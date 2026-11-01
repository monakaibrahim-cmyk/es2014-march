ï»-- lua header. UTF-8 ¸ì½”ë”© ¸‹„ œ„•´ ´ ì¤„ì ì§š°ì§ ë§ˆì„¸š”.

----------     Game Server „¤ •     ----------

-- ¬˜‰¬ ë¦¬í¬Š¸ ë©”ì¼ë§ ë¦¬ìŠ¤Š¸ --
Server:SetMailingList( "ninil@kog.co.kr, bowrain@kog.co.kr" )

-- ì¢…ë£Œ‹œ db ì²˜ë¦¬ ê¸°ì‹œê° --
Server:SetShutDownWait( 60 * 1000 )

-- Š¤¬ë¦½íŠ¸ ŒŒ‹± ‹¤Œ¨ ë¦¬í¬Š¸
Server:SetScriptParsingErrReport( true )
Server:AddScriptParsingErrReportMail( 'bowrain@kog.co.kr' )	-- ˜¤˜„ƒ
Server:AddScriptParsingErrReportMail( 'ninil@kog.co.kr' )	-- „™½

-- Add moritoring server's IP for checking port of elsword's server ( SERV_PERMIT_PORT_CHECK )
--Server:AddPortCheckMoritoringServer( "79.110.90.240" )

-- Hack Shield HSB File Path
--Server:SetHackShieldHSBFilePath( "E:\\projectx2_svn\\source\\KR\\Trunk\\KncWX2Server\\GameServer\\HackShield\\X2.hsb" )

-- TRWorkerThread ê°ˆ˜
TRServer:TRWorkerThreadCount( 6 )


----------     GS NetLayer „¤ •     ----------

NetLayer:SetCheckSequenceNum( true )
NetLayer:SetPacketAuthFailLimit( 100 ) -- œ ê° 100ê°œì´ƒ ë¹„ì •ƒ Œ¨‚·„ ë³´ë‚´ë© •´‹¹ œ   ‘†•´ œ


----------     GS SimLayer „¤ •     ----------
SimLayer:SetUseKogOTP ( true )

-- PublisherBillingConnectType Flag --
--[[
		PBCT_NONE				= 0,	
		// kncSend –„ë¬¸ì— DBLayer ¼ë° Manager Š” êµ¬ë¶„˜–´•¼ •¨
		PBCT_NORMAL		= 1,	// ¼ë°˜ì ¸ Manager †µ•´ (ë³´í†µ TCP, SOAP “±)
		PBCT_DB					= 2,	// DB †µ‹  Managerë¥ †µ•´
		PBCT_UNUSUAL		= 3,	// „–´ “°˜ê° Š¹´ ‚¬•­ ˆŠ” ê²½ìš°
--]]
SimLayer:SetPublisherBillingConnectType (PBCT_NORMAL)
SimLayer:SetCheckCouponByPublisher ( false )

-- Virsion Flag --
--[[
VF_INTERNAL	 : ‚¬‚´ …ŒŠ¤Š¸ ë²„ì „
VF_OPEN_TEST : ˜¤”ˆ …ŒŠ¤Š¸ ë²„ì „
VF_SERVICE	 : „œë¹„ìŠ¤ ë²„ì „
--]]
SimLayer:SetVersionFlag( VF_INTERNAL )

-- Common Flag --
--[[
CF_NPGG     : nProtect Game Guard Check
CF_CHECK_IP :  ‘† IP Check
CF_HSHIELD	: HackShield
CF_XTRAP	: X-Trap
--]]
--SimLayer:AddCommonFlag( CF_HSHIELD )
--SimLayer:AddCommonFlag( CF_XTRAP )

-- Auth Flag --
--[[
AF_INTERNAL    : ‚¬‚´ ¸ì¦
AF_NEXON_KOREA : „¥Š¨ êµ‚´ ¸ì¦
AF_K3RCOMBO_US 
--]]
SimLayer:SetAuthFlag( AF_INTERNAL )

-- Billing Flag --
--[[
BF_INTERNAL : ‚¬‚´ ë²„ì „ ë¹Œë§
BF_NEXON_KOREA_TEST : „¥Š¨ ë¹Œë§ …Œ„­
BF_NEXON_KOREA : „¥Š¨ ë¹Œë§ ë³¸ì„­
BF_PAYLETTER_US : ë¯¸êµ­ ˜´ ˆ„°
BF_PAYLETTER_US_INTERNAL : ë¯¸êµ­ ¸„°„
--]]
SimLayer:SetBillingFlag( BF_INTERNAL )

-- IP Check --
-- „¤ •˜–´ ˆì§ •Šœ¼ë© ëª¨ë“  IP  ‘† —ˆš©
--SimLayer:AddIP( "116.120.238" )

-- Script File Path --
SimLayer:AddPath( "D:\\ElSwordServer\\ServerResource" )
SimLayer:AddPath( "D:\\ElSwordServer\\ClientScript" )


----------     DB Layer „¤ •     ----------

--  ‘† DB ëª©ë¡ --
--[[
DC_ACCOUNT         : ê³„ì •
DC_GAME            : ê²Œì„
DC_LOG             : †µê³
DC_NX_WEB		   : „¥Š¨ WEB
--]]
-- AddDB( DB ì¢…ë¥˜, file dsn, thread ê°œìˆ˜, DBConnectionString—¬ë¶ )

dofile( "D:\\ElSword\\JP_TW_EU_CN_US\\Trunk\\KncWX2Server\\ServerResource\\DBConfig.lua" )
DBLayer:SetManagerDB( ESC_GAME, DB_MANAGER_PRIMARY_CONN, true )

if Server:GetServerGroupID() == 0 then
elseif Server:GetServerGroupID() == 1 then
else
end




----------     ë¹Œë§ „¤ •     ----------

-- InitNexonBillingTCPInfo( „œë² IP, „œë² Port, „œë² „ë©”ì¸ )
if SimLayer:GetBillingFlag() == BF_PAYLETTER_US
then
PayletterBillingManager:InitPayletterBillingInfo( '222.127.25.29', 30010, 99 )
PayletterBillingManager:SetNumThread( 10 )
end



----------     †µê³ „¤ •     ----------

StatisticsManager:SetUserLog( true )
StatisticsManager:SetBillingPacketLog( true )

StatisticsManager:AddStatistics( SI_DISCONNECT_USERFSM, 1800, true )
StatisticsManager:AddStatistics( SI_DISCONNECT_REASON, 300, true )
StatisticsManager:AddStatistics( SI_PVP_MAP, 3600, true )
StatisticsManager:AddStatistics( SI_FPS, 3600, true )
StatisticsManager:AddStatistics( SI_ED, 3600, true )
StatisticsManager:AddStatistics( SI_QUEST, 3600, true )
StatisticsManager:AddStatistics( SI_CHARACTER, 10, true )
StatisticsManager:AddStatistics( SI_LOC_ITEM, 3600, false )
StatisticsManager:AddStatistics( SI_LOC_SPIRIT, 3600, false )
StatisticsManager:AddStatistics( SI_LOC_ENCHANT, 3600, false )
StatisticsManager:AddStatistics( SI_ITEM_DB, 3600, true )
StatisticsManager:SetStatisticsFlushTime( SI_ITEM_DB, 4 )




----------     ë¡œê·¸  ˆë² „¤ •     ----------

-- ë¡œê·¸  ˆë² --
--[[
-1 : no logs
 0 : cerr, cout
 1 : cerr, cwarn, cout
 2 : cerr, cwarn, clog, cout
--]]
log( 0 )
