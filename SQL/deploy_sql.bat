@echo off
setlocal EnableExtensions

:: ============================================================================
:: Elsword SQL Server 2017 - 2025 Database Deployment Script
:: Supports Windows MSSQL (Local / Named Instance) & Remote Linux VPS MSSQL
:: Usage:
::   deploy_sql.bat                              (Windows Auth on localhost)
::   deploy_sql.bat <ServerIP,1433> <User> <Pwd> (SQL Auth on Remote Linux VPS)
:: ============================================================================

set "SQL_DIR=%~dp0"
set "SERVER_INSTANCE=%~1"
set "DB_USER=%~2"
set "DB_PASS=%~3"

if "%SERVER_INSTANCE%"=="" set "SERVER_INSTANCE=localhost"

where sqlcmd >nul 2>&1
if errorlevel 1 (
    echo [ERROR] 'sqlcmd' utility was not found in PATH.
    echo         Install Microsoft Command Line Utilities for SQL Server ^(mssql-tools18^).
    exit /b 1
)

echo ===============================================================================
echo        Elsword SQL Server 2017 - 2025 Schema Deployment Pipeline
echo ===============================================================================
echo [*] Target Server: %SERVER_INSTANCE%

set "AUTH_ARGS=-E -C"
if not "%DB_USER%"=="" (
    set "AUTH_ARGS=-U "%DB_USER%" -P "%DB_PASS%" -C"
    echo [*] Auth Mode:     SQL Server Authentication [%DB_USER%]
) else (
    echo [*] Auth Mode:     Trusted Windows Authentication [-E]
)
echo.

for %%S in (Account.sql Game01.sql ES_BILLING.sql Statistics.sql) do (
    echo [>] Deploying %%S ...
    sqlcmd -S "%SERVER_INSTANCE%" %AUTH_ARGS% -f 65001 -i "%SQL_DIR%%%S" -b
    if errorlevel 1 (
        echo [FAILED] Error occurred while executing %%S
        exit /b 1
    )
    echo [OK] %%S deployed successfully.
    echo.
)

echo ===============================================================================
echo [SUCCESS] All 4 databases [Account, Game01, ES_BILLING, Statistics] deployed!
echo ===============================================================================
exit /b 0
