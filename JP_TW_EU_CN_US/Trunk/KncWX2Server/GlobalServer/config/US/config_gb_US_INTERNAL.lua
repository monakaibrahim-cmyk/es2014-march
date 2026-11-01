ï»-- lua header. UTF-8 ¸ì½”ë”© ¸‹„ œ„•´ ´ ì¤„ì ì§š°ì§ ë§ˆì„¸š”.

----------     Global Server „¤ •     ----------

-- ¬˜‰¬ ë¦¬í¬Š¸ ë©”ì¼ë§ ë¦¬ìŠ¤Š¸ --
Server:SetMailingList( "ninil@kog.co.kr, bowrain@kog.co.kr" )

-- ì¢…ë£Œ‹œ db ì²˜ë¦¬ ê¸°ì‹œê° --
Server:SetShutDownWait( 60 * 1000 )

-- „¥Š¨ passport ¸ì¦  ˆë²
--Server:SetPassportLevel( 2 )

-- Š¤¬ë¦½íŠ¸ ŒŒ‹± ‹¤Œ¨ ë¦¬í¬Š¸
Server:SetScriptParsingErrReport( true )
Server:AddScriptParsingErrReportMail( 'bowrain@kog.co.kr' )	-- ˜¤˜„ƒ
Server:AddScriptParsingErrReportMail( 'ninil@kog.co.kr' )	-- „™½

-- Add moritoring server's IP for checking port of elsword's server ( SERV_PERMIT_PORT_CHECK )
--Server:AddPortCheckMoritoringServer( "79.110.90.240" )

----------     Global NetLayer „¤ •     ----------

NetLayer:SetCheckSequenceNum( false ) -- ‚´ë¶†µ‹  SequenceNum ì²´í¬•„š”—†Œ


----------     Global SimLayer „¤ •     ----------
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
--]]
SimLayer:SetAuthFlag( AF_INTERNAL )

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
DBLayer:SetManagerDB( ESC_GLOBAL, DB_MANAGER_PRIMARY_CONN, true )


----------     ë¡œê·¸  ˆë² „¤ •     ----------

-- ë¡œê·¸  ˆë² --
--[[
-1 : no logs
 0 : cerr, cout
 1 : cerr, cwarn, cout
 2 : cerr, cwarn, clog, cout
--]]
log( 0 )
