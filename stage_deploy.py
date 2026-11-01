import os
import re
import shutil

REPO_ROOT = os.path.dirname(os.path.abspath(__file__))
TRUNK_DIR = os.path.join(REPO_ROOT, r'JP_TW_EU_CN_US\Trunk')
SERVER_SRC_ROOT = os.path.join(TRUNK_DIR, 'KncWX2Server')
CLIENT_RELEASE_DIR = os.path.join(TRUNK_DIR, r'X2\Release')

# Use D:\ElSwordServer if present on host, otherwise stage into <REPO_ROOT>\Deploy\ElSwordServer
SERVER_DEPLOY_ROOT = os.environ.get(
    'ELSWORD_SERVER_DEPLOY_DIR',
    r'D:\ElSwordServer' if os.path.isdir(r'D:\ElSwordServer') else os.path.join(REPO_ROOT, r'Deploy\ElSwordServer')
)

_default_vcpkg = os.path.join(REPO_ROOT, r'ExternalLib\vcpkg_x86-windows')
if not os.path.isdir(_default_vcpkg):
    _default_vcpkg = os.path.join(os.environ.get('VCPKG_INSTALLATION_ROOT', r'C:\vcpkg'), r'installed\x86-windows')
VCPKG_BIN_DIR = os.path.join(os.environ.get('VCPKG_INSTALLED_DIR', _default_vcpkg), 'bin')

SERVERS = [
    ('GlobalServer',  'config_gb', 'ESC_GLOBAL'),
    ('ChannelServer', 'config_ch', 'ESC_CHANNEL'),
    ('LoginServer',   'config_lg', 'ESC_LOGIN'),
    ('CenterServer',  'config_cn', 'ESC_CENTER'),
    ('GameServer',    'config_gs', 'ESC_GAME'),
]

CLIENT_VERSION = 'V4.0115.4'
DEFAULT_CHANNEL_IP = '127.0.0.1'
DEFAULT_CHANNEL_PORT = 9200


def copy_if_exists(src, dst_dir, dst_name=None):
    if not os.path.isfile(src):
        return False
    os.makedirs(dst_dir, exist_ok=True)
    dst = os.path.join(dst_dir, dst_name or os.path.basename(src))
    if os.path.abspath(src).lower() == os.path.abspath(dst).lower():
        return True
    shutil.copy2(src, dst)
    return True


def unify_ini_version(ini_path):
    if not os.path.isfile(ini_path):
        return
    with open(ini_path, 'r', encoding='cp949', errors='ignore') as f:
        text = f.read()
    text = re.sub(r'(?m)^(Internal Version\s*=\s*).*$', rf'\g<1>{CLIENT_VERSION}', text)
    text = re.sub(r'(?m)^(OpenTest Version\s*=\s*).*$', rf'\g<1>{CLIENT_VERSION}', text)
    text = re.sub(r'(?m)^(Service Version\s*=\s*).*$',  rf'\g<1>{CLIENT_VERSION}', text)
    with open(ini_path, 'w', encoding='cp949') as f:
        f.write(text)


def patch_server_lua(lua_path, esc_const, db_config_lua_path, sr_path_escaped, cs_path_escaped):
    if not os.path.isfile(lua_path):
        return
    with open(lua_path, 'r', encoding='cp949', errors='ignore') as f:
        lines = f.readlines()

    new_lines = []
    added_paths = False
    added_db = False

    for line in lines:
        if 'SimLayer:AddPath' in line:
            if not added_paths:
                new_lines.append(f'SimLayer:AddPath( "{sr_path_escaped}" )\n')
                new_lines.append(f'SimLayer:AddPath( "{cs_path_escaped}" )\n')
                added_paths = True
            continue
        if 'SimLayer:SetAuthFlag' in line:
            new_lines.append('SimLayer:SetAuthFlag( AF_INTERNAL )\n')
            continue
        if 'DBLayer:AddDB' in line or 'DBLayer:SetManagerDB' in line or 'DBConfig.lua' in line:
            if not added_db:
                new_lines.append(f'dofile( "{db_config_lua_path}" )\n')
                new_lines.append(f'DBLayer:SetManagerDB( {esc_const}, DB_MANAGER_PRIMARY_CONN, true )\n')
                added_db = True
            continue
        new_lines.append(line)

    with open(lua_path, 'w', encoding='cp949') as f:
        f.writelines(new_lines)


def stage_servers():
    print('[*] Staging Server Binaries, DLLs, and Configs ->', SERVER_DEPLOY_ROOT)
    os.makedirs(SERVER_DEPLOY_ROOT, exist_ok=True)

    sr_dst = os.path.join(SERVER_DEPLOY_ROOT, 'ServerResource')
    cs_dst = os.path.join(SERVER_DEPLOY_ROOT, 'ClientScript')
    os.makedirs(sr_dst, exist_ok=True)
    os.makedirs(cs_dst, exist_ok=True)

    sr_src = os.path.join(SERVER_SRC_ROOT, r'ServerResource\US')
    if os.path.isdir(sr_src):
        for fn in os.listdir(sr_src):
            if fn.lower().endswith('.lua'):
                dst_f = os.path.join(sr_dst, fn)
                if not os.path.exists(dst_f):
                    shutil.copy2(os.path.join(sr_src, fn), dst_f)

    db_cfg_dst = os.path.join(sr_dst, 'DBConfig.lua')
    if not os.path.exists(db_cfg_dst):
        db_cfg_src = os.path.join(SERVER_SRC_ROOT, r'ServerResource\DBConfig.lua')
        if os.path.exists(db_cfg_src):
            shutil.copy2(db_cfg_src, db_cfg_dst)

    deploy_sr_esc = sr_dst.replace('\\', '\\\\')
    deploy_cs_esc = cs_dst.replace('\\', '\\\\')
    deploy_db_esc = db_cfg_dst.replace('\\', '\\\\')

    repo_sr_esc = os.path.join(SERVER_SRC_ROOT, r'ServerResource\US').replace('\\', '\\\\')
    repo_db_esc = os.path.join(SERVER_SRC_ROOT, r'ServerResource\DBConfig.lua').replace('\\', '\\\\')

    for srv_name, cfg_prefix, esc_const in SERVERS:
        srv_src_dir = os.path.join(SERVER_SRC_ROOT, srv_name)
        srv_rel_dir = os.path.join(srv_src_dir, 'Release')
        srv_dst_dir = os.path.join(SERVER_DEPLOY_ROOT, srv_name)
        os.makedirs(srv_dst_dir, exist_ok=True)

        exe_src = os.path.join(srv_rel_dir, f'{srv_name}.exe')
        if copy_if_exists(exe_src, srv_dst_dir):
            print(f'  [OK] {srv_name}.exe -> {srv_dst_dir}')
        copy_if_exists(os.path.join(srv_rel_dir, 'z.dll'), srv_dst_dir)
        copy_if_exists(os.path.join(VCPKG_BIN_DIR, 'zlib1.dll'), srv_dst_dir, 'z.dll')

        common_dlls = ['KncCrashRptSV.dll', 'MailMIME.dll', 'MailSMTP.dll', 'tbbmalloc.dll', 'tbbmalloc_proxy.dll', 'dbghelp.dll']
        if srv_name in ('ChannelServer', 'GameServer'):
            common_dlls.extend(['msxml6.dll', 'MSSOAP30.dll'])
        for dll in common_dlls:
            copy_if_exists(os.path.join(srv_src_dir, dll), srv_dst_dir)

        ini_dst = os.path.join(srv_dst_dir, f'{cfg_prefix}.ini')
        if not os.path.exists(ini_dst):
            copy_if_exists(os.path.join(srv_src_dir, r'config\US', f'{cfg_prefix}.ini'), srv_dst_dir)
        unify_ini_version(ini_dst)

        for tag in ('US_INTERNAL', 'US_TEST', 'US_SERVICE'):
            lua_name = f'{cfg_prefix}_{tag}.lua'
            lua_dst = os.path.join(srv_dst_dir, lua_name)
            if not os.path.exists(lua_dst):
                copy_if_exists(os.path.join(srv_src_dir, r'config\US', lua_name), srv_dst_dir)
            patch_server_lua(lua_dst, esc_const, deploy_db_esc, deploy_sr_esc, deploy_cs_esc)

            src_lua = os.path.join(srv_src_dir, r'config\US', lua_name)
            if os.path.exists(src_lua):
                patch_server_lua(src_lua, esc_const, repo_db_esc, repo_sr_esc, deploy_cs_esc)
        src_ini = os.path.join(srv_src_dir, r'config\US', f'{cfg_prefix}.ini')
        if os.path.exists(src_ini):
            unify_ini_version(src_ini)


def stage_client():
    print('[*] Staging Client Binary, Runtime DLLs, and Configs ->', CLIENT_RELEASE_DIR)
    os.makedirs(CLIENT_RELEASE_DIR, exist_ok=True)

    client_dll_sources = [
        (os.path.join(TRUNK_DIR, r'X2Viewer\fmodex.dll'), 'fmodex.dll'),
        (os.path.join(TRUNK_DIR, r'X2Viewer\KncCrashRpt.dll'), 'KncCrashRpt.dll'),
        (os.path.join(TRUNK_DIR, r'X2Viewer\KncFirewall.dll'), 'KncFirewall.dll'),
        (os.path.join(TRUNK_DIR, r'X2Viewer\MailMIME.dll'), 'MailMIME.dll'),
        (os.path.join(TRUNK_DIR, r'X2Viewer\MailSMTP.dll'), 'MailSMTP.dll'),
        (os.path.join(TRUNK_DIR, r'Steamworks\lib\steam_api.dll'), 'steam_api.dll'),
        (os.path.join(TRUNK_DIR, r'Steamworks\lib\sdkencryptedappticket.dll'), 'sdkencryptedappticket.dll'),
        (os.path.join(SERVER_SRC_ROOT, r'CenterServer\d3dx9_43.dll'), 'd3dx9_43.dll'),
        (r'C:\Windows\SysWOW64\d3dx9_43.dll', 'd3dx9_43.dll'),
        (os.path.join(VCPKG_BIN_DIR, 'zlib1.dll'), 'z.dll'),
        (os.path.join(VCPKG_BIN_DIR, 'libpng16.dll'), 'libpng16.dll'),
    ]

    copied_dlls = 0
    for src_path, dll_name in client_dll_sources:
        if copy_if_exists(src_path, CLIENT_RELEASE_DIR, dll_name):
            copied_dlls += 1
    print(f'  [OK] Staged client runtime DLLs into {CLIENT_RELEASE_DIR}')

    client_config_lua = f"""-- ============================================================================
-- Elsword Client Connection & Version Configuration
-- Loaded automatically on startup by CX2Main::GetWstrBasicConfigFile()
-- ============================================================================

g_pMain:SetClientVersion_LUA( "{CLIENT_VERSION}" )
g_pMain:SetSubClientVersion_LUA( "{CLIENT_VERSION}" )
g_pMain:SetNationFlag( NF_US )

-- ChannelServer TCP Endpoint (default 127.0.0.1:9200)
g_pMain:SetChannelServerPort( {DEFAULT_CHANNEL_PORT} )
g_pMain:AddChannelServerIP_LUA( "{DEFAULT_CHANNEL_IP}", {DEFAULT_CHANNEL_PORT} )
g_pMain:SetDefaultChannelServerIPIndex( 0 )
"""

    for cfg_name in ('Config_US_INTERNAL.lua', 'Config_US_SERVICE.lua', 'Config_US_TEST.lua', 'Config.lua'):
        cfg_path = os.path.join(CLIENT_RELEASE_DIR, cfg_name)
        if not os.path.exists(cfg_path):
            with open(cfg_path, 'w', encoding='cp949', newline='\r\n') as f:
                f.write(client_config_lua)
    print(f'  [OK] Staged Config_US_*.lua ({CLIENT_VERSION} -> {DEFAULT_CHANNEL_IP}:{DEFAULT_CHANNEL_PORT})')

    launcher_bat = os.path.join(CLIENT_RELEASE_DIR, 'StartClient.bat')
    with open(launcher_bat, 'w', encoding='ascii', newline='\r\n') as f:
        f.write('@echo off\n')
        f.write('cd /d "%~dp0"\n')
        f.write('start "" "x2.exe"\n')

    for item in os.listdir(CLIENT_RELEASE_DIR):
        full = os.path.join(CLIENT_RELEASE_DIR, item)
        if os.path.isdir(full) and item.lower() in ('x2.tlog', 'x2_md.tlog', 'microsoft'):
            shutil.rmtree(full, ignore_errors=True)
        elif os.path.isfile(full) and item.lower().endswith(('.res', '.exp', '.lib', '.recipe', '.log', '.txt', '.intermediate.manifest')):
            os.remove(full)


if __name__ == '__main__':
    stage_servers()
    stage_client()
    print('[SUCCESS] Post-build staging and deployment completed.')
