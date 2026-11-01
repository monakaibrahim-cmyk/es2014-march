ï»----------     Center Server „¤ •     ----------

-- ¬˜‰¬ ë¦¬í¬Š¸ ë©”ì¼ë§ ë¦¬ìŠ¤Š¸ --
--Server:SetMailingList( "demiahun@kogstudios.com, comicprince@kogstudios.com" )

-- ì¢…ë£Œ‹œ db ì²˜ë¦¬ ê¸°ì‹œê° --
Server:SetShutDownWait( 60 * 1000 )  -- ì¢…ë£Œ‹œ db ì²˜ë¦¬ ê¸°ì‹œê° : 1ë¶.

-- Add moritoring server's IP for checking port of elsword's server ( SERV_PERMIT_PORT_CHECK )
--Server:AddPortCheckMoritoringServer( "79.110.90.240" )

----------     Center NetLayer „¤ •     ----------

NetLayer:SetCheckSequenceNum( false ) -- ‚´ë¶†µ‹  SequenceNum ì²´í¬•„š”—†Œ


----------     Center SimLayer „¤ •     ----------
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
DBLayer:SetManagerDB( ESC_CENTER, DB_MANAGER_PRIMARY_CONN, true )

if Server:GetServerGroupID() == 0 then
elseif Server:GetServerGroupID() == 1 then
else
end


----------     ë£ „¤ •     ----------

RoomManager:SetNumPvPRoom( 1500 )
RoomManager:SetNumDungeonRoom( 1500 )
RoomManager:SetNumSquare( 10 ) -- DB— „¤ •˜–´ ˆŠ” ê´‘ì¥ ê°œìˆ˜ ´ƒ´–´•¼ •œ‹¤.
RoomManager:SetNumTrade( 300 )
RoomManager:SetNumTrainingCenterRoom( 1500 )
RoomManager:SetNumPersonalShop( 150 )
RoomManager:SetNumBattleField( 1500 )
RoomManager:SetNumWeddingHall( 300 )

-- ì¢ë¹„ìœ  ì²´í¬ ‹œê° „¤ • --
RoomManager:SetZUTickTime( 300 )
RoomManager:SetBattleFieldZUTickTime( 20 )		-- ë°°í•„“œ ì¢ë¹„ìœ  ì²´í¬ ‹œê° „¤ •


----------     †µê³ „¤ •     ----------

StatisticsManager:AddStatistics( SI_RES_STONE, 3600, true )
StatisticsManager:AddStatistics( SI_LOC_PVP, 3600, false )


----------     ë¡œê·¸  ˆë² „¤ •     ----------

-- ë¡œê·¸  ˆë² --
--[[
-1 : no logs
 0 : cerr, cout
 1 : cerr, cwarn, cout
 2 : cerr, cwarn, clog, cout
--]]
log( 1 )