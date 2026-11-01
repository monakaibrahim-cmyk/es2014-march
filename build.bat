@echo off
setlocal EnableDelayedExpansion

title Elsword 2014 - Modern Build Pipeline [VS 2026 / C++23 / DX12]
echo ===============================================================================
echo            Elsword 2014 Build Pipeline [VS 2026 / C++23 / DX12]
echo ===============================================================================

set "REPO_ROOT=%~dp0"
if "%REPO_ROOT:~-1%"=="\" set "REPO_ROOT=%REPO_ROOT:~0,-1%"

set "SOLUTION=%REPO_ROOT%\JP_TW_EU_CN_US\Trunk\X2Project_2010.sln"

:: -----------------------------------------------------------------------------
:: 1. Parse Arguments (Target, Configuration, Action)
:: -----------------------------------------------------------------------------
set "TARGET=all"
set "CONFIG=Release"
set "IS_REBUILD=0"
set "SKIP_STAGE=0"
set "CHECK_ONLY=0"

:parse_args
if "%~1"=="" goto after_args

if /i "%~1"=="/check" (
    set "CHECK_ONLY=1"
    shift
    goto parse_args
)
if /i "%~1"=="check" (
    set "CHECK_ONLY=1"
    shift
    goto parse_args
)

if /i "%~1"=="debug" (
    set "CONFIG=Debug"
    shift
    goto parse_args
)
if /i "%~1"=="release" (
    set "CONFIG=Release"
    shift
    goto parse_args
)
if /i "%~1"=="/rebuild" (
    set "IS_REBUILD=1"
    shift
    goto parse_args
)
if /i "%~1"=="-rebuild" (
    set "IS_REBUILD=1"
    shift
    goto parse_args
)
if /i "%~1"=="rebuild" (
    set "IS_REBUILD=1"
    shift
    goto parse_args
)
if /i "%~1"=="/nostage" (
    set "SKIP_STAGE=1"
    shift
    goto parse_args
)
if /i "%~1"=="client" (
    set "TARGET=client"
    shift
    goto parse_args
)
if /i "%~1"=="server" (
    set "TARGET=server"
    shift
    goto parse_args
)
if /i "%~1"=="all" (
    set "TARGET=all"
    shift
    goto parse_args
)
if /i "%~1"=="login" (
    set "TARGET=login"
    shift
    goto parse_args
)
if /i "%~1"=="center" (
    set "TARGET=center"
    shift
    goto parse_args
)
if /i "%~1"=="channel" (
    set "TARGET=channel"
    shift
    goto parse_args
)
if /i "%~1"=="global" (
    set "TARGET=global"
    shift
    goto parse_args
)
if /i "%~1"=="game" (
    set "TARGET=game"
    shift
    goto parse_args
)

echo [!] Unknown argument: %~1
echo Usage: build.bat [all^|client^|server^|login^|center^|channel^|global^|game] [Release^|Debug] [/rebuild] [/nostage]
exit /b 1

:after_args

set "ACTION_NAME=Build"
if "%IS_REBUILD%"=="1" set "ACTION_NAME=Rebuild"

echo [*] Target:        %TARGET%
echo [*] Configuration: %CONFIG%^|Win32
echo [*] Action:        %ACTION_NAME%
echo.

:: -----------------------------------------------------------------------------
:: 2. Locate Visual Studio Installation & MSBuild.exe
:: -----------------------------------------------------------------------------
set "MSBUILD_EXE="
set "VS_INSTALL_DIR="

set "VSWHERE=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
if not exist "%VSWHERE%" set "VSWHERE=%ProgramFiles%\Microsoft Visual Studio\Installer\vswhere.exe"

if exist "%VSWHERE%" (
    for /f "usebackq tokens=*" %%i in (`"%VSWHERE%" -latest -products * -requires Microsoft.Component.MSBuild -property installationPath 2^>nul`) do (
        if exist "%%i" set "VS_INSTALL_DIR=%%i"
    )
    for /f "usebackq tokens=*" %%i in (`"%VSWHERE%" -latest -products * -requires Microsoft.Component.MSBuild -find MSBuild\**\Bin\amd64\MSBuild.exe 2^>nul`) do (
        if exist "%%i" set "MSBUILD_EXE=%%i"
    )
    if not defined MSBUILD_EXE (
        for /f "usebackq tokens=*" %%i in (`"%VSWHERE%" -latest -products * -requires Microsoft.Component.MSBuild -find MSBuild\**\Bin\MSBuild.exe 2^>nul`) do (
            if exist "%%i" set "MSBUILD_EXE=%%i"
        )
    )
)

if not defined MSBUILD_EXE (
    if exist "C:\Program Files\Microsoft Visual Studio\18\Professional\MSBuild\Current\Bin\amd64\MSBuild.exe" (
        set "VS_INSTALL_DIR=C:\Program Files\Microsoft Visual Studio\18\Professional"
        set "MSBUILD_EXE=C:\Program Files\Microsoft Visual Studio\18\Professional\MSBuild\Current\Bin\amd64\MSBuild.exe"
    ) else if exist "C:\Program Files\Microsoft Visual Studio\18\Community\MSBuild\Current\Bin\amd64\MSBuild.exe" (
        set "VS_INSTALL_DIR=C:\Program Files\Microsoft Visual Studio\18\Community"
        set "MSBUILD_EXE=C:\Program Files\Microsoft Visual Studio\18\Community\MSBuild\Current\Bin\amd64\MSBuild.exe"
    ) else if exist "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\MSBuild\Current\Bin\amd64\MSBuild.exe" (
        set "VS_INSTALL_DIR=C:\Program Files\Microsoft Visual Studio\2022\Enterprise"
        set "MSBUILD_EXE=C:\Program Files\Microsoft Visual Studio\2022\Enterprise\MSBuild\Current\Bin\amd64\MSBuild.exe"
    ) else if exist "C:\Program Files\Microsoft Visual Studio\2022\Professional\MSBuild\Current\Bin\amd64\MSBuild.exe" (
        set "VS_INSTALL_DIR=C:\Program Files\Microsoft Visual Studio\2022\Professional"
        set "MSBUILD_EXE=C:\Program Files\Microsoft Visual Studio\2022\Professional\MSBuild\Current\Bin\amd64\MSBuild.exe"
    ) else if exist "C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\amd64\MSBuild.exe" (
        set "VS_INSTALL_DIR=C:\Program Files\Microsoft Visual Studio\2022\Community"
        set "MSBUILD_EXE=C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\amd64\MSBuild.exe"
    )
)

:: -----------------------------------------------------------------------------
:: 3. Pre-Flight Dependency & Visual Studio Installer Component Check
:: -----------------------------------------------------------------------------
echo [*] Running Pre-Flight Dependency ^& Toolchain Check...
set "DEP_MISSING=0"

:: Check 3.1: Visual Studio & MSBuild
if not defined MSBUILD_EXE (
    echo.
    echo [MISSING DEPENDENCY] Visual Studio 2026 / 2022 MSBuild.exe not found!
    echo   -^> Action Required: Install Visual Studio 2026 ^(or 2022^) via Visual Studio Installer
    echo      and select the "Desktop development with C++" workload.
    set "DEP_MISSING=1"
) else (
    echo   [OK] MSBuild:       "%MSBUILD_EXE%"
)

:: Check 3.2: MSVC x86 C++ Compiler (cl.exe) & C++ MFC/ATL (afxwin.h, mfc140u.lib)
set "FOUND_CL=0"
set "FOUND_MFC=0"
if defined VS_INSTALL_DIR (
    for /d %%V in ("%VS_INSTALL_DIR%\VC\Tools\MSVC\*") do (
        if exist "%%V\bin\Hostx64\x86\cl.exe" set "FOUND_CL=1"
        if exist "%%V\bin\Hostx86\x86\cl.exe" set "FOUND_CL=1"
        if exist "%%V\atlmfc\include\afxwin.h" if exist "%%V\atlmfc\lib\x86\mfc140u.lib" set "FOUND_MFC=1"
    )
)

if "%FOUND_CL%"=="0" (
    echo.
    echo [MISSING DEPENDENCY] MSVC C++ x86/x64 Build Tools ^(cl.exe^) not found!
    echo   -^> Action Required in Visual Studio Installer ^(Modify -^> Individual Components^):
    echo      [x] MSVC v145 - VS 2026 C++ x64/x86 build tools ^(or MSVC v143 for VS 2022^)
    set "DEP_MISSING=1"
) else (
    echo   [OK] MSVC x86 C++ Compiler ^(cl.exe^)
)

if "%FOUND_MFC%"=="0" (
    echo.
    echo [MISSING DEPENDENCY] Visual Studio C++ MFC / ATL for x86 ^(afxwin.h / mfc140u.lib^) not found!
    echo   -^> Action Required in Visual Studio Installer ^(Modify -^> Individual Components^):
    echo      [x] C++ MFC for latest v145 build tools ^(x86 ^& x64^)   ^[or v143 for VS 2022^]
    echo      [x] C++ ATL for latest v145 build tools ^(x86 ^& x64^)   ^[or v143 for VS 2022^]
    set "DEP_MISSING=1"
) else (
    echo   [OK] C++ MFC ^& ATL x86 Libraries ^(afxwin.h, mfc140u.lib^)
)

:: Check 3.3: Windows 10/11 SDK
set "FOUND_WINSDK=0"
set "WINSDK_BASE=%ProgramFiles(x86)%\Windows Kits\10\Include"
if exist "%WINSDK_BASE%" (
    for /d %%S in ("%WINSDK_BASE%\10.0.*") do (
        if exist "%%S\um\Windows.h" if exist "%%S\um\d3d12.h" set "FOUND_WINSDK=1"
    )
)
if "%FOUND_WINSDK%"=="0" (
    echo.
    echo [MISSING DEPENDENCY] Windows 10 / 11 SDK ^(Windows.h / d3d12.h / sqlext.h^) not found!
    echo   -^> Action Required in Visual Studio Installer ^(Modify -^> Individual Components^):
    echo      [x] Windows 11 SDK ^(10.0.26100.0^) ^(or latest Windows 10/11 SDK^)
    set "DEP_MISSING=1"
) else (
    echo   [OK] Windows 10/11 SDK ^(Windows.h, d3d11.h, d3d12.h, sqlext.h^)
)

:: Check 3.4: DirectX SDK (June 2010) - Prefer bundled ExternalLib\DirectX_SDK_June2010 or system install
if not defined DXSDK_DIR (
    set "DXSDK_DIR=%REPO_ROOT%\ExternalLib\DirectX_SDK_June2010\"
)
if "%DXSDK_DIR:~-1%" NEQ "\" set "DXSDK_DIR=%DXSDK_DIR%\"
if not exist "%DXSDK_DIR%Include\d3dx9.h" (
    if exist "%REPO_ROOT%\ExternalLib\DirectX_SDK_June2010\Include\d3dx9.h" (
        set "DXSDK_DIR=%REPO_ROOT%\ExternalLib\DirectX_SDK_June2010\"
    ) else if exist "C:\Program Files (x86)\Microsoft DirectX SDK (June 2010)\Include\d3dx9.h" (
        set "DXSDK_DIR=C:\Program Files (x86)\Microsoft DirectX SDK (June 2010)\"
    )
)
if not exist "%DXSDK_DIR%Include\d3dx9.h" (
    echo.
    echo [MISSING DEPENDENCY] Microsoft DirectX SDK ^(June 2010^) not found at "%DXSDK_DIR%"!
    echo   -^> Action Required:
    echo      1. Ensure ExternalLib\DirectX_SDK_June2010 is present in the repository, OR
    echo      2. Install "Microsoft DirectX SDK (June 2010)" ^(DXSDK_Jun10.exe^).
    set "DEP_MISSING=1"
) else (
    echo   [OK] DirectX SDK:   "%DXSDK_DIR%"
)

:: Check 3.5: vcpkg x86-windows packages (zlib, libpng) - Prefer bundled ExternalLib\vcpkg_x86-windows or system install
if not defined VCPKG_INSTALLED_DIR (
    set "VCPKG_INSTALLED_DIR=%REPO_ROOT%\ExternalLib\vcpkg_x86-windows"
)
if not exist "%VCPKG_INSTALLED_DIR%\include\zlib.h" (
    if exist "%REPO_ROOT%\ExternalLib\vcpkg_x86-windows\include\zlib.h" (
        set "VCPKG_INSTALLED_DIR=%REPO_ROOT%\ExternalLib\vcpkg_x86-windows"
    ) else if defined VCPKG_INSTALLATION_ROOT if exist "%VCPKG_INSTALLATION_ROOT%\installed\x86-windows\include\zlib.h" (
        set "VCPKG_INSTALLED_DIR=%VCPKG_INSTALLATION_ROOT%\installed\x86-windows"
    ) else if exist "C:\vcpkg\installed\x86-windows\include\zlib.h" (
        set "VCPKG_INSTALLED_DIR=C:\vcpkg\installed\x86-windows"
    )
)
if not exist "%VCPKG_INSTALLED_DIR%\include\zlib.h" (
    echo.
    echo [MISSING DEPENDENCY] vcpkg x86-windows libraries ^(zlib, libpng^) not found in "%VCPKG_INSTALLED_DIR%"!
    echo   -^> Action Required: Ensure ExternalLib\vcpkg_x86-windows is present, or run:
    echo      vcpkg install zlib:x86-windows libpng:x86-windows
    set "DEP_MISSING=1"
) else (
    echo   [OK] vcpkg x86:     "%VCPKG_INSTALLED_DIR%"
)

:: Check 3.6: Boost C++ Libraries - Prefer bundled ExternalLib\Boost or system install
if not defined BOOST_DIR (
    set "BOOST_DIR=%REPO_ROOT%\ExternalLib\Boost\"
)
if defined BOOST_DIR if "%BOOST_DIR:~-1%" NEQ "\" set "BOOST_DIR=%BOOST_DIR%\"
if not exist "%BOOST_DIR%boost\version.hpp" (
    if exist "%REPO_ROOT%\ExternalLib\Boost\boost\version.hpp" (
        set "BOOST_DIR=%REPO_ROOT%\ExternalLib\Boost\"
    ) else if exist "C:\local\boost_1_92_0\boost\version.hpp" (
        set "BOOST_DIR=C:\local\boost_1_92_0\"
    ) else (
        for /d %%B in ("C:\local\boost_*") do (
            if exist "%%B\boost\version.hpp" set "BOOST_DIR=%%B\"
        )
    )
)
if not exist "%BOOST_DIR%boost\version.hpp" (
    echo.
    echo [MISSING DEPENDENCY] Boost C++ Libraries not found!
    echo   -^> Action Required:
    echo      1. Ensure ExternalLib\Boost is present in the repository, OR
    echo      2. Set BOOST_DIR=C:\path\to\boost\ before running build.bat.
    set "DEP_MISSING=1"
) else (
    echo   [OK] Boost Dir:     "%BOOST_DIR%"
)

if "%DEP_MISSING%"=="1" (
    echo.
    echo ===============================================================================
    echo [ERROR] Build aborted due to missing dependencies listed above.
    echo         Please install the missing components and re-run build.bat.
    echo ===============================================================================
    exit /b 1
)
echo.

if "%CHECK_ONLY%"=="1" (
    echo ===============================================================================
    echo [SUCCESS] All Visual Studio and ExternalLib dependencies verified!
    echo ===============================================================================
    exit /b 0
)

:: -----------------------------------------------------------------------------
:: 4. Execute Build Targets
:: -----------------------------------------------------------------------------
set "TRUNK_DIR=%REPO_ROOT%\JP_TW_EU_CN_US\Trunk"
set "MSBUILD_FLAGS=/p:Configuration=%CONFIG% /p:Platform=Win32 /p:BOOST_DIR="%BOOST_DIR%\" /p:DXSDK_DIR="%DXSDK_DIR%\" /p:VCPKG_INSTALLED_DIR="%VCPKG_INSTALLED_DIR%" /m /v:m /nologo"
set "BUILD_FAILED=0"

:: Build prerequisite static libraries if /rebuild was requested or if static libs are missing
set "NEED_PREREQS=0"
if "%IS_REBUILD%"=="1" set "NEED_PREREQS=1"
if not exist "%TRUNK_DIR%\KNCSDK\lib_2010\KncSecurity71MD.lib" set "NEED_PREREQS=1"
if not exist "%TRUNK_DIR%\KTDXLIB\CxImage.lib" set "NEED_PREREQS=1"
if not exist "%TRUNK_DIR%\X2Lib\X2ServerProtocol.lib" set "NEED_PREREQS=1"

if "%NEED_PREREQS%"=="1" (
    echo [^>] Building Prerequisite Static Libraries ^(KNCSDK, CxImage, LuaJIT, X2ServerProtocol^)...
    if not exist "%TRUNK_DIR%\luajitLib\LuaJIT-2.0.2\src\lj_vm.obj" (
        if defined VS_INSTALL_DIR if exist "%VS_INSTALL_DIR%\VC\Auxiliary\Build\vcvars32.bat" (
            echo [^>] Generating LuaJIT x86 VM object ^(lj_vm.obj^)...
            cmd /c "call "%VS_INSTALL_DIR%\VC\Auxiliary\Build\vcvars32.bat" >nul && cd /d "%TRUNK_DIR%\luajitLib\LuaJIT-2.0.2\src" && call msvcbuild.bat lj_vm >nul"
        )
    )
    for %%P in (
        "%TRUNK_DIR%\luaLib\luaLib_2010.vcxproj"
        "%TRUNK_DIR%\libxml\libxml_2010.vcxproj"
        "%TRUNK_DIR%\KNCSDK\KncSerialize71\KncSerialize_2010.vcxproj"
        "%TRUNK_DIR%\KNCSDK\KncSecurity71\KncSecurity_2010.vcxproj"
        "%TRUNK_DIR%\KNCSDK\KncDebug\KncDebug_2010.vcxproj"
        "%TRUNK_DIR%\cximage\jpeg\jpeg_2010.vcxproj"
        "%TRUNK_DIR%\cximage\CxImage\cximage_2010.vcxproj"
        "%TRUNK_DIR%\luajitLib\luajitLib.vcxproj"
        "%TRUNK_DIR%\X2ServerProtocol\X2ServerProtocol_2010.vcxproj"
    ) do (
        if "%IS_REBUILD%"=="1" (
            "%MSBUILD_EXE%" "%%~P" %MSBUILD_FLAGS% /t:Rebuild
        ) else (
            "%MSBUILD_EXE%" "%%~P" %MSBUILD_FLAGS% /t:Build
        )
        if errorlevel 1 (
            set "BUILD_FAILED=1"
            goto build_done
        )
    )
    if exist "%TRUNK_DIR%\KTDXLIB\luaLib.lib" (
        copy /Y "%TRUNK_DIR%\KTDXLIB\luaLib.lib" "%TRUNK_DIR%\KNCSDK\lib_2010\KncLua71MD.lib" >nul
        copy /Y "%TRUNK_DIR%\KTDXLIB\luaLib.lib" "%TRUNK_DIR%\KNCSDK\lib_2010\KncLua71MDd.lib" >nul
    )
)

if /i "%TARGET%"=="all" goto do_all
if /i "%TARGET%"=="client" goto do_client
if /i "%TARGET%"=="server" goto do_server
if /i "%TARGET%"=="login" goto do_login
if /i "%TARGET%"=="center" goto do_center
if /i "%TARGET%"=="channel" goto do_channel
if /i "%TARGET%"=="global" goto do_global
if /i "%TARGET%"=="game" goto do_game
goto do_all

:do_all
echo [^>] Building Server Cluster: Login, Center, Channel, Global, Game...
if "%IS_REBUILD%"=="1" (
    "%MSBUILD_EXE%" "%SOLUTION%" %MSBUILD_FLAGS% /t:LoginServer:Rebuild;CenterServer:Rebuild;ChannelServer:Rebuild;GlobalServer:Rebuild;GameServer:Rebuild
) else (
    "%MSBUILD_EXE%" "%SOLUTION%" %MSBUILD_FLAGS% /t:LoginServer;CenterServer;ChannelServer;GlobalServer;GameServer
)
if errorlevel 1 (
    set "BUILD_FAILED=1"
    goto build_done
)
goto do_client

:do_client
set "NEED_CLIENT_LIBS=0"
if "%IS_REBUILD%"=="1" set "NEED_CLIENT_LIBS=1"
if not exist "%TRUNK_DIR%\KTDXLIB\KTDXLIB.lib" set "NEED_CLIENT_LIBS=1"
if not exist "%TRUNK_DIR%\X2Lib\X2Lib.lib" set "NEED_CLIENT_LIBS=1"

if "%NEED_CLIENT_LIBS%"=="1" (
    echo [^>] Building Client Static Libraries ^(KTDXLIB, X2Lib^)...
    if "%IS_REBUILD%"=="1" (
        "%MSBUILD_EXE%" "%SOLUTION%" %MSBUILD_FLAGS% /t:KTDXLIB:Rebuild
        if errorlevel 1 ( set "BUILD_FAILED=1" & goto build_done )
        "%MSBUILD_EXE%" "%SOLUTION%" %MSBUILD_FLAGS% /t:X2Lib:Rebuild
        if errorlevel 1 ( set "BUILD_FAILED=1" & goto build_done )
    ) else (
        "%MSBUILD_EXE%" "%SOLUTION%" %MSBUILD_FLAGS% /t:KTDXLIB
        if errorlevel 1 ( set "BUILD_FAILED=1" & goto build_done )
        "%MSBUILD_EXE%" "%SOLUTION%" %MSBUILD_FLAGS% /t:X2Lib
        if errorlevel 1 ( set "BUILD_FAILED=1" & goto build_done )
    )
)

echo [^>] Building Client: X2.exe...
if "%IS_REBUILD%"=="1" (
    "%MSBUILD_EXE%" "%SOLUTION%" %MSBUILD_FLAGS% /t:X2:Rebuild
) else (
    "%MSBUILD_EXE%" "%SOLUTION%" %MSBUILD_FLAGS% /t:X2
)
if errorlevel 1 set "BUILD_FAILED=1"
goto build_done

:do_server
echo [^>] Building Server Cluster: Login, Center, Channel, Global, Game...
if "%IS_REBUILD%"=="1" (
    "%MSBUILD_EXE%" "%SOLUTION%" %MSBUILD_FLAGS% /t:LoginServer:Rebuild;CenterServer:Rebuild;ChannelServer:Rebuild;GlobalServer:Rebuild;GameServer:Rebuild
) else (
    "%MSBUILD_EXE%" "%SOLUTION%" %MSBUILD_FLAGS% /t:LoginServer;CenterServer;ChannelServer;GlobalServer;GameServer
)
if errorlevel 1 set "BUILD_FAILED=1"
goto build_done

:do_login
echo [^>] Building LoginServer.exe...
if "%IS_REBUILD%"=="1" (
    "%MSBUILD_EXE%" "%SOLUTION%" %MSBUILD_FLAGS% /t:LoginServer:Rebuild
) else (
    "%MSBUILD_EXE%" "%SOLUTION%" %MSBUILD_FLAGS% /t:LoginServer
)
if errorlevel 1 set "BUILD_FAILED=1"
goto build_done

:do_center
echo [^>] Building CenterServer.exe...
if "%IS_REBUILD%"=="1" (
    "%MSBUILD_EXE%" "%SOLUTION%" %MSBUILD_FLAGS% /t:CenterServer:Rebuild
) else (
    "%MSBUILD_EXE%" "%SOLUTION%" %MSBUILD_FLAGS% /t:CenterServer
)
if errorlevel 1 set "BUILD_FAILED=1"
goto build_done

:do_channel
echo [^>] Building ChannelServer.exe...
if "%IS_REBUILD%"=="1" (
    "%MSBUILD_EXE%" "%SOLUTION%" %MSBUILD_FLAGS% /t:ChannelServer:Rebuild
) else (
    "%MSBUILD_EXE%" "%SOLUTION%" %MSBUILD_FLAGS% /t:ChannelServer
)
if errorlevel 1 set "BUILD_FAILED=1"
goto build_done

:do_global
echo [^>] Building GlobalServer.exe...
if "%IS_REBUILD%"=="1" (
    "%MSBUILD_EXE%" "%SOLUTION%" %MSBUILD_FLAGS% /t:GlobalServer:Rebuild
) else (
    "%MSBUILD_EXE%" "%SOLUTION%" %MSBUILD_FLAGS% /t:GlobalServer
)
if errorlevel 1 set "BUILD_FAILED=1"
goto build_done

:do_game
echo [^>] Building GameServer.exe...
if "%IS_REBUILD%"=="1" (
    "%MSBUILD_EXE%" "%SOLUTION%" %MSBUILD_FLAGS% /t:GameServer:Rebuild
) else (
    "%MSBUILD_EXE%" "%SOLUTION%" %MSBUILD_FLAGS% /t:GameServer
)
if errorlevel 1 set "BUILD_FAILED=1"
goto build_done

:build_done
echo.
if "%BUILD_FAILED%"=="1" (
    echo ===============================================================================
    echo [FAILED] Build finished with errors.
    echo ===============================================================================
    exit /b 1
)

echo ===============================================================================
echo [SUCCESS] Build completed successfully!
echo ===============================================================================
echo.
if "%SKIP_STAGE%"=="0" if exist "%REPO_ROOT%\stage_deploy.py" (
    python "%REPO_ROOT%\stage_deploy.py"
    echo.
)
echo Binary Status Report:
call :report_binary "Client (x2.exe)"      "%REPO_ROOT%\JP_TW_EU_CN_US\Trunk\X2\%CONFIG%\x2.exe"
call :report_binary "LoginServer.exe"      "%REPO_ROOT%\JP_TW_EU_CN_US\Trunk\KncWX2Server\LoginServer\%CONFIG%\LoginServer.exe"
call :report_binary "CenterServer.exe"     "%REPO_ROOT%\JP_TW_EU_CN_US\Trunk\KncWX2Server\CenterServer\%CONFIG%\CenterServer.exe"
call :report_binary "ChannelServer.exe"    "%REPO_ROOT%\JP_TW_EU_CN_US\Trunk\KncWX2Server\ChannelServer\%CONFIG%\ChannelServer.exe"
call :report_binary "GlobalServer.exe"     "%REPO_ROOT%\JP_TW_EU_CN_US\Trunk\KncWX2Server\GlobalServer\%CONFIG%\GlobalServer.exe"
call :report_binary "GameServer.exe"       "%REPO_ROOT%\JP_TW_EU_CN_US\Trunk\KncWX2Server\GameServer\%CONFIG%\GameServer.exe"
echo.
exit /b 0

:report_binary
set "BNAME=%~1"
set "BPATH=%~2"
if exist "%BPATH%" (
    for %%F in ("%BPATH%") do echo   [OK] !BNAME! : %%~zF bytes  Updated: %%~tF
) else (
    echo   [--] !BNAME! : Not built in %CONFIG%
)
exit /b 0
