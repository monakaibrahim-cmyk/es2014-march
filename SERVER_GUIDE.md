# Elsword (March 2014) — Complete Clone, Build, Database & Runtime Guide

This document provides a complete end-to-end guide for cloning, building, deploying the SQL Server databases, and running the **Elsword (March 2014)** server suite and client modernized for **Visual Studio 2026 (`v145`) / Visual Studio 2022 (`v143`)**, **C++23 (`/std:c++latest`)**, **DirectX 12 (`D3D9On12`) / DirectX 11**, and **MS SQL Server 2017–2025** (Windows & Linux VPS).

---

## 1. Prerequisites & Zero-Setup Bundled SDKs (For Fresh Clones)

> [!TIP]
> **No DirectX SDK, Boost, or vcpkg Installation Required!**
> Fresh clones do **not** require installing the legacy Microsoft DirectX SDK (June 2010), Boost C++ Libraries, FreeType, or vcpkg. All required third-party headers, `.lib` import/static libraries, and runtime `.dll` files are **pre-bundled inside [`ExternalLib/`](file:///D:/ElSword/ExternalLib)** and automatically wired into [`build.bat`](file:///D:/ElSword/build.bat) and [`Directory.Build.props`](file:///D:/ElSword/JP_TW_EU_CN_US/Trunk/Directory.Build.props).

### 1.1 Visual Studio 2026 (`v145`) or Visual Studio 2022 (`v143`)
The **only** build tool you need to install on your machine is Visual Studio 2022 or 2026. Open **Visual Studio Installer** $\rightarrow$ **Modify** and enable:
- **Workload**:
  - `[x]` **Desktop development with C++**
- **Individual Components** *(Required — both Client and Server use 32-bit MFC/ATL and Win32 SDK)*:
  - `[x]` **MSVC v145 - VS 2026 C++ x64/x86 build tools** *(or MSVC v143 for VS 2022)*
  - `[x]` **C++ MFC for latest v145 build tools (x86 & x64)** *(or v143 for VS 2022 — provides `afxwin.h` and `mfc140u.lib`)*
  - `[x]` **C++ ATL for latest v145 build tools (x86 & x64)** *(or v143 for VS 2022 — provides `atlstr.h`)*
  - `[x]` **Windows 11 SDK (10.0.26100.0)** *(or latest Windows 10/11 SDK)*

### 1.2 Pre-Bundled SDKs Included in `ExternalLib\`
Both [`build.bat`](file:///D:/ElSword/build.bat) and [`Directory.Build.props`](file:///D:/ElSword/JP_TW_EU_CN_US/Trunk/Directory.Build.props) automatically resolve the following bundled SDKs inside the repository (even if your machine has no environment variables or has stale paths from old installations):

| Dependency | Bundled Repository Path | Contents | Optional Override Env Var |
| :--- | :--- | :--- | :--- |
| **DirectX SDK (June 2010)** | [`ExternalLib/DirectX_SDK_June2010/`](file:///D:/ElSword/ExternalLib/DirectX_SDK_June2010) | `Include\d3dx9*.h`, `dxerr.h`, `Lib\x86\d3dx9.lib`, `DxErr.lib`, `dxguid.lib` | `DXSDK_DIR` |
| **Boost C++ Headers** | [`ExternalLib/Boost/`](file:///D:/ElSword/ExternalLib/Boost) | Complete transitive closure of 9,784 `boost\*.hpp` headers used by Client & Server | `BOOST_DIR` |
| **vcpkg `x86-windows`** | [`ExternalLib/vcpkg_x86-windows/`](file:///D:/ElSword/ExternalLib/vcpkg_x86-windows) | 32-bit `zlib`, `libpng16`, and `libxml2` (`include\`, `lib\`, and `bin\*.dll`) | `VCPKG_INSTALLED_DIR` |
| **FreeType 2.4.11** | [`ExternalLib/freetype-2.4.11/`](file:///D:/ElSword/ExternalLib/freetype-2.4.11) | `include\ft2build.h` and `libs\freetype2411MT.lib` | `FREE_TYPE_DIR` |

> **Database Runtime Driver**: Install **Microsoft ODBC Driver 18 for SQL Server** (`msodbcsql.msi`) on the machine hosting the compiled server executables so [`KDBConnectionManager`](file:///D:/ElSword/JP_TW_EU_CN_US/Trunk/KncWX2Server/Common/DBConnectionManager.h) can establish TLS-encrypted ODBC connections to MS SQL Server 2017–2025.

---

## 2. Cloning & Building from Scratch

```bat
:: 1. Clone the repository (development branch)
git clone -b development https://github.com/monakaibrahim-cmyk/es2014-march.git
cd es2014-march

:: 2. (Optional) Run the Pre-Flight Dependency Check by itself
build.bat /check

:: 3. Build everything (Prerequisite static libs + Client + all 5 Servers) and auto-stage
build.bat

:: Or build specific targets:
build.bat server          :: Build all 5 servers (Login, Center, Channel, Global, Game)
build.bat client          :: Build X2.exe client only
build.bat center          :: Build CenterServer.exe only
build.bat all /rebuild    :: Full clean rebuild of all prerequisite libs, servers, and client

:: 4. (Optional) Clean intermediate .obj / .pch / .pdb / .tlog build artifacts
clean.bat
```

### How [`build.bat`](file:///D:/ElSword/build.bat) Makes Fresh Clones Foolproof
1. **Pre-Flight Dependency & Toolchain Check**: Before invoking `MSBuild.exe`, [`build.bat`](file:///D:/ElSword/build.bat) checks for Visual Studio 2022/2026, the x86 MSVC compiler (`cl.exe`), 32-bit MFC/ATL libraries (`afxwin.h`, `mfc140u.lib`), the Windows 10/11 SDK, and the bundled `ExternalLib\` SDKs. If any Visual Studio component is missing, it stops immediately and prints the exact component names to check in **Visual Studio Installer**.
2. **Automatic Prerequisite Static Library Compilation**: On a fresh clone (when `KNCSDK\lib_2010\KncSecurity71MD.lib` is not yet built) or when `/rebuild` is passed, [`build.bat`](file:///D:/ElSword/build.bat) automatically builds all 9 internal static libraries (`luaLib`, `libxml`, `KncSerialize`, `KncSecurity`, `KncDebug`, `jpeg`, `CxImage`, `luajitLib`, `X2ServerProtocol`) with your exact MSVC toolset (`v143` or `v145`) before building the servers and client—preventing any MSVC linker version mismatch (`LNK1262`).
3. **Automatic Post-Build Staging ([`stage_deploy.bat`](file:///D:/ElSword/stage_deploy.bat) / [`stage_deploy.py`](file:///D:/ElSword/stage_deploy.py))**:
   - **Server Runtime**: Staged into `D:\ElSwordServer` (if `D:\ElSwordServer` exists on the machine) or `<RepoRoot>\Deploy\ElSwordServer` (on fresh clones), complete with compiled `.exe` binaries, required runtime DLLs (`z.dll`, `KncCrashRptSV.dll`, `MailMIME.dll`, `MailSMTP.dll`, `tbbmalloc.dll`, `tbbmalloc_proxy.dll`, `msxml6.dll`, `MSSOAP30.dll`), `ServerResource\DBConfig.lua`, and unified `config_*.ini` / `config_*_US_*.lua` files.
   - **Client Runtime**: Staged into [`JP_TW_EU_CN_US/Trunk/X2/Release/`](file:///D:/ElSword/JP_TW_EU_CN_US/Trunk/X2/Release), complete with `X2.exe`, all 10 required client DLLs (`d3dx9_43.dll`, `fmodex.dll`, `KncCrashRpt.dll`, `KncFirewall.dll`, `libpng16.dll`, `MailMIME.dll`, `MailSMTP.dll`, `sdkencryptedappticket.dll`, `steam_api.dll`, `z.dll`), `Config_US_*.lua`, and `StartClient.bat`.

---

## 3. Compiled Executables Overview

Building the repository via [`build.bat`](file:///D:/ElSword/build.bat) produces **6 primary Win32 (`x86`) executables**:

| Role | Executable Path | Config Prefix | ServerClass ID | Default Ports (TCP / UDP) | Description |
| :--- | :--- | :--- | :---: | :---: | :--- |
| **GlobalServer** | [`KncWX2Server/GlobalServer/Release/GlobalServer.exe`](file:///D:/ElSword/JP_TW_EU_CN_US/Trunk/KncWX2Server/GlobalServer/Release/GlobalServer.exe) | `config_gb` | `6` (`ESC_GLOBAL`) | `9100` / `9101` | Cross-server matchmaking, global announcements, field boss sync, and world state coordination. |
| **ChannelServer** | [`KncWX2Server/ChannelServer/Release/ChannelServer.exe`](file:///D:/ElSword/JP_TW_EU_CN_US/Trunk/KncWX2Server/ChannelServer/Release/ChannelServer.exe) | `config_ch` | `4` (`ESC_CHANNEL`) | `9200` / `9201` | Server/channel list gateway queried by the client prior to login. |
| **LoginServer** | [`KncWX2Server/LoginServer/Release/LoginServer.exe`](file:///D:/ElSword/JP_TW_EU_CN_US/Trunk/KncWX2Server/LoginServer/Release/LoginServer.exe) | `config_lg` | `2` (`ESC_LOGIN`) | `9300` / `9301` | Account authentication, session registration, OTP/2nd-password verification, and concurrency routing. |
| **CenterServer** | [`KncWX2Server/CenterServer/Release/CenterServer.exe`](file:///D:/ElSword/JP_TW_EU_CN_US/Trunk/KncWX2Server/CenterServer/Release/CenterServer.exe) | `config_cn` | `1` (`ESC_CENTER`) | `9400` / `9401` | Room/dungeon/PvP/battlefield instance authority, party management, and inter-GameServer relay. |
| **GameServer** | [`KncWX2Server/GameServer/Release/GameServer.exe`](file:///D:/ElSword/JP_TW_EU_CN_US/Trunk/KncWX2Server/GameServer/Release/GameServer.exe) | `config_gs` | `3` (`ESC_GAME`) | `9500` / `9501` | Main player session host: character loading, inventory, quests, mail, trades, cash shop, and villages. |
| **Client (`x2.exe`)** | [`X2/Release/x2.exe`](file:///D:/ElSword/JP_TW_EU_CN_US/Trunk/X2/Release/x2.exe) | `Config_US_*.lua` | N/A | Dynamic | Game client modernized with DirectX 12 (`D3D9On12`), DirectX 11 presentation, and DirectX 9 fallback. |

---

## 4. Server Directory Structure & DSN-Less Database Architecture

> [!IMPORTANT]
> **DSN-less Database Architecture (`KDBConnectionManager`)**: Legacy `.dsn` files have been completely eliminated. All 5 servers load [`ServerResource/DBConfig.lua`](file:///D:/ElSword/JP_TW_EU_CN_US/Trunk/KncWX2Server/ServerResource/DBConfig.lua) and call `DBLayer:SetManagerDB(...)`, which queries `[Account].[dbo].[MServerDBConnectionInfo]` via `dbo.temp_get_info` with automatic primary-to-fallback failover support.

### Staged Server Directory Layout

```text
ElSwordServer/
├── ServerResource/
│   ├── DBConfig.lua                        # Centralized Manager DB Primary & Fallback endpoints
│   ├── CashShopConfig.lua
│   ├── EnchantTable.lua
│   ├── FieldBossData.lua
│   ├── GameSysValTable.lua
│   └── ... (server Lua scripts)
│
├── ClientScript/                           # Shared dungeon, stage, NPC, and item Lua scripts
│
└── GameServer/                             # (Same layout applies to Global, Channel, Login, Center)
    ├── GameServer.exe                      # Compiled VS 2026 C++23 server executable
    ├── z.dll                               # zlib runtime library (built via vcpkg)
    ├── config_gs.ini                       # Protocol version strings (V4.0115.4) & server messages
    ├── config_gs_US_INTERNAL.lua           # Internal/Dev server startup script
    ├── config_gs_US_TEST.lua               # Test environment startup script
    ├── config_gs_US_SERVICE.lua            # Production environment startup script (used by Start.bat)
    ├── KncCrashRptSV.dll                   # Crash dump handler DLL
    ├── MailMIME.dll / MailSMTP.dll         # MIME & SMTP alert helpers
    ├── tbbmalloc.dll / tbbmalloc_proxy.dll # Intel TBB memory allocator DLLs
    └── RobotPattern/                       # PvP / Dungeon AI robot action scripts (GameServer only)
```

### Summary of Database Connections Managed per Server (`[Account].[dbo].[MServerDBConnectionInfo]`)

| Server | ServerClass Enum (`ServerType`) | Managed Databases (`DBType` in `MServerDBConnectionInfo`) | Needs `ServerResource\` & `ClientScript\`? |
| :--- | :--- | :--- | :---: |
| **GlobalServer** | `ESC_GLOBAL` (`6`) | `DC_ACCOUNT` (`0` $\rightarrow$ `Account`), `DC_LOG` (`2` $\rightarrow$ `Statistics`) | Yes |
| **ChannelServer** | `ESC_CHANNEL` (`4`) | `DC_ACCOUNT` (`0` $\rightarrow$ `Account`), `DC_LOG` (`2` $\rightarrow$ `Statistics`) | Yes |
| **LoginServer** | `ESC_LOGIN` (`2`) | `DC_ACCOUNT` (`0` $\rightarrow$ `Account`), `DC_GAME` (`1` $\rightarrow$ `Game01`), `DC_LOG` (`2` $\rightarrow$ `Statistics`) | Yes |
| **CenterServer** | `ESC_CENTER` (`1`) | `DC_ACCOUNT` (`0` $\rightarrow$ `Account`), `DC_GAME` (`1` $\rightarrow$ `Game01`), `DC_LOG` (`2` $\rightarrow$ `Statistics`) | Yes |
| **GameServer** | `ESC_GAME` (`3`) | `DC_ACCOUNT` (`0` $\rightarrow$ `Account`), `DC_GAME` (`1` $\rightarrow$ `Game01`), `DC_LOG` (`2` $\rightarrow$ `Statistics`), `DC_KOG_BILLING` (`7` $\rightarrow$ `ES_BILLING`) | Yes |

---

## 5. Database Deployment & Configuration Steps

### Step 1: Deploy the 4 SQL Server Databases (SQL Server 2017–2025)

The [`SQL/`](file:///D:/ElSword/SQL) directory contains the modernized schemas for MS SQL Server 2017–2025 (compatible with both Windows and Linux VPS instances):

1. [`Account.sql`](file:///D:/ElSword/SQL/Account.sql) — Creates `[Account]` (`DC_ACCOUNT`), `[dbo].[MServerDBConnectionInfo]`, `[dbo].[temp_get_info]`, and `[dbo].[sp_ConfigureServerEndpoints]`
2. [`Game01.sql`](file:///D:/ElSword/SQL/Game01.sql) — Creates `[Game01]` (`DC_GAME`)
3. [`ES_BILLING.sql`](file:///D:/ElSword/SQL/ES_BILLING.sql) — Creates `[ES_BILLING]` (`DC_KOG_BILLING`)
4. [`Statistics.sql`](file:///D:/ElSword/SQL/Statistics.sql) — Creates `[Statistics]` (`DC_LOG`, including `dbo.LServerList` and `dbo.LCenterProxy`)

Run [`SQL/deploy_sql.bat`](file:///D:/ElSword/SQL/deploy_sql.bat) to deploy all four schemas automatically:

```bat
:: Local Windows SQL Server (Trusted Auth):
SQL\deploy_sql.bat

:: Remote Linux VPS SQL Server (SQL Auth):
SQL\deploy_sql.bat 203.0.113.10,1433 sa YourStrongPassword123!
```

### Step 2: Configure Database Endpoints (`DBConfig.lua` & `sp_ConfigureServerEndpoints`)

1. **Edit `ServerResource\DBConfig.lua`** to point to your `[Account]` database (and optional fallback endpoint):
   ```lua
   -- Primary SQL Server / Linux VPS endpoint for the Manager DB ([Account])
   DB_MANAGER_PRIMARY_CONN = "DRIVER={ODBC Driver 18 for SQL Server};SERVER=203.0.113.10,1433;DATABASE=Account;UID=sa;PWD=YourStrongPassword;Encrypt=Mandatory;TrustServerCertificate=Yes;"

   -- Optional Secondary / Fallback SQL Server endpoint for automatic failover:
   DB_MANAGER_FALLBACK_CONN = ""
   ```
2. **Update all server DB endpoints in SQL Server** with a single command using `[Account].[dbo].[sp_ConfigureServerEndpoints]`:
   ```sql
   USE [Account];
   GO
   -- Local Windows Auth:
   EXEC [dbo].[sp_ConfigureServerEndpoints] @Server = N'127.0.0.1,1433';

   -- Or Remote Linux VPS SQL Auth:
   EXEC [dbo].[sp_ConfigureServerEndpoints]
       @Server     = N'203.0.113.10,1433',
       @Driver     = N'{ODBC Driver 18 for SQL Server}',
       @UID        = N'sa',
       @PWD        = N'YourStrongPassword',
       @ExtraFlags = N'Encrypt=Mandatory;TrustServerCertificate=Yes;';
   GO
   ```

### Step 3: Register Your Host IP in `[Statistics].[dbo].[LServerList]`

During startup (`KBaseServer::Init()` $\rightarrow$ `Authenticate(10000)`), every server queries `[Statistics].[dbo].[P_LServerList_By_PublicIP_SEL]` using the host machine's local IPv4 address (`NetCommon::GetLocalIPW()`) and its `ServerType`.

Execute the following SQL in `[Statistics]` (replace `192.168.1.100` with your machine's local LAN IPv4 address):

```sql
USE [Statistics];
GO

DECLARE @HostIP NVARCHAR(15) = N'192.168.1.100'; -- Replace with your local IPv4

DELETE FROM [dbo].[LServerList];
DELETE FROM [dbo].[LCenterProxy];

INSERT INTO [dbo].[LServerList]
    ([UID], [Name], [ServerSetID], [ServerType], [PublicIP], [PrivateIP], [Port1], [Port2], [MaxConcurrentUser], [ConcurrentUser], [Enable], [ServerRollType])
VALUES
    -- ServerType: 1=Center, 2=Login, 3=Game, 4=Channel, 6=Global
    (1, N'CenterServer_01',  214, 1, @HostIP, @HostIP, 9400, 9401, 5000, 0, 1, 0),
    (2, N'LoginServer_01',   214, 2, @HostIP, @HostIP, 9300, 9301, 5000, 0, 1, 0),
    (3, N'GameServer_01',    214, 3, @HostIP, @HostIP, 9500, 9501, 2000, 0, 1, 0),
    (4, N'ChannelServer_01', 214, 4, @HostIP, @HostIP, 9200, 9201, 5000, 0, 1, 0),
    (6, N'GlobalServer_01',  214, 6, @HostIP, @HostIP, 9100, 9101, 5000, 0, 1, 0);

INSERT INTO [dbo].[LCenterProxy] ([ServerUID], [ProxyID], [ServerSetID])
VALUES (1, 1, 214);
GO
```

---

## 6. Launching the Server Suite & Client

### Launching the Servers
Run `Start.bat` inside your staged server directory (`D:\ElSwordServer\Start.bat` or `Deploy\ElSwordServer\Start.bat`), which starts all 5 servers in sequence (`CenterServer` $\rightarrow$ `LoginServer` $\rightarrow$ `ChannelServer` $\rightarrow$ `GlobalServer` $\rightarrow$ `GameServer`) with arguments `US_SERVICE 214`.

### Launching the Client (`X2.exe`)
1. Copy the staged files from [`JP_TW_EU_CN_US/Trunk/X2/Release/`](file:///D:/ElSword/JP_TW_EU_CN_US/Trunk/X2/Release) into your Elsword 2014 client directory containing `data\data*.kom` (or place the `data\` folder inside `X2/Release/`).
2. Verify [`Config_US_INTERNAL.lua`](file:///D:/ElSword/JP_TW_EU_CN_US/Trunk/X2/Release/Config_US_INTERNAL.lua) has your `ChannelServer` IP and port (`9200`) and version `V4.0115.4`.
3. Run [`StartClient.bat`](file:///D:/ElSword/JP_TW_EU_CN_US/Trunk/X2/Release/StartClient.bat) (or launch `X2.exe` directly — no patcher argument or GameGuard/X-Trap is required).
