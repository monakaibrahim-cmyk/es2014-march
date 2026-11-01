@echo off
setlocal
echo ===============================================================================
echo          Elsword 2014 - Post-Build Binary ^& Runtime Staging Script
echo ===============================================================================
python "%~dp0stage_deploy.py"
if errorlevel 1 (
    echo [ERROR] Staging script failed.
    exit /b 1
)
exit /b 0
