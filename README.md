# Elsword 2014 (March) — Modernized C++23 & DirectX 9/11/12 Source

[![Test Build (development)](https://github.com/monakaibrahim-cmyk/es2014-march/actions/workflows/build-test.yml/badge.svg?branch=development)](https://github.com/monakaibrahim-cmyk/es2014-march/actions/workflows/build-test.yml)

Modernized client (`X2.exe`) and 5-daemon server cluster (`CenterServer`, `ChannelServer`, `GameServer`, `GlobalServer`, `LoginServer`) upgraded for **Visual Studio 2022 (`v143`)** and **Visual Studio 2026 (`v145`)** with:

- **Self-Contained External SDKs (`ExternalLib\`)**: Bundled DirectX SDK (June 2010), Boost C++ headers, and 32-bit `zlib`/`libpng`/`libxml2` (`vcpkg_x86-windows`) so fresh clones build out-of-the-box without installing legacy third-party SDKs.
- **Modern C++23 (`std:c++latest`) & RAII ODBC Layer**: Replaces legacy `.dsn` files with centralized DSN-less ODBC connection management (`KDBConnectionManager` + `ServerResource\DBConfig.lua`) supporting automatic primary/fallback MSSQL failover and Linux VPS SQL Server 2019/2022/2025.
- **Tri-Backend Rendering Engine**: Native `D3D9` (`DX9`), `D3D9On12` (`DX12`), and `DXVK` (`DX11`) runtime selection via `RendererBackend = "DX12" | "DX11" | "DX9"` in `GameOptions.lua`.
- **Single-Region Unified Codebase (`SERVICE_GLOBAL`)**: Consolidated region macro architecture across all client and server projects.
- **Automated Build & Post-Build Staging**: One-command build (`build.bat`) with pre-flight Visual Studio Installer dependency checks and automated runtime staging (`stage_deploy.py`).

---

## Quick Start (Clone & Build)

### 1. Required Visual Studio Installer Components
Open **Visual Studio Installer** -> **Modify** on Visual Studio 2022 or 2026, select the **Desktop development with C++** workload, and ensure these **Individual components** are checked:
- **MSVC v143 or v145 - VS C++ x64/x86 build tools**
- **C++ MFC for latest v143/v145 build tools (x86 & x64)** *(Required for 32-bit `afxwin.h` / `mfc140u.lib`)*
- **C++ ATL for latest v143/v145 build tools (x86 & x64)** *(Required for 32-bit `atlstr.h`)*
- **Windows 10 SDK** or **Windows 11 SDK**

> **No External SDK Installers Required:**
> DirectX SDK (June 2010) (`ExternalLib\DirectX_SDK_June2010`), Boost C++ headers (`ExternalLib\Boost`), and 32-bit `zlib`/`libpng` (`ExternalLib\vcpkg_x86-windows`) are pre-bundled directly in the repository and automatically detected by `build.bat` and `Directory.Build.props`.

### 2. Clone, Build & Stage Everything
```cmd
git clone -b development https://github.com/monakaibrahim-cmyk/es2014-march.git
cd es2014-march
build.bat
```
> `build.bat` automatically runs a pre-flight check (reporting any missing Visual Studio Installer components), builds all prerequisite static libraries, compiles the 5 server executables and `X2.exe` client, and stages the ready-to-run server cluster into `Deploy\ElSwordServer\`.

---

## Documentation

For complete instructions on:
- **SQL Server 2017–2025 Database Restore & Endpoint Stored Procedure (`sp_ConfigureServerEndpoints`)**
- **DSN-less `ServerResource\DBConfig.lua` Configuration**
- **Server Launch Order & Client Connection Setup**

See **[`SERVER_GUIDE.md`](SERVER_GUIDE.md)**.
