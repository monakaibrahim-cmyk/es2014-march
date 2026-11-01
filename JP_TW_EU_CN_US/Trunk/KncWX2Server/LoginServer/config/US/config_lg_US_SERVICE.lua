ï»-- lua header. UTF-8 ¸ì½”ë”© ¸‹„ œ„•´ ´ ì¤„ì ì§š°ì§ ë§ˆì„¸š”.

----------     Login Server „¤ •     ----------

-- ¬˜‰¬ ë¦¬í¬Š¸ ë©”ì¼ë§ ë¦¬ìŠ¤Š¸ --
--Server:SetMailingList( "demiahun@kogstudios.com, comicprince@kogstudios.com" )

-- ì¢…ë£Œ‹œ db ì²˜ë¦¬ ê¸°ì‹œê° --
Server:SetShutDownWait( 60 * 1000 )

-- „¥Š¨ passport ¸ì¦  ˆë²
--Server:SetPassportLevel( 2 )

-- „œë²„ê°„  ‘† ëª¨ë‹ˆ„°ë§ ™‘ —¬ë¶
--Server:SetConnectionMornitoringEnable( false )

-- Add moritoring server's IP for checking port of elsword's server ( SERV_PERMIT_PORT_CHECK )
--Server:AddPortCheckMoritoringServer( "79.110.90.240" )

----------     Login NetLayer „¤ •     ----------

NetLayer:SetCheckSequenceNum( false ) -- ‚´ë¶†µ‹  SequenceNum ì²´í¬•„š”—†Œ


----------     Login SimLayer „¤ •     ----------
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
SimLayer:SetCheckCouponByPublisher ( true )

-- Auth Flag --
--[[
AF_INTERNAL    : ‚¬‚´ ¸ì¦
AF_NEXON_KOREA : „¥Š¨ êµ‚´ ¸ì¦
AF_K3RCOMBO_US : ë¯¸êµ­
--]]
SimLayer:SetAuthFlag( AF_INTERNAL )

-- Script File Path --
SimLayer:AddPath( "D:\\ElSwordServer\\ServerResource" )
SimLayer:AddPath( "D:\\ElSwordServer\\ClientScript" )
-- ¸ì¦ ê¸ ê¸°ëŠ¥
SimLayer:SetEnableAuthWait( true )


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
DBLayer:SetManagerDB( ESC_LOGIN, DB_MANAGER_PRIMARY_CONN, true )

if Server:GetServerGroupID() == 0 then
else	
end



----------     ¸ì¦ „¤ •     ----------

--[[
-- PC ë° ¸ì¦  •ë³ --
-- InitNexonAuthInfo( ¸ì¦ „œë² IP, ¸ì¦ „œë² Port, „œë² „ë©”ì¸, „ë©”ì¸„¤„, „¸…˜ì²´í¬…, „¸…˜ì²´í¬ì¹´ìš´Š¸ )

if Server:GetServerGroupID() == 0 then
	NXAuthManager:InitNexonAuthInfo( '211.218.232.116', 10029, 0, '†” ˆŠ¤', 2, 25 )
else
	NXAuthManager:InitNexonAuthInfo( '211.218.232.116', 10029, 1, 'ê°´•„', 2, 25 )
end

-- “° ˆ“œ ê°œìˆ˜ --
NXAuthManager:SetNumThread( 2 )

--]]


----------     ë¡œê·¸  ˆë² „¤ •     ----------

-- ë¡œê·¸  ˆë² --
--[[
-1 : no logs
 0 : cerr, cout
 1 : cerr, cwarn, cout
 2 : cerr, cwarn, clog, cout
--]]
log( 0 )