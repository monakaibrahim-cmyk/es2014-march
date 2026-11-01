#pragma once

#include "SubThread.h"
#include "odbc/Odbc.h"
#include "odbc/DBUtil.h"
#include "Event.h"
#include "CommonPacket.h"
#include "ServerPacket.h"

#pragma push_macro("min")
#pragma push_macro("max")
#undef min
#undef max
#include <atomic>
#include <chrono>
#include <cstdint>
#include <expected>
#include <memory>
#include <mutex>
#include <optional>
#include <shared_mutex>
#include <string>
#include <string_view>
#include <vector>
#pragma pop_macro("max")
#pragma pop_macro("min")

#ifndef SERV_DB_CONNECTION_SECURITY
struct KDBConnectionInfo
{
    int             m_iDBType      = 0;
    std::wstring    m_wstrConnectionString;
    int             m_iThreadCount = 0;
};
#endif // SERV_DB_CONNECTION_SECURITY

//==============================================================================
// KDBConnectionManager (C++23 Modernized Edition)
// - RAII ODBC Handle Management (`UniqueSqlEnv`, `UniqueSqlDbc`, `UniqueSqlStmt`)
// - Remote Linux VPS MSSQL Optimization (TLS, Keep-Alive, Timeouts)
// - Strictly Type-Safe Parameterized Queries (`SQLPrepareW` + `SQLBindParameter`)
// - Explicit Dual-Endpoint Failover State Machine (Primary Linux VPS -> Fallback)
//==============================================================================
class KDBConnectionManager
{
public:
    struct FailoverTelemetry
    {
        knc::db::FailoverState  currentState        = knc::db::FailoverState::Disconnected;
        uint64_t                totalQueries        = 0;
        uint64_t                failoverCount       = 0;
        uint64_t                primaryRecoveries   = 0;
    };

    KDBConnectionManager();
    KDBConnectionManager(
        std::wstring_view primaryLinuxVpsConnStr,
        std::wstring_view fallbackConnStr,
        const knc::db::LinuxVpsConnectionOptions& options = {} );
    virtual ~KDBConnectionManager();

    KDBConnectionManager( const KDBConnectionManager& ) = delete;
    KDBConnectionManager& operator=( const KDBConnectionManager& ) = delete;

    //--------------------------------------------------------------------------
    // 1. Endpoint & Remote Linux VPS Configuration
    //--------------------------------------------------------------------------
    void SetEndpoints(
        std::wstring_view primaryLinuxVpsConnStr,
        std::wstring_view fallbackConnStr = {} );

    void SetConnectionOptions( const knc::db::LinuxVpsConnectionOptions& options ) noexcept;
    void SetPrimaryRecoveryCooldown( std::chrono::seconds cooldown ) noexcept;

    [[nodiscard]] knc::db::FailoverState GetState() const noexcept
    {
        return m_state.load( std::memory_order_acquire );
    }

    [[nodiscard]] FailoverTelemetry GetTelemetry() const noexcept;

    //--------------------------------------------------------------------------
    // 2. Explicit Connection & Failover State Machine Operations
    //--------------------------------------------------------------------------
    [[nodiscard]] std::expected< void, knc::db::DbError > Connect();
    [[nodiscard]] std::expected< void, knc::db::DbError > FailoverToSecondary( const knc::db::DbError& cause );
    [[nodiscard]] std::optional< knc::db::DbError > TryRestorePrimaryIfReady();
    void Disconnect() noexcept;

    //--------------------------------------------------------------------------
    // 3. Modern C++23 Parameterized Query & Decryption API (`std::expected`)
    //--------------------------------------------------------------------------
    [[nodiscard]] std::expected< std::vector< KDBConnectionInfo >, knc::db::DbError >
    FetchManagedConnectionInfos(
        int32_t serverType,
        std::wstring_view primaryConnStr,
        std::wstring_view fallbackConnStr = {},
        bool isRawConnString = true );

    [[nodiscard]] static std::expected< std::wstring, knc::db::DbError >
    DecryptConnectionPayload( std::wstring_view encryptedPayload );

    [[nodiscard]] static std::expected< std::string, knc::db::DbError >
    EncryptConnectionPayload( std::string_view plainPayload );

    //--------------------------------------------------------------------------
    // 4. Legacy 2014 Facade (Preserved for 100% KDBLayer Source Compatibility)
    //--------------------------------------------------------------------------
    bool GetDBConnectionInfoFromManagerDB(
        IN const int iServerType,
        IN const wchar_t* szConnStr,
        IN const bool bDBConnStr,
        OUT std::vector< KDBConnectionInfo >& vecDBConnectionInfo );

    bool DecryptDBString(
        IN const std::wstring& wstrDBString,
        OUT std::wstring& wstrDecryptString );

private:
    [[nodiscard]] std::expected< void, knc::db::DbError > ConnectEndpointLocked(
        std::wstring_view connStr,
        knc::db::FailoverState targetState );

    [[nodiscard]] std::expected< std::vector< KDBConnectionInfo >, knc::db::DbError >
    ExecuteManagerInfoQueryLocked( int32_t serverType );

    mutable std::shared_mutex                   m_mutex;
    knc::db::UniqueSqlEnv                       m_upEnv;
    knc::db::UniqueSqlDbc                       m_upDbc;
    knc::db::UniqueSqlStmt                      m_upStmt;

    std::wstring                                m_wstrPrimaryEndpoint;
    std::wstring                                m_wstrFallbackEndpoint;
    bool                                        m_bIsRawConnectionString = true;
    knc::db::LinuxVpsConnectionOptions          m_options;

    std::atomic< knc::db::FailoverState >       m_state{ knc::db::FailoverState::Disconnected };
    std::chrono::steady_clock::time_point       m_lastFailoverTimestamp{};
    std::chrono::seconds                        m_primaryRecoveryCooldown{ 60 };

    std::atomic< uint64_t >                     m_totalQueries{ 0 };
    std::atomic< uint64_t >                     m_failoverCount{ 0 };
    std::atomic< uint64_t >                     m_primaryRecoveries{ 0 };
};
