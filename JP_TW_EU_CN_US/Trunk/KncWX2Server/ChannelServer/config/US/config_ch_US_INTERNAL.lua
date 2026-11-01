ï»----------     Channel Server „¤ •     ----------

-- ¬˜‰¬ ë¦¬í¬Š¸ ë©”ì¼ë§ ë¦¬ìŠ¤Š¸ --
Server:SetMailingList( "ninil@kog.co.kr, bowrain@kog.co.kr" )

-- ì¢…ë£Œ‹œ db ì²˜ë¦¬ ê¸°ì‹œê° --
Server:SetShutDownWait( 60 * 1000 )

-- Š¤¬ë¦½íŠ¸ ŒŒ‹± ‹¤Œ¨ ë¦¬í¬Š¸
Server:SetScriptParsingErrReport( true )
Server:AddScriptParsingErrReportMail( 'ninil@kog.co.kr' )	-- ì¡°íš¨ì§
Server:AddScriptParsingErrReportMail( 'bowrain@kog.co.kr' ) -- „ê·œìˆ˜

-- Add moritoring server's IP for checking port of elsword's server ( SERV_PERMIT_PORT_CHECK )
--Server:AddPortCheckMoritoringServer( "79.110.90.240" )

----------     Channel NetLayer „¤ •     ----------

NetLayer:SetCheckSequenceNum( false )
NetLayer:SetPacketAuthFailLimit( 100 ) -- œ ê° 100ê°œì´ƒ ë¹„ì •ƒ Œ¨‚·„ ë³´ë‚´ë© •´‹¹ œ   ‘†•´ œ


----------     Channel SimLayer „¤ •     ----------
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

-- Auth Flag --
--[[
AF_INTERNAL    : ‚¬‚´ ¸ì¦
AF_NEXON_KOREA : „¥Š¨ êµ‚´ ¸ì¦
AF_K3RCOMBO_US : ë¯¸êµ­
--]]
SimLayer:SetAuthFlag( AF_INTERNAL )

-- IP Check --
SimLayer:SetCheckIPMode( CIM_SERVICE_MODE )		-- „œë¹„ìŠ¤ ëª¨ë“œ
--SimLayer:SetCheckIPMode( CIM_CHECK_MODE )		--  ê²ëª¨ë“œ

--  ê² ëª¨ë“œ IP ì²´í¬
SimLayer:AddCheckModeIP( "192.168.66" )
SimLayer:SetCheckModeCheckIPType( CIT_CHECK_IP_BLOCK )

-- „œë¹„ìŠ¤ ëª¨ë“œ IP ì²´í¬
SimLayer:AddIP( "192.168.66" )
SimLayer:SetCheckIPType( CIT_ALL_IP_ALLOW )

-- Script File Path --
SimLayer:AddPath( "D:\\ElSwordServer\\ServerResource" )
SimLayer:AddPath( "D:\\ElSwordServer\\ClientScript" )


----------     DB Layer „¤ •     ----------

--  ‘† DB ëª©ë¡ --
--[[
DC_ACCOUNT         : ê³„ì •
DC_GAME            : ê²Œì„
DC_LOG             : †µê³
DC_NX_SHOP_GATEWAY : „¥Š¨ ë¹Œë§ ê²Œì´Š¸›¨´
--]]
-- AddDB( DB ì¢…ë¥˜, file dsn, thread ê°œìˆ˜, DBConnectionString—¬ë¶ )

dofile( "D:\\ElSword\\JP_TW_EU_CN_US\\Trunk\\KncWX2Server\\ServerResource\\DBConfig.lua" )
DBLayer:SetManagerDB( ESC_CHANNEL, DB_MANAGER_PRIMARY_CONN, true )

if Server:GetServerGroupID() == 0 then
elseif Server:GetServerGroupID() == 1 then
else
end

----------     ¸ì¦ „¤ •     ----------
-- …ŒŠ¤Š¸ ì¤
-- add •¨ˆ˜“¤ ¸ë¥ ‹¤ „‹œë¡.. –´ì°¨í”¼ •ˆ“°ê³ ˆŒ
K3RComboAuthManager:AddWebServiceAddress( 'http://gamewcf.kill3rcombo.com:83/GameSecurityService.svc' )
K3RComboAuthManager:AddWebMethod( K3R_AUTH, 'http://Kill3rComboService/2010/IGameSecurityContract/Login' )
--K3RComboAuthManager:AddWebMethod( K3R_AUTH, 'http://tempuri.org/IGameSecurityContract/Login' )
K3RComboAuthManager:Init( 1 )


----------     ë¡œê·¸  ˆë² „¤ •     ----------

-- ë¡œê·¸  ˆë² --
--[[
-1 : no logs
 0 : cerr, cout
 1 : cerr, cwarn, cout
 2 : cerr, cwarn, clog, cout
--]]
log( 0 )