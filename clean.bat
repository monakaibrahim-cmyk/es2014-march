@echo off
setlocal EnableDelayedExpansion

title Elsword 2014 - Clean Workspace
echo ===============================================================================
echo                     Elsword 2014 Workspace Cleaner
echo ===============================================================================

set "REPO_ROOT=%~dp0"
if "%REPO_ROOT:~-1%"=="\" set "REPO_ROOT=%REPO_ROOT:~0,-1%"

cd /d "%REPO_ROOT%"

set "CLEAN_BINARIES=0"
if /i "%~1"=="/all" set "CLEAN_BINARIES=1"
if /i "%~1"=="all" set "CLEAN_BINARIES=1"
if /i "%~1"=="-all" set "CLEAN_BINARIES=1"

if "%CLEAN_BINARIES%"=="1" (
    echo [*] Mode: FULL CLEAN [Removing intermediate build files AND built binaries]
) else (
    echo [*] Mode: INTERMEDIATE CLEAN [Preserving final .exe binaries]
    echo     Tip: Run 'clean.bat /all' to also delete generated executables.
)
echo.
echo [*] Cleaning intermediate compiler artifacts...

:: Delete compiler intermediate files across workspace
del /s /f /q *.obj *.pch *.pdb *.ilk *.idb *.iobj *.ipdb *.map *.tlog *.lastcodeanalysissucceeded *.ncb *.suo *.user *.userosscache *.sln.docstates *.tmp *.bak *.orig 2>nul

:: Delete Visual Studio cache directories (.vs, ipch)
for /d /r %%d in (.vs ipch) do (
    if exist "%%d" (
        attrib -h -r -s "%%d" /s /d >nul 2>&1
        rd /s /q "%%d" 2>nul
    )
)

:: If full clean requested, remove generated executables in Release/Debug folders
if "%CLEAN_BINARIES%"=="1" (
    echo [*] Removing generated executables...
    del /s /f /q "%REPO_ROOT%\JP_TW_EU_CN_US\Trunk\X2\Release\*.exe" 2>nul
    del /s /f /q "%REPO_ROOT%\JP_TW_EU_CN_US\Trunk\X2\Debug\*.exe" 2>nul
    del /s /f /q "%REPO_ROOT%\JP_TW_EU_CN_US\Trunk\KncWX2Server\*\Release\*.exe" 2>nul
    del /s /f /q "%REPO_ROOT%\JP_TW_EU_CN_US\Trunk\KncWX2Server\*\Debug\*.exe" 2>nul
)

echo.
echo ===============================================================================
echo [SUCCESS] Workspace cleanup completed! Ready for Git / GitHub.
echo ===============================================================================
exit /b 0
