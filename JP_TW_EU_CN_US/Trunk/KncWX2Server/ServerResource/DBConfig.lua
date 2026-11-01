-- ============================================================================
-- Centralized Database Connection Manager Configuration (Option 2: DSN-less)
-- All 5 servers query [Account].[dbo].[MServerDBConnectionInfo] via dbo.temp_get_info
-- ============================================================================

-- Primary SQL Server / Linux VPS endpoint for the Manager DB ([Account])
-- Local Windows Auth default:
DB_MANAGER_PRIMARY_CONN = "DRIVER={ODBC Driver 18 for SQL Server};SERVER=127.0.0.1,1433;DATABASE=Account;Trusted_Connection=Yes;Encrypt=Optional;TrustServerCertificate=Yes;"

-- Remote Linux VPS SQL Auth example (uncomment and set your VPS IP & password):
-- DB_MANAGER_PRIMARY_CONN = "DRIVER={ODBC Driver 18 for SQL Server};SERVER=203.0.113.10,1433;DATABASE=Account;UID=sa;PWD=YourStrongPassword;Encrypt=Mandatory;TrustServerCertificate=Yes;"

-- Optional Secondary / Fallback SQL Server endpoint for automatic failover:
DB_MANAGER_FALLBACK_CONN = ""
