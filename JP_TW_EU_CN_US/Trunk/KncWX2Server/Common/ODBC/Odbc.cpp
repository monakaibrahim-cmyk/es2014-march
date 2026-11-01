#pragma warning( disable : 4146 )
//{{ florist
#ifdef _STDAFX
#include "stdafx.h"
#endif
//}} florist

#include "ODBC.h"
#include "dbg/dbg.hpp"
#include <Thread/Locker.h>
#include <KncUtil.h>
#include <boost/algorithm/string/replace.hpp>
#include <ctime>
#include <cwctype>

// SQL Server specific connection attributes (msodbcsql / sqlncli)
#ifndef SQL_COPT_SS_KEEPALIVE
#define SQL_COPT_SS_KEEPALIVE           1241
#endif
#ifndef SQL_COPT_SS_KEEPALIVE_INTERVAL
#define SQL_COPT_SS_KEEPALIVE_INTERVAL  1242
#endif

namespace knc::db
{
    namespace
    {
        [[nodiscard]] bool ContainsCaseInsensitive( std::wstring_view haystack, std::wstring_view needle ) noexcept
        {
            if( needle.empty() || haystack.size() < needle.size() )
            {
                return false;
            }

            for( size_t i = 0; i <= haystack.size() - needle.size(); ++i )
            {
                bool match = true;
                for( size_t j = 0; j < needle.size(); ++j )
                {
                    if( std::towlower( haystack[i + j] ) != std::towlower( needle[j] ) )
                    {
                        match = false;
                        break;
                    }
                }
                if( match )
                {
                    return true;
                }
            }
            return false;
        }
    } // anonymous namespace

    DbError ExtractOdbcDiagnostics(
        SQLSMALLINT handleType,
        SQLHANDLE handle,
        DbErrorCategory defaultCategory ) noexcept
    {
        DbError err;
        err.category = defaultCategory;

        if( handle == SQL_NULL_HANDLE )
        {
            err.message = L"ODBC handle is SQL_NULL_HANDLE.";
            return err;
        }

        SQLWCHAR sqlState[6] = { 0 };
        SQLINTEGER nativeErr = 0;
        SQLWCHAR msgBuf[SQL_MAX_MESSAGE_LENGTH] = { 0 };
        SQLSMALLINT msgLen = 0;

        const SQLRETURN diagRet = ::SQLGetDiagRecW(
            handleType,
            handle,
            1,
            sqlState,
            &nativeErr,
            msgBuf,
            static_cast< SQLSMALLINT >( std::size( msgBuf ) ),
            &msgLen );

        if( SQLOK( diagRet ) )
        {
            err.sqlState.assign( sqlState, 5 );
            err.nativeError = nativeErr;
            if( msgLen > 0 )
            {
                err.message.assign( msgBuf, static_cast< size_t >( msgLen ) );
            }

            if( err.sqlState.starts_with( L"08" ) )
            {
                err.category = DbErrorCategory::NetworkDropout;
            }
            else if( err.sqlState == L"HYT00" || err.sqlState == L"HYT01" )
            {
                err.category = DbErrorCategory::QueryTimeout;
            }
            else if( err.sqlState == L"40001" || err.sqlState == L"40002" ||
                     nativeErr == 823 || nativeErr == 824 || nativeErr == 825 ||
                     nativeErr == 10053 || nativeErr == 10054 || nativeErr == 10060 )
            {
                err.category = DbErrorCategory::HardwareOrResourceFailure;
            }
        }
        else
        {
            err.message = L"Unable to retrieve ODBC diagnostic record.";
        }

        return err;
    }

    std::wstring BuildLinuxVpsConnectionString(
        std::wstring_view baseConnStr,
        const LinuxVpsConnectionOptions& options )
    {
        std::wstring result( baseConnStr );
        if( result.empty() )
        {
            return result;
        }

        // If this is a FILEDSN connection string, preserve the FILEDSN prefix and append tuning attributes
        if( !result.ends_with( L';' ) )
        {
            result.push_back( L';' );
        }

        if( !ContainsCaseInsensitive( result, L"FILEDSN=" ) )
        {
            if( !ContainsCaseInsensitive( result, L"Encrypt=" ) )
            {
                result += options.enableTlsEncryption ? L"Encrypt=yes;" : L"Encrypt=no;";
            }
            if( !ContainsCaseInsensitive( result, L"TrustServerCertificate=" ) )
            {
                result += options.trustServerCertificate ? L"TrustServerCertificate=yes;" : L"TrustServerCertificate=no;";
            }
        }

        return result;
    }

    std::expected< UniqueSqlEnv, DbError > CreateEnvironmentHandle() noexcept
    {
        SQLHENV rawEnv = SQL_NULL_HENV;
        SQLRETURN ret = ::SQLAllocHandle( SQL_HANDLE_ENV, SQL_NULL_HANDLE, &rawEnv );
        if( !SQLOK( ret ) || rawEnv == SQL_NULL_HENV )
        {
            return std::unexpected( DbError{
                DbErrorCategory::HandleAllocationFailed,
                L"HY001",
                0,
                L"SQLAllocHandle(SQL_HANDLE_ENV) failed."
            } );
        }

        UniqueSqlEnv upEnv( rawEnv );

        // Prefer ODBC 3.80 for modern Windows -> Linux MSSQL driver features, fallback to ODBC 3.0
        ret = ::SQLSetEnvAttr(
            upEnv.get(),
            SQL_ATTR_ODBC_VERSION,
            reinterpret_cast< SQLPOINTER >( SQL_OV_ODBC3_80 ),
            SQL_IS_INTEGER );
        if( !SQLOK( ret ) )
        {
            ret = ::SQLSetEnvAttr(
                upEnv.get(),
                SQL_ATTR_ODBC_VERSION,
                reinterpret_cast< SQLPOINTER >( SQL_OV_ODBC3 ),
                SQL_IS_INTEGER );
            if( !SQLOK( ret ) )
            {
                return std::unexpected( ExtractOdbcDiagnostics(
                    SQL_HANDLE_ENV, upEnv.get(), DbErrorCategory::HandleAllocationFailed ) );
            }
        }

        return upEnv;
    }

    std::expected< UniqueSqlDbc, DbError > ConnectDatabaseHandle(
        SQLHENV hEnv,
        std::wstring_view connStr,
        const LinuxVpsConnectionOptions& options )
    {
        if( hEnv == SQL_NULL_HENV )
        {
            return std::unexpected( DbError{
                DbErrorCategory::InvalidArgument,
                L"HY009",
                0,
                L"ConnectDatabaseHandle called with SQL_NULL_HENV."
            } );
        }

        SQLHDBC rawDbc = SQL_NULL_HDBC;
        SQLRETURN ret = ::SQLAllocHandle( SQL_HANDLE_DBC, hEnv, &rawDbc );
        if( !SQLOK( ret ) || rawDbc == SQL_NULL_HDBC )
        {
            return std::unexpected( ExtractOdbcDiagnostics(
                SQL_HANDLE_ENV, hEnv, DbErrorCategory::HandleAllocationFailed ) );
        }

        UniqueSqlDbc upDbc( rawDbc );

        // Configure pre-connect attributes optimized for high-latency remote Linux VPS MSSQL links
        ::SQLSetConnectAttrW(
            upDbc.get(),
            SQL_ATTR_LOGIN_TIMEOUT,
            reinterpret_cast< SQLPOINTER >( static_cast< uintptr_t >( options.loginTimeoutSeconds ) ),
            SQL_IS_UINTEGER );

        ::SQLSetConnectAttrW(
            upDbc.get(),
            SQL_ATTR_CONNECTION_TIMEOUT,
            reinterpret_cast< SQLPOINTER >( static_cast< uintptr_t >( options.connectionTimeoutSeconds ) ),
            SQL_IS_UINTEGER );

        if( options.networkPacketSizeBytes >= 512 )
        {
            ::SQLSetConnectAttrW(
                upDbc.get(),
                SQL_ATTR_PACKET_SIZE,
                reinterpret_cast< SQLPOINTER >( static_cast< uintptr_t >( options.networkPacketSizeBytes ) ),
                SQL_IS_UINTEGER );
        }

        // TCP Keep-Alive settings for Linux VPS firewall/NAT traversal
        ::SQLSetConnectAttrW(
            upDbc.get(),
            SQL_COPT_SS_KEEPALIVE,
            reinterpret_cast< SQLPOINTER >( static_cast< uintptr_t >( options.tcpKeepAliveMs ) ),
            SQL_IS_UINTEGER );

        ::SQLSetConnectAttrW(
            upDbc.get(),
            SQL_COPT_SS_KEEPALIVE_INTERVAL,
            reinterpret_cast< SQLPOINTER >( static_cast< uintptr_t >( options.tcpKeepAliveIntervalMs ) ),
            SQL_IS_UINTEGER );

        const std::wstring normalizedConn = BuildLinuxVpsConnectionString( connStr, options );
        std::vector< SQLWCHAR > outConnBuf( 2048, 0 );
        SQLSMALLINT outConnLen = 0;

        ret = ::SQLDriverConnectW(
            upDbc.get(),
            nullptr,
            const_cast< SQLWCHAR* >( normalizedConn.c_str() ),
            static_cast< SQLSMALLINT >( normalizedConn.size() ),
            outConnBuf.data(),
            static_cast< SQLSMALLINT >( outConnBuf.size() ),
            &outConnLen,
            SQL_DRIVER_NOPROMPT );

        if( !SQLOK( ret ) )
        {
            // Retry with raw connection string if legacy ODBC driver rejected modern TLS attributes
            ret = ::SQLDriverConnectW(
                upDbc.get(),
                nullptr,
                const_cast< SQLWCHAR* >( connStr.data() ),
                static_cast< SQLSMALLINT >( connStr.size() ),
                outConnBuf.data(),
                static_cast< SQLSMALLINT >( outConnBuf.size() ),
                &outConnLen,
                SQL_DRIVER_NOPROMPT );

            if( !SQLOK( ret ) )
            {
                return std::unexpected( ExtractOdbcDiagnostics(
                    SQL_HANDLE_DBC, upDbc.get(), DbErrorCategory::ConnectionFailed ) );
            }
        }

        return upDbc;
    }

    std::expected< UniqueSqlStmt, DbError > CreateStatementHandle(
        SQLHDBC hDbc,
        uint32_t queryTimeoutSeconds ) noexcept
    {
        if( hDbc == SQL_NULL_HDBC )
        {
            return std::unexpected( DbError{
                DbErrorCategory::InvalidArgument,
                L"08003",
                0,
                L"CreateStatementHandle called with SQL_NULL_HDBC."
            } );
        }

        SQLHSTMT rawStmt = SQL_NULL_HSTMT;
        const SQLRETURN ret = ::SQLAllocHandle( SQL_HANDLE_STMT, hDbc, &rawStmt );
        if( !SQLOK( ret ) || rawStmt == SQL_NULL_HSTMT )
        {
            return std::unexpected( ExtractOdbcDiagnostics(
                SQL_HANDLE_DBC, hDbc, DbErrorCategory::HandleAllocationFailed ) );
        }

        UniqueSqlStmt upStmt( rawStmt );

        if( queryTimeoutSeconds > 0 )
        {
            ::SQLSetStmtAttrW(
                upStmt.get(),
                SQL_ATTR_QUERY_TIMEOUT,
                reinterpret_cast< SQLPOINTER >( static_cast< uintptr_t >( queryTimeoutSeconds ) ),
                SQL_IS_UINTEGER );
        }

        return upStmt;
    }
} // namespace knc::db

KODBC::KMaxProcessingInfo KODBC::ms_kMaxProcessingInfo = {
    KncCriticalSection(), L"Initial State", 0, CTime::GetCurrentTime()
};

KODBC::KODBC()
    : m_upEnv( nullptr )
    , m_upDbc( nullptr )
    , m_upStmt( nullptr )
    , m_hEnv( SQL_NULL_HENV )
    , m_hDbc( SQL_NULL_HDBC )
    , m_hStmt( SQL_NULL_HSTMT )
    , m_usColumNum( 0 )
    , m_sqlMsgLen( 0 )
    , m_sqlNativeErr( 0 )
    , m_bDBConnStr( false )
{
    std::memset( m_szDiagMsg, 0, sizeof( m_szDiagMsg ) );
    std::memset( m_sqlState, 0, sizeof( m_sqlState ) );
    ::InitializeCriticalSection( &m_cs );
}

KODBC::~KODBC()
{
    Close();
    ::DeleteCriticalSection( &m_cs );
}

void KODBC::ConfigureLinuxVpsOptions( const knc::db::LinuxVpsConnectionOptions& options ) noexcept
{
    m_linuxVpsOptions = options;
}

void KODBC::SetFailoverEndpoints( std::wstring_view primaryConnStr, std::wstring_view fallbackConnStr )
{
    m_bDBConnStr = true;
    m_SecurityDBConnStr.Init( std::wstring( primaryConnStr ) );
    if( !fallbackConnStr.empty() )
    {
        m_SecurityFallbackConnStr.Init( std::wstring( fallbackConnStr ) );
    }
}

std::expected< void, knc::db::DbError > KODBC::ConnectWithFailover()
{
    Close();

    auto envRes = knc::db::CreateEnvironmentHandle();
    if( !envRes )
    {
        return std::unexpected( envRes.error() );
    }
    m_upEnv = std::move( *envRes );

    const std::wstring primaryConn = m_bDBConnStr
        ? m_SecurityDBConnStr.GetClearString().GetString()
        : m_strDSN;

    if( !primaryConn.empty() )
    {
        auto dbcRes = knc::db::ConnectDatabaseHandle( m_upEnv.get(), primaryConn, m_linuxVpsOptions );
        if( dbcRes )
        {
            auto stmtRes = knc::db::CreateStatementHandle( dbcRes->get(), m_linuxVpsOptions.queryTimeoutSeconds );
            if( stmtRes )
            {
                m_upDbc  = std::move( *dbcRes );
                m_upStmt = std::move( *stmtRes );
                SyncLegacyHandles();
                m_failoverState.store( knc::db::FailoverState::PrimaryActive, std::memory_order_release );
                return {};
            }
        }
    }

    // Primary endpoint failed -> attempt explicit failover to secondary endpoint if configured
    if( !m_SecurityFallbackConnStr.IsEmpty() )
    {
        m_failoverState.store( knc::db::FailoverState::FailingOver, std::memory_order_release );
        const std::wstring fallbackConn = m_SecurityFallbackConnStr.GetClearString().GetString();

        auto fbDbcRes = knc::db::ConnectDatabaseHandle( m_upEnv.get(), fallbackConn, m_linuxVpsOptions );
        if( fbDbcRes )
        {
            auto fbStmtRes = knc::db::CreateStatementHandle( fbDbcRes->get(), m_linuxVpsOptions.queryTimeoutSeconds );
            if( fbStmtRes )
            {
                m_upDbc  = std::move( *fbDbcRes );
                m_upStmt = std::move( *fbStmtRes );
                SyncLegacyHandles();
                m_failoverState.store( knc::db::FailoverState::FallbackActive, std::memory_order_release );
                return {};
            }
        }
    }

    Close();
    return std::unexpected( knc::db::DbError{
        knc::db::DbErrorCategory::AllEndpointsExhausted,
        L"08001",
        0,
        L"Both primary Linux VPS MSSQL and fallback endpoints failed to connect."
    } );
}

std::expected< void, knc::db::DbError > KODBC::TriggerFailover( const knc::db::DbError& triggerReason )
{
    START_LOG( cerr, L"Primary DB Endpoint failure detected. Initiating failover state machine." )
        << BUILD_LOG( triggerReason.sqlState )
        << BUILD_LOG( triggerReason.nativeError )
        << BUILD_LOG( triggerReason.message )
        << END_LOG;

    m_failoverState.store( knc::db::FailoverState::FailingOver, std::memory_order_release );

    // Drop dead statement and connection handles via RAII reset
    m_upStmt.reset();
    m_upDbc.reset();
    SyncLegacyHandles();

    if( m_upEnv == nullptr )
    {
        auto envRes = knc::db::CreateEnvironmentHandle();
        if( !envRes )
        {
            m_failoverState.store( knc::db::FailoverState::Disconnected, std::memory_order_release );
            return std::unexpected( envRes.error() );
        }
        m_upEnv = std::move( *envRes );
    }

    // 1. If a secondary/fallback endpoint is configured, switch to it immediately
    if( !m_SecurityFallbackConnStr.IsEmpty() )
    {
        const std::wstring fallbackConn = m_SecurityFallbackConnStr.GetClearString().GetString();
        auto fbDbcRes = knc::db::ConnectDatabaseHandle( m_upEnv.get(), fallbackConn, m_linuxVpsOptions );
        if( fbDbcRes )
        {
            auto fbStmtRes = knc::db::CreateStatementHandle( fbDbcRes->get(), m_linuxVpsOptions.queryTimeoutSeconds );
            if( fbStmtRes )
            {
                m_upDbc  = std::move( *fbDbcRes );
                m_upStmt = std::move( *fbStmtRes );
                SyncLegacyHandles();
                m_failoverState.store( knc::db::FailoverState::FallbackActive, std::memory_order_release );
                return {};
            }
        }
    }

    // 2. Otherwise retry the primary endpoint
    return ConnectWithFailover();
}

bool KODBC::DriverConnect( const wchar_t* szConnStr, bool bDBConnStr )
{
	m_bDBConnStr = bDBConnStr;
	
	if( m_bDBConnStr )
	{
		KClearString< std::wstring > kConnStr( szConnStr ? szConnStr : L"" );
		return DriverConnectString( kConnStr );
	}
	else
	{
		return DriverConnectFileDSN( szConnStr );
	}
}

bool KODBC::DriverConnectFileDSN( const wchar_t* szDsn_ )
{	
    if( !szDsn_ )
    {
        return false;
    }

	const std::wstring strDsn_( szDsn_ );

    // Auto-detect raw DSN-less ODBC connection strings (e.g., "DRIVER={...};SERVER=...")
    if( strDsn_.find( L'=' ) != std::wstring::npos && !strDsn_.starts_with( L"FILEDSN=" ) )
    {
        m_bDBConnStr = true;
        return DriverConnectString( KClearString< std::wstring >( strDsn_ ) );
    }

    if( m_strDSN.empty() )
    {
        wchar_t buff[MAX_PATH] = { 0 };
        ::GetCurrentDirectoryW( MAX_PATH, buff );

        m_strAbsolutePathDSN.assign( buff );
        m_strAbsolutePathDSN += L"\\";
        m_strAbsolutePathDSN += strDsn_;

        m_strDSN = L"FILEDSN=";
        m_strDSN += m_strAbsolutePathDSN;
    }

    Close();

    auto envRes = knc::db::CreateEnvironmentHandle();
    if( !envRes )
    {
        START_LOG( cerr, L"DriverConnectFileDSN() Environment alloc failed: " << envRes.error().message )
            << BUILD_LOG( m_strDSN )
            << END_LOG;
        return false;
    }

    auto dbcRes = knc::db::ConnectDatabaseHandle( envRes->get(), m_strDSN, m_linuxVpsOptions );
    if( !dbcRes )
    {
        START_LOG( cerr, L"DriverConnectFileDSN() Connect failed: " << dbcRes.error().message )
            << BUILD_LOG( m_strDSN )
            << BUILD_LOG( dbcRes.error().sqlState )
            << END_LOG;
        return false;
    }

    auto stmtRes = knc::db::CreateStatementHandle( dbcRes->get(), m_linuxVpsOptions.queryTimeoutSeconds );
    if( !stmtRes )
    {
        START_LOG( cerr, L"DriverConnectFileDSN() Statement alloc failed: " << stmtRes.error().message )
            << BUILD_LOG( m_strDSN )
            << END_LOG;
        return false;
    }

    m_upEnv  = std::move( *envRes );
    m_upDbc  = std::move( *dbcRes );
    m_upStmt = std::move( *stmtRes );
    SyncLegacyHandles();
    m_failoverState.store( knc::db::FailoverState::PrimaryActive, std::memory_order_release );

    dbg::cout << L"DriverConnect() success. m_strDSN : " << m_strDSN << dbg::endl;
    return true;
}

bool KODBC::DriverConnectString( const KClearString< std::wstring >& kDBConnStr )
{
	if( m_SecurityDBConnStr.IsEmpty() && !kDBConnStr.empty() )
	{
		m_SecurityDBConnStr.Init( kDBConnStr.GetString() );

		// Store sanitized database identifier without credentials
		m_strDBConnStr = kDBConnStr.GetString();

		size_t index = m_strDBConnStr.find( L";DATABASE=" );
		if( index != std::wstring::npos )
		{
			m_strDBConnStr.erase( 0, index + 10 );

			index = m_strDBConnStr.find( L";" );
			if( index != std::wstring::npos )
			{
				m_strDBConnStr.erase( index );
			}
		}
	}

    auto res = ConnectWithFailover();
    if( !res )
    {
		START_LOG( cerr, L"DriverConnectString() Failed: " << res.error().message )
			<< BUILD_LOG( m_strDBConnStr )
			<< BUILD_LOG( res.error().sqlState )
			<< END_LOG;
		return false;
    }

	dbg::cout << L"DriverConnect() success. m_strDSN : " << m_strDBConnStr << dbg::endl;
	return true;
}

bool KODBC::ReConnect()
{
    const auto res = ConnectWithFailover();
    if( !res )
    {
        dbg::cerr << L"Reconnect attempt failed: " << res.error().message << END_LOG;
        return false;
    }

    START_LOG( cout, L"Reconnect succeeded. State: " << knc::db::ToWStringView( GetFailoverState() ) );
    return true;
}

void KODBC::Close()
{
    // RAII smart handles release in reverse-dependency order: Stmt -> Dbc -> Env
    m_upStmt.reset();
    m_upDbc.reset();
    m_upEnv.reset();
    SyncLegacyHandles();

    m_usColumNum = 0;
    m_failoverState.store( knc::db::FailoverState::Disconnected, std::memory_order_release );
}

bool KODBC::Query( const std::wstring& wstrQuery )
{
	if( wstrQuery.length() > QUERY_BUFFER_SIZE )
	{
		START_LOG( cerr, L"Query string length exceeds advisory buffer size." )
			<< BUILD_LOG( wstrQuery.length() )
			<< BUILD_LOG( wstrQuery )
			<< END_LOG;
	}

	m_strLastQuery = wstrQuery;

    if( m_upStmt == nullptr )
    {
        if( !ReConnect() )
        {
            return false;
        }
    }

	const auto startTick = std::chrono::steady_clock::now();

	SQLRETURN ret = ::SQLExecDirectW(
        m_upStmt.get(),
        const_cast< SQLWCHAR* >( m_strLastQuery.c_str() ),
        static_cast< SQLINTEGER >( m_strLastQuery.size() ) );

	::SQLGetDiagRecW(
        SQL_HANDLE_STMT,
		m_upStmt.get(),
		1,
		m_sqlState,
		&m_sqlNativeErr,
		m_szDiagMsg,
		static_cast< SQLSMALLINT >( std::size( m_szDiagMsg ) ),
		&m_sqlMsgLen );

	if( ret == SQL_ERROR || ret == SQL_INVALID_HANDLE )
	{
        const auto diagErr = knc::db::ExtractOdbcDiagnostics( SQL_HANDLE_STMT, m_upStmt.get() );
        const std::wstring_view stateView( m_sqlState );

		if( diagErr.IsFailoverTrigger() || stateView == L"08S01" || stateView == L"24000" )
		{
			dbg::cerr << m_strLastQuery << L" (SQLSTATE:" << stateView << L")" << END_LOG;

            if( TriggerFailover( diagErr ).has_value() && m_upStmt != nullptr )
            {
				ret = ::SQLExecDirectW(
                    m_upStmt.get(),
                    const_cast< SQLWCHAR* >( m_strLastQuery.c_str() ),
                    static_cast< SQLINTEGER >( m_strLastQuery.size() ) );
            }
            else
            {
                dbg::cerr << L"Failover / Reconnect failed." << END_LOG;
                return false;
            }
		}
	}

    const auto elapsedMs = static_cast< DWORD >(
        std::chrono::duration_cast< std::chrono::milliseconds >(
            std::chrono::steady_clock::now() - startTick ).count() );

	{
		KLocker lock( ms_kMaxProcessingInfo.m_cs );

		if( elapsedMs > ms_kMaxProcessingInfo.m_dwTerm )
		{
			ms_kMaxProcessingInfo.m_strQuery = m_strLastQuery;
			ms_kMaxProcessingInfo.m_cTime    = CTime::GetCurrentTime();
			ms_kMaxProcessingInfo.m_dwTerm   = elapsedMs;

			START_LOG( clog2, L"Updated maximum query processing duration." )
				<< BUILD_LOG( ms_kMaxProcessingInfo.m_strQuery )
				<< BUILD_LOG( ms_kMaxProcessingInfo.m_dwTerm );
		}
	}

	if( !SQLOK( ret ) && ret != SQL_NO_DATA )
	{
		const SQLRETURN ret2 = ::SQLGetDiagRecW(
            SQL_HANDLE_STMT,
			m_upStmt.get(),
			1,
			m_sqlState,
			&m_sqlNativeErr,
			m_szDiagMsg,
			static_cast< SQLSMALLINT >( std::size( m_szDiagMsg ) ),
			&m_sqlMsgLen );

		START_LOG( cerr, L"Query execution failed!" )
			<< BUILD_LOG( ret )
			<< BUILD_LOG( ret2 )
			<< BUILD_LOG( m_sqlState )
			<< BUILD_LOG( m_sqlNativeErr )
			<< BUILD_LOG( m_szDiagMsg )
			<< BUILD_LOG( m_sqlMsgLen )
			<< END_LOG;
	}

	return SQLOK( ret );
}

bool KODBC::BeginFetch()
{
    if( m_upStmt == nullptr )
    {
        return false;
    }

    m_usColumNum = 0;
    const SQLRETURN ret = ::SQLFetch( m_upStmt.get() );
    
    if( !SQLOK( ret ) )
    {
        EndFetch();

        ::SQLGetDiagRecW(
            SQL_HANDLE_STMT,
            m_upStmt.get(),
            1,
            m_sqlState,
            &m_sqlNativeErr,
            m_szDiagMsg,
            static_cast< SQLSMALLINT >( std::size( m_szDiagMsg ) ),
            &m_sqlMsgLen );

        return false;
    }

    return true;
}

bool KODBC::Fetch()
{
    if( m_upStmt == nullptr )
    {
        return false;
    }

    m_usColumNum = 0;
    const SQLRETURN ret = ::SQLFetch( m_upStmt.get() );

    if( ret == SQL_NO_DATA )
    {
        EndFetch();
    }

    return SQLOK( ret );
}

void KODBC::EndFetch()
{
    if( m_upStmt != nullptr )
    {
        ::SQLCloseCursor( m_upStmt.get() );
    }
}

KODBC& KODBC::operator >>( bool& val_ )
{
    char        val = 0;
    SQLLEN      lenBin = 0;

    m_usColumNum++;
    const SQLRETURN ret = ::SQLGetData(
        m_upStmt.get(),
        m_usColumNum,
        SQL_C_STINYINT,
        &val,
        sizeof( val ),
        &lenBin );

    if( lenBin == SQL_NULL_DATA )
        return *this;

    if( !SQLOK( ret ) )
    {
        THROW_INVALID_QUERY();
    }
    
    val_ = ( val != 0 );
    return *this;
}

KODBC& KODBC::operator >>( char& val_ )
{
    SQLLEN lenBin = 0;

    m_usColumNum++;
    const SQLRETURN ret = ::SQLGetData(
        m_upStmt.get(),
        m_usColumNum,
        SQL_C_STINYINT,
        &val_,
        sizeof( char ),
        &lenBin );

    if( lenBin == SQL_NULL_DATA )
        return *this;

    if( !SQLOK( ret ) )
    {
        THROW_INVALID_QUERY();
    }

    return *this;
}

KODBC& KODBC::operator >>( wchar_t& val_ )
{
    SQLLEN lenBin = 0;

	m_usColumNum++;
	const SQLRETURN ret = ::SQLGetData(
        m_upStmt.get(),
		m_usColumNum,
		SQL_C_WCHAR,
		&val_,
		sizeof( wchar_t ),
		&lenBin );

    if( lenBin == SQL_NULL_DATA )
        return *this;

	if( !SQLOK( ret ) )
	{
		THROW_INVALID_QUERY();
	}

	return *this;
}

KODBC& KODBC::operator >>( short& val_ )
{
    SQLLEN lenBin = 0;
    
    m_usColumNum++;
    const SQLRETURN ret = ::SQLGetData(
        m_upStmt.get(),
        m_usColumNum,
        SQL_C_SHORT,
        &val_,
        sizeof( short ),
        &lenBin );

    if( lenBin == SQL_NULL_DATA )
        return *this;

    if( !SQLOK( ret ) )
    {
        THROW_INVALID_QUERY();
    }
    
    return *this;
}

KODBC& KODBC::operator >>( int& val_ )
{
    SQLLEN lenBin = 0;
    
    m_usColumNum++;
    const SQLRETURN ret = ::SQLGetData(
        m_upStmt.get(),
        m_usColumNum,
        SQL_C_SLONG,
        &val_,
        sizeof( int ),
        &lenBin );

    if( lenBin == SQL_NULL_DATA )
        return *this;

    if( !SQLOK( ret ) )
    {
        THROW_INVALID_QUERY();
    }
    
    return *this;
}

KODBC& KODBC::operator >>( UINT& val_ )
{
	SQLLEN lenBin = 0;

	m_usColumNum++;
	const SQLRETURN ret = ::SQLGetData(
        m_upStmt.get(),
		m_usColumNum,
		SQL_C_SLONG,
		&val_,
		sizeof( UINT ),
		&lenBin );

	if( lenBin == SQL_NULL_DATA )
		return *this;

	if( !SQLOK( ret ) )
	{
		THROW_INVALID_QUERY();
	}

	return *this;
}

KODBC& KODBC::operator >>( UCHAR& val_ )
{
    SQLLEN lenBin = 0;
    
    m_usColumNum++;
    const SQLRETURN ret = ::SQLGetData(
        m_upStmt.get(),
        m_usColumNum,
        SQL_C_UTINYINT,
        &val_,
        sizeof( UCHAR ),
        &lenBin );

    if( lenBin == SQL_NULL_DATA )
        return *this;

    if( !SQLOK( ret ) )
    {
        THROW_INVALID_QUERY();
    }
    
    return *this;
}

KODBC& KODBC::operator >>( USHORT& val_ )
{
    SQLLEN lenBin = 0;
    
    m_usColumNum++;
    const SQLRETURN ret = ::SQLGetData(
        m_upStmt.get(),
        m_usColumNum,
        SQL_C_SSHORT,
        &val_,
        sizeof( USHORT ),
        &lenBin );

    if( lenBin == SQL_NULL_DATA )
        return *this;

    if( !SQLOK( ret ) )
    {
        THROW_INVALID_QUERY();
    }
    
    return *this;
}

KODBC& KODBC::operator >>( DWORD& val_ )
{
    SQLLEN lenBin = 0;
    
    m_usColumNum++;
    const SQLRETURN ret = ::SQLGetData(
        m_upStmt.get(),
        m_usColumNum,
        SQL_C_SLONG,
        &val_,
        sizeof( DWORD ),
        &lenBin );

    if( lenBin == SQL_NULL_DATA )
        return *this;

    if( !SQLOK( ret ) )
    {
        THROW_INVALID_QUERY();
    }

    return *this;
}

KODBC& KODBC::operator >>( ULONGLONG& val_ )
{
    SQLLEN lenBin = 0;

    m_usColumNum++;
    const SQLRETURN ret = ::SQLGetData(
        m_upStmt.get(),
        m_usColumNum,
        SQL_C_SBIGINT,
        &val_,
        sizeof( ULONGLONG ),
        &lenBin );

    if( lenBin == SQL_NULL_DATA )
        return *this;

    if( !SQLOK( ret ) )
    {
        THROW_INVALID_QUERY();
    }

    return *this;
}

KODBC& KODBC::operator >>( LONGLONG& val_ )
{
    SQLLEN lenBin = 0;

    m_usColumNum++;
    const SQLRETURN ret = ::SQLGetData(
        m_upStmt.get(),
        m_usColumNum,
        SQL_C_SBIGINT,
        &val_,
        sizeof( LONGLONG ),
        &lenBin );

    if( lenBin == SQL_NULL_DATA )
        return *this;

    if( !SQLOK( ret ) )
    {
        THROW_INVALID_QUERY();
    }

    return *this;
}

KODBC& KODBC::operator >>( std::string& val_ )
{
    m_usColumNum++;
    val_.clear();

    std::array< char, 1024 > chunk{};
    SQLLEN lenBin = 0;

    SQLRETURN ret = ::SQLGetData(
        m_upStmt.get(),
        m_usColumNum,
        SQL_C_CHAR,
        chunk.data(),
        static_cast< SQLLEN >( chunk.size() ),
        &lenBin );

    if( lenBin == SQL_NULL_DATA )
        return *this;

    if( !SQLOK( ret ) )
    {
        THROW_INVALID_QUERY();
    }

    while( SQLOK( ret ) )
    {
        if( lenBin == SQL_NO_TOTAL || lenBin >= static_cast< SQLLEN >( chunk.size() ) )
        {
            val_.append( chunk.data(), chunk.size() - 1 );
        }
        else if( lenBin > 0 )
        {
            val_.append( chunk.data(), static_cast< size_t >( lenBin ) );
        }

        if( ret == SQL_SUCCESS )
        {
            break;
        }

        ret = ::SQLGetData(
            m_upStmt.get(),
            m_usColumNum,
            SQL_C_CHAR,
            chunk.data(),
            static_cast< SQLLEN >( chunk.size() ),
            &lenBin );
    }

    return *this;
}

KODBC& KODBC::operator >>( char* val_ )
{
    SQLLEN lenBin = 0;

    m_usColumNum++;
    const SQLRETURN ret = ::SQLGetData(
        m_upStmt.get(),
        m_usColumNum,
        SQL_C_CHAR,
        val_,
        1024,
        &lenBin );

    if( lenBin == SQL_NULL_DATA )
        return *this;

    if( !SQLOK( ret ) )
    {
        THROW_INVALID_QUERY();
    }
    
    return *this;
}

KODBC& KODBC::operator >>( std::wstring& val_ )
{
    m_usColumNum++;
    val_.clear();

    std::array< wchar_t, 1024 > chunk{};
    SQLLEN lenBin = 0;

    SQLRETURN ret = ::SQLGetData(
        m_upStmt.get(),
        m_usColumNum,
        SQL_C_WCHAR,
        chunk.data(),
        static_cast< SQLLEN >( chunk.size() * sizeof( wchar_t ) ),
        &lenBin );

    if( lenBin == SQL_NULL_DATA )
        return *this;

    if( !SQLOK( ret ) )
    {
        THROW_INVALID_QUERY();
    }

    while( SQLOK( ret ) )
    {
        const SQLLEN maxPayloadBytes = static_cast< SQLLEN >( ( chunk.size() - 1 ) * sizeof( wchar_t ) );
        if( lenBin == SQL_NO_TOTAL || lenBin >= static_cast< SQLLEN >( chunk.size() * sizeof( wchar_t ) ) )
        {
            val_.append( chunk.data(), chunk.size() - 1 );
        }
        else if( lenBin > 0 )
        {
            const size_t charCount = static_cast< size_t >( ( std::min )( lenBin, maxPayloadBytes ) ) / sizeof( wchar_t );
            val_.append( chunk.data(), charCount );
        }

        if( ret == SQL_SUCCESS )
        {
            break;
        }

        ret = ::SQLGetData(
            m_upStmt.get(),
            m_usColumNum,
            SQL_C_WCHAR,
            chunk.data(),
            static_cast< SQLLEN >( chunk.size() * sizeof( wchar_t ) ),
            &lenBin );
    }

    return *this;
}

KODBC& KODBC::operator >>( wchar_t* val_ )
{
    SQLLEN lenBin = 0;

    m_usColumNum++;
    const SQLRETURN ret = ::SQLGetData(
        m_upStmt.get(),
        m_usColumNum,
        SQL_C_WCHAR,
        val_,
        1024,
        &lenBin );

    if( lenBin == SQL_NULL_DATA )
        return *this;

    if( !SQLOK( ret ) )
    {
        THROW_INVALID_QUERY();
    }

    return *this;
}

KODBC& KODBC::operator >>( float& val_ )
{
    SQLLEN lenBin = 0;

    m_usColumNum++;
    const SQLRETURN ret = ::SQLGetData(
        m_upStmt.get(),
        m_usColumNum,
        SQL_C_FLOAT,
        &val_,
        sizeof( float ),
        &lenBin );

    if( lenBin == SQL_NULL_DATA )
        return *this;

    if( !SQLOK( ret ) )
    {
        THROW_INVALID_QUERY();
    }

    return *this;
}

KODBC& KODBC::operator >>( KSerBuffer& val_ )
{
    std::array< char, 1024 > cbuff{};
    SQLLEN lenBin = 0;

    m_usColumNum++;
    val_.Clear();

    SQLRETURN ret = ::SQLGetData(
        m_upStmt.get(),
        m_usColumNum,
        SQL_C_BINARY,
        cbuff.data(),
        static_cast< SQLLEN >( cbuff.size() ),
        &lenBin );

    while( ret != SQL_NO_DATA )
    {
        if( lenBin == SQL_NULL_DATA )
            return *this;

        if( !SQLOK( ret ) )
        {
            THROW_INVALID_QUERY();
        }

        const SQLLEN bytesRead = ( lenBin == SQL_NO_TOTAL || lenBin > static_cast< SQLLEN >( cbuff.size() ) )
            ? static_cast< SQLLEN >( cbuff.size() )
            : lenBin;

        if( bytesRead > 0 )
        {
            val_.Write( cbuff.data(), static_cast< ULONG >( bytesRead ) );
        }

        ret = ::SQLGetData(
            m_upStmt.get(),
            m_usColumNum,
            SQL_C_BINARY,
            cbuff.data(),
            static_cast< SQLLEN >( cbuff.size() ),
            &lenBin );
    }

    return *this;
}

KODBC& KODBC::operator >>( time_t& val_ )
{
    TIMESTAMP_STRUCT sqlTime{};
    SQLLEN           lenBin = 0;

    m_usColumNum++;
 
    const SQLRETURN ret = ::SQLGetData(
        m_upStmt.get(),
        m_usColumNum,
        SQL_C_TYPE_TIMESTAMP,
        &sqlTime,
        sizeof( sqlTime ),
        &lenBin );

    if( lenBin == SQL_NULL_DATA )
        return *this;

    if( !SQLOK( ret ) )
    {
        THROW_INVALID_QUERY();
    }

    struct tm timeVal{};
    timeVal.tm_year = sqlTime.year - 1900;
    timeVal.tm_mon  = sqlTime.month - 1;
    timeVal.tm_mday = sqlTime.day;
    timeVal.tm_hour = sqlTime.hour;
    timeVal.tm_min  = sqlTime.minute;
    timeVal.tm_sec  = sqlTime.second;

    val_ = std::mktime( &timeVal );
    if( val_ == static_cast< time_t >( -1 ) )
    {
        THROW_INVALID_QUERY();
    }

    return *this;
}

ImplToStringW( KODBC )
{
    wchar_t szSectionName[10] = { 0 };
    ::GetPrivateProfileSectionNamesW( szSectionName, 10, m_strAbsolutePathDSN.c_str() );

    wchar_t szAddress[100] = { 0 };
    ::GetPrivateProfileStringW( szSectionName, L"Address", nullptr, szAddress, 100, m_strAbsolutePathDSN.c_str() );
   
    return stm_ << std::endl
                << TOSTRINGW( szAddress )
                << TOSTRINGW( m_strDSN );
}

void KODBC::DumpMaxTime( std::wostream& stm_ )
{
    KLocker lock( ms_kMaxProcessingInfo.m_cs );

    stm_ << L" -- Max Processing query -- " << std::endl
         << L"  query   : " << ms_kMaxProcessingInfo.m_strQuery.c_str() << std::endl
         << L"  elapsed : " << ms_kMaxProcessingInfo.m_dwTerm << std::endl
         << L"  execute : " << (const wchar_t*)ms_kMaxProcessingInfo.m_cTime.Format( _T( "%Y-%m-%d %H:%M:%S" ) ) << std::endl;
}

void KODBC::ResetMaxTime()
{
    KLocker lock( ms_kMaxProcessingInfo.m_cs );

    ms_kMaxProcessingInfo.m_dwTerm = 0;
    ms_kMaxProcessingInfo.m_cTime  = CTime::GetCurrentTime();
    std::wstring wstrTime = static_cast< const wchar_t* >( ms_kMaxProcessingInfo.m_cTime.Format( _T( "%Y-%m-%d %H:%M:%S" ) ) );
    wstrTime.append( L" Reset completed." );
	ms_kMaxProcessingInfo.m_strQuery = std::move( wstrTime );
}

namespace
{
    static constexpr std::wstring_view g_szInvalidMark[] = {
        L"\'",
        L"\"",
        L";",
        L"--",
        L" ",
        L"\x3000",
        L"\t",
        L",",
		L"`",
		L"^",
		L"&",
		L"*",
		L"+",
		L"=",
		L"|",
		L"{",
		L"}",
		L":",
		L"?",
		L"<",
		L">",
		L"\x266A"
    };

	static constexpr std::wstring_view g_szInvalidMarkForLetter[] = {
		L"\'",
	};

	static constexpr std::wstring_view g_szInvalidMarkForCheat[] = {
		L";",
		L"--",
		L"\x3000",
		L"\t",
		L",",
		L"~",
		L"`",
		L"@",
		L"^",
		L"&",
		L"*",
		L"-",
		L"+",
		L"=",
		L"|",
		L"{",
		L"}",
		L"[",
		L"]",
		L":",
		L"?",
		L"<",
		L">",
		L".",
		L"\x266A"
	};

	static constexpr std::wstring_view g_szInvalidMarkForMachineID[] = {
		L"\'",
		L"\"",
		L";",
		L"--",
		L" ",
		L"\x3000",
		L"\t",
		L",",
		L"~",
		L"`",
		L"@",
		L"^",
		L"&",
		L"*",
		L"-",
		L"|",
		L"{",
		L"}",
		L"[",
		L"]",
		L":",
		L"?",
		L"<",
		L">",
		L".",
		L"\x266A"
	};
}

bool KODBC::IsInvalidMarkIn( IN const std::wstring& strData )
{
    const std::wstring_view view( strData );
    for( const auto token : g_szInvalidMark )
    {
        if( view.find( token ) != std::wstring_view::npos )
            return true;
    }
    return false;
}

bool KODBC::IsInvalidMarkInForLetter( IN const std::wstring& strData )
{
    const std::wstring_view view( strData );
	for( const auto token : g_szInvalidMarkForLetter )
	{
		if( view.find( token ) != std::wstring_view::npos )
			return true;
	}
	return false;
}

bool KODBC::IsInvalidMarkInForCheat( IN const std::wstring& strData )
{
    const std::wstring_view view( strData );
	for( const auto token : g_szInvalidMarkForCheat )
	{
		if( view.find( token ) != std::wstring_view::npos )
			return true;
	}
	return false;
}

bool KODBC::IsInvalidMarkInForMachineID( IN const std::wstring& strData )
{
    const std::wstring_view view( strData );
	for( const auto token : g_szInvalidMarkForMachineID )
	{
		if( view.find( token ) != std::wstring_view::npos )
			return true;
	}
	return false;
}

void KODBC::RemoveInvalidMark( IN OUT std::wstring& strData )
{
    for( const auto token : g_szInvalidMark )
    {
        boost::replace_all( strData, token, L"*" );
    }
}

KDBQuerySuccessChecker::KDBQuerySuccessChecker()
{
	Clear();
}

KDBQuerySuccessChecker::~KDBQuerySuccessChecker() = default;

void KDBQuerySuccessChecker::Clear()
{
	m_vecSuccessQuery.clear();
	m_vecFailedQuery.clear();
}

void KDBQuerySuccessChecker::AddSuccessQuery( IN const std::wstring& wstrQuery )
{
	m_vecSuccessQuery.push_back( wstrQuery );
}

void KDBQuerySuccessChecker::AddFailedQuery( IN const std::wstring& wstrQuery )
{
	m_vecFailedQuery.push_back( wstrQuery );
}

bool KDBQuerySuccessChecker::IsAllQuerySuccess() const
{
	return ( !m_vecSuccessQuery.empty() && m_vecFailedQuery.empty() );
}

void KDBQuerySuccessChecker::PrintLogSuccessQuery() const
{
	for( const auto& query : m_vecSuccessQuery )
	{
		START_LOG( cout2, L"Success Query : " << query );
	}
}

void KDBQuerySuccessChecker::PrintLogFailedQuery() const
{
	for( const auto& query : m_vecFailedQuery )
	{
		START_LOG( cout2, L"Failed Query : " << query );
	}
}
