#ifndef ODBC_H
#define ODBC_H "$Id: ODBC.H,v 2.0 2026/11/01 C++23 RAII & Failover Edition $"

#include <ostream>
#include <windows.h>
#include <sql.h>
#include <sqlext.h>

#pragma push_macro("min")
#pragma push_macro("max")
#undef min
#undef max
#include <array>
#include <atomic>
#include <chrono>
#include <concepts>
#include <cstdint>
#include <expected>
#include <memory>
#include <mutex>
#include <optional>
#include <shared_mutex>
#include <span>
#include <string>
#include <string_view>
#include <type_traits>
#include <utility>
#include <vector>
#pragma pop_macro("max")
#pragma pop_macro("min")

#include "Serializer/SerBuffer.h"
#include <ToString.h>
#include <atltime.h>    // CTime (legacy compatibility)
#include "KncException.h"
#include "KncSmartPtr.h"
#include "SecurityString.h"

namespace knc::db
{
    //==========================================================================
    // 1. C++23 RAII Smart Handle Deleters for ODBC Resources
    //==========================================================================
    struct SqlEnvDeleter
    {
        void operator()( SQLHENV hEnv ) const noexcept
        {
            if( hEnv != SQL_NULL_HENV )
            {
                ::SQLFreeHandle( SQL_HANDLE_ENV, hEnv );
            }
        }
    };

    struct SqlDbcDeleter
    {
        void operator()( SQLHDBC hDbc ) const noexcept
        {
            if( hDbc != SQL_NULL_HDBC )
            {
                ::SQLDisconnect( hDbc );
                ::SQLFreeHandle( SQL_HANDLE_DBC, hDbc );
            }
        }
    };

    struct SqlStmtDeleter
    {
        void operator()( SQLHSTMT hStmt ) const noexcept
        {
            if( hStmt != SQL_NULL_HSTMT )
            {
                ::SQLCloseCursor( hStmt );
                ::SQLFreeHandle( SQL_HANDLE_STMT, hStmt );
            }
        }
    };

    using UniqueSqlEnv  = std::unique_ptr< void, SqlEnvDeleter >;
    using UniqueSqlDbc  = std::unique_ptr< void, SqlDbcDeleter >;
    using UniqueSqlStmt = std::unique_ptr< void, SqlStmtDeleter >;

    // RAII Guard that automatically unbinds parameters and closes cursors on scope exit
    class SqlStmtResetGuard
    {
    public:
        explicit SqlStmtResetGuard( SQLHSTMT hStmt, bool closeCursor = false ) noexcept
            : m_hStmt( hStmt )
            , m_bCloseCursor( closeCursor )
        {
        }

        ~SqlStmtResetGuard() noexcept
        {
            if( m_hStmt != SQL_NULL_HSTMT )
            {
                ::SQLFreeStmt( m_hStmt, SQL_RESET_PARAMS );
                ::SQLFreeStmt( m_hStmt, SQL_UNBIND );
                if( m_bCloseCursor )
                {
                    ::SQLCloseCursor( m_hStmt );
                }
            }
        }

        SqlStmtResetGuard( const SqlStmtResetGuard& ) = delete;
        SqlStmtResetGuard& operator=( const SqlStmtResetGuard& ) = delete;

    private:
        SQLHSTMT m_hStmt;
        bool     m_bCloseCursor;
    };

    //==========================================================================
    // 2. C++23 Structured Database Error & Diagnostic State (`std::expected`)
    //==========================================================================
    enum class DbErrorCategory : uint8_t
    {
        None = 0,
        InvalidArgument,
        HandleAllocationFailed,
        ConnectionFailed,
        NetworkDropout,             // SQLSTATE 08001, 08003, 08007, 08S01, 08S02
        QueryTimeout,               // SQLSTATE HYT00, HYT01
        HardwareOrResourceFailure,  // SQLSTATE 40001, 40002, or fatal I/O errors (823, 824, 825)
        ParameterBindingFailed,
        QueryExecutionFailed,
        FetchFailed,
        DecryptionFailed,
        AllEndpointsExhausted
    };

    struct DbError
    {
        DbErrorCategory category    = DbErrorCategory::None;
        std::wstring    sqlState    = L"00000";
        SQLINTEGER      nativeError = 0;
        std::wstring    message;

        [[nodiscard]] bool IsFailoverTrigger() const noexcept
        {
            if( category == DbErrorCategory::NetworkDropout ||
                category == DbErrorCategory::QueryTimeout ||
                category == DbErrorCategory::HardwareOrResourceFailure ||
                category == DbErrorCategory::ConnectionFailed )
            {
                return true;
            }

            if( sqlState.starts_with( L"08" ) ||
                sqlState == L"HYT00" ||
                sqlState == L"HYT01" ||
                sqlState == L"40001" ||
                sqlState == L"40002" )
            {
                return true;
            }

            // MSSQL fatal I/O or transport-level native errors
            switch( nativeError )
            {
            case 823:   // OS I/O error
            case 824:   // Logical consistency I/O error
            case 825:   // Read-retry I/O warning
            case 10053: // WSAECONNABORTED
            case 10054: // WSAECONNRESET
            case 10060: // WSAETIMEDOUT
            case 10061: // WSAECONNREFUSED
                return true;
            default:
                return false;
            }
        }
    };

    //==========================================================================
    // 3. Remote Linux VPS MSSQL Connection Tuning Options
    //==========================================================================
    struct LinuxVpsConnectionOptions
    {
        uint32_t loginTimeoutSeconds        = 10;    // SQL_ATTR_LOGIN_TIMEOUT
        uint32_t connectionTimeoutSeconds   = 15;    // SQL_ATTR_CONNECTION_TIMEOUT
        uint32_t queryTimeoutSeconds        = 30;    // SQL_ATTR_QUERY_TIMEOUT
        uint32_t tcpKeepAliveMs             = 30000; // KeepAlive (ms) for Linux VPS NAT/firewalls
        uint32_t tcpKeepAliveIntervalMs     = 1000;  // KeepAliveInterval (ms)
        uint32_t networkPacketSizeBytes     = 4096;  // SQL_ATTR_PACKET_SIZE
        bool     enableTlsEncryption        = true;  // Encrypt=yes
        bool     trustServerCertificate     = true;  // TrustServerCertificate=yes (Linux VPS self-signed TLS)
        bool     multiSubnetFailover        = true;  // MultiSubnetFailover=Yes
    };

    //==========================================================================
    // 4. Explicit Application-Level Failover State Machine
    //==========================================================================
    enum class FailoverState : uint8_t
    {
        Disconnected = 0,
        PrimaryActive,      // Connected to primary remote Linux VPS MSSQL
        FailingOver,        // Transitioning after primary dropout/timeout/hardware error
        FallbackActive      // Connected to secondary fallback MSSQL endpoint
    };

    [[nodiscard]] constexpr std::wstring_view ToWStringView( FailoverState state ) noexcept
    {
        switch( state )
        {
        case FailoverState::Disconnected:   return L"Disconnected";
        case FailoverState::PrimaryActive:  return L"PrimaryActive";
        case FailoverState::FailingOver:    return L"FailingOver";
        case FailoverState::FallbackActive: return L"FallbackActive";
        default:                            return L"Unknown";
        }
    }

    // Extracts diagnostic state from any ODBC handle into a structured C++23 DbError
    [[nodiscard]] DbError ExtractOdbcDiagnostics(
        SQLSMALLINT handleType,
        SQLHANDLE handle,
        DbErrorCategory defaultCategory = DbErrorCategory::QueryExecutionFailed ) noexcept;

    // Normalizes a connection string for remote Linux VPS MSSQL over Microsoft ODBC Driver
    [[nodiscard]] std::wstring BuildLinuxVpsConnectionString(
        std::wstring_view baseConnStr,
        const LinuxVpsConnectionOptions& options = {} );

    // Allocates an RAII SQLHENV configured for ODBC 3.80 / 3.0
    [[nodiscard]] std::expected< UniqueSqlEnv, DbError > CreateEnvironmentHandle() noexcept;

    // Allocates and connects an RAII SQLHDBC with Linux VPS timeouts and TLS settings
    [[nodiscard]] std::expected< UniqueSqlDbc, DbError > ConnectDatabaseHandle(
        SQLHENV hEnv,
        std::wstring_view connStr,
        const LinuxVpsConnectionOptions& options = {} );

    // Allocates an RAII SQLHSTMT with configured query timeout
    [[nodiscard]] std::expected< UniqueSqlStmt, DbError > CreateStatementHandle(
        SQLHDBC hDbc,
        uint32_t queryTimeoutSeconds = 30 ) noexcept;

    //==========================================================================
    // 5. Type-Safe Parameterized Query Binding (`SQLBindParameter`)
    //==========================================================================
    namespace detail
    {
        struct BoundParamStorage
        {
            SQLLEN indicator = 0;
        };

        [[nodiscard]] inline SQLRETURN BindOneParameter(
            SQLHSTMT hStmt,
            SQLUSMALLINT paramIndex,
            const bool& val,
            SQLLEN& indicator ) noexcept
        {
            indicator = sizeof( bool );
            return ::SQLBindParameter(
                hStmt, paramIndex, SQL_PARAM_INPUT,
                SQL_C_BIT, SQL_BIT, 1, 0,
                const_cast< bool* >( &val ), sizeof( bool ), &indicator );
        }

        template< std::signed_integral T >
            requires ( sizeof( T ) <= sizeof( int32_t ) && !std::same_as< T, bool > )
        [[nodiscard]] inline SQLRETURN BindOneParameter(
            SQLHSTMT hStmt,
            SQLUSMALLINT paramIndex,
            const T& val,
            SQLLEN& indicator ) noexcept
        {
            indicator = sizeof( T );
            constexpr SQLSMALLINT cType   = ( sizeof( T ) == 1 ) ? SQL_C_STINYINT :
                                            ( sizeof( T ) == 2 ) ? SQL_C_SSHORT   : SQL_C_SLONG;
            constexpr SQLSMALLINT sqlType = ( sizeof( T ) == 1 ) ? SQL_TINYINT    :
                                            ( sizeof( T ) == 2 ) ? SQL_SMALLINT   : SQL_INTEGER;
            return ::SQLBindParameter(
                hStmt, paramIndex, SQL_PARAM_INPUT,
                cType, sqlType, 0, 0,
                const_cast< T* >( &val ), sizeof( T ), &indicator );
        }

        template< std::unsigned_integral T >
            requires ( sizeof( T ) <= sizeof( uint32_t ) && !std::same_as< T, bool > )
        [[nodiscard]] inline SQLRETURN BindOneParameter(
            SQLHSTMT hStmt,
            SQLUSMALLINT paramIndex,
            const T& val,
            SQLLEN& indicator ) noexcept
        {
            indicator = sizeof( T );
            constexpr SQLSMALLINT cType   = ( sizeof( T ) == 1 ) ? SQL_C_UTINYINT :
                                            ( sizeof( T ) == 2 ) ? SQL_C_USHORT   : SQL_C_ULONG;
            constexpr SQLSMALLINT sqlType = ( sizeof( T ) == 1 ) ? SQL_TINYINT    :
                                            ( sizeof( T ) == 2 ) ? SQL_SMALLINT   : SQL_INTEGER;
            return ::SQLBindParameter(
                hStmt, paramIndex, SQL_PARAM_INPUT,
                cType, sqlType, 0, 0,
                const_cast< T* >( &val ), sizeof( T ), &indicator );
        }

        template< std::integral T >
            requires ( sizeof( T ) == sizeof( int64_t ) )
        [[nodiscard]] inline SQLRETURN BindOneParameter(
            SQLHSTMT hStmt,
            SQLUSMALLINT paramIndex,
            const T& val,
            SQLLEN& indicator ) noexcept
        {
            indicator = sizeof( T );
            constexpr SQLSMALLINT cType = std::is_signed_v< T > ? SQL_C_SBIGINT : SQL_C_UBIGINT;
            return ::SQLBindParameter(
                hStmt, paramIndex, SQL_PARAM_INPUT,
                cType, SQL_BIGINT, 0, 0,
                const_cast< T* >( &val ), sizeof( T ), &indicator );
        }

        [[nodiscard]] inline SQLRETURN BindOneParameter(
            SQLHSTMT hStmt,
            SQLUSMALLINT paramIndex,
            const float& val,
            SQLLEN& indicator ) noexcept
        {
            indicator = sizeof( float );
            return ::SQLBindParameter(
                hStmt, paramIndex, SQL_PARAM_INPUT,
                SQL_C_FLOAT, SQL_REAL, 0, 0,
                const_cast< float* >( &val ), sizeof( float ), &indicator );
        }

        [[nodiscard]] inline SQLRETURN BindOneParameter(
            SQLHSTMT hStmt,
            SQLUSMALLINT paramIndex,
            const double& val,
            SQLLEN& indicator ) noexcept
        {
            indicator = sizeof( double );
            return ::SQLBindParameter(
                hStmt, paramIndex, SQL_PARAM_INPUT,
                SQL_C_DOUBLE, SQL_DOUBLE, 0, 0,
                const_cast< double* >( &val ), sizeof( double ), &indicator );
        }

        [[nodiscard]] inline SQLRETURN BindOneParameter(
            SQLHSTMT hStmt,
            SQLUSMALLINT paramIndex,
            std::wstring_view val,
            SQLLEN& indicator ) noexcept
        {
            indicator = static_cast< SQLLEN >( val.size() * sizeof( wchar_t ) );
            const SQLULEN columnSize = val.empty() ? 1 : static_cast< SQLULEN >( val.size() );
            return ::SQLBindParameter(
                hStmt, paramIndex, SQL_PARAM_INPUT,
                SQL_C_WCHAR, SQL_WVARCHAR, columnSize, 0,
                const_cast< wchar_t* >( val.data() ), indicator, &indicator );
        }

        [[nodiscard]] inline SQLRETURN BindOneParameter(
            SQLHSTMT hStmt,
            SQLUSMALLINT paramIndex,
            const std::wstring& val,
            SQLLEN& indicator ) noexcept
        {
            return BindOneParameter( hStmt, paramIndex, std::wstring_view{ val }, indicator );
        }

        [[nodiscard]] inline SQLRETURN BindOneParameter(
            SQLHSTMT hStmt,
            SQLUSMALLINT paramIndex,
            const wchar_t* val,
            SQLLEN& indicator ) noexcept
        {
            return BindOneParameter(
                hStmt, paramIndex,
                val ? std::wstring_view{ val } : std::wstring_view{},
                indicator );
        }

        [[nodiscard]] inline SQLRETURN BindOneParameter(
            SQLHSTMT hStmt,
            SQLUSMALLINT paramIndex,
            std::string_view val,
            SQLLEN& indicator ) noexcept
        {
            indicator = static_cast< SQLLEN >( val.size() );
            const SQLULEN columnSize = val.empty() ? 1 : static_cast< SQLULEN >( val.size() );
            return ::SQLBindParameter(
                hStmt, paramIndex, SQL_PARAM_INPUT,
                SQL_C_CHAR, SQL_VARCHAR, columnSize, 0,
                const_cast< char* >( val.data() ), indicator, &indicator );
        }

        [[nodiscard]] inline SQLRETURN BindOneParameter(
            SQLHSTMT hStmt,
            SQLUSMALLINT paramIndex,
            const std::string& val,
            SQLLEN& indicator ) noexcept
        {
            return BindOneParameter( hStmt, paramIndex, std::string_view{ val }, indicator );
        }

        [[nodiscard]] inline SQLRETURN BindOneParameter(
            SQLHSTMT hStmt,
            SQLUSMALLINT paramIndex,
            std::span< const uint8_t > val,
            SQLLEN& indicator ) noexcept
        {
            indicator = static_cast< SQLLEN >( val.size_bytes() );
            const SQLULEN columnSize = val.empty() ? 1 : static_cast< SQLULEN >( val.size_bytes() );
            return ::SQLBindParameter(
                hStmt, paramIndex, SQL_PARAM_INPUT,
                SQL_C_BINARY, SQL_VARBINARY, columnSize, 0,
                const_cast< uint8_t* >( val.data() ), indicator, &indicator );
        }
    } // namespace detail
} // namespace knc::db

SmartPointer( KODBC );

class KODBC
{
public:

#   define SQLOK(result) (result == SQL_SUCCESS || result == SQL_SUCCESS_WITH_INFO)
#   define SQLNODATA(result) (result == SQL_NO_DATA)
#   define THROW_INVALID_QUERY() { throw std::exception("DB Query Exception"); }
#   define FETCH_DATA( varlist ) \
            { \
                try \
                { \
                    m_kODBC >> varlist;\
                } \
                catch( std::exception& ex) \
                { \
                dbg::cout << LOG_HEADER_STR << KncUtil::toWideString( ex.what() ) << END_LOG; \
                } \
                catch( ... ) \
                { \
                dbg::cout << LOG_HEADER_STR << L"Unknown Exception Occured." << END_LOG; \
                } \
            }

#   define FETCH_DATA_PTR( pODBC, varlist ) \
	{ \
		try \
		{ \
			(*pODBC) >> varlist;\
		} \
		catch( std::exception& ex) \
		{ \
			dbg::cout << LOG_HEADER_STR << KncUtil::toWideString( ex.what() ) << END_LOG; \
		} \
		catch( ... ) \
		{ \
			dbg::cout << LOG_HEADER_STR << L"Unknown Exception Occured." << END_LOG; \
		} \
	}

	enum ODBC_INFO
	{
		QUERY_BUFFER_SIZE = 4096,
	};

    DeclToStringW;
    DeclDump;

    KODBC();
    virtual ~KODBC();

    // Non-copyable, movable
    KODBC( const KODBC& ) = delete;
    KODBC& operator=( const KODBC& ) = delete;

	bool DriverConnect( const wchar_t* szConnStr, bool bDBConnStr );
    bool DriverConnectFileDSN( const wchar_t* szDsn );
	bool DriverConnectString( const KClearString< std::wstring >& kDBConnStr );
    bool ReConnect();
    void Close();

    //==========================================================================
    // Modern C++23 Dual-Endpoint & Parameterized Query API
    //==========================================================================
    void ConfigureLinuxVpsOptions( const knc::db::LinuxVpsConnectionOptions& options ) noexcept;
    void SetFailoverEndpoints( std::wstring_view primaryConnStr, std::wstring_view fallbackConnStr );

    [[nodiscard]] std::expected< void, knc::db::DbError > ConnectWithFailover();
    [[nodiscard]] std::expected< void, knc::db::DbError > TriggerFailover( const knc::db::DbError& triggerReason );
    [[nodiscard]] knc::db::FailoverState GetFailoverState() const noexcept { return m_failoverState.load( std::memory_order_acquire ); }

    template< typename... Args >
    [[nodiscard]] std::expected< void, knc::db::DbError > ExecutePrepared(
        std::wstring_view parameterizedSql,
        const Args&... args )
    {
        if( m_upStmt == nullptr )
        {
            auto connRes = ConnectWithFailover();
            if( !connRes )
            {
                return std::unexpected( connRes.error() );
            }
        }

        auto tryExec = [&]( SQLHSTMT hStmt ) -> std::expected< void, knc::db::DbError >
        {
            ::SQLFreeStmt( hStmt, SQL_RESET_PARAMS );
            ::SQLCloseCursor( hStmt );

            SQLRETURN ret = ::SQLPrepareW(
                hStmt,
                const_cast< SQLWCHAR* >( parameterizedSql.data() ),
                static_cast< SQLINTEGER >( parameterizedSql.size() ) );
            if( !SQLOK( ret ) )
            {
                return std::unexpected( knc::db::ExtractOdbcDiagnostics( SQL_HANDLE_STMT, hStmt ) );
            }

            if constexpr ( sizeof...( Args ) > 0 )
            {
                std::array< SQLLEN, sizeof...( Args ) > indicators{};
                SQLUSMALLINT idx = 1;
                SQLRETURN bindRet = SQL_SUCCESS;

                auto bindEach = [&]( const auto& arg, SQLLEN& ind )
                {
                    if( SQLOK( bindRet ) )
                    {
                        bindRet = knc::db::detail::BindOneParameter( hStmt, idx++, arg, ind );
                    }
                };

                size_t i = 0;
                ( bindEach( args, indicators[i++] ), ... );

                if( !SQLOK( bindRet ) )
                {
                    return std::unexpected( knc::db::ExtractOdbcDiagnostics(
                        SQL_HANDLE_STMT, hStmt, knc::db::DbErrorCategory::ParameterBindingFailed ) );
                }
            }

            ret = ::SQLExecute( hStmt );
            if( !SQLOK( ret ) && ret != SQL_NO_DATA )
            {
                return std::unexpected( knc::db::ExtractOdbcDiagnostics( SQL_HANDLE_STMT, hStmt ) );
            }

            return {};
        };

        m_strLastQuery.assign( parameterizedSql );
        auto result = tryExec( m_upStmt.get() );
        if( !result && result.error().IsFailoverTrigger() )
        {
            if( auto failoverRes = TriggerFailover( result.error() ); failoverRes.has_value() )
            {
                result = tryExec( m_upStmt.get() );
            }
        }

        return result;
    }

	bool Query( const std::wstring& wstrQuery );
	const std::wstring& GetLastQuery() const { return m_strLastQuery; }
    
    bool BeginFetch();
    bool Fetch();
    void EndFetch();
    
    KODBC& operator >>(bool& val);
    KODBC& operator >>(char& val);
	KODBC& operator >>(wchar_t& val);
    KODBC& operator >>(short& val);
    KODBC& operator >>(int& val);
	KODBC& operator >>(UINT& val);
    KODBC& operator >>(UCHAR& val);
    KODBC& operator >>(USHORT& val);
    KODBC& operator >>(DWORD& val);
    KODBC& operator >>(char* val);
    KODBC& operator >>(std::string& val);
    KODBC& operator >>(float& val);
    KODBC& operator >>(KSerBuffer& val);
    KODBC& operator >>(time_t& val);            // 040728
    KODBC& operator >>(wchar_t* val);           // 051229
    KODBC& operator >>(std::wstring& val);      // 051229
    KODBC& operator >>(ULONGLONG& val);         // 061009
    KODBC& operator >>(LONGLONG& val);          // 061009

    CRITICAL_SECTION& GetCS() { return m_cs; }

    static void DumpMaxTime( std::wostream& stm );
    static void ResetMaxTime();

public:
    enum {
        BLOB_DATA_PARAM_MARKER,     // 040622. Parameter marker ID for binary blob transfers
    };

    // Modern C++23 RAII Smart Handles owning the underlying ODBC resources
    knc::db::UniqueSqlEnv   m_upEnv;
    knc::db::UniqueSqlDbc   m_upDbc;
    knc::db::UniqueSqlStmt  m_upStmt;

    // Legacy handle mirrors synchronized with RAII smart pointers for diagnostics
    SQLHENV             m_hEnv;
    SQLHDBC             m_hDbc;
    SQLHSTMT            m_hStmt;

    USHORT              m_usColumNum;
    CRITICAL_SECTION    m_cs;

public:
    // diagnostic message
    SQLWCHAR            m_szDiagMsg[SQL_MAX_MESSAGE_LENGTH];
    SQLSMALLINT         m_sqlMsgLen;
    SQLWCHAR            m_sqlState[6];
    SQLINTEGER          m_sqlNativeErr;

	// DB Connection Info
	bool				m_bDBConnStr;
    std::wstring        m_strDSN;
    std::wstring        m_strAbsolutePathDSN;
	std::wstring		m_strDBConnStr;
	KSecurityString< std::wstring >	m_SecurityDBConnStr;
	KSecurityString< std::wstring >	m_SecurityFallbackConnStr;

    knc::db::LinuxVpsConnectionOptions      m_linuxVpsOptions;
    std::atomic< knc::db::FailoverState >   m_failoverState{ knc::db::FailoverState::Disconnected };

    std::wstring        m_strLastQuery; // Retains last executed SQL query for diagnostics

    static struct KMaxProcessingInfo {
        KncCriticalSection  m_cs;
        std::wstring        m_strQuery;
        DWORD               m_dwTerm;       // Maximum elapsed processing duration (ms)
        CTime               m_cTime;
    } ms_kMaxProcessingInfo;

    static bool IsInvalidMarkIn( IN const std::wstring& strData );
	static bool IsInvalidMarkInForLetter( IN const std::wstring& strData );
	static bool IsInvalidMarkInForCheat( IN const std::wstring& strData );
	static bool IsInvalidMarkInForMachineID( IN const std::wstring& strData );
    static void RemoveInvalidMark( IN OUT std::wstring& strData );

private:
    void SyncLegacyHandles() noexcept
    {
        m_hEnv  = m_upEnv.get();
        m_hDbc  = m_upDbc.get();
        m_hStmt = m_upStmt.get();
    }
};


class KDBQuerySuccessChecker
{
public:
	KDBQuerySuccessChecker();
	~KDBQuerySuccessChecker();

	void Clear();
	void AddSuccessQuery( IN const std::wstring& wstrQuery );
	void AddFailedQuery( IN const std::wstring& wstrQuery );
	bool IsAllQuerySuccess() const;
	void PrintLogSuccessQuery() const;
	void PrintLogFailedQuery() const;

private:
	std::vector< std::wstring >	m_vecSuccessQuery;
	std::vector< std::wstring > m_vecFailedQuery;
};

#endif
