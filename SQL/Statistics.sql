-- =============================================================================
-- Elsword Database Schema: [Statistics]
-- Target Engine: Microsoft SQL Server 2017 - 2025 (Windows & Linux VPS)
-- Compatibility: COMPATIBILITY_LEVEL 140 (2017) / 150 (2019) / 160 (2022) / 170 (2025)
-- =============================================================================
USE [master]
GO

-- Ensure all peer databases exist so cross-database stored procedures resolve cleanly
IF DB_ID(N'Account') IS NULL
    CREATE DATABASE [Account];
GO
IF DB_ID(N'ES_BILLING') IS NULL
    CREATE DATABASE [ES_BILLING];
GO
IF DB_ID(N'Game01') IS NULL
    CREATE DATABASE [Game01];
GO
IF DB_ID(N'Statistics') IS NULL
    CREATE DATABASE [Statistics];
GO

-- Dynamically set highest supported Compatibility Level for SQL Server 2017 - 2025
DECLARE @MajorVersion INT = CAST(SERVERPROPERTY('ProductMajorVersion') AS INT);
DECLARE @CompatLevel INT = CASE
    WHEN @MajorVersion >= 17 THEN 170 -- SQL Server 2025
    WHEN @MajorVersion = 16  THEN 160 -- SQL Server 2022
    WHEN @MajorVersion = 15  THEN 150 -- SQL Server 2019
    WHEN @MajorVersion = 14  THEN 140 -- SQL Server 2017
    ELSE 130                          -- SQL Server 2016 fallback
END;
DECLARE @SqlCmd NVARCHAR(400) = N'ALTER DATABASE [Statistics] SET COMPATIBILITY_LEVEL = ' + CAST(@CompatLevel AS NVARCHAR(10));
EXEC sp_executesql @SqlCmd;
GO

ALTER DATABASE [Statistics] SET ANSI_NULL_DEFAULT ON
GO
ALTER DATABASE [Statistics] SET ANSI_NULLS ON
GO
ALTER DATABASE [Statistics] SET ANSI_PADDING ON
GO
ALTER DATABASE [Statistics] SET ANSI_WARNINGS ON
GO
ALTER DATABASE [Statistics] SET ARITHABORT ON
GO
ALTER DATABASE [Statistics] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [Statistics] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [Statistics] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [Statistics] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [Statistics] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [Statistics] SET CURSOR_DEFAULT GLOBAL
GO
ALTER DATABASE [Statistics] SET CONCAT_NULL_YIELDS_NULL ON
GO
ALTER DATABASE [Statistics] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [Statistics] SET QUOTED_IDENTIFIER ON
GO
ALTER DATABASE [Statistics] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [Statistics] SET DISABLE_BROKER
GO
ALTER DATABASE [Statistics] SET AUTO_UPDATE_STATISTICS_ASYNC ON
GO
ALTER DATABASE [Statistics] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [Statistics] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [Statistics] SET ALLOW_SNAPSHOT_ISOLATION ON
GO
ALTER DATABASE [Statistics] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [Statistics] SET READ_COMMITTED_SNAPSHOT ON
GO
ALTER DATABASE [Statistics] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [Statistics] SET READ_WRITE
GO
ALTER DATABASE [Statistics] SET RECOVERY SIMPLE
GO
ALTER DATABASE [Statistics] SET MULTI_USER
GO
ALTER DATABASE [Statistics] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [Statistics] SET DB_CHAINING OFF
GO
ALTER DATABASE [Statistics] SET TARGET_RECOVERY_TIME = 60 SECONDS
GO
USE [Statistics]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF DATABASE_PRINCIPAL_ID(N'statsuser') IS NULL
    CREATE USER [statsuser] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo];
GO
IF DATABASE_PRINCIPAL_ID(N'gmanager') IS NULL
    CREATE USER [gmanager] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo];
GO
IF DATABASE_PRINCIPAL_ID(N'elsword') IS NULL
    CREATE USER [elsword] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo];
GO
IF OBJECT_ID(N'[dbo].[LUnitStatistics]', N'U') IS NULL
CREATE TABLE [dbo].[LUnitStatistics](
	[UnitUID] [bigint] NOT NULL,
	[UserUID] [bigint] NOT NULL,
	[NickName] [nvarchar](40) NOT NULL,
	[NickNameChangeCount] [smallint] NOT NULL,
	[UnitClass] [tinyint] NOT NULL,
	[Exp] [int] NOT NULL,
	[Level] [tinyint] NOT NULL,
	[GamePoint] [int] NOT NULL,
	[PlayDayCnt] [int] NOT NULL,
	[LoginCount] [int] NOT NULL,
	[PCBangCnt] [int] NOT NULL,
	[PCBangDayCnt] [smallint] NOT NULL,
	[LastDate] [smalldatetime] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL,
	[DelDate] [smalldatetime] NULL,
	[TotalPlayTime] [int] NOT NULL,
	[VsPlayTime] [int] NOT NULL,
	[DPlayTime] [int] NOT NULL,
	[UseSpirit] [int] NOT NULL,
	[AllSpiritCnt] [smallint] NOT NULL,
	[KillCnt] [int] NOT NULL,
	[VsCnt] [int] NOT NULL,
	[DCnt] [int] NOT NULL,
	[P2PCnt] [int] NOT NULL,
	[SquareCnt] [int] NOT NULL,
	[SquarePlayTime] [int] NOT NULL,
	[QuestCnt] [int] NOT NULL,
	[ReQuestCnt] [int] NOT NULL,
	[UseStone] [int] NOT NULL,
 CONSTRAINT [PKC_LUnitStatistics_UnitUID] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LUnitPVPLog]', N'U') IS NULL
CREATE TABLE [dbo].[LUnitPVPLog](
	[ArenaUID] [bigint] NOT NULL,
	[MatchType] [tinyint] NOT NULL,
	[PvpType] [tinyint] NOT NULL,
	[UnitUID] [bigint] NOT NULL,
	[NickName] [nvarchar](16) NOT NULL,
	[Lv] [tinyint] NOT NULL,
	[UnitClass] [tinyint] NOT NULL,
	[Rating] [int] NOT NULL,
	[Rank] [tinyint] NOT NULL,
	[RPoint] [int] NOT NULL,
	[APoint] [int] NOT NULL,
	[OfficialMatchCnt] [int] NOT NULL,
	[Team] [tinyint] NOT NULL,
	[PartyApp] [bit] NOT NULL,
	[WaitTime] [smallint] NOT NULL,
	[Win] [tinyint] NOT NULL,
	[EndType] [tinyint] NOT NULL,
	[playTime] [smallint] NOT NULL,
	[Kill] [tinyint] NOT NULL,
	[Assist] [tinyint] NOT NULL,
	[Death] [tinyint] NOT NULL,
	[NetRatingInc] [smallint] NOT NULL,
	[NetRPInc] [smallint] NOT NULL,
	[NetAPInc] [smallint] NOT NULL,
	[EXPearned] [int] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LUnitDailyPlay]', N'U') IS NULL
CREATE TABLE [dbo].[LUnitDailyPlay](
	[RegDate] [char](8) NOT NULL,
	[UnitUID] [bigint] NOT NULL,
	[AuthLevel] [tinyint] NOT NULL,
	[UseSpirit] [int] NOT NULL,
	[AllSpirit] [bit] NOT NULL,
	[TotalPlayTime] [int] NOT NULL,
	[DurationTime] [int] NOT NULL,
	[DSoloCnt] [int] NOT NULL,
	[DPartyCnt] [int] NOT NULL,
	[DSWCnt] [int] NOT NULL,
	[DPWCnt] [int] NOT NULL,
	[DSPlayTime] [int] NOT NULL,
	[DPPlayTime] [int] NOT NULL,
	[VsKillCnt] [int] NOT NULL,
	[VsWinCnt] [smallint] NOT NULL,
	[VsLoseCnt] [smallint] NOT NULL,
	[VsPlayTime] [int] NOT NULL,
	[TrainingPT] [int] NOT NULL,
	[TrainingCnt] [smallint] NOT NULL,
	[P2PCnt] [smallint] NOT NULL,
	[SquareCnt] [smallint] NOT NULL,
	[SquarePlayTime] [int] NOT NULL,
	[BuyItemCnt] [smallint] NOT NULL,
	[SellItemCnt] [smallint] NOT NULL,
	[GetItemCnt] [smallint] NOT NULL,
	[PCBangFlag] [bit] NOT NULL,
	[UseStone] [smallint] NOT NULL,
 CONSTRAINT [PKC_LUnitDailyPlay_RegDate_UnitUID] PRIMARY KEY CLUSTERED 
(
	[RegDate] ASC,
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LUnitDailyGamePoint]', N'U') IS NULL
CREATE TABLE [dbo].[LUnitDailyGamePoint](
	[RegDate] [char](8) NOT NULL,
	[UnitUID] [bigint] NOT NULL,
	[PTotal] [bigint] NOT NULL,
	[MTotal] [bigint] NOT NULL,
	[TotalDiff] [int] NOT NULL,
	[PDungeon] [int] NOT NULL,
	[PTraining] [int] NOT NULL,
	[PQuest] [int] NOT NULL,
	[PItemSell] [int] NOT NULL,
	[PItemTrade] [bigint] NOT NULL,
	[PPersonalShop] [bigint] NOT NULL,
	[PPostLetter] [bigint] NOT NULL,
	[MItemBuy] [int] NOT NULL,
	[MItemTrade] [bigint] NOT NULL,
	[MItemRepair] [int] NOT NULL,
	[MItemEnchant] [bigint] NOT NULL,
	[MItemSocket] [int] NOT NULL,
	[MItemAttribute] [int] NOT NULL,
	[MManufacture] [int] NOT NULL,
	[MDunPenalty] [int] NOT NULL,
	[MPersonalShop] [bigint] NOT NULL,
	[MOpenPShop] [bigint] NOT NULL,
	[MSellTaxPShop] [int] NOT NULL,
	[MBuyTaxPShop] [int] NOT NULL,
	[MPostLetter] [bigint] NOT NULL,
	[MSendLetterBasic] [int] NOT NULL,
	[MSendLetterItem] [int] NOT NULL,
	[MOpenCubeSpendED] [bigint] NOT NULL,
	[PBattleFieldED] [bigint] NOT NULL,
	[MCoboExpressTicketED] [bigint] NOT NULL,
	[MItemDecom] [bigint] NOT NULL,
 CONSTRAINT [PKC_LUnitDailyGamePoint_RegDate_UnitUID] PRIMARY KEY CLUSTERED 
(
	[RegDate] ASC,
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LUnitConnectLog]', N'U') IS NULL
CREATE TABLE [dbo].[LUnitConnectLog](
	[LogID] [bigint] IDENTITY(1,1) NOT NULL,
	[ServerUID] [int] NOT NULL,
	[UnitUID] [bigint] NOT NULL,
	[NickName] [nvarchar](40) NOT NULL,
	[UnitClass] [tinyint] NOT NULL,
	[Exp] [int] NOT NULL,
	[Level] [tinyint] NOT NULL,
	[logintime] [datetime] NOT NULL,
	[logouttime] [datetime] NOT NULL,
	[PlayTime] [int] NOT NULL,
	[PCBangFlag] [bit] NOT NULL,
	[AuthLevel] [tinyint] NOT NULL,
	[loginLevel] [tinyint] NOT NULL,
 CONSTRAINT [PK_LUnitConnectLog_LogID] PRIMARY KEY NONCLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LUDPRelayCheck]', N'U') IS NULL
CREATE TABLE [dbo].[LUDPRelayCheck](
	[UID] [int] NOT NULL,
	[IP] [nvarchar](15) NOT NULL,
	[AvgDelayTime] [int] NOT NULL,
	[MaxDelayTime] [int] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LTradeBank]', N'U') IS NULL
CREATE TABLE [dbo].[LTradeBank](
	[LogID] [bigint] IDENTITY(1,1) NOT NULL,
	[ServerSetID] [tinyint] NOT NULL,
	[FromUnitUID] [bigint] NULL,
	[ToUnitUID] [bigint] NULL,
	[FromItemUID] [bigint] NOT NULL,
	[ToItemUID] [bigint] NOT NULL,
	[ItemID] [int] NULL,
	[SealCnt] [int] NULL,
	[RegDate] [smalldatetime] NOT NULL,
 CONSTRAINT [LTradeItem] PRIMARY KEY NONCLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LTrade]', N'U') IS NULL
CREATE TABLE [dbo].[LTrade](
	[idx] [bigint] IDENTITY(1,1) NOT NULL,
	[ServerSetID] [tinyint] NULL,
	[FromUserUID] [bigint] NOT NULL,
	[FromUnitUID] [bigint] NOT NULL,
	[ToUserUID] [bigint] NOT NULL,
	[ToUnitUID] [bigint] NOT NULL,
	[ItemUID] [bigint] NOT NULL,
	[ItemID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL,
	[IsUpdate] [bit] NOT NULL,
 CONSTRAINT [PK_LTrade_idx] PRIMARY KEY NONCLUSTERED 
(
	[idx] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LToolServerList]', N'U') IS NULL
CREATE TABLE [dbo].[LToolServerList](
	[ServerUID] [int] NOT NULL,
	[ServerSetID] [int] NULL,
	[ServerType] [int] NULL,
	[ChannelID] [int] NULL,
	[ChannelName] [nvarchar](20) NULL,
	[IP] [nvarchar](15) NULL,
	[Port] [int] NULL,
 CONSTRAINT [PK_LToolServerList] PRIMARY KEY CLUSTERED 
(
	[ServerUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UQ_LToolServerList_ServerUID] UNIQUE NONCLUSTERED 
(
	[ServerUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LStatsDailyRemainMoney]', N'U') IS NULL
CREATE TABLE [dbo].[LStatsDailyRemainMoney](
	[ServerSetID] [tinyint] NOT NULL,
	[RegDate] [char](10) NOT NULL,
	[TotalRemain] [bigint] NULL,
	[AvgRemain] [bigint] NULL,
	[UserAvgRemain] [bigint] NULL,
 CONSTRAINT [PK_LStatsDailyRemainMoney] PRIMARY KEY CLUSTERED 
(
	[ServerSetID] ASC,
	[RegDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LSquareTable]', N'U') IS NULL
CREATE TABLE [dbo].[LSquareTable](
	[IP] [nvarchar](20) NOT NULL,
	[Type] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LSkillPointLog]', N'U') IS NULL
CREATE TABLE [dbo].[LSkillPointLog](
	[ServerGroupID] [int] NULL,
	[UserUID] [bigint] NULL,
	[UnitUID] [bigint] NULL,
	[UnitClass] [int] NULL,
	[Level] [int] NULL,
	[SPoint] [int] NULL,
	[UsedSPoint] [int] NULL,
	[CSPoint] [int] NULL,
	[UsedCSPoint] [int] NULL,
	[MaxCSPoint] [int] NULL,
	[CorrectionSP] [int] NULL,
	[Regdate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LSimProxy]', N'U') IS NULL
CREATE TABLE [dbo].[LSimProxy](
	[ServerSetID] [tinyint] NULL,
	[ServerUID] [int] NULL,
	[ProxyID] [tinyint] NULL,
	[ProxyType] [tinyint] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LServerSimLayerTickLog]', N'U') IS NULL
CREATE TABLE [dbo].[LServerSimLayerTickLog](
	[ServerUID] [bigint] NULL,
	[ServerType] [tinyint] NULL,
	[MaxTickCount] [int] NULL,
	[MaxTickRegDate] [smalldatetime] NULL,
	[RegDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LServerSetList]', N'U') IS NULL
CREATE TABLE [dbo].[LServerSetList](
	[ServerSetID] [tinyint] NOT NULL,
	[ServerSetName] [nvarchar](50) NOT NULL,
	[ServerSetOrder] [tinyint] NOT NULL,
	[ServerGameDB] [nvarchar](50) NULL,
	[ServerGameDBName] [nvarchar](50) NULL,
	[ServerStatisticsDB] [nvarchar](50) NULL,
	[ServerStatisticsDBName] [nvarchar](50) NULL,
	[ServerAccountDB] [nvarchar](50) NULL,
	[ServerAccountDBName] [nvarchar](50) NULL,
	[sDefaultServer] [bit] NOT NULL,
 CONSTRAINT [PK_LServerSetList] PRIMARY KEY CLUSTERED 
(
	[ServerSetID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LServerList]', N'U') IS NULL
CREATE TABLE [dbo].[LServerList](
	[UID] [int] NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
	[ServerSetID] [tinyint] NOT NULL,
	[ServerType] [tinyint] NOT NULL,
	[Port1] [smallint] NOT NULL,
	[Port2] [smallint] NOT NULL,
	[MaxConcurrentUser] [smallint] NOT NULL,
	[ConcurrentUser] [smallint] NOT NULL,
	[Enable] [bit] NOT NULL,
	[ServerRollType] [tinyint] NULL,
	[PublicIP] [nvarchar](15) NULL,
	[PrivateIP] [nvarchar](15) NULL,
	[IP] [nvarchar](15) NULL,
 CONSTRAINT [PK_LServerList] PRIMARY KEY CLUSTERED 
(
	[UID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LServer_GSUser_Packet_Latency]', N'U') IS NULL
CREATE TABLE [dbo].[LServer_GSUser_Packet_Latency](
	[ServerUID] [int] NOT NULL,
	[PacketID] [nvarchar](50) NOT NULL,
	[Latency] [int] NOT NULL,
	[MaxDate] [smalldatetime] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL,
	[UnitUID] [bigint] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LServer_ErrorLog]', N'U') IS NULL
CREATE TABLE [dbo].[LServer_ErrorLog](
	[ServerUID] [int] NULL,
	[FunctionName] [nvarchar](100) NULL,
	[FileName] [nvarchar](200) NULL,
	[LineNum] [nvarchar](10) NULL,
	[Count] [int] NULL,
	[RegDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LServer_CnProxy_Packet_Count]', N'U') IS NULL
CREATE TABLE [dbo].[LServer_CnProxy_Packet_Count](
	[ServerUID] [int] NOT NULL,
	[PacketID] [nvarchar](50) NOT NULL,
	[Count] [int] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LSecurityTypeLog]', N'U') IS NULL
CREATE TABLE [dbo].[LSecurityTypeLog](
	[UserUID] [bigint] NOT NULL,
	[SecurityType] [tinyint] NOT NULL,
	[Age] [tinyint] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LRetainLog]', N'U') IS NULL
CREATE TABLE [dbo].[LRetainLog](
	[UserUID] [bigint] NOT NULL,
	[UnitUID] [bigint] NOT NULL,
	[ItemID] [int] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LQuestInfo]', N'U') IS NULL
CREATE TABLE [dbo].[LQuestInfo](
	[QuestID] [int] NOT NULL,
	[Accept] [int] NOT NULL,
	[GiveUp] [int] NOT NULL,
	[Complete] [int] NOT NULL,
	[AcceptLevel] [int] NOT NULL,
	[GiveUpLevel] [int] NOT NULL,
	[CompleteLevel] [int] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LProductList]', N'U') IS NULL
CREATE TABLE [dbo].[LProductList](
	[ProductNo] [int] NOT NULL,
	[ProductExpire] [smallint] NOT NULL,
	[ProductPieces] [smallint] NOT NULL,
	[ItemID] [int] NOT NULL,
	[SalePrice] [int] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LPost_TradeMonitor]', N'U') IS NULL
CREATE TABLE [dbo].[LPost_TradeMonitor](
	[ServerSetID] [tinyint] NULL,
	[ToUnitUID] [bigint] NULL,
	[RegDate] [smalldatetime] NULL,
	[Type] [tinyint] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LPetEvolution]', N'U') IS NULL
CREATE TABLE [dbo].[LPetEvolution](
	[UnitUID] [bigint] NULL,
	[PetUID] [bigint] NULL,
	[PetID] [bigint] NULL,
	[EventItemID] [bigint] NULL,
	[Regdate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LPerformance]', N'U') IS NULL
CREATE TABLE [dbo].[LPerformance](
	[UnitUID] [bigint] NULL,
	[RoomUID] [bigint] NULL,
	[GameType] [smallint] NULL,
	[Host] [bit] NULL,
	[Leave] [bit] NULL,
	[NumOfP2P] [smallint] NULL,
	[NumOfRelay] [smallint] NULL,
	[AVGPing] [int] NULL,
	[BestPing] [int] NULL,
	[WorstPing] [int] NULL,
	[PingStandardDeviation] [float] NULL,
	[PacketLossRate] [float] NULL,
	[AVGFrameMovePerSec] [float] NULL,
	[MAXFrameMovePerSec] [float] NULL,
	[MINFrameMovePerSec] [float] NULL,
	[FrameMovePerSecStandardDeviation] [float] NULL,
	[FrameAVG] [smallint] NULL,
	[AvailableMemory] [bigint] NULL,
	[TotalMemory] [int] NULL,
	[ProcessorName] [nvarchar](50) NULL,
	[WindowsVersion] [nvarchar](50) NULL,
	[D3DDeviceName] [nvarchar](50) NULL,
	[Regdate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LPCBangList]', N'U') IS NULL
CREATE TABLE [dbo].[LPCBangList](
	[IP] [nvarchar](15) NOT NULL,
	[PC_Type] [tinyint] NULL,
	[RegDate] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_LPCBangList_IP] PRIMARY KEY CLUSTERED 
(
	[IP] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LP2P_RelayLog]', N'U') IS NULL
CREATE TABLE [dbo].[LP2P_RelayLog](
	[GameType] [tinyint] NULL,
	[TryCount] [smallint] NULL,
	[P2PPlayTime] [int] NULL,
	[RelayPlayTime] [int] NULL,
	[RelayIP] [nvarchar](15) NULL,
	[RegDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LNonExistentModuleLog]', N'U') IS NULL
CREATE TABLE [dbo].[LNonExistentModuleLog](
	[ServerSN] [bigint] NOT NULL,
	[UserUID] [bigint] NOT NULL,
	[ModuleName] [nvarchar](20) NOT NULL,
	[RegDate] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LNetCafeList]', N'U') IS NULL
CREATE TABLE [dbo].[LNetCafeList](
	[IP] [nvarchar](15) NOT NULL,
	[PC_Type] [tinyint] NULL,
	[RegDate] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_LNetCafeList] PRIMARY KEY CLUSTERED 
(
	[IP] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LModuleTable]', N'U') IS NULL
CREATE TABLE [dbo].[LModuleTable](
	[ModuleUID] [int] IDENTITY(1,1) NOT NULL,
	[ModuleName] [nvarchar](40) NOT NULL,
	[count] [bigint] NOT NULL,
	[allow] [bit] NULL,
	[flag] [tinyint] NULL,
 CONSTRAINT [PK_LModule_ModuleUID] PRIMARY KEY CLUSTERED 
(
	[ModuleUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LLoginProxy]', N'U') IS NULL
CREATE TABLE [dbo].[LLoginProxy](
	[ServerSetID] [tinyint] NOT NULL,
	[ServerUID] [int] NOT NULL,
	[ProxyID] [tinyint] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LKomFileLog]', N'U') IS NULL
CREATE TABLE [dbo].[LKomFileLog](
	[UserUID] [bigint] NOT NULL,
	[KomName] [nvarchar](100) NULL,
	[Regdate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LItemSynthesis]', N'U') IS NULL
CREATE TABLE [dbo].[LItemSynthesis](
	[LogID] [int] IDENTITY(1,1) NOT NULL,
	[ServerSetID] [tinyint] NOT NULL,
	[UnitUID] [bigint] NOT NULL,
	[Level] [tinyint] NOT NULL,
	[BeforeItemUID_1] [bigint] NOT NULL,
	[BeforeItemUID_2] [bigint] NOT NULL,
	[BeforeItemUID_3] [bigint] NOT NULL,
	[BeforeItemUID_4] [bigint] NOT NULL,
	[BeforeItemUID_5] [bigint] NOT NULL,
	[AfterItemUID] [bigint] NOT NULL,
	[AfterItemID] [bigint] NOT NULL,
	[RegDate] [datetime] NOT NULL,
 CONSTRAINT [PKC_LItemSynthesis_LogID] PRIMARY KEY NONCLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LItemOnOff]', N'U') IS NULL
CREATE TABLE [dbo].[LItemOnOff](
	[UID] [int] IDENTITY(1,1) NOT NULL,
	[ItemID] [bigint] NOT NULL,
	[sType] [tinyint] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[RegDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LItemLog]', N'U') IS NULL
CREATE TABLE [dbo].[LItemLog](
	[ServerSetID] [tinyint] NULL,
	[ItemID] [int] NOT NULL,
	[Trade] [int] NOT NULL,
	[PShop] [int] NOT NULL,
	[TBoard] [int] NOT NULL,
	[Buy] [int] NOT NULL,
	[Sell] [int] NOT NULL,
	[Use] [int] NOT NULL,
	[Make] [int] NOT NULL,
	[Failed] [int] NOT NULL,
	[Drop] [int] NOT NULL,
	[Quest] [int] NOT NULL,
	[Equip] [int] NOT NULL,
	[Random] [int] NOT NULL,
	[Resolve] [int] NOT NULL,
	[R_Result] [int] NOT NULL,
	[Mall] [int] NOT NULL,
	[Post] [int] NOT NULL,
	[Attrib] [int] NOT NULL,
	[Exchange_S] [int] NOT NULL,
	[Exchange_R] [int] NOT NULL,
	[Discard] [int] NOT NULL,
	[PetFeed] [int] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL,
	[ServerUID] [int] NULL,
	[RegPShop] [int] NOT NULL,
	[BuyPShopAgency] [int] NOT NULL,
	[PickUpPShop] [int] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LInternalID]', N'U') IS NULL
CREATE TABLE [dbo].[LInternalID](
	[ID] [nvarchar](255) NOT NULL,
	[UserUID] [bigint] NULL,
 CONSTRAINT [PKC_LInternalID_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LHackProcessList]', N'U') IS NULL
CREATE TABLE [dbo].[LHackProcessList](
	[ProcessName] [nvarchar](200) NULL,
	[ClassName] [nvarchar](200) NULL,
	[ListType] [tinyint] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LGlobalProxy]', N'U') IS NULL
CREATE TABLE [dbo].[LGlobalProxy](
	[ServerSetID] [tinyint] NOT NULL,
	[ServerUID] [int] NOT NULL,
	[ProxyID] [tinyint] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LFriendSystem_Ranker]', N'U') IS NULL
CREATE TABLE [dbo].[LFriendSystem_Ranker](
	[UnitUID] [bigint] NOT NULL,
 CONSTRAINT [PKC_LFriendSystem_Ranker_UnitUID] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LFriendSystem_LastReset]', N'U') IS NULL
CREATE TABLE [dbo].[LFriendSystem_LastReset](
	[Num] [int] NOT NULL,
	[LastResetDate] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LFieldLog]', N'U') IS NULL
CREATE TABLE [dbo].[LFieldLog](
	[LogID] [bigint] IDENTITY(1,1) NOT NULL,
	[ServerSetID] [tinyint] NULL,
	[ServerIP] [nvarchar](15) NULL,
	[RoomUID] [bigint] NULL,
	[EndType] [tinyint] NULL,
	[UnitUID] [bigint] NULL,
	[NickName] [nvarchar](20) NULL,
	[UnitClass] [tinyint] NULL,
	[LV] [tinyint] NULL,
	[PlayTime] [int] NULL,
	[EXP] [int] NULL,
	[ED] [int] NULL,
	[RegDate] [smalldatetime] NULL,
	[FieldID] [int] NULL,
	[Frame] [smallint] NULL,
	[NPCDieCount] [int] NULL,
 CONSTRAINT [PK_LFieldLog_LogID] PRIMARY KEY NONCLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LExpo_Event]', N'U') IS NULL
CREATE TABLE [dbo].[LExpo_Event](
	[ServerSetID] [tinyint] NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ServerUID] [int] NOT NULL,
	[NPCID] [int] NOT NULL,
	[KillUnitUID] [bigint] NOT NULL,
	[DropDate] [smalldatetime] NOT NULL,
	[DieDate] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_LExpo_Event_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LExitLog]', N'U') IS NULL
CREATE TABLE [dbo].[LExitLog](
	[UnitUID] [bigint] NULL,
	[DungeonID] [int] NULL,
	[StartMember] [tinyint] NULL,
	[NowMember] [tinyint] NULL,
	[VoteMember] [tinyint] NULL,
	[ExitStage] [tinyint] NULL,
	[ExitSubStage] [tinyint] NULL,
	[ExitPoint] [tinyint] NULL,
	[RegDate] [datetime] NULL,
	[ExitResult] [bit] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LExchangeLog]', N'U') IS NULL
CREATE TABLE [dbo].[LExchangeLog](
	[UnitUID] [bigint] NULL,
	[UserUID] [bigint] NULL,
	[ItemID_I] [int] NULL,
	[Quantity_I] [smallint] NULL,
	[ItemID_O] [int] NULL,
	[Quantity_O] [smallint] NULL,
	[ExchangeType] [tinyint] NULL,
	[RegDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LEvent_Rank_TimeSpace]', N'U') IS NULL
CREATE TABLE [dbo].[LEvent_Rank_TimeSpace](
	[Rank] [tinyint] NULL,
	[UnitUID] [bigint] NOT NULL,
	[NickName] [nvarchar](24) NULL,
	[UnitClass] [tinyint] NULL,
	[Level] [tinyint] NULL,
	[Point] [smallint] NULL,
 CONSTRAINT [PKC_LEvent_Rank_TimeSpace_UnitUID] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LEvent_Rank_Dungeon]', N'U') IS NULL
CREATE TABLE [dbo].[LEvent_Rank_Dungeon](
	[Rank] [tinyint] NULL,
	[UnitUID] [bigint] NOT NULL,
	[NickName] [nvarchar](24) NULL,
	[UnitClass] [tinyint] NULL,
	[Level] [tinyint] NULL,
	[Point] [smallint] NULL,
 CONSTRAINT [PKC_LEvent_Rank_Dungeon_UnitUID] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LEvent_Jackpot]', N'U') IS NULL
CREATE TABLE [dbo].[LEvent_Jackpot](
	[CouponNumber] [nvarchar](30) NOT NULL,
	[BeginDate] [smalldatetime] NOT NULL,
	[EndDate] [smalldatetime] NULL,
	[DropDate] [smalldatetime] NULL,
	[UserUID] [bigint] NULL,
	[UnitUID] [bigint] NULL,
	[State] [tinyint] NULL,
 CONSTRAINT [PK_LEvent_Jackpot_CouponNumber] PRIMARY KEY CLUSTERED 
(
	[CouponNumber] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LEvent_Christmas]', N'U') IS NULL
CREATE TABLE [dbo].[LEvent_Christmas](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ItemID] [int] NOT NULL,
	[DropTime] [smalldatetime] NOT NULL,
	[UpdTime] [smalldatetime] NOT NULL,
	[UserUID] [bigint] NOT NULL,
	[UnitUID] [bigint] NOT NULL,
	[DropEndTime] [smalldatetime] NULL,
	[CubeID] [int] NULL,
 CONSTRAINT [PK_LEvent_Christmas_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LEquipmentLog]', N'U') IS NULL
CREATE TABLE [dbo].[LEquipmentLog](
	[ServerSetID] [tinyint] NULL,
	[UnitUID] [bigint] NULL,
	[UnitLevel] [tinyint] NULL,
	[DungeonID] [int] NULL,
	[Difficulty] [tinyint] NULL,
	[WeaponLevel] [tinyint] NULL,
	[WeaponClass] [tinyint] NULL,
	[PhysicalAttack] [int] NULL,
	[MagicAttack] [int] NULL,
	[Regdate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LEnchantLog]', N'U') IS NULL
CREATE TABLE [dbo].[LEnchantLog](
	[UnitUID] [bigint] NOT NULL,
	[ItemUID] [bigint] NOT NULL,
	[ItemID] [int] NOT NULL,
	[IsPluor] [bit] NOT NULL,
	[BeforeELv] [tinyint] NOT NULL,
	[AfterELv] [tinyint] NOT NULL,
	[EnchantType] [tinyint] NOT NULL,
	[RegDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LEDBuffeffect]', N'U') IS NULL
CREATE TABLE [dbo].[LEDBuffeffect](
	[LogUID] [bigint] IDENTITY(1,1) NOT NULL,
	[UnitUID] [bigint] NOT NULL,
	[BuffID] [int] NOT NULL,
	[UseDate] [smalldatetime] NOT NULL,
	[EndDate] [smalldatetime] NOT NULL,
	[DurationTime] [int] NOT NULL,
	[ItemID] [int] NOT NULL,
	[DungeonOnly] [bit] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_LEDBuffeffect] PRIMARY KEY CLUSTERED 
(
	[LogUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LDungeonTimeHackUser]', N'U') IS NULL
CREATE TABLE [dbo].[LDungeonTimeHackUser](
	[UserUID] [bigint] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL,
 CONSTRAINT [PKC_LDungeonTimeHackUser_UserUID] PRIMARY KEY CLUSTERED 
(
	[UserUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LDungeonLog]', N'U') IS NULL
CREATE TABLE [dbo].[LDungeonLog](
	[Seq] [int] IDENTITY(1,1) NOT NULL,
	[ServerSetID] [tinyint] NULL,
	[ServerIP] [nvarchar](15) NULL,
	[DungeonID] [int] NULL,
	[UnitUID] [bigint] NULL,
	[NickName] [nvarchar](20) NULL,
	[Diffculty] [tinyint] NULL,
	[IsChallenge] [bit] NULL,
	[UnitClass] [tinyint] NULL,
	[Clear] [tinyint] NULL,
	[StartMember] [tinyint] NULL,
	[EndMemeber] [tinyint] NULL,
	[LV] [tinyint] NULL,
	[PlayTime] [int] NULL,
	[EXP] [int] NULL,
	[ED] [int] NULL,
	[Combo] [tinyint] NULL,
	[ComboScore] [int] NULL,
	[Technical] [tinyint] NULL,
	[TechnScore] [int] NULL,
	[Time] [tinyint] NULL,
	[Damaged] [tinyint] NULL,
	[DamagedNum] [int] NULL,
	[Rank] [tinyint] NULL,
	[Continue] [tinyint] NULL,
	[PassStage] [tinyint] NULL,
	[PassSubSt] [tinyint] NULL,
	[WithPet] [bit] NULL,
	[RegDate] [smalldatetime] NULL,
	[NpcDieCount] [smallint] NULL,
	[GivenDamage] [bigint] NULL,
	[AttackDamage] [bigint] NULL,
	[UsingSkillKind] [smallint] NULL,
	[TotalEXP] [int] NULL,
	[PetID] [int] NULL,
	[PetEvoStep] [tinyint] NULL,
	[DashCount] [int] NULL,
	[EndHP] [int] NULL,
	[StartContinue] [smallint] NULL,
	[ContinueUseStage] [smallint] NULL,
	[ContinueUseSub] [smallint] NULL,
	[Frame] [smallint] NULL,
	[BaseHP] [int] NULL,
	[RecovHP] [int] NULL,
	[ChannelIP] [nvarchar](15) NULL,
	[UserUID] [bigint] NULL,
	[IsMatchStart] [bit] NULL,
	[MatchWait] [int] NULL,
	[LeaveReason] [int] NULL,
	[RoomState] [tinyint] NULL,
	[SkillSlotType] [bit] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LDungeonLeaveLog]', N'U') IS NULL
CREATE TABLE [dbo].[LDungeonLeaveLog](
	[UnitUID] [bigint] NULL,
	[LeaveReason] [nvarchar](30) NULL,
	[RoomState] [nvarchar](30) NULL,
	[RegDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LDisconnectUserFSM]', N'U') IS NULL
CREATE TABLE [dbo].[LDisconnectUserFSM](
	[ServerSetID] [tinyint] NULL,
	[ServerUID] [int] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL,
	[S_INIT] [int] NOT NULL,
	[S_UID_UPDATED] [int] NOT NULL,
	[S_LOGINED] [int] NOT NULL,
	[S_SERVER_SELECT] [int] NOT NULL,
	[S_UNIT_SELECT] [int] NOT NULL,
	[S_VILLAGE_MAP] [int] NOT NULL,
	[S_LOCAL_MAP] [int] NOT NULL,
	[S_WORLD_MAP] [int] NOT NULL,
	[S_CHANNEL] [int] NOT NULL,
	[S_ROOM] [int] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LDisconnectReason_New]', N'U') IS NULL
CREATE TABLE [dbo].[LDisconnectReason_New](
	[IDX] [bigint] IDENTITY(1,1) NOT NULL,
	[ServerUID] [int] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL,
	[DisconnectType] [int] NOT NULL,
	[CNT] [int] NOT NULL,
 CONSTRAINT [IXC_LDisconnectReason_New_IDX] PRIMARY KEY CLUSTERED 
(
	[IDX] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LDisconnectReason_abnormal]', N'U') IS NULL
CREATE TABLE [dbo].[LDisconnectReason_abnormal](
	[ServerSetID] [tinyint] NOT NULL,
	[ChannelID] [int] NOT NULL,
	[ServerUID] [int] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL,
	[S_INIT] [int] NOT NULL,
	[S_UID_UPDATED] [int] NOT NULL,
	[S_LOGINED] [int] NOT NULL,
	[S_SERVER_SELECT] [int] NOT NULL,
	[S_UNIT_SELECT] [int] NOT NULL,
	[S_VILLAGE_MAP] [int] NOT NULL,
	[S_LOCAL_MAP] [int] NOT NULL,
	[S_WORLD_MAP] [int] NOT NULL,
	[S_CHANNEL] [int] NOT NULL,
	[S_ROOM] [int] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LDisconnectReason]', N'U') IS NULL
CREATE TABLE [dbo].[LDisconnectReason](
	[ServerSetID] [tinyint] NULL,
	[ServerUID] [int] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL,
	[No_Reason] [int] NOT NULL,
	[Unknown] [int] NOT NULL,
	[NProtect_Auth_Fail] [int] NOT NULL,
	[PCBang_Auth_Delay] [int] NOT NULL,
	[Diff_Main_Ver] [int] NOT NULL,
	[Limit_User_Num] [int] NOT NULL,
	[Nexon_Auth_Fail] [int] NOT NULL,
	[Same_Server_Connect] [int] NOT NULL,
	[Account_Block] [int] NOT NULL,
	[IP_Block] [int] NOT NULL,
	[NProtect_Auth_First] [int] NOT NULL,
	[PCBang_Auth_Fail] [int] NOT NULL,
	[PCBang_Auth_Wrong] [int] NOT NULL,
	[Internal_Account] [int] NOT NULL,
	[Normal_Disconnect] [int] NOT NULL,
	[Client_Crash] [int] NOT NULL,
	[Client_Hacking] [int] NOT NULL,
	[NProtect_Wrong_Ack] [int] NOT NULL,
	[PCBang_Auth_Server] [int] NOT NULL,
	[Server_Shutdown] [int] NOT NULL,
	[Session_Close] [int] NOT NULL,
	[WSAECONNRESET] [int] NOT NULL,
	[WSARecvFailed] [int] NOT NULL,
	[WSASendFailed_OnSendComp] [int] NOT NULL,
	[SendBufferFull] [int] NOT NULL,
	[WSASendFailed] [int] NOT NULL,
	[GM_Kick_User] [int] NOT NULL,
	[Diff_Server_Connect] [int] NOT NULL,
	[User_Reg_Error] [int] NOT NULL,
	[Heart_Beat] [int] NOT NULL,
	[IOCP_GetStatus] [int] NOT NULL,
	[NProtect_Hacking] [int] NOT NULL,
	[ChannelChange] [int] NOT NULL,
	[Channel_Change_Fail] [int] NOT NULL,
	[Traffic_Attack] [int] NOT NULL,
	[ServerAccBlock] [smallint] NOT NULL,
	[MachineIDBlock] [int] NOT NULL,
	[Same_MachineID_Connect] [int] NOT NULL,
	[Shutdown_System] [int] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LDefense_Crystal]', N'U') IS NULL
CREATE TABLE [dbo].[LDefense_Crystal](
	[ServerSetID] [tinyint] NULL,
	[TargetCrystal] [int] NOT NULL,
	[WsrtStartTime] [smalldatetime] NOT NULL,
	[ProtectedCrystalCount] [int] NOT NULL,
 CONSTRAINT [PK_LDefense_Crystal_WsrtStartTime] PRIMARY KEY CLUSTERED 
(
	[WsrtStartTime] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LConnectLog]', N'U') IS NULL
CREATE TABLE [dbo].[LConnectLog](
	[ServerSetID] [tinyint] NULL,
	[UserUID] [bigint] NOT NULL,
	[IP] [nvarchar](15) NOT NULL,
	[LoginTime] [smalldatetime] NOT NULL,
	[LogoutTime] [smalldatetime] NOT NULL,
	[LoginFail] [bit] NOT NULL,
	[LogoutFail] [bit] NOT NULL,
	[TotalPlayTime] [int] NOT NULL,
	[VsPlayTime] [int] NOT NULL,
	[ArcadePlayTime] [int] NOT NULL,
	[DisconnectReason] [tinyint] NULL,
	[DisconnectUserFSM] [int] NULL,
	[ConnectUID] [int] IDENTITY(1,1) NOT NULL,
	[DungeonPlayTime] [int] NULL,
	[FieldPlayTime] [int] NULL,
	[ChannelCode] [int] NULL,
	[PCBangFlag] [bit] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LComebackUserLog]', N'U') IS NULL
CREATE TABLE [dbo].[LComebackUserLog](
	[UserUID] [bigint] NOT NULL,
	[Age] [tinyint] NOT NULL,
	[UnitUID] [bigint] NOT NULL,
	[UnitClass] [tinyint] NOT NULL,
	[Level] [tinyint] NOT NULL,
	[IsFirstLogin] [bit] NOT NULL,
	[ComebackGrade] [tinyint] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LClientPerformance_Village_VillageInfo]', N'U') IS NULL
CREATE TABLE [dbo].[LClientPerformance_Village_VillageInfo](
	[UnitUID] [bigint] NULL,
	[SystemKey] [bigint] NULL,
	[AvgFrame] [float] NULL,
	[AvgFrame_StdDev] [float] NULL,
	[FirstMemUsageCheck] [bit] NULL,
	[MinWorkingSetSize] [float] NULL,
	[MaxWorkingSetSize] [float] NULL,
	[MinPagefileUsage] [float] NULL,
	[MaxPagefileUsage] [float] NULL,
	[PartyType] [int] NULL,
	[PartyUserNum] [int] NULL,
	[MapID] [int] NULL,
	[VillageUserNum] [int] NULL,
	[RegDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LClientPerformance_Village_UnknownLagInfo]', N'U') IS NULL
CREATE TABLE [dbo].[LClientPerformance_Village_UnknownLagInfo](
	[UnitUID] [bigint] NULL,
	[SystemKey] [bigint] NULL,
	[LagType] [int] NULL,
	[PartyType] [int] NULL,
	[PartyUserNum] [int] NULL,
	[MapID] [int] NULL,
	[VillageUserNum] [int] NULL,
	[LagTime] [float] NULL,
	[PlayTime] [float] NULL,
	[LagTotalNum] [float] NULL,
	[LagTotalTime] [float] NULL,
	[RegDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LClientPerformance_Village_knownLagInfo]', N'U') IS NULL
CREATE TABLE [dbo].[LClientPerformance_Village_knownLagInfo](
	[UnitUID] [bigint] NULL,
	[SystemKey] [bigint] NULL,
	[LagType] [int] NULL,
	[PartyType] [int] NULL,
	[PartyUserNum] [int] NULL,
	[MapID] [int] NULL,
	[VillageUserNum] [int] NULL,
	[LagTime] [float] NULL,
	[PlayTime] [float] NULL,
	[LagTotalNum] [float] NULL,
	[LagTotalTime] [float] NULL,
	[RegDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LClientPerformance_UserPCInfo]', N'U') IS NULL
CREATE TABLE [dbo].[LClientPerformance_UserPCInfo](
	[UserUID] [bigint] NULL,
	[SystemKey] [bigint] NULL,
	[CPU] [nvarchar](200) NULL,
	[Memory] [nvarchar](100) NULL,
	[GPU] [nvarchar](100) NULL,
	[OS] [nvarchar](100) NULL,
	[RegDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LClientPerformance_PVP_UnknownLagInfo]', N'U') IS NULL
CREATE TABLE [dbo].[LClientPerformance_PVP_UnknownLagInfo](
	[UnitUID] [bigint] NULL,
	[SystemKey] [bigint] NULL,
	[LagType] [int] NULL,
	[MapID] [int] NULL,
	[PVPUserNum] [int] NULL,
	[PVPType] [int] NULL,
	[LastRound] [int] NULL,
	[LagTime] [float] NULL,
	[PlayTime] [float] NULL,
	[LagTotalNum] [float] NULL,
	[LagTotalTime] [float] NULL,
	[RegDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LClientPerformance_PVP_PVPInfo]', N'U') IS NULL
CREATE TABLE [dbo].[LClientPerformance_PVP_PVPInfo](
	[UnitUID] [bigint] NULL,
	[SystemKey] [bigint] NULL,
	[AvgFrame] [float] NULL,
	[AvgFrame_StdDev] [float] NULL,
	[P2PMinPingTime] [float] NULL,
	[P2PMaxPingTime] [float] NULL,
	[P2PAvgPingTime] [float] NULL,
	[P2PAvgPingTime_StdDev] [float] NULL,
	[P2PAvgPingLossRate] [float] NULL,
	[RelayMinPingTime] [float] NULL,
	[RelayMaxPingTime] [float] NULL,
	[RelayAvgPingTime] [float] NULL,
	[RelayAvgPingTime_StdDev] [float] NULL,
	[RelayAvgPingLossRate] [float] NULL,
	[TCPMinPingTime] [float] NULL,
	[TCPMaxPingTime] [float] NULL,
	[TCPAvgPingTime] [float] NULL,
	[TCPAvgPingTime_StdDev] [float] NULL,
	[UDPMinPingTime] [float] NULL,
	[UDPMaxPingTime] [float] NULL,
	[UDPAvgPingTime] [float] NULL,
	[UDPAvgPingTime_StdDev] [float] NULL,
	[UDPAvgPingLossRate] [float] NULL,
	[UDPSendCountPerSecHost] [float] NULL,
	[UDPSendAmountPerSecHost] [float] NULL,
	[UDPRecvCountPerSecHost] [float] NULL,
	[UDPRecvAmountPerSecHost] [float] NULL,
	[UDPSendCountPerSec] [float] NULL,
	[UDPSendAmountPerSec] [float] NULL,
	[UDPRecvCountPerSec] [float] NULL,
	[UDPRecvAmountPerSec] [float] NULL,
	[UDPUserSyncPacketLossRate] [float] NULL,
	[UDPNPCSyncPacketLossRate] [float] NULL,
	[FirstMemUsageCheck] [bit] NULL,
	[MinWorkingSetSize] [float] NULL,
	[MaxWorkingSetSize] [float] NULL,
	[MinPagefileUsage] [float] NULL,
	[MaxPagefileUsage] [float] NULL,
	[MapID] [int] NULL,
	[PVPUserNum] [int] NULL,
	[PVPType] [int] NULL,
	[EscapeCheck] [bit] NULL,
	[LastRound] [int] NULL,
	[RegDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LClientPerformance_PVP_knownLagInfo]', N'U') IS NULL
CREATE TABLE [dbo].[LClientPerformance_PVP_knownLagInfo](
	[UnitUID] [bigint] NULL,
	[SystemKey] [bigint] NULL,
	[LagType] [int] NULL,
	[MapID] [int] NULL,
	[PVPUserNum] [int] NULL,
	[PVPType] [int] NULL,
	[LastRound] [int] NULL,
	[LagTime] [float] NULL,
	[PlayTime] [float] NULL,
	[LagTotalNum] [float] NULL,
	[LagTotalTime] [float] NULL,
	[RegDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LClientPerformance_Field_UnknownLagInfo]', N'U') IS NULL
CREATE TABLE [dbo].[LClientPerformance_Field_UnknownLagInfo](
	[UnitUID] [bigint] NULL,
	[SystemKey] [bigint] NULL,
	[LagType] [int] NULL,
	[PartyType] [int] NULL,
	[PartyUserNum] [int] NULL,
	[MapID] [int] NULL,
	[FieldUserNum] [int] NULL,
	[LagTime] [float] NULL,
	[PlayTime] [float] NULL,
	[LagTotalNum] [float] NULL,
	[LagTotalTime] [float] NULL,
	[RegDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LClientPerformance_Field_knownLagInfo]', N'U') IS NULL
CREATE TABLE [dbo].[LClientPerformance_Field_knownLagInfo](
	[UnitUID] [bigint] NULL,
	[SystemKey] [bigint] NULL,
	[LagType] [int] NULL,
	[PartyType] [int] NULL,
	[PartyUserNum] [int] NULL,
	[MapID] [int] NULL,
	[VillageUserNum] [int] NULL,
	[LagTime] [float] NULL,
	[PlayTime] [float] NULL,
	[LagTotalNum] [float] NULL,
	[LagTotalTime] [float] NULL,
	[RegDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LClientPerformance_Field_FieldInfo]', N'U') IS NULL
CREATE TABLE [dbo].[LClientPerformance_Field_FieldInfo](
	[UnitUID] [bigint] NULL,
	[SystemKey] [bigint] NULL,
	[AvgFrame] [float] NULL,
	[AvgFrame_StdDev] [float] NULL,
	[P2PMinPingTime] [float] NULL,
	[P2PMaxPingTime] [float] NULL,
	[P2PAvgPingTime] [float] NULL,
	[P2PAvgPingTime_StdDev] [float] NULL,
	[P2PAvgPingLossRate] [float] NULL,
	[RelayMinPingTime] [float] NULL,
	[RelayMaxPingTime] [float] NULL,
	[RelayAvgPingTime] [float] NULL,
	[RelayAvgPingTime_StdDev] [float] NULL,
	[RelayAvgPingLossRate] [float] NULL,
	[TCPMinPingTime] [float] NULL,
	[TCPMaxPingTime] [float] NULL,
	[TCPAvgPingTime] [float] NULL,
	[TCPAvgPingTime_StdDev] [float] NULL,
	[UDPMinPingTime] [float] NULL,
	[UDPMaxPingTime] [float] NULL,
	[UDPAvgPingTime] [float] NULL,
	[UDPAvgPingTime_StdDev] [float] NULL,
	[UDPAvgPingLossRate] [float] NULL,
	[UDPSendCountPerSecHost] [float] NULL,
	[UDPSendAmountPerSecHost] [float] NULL,
	[UDPRecvCountPerSecHost] [float] NULL,
	[UDPRecvAmountPerSecHost] [float] NULL,
	[UDPSendCountPerSec] [float] NULL,
	[UDPSendAmountPerSec] [float] NULL,
	[UDPRecvCountPerSec] [float] NULL,
	[UDPRecvAmountPerSec] [float] NULL,
	[UDPUserSyncPacketLossRate] [float] NULL,
	[UDPNPCSyncPacketLossRate] [float] NULL,
	[NPCReactionHostUpdAvgPingTime] [float] NULL,
	[NPCReactionMinDelayTimeSimulOff] [float] NULL,
	[NPCReactionMaxDelayTimeSimulOff] [float] NULL,
	[NPCReactionAvgDelayTimeSimulOff] [float] NULL,
	[NPCReactionAvgStdDevDelayTimeSimulOff] [float] NULL,
	[NPCReactionMinDelayTimeSimulOn] [float] NULL,
	[NPCReactionMaxDelayTimeSimulOn] [float] NULL,
	[NPCReactionAvgDelayTimeSimulOn] [float] NULL,
	[NPCReactionAvgStdDevDelayTimeSimulOn] [float] NULL,
	[FirstMemUsageCheck] [bit] NULL,
	[MinWorkingSetSize] [float] NULL,
	[MaxWorkingSetSize] [float] NULL,
	[MinPagefileUsage] [float] NULL,
	[MaxPagefileUsage] [float] NULL,
	[PartyType] [int] NULL,
	[PartyUserNum] [int] NULL,
	[MapID] [int] NULL,
	[FieldUserNum] [int] NULL,
	[RegDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LClientPerformance_Dungeon_UnknownLagInfo]', N'U') IS NULL
CREATE TABLE [dbo].[LClientPerformance_Dungeon_UnknownLagInfo](
	[UnitUID] [bigint] NULL,
	[SystemKey] [bigint] NULL,
	[LagType] [int] NULL,
	[PartyType] [int] NULL,
	[PartyUserNum] [int] NULL,
	[MapID] [int] NULL,
	[Difficulty] [int] NULL,
	[LastStage] [int] NULL,
	[LastBlock] [int] NULL,
	[LagTime] [float] NULL,
	[PlayTime] [float] NULL,
	[LagTotalNum] [float] NULL,
	[LagTotalTime] [float] NULL,
	[RegDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LClientPerformance_Dungeon_knownLagInfo]', N'U') IS NULL
CREATE TABLE [dbo].[LClientPerformance_Dungeon_knownLagInfo](
	[UnitUID] [bigint] NULL,
	[SystemKey] [bigint] NULL,
	[LagType] [int] NULL,
	[PartyType] [int] NULL,
	[PartyUserNum] [int] NULL,
	[MapID] [int] NULL,
	[Difficulty] [int] NULL,
	[LastStage] [int] NULL,
	[LastBlock] [int] NULL,
	[LagTime] [float] NULL,
	[PlayTime] [float] NULL,
	[LagTotalNum] [float] NULL,
	[LagTotalTime] [float] NULL,
	[RegDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LClientPerformance_Dungeon_DungeonInfo]', N'U') IS NULL
CREATE TABLE [dbo].[LClientPerformance_Dungeon_DungeonInfo](
	[UnitUID] [bigint] NULL,
	[SystemKey] [bigint] NULL,
	[AvgFrame] [float] NULL,
	[AvgFrame_StdDev] [float] NULL,
	[P2PMinPingTime] [float] NULL,
	[P2PMaxPingTime] [float] NULL,
	[P2PAvgPingTime] [float] NULL,
	[P2PAvgPingTime_StdDev] [float] NULL,
	[P2PAvgPingLossRate] [float] NULL,
	[RelayMinPingTime] [float] NULL,
	[RelayMaxPingTime] [float] NULL,
	[RelayAvgPingTime] [float] NULL,
	[RelayAvgPingTime_StdDev] [float] NULL,
	[RelayAvgPingLossRate] [float] NULL,
	[TCPMinPingTime] [float] NULL,
	[TCPMaxPingTime] [float] NULL,
	[TCPAvgPingTime] [float] NULL,
	[TCPAvgPingTime_StdDev] [float] NULL,
	[UDPMinPingTime] [float] NULL,
	[UDPMaxPingTime] [float] NULL,
	[UDPAvgPingTime] [float] NULL,
	[UDPAvgPingTime_StdDev] [float] NULL,
	[UDPAvgPingLossRate] [float] NULL,
	[UDPSendCountPerSecHost] [float] NULL,
	[UDPSendAmountPerSecHost] [float] NULL,
	[UDPRecvCountPerSecHost] [float] NULL,
	[UDPRecvAmountPerSecHost] [float] NULL,
	[UDPSendCountPerSec] [float] NULL,
	[UDPSendAmountPerSec] [float] NULL,
	[UDPRecvCountPerSec] [float] NULL,
	[UDPRecvAmountPerSec] [float] NULL,
	[UDPUserSyncPacketLossRate] [float] NULL,
	[UDPNPCSyncPacketLossRate] [float] NULL,
	[NPCReactionHostUpdAvgPingTime] [float] NULL,
	[NPCReactionMinDelayTimeSimulOff] [float] NULL,
	[NPCReactionMaxDelayTimeSimulOff] [float] NULL,
	[NPCReactionAvgDelayTimeSimulOff] [float] NULL,
	[NPCReactionAvgStdDevDelayTimeSimulOff] [float] NULL,
	[NPCReactionMinDelayTimeSimulOn] [float] NULL,
	[NPCReactionMaxDelayTimeSimulOn] [float] NULL,
	[NPCReactionAvgDelayTimeSimulOn] [float] NULL,
	[NPCReactionAvgStdDevDelayTimeSimulOn] [float] NULL,
	[FirstMemUsageCheck] [bit] NULL,
	[MinWorkingSetSize] [float] NULL,
	[MaxWorkingSetSize] [float] NULL,
	[MinPagefileUsage] [float] NULL,
	[MaxPagefileUsage] [float] NULL,
	[PartyType] [int] NULL,
	[PartyUserNum] [int] NULL,
	[MapID] [int] NULL,
	[Difficulty] [int] NULL,
	[EscapeCheck] [bit] NULL,
	[LastStage] [int] NULL,
	[LastBlock] [int] NULL,
	[RegDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LCharLvUp]', N'U') IS NULL
CREATE TABLE [dbo].[LCharLvUp](
	[ServerSetID] [tinyint] NULL,
	[CharUID] [bigint] NOT NULL,
	[Level] [tinyint] NOT NULL,
	[Start] [smalldatetime] NOT NULL,
	[Finish] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_LCharLvUp] PRIMARY KEY CLUSTERED 
(
	[CharUID] ASC,
	[Level] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LChargeCashItem]', N'U') IS NULL
CREATE TABLE [dbo].[LChargeCashItem](
	[ChargeCashItemUID] [int] IDENTITY(1,1) NOT NULL,
	[UnitUID] [bigint] NOT NULL,
	[ItemUID] [bigint] NOT NULL,
	[ItemID] [int] NOT NULL,
	[ChargePoint] [bigint] NOT NULL,
	[AfterPoint] [bigint] NOT NULL,
	[sResult] [tinyint] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL,
 CONSTRAINT [PKC_LChargeCashItem_ChargeCashItemUID] PRIMARY KEY CLUSTERED 
(
	[ChargeCashItemUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LCharacterLog]', N'U') IS NULL
CREATE TABLE [dbo].[LCharacterLog](
	[LogID] [bigint] IDENTITY(1,1) NOT NULL,
	[RegDate] [smalldatetime] NOT NULL,
	[ServerSetID] [tinyint] NULL,
	[UnitUID] [bigint] NOT NULL,
	[NickName] [nvarchar](16) NOT NULL,
	[OnlyOne] [bit] NOT NULL,
	[ServerUID] [int] NOT NULL,
	[EventType] [smallint] NOT NULL,
	[LV] [tinyint] NOT NULL,
	[UnitClass] [tinyint] NOT NULL,
	[ClearDungeon] [int] NOT NULL,
	[Dungeon_PT] [int] NOT NULL,
	[PVP_PT] [int] NOT NULL,
	[DT] [int] NOT NULL,
	[UserUID] [bigint] NULL,
	[UnitRegDate] [smalldatetime] NULL,
	[UserRegDate] [smalldatetime] NULL,
	[ProductNo] [int] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LChannelReward]', N'U') IS NULL
CREATE TABLE [dbo].[LChannelReward](
	[ServerSetID] [tinyint] NOT NULL,
	[ChannelID] [smallint] NOT NULL,
	[StartLv] [tinyint] NULL,
	[EndLv] [tinyint] NULL,
	[PerEXP] [smallint] NULL,
	[PerED] [smallint] NULL,
 CONSTRAINT [PK_LChannelReward_ServerSetID_ChannelID] PRIMARY KEY CLUSTERED 
(
	[ServerSetID] ASC,
	[ChannelID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LChannelList]', N'U') IS NULL
CREATE TABLE [dbo].[LChannelList](
	[UID] [int] NULL,
	[ChannelID] [int] NOT NULL,
	[ChannelName] [nvarchar](30) NULL,
	[ServerSetID] [int] NULL,
	[IP] [nvarchar](15) NULL,
	[Port1] [int] NULL,
	[Port2] [int] NULL,
	[MaxConcurrentUser] [int] NULL,
	[ConcurrentUser] [int] NULL,
	[MakePartyCNT] [int] NOT NULL,
	[PlayPartyCNT] [int] NOT NULL,
	[OnOff] [bit] NOT NULL,
 CONSTRAINT [UK_LChannelList_UID] UNIQUE NONCLUSTERED 
(
	[UID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LCenterProxy]', N'U') IS NULL
CREATE TABLE [dbo].[LCenterProxy](
	[ServerSetID] [tinyint] NOT NULL,
	[ServerUID] [int] NOT NULL,
	[ProxyID] [tinyint] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LCatchHackuserInfo]', N'U') IS NULL
CREATE TABLE [dbo].[LCatchHackuserInfo](
	[USERUID] [bigint] NULL,
	[UNITUID] [bigint] NULL,
	[REGDATE] [smalldatetime] NULL,
	[CrashType] [int] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LCashSalesLog]', N'U') IS NULL
CREATE TABLE [dbo].[LCashSalesLog](
	[IDX] [int] IDENTITY(1,1) NOT NULL,
	[UserUID] [bigint] NOT NULL,
	[UnitUID] [bigint] NOT NULL,
	[UnitClass] [tinyint] NOT NULL,
	[Level] [tinyint] NOT NULL,
	[ProductNo] [int] NOT NULL,
	[BuyQuantity] [int] NOT NULL,
	[TotalPrice] [int] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL,
	[FirstBuy] [bit] NOT NULL,
	[BuyType] [tinyint] NOT NULL,
	[CashType] [tinyint] NULL,
	[OrderID] [nvarchar](50) NULL,
 CONSTRAINT [PK_LCashSalesLog] PRIMARY KEY CLUSTERED 
(
	[IDX] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LArenaUIDCreate]', N'U') IS NULL
CREATE TABLE [dbo].[LArenaUIDCreate](
	[ArenaUID] [bigint] NOT NULL,
	[type] [tinyint] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LApointLog]', N'U') IS NULL
CREATE TABLE [dbo].[LApointLog](
	[UnitUID] [bigint] NOT NULL,
	[ItemID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[BeforeAP] [int] NOT NULL,
	[AfterAP] [int] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LAccusationLog]', N'U') IS NULL
CREATE TABLE [dbo].[LAccusationLog](
	[UnitUID] [bigint] NULL,
	[RegDate] [smalldatetime] NULL,
	[RoomUID] [bigint] NULL,
	[PVPChannelClass] [smallint] NULL,
	[MatchType] [smallint] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GMQueryHistory]', N'U') IS NULL
CREATE TABLE [dbo].[GMQueryHistory](
	[HistoryUID] [int] IDENTITY(1,1) NOT NULL,
	[GMID] [nvarchar](20) NOT NULL,
	[Query] [nvarchar](1000) NOT NULL,
	[RegDate] [datetime] NOT NULL,
	[Result] [int] NULL,
 CONSTRAINT [PK_GM_History] PRIMARY KEY CLUSTERED 
(
	[HistoryUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[FrameRate]', N'U') IS NULL
CREATE TABLE [dbo].[FrameRate](
	[ServerSetID] [tinyint] NOT NULL,
	[RegDate] [nvarchar](10) NOT NULL,
	[PlayType] [tinyint] NOT NULL,
	[Under20] [int] NOT NULL,
	[S21_30] [int] NOT NULL,
	[S31_40] [int] NOT NULL,
	[S41_50] [int] NOT NULL,
	[S51_60] [int] NOT NULL,
	[S61_70] [int] NOT NULL,
	[S71_80] [int] NOT NULL,
	[S81_90] [int] NOT NULL,
	[Over90] [int] NOT NULL,
	[AUnder20] [float] NOT NULL,
	[A21_30] [float] NOT NULL,
	[A31_40] [float] NOT NULL,
	[A41_50] [float] NOT NULL,
	[A51_60] [float] NOT NULL,
	[A61_70] [float] NOT NULL,
	[A71_80] [float] NOT NULL,
	[A81_90] [float] NOT NULL,
	[AOver90] [float] NOT NULL,
 CONSTRAINT [PKC_FrameRate_RegDate_PlayType] PRIMARY KEY CLUSTERED 
(
	[ServerSetID] ASC,
	[RegDate] ASC,
	[PlayType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[EventInfo_New]', N'U') IS NULL
CREATE TABLE [dbo].[EventInfo_New](
	[EventID] [int] NOT NULL,
	[EXPRate] [int] NOT NULL,
	[VPRate] [int] NOT NULL,
	[EDRate] [int] NOT NULL,
	[DungeonID] [int] NOT NULL,
	[DungeonMode] [int] NOT NULL,
	[UnitLevel] [int] NOT NULL,
	[UnitType] [tinyint] NOT NULL,
	[UnitClass] [tinyint] NOT NULL,
	[PartyNum] [tinyint] NOT NULL,
	[EventTime] [int] NOT NULL,
	[EventReward] [int] NOT NULL,
	[MinLevel] [tinyint] NOT NULL,
	[MaxLevel] [tinyint] NOT NULL,
	[Isrepetition] [bit] NOT NULL,
	[IsDelEvent] [bit] NOT NULL,
	[IsPCbangEvent] [bit] NOT NULL,
	[DirectReward] [bit] NOT NULL,
	[IsAccountEvent] [bit] NOT NULL,
	[DropRate] [int] NOT NULL,
	[IswithPCbang] [bit] NOT NULL,
	[ChannelCode] [tinyint] NOT NULL,
	[BF_Team] [int] NOT NULL,
	[HenirRewardCount] [int] NOT NULL,
	[IsHenirRewardLimited] [bit] NOT NULL,
	[ServerGroup] [tinyint] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[EventInfo]', N'U') IS NULL
CREATE TABLE [dbo].[EventInfo](
	[EventID] [int] IDENTITY(1,1) NOT NULL,
	[EventName] [nvarchar](1500) NULL,
	[EventType] [int] NOT NULL,
	[BeginDate] [smalldatetime] NOT NULL,
	[EndDate] [smalldatetime] NOT NULL,
	[ScriptID] [int] NOT NULL,
	[OnOff] [bit] NULL,
	[ServerSetID] [bigint] NULL,
 CONSTRAINT [PKC_EventInfo_EventID] PRIMARY KEY CLUSTERED 
(
	[EventID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[Event_ServerInfo]', N'U') IS NULL
CREATE TABLE [dbo].[Event_ServerInfo](
	[ServerGroup] [int] NOT NULL,
	[ServerUID] [int] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[Event_RewardRetainUserItem]', N'U') IS NULL
CREATE TABLE [dbo].[Event_RewardRetainUserItem](
	[SlotNo] [int] NOT NULL,
	[ItemID] [int] NOT NULL,
	[Quantity] [int] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[Event_RewardLevelUp]', N'U') IS NULL
CREATE TABLE [dbo].[Event_RewardLevelUp](
	[Level] [tinyint] NOT NULL,
	[RewardID] [int] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[Event_Reward]', N'U') IS NULL
CREATE TABLE [dbo].[Event_Reward](
	[RewardID] [int] NOT NULL,
	[RewardItemID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Period] [smallint] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[Event_Monster]', N'U') IS NULL
CREATE TABLE [dbo].[Event_Monster](
	[EventID] [int] NOT NULL,
	[MonDropCount] [int] NOT NULL,
	[IsBossStage] [bit] NOT NULL,
	[MonsterID] [int] NOT NULL,
	[AdventRate] [int] NOT NULL,
	[DungeonID] [int] NOT NULL,
	[NoDungeonID] [int] NOT NULL,
	[NoDungeonStage] [int] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[DropEvent]', N'U') IS NULL
CREATE TABLE [dbo].[DropEvent](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ItemID] [int] NULL,
	[DropTime] [smalldatetime] NULL,
	[UpdTime] [smalldatetime] NULL,
	[ServerIP] [nvarchar](15) NULL,
	[Flag] [bit] NULL,
	[GetUserUID] [bigint] NULL,
	[IsNotice] [bit] NULL,
 CONSTRAINT [PKC_LDropEvent_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[CheatLog]', N'U') IS NULL
CREATE TABLE [dbo].[CheatLog](
	[ServerSetID] [tinyint] NULL,
	[UserUID] [bigint] NULL,
	[unitUID] [bigint] NOT NULL,
	[AuthLevel] [tinyint] NOT NULL,
	[CheatCode] [nvarchar](8) NOT NULL,
	[CheatSTR] [nvarchar](50) NOT NULL,
	[RegDate] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[CBT3rdDailyUserStats]', N'U') IS NULL
CREATE TABLE [dbo].[CBT3rdDailyUserStats](
	[Date] [nvarchar](10) NOT NULL,
	[ServerSetID] [tinyint] NULL,
	[TotalUser] [int] NOT NULL,
	[TotalConnect] [int] NOT NULL,
	[DayUniqUser] [int] NOT NULL,
	[DayUniqUser_Guest] [int] NULL,
	[NewUniqUser] [int] NOT NULL,
	[NewUniqUser_Guest] [int] NULL,
	[TopConnectCnt] [int] NOT NULL,
	[TopConnectTime] [smalldatetime] NOT NULL,
	[TopConnectCnt_Guest] [smallint] NOT NULL,
	[TopConnectTime_Guest] [smalldatetime] NOT NULL,
	[AVGConnectCnt] [int] NOT NULL,
	[AVGDT] [int] NOT NULL,
	[AVGDT_Normal] [int] NULL,
	[AVGDT_Guest] [int] NULL,
	[AVGPT] [int] NOT NULL,
	[AVGPT_Normal] [int] NULL,
	[AVGPT_Guest] [int] NULL,
	[AVGVsPT] [int] NOT NULL,
	[AVGVsPT_Normal] [int] NULL,
	[AVGVsPT_Guest] [int] NULL,
	[AVGArcadePT] [int] NOT NULL,
	[AVGArcadePT_Normal] [int] NOT NULL,
	[AVGArcadePT_Guest] [int] NOT NULL,
	[AfterLogin] [smallint] NULL,
	[OclockUser] [smallint] NULL,
	[ChangeUser] [smallint] NULL,
 CONSTRAINT [PKC_DailyUserStats_Date] PRIMARY KEY CLUSTERED 
(
	[Date] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 70) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[AbuserList]', N'U') IS NULL
CREATE TABLE [dbo].[AbuserList](
	[UnitUID] [bigint] NULL,
	[Type] [tinyint] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LUserStatistics]', N'U') IS NULL
CREATE TABLE [dbo].[LUserStatistics](
	[UserUID] [bigint] NOT NULL,
	[PublisherSN] [int] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL,
	[FirstUnitUID] [bigint] NOT NULL,
	[UnitCount] [tinyint] NOT NULL,
	[UnitDelCount] [smallint] NOT NULL,
	[LastLogin] [smalldatetime] NOT NULL,
	[AuthLevel] [tinyint] NOT NULL,
 CONSTRAINT [PKC_LUserStatistics_UserUID] PRIMARY KEY NONCLUSTERED 
(
	[UserUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[LUserDLLLog]', N'U') IS NULL
CREATE TABLE [dbo].[LUserDLLLog](
	[UserUID] [bigint] NOT NULL,
	[ServerSN] [bigint] NOT NULL,
	[DLLName] [nvarchar](20) NOT NULL,
	[Type] [smallint] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatsAbusingLog]', N'U') IS NULL
CREATE TABLE [dbo].[StatsAbusingLog](
	[ServerSetID] [tinyint] NULL,
	[UnitUID] [bigint] NOT NULL,
	[UserUID] [bigint] NOT NULL,
	[IP] [nvarchar](15) NULL,
	[VsType] [tinyint] NULL,
	[VsSetTime] [smallint] NULL,
	[IsSecret] [bit] NULL,
	[PlayerCnt] [tinyint] NULL,
	[VsStartTime] [smalldatetime] NULL,
	[VsEndTime] [smalldatetime] NULL,
	[VsPlayTime] [int] NULL,
	[GetVP] [int] NULL,
	[GetExp] [int] NULL,
	[KillCnt] [tinyint] NULL,
	[DeathCnt] [tinyint] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatsAbnormalReason]', N'U') IS NULL
CREATE TABLE [dbo].[StatsAbnormalReason](
	[ServerSetID] [tinyint] NULL,
	[ServerUID] [tinyint] NULL,
	[Reason] [int] NULL,
	[Cnt] [int] NULL,
	[RegDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[Stats080321Unit]', N'U') IS NULL
CREATE TABLE [dbo].[Stats080321Unit](
	[UserID] [nvarchar](20) NULL,
	[useruid] [bigint] NOT NULL,
	[unituid] [bigint] NOT NULL,
	[isfirst] [bit] NULL,
	[nickname] [nvarchar](20) NULL,
	[level] [int] NULL,
	[exp] [int] NULL,
	[unitclass] [tinyint] NULL,
	[Gender] [bit] NULL,
	[Age] [tinyint] NULL,
	[Quest] [smallint] NULL,
	[Skill] [smallint] NULL,
	[PlayDayCnt] [smallint] NULL,
	[VsPT] [int] NULL,
	[DunClearCnt] [smallint] NULL,
	[DunPT] [int] NULL,
	[DurationTime] [int] NULL,
	[SquareCnt] [smallint] NULL,
	[SquareTime] [int] NULL,
	[GamePoint] [int] NULL,
	[UseSpirit] [int] NULL,
	[UseStone] [smallint] NULL,
	[TutoWin] [smallint] NULL,
	[TutoLose] [smallint] NULL,
	[TutoGiveUp] [smallint] NULL,
	[TutoPT] [int] NULL,
	[TraPT] [int] NULL,
	[LastLogin] [smalldatetime] NULL,
	[RegDate] [smalldatetime] NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PKNC_Stats080321Unit_unituid] PRIMARY KEY NONCLUSTERED 
(
	[unituid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatPlayTime]', N'U') IS NULL
CREATE TABLE [dbo].[StatPlayTime](
	[RegDate] [smalldatetime] NOT NULL,
	[TotalPvpTime] [int] NOT NULL,
	[TotalDungeonTime] [int] NOT NULL,
	[TotalLoginTime] [int] NOT NULL,
	[ConnectCount] [int] NOT NULL,
	[UserCount] [int] NOT NULL,
	[TotPvpEx] [int] NOT NULL,
	[TotDungeonEx] [int] NOT NULL,
	[TotLoginEx] [int] NOT NULL,
	[ConnectCountEx] [int] NOT NULL,
	[UserCountEx] [int] NOT NULL,
 CONSTRAINT [PK_StatPlayTime] PRIMARY KEY CLUSTERED 
(
	[RegDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatPlayModeCount]', N'U') IS NULL
CREATE TABLE [dbo].[StatPlayModeCount](
	[GameModeID] [tinyint] NOT NULL,
	[GameModeName] [nvarchar](50) NOT NULL,
	[PlayCount] [int] NOT NULL,
	[PlayTime] [int] NOT NULL,
	[WaitingTime] [int] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatGameStatePopup_D]', N'U') IS NULL
CREATE TABLE [dbo].[StatGameStatePopup_D](
	[RegDate] [smalldatetime] NOT NULL,
	[UserUID] [bigint] NULL,
	[CharUID] [bigint] NOT NULL,
	[ModeCnt_MyInfo_MyInfo] [int] NOT NULL,
	[PlayTime_MyInfo_MyInfo] [int] NOT NULL,
	[ModeCnt_MyInfo_Inventory] [int] NOT NULL,
	[PlayTime_MyInfo_Inventory] [int] NOT NULL,
	[ModeCnt_MyInfo_SkillTree] [int] NOT NULL,
	[PlayTime_MyInfo_SkillTree] [int] NOT NULL,
	[ModeCnt_MyInfo_Quest] [int] NULL,
	[PlayTime_MyInfo_Quest] [int] NULL,
	[ModeCnt_FindUser] [int] NULL,
	[PlayTime_FindUser] [int] NULL,
	[ModeCnt_Party] [int] NULL,
	[PlayTime_Party] [int] NULL,
 CONSTRAINT [PK_StatGameStatePopup_D] PRIMARY KEY CLUSTERED 
(
	[CharUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatGameStatePopup]', N'U') IS NULL
CREATE TABLE [dbo].[StatGameStatePopup](
	[UserUID] [bigint] NULL,
	[CharUID] [bigint] NOT NULL,
	[ModeCnt_MyInfo_MyInfo] [int] NOT NULL,
	[PlayTime_MyInfo_MyInfo] [int] NOT NULL,
	[ModeCnt_MyInfo_Inventory] [int] NOT NULL,
	[PlayTime_MyInfo_Inventory] [int] NOT NULL,
	[ModeCnt_MyInfo_SkillTree] [int] NOT NULL,
	[PlayTime_MyInfo_SkillTree] [int] NOT NULL,
	[ModeCnt_MyInfo_Quest] [int] NULL,
	[PlayTime_MyInfo_Quest] [int] NULL,
	[ModeCnt_FindUser] [int] NULL,
	[PlayTime_FindUser] [int] NULL,
	[ModeCnt_Party] [int] NULL,
	[PlayTime_Party] [int] NULL,
 CONSTRAINT [PK_StatGameStatePopup] PRIMARY KEY CLUSTERED 
(
	[CharUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatGameState_D]', N'U') IS NULL
CREATE TABLE [dbo].[StatGameState_D](
	[RegDate] [smalldatetime] NOT NULL,
	[UserUID] [bigint] NULL,
	[CharUID] [bigint] NOT NULL,
	[ModeType] [int] NULL,
	[VillageID] [int] NULL,
	[NPCHouseID] [int] NULL,
	[ModeCount] [int] NULL,
	[PlayTime] [int] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatGameState]', N'U') IS NULL
CREATE TABLE [dbo].[StatGameState](
	[UserUID] [bigint] NULL,
	[CharUID] [bigint] NOT NULL,
	[ModeType] [int] NULL,
	[VillageID] [int] NULL,
	[NPCHouseID] [int] NULL,
	[ModeCount] [int] NULL,
	[PlayTime] [int] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatGamePlay_D]', N'U') IS NULL
CREATE TABLE [dbo].[StatGamePlay_D](
	[RegDate] [smalldatetime] NOT NULL,
	[UserUID] [bigint] NULL,
	[CharUID] [bigint] NOT NULL,
	[ModeType] [int] NULL,
	[GameType] [int] NULL,
	[DungeonID] [int] NULL,
	[GameEnd_Win] [int] NULL,
	[GameEnd_Lose] [int] NULL,
	[GameEnd_Drop] [int] NULL,
	[GameEnd_Win_PT] [int] NULL,
	[GameEnd_Lose_PT] [int] NULL,
	[GameEnd_Drop_PT] [int] NULL,
	[GameModeCount] [int] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatGamePlay]', N'U') IS NULL
CREATE TABLE [dbo].[StatGamePlay](
	[UserUID] [bigint] NULL,
	[CharUID] [bigint] NOT NULL,
	[ModeType] [int] NULL,
	[GameType] [int] NULL,
	[DungeonID] [int] NULL,
	[GameEnd_Win] [int] NULL,
	[GameEnd_Lose] [int] NULL,
	[GameEnd_Drop] [int] NULL,
	[GameEnd_Win_PT] [int] NULL,
	[GameEnd_Lose_PT] [int] NULL,
	[GameEnd_Drop_PT] [int] NULL,
	[GameModeCount] [int] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatErrorMsg]', N'U') IS NULL
CREATE TABLE [dbo].[StatErrorMsg](
	[ErrorID] [int] NOT NULL,
	[ErrorMsg] [nvarchar](200) NULL,
	[ErrorCount] [int] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatChar]', N'U') IS NULL
CREATE TABLE [dbo].[StatChar](
	[UserUID] [bigint] NULL,
	[CharUID] [bigint] NOT NULL,
	[VP_Inc_PVP] [int] NULL,
	[VP_Inc_Total] [int] NULL,
	[VP_Dec_ToExp] [int] NULL,
	[VP_Dec_Total] [int] NULL,
	[EXP_Inc_Dungeon] [int] NULL,
	[EXP_Inc_FromVP] [int] NULL,
	[EXP_Inc_Quest] [int] NULL,
	[EXP_Inc_Mission] [int] NULL,
	[EXP_Inc_Total] [int] NULL,
	[SP_Inc_LvUp] [int] NULL,
	[SP_Inc_DungeonClear] [int] NULL,
	[SP_Inc_PvpWin] [int] NULL,
	[SP_Inc_QuestClear] [int] NULL,
	[SP_Inc_Total] [int] NULL,
	[SP_Dec_Buy] [int] NULL,
	[SP_Dec_Total] [int] NULL,
	[ED_Inc_PVP] [int] NULL,
	[ED_Inc_Dungeon] [int] NULL,
	[ED_Inc_Quest] [int] NULL,
	[ED_Inc_Mission] [int] NULL,
	[ED_Inc_Trade] [int] NULL,
	[ED_Inc_Auction] [int] NULL,
	[ED_Inc_Sell] [int] NULL,
	[ED_Inc_Total] [int] NULL,
	[ED_Dec_Buy] [int] NULL,
	[ED_Dec_Total] [int] NULL,
	[Skill_Get_Active] [int] NULL,
	[Skill_Get_Job] [int] NULL,
	[Skill_Get_Passive] [int] NULL,
	[Skill_Get_Total] [int] NULL,
	[Item_Get] [int] NULL,
	[Item_Buy] [int] NULL,
	[Item_Sell] [int] NULL,
	[Quest_Normal_Accept] [int] NULL,
	[Quest_Normal_Complete] [int] NULL,
	[Quest_Normal_Discard] [int] NULL,
	[Quest_Repeat_Accept] [int] NULL,
	[Quest_Repeat_Complete] [int] NULL,
	[Quest_Repeat_Discard] [int] NULL,
	[Mission_Success] [int] NULL,
	[Mission_Failed] [int] NULL,
	[Party_Request] [int] NULL,
	[Party_Accept] [int] NULL,
	[Party_Discard] [int] NULL,
	[Party_Leave] [int] NULL,
	[TogetherPlay] [int] NULL,
	[InviteRoom] [int] NULL,
 CONSTRAINT [PK_StatChar] PRIMARY KEY CLUSTERED 
(
	[CharUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatCCUMinuteChannel]', N'U') IS NULL
CREATE TABLE [dbo].[StatCCUMinuteChannel](
	[LogID] [int] IDENTITY(1,1) NOT NULL,
	[RegDate] [smalldatetime] NOT NULL,
	[ServerUID] [int] NOT NULL,
	[CCU] [int] NOT NULL,
	[ChannelCode] [tinyint] NOT NULL,
 CONSTRAINT [PK_StatCCUMinuteChannel] PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatCCUMinute]', N'U') IS NULL
CREATE TABLE [dbo].[StatCCUMinute](
	[ServerSetID] [tinyint] NULL,
	[RegDate] [smalldatetime] NOT NULL,
	[ServerUID] [int] NOT NULL,
	[CCU] [int] NOT NULL,
	[CCUMinuteUID] [bigint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_StatCCUMinute] PRIMARY KEY NONCLUSTERED 
(
	[CCUMinuteUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[ResurrectionStoneLog]', N'U') IS NULL
CREATE TABLE [dbo].[ResurrectionStoneLog](
	[ServerSetID] [tinyint] NULL,
	[UnitUID] [bigint] NOT NULL,
	[DungeonID] [int] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[ReleaseTick]', N'U') IS NULL
CREATE TABLE [dbo].[ReleaseTick](
	[Type] [tinyint] NULL,
	[Count] [int] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[Rank_SpaceTime_Week_BAK]', N'U') IS NULL
CREATE TABLE [dbo].[Rank_SpaceTime_Week_BAK](
	[Rank] [tinyint] NULL,
	[UnitUID] [bigint] NOT NULL,
	[NickName] [nvarchar](16) NULL,
	[UnitClass] [tinyint] NULL,
	[Level] [tinyint] NULL,
	[Stage] [tinyint] NULL,
	[PlayTime] [smallint] NULL,
	[RegDate] [smalldatetime] NULL,
 CONSTRAINT [PKC_Rank_SpaceTime_Week_BAK_UnitUID] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[Rank_SpaceTime_Week]', N'U') IS NULL
CREATE TABLE [dbo].[Rank_SpaceTime_Week](
	[ServerSetID] [tinyint] NULL,
	[Rank] [tinyint] NULL,
	[UnitUID] [bigint] NOT NULL,
	[NickName] [nvarchar](16) NULL,
	[UnitClass] [tinyint] NULL,
	[Level] [tinyint] NULL,
	[Stage] [tinyint] NULL,
	[PlayTime] [smallint] NULL,
	[RegDate] [smalldatetime] NULL,
	[Date] [smalldatetime] NULL,
	[StartMember] [int] NULL,
	[EndMember] [int] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[Rank_SpaceTime_Month_BAK]', N'U') IS NULL
CREATE TABLE [dbo].[Rank_SpaceTime_Month_BAK](
	[Rank] [tinyint] NULL,
	[UnitUID] [bigint] NOT NULL,
	[NickName] [nvarchar](16) NULL,
	[UnitClass] [tinyint] NULL,
	[Level] [tinyint] NULL,
	[Stage] [tinyint] NULL,
	[PlayTime] [smallint] NULL,
	[RegDate] [smalldatetime] NULL,
 CONSTRAINT [PKC_Rank_SpaceTime_Month_BAK_UnitUID] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[Rank_SpaceTime_Month]', N'U') IS NULL
CREATE TABLE [dbo].[Rank_SpaceTime_Month](
	[ServerSetID] [tinyint] NULL,
	[Rank] [tinyint] NULL,
	[UnitUID] [bigint] NOT NULL,
	[NickName] [nvarchar](16) NULL,
	[UnitClass] [tinyint] NULL,
	[Level] [tinyint] NULL,
	[Stage] [tinyint] NULL,
	[PlayTime] [smallint] NULL,
	[RegDate] [smalldatetime] NULL,
	[Date] [smalldatetime] NULL,
	[StartMember] [int] NULL,
	[EndMember] [int] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[Rank_SpaceTime_Day_BAK]', N'U') IS NULL
CREATE TABLE [dbo].[Rank_SpaceTime_Day_BAK](
	[Rank] [tinyint] NULL,
	[UnitUID] [bigint] NOT NULL,
	[NickName] [nvarchar](16) NULL,
	[UnitClass] [tinyint] NULL,
	[Level] [tinyint] NULL,
	[Stage] [tinyint] NULL,
	[PlayTime] [smallint] NULL,
	[RegDate] [smalldatetime] NULL,
 CONSTRAINT [PKC_Rank_SpaceTime_Day_BAK_UnitUID] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[Rank_SpaceTime_Day]', N'U') IS NULL
CREATE TABLE [dbo].[Rank_SpaceTime_Day](
	[ServerSetID] [tinyint] NULL,
	[Rank] [tinyint] NULL,
	[UnitUID] [bigint] NOT NULL,
	[NickName] [nvarchar](16) NULL,
	[UnitClass] [tinyint] NULL,
	[Level] [tinyint] NULL,
	[Stage] [tinyint] NULL,
	[PlayTime] [smallint] NULL,
	[RegDate] [smalldatetime] NULL,
	[Date] [smalldatetime] NULL,
	[StartMember] [int] NULL,
	[EndMember] [int] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[QueryStats]', N'U') IS NULL
CREATE TABLE [dbo].[QueryStats](
	[QueryName] [nvarchar](70) NULL,
	[MinTime] [int] NULL,
	[AvgTime] [int] NULL,
	[MaxTime] [int] NULL,
	[Over1Sec] [smallint] NULL,
	[QueryCnt] [int] NULL,
	[QueryFail] [smallint] NULL,
	[RegDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatsDailyQuiz]', N'U') IS NULL
CREATE TABLE [dbo].[StatsDailyQuiz](
	[LogID] [int] IDENTITY(1,1) NOT NULL,
	[ServerSetID] [tinyint] NULL,
	[Useruid] [bigint] NULL,
	[Unituid] [bigint] NULL,
	[QuizNum] [int] NULL,
	[BoardNum] [int] NULL,
	[Answer] [tinyint] NULL,
	[Reward_Day] [int] NULL,
	[Reward_Special] [int] NULL,
	[Reward_Month] [int] NULL,
	[Unitclass] [tinyint] NULL,
	[Level] [tinyint] NULL,
	[Regdate] [smalldatetime] NULL,
	[Reward_Month_BoardNum] [int] NULL,
 CONSTRAINT [PKC_StatsDailyQuiz_LogID] PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatsDaily]', N'U') IS NULL
CREATE TABLE [dbo].[StatsDaily](
	[ServerSetID] [tinyint] NULL,
	[DATE] [nvarchar](10) NOT NULL,
	[TotalUnit] [int] NOT NULL,
	[NewUnit] [int] NOT NULL,
	[DelUnit] [int] NOT NULL,
 CONSTRAINT [PKC_StatsDaily_Date] PRIMARY KEY CLUSTERED 
(
	[DATE] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatsCSPLog]', N'U') IS NULL
CREATE TABLE [dbo].[StatsCSPLog](
	[ServerSetID] [tinyint] NULL,
	[UnitUID] [bigint] NULL,
	[Level] [tinyint] NULL,
	[CSPoint] [tinyint] NULL,
	[Period] [tinyint] NULL,
	[IsExtend] [bit] NULL,
	[RegDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatsCharmItemLog_Direct]', N'U') IS NULL
CREATE TABLE [dbo].[StatsCharmItemLog_Direct](
	[ServerSetID] [tinyint] NULL,
	[UnitUID] [bigint] NULL,
	[ItemID] [bigint] NULL,
	[ItemUID] [bigint] NULL,
	[Before] [tinyint] NULL,
	[After] [tinyint] NULL,
	[RegDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatsCharmItemLog]', N'U') IS NULL
CREATE TABLE [dbo].[StatsCharmItemLog](
	[ServerSetID] [tinyint] NULL,
	[CharmItemID] [bigint] NULL,
	[UnitUID] [bigint] NULL,
	[ItemID] [bigint] NULL,
	[Quantity] [tinyint] NULL,
	[RegDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatsCashLog]', N'U') IS NULL
CREATE TABLE [dbo].[StatsCashLog](
	[ServerSetID] [tinyint] NULL,
	[UnitUID] [bigint] NOT NULL,
	[ItemID] [int] NOT NULL,
	[Quantity] [smallint] NOT NULL,
	[Period] [smallint] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL,
	[Level] [tinyint] NOT NULL,
	[UnitClass] [tinyint] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatsAttrib_AttachLog]', N'U') IS NULL
CREATE TABLE [dbo].[StatsAttrib_AttachLog](
	[ServerSetID] [tinyint] NULL,
	[UnitUID] [bigint] NULL,
	[ItemID] [bigint] NULL,
	[ItemUID] [bigint] NULL,
	[BeforeSlot1] [tinyint] NULL,
	[BeforeSlot2] [tinyint] NULL,
	[BeforeSlot3] [tinyint] NULL,
	[AfterSlot1] [tinyint] NULL,
	[AfterSlot2] [tinyint] NULL,
	[AfterSlot3] [tinyint] NULL,
	[RegDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatsArcade]', N'U') IS NULL
CREATE TABLE [dbo].[StatsArcade](
	[UnitUID] [bigint] NOT NULL,
	[ArcadeID] [int] NOT NULL,
	[Floor] [int] NULL,
	[SW_Cnt] [smallint] NULL,
	[SL_Cnt] [smallint] NULL,
	[SG_Cnt] [smallint] NULL,
	[SRS_Cnt] [int] NULL,
	[PW_Cnt] [smallint] NULL,
	[PL_Cnt] [smallint] NULL,
	[PG_Cnt] [smallint] NULL,
	[PRS_Cnt] [int] NULL,
	[SW_Time] [int] NULL,
	[SL_Time] [int] NULL,
	[SG_Time] [int] NULL,
	[PW_Time] [int] NULL,
	[PL_Time] [int] NULL,
	[PG_Time] [int] NULL,
 CONSTRAINT [PKC_StatsArcade_UnitUID_ArcadeID] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC,
	[ArcadeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatsAndOrUser]', N'U') IS NULL
CREATE TABLE [dbo].[StatsAndOrUser](
	[ServerSetID] [tinyint] NULL,
	[REGDATE] [smalldatetime] NOT NULL,
	[ANDUSER] [int] NOT NULL,
	[ORUSER] [int] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatsAllSpirit_Old]', N'U') IS NULL
CREATE TABLE [dbo].[StatsAllSpirit_Old](
	[UnitUID] [bigint] NOT NULL,
	[UnitClass] [tinyint] NULL,
	[Level] [smallint] NULL,
	[PlayDayCnt] [smallint] NULL,
	[AllSpirit] [smallint] NULL,
	[DunCnt] [int] NULL,
	[VsCnt] [int] NULL,
	[QuestCnt] [int] NULL,
	[UseStone] [bigint] NULL,
	[GetED] [bigint] NULL,
	[UseED] [bigint] NULL,
	[NowED] [bigint] NULL,
	[RegDate] [smalldatetime] NULL,
 CONSTRAINT [PKC_StatsAllSpirit_Old_UnitUID] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatsAllSpirit]', N'U') IS NULL
CREATE TABLE [dbo].[StatsAllSpirit](
	[ServerSetID] [tinyint] NULL,
	[UnitUID] [bigint] NOT NULL,
	[UnitClass] [tinyint] NULL,
	[Level] [smallint] NULL,
	[PlayDayCnt] [smallint] NULL,
	[AllSpirit] [smallint] NULL,
	[DunCnt] [int] NULL,
	[VsCnt] [int] NULL,
	[QuestCnt] [int] NULL,
	[UseStone] [bigint] NULL,
	[GetED] [bigint] NULL,
	[UseED] [bigint] NULL,
	[NowED] [bigint] NULL,
	[RegDate] [smalldatetime] NULL,
 CONSTRAINT [PKC_StatsAllSpirit_UnitUID] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatsAllSkillDelete]', N'U') IS NULL
CREATE TABLE [dbo].[StatsAllSkillDelete](
	[ServerSetID] [tinyint] NULL,
	[UnitUID] [bigint] NULL,
	[ItemUID] [bigint] NULL,
	[SPoint] [smallint] NULL,
	[CSP] [smallint] NULL,
	[RegDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatsDecomposition]', N'U') IS NULL
CREATE TABLE [dbo].[StatsDecomposition](
	[ServerSetID] [tinyint] NULL,
	[UnitUID] [bigint] NOT NULL,
	[ItemUID] [bigint] NOT NULL,
	[Quantity] [tinyint] NULL,
	[RegDate] [smalldatetime] NULL,
	[AfterItemID] [int] NULL,
	[AfterItemQuantity] [int] NULL,
	[Level] [tinyint] NULL,
 CONSTRAINT [PKC_StatsDecomposition_UnitUID_ItemUID] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC,
	[ItemUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatsDungeon]', N'U') IS NULL
CREATE TABLE [dbo].[StatsDungeon](
	[ServerSetID] [tinyint] NULL,
	[unitUID] [bigint] NOT NULL,
	[DungeonID] [int] NOT NULL,
	[UnitClass] [tinyint] NULL,
	[SW_Cnt] [int] NULL,
	[SL_Cnt] [int] NULL,
	[SG_Cnt] [int] NULL,
	[SRS_Cnt] [int] NULL,
	[PW_Cnt] [int] NULL,
	[PL_Cnt] [int] NULL,
	[PG_Cnt] [int] NULL,
	[PRS_Cnt] [int] NULL,
	[SW_Time] [bigint] NULL,
	[SL_Time] [bigint] NULL,
	[SG_Time] [bigint] NULL,
	[PW_Time] [bigint] NULL,
	[PL_Time] [bigint] NULL,
	[PG_Time] [bigint] NULL,
 CONSTRAINT [PKC_StatsDungeon_unitUID_DungeonID] PRIMARY KEY CLUSTERED 
(
	[unitUID] ASC,
	[DungeonID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatsDistribution]', N'U') IS NULL
CREATE TABLE [dbo].[StatsDistribution](
	[RegDate] [nvarchar](10) NOT NULL,
	[MemberCount] [tinyint] NOT NULL,
	[User1] [int] NOT NULL,
	[User2] [int] NOT NULL,
	[User3] [int] NOT NULL,
	[User4] [int] NOT NULL,
 CONSTRAINT [PK_StatsDistribution_RegDate_MemberCount] PRIMARY KEY CLUSTERED 
(
	[RegDate] ASC,
	[MemberCount] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatsMoneySupply]', N'U') IS NULL
CREATE TABLE [dbo].[StatsMoneySupply](
	[ServerSetID] [tinyint] NULL,
	[Regdate] [nvarchar](10) NOT NULL,
	[PDun] [bigint] NULL,
	[PTraining] [bigint] NULL,
	[PQuest] [bigint] NULL,
	[PItemSell] [bigint] NULL,
	[PItemP2P] [bigint] NULL,
	[PStoreP2P] [bigint] NULL,
	[PPostP2P] [bigint] NOT NULL,
	[MItemBuy] [bigint] NULL,
	[MItemP2P] [bigint] NULL,
	[MItemRepair] [bigint] NULL,
	[MItemMake] [bigint] NULL,
	[MDunPenalty] [bigint] NULL,
	[MStoreP2P] [bigint] NULL,
	[MStoreOpen] [bigint] NULL,
	[MEnchant] [bigint] NULL,
	[MSocket] [bigint] NULL,
	[MPostP2P] [bigint] NOT NULL,
	[MPostBasic] [bigint] NOT NULL,
	[MPostItem] [bigint] NOT NULL,
	[MAttribute] [bigint] NOT NULL,
	[MStoreP2PTax] [bigint] NOT NULL,
	[MStoreBBSTax] [bigint] NOT NULL,
	[MPShopAgency] [bigint] NOT NULL,
	[MBuyTaxPShopA] [bigint] NOT NULL,
	[PPShopPickUp] [bigint] NOT NULL,
	[TotalED] [bigint] NULL,
	[MOpenCubeSpendED] [bigint] NULL,
	[PBattleFieldED] [bigint] NULL,
	[MCoboExpressTicketED] [bigint] NULL,
	[MItemDecom] [bigint] NULL,
 CONSTRAINT [PKC_StatsMoneySupply_Regdate] PRIMARY KEY CLUSTERED 
(
	[Regdate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatsMoneyLog]', N'U') IS NULL
CREATE TABLE [dbo].[StatsMoneyLog](
	[ServerSetID] [tinyint] NULL,
	[UnitUID] [bigint] NULL,
	[State] [tinyint] NULL,
	[BMoney] [int] NULL,
	[AMoney] [int] NULL,
	[Money] [int] NULL,
	[RegDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatsMegaphone]', N'U') IS NULL
CREATE TABLE [dbo].[StatsMegaphone](
	[ServerSetID] [tinyint] NULL,
	[UnitUID] [bigint] NULL,
	[ItemID] [int] NULL,
	[RegDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatsLoginLOG]', N'U') IS NULL
CREATE TABLE [dbo].[StatsLoginLOG](
	[ServerGroupID] [int] NULL,
	[ServerUID] [int] NULL,
	[LoginResultType] [int] NULL,
	[LoginResultCount] [int] NULL,
	[Regdate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatsJackPot]', N'U') IS NULL
CREATE TABLE [dbo].[StatsJackPot](
	[ServerSetID] [tinyint] NULL,
	[UnitUID] [bigint] NOT NULL,
	[ItemID] [int] NOT NULL,
	[DurationTime] [int] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatsItemResurrection]', N'U') IS NULL
CREATE TABLE [dbo].[StatsItemResurrection](
	[ServerSetID] [tinyint] NULL,
	[UnitUID] [bigint] NOT NULL,
	[ItemUID] [bigint] NOT NULL,
	[Before] [smallint] NULL,
	[After] [smallint] NULL,
	[RegDate] [datetime] NOT NULL,
 CONSTRAINT [PKC_StatsItemResurrection_ItemUID_RegDate] PRIMARY KEY CLUSTERED 
(
	[ItemUID] ASC,
	[RegDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatsItemGetLog]', N'U') IS NULL
CREATE TABLE [dbo].[StatsItemGetLog](
	[Idx] [int] IDENTITY(1,1) NOT NULL,
	[GitemUid] [int] NOT NULL,
	[Reason] [int] NOT NULL,
	[Regdate] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_StatsItemGetLog] PRIMARY KEY CLUSTERED 
(
	[Idx] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatsItemChange]', N'U') IS NULL
CREATE TABLE [dbo].[StatsItemChange](
	[ServerSetID] [tinyint] NULL,
	[UnitUID] [bigint] NOT NULL,
	[BeforeUID] [bigint] NOT NULL,
	[BeforeID] [int] NULL,
	[AfterUID] [bigint] NULL,
	[AfterID] [int] NULL,
	[RegDate] [smalldatetime] NULL,
 CONSTRAINT [PKC_StatsItemChange_UnitUID_BeforeUID] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC,
	[BeforeUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatsItemBreak]', N'U') IS NULL
CREATE TABLE [dbo].[StatsItemBreak](
	[ServerSetID] [tinyint] NULL,
	[UnitUID] [bigint] NOT NULL,
	[ItemUID] [bigint] NOT NULL,
	[ItemID] [int] NULL,
	[ELevel] [tinyint] NULL,
	[RegDate] [datetime] NOT NULL,
 CONSTRAINT [PKC_StatsItemBreak_UnitUID_ItemUID] PRIMARY KEY CLUSTERED 
(
	[ItemUID] ASC,
	[RegDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatsHackUser]', N'U') IS NULL
CREATE TABLE [dbo].[StatsHackUser](
	[UserID] [nvarchar](30) NULL,
	[Channel] [tinyint] NULL,
	[RegDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatsGetItemLog]', N'U') IS NULL
CREATE TABLE [dbo].[StatsGetItemLog](
	[ServerSetID] [tinyint] NULL,
	[UnitUID] [bigint] NOT NULL,
	[RewardState] [tinyint] NULL,
	[ItemID] [int] NULL,
	[Quantity] [tinyint] NULL,
	[RegDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatsPacketLog_2]', N'U') IS NULL
CREATE TABLE [dbo].[StatsPacketLog_2](
	[Idx] [int] IDENTITY(1,1) NOT NULL,
	[Monitor_Idx] [int] NOT NULL,
	[UnitUID] [int] NOT NULL,
	[Packet] [nvarchar](20) NOT NULL,
	[Count] [bigint] NOT NULL,
	[Regdate] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_StatsPacketLog_2] PRIMARY KEY CLUSTERED 
(
	[Idx] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatsPacketLog_1]', N'U') IS NULL
CREATE TABLE [dbo].[StatsPacketLog_1](
	[Idx] [int] IDENTITY(1,1) NOT NULL,
	[UnitUID] [int] NOT NULL,
	[Regdate] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_StatsPacketLog_1] PRIMARY KEY CLUSTERED 
(
	[Idx] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatsNickNameRestore]', N'U') IS NULL
CREATE TABLE [dbo].[StatsNickNameRestore](
	[ServerSetID] [tinyint] NULL,
	[NickName] [nvarchar](16) NOT NULL,
	[UnitUID] [bigint] NOT NULL,
	[Regdate] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatsNickNameChange]', N'U') IS NULL
CREATE TABLE [dbo].[StatsNickNameChange](
	[ServerSetID] [tinyint] NULL,
	[NickName] [nvarchar](16) NOT NULL,
	[UnitUID] [bigint] NOT NULL,
	[Regdate] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatsStoneCnt]', N'U') IS NULL
CREATE TABLE [dbo].[StatsStoneCnt](
	[ServerSetID] [tinyint] NULL,
	[Regdate] [nvarchar](10) NOT NULL,
	[PlayerCnt] [int] NULL,
	[UseCnt] [bigint] NULL,
	[DailyAVGCnt] [float] NULL,
	[FreeInsertCnt] [int] NULL,
	[NowCnt] [bigint] NULL,
	[Plus1] [int] NULL,
	[Plus2] [int] NULL,
	[Plus3] [int] NULL,
	[PlusOver3] [int] NULL,
 CONSTRAINT [PKC_StatsStoneCnt_RegDate] PRIMARY KEY CLUSTERED 
(
	[Regdate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatsSpiritLog]', N'U') IS NULL
CREATE TABLE [dbo].[StatsSpiritLog](
	[ServerSetID] [tinyint] NULL,
	[UnitUID] [bigint] NULL,
	[PlayTime] [int] NULL,
	[DurationTime] [int] NULL,
	[UsedSpirit] [smallint] NULL,
	[Regdate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatsSealLog]', N'U') IS NULL
CREATE TABLE [dbo].[StatsSealLog](
	[ServerSetID] [tinyint] NULL,
	[UnitUID] [bigint] NULL,
	[SealUID] [bigint] NULL,
	[ItemUID] [bigint] NULL,
	[SealCnt] [tinyint] NULL,
	[RegDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatsTraining]', N'U') IS NULL
CREATE TABLE [dbo].[StatsTraining](
	[ServerSetID] [tinyint] NULL,
	[unitUID] [bigint] NOT NULL,
	[TrainingID] [int] NOT NULL,
	[Win_Cnt] [int] NULL,
	[Lose_Cnt] [int] NULL,
	[GiveUp_Cnt] [int] NULL,
	[Win_Time] [bigint] NULL,
	[Lose_Time] [bigint] NULL,
	[GiveUp_Time] [bigint] NULL,
 CONSTRAINT [PKC_StatsTraining_utniUID_TrainingID] PRIMARY KEY CLUSTERED 
(
	[unitUID] ASC,
	[TrainingID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatsTradeEnd]', N'U') IS NULL
CREATE TABLE [dbo].[StatsTradeEnd](
	[ServerSetID] [tinyint] NULL,
	[UnitUID] [bigint] NULL,
	[UserUID] [bigint] NULL,
	[EndType] [tinyint] NULL,
	[RegDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatsTimeSpaceTop100]', N'U') IS NULL
CREATE TABLE [dbo].[StatsTimeSpaceTop100](
	[ServerSetID] [tinyint] NULL,
	[UserUID] [bigint] NULL,
	[UnitUID] [bigint] NULL,
	[PlayTime] [smallint] NULL,
	[RegDate] [datetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[SYS_SP_ErrorLog]', N'U') IS NULL
CREATE TABLE [dbo].[SYS_SP_ErrorLog](
	[CD_LOGNUMBER] [int] IDENTITY(1,1) NOT NULL,
	[NO_ERROR_LINE] [int] NULL,
	[ST_ERROR_MESSAGE] [nvarchar](2048) NULL,
	[NO_ERROR_NUMBER] [int] NULL,
	[ST_ERROR_PROCEDURE] [nvarchar](126) NULL,
	[NO_ERROR_SEVERITY] [int] NULL,
	[NO_ERROR_STATE] [int] NULL,
	[NO_XACT_STATE] [smallint] NULL,
	[ST_SYSTEM_USER] [nvarchar](126) NULL,
	[DT_ERROR_DATE] [datetime] NULL,
 CONSTRAINT [PK_SYS_SP_ErrorLog] PRIMARY KEY CLUSTERED 
(
	[CD_LOGNUMBER] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[STrade]', N'U') IS NULL
CREATE TABLE [dbo].[STrade](
	[idx] [bigint] IDENTITY(1,1) NOT NULL,
	[ServerSetID] [tinyint] NULL,
	[FromUnitUID] [bigint] NULL,
	[ToUnitUID] [bigint] NULL,
	[ItemID] [int] NULL,
	[ItemUID] [bigint] NOT NULL,
	[Quantity] [int] NULL,
	[Money] [int] NULL,
	[RegDate] [smalldatetime] NULL,
	[IsBBS] [bit] NOT NULL,
	[StoreType] [tinyint] NULL,
 CONSTRAINT [PK_STrade_idx] PRIMARY KEY NONCLUSTERED 
(
	[idx] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatsVsMap]', N'U') IS NULL
CREATE TABLE [dbo].[StatsVsMap](
	[ServerSetID] [tinyint] NULL,
	[MapID] [int] NOT NULL,
	[MapCnt] [int] NULL,
 CONSTRAINT [PKC_StatsVsMap_MapID] PRIMARY KEY CLUSTERED 
(
	[MapID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatsVs]', N'U') IS NULL
CREATE TABLE [dbo].[StatsVs](
	[ServerSetID] [tinyint] NULL,
	[unitUID] [bigint] NOT NULL,
	[TMW_Cnt] [int] NULL,
	[TML_Cnt] [int] NULL,
	[TMG_Cnt] [int] NULL,
	[TMD_Cnt] [int] NULL,
	[TDW_Cnt] [int] NULL,
	[TDL_Cnt] [int] NULL,
	[TDG_Cnt] [int] NULL,
	[TDD_Cnt] [int] NULL,
	[TDNan_Cnt] [int] NULL,
	[DW_Cnt] [int] NULL,
	[DL_Cnt] [int] NULL,
	[DG_Cnt] [int] NULL,
	[DD_Cnt] [int] NULL,
	[DNan_Cnt] [int] NULL,
	[TMW_Time] [bigint] NULL,
	[TML_Time] [bigint] NULL,
	[TMG_Time] [bigint] NULL,
	[TMD_Time] [bigint] NULL,
	[TDW_Time] [bigint] NULL,
	[TDL_Time] [bigint] NULL,
	[TDG_Time] [bigint] NULL,
	[TDD_Time] [bigint] NULL,
	[TDNan_Time] [bigint] NULL,
	[DW_Time] [bigint] NULL,
	[DL_Time] [bigint] NULL,
	[DG_Time] [bigint] NULL,
	[DD_Time] [bigint] NULL,
	[DNan_Time] [bigint] NULL,
 CONSTRAINT [PKC_StatsVsModeCnt_unitUID] PRIMARY KEY CLUSTERED 
(
	[unitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[UnitStatistics]', N'U') IS NULL
CREATE TABLE [dbo].[UnitStatistics](
	[userUID] [bigint] NOT NULL,
	[unitUID] [bigint] NOT NULL,
	[Age] [tinyint] NULL,
	[Gender] [bit] NULL,
	[RegDate] [smalldatetime] NULL,
	[LastDate] [smalldatetime] NULL,
	[PlayDayCnt] [smallint] NULL,
	[LoginCount] [int] NULL,
	[CharNo] [tinyint] NULL,
	[IsFirst] [bit] NULL,
	[UnitClass] [tinyint] NULL,
	[Deleted] [bit] NULL,
	[Level] [tinyint] NULL,
	[Exp] [int] NULL,
	[GamePoint] [int] NULL,
	[PDunED] [int] NULL,
	[PQuestED] [int] NULL,
	[PItemSellED] [int] NULL,
	[PItemP2PED] [bigint] NULL,
	[MItemBuyED] [int] NULL,
	[MItemP2PED] [bigint] NULL,
	[MItemMakeED] [int] NULL,
	[MItemRepairED] [int] NULL,
	[MStoreP2P] [bigint] NULL,
	[MEnchant] [bigint] NULL,
	[MSocket] [int] NULL,
	[VsPoint] [int] NULL,
	[VsPointMax] [int] NULL,
	[SPoint] [int] NULL,
	[VsRank] [int] NULL,
	[ExpRank] [int] NULL,
	[UseSpirit] [int] NULL,
	[AllSpirit] [smallint] NULL,
	[KillCnt] [int] NULL,
	[VsCnt] [int] NULL,
	[DSoloCnt] [int] NULL,
	[DPartyCnt] [int] NULL,
	[VsWinCnt] [int] NULL,
	[VsLoseCnt] [int] NULL,
	[DSWCnt] [int] NULL,
	[DPWCnt] [int] NULL,
	[PartyRate] [float] NULL,
	[Beginner] [int] NULL,
	[VsPlayTime] [int] NULL,
	[DSPlayTime] [int] NULL,
	[DPPlayTime] [int] NULL,
	[DunAndVSPT] [int] NULL,
	[TutorialPT] [int] NULL,
	[TrainingPT] [int] NULL,
	[TotalPlayTime] [int] NULL,
	[VsRate] [float] NULL,
	[DurationTime] [int] NULL,
	[BuyItem] [int] NULL,
	[SellItem] [int] NULL,
	[GetItem] [int] NULL,
	[P2PCnt] [int] NULL,
	[P2PBuyItem] [int] NULL,
	[P2PSellItem] [int] NULL,
	[Skill_Basic] [tinyint] NULL,
	[Skill_1] [tinyint] NULL,
	[Skill_2] [tinyint] NULL,
	[NQuestAcc] [int] NULL,
	[NQuestGiveUp] [int] NULL,
	[NQuestComplete] [int] NULL,
	[RQuestAcc] [int] NULL,
	[RQuestGiveUp] [int] NULL,
	[RQuestComplete] [int] NULL,
	[EQuestAcc] [int] NULL,
	[EQuestGiveUp] [int] NULL,
	[EQuestComplete] [int] NULL,
	[QuestCnt] [int] NULL,
	[ReQuestCnt] [int] NULL,
	[SquareCnt] [int] NULL,
	[SquarePlayTime] [int] NULL,
	[PCBangCnt] [int] NULL,
	[PCBangDayCnt] [smallint] NULL,
	[PCBangFlag] [bit] NULL,
	[MOpenCubeSpendED] [int] NULL,
 CONSTRAINT [PKC_UnitStatistics_UnitUID] PRIMARY KEY CLUSTERED 
(
	[unitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[StatsEnchantLog]', N'U') IS NULL
CREATE TABLE [dbo].[StatsEnchantLog](
	[ServerSetID] [tinyint] NULL,
	[UserUID] [bigint] NULL,
	[UnitUID] [bigint] NULL,
	[ItemID] [int] NULL,
	[ItemUID] [bigint] NULL,
	[TryELevel] [tinyint] NULL,
	[Result] [tinyint] NULL,
	[RegDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[statsEnchantAid]', N'U') IS NULL
CREATE TABLE [dbo].[statsEnchantAid](
	[ServerSetID] [tinyint] NULL,
	[ItemUID] [bigint] NULL,
	[Before] [tinyint] NULL,
	[After] [tinyint] NULL,
	[UseSupport] [bit] NULL,
	[UsePlus] [bit] NULL,
	[UseDestroyGuard] [bit] NULL,
	[RegDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_LUnitPVPLog_RegDate_UnitUID' AND object_id = OBJECT_ID(N'[dbo].[LUnitPVPLog]'))
CREATE CLUSTERED INDEX [IXC_LUnitPVPLog_RegDate_UnitUID] ON [dbo].[LUnitPVPLog] 
(
	[RegDate] ASC,
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_LUnitConnectLog_logintime' AND object_id = OBJECT_ID(N'[dbo].[LUnitConnectLog]'))
CREATE CLUSTERED INDEX [IXC_LUnitConnectLog_logintime] ON [dbo].[LUnitConnectLog] 
(
	[logintime] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_LUDPRelayCheck_RegDate_UID' AND object_id = OBJECT_ID(N'[dbo].[LUDPRelayCheck]'))
CREATE CLUSTERED INDEX [IXC_LUDPRelayCheck_RegDate_UID] ON [dbo].[LUDPRelayCheck] 
(
	[RegDate] ASC,
	[UID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_LTradeBank_ToItemUID' AND object_id = OBJECT_ID(N'[dbo].[LTradeBank]'))
CREATE CLUSTERED INDEX [IXC_LTradeBank_ToItemUID] ON [dbo].[LTradeBank] 
(
	[ToItemUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_LTradeBank_FromUnitUID' AND object_id = OBJECT_ID(N'[dbo].[LTradeBank]'))
CREATE NONCLUSTERED INDEX [IX_LTradeBank_FromUnitUID] ON [dbo].[LTradeBank] 
(
	[FromUnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_LTrade_FromUnitUID' AND object_id = OBJECT_ID(N'[dbo].[LTrade]'))
CREATE CLUSTERED INDEX [IXC_LTrade_FromUnitUID] ON [dbo].[LTrade] 
(
	[FromUnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_LTrade_ToUnitUID' AND object_id = OBJECT_ID(N'[dbo].[LTrade]'))
CREATE NONCLUSTERED INDEX [IX_LTrade_ToUnitUID] ON [dbo].[LTrade] 
(
	[ToUnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'CI_LSkillPointLog_RegDate' AND object_id = OBJECT_ID(N'[dbo].[LSkillPointLog]'))
CREATE CLUSTERED INDEX [CI_LSkillPointLog_RegDate] ON [dbo].[LSkillPointLog] 
(
	[Regdate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_LServer_GSUser_Packet_Latency_RegDate' AND object_id = OBJECT_ID(N'[dbo].[LServer_GSUser_Packet_Latency]'))
CREATE CLUSTERED INDEX [IXC_LServer_GSUser_Packet_Latency_RegDate] ON [dbo].[LServer_GSUser_Packet_Latency] 
(
	[RegDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_LServer_ErrorLog_RegDate_ServerUID' AND object_id = OBJECT_ID(N'[dbo].[LServer_ErrorLog]'))
CREATE CLUSTERED INDEX [IXC_LServer_ErrorLog_RegDate_ServerUID] ON [dbo].[LServer_ErrorLog] 
(
	[RegDate] ASC,
	[ServerUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_LServer_CnProxy_Packet_Count_RegDate' AND object_id = OBJECT_ID(N'[dbo].[LServer_CnProxy_Packet_Count]'))
CREATE CLUSTERED INDEX [IXC_LServer_CnProxy_Packet_Count_RegDate] ON [dbo].[LServer_CnProxy_Packet_Count] 
(
	[RegDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_LSecurityTypeLog_RegDate' AND object_id = OBJECT_ID(N'[dbo].[LSecurityTypeLog]'))
CREATE CLUSTERED INDEX [IXC_LSecurityTypeLog_RegDate] ON [dbo].[LSecurityTypeLog] 
(
	[RegDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_LRetainLog_RegDate_UnitUID' AND object_id = OBJECT_ID(N'[dbo].[LRetainLog]'))
CREATE CLUSTERED INDEX [IXC_LRetainLog_RegDate_UnitUID] ON [dbo].[LRetainLog] 
(
	[RegDate] ASC,
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_LQuestInfo_QuestID_RegDate' AND object_id = OBJECT_ID(N'[dbo].[LQuestInfo]'))
CREATE CLUSTERED INDEX [IXC_LQuestInfo_QuestID_RegDate] ON [dbo].[LQuestInfo] 
(
	[QuestID] ASC,
	[RegDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_LPost_TradeMonitor_ToUnitUID' AND object_id = OBJECT_ID(N'[dbo].[LPost_TradeMonitor]'))
CREATE CLUSTERED INDEX [IXC_LPost_TradeMonitor_ToUnitUID] ON [dbo].[LPost_TradeMonitor] 
(
	[ToUnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_LP2P_RelayLog_RegDate' AND object_id = OBJECT_ID(N'[dbo].[LP2P_RelayLog]'))
CREATE CLUSTERED INDEX [IXC_LP2P_RelayLog_RegDate] ON [dbo].[LP2P_RelayLog] 
(
	[RegDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_LNonExistentModuleLog_RegDate' AND object_id = OBJECT_ID(N'[dbo].[LNonExistentModuleLog]'))
CREATE CLUSTERED INDEX [IXC_LNonExistentModuleLog_RegDate] ON [dbo].[LNonExistentModuleLog] 
(
	[RegDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_LFieldLog_RegDate' AND object_id = OBJECT_ID(N'[dbo].[LFieldLog]'))
CREATE CLUSTERED INDEX [IXC_LFieldLog_RegDate] ON [dbo].[LFieldLog] 
(
	[RegDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_LExitLog_RegDate' AND object_id = OBJECT_ID(N'[dbo].[LExitLog]'))
CREATE CLUSTERED INDEX [IXC_LExitLog_RegDate] ON [dbo].[LExitLog] 
(
	[RegDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_LExitLog_UnitUID' AND object_id = OBJECT_ID(N'[dbo].[LExitLog]'))
CREATE NONCLUSTERED INDEX [IX_LExitLog_UnitUID] ON [dbo].[LExitLog] 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_LExchangeLog_RegDate' AND object_id = OBJECT_ID(N'[dbo].[LExchangeLog]'))
CREATE CLUSTERED INDEX [IXC_LExchangeLog_RegDate] ON [dbo].[LExchangeLog] 
(
	[RegDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_LExchangeLog_UnitUID' AND object_id = OBJECT_ID(N'[dbo].[LExchangeLog]'))
CREATE NONCLUSTERED INDEX [IX_LExchangeLog_UnitUID] ON [dbo].[LExchangeLog] 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_LEquipmentLog_ID_Regdate' AND object_id = OBJECT_ID(N'[dbo].[LEquipmentLog]'))
CREATE CLUSTERED INDEX [IXC_LEquipmentLog_ID_Regdate] ON [dbo].[LEquipmentLog] 
(
	[DungeonID] ASC,
	[Regdate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_LEnchantLog_UnitUID' AND object_id = OBJECT_ID(N'[dbo].[LEnchantLog]'))
CREATE CLUSTERED INDEX [IXC_LEnchantLog_UnitUID] ON [dbo].[LEnchantLog] 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_LEnchantLog_RegDate' AND object_id = OBJECT_ID(N'[dbo].[LEnchantLog]'))
CREATE NONCLUSTERED INDEX [IX_LEnchantLog_RegDate] ON [dbo].[LEnchantLog] 
(
	[RegDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_LDungeonLog_Reg_ID' AND object_id = OBJECT_ID(N'[dbo].[LDungeonLog]'))
CREATE CLUSTERED INDEX [IXC_LDungeonLog_Reg_ID] ON [dbo].[LDungeonLog] 
(
	[RegDate] ASC,
	[DungeonID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_LDungeonLog_IDX' AND object_id = OBJECT_ID(N'[dbo].[LDungeonLog]'))
CREATE NONCLUSTERED INDEX [IX_LDungeonLog_IDX] ON [dbo].[LDungeonLog] 
(
	[Seq] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_LDungeonLeaveLog_RegDate' AND object_id = OBJECT_ID(N'[dbo].[LDungeonLeaveLog]'))
CREATE CLUSTERED INDEX [IXC_LDungeonLeaveLog_RegDate] ON [dbo].[LDungeonLeaveLog] 
(
	[RegDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_LDisconnectReason_New_RegDate' AND object_id = OBJECT_ID(N'[dbo].[LDisconnectReason_New]'))
CREATE NONCLUSTERED INDEX [IX_LDisconnectReason_New_RegDate] ON [dbo].[LDisconnectReason_New] 
(
	[RegDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_LDisconnectReason_RegDate' AND object_id = OBJECT_ID(N'[dbo].[LDisconnectReason]'))
CREATE CLUSTERED INDEX [IXC_LDisconnectReason_RegDate] ON [dbo].[LDisconnectReason] 
(
	[RegDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_LConnectLog_LoginTime' AND object_id = OBJECT_ID(N'[dbo].[LConnectLog]'))
CREATE CLUSTERED INDEX [IXC_LConnectLog_LoginTime] ON [dbo].[LConnectLog] 
(
	[LoginTime] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'NIDX_LConnectLog_UserUID' AND object_id = OBJECT_ID(N'[dbo].[LConnectLog]'))
CREATE NONCLUSTERED INDEX [NIDX_LConnectLog_UserUID] ON [dbo].[LConnectLog] 
(
	[UserUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_LComebackUserLog_RegDate' AND object_id = OBJECT_ID(N'[dbo].[LComebackUserLog]'))
CREATE CLUSTERED INDEX [IXC_LComebackUserLog_RegDate] ON [dbo].[LComebackUserLog] 
(
	[RegDate] ASC,
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_LClientPerformance_Village_UnknownLagInfo_RegDate' AND object_id = OBJECT_ID(N'[dbo].[LClientPerformance_Village_UnknownLagInfo]'))
CREATE CLUSTERED INDEX [IXC_LClientPerformance_Village_UnknownLagInfo_RegDate] ON [dbo].[LClientPerformance_Village_UnknownLagInfo] 
(
	[RegDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_LClientPerformance_Village_knownLagInfo_RegDate' AND object_id = OBJECT_ID(N'[dbo].[LClientPerformance_Village_knownLagInfo]'))
CREATE CLUSTERED INDEX [IXC_LClientPerformance_Village_knownLagInfo_RegDate] ON [dbo].[LClientPerformance_Village_knownLagInfo] 
(
	[RegDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_LClientPerformance_UserPCInfo_RegDate' AND object_id = OBJECT_ID(N'[dbo].[LClientPerformance_UserPCInfo]'))
CREATE CLUSTERED INDEX [IXC_LClientPerformance_UserPCInfo_RegDate] ON [dbo].[LClientPerformance_UserPCInfo] 
(
	[RegDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_LClientPerformance_PVP_UnknownLagInfo_RegDate' AND object_id = OBJECT_ID(N'[dbo].[LClientPerformance_PVP_UnknownLagInfo]'))
CREATE CLUSTERED INDEX [IXC_LClientPerformance_PVP_UnknownLagInfo_RegDate] ON [dbo].[LClientPerformance_PVP_UnknownLagInfo] 
(
	[RegDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_LClientPerformance_PVP_knownLagInfo_RegDate' AND object_id = OBJECT_ID(N'[dbo].[LClientPerformance_PVP_knownLagInfo]'))
CREATE CLUSTERED INDEX [IXC_LClientPerformance_PVP_knownLagInfo_RegDate] ON [dbo].[LClientPerformance_PVP_knownLagInfo] 
(
	[RegDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_LClientPerformance_Field_UnknownLagInfo_RegDate' AND object_id = OBJECT_ID(N'[dbo].[LClientPerformance_Field_UnknownLagInfo]'))
CREATE CLUSTERED INDEX [IXC_LClientPerformance_Field_UnknownLagInfo_RegDate] ON [dbo].[LClientPerformance_Field_UnknownLagInfo] 
(
	[RegDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_LClientPerformance_Field_knownLagInfo_RegDate' AND object_id = OBJECT_ID(N'[dbo].[LClientPerformance_Field_knownLagInfo]'))
CREATE CLUSTERED INDEX [IXC_LClientPerformance_Field_knownLagInfo_RegDate] ON [dbo].[LClientPerformance_Field_knownLagInfo] 
(
	[RegDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_LClientPerformance_Dungeon_UnknownLagInfo_RegDate' AND object_id = OBJECT_ID(N'[dbo].[LClientPerformance_Dungeon_UnknownLagInfo]'))
CREATE CLUSTERED INDEX [IXC_LClientPerformance_Dungeon_UnknownLagInfo_RegDate] ON [dbo].[LClientPerformance_Dungeon_UnknownLagInfo] 
(
	[RegDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_LClientPerformance_Dungeon_knownLagInfo_RegDate' AND object_id = OBJECT_ID(N'[dbo].[LClientPerformance_Dungeon_knownLagInfo]'))
CREATE CLUSTERED INDEX [IXC_LClientPerformance_Dungeon_knownLagInfo_RegDate] ON [dbo].[LClientPerformance_Dungeon_knownLagInfo] 
(
	[RegDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_LCharacterLog_RegDate' AND object_id = OBJECT_ID(N'[dbo].[LCharacterLog]'))
CREATE CLUSTERED INDEX [IXC_LCharacterLog_RegDate] ON [dbo].[LCharacterLog] 
(
	[RegDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'CI_LCatchHackuserInfo_RegDate' AND object_id = OBJECT_ID(N'[dbo].[LCatchHackuserInfo]'))
CREATE CLUSTERED INDEX [CI_LCatchHackuserInfo_RegDate] ON [dbo].[LCatchHackuserInfo] 
(
	[REGDATE] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_LApointLog_UnitUID' AND object_id = OBJECT_ID(N'[dbo].[LApointLog]'))
CREATE CLUSTERED INDEX [IXC_LApointLog_UnitUID] ON [dbo].[LApointLog] 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_LAccusationLog_AssailantUID' AND object_id = OBJECT_ID(N'[dbo].[LAccusationLog]'))
CREATE CLUSTERED INDEX [IXC_LAccusationLog_AssailantUID] ON [dbo].[LAccusationLog] 
(
	[RegDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_EventInfo_EndDate' AND object_id = OBJECT_ID(N'[dbo].[EventInfo]'))
CREATE NONCLUSTERED INDEX [IX_EventInfo_EndDate] ON [dbo].[EventInfo] 
(
	[EndDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_AbuserList_Type' AND object_id = OBJECT_ID(N'[dbo].[AbuserList]'))
CREATE CLUSTERED INDEX [IXC_AbuserList_Type] ON [dbo].[AbuserList] 
(
	[Type] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_LUserDLLLog_UserUID' AND object_id = OBJECT_ID(N'[dbo].[LUserDLLLog]'))
CREATE CLUSTERED INDEX [IXC_LUserDLLLog_UserUID] ON [dbo].[LUserDLLLog] 
(
	[UserUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_StatsAbusingLog_UnitUID' AND object_id = OBJECT_ID(N'[dbo].[StatsAbusingLog]'))
CREATE CLUSTERED INDEX [IXC_StatsAbusingLog_UnitUID] ON [dbo].[StatsAbusingLog] 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_StatsAbusingLog_UserUID' AND object_id = OBJECT_ID(N'[dbo].[StatsAbusingLog]'))
CREATE NONCLUSTERED INDEX [IX_StatsAbusingLog_UserUID] ON [dbo].[StatsAbusingLog] 
(
	[UserUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_StatsAbnormalReason_RegDate' AND object_id = OBJECT_ID(N'[dbo].[StatsAbnormalReason]'))
CREATE CLUSTERED INDEX [IXC_StatsAbnormalReason_RegDate] ON [dbo].[StatsAbnormalReason] 
(
	[RegDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_StatMinuteCCU' AND object_id = OBJECT_ID(N'[dbo].[StatCCUMinute]'))
CREATE UNIQUE CLUSTERED INDEX [IX_StatMinuteCCU] ON [dbo].[StatCCUMinute] 
(
	[ServerUID] ASC,
	[RegDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_ResurrectionStoneLog_UnitUID' AND object_id = OBJECT_ID(N'[dbo].[ResurrectionStoneLog]'))
CREATE NONCLUSTERED INDEX [IX_ResurrectionStoneLog_UnitUID] ON [dbo].[ResurrectionStoneLog] 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_Rank_SpaceTime_Week_Date_Rank' AND object_id = OBJECT_ID(N'[dbo].[Rank_SpaceTime_Week]'))
CREATE CLUSTERED INDEX [IX_Rank_SpaceTime_Week_Date_Rank] ON [dbo].[Rank_SpaceTime_Week] 
(
	[Date] ASC,
	[Rank] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_Rank_SpaceTime_Month_Date_Rank' AND object_id = OBJECT_ID(N'[dbo].[Rank_SpaceTime_Month]'))
CREATE CLUSTERED INDEX [IX_Rank_SpaceTime_Month_Date_Rank] ON [dbo].[Rank_SpaceTime_Month] 
(
	[Date] ASC,
	[Rank] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_Rank_SpaceTime_Day_Date_Rank' AND object_id = OBJECT_ID(N'[dbo].[Rank_SpaceTime_Day]'))
CREATE CLUSTERED INDEX [IX_Rank_SpaceTime_Day_Date_Rank] ON [dbo].[Rank_SpaceTime_Day] 
(
	[Date] ASC,
	[Rank] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_StatsDailyQuiz_RegDate' AND object_id = OBJECT_ID(N'[dbo].[StatsDailyQuiz]'))
CREATE NONCLUSTERED INDEX [IX_StatsDailyQuiz_RegDate] ON [dbo].[StatsDailyQuiz] 
(
	[Regdate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_StatsDailyQuiz_Unituid' AND object_id = OBJECT_ID(N'[dbo].[StatsDailyQuiz]'))
CREATE NONCLUSTERED INDEX [IX_StatsDailyQuiz_Unituid] ON [dbo].[StatsDailyQuiz] 
(
	[ServerSetID] ASC,
	[Unituid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_StatsCSPLog_UnitUID' AND object_id = OBJECT_ID(N'[dbo].[StatsCSPLog]'))
CREATE CLUSTERED INDEX [IXC_StatsCSPLog_UnitUID] ON [dbo].[StatsCSPLog] 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_StatsCharmItemLog_Direct_UnitUID' AND object_id = OBJECT_ID(N'[dbo].[StatsCharmItemLog_Direct]'))
CREATE CLUSTERED INDEX [IXC_StatsCharmItemLog_Direct_UnitUID] ON [dbo].[StatsCharmItemLog_Direct] 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_StatsCharmItemLog_UnitUID' AND object_id = OBJECT_ID(N'[dbo].[StatsCharmItemLog]'))
CREATE CLUSTERED INDEX [IXC_StatsCharmItemLog_UnitUID] ON [dbo].[StatsCharmItemLog] 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_StatsCashLog_UnitUID' AND object_id = OBJECT_ID(N'[dbo].[StatsCashLog]'))
CREATE NONCLUSTERED INDEX [IX_StatsCashLog_UnitUID] ON [dbo].[StatsCashLog] 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_StatsAllSkillDelete_UnitUID' AND object_id = OBJECT_ID(N'[dbo].[StatsAllSkillDelete]'))
CREATE CLUSTERED INDEX [IX_StatsAllSkillDelete_UnitUID] ON [dbo].[StatsAllSkillDelete] 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_StatsMoneyLog_UnitUID' AND object_id = OBJECT_ID(N'[dbo].[StatsMoneyLog]'))
CREATE CLUSTERED INDEX [IXC_StatsMoneyLog_UnitUID] ON [dbo].[StatsMoneyLog] 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_StatsMegaphone_UnitUID' AND object_id = OBJECT_ID(N'[dbo].[StatsMegaphone]'))
CREATE CLUSTERED INDEX [IX_StatsMegaphone_UnitUID] ON [dbo].[StatsMegaphone] 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IC_StatsJackPot_UnitUID' AND object_id = OBJECT_ID(N'[dbo].[StatsJackPot]'))
CREATE NONCLUSTERED INDEX [IC_StatsJackPot_UnitUID] ON [dbo].[StatsJackPot] 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_StatsNickNameRestore_NickName' AND object_id = OBJECT_ID(N'[dbo].[StatsNickNameRestore]'))
CREATE NONCLUSTERED INDEX [IX_StatsNickNameRestore_NickName] ON [dbo].[StatsNickNameRestore] 
(
	[NickName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_StatsNickNameChange_NickName' AND object_id = OBJECT_ID(N'[dbo].[StatsNickNameChange]'))
CREATE NONCLUSTERED INDEX [IX_StatsNickNameChange_NickName] ON [dbo].[StatsNickNameChange] 
(
	[NickName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_StatsSealLog_UnitUID' AND object_id = OBJECT_ID(N'[dbo].[StatsSealLog]'))
CREATE CLUSTERED INDEX [IXC_StatsSealLog_UnitUID] ON [dbo].[StatsSealLog] 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_TradeEnd_UserUID' AND object_id = OBJECT_ID(N'[dbo].[StatsTradeEnd]'))
CREATE CLUSTERED INDEX [IXC_TradeEnd_UserUID] ON [dbo].[StatsTradeEnd] 
(
	[UserUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_STrade_RegDate' AND object_id = OBJECT_ID(N'[dbo].[STrade]'))
CREATE CLUSTERED INDEX [IXC_STrade_RegDate] ON [dbo].[STrade] 
(
	[RegDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_STrade_FromUnitUID' AND object_id = OBJECT_ID(N'[dbo].[STrade]'))
CREATE NONCLUSTERED INDEX [IX_STrade_FromUnitUID] ON [dbo].[STrade] 
(
	[FromUnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_STrade_ToUnitUID' AND object_id = OBJECT_ID(N'[dbo].[STrade]'))
CREATE NONCLUSTERED INDEX [IX_STrade_ToUnitUID] ON [dbo].[STrade] 
(
	[ToUnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_UnitStatistics_UserUID' AND object_id = OBJECT_ID(N'[dbo].[UnitStatistics]'))
CREATE NONCLUSTERED INDEX [IX_UnitStatistics_UserUID] ON [dbo].[UnitStatistics] 
(
	[userUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_StatsEnchantLog_StatsEnchantLog_UserUID' AND object_id = OBJECT_ID(N'[dbo].[StatsEnchantLog]'))
CREATE NONCLUSTERED INDEX [IXC_StatsEnchantLog_StatsEnchantLog_UserUID] ON [dbo].[StatsEnchantLog] 
(
	[UserUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_statsEnchantAid_ItemUID' AND object_id = OBJECT_ID(N'[dbo].[statsEnchantAid]'))
CREATE CLUSTERED INDEX [IXC_statsEnchantAid_ItemUID] ON [dbo].[statsEnchantAid] 
(
	[ItemUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[DF_LUnitDailyGamePoint_MOpenCubeSpendED]') IS NULL
/****** Object:  Default [DF_LUnitDailyGamePoint_MOpenCubeSpendED]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LUnitDailyGamePoint] ADD  CONSTRAINT [DF_LUnitDailyGamePoint_MOpenCubeSpendED]  DEFAULT ((0)) FOR [MOpenCubeSpendED]
GO
IF OBJECT_ID(N'[dbo].[DF_LUnitDailyGamePoint_PBattleFieldED]') IS NULL
/****** Object:  Default [DF_LUnitDailyGamePoint_PBattleFieldED]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LUnitDailyGamePoint] ADD  CONSTRAINT [DF_LUnitDailyGamePoint_PBattleFieldED]  DEFAULT ((0)) FOR [PBattleFieldED]
GO
IF OBJECT_ID(N'[dbo].[DF_LUnitDailyGamePoint_MCoboExpressTicketED]') IS NULL
/****** Object:  Default [DF_LUnitDailyGamePoint_MCoboExpressTicketED]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LUnitDailyGamePoint] ADD  CONSTRAINT [DF_LUnitDailyGamePoint_MCoboExpressTicketED]  DEFAULT ((0)) FOR [MCoboExpressTicketED]
GO
IF OBJECT_ID(N'[dbo].[DF_LUnitDailyGamePoint_MItemDecom]') IS NULL
/****** Object:  Default [DF_LUnitDailyGamePoint_MItemDecom]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LUnitDailyGamePoint] ADD  CONSTRAINT [DF_LUnitDailyGamePoint_MItemDecom]  DEFAULT ((0)) FOR [MItemDecom]
GO
IF OBJECT_ID(N'[dbo].[DF_LTradeBank_RegDate]') IS NULL
/****** Object:  Default [DF_LTradeBank_RegDate]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LTradeBank] ADD  CONSTRAINT [DF_LTradeBank_RegDate]  DEFAULT (getdate()) FOR [RegDate]
GO
IF OBJECT_ID(N'[dbo].[DF_LTrade_ServerSetID]') IS NULL
/****** Object:  Default [DF_LTrade_ServerSetID]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LTrade] ADD  CONSTRAINT [DF_LTrade_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_LTrade_IsUpdate]') IS NULL
/****** Object:  Default [DF_LTrade_IsUpdate]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LTrade] ADD  CONSTRAINT [DF_LTrade_IsUpdate]  DEFAULT ((0)) FOR [IsUpdate]
GO
IF OBJECT_ID(N'[dbo].[DF_LQuestInfo_Accept]') IS NULL
/****** Object:  Default [DF_LQuestInfo_Accept]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LQuestInfo] ADD  CONSTRAINT [DF_LQuestInfo_Accept]  DEFAULT ((0)) FOR [Accept]
GO
IF OBJECT_ID(N'[dbo].[DF_LQuestInfo_GiveUp]') IS NULL
/****** Object:  Default [DF_LQuestInfo_GiveUp]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LQuestInfo] ADD  CONSTRAINT [DF_LQuestInfo_GiveUp]  DEFAULT ((0)) FOR [GiveUp]
GO
IF OBJECT_ID(N'[dbo].[DF_LQuestInfo_Complete]') IS NULL
/****** Object:  Default [DF_LQuestInfo_Complete]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LQuestInfo] ADD  CONSTRAINT [DF_LQuestInfo_Complete]  DEFAULT ((0)) FOR [Complete]
GO
IF OBJECT_ID(N'[dbo].[DF_LQuestInfo_AcceptLevel]') IS NULL
/****** Object:  Default [DF_LQuestInfo_AcceptLevel]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LQuestInfo] ADD  CONSTRAINT [DF_LQuestInfo_AcceptLevel]  DEFAULT ((0)) FOR [AcceptLevel]
GO
IF OBJECT_ID(N'[dbo].[DF_LQuestInfo_GiveUpLevel]') IS NULL
/****** Object:  Default [DF_LQuestInfo_GiveUpLevel]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LQuestInfo] ADD  CONSTRAINT [DF_LQuestInfo_GiveUpLevel]  DEFAULT ((0)) FOR [GiveUpLevel]
GO
IF OBJECT_ID(N'[dbo].[DF_LQuestInfo_CompleteLevel]') IS NULL
/****** Object:  Default [DF_LQuestInfo_CompleteLevel]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LQuestInfo] ADD  CONSTRAINT [DF_LQuestInfo_CompleteLevel]  DEFAULT ((0)) FOR [CompleteLevel]
GO
IF OBJECT_ID(N'[dbo].[DF_LQuestInfo_RegDate]') IS NULL
/****** Object:  Default [DF_LQuestInfo_RegDate]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LQuestInfo] ADD  CONSTRAINT [DF_LQuestInfo_RegDate]  DEFAULT (getdate()) FOR [RegDate]
GO
IF OBJECT_ID(N'[dbo].[DF_LPost_TradeMonitor_ServerSetID]') IS NULL
/****** Object:  Default [DF_LPost_TradeMonitor_ServerSetID]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LPost_TradeMonitor] ADD  CONSTRAINT [DF_LPost_TradeMonitor_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_LItemOnOff_RegDate]') IS NULL
/****** Object:  Default [DF_LItemOnOff_RegDate]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LItemOnOff] ADD  CONSTRAINT [DF_LItemOnOff_RegDate]  DEFAULT (getdate()) FOR [RegDate]
GO
IF OBJECT_ID(N'[dbo].[DF_LItemLog_ServerSetID]') IS NULL
/****** Object:  Default [DF_LItemLog_ServerSetID]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LItemLog] ADD  CONSTRAINT [DF_LItemLog_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_LFieldLog_ServerSetID]') IS NULL
/****** Object:  Default [DF_LFieldLog_ServerSetID]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LFieldLog] ADD  CONSTRAINT [DF_LFieldLog_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_LExpo_Event_ServerSetID]') IS NULL
/****** Object:  Default [DF_LExpo_Event_ServerSetID]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LExpo_Event] ADD  CONSTRAINT [DF_LExpo_Event_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_LEquipmentLog_ServerSetID]') IS NULL
/****** Object:  Default [DF_LEquipmentLog_ServerSetID]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LEquipmentLog] ADD  CONSTRAINT [DF_LEquipmentLog_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_LEDBuffeffect_RegDate]') IS NULL
/****** Object:  Default [DF_LEDBuffeffect_RegDate]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LEDBuffeffect] ADD  CONSTRAINT [DF_LEDBuffeffect_RegDate]  DEFAULT (getdate()) FOR [RegDate]
GO
IF OBJECT_ID(N'[dbo].[DF_LDungeonTimeHackUser_RegDate]') IS NULL
/****** Object:  Default [DF_LDungeonTimeHackUser_RegDate]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LDungeonTimeHackUser] ADD  CONSTRAINT [DF_LDungeonTimeHackUser_RegDate]  DEFAULT (getdate()) FOR [RegDate]
GO
IF OBJECT_ID(N'[dbo].[DF_LDungeonLog_ServerSetID]') IS NULL
/****** Object:  Default [DF_LDungeonLog_ServerSetID]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LDungeonLog] ADD  CONSTRAINT [DF_LDungeonLog_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_LDisconnectUserFSM_ServerSetID]') IS NULL
/****** Object:  Default [DF_LDisconnectUserFSM_ServerSetID]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LDisconnectUserFSM] ADD  CONSTRAINT [DF_LDisconnectUserFSM_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_LDisconnectReason_abnormal_ServerSetID]') IS NULL
/****** Object:  Default [DF_LDisconnectReason_abnormal_ServerSetID]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LDisconnectReason_abnormal] ADD  CONSTRAINT [DF_LDisconnectReason_abnormal_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_LDisconnectReason_ServerSetID]') IS NULL
/****** Object:  Default [DF_LDisconnectReason_ServerSetID]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LDisconnectReason] ADD  CONSTRAINT [DF_LDisconnectReason_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_LDisconnectReason_NProtect_Hacking]') IS NULL
/****** Object:  Default [DF_LDisconnectReason_NProtect_Hacking]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LDisconnectReason] ADD  CONSTRAINT [DF_LDisconnectReason_NProtect_Hacking]  DEFAULT ((0)) FOR [NProtect_Hacking]
GO
IF OBJECT_ID(N'[dbo].[DF_LDisconnectReason_ChannelChange]') IS NULL
/****** Object:  Default [DF_LDisconnectReason_ChannelChange]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LDisconnectReason] ADD  CONSTRAINT [DF_LDisconnectReason_ChannelChange]  DEFAULT ((0)) FOR [ChannelChange]
GO
IF OBJECT_ID(N'[dbo].[DF_LDisconnectReason_Channel_Change_Fail]') IS NULL
/****** Object:  Default [DF_LDisconnectReason_Channel_Change_Fail]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LDisconnectReason] ADD  CONSTRAINT [DF_LDisconnectReason_Channel_Change_Fail]  DEFAULT ((0)) FOR [Channel_Change_Fail]
GO
IF OBJECT_ID(N'[dbo].[DF_LDisconnectReason_Traffic_Attack]') IS NULL
/****** Object:  Default [DF_LDisconnectReason_Traffic_Attack]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LDisconnectReason] ADD  CONSTRAINT [DF_LDisconnectReason_Traffic_Attack]  DEFAULT ((0)) FOR [Traffic_Attack]
GO
IF OBJECT_ID(N'[dbo].[DF_LDisconnectReason_MachineIDBlock]') IS NULL
/****** Object:  Default [DF_LDisconnectReason_MachineIDBlock]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LDisconnectReason] ADD  CONSTRAINT [DF_LDisconnectReason_MachineIDBlock]  DEFAULT ((0)) FOR [MachineIDBlock]
GO
IF OBJECT_ID(N'[dbo].[DF_LDisconnectReason_Same_MachineID_Connect]') IS NULL
/****** Object:  Default [DF_LDisconnectReason_Same_MachineID_Connect]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LDisconnectReason] ADD  CONSTRAINT [DF_LDisconnectReason_Same_MachineID_Connect]  DEFAULT ((0)) FOR [Same_MachineID_Connect]
GO
IF OBJECT_ID(N'[dbo].[DF_LDefense_Crystal_ServerSetID]') IS NULL
/****** Object:  Default [DF_LDefense_Crystal_ServerSetID]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LDefense_Crystal] ADD  CONSTRAINT [DF_LDefense_Crystal_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_LConnectLog_ServerSetID]') IS NULL
/****** Object:  Default [DF_LConnectLog_ServerSetID]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LConnectLog] ADD  CONSTRAINT [DF_LConnectLog_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_LConnectLog_TotalPlayTime]') IS NULL
/****** Object:  Default [DF_LConnectLog_TotalPlayTime]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LConnectLog] ADD  CONSTRAINT [DF_LConnectLog_TotalPlayTime]  DEFAULT ((0)) FOR [TotalPlayTime]
GO
IF OBJECT_ID(N'[dbo].[DF_LConnectLog_VsPlayTime]') IS NULL
/****** Object:  Default [DF_LConnectLog_VsPlayTime]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LConnectLog] ADD  CONSTRAINT [DF_LConnectLog_VsPlayTime]  DEFAULT ((0)) FOR [VsPlayTime]
GO
IF OBJECT_ID(N'[dbo].[DF_LConnectLog_ArcadePlayTime]') IS NULL
/****** Object:  Default [DF_LConnectLog_ArcadePlayTime]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LConnectLog] ADD  CONSTRAINT [DF_LConnectLog_ArcadePlayTime]  DEFAULT ((0)) FOR [ArcadePlayTime]
GO
IF OBJECT_ID(N'[dbo].[DF_LCharLvUp_ServerSetID]') IS NULL
/****** Object:  Default [DF_LCharLvUp_ServerSetID]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LCharLvUp] ADD  CONSTRAINT [DF_LCharLvUp_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_LChargeCashItem_sResult]') IS NULL
/****** Object:  Default [DF_LChargeCashItem_sResult]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LChargeCashItem] ADD  CONSTRAINT [DF_LChargeCashItem_sResult]  DEFAULT ((0)) FOR [sResult]
GO
IF OBJECT_ID(N'[dbo].[DF_LChargeCashItem_RegDate]') IS NULL
/****** Object:  Default [DF_LChargeCashItem_RegDate]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LChargeCashItem] ADD  CONSTRAINT [DF_LChargeCashItem_RegDate]  DEFAULT (getdate()) FOR [RegDate]
GO
IF OBJECT_ID(N'[dbo].[DF_LChannelReward_ServerSetID]') IS NULL
/****** Object:  Default [DF_LChannelReward_ServerSetID]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LChannelReward] ADD  CONSTRAINT [DF_LChannelReward_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_LChannelList_MakePartyCNT]') IS NULL
/****** Object:  Default [DF_LChannelList_MakePartyCNT]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LChannelList] ADD  CONSTRAINT [DF_LChannelList_MakePartyCNT]  DEFAULT ((0)) FOR [MakePartyCNT]
GO
IF OBJECT_ID(N'[dbo].[DF_LChannelList_PlayPartyCNT]') IS NULL
/****** Object:  Default [DF_LChannelList_PlayPartyCNT]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LChannelList] ADD  CONSTRAINT [DF_LChannelList_PlayPartyCNT]  DEFAULT ((0)) FOR [PlayPartyCNT]
GO
IF OBJECT_ID(N'[dbo].[DF_LChannelList_OnOff]') IS NULL
/****** Object:  Default [DF_LChannelList_OnOff]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[LChannelList] ADD  CONSTRAINT [DF_LChannelList_OnOff]  DEFAULT ((1)) FOR [OnOff]
GO
IF OBJECT_ID(N'[dbo].[DF_GM_History_RegDate]') IS NULL
/****** Object:  Default [DF_GM_History_RegDate]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[GMQueryHistory] ADD  CONSTRAINT [DF_GM_History_RegDate]  DEFAULT (getdate()) FOR [RegDate]
GO
IF OBJECT_ID(N'[dbo].[DF_FrameRate_ServerSetID]') IS NULL
/****** Object:  Default [DF_FrameRate_ServerSetID]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[FrameRate] ADD  CONSTRAINT [DF_FrameRate_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_FrameRate_Under20]') IS NULL
/****** Object:  Default [DF_FrameRate_Under20]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[FrameRate] ADD  CONSTRAINT [DF_FrameRate_Under20]  DEFAULT ((0)) FOR [Under20]
GO
IF OBJECT_ID(N'[dbo].[DF_FrameRate_S21_30]') IS NULL
/****** Object:  Default [DF_FrameRate_S21_30]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[FrameRate] ADD  CONSTRAINT [DF_FrameRate_S21_30]  DEFAULT ((0)) FOR [S21_30]
GO
IF OBJECT_ID(N'[dbo].[DF_FrameRate_S31_40]') IS NULL
/****** Object:  Default [DF_FrameRate_S31_40]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[FrameRate] ADD  CONSTRAINT [DF_FrameRate_S31_40]  DEFAULT ((0)) FOR [S31_40]
GO
IF OBJECT_ID(N'[dbo].[DF_FrameRate_S41_50]') IS NULL
/****** Object:  Default [DF_FrameRate_S41_50]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[FrameRate] ADD  CONSTRAINT [DF_FrameRate_S41_50]  DEFAULT ((0)) FOR [S41_50]
GO
IF OBJECT_ID(N'[dbo].[DF_FrameRate_S51_60]') IS NULL
/****** Object:  Default [DF_FrameRate_S51_60]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[FrameRate] ADD  CONSTRAINT [DF_FrameRate_S51_60]  DEFAULT ((0)) FOR [S51_60]
GO
IF OBJECT_ID(N'[dbo].[DF_FrameRate_S61_70]') IS NULL
/****** Object:  Default [DF_FrameRate_S61_70]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[FrameRate] ADD  CONSTRAINT [DF_FrameRate_S61_70]  DEFAULT ((0)) FOR [S61_70]
GO
IF OBJECT_ID(N'[dbo].[DF_FrameRate_S71_80]') IS NULL
/****** Object:  Default [DF_FrameRate_S71_80]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[FrameRate] ADD  CONSTRAINT [DF_FrameRate_S71_80]  DEFAULT ((0)) FOR [S71_80]
GO
IF OBJECT_ID(N'[dbo].[DF_FrameRate_S81_90]') IS NULL
/****** Object:  Default [DF_FrameRate_S81_90]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[FrameRate] ADD  CONSTRAINT [DF_FrameRate_S81_90]  DEFAULT ((0)) FOR [S81_90]
GO
IF OBJECT_ID(N'[dbo].[DF_FrameRate_Over90]') IS NULL
/****** Object:  Default [DF_FrameRate_Over90]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[FrameRate] ADD  CONSTRAINT [DF_FrameRate_Over90]  DEFAULT ((0)) FOR [Over90]
GO
IF OBJECT_ID(N'[dbo].[DF_FrameRate_AUnder20]') IS NULL
/****** Object:  Default [DF_FrameRate_AUnder20]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[FrameRate] ADD  CONSTRAINT [DF_FrameRate_AUnder20]  DEFAULT ((0)) FOR [AUnder20]
GO
IF OBJECT_ID(N'[dbo].[DF_FrameRate_A21_30]') IS NULL
/****** Object:  Default [DF_FrameRate_A21_30]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[FrameRate] ADD  CONSTRAINT [DF_FrameRate_A21_30]  DEFAULT ((0)) FOR [A21_30]
GO
IF OBJECT_ID(N'[dbo].[DF_FrameRate_A31_40]') IS NULL
/****** Object:  Default [DF_FrameRate_A31_40]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[FrameRate] ADD  CONSTRAINT [DF_FrameRate_A31_40]  DEFAULT ((0)) FOR [A31_40]
GO
IF OBJECT_ID(N'[dbo].[DF_FrameRate_A41_50]') IS NULL
/****** Object:  Default [DF_FrameRate_A41_50]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[FrameRate] ADD  CONSTRAINT [DF_FrameRate_A41_50]  DEFAULT ((0)) FOR [A41_50]
GO
IF OBJECT_ID(N'[dbo].[DF_FrameRate_A51_60]') IS NULL
/****** Object:  Default [DF_FrameRate_A51_60]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[FrameRate] ADD  CONSTRAINT [DF_FrameRate_A51_60]  DEFAULT ((0)) FOR [A51_60]
GO
IF OBJECT_ID(N'[dbo].[DF_FrameRate_A61_70]') IS NULL
/****** Object:  Default [DF_FrameRate_A61_70]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[FrameRate] ADD  CONSTRAINT [DF_FrameRate_A61_70]  DEFAULT ((0)) FOR [A61_70]
GO
IF OBJECT_ID(N'[dbo].[DF_FrameRate_A71_80]') IS NULL
/****** Object:  Default [DF_FrameRate_A71_80]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[FrameRate] ADD  CONSTRAINT [DF_FrameRate_A71_80]  DEFAULT ((0)) FOR [A71_80]
GO
IF OBJECT_ID(N'[dbo].[DF_FrameRate_A81_90]') IS NULL
/****** Object:  Default [DF_FrameRate_A81_90]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[FrameRate] ADD  CONSTRAINT [DF_FrameRate_A81_90]  DEFAULT ((0)) FOR [A81_90]
GO
IF OBJECT_ID(N'[dbo].[DF_FrameRate_AOver90]') IS NULL
/****** Object:  Default [DF_FrameRate_AOver90]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[FrameRate] ADD  CONSTRAINT [DF_FrameRate_AOver90]  DEFAULT ((0)) FOR [AOver90]
GO
IF OBJECT_ID(N'[dbo].[DF_EventInfo_New_EventID]') IS NULL
/****** Object:  Default [DF_EventInfo_New_EventID]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[EventInfo_New] ADD  CONSTRAINT [DF_EventInfo_New_EventID]  DEFAULT ((-1)) FOR [EventID]
GO
IF OBJECT_ID(N'[dbo].[DF_EventInfo_New_EXPRate]') IS NULL
/****** Object:  Default [DF_EventInfo_New_EXPRate]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[EventInfo_New] ADD  CONSTRAINT [DF_EventInfo_New_EXPRate]  DEFAULT ((0)) FOR [EXPRate]
GO
IF OBJECT_ID(N'[dbo].[DF_EventInfo_New_VPRate]') IS NULL
/****** Object:  Default [DF_EventInfo_New_VPRate]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[EventInfo_New] ADD  CONSTRAINT [DF_EventInfo_New_VPRate]  DEFAULT ((0)) FOR [VPRate]
GO
IF OBJECT_ID(N'[dbo].[DF_EventInfo_New_EDRate]') IS NULL
/****** Object:  Default [DF_EventInfo_New_EDRate]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[EventInfo_New] ADD  CONSTRAINT [DF_EventInfo_New_EDRate]  DEFAULT ((0)) FOR [EDRate]
GO
IF OBJECT_ID(N'[dbo].[DF_EventInfo_New_DungeonID]') IS NULL
/****** Object:  Default [DF_EventInfo_New_DungeonID]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[EventInfo_New] ADD  CONSTRAINT [DF_EventInfo_New_DungeonID]  DEFAULT ((0)) FOR [DungeonID]
GO
IF OBJECT_ID(N'[dbo].[DF_EventInfo_New_DungeonMode]') IS NULL
/****** Object:  Default [DF_EventInfo_New_DungeonMode]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[EventInfo_New] ADD  CONSTRAINT [DF_EventInfo_New_DungeonMode]  DEFAULT ((0)) FOR [DungeonMode]
GO
IF OBJECT_ID(N'[dbo].[DF_EventInfo_New_UnitLevel]') IS NULL
/****** Object:  Default [DF_EventInfo_New_UnitLevel]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[EventInfo_New] ADD  CONSTRAINT [DF_EventInfo_New_UnitLevel]  DEFAULT ((0)) FOR [UnitLevel]
GO
IF OBJECT_ID(N'[dbo].[DF_EventInfo_New_UnitType]') IS NULL
/****** Object:  Default [DF_EventInfo_New_UnitType]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[EventInfo_New] ADD  CONSTRAINT [DF_EventInfo_New_UnitType]  DEFAULT ((0)) FOR [UnitType]
GO
IF OBJECT_ID(N'[dbo].[DF_EventInfo_New_UnitClass]') IS NULL
/****** Object:  Default [DF_EventInfo_New_UnitClass]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[EventInfo_New] ADD  CONSTRAINT [DF_EventInfo_New_UnitClass]  DEFAULT ((0)) FOR [UnitClass]
GO
IF OBJECT_ID(N'[dbo].[DF_EventInfo_New_PartyNum]') IS NULL
/****** Object:  Default [DF_EventInfo_New_PartyNum]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[EventInfo_New] ADD  CONSTRAINT [DF_EventInfo_New_PartyNum]  DEFAULT ((0)) FOR [PartyNum]
GO
IF OBJECT_ID(N'[dbo].[DF_EventInfo_New_EventTime]') IS NULL
/****** Object:  Default [DF_EventInfo_New_EventTime]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[EventInfo_New] ADD  CONSTRAINT [DF_EventInfo_New_EventTime]  DEFAULT ((0)) FOR [EventTime]
GO
IF OBJECT_ID(N'[dbo].[DF_EventInfo_New_EventReward]') IS NULL
/****** Object:  Default [DF_EventInfo_New_EventReward]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[EventInfo_New] ADD  CONSTRAINT [DF_EventInfo_New_EventReward]  DEFAULT ((0)) FOR [EventReward]
GO
IF OBJECT_ID(N'[dbo].[DF_EventInfo_New_MinLevel]') IS NULL
/****** Object:  Default [DF_EventInfo_New_MinLevel]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[EventInfo_New] ADD  CONSTRAINT [DF_EventInfo_New_MinLevel]  DEFAULT ((0)) FOR [MinLevel]
GO
IF OBJECT_ID(N'[dbo].[DF_EventInfo_New_MaxLevel]') IS NULL
/****** Object:  Default [DF_EventInfo_New_MaxLevel]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[EventInfo_New] ADD  CONSTRAINT [DF_EventInfo_New_MaxLevel]  DEFAULT ((0)) FOR [MaxLevel]
GO
IF OBJECT_ID(N'[dbo].[DF_EventInfo_New_Isrepetition]') IS NULL
/****** Object:  Default [DF_EventInfo_New_Isrepetition]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[EventInfo_New] ADD  CONSTRAINT [DF_EventInfo_New_Isrepetition]  DEFAULT ((1)) FOR [Isrepetition]
GO
IF OBJECT_ID(N'[dbo].[DF_EventInfo_New_IsDelEvent]') IS NULL
/****** Object:  Default [DF_EventInfo_New_IsDelEvent]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[EventInfo_New] ADD  CONSTRAINT [DF_EventInfo_New_IsDelEvent]  DEFAULT ((0)) FOR [IsDelEvent]
GO
IF OBJECT_ID(N'[dbo].[DF_EventInfo_New_IsPCbangEvent]') IS NULL
/****** Object:  Default [DF_EventInfo_New_IsPCbangEvent]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[EventInfo_New] ADD  CONSTRAINT [DF_EventInfo_New_IsPCbangEvent]  DEFAULT ((0)) FOR [IsPCbangEvent]
GO
IF OBJECT_ID(N'[dbo].[DF_EventInfo_New_DirectReward]') IS NULL
/****** Object:  Default [DF_EventInfo_New_DirectReward]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[EventInfo_New] ADD  CONSTRAINT [DF_EventInfo_New_DirectReward]  DEFAULT ((0)) FOR [DirectReward]
GO
IF OBJECT_ID(N'[dbo].[DF_EventInfo_New_IsAccountEvent]') IS NULL
/****** Object:  Default [DF_EventInfo_New_IsAccountEvent]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[EventInfo_New] ADD  CONSTRAINT [DF_EventInfo_New_IsAccountEvent]  DEFAULT ((0)) FOR [IsAccountEvent]
GO
IF OBJECT_ID(N'[dbo].[DF_EventInfo_New_DropRate]') IS NULL
/****** Object:  Default [DF_EventInfo_New_DropRate]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[EventInfo_New] ADD  CONSTRAINT [DF_EventInfo_New_DropRate]  DEFAULT ((1)) FOR [DropRate]
GO
IF OBJECT_ID(N'[dbo].[DF_EventInfo_New_IswithPCbang]') IS NULL
/****** Object:  Default [DF_EventInfo_New_IswithPCbang]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[EventInfo_New] ADD  CONSTRAINT [DF_EventInfo_New_IswithPCbang]  DEFAULT ((0)) FOR [IswithPCbang]
GO
IF OBJECT_ID(N'[dbo].[DF_EventInfo_New_ChannelCode]') IS NULL
/****** Object:  Default [DF_EventInfo_New_ChannelCode]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[EventInfo_New] ADD  CONSTRAINT [DF_EventInfo_New_ChannelCode]  DEFAULT ((-1)) FOR [ChannelCode]
GO
IF OBJECT_ID(N'[dbo].[DF_EventInfo_New_BF_Team]') IS NULL
/****** Object:  Default [DF_EventInfo_New_BF_Team]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[EventInfo_New] ADD  CONSTRAINT [DF_EventInfo_New_BF_Team]  DEFAULT ((0)) FOR [BF_Team]
GO
IF OBJECT_ID(N'[dbo].[DF_EventInfo_New_HenirRewardCount]') IS NULL
/****** Object:  Default [DF_EventInfo_New_HenirRewardCount]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[EventInfo_New] ADD  CONSTRAINT [DF_EventInfo_New_HenirRewardCount]  DEFAULT ((0)) FOR [HenirRewardCount]
GO
IF OBJECT_ID(N'[dbo].[DF_EventInfo_New_IsHenirRewardLimited]') IS NULL
/****** Object:  Default [DF_EventInfo_New_IsHenirRewardLimited]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[EventInfo_New] ADD  CONSTRAINT [DF_EventInfo_New_IsHenirRewardLimited]  DEFAULT ((0)) FOR [IsHenirRewardLimited]
GO
IF OBJECT_ID(N'[dbo].[DF_EventInfo_New_ServerGroup]') IS NULL
/****** Object:  Default [DF_EventInfo_New_ServerGroup]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[EventInfo_New] ADD  CONSTRAINT [DF_EventInfo_New_ServerGroup]  DEFAULT ((-1)) FOR [ServerGroup]
GO
IF OBJECT_ID(N'[dbo].[DF_EventInfo_ServerSetID]') IS NULL
/****** Object:  Default [DF_EventInfo_ServerSetID]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[EventInfo] ADD  CONSTRAINT [DF_EventInfo_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_Event_ServerInfo_ServerGroup]') IS NULL
/****** Object:  Default [DF_Event_ServerInfo_ServerGroup]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[Event_ServerInfo] ADD  CONSTRAINT [DF_Event_ServerInfo_ServerGroup]  DEFAULT ((-1)) FOR [ServerGroup]
GO
IF OBJECT_ID(N'[dbo].[DF_Event_ServerInfo_ServerUID]') IS NULL
/****** Object:  Default [DF_Event_ServerInfo_ServerUID]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[Event_ServerInfo] ADD  CONSTRAINT [DF_Event_ServerInfo_ServerUID]  DEFAULT ((-1)) FOR [ServerUID]
GO
IF OBJECT_ID(N'[dbo].[DF_Event_RewardRetainUserItem_SlotNo]') IS NULL
/****** Object:  Default [DF_Event_RewardRetainUserItem_SlotNo]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[Event_RewardRetainUserItem] ADD  CONSTRAINT [DF_Event_RewardRetainUserItem_SlotNo]  DEFAULT ((-1)) FOR [SlotNo]
GO
IF OBJECT_ID(N'[dbo].[DF_Event_RewardRetainUserItem_ItemID]') IS NULL
/****** Object:  Default [DF_Event_RewardRetainUserItem_ItemID]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[Event_RewardRetainUserItem] ADD  CONSTRAINT [DF_Event_RewardRetainUserItem_ItemID]  DEFAULT ((-1)) FOR [ItemID]
GO
IF OBJECT_ID(N'[dbo].[DF_Event_RewardRetainUserItem_Quantity]') IS NULL
/****** Object:  Default [DF_Event_RewardRetainUserItem_Quantity]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[Event_RewardRetainUserItem] ADD  CONSTRAINT [DF_Event_RewardRetainUserItem_Quantity]  DEFAULT ((-1)) FOR [Quantity]
GO
IF OBJECT_ID(N'[dbo].[DF_Event_RewardLevelUp_Level]') IS NULL
/****** Object:  Default [DF_Event_RewardLevelUp_Level]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[Event_RewardLevelUp] ADD  CONSTRAINT [DF_Event_RewardLevelUp_Level]  DEFAULT ((-1)) FOR [Level]
GO
IF OBJECT_ID(N'[dbo].[DF_Event_RewardLevelUp_RewardID]') IS NULL
/****** Object:  Default [DF_Event_RewardLevelUp_RewardID]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[Event_RewardLevelUp] ADD  CONSTRAINT [DF_Event_RewardLevelUp_RewardID]  DEFAULT ((0)) FOR [RewardID]
GO
IF OBJECT_ID(N'[dbo].[DF_Event_Reward_RewardID]') IS NULL
/****** Object:  Default [DF_Event_Reward_RewardID]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[Event_Reward] ADD  CONSTRAINT [DF_Event_Reward_RewardID]  DEFAULT ((0)) FOR [RewardID]
GO
IF OBJECT_ID(N'[dbo].[DF_Event_Reward_RewardItemID]') IS NULL
/****** Object:  Default [DF_Event_Reward_RewardItemID]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[Event_Reward] ADD  CONSTRAINT [DF_Event_Reward_RewardItemID]  DEFAULT ((0)) FOR [RewardItemID]
GO
IF OBJECT_ID(N'[dbo].[DF_Event_Reward_Quantity]') IS NULL
/****** Object:  Default [DF_Event_Reward_Quantity]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[Event_Reward] ADD  CONSTRAINT [DF_Event_Reward_Quantity]  DEFAULT ((0)) FOR [Quantity]
GO
IF OBJECT_ID(N'[dbo].[DF_Event_Reward_Period]') IS NULL
/****** Object:  Default [DF_Event_Reward_Period]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[Event_Reward] ADD  CONSTRAINT [DF_Event_Reward_Period]  DEFAULT ((-1)) FOR [Period]
GO
IF OBJECT_ID(N'[dbo].[DF_Event_Monster_EventID]') IS NULL
/****** Object:  Default [DF_Event_Monster_EventID]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[Event_Monster] ADD  CONSTRAINT [DF_Event_Monster_EventID]  DEFAULT ((-1)) FOR [EventID]
GO
IF OBJECT_ID(N'[dbo].[DF_Event_Monster_MonDropCount]') IS NULL
/****** Object:  Default [DF_Event_Monster_MonDropCount]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[Event_Monster] ADD  CONSTRAINT [DF_Event_Monster_MonDropCount]  DEFAULT ((0)) FOR [MonDropCount]
GO
IF OBJECT_ID(N'[dbo].[DF_Event_Monster_IsBossStage]') IS NULL
/****** Object:  Default [DF_Event_Monster_IsBossStage]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[Event_Monster] ADD  CONSTRAINT [DF_Event_Monster_IsBossStage]  DEFAULT ((0)) FOR [IsBossStage]
GO
IF OBJECT_ID(N'[dbo].[DF_Event_Monster_MonsterID]') IS NULL
/****** Object:  Default [DF_Event_Monster_MonsterID]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[Event_Monster] ADD  CONSTRAINT [DF_Event_Monster_MonsterID]  DEFAULT ((0)) FOR [MonsterID]
GO
IF OBJECT_ID(N'[dbo].[DF_Event_Monster_AdventRate]') IS NULL
/****** Object:  Default [DF_Event_Monster_AdventRate]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[Event_Monster] ADD  CONSTRAINT [DF_Event_Monster_AdventRate]  DEFAULT ((0)) FOR [AdventRate]
GO
IF OBJECT_ID(N'[dbo].[DF_Event_Monster_DungeonID]') IS NULL
/****** Object:  Default [DF_Event_Monster_DungeonID]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[Event_Monster] ADD  CONSTRAINT [DF_Event_Monster_DungeonID]  DEFAULT ((0)) FOR [DungeonID]
GO
IF OBJECT_ID(N'[dbo].[DF_Event_Monster_NoDungeonID]') IS NULL
/****** Object:  Default [DF_Event_Monster_NoDungeonID]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[Event_Monster] ADD  CONSTRAINT [DF_Event_Monster_NoDungeonID]  DEFAULT ((0)) FOR [NoDungeonID]
GO
IF OBJECT_ID(N'[dbo].[DF_Event_Monster_NoDungeonStage]') IS NULL
/****** Object:  Default [DF_Event_Monster_NoDungeonStage]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[Event_Monster] ADD  CONSTRAINT [DF_Event_Monster_NoDungeonStage]  DEFAULT ((-1)) FOR [NoDungeonStage]
GO
IF OBJECT_ID(N'[dbo].[DF_DropEvent_Flag]') IS NULL
/****** Object:  Default [DF_DropEvent_Flag]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[DropEvent] ADD  CONSTRAINT [DF_DropEvent_Flag]  DEFAULT ((0)) FOR [Flag]
GO
IF OBJECT_ID(N'[dbo].[DF_CheatLog_ServerSetID]') IS NULL
/****** Object:  Default [DF_CheatLog_ServerSetID]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[CheatLog] ADD  CONSTRAINT [DF_CheatLog_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_CBT3rdDailyUserStats_ServerSetID]') IS NULL
/****** Object:  Default [DF_CBT3rdDailyUserStats_ServerSetID]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[CBT3rdDailyUserStats] ADD  CONSTRAINT [DF_CBT3rdDailyUserStats_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_CBT3rdDailyUserStats_TopConnectCnt_Guest]') IS NULL
/****** Object:  Default [DF_CBT3rdDailyUserStats_TopConnectCnt_Guest]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[CBT3rdDailyUserStats] ADD  CONSTRAINT [DF_CBT3rdDailyUserStats_TopConnectCnt_Guest]  DEFAULT ((0)) FOR [TopConnectCnt_Guest]
GO
IF OBJECT_ID(N'[dbo].[DF_CBT3rdDailyUserStats_TopConnectTime_Guest]') IS NULL
/****** Object:  Default [DF_CBT3rdDailyUserStats_TopConnectTime_Guest]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[CBT3rdDailyUserStats] ADD  CONSTRAINT [DF_CBT3rdDailyUserStats_TopConnectTime_Guest]  DEFAULT ((0)) FOR [TopConnectTime_Guest]
GO
IF OBJECT_ID(N'[dbo].[DF_CBT3rdDailyUserStats_AVGArcadePT]') IS NULL
/****** Object:  Default [DF_CBT3rdDailyUserStats_AVGArcadePT]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[CBT3rdDailyUserStats] ADD  CONSTRAINT [DF_CBT3rdDailyUserStats_AVGArcadePT]  DEFAULT ((0)) FOR [AVGArcadePT]
GO
IF OBJECT_ID(N'[dbo].[DF_CBT3rdDailyUserStats_AVGArcadePT_Normal]') IS NULL
/****** Object:  Default [DF_CBT3rdDailyUserStats_AVGArcadePT_Normal]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[CBT3rdDailyUserStats] ADD  CONSTRAINT [DF_CBT3rdDailyUserStats_AVGArcadePT_Normal]  DEFAULT ((0)) FOR [AVGArcadePT_Normal]
GO
IF OBJECT_ID(N'[dbo].[DF_CBT3rdDailyUserStats_AVGArcadePT_Guest]') IS NULL
/****** Object:  Default [DF_CBT3rdDailyUserStats_AVGArcadePT_Guest]    Script Date: 01/25/2014 12:19:12 ******/
ALTER TABLE [dbo].[CBT3rdDailyUserStats] ADD  CONSTRAINT [DF_CBT3rdDailyUserStats_AVGArcadePT_Guest]  DEFAULT ((0)) FOR [AVGArcadePT_Guest]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsAbusingLog_ServerSetID]') IS NULL
/****** Object:  Default [DF_StatsAbusingLog_ServerSetID]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsAbusingLog] ADD  CONSTRAINT [DF_StatsAbusingLog_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsAbnormalReason_ServerSetID]') IS NULL
/****** Object:  Default [DF_StatsAbnormalReason_ServerSetID]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsAbnormalReason] ADD  CONSTRAINT [DF_StatsAbnormalReason_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_StatCCUMinuteChannel_RegDate]') IS NULL
/****** Object:  Default [DF_StatCCUMinuteChannel_RegDate]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatCCUMinuteChannel] ADD  CONSTRAINT [DF_StatCCUMinuteChannel_RegDate]  DEFAULT (getdate()) FOR [RegDate]
GO
IF OBJECT_ID(N'[dbo].[DF_StatMinuteCCU_RegDate]') IS NULL
/****** Object:  Default [DF_StatMinuteCCU_RegDate]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatCCUMinute] ADD  CONSTRAINT [DF_StatMinuteCCU_RegDate]  DEFAULT (getdate()) FOR [RegDate]
GO
IF OBJECT_ID(N'[dbo].[DF_ResurrectionStoneLog_ServerSetID]') IS NULL
/****** Object:  Default [DF_ResurrectionStoneLog_ServerSetID]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[ResurrectionStoneLog] ADD  CONSTRAINT [DF_ResurrectionStoneLog_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_Rank_SpaceTime_Week_ServerSetID]') IS NULL
/****** Object:  Default [DF_Rank_SpaceTime_Week_ServerSetID]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[Rank_SpaceTime_Week] ADD  CONSTRAINT [DF_Rank_SpaceTime_Week_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_Rank_SpaceTime_Month_ServerSetID]') IS NULL
/****** Object:  Default [DF_Rank_SpaceTime_Month_ServerSetID]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[Rank_SpaceTime_Month] ADD  CONSTRAINT [DF_Rank_SpaceTime_Month_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_Rank_SpaceTime_Day_ServerSetID]') IS NULL
/****** Object:  Default [DF_Rank_SpaceTime_Day_ServerSetID]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[Rank_SpaceTime_Day] ADD  CONSTRAINT [DF_Rank_SpaceTime_Day_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsDailyQuiz_ServerSetID]') IS NULL
/****** Object:  Default [DF_StatsDailyQuiz_ServerSetID]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsDailyQuiz] ADD  CONSTRAINT [DF_StatsDailyQuiz_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsDaily_ServerSetID]') IS NULL
/****** Object:  Default [DF_StatsDaily_ServerSetID]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsDaily] ADD  CONSTRAINT [DF_StatsDaily_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsCSPLog_ServerSetID]') IS NULL
/****** Object:  Default [DF_StatsCSPLog_ServerSetID]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsCSPLog] ADD  CONSTRAINT [DF_StatsCSPLog_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsCharmItemLog_Direct_ServerSetID]') IS NULL
/****** Object:  Default [DF_StatsCharmItemLog_Direct_ServerSetID]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsCharmItemLog_Direct] ADD  CONSTRAINT [DF_StatsCharmItemLog_Direct_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsCharmItemLog_ServerSetID]') IS NULL
/****** Object:  Default [DF_StatsCharmItemLog_ServerSetID]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsCharmItemLog] ADD  CONSTRAINT [DF_StatsCharmItemLog_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsCashLog_ServerSetID]') IS NULL
/****** Object:  Default [DF_StatsCashLog_ServerSetID]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsCashLog] ADD  CONSTRAINT [DF_StatsCashLog_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsCashLog_Level]') IS NULL
/****** Object:  Default [DF_StatsCashLog_Level]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsCashLog] ADD  CONSTRAINT [DF_StatsCashLog_Level]  DEFAULT ((0)) FOR [Level]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsCashLog_UnitClass]') IS NULL
/****** Object:  Default [DF_StatsCashLog_UnitClass]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsCashLog] ADD  CONSTRAINT [DF_StatsCashLog_UnitClass]  DEFAULT ((0)) FOR [UnitClass]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsAttrib_AttachLog_ServerSetID]') IS NULL
/****** Object:  Default [DF_StatsAttrib_AttachLog_ServerSetID]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsAttrib_AttachLog] ADD  CONSTRAINT [DF_StatsAttrib_AttachLog_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsArcade_Floor]') IS NULL
/****** Object:  Default [DF_StatsArcade_Floor]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsArcade] ADD  CONSTRAINT [DF_StatsArcade_Floor]  DEFAULT ((0)) FOR [Floor]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsArcade_SW_Cnt]') IS NULL
/****** Object:  Default [DF_StatsArcade_SW_Cnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsArcade] ADD  CONSTRAINT [DF_StatsArcade_SW_Cnt]  DEFAULT ((0)) FOR [SW_Cnt]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsArcade_SL_Cnt]') IS NULL
/****** Object:  Default [DF_StatsArcade_SL_Cnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsArcade] ADD  CONSTRAINT [DF_StatsArcade_SL_Cnt]  DEFAULT ((0)) FOR [SL_Cnt]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsArcade_SG_Cnt]') IS NULL
/****** Object:  Default [DF_StatsArcade_SG_Cnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsArcade] ADD  CONSTRAINT [DF_StatsArcade_SG_Cnt]  DEFAULT ((0)) FOR [SG_Cnt]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsArcade_SRS_Cnt]') IS NULL
/****** Object:  Default [DF_StatsArcade_SRS_Cnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsArcade] ADD  CONSTRAINT [DF_StatsArcade_SRS_Cnt]  DEFAULT ((0)) FOR [SRS_Cnt]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsArcade_PW_Cnt]') IS NULL
/****** Object:  Default [DF_StatsArcade_PW_Cnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsArcade] ADD  CONSTRAINT [DF_StatsArcade_PW_Cnt]  DEFAULT ((0)) FOR [PW_Cnt]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsArcade_PL_Cnt]') IS NULL
/****** Object:  Default [DF_StatsArcade_PL_Cnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsArcade] ADD  CONSTRAINT [DF_StatsArcade_PL_Cnt]  DEFAULT ((0)) FOR [PL_Cnt]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsArcade_PG_Cnt]') IS NULL
/****** Object:  Default [DF_StatsArcade_PG_Cnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsArcade] ADD  CONSTRAINT [DF_StatsArcade_PG_Cnt]  DEFAULT ((0)) FOR [PG_Cnt]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsArcade_PRS_Cnt]') IS NULL
/****** Object:  Default [DF_StatsArcade_PRS_Cnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsArcade] ADD  CONSTRAINT [DF_StatsArcade_PRS_Cnt]  DEFAULT ((0)) FOR [PRS_Cnt]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsArcade_SW_Time]') IS NULL
/****** Object:  Default [DF_StatsArcade_SW_Time]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsArcade] ADD  CONSTRAINT [DF_StatsArcade_SW_Time]  DEFAULT ((0)) FOR [SW_Time]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsArcade_SL_Time]') IS NULL
/****** Object:  Default [DF_StatsArcade_SL_Time]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsArcade] ADD  CONSTRAINT [DF_StatsArcade_SL_Time]  DEFAULT ((0)) FOR [SL_Time]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsArcade_SG_Time]') IS NULL
/****** Object:  Default [DF_StatsArcade_SG_Time]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsArcade] ADD  CONSTRAINT [DF_StatsArcade_SG_Time]  DEFAULT ((0)) FOR [SG_Time]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsArcade_PW_Time]') IS NULL
/****** Object:  Default [DF_StatsArcade_PW_Time]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsArcade] ADD  CONSTRAINT [DF_StatsArcade_PW_Time]  DEFAULT ((0)) FOR [PW_Time]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsArcade_PL_Time]') IS NULL
/****** Object:  Default [DF_StatsArcade_PL_Time]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsArcade] ADD  CONSTRAINT [DF_StatsArcade_PL_Time]  DEFAULT ((0)) FOR [PL_Time]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsArcade_PG_Time]') IS NULL
/****** Object:  Default [DF_StatsArcade_PG_Time]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsArcade] ADD  CONSTRAINT [DF_StatsArcade_PG_Time]  DEFAULT ((0)) FOR [PG_Time]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsAndOrUser_ServerSetID]') IS NULL
/****** Object:  Default [DF_StatsAndOrUser_ServerSetID]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsAndOrUser] ADD  CONSTRAINT [DF_StatsAndOrUser_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsAllSpirit_Old_RegDate]') IS NULL
/****** Object:  Default [DF_StatsAllSpirit_Old_RegDate]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsAllSpirit_Old] ADD  CONSTRAINT [DF_StatsAllSpirit_Old_RegDate]  DEFAULT (getdate()) FOR [RegDate]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsAllSpirit_ServerSetID]') IS NULL
/****** Object:  Default [DF_StatsAllSpirit_ServerSetID]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsAllSpirit] ADD  CONSTRAINT [DF_StatsAllSpirit_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsAllSpirit_RegDate]') IS NULL
/****** Object:  Default [DF_StatsAllSpirit_RegDate]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsAllSpirit] ADD  CONSTRAINT [DF_StatsAllSpirit_RegDate]  DEFAULT (getdate()) FOR [RegDate]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsAllSkillDelete_ServerSetID]') IS NULL
/****** Object:  Default [DF_StatsAllSkillDelete_ServerSetID]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsAllSkillDelete] ADD  CONSTRAINT [DF_StatsAllSkillDelete_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsDecomposition_ServerSetID]') IS NULL
/****** Object:  Default [DF_StatsDecomposition_ServerSetID]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsDecomposition] ADD  CONSTRAINT [DF_StatsDecomposition_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsDungeon_ServerSetID]') IS NULL
/****** Object:  Default [DF_StatsDungeon_ServerSetID]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsDungeon] ADD  CONSTRAINT [DF_StatsDungeon_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsDungeon_UnitClass]') IS NULL
/****** Object:  Default [DF_StatsDungeon_UnitClass]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsDungeon] ADD  CONSTRAINT [DF_StatsDungeon_UnitClass]  DEFAULT ((0)) FOR [UnitClass]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsDungeon_SW_Cnt]') IS NULL
/****** Object:  Default [DF_StatsDungeon_SW_Cnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsDungeon] ADD  CONSTRAINT [DF_StatsDungeon_SW_Cnt]  DEFAULT ((0)) FOR [SW_Cnt]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsDungeon_SL_Cnt]') IS NULL
/****** Object:  Default [DF_StatsDungeon_SL_Cnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsDungeon] ADD  CONSTRAINT [DF_StatsDungeon_SL_Cnt]  DEFAULT ((0)) FOR [SL_Cnt]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsDungeon_SG_Cnt]') IS NULL
/****** Object:  Default [DF_StatsDungeon_SG_Cnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsDungeon] ADD  CONSTRAINT [DF_StatsDungeon_SG_Cnt]  DEFAULT ((0)) FOR [SG_Cnt]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsDungeon_SRS_Cnt]') IS NULL
/****** Object:  Default [DF_StatsDungeon_SRS_Cnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsDungeon] ADD  CONSTRAINT [DF_StatsDungeon_SRS_Cnt]  DEFAULT ((0)) FOR [SRS_Cnt]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsDungeon_PW_Cnt]') IS NULL
/****** Object:  Default [DF_StatsDungeon_PW_Cnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsDungeon] ADD  CONSTRAINT [DF_StatsDungeon_PW_Cnt]  DEFAULT ((0)) FOR [PW_Cnt]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsDungeon_PL_Cnt]') IS NULL
/****** Object:  Default [DF_StatsDungeon_PL_Cnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsDungeon] ADD  CONSTRAINT [DF_StatsDungeon_PL_Cnt]  DEFAULT ((0)) FOR [PL_Cnt]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsDungeon_PG_Cnt]') IS NULL
/****** Object:  Default [DF_StatsDungeon_PG_Cnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsDungeon] ADD  CONSTRAINT [DF_StatsDungeon_PG_Cnt]  DEFAULT ((0)) FOR [PG_Cnt]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsDungeon_PRS_Cnt]') IS NULL
/****** Object:  Default [DF_StatsDungeon_PRS_Cnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsDungeon] ADD  CONSTRAINT [DF_StatsDungeon_PRS_Cnt]  DEFAULT ((0)) FOR [PRS_Cnt]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsDungeon_SW_Time]') IS NULL
/****** Object:  Default [DF_StatsDungeon_SW_Time]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsDungeon] ADD  CONSTRAINT [DF_StatsDungeon_SW_Time]  DEFAULT ((0)) FOR [SW_Time]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsDungeon_SL_Time]') IS NULL
/****** Object:  Default [DF_StatsDungeon_SL_Time]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsDungeon] ADD  CONSTRAINT [DF_StatsDungeon_SL_Time]  DEFAULT ((0)) FOR [SL_Time]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsDungeon_SG_Time]') IS NULL
/****** Object:  Default [DF_StatsDungeon_SG_Time]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsDungeon] ADD  CONSTRAINT [DF_StatsDungeon_SG_Time]  DEFAULT ((0)) FOR [SG_Time]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsDungeon_PW_Time]') IS NULL
/****** Object:  Default [DF_StatsDungeon_PW_Time]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsDungeon] ADD  CONSTRAINT [DF_StatsDungeon_PW_Time]  DEFAULT ((0)) FOR [PW_Time]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsDungeon_PL_Time]') IS NULL
/****** Object:  Default [DF_StatsDungeon_PL_Time]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsDungeon] ADD  CONSTRAINT [DF_StatsDungeon_PL_Time]  DEFAULT ((0)) FOR [PL_Time]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsDungeon_PG_Time]') IS NULL
/****** Object:  Default [DF_StatsDungeon_PG_Time]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsDungeon] ADD  CONSTRAINT [DF_StatsDungeon_PG_Time]  DEFAULT ((0)) FOR [PG_Time]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsMoneySupply_ServerSetID]') IS NULL
/****** Object:  Default [DF_StatsMoneySupply_ServerSetID]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsMoneySupply] ADD  CONSTRAINT [DF_StatsMoneySupply_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsMoneySupply_PDun]') IS NULL
/****** Object:  Default [DF_StatsMoneySupply_PDun]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsMoneySupply] ADD  CONSTRAINT [DF_StatsMoneySupply_PDun]  DEFAULT ((0)) FOR [PDun]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsMoneySupply_PTraining]') IS NULL
/****** Object:  Default [DF_StatsMoneySupply_PTraining]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsMoneySupply] ADD  CONSTRAINT [DF_StatsMoneySupply_PTraining]  DEFAULT ((0)) FOR [PTraining]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsMoneySupply_PQuest]') IS NULL
/****** Object:  Default [DF_StatsMoneySupply_PQuest]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsMoneySupply] ADD  CONSTRAINT [DF_StatsMoneySupply_PQuest]  DEFAULT ((0)) FOR [PQuest]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsMoneySupply_PItemSell]') IS NULL
/****** Object:  Default [DF_StatsMoneySupply_PItemSell]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsMoneySupply] ADD  CONSTRAINT [DF_StatsMoneySupply_PItemSell]  DEFAULT ((0)) FOR [PItemSell]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsMoneySupply_PItemP2P]') IS NULL
/****** Object:  Default [DF_StatsMoneySupply_PItemP2P]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsMoneySupply] ADD  CONSTRAINT [DF_StatsMoneySupply_PItemP2P]  DEFAULT ((0)) FOR [PItemP2P]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsMoneySupply_PStoreP2P]') IS NULL
/****** Object:  Default [DF_StatsMoneySupply_PStoreP2P]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsMoneySupply] ADD  CONSTRAINT [DF_StatsMoneySupply_PStoreP2P]  DEFAULT ((0)) FOR [PStoreP2P]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsMoneySupply_PPostP2P]') IS NULL
/****** Object:  Default [DF_StatsMoneySupply_PPostP2P]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsMoneySupply] ADD  CONSTRAINT [DF_StatsMoneySupply_PPostP2P]  DEFAULT ((0)) FOR [PPostP2P]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsMoneySupply_MItemBuy]') IS NULL
/****** Object:  Default [DF_StatsMoneySupply_MItemBuy]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsMoneySupply] ADD  CONSTRAINT [DF_StatsMoneySupply_MItemBuy]  DEFAULT ((0)) FOR [MItemBuy]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsMoneySupply_MItemP2P]') IS NULL
/****** Object:  Default [DF_StatsMoneySupply_MItemP2P]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsMoneySupply] ADD  CONSTRAINT [DF_StatsMoneySupply_MItemP2P]  DEFAULT ((0)) FOR [MItemP2P]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsMoneySupply_MItemRepair]') IS NULL
/****** Object:  Default [DF_StatsMoneySupply_MItemRepair]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsMoneySupply] ADD  CONSTRAINT [DF_StatsMoneySupply_MItemRepair]  DEFAULT ((0)) FOR [MItemRepair]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsMoneySupply_MItemMake]') IS NULL
/****** Object:  Default [DF_StatsMoneySupply_MItemMake]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsMoneySupply] ADD  CONSTRAINT [DF_StatsMoneySupply_MItemMake]  DEFAULT ((0)) FOR [MItemMake]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsMoneySupply_MDunPenalty]') IS NULL
/****** Object:  Default [DF_StatsMoneySupply_MDunPenalty]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsMoneySupply] ADD  CONSTRAINT [DF_StatsMoneySupply_MDunPenalty]  DEFAULT ((0)) FOR [MDunPenalty]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsMoneySupply_MStoreP2P]') IS NULL
/****** Object:  Default [DF_StatsMoneySupply_MStoreP2P]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsMoneySupply] ADD  CONSTRAINT [DF_StatsMoneySupply_MStoreP2P]  DEFAULT ((0)) FOR [MStoreP2P]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsMoneySupply_MStoreOpen]') IS NULL
/****** Object:  Default [DF_StatsMoneySupply_MStoreOpen]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsMoneySupply] ADD  CONSTRAINT [DF_StatsMoneySupply_MStoreOpen]  DEFAULT ((0)) FOR [MStoreOpen]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsMoneySupply_MEnchant]') IS NULL
/****** Object:  Default [DF_StatsMoneySupply_MEnchant]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsMoneySupply] ADD  CONSTRAINT [DF_StatsMoneySupply_MEnchant]  DEFAULT ((0)) FOR [MEnchant]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsMoneySupply_MSocket]') IS NULL
/****** Object:  Default [DF_StatsMoneySupply_MSocket]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsMoneySupply] ADD  CONSTRAINT [DF_StatsMoneySupply_MSocket]  DEFAULT ((0)) FOR [MSocket]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsMoneySupply_MPostP2P]') IS NULL
/****** Object:  Default [DF_StatsMoneySupply_MPostP2P]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsMoneySupply] ADD  CONSTRAINT [DF_StatsMoneySupply_MPostP2P]  DEFAULT ((0)) FOR [MPostP2P]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsMoneySupply_MPostBasic]') IS NULL
/****** Object:  Default [DF_StatsMoneySupply_MPostBasic]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsMoneySupply] ADD  CONSTRAINT [DF_StatsMoneySupply_MPostBasic]  DEFAULT ((0)) FOR [MPostBasic]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsMoneySupply_MPostItem]') IS NULL
/****** Object:  Default [DF_StatsMoneySupply_MPostItem]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsMoneySupply] ADD  CONSTRAINT [DF_StatsMoneySupply_MPostItem]  DEFAULT ((0)) FOR [MPostItem]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsMoneySupply_MAttribute]') IS NULL
/****** Object:  Default [DF_StatsMoneySupply_MAttribute]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsMoneySupply] ADD  CONSTRAINT [DF_StatsMoneySupply_MAttribute]  DEFAULT ((0)) FOR [MAttribute]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsMoneySupply_MStoreP2PTax]') IS NULL
/****** Object:  Default [DF_StatsMoneySupply_MStoreP2PTax]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsMoneySupply] ADD  CONSTRAINT [DF_StatsMoneySupply_MStoreP2PTax]  DEFAULT ((0)) FOR [MStoreP2PTax]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsMoneySupply_MStoreBBSTax]') IS NULL
/****** Object:  Default [DF_StatsMoneySupply_MStoreBBSTax]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsMoneySupply] ADD  CONSTRAINT [DF_StatsMoneySupply_MStoreBBSTax]  DEFAULT ((0)) FOR [MStoreBBSTax]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsMoneySupply_MPShopAgency]') IS NULL
/****** Object:  Default [DF_StatsMoneySupply_MPShopAgency]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsMoneySupply] ADD  CONSTRAINT [DF_StatsMoneySupply_MPShopAgency]  DEFAULT ((0)) FOR [MPShopAgency]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsMoneySupply_MBuyTaxPShopA]') IS NULL
/****** Object:  Default [DF_StatsMoneySupply_MBuyTaxPShopA]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsMoneySupply] ADD  CONSTRAINT [DF_StatsMoneySupply_MBuyTaxPShopA]  DEFAULT ((0)) FOR [MBuyTaxPShopA]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsMoneySupply_PPShopPickUp]') IS NULL
/****** Object:  Default [DF_StatsMoneySupply_PPShopPickUp]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsMoneySupply] ADD  CONSTRAINT [DF_StatsMoneySupply_PPShopPickUp]  DEFAULT ((0)) FOR [PPShopPickUp]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsMoneySupply_TotalED]') IS NULL
/****** Object:  Default [DF_StatsMoneySupply_TotalED]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsMoneySupply] ADD  CONSTRAINT [DF_StatsMoneySupply_TotalED]  DEFAULT ((0)) FOR [TotalED]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsMoneySupply_MOpenCubeSpendED]') IS NULL
/****** Object:  Default [DF_StatsMoneySupply_MOpenCubeSpendED]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsMoneySupply] ADD  CONSTRAINT [DF_StatsMoneySupply_MOpenCubeSpendED]  DEFAULT ((0)) FOR [MOpenCubeSpendED]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsMoneySupply_PBattleFieldED]') IS NULL
/****** Object:  Default [DF_StatsMoneySupply_PBattleFieldED]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsMoneySupply] ADD  CONSTRAINT [DF_StatsMoneySupply_PBattleFieldED]  DEFAULT ((0)) FOR [PBattleFieldED]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsMoneySupply_MCoboExpressTicketED]') IS NULL
/****** Object:  Default [DF_StatsMoneySupply_MCoboExpressTicketED]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsMoneySupply] ADD  CONSTRAINT [DF_StatsMoneySupply_MCoboExpressTicketED]  DEFAULT ((0)) FOR [MCoboExpressTicketED]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsMoneySupply_MItemDecom]') IS NULL
/****** Object:  Default [DF_StatsMoneySupply_MItemDecom]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsMoneySupply] ADD  CONSTRAINT [DF_StatsMoneySupply_MItemDecom]  DEFAULT ((0)) FOR [MItemDecom]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsMoneyLog_ServerSetID]') IS NULL
/****** Object:  Default [DF_StatsMoneyLog_ServerSetID]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsMoneyLog] ADD  CONSTRAINT [DF_StatsMoneyLog_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsMegaphone_ServerSetID]') IS NULL
/****** Object:  Default [DF_StatsMegaphone_ServerSetID]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsMegaphone] ADD  CONSTRAINT [DF_StatsMegaphone_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsJackPot_ServerSetID]') IS NULL
/****** Object:  Default [DF_StatsJackPot_ServerSetID]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsJackPot] ADD  CONSTRAINT [DF_StatsJackPot_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsJackPot_DurationTime]') IS NULL
/****** Object:  Default [DF_StatsJackPot_DurationTime]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsJackPot] ADD  CONSTRAINT [DF_StatsJackPot_DurationTime]  DEFAULT ((0)) FOR [DurationTime]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsItemResurrection_ServerSetID]') IS NULL
/****** Object:  Default [DF_StatsItemResurrection_ServerSetID]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsItemResurrection] ADD  CONSTRAINT [DF_StatsItemResurrection_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsItemChange_ServerSetID]') IS NULL
/****** Object:  Default [DF_StatsItemChange_ServerSetID]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsItemChange] ADD  CONSTRAINT [DF_StatsItemChange_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsItemBreak_ServerSetID]') IS NULL
/****** Object:  Default [DF_StatsItemBreak_ServerSetID]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsItemBreak] ADD  CONSTRAINT [DF_StatsItemBreak_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsGetItemLog_ServerSetID]') IS NULL
/****** Object:  Default [DF_StatsGetItemLog_ServerSetID]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsGetItemLog] ADD  CONSTRAINT [DF_StatsGetItemLog_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsPacketLog_2_Regdate]') IS NULL
/****** Object:  Default [DF_StatsPacketLog_2_Regdate]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsPacketLog_2] ADD  CONSTRAINT [DF_StatsPacketLog_2_Regdate]  DEFAULT (getdate()) FOR [Regdate]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsPacketLog_1_Regdate]') IS NULL
/****** Object:  Default [DF_StatsPacketLog_1_Regdate]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsPacketLog_1] ADD  CONSTRAINT [DF_StatsPacketLog_1_Regdate]  DEFAULT (getdate()) FOR [Regdate]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsNickNameRestore_ServerSetID]') IS NULL
/****** Object:  Default [DF_StatsNickNameRestore_ServerSetID]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsNickNameRestore] ADD  CONSTRAINT [DF_StatsNickNameRestore_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsNickNameChange_ServerSetID]') IS NULL
/****** Object:  Default [DF_StatsNickNameChange_ServerSetID]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsNickNameChange] ADD  CONSTRAINT [DF_StatsNickNameChange_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsStoneCnt_ServerSetID]') IS NULL
/****** Object:  Default [DF_StatsStoneCnt_ServerSetID]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsStoneCnt] ADD  CONSTRAINT [DF_StatsStoneCnt_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsStoneCnt_Regdate]') IS NULL
/****** Object:  Default [DF_StatsStoneCnt_Regdate]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsStoneCnt] ADD  CONSTRAINT [DF_StatsStoneCnt_Regdate]  DEFAULT ((0)) FOR [Regdate]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsStoneCnt_PlayerCnt]') IS NULL
/****** Object:  Default [DF_StatsStoneCnt_PlayerCnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsStoneCnt] ADD  CONSTRAINT [DF_StatsStoneCnt_PlayerCnt]  DEFAULT ((0)) FOR [PlayerCnt]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsStoneCnt_UseCnt]') IS NULL
/****** Object:  Default [DF_StatsStoneCnt_UseCnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsStoneCnt] ADD  CONSTRAINT [DF_StatsStoneCnt_UseCnt]  DEFAULT ((0)) FOR [UseCnt]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsStoneCnt_DailyAVGCnt]') IS NULL
/****** Object:  Default [DF_StatsStoneCnt_DailyAVGCnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsStoneCnt] ADD  CONSTRAINT [DF_StatsStoneCnt_DailyAVGCnt]  DEFAULT ((0)) FOR [DailyAVGCnt]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsStoneCnt_FreeInsertCnt]') IS NULL
/****** Object:  Default [DF_StatsStoneCnt_FreeInsertCnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsStoneCnt] ADD  CONSTRAINT [DF_StatsStoneCnt_FreeInsertCnt]  DEFAULT ((0)) FOR [FreeInsertCnt]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsStoneCnt_NowCnt]') IS NULL
/****** Object:  Default [DF_StatsStoneCnt_NowCnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsStoneCnt] ADD  CONSTRAINT [DF_StatsStoneCnt_NowCnt]  DEFAULT ((0)) FOR [NowCnt]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsStoneCnt_Plus1]') IS NULL
/****** Object:  Default [DF_StatsStoneCnt_Plus1]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsStoneCnt] ADD  CONSTRAINT [DF_StatsStoneCnt_Plus1]  DEFAULT ((0)) FOR [Plus1]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsStoneCnt_Plus2]') IS NULL
/****** Object:  Default [DF_StatsStoneCnt_Plus2]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsStoneCnt] ADD  CONSTRAINT [DF_StatsStoneCnt_Plus2]  DEFAULT ((0)) FOR [Plus2]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsStoneCnt_Plus3]') IS NULL
/****** Object:  Default [DF_StatsStoneCnt_Plus3]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsStoneCnt] ADD  CONSTRAINT [DF_StatsStoneCnt_Plus3]  DEFAULT ((0)) FOR [Plus3]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsStoneCnt_PlusOver3]') IS NULL
/****** Object:  Default [DF_StatsStoneCnt_PlusOver3]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsStoneCnt] ADD  CONSTRAINT [DF_StatsStoneCnt_PlusOver3]  DEFAULT ((0)) FOR [PlusOver3]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsSpiritLog_ServerSetID]') IS NULL
/****** Object:  Default [DF_StatsSpiritLog_ServerSetID]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsSpiritLog] ADD  CONSTRAINT [DF_StatsSpiritLog_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsSealLog_ServerSetID]') IS NULL
/****** Object:  Default [DF_StatsSealLog_ServerSetID]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsSealLog] ADD  CONSTRAINT [DF_StatsSealLog_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsTraining_ServerSetID]') IS NULL
/****** Object:  Default [DF_StatsTraining_ServerSetID]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsTraining] ADD  CONSTRAINT [DF_StatsTraining_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsTraining_Win_Cnt]') IS NULL
/****** Object:  Default [DF_StatsTraining_Win_Cnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsTraining] ADD  CONSTRAINT [DF_StatsTraining_Win_Cnt]  DEFAULT ((0)) FOR [Win_Cnt]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsTraining_Lose_Cnt]') IS NULL
/****** Object:  Default [DF_StatsTraining_Lose_Cnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsTraining] ADD  CONSTRAINT [DF_StatsTraining_Lose_Cnt]  DEFAULT ((0)) FOR [Lose_Cnt]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsTraining_GiveUp_Cnt]') IS NULL
/****** Object:  Default [DF_StatsTraining_GiveUp_Cnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsTraining] ADD  CONSTRAINT [DF_StatsTraining_GiveUp_Cnt]  DEFAULT ((0)) FOR [GiveUp_Cnt]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsTraining_Win_Time]') IS NULL
/****** Object:  Default [DF_StatsTraining_Win_Time]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsTraining] ADD  CONSTRAINT [DF_StatsTraining_Win_Time]  DEFAULT ((0)) FOR [Win_Time]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsTraining_Lose_Time]') IS NULL
/****** Object:  Default [DF_StatsTraining_Lose_Time]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsTraining] ADD  CONSTRAINT [DF_StatsTraining_Lose_Time]  DEFAULT ((0)) FOR [Lose_Time]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsTraining_GiveUp_Time]') IS NULL
/****** Object:  Default [DF_StatsTraining_GiveUp_Time]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsTraining] ADD  CONSTRAINT [DF_StatsTraining_GiveUp_Time]  DEFAULT ((0)) FOR [GiveUp_Time]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsTradeEnd_ServerSetID]') IS NULL
/****** Object:  Default [DF_StatsTradeEnd_ServerSetID]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsTradeEnd] ADD  CONSTRAINT [DF_StatsTradeEnd_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsTimeSpaceTop100_ServerSetID]') IS NULL
/****** Object:  Default [DF_StatsTimeSpaceTop100_ServerSetID]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsTimeSpaceTop100] ADD  CONSTRAINT [DF_StatsTimeSpaceTop100_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_STrade_ServerSetID]') IS NULL
/****** Object:  Default [DF_STrade_ServerSetID]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[STrade] ADD  CONSTRAINT [DF_STrade_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_STrade_IsBBS]') IS NULL
/****** Object:  Default [DF_STrade_IsBBS]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[STrade] ADD  CONSTRAINT [DF_STrade_IsBBS]  DEFAULT ((0)) FOR [IsBBS]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsVsMap_ServerSetID]') IS NULL
/****** Object:  Default [DF_StatsVsMap_ServerSetID]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsVsMap] ADD  CONSTRAINT [DF_StatsVsMap_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsVsMap_MapCnt]') IS NULL
/****** Object:  Default [DF_StatsVsMap_MapCnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsVsMap] ADD  CONSTRAINT [DF_StatsVsMap_MapCnt]  DEFAULT ((0)) FOR [MapCnt]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsVs_ServerSetID]') IS NULL
/****** Object:  Default [DF_StatsVs_ServerSetID]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsVs] ADD  CONSTRAINT [DF_StatsVs_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsVs_TMW_Cnt]') IS NULL
/****** Object:  Default [DF_StatsVs_TMW_Cnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsVs] ADD  CONSTRAINT [DF_StatsVs_TMW_Cnt]  DEFAULT ((0)) FOR [TMW_Cnt]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsVs_TML_Cnt]') IS NULL
/****** Object:  Default [DF_StatsVs_TML_Cnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsVs] ADD  CONSTRAINT [DF_StatsVs_TML_Cnt]  DEFAULT ((0)) FOR [TML_Cnt]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsVs_TMG_Cnt]') IS NULL
/****** Object:  Default [DF_StatsVs_TMG_Cnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsVs] ADD  CONSTRAINT [DF_StatsVs_TMG_Cnt]  DEFAULT ((0)) FOR [TMG_Cnt]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsVs_TMD_Cnt]') IS NULL
/****** Object:  Default [DF_StatsVs_TMD_Cnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsVs] ADD  CONSTRAINT [DF_StatsVs_TMD_Cnt]  DEFAULT ((0)) FOR [TMD_Cnt]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsVs_TDW_Cnt]') IS NULL
/****** Object:  Default [DF_StatsVs_TDW_Cnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsVs] ADD  CONSTRAINT [DF_StatsVs_TDW_Cnt]  DEFAULT ((0)) FOR [TDW_Cnt]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsVs_TDL_Cnt]') IS NULL
/****** Object:  Default [DF_StatsVs_TDL_Cnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsVs] ADD  CONSTRAINT [DF_StatsVs_TDL_Cnt]  DEFAULT ((0)) FOR [TDL_Cnt]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsVs_TDG_Cnt]') IS NULL
/****** Object:  Default [DF_StatsVs_TDG_Cnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsVs] ADD  CONSTRAINT [DF_StatsVs_TDG_Cnt]  DEFAULT ((0)) FOR [TDG_Cnt]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsVs_TDD_Cnt]') IS NULL
/****** Object:  Default [DF_StatsVs_TDD_Cnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsVs] ADD  CONSTRAINT [DF_StatsVs_TDD_Cnt]  DEFAULT ((0)) FOR [TDD_Cnt]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsVs_TDNan_Cnt]') IS NULL
/****** Object:  Default [DF_StatsVs_TDNan_Cnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsVs] ADD  CONSTRAINT [DF_StatsVs_TDNan_Cnt]  DEFAULT ((0)) FOR [TDNan_Cnt]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsVs_DW_Cnt]') IS NULL
/****** Object:  Default [DF_StatsVs_DW_Cnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsVs] ADD  CONSTRAINT [DF_StatsVs_DW_Cnt]  DEFAULT ((0)) FOR [DW_Cnt]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsVs_DL_Cnt]') IS NULL
/****** Object:  Default [DF_StatsVs_DL_Cnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsVs] ADD  CONSTRAINT [DF_StatsVs_DL_Cnt]  DEFAULT ((0)) FOR [DL_Cnt]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsVs_DG_Cnt]') IS NULL
/****** Object:  Default [DF_StatsVs_DG_Cnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsVs] ADD  CONSTRAINT [DF_StatsVs_DG_Cnt]  DEFAULT ((0)) FOR [DG_Cnt]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsVs_DD_Cnt]') IS NULL
/****** Object:  Default [DF_StatsVs_DD_Cnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsVs] ADD  CONSTRAINT [DF_StatsVs_DD_Cnt]  DEFAULT ((0)) FOR [DD_Cnt]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsVs_DNan_Cnt]') IS NULL
/****** Object:  Default [DF_StatsVs_DNan_Cnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsVs] ADD  CONSTRAINT [DF_StatsVs_DNan_Cnt]  DEFAULT ((0)) FOR [DNan_Cnt]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsVs_TMW_Time]') IS NULL
/****** Object:  Default [DF_StatsVs_TMW_Time]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsVs] ADD  CONSTRAINT [DF_StatsVs_TMW_Time]  DEFAULT ((0)) FOR [TMW_Time]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsVs_TML_Time]') IS NULL
/****** Object:  Default [DF_StatsVs_TML_Time]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsVs] ADD  CONSTRAINT [DF_StatsVs_TML_Time]  DEFAULT ((0)) FOR [TML_Time]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsVs_TMG_Time]') IS NULL
/****** Object:  Default [DF_StatsVs_TMG_Time]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsVs] ADD  CONSTRAINT [DF_StatsVs_TMG_Time]  DEFAULT ((0)) FOR [TMG_Time]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsVs_TMD_Time]') IS NULL
/****** Object:  Default [DF_StatsVs_TMD_Time]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsVs] ADD  CONSTRAINT [DF_StatsVs_TMD_Time]  DEFAULT ((0)) FOR [TMD_Time]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsVs_TDW_Time]') IS NULL
/****** Object:  Default [DF_StatsVs_TDW_Time]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsVs] ADD  CONSTRAINT [DF_StatsVs_TDW_Time]  DEFAULT ((0)) FOR [TDW_Time]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsVs_TDL_Time]') IS NULL
/****** Object:  Default [DF_StatsVs_TDL_Time]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsVs] ADD  CONSTRAINT [DF_StatsVs_TDL_Time]  DEFAULT ((0)) FOR [TDL_Time]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsVs_TDG_Time]') IS NULL
/****** Object:  Default [DF_StatsVs_TDG_Time]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsVs] ADD  CONSTRAINT [DF_StatsVs_TDG_Time]  DEFAULT ((0)) FOR [TDG_Time]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsVs_TDD_Time]') IS NULL
/****** Object:  Default [DF_StatsVs_TDD_Time]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsVs] ADD  CONSTRAINT [DF_StatsVs_TDD_Time]  DEFAULT ((0)) FOR [TDD_Time]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsVs_TDNan_Time]') IS NULL
/****** Object:  Default [DF_StatsVs_TDNan_Time]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsVs] ADD  CONSTRAINT [DF_StatsVs_TDNan_Time]  DEFAULT ((0)) FOR [TDNan_Time]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsVs_DW_Time]') IS NULL
/****** Object:  Default [DF_StatsVs_DW_Time]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsVs] ADD  CONSTRAINT [DF_StatsVs_DW_Time]  DEFAULT ((0)) FOR [DW_Time]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsVs_DL_Time]') IS NULL
/****** Object:  Default [DF_StatsVs_DL_Time]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsVs] ADD  CONSTRAINT [DF_StatsVs_DL_Time]  DEFAULT ((0)) FOR [DL_Time]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsVs_DG_Time]') IS NULL
/****** Object:  Default [DF_StatsVs_DG_Time]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsVs] ADD  CONSTRAINT [DF_StatsVs_DG_Time]  DEFAULT ((0)) FOR [DG_Time]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsVs_DD_Time]') IS NULL
/****** Object:  Default [DF_StatsVs_DD_Time]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsVs] ADD  CONSTRAINT [DF_StatsVs_DD_Time]  DEFAULT ((0)) FOR [DD_Time]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsVs_DNan_Time]') IS NULL
/****** Object:  Default [DF_StatsVs_DNan_Time]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsVs] ADD  CONSTRAINT [DF_StatsVs_DNan_Time]  DEFAULT ((0)) FOR [DNan_Time]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_Age]') IS NULL
/****** Object:  Default [DF_UnitStatistics_Age]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_Age]  DEFAULT ((0)) FOR [Age]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_Gender]') IS NULL
/****** Object:  Default [DF_UnitStatistics_Gender]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_Gender]  DEFAULT ((0)) FOR [Gender]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_RegDate]') IS NULL
/****** Object:  Default [DF_UnitStatistics_RegDate]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_RegDate]  DEFAULT (getdate()) FOR [RegDate]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_LastDate]') IS NULL
/****** Object:  Default [DF_UnitStatistics_LastDate]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_LastDate]  DEFAULT (getdate()) FOR [LastDate]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_PlayDayCnt]') IS NULL
/****** Object:  Default [DF_UnitStatistics_PlayDayCnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_PlayDayCnt]  DEFAULT ((0)) FOR [PlayDayCnt]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_LoginCount]') IS NULL
/****** Object:  Default [DF_UnitStatistics_LoginCount]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_LoginCount]  DEFAULT ((0)) FOR [LoginCount]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_CharNo]') IS NULL
/****** Object:  Default [DF_UnitStatistics_CharNo]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_CharNo]  DEFAULT ((0)) FOR [CharNo]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_IsFirst]') IS NULL
/****** Object:  Default [DF_UnitStatistics_IsFirst]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_IsFirst]  DEFAULT ((0)) FOR [IsFirst]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_UnitClass]') IS NULL
/****** Object:  Default [DF_UnitStatistics_UnitClass]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_UnitClass]  DEFAULT ((0)) FOR [UnitClass]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_Deleted]') IS NULL
/****** Object:  Default [DF_UnitStatistics_Deleted]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_Level]') IS NULL
/****** Object:  Default [DF_UnitStatistics_Level]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_Level]  DEFAULT ((0)) FOR [Level]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_Exp]') IS NULL
/****** Object:  Default [DF_UnitStatistics_Exp]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_Exp]  DEFAULT ((0)) FOR [Exp]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_GamePoint]') IS NULL
/****** Object:  Default [DF_UnitStatistics_GamePoint]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_GamePoint]  DEFAULT ((0)) FOR [GamePoint]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_PDunED]') IS NULL
/****** Object:  Default [DF_UnitStatistics_PDunED]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_PDunED]  DEFAULT ((0)) FOR [PDunED]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_PQuestED]') IS NULL
/****** Object:  Default [DF_UnitStatistics_PQuestED]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_PQuestED]  DEFAULT ((0)) FOR [PQuestED]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_PItemSellED]') IS NULL
/****** Object:  Default [DF_UnitStatistics_PItemSellED]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_PItemSellED]  DEFAULT ((0)) FOR [PItemSellED]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_PItemP2PED]') IS NULL
/****** Object:  Default [DF_UnitStatistics_PItemP2PED]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_PItemP2PED]  DEFAULT ((0)) FOR [PItemP2PED]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_MItemBuy]') IS NULL
/****** Object:  Default [DF_UnitStatistics_MItemBuy]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_MItemBuy]  DEFAULT ((0)) FOR [MItemBuyED]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_MItemP2PED]') IS NULL
/****** Object:  Default [DF_UnitStatistics_MItemP2PED]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_MItemP2PED]  DEFAULT ((0)) FOR [MItemP2PED]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_MItemMakeED]') IS NULL
/****** Object:  Default [DF_UnitStatistics_MItemMakeED]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_MItemMakeED]  DEFAULT ((0)) FOR [MItemMakeED]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_MItemRepairED]') IS NULL
/****** Object:  Default [DF_UnitStatistics_MItemRepairED]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_MItemRepairED]  DEFAULT ((0)) FOR [MItemRepairED]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_MStoreP2P]') IS NULL
/****** Object:  Default [DF_UnitStatistics_MStoreP2P]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_MStoreP2P]  DEFAULT ((0)) FOR [MStoreP2P]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_MEnchant]') IS NULL
/****** Object:  Default [DF_UnitStatistics_MEnchant]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_MEnchant]  DEFAULT ((0)) FOR [MEnchant]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_MSocket]') IS NULL
/****** Object:  Default [DF_UnitStatistics_MSocket]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_MSocket]  DEFAULT ((0)) FOR [MSocket]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_VsPoint]') IS NULL
/****** Object:  Default [DF_UnitStatistics_VsPoint]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_VsPoint]  DEFAULT ((0)) FOR [VsPoint]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_VsPointMax]') IS NULL
/****** Object:  Default [DF_UnitStatistics_VsPointMax]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_VsPointMax]  DEFAULT ((0)) FOR [VsPointMax]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_SPoint]') IS NULL
/****** Object:  Default [DF_UnitStatistics_SPoint]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_SPoint]  DEFAULT ((0)) FOR [SPoint]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_VsRank]') IS NULL
/****** Object:  Default [DF_UnitStatistics_VsRank]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_VsRank]  DEFAULT ((0)) FOR [VsRank]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_ExpRank]') IS NULL
/****** Object:  Default [DF_UnitStatistics_ExpRank]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_ExpRank]  DEFAULT ((0)) FOR [ExpRank]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_UseSpirit]') IS NULL
/****** Object:  Default [DF_UnitStatistics_UseSpirit]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_UseSpirit]  DEFAULT ((0)) FOR [UseSpirit]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_AllSpirit]') IS NULL
/****** Object:  Default [DF_UnitStatistics_AllSpirit]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_AllSpirit]  DEFAULT ((0)) FOR [AllSpirit]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_KillCnt]') IS NULL
/****** Object:  Default [DF_UnitStatistics_KillCnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_KillCnt]  DEFAULT ((0)) FOR [KillCnt]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_VsCnt]') IS NULL
/****** Object:  Default [DF_UnitStatistics_VsCnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_VsCnt]  DEFAULT ((0)) FOR [VsCnt]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_DSoloCnt]') IS NULL
/****** Object:  Default [DF_UnitStatistics_DSoloCnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_DSoloCnt]  DEFAULT ((0)) FOR [DSoloCnt]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_DPartyCnt]') IS NULL
/****** Object:  Default [DF_UnitStatistics_DPartyCnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_DPartyCnt]  DEFAULT ((0)) FOR [DPartyCnt]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_VsWinCnt]') IS NULL
/****** Object:  Default [DF_UnitStatistics_VsWinCnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_VsWinCnt]  DEFAULT ((0)) FOR [VsWinCnt]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_VsLoseCnt]') IS NULL
/****** Object:  Default [DF_UnitStatistics_VsLoseCnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_VsLoseCnt]  DEFAULT ((0)) FOR [VsLoseCnt]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_DSWCnt]') IS NULL
/****** Object:  Default [DF_UnitStatistics_DSWCnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_DSWCnt]  DEFAULT ((0)) FOR [DSWCnt]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_DPWCnt]') IS NULL
/****** Object:  Default [DF_UnitStatistics_DPWCnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_DPWCnt]  DEFAULT ((0)) FOR [DPWCnt]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_PartyRate]') IS NULL
/****** Object:  Default [DF_UnitStatistics_PartyRate]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_PartyRate]  DEFAULT ((0.0)) FOR [PartyRate]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_Beginner]') IS NULL
/****** Object:  Default [DF_UnitStatistics_Beginner]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_Beginner]  DEFAULT ((0)) FOR [Beginner]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_VsPlayTime]') IS NULL
/****** Object:  Default [DF_UnitStatistics_VsPlayTime]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_VsPlayTime]  DEFAULT ((0)) FOR [VsPlayTime]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_DSPlayTime]') IS NULL
/****** Object:  Default [DF_UnitStatistics_DSPlayTime]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_DSPlayTime]  DEFAULT ((0)) FOR [DSPlayTime]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_DPPlayTime]') IS NULL
/****** Object:  Default [DF_UnitStatistics_DPPlayTime]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_DPPlayTime]  DEFAULT ((0)) FOR [DPPlayTime]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_DunAndVSPT]') IS NULL
/****** Object:  Default [DF_UnitStatistics_DunAndVSPT]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_DunAndVSPT]  DEFAULT ((0)) FOR [DunAndVSPT]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_TutoPlayTime]') IS NULL
/****** Object:  Default [DF_UnitStatistics_TutoPlayTime]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_TutoPlayTime]  DEFAULT ((0)) FOR [TutorialPT]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_TrainingPT]') IS NULL
/****** Object:  Default [DF_UnitStatistics_TrainingPT]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_TrainingPT]  DEFAULT ((0)) FOR [TrainingPT]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_TotalPlayTime]') IS NULL
/****** Object:  Default [DF_UnitStatistics_TotalPlayTime]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_TotalPlayTime]  DEFAULT ((0)) FOR [TotalPlayTime]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_VsRate]') IS NULL
/****** Object:  Default [DF_UnitStatistics_VsRate]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_VsRate]  DEFAULT ((0.0)) FOR [VsRate]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_DurationTime]') IS NULL
/****** Object:  Default [DF_UnitStatistics_DurationTime]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_DurationTime]  DEFAULT ((0)) FOR [DurationTime]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_BuyItem]') IS NULL
/****** Object:  Default [DF_UnitStatistics_BuyItem]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_BuyItem]  DEFAULT ((0)) FOR [BuyItem]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_SellItem]') IS NULL
/****** Object:  Default [DF_UnitStatistics_SellItem]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_SellItem]  DEFAULT ((0)) FOR [SellItem]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_GetItem]') IS NULL
/****** Object:  Default [DF_UnitStatistics_GetItem]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_GetItem]  DEFAULT ((0)) FOR [GetItem]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_P2PCnt]') IS NULL
/****** Object:  Default [DF_UnitStatistics_P2PCnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_P2PCnt]  DEFAULT ((0)) FOR [P2PCnt]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_P2PBuyItem]') IS NULL
/****** Object:  Default [DF_UnitStatistics_P2PBuyItem]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_P2PBuyItem]  DEFAULT ((0)) FOR [P2PBuyItem]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_P2PSellItem]') IS NULL
/****** Object:  Default [DF_UnitStatistics_P2PSellItem]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_P2PSellItem]  DEFAULT ((0)) FOR [P2PSellItem]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_Skill_Basic]') IS NULL
/****** Object:  Default [DF_UnitStatistics_Skill_Basic]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_Skill_Basic]  DEFAULT ((0)) FOR [Skill_Basic]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_Skill_1]') IS NULL
/****** Object:  Default [DF_UnitStatistics_Skill_1]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_Skill_1]  DEFAULT ((0)) FOR [Skill_1]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_Skill_2]') IS NULL
/****** Object:  Default [DF_UnitStatistics_Skill_2]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_Skill_2]  DEFAULT ((0)) FOR [Skill_2]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_NQuestAcc]') IS NULL
/****** Object:  Default [DF_UnitStatistics_NQuestAcc]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_NQuestAcc]  DEFAULT ((0)) FOR [NQuestAcc]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_NQuestGiveUp]') IS NULL
/****** Object:  Default [DF_UnitStatistics_NQuestGiveUp]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_NQuestGiveUp]  DEFAULT ((0)) FOR [NQuestGiveUp]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_NQuestComplete]') IS NULL
/****** Object:  Default [DF_UnitStatistics_NQuestComplete]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_NQuestComplete]  DEFAULT ((0)) FOR [NQuestComplete]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_RQuestAcc]') IS NULL
/****** Object:  Default [DF_UnitStatistics_RQuestAcc]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_RQuestAcc]  DEFAULT ((0)) FOR [RQuestAcc]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_RQuestGiveUp]') IS NULL
/****** Object:  Default [DF_UnitStatistics_RQuestGiveUp]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_RQuestGiveUp]  DEFAULT ((0)) FOR [RQuestGiveUp]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_RQuestComplete]') IS NULL
/****** Object:  Default [DF_UnitStatistics_RQuestComplete]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_RQuestComplete]  DEFAULT ((0)) FOR [RQuestComplete]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_EQuestAcc]') IS NULL
/****** Object:  Default [DF_UnitStatistics_EQuestAcc]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_EQuestAcc]  DEFAULT ((0)) FOR [EQuestAcc]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_EQuestGiveUp]') IS NULL
/****** Object:  Default [DF_UnitStatistics_EQuestGiveUp]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_EQuestGiveUp]  DEFAULT ((0)) FOR [EQuestGiveUp]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_EQuestComplete]') IS NULL
/****** Object:  Default [DF_UnitStatistics_EQuestComplete]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_EQuestComplete]  DEFAULT ((0)) FOR [EQuestComplete]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_QuestCnt]') IS NULL
/****** Object:  Default [DF_UnitStatistics_QuestCnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_QuestCnt]  DEFAULT ((0)) FOR [QuestCnt]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_ReQuestCnt]') IS NULL
/****** Object:  Default [DF_UnitStatistics_ReQuestCnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_ReQuestCnt]  DEFAULT ((0)) FOR [ReQuestCnt]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_SquareCnt]') IS NULL
/****** Object:  Default [DF_UnitStatistics_SquareCnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_SquareCnt]  DEFAULT ((0)) FOR [SquareCnt]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_SquarePlayTime]') IS NULL
/****** Object:  Default [DF_UnitStatistics_SquarePlayTime]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_SquarePlayTime]  DEFAULT ((0)) FOR [SquarePlayTime]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_PCBangCnt]') IS NULL
/****** Object:  Default [DF_UnitStatistics_PCBangCnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_PCBangCnt]  DEFAULT ((0)) FOR [PCBangCnt]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_PCBangDayCnt]') IS NULL
/****** Object:  Default [DF_UnitStatistics_PCBangDayCnt]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_PCBangDayCnt]  DEFAULT ((0)) FOR [PCBangDayCnt]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_PCBangFlag]') IS NULL
/****** Object:  Default [DF_UnitStatistics_PCBangFlag]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_PCBangFlag]  DEFAULT ((0)) FOR [PCBangFlag]
GO
IF OBJECT_ID(N'[dbo].[DF_UnitStatistics_MOpenCubeSpendED]') IS NULL
/****** Object:  Default [DF_UnitStatistics_MOpenCubeSpendED]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[UnitStatistics] ADD  CONSTRAINT [DF_UnitStatistics_MOpenCubeSpendED]  DEFAULT ((0)) FOR [MOpenCubeSpendED]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsEnchantLog_ServerSetID]') IS NULL
/****** Object:  Default [DF_StatsEnchantLog_ServerSetID]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsEnchantLog] ADD  CONSTRAINT [DF_StatsEnchantLog_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
IF OBJECT_ID(N'[dbo].[DF_StatsEnchantLog_RegDate]') IS NULL
/****** Object:  Default [DF_StatsEnchantLog_RegDate]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[StatsEnchantLog] ADD  CONSTRAINT [DF_StatsEnchantLog_RegDate]  DEFAULT (getdate()) FOR [RegDate]
GO
IF OBJECT_ID(N'[dbo].[DF_statsEnchantAid_ServerSetID]') IS NULL
/****** Object:  Default [DF_statsEnchantAid_ServerSetID]    Script Date: 01/25/2014 12:19:13 ******/
ALTER TABLE [dbo].[statsEnchantAid] ADD  CONSTRAINT [DF_statsEnchantAid_ServerSetID]  DEFAULT ((0)) FOR [ServerSetID]
GO
/*
	캐릭터별 칭호 로그 정보
	SeoJR
	12.11.28
	
	TODO:
	- 내용 확인 후 다시 작성
	
	참고:
	- 중국의 경우 @ServerSetID 값으로 DBName을 가져오지 않고 @UnitUID로 DBName을 조회함
*/
CREATE OR ALTER PROCEDURE [dbo].[P_Manager_Title_SEL]
	@ServerSetID	INT
,	@UnitUID		BIGINT

AS
SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

DECLARE @SQL			NVARCHAR(MAX)
,		@SQLWhere		NVARCHAR(100)
,		@SQLParam		NVARCHAR(MAX)
,		@DBName			NVARCHAR(50)

SET @DBName = dbo.F_Manager_DBName(@ServerSetID)

SET @SQLWhere = N'WHERE UnitUID = @UnitUID'

SET @SQLParam = '@UnitUID BIGINT, @DungeonID INT'
SET @SQL = N'
	'

EXEC sp_executesql @SQL, @SQLParam, @UnitUID
--PRINT @SQL
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_insert_Dungeon_Temp_Log]
	@iDungeonID			INT,
	@iUnitUID			BIGINT,
	@strNickName		NVARCHAR(20),
	@iUserUID			BIGINT,
	@iDiffculty			TINYINT,
	@bIsChallenge		BIT,
	@iUnitClass			TINYINT,
	@iClear				TINYINT,
	@iStartMember		TINYINT,
	@iEndMemeber		TINYINT,
	@iLV				TINYINT,
	@iPlayTime			INT,
	@iCombo				TINYINT,
	@iComboScore		INT,
	@iTechnical			TINYINT,
	@iTechnScore		INT,
	@iTime				TINYINT,
	@iDamage			TINYINT,
	@iRank				TINYINT,
	@iPassStage			TINYINT,
	@iPassSub			TINYINT,
	@iNormKill			SMALLINT,
	@iLoEliteKill		SMALLINT,
	@iHiEliteKill		SMALLINT,
	@iMidBossKill		SMALLINT,
	@iBossKill			SMALLINT,
	@iAttkedDam			INT,
	@iRecovHP			INT,
	@iBaseHP			INT,
	@iGivenDam			INT,
	@iPartyDam			INT,
	@iSkillUsed			SMALLINT,	
	@sdtRegDate			SMALLDATETIME,
	@bComeBackParty		BIT,
	@iOK				INT = 0
	
	
AS
SET NOCOUNT ON;

BEGIN TRAN
/*
	INSERT INTO dbo.LDungeonTempLog (DungeonID, UnitUID, NickName, UserUID, Difficulty, IsChallenge, UnitClass, [Clear], StartMember, EndMember, Lv, PlayTime,
								     Combo, ComboScore, Technical, TechnScore, [TIME], Damage, [RANK], PassStage, PassSub, NormKill, LoEliteKill, HiEliteKill,
								     MidBossKill, BossKill, AttkedDam, RecovHP, BaseHP, GivenDam, PartyDam, SkillUsed, RegDate, ComeBackParty)
	    SELECT @iDungeonID, @iUnitUID, @strNickName, @iUserUID, @iDiffculty, @bIsChallenge, @iUnitClass, @iClear, @iStartMember, @iEndMemeber, @iLV, @iPlayTime,
			   @iCombo, @iComboScore, @iTechnical, @iTechnScore, @iTime, @iDamage, @iRank, @iPassStage, @iPassSub, @iNormKill, @iLoEliteKill, @iHiEliteKill,
			   @iMidBossKill, @iBossKill, @iAttkedDam, @iRecovHP, @iBaseHP, @iGivenDam, @iPartyDam, @iSkillUsed, @sdtRegDate, @bComeBackParty
			   
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -112	GOTO FAIL_TRAN	END
*/
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_insert_dungeon_stage]
	@iDungeonID		INT
,	@iStageID		SMALLINT
,	@iUnitUID		BIGINT
,	@iLevel			TINYINT
,	@iDifficulty	TINYINT
,	@iIsChallenge	TINYINT
,	@iUnitClass		TINYINT
,	@iPlayTime		INT
,	@iDamage		INT
,	@iResCount		SMALLINT
,	@sdtRegDate		SMALLDATETIME
,	@iOK			INT = 0

AS
SET NOCOUNT ON;

BEGIN TRAN
/*
	INSERT INTO dbo.LDungeonStageLog (DungeonID, StageID, UnitUID, [Level], Difficulty, IsChallenge, UnitClass, PlayTime,Damage, ResCount, RegDate)
	    SELECT @iDungeonID, @iStageID, @iUnitUID, @iLevel, @iDifficulty, @iIsChallenge, @iUnitClass, @iPlayTime, @iDamage, @iResCount, @sdtRegDate		
			   
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END
*/
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LDungeonTempLog_INS]
	@iServerSetID		TINYINT,
	@iDungeonID			INT,
	@iUnitUID			BIGINT,
	@strNickName		NVARCHAR(20),
	@iUserUID			BIGINT,
	@iDiffculty			TINYINT,
	@bIsChallenge		BIT,
	@iUnitClass			TINYINT,
	@iClear				TINYINT,
	@iStartMember		TINYINT,
	@iEndMemeber		TINYINT,
	@iLV				TINYINT,
	@iPlayTime			INT,
	@iCombo				TINYINT,
	@iComboScore		INT,
	@iTechnical			TINYINT,
	@iTechnScore		INT,
	@iTime				TINYINT,
	@iDamage			TINYINT,
	@iRank				TINYINT,
	@iPassStage			TINYINT,
	@iPassSub			TINYINT,
	@iNormKill			SMALLINT,
	@iLoEliteKill		SMALLINT,
	@iHiEliteKill		SMALLINT,
	@iMidBossKill		SMALLINT,
	@iBossKill			SMALLINT,
	@iAttkedDam			INT,
	@iRecovHP			INT,
	@iBaseHP			INT,
	@iGivenDam			INT,
	@iPartyDam			INT,
	@iSkillUsed			SMALLINT,	
	@sdtRegDate			SMALLDATETIME,
	@bComeBackParty		BIT,
	@iOK				INT = 0
	
	
AS
SET NOCOUNT ON;

BEGIN TRAN
/*
	INSERT INTO dbo.LDungeonTempLog (DungeonID, UnitUID, NickName, UserUID, Difficulty, IsChallenge, UnitClass, [Clear], StartMember, EndMember, Lv, PlayTime,
								     Combo, ComboScore, Technical, TechnScore, [TIME], Damage, [RANK], PassStage, PassSub, NormKill, LoEliteKill, HiEliteKill,
								     MidBossKill, BossKill, AttkedDam, RecovHP, BaseHP, GivenDam, PartyDam, SkillUsed, RegDate, ComeBackParty)
	    SELECT @iDungeonID, @iUnitUID, @strNickName, @iUserUID, @iDiffculty, @bIsChallenge, @iUnitClass, @iClear, @iStartMember, @iEndMemeber, @iLV, @iPlayTime,
			   @iCombo, @iComboScore, @iTechnical, @iTechnScore, @iTime, @iDamage, @iRank, @iPassStage, @iPassSub, @iNormKill, @iLoEliteKill, @iHiEliteKill,
			   @iMidBossKill, @iBossKill, @iAttkedDam, @iRecovHP, @iBaseHP, @iGivenDam, @iPartyDam, @iSkillUsed, @sdtRegDate, @bComeBackParty
			   
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -112	GOTO FAIL_TRAN	END
*/
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LDungeonStageLog_INS]
	@iServerSetID		TINYINT
,	@iDungeonID		INT
,	@iStageID		SMALLINT
,	@iUnitUID		BIGINT
,	@iLevel			TINYINT
,	@iDifficulty	TINYINT
,	@iIsChallenge	TINYINT
,	@iUnitClass		TINYINT
,	@iPlayTime		INT
,	@iDamage		INT
,	@iResCount		SMALLINT
,	@sdtRegDate		SMALLDATETIME
,	@iOK			INT = 0

AS
SET NOCOUNT ON;

BEGIN TRAN
/*
	INSERT INTO dbo.LDungeonStageLog (DungeonID, StageID, UnitUID, [Level], Difficulty, IsChallenge, UnitClass, PlayTime,Damage, ResCount, RegDate)
	    SELECT @iDungeonID, @iStageID, @iUnitUID, @iLevel, @iDifficulty, @iIsChallenge, @iUnitClass, @iPlayTime, @iDamage, @iResCount, @sdtRegDate		
			   
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END
*/
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
/* 
기능: 매분 게임서버 동접수를 모두 합한 전체 동접을 계산해 기록한다.

*/

CREATE OR ALTER PROCEDURE [dbo].[lup_insert_ccu_minute]
    @sdtRegDate			[SMALLDATETIME]
,	@iServerUID			[INT]
,	@iConcurrentUser	[INT]

AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

/*
INSERT INTO dbo.StatCCUMinute( RegDate, ServerUID, CCU )
	SELECT @sdtRegDate, @iServerUID, @iConcurrentUser
*/
GO
/* 
	체험 아이디 사용자들의 동접 기록
	2008.05.27 
	sutamtwo
*/

CREATE OR ALTER PROCEDURE [dbo].[lup_update_concurrent_guestuser]
    @sdtRegDate_ [smalldatetime],
	@iUID_ [int],
	@iConcurrentUser_ [int]
AS
SET NOCOUNT ON;


    INSERT INTO dbo.StatCCUMinuteGuestUser( RegDate, ServerUID, CCU ) 
		select @sdtRegDate_, @iUID_, @iConcurrentUser_
GO
-- =============================================
-- Author:		sutamtwo
-- Create date: 2008.05.27 
-- Description: 체험 아이디 사용자들의 동접 기록
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_StatCCUMinuteGuestUser_INS]
	@iServerSetID	TINYINT	,
    @sdtRegDate_ [smalldatetime],
	@iUID_ [int],
	@iConcurrentUser_ [int]
AS
SET NOCOUNT ON;


    INSERT INTO dbo.StatCCUMinuteGuestUser( RegDate, ServerUID, CCU ) 
		select @sdtRegDate_, @iUID_, @iConcurrentUser_
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 생성했던 캐릭터를 삭제한다.
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_ChatLog_INS]
	@iServerSetID	TINYINT,
    @iRoomUID_       bigint,
    @iCharUID_       bigint,
    @iUserUID_       bigint,
    @iChatType_      tinyint,
    @strMsg_        nvarchar(64)
AS

SET NOCOUNT ON;


DECLARE @strQuery nvarchar(1024),
        @strTableName nvarchar(32)

-- 데이터를 추가할 테이블 이름을 생성.
SET @strTableName = 'Chat_' + CONVERT( nvarchar(24), GetDate(), 12 )

-- 해당 이름을 가진 테이블이 존재하는지 조회하고, 없다면 생성.
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID( @strTableName ) AND type in (N'U'))
BEGIN
    SET @strQuery = 'CREATE TABLE dbo.' + @strTableName + '(
	    [RoomUID] [bigint] NOT NULL,
	    [CharUID] [bigint] NOT NULL,
	    [UserUID] [bigint] NOT NULL,
	    [ChatType] [tinyint] NOT NULL,
	    [Msg] [nvarchar](64) COLLATE Korean_Wansung_CI_AS NOT NULL,
	    [RegDate] [datetime] NOT NULL
    ) ON [PRIMARY]'

    EXEC dbo.sp_executesql @strQuery
END


BEGIN TRAN
    -- 실제 데이터 추가
    SET @strQuery = 'INSERT INTO ' + @strTableName + '(RoomUID, CharUID, UserUID, ChatType, Msg, RegDate) ' +
        'VALUES( @RoomUID, @CharUID, @UserUID, @ChatType, @strMsg, GetDate() )'

    EXEC dbo.sp_executesql @strQuery,
        N'@RoomUID bigint, @CharUID bigint, @UserUID bigint, @chatType tinyint, @strMsg nvarchar(64)',
        @iRoomUID_, @iCharUID_, @iUserUID_, @iChatType_, @strMsg_

    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
    BEGIN
        GOTO FAIL_TRAN
    END
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:

RETURN
GO
/* 
기능: 생성했던 캐릭터를 삭제한다.
In: iRoomUID, iCharUID, iUserUID, iChatType, strMsg
Out: x

- Working example:
Exec lup_insert_chat_log 1, 2, 3, 4, N'야호'

*/

CREATE OR ALTER PROCEDURE [dbo].[lup_insert_chat_log]
    @iRoomUID_       bigint,
    @iCharUID_       bigint,
    @iUserUID_       bigint,
    @iChatType_      tinyint,
    @strMsg_        nvarchar(64)
AS

SET NOCOUNT ON;


DECLARE @strQuery nvarchar(1024),
        @strTableName nvarchar(32)

-- 데이터를 추가할 테이블 이름을 생성.
SET @strTableName = 'Chat_' + CONVERT( nvarchar(24), GetDate(), 12 )

-- 해당 이름을 가진 테이블이 존재하는지 조회하고, 없다면 생성.
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID( @strTableName ) AND type in (N'U'))
BEGIN
    SET @strQuery = 'CREATE TABLE dbo.' + @strTableName + '(
	    [RoomUID] [bigint] NOT NULL,
	    [CharUID] [bigint] NOT NULL,
	    [UserUID] [bigint] NOT NULL,
	    [ChatType] [tinyint] NOT NULL,
	    [Msg] [nvarchar](64) COLLATE Korean_Wansung_CI_AS NOT NULL,
	    [RegDate] [datetime] NOT NULL
    ) ON [PRIMARY]'

    EXEC dbo.sp_executesql @strQuery
END


BEGIN TRAN
    -- 실제 데이터 추가
    SET @strQuery = 'INSERT INTO ' + @strTableName + '(RoomUID, CharUID, UserUID, ChatType, Msg, RegDate) ' +
        'VALUES( @RoomUID, @CharUID, @UserUID, @ChatType, @strMsg, GetDate() )'

    EXEC dbo.sp_executesql @strQuery,
        N'@RoomUID bigint, @CharUID bigint, @UserUID bigint, @chatType tinyint, @strMsg nvarchar(64)',
        @iRoomUID_, @iCharUID_, @iUserUID_, @iChatType_, @strMsg_

    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
    BEGIN
        GOTO FAIL_TRAN
    END
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:

RETURN
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_insert_character_Log]
	@sdtRegDate		SMALLDATETIME,
	@iUnitUID		BIGINT,
	@strNickName	NVARCHAR(16),
	@bOnlyOne		BIT,
	@iServerUID		INT,
	@iEventType		SMALLINT,
	@iLV			TINYINT,
	@iUnitClass		TINYINT,
	@iClearDungeon	INT,
	@iDungeon_PT	INT,
	@iPVP_PT		INT,
	@iDT			INT,
	@iUserUID		BIGINT,
	@sdtUnitRegdate SMALLDATETIME,
	@sdtUserRegdate	SMALLDATETIME,
	@iProductNo		INT,
	@iOK			INT = 0
	
AS
SET NOCOUNT ON;

BEGIN TRAN

	INSERT INTO dbo.LCharacterLog (RegDate, UnitUID, NickName, OnlyOne, ServerUID, EventType, LV, UnitClass, ClearDungeon, 
				Dungeon_PT, PVP_PT, DT, UserUID, UnitRegDate, UserRegDate, ProductNo)
	    SELECT @sdtRegDate, @iUnitUID, @strNickName, @bOnlyOne, @iServerUID, @iEventType, @iLV, @iUnitClass, @iClearDungeon, 
				@iDungeon_PT, @iPVP_PT, @iDT, @iUserUID, @sdtUnitRegdate, @sdtUserRegdate, @iProductNo
			   
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -100	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[StatsDungeonUpdate]
	@iUnitUID		[bigint]
,	@iDungeonID		[int]
,	@iSW_Cnt		[tinyint]
,	@iSL_Cnt		[tinyint]
,	@iSG_Cnt		[tinyint]
,	@iSRS_Cnt		[smallint]
,	@iPW_Cnt		[tinyint]
,	@iPL_Cnt		[tinyint]
,	@iPG_Cnt		[tinyint]
,	@iPRS_Cnt		[smallint]
,	@iSW_Time		[smallint]	
,	@iSL_Time		[smallint]
,	@iSG_Time		[smallint]
,	@iPW_Time		[smallint]
,	@iPL_Time		[smallint]
,	@iPG_Time		[smallint]
,	@iOK_			[int] = 0


AS
/* 
sutamtwo
작성일 : 2007년 10월 24일
사용 : 던전별 Mode Count 및 Play Time 기록
*/
SET NOCOUNT ON;
SET XACT_ABORT ON;

IF NOT EXISTS(select * from [game01].dbo.GUnit with (nolock) where unituid = @iUnitUID)
	-- 해당 유닛 없음
	BEGIN    SELECT @iOK_ = -1     GOTO END_PROC    END

BEGIN TRAN
	IF NOT EXISTS(SELECT * FROM dbo.StatsDungeon WITH (NOLOCK) WHERE Unituid = @iUnitUID and DungeonID = @iDungeonID)
		BEGIN
			DECLARE @iUnitClass	tinyint
			SELECT	@iUnitClass = UnitClass FROM [Game01].[dbo].[GUnit] WITH (NOLOCK) WHERE  UnitUID = @iUnitUID 

			INSERT INTO dbo.StatsDungeon (UnitUID, DungeonID, UnitClass)
				SELECT @iUnitUID, @iDungeonID, @iUnitClass
				IF @@ERROR <> 0
					BEGIN	SELECT @iOK_ = -101	GOTO FAIL_TRAN	END
		END
	
	UPDATE dbo.StatsDungeon WITH (UPDLOCK)
		SET	SW_Cnt  = SW_Cnt  + @iSW_Cnt 	      
,			SL_Cnt  = SL_Cnt  + @iSL_Cnt 	      
,			SG_Cnt  = SG_Cnt  + @iSG_Cnt 	      
,			SRS_Cnt = SRS_Cnt + @iSRS_Cnt 
,			PW_Cnt  = PW_Cnt  + @iPW_Cnt 	      
,			PL_Cnt  = PL_Cnt  + @iPL_Cnt  	      
,			PG_Cnt  = PG_Cnt  + @iPG_Cnt 	      
,			PRS_Cnt = PRS_Cnt + @iPRS_Cnt
,			SW_Time = SW_Time + @iSW_Time
,			SL_Time = SL_Time + @iSL_Time
,			SG_Time = SG_Time + @iSG_Time
,			PW_Time = PW_Time + @iPW_Time
,			PL_Time = PL_Time + @iPL_Time
,			PG_Time = PG_Time + @iPG_Time
		WHERE Unituid = @iUnitUID and DungeonID = @iDungeonID

	IF @@ERROR <> 0
		BEGIN	SELECT @iOK_ = -102	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK_, @iUnitUID
GO
/*
프로시저명 : dbo.SYS_SP_ErrorLog_INT
내용 : DB 오류 기록
작성일 : 2011-02-11
작성자 : 김병일
-- ## 관련 테이블 ##--
	dbo.SYS_SP_ErrorLog
-- ## 관련 프로시저 ## --
	없음
-- ## 입력 ## --
	@NO_XACT_STATE		smallint					-- 트랜잭션 상태 정보
-- ## 출력 ## --
	Output : 없음
	ReturnValue : 없음
	RecodeSet : 없음
-- ## 예제 ## --
	IF OBJECT_ID('_TestTable') IS NOT NULL
		DROP TABLE dbo.[_TestTable]

	CREATE TABLE dbo.[_TestTable] (
		col1			int
	)

	SELECT * FROM dbo.[_TestTable]

	BEGIN TRY
		BEGIN TRAN

		INSERT INTO dbo.[_TestTable]
		VALUES (1/0)

		COMMIT TRAN AL
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE
	END CATCH

	SELECT * FROM dbo.[_TestTable]
	SELECT * FROM dbo.SYS_SP_ErrorLog
*/
CREATE OR ALTER PROCEDURE [dbo].[SYS_SP_ErrorLog_INT]
	@NO_XACT_STATE		smallint ,					-- 트랜잭션 상태 정보
	@ST_SYSTEM_USER		nvarchar(128) = NULL		-- 사용자 계정(DB 접속 계정)
AS
	SET NOCOUNT ON

	-- 변수 선언
	DECLARE	@NO_ERROR_LINE		int,
		@ST_ERROR_MESSAGE		nvarchar(2048),
		@ST_ERROR_PROCEDURE		nvarchar(126),
		@NO_ERROR_NUMBER		int,
		@NO_ERROR_SEVERITY		int,
		@NO_ERROR_STATE			int

	-- 변수 값 입력
	SET @NO_ERROR_LINE			= ERROR_LINE()		-- 오류 발생 줄
	SET @ST_ERROR_MESSAGE		= ERROR_MESSAGE()	-- 오류 메시지
	SET @ST_ERROR_PROCEDURE		= ERROR_PROCEDURE()	-- 오류 프로시저명
	SET @NO_ERROR_NUMBER		= ERROR_NUMBER()	-- 오류 번호
	SET @NO_ERROR_SEVERITY		= ERROR_SEVERITY()	-- 오류 심각도
	SET @NO_ERROR_STATE			= ERROR_STATE()		-- 오류 상태 번호

	IF @ST_SYSTEM_USER IS NULL
		SET @ST_SYSTEM_USER = SYSTEM_USER

	BEGIN TRY
		-- 저장
		INSERT INTO dbo.SYS_SP_ErrorLog ( NO_ERROR_LINE, ST_ERROR_MESSAGE, NO_ERROR_NUMBER, ST_ERROR_PROCEDURE, NO_ERROR_SEVERITY, NO_ERROR_STATE, NO_XACT_STATE, ST_SYSTEM_USER, DT_ERROR_DATE )
		VALUES ( @NO_ERROR_LINE, @ST_ERROR_MESSAGE, @NO_ERROR_NUMBER, @ST_ERROR_PROCEDURE, @NO_ERROR_SEVERITY, @NO_ERROR_STATE, @NO_XACT_STATE, @ST_SYSTEM_USER, GETDATE() )
	END TRY
	BEGIN CATCH
		-- 저장 실패시 오류 로그에 기록
		RAISERROR(N'Procedure error [SP-%s][NUM-%d][MSG-%s][LINE-%d][USER-%s]', 16, @NO_ERROR_STATE, @ST_ERROR_PROCEDURE, @NO_ERROR_NUMBER, @ST_ERROR_MESSAGE, @NO_ERROR_LINE, @ST_SYSTEM_USER) WITH LOG
	END CATCH
GO
CREATE OR ALTER PROCEDURE [dbo].[StatsUpdateDelUnit]
	@iUnitUID	bigint
,	@iOK		int = 0

AS
SET NOCOUNT ON;

IF NOT EXISTS (SELECT * FROM dbo.UnitStatistics WITH (NOLOCK) WHERE UNITUID = @iUnitUID)
	BEGIN
		SELECT @iOK = -2	GOTO END_PROC
	END


BEGIN TRAN

	UPDATE dbo.UnitStatistics
		SET deleted = 1
			WHERE unituid = @iUnitUID

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
    BEGIN    
        SELECT @iOK = -1 
        GOTO FAIL_TRAN    
    END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[StatsUnitUpdate_Once]
	@iUnitUID  [bigint]
,	@iOK_   [int] = 0
AS
/*
	sutamtwo 
	작성일 : 2007년 10월 29일
	사용 : UnitStatistics 정보 갱신

	수정일 : 2009년 03월 12일
	수정자 : microcat
	내용 : DeadLock (혹은 Block)으로 인한 Index (UserUID에 Non-Clustered) 생성, Transaction 밖으로 Declare 및 Select 문 빼기

*/
SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE @iUserUID  bigint
,		@sdtLastDate smalldatetime
,		@iPlayDayCnt smallint
,		@iLoginCount int
,		@bDeleted  bit
,		@iLevel   tinyint
,		@iExp   int
,		@iGamepoint  int
,		@iVsPoint  int
,		@iVsPointMax int
,		@iSPoint  smallint
,		@iCharNo  tinyint
,		@iVsCnt   int
,		@iDSoloCnt  int
,		@iDPartyCnt  int
,		@iVsWinCnt  int
,		@iVsLoseCnt  int
,		@iVsDrawCnt  int 
,		@iDSoloWinCnt int
,		@iDPartyWinCnt int
,		@iVSPlayTime int
,		@iDSoloPlayTime int
,		@iDPartyPlayTime int
,		@iVsRank  bigint
,		@iExpRank  bigint
,		@iSkill_Cnt  tinyint
,		@iQuest_Cnt  tinyint
,		@iQuest_Re_Cnt tinyint
,		@iTutoWin_Cnt smallint
,		@iTraWin_Cnt smallint
,		@iTutoPlayTime int
,		@iTrainingPT int
,		@iBestUnitUID int



 -- GUnit에 존재한다면,
IF EXISTS (SELECT * FROM [Game01].[dbo].[GUnit] WITH (NOLOCK) WHERE UnitUid = @iUnitUID)
BEGIN 
	SELECT @iUserUID = UserUID FROM [Game01].[dbo].[GUnit] WITH (NOLOCK) WHERE UnitUid = @iUnitUID
   
   -- 튜토리얼 Play Time 구하기
	SELECT @iTutoPlayTime = (SUM(SW_TIME) + SUM(SL_TIME) + SUM(SG_TIME))
		FROM dbo.StatsDungeon WITH (NOLOCK)
			WHERE UnitUID = @iUnitUID
				AND DungeonID IN (30030,30031,30032,30033,30034)
  
   -- 훈련소 Play Time 구하기
	SELECT @iTrainingPT = SUM(Win_Time + Lose_Time + GiveUp_Time)
		FROM dbo.StatsTraining WITH (NOLOCK)
			WHERE Unituid = @iUnitUID


   -- 대전 관련 정보 수집
	SELECT	@iVsCnt = ISNULL((TMW_CNT+TML_CNT+TMG_CNT+TMD_CNT+TDW_CNT+TDL_CNT+TDNAN_CNT+TDG_CNT+TDD_CNT+DW_CNT+DL_CNT+DG_CNT+DNAN_CNT+DD_CNT),0)
,			@iVsWinCnt = ISNULL((TMW_CNT+TDW_CNT+DW_CNT),0)
,			@iVsLoseCnt = ISNULL((TML_CNT+TDL_CNT+DL_CNT),0) 
,			@iVsDrawCnt = ISNULL((TMD_CNT+TDD_CNT+DD_CNT),0)      
,			@iVSPlayTime = ISNULL((TMW_TIME + TML_TIME + TMG_TIME + TMD_TIME + TDW_TIME + TDL_TIME + TDG_TIME + TDD_TIME + DW_TIME + DL_TIME + DG_TIME + DD_TIME ),0)
		FROM dbo.StatsVs WITH (NOLOCK) 
			WHERE unituid = @iUnitUID

   -- 던전 관련 정보 수집
   SELECT	@iDSoloCnt = (SUM(SW_CNT) + SUM(SL_CNT) + SUM(SG_CNT))  
,			@iDPartyCnt = (SUM(PW_CNT) + SUM(PL_CNT) + SUM(PG_CNT)) 
,			@iDSoloWinCnt = SUM(SW_CNT)
,			@iDPartyWinCnt = SUM(PW_CNT) 
,			@iDSoloPlayTime = (SUM(SW_TIME) + SUM(SL_TIME) + SUM(SG_TIME))
,			@iDPartyPlayTime = (SUM(PW_TIME) + SUM(PL_TIME) + SUM(PG_TIME))
	FROM dbo.StatsDungeon WITH (NOLOCK)
		WHERE UnitUID = @iUnitUID
			AND DungeonID IN (30030,30031,30032,30033,30034)

   -- 스킬, 퀘스트 정보 수집
   SELECT @iSkill_Cnt = COUNT(*) FROM [Game01].[dbo].[GSkill] WITH (NOLOCK) WHERE UnitUID = @iUnitUID
   SELECT @iQuest_Cnt = COUNT(*) FROM [Game01].[dbo].[GQuests_Complete] WITH (NOLOCK) WHERE UnitUID = @iUnitUID
   SELECT @iQuest_Re_Cnt = COUNT(*) FROM [Game01].[dbo].[GQuests_Repeat] WITH (NOLOCK) WHERE UnitUID = @iUnitUID
   
   -- 초보 적응도 파악 (튜토리얼 + 훈련소 승 수)
   SELECT @iTraWin_Cnt = ISNULL(SUM(WIN_CNT),0) FROM dbo.StatsTraining WITH (NOLOCK) WHERE UNITUID = @iUnitUID
   SELECT @iTutoWin_Cnt = ISNULL(SW_CNT,0) FROM DBO.STATSDUNGEON WITH (NOLOCK) WHERE UNITUID = @iUnitUID AND DUNGEONID IN (30030,30031,30032,30033,30034)

   -- 캐릭터 수 파악
   SELECT @iCharNo = COUNT(Deleted) FROM [Game01].[dbo].[GUnit] WITH (NOLOCK) WHERE UserUID = @iUserUID and Deleted = 0

   -- 랭킹 정보 수집
   SELECT @iVsRank = VsRank, @iExpRank = ExpRank FROM dbo.Rank_ WITH (NOLOCK) WHERE unitUID = @iUnitUID

   -- GUnit에서 조회할 수 있는 기본정보 조회
   SELECT	@sdtLastDate = lastdate
,			@iPlayDayCnt = playdaycnt
,			@iLoginCount = logincount
,			@bDeleted = deleted
,			@iLevel = [level]
,			@iExp = [exp]
,			@iGamepoint = gamepoint
--,			@iVsPoint = vspoint
--,			@iVsPointMax = vspointmax
,			@iSPoint = spoint
	FROM [Game01].[dbo].[GUnit] WITH (NOLOCK)
		WHERE unituid = @iUnitUID



END
-- GUnit에 존재한다면

IF NOT EXISTS (SELECT * From dbo.UnitStatistics WITH (NOLOCK) WHERE UnitUID = @iUnitUID)
BEGIN
	BEGIN TRANSACTION
		INSERT INTO dbo.UnitStatistics WITH (UPDLOCK) (UnitUID,	UserUID, Age, Gender, RegDate, UnitClass)
			SELECT a.UnitUID, a.UserUID, b.Age,	b.Gender, a.RegDate, a.UnitClass
				FROM (SELECT UnitUID, UserUID, RegDate,	UnitClass FROM [Game01].[dbo].[GUnit] WITH (UPDLOCK) WHERE UnitUID = @iUnitUID) AS A
			JOIN 
				(
					SELECT UserUID,	Age, Gender	FROM [Account].[dbo].[MUser] WITH (UPDLOCK) WHERE UserUID = @iUserUID
				) AS B
			ON
			a.UserUID = b.UserUID

	IF @@ERROR <> 0
		BEGIN	SELECT @iOK_ = -101	GOTO FAIL_TRAN	END

	COMMIT TRANSACTION
END


SELECT TOP 1
	@iBestUnitUID = UnitUID
	FROM dbo.UnitStatistics WITH (NOLOCK)
		WHERE UserUID = @iUserUID AND Deleted = 0
			ORDER BY [Exp] DESC

BEGIN TRANSACTION
   
	UPDATE a WITH (UPDLOCK)
	SET lastdate = @sdtLastDate 
	,	playdaycnt = @iPlayDayCnt 
	,   logincount = @iLoginCount 
	,   deleted = @bDeleted 
	,   [level] = @iLevel 
	,   [exp] = @iExp  
	,   gamepoint = @iGamepoint 
	,   vspoint = @iVsPoint 
	,   vspointmax = @iVsPointMax 
	,   spoint = @iSPoint 
	,   charNo = @iCharNo
	,   vsRank = @iVsRank
	,   ExpRank = @iExpRank
	,   VsCnt = ISNULL(@iVsCnt,0)
	,   VsWinCnt = ISNULL(@iVsWinCnt,0)
	,   VsLoseCnt = ISNULL(@iVsLoseCnt,0)
	,   VSPlayTime = ISNULL(@iVSPlayTime,0)
	,   DSoloCnt = ISNULL(@iDSoloCnt,0)
	,   DPartyCnt = ISNULL(@iDPartyCnt,0)
	,   DSWCnt = ISNULL(@iDSoloWinCnt,0)
	,   DPWCnt = ISNULL(@iDPartyWinCnt,0)      
	,   DSPlayTime = ISNULL(@iDSoloPlayTime ,0)    
	,   DPPlayTime = ISNULL(@iDPartyPlayTime ,0)
	,   DunAndVSPT = ISNULL((@iDSoloPlayTime + @iDPartyPlayTime + @iVSPlayTime),0)
	,   TutorialPT = ISNULL(@iTutoPlayTime, 0)
	,   TrainingPT = ISNULL(@iTrainingPT, 0)
	,   TotalPlayTime = ISNULL((@iVSPlayTime + @iDSoloPlayTime + @iDPartyPlayTime + @iTutoPlayTime + TrainingPT),0)
	,   Skill_Basic = @iSkill_Cnt
	,   QuestCnt = @iQuest_Cnt
	,   ReQuestCnt = @iQuest_Re_Cnt
	,   Beginner = ISNULL(@iTraWin_Cnt + @iTutoWin_Cnt , 0)
	,   PCBangFlag = 0
	,	VsRate = case when @iVSPlayTime > 0 then ISNULL(CONVERT(Float, @iVSPlayTime)/(@iVSPlayTime + @iDSoloPlayTime + @iDPartyPlayTime) * 100,0) else VsRate end
	,	PartyRate = case when @iDPartyCnt > 0 then ISNULL(CONVERT(Float, @iDPartyCnt)/(@iDSoloCnt + @iDPartyCnt) * 100,0) else PartyRate end
	FROM dbo.UnitStatistics AS A WITH (UPDLOCK)
	WHERE unitUID = @iUnitUID

IF @@ERROR <> 0
	BEGIN    SELECT @iOK_ = -102    GOTO FAIL_TRAN    END


--	대표 캐릭터 업데이트
UPDATE a WITH (UPDLOCK)
	SET IsFirst = CASE UnitUID WHEN @iBestUnitUID THEN 1 ELSE 0 END
		FROM dbo.UnitStatistics AS A WITH (UPDLOCK)
			WHERE UserUID = @iUserUID

COMMIT TRANSACTION

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK_
GO
CREATE OR ALTER PROCEDURE [dbo].[StatsTrainingUpdate]
	@iUnitUID		[bigint]
,	@iTrainingID	[smallint]
,	@iWin_Cnt		[int]
,	@iLose_Cnt		[int]
,	@iGiveUp_Cnt	[int]
,	@iWin_Time		[bigint]
,	@iLose_Time		[bigint]
,	@iGiveUp_Time	[bigint]
,	@iOK_			[int] = 0

AS
/* 
sutamtwo
작성일 : 2007년 10월 24일
사용 : 훈련소 Mode Count 및 Play Time 기록
*/
SET NOCOUNT ON;
SET XACT_ABORT ON;

IF NOT EXISTS(select * from [game01].dbo.GUnit with (nolock) where unituid = @iUnitUID)
	-- 해당 유닛 없음
	BEGIN    SELECT @iOK_ = -1     GOTO END_PROC    END

BEGIN TRAN
	IF NOT EXISTS(SELECT * FROM dbo.StatsTraining WITH (NOLOCK) WHERE Unituid = @iUnitUID and TrainingID = @iTrainingID)
		BEGIN
			INSERT INTO dbo.StatsTraining (UnitUID, TrainingID)
				SELECT @iUnitUID, @iTrainingID
				IF @@ERROR <> 0
					BEGIN	SELECT @iOK_ = -101	GOTO FAIL_TRAN	END
		END

	UPDATE dbo.StatsTraining WITH (UPDLOCK)
		SET	Win_Cnt	    = Win_Cnt	  + @iWin_Cnt	     
,			Lose_Cnt    = Lose_Cnt    + @iLose_Cnt     	  
,			GiveUp_Cnt  = GiveUp_Cnt  + @iGiveUp_Cnt  	
,			Win_Time    = Win_Time    + @iWin_Time      	
,			Lose_Time   = Lose_Time   + @iLose_Time         	
,			GiveUp_Time = GiveUp_Time + @iGiveUp_Time     	
		WHERE Unituid = @iUnitUID and TrainingID = @iTrainingID

	IF @@ERROR <> 0
		BEGIN	SELECT @iOK_ = -102	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK_, @iUnitUID
GO
CREATE OR ALTER PROCEDURE [dbo].[StatsVsUpdate]
	@iUnitUID		[bigint]
,	@iTMW_Cnt		[smallint]
,	@iTML_Cnt		[smallint]
,	@iTMG_Cnt		[smallint]
,	@iTMD_Cnt		[smallint]
,	@iTDW_Cnt		[smallint]
,	@iTDL_Cnt		[smallint]
,	@iTDG_Cnt		[smallint]
,	@iTDD_Cnt		[smallint]
,	@iTDNan_Cnt		[smallint]
,	@iDW_Cnt		[smallint]
,	@iDL_Cnt		[smallint]
,	@iDG_Cnt		[smallint]
,	@iDD_Cnt		[smallint]
,	@iDNan_Cnt		[smallint]
,	@iTMW_Time		[int]
,	@iTML_Time		[int]
,	@iTMG_Time		[int]
,	@iTMD_Time		[int]
,	@iTDW_Time		[int]
,	@iTDL_Time		[int]
,	@iTDG_Time		[int]
,	@iTDD_Time		[int]
,	@iTDNan_Time	[int]
,	@iDW_Time		[int]
,	@iDL_Time		[int]
,	@iDG_Time		[int]
,	@iDD_Time		[int]
,	@iDNan_Time		[int]
,	@iOK_			[int] = 0
AS
/* 
sutamtwo
작성일 : 2007년 10월 25일
사용 : 대전 모드 카운트 및 대전 플레이 타임 업데이트
*/
SET NOCOUNT ON;
SET XACT_ABORT ON;

IF NOT EXISTS(SELECT * FROM [GAME01].dbo.GUnit WITH (NOLOCK) WHERE unituid = @iUnitUID)
	-- 해당 유닛 존재하지 않음
	BEGIN    SELECT @iOK_ = -1     GOTO END_PROC    END

BEGIN TRAN
	-- 해당 유닛은 존재하지만 기존 데이터가 없으면 insert
	IF NOT EXISTS(SELECT * FROM dbo.StatsVs WITH (NOLOCK) WHERE Unituid = @iUnitUID)
		BEGIN
			INSERT INTO dbo.StatsVs (UnitUID)
				SELECT @iUnitUID
				IF @@ERROR <> 0
					BEGIN	SELECT @iOK_ = -101	GOTO FAIL_TRAN	END
		END

	-- 대전 모드 카운트 업데이트
	UPDATE dbo.StatsVs WITH (UPDLOCK)
			SET	TMW_Cnt	    = TMW_Cnt	+ @iTMW_Cnt	            	
,				TML_Cnt	    = TML_Cnt	+ @iTML_Cnt	         	
,				TMG_Cnt	    = TMG_Cnt	+ @iTMG_Cnt	 
,				TMD_Cnt		= TMD_Cnt	+ @iTMD_Cnt          	
,				TDW_Cnt	    = TDW_Cnt	+ @iTDW_Cnt	         	
,				TDL_Cnt	    = TDL_Cnt	+ @iTDL_Cnt	       	
,				TDNan_Cnt   = TDNan_Cnt + @iTDNan_Cnt 	
,				TDG_Cnt	    = TDG_Cnt	+ @iTDG_Cnt	      	
,				TDD_Cnt		= TDD_Cnt	+ @iTDD_Cnt
,				DW_Cnt	    = DW_Cnt	+ @iDW_Cnt	        	
,				DL_Cnt	    = DL_Cnt	+ @iDL_Cnt	         	
,				DG_Cnt	    = DG_Cnt	+ @iDG_Cnt	          	
,				DNan_Cnt    = DNan_Cnt  + @iDNan_Cnt      	
,				DD_Cnt		= DD_Cnt	+ @iDD_Cnt	
,				TMW_Time    = TMW_Time  + @iTMW_Time     	
,				TML_Time    = TML_Time  + @iTML_Time       	
,				TMG_Time    = TMG_Time  + @iTMG_Time     	
,				TMD_Time    = TMD_Time  + @iTMD_Time     	
,				TDW_Time    = TDW_Time  + @iTDW_Time     	
,				TDL_Time    = TDL_Time  + @iTDL_Time   	
,				TDG_Time    = TDG_Time  + @iTDG_Time  
,				TDNan_Time  = TDNan_Time	+ @iTDNan_Time
,				TDD_Time    = TDD_Time  + @iTDD_Time  
,				DW_Time	    = DW_Time	+ @iDW_Time	         	
,				DL_Time	    = DL_Time	+ @iDL_Time	     	
,				DG_Time     = DG_Time   + @iDG_Time   		
,				DNan_Time   = DNan_Time + @iDNan_Time 
,				DD_Time     = DD_Time   + @iDD_Time   		
			WHERE unituid = @iUnitUID
	IF @@error <> 0
		BEGIN	SELECT @iOK_ = -103	GOTO FAIL_TRAN	END


COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK_, @iUnitUID
GO
CREATE OR ALTER PROCEDURE [dbo].[StatsVsMapUpdate]
	@iMapID		[int]
,	@iMapCnt	[int]
,	@iOK_		[int] = 0
AS
/* 
sutamtwo
작성일 : 2007년 10월 25일
사용 : 맵 카운트 업데이트
*/
SET NOCOUNT ON;
SET XACT_ABORT ON;


BEGIN TRAN

	-- 맵 정보가 없으면, 
	IF NOT EXISTS(SELECT * FROM dbo.StatsVsMap WITH (NOLOCK) WHERE MapID = @iMapID)
		BEGIN
			INSERT INTO dbo.StatsVsMap (MapID)
				SELECT @iMapID
					IF @@ERROR <> 0
					BEGIN	SELECT @iOK_ = -101	GOTO FAIL_TRAN	END
		END

	-- 맵 카운트 플러스
	UPDATE dbo.StatsVsMap	WITH (UPDLOCK)
		SET	MapCnt	= MapCnt + @iMapCnt
			WHERE MapID = @iMapID
		IF @@error <> 0
			BEGIN	SELECT @iOK_ = -102	GOTO FAIL_TRAN	END


COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK_
GO
CREATE OR ALTER PROCEDURE [dbo].[StatsStoneCntUpdate]
	@iPlayerCnt		bigint
,	@iUseCnt		bigint
,	@iOK_			[int] = 0
AS
/* 
sutamtwo
작성일 : 2007년 12월 24일
사용 : 부활석 사용량 측정 SP
*/
SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE @strRegdate	nvarchar(10)
,		@iStoneCnt	bigint
SELECT	@strRegdate = CONVERT(nvarchar(10),getdate(),120)

SELECT @iStoneCnt = SUM(Quantity)
	FROM [Game01].[dbo].[GResurrectionStone] WITH (NOLOCK)

BEGIN TRAN

		IF NOT EXISTS (SELECT * FROM dbo.StatsStoneCnt WITH (NOLOCK) WHERE Regdate = @strRegdate)
			BEGIN	
				INSERT INTO dbo.StatsStoneCnt (Regdate, PlayerCnt, UseCnt)
					SELECT @strRegdate, @iPlayerCnt, @iUseCnt

						IF @@ERROR <> 0
						BEGIN	SELECT @iOK_ = -101	GOTO FAIL_TRAN	END
			END		-- GUnit에 존재하지만 테이블에 기록되어있지 않다면,

		ELSE

	UPDATE dbo.StatsStoneCnt WITH (UPDLOCK)
			SET	PlayerCnt	= PlayerCnt		+ @iPlayerCnt			   	
,				UseCnt		= UseCnt		+ @iUseCnt		   	
,				DailyAVGCnt	= (UseCnt + @iUseCnt)*1.0/(PlayerCnt + @iPlayerCnt)
,				NowCnt		= @iStoneCnt
			WHERE Regdate	= @strRegdate
	IF @@error <> 0
		BEGIN	SELECT @iOK_ = -102	GOTO FAIL_TRAN	END



COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK_
GO
-- =============================================
-- Author:		YJ
-- Create date: 2012. 07. 01
-- Description:	각 퀘스트별 수락과 완료, 포기 비율 및 평균 레벨 구하기
--				퀘스트 통계 새버전  ~매일저장
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[StatsQuestInfoUpdate]
	@iQuestID		[bigint]
,	@iAccept		[smallint]
,	@iGiveUp		[smallint]
,	@iComplete		[smallint]
,	@iAcceptLevel	[smallint]
,	@iGiveUpLevel	[smallint]
,	@iCompleteLevel	[smallint]
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE @iResult int
,		@iAccept_	bigint
,		@iGiveUp_	bigint
,		@iComplete_	bigint


BEGIN TRY

	SET @iResult = -1
		
	IF Convert(Char(10),GETDATE(),120) < '2012-07-05' --SP 생성 다음날짜 입력
		BEGIN
			RAISERROR (N'Error', 15, 1)
		END
		
	BEGIN TRAN
		-- 해당 퀘스트는 존재하지만 기존 데이터가 없으면 insert
		IF NOT EXISTS(SELECT * FROM dbo.LQuestInfo WITH (NOLOCK) WHERE QuestID = @iQuestID AND Convert(Char(10),RegDate,120) = Convert(Char(10),Getdate(),120))
			BEGIN
				INSERT INTO dbo.LQuestInfo (QuestID, Accept, GiveUp, Complete, AcceptLevel, GiveUpLevel, CompleteLevel)
					SELECT @iQuestID, @iAccept, @iGiveUp, @iComplete, @iAcceptLevel, @iGiveUpLevel, @iCompleteLevel
					
			END			
		ELSE 			
			BEGIN					
				UPDATE dbo.LQuestInfo WITH (UPDLOCK)
					SET	Accept			= Accept		+ @iAccept	            	
		,				GiveUp			= GiveUp		+ @iGiveUp	         	
		,				Complete	    = Complete		+ @iComplete	       	
		,				AcceptLevel		= AcceptLevel	+ @iAcceptLevel	
		,				GiveUpLevel		= GiveUpLevel	+ @iGiveUpLevel          	
		,				CompleteLevel	= CompleteLevel	+ @iCompleteLevel	
		,				RegDate			= GETDATE()
					WHERE QuestID = @iQuestID AND Convert(Char(10),RegDate,120) = Convert(Char(10),Getdate(),120)
			END
	COMMIT TRAN		
	
	/*
	SET @iResult = -2
	BEGIN TRAN
			
		SELECT	@iAccept_ = Accept, @iGiveUp_ = GiveUp, @iComplete_ = Complete
			FROM dbo.LQuestInfo	WITH (NOLOCK)
				WHERE QuestID = @iQuestID AND Convert(Char(10),RegDate,120) = Convert(Char(10),Getdate(),120)


		IF (@iAccept_ > 0 AND @iGiveUp_ > 0 AND @iComplete_ > 0)
			BEGIN 
				UPDATE dbo.LQuestInfo WITH (UPDLOCK)
					SET AcceptLevelRate = AcceptLevel * 1.0 / Accept
		,				GiveUpLevelRate = GiveUpLevel * 1.0/ GiveUp
		,				CompleteLevelRate = CompleteLevel * 1.0/ Complete
					WHERE QuestID = @iQuestID AND Convert(Char(10),RegDate,120) = Convert(Char(10),Getdate(),120)
			END
				
	COMMIT TRAN
	*/
	
	SET @iResult = 0

	SELECT @iResult, @iQuestID
	
END TRY

BEGIN CATCH
	IF (XACT_STATE()) <> 0
		ROLLBACK TRAN
		
	SELECT @iResult, ERROR_MESSAGE() AS ErrorMassage
END CATCH
GO
CREATE OR ALTER PROCEDURE [dbo].[StatsMoneySupplyUpdate]
	@iPDun					bigint
,	@iPTraining				bigint
,	@iPQuest				bigint
,	@iPItemSell				bigint
,	@iPItemP2P				bigint
,	@iPStoreP2P				bigint
,	@iPPostP2P				bigint	-- 우체국 받은 돈
,	@iMItemBuy				bigint
,	@iMItemP2P				bigint
,	@iMItemRepair			bigint
,	@iMItemMake				bigint
,	@iMDunPenalty			bigint
,	@iMStoreP2P				bigint
,	@iMStoreOpen			bigint
,	@iMEnchant				bigint
,	@iMSocket				bigint
,	@iMPostP2P				bigint	-- 우체국 송금
,	@iMPostBasic			bigint	-- 우체국 수수료 (기본)
,	@iMPostItem				bigint	-- 우체국 수수료 (아이템)
,	@iMAttribute			bigint	-- 속성강화
,	@iMStoreP2PTax			bigint	-- 개인 상점 수수료
,	@iMStoreBBSTax			bigint	-- 개인 상점 거래게시판 수수료
,	@iMPShopAgency			bigint
,	@iMBuyTaxPShopA 		bigint
,	@IPPShopPickUp			bigint
,	@iMOpenCubeSpendED		bigint	-- ED로 큐브오픈/2012.12.06 패치
,	@iPBattleFieldED		bigint	-- 배틀필드에서 획득한 ED/2013.05.09 패치
,	@iMCoboExpressTicketED	bigint	-- 코보티켓 지역이동으로 소모한 ED/2013.05.09 패치
,	@iMItemDecom			bigint	-- 일본 분해 ED
,	@iOK_				[int] = 0
AS
/* 
sutamtwo
작성일 : 2007년 12월 24일
사용 : 통화량 측정 SP
*/
SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE @strRegdate	nvarchar(10)
SELECT	@strRegdate = CONVERT(nvarchar(10),getdate(),120)

BEGIN TRAN
	-- 해당 유닛은 존재하지만 기존 데이터가 없으면 insert

		IF NOT EXISTS (SELECT * FROM dbo.StatsMoneySupply WITH (NOLOCK) WHERE Regdate = @strRegdate)
			BEGIN	
				INSERT INTO dbo.StatsMoneySupply (Regdate, PDun, PTraining, PQuest, PItemSell, PItemP2P, PStoreP2P, PPostP2P, MItemBuy, MItemP2P, MItemRepair, MItemMake, MDunPenalty, MStoreP2P, MStoreOpen, MEnchant, MSocket, MPostP2P, MPostBasic, MPostItem, MAttribute, MStoreP2PTax, MStoreBBSTax, MPShopAgency, MBuyTaxPShopA, PPShopPickUp, MOpenCubeSpendED, PBattleFieldED, MCoboExpressTicketED, MItemDecom)
					SELECT @strRegdate, @iPDun, @iPTraining, @iPQuest, @iPItemSell, @iPItemP2P, @iPStoreP2P, @iPPostP2P, @iMItemBuy, @iMItemP2P, @iMItemRepair, @iMItemMake, @iMDunPenalty, @iMStoreP2P, @iMStoreOpen, @iMEnchant, @iMSocket, @iMPostP2P, @iMPostBasic, @iMPostItem, @iMAttribute, @iMStoreP2PTax, @iMStoreBBSTax, @iMPShopAgency, @iMBuyTaxPShopA, @IPPShopPickUp, @iMOpenCubeSpendED, @iPBattleFieldED, @iMCoboExpressTicketED, @iMItemDecom

						IF @@ERROR <> 0
						BEGIN	SELECT @iOK_ = -101	GOTO FAIL_TRAN	END
			END		-- GUnit에 존재하지만 테이블에 기록되어있지 않다면,

		ELSE

	UPDATE dbo.StatsMoneySupply WITH (UPDLOCK)
			SET	PDun		 		= PDun			+ @iPDun				
,				PTraining	 		= PTraining	+ @iPTraining			   	
,				PQuest		 		= PQuest		+ @iPQuest		   	
,				PItemSell	 		= PItemSell	+ @iPItemSell		 	
,				PItemP2P	 		= PItemP2P		+ @iPItemP2P		
,				PStoreP2P	 		= PStoreP2P	+ @iPStoreP2P
,				PPostP2P	 		= PPostP2P		+ @iPPostP2P
,				MItemBuy	 		= MItemBuy		+ @iMItemBuy			
,				MItemP2P	 		= MItemP2P		+ @iMItemP2P		     	
,				MItemRepair	 		= MItemRepair	+ @iMItemRepair	
,				MItemMake	 		= MItemMake	+ @iMItemMake			  	
,				MDunPenalty  		= MDunPenalty	+ @iMDunPenalty
,				MStoreP2P	 		= MStoreP2P	+ @iMStoreP2P	
,				MStoreOpen	 		= MStoreOpen	+ @iMStoreOpen
,				MEnchant	 		= MEnchant		+ @iMEnchant		
,				MSocket		 		= MSocket		+ @iMSocket		
,				MPostP2P	 		= MPostP2P		+ @iMPostP2P	
,				MPostBasic	 		= MPostBasic	+ @iMPostBasic  
,				MPostItem	 		= MPostItem	+ @iMPostItem	
,				MAttribute	 		= MAttribute	+ @iMAttribute  
,				MStoreP2PTax 		= MStoreP2PTax	+ @iMStoreP2PTax
,				MStoreBBSTax 		= MStoreBBSTax	+ @iMStoreBBSTax
,				MPShopAgency 		= MPShopAgency + @iMPShopAgency
,				MBuyTaxPShopA		= MBuyTaxPShopA+ @iMBuyTaxPShopA
,				PPShopPickUp 		= PPShopPickUp + @IPPShopPickUp
,				MOpenCubeSpendED	= MOpenCubeSpendED + @iMOpenCubeSpendED
,				PBattleFieldED		= PBattleFieldED + @iPBattleFieldED
,				MCoboExpressTicketED= MCoboExpressTicketED + @iMCoboExpressTicketED
,				MItemDecom 			= MItemDecom + @iMItemDecom
			WHERE Regdate	= @strRegdate
	IF @@error <> 0
		BEGIN	SELECT @iOK_ = -102	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK_
GO
CREATE OR ALTER PROCEDURE [dbo].[StatsFrameRate]
	@iPlayType		[tinyint]	
,	@iSUnder20		[int]		
,	@iS21_30		[int]		
,	@iS31_40		[int]		
,	@iS41_50		[int]		
,	@iS51_60		[int]		
,	@iS61_70		[int]		
,	@iS71_80		[int]		
,	@iS81_90		[int]		
,	@iSOver90		[int]		
,	@iOK_			[int] = 0
AS 

/* 
sutamtwo
작성일 : 2007년 11월 1일
사용 : 기타 통계 자료 업데이트
*/
SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE @TODAY VARCHAR(10)
,		@SumCnt	Float
SELECT @TODAY = CONVERT(VARCHAR(10),GETDATE(),120)

BEGIN TRAN

	IF NOT EXISTS (SELECT * FROM dbo.FrameRate WITH (NOLOCK) WHERE RegDate = @TODAY AND PlayType = @iPlayType )
			BEGIN	-- 해당 날짜 해당 통계가 존재하지만 테이블에 기록되어있지 않다면,
				INSERT INTO dbo.FrameRate (RegDate, PlayType)
					SELECT @TODAY, @iPlayType
				IF @@ERROR <> 0
				BEGIN	SELECT @iOK_ = -101	GOTO FAIL_TRAN	END
			END		-- GUnit에 존재하지만 테이블에 기록되어있지 않다면,                 

	-- 비율 합계 업데이트
	UPDATE dbo.FrameRate WITH (UPDLOCK)
			SET	Under20  = Under20  + @iSUnder20 
,				S21_30   = S21_30   + @iS21_30  
,				S31_40   = S31_40   + @iS31_40  
,				S41_50   = S41_50   + @iS41_50  
,				S51_60   = S51_60   + @iS51_60  
,				S61_70   = S61_70   + @iS61_70  
,				S71_80   = S71_80   + @iS71_80  
,				S81_90   = S81_90   + @iS81_90  
,				Over90   = Over90  + @iSOver90  
			WHERE RegDate = @TODAY AND PlayType = @iPlayType

	IF @@error <> 0
		BEGIN	SELECT @iOK_ = -103	GOTO FAIL_TRAN	END

	-- 총합 및 평균 구하기
	SELECT @SumCnt = (Under20 + S21_30 + S31_40 + S41_50 + S51_60 + S61_70 + S71_80 + S81_90 + Over90)
		FROM dbo.FrameRate WITH (NOLOCK)
			WHERE RegDate = @TODAY AND PlayType = @iPlayType

	UPDATE dbo.FrameRate
		SET	AUnder20	= Under20 / @SumCnt * 100
,			A21_30		= S21_30 / @SumCnt	* 100	
,			A31_40		= S31_40 / @SumCnt  * 100
,			A41_50		= S41_50 / @SumCnt  * 100
,			A51_60		= S51_60 / @SumCnt  * 100	  
,			A61_70		= S61_70 / @SumCnt  * 100	 
,			A71_80		= S71_80 / @SumCnt  * 100	 
,			A81_90		= S81_90 / @SumCnt  * 100
,			AOver90		= Over90 / @SumCnt  * 100
		WHERE RegDate = @TODAY AND PlayType = @iPlayType


COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK_
GO
CREATE OR ALTER PROCEDURE [dbo].[StatsEtcUpdateSecond]	
	@iUserUID			[bigint]
,	@iUnitUID			[bigint]
,	@iPDunED			[int]
,	@iPQuestED			[int]
,	@iPItemSellED		[int]
--,	@iPItemP2PED		[int]
,	@iMItemBuyED		[int]
--,	@iMItemP2PED		[int]
,	@iMItemMakeED		[int]
,	@iMItemRepairED		[int]
,	@iMStoreP2P			[int]
,	@iMEnchant			[int]
,	@iMSocket			[int]
,	@iP2PCnt			[int]
,	@iNQuestAcc			[int]
,	@iNQuestGiveUp		[int]
,	@iNQuestComplete	[int]
,	@iRQuestAcc			[int]
,	@iRQuestGiveUp		[int]
,	@iRQuestComplete	[int]
,	@iMOpenCubeSpendED	[int] -- 2012.12.06 패치
--,	@iEQuestAcc			[int]
--,	@iEQuestGiveUp		[int]
--,	@iEQuestComplete	[int]
,	@iOK_				[int] = 0
AS

/* 
choi yuk sa
작성일 : 2008년 03월 11일
사용 : 기타 통계 자료 업데이트
수정 : Etc프로시져 최적화
*/
SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRAN
	-- 해당 유닛은 존재하지만 기존 데이터가 없으면 insert
	IF NOT EXISTS (SELECT * FROM dbo.UnitStatistics WITH (NOLOCK) WHERE UnitUid = @iUnitUID)
		BEGIN	-- GUnit에 존재하지만 테이블에 기록되어있지 않다면,
			INSERT INTO dbo.UnitStatistics (UnitUID, UserUID, Age, Gender, RegDate, UnitClass, [level])
				SELECT a.UnitUID, a.UserUID, b.Age, b.Gender, a.RegDate, a.UnitClass, a.level
					FROM [Game01].[dbo].[GUnit] as a WITH (NOLOCK), [Account].[dbo].[MUser] as b WITH (NOLOCK)
						WHERE a.UnitUID = @iUnitUID and b.UserUID = @iUserUID
					IF @@ERROR <> 0
					BEGIN	SELECT @iOK_ = -101	GOTO FAIL_TRAN	END
		END		-- GUnit에 존재하지만 테이블에 기록되어있지 않다면,	

		-- ED 획득량 및 던전, 개인거래 횟수
		UPDATE dbo.UnitStatistics WITH (UPDLOCK)
			SET	PDunED		= PDunED			+ @iPDunED		
,				PQuestED		= PQuestED			+ @iPQuestED		   
,				PItemSellED	= PItemSellED		+ @iPItemSellED	
--,				PItemP2PED	= PItemP2PED		+ @iPItemP2PED	
,				MItemBuyED	= MItemBuyED		+ @iMItemBuyED	
--,				MItemP2PED	= MItemP2PED		+ @iMItemP2PED	
,				MItemMakeED	= MItemMakeED		+ @iMItemMakeED	
,				MItemRepairED	= MItemRepairED	+ @iMItemRepairED
,				MStoreP2P	= MStoreP2P			+ @iMStoreP2P
,				MEnchant	= MEnchant			+ @iMEnchant
,				MSocket		= MSocket			+ @iMSocket
,				P2PCnt		= P2PCnt			+ @iP2PCnt		
,				NQuestAcc			= NQuestAcc			+ @iNQuestAcc		   
,				NQuestGiveUp		= NQuestGiveUp		+ @iNQuestGiveUp	
,				NQuestComplete	= NQuestComplete	+ @iNQuestComplete 
,				RQuestAcc			= RQuestAcc			+ @iRQuestAcc		   
,				RQuestGiveUp		= RQuestGiveUp		+ @iRQuestGiveUp	
,				RQuestComplete	= RQuestComplete	+ @iRQuestComplete
,				MOpenCubeSpendED = MOpenCubeSpendED + @iMOpenCubeSpendED
--,				EQuestAcc			= EQuestAcc			+ @iEQuestAcc		   
--,				EQuestGiveUp		= EQuestGiveUp		+ @iEQuestGiveUp	
--,				EQuestComplete	= EQuestComplete	+ @iEQuestComplete 
				WHERE unitUID = @iUnitUID
		IF @@error <> 0
			BEGIN	SELECT @iOK_ = -104	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK_
GO
CREATE OR ALTER PROCEDURE [dbo].[StatsEtcUpdateFirst]
	@iUserUID		[bigint]
,	@iUnitUID		[bigint]
,	@iUseSpirit		[smallint]
,	@bAllSpirit		[bit]
,	@iDurationTime	[int]
,	@iVsKill		[smallint]
,	@iGetItem		[smallint]
,	@iBuyItem		[smallint]
,	@iSellItem		[smallint]
,	@iP2PBuyItem	[smallint]
,	@iP2PSellItem	[smallint]
,	@iSquare_Cnt	[smallint]
,	@iSquare_Time	[int]
,	@iIsPCBang		[bit]
,	@iOK_			[int] = 0
AS

/* 
sutamtwo
작성일 : 2008년 07월 14일
사용 : 기타 통계 자료 업데이트
수정 : Etc프로시져 최적화
*/
SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRAN
	-- 해당 유닛은 존재하지만 기존 데이터가 없으면 INSERT
	IF NOT EXISTS (SELECT * FROM dbo.UnitStatistics WITH (NOLOCK) WHERE UnitUid = @iUnitUID)
		BEGIN	-- GUnit에 존재하지만 테이블에 기록되어있지 않다면,
			INSERT INTO dbo.UnitStatistics (UnitUID, UserUID, Age, Gender, RegDate, UnitClass, [level])
				SELECT @iUnitUID, @iUserUID, b.Age, b.Gender, a.RegDate, a.UnitClass, a.level
					FROM [Game01].[dbo].[GUnit] AS A WITH (NOLOCK)
							JOIN [Account].[dbo].[MUser] AS B WITH (NOLOCK)
								ON a.UnitUID = @iUnitUID and b.UserUID = @iUserUID
					IF @@ERROR <> 0
						  BEGIN	SELECT @iOK_ = -101	GOTO FAIL_TRAN	END
		END		-- GUnit에 존재하지만 테이블에 기록되어있지 않다면,



	-- 기본통계 (일일통계) 근성도 모두 소모한 유저의 특성 파악
	IF (@bAllSpirit = 1)
		BEGIN
			INSERT INTO dbo.StatsAllSpirit (UnitUID, UnitClass, Level, PlayDayCnt, AllSpirit, DunCnt, VsCnt, QuestCnt, UseStone, GetED, UseED, NowED )
				SELECT UnitUID, UnitClass, Level, PlayDayCnt, AllSpirit + 1, (DSoloCnt + DPartyCnt), VsCnt, QuestCnt, (SELECT SUM(srs_cnt + prs_cnt) FROM dbo.statsdungeon WITH (NOLOCK) WHERE UnitUID = @iUnitUID), (PDunED + PQuestED + PItemSellED + PItemP2PED), (MItemBuyED+MItemP2PED+MItemMakeED+MItemRepairED+MStoreP2P+MEnchant), GamePoint
					FROM dbo.UnitStatistics WITH (NOLOCK)
						WHERE UnitUID = @iUnitUID
		END


	-- 대전 모드 카운트 업데이트
	UPDATE dbo.UnitStatistics WITH (UPDLOCK)
			SET	UseSpirit		= UseSpirit	     +  @iUseSpirit		  	
,				AllSpirit		= AllSpirit	     + 	@bAllSpirit		
,				DurationTime	= DurationTime   +  @iDurationTime	   	
,				KillCnt			= KillCnt		 +  @iVsKill		   	
,				GetItem			= GetItem		 +  @iGetItem		 	
,				BuyItem			= BuyItem		 +	@iBuyItem		
,				SellItem		= SellItem	   	 +	@iSellItem		
,				P2PBuyItem		= P2PBuyItem	 +  @iP2PBuyItem	     	
,				P2PSellItem		= P2PSellItem	 +  @iP2PSellItem	      	
,				SquareCnt		= SquareCnt	     +  @iSquare_Cnt		   	
,				SquarePlayTime	= SquarePlayTime +  @iSquare_Time	
			WHERE unituid = @iUnitUID
	IF @@error <> 0
		BEGIN	SELECT @iOK_ = -103	GOTO FAIL_TRAN	END

	-- PC방 관련 카운트 작업

	IF (@iIsPCBang = 1)
		BEGIN
			UPDATE dbo.UnitStatistics WITH (UPDLOCK)
				SET	PCBangCnt = PCBangCnt + 1
					WHERE unitUID = @iUnitUID
			IF @@ERROR <> 0
				BEGIN	SELECT @iOK_ = -104	GOTO FAIL_TRAN	END

			IF ((SELECT PCBangFlag FROM dbo.UnitStatistics WITH (NOLOCK) WHERE unitUID = @iUnitUID) = 0)
				BEGIN
					UPDATE dbo.UnitStatistics
						SET PCBangDayCnt = PCBangDayCnt + 1, PCBangFlag = 1
							WHERE UnitUID = @iUnitUID
					IF @@ERROR <> 0
						BEGIN	SELECT @iOK_ = -105	GOTO FAIL_TRAN	END

				END
		END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK_
GO
CREATE OR ALTER PROCEDURE [dbo].[StatsInsertSealLog]
	@iUnitUID	BIGINT
,	@iSealUID	BIGINT
,	@iItemUID	BIGINT
,	@iSealCnt	TINYINT
,	@iOK		INT = 0

AS

/* 
	2009.09.09
	sutamtwo
	봉인 아이템 로그
	
*/

SET NOCOUNT ON;


BEGIN TRAN

	INSERT INTO dbo.StatsSealLog (UnitUID, SealUID, ItemUID, SealCnt, RegDate) 
		SELECT @iUnitUID, @iSealUID, @iItemUID, @iSealCnt, GETDATE()

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[StatsInsertItemResurrection]
	@iUnitUID	[bigint]
,	@iItemUID	[bigint]
,	@iBefore	[smallint]
,	@iAfter		[smallint]
,	@iOK		[int] = 0


AS
/* 
sutamtwo
작성일 : 2008년 12월 22일
사용 : 강화로 파괴된 아이템 살리기
*/
SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRAN

	INSERT INTO dbo.StatsItemResurrection(UnitUID,	ItemUID, Before, After ,RegDate)
		SELECT @iUnitUID, @iItemUID, @iBefore, @iAfter, GetDate()

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[StatsInsertItemBreak]
	@iUnitUID	[bigint]
,	@iItemUID	[bigint]
,	@iItemID	[int]
,	@iELevel	[tinyint]
,	@iOK		[int] = 0


AS
/* 
sutamtwo
작성일 : 2008년 11월 10일
사용 : 강화레벨 5 이상 아이템 파괴 로그
*/
SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRAN

	INSERT INTO dbo.StatsItemBreak(UnitUID,	ItemUID, ItemID, ELevel	,RegDate)
		SELECT @iUnitUID, @iItemUID, @iItemID, @iELevel, GetDate()

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[StatsInsertHackUser]
	@strUserID	NVARCHAR(30)
,	@iChannel	TINYINT

AS

SET NOCOUNT ON;
	/*
		2009. 10. 26
		sutamtwo

		중복패킷 관련 핵유저 등록

	*/

DECLARE	@sdtNow	SMALLDATETIME
SELECT	@sdtNow	= GETDATE()

	INSERT INTO dbo.statsHackUser (UserID, Channel, RegDate)
		SELECT @strUserID, @iChannel, @sdtNow
GO
/*
	2009.06.09
	sutamtwo
	CSP 사용로그 남기기
*/

CREATE OR ALTER PROCEDURE [dbo].[StatsInsertCSPLog]
	@iUnitUID	BIGINT
,	@iLevel		TINYINT	
,	@iCSP		TINYINT
,	@iPeriod	TINYINT
,	@iIsExtend	BIT	
,	@iOK		INT	= 0
AS
SET NOCOUNT ON;

DECLARE	@sdtNow	SMALLDATETIME
SELECT	@sdtNow = GETDATE()

BEGIN TRAN	
	
	INSERT INTO dbo.StatsCSPLog (UnitUID, [Level], CSPoint, Period, IsExtend, RegDate)
		SELECT @iUnitUID, @iLevel, @iCSP, @iPeriod, @iIsExtend, @sdtNow

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END

COMMIT TRAN


GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[StatsInsertCharmItemLog_Direct]
	@ServerSetID	tinyint
,	@iUnitUID	[bigint]
,	@iItemID	[int]
,	@iItemUID	[bigint]
,	@iBefore	[tinyint]
,	@iAfter		[tinyint]
,	@iOK		[int] = 0


AS
/* 
sutamtwo
작성일 : 2008년 12월 30일
사용 : 매력 아이템 중 Direct로 강화 시켜주는 아이템 사용 시 로그
*/
SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRAN

	INSERT INTO dbo.StatsCharmItemLog_Direct (ServerSetID, UnitUID, ItemID, ItemUID, Before, After, RegDate)
		SELECT @ServerSetID, @iUnitUID, @iItemID, @iItemUID, @iBefore, @iAfter, GetDate()

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[StatsInsertCharmItemLog]
	@iCharItemID	[bigint]
,	@iUnitUID		[bigint]
,	@iItemID		[int]
,	@iQuantity		[tinyint]
,	@iOK			[int] = 0


AS
/* 
sutamtwo
작성일 : 2008년 12월 30일
사용 : 매력 아이템 사용 시 획득 아이템 관련 로그
*/
SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRAN

	INSERT INTO dbo.StatsCharmItemLog (CharmItemID, UnitUID, ItemID, Quantity, RegDate)
		SELECT @iCharItemID, @iUnitUID, @iItemID, @iQuantity, GetDate()

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[StatsInsertAttrib_AttachLog]
	@iUnitUID		[bigint]
,	@iItemID		[int]
,	@iItemUID		[bigint]
,	@iBeforeSlot1	[tinyint]
,	@iBeforeSlot2	[tinyint]
,	@iBeforeSlot3	[tinyint]
,	@iAfterSlot1	[tinyint]
,	@iAfterSlot2	[tinyint]
,	@iAfterSlot3	[tinyint]
,	@iOK		[int] = 0


AS
/* 
Hwang
작성일 : 2011년 01월 05일
사용 : 속성석 대신 이벤트 기간내 정제된 엘의 조각 사용 시 로그
*/
SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRAN

	INSERT INTO dbo.StatsAttrib_AttachLog (UnitUID, ItemID, ItemUID, BeforeSlot1, BeforeSlot2, BeforeSlot3, AfterSlot1, AfterSlot2, AfterSlot3, RegDate)
		SELECT @iUnitUID, @iItemID, @iItemUID, @iBeforeSlot1, @iBeforeSlot2, @iBeforeSlot3, @iAfterSlot1, @iAfterSlot2, @iAfterSlot3, GetDate()

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[StatsInsertAidLog]
	@iItemUID	[bigint]
,	@iBefore	[tinyint]
,	@iAfter		[tinyint]
,	@iOK		[int] = 0


AS
/* 
sutamtwo
작성일 : 2008년 12월 18일
사용 : 강화보조제 사용 로그
*/
SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRAN

	INSERT INTO dbo.statsEnchantAid (ItemUID, Before, After, RegDate)
		SELECT @iItemUID, @iBefore, @iAfter, GetDate()

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[StatsDecompositionLog]
	@iUnitUID				bigint
,	@iItemUID				bigint
,	@iQuantity				tinyint
,	@iAfterItemID			int = NULL
,	@iAfterItemQuantity		int = NULL
,	@iLevel					tinyint = NULL
AS
/*
	캐시템 분해 시 로그 남김
	sutamtwo
	2008-10-22
	수정
	김병일
	2011-05-11
	로그 추가
*/
	SET NOCOUNT ON

	DECLARE @Result	int

	BEGIN TRY

		INSERT INTO dbo.StatsDecomposition ( UnitUID, ItemUID, Quantity, RegDate, AfterItemID, AfterItemQuantity, [Level] )
		VALUES ( @iUnitUID, @iItemUID, @iQuantity, GETDATE(), @iAfterItemID, @iAfterItemQuantity, @iLevel )

		SET @Result = 0
	END TRY
	BEGIN CATCH
		SET @Result = -1
	END CATCH

	SELECT @Result
GO
CREATE OR ALTER PROCEDURE [dbo].[StatsDailyUpdate]
	@iNewUnit		[int]
,	@iDelUnit		[int]
,	@iOK_			[int] = 0
AS
/* 
sutamtwo
작성일 : 2011년 02월 28일
사용 : 일일 캐릭터 생성수와 삭제수 SP
*/
SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE @strRegdate	nvarchar(10)
SELECT	@strRegdate = CONVERT(nvarchar(10),getdate(),120)

BEGIN TRAN
	-- 해당 일의 데이터가 없다면 insert

		IF NOT EXISTS (SELECT * FROM dbo.StatsDaily WITH (NOLOCK) WHERE Date = @strRegdate)
			BEGIN	
				INSERT INTO dbo.StatsDaily (Date, TotalUnit, NewUnit, DelUnit)
					SELECT @strRegdate, 0, @iNewUnit, @iDelUnit

						IF @@ERROR <> 0
						BEGIN	SELECT @iOK_ = -201	GOTO FAIL_TRAN	END
			END	

		ELSE
			BEGIN
				UPDATE dbo.StatsDaily WITH (UPDLOCK)
					SET	NewUnit	= NewUnit	+ @iNewUnit				
					,	DelUnit	= DelUnit	+ @iDelUnit			   	
						WHERE Date	= @strRegdate
				IF @@error <> 0
					BEGIN	SELECT @iOK_ = -202	GOTO FAIL_TRAN	END
			END
			
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK_
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_CBT3rdDailyUserStats_SEL]
	@iServerSetID	TINYINT	
AS
SET NOCOUNT ON;


declare @iUniq	int
,		@iAvgPT	int
,		@iAvgVsPT int


select	@iUniq = count(distinct(useruid)) from dbo.lconnectlog with (nolock) where logintime  
between convert(nvarchar(10), dateadd( day, -2, getdate()), 120)+' 00:00' and convert(nvarchar(10), dateadd( day, -2, getdate()), 120)+' 23:59' and vsplaytime between 0 and 180000 and totalplaytime between 0 and 180000 

select @iAvgPT = sum(totalplaytime)/@iUniq, @iAvgVsPT = sum(vsplaytime)/@iUniq 
	from dbo.lconnectlog with (nolock)
		where logintime  between convert(nvarchar(10), dateadd( day, -2, getdate()), 120)+' 00:00' and convert(nvarchar(10), dateadd( day, -2, getdate()), 120)+' 23:59' and vsplaytime between 0 and 180000 and totalplaytime between 0 and 180000 
			and vsplaytime between 0 and 180000 and totalplaytime between 0 and 180000 

--일간 정보
select topconnectcnt, topconnecttime, avgconnectcnt, newuniquser, totaluser, dayuniquser,avgDT, @iAvgPT, @iAvgVsPT, AVGArcadePT
	from dbo.CBT3rdDailyUserStats with (nolock)
		where date = convert(nvarchar(10), dateadd( day, -2, getdate()), 120)
GO
-- =============================================
-- Author: 
-- Create date: 
-- Description: 어뷰징 유저 목록을 조화한다.
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_AbuserList_SEL]
	@iServerSetID	TINYINT,
	@iType	tinyint

AS
SET NOCOUNT ON;

SELECT UnitUID
	FROM dbo.AbuserList WITH (NOLOCK)
		WHERE Type = @iType
GO
-- =============================================
-- Author:		sutamtwo
-- Create date: 2008. 11. 03
-- Description: 어뷰저 리스트에 등록, Tick 값 갱신
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_AbuserList_INS]
	@iServerSetID	TINYINT
,	@iType			tinyint
,	@iUnitUID		bigint
,	@iOK			int = 0
AS
SET NOCOUNT ON;

----	닉네임으로 UnitUID 찾아내기
--DECLARE	@iUnitUID	bigint
--SELECT	@iUnitUID = UnitUID
--	FROM [Game01].[dbo].[GUnitNickName] WITH (NOLOCK)
--		WHERE NickName = @strNickName


----	존재하지 않는 닉네임
--IF (@iUnitUID IS NULL)
--	BEGIN	SELECT @iOK = -1	GOTO END_PROC	END

--	이미 등록된 닉네임
IF	EXISTS (SELECT * FROM dbo.AbuserList WITH (NOLOCK) WHERE UnitUID = @iUnitUID AND Type = @iType)
	BEGIN	SELECT @iOK = -2	GOTO END_PROC	END




BEGIN TRAN

	INSERT INTO dbo.AbuserList (Type, UnitUID)
		SELECT @iType, @iUnitUID

	IF NOT EXISTS (SELECT * FROM dbo.ReleaseTick WITH (NOLOCK) WHERE Type = @iType)
		BEGIN
			INSERT INTO dbo.ReleaseTick (Type, Count)
				SELECT @iType, 1	

			IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
				BEGIN	SELECT @iOK = -3	GOTO FAIL_TRAN	END
		END
	ELSE
		BEGIN
			UPDATE dbo.ReleaseTick
				SET Count = Count + 1
					WHERE Type = @iType
			IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
				BEGIN	SELECT @iOK = -4	GOTO FAIL_TRAN	END
		END

COMMIT TRAN



GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN


END_PROC:
SELECT @iOK
GO
/*
	VsType 
		1. 데스메치
		2. 팀데스매치
		3. 팀매치 

	IsSecret
		0. 비공개
		1. 공개

	2008. 03. 04
	sutamtwo
	어뷰저 로그 남기기
*/
CREATE OR ALTER PROCEDURE [dbo].[StatsAbusingLogInsert]
	@iUserUID		bigint
,	@iUnitUID		bigint
,	@strIP			nvarchar(15)
,	@iVsType		tinyint
,	@iVsSetTime		smallint
,	@bIsSecret		bit
,	@iPlayerCnt		tinyint
,	@sdtVsEndTime	smalldatetime
,	@iPlayTime		int
,	@iGetVP			int
,	@iGetExp		int
,	@iKillCnt		tinyint
,	@iDeathCnt		tinyint
,	@iOK			int = 0

AS
SET NOCOUNT ON;
SET XACT_ABORT ON;


DECLARE	@sdtVsStartTime	smalldatetime
SELECT  @sdtVsStartTime = DATEADD(SS, -@iPlayTime, GETDATE())


BEGIN TRAN

	INSERT INTO dbo.StatsAbusingLog (UnitUID, UserUID, IP, VsType, VsSetTime, IsSecret, PlayerCnt, VsStartTime, VsEndTime, VsPlayTime, GetVP, GetEXP, KillCnt, DeathCnt)
		SELECT @iUnitUID, @iUserUID, @strIP, @iVsType, @iVsSetTime, @bIsSecret, @iPlayerCnt, @sdtVsStartTime, @sdtVsEndTime, @iPlayTime, @iGetVP, @iGetExp, @iKillCnt, @iDeathCnt
	
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN 
			SELECT @iOK = -1
			GOTO FAIL_TRAN
		END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK


--create table dbo.StatsAbusingLog
--(
--	UnitUID		bigint not null
--,	UserUID		bigint not null
--,	IP			nvarchar(15)
--,	VsType		tinyint
--,	VsSetTime	smallint
--,	IsSecret	bit
--,	PlayerCnt	tinyint
--,	VsStartTime	smalldatetime
--,	VsEndTime	smalldatetime
--,	VsPlayTime	int
--,	GetVP		int
--,	GetExp		int
--,	KillCnt		tinyint
--,	DeathCnt	tinyint
--)
--
--create clustered index IXC_StatsAbusingLog_UnitUID on dbo.StatsAbusingLog(UnitUID) with fillfactor = 80
--create nonclustered index IX_StatsAbusingLog_UserUID on dbo.StatsAbusingLog(UserUID) with fillfactor = 80

--
--1. UserUID
--2. UnitUID
--3. 접속 IP
--4. 방 모드(데스, 팀데, 팀)
--5. 방 제한시간
--6. 비밀방 여부
--7. 대전방 참석인원
--8. 종료시간
--9. 플레이시간
--10. 획득 VP
--11. 획득 EXP
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_StatCCUMinuteChannel_INS]
	@iServerSetID		TINYINT		
,   @sdtRegDate			SMALLDATETIME
,	@iServerUID			INT
,	@iConcurrentUser	INT
, 	@ChannelCode		TINYINT
AS
	SET NOCOUNT ON
	
	DECLARE @Result				int

	BEGIN TRY
	 BEGIN TRAN

		INSERT INTO dbo.StatCCUMinuteChannel ( RegDate, ServerUID, CCU, ChannelCode )
		SELECT @sdtRegDate, @iServerUID, @iConcurrentUser, @ChannelCode
		
	 COMMIT TRAN

		SET @Result = 0
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE  smallint
		SET @NO_XACT_STATE		= XACT_STATE()

		 IF @NO_XACT_STATE <> 0
			 ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

		IF @Result = 0 OR @Result IS NULL
			SET @Result = -1
	END CATCH

	SELECT ISNULL(@Result, 0) AS Result
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_StatCCUMinute_Yesterday_SEL]
	@iServerSetID	TINYINT
,	@iServerUID	SMALLINT
AS
SET NOCOUNT ON;

	SELECT regdate, serveruid, ccu 
		FROM dbo.StatCCUMinute WITH (NOLOCK)
			WHERE regdate BETWEEN convert(varchar(10),getdate()-1,120)+' 00:00:00' AND convert(varchar(10),getdate()-1,120)+' 23:59:00' 
				AND ServerUID = @iServerUID
					ORDER BY regdate
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_StatCCUMinute_Today_SEL]
	@iServerSetID	TINYINT
,	@iServerUID	SMALLINT
AS
SET NOCOUNT ON;

	SELECT regdate, serveruid, ccu 
		FROM dbo.StatCCUMinute WITH (NOLOCK)
			WHERE regdate between convert(varchar(10),getdate(),120)+' 00:00:00' and getdate()
				AND ServerUID = @iServerUID
					ORDER BY regdate
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_StatCCUMinute_SEL]
	@iServerSetID	TINYINT	
,	@iServerUID	smallint
,	@strDate	smalldatetime
AS
SET NOCOUNT ON;

	SELECT regdate, serveruid, ccu 
		FROM dbo.StatCCUMinute WITH (NOLOCK)
			WHERE regdate BETWEEN convert(varchar(10),@strDate,120)+' 00:00:00' AND convert(varchar(10),@strDate,120)+' 23:59:00' 
				AND ServerUID = @iServerUID
					ORDER BY regdate
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_StatCCUMinute_Nowtime_SEL]	
	@iServerSetID	TINYINT
,	@iServerUID	SMALLINT
,	@strDate	smalldatetime
AS
SET NOCOUNT ON;

	SELECT regdate, serveruid, ccu 
		FROM dbo.StatCCUMinute WITH (NOLOCK)
			WHERE regdate between @strDate and getdate()
				AND ServerUID = @iServerUID
					ORDER BY regdate
GO
-- =============================================
-- Author:		김병일
-- Create date: 2011.04.27
-- Description: 매분 게임서버 동접수를 모두 합한 전체 동접을 계산해 기록한다.
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_StatCCUMinute_INS]
    @iServerSetID		tinyint			-- 서버 그룹 추가
,	@sdtRegDate			smalldatetime
,	@iServerUID			int
,	@iConcurrentUser	int
AS
	SET NOCOUNT ON

	BEGIN TRY
		BEGIN TRAN

		IF NOT EXISTS ( SELECT * FROM dbo.StatCCUMinute WITH(NOLOCK) WHERE RegDate = DATEADD(MI, -1, @sdtRegDate) AND ServerSetID = @iServerSetID AND ServerUID = 0 )
		BEGIN
			INSERT INTO dbo.StatCCUMinute ( ServerSetID, RegDate, ServerUID, CCU )
			SELECT @iServerSetID, DATEADD(MI, -1, @sdtRegDate), 0, ISNULL(SUM(CCU), 0)
			FROM dbo.StatCCUMinute AS A WITH(NOLOCK)
			JOIN (
				SELECT ServerSetID, ServerUID, MAX(RegDate) AS RegDate
				FROM dbo.StatCCUMinute AS B WITH(NOLOCK)
				WHERE RegDate BETWEEN DATEADD(MI, -5, @sdtRegDate) AND DATEADD(MI, -1, @sdtRegDate)	-- 5분 이내 데이터 중에
					AND ServerSetID = @iServerSetID													-- 같은 서버 그룹에서
					AND ServerUID > 0																-- 서버 토탈 CCU가 아닌
				GROUP BY ServerSetID, ServerUID
			) AS B
			ON A.ServerSetID = B.ServerSetID AND A.ServerUID = B.ServerUID AND A.RegDate = B.RegDate
		END

		INSERT INTO dbo.StatCCUMinute ( ServerSetID, RegDate, ServerUID, CCU )
		VALUES ( @iServerSetID, @sdtRegDate, @iServerUID, @iConcurrentUser )

		COMMIT TRAN
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE
	END CATCH
GO
-- =============================================
-- Author:		
-- Create date: 
-- Description:	
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_ResurrectionStoneLog_INS]
	@iServerSetID	TINYINT
,	@iUnitUID		bigint	
,	@iDungeonID		int		
,	@sdtRegDate		smalldatetime	
,	@iOK			int = 0
AS

SET NOCOUNT ON;

BEGIN TRAN

	INSERT INTO dbo.ResurrectionStoneLog(ServerSetID, UnitUID, DungeonID, RegDate)
		SELECT @iServerSetID, @iUnitUID, @iDungeonID, @sdtRegDate
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_ReleaseTick_SEL]
	@iServerSetID	TINYINT
AS
SET NOCOUNT ON;

SELECT Type, Count
	FROM dbo.ReleaseTick WITH (NOLOCK)
		ORDER BY TYPE
GO
-- =============================================
-- Author:		sutamtwo
-- Create date: 2009. 07. 07
-- Description: 주간 랭킹 기록 읽어가기
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_Rank_SpaceTime_Week_SEL]
	@iServerSetID	TINYINT
AS 
SET NOCOUNT ON;

DECLARE @sdtNow	SMALLDATETIME
SELECT @sdtNow = (SELECT TOP 1 Date FROM Rank_SpaceTime_Week WITH (NOLOCK) ORDER BY Date DESC )
	

SELECT [Rank], UnitUID, NickName, UnitClass, [Level], Stage, PlayTime, RegDate
	FROM dbo.Rank_SpaceTime_Week WITH (NOLOCK)
		WHERE Date = @sdtNow AND ServerSetID = ISNULL(@iServerSetID, 0)
			ORDER BY [Rank]
				OPTION (MAXDOP 1)
GO
-- =============================================
-- Author:		sutamtwo
-- Create date: 2009. 07. 07
-- Description: 주간 랭킹 넣기
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_Rank_SpaceTime_Week_INS]
	@iServerSetID	TINYINT	
,	@iRank			TINYINT
,	@iUnitUID		BIGINT
,	@strNickName	NVARCHAR(16)
,	@iUnitClass		TINYINT
,	@iLevel			TINYINT
,	@iStage			TINYINT
,	@iPlayTime		SMALLINT
,	@sdtRegDate		SMALLDATETIME
,	@sdtDate		SMALLDATETIME
AS 
SET NOCOUNT ON;

INSERT INTO dbo.Rank_SpaceTime_Week (ServerSetID, [Rank], UnitUID, NickName, UnitClass, [Level], Stage, PlayTime, RegDate, Date)
	SELECT @iServerSetID, @iRank,	@iUnitUID,	@strNickName, @iUnitClass, @iLevel, @iStage, @iPlayTime, @sdtRegDate, @sdtDate
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 헤니르시공 주간 랭킹 정보를 삭제한다.
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_Rank_SpaceTime_Week_DEL]
	@iServerSetID		TINYINT	= NULL
AS 
SET NOCOUNT ON;

TRUNCATE TABLE dbo.Rank_SpaceTime_Week
GO
-- =============================================
-- Author:		sutamtwo
-- Create date: 2009. 07. 07
-- Description: 월간 랭킹 기록 읽어가기
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_Rank_SpaceTime_Month_SEL]
	@iServerSetID	TINYINT	
AS 
SET NOCOUNT ON;

DECLARE @sdtNow	SMALLDATETIME
SELECT @sdtNow = (SELECT TOP 1 Date FROM dbo.Rank_SpaceTime_Month WITH (NOLOCK) ORDER BY Date DESC )
	

SELECT [Rank], UnitUID, NickName, UnitClass, [Level], Stage, PlayTime, RegDate
	FROM dbo.Rank_SpaceTime_Month WITH (NOLOCK)
		WHERE Date = @sdtNow AND ServerSetID = ISNULL(@iServerSetID, 0)
			ORDER BY [Rank]
				OPTION (MAXDOP 1)
GO
-- =============================================
-- Author:		sutamtwo
-- Create date: 2009. 07. 07
-- Description: 월간 랭킹 넣기
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_Rank_SpaceTime_Month_INS]
	@iServerSetID	TINYINT	
,	@iRank			TINYINT
,	@iUnitUID		BIGINT
,	@strNickName	NVARCHAR(16)
,	@iUnitClass		TINYINT
,	@iLevel			TINYINT
,	@iStage			TINYINT
,	@iPlayTime		SMALLINT
,	@sdtRegDate		SMALLDATETIME
,	@sdtDate		SMALLDATETIME
AS 
SET NOCOUNT ON;

INSERT INTO dbo.Rank_SpaceTime_Month (ServerSetID, [Rank], UnitUID, NickName, UnitClass, [Level], Stage, PlayTime, RegDate, Date)
	SELECT @iServerSetID, @iRank,	@iUnitUID,	@strNickName, @iUnitClass, @iLevel, @iStage, @iPlayTime, @sdtRegDate, @sdtDate
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 헤니르시공 월간 랭킹 정보를 삭제한다.
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_Rank_SpaceTime_Month_DEL]
	@iServerSetID		TINYINT	= NULL
AS 
SET NOCOUNT ON;

TRUNCATE TABLE dbo.Rank_SpaceTime_Month
GO
-- =============================================
-- Author:		sutamtwo
-- Create date: 2009. 07. 07
-- Description: 일간 랭킹 기록 읽어가기
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_Rank_SpaceTime_Day_SEL]
	@iServerSetID	TINYINT
AS 
SET NOCOUNT ON;

DECLARE @sdtNow	SMALLDATETIME
SELECT @sdtNow = (SELECT TOP 1 Date FROM Rank_SpaceTime_Day WITH (NOLOCK) ORDER BY Date DESC )
	

SELECT [Rank], UnitUID, NickName, UnitClass, [Level], Stage, PlayTime, RegDate
	FROM dbo.Rank_SpaceTime_Day WITH (NOLOCK)
		WHERE Date = @sdtNow AND ServerSetID = ISNULL(@iServerSetID, 0)
			ORDER BY [Rank]
				OPTION (MAXDOP 1)
GO
-- =============================================
-- Author:		sutamtwo
-- Create date: 2009. 07. 07
-- Description: 일간 랭킹 넣기
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_Rank_SpaceTime_Day_INS]
	@iServerSetID	TINYINT	
,	@iRank			TINYINT
,	@iUnitUID		BIGINT
,	@strNickName	NVARCHAR(16)
,	@iUnitClass		TINYINT
,	@iLevel			TINYINT
,	@iStage			TINYINT
,	@iPlayTime		SMALLINT
,	@sdtRegDate		SMALLDATETIME
,	@sdtDate		SMALLDATETIME
AS 
SET NOCOUNT ON;

INSERT INTO dbo.Rank_SpaceTime_Day (ServerSetID, [Rank], UnitUID, NickName, UnitClass, [Level], Stage, PlayTime, RegDate, Date)
	SELECT @iServerSetID, @iRank,	@iUnitUID,	@strNickName, @iUnitClass, @iLevel, @iStage, @iPlayTime, @sdtRegDate, @sdtDate
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 헤니르시공 일간 랭킹 정보를 삭제한다.
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_Rank_SpaceTime_Day_DEL]
	@iServerSetID		TINYINT	= NULL
AS 
SET NOCOUNT ON;

TRUNCATE TABLE dbo.Rank_SpaceTime_Day
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_QueryStats_INS]
	@iServerSetID	TINYINT
,	@strQueryName	NVARCHAR(70)
,	@iMinTime		INT
,	@iAvgTime		INT
,	@iMaxTime		INT
,	@iOver1Sec		SMALLINT
,	@iQueryCnt		INT
,	@iQueryFail		SMALLINT

AS
SET NOCOUNT ON;


INSERT INTO dbo.QueryStats (QueryName, MinTime, AvgTime, MaxTime, Over1Sec, QueryCnt, QueryFail, RegDate)
	SELECT @strQueryName, @iMinTime, @iAvgTime, @iMaxTime, @iOver1Sec, @iQueryCnt, @iQueryFail, GETDATE()
GO
CREATE OR ALTER PROCEDURE [dbo].[P_Manager_Unit_Restore_UPD]
	@UnitUID	BIGINT
AS
SET NOCOUNT ON

UPDATE [Statistics].dbo.UnitStatistics 
SET deleted = 0 
WHERE UnitUID = @UnitUID
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2011.07.27
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LUnitPVPLog_INS]
	@iServerSetID		TINYINT,
	@iArenaUID			BIGINT,		-- 대전 고유 번호
	@iMatchType			TINYINT,	-- 대전 타입(11: 1대1 팀매치, 12: 2대2 팀매치, 13: 3대3 팀매치, 21: 1대1 데스매치, 22: 2대2 데스매치, 23: 3대3 데스매치
	@iPvpType			TINYINT,	-- 0: 해당없음, 1: 초보자 NPC, 2: 영웅 NPC
	@iUnitUID			BIGINT,
	@strNickName		NVARCHAR(16),
	@iLv				TINYINT,
	@iUnitClass			TINYINT,
	@iRating			INT,
	@iRank				TINYINT,	-- 10: 1번째 낮은 단계, 20: 2번째 낮은 단계, 30: 3번째 낮은 단계, 40: 4번째 낮은 단계, 50: 5번째 낮은 단계, 60: 6번째 낮은 단계, 
	@iRPoint			INT,		-- 랭크 포인트 보유량
	@iAPoint			INT,		-- 아레나 포인트 보유량
	@iOfficialMatchCnt	INT,		-- 총 공식대전 플레이 횟수
	@iTeam				TINYINT,	-- 1: 레드팀, 2: 블루팀
	@bPartyApp			BIT,		-- 파티로 신청하였는지 여부
	@iWaitTime			SMALLINT,	-- 신청 후 대전 시작까지 대기 시간(초)
	@iWin				TINYINT,	-- 0: 패, 1: 승, 2: 비정상 종료
	@iEndType			SMALLINT,	-- 주석 따로..
	@iplayTime			SMALLINT,
	@iKill				TINYINT,
	@iAssist			TINYINT,
	@iDeath				TINYINT,
	@iNetRatingInc		SMALLINT,	-- rating 획득량
	@iNetRPInc			SMALLINT,	-- RPoint 증감
	@iNetAPInc			SMALLINT,	-- APoint 획득량
	@iEXPearned			INT,		-- 대전을 통해 획득한 경험치
	@sdtRegDate			SMALLDATETIME,
	@iOK [int] = 0

/*-------------------------------------
	# EndType

0	대전시작 30초 이내 이탈로 종료 처리
1	Kill 수 충족으로 정상 종료
2	대전 시간 종료로 정상 종료
3	상대 모두 이탈로 종료
4	자신의 이탈로 종료
5	기타
--------------------------------------*/

AS
SET NOCOUNT ON;

BEGIN TRAN

	INSERT INTO dbo.LUnitPVPLog (ArenaUID, MatchType, PvpType, UnitUID, NickName, Lv, UnitClass, Rating, [Rank], RPoint, APoint, OfficialMatchCnt,
					Team, PartyApp, WaitTime, Win, EndType, playTime, [Kill], Assist, Death, NetRatingInc, NetRPInc, NetAPInc, EXPearned, RegDate)
	    SELECT @iArenaUID, @iMatchType, @iPvpType, @iUnitUID, @strNickName, @iLv, @iUnitClass, @iRating, @iRank, @iRPoint, @iAPoint,
					@iOfficialMatchCnt, @iTeam, @bPartyApp, @iWaitTime, @iWin, @iEndType, @iplayTime, @iKill, @iAssist, @iDeath,
					@iNetRatingInc, @iNetRPInc, @iNetAPInc, @iEXPearned, @sdtRegDate		   
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LUnitDailyPlay_INT]
	@iServerSetID	TINYINT
,	@RegDate					char(8)
,	@UnitUID					bigint
,	@AuthLevel					tinyint
,	@UseSpirit					int
,	@AllSpirit					bit
,	@TotalPlayTime				int
,	@DurationTime				int
,	@DSoloCnt					int
,	@DPartyCnt					int
,	@DSWCnt						int
,	@DPWCnt						int
,	@DSPlayTime					int
,	@DPPlayTime					int
,	@VsKillCnt					smallint
,	@VsWinCnt					smallint
,	@VsLoseCnt					int
,	@VsPlayTime					int
,	@TrainingPT					int
,	@TrainingCnt				smallint
,	@P2PCnt						smallint
,	@SquareCnt					smallint
,	@SquarePlayTime				int
,	@BuyItemCnt					smallint
,	@SellItemCnt				smallint
,	@GetItemCnt					smallint
,	@PCBangFlag					bit
,	@UseStone					smallint
AS
	SET NOCOUNT ON

	IF EXISTS (SELECT * FROM dbo.LUnitDailyPlay WITH(NOLOCK) WHERE RegDate = @Regdate AND UnitUID = @UnitUID) BEGIN
		UPDATE dbo.LUnitDailyPlay
		SET AuthLevel			= CASE WHEN AuthLevel > @AuthLevel THEN AuthLevel ELSE @AuthLevel END
		,	UseSpirit			= UseSpirit + @UseSpirit
		,	AllSpirit			= CASE WHEN AllSpirit = 1 THEN 1 ELSE @AllSpirit END
		,	TotalPlayTime		= TotalPlayTime + @TotalPlayTime
		,	DurationTime		= DurationTime + @DurationTime
		,	DSoloCnt			= DSoloCnt + @DSoloCnt
		,	DPartyCnt			= DPartyCnt + @DPartyCnt
		,	DSWCnt				= DSWCnt + @DSWCnt
		,	DPWCnt				= DPWCnt + @DPWCnt
		,	DSPlayTime			= DSPlayTime + @DSPlayTime
		,	DPPlayTime			= DPPlayTime + @DPPlayTime
		,	VsKillCnt			= VsKillCnt + @VsKillCnt
		,	VsWinCnt			= VsWinCnt + @VsWinCnt
		,	VsLoseCnt			= VsLoseCnt + @VsLoseCnt
		,	VsPlayTime			= VsPlayTime + @VsPlayTime
		,	TrainingPT			= TrainingPT + @TrainingPT
		,	TrainingCnt			= TrainingCnt + @TrainingCnt
		,	P2PCnt				= P2PCnt + @P2PCnt
		,	SquareCnt			= SquareCnt + @SquareCnt
		,	SquarePlayTime		= SquarePlayTime + @SquarePlayTime
		,	BuyItemCnt			= BuyItemCnt + @BuyItemCnt
		,	SellItemCnt			= SellItemCnt + @SellItemCnt
		,	GetItemCnt			= GetItemCnt + @GetItemCnt
		,	PCBangFlag			= CASE WHEN PCBangFlag = 1 THEN 1 ELSE @PCBangFlag END
		,	UseStone			= UseStone + @UseStone
		WHERE RegDate = @Regdate AND UnitUID = @UnitUID
	END
	ELSE BEGIN
		INSERT INTO dbo.LUnitDailyPlay ( RegDate, UnitUID, AuthLevel, UseSpirit, AllSpirit, TotalPlayTime, DurationTime, DSoloCnt, DPartyCnt, DSWCnt, DPWCnt, DSPlayTime, DPPlayTime, VsKillCnt, VsWinCnt, VsLoseCnt, VsPlayTime, TrainingPT, TrainingCnt, P2PCnt, SquareCnt, SquarePlayTime, BuyItemCnt, SellItemCnt, GetItemCnt, PCBangFlag, UseStone )
		VALUES ( @RegDate, @UnitUID, @AuthLevel, @UseSpirit, @AllSpirit, @TotalPlayTime, @DurationTime, @DSoloCnt, @DPartyCnt, @DSWCnt, @DPWCnt, @DSPlayTime, @DPPlayTime, @VsKillCnt, @VsWinCnt, @VsLoseCnt, @VsPlayTime, @TrainingPT, @TrainingCnt, @P2PCnt, @SquareCnt, @SquarePlayTime, @BuyItemCnt, @SellItemCnt, @GetItemCnt, @PCBangFlag, @UseStone )
	END
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LUnitDailyPlay_INS]
	@iServerSetID	TINYINT
,	@RegDate					char(8)
,	@UnitUID					bigint
,	@AuthLevel					tinyint
,	@UseSpirit					int
,	@AllSpirit					bit
,	@TotalPlayTime				int
,	@DurationTime				int
,	@DSoloCnt					int
,	@DPartyCnt					int
,	@DSWCnt						int
,	@DPWCnt						int
,	@DSPlayTime					int
,	@DPPlayTime					int
,	@VsKillCnt					smallint
,	@VsWinCnt					smallint
,	@VsLoseCnt					int
,	@VsPlayTime					int
,	@TrainingPT					int
,	@TrainingCnt				smallint
,	@P2PCnt						smallint
,	@SquareCnt					smallint
,	@SquarePlayTime				int
,	@BuyItemCnt					smallint
,	@SellItemCnt				smallint
,	@GetItemCnt					smallint
,	@PCBangFlag					bit
,	@UseStone					smallint
AS
	SET NOCOUNT ON

	IF EXISTS (SELECT * FROM dbo.LUnitDailyPlay WITH(NOLOCK) WHERE RegDate = @Regdate AND UnitUID = @UnitUID) BEGIN
		UPDATE dbo.LUnitDailyPlay
		SET AuthLevel			= CASE WHEN AuthLevel > @AuthLevel THEN AuthLevel ELSE @AuthLevel END
		,	UseSpirit			= UseSpirit + @UseSpirit
		,	AllSpirit			= CASE WHEN AllSpirit = 1 THEN 1 ELSE @AllSpirit END
		,	TotalPlayTime		= TotalPlayTime + @TotalPlayTime
		,	DurationTime		= DurationTime + @DurationTime
		,	DSoloCnt			= DSoloCnt + @DSoloCnt
		,	DPartyCnt			= DPartyCnt + @DPartyCnt
		,	DSWCnt				= DSWCnt + @DSWCnt
		,	DPWCnt				= DPWCnt + @DPWCnt
		,	DSPlayTime			= DSPlayTime + @DSPlayTime
		,	DPPlayTime			= DPPlayTime + @DPPlayTime
		,	VsKillCnt			= VsKillCnt + @VsKillCnt
		,	VsWinCnt			= VsWinCnt + @VsWinCnt
		,	VsLoseCnt			= VsLoseCnt + @VsLoseCnt
		,	VsPlayTime			= VsPlayTime + @VsPlayTime
		,	TrainingPT			= TrainingPT + @TrainingPT
		,	TrainingCnt			= TrainingCnt + @TrainingCnt
		,	P2PCnt				= P2PCnt + @P2PCnt
		,	SquareCnt			= SquareCnt + @SquareCnt
		,	SquarePlayTime		= SquarePlayTime + @SquarePlayTime
		,	BuyItemCnt			= BuyItemCnt + @BuyItemCnt
		,	SellItemCnt			= SellItemCnt + @SellItemCnt
		,	GetItemCnt			= GetItemCnt + @GetItemCnt
		,	PCBangFlag			= CASE WHEN PCBangFlag = 1 THEN 1 ELSE @PCBangFlag END
		,	UseStone			= UseStone + @UseStone
		WHERE RegDate = @Regdate AND UnitUID = @UnitUID
	END
	ELSE BEGIN
		INSERT INTO dbo.LUnitDailyPlay ( RegDate, UnitUID, AuthLevel, UseSpirit, AllSpirit, TotalPlayTime, DurationTime, DSoloCnt, DPartyCnt, DSWCnt, DPWCnt, DSPlayTime, DPPlayTime, VsKillCnt, VsWinCnt, VsLoseCnt, VsPlayTime, TrainingPT, TrainingCnt, P2PCnt, SquareCnt, SquarePlayTime, BuyItemCnt, SellItemCnt, GetItemCnt, PCBangFlag, UseStone )
		VALUES ( @RegDate, @UnitUID, @AuthLevel, @UseSpirit, @AllSpirit, @TotalPlayTime, @DurationTime, @DSoloCnt, @DPartyCnt, @DSWCnt, @DPWCnt, @DSPlayTime, @DPPlayTime, @VsKillCnt, @VsWinCnt, @VsLoseCnt, @VsPlayTime, @TrainingPT, @TrainingCnt, @P2PCnt, @SquareCnt, @SquarePlayTime, @BuyItemCnt, @SellItemCnt, @GetItemCnt, @PCBangFlag, @UseStone )
	END
GO
CREATE OR ALTER PROCEDURE [dbo].[P_LUnitDailyGamePoint_INT]
	@Regdate					char(8)
,	@UnitUID					bigint
,	@PTotal						bigint
,	@MTotal						bigint
,	@TotalDiff					int
,	@PDungeon					int
,	@PTraining					int
,	@PQuest						int
,	@PItemSell					int
,	@PItemTrade					bigint
,	@PPersonalShop				bigint
,	@PPostLetter				bigint
,	@MItemBuy					int
,	@MItemTrade					bigint
,	@MItemRepair				int
,	@MItemEnchant				bigint
,	@MItemSocket				int
,	@MItemAttribute				int
,	@MManufacture				int
,	@MDunPenalty				int
,	@MPersonalShop				bigint
,	@MOpenPShop					bigint
,	@MSellTaxPShop				int
,	@MBuyTaxPShop				int
,	@MPostLetter				bigint
,	@MSendLetterBasic			int
,	@MSendLetterItem			int
,	@MOpenCubeSpendED			bigint				-- ED로 큐브오픈/2012.12.06 패치
,	@PBattleFieldED				bigint				-- 배틀필드에서 획득한 ED/2013.05.09 패치
,	@MCoboExpressTicketED		bigint				-- 코보티켓 지역이동으로 소모한 ED/2013.05.09 패치
,	@MItemDecom					bigint				-- 일본 분해 ED
AS
	SET NOCOUNT ON

	IF EXISTS (SELECT * FROM dbo.LUnitDailyGamePoint WITH(NOLOCK) WHERE RegDate = @Regdate AND UnitUID = @UnitUID) BEGIN
		UPDATE dbo.LUnitDailyGamePoint
		SET PTotal				= PTotal + @PTotal
		,	MTotal				= MTotal + @MTotal
		,	TotalDiff			= TotalDiff + @TotalDiff
		,	PDungeon			= PDungeon + @PDungeon
		,	PTraining			= PTraining + @PTraining
		,	PQuest				= PQuest + @PQuest
		,	PItemSell			= PItemSell + @PItemSell
		,	PItemTrade			= PItemTrade + @PItemTrade
		,	PPersonalShop		= PPersonalShop + @PPersonalShop
		,	PPostLetter			= PPostLetter + @PPostLetter
		,	MItemBuy			= MItemBuy + @MItemBuy
		,	MItemTrade			= MItemTrade + @MItemTrade
		,	MItemRepair			= MItemRepair + @MItemRepair
		,	MItemEnchant		= MItemEnchant + @MItemEnchant
		,	MItemSocket			= MItemSocket + @MItemSocket
		,	MItemAttribute		= MItemAttribute + @MItemAttribute
		,	MManufacture		= MManufacture + @MManufacture
		,	MDunPenalty			= MDunPenalty + @MDunPenalty
		,	MPersonalShop		= MPersonalShop + @MPersonalShop
		,	MOpenPShop			= MOpenPShop + @MOpenPShop
		,	MSellTaxPShop		= MSellTaxPShop + @MSellTaxPShop
		,	MBuyTaxPShop		= MBuyTaxPShop + @MBuyTaxPShop
		,	MPostLetter			= MPostLetter + @MPostLetter
		,	MSendLetterBasic	= MSendLetterBasic + @MSendLetterBasic
		,	MSendLetterItem		= MSendLetterItem + @MSendLetterItem
		,	MOpenCubeSpendED	= MOpenCubeSpendED + @MOpenCubeSpendED
		,	PBattleFieldED		= PBattleFieldED + @PBattleFieldED
		,	MCoboExpressTicketED = MCoboExpressTicketED + @MCoboExpressTicketED
		,	MItemDecom			= MCoboExpressTicketED + @MCoboExpressTicketED
		WHERE RegDate = @Regdate AND UnitUID = @UnitUID
	END
	ELSE BEGIN
		INSERT INTO dbo.LUnitDailyGamePoint ( RegDate, UnitUID, PTotal, MTotal, TotalDiff, PDungeon, PTraining, PQuest, PItemSell, PItemTrade, PPersonalShop, PPostLetter, MItemBuy, MItemTrade, MItemRepair, MItemEnchant, MItemSocket, MItemAttribute, MManufacture, MDunPenalty, MPersonalShop, MOpenPShop, MSellTaxPShop, MBuyTaxPShop, MPostLetter, MSendLetterBasic, MSendLetterItem, MOpenCubeSpendED, PBattleFieldED, MCoboExpressTicketED, MItemDecom )
		VALUES ( @RegDate, @UnitUID, @PTotal, @MTotal, @TotalDiff, @PDungeon, @PTraining, @PQuest, @PItemSell, @PItemTrade, @PPersonalShop, @PPostLetter, @MItemBuy, @MItemTrade, @MItemRepair, @MItemEnchant, @MItemSocket, @MItemAttribute, @MManufacture, @MDunPenalty, @MPersonalShop, @MOpenPShop, @MSellTaxPShop, @MBuyTaxPShop, @MPostLetter, @MSendLetterBasic, @MSendLetterItem, @MOpenCubeSpendED, @PBattleFieldED, @MCoboExpressTicketED, @MItemDecom )
	END
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LUnitDailyGamePoint_INS]
	@iServerSetID	TINYINT
,	@Regdate					char(8)
,	@UnitUID					bigint
,	@PTotal						bigint
,	@MTotal						bigint
,	@TotalDiff					int
,	@PDungeon					int
,	@PTraining					int
,	@PQuest						int
,	@PItemSell					int
,	@PItemTrade					bigint
,	@PPersonalShop				bigint
,	@PPostLetter				bigint
,	@MItemBuy					int
,	@MItemTrade					bigint
,	@MItemRepair				int
,	@MItemEnchant				bigint
,	@MItemSocket				int
,	@MItemAttribute				int
,	@MManufacture				int
,	@MDunPenalty				int
,	@MPersonalShop				bigint
,	@MOpenPShop					bigint
,	@MSellTaxPShop				int
,	@MBuyTaxPShop				int
,	@MPostLetter				bigint
,	@MSendLetterBasic			int
,	@MSendLetterItem			int
,	@MOpenCubeSpendED			bigint				-- ED로 큐브오픈/2012.12.06 패치
,	@PBattleFieldED				bigint				-- 배틀필드에서 획득한 ED/2013.05.09 패치
,	@MCoboExpressTicketED		bigint				-- 코보티켓 지역이동으로 소모한 ED/2013.05.09 패치
,	@MItemDecom					bigint				-- 일본 분해 ED
AS
	SET NOCOUNT ON

	IF EXISTS (SELECT * FROM dbo.LUnitDailyGamePoint WITH(NOLOCK) WHERE RegDate = @Regdate AND UnitUID = @UnitUID) BEGIN
		UPDATE dbo.LUnitDailyGamePoint
		SET PTotal				= PTotal + @PTotal
		,	MTotal				= MTotal + @MTotal
		,	TotalDiff			= TotalDiff + @TotalDiff
		,	PDungeon			= PDungeon + @PDungeon
		,	PTraining			= PTraining + @PTraining
		,	PQuest				= PQuest + @PQuest
		,	PItemSell			= PItemSell + @PItemSell
		,	PItemTrade			= PItemTrade + @PItemTrade
		,	PPersonalShop		= PPersonalShop + @PPersonalShop
		,	PPostLetter			= PPostLetter + @PPostLetter
		,	MItemBuy			= MItemBuy + @MItemBuy
		,	MItemTrade			= MItemTrade + @MItemTrade
		,	MItemRepair			= MItemRepair + @MItemRepair
		,	MItemEnchant		= MItemEnchant + @MItemEnchant
		,	MItemSocket			= MItemSocket + @MItemSocket
		,	MItemAttribute		= MItemAttribute + @MItemAttribute
		,	MManufacture		= MManufacture + @MManufacture
		,	MDunPenalty			= MDunPenalty + @MDunPenalty
		,	MPersonalShop		= MPersonalShop + @MPersonalShop
		,	MOpenPShop			= MOpenPShop + @MOpenPShop
		,	MSellTaxPShop		= MSellTaxPShop + @MSellTaxPShop
		,	MBuyTaxPShop		= MBuyTaxPShop + @MBuyTaxPShop
		,	MPostLetter			= MPostLetter + @MPostLetter
		,	MSendLetterBasic	= MSendLetterBasic + @MSendLetterBasic
		,	MSendLetterItem		= MSendLetterItem + @MSendLetterItem
		,	MOpenCubeSpendED	= MOpenCubeSpendED + @MOpenCubeSpendED
		,	PBattleFieldED		= PBattleFieldED + @PBattleFieldED
		,	MCoboExpressTicketED = MCoboExpressTicketED + @MCoboExpressTicketED
		,	MItemDecom			= MCoboExpressTicketED + @MCoboExpressTicketED
		WHERE RegDate = @Regdate AND UnitUID = @UnitUID
	END
	ELSE BEGIN
		INSERT INTO dbo.LUnitDailyGamePoint ( RegDate, UnitUID, PTotal, MTotal, TotalDiff, PDungeon, PTraining, PQuest, PItemSell, PItemTrade, PPersonalShop, PPostLetter, MItemBuy, MItemTrade, MItemRepair, MItemEnchant, MItemSocket, MItemAttribute, MManufacture, MDunPenalty, MPersonalShop, MOpenPShop, MSellTaxPShop, MBuyTaxPShop, MPostLetter, MSendLetterBasic, MSendLetterItem, MOpenCubeSpendED, PBattleFieldED, MCoboExpressTicketED, MItemDecom )
		VALUES ( @RegDate, @UnitUID, @PTotal, @MTotal, @TotalDiff, @PDungeon, @PTraining, @PQuest, @PItemSell, @PItemTrade, @PPersonalShop, @PPostLetter, @MItemBuy, @MItemTrade, @MItemRepair, @MItemEnchant, @MItemSocket, @MItemAttribute, @MManufacture, @MDunPenalty, @MPersonalShop, @MOpenPShop, @MSellTaxPShop, @MBuyTaxPShop, @MPostLetter, @MSendLetterBasic, @MSendLetterItem, @MOpenCubeSpendED, @PBattleFieldED, @MCoboExpressTicketED, @MItemDecom )
	END
GO
CREATE OR ALTER PROCEDURE [dbo].[P_LUnitConnectLog_INT]
	@ServerUID				int
,	@UnitUID				bigint
,	@NickName				nvarchar(40)
,	@UnitClass				tinyint
,	@Exp					int
,	@Level					tinyint
,	@logintime				datetime
,	@logouttime				datetime
,	@PlayTime				int
,	@PCBangFlag				bit
,	@AuthLevel				tinyint
,	@loginLevel				tinyint
AS
	SET NOCOUNT ON

	INSERT INTO dbo.LUnitConnectLog ( ServerUID, UnitUID, NickName, UnitClass, [Exp], [Level], logintime, logouttime, PlayTime, PCBangFlag, AuthLevel, loginLevel )
	VALUES ( @ServerUID, @UnitUID, @NickName, @UnitClass, @Exp, @Level, @logintime, @logouttime, @PlayTime, @PCBangFlag, @AuthLevel, @loginLevel )
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LUnitConnectLog_INS]
	@iServerSetID			TINYINT
,	@ServerUID				int
,	@UnitUID				bigint
,	@NickName				nvarchar(40)
,	@UnitClass				tinyint
,	@Exp					int
,	@Level					tinyint
,	@logintime				datetime
,	@logouttime				datetime
,	@PlayTime				int
,	@PCBangFlag				bit
,	@AuthLevel				tinyint
,	@loginLevel				tinyint
AS
	SET NOCOUNT ON

	INSERT INTO dbo.LUnitConnectLog ( ServerUID, UnitUID, NickName, UnitClass, [Exp], [Level], logintime, logouttime, PlayTime, PCBangFlag, AuthLevel, loginLevel )
	VALUES ( @ServerUID, @UnitUID, @NickName, @UnitClass, @Exp, @Level, @logintime, @logouttime, @PlayTime, @PCBangFlag, @AuthLevel, @loginLevel )
GO
CREATE OR ALTER PROCEDURE [dbo].[P_LUDPRelayCheck_INT]
	@UID			int
,	@IP				nvarchar(15)
,	@AvgDelayTime	int
,	@MaxDelayTime	int
,	@RegDate		smalldatetime
AS
	SET NOCOUNT ON
/*
	게임서버 UDP Relay 서버 지연 로그(배틀필드를 위한 정보 수집)
*/
	DECLARE @Result		int
	
	BEGIN TRY
		BEGIN TRAN

		INSERT INTO	dbo.LUDPRelayCheck ( UID, IP, AvgDelayTime, MaxDelayTime, RegDate )
		VALUES ( @UID, @IP, @AvgDelayTime, @MaxDelayTime, @RegDate  )

		COMMIT TRAN

		SET @Result = 0
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

		SET @Result = -1
	END CATCH

	SELECT @Result
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 게임서버 UDP Relay 서버 지연 로그(배틀필드를 위한 정보 수집)
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LUDPRelayCheck_INS]
	@iServerSetID		TINYINT
,	@UID			int
,	@IP				nvarchar(15)
,	@AvgDelayTime	int
,	@MaxDelayTime	int
,	@RegDate		smalldatetime
AS
	SET NOCOUNT ON

	DECLARE @Result		int
	
	BEGIN TRY
		BEGIN TRAN

		INSERT INTO	dbo.LUDPRelayCheck ( UID, IP, AvgDelayTime, MaxDelayTime, RegDate )
		VALUES ( @UID, @IP, @AvgDelayTime, @MaxDelayTime, @RegDate  )

		COMMIT TRAN

		SET @Result = 0
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

		SET @Result = -1
	END CATCH

	SELECT @Result
GO
-- =============================================
-- Author:		KOG. B.K
-- Create date: 2011. 10.18
-- Description:	내 캐릭터간 은행 거래 로그
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LTradeBank_INT]
	@ServerSetID	tinyint		
,	@FromUnitUID    bigint		
,	@ToUnitUID      bigint		
,	@FromItemUID    bigint		
,	@ToItemUID      bigint		
,	@ItemID         int			
,	@SealCnt        int			

AS
SET NOCOUNT ON

	DECLARE @RegDate SMALLDATETIME
	
	SET @RegDate = GETDATE()
	
	INSERT INTO dbo.LTradeBank ( ServerSetID, FromUnitUID, ToUnitUID, FromItemUID, ToItemUID, ItemID, SealCnt, RegDate )
	VALUES ( @ServerSetID, @FromUnitUID, @ToUnitUID, @FromItemUID, @ToItemUID, @ItemID, @SealCnt, @RegDate )
	
	RETURN @@ERROR
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LTrade_INS]
	@iServerSetID	TINYINT	,
    @iFromUserUID   [bigint],
    @iFromUnitUID   [bigint],
    @iToUserUID     [bigint],
    @iToUnitUID     [bigint],
    @iItemUID       [bigint],
    @iItemID        [int],
    @iQuantity      [int],
    @iOK            [int] = 0
AS

SET NOCOUNT ON;

BEGIN TRAN
    INSERT INTO dbo.LTrade(ServerSetID, FromUserUID, FromUnitUID, ToUserUID, ToUnitUID, ItemUID, ItemID, Quantity, RegDate )
    SELECT @iServerSetID, @iFromUserUID, @iFromUnitUID, @iToUserUID, @iToUnitUID, @iItemUID, @iItemID, @iQuantity, GetDate()
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
    BEGIN
        SELECT @iOK = -1
        GOTO FAIL_TRAN
    END    
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LToolServerList_SEL]
	@iServerSetID	TINYINT
AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

SELECT  ServerUID,
		ServerSetID,
		ServerType,
		ChannelID,
		ChannelName,
		IP,
		Port
    FROM dbo.LToolServerList WITH (NOLOCK)
	ORDER BY ChannelID
GO
-- =============================================
-- Author: KIM
-- Create date: 2012-04-09
-- Description:	현재 미 삭제 캐릭터 전체 ED 보유량 저장
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LStatsDailyRemainMoney_INT]
	@RegDate		char(10)
,	@TotalRemain	bigint
,	@AvgRemain		bigint
,	@UserAvgRemain	bigint
,	@ServerSetID	tinyint
AS
	SET NOCOUNT ON

	DELETE dbo.LStatsDailyRemainMoney
	WHERE ServerSetID = @ServerSetID AND RegDate = @RegDate

	INSERT INTO dbo.LStatsDailyRemainMoney ( ServerSetID, RegDate, TotalRemain, AvgRemain, UserAvgRemain )
	VALUES ( @ServerSetID, @RegDate, @TotalRemain, @AvgRemain, @UserAvgRemain )
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LSquareTable_SEL]
	@iServerSetID	TINYINT
,	@strServerIP	NVARCHAR(20)

AS
SET NOCOUNT ON;

SELECT [Type], [NAME]
	FROM dbo.LSquareTable WITH (NOLOCK)
		WHERE IP = @strServerIP
GO
CREATE OR ALTER PROCEDURE [dbo].[P_LSkillPointLog_INT]
	@ServerGroupID int ,
	@UserUID		bigint,
	@UnitUID		bigint,
	@UnitClass	int,
	@Level		int,
	@SPoint		int,
	@UsedSPoint	int,
	@CSPoint		int,
	@UsedCSPoint	int,
	@MaxCSPoint  int,
	@CorrectionSP int

AS
	SET NOCOUNT ON
	
-- =============================================
-- Author:  EJ
-- Create date: 
-- Description: 레벨에 비정상적은 SP를 가진 유저에 대해 SP 지급하는 로그
-- =============================================

	DECLARE @Result		int

	BEGIN TRY
		BEGIN TRAN

		INSERT INTO	dbo.LSkillPointLog ( ServerGroupID, UserUID, UnitUID, UnitClass, Level, SPoint, UsedSPoint, 
			CSPoint, UsedCSPoint, MaxCSPoint, CorrectionSP, Regdate	)
		SELECT @ServerGroupID, @UserUID, @UnitUID, @UnitClass, @Level, @SPoint, @UsedSPoint, 
			@CSPoint, @UsedCSPoint, @MaxCSPoint, @CorrectionSP, GETDATE()

		COMMIT TRAN

		SET @Result = 0
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

		SET @Result = -1
	END CATCH

	SELECT @Result
GO
-- =============================================
-- Author:		HWANG
-- Create date: 2013.02.13
-- Description:	각 게임서버들의 SimLayer Tick 퍼포먼스 정보를 DB에 로그로 남김
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LServerSimLayerTickLog_SET]
	@iServerSetID		TINYINT
,	@ServerUID		bigint
,	@ServerType		tinyint
,	@MaxTickCount	int
,	@MaxTickRegDate	smalldatetime
,	@RegDate		smalldatetime

AS
	SET NOCOUNT ON;
	
	DECLARE @Result		int
	
	BEGIN TRY
		BEGIN TRAN
		
			SET @Result = -1
			
			INSERT INTO	dbo.LServerSimLayerTickLog ( ServerUID, ServerType, MaxTickCount, MaxTickRegDate, RegDate )
			VALUES ( @ServerUID, @ServerType, @MaxTickCount, @MaxTickRegDate, @RegDate )
			
		COMMIT TRAN

		SET @Result = 0
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE
		
		IF @Result = 0 OR @Result IS NULL
			SET @Result = -3
	END CATCH
	
	SELECT @Result
GO
-- =============================================
-- Author:		HWANG
-- Create date: 2013.02.13
-- Description:	각 게임서버들의 SimLayer Tick 퍼포먼스 정보를 DB에 로그로 남김
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LServerSimLayerTickLog_INS]
	@iServerSetID	TINYINT
,	@ServerUID		bigint
,	@ServerType		tinyint
,	@MaxTickCount	int
,	@MaxTickRegDate	smalldatetime
,	@RegDate		smalldatetime

AS
	SET NOCOUNT ON;
	
	DECLARE @Result		int
	
	BEGIN TRY
		BEGIN TRAN
		
			SET @Result = -1
			
			INSERT INTO	dbo.LServerSimLayerTickLog ( ServerUID, ServerType, MaxTickCount, MaxTickRegDate, RegDate )
			VALUES ( @ServerUID, @ServerType, @MaxTickCount, @MaxTickRegDate, @RegDate )
			
		COMMIT TRAN

		SET @Result = 0
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE
		
		IF @Result = 0 OR @Result IS NULL
			SET @Result = -3
	END CATCH
	
	SELECT @Result
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LServerList_Verify_On_SEL]
	@iServerSetID		TINYINT
,	@iServerType	TINYINT
,	@strServerIP	NVARCHAR(15)

AS
SET NOCOUNT ON;

SELECT [UID], [Name], ServerSetID, ServerType, IP, Port1, Port2, MaxConcurrentUser, ConcurrentUser, [Enable], ServerRollType 
   FROM dbo.LServerList WITH (NOLOCK)
		WHERE ServerType = @iServerType AND IP = @strServerIP
GO
-- =============================================
-- Author:		
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LServerList_Verify_Connect_SEL]
	@iServerSetID	TINYINT	= 0
,	@iServerType	TINYINT
,	@strServerIP	NVARCHAR(15)
,	@iPort1			SMALLINT
,	@iInternal		TINYINT
AS
SET NOCOUNT ON;

IF @iServerType = 0 
BEGIN
	SELECT [UID], ServerSetID, [Name], MaxConcurrentUser, ServerType
	FROM dbo.LServerList WITH (NOLOCK)
	WHERE 1 = (CASE WHEN @iInternal = 0 AND PublicIP = @strServerIP THEN 1 
				WHEN @iInternal = 1 AND PrivateIP = @strServerIP THEN 1 
			ELSE 0 END)
	AND Port1 = @iPort1
END
ELSE
BEGIN
	SELECT [UID], ServerSetID, [Name], MaxConcurrentUser, ServerType
	FROM dbo.LServerList WITH (NOLOCK)
	WHERE ServerType = @iServerType 
	AND 1 = (CASE WHEN @iInternal = 0 AND PublicIP = @strServerIP THEN 1 
				WHEN @iInternal = 1 AND PrivateIP = @strServerIP THEN 1 
			ELSE 0 END)
	AND Port1 = @iPort1
END
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LServerList_UPD]
	@iServerSetID	TINYINT	,	
	@iUID_ [int],
	@bFlag_ [bit],
	@iOK [int] = 0
AS
SET NOCOUNT ON;

IF NOT EXISTS(SELECT * FROM dbo.LServerList WITH (NOLOCK) WHERE UID = @iUID_)
    BEGIN    SELECT @iOK = -1    GOTO END_PROC    END

BEGIN TRAN
    UPDATE dbo.LServerList WITH(ROWLOCK)
        SET [Enable] = @bFlag_
,           ConcurrentUser = CASE @bFlag_ WHEN 1 THEN ConcurrentUser ELSE 0 END
            WHERE UID = @iUID_
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
        BEGIN    SELECT @iOK = -11    GOTO FAIL_TRAN    END
COMMIT TRAN
GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LServerList_SEL]
	@iServerSetID	TINYINT
AS
SET NOCOUNT ON;

SELECT  [UID]
,       [Name]
,       ServerSetID
,       ServerType
,       IP
,       Port1
,       Port2
,       MaxConcurrentUser
,       ConcurrentUser
,       [Enable]
    FROM dbo.LServerList WITH (NOLOCK)
GO
CREATE OR ALTER PROCEDURE [dbo].[P_LServerList_GET_verify_PublicIP]
	@iServerType	TINYINT
,	@strServerIP	NVARCHAR(15)
-- =============================================
-- Author:		Hwang
-- Create date: 2013.01.18
-- Description:	해당 서버가 실제 존재하는지 인증하는 SP
-- =============================================
AS
SET NOCOUNT ON;

SELECT [UID], [Name], ServerSetID, ServerType, PublicIP, PrivateIP, Port1, Port2, MaxConcurrentUser, ConcurrentUser, [Enable], ServerRollType 
   FROM dbo.LServerList WITH (NOLOCK)
		WHERE ServerType = @iServerType AND PublicIP = @strServerIP
GO
CREATE OR ALTER PROCEDURE [dbo].[P_LServerList_GET_verify_connect]
       @iServerType TINYINT
,      @strServerIP NVARCHAR(15)
,      @iPort1      SMALLINT

AS
SET NOCOUNT ON;

SELECT [UID], ServerSetID, [Name], MaxConcurrentUser
       FROM dbo.LServerList WITH (NOLOCK)
             WHERE ServerType = @iServerType AND PrivateIP = @strServerIP AND Port1 = @iPort1
GO
CREATE OR ALTER PROCEDURE [dbo].[P_LServerList_GET_login_proxyinfo]
	@iServerGroupID		TINYINT

AS
SET NOCOUNT ON;

	SELECT A.ProxyID, B.PrivateIP, B.Port1
	FROM dbo.LLoginProxy AS A WITH (NOLOCK) 
	JOIN dbo.LServerList AS B WITH (NOLOCK)
		ON A.ServerSetID = B.ServerSetID AND A.ServerUID = B.UID
	WHERE A.ServerSetID = @iServerGroupID
	ORDER BY A.ProxyID ASC
GO
CREATE OR ALTER PROCEDURE [dbo].[P_LServerList_GET_global_proxyinfo]
	@iServerGroupID		TINYINT

AS
SET NOCOUNT ON;

	SELECT A.ProxyID, B.PrivateIP, B.Port1
	FROM dbo.LGlobalProxy AS A WITH (NOLOCK)
	JOIN dbo.LServerList AS B WITH (NOLOCK)
		ON A.ServerSetID = B.ServerSetID AND A.ServerUID = B.UID
	WHERE A.ServerSetID = @iServerGroupID 
	ORDER BY A.ProxyID ASC
GO
CREATE OR ALTER PROCEDURE [dbo].[P_LServerList_GET_center_proxyinfo]
	@iServerGroupID		TINYINT

AS
SET NOCOUNT ON;

	SELECT A.ProxyID, B.PrivateIP, B.Port1 
	FROM dbo.LCenterProxy AS A WITH (NOLOCK)
	JOIN dbo.LServerList AS B WITH (NOLOCK)
		ON A.ServerSetID = B.ServerSetID AND A.ServerUID = B.UID
	WHERE A.ServerSetID = @iServerGroupID 
	ORDER BY A.ProxyID ASC
GO
CREATE OR ALTER PROCEDURE [dbo].[P_LServerList_GET_byServerType]
	@ServerSetID	tinyint
,	@ServerType		tinyint

AS 
SET NOCOUNT ON

	SELECT  UID, Name, ServerSetID, ServerType, PublicIP, PrivateIP, Port1, Port2
	FROM dbo.LServerList WITH(NOLOCK)
	WHERE ServerSetID = @ServerSetID and ServerType = @ServerType
GO
CREATE OR ALTER PROCEDURE [dbo].[P_LServerList_GET_ALL]
AS
SET NOCOUNT ON;

SELECT  [UID]
,       [Name]
,       ServerSetID
,       ServerType
,		PublicIP
,		PrivateIP
,       Port1
,       Port2
,       MaxConcurrentUser
,       ConcurrentUser
,       [Enable]
    FROM dbo.LServerList WITH (NOLOCK)
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LServerList_GET]
	@ServerSetID	tinyint
,	@ServerType		tinyint

AS 
SET NOCOUNT ON

	SELECT  UID, Name, ServerSetID, ServerType, IP, Port1, Port2
	FROM dbo.LServerList WITH(NOLOCK)
	WHERE ServerSetID = @ServerSetID and ServerType = @ServerType
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 서버 동접 수치를 기록한다 (게임서버의 경우 두 곳에 해야 함)
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LServerList_CCU_UPD]
	@iServerSetID		TINYINT	
,    @sdtRegDate_		[smalldatetime]
,	@iUID_				[int]
,	@iConcurrentUser_	[int]
,	@iMakePartyCNT		[int]
,	@iPlayPartyCNT		[int]
AS
	SET NOCOUNT ON;


---- 파티 생성 카운트 값에 쓰레기 값이 넘어올 때
--IF @iMakePartyCNT < 0 OR @iMakePartyCNT > 30000
--BEGIN
--	SELECT @iMakePartyCNT = 0	
--END
---- 파티 플레이 카운트 값에 쓰레기 값이 넘어올 때
--IF @iPlayPartyCNT < 0 OR @iPlayPartyCNT > 30000
--BEGIN
--	SELECT @iPlayPartyCNT = 0	
--END



	-- UID 유효성 검사 및 서버의 타입(센터,게임여부)도 획득한다.
	DECLARE @iServerType	tinyint
	,		@iChannelOn		bit
	SELECT	@iServerType = ServerType 
		FROM dbo.LServerList WITH (NOLOCK) 
			WHERE UID = @iUID_ AND [Enable] = 1

	-- 유저에게 보이는 채널 리스트에 해당 서버가 ON/OFF 되어있는지 판단 (OFF되어있으면 업데이트 안함)
	SELECT	@iChannelOn	= Onoff
		FROM dbo.LChannelList WITH (NOLOCK)
			WHERE [UID] = @iUID_

	IF @iServerType IS NULL -- 해당 서버에 대한 데이터가 존재하지 않음
	BEGIN
		RAISERROR( 'WORK FAILED. err:%d', 16, 1, @@ERROR )
		GOTO END_PROC
	END

	BEGIN TRAN

		UPDATE dbo.LServerList
			SET ConcurrentUser = @iConcurrentUser_ 
				WHERE [UID] = @iUID_
				IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
					GOTO FAIL_TRAN
	
		IF @iServerType = 3
		BEGIN
		
			IF NOT EXISTS (SELECT * FROM StatCCUMinute WITH(NOLOCK) WHERE ServerUID = @iUID_ AND RegDate = @sdtRegDate_ AND ServerSetID = @iServerSetID)
			BEGIN
			
				INSERT INTO dbo.StatCCUMinute( RegDate, ServerUID, CCU, ServerSetID ) VALUES( @sdtRegDate_, @iUID_, @iConcurrentUser_, @iServerSetID )
				IF @@ERROR <> 0
					GOTO FAIL_TRAN
				
			END
			
		END
	  
    
		IF (@iChannelOn = 1)
		BEGIN 	
			UPDATE dbo.LChannelList
				SET ConcurrentUser	= @iConcurrentUser_
				,	MakePartyCNT	= @iMakePartyCNT
				,	PlayPartyCNT	= @iPlayPartyCNT
					WHERE [UID] = @iUID_ AND OnOff = 1
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				GOTO FAIL_TRAN
		END

	COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
RAISERROR( 'WORK FAILED. err:%d', 16, 1, @@ERROR )
ROLLBACK TRAN

END_PROC:
RETURN
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LServerList_CCU_SEL]
	@iServerSetID	TINYINT	
AS
SET NOCOUNT ON;

SELECT  SUM( ConcurrentUser )
    FROM dbo.LServerList WITH (NOLOCK)
	WHERE ServerType = 3 AND Enable = 1
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LServerList_By_ServerType_SEL]
	@ServerSetID	tinyint
,	@ServerType		tinyint

AS 
SET NOCOUNT ON

	SELECT  UID, Name, ServerSetID, ServerType, PublicIP, PrivateIP, Port1, Port2
	FROM dbo.LServerList WITH(NOLOCK)
	WHERE ServerSetID = @ServerSetID and ServerType = @ServerType
GO
-- =============================================
-- Author:		김병일
-- Create date: 2011.12.07
-- Description: Channel 서버 목록(GameServer 목록 아님 - dbo.LChannelList 와 관련 없음)
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LServerList_By_ServerSetID_SEL]
	@iServerSetID	TINYINT
AS
	SET NOCOUNT ON

	SELECT A.ServerSetOrder, A.ServerSetID, A.ServerSetName, PublicIP, Port1, Port2, [Enable]
	FROM dbo.LServerSetList AS A WITH(NOLOCK)
	JOIN dbo.LServerList AS B WITH(NOLOCK)
		ON A.ServerSetID = B.ServerSetID
	WHERE ServerType = 4 and A.ServerSetID = @iServerSetID
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.01.18
-- Description:	해당 서버가 실제 존재하는지 인증하는 SP
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LServerList_By_PublicIP_SEL]
	@iServerSetID	TINYINT
,	@iServerType	TINYINT
,	@strServerIP	NVARCHAR(15)
AS
SET NOCOUNT ON;

SELECT [UID], [Name], ServerSetID, ServerType, PublicIP, PrivateIP, Port1, Port2, MaxConcurrentUser, ConcurrentUser, [Enable], ServerRollType 
   FROM dbo.LServerList WITH (NOLOCK)
		WHERE ServerType = @iServerType AND PublicIP = @strServerIP
GO
CREATE OR ALTER PROCEDURE [dbo].[P_LServer_GSUser_Packet_Latency_INT]
	@ServerUID	int
,	@PacketID	nvarchar(50)
,	@Latency	int
,	@MaxDate	smalldatetime
,	@RegDate	smalldatetime
,	@UnitUID	bigint
AS
	SET NOCOUNT ON
/*
	게임서버에서 처리되는 패킷들중에 처리가 가장 지연되는 top 10을 골라내서 5분간격으로 로그를 남기는 것
*/
	DECLARE @Result		int

	BEGIN TRY
		BEGIN TRAN

		INSERT INTO	dbo.LServer_GSUser_Packet_Latency ( ServerUID, PacketID, Latency, MaxDate, RegDate, UnitUID )
		VALUES ( @ServerUID, @PacketID, @Latency, @MaxDate, @RegDate, @UnitUID  )

		COMMIT TRAN

		SET @Result = 0
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

		SET @Result = -1
	END CATCH

	SELECT @Result
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LServer_GSUser_Packet_Latency_INS]
	@iServerSetID		TINYINT
,	@ServerUID	int
,	@PacketID	nvarchar(50)
,	@Latency	int
,	@MaxDate	smalldatetime
,	@RegDate	smalldatetime
,	@UnitUID	bigint
AS
	SET NOCOUNT ON
/*
	게임서버에서 처리되는 패킷들중에 처리가 가장 지연되는 top 10을 골라내서 5분간격으로 로그를 남기는 것
*/
	DECLARE @Result		int

	BEGIN TRY
		BEGIN TRAN

		INSERT INTO	dbo.LServer_GSUser_Packet_Latency ( ServerUID, PacketID, Latency, MaxDate, RegDate, UnitUID )
		VALUES ( @ServerUID, @PacketID, @Latency, @MaxDate, @RegDate, @UnitUID  )

		COMMIT TRAN

		SET @Result = 0
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

		SET @Result = -1
	END CATCH

	SELECT @Result
GO
-- ==========================================================================================
-- Author:		HWANG
-- Create date: 2013.02.22
-- Description:	서버에서 출력되는 에러 로그들을 통계로 내어 로그 파일을 찾아보지 않아도
--				쉽게 현재 서버의 정상동작 상태와 문제점 파악에 도움이 되기 위하여
--				DB테이블에 서버 에러 로그 종류별 카운트 정보를 기록
-- ==========================================================================================
CREATE OR ALTER PROCEDURE [dbo].[P_LServer_ErrorLog_INS]
	@ServerUID		int
,	@FunctionName	nvarchar(100)
,	@FileName		nvarchar(200)
,	@LineNum		nvarchar(10)
,	@Count			int
,	@RegDate		smalldatetime


AS
	SET NOCOUNT ON;
	
	DECLARE @Result		INT

	BEGIN TRY
		BEGIN TRAN
		
			SET @Result = -1
			
			INSERT INTO dbo.LServer_ErrorLog ( 	ServerUID, FunctionName, [FileName], LineNum, [Count], RegDate )
			VALUES ( @ServerUID, @FunctionName, @FileName, @LineNum, @Count, @RegDate )			

		COMMIT TRAN

		SET @Result = 0

	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE
		
		IF @Result IS NULL OR @Result = 0
			SET @Result = -100
	END CATCH

	
	SELECT @Result as 'Result'
GO
CREATE OR ALTER PROCEDURE [dbo].[P_LServer_CnProxy_Packet_Count_INT]
	@ServerUID	int
,	@PacketID	nvarchar(50)
,	@Count		int
,	@RegDate	smalldatetime
AS
	SET NOCOUNT ON
/*
	게임서버에서 처리는 패킷들의 종류별로 카운트를 매겨서 가장 많은 수 top 10을 골라내서 5분간격으로 로그를 남기는것
*/
	DECLARE @Result		int

	BEGIN TRY
		BEGIN TRAN

		INSERT INTO	dbo.LServer_CnProxy_Packet_Count ( ServerUID, PacketID, [Count], RegDate )
		VALUES ( @ServerUID, @PacketID, @Count, @RegDate  )

		COMMIT TRAN

		SET @Result = 0
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

		SET @Result = -1
	END CATCH

	SELECT @Result
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 게임서버에서 처리는 패킷들의 종류별로 카운트를 매겨서 가장 많은 수 top 10을 골라내서 5분간격으로 로그를 남기는것
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LServer_CnProxy_Packet_Count_INS]
	@iServerSetID	TINYINT
,	@ServerUID	int
,	@PacketID	nvarchar(50)
,	@Count		int
,	@RegDate	smalldatetime
AS
	SET NOCOUNT ON

	DECLARE @Result		int

	BEGIN TRY
		BEGIN TRAN

		INSERT INTO	dbo.LServer_CnProxy_Packet_Count ( ServerUID, PacketID, [Count], RegDate )
		VALUES ( @ServerUID, @PacketID, @Count, @RegDate  )

		COMMIT TRAN

		SET @Result = 0
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

		SET @Result = -1
	END CATCH

	SELECT @Result
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LSecurityTypeLog_INS]
	@iServerSetID	TINYINT
,	@iUserUID		BIGINT
,	@iSecurityType	TINYINT
,	@iAge			TINYINT
,	@sdtRegDate		SMALLDATETIME
,	@iOK            int = 0

AS
SET NOCOUNT ON;

BEGIN TRAN

    INSERT INTO dbo.LSecurityTypeLog WITH (UPDLOCK)(UserUID, SecurityType, Age, RegDate)
	    SELECT @iUserUID, @iSecurityType, @iAge, @sdtRegDate

		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN
			SELECT @iOK = -1
			GOTO FAIL_TRAN
		END   
		 
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LRetainLog_INS]
	@iServerSetID	TINYINT,
	@iUserUID		BIGINT,
	@iUnitUID		BIGINT,
	@iItemID		INT,
	@sdtRegDate		SMALLDATETIME,
	@iOK			INT = 0
	
AS
SET NOCOUNT ON;

BEGIN TRAN

    INSERT INTO dbo.LRetainLog( UserUID, UnitUID, ItemID, RegDate)
		SELECT @iUserUID, @iUnitUID, @iItemID, @sdtRegDate
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	 GOTO FAIL_TRAN		END
    
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LProductList_INS]
	@iServerSetID		TINYINT,
	@iProductNo			INT,	
	@iProductExpire		SMALLINT,
	@iProductPieces		SMALLINT,
	@iItemID			INT,
	@iSalePrice			INT,
	@iOK        [int] = 0
	
AS
SET NOCOUNT ON;

IF EXISTS (SELECT * FROM dbo.LProductList WITH (NOLOCK) WHERE ProductNo = @iProductNo)
	BEGIN	SELECT	@iOK = -2	GOTO END_PROC	END


BEGIN TRAN

	INSERT INTO dbo.LProductList (ProductNo, ProductExpire, ProductPieces, ItemID, SalePrice)
		SELECT @iProductNo, @iProductExpire, @iProductPieces, @iItemID, @iSalePrice

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	BEGIN	SELECT @iOK = -1	GOTO	FAIL_TRAN	END
	
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LPost_TradeMonitor_INS]
	@iServerSetID	TINYINT,	
	@iToUnitUID		BIGINT,
	@sdtRegDate		SMALLDATETIME,
	@iType			TINYINT,
	@iOK			[int] = 0	

AS
SET NOCOUNT ON;			
					

IF EXISTS (SELECT * FROM dbo.LPost_TradeMonitor WITH (NOLOCK) WHERE ToUnitUID = @iToUnitUID AND [Type] = @iType)
	BEGIN	SELECT	@iOK = -10	GOTO END_PROC	END

DECLARE @iUserUID BIGINT
SELECT @iUserUID = UserUID FROM dbo.UnitStatistics WITH (NOLOCK) WHERE unitUID = @iToUnitUID
	
BEGIN TRAN	

	INSERT INTO dbo.LPost_TradeMonitor (ServerSetID, ToUnitUID, RegDate, [Type])
		SELECT @iServerSetID, @iToUnitUID, @sdtRegDate, @iType
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1				
				BEGIN	SELECT @iOK = -11	GOTO FAIL_TRAN	END
		
	UPDATE dbo.ReleaseTick
		SET [Count] = [Count] + 1
			WHERE [Type] = 1
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1				
				BEGIN	SELECT @iOK = -13	GOTO FAIL_TRAN	END	

COMMIT TRAN						
						
GOTO END_PROC						
						
FAIL_TRAN:						
ROLLBACK TRAN						
						
END_PROC:						
SELECT @iOK
GO
-- =============================================
-- Author:  EJ
-- Create date: 2012-10-10
-- Description: 진화한 펫 로그 등록
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LPetEvolution_INT]
	@UnitUID			bigint,
	@PetUID				bigint,
	@PetID				bigint,
	@EventItemID		bigint
AS
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @Result	int

	BEGIN TRY
		BEGIN TRAN
		
		INSERT INTO dbo.LPetEvolution ( UnitUID, PetUID, PetID, EventItemID, Regdate )
		SELECT @UnitUID, @PetUID, @PetID, @EventItemID, Getdate()
				
		SET @Result = 0
	COMMIT TRAN
	END TRY
	
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

		IF @Result IS NULL 
			SET @Result = -1
	END CATCH

	SELECT @Result
GO
CREATE OR ALTER PROCEDURE [dbo].[P_LPerformance_INS]
	@ServerSetID	TINYINT,
	@UnitUID bigint,
	@RoomUID bigint,
	@GameType smallint,
	@Host  bit,
	@Leave bit,
	@NumOfP2P smallint,
	@NumOfRelay smallint,
	@AVGPing int,
	@BestPing int,
	@WorstPing int,
	@PingStandardDeviation float,
	@PacketLossRate float,
	@AVGFrameMovePerSec float,
	@MAXFrameMovePerSec float,
	@MINFrameMovePerSec float,
	@FrameMovePerSecStandardDeviation float,
	@FrameAVG smallint,
	@AvailableMemory int,
	@TotalMemory int,
	@ProcessorName nvarchar(50),
	@WindowsVersion nvarchar(50),
	@D3DDeviceName nvarchar(50)
AS
	SET NOCOUNT ON
	
	DECLARE @Result			int
	
	BEGIN TRY
		BEGIN TRAN
			
		INSERT INTO dbo.LPerformance ( UnitUID, RoomUID, GameType, Host, Leave, NumOfP2P, NumOfRelay, AVGPing, BestPing, WorstPing, PingStandardDeviation, PacketLossRate, AVGFrameMovePerSec, MAXFrameMovePerSec, MINFrameMovePerSec, FrameMovePerSecStandardDeviation, FrameAVG, AvailableMemory, TotalMemory, ProcessorName, WindowsVersion, D3DDeviceName, Regdate )
		VALUES ( @UnitUID, @RoomUID, @GameType, @Host, @Leave, @NumOfP2P, @NumOfRelay, @AVGPing, @BestPing, @WorstPing, @PingStandardDeviation, 
		 @PacketLossRate, @AVGFrameMovePerSec,@MAXFrameMovePerSec, @MINFrameMovePerSec, @FrameMovePerSecStandardDeviation, @FrameAVG, @AvailableMemory, @TotalMemory,
		  @ProcessorName, @WindowsVersion, @D3DDeviceName, GETDATE() )
			
		COMMIT TRAN
			
		SET @Result = 0
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN
		
		SET @Result = -1
	END CATCH
	SELECT @Result
GO
CREATE OR ALTER PROCEDURE [dbo].[P_LPCBangList_SEL]
AS
	SET NOCOUNT ON

	SELECT IP, PC_Type
	FROM dbo.LPCBangList WITH(NOLOCK)
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2012.10.16
-- Description:	P2P & RelayServer 사용율 및 P2P 홀펀칭 시도 횟수 기록
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LP2P_RelayLog_INT]
	@GameType		tinyint
,	@TryCount		smallint
,	@P2PPlayTime	int
,	@RelayPlayTime	int
,	@RelayIP		nvarchar(15)
,	@RegDate		smalldatetime
AS
	SET NOCOUNT ON

	DECLARE @Result		int

	BEGIN TRY
		BEGIN TRAN
		
		SET @Result = -1

		INSERT INTO	dbo.LP2P_RelayLog ( GameType, TryCount, P2PPlayTime, RelayPlayTime, RelayIP, RegDate )
		VALUES ( @GameType, @TryCount, @P2PPlayTime, @RelayPlayTime, @RelayIP, @RegDate  )

		COMMIT TRAN

		SET @Result = 0
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE
		
		SET @Result = -1
	END CATCH

	SELECT @Result
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2012.10.16
-- Description:	P2P & RelayServer 사용율 및 P2P 홀펀칭 시도 횟수 기록
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LP2P_RelayLog_INS]
	@iServerSetID	TINYINT
,	@GameType		tinyint
,	@TryCount		smallint
,	@P2PPlayTime	int
,	@RelayPlayTime	int
,	@RelayIP		nvarchar(15)
,	@RegDate		smalldatetime
AS
	SET NOCOUNT ON

	DECLARE @Result		int

	BEGIN TRY
		BEGIN TRAN
		
		SET @Result = -1

		INSERT INTO	dbo.LP2P_RelayLog ( GameType, TryCount, P2PPlayTime, RelayPlayTime, RelayIP, RegDate )
		VALUES ( @GameType, @TryCount, @P2PPlayTime, @RelayPlayTime, @RelayIP, @RegDate  )

		COMMIT TRAN

		SET @Result = 0
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE
		
		SET @Result = -1
	END CATCH

	SELECT @Result
GO
-- =============================================
-- Author:		Hwang
-- Create date: 
-- Description: 존재하지 않는 모듈을 사용해서 게임 접속하는 경우 로그 남음
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LNonExistentModuleLog_INS]
	@iServerSetID	TINYINT	
,	@iServerSN		bigint
,	@iUserUID		bigint
,	@strModuleName	nvarchar(20)
,	@sdtRegDate		smalldatetime
AS
	SET NOCOUNT ON

	DECLARE @Result		int

	BEGIN TRY
		BEGIN TRAN

			INSERT INTO	dbo.LNonExistentModuleLog ( ServerSN, UserUID, ModuleName, RegDate )
			VALUES ( @iServerSN, @iUserUID, @strModuleName, @sdtRegDate )
			
		COMMIT TRAN

		SET @Result = 0
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

		IF @Result = 0 OR @Result IS NULL
			SET @Result = -1
	END CATCH

	SELECT ISNULL(@Result, 0) AS Result
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LModuleTable_UPD]
	@iServerSetID		TINYINT,
    @iModuleUID   int,
    @iCount		  BIGINT,
    @iOK          int = 0
AS

SET NOCOUNT ON;

-- 해당 유닛이 없는 경우.
IF NOT EXISTS (SELECT * FROM dbo.LModuleTable WITH (NOLOCK) WHERE ModuleUId = @iModuleUID)
    GOTO END_PROC

BEGIN TRAN

    UPDATE dbo.LModuleTable WITH( ROWLOCK )
        SET [count] = @iCount
			WHERE ModuleUId = @iModuleUID

		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -3	GOTO FAIL_TRAN	END


COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2010-10-13
-- Description: 모듈리스트 긁어가기
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LModuleTable_SEL]
	@iServerSetID	TINYINT
AS
SET NOCOUNT ON ;

SELECT ModuleUID, ModuleName, [count], allow, flag
	FROM dbo.LModuleTable WITH (NOLOCK)
GO
-- =============================================
-- Author:		2010-10-13
-- Create date: Hwang
-- Description: 클라이언트 DDL 로그 남김
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LModuleTable_INS]
	@iServerSetID		TINYINT
,	@strModuleName		NVARCHAR(20)
,	@iCount				BIGINT
,	@iBAllow			BIT
,	@iFlag				TINYINT
,	@iOK				INT = 0 
,   @iModuleUID			INT = 0

AS
SET NOCOUNT ON ;

BEGIN TRAN

		INSERT INTO dbo.LModuleTable ( ModuleName, [count], allow, flag )
		SELECT @strModuleName, @iCount, @iBAllow, @iFlag
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN	SELECT @iOK = -1  GOTO FAIL_TRAN  END
			
		SELECT @iModuleUID = @@IDENTITY
			
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK, @iModuleUID
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LLoginProxy_SEL]
	@iServerSetID	TINYINT

AS
SET NOCOUNT ON;

	SELECT A.ProxyID, B.IP, B.Port1
	FROM dbo.LLoginProxy AS A WITH (NOLOCK) JOIN dbo.LServerList AS B WITH (NOLOCK)
	ON A.ServerSetID = B.ServerSetID AND A.ServerUID = B.UID
	WHERE A.ServerSetID = @iServerSetID
	ORDER BY A.ProxyID ASC
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LLoginProxy_By_ServerUID_SEL]
	@iServerSetID	TINYINT
,	@iServerUID		INT

AS
SET NOCOUNT ON;

SELECT ProxyID 
	FROM dbo.LLoginProxy WITH (NOLOCK)
		WHERE ServerUID = @iServerUID
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LLoginProxy_By_ServerSetID_SEL]
	@iServerSetID		TINYINT

AS
SET NOCOUNT ON;

	SELECT A.ProxyID, B.PrivateIP, B.Port1
	FROM dbo.LLoginProxy AS A WITH (NOLOCK) 
	JOIN dbo.LServerList AS B WITH (NOLOCK)
		ON A.ServerSetID = B.ServerSetID AND A.ServerUID = B.UID
	WHERE A.ServerSetID = @iServerSetID
	ORDER BY A.ProxyID ASC
GO
-- =============================================
-- Author:  	EJ
-- Create date: 2013-06-17 
-- Description: 변형 콤파일 사용할 경우 콤파일명 로그 남기는 기능 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LKomFileLog_INT]
	@UserUID		bigint
,	@KomName	nvarchar(100)
AS
	SET NOCOUNT ON
	
	DECLARE @Result		int

	BEGIN TRY
		BEGIN TRAN

		INSERT INTO	dbo.LKomFileLog ( UserUID, KomName, Regdate)
		SELECT @UserUID, @KomName, GETDATE()

		COMMIT TRAN

		SET @Result = 0
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

		SET @Result = -1
	END CATCH

	SELECT @Result
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LItemLog_INS]
	@iServerSetID	TINYINT,
	@iItemID			INT,
	@iTrade				INT,
	@iPShop				INT,
	@iTBoard			INT,
	@iBuy				INT,
	@iSell				INT,
	@iUse				INT,
	@iMake				INT,
	@iFailed			INT,
	@iDrop				INT,
	@iQuest				INT,
	@iEquip				INT,
	@iRandom			INT,
	@iResolve			INT,
	@iR_Result			INT,
	@iMall				INT,
	@iPost				INT,
	@iAttrib			INT,
	@iExchange_S		INT,
	@iExchange_R		INT,
	@iDiscard			INT,
	@iPetFeed			INT,
	@sdtRegDate			SMALLDATETIME,
	@iServerUID			INT,
	@iRegPShop			INT,
	@iBuyPShopAgency	INT,
	@iPickUpPShop		INT,
	@iOK				INT = 0
	
AS
SET NOCOUNT ON;

BEGIN TRAN

	INSERT INTO dbo.LItemLog (ServerSetID, ItemID, Trade, PShop, TBoard, Buy, Sell, [Use], Make, Failed, [Drop], Quest, Equip, Random, Resolve, R_Result, Mall, Post, Attrib,
							  Exchange_S, Exchange_R, Discard, PetFeed, RegDate, ServerUID, RegPShop, BuyPShopAgency, PickUpPShop)
		SELECT  @iServerSetID, @iItemID, @iTrade, @iPShop, @iTBoard, @iBuy, @iSell, @iUse, @iMake, @iFailed, @iDrop, @iQuest, @iEquip, @iRandom, @iResolve, @iR_Result,
				@iMall, @iPost, @iAttrib, @iExchange_S, @iExchange_R, @iDiscard, @iPetFeed, @sdtRegDate, @iServerUID, @iRegPShop, @iBuyPShopAgency, @iPickUpPShop
	
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -112	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
-- =============================================
-- Author:		sutamtwo
-- Create date: 2010.02.12
-- Description: 해킹 프로세스 리스트 정보 읽기
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LHackProcessList_SEL]
	@iServerSetID	TINYINT
AS
SET NOCOUNT ON;

SELECT ProcessName, ClassName, ListType
	FROM dbo.LHackProcessList WITH (NOLOCK)
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LGlobalProxy_SEL]
	@iServerGroupID		TINYINT
AS
SET NOCOUNT ON;

	SELECT A.ProxyID, B.IP, B.Port1
	FROM dbo.LGlobalProxy AS A WITH (NOLOCK) JOIN dbo.LServerList AS B WITH (NOLOCK)
	ON A.ServerSetID = B.ServerSetID AND A.ServerUID = B.UID
	WHERE A.ServerSetID = @iServerGroupID 
	ORDER BY A.ProxyID ASC
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LGlobalProxy_By_ServerSetID_SEL]
	@iServerSetID		TINYINT
AS
SET NOCOUNT ON;

	SELECT A.ProxyID, B.PrivateIP, B.Port1
	FROM dbo.LGlobalProxy AS A WITH (NOLOCK)
	JOIN dbo.LServerList AS B WITH (NOLOCK)
		ON A.ServerSetID = B.ServerSetID AND A.ServerUID = B.UID
	WHERE A.ServerSetID = @iServerSetID 
	ORDER BY A.ProxyID ASC
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.03.15
-- Description: 랭킹 초기화(주간)
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LFriendSystem_Reset]
	@Num		int

AS
	SET NOCOUNT ON;
	
	DECLARE @Result			int
	DECLARE @LastResetDate	smalldatetime
	SET @LastResetDate = GETDATE()
	
	BEGIN TRY
		BEGIN TRAN
			
			SET @Result = -1
			
			UPDATE dbo.LFriendSystem_LastReset
			SET Num = @Num
			  , LastResetDate = @LastResetDate
			  
			SET @Result = -2
			
			DELETE FROM dbo.LFriendSystem_Ranker
			WHERE UnitUID > 0

		COMMIT TRAN
		
		SET @Result = 0
		
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

		IF @Result = 0 OR @Result IS NULL
			SET @Result = -2
	END CATCH	
	
	SELECT @Result AS 'Result', @LastResetDate as 'LastResetDate'
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.03.15
-- Description:	랭커 정보 모두 읽기
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LFriendSystem_RankerInfo_GET]

AS
	SET NOCOUNT ON;

	SELECT E.UserUID, E.Category, E.Gender, E.Birth, E.UserProfile, A.UnitUID, D.NickName, C.Level, C.UnitClass, B.Spirit, B.AP
	FROM [Statistics].dbo.LFriendSystem_Ranker AS A WITH(NOLOCK)
	JOIN [Game01].dbo.GFriendSystem_UnitInfo AS B WITH(NOLOCK)
		ON A.UnitUID = B.UnitUID
	JOIN [Game01].dbo.GUnit AS C WITH(NOLOCK)
		ON B.UnitUID = C.UnitUID AND Deleted = 0
	JOIN [Game01].dbo.GUnitNickName AS D WITH(NOLOCK)
		ON B.UnitUID = D.UnitUID
	JOIN [Account].dbo.MFriendSystem_UserInfo AS E WITH(NOLOCK)
		ON C.UserUID = E.UserUID
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.03.15
-- Description:	랭커 정보 쓰기
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LFriendSystem_Ranker_INS]
	@UnitUID	bigint

AS
	SET NOCOUNT ON;
	
	DECLARE @Result			int
	-- 이미 랭커이면, 1 반환
	IF EXISTS ( SELECT UnitUID FROM dbo.LFriendSystem_Ranker WITH(NOLOCK) WHERE UnitUID = @UnitUID ) BEGIN
		SET @Result = 1
	END
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN
				
				SET @Result = -1
				
				INSERT INTO dbo.LFriendSystem_Ranker ( UnitUID )
				VALUES ( @UnitUID )

			COMMIT TRAN
			
			SET @Result = 0
			
		END TRY
		BEGIN CATCH
			DECLARE @NO_XACT_STATE		smallint
			SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

			IF @NO_XACT_STATE <> 0
				ROLLBACK TRAN

			EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

			IF @Result = 0 OR @Result IS NULL
				SET @Result = -2
		END CATCH
	END

	SELECT ISNULL(@Result, 0) AS Result
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.03.15
-- Description:	랭커 정보 삭제
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LFriendSystem_Ranker_DEL]
	@UnitUID	bigint

AS
	SET NOCOUNT ON;
	
	DECLARE @Result			int

	BEGIN TRY
		BEGIN TRAN
			
			SET @Result = -1
			
			DELETE FROM dbo.LFriendSystem_Ranker
			WHERE UnitUID = @UnitUID

		COMMIT TRAN
		
		SET @Result = 0
		
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

		IF @Result = 0 OR @Result IS NULL
			SET @Result = -2
	END CATCH

	SELECT ISNULL(@Result, 0) AS Result
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.03.15
-- Description:	시스템 정보 읽기
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LFriendSystem_LastReset_GET]

AS
	SET NOCOUNT ON;
	
	DECLARE @Result			int

	IF EXISTS ( SELECT TOP 1 * FROM dbo.LFriendSystem_LastReset WITH(NOLOCK) ) BEGIN

		SELECT Num, LastResetDate
			FROM dbo.LFriendSystem_LastReset WITH(NOLOCK)
	END
	-- 최초 읽어가는 시점에 인설트
	ELSE BEGIN
	
		SET @Result = -1
		
		INSERT INTO dbo.LFriendSystem_LastReset ( Num, LastResetDate )
		VALUES ( 0, '1900-01-01 00:00')
		
		SELECT  0, '1900-01-01 00:00'
	
	END
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2012.10.18
-- Description:	
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LFieldLog_INT]
	@iServerSetID	tinyint,
	@ServerIP		nvarchar(15),
	@FieldID		int,
	@RoomUID		bigint,
	@EndType		tinyint,
	@UnitUID		bigint,
	@NickName		nvarchar(20),
	@UnitClass		tinyint,
	@LV				tinyint,
	@PlayTime		int,
	@EXP			int,
	@ED				int,
	@RegDate		smalldatetime,
	@Frame			smallint,
	@iChannelCode	tinyint,
	@iNPCDieCount	int

AS
	SET NOCOUNT ON

	DECLARE @Result		int

	BEGIN TRY
		BEGIN TRAN
		
		SET @Result = -1

		INSERT INTO	dbo.LFieldLog ( ServerSetID, ServerIP, FieldID, RoomUID, EndType, UnitUID, NickName, UnitClass, LV, PlayTime, [EXP], ED, RegDate, Frame, NPCDieCount )
		VALUES ( @iServerSetID, @ServerIP, @FieldID, @RoomUID, @EndType, @UnitUID, @NickName, @UnitClass, @LV, @PlayTime, @EXP, @ED, @RegDate, @Frame, @iNPCDieCount )

		COMMIT TRAN

		SET @Result = 0
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE
		
		SET @Result = -1
	END CATCH

	SELECT @Result
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2012.10.18
-- Description:	
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LFieldLog_INS]
	@iServerSetID	TINYINT,
	@ServerIP		nvarchar(15),
	@FieldID		int,
	@RoomUID		bigint,
	@EndType		tinyint,
	@UnitUID		bigint,
	@NickName		nvarchar(20),
	@UnitClass		tinyint,
	@LV				tinyint,
	@PlayTime		int,
	@EXP			int,
	@ED				int,
	@RegDate		smalldatetime,
	@Frame			smallint,
	@NPCDieCount	int

AS
	SET NOCOUNT ON

	DECLARE @Result		int

	BEGIN TRY
		BEGIN TRAN
		
		SET @Result = -1

		INSERT INTO	dbo.LFieldLog ( ServerIP, FieldID, RoomUID, EndType, UnitUID, NickName, UnitClass, LV, PlayTime, [EXP], ED, RegDate, Frame, NPCDieCount )
		VALUES ( @ServerIP, @FieldID, @RoomUID, @EndType, @UnitUID, @NickName, @UnitClass, @LV, @PlayTime, @EXP, @ED, @RegDate, @Frame, @NPCDieCount )

		COMMIT TRAN

		SET @Result = 0
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE
		
		SET @Result = -1
	END CATCH

	SELECT @Result
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2010. 11. 19
-- Description: 엑스포 이벤트 관련 리스트 정보 갱신
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LExpo_Event_UPD]
	@iServerSetID	TINYINT		
,	@iID			INT
,	@iKillUnitUID	BIGINT	
,	@sdtDieDate		SMALLDATETIME
,	@iOK			INT	= 0

AS
SET NOCOUNT ON;
SET XACT_ABORT ON;



BEGIN TRAN

	UPDATE dbo.LExpo_Event
		SET DieDate		= @sdtDieDate
		,	KillUnitUID	= @iKillUnitUID
			WHERE ID = @iID

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -2	GOTO FAIL_TRAN	END
		
COMMIT TRAN		
		
		


GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2010. 11. 19
-- Description: 엑스포 이벤트 관련 리스트 정보 읽기
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LExpo_Event_SEL]
	@iServerSetID	TINYINT
,	@iServerUID INT
AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

SELECT ID,			
	   NPCID,
	   DropDate
    FROM dbo.LExpo_Event WITH (NOLOCK)
	WHERE ServerUID = @iServerUID AND DropDate > GETDATE()
		ORDER BY DropDate
GO
-- =============================================
-- Author:		HWANG
-- Create date: 2013.01.28
-- Description:	던전 강퇴 로그
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LExitLog_INS]
	@iServerSetID	TINYINT
,	@UnitUID		bigint
,	@DungeonID		int
,	@StartMember	tinyint
,	@NowMember		tinyint
,	@VoteMember		tinyint
,	@ExitStage		tinyint
,	@ExitSubStage	tinyint
,	@ExitPoint		tinyint
,	@RegDate		datetime
,	@ExitResult		bit

AS
	SET NOCOUNT ON;

	DECLARE @Result		INT

	BEGIN TRY
		BEGIN TRAN
		
			SET @Result = -1
			
			INSERT INTO dbo.LExitLog ( UnitUID, DungeonID, StartMember, NowMember,VoteMember, ExitStage, ExitSubStage, ExitPoint, RegDate, ExitResult )
			VALUES ( @UnitUID, @DungeonID, @StartMember, @NowMember, @VoteMember, @ExitStage, @ExitSubStage, @ExitPoint, @RegDate, @ExitResult )			

		COMMIT TRAN

		SET @Result = 0

	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE
		
		IF @Result IS NULL OR @Result = 0
			SET @Result = -100
	END CATCH

	
	SELECT @Result as 'Result'
GO
-- =============================================
-- Author:		HWANG
-- Create date: 2013.02.19
-- Description:	아이템 교환 로그
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LExchangeLog_INS]
	@UnitUID		bigint
,	@UserUID		bigint
,	@ItemID_I		int
,	@Quantity_I		smallint
,	@ItemID_O		int
,	@Quantity_O		smallint
,	@ExchangeType	tinyint
,	@RegDate		smalldatetime
/*
ExchangeType	1:ALL/2:RANDOM/3:SELECT
*/
AS
	SET NOCOUNT ON

	DECLARE @Result		int

	BEGIN TRY
		BEGIN TRAN
		
		SET @Result = -1

		INSERT INTO	dbo.LExchangeLog ( UnitUID, UserUID, ItemID_I, Quantity_I, ItemID_O, Quantity_O, ExchangeType, RegDate )
		VALUES ( @UnitUID, @UserUID, @ItemID_I, @Quantity_I, @ItemID_O, @Quantity_O, @ExchangeType, @RegDate )

		COMMIT TRAN

		SET @Result = 0
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE
		
		IF @Result IS NULL OR @Result = 0
			SET @Result = -100
	END CATCH

	SELECT @Result
GO
-- =============================================
-- Author:		sutamtwo
-- Create date: 2009. 08. 26
-- Description: 시공 랭킹 읽기
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LEvent_Rank_TimeSpace]
	@iServerSetID	TINYINT
AS 
SET NOCOUNT ON;

SELECT [Rank], UnitUID, NickName, UnitClass, [Level], Point
	FROM dbo.LEvent_Rank_TimeSpace
GO
-- =============================================
-- Author:		HWANG
-- Create date: 2012.12.18
-- Description:	잭팟 이벤트 당첨자 정보 기록
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LEvent_Jackpot_UPT]
	@CouponNumber		NVARCHAR(30)
,	@UserUID			bigint
,	@UnitUID			bigint
,	@State				tinyint

AS
	SET NOCOUNT ON

	DECLARE @Result		int

	-- 해당 퀘스트를 수락한 기록이 없다면
	IF NOT EXISTS (SELECT 1 FROM dbo.LEvent_Jackpot WITH(NOLOCK) WHERE CouponNumber = @CouponNumber AND [State] = 0)
					SET @Result = -1
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN
			
				SET @Result = -2
						
				UPDATE dbo.LEvent_Jackpot
				SET UserUID	  = @UserUID
				 ,	UnitUID	  = @UnitUID
				 ,	DropDate  = GETDATE()
				 ,	[State]	  = @State
				WHERE CouponNumber = @CouponNumber
					
			COMMIT TRAN

			SET @Result = 0
		END TRY
		BEGIN CATCH
			DECLARE @NO_XACT_STATE		smallint
			SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

			IF @NO_XACT_STATE <> 0
				ROLLBACK TRAN

			EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

			IF @Result = 0 OR @Result IS NULL
				SET @Result = -3
		END CATCH
	END
	
	SELECT @Result AS Result
GO
-- =============================================
-- Author:		HWANG
-- Create date: 2012.12.18
-- Description:	잭팟 이벤트 당첨자 정보 기록
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LEvent_Jackpot_UPD]
	@iServerSetID		TINYINT
,	@CouponNumber		NVARCHAR(30)
,	@UserUID			bigint
,	@UnitUID			bigint
,	@State				tinyint

AS
	SET NOCOUNT ON

	DECLARE @Result		int

	-- 해당 퀘스트를 수락한 기록이 없다면
	IF NOT EXISTS (SELECT 1 FROM dbo.LEvent_Jackpot WITH(NOLOCK) WHERE CouponNumber = @CouponNumber AND [State] = 0)
					SET @Result = -1
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN
			
				SET @Result = -2
						
				UPDATE dbo.LEvent_Jackpot
				SET UserUID	  = @UserUID
				 ,	UnitUID	  = @UnitUID
				 ,	DropDate  = GETDATE()
				 ,	[State]	  = @State
				WHERE CouponNumber = @CouponNumber
					
			COMMIT TRAN

			SET @Result = 0
		END TRY
		BEGIN CATCH
			DECLARE @NO_XACT_STATE		smallint
			SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

			IF @NO_XACT_STATE <> 0
				ROLLBACK TRAN

			EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

			IF @Result = 0 OR @Result IS NULL
				SET @Result = -3
		END CATCH
	END
	
	SELECT @Result AS Result
GO
-- =============================================
-- Author:		HWANG
-- Create date: 2012.12.18
-- Description:	잭팟 이벤트 정보 읽어가기
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LEvent_Jackpot_SEL]
	@iServerSetID		TINYINT
AS
	SET NOCOUNT ON;
	
	SELECT CouponNumber, BeginDate, EndDate, UserUID, UnitUID, [State]
		FROM dbo.LEvent_Jackpot WITH(NOLOCK)
GO
-- =============================================
-- Author:		HWANG
-- Create date: 2012.12.18
-- Description:	잭팟 이벤트 정보 읽어가기
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LEvent_Jackpot_GET]

AS
	SET NOCOUNT ON;
	
	SELECT CouponNumber, BeginDate, EndDate, UserUID, UnitUID, [State]
		FROM dbo.LEvent_Jackpot WITH(NOLOCK)
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2010. 12. 20
-- Description: 크리스마스 이벤트 관련 리스트 정보 갱신
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LEvent_Christmas_UPD]
	@iServerSetID	TINYINT	,	
	@iID			INT,
	@iUserUID		BIGINT,
	@iUnitUID		BIGINT,
	@sdtUpdTime		SMALLDATETIME,
	@iOK			INT	= 0
AS
SET NOCOUNT ON;
SET XACT_ABORT ON;



BEGIN TRAN

	UPDATE dbo.LEvent_Christmas
		SET UserUID	= @iUserUID,
			UnitUID = @iUnitUID,
			UpdTime = @sdtUpdTime
	WHERE ID = @iID

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -2	GOTO FAIL_TRAN	END
		
COMMIT TRAN		
		
		


GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2010. 12. 20
-- Description: 크리스마스 이벤트 관련 리스트 정보 읽기
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LEvent_Christmas_SEL]
	@iServerSetID	TINYINT	
AS
SET NOCOUNT ON;

SELECT ID, ItemID, DropTime, UpdTime, UserUID, UnitUID, DropEndTime, CubeID
FROM dbo.LEvent_Christmas WITH (NOLOCK)
ORDER BY DropTime
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LEquipmentLog_INS]
	@iServerSetID		TINYINT	,
	@iUnitUID			BIGINT,
	@iUnitLevel			TINYINT,
	@iDungeonID			INT,
	@iDifficulty		TINYINT,
	@iWeaponLevel		TINYINT,
	@iWeaponClass		TINYINT,
	@iPhysicalAttack	INT,
	@iMagicAttack		INT,
	@sdtRegDate			SMALLDATETIME,
	@iOK				INT = 0
	
AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRAN

	INSERT INTO dbo.LEquipmentLog (ServerSetID, UnitUID, UnitLevel, DungeonID, Difficulty, WeaponLevel, WeaponClass, PhysicalAttack, MagicAttack, Regdate)
	    SELECT @iServerSetID, @iUnitUID, @iUnitLevel, @iDungeonID, @iDifficulty, @iWeaponLevel, @iWeaponClass, @iPhysicalAttack, @iMagicAttack, @sdtRegDate
			   
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -111	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LEnchantLog_INS]
	@iServerSetID		TINYINT
,	@iUnitUID		bigint
,	@iItemUID		bigint
,	@iItemID		int
,	@bIsPluor		bit		-- 플루오르스톤 사용 유무(0: 사용안함/1: 사용)
,	@iBeforeELv		tinyint	-- 강화 전 레벨
,	@iAfterELv		tinyint	-- 강화 후 레벨
,	@iEnchantType	tinyint	-- 강화 결과( 1: 강화 성공/2: 파손/3: 변화없음/4: 하락/5: 초기화[0강])
,	@dtRegDate		datetime
AS
	SET NOCOUNT ON
	
	DECLARE @Result			int

	BEGIN TRY
		BEGIN TRAN

		INSERT INTO dbo.LEnchantLog( UnitUID, ItemUID, ItemID, IsPluor, BeforeELv, AfterELv, EnchantType, RegDate )
		VALUES( @iUnitUID, @iItemUID, @iItemID, @bIsPluor, @iBeforeELv, @iAfterELv, @iEnchantType, @dtRegDate )

		COMMIT TRAN
		
		SET @Result = 0
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE
		
		IF @Result = 0 OR @Result IS NULL
			SET @Result = -1
	END CATCH
	
	SELECT ISNULL(@Result, 0) AS Result
GO
/*
	ED로 버프 구매한 내역을 기록 한다.
	작성자: SeoJR
	최종 수정일 : 2012-12-03
	- 2012.12.03 : 버프 구매 로그 남기기
*/
CREATE OR ALTER PROCEDURE [dbo].[P_LEDBuffeffect_INT]
	@UnitUID 		BIGINT
,	@BuffID			INT
,	@UseDate		SMALLDATETIME
,	@EndDate		SMALLDATETIME
,	@DurationTime	INT
,	@ItemID			INT
,	@DungeonOnly	BIT
AS
	SET NOCOUNT ON
	
	DECLARE @Result	INT
	
	IF @UnitUID IS NULL OR @UnitUID <= 0
	BEGIN
		SELECT @Result	= -1
	END
	ELSE
	BEGIN
	
		BEGIN TRY
			BEGIN TRAN
		
				SET @Result = -2 
			
				INSERT INTO dbo.LEDBuffeffect
				(UnitUID, BuffID, UseDate, EndDate, DurationTime, ItemID, DungeonOnly)
				SELECT @UnitUID, @BuffID, @UseDate, @EndDate, @DurationTime, @ItemID, @DungeonOnly
			
			COMMIT TRAN
			
			SET @Result = 0
			
		END TRY
		BEGIN CATCH
			DECLARE @NO_XACT_STATE		smallint
			SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

			IF @NO_XACT_STATE <> 0
				ROLLBACK TRAN

			EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

			IF @Result = 0 OR @Result IS NULL
				SET @Result = -2
		END CATCH
			
	END
	
	SELECT ISNULL(@Result, 0) AS Result
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LDungeonTimeHackUser_INS]
	@iServerSetID	TINYINT,
	@iUserUID_		BIGINT,
	@sdtRegDate		SMALLDATETIME
	
AS
SET NOCOUNT ON;

	IF EXISTS (SELECT * FROM dbo.LDungeonTimeHackUser WITH (NOLOCK) WHERE UserUID = @iUserUID_)
		BEGIN	GOTO END_PROC	END
		
	ELSE
		BEGIN
			INSERT INTO dbo.LDungeonTimeHackUser(UserUID, RegDate)
			SELECT @iUserUID_, @sdtRegDate
		END
		
END_PROC:
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_update_Christmas_event]
	@iID			INT,
	@iUserUID		BIGINT,
	@iUnitUID		BIGINT,
	@sdtUpdTime		SMALLDATETIME,
	@iOK			INT	= 0
/*
	Hwang	
	2010. 12. 20
	크리스마스 이벤트 관련 리스트 정보 갱신
*/
	

AS
SET NOCOUNT ON;
SET XACT_ABORT ON;



BEGIN TRAN

	UPDATE dbo.LEvent_Christmas
		SET UserUID	= @iUserUID,
			UnitUID = @iUnitUID,
			UpdTime = @sdtUpdTime
	WHERE ID = @iID

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -2	GOTO FAIL_TRAN	END
		
COMMIT TRAN		
		
		


GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_set_server_enable_flag]
	@iUID_ [int],
	@bFlag_ [bit],
	@iOK [int] = 0
AS
SET NOCOUNT ON;

IF NOT EXISTS(SELECT * FROM dbo.LServerList WITH (NOLOCK) WHERE UID = @iUID_)
    BEGIN    SELECT @iOK = -1    GOTO END_PROC    END

BEGIN TRAN
    UPDATE dbo.LServerList WITH(ROWLOCK)
        SET [Enable] = @bFlag_
,           ConcurrentUser = CASE @bFlag_ WHEN 1 THEN ConcurrentUser ELSE 0 END
            WHERE UID = @iUID_
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
        BEGIN    SELECT @iOK = -11    GOTO FAIL_TRAN    END
COMMIT TRAN
GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_Nickname_Restore_Log]
	@iUnitUID		[bigint]
,	@strNickName	[nvarchar](16)
,	@iOK			[int] = 0
AS
SET NOCOUNT ON;

DECLARE	@sdtNow	SMALLDATETIME
SELECT	@sdtNow = GETDATE()

BEGIN TRAN	

	--  닉네임 변경 기록 저장
	INSERT INTO dbo.StatsNickNameRestore (NickName,UnitUID, Regdate)
		SELECT @strNickName, @iUnitUID, @sdtNow
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
        BEGIN    SELECT @iOK = -1	GOTO END_PROC    END


COMMIT TRAN


GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_Nickname_Delete_Log]
	@iUnitUID		[bigint]
,	@strNickName	[nvarchar](16)
,	@iOK			[int] = 0
AS
SET NOCOUNT ON;

DECLARE	@sdtNow	SMALLDATETIME
SELECT	@sdtNow = GETDATE()

BEGIN TRAN	

	--  닉네임 변경 기록 저장
	INSERT INTO dbo.StatsNickNameChange (NickName,UnitUID, Regdate)
		SELECT @strNickName, @iUnitUID, @sdtNow
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
        BEGIN    SELECT @iOK = -1	GOTO END_PROC    END


COMMIT TRAN


GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_insert_user_play_time]
	@ServerSetID		tinyint,
    @UserUID            [bigint],
    @IP                 [nvarchar](15),
    @LoginTime          [smalldatetime],
    @LogoutTime         [smalldatetime],
    @LoginFail          [bit],
    @LogoutFail         [bit],
	@iTotalPlayTime		[int],
	@iVsPlayTime		[int],
	@iDungeonPlayTime	[int],	-- 2012.11.22 업데이트
	@iFieldPlayTime		[int],	-- 2012.11.22 업데이트
	@iDisconnectReason	[tinyint],
	@iDisconnectUserFSM	[tinyint],
	@iArcadePlayTime	[int],
	@iChannelCode		int = NULL,
	@PCBangFlag			BIT = 0,
    @iOK                [int] = 0
AS

SET NOCOUNT ON;

BEGIN TRAN
    INSERT INTO dbo.LConnectLog(ServerSetID, UserUID, IP, LoginTime, LogoutTime, LoginFail, LogoutFail, TotalPlayTime, VsPlayTime, DisconnectReason, DisconnectUserFSM, ArcadePlayTime, DungeonPlayTime, FieldPlayTime, ChannelCode, PCBangFlag)
    SELECT @ServerSetID, @UserUID, @IP, @LoginTime, @LogoutTime,@LoginFail, @LogoutFail, @iTotalPlayTime, @iVsPlayTime, @iDisconnectReason, @iDisconnectUserFSM, @iArcadePlayTime, @iDungeonPlayTime, @iFieldPlayTime, @iChannelCode, @PCBangFlag
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
    BEGIN
        SELECT @iOK = -1
        GOTO FAIL_TRAN
    END
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_insert_unitpvp_log]
	@iArenaUID			BIGINT,		-- 대전 고유 번호
	@iMatchType			TINYINT,	-- 대전 타입(11: 1대1 팀매치, 12: 2대2 팀매치, 13: 3대3 팀매치, 21: 1대1 데스매치, 22: 2대2 데스매치, 23: 3대3 데스매치
	@iPvpType			TINYINT,	-- 0: 해당없음, 1: 초보자 NPC, 2: 영웅 NPC
	@iUnitUID			BIGINT,
	@strNickName		NVARCHAR(16),
	@iLv				TINYINT,
	@iUnitClass			TINYINT,
	@iRating			INT,
	@iRank				TINYINT,	-- 10: 1번째 낮은 단계, 20: 2번째 낮은 단계, 30: 3번째 낮은 단계, 40: 4번째 낮은 단계, 50: 5번째 낮은 단계, 60: 6번째 낮은 단계, 
	@iRPoint			INT,		-- 랭크 포인트 보유량
	@iAPoint			INT,		-- 아레나 포인트 보유량
	@iOfficialMatchCnt	INT,		-- 총 공식대전 플레이 횟수
	@iTeam				TINYINT,	-- 1: 레드팀, 2: 블루팀
	@bPartyApp			BIT,		-- 파티로 신청하였는지 여부
	@iWaitTime			SMALLINT,	-- 신청 후 대전 시작까지 대기 시간(초)
	@iWin				TINYINT,	-- 0: 패, 1: 승, 2: 비정상 종료
	@iEndType			SMALLINT,	-- 주석 따로..
	@iplayTime			SMALLINT,
	@iKill				TINYINT,
	@iAssist			TINYINT,
	@iDeath				TINYINT,
	@iNetRatingInc		SMALLINT,	-- rating 획득량
	@iNetRPInc			SMALLINT,	-- RPoint 증감
	@iNetAPInc			SMALLINT,	-- APoint 획득량
	@iEXPearned			INT,		-- 대전을 통해 획득한 경험치
	@sdtRegDate			SMALLDATETIME,
	@iOK [int] = 0

/*-------------------------------------
	# EndType

0	대전시작 30초 이내 이탈로 종료 처리
1	Kill 수 충족으로 정상 종료
2	대전 시간 종료로 정상 종료
3	상대 모두 이탈로 종료
4	자신의 이탈로 종료
5	기타
--------------------------------------*/
/*
Hwang
2011.07.27
*/


AS
SET NOCOUNT ON;

BEGIN TRAN

	INSERT INTO dbo.LUnitPVPLog (ArenaUID, MatchType, PvpType, UnitUID, NickName, Lv, UnitClass, Rating, [Rank], RPoint, APoint, OfficialMatchCnt,
					Team, PartyApp, WaitTime, Win, EndType, playTime, [Kill], Assist, Death, NetRatingInc, NetRPInc, NetAPInc, EXPearned, RegDate)
	    SELECT @iArenaUID, @iMatchType, @iPvpType, @iUnitUID, @strNickName, @iLv, @iUnitClass, @iRating, @iRank, @iRPoint, @iAPoint,
					@iOfficialMatchCnt, @iTeam, @bPartyApp, @iWaitTime, @iWin, @iEndType, @iplayTime, @iKill, @iAssist, @iDeath,					@iNetRatingInc, @iNetRPInc, @iNetAPInc, @iEXPearned, @sdtRegDate		   
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_insert_trade_log]
    @iFromUserUID   [bigint],
    @iFromUnitUID   [bigint],
    @iToUserUID     [bigint],
    @iToUnitUID     [bigint],
    @iItemUID       [bigint],
    @iItemID        [int],
    @iQuantity      [int],
    @iOK            [int] = 0
AS

SET NOCOUNT ON;

BEGIN TRAN
    INSERT INTO dbo.LTrade( FromUserUID, FromUnitUID, ToUserUID, ToUnitUID, ItemUID, ItemID, Quantity, RegDate )
    SELECT @iFromUserUID, @iFromUnitUID, @iToUserUID, @iToUnitUID, @iItemUID, @iItemID, @iQuantity, GetDate()
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
    BEGIN
        SELECT @iOK = -1
        GOTO FAIL_TRAN
    END    
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_insert_timespacetop100]
	@iUserUID	BIGINT	
,	@iUnitUID	BIGINT
,	@iPlayTime	SMALLINT
,	@iOK		INT = 0
AS
SET NOCOUNT ON;

/*
	2009. 07. 28
	sutamtwo
	헤니르의 시공 100명 뽑기

*/


DECLARE	@sdtNow DATETIME
SELECT	@sdtNow = GETDATE()

BEGIN TRAN

	INSERT INTO dbo.StatsTimeSpaceTop100 (UserUID, UnitUID, PlayTime, RegDate)
			SELECT @iUserUID, @iUnitUID, @iPlayTime, @sdtNow
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_insert_store_log]
    @iFromUnitUID   [bigint],
    @iToUnitUID     [bigint],
    @iItemID        [int],
    @iItemUID       [bigint],
    @iQuantity      [int],
	@iMoney			[int],
	@bIsBBS			[bit],
	@iStoreType		[tinyint],
    @iOK            [int] = 0
AS

SET NOCOUNT ON;

BEGIN TRAN
    INSERT INTO dbo.STrade( FromUnitUID, ToUnitUID, ItemID,ItemUID, Quantity, [Money], RegDate, IsBBS, StoreType )
	    SELECT @iFromUnitUID, @iToUnitUID, @iItemID, @iItemUID, @iQuantity, @iMoney, GetDate(), @bIsBBS, @iStoreType

		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN
			SELECT @iOK = -1
			GOTO FAIL_TRAN
		END    
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_insert_stone_log]
(
	@iUnitUID		bigint	
,	@iDungeonID		int		
,	@sdtRegDate		smalldatetime	
,	@iOK			int = 0
)
AS

SET NOCOUNT ON;

BEGIN TRAN

	INSERT INTO dbo.ResurrectionStoneLog(UnitUID, DungeonID, RegDate)
		SELECT @iUnitUID, @iDungeonID, @sdtRegDate
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
/*
	lup_insert_DailyQuiz
	lup_insert_StatsDailyQuiz
*/
CREATE OR ALTER PROCEDURE [dbo].[lup_insert_StatsDailyQuiz]
	@ServerSetID				tinyint
,	@Useruid					bigint
,	@Unituid 					bigint
,	@QuizNum					int				-- 문제푼 번호
,	@BoardNum					int				-- 몇칸 까지 갔는지
,	@Answer						int				-- 맞추면 1, 못맞추면 0
,	@Reward_Day					int				-- 보상 itemid
,	@Reward_Special				int				-- 보상 itemid
,	@Reward_Month				int				-- 보상 itemid
,	@Reward_Month_BoardNum		int				-- 보상 itemid
,	@Unitclass					int
,	@Level						int
,	@Regdate					smalldatetime	-- 문제를 푼 날짜
AS
	SET NOCOUNT ON

	DECLARE @Result		int
	BEGIN TRY
		BEGIN TRAN

		INSERT INTO dbo.StatsDailyQuiz ( ServerSetID, Useruid, Unituid, QuizNum, BoardNum, Answer, Reward_Day, Reward_Special, Reward_Month, Unitclass, [Level], Regdate, Reward_Month_BoardNum )
		VALUES ( @ServerSetID, @useruid, @unituid, @QuizNum, @BoardNum, @Answer, @Reward_Day, @Reward_Special, @Reward_Month, @Unitclass, @Level, @Regdate, @Reward_Month_BoardNum )

		COMMIT TRAN

		SET @Result = 0
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

		SET @Result = -1
	END CATCH

	SELECT @Result AS Result
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_insert_StatCCUMinuteChannel]
    @sdtRegDate			SMALLDATETIME
,	@iServerUID			INT
,	@iConcurrentUser	INT
, 	@ChannelCode		TINYINT
AS
	SET NOCOUNT ON
	
	DECLARE @Result				int

	BEGIN TRY
	 BEGIN TRAN

		INSERT INTO dbo.StatCCUMinuteChannel ( RegDate, ServerUID, CCU, ChannelCode )
		SELECT @sdtRegDate, @iServerUID, @iConcurrentUser, @ChannelCode
		
	 COMMIT TRAN

		SET @Result = 0
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE  smallint
		SET @NO_XACT_STATE		= XACT_STATE()

		 IF @NO_XACT_STATE <> 0
			 ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

		IF @Result = 0 OR @Result IS NULL
			SET @Result = -1
	END CATCH

	SELECT ISNULL(@Result, 0) AS Result
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_insert_spirit_log]
(
	@iUnitUID	bigint,
	@iPT	int,
	@iDT int,
	@iUsedSp smallint
)	

AS
SET NOCOUNT ON;


INSERT INTO dbo.StatsSpiritLog (UnitUID, PlayTime, DurationTime, UsedSpirit, Regdate)
	SELECT @iUnitUID, @iPT, @iDT, @iUsedSp, getdate()

--2010.07.01~2010.07.07 근성도 통계기록 프로시저
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_insert_securitytype_log]
	@iUserUID		BIGINT
,	@iSecurityType	TINYINT
,	@iAge			TINYINT
,	@sdtRegDate		SMALLDATETIME
,	@iOK            int = 0

AS
SET NOCOUNT ON;

BEGIN TRAN

    INSERT INTO dbo.LSecurityTypeLog WITH (UPDLOCK)(UserUID, SecurityType, Age, RegDate)
	    SELECT @iUserUID, @iSecurityType, @iAge, @sdtRegDate

		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN
			SELECT @iOK = -1
			GOTO FAIL_TRAN
		END   
		 
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_insert_retain_log]
	@iUserUID		BIGINT,
	@iUnitUID		BIGINT,
	@iItemID		INT,
	@sdtRegDate		SMALLDATETIME,
	@iOK			INT = 0
	
AS
SET NOCOUNT ON;

BEGIN TRAN

    INSERT INTO dbo.LRetainLog( UserUID, UnitUID, ItemID, RegDate)
		SELECT @iUserUID, @iUnitUID, @iItemID, @sdtRegDate
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	 GOTO FAIL_TRAN		END
    
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
-- =============================================
-- Author:	YJ
-- Create date: 2012.09.10
-- Description:	헤니르시공 랭킹 주별 보상 후 저장/패치시 백업
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[lup_insert_rank_spacetime_week]
	@iRank			TINYINT
,	@iUnitUID		BIGINT
,	@strNickName	NVARCHAR(16)
,	@iUnitClass		TINYINT
,	@iLevel			TINYINT
,	@iStage			TINYINT
,	@iPlayTime		SMALLINT
,	@sdtRegDate		SMALLDATETIME
,	@Type			INT
,	@StartMember	INT
,	@EndMember		INT
	
AS 
SET NOCOUNT ON;

IF @Type = 1 BEGIN -- 랭킹 리스트 일자별 저장

INSERT INTO dbo.Rank_SpaceTime_Week ([Rank], UnitUID, NickName, UnitClass, [Level], Stage, PlayTime, RegDate, StartMember, EndMember)
	SELECT @iRank,	@iUnitUID,	@strNickName, @iUnitClass, @iLevel, @iStage, @iPlayTime, @sdtRegDate, @StartMember, @EndMember

END
ELSE BEGIN -- 랭킹 리스트 패치시 백업

	INSERT INTO dbo.Rank_SpaceTime_Week_BAK ([Rank], UnitUID, NickName, UnitClass, [Level], Stage, PlayTime, RegDate)
		SELECT @iRank,	@iUnitUID,	@strNickName, @iUnitClass, @iLevel, @iStage, @iPlayTime, @sdtRegDate

END
GO
-- =============================================
-- Author:	YJ
-- Create date: 2012.09.10
-- Description:	헤니르시공 랭킹 월별 보상 후 저장/패치시 백업
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[lup_insert_rank_spacetime_month]
	@iRank			TINYINT
,	@iUnitUID		BIGINT
,	@strNickName	NVARCHAR(16)
,	@iUnitClass		TINYINT
,	@iLevel			TINYINT
,	@iStage			TINYINT
,	@iPlayTime		SMALLINT
,	@sdtRegDate		SMALLDATETIME
,	@Type			INT
,	@StartMember	INT
,	@EndMember		INT
	
AS 
SET NOCOUNT ON;

IF @Type = 1 BEGIN -- 랭킹 리스트 일자별 저장

INSERT INTO dbo.Rank_SpaceTime_Month ([Rank], UnitUID, NickName, UnitClass, [Level], Stage, PlayTime, RegDate, StartMember, EndMember)
	SELECT @iRank,	@iUnitUID,	@strNickName, @iUnitClass, @iLevel, @iStage, @iPlayTime, @sdtRegDate, @StartMember, @EndMember

END
ELSE BEGIN -- 랭킹 리스트 패치시 백업

	INSERT INTO dbo.Rank_SpaceTime_Month_BAK ([Rank], UnitUID, NickName, UnitClass, [Level], Stage, PlayTime, RegDate)
		SELECT @iRank,	@iUnitUID,	@strNickName, @iUnitClass, @iLevel, @iStage, @iPlayTime, @sdtRegDate

END
GO
-- =============================================
-- Author:	YJ
-- Create date: 2012.09.10
-- Description:	헤니르시공 랭킹 일별 보상 후 저장/패치시 백업
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[lup_insert_rank_spacetime_day]
	@iRank			TINYINT
,	@iUnitUID		BIGINT
,	@strNickName	NVARCHAR(16)
,	@iUnitClass		TINYINT
,	@iLevel			TINYINT
,	@iStage			TINYINT
,	@iPlayTime		SMALLINT
,	@sdtRegDate		SMALLDATETIME
,	@Type			INT
,	@StartMember	INT
,	@EndMember		INT

AS 
SET NOCOUNT ON;

IF @Type = 1 BEGIN -- 랭킹 리스트 일자별 저장

	INSERT INTO dbo.Rank_SpaceTime_Day ([Rank], UnitUID, NickName, UnitClass, [Level], Stage, PlayTime, RegDate, StartMember, EndMember)
		SELECT @iRank,	@iUnitUID,	@strNickName, @iUnitClass, @iLevel, @iStage, @iPlayTime, @sdtRegDate, @StartMember, @EndMember

END
ELSE BEGIN -- 랭킹 리스트 패치시 백업

	INSERT INTO dbo.Rank_SpaceTime_Day_BAK ([Rank], UnitUID, NickName, UnitClass, [Level], Stage, PlayTime, RegDate)
		SELECT @iRank,	@iUnitUID,	@strNickName, @iUnitClass, @iLevel, @iStage, @iPlayTime, @sdtRegDate

END
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_insert_querystats]
	@strQueryName	NVARCHAR(70)
,	@iMinTime		INT
,	@iAvgTime		INT
,	@iMaxTime		INT
,	@iOver1Sec		SMALLINT
,	@iQueryCnt		INT
,	@iQueryFail		SMALLINT

AS
SET NOCOUNT ON;


INSERT INTO dbo.QueryStats (QueryName, MinTime, AvgTime, MaxTime, Over1Sec, QueryCnt, QueryFail, RegDate)
	SELECT @strQueryName, @iMinTime, @iAvgTime, @iMaxTime, @iOver1Sec, @iQueryCnt, @iQueryFail, GETDATE()
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_insert_Product_list]
	@iProductNo			INT,	
	@iProductExpire		SMALLINT,
	@iProductPieces		SMALLINT,
	@iItemID			INT,
	@iSalePrice			INT,
	@iOK        [int] = 0
	
AS
SET NOCOUNT ON;

IF EXISTS (SELECT * FROM dbo.LProductList WITH (NOLOCK) WHERE ProductNo = @iProductNo)
	BEGIN	SELECT	@iOK = -2	GOTO END_PROC	END


BEGIN TRAN

	INSERT INTO dbo.LProductList (ProductNo, ProductExpire, ProductPieces, ItemID, SalePrice)
		SELECT @iProductNo, @iProductExpire, @iProductPieces, @iItemID, @iSalePrice

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	BEGIN	SELECT @iOK = -1	GOTO	FAIL_TRAN	END
	
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
/*	
	2008-06-18
	sutamtwo
	돈이 들어오고 나가는 상태 파악 (특정 유닛만)

	ELS_NONE = 0,

	ELS_DUNGEON_REWARD,			// [1]
	ELS_BUY_ED_ITEM,			// [2]
	ELS_BUY_ED_ITEM_ROLLBACK,	// [3]
	ELS_SELL_ED_ITEM,			// [4]
	ELS_OUT_TRADE,				// [5]
	ELS_IN_TRADE,				// [6]
	ELS_ITEM_REPAIR,			// [7]
	ELS_TRANING_REWARD,			// [8]
	ELS_MANUFACTURE,			// [9]
	ELS_PERSONAL_SHOP_OPEN,		// [10]
	ELS_IN_PERSONAL_SHOP,		// [11]
	ELS_OUT_PERSONAL_SHOP,		// [12]
	ELS_ITEM_ENCHANT,			// [13]
	ELS_ITEM_SOCKET,			// [14] 
	ELS_QUEST_REWARD			// [15]
*/

CREATE OR ALTER PROCEDURE [dbo].[lup_insert_moeny_log]
(
	@iUnitUID	bigint
,	@iState		tinyint
,	@iBMoney	int
,	@iAMoney	int
,	@iMoney		int
)

AS

SET NOCOUNT ON ;


	INSERT INTO dbo.StatsMoneyLog (UnitUID,	State, BMoney, AMoney, Money, RegDate)
		SELECT @iUnitUID, @iState, @iBMoney, @iAMoney, @iMoney,	GETDATE()
GO
/*	
	2010-10-13
	Hwang
	클라이언트 DDL 로그 남김
*/

CREATE OR ALTER PROCEDURE [dbo].[lup_insert_module_log]
	@strModuleName	NVARCHAR(20)
,	@iCount		BIGINT
,	@iBAllow			BIT
,	@iFlag				TINYINT
,	@iOK		INT = 0 
,   @iModuleUID int = 0

AS
SET NOCOUNT ON ;

BEGIN TRAN

		INSERT INTO dbo.LModuleTable ( ModuleName, [count], allow, flag )
		SELECT @strModuleName, @iCount, @iBAllow, @iFlag
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN	SELECT @iOK = -1  GOTO FAIL_TRAN  END
			
		SELECT @iModuleUID = @@IDENTITY
			
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK, @iModuleUID
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_insert_megaphone_log]
	@iUnitUID	bigint
,	@iItemID	int
,	@iOK		int = 0
	
AS

SET NOCOUNT ON;



BEGIN TRAN

	INSERT INTO	dbo.StatsMegaphone (UnitUID, ItemID, RegDate)
		SELECT 	@iUnitUID, @iItemID, GetDate()

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN
			SELECT @iOK = -1	GOTO FAIL_TRAN
		END

COMMIT TRAN

GOTO END_PROC


FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_insert_lvup]
@iCharUID_  bigint,
@iLvBefore_ tinyint,
@iLvAfter_  tinyint
AS
/* 
기능: 캐릭터 레벨업 기록을 남긴다.
In: iCharUID, iLevelBefore, iLevelAfter
Out: 

- Working example:
Exec lup_insert_lvup 1, 1, 1

*/

SET NOCOUNT ON;

DECLARE @CurDate smalldatetime
SET @CurDate = GetDate()

BEGIN TRAN 

-- 가장 처음 레벨 ( 1 ) 이라면 캐릭터 생성 시점이다. 시작시간만을 기록한다.
IF @iLvBefore_ = 1 AND @iLvAfter_ = 1
BEGIN
    INSERT INTO LCharLvUp( CharUID, Level, Start, Finish )
        VALUES( @iCharUID_, 1, GETDATE(), '2079-1-1' )

    IF @@ERROR <> 0
    BEGIN
        RAISERROR( '캐릭터 생성시점 시각 기록 실패', 16, 1, @iLvBefore_ )
        GOTO FAIL_PROC
    END
    ELSE 
    BEGIN
        COMMIT TRAN
        RETURN -- 초기 시작 시간만 기록하고 나면 바로 리턴.
    END    
END

-- 이전 레벨의 완료시점을 기록한다. (이젠 레벨 기록이 없다면 업데이트 안하고 그냥 다음으로 흘러감)
UPDATE LCharLvUp SET Finish = @CurDate WHERE CharUID = @iCharUID_ AND Level = @iLvBefore_
IF @@ERROR <> 0
BEGIN
    RAISERROR( '기존 레벨 완료시점 업데이트 오류. LvBefore:%d', 16, 1, @iLvBefore_ )
    GOTO FAIL_PROC
END

-- 레벨이 2계단 이상 상승했다면 중간에 건너뛴 레벨에 대한 기록도 남겨 주도록 한다.
IF @iLvAfter_ - @iLvBefore_ >= 2 
BEGIN
    DECLARE @iLv int
    SET @iLv = @iLvBefore_ + 1
    WHILE @iLv < @iLvAfter_
    BEGIN
        INSERT INTO LCharLvUp( CharUID, Level, Start, Finish )
            VALUES( @iCharUID_, @iLv, @CurDate, @CurDate )
        IF @@ERROR <> 0
        BEGIN
            RAISERROR( '중간에 건너뛴 레벨들 기록 실패. LvBefore:%d, LvAfter:%d', 16, 1, @iLvBefore_, @iLvAfter_ )
            GOTO FAIL_PROC
        END
        SET @iLv = @iLv + 1
    END
END

-- 현재 레벨의 시작시점을 기록한다.
INSERT INTO LCharLvUp( CharUID, Level, Start, Finish ) VALUES( @iCharUID_, @iLvAfter_, @CurDate, '2079-1-1' )
IF @@ERROR <> 0
BEGIN
    RAISERROR( '레벨업 기록 실패. LvBefore:%d, LvAfter:%d', 16, 1, @iLvBefore_, @iLvAfter_ )
    GOTO FAIL_PROC
END

COMMIT TRAN
RETURN

FAIL_PROC:
ROLLBACK TRAN
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_insert_LPost_TradeMonitor]
	@iToUnitUID		BIGINT,
	@sdtRegDate		SMALLDATETIME,
	@iType			TINYINT,
	@iOK			[int] = 0	

AS
SET NOCOUNT ON;			
					

IF EXISTS (SELECT * FROM dbo.LPost_TradeMonitor WITH (NOLOCK) WHERE ToUnitUID = @iToUnitUID AND [Type] = @iType)
	BEGIN	SELECT	@iOK = -10	GOTO END_PROC	END

DECLARE @iUserUID BIGINT
SELECT @iUserUID = UserUID FROM dbo.UnitStatistics WITH (NOLOCK) WHERE unitUID = @iToUnitUID
	
BEGIN TRAN	

	INSERT INTO dbo.LPost_TradeMonitor (ToUnitUID, RegDate, [Type])
		SELECT @iToUnitUID, @sdtRegDate, @iType
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1				
				BEGIN	SELECT @iOK = -11	GOTO FAIL_TRAN	END
		
	UPDATE dbo.ReleaseTick
		SET [Count] = [Count] + 1
			WHERE [Type] = 1
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1				
				BEGIN	SELECT @iOK = -13	GOTO FAIL_TRAN	END	

COMMIT TRAN						
						
GOTO END_PROC						
						
FAIL_TRAN:						
ROLLBACK TRAN						
						
END_PROC:						
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_insert_LItemSynthesis]
	@ServerSetID				tinyint
,	@UnitUID					bigint
,	@Level						tinyint
,	@BeforeItemUID_1			bigint
,	@BeforeItemUID_2			bigint
,	@BeforeItemUID_3			bigint
,	@BeforeItemUID_4			bigint
,	@BeforeItemUID_5			bigint
,	@AfterItemUID				bigint
,	@AfterItemID				bigint
AS
	SET NOCOUNT ON

	DECLARE @Result	int

	BEGIN TRY

		INSERT INTO dbo.LItemSynthesis ( ServerSetID, UnitUID, [Level], BeforeItemUID_1, BeforeItemUID_2, BeforeItemUID_3, BeforeItemUID_4, BeforeItemUID_5, AfterItemUID, AfterItemID, RegDate )
		VALUES ( @ServerSetID, @UnitUID, @Level, @BeforeItemUID_1, @BeforeItemUID_2, @BeforeItemUID_3, @BeforeItemUID_4, @BeforeItemUID_5, @AfterItemUID, @AfterItemID, GETDATE() )

		SET @Result = 0
	END TRY
	BEGIN CATCH
		SET @Result = -1
	END CATCH

	SELECT @Result
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_insert_jackpot_log]
	@iUnitUID	bigint
,	@iItemID	int
,	@iDurationTime	int
,	@sdtRegDate	smalldatetime
,	@iOK		int = 0

AS
SET NOCOUNT ON;

BEGIN TRAN
	INSERT INTO dbo.StatsJackPot (UnitUID, ItemID, DurationTime, RegDate)
		SELECT @iUnitUID, @iItemID, @iDurationTime, @sdtRegDate
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END
		
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_insert_Item_Log]
	@iItemID			INT,
	@iTrade				INT,
	@iPShop				INT,
	@iTBoard			INT,
	@iBuy				INT,
	@iSell				INT,
	@iUse				INT,
	@iMake				INT,
	@iFailed			INT,
	@iDrop				INT,
	@iQuest				INT,
	@iEquip				INT,
	@iRandom			INT,
	@iResolve			INT,
	@iR_Result			INT,
	@iMall				INT,
	@iPost				INT,
	@iAttrib			INT,
	@iExchange_S		INT,
	@iExchange_R		INT,
	@iDiscard			INT,
	@iPetFeed			INT,
	@sdtRegDate			SMALLDATETIME,
	@iServerUID			INT,
	@iRegPShop			INT,
	@iBuyPShopAgency	INT,
	@iPickUpPShop		INT,
	@iOK				INT = 0
	
AS
SET NOCOUNT ON;

BEGIN TRAN

	INSERT INTO dbo.LItemLog (ItemID, Trade, PShop, TBoard, Buy, Sell, [Use], Make, Failed, [Drop], Quest, Equip, Random, Resolve, R_Result, Mall, Post, Attrib,
							  Exchange_S, Exchange_R, Discard, PetFeed, RegDate, ServerUID, RegPShop, BuyPShopAgency, PickUpPShop)
		SELECT  @iItemID, @iTrade, @iPShop, @iTBoard, @iBuy, @iSell, @iUse, @iMake, @iFailed, @iDrop, @iQuest, @iEquip, @iRandom, @iResolve, @iR_Result,
				@iMall, @iPost, @iAttrib, @iExchange_S, @iExchange_R, @iDiscard, @iPetFeed, @sdtRegDate, @iServerUID, @iRegPShop, @iBuyPShopAgency, @iPickUpPShop
	
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -112	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
/* 
	2008. 05. 21
	sutamtwo
	특정 유저가 얻는 아이템 로그 
*/
CREATE OR ALTER PROCEDURE [dbo].[lup_insert_getitem_log]
	@iUnitUID	bigint
,	@iRewardState tinyint
,	@iItemID	int
,	@iQuantity	tinyint
,	@iOK		int = 0
AS 

SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE	@sdtNow	smalldatetime
SELECT	@sdtNow	= GetDate()


	INSERT INTO dbo.StatsGetItemLog (UnitUID, RewardState, ItemID, Quantity, RegDate)
		SELECT @iUnitUID, @iRewardState, @iItemID, @iQuantity, @sdtNow
	
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN
			SELECT @iOK = -1
		END

SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_insert_Equipment_Log]
	@iUnitUID			BIGINT,
	@iUnitLevel			TINYINT,
	@iDungeonID			INT,
	@iDifficulty		TINYINT,
	@iWeaponLevel		TINYINT,
	@iWeaponClass		TINYINT,
	@iPhysicalAttack	INT,
	@iMagicAttack		INT,
	@sdtRegDate			SMALLDATETIME,
	@iOK				INT = 0
	
AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRAN

	INSERT INTO dbo.LEquipmentLog (UnitUID, UnitLevel, DungeonID, Difficulty, WeaponLevel, WeaponClass, PhysicalAttack, MagicAttack, Regdate)
	    SELECT @iUnitUID, @iUnitLevel, @iDungeonID, @iDifficulty, @iWeaponLevel, @iWeaponClass, @iPhysicalAttack, @iMagicAttack, @sdtRegDate
			   
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -111	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_insert_enchant_log_new]
	@iUnitUID		bigint
,	@iItemUID		bigint
,	@iItemID		int
,	@bIsPluor		bit		-- 플루오르스톤 사용 유무(0: 사용안함/1: 사용)
,	@iBeforeELv		tinyint	-- 강화 전 레벨
,	@iAfterELv		tinyint	-- 강화 후 레벨
,	@iEnchantType	tinyint	-- 강화 결과( 1: 강화 성공/2: 파손/3: 변화없음/4: 하락/5: 초기화[0강])
,	@dtRegDate		datetime
AS
	SET NOCOUNT ON
	
	DECLARE @Result			int

	BEGIN TRY
		BEGIN TRAN

		INSERT INTO dbo.LEnchantLog( UnitUID, ItemUID, ItemID, IsPluor, BeforeELv, AfterELv, EnchantType, RegDate )
		VALUES( @iUnitUID, @iItemUID, @iItemID, @bIsPluor, @iBeforeELv, @iAfterELv, @iEnchantType, @dtRegDate )

		COMMIT TRAN
		
		SET @Result = 0
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE
		
		IF @Result = 0 OR @Result IS NULL
			SET @Result = -1
	END CATCH
	
	SELECT ISNULL(@Result, 0) AS Result
GO
/*
	2008. 06. 11
	sutamtwo
	아이템 강화 로그

	ERS_NONE = 0,		비정상결과
	ERS_SUCCESS = 1		성공
	ERS_NO_CHANGE, = 2  변화없음
	ERS_LEVEL_DOWN, = 3 레벨 하락
	ERS_RESET, = 4      레벨 초기화
	ERS_BROKEN, = 5     아이템 파괴 
*/
CREATE OR ALTER PROCEDURE [dbo].[lup_insert_enchant_log]
	@iUserUID	bigint
,	@iUnitUID	bigint
,	@iItemID	int
,	@iItemUID	bigint
,	@iTryELevel	tinyint
,	@iResult	tinyint
,	@iOK		int = 0
	
AS

SET NOCOUNT ON;


INSERT INTO	dbo.StatsEnchantLog (UserUID, UnitUID, ItemID, ItemUID, TryELevel,	Result)
	SELECT 	@iUserUID, @iUnitUID , @iItemID, @iItemUID, @iTryELevel, @iResult

IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	BEGIN
		SELECT @iOK = -1	
	END

SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_insert_catch_hackuser_info] 
	@USERUID BIGINT,
	@UNITUID BIGINT,
	@CrashType	INT

AS

SET NOCOUNT ON;

	INSERT INTO DBO.LCatchHackuserInfo (USERUID, UNITUID, CrashType, REGDATE)
	VALUES (@USERUID,  @UNITUID, @CrashType, GETDATE())

	RETURN @@ERROR
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_insert_CashSales_Log]
	@iUserUID		bigint,
	@iUnitUID		bigint,
	@iUnitClass		TINYINT,
	@iLevel			TINYINT,
	@iProductNo		INT,
	@iBuyQuantity	int,
	@iTotalPrice	int,
	@sdtRegDate		SMALLDATETIME,
	@bFirstBuy		BIT,
	@iBuyType		TINYINT,
	@strUserID		NVARCHAR(24),
	@iOK			INT = 0
	
AS
SET NOCOUNT ON;


BEGIN TRAN

	INSERT INTO dbo.LCashSalesLog (UserUID, UnitUID, UnitClass, [Level], ProductNo, BuyQuantity, TotalPrice, RegDate, FirstBuy, BuyType, OrderID)
	    SELECT  @iUserUID, @iUnitUID, @iUnitClass, @iLevel, @iProductNo, @iBuyQuantity, @iTotalPrice, @sdtRegDate, @bFirstBuy, @iBuyType, @strUserID
			   
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_insert_cash_log]
	@iUnitUID	bigint 
,	@iItemID	int
,	@iPeriod	smallint
,	@iQuantity	SMALLINT
,	@iLevel		TINYINT
,	@iUnitClass	tinyint
,	@iOK		int = 0
AS
SET NOCOUNT ON;

DECLARE	@sdtNow smalldatetime
SELECT	@sdtNow = GETDATE()

BEGIN TRAN

	INSERT INTO dbo.StatsCashLog (UnitUID, ItemID, Period, Quantity, RegDate, [Level], UnitClass)
		SELECT @iUnitUID, @iItemID, @iPeriod, @iQuantity, @sdtNow, @iLevel, @iUnitClass
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_insert_allskilldelete]
(
	@iUnitUID	BIGINT
,	@iItemUID	BIGINT	
,	@iSPoint	INT
,	@iCSP		INT
,	@iOK		INT	= 0
)
AS

SET NOCOUNT ON;
SET XACT_ABORT ON ;


/*
	2009. 06. 03
	sutamtwo
	스킬 전체 초기화 사용 로그
*/



BEGIN TRAN

	INSERT INTO dbo.StatsAllSkillDelete (UnitUID, ItemUID, SPoint, CSP, RegDate)
		SELECT @iUnitUID, @iItemUID, @iSPoint, @iCSP, GETDATE()
	
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END
	
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
/*
	2008. 11. 03	
	sutamtwo
	어뷰저 리스트에 등록, Tick 값 갱신
*/


CREATE OR ALTER PROCEDURE [dbo].[lup_insert_abuser_list]
	@iType			tinyint
,	@iUnitUID		bigint
,	@iOK			int = 0
AS
SET NOCOUNT ON;

----	닉네임으로 UnitUID 찾아내기
--DECLARE	@iUnitUID	bigint
--SELECT	@iUnitUID = UnitUID
--	FROM [Game01].[dbo].[GUnitNickName] WITH (NOLOCK)
--		WHERE NickName = @strNickName


----	존재하지 않는 닉네임
--IF (@iUnitUID IS NULL)
--	BEGIN	SELECT @iOK = -1	GOTO END_PROC	END

--	이미 등록된 닉네임
IF	EXISTS (SELECT * FROM dbo.AbuserList WITH (NOLOCK) WHERE UnitUID = @iUnitUID AND Type = @iType)
	BEGIN	SELECT @iOK = -2	GOTO END_PROC	END




BEGIN TRAN

	INSERT INTO dbo.AbuserList (Type, UnitUID)
		SELECT @iType, @iUnitUID

	IF NOT EXISTS (SELECT * FROM dbo.ReleaseTick WITH (NOLOCK) WHERE Type = @iType)
		BEGIN
			INSERT INTO dbo.ReleaseTick (Type, Count)
				SELECT @iType, 1	

			IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
				BEGIN	SELECT @iOK = -3	GOTO FAIL_TRAN	END
		END
	ELSE
		BEGIN
			UPDATE dbo.ReleaseTick
				SET Count = Count + 1
					WHERE Type = @iType
			IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
				BEGIN	SELECT @iOK = -4	GOTO FAIL_TRAN	END
		END

COMMIT TRAN



GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN


END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_insert_abnormal_reason]
	@iServerUID	INT
,	@iReason	INT
,	@iCnt		INT

/*
	2009. 09. 01
	sutamtwo
	알 수 없는 비정상 종료의 값을 체크
*/

AS

SET NOCOUNT ON;

DECLARE @sdtNow smalldatetime
SELECT  @sdtNow = GetDate()

INSERT INTO dbo.StatsAbnormalReason (ServerUID, Reason, Cnt, RegDate)
	SELECT @iServerUID, @iReason, @iCnt, @sdtNow
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_get_yesterday_ccu]	
	@iServerUID	smallint
AS
SET NOCOUNT ON;

	SELECT regdate, serveruid, ccu 
		FROM dbo.StatCCUMinute WITH (NOLOCK)
			WHERE regdate BETWEEN convert(varchar(10),getdate()-1,120)+' 00:00:00' AND convert(varchar(10),getdate()-1,120)+' 23:59:00' 
				AND ServerUID = @iServerUID
					ORDER BY regdate
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_get_ToolServer_list]

AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

SELECT  ServerUID,
		ServerSetID,
		ServerType,
		ChannelID,
		ChannelName,
		IP,
		Port
    FROM dbo.LToolServerList WITH (NOLOCK)
	ORDER BY ChannelID
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_get_today_ccu]	
	@iServerUID	smallint
AS
SET NOCOUNT ON;

	SELECT regdate, serveruid, ccu 
		FROM dbo.StatCCUMinute WITH (NOLOCK)
			WHERE regdate between convert(varchar(10),getdate(),120)+' 00:00:00' and getdate()
				AND ServerUID = @iServerUID
					ORDER BY regdate
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_get_square_list]
	@strServerIP	NVARCHAR(20)

AS
SET NOCOUNT ON;

SELECT [Type], [NAME]
	FROM dbo.LSquareTable WITH (NOLOCK)
		WHERE IP = @strServerIP
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_get_server_list]
AS
SET NOCOUNT ON;

SELECT  [UID]
,       [Name]
,       ServerSetID
,       ServerType
,       IP
,       Port1
,       Port2
,       MaxConcurrentUser
,       ConcurrentUser
,       [Enable]
    FROM dbo.LServerList WITH (NOLOCK)
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_get_server_concurrent_user]
AS
SET NOCOUNT ON;

SELECT  SUM( ConcurrentUser )
    FROM dbo.LServerList WITH (NOLOCK)
	WHERE ServerType = 3 AND Enable = 1
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_get_release_tick]

AS
SET NOCOUNT ON;

SELECT Type, Count
	FROM dbo.ReleaseTick WITH (NOLOCK)
		ORDER BY TYPE
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_get_rank_spacetime_week]
	
	
/*
	2009. 07. 07
	sutamtwo
	주간 랭킹 기록 읽어가기
*/	
	
AS 
SET NOCOUNT ON;

DECLARE @sdtNow	SMALLDATETIME
SELECT @sdtNow = (SELECT TOP 1 Date FROM Rank_SpaceTime_Week WITH (NOLOCK) ORDER BY Date DESC )
	

SELECT [Rank], UnitUID, NickName, UnitClass, [Level], Stage, PlayTime, RegDate
	FROM dbo.Rank_SpaceTime_Week WITH (NOLOCK)
		WHERE Date = @sdtNow
			ORDER BY [Rank]
				OPTION (MAXDOP 1)
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_get_rank_spacetime_month]
	
	
/*
	2009. 07. 07
	sutamtwo
	월간 랭킹 기록 읽어가기
*/	
	
AS 
SET NOCOUNT ON;

DECLARE @sdtNow	SMALLDATETIME
SELECT @sdtNow = (SELECT TOP 1 Date FROM dbo.Rank_SpaceTime_Month WITH (NOLOCK) ORDER BY Date DESC )
	

SELECT [Rank], UnitUID, NickName, UnitClass, [Level], Stage, PlayTime, RegDate
	FROM dbo.Rank_SpaceTime_Month WITH (NOLOCK)
		WHERE Date = @sdtNow
			ORDER BY [Rank]
				OPTION (MAXDOP 1)
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_get_rank_spacetime_day]
	
	
/*
	2009. 07. 07
	sutamtwo
	일간 랭킹 기록 읽어가기
*/	
	
AS 
SET NOCOUNT ON;

DECLARE @sdtNow	SMALLDATETIME
SELECT @sdtNow = (SELECT TOP 1 Date FROM Rank_SpaceTime_Day WITH (NOLOCK) ORDER BY Date DESC )
	

SELECT [Rank], UnitUID, NickName, UnitClass, [Level], Stage, PlayTime, RegDate
	FROM dbo.Rank_SpaceTime_Day WITH (NOLOCK)
		WHERE Date = @sdtNow
			ORDER BY [Rank]
				OPTION (MAXDOP 1)
GO
/*
	2011. 04. 25	
	Hwang
*/		

CREATE OR ALTER PROCEDURE [dbo].[lup_get_ProtectedCrystalCount]	
	@sdtWsrtStartTime	smalldatetime	
AS
SET NOCOUNT ON;

	SELECT TargetCrystal, ProtectedCrystalCount
		FROM dbo.LDefense_Crystal WITH (NOLOCK)
			WHERE WsrtStartTime = @sdtWsrtStartTime
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_get_nowtime_ccu]	
	@iServerUID	smallint,
	@strDate	smalldatetime
AS
SET NOCOUNT ON;

	SELECT regdate, serveruid, ccu 
		FROM dbo.StatCCUMinute WITH (NOLOCK)
			WHERE regdate between @strDate and getdate()
				AND ServerUID = @iServerUID
					ORDER BY regdate
GO
/*	
	2010-10-13
	Hwang
	모듈리스트 긁어가기
*/

CREATE OR ALTER PROCEDURE [dbo].[lup_get_module_log]
AS
SET NOCOUNT ON ;

SELECT ModuleUID, ModuleName, [count]
	FROM dbo.LModuleTable WITH (NOLOCK)
GO
/*
	2011.12.07
	김병일
	: Channel 서버 목록(GameServer 목록 아님 - dbo.LChannelList 와 관련 없음)
*/
CREATE OR ALTER PROCEDURE [dbo].[lup_get_LServerChannelList]
AS
	SET NOCOUNT ON

	SELECT A.ServerSetOrder, A.ServerSetID, A.ServerSetName, IP, Port1, Port2, [Enable]
	FROM dbo.LServerSetList AS A WITH(NOLOCK)
	JOIN dbo.LServerList AS B WITH(NOLOCK)
		ON A.ServerSetID = B.ServerSetID
	WHERE ServerType = 4
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_get_login_proxy_info]
	@iServerGroupID		TINYINT

AS
SET NOCOUNT ON;

	SELECT A.ProxyID, B.IP, B.Port1
	FROM dbo.LLoginProxy AS A WITH (NOLOCK) JOIN dbo.LServerList AS B WITH (NOLOCK)
	ON A.ServerSetID = B.ServerSetID AND A.ServerUID = B.UID
	WHERE A.ServerSetID = @iServerGroupID
	ORDER BY A.ProxyID ASC
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_get_login_proxy_id_by_serveruid]
	@iServerUID		INT

AS
SET NOCOUNT ON;

SELECT ProxyID 
	FROM dbo.LLoginProxy WITH (NOLOCK)
		WHERE ServerUID = @iServerUID
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[lup_get_LLoginProxy]
	@iServerGroupID		TINYINT

AS
SET NOCOUNT ON;

	SELECT A.ProxyID, B.IP, B.Port1
	FROM dbo.LLoginProxy AS A WITH (NOLOCK) JOIN dbo.LServerList AS B WITH (NOLOCK)
	ON A.ServerSetID = B.ServerSetID AND A.ServerUID = B.UID
	WHERE A.ServerSetID = @iServerGroupID
	ORDER BY A.ProxyID ASC
GO
/*
	2011.10.06
	김병일
	스크립트 수정
--$$ 원본 주석 시작 lup_get_global_proxy_info
	주석 없음
--$$ 원본 주석 끝
*/
CREATE OR ALTER PROCEDURE [dbo].[lup_get_LGlobalProxy]
	@iServerGroupID		tinyint
AS
	SET NOCOUNT ON

	SELECT A.ProxyID, B.IP, B.Port1
	FROM dbo.LGlobalProxy AS A WITH(NOLOCK)
	JOIN dbo.LServerList AS B WITH(NOLOCK)
		ON A.ServerSetID = B.ServerSetID AND A.ServerUID = B.[UID]
	WHERE A.ServerSetID = @iServerGroupID
	ORDER BY A.ProxyID
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_get_hackprocess_list]

/*
	2010.02.12
	sutamtwo
	해킹 프로세스 리스트 정보 읽기
*/

AS
SET NOCOUNT ON;

SELECT ProcessName, ClassName, ListType
	FROM dbo.LHackProcessList WITH (NOLOCK)
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_get_global_proxy_info]
	@iServerGroupID		TINYINT

AS
SET NOCOUNT ON;

	SELECT A.ProxyID, B.IP, B.Port1
	FROM dbo.LGlobalProxy AS A WITH (NOLOCK) JOIN dbo.LServerList AS B WITH (NOLOCK)
	ON A.ServerSetID = B.ServerSetID AND A.ServerUID = B.UID
	WHERE A.ServerSetID = @iServerGroupID 
	ORDER BY A.ProxyID ASC
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_get_expo_event]
	@iServerUID int


/*
	Hwang	
	2010. 11. 19
	엑스포 이벤트 관련 리스트 정보 읽기
*/
	

AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

SELECT ID,			
	   NPCID,
	   DropDate
    FROM dbo.LExpo_Event WITH (NOLOCK)
	WHERE ServerUID = @iServerUID AND DropDate > GETDATE()
		ORDER BY DropDate
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_get_event]
AS
SET NOCOUNT ON;

DECLARE	@sdtNow smalldatetime
SELECT	@sdtNow = GETDATE()


SELECT EventID,	EventName, EventType, CONVERT(NVARCHAR(19),BeginDate,120) as BeginDate, CONVERT(NVARCHAR(19), EndDate, 120) as EndDate, ScriptID,	OnOff
	FROM dbo.EventInfo WITH (NOLOCK)
		WHERE EndDate >= @sdtNow
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_get_drop_event]


/*
	sutamtwo	
	2009. 05. 25
	드랍 아이템 관련 이벤트 리스트 정보 읽기
*/
	

AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

SELECT	ID
,		ItemID
,		DropTime
,		ServerIP
,		Flag
,		IsNotice
    FROM dbo.DropEvent	WITH (NOLOCK)
		ORDER BY ID
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_get_date_ccu]	
	@iServerUID	smallint,
	@strDate	smalldatetime
AS
SET NOCOUNT ON;

	SELECT regdate, serveruid, ccu 
		FROM dbo.StatCCUMinute WITH (NOLOCK)
			WHERE regdate BETWEEN convert(varchar(10),@strDate,120)+' 00:00:00' AND convert(varchar(10),@strDate,120)+' 23:59:00' 
				AND ServerUID = @iServerUID
					ORDER BY regdate
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_get_Christmas_event]


/*
	Hwang	
	2010. 12. 20
	크리스마스 이벤트 관련 리스트 정보 읽기
*/
	

AS
SET NOCOUNT ON;

SELECT ID, ItemID, DropTime, UpdTime, UserUID, UnitUID, DropEndTime, CubeID
FROM dbo.LEvent_Christmas WITH (NOLOCK)
ORDER BY DropTime
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_get_channelid_by_serveruid]
	@iServerUID		INT

AS
SET NOCOUNT ON;

SELECT ChannelID
	FROM dbo.LChannelList WITH (NOLOCK)
		WHERE [UID] = @iServerUID
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_get_channel_reward]
	@iChannelID	INT


AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

SELECT	ChannelID
,		StartLv
,		EndLv
,		PerEXP
,		PerED
	FROM dbo.LChannelReward WITH (NOLOCK)
		WHERE ChannelID = @iChannelID
			OPTION (MAXDOP 1)
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_get_channel_list]
	@iServerSetID	int

AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

SELECT  [UID]
,		ChannelID
,       ChannelName
,       ServerSetID
,       IP
,       Port1
,       Port2
,       MaxConcurrentUser
,       ConcurrentUser
,		MakePartyCNT		
,		PlayPartyCNT
    FROM dbo.LChannelList WITH (NOLOCK)
		WHERE ServerSetID = @iServerSetID
			AND OnOff = 1
	ORDER BY ChannelID
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_get_center_proxy_info]
	@iServerGroupID		TINYINT

AS
SET NOCOUNT ON;

SELECT A.ProxyID, B.IP, B.Port1 
FROM dbo.LCenterProxy AS A WITH (NOLOCK)
JOIN dbo.LServerList AS B WITH (NOLOCK)
ON A.ServerSetID = B.ServerSetID AND A.ServerUID = B.UID
WHERE A.ServerSetID = @iServerGroupID 
ORDER BY A.ProxyID ASC
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_get_center_proxy_id_by_serveruid]
	@iServerUID		INT

AS
SET NOCOUNT ON;

SELECT ProxyID
	FROM dbo.LCenterProxy WITH (NOLOCK)
		WHERE ServerUID = @iServerUID
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_get_ArenaUID]
	@iOK [int] = 0
	
AS
SET NOCOUNT ON;

DECLARE @iArenaUID BIGINT

BEGIN TRAN

	UPDATE dbo.LArenaUIDCreate
		SET ArenaUID = ArenaUID + 1
			where [type] = 1
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END

	SELECT @iArenaUID = ArenaUID
		FROM dbo.LArenaUIDCreate WITH (NOLOCK)
		
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK, @iArenaUID
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_get_abuser_list]
	@iType	tinyint

AS
SET NOCOUNT ON;

SELECT UnitUID
	FROM dbo.AbuserList WITH (NOLOCK)
		WHERE Type = @iType
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_delete_rank_spacetime_week]
	
	
/*
	2009. 07. 07
	sutamtwo
	주간 랭킹 비우기
*/	
	
AS 
SET NOCOUNT ON;

TRUNCATE TABLE dbo.Rank_SpaceTime_Week
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_delete_rank_spacetime_month]
	
	
/*
	2009. 07. 07
	sutamtwo
	월간 랭킹 비우기
*/	
	
AS 
SET NOCOUNT ON;

TRUNCATE TABLE dbo.Rank_SpaceTime_Month
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_delete_rank_spacetime_day]
	
	
/*
	2009. 07. 07
	sutamtwo
	일간 랭킹 비우기
*/	
	
AS 
SET NOCOUNT ON;

TRUNCATE TABLE dbo.Rank_SpaceTime_Day
GO
/* 
기능: 매분 게임서버 동접수를 모두 합한 전체 동접을 계산해 기록한다.

*/

CREATE OR ALTER PROCEDURE [dbo].[lup__ccu_minute]
AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

INSERT INTO dbo.StatCCUMinute(ServerUID, CCU)
	SELECT [UID], ConcurrentUser FROM dbo.LServerList WITH (NOLOCK) WHERE ServerType = 3 AND [UID] < 100 UNION ALL
	SELECT 0, SUM(ConcurrentUser) FROM dbo.LServerList WITH (NOLOCK) WHERE ServerType = 3 AND [UID] < 100
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_UnitStatistics_UnitClass_UPD]
	@iServerSetID		TINYINT,
    @iUnitUID   [bigint],
    @iUnitClass [tinyint],
    @iOK        [int] = 0
AS

SET NOCOUNT ON;

-- 해당 유닛이 없는 경우.
IF NOT EXISTS (SELECT * FROM dbo.UnitStatistics	WITH (NOLOCK) WHERE UnitUID = @iUnitUID)
    GOTO END_PROC

BEGIN TRAN

    UPDATE dbo.UnitStatistics WITH( ROWLOCK )
        SET UnitClass = @iUnitClass
			WHERE UnitUID = @iUnitUID

		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -3	GOTO FAIL_TRAN	END


COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_UnitStatistics_Rena2_SEL]
	@iServerSetID		TINYINT
AS
SET NOCOUNT ON;

SELECT [LEVEL], COUNT(*)
	FROM dbo.UnitStatistics WITH (NOLOCK)
		WHERE IsFirst = 0 AND Deleted = 0 AND UnitClass in (12, 13)
			GROUP BY LEVEL ORDER BY LEVEL
				OPTION (MAXDOP 1)
GO
-- =============================================
-- Author:		microcat
-- Create date: 2009년 03월 12일
-- Description: UnitStatistics 정보 갱신
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_UnitStatistics_Once_SET]
	@iServerSetID		TINYINT
,	@iUnitUID  [bigint]
,	@iOK_   [int] = 0
AS
/*
	sutamtwo 
	작성일 : 2007년 10월 29일
	사용 : UnitStatistics 정보 갱신

	수정일 : 2009년 03월 12일
	수정자 : microcat
	내용 : DeadLock (혹은 Block)으로 인한 Index (UserUID에 Non-Clustered) 생성, Transaction 밖으로 Declare 및 Select 문 빼기

*/
SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE @iUserUID  bigint
,		@sdtLastDate smalldatetime
,		@iPlayDayCnt smallint
,		@iLoginCount int
,		@bDeleted  bit
,		@iLevel   tinyint
,		@iExp   int
,		@iGamepoint  int
,		@iVsPoint  int
,		@iVsPointMax int
,		@iSPoint  smallint
,		@iCharNo  tinyint
,		@iVsCnt   int
,		@iDSoloCnt  int
,		@iDPartyCnt  int
,		@iVsWinCnt  int
,		@iVsLoseCnt  int
,		@iVsDrawCnt  int 
,		@iDSoloWinCnt int
,		@iDPartyWinCnt int
,		@iVSPlayTime int
,		@iDSoloPlayTime int
,		@iDPartyPlayTime int
,		@iVsRank  bigint
,		@iExpRank  bigint
,		@iSkill_Cnt  tinyint
,		@iQuest_Cnt  tinyint
,		@iQuest_Re_Cnt tinyint
,		@iTutoWin_Cnt smallint
,		@iTraWin_Cnt smallint
,		@iTutoPlayTime int
,		@iTrainingPT int
,		@iBestUnitUID int



 -- GUnit에 존재한다면,
IF EXISTS (SELECT * FROM [Game01].[dbo].[GUnit] WITH (NOLOCK) WHERE UnitUid = @iUnitUID)
BEGIN 
	SELECT @iUserUID = UserUID FROM [Game01].[dbo].[GUnit] WITH (NOLOCK) WHERE UnitUid = @iUnitUID
   
   -- 튜토리얼 Play Time 구하기
	SELECT @iTutoPlayTime = (SUM(SW_TIME) + SUM(SL_TIME) + SUM(SG_TIME))
		FROM dbo.StatsDungeon WITH (NOLOCK)
			WHERE UnitUID = @iUnitUID
				AND DungeonID IN (30030,30031,30032,30033,30034)
  
   -- 훈련소 Play Time 구하기
	SELECT @iTrainingPT = SUM(Win_Time + Lose_Time + GiveUp_Time)
		FROM dbo.StatsTraining WITH (NOLOCK)
			WHERE Unituid = @iUnitUID


   -- 대전 관련 정보 수집
	SELECT	@iVsCnt = ISNULL((TMW_CNT+TML_CNT+TMG_CNT+TMD_CNT+TDW_CNT+TDL_CNT+TDNAN_CNT+TDG_CNT+TDD_CNT+DW_CNT+DL_CNT+DG_CNT+DNAN_CNT+DD_CNT),0)
,			@iVsWinCnt = ISNULL((TMW_CNT+TDW_CNT+DW_CNT),0)
,			@iVsLoseCnt = ISNULL((TML_CNT+TDL_CNT+DL_CNT),0) 
,			@iVsDrawCnt = ISNULL((TMD_CNT+TDD_CNT+DD_CNT),0)      
,			@iVSPlayTime = ISNULL((TMW_TIME + TML_TIME + TMG_TIME + TMD_TIME + TDW_TIME + TDL_TIME + TDG_TIME + TDD_TIME + DW_TIME + DL_TIME + DG_TIME + DD_TIME ),0)
		FROM dbo.StatsVs WITH (NOLOCK) 
			WHERE unituid = @iUnitUID

   -- 던전 관련 정보 수집
   SELECT	@iDSoloCnt = (SUM(SW_CNT) + SUM(SL_CNT) + SUM(SG_CNT))  
,			@iDPartyCnt = (SUM(PW_CNT) + SUM(PL_CNT) + SUM(PG_CNT)) 
,			@iDSoloWinCnt = SUM(SW_CNT)
,			@iDPartyWinCnt = SUM(PW_CNT) 
,			@iDSoloPlayTime = (SUM(SW_TIME) + SUM(SL_TIME) + SUM(SG_TIME))
,			@iDPartyPlayTime = (SUM(PW_TIME) + SUM(PL_TIME) + SUM(PG_TIME))
	FROM dbo.StatsDungeon WITH (NOLOCK)
		WHERE UnitUID = @iUnitUID
			AND DungeonID IN (30030,30031,30032,30033,30034)

   -- 스킬, 퀘스트 정보 수집
   SELECT @iSkill_Cnt = COUNT(*) FROM [Game01].[dbo].[GSkill] WITH (NOLOCK) WHERE UnitUID = @iUnitUID
   SELECT @iQuest_Cnt = COUNT(*) FROM [Game01].[dbo].[GQuests_Complete] WITH (NOLOCK) WHERE UnitUID = @iUnitUID
   SELECT @iQuest_Re_Cnt = COUNT(*) FROM [Game01].[dbo].[GQuests_Repeat] WITH (NOLOCK) WHERE UnitUID = @iUnitUID
   
   -- 초보 적응도 파악 (튜토리얼 + 훈련소 승 수)
   SELECT @iTraWin_Cnt = ISNULL(SUM(WIN_CNT),0) FROM dbo.StatsTraining WITH (NOLOCK) WHERE UNITUID = @iUnitUID
   SELECT @iTutoWin_Cnt = ISNULL(SW_CNT,0) FROM DBO.STATSDUNGEON WITH (NOLOCK) WHERE UNITUID = @iUnitUID AND DUNGEONID IN (30030,30031,30032,30033,30034)

   -- 캐릭터 수 파악
   SELECT @iCharNo = COUNT(Deleted) FROM [Game01].[dbo].[GUnit] WITH (NOLOCK) WHERE UserUID = @iUserUID and Deleted = 0

   -- 랭킹 정보 수집
   SELECT @iVsRank = VsRank, @iExpRank = ExpRank FROM dbo.Rank_ WITH (NOLOCK) WHERE unitUID = @iUnitUID

   -- GUnit에서 조회할 수 있는 기본정보 조회
   SELECT	@sdtLastDate = lastdate
,			@iPlayDayCnt = playdaycnt
,			@iLoginCount = logincount
,			@bDeleted = deleted
,			@iLevel = [level]
,			@iExp = [exp]
,			@iGamepoint = gamepoint
--,			@iVsPoint = vspoint
--,			@iVsPointMax = vspointmax
,			@iSPoint = spoint
	FROM [Game01].[dbo].[GUnit] WITH (NOLOCK)
		WHERE unituid = @iUnitUID



END
-- GUnit에 존재한다면

IF NOT EXISTS (SELECT * From dbo.UnitStatistics WITH (NOLOCK) WHERE UnitUID = @iUnitUID)
BEGIN
	BEGIN TRANSACTION
		INSERT INTO dbo.UnitStatistics WITH (UPDLOCK) (UnitUID,	UserUID, Age, Gender, RegDate, UnitClass)
			SELECT a.UnitUID, a.UserUID, b.Age,	b.Gender, a.RegDate, a.UnitClass
				FROM (SELECT UnitUID, UserUID, RegDate,	UnitClass FROM [Game01].[dbo].[GUnit] WITH (UPDLOCK) WHERE UnitUID = @iUnitUID) AS A
			JOIN 
				(
					SELECT UserUID,	Age, Gender	FROM [Account].[dbo].[MUser] WITH (UPDLOCK) WHERE UserUID = @iUserUID
				) AS B
			ON
			a.UserUID = b.UserUID

	IF @@ERROR <> 0
		BEGIN	SELECT @iOK_ = -101	GOTO FAIL_TRAN	END

	COMMIT TRANSACTION
END


SELECT TOP 1
	@iBestUnitUID = UnitUID
	FROM dbo.UnitStatistics WITH (NOLOCK)
		WHERE UserUID = @iUserUID AND Deleted = 0
			ORDER BY [Exp] DESC

BEGIN TRANSACTION
   
	UPDATE a WITH (UPDLOCK)
	SET lastdate = @sdtLastDate 
	,	playdaycnt = @iPlayDayCnt 
	,   logincount = @iLoginCount 
	,   deleted = @bDeleted 
	,   [level] = @iLevel 
	,   [exp] = @iExp  
	,   gamepoint = @iGamepoint 
	,   vspoint = @iVsPoint 
	,   vspointmax = @iVsPointMax 
	,   spoint = @iSPoint 
	,   charNo = @iCharNo
	,   vsRank = @iVsRank
	,   ExpRank = @iExpRank
	,   VsCnt = ISNULL(@iVsCnt,0)
	,   VsWinCnt = ISNULL(@iVsWinCnt,0)
	,   VsLoseCnt = ISNULL(@iVsLoseCnt,0)
	,   VSPlayTime = ISNULL(@iVSPlayTime,0)
	,   DSoloCnt = ISNULL(@iDSoloCnt,0)
	,   DPartyCnt = ISNULL(@iDPartyCnt,0)
	,   DSWCnt = ISNULL(@iDSoloWinCnt,0)
	,   DPWCnt = ISNULL(@iDPartyWinCnt,0)      
	,   DSPlayTime = ISNULL(@iDSoloPlayTime ,0)    
	,   DPPlayTime = ISNULL(@iDPartyPlayTime ,0)
	,   DunAndVSPT = ISNULL((@iDSoloPlayTime + @iDPartyPlayTime + @iVSPlayTime),0)
	,   TutorialPT = ISNULL(@iTutoPlayTime, 0)
	,   TrainingPT = ISNULL(@iTrainingPT, 0)
	,   TotalPlayTime = ISNULL((@iVSPlayTime + @iDSoloPlayTime + @iDPartyPlayTime + @iTutoPlayTime + TrainingPT),0)
	,   Skill_Basic = @iSkill_Cnt
	,   QuestCnt = @iQuest_Cnt
	,   ReQuestCnt = @iQuest_Re_Cnt
	,   Beginner = ISNULL(@iTraWin_Cnt + @iTutoWin_Cnt , 0)
	,   PCBangFlag = 0
	,	VsRate = case when @iVSPlayTime > 0 then ISNULL(CONVERT(Float, @iVSPlayTime)/(@iVSPlayTime + @iDSoloPlayTime + @iDPartyPlayTime) * 100,0) else VsRate end
	,	PartyRate = case when @iDPartyCnt > 0 then ISNULL(CONVERT(Float, @iDPartyCnt)/(@iDSoloCnt + @iDPartyCnt) * 100,0) else PartyRate end
	FROM dbo.UnitStatistics AS A WITH (UPDLOCK)
	WHERE unitUID = @iUnitUID

IF @@ERROR <> 0
	BEGIN    SELECT @iOK_ = -102    GOTO FAIL_TRAN    END


--	대표 캐릭터 업데이트
UPDATE a WITH (UPDLOCK)
	SET IsFirst = CASE UnitUID WHEN @iBestUnitUID THEN 1 ELSE 0 END
		FROM dbo.UnitStatistics AS A WITH (UPDLOCK)
			WHERE UserUID = @iUserUID

COMMIT TRANSACTION

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK_
GO
-- =============================================
-- Author:		choi yuk sa
-- Create date: 2008년 03월 11일
-- Description: 기타 통계 자료 업데이트
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_UnitStatistics_Etc2_SET]	
	@iServerSetID		TINYINT
,	@iUserUID			[bigint]
,	@iUnitUID			[bigint]
,	@iPDunED			[int]
,	@iPQuestED			[int]
,	@iPItemSellED		[int]
--,	@iPItemP2PED		[int]
,	@iMItemBuyED		[int]
--,	@iMItemP2PED		[int]
,	@iMItemMakeED		[int]
,	@iMItemRepairED		[int]
,	@iMStoreP2P			[int]
,	@iMEnchant			[int]
,	@iMSocket			[int]
,	@iP2PCnt			[int]
,	@iNQuestAcc			[int]
,	@iNQuestGiveUp		[int]
,	@iNQuestComplete	[int]
,	@iRQuestAcc			[int]
,	@iRQuestGiveUp		[int]
,	@iRQuestComplete	[int]
,	@iMOpenCubeSpendED	[int] -- 2012.12.06 패치
--,	@iEQuestAcc			[int]
--,	@iEQuestGiveUp		[int]
--,	@iEQuestComplete	[int]
,	@iOK_				[int] = 0
AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRAN
	-- 해당 유닛은 존재하지만 기존 데이터가 없으면 insert
	IF NOT EXISTS (SELECT * FROM dbo.UnitStatistics WITH (NOLOCK) WHERE UnitUid = @iUnitUID)
		BEGIN	-- GUnit에 존재하지만 테이블에 기록되어있지 않다면,
			INSERT INTO dbo.UnitStatistics (UnitUID, UserUID, Age, Gender, RegDate, UnitClass, [level])
				SELECT a.UnitUID, a.UserUID, b.Age, b.Gender, a.RegDate, a.UnitClass, a.level
					FROM [Game01].[dbo].[GUnit] as a WITH (NOLOCK), [Account].[dbo].[MUser] as b WITH (NOLOCK)
						WHERE a.UnitUID = @iUnitUID and b.UserUID = @iUserUID
					IF @@ERROR <> 0
					BEGIN	SELECT @iOK_ = -101	GOTO FAIL_TRAN	END
		END		-- GUnit에 존재하지만 테이블에 기록되어있지 않다면,	

		-- ED 획득량 및 던전, 개인거래 횟수
		UPDATE dbo.UnitStatistics WITH (UPDLOCK)
			SET	PDunED		= PDunED			+ @iPDunED		
,				PQuestED		= PQuestED			+ @iPQuestED		   
,				PItemSellED	= PItemSellED		+ @iPItemSellED	
--,				PItemP2PED	= PItemP2PED		+ @iPItemP2PED	
,				MItemBuyED	= MItemBuyED		+ @iMItemBuyED	
--,				MItemP2PED	= MItemP2PED		+ @iMItemP2PED	
,				MItemMakeED	= MItemMakeED		+ @iMItemMakeED	
,				MItemRepairED	= MItemRepairED	+ @iMItemRepairED
,				MStoreP2P	= MStoreP2P			+ @iMStoreP2P
,				MEnchant	= MEnchant			+ @iMEnchant
,				MSocket		= MSocket			+ @iMSocket
,				P2PCnt		= P2PCnt			+ @iP2PCnt		
,				NQuestAcc			= NQuestAcc			+ @iNQuestAcc		   
,				NQuestGiveUp		= NQuestGiveUp		+ @iNQuestGiveUp	
,				NQuestComplete	= NQuestComplete	+ @iNQuestComplete 
,				RQuestAcc			= RQuestAcc			+ @iRQuestAcc		   
,				RQuestGiveUp		= RQuestGiveUp		+ @iRQuestGiveUp	
,				RQuestComplete	= RQuestComplete	+ @iRQuestComplete
,				MOpenCubeSpendED = MOpenCubeSpendED + @iMOpenCubeSpendED
--,				EQuestAcc			= EQuestAcc			+ @iEQuestAcc		   
--,				EQuestGiveUp		= EQuestGiveUp		+ @iEQuestGiveUp	
--,				EQuestComplete	= EQuestComplete	+ @iEQuestComplete 
				WHERE unitUID = @iUnitUID
		IF @@error <> 0
			BEGIN	SELECT @iOK_ = -104	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK_
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_UnitStatistics_Delete_SET]
	@iServerSetID		TINYINT
,	@iUnitUID	bigint
,	@iOK		int = 0

AS
SET NOCOUNT ON;

IF NOT EXISTS (SELECT * FROM dbo.UnitStatistics WITH (NOLOCK) WHERE UNITUID = @iUnitUID)
	BEGIN
		SELECT @iOK = -2	GOTO END_PROC
	END


BEGIN TRAN

	UPDATE dbo.UnitStatistics
		SET deleted = 1
			WHERE unituid = @iUnitUID

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
    BEGIN    
        SELECT @iOK = -1 
        GOTO FAIL_TRAN    
    END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
-- =============================================
-- Author: YJ
-- Create date: 2012-02-15
-- Description:	개인상점 시세 통계 수집
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_STrade_INS_Stats] 
	@Date	NVARCHAR(10) = NULL
	
AS
SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

IF @Date IS NULL BEGIN
	SET @Date = CONVERT(NVARCHAR(10), DATEADD(DAY, -1, GETDATE()), 120)
END

/*DECLARE @Date NVARCHAR(10)

SET @Date = CONVERT(NVARCHAR(10), DATEADD(DAY, -1, GETDATE()), 120)
*/

BEGIN TRY

	IF EXISTS( SELECT * FROM LStradeStats WHERE RegDate = @Date ) BEGIN
		RAISERROR (N'Primary Key Error', 15, 1)
	END

	BEGIN TRAN

		INSERT INTO dbo.LStradeStats(
					ItemID,
					AVGMoney,
					STDEVMoney,
					MAXMoney,
					MINMoney,
					CNTItem,
					OneAVGQuantity,
					OneAVGMoney,
					RegDate
		)
		SELECT		ItemID
		,			SUM(Convert(bigint,Money))/SUM(Quantity) AS AVGMoney
		,			(POWER(SUM(POWER(CONVERT(BIGINT,Money)/Quantity,2)*Quantity)/SUM(Quantity) - POWER(SUM(CONVERT(BIGINT,Money))/SUM(Quantity),2),0.5)) AS STDEVMoney
		,			MAX(Money/Quantity) AS MAXMoney
		,			MIN(Money/Quantity) AS MINMoney
		,			COUNT(ItemID) AS CNTItem
		,			SUM(Quantity)/COUNT(ItemID) AS OneAVGQuantity
		,			AVG(Convert(bigint,Money)) AS OneAVGMoney
		,			@Date 
		FROM STrade 
		WHERE RegDate BETWEEN @Date+' 00:00' AND @Date+' 23:59'
		GROUP BY ItemID

	COMMIT TRAN

END TRY

BEGIN CATCH
	
	SELECT	ERROR_MESSAGE() AS ErrorMessage
	,		ERROR_NUMBER() AS ErrorNumber

	IF (XACT_STATE()) <> 0
		ROLLBACK TRAN
END CATCH

SET NOCOUNT OFF
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_STrade_INS]
	@iServerSetID	TINYINT,
    @iFromUnitUID   [bigint],
    @iToUnitUID     [bigint],
    @iItemID        [int],
    @iItemUID       [bigint],
    @iQuantity      [int],
	@iMoney			[int],
	@bIsBBS			[bit],
	@iStoreType		[tinyint],
    @iOK            [int] = 0
AS

SET NOCOUNT ON;

BEGIN TRAN
    INSERT INTO dbo.STrade(ServerSetID, FromUnitUID, ToUnitUID, ItemID,ItemUID, Quantity, [Money], RegDate, IsBBS, StoreType )
	    SELECT @iServerSetID, @iFromUnitUID, @iToUnitUID, @iItemID, @iItemUID, @iQuantity, @iMoney, GetDate(), @bIsBBS, @iStoreType

		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN
			SELECT @iOK = -1
			GOTO FAIL_TRAN
		END    
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
-- =============================================
-- Author:		sutamtwo
-- Create date: 2007년 10월 25일
-- Description: 맵 카운트 업데이트
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_StatsVsMap_SET]
	@iServerSetID		TINYINT
,	@iMapID		[int]
,	@iMapCnt	[int]
,	@iOK_		[int] = 0
AS
SET NOCOUNT ON;
SET XACT_ABORT ON;


BEGIN TRAN

	-- 맵 정보가 없으면, 
	IF NOT EXISTS(SELECT * FROM dbo.StatsVsMap WITH (NOLOCK) WHERE MapID = @iMapID AND ServerSetID = @iServerSetID)
		BEGIN
			INSERT INTO dbo.StatsVsMap (ServerSetID, MapID)
				SELECT @iServerSetID, @iMapID
					IF @@ERROR <> 0
					BEGIN	SELECT @iOK_ = -101	GOTO FAIL_TRAN	END
		END

	-- 맵 카운트 플러스
	UPDATE dbo.StatsVsMap	WITH (UPDLOCK)
		SET	MapCnt	= MapCnt + @iMapCnt
			WHERE MapID = @iMapID AND ServerSetID = @iServerSetID
		IF @@error <> 0
			BEGIN	SELECT @iOK_ = -102	GOTO FAIL_TRAN	END


COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK_
GO
-- =============================================
-- Author:		sutamtwo
-- Create date: 2007년 10월 25일
-- Description: 대전 모드 카운트 및 대전 플레이 타임 업데이트
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_StatsVs_SET]
	@iServerSetID		TINYINT
,	@iUnitUID		[bigint]
,	@iTMW_Cnt		[smallint]
,	@iTML_Cnt		[smallint]
,	@iTMG_Cnt		[smallint]
,	@iTMD_Cnt		[smallint]
,	@iTDW_Cnt		[smallint]
,	@iTDL_Cnt		[smallint]
,	@iTDG_Cnt		[smallint]
,	@iTDD_Cnt		[smallint]
,	@iTDNan_Cnt		[smallint]
,	@iDW_Cnt		[smallint]
,	@iDL_Cnt		[smallint]
,	@iDG_Cnt		[smallint]
,	@iDD_Cnt		[smallint]
,	@iDNan_Cnt		[smallint]
,	@iTMW_Time		[int]
,	@iTML_Time		[int]
,	@iTMG_Time		[int]
,	@iTMD_Time		[int]
,	@iTDW_Time		[int]
,	@iTDL_Time		[int]
,	@iTDG_Time		[int]
,	@iTDD_Time		[int]
,	@iTDNan_Time	[int]
,	@iDW_Time		[int]
,	@iDL_Time		[int]
,	@iDG_Time		[int]
,	@iDD_Time		[int]
,	@iDNan_Time		[int]
,	@iOK_			[int] = 0
AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

IF NOT EXISTS(SELECT * FROM [GAME01].dbo.GUnit WITH (NOLOCK) WHERE unituid = @iUnitUID)
	-- 해당 유닛 존재하지 않음
	BEGIN    SELECT @iOK_ = -1     GOTO END_PROC    END

BEGIN TRAN
	-- 해당 유닛은 존재하지만 기존 데이터가 없으면 insert
	IF NOT EXISTS(SELECT * FROM dbo.StatsVs WITH (NOLOCK) WHERE Unituid = @iUnitUID)
		BEGIN
			INSERT INTO dbo.StatsVs (ServerSetID, UnitUID)
				SELECT @iServerSetID, @iUnitUID
				IF @@ERROR <> 0
					BEGIN	SELECT @iOK_ = -101	GOTO FAIL_TRAN	END
		END

	-- 대전 모드 카운트 업데이트
	UPDATE dbo.StatsVs WITH (UPDLOCK)
			SET	TMW_Cnt	    = TMW_Cnt	+ @iTMW_Cnt	            	
,				TML_Cnt	    = TML_Cnt	+ @iTML_Cnt	         	
,				TMG_Cnt	    = TMG_Cnt	+ @iTMG_Cnt	 
,				TMD_Cnt		= TMD_Cnt	+ @iTMD_Cnt          	
,				TDW_Cnt	    = TDW_Cnt	+ @iTDW_Cnt	         	
,				TDL_Cnt	    = TDL_Cnt	+ @iTDL_Cnt	       	
,				TDNan_Cnt   = TDNan_Cnt + @iTDNan_Cnt 	
,				TDG_Cnt	    = TDG_Cnt	+ @iTDG_Cnt	      	
,				TDD_Cnt		= TDD_Cnt	+ @iTDD_Cnt
,				DW_Cnt	    = DW_Cnt	+ @iDW_Cnt	        	
,				DL_Cnt	    = DL_Cnt	+ @iDL_Cnt	         	
,				DG_Cnt	    = DG_Cnt	+ @iDG_Cnt	          	
,				DNan_Cnt    = DNan_Cnt  + @iDNan_Cnt      	
,				DD_Cnt		= DD_Cnt	+ @iDD_Cnt	
,				TMW_Time    = TMW_Time  + @iTMW_Time     	
,				TML_Time    = TML_Time  + @iTML_Time       	
,				TMG_Time    = TMG_Time  + @iTMG_Time     	
,				TMD_Time    = TMD_Time  + @iTMD_Time     	
,				TDW_Time    = TDW_Time  + @iTDW_Time     	
,				TDL_Time    = TDL_Time  + @iTDL_Time   	
,				TDG_Time    = TDG_Time  + @iTDG_Time  
,				TDNan_Time  = TDNan_Time	+ @iTDNan_Time
,				TDD_Time    = TDD_Time  + @iTDD_Time  
,				DW_Time	    = DW_Time	+ @iDW_Time	         	
,				DL_Time	    = DL_Time	+ @iDL_Time	     	
,				DG_Time     = DG_Time   + @iDG_Time   		
,				DNan_Time   = DNan_Time + @iDNan_Time 
,				DD_Time     = DD_Time   + @iDD_Time   		
			WHERE unituid = @iUnitUID
	IF @@error <> 0
		BEGIN	SELECT @iOK_ = -103	GOTO FAIL_TRAN	END


COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK_, @iUnitUID
GO
-- =============================================
-- Author:		sutamtwo
-- Create date: 2007년 10월 24일
-- Description: 훈련소 Mode Count 및 Play Time 기록
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_StatsTraining_SET]
	@iServerSetID		TINYINT
,	@iUnitUID		[bigint]
,	@iTrainingID	[smallint]
,	@iWin_Cnt		[int]
,	@iLose_Cnt		[int]
,	@iGiveUp_Cnt	[int]
,	@iWin_Time		[bigint]
,	@iLose_Time		[bigint]
,	@iGiveUp_Time	[bigint]
,	@iOK_			[int] = 0

AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

IF NOT EXISTS(select * from [game01].dbo.GUnit with (nolock) where unituid = @iUnitUID)
	-- 해당 유닛 없음
	BEGIN    SELECT @iOK_ = -1     GOTO END_PROC    END

BEGIN TRAN
	IF NOT EXISTS(SELECT * FROM dbo.StatsTraining WITH (NOLOCK) WHERE Unituid = @iUnitUID and TrainingID = @iTrainingID)
		BEGIN
			INSERT INTO dbo.StatsTraining (ServerSetID, UnitUID, TrainingID)
				SELECT @iServerSetID, @iUnitUID, @iTrainingID
				IF @@ERROR <> 0
					BEGIN	SELECT @iOK_ = -101	GOTO FAIL_TRAN	END
		END

	UPDATE dbo.StatsTraining WITH (UPDLOCK)
		SET	Win_Cnt	    = Win_Cnt	  + @iWin_Cnt	     
,			Lose_Cnt    = Lose_Cnt    + @iLose_Cnt     	  
,			GiveUp_Cnt  = GiveUp_Cnt  + @iGiveUp_Cnt  	
,			Win_Time    = Win_Time    + @iWin_Time      	
,			Lose_Time   = Lose_Time   + @iLose_Time         	
,			GiveUp_Time = GiveUp_Time + @iGiveUp_Time     	
		WHERE Unituid = @iUnitUID and TrainingID = @iTrainingID

	IF @@ERROR <> 0
		BEGIN	SELECT @iOK_ = -102	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK_, @iUnitUID
GO
-- =============================================
-- Author:		sutamtwo
-- Create date: 2009. 07. 28
-- Description: 헤니르의 시공 100명 뽑기
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_StatsTimeSpaceTop100_INS]
	@iServerSetID	TINYINT
,	@iUserUID	BIGINT	
,	@iUnitUID	BIGINT
,	@iPlayTime	SMALLINT
,	@iOK		INT = 0
AS
SET NOCOUNT ON;

DECLARE	@sdtNow DATETIME
SELECT	@sdtNow = GETDATE()

BEGIN TRAN

	INSERT INTO dbo.StatsTimeSpaceTop100 (ServerSetID, UserUID, UnitUID, PlayTime, RegDate)
			SELECT @iServerSetID, @iUserUID, @iUnitUID, @iPlayTime, @sdtNow
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_StatsStoneCnt_SET]
	@iServerSetID		TINYINT
,	@iSupplyCnt			smallint
,	@iQuantity			int
AS
	SET NOCOUNT ON 


	IF NOT EXISTS (SELECT * FROM dbo.StatsStoneCnt WHERE Regdate = CONVERT(NVARCHAR(10), GETDATE(),120))
	BEGIN
			INSERT INTO dbo.StatsStoneCnt (ServerSetID, RegDate, FreeInsertCnt,Plus1,Plus2,Plus3,PlusOver3)
			SELECT @iServerSetID, CONVERT(NVARCHAR(10), GETDATE(),120), 0, 0,0,0,0
	END
	ELSE BEGIN
		UPDATE dbo.StatsStoneCnt
		SET FreeInsertCnt = FreeInsertCnt + @iSupplyCnt - @iQuantity
		,	Plus1			= plus1 + case (@iSupplyCnt - @iQuantity) when 1 then 1 else 0 end
		,	Plus2			= plus2 + case (@iSupplyCnt - @iQuantity) when 2 then 1 else 0 end
		,	Plus3			= plus3 + case (@iSupplyCnt - @iQuantity) when 3 then 1 else 0 end
		,	PlusOver3		= plusOver3 + case (@iSupplyCnt - @iQuantity) when 4 then 1 when 5 then 1 when 6 then 1 when 7 then 1 when 8 then 1 when 9 then 1 else 0 end
		WHERE Regdate = CONVERT(NVARCHAR(10), GETDATE(),120) AND ServerSetID = @iServerSetID
	END
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_StatsSpiritLog_INS]
(
	@iServerSetID	TINYINT	,
	@iUnitUID	bigint,
	@iPT	int,
	@iDT int,
	@iUsedSp smallint
)	

AS
SET NOCOUNT ON;


INSERT INTO dbo.StatsSpiritLog (ServerSetID, UnitUID, PlayTime, DurationTime, UsedSpirit, Regdate)
	SELECT @iServerSetID, @iUnitUID, @iPT, @iDT, @iUsedSp, getdate()

--2010.07.01~2010.07.07 근성도 통계기록 프로시저
GO
-- =============================================
-- Author:		sutamtwo
-- Create date: 2009.09.09
-- Description: 봉인 아이템 로그
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_StatsSealLog_INS]
	@iServerSetID		TINYINT
,	@iUnitUID	BIGINT
,	@iSealUID	BIGINT
,	@iItemUID	BIGINT
,	@iSealCnt	TINYINT
,	@iOK		INT = 0

AS
SET NOCOUNT ON;


BEGIN TRAN

	INSERT INTO dbo.StatsSealLog (ServerSetID, UnitUID, SealUID, ItemUID, SealCnt, RegDate) 
		SELECT @iServerSetID, @iUnitUID, @iSealUID, @iItemUID, @iSealCnt, GETDATE()

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
-- =============================================
-- Author:		sutamtwo
-- Create date: 2007년 12월 26일
-- Description: 각 퀘스트별 수락과 완료, 포기 비율 및 평균 레벨 구하기
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_StatsQuestInfo_SET]
	@iServerSetID		TINYINT
,	@iQuestID		[bigint]
,	@iAccept		[smallint]
,	@iGiveUp		[smallint]
,	@iComplete		[smallint]
,	@iAcceptLevel	[smallint]
,	@iGiveUpLevel	[smallint]
,	@iCompleteLevel	[smallint]
,	@iOK_			[int] = 0
AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE @iResult int
,		@iAccept_	bigint
,		@iGiveUp_	bigint
,		@iComplete_	bigint


BEGIN TRY

	SET @iResult = -1
		
	IF Convert(Char(10),GETDATE(),120) < '2012-07-05' --SP 생성 다음날짜 입력
		BEGIN
			RAISERROR (N'Error', 15, 1)
		END
		
	BEGIN TRAN
		-- 해당 퀘스트는 존재하지만 기존 데이터가 없으면 insert
		IF NOT EXISTS(SELECT * FROM dbo.LQuestInfo WITH (NOLOCK) WHERE QuestID = @iQuestID AND Convert(Char(10),RegDate,120) = Convert(Char(10),Getdate(),120))
			BEGIN
				INSERT INTO dbo.LQuestInfo (QuestID, Accept, GiveUp, Complete, AcceptLevel, GiveUpLevel, CompleteLevel, RegDate)
					SELECT @iQuestID, @iAccept, @iGiveUp, @iComplete, @iAcceptLevel, @iGiveUpLevel, @iCompleteLevel, GETDATE()
					
			END			
		ELSE 			
			BEGIN					
				UPDATE dbo.LQuestInfo WITH (UPDLOCK)
					SET	Accept			= Accept		+ @iAccept	            	
		,				GiveUp			= GiveUp		+ @iGiveUp	         	
		,				Complete	    = Complete		+ @iComplete	       	
		,				AcceptLevel		= AcceptLevel	+ @iAcceptLevel	
		,				GiveUpLevel		= GiveUpLevel	+ @iGiveUpLevel          	
		,				CompleteLevel	= CompleteLevel	+ @iCompleteLevel	
		,				RegDate			= GETDATE()
					WHERE QuestID = @iQuestID AND Convert(Char(10),RegDate,120) = Convert(Char(10),Getdate(),120)
			END
	COMMIT TRAN		
	
	SET @iResult = 0

	SELECT @iResult, @iQuestID
	
END TRY

BEGIN CATCH
	IF (XACT_STATE()) <> 0
		ROLLBACK TRAN
		
	SELECT @iResult, ERROR_MESSAGE() AS ErrorMassage
END CATCH
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_StatsNickNameRestore_INS]
	@iServerSetID	TINYINT	
,	@iUnitUID		[bigint]
,	@strNickName	[nvarchar](16)
,	@iOK			[int] = 0
AS
SET NOCOUNT ON;

DECLARE	@sdtNow	SMALLDATETIME
SELECT	@sdtNow = GETDATE()

BEGIN TRAN	

	--  닉네임 변경 기록 저장
	INSERT INTO dbo.StatsNickNameRestore (ServerSetID, NickName,UnitUID, Regdate)
		SELECT @iServerSetID, @strNickName, @iUnitUID, @sdtNow
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
        BEGIN    SELECT @iOK = -1	GOTO END_PROC    END


COMMIT TRAN


GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_StatsNickNameChange_INS]
	@iServerSetID	TINYINT	
,	@iUnitUID		[bigint]
,	@strNickName	[nvarchar](16)
,	@iOK			[int] = 0
AS
SET NOCOUNT ON;

DECLARE	@sdtNow	SMALLDATETIME
SELECT	@sdtNow = GETDATE()

BEGIN TRAN	

	--  닉네임 변경 기록 저장
	INSERT INTO dbo.StatsNickNameChange (ServerSetID, NickName,UnitUID, Regdate)
		SELECT @iServerSetID, @strNickName, @iUnitUID, @sdtNow
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
        BEGIN    SELECT @iOK = -1	GOTO END_PROC    END


COMMIT TRAN


GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
-- =============================================
-- Author:		sutamtwo
-- Create date: 2007년 12월 24일
-- Description: 통화량 측정 SP
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_StatsMoneySupply_INS]
	@iServerSetID		TINYINT
,	@iPDun				bigint
,	@iPTraining			bigint
,	@iPQuest			bigint
,	@iPItemSell			bigint
,	@iPItemP2P			bigint
,	@iPStoreP2P			bigint
,	@iPPostP2P			bigint	-- 우체국 받은 돈
,	@iMItemBuy			bigint
,	@iMItemP2P			bigint
,	@iMItemRepair		bigint
,	@iMItemMake			bigint
,	@iMDunPenalty		bigint
,	@iMStoreP2P			bigint
,	@iMStoreOpen		bigint
,	@iMEnchant			bigint
,	@iMSocket			bigint
,	@iMPostP2P			bigint	-- 우체국 송금
,	@iMPostBasic		bigint	-- 우체국 수수료 (기본)
,	@iMPostItem			bigint	-- 우체국 수수료 (아이템)
,	@iMAttribute		bigint	-- 속성강화
,	@iMStoreP2PTax		bigint	-- 개인 상점 수수료
,	@iMStoreBBSTax		bigint	-- 개인 상점 거래게시판 수수료
,	@iMPShopAgency		bigint
,	@iMBuyTaxPShopA 	bigint
,	@IPPShopPickUp		bigint
,	@iMOpenCubeSpendED		bigint	-- ED로 큐브오픈/2012.12.06 패치
,	@iPBattleFieldED		bigint	-- 배틀필드에서 획득한 ED/2013.05.09 패치
,	@iMCoboExpressTicketED	bigint	-- 코보티켓 지역이동으로 소모한 ED/2013.05.09 패치
,	@iMItemDecom			bigint	-- 일본 분해 ED
,	@iOK_				[int] = 0
AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE @strRegdate	nvarchar(10)
SELECT	@strRegdate = CONVERT(nvarchar(10),getdate(),120)

BEGIN TRAN
	-- 해당 유닛은 존재하지만 기존 데이터가 없으면 insert

		IF NOT EXISTS (SELECT * FROM dbo.StatsMoneySupply WITH (NOLOCK) WHERE Regdate = @strRegdate)
			BEGIN	
				INSERT INTO dbo.StatsMoneySupply (ServerSetID, Regdate, PDun, PTraining, PQuest, PItemSell, PItemP2P, PStoreP2P, PPostP2P, MItemBuy, MItemP2P, MItemRepair, MItemMake, MDunPenalty, MStoreP2P, MStoreOpen, MEnchant, MSocket, MPostP2P, MPostBasic, MPostItem, MAttribute, MStoreP2PTax, MStoreBBSTax, MPShopAgency, MBuyTaxPShopA, PPShopPickUp, MOpenCubeSpendED, PBattleFieldED, MCoboExpressTicketED, MItemDecom)
					SELECT @iServerSetID, @strRegdate, @iPDun, @iPTraining, @iPQuest, @iPItemSell, @iPItemP2P, @iPStoreP2P, @iPPostP2P, @iMItemBuy, @iMItemP2P, @iMItemRepair, @iMItemMake, @iMDunPenalty, @iMStoreP2P, @iMStoreOpen, @iMEnchant, @iMSocket, @iMPostP2P, @iMPostBasic, @iMPostItem, @iMAttribute, @iMStoreP2PTax, @iMStoreBBSTax, @iMPShopAgency, @iMBuyTaxPShopA, @IPPShopPickUp, @iMOpenCubeSpendED, @iPBattleFieldED, @iMCoboExpressTicketED, @iMItemDecom

						IF @@ERROR <> 0
						BEGIN	SELECT @iOK_ = -101	GOTO FAIL_TRAN	END
			END		-- GUnit에 존재하지만 테이블에 기록되어있지 않다면,

		ELSE

	UPDATE dbo.StatsMoneySupply WITH (UPDLOCK)
			SET	PDun		 		= PDun			+ @iPDun				
,				PTraining	 		= PTraining	+ @iPTraining			   	
,				PQuest		 		= PQuest		+ @iPQuest		   	
,				PItemSell	 		= PItemSell	+ @iPItemSell		 	
,				PItemP2P	 		= PItemP2P		+ @iPItemP2P		
,				PStoreP2P	 		= PStoreP2P	+ @iPStoreP2P
,				PPostP2P	 		= PPostP2P		+ @iPPostP2P
,				MItemBuy	 		= MItemBuy		+ @iMItemBuy			
,				MItemP2P	 		= MItemP2P		+ @iMItemP2P		     	
,				MItemRepair	 		= MItemRepair	+ @iMItemRepair	
,				MItemMake	 		= MItemMake	+ @iMItemMake			  	
,				MDunPenalty  		= MDunPenalty	+ @iMDunPenalty
,				MStoreP2P	 		= MStoreP2P	+ @iMStoreP2P	
,				MStoreOpen	 		= MStoreOpen	+ @iMStoreOpen
,				MEnchant	 		= MEnchant		+ @iMEnchant		
,				MSocket		 		= MSocket		+ @iMSocket		
,				MPostP2P	 		= MPostP2P		+ @iMPostP2P	
,				MPostBasic	 		= MPostBasic	+ @iMPostBasic  
,				MPostItem	 		= MPostItem	+ @iMPostItem	
,				MAttribute	 		= MAttribute	+ @iMAttribute  
,				MStoreP2PTax 		= MStoreP2PTax	+ @iMStoreP2PTax
,				MStoreBBSTax 		= MStoreBBSTax	+ @iMStoreBBSTax
,				MPShopAgency 		= MPShopAgency + @iMPShopAgency
,				MBuyTaxPShopA		= MBuyTaxPShopA+ @iMBuyTaxPShopA
,				PPShopPickUp 		= PPShopPickUp + @IPPShopPickUp
,				MOpenCubeSpendED	= MOpenCubeSpendED + @iMOpenCubeSpendED
,				PBattleFieldED		= PBattleFieldED + @iPBattleFieldED
,				MCoboExpressTicketED= MCoboExpressTicketED + @iMCoboExpressTicketED
,				MItemDecom 			= MItemDecom + @iMItemDecom
			WHERE Regdate	= @strRegdate AND ServerSetID = @iServerSetID
	IF @@error <> 0
		BEGIN	SELECT @iOK_ = -102	GOTO FAIL_TRAN	END
		
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK_
GO
-- =============================================
-- Author:		sutamtwo
-- Create date: 2008-06-18
-- Description: 돈이 들어오고 나가는 상태 파악 (특정 유닛만)
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_StatsMoneyLog_INS]
(
	@iServerSetID	TINYINT	
,	@iUnitUID	bigint
,	@iState		tinyint
,	@iBMoney	int
,	@iAMoney	int
,	@iMoney		int
)

/*	
	ELS_NONE = 0,

	ELS_DUNGEON_REWARD,			// [1]
	ELS_BUY_ED_ITEM,			// [2]
	ELS_BUY_ED_ITEM_ROLLBACK,	// [3]
	ELS_SELL_ED_ITEM,			// [4]
	ELS_OUT_TRADE,				// [5]
	ELS_IN_TRADE,				// [6]
	ELS_ITEM_REPAIR,			// [7]
	ELS_TRANING_REWARD,			// [8]
	ELS_MANUFACTURE,			// [9]
	ELS_PERSONAL_SHOP_OPEN,		// [10]
	ELS_IN_PERSONAL_SHOP,		// [11]
	ELS_OUT_PERSONAL_SHOP,		// [12]
	ELS_ITEM_ENCHANT,			// [13]
	ELS_ITEM_SOCKET,			// [14] 
	ELS_QUEST_REWARD			// [15]
*/

AS
SET NOCOUNT ON ;


	INSERT INTO dbo.StatsMoneyLog (ServerSetID, UnitUID,	State, BMoney, AMoney, Money, RegDate)
		SELECT @iServerSetID, @iUnitUID, @iState, @iBMoney, @iAMoney, @iMoney,	GETDATE()
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_StatsMegaphone_INS]
	@iServerSetID	TINYINT	
,	@iUnitUID	bigint
,	@iItemID	int
,	@iOK		int = 0
	
AS

SET NOCOUNT ON;
BEGIN TRAN

	INSERT INTO	dbo.StatsMegaphone (ServerSetID, UnitUID, ItemID, RegDate)
		SELECT 	@iServerSetID, @iUnitUID, @iItemID, GetDate()

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN
			SELECT @iOK = -1	GOTO FAIL_TRAN
		END

COMMIT TRAN

GOTO END_PROC


FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
-- =============================================
-- Author:  EJ
-- Create date: 2012-09-18
-- Description: 로그인 성공 및 실패 정보 정보 로그 남기는 기능
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_StatsLoginLOG_INS]
	@ServerGroupID 		int,
	@ServerUID			int,
	@LoginResultType	int,
	@LoginResultCount 	int
AS
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

		DECLARE @Result INT
	
	BEGIN TRY
		
			INSERT INTO dbo.StatsLoginLOG (ServerGroupID, ServerUID, LoginResultType, LoginResultCount, Regdate)
			SELECT @ServerGroupID, @ServerUID, @LoginResultType, @LoginResultCount, GETDATE()
			
			SET @Result = 0
		
		
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

		IF @Result <> 0 
			SET @Result = -1
	END CATCH

	SELECT @Result AS Result
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_StatsJackPot_INS]
	@iServerSetID	TINYINT	
,	@iUnitUID	bigint
,	@iItemID	int
,	@iDurationTime	int
,	@sdtRegDate	smalldatetime
,	@iOK		int = 0

AS
SET NOCOUNT ON;

BEGIN TRAN
	INSERT INTO dbo.StatsJackPot (ServerSetID, UnitUID, ItemID, DurationTime, RegDate)
		SELECT @iServerSetID, @iUnitUID, @iItemID, @iDurationTime, @sdtRegDate
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END
		
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
-- =============================================
-- Author:		sutamtwo
-- Create date: 2008년 12월 22일
-- Description: 강화로 파괴된 아이템 살리기
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_StatsItemResurrection_INS]
	@iServerSetID		TINYINT
,	@iUnitUID	[bigint]
,	@iItemUID	[bigint]
,	@iBefore	[smallint]
,	@iAfter		[smallint]
,	@iOK		[int] = 0
AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRAN

	INSERT INTO dbo.StatsItemResurrection(ServerSetID, UnitUID,	ItemUID, Before, After ,RegDate)
		SELECT @iServerSetID, @iUnitUID, @iItemUID, @iBefore, @iAfter, GetDate()

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
-- =============================================
-- Author:		sutamtwo
-- Create date: 2008년 11월 10일
-- Description: 강화레벨 5 이상 아이템 파괴 로그
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_StatsItemBreak_INS]
	@iServerSetID		TINYINT
,	@iUnitUID	[bigint]
,	@iItemUID	[bigint]
,	@iItemID	[int]
,	@iELevel	[tinyint]
,	@iOK		[int] = 0


AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRAN

	INSERT INTO dbo.StatsItemBreak(ServerSetID, UnitUID,	ItemUID, ItemID, ELevel	,RegDate)
		SELECT @iServerSetID, @iUnitUID, @iItemUID, @iItemID, @iELevel, GetDate()

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
-- =============================================
-- Author:		sutamtwo
-- Create date: 2009. 10. 26
-- Description: 중복패킷 관련 핵유저 등록
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_statsHackUser_INS]
	@iServerSetID		TINYINT
,	@strUserID	NVARCHAR(30)
,	@iChannel	TINYINT

AS

SET NOCOUNT ON;

DECLARE	@sdtNow	SMALLDATETIME
SELECT	@sdtNow	= GETDATE()

	INSERT INTO dbo.statsHackUser (UserID, Channel, RegDate)
		SELECT @strUserID, @iChannel, @sdtNow
GO
-- =============================================
-- Author:		sutamtwo
-- Create date: 2008. 05. 21
-- Description: 특정 유저가 얻는 아이템 로그 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_StatsGetItemLog_INS]
	@iServerSetID	TINYINT	
,	@iUnitUID	bigint
,	@iRewardState tinyint
,	@iItemID	int
,	@iQuantity	tinyint
,	@iOK		int = 0
AS 

SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE	@sdtNow	smalldatetime
SELECT	@sdtNow	= GetDate()


	INSERT INTO dbo.StatsGetItemLog (ServerSetID, UnitUID, RewardState, ItemID, Quantity, RegDate)
		SELECT @iServerSetID, @iUnitUID, @iRewardState, @iItemID, @iQuantity, @sdtNow
	
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN
			SELECT @iOK = -1
		END

SELECT @iOK
GO
-- =============================================
-- Author:		sutamtwo
-- Create date: 2008. 06. 11
-- Description: 아이템 강화 로그
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_StatsEnchantLog_INS]
	@iServerSetID	TINYINT	
,	@iUserUID	bigint
,	@iUnitUID	bigint
,	@iItemID	int
,	@iItemUID	bigint
,	@iTryELevel	tinyint
,	@iResult	tinyint
,	@iOK		int = 0
	
AS

SET NOCOUNT ON;

/*
	ERS_NONE = 0,		비정상결과
	ERS_SUCCESS = 1		성공
	ERS_NO_CHANGE, = 2  변화없음
	ERS_LEVEL_DOWN, = 3 레벨 하락
	ERS_RESET, = 4      레벨 초기화
	ERS_BROKEN, = 5     아이템 파괴 
*/
INSERT INTO	dbo.StatsEnchantLog (ServerSetID, UserUID, UnitUID, ItemID, ItemUID, TryELevel,	Result)
	SELECT @iServerSetID,	@iUserUID, @iUnitUID , @iItemID, @iItemUID, @iTryELevel, @iResult

IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	BEGIN
		SELECT @iOK = -1	
	END

SELECT @iOK
GO
-- =============================================
-- Author:		sutamtwo
-- Create date: 2008년 12월 18일
-- Description: 강화보조제 사용 로그
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_statsEnchantAid_INS]
	@iServerSetID		TINYINT
,	@iItemUID			[bigint]
,	@iBefore			[tinyint]
,	@iAfter				[tinyint]
,	@bUseSupport		[bit] = 0
,	@bUsePlus			[bit] = 0
,	@bUseDestroyGuard	[bit] = 0
,	@iOK				[int] = 0
AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRAN

	INSERT INTO dbo.statsEnchantAid (ServerSetID, ItemUID, Before, After, UseSupport, UsePlus, UseDestroyGuard, RegDate)
		SELECT @iServerSetID, @iItemUID, @iBefore, @iAfter, @bUseSupport, @bUsePlus, @bUseDestroyGuard, GetDate()
		
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
-- =============================================
-- Author:		sutamtwo
-- Create date: 2007년 10월 24일
-- Description: 던전별 Mode Count 및 Play Time 기록
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_StatsDungeon_SET]
	@iServerSetID		TINYINT
,	@iUnitUID		[bigint]
,	@iDungeonID		[int]
,	@iSW_Cnt		[tinyint]
,	@iSL_Cnt		[tinyint]
,	@iSG_Cnt		[tinyint]
,	@iSRS_Cnt		[smallint]
,	@iPW_Cnt		[tinyint]
,	@iPL_Cnt		[tinyint]
,	@iPG_Cnt		[tinyint]
,	@iPRS_Cnt		[smallint]
,	@iSW_Time		[smallint]	
,	@iSL_Time		[smallint]
,	@iSG_Time		[smallint]
,	@iPW_Time		[smallint]
,	@iPL_Time		[smallint]
,	@iPG_Time		[smallint]
,	@iOK_			[int] = 0


AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

IF NOT EXISTS(select * from [game01].dbo.GUnit with (nolock) where unituid = @iUnitUID)
	-- 해당 유닛 없음
	BEGIN    SELECT @iOK_ = -1     GOTO END_PROC    END

BEGIN TRAN
	IF NOT EXISTS(SELECT * FROM dbo.StatsDungeon WITH (NOLOCK) WHERE Unituid = @iUnitUID and DungeonID = @iDungeonID)
		BEGIN
			DECLARE @iUnitClass	tinyint
			SELECT	@iUnitClass = UnitClass FROM [Game01].[dbo].[GUnit] WITH (NOLOCK) WHERE  UnitUID = @iUnitUID 

			INSERT INTO dbo.StatsDungeon (ServerSetID, UnitUID, DungeonID, UnitClass)
				SELECT @iServerSetID, @iUnitUID, @iDungeonID, @iUnitClass
				IF @@ERROR <> 0
					BEGIN	SELECT @iOK_ = -101	GOTO FAIL_TRAN	END
		END
	
	UPDATE dbo.StatsDungeon WITH (UPDLOCK)
		SET	SW_Cnt  = SW_Cnt  + @iSW_Cnt 	      
,			SL_Cnt  = SL_Cnt  + @iSL_Cnt 	      
,			SG_Cnt  = SG_Cnt  + @iSG_Cnt 	      
,			SRS_Cnt = SRS_Cnt + @iSRS_Cnt 
,			PW_Cnt  = PW_Cnt  + @iPW_Cnt 	      
,			PL_Cnt  = PL_Cnt  + @iPL_Cnt  	      
,			PG_Cnt  = PG_Cnt  + @iPG_Cnt 	      
,			PRS_Cnt = PRS_Cnt + @iPRS_Cnt
,			SW_Time = SW_Time + @iSW_Time
,			SL_Time = SL_Time + @iSL_Time
,			SG_Time = SG_Time + @iSG_Time
,			PW_Time = PW_Time + @iPW_Time
,			PL_Time = PL_Time + @iPL_Time
,			PG_Time = PG_Time + @iPG_Time
		WHERE Unituid = @iUnitUID and DungeonID = @iDungeonID

	IF @@ERROR <> 0
		BEGIN	SELECT @iOK_ = -102	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK_, @iUnitUID
GO
-- =============================================
-- Author:		sutamtwo
-- Create date: 2008-10-22
-- Description: 캐시템 분해 시 로그 남김
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_StatsDecomposition_INS]
	@iServerSetID		TINYINT
,	@iUnitUID			bigint
,	@iItemUID			bigint
,	@iQuantity			tinyint
,	@iAfterItemID		int = NULL
,	@iAfterItemQuantity	int = NULL
,	@iLevel				tinyint = NULL
,	@iOK				int = 0
AS

SET NOCOUNT ON;

DECLARE @sdtNow	smalldatetime
SELECT	@sdtNow = GETDATE()


BEGIN TRAN

	INSERT INTO dbo.StatsDecomposition (ServerSetID, UnitUID, ItemUID, Quantity, RegDate, AfterItemID, AfterItemQuantity, [Level] )
		VALUES (@iServerSetID, @iUnitUID, @iItemUID, @iQuantity, GETDATE(), @iAfterItemID, @iAfterItemQuantity, @iLevel )
	
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END
	
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
-- =============================================
-- Author:		sutamtwo
-- Create date: 2011년 02월 28일
-- Description: 일일 캐릭터 생성수와 삭제수 SP
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_StatsDaily_SET]
	@iServerSetID		TINYINT
,	@iNewUnit		[int]
,	@iDelUnit		[int]
,	@iOK_			[int] = 0
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE @strRegdate	nvarchar(10)
SELECT	@strRegdate = CONVERT(nvarchar(10),getdate(),120)

BEGIN TRAN
	-- 해당 일의 데이터가 없다면 insert

		IF NOT EXISTS (SELECT * FROM dbo.StatsDaily WITH (NOLOCK) WHERE Date = @strRegdate)
			BEGIN	
				INSERT INTO dbo.StatsDaily (ServerSetID, Date, TotalUnit, NewUnit, DelUnit)
					SELECT @iServerSetID, @strRegdate, 0, @iNewUnit, @iDelUnit

						IF @@ERROR <> 0
						BEGIN	SELECT @iOK_ = -201	GOTO FAIL_TRAN	END
			END	

		ELSE
			BEGIN
				UPDATE dbo.StatsDaily WITH (UPDLOCK)
					SET	NewUnit	= NewUnit	+ @iNewUnit				
					,	DelUnit	= DelUnit	+ @iDelUnit			   	
						WHERE Date	= @strRegdate AND ServerSetID = @iServerSetID
				IF @@error <> 0
					BEGIN	SELECT @iOK_ = -202	GOTO FAIL_TRAN	END
			END
			
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK_
GO
-- =============================================
-- Author:		sutamtwo
-- Create date: 2009.06.09
-- Description: CSP 사용로그 남기기
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_StatsCSPLog_INS]
	@iServerSetID		TINYINT
,	@iUnitUID	BIGINT
,	@iLevel		TINYINT	
,	@iCSP		TINYINT
,	@iPeriod	TINYINT
,	@iIsExtend	BIT	
,	@iOK		INT	= 0
AS
SET NOCOUNT ON;

DECLARE	@sdtNow	SMALLDATETIME
SELECT	@sdtNow = GETDATE()

BEGIN TRAN	
	
	INSERT INTO dbo.StatsCSPLog (ServerSetID, UnitUID, [Level], CSPoint, Period, IsExtend, RegDate)
		SELECT @iServerSetID, @iUnitUID, @iLevel, @iCSP, @iPeriod, @iIsExtend, @sdtNow

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END

COMMIT TRAN


GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
-- =============================================
-- Author:		sutamtwo
-- Create date: 2008년 12월 30일
-- Description: 매력 아이템 사용 시 획득 아이템 관련 로그
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_StatsCharmItemLog_INS]
	@iServerSetID		TINYINT
,	@iCharItemID	[bigint]
,	@iUnitUID		[bigint]
,	@iItemID		[int]
,	@iQuantity		[tinyint]
,	@iOK			[int] = 0
AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRAN

	INSERT INTO dbo.StatsCharmItemLog (ServerSetID, CharmItemID, UnitUID, ItemID, Quantity, RegDate)
		SELECT @iServerSetID, @iCharItemID, @iUnitUID, @iItemID, @iQuantity, GetDate()

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
-- =============================================
-- Author:		sutamtwo
-- Create date: 2008년 12월 30일
-- Description: 매력 아이템 중 Direct로 강화 시켜주는 아이템 사용 시 로그
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_StatsCharmItemLog_Direct_INS]
	@iServerSetID		TINYINT
,	@iUnitUID	[bigint]
,	@iItemID	[int]
,	@iItemUID	[bigint]
,	@iBefore	[tinyint]
,	@iAfter		[tinyint]
,	@iOK		[int] = 0
AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRAN

	INSERT INTO dbo.StatsCharmItemLog_Direct (ServerSetID, UnitUID, ItemID, ItemUID, Before, After, RegDate)
		SELECT @iServerSetID, @iUnitUID, @iItemID, @iItemUID, @iBefore, @iAfter, GetDate()

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_StatsCashLog_INS]
	@iServerSetID	TINYINT
,	@iUnitUID	bigint 
,	@iItemID	int
,	@iPeriod	smallint
,	@iQuantity	SMALLINT
,	@iLevel		TINYINT
,	@iUnitClass	tinyint
,	@iOK		int = 0
AS
SET NOCOUNT ON;

DECLARE	@sdtNow smalldatetime
SELECT	@sdtNow = GETDATE()

BEGIN TRAN

	INSERT INTO dbo.StatsCashLog (ServerSetID, UnitUID, ItemID, Period, Quantity, RegDate, [Level], UnitClass)
		SELECT @iServerSetID, @iUnitUID, @iItemID, @iPeriod, @iQuantity, @sdtNow, @iLevel, @iUnitClass
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2011년 01월 05일
-- Description: 속성석 대신 이벤트 기간내 정제된 엘의 조각 사용 시 로그
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_StatsAttrib_AttachLog_INS]
	@iServerSetID		TINYINT
,	@iUnitUID		[bigint]
,	@iItemID		[int]
,	@iItemUID		[bigint]
,	@iBeforeSlot1	[tinyint]
,	@iBeforeSlot2	[tinyint]
,	@iBeforeSlot3	[tinyint]
,	@iAfterSlot1	[tinyint]
,	@iAfterSlot2	[tinyint]
,	@iAfterSlot3	[tinyint]
,	@iOK		[int] = 0


AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRAN

	INSERT INTO dbo.StatsAttrib_AttachLog (ServerSetID, UnitUID, ItemID, ItemUID, BeforeSlot1, BeforeSlot2, BeforeSlot3, AfterSlot1, AfterSlot2, AfterSlot3, RegDate)
		SELECT @iServerSetID, @iUnitUID, @iItemID, @iItemUID, @iBeforeSlot1, @iBeforeSlot2, @iBeforeSlot3, @iAfterSlot1, @iAfterSlot2, @iAfterSlot3, GetDate()

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
-- =============================================
-- Author:		sutamtwo
-- Create date: 2009. 06. 03
-- Description: 스킬 전체 초기화 사용 로그
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_StatsAllSkillDelete_INS]
(
	@iServerSetID	TINYINT
,	@iUnitUID	BIGINT
,	@iItemUID	BIGINT	
,	@iSPoint	INT
,	@iCSP		INT
,	@iOK		INT	= 0
)
AS

SET NOCOUNT ON;
SET XACT_ABORT ON ;

BEGIN TRAN

	INSERT INTO dbo.StatsAllSkillDelete (ServerSetID, UnitUID, ItemUID, SPoint, CSP, RegDate)
		SELECT @iServerSetID, @iUnitUID, @iItemUID, @iSPoint, @iCSP, GETDATE()
	
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END
	
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
-- =============================================
-- Author:		sutamtwo
-- Create date: 2008. 03. 04
-- Description: 어뷰저 로그 남기기
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_StatsAbusingLog_INS]
	@iServerSetID		TINYINT
,	@iUserUID		bigint
,	@iUnitUID		bigint
,	@strIP			nvarchar(15)
,	@iVsType		tinyint
,	@iVsSetTime		smallint
,	@bIsSecret		bit
,	@iPlayerCnt		tinyint
,	@sdtVsEndTime	smalldatetime
,	@iPlayTime		int
,	@iGetVP			int
,	@iGetExp		int
,	@iKillCnt		tinyint
,	@iDeathCnt		tinyint
,	@iOK			int = 0

AS
SET NOCOUNT ON;
SET XACT_ABORT ON;


DECLARE	@sdtVsStartTime	smalldatetime
SELECT  @sdtVsStartTime = DATEADD(SS, -@iPlayTime, GETDATE())


BEGIN TRAN

	INSERT INTO dbo.StatsAbusingLog (ServerSetID, UnitUID, UserUID, IP, VsType, VsSetTime, IsSecret, PlayerCnt, VsStartTime, VsEndTime, VsPlayTime, GetVP, GetEXP, KillCnt, DeathCnt)
		SELECT @iServerSetID, @iUnitUID, @iUserUID, @strIP, @iVsType, @iVsSetTime, @bIsSecret, @iPlayerCnt, @sdtVsStartTime, @sdtVsEndTime, @iPlayTime, @iGetVP, @iGetExp, @iKillCnt, @iDeathCnt
	
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN 
			SELECT @iOK = -1
			GOTO FAIL_TRAN
		END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK


--create table dbo.StatsAbusingLog
--(
--	UnitUID		bigint not null
--,	UserUID		bigint not null
--,	IP			nvarchar(15)
--,	VsType		tinyint
--,	VsSetTime	smallint
--,	IsSecret	bit
--,	PlayerCnt	tinyint
--,	VsStartTime	smalldatetime
--,	VsEndTime	smalldatetime
--,	VsPlayTime	int
--,	GetVP		int
--,	GetExp		int
--,	KillCnt		tinyint
--,	DeathCnt	tinyint
--)
--
--create clustered index IXC_StatsAbusingLog_UnitUID on dbo.StatsAbusingLog(UnitUID) with fillfactor = 80
--create nonclustered index IX_StatsAbusingLog_UserUID on dbo.StatsAbusingLog(UserUID) with fillfactor = 80

--
--1. UserUID
--2. UnitUID
--3. 접속 IP
--4. 방 모드(데스, 팀데, 팀)
--5. 방 제한시간
--6. 비밀방 여부
--7. 대전방 참석인원
--8. 종료시간
--9. 플레이시간
--10. 획득 VP
--11. 획득 EXP
GO
-- =============================================
-- Author:		sutamtwo
-- Create date: 2009. 09. 01
-- Description: 알 수 없는 비정상 종료의 값을 체크
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_StatsAbnormalReason_SEL]
	@iServerSetID	TINYINT
,	@iServerUID	INT
,	@iReason	INT
,	@iCnt		INT
AS

SET NOCOUNT ON;

DECLARE @sdtNow smalldatetime
SELECT  @sdtNow = GetDate()

INSERT INTO dbo.StatsAbnormalReason (ServerSetID, ServerUID, Reason, Cnt, RegDate)
	SELECT @iServerSetID, @iServerUID, @iReason, @iCnt, @sdtNow
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LDungeonLog_INS]
	@iServerSetID		TINYINT = 0,
	@strServerIP		NVARCHAR(15),
	@iDungeonID			INT,
	@iUnitUID			BIGINT,
	@strNickName		NVARCHAR(20),
	@iDiffculty			TINYINT,
	@bIsChallenge		BIT,
	@iUnitClass			TINYINT,
	@iClear				TINYINT,
	@iStartMember		TINYINT,
	@iEndMemeber		TINYINT,
	@iLV				TINYINT,
	@iPlayTime			INT,
	@iEXP				INT,
	@iED				INT,
	@iCombo				TINYINT,
	@iComboScore		INT,
	@iTechnical			TINYINT,
	@iTechnScore		INT,
	@iTime				TINYINT,
	@iDamaged			TINYINT,
	@iDamagedNum		INT,
	@iRank				TINYINT,
	@iContinue			TINYINT,
	@iPassStage			TINYINT,
	@iPassSubSt			TINYINT,
	@bWithPet			BIT,
	@sdtRegDate			SMALLDATETIME,
	@iNpcDieCount		SMALLINT,
	@iGivenDamage		BIGINT,
	@iAttackDamage		BIGINT,
	@iUsingSkillKind	SMALLINT,
	@iTotalEXP			INT,
	@iPetID				INT,
	@iPetEvoStep		TINYINT,
	@iDashCount			INT,			-- 2012.03.15 업데이트에 추가
	@iEndHP				INT,			-- 2012.06.21 업데이트에 추가
	@iStartContinue		SMALLINT,		-- 2012.06.21 업데이트에 추가
	@iContinueUseStage	SMALLINT,		-- 2012.06.21 업데이트에 추가
	@iContinueUseSub	SMALLINT,		-- 2012.06.21 업데이트에 추가
	@iFrame				SMALLINT,		-- 2012.06.21 업데이트에 추가
	@iBaseHP			INT,			-- 2012.07.05 업데이트에 추가
	@iRecovHP			INT,			-- 2012.07.05 업데이트에 추가
	@strChannelIP		NVARCHAR(15),	-- 2012.07.05 업데이트에 추가
	@iUserUID			BIGINT,			-- 2012.07.12 업데이트에 추가
	@bIsMatchStart		BIT,			-- 2012.11.08 업데이트에 추가
	@iMatchWait			INT,			-- 2012.11.22 업데이트에 추가
	@iLeaveReason		INT,			-- 2012.12.13 업데이트에 추가
	@iRoomState			TINYINT,		-- 2012.12.13 업데이트에 추가
	@bSkillSlotType		BIT,			-- 2012.12.13 업데이트에 추가
	@iOK				INT = 0
	
AS
SET NOCOUNT ON;

BEGIN TRAN

	INSERT INTO dbo.LDungeonLog (ServerSetID, ServerIP, DungeonID, UnitUID, NickName, Diffculty, IsChallenge, UnitClass, [Clear], StartMember, EndMemeber, LV,
	                             PlayTime, [EXP], ED, Combo, ComboScore, Technical, TechnScore, [Time], Damaged, DamagedNum, [Rank], [Continue],
	                             PassStage, PassSubSt, WithPet, RegDate, NpcDieCount, GivenDamage, AttackDamage, UsingSkillKind, TotalEXP, PetID, PetEvoStep, DashCount,
	                             EndHP, StartContinue, ContinueUseStage, ContinueUseSub, Frame, BaseHP, RecovHP, ChannelIP, UserUID, IsMatchStart, MatchWait,
	                             LeaveReason, RoomState, SkillSlotType)
	    SELECT @iServerSetID, @strServerIP, @iDungeonID, @iUnitUID, @strNickName, @iDiffculty, @bIsChallenge, @iUnitClass, @iClear, @iStartMember, @iEndMemeber, @iLV, 
			   @iPlayTime, @iEXP, @iED, @iCombo, @iComboScore, @iTechnical, @iTechnScore, @iTime, @iDamaged, @iDamagedNum, @iRank, @iContinue,
			   @iPassStage, @iPassSubSt, @bWithPet, @sdtRegDate, @iNpcDieCount, @iGivenDamage, @iAttackDamage, @iUsingSkillKind, @iTotalEXP, @iPetID, @iPetEvoStep, @iDashCount,
			   @iEndHP, @iStartContinue, @iContinueUseStage, @iContinueUseSub, @iFrame, @iBaseHP, @iRecovHP, @strChannelIP, @iUserUID, @bIsMatchStart, @iMatchWait,
			   @iLeaveReason, @iRoomState, @bSkillSlotType
			   
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -111	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2012.12.12
-- Description:	던전 결과창에서 접속을 끊는 경우, 
--				필드로 돌아오지 못하는 유저 확인용
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LDungeonLeaveLog_INT]
	@UnitUID		bigint
,	@LeaveReason	nvarchar(30)
,	@RoomState		nvarchar(30)
,	@RegDate		smalldatetime

AS
	SET NOCOUNT ON
	
	DECLARE	@Result		int

		BEGIN TRY
			BEGIN TRAN

			INSERT INTO dbo.LDungeonLeaveLog( UnitUID, LeaveReason, RoomState, RegDate )
			VALUES( @UnitUID, @LeaveReason, @RoomState ,@RegDate )

			COMMIT TRAN

			SET @Result = 0
		END TRY
		BEGIN CATCH
			DECLARE @NO_XACT_STATE		smallint
			SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

			IF @NO_XACT_STATE <> 0
				ROLLBACK TRAN

			EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

			IF @Result = 0 OR @Result IS NULL
				SET @Result = -1
		END CATCH

	SELECT @Result AS Result
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2012.12.12
-- Description:	던전 결과창에서 접속을 끊는 경우, 
--				필드로 돌아오지 못하는 유저 확인용
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LDungeonLeaveLog_INS]
	@iServerSetID		TINYINT
,	@UnitUID		bigint
,	@LeaveReason	nvarchar(30)
,	@RoomState		nvarchar(30)
,	@RegDate		smalldatetime

AS
	SET NOCOUNT ON
	
	DECLARE	@Result		int

		BEGIN TRY
			BEGIN TRAN

			INSERT INTO dbo.LDungeonLeaveLog( UnitUID, LeaveReason, RoomState, RegDate )
			VALUES( @UnitUID, @LeaveReason, @RoomState ,@RegDate )

			COMMIT TRAN

			SET @Result = 0
		END TRY
		BEGIN CATCH
			DECLARE @NO_XACT_STATE		smallint
			SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

			IF @NO_XACT_STATE <> 0
				ROLLBACK TRAN

			EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

			IF @Result = 0 OR @Result IS NULL
				SET @Result = -1
		END CATCH

	SELECT @Result AS Result
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LDisconnectUserFSM_INS]
	@iServerSetID		TINYINT,	
	@ServerUID			[int],
	@iS_INIT			[int],
	@iS_UID_UPDATED		[int],
	@iS_LOGINED			[int],
	@iS_SERVER_SELECT	[int],
	@iS_UNIT_SELECT		[int],
	@iS_VILLAGE_MAP		[int],
	@iS_LOCAL_MAP		[int],
	@iS_WORLD_MAP		[int],
	@iS_CHANNEL			[int],
	@iS_ROOM			[int],
    @iOK				[int] = 0
AS

SET NOCOUNT ON;

DECLARE @sdtNow smalldatetime
SELECT  @sdtNow = GetDate()

BEGIN TRAN
    INSERT INTO dbo.LDisconnectUserFSM( 
		ServerSetID,
		ServerUID,
		RegDate, 
		S_INIT, 
		S_UID_UPDATED,
		S_LOGINED, 
		S_SERVER_SELECT, 
		S_UNIT_SELECT, 
		S_VILLAGE_MAP,
		S_LOCAL_MAP, 
		S_WORLD_MAP, 
		S_CHANNEL, 
		S_ROOM )
    SELECT @iServerSetID, @ServerUID, @sdtNow, @iS_INIT, @iS_UID_UPDATED, @iS_LOGINED, @iS_SERVER_SELECT, @iS_UNIT_SELECT, @iS_VILLAGE_MAP, @iS_LOCAL_MAP,
		@iS_WORLD_MAP, @iS_CHANNEL, @iS_ROOM
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
    BEGIN
        SELECT @iOK = -1
        GOTO FAIL_TRAN
    END
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
/*
	2011.05.07
	김병일
	신규 추가
	Mail_Crash_Report 관련 SP 통합
*/
CREATE OR ALTER PROCEDURE [dbo].[P_LDisconnectReason_SEL]
	@iServerSetID		tinyint				-- 서버 그룹 추가
,	@startDate			nchar(10)
AS
	SET NOCOUNT ON

	IF EXISTS (SELECT * FROM dbo.LDisconnectReason WITH(NOLOCK) WHERE RegDate >= @startDate AND ServerSetID = @iServerSetID ) BEGIN
		SELECT SUM(No_reason)           AS No_reason,           SUM(Unknown)             AS Unknown,             SUM(NProtect_Auth_Fail)       AS NProtect_Auth_Fail
		,      SUM(PCBang_Auth_Delay)   AS PCBang_Auth_Delay,   SUM(Diff_Main_Ver)       AS Diff_Main_Ver,       SUM(Limit_User_Num)           AS Limit_User_Num
		,      SUM(Nexon_Auth_Fail)     AS Nexon_Auth_Fail,     SUM(Same_Server_Connect) AS Same_Server_Connect, SUM(Account_Block)            AS Account_Block
		,      SUM(IP_Block)            AS IP_Block,            SUM(NProtect_Auth_First) AS NProtect_Auth_First, SUM(PCBang_Auth_Fail)         AS PCBang_Auth_Fail
		,      SUM(PCBang_Auth_Wrong)   AS PCBang_Auth_Wrong,   SUM(Internal_Account)    AS Internal_Account,    SUM(Normal_Disconnect)        AS Normal_Disconnect
		,      SUM(Client_Crash)        AS Client_Crash,        SUM(Client_Hacking)      AS Client_Hacking,      SUM(NProtect_Wrong_Ack)       AS NProtect_Wrong_Ack
		,      SUM(PCBang_Auth_Server)  AS PCBang_Auth_Server,  SUM(Server_Shutdown)     AS Server_Shutdown,     SUM(Session_Close)            AS Session_Close
		,      SUM(WSAECONNRESET)       AS WSAECONNRESET,       SUM(WSARecvFailed)       AS WSARecvFailed,       SUM(WSASendFailed_OnSendComp) AS WSASendFailed_OnSendComp
		,      SUM(SendBufferFull)      AS SendBufferFull,      SUM(WSASendFailed)       AS WSASendFailed,       SUM(GM_Kick_User)             AS GM_Kick_User
		,      SUM(Diff_Server_Connect) AS Diff_Server_Connect, SUM(User_Reg_Error)      AS User_Reg_Error,      SUM(Heart_Beat)               AS Heart_Beat
		,      SUM(IOCP_GetStatus)      AS IOCP_GetStatus,      SUM(NProtect_Hacking)    AS NProtect_Hacking
		,	   CONVERT(NVARCHAR(10), RegDate, 120) AS RegDate
		FROM dbo.LDisconnectReason WITH(NOLOCK)
		WHERE RegDate >= @startDate
			AND ServerSetID = @iServerSetID
		GROUP BY CONVERT(NVARCHAR(10), RegDate, 120)
	END
GO
/*
	2012.03.05
	김병일
	신규 추가
	Mail_Crash_Report_New 관련 SP(서영진)
*/
CREATE OR ALTER PROCEDURE [dbo].[P_LDisconnectReason_New_SEL]
	@date			nchar(10) = NULL
AS
	SET NOCOUNT ON

	DECLARE @sdtStart		smalldatetime
	,		@sdtEnd			smalldatetime

	IF @date IS NULL
        SET @date = CONVERT(nchar(10), DATEADD(dd, -1, GETDATE()), 120)

	IF ISDATE(@date) =1 BEGIN
		SET @sdtStart = @date +' 00:00'
        SET @sdtEnd = @date +' 23:59'
        
		SELECT SUM(TotalCNT) AS TotalCNT, SUM(ClientCrash) AS ClientCrash, SUM(ServerFullDis) AS ServerFullDis , SUM(IOCPGetStatus) AS IOCPGetStatus, @date
		FROM
		(
		SELECT 
			TotalCNT = CASE DisconnectType 
				WHEN 5 THEN 0 
				ELSE CNT 
			END,
			ClientCrash = CASE DisconnectType 
				WHEN 15 THEN CNT
				ELSE 0
			END,
			IOCPGetStatus = CASE DisconnectType
				WHEN 30 THEN CNT
				ELSE 0
			END,
			ServerFullDis = CASE DisconnectType
				WHEN 5 THEN CNT
				ELSE 0
			END
		FROM dbo.LDisconnectReason_New WITH(NOLOCK)
		WHERE RegDate BETWEEN @sdtStart AND @sdtEnd
		) AS DIS

	END
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 종료사유 테이블 새로 생성(확장성 위해서)
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LDisconnectReason_New_INS]
	@iServerSetID		TINYINT
,	@ServerUID		int
,	@RegDate		smalldatetime
,	@DisconnectType	int
,	@CNT			int
AS
	SET NOCOUNT ON

	DECLARE @Result		int

	BEGIN TRY
		BEGIN TRAN

		INSERT INTO	dbo.LDisconnectReason_New ( ServerUID, RegDate, DisconnectType, CNT )
		VALUES ( @ServerUID, @RegDate, @DisconnectType, @CNT )

		COMMIT TRAN

		SET @Result = 0
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

		SET @Result = -1
	END CATCH

	SELECT @Result
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LDisconnectReason_INS]
	@iServerSetID			TINYINT,	
	@ServerUID				[int],
	@No_Reason				[int],
	@Unknown				[int],
	@NProtect_Auth_Fail		[int],
	@PCBang_Auth_Delay		[int],
	@Diff_Main_Ver			[int],
	@Limit_User_Num			[int],
	@Nexon_Auth_Fail		[int],
	@Same_Server_Connect	[int],
	@Account_Block			[int],
	@IP_Block				[int],
	@NProtect_Auth_First	[int],
	@PCBang_Auth_Fail		[int],
	@PCBang_Auth_Wrong		[int],
	@Internal_Account		[int],
	@Normal_Disconnect		[int],
	@Client_Crash			[int],
	@Client_Hacking			[int],
	@NProtect_Wrong_Ack		[int],
	@PCBang_Auth_Server		[int],
	@Server_Shutdown		[int],
	@Session_Close			[int],
	@WSAECONNRESET			[int],
	@WSARecvFailed			[int],
	@WSASendFailed_OnSendComp[int],
	@SendBufferFull			[int],
	@WSASendFailed			[int],
	@GM_Kick_User			[int],
	@Diff_Server_Connect	[int],
	@User_Reg_Error			[int],
	@Heart_Beat				[int],
	@IOCP_GetStatus			[int],
	@NProtect_Hacking		[int],
	@ChannelChange			[int],
	@Channel_Change_Fail	[int],
	@Traffic_Attack			[int],
	@ServerAccBlock			[int],
	@MachineIDBlock			[int],
	@Same_MachineID_Connect	[int],
	@Shutdown_System		[int],
    @iOK					[int] = 0
AS

SET NOCOUNT ON;

DECLARE @sdtNow smalldatetime
SELECT  @sdtNow = GetDate()

BEGIN TRAN
    INSERT INTO dbo.LDisconnectReason( 
		ServerSetID,
		ServerUID,
		RegDate, 
		No_Reason,
		Unknown,
		NProtect_Auth_Fail,
		PCBang_Auth_Delay,
		Diff_Main_Ver,
		Limit_User_Num,
		Nexon_Auth_Fail,
		Same_Server_Connect,
		Account_Block,
		IP_Block,
		NProtect_Auth_First,
		PCBang_Auth_Fail,
		PCBang_Auth_Wrong,
		Internal_Account,
		Normal_Disconnect,
		Client_Crash,
		Client_Hacking,
		NProtect_Wrong_Ack,
		PCBang_Auth_Server,
		Server_Shutdown,
		Session_Close,
		WSAECONNRESET,
		WSARecvFailed,
		WSASendFailed_OnSendComp,
		SendBufferFull,
		WSASendFailed,
		GM_Kick_User,
		Diff_Server_Connect,
		User_Reg_Error,		
		Heart_Beat,
		IOCP_GetStatus,
		NProtect_Hacking,
		ChannelChange,
		Channel_Change_Fail,
		Traffic_Attack,
		ServerAccBlock,
		MachineIDBlock,
		Same_MachineID_Connect,
		Shutdown_System
		)
    SELECT 
		@iServerSetID,
		@ServerUID,
		@sdtNow,
		@No_Reason,
		@Unknown,
		@NProtect_Auth_Fail,
		@PCBang_Auth_Delay,
		@Diff_Main_Ver,
		@Limit_User_Num,
		@Nexon_Auth_Fail,
		@Same_Server_Connect,
		@Account_Block,
		@IP_Block,
		@NProtect_Auth_First,
		@PCBang_Auth_Fail,
		@PCBang_Auth_Wrong,
		@Internal_Account,
		@Normal_Disconnect,
		@Client_Crash,
		@Client_Hacking,
		@NProtect_Wrong_Ack,
		@PCBang_Auth_Server,
		@Server_Shutdown,
		@Session_Close,
		@WSAECONNRESET,
		@WSARecvFailed,
		@WSASendFailed_OnSendComp,
		@SendBufferFull,
		@WSASendFailed,
		@GM_Kick_User,
		@Diff_Server_Connect,
		@User_Reg_Error,
		@Heart_Beat,
		@IOCP_GetStatus,
		@NProtect_Hacking,
		@ChannelChange,
		@Channel_Change_Fail,
		@Traffic_Attack,
		@ServerAccBlock,
		@MachineIDBlock,
		@Same_MachineID_Connect,
		@Shutdown_System
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
    BEGIN
        SELECT @iOK = -1
        GOTO FAIL_TRAN
    END
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
/*
	2011.05.07
	김병일
	신규 추가
	Mail_Crash_Report_AbNormal 관련 SP 통합
*/
CREATE OR ALTER PROCEDURE [dbo].[P_LDisconnectReason_abnormal_SEL]
	@iServerSetID		tinyint				-- 서버 그룹 추가
,	@startDate			nchar(10)
,	@endDate			nchar(10) = NULL
AS
	SET NOCOUNT ON
	
	IF @endDate IS NULL
		SET @endDate = CONVERT(nchar(10), DATEADD(dd, 1, @startDate), 120)

	SELECT ISNULL(B.ChannelName, N'') AS ChannelName
	,      SUM(S_INIT)                AS S_INIT,          SUM(S_UID_UPDATED) AS S_UID_UPDATED, SUM(S_LOGINED)     AS S_LOGINED
	,      SUM(S_SERVER_SELECT)       AS S_SERVER_SELECT, SUM(S_UNIT_SELECT) AS S_UNIT_SELECT, SUM(S_VILLAGE_MAP) AS S_VILLAGE_MAP
	,      SUM(S_LOCAL_MAP)           AS S_LOCAL_MAP,     SUM(S_WORLD_MAP)   AS S_WORLD_MAP,   SUM(S_CHANNEL)     AS S_CHANNEL
	,      SUM(S_ROOM)                AS S_ROOM
	FROM dbo.LDisconnectReason_abnormal AS A WITH(NOLOCK)
	JOIN dbo.LChannelList AS B WITH(NOLOCK) ON A.ChannelID = B.ChannelID
	WHERE RegDate >= @startDate AND RegDate < @endDate
		AND A.ServerSetID = @iServerSetID
	GROUP BY B.ChannelName, A.ChannelID
	ORDER BY A.ChannelID
GO
/*
	2011. 04. 25	
	Hwang
*/		

-- =============================================
-- Author:		Hwang
-- Create date: 2011. 04. 25
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LDefense_Crystal_SET]
	@iServerSetID	TINYINT
,	@iTargetCrystal			int
,	@sdtWsrtStartTime		SMALLDATETIME
,	@iProtectedCrystalCount	int
,	@iOK					int = 0
AS
SET NOCOUNT ON;

BEGIN TRAN

	IF NOT EXISTS (SELECT * FROM dbo.LDefense_Crystal WITH (NOLOCK) WHERE WsrtStartTime = @sdtWsrtStartTime AND ServerSetID = @iServerSetID)
		BEGIN
			INSERT INTO dbo.LDefense_Crystal (ServerSetID, TargetCrystal, WsrtStartTime, ProtectedCrystalCount)
				SELECT	@iServerSetID, @iTargetCrystal, @sdtWsrtStartTime, @iProtectedCrystalCount	

			IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
				BEGIN	SELECT @iOK = -100	GOTO FAIL_TRAN	END
		END
		
	ELSE
		BEGIN
			UPDATE dbo.LDefense_Crystal
				SET ProtectedCrystalCount = @iProtectedCrystalCount
					WHERE WsrtStartTime = @sdtWsrtStartTime
					AND ServerSetID = @iServerSetID
					
			IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
				BEGIN	SELECT @iOK = -101	GOTO FAIL_TRAN	END
		END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2011. 04. 25	
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LDefense_Crystal_SEL]
	@iServerSetID	TINYINT	
,	@sdtWsrtStartTime	smalldatetime	
AS
SET NOCOUNT ON;

	SELECT TargetCrystal, ProtectedCrystalCount
		FROM dbo.LDefense_Crystal WITH (NOLOCK)
			WHERE WsrtStartTime = @sdtWsrtStartTime
			AND ServerSetID = @iServerSetID
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LConnectLog_INS]
	@iServerSetID		TINYINT,
    @UserUID            [bigint],
    @IP                 [nvarchar](15),
    @LoginTime          [smalldatetime],
    @LogoutTime         [smalldatetime],
    @LoginFail          [bit],
    @LogoutFail         [bit],
	@iTotalPlayTime		[int],
	@iVsPlayTime		[int],
	@iDungeonPlayTime	[int],	-- 2012.11.22 업데이트
	@iFieldPlayTime		[int],	-- 2012.11.22 업데이트
	@iDisconnectReason	[tinyint],
	@iDisconnectUserFSM	[tinyint],
	@iArcadePlayTime	[int],
	@iChannelCode		int,
	@PCBangFlag			BIT = 0,
    @iOK                [int] = 0
AS

SET NOCOUNT ON;

BEGIN TRAN
    INSERT INTO dbo.LConnectLog( UserUID, IP, LoginTime, LogoutTime, LoginFail, LogoutFail, TotalPlayTime, VsPlayTime, DisconnectReason, DisconnectUserFSM, ArcadePlayTime, DungeonPlayTime, FieldPlayTime, ChannelCode, PCBangFlag)
    SELECT @UserUID, @IP, @LoginTime, @LogoutTime,@LoginFail, @LogoutFail, @iTotalPlayTime, @iVsPlayTime, @iDisconnectReason, @iDisconnectUserFSM, @iArcadePlayTime, @iDungeonPlayTime, @iFieldPlayTime, @iChannelCode, @PCBangFlag
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
    BEGIN
        SELECT @iOK = -1
        GOTO FAIL_TRAN
    END
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LComebackUserLog_INS]
	@iServerSetID		TINYINT
,	@iUserUID			BIGINT
,	@iAge				TINYINT
,	@iUnitUID			BIGINT
,	@iUnitClass			TINYINT
,	@iLevel				TINYINT
,	@bIsFirstLogin		BIT
,	@iComebackGrade		TINYINT
,	@sdtRegDate			SMALLDATETIME
,	@iOK				INT = 0

AS
SET NOCOUNT ON;			
						
BEGIN TRAN	
			
INSERT INTO dbo.LComebackUserLog (UserUID, Age, UnitUID, UnitClass, [Level], IsFirstLogin, ComebackGrade, RegDate)
	SELECT @iUserUID, @iAge, @iUnitUID, @iUnitClass, @iLevel, @bIsFirstLogin, @iComebackGrade, @sdtRegDate
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1				
			BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END
	
COMMIT TRAN						
						
GOTO END_PROC						
						
FAIL_TRAN:						
ROLLBACK TRAN						
						
END_PROC:						
SELECT @iOK
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.03.20
-- Description:	마을 성능 측정 - 평균프레임, UDP, TCP, 메모리
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LClientPerformance_Village_VillageInfo_INS]
	@UnitUID			bigint			-- 캐릭터 UID
,	@SystemKey			bigint			-- mac address
,	@AvgFrame			float			-- 평균프레임
,	@AvgFrame_StdDev	float			-- 평균프레임에 대한 표준편차
,	@FirstMemUsageCheck	bit				-- 클라구동후 최초로 마을에서 메모리 사용량 측정했는지 여부
,	@MinWorkingSetSize	float			-- 최소 workingset 크기(MB단위)
,	@MaxWorkingSetSize	float			-- 최대 workingset 크기(MB단위)
,	@MinPagefileUsage	float			-- 최소 pagefile 사용량(MB단위)
,	@MaxPagefileUsage	float			-- 최대 pagefile 사용량(MB단위)
,	@PartyType			int				-- 파티 타입(0: 파티없음, 1: 파티장, 2: 파티원, 3: 관람자 )
,	@PartyUserNum		int				-- 파티원수(자신을 뺀 수)
,	@MapID				int				-- 마을맵 ID
,	@VillageUserNum		int				-- 마을에 있는 유저 수(마을 나오기 직전의 유저 수)

AS
	SET NOCOUNT ON;
	
	DECLARE @Result			int

	BEGIN TRY
		BEGIN TRAN
			
			INSERT INTO dbo.LClientPerformance_Village_VillageInfo ( UnitUID, SystemKey, AvgFrame, AvgFrame_StdDev, FirstMemUsageCheck, MinWorkingSetSize, MaxWorkingSetSize, MinPagefileUsage, MaxPagefileUsage, PartyType, PartyUserNum, MapID, VillageUserNum, RegDate )
			VALUES ( @UnitUID, @SystemKey, @AvgFrame, @AvgFrame_StdDev, @FirstMemUsageCheck, @MinWorkingSetSize, @MaxWorkingSetSize, @MinPagefileUsage, @MaxPagefileUsage, @PartyType, @PartyUserNum,	@MapID,	@VillageUserNum, GETDATE() )

		COMMIT TRAN
		
		SET @Result = 0
		
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

		IF @Result = 0 OR @Result IS NULL
			SET @Result = -1
	END CATCH

	SELECT ISNULL(@Result, 0) AS Result
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.03.20
-- Description:	마을 성능 측정 - 알려지지 않은 랙 관련 측정
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LClientPerformance_Village_UnknownLagInfo_INS]
	@UnitUID			bigint			-- 캐릭터UID
,	@SystemKey			bigint			-- mac address
,	@LagType			int				-- 랙 구간
,	@PartyType			int				-- 파티 타입(0: 파티없음, 1: 파티장, 2: 파티원, 3: 관람자 )
,	@PartyUserNum		int				-- 파티원 수
,	@MapID				int				-- 마을맵 ID
,	@VillageUserNum		int				-- 마을에 있는 유저 수
,	@LagTime			float			-- 랙 시간
,	@PlayTime			float			-- 플레이 시간
,	@LagTotalNum		float			-- 랙 횟수
,	@LagTotalTime		float			-- 랙 총 시간

AS
	SET NOCOUNT ON;
	
	DECLARE @Result			int

	BEGIN TRY
		BEGIN TRAN
			
			INSERT INTO dbo.LClientPerformance_Village_UnknownLagInfo ( UnitUID, SystemKey, LagType, PartyType, PartyUserNum, MapID, VillageUserNum, LagTime, PlayTime, LagTotalNum, LagTotalTime, RegDate )
			VALUES ( @UnitUID, @SystemKey, @LagType, @PartyType, @PartyUserNum, @MapID, @VillageUserNum, @LagTime, @PlayTime, @LagTotalNum, @LagTotalTime, GETDATE() )
	
		COMMIT TRAN
		
		SET @Result = 0
		
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

		IF @Result = 0 OR @Result IS NULL
			SET @Result = -1
	END CATCH

	SELECT ISNULL(@Result, 0) AS Result
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.03.20
-- Description:	마을 성능 측정 - 알려진 랙 관련 측정
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LClientPerformance_Village_knownLagInfo_INS]
	@UnitUID			bigint			-- 캐릭터UID
,	@SystemKey			bigint			-- mac address
,	@LagType			int				-- 랙 구간
,	@PartyType			int				-- 파티 타입(0: 파티없음, 1: 파티장, 2: 파티원, 3: 관람자 )
,	@PartyUserNum		int				-- 파티원 수
,	@MapID				int				-- 마을맵 ID
,	@VillageUserNum		int				-- 마을 있는 유저 수
,	@LagTime			float			-- 랙 시간
,	@PlayTime			float			-- 플레이 시간
,	@LagTotalNum		float			-- 랙 횟수
,	@LagTotalTime		float			-- 랙 총 시간

AS
	SET NOCOUNT ON;
	
	DECLARE @Result			int

	BEGIN TRY
		BEGIN TRAN
			
			INSERT INTO dbo.LClientPerformance_Village_knownLagInfo ( UnitUID, SystemKey, LagType, PartyType, PartyUserNum, MapID, VillageUserNum, LagTime, PlayTime, LagTotalNum, LagTotalTime, RegDate )
			VALUES ( @UnitUID, @SystemKey, @LagType, @PartyType, @PartyUserNum, @MapID, @VillageUserNum, @LagTime, @PlayTime, @LagTotalNum, @LagTotalTime, GETDATE() )
	
		COMMIT TRAN
		
		SET @Result = 0
		
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

		IF @Result = 0 OR @Result IS NULL
			SET @Result = -1
	END CATCH

	SELECT ISNULL(@Result, 0) AS Result
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.03.20
-- Description:	유저PC 사양 정보(클라 실행 초기에 기록)
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LClientPerformance_UserPCInfo_INS]
	@UserUID	bigint			-- 계정 UID
,	@SystemKey	bigint			-- mac address
,	@CPU		nvarchar(200)
,	@Memory		nvarchar(100)
,	@GPU		nvarchar(100)
,	@OS			nvarchar(100)

AS
	SET NOCOUNT ON;
	
	DECLARE @Result			int

	BEGIN TRY
		BEGIN TRAN
			
			INSERT INTO dbo.LClientPerformance_UserPCInfo ( UserUID, SystemKey, CPU, Memory, GPU, OS, RegDate )
			VALUES ( @UserUID, @SystemKey, @CPU, @Memory, @GPU, @OS, GETDATE() )

		COMMIT TRAN
		
		SET @Result = 0
		
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

		IF @Result = 0 OR @Result IS NULL
			SET @Result = -1
	END CATCH

	SELECT ISNULL(@Result, 0) AS Result
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.03.20
-- Description:	대전 성능 측정 - 알려지지 않은 랙 관련 측정
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LClientPerformance_PVP_UnknownLagInfo_INS]
	@UnitUID			bigint			-- 캐릭터UID
,	@SystemKey			bigint			-- mac address
,	@LagType			int				-- 랙 구간
,	@MapID				int				-- 대전맵 ID
,	@PVPUserNum			int				-- 대전 유저수
,	@PVPType			int				-- 대전 룰
,	@LastRound			int				-- 마지막까지 플레이 했던 block 번호
,	@LagTime			float			-- 랙 시간
,	@PlayTime			float			-- 플레이 시간
,	@LagTotalNum		float			-- 랙 횟수
,	@LagTotalTime		float			-- 랙 총 시간

AS
	SET NOCOUNT ON;
	
	DECLARE @Result			int

	BEGIN TRY
		BEGIN TRAN
			
			INSERT INTO dbo.LClientPerformance_PVP_UnknownLagInfo ( UnitUID, SystemKey, LagType, MapID, PVPUserNum, PVPType, LastRound, LagTime, PlayTime, LagTotalNum, LagTotalTime, RegDate )
			VALUES ( @UnitUID, @SystemKey, @LagType, @MapID, @PVPUserNum, @PVPType, @LastRound, @LagTime, @PlayTime, @LagTotalNum, @LagTotalTime, GETDATE() )
	
		COMMIT TRAN
		
		SET @Result = 0
		
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

		IF @Result = 0 OR @Result IS NULL
			SET @Result = -1
	END CATCH

	SELECT ISNULL(@Result, 0) AS Result
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.03.20
-- Description:	대전 성능 측정 - 평균프레임, UDP, TCP, 메모리
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LClientPerformance_PVP_PVPInfo_INS]
	@UnitUID					bigint			-- 캐릭터UID
,	@SystemKey					bigint			-- mac address

,	@AvgFrame					float			-- 평균프레임

,	@AvgFrame_StdDev			float			-- 평균프레임에 대한 표준편차
,	@P2PMinPingTime				float			-- P2P 최소 ping time
,	@P2PMaxPingTime				float			-- P2P 최대 ping time
,	@P2PAvgPingTime				float			-- P2P 평균 ping time
,	@P2PAvgPingTime_StdDev		float			-- P2P 평균 ping time에 대한 표준편차
,	@P2PAvgPingLossRate			float			-- P2P 평균 ping loss rate

,	@RelayMinPingTime			float			-- Relay 최소 ping time
,	@RelayMaxPingTime			float			-- Relay 최대 ping time
,	@RelayAvgPingTime			float			-- Relay 평균 ping time
,	@RelayAvgPingTime_StdDev	float			-- Relay 평균 ping time에 대한 표준편차
,	@RelayAvgPingLossRate		float			-- Relay 평균 ping loss rate

-- 2013.07.08 추가 ----------------------------------------------------------------------------
,	@UDPMinPingTime				float			-- UDP 최소 ping time
,	@UDPMaxPingTime				float			-- UDP 최대 ping time
,	@UDPAvgPingTime				float			-- UDP 평균 ping time
,	@UDPAvgPingTime_StdDev		float			-- UDP 평균 ping time에 대한 표준편차
,	@UDPAvgPingLossRate			float			-- UDP 평균 ping time에 대한 표준편차
-----------------------------------------------------------------------------------------------

,	@TCPMinPingTime				float			-- TCP 최소 ping time
,	@TCPMaxPingTime				float			-- TCP 최대 ping time
,	@TCPAvgPingTime				float			-- TCP 평균 ping time
,	@TCPAvgPingTime_StdDev		float			-- TCP 평균 ping time에 대한 표준편차

,	@UDPSendCountPerSecHost		float			-- 초당 UDP Send 개수(Host 일경우)
,	@UDPSendAmountPerSecHost	float			-- 초당 UDP Send 양(Host 일경우)
,	@UDPRecvCountPerSecHost		float			-- 초당 UDP Recv 개수(Host 일경우)
,	@UDPRecvAmountPerSecHost	float			-- 초당 UDP Recv 양(Host 일경우)

,	@UDPSendCountPerSec			float			-- 초당 UDP Send 개수(Host 아닐경우)
,	@UDPSendAmountPerSec		float			-- 초당 UDP Send 양(Host 아닐경우)
,	@UDPRecvCountPerSec			float			-- 초당 UDP Recv 개수(Host 아닐경우)
,	@UDPRecvAmountPerSec		float			-- 초당 UDP Recv 양(Host 아닐경우)

,	@UDPUserSyncPacketLossRate	float			-- UDP UserSyncPacket에 대한 loss rate
,	@UDPNPCSyncPacketLossRate	float			-- UDP NpcSyncPacket에 대한 loss rate

,	@FirstMemUsageCheck			bit				-- 클라구동후 최초로 던전에서 메모리 사용량 측정했는지 여부
,	@MinWorkingSetSize			float			-- 최소 workingset 크기(MB단위)
,	@MaxWorkingSetSize			float			-- 최대 workingset 크기(MB단위)
,	@MinPagefileUsage			float			-- 최소 pagefile 사용량(MB단위)
,	@MaxPagefileUsage			float			-- 최대 pagefile 사용량(MB단위)

,	@MapID						int				-- 대전맵 ID
,	@PVPUserNum					int				-- 대전 유저수(자신을 포함한 수)
,	@PVPType					int				-- 대전 룰( ( 팀전(0) or 데스매치(1) or 서바이벌(2) ) << 16 | ( 비아이템전(0) or 아이템전(1) ) )
,	@EscapeCheck				bit				-- 던전플레이 도중에 빠져나왔는지 여부
,	@LastRound					int				-- 마지막까지 플레이 했던 round 번호( 팀매치일경우: 1, 데스매치: 레드팀 킬수 + 블루팀 킬수, 서바이벌: 전체 킬수 )

AS
	SET NOCOUNT ON;
	
	DECLARE @Result			int

	BEGIN TRY
		BEGIN TRAN
			
			INSERT INTO dbo.LClientPerformance_PVP_PVPInfo ( 
					UnitUID, SystemKey, 
					AvgFrame, AvgFrame_StdDev,
					P2PMinPingTime, P2PMaxPingTime, P2PAvgPingTime, P2PAvgPingTime_StdDev, P2PAvgPingLossRate,
					RelayMinPingTime, RelayMaxPingTime, RelayAvgPingTime, RelayAvgPingTime_StdDev, RelayAvgPingLossRate, 
					TCPMinPingTime, TCPMaxPingTime, TCPAvgPingTime, TCPAvgPingTime_StdDev, 
					UDPMinPingTime, UDPMaxPingTime, UDPAvgPingTime, UDPAvgPingTime_StdDev, UDPAvgPingLossRate,
					UDPSendCountPerSecHost, UDPSendAmountPerSecHost, UDPRecvCountPerSecHost, UDPRecvAmountPerSecHost,
					UDPSendCountPerSec, UDPSendAmountPerSec, UDPRecvCountPerSec, UDPRecvAmountPerSec,
					UDPUserSyncPacketLossRate, UDPNPCSyncPacketLossRate,
					FirstMemUsageCheck, MinWorkingSetSize, MaxWorkingSetSize, MinPagefileUsage, MaxPagefileUsage, 
					MapID, PVPUserNum, PVPType, EscapeCheck, LastRound, RegDate )
			VALUES ( 
					@UnitUID, @SystemKey, @AvgFrame, @AvgFrame_StdDev,
					@P2PMinPingTime, @P2PMaxPingTime, @P2PAvgPingTime, @P2PAvgPingTime_StdDev, @P2PAvgPingLossRate, 
					@RelayMinPingTime, @RelayMaxPingTime, @RelayAvgPingTime, @RelayAvgPingTime_StdDev, @RelayAvgPingLossRate, 
					@TCPMinPingTime, @TCPMaxPingTime, @TCPAvgPingTime, @TCPAvgPingTime_StdDev, 
					@UDPMinPingTime, @UDPMaxPingTime, @UDPAvgPingTime, @UDPAvgPingTime_StdDev, @UDPAvgPingLossRate,
					@UDPSendCountPerSecHost, @UDPSendAmountPerSecHost, @UDPRecvCountPerSecHost, @UDPRecvAmountPerSecHost,
					@UDPSendCountPerSec, @UDPSendAmountPerSec, @UDPRecvCountPerSec, @UDPRecvAmountPerSec,
					@UDPUserSyncPacketLossRate, @UDPNPCSyncPacketLossRate,
					@FirstMemUsageCheck, @MinWorkingSetSize, @MaxWorkingSetSize, @MinPagefileUsage, @MaxPagefileUsage, 
					@MapID, @PVPUserNum, @PVPType, @EscapeCheck, @LastRound, GETDATE()
					)

		COMMIT TRAN
		
		SET @Result = 0
		
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

		IF @Result = 0 OR @Result IS NULL
			SET @Result = -1
	END CATCH

	SELECT ISNULL(@Result, 0) AS Result
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.03.20
-- Description:	대전 성능 측정 - 알려진 랙 관련 측정
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LClientPerformance_PVP_knownLagInfo_INS]
	@UnitUID			bigint			-- 캐릭터UID
,	@SystemKey			bigint			-- mac address
,	@LagType			int				-- 랙 구간
,	@MapID				int				-- 대전맵 ID
,	@PVPUserNum			int				-- 대전 유저수
,	@PVPType			int				-- 대전 룰
,	@LastRound			int				-- 마지막까지 플레이 했던 block 번호
,	@LagTime			float			-- 랙 시간
,	@PlayTime			float			-- 플레이 시간
,	@LagTotalNum		float			-- 랙 횟수
,	@LagTotalTime		float			-- 랙 총 시간

AS
	SET NOCOUNT ON;
	
	DECLARE @Result			int

	BEGIN TRY
		BEGIN TRAN
			
			INSERT INTO dbo.LClientPerformance_PVP_knownLagInfo ( UnitUID, SystemKey, LagType, MapID, PVPUserNum, PVPType, LastRound, LagTime, PlayTime, LagTotalNum, LagTotalTime, RegDate )
			VALUES ( @UnitUID, @SystemKey, @LagType, @MapID, @PVPUserNum, @PVPType, @LastRound, @LagTime, @PlayTime, @LagTotalNum, @LagTotalTime, GETDATE() )
	
		COMMIT TRAN
		
		SET @Result = 0
		
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

		IF @Result = 0 OR @Result IS NULL
			SET @Result = -1
	END CATCH

	SELECT ISNULL(@Result, 0) AS Result
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.03.20
-- Description:	필드 성능 측정 - 알려지지 않은 랙 관련 측정
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LClientPerformance_Field_UnknownLagInfo_INS]
	@UnitUID			bigint			-- 캐릭터UID
,	@SystemKey			bigint			-- mac address
,	@LagType			int				-- 랙 구간
,	@PartyType			int				-- 파티 타입(0: 파티없음, 1: 파티장, 2: 파티원, 3: 관람자 )
,	@PartyUserNum		int				-- 파티원 수
,	@MapID				int				-- 필드맵 ID
,	@FieldUserNum		int				-- 필드에 있는 유저 수
,	@LagTime			float			-- 랙 시간
,	@PlayTime			float			-- 플레이 시간
,	@LagTotalNum		float			-- 랙 횟수
,	@LagTotalTime		float			-- 랙 총 시간

AS
	SET NOCOUNT ON;
	
	DECLARE @Result			int

	BEGIN TRY
		BEGIN TRAN
			
			INSERT INTO dbo.LClientPerformance_Field_UnknownLagInfo ( UnitUID, SystemKey, LagType, PartyType, PartyUserNum, MapID, FieldUserNum, LagTime, PlayTime, LagTotalNum, LagTotalTime, RegDate )
			VALUES ( @UnitUID, @SystemKey, @LagType, @PartyType, @PartyUserNum, @MapID, @FieldUserNum, @LagTime, @PlayTime, @LagTotalNum, @LagTotalTime, GETDATE() )
	
		COMMIT TRAN
		
		SET @Result = 0
		
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

		IF @Result = 0 OR @Result IS NULL
			SET @Result = -1
	END CATCH

	SELECT ISNULL(@Result, 0) AS Result
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.03.20
-- Description:	필드 성능 측정 - 알려진 랙 관련 측정
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LClientPerformance_Field_knownLagInfo_INS]
	@UnitUID			bigint			-- 캐릭터UID
,	@SystemKey			bigint			-- mac address
,	@LagType			int				-- 랙 구간
,	@PartyType			int				-- 파티 타입(0: 파티없음, 1: 파티장, 2: 파티원, 3: 관람자 )
,	@PartyUserNum		int				-- 파티원 수
,	@MapID				int				-- 필드맵 ID
,	@VillageUserNum		int				-- 필드 있는 유저 수
,	@LagTime			float			-- 랙 시간
,	@PlayTime			float			-- 플레이 시간
,	@LagTotalNum		float			-- 랙 횟수
,	@LagTotalTime		float			-- 랙 총 시간

AS
	SET NOCOUNT ON;
	
	DECLARE @Result			int

	BEGIN TRY
		BEGIN TRAN
			
			INSERT INTO dbo.LClientPerformance_Field_knownLagInfo ( UnitUID, SystemKey, LagType, PartyType, PartyUserNum, MapID, VillageUserNum, LagTime, PlayTime, LagTotalNum, LagTotalTime, RegDate )
			VALUES ( @UnitUID, @SystemKey, @LagType, @PartyType, @PartyUserNum, @MapID, @VillageUserNum, @LagTime, @PlayTime, @LagTotalNum, @LagTotalTime, GETDATE() )
	
		COMMIT TRAN
		
		SET @Result = 0
		
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

		IF @Result = 0 OR @Result IS NULL
			SET @Result = -1
	END CATCH

	SELECT ISNULL(@Result, 0) AS Result
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.03.20
-- Description:	필드 성능 측정 - 평균프레임, UDP, TCP, 메모리
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LClientPerformance_Field_FieldInfo_INS]
	@UnitUID					bigint			-- 캐릭터UID
,	@SystemKey					bigint			-- mac address

,	@AvgFrame					float			-- 평균프레임
,	@AvgFrame_StdDev			float			-- 평균프레임에 대한 표준편차

,	@P2PMinPingTime				float			-- P2P 최소 ping time
,	@P2PMaxPingTime				float			-- P2P 최대 ping time
,	@P2PAvgPingTime				float			-- P2P 평균 ping time
,	@P2PAvgPingTime_StdDev		float			-- P2P 평균 ping time에 대한 표준편차
,	@P2PAvgPingLossRate			float			-- P2P 평균 ping loss rate

,	@RelayMinPingTime			float			-- Relay 최소 ping time
,	@RelayMaxPingTime			float			-- Relay 최대 ping time
,	@RelayAvgPingTime			float			-- Relay 평균 ping time
,	@RelayAvgPingTime_StdDev	float			-- Relay 평균 ping time에 대한 표준편차
,	@RelayAvgPingLossRate		float			-- Relay 평균 ping loss rate

-- 2013.07.08 추가 ----------------------------------------------------------------------------
,	@UDPMinPingTime				float			-- UDP 최소 ping time
,	@UDPMaxPingTime				float			-- UDP 최대 ping time
,	@UDPAvgPingTime				float			-- UDP 평균 ping time
,	@UDPAvgPingTime_StdDev		float			-- UDP 평균 ping time에 대한 표준편차
,	@UDPAvgPingLossRate			float			-- UDP 평균 ping time에 대한 표준편차
-----------------------------------------------------------------------------------------------

,	@TCPMinPingTime				float			-- TCP 최소 ping time
,	@TCPMaxPingTime				float			-- TCP 최대 ping time
,	@TCPAvgPingTime				float			-- TCP 평균 ping time
,	@TCPAvgPingTime_StdDev		float			-- TCP 평균 ping time에 대한 표준편차

,	@UDPSendCountPerSecHost		float			-- 초당 UDP Send 개수(Host 일경우)
,	@UDPSendAmountPerSecHost	float			-- 초당 UDP Send 양(Host 일경우)
,	@UDPRecvCountPerSecHost		float			-- 초당 UDP Recv 개수(Host 일경우)
,	@UDPRecvAmountPerSecHost	float			-- 초당 UDP Recv 양(Host 일경우)

,	@UDPSendCountPerSec			float			-- 초당 UDP Send 개수(Host 아닐경우)
,	@UDPSendAmountPerSec		float			-- 초당 UDP Send 양(Host 아닐경우)
,	@UDPRecvCountPerSec			float			-- 초당 UDP Recv 개수(Host 아닐경우)
,	@UDPRecvAmountPerSec		float			-- 초당 UDP Recv 양(Host 아닐경우)

,	@UDPUserSyncPacketLossRate	float			-- UDP UserSyncPacket에 대한 loss rate
,	@UDPNPCSyncPacketLossRate	float			-- UDP NpcSyncPacket에 대한 loss rate

-- 2013.08.09 추가 ----------------------------------------------------------------------------
,	@NPCReactionHostUpdAvgPingTime		float	-- 비호스트 NPC 리액션 측정시 Host UDP 평균 ping time
-----------------------------------------------------------------------------------------------

-- 2013.07.08 추가 ----------------------------------------------------------------------------
,	@NPCReactionMinDelayTimeSimulOff	float	-- 비호스트 NPC 리액션 최소 delay time(Simul 안 할 경우)
,	@NPCReactionMaxDelayTimeSimulOff	float	-- 비호스트 NPC 리액션 최대 delay time(Simul 안 할 경우)
,	@NPCReactionAvgDelayTimeSimulOff	float	-- 비호스트 NPC 리액션 평균 delay time(Simul 안 할 경우)
,	@NPCReactionAvgStdDevDelayTimeSimulOff	float	-- 비호스트 NPC 리액션 평균 delay time에 대한 표준편차(Simul 안 할 경우)
,	@NPCReactionMinDelayTimeSimulOn		float	-- 비호스트 NPC 리액션 최소 delay time(Simul 할 경우)
,	@NPCReactionMaxDelayTimeSimulOn		float	-- 비호스트 NPC 리액션 최대 delay time(Simul 할 경우)
,	@NPCReactionAvgDelayTimeSimulOn		float	-- 비호스트 NPC 리액션 평균 delay time(Simul 할 경우)
,	@NPCReactionAvgStdDevDelayTimeSimulOn	float	-- 비호스트 NPC 리액션 평균 delay time에 대한 표준편차(Simul 할 경우)
-----------------------------------------------------------------------------------------------

,	@FirstMemUsageCheck			bit				-- 클라구동후 최초로 던전에서 메모리 사용량 측정했는지 여부
,	@MinWorkingSetSize			float			-- 최소 workingset 크기(MB단위)
,	@MaxWorkingSetSize			float			-- 최대 workingset 크기(MB단위)
,	@MinPagefileUsage			float			-- 최소 pagefile 사용량(MB단위)
,	@MaxPagefileUsage			float			-- 최대 pagefile 사용량(MB단위)

,	@PartyType					int				-- 파티 타입(0: 파티없음, 1: 파티장, 2: 파티원, 3: 관람자 )
,	@PartyUserNum				int				-- 파티원수(자신을 뺀 수)
,	@MapID						int				-- 던전맵 ID
,	@FieldUserNum				int				-- 필드에 있는 유저 수(필드 나오기 직전의 유저 수)

AS
	SET NOCOUNT ON;
	
	DECLARE @Result			int

	BEGIN TRY
		BEGIN TRAN
			
			INSERT INTO dbo.LClientPerformance_Field_FieldInfo ( 
					UnitUID, SystemKey, 
					AvgFrame, AvgFrame_StdDev,
					P2PMinPingTime, P2PMaxPingTime, P2PAvgPingTime, P2PAvgPingTime_StdDev, P2PAvgPingLossRate,
					RelayMinPingTime, RelayMaxPingTime, RelayAvgPingTime, RelayAvgPingTime_StdDev, RelayAvgPingLossRate, 
					TCPMinPingTime, TCPMaxPingTime, TCPAvgPingTime, TCPAvgPingTime_StdDev, 
					UDPMinPingTime, UDPMaxPingTime, UDPAvgPingTime, UDPAvgPingTime_StdDev, UDPAvgPingLossRate, 
					UDPSendCountPerSecHost, UDPSendAmountPerSecHost, UDPRecvCountPerSecHost, UDPRecvAmountPerSecHost,
					UDPSendCountPerSec, UDPSendAmountPerSec, UDPRecvCountPerSec, UDPRecvAmountPerSec,
					UDPUserSyncPacketLossRate, UDPNPCSyncPacketLossRate, NPCReactionHostUpdAvgPingTime,
					NPCReactionMinDelayTimeSimulOff, NPCReactionMaxDelayTimeSimulOff, NPCReactionAvgDelayTimeSimulOff, NPCReactionAvgStdDevDelayTimeSimulOff,
					NPCReactionMinDelayTimeSimulOn, NPCReactionMaxDelayTimeSimulOn, NPCReactionAvgDelayTimeSimulOn, NPCReactionAvgStdDevDelayTimeSimulOn,
					FirstMemUsageCheck, MinWorkingSetSize, MaxWorkingSetSize, MinPagefileUsage, MaxPagefileUsage, 
					PartyType, PartyUserNum, MapID, FieldUserNum, RegDate 
					)
			VALUES ( 
					@UnitUID, @SystemKey, 
					@AvgFrame, @AvgFrame_StdDev, 
					@P2PMinPingTime, @P2PMaxPingTime, @P2PAvgPingTime, @P2PAvgPingTime_StdDev, @P2PAvgPingLossRate, 
					@RelayMinPingTime, @RelayMaxPingTime, @RelayAvgPingTime, @RelayAvgPingTime_StdDev, @RelayAvgPingLossRate, 
					@TCPMinPingTime, @TCPMaxPingTime, @TCPAvgPingTime, @TCPAvgPingTime_StdDev, 
					@UDPMinPingTime, @UDPMaxPingTime, @UDPAvgPingTime, @UDPAvgPingTime_StdDev, @UDPAvgPingLossRate,
					@UDPSendCountPerSecHost, @UDPSendAmountPerSecHost, @UDPRecvCountPerSecHost, @UDPRecvAmountPerSecHost,
					@UDPSendCountPerSec, @UDPSendAmountPerSec, @UDPRecvCountPerSec, @UDPRecvAmountPerSec,
					@UDPUserSyncPacketLossRate, @UDPNPCSyncPacketLossRate, @NPCReactionHostUpdAvgPingTime,
					@NPCReactionMinDelayTimeSimulOff, @NPCReactionMaxDelayTimeSimulOff, @NPCReactionAvgDelayTimeSimulOff, @NPCReactionAvgStdDevDelayTimeSimulOff,
					@NPCReactionMinDelayTimeSimulOn, @NPCReactionMaxDelayTimeSimulOn, @NPCReactionAvgDelayTimeSimulOn, @NPCReactionAvgStdDevDelayTimeSimulOn,
					@FirstMemUsageCheck, @MinWorkingSetSize, @MaxWorkingSetSize, @MinPagefileUsage, @MaxPagefileUsage, 
					@PartyType, @PartyUserNum, @MapID, @FieldUserNum, GETDATE() 
					)

		COMMIT TRAN
		
		SET @Result = 0
		
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

		IF @Result = 0 OR @Result IS NULL
			SET @Result = -1
	END CATCH

	SELECT ISNULL(@Result, 0) AS Result
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.03.20
-- Description:	던전 성능 측정 - 알려지지 않은 랙 관련 측정
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LClientPerformance_Dungeon_UnknownLagInfo_INS]
	@UnitUID			bigint			-- 캐릭터UID
,	@SystemKey			bigint			-- mac address
,	@LagType			int				-- 랙 구간
,	@PartyType			int				-- 파티 타입(0: 파티없음, 1: 파티장, 2: 파티원, 3: 관람자 )
,	@PartyUserNum		int				-- 파티원 수
,	@MapID				int				-- 필드맵 ID
,	@Difficulty			int				-- 던전 난이도
,	@LastStage			int				-- 마지막까지 플레이 했던 stage 번호
,	@LastBlock			int				-- 마지막까지 플레이 했던 block 번호
,	@LagTime			float			-- 랙 시간
,	@PlayTime			float			-- 플레이 시간
,	@LagTotalNum		float			-- 랙 횟수
,	@LagTotalTime		float			-- 랙 총 시간

AS
	SET NOCOUNT ON;
	
	DECLARE @Result			int

	BEGIN TRY
		BEGIN TRAN
			
			INSERT INTO dbo.LClientPerformance_Dungeon_UnknownLagInfo ( UnitUID, SystemKey, LagType, PartyType, PartyUserNum, MapID, Difficulty
				   , LastStage, LastBlock, LagTime, PlayTime, LagTotalNum, LagTotalTime, RegDate )
			VALUES ( @UnitUID, @SystemKey, @LagType, @PartyType, @PartyUserNum, @MapID, @Difficulty, @LastStage, @LastBlock, @LagTime, @PlayTime
				   , @LagTotalNum, @LagTotalTime, GETDATE() )
	
		COMMIT TRAN
		
		SET @Result = 0
		
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

		IF @Result = 0 OR @Result IS NULL
			SET @Result = -1
	END CATCH

	SELECT ISNULL(@Result, 0) AS Result
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.03.20
-- Description:	던전 성능 측정 - 알려진 랙 관련 측정
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LClientPerformance_Dungeon_knownLagInfo_INS]
	@UnitUID			bigint			-- 캐릭터UID
,	@SystemKey			bigint			-- mac address
,	@LagType			int				-- 랙 구간
,	@PartyType			int				-- 파티 타입(0: 파티없음, 1: 파티장, 2: 파티원, 3: 관람자 )
,	@PartyUserNum		int				-- 파티원 수
,	@MapID				int				-- 필드맵 ID
,	@Difficulty			int				-- 던전 난이도
,	@LastStage			int				-- 마지막까지 플레이 했던 stage 번호
,	@LastBlock			int				-- 마지막까지 플레이 했던 block 번호
,	@LagTime			float			-- 랙 시간
,	@PlayTime			float			-- 플레이 시간
,	@LagTotalNum		float			-- 랙 횟수
,	@LagTotalTime		float			-- 랙 총 시간

AS
	SET NOCOUNT ON;
	
	DECLARE @Result			int

	BEGIN TRY
		BEGIN TRAN
			
			INSERT INTO dbo.LClientPerformance_Dungeon_knownLagInfo ( UnitUID, SystemKey, LagType, PartyType, PartyUserNum, MapID, Difficulty
				   , LastStage, LastBlock, LagTime, PlayTime, LagTotalNum, LagTotalTime, RegDate )
			VALUES ( @UnitUID, @SystemKey, @LagType, @PartyType, @PartyUserNum, @MapID, @Difficulty, @LastStage, @LastBlock, @LagTime, @PlayTime
				   , @LagTotalNum, @LagTotalTime, GETDATE() )
	
		COMMIT TRAN
		
		SET @Result = 0
		
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

		IF @Result = 0 OR @Result IS NULL
			SET @Result = -1
	END CATCH

	SELECT ISNULL(@Result, 0) AS Result
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.03.20
-- Description:	던전 성능 측정 - 평균프레임, UDP, TCP, 메모리
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LClientPerformance_Dungeon_DungeonInfo_INS]
	@UnitUID					bigint			-- 캐릭터UID
,	@SystemKey					bigint			-- mac address

,	@AvgFrame					float			-- 평균프레임
,	@AvgFrame_StdDev			float			-- 평균프레임에 대한 표준편차

,	@P2PMinPingTime				float			-- P2P 최소 ping time
,	@P2PMaxPingTime				float			-- P2P 최대 ping time
,	@P2PAvgPingTime				float			-- P2P 평균 ping time
,	@P2PAvgPingTime_StdDev		float			-- P2P 평균 ping time에 대한 표준편차
,	@P2PAvgPingLossRate			float			-- P2P 평균 ping loss rate

,	@RelayMinPingTime			float			-- Relay 최소 ping time
,	@RelayMaxPingTime			float			-- Relay 최대 ping time
,	@RelayAvgPingTime			float			-- Relay 평균 ping time
,	@RelayAvgPingTime_StdDev	float			-- Relay 평균 ping time에 대한 표준편차
,	@RelayAvgPingLossRate		float			-- Relay 평균 ping loss rate

-- 2013.07.08 추가 ----------------------------------------------------------------------------
,	@UDPMinPingTime				float			-- UDP 최소 ping time
,	@UDPMaxPingTime				float			-- UDP 최대 ping time
,	@UDPAvgPingTime				float			-- UDP 평균 ping time
,	@UDPAvgPingTime_StdDev		float			-- UDP 평균 ping time에 대한 표준편차
,	@UDPAvgPingLossRate			float			-- UDP 평균 ping time에 대한 표준편차
-----------------------------------------------------------------------------------------------

,	@TCPMinPingTime				float			-- TCP 최소 ping time
,	@TCPMaxPingTime				float			-- TCP 최대 ping time
,	@TCPAvgPingTime				float			-- TCP 평균 ping time
,	@TCPAvgPingTime_StdDev		float			-- TCP 평균 ping time에 대한 표준편차

,	@UDPSendCountPerSecHost		float			-- 초당 UDP Send 개수(Host 일경우)
,	@UDPSendAmountPerSecHost	float			-- 초당 UDP Send 양(Host 일경우)
,	@UDPRecvCountPerSecHost		float			-- 초당 UDP Recv 개수(Host 일경우)
,	@UDPRecvAmountPerSecHost	float			-- 초당 UDP Recv 양(Host 일경우)

,	@UDPSendCountPerSec			float			-- 초당 UDP Send 개수(Host 아닐경우)
,	@UDPSendAmountPerSec		float			-- 초당 UDP Send 양(Host 아닐경우)
,	@UDPRecvCountPerSec			float			-- 초당 UDP Recv 개수(Host 아닐경우)
,	@UDPRecvAmountPerSec		float			-- 초당 UDP Recv 양(Host 아닐경우)

,	@UDPUserSyncPacketLossRate	float			-- UDP UserSyncPacket에 대한 loss rate
,	@UDPNPCSyncPacketLossRate	float			-- UDP NpcSyncPacket에 대한 loss rate

-- 2013.08.09 추가 ----------------------------------------------------------------------------
,	@NPCReactionHostUpdAvgPingTime		float	-- 비호스트 NPC 리액션 측정시 Host UDP 평균 ping time
-----------------------------------------------------------------------------------------------

-- 2013.07.08 추가 ----------------------------------------------------------------------------
,	@NPCReactionMinDelayTimeSimulOff	float	-- 비호스트 NPC 리액션 최소 delay time(Simul 안 할 경우)
,	@NPCReactionMaxDelayTimeSimulOff	float	-- 비호스트 NPC 리액션 최대 delay time(Simul 안 할 경우)
,	@NPCReactionAvgDelayTimeSimulOff	float	-- 비호스트 NPC 리액션 평균 delay time(Simul 안 할 경우)
,	@NPCReactionAvgStdDevDelayTimeSimulOff	float	-- 비호스트 NPC 리액션 평균 delay time에 대한 표준편차(Simul 안 할 경우)
,	@NPCReactionMinDelayTimeSimulOn		float	-- 비호스트 NPC 리액션 최소 delay time(Simul 할 경우)
,	@NPCReactionMaxDelayTimeSimulOn		float	-- 비호스트 NPC 리액션 최대 delay time(Simul 할 경우)
,	@NPCReactionAvgDelayTimeSimulOn		float	-- 비호스트 NPC 리액션 평균 delay time(Simul 할 경우)
,	@NPCReactionAvgStdDevDelayTimeSimulOn	float	-- 비호스트 NPC 리액션 평균 delay time에 대한 표준편차(Simul 할 경우)
-----------------------------------------------------------------------------------------------

,	@FirstMemUsageCheck			bit				-- 클라구동후 최초로 던전에서 메모리 사용량 측정했는지 여부
,	@MinWorkingSetSize			float			-- 최소 workingset 크기(MB단위)
,	@MaxWorkingSetSize			float			-- 최대 workingset 크기(MB단위)
,	@MinPagefileUsage			float			-- 최소 pagefile 사용량(MB단위)
,	@MaxPagefileUsage			float			-- 최대 pagefile 사용량(MB단위)

,	@PartyType					int				-- 파티 타입(0: 파티없음, 1: 파티장, 2: 파티원, 3: 관람자 )
,	@PartyUserNum				int				-- 파티원수(자신을 뺀 수)
,	@MapID						int				-- 던전맵 ID
,	@Difficulty					int				-- 던전 난이도
,	@EscapeCheck				bit				-- 던전플레이 도중에 빠져나왔는지 여부
,	@LastStage					int				-- 마지막까지 플레이 했던 stage 번호
,	@LastBlock					int				-- 마지막까지 플레이 했던 block 번호

AS
	SET NOCOUNT ON;
	
	DECLARE @Result			int

	BEGIN TRY
		BEGIN TRAN
			
			INSERT INTO dbo.LClientPerformance_Dungeon_DungeonInfo ( 
					UnitUID, SystemKey, 
					AvgFrame, AvgFrame_StdDev,
					P2PMinPingTime, P2PMaxPingTime, P2PAvgPingTime, P2PAvgPingTime_StdDev, P2PAvgPingLossRate,
					RelayMinPingTime, RelayMaxPingTime, RelayAvgPingTime, RelayAvgPingTime_StdDev, RelayAvgPingLossRate, 
					TCPMinPingTime, TCPMaxPingTime, TCPAvgPingTime, TCPAvgPingTime_StdDev, 
					UDPMinPingTime, UDPMaxPingTime, UDPAvgPingTime, UDPAvgPingTime_StdDev, UDPAvgPingLossRate, 
					UDPSendCountPerSecHost, UDPSendAmountPerSecHost, UDPRecvCountPerSecHost, UDPRecvAmountPerSecHost,
					UDPSendCountPerSec, UDPSendAmountPerSec, UDPRecvCountPerSec, UDPRecvAmountPerSec,
					UDPUserSyncPacketLossRate, UDPNPCSyncPacketLossRate, NPCReactionHostUpdAvgPingTime,
					NPCReactionMinDelayTimeSimulOff, NPCReactionMaxDelayTimeSimulOff, NPCReactionAvgDelayTimeSimulOff, NPCReactionAvgStdDevDelayTimeSimulOff,
					NPCReactionMinDelayTimeSimulOn, NPCReactionMaxDelayTimeSimulOn, NPCReactionAvgDelayTimeSimulOn, NPCReactionAvgStdDevDelayTimeSimulOn,
					FirstMemUsageCheck, MinWorkingSetSize, MaxWorkingSetSize, MinPagefileUsage, MaxPagefileUsage, 
					PartyType, PartyUserNum, MapID, Difficulty, EscapeCheck, LastStage, LastBlock, RegDate )
			VALUES ( 
					@UnitUID, @SystemKey, @AvgFrame, @AvgFrame_StdDev,
					@P2PMinPingTime, @P2PMaxPingTime, @P2PAvgPingTime, @P2PAvgPingTime_StdDev, @P2PAvgPingLossRate, 
					@RelayMinPingTime, @RelayMaxPingTime, @RelayAvgPingTime, @RelayAvgPingTime_StdDev, @RelayAvgPingLossRate, 
					@TCPMinPingTime, @TCPMaxPingTime, @TCPAvgPingTime, @TCPAvgPingTime_StdDev, 
					@UDPMinPingTime, @UDPMaxPingTime, @UDPAvgPingTime, @UDPAvgPingTime_StdDev, @UDPAvgPingLossRate,
					@UDPSendCountPerSecHost, @UDPSendAmountPerSecHost, @UDPRecvCountPerSecHost, @UDPRecvAmountPerSecHost,
					@UDPSendCountPerSec, @UDPSendAmountPerSec, @UDPRecvCountPerSec, @UDPRecvAmountPerSec,
					@UDPUserSyncPacketLossRate, @UDPNPCSyncPacketLossRate, @NPCReactionHostUpdAvgPingTime,
					@NPCReactionMinDelayTimeSimulOff, @NPCReactionMaxDelayTimeSimulOff, @NPCReactionAvgDelayTimeSimulOff, @NPCReactionAvgStdDevDelayTimeSimulOff,
					@NPCReactionMinDelayTimeSimulOn, @NPCReactionMaxDelayTimeSimulOn, @NPCReactionAvgDelayTimeSimulOn, @NPCReactionAvgStdDevDelayTimeSimulOn,
					@FirstMemUsageCheck, @MinWorkingSetSize, @MaxWorkingSetSize, @MinPagefileUsage, @MaxPagefileUsage, 
					@PartyType, @PartyUserNum, @MapID, @Difficulty, @EscapeCheck, @LastStage, @LastBlock, GETDATE() 
					)

		COMMIT TRAN
		
		SET @Result = 0
		
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

		IF @Result = 0 OR @Result IS NULL
			SET @Result = -1
	END CATCH

	SELECT ISNULL(@Result, 0) AS Result
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 캐릭터 레벨업 기록을 남긴다.
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LCharLvUp_SET]
@iServerSetID	TINYINT,	
@iCharUID_  bigint,
@iLvBefore_ tinyint,
@iLvAfter_  tinyint
AS
SET NOCOUNT ON;

DECLARE @CurDate smalldatetime
SET @CurDate = GetDate()

BEGIN TRAN 

-- 가장 처음 레벨 ( 1 ) 이라면 캐릭터 생성 시점이다. 시작시간만을 기록한다.
IF @iLvBefore_ = 1 AND @iLvAfter_ = 1
BEGIN
    INSERT INTO LCharLvUp(ServerSetID, CharUID, Level, Start, Finish )
        VALUES(@iServerSetID, @iCharUID_, 1, GETDATE(), '2079-1-1' )

    IF @@ERROR <> 0
    BEGIN
        RAISERROR( '캐릭터 생성시점 시각 기록 실패', 16, 1, @iLvBefore_ )
        GOTO FAIL_PROC
    END
    ELSE 
    BEGIN
        COMMIT TRAN
        RETURN -- 초기 시작 시간만 기록하고 나면 바로 리턴.
    END    
END

-- 이전 레벨의 완료시점을 기록한다. (이젠 레벨 기록이 없다면 업데이트 안하고 그냥 다음으로 흘러감)
UPDATE LCharLvUp SET Finish = @CurDate WHERE CharUID = @iCharUID_ AND Level = @iLvBefore_
IF @@ERROR <> 0
BEGIN
    RAISERROR( '기존 레벨 완료시점 업데이트 오류. LvBefore:%d', 16, 1, @iLvBefore_ )
    GOTO FAIL_PROC
END

-- 레벨이 2계단 이상 상승했다면 중간에 건너뛴 레벨에 대한 기록도 남겨 주도록 한다.
IF @iLvAfter_ - @iLvBefore_ >= 2 
BEGIN
    DECLARE @iLv int
    SET @iLv = @iLvBefore_ + 1
    WHILE @iLv < @iLvAfter_
    BEGIN
        INSERT INTO LCharLvUp(ServerSetID, CharUID, Level, Start, Finish )
            VALUES(@iServerSetID, @iCharUID_, @iLv, @CurDate, @CurDate )
        IF @@ERROR <> 0
        BEGIN
            RAISERROR( '중간에 건너뛴 레벨들 기록 실패. LvBefore:%d, LvAfter:%d', 16, 1, @iLvBefore_, @iLvAfter_ )
            GOTO FAIL_PROC
        END
        SET @iLv = @iLv + 1
    END
END

-- 현재 레벨의 시작시점을 기록한다.
INSERT INTO LCharLvUp(ServerSetID, CharUID, Level, Start, Finish ) VALUES(@iServerSetID, @iCharUID_, @iLvAfter_, @CurDate, '2079-1-1' )
IF @@ERROR <> 0
BEGIN
    RAISERROR( '레벨업 기록 실패. LvBefore:%d, LvAfter:%d', 16, 1, @iLvBefore_, @iLvAfter_ )
    GOTO FAIL_PROC
END

COMMIT TRAN
RETURN

FAIL_PROC:
ROLLBACK TRAN
GO
-- =============================================
-- Author:		YJ
-- Create date: 2011. 11. 21
-- Description:	대만 캐쉬 충전(변환) 아이템 로그
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LChargeCashITem_INS]
	@iServerSetID	tinyint,
    @iUnitUID       [bigint],
	@iItemUID       [bigint],    
	@iItemID        [int],
    @iChargePoint   [bigint],	
	@iAfterPoint    [bigint],
	@iReturn		[tinyint]	
AS

SET NOCOUNT ON;

DECLARE @Result int
,		@ErrScript nvarchar(MAX)		

SET @Result = -1

SET @ErrScript = N'dbo.P_LChargeCashITem_INS ' 
	+ CAST(@iUnitUID AS nvarchar(50)) + ', '
	+ CAST(@iItemUID AS nvarchar(50)) + ', '
	+ CAST(@iItemID AS nvarchar(50)) + ', '
	+ CAST(@iChargePoint AS nvarchar(50)) + ', '
	+ CAST(@iAfterPoint AS nvarchar(50)) + ', '
	+ CAST(@iReturn AS nvarchar(50)) + ', '

BEGIN TRY

	BEGIN TRAN
		
		SET @Result = 0
		
		INSERT INTO LChargeCashItem(UnitUID, ItemUID, ItemID, ChargePoint, AfterPoint, sResult)
			SELECT @iUnitUID, @iItemUID, @iItemID, @iChargePoint, @iAfterPoint, @iReturn

	    
	COMMIT TRAN
	
	GOTO END_PROC
	
END TRY

BEGIN CATCH

	SELECT ERROR_NUMBER() AS ErrorNumber
	ROLLBACK TRAN
	
	GOTO END_PROC

END CATCH

END_PROC:
SELECT @Result
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LCharacterLog_INS]
	@iServerSetID	TINYINT,
	@sdtRegDate		SMALLDATETIME,
	@iUnitUID		BIGINT,
	@strNickName	NVARCHAR(16),
	@bOnlyOne		BIT,
	@iServerUID		INT,
	@iEventType		SMALLINT,
	@iLV			TINYINT,
	@iUnitClass		TINYINT,
	@iClearDungeon	INT,
	@iDungeon_PT	INT,
	@iPVP_PT		INT,
	@iDT			INT,
	@iUserUID		BIGINT,
	@sdtUnitRegdate SMALLDATETIME,
	@sdtUserRegdate	SMALLDATETIME,
	@iProductNo		INT,
	@iOK			INT = 0
	
AS
SET NOCOUNT ON;

BEGIN TRAN

	INSERT INTO dbo.LCharacterLog (RegDate, ServerSetID, UnitUID, NickName, OnlyOne, ServerUID, EventType, LV, UnitClass, ClearDungeon, 
				Dungeon_PT, PVP_PT, DT, UserUID, UnitRegDate, UserRegDate, ProductNo)
	    SELECT @sdtRegDate, @iServerSetID, @iUnitUID, @strNickName, @bOnlyOne, @iServerUID, @iEventType, @iLV, @iUnitClass, @iClearDungeon, 
				@iDungeon_PT, @iPVP_PT, @iDT, @iUserUID, @sdtUnitRegdate, @sdtUserRegdate, @iProductNo
			   
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -100	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 채널 보상 정보를 조회한다.
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LChannelReward_SEL]
	@iServerSetID	TINYINT	
,	@iChannelID	INT
AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

SELECT	ChannelID
,		StartLv
,		EndLv
,		PerEXP
,		PerED
	FROM dbo.LChannelReward WITH (NOLOCK)
		WHERE ChannelID = @iChannelID
			OPTION (MAXDOP 1)
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 채널 목록을 조회한다.
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LChannelList_SEL]
	@iServerSetID	int
AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

SELECT  [UID]
,		ChannelID
,       ChannelName
,       ServerSetID
,       IP
,       Port1
,       Port2
,       MaxConcurrentUser
,       ConcurrentUser
,		MakePartyCNT		
,		PlayPartyCNT
    FROM dbo.LChannelList WITH (NOLOCK)
		WHERE ServerSetID = @iServerSetID
			AND OnOff = 1
	ORDER BY ChannelID
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 서버 고유번호로 채널 목록을 조회한다.
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LChannelList_By_ServerUID_SEL]
	@iServerSetID	TINYINT	
,	@iServerUID		INT
AS
SET NOCOUNT ON;

SELECT ChannelID
	FROM dbo.LChannelList WITH (NOLOCK)
		WHERE [UID] = @iServerUID
GO
CREATE OR ALTER PROCEDURE [dbo].[P_LCenterProxy_SEL]
	@iServerGroupID		TINYINT

AS
SET NOCOUNT ON;

SELECT A.ProxyID, B.IP, B.Port1 
FROM dbo.LCenterProxy AS A WITH (NOLOCK)
JOIN dbo.LServerList AS B WITH (NOLOCK)
ON A.ServerSetID = B.ServerSetID AND A.ServerUID = B.UID
WHERE A.ServerSetID = @iServerGroupID 
ORDER BY A.ProxyID ASC
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 서버 고유번호로 센터서버 프록시 아이디를 조회한다.
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LCenterProxy_By_ServerUID_SEL]
	@iServerSetID	TINYINT	
,	@iServerUID		INT

AS
SET NOCOUNT ON;

SELECT ProxyID
	FROM dbo.LCenterProxy WITH (NOLOCK)
		WHERE ServerUID = @iServerUID
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LCenterProxy_By_ServerSetID_SEL]
	@iServerSetID		TINYINT
AS
SET NOCOUNT ON;

	SELECT A.ProxyID, B.PrivateIP, B.Port1 
	FROM dbo.LCenterProxy AS A WITH (NOLOCK)
	JOIN dbo.LServerList AS B WITH (NOLOCK)
		ON A.ServerSetID = B.ServerSetID AND A.ServerUID = B.UID
	WHERE A.ServerSetID = @iServerSetID 
	ORDER BY A.ProxyID ASC
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LCashSalesLog_INS]
	@iServerSetID	TINYINT,
	@iUserUID		bigint,
	@iUnitUID		bigint,
	@iUnitClass		TINYINT,
	@iLevel			TINYINT,
	@iProductNo		INT,
	@iBuyQuantity	int,
	@iTotalPrice	int,
	@sdtRegDate		SMALLDATETIME,
	@bFirstBuy		BIT,
	@iBuyType		TINYINT,
	@strUserID		NVARCHAR(24),
	@iOK			INT = 0
	
AS
SET NOCOUNT ON;


BEGIN TRAN

	INSERT INTO dbo.LCashSalesLog (UserUID, UnitUID, UnitClass, [Level], ProductNo, BuyQuantity, TotalPrice, RegDate, FirstBuy, BuyType, OrderID)
	    SELECT  @iUserUID, @iUnitUID, @iUnitClass, @iLevel, @iProductNo, @iBuyQuantity, @iTotalPrice, @sdtRegDate, @bFirstBuy, @iBuyType, @strUserID
			   
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
-- =============================================
-- Author: 
-- Create date: 
-- Description: ArenaUID를 갱신하고 갱신된 값을 조회한다
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LArenaUIDCreate_SEL]
	@iServerSetID	TINYINT,
	@iOK [int] = 0
	
AS
SET NOCOUNT ON;

DECLARE @iArenaUID BIGINT

BEGIN TRAN

	UPDATE dbo.LArenaUIDCreate
		SET ArenaUID = ArenaUID + 1
			where [type] = 1
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END

	SELECT @iArenaUID = ArenaUID
		FROM dbo.LArenaUIDCreate WITH (NOLOCK)
		
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK, @iArenaUID
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 공식대전에서 획득한 APoint를 아이템 구매에 사용한 로그 기록
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LApointLog_INT]
	@iServerSetID		TINYINT
,	@UnitUID	bigint
,	@ItemID		int
,	@Quantity	int
,	@BeforeAP	int
,	@AfterAP	int
,	@RegDate	smalldatetime
AS
	SET NOCOUNT ON

	DECLARE @Result		int

	BEGIN TRY
		BEGIN TRAN

		INSERT INTO	dbo.LApointLog ( UnitUID, ItemID, Quantity, BeforeAP, AfterAP, RegDate )
		VALUES ( @UnitUID, @ItemID, @Quantity, @BeforeAP, @AfterAP,@RegDate  )

		COMMIT TRAN

		SET @Result = 0
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

		SET @Result = -1
	END CATCH

	SELECT @Result
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 공식대전에서 획득한 APoint를 아이템 구매에 사용한 로그 기록
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LApointLog_INS]
	@iServerSetID		TINYINT
,	@UnitUID	bigint
,	@ItemID		int
,	@Quantity	int
,	@BeforeAP	int
,	@AfterAP	int
,	@RegDate	smalldatetime
AS
	SET NOCOUNT ON

	DECLARE @Result		int

	BEGIN TRY
		BEGIN TRAN

		INSERT INTO	dbo.LApointLog ( UnitUID, ItemID, Quantity, BeforeAP, AfterAP, RegDate )
		VALUES ( @UnitUID, @ItemID, @Quantity, @BeforeAP, @AfterAP,@RegDate  )

		COMMIT TRAN

		SET @Result = 0
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

		SET @Result = -1
	END CATCH

	SELECT @Result
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2012-09-05
-- Description:	랜선랙 방지 프로세스 업데이트 이후 어뷰징 로그 기록
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LAccusationLog_INT]
	@iServerSetID		TINYINT
,	@RoomUID			bigint
,	@PVPChannelClass	smallint
,	@MatchType			smallint
,	@UnitUID			bigint
,	@RegDate			smalldatetime
	
AS
	SET NOCOUNT ON;

	DECLARE @Result		int
	
	BEGIN TRY
		BEGIN TRAN
		
		SET @Result = -1

		INSERT INTO	dbo.LAccusationLog ( RoomUID, PVPChannelClass, MatchType, UnitUID, RegDate )
		VALUES ( @RoomUID, @PVPChannelClass, @MatchType, @UnitUID, @RegDate )

		COMMIT TRAN

		SET @Result = 0
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

		SET @Result = -2
	END CATCH

	SELECT @Result
GO
-- =============================================
-- Author:		sutamtwo
-- Create date: 2007년 11월 1일
-- Description: 기타 통계 자료 업데이트
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_FrameRate_SET]
	@iServerSetID		TINYINT
,	@iPlayType		[tinyint]	
,	@iSUnder20		[int]		
,	@iS21_30		[int]		
,	@iS31_40		[int]		
,	@iS41_50		[int]		
,	@iS51_60		[int]		
,	@iS61_70		[int]		
,	@iS71_80		[int]		
,	@iS81_90		[int]		
,	@iSOver90		[int]		
,	@iOK_			[int] = 0
AS 
SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE @TODAY VARCHAR(10)
,		@SumCnt	Float
SELECT @TODAY = CONVERT(VARCHAR(10),GETDATE(),120)

BEGIN TRAN

	IF NOT EXISTS (SELECT * FROM dbo.FrameRate WITH (NOLOCK) WHERE RegDate = @TODAY AND PlayType = @iPlayType )
			BEGIN	-- 해당 날짜 해당 통계가 존재하지만 테이블에 기록되어있지 않다면,
				INSERT INTO dbo.FrameRate (RegDate, PlayType)
					SELECT @TODAY, @iPlayType
				IF @@ERROR <> 0
				BEGIN	SELECT @iOK_ = -101	GOTO FAIL_TRAN	END
			END		-- GUnit에 존재하지만 테이블에 기록되어있지 않다면,                 

	-- 비율 합계 업데이트
	UPDATE dbo.FrameRate WITH (UPDLOCK)
			SET	Under20  = Under20  + @iSUnder20 
,				S21_30   = S21_30   + @iS21_30  
,				S31_40   = S31_40   + @iS31_40  
,				S41_50   = S41_50   + @iS41_50  
,				S51_60   = S51_60   + @iS51_60  
,				S61_70   = S61_70   + @iS61_70  
,				S71_80   = S71_80   + @iS71_80  
,				S81_90   = S81_90   + @iS81_90  
,				Over90   = Over90  + @iSOver90  
			WHERE RegDate = @TODAY AND PlayType = @iPlayType

	IF @@error <> 0
		BEGIN	SELECT @iOK_ = -103	GOTO FAIL_TRAN	END

	-- 총합 및 평균 구하기
	SELECT @SumCnt = (Under20 + S21_30 + S31_40 + S41_50 + S51_60 + S61_70 + S71_80 + S81_90 + Over90)
		FROM dbo.FrameRate WITH (NOLOCK)
			WHERE RegDate = @TODAY AND PlayType = @iPlayType

	UPDATE dbo.FrameRate
		SET	AUnder20	= Under20 / @SumCnt * 100
,			A21_30		= S21_30 / @SumCnt	* 100	
,			A31_40		= S31_40 / @SumCnt  * 100
,			A41_50		= S41_50 / @SumCnt  * 100
,			A51_60		= S51_60 / @SumCnt  * 100	  
,			A61_70		= S61_70 / @SumCnt  * 100	 
,			A71_80		= S71_80 / @SumCnt  * 100	 
,			A81_90		= S81_90 / @SumCnt  * 100
,			AOver90		= Over90 / @SumCnt  * 100
		WHERE RegDate = @TODAY AND PlayType = @iPlayType


COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK_
GO
/*
	2011.05.07
	김병일
	신규 추가
	Mail_FrameRate 관련 SP 통합
*/
CREATE OR ALTER PROCEDURE [dbo].[P_FrameRate_SEL]
	@iServerSetID		tinyint				-- 서버 그룹 추가
,	@regDate			nchar(10)
AS
	SET NOCOUNT ON
	
	SELECT REGDATE, PlayType
	, CASE WHEN TotalCount = 0 THEN 0 ELSE CAST(Under20 * 1.0 / TotalCount * 100.0	AS DECIMAL(5,1)) END	AS '20 Under'
	, CASE WHEN TotalCount = 0 THEN 0 ELSE CAST(S21_30 * 1.0 / TotalCount * 100.0	AS DECIMAL(5,1)) END	AS '21-30'
	, CASE WHEN TotalCount = 0 THEN 0 ELSE CAST(S31_40 * 1.0 / TotalCount * 100.0	AS DECIMAL(5,1)) END	AS '31-40'
	, CASE WHEN TotalCount = 0 THEN 0 ELSE CAST(S41_50 * 1.0 / TotalCount * 100.0	AS DECIMAL(5,1)) END	AS '41-50'
	, CASE WHEN TotalCount = 0 THEN 0 ELSE CAST(S51_60 * 1.0 / TotalCount * 100.0	AS DECIMAL(5,1)) END	AS '51-60'
	, CASE WHEN TotalCount = 0 THEN 0 ELSE CAST(S61_70 * 1.0 / TotalCount * 100.0	AS DECIMAL(5,1)) END	AS '61-70'
	, CASE WHEN TotalCount = 0 THEN 0 ELSE CAST(S71_80 * 1.0 / TotalCount * 100.0	AS DECIMAL(5,1)) END	AS '71-80'
	, CASE WHEN TotalCount = 0 THEN 0 ELSE CAST(S81_90 * 1.0 / TotalCount * 100.0	AS DECIMAL(5,1)) END	AS '81-90'
	, CASE WHEN TotalCount = 0 THEN 0 ELSE CAST(Over90 * 1.0 / TotalCount * 100.0	AS DECIMAL(5,1)) END	AS '90 Over'
	FROM (
		SELECT REGDATE
		, CASE PlayType WHEN 0 THEN N'PvP' WHEN 1 THEN N'Dungeon' WHEN 2 THEN N'Field' END AS PlayType
		, Under20, S21_30, S31_40, S41_50, S51_60, S61_70, S71_80, S81_90, Over90
		, (Under20 + S21_30 + S31_40 + S41_50 + S51_60 + S61_70 + S71_80 + S81_90 + Over90) AS TotalCount
		FROM dbo.FrameRate WITH(NOLOCK)
		WHERE RegDate >= @regDate
			AND ServerSetID = @iServerSetID
	) AS TempTable
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_EventInfo_SEL]
	@iServerSetID	TINYINT	
AS
SET NOCOUNT ON;

DECLARE	@sdtNow smalldatetime
SELECT	@sdtNow = GETDATE()


SELECT EventID,	EventName, EventType, CONVERT(NVARCHAR(19),BeginDate,120) as BeginDate, CONVERT(NVARCHAR(19), EndDate, 120) as EndDate, ScriptID,	OnOff
	FROM dbo.EventInfo WITH (NOLOCK)
		WHERE EndDate >= @sdtNow
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_Event_ServerInfo_SEL]
	@iServerSetID		TINYINT
AS 
SET NOCOUNT ON

	SELECT  ServerGroup, ServerUID
	FROM dbo.Event_ServerInfo WITH(NOLOCK)
GO
CREATE OR ALTER PROCEDURE [dbo].[P_Event_ServerInfo_GET]

AS 
SET NOCOUNT ON

	SELECT  ServerGroup, ServerUID
	FROM dbo.Event_ServerInfo WITH(NOLOCK)
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_Event_RewardRetainUserItem_SEL]
	@iServerSetID		TINYINT
AS 
SET NOCOUNT ON

	SELECT  SlotNo,	ItemID,	Quantity
	FROM dbo.Event_RewardRetainUserItem WITH(NOLOCK)
GO
CREATE OR ALTER PROCEDURE [dbo].[P_Event_RewardRetainUserItem_GET]

AS 
SET NOCOUNT ON

	SELECT  SlotNo,	ItemID,	Quantity
	FROM dbo.Event_RewardRetainUserItem WITH(NOLOCK)
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_Event_RewardLevelUp_SEL]
	@iServerSetID		TINYINT
AS 
SET NOCOUNT ON

	SELECT  Level, RewardID
	FROM dbo.Event_RewardLevelUp WITH(NOLOCK)
GO
CREATE OR ALTER PROCEDURE [dbo].[P_Event_RewardLevelUp_GET]

AS 
SET NOCOUNT ON

	SELECT  Level, RewardID
	FROM dbo.Event_RewardLevelUp WITH(NOLOCK)
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_Event_Reward_SEL]
	@iServerSetID		TINYINT
AS 
SET NOCOUNT ON

	SELECT  RewardID, RewardItemID,	Quantity, Period
	FROM dbo.Event_Reward WITH(NOLOCK)
GO
CREATE OR ALTER PROCEDURE [dbo].[P_Event_Reward_GET]

AS 
SET NOCOUNT ON

	SELECT  RewardID, RewardItemID,	Quantity, Period
	FROM dbo.Event_Reward WITH(NOLOCK)
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_Event_Monster_SEL]
	@iServerSetID		TINYINT
AS 
SET NOCOUNT ON

	SELECT  EventID, MonDropCount, IsBossStage,	MonsterID, AdventRate, DungeonID, NoDungeonID, NoDungeonStage
	FROM dbo.Event_Monster WITH(NOLOCK)
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_Event_Monster_GET]
	@iServerSetID		TINYINT
AS 
SET NOCOUNT ON

	SELECT  EventID, MonDropCount, IsBossStage,	MonsterID, AdventRate, DungeonID, NoDungeonID, NoDungeonStage
	FROM dbo.Event_Monster WITH(NOLOCK)
GO
-- =============================================
-- Author:		sutamtwo
-- Create date: 2009. 05. 25
-- Description: 드랍 아이템 관련 이벤트 리스트 정보 갱신
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_DropEvent_UPD]
	@iServerSetID	TINYINT		
,	@iID			INT
,	@iGetUserUID	BIGINT	
,	@iOK			INT	= 0
AS
SET NOCOUNT ON;
SET XACT_ABORT ON;


IF EXISTS (SELECT GetUserUID FROM dbo.DropEvent WITH (NOLOCK) WHERE GetUserUID = @iGetUserUID)
BEGIN
	BEGIN	SELECT @iOK = -1	GOTO END_PROC	END
END


BEGIN TRAN

	UPDATE dbo.DropEvent
		SET UPDTime		= GETDATE()
		,	Flag		= 1
		,	GetUserUID	= @iGetUserUID
			WHERE ID = @iID

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -2	GOTO FAIL_TRAN	END
		
COMMIT TRAN		
		
		


GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
-- =============================================
-- Author:		sutamtwo
-- Create date: 2009. 05. 25
-- Description: 드랍 아이템 관련 이벤트 리스트 정보 읽기
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_DropEvent_SEL]
	@iServerSetID	TINYINT	
AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

SELECT	ID
,		ItemID
,		DropTime
,		ServerIP
,		Flag
,		IsNotice
    FROM dbo.DropEvent	WITH (NOLOCK)
		ORDER BY ID
GO
-- =============================================
-- Author:		sutamtwo
-- Create date: 2007.11.09
-- Description: 클라이언트에서 치팅코드 사용내역을 기록
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_CheatLog_INS]
	@iServerSetID	TINYINT	
,	@iUserUID_		bigint
,	@iUnitUID_		bigint
,	@iAuthLevel_	tinyint
,	@strCheatCode_	nvarchar(8)
,	@strCheatSTR_	nvarchar(50)
,	@iOK_			int = 0

AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE	@sdtNow	smalldatetime
SELECT	@sdtNow = GetDate()

-- 존재하지 않는 UID면 종료
IF NOT EXISTS (SELECT * FROM [Account].dbo.MUser WITH (NOLOCK) WHERE UserUID = @iUserUID_)
	BEGIN	SELECT @iOK_ = -1	GOTO END_PROC	END


BEGIN TRAN

	INSERT INTO dbo.CheatLog (ServerSetID, UserUID, UnitUID, AuthLevel, CheatCode, CheatSTR, RegDate)
		SELECT @iServerSetID, @iUserUID_, @iUnitUID_, @iAuthLevel_, @strCheatCode_, @strCheatSTR_, @sdtNow
	IF @@ERROR <> 0
		BEGIN	SELECT @iOK_ = -10	GOTO FAIL_TRAN	END


COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK_
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_verify_server_on]
	@iServerType	TINYINT
,	@strServerIP	NVARCHAR(15)

AS
SET NOCOUNT ON;

SELECT [UID], [Name], ServerSetID, ServerType, IP, Port1, Port2, MaxConcurrentUser, ConcurrentUser, [Enable], ServerRollType 
   FROM dbo.LServerList WITH (NOLOCK)
		WHERE ServerType = @iServerType AND IP = @strServerIP
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_verify_server_connect]
	@iServerType	TINYINT
,	@strServerIP	NVARCHAR(15)
,	@iPort1			SMALLINT

AS
SET NOCOUNT ON;

SELECT [UID], ServerSetID, [Name], MaxConcurrentUser
	FROM dbo.LServerList WITH (NOLOCK)
		WHERE ServerType = @iServerType AND IP = @strServerIP AND Port1 = @iPort1
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_update_unit_class]
    @iUnitUID   [bigint],
    @iUnitClass [tinyint],
    @iOK        [int] = 0
AS

SET NOCOUNT ON;

-- 해당 유닛이 없는 경우.
IF NOT EXISTS (SELECT * FROM dbo.UnitStatistics	WITH (NOLOCK) WHERE UnitUID = @iUnitUID)
    GOTO END_PROC

BEGIN TRAN

    UPDATE dbo.UnitStatistics WITH( ROWLOCK )
        SET UnitClass = @iUnitClass
			WHERE UnitUID = @iUnitUID

		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -3	GOTO FAIL_TRAN	END


COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_update_stone_cnt]
	@iSupplyCnt		smallint
,	@iQuantity		int
,	@iOK			[int] = 0
AS
SET NOCOUNT ON;


IF(@iQuantity < @iSupplyCnt)
	BEGIN
-- 일간 부활석 리필 숫자 저장
		IF NOT EXISTS (SELECT * FROM dbo.StatsStoneCnt WHERE Regdate = CONVERT(NVARCHAR(10), GETDATE(),120))
			BEGIN
				INSERT INTO dbo.StatsStoneCnt (RegDate, FreeInsertCnt,Plus1,Plus2,Plus3,PlusOver3)
					SELECT CONVERT(NVARCHAR(10), GETDATE(),120), 0, 0,0,0,0
				IF @@ERROR <> 0
					BEGIN	SELECT @iOK = -98	END
			END

		UPDATE [Statistics].dbo.StatsStoneCnt WITH (UPDLOCK)
			SET FreeInsertCnt = FreeInsertCnt + @iSupplyCnt - @iQuantity
			,	Plus1			= plus1 + case (@iSupplyCnt - @iQuantity) when 1 then 1 else 0 end
			,	Plus2			= plus2 + case (@iSupplyCnt - @iQuantity) when 2 then 1 else 0 end
			,	Plus3			= plus3 + case (@iSupplyCnt - @iQuantity) when 3 then 1 else 0 end
			,	PlusOver3		= plusOver3 + case (@iSupplyCnt - @iQuantity) when 4 then 1 when 5 then 1 when 6 then 1 when 7 then 1 when 8 then 1 when 9 then 1 else 0 end
			WHERE Regdate = CONVERT(NVARCHAR(10), GETDATE(),120)
				IF @@ERROR <> 0 
					BEGIN	SELECT @iOK = -99	END
			
	END

GOTO END_PROC

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_update_module_log]
    @iModuleUID   int,
    @iCount		  BIGINT,
    @iOK          int = 0
AS

SET NOCOUNT ON;

-- 해당 유닛이 없는 경우.
IF NOT EXISTS (SELECT * FROM dbo.LModuleTable WITH (NOLOCK) WHERE ModuleUId = @iModuleUID)
    GOTO END_PROC

BEGIN TRAN

    UPDATE dbo.LModuleTable WITH( ROWLOCK )
        SET [count] = @iCount
			WHERE ModuleUId = @iModuleUID

		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -3	GOTO FAIL_TRAN	END


COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_update_expo_event]
	@iID			INT
,	@iKillUnitUID	BIGINT	
,	@sdtDieDate		SMALLDATETIME
,	@iOK			INT	= 0
/*
	Hwang	
	2010. 11. 19
	엑스포 이벤트 관련 리스트 정보 갱신
*/
	

AS
SET NOCOUNT ON;
SET XACT_ABORT ON;



BEGIN TRAN

	UPDATE dbo.LExpo_Event
		SET DieDate		= @sdtDieDate
		,	KillUnitUID	= @iKillUnitUID
			WHERE ID = @iID

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -2	GOTO FAIL_TRAN	END
		
COMMIT TRAN		
		
		


GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_update_drop_event]
	@iID			INT
,	@iGetUserUID	BIGINT	
,	@iOK			INT	= 0
/*
	sutamtwo	
	2009. 05. 25
	드랍 아이템 관련 이벤트 리스트 정보 갱신
*/
	

AS
SET NOCOUNT ON;
SET XACT_ABORT ON;


IF EXISTS (SELECT GetUserUID FROM dbo.DropEvent WITH (NOLOCK) WHERE GetUserUID = @iGetUserUID)
BEGIN
	BEGIN	SELECT @iOK = -1	GOTO END_PROC	END
END


BEGIN TRAN

	UPDATE dbo.DropEvent
		SET UPDTime		= GETDATE()
		,	Flag		= 1
		,	GetUserUID	= @iGetUserUID
			WHERE ID = @iID

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -2	GOTO FAIL_TRAN	END
		
COMMIT TRAN		
		
		


GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
/* 
기능: 서버 동접 수치를 기록한다 (게임서버의 경우 두 곳에 해야 함)
In: @iUID, @iConcurrentUser
Out: x

- Working example:
Exec lup_update_concurrent_user 20, 20

*/

CREATE OR ALTER PROCEDURE [dbo].[lup_update_concurrent_user]
    @sdtRegDate_		[smalldatetime]
,	@iUID_				[int]
,	@iConcurrentUser_	[int]
,	@iMakePartyCNT		[int]
,	@iPlayPartyCNT		[int]

AS
	SET NOCOUNT ON;


---- 파티 생성 카운트 값에 쓰레기 값이 넘어올 때
--IF @iMakePartyCNT < 0 OR @iMakePartyCNT > 30000
--BEGIN
--	SELECT @iMakePartyCNT = 0	
--END
---- 파티 플레이 카운트 값에 쓰레기 값이 넘어올 때
--IF @iPlayPartyCNT < 0 OR @iPlayPartyCNT > 30000
--BEGIN
--	SELECT @iPlayPartyCNT = 0	
--END



	-- UID 유효성 검사 및 서버의 타입(센터,게임여부)도 획득한다.
	DECLARE @iServerType	tinyint
	,		@iChannelOn		bit
	SELECT	@iServerType = ServerType 
		FROM dbo.LServerList WITH (NOLOCK) 
			WHERE UID = @iUID_ AND [Enable] = 1

	-- 유저에게 보이는 채널 리스트에 해당 서버가 ON/OFF 되어있는지 판단 (OFF되어있으면 업데이트 안함)
	SELECT	@iChannelOn	= Onoff
		FROM dbo.LChannelList WITH (NOLOCK)
			WHERE [UID] = @iUID_

	IF @iServerType IS NULL -- 해당 서버에 대한 데이터가 존재하지 않음
	BEGIN
		RAISERROR( 'WORK FAILED. err:%d', 16, 1, @@ERROR )
		GOTO END_PROC
	END

	BEGIN TRAN

		UPDATE dbo.LServerList
			SET ConcurrentUser = @iConcurrentUser_ 
				WHERE [UID] = @iUID_
				IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
					GOTO FAIL_TRAN
	/*
		IF @iServerType = 3
		BEGIN
			INSERT INTO dbo.StatCCUMinute( RegDate, ServerUID, CCU ) VALUES( @sdtRegDate_, @iUID_, @iConcurrentUser_ )
			IF @@ERROR <> 0
				GOTO FAIL_TRAN
		END
	*/    
    
		IF (@iChannelOn = 1)
		BEGIN 	
			UPDATE dbo.LChannelList
				SET ConcurrentUser	= @iConcurrentUser_
				,	MakePartyCNT	= @iMakePartyCNT
				,	PlayPartyCNT	= @iPlayPartyCNT
					WHERE [UID] = @iUID_ AND OnOff = 1
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				GOTO FAIL_TRAN
		END

	COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
RAISERROR( 'WORK FAILED. err:%d', 16, 1, @@ERROR )
ROLLBACK TRAN

END_PROC:
RETURN
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_insert_Dungeon_Log]
	@strServerIP		NVARCHAR(15),
	@iDungeonID			INT,
	@iUnitUID			BIGINT,
	@strNickName		NVARCHAR(20),
	@iDiffculty			TINYINT,
	@bIsChallenge		BIT,
	@iUnitClass			TINYINT,
	@iClear				TINYINT,
	@iStartMember		TINYINT,
	@iEndMemeber		TINYINT,
	@iLV				TINYINT,
	@iPlayTime			INT,
	@iEXP				INT,
	@iED				INT,
	@iCombo				TINYINT,
	@iComboScore		INT,
	@iTechnical			TINYINT,
	@iTechnScore		INT,
	@iTime				TINYINT,
	@iDamaged			TINYINT,
	@iDamagedNum		INT,
	@iRank				TINYINT,
	@iContinue			TINYINT,
	@iPassStage			TINYINT,
	@iPassSubSt			TINYINT,
	@bWithPet			BIT,
	@sdtRegDate			SMALLDATETIME,
	@iNpcDieCount		SMALLINT,
	@iGivenDamage		BIGINT,
	@iAttackDamage		BIGINT,
	@iUsingSkillKind	SMALLINT,
	@iTotalEXP			INT,
	@iPetID				TINYINT,
	@iPetEvoStep		TINYINT,
	@iDashCount			INT,			-- 2012.03.15 업데이트에 추가
	@iEndHP				INT,			-- 2012.06.21 업데이트에 추가
	@iStartContinue		SMALLINT,		-- 2012.06.21 업데이트에 추가
	@iContinueUseStage	SMALLINT,		-- 2012.06.21 업데이트에 추가
	@iContinueUseSub	SMALLINT,		-- 2012.06.21 업데이트에 추가
	@iFrame				SMALLINT,		-- 2012.06.21 업데이트에 추가
	@iBaseHP			INT,			-- 2012.07.05 업데이트에 추가
	@iRecovHP			INT,			-- 2012.07.05 업데이트에 추가
	@strChannelIP		NVARCHAR(15),	-- 2012.07.05 업데이트에 추가
	@iUserUID			BIGINT,			-- 2012.07.12 업데이트에 추가
	@bIsMatchStart		BIT,			-- 2012.11.08 업데이트에 추가
	@iMatchWait			INT,			-- 2012.11.22 업데이트에 추가
	@iLeaveReason		INT,			-- 2012.12.13 업데이트에 추가
	@iRoomState			TINYINT,		-- 2012.12.13 업데이트에 추가
	@bSkillSlotType		BIT,			-- 2012.12.13 업데이트에 추가
	@iOK				INT = 0
	
AS
SET NOCOUNT ON;

BEGIN TRAN

	INSERT INTO dbo.LDungeonLog (ServerIP, DungeonID, UnitUID, NickName, Diffculty, IsChallenge, UnitClass, [Clear], StartMember, EndMemeber, LV,
	                             PlayTime, [EXP], ED, Combo, ComboScore, Technical, TechnScore, [Time], Damaged, DamagedNum, [Rank], [Continue],
	                             PassStage, PassSubSt, WithPet, RegDate, NpcDieCount, GivenDamage, AttackDamage, UsingSkillKind, TotalEXP, PetID, PetEvoStep, DashCount,
	                             EndHP, StartContinue, ContinueUseStage, ContinueUseSub, Frame, BaseHP, RecovHP, ChannelIP, UserUID, IsMatchStart, MatchWait,
	                             LeaveReason, RoomState, SkillSlotType)
	    SELECT @strServerIP, @iDungeonID, @iUnitUID, @strNickName, @iDiffculty, @bIsChallenge, @iUnitClass, @iClear, @iStartMember, @iEndMemeber, @iLV, 
			   @iPlayTime, @iEXP, @iED, @iCombo, @iComboScore, @iTechnical, @iTechnScore, @iTime, @iDamaged, @iDamagedNum, @iRank, @iContinue,
			   @iPassStage, @iPassSubSt, @bWithPet, @sdtRegDate, @iNpcDieCount, @iGivenDamage, @iAttackDamage, @iUsingSkillKind, @iTotalEXP, @iPetID, @iPetEvoStep, @iDashCount,
			   @iEndHP, @iStartContinue, @iContinueUseStage, @iContinueUseSub, @iFrame, @iBaseHP, @iRecovHP, @strChannelIP, @iUserUID, @bIsMatchStart, @iMatchWait,
			   @iLeaveReason, @iRoomState, @bSkillSlotType
			   
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -111	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_insert_disconnect_userfsm]
	@ServerUID			[int],
	@iS_INIT			[int],
	@iS_UID_UPDATED		[int],
	@iS_LOGINED			[int],
	@iS_SERVER_SELECT	[int],
	@iS_UNIT_SELECT		[int],
	@iS_VILLAGE_MAP		[int],
	@iS_LOCAL_MAP		[int],
	@iS_WORLD_MAP		[int],
	@iS_CHANNEL			[int],
	@iS_ROOM			[int],
    @iOK				[int] = 0
AS

SET NOCOUNT ON;

DECLARE @sdtNow smalldatetime
SELECT  @sdtNow = GetDate()

BEGIN TRAN
    INSERT INTO dbo.LDisconnectUserFSM( 
		ServerUID,
		RegDate, 
		S_INIT, 
		S_UID_UPDATED,
		S_LOGINED, 
		S_SERVER_SELECT, 
		S_UNIT_SELECT, 
		S_VILLAGE_MAP,
		S_LOCAL_MAP, 
		S_WORLD_MAP, 
		S_CHANNEL, 
		S_ROOM )
    SELECT @ServerUID, @sdtNow, @iS_INIT, @iS_UID_UPDATED, @iS_LOGINED, @iS_SERVER_SELECT, @iS_UNIT_SELECT, @iS_VILLAGE_MAP, @iS_LOCAL_MAP,
		@iS_WORLD_MAP, @iS_CHANNEL, @iS_ROOM
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
    BEGIN
        SELECT @iOK = -1
        GOTO FAIL_TRAN
    END
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_insert_disconnect_reason]
	@ServerUID				[int],
	@No_Reason				[int],
	@Unknown				[int],
	@NProtect_Auth_Fail		[int],
	@PCBang_Auth_Delay		[int],
	@Diff_Main_Ver			[int],
	@Limit_User_Num			[int],
	@Nexon_Auth_Fail		[int],
	@Same_Server_Connect	[int],
	@Account_Block			[int],
	@IP_Block				[int],
	@NProtect_Auth_First	[int],
	@PCBang_Auth_Fail		[int],
	@PCBang_Auth_Wrong		[int],
	@Internal_Account		[int],
	@Normal_Disconnect		[int],
	@Client_Crash			[int],
	@Client_Hacking			[int],
	@NProtect_Wrong_Ack		[int],
	@PCBang_Auth_Server		[int],
	@Server_Shutdown		[int],
	@Session_Close			[int],
	@WSAECONNRESET			[int],
	@WSARecvFailed			[int],
	@WSASendFailed_OnSendComp[int],
	@SendBufferFull			[int],
	@WSASendFailed			[int],
	@GM_Kick_User			[int],
	@Diff_Server_Connect	[int],
	@User_Reg_Error			[int],
	@Heart_Beat				[int],
	@IOCP_GetStatus			[int],
	@NProtect_Hacking		[int],
	@ChannelChange			[int],
	@Channel_Change_Fail	[int],
	@Traffic_Attack			[int],
	@ServerAccBlock			[int],
	@MachineIDBlock			[int],
	@Same_MachineID_Connect	[int],
	@Shutdown_System		[int],
    @iOK					[int] = 0
AS

SET NOCOUNT ON;

DECLARE @sdtNow smalldatetime
SELECT  @sdtNow = GetDate()

BEGIN TRAN
    INSERT INTO dbo.LDisconnectReason( 
		ServerUID,
		RegDate, 
		No_Reason,
		Unknown,
		NProtect_Auth_Fail,
		PCBang_Auth_Delay,
		Diff_Main_Ver,
		Limit_User_Num,
		Nexon_Auth_Fail,
		Same_Server_Connect,
		Account_Block,
		IP_Block,
		NProtect_Auth_First,
		PCBang_Auth_Fail,
		PCBang_Auth_Wrong,
		Internal_Account,
		Normal_Disconnect,
		Client_Crash,
		Client_Hacking,
		NProtect_Wrong_Ack,
		PCBang_Auth_Server,
		Server_Shutdown,
		Session_Close,
		WSAECONNRESET,
		WSARecvFailed,
		WSASendFailed_OnSendComp,
		SendBufferFull,
		WSASendFailed,
		GM_Kick_User,
		Diff_Server_Connect,
		User_Reg_Error,		
		Heart_Beat,
		IOCP_GetStatus,
		NProtect_Hacking,
		ChannelChange,
		Channel_Change_Fail,
		Traffic_Attack,
		ServerAccBlock,
		MachineIDBlock,
		Same_MachineID_Connect,
		Shutdown_System
		)
    SELECT 
		@ServerUID,
		@sdtNow,
		@No_Reason,
		@Unknown,
		@NProtect_Auth_Fail,
		@PCBang_Auth_Delay,
		@Diff_Main_Ver,
		@Limit_User_Num,
		@Nexon_Auth_Fail,
		@Same_Server_Connect,
		@Account_Block,
		@IP_Block,
		@NProtect_Auth_First,
		@PCBang_Auth_Fail,
		@PCBang_Auth_Wrong,
		@Internal_Account,
		@Normal_Disconnect,
		@Client_Crash,
		@Client_Hacking,
		@NProtect_Wrong_Ack,
		@PCBang_Auth_Server,
		@Server_Shutdown,
		@Session_Close,
		@WSAECONNRESET,
		@WSARecvFailed,
		@WSASendFailed_OnSendComp,
		@SendBufferFull,
		@WSASendFailed,
		@GM_Kick_User,
		@Diff_Server_Connect,
		@User_Reg_Error,
		@Heart_Beat,
		@IOCP_GetStatus,
		@NProtect_Hacking,
		@ChannelChange,
		@Channel_Change_Fail,
		@Traffic_Attack,
		@ServerAccBlock,
		@MachineIDBlock,
		@Same_MachineID_Connect,
		@Shutdown_System
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
    BEGIN
        SELECT @iOK = -1
        GOTO FAIL_TRAN
    END
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_insert_DGT_HackUser]
	@iUserUID_		BIGINT,
	@sdtRegDate		SMALLDATETIME
	
AS
SET NOCOUNT ON;

	IF EXISTS (SELECT * FROM dbo.LDungeonTimeHackUser WITH (NOLOCK) WHERE UserUID = @iUserUID_)
		BEGIN	GOTO END_PROC	END
		
	ELSE
		BEGIN
			INSERT INTO dbo.LDungeonTimeHackUser(UserUID, RegDate)
			SELECT @iUserUID_, @sdtRegDate
		END
		
END_PROC:
GO
/*
	2011. 04. 25	
	Hwang
*/		

CREATE OR ALTER PROCEDURE [dbo].[lup_insert_Defense_Crystal]
	@iTargetCrystal			int
,	@sdtWsrtStartTime		SMALLDATETIME
,	@iProtectedCrystalCount	int
,	@iOK					int = 0
AS
SET NOCOUNT ON;

BEGIN TRAN

	IF NOT EXISTS (SELECT * FROM dbo.LDefense_Crystal WITH (NOLOCK) WHERE WsrtStartTime = @sdtWsrtStartTime)
		BEGIN
			INSERT INTO dbo.LDefense_Crystal (TargetCrystal, WsrtStartTime, ProtectedCrystalCount)
				SELECT	@iTargetCrystal, @sdtWsrtStartTime, @iProtectedCrystalCount	

			IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
				BEGIN	SELECT @iOK = -100	GOTO FAIL_TRAN	END
		END
		
	ELSE
		BEGIN
			UPDATE dbo.LDefense_Crystal
				SET ProtectedCrystalCount = @iProtectedCrystalCount
					WHERE WsrtStartTime = @sdtWsrtStartTime
					
			IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
				BEGIN	SELECT @iOK = -101	GOTO FAIL_TRAN	END
		END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_insert_comebackuser_log]
	@iUserUID			BIGINT
,	@iAge				TINYINT
,	@iUnitUID			BIGINT
,	@iUnitClass			TINYINT
,	@iLevel				TINYINT
,	@bIsFirstLogin		BIT
,	@iComebackGrade		TINYINT
,	@sdtRegDate			SMALLDATETIME
,	@iOK				INT = 0

AS
SET NOCOUNT ON;			
						
BEGIN TRAN	
			
INSERT INTO dbo.LComebackUserLog (UserUID, Age, UnitUID, UnitClass, [Level], IsFirstLogin, ComebackGrade, RegDate)
	SELECT @iUserUID, @iAge, @iUnitUID, @iUnitClass, @iLevel, @bIsFirstLogin, @iComebackGrade, @sdtRegDate
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1				
			BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END
	
COMMIT TRAN						
						
GOTO END_PROC						
						
FAIL_TRAN:						
ROLLBACK TRAN						
						
END_PROC:						
SELECT @iOK
GO
/*
	sutamtwo
	2007.11.09

	클라이언트에서 치팅코드 사용내역을 기록

	yuksa
	2008.01.22

	UserUID 컬럼 추가
*/
CREATE OR ALTER PROCEDURE [dbo].[lup_insert_cheat_log]
	@iUserUID_		bigint
,	@iUnitUID_		bigint
,	@iAuthLevel_	tinyint
,	@strCheatCode_	nvarchar(8)
,	@strCheatSTR_	nvarchar(50)
,	@iOK_			int = 0

AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE	@sdtNow	smalldatetime
SELECT	@sdtNow = GetDate()

-- 존재하지 않는 UID면 종료
IF NOT EXISTS (SELECT * FROM [Account].dbo.MUser WITH (NOLOCK) WHERE UserUID = @iUserUID_)
	BEGIN	SELECT @iOK_ = -1	GOTO END_PROC	END


BEGIN TRAN

	INSERT INTO dbo.CheatLog (UserUID, UnitUID, AuthLevel, CheatCode, CheatSTR, RegDate)
		SELECT @iUserUID_, @iUnitUID_, @iAuthLevel_, @strCheatCode_, @strCheatSTR_, @sdtNow
	IF @@ERROR <> 0
		BEGIN	SELECT @iOK_ = -10	GOTO FAIL_TRAN	END


COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK_
GO
-- =============================================
-- Author: JR
-- Create date: 2013-02-21
-- Update date: 2013-02-21
-- Description:	 틱변경
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_Manager_ReleaseTick_UPD]
	@Type	TINYINT = NULL
,	@DBType	CHAR(1) = NULL
,	@Result	INT = 0 OUTPUT
AS
SET NOCOUNT ON;

DECLARE @EXEC_SCRIPT	NVARCHAR(MAX)
,		@SQLUser		NVARCHAR(50)

SET @Result = -1

-- 없는 국가/DB를 위해 테이블 확인
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('dbo.ReleaseTick'))
BEGIN
	UPDATE ReleaseTick
	SET [Count] = [Count] + 1
	WHERE [type] = CASE WHEN @Type IS NOT NULL THEN @Type ELSE [type] END
	
	SET @Result = 0
END
GO
CREATE OR ALTER PROCEDURE [dbo].[P_Manager_NetCafe_INS]
	@InputIP	NVARCHAR(15)
,	@PC_Type	TINYINT = NULL
,	@Result		INT = -1 OUTPUT
AS
SET NOCOUNT ON;

DECLARE @EXEC_SCRIPT	NVARCHAR(MAX)
,		@SQLUser		NVARCHAR(50)

BEGIN TRAN
	
	INSERT INTO dbo.LNetCafeList (IP, PC_Type , RegDate)
		SELECT @InputIP, @PC_Type, GETDATE()
	
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	BEGIN    
		SELECT @Result = -1    
		GOTO FAIL_TRAN    
	END

COMMIT TRAN

SET @Result = 0
GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
GO
CREATE OR ALTER PROCEDURE [dbo].[P_Manager_NetCafe_DEL]
	@InputIP	NVARCHAR(15)
,	@Result		INT = 0 OUTPUT
AS
SET NOCOUNT ON;

DECLARE @EXEC_SCRIPT	NVARCHAR(MAX)
,		@SQLUser		NVARCHAR(50)

BEGIN TRAN
	
	DELETE FROM dbo.LNetCafeList WHERE IP = @InputIP
	
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	BEGIN    
		SELECT @Result = -1    
		GOTO FAIL_TRAN    
	END

COMMIT TRAN
GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
GO
CREATE OR ALTER PROCEDURE [dbo].[P_Manager_EventInfo_UPD]
	@Result		INT = 0 OUTPUT
AS
SET NOCOUNT ON;

DECLARE @EXEC_SCRIPT	NVARCHAR(MAX)
,		@SQLUser		NVARCHAR(50)

BEGIN TRAN
	
	UPDATE A
	SET A.EventName = B.EventName
	,	A.EventType = B. EventType
	,	A.BeginDate = B.BeginDate
	,	A.EndDate = B.EndDate
	,	A.ScriptID = B.ScriptID
	,	A.OnOff = B.OnOff
	,	A.ServerSetID = B.ServerSetID
	FROM dbo.EventInfo AS A, GAMEMANAGE.GameManage.dbo.GMTempEventInfo AS B
	WHERE A.EventID = B.EventID
	
	SET @Result = @@ROWCOUNT
	
	IF @@ERROR <> 0 OR @Result < 1
	BEGIN    
		SELECT @Result = -1    
		GOTO FAIL_TRAN    
	END
	
COMMIT TRAN
GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
GO
CREATE OR ALTER PROCEDURE [dbo].[P_Manager_EventInfo_INS]
	@Result		INT = 0 OUTPUT
AS
SET NOCOUNT ON;

DECLARE @EXEC_SCRIPT	NVARCHAR(MAX)
,		@SQLUser		NVARCHAR(50)

BEGIN TRAN
	
	INSERT INTO dbo.EventInfo (EventName, EventType, BeginDate, EndDate, ScriptID, OnOff, ServerSetID)
	SELECT	EventName, EventType, BeginDate, EndDate, ScriptID, OnOff, ServerSetID
	FROM	GAMEMANAGE.GameManage.dbo.GMTempEventInfo
	
	SET @Result = @@ROWCOUNT

	IF @@ERROR <> 0
	BEGIN    
		SELECT @Result = -1    
		GOTO FAIL_TRAN    
	END
	
COMMIT TRAN
GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
GO
CREATE OR ALTER PROCEDURE [dbo].[P_Manager_EventInfo_DEL]
	@EventID	INT
,	@Result		INT = 0 OUTPUT
AS
SET NOCOUNT ON;

DECLARE @EXEC_SCRIPT	NVARCHAR(MAX)
,		@SQLUser		NVARCHAR(50)

BEGIN TRAN
	
	UPDATE dbo.EventInfo 
	SET OnOff = 0
	WHERE EventID = @EventID
	
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	BEGIN    
		SELECT @Result = -1    
		GOTO FAIL_TRAN    
	END
	
COMMIT TRAN
GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
GO
CREATE OR ALTER PROCEDURE [dbo].[P_LUserDLLLog_INT]
	@UserUID	bigint
,	@ServerSN	bigint
,	@DLLName	nvarchar(20)
,	@Type		smallint

AS
	SET NOCOUNT ON
/*
	접속한 유저의 DLL을 검사하여 문제가 있는 DLL의 정보를 남긴다
*/
	
	DECLARE	@Result		int

		BEGIN TRY
			BEGIN TRAN

			INSERT INTO dbo.LUserDLLLog( UserUID, ServerSN, DLLName, [Type], RegDate )
			VALUES( @UserUID, @ServerSN, @DLLName, @Type, GETDATE() )

			COMMIT TRAN

			SET @Result = 0
		END TRY
		BEGIN CATCH
			DECLARE @NO_XACT_STATE		smallint
			SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

			IF @NO_XACT_STATE <> 0
				ROLLBACK TRAN

			EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

			IF @Result = 0 OR @Result IS NULL
				SET @Result = -1
		END CATCH

	SELECT ISNULL(@Result, 0) AS Result
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 접속한 유저의 DLL을 검사하여 문제가 있는 DLL의 정보를 남긴다
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LUserDLLLog_INS]
	@iServerSetID		TINYINT
,	@UserUID	bigint
,	@ServerSN	bigint
,	@DLLName	nvarchar(20)
,	@Type		smallint

AS
	SET NOCOUNT ON

	DECLARE	@Result		int

		BEGIN TRY
			BEGIN TRAN

			INSERT INTO dbo.LUserDLLLog( UserUID, ServerSN, DLLName, [Type], RegDate )
			VALUES( @UserUID, @ServerSN, @DLLName, @Type, GETDATE() )

			COMMIT TRAN

			SET @Result = 0
		END TRY
		BEGIN CATCH
			DECLARE @NO_XACT_STATE		smallint
			SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

			IF @NO_XACT_STATE <> 0
				ROLLBACK TRAN

			EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

			IF @Result = 0 OR @Result IS NULL
				SET @Result = -1
		END CATCH

	SELECT ISNULL(@Result, 0) AS Result
GO
CREATE OR ALTER PROCEDURE [dbo].[P_LUnitStatisticsTotal]
-- Connect
	@ServerUID					int					-- 서버 번호
,	@logintime					datetime			-- 로그인 일시
,	@logouttime					datetime			-- 로그아웃 일시
,	@PCBangFlag					bit					-- PC방 여부
,	@AuthLevel					tinyint				-- 계정 권한
-- User
,	@UserUID					bigint				-- 계정 고유번호
,	@PublisherSN				int					-- 퍼블리셔 SN
,	@UserRegDate				smalldatetime		-- 계정 생성일시
-- Unit
,	@UnitUID					bigint				-- 고유번호
,	@NickName					nvarchar(20)		-- 닉네임
,	@UnitClass					tinyint				-- 클래스
,	@Exp						int					-- 경험치
,	@Level						tinyint				-- 레벨
,	@GamePoint					int					-- ED
,	@UnitRegDate				smalldatetime		-- 생성일시
,	@QuestCnt					int					-- 총 완료 퀘스트 수
,	@ReQuestCnt					int					-- 총 중복 완료 퀘스트 수
-- ED
,	@PDungeon					int					-- 던전 획득
,	@PTraining					int					-- 트레이닝 획득
,	@PQuest						int					-- 퀘스트 획득
,	@PItemSell					int					-- 아이템 판매 획득
,	@PItemTrade					bigint				-- 아이템 거래 획득
,	@PPersonalShop				bigint				-- 아이템 개인 거래 획득
,	@PPostLetter				bigint				-- 우편 수령 획득
,	@MItemBuy					int					-- 아이템 판매
,	@MItemTrade					bigint				-- 거래 지불
,	@MItemRepair				int					-- 아이템 수리비
,	@MItemEnchant				bigint				-- 아이템 강화 수수료
,	@MItemSocket				int					-- 아이템 소켓 수수료
,	@MItemAttribute				int					-- 아이템 속성 수수료
,	@MManufacture				int					-- 아이템 제조 수수료
,	@MDunPenalty				int					-- 던전 이탈 패널티
,	@MPersonalShop				bigint				-- 개인 거래 지불
,	@MOpenPShop					bigint				-- 개인 상점 개설 수수료
,	@MSellTaxPShop				int					-- 개인 상점 구매 수수료
,	@MBuyTaxPShop				int					-- 개인 상점 판매 수수료
,	@MPostLetter				bigint				-- 우편 첨부
,	@MSendLetterBasic			int					-- 우편 발송 수수료
,	@MSendLetterItem			int					-- 우편 아이템 첨부 수수료
,	@MOpenCubeSpendED			bigint				-- ED로 큐브오픈/2012.12.06 패치
,	@PBattleFieldED				bigint				-- 배틀필드에서 획득한 ED/2013.05.09 패치
,	@MCoboExpressTicketED		bigint				-- 코보티켓 지역이동으로 소모한 ED/2013.05.09 패치
,	@MItemDecom					bigint				-- 일본 분해 ED
-- Play
,	@UseSpirit					int					-- 사용 근성도
,	@AllSpirit					bit					-- 근성도 모두 소모 여부
,	@TotalPlayTime				int					-- 총 플래이 시간(초)
,	@DurationTime				int					-- 총 대기 시간(초)
,	@VsPlayTime					int					-- 총 대전 시간(초)
,	@DSoloCnt					int					-- 던전 싱글 플래이 횟수
,	@DPartyCnt					int					-- 던전 파티 플래이 횟수
,	@DSWCnt						int					-- 던전 싱글 클리이 횟수
,	@DPWCnt						int					-- 던전 파티 클리이 횟수
,	@DSPlayTime					int					-- 던전 싱글 플래이 시간(초)
,	@DPPlayTime					int					-- 던전 파티 플래이 시간(초)
,	@VsKillCnt					int					-- 대전 Kill 수
,	@VsWinCnt					smallint			-- 대전 승 수
,	@VsLoseCnt					smallint			-- 대전 패 수
,	@TrainingPT					int					-- 트레이닝 플래이 시간(초)
,	@TrainingCnt				int					-- 트레이닝 플래이 횟수
,	@P2PCnt						smallint			-- 개인 거래 횟 수
,	@SquareCnt					int					-- 광장 출입 횟 수
,	@SquarePlayTime				int					-- 광장 머문 시간
,	@BuyItemCnt					int					-- 구매한 아이템 수
,	@SellItemCnt				int					-- 판매한 아이템 수
,	@GetItemCnt					int					-- 획득한 아이템 수
,	@UseStone					smallint			-- 사용한 부활석 수
AS
	SET NOCOUNT ON

	DECLARE @Result				int

	DECLARE @GamePointBefor		int
	,	@NickNameBefor			nvarchar(40)
	,	@CreateUnit				bit
	,	@CreateUser				bit
	,	@FirstUnitUID			bigint
	,	@FirstUnitExp			int
	,	@Regdate				char(8)
	,	@PTotal					bigint
	,	@MTotal					bigint
	,	@TotalDiff				int

	SET @Regdate = CONVERT(char(8), @logouttime, 112)

	-- 마지막 캐릭터 정보(ED, NickName)
	SELECT @GamePointBefor = GamePoint,	@NickNameBefor = NickName
	,	@CreateUnit = 0
	FROM dbo.LUnitStatistics WITH(NOLOCK)
	WHERE UnitUID = @UnitUID

	-- 없으면 기본값(캐릭터 추가)
	IF @@ROWCOUNT = 0
		SELECT @GamePointBefor = 0, @NickNameBefor = @NickName, @CreateUnit = 1

	-- 경험치 가장 많은 캐릭터(FirstUnit 이 왜 경험치가 가장 많은 캐릭터일까?)
	SELECT @FirstUnitUID = FirstUnitUID
	,	@CreateUser = 0
	FROM dbo.LUserStatistics WITH(NOLOCK)
	WHERE UserUID = @UserUID

	-- 없으면 기본값(계정 추가)
	IF @@ROWCOUNT = 0
		SELECT @FirstUnitUID = @UnitUID, @CreateUser = 1
	ELSE BEGIN
		SELECT @FirstUnitExp = [Exp]
		FROM dbo.LUnitStatistics WITH(NOLOCK)
		WHERE UnitUID = @FirstUnitUID

		IF @FirstUnitExp <= @Exp
			SET @FirstUnitUID = @UnitUID
	END

	SET @PTotal = @PDungeon + @PTraining + @PQuest + @PItemSell + @PItemTrade + @PPersonalShop + @PPostLetter + @MOpenCubeSpendED + @MCoboExpressTicketED + @MItemDecom
	SET @MTotal = @MItemBuy + @MItemTrade + @MItemRepair + @MItemEnchant + @MItemSocket + @MItemAttribute + @MManufacture + @MDunPenalty + @MPersonalShop + @MOpenPShop + @MSellTaxPShop + @MBuyTaxPShop + @MPostLetter + @MSendLetterBasic + @MSendLetterItem + @PBattleFieldED
	SET @TotalDiff = (@GamePointBefor + @PTotal - @MTotal) - @GamePoint

	BEGIN TRY
		-- 계정 신규 등록
		IF @CreateUser = 1 BEGIN
			INSERT INTO dbo.LUserStatistics ( UserUID, PublisherSN, RegDate, FirstUnitUID, UnitCount, UnitDelCount, LastLogin, AuthLevel )
			VALUES ( @UserUID, @PublisherSN, @UserRegDate, @FirstUnitUID, 1, 0, @logouttime, @AuthLevel )
		END
		ELSE BEGIN
			UPDATE dbo.LUserStatistics
			SET UnitCount = UnitCount + CASE WHEN @CreateUnit = 1 THEN 1 ELSE 0 END
			,	FirstUnitUID = @FirstUnitUID
			,	LastLogin = @logouttime
			,	AuthLevel = @AuthLevel
			WHERE UserUID = @UserUID
		END

		-- 캐릭터 신규 등록
		IF @CreateUnit = 1 BEGIN
			INSERT INTO dbo.LUnitStatistics ( UnitUID, UserUID, NickName, NickNameChangeCount, UnitClass, [Exp], [Level], GamePoint, PlayDayCnt, LoginCount, PCBangCnt, PCBangDayCnt, LastDate, RegDate, DelDate, TotalPlayTime, VsPlayTime, DPlayTime, UseSpirit, AllSpiritCnt, KillCnt, VsCnt, DCnt, P2PCnt, SquareCnt, SquarePlayTime, QuestCnt, ReQuestCnt, UseStone )
			SELECT @UnitUID, @UserUID, @NickName, 0, @UnitClass, @Exp, @Level, @GamePoint, 1, 1, CASE WHEN @PCBangFlag = 1 THEN 1 ELSE 0 END, CASE WHEN @PCBangFlag = 1 THEN 1 ELSE 0 END, @logouttime, @UnitRegDate, NULL, @TotalPlayTime, @VsPlayTime, (@DSPlayTime + @DPPlayTime), @UseSpirit, CASE WHEN @AllSpirit = 1 THEN 1 ELSE 0 END, @VsKillCnt, (@VsWinCnt + @VsLoseCnt), (@DSoloCnt + @DPartyCnt), @P2PCnt, @SquareCnt, @SquarePlayTime, @QuestCnt, @ReQuestCnt, @UseStone
		END
		ELSE BEGIN
			UPDATE dbo.LUnitStatistics
			SET NickName = @NickName
			,	NickNameChangeCount = NickNameChangeCount + CASE WHEN @NickNameBefor <> @NickName THEN 1 ELSE 0 END
			,	UnitClass = @UnitClass
			,	[Exp] = @Exp
			,	[Level] = @Level
			,	GamePoint = @GamePoint
			,	PlayDayCnt = PlayDayCnt + CASE WHEN DATEDIFF(dd, LastDate, @logouttime) <> 0 THEN 1 ELSE 0 END
			,	LoginCount = LoginCount + 1
			,	PCBangCnt = PCBangCnt + CASE WHEN @PCBangFlag = 1 THEN 1 ELSE 0 END
			,	PCBangDayCnt = PCBangDayCnt + CASE WHEN (DATEDIFF(dd, LastDate, @logouttime) <> 0 AND @PCBangFlag = 1) THEN 1 ELSE 0 END
			,	LastDate = @logouttime
			,	TotalPlayTime = TotalPlayTime + @TotalPlayTime
			,	VsPlayTime = VsPlayTime + @VsPlayTime
			,	DPlayTime = DPlayTime + (@DSPlayTime + @DPPlayTime)
			,	UseSpirit = UseSpirit + @UseSpirit
			,	AllSpiritCnt = AllSpiritCnt + CASE WHEN (DATEDIFF(dd, LastDate, @logouttime) <> 0 AND @AllSpirit = 1) THEN 1 ELSE 0 END
			,	KillCnt = KillCnt + @VsKillCnt
			,	VsCnt = VsCnt + (@VsWinCnt + @VsLoseCnt)
			,	DCnt = DCnt + (@DSoloCnt + @DPartyCnt)
			,	P2PCnt = P2PCnt + @P2PCnt
			,	SquareCnt = SquareCnt + @SquareCnt
			,	SquarePlayTime = SquarePlayTime + @SquarePlayTime
			,	QuestCnt = @QuestCnt
			,	ReQuestCnt = @ReQuestCnt
			,	UseStone = UseStone + @UseStone
			WHERE UnitUID = @UnitUID
		END

		-- 접속 내역 기록
		EXEC dbo.P_LUnitConnectLog_INT @ServerUID, @UnitUID, @NickName, @UnitClass, @Exp, @Level, @logintime, @logouttime, @TotalPlayTime, @PCBangFlag, @AuthLevel, @Level

		-- 캐릭터 일별 ED통계 기록
		EXEC dbo.P_LUnitDailyGamePoint_INT @Regdate, @UnitUID, @PTotal, @MTotal, @TotalDiff, @PDungeon, @PTraining, @PQuest, @PItemSell, @PItemTrade, @PPersonalShop, @PPostLetter, @MItemBuy, @MItemTrade, @MItemRepair, @MItemEnchant, @MItemSocket, @MItemAttribute, @MManufacture, @MDunPenalty, @MPersonalShop, @MOpenPShop, @MSellTaxPShop, @MBuyTaxPShop, @MPostLetter, @MSendLetterBasic, @MSendLetterItem, @MOpenCubeSpendED, @PBattleFieldED, @MCoboExpressTicketED, @MItemDecom

		-- 캐릭터 일별 Play통계 기록
		EXEC dbo.P_LUnitDailyPlay_INT 0, @RegDate, @UnitUID, @AuthLevel, @UseSpirit, @AllSpirit, @TotalPlayTime, @DurationTime, @DSoloCnt, @DPartyCnt, @DSWCnt, @DPWCnt, @DSPlayTime, @DPPlayTime, @VsKillCnt, @VsWinCnt, @VsLoseCnt, @VsPlayTime, @TrainingPT, @TrainingCnt, @P2PCnt, @SquareCnt, @SquarePlayTime, @BuyItemCnt, @SellItemCnt, @GetItemCnt, @PCBangFlag, @UseStone

		SET @Result = 0
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

		IF @Result IS NULL OR @Result = 0
			SET @Result = 555
	END CATCH

	SELECT @Result AS Result
GO
-- =============================================
-- Author:  
-- Create date: 
-- Description: 
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_LUnitStatistics_SET]
	@iServerSetID	TINYINT	
-- Connect
,	@ServerUID					int					-- 서버 번호
,	@logintime					datetime			-- 로그인 일시
,	@logouttime					datetime			-- 로그아웃 일시
,	@PCBangFlag					bit					-- PC방 여부
,	@AuthLevel					tinyint				-- 계정 권한
-- User
,	@UserUID					bigint				-- 계정 고유번호
,	@PublisherSN				int					-- 퍼블리셔 SN
,	@UserRegDate				smalldatetime		-- 계정 생성일시
-- Unit
,	@UnitUID					bigint				-- 고유번호
,	@NickName					nvarchar(20)		-- 닉네임
,	@UnitClass					tinyint				-- 클래스
,	@Exp						int					-- 경험치
,	@Level						tinyint				-- 레벨
,	@GamePoint					int					-- ED
,	@UnitRegDate				smalldatetime		-- 생성일시
,	@QuestCnt					int					-- 총 완료 퀘스트 수
,	@ReQuestCnt					int					-- 총 중복 완료 퀘스트 수
-- ED
,	@PDungeon					int					-- 던전 획득
,	@PTraining					int					-- 트레이닝 획득
,	@PQuest						int					-- 퀘스트 획득
,	@PItemSell					int					-- 아이템 판매 획득
,	@PItemTrade					bigint				-- 아이템 거래 획득
,	@PPersonalShop				bigint				-- 아이템 개인 거래 획득
,	@PPostLetter				bigint				-- 우편 수령 획득
,	@MItemBuy					int					-- 아이템 판매
,	@MItemTrade					bigint				-- 거래 지불
,	@MItemRepair				int					-- 아이템 수리비
,	@MItemEnchant				bigint				-- 아이템 강화 수수료
,	@MItemSocket				int					-- 아이템 소켓 수수료
,	@MItemAttribute				int					-- 아이템 속성 수수료
,	@MManufacture				int					-- 아이템 제조 수수료
,	@MDunPenalty				int					-- 던전 이탈 패널티
,	@MPersonalShop				bigint				-- 개인 거래 지불
,	@MOpenPShop					bigint				-- 개인 상점 개설 수수료
,	@MSellTaxPShop				int					-- 개인 상점 구매 수수료
,	@MBuyTaxPShop				int					-- 개인 상점 판매 수수료
,	@MPostLetter				bigint				-- 우편 첨부
,	@MSendLetterBasic			int					-- 우편 발송 수수료
,	@MSendLetterItem			int					-- 우편 아이템 첨부 수수료
,	@MOpenCubeSpendED			bigint				-- ED로 큐브오픈/2012.12.06 패치
,	@PBattleFieldED				bigint				-- 배틀필드에서 획득한 ED/2013.05.09 패치
,	@MCoboExpressTicketED		bigint				-- 코보티켓 지역이동으로 소모한 ED/2013.05.09 패치
,	@MItemDecom					bigint				-- 일본 분해 ED

-- Play
,	@UseSpirit					int					-- 사용 근성도
,	@AllSpirit					bit					-- 근성도 모두 소모 여부
,	@TotalPlayTime				int					-- 총 플래이 시간(초)
,	@DurationTime				int					-- 총 대기 시간(초)
,	@VsPlayTime					int					-- 총 대전 시간(초)
,	@DSoloCnt					int					-- 던전 싱글 플래이 횟수
,	@DPartyCnt					int					-- 던전 파티 플래이 횟수
,	@DSWCnt						int					-- 던전 싱글 클리이 횟수
,	@DPWCnt						int					-- 던전 파티 클리이 횟수
,	@DSPlayTime					int					-- 던전 싱글 플래이 시간(초)
,	@DPPlayTime					int					-- 던전 파티 플래이 시간(초)
,	@VsKillCnt					int					-- 대전 Kill 수
,	@VsWinCnt					smallint			-- 대전 승 수
,	@VsLoseCnt					smallint			-- 대전 패 수
,	@TrainingPT					int					-- 트레이닝 플래이 시간(초)
,	@TrainingCnt				int					-- 트레이닝 플래이 횟수
,	@P2PCnt						smallint			-- 개인 거래 횟 수
,	@SquareCnt					int					-- 광장 출입 횟 수
,	@SquarePlayTime				int					-- 광장 머문 시간
,	@BuyItemCnt					int					-- 구매한 아이템 수
,	@SellItemCnt				int					-- 판매한 아이템 수
,	@GetItemCnt					int					-- 획득한 아이템 수
,	@UseStone					smallint			-- 사용한 부활석 수
AS
	SET NOCOUNT ON

	DECLARE @Result				int

	DECLARE @GamePointBefor		int
	,	@NickNameBefor			nvarchar(40)
	,	@CreateUnit				bit
	,	@CreateUser				bit
	,	@FirstUnitUID			bigint
	,	@FirstUnitExp			int
	,	@Regdate				char(8)
	,	@PTotal					bigint
	,	@MTotal					bigint
	,	@TotalDiff				int

	SET @Regdate = CONVERT(char(8), @logouttime, 112)

	-- 마지막 캐릭터 정보(ED, NickName)
	SELECT @GamePointBefor = GamePoint,	@NickNameBefor = NickName
	,	@CreateUnit = 0
	FROM dbo.LUnitStatistics WITH(NOLOCK)
	WHERE UnitUID = @UnitUID

	-- 없으면 기본값(캐릭터 추가)
	IF @@ROWCOUNT = 0
		SELECT @GamePointBefor = 0, @NickNameBefor = @NickName, @CreateUnit = 1

	-- 경험치 가장 많은 캐릭터(FirstUnit 이 왜 경험치가 가장 많은 캐릭터일까?)
	SELECT @FirstUnitUID = FirstUnitUID
	,	@CreateUser = 0
	FROM dbo.LUserStatistics WITH(NOLOCK)
	WHERE UserUID = @UserUID

	-- 없으면 기본값(계정 추가)
	IF @@ROWCOUNT = 0
		SELECT @FirstUnitUID = @UnitUID, @CreateUser = 1
	ELSE BEGIN
		SELECT @FirstUnitExp = [Exp]
		FROM dbo.LUnitStatistics WITH(NOLOCK)
		WHERE UnitUID = @FirstUnitUID

		IF @FirstUnitExp <= @Exp
			SET @FirstUnitUID = @UnitUID
	END

	SET @PTotal = @PDungeon + @PTraining + @PQuest + @PItemSell + @PItemTrade + @PPersonalShop + @PPostLetter + @MOpenCubeSpendED + @MCoboExpressTicketED + @MItemDecom
	SET @MTotal = @MItemBuy + @MItemTrade + @MItemRepair + @MItemEnchant + @MItemSocket + @MItemAttribute + @MManufacture + @MDunPenalty + @MPersonalShop + @MOpenPShop + @MSellTaxPShop + @MBuyTaxPShop + @MPostLetter + @MSendLetterBasic + @MSendLetterItem + @PBattleFieldED
	SET @TotalDiff = (@GamePointBefor + @PTotal - @MTotal) - @GamePoint

	BEGIN TRY
		-- 계정 신규 등록
		IF @CreateUser = 1 BEGIN
			INSERT INTO dbo.LUserStatistics ( UserUID, PublisherSN, RegDate, FirstUnitUID, UnitCount, UnitDelCount, LastLogin, AuthLevel )
			VALUES ( @UserUID, @PublisherSN, @UserRegDate, @FirstUnitUID, 1, 0, @logouttime, @AuthLevel )
		END
		ELSE BEGIN
			UPDATE dbo.LUserStatistics
			SET UnitCount = UnitCount + CASE WHEN @CreateUnit = 1 THEN 1 ELSE 0 END
			,	FirstUnitUID = @FirstUnitUID
			,	LastLogin = @logouttime
			,	AuthLevel = @AuthLevel
			WHERE UserUID = @UserUID
		END

		-- 캐릭터 신규 등록
		IF @CreateUnit = 1 BEGIN
			INSERT INTO dbo.LUnitStatistics ( UnitUID, UserUID, NickName, NickNameChangeCount, UnitClass, [Exp], [Level], GamePoint, PlayDayCnt, LoginCount, PCBangCnt, PCBangDayCnt, LastDate, RegDate, DelDate, TotalPlayTime, VsPlayTime, DPlayTime, UseSpirit, AllSpiritCnt, KillCnt, VsCnt, DCnt, P2PCnt, SquareCnt, SquarePlayTime, QuestCnt, ReQuestCnt, UseStone )
			SELECT @UnitUID, @UserUID, @NickName, 0, @UnitClass, @Exp, @Level, @GamePoint, 1, 1, CASE WHEN @PCBangFlag = 1 THEN 1 ELSE 0 END, CASE WHEN @PCBangFlag = 1 THEN 1 ELSE 0 END, @logouttime, @UnitRegDate, NULL, @TotalPlayTime, @VsPlayTime, (@DSPlayTime + @DPPlayTime), @UseSpirit, CASE WHEN @AllSpirit = 1 THEN 1 ELSE 0 END, @VsKillCnt, (@VsWinCnt + @VsLoseCnt), (@DSoloCnt + @DPartyCnt), @P2PCnt, @SquareCnt, @SquarePlayTime, @QuestCnt, @ReQuestCnt, @UseStone
		END
		ELSE BEGIN
			UPDATE dbo.LUnitStatistics
			SET NickName = @NickName
			,	NickNameChangeCount = NickNameChangeCount + CASE WHEN @NickNameBefor <> @NickName THEN 1 ELSE 0 END
			,	UnitClass = @UnitClass
			,	[Exp] = @Exp
			,	[Level] = @Level
			,	GamePoint = @GamePoint
			,	PlayDayCnt = PlayDayCnt + CASE WHEN DATEDIFF(dd, LastDate, @logouttime) <> 0 THEN 1 ELSE 0 END
			,	LoginCount = LoginCount + 1
			,	PCBangCnt = PCBangCnt + CASE WHEN @PCBangFlag = 1 THEN 1 ELSE 0 END
			,	PCBangDayCnt = PCBangDayCnt + CASE WHEN (DATEDIFF(dd, LastDate, @logouttime) <> 0 AND @PCBangFlag = 1) THEN 1 ELSE 0 END
			,	LastDate = @logouttime
			,	TotalPlayTime = TotalPlayTime + @TotalPlayTime
			,	VsPlayTime = VsPlayTime + @VsPlayTime
			,	DPlayTime = DPlayTime + (@DSPlayTime + @DPPlayTime)
			,	UseSpirit = UseSpirit + @UseSpirit
			,	AllSpiritCnt = AllSpiritCnt + CASE WHEN (DATEDIFF(dd, LastDate, @logouttime) <> 0 AND @AllSpirit = 1) THEN 1 ELSE 0 END
			,	KillCnt = KillCnt + @VsKillCnt
			,	VsCnt = VsCnt + (@VsWinCnt + @VsLoseCnt)
			,	DCnt = DCnt + (@DSoloCnt + @DPartyCnt)
			,	P2PCnt = P2PCnt + @P2PCnt
			,	SquareCnt = SquareCnt + @SquareCnt
			,	SquarePlayTime = SquarePlayTime + @SquarePlayTime
			,	QuestCnt = @QuestCnt
			,	ReQuestCnt = @ReQuestCnt
			,	UseStone = UseStone + @UseStone
			WHERE UnitUID = @UnitUID
		END

		-- 접속 내역 기록
		EXEC dbo.P_LUnitConnectLog_INS @iServerSetID, @ServerUID, @UnitUID, @NickName, @UnitClass, @Exp, @Level, @logintime, @logouttime, @TotalPlayTime, @PCBangFlag, @AuthLevel, @Level
		
		-- 캐릭터 일별 ED통계 기록
		EXEC dbo.P_LUnitDailyGamePoint_INS @iServerSetID, @Regdate, @UnitUID, @PTotal, @MTotal, @TotalDiff, @PDungeon, @PTraining, @PQuest, @PItemSell, @PItemTrade, @PPersonalShop, @PPostLetter, @MItemBuy, @MItemTrade, @MItemRepair, @MItemEnchant, @MItemSocket, @MItemAttribute, @MManufacture, @MDunPenalty, @MPersonalShop, @MOpenPShop, @MSellTaxPShop, @MBuyTaxPShop, @MPostLetter, @MSendLetterBasic, @MSendLetterItem, @MOpenCubeSpendED, @PBattleFieldED, @MCoboExpressTicketED, @MItemDecom

		-- 캐릭터 일별 Play통계 기록
		EXEC dbo.P_LUnitDailyPlay_INS @iServerSetID, @RegDate, @UnitUID, @AuthLevel, @UseSpirit, @AllSpirit, @TotalPlayTime, @DurationTime, @DSoloCnt, @DPartyCnt, @DSWCnt, @DPWCnt, @DSPlayTime, @DPPlayTime, @VsKillCnt, @VsWinCnt, @VsLoseCnt, @VsPlayTime, @TrainingPT, @TrainingCnt, @P2PCnt, @SquareCnt, @SquarePlayTime, @BuyItemCnt, @SellItemCnt, @GetItemCnt, @PCBangFlag, @UseStone

		SET @Result = 0
	END TRY
	BEGIN CATCH
		DECLARE @NO_XACT_STATE		smallint
		SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

		IF @NO_XACT_STATE <> 0
			ROLLBACK TRAN

		EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

		IF @Result IS NULL OR @Result = 0
			SET @Result = 555
	END CATCH

	SELECT @Result AS Result
GO
