#include "DBConnectionManager.h"
#include "BaseServer.h"

#include "cryptopp/des.h"
#include "cryptopp/modes.h"
#include "cryptopp/hmac.h"
#include "cryptopp/md5.h"
#include "KncSecurity/ByteStream.h"

#pragma push_macro("min")
#pragma push_macro("max")
#undef min
#undef max
#include <array>
#include <charconv>
#include <format>
#include <random>
#pragma pop_macro("max")
#pragma pop_macro("min")

namespace
{
    constexpr size_t kCryptoKeySize     = 8;
    constexpr size_t kCryptoIvSize      = 8;
    constexpr size_t kByteTripletWidth  = 3;

    [[nodiscard]] std::string FormatByteTriplet( uint8_t value )
    {
        return std::format( "{:03d}", static_cast< unsigned int >( value ) );
    }

    [[nodiscard]] std::optional< uint8_t > ParseByteTriplet( std::string_view sv ) noexcept
    {
        if( sv.size() != kByteTripletWidth )
        {
            return std::nullopt;
        }

        unsigned int parsed = 0;
        const auto [ptr, ec] = std::from_chars( sv.data(), sv.data() + sv.size(), parsed );
        if( ec != std::errc{} || ptr != sv.data() + sv.size() || parsed > 255u )
        {
            return std::nullopt;
        }

        return static_cast< uint8_t >( parsed );
    }

    [[nodiscard]] std::array< uint8_t, kCryptoKeySize > GenerateRandomKey() noexcept
    {
        thread_local std::mt19937 rng{ std::random_device{}() };
        std::uniform_int_distribution< unsigned int > dist( 1u, 126u );

        std::array< uint8_t, kCryptoKeySize > key{};
        for( auto& b : key )
        {
            b = static_cast< uint8_t >( dist( rng ) );
        }
        return key;
    }

    [[nodiscard]] std::array< uint8_t, kCryptoIvSize > GenerateRandomIv() noexcept
    {
        thread_local std::mt19937 rng{ std::random_device{}() };
        std::uniform_int_distribution< unsigned int > dist( 0u, 39u );

        std::array< uint8_t, kCryptoIvSize > iv{};
        iv.fill( static_cast< uint8_t >( 'A' + dist( rng ) ) );
        return iv;
    }

    [[nodiscard]] std::expected< std::string, knc::db::DbError >
    EncryptDesPayload( std::string_view plainSource )
    {
        const auto key = GenerateRandomKey();
        const auto iv  = GenerateRandomIv();

        std::vector< uint8_t > paddedPayload( plainSource.begin(), plainSource.end() );
        while( ( paddedPayload.size() % kCryptoKeySize ) != 0 || paddedPayload.empty() )
        {
            paddedPayload.push_back( static_cast< uint8_t >( '@' ) );
        }

        std::vector< uint8_t > cipherBytes( paddedPayload.size(), 0 );
        CryptoPP::CBC_Mode< CryptoPP::DES >::Encryption encryptor(
            key.data(), key.size(), iv.data() );
        encryptor.ProcessData(
            cipherBytes.data(),
            paddedPayload.data(),
            paddedPayload.size() );

        std::string encoded;
        encoded.reserve( ( kCryptoKeySize + kCryptoIvSize + cipherBytes.size() ) * kByteTripletWidth );

        for( size_t i = 0; i < kCryptoKeySize; ++i )
        {
            encoded += FormatByteTriplet( key[i] );
        }

        for( size_t i = 0; i < kCryptoIvSize; ++i )
        {
            encoded += FormatByteTriplet( static_cast< uint8_t >( iv[i] ^ key[i] ) );
        }

        for( const uint8_t c : cipherBytes )
        {
            encoded += FormatByteTriplet( c );
        }

        return encoded;
    }

    [[nodiscard]] std::expected< std::string, knc::db::DbError >
    DecryptDesPayload( std::string_view encryptedSource )
    {
        constexpr size_t kHeaderLen = ( kCryptoKeySize + kCryptoIvSize ) * kByteTripletWidth;
        if( encryptedSource.size() <= kHeaderLen || ( encryptedSource.size() % kByteTripletWidth ) != 0 )
        {
            return std::unexpected( knc::db::DbError{
                knc::db::DbErrorCategory::DecryptionFailed,
                L"22023",
                0,
                L"Encrypted connection payload has invalid length."
            } );
        }

        std::array< uint8_t, kCryptoKeySize > key{};
        std::array< uint8_t, kCryptoIvSize >  iv{};

        size_t cursor = 0;
        for( size_t i = 0; i < kCryptoKeySize; ++i, cursor += kByteTripletWidth )
        {
            auto parsed = ParseByteTriplet( encryptedSource.substr( cursor, kByteTripletWidth ) );
            if( !parsed )
            {
                return std::unexpected( knc::db::DbError{
                    knc::db::DbErrorCategory::DecryptionFailed,
                    L"22018",
                    0,
                    L"Failed to parse DES key triplet from connection string."
                } );
            }
            key[i] = *parsed;
        }

        for( size_t i = 0; i < kCryptoIvSize; ++i, cursor += kByteTripletWidth )
        {
            auto parsed = ParseByteTriplet( encryptedSource.substr( cursor, kByteTripletWidth ) );
            if( !parsed )
            {
                return std::unexpected( knc::db::DbError{
                    knc::db::DbErrorCategory::DecryptionFailed,
                    L"22018",
                    0,
                    L"Failed to parse DES IV triplet from connection string."
                } );
            }
            iv[i] = static_cast< uint8_t >( *parsed ^ key[i] );
        }

        const size_t cipherCount = ( encryptedSource.size() - cursor ) / kByteTripletWidth;
        if( cipherCount == 0 || ( cipherCount % kCryptoKeySize ) != 0 )
        {
            return std::unexpected( knc::db::DbError{
                knc::db::DbErrorCategory::DecryptionFailed,
                L"22023",
                0,
                L"Encrypted DES ciphertext is not aligned to 8-byte block boundary."
            } );
        }

        std::vector< uint8_t > cipherBytes( cipherCount, 0 );
        for( size_t i = 0; i < cipherCount; ++i, cursor += kByteTripletWidth )
        {
            auto parsed = ParseByteTriplet( encryptedSource.substr( cursor, kByteTripletWidth ) );
            if( !parsed )
            {
                return std::unexpected( knc::db::DbError{
                    knc::db::DbErrorCategory::DecryptionFailed,
                    L"22018",
                    0,
                    L"Invalid byte triplet inside DES payload."
                } );
            }
            cipherBytes[i] = *parsed;
        }

        std::vector< uint8_t > plainBytes( cipherBytes.size(), 0 );
        CryptoPP::CBC_Mode< CryptoPP::DES >::Decryption decryptor(
            key.data(), key.size(), iv.data() );
        decryptor.ProcessData(
            plainBytes.data(),
            cipherBytes.data(),
            cipherBytes.size() );

        std::string result;
        result.reserve( plainBytes.size() );
        for( const uint8_t ch : plainBytes )
        {
            if( ch != static_cast< uint8_t >( '@' ) && ch != 0 )
            {
                result.push_back( static_cast< char >( ch ) );
            }
        }

        return result;
    }

    // Dynamic RAII helper to fetch a wstring column without fixed stack buffer limits
    [[nodiscard]] std::expected< std::wstring, knc::db::DbError >
    FetchWStringColumn( SQLHSTMT hStmt, SQLUSMALLINT colIndex )
    {
        std::wstring result;
        std::array< wchar_t, 512 > chunk{};
        SQLLEN indicator = 0;

        SQLRETURN ret = ::SQLGetData(
            hStmt,
            colIndex,
            SQL_C_WCHAR,
            chunk.data(),
            static_cast< SQLLEN >( chunk.size() * sizeof( wchar_t ) ),
            &indicator );

        if( indicator == SQL_NULL_DATA )
        {
            return result;
        }

        if( !SQLOK( ret ) )
        {
            return std::unexpected( knc::db::ExtractOdbcDiagnostics(
                SQL_HANDLE_STMT, hStmt, knc::db::DbErrorCategory::FetchFailed ) );
        }

        while( SQLOK( ret ) )
        {
            const SQLLEN maxPayloadBytes = static_cast< SQLLEN >( ( chunk.size() - 1 ) * sizeof( wchar_t ) );
            if( indicator == SQL_NO_TOTAL || indicator >= static_cast< SQLLEN >( chunk.size() * sizeof( wchar_t ) ) )
            {
                result.append( chunk.data(), chunk.size() - 1 );
            }
            else if( indicator > 0 )
            {
                const size_t chars = static_cast< size_t >( ( std::min )( indicator, maxPayloadBytes ) ) / sizeof( wchar_t );
                result.append( chunk.data(), chars );
            }

            if( ret == SQL_SUCCESS )
            {
                break;
            }

            ret = ::SQLGetData(
                hStmt,
                colIndex,
                SQL_C_WCHAR,
                chunk.data(),
                static_cast< SQLLEN >( chunk.size() * sizeof( wchar_t ) ),
                &indicator );
        }

        return result;
    }

    [[nodiscard]] std::expected< int32_t, knc::db::DbError >
    FetchInt32Column( SQLHSTMT hStmt, SQLUSMALLINT colIndex )
    {
        int32_t value = 0;
        SQLLEN indicator = 0;
        const SQLRETURN ret = ::SQLGetData(
            hStmt,
            colIndex,
            SQL_C_SLONG,
            &value,
            sizeof( value ),
            &indicator );

        if( indicator == SQL_NULL_DATA )
        {
            return 0;
        }

        if( !SQLOK( ret ) )
        {
            return std::unexpected( knc::db::ExtractOdbcDiagnostics(
                SQL_HANDLE_STMT, hStmt, knc::db::DbErrorCategory::FetchFailed ) );
        }

        return value;
    }
} // anonymous namespace

KDBConnectionManager::KDBConnectionManager() = default;

KDBConnectionManager::KDBConnectionManager(
    std::wstring_view primaryLinuxVpsConnStr,
    std::wstring_view fallbackConnStr,
    const knc::db::LinuxVpsConnectionOptions& options )
    : m_wstrPrimaryEndpoint( primaryLinuxVpsConnStr )
    , m_wstrFallbackEndpoint( fallbackConnStr )
    , m_options( options )
{
}

KDBConnectionManager::~KDBConnectionManager()
{
    Disconnect();
}

void KDBConnectionManager::SetEndpoints(
    std::wstring_view primaryLinuxVpsConnStr,
    std::wstring_view fallbackConnStr )
{
    std::unique_lock lock( m_mutex );
    m_wstrPrimaryEndpoint.assign( primaryLinuxVpsConnStr );
    m_wstrFallbackEndpoint.assign( fallbackConnStr );
}

void KDBConnectionManager::SetConnectionOptions( const knc::db::LinuxVpsConnectionOptions& options ) noexcept
{
    std::unique_lock lock( m_mutex );
    m_options = options;
}

void KDBConnectionManager::SetPrimaryRecoveryCooldown( std::chrono::seconds cooldown ) noexcept
{
    std::unique_lock lock( m_mutex );
    m_primaryRecoveryCooldown = cooldown;
}

KDBConnectionManager::FailoverTelemetry KDBConnectionManager::GetTelemetry() const noexcept
{
    return FailoverTelemetry{
        m_state.load( std::memory_order_acquire ),
        m_totalQueries.load( std::memory_order_relaxed ),
        m_failoverCount.load( std::memory_order_relaxed ),
        m_primaryRecoveries.load( std::memory_order_relaxed )
    };
}

void KDBConnectionManager::Disconnect() noexcept
{
    std::unique_lock lock( m_mutex );
    m_upStmt.reset();
    m_upDbc.reset();
    m_upEnv.reset();
    m_state.store( knc::db::FailoverState::Disconnected, std::memory_order_release );
}

std::expected< void, knc::db::DbError > KDBConnectionManager::ConnectEndpointLocked(
    std::wstring_view connStr,
    knc::db::FailoverState targetState )
{
    if( connStr.empty() )
    {
        return std::unexpected( knc::db::DbError{
            knc::db::DbErrorCategory::InvalidArgument,
            L"08001",
            0,
            L"Endpoint connection string is empty."
        } );
    }

    // Release any prior statement/connection before establishing the new session
    m_upStmt.reset();
    m_upDbc.reset();

    if( m_upEnv == nullptr )
    {
        auto envRes = knc::db::CreateEnvironmentHandle();
        if( !envRes )
        {
            m_state.store( knc::db::FailoverState::Disconnected, std::memory_order_release );
            return std::unexpected( envRes.error() );
        }
        m_upEnv = std::move( *envRes );
    }

    std::wstring resolvedConn( connStr );
    if( !m_bIsRawConnectionString && !resolvedConn.starts_with( L"FILEDSN=" ) && resolvedConn.find( L'=' ) == std::wstring::npos )
    {
        wchar_t cwd[MAX_PATH] = { 0 };
        ::GetCurrentDirectoryW( MAX_PATH, cwd );
        resolvedConn = std::wstring( L"FILEDSN=" ) + cwd + L"\\" + resolvedConn;
    }

    auto dbcRes = knc::db::ConnectDatabaseHandle( m_upEnv.get(), resolvedConn, m_options );
    if( !dbcRes )
    {
        return std::unexpected( dbcRes.error() );
    }

    auto stmtRes = knc::db::CreateStatementHandle( dbcRes->get(), m_options.queryTimeoutSeconds );
    if( !stmtRes )
    {
        return std::unexpected( stmtRes.error() );
    }

    m_upDbc  = std::move( *dbcRes );
    m_upStmt = std::move( *stmtRes );
    m_state.store( targetState, std::memory_order_release );

    return {};
}

std::expected< void, knc::db::DbError > KDBConnectionManager::Connect()
{
    std::unique_lock lock( m_mutex );

    auto primaryRes = ConnectEndpointLocked( m_wstrPrimaryEndpoint, knc::db::FailoverState::PrimaryActive );
    if( primaryRes )
    {
        return {};
    }

    // If primary Linux VPS link fails and a fallback endpoint is configured, transition to FallbackActive
    if( !m_wstrFallbackEndpoint.empty() )
    {
        m_state.store( knc::db::FailoverState::FailingOver, std::memory_order_release );

        auto fallbackRes = ConnectEndpointLocked( m_wstrFallbackEndpoint, knc::db::FailoverState::FallbackActive );
        if( fallbackRes )
        {
            m_lastFailoverTimestamp = std::chrono::steady_clock::now();
            m_failoverCount.fetch_add( 1, std::memory_order_relaxed );

            START_LOG( cout, L"Primary Linux VPS DB unreachable; failed over to secondary endpoint." )
                << BUILD_LOG( primaryRes.error().sqlState )
                << BUILD_LOG( primaryRes.error().message );
            return {};
        }
    }

    m_state.store( knc::db::FailoverState::Disconnected, std::memory_order_release );
    return std::unexpected( primaryRes.error() );
}

std::expected< void, knc::db::DbError > KDBConnectionManager::FailoverToSecondary( const knc::db::DbError& cause )
{
    std::unique_lock lock( m_mutex );

    m_state.store( knc::db::FailoverState::FailingOver, std::memory_order_release );

    START_LOG( cerr, L"Failover triggered due to primary Linux VPS DB fault." )
        << BUILD_LOG( cause.sqlState )
        << BUILD_LOG( cause.nativeError )
        << BUILD_LOG( cause.message )
        << END_LOG;

    // Safely tear down the broken connection handles via RAII reset
    m_upStmt.reset();
    m_upDbc.reset();

    if( !m_wstrFallbackEndpoint.empty() )
    {
        auto fbRes = ConnectEndpointLocked( m_wstrFallbackEndpoint, knc::db::FailoverState::FallbackActive );
        if( fbRes )
        {
            m_lastFailoverTimestamp = std::chrono::steady_clock::now();
            m_failoverCount.fetch_add( 1, std::memory_order_relaxed );
            return {};
        }
    }

    // If no separate fallback is configured (or fallback failed), attempt reconnect on primary
    auto retryPrimary = ConnectEndpointLocked( m_wstrPrimaryEndpoint, knc::db::FailoverState::PrimaryActive );
    if( retryPrimary )
    {
        return {};
    }

    m_state.store( knc::db::FailoverState::Disconnected, std::memory_order_release );
    return std::unexpected( knc::db::DbError{
        knc::db::DbErrorCategory::AllEndpointsExhausted,
        cause.sqlState,
        cause.nativeError,
        L"Failover exhausted both primary Linux VPS and secondary fallback endpoints."
    } );
}

std::optional< knc::db::DbError > KDBConnectionManager::TryRestorePrimaryIfReady()
{
    std::unique_lock lock( m_mutex );

    if( m_state.load( std::memory_order_acquire ) != knc::db::FailoverState::FallbackActive )
    {
        return std::nullopt;
    }

    const auto now = std::chrono::steady_clock::now();
    if( ( now - m_lastFailoverTimestamp ) < m_primaryRecoveryCooldown )
    {
        return std::nullopt;
    }

    m_lastFailoverTimestamp = now;

    // Probe primary Linux VPS endpoint on a temporary RAII connection before disturbing active fallback
    auto probeDbc = knc::db::ConnectDatabaseHandle( m_upEnv.get(), m_wstrPrimaryEndpoint, m_options );
    if( !probeDbc )
    {
        return probeDbc.error();
    }

    auto probeStmt = knc::db::CreateStatementHandle( probeDbc->get(), m_options.queryTimeoutSeconds );
    if( !probeStmt )
    {
        return probeStmt.error();
    }

    // Atomically swap active handles back to primary Linux VPS connection
    m_upStmt = std::move( *probeStmt );
    m_upDbc  = std::move( *probeDbc );
    m_state.store( knc::db::FailoverState::PrimaryActive, std::memory_order_release );
    m_primaryRecoveries.fetch_add( 1, std::memory_order_relaxed );

    START_LOG( cout, L"Primary Linux VPS MSSQL connection restored from FallbackActive." );
    return std::nullopt;
}

std::expected< std::vector< KDBConnectionInfo >, knc::db::DbError >
KDBConnectionManager::ExecuteManagerInfoQueryLocked( int32_t serverType )
{
    if( m_upStmt == nullptr )
    {
        return std::unexpected( knc::db::DbError{
            knc::db::DbErrorCategory::ConnectionFailed,
            L"08003",
            0,
            L"Statement handle is not initialized."
        } );
    }

    SQLHSTMT hStmt = m_upStmt.get();
    knc::db::SqlStmtResetGuard stmtGuard( hStmt, true );

    // Strictly parameterized stored procedure call (zero string concatenation / SQL injection risk)
    static constexpr std::wstring_view kParameterizedProc = L"{call dbo.temp_get_info(?)}";

    SQLRETURN ret = ::SQLPrepareW(
        hStmt,
        const_cast< SQLWCHAR* >( kParameterizedProc.data() ),
        static_cast< SQLINTEGER >( kParameterizedProc.size() ) );
    if( !SQLOK( ret ) )
    {
        return std::unexpected( knc::db::ExtractOdbcDiagnostics( SQL_HANDLE_STMT, hStmt ) );
    }

    SQLLEN paramIndicator = 0;
    ret = knc::db::detail::BindOneParameter( hStmt, 1, serverType, paramIndicator );
    if( !SQLOK( ret ) )
    {
        return std::unexpected( knc::db::ExtractOdbcDiagnostics(
            SQL_HANDLE_STMT, hStmt, knc::db::DbErrorCategory::ParameterBindingFailed ) );
    }

    ret = ::SQLExecute( hStmt );
    if( !SQLOK( ret ) && ret != SQL_NO_DATA )
    {
        return std::unexpected( knc::db::ExtractOdbcDiagnostics( SQL_HANDLE_STMT, hStmt ) );
    }

    m_totalQueries.fetch_add( 1, std::memory_order_relaxed );

    std::vector< KDBConnectionInfo > results;
    while( SQLOK( ::SQLFetch( hStmt ) ) )
    {
        auto groupRes       = FetchInt32Column( hStmt, 1 );
        auto dbTypeRes      = FetchInt32Column( hStmt, 2 );
        auto encryptedRes   = FetchWStringColumn( hStmt, 3 );
        auto threadCountRes = FetchInt32Column( hStmt, 4 );

        if( !groupRes || !dbTypeRes || !encryptedRes || !threadCountRes )
        {
            continue;
        }

        const int32_t serverGroupId = *groupRes;
        if( serverGroupId != -1 && KBaseServer::GetKObj() != nullptr )
        {
            if( serverGroupId != KBaseServer::GetKObj()->GetServerGroupID() )
            {
                continue;
            }
        }

        auto decryptedConnStr = DecryptConnectionPayload( *encryptedRes );
        if( !decryptedConnStr )
        {
            START_LOG( cerr, L"Failed to decrypt manager DB connection string!" )
                << BUILD_LOG( *encryptedRes )
                << BUILD_LOG( decryptedConnStr.error().message )
                << END_LOG;
            continue;
        }

        KDBConnectionInfo info;
        info.m_iDBType               = *dbTypeRes;
        info.m_wstrConnectionString  = std::move( *decryptedConnStr );
        info.m_iThreadCount          = *threadCountRes;
        results.push_back( std::move( info ) );
    }

    return results;
}

std::expected< std::vector< KDBConnectionInfo >, knc::db::DbError >
KDBConnectionManager::FetchManagedConnectionInfos(
    int32_t serverType,
    std::wstring_view primaryConnStr,
    std::wstring_view fallbackConnStr,
    bool isRawConnString )
{
    {
        std::unique_lock lock( m_mutex );
        m_bIsRawConnectionString = isRawConnString;
        if( !primaryConnStr.empty() )
        {
            m_wstrPrimaryEndpoint.assign( primaryConnStr );
        }
        if( !fallbackConnStr.empty() )
        {
            m_wstrFallbackEndpoint.assign( fallbackConnStr );
        }
    }

    if( GetState() == knc::db::FailoverState::Disconnected )
    {
        auto connRes = Connect();
        if( !connRes )
        {
            return std::unexpected( connRes.error() );
        }
    }
    else if( GetState() == knc::db::FailoverState::FallbackActive )
    {
        (void)TryRestorePrimaryIfReady();
    }

    std::expected< std::vector< KDBConnectionInfo >, knc::db::DbError > queryRes;
    {
        std::unique_lock lock( m_mutex );
        queryRes = ExecuteManagerInfoQueryLocked( serverType );
    }

    // If primary Linux VPS link dropped or timed out mid-query, trigger failover and retry once
    if( !queryRes && queryRes.error().IsFailoverTrigger() )
    {
        auto failoverRes = FailoverToSecondary( queryRes.error() );
        if( failoverRes )
        {
            std::unique_lock lock( m_mutex );
            queryRes = ExecuteManagerInfoQueryLocked( serverType );
        }
    }

    return queryRes;
}

std::expected< std::wstring, knc::db::DbError >
KDBConnectionManager::DecryptConnectionPayload( std::wstring_view encryptedPayload )
{
    // Support both DES-encrypted numeric triplets and direct ODBC connection strings ("DRIVER=...;SERVER=...")
    if( encryptedPayload.find( L'=' ) != std::wstring_view::npos )
    {
        return std::wstring( encryptedPayload );
    }

    const std::string narrowInput = KncUtil::toNarrowString(
        encryptedPayload.data(),
        static_cast< int >( encryptedPayload.size() ) );

    auto decryptedNarrow = DecryptDesPayload( narrowInput );
    if( !decryptedNarrow )
    {
        return std::unexpected( decryptedNarrow.error() );
    }

    return KncUtil::toWideString( *decryptedNarrow );
}

std::expected< std::string, knc::db::DbError >
KDBConnectionManager::EncryptConnectionPayload( std::string_view plainPayload )
{
    return EncryptDesPayload( plainPayload );
}

bool KDBConnectionManager::GetDBConnectionInfoFromManagerDB(
    IN const int iServerType,
    IN const wchar_t* szConnStr,
    IN const bool bDBConnStr,
    OUT std::vector< KDBConnectionInfo >& vecDBConnectionInfo )
{
    vecDBConnectionInfo.clear();

    if( szConnStr == nullptr )
    {
        START_LOG( cerr, L"Connection string pointer is nullptr!" )
            << END_LOG;
        return false;
    }

    auto result = FetchManagedConnectionInfos(
        static_cast< int32_t >( iServerType ),
        std::wstring_view{ szConnStr },
        m_wstrFallbackEndpoint,
        bDBConnStr );

    if( !result )
    {
        START_LOG( cerr, L"Failed to query DB connection info from Manager DB!" )
            << BUILD_LOG( iServerType )
            << BUILD_LOG( result.error().sqlState )
            << BUILD_LOG( result.error().nativeError )
            << BUILD_LOG( result.error().message )
            << END_LOG;
        return false;
    }

    if( result->empty() )
    {
        START_LOG( cerr, L"Manager DB returned empty connection list!" )
            << BUILD_LOG( iServerType )
            << END_LOG;
        return false;
    }

    vecDBConnectionInfo = std::move( *result );
    return true;
}

bool KDBConnectionManager::DecryptDBString(
    IN const std::wstring& wstrDBString,
    OUT std::wstring& wstrDecryptString )
{
    auto res = DecryptConnectionPayload( wstrDBString );
    if( !res )
    {
        START_LOG( cerr, L"Decryption failed!" )
            << BUILD_LOG( wstrDBString )
            << BUILD_LOG( res.error().message )
            << END_LOG;
        return false;
    }

    wstrDecryptString = std::move( *res );
    return true;
}
