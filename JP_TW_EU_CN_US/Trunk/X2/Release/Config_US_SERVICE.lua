-- ============================================================================
-- Elsword Client Connection & Version Configuration
-- Loaded automatically on startup by CX2Main::GetWstrBasicConfigFile()
-- ============================================================================

g_pMain:SetClientVersion_LUA( "V4.0115.4" )
g_pMain:SetSubClientVersion_LUA( "V4.0115.4" )
g_pMain:SetNationFlag( NF_US )

-- ChannelServer TCP Endpoint (default 127.0.0.1:9200)
g_pMain:SetChannelServerPort( 9200 )
g_pMain:AddChannelServerIP_LUA( "127.0.0.1", 9200 )
g_pMain:SetDefaultChannelServerIPIndex( 0 )
