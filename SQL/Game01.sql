-- =============================================================================
-- Elsword Database Schema: [Game01]
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
DECLARE @SqlCmd NVARCHAR(400) = N'ALTER DATABASE [Game01] SET COMPATIBILITY_LEVEL = ' + CAST(@CompatLevel AS NVARCHAR(10));
EXEC sp_executesql @SqlCmd;
GO

ALTER DATABASE [Game01] SET ANSI_NULL_DEFAULT ON
GO
ALTER DATABASE [Game01] SET ANSI_NULLS ON
GO
ALTER DATABASE [Game01] SET ANSI_PADDING ON
GO
ALTER DATABASE [Game01] SET ANSI_WARNINGS ON
GO
ALTER DATABASE [Game01] SET ARITHABORT ON
GO
ALTER DATABASE [Game01] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [Game01] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [Game01] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [Game01] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [Game01] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [Game01] SET CURSOR_DEFAULT GLOBAL
GO
ALTER DATABASE [Game01] SET CONCAT_NULL_YIELDS_NULL ON
GO
ALTER DATABASE [Game01] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [Game01] SET QUOTED_IDENTIFIER ON
GO
ALTER DATABASE [Game01] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [Game01] SET DISABLE_BROKER
GO
ALTER DATABASE [Game01] SET AUTO_UPDATE_STATISTICS_ASYNC ON
GO
ALTER DATABASE [Game01] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [Game01] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [Game01] SET ALLOW_SNAPSHOT_ISOLATION ON
GO
ALTER DATABASE [Game01] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [Game01] SET READ_COMMITTED_SNAPSHOT ON
GO
ALTER DATABASE [Game01] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [Game01] SET READ_WRITE
GO
ALTER DATABASE [Game01] SET RECOVERY SIMPLE
GO
ALTER DATABASE [Game01] SET MULTI_USER
GO
ALTER DATABASE [Game01] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [Game01] SET DB_CHAINING OFF
GO
ALTER DATABASE [Game01] SET TARGET_RECOVERY_TIME = 60 SECONDS
GO
USE [Game01]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF DATABASE_PRINCIPAL_ID(N'gmanager') IS NULL
    CREATE USER [gmanager] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo];
GO
IF DATABASE_PRINCIPAL_ID(N'elsword') IS NULL
    CREATE USER [elsword] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo];
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
IF OBJECT_ID(N'[dbo].[Rank_SpaceTime_Week]', N'U') IS NULL
CREATE TABLE [dbo].[Rank_SpaceTime_Week](
	[Rank] [tinyint] NULL,
	[UnitUID] [bigint] NOT NULL,
	[NickName] [nvarchar](16) NULL,
	[UnitClass] [tinyint] NULL,
	[Level] [tinyint] NULL,
	[Stage] [tinyint] NULL,
	[PlayTime] [smallint] NULL,
	[RegDate] [smalldatetime] NULL,
	[Date] [smalldatetime] NULL,
 CONSTRAINT [PKC_Rank_SpaceTime_Week_UnitUID] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[Rank_SpaceTime_MyRecord]', N'U') IS NULL
CREATE TABLE [dbo].[Rank_SpaceTime_MyRecord](
	[UnitUID] [bigint] NOT NULL,
	[Stage] [tinyint] NULL,
	[Level] [tinyint] NULL,
	[UnitClass] [tinyint] NULL,
	[PlayTime] [smallint] NULL,
	[RegDate] [smalldatetime] NULL,
 CONSTRAINT [PKC_Rank_SpaceTime_MyRecord_UnitUID] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[Rank_SpaceTime_Month]', N'U') IS NULL
CREATE TABLE [dbo].[Rank_SpaceTime_Month](
	[Rank] [tinyint] NULL,
	[UnitUID] [bigint] NOT NULL,
	[NickName] [nvarchar](16) NULL,
	[UnitClass] [tinyint] NULL,
	[Level] [tinyint] NULL,
	[Stage] [tinyint] NULL,
	[PlayTime] [smallint] NULL,
	[RegDate] [smalldatetime] NULL,
	[Date] [smalldatetime] NULL,
 CONSTRAINT [PKC_Rank_SpaceTime_Month_UnitUID] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[Rank_SpaceTime_Day]', N'U') IS NULL
CREATE TABLE [dbo].[Rank_SpaceTime_Day](
	[Rank] [tinyint] NULL,
	[UnitUID] [bigint] NOT NULL,
	[NickName] [nvarchar](16) NULL,
	[UnitClass] [tinyint] NULL,
	[Level] [tinyint] NULL,
	[Stage] [tinyint] NULL,
	[PlayTime] [smallint] NULL,
	[RegDate] [smalldatetime] NULL,
	[Date] [smalldatetime] NULL,
 CONSTRAINT [PKC_Rank_SpaceTime_Day_UnitUID] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
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
IF OBJECT_ID(N'[dbo].[TR_UserID]', N'U') IS NULL
CREATE TABLE [dbo].[TR_UserID](
	[UnitUID] [bigint] NULL,
	[OldGamePoint] [int] NULL,
	[GamePoint] [int] NULL,
	[UpdateDate] [smalldatetime] NULL,
	[UpdateID] [nvarchar](50) NULL,
	[HostName] [nvarchar](50) NULL,
	[SysUser] [nvarchar](50) NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[TempNoteItemID]', N'U') IS NULL
CREATE TABLE [dbo].[TempNoteItemID](
	[ItemID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[TempItemList]', N'U') IS NULL
CREATE TABLE [dbo].[TempItemList](
	[UnitUID] [bigint] NULL,
	[ItemCount] [int] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[Temp_SCL]', N'U') IS NULL
CREATE TABLE [dbo].[Temp_SCL](
	[RowNumber] [int] IDENTITY(0,1) NOT NULL,
	[EventClass] [int] NULL,
	[TextData] [nvarchar](max) NULL,
	[ApplicationName] [nvarchar](128) NULL,
	[NTUserName] [nvarchar](128) NULL,
	[LoginName] [nvarchar](128) NULL,
	[CPU] [int] NULL,
	[Reads] [bigint] NULL,
	[Writes] [bigint] NULL,
	[Duration] [bigint] NULL,
	[ClientProcessID] [int] NULL,
	[SPID] [int] NULL,
	[StartTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[BinaryData] [varbinary](max) NULL,
	[DatabaseID] [int] NULL,
	[DatabaseName] [nvarchar](128) NULL,
	[Error] [int] NULL,
	[EventSequence] [bigint] NULL,
	[HostName] [nvarchar](128) NULL,
	[IsSystem] [int] NULL,
	[LoginSid] [varbinary](max) NULL,
	[NTDomainName] [nvarchar](128) NULL,
	[ObjectName] [nvarchar](128) NULL,
	[RequestID] [int] NULL,
	[RowCounts] [bigint] NULL,
	[ServerName] [nvarchar](128) NULL,
	[SessionLoginName] [nvarchar](128) NULL,
	[TransactionID] [bigint] NULL,
	[XactSequence] [bigint] NULL,
 CONSTRAINT [PK_Temp_SCL_RowNumber] PRIMARY KEY CLUSTERED 
(
	[RowNumber] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GCouple_WeddingInvitation]', N'U') IS NULL
CREATE TABLE [dbo].[GCouple_WeddingInvitation](
	[ItemUID] [bigint] NOT NULL,
	[WeddingUID] [int] NOT NULL,
 CONSTRAINT [PKC_GCouple_WeddingInvitation_ItemUID] PRIMARY KEY CLUSTERED 
(
	[ItemUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GCouple_WeddingInfo]', N'U') IS NULL
CREATE TABLE [dbo].[GCouple_WeddingInfo](
	[WeddingUID] [int] IDENTITY(1,1) NOT NULL,
	[GroomUID] [bigint] NOT NULL,
	[BrideUID] [bigint] NOT NULL,
	[WeddingHallType] [tinyint] NOT NULL,
	[WeddingNPC] [tinyint] NOT NULL,
	[WeddingDate] [smalldatetime] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL,
	[WeddingCheck] [bit] NOT NULL,
	[WeddingMessage] [nvarchar](80) NULL,
 CONSTRAINT [PKC_GCouple_WeddingInfo_WeddingUID] PRIMARY KEY CLUSTERED 
(
	[WeddingUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GCouple_Info]', N'U') IS NULL
CREATE TABLE [dbo].[GCouple_Info](
	[UnitUID] [bigint] NOT NULL,
	[PartnerUID] [bigint] NOT NULL,
	[LoveWord] [nvarchar](20) NULL,
	[CoupleType] [tinyint] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL,
	[LastLogOffDate] [smalldatetime] NOT NULL,
	[LastRewardDate] [smalldatetime] NOT NULL,
	[TitleRewardLv] [tinyint] NOT NULL,
 CONSTRAINT [PKC_GCouple_Info_UnitUID] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GCoolTime]', N'U') IS NULL
CREATE TABLE [dbo].[GCoolTime](
	[UnitUID] [bigint] NOT NULL,
	[CoolType] [tinyint] NOT NULL,
	[CoolID] [int] NOT NULL,
	[CoolTime] [int] NOT NULL,
 CONSTRAINT [PKC_GCoolTime_UnitUID_CoolType_CoolID] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC,
	[CoolType] ASC,
	[CoolID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GCharacter_Count]', N'U') IS NULL
CREATE TABLE [dbo].[GCharacter_Count](
	[UnitUID] [bigint] NOT NULL,
	[LogType] [smallint] NOT NULL,
	[Count] [int] NULL,
 CONSTRAINT [PKC_Character_Count_UnitUID_Type] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC,
	[LogType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GCBTEventData_NickName]', N'U') IS NULL
CREATE TABLE [dbo].[GCBTEventData_NickName](
	[NickName] [nvarchar](200) NOT NULL,
	[UserID] [nvarchar](200) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[NickName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GCBTEventData_Item]', N'U') IS NULL
CREATE TABLE [dbo].[GCBTEventData_Item](
	[UserID] [nvarchar](200) NOT NULL,
	[HaveItem] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GBuffeffect]', N'U') IS NULL
CREATE TABLE [dbo].[GBuffeffect](
	[UnitUID] [bigint] NOT NULL,
	[BuffID] [int] NOT NULL,
	[UseDate] [datetime] NOT NULL,
 CONSTRAINT [PKC_GDarkGate_Itemeffect_UnitUID_ItemType] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC,
	[BuffID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GBlacklist]', N'U') IS NULL
CREATE TABLE [dbo].[GBlacklist](
	[MyUID] [bigint] NOT NULL,
	[BlockUID] [bigint] NOT NULL,
 CONSTRAINT [PKC_GBlacklist_MyUID_BlockUID] PRIMARY KEY CLUSTERED 
(
	[MyUID] ASC,
	[BlockUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GBase_Item]', N'U') IS NULL
CREATE TABLE [dbo].[GBase_Item](
	[UnitClass] [tinyint] NULL,
	[ItemID] [int] NOT NULL,
	[InventoryCategory] [tinyint] NULL,
	[SlotID] [tinyint] NULL,
	[UsageType] [tinyint] NULL,
	[Quantity] [int] NULL,
	[Endurance] [int] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GBankShare]', N'U') IS NULL
CREATE TABLE [dbo].[GBankShare](
	[UserUID] [bigint] NOT NULL,
	[UnitUID] [bigint] NOT NULL,
	[sRoute] [tinyint] NOT NULL,
	[sOnOff] [bit] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_GBankShare_UsreUID] PRIMARY KEY CLUSTERED 
(
	[UserUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GAdvertisementEvent]', N'U') IS NULL
CREATE TABLE [dbo].[GAdvertisementEvent](
	[UserUID] [bigint] NOT NULL,
	[EventUID] [int] NOT NULL,
	[RegDate] [smalldatetime] NULL,
 CONSTRAINT [PKC_GAdvertisementEvent] PRIMARY KEY CLUSTERED 
(
	[UserUID] ASC,
	[EventUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GVIPTicket]', N'U') IS NULL
CREATE TABLE [dbo].[GVIPTicket](
	[UnitUID] [bigint] NOT NULL,
	[Period] [int] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL,
	[ExpireDate] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_GVIPTicket] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GUser]', N'U') IS NULL
CREATE TABLE [dbo].[GUser](
	[UserUID] [bigint] NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[USSize] [tinyint] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL,
	[DelDate] [smalldatetime] NOT NULL,
	[Deleted]  AS (case [RegDate] when [DelDate] then (0) else (1) end),
 CONSTRAINT [PK_GUser_UserUID] PRIMARY KEY NONCLUSTERED 
(
	[UserUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GUnitWaitDelete]', N'U') IS NULL
CREATE TABLE [dbo].[GUnitWaitDelete](
	[UnitUID] [bigint] NOT NULL,
	[DelDate] [smalldatetime] NOT NULL,
	[DelAbleDate] [smalldatetime] NOT NULL,
	[RestoreAbleDate] [smalldatetime] NOT NULL,
	[Deleted] [tinyint] NOT NULL,
 CONSTRAINT [PK_GUnitWaitDelete] PRIMARY KEY NONCLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GUnitRestore]', N'U') IS NULL
CREATE TABLE [dbo].[GUnitRestore](
	[LogUID] [bigint] IDENTITY(1,1) NOT NULL,
	[UnitUID] [bigint] NOT NULL,
	[DelDate] [smalldatetime] NOT NULL,
	[RestoreDate] [smalldatetime] NOT NULL,
	[ReDelAbleDate] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_GUnitRestore] PRIMARY KEY CLUSTERED 
(
	[LogUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GUnitPVPTag]', N'U') IS NULL
CREATE TABLE [dbo].[GUnitPVPTag](
	[UnitUID] [bigint] NOT NULL,
	[Win] [int] NOT NULL,
	[Lose] [int] NOT NULL,
	[Point] [int] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_GUnitPVPTag] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GUnitPVP_Season2]', N'U') IS NULL
CREATE TABLE [dbo].[GUnitPVP_Season2](
	[UnitUID] [bigint] NOT NULL,
	[OfficialMatchCnt] [int] NOT NULL,
	[Rating] [int] NOT NULL,
	[MaxRating] [int] NOT NULL,
	[RPoint] [int] NOT NULL,
	[APoint] [int] NOT NULL,
	[IsWinBeforeMatch] [bit] NOT NULL,
	[Grade] [tinyint] NOT NULL,
	[win] [int] NOT NULL,
	[lose] [int] NOT NULL,
	[KFactor] [int] NOT NULL,
	[IsRedistribution] [bit] NOT NULL,
	[PastSeasonWin] [int] NOT NULL,
 CONSTRAINT [PKC_GUnitPVP_Season2_UnitUID] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GUnitPVP]', N'U') IS NULL
CREATE TABLE [dbo].[GUnitPVP](
	[UnitUID] [bigint] NOT NULL,
	[OfficialMatchCnt] [int] NULL,
	[Rating] [int] NULL,
	[MaxRating] [int] NULL,
	[RPoint] [int] NULL,
	[APoint] [int] NULL,
	[IsWinBeforeMatch] [bit] NULL,
	[Grade] [tinyint] NOT NULL,
	[win] [int] NULL,
	[lose] [int] NULL,
 CONSTRAINT [PK_GUnitPVP_UnitUID] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GUnitPlayInfo]', N'U') IS NULL
CREATE TABLE [dbo].[GUnitPlayInfo](
	[UnitUID] [bigint] NOT NULL,
	[MaxHP] [int] NOT NULL,
	[CurHP] [int] NOT NULL,
	[MaxMP] [int] NOT NULL,
	[CurMP] [int] NOT NULL,
	[CurHyperGage] [int] NOT NULL,
	[CharAbilCNT] [int] NOT NULL,
 CONSTRAINT [PKC_GUnitPlayInfo_UnitUID] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GUnitNickName]', N'U') IS NULL
CREATE TABLE [dbo].[GUnitNickName](
	[UnitUID] [bigint] NOT NULL,
	[NickName] [nvarchar](26) NULL,
	[RegDate] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_GUnitNickName_UnitUID] PRIMARY KEY NONCLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GUnitLastPosition]', N'U') IS NULL
CREATE TABLE [dbo].[GUnitLastPosition](
	[UnitUID] [bigint] NOT NULL,
	[MapID] [int] NOT NULL,
	[LastLineIndex] [smallint] NOT NULL,
	[LastPosValue] [smallint] NOT NULL,
 CONSTRAINT [PKC_GUnitLastPosition_UnitUID] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GUnitClassChangeStage]', N'U') IS NULL
CREATE TABLE [dbo].[GUnitClassChangeStage](
	[UnitUID] [bigint] NOT NULL,
	[OldID] [int] NOT NULL,
	[NewID] [int] NOT NULL,
	[SPNo] [tinyint] NOT NULL,
	[RegDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GUnit_LastPoint]', N'U') IS NULL
CREATE TABLE [dbo].[GUnit_LastPoint](
	[UnitUID] [bigint] NOT NULL,
	[Gamepoint] [int] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_UnitUID_GUnit_LastPoint] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GUnit_ED]', N'U') IS NULL
CREATE TABLE [dbo].[GUnit_ED](
	[UnitUID] [bigint] NOT NULL,
	[Gamepoint] [int] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GUnit_BackUP]', N'U') IS NULL
CREATE TABLE [dbo].[GUnit_BackUP](
	[UnitUID] [bigint] IDENTITY(1,1) NOT NULL,
	[Level] [tinyint] NOT NULL,
	[EXP] [int] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GUnit]', N'U') IS NULL
CREATE TABLE [dbo].[GUnit](
	[UnitUID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserUID] [bigint] NOT NULL,
	[UnitClass] [tinyint] NOT NULL,
	[Exp] [int] NOT NULL,
	[Level] [tinyint] NOT NULL,
	[GamePoint] [int] NOT NULL,
	[BaseHP] [smallint] NOT NULL,
	[AtkPhysic] [tinyint] NOT NULL,
	[AtkMagic] [tinyint] NOT NULL,
	[DefPhysic] [tinyint] NOT NULL,
	[DefMagic] [tinyint] NOT NULL,
	[SPoint] [int] NOT NULL,
	[Seceder] [int] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL,
	[DelDate] [smalldatetime] NOT NULL,
	[LastDate] [smalldatetime] NOT NULL,
	[LastPosition] [int] NOT NULL,
	[PlayDayCnt] [int] NOT NULL,
	[LoginCount] [int] NOT NULL,
	[Deleted]  AS (case [RegDate] when [DelDate] then (0) else (1) end),
 CONSTRAINT [PK_GUnit_UnitUID] PRIMARY KEY NONCLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GTutor]', N'U') IS NULL
CREATE TABLE [dbo].[GTutor](
	[TeacherUID] [bigint] NOT NULL,
	[StudentUID] [bigint] NOT NULL,
	[RegDate] [smalldatetime] NULL,
	[LastDate] [smalldatetime] NULL,
	[DelDate] [smalldatetime] NULL,
	[Deleted]  AS (case [RegDate] when [DelDate] then (0) else (1) end)
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GTrainingCenter]', N'U') IS NULL
CREATE TABLE [dbo].[GTrainingCenter](
	[UnitUID] [bigint] NOT NULL,
	[TCID] [int] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL,
 CONSTRAINT [PKC_GTrainingCenter_UnitUID_TCID] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC,
	[TCID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GTitle_Mission]', N'U') IS NULL
CREATE TABLE [dbo].[GTitle_Mission](
	[UnitUID] [bigint] NOT NULL,
	[TitleID] [int] NOT NULL,
	[SubMission1] [smallint] NULL,
	[SubMission2] [smallint] NULL,
	[SubMission3] [smallint] NULL,
	[SubMission4] [smallint] NULL,
	[SubMission5] [smallint] NULL,
 CONSTRAINT [PKC_GTitle_Mission_UnitUID_TitleID] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC,
	[TitleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GTitle_Complete]', N'U') IS NULL
CREATE TABLE [dbo].[GTitle_Complete](
	[UnitUID] [bigint] NOT NULL,
	[TitleID] [int] NOT NULL,
	[EndDate] [smalldatetime] NULL,
	[IsHang] [bit] NULL,
 CONSTRAINT [PKC_GTitle_Complete_UnitUID_TitleID] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC,
	[TitleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GTempEventChar]', N'U') IS NULL
CREATE TABLE [dbo].[GTempEventChar](
	[UserUID] [bigint] NOT NULL,
	[UnituID] [bigint] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GTempEvent]', N'U') IS NULL
CREATE TABLE [dbo].[GTempEvent](
	[UserID] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GSpirit]', N'U') IS NULL
CREATE TABLE [dbo].[GSpirit](
	[unitUID] [bigint] NOT NULL,
	[Spirit] [smallint] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL,
	[Flag] [bit] NOT NULL,
 CONSTRAINT [PKC_GSpirit_unitUID] PRIMARY KEY CLUSTERED 
(
	[unitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GSkillSlot2_New]', N'U') IS NULL
CREATE TABLE [dbo].[GSkillSlot2_New](
	[UnitUID] [bigint] NOT NULL,
	[Slot01] [smallint] NULL,
	[Slot02] [smallint] NULL,
	[Slot03] [smallint] NULL,
	[Slot04] [smallint] NULL,
	[EndDate] [smalldatetime] NULL,
 CONSTRAINT [PKC_GSkillSlot2_New_UnitUID] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GSkillSlot2]', N'U') IS NULL
CREATE TABLE [dbo].[GSkillSlot2](
	[UnitUID] [bigint] NOT NULL,
	[Slot01] [int] NOT NULL,
	[Slot02] [int] NOT NULL,
	[Slot03] [int] NOT NULL,
	[EndDate] [smalldatetime] NULL,
 CONSTRAINT [PK_GSkillSlot2_UnitUID] PRIMARY KEY NONCLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GSkillSlot_New]', N'U') IS NULL
CREATE TABLE [dbo].[GSkillSlot_New](
	[UnitUID] [bigint] NOT NULL,
	[Slot01] [smallint] NULL,
	[Slot02] [smallint] NULL,
	[Slot03] [smallint] NULL,
	[Slot04] [smallint] NULL,
 CONSTRAINT [PKC_GSkillSlot_New_UnitUID] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GSkillSlot]', N'U') IS NULL
CREATE TABLE [dbo].[GSkillSlot](
	[UnitUID] [bigint] NOT NULL,
	[Slot01] [int] NOT NULL,
	[Slot02] [int] NOT NULL,
	[Slot03] [int] NOT NULL,
 CONSTRAINT [PK_GSkillSlot] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GSkillCode]', N'U') IS NULL
CREATE TABLE [dbo].[GSkillCode](
	[Code] [int] NOT NULL,
	[Name] [nvarchar](255) NULL,
 CONSTRAINT [PKC_GSkillCode_Code] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GSkill_Unsealed]', N'U') IS NULL
CREATE TABLE [dbo].[GSkill_Unsealed](
	[UnitUID] [bigint] NOT NULL,
	[SkillID] [smallint] NOT NULL,
	[RegDate] [smalldatetime] NULL,
 CONSTRAINT [PKC_GSkill_Unsealed_UnitUID] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC,
	[SkillID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GSKill_New]', N'U') IS NULL
CREATE TABLE [dbo].[GSKill_New](
	[UnitUID] [bigint] NOT NULL,
	[SkillID] [smallint] NOT NULL,
	[Level] [tinyint] NULL,
	[CSP] [tinyint] NULL,
	[Deleted]  AS (case [Level] when (0) then (1) else (0) end),
 CONSTRAINT [PKC_GSkill_New_UnitUID] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC,
	[SkillID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GSkill_Default]', N'U') IS NULL
CREATE TABLE [dbo].[GSkill_Default](
	[UnitClass] [smallint] NULL,
	[SkillID] [int] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GSkill_Cash]', N'U') IS NULL
CREATE TABLE [dbo].[GSkill_Cash](
	[UnitUID] [bigint] NOT NULL,
	[CsPoint] [int] NULL,
	[MaxCsP] [int] NULL,
	[Period] [tinyint] NULL,
	[EndDate] [smalldatetime] NULL,
 CONSTRAINT [PKC_GSkill_Cash_UnitUID] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GSkill_BeforeList]', N'U') IS NULL
CREATE TABLE [dbo].[GSkill_BeforeList](
	[UnitUID] [bigint] NULL,
	[SkillID] [smallint] NULL,
	[Level] [tinyint] NULL,
	[CSP] [tinyint] NULL,
	[RegDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GSkill]', N'U') IS NULL
CREATE TABLE [dbo].[GSkill](
	[UnitUID] [bigint] NOT NULL,
	[SkillID] [int] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_GSkill] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC,
	[SkillID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GRiding]', N'U') IS NULL
CREATE TABLE [dbo].[GRiding](
	[RidingUID] [bigint] IDENTITY(1,1) NOT NULL,
	[UnitUID] [bigint] NOT NULL,
	[RidingID] [smallint] NOT NULL,
	[RidingStamina] [smallint] NOT NULL,
	[Period] [int] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL,
	[DelDate] [smalldatetime] NULL,
	[LastDate] [datetime] NOT NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_GRiding_RidingUID] PRIMARY KEY NONCLUSTERED 
(
	[RidingUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GResurrectionStoneCnt]', N'U') IS NULL
CREATE TABLE [dbo].[GResurrectionStoneCnt](
	[StartCnt] [smallint] NULL,
	[SupplyCnt] [smallint] NULL,
	[StartSpirit] [smallint] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GResurrectionStone_AutoPay]', N'U') IS NULL
CREATE TABLE [dbo].[GResurrectionStone_AutoPay](
	[UnitUID] [bigint] NOT NULL,
	[Quantity] [tinyint] NULL,
	[LastRefill] [smalldatetime] NULL,
 CONSTRAINT [PKC_GResurrectionStone_AutoPay_UnitUID] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GResurrectionStone]', N'U') IS NULL
CREATE TABLE [dbo].[GResurrectionStone](
	[UnitUID] [bigint] NOT NULL,
	[Quantity] [smallint] NOT NULL,
 CONSTRAINT [PK_GResurrectionStone] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GRemainTime]', N'U') IS NULL
CREATE TABLE [dbo].[GRemainTime](
	[UnitUID] [bigint] NULL,
	[EventID] [smallint] NULL,
	[RemainTime] [smallint] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GRecommend_Count]', N'U') IS NULL
CREATE TABLE [dbo].[GRecommend_Count](
	[UnitUID] [bigint] NOT NULL,
	[RecommendCount] [int] NOT NULL,
 CONSTRAINT [PKC_GRecommend_Count_UnitUID] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GRecommend]', N'U') IS NULL
CREATE TABLE [dbo].[GRecommend](
	[OldUID] [bigint] NOT NULL,
	[NewUID] [bigint] NOT NULL,
	[RegDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GRank_Except]', N'U') IS NULL
CREATE TABLE [dbo].[GRank_Except](
	[UserUID] [bigint] NOT NULL,
 CONSTRAINT [PKC_GRank_Except_UserUID] PRIMARY KEY CLUSTERED 
(
	[UserUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GRank_Arcade_Server]', N'U') IS NULL
CREATE TABLE [dbo].[GRank_Arcade_Server](
	[Rank] [tinyint] NULL,
	[GameMode] [int] NULL,
	[StageCnt] [tinyint] NULL,
	[PlayTime] [int] NULL,
	[RegDate] [smalldatetime] NULL,
	[Unit1] [nvarchar](16) NULL,
	[Unit2] [nvarchar](16) NULL,
	[Unit3] [nvarchar](16) NULL,
	[Unit4] [nvarchar](16) NULL,
	[UnitUID1] [bigint] NULL,
	[UnitUID2] [bigint] NULL,
	[UnitUID3] [bigint] NULL,
	[UnitUID4] [bigint] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GRank_Arcade]', N'U') IS NULL
CREATE TABLE [dbo].[GRank_Arcade](
	[UnitUID] [bigint] NULL,
	[GameMode] [int] NULL,
	[StageCnt] [tinyint] NULL,
	[PlayTime] [int] NULL,
	[RegDate] [smalldatetime] NULL,
	[Unit1] [nvarchar](16) NULL,
	[Unit2] [nvarchar](16) NULL,
	[Unit3] [nvarchar](16) NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GRank]', N'U') IS NULL
CREATE TABLE [dbo].[GRank](
	[VsRank] [bigint] NOT NULL,
	[ExpRank] [bigint] NOT NULL,
	[ClassVsRank] [bigint] NOT NULL,
	[ClassExpRank] [bigint] NOT NULL,
	[UnitUID] [bigint] NOT NULL,
	[NickName] [nvarchar](24) NOT NULL,
	[Win] [bigint] NOT NULL,
	[Level] [smallint] NOT NULL,
	[Exp] [bigint] NOT NULL,
	[UnitClass] [smallint] NOT NULL,
	[Grade] [tinyint] NOT NULL,
	[RPoint] [int] NOT NULL,
	[OfficialMatchCnt] [int] NOT NULL,
	[UClass] [tinyint] NOT NULL,
	[RegDate] [char](10) NOT NULL,
 CONSTRAINT [PKC_GRank] PRIMARY KEY NONCLUSTERED 
(
	[RegDate] ASC,
	[VsRank] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GQuests_Repeat]', N'U') IS NULL
CREATE TABLE [dbo].[GQuests_Repeat](
	[UnitUID] [bigint] NOT NULL,
	[QuestID] [int] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL,
	[CompleteDate] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GQuests_Complete]', N'U') IS NULL
CREATE TABLE [dbo].[GQuests_Complete](
	[UnitUID] [bigint] NOT NULL,
	[QuestID] [int] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL,
	[CompleteDate] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_GQuests_Complete] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC,
	[QuestID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GQuests]', N'U') IS NULL
CREATE TABLE [dbo].[GQuests](
	[UnitUID] [bigint] NOT NULL,
	[QuestID] [int] NOT NULL,
	[SubQuest0] [tinyint] NOT NULL,
	[SubQuest1] [tinyint] NOT NULL,
	[SubQuest2] [tinyint] NOT NULL,
	[SubQuest3] [tinyint] NOT NULL,
	[SubQuest4] [tinyint] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_GQuests] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC,
	[QuestID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GQuestCode]', N'U') IS NULL
CREATE TABLE [dbo].[GQuestCode](
	[Code] [int] NOT NULL,
	[Name] [nvarchar](255) NULL,
 CONSTRAINT [PK_GQuestCode] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GPShopItemSocket]', N'U') IS NULL
CREATE TABLE [dbo].[GPShopItemSocket](
	[ItemUID] [bigint] NOT NULL,
	[UnitUID] [bigint] NOT NULL,
	[Socket1] [int] NOT NULL,
	[Socket2] [int] NOT NULL,
	[Socket3] [int] NOT NULL,
	[Socket4] [int] NOT NULL,
 CONSTRAINT [PK_GPShopItemSocket] PRIMARY KEY NONCLUSTERED 
(
	[ItemUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GPShopItem]', N'U') IS NULL
CREATE TABLE [dbo].[GPShopItem](
	[ItemUID] [bigint] IDENTITY(1,1) NOT NULL,
	[UnitUID] [bigint] NOT NULL,
	[ItemID] [int] NOT NULL,
	[UsageType] [tinyint] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Endurance] [int] NOT NULL,
	[SealCnt] [tinyint] NOT NULL,
	[ELevel] [smallint] NOT NULL,
	[Attribute1] [tinyint] NOT NULL,
	[Attribute2] [tinyint] NOT NULL,
	[Attribute3] [tinyint] NOT NULL,
	[Socket1] [int] NOT NULL,
	[Socket2] [int] NOT NULL,
	[Socket3] [int] NOT NULL,
	[Socket4] [int] NOT NULL,
	[PricePerOne] [int] NOT NULL,
	[FeePerOne] [int] NOT NULL,
	[TotalSellEDIn] [int] NOT NULL,
	[TotalSoldItemQuantity] [int] NOT NULL,
	[TotalSellCommissionED] [int] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL,
	[DelDate] [smalldatetime] NOT NULL,
	[Deleted] [tinyint] NOT NULL,
	[OldItemUID] [bigint] NOT NULL,
	[Category] [tinyint] NULL,
	[SocketR1] [int] NULL,
	[SocketR2] [int] NULL,
	[SocketR3] [int] NULL,
	[SocketR4] [int] NULL,
	[SocketR5] [int] NULL,
 CONSTRAINT [PK_GPShop_Item_ItemUID] PRIMARY KEY NONCLUSTERED 
(
	[ItemUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GPShopInfo]', N'U') IS NULL
CREATE TABLE [dbo].[GPShopInfo](
	[UserUID] [bigint] NOT NULL,
	[UnitUID] [bigint] NOT NULL,
	[IsPShopOpen] [bit] NOT NULL,
	[ShopType] [tinyint] NOT NULL,
	[PShopName] [nvarchar](50) NOT NULL,
	[BeginDate] [smalldatetime] NOT NULL,
	[ExpirationDate] [smalldatetime] NOT NULL,
	[On_Off] [bit] NOT NULL,
 CONSTRAINT [PK_PShopInfo_UnitUID] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GPost_Wedding]', N'U') IS NULL
CREATE TABLE [dbo].[GPost_Wedding](
	[PostNo] [bigint] NOT NULL,
	[WeddingUID] [int] NOT NULL,
 CONSTRAINT [PKC_GPost_Wedding_PostNo] PRIMARY KEY CLUSTERED 
(
	[PostNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GPost_Socket_Random]', N'U') IS NULL
CREATE TABLE [dbo].[GPost_Socket_Random](
	[PostNo] [bigint] NOT NULL,
	[Socket1] [int] NOT NULL,
	[Socket2] [int] NOT NULL,
	[Socket3] [int] NOT NULL,
	[Socket4] [int] NOT NULL,
	[Socket5] [int] NOT NULL,
 CONSTRAINT [PKC_GPost_Socket_Random_PostNo] PRIMARY KEY CLUSTERED 
(
	[PostNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GPost_Socket]', N'U') IS NULL
CREATE TABLE [dbo].[GPost_Socket](
	[PostNo] [bigint] NOT NULL,
	[Socket1] [int] NOT NULL,
	[Socket2] [int] NOT NULL,
	[Socket3] [int] NOT NULL,
	[Socket4] [int] NOT NULL,
 CONSTRAINT [PKC_GPost_Socket_PostNo] PRIMARY KEY CLUSTERED 
(
	[PostNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GPost_Seal]', N'U') IS NULL
CREATE TABLE [dbo].[GPost_Seal](
	[PostNo] [bigint] NOT NULL,
	[SealCnt] [tinyint] NULL,
 CONSTRAINT [PKC_GPost_Seal_PostNo] PRIMARY KEY CLUSTERED 
(
	[PostNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GPost_Period]', N'U') IS NULL
CREATE TABLE [dbo].[GPost_Period](
	[PostNo] [bigint] NOT NULL,
	[Period] [tinyint] NULL,
 CONSTRAINT [PKC_GPost_Period_PostNo] PRIMARY KEY CLUSTERED 
(
	[PostNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GPost_Enchant]', N'U') IS NULL
CREATE TABLE [dbo].[GPost_Enchant](
	[PostNo] [bigint] NOT NULL,
	[ELevel] [tinyint] NULL,
 CONSTRAINT [PKC_GPost_Enchant_PostNo] PRIMARY KEY CLUSTERED 
(
	[PostNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GPost_BlackList]', N'U') IS NULL
CREATE TABLE [dbo].[GPost_BlackList](
	[MyUID] [bigint] NULL,
	[BlockUID] [bigint] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GPost_Attribute]', N'U') IS NULL
CREATE TABLE [dbo].[GPost_Attribute](
	[PostNo] [bigint] NOT NULL,
	[Attribute1] [tinyint] NULL,
	[Attribute2] [tinyint] NULL,
	[Attribute3] [tinyint] NOT NULL,
 CONSTRAINT [PKC_GPost_Attribute_PostNo] PRIMARY KEY CLUSTERED 
(
	[PostNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GPost]', N'U') IS NULL
CREATE TABLE [dbo].[GPost](
	[PostNo] [bigint] IDENTITY(1,1) NOT NULL,
	[FromUnitUID] [bigint] NOT NULL,
	[ToUnitUID] [bigint] NOT NULL,
	[Quantity] [int] NOT NULL,
	[ScType] [tinyint] NOT NULL,
	[ScIndex] [bigint] NOT NULL,
	[RegDate] [smalldatetime] NULL,
	[DelDate] [smalldatetime] NULL,
	[IsReceive] [bit] NULL,
	[IsRead] [bit] NULL,
	[Deleted]  AS (case [RegDate] when [DelDate] then (0) else (1) end),
	[Title] [nvarchar](38) NULL,
	[Message] [nvarchar](800) NULL,
 CONSTRAINT [PK_GPost] PRIMARY KEY NONCLUSTERED 
(
	[PostNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GPetNameChangeLog]', N'U') IS NULL
CREATE TABLE [dbo].[GPetNameChangeLog](
	[PetUID] [bigint] NOT NULL,
	[OldPetName] [nvarchar](16) NOT NULL,
	[NewPetName] [nvarchar](16) NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GPet_Info]', N'U') IS NULL
CREATE TABLE [dbo].[GPet_Info](
	[PetUID] [bigint] IDENTITY(1,1) NOT NULL,
	[UnitUID] [bigint] NOT NULL,
	[PetID] [int] NOT NULL,
	[PetName] [nvarchar](16) NOT NULL,
	[EvolutionStep] [tinyint] NOT NULL,
	[Satiety] [smallint] NOT NULL,
	[Intimacy] [int] NOT NULL,
	[Extroversion] [smallint] NOT NULL,
	[Emotion] [smallint] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL,
	[DelDate] [smalldatetime] NOT NULL,
	[IsCall] [bit] NOT NULL,
	[AutoFeed] [bit] NOT NULL,
	[LastFeedDate] [smalldatetime] NOT NULL,
	[LastcallDate] [smalldatetime] NULL,
	[PickUP] [bit] NULL,
 CONSTRAINT [PKC_GPet_Info_PetUID] PRIMARY KEY CLUSTERED 
(
	[PetUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GPatchItem]', N'U') IS NULL
CREATE TABLE [dbo].[GPatchItem](
	[ItemID] [int] NULL,
	[ItemType] [tinyint] NULL,
	[UnitClass] [tinyint] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GNote_PageCNT]', N'U') IS NULL
CREATE TABLE [dbo].[GNote_PageCNT](
	[UnitUID] [bigint] NOT NULL,
	[MaxPage] [tinyint] NULL,
 CONSTRAINT [PKC_GNote_PageCNT_UnitUID] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GNote]', N'U') IS NULL
CREATE TABLE [dbo].[GNote](
	[UnitUID] [bigint] NULL,
	[ItemID] [int] NULL,
	[PageNo] [tinyint] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GLevel_SPoint]', N'U') IS NULL
CREATE TABLE [dbo].[GLevel_SPoint](
	[Level] [smallint] NULL,
	[Spoint] [int] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GItemWishList]', N'U') IS NULL
CREATE TABLE [dbo].[GItemWishList](
	[UserUID] [bigint] NOT NULL,
	[SlotNo] [smallint] NOT NULL,
	[ItemID] [int] NULL,
 CONSTRAINT [PK_GItemWishList_UserUID] PRIMARY KEY CLUSTERED 
(
	[UserUID] ASC,
	[SlotNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GItemSocket_Random]', N'U') IS NULL
CREATE TABLE [dbo].[GItemSocket_Random](
	[ItemUID] [bigint] NOT NULL,
	[Socket1] [int] NOT NULL,
	[Socket2] [int] NOT NULL,
	[Socket3] [int] NOT NULL,
	[Socket4] [int] NOT NULL,
	[Socket5] [int] NOT NULL,
	[UnitUID] [bigint] NOT NULL,
 CONSTRAINT [PK_GItemSocket_Random_ItemUID] PRIMARY KEY NONCLUSTERED 
(
	[ItemUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GItemSocket]', N'U') IS NULL
CREATE TABLE [dbo].[GItemSocket](
	[ItemUID] [bigint] NOT NULL,
	[Socket1] [int] NOT NULL,
	[Socket2] [int] NOT NULL,
	[Socket3] [int] NOT NULL,
	[Socket4] [int] NOT NULL,
	[UnitUID] [bigint] NOT NULL,
 CONSTRAINT [PK_GItemSocket_ItemUID] PRIMARY KEY NONCLUSTERED 
(
	[ItemUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GItemSeal]', N'U') IS NULL
CREATE TABLE [dbo].[GItemSeal](
	[ItemUID] [bigint] NOT NULL,
	[SealCnt] [tinyint] NULL,
 CONSTRAINT [PKC_GItemSeal_ItemUID] PRIMARY KEY CLUSTERED 
(
	[ItemUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GItemPeriod]', N'U') IS NULL
CREATE TABLE [dbo].[GItemPeriod](
	[ItemUID] [bigint] NOT NULL,
	[Period] [smallint] NOT NULL,
	[ExpirationDate] [smalldatetime] NOT NULL,
	[UnitUID] [bigint] NOT NULL,
 CONSTRAINT [PK_GItemPeriod_ItemUID] PRIMARY KEY NONCLUSTERED 
(
	[ItemUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GItemInventorySize]', N'U') IS NULL
CREATE TABLE [dbo].[GItemInventorySize](
	[UnitUID] [bigint] NOT NULL,
	[InventoryCategory] [tinyint] NOT NULL,
	[NumSlot] [tinyint] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GItemInsertType]', N'U') IS NULL
CREATE TABLE [dbo].[GItemInsertType](
	[ItemUID] [bigint] NOT NULL,
	[InsertType] [tinyint] NOT NULL,
 CONSTRAINT [PKC_ItemUID_GItemInsertType] PRIMARY KEY CLUSTERED 
(
	[ItemUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GItemEndurance]', N'U') IS NULL
CREATE TABLE [dbo].[GItemEndurance](
	[ItemUID] [bigint] NOT NULL,
	[Endurance] [int] NOT NULL,
	[UnitUID] [bigint] NULL,
 CONSTRAINT [PKC_GItemEndurance_ItemUID] PRIMARY KEY NONCLUSTERED 
(
	[ItemUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GItemEnchant]', N'U') IS NULL
CREATE TABLE [dbo].[GItemEnchant](
	[ItemUID] [bigint] NOT NULL,
	[ELevel] [smallint] NOT NULL,
	[UnitUID] [bigint] NOT NULL,
 CONSTRAINT [PK_GItemEnchant_ItemUID] PRIMARY KEY NONCLUSTERED 
(
	[ItemUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GItemCode]', N'U') IS NULL
CREATE TABLE [dbo].[GItemCode](
	[ItemCode] [int] NOT NULL,
	[ItemName] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[Period] [int] NOT NULL,
	[Endurance] [int] NOT NULL,
 CONSTRAINT [PK_GItemCode_ItemCode] PRIMARY KEY CLUSTERED 
(
	[ItemCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GItemAttribute]', N'U') IS NULL
CREATE TABLE [dbo].[GItemAttribute](
	[ItemUID] [bigint] NOT NULL,
	[SlotNo] [tinyint] NOT NULL,
	[Attribute] [tinyint] NOT NULL,
	[UnitUID] [bigint] NOT NULL,
 CONSTRAINT [PK_GItemAttribute_ItemUID_SlotNo] PRIMARY KEY NONCLUSTERED 
(
	[ItemUID] ASC,
	[SlotNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GItem_Pet]', N'U') IS NULL
CREATE TABLE [dbo].[GItem_Pet](
	[UnitUID] [bigint] NOT NULL,
	[ItemUID] [bigint] NOT NULL,
	[PetUID] [bigint] NOT NULL,
 CONSTRAINT [PK_GItem_Pet] PRIMARY KEY NONCLUSTERED 
(
	[UnitUID] ASC,
	[ItemUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GItem_Log]', N'U') IS NULL
CREATE TABLE [dbo].[GItem_Log](
	[ItemUID] [bigint] NOT NULL,
	[UnitUID] [bigint] NOT NULL,
	[ItemID] [int] NOT NULL,
	[InventoryCategory] [tinyint] NOT NULL,
	[SlotID] [tinyint] NOT NULL,
	[UsageType] [tinyint] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Endurance] [int] NOT NULL,
	[Inserted] [tinyint] NULL,
	[RegDate] [smalldatetime] NOT NULL,
	[DelDate] [datetime] NOT NULL,
	[Deleted] [tinyint] NOT NULL,
 CONSTRAINT [PK_GItem_Log_ItemUID] PRIMARY KEY NONCLUSTERED 
(
	[ItemUID] ASC
)WITH (PAD_INDEX  = ON, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GItem]', N'U') IS NULL
CREATE TABLE [dbo].[GItem](
	[ItemUID] [bigint] IDENTITY(1,1) NOT NULL,
	[UnitUID] [bigint] NOT NULL,
	[ItemID] [int] NOT NULL,
	[InventoryCategory] [tinyint] NOT NULL,
	[SlotID] [tinyint] NOT NULL,
	[UsageType] [tinyint] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Endurance] [int] NOT NULL,
	[Inserted] [tinyint] NULL,
	[RegDate] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_GItme_ItemUID] PRIMARY KEY NONCLUSTERED 
(
	[ItemUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GIs30Min]', N'U') IS NULL
CREATE TABLE [dbo].[GIs30Min](
	[UnitUID] [bigint] NOT NULL,
	[EventType] [smallint] NOT NULL,
	[RegDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GHenirRewardCnt]', N'U') IS NULL
CREATE TABLE [dbo].[GHenirRewardCnt](
	[UnitUID] [bigint] NOT NULL,
	[NormalCnt] [smallint] NOT NULL,
	[PCBangCnt] [smallint] NOT NULL,
	[EventCnt] [smallint] NOT NULL,
	[LastDate] [smalldatetime] NOT NULL,
 CONSTRAINT [PKC_UnitUID_GHenirRewardCnt] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GGuild_SkillPoint]', N'U') IS NULL
CREATE TABLE [dbo].[GGuild_SkillPoint](
	[GuildNo] [int] NOT NULL,
	[SPoint] [tinyint] NULL,
	[CSPoint] [tinyint] NULL,
	[MaxCsPoint] [tinyint] NULL,
	[Period] [tinyint] NULL,
	[EndDate] [smalldatetime] NULL,
 CONSTRAINT [PKC_GGuild_SkillPoint_GuildNo] PRIMARY KEY CLUSTERED 
(
	[GuildNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GGuild_Skill]', N'U') IS NULL
CREATE TABLE [dbo].[GGuild_Skill](
	[GuildNo] [int] NULL,
	[SkillID] [int] NULL,
	[Level] [tinyint] NULL,
	[CSPoint] [tinyint] NULL,
	[Deleted]  AS (case [Level] when (0) then (1) else (0) end)
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GGuild_Member]', N'U') IS NULL
CREATE TABLE [dbo].[GGuild_Member](
	[UnitUID] [bigint] NOT NULL,
	[GuildNo] [int] NULL,
	[EXP] [smallint] NULL,
	[RegDate] [smalldatetime] NULL,
	[LastDate] [smalldatetime] NULL,
	[State] [tinyint] NULL,
	[Message] [nvarchar](60) NULL,
 CONSTRAINT [PK_GGuild_Member_UnitUID] PRIMARY KEY NONCLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GGuild_Deleted]', N'U') IS NULL
CREATE TABLE [dbo].[GGuild_Deleted](
	[GuildNo] [int] NULL,
	[GuildName] [nvarchar](60) NULL,
	[DelDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GGuild_BBS_Join]', N'U') IS NULL
CREATE TABLE [dbo].[GGuild_BBS_Join](
	[UnitUID] [bigint] NULL,
	[GuildNo] [int] NULL,
	[UnitHello] [nvarchar](80) NULL,
	[RegDate] [smalldatetime] NULL,
 CONSTRAINT [UK_GGuild_BBS_Join_UnitUID] UNIQUE NONCLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GGuild_BBS]', N'U') IS NULL
CREATE TABLE [dbo].[GGuild_BBS](
	[GuildNo] [int] NOT NULL,
	[GuildHello] [nvarchar](80) NULL,
	[RegDate] [smalldatetime] NULL,
	[EndDate] [smalldatetime] NULL,
 CONSTRAINT [PKC_GGuild_BBS_GuildNo] PRIMARY KEY CLUSTERED 
(
	[GuildNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GGuild]', N'U') IS NULL
CREATE TABLE [dbo].[GGuild](
	[GuildNo] [int] IDENTITY(1,1) NOT NULL,
	[GuildName] [nvarchar](30) NULL,
	[MaxNo] [tinyint] NULL,
	[Level] [tinyint] NULL,
	[EXP] [smallint] NULL,
	[CreateDate] [smalldatetime] NULL,
	[LastDate] [smalldatetime] NULL,
	[State] [tinyint] NULL,
	[Logo] [tinyint] NULL,
	[SayHello] [nvarchar](90) NULL,
 CONSTRAINT [PKC_GGuild_GuildNo] PRIMARY KEY CLUSTERED 
(
	[GuildNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY],
 CONSTRAINT [UK_GGuild_GuildName] UNIQUE NONCLUSTERED 
(
	[GuildName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GGuide]', N'U') IS NULL
CREATE TABLE [dbo].[GGuide](
	[UnitUID] [bigint] NULL,
	[ItemID] [int] NULL,
	[PageNo] [tinyint] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GFriendSystem_UnitInfo]', N'U') IS NULL
CREATE TABLE [dbo].[GFriendSystem_UnitInfo](
	[UnitUID] [bigint] NOT NULL,
	[Spirit] [int] NOT NULL,
	[AP] [int] NOT NULL,
 CONSTRAINT [PKC_GFriendSystem_UnitInfo_UnitUID] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GFriendSystem_Ranker]', N'U') IS NULL
CREATE TABLE [dbo].[GFriendSystem_Ranker](
	[UnitUID] [bigint] NOT NULL,
 CONSTRAINT [PKC_LFriendSystem_Ranker_UnitUID] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GFriendSystem_LastReset]', N'U') IS NULL
CREATE TABLE [dbo].[GFriendSystem_LastReset](
	[Num] [int] NOT NULL,
	[LastResetDate] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GFriendMessage]', N'U') IS NULL
CREATE TABLE [dbo].[GFriendMessage](
	[UnitUID] [bigint] NOT NULL,
	[SenDerUID] [bigint] NOT NULL,
	[MessageType] [tinyint] NULL,
	[Message] [nvarchar](256) NULL,
	[RegDate] [smalldatetime] NULL,
 CONSTRAINT [PKC_GFriendMessage_UnitUID_SenderUID] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC,
	[SenDerUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GFriendList]', N'U') IS NULL
CREATE TABLE [dbo].[GFriendList](
	[UnitUID1] [bigint] NOT NULL,
	[UnitUID2] [bigint] NOT NULL,
	[Regdate] [smalldatetime] NOT NULL,
	[Type] [tinyint] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GFriendGroup]', N'U') IS NULL
CREATE TABLE [dbo].[GFriendGroup](
	[UnitUID] [bigint] NOT NULL,
	[GroupID] [tinyint] NOT NULL,
	[GroupName] [nvarchar](30) NOT NULL,
 CONSTRAINT [PKC_GFriendGroup_UnitUID] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC,
	[GroupID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GFriend]', N'U') IS NULL
CREATE TABLE [dbo].[GFriend](
	[UnitUID] [bigint] NOT NULL,
	[FriendUID] [bigint] NOT NULL,
	[GroupID] [tinyint] NULL,
	[Status] [tinyint] NULL,
	[RegDate] [smalldatetime] NULL,
 CONSTRAINT [PKC_GFriend_UnitUID_FriendUID] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC,
	[FriendUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GEventTradeCount]', N'U') IS NULL
CREATE TABLE [dbo].[GEventTradeCount](
	[UnitUID] [bigint] NOT NULL,
	[Count] [int] NULL,
	[LastDate] [smalldatetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GEventRavenSpirit]', N'U') IS NULL
CREATE TABLE [dbo].[GEventRavenSpirit](
	[UnitUID] [bigint] NOT NULL,
	[RagePoint] [int] NOT NULL,
	[PeacePoint] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GEventNewYear]', N'U') IS NULL
CREATE TABLE [dbo].[GEventNewYear](
	[UserUID] [bigint] NOT NULL,
	[UnitUID] [bigint] NULL,
	[StepID] [tinyint] NULL,
	[LastDate] [smalldatetime] NULL,
 CONSTRAINT [PKC_GEventNewYear_UserUID] PRIMARY KEY CLUSTERED 
(
	[UserUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GEventEveLimit]', N'U') IS NULL
CREATE TABLE [dbo].[GEventEveLimit](
	[EventDate] [smalldatetime] NOT NULL,
	[CreateCount] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[EventDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GEventEveBuff]', N'U') IS NULL
CREATE TABLE [dbo].[GEventEveBuff](
	[UnitUID] [bigint] NOT NULL,
	[BuffExpireDate_1] [smalldatetime] NULL,
	[BuffExpireDate_2] [smalldatetime] NULL,
	[BuffExpireDate_3] [smalldatetime] NULL,
	[BuffExpireDate_4] [smalldatetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GEventEndYear]', N'U') IS NULL
CREATE TABLE [dbo].[GEventEndYear](
	[UnitUID] [bigint] NOT NULL,
	[LastRewardLevel] [tinyint] NULL,
	[LastDate] [smalldatetime] NULL,
 CONSTRAINT [PKC_GEventEndYear_UnitUID] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GEventDungeonData]', N'U') IS NULL
CREATE TABLE [dbo].[GEventDungeonData](
	[UnitUID] [bigint] NOT NULL,
	[DungeonID] [int] NOT NULL,
	[PlayCount] [int] NULL,
	[SuccessCount] [int] NULL,
	[LastResetTime] [smalldatetime] NULL,
 CONSTRAINT [PK_GEventDungeonData_UnitUID_DungeonID] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC,
	[DungeonID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GEventBankShare]', N'U') IS NULL
CREATE TABLE [dbo].[GEventBankShare](
	[UserUID] [bigint] NOT NULL,
	[UnitUID] [bigint] NULL,
	[ItemID] [int] NULL,
	[RegDate] [smalldatetime] NULL,
 CONSTRAINT [PK_GEventBankShare_UserUID] PRIMARY KEY CLUSTERED 
(
	[UserUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GEvent3vs3PVPData]', N'U') IS NULL
CREATE TABLE [dbo].[GEvent3vs3PVPData](
	[UnitUID] [bigint] NOT NULL,
	[PlayCount] [int] NULL,
	[KillCount] [int] NULL,
	[DeathCount] [int] NULL,
	[LastUpdateDate] [smalldatetime] NULL,
 CONSTRAINT [PK_GEvent3vs3PVPData_UnitUID] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GEvent_RewardUser]', N'U') IS NULL
CREATE TABLE [dbo].[GEvent_RewardUser](
	[UserUID] [bigint] NOT NULL,
	[UnitUID] [bigint] NOT NULL,
	[EventUID] [int] NOT NULL,
	[RegDate] [smalldatetime] NULL,
 CONSTRAINT [PK_GEvent_RewardUser_UserUID_EventUID] PRIMARY KEY CLUSTERED 
(
	[UserUID] ASC,
	[EventUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GEvent_RewardUnit]', N'U') IS NULL
CREATE TABLE [dbo].[GEvent_RewardUnit](
	[UnitUID] [bigint] NOT NULL,
	[ItemID] [int] NOT NULL,
	[RegDate] [smalldatetime] NULL,
 CONSTRAINT [PK_GEvent_RewardUnit] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC,
	[ItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GEvent_Letter]', N'U') IS NULL
CREATE TABLE [dbo].[GEvent_Letter](
	[UnitUID] [bigint] NULL,
	[Message] [nvarchar](700) NULL,
	[RegDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GEvent_CombackUser]', N'U') IS NULL
CREATE TABLE [dbo].[GEvent_CombackUser](
	[UserUID] [bigint] NOT NULL,
	[UnitUID] [bigint] NOT NULL,
	[LastDate] [smalldatetime] NOT NULL,
	[IsReward] [bit] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GEvent_Account_Nor]', N'U') IS NULL
CREATE TABLE [dbo].[GEvent_Account_Nor](
	[UserUID] [int] NULL,
	[EventUID] [smallint] NULL,
	[RegDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GEvent_Account_Acc]', N'U') IS NULL
CREATE TABLE [dbo].[GEvent_Account_Acc](
	[UserUID] [int] NULL,
	[EventUID] [smallint] NULL,
	[RemainTime] [smallint] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[Get_Super_EL_Info]', N'U') IS NULL
CREATE TABLE [dbo].[Get_Super_EL_Info](
	[Userid] [nvarchar](20) NOT NULL,
	[Quantity] [int] NOT NULL,
	[RegDate] [smalldatetime] NULL,
 CONSTRAINT [PKC_Get_Super_EL_Info_Userid] PRIMARY KEY CLUSTERED 
(
	[Userid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[Get_EL_Info]', N'U') IS NULL
CREATE TABLE [dbo].[Get_EL_Info](
	[Userid] [nvarchar](20) NOT NULL,
	[Quantity] [int] NOT NULL,
	[RegDate] [smalldatetime] NULL,
 CONSTRAINT [PKC_Get_EL_Info_Userid] PRIMARY KEY CLUSTERED 
(
	[Userid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GDungeonInfo]', N'U') IS NULL
CREATE TABLE [dbo].[GDungeonInfo](
	[UserLevel] [int] NULL,
	[DungeonID] [int] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GDungeonCode]', N'U') IS NULL
CREATE TABLE [dbo].[GDungeonCode](
	[Code] [int] NOT NULL,
	[Name] [nvarchar](255) NULL,
 CONSTRAINT [PKC_GDungeonCode_Code] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GDungeonClear]', N'U') IS NULL
CREATE TABLE [dbo].[GDungeonClear](
	[UnitUID] [bigint] NOT NULL,
	[GameMode] [int] NOT NULL,
	[MaxScore] [int] NOT NULL,
	[MaxTotalRank] [tinyint] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_GDungeonClear_1] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC,
	[GameMode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GDenyOption]', N'U') IS NULL
CREATE TABLE [dbo].[GDenyOption](
	[UnitUID] [bigint] NOT NULL,
	[QuestionNo] [tinyint] NOT NULL,
	[CodeNo] [tinyint] NOT NULL,
 CONSTRAINT [PKC_GDenyOption_UnitUID_Question] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC,
	[QuestionNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GDenyCode]', N'U') IS NULL
CREATE TABLE [dbo].[GDenyCode](
	[QuestionNo] [tinyint] NOT NULL,
	[CodeNo] [tinyint] NOT NULL,
	[Comment] [nvarchar](100) NOT NULL,
 CONSTRAINT [PKC_GDenyCode_QuestionNo_CodeNo] PRIMARY KEY CLUSTERED 
(
	[QuestionNo] ASC,
	[CodeNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GDeletedNickNameHistory]', N'U') IS NULL
CREATE TABLE [dbo].[GDeletedNickNameHistory](
	[NickName] [nvarchar](35) NOT NULL,
	[UnitUID] [bigint] NOT NULL,
	[Regdate] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GDeletedNickName]', N'U') IS NULL
CREATE TABLE [dbo].[GDeletedNickName](
	[Nickname] [nvarchar](35) NOT NULL,
 CONSTRAINT [PKC_GDeletedNickName_Nickname] PRIMARY KEY CLUSTERED 
(
	[Nickname] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GDarkGate_LastDate]', N'U') IS NULL
CREATE TABLE [dbo].[GDarkGate_LastDate](
	[UnitUID] [bigint] NOT NULL,
	[LastCompleteDate] [smalldatetime] NOT NULL,
 CONSTRAINT [PKC_GDarkGate_LastDate_UnitUID] PRIMARY KEY CLUSTERED 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[GCreateUnitCnt]', N'U') IS NULL
CREATE TABLE [dbo].[GCreateUnitCnt](
	[UserUID] [bigint] NOT NULL,
	[CNT] [tinyint] NOT NULL,
 CONSTRAINT [PKC_GCreateUnitCnt_UserUID] PRIMARY KEY CLUSTERED 
(
	[UserUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_Rank_SpaceTime_Week_Date_Rank' AND object_id = OBJECT_ID(N'[dbo].[Rank_SpaceTime_Week]'))
CREATE NONCLUSTERED INDEX [IX_Rank_SpaceTime_Week_Date_Rank] ON [dbo].[Rank_SpaceTime_Week] 
(
	[Date] ASC,
	[Rank] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_Rank_SpaceTime_Month_Date_Rank' AND object_id = OBJECT_ID(N'[dbo].[Rank_SpaceTime_Month]'))
CREATE NONCLUSTERED INDEX [IX_Rank_SpaceTime_Month_Date_Rank] ON [dbo].[Rank_SpaceTime_Month] 
(
	[Date] ASC,
	[Rank] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_Rank_SpaceTime_Day_Date_Rank' AND object_id = OBJECT_ID(N'[dbo].[Rank_SpaceTime_Day]'))
CREATE NONCLUSTERED INDEX [IX_Rank_SpaceTime_Day_Date_Rank] ON [dbo].[Rank_SpaceTime_Day] 
(
	[Date] ASC,
	[Rank] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_GCouple_WeddingInfo_WeddingDate' AND object_id = OBJECT_ID(N'[dbo].[GCouple_WeddingInfo]'))
CREATE NONCLUSTERED INDEX [IX_GCouple_WeddingInfo_WeddingDate] ON [dbo].[GCouple_WeddingInfo] 
(
	[WeddingDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'CIX_GBase_Item_UnitClass' AND object_id = OBJECT_ID(N'[dbo].[GBase_Item]'))
CREATE CLUSTERED INDEX [CIX_GBase_Item_UnitClass] ON [dbo].[GBase_Item] 
(
	[UnitClass] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'UQ_GBase_Item' AND object_id = OBJECT_ID(N'[dbo].[GBase_Item]'))
CREATE UNIQUE NONCLUSTERED INDEX [UQ_GBase_Item] ON [dbo].[GBase_Item] 
(
	[InventoryCategory] ASC,
	[SlotID] ASC,
	[UnitClass] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_GUser_UserID' AND object_id = OBJECT_ID(N'[dbo].[GUser]'))
CREATE NONCLUSTERED INDEX [IX_GUser_UserID] ON [dbo].[GUser] 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_GUnitRestore_UnitUID' AND object_id = OBJECT_ID(N'[dbo].[GUnitRestore]'))
CREATE NONCLUSTERED INDEX [IX_GUnitRestore_UnitUID] ON [dbo].[GUnitRestore] 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'MUK_GUnitNickName_NickName' AND object_id = OBJECT_ID(N'[dbo].[GUnitNickName]'))
CREATE UNIQUE NONCLUSTERED INDEX [MUK_GUnitNickName_NickName] ON [dbo].[GUnitNickName] 
(
	[NickName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_LUnitClassChangeLog_UnitUID' AND object_id = OBJECT_ID(N'[dbo].[GUnitClassChangeStage]'))
CREATE CLUSTERED INDEX [IXC_LUnitClassChangeLog_UnitUID] ON [dbo].[GUnitClassChangeStage] 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_GUnit_ED_UnitUID_RegDate' AND object_id = OBJECT_ID(N'[dbo].[GUnit_ED]'))
CREATE CLUSTERED INDEX [IXC_GUnit_ED_UnitUID_RegDate] ON [dbo].[GUnit_ED] 
(
	[UnitUID] ASC,
	[RegDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'ixc_GUnit_UserUID' AND object_id = OBJECT_ID(N'[dbo].[GUnit]'))
CREATE CLUSTERED INDEX [ixc_GUnit_UserUID] ON [dbo].[GUnit] 
(
	[UserUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_GTutor_TeacherUID' AND object_id = OBJECT_ID(N'[dbo].[GTutor]'))
CREATE CLUSTERED INDEX [IXC_GTutor_TeacherUID] ON [dbo].[GTutor] 
(
	[TeacherUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_GTutor_SutdentUID' AND object_id = OBJECT_ID(N'[dbo].[GTutor]'))
CREATE NONCLUSTERED INDEX [IX_GTutor_SutdentUID] ON [dbo].[GTutor] 
(
	[StudentUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_GSkill_Default_UnitClass' AND object_id = OBJECT_ID(N'[dbo].[GSkill_Default]'))
CREATE CLUSTERED INDEX [IXC_GSkill_Default_UnitClass] ON [dbo].[GSkill_Default] 
(
	[UnitClass] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_GSkill_BeforeList_UnitUID' AND object_id = OBJECT_ID(N'[dbo].[GSkill_BeforeList]'))
CREATE CLUSTERED INDEX [IXC_GSkill_BeforeList_UnitUID] ON [dbo].[GSkill_BeforeList] 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_GRiding_UnitUID' AND object_id = OBJECT_ID(N'[dbo].[GRiding]'))
CREATE CLUSTERED INDEX [IXC_GRiding_UnitUID] ON [dbo].[GRiding] 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_GRemainTime_UnitUID' AND object_id = OBJECT_ID(N'[dbo].[GRemainTime]'))
CREATE CLUSTERED INDEX [IXC_GRemainTime_UnitUID] ON [dbo].[GRemainTime] 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_GRecommend_NewUID' AND object_id = OBJECT_ID(N'[dbo].[GRecommend]'))
CREATE NONCLUSTERED INDEX [IX_GRecommend_NewUID] ON [dbo].[GRecommend] 
(
	[NewUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'PKC_GRank_Arcade_UnitUID' AND object_id = OBJECT_ID(N'[dbo].[GRank_Arcade]'))
CREATE CLUSTERED INDEX [PKC_GRank_Arcade_UnitUID] ON [dbo].[GRank_Arcade] 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_GRank_RegDate_ExpRank' AND object_id = OBJECT_ID(N'[dbo].[GRank]'))
CREATE CLUSTERED INDEX [IXC_GRank_RegDate_ExpRank] ON [dbo].[GRank] 
(
	[RegDate] ASC,
	[ExpRank] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_GRank_NickName' AND object_id = OBJECT_ID(N'[dbo].[GRank]'))
CREATE NONCLUSTERED INDEX [IX_GRank_NickName] ON [dbo].[GRank] 
(
	[NickName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_GRank_VsRank' AND object_id = OBJECT_ID(N'[dbo].[GRank]'))
CREATE NONCLUSTERED INDEX [IX_GRank_VsRank] ON [dbo].[GRank] 
(
	[VsRank] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_GQUESTS_REPEAT_UnitUID' AND object_id = OBJECT_ID(N'[dbo].[GQuests_Repeat]'))
CREATE CLUSTERED INDEX [IXC_GQUESTS_REPEAT_UnitUID] ON [dbo].[GQuests_Repeat] 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_GPShop_Item_UnitUID' AND object_id = OBJECT_ID(N'[dbo].[GPShopItem]'))
CREATE CLUSTERED INDEX [IXC_GPShop_Item_UnitUID] ON [dbo].[GPShopItem] 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_GPostBlackList_MyUID' AND object_id = OBJECT_ID(N'[dbo].[GPost_BlackList]'))
CREATE CLUSTERED INDEX [IXC_GPostBlackList_MyUID] ON [dbo].[GPost_BlackList] 
(
	[MyUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_GPost_ToUnitUID' AND object_id = OBJECT_ID(N'[dbo].[GPost]'))
CREATE CLUSTERED INDEX [IXC_GPost_ToUnitUID] ON [dbo].[GPost] 
(
	[ToUnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_GPost_FromUnitUID' AND object_id = OBJECT_ID(N'[dbo].[GPost]'))
CREATE NONCLUSTERED INDEX [IX_GPost_FromUnitUID] ON [dbo].[GPost] 
(
	[FromUnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_GPost_ScIndex' AND object_id = OBJECT_ID(N'[dbo].[GPost]'))
CREATE NONCLUSTERED INDEX [IX_GPost_ScIndex] ON [dbo].[GPost] 
(
	[ScIndex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_GPetNameChangeLog_PetUID' AND object_id = OBJECT_ID(N'[dbo].[GPetNameChangeLog]'))
CREATE CLUSTERED INDEX [IXC_GPetNameChangeLog_PetUID] ON [dbo].[GPetNameChangeLog] 
(
	[PetUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_GPet_Info_UnitUID' AND object_id = OBJECT_ID(N'[dbo].[GPet_Info]'))
CREATE NONCLUSTERED INDEX [IX_GPet_Info_UnitUID] ON [dbo].[GPet_Info] 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_GNote_UnitUID' AND object_id = OBJECT_ID(N'[dbo].[GNote]'))
CREATE CLUSTERED INDEX [IXC_GNote_UnitUID] ON [dbo].[GNote] 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_GItemSocket_Random_UnitUID' AND object_id = OBJECT_ID(N'[dbo].[GItemSocket_Random]'))
CREATE CLUSTERED INDEX [IXC_GItemSocket_Random_UnitUID] ON [dbo].[GItemSocket_Random] 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_GItemSocket_UnitUID' AND object_id = OBJECT_ID(N'[dbo].[GItemSocket]'))
CREATE CLUSTERED INDEX [IXC_GItemSocket_UnitUID] ON [dbo].[GItemSocket] 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_GItemPeriod_UnitUID' AND object_id = OBJECT_ID(N'[dbo].[GItemPeriod]'))
CREATE CLUSTERED INDEX [IXC_GItemPeriod_UnitUID] ON [dbo].[GItemPeriod] 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_GItemInventorySize_UnitUID' AND object_id = OBJECT_ID(N'[dbo].[GItemInventorySize]'))
CREATE NONCLUSTERED INDEX [IXC_GItemInventorySize_UnitUID] ON [dbo].[GItemInventorySize] 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_GItemEndurance_UnitUID' AND object_id = OBJECT_ID(N'[dbo].[GItemEndurance]'))
CREATE CLUSTERED INDEX [IXC_GItemEndurance_UnitUID] ON [dbo].[GItemEndurance] 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_GItemEnchant_UnitUID' AND object_id = OBJECT_ID(N'[dbo].[GItemEnchant]'))
CREATE CLUSTERED INDEX [IXC_GItemEnchant_UnitUID] ON [dbo].[GItemEnchant] 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_GItemCode_ItemName' AND object_id = OBJECT_ID(N'[dbo].[GItemCode]'))
CREATE NONCLUSTERED INDEX [IX_GItemCode_ItemName] ON [dbo].[GItemCode] 
(
	[ItemName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_GItemAttribute_UnitUID' AND object_id = OBJECT_ID(N'[dbo].[GItemAttribute]'))
CREATE CLUSTERED INDEX [IXC_GItemAttribute_UnitUID] ON [dbo].[GItemAttribute] 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_GItem_Log_DelDate' AND object_id = OBJECT_ID(N'[dbo].[GItem_Log]'))
CREATE CLUSTERED INDEX [IXC_GItem_Log_DelDate] ON [dbo].[GItem_Log] 
(
	[DelDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_GItem_Log_ItemID' AND object_id = OBJECT_ID(N'[dbo].[GItem_Log]'))
CREATE NONCLUSTERED INDEX [IX_GItem_Log_ItemID] ON [dbo].[GItem_Log] 
(
	[ItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_GItem_Log_UnitUID' AND object_id = OBJECT_ID(N'[dbo].[GItem_Log]'))
CREATE NONCLUSTERED INDEX [IX_GItem_Log_UnitUID] ON [dbo].[GItem_Log] 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_GItme_UnitUID' AND object_id = OBJECT_ID(N'[dbo].[GItem]'))
CREATE CLUSTERED INDEX [IXC_GItme_UnitUID] ON [dbo].[GItem] 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_GItem_ItemID' AND object_id = OBJECT_ID(N'[dbo].[GItem]'))
CREATE NONCLUSTERED INDEX [IX_GItem_ItemID] ON [dbo].[GItem] 
(
	[ItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_GIs30Min_UnitUID_EventType' AND object_id = OBJECT_ID(N'[dbo].[GIs30Min]'))
CREATE CLUSTERED INDEX [IXC_GIs30Min_UnitUID_EventType] ON [dbo].[GIs30Min] 
(
	[UnitUID] ASC,
	[EventType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_GGuild_Skill_GuildNo' AND object_id = OBJECT_ID(N'[dbo].[GGuild_Skill]'))
CREATE CLUSTERED INDEX [IXC_GGuild_Skill_GuildNo] ON [dbo].[GGuild_Skill] 
(
	[GuildNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_GGuild_Member_GuildNo' AND object_id = OBJECT_ID(N'[dbo].[GGuild_Member]'))
CREATE CLUSTERED INDEX [IXC_GGuild_Member_GuildNo] ON [dbo].[GGuild_Member] 
(
	[GuildNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_GGuild_Deleted_GuildName' AND object_id = OBJECT_ID(N'[dbo].[GGuild_Deleted]'))
CREATE CLUSTERED INDEX [IX_GGuild_Deleted_GuildName] ON [dbo].[GGuild_Deleted] 
(
	[GuildName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_GGuild_BBS_Join_GuildNo' AND object_id = OBJECT_ID(N'[dbo].[GGuild_BBS_Join]'))
CREATE CLUSTERED INDEX [IX_GGuild_BBS_Join_GuildNo] ON [dbo].[GGuild_BBS_Join] 
(
	[GuildNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_GGuild_GuildName' AND object_id = OBJECT_ID(N'[dbo].[GGuild]'))
CREATE NONCLUSTERED INDEX [IX_GGuild_GuildName] ON [dbo].[GGuild] 
(
	[GuildName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_GGuide_UnitUID' AND object_id = OBJECT_ID(N'[dbo].[GGuide]'))
CREATE CLUSTERED INDEX [IXC_GGuide_UnitUID] ON [dbo].[GGuide] 
(
	[UnitUID] ASC,
	[PageNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'UIX_GFriendList_UnitUID' AND object_id = OBJECT_ID(N'[dbo].[GFriendList]'))
CREATE UNIQUE NONCLUSTERED INDEX [UIX_GFriendList_UnitUID] ON [dbo].[GFriendList] 
(
	[UnitUID1] ASC,
	[UnitUID2] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_GEvent_Letter_UnitUID' AND object_id = OBJECT_ID(N'[dbo].[GEvent_Letter]'))
CREATE CLUSTERED INDEX [IXC_GEvent_Letter_UnitUID] ON [dbo].[GEvent_Letter] 
(
	[UnitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_GEvent_CombackUser_UserUID' AND object_id = OBJECT_ID(N'[dbo].[GEvent_CombackUser]'))
CREATE CLUSTERED INDEX [IXC_GEvent_CombackUser_UserUID] ON [dbo].[GEvent_CombackUser] 
(
	[UserUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_GEvent_Account_Nor_UserUID' AND object_id = OBJECT_ID(N'[dbo].[GEvent_Account_Nor]'))
CREATE CLUSTERED INDEX [IXC_GEvent_Account_Nor_UserUID] ON [dbo].[GEvent_Account_Nor] 
(
	[UserUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_GEvent_Account_Acc_UserUID' AND object_id = OBJECT_ID(N'[dbo].[GEvent_Account_Acc]'))
CREATE CLUSTERED INDEX [IXC_GEvent_Account_Acc_UserUID] ON [dbo].[GEvent_Account_Acc] 
(
	[UserUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_GDeletedNickNameHistory_NickName' AND object_id = OBJECT_ID(N'[dbo].[GDeletedNickNameHistory]'))
CREATE NONCLUSTERED INDEX [IX_GDeletedNickNameHistory_NickName] ON [dbo].[GDeletedNickNameHistory] 
(
	[NickName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[DF_GBankShare_sOnOff]') IS NULL
/****** Object:  Default [DF_GBankShare_sOnOff]    Script Date: 01/25/2014 12:18:35 ******/
ALTER TABLE [dbo].[GBankShare] ADD  CONSTRAINT [DF_GBankShare_sOnOff]  DEFAULT ((1)) FOR [sOnOff]
GO
IF OBJECT_ID(N'[dbo].[DF_GBankShare_RegDate]') IS NULL
/****** Object:  Default [DF_GBankShare_RegDate]    Script Date: 01/25/2014 12:18:35 ******/
ALTER TABLE [dbo].[GBankShare] ADD  CONSTRAINT [DF_GBankShare_RegDate]  DEFAULT (getdate()) FOR [RegDate]
GO
IF OBJECT_ID(N'[dbo].[DF_GVIPTicket_RegDate]') IS NULL
/****** Object:  Default [DF_GVIPTicket_RegDate]    Script Date: 01/25/2014 12:18:35 ******/
ALTER TABLE [dbo].[GVIPTicket] ADD  CONSTRAINT [DF_GVIPTicket_RegDate]  DEFAULT (getdate()) FOR [RegDate]
GO
IF OBJECT_ID(N'[dbo].[DF_GVIPTicket_ExpireDate]') IS NULL
/****** Object:  Default [DF_GVIPTicket_ExpireDate]    Script Date: 01/25/2014 12:18:35 ******/
ALTER TABLE [dbo].[GVIPTicket] ADD  CONSTRAINT [DF_GVIPTicket_ExpireDate]  DEFAULT (getdate()) FOR [ExpireDate]
GO
IF OBJECT_ID(N'[dbo].[DF_GUnitPVPTag_Win]') IS NULL
/****** Object:  Default [DF_GUnitPVPTag_Win]    Script Date: 01/25/2014 12:18:35 ******/
ALTER TABLE [dbo].[GUnitPVPTag] ADD  CONSTRAINT [DF_GUnitPVPTag_Win]  DEFAULT ((0)) FOR [Win]
GO
IF OBJECT_ID(N'[dbo].[DF_GUnitPVPTag_Lose]') IS NULL
/****** Object:  Default [DF_GUnitPVPTag_Lose]    Script Date: 01/25/2014 12:18:35 ******/
ALTER TABLE [dbo].[GUnitPVPTag] ADD  CONSTRAINT [DF_GUnitPVPTag_Lose]  DEFAULT ((0)) FOR [Lose]
GO
IF OBJECT_ID(N'[dbo].[DF_GUnitPVPTag_Point]') IS NULL
/****** Object:  Default [DF_GUnitPVPTag_Point]    Script Date: 01/25/2014 12:18:35 ******/
ALTER TABLE [dbo].[GUnitPVPTag] ADD  CONSTRAINT [DF_GUnitPVPTag_Point]  DEFAULT ((0)) FOR [Point]
GO
IF OBJECT_ID(N'[dbo].[DF_GUnitPVPTag_RegDate]') IS NULL
/****** Object:  Default [DF_GUnitPVPTag_RegDate]    Script Date: 01/25/2014 12:18:35 ******/
ALTER TABLE [dbo].[GUnitPVPTag] ADD  CONSTRAINT [DF_GUnitPVPTag_RegDate]  DEFAULT (getdate()) FOR [RegDate]
GO
IF OBJECT_ID(N'[dbo].[DF_GUnitPVP_Grade]') IS NULL
/****** Object:  Default [DF_GUnitPVP_Grade]    Script Date: 01/25/2014 12:18:35 ******/
ALTER TABLE [dbo].[GUnitPVP] ADD  CONSTRAINT [DF_GUnitPVP_Grade]  DEFAULT ((1)) FOR [Grade]
GO
IF OBJECT_ID(N'[dbo].[DF_GUnit_LastDate]') IS NULL
/****** Object:  Default [DF_GUnit_LastDate]    Script Date: 01/25/2014 12:18:35 ******/
ALTER TABLE [dbo].[GUnit] ADD  CONSTRAINT [DF_GUnit_LastDate]  DEFAULT ((0)) FOR [LastDate]
GO
IF OBJECT_ID(N'[dbo].[DF_GUnit_PlayDay]') IS NULL
/****** Object:  Default [DF_GUnit_PlayDay]    Script Date: 01/25/2014 12:18:35 ******/
ALTER TABLE [dbo].[GUnit] ADD  CONSTRAINT [DF_GUnit_PlayDay]  DEFAULT ((0)) FOR [PlayDayCnt]
GO
IF OBJECT_ID(N'[dbo].[DF_GUnit_LoginCount]') IS NULL
/****** Object:  Default [DF_GUnit_LoginCount]    Script Date: 01/25/2014 12:18:35 ******/
ALTER TABLE [dbo].[GUnit] ADD  CONSTRAINT [DF_GUnit_LoginCount]  DEFAULT ((1)) FOR [LoginCount]
GO
IF OBJECT_ID(N'[dbo].[DF_GTitle_Complete_IsHang]') IS NULL
/****** Object:  Default [DF_GTitle_Complete_IsHang]    Script Date: 01/25/2014 12:18:35 ******/
ALTER TABLE [dbo].[GTitle_Complete] ADD  CONSTRAINT [DF_GTitle_Complete_IsHang]  DEFAULT ((0)) FOR [IsHang]
GO
IF OBJECT_ID(N'[dbo].[DF_GSpirit_Flag]') IS NULL
/****** Object:  Default [DF_GSpirit_Flag]    Script Date: 01/25/2014 12:18:35 ******/
ALTER TABLE [dbo].[GSpirit] ADD  CONSTRAINT [DF_GSpirit_Flag]  DEFAULT ((0)) FOR [Flag]
GO
IF OBJECT_ID(N'[dbo].[DF_GRank_Arcade_Server_Unit2]') IS NULL
/****** Object:  Default [DF_GRank_Arcade_Server_Unit2]    Script Date: 01/25/2014 12:18:35 ******/
ALTER TABLE [dbo].[GRank_Arcade_Server] ADD  CONSTRAINT [DF_GRank_Arcade_Server_Unit2]  DEFAULT (NULL) FOR [Unit2]
GO
IF OBJECT_ID(N'[dbo].[DF_GRank_Arcade_Server_Unit3]') IS NULL
/****** Object:  Default [DF_GRank_Arcade_Server_Unit3]    Script Date: 01/25/2014 12:18:35 ******/
ALTER TABLE [dbo].[GRank_Arcade_Server] ADD  CONSTRAINT [DF_GRank_Arcade_Server_Unit3]  DEFAULT (NULL) FOR [Unit3]
GO
IF OBJECT_ID(N'[dbo].[DF_GRank_Arcade_Server_Unit4]') IS NULL
/****** Object:  Default [DF_GRank_Arcade_Server_Unit4]    Script Date: 01/25/2014 12:18:35 ******/
ALTER TABLE [dbo].[GRank_Arcade_Server] ADD  CONSTRAINT [DF_GRank_Arcade_Server_Unit4]  DEFAULT (NULL) FOR [Unit4]
GO
IF OBJECT_ID(N'[dbo].[DF_GRank_Arcade_Unit1]') IS NULL
/****** Object:  Default [DF_GRank_Arcade_Unit1]    Script Date: 01/25/2014 12:18:35 ******/
ALTER TABLE [dbo].[GRank_Arcade] ADD  CONSTRAINT [DF_GRank_Arcade_Unit1]  DEFAULT (NULL) FOR [Unit1]
GO
IF OBJECT_ID(N'[dbo].[DF_GRank_Arcade_Unit2]') IS NULL
/****** Object:  Default [DF_GRank_Arcade_Unit2]    Script Date: 01/25/2014 12:18:35 ******/
ALTER TABLE [dbo].[GRank_Arcade] ADD  CONSTRAINT [DF_GRank_Arcade_Unit2]  DEFAULT (NULL) FOR [Unit2]
GO
IF OBJECT_ID(N'[dbo].[DF_GRank_Arcade_Unit3]') IS NULL
/****** Object:  Default [DF_GRank_Arcade_Unit3]    Script Date: 01/25/2014 12:18:35 ******/
ALTER TABLE [dbo].[GRank_Arcade] ADD  CONSTRAINT [DF_GRank_Arcade_Unit3]  DEFAULT (NULL) FOR [Unit3]
GO
IF OBJECT_ID(N'[dbo].[DF_GPShop_Item_Deleted]') IS NULL
/****** Object:  Default [DF_GPShop_Item_Deleted]    Script Date: 01/25/2014 12:18:35 ******/
ALTER TABLE [dbo].[GPShopItem] ADD  CONSTRAINT [DF_GPShop_Item_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
IF OBJECT_ID(N'[dbo].[DF_GPost_Attribute_Attribute3]') IS NULL
/****** Object:  Default [DF_GPost_Attribute_Attribute3]    Script Date: 01/25/2014 12:18:35 ******/
ALTER TABLE [dbo].[GPost_Attribute] ADD  CONSTRAINT [DF_GPost_Attribute_Attribute3]  DEFAULT ((0)) FOR [Attribute3]
GO
IF OBJECT_ID(N'[dbo].[DF_GPost_IsReceive]') IS NULL
/****** Object:  Default [DF_GPost_IsReceive]    Script Date: 01/25/2014 12:18:35 ******/
ALTER TABLE [dbo].[GPost] ADD  CONSTRAINT [DF_GPost_IsReceive]  DEFAULT ((0)) FOR [IsReceive]
GO
IF OBJECT_ID(N'[dbo].[DF_GPost_IsRead]') IS NULL
/****** Object:  Default [DF_GPost_IsRead]    Script Date: 01/25/2014 12:18:35 ******/
ALTER TABLE [dbo].[GPost] ADD  CONSTRAINT [DF_GPost_IsRead]  DEFAULT ((0)) FOR [IsRead]
GO
IF OBJECT_ID(N'[dbo].[DF_GItemSocket_Socket1]') IS NULL
/****** Object:  Default [DF_GItemSocket_Socket1]    Script Date: 01/25/2014 12:18:35 ******/
ALTER TABLE [dbo].[GItemSocket] ADD  CONSTRAINT [DF_GItemSocket_Socket1]  DEFAULT ((-1)) FOR [Socket1]
GO
IF OBJECT_ID(N'[dbo].[DF_GItemSocket_Socket2]') IS NULL
/****** Object:  Default [DF_GItemSocket_Socket2]    Script Date: 01/25/2014 12:18:35 ******/
ALTER TABLE [dbo].[GItemSocket] ADD  CONSTRAINT [DF_GItemSocket_Socket2]  DEFAULT ((-1)) FOR [Socket2]
GO
IF OBJECT_ID(N'[dbo].[DF_GItemSocket_Socket3]') IS NULL
/****** Object:  Default [DF_GItemSocket_Socket3]    Script Date: 01/25/2014 12:18:35 ******/
ALTER TABLE [dbo].[GItemSocket] ADD  CONSTRAINT [DF_GItemSocket_Socket3]  DEFAULT ((-1)) FOR [Socket3]
GO
IF OBJECT_ID(N'[dbo].[DF_GItemSocket_Socket4]') IS NULL
/****** Object:  Default [DF_GItemSocket_Socket4]    Script Date: 01/25/2014 12:18:35 ******/
ALTER TABLE [dbo].[GItemSocket] ADD  CONSTRAINT [DF_GItemSocket_Socket4]  DEFAULT ((-1)) FOR [Socket4]
GO
IF OBJECT_ID(N'[dbo].[DF_GItem_Log_UsageType]') IS NULL
/****** Object:  Default [DF_GItem_Log_UsageType]    Script Date: 01/25/2014 12:18:35 ******/
ALTER TABLE [dbo].[GItem_Log] ADD  CONSTRAINT [DF_GItem_Log_UsageType]  DEFAULT ((0)) FOR [UsageType]
GO
IF OBJECT_ID(N'[dbo].[DF_GItem_Log_Quantity]') IS NULL
/****** Object:  Default [DF_GItem_Log_Quantity]    Script Date: 01/25/2014 12:18:35 ******/
ALTER TABLE [dbo].[GItem_Log] ADD  CONSTRAINT [DF_GItem_Log_Quantity]  DEFAULT ((0)) FOR [Quantity]
GO
IF OBJECT_ID(N'[dbo].[DF_GItem_Log_Endurance]') IS NULL
/****** Object:  Default [DF_GItem_Log_Endurance]    Script Date: 01/25/2014 12:18:35 ******/
ALTER TABLE [dbo].[GItem_Log] ADD  CONSTRAINT [DF_GItem_Log_Endurance]  DEFAULT ((-1)) FOR [Endurance]
GO
IF OBJECT_ID(N'[dbo].[DF_GItem_UsageType]') IS NULL
/****** Object:  Default [DF_GItem_UsageType]    Script Date: 01/25/2014 12:18:35 ******/
ALTER TABLE [dbo].[GItem] ADD  CONSTRAINT [DF_GItem_UsageType]  DEFAULT ((0)) FOR [UsageType]
GO
IF OBJECT_ID(N'[dbo].[DF_GItem_Quantity]') IS NULL
/****** Object:  Default [DF_GItem_Quantity]    Script Date: 01/25/2014 12:18:35 ******/
ALTER TABLE [dbo].[GItem] ADD  CONSTRAINT [DF_GItem_Quantity]  DEFAULT ((0)) FOR [Quantity]
GO
IF OBJECT_ID(N'[dbo].[DF_GItem_Endurance]') IS NULL
/****** Object:  Default [DF_GItem_Endurance]    Script Date: 01/25/2014 12:18:35 ******/
ALTER TABLE [dbo].[GItem] ADD  CONSTRAINT [DF_GItem_Endurance]  DEFAULT ((-1)) FOR [Endurance]
GO
IF OBJECT_ID(N'[dbo].[DF_GIs30Min_EventType]') IS NULL
/****** Object:  Default [DF_GIs30Min_EventType]    Script Date: 01/25/2014 12:18:35 ******/
ALTER TABLE [dbo].[GIs30Min] ADD  CONSTRAINT [DF_GIs30Min_EventType]  DEFAULT ((0)) FOR [EventType]
GO
IF OBJECT_ID(N'[dbo].[DF_GGuild_Member_EXP]') IS NULL
/****** Object:  Default [DF_GGuild_Member_EXP]    Script Date: 01/25/2014 12:18:35 ******/
ALTER TABLE [dbo].[GGuild_Member] ADD  CONSTRAINT [DF_GGuild_Member_EXP]  DEFAULT ((0)) FOR [EXP]
GO
IF OBJECT_ID(N'[dbo].[DF_GEvent_RewardUser_RegDate]') IS NULL
/****** Object:  Default [DF_GEvent_RewardUser_RegDate]    Script Date: 01/25/2014 12:18:36 ******/
ALTER TABLE [dbo].[GEvent_RewardUser] ADD  CONSTRAINT [DF_GEvent_RewardUser_RegDate]  DEFAULT (getdate()) FOR [RegDate]
GO
IF OBJECT_ID(N'[dbo].[DF_GEvent_RewardUnit_RegDate]') IS NULL
/****** Object:  Default [DF_GEvent_RewardUnit_RegDate]    Script Date: 01/25/2014 12:18:36 ******/
ALTER TABLE [dbo].[GEvent_RewardUnit] ADD  CONSTRAINT [DF_GEvent_RewardUnit_RegDate]  DEFAULT (getdate()) FOR [RegDate]
GO
IF OBJECT_ID(N'[dbo].[DF_GEvent_CombackUser_IsReward]') IS NULL
/****** Object:  Default [DF_GEvent_CombackUser_IsReward]    Script Date: 01/25/2014 12:18:36 ******/
ALTER TABLE [dbo].[GEvent_CombackUser] ADD  CONSTRAINT [DF_GEvent_CombackUser_IsReward]  DEFAULT ((0)) FOR [IsReward]
GO
IF OBJECT_ID(N'[dbo].[DF_Get_Super_EL_Info_RegDate]') IS NULL
/****** Object:  Default [DF_Get_Super_EL_Info_RegDate]    Script Date: 01/25/2014 12:18:36 ******/
ALTER TABLE [dbo].[Get_Super_EL_Info] ADD  CONSTRAINT [DF_Get_Super_EL_Info_RegDate]  DEFAULT (getdate()) FOR [RegDate]
GO
IF OBJECT_ID(N'[dbo].[DF_Get_EL_Info_RegDate]') IS NULL
/****** Object:  Default [DF_Get_EL_Info_RegDate]    Script Date: 01/25/2014 12:18:36 ******/
ALTER TABLE [dbo].[Get_EL_Info] ADD  CONSTRAINT [DF_Get_EL_Info_RegDate]  DEFAULT (getdate()) FOR [RegDate]
GO
IF OBJECT_ID(N'[dbo].[DF_GDungeonClear_MaxScore]') IS NULL
/****** Object:  Default [DF_GDungeonClear_MaxScore]    Script Date: 01/25/2014 12:18:36 ******/
ALTER TABLE [dbo].[GDungeonClear] ADD  CONSTRAINT [DF_GDungeonClear_MaxScore]  DEFAULT ((0)) FOR [MaxScore]
GO
IF OBJECT_ID(N'[dbo].[DF_GDungeonClear_MaxTotalRank]') IS NULL
/****** Object:  Default [DF_GDungeonClear_MaxTotalRank]    Script Date: 01/25/2014 12:18:36 ******/
ALTER TABLE [dbo].[GDungeonClear] ADD  CONSTRAINT [DF_GDungeonClear_MaxTotalRank]  DEFAULT ((0)) FOR [MaxTotalRank]
GO
IF OBJECT_ID(N'[dbo].[DF_GCreateUnitCnt_CNT]') IS NULL
/****** Object:  Default [DF_GCreateUnitCnt_CNT]    Script Date: 01/25/2014 12:18:36 ******/
ALTER TABLE [dbo].[GCreateUnitCnt] ADD  CONSTRAINT [DF_GCreateUnitCnt_CNT]  DEFAULT ((1)) FOR [CNT]
GO
CREATE OR ALTER PROCEDURE [dbo].[P_LSquareTable_SEL]
	@int1	INT,
	@str1	[nvarchar](64)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT 1 as COLUMNAME
	RETURN
END
GO
CREATE OR ALTER PROCEDURE [dbo].[P_LServerList_UPD]
	@int1	INT,
	@int2	INT,
	@int3	INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT 1 as COLUMNAME
	RETURN
END
GO
CREATE OR ALTER PROCEDURE [dbo].[P_LServerList_By_PublicIP_SEL]
	@int1	INT,
	@int2	INT,
	@str1	[nvarchar](64)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT 1 as COLUMNAME
	RETURN
END
GO
CREATE OR ALTER PROCEDURE [dbo].[P_LCenterProxy_By_ServerUID_SEL]
	@int1	INT,
	@int2	INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT 1 as COLUMNAME
	RETURN
END
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_update_arcade_rank_server]
	@iRank		tinyint
,	@iGameMode	int
,	@iStageCnt	tinyint
,	@iPlayTime	int 
,	@sdtRegDate	smalldatetime
,	@strUnit1	nvarchar(16)
,	@strUnit2	nvarchar(16)
,	@strUnit3	nvarchar(16)
,	@strUnit4	nvarchar(16)
,	@iUnitUID1	bigint
,	@iUnitUID2	bigint
,	@iUnitUID3	bigint
,	@iUnitUID4	bigint
,	@iOK		int = 0



AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRAN
	IF NOT EXISTS (SELECT * FROM dbo.Rank_Arcade_Server WITH (NOLOCK) WHERE GameMode = @iGameMode AND Rank = @iRank)
		BEGIN
			INSERT INTO dbo.Rank_Arcade_Server (Rank, GameMode, StageCnt, PlayTime, RegDate, Unit1, Unit2, Unit3, Unit4, UnitUID1, UnitUID2, UnitUID3, UnitUID4)
				SELECT @iRank, @iGameMode, @iStageCnt, @iPlayTime, @sdtRegDate, @strUnit1, @strUnit2, @strUnit3, @strUnit4, @iUnitUID1, @iUnitUID2, @iUnitUID3, @iUnitUID4
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END
			GOTO COMMIT_TRAN
		END

		UPDATE dbo.Rank_Arcade_Server WITH (UPDLOCK)
			SET StageCnt = @iStageCnt,	
				PlayTime = @iPlayTime,	
				RegDate	= @sdtRegDate,	
				Unit1 = @strUnit1,
				Unit2 = @strUnit2,
				Unit3 = @strUnit3,	
				Unit4 = @strUnit4,	
				UnitUID1 = @iUnitUID1,	
				UnitUID2 = @iUnitUID2,	
				UnitUID3 = @iUnitUID3,
				UnitUID4 = @iUnitUID4
			WHERE GameMode = @iGameMode AND Rank = @iRank

COMMIT_TRAN:
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[lup_select_arcade_rank_server]


AS
SET NOCOUNT ON;
SET XACT_ABORT ON;


	SELECT Rank, GameMode, StageCnt, PlayTime, RegDate, Unit1, Unit2, Unit3, Unit4, UnitUID1, UnitUID2, UnitUID3, UnitUID4
		FROM dbo.Rank_Arcade_Server WITH (NOLOCK)
			ORDER BY RANK OPTION (MAXDOP 1)
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_unit_equip_list]
	@iUnitUID_ [bigint]
AS
SET NOCOUNT ON;

SELECT ItemUID
    FROM dbo.GUnitEquip WITH(NOLOCK)
        WHERE UnitUID = @iUnitUID_
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_point_kill]
	@iUnitUID	BIGINT
,	@iKillUID	BIGINT	
,	@iOK		INT = 0	
/*
	2009. 08. 26
	sutamtwo
	Kill Point 쓰기
*/	
	
AS 
SET NOCOUNT ON;


BEGIN TRAN
	INSERT INTO dbo.GEvent_Vs_Kill (UnitUID, KillUID)
		SELECT @iUnitUID, @iKillUID
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN SELECT @iOK = 0 GOTO FAIL_TRAN END
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_point_kill]
	@iUnitUID	BIGINT
,	@iOK		INT = 0	
/*
	2009. 08. 26
	sutamtwo
	Kill Point 읽기
*/	
	
AS 
SET NOCOUNT ON;

SELECT KillUID FROM dbo.GEvent_Vs_Kill WITH (NOLOCK)
	WHERE UnitUID = @iUnitUID
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_point_death]
	@iUnitUID	BIGINT
,	@iDeathUID	BIGINT
,	@iOK		INT = 0	
/*
	2009. 08. 26
	sutamtwo
	Death Point 쓰기
*/	
	
AS 
SET NOCOUNT ON;

BEGIN TRAN
	INSERT INTO dbo.GEvent_Vs_Death (UnitUID, DeathUID)
		SELECT @iUnitUID, @iDeathUID
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN SELECT @iOK = 0 GOTO FAIL_TRAN END
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_point_death]
	@iUnitUID	BIGINT

/*
	2009. 08. 26
	sutamtwo
	Death Point 읽기
*/	
	
AS 
SET NOCOUNT ON;

SELECT DeathUID FROM dbo.GEvent_Vs_Death WITH (NOLOCK)
	WHERE UnitUID = @iUnitUID
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_point_timespace]
	@iUnitUID	BIGINT
,	@iPoint		SMALLINT
,	@iOK		INT = 0	
/*
	2009. 08. 26
	sutamtwo
	시공 포인트 쓰기
*/	
	
AS 
SET NOCOUNT ON;

BEGIN TRAN

IF NOT EXISTS (SELECT 1 FROM dbo.GEvent_TimeSpace_Point WITH (NOLOCK) WHERE UnitUID = @iUnitUID)
	BEGIN
		INSERT INTO dbo.GEvent_TimeSpace_Point (UnitUID, MyPoint)
			SELECT @iUnitUID, @iPoint
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN
				SELECT @iOK = -1	GOTO FAIL_TRAN
			END
	END

ELSE
	BEGIN
		UPDATE dbo.GEvent_TimeSpace_Point 
			SET MyPoint = @iPoint
				WHERE UnitUID = @iUnitUID
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN
				SELECT @iOK = -2	GOTO FAIL_TRAN
			END
	END
	
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_point_timespace]
	@iUnitUID		BIGINT
	
	
/*
	2009. 08. 26
	sutamtwo
	시공 포인트 읽기
*/	
	
AS 
SET NOCOUNT ON;

SELECT MyPoint FROM dbo.GEvent_TimeSpace_Point WITH (NOLOCK)
	WHERE UnitUID = @iUnitUID
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_event_stone110]
(
	@iUnitUID	BIGINT
,	@iCount		TINYINT
,	@iOK		INT = 0
)

AS
/*
	2010.02.23
	sutamtwo
	부활석 110개 구매한 유저의 사용값 업데이트
*/
SET NOCOUNT ON ;

BEGIN TRAN

	UPDATE dbo.GEvent_Stone110
		SET [Count] = [Count] + @iCount
	WHERE UnitUID = @iUnitUID

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_insert_rank_timespace]
	@iRank			TINYINT
,	@iUnitUID		BIGINT
,	@strNickName	NVARCHAR(16)
,	@iUnitClass		TINYINT
,	@iLevel			TINYINT
,	@iPoint			SMALLINT
,	@sdtRegDate		SMALLDATETIME
	
	
/*
	2009. 08. 26
	sutamtwo
	시공 랭킹 넣기
*/	
	
AS 
SET NOCOUNT ON;

INSERT INTO dbo.GEvent_Rank_TimeSpace ([Rank], UnitUID, NickName, UnitClass, [Level], Point)
	SELECT @iRank,	@iUnitUID,	@strNickName, @iUnitClass, @iLevel, @iPoint
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_delete_rank_time_space]
	
	
/*
	2009. 08. 26
	sutamtwo
	시공 랭킹 비우기
*/	
	
AS 
SET NOCOUNT ON;

TRUNCATE TABLE dbo.GEvent_Rank_TimeSpace
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_insert_rank_dungeon]
	@iRank			TINYINT
,	@iUnitUID		BIGINT
,	@strNickName	NVARCHAR(16)
,	@iUnitClass		TINYINT
,	@iLevel			TINYINT
,	@iPoint			SMALLINT
,	@sdtRegDate		SMALLDATETIME
	
	
/*
	2009. 08. 26
	sutamtwo
	일간 랭킹 넣기
*/	
	
AS 
SET NOCOUNT ON;

INSERT INTO dbo.GEvent_Rank_Dungeon ([Rank], UnitUID, NickName, UnitClass, [Level], Point)
	SELECT @iRank,	@iUnitUID,	@strNickName, @iUnitClass, @iLevel, @iPoint
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_delete_rank_dungeon]
	
	
/*
	2009. 08. 26
	sutamtwo
	던전 랭킹 비우기
*/	
	
AS 
SET NOCOUNT ON;

TRUNCATE TABLE dbo.GEvent_Rank_Dungeon
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_point_dungeon]
	@iUnitUID	BIGINT
,	@iPoint		SMALLINT
,	@iOK		INT = 0	
/*
	2009. 08. 26
	sutamtwo
	던전 포인트 쓰기
*/	
	
AS 
SET NOCOUNT ON;

BEGIN TRAN

IF NOT EXISTS (SELECT 1 FROM dbo.GEvent_Dungeon_Point WITH (NOLOCK) WHERE UnitUID = @iUnitUID)
	BEGIN
		INSERT INTO dbo.GEvent_Dungeon_Point (UnitUID, MyPoint)
			SELECT @iUnitUID, @iPoint
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN
				SELECT @iOK = -1	GOTO FAIL_TRAN
			END
	END

ELSE
	BEGIN
		UPDATE dbo.GEvent_Dungeon_Point 
			SET MyPoint = @iPoint
				WHERE UnitUID = @iUnitUID
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN
				SELECT @iOK = -2	GOTO FAIL_TRAN
			END
	END
	
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_point_dungeon]
	@iUnitUID		BIGINT
	
	
/*
	2009. 08. 26
	sutamtwo
	던전 포인트 읽기
*/	
	
AS 
SET NOCOUNT ON;

SELECT MyPoint FROM dbo.GEvent_Dungeon_Point WITH (NOLOCK)
	WHERE UnitUID = @iUnitUID
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_insert_charmitem_log]
	@iUserUID	BIGINT
,	@iUnitUID	BIGINT	
,	@iOK		INT = 0

AS

SET NOCOUNT ON;


BEGIN TRAN
	INSERT INTO dbo.GEvent_CharmItem (UserUID, UnitUID, RegDate)
		SELECT @iUserUID, @iUnitUID, GETDATE()
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
CREATE OR ALTER PROCEDURE [dbo].[gup_check_charmitem]
	@iUserUID	BIGINT


AS

SET NOCOUNT ON;

SELECT COUNT(1)
	FROM dbo.GEvent_CharmItem WITH (NOLOCK)
		WHERE UserUID = @iUserUID
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GDarkGate_Itemeffect_SEL]
	@UnitUID 		BIGINT
/*
	어둠의 문 영약 사용 시각 데이터 가져가기
	작성자: Hwang
*/
AS
	SET NOCOUNT ON
	
	DECLARE @ItemType	int
		,	@UseDate	datetime

	SELECT @ItemType = ItemType, @UseDate = UseDate
	FROM dbo.GDarkGate_Itemeffect WITH(NOLOCK)
	WHERE UnitUID = @UnitUID
	
	IF @@ROWCOUNT = 0
		SELECT -1, @ItemType AS ItemType, @UseDate AS UseDate
	ELSE
		SELECT 0, ItemType, UseDate
		FROM dbo.GDarkGate_Itemeffect WITH(NOLOCK)
		WHERE UnitUID = @UnitUID
GO
/*
	넥슨 웹 콘솔
	계정 제재와 관련하여 상태, 캐릭터명, 제재사유, 제재자, 제제일, 시작일, 종료일 
	2008.09.08 
	sutamtwo
*/
CREATE OR ALTER PROCEDURE [dbo].[gcp_get_character_block_info]
	@strNickName	nvarchar(20)
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE	@iUnitUID		BIGINT
,		@iUserUID		BIGINT
,		@iauthlevel		INT
,		@strReason		NVARCHAR(100)
,		@strsession		NVARCHAR(16)
,		@sdtstartdate	SMALLDATETIME
,		@sdtenddate		SMALLDATETIME


	SELECT	@iUnitUID = UnitUID
		FROM dbo.GUnitNickName WITH (NOLOCK)
			WHERE NickName = @strNickName

	SELECT	@iUserUID = UserUID
		FROM dbo.GUnit WITH (NOLOCK)
			WHERE UnitUID = @iUnitUID

	EXEC [account].dbo.mcp_get_character_block_info @iUserUID, 
										  @iauthlevel OUTPUT,
										  @strReason OUTPUT,
										  @strsession OUTPUT,
										  @sdtstartdate OUTPUT,
										  @sdtenddate OUTPUT


	SELECT	CASE @iauthlevel	
			WHEN 0	THEN '정상'
			WHEN -1	THEN '경고'
			WHEN -2	THEN '7일 정지'
			WHEN -3	THEN '30일 정지'
			WHEN -4	THEN '영구 정지'
		END AS authlevel,
			@strNickName,
			@strReason AS reason,
			@strsession AS session,
			@sdtstartdate AS startdate,
			@sdtenddate AS enddate
GO
/*
	넥슨 웹 콘솔
	넥슨ID, 캐릭터 생성일, 마지막 로그인IP, 마지막 로그인, 마지막 로그아웃 
	2008.09.08 
	sutamtwo
*/
CREATE OR ALTER PROCEDURE [dbo].[gcp_get_character_base_info] 
	@strNickName	nvarchar(20)
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE	@iUnitUID		BIGINT
,		@iUserUID		BIGINT
,		@iUserID		NVARCHAR(24)
,		@sdtRegDate		SMALLDATETIME
,		@strIP			NVARCHAR(15)
,		@sdtLoginTime	SMALLDATETIME
,		@sdtLogoutTime	SMALLDATETIME

SELECT	@iUnitUID = UnitUID
	FROM dbo.GUnitNickName WITH (NOLOCK)
		WHERE NickName = @strNickName

SELECT	@iUserUID = a.UserUID
,		@sdtRegDate = a.RegDate
,		@iUserID = b.UserID
	FROM dbo.GUnit AS a WITH (NOLOCK)
	JOIN dbo.GUser AS b WITH (NOLOCK) ON a.UserUID = b.UserUID
		WHERE UnitUID = @iUnitUID

	-- 최근 접속했던 IP/로그인/로그아웃
	EXEC [Statistics].dbo.lcp_get_character_base_info @iUserUID, @strIP OUTPUT, @sdtLoginTime OUTPUT,	@sdtLogoutTime OUTPUT


SELECT @iUserID AS UserID, @sdtRegDate, @strIP AS Y, @sdtLoginTime AS Z, @sdtLogoutTime AS Q
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GCoolTime_SEL]
	@UnitUID 		BIGINT
/*
	게임 플레이 정보
	작성자: Hwang
*/
AS
	SET NOCOUNT ON

	SELECT CoolType, CoolID, CoolTime
	FROM dbo.GCoolTime WITH(NOLOCK)
	WHERE UnitUID = @UnitUID
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GCoolTime_INS_Quick]
	@iUnitUID		bigint
,	@iCoolType		tinyint
,	@iCoolID_0		int
,	@iCoolTime_0	int
,	@iCoolID_1		int
,	@iCoolTime_1	int
,	@iCoolID_2		int
,	@iCoolTime_2	int
,	@iCoolID_3		int
,	@iCoolTime_3	int
,	@iCoolID_4		int
,	@iCoolTime_4	int
,	@iCoolID_5		int
,	@iCoolTime_5	int
,	@iCoolID_6		int
,	@iCoolTime_6	int
,	@iCoolID_7		int
,	@iCoolTime_7	int
,	@iCoolID_8		int
,	@iCoolTime_8	int
,	@iCoolID_9		int
,	@iCoolTime_9	int

AS
	SET NOCOUNT ON

	DECLARE @Result		int

	IF NOT EXISTS (SELECT 1 FROM dbo.GUnit WITH(NOLOCK) WHERE UnitUID = @iUnitUID)
		SET @Result = -1
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN

			IF @iCoolID_0 > -1 BEGIN 
				IF EXISTS ( SELECT * FROM dbo.GCoolTime WITH(NOLOCK) WHERE UnitUID = @iUnitUID and CoolType = @iCoolType and CoolID = @iCoolID_0 ) BEGIN
					SET @Result = -2

					UPDATE dbo.GCoolTime
					SET CoolTime = @iCoolTime_0
					WHERE UnitUID = @iUnitUID and CoolType = @iCoolType and CoolID = @iCoolID_0
				END
				ELSE BEGIN
					SET @Result = -3

					INSERT INTO	dbo.GCoolTime ( UnitUID, CoolType, CoolID, CoolTime )
					VALUES ( @iUnitUID, @iCoolType, @iCoolID_0, @iCoolTime_0 )
				END
			END
			
			IF @iCoolID_1 > -1 BEGIN 
				IF EXISTS ( SELECT * FROM dbo.GCoolTime WITH(NOLOCK) WHERE UnitUID = @iUnitUID and CoolType = @iCoolType and CoolID = @iCoolID_1 ) BEGIN
					SET @Result = -4

					UPDATE dbo.GCoolTime
					SET CoolTime = @iCoolTime_1
					WHERE UnitUID = @iUnitUID and CoolType = @iCoolType and CoolID = @iCoolID_1
				END
				ELSE BEGIN
					SET @Result = -5

					INSERT INTO	dbo.GCoolTime ( UnitUID, CoolType, CoolID, CoolTime )
					VALUES ( @iUnitUID, @iCoolType, @iCoolID_1, @iCoolTime_1 )
				END
			END
			
			IF @iCoolID_2 > -1 BEGIN 
				IF EXISTS ( SELECT * FROM dbo.GCoolTime WITH(NOLOCK) WHERE UnitUID = @iUnitUID and CoolType = @iCoolType and CoolID = @iCoolID_2 ) BEGIN
					SET @Result = -6

					UPDATE dbo.GCoolTime
					SET CoolTime = @iCoolTime_2
					WHERE UnitUID = @iUnitUID and CoolType = @iCoolType and CoolID = @iCoolID_2
				END
				ELSE BEGIN
					SET @Result = -7

					INSERT INTO	dbo.GCoolTime ( UnitUID, CoolType, CoolID, CoolTime )
					VALUES ( @iUnitUID, @iCoolType, @iCoolID_2, @iCoolTime_2 )
				END
			END
			
			IF @iCoolID_3 > -1 BEGIN 
				IF EXISTS ( SELECT * FROM dbo.GCoolTime WITH(NOLOCK) WHERE UnitUID = @iUnitUID and CoolType = @iCoolType and CoolID = @iCoolID_3 ) BEGIN
					SET @Result = -8

					UPDATE dbo.GCoolTime
					SET CoolTime = @iCoolTime_3
					WHERE UnitUID = @iUnitUID and CoolType = @iCoolType and CoolID = @iCoolID_3
				END
				ELSE BEGIN
					SET @Result = -9

					INSERT INTO	dbo.GCoolTime ( UnitUID, CoolType, CoolID, CoolTime )
					VALUES ( @iUnitUID, @iCoolType, @iCoolID_3, @iCoolTime_3 )
				END
			END
			
			IF @iCoolID_4 > -1 BEGIN 
				IF EXISTS ( SELECT * FROM dbo.GCoolTime WITH(NOLOCK) WHERE UnitUID = @iUnitUID and CoolType = @iCoolType and CoolID = @iCoolID_4 ) BEGIN
					SET @Result = -10

					UPDATE dbo.GCoolTime
					SET CoolTime = @iCoolTime_4
					WHERE UnitUID = @iUnitUID and CoolType = @iCoolType and CoolID = @iCoolID_4
				END
				ELSE BEGIN
					SET @Result = -11

					INSERT INTO	dbo.GCoolTime ( UnitUID, CoolType, CoolID, CoolTime )
					VALUES ( @iUnitUID, @iCoolType, @iCoolID_4, @iCoolTime_4 )
				END
			END
			
			IF @iCoolID_5 > -1 BEGIN 
				IF EXISTS ( SELECT * FROM dbo.GCoolTime WITH(NOLOCK) WHERE UnitUID = @iUnitUID and CoolType = @iCoolType and CoolID = @iCoolID_5 ) BEGIN
					SET @Result = -12

					UPDATE dbo.GCoolTime
					SET CoolTime = @iCoolTime_5
					WHERE UnitUID = @iUnitUID and CoolType = @iCoolType and CoolID = @iCoolID_5
				END
				ELSE BEGIN
					SET @Result = -13

					INSERT INTO	dbo.GCoolTime ( UnitUID, CoolType, CoolID, CoolTime )
					VALUES ( @iUnitUID, @iCoolType, @iCoolID_5, @iCoolTime_5 )
				END
			END
			IF @iCoolID_6 > -1 BEGIN 
				IF EXISTS ( SELECT * FROM dbo.GCoolTime WITH(NOLOCK) WHERE UnitUID = @iUnitUID and CoolType = @iCoolType and CoolID = @iCoolID_6 ) BEGIN
					SET @Result = -14

					UPDATE dbo.GCoolTime
					SET CoolTime = @iCoolTime_6
					WHERE UnitUID = @iUnitUID and CoolType = @iCoolType and CoolID = @iCoolID_6
				END
				ELSE BEGIN
					SET @Result = -15

					INSERT INTO	dbo.GCoolTime ( UnitUID, CoolType, CoolID, CoolTime )
					VALUES ( @iUnitUID, @iCoolType, @iCoolID_6, @iCoolTime_6 )
				END
			END
			IF @iCoolID_7 > -1 BEGIN 
				IF EXISTS ( SELECT * FROM dbo.GCoolTime WITH(NOLOCK) WHERE UnitUID = @iUnitUID and CoolType = @iCoolType and CoolID = @iCoolID_7 ) BEGIN
					SET @Result = -16

					UPDATE dbo.GCoolTime
					SET CoolTime = @iCoolTime_7
					WHERE UnitUID = @iUnitUID and CoolType = @iCoolType and CoolID = @iCoolID_7
				END
				ELSE BEGIN
					SET @Result = -17

					INSERT INTO	dbo.GCoolTime ( UnitUID, CoolType, CoolID, CoolTime )
					VALUES ( @iUnitUID, @iCoolType, @iCoolID_7, @iCoolTime_7 )
				END
			END
			IF @iCoolID_8 > -1 BEGIN 
				IF EXISTS ( SELECT * FROM dbo.GCoolTime WITH(NOLOCK) WHERE UnitUID = @iUnitUID and CoolType = @iCoolType and CoolID = @iCoolID_8 ) BEGIN
					SET @Result = -18

					UPDATE dbo.GCoolTime
					SET CoolTime = @iCoolTime_8
					WHERE UnitUID = @iUnitUID and CoolType = @iCoolType and CoolID = @iCoolID_8
				END
				ELSE BEGIN
					SET @Result = -19

					INSERT INTO	dbo.GCoolTime ( UnitUID, CoolType, CoolID, CoolTime )
					VALUES ( @iUnitUID, @iCoolType, @iCoolID_8, @iCoolTime_8 )
				END
			END
			IF @iCoolID_9 > -1 BEGIN 
				IF EXISTS ( SELECT * FROM dbo.GCoolTime WITH(NOLOCK) WHERE UnitUID = @iUnitUID and CoolType = @iCoolType and CoolID = @iCoolID_9 ) BEGIN
					SET @Result = -20

					UPDATE dbo.GCoolTime
					SET CoolTime = @iCoolTime_9
					WHERE UnitUID = @iUnitUID and CoolType = @iCoolType and CoolID = @iCoolID_9
				END
				ELSE BEGIN
					SET @Result = -21

					INSERT INTO	dbo.GCoolTime ( UnitUID, CoolType, CoolID, CoolTime )
					VALUES ( @iUnitUID, @iCoolType, @iCoolID_9, @iCoolTime_9 )
				END
			END
			
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
				SET @Result = -100
		END CATCH
	END

	SELECT ISNULL(@Result, 0) AS Result
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GCoolTime_INS_New]
	@iUnitUID		bigint
,	@iCoolType		tinyint
,	@iCoolID_0		int
,	@iCoolTime_0	int
,	@iCoolID_1		int
,	@iCoolTime_1	int
,	@iCoolID_2		int
,	@iCoolTime_2	int
,	@iCoolID_3		int
,	@iCoolTime_3	int
,	@iCoolID_4		int
,	@iCoolTime_4	int
,	@iCoolID_5		int
,	@iCoolTime_5	int
,	@iCoolID_6		int
,	@iCoolTime_6	int
,	@iCoolID_7		int
,	@iCoolTime_7	int


/*
	쿨타임 저장
	(CoolType  0: 스킬, 1: 퀵슬롯
	작성자: Hwang
*/
AS
	SET NOCOUNT ON

	DECLARE @Result		int

	IF NOT EXISTS (SELECT 1 FROM dbo.GUnit WITH(NOLOCK) WHERE UnitUID = @iUnitUID)
		SET @Result = -1
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN

			IF @iCoolID_0 > -1 BEGIN 
				IF EXISTS ( SELECT * FROM dbo.GCoolTime WITH(NOLOCK) WHERE UnitUID = @iUnitUID and CoolType = @iCoolType and CoolID = @iCoolID_0 ) BEGIN
					SET @Result = -2

					UPDATE dbo.GCoolTime
					SET CoolTime = @iCoolTime_0
					WHERE UnitUID = @iUnitUID and CoolType = @iCoolType and CoolID = @iCoolID_0
				END
				ELSE BEGIN
					SET @Result = -3

					INSERT INTO	dbo.GCoolTime ( UnitUID, CoolType, CoolID, CoolTime )
					VALUES ( @iUnitUID, @iCoolType, @iCoolID_0, @iCoolTime_0 )
				END
			END
			
			IF @iCoolID_1 > -1 BEGIN 
				IF EXISTS ( SELECT * FROM dbo.GCoolTime WITH(NOLOCK) WHERE UnitUID = @iUnitUID and CoolType = @iCoolType and CoolID = @iCoolID_1 ) BEGIN
					SET @Result = -4

					UPDATE dbo.GCoolTime
					SET CoolTime = @iCoolTime_1
					WHERE UnitUID = @iUnitUID and CoolType = @iCoolType and CoolID = @iCoolID_1
				END
				ELSE BEGIN
					SET @Result = -5

					INSERT INTO	dbo.GCoolTime ( UnitUID, CoolType, CoolID, CoolTime )
					VALUES ( @iUnitUID, @iCoolType, @iCoolID_1, @iCoolTime_1 )
				END
			END
			
			IF @iCoolID_2 > -1 BEGIN 
				IF EXISTS ( SELECT * FROM dbo.GCoolTime WITH(NOLOCK) WHERE UnitUID = @iUnitUID and CoolType = @iCoolType and CoolID = @iCoolID_2 ) BEGIN
					SET @Result = -6

					UPDATE dbo.GCoolTime
					SET CoolTime = @iCoolTime_2
					WHERE UnitUID = @iUnitUID and CoolType = @iCoolType and CoolID = @iCoolID_2
				END
				ELSE BEGIN
					SET @Result = -7

					INSERT INTO	dbo.GCoolTime ( UnitUID, CoolType, CoolID, CoolTime )
					VALUES ( @iUnitUID, @iCoolType, @iCoolID_2, @iCoolTime_2 )
				END
			END
			
			IF @iCoolID_3 > -1 BEGIN 
				IF EXISTS ( SELECT * FROM dbo.GCoolTime WITH(NOLOCK) WHERE UnitUID = @iUnitUID and CoolType = @iCoolType and CoolID = @iCoolID_3 ) BEGIN
					SET @Result = -8

					UPDATE dbo.GCoolTime
					SET CoolTime = @iCoolTime_3
					WHERE UnitUID = @iUnitUID and CoolType = @iCoolType and CoolID = @iCoolID_3
				END
				ELSE BEGIN
					SET @Result = -9

					INSERT INTO	dbo.GCoolTime ( UnitUID, CoolType, CoolID, CoolTime )
					VALUES ( @iUnitUID, @iCoolType, @iCoolID_3, @iCoolTime_3 )
				END
			END
			
			IF @iCoolID_4 > -1 BEGIN 
				IF EXISTS ( SELECT * FROM dbo.GCoolTime WITH(NOLOCK) WHERE UnitUID = @iUnitUID and CoolType = @iCoolType and CoolID = @iCoolID_4 ) BEGIN
					SET @Result = -10

					UPDATE dbo.GCoolTime
					SET CoolTime = @iCoolTime_4
					WHERE UnitUID = @iUnitUID and CoolType = @iCoolType and CoolID = @iCoolID_4
				END
				ELSE BEGIN
					SET @Result = -11

					INSERT INTO	dbo.GCoolTime ( UnitUID, CoolType, CoolID, CoolTime )
					VALUES ( @iUnitUID, @iCoolType, @iCoolID_4, @iCoolTime_4 )
				END
			END
			
			IF @iCoolID_5 > -1 BEGIN 
				IF EXISTS ( SELECT * FROM dbo.GCoolTime WITH(NOLOCK) WHERE UnitUID = @iUnitUID and CoolType = @iCoolType and CoolID = @iCoolID_5 ) BEGIN
					SET @Result = -12

					UPDATE dbo.GCoolTime
					SET CoolTime = @iCoolTime_5
					WHERE UnitUID = @iUnitUID and CoolType = @iCoolType and CoolID = @iCoolID_5
				END
				ELSE BEGIN
					SET @Result = -13

					INSERT INTO	dbo.GCoolTime ( UnitUID, CoolType, CoolID, CoolTime )
					VALUES ( @iUnitUID, @iCoolType, @iCoolID_5, @iCoolTime_5 )
				END
			END
			
			IF @iCoolID_6 > -1 BEGIN 
				IF EXISTS ( SELECT * FROM dbo.GCoolTime WITH(NOLOCK) WHERE UnitUID = @iUnitUID and CoolType = @iCoolType and CoolID = @iCoolID_6 ) BEGIN
					SET @Result = -14

					UPDATE dbo.GCoolTime
					SET CoolTime = @iCoolTime_6
					WHERE UnitUID = @iUnitUID and CoolType = @iCoolType and CoolID = @iCoolID_6
				END
				ELSE BEGIN
					SET @Result = -15

					INSERT INTO	dbo.GCoolTime ( UnitUID, CoolType, CoolID, CoolTime )
					VALUES ( @iUnitUID, @iCoolType, @iCoolID_6, @iCoolTime_6 )
				END
			END
			
			IF @iCoolID_7 > -1 BEGIN 
				IF EXISTS ( SELECT * FROM dbo.GCoolTime WITH(NOLOCK) WHERE UnitUID = @iUnitUID and CoolType = @iCoolType and CoolID = @iCoolID_7 ) BEGIN
					SET @Result = -16

					UPDATE dbo.GCoolTime
					SET CoolTime = @iCoolTime_7
					WHERE UnitUID = @iUnitUID and CoolType = @iCoolType and CoolID = @iCoolID_7
				END
				ELSE BEGIN
					SET @Result = -17

					INSERT INTO	dbo.GCoolTime ( UnitUID, CoolType, CoolID, CoolTime )
					VALUES ( @iUnitUID, @iCoolType, @iCoolID_7, @iCoolTime_7 )
				END
			END

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
				SET @Result = -100
		END CATCH
	END

	SELECT ISNULL(@Result, 0) AS Result
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GCoolTime_INS]
	@iUnitUID	bigint
,	@iCoolType	tinyint
,	@iCoolID	int
,	@iCoolTime	int

/*
	쿨타임 저장
	(CoolType  1: 스킬, 2: 퀵슬롯
	작성자: Hwang
*/
AS
	SET NOCOUNT ON

	DECLARE @Result		int

	IF NOT EXISTS (SELECT 1 FROM dbo.GUnit WITH(NOLOCK) WHERE UnitUID = @iUnitUID)
		SET @Result = -1
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN

			IF EXISTS ( SELECT * FROM dbo.GCoolTime WITH(NOLOCK) WHERE UnitUID = @iUnitUID and CoolType = @iCoolType and CoolID = @iCoolID ) BEGIN
				SET @Result = -2

				UPDATE dbo.GCoolTime
				SET CoolTime = @iCoolTime
				WHERE UnitUID = @iUnitUID and CoolType = @iCoolType and CoolID = @iCoolID
			END
			ELSE BEGIN
				SET @Result = -3

				INSERT INTO	dbo.GCoolTime ( UnitUID, CoolType, CoolID, CoolTime )
				VALUES ( @iUnitUID, @iCoolType, @iCoolID, @iCoolTime )
			END

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
CREATE OR ALTER PROCEDURE [dbo].[P_GCBTEventData_NickName_CHK]
	@UserID		NVARCHAR(200)
,	@NickName	NVARCHAR(200)
AS

SET NOCOUNT ON

DECLARE @Result INT
DECLARE @TempUserID NVARCHAR(200)

SELECT @TempUserID = UserID
FROM dbo.GCBTEventData_NickName WITH(NOLOCK)
WHERE NickName = @NickName

--예약된 닉네임이 아니거나 자신이 에약한 닉네임 일 경우
IF @TempUserID IS NULL OR @TempUserID = @UserID
	SET @Result = 0
ELSE
	SET @Result = -1
	
SELECT @Result
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GCBTEventData_Item_CHK]
	@UserID		NVARCHAR(200)
AS

SET NOCOUNT ON

DECLARE @Result TINYINT
DECLARE @Result1 TINYINT
DECLARE @Result2 TINYINT

SET @Result1 = 0
SET @Result2 = 0
	
	
SELECT @Result = HaveItem
FROM dbo.GCBTEventData_Item WITH(NOLOCK)
WHERE UserID = @UserID

IF @@ROWCOUNT = 1
BEGIN
	SET @Result1 = @Result / 10
	SET @Result2 = @Result % 10	
END

--아이템 존재하면 0 없으면 -1 반환
SELECT 
	CASE WHEN @Result1 = 1 THEN 0 ELSE -1 END	--//개척자의 망토
,	CASE WHEN @Result2 = 1 THEN 0 ELSE -1 END	--//엘리트 엘수색대원의 증명
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GBuffeffect_UPD]
	@UnitUID 	BIGINT
,	@BuffID		INT
,	@UseDate	DATETIME
/*
	어둠의 문 영약/비약 사용 및 버프 데이터 기록
	ItemType에는 사용한 영약/비약 및 버프(어둠의문 참가자에게 주는)에 해당하는 버프ID가 입력된다
	작성자: Hwang
*/
AS
	SET NOCOUNT ON
	
	DECLARE @Result	INT

	IF NOT EXISTS ( SELECT * FROM dbo.GUnit WITH(NOLOCK) WHERE UnitUID = @UnitUID )
		SELECT @Result	= -1
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN
			
			IF EXISTS ( SELECT * FROM dbo.GBuffeffect WITH(NOLOCK) WHERE UnitUID = @UnitUID AND BuffID = @BuffID ) BEGIN
				SET @Result = -2

				UPDATE dbo.GBuffeffect
				SET UseDate = @UseDate
				WHERE UnitUID = @UnitUID AND BuffID = @BuffID
				
			END
			ELSE BEGIN
				SET @Result = -3

				INSERT INTO dbo.GBuffeffect ( UnitUID, BuffID, UseDate )
				VALUES( @UnitUID, @BuffID, @UseDate  )
			END

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
CREATE OR ALTER PROCEDURE [dbo].[P_GBuffeffect_SEL]
	@UnitUID 		BIGINT
/*
	어둠의 문 영약 사용 시각 데이터 가져가기
	작성자: Hwang
*/
AS
	SET NOCOUNT ON
	
	DECLARE @BuffID		int
		,	@UseDate	datetime

	SELECT @BuffID = BuffID, @UseDate = UseDate
	FROM dbo.GBuffeffect WITH(NOLOCK)
	WHERE UnitUID = @UnitUID
	
	IF @@ROWCOUNT = 0
		SELECT -1, @BuffID AS BuffID, @UseDate AS UseDate
	ELSE
		SELECT 0, BuffID, UseDate
		FROM dbo.GBuffeffect WITH(NOLOCK)
		WHERE UnitUID = @UnitUID
GO
-- =============================================
-- Author:		YJ
-- Create date: 2011. 11.01
-- Description:	은행공유 체크 테이블, 공유중이 계정, 공유를 최조 시작한 캐릭터 정보 확인
--              sRoute : 1: 퀘스트 2: 캐쉬
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GBankShare_INS]
	@iUserUID	bigint
,	@iUnitUID	bigint
, 	@iRoute		tinyint

AS
SET NOCOUNT ON

DECLARE @Result int

IF EXISTS(SELECT * FROM GBankShare WHERE UserUID = @iUserUID) BEGIN
	SELECT @Result = -2
	RETURN
END

BEGIN TRY
	BEGIN TRAN
		SET @Result = -1

		INSERT INTO dbo.GBankShare (UserUID, UnitUID, sRoute)
		SELECT @iUserUID, @iUnitUID, @iRoute
		
	COMMIT TRAN

	SET @Result = 0
END TRY
BEGIN CATCH
	IF (XACT_STATE()) <> 0
		ROLLBACK TRAN
	
	SET @Result = -1
END CATCH

SELECT @Result
RETURN
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GBankShare_GET_Event]
	@iUserUID	INT
,	@iUnitUID	BIGINT
,	@iItemID	INT

AS
SET NOCOUNT ON

DECLARE @Result		INT 
,		@ChkUnitUID	INT 


IF EXISTS(SELECT * FROM GEventBankShare WHERE UserUID = @iUserUID) BEGIN	
	SET @Result = -1
	GOTO END_PROC	
END

IF NOT EXISTS(SELECT * FROM GBankShare WHERE UserUID = @iUserUID) BEGIN
	SET @Result = -2
	GOTO END_PROC
END

SELECT @ChkUnitUID = UnitUID FROM GBankShare WHERE UserUID = @iUserUID

SET @Result = -3
IF @ChkUnitUID > 0 BEGIN

	SET @Result = -4
	IF @iUnitUID <> @ChkUnitUID BEGIN
		
		BEGIN TRY
			BEGIN TRAN
			
			SET @Result = -1						
			-- 보상 우편 보내기
			/*INSERT INTO dbo.GPost (FromUnitUID,	ToUnitUID, Quantity, ScType, ScIndex, RegDate, DelDate,	Message)
			SELECT @iUnitUID, @iUnitUID, 1, 5, 60003464, GETDATE(), GETDATE(), N'TEST'*/
		
		
			SET @Result = -2
			-- 로그 남기기
			INSERT INTO dbo.GEventBankShare (UserUID, UnitUID, ItemID, RegDate)
			SELECT	@iUserUID, @iUnitUID, @iItemID, GETDATE()
			
			COMMIT TRAN		
			
			SET @Result = 0
			GOTO END_PROC
			
		END TRY
		
		BEGIN CATCH
			IF (XACT_STATE()) <> 0
			ROLLBACK TRAN
			
			SET @Result = -100			
			GOTO END_PROC
		END CATCH			
		
	END
		
END

END_PROC:
SELECT @Result
RETURN
GO
-- =============================================
-- Author:		YJ
-- Create date: 2011. 11.01
-- Description:	은행 공유 여부 체크
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GBankShare_CHK]
	@iUserUID	int

AS
SET NOCOUNT ON

DECLARE @Result int

SET @Result = 1

IF EXISTS(SELECT * FROM GBankShare WHERE UserUID = @iUserUID) BEGIN
	SET @Result = 0
END

SELECT @Result
RETURN
GO
-- =============================================
-- Author:  EJ
-- Create date: 2012-10-09
-- Description: 실시간 광고 시스템 유저 정보 조회
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GAdvertisementEvent_SEL]
	@UserUID	bigint

AS
	SET NOCOUNT ON

	SELECT EventUID FROM dbo.GAdvertisementEvent WITH(NOLOCK) WHERE UserUID = @UserUID
GO
--=====================================================================
-- 필요 프로시저 생성
--=====================================================================

-- =============================================
-- Author:  EJ
-- Create date: 2012-10-09
-- Description: 실시간 광고 시스템 유저 정보 등록
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GAdvertisementEvent_INT]
	@UserUID	bigint
,	@EventUID	int

AS
	SET NOCOUNT ON

	-- 기존 파라미터에서 변수로 변경
	DECLARE @Result			int

	IF EXISTS (SELECT * FROM dbo.GAdvertisementEvent WITH(NOLOCK) WHERE UserUID = @UserUID AND EventUID = @EventUID ) BEGIN
		SET @Result = -1
	END
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN
				INSERT INTO dbo.GAdvertisementEvent ( UserUID, EventUID, Regdate )
				SELECT @UserUID, @EventUID , GETDATE()
			COMMIT TRAN

			SET @Result = 0
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
	END
	
	SELECT @Result AS Result
GO
-- =============================================
-- Author:		JR
-- Create date: 2013. 06. 03
-- Description:	이벤트용 체크 프로시저 (서버로 빼는 작업전 임시로 사용)
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_EventUser_CHK]
	@iUserUID		bigint
,	@iUnitUID		bigint
,	@iEventUID		int
,	@Result			int = 0
AS 
SET NOCOUNT ON;

BEGIN TRAN

	IF NOT EXISTS (SELECT * FROM GEvent_RewardUser WITH(NOLOCK) WHERE UserUID = @iUserUID AND EventUID = @iEventUID)
	BEGIN
	
		INSERT INTO GItem (UnitUID, ItemID, InventoryCategory, SlotID, UsageType, Quantity, Endurance, RegDate, Inserted)
		SELECT @iUnitUID, 60006273, 0, 0, 2, 5, -1, GETDATE(), 119 UNION ALL
		SELECT @iUnitUID, 67005880, 0, 0, 2, 1, -1, GETDATE(), 119
		
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 2
		BEGIN	SELECT @Result = -1	GOTO FAIL_TRAN	END

		INSERT INTO GEvent_RewardUser (UserUID, UnitUID, EventUID, RegDate)
		SELECT @iUserUID, @iUnitUID, @iEventUID, GETDATE()

		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @Result = -2	GOTO FAIL_TRAN	END
		
	END
	
COMMIT TRAN
GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
RETURN @Result
GO
-- =============================================
-- Author:		JR
-- Create date: 2013. 03. 28
-- Description:	이벤트용 체크 프로시저
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_EventUnit_CHK]
	@iUnitUID		[bigint]
AS 
SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE @Result INT
,		@PvPCount SMALLDATETIME

SELECT @PvPCount = OfficialMatchCnt FROM dbo.GUnitPVP WITH(NOLOCK) WHERE UnitUID = @iUnitUID

IF @PvPCount > 0 BEGIN
	SET @Result = 1
END
ELSE BEGIN
	SET @Result = 2
END

SELECT @Result
GO
-- =============================================
-- Author:		YJ
-- Create date: 2012. 02. 25
-- Description:	이벤트 활성화 유무 체크
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_CustomEvent_CHK]
	@UserUID		bigint
,	@iUnitUID		[bigint]
AS 

SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE @Result INT

IF EXISTS (SELECT * FROM Account.dbo.MComebackUserEvent WITH(NOLOCK) WHERE UserUID = @UserUID) 
	SET @Result = 1
ELSE
	SET @Result = 2

SELECT @Result
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_pet_info]
	@iPetUID		 BIGINT,
	@iEvolutionStep	 TINYINT,
	@iSatiety		 SMALLINT,
	@iIntimacy		 INT,
	@iExtroversion	 SMALLINT,
	@iEmotion		 SMALLINT,
	@bAutoFeed		 BIT,
	@sdtLastFeedDate SMALLDATETIME,
	@sdtLastcallDate SMALLDATETIME,
	@iOK			 int = 0

/* 펫 정보 업데이트
  2010-07-26  */
 
AS
SET NOCOUNT ON;


-- 해당 펫이 없는 경우
IF NOT EXISTS( SELECT 1 FROM dbo.GPet_Info WITH( NOLOCK ) WHERE PetUID = @iPetUID)
BEGIN
    SELECT @iOK = -1
    GOTO END_PROC
END

BEGIN TRAN
		BEGIN
			UPDATE dbo.GPet_Info
				SET EvolutionStep = @iEvolutionStep, Satiety = (Satiety + @iSatiety), Intimacy = (Intimacy + @iIntimacy),
				    Extroversion = (Extroversion + @iExtroversion), Emotion = (Emotion + @iEmotion), AutoFeed = @bAutoFeed, 
				    LastFeedDate = @sdtLastFeedDate, LastcallDate = @sdtLastcallDate
					WHERE PetUID = @iPetUID
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN	SELECT @iOK = -2	GOTO FAIL_TRAN	END
			GOTO COMMIT_TRAN
		END
	

COMMIT_TRAN:
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_pet_call]
	@iPetUID		BIGINT,
	@BIsCall		BIT,
	@iOK		int = 0

/* 소환여부 업데이트
  2010-07-26  */
 
AS
SET NOCOUNT ON;

IF NOT EXISTS (SELECT 1 FROM dbo.GPet_Info WITH (NOLOCK) WHERE PetUID = @iPetUID)
BEGIN
	SELECT @iOK = -1	GOTO FAIL_TRAN
END	


BEGIN TRAN
		UPDATE dbo.GPet_Info
			SET IsCall = @BIsCall
				WHERE PetUID = @iPetUID
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN	SELECT @iOK = -2	GOTO FAIL_TRAN	END		
COMMIT_TRAN:
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_item_seal]
	@iItemUID	BIGINT
,	@iSealCnt	TINYINT
,	@iOK		INT	= 0
AS
SET NOCOUNT ON;

/*
	sutamtwo
	2009.08.27
	봉인 하기 및 봉인 풀기
*/


DECLARE @SealCnt	TINYINT
SELECT	@SealCnt = SealCnt 
	FROM dbo.GItemSeal WITH (NOLOCK) 
		WHERE ItemUID = @iItemUID

IF (@SealCnt = @iSealCnt)
	BEGIN
		SELECT @iOK = -1	GOTO END_PROC
	END
	

BEGIN TRAN

	IF	(@SealCnt IS NULL)
	BEGIN
		INSERT INTO dbo.GItemSeal (ItemUID, SealCnt)
			SELECT @iItemUID, @iSealCnt
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN
				SELECT @iOK = -2	GOTO FAIL_TRAN
			END
	END	
	ELSE	
	BEGIN
		UPDATE dbo.GItemSeal
			SET SealCnt = @iSealCnt
				WHERE ItemUID = @iItemUID
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN
				SELECT @iOK = -3	GOTO FAIL_TRAN	
			END
	END	
		
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_item_position_pet]
	@iUnitUID				bigint
,	@iItemUID				bigint
,	@iPetUID				bigint
,	@iInventoryCategory		int
,	@iSlotID				int
--,	@iOK					int = 0
AS
	SET NOCOUNT ON

	-- 기존 파라미터에서 변수로 변경
	DECLARE @Result		int

	-- 해당 아이템이 없는 경우.
	IF NOT EXISTS ( SELECT * FROM dbo.GItem WITH(NOLOCK) WHERE UnitUID = @iUnitUID AND ItemUID = @iItemUID )
		SET @Result = -1
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN

				SET @Result = -3

				UPDATE dbo.GItem
				SET	InventoryCategory	= @iInventoryCategory
				,	SlotID				= @iSlotID
				WHERE ItemUID = @iItemUID
				
				IF NOT EXISTS ( SELECT * FROM dbo.GItem_Pet WITH(NOLOCK) WHERE UnitUID = @iUnitUID AND ItemUID = @iItemUID ) BEGIN
					-- 카테고리 번호가 팻 인벤토리 이고 팻 번호가 존재 할 경우만 등록(0814 김병일)
					IF @iInventoryCategory = 13 AND @iPetUID <> 0 BEGIN
						SET @Result = -4
						
						INSERT INTO dbo.GItem_Pet ( UnitUID, ItemUID, PetUID )
						VALUES ( @iUnitUID, @iItemUID, @iPetUID )
					END
				END
				ELSE BEGIN
					SET @Result = -5
					
					-- 카테고리 번호가 팻 인벤토리 일 경우 팻 번호 입력 하고
					-- 팻 번호는 서버에서 주는 것을 신뢰(0814 김병일)
					UPDATE dbo.GItem_Pet
					SET PetUID = CASE WHEN @iInventoryCategory = 13 THEN @iPetUID ELSE 0 END
					WHERE UnitUID = @iUnitUID
						AND ItemUID = @iItemUID
				END

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
	END

	SELECT ISNULL(@Result, 0) AS Result
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_item_position]
    @iItemUID           [bigint],
    @iInventoryCategory [int],
    @iSlotID            [int],
    @iOK                [int] = 0
AS

SET NOCOUNT ON;

-- 해당 아이템이 없는 경우.
IF NOT EXISTS( SELECT * FROM dbo.GItem WITH( NOLOCK ) WHERE ItemUID = @iItemUID )
BEGIN
    SELECT @iOK = -1
    GOTO END_PROC
END

BEGIN TRAN
    UPDATE dbo.GItem WITH( ROWLOCK )
        SET InventoryCategory	= @iInventoryCategory
,			SlotID				= @iSlotID
        WHERE ItemUID = @iItemUID
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
    BEGIN
        SELECT @iOK = -3
        GOTO FAIL_TRAN
    END
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_item_period]
    @iUnitUID	  BIGINT,
    @iItemUID     BIGINT,
    @iPeriod      SMALLINT,
    @iOK          [int] = 0
AS

/*  2010-08-16
    item expiration 바꿔주는 sp*/

SET NOCOUNT ON;

-- 해당 아이템이 없는 경우.
IF NOT EXISTS (SELECT * FROM dbo.GItem WITH (NOLOCK) WHERE ItemUID = @iItemUID )
BEGIN
    SELECT @iOK = -1
    GOTO END_PROC
END

DECLARE @sdtExpirationDate SMALLDATETIME
SELECT @sdtExpirationDate = DATEADD(dd, @iPeriod, GETDATE())


BEGIN TRAN
			UPDATE dbo.GItemPeriod WITH (UPDLOCK)
				SET ExpirationDate = @sdtExpirationDate
			WHERE ItemUID = @iItemUID AND UnitUID = @iUnitUID
				IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN	
					SELECT @iOK = -2	GOTO FAIL_TRAN	
				END
COMMIT TRAN
GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK, @sdtExpirationDate
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_item]
	@iUnitUID	bigint ,
	@iItemUID	bigint ,
	@iUsageType	int ,
	@iParam		int ,
	@iOK		int = 0
AS
	SET NOCOUNT ON
	
	DECLARE @CheckValue		int
	
	-- 해당아이템이없는경우.
	IF NOT EXISTS( SELECT * FROM dbo.GItem WITH(NOLOCK) WHERE UnitUID = @iUnitUID AND ItemUID = @iItemUID )
		SELECT @iOK = -1
	-- 사용타입이올바른지판단한다.
	ELSE IF @iUsageType NOT IN (1, 2)
		SELECT @iOK = -2
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN
				UPDATE dbo.GItem
				SET Quantity = CASE @iUsageType WHEN 2 THEN Quantity + @iParam ELSE Quantity END
				,	Endurance = CASE @iUsageType WHEN 1 THEN Endurance + @iParam ELSE Endurance END
				,	@CheckValue = CASE @iUsageType WHEN 1 THEN Endurance + @iParam ELSE Quantity + @iParam END
				WHERE UnitUID = @iUnitUID AND ItemUID = @iItemUID
				
			IF @CheckValue < 0 BEGIN
				ROLLBACK TRAN
				SET @iOK = -5
			END
			ELSE BEGIN
				COMMIT TRAN
				SET @iOK = 0
			END
		END TRY
		BEGIN CATCH
			IF (XACT_STATE()) <> 0
				ROLLBACK TRAN
			
			IF @iUsageType = 2
				SET @iOK = -3
			ELSE
				SET @iOK = -4
		END CATCH
	END

	SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_henir_reward_cnt]
	@iUnitUID		BIGINT,
	@iNormalCnt		SMALLINT,
	@iPCBangCnt		SMALLINT,
	@iEventCnt		SMALLINT,
	@iOK			INT = 0
	
AS
SET NOCOUNT ON;

IF NOT EXISTS( SELECT * FROM dbo.GUnit WITH( NOLOCK ) WHERE UnitUID = @iUnitUID AND Deleted = 0 )
	BEGIN    SELECT @iOK = -1    GOTO END_PROC	END

BEGIN TRAN

	UPDATE dbo.GHenirRewardCnt
		SET NormalCnt = @iNormalCnt,
			PCBangCnt = @iPCBangCnt,
			EventCnt = @iEventCnt
		WHERE UnitUID = @iUnitUID
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN	SELECT @iOK = -2	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_guild_skill_point]
	@iGuildNo	BIGINT
,	@iSPoint	TINYINT
,	@iOK		INT = 0

/*
	sutamtwo
	2009. 11. 26
	길드 스킬 포인트 업데이트 (절대값)

*/
AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

-- 길드 없음
IF NOT EXISTS (SELECT 1 FROM dbo.GGuild WITH (NOLOCK) WHERE GuildNo = @iGuildNo)
	BEGIN	SELECT @iOK = -1	GOTO END_PROC	END



BEGIN TRAN
	IF NOT EXISTS (SELECT 1 FROM dbo.GGuild_SkillPoint WITH (NOLOCK) WHERE GuildNo = @iGuildNo)
	BEGIN
		INSERT INTO dbo.GGuild_SkillPoint (GuildNo, SPoint, CSPoint, MaxCsPoint, Period, EndDate)
			SELECT @iGuildNo, @iSPoint, 0, 0, 0, NULL
		IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
			BEGIN
				SELECT @iOK = -2	GOTO FAIL_TRAN
			END
	GOTO COMMIT_TRAN
	END


	UPDATE dbo.GGuild_SkillPoint
		SET SPoint = @iSPoint
			WHERE GuildNo = @iGuildNo


	COMMIT_TRAN:
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_guild_skill_info_new]
	@iGuildNo	INT
,	@iSkillID	INT
,	@iLevel		TINYINT	
,	@iCsPoint	TINYINT	
,	@iOK		int = 0

AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

/*
	2009. 11. 25
	sutamtwo
	1. 스킬을 새로 배우기
	2. 스킬 1개 되돌리기
	3. 캐시 스킬 기한 끝나서 정보 갱신 (여러번 호출)
*/


IF NOT EXISTS (SELECT 1 FROM dbo.GGuild WITH (NOLOCK) WHERE GuildNo = @iGuildNo)
BEGIN
	SELECT @iOK = -1	GOTO END_PROC
END


BEGIN TRAN

IF NOT EXISTS (SELECT 1 FROM dbo.GGuild_Skill WITH (NOLOCK) WHERE GuildNo = @iGuildNo AND SkillID = @iSkillID)
	BEGIN
		INSERT INTO dbo.GGuild_Skill (GuildNo, SkillID, [Level], CSPoint) 
			SELECT @iGuildNo, @iSkillID, @iLevel, @iCsPoint
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN	SELECT @iOK = -2	GOTO FAIL_TRAN	END
	END


ELSE
	BEGIN
		UPDATE dbo.GGuild_Skill
			SET [Level] = @iLevel
			,	CSPoint	= @iCsPoint
			WHERE GuildNo = @iGuildNo AND SkillID = @iSkillID
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1 
			BEGIN	SELECT @iOK = -3	GOTO FAIL_TRAN	END
	END


COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_guild_message]
	@iUnitUID	BIGINT
,	@iGuildNo	INT
,	@strMessage	NVARCHAR(90)
,	@iOK		INT = 0
AS

SET NOCOUNT ON;
	/*
		2009. 10. 05
		sutamtwo
		길드 메시지 변경하기
	*/

DECLARE	@iMyGuildNo	INT	
SELECT	@iMyGuildNo	= GuildNo
	FROM dbo.GGuild_Member WITH (NOLOCK)
		WHERE UnitUID = @iUnitUID

IF ISNULL(@iMyGuildNo, -1) <> @iGuildNo
BEGIN
	SELECT @iOK = -1	GOTO END_PROC
END

BEGIN TRAN	

	UPDATE dbo.GGuild
		SET SayHello = @strMessage
			WHERE GuildNo = @iGuildNo
			
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	BEGIN
		SELECT @iOK = -2	GOTO FAIL_TRAN
	END
	
COMMIT TRAN	

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN


END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_guild_member_message]
	@iUnitUID	BIGINT
,	@iGuildNo	INT	
,	@strMessage	NVARCHAR(120)
,	@iOK		INT	= 0
AS

SET NOCOUNT ON;
	/*
		2009. 10. 05
		sutamtwo
		길드원 등급 변경하기
	*/


IF NOT EXISTS (SELECT 1 FROM dbo.GGuild_Member WITH (NOLOCK) WHERE GuildNo = @iGuildNo AND UnitUID = @iUnitUID)
	BEGIN
		SELECT @iOK	= -1	GOTO END_PROC
	END


BEGIN TRAN	

	UPDATE dbo.GGuild_Member
		SET [Message] = @strMessage
			WHERE UnitUID = @iUnitUID

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN
			SELECT @iOK = -2	GOTO FAIL_TRAN
		END
	
COMMIT TRAN	

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_guild_member_grade]
	@iUnitUID	BIGINT
,	@iGuildNo	INT	
,	@iGrade		TINYINT
,	@iOK		INT	= 0
AS

SET NOCOUNT ON;
	/*
		2009. 10. 05
		sutamtwo
		길드원 등급 변경하기
	*/



IF NOT EXISTS (SELECT 1 FROM dbo.GGuild_Member WITH (NOLOCK) WHERE GuildNo = @iGuildNo AND UnitUID = @iUnitUID)
	BEGIN
		SELECT @iOK	= -1	GOTO END_PROC
	END




BEGIN TRAN	

	UPDATE dbo.GGuild_Member
		SET [State]	= @iGrade
			WHERE UnitUID = @iUnitUID

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN
			SELECT @iOK = -2	GOTO FAIL_TRAN
		END
	
COMMIT TRAN	

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_guild_member_exp]
	@iUnitUID	BIGINT	
,	@iGuildNo	INT
,	@iExpPoint	SMALLINT
,	@iOK		INT = 0
AS


SET NOCOUNT ON;
	/*
		2009. 10. 14
		sutamtwo
		길드 멤버 경험치 업데이트
	*/


IF 1 <> (SELECT COUNT(1) FROM dbo.GGuild_Member WITH (NOLOCK) WHERE UnitUID = @iUnitUID AND GuildNo = @iGuildNo)
BEGIN
	SELECT @iOK = -1	GOTO END_PROC
END


BEGIN TRAN

	UPDATE dbo.GGuild_Member
		SET [EXP] = @iExpPoint
			WHERE UnitUID = @iUnitUID
			
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN
			SELECT @iOK = -2	GOTO FAIL_TRAN
		END
		
COMMIT TRAN
GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_guild_maxno]
	@iGuildNo	INT
,	@iMaxNo		TINYINT
AS

SET NOCOUNT ON;
	/*
		2009. 10. 05
		sutamtwo
		길드 최고 인원 확장하기
	*/


UPDATE dbo.GGuild
	SET MaxNo = @iMaxNo
		WHERE GuildNo = @iGuildNo
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_guild_master]
	@iOldMasterUID BIGINT
,	@iNewMasterUID BIGINT
,	@iOldState  TINYINT 
,	@iNewState  TINYINT
,	@iGuildNo  INT
,	@iOK   INT = 0

AS

SET NOCOUNT ON;
	/*
		2009. 10. 09
		sutamtwo
		길드 마스터 위임
	*/


IF 2 <> (SELECT COUNT(1) FROM dbo.GGuild_Member WITH (NOLOCK) WHERE GuildNo = @iGuildNo AND UnitUID IN (@iOldMasterUID, @iNewMasterUID))
	BEGIN
		SELECT @iOK = -1	GOTO FAIL_TRAN
	END


BEGIN TRAN	

	UPDATE dbo.GGuild_Member
		SET [State]	= @iOldState
			WHERE UnitUID = @iOldMasterUID

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN
			SELECT @iOK = -2	GOTO FAIL_TRAN
		END

	UPDATE dbo.GGuild_Member
		SET [State]	= @iNewState
			WHERE UnitUID = @iNewMasterUID

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN
			SELECT @iOK = -3	GOTO FAIL_TRAN
		END
			
COMMIT TRAN	

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_guild_level]
	@iGuildNo		INT
,	@iGuildLevel	TINYINT
,	@iOK			INT = 0
AS

SET NOCOUNT ON;
	/*
		2009. 10. 29
		sutamtwo
		
		길드 레벨 업데이트
	*/


IF NOT EXISTS (SELECT 1 FROM dbo.GGuild WITH (NOLOCK) WHERE GuildNo = @iGuildNo)
BEGIN
	SELECT @iOK = -1	GOTO FAIL_TRAN
END	

BEGIN TRAN	
	UPDATE dbo.GGuild
		SET [LEVEL] = @iGuildLevel
			WHERE GuildNo = @iGuildNo
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
CREATE OR ALTER PROCEDURE [dbo].[gup_update_guild_lastdate]
	@iUnitUID	BIGINT
,	@iGuildNo	INT	
,	@iOK		INT	= 0
AS

SET NOCOUNT ON;
	/*
		2009. 10. 05
		sutamtwo
		길드원 등급 변경하기
	*/


IF NOT EXISTS (SELECT 1 FROM dbo.GGuild_Member WITH (NOLOCK) WHERE GuildNo = @iGuildNo AND UnitUID = @iUnitUID)
	BEGIN
		SELECT @iOK	= -1	GOTO END_PROC
	END

DECLARE	@sdtNow	SMALLDATETIME
SELECT	@sdtNow = GETDATE()


BEGIN TRAN	

	UPDATE dbo.GGuild_Member
		SET LastDate = @sdtNow
			WHERE UnitUID = @iUnitUID

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN
			SELECT @iOK = -2	GOTO FAIL_TRAN
		END
	


	UPDATE dbo.GGuild
		SET LastDate = @sdtNow
			WHERE GuildNo = @iGuildNo

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN
			SELECT @iOK = -3	GOTO FAIL_TRAN
		END
	

COMMIT TRAN	

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_guild_exp]
	@iUnitUID	BIGINT	
,	@iGuildNo	INT
,	@iExpPoint	SMALLINT
,	@iOK		INT = 0
AS


SET NOCOUNT ON;
	/*
		2009. 10. 14
		sutamtwo
		길드  경험치 업데이트
	*/


IF 1 <> (SELECT COUNT(1) FROM dbo.GGuild_Member WITH (NOLOCK) WHERE UnitUID = @iUnitUID AND GuildNo = @iGuildNo)
BEGIN
	SELECT @iOK = -1	GOTO END_PROC
END


BEGIN TRAN

	UPDATE dbo.GGuild
		SET [EXP] = [EXP] + @iExpPoint
			WHERE GuildNo = @iGuildNo
			
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN
			SELECT @iOK = -2	GOTO FAIL_TRAN
		END
		
COMMIT TRAN
GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_guild_cash_skill_point_info]
	@iGuildNo		INT
,	@iCsPoint		TINYINT
,	@iMaxCsPoint	TINYINT
,	@iOK			INT	= 0
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

/*
	2009. 11. 25
	sutamtwo
	CsPoint 를 업데이트 해줌 (절대값으로)
	Return : OK
*/

IF NOT EXISTS (SELECT 1 FROM dbo.GGuild WITH (NOLOCK) WHERE GuildNo = @iGuildNo)
	BEGIN
		SELECT @iOK = -1	GOTO END_PROC
	END


BEGIN TRAN
	UPDATE dbo.GGuild_SkillPoint
		SET CsPoint		= @iCsPoint
		,	MaxCsPoint	= @iMaxCsPoint
			WHERE GuildNo = @iGuildNo
			
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -2	GOTO FAIL_TRAN	END			
			
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_guild_cash_skill_period]
	@iGuildNo	INT	
,	@iPeriod	TINYINT
,	@iOK		INT	= 0
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

/*
	2009. 11. 25
	sutamtwo
	길드 캐시 스킬의 남은 기한을 연장
	Return : OK
*/

DECLARE	@sdtEndDate	SMALLDATETIME
,		@sdtNowDate	SMALLDATETIME

IF NOT EXISTS (SELECT 1 FROM dbo.GGuild WITH (NOLOCK) WHERE GuildNo = @iGuildNo)
	BEGIN
		SELECT @iOK = -1	
		SELECT	@sdtEndDate = GETDATE()	
		GOTO END_PROC
	END


SELECT @sdtNowDate = EndDate
	FROM dbo.GGuild_SkillPoint WITH (NOLOCK)
		WHERE GuildNo = @iGuildNo

		
IF (@sdtNowDate <= GETDATE())
	BEGIN	
		SELECT @iOK = -3
		SELECT	@sdtEndDate = @sdtNowDate
		GOTO FAIL_TRAN	
	END


SELECT	@sdtEndDate = DATEADD(DD, @iPeriod, @sdtNowDate)


BEGIN TRAN

	UPDATE dbo.GGuild_SkillPoint
		SET EndDate	= @sdtEndDate
	WHERE GuildNo = @iGuildNo
		OPTION (MAXDOP 1)
		
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -4	GOTO FAIL_TRAN	END			

			
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK, @sdtEndDate
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_get_post_item]
	@UnitUID	bigint	
,	@iPostNo	bigint
,	@iOK		int = 0
AS
SET NOCOUNT ON;

DECLARE	@iToUnitUID	bigint
,		@iIsReceive	bigint
,		@bDeleted	bit

SELECT @iToUnitUID = ToUnitUID, @iIsReceive = IsReceive, @bDeleted = Deleted
	FROM  dbo.GPost WITH (NOLOCK) WHERE PostNo = @iPostNo


	-- 해당 우체국번호가 없으면 에러
	IF @iToUnitUID IS NULL
		BEGIN	SELECT	@iOK = -2	GOTO END_PROC	END

	-- 이미 삭제된 아이템이면 에러
	IF (@bDeleted = 1)
		BEGIN	SELECT	@iOK = -3	GOTO END_PROC	END
	
	-- 다른 사람의 소포이면
	IF (@UnitUID <> @iToUnitUID)
		BEGIN	SELECT	@iOK = -4	GOTO END_PROC	END

	-- 이미 아이템을 받아간 소포이면
	IF (@iIsReceive = 1)
		BEGIN	SELECT	@iOK = -5	GOTO END_PROC	END


BEGIN TRAN
	
	UPDATE dbo.GPost
		SET IsReceive = 1
			WHERE PostNo = @iPostNo
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT	@iOK = -1	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_WishList]
	@iUserUID	bigint 
,	@iSlotNo	smallint
,	@iItemID	int
,	@iOK		int = 0

AS
SET NOCOUNT ON;

BEGIN TRAN

	IF NOT EXISTS (SELECT * FROM dbo.GItemWishList WITH (NOLOCK) WHERE UserUID = @iUserUID AND SlotNo = @iSlotNo)
		BEGIN
			INSERT INTO dbo.GItemWishList (UserUID, SlotNo, ItemID)
				SELECT @iUserUID, @iSlotNo, @iItemID
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN    SELECT @iOK = -1    GOTO FAIL_TRAN    END
		END

	ELSE
		BEGIN
			UPDATE dbo.GItemWishList WITH (UPDLOCK)
				SET ItemID = @iItemID
					WHERE UserUID = @iUserUID
						AND SlotNo = @iSlotNo
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN    SELECT @iOK = -2    GOTO FAIL_TRAN    END
		END


COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_ussize]
	@iUserUID	bigint
,	@iSlotSize	tinyint
,   @iMaxSize	tinyint
,	@iOK		int = 0
AS
SET NOCOUNT ON;


DECLARE	@iMySize	tinyint
SELECT	@iMySize	= USSize
	FROM dbo.GUser WITH (NOLOCK)
		WHERE UserUID = @iUserUID

-- 최대 가질 수 있는 Size보다 클 때
IF ( (@iMySize+@iSlotSize) > @iMaxSize)
	BEGIN	SELECT @iOK = -1	GOTO END_PROC	END


BEGIN TRAN

	UPDATE dbo.GUser
		SET USSize = (@iMySize + @iSlotSize)
			WHERE UserUID = @iUserUID
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN    SELECT @iOK = -2    GOTO FAIL_TRAN    END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK, (@iMySize + @iSlotSize)
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_unitpvp]
	@iUnitUID			BIGINT
,	@iOfficialMatchCnt	INT
,	@iRating			INT
,	@iMaxRating			INT
,	@iRPoint			INT
,	@iAPoint			INT
,	@bIsWinBeforeMatch	BIT
,	@iGrade				TINYINT
,	@iwin				INT
,	@ilose				INT
,	@iOK				INT = 0

AS
SET NOCOUNT ON;

IF NOT EXISTS( SELECT * FROM dbo.GUnit WITH( NOLOCK ) WHERE UnitUID = @iUnitUID AND Deleted = 0 )
BEGIN
    SELECT @iOK = -1
    GOTO END_PROC
END

BEGIN TRAN

	IF EXISTS(SELECT * FROM dbo.GUnitPVP WITH (NOLOCK) WHERE UnitUID = @iUnitUID)
	BEGIN
		UPDATE dbo.GUnitPVP WITH( ROWLOCK )
				SET OfficialMatchCnt = OfficialMatchCnt + @iOfficialMatchCnt,
					Rating = Rating + @iRating,
					MaxRating = MaxRating + @iMaxRating,		
					RPoint = RPoint + @iRPoint	,
					APoint = APoint	+ @iAPoint,
					IsWinBeforeMatch = @bIsWinBeforeMatch,
					Grade = @iGrade,
					win   = win + @iwin,
					lose  = lose + @ilose
				WHERE UnitUID = @iUnitUID
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN
				SELECT @iOK = -2
				GOTO FAIL_TRAN
			END		
	END
	
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_unit_login]
    @iUnitUID   [bigint],
    @iOK        [int] = 0
AS

SET NOCOUNT ON;

DECLARE 
	@sdtNow smalldatetime,
	@LastDate smalldatetime

SELECT @sdtNow = GetDate()

SELECT @LastDate = LastDate FROM dbo.GUnit WHERE UnitUID = @iUnitUID

-- 해당 유닛이 없는 경우.
IF NOT EXISTS( SELECT * FROM dbo.GUnit WITH( NOLOCK ) WHERE UnitUID = @iUnitUID AND Deleted = 0 )
BEGIN
    SELECT @iOK = -1
    GOTO END_PROC
END

BEGIN TRAN
	IF DateDiff ( day, @LastDate, @sdtNow ) > 0
	BEGIN
		UPDATE dbo.GUnit WITH( ROWLOCK ) SET PlayDayCnt = PlayDayCnt + 1 WHERE UnitUID = @iUnitUID
	END

	UPDATE dbo.GUnit WITH( ROWLOCK ) SET 
		LoginCount = LoginCount + 1, LastDate = @sdtNow 
	WHERE UnitUID = @iUnitUID

    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
    BEGIN
        SELECT @iOK = -2
        GOTO FAIL_TRAN
    END
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_unit_lastpoint]
	@iUnitUID		BIGINT,
	@iGamepoint		INT,
	@iOK			INT = 0
	

AS
SET NOCOUNT ON;

DECLARE @sdtnow		SMALLDATETIME
SELECT @sdtnow = GETDATE()

IF NOT EXISTS ( SELECT * FROM dbo.GUnit_LastPoint WITH(NOLOCK) WHERE UnitUID = @iUnitUID )
	BEGIN    SELECT @iOK = -1    GOTO END_PROC    END
	
BEGIN TRAN					

			UPDATE dbo.GUnit_LastPoint WITH (UPDLOCK)
			SET Gamepoint = @iGamepoint,
				RegDate = @sdtnow
			WHERE UnitUID = @iUnitUID
			
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1 
			BEGIN    SELECT @iOK = -1   GOTO FAIL_TRAN    END
	
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_unit_info]
    @iUnitUID   	[bigint],
    @iExp       	[int],
    @iLevel     	[int],
    @iGamePoint 	[int],
	@iSPoint		[int],
	@iMapID			[int],
	@iSpirit		[smallint],
	@iSpiritFlag	[bit],
    @iOK        	[int] = 0
AS

SET NOCOUNT ON;

DECLARE 
	@sdtNow smalldatetime,
	@LastDate smalldatetime

SELECT @sdtNow = GetDate()

SELECT @LastDate = LastDate FROM dbo.GUnit WHERE UnitUID = @iUnitUID

-- 해당 유닛이 없는 경우.
IF NOT EXISTS( SELECT * FROM dbo.GUnit WITH( NOLOCK ) WHERE UnitUID = @iUnitUID AND Deleted = 0 )
BEGIN
    SELECT @iOK = -1
    GOTO END_PROC
END

BEGIN TRAN
--	IF DateDiff ( day, @LastDate, @sdtNow ) > 0
--	BEGIN
--		UPDATE dbo.GUnit WITH( ROWLOCK ) SET PlayDayCnt = PlayDayCnt + 1 WHERE UnitUID = @iUnitUID
--	END

    UPDATE dbo.GUnit WITH( ROWLOCK )
        SET [Exp] = [Exp] + @iExp, [Level] = @iLevel, GamePoint = GamePoint + @iGamePoint,
			SPoint = SPoint + @iSPoint, LastPosition = @iMapID--,
--			LastDate = @sdtNow
        WHERE UnitUID = @iUnitUID
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
    BEGIN
        SELECT @iOK = -2
        GOTO FAIL_TRAN
    END

-- 근성도 저장
	UPDATE dbo.GSpirit WITH (UPDLOCK)
		SET Spirit = @iSpirit
			WHERE unitUID = @iunitUID
	    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN
				SELECT @iOK = -3
				GOTO FAIL_TRAN
			END

-- ED 증감 저장(DB용)
	INSERT INTO dbo.GUnit_ED WITH (UPDLOCK) (UnitUID, Gamepoint, RegDate)
		SELECT @iUnitUID, @iGamePoint, @sdtNow
		  IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN
				SELECT @iOK = -4
				GOTO FAIL_TRAN
			END

--	IF	(@iSpiritFlag = 1 AND (SELECT Flag FROM dbo.GSpirit WHERE UnitUID = @iunitUID)=0 ) 
--	BEGIN
--		UPDATE dbo.GSpirit WITH (UPDLOCK)
--			SET Flag = 1
--				WHERE unitUID = @iunitUID
--	END


COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_unit_class]
    @iUnitUID   [bigint],
    @iUnitClass [tinyint],
    @iOK        [int] = 0
AS

SET NOCOUNT ON;

-- 해당 유닛이 없는 경우.
IF NOT EXISTS( SELECT * FROM dbo.GUnit WITH( NOLOCK ) WHERE UnitUID = @iUnitUID AND Deleted = 0 )
BEGIN
    SELECT @iOK = -1
    GOTO END_PROC
END

BEGIN TRAN

    UPDATE dbo.GUnit WITH( ROWLOCK )
        SET UnitClass = @iUnitClass
			WHERE UnitUID = @iUnitUID
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -2	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_ui_5]
    @iUnitUID   	[bigint],
    @iExp       	[int],
    @iLevel     	[int],
    @iGamePoint 	[int],
	@iSPoint		[int],
	@iMapID			[int],
	@iSpirit		[smallint],
	@iSpiritFlag	[bit],
    @iOK        	[int] = 0
AS

SET NOCOUNT ON;

DECLARE 
	@sdtNow smalldatetime,
	@LastDate smalldatetime

SELECT @sdtNow = GetDate()

SELECT @LastDate = LastDate FROM dbo.GUnit WHERE UnitUID = @iUnitUID

-- 해당 유닛이 없는 경우.
IF NOT EXISTS( SELECT * FROM dbo.GUnit WITH( NOLOCK ) WHERE UnitUID = @iUnitUID AND Deleted = 0 )
BEGIN
    SELECT @iOK = -1
    GOTO END_PROC
END

BEGIN TRAN
--	IF DateDiff ( day, @LastDate, @sdtNow ) > 0
--	BEGIN
--		UPDATE dbo.GUnit WITH( ROWLOCK ) SET PlayDayCnt = PlayDayCnt + 1 WHERE UnitUID = @iUnitUID
--	END

    UPDATE dbo.GUnit WITH( ROWLOCK )
        SET [Exp] = [Exp] + @iExp, [Level] = @iLevel, GamePoint = GamePoint + @iGamePoint,
			SPoint = SPoint + @iSPoint, LastPosition = @iMapID--,
--			LastDate = @sdtNow
        WHERE UnitUID = @iUnitUID
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
    BEGIN
        SELECT @iOK = -2
        GOTO FAIL_TRAN
    END

-- 근성도 저장
	UPDATE dbo.GSpirit WITH (UPDLOCK)
		SET Spirit = @iSpirit
			WHERE unitUID = @iunitUID
	    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN
				SELECT @iOK = -3
				GOTO FAIL_TRAN
			END

-- ED 증감 저장(DB용)
	INSERT INTO dbo.GUnit_ED WITH (UPDLOCK) (UnitUID, Gamepoint, RegDate)
		SELECT @iUnitUID, @iGamePoint, @sdtNow
		  IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN
				SELECT @iOK = -4
				GOTO FAIL_TRAN
			END

--	IF	(@iSpiritFlag = 1 AND (SELECT Flag FROM dbo.GSpirit WHERE UnitUID = @iunitUID)=0 ) 
--	BEGIN
--		UPDATE dbo.GSpirit WITH (UPDLOCK)
--			SET Flag = 1
--				WHERE unitUID = @iunitUID
--	END


COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
/*	sutamtwo
	2008-10-07
	타이틀 장/탈착 
	넘어오는 타이틀 ID 값이 0 이면 탈착,
	0 이상이면 장착
	
	Hwang
	2011-01-11
	TitleID smailint 에서 int 데이터 타입변경
*/

CREATE OR ALTER PROCEDURE [dbo].[gup_update_title_mission]
	@iUnitUID	bigint
,	@TitleID	int
,	@SubMission1 smallint
,	@SubMission2 smallint
,	@SubMission3 smallint
,	@SubMission4 smallint
,	@SubMission5 smallint
,	@iOK  int = 0


AS

SET NOCOUNT ON ;


DECLARE	@iNew	tinyint
SELECT	@iNew = (SELECT COUNT(*) FROM dbo.GTitle_Mission WITH (NOLOCK) WHERE UnitUID = @iUnitUID AND TitleID = @TitleID)

BEGIN TRAN

	-- 미션 INSERT (@iNew = 0)
	IF	(@iNew = 0)
		BEGIN
			INSERT INTO dbo.GTitle_Mission (UnitUID, TitleID, SubMission1, SubMission2, SubMission3, SubMission4, SubMission5)
				SELECT @iUnitUID, @TitleID, @SubMission1, @SubMission2, @SubMission3, @SubMission4, @SubMission5
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END
		END

	-- 미션 UPDATE (@iNew > 0)
	ELSE
		BEGIN
			UPDATE dbo.GTitle_Mission
					SET SubMission1 = @SubMission1
					,	SubMission2 = @SubMission2
					,	SubMission3 = @SubMission3
					,	SubMission4 = @SubMission4
					,	SubMission5 = @SubMission5
						WHERE UnitUID = @iUnitUID AND TitleID = @TitleID
				IF @@ERROR <> 0 OR @@ROWCOUNT > 1
					BEGIN	SELECT @iOK = -2	GOTO FAIL_TRAN	END
		END
	
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
/*	sutamtwo
	2008-10-07
	타이틀 장/탈착 
	넘어오는 타이틀 ID 값이 0 이면 탈착,
	0 이상이면 장착
	
	Hwang
	2011-01-11
	TitleID smailint 에서 int 데이터 타입변경
*/

CREATE OR ALTER PROCEDURE [dbo].[gup_update_title_hang]
(
	@iUnitUID	bigint
,	@iOldID		int
,	@iTitleID	int
,	@iOK		int = 0
)

AS

SET NOCOUNT ON ;


BEGIN TRAN

	-- 탈착하기 (@iTitleID = 0)
	IF	(@iTitleID = 0)
		BEGIN
			UPDATE dbo.GTitle_Complete
				SET IsHang = 0
					WHERE UnitUID = @iUnitUID
			IF @@ERROR <> 0 
				BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END
		END

	-- 새로 장착하기 (@iTitleID > 0)
	ELSE
		BEGIN
		-- 기존꺼 빼고
			UPDATE dbo.GTitle_Complete
				SET IsHang = 0
					WHERE UnitUID = @iUnitUID AND TitleID = @iOldID
			IF @@ERROR <> 0 OR @@ROWCOUNT > 1
				BEGIN	SELECT @iOK = -3	GOTO FAIL_TRAN	END

		-- 새로 넣고
			UPDATE dbo.GTitle_Complete
				SET IsHang = 1
					WHERE UnitUID = @iUnitUID AND TitleID = @iTitleID
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN	SELECT @iOK = -2	GOTO FAIL_TRAN	END

		END
	
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
/*	Hwang
	2011-04-27
	칭호 기간 연장되도록 하는 SP
*/

CREATE OR ALTER PROCEDURE [dbo].[gup_update_title]
(
	@iUnitUID	bigint
,	@iTitleID	int
,	@iPeriod	smallint
,	@iOK		int = 0
)

AS

SET NOCOUNT ON ;

DECLARE	@sdtEndDate	smalldatetime
SELECT	@sdtEndDate = EndDate + @iPeriod FROM dbo. GTitle_Complete WHERE UnitUID = @iUnitUID AND TitleID = @iTitleID

IF (@iPeriod = 0)
	BEGIN	
		SELECT	@sdtEndDate = '2040-12-31 23:59'
		SELECT  @iOK = -1
		GOTO END_PROC
		
	END

BEGIN TRAN
		UPDATE dbo.GTitle_Complete
			SET EndDate = @sdtEndDate
				WHERE UnitUID = @iUnitUID AND TitleID = @iTitleID
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN	SELECT @iOK = -2	GOTO FAIL_TRAN	END

	-- 진행 중이던 미션 지우기
	DELETE FROM dbo.GTitle_Mission
		WHERE UnitUID = @iUnitUID AND TitleID = @iTitleID
	--IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	--	BEGIN	SELECT @iOK = -3	GOTO FAIL_TRAN	END

	
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK, @sdtEndDate
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_Socket]
	@iUnitUID	BIGINT
,	@iItemUID	bigint
,	@iSoket1	int
,	@iSoket2	int
,	@iSoket3	int
,	@iSoket4	int
,	@iOK		int = 0

AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRAN
	IF NOT EXISTS (SELECT 1 FROM dbo.GItemSocket WITH (NOLOCK) WHERE UnitUID = @iUnitUID AND ItemUID = @iItemUID)
		BEGIN
			INSERT INTO dbo.GItemSocket (UnitUID, ItemUID, Socket1, Socket2, Socket3, Socket4)
				SELECT @iUnitUID, @iItemUID, @iSoket1, @iSoket2, @iSoket3, @iSoket4
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END
			GOTO COMMIT_TRAN
		END

		UPDATE dbo.GItemSocket
			SET Socket1	= @iSoket1
,				Socket2	= @iSoket2
,				Socket3	= @iSoket3
,				Socket4	= @iSoket4
			WHERE UnitUID = @iUnitUID AND ItemUID = @iItemUID
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1 
		BEGIN	SELECT @iOK = -2	GOTO FAIL_TRAN	END


COMMIT_TRAN:
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
/*
	2008. 04.21
	sutamtwo
	스킬슬롯 B에 업데이트 시키기
*/

CREATE OR ALTER PROCEDURE [dbo].[gup_update_skill_slot2]
	@iUnitUID_ [bigint]
,	@iSlot01 [int]
,	@iSlot02 [int]
,	@iSlot03 [int]
,	@iOK [int] = 0
AS
SET NOCOUNT ON;

BEGIN TRAN

	UPDATE dbo.GSkillSlot2 WITH ( ROWLOCK )
			SET Slot01 = @iSlot01, 
				Slot02 = @iSlot02, 
				Slot03 = @iSlot03
			WHERE UnitUID = @iUnitUID_
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -11	GOTO FAIL_TRAN	END	    

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_skill_info_new]
	@iUnitUID	BIGINT
,	@iSkillID	INT
,	@iLevel		TINYINT	
,	@iCsPoint	TINYINT	
,	@iOK		int = 0

AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

/*
	2009. 05. 07
	sutamtwo
	1. 스킬을 새로 배우기
	2. 스킬 1개 되돌리기
	3. 캐시 스킬 기한 끝나서 정보 갱신 (여러번 호출)
*/


BEGIN TRAN

IF NOT EXISTS (SELECT 1 FROM dbo.GSkill_New WITH (NOLOCK) WHERE UnitUID = @iUnitUID AND SkillID = @iSkillID)
	BEGIN
		INSERT INTO dbo.GSkill_New (UnitUID, SkillID, [Level], CSP) 
			SELECT @iUnitUID, @iSkillID, @iLevel, @iCsPoint
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END
	END


ELSE
	BEGIN
		UPDATE dbo.GSkill_New
			SET [Level] = @iLevel
			,	CSP		= @iCsPoint
			WHERE UnitUID = @iUnitUID AND SkillID = @iSkillID
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1 
			BEGIN	SELECT @iOK = -2	GOTO FAIL_TRAN	END
	END


COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_resurrection_stone_autopay] 
	@iUnitUID	BIGINT
,	@iQuantity	SMALLINT
,	@iOK		INT = 0
AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

	/*
		2009-10-14
		sutamtwo
		자동결제 부활석 수량 업데이트
	*/

DECLARE	@sdtNow SMALLDATETIME
SELECT	@sdtNow	= GETDATE()

BEGIN TRAN

	IF NOT EXISTS (SELECT 1 FROM dbo.GResurrectionStone_AutoPay WITH (NOLOCK) WHERE UnitUID = @iUnitUID)
		BEGIN

			INSERT INTO dbo.GResurrectionStone_AutoPay (UnitUID, Quantity, LastRefill)
				SELECT @iUnitUID, @iQuantity, @sdtNow
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN
					SELECT @iOK = -1	GOTO FAIL_TRAN
				END		
			GOTO COMMIT_TRAN
		END
	
	IF (@iQuantity > 0)
		BEGIN
			UPDATE dbo.GResurrectionStone_AutoPay
				SET Quantity = Quantity + @iQuantity
				,	LastRefill = @sdtNow
					WHERE UnitUID = @iUnitUID
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN
					SELECT @iOK = -2	GOTO FAIL_TRAN
				END		
		END

	ELSE	
		BEGIN
			UPDATE dbo.GResurrectionStone_AutoPay
				SET Quantity = Quantity + @iQuantity
					WHERE UnitUID = @iUnitUID
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN
					SELECT @iOK = -3	GOTO FAIL_TRAN
				END		
		END


COMMIT_TRAN:
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
/*
	sutamtwo
	부활석 사용 후 남은 갯수(변동량)을 DB에 저장
	2007. 11. 20

	OK값
	
	 -1	: 해당 유닛 없음
	-10 : 부활석이 없을 때 Insert 오류 ( 처음 Insert 하는데 그 값이 음수면 곤란함)
	-20 : 계산값이 음수일 때 0으로 바꾸고 업데이트 하는 행
	-21 : 보통 일반적인 업데이트문
*/
CREATE OR ALTER PROCEDURE [dbo].[gup_update_resurrection_stone]
    @iUnitUID   	[bigint]
,	@iResurrection	[int]
,	@iOK        	[int] = 0
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

-- 해당 유닛이 없는 경우.
IF NOT EXISTS( SELECT * FROM dbo.GUnit WITH( NOLOCK ) WHERE UnitUID = @iUnitUID AND Deleted = 0 )
BEGIN
    SELECT @iOK = -1
    GOTO END_PROC
END


DECLARE @iStoneCnt	int
SELECT @iStoneCnt = Quantity
	FROM dbo.GResurrectionStone	WITH (NOLOCK)
		WHERE UnitUid = @iUnitUID


BEGIN TRAN

	-- 부활석 존재하지 않으면 Insert
	IF NOT EXISTS (SELECT * FROM dbo.GResurrectionStone WITH (NOLOCK) WHERE UnitUID = @iUnitUID)
		BEGIN
			INSERT INTO dbo.GResurrectionStone (UnitUID, Quantity)
				SELECT @iUnitUID, @iResurrection
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN	SELECT @iOK = -10 GOTO END_PROC	END

			GOTO COMMIT_TRAN
		END
		
	
	-- 계산 값이 음수가 될 경우 0으로 저장
	IF ((@iStoneCnt + @iResurrection)<0)
	BEGIN
		UPDATE dbo.GResurrectionStone WITH (UPDLOCK)
			SET	Quantity = 0
				WHERE unitUID = @iUnitUID
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN 	SELECT @iOK = -20	GOTO END_PROC	END

		GOTO COMMIT_TRAN
	END
	
	UPDATE dbo.GResurrectionStone WITH (UPDLOCK)
		SET	Quantity = @iStoneCnt + @iResurrection
			WHERE unitUID = @iUnitUID
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN 	SELECT @iOK = -21	GOTO END_PROC	END

COMMIT_TRAN:
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_remaintime_account]
	@iUserUID		INT
,	@iEventUID		SMALLINT
,	@iRemainTime	SMALLINT
,	@iOK			INT	= 0	

AS
SET NOCOUNT ON;


/*
	2010. 06. 15
	sutamtwo
	계정단위 접속 이벤트 남은 시간 저장
*/


BEGIN TRAN

	IF NOT EXISTS (SELECT 1 FROM dbo.GEvent_Account_Acc WITH (NOLOCK) WHERE UserUID = @iUserUID AND EventUID = @iEventUID)
		BEGIN
			INSERT INTO dbo.GEvent_Account_Acc (UserUID, EventUID, RemainTime)
				SELECT @iUserUID, @iEventUID, @iRemainTime
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN    SELECT @iOK = -1    GOTO FAIL_TRAN    END
			GOTO COMMIT_TRAN
		END

	ELSE	
		UPDATE dbo.GEvent_Account_Acc
			SET RemainTime = @iRemainTime
				WHERE UserUID = @iUserUID AND EventUID = @iEventUID
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN    SELECT @iOK = -2    GOTO FAIL_TRAN    END
		

COMMIT_TRAN:
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_remaintime]
	@iUnitUID		BIGINT
,	@iEventID		SMALLINT
,	@iRemainTime	SMALLINT
,	@iOK			INT	= 0	

AS
SET NOCOUNT ON;


/*
	2009. 12. 04
	sutamtwo
	접속 이벤트 남은 시간 저장
*/


BEGIN TRAN

	IF NOT EXISTS (SELECT 1 FROM dbo.GRemainTime WITH (NOLOCK) WHERE UnitUID = @iUnitUID AND EventID = @iEventID)
		BEGIN
			INSERT INTO dbo.GRemainTime (UnitUID, EventID, RemainTime)
				SELECT @iUnitUID, @iEventID, @iRemainTime
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN    SELECT @iOK = -1    GOTO FAIL_TRAN    END
			GOTO COMMIT_TRAN
		END

	ELSE	
		UPDATE dbo.GRemainTime
			SET RemainTime = @iRemainTime
				WHERE UnitUID = @iUnitUID AND EventID = @iEventID
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN    SELECT @iOK = -2    GOTO FAIL_TRAN    END
		

COMMIT_TRAN:
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_read_post_letter]
	@UnitUID	bigint	
,	@iPostNo	bigint
,	@iOK		int = 0
AS
SET NOCOUNT ON;

DECLARE	@iToUnitUID	bigint
,		@iIsRead	bigint
,		@bDeleted	bit

SELECT @iToUnitUID = ToUnitUID, @iIsRead = IsRead, @bDeleted = Deleted
	FROM  dbo.GPost WITH (NOLOCK) WHERE PostNo = @iPostNo


	-- 해당 우체국번호가 없으면 에러
	IF @iToUnitUID IS NULL
		BEGIN	SELECT	@iOK = -2	GOTO END_PROC	END

	-- 이미 삭제된 아이템이면 에러
	IF (@bDeleted = 1)
		BEGIN	SELECT	@iOK = -3	GOTO END_PROC	END
	
	-- 다른 사람의 소포이면
	IF (@UnitUID <> @iToUnitUID)
		BEGIN	SELECT	@iOK = -4	GOTO END_PROC	END

	-- 이미 읽은 편지라면
	IF (@iIsRead = 1)
		BEGIN	SELECT	@iOK = -5	GOTO END_PROC	END


BEGIN TRAN
	
	UPDATE dbo.GPost
		SET IsRead = 1
			WHERE PostNo = @iPostNo
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT	@iOK = -1	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_rank]
	@iOK_	[int] = 0
/* 
Hwang
작성일 : 2011년 07월 26일
사용 : GameDB용 랭킹 갱신에 사용될 SP
*/

AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRAN

	INSERT INTO dbo.GRank ( VsRank, ExpRank, ClassVsRank, ClassExpRank, UnitUID, NickName, Win, [Level], [Exp], UnitClass, Grade, RPoint, OfficialMatchCnt, UClass, RegDate )
	SELECT ROW_NUMBER() OVER(ORDER BY Grade DESC, RPoint DESC, win DESC, UnitUID ASC) AS VsRank
	, RANK() OVER(ORDER BY [Exp] DESC, Start ASC) AS ExpRank
	, ROW_NUMBER() OVER(PARTITION BY UClass ORDER BY Grade DESC, RPoint DESC, win DESC, UnitUID ASC) AS ClassVsRank
	, RANK() OVER(PARTITION BY UClass ORDER BY [Exp] ASC) AS ClassExpRank
	, UnitUID, NickName, Win, [Level], [Exp], UnitClass, Grade, RPoint, OfficialMatchCnt
	, UClass
	, CONVERT(char(10), DATEADD(dd, -1, GETDATE()), 120) AS RegDate
	FROM (
		SELECT A.UnitUID, C.Grade, C.Win, C.RPoint, C.OfficialMatchCnt, A.[Level], A.[Exp], b.NickName, A.UnitClass, LV.Start
		, CASE
			WHEN A.UnitClass IN (1, 10, 11, 22, 100, 101, 112) THEN 1        -- Elsword
			WHEN A.UnitClass IN (3, 12, 13, 24, 102, 103, 114) THEN 3        -- Rena
			WHEN A.UnitClass IN (2, 14, 15, 23, 104, 105, 113) THEN 2        -- Aisha
			WHEN A.UnitClass IN (4, 16, 17, 25, 106, 107, 115) THEN 4        -- Raven
			WHEN A.UnitClass IN (5, 18, 19, 26, 108, 109, 116) THEN 5        -- Eve
			WHEN A.UnitClass IN (6, 20, 21, 27, 110, 111, 117) THEN 6        -- Chung
			WHEN UnitClass IN (7, 28, 118) THEN 7							 -- Ara
			ELSE NULL END AS UClass											 -- None
		FROM dbo.GUnit AS A WITH(NOLOCK)
		JOIN dbo.GUnitPVP_Season2 AS C WITH(NOLOCK)
			ON A.UnitUID = C.UnitUID
		JOIN dbo.GUnitNickName AS B WITH(NOLOCK)
			ON A.UnitUID = B.UnitUID
		JOIN [Statistics].dbo.LCharLvUp AS LV WITH(NOLOCK)
			ON A.UnitUID = LV.CharUID AND A.Level = LV.Level
		WHERE A.Deleted = 0
			AND NOT EXISTS (SELECT * FROM dbo.GRank_Except WITH(NOLOCK) WHERE UserUID = A.UserUID)
			AND NOT EXISTS (SELECT * FROM Account.dbo.MUserAuthority WITH(NOLOCK) WHERE UserUID = A.UserUID AND AuthLevel > 0)
	) AS TempTable
	ORDER BY VsRank ASC
	
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK_
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_quest]
    @iUnitUID   [bigint],
    @iQuestID   [int],
	@iSubQuest0	[tinyint],
	@iSubQuest1	[tinyint],
	@iSubQuest2	[tinyint],
	@iSubQuest3	[tinyint],
	@iSubQuest4	[tinyint],
    @iOK        [int] = 0
AS

SET NOCOUNT ON;

-- 해당 퀘스트가 없는 경우.
IF NOT EXISTS( SELECT * FROM dbo.GQuests WITH( NOLOCK ) WHERE UnitUID = @iUnitUID AND QuestID = @iQuestID )
BEGIN
    SELECT @iOK = -1
    GOTO END_PROC
END
-- 해당 퀘스트가 이미 완료된 경우
IF EXISTS( SELECT * FROM dbo.GQuests_Complete WITH( NOLOCK ) WHERE UnitUID = @iUnitUID AND QuestID = @iQuestID )
BEGIN
    SELECT @iOK = -3
    GOTO END_PROC
END

BEGIN TRAN
    UPDATE dbo.GQuests WITH( ROWLOCK )
        SET SubQuest0 = @iSubQuest0, SubQuest1 = @iSubQuest1, SubQuest2 = @iSubQuest2, 
			SubQuest3 = @iSubQuest3, SubQuest4 = @iSubQuest4
        WHERE UnitUID = @iUnitUID AND QuestID = @iQuestID
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
    BEGIN
        SELECT @iOK = -2
        GOTO FAIL_TRAN
    END
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_PShopItem]
	@iUnitUID					BIGINT,
    @iItemUID   				BIGINT,
    @iQuantity					INT,
    @iTotalSellEDIn				INT,
    @iTotalSoldItemQuantity     INT,
    @iTotalSellCommissionED		INT,
    @iOK        				INT = 0
AS

SET NOCOUNT ON;

-- 해당 아이템이 없는 경우.
IF NOT EXISTS( SELECT 1 FROM dbo.GPShopItem WITH( NOLOCK ) WHERE UnitUID = @iUnitUID AND ItemUID = @iItemUID AND Deleted = 0 )
BEGIN
    SELECT @iOK = -1
    GOTO END_PROC
END



-- 수량값이 더해서 음수 값을 것을 대비
DECLARE	@iQuantity_	INT --기존에 있던 수량
SELECT	@iQuantity_	= Quantity 
	FROM dbo.GPShopItem WITH (NOLOCK) 
		WHERE UnitUID = @iUnitUID AND ItemUID = @iItemUID


BEGIN TRAN
	-- 수량성인데 더한 값이 음수 일 때 에러
		IF (@iQuantity_ + @iQuantity) < 0
		BEGIN
            SELECT @iOK = -2	GOTO FAIL_TRAN
        END

        UPDATE dbo.GPShopItem WITH(ROWLOCK)
            SET Quantity = Quantity + @iQuantity
            ,	TotalSellEDIn = @iTotalSellEDIn
            ,	TotalSoldItemQuantity = @iTotalSoldItemQuantity
            ,	TotalSellCommissionED = @iTotalSellCommissionED
            WHERE UnitUID = @iUnitUID AND ItemUID = @iItemUID
        IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
        BEGIN
            SELECT @iOK = -3
            GOTO FAIL_TRAN
        END
    
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_PShopinfo]
	@iUnitUID			BIGINT,
	@bIsPShopOpen		BIT,
	@iBeginDate			SMALLDATETIME,
	@bOn_Off			BIT,
	@iShopType			TINYINT,
    @iOK				INT = 0
    
AS
SET NOCOUNT ON;

DECLARE @bIsPShopOpen_	BIGINT


IF NOT EXISTS( SELECT 1 FROM dbo.GUnit WITH (NOLOCK) WHERE UnitUID = @iUnitUID AND Deleted = 0 )
BEGIN
    SELECT @iOK = -1
    GOTO END_PROC
END

IF NOT EXISTS( SELECT 1 FROM dbo.GPShopInfo WITH (NOLOCK) WHERE UnitUID = @iUnitUID )
BEGIN
    SELECT @iOK = -2
    GOTO END_PROC
END

SELECT @bIsPShopOpen_ = IsPShopOpen FROM dbo.GPShopInfo WITH (NOLOCK) WHERE UnitUID = @iUnitUID
IF (@bIsPShopOpen_ <> 0)
BEGIN
    SELECT @iOK = -3
    GOTO END_PROC
END

BEGIN TRAN

		UPDATE dbo.GPShopInfo WITH (ROWLOCK)
			SET IsPShopOpen = @bIsPShopOpen
			,	BeginDate = @iBeginDate
			,	On_Off = @bOn_Off
			,	ShopType = @iShopType
			WHERE UnitUID = @iUnitUID
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN
				SELECT @iOK = -4	GOTO FAIL_TRAN
			END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_PShop_info_PShopName]
	@iUnitUID			BIGINT
,	@strPShopName		NVARCHAR(50)
,	@iOK				INT = 0
    
AS
SET NOCOUNT ON;

IF NOT EXISTS( SELECT 1 FROM dbo.GUnit WITH( NOLOCK ) WHERE UnitUID = @iUnitUID AND Deleted = 0 )
BEGIN
    SELECT @iOK = -1
    GOTO END_PROC
END

BEGIN TRAN

	UPDATE dbo.GPShopInfo WITH (ROWLOCK)
	    SET PShopName = @strPShopName
	    WHERE UnitUID = @iUnitUID
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
        BEGIN
            SELECT @iOK = -4
            GOTO FAIL_TRAN
        END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_PShop_info_On_Off]
	@iUnitUID			[BIGINT],
	@bOn_Off			[BIT],
    @iOK				[INT] = 0
    
AS
SET NOCOUNT ON;

IF NOT EXISTS( SELECT 1 FROM dbo.GUnit WITH (NOLOCK) WHERE UnitUID = @iUnitUID)
BEGIN
    SELECT @iOK = -1
    GOTO END_PROC
END

BEGIN TRAN

	UPDATE dbo.GPShopInfo WITH (ROWLOCK)
	    SET On_Off = @bOn_Off
	    WHERE UnitUID = @iUnitUID
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
        BEGIN
            SELECT @iOK = -4
            GOTO FAIL_TRAN
        END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_PShop_info_IsPShopOpen]
	@iUnitUID			BIGINT,
	@bIsPShopOpen		BIT,
    @iOK				INT = 0
    
AS
SET NOCOUNT ON;

IF NOT EXISTS( SELECT 1 FROM dbo.GUnit WITH (NOLOCK) WHERE UnitUID = @iUnitUID AND Deleted = 0 )
BEGIN
    SELECT @iOK = -1
    GOTO END_PROC
END

BEGIN TRAN

	UPDATE dbo.GPShopInfo WITH (ROWLOCK)
	    SET IsPShopOpen = @bIsPShopOpen
			WHERE UnitUID  = @iUnitUID
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
        BEGIN
            SELECT @iOK = -4
            GOTO FAIL_TRAN
        END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_event_account_nor]
	@iUserUID	INT
,	@iEventUID	SMALLINT
,	@sdtEndDate	SMALLDATETIME
,	@iOK		INT = 0
AS 

/* 
sutamtwo
작성일 : 2010년 06월 15일
사용 : 계정별 접속 이벤트
*/
SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRAN
	IF EXISTS (SELECT 1 FROM dbo.GEvent_Account_Nor WITH (NOLOCK) WHERE UserUID = @iUserUID AND EventUID = @iEventUID)
		BEGIN
			UPDATE dbo.GEvent_Account_Nor WITH (UPDLOCK)
				SET	RegDate = @sdtEndDate
					WHERE UserUID = @iUserUID AND EventUID = @iEventUID
			IF @@ERROR <> 0 OR @@ROWCOUNT > 1
				BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END
		END
	ELSE 
		BEGIN
			INSERT INTO dbo.GEvent_Account_Nor (UserUID, EventUID, RegDate)
				SELECT @iUserUID, @iEventUID, @sdtEndDate
			IF @@ERROR <> 0 OR @@ROWCOUNT > 1
				BEGIN	SELECT @iOK = -2	GOTO FAIL_TRAN	END
		END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:

SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_Enchant]
	@iUnitUID	BIGINT	
,	@iItemUID	bigint
,	@iELevel	smallint
,	@iOK		int = 0

AS
SET NOCOUNT ON;
SET XACT_ABORT ON;



BEGIN TRAN
	IF NOT EXISTS (SELECT 1 FROM dbo.GItemEnchant WITH (NOLOCK) WHERE UnitUID = @iUnitUID AND ItemUID = @iItemUID)
		BEGIN
			INSERT INTO dbo.GItemEnchant(UnitUID, ItemUID, ELevel)
				SELECT @iUnitUID, @iItemUID, @iELevel
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END
			GOTO COMMIT_TRAN
		END
	
	UPDATE dbo.GItemEnchant WITH (UPDLOCK)
		SET ELevel = @iELevel
			WHERE UnitUID = @iUnitUID AND ItemUID = @iItemUID
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -2	GOTO FAIL_TRAN	END

COMMIT_TRAN:
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_deny_option]
	@iUnitUID	BIGINT
,	@iQuestion	TINYINT
,	@iCodeNo	TINYINT
,	@iOK		INT	= 0
/*
	2009. 10. 16
	sutamtwo
	친구 요청 거절하기
*/

AS
SET NOCOUNT ON;

IF NOT EXISTS (SELECT 1 FROM dbo.GDenyOption WITH (NOLOCK) WHERE UnitUID = @iUnitUID AND QuestionNo = @iQuestion)
	BEGIN
		INSERT INTO dbo.GDenyOption (UnitUID, QuestionNo, CodeNo)
			SELECT @iUnitUID, @iQuestion, @iCodeNo
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN
				SELECT @iOK = -1	GOTO FAIL_TRAN
			END
	END

ELSE
	BEGIN
		UPDATE dbo.GDenyOption
			SET CodeNo = @iCodeNo
				WHERE UnitUID = @iUnitUID AND QuestionNo = @iQuestion
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN
				SELECT @iOK = -2	GOTO FAIL_TRAN
			END
		
	END
COMMIT TRAN	

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_community_opt]
    @iUnitUID_			[bigint],
	@iInsertFriendDeny_	[tinyint],
	@iManToManChatDeny_ [tinyint],
	@iPartyDeny_		[tinyint],
	@iPrivateDealDeny_	[tinyint],
    @iOK        [int] = 0
AS

SET NOCOUNT ON;

-- 해당 Unit이 없는 경우 
IF NOT EXISTS ( select * from dbo.GUnit with (nolock) where UnitUID = @iUnitUID_ )
	BEGIN  select @iOK = -1	goto END_PROC END

-- Insert
IF NOT EXISTS( SELECT * FROM dbo.GDenyOption WITH( NOLOCK ) WHERE UnitUID = @iUnitUID_ )
	BEGIN
		BEGIN TRAN
			INSERT INTO dbo.GDenyOption with (updlock) ( UnitUID, QuestionNo, CodeNo )
				SELECT  @iUnitUID_, 1, @iInsertFriendDeny_
				union all
				SELECT  @iUnitUID_, 2, @iManToManChatDeny_
				union all
				SELECT  @iUnitUID_, 3, @iPartyDeny_
				union all
				SELECT  @iUnitUID_, 4, @iPrivateDealDeny_
	
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 4
			BEGIN    
				SELECT @iOK = -2
				GOTO FAIL_TRAN
			END
		COMMIT TRAN
	END

-- Update
ELSE
	BEGIN
		BEGIN TRAN
			UPDATE dbo.GDenyOption WITH(updlock)
				SET CodeNo = 
					CASE questionNo 
						when 1 then @iInsertFriendDeny_ 
						when 2 then @iManToManChatDeny_ 
						when 3 then @iPartyDeny_ 
						when 4 then @iPrivateDealDeny_ 
						else 1
					END
				WHERE UnitUID = @iUnitUID_
				
			IF @@ERROR <> 0
			BEGIN
				SELECT @iOK = -3
				GOTO FAIL_TRAN
			END

		COMMIT TRAN
	END

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_Character_Count]
	@iUnitUID	BIGINT,
	@iLogType	SMALLINT,
	@iCount		INT,
	@iOK        [int] = 0
AS

SET NOCOUNT ON;

BEGIN TRAN
	IF NOT EXISTS( SELECT * FROM dbo.GCharacter_Count WITH (NOLOCK) WHERE UnitUID = @iUnitUID and LogType = @iLogType )
	BEGIN
		INSERT INTO dbo.GCharacter_Count (UnitUID, LogType, [Count])
			SELECT @iUnitUID, @iLogType, @iCount
	END
	
	ELSE	
	BEGIN
		UPDATE dbo.GCharacter_Count WITH (ROWLOCK) 
		SET [count] = [count] + @iCount
		WHERE UnitUID = @iUnitUID AND LogType = @iLogType
	END
	
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	BEGIN	SELECT @iOK = -1	GOTO	FAIL_TRAN	END
	
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_cash_skill_point_info]
	@iUnitUID	BIGINT
,	@iCsPoint	TINYINT
,	@iOK		INT	= 0
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

/*
	2009. 05. 07
	sutamtwo
	CsPoint 를 업데이트 해줌 (절대값으로)
	Return : OK
*/


BEGIN TRAN
	UPDATE dbo.GSkill_Cash
		SET CsPoint = @iCsPoint
			WHERE UnitUID = @iUnitUID
			
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END			
			
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_cash_skill_period]
	@iUnitUID	BIGINT
,	@iPeriod	TINYINT
,	@iOK		INT	= 0
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

/*
	2009. 06. 16
	sutamtwo
	캐시 스킬의 남은 기한을 연장
	Return : OK
*/

DECLARE	@sdtEndDate	SMALLDATETIME
,		@sdtNowDate	SMALLDATETIME

SELECT @sdtNowDate = EndDate
	FROM dbo.GSkill_Cash WITH (NOLOCK)
		WHERE UnitUID = @iUnitUID
		
IF (@sdtNowDate <= GETDATE())
	BEGIN	
		SELECT @iOK = -1	GOTO FAIL_TRAN	
	END

IF NOT EXISTS (SELECT UnitUID FROM dbo.GSkill_Cash WITH (NOLOCK) WHERE UnitUID = @iUnitUID)
	BEGIN	
		SELECT @iOK = -2	GOTO FAIL_TRAN	
	END


SELECT	@sdtEndDate = DATEADD(DD, @iPeriod, @sdtNowDate)


BEGIN TRAN

	UPDATE dbo.GSkill_Cash
		SET EndDate	= @sdtEndDate
	WHERE UnitUID = @iUnitUID
		OPTION (MAXDOP 1)
		
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -3	GOTO FAIL_TRAN	END			

			
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK, @sdtEndDate
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_Attribute]
	@iUnitUID	bigint
,	@iItemUID	bigint
,	@iSlotNo	Tinyint
,	@iAttribute	tinyint
,	@iOK		int = 0

AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRAN
	IF NOT EXISTS (SELECT 1 FROM dbo.GItemAttribute WITH (NOLOCK) WHERE UnitUID = @iUnitUID AND ItemUID = @iItemUID AND SlotNo = @iSlotNo)
		BEGIN
			INSERT INTO dbo.GItemAttribute (UnitUID, ItemUID, SlotNo, Attribute)
				SELECT @iUnitUID, @iItemUID, @iSlotNo, @iAttribute
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END
			GOTO COMMIT_TRAN
		END

		UPDATE dbo.GItemAttribute
			SET Attribute	= @iAttribute
				WHERE UnitUID = @iUnitUID AND ItemUID = @iItemUID AND SlotNo = @iSlotNo
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1 
		BEGIN	SELECT @iOK = -2	GOTO FAIL_TRAN	END


COMMIT_TRAN:
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_arcade_rank]
	@iUnitUID	bigint
,	@iGameMode	int
,	@iStageCnt	tinyint
,	@iPlayTime	int 
,	@sdtRegDate	smalldatetime
,	@strUnit1	nvarchar(16)
,	@strUnit2	nvarchar(16)
,	@strUnit3	nvarchar(16)
,	@iOK		int = 0



AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRAN
	IF NOT EXISTS (SELECT TOP 1 UnitUID FROM dbo.GRank_Arcade WITH (NOLOCK) WHERE UnitUID = @iUnitUID AND GameMode = @iGameMode)
		BEGIN
			INSERT INTO dbo.GRank_Arcade (UnitUID, GameMode, StageCnt, PlayTime, RegDate, Unit1, Unit2, Unit3)
				SELECT @iUnitUID, @iGameMode, @iStageCnt, @iPlayTime, @sdtRegDate, @strUnit1, @strUnit2, @strUnit3
		
				

			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END
			GOTO COMMIT_TRAN
		END

		UPDATE dbo.GRank_Arcade WITH (UPDLOCK)
			SET StageCnt = @iStageCnt,
				PlayTime = @iPlayTime,
				RegDate = @sdtRegDate,
				Unit1 = @strUnit1,
				Unit2 = @strUnit2,
				Unit3 = @strUnit3
				WHERE UnitUID = @iUnitUID AND GameMode = @iGameMode
				
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1 
		BEGIN	SELECT @iOK = -2	GOTO FAIL_TRAN	END


COMMIT_TRAN:
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK


--CREATE TABLE dbo.GRank_Arcade
--(
--	UnitUID		bigint
--,	GameMode	int
--,	StageCnt	tinyint
--,	PlayTime	int
--,	RegDate		smalldatetime
--,	Unit1		nvarchar(16) DEFAULT NULL
--,	Unit2		nvarchar(16) DEFAULT NULL
--,	Unit3		nvarchar(16) DEFAULT NULL
--,	CONSTRAINT FK_GRank_Arcade_GUnit_UnitUID FOREIGN KEY (UnitUID) REFERENCES dbo.GUnit (UnitUID) ON UPDATE CASCADE ON DELETE CASCADE
--)
--
--create clustered index PKC_GRank_Arcade_UnitUID on dbo.GRank_Arcade (UnitUID) WITH FILLFACTOR = 80
--
--
--CREATE TABLE dbo.GRank_Arcade_Server
--(
--	Rank		tinyint
--,	GameMode	int
--,	StageCnt	tinyint
--,	PlayTime	int
--,	RegDate		smalldatetime
--,	Unit1		nvarchar(16)
--,	Unit2		nvarchar(16) DEFAULT NULL
--,	Unit3		nvarchar(16) DEFAULT NULL
--,	Unit4		nvarchar(16) DEFAULT NULL
--,	UnitUID1	bigint
--,	UnitUID2	bigint
--,	UnitUID3	bigint
--,	UnitUID4	bigint
--)
--
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_30min]
	@iUnitUID	BIGINT
,	@iEventType	smallint
,	@sdtEndDate	smalldatetime
,	@iOK		INT = 0
AS 

/* 
sutamtwo
작성일 : 2008년 05월 19일
사용 : 30분 접속 이벤트 (UPDATE 용)
*/
SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRAN
	IF EXISTS (SELECT * FROM dbo.GIs30Min WITH (NOLOCK) WHERE UnitUID = @iUnitUID AND EventType = @iEventType)
		BEGIN
			UPDATE dbo.GIs30Min WITH (UPDLOCK)
				SET	RegDate = @sdtEndDate
					WHERE UnitUID = @iUnitUID AND EventType = @iEventType
			IF @@ERROR <> 0 OR @@ROWCOUNT > 1
				BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END
		END
	ELSE 
		BEGIN
			INSERT INTO dbo.GIs30Min (UnitUID, EventType, RegDate)
				SELECT @iUnitUID, @iEventType, @sdtEndDate
			IF @@ERROR <> 0 OR @@ROWCOUNT > 1
				BEGIN	SELECT @iOK = -2	GOTO FAIL_TRAN	END
		END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:

SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_tool_insert_post_item]
    @iUnitUID       [bigint],
    @iItemID        [int],
    @iQuantity      [smallint],	
    @iPeriod	    [TINYINT],	
	@strTitle		[nvarchar](70),
	@strText		[nvarchar](500),
	@strSession		[nvarchar](24),
	@strIP			[nvarchar](15),
    @iOK            [int] = 0,
    @iItemUID       [bigint] = 0
AS

SET NOCOUNT ON;

-- 해당 유닛이 없는 경우.
IF NOT EXISTS( SELECT * FROM dbo.GUnit WITH( NOLOCK ) WHERE UnitUID = @iUnitUID AND Deleted = 0 )
BEGIN
    SELECT @iOK = -1
    GOTO END_PROC
END

DECLARE @sdtNow			smalldatetime
,		@iPeriodType	tinyint
,		@iEndurance		smallint
SELECT  @sdtNow = GetDate()

/*
select @iPeriodType = Period, @iEndurance = Endurance
	from dbo.gitemcode
		where itemcode = @iItemID
*/


BEGIN TRAN
	INSERT INTO dbo.GPost (FromUnitUID, ToUnitUID, Quantity, ScType, ScIndex, RegDate, DelDate, IsReceive, IsRead, Title, [Message])
		SELECT 0, @iUnitUID, @iQuantity, 5, @iItemID, @sdtNow, @sdtNow, 0, 0, @strTitle, @strText

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN
			SELECT @iOK = -11 -- GItem insert Error
			GOTO FAIL_TRAN
		END

	SELECT @iItemUID = @@IDENTITY
/*
-- 수량성 아이템이면,
    IF @iPeriodType = 2
    BEGIN
        INSERT INTO dbo.GItemQuantity( ItemUID, Quantity )
			SELECT @iItemUID, @iQuantity
        IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN
				SELECT @iOK = -12 -- 수량성 아이템 insert Error
				GOTO FAIL_TRAN
			END
    END
-- 내구도 아이템이면,
	IF @iPeriodType = 1
    BEGIN
        INSERT INTO dbo.GItemEndurance( ItemUID, Endurance )
			SELECT @iItemUID, @iEndurance
        IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN
				SELECT @iOK = -13 -- 내구도 아이템 insert Error
				GOTO FAIL_TRAN
			END
    END
*/
-- 내구도 아이템이면,
	IF @iPeriodType = 1 AND @iPeriod <> 0
    BEGIN
        INSERT INTO dbo.GPost_Period( PostNo, Period )
			SELECT @iItemUID, @iPeriod
        IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN
				SELECT @iOK = -13 -- 내구도 아이템 insert Error
				GOTO FAIL_TRAN
			END
    END

-- 로그 남기기
	insert into dbo.GItemToolHistory(UnitUID,Itemuid,InsOrDel,session,ip,regdate)
		select @iUnitUID, @iItemUID, 0, @strSession, @strIP, @sdtNow
		    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN
					SELECT @iOK = -14 -- Log insert Error
					GOTO FAIL_TRAN
				END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_set_end_period]
    @strNickName	nvarchar(20)
,	@iEndMin		int
AS
	SET NOCOUNT ON

	DECLARE	@iUnitUID	bigint
	DECLARE @EndDate	smalldatetime
	
	SET @EndDate = DATEADD(MI, @iEndMin, GETDATE())
	
	SELECT	@iUnitUID = UnitUID
	FROM dbo.GUnitNickName WITH (NOLOCK)
	WHERE NickName = @strNickName
	
	BEGIN TRY
		BEGIN TRAN
	
		UPDATE dbo.GItemPeriod
		SET ExpirationDate = @EndDate
		FROM dbo.GItemPeriod AS A WITH(NOLOCK)
		WHERE EXISTS (SELECT * FROM dbo.GItem WITH(NOLOCK) WHERE UnitUID = @iUnitUID AND ItemUID = A.ItemUID)
		
		UPDATE dbo.GTitle_Complete
		SET EndDate = @EndDate
		WHERE UnitUID = @iUnitUID
		
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		IF (XACT_STATE()) <> 0
			ROLLBACK TRAN
		
		RETURN -1
	END CATCH
	
	RETURN 0
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_select_unit_new]
	@iUnitUID_		bigint
,	@iUserUID	[bigint]
AS
	SET NOCOUNT ON

	-- 기존 파라미터에서 변수로 변경
	DECLARE @Result		int

	DECLARE @sdtNow			smalldatetime
	,		@sdtSpiritDate	smalldatetime
	--,		@iSpirit		smallint
	--,		@bSpiritFlag	bit
	,		@sdtLastLogin	smalldatetime
	,		@iStartCnt		smallint
	,		@iSupplyCnt		smallint
	,		@iStartSpirit	smallint
	,		@sdtRegDate		smalldatetime
	DECLARE @strErrorMSG	nvarchar(max)

	SET @strErrorMSG = N'%s [gup_select_unit_new @iUnitUID_ = %I64d, @iUserUID = %I64d, @Result = %d]'

	SELECT @sdtLastLogin = LastDate, @sdtRegDate = RegDate, @sdtNow = GETDATE()
	FROM dbo.GUnit WITH(NOLOCK)
	WHERE UnitUID = @iUnitUID_
		AND Deleted = 0

	-- 해당 유닛이 없는 경우.
	IF @@ROWCOUNT = 0
		SET @Result = -1

	SELECT @sdtSpiritDate = regdate
	--, @iSpirit = Spirit, @bSpiritFlag = Flag
	FROM dbo.GSpirit WITH(NOLOCK)
	WHERE unitUID = @iUnitUID_

	SELECT @iStartCnt = StartCnt, @iSupplyCnt = SupplyCnt, @iStartSpirit = StartSpirit
	FROM dbo.GResurrectionStoneCnt WITH(NOLOCK)


	BEGIN TRY

		BEGIN TRAN

			IF NOT EXISTS ( SELECT * FROM dbo.GUnit WITH(NOLOCK) WHERE UnitUID = @iUnitUID_ AND UserUID = @iUserUID ) BEGIN
				SET @Result = -10
				
				RAISERROR(@strErrorMSG, 15, 1, N'GUnit ', @iUnitUID_, @iUserUID, @Result) WITH SETERROR
			END
			
			IF CONVERT(smalldatetime, CONVERT(varchar(10), DATEADD(hh, 18, @sdtSpiritDate), 120) + ' 06:00') < @sdtNow BEGIN

				SET @Result = -11

				UPDATE dbo.GSpirit
				SET Spirit = @iStartSpirit
				,	Flag = 0
				,	Regdate = @sdtNow
				WHERE UnitUID = @iUnitUID_
			END
			
					
			UPDATE dbo.GEventDungeonData
			SET PlayCount = 0
			,	SuccessCount = 0
			,	LastResetTime = @sdtNow
			WHERE UnitUID = @iUnitUID_
			AND CONVERT(varchar(10), DATEADD(dd, 1, LastResetTime), 120) < @sdtNow


			-- 부활석 정책

			-- 기존 캐릭터의 부활석 정보 가져오기
			DECLARE @iQuantity	int

			SELECT @iQuantity = Quantity
			FROM dbo.GResurrectionStone	WITH(NOLOCK)
			WHERE unituid =@iUnitUID_

			IF @@ROWCOUNT = 0 BEGIN
				SET @Result = -21

				INSERT INTO dbo.GResurrectionStone ( UnitUID, Quantity )
				VALUES ( @iUnitUID_, @iStartCnt )
			END
			ELSE IF CONVERT(smalldatetime, CONVERT(varchar(10), DATEADD(hh, 18, @sdtLastLogin), 120) + ' 06:00') < @sdtNow BEGIN
				-- 기준치보다 보유량이 적을 때
				IF(@iQuantity < @iSupplyCnt) BEGIN
					SET @Result = -22

					UPDATE dbo.GResurrectionStone
					SET Quantity = @iSupplyCnt
					WHERE UnitUID = @iUnitUID_
				END
			END

			SET @Result = -32

			UPDATE dbo.GUnit
			SET LoginCount = LoginCount + 1
			,	LastDate = @sdtNow
			,	PlayDayCnt = CASE WHEN DATEDIFF(dd, @sdtLastLogin, @sdtNow) > 0 THEN PlayDayCnt + 1 ELSE PlayDayCnt END
			WHERE UnitUID = @iUnitUID_

		COMMIT TRAN
		
		IF(@iQuantity < @iSupplyCnt)
			EXEC [Statistics].dbo.P_StatsStoneCnt_SET 0, @iSupplyCnt, @iQuantity


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

	SELECT @Result AS Result, @sdtRegDate AS RegDate, @sdtLastLogin AS LastLogin, @iSupplyCnt, @iQuantity
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_select_unit]
	@iUnitUID_	[bigint]
,	@iOK		[int] = 0
AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

-- 해당 유닛이 없는 경우.
IF NOT EXISTS( SELECT * FROM dbo.GUnit WITH( NOLOCK ) WHERE UnitUID = @iUnitUID_ AND Deleted = 0 )
BEGIN
    SELECT @iOK = -1
    GOTO END_PROC
END


DECLARE @iSpirit		smallint
,		@sdtSpiritDate	smalldatetime
,		@sdtNow			smalldatetime
,		@bSpiritFlag	bit
,		@sdtLastLogin	smalldatetime
,		@iStartCnt		smallint
,		@iSupplyCnt		smallint
,		@iStartSpirit	smallint
/*******등록 날짜 추가*******/
,		@sdtRegDate		smalldatetime
/*******등록 날짜 추가*******/
,		@iQuantity		INT
,		@istone			INT		-- 충전될 부활석 수량


SELECT @sdtNow = getdate()
SELECT @sdtLastLogin = LastDate
/*******등록 날짜 추가*******/
,	@sdtRegDate = RegDate
/*******등록 날짜 추가*******/

	FROM dbo.GUnit	WITH (NOLOCK)
		WHERE UnitUID = @iUnitUID_

SELECT @iSpirit = Spirit, @sdtSpiritDate = regdate, @bSpiritFlag = Flag
	FROM dbo.GSpirit  WITH (NOLOCK)
		WHERE unitUID = @iUnitUID_

SELECT @iStartCnt = StartCnt, @iSupplyCnt = SupplyCnt, @iStartSpirit = StartSpirit
	FROM dbo.GResurrectionStoneCnt WITH (NOLOCK)

-- 기존 캐릭터의 부활석 정보 가져오기
SELECT	@iQuantity = quantity
	FROM dbo.GResurrectionStone	 WITH (NOLOCK)
		WHERE unituid = @iUnitUID_

SELECT @istone = @iSupplyCnt - @iQuantity

BEGIN TRAN
IF CONVERT(SMALLDATETIME,CONVERT(NVARCHAR(10),dateadd(hh,+18,@sdtSpiritDate),120)+' 06:00') < @sdtNow
	BEGIN
		SELECT @iSpirit = @iStartSpirit
		SELECT @bSpiritFlag = 0

		UPDATE [Game01].[dbo].[GSpirit] WITH (UPDLOCK)
			SET Spirit = @iStartSpirit,	Flag = 0, Regdate = @sdtNow
				WHERE UnitUID = @iUnitUID_
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN	SELECT @iOK = -11	GOTO FAIL_TRAN	END

	END



	
/*
-- 휴면 유저 아이템 지급
IF @sdtLastLogin < '2009-01-07 16:00' AND @RegDate < '2009-01-02 17:00'
	BEGIN
		-- 3개월 이상
		IF '2008-09-30 23:59' >= @sdtLastLogin
			BEGIN
				INSERT INTO dbo.GPost (FromUnitUID, ToUnitUID, Quantity, ScType, ScIndex, RegDate, DelDate, IsReceive, IsRead, Title, Message)
					SELECT @iUnitUID_, @iUnitUID_, 1, 5, 130220, @sdtNow, @sdtNow, 0, 0, '겨울 캠프 이벤트 두울', '겨울 캠프 이벤트를 맞이 하여 뜻 깊은 감사의 선물을 드립니다.'
			END
		-- 3개월 미만
		ELSE
			BEGIN
				INSERT INTO dbo.GPost (FromUnitUID, ToUnitUID, Quantity, ScType, ScIndex, RegDate, DelDate, IsReceive, IsRead, Title, Message)
					SELECT @iUnitUID_, @iUnitUID_, 1, 5, 130210, @sdtNow, @sdtNow, 0, 0, '겨울 캠프 이벤트 두울', '겨울 캠프 이벤트를 맞이 하여 뜻 깊은 감사의 선물을 드립니다.'
			END
	END
-- 휴면 유저 아이템 지급		

*/

-- 부활석 정책
  IF CONVERT(SMALLDATETIME,CONVERT(NVARCHAR(10),dateadd(hh,+18,@sdtLastLogin),120)+' 06:00') < @sdtNow
	BEGIN

	-- 신규 캐릭터라면,
	IF NOT EXISTS (SELECT * FROM dbo.GResurrectionStone WITH (NOLOCK) WHERE UnitUID = @iUnitUID_)
		BEGIN
			INSERT INTO dbo.GResurrectionStone (UnitUID, Quantity)
				SELECT @iUnitUID_, @iStartCnt
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN	SELECT @iOK = -21	GOTO FAIL_TRAN	END
		END
	-- 기준치보다 보유량이 적을 때,
	ELSE
		BEGIN
			IF(@iQuantity < @iSupplyCnt)
				BEGIN
					UPDATE dbo.GResurrectionStone WITH (UPDLOCK)
						SET QUANTITY = @iSupplyCnt
							WHERE UnitUID = @iUnitUID_
					IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
						BEGIN	SELECT @iOK = -22	GOTO FAIL_TRAN	END
/*
	-- 일간 부활석 리필 숫자 저장
					IF NOT EXISTS (SELECT * FROM [Statistics].dbo.StatsStoneCnt WHERE Regdate = CONVERT(NVARCHAR(10), GETDATE(),120))
						BEGIN
							INSERT INTO [Statistics].dbo.StatsStoneCnt (RegDate, FreeInsertCnt,Plus1,Plus2,Plus3,PlusOver3)
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
					*/	
				END

		END	
	END


	IF DateDiff ( day, @sdtLastLogin, @sdtNow ) > 0
	BEGIN
		UPDATE dbo.GUnit WITH( ROWLOCK ) 
			SET PlayDayCnt = PlayDayCnt + 1 WHERE UnitUID = @iUnitUID_
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN	SELECT @iOK = -31	GOTO FAIL_TRAN	END
	END

	UPDATE dbo.GUnit WITH( ROWLOCK ) 
		SET LoginCount = LoginCount + 1, LastDate = @sdtNow 
			WHERE UnitUID = @iUnitUID_
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -32	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK, @sdtRegDate, @sdtLastLogin--,@istone
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_select_event_account_nor]
	@iUserUID	BIGINT

AS 
/* 
sutamtwo
작성일 : 2010년 06월 15일
사용 : 계정단위 접속 이벤트
*/
SET NOCOUNT ON;
SET XACT_ABORT ON;

	SELECT EventUID, RegDate
		FROM dbo.GEvent_Account_Nor WITH (NOLOCK)
			WHERE UserUID = @iUserUID
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_select_event_account_acc]
	@iUserUID	BIGINT

AS 
/* 
sutamtwo
작성일 : 2010년 06월 15일
사용 : 계정단위 접속 이벤트
*/
SET NOCOUNT ON;
SET XACT_ABORT ON;

	SELECT EventUID, RemainTime
		FROM dbo.GEvent_Account_Acc WITH (NOLOCK)
			WHERE UserUID = @iUserUID
GO
/*	sutamtwo
	2008-01-31
	블랙 리스트에 얻어오기
*/

CREATE OR ALTER PROCEDURE [dbo].[gup_select_blacklist]
(
	@iMyUID		bigint	
,	@iOK		int = 0
)

AS

SET NOCOUNT ON ;

SELECT a.BlockUID, b.Nickname
	FROM dbo.GBlackList	as a WITH (NOLOCK) , dbo.GUnitNickname AS b WITH (NOLOCK)
		WHERE a.MyUID = @iMyUID and a.blockuid = b.unituid
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_select_arcade_rank]
	@iUnitUID	bigint

AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

SELECT GameMode, StageCnt, PlayTime, RegDate, Unit1, Unit2, Unit3
	FROM dbo.GRank_Arcade WITH (NOLOCK)
		WHERE UnitUID = @iUnitUID
			OPTION (MAXDOP 1)
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_select_30min]
	@iUnitUID	BIGINT
,	@iOK		[int] = 0
AS 
/* 
sutamtwo
작성일 : 2008년 05월 19일
사용 : 30분 접속 이벤트 (SELECT 용)
*/
SET NOCOUNT ON;
SET XACT_ABORT ON;

	SELECT EVENTTYPE, REGDATE
		FROM dbo.GIs30min WITH (NOLOCK)
			WHERE UnitUID = @iUnitUID
GO
/*
	2009.04.15
	sutamtwo
	닉네임을 복구해주기
*/

CREATE OR ALTER PROCEDURE [dbo].[gup_restore_nickname]
	@iUnitUID_			[bigint]
,	@strNewNickName_	[nvarchar](16)
,	@iOK				[int] = 0
AS
SET NOCOUNT ON;



-- 해당 유닛이 없는 경우.
IF NOT EXISTS( SELECT * FROM dbo.GUnit WITH( NOLOCK ) WHERE UnitUID = @iUnitUID_ AND Deleted = 0 )
BEGIN
    SELECT @iOK = -1
    GOTO END_PROC
END

DECLARE @strNickName    NVARCHAR(16)
,		@sdtNow			SMALLDATETIME
,		@sdtNickDate	SMALLDATETIME
SELECT	@sdtNow = GetDate()
SELECT @strNickName = CASE WHEN nickname LIKE '%[_]%' THEN '__DELETED__' ELSE nickname END FROM dbo.GUnitNickName WITH( NOLOCK ) WHERE UnitUID = @iUnitUID_  

-- 닉네임 복구 대상이 아니다.
IF @strNickName <> N'__DELETED__'
BEGIN
    SELECT @iOK = -2
    GOTO END_PROC
END

-- 동일한 닉네임이 존재하는 경우
IF EXISTS( SELECT * FROM dbo.GUnitNickName WITH(NOLOCK) WHERE NickName = @strNewNickName_ )
BEGIN
    SELECT @iOK = -3
    GOTO END_PROC
END

-- 삭제된 닉네임 중 해당 닉네임이 존재하는 경우
IF EXISTS( SELECT * FROM dbo.GDeletedNickNameHistory with (nolock) WHERE NickName = @strNewNickName_ )
    BEGIN    
		SELECT @sdtNickDate = MAX(RegDate) FROM dbo.GDeletedNickNameHistory WITH(NOLOCK) WHERE NickName = @strNewNickName_
		IF (DATEADD(DD,-14,@sdtNow) < @sdtNickDate)
			BEGIN	SELECT @iOK = -4  SELECT @sdtNickDate = DATEADD(DD,14,@sdtNickDate) GOTO END_PROC	END
	END



BEGIN TRAN

    UPDATE dbo.GUnitNickName
        SET NickName	= @strNewNickName_
			WHERE UnitUID = @iUnitUID_
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	BEGIN    
		SELECT @iOK = -5
		GOTO FAIL_TRAN
	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_restore_nick_name]
    @iUserUID_			[bigint]
,	@iUnitUID_			[bigint]
,	@strNewNickName_	[nvarchar](16)
,	@iOK				[int] = 0
AS
SET NOCOUNT ON;


-- 해당 유닛이 없는 경우.
IF NOT EXISTS( SELECT * FROM dbo.GUnit WITH( NOLOCK ) WHERE UserUID = @iUserUID_ AND UnitUID = @iUnitUID_ AND Deleted = 0 )
BEGIN
    SELECT @iOK = -1
    GOTO END_PROC
END

DECLARE @strNickName    nvarchar(16)
,		@sdtNow			smalldatetime

SELECT @sdtNow = GetDate()

SELECT @strNickName = NickName FROM dbo.GUnitNickName WITH( NOLOCK ) WHERE UnitUID = @iUnitUID_

-- 닉네임 복구 대상이 아니다.
IF @strNickName <> N'__DELETED__'
BEGIN
    SELECT @iOK = -2
    GOTO END_PROC
END

-- 동일한 닉네임이 존재하는 경우
IF EXISTS( SELECT * FROM dbo.GUnitNickName WITH(NOLOCK) WHERE NickName = @strNewNickName_ )
BEGIN
    SELECT @iOK = -3
    GOTO END_PROC
END

-- 삭제된 닉네임 중 해당 닉네임이 존재하는 경우
IF EXISTS( SELECT * FROM dbo.GDeletedNickName with (nolock) WHERE NickName = @strNewNickName_ )
BEGIN
    SELECT @iOK = -4
    GOTO END_PROC
END

BEGIN TRAN

    UPDATE dbo.GUnitNickName
        SET NickName = @strNewNickName_, RegDate = @sdtNow
        WHERE UnitUID = @iUnitUID_
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	BEGIN    
		SELECT @iOK = -5
		GOTO FAIL_TRAN
	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_new_blacklist_user]
	@iUnitUID_ [bigint],	
	@strNickName_ [nvarchar](16),
	@iOK [int] = 0
AS
SET NOCOUNT ON;

--존재하는 닉네임인지 확인
DECLARE @iBLUnitUID_ bigint

SET @iBLUnitUID_ = (SELECT UnitUID FROM dbo.GUnitNickName WHERE NickName = @strNickName_ )
    IF @iBLUnitUID_ IS NULL
        BEGIN    SELECT @iOK = -10    GOTO END_PROC    END

--이미 등록된 유저인지 체크
IF EXISTS(SELECT * FROM dbo.GFriendList WITH(NOLOCK) WHERE UnitUID1 = @iUnitUID_ AND UnitUID2 = @iBLUnitUID_ AND Type = 4)
    BEGIN    SELECT @iOK = -1    GOTO END_PROC    END

DECLARE @sdtNow smalldatetime
SELECT  @sdtNow = GetDate()

BEGIN TRAN

--블랙리스트 유저 UnitUID 등록
    INSERT INTO dbo.GFriendList(
                               UnitUID1
,						       UnitUID2
,                              RegDate
,						       Type
                              )
        SELECT  @iUnitUID_
,				@iBLUnitUID_
,               @sdtNow
,				4						 -- 임시로 4로 넣음 : 4는 블랙리스트 타입

    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
        BEGIN    SELECT @iOK = -11    GOTO FAIL_TRAN    END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK, @iBLUnitUID_
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_insert_unsealed_skill]
	@iUnitUID	[bigint]
,	@iSkillID	[SMALLINT]
,	@iOK		[int] = 0
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

/*
	2009. 04. 29
	sutamtwo
	스킬 봉인 해제하기
	Return : UnitUID, SkillID
*/



-- 이미 습득한 스킬이라면
IF EXISTS (SELECT UnitUID FROM dbo.GSkill_Unsealed WITH (NOLOCK) WHERE UnitUID = @iUnitUID AND SkillID = @iSkillID)
	BEGIN	SELECT @iOK = -1	GOTO END_PROC	END


BEGIN TRAN	

		INSERT INTO	DBO.GSkill_Unsealed (UnitUID, SkillID, RegDate)
			SELECT @iUnitUID, @iSkillID, GETDATE()
		
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN	SELECT @iOK = -2	GOTO FAIL_TRAN	END

				
COMMIT TRAN	

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_insert_unit_lastpoint]
	@iUnitUID		BIGINT,
	@iGamepoint		INT,
	@sdtRegDate		SMALLDATETIME,
	@iOK			INT = 0
	

AS
SET NOCOUNT ON;

BEGIN TRAN				
				
	IF EXISTS ( SELECT * FROM dbo.GUnit_LastPoint WITH(NOLOCK) WHERE UnitUID = @iUnitUID )
		BEGIN
			UPDATE dbo.GUnit_LastPoint WITH (UPDLOCK)
			SET Gamepoint = @iGamepoint,
				RegDate = @sdtRegDate
			WHERE UnitUID = @iUnitUID
			
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1 
			BEGIN    SELECT @iOK = -1   GOTO FAIL_TRAN    END
		END
	ELSE
		BEGIN
			INSERT INTO	dbo.GUnit_LastPoint WITH (UPDLOCK) (UnitUID, Gamepoint, RegDate)
			SELECT @iUnitUID, @iGamepoint, @sdtRegDate

			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1 
			BEGIN    SELECT @iOK = -2   GOTO FAIL_TRAN    END
		END
	
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_insert_tutor]
	@TeacherUID	bigint	
,	@StudentUID	bigint	
,	@iOK			int = 0
AS
SET NOCOUNT ON;


DECLARE @sdtNow	smalldatetime
SELECT	@sdtNow	= GETDATE()


--	한 스승이 제자 3명 초과
IF 3 <= (SELECT COUNT(*) FROM dbo.GTutor WITH (NOLOCK) WHERE TeacherUID = @TeacherUID AND Deleted = 0)
	BEGIN	SELECT	@iOK = -2	GOTO FAIL_TRAN	END


--	제자가 이미 다른 스승과 사제관계를 맺고 있음
IF EXISTS (SELECT * FROM dbo.GTutor WITH (NOLOCK) WHERE StudentUID = @StudentUID AND Deleted = 0)
	BEGIN	SELECT	@iOK = -3	GOTO FAIL_TRAN	END


BEGIN TRAN
	
	INSERT INTO dbo.GTutor (TeacherUID,	StudentUID, RegDate, LastDate, DelDate)
		SELECT @TeacherUID, @StudentUID, @sdtNow, @sdtNow, @sdtNow
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT	@iOK = -1	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
/*	sutamtwo
	2008-10-07
	미션 성공 -> 미션 지우기 -> 칭호 받기
	PERIOD 값이 0이면 영구, 나머지 숫자면 더해서 종료일 계산
	
	Hwang
	2011-01-11
	TitleID smailint 에서 int 데이터 타입변경
*/

CREATE OR ALTER PROCEDURE [dbo].[gup_insert_title]
(
	@iUnitUID	bigint
,	@iTitleID	int
,	@iPeriod	smallint
,	@iOK		int = 0
)

AS

SET NOCOUNT ON ;

DECLARE	@sdtEndDate	smalldatetime
,		@iIsExist	tinyint

IF @iPeriod = 0
	BEGIN	
		SELECT	@sdtEndDate = '2040-12-31 23:59'	
	END

ELSE
	BEGIN
		SELECT	@sdtEndDate = DATEADD(DD, @iPeriod, GETDATE())
	END



SELECT @iIsExist = (SELECT COUNT(*) FROM dbo.GTitle_Complete WITH (NOLOCK) WHERE UnitUID = @iUnitUID AND TitleID = @iTitleID)



BEGIN TRAN

	-- 처음 들어온 Title이면
	IF	(@iIsExist = 0)
		BEGIN
			INSERT INTO dbo.GTitle_Complete (UnitUID, TitleID, EndDate, IsHang)
				SELECT @iUnitUID, @iTitleID, @sdtEndDate, 0
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END
		
		END
	-- 이미 들어왔던 기록이 있으면
	ELSE
		BEGIN
			UPDATE dbo.GTitle_Complete
				SET EndDate = @sdtEndDate
					WHERE UnitUID = @iUnitUID AND TitleID = @iTitleID
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN	SELECT @iOK = -2	GOTO FAIL_TRAN	END

		END

	-- 진행 중이던 미션 지우기
	DELETE FROM dbo.GTitle_Mission
		WHERE UnitUID = @iUnitUID AND TitleID = @iTitleID
	--IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	--	BEGIN	SELECT @iOK = -3	GOTO FAIL_TRAN	END

	
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK, @sdtEndDate
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_insert_tc_clear]
    @iUnitUID	[bigint]
,   @iTCID		[int]
,   @sdtRegDate [smalldatetime]
,   @iOK        [int] = 0
AS

SET NOCOUNT ON;

-- 해당 유닛이 없는 경우.
IF NOT EXISTS( SELECT * FROM dbo.GUnit WITH( NOLOCK ) WHERE UnitUID = @iUnitUID AND Deleted = 0 )
BEGIN
    SELECT @iOK = -1
    GOTO END_PROC
END

-- 이미 클리어하였다고 기록되어 있는 경우.
IF EXISTS( SELECT * FROM dbo.GTrainingCenter WITH( NOLOCK ) WHERE UnitUID = @iUnitUID AND TCID = @iTCID )
	BEGIN
		SELECT @iOK = -2
		GOTO END_PROC
	END


BEGIN TRAN

    INSERT INTO dbo.GTrainingCenter( UnitUID, TCID, RegDate )
		SELECT @iUnitUID, @iTCID, @sdtRegDate
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN
					SELECT @iOK = -3
				    GOTO FAIL_TRAN
				END    

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
/* 현재 사용되고있지 않음 */
CREATE OR ALTER PROCEDURE [dbo].[gup_insert_stone]
	@strNick	nvarchar(16)
,	@iQuantity	smallint
AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE @iUnitUID	bigint
SELECT @iUnitUID = unitUID
	FROM dbo.GUnitNickname
		WHERE nickname = @strNick

	IF NOT EXISTS (SELECT * FROM dbo.GResurrectionStone WHERE unitUID = @iUnitUID)
	BEGIN
		INSERT INTO dbo.GResurrectionStone (UnitUID, Quantity)
			SELECT @iUnitUID, @iQuantity
	END

		UPDATE dbo.GResurrectionStone
			SET Quantity = @iQuantity
				WHERE UnitUID = @iUnitUID

SELECT * FROM dbo.GResurrectionStone
	WHERE UNITUID = @iUnitUID
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_insert_skill_slotB_new]
	@iUnitUID	BIGINT
,	@iPeriod	SMALLINT
,	@iOK		INT	= 0
AS

SET NOCOUNT ON;
	
/*
	2009. 05. 26
	sutamtwo
	확장 스킬 슬롯 구매하기
*/

DECLARE	@sdtNow	SMALLDATETIME
,		@sdtEnd	SMALLDATETIME


SELECT	@sdtNow = GETDATE()	


-- 기한제 혹은 영구
IF (@iPeriod = 0)
	BEGIN
		SELECT @sdtEnd = '2049-12-31 23:59'
	END
ELSE	
	BEGIN
		SELECT @sdtEnd = DATEADD(DD, @iPeriod, @sdtNow)
	END	


BEGIN TRAN

-- 스킬 확장 구매한 적 없음
IF NOT EXISTS (SELECT 1 FROM dbo.GSkillSlot2_New WITH (NOLOCK) WHERE UnitUID = @iUnitUID)
	BEGIN
		INSERT INTO dbo.GSkillSlot2_New (UnitUID, Slot01, Slot02, Slot03, Slot04, EndDate)
			SELECT @iUnitUID, 0, 0, 0, 0, @sdtEnd
		
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN    SELECT @iOK = -11    GOTO FAIL_TRAN    END			
	END	
	
ELSE
	BEGIN
		UPDATE dbo.GSkillSlot2_New
			SET	EndDate = @sdtEnd
				WHERE UnitUID = @iUnitUID		
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN    SELECT @iOK = -12    GOTO FAIL_TRAN    END				
	END
	
	
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK, @sdtEnd
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_insert_skill_slot2_new]
	@iUnitUID	BIGINT	
,	@iSlot01	SMALLINT
,	@iSlot02	SMALLINT
,	@iSlot03	SMALLINT
,	@iSlot04	SMALLINT
,	@iOK		INT	= 0
AS
SET NOCOUNT ON;

BEGIN TRAN
	--이미 등록되어 있으면 업데이트
	IF EXISTS(SELECT * FROM dbo.GSkillSlot2_New WITH(NOLOCK) WHERE UnitUID = @iUnitUID	)
		BEGIN	
			UPDATE dbo.GSkillSlot2_New WITH( ROWLOCK )
					SET Slot01 = @iSlot01
					,	Slot02 = @iSlot02 
					,	Slot03 = @iSlot03
					,	Slot04 = @iSlot04
				WHERE UnitUID = @iUnitUID
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN	SELECT @iOK = -11	GOTO FAIL_TRAN	END	    
		END
	--없으면 생성후 등록
	ELSE
		BEGIN
			INSERT INTO dbo.GSkillSlot2_New (UnitUID, Slot01, Slot02, Slot03, Slot04, EndDate)
			SELECT @iUnitUID, @iSlot01, @iSlot02 , @iSlot03, @iSlot04, '2000-01-01 00:00:00'
		
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN    SELECT @iOK = -12    GOTO FAIL_TRAN    END	
		END	

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_insert_skill_slot_new]
	@iUnitUID	BIGINT	
,	@iSlot01	SMALLINT
,	@iSlot02	SMALLINT
,	@iSlot03	SMALLINT
,	@iSlot04	SMALLINT
,	@iOK		INT	= 0
AS
SET NOCOUNT ON;

BEGIN TRAN
	--이미 등록되어 있으면 업데이트
	IF EXISTS(SELECT * FROM dbo.GSkillSlot_New WITH(NOLOCK) WHERE UnitUID = @iUnitUID	)
		BEGIN	
			UPDATE dbo.GSkillSlot_New WITH( ROWLOCK )
					SET Slot01 = @iSlot01
					,	Slot02 = @iSlot02 
					,	Slot03 = @iSlot03
					,	Slot04 = @iSlot04
				WHERE UnitUID = @iUnitUID
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN	SELECT @iOK = -11	GOTO FAIL_TRAN	END	    
		END
	--없으면 생성후 등록
	ELSE
		BEGIN
			INSERT INTO dbo.GSkillSlot_New ( UnitUID, Slot01, Slot02, Slot03, Slot04 )
				SELECT  @iUnitUID, @iSlot01, @iSlot02, @iSlot03, @iSlot04
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN    SELECT @iOK = -12    GOTO FAIL_TRAN    END
		END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_insert_skill]
	@iUnitUID_ [bigint],
	@iSkillID_ [int],
	@iOK [int] = 0
AS
SET NOCOUNT ON;

--이미 배운 스킬인지 체크
IF EXISTS(SELECT * FROM dbo.GSkill WITH(NOLOCK) WHERE UnitUID = @iUnitUID_ AND SkillID = @iSkillID_ )
    BEGIN    SELECT @iOK = -1    GOTO END_PROC    END

DECLARE @sdtNow smalldatetime
SELECT  @sdtNow = GetDate()

BEGIN TRAN
    INSERT INTO dbo.GSkill(
                           UnitUID
,                          SkillID
,                          RegDate
                          )
        SELECT  @iUnitUID_
,               @iSkillID_
,               @sdtNow
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
        BEGIN    SELECT @iOK = -11    GOTO FAIL_TRAN    END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_insert_recommend]
	@NewUID		bigint
,	@OldNick	nvarchar(16)
,	@iOK		int = 0
AS
SET NOCOUNT ON;


IF NOT EXISTS (SELECT * FROM dbo.GUnitNickName WITH (NOLOCK) WHERE NickName = @OldNick)
BEGIN
	SELECT	@iOK = -1	GOTO END_PROC
END


DECLARE @sdtNow	smalldatetime
,		@iOldUID int

SELECT	@sdtNow	= GETDATE()
SELECT	@iOldUID = UnitUID
	FROM dbo.GUnitNickName	WITH (NOLOCK)
		WHERE NickName = @OldNick

BEGIN TRAN
	
	INSERT INTO dbo.GRecommend (OldUID, NewUID, RegDate)
		SELECT @iOldUID, @NewUID, @sdtNow

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT	@iOK = -2	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK, @iOldUID
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_insert_querystats]
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
CREATE OR ALTER PROCEDURE [dbo].[gup_insert_PShopItem]
	@iOldItemUID	BIGINT
,	@iUnitUID       BIGINT
,	@iItemID        INT
,	@iUsageType		TINYINT
,	@iQuantity      SMALLINT
,	@iEndurance		INT
,	@iSealCnt		TINYINT
,	@iElevel		SMALLINT
,	@iAttribute1	TINYINT
,	@iAttribute2	TINYINT
,	@iAttribute3	TINYINT
,	@iSocket1		INT
,	@iSocket2		INT
,	@iSocket3		INT
,	@iSocket4		INT
,	@iPricePerOne	INT
,	@iFeePerOne		INT
,	@iCategory		TINYINT
,	@iOK            int = 0
,	@iItemUID       BIGINT = 0
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;


-- 해당 유닛이 없는 경우.
IF NOT EXISTS( SELECT 1 FROM dbo.GUnit WITH( NOLOCK ) WHERE UnitUID = @iUnitUID AND Deleted = 0 )
BEGIN
    SELECT @iOK = -1
    GOTO END_PROC
END

DECLARE @sdtNow smalldatetime
,		@sdtEndDate SMALLDATETIME
SELECT  @sdtNow = GetDate()

BEGIN TRAN
	INSERT INTO dbo.GPShopItem( UnitUID, ItemID, UsageType, Quantity, Endurance, SealCnt, ELevel, Attribute1, Attribute2, Attribute3,
								Socket1, Socket2, Socket3, Socket4, PricePerOne, FeePerOne, TotalSellEDIn, TotalSoldItemQuantity, TotalSellCommissionED,
								RegDate, DelDate, OldItemUID, Category )
	SELECT @iUnitUID, @iItemID, @iUsageType, @iQuantity, @iEndurance, @iSealCnt, @iElevel, @iAttribute1, @iAttribute2, @iAttribute3,
		   0, 0, 0, 0, @iPricePerOne, @iFeePerOne, 0, 0, 0, @sdtNow, @sdtNow, @iOldItemUID, @iCategory
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	BEGIN
		SELECT @iOK = -11
		GOTO FAIL_TRAN
	END
	SELECT @iItemUID = @@IDENTITY

	IF @iSocket1 >= 0 OR @iSocket2 >= 0 OR @iSocket3 >= 0 OR @iSocket4 >= 0 BEGIN
		INSERT INTO dbo.GPShopItemSocket ( ItemUID, UnitUID, Socket1, Socket2, Socket3, Socket4 )
		VALUES ( @iItemUID, @iUnitUID, @iSocket1, @iSocket2, @iSocket3, @iSocket4 )
	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK, @iItemUID
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_insert_PShopInfo]
	@iUserUID			BIGINT
,	@iUnitUID			BIGINT
,	@iPeriod			TINYINT
,	@iOK				INT = 0

AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE	@sdtExpirationDate	SMALLDATETIME
,		@sdtnow				SMALLDATETIME
SELECT  @sdtnow = GETDATE()
	

-- 해당 유닛이 없는 경우.
IF NOT EXISTS( SELECT 1 FROM dbo.GUnit WITH( NOLOCK ) WHERE UnitUID = @iUnitUID AND Deleted = 0 )
BEGIN
    SELECT @iOK = -1
    GOTO END_PROC
END

BEGIN TRAN		
		-- 구매한 기록이 없으면	
		IF NOT EXISTS( SELECT 1 FROM dbo.GPShopInfo WITH( NOLOCK ) WHERE UnitUID = @iUnitUID)
		BEGIN
			SELECT @sdtExpirationDate = @sdtnow + @iPeriod
		
			INSERT INTO dbo.GPShopInfo( UserUID, UnitUID, IsPShopOpen, ShopType, PShopName, BeginDate, ExpirationDate, On_Off)
			SELECT @iUserUID, @iUnitUID, 0, 0, '', @sdtExpirationDate, @sdtExpirationDate, 0
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN
					SELECT @iOK = -11
					GOTO FAIL_TRAN
				END
		END
	ELSE
		BEGIN -- 구매한 기록이 있으면
			SELECT @sdtExpirationDate = (SELECT ExpirationDate FROM dbo.GPShopInfo WITH (NOLOCK) WHERE UnitUID = @iUnitUID)
			
			IF (@sdtnow < @sdtExpirationDate)
				BEGIN
					SELECT @sdtExpirationDate = @sdtExpirationDate + @iPeriod
				
					UPDATE dbo.GPShopInfo WITH (ROWLOCK)
					SET	  ExpirationDate = @sdtExpirationDate
					WHERE UnitUID = @iUnitUID
							IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
								BEGIN
									SELECT @iOK = -12
									GOTO FAIL_TRAN
								END
				END
			ELSE
				BEGIN
					SELECT @sdtExpirationDate =  @sdtnow + @iPeriod
				
					UPDATE dbo.GPShopInfo WITH (ROWLOCK)
					SET	  ExpirationDate = @sdtExpirationDate
					WHERE UnitUID = @iUnitUID
							IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
								BEGIN
									SELECT @iOK = -13
									GOTO FAIL_TRAN
								END
				END
		END
					
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK, @sdtExpirationDate
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_insert_post_item_new_test]
	@FromUnitUID	bigint	
,	@ToUnitUID		bigint
,	@Quantity		int		
,	@ScType			tinyint	
,	@ScIndex		int
,	@Title			nvarchar(38)
,	@Message		nvarchar(800)
,	@ELevel			smallint
,	@Socket1		smallint 
,	@Socket2		smallint 
,	@Socket3		smallint 
,	@Socket4		smallint 
,	@Attribute1		tinyint
,	@Attribute2		tinyint
,	@iOK			int = 0

AS
SET NOCOUNT ON;

DECLARE @sdtNow	smalldatetime
,		@PostNo	bigint
,		@Option	int
SELECT	@sdtNow	= GETDATE()

SELECT @Option = (@ELevel + @Socket1 + @Socket2 + @Socket3 + @Socket4 + @Attribute1 + @Attribute2)


/*

해당 부분은 따로 뺄꺼임 [dbo].[gup_check_insert_post_item]

-- 해당 닉네임이 존재하지 않으면 종료
IF @ToUnitUID IS NULL
	BEGIN	SELECT	@iOK = -99	GOTO END_PROC	END

-- 일반 우편이 30개 넘을 때
IF (SELECT COUNT(*) FROM dbo.GPost WITH (NOLOCK) WHERE ToUnitUID = @ToUnitUID AND SCType = 1 AND Deleted = 0) > 29
	BEGIN	SELECT	@iOK = -98	GOTO END_PROC	END

-- 상대방의 블랙 리스트에 내가 등록 되어있다면
IF EXISTS (SELECT * FROM dbo.GPost_BlackList WITH (NOLOCK) WHERE MyUID = @ToUnitUID AND BlockUID = @FromUnitUID)
	BEGIN	SELECT	@iOK = -97	GOTO END_PROC	END

*/

BEGIN TRAN
	
	-- 우체국에 넣기
	INSERT INTO dbo.GPost (FromUnitUID,	ToUnitUID, Quantity, ScType, ScIndex, RegDate, DelDate,	Title, Message)
		SELECT @FromUnitUID, @ToUnitUID, @Quantity, @ScType, @ScIndex, @sdtNow, @sdtNow, @Title, @Message
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT	@iOK = -1	GOTO FAIL_TRAN	END

	-- PostNO 가져오기
	SELECT @PostNo = @@IDENTITY
		

	-- 기타 옵션이 하나도 없을 경우 종료
	IF @Option = 0
		BEGIN	GOTO END_	END


	-- 강화에 해당된다면,
	IF @ELevel > 0
		BEGIN
			INSERT INTO dbo.GPost_Enchant (PostNo, ELevel)
				SELECT @PostNo, @ELevel
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN	SELECT	@iOK = -2	GOTO FAIL_TRAN	END
		END
		

	-- 소켓에 해당된다면,
	IF (@Socket1 + @Socket2 + @Socket3 + @Socket4) > 0
		BEGIN
			INSERT INTO dbo.GPost_Socket (PostNo, Socket1, Socket2, Socket3, Socket4)
				SELECT @PostNo, @Socket1 , @Socket2 , @Socket3 , @Socket4
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN	SELECT	@iOK = -3	GOTO FAIL_TRAN	END
		END

	-- 속성에 해당된다면,
	IF (@Attribute1 + @Attribute2) > 0
		BEGIN
			INSERT INTO GPost_Attribute (PostNo, Attribute1, Attribute2)
				SELECT @PostNo, @Attribute1 , @Attribute2
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN	SELECT	@iOK = -4	GOTO FAIL_TRAN	END
		END

END_:
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK, @PostNo, @ToUnitUID, @sdtNow
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_insert_post_item_new]
	@FromUnitUID	bigint	
,	@ToUnitNickName	nvarchar(16)
,	@Quantity		int		
,	@ScType			tinyint	
,	@ScIndex		int
,	@Title			nvarchar(38)
,	@Message		nvarchar(800)
,	@ELevel			smallint
,	@Socket1		int 
,	@Socket2		int 
,	@Socket3		int 
,	@Socket4		int 
,	@Attribute1		tinyint
,	@Attribute2		TINYINT
,	@Attribute3		TINYINT
,	@iSealCnt		TINYINT
,	@iOK			int = 0

AS
SET NOCOUNT ON;

DECLARE @sdtNow	smalldatetime
,		@PostNo	bigint
,		@ToUnitUID	bigint
SELECT	@sdtNow	= GETDATE()

SELECT @ToUnitUID = UnitUID
	FROM dbo.GunitNickName WITH (NOLOCK)
		WHERE NickName = @ToUnitNickName
			OPTION (MAXDOP 1)

/*

해당 부분은 따로 뺄꺼임 [dbo].[gup_check_insert_post_item]

-- 해당 닉네임이 존재하지 않으면 종료
IF @ToUnitUID IS NULL
	BEGIN	SELECT	@iOK = -99	GOTO END_PROC	END

-- 일반 우편이 30개 넘을 때
IF (SELECT COUNT(*) FROM dbo.GPost WITH (NOLOCK) WHERE ToUnitUID = @ToUnitUID AND SCType = 1 AND Deleted = 0) > 29
	BEGIN	SELECT	@iOK = -98	GOTO END_PROC	END

-- 상대방의 블랙 리스트에 내가 등록 되어있다면
IF EXISTS (SELECT * FROM dbo.GPost_BlackList WITH (NOLOCK) WHERE MyUID = @ToUnitUID AND BlockUID = @FromUnitUID)
	BEGIN	SELECT	@iOK = -97	GOTO END_PROC	END

*/

BEGIN TRAN
	
	-- 우체국에 넣기
	INSERT INTO dbo.GPost (FromUnitUID,	ToUnitUID, Quantity, ScType, ScIndex, RegDate, DelDate,	Title, Message)
		SELECT @FromUnitUID, @ToUnitUID, @Quantity, @ScType, @ScIndex, @sdtNow, @sdtNow, @Title, @Message
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT	@iOK = -1	GOTO FAIL_TRAN	END

	-- PostNO 가져오기
	SELECT @PostNo = @@IDENTITY
		

	-- 기타 옵션이 하나도 없을 경우 종료
	IF @ELevel = 0 AND @Socket1 = 0 AND @Socket2 = 0 AND @Socket3 = 0 AND @Socket4 = 0 AND @Attribute1 = 0 AND @Attribute2 = 0 AND @Attribute3 = 0 AND @iSealCnt = 0
        BEGIN  GOTO END_    END 


	-- 강화에 해당된다면,
	IF @ELevel > 0
		BEGIN
			INSERT INTO dbo.GPost_Enchant (PostNo, ELevel)
				SELECT @PostNo, @ELevel
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN	SELECT	@iOK = -2	GOTO FAIL_TRAN	END
		END
		
	-- 소켓에 해당된다면,
	IF @Socket1 <> 0 OR @Socket2 <> 0 OR @Socket3 <> 0 OR @Socket4 <> 0
		BEGIN
			INSERT INTO dbo.GPost_Socket (PostNo, Socket1, Socket2, Socket3, Socket4)
				SELECT @PostNo, @Socket1 , @Socket2 , @Socket3 , @Socket4
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN	SELECT	@iOK = -3	GOTO FAIL_TRAN	END
		END

	-- 속성에 해당된다면,
	IF (@Attribute1 + @Attribute2+ @Attribute3) > 0							
		BEGIN						
			INSERT INTO GPost_Attribute (PostNo, Attribute1, Attribute2, Attribute3)					
				SELECT @PostNo, @Attribute1 , @Attribute2, @Attribute3				
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1					
				BEGIN	SELECT	@iOK = -4	GOTO FAIL_TRAN	END
		END						


	IF (@iSealCnt > 0)
		BEGIN
			INSERT INTO dbo.GPost_Seal (PostNo, SealCnt) 
				SELECT @PostNo, @iSealCnt
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN	SELECT @iOK = -5	GOTO FAIL_TRAN	END
		END


END_:
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK, @PostNo, @ToUnitUID, @sdtNow
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_insert_post_item]
	@FromUnitUID	bigint	
,	@ToUnitUID		bigint	
,	@Quantity		int		
,	@ScType			tinyint	
,	@ScIndex		bigint	
,	@Message		nvarchar(800)
,	@iOK			int = 0
AS
SET NOCOUNT ON;

DECLARE @sdtNow		smalldatetime
,		@iPostNo	bigint
SELECT	@sdtNow	= GETDATE()

BEGIN TRAN
	
	INSERT INTO dbo.GPost (FromUnitUID,	ToUnitUID, Quantity, ScType, ScIndex, RegDate, DelDate,	Message)
		SELECT @FromUnitUID, @ToUnitUID, @Quantity, @ScType, @ScIndex, @sdtNow, @sdtNow, @Message
	SELECT @iPostNo = @@IDENTITY  
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT	@iOK = -1	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK, @iPostNo, @sdtNow
GO
/*	sutamtwo
	2008-09-26
	블랙 리스트에 등재하기

	-1 : 해당 닉네임 없음
	-2 : 이미 등록된 이름
*/

CREATE OR ALTER PROCEDURE [dbo].[gup_insert_post_blacklist]
(
	@iMyUID		bigint	
,	@iBlockNick	nvarchar(16)
,	@iOK		int = 0
)

AS

SET NOCOUNT ON ;

DECLARE @iBlockUID	bigint
SELECT	@iBlockUID = UnitUID
	FROM dbo.GUnitNickName WITH (NOLOCK)
		WHERE NickName = @iBlockNick

-- 해당 닉네임은 없다
IF (@iBlockUID IS NULL)
	BEGIN	SELECT @iOK = -1	GOTO END_PROC	END

-- 이미 등록된 닉네임이다
IF EXISTS (SELECT * FROM dbo.GPost_BlackList WITH (NOLOCK) WHERE MyUID = @iMyUID AND BlockUID = @iBlockUID)
	BEGIN	SELECT @iOK = -2	GOTO END_PROC	END



BEGIN TRAN
	INSERT INTO dbo.GPost_BlackList (MyUID, BlockUID)
		SELECT @iMyUID, @iBlockUID
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -3	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN


END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_insert_patchitem]
	@strNickName	NVARCHAR(30)
,	@iOK			INT	= 0
/*

	2009. 07. 28
	sutamtwo
	패치에 들어가는 아이템 넣어주기

*/
AS
	SET NOCOUNT ON

	DECLARE	@iUnitUID	bigint
	,		@iUnitClass	tinyint

	SELECT @iUnitUID = UnitUID
	FROM dbo.GUnitNickName WITH(NOLOCK)
	WHERE NickName = @strNickName
	
	IF @@ROWCOUNT = 0 BEGIN
		SELECT @iOK = -1
		RETURN
	END

	SELECT	@iUnitClass = CASE UnitClass
			WHEN 1	THEN 1
			WHEN 10 THEN 1
			WHEN 11 THEN 1
			WHEN 2	THEN 2
			WHEN 14	THEN 2
			WHEN 15	THEN 2
			WHEN 3	THEN 3
			WHEN 12	THEN 3
			WHEN 13	THEN 3
			WHEN 4	THEN 4
			WHEN 16	THEN 4
			WHEN 17	THEN 4
			WHEN 5	THEN 5
			WHEN 18	THEN 5
			WHEN 19	THEN 5
			WHEN 20 THEN 6
			WHEN 21 THEN 6
		END
	FROM dbo.GUnit WITH(NOLOCK)
	WHERE UnitUID = @iUnitUID
	
	BEGIN TRY
		BEGIN TRAN
			SET @iOK = -1

			-- 일단 아이템 넣기
			INSERT INTO dbo.GItem (UnitUID, ItemID, InventoryCategory, SlotID, Endurance, Quantity, Inserted, RegDate)
			SELECT @iUnitUID, ItemID, 0, 0, 10000, 5, 125, GETDATE()
			FROM dbo.GPatchItem WITH(NOLOCK)
			WHERE UnitClass IN ( @iUnitClass, 0 )
		COMMIT TRAN

		SET @iOK = 0
	END TRY
	BEGIN CATCH
		IF (XACT_STATE()) <> 0
			ROLLBACK TRAN
	END CATCH

	SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_insert_notecnt]
	@iUnitUID	BIGINT
,	@iMaxPage	TINYINT
,	@iOK		INT = 0


AS

SET NOCOUNT ON;
	/*
		2010. 03. 26
		sutamtwo

		기술의 노트
		최대 페이지 수 기록 or 업데이트
		없으면 쓰고 있으면 업데이트

	*/


BEGIN TRAN

	IF NOT EXISTS (SELECT 1 FROM dbo.GNote_PageCNT WITH (NOLOCK) WHERE UnitUID = @iUnitUID)
		BEGIN
			INSERT INTO dbo.GNote_PageCNT (UnitUID, MaxPage)
				SELECT @iUnitUID, @iMaxPage
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END
		END	
	
	ELSE 
		BEGIN
			UPDATE dbo.GNote_PageCNT
				SET MaxPage = @iMaxPage
					WHERE UnitUID = @iUnitUID
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN	SELECT @iOK = -2	GOTO FAIL_TRAN	END
		END			
		
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_insert_note]
	@iUnitUID	BIGINT
,	@iItemID	INT	
,	@iPageNo	TINYINT
,	@iOK		INT = 0


AS

SET NOCOUNT ON;
	/*
		2010. 03. 26
		sutamtwo

		기술의 노트
		해당 PageNo에 넘겨받은 ItemID를 쓴다
		없으면 쓰고 있으면 업데이트

	*/


BEGIN TRAN

	IF NOT EXISTS (SELECT 1 FROM dbo.GNote WITH (NOLOCK) WHERE UnitUID = @iUnitUID AND PageNo = @iPageNo)
		BEGIN
			INSERT INTO dbo.GNote (UnitUID, ItemID, PageNo)
				SELECT @iUnitUID, @iItemID, @iPageNo
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END
		END	
	
	ELSE 
		BEGIN
			UPDATE dbo.GNote
				SET ItemID = @iItemID
					WHERE UnitUID = @iUnitUID AND PageNo = @iPageNo
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN	SELECT @iOK = -2	GOTO FAIL_TRAN	END
		END			
		
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_insert_item_Code]
    @iItemCode      [int]
,	@strItemName	nvarchar(16)
,   @iPeriod		[tinyint]
,	@iEndurance		[int],
    @iOK            [int] = 0

AS

SET NOCOUNT ON;

BEGIN TRAN

	INSERT INTO dbo.GItemCode (itemcode, itemname, period, endurance)
		SELECT @iItemCode, @strItemName, @iPeriod, @iEndurance

		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN
				SELECT @iOK = -11	GOTO FAIL_TRAN
			END
    
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_insert_item]
	@iUnitUID		bigint ,
	@iItemID		int ,
	@iPeriodType	tinyint ,
	@iQuantity		smallint ,  
	@iEndurance		int ,
	@iPeriod		int ,
	@iElevel		smallint = 0 ,
	@iAttribute1	tinyint = 0 ,
	@iAttribute2	tinyint = 0 ,
	@iAttribute3	tinyint = 0 ,
	@iInsertType	tinyint ,
	@iOK			int = 0 ,
	@iItemUID		bigint = 0
AS
	SET NOCOUNT ON
	
	DECLARE @sdtNow		datetime
	,	@sdtEndDate		smalldatetime
		
	SET @sdtNow = GETDATE()
		
	-- 해당유닛이 있는 경우.
	IF EXISTS ( SELECT * FROM dbo.GUnit WITH( NOLOCK ) WHERE UnitUID = @iUnitUID ) BEGIN-- AND Deleted = 0
		BEGIN TRY
			BEGIN TRAN
			
			-- 아이템 등록
			SET @iOK = -11
			
			INSERT INTO dbo.GItem ( UnitUID, ItemID, InventoryCategory, UsageType, Quantity, Endurance, SlotID, Inserted, RegDate )
			SELECT @iUnitUID, @iItemID, 0, @iPeriodType
				, CASE WHEN @iPeriodType = 2 THEN @iQuantity ELSE 0 END
				, CASE WHEN @iPeriodType = 1 THEN @iEndurance ELSE -1 END
				, 0
				, @iInsertType
				, @sdtNow
				
			SET @iItemUID = @@IDENTITY
			
			-- 기간제 아이템
			IF @iPeriodType = 0 AND @iPeriod > 0 BEGIN
				SET @iOK = -12
				SET @sdtEndDate = DATEADD( dd, @iPeriod, @sdtNow )
				
				INSERT INTO dbo.GItemPeriod( UnitUID, ItemUID, Period, ExpirationDate )
				SELECT @iUnitUID, @iItemUID, @iPeriod, @sdtEndDate
			END
			
			-- 강화 아이템
			IF @iElevel <> 0 BEGIN
				SET @iOK = -14
				
				INSERT INTO dbo.GItemEnchant (UnitUID, ItemUID, Elevel)
				SELECT @iUnitUID, @iItemUID, @iElevel
			END
			
			-- 속성 부여
			IF @iAttribute1 > 0 OR @iAttribute2 > 0 OR @iAttribute3 > 0 BEGIN
				SET @iOK = -15
				
				INSERT INTO dbo.GItemAttribute (UnitUID, ItemUID, SlotNo, Attribute)
				SELECT @iUnitUID, @iItemUID, SlotNo, Attribute
				FROM (
					SELECT 0 AS SlotNo, @iAttribute1 AS Attribute
					UNION ALL
					SELECT 1, @iAttribute2
					UNION ALL
					SELECT 2, @iAttribute3
				) AS TempTable
				WHERE Attribute > 0
			END
			
			COMMIT TRAN
			SET @iOK = 0
		END TRY
		BEGIN CATCH
			IF (XACT_STATE()) <> 0
				ROLLBACK TRAN
			
			SELECT ERROR_MESSAGE()
		END CATCH
	END
	ELSE
		SET @iOK = -1

	SELECT @iOK, @iItemUID, @sdtEndDate
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_insert_inventory_size]
	@iUnitUID	bigint 
,	@iInventoryCategory tinyint
,	@iNumSlot	tinyint
,	@iOK		int = 0
AS
SET NOCOUNT ON;

DECLARE	@sdtNow	smalldatetime
SELECT	@sdtNow = GETDATE()

BEGIN TRAN

	INSERT INTO dbo.GItemInventorySize (UnitUID, InventoryCategory, NumSlot, RegDate)
		SELECT @iUnitUID, @iInventoryCategory, @iNumSlot, @sdtNow

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_insert_guild_cash_skill_point_info]
	@iGuildNo	INT
,	@iCsPoint	TINYINT
,	@iPeriod	TINYINT
,	@iOK		INT	= 0
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

/*
	2009. 11. 30
	sutamtwo
	길드 캐시 스킬의 정보를 새로 쓰거나 업데이트
	Return : OK
*/


IF NOT EXISTS (SELECT 1 FROM dbo.GGuild WITH (NOLOCK) WHERE GuildNo = @iGuildNo)
	BEGIN
		SELECT @iOK = -1	GOTO END_PROC
	END


DECLARE	@sdtEndDate	SMALLDATETIME
SELECT	@sdtEndDate = DATEADD(DD, @iPeriod, GETDATE())

BEGIN TRAN

	IF EXISTS (SELECT 1 FROM dbo.GGuild_SkillPoint WITH (NOLOCK) WHERE GuildNo = @iGuildNo)
	-- 이미 한번 산적 있음. 업데이트 합시다.
	BEGIN
		UPDATE dbo.GGuild_SkillPoint
			SET Period		= @iPeriod
			,	CsPoint		= @iCsPoint
			,	MaxCsPoint	= @iCsPoint
			,	EndDate		= @sdtEndDate
		WHERE GuildNo = @iGuildNo
			OPTION (MAXDOP 1)
	
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN	SELECT @iOK = -2	GOTO FAIL_TRAN	END			

	END
	
	ELSE

	-- 첫 구매. 인설트 합시다.
	BEGIN
			
		INSERT INTO	dbo.GGuild_SkillPoint (GuildNo, CsPoint, MaxCsPoint, Period, EndDate)
			SELECT @iGuildNo, @iCsPoint, @iCsPoint, @iPeriod, @sdtEndDate
		
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN	SELECT @iOK = -3	GOTO FAIL_TRAN	END
	END
			
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK, @sdtEndDate
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_insert_guild_bbs_join]
	@iGuildNo		INT
,	@iUnitUID		BIGINT
,	@strUnitHello	NVARCHAR(80)
,	@iOK			INT = 0
AS

/*
	2010. 01. 18
	sutamtwo
	길드 게시판에 조인 요청
*/

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRAN
	
	INSERT INTO dbo.GGuild_BBS_Join (UnitUID, GuildNo, UnitHello, RegDate)
		SELECT @iUnitUID, @iGuildNo, @strUnitHello, GETDATE()
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN		END
		
COMMIT TRAN
GOTO END_PROC


FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK, GETDATE()
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_insert_guild_bbs]
	@iGuildNo		INT
,	@strGuildHello	NVARCHAR(80)
,	@iAdvPeriod		TINYINT
,	@iOK			INT = 0
AS

/*
	2010. 01. 18
	sutamtwo
	길드 게시판에 광고내기
*/

SET NOCOUNT ON;
SET XACT_ABORT ON;


DECLARE	@sdtNow		SMALLDATETIME
,		@sdtEndDate	SMALLDATETIME

SELECT	@sdtNow = GETDATE()
SELECT	@sdtEndDate = DATEADD(DD, @iAdvPeriod, @sdtNow)


BEGIN TRAN
	
	INSERT INTO dbo.GGuild_BBS (GuildNo, GuildHello, RegDate, EndDate)
		SELECT @iGuildNo, @strGuildHello, @sdtNow, @sdtEndDate
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN		END
		
COMMIT TRAN
GOTO END_PROC


FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK, @sdtNow, @sdtEndDate
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_insert_guide]
	@iUnitUID	BIGINT
,	@iItemID	INT	
,	@iPageNo	TINYINT
,	@iOK		INT = 0
AS

SET NOCOUNT ON;

DECLARE @PageCnt TINYINT

BEGIN TRAN

	IF NOT EXISTS (SELECT 1 FROM dbo.GGuide WITH (NOLOCK) WHERE UnitUID = @iUnitUID AND PageNo = @iPageNo)
		BEGIN
			INSERT INTO dbo.GGuide (UnitUID, ItemID, PageNo)
				SELECT @iUnitUID, @iItemID, @iPageNo
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END
		END	
	
	ELSE 
		BEGIN
			UPDATE dbo.GGuide
				SET ItemID = @iItemID
					WHERE UnitUID = @iUnitUID AND PageNo = @iPageNo
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN	SELECT @iOK = -2	GOTO FAIL_TRAN	END
		END	
		
	SELECT @PageCnt = COUNT(*) FROM dbo.GGuide WITH(NOLOCK) WHERE UnitUID = @iUnitUID		
		
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK, @PageCnt
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_insert_dungeon_clear]
    @iUnitUID   [bigint],
    @iDungeonID [int],
	@iMaxScore	[int],
	@iMaxTotalRank	[tinyint],
    @sdtRegDate [smalldatetime],
    @iOK        [int] = 0
AS

SET NOCOUNT ON;

-- 해당 유닛이 없는 경우.
IF NOT EXISTS( SELECT * FROM dbo.GUnit WITH( NOLOCK ) WHERE UnitUID = @iUnitUID AND Deleted = 0 )
BEGIN
    SELECT @iOK = -1
    GOTO END_PROC
END



BEGIN TRAN
	-- 이미 클리어하였다고 기록되어 있는 경우.
	IF EXISTS( SELECT * FROM dbo.GDungeonClear WITH( NOLOCK ) WHERE UnitUID = @iUnitUID AND GameMode = @iDungeonID )
		BEGIN
			UPDATE dbo.GDungeonClear WITH (UPDLOCK)
				SET MaxScore = @iMaxScore, MaxTotalRank = @iMaxTotalRank
					WHERE UnitUID = @iUnitUID AND GameMode = @iDungeonID
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN	SELECT @iOK = -2	GOTO	FAIL_TRAN
			END 
		END

	ELSE
		BEGIN
			INSERT INTO dbo.GDungeonClear( UnitUID, GameMode, MaxScore, MaxTotalRank, RegDate )
			SELECT @iUnitUID, @iDungeonID, @iMaxScore, @iMaxTotalRank, @sdtRegDate
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN
				SELECT @iOK = -3
				GOTO FAIL_TRAN
			END    
		END
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_insert_denycode]

AS

SET NOCOUNT ON;


INSERT INTO dbo.GDenyCode (QuestionNo, CodeNo, Comment)
SELECT 1, 0, '친구초대 On' UNION ALL 
SELECT 1, 1, '친구초대 Off' UNION ALL 
SELECT 1, 2, '친구초대 Only Friends' UNION ALL 
SELECT 2, 0, '1:1 채팅 On' UNION ALL 
SELECT 2, 1, '1:1 채팅 Off' UNION ALL 
SELECT 2, 2, '1:1 채팅 OnlyFriends' UNION ALL 
SELECT 3, 0, '파티 초대 On' UNION ALL 
SELECT 3, 1, '파티 초대 Off' UNION ALL 
SELECT 3, 2, '파티 초대 Only Friends' UNION ALL 
SELECT 4, 0, '쪽지 On' UNION ALL 
SELECT 4, 1, '쪽지 Off' UNION ALL 
SELECT 4, 2, '쪽지 Only Friends'
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_insert_cash_skill_point_info]
	@iUnitUID	BIGINT
,	@iCsPoint	TINYINT
,	@iPeriod	TINYINT
,	@iOK		INT	= 0
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

/*
	2009. 04. 28
	sutamtwo
	캐시 스킬의 정보를 새로 쓰거나 업데이트
	Return : OK
*/
DECLARE	@sdtEndDate	SMALLDATETIME
SELECT	@sdtEndDate = DATEADD(DD, @iPeriod, GETDATE())


BEGIN TRAN

	IF EXISTS (SELECT UnitUID FROM dbo.GSkill_Cash WITH (NOLOCK) WHERE UnitUID = @iUnitUID)
	-- 이미 한번 산적 있음. 업데이트 합시다.
	BEGIN
		UPDATE dbo.GSkill_Cash
			SET Period	= @iPeriod
			,	CsPoint	= @iCsPoint
			,	MaxCsP	= @iCsPoint
			,	EndDate	= @sdtEndDate
		WHERE UnitUID = @iUnitUID
			OPTION (MAXDOP 1)
			
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END			

	END
	
	ELSE

	-- 첫 구매. 인설트 합시다.
	BEGIN
			
		INSERT INTO	DBO.GSkill_Cash (UnitUID, CsPoint, MaxCsP, Period, EndDate)
			SELECT @iUnitUID, @iCsPoint, @iCsPoint, @iPeriod, @sdtEndDate
		
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN	SELECT @iOK = -2	GOTO FAIL_TRAN	END
	END
			
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK, @sdtEndDate
GO
/*	sutamtwo
	2008-01-31
	블랙 리스트에 등재하기
*/

CREATE OR ALTER PROCEDURE [dbo].[gup_insert_blacklist]
(
	@iMyUID		bigint	
,	@iBlockUID	bigint	
,	@iOK		int = 0
)

AS

SET NOCOUNT ON ;

DECLARE @strNickName nvarchar(16)
SELECT	@strNickName = Nickname 
	FROM dbo.GUnitNickName WITH (NOLOCK)
		WHERE UnitUID = @iBlockUID

IF (@strNickName IS NULL)
	BEGIN	SELECT @iOK = -1	GOTO END_PROC	END

BEGIN TRAN
	INSERT INTO dbo.GBlackList(MyUID, BlockUID)
		SELECT @iMyUID, @iBlockUID
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -2	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN


END_PROC:
SELECT @iOK, @strNickName
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_insert_BeforeSkillList]
	@iUnitUID	BIGINT
,	@iOK		INT	= 0
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

/*
	2009. 06. 16
	sutamtwo
	스킬 기한 만료 전에 백업용 데이터
	Return : OK
*/


BEGIN TRAN

	UPDATE dbo.GSkill_Cash
		SET MaxCsP = 0
			WHERE UnitUID = @iUnitUID 
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END			


	INSERT INTO dbo.GSkill_BeforeList (UnitUID, SkillID, [Level], CSP, RegDate)
		SELECT UnitUID, SkillID, [Level], CSP, GETDATE()
			FROM dbo.GSkill_New WITH (NOLOCK)
				WHERE UnitUID = @iUnitUID AND Deleted = 0

		
	IF @@ERROR <> 0 
		BEGIN	SELECT @iOK = -2	GOTO FAIL_TRAN	END			

			
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_init_skill]
	@iUnitUID_	[bigint]
,	@iSPointMax	[int]
,	@iOK [int] = 0
AS
SET NOCOUNT ON;

DECLARE @iRowCount int
SELECT	@iRowCount = COUNT(*) 
	FROM dbo.GSkill 
		WHERE UnitUID = @iUnitUID_ 

BEGIN TRAN
	-- 습득 스킬 지우기
    DELETE FROM dbo.GSkill
        WHERE UnitUID = @iUnitUID_
    IF @@ERROR <> 0 OR @@ROWCOUNT <> @iRowCount
        BEGIN    SELECT @iOK = -11    GOTO FAIL_TRAN    END

	-- 장착 스킬 지우기
	UPDATE dbo.GSkillSlot WITH( ROWLOCK )
		SET Slot01 = 0, Slot02 = 0, Slot03 = 0
			WHERE UnitUID = @iUnitUID_
	IF @@ERROR <> 0 OR @@ROWCOUNT > 1
		BEGIN	SELECT @iOK = -12	GOTO FAIL_TRAN	END

	-- 스킬 포인트 보상
	UPDATE dbo.GUnit 
		SET SPoint = @iSPointMax
			WHERE UnitUID = @iUnitUID_
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -13	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_WishList]
	@iUserUID	bigint 

AS
SET NOCOUNT ON;

SELECT SlotNo, ItemID
	FROM dbo.GItemWishList WITH (NOLOCK)
		WHERE UserUID = @iUserUID
			AND ItemID > 0
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_userid_by_nickname]
	@strNickName	nvarchar(16)
--,	@iOK			int = 0
AS
	SET NOCOUNT ON

	SELECT ISNULL(MAX(CASE WHEN A.UserUID IS NULL THEN -1 ELSE 0 END), -1) AS Result
	, MAX(RTRIM(A.UserID)) AS NickName
	, MAX(A.UserUID) AS UserUID
	, MAX(B.UnitUID) AS UnitUID
	FROM dbo.GUser AS A WITH(NOLOCK)
	JOIN dbo.GUnit AS B WITH(NOLOCK)
	ON A.UserUID = B.UserUID AND EXISTS (SELECT * FROM dbo.GUnitNickName WITH(NOLOCK) WHERE NickName = @strNickName AND UnitUID = B.UnitUID)
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_user_info]
	@iUserUID_ [bigint]
,	@iUserID_  nvarchar(20)
,   @iUSSize   [int] = 0
AS
SET NOCOUNT ON;

DECLARE @sdtNow smalldatetime
SELECT  @sdtNow = GetDate()

-- UserUID가 현재 서버군에 처음 접속한 경우
IF NOT EXISTS( SELECT * FROM dbo.GUser WITH (NOLOCK) where UserUID = @iUserUID_ )
BEGIN
    -- USER 정보 추가.
    INSERT INTO dbo.GUser( UserUID, UserID, USSize, RegDate, DelDate )
        SELECT  @iUserUID_,@iUserID_, 5, @sdtNow, @sdtNow
END

SELECT  @iUSSize = USSize
    FROM dbo.GUser WITH(NOLOCK)
        WHERE UserUID = @iUserUID_

SELECT @iUSSize
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_unsealed_skill_info]
	@iUnitUID [bigint]
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

/*
	2009. 04. 29
	sutamtwo
	봉인 해제된 스킬의 정보를 받아감
	Return : UnitUID, SkillID
*/

SELECT SkillID
	FROM DBO.GSkill_Unsealed WITH (NOLOCK)
		WHERE UnitUID = @iUnitUID
			OPTION (MAXDOP 1)
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_unitpvp_info]
	@iUnitUID	BIGINT
AS
SET NOCOUNT ON;

SELECT OfficialMatchCnt, Rating, MaxRating, RPoint, APoint, IsWinBeforeMatch, win, lose
	FROM dbo.GUnitPVP WITH (NOLOCK)
		WHERE UnitUID = @iUnitUID
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_unitinfo_by_UserID_ServerID]
	@iUserUID			bigint
AS
SET NOCOUNT ON
SET XACT_ABORT ON;

	SELECT a.UserID, c.NickName, d.UnitClass, d.[Level], d.[Exp], e.rating as 'VSPointmax', e.Win, e.lose, D.UnitUID
	FROM dbo.GUnit AS D WITH (NOLOCK)
	JOIN dbo.GUser AS A WITH (NOLOCK)
		ON D.UserUID = A.UserUID
	JOIN dbo.GUnitNickName AS C WITH (NOLOCK)		
		ON D.UnitUID = C.UnitUID	
	JOIN dbo.GUnitPVP as E with (nolock)
		ON D.UnitUID = E.UnitUID	
	WHERE D.UserUID = @iUserUID AND D.Deleted = 0
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_unitinfo_by_UserID_MessengerSN]
	@iUnitUID		BIGINT,
	@strNickName	NVARCHAR(20) = N'' OUTPUT,
	@iUnitClass		SMALLINT = 0 OUTPUT,
	@ilevel			TINYINT = 0 OUTPUT,
	@iExp			INT = 0 OUTPUT,
	@iVSPointmax	INT = 0 OUTPUT,
	@iWin			INT = 0 OUTPUT,
	@ilose			INT = 0 OUTPUT

AS
SET NOCOUNT ON;
SET XACT_ABORT ON;
	
	SELECT @strNickName = c.NickName, @iUnitClass = d.UnitClass, @ilevel = d.[Level], @iExp = d.[Exp], @iVSPointmax = e.rating, @iWin = e.Win, @ilose 
= e.lose	
		FROM dbo.GUnit AS D WITH (NOLOCK)	
			JOIN dbo.GUser AS A WITH (NOLOCK)	
				ON D.UserUID = A.UserUID
			JOIN dbo.GUnitNickName AS C WITH (NOLOCK)
				ON D.UnitUID = C.UnitUID
			JOIN dbo.GUnitPVP as E with (NOLOCK)
				ON D.UnitUID = E.UnitUID
			WHERE D.UnitUID = @iUnitUID AND D.Deleted = 0
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_unitinfo_by_serverID_nickname]
	@strNickName_		nvarchar(24),
	@strUserID		NVARCHAR(24) = N'' OUTPUT,
	@iUnitUID		BIGINT = 0 OUTPUT,
	@iUnitClass		SMALLINT = 0 OUTPUT,
	@ilevel			TINYINT = 0 OUTPUT,
	@iExp			INT = 0 OUTPUT,
	@iVSPointmax	INT = 0 OUTPUT,
	@iWin			INT = 0 OUTPUT,
	@ilose			INT = 0 OUTPUT

AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE @iUnitUID_	BIGINT

	SELECT @iUnitUID_ = UnitUID FROM dbo.GUnitNickName WITH (NOLOCK) WHERE NickName = @strNickName_
	
	SELECT @strUserID = a.UserID, @iUnitUID = d.UnitUID, @iUnitClass = d.UnitClass, @ilevel = d.[Level], @iExp = d.[Exp], 
		   @iVSPointmax = e.rating, @iWin = e.Win, @ilose = e.lose	
		FROM dbo.GUnit AS D WITH (NOLOCK)		
			JOIN dbo.GUser AS A WITH (NOLOCK)	
				ON D.UserUID = A.UserUID
			JOIN dbo.GUnitPVP as E with (NOLOCK)
				ON D.UnitUID = E.UnitUID
			WHERE D.UnitUID = @iUnitUID_ AND D.Deleted = 0
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_unitclass_level]
	@strNickName	nvarchar(16)
,	@iOK			int = 0
AS
SET NOCOUNT ON;

-- 존재하지 않는 닉네임
IF NOT EXISTS (SELECT * FROM dbo.GUnitNickName WITH (NOLOCK) WHERE NickName =  @strNickName)
	BEGIN
		SELECT @iOK = -1
		GOTO END_PROC
	END


DECLARE	@iUnitUID bigint
,		@UnitClass int
,		@Level int

SELECT	@iUnitUID = UnitUID 
	FROM dbo.GUnitNickName WITH (NOLOCK)
		WHERE NickName =  @strNickName

SELECT	@UnitClass = UnitClass, @Level = [level]
	FROM dbo.GUnit WITH (NOLOCK)
		WHERE UnitUID = @iUnitUID


END_PROC:
SELECT @iOK, @UnitClass, @Level
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_unitclass_by_unituid]
	@iUnitUID	BIGINT
AS
SET NOCOUNT ON;
	
SELECT UnitClass
	FROM dbo.GUnit
		WHERE UnitUID = @iUnitUID
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_unit_uid]
	@strNickName	NVARCHAR(32)

AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

	SELECT UnitUID 
		FROM dbo.GUnitNickName WITH (NOLOCK)
			WHERE NickName = @strNickName
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_unit_name]				
   @strNickName_		[nvarchar](24)

AS
SET NOCOUNT ON;				
SET XACT_ABORT ON;

	SELECT	UnitUID		
		FROM dbo.GUnitNickName WITH (NOLOCK)		
			WHERE NickName = @strNickName_
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_unit_lastpoint]
	@iUnitUID	BIGINT
	

AS
SET NOCOUNT ON;

	SELECT Gamepoint
		FROM dbo.GUnit_LastPoint WITH (NOLOCK)
			WHERE UnitUID = @iUnitUID
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_unit_info_by_useruid]
	@iUserUID_ [bigint]
AS
SET NOCOUNT ON;

SELECT  a.UnitUID
,       a.UnitClass
,       a.[Exp]
,       a.[Level]
,       a.GamePoint
,		c.Rating
,       a.BaseHP
,       a.AtkPhysic
,       a.AtkMagic
,       a.DefPhysic
,       a.DefMagic
,       a.SPoint
,		CASE WHEN b.NickName LIKE '%[_]%' THEN '__DELETED__' ELSE b.NickName END
,       a.LastPosition
    FROM dbo.GUnit as a WITH(NOLOCK)
		JOIN dbo.GUnitPVP AS c WITH (NOLOCK) ON a.UnitUID = c.UnitUID
        JOIN dbo.GUnitNickName as b WITH(NOLOCK)
            ON a.UserUID = @iUserUID_ AND a.Deleted = 0 AND a.UnitUID = b.UnitUID --삭제된 유저 정보 읽어갈까봐...
				ORDER BY a.LastDate DESC

/* ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 캐릭터 삭제 프로세스 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////

SELECT A.UnitUID, A.UnitClass, A.[Exp], A.[Level], A.GamePoint
	, D.Rating
	, A.BaseHP, A.AtkPhysic, A.AtkMagic, A.DefPhysic, A.DefMagic, A.SPoint, B.NickName
	, A.LastPosition
	, A.LastDate												--$$서버에서 캐릭터 표시 순서를 정하기 위해 추가(Maxpia)
	, A.Deleted, C.DelAbleDate, C.RestoreAbleDate				-- 캐릭터 삭제 대기 추가로 추가(Maxpia)
	FROM dbo.GUnit AS A WITH(NOLOCK)
	JOIN dbo.GUnitNickName AS B WITH(NOLOCK)
		ON A.UnitUID = B.UnitUID
	LEFT OUTER JOIN dbo.GUnitWaitDelete AS C WITH(NOLOCK)
		ON A.UnitUID = C.UnitUID
	JOIN dbo.GUnitPVP AS D WITH(NOLOCK)
		ON A.UnitUID = D.UnitUID
	WHERE A.UserUID = @UserUID
		AND (
			A.Deleted = 0	-- 삭제된 유저 정보 읽어갈까봐...
			OR ( A.Deleted = 1 AND ISNULL(C.Deleted, 1) = 0)	-- 캐릭터 삭제 대기 추가로 추가(Maxpia)
		)
	--ORDER BY A.LastDate DESC									--$$서버에서 정렬 처리하기로함.(Maxpia)
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// */
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_unit_info_by_unituid]
	@iUnitUID_ [bigint]
AS
SET NOCOUNT ON;

DECLARE @iSpirit smallint
,		@iAllSpirit bit
,		@iOldUID bigint

SELECT	@iSpirit = Spirit, @iAllSpirit = Flag
	FROM dbo.GSpirit
		WHERE unitUID = @iUnitUID_


SELECT @iOldUID = 0
SELECT @iOldUID = OldUID 
	FROM dbo.GRecommend
		WHERE NewUID = @iUnitUID_


--SELECT  a.UnitUID
--,       a.UnitClass
--,       a.[Exp]
--,       a.[Level]
--,       a.GamePoint
--,       a.BaseHP
--,       a.AtkPhysic
--,       a.AtkMagic
--,       a.DefPhysic
--,       a.DefMagic
--,       a.SPoint
--,		CASE WHEN b.NickName LIKE '%[_]%' THEN '__DELETED__' ELSE b.NickName END
--,       a.LastPosition
--,		@iSpirit
--,		@iAllSpirit
--,		@iOldUID
--    FROM dbo.GUnit as a WITH(NOLOCK)
--        JOIN dbo.GUnitNickName as b WITH(NOLOCK)
--ON a.UnitUID = @iUnitUID_ AND a.Deleted = 0 AND a.UnitUID = b.UnitUID --삭제된 유저 정보 읽어갈까봐...


SELECT A.UnitUID, A.UnitClass, A.[Exp], A.[Level], A.GamePoint
--	, A.VSPoint, A.VSPointMax
	, A.BaseHP
	, A.AtkPhysic, A.AtkMagic, A.DefPhysic, A.DefMagic, A.SPoint
	, CASE WHEN B.NickName LIKE N'%[_]%' THEN N'__DELETED__' ELSE B.NickName END AS NickName
	--, A.Win, A.Lose
	, A.LastPosition
	, C.Spirit, C.Flag, ISNULL(D.OldUID, 0) AS OldUID
FROM dbo.GUnit AS A WITH(NOLOCK)
JOIN dbo.GUnitNickName AS B WITH(NOLOCK)
	ON A.UnitUID = B.UnitUID
LEFT OUTER JOIN dbo.GSpirit AS C WITH(NOLOCK)
	ON A.UnitUID = C.UnitUID
LEFT OUTER JOIN dbo.GRecommend AS D WITH(NOLOCK)
	ON A.UnitUID = D.NewUID
LEFT OUTER JOIN dbo.GUnitWaitDelete AS E WITH(NOLOCK)
	ON A.UnitUID = e.UnitUID
WHERE A.UnitUID = @iUnitUID_
	AND (
		A.Deleted = 0	-- 삭제된 유저 정보 읽어갈까봐...
		OR ( A.Deleted = 1 AND ISNULL(E.Deleted, 1) = 0)	-- 캐릭터 삭제 대기 추가로 추가(Maxpia)
	)
GO
-- 스승이 1, 제자가 0
CREATE OR ALTER PROCEDURE [dbo].[gup_get_tutor] 
	@bIsTeacher	bit
,	@iUnitUID	bigint	
,	@iOK		int = 0
AS
SET NOCOUNT ON;

DECLARE @sdtNow	smalldatetime
,		@iUnitClass	tinyint
SELECT	@sdtNow	= GETDATE()

SELECT @iUnitClass = UnitClass
	FROM dbo.GUnit WITH (NOLOCK)
		WHERE UnitUID = @iUnitUID



	IF (@bIsTeacher = 1)
		BEGIN
			SELECT a.StudentUID, b.level, c.Nickname, a.lastdate--, @iUnitClass
				FROM dbo.GTutor as a with (nolock)
					JOIN dbo.GUnit as b with (nolock)
						ON a.TeacherUID = @iUnitUID AND a.StudentUID = b.UnitUID
							JOIN dbo.GUnitNickName as c with (nolock)
								ON a.StudentUID = c.UnitUID
									AND a.Deleted = 0
								
		END
	

	IF (@bIsTeacher = 0)
		BEGIN
			SELECT a.TeacherUID, b.level, c.Nickname, a.lastdate--, @iUnitClass
				FROM dbo.GTutor as a with (nolock)
					JOIN dbo.GUnit as b with (nolock)
						ON a.StudentUID = @iUnitUID and a.TeacherUID = b.UnitUID
							JOIN dbo.GUnitNickName as c with (nolock)
								ON a.TeacherUID = c.UnitUID
									AND a.Deleted = 0
			UPDATE dbo.GTutor WITH (UPDLOCK)
				SET LastDate = @sdtNow
					WHERE StudentUID = @iUnitUID
		END
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_title_mission_list]
	@iUnitUID	bigint
AS
SET NOCOUNT ON;

SELECT  TitleID
,       SubMission1
,       SubMission2
,       SubMission3
,       SubMission4
,       SubMission5
    FROM dbo.GTitle_Mission WITH (NOLOCK)
        WHERE UnitUID = @iUnitUID
GO
/*	sutamtwo
	2008-10-07
	보유중인 (클리어 한)
	PERIOD 값이 0이면 영구, 나머지 숫자면 더해서 종료일 계산
*/

CREATE OR ALTER PROCEDURE [dbo].[gup_get_title_list]
(
	@iUnitUID	bigint
)

AS

SET NOCOUNT ON ;


	SELECT TitleID, EndDate, IsHang
		FROM dbo.GTitle_Complete WITH (NOLOCK)
			WHERE UnitUID = @iUnitUID
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_tc_clear]
	@iUnitUID_ [bigint]
AS
SET NOCOUNT ON;

SELECT TCID, CAST( RegDate AS nvarchar(19)) FROM dbo.GTrainingCenter  WITH (NOLOCK) WHERE UnitUID = @iUnitUID_
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_skill_slot2_New]
	@iUnitUID	BIGINT

AS

SET NOCOUNT ON;
	
/*
	2009. 05. 26
	sutamtwo
	확장 스킬 슬롯에 들어있는 스킬 정보
*/

DECLARE	@bState	BIT
,		@sdtNow	SMALLDATETIME
,		@sdtEnd	SMALLDATETIME

SELECT	@bState = 0
SELECT	@sdtNow = GETDATE()	
SELECT	@sdtEnd = EndDate 
	FROM dbo.GSkillSlot2_New WITH (NOLOCK) 
		WHERE UnitUID = @iUnitUID



IF ( @sdtNow < @sdtEnd )
BEGIN
	SELECT @bState = 1
END



-- 스킬 확장 구매한 적 없음
IF NOT EXISTS (SELECT 1 FROM dbo.GSkillSlot2_New WITH (NOLOCK) WHERE UnitUID = @iUnitUID)
	BEGIN
		SELECT 0, 0, 0, 0, '2000-01-01 00:00:00', 0
	END	
	

-- 스킬 확장 구매한 적 있음
ELSE
	BEGIN
		SELECT	Slot01, Slot02, Slot03, Slot04, EndDate, @bState
			FROM dbo.GSkillSlot2_New WITH (NOLOCK)
				WHERE UnitUID = @iUnitUID		
	END
GO
/*
	2008. 04. 21
	sutamtwo
	스킬슬롯 2 정보를 읽어감
	일단 무조건 값을 넘긴 다음,
	유효성 검사는 서버에서 함
	조건 체크문 1줄만 들어가면 DB에서 할 수도 있음
*/

CREATE OR ALTER PROCEDURE [dbo].[gup_get_skill_slot2] 
	@iUnitUID [bigint]
AS
SET NOCOUNT ON;

IF EXISTS (SELECT * FROM dbo.GSkillSlot2 WITH(NOLOCK) WHERE UnitUID = @iUnitUID)
	BEGIN
		SELECT Slot01, Slot02, Slot03, EndDate
			FROM dbo.GSkillSlot2 WITH(NOLOCK) 
				WHERE UnitUID = @iUnitUID
	END
ELSE
	BEGIN
		SELECT 0 AS 'Slot01', 0 as 'Slot02', 0 as 'Slot03', '2000-01-01 00:00:00' as 'EndDate'
	END
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_skill_slot_New]
	@iUnitUID	BIGINT

AS

SET NOCOUNT ON;
	
/*
	2009. 05. 26
	sutamtwo
	기본 스킬 슬롯에 들어있는 스킬 정보
*/

SELECT	Slot01, Slot02, Slot03, Slot04
	FROM dbo.GSkillSlot_New WITH (NOLOCK)
		WHERE UnitUID = @iUnitUID
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_skill_slot]
	@iUnitUID_ [bigint]
AS
SET NOCOUNT ON;

SELECT  Slot01, Slot02, Slot03 FROM dbo.GSkillSlot WITH(NOLOCK) WHERE UnitUID = @iUnitUID_
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_skill_list_new]
	@iUnitUID	bigint


/*
	sutamtwo
	2009. 05. 25
	내가 보유한 스킬 리스트, 사용한 CSP 정보

*/
AS
SET NOCOUNT ON;
SET XACT_ABORT ON;


SELECT	SkillID, [Level], CSP
	FROM dbo.GSkill_New
		WITH(NOLOCK) 
			WHERE UnitUID = @iUnitUID
				AND Deleted = 0
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_skill_list]
	@iUnitUID_ [bigint]
AS
SET NOCOUNT ON;

SELECT  SkillID FROM dbo.GSkill WITH(NOLOCK) WHERE UnitUID = @iUnitUID_
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_select_unit]
	@iUnitUID_	[bigint]
,	@iOK		[int] = 0
AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE @sdtRegDate		smalldatetime

IF NOT EXISTS( SELECT * FROM dbo.GUnit WITH( NOLOCK ) WHERE UnitUID = @iUnitUID_ AND Deleted = 0 )
BEGIN
    set @iok = -1
    
END

else
SELECT @sdtRegDate = RegDate 
	FROM dbo.GUnit	WITH (NOLOCK)
		WHERE UnitUID = @iUnitUID_

SELECT @iOK as result, @sdtRegDate as regdate
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_scl_count]

AS
SET NOCOUNT ON;

SELECT TOP 1 RowNumber
FROM dbo.Temp_SCL WITH (NOLOCK)
ORDER BY RowNumber desc
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_resurrection_stone_autopay] 
	@iUnitUID	BIGINT

AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

	/*
		2009-10-14
		sutamtwo
		자동결제 부활석 수량 가져오기
	*/


DECLARE	@iQuantity		TINYINT
,		@sdtLastRefill	SMALLDATETIME
SELECT	@iQuantity = Quantity
,		@sdtLastRefill = LastRefill
	FROM dbo.GResurrectionStone_AutoPay WITH (NOLOCK)
		WHERE UnitUID = @iUnitUID

IF @iQuantity IS NULL
	BEGIN
		SELECT 0, '2000-01-01 00:00:00'
	END

ELSE 
	BEGIN
		SELECT @iQuantity, @sdtLastRefill
	END
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_resurrection_stone]
	@iUnitUID_ [bigint],
    @iQuantity [smallint] = 0
AS
SET NOCOUNT ON;

SELECT @iQuantity = Quantity FROM dbo.GResurrectionStone WITH (NOLOCK) WHERE UnitUID = @iUnitUID_

SELECT @iQuantity
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_remaintime]
	@iUnitUID	BIGINT

/*
	2009. 12. 04
	sutamtwo
	접속 이벤트의 남은 시간 저장

*/
	
AS
SET NOCOUNT ON;

SELECT EventID, RemainTime 
	FROM dbo.GRemainTime WITH (NOLOCK)
		WHERE UnitUID = @iUnitUID
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_recommend_list_me]
	@iMyUID	BIGINT
AS 

/* 
	2010. 01. 11
	sutamtwo
	나를 추천한 사람들
*/

SET NOCOUNT ON;
SET XACT_ABORT ON;

SELECT a.UnitUID, a.LEVEL, a.UnitClass, b.NickName, c.RegDate
FROM dbo.GRecommend AS c WITH (NOLOCK)
	JOIN dbo.GUnit AS a WITH (NOLOCK)
		ON c.NewUID = a.UnitUID
	JOIN dbo.GUnitNickName AS b WITH (NOLOCK)
		ON a.UnitUID = b.UnitUID
WHERE c.OldUID = @iMyUID AND a.Deleted = 0 AND c.RegDate >= '2010-01-14 08:00'
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_rank_vs]
/*
	2009. 07. 07
	sutamtwo
	Vs 랭킹 2000등

	2011. 07. 27
	대전 랭킹 개편
	
	2012. 09. 20
	대전 시즌2 시작(배치경기 10판 이상하지 않은 유저는 랭킹에서 제외되어야함)
*/
AS
	SET NOCOUNT ON

	SELECT TOP 2000 UnitUID, ROW_NUMBER() OVER(ORDER BY VsRank) as VsRank, NickName, UnitClass, [Level], Grade, Win, RPoint, OfficialMatchCnt
	FROM dbo.GRank WITH(NOLOCK)
	WHERE RegDate = (SELECT MAX(RegDate) FROM dbo.GRank WITH(NOLOCK))
	AND OfficialMatchCnt >= 10
	ORDER BY VsRank
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_rank_spacetime_week]
	
	
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
CREATE OR ALTER PROCEDURE [dbo].[gup_get_rank_spacetime_month]
	
	
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
CREATE OR ALTER PROCEDURE [dbo].[gup_get_rank_spacetime_day]
	
	
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
CREATE OR ALTER PROCEDURE [dbo].[gup_get_rank_myrecord]
	@iUnitUID	BIGINT
	
/*
	2009. 07. 07
	sutamtwo
	나의 최근 랭킹 기록 읽어가기
*/	
	
AS 
SET NOCOUNT ON;

SELECT Stage, PlayTime, [Level], UnitClass, RegDate
	FROM dbo.Rank_SpaceTime_MyRecord WITH (NOLOCK)
		WHERE UnitUID = @iUnitUID
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_rank_exp]
/*
	2009. 07. 07
	sutamtwo
	EXP 랭킹 2000등
*/
AS
	SET NOCOUNT ON

	SELECT TOP 2000 UnitUID, ExpRank, NickName, UnitClass, [Level], [Exp]
	FROM dbo.GRank WITH(NOLOCK)
	WHERE RegDate = (SELECT MAX(RegDate) FROM dbo.GRank WITH(NOLOCK))
	ORDER BY ExpRank
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_quest_repeat_list]
	@iUnitUID_ [bigint]
AS
SET NOCOUNT ON;

SELECT  QuestID
    FROM dbo.GQuests_Repeat WITH(NOLOCK)
        WHERE UnitUID = @iUnitUID_
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_quest_Repeat_complete_list]
	@iUnitUID	bigint
AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

		
SELECT QuestID, MAX(CompleteDate)
	FROM DBO.GQUESTS_REPEAT WITH (NOLOCK)
		WHERE UnitUID = @iUnitUID
		GROUP BY QuestID
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_quest_list]
	@iUnitUID_ [bigint]
AS
SET NOCOUNT ON;

SELECT  QuestID 
,       SubQuest0
,       SubQuest1
,       SubQuest2
,       SubQuest3
,       SubQuest4
    FROM dbo.GQuests WITH(NOLOCK)
        WHERE UnitUID = @iUnitUID_
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_quest_complete_list]
	@iUnitUID_ [bigint]
AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

SELECT  QuestID, RegDate
    FROM dbo.GQuests_Complete WITH(NOLOCK)
        WHERE UnitUID = @iUnitUID_
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_PShopItem_Inventory_by_UnitUID]
	@iUnitUID	BIGINT

AS
SET NOCOUNT ON;

SELECT  A.ItemUID
,		ItemID
,		UsageType
,		Quantity
,		Endurance
,		SealCnt
,		ELevel
,		Attribute1
,		Attribute2
,		Attribute3
,		ISNULL(B.Socket1, A.Socket1) AS Socket1
,		ISNULL(B.Socket2, A.Socket2) AS Socket2
,		ISNULL(B.Socket3, A.Socket3) AS Socket3
,		ISNULL(B.Socket4, A.Socket4) AS Socket4
,		PricePerOne
,		FeePerOne
,		TotalSellEDIn
,		TotalSoldItemQuantity
,		TotalSellCommissionED
,		Category
,		OldItemUID
FROM dbo.GPShopItem AS A WITH(NOLOCK)
LEFT OUTER JOIN dbo.GPShopItemSocket AS B WITH(NOLOCK)
	ON A.ItemUID = B.ItemUID
WHERE A.UnitUID = @iUnitUID and deleted = 0
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_PShop_info_UnitUID]
	@iUnitUID		BIGINT
AS
SET NOCOUNT ON;

SELECT  ExpirationDate
,		IsPShopOpen
    FROM dbo.GPShopInfo WITH (NOLOCK) WHERE UnitUID = @iUnitUID
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_PShop_info]
AS
SET NOCOUNT ON;

SELECT  a.UserUID
,		a.UnitUID	
,		b.NickName
,		a.ShopType
,		a.PShopName
,		a.BeginDate
,		a.ExpirationDate
,		a.On_Off
FROM dbo.GPShopInfo AS a WITH (NOLOCK)
JOIN dbo.GUnitNickName AS b WITH (NOLOCK) ON a.UnitUID = b.UnitUID
WHERE a.IsPShopOpen = 1
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_post_item_new]
	@UnitUID	bigint	
,	@iOK		int = 0
AS
SET NOCOUNT ON;

	SELECT a.PostNo, ISNULL(b.nickname,'__DELETED__'), a.toUnitUID, a.Quantity, a.ScType, a.ScIndex, a.RegDate, a.IsReceive, a.IsRead, a.title, a.Message, c.ELevel, D.socket1, D.socket2, D.socket3, D.socket4, E.Attribute1, E.Attribute2, E.Attribute3, F.SealCnt, a.FromUnitUID	
		FROM dbo.GPost AS A WITH (NOLOCK)
			JOIN dbo.GUnitNickName AS B WITH (NOLOCK)
				ON a.FromUnitUID = b.UnitUID
			LEFT OUTER JOIN dbo.GPost_Enchant AS C WITH (NOLOCK)
				ON A.PostNo = C.PostNo
			LEFT OUTER JOIN dbo.GPost_Socket AS D WITH (NOLOCK)
				ON A.PostNo = D.PostNo
			LEFT OUTER JOIN dbo.GPost_Attribute AS E WITH (NOLOCK)
				ON A.PostNo = E.PostNo
			LEFT OUTER JOIN dbo.GPost_Seal AS F WITH (NOLOCK)
				ON A.PostNo = F.PostNo				
		WHERE a.ToUnitUID = @UnitUID AND a.DELETED = 0
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_post_item]
	@UnitUID	bigint	
,	@iOK		int = 0
AS
SET NOCOUNT ON;

	SELECT a.PostNo, CASE WHEN b.NickName LIKE '%[_]%' THEN '__DELETED__' ELSE b.NickName END, a.FromUnitUID, a.Quantity, a.ScType, a.ScIndex, a.RegDate,	a.Message
		FROM dbo.GPost AS A WITH (NOLOCK)
			JOIN dbo.GUnitNickName AS B WITH (NOLOCK)
				ON a.ToUnitUID = @UnitUID AND a.DELETED = 0 
					AND a.FromUnitUID = b.UnitUID
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_post_blacklist]
	@iUnitUID	[bigint]
AS
SET NOCOUNT ON;

SELECT B.NickName
	FROM dbo.GPost_BlackList AS A WITH(NOLOCK)
		JOIN dbo.GUnitNickName AS B WITH(NOLOCK)
			ON a.MyUID = @iUnitUID
				AND a.BlockUID = b.UnitUID
GO
--gup_get_pet_list
CREATE OR ALTER PROCEDURE [dbo].[gup_get_pet_list]
	@iUnitUID		BIGINT

/* 
2010-07-26 유닛이 가진 펫 리스트 읽어가기
2012-12-26 펫이 ED, 아이템 획득할 수 있는 기능 함께 읽어가도록 수정
  */
 
AS
SET NOCOUNT ON;

SELECT PetUID, PetID, PetName, EvolutionStep, Satiety, Intimacy, Extroversion, Emotion, RegDate, IsCall, AutoFeed, LastFeedDate, LastcallDate, PickUP
	, CASE WHEN RegDate = DelDate THEN NULL ELSE DelDate END DelDate
FROM dbo.GPet_Info WITH (NOLOCK) WHERE UnitUID = @iUnitUID
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_notecnt]
	@iUnitUID	BIGINT

AS

SET NOCOUNT ON;
	/*
		2010. 03. 26
		sutamtwo

		기술의 노트
		현재 내가 가질 수 있는 최대 페이지 수 기록
	*/

SELECT MaxPage
	FROM dbo.GNote_PageCNT WITH (NOLOCK)
		WHERE UnitUID = @iUnitUID
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_note]
	@iUnitUID	BIGINT

AS

SET NOCOUNT ON;
	/*
		2010. 03. 26
		sutamtwo

		기술의 노트
		현재 내가 가진 기술의 노트 내용
	*/

SELECT PageNo, ItemID
	FROM dbo.GNote WITH (NOLOCK)
		WHERE UnitUID = @iUnitUID
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_nickname]
	@iUnitUID	bigint
AS
	SET NOCOUNT ON

	SELECT ISNULL(MAX(NickName), N'') AS NickName
	FROM dbo.GUnitNickName WITH(NOLOCK)
	WHERE UnitUID = @iUnitUID
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_my_guild_info]
	@iUnitUID	BIGINT

AS


SET NOCOUNT ON;
	/*
		2009. 09. 25
		sutamtwo
		내가 속해있는 길드 No, Name
		0이면 없음
	*/


DECLARE	@iGuildNo		INT
SELECT	@iGuildNo = GuildNo
	FROM dbo.GGuild_Member WITH (NOLOCK)
		WHERE UnitUID = @iUnitUID

IF @iGuildNo IS NULL
	BEGIN
		SELECT 0, ''		
	END

ELSE 
	BEGIN
		SELECT @iGuildNo, GuildName
			FROM dbo.GGuild WITH (NOLOCK)
				WHERE GuildNo = @iGuildNo
	END
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_MessengerSN] 
    @iUnitUID_		[bigint]
,	@iMessengerSN	[int] = 0
AS
/* 
작성자 : sutamtwo
작성일 : 2007년 9월 7일
사용 :  캐릭터 선택 시 호출이되며, 호출되면 캐릭터의 UnitUID를 받아 
		넥슨 플러그에 사용될 SN값을 Account.MessengerSN 디비에서 불러온다
결과값 : SN이 0이면 실패, 아닐 경우 성공

*/
SET NOCOUNT ON;

	select @iMessengerSN = SN 
			from [Account].[dbo].[MessengerSN] with (nolock)
				where UnitUID = @iUnitUID_			

SELECT @iMessengerSN
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_item_list_seal]
	@iUnitUID	bigint
AS
	SET NOCOUNT ON
/*
	sutamtwo
	2009.08.27
	봉인 정보 읽기	
*/
	SELECT ItemUID, SealCnt
	FROM dbo.GItemSeal AS A WITH(NOLOCK)
	WHERE EXISTS (
			SELECT *
			FROM dbo.GItem WITH(NOLOCK)
			WHERE ItemUID = A.ItemUID
				AND UnitUID = @iUnitUID
		)
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_Item_list_pet]
	@iUnitUID		BIGINT

/* GItem_Pet 테이블에서 펫이 가지고 있는 아이템 정보 가져가기
 2010-08-06  */
 
AS
SET NOCOUNT ON;

SELECT ItemUID, PetUID
	FROM dbo.GItem_pet WITH (NOLOCK) WHERE UnitUID = @iUnitUID
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_item_list]
	 @iUnitUID_ [bigint]
AS
	SET NOCOUNT ON

	SELECT
		ITM.ItemUID
	,	ITM.ItemID
	,	UsageType
	,	Quantity
	,	Endurance
	,	isnull(PER.Period , 0)
	,	PER.ExpirationDate
	,	isnull(ENC.Elevel, 0)
	,	isnull(SOC.Socket1, 0)
	,	isnull(SOC.Socket2, 0)
	,	isnull(SOC.Socket3, 0)
	,	isnull(SOC.Socket4, 0)
	,	ITM.InventoryCategory
	,	ITM.SlotID
	FROM dbo.GItem						AS ITM  WITH(NOLOCK)
	LEFT OUTER JOIN dbo.GItemEnchant	AS ENC WITH(NOLOCK)
		ON ENC.UnitUID = @iUnitUID_ AND ITM.ItemUID = ENC.ItemUID  --//CL
	LEFT OUTER JOIN dbo.GItemPeriod		AS PER WITH(NOLOCK)
		ON PER.UnitUID = @iUnitUID_ AND ITM.ItemUID = PER.ItemUID  --//NC
	LEFT OUTER JOIN dbo.GItemSocket		AS SOC WITH(NOLOCK)
		ON SOC.UnitUID = @iUnitUID_ AND ITM.ItemUID = SOC.ItemUID  --//NC
	WHERE ITM.UnitUID = @iUnitUID_
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_inventory_size]
	@iUnitUID_ [bigint]
AS
SET NOCOUNT ON;

SELECT InventoryCategory, SUM(NumSlot)
	FROM dbo.GItemInventorySize WITH (NOLOCK) 
		WHERE UnitUID = @iUnitUID_
			GROUP BY NumSlot, InventoryCategory
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_inventory_by_category]
    @iUnitUID_              [bigint],
    @iInventoryCategory_    [tinyint]
AS

SET NOCOUNT ON;

DECLARE @InventoryInfo TABLE
(
    SlotID tinyint not null,
    ItemUID bigint not null,
    ItemID int not null,
    Quantity smallint not null
)

INSERT INTO @InventoryInfo( SlotID, ItemUID, ItemID, Quantity )
    SELECT SlotID, ItemUID, 0, Quantity
        FROM dbo.GItemInventory WITH(NOLOCK)
            WHERE InventoryCategory = @iInventoryCategory_ AND UnitUID = @iUnitUID_ AND ItemUID IS NOT NULL

UPDATE a
    SET a.ItemID = b.ItemID
        FROM @InventoryInfo as a
            JOIN dbo.GItem as b WITH(NOLOCK) ON a.ItemUID = b.ItemUID

SELECT SlotID, ItemUID, ItemID, Quantity
    FROM @InventoryInfo
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_inventory]
    @iUnitUID_ [bigint]
AS

SET NOCOUNT ON;

DECLARE @InventoryInfo TABLE
(
    InventoryCategory tinyint not null,
    SlotID tinyint not null,
    ItemUID bigint not null,
    ItemID int not null,
    Quantity smallint not null
)

INSERT INTO @InventoryInfo( InventoryCategory, SlotID, ItemUID, ItemID, Quantity )
    SELECT InventoryCategory, SlotID, ItemUID, 0, Quantity
        FROM dbo.GItemInventory WITH(NOLOCK)
            WHERE UnitUID = @iUnitUID_ AND ItemUID IS NOT NULL

UPDATE a
    SET a.ItemID = b.ItemID
        FROM @InventoryInfo as a
            JOIN dbo.GItem as b WITH(NOLOCK) ON a.ItemUID = b.ItemUID

SELECT InventoryCategory, SlotID, ItemUID, ItemID, Quantity
    FROM @InventoryInfo
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_henir_reward_cnt]
	@iUnitUID	BIGINT,
	@sdtNow		SMALLDATETIME,
	@iOK		INT = 0
	
AS
SET NOCOUNT ON;

IF NOT EXISTS( SELECT * FROM dbo.GUnit WITH( NOLOCK ) WHERE UnitUID = @iUnitUID AND Deleted = 0 ) BEGIN
	SELECT @iOK = -1    GOTO END_PROC	
END
IF NOT EXISTS( SELECT * FROM dbo.GHenirRewardCnt WITH( NOLOCK ) WHERE UnitUID = @iUnitUID ) BEGIN
	SELECT @iOK = -3    GOTO END_PROC
END

DECLARE	@sdtLastDate	SMALLDATETIME
,		@iNormalCnt		SMALLINT
,		@iPCBangCnt		SMALLINT
,		@iEventCnt		SMALLINT

SELECT @sdtLastDate = LastDate
	FROM dbo.GHenirRewardCnt WITH (NOLOCK)
		WHERE UnitUID = @iUnitUID

BEGIN TRAN

	IF CONVERT(SMALLDATETIME,CONVERT(NVARCHAR(10),dateadd(hh,+18,@sdtLastDate),120)+' 06:00') < @sdtNow
		BEGIN
			UPDATE dbo.GHenirRewardCnt
				SET NormalCnt = 0,
					PCBangCnt = 0,
					EventCnt  = 0,
					LastDate  = @sdtNow
				WHERE UnitUID = @iUnitUID
					IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
						BEGIN	SELECT @iOK = -2	GOTO FAIL_TRAN	END
		END			

	SELECT @iNormalCnt = NormalCnt, @iPCBangCnt = PCBangCnt, @iEventCnt = EventCnt
		FROM dbo.GHenirRewardCnt WITH(NOLOCK)
			WHERE UnitUID = @iUnitUID


COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK, @iNormalCnt, @iPCBangCnt, @iEventCnt
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_guild_skill_point_info]
	@iGuildNo	INT
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

/*
	2009. 11. 26
	sutamtwo
	길드 캐시 스킬의 정보를 받아감
	Return : CsPoint, MaxCsP, EndDate
*/


IF NOT EXISTS ( SELECT 1 FROM dbo.GGuild_SkillPoint WITH (NOLOCK) WHERE GuildNo = @iGuildNo)
	BEGIN
		SELECT	0, 0, 0, '2000-01-01 00:00:00'
	END
ELSE
	BEGIN
		SELECT SPoint, CsPoint, MaxCsPoint, EndDate
			FROM DBO.GGuild_SkillPoint WITH (NOLOCK)
				WHERE GuildNo = @iGuildNo
					OPTION (MAXDOP 1)
	END
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_guild_skill_list_new]
	@iGuildNo	BIGINT


/*
	sutamtwo
	2009. 11. 26
	우리 길드의 스킬 리스트, 사용한 CSP 정보

*/
AS
SET NOCOUNT ON;
SET XACT_ABORT ON;


SELECT	SkillID, [Level], CsPoint
	FROM dbo.GGuild_Skill	WITH(NOLOCK) 
		WHERE GuildNo = @iGuildNo
			AND Deleted = 0
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_guild_member_info]
	@iGuildNo		INT

AS

SET NOCOUNT ON;
	/*
		2009. 09. 25
		sutamtwo
		UID, 
		닉네임, 
		Class, 
		LV, 
		등급, 
		로그아웃시간, 
		길드원 인사말,
		길드원 EXP

	*/



SELECT a.UnitUID, b.NickName, a.UnitClass, a.LEVEL, c.State, c.LastDate, c.MESSAGE
	FROM dbo.GGuild_Member AS c WITH (NOLOCK)
		JOIN dbo.GUnit AS a WITH (NOLOCK)
			ON c.UnitUID = a.UnitUID
		JOIN dbo.GUnitNickName AS b WITH (NOLOCK)
			ON b.UnitUID = c.UnitUID
	WHERE c.GuildNo = @iGuildNo AND a.Deleted = 0
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_guild_member_grade]
	@iUnitUID	BIGINT

AS

SET NOCOUNT ON;
	/*
		2009. 10. 05
		sutamtwo
		길드원 등급 표시
	*/


SELECT ISNULL([State], -1), ISNULL([EXP], -1)
	FROM dbo.GGuild_Member WITH (NOLOCK)
		WHERE UnitUID = @iUnitUID
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_guild_info]
	@iGuildNo		INT

AS

SET NOCOUNT ON;
	/*
		2009. 09. 25
		sutamtwo
		길드이름, 
		MaxNo, 
		길드 경험치, 
		길드 메시지, 
		창단일
	*/


IF EXISTS (SELECT 1 FROM dbo.GGuild WITH (NOLOCK) WHERE GuildNo = @iGuildNo)
	BEGIN
		SELECT 0, GuildName, MaxNo, [Level], [EXP], SayHello, CreateDate
			FROM dbo.GGuild WITH (NOLOCK)
				WHERE GuildNo = @iGuildNo	
	END
ELSE
	BEGIN
		SELECT -1, '', 0, 0, 0, '', '2000-01-01 00:00'
	END
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_guild_cash_skill_point_info]
	@iGuildNo	INT
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

/*
	2009. 11. 26
	sutamtwo
	길드 캐시 스킬의 정보를 받아감
	Return : CsPoint, MaxCsP, EndDate
*/


IF NOT EXISTS ( SELECT 1 FROM dbo.GGuild_SkillPoint WITH (NOLOCK) WHERE GuildNo = @iGuildNo)
	BEGIN
		SELECT	0, 0, 0, '2000-01-01 00:00:00'
	END
ELSE
	BEGIN
		SELECT SPoint, CsPoint, MaxCsPoint, EndDate
			FROM DBO.GGuild_SkillPoint WITH (NOLOCK)
				WHERE GuildNo = @iGuildNo
					OPTION (MAXDOP 1)
	END
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_guild_bbs_list]
AS

/*
	2010. 01. 18
	sutamtwo
	길드 광고 등록된 리스트 얻기	
*/


SET NOCOUNT ON;
SET XACT_ABORT ON;

/*  1-1
SELECT GuildUID, GuildHello, EndDate
	FROM dbo.GGuild_BBS WITH (NOLOCK)
*/

/*
SELECT a.GuildNo, b.GuildName, b.[Level], b.MaxNo, a.GuildHello, a.RegDate, a.EndDate
FROM dbo.GGuild_BBS AS a WITH (NOLOCK)
	JOIN dbo.GGuild AS b WITH (NOLOCK)
		ON a.GuildNo = b.GuildNo
	JOIN dbo.GGuild_Member AS c WITH (NOLOCK)
		ON a.GuildNo = c.GuildNo
*/

SELECT a.GuildNo, b.GuildName, b.[Level], d.NickName, e.CNT, a.GuildHello, b.CreateDate, a.RegDate, a.EndDate
FROM dbo.GGuild_BBS AS a WITH (NOLOCK)
	JOIN dbo.GGuild AS b WITH (NOLOCK)
		ON a.GuildNo = b.GuildNo
	JOIN dbo.GGuild_Member AS c WITH (NOLOCK)
		ON a.GuildNo = c.GuildNo
	JOIN dbo.GUnitNickName AS d WITH (NOLOCK)
		ON c.UnitUID = d.UnitUID
	JOIN
	(
		SELECT GuildNo, COUNT(1) AS CNT
			FROM dbo.GGuild_Member WITH (NOLOCK)
				GROUP BY GuildNo
	) AS e
	ON a.GuildNo = e.GuildNo
WHERE c.State = 1
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_guild_bbs_join_list]

AS

/*
	2010. 01. 18
	sutamtwo
	길드 가입 신청자 리스트
*/

SET NOCOUNT ON;
SET XACT_ABORT ON;


/*1-1
SELECT UnitUID, UnitHello
	FROM dbo.GGuild_BBS_Join WITH (NOLOCK)
		WHERE GuildNo = @iGuildNo
*/


SELECT a.GuildNo, a.UnitUID, c.NickName, b.UnitClass, b.LEVEL, a.UnitHello, a.RegDate
	FROM dbo.gguild_BBS_Join AS a WITH (NOLOCK)
		JOIN dbo.GUnit AS b WITH (NOLOCK)
			ON a.UnitUID = b.UnitUID
		JOIN dbo.GUnitNickName AS c WITH (NOLOCK)
			ON a.UnitUID = c.UnitUID
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_guide]
	@iUnitUID	BIGINT

AS

SET NOCOUNT ON;

SELECT PageNo, ItemID
	FROM dbo.GGuide WITH (NOLOCK)
		WHERE UnitUID = @iUnitUID
GO
/*
	sutamtwo
	2009. 05. 12
	보낸 우편 내역
*/
CREATE OR ALTER PROCEDURE [dbo].[gup_get_frompost]
	@strNickName	nvarchar(20)
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE	@iUnitUID	BIGINT
SELECT	@iUnitUID = UnitUID
	FROM dbo.GUnitNickName WITH (NOLOCK)
		WHERE NickName = @strNickName


SELECT a.PostNo, a.FromUnitUID, a.ToUnitUID, @strNickName AS FromNick, b.NickName AS ToNick, c.ItemName, a.Quantity, a.RegDate, a.Title
	FROM dbo.GPost AS a WITH (NOLOCK)
		JOIN dbo.GUnitNickName AS b WITH (NOLOCK)
			ON a.ToUnitUID = b.UnitUID
		JOIN dbo.GItemCode AS c WITH (NOLOCK)
			ON a.ScIndex = c.ItemCode
	WHERE FromUnitUID = @iUnitUID AND ScType = 1
		ORDER BY a.RegDate DESC OPTION (Maxdop 1)
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_friend_message]
	@iUnitUID	bigint

/*
	2009. 06. 24
	sutamtwo
	친구 요청 메시지 읽어가기
*/

AS
SET NOCOUNT ON;

SELECT MSG.SenderUID, NIC.NickName, MSG.MessageType, MSG.[Message], MSG.RegDate
	FROM dbo.GFriendMessage AS MSG WITH (NOLOCK)
		JOIN dbo.GUnitNickName AS NIC WITH (NOLOCK)
			ON MSG.SenderUID = NIC.UnitUID
		WHERE MSG.UnitUID = @iUnitUID

DELETE FROM dbo.GFriendMessage
	WHERE UnitUID = @iUnitUID
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_friend_list]
	@iUnitUID	bigint

/*
	2009. 06. 24
	sutamtwo
	친구 리스트 읽어가기
*/

AS
SET NOCOUNT ON;
/*

SELECT FRD.FriendUID, NIC.NickName, FRD.GroupID, FRD.[Status]
	FROM dbo.GFriend AS FRD WITH (NOLOCK)
		JOIN dbo.GUnitNickName AS NIC WITH (NOLOCK)
			ON FRD.FriendUID = NIC.UnitUID
	WHERE FRD.UnitUID = @iUnitUID
*/

SELECT FRD.FriendUID, NIC.NickName, FRD.GroupID, FRD.[Status]
	FROM dbo.GFriend AS FRD WITH (NOLOCK)
		JOIN dbo.GUnit AS UNIT WITH(NOLOCK) ON FRD.FriendUID = UNIT.UnitUID AND UNIT.Deleted = 0
		JOIN dbo.GUnitNickName AS NIC WITH (NOLOCK)
			ON FRD.FriendUID = NIC.UnitUID
	WHERE FRD.UnitUID = @iUnitUID
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_friend_group_list]
	@iUnitUID	bigint

/*
	2009. 06. 24
	sutamtwo
	친구 그룹 읽어가기
*/

AS
SET NOCOUNT ON;

SELECT GroupID, GroupName
	FROM dbo.GFriendGroup WITH (NOLOCK)
		WHERE UnitUID = @iUnitUID
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_equipped_item_list_2]
	@iUnitUID_		bigint
AS
	SET NOCOUNT ON

	SELECT A.ItemUID, A.ItemID, A.UsageType, A.Quantity, A.Endurance
	, C.Period, C.ExpirationDate AS EndDate
	, B.ELevel
	, D.Socket1, D.Socket2, D.Socket3, D.Socket4
	, A.InventoryCategory, A.SlotID
	FROM dbo.GItem AS A WITH(NOLOCK)
	LEFT OUTER JOIN dbo.GItemEnchant AS B WITH(NOLOCK)
		ON A.ItemUID = B.ItemUID AND B.UnitUID = @iUnitUID_
	LEFT OUTER JOIN dbo.GItemPeriod AS C WITH(NOLOCK)
		ON A.ItemUID = C.ItemUID AND C.UnitUID = @iUnitUID_
	LEFT OUTER JOIN dbo.GItemSocket AS D WITH(NOLOCK)
		ON A.ItemUID = D.ItemUID AND D.UnitUID = @iUnitUID_
	WHERE A.UnitUID = @iUnitUID_
		AND A.InventoryCategory = 9
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_equipped_item_list]
	@iUnitUID_	bigint
AS
	SET NOCOUNT ON

	SELECT
		ITM.ItemUID
	,	ITM.ItemID
	,	UsageType
	,	Quantity
	,	Endurance
	,	isnull(PER.Period , 0)
	,	PER.ExpirationDate
	,	isnull(ENC.Elevel, 0)
	,	isnull(SOC.Socket1, 0)
	,	isnull(SOC.Socket2, 0)
	,	isnull(SOC.Socket3, 0)
	,	isnull(SOC.Socket4, 0)
	,	ITM.InventoryCategory
	,	ITM.SlotID
	FROM dbo.GItem						AS ITM  WITH(NOLOCK)
	LEFT OUTER JOIN dbo.GItemEnchant	AS ENC WITH(NOLOCK)
		ON ENC.UnitUID = @iUnitUID_ AND ITM.ItemUID = ENC.ItemUID  --//CL
	LEFT OUTER JOIN dbo.GItemPeriod		AS PER WITH(NOLOCK)
		ON PER.UnitUID = @iUnitUID_ AND ITM.ItemUID = PER.ItemUID  --//NC
	LEFT OUTER JOIN dbo.GItemSocket		AS SOC WITH(NOLOCK)
		ON SOC.UnitUID = @iUnitUID_ AND ITM.ItemUID = SOC.ItemUID  --//NC
	WHERE ITM.UnitUID = @iUnitUID_
		AND ITM.InventoryCategory = 9
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_dungeon_clear]
	@iUnitUID_ [bigint]
AS
SET NOCOUNT ON;

SELECT GameMode, MaxScore, MaxTotalRank, CAST( RegDate AS nvarchar(19)) 
	FROM dbo.GDungeonClear WITH (NOLOCK) 
		WHERE UnitUID = @iUnitUID_
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_community_opt_unituid]
	@iUnitUID_ [bigint]
AS
SET NOCOUNT ON;

DECLARE @iValue1 tinyint
DECLARE @iValue2 tinyint
DECLARE @iValue3 tinyint
DECLARE @iValue4 tinyint

SET @iValue1 = (SELECT  CodeNo FROM dbo.GDenyOption WITH(NOLOCK) WHERE UnitUID = @iUnitUID_ AND QuestionNo = 1)
IF @iValue1 IS NULL
BEGIN
	SET @iValue1 = 1
END

SET @iValue2 = (SELECT  CodeNo FROM dbo.GDenyOption WITH(NOLOCK) WHERE UnitUID = @iUnitUID_ AND QuestionNo = 2)
IF @iValue2 IS NULL
BEGIN
	SET @iValue2 = 1
END

SET @iValue3 = (SELECT  CodeNo FROM dbo.GDenyOption WITH(NOLOCK) WHERE UnitUID = @iUnitUID_ AND QuestionNo = 3)
IF @iValue3 IS NULL
BEGIN
	SET @iValue3 = 1
END

SET @iValue4 = (SELECT  CodeNo FROM dbo.GDenyOption WITH(NOLOCK) WHERE UnitUID = @iUnitUID_ AND QuestionNo = 4)
IF @iValue4 IS NULL
BEGIN
	SET @iValue4 = 1
END

SELECT @iValue1, @iValue2, @iValue3, @iValue4
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_Character_Count]
	@iUnitUID	BIGINT

AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

SELECT 	LogType,
		[Count]
    FROM dbo.GCharacter_Count WITH (NOLOCK)
		WHERE UnitUID = @iUnitUID
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_cash_skill_point_info]
	@iUnitUID	[bigint]
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

/*
	2009. 04. 28
	sutamtwo
	캐시 스킬의 정보를 받아감
	Return : CsPoint, MaxCsP, EndDate
*/



IF NOT EXISTS ( SELECT * FROM dbo.GSkill_Cash WITH (NOLOCK) WHERE UnitUID = @iUnitUID )
	BEGIN
		SELECT	0, 0, '2000-01-01 00:00:00'
	END
ELSE
	BEGIN
		SELECT CsPoint, MaxCsP, EndDate
			FROM DBO.GSkill_Cash WITH (NOLOCK)
				WHERE UnitUID = @iUnitUID
					OPTION (MAXDOP 1)
	END
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_blacklist_by_unituid]
	@iUnitUID_ [bigint]
AS
SET NOCOUNT ON;

SELECT  a.UnitUID2
,       b.NickName
    FROM dbo.GFriendList as a WITH(NOLOCK)
        JOIN dbo.GUnitNickName as b WITH(NOLOCK)
            ON a.UnitUID1 = @iUnitUID_ AND a.UnitUID2 = b.UnitUID AND type = 4

--해당 UnitUID의 블랙리스트유저UnitUID와 닉네임까지 얻기
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_attribute]
    @iUnitUID	bigint
AS
	SET NOCOUNT ON

	SELECT ItemUID, SlotNo, Attribute, UnitUID
	FROM dbo.GItemAttribute	AS A WITH(NOLOCK)
	WHERE UnitUID = @iUnitUID
		AND EXISTS (
			SELECT *
			FROM dbo.GItem WITH(NOLOCK)
			WHERE ItemUID = A.ItemUID
				AND UnitUID = @iUnitUID
				AND Inventorycategory IN (1, 8, 9, 13)
		)
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_friend_send_message]
	@iFromUnitUID	BIGINT
,	@strToNick		NVARCHAR(20)
,	@iMessageType	TINYINT
,	@strMessage		NVARCHAR(256)
,	@iOK			INT	= 0

/*
	2009. 06. 24
	sutamtwo
	친구 요청 메시지 보내기
	-1 : 요청한 닉네임의 사람이 없음
	-2 : 트랜젝션 에러
*/

AS
SET NOCOUNT ON;


DECLARE	@iToUnitUID		BIGINT

SELECT	@iToUnitUID = UnitUID
	FROM dbo.GUnitNickName WITH (NOLOCK)
		WHERE NickName = @strToNick
		
IF @iToUnitUID IS NULL
BEGIN
	SELECT @iOK = -1	GOTO END_PROC
END

	
BEGIN TRAN		

	INSERT INTO dbo.GFriendMessage (UnitUID, SenDerUID, MessageType, [Message], RegDate)
		SELECT @iToUnitUID, @iFromUnitUID, @iMessageType, @strMessage, GETDATE()
	
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN
			SELECT @iOK = -2	GOTO FAIL_TRAN
		END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_friend_request]
	@iUserUID		BIGINT
,	@iUnitUID		BIGINT
,	@strNickName	NVARCHAR(20)
,	@iMyStatus		TINYINT	
,	@iFriendStatus	TINYINT
,	@iOK			INT	= 0

/*
	2009. 06. 29
	sutamtwo
	친구 요청 하기
	-1 : 해당 닉네임은 존재하지 않음
	-2 : 내 트랜잭션 에러
	-3 : 친구 트랜잭션 에러
	-4 : 친구의 UserUID가 존재하지 않음
	-5 : 같은 계정의 캐릭터에게 친구 요청함
	-6 : 나의 친구 리스트가 가득 참
	-7 : 친구의 친구 리스트가 가득 참
	-8 : 상대방이 친구 거절 상태임
*/

AS
SET NOCOUNT ON;


DECLARE	@iFriendUID		BIGINT
,		@iFriendUserUID BIGINT
,		@iNumFriend		INT



SELECT	@iFriendUID = UnitUID
	FROM dbo.GUnitNickName WITH (NOLOCK)
		WHERE NickName = @strNickName
			OPTION (MAXDOP 1)
		

IF @iFriendUID IS NULL
	BEGIN
		SELECT @iOK = -1	GOTO END_PROC
	END


SELECT	@iFriendUserUID = UserUID
	FROM dbo.GUnit WITH (NOLOCK)
		WHERE UnitUID = @iFriendUID
			OPTION (MAXDOP 1)

IF @iFriendUserUID IS NULL
	BEGIN
		SELECT @iOK = -4	GOTO END_PROC
	END

IF @iFriendUserUID = @iUserUID
	BEGIN
		SELECT @iOK = -5	GOTO END_PROC
	END



-- 상대방이 친구 거절 상태이다
IF (SELECT CodeNo FROM dbo.GDenyOption WITH (NOLOCK) WHERE UnitUID = @iFriendUID AND QuestionNo = 1) = 0
	BEGIN
		SELECT @iOK = -8	GOTO END_PROC		
	END



-- 나의 친구 리스트가 100명 이상이다
SELECT	@iNumFriend = COUNT( FRD.UnitUID ) 
FROM dbo.GFriend AS FRD WITH (NOLOCK) 
	JOIN dbo.GUnit AS UNIT WITH(NOLOCK) ON FRD.FriendUID = UNIT.UnitUID AND UNIT.Deleted = 0
WHERE FRD.UnitUID = @iUnitUID

IF @iNumFriend >= 100
	BEGIN
		SELECT @iOK = -6	GOTO END_PROC
	END

-- 상대방의 친구 리스트가 100명 이상이다
SELECT	@iNumFriend = COUNT( FRD.UnitUID ) 
FROM dbo.GFriend  AS FRD WITH (NOLOCK) 
	JOIN dbo.GUnit AS UNIT WITH(NOLOCK) ON FRD.FriendUID = UNIT.UnitUID AND UNIT.Deleted = 0
WHERE FRD.UnitUID = @iFriendUID

IF @iNumFriend >= 100
	BEGIN
		SELECT @iOK = -7	GOTO END_PROC
	END
	
	
	
	
BEGIN TRAN		

	INSERT INTO dbo.GFriend (UnitUID, FriendUID, GroupID, Status, RegDate)
		SELECT @iUnitUID, @iFriendUID, 0, @iMyStatus, GETDATE()
	
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN
			SELECT @iOK = -2	GOTO FAIL_TRAN
		END


	INSERT INTO dbo.GFriend (UnitUID, FriendUID, GroupID, Status, RegDate)
		SELECT @iFriendUID, @iUnitUID, 0, @iFriendStatus, GETDATE()
	
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN
			SELECT @iOK = -3	GOTO FAIL_TRAN
		END



COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK, ISNULL(@iFriendUID, 0)
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_friend_move]
	@iUnitUID		BIGINT
,	@iFriendUID		BIGINT
,	@iGroupID		TINYINT
,	@iOK			INT	= 0

/*
	2009. 06. 25
	sutamtwo
	친구 삭제 하기
	-1 : 이상한 그룹 ID이다
	-2 : 트랜잭션 에러
*/

AS
SET NOCOUNT ON;

-- 그룹 ID 유효성 검사
IF (@iGroupID > 0)
BEGIN
	IF NOT EXISTS (SELECT UnitUID FROM dbo.GFriendGroup WITH (NOLOCK) WHERE UnitUID = @iUnitUID AND GroupID = @iGroupID)
		BEGIN	SELECT @iOK = -1	GOTO END_PROC 	END
END


BEGIN TRAN		

	UPDATE dbo.GFriend
		SET GroupID = @iGroupID
			WHERE UnitUID = @iUnitUID AND FriendUID = @iFriendUID

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN
			SELECT @iOK = -2	GOTO FAIL_TRAN
		END


COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_friend_group_rename]
	@iUnitUID		BIGINT
,	@iGroupID		TINYINT
,	@strGroupName	NVARCHAR(30)
,	@iOK			INT	= 0

/*
	2009. 06. 25
	sutamtwo
	그룹 이름 바꾸기
	-1 : 트랜잭션 에러
*/

AS
SET NOCOUNT ON;


BEGIN TRAN		

	UPDATE dbo.GFriendGroup
		SET GroupName = @strGroupName
			WHERE UnitUID = @iUnitUID AND GroupID = @iGroupID

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
CREATE OR ALTER PROCEDURE [dbo].[gup_friend_group_make]
	@iUnitUID		BIGINT
,	@iGroupID		TINYINT
,	@strGroupName	NVARCHAR(30)
,	@iOK			INT	= 0

/*
	2009. 06. 25
	sutamtwo
	그룹 만들기
	-1 : 트랜잭션 에러
*/

AS
SET NOCOUNT ON;


BEGIN TRAN		

	INSERT INTO dbo.GFriendGroup (UnitUID, GroupID, GroupName)
		SELECT @iUnitUID, @iGroupID, @strGroupName

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
CREATE OR ALTER PROCEDURE [dbo].[gup_friend_group_delete]
	@iUnitUID		BIGINT
,	@iGroupID		TINYINT
,	@iOK			INT	= 0

/*
	2009. 06. 25
	sutamtwo
	그룹 삭제하기
	-1 : 그런 그룹 없음
	-2 : 그룹 속해있는 친구들 기본 그룹으로 옮김 에러
	-3 : 그룹 지우기
*/

AS
SET NOCOUNT ON;


-- 그룹 유효성 검사
IF NOT EXISTS (SELECT UnitUID FROM dbo.GFriendGroup WITH (NOLOCK) WHERE UnitUID = @iUnitUID AND GroupID = @iGroupID)
	BEGIN
		SELECT @iOK = -1	GOTO END_PROC
	END


BEGIN TRAN		

	UPDATE dbo.GFriend
		SET GroupID = 0
			WHERE UnitUID = @iUnitUID
				AND GroupID = @iGroupID

	IF @@ERROR	<> 0 
		BEGIN
			SELECT @iOK = -2	GOTO FAIL_TRAN
		END


	DELETE FROM dbo.GFriendGroup
		WHERE UnitUID = @iUnitUID AND GroupID = @iGroupID

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN
			SELECT @iOK = -3	GOTO FAIL_TRAN
		END


COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_friend_get_message]
	@iUnitUID	bigint

/*
	2009. 06. 24
	sutamtwo
	친구 요청 메시지 읽어가기
*/

AS
SET NOCOUNT ON;

SELECT MSG.SenderUID, NIC.NickName, MSG.MessageType, MSG.[Message], MSG.RegDate
	FROM dbo.GFriendMessage AS MSG WITH (NOLOCK)
		JOIN dbo.GUnitNickName AS NIC WITH (NOLOCK)
			ON MSG.SenderUID = NIC.UnitUID
		WHERE MSG.UnitUID = @iUnitUID

DELETE FROM dbo.GFriendMessage
	WHERE UnitUID = @iUnitUID
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_friend_get_list]
	@iUnitUID	bigint

/*
	2009. 06. 24
	sutamtwo
	친구 리스트 읽어가기
*/

AS
SET NOCOUNT ON;
/*
SELECT FRD.FriendUID, NIC.NickName, FRD.GroupID, FRD.[Status]
	FROM dbo.GFriend AS FRD WITH (NOLOCK)
		JOIN dbo.GUnitNickName AS NIC WITH (NOLOCK)
			ON FRD.FriendUID = NIC.UnitUID
	WHERE FRD.UnitUID = @iUnitUID
*/
	
SELECT FRD.FriendUID, NIC.NickName, FRD.GroupID, FRD.[Status]
FROM dbo.GFriend AS FRD WITH (NOLOCK)
	JOIN dbo.GUnit AS UNIT WITH(NOLOCK) ON FRD.FriendUID = UNIT.UnitUID AND UNIT.Deleted = 0
	JOIN dbo.GUnitNickName AS NIC WITH (NOLOCK)
		ON FRD.FriendUID = NIC.UnitUID
WHERE FRD.UnitUID = @iUnitUID
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_friend_get_group_list]
	@iUnitUID	bigint

/*
	2009. 06. 24
	sutamtwo
	친구 그룹 읽어가기
*/

AS
SET NOCOUNT ON;

SELECT GroupID, GroupName
	FROM dbo.GFriendGroup WITH (NOLOCK)
		WHERE UnitUID = @iUnitUID
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_friend_delete]
	@iUnitUID		BIGINT
,	@iFriendUID		BIGINT
,	@iOK			INT	= 0

/*
	2009. 06. 24
	sutamtwo
	친구 삭제 하기
	-1 : 나의 친구 삭제 실패
	-2 : 친구의 나 삭제 실패
*/

AS
SET NOCOUNT ON;


BEGIN TRAN		

	DELETE FROM dbo.GFriend
		WHERE UnitUID = @iUnitUID AND FriendUID = @iFriendUID
	
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN
			SELECT @iOK = -1	GOTO FAIL_TRAN
		END



	DELETE FROM dbo.GFriend
		WHERE UnitUID = @iFriendUID AND FriendUID = @iUnitUID

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN
			SELECT @iOK = -2	GOTO FAIL_TRAN
		END



COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_friend_block_unblock]
	@iUnitUID		BIGINT
,	@iFriendUID		BIGINT
,	@iBeforeStatus	TINYINT	
,	@iAfterStatus	TINYINT
,	@iOK			INT	= 0

/*
	2009. 06. 24
	sutamtwo
	친구 블럭하기, 블럭 해제하기
	-1 : 내 친구가 아니다.
	-2 : 내 이전 상태값이 이상하다
	-3 : 내 트랜잭션 에러
	
*/

AS
SET NOCOUNT ON;

DECLARE	@iMyStatus	TINYINT
SELECT	@iMyStatus = [Status]
	FROM dbo.GFriend WITH (NOLOCK)
		WHERE UnitUID = @iUnitUID AND FriendUID = @iFriendUID
		
		
IF @iMyStatus IS NULL 
BEGIN
	SELECT	@iOK = -1	GOTO END_PROC
END



IF @iMyStatus <> @iBeforeStatus 
BEGIN
	SELECT	@iOK = -2	GOTO END_PROC
END

	
BEGIN TRAN		

	UPDATE dbo.GFriend
		SET [Status] = @iAfterStatus
			WHERE UnitUID = @iUnitUID AND FriendUID = @iFriendUID
	
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN
			SELECT @iOK = -3	GOTO FAIL_TRAN
		END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_friend_accept]
	@iUnitUID		BIGINT
,	@iFriendUID		BIGINT
,	@iMyStatus		TINYINT	
,	@iFriendStatus	TINYINT
,	@iStatus		TINYINT
,	@iOK			INT	= 0

/*
	2009. 06. 24
	sutamtwo
	친구 요청 수락하기
	-1 : 나의 이전 상태값이 이상하다
	-2 : 친구의 이전 상태값이 이상하다
	-3 : 내 트랜잭션 에러
	-4 : 친구 트랜잭션 에러
*/

AS
SET NOCOUNT ON;


DECLARE	@iMyBeforeStatus		TINYINT
,		@iFriendBeforeStatus	TINYINT	


SELECT	@iMyBeforeStatus = [Status]
	FROM dbo.GFriend WITH (NOLOCK)
		WHERE UnitUID = @iUnitUID AND FriendUID = @iFriendUID
		
SELECT	@iFriendBeforeStatus = [Status]
	FROM dbo.GFriend WITH (NOLOCK)
		WHERE UnitUID = @iFriendUID AND FriendUID = @iUnitUID

IF (@iMyStatus <> @iMyBeforeStatus)
	BEGIN
		SELECT @iOK = -1	GOTO END_PROC
	END
		
IF (@iFriendBeforeStatus <> @iFriendBeforeStatus)
	BEGIN
		SELECT @iOK = -2	GOTO END_PROC
	END


	
BEGIN TRAN		

	UPDATE dbo.GFriend
		SET [Status] = @iStatus
			WHERE UnitUID = @iUnitUID AND FriendUID = @iFriendUID
	
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN
			SELECT @iOK = -3	GOTO FAIL_TRAN
		END

	UPDATE dbo.GFriend
		SET [Status] = @iStatus
			WHERE UnitUID = @iFriendUID AND FriendUID = @iUnitUID
	
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN
			SELECT @iOK = -4	GOTO FAIL_TRAN
		END



COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_delete_user]
	@iUserID	[nvarchar] (16)
,	@iOK [int] = 0
AS
SET NOCOUNT ON;


DECLARE @sdtNow		datetime
,       @iItemCount int
,		@iUserUID	bigint
,		@iUnitCount	int


DECLARE @tabUnitUID TABLE
(
	UnitUID	BIGINT
,	NickName	nvarchar(16)
)


SELECT @iUserUID = UserUID 
	FROM dbo.GUser WITH (NOLOCK)
		WHERE UserID = 	@iUserID



-- 유닛이 하나도 없는 경우
IF NOT EXISTS( SELECT * FROM dbo.GUnit WITH( NOLOCK ) WHERE UserUID = @iUserUID AND DELETED = 0 )
BEGIN
	SELECT @iOK = 0    GOTO END_PROC
END



-- 유닛이 있는 경우

INSERT INTO @tabUnitUID (UnitUID)
	SELECT UnitUID FROM dbo.GUnit WITH (NOLOCK) WHERE UserUID = @iUserUID AND DELETED = 0

UPDATE a
	SET a.NickName = b.NickName
		FROM @tabUnitUID AS A
			JOIN dbo.GUnitNickName AS B WITH (NOLOCK)
				ON A.UnitUID = B.UnitUID

SELECT	@iUnitCount = COUNT(*)
	FROM @tabUnitUID

SELECT  @sdtNow = DateAdd( mi, 1, GetDate() )

BEGIN TRAN

--	유닛 정보 지우기
    UPDATE dbo.GUnit WITH(ROWLOCK)
        SET DelDate = @sdtNow
            WHERE UnitUID in (SELECT UnitUID FROM @tabUnitUID)
    IF @@ERROR <> 0 OR @@ROWCOUNT <> @iUnitCount
        BEGIN    SELECT @iOK = -11    GOTO END_PROC    END

--	사제 시스템에서 지우기
	UPDATE dbo.GTutor WITH (ROWLOCK)
		SET DelDate = @sdtNow
			WHERE (TeacherUID  in (SELECT UnitUID FROM @tabUnitUID) OR StudentUID in (SELECT UnitUID FROM @tabUnitUID))
				AND DELETED = 0

    UPDATE dbo.GUnitNickName WITH (ROWLOCK)
        SET NickName = NULL
            WHERE UnitUID in (SELECT UnitUID FROM @tabUnitUID)
    IF @@ERROR <> 0 OR @@ROWCOUNT <> @iUnitCount
        BEGIN    SELECT @iOK = -12    GOTO END_PROC    END


--  닉네임 과거 기록 저장
	INSERT INTO dbo.GDeletedNickNameHistory (NickName,UnitUID, Regdate)
		SELECT NickName, UnitUID, @sdtNow
			FROM @tabUnitUID
    IF @@ERROR <> 0 OR @@ROWCOUNT <> @iUnitCount
        BEGIN    SELECT @iOK = -14    GOTO END_PROC    END

	
	DELETE dbo.GItem
		OUTPUT DELETED.ItemUID, DELETED.UnitUID, DELETED.ItemID, DELETED.InventoryCategory, DELETED.SlotID, DELETED.UsageType, DELETED.Quantity, DELETED.Endurance, DELETED.Inserted, DELETED.RegDate, @sdtNow, 255
		INTO dbo.Gitem_Log ( ItemUID, UnitUID, ItemID, InventoryCategory, SlotID, UsageType, Quantity, Endurance, Inserted, RegDate, DelDate, Deleted )
	WHERE  UnitUID in (SELECT UnitUID FROM @tabUnitUID)
	
	 IF @@ERROR <> 0
        BEGIN    SELECT @iOK = -15    GOTO END_PROC    END
		
		
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_delete_unit]
	@iUserUID	bigint,
	@iUnitUID_	bigint,
	@iOK		int = 0
AS
	SET NOCOUNT ON

	-- 기존 파라미터에서 변수로 변경
	DECLARE @Result		int

	DECLARE @sdtNow SMALLDATETIME
	,		@DelAbleDate SMALLDATETIME
	SET @sdtNow = GETDATE()

	
	--$$ 캐릭터 삭제 대기 추가(Maxpia)
	SELECT @DelAbleDate = DelAbleDate
	FROM dbo.GUnitWaitDelete WITH(NOLOCK)
	WHERE UnitUID = @iUnitUID_
	
	
	-- 해당 유닛이 없는 경우.
	
	IF @@ROWCOUNT = 0									--$$ 캐릭터 삭제 대기 추가(Maxpia)
		SET @Result = -21								--삭제 대기 정보 없음
	ELSE IF @DelAbleDate > @sdtNow
		SET @Result = -22								--삭제 가능일 아님
	ELSE IF NOT EXISTS ( SELECT * FROM dbo.GUnit WITH(NOLOCK) WHERE UnitUID = @iUnitUID_ AND UserUID = @iUserUID AND Deleted = 1 )	--$$ 캐릭터 삭제 대기 추가로 이미 삭제된(삭제 대기) 캐릭터만 삭제 가능 -- 패킷조작 삭제 요청 대비 UserUID 추가[국내 추가 예정으로 미리 추가](Maxpia)
		SET @Result = -23				--삭제 대기 상태 아님
	-- IF NOT EXISTS ( SELECT * FROM dbo.GUnit WITH(NOLOCK) WHERE UnitUID = @UnitUID AND Deleted = 0 )
		-- SET @Result = -1		-- 기존 미삭제 캐릭터 검사 안함(이미 삭제 대기 상태)
	ELSE BEGIN
	/*
	IF NOT EXISTS ( SELECT UnitUID FROM dbo.GUnit WITH(NOLOCK) WHERE UserUID = @iUserUID AND UnitUID = @iUnitUID_ AND Deleted = 0 )
		SET @Result = -1
	ELSE BEGIN
	*/
		BEGIN TRY
			BEGIN TRAN
		
			
			--$$ 캐릭터 삭제 대기 추가(Maxpia)
			--삭제 대기 정보 갱신
			SET @Result = -24
			UPDATE dbo.GUnitWaitDelete
			SET Deleted = 1
			WHERE UnitUID = @iUnitUID_
			
		
			-- 캐릭터 삭제로 변경
			SET @Result = -11
			UPDATE dbo.GUnit
			SET @sdtNow = DelDate = CASE WHEN @sdtNow = RegDate THEN DATEADD(mi, 1, @sdtNow) ELSE @sdtNow END
            WHERE UnitUID = @iUnitUID_ AND Deleted = 0

			-- 사제 시스템에서 지우기 (삭제 프로세스가 있을경우 주석처리)
			SET @Result = -12
			UPDATE dbo.GTutor
			SET DelDate = @sdtNow
			WHERE (TeacherUID = @iUnitUID_ OR StudentUID = @iUnitUID_)
				AND DELETED = 0
		
			-- 닉네임 삭제로 수정
			SET @Result = -13
			UPDATE dbo.GUnitNickName
			SET NickName = NickName + N'_' + SUBSTRING(CONVERT(nvarchar(10), GETDATE(), 112), 3, 6)
				-- NickName = NickName + N'_' + RIGHT(REPLACE(REPLACE(REPLACE(CONVERT(nvarchar(19), GETDATE(), 120), N'-', N''), N':', N''), N' ', N''), 12)
				OUTPUT DELETED.NickName, @iUnitUID_, @sdtNow
				INTO dbo.GDeletedNickNameHistory ( NickName, UnitUID, Regdate )
            WHERE UnitUID = @iUnitUID_
            
		
			-- 아이템 삭제
			 SET @Result = -15
			 DELETE dbo.GItem
				OUTPUT DELETED.ItemUID, DELETED.UnitUID, DELETED.ItemID, DELETED.InventoryCategory, DELETED.SlotID, DELETED.UsageType, DELETED.Quantity, DELETED.Endurance, DELETED.Inserted, DELETED.RegDate, GETDATE(), 32
				INTO dbo.GItem_Log ( ItemUID, UnitUID, ItemID, InventoryCategory, SlotID, UsageType, Quantity, Endurance, Inserted, RegDate, DelDate, Deleted )
			 WHERE UnitUID = @iUnitUID_
		
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
				SET @Result = -11
		END CATCH
	END

	SELECT ISNULL(@Result, 0) AS Result
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_delete_Tutor]
	@TeacherUID	bigint	
,	@StudentUID	bigint	
,	@iOK		int = 0
AS
SET NOCOUNT ON;

IF NOT EXISTS(SELECT * FROM dbo.GTutor WITH (NOLOCK) WHERE StudentUID = @StudentUID AND TeacherUID = @TeacherUID AND Deleted = 0)
	BEGIN	SELECT	@iOK = -1	GOTO FAIL_TRAN	END

DECLARE @sdtNow	smalldatetime
SELECT	@sdtNow	= DATEADD(MI, 1, GETDATE())

BEGIN TRAN
    UPDATE dbo.GTutor WITH (ROWLOCK)
		SET DelDate = @sdtNow
			WHERE (StudentUID = @StudentUID AND TeacherUID = @TeacherUID)
				AND DELETED = 0
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
        BEGIN    SELECT @iOK = -11    GOTO FAIL_TRAN    END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_delete_rank_spacetime_week]
	
	
/*
	2009. 07. 07
	sutamtwo
	주간 랭킹 비우기
*/	
	
AS 
SET NOCOUNT ON;

TRUNCATE TABLE dbo.Rank_SpaceTime_week
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_delete_rank_spacetime_month]
	
	
/*
	2009. 07. 07
	sutamtwo
	월간 랭킹 비우기
*/	
	
AS 
SET NOCOUNT ON;

TRUNCATE TABLE dbo.Rank_SpaceTime_Month
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_delete_rank_spacetime_day]
	
	
/*
	2009. 07. 07
	sutamtwo
	일간 랭킹 비우기
*/	
	
AS 
SET NOCOUNT ON;

TRUNCATE TABLE dbo.Rank_SpaceTime_day
GO
--gup_create_pet
CREATE OR ALTER PROCEDURE [dbo].[gup_create_pet]
	@iUnitUID		BIGINT,
	@iPetID			INT,
	@strPetName		NVARCHAR(16),
	@iEvolutionStep	TINYINT,
	@iSatiety		SMALLINT,
	@iIntimacy		INT,
	@iExtroversion	SMALLINT,
	@iEmotion		SMALLINT,
	@iPeriod		INT,
	@iOK			INT = 0,
	@iPetUID bigint = 0

AS
SET NOCOUNT ON;

DECLARE @sdtNow		SMALLDATETIME
DECLARE @DelDate	SMALLDATETIME
	
SELECT @sdtNow = GETDATE()

IF @iPeriod > 0
	SET @DelDate = DATEADD(dd, @iPeriod, @sdtNow)
ELSE
	SET @DelDate = @sdtNow

BEGIN TRAN

	-- 펫 생성
	INSERT INTO dbo.GPet_Info (UnitUID, PetID, PetName, EvolutionStep, Satiety, Intimacy, Extroversion, Emotion, 
								RegDate, DelDate, IsCall, AutoFeed, LastFeedDate, LastcallDate)
	SELECT @iUnitUID, @iPetID, @strPetName, @iEvolutionStep, @iSatiety, @iIntimacy, @iExtroversion, @iEmotion, @sdtNow, @DelDate, 0, 0, @sdtNow, @sdtNow
	
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
    BEGIN    
        SELECT @iOK = -1    
        GOTO FAIL_TRAN    
    END
    
    SELECT @iPetUID = @@IDENTITY
    
  

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK, @iPetUID, CASE WHEN @sdtNow = @DelDate THEN NULL ELSE @DelDate END DelDate
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_create_guild_member]
	@iUnitUID	BIGINT
,	@iGuildNo	INT
,	@strMessage	NVARCHAR(60)
,	@iOK		INT = 0


AS

SET NOCOUNT ON;
	/*
		2009. 09. 25
		sutamtwo

		길드 멤버 가입시키기
		GUG_MASTER		// 마스터		1
		GUG_SYSOP		// 관리자		2
		GUG_OLD_USER	// 원로 길드원	3
		GUG_VIP_USER	// 우수 길드원	4
		GUG_NORMAL_USER	// 일반 길드원	5
		GUG_NEW_USER	// 신입 길드원	6

	*/


DECLARE @sdtNow		SMALLDATETIME
,		@iMaxNo		TINYINT
,		@iNowNo		TINYINT

SELECT  @sdtNow = GetDate()
		
-- 이미 길드에 가입되어있음
IF EXISTS (SELECT 1 FROM dbo.GGuild_Member WITH (NOLOCK) WHERE UnitUID = @iUnitUID)
    BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END


BEGIN TRAN

	SELECT 	@iMaxNo = Maxno
		FROM dbo.GGuild WITH (NOLOCK)
			WHERE GuildNo = @iGuildNo

	SELECT	@iNowNo = COUNT(1)
		FROM dbo.GGuild_Member WITH (NOLOCK)
			WHERE GuildNo = @iGuildNo
	
	
	
	IF (@iNowNo < @iMaxNo)
		BEGIN
			INSERT INTO dbo.GGuild_Member (UnitUID, GuildNo, [EXP], RegDate, LastDate, [State], [Message])
				SELECT @iUnitUID, @iGuildNo, 0, @sdtNow, @sdtNow, 6, @strMessage
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN
				SELECT @iOK = -2	GOTO FAIL_TRAN
			END
		END		

	ELSE 
		BEGIN
			SELECT @iOK = -3	GOTO FAIL_TRAN
		END
	

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_create_guild_check]
	@iUnitUID		BIGINT
,	@strGuildName	NVARCHAR(30)
,	@iOK			INT = 0


AS

SET NOCOUNT ON;
	/*
		2009. 09. 25
		sutamtwo

		길드 창단과 관련된 SP
		해당 닉네임이 있는가,
		내가 이미 길드 가입 중인가

	*/

DECLARE	@sdtGuildDate SMALLDATETIME

--	이미 길드에 가입 중이다
IF EXISTS (SELECT 1 FROM dbo.GGuild_Member WITH (NOLOCK) WHERE UnitUID = @iUnitUID)
    BEGIN
	    SELECT @iOK = -1
	    GOTO END_PROC
    END


IF EXISTS (SELECT 1 FROM dbo.GGuild WITH (NOLOCK) WHERE GuildName = @strGuildName)
    BEGIN
	    SELECT @iOK = -2
	    GOTO END_PROC
    END
		
		
IF EXISTS( SELECT 1 FROM dbo.GGuild_Deleted with (nolock) WHERE GuildName = @strGuildName )
    BEGIN    
		SELECT TOP 1 @sdtGuildDate = DelDate FROM dbo.GGuild_Deleted WHERE GuildName = @strGuildName ORDER BY DelDate DESC
		IF (DATEADD(DD,-7,GETDATE()) < @sdtGuildDate)
			BEGIN	SELECT @iOK = -3	GOTO END_PROC	END
	END
		
		
END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_create_guild]
	@iUnitUID		BIGINT
,	@strGuildName	NVARCHAR(30)
,	@iMaxNo			TINYINT
,	@strSayHello	NVARCHAR(90)
,	@iLogo			TINYINT	= 0
,	@iOK			INT = 0


AS

SET NOCOUNT ON;
	/*
		2009. 09. 25
		sutamtwo

		길드 창단과 관련된 SP
		State 는 기본이 0
		@strSayHello 는 공백 시 서버에서 '' 로 넘겨줄 것
		길드 생성자가 길드마스터가 되고, 등급은 기본으로 1

	*/

DECLARE @sdtNow		SMALLDATETIME
DECLARE @iGuildNo	INT
SELECT  @sdtNow = GetDate()



BEGIN TRAN


	INSERT INTO dbo.GGuild (GuildName, MaxNo, [Level], [EXP], CreateDate, LastDate, [State], Logo, SayHello)
		SELECT @strGuildName, @iMaxNo, 1, 0, @sdtNow, @sdtNow, 0, @iLogo, @strSayHello	    
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
    BEGIN
	    SELECT @iOK = -1
	    GOTO FAIL_TRAN
    END
	
	SELECT @iGuildNo = @@IDENTITY

    INSERT INTO dbo.GGuild_Member (UnitUID, GuildNo, RegDate, LastDate, [State], [Message])
		SELECT @iUnitUID, @iGuildNo, @sdtNow, @sdtNow, 1, ''
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
    BEGIN
	    SELECT @iOK = -2
	    GOTO FAIL_TRAN
    END
		
		
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK, @iGuildNo, @sdtNow
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_complete_quest]
	@iUnitUID_ [bigint],
	@iQuestID_ [int],
	@bRepeat   [bit],
	@iOK [int] = 0
AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

--퀘스트가 없으면 지우지 않는다.
IF NOT EXISTS(SELECT * FROM dbo.GQuests WITH(NOLOCK) WHERE UnitUID = @iUnitUID_ AND QuestID = @iQuestID_ )
    BEGIN    SELECT @iOK = -1    GOTO END_PROC    END

--삭제 전 퀘스트 시작시간을 받아온다.
DECLARE @sdtBegin	smalldatetime
SELECT  @sdtBegin = RegDate
    FROM dbo.GQuests WITH(NOLOCK) WHERE UnitUID = @iUnitUID_ AND QuestID = @iQuestID_

-- 완료시간을 넣어주기위해
DECLARE @sdtComplete smalldatetime
SELECT  @sdtComplete = GetDate()

BEGIN TRAN
	IF @bRepeat = 1
		BEGIN
			INSERT INTO dbo.GQuests_Repeat(
                          UnitUID
,                         QuestID
,                         RegDate
,                         CompleteDate
                          )
                SELECT  @iUnitUID_
,                       @iQuestID_
,                       @sdtBegin
,                       @sdtComplete
            IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
                BEGIN    SELECT @iOK = -11    GOTO FAIL_TRAN    END
		END
	ELSE
		BEGIN
			INSERT INTO dbo.GQuests_Complete(
                          UnitUID
,                         QuestID
,                         RegDate
,                         CompleteDate
                          )
                SELECT  @iUnitUID_
,                       @iQuestID_
,                       @sdtBegin
,                       @sdtComplete
            IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
                BEGIN    SELECT @iOK = -12    GOTO FAIL_TRAN    END
		END

--QUEST 완료 처리가 끝나면 삭제한다.
    DELETE dbo.GQuests
        WHERE UnitUID = @iUnitUID_ AND QuestID = @iQuestID_
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
        BEGIN    SELECT @iOK = -13    GOTO FAIL_TRAN    END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK, @sdtComplete
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_check_nickname]
	@strNewNickName_	[nvarchar](16)
,	@iOK				[int] = 0
AS
SET NOCOUNT ON;


DECLARE @sdtNow			SMALLDATETIME
,		@sdtNickDate	SMALLDATETIME
SELECT	@sdtNow = GetDate()


-- 동일한 닉네임이 존재하는 경우
IF EXISTS( SELECT * FROM dbo.GUnitNickName WITH(NOLOCK) WHERE NickName = @strNewNickName_ )
BEGIN
    SELECT @iOK = -1
    GOTO END_PROC
END

-- 삭제된 닉네임 중 해당 닉네임이 존재하는 경우
IF EXISTS( SELECT * FROM dbo.GDeletedNickNameHistory with (nolock) WHERE NickName = @strNewNickName_ )
    BEGIN    
		SELECT TOP 1 @sdtNickDate = RegDate FROM dbo.GDeletedNickNameHistory WHERE NickName = @strNewNickName_ ORDER BY RegDate DESC
		IF (DATEADD(DD,-14,@sdtNow) < @sdtNickDate)
			BEGIN	SELECT @iOK = -2	GOTO END_PROC	END
	END


END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_check_insert_post_item]
	@FromUnitUID	bigint	
,	@ToUnitNickName	nvarchar(16)
,	@iOK			int = 0

AS
SET NOCOUNT ON;

DECLARE @sdtNow	smalldatetime
,		@ToUnitUID	bigint
,		@strUserID	nvarchar(25)
,		@iUserUID	bigint

SELECT @ToUnitUID = UnitUID
	FROM dbo.GunitNickName WITH (NOLOCK)
		WHERE NickName = @ToUnitNickName
			OPTION (MAXDOP 1)

SELECT	@iUserUID = UserUID
	FROM dbo.GUnit WITH (NOLOCK)
		WHERE UnitUID = @ToUnitUID

SELECT	@strUserID = UserID 
	FROM dbo.GUser WITH (NOLOCK)
		WHERE UserUID = @iUserUID



-- 자기 자신한테 우편을 보낼려고 하면 종료
IF @FromUnitUID = @ToUnitUID
	BEGIN	SELECT	@iOK = -100	GOTO END_PROC	END

-- 해당 닉네임이 존재하지 않으면 종료
IF @ToUnitUID IS NULL
	BEGIN	SELECT	@iOK = -99	GOTO END_PROC	END

-- 체험 아이디라면
IF RIGHT(@strUserID, 1) = '/'
	BEGIN	SELECT	@iOK = -96	GOTO END_PROC	END

-- 일반 우편이 30개 넘을 때
IF (SELECT COUNT(*) FROM dbo.GPost WITH (NOLOCK) WHERE ToUnitUID = @ToUnitUID AND SCType = 1 AND Deleted = 0) > 29
	BEGIN	SELECT	@iOK = -98	GOTO END_PROC	END

-- 상대방의 블랙 리스트에 내가 등록 되어있다면
IF EXISTS (SELECT * FROM dbo.GPost_BlackList WITH (NOLOCK) WHERE MyUID = @ToUnitUID AND BlockUID = @FromUnitUID)
	BEGIN	SELECT	@iOK = -97	GOTO END_PROC	END
	



END_PROC:
SELECT @iOK
GO
/*
	2009.04.15
	sutamtwo
	닉네임을 __DELETED__ 로 바꾸기
	--> 닉네임_날짜 형태로 변경(ex. 엘소드_120101)
*/

CREATE OR ALTER PROCEDURE [dbo].[gup_change_nickname]
	@iUnitUID		[bigint]
,	@strNickName	[nvarchar](16)
,	@iOK			[int] = 0
AS
SET NOCOUNT ON;

DECLARE	@sdtNow	SMALLDATETIME
SELECT	@sdtNow = GETDATE()

BEGIN TRAN	
	
	-- 닉네임 바꿔주기
	UPDATE dbo.GUnitNickName WITH(ROWLOCK)
        SET NickName = NickName + '_' + substring(convert(nvarchar(10),GetDate(),112), 3, 6)
            WHERE UnitUID = @iUnitUID
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
        BEGIN    SELECT @iOK = -12    GOTO END_PROC    END

	--  닉네임 과거 기록 저장
	INSERT INTO dbo.GDeletedNickNameHistory (NickName,UnitUID, Regdate)
		SELECT @strNickName, @iUnitUID, @sdtNow
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
            BEGIN    SELECT @iOK = -2	GOTO END_PROC    END


COMMIT TRAN


GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_buy_gp_item]
    @iUnitUID       [bigint],
    @iItemID        [int],
    @iPrice         [int],
    @iPvPPoint      [int],
    @iPeriodType    [tinyint],
    @iQuantity      [smallint],
    @iOK            [int] = 0,
    @iItemUID       [bigint] = 0
AS

SET NOCOUNT ON;

-- 해당 유닛이 없는 경우.
IF NOT EXISTS( SELECT * FROM dbo.GUnit WITH( NOLOCK ) WHERE UnitUID = @iUnitUID AND Deleted = 0 )
BEGIN
    SELECT @iOK = -1
    GOTO END_PROC
END

-- 수량성 아이템인데 가지고 있는 경우에는 수량만 더해진다.
--IF @iPeriodType = 2
--BEGIN
	--DECLARE @InternalItemUID TABLE ( UID bigint Primary Key Not NULL )
	--INSERT INTO @InternalItemUID(UID) 
	--	SELECT ItemUID FROM dbo.GItem WITH( NOLOCK ) WHERE UnitUID = @iUnitUID AND ItemID = @iItemID AND Deleted = 0
  --  SELECT @iItemUID = ItemUID FROM dbo.GItem WITH( NOLOCK ) WHERE UnitUID = @iUnitUID AND ItemID = @iItemID AND Deleted = 0

	
--END

DECLARE @sdtNow smalldatetime
SELECT  @sdtNow = GetDate()

BEGIN TRAN


    INSERT INTO dbo.GItem( UnitUID, ItemID, InventoryCategory, UsageType, Quantity, Endurance, SlotID, RegDate )
    SELECT @iUnitUID, @iItemID, 0, 0, 0, 0, 0, @sdtNow
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
    BEGIN
	    SELECT @iOK = -5
	    GOTO FAIL_TRAN
    END
    SELECT @iItemUID = @@IDENTITY

    
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK, @iItemUID
GO
/*	sutamtwo
	OK값

	-1 : 삭제 에러
	-2 : 삭제 기록 작성 에러
*/

CREATE OR ALTER PROCEDURE [dbo].[gup_all_dungeonclear]
	@iUnitUID_		[bigint]

AS
SET NOCOUNT ON;



DECLARE	@sdtNow SMALLDATETIME
SELECT	@sdtNow = GetDate()




		DELETE FROM dbo.GDungeonClear 
			WHERE unituid = @iUnitUID_

		INSERT INTO dbo.GDungeonClear (UnitUID, GameMode, MaxScore,MaxTotalRank,regdate)
			SELECT @iUnitUID_, 10000,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 10001,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 10002,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 10003,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 10004,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 10005,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 10006,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 10007,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 10008,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 10009,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30000,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30010,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30011,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30012,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30020,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30021,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30022,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30030,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30031,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30032,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30033,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30034,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30035,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30040,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30041,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30042,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30050,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30051,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30052,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30060,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30061,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30062,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30070,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30071,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30072,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30080,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30081,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30082,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30090,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30091,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30092,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30100,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30101,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30102,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30110,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30111,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30112,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30120,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30121,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30122,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30130,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30131,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30132,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30140,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30141,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30142,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30150,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30151,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30152,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30160,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30161,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30162,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30170,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30171,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30172,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30180,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30181,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30182,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30190,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30191,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30192,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30200,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30201,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30202,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30210,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30211,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30212,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30220,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30221,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30222,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30230,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30231,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30232,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30240,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30241,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30242,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30250,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30251,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30252,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30260,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30261,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30262,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30270,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30271,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30272,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30280,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30281,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30282,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30290,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30291,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30292,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30300,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30301,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 30302,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32000,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32001,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32002,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32003,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32004,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32005,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32100,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32101,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32102,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32200,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32201,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32202,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32300,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32301,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32302,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32400,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32401,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32402,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32500,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32501,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32502,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32600,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32601,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32602,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32700,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32701,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32702,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32800,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32900,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32901,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32902,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32910,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32920,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32930,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32940,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32950,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32951,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32952,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32960,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32961,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32962,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32970,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32971,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32972,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32980,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32981,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 32982,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33000,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33001,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33002,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33010,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33011,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33012,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33020,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33021,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33030,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33031,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33040,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33041,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33050,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33051,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33060,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33061,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33062,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33070,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33071,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33072,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33080,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33081,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33082,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33090,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33091,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33092,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33100,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33110,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33120,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33121,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33122,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33130,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33131,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33132,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33140,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33141,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33142,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33150,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33151,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33152,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33160,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33161,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33162,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33170,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33171,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33172,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33180,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33181,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33182,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33190,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 33191,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 38000,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 38010,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 38020,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 38100,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 38110,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 38120,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 38130,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 38140,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 38150,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 38300,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 38301,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 38302,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 38310,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 38311,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 38312,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 38320,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 38321,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 38322,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 38330,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 38331,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 38332,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 38340,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 38341,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 38342,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 38350,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 38351,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 38352,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 39000,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 39001,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 39002,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 39100,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 39101,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 39102,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 39103,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 39104,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 39105,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 39106,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 39200,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 39201,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 39202,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 39203,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 39204,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 39205,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 39206,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 39300,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 39301,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 39302,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 39303,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 39304,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 39305,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 39306,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 39400,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 39401,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 39402,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 39403,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 39404,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 39405,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 39406,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 39500,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 39510,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 39520,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 39530,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 39540,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 39550,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 41010,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 41011,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 41020,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 41030,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 41040,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 41050,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 41060,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 41070,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 41080,  0, 0, @sdtNow UNION ALL
			SELECT @iUnitUID_, 41090,  0, 0, @sdtNow
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_admin_update_unit_info]
    @iUnitUID   	[bigint],
    @iExp       	[int],
    @iLevel     	[int],
--  @iGamePoint 	[int],
--	@iVSPoint		[int],
--	@iVSPointMax	[int],
--	@iWin			[int],
--	@iLose			[int],
--	@iSeceder		[int],
    @iOK        	[int] = 0
AS

SET NOCOUNT ON;

-- 해당 유닛이 없는 경우.
IF NOT EXISTS( SELECT * FROM dbo.GUnit WITH( NOLOCK ) WHERE UnitUID = @iUnitUID AND Deleted = 0 )
BEGIN
    SELECT @iOK = -1
    GOTO END_PROC
END

BEGIN TRAN
    UPDATE dbo.GUnit WITH( ROWLOCK )
        SET Exp = @iExp, [Level] = @iLevel--, GamePoint = @iGamePoint, VSPoint = @iVSPoint,
			--VSPointMax = @iVSPointMax,
			--Win = @iWin, Lose = @iLose, Seceder = @iSeceder
        WHERE UnitUID = @iUnitUID
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
    BEGIN
        SELECT @iOK = -2
        GOTO FAIL_TRAN
    END
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_admin_update_unit_gamepoint]
    @iUnitUID   [bigint],
    @iGamePoint [int],
    @iOK        [int] = 0
AS

SET NOCOUNT ON;

-- 해당 유닛이 없는 경우.
IF NOT EXISTS( SELECT * FROM dbo.GUnit WITH( NOLOCK ) WHERE UnitUID = @iUnitUID AND Deleted = 0 )
BEGIN
    SELECT @iOK = -1
    GOTO END_PROC
END

BEGIN TRAN
    UPDATE dbo.GUnit WITH( ROWLOCK )
        SET GamePoint = @iGamePoint
        WHERE UnitUID = @iUnitUID
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
    BEGIN
        SELECT @iOK = -2
        GOTO FAIL_TRAN
    END
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_admin_update_unit_class]
    @iUnitUID   [bigint],
    @iUnitClass [tinyint],
    @iOK        [int] = 0
AS

SET NOCOUNT ON;

-- 해당 유닛이 없는 경우.
IF NOT EXISTS( SELECT * FROM dbo.GUnit WITH( NOLOCK ) WHERE UnitUID = @iUnitUID AND Deleted = 0 )
BEGIN
    SELECT @iOK = -1
    GOTO END_PROC
END

BEGIN TRAN
    UPDATE dbo.GUnit WITH( ROWLOCK )
        SET UnitClass = @iUnitClass
			WHERE UnitUID = @iUnitUID
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -2	GOTO FAIL_TRAN	END

	IF EXISTS (SELECT * FROM [statistics].dbo.UnitStatistics WHERE UnitUID = @iUnitUID)
	BEGIN
	    UPDATE [statistics].dbo.UnitStatistics WITH( ROWLOCK )
	        SET UnitClass = @iUnitClass
				WHERE UnitUID = @iUnitUID

		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -3	GOTO FAIL_TRAN	END

	END



COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_delete_quest]
	@iUnitUID_ [bigint],
	@iQuestID_ [int],
	@iOK [int] = 0
AS
SET NOCOUNT ON;

--퀘스트가 없으면 지우지 않는다.
IF NOT EXISTS(SELECT * FROM dbo.GQuests WITH(NOLOCK) WHERE UnitUID = @iUnitUID_ AND QuestID = @iQuestID_ )
    BEGIN    SELECT @iOK = -1    GOTO END_PROC    END

BEGIN TRAN
    DELETE dbo.GQuests
        WHERE UnitUID = @iUnitUID_ AND QuestID = @iQuestID_
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
        BEGIN    SELECT @iOK = -11    GOTO FAIL_TRAN    END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_delete_post_item_by_PostNo]
	@UnitUID	bigint	
,	@iPostNo	bigint
,	@iOK		int = 0
AS
SET NOCOUNT ON;

DECLARE @sdtNow	smalldatetime
SELECT	@sdtNow	= DATEADD(MI, 1, GETDATE())

	-- 해당 우체국번호가 없으면 에러
	IF NOT EXISTS (SELECT * FROM dbo.GPost WHERE PostNo = @iPostNo)
		BEGIN	SELECT	@iOK = -2	GOTO FAIL_TRAN	END

	-- 이미 삭제된 아이템이면 에러
	IF (1 = (SELECT DELETED FROM  dbo.GPost WHERE PostNo = @iPostNo))
		BEGIN	SELECT	@iOK = -3	GOTO FAIL_TRAN	END
	
	-- 다른 사람의 소포이면
	IF (@UnitUID <> (SELECT ToUnitUID FROM  dbo.GPost WHERE PostNo = @iPostNo))
		BEGIN	SELECT	@iOK = -4	GOTO FAIL_TRAN	END

BEGIN TRAN
	
	UPDATE dbo.GPost
		SET DELDATE = @sdtNow
			WHERE PostNo = @iPostNo
	IF @@ERROR <> 0
		BEGIN	SELECT	@iOK = -1	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_delete_post_item]
	@UnitUID	bigint	
,	@iOK		int = 0
AS
SET NOCOUNT ON;

DECLARE @sdtNow	smalldatetime
SELECT	@sdtNow	= DATEADD(MI, 1, GETDATE())

BEGIN TRAN
	
	UPDATE dbo.GPost
		SET DELDATE = @sdtNow
			WHERE ToUnitUID = @UnitUID
	IF @@ERROR <> 0
		BEGIN	SELECT	@iOK = -1	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
/*	sutamtwo
	2008-09-29
	블랙 리스트에 얻어오기
*/

CREATE OR ALTER PROCEDURE [dbo].[gup_delete_post_blacklist]
(
	@iMyUID		bigint	
,	@iBlockNickName nvarchar(16)
,	@iOK		int = 0
)

AS

SET NOCOUNT ON ;

DECLARE	@iBlockUID	bigint
SELECT	@iBlockUID = unitUID
	FROM dbo.GUnitNickName	WITH (NOLOCK)
		WHERE NickName = @iBlockNickName

IF @iBlockUID IS NULL
	BEGIN
		SELECT @iOK = -1
		GOTO END_PROC
	END

IF NOT EXISTS (SELECT * FROM dbo.GPost_BlackList WITH (NOLOCK) WHERE MyUID = @iMyUID AND BlockUID = @iBlockUID)
	BEGIN
		SELECT @iOK = -2
		GOTO END_PROC
	END

BEGIN TRAN
	DELETE FROM dbo.GPost_BlackList
		WHERE MyUID = @iMyUID AND BlockUID = @iBlockUID

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN
			SELECT @iOK = -3
			GOTO FAIL_TRAN
		END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_delete_one_skill]
	@iUnitUID	bigint 
,	@iSkillID	int
,	@iOK		int = 0
AS
SET NOCOUNT ON;

IF NOT EXISTS (SELECT * FROM dbo.GSkill WITH (NOLOCK) WHERE UnitUID = @iUnitUID AND SkillID = @iSkillID)
	BEGIN	SELECT @iOK = -1	GOTO END_PROC	END

BEGIN TRAN
	-- 소유 스킬 리스트에서 지우기
	DELETE FROM dbo.GSkill
		WHERE UnitUID = @iUnitUID AND SkillID = @iSkillID
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -2	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_delete_item]
    @iItemUID   bigint
,	@iReason	tinyint
,	@iOK		int = 0
AS
	SET NOCOUNT ON
	
	BEGIN TRY
	
		BEGIN TRAN
		
		DELETE dbo.GItem
			OUTPUT DELETED.ItemUID, DELETED.UnitUID, DELETED.ItemID, DELETED.InventoryCategory, DELETED.SlotID, DELETED.UsageType, DELETED.Quantity, DELETED.Endurance, DELETED.Inserted, DELETED.RegDate, GETDATE(), @iReason
			INTO dbo.GItem_Log ( ItemUID, UnitUID, ItemID, InventoryCategory, SlotID, UsageType, Quantity, Endurance, Inserted, RegDate, DelDate, Deleted )
		WHERE ItemUID = @iItemUID
		
		COMMIT TRAN
		
		SET @iOK = 0
	END TRY
	BEGIN CATCH
		IF (XACT_STATE()) <> 0
			ROLLBACK TRAN
		SET @iOK = -2
	END CATCH

	SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_delete_guild_member]
	@iUnitUID	BIGINT
,	@iGuildNo	INT
,	@iOK		INT	= 0

AS

SET NOCOUNT ON;
	/*
		2009. 10. 05
		sutamtwo
		길드원 삭제하기
	*/

IF NOT EXISTS (SELECT 1 FROM dbo.GGuild_Member WITH (NOLOCK) WHERE GuildNo = @iGuildNo AND UnitUID = @iUnitUID)
	BEGIN
		SELECT @iOK	= -1	GOTO END_PROC
	END


BEGIN TRAN	

	DELETE FROM dbo.GGuild_Member
		WHERE UnitUID = @iUnitUID	

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN
			SELECT @iOK = -2	GOTO FAIL_TRAN
		END
	
COMMIT TRAN	

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_delete_guild_bbs_join]
	@iGuildNo		INT
,	@iUnitUID		BIGINT
,	@iOK			INT = 0
AS

/*
	2010. 01. 18
	sutamtwo
	길드 게시판에 조인 요청 삭제
*/

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRAN
	
	DELETE FROM dbo.GGuild_BBS_Join
		WHERE GuildNo = @iGuildNo AND UnitUID = @iUnitUID
 	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN		END
		
COMMIT TRAN
GOTO END_PROC


FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_delete_guild_bbs]
	@iGuildNo		INT
,	@iOK			INT = 0
AS

/*
	2010. 01. 18
	sutamtwo
	길드 게시판에 광고삭제
*/

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRAN
	
	DELETE FROM dbo.GGuild_BBS
		WHERE GuildNo = @iGuildNo
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN		END
		
COMMIT TRAN
GOTO END_PROC


FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_delete_guild_3month]
    @iOK	INT = 0

AS

SET NOCOUNT ON;

DECLARE	@sdtNow	SMALLDATETIME
SELECT	@sdtNow = GETDATE()


DECLARE	@Deleted TABLE 
(
	UnitUID		BIGINT
,	GuildNo		INT
,	GuildName	NVARCHAR(80)
)


INSERT INTO @Deleted (UnitUID, GuildNo, GuildName)
	SELECT b.UnitUID, a.GuildNo, a.GuildName
		FROM dbo.GGuild AS a WITH (NOLOCK)
			JOIN dbo.GGuild_Member AS b WITH (NOLOCK)
		ON a.GuildNo = b.GuildNo
			WHERE a.LastDate <= DATEADD(MM, -3, @sdtNow) AND a.[State] = 0
-- 지울 길드 없음
IF @@ROWCOUNT = 0 
	BEGIN	SELECT @iOK = 1	GOTO END_PROC	END



BEGIN TRAN

	-- 우편 보내기
	INSERT INTO dbo.GPost (FromUnitUID, ToUnitUID, Quantity, ScType, ScIndex, RegDate, DelDate, [Message])
		SELECT UnitUID, UnitUID, 1, 8, 0, @sdtNow, @sdtNow, GuildName
			FROM @Deleted
			
	IF @@ERROR <> 0
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END


	-- 길드원 지우기
	DELETE FROM dbo.GGuild_Member
		WHERE UnitUID IN (SELECT UnitUID FROM @Deleted)

	IF @@ERROR <> 0
		BEGIN	SELECT @iOK = -2	GOTO FAIL_TRAN	END
		

	-- 길드 지우기
	UPDATE dbo.GGuild
		SET [State] = 255
		,	GuildName	= NULL
	WHERE GuildNo IN (SELECT GuildNo FROM @Deleted)
	
	IF @@ERROR <> 0
		BEGIN	SELECT @iOK = -3	GOTO FAIL_TRAN	END
	
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_delete_guild]
	@iUnitUID	BIGINT
,	@iGuildNo	INT
,	@iOK		INT	= 0

AS

SET NOCOUNT ON;
	/*
		2009. 10. 05
		sutamtwo
		길드 삭제하기
	*/


IF NOT EXISTS (SELECT 1 FROM dbo.GGuild_Member WITH (NOLOCK) WHERE GuildNo = @iGuildNo AND UnitUID = @iUnitUID)
	BEGIN
		SELECT @iOK	= -1	GOTO END_PROC
	END

IF 1 > (SELECT COUNT(1) FROM dbo.GGuild_Member WITH (NOLOCK) WHERE GuildNo = @iGuildNo)
	BEGIN
		SELECT @iOK	= -2	GOTO END_PROC
	END
	

DECLARE	@strGuildName	NVARCHAR(60)
SELECT	@strGuildName = GuildName
	FROM dbo.GGuild WITH (NOLOCK)
		WHERE GuildNo = @iGuildNo


BEGIN TRAN	

	DELETE FROM dbo.GGuild_Member
		WHERE UnitUID = @iUnitUID	

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN
			SELECT @iOK = -2	GOTO FAIL_TRAN
		END
	
	UPDATE dbo.GGuild
		SET [State]		= 255
		,	GuildName	= '__Deleted__' + CONVERT(NVARCHAR(8), GuildNo)
			WHERE GuildNo = @iGuildNo
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN
			SELECT @iOK = -3	GOTO FAIL_TRAN
		END
		
	INSERT INTO dbo.GGuild_Deleted (GuildNo, GuildName, DelDate)
		SELECT @iGuildNo, @strGuildName, GETDATE()
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN
			SELECT @iOK = -4	GOTO FAIL_TRAN
		END


	
COMMIT TRAN	

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_delete_GPShop_Item]
    @iItemUID   BIGINT
,	@iReason	TINYINT
,	@iOK		INT = 0
AS

SET NOCOUNT ON;

-- 생성된지 1분 안에 삭제될 경우에 삭제 시각이 생성 시각과 같아지는 것을 방지한다.
DECLARE @sdtNow smalldatetime
SELECT  @sdtNow = DateAdd( mi, 1, GetDate() )

BEGIN TRAN

	UPDATE dbo.GPShopItem
		SET DelDate = @sdtNow
		,	Deleted	= @iReason
	WHERE ItemUID = @iItemUID

    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	    BEGIN	SELECT @iOK = -2	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
/*	sutamtwo
	2008-01-31
	블랙 리스트에 얻어오기
*/

CREATE OR ALTER PROCEDURE [dbo].[gup_delete_blacklist]
(
	@iMyUID		bigint	
,	@iBlockUID	bigint
,	@iOK		int = 0
)

AS

SET NOCOUNT ON ;

IF NOT EXISTS (SELECT * FROM dbo.GBlackList WITH (NOLOCK) WHERE MyUID = @iMyUID AND BlockUID = @iBlockUID)
	BEGIN	SELECT @iOK = -1	GOTO END_PROC	END


BEGIN TRAN

	DELETE FROM dbo.GBlackList
		WHERE MyUID = @iMyUID AND BlockUID = @iBlockUID

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN
			SELECT @iOK = -2
			GOTO FAIL_TRAN
		END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE  [dbo].[gup_delete_all_skill_new] 
	@iUnitUID_		bigint
,	@iSPointMax		int
,	@iCSPoint		int
,	@iBasicSkill	INT
,	@iBasicSkill2	int
,	@iOK			int = 0
AS
SET NOCOUNT ON;


/*
	2009.05.07
	sutamtwo
	스킬 슬롯 초기화
*/


DECLARE @iRowCount int
SELECT	@iRowCount = COUNT(*) 
	FROM dbo.GSkill_New
		WHERE UnitUID = @iUnitUID_

BEGIN TRAN
	-- 습득 스킬 지우기
    DELETE FROM dbo.GSkill_New
        WHERE UnitUID = @iUnitUID_
			AND SKILLID NOT IN (@iBasicSkill, @iBasicSkill2)

    IF @@ERROR <> 0 OR @@ROWCOUNT >= @iRowCount
        BEGIN    SELECT @iOK = -1    GOTO FAIL_TRAN    END

	UPDATE dbo.GSkill_New
		SET [Level] = 1
		,	CSP = 0
			WHERE UnitUID = @iUnitUID_				
				
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 2
        BEGIN    SELECT @iOK = -6    GOTO FAIL_TRAN    END


	-- 스킬 포인트 보상
	UPDATE dbo.GUnit 
		SET SPoint = @iSPointMax
			WHERE UnitUID = @iUnitUID_
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -2	GOTO FAIL_TRAN	END


	-- 캐시 스킬 포인트 보상
	IF ( @iCSPoint > 0)
	BEGIN
		UPDATE dbo.GSkill_Cash
			SET CsPoint = @iCSPoint
				WHERE UnitUID = @iUnitUID_
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN	SELECT @iOK = -3	GOTO FAIL_TRAN	END
	END
	
	-- 스킬 슬롯 초기화
	UPDATE dbo.GSkillSlot_New
		SET Slot01  = 0
		,	Slot02	= 0
		,	Slot03	= 0
		,	Slot04	= 0
	WHERE UnitUID = @iUnitUID_
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -4	GOTO FAIL_TRAN	END


	IF EXISTS (SELECT UnitUID FROM dbo.GSkillSlot2_New WITH (NOLOCK) WHERE UnitUID = @iUnitUID_)
	BEGIN
		UPDATE dbo.GSkillSlot2_New
			SET Slot01  = 0
			,	Slot02	= 0
			,	Slot03	= 0
			,	Slot04	= 0
		WHERE UnitUID = @iUnitUID_
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN	SELECT @iOK = -5	GOTO FAIL_TRAN	END	
	
	END	


COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
/*
	2008.08.05
	SUTAMTWO
	스킬 슬롯 초기화
*/



CREATE OR ALTER PROCEDURE  [dbo].[gup_delete_all_skill] 
	@iUnitUID_	[bigint]
,	@iSPointMax	[int]
,	@iBasicSkill[int]
,	@iOK [int] = 0
AS
SET NOCOUNT ON;

DECLARE @iRowCount int
SELECT	@iRowCount = COUNT(*) 
	FROM dbo.GSkill 
		WHERE UnitUID = @iUnitUID_ 

BEGIN TRAN
	-- 습득 스킬 지우기
    DELETE FROM dbo.GSkill
        WHERE UnitUID = @iUnitUID_
			AND SKILLID NOT IN (@iBasicSkill)

    IF @@ERROR <> 0 OR @@ROWCOUNT > @iRowCount
        BEGIN    SELECT @iOK = -11    GOTO FAIL_TRAN    END

	-- 장착 스킬 지우기
	UPDATE dbo.GSkillSlot WITH( ROWLOCK )
		SET Slot01 = @iBasicSkill, Slot02 = 0, Slot03 = 0
			WHERE UnitUID = @iUnitUID_
	IF @@ERROR <> 0 OR @@ROWCOUNT > 1
		BEGIN	SELECT @iOK = -12	GOTO FAIL_TRAN	END

	
	IF EXISTS (SELECT * FROM dbo.GSkillSlot2 WITH (NOLOCK) WHERE UnitUID = @iUnitUID_)
		BEGIN
			UPDATE dbo.GSkillSlot2 WITH( ROWLOCK )
				SET Slot01 = 0, Slot02 = 0, Slot03 = 0
					WHERE UnitUID = @iUnitUID_
				IF @@ERROR <> 0 OR @@ROWCOUNT > 1
					BEGIN	SELECT @iOK = -14	GOTO FAIL_TRAN	END
		END


	-- 스킬 포인트 보상
	UPDATE dbo.GUnit 
		SET SPoint = @iSPointMax
			WHERE UnitUID = @iUnitUID_
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -13	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE  [dbo].[gup_delete_all_guild_skill] 
	@iGuildNo		INT
,	@iSPointMax		INT
,	@iCSPoint		INT
,	@iOK			INT	= 0
AS
SET NOCOUNT ON;


/*
	2009.11.25
	sutamtwo
	길드 스킬 초기화
*/

IF NOT EXISTS (SELECT 1 FROM dbo.GGuild WITH (NOLOCK) WHERE GuildNo = @iGuildNo)
	BEGIN
		SELECT @iOK = -1	GOTO END_PROC
	END

BEGIN TRAN

	-- 습득 스킬 지우기
    DELETE FROM dbo.GGuild_Skill
        WHERE GuildNo = @iGuildNo

    IF @@ERROR <> 0 
        BEGIN    SELECT @iOK = -2    GOTO FAIL_TRAN    END

	-- 스킬 포인트 보상
	UPDATE dbo.GGuild_SkillPoint
		SET SPoint	= @iSPointMax
		,	CSPoint	= @iCSPoint
			WHERE GuildNo = @iGuildNo
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -3	GOTO FAIL_TRAN	END


COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_del_blacklist_user]
	@iUnitUID_ [bigint],	
	@strNickName_ [nvarchar](16),
	@iOK [int] = 0
AS
SET NOCOUNT ON;

--존재하는 닉네임인지 확인
DECLARE @iBLUnitUID_ bigint

SET @iBLUnitUID_ = (SELECT UnitUID FROM dbo.GUnitNickName WHERE NickName = @strNickName_ )
    IF @iBLUnitUID_ IS NULL
        BEGIN    SELECT @iOK = -10    GOTO END_PROC    END

--삭제할 유저가 블랙리스트에 있는지 체크
IF NOT EXISTS(SELECT * FROM dbo.GFriendList WITH(NOLOCK) WHERE UnitUID1 = @iUnitUID_ AND UnitUID2 = @iBLUnitUID_ AND Type = 4)
    BEGIN    SELECT @iOK = -1    GOTO END_PROC    END

BEGIN TRAN
    DELETE dbo.GFriendList
        WHERE UnitUID1 = @iUnitUID_ AND UnitUID2 = @iBLUnitUID_ AND Type = 4
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
        BEGIN    SELECT @iOK = -11    GOTO FAIL_TRAN    END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_create_unit_set_promotion] 
	@iUnitUID	[bigint]
,	@iOK [int] = 0

AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

/*
	sutamtwo
	2008-03-31
	유닛 생성 시 7일짜리 프로모션 복장 세팅
	날짜 집어넣는 중
*/



DECLARE	@sdtNow SMALLDATETIME
,		@sdtEnd	SMALLDATETIME

SELECT	@sdtNow = GETDATE()
SELECT  @sdtEnd	= DATEADD(DD,7,@sdtNow)


BEGIN TRANSACTION

	INSERT INTO dbo.GItemPeriod (UnitUID, ItemUID, Period, ExpirationDate)
		SELECT UnitUID, ItemUID, 7, @sdtEnd
			FROM dbo.GItem WITH (NOLOCK)
				WHERE Unituid = @iUnitUID AND InventoryCategory = 9 AND SlotID NOT IN (1, 3, 5, 7, 9)
	IF	@@ERROR <> 0 OR @@ROWCOUNT <> 5
		BEGIN
			SELECT @iOK = -1	GOTO FAIL_TRAN
		END


/*
	INSERT INTO dbo.GItemEndurance (UnitUID, ItemUID, Endurance) 
		SELECT UnitUID, ItemUID, 10000
			FROM dbo.GItem WITH (NOLOCK)
				WHERE Unituid = @iUnitUID AND InventoryCategory = 9 AND SlotID IN (1, 3, 5, 7, 9)
	IF	@@ERROR <> 0 OR @@ROWCOUNT <> 5
		BEGIN
			SELECT @iOK = -2	GOTO FAIL_TRAN
		END
*/



COMMIT TRANSACTION

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_create_unit]
	@iUserUID_ [bigint],
	@strNickName_ [nvarchar](16),
	@iUnitClass_ [tinyint],
	@iOK [int] = 0,
	@iUnitUID [bigint] = 0
AS
SET NOCOUNT ON;

DECLARE @bDeleted bit,
        @iUsSize int,
        @sdtNow smalldatetime
,		@iStartSpirit smallint
,		@sdtNickDate smalldatetime
--	신규계정 최초 생성 캐릭터에게 큐브 주기
,		@iPopUp		tinyint
,		@sdtAccountRegDate	smalldatetime	-- 신규 계정의 모든 캐릭터에게 이벤트 아이템 주기 ( 박세훈 )
SELECT @iPopUp = 0

SELECT @sdtAccountRegDate = RegDate FROM [Account].[dbo].[MUser] WITH(NOLOCK) WHERE UserUID = @iUserUID_	-- ( 박세훈 )


SELECT  @sdtNow = GetDate()

SELECT  @iStartSpirit = StartSpirit
	FROM dbo.GResurrectionStoneCnt WITH (NOLOCK)

-- 계정의 삭제여부 및 캐릭터 슬롯 개수 정보 얻기.
SELECT @bDeleted = Deleted, @iUsSize = USSize FROM dbo.GUser WITH(NOLOCK) WHERE UserUID = @iUserUID_

IF @bDeleted = 1    -- 해당 UserUID가 이미 삭제된 경우
    BEGIN    SELECT @iOK = -1    GOTO END_PROC    END

-- 현재 보유한 캐릭터 수가 이미 제한에 걸린 경우
if (select count(*) from dbo.GUnit WITH (NOLOCK) where deleted = 0 and UserUID = @iUserUID_) >= @iUsSize
    BEGIN    SELECT @iOK = -3    GOTO END_PROC    END

-- 일일 최대 생성수에 걸리는 경우
IF ((select count(*) from dbo.GUnit with (nolock) where useruid = @iUserUID_ and regdate between convert(nvarchar(10), @sdtNow, 120)+' 00:00:00' and convert(nvarchar(10), @sdtNow, 120)+' 23:59:00') = 4)
	BEGIN	SELECT @iOK = -23    GOTO END_PROC    END

-- 동일한 닉네임이 존재하는 경우
IF EXISTS(SELECT * FROM dbo.GUnitNickName WITH(NOLOCK) WHERE NickName = @strNickName_)
    BEGIN    SELECT @iOK = -2    GOTO END_PROC    END

-- 삭제된 닉네임 중 해당 닉네임이 존재하는 경우
--	수정 1
IF EXISTS(SELECT * FROM dbo.GDeletedNickNameHistory with (nolock) WHERE NickName = @strNickName_)
    BEGIN    
		SELECT TOP 1 @sdtNickDate = RegDate FROM dbo.GDeletedNickNameHistory WHERE NickName = @strNickName_ ORDER BY RegDate DESC
		IF (DATEADD(DD,-14,@sdtNow) < @sdtNickDate)
			BEGIN	SELECT @iOK = -222  SELECT @sdtNickDate = DATEADD(DD,14,@sdtNickDate) GOTO END_PROC	END
	END

IF @iUnitClass_ not in (1, 2, 3, 4, 5, 6)
	BEGIN
		SELECT @iOK = -10
		GOTO END_PROC
	END
	

BEGIN TRAN

    -- unit 생성.
    INSERT INTO dbo.GUnit( UserUID, UnitClass, [Exp], [Level], GamePoint, BaseHP, AtkPhysic, AtkMagic, DefPhysic, DefMagic, 
							SPoint, Seceder, RegDate, DelDate, LastPosition  ) -- 배틀필드 들어가면 LastPosition 빼야됨
        SELECT  @iUserUID_, @iUnitClass_, 0, 1, 0, 0, 0, 0, 0, 0,
                 0, 0, @sdtNow, @sdtNow, 0
		    
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
    BEGIN    
        SELECT @iOK = -11  
        GOTO FAIL_TRAN    
    END

    SELECT @iUnitUID = @@IDENTITY
    
    -- 마지막 위치값 저장
    INSERT INTO dbo.GUnitLastPosition( UnitUID, MapID, LastLineIndex, LastPosValue )
		SELECT @iUnitUID, 2000, 0, 0
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
    BEGIN    
        SELECT @iOK = -12 
        GOTO FAIL_TRAN
    END
    
    INSERT INTO dbo.GUnitNickName( UnitUID, NickName, RegDate )
        SELECT  @iUnitUID, @strNickName_, @sdtNow
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
    BEGIN    
        SELECT @iOK = -13    
        GOTO FAIL_TRAN
    END


    -- 커뮤니티 옵션 생성
	INSERT INTO dbo.GDenyOption( UnitUID, QuestionNo, CodeNo )
        SELECT  @iUnitUID, 1, 1 UNION ALL
        SELECT  @iUnitUID, 2, 1 UNION ALL
        SELECT  @iUnitUID, 3, 1 UNION ALL
        SELECT  @iUnitUID, 4, 1 UNION ALL
        SELECT  @iUnitUID, 5, 1
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 5
    BEGIN    
        SELECT @iOK = -14
        GOTO FAIL_TRAN
    END

	-- [[기본 스킬 셋팅]]

	-- 로우의 호출 기본 퀘스트 넣기
/*
	INSERT INTO dbo.GQuests (UnitUID, QuestID, SubQuest0, SubQuest1, SubQuest2, SubQuest3, SubQuest4, RegDate)
		SELECT @iUnitUID, 11000, 1,0,0,0,0, @sdtNow
*/

		-- 기본스킬 등록
	INSERT INTO dbo.GSkill_New( UnitUID, SkillID, [Level], CSP)
	SELECT @iUnitUID, SkillID, 1, 0
	FROM GSkill_Default  WITH(NOLOCK)
	WHERE UnitClass= @iUnitClass_
		
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 2
		BEGIN    SELECT @iOK = -16    GOTO FAIL_TRAN    END

	-- 기본 스킬 슬롯 등록
	INSERT INTO dbo.GSkillSlot_New( UnitUID, Slot01, Slot02, Slot03, Slot04 )
	SELECT @iUnitUID, ISNULL([1], 0), ISNULL([2], 0), ISNULL([3], 0), ISNULL([4], 0)
	FROM (
		SELECT ROW_NUMBER() OVER(ORDER BY UnitClass) AS SkillNum, SkillID
		FROM dbo.GSkill_Default WITH(NOLOCK)
		WHERE UnitClass = @iUnitClass_
	) AS BASETABLE
	PIVOT (
		MAX(SkillID) FOR SkillNum IN ( [1], [2], [3], [4] )
	) AS PIVOTTABLE
		
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN    SELECT @iOK = -15    GOTO FAIL_TRAN    END
				
	INSERT INTO dbo.GItem (UnitUID, ItemID, InventoryCategory, SlotID, UsageType, Quantity, Endurance, Inserted, RegDate)
	SELECT @iUnitUID, ItemID, InventoryCategory, SlotID, UsageType, Quantity, Endurance, 125, @sdtNow
	FROM dbo.GBase_Item WITH(NOLOCK)
	WHERE UnitClass = @iUnitClass_

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 10
		BEGIN    SELECT @iOK = -28    GOTO FAIL_TRAN    END
    
    
	----엘소드
	--IF @iUnitClass_ = 1
	--BEGIN
	--	INSERT INTO dbo.GSkill_New( UnitUID, SkillID, [Level], CSP)
	--        SELECT  @iUnitUID, 1000, 1, 0 UNION ALL 
	--        SELECT  @iUnitUID, 1207, 1, 0
	--			IF @@ERROR <> 0 OR @@ROWCOUNT <> 2
	--				BEGIN    SELECT @iOK = -16    GOTO FAIL_TRAN    END

	--	INSERT INTO dbo.GSkillSlot_New( UnitUID, Slot01, Slot02, Slot03, Slot04 )
	--		SELECT  @iUnitUID, 1000, 1207, 0, 0
	--			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	--				BEGIN    SELECT @iOK = -15    GOTO FAIL_TRAN    END
					
	--	INSERT INTO dbo.GItem (UnitUID, ItemID, InventoryCategory, SlotID, UsageType, Quantity, Endurance, Inserted, RegDate)
	--		SELECT @iUnitUID, 128000, 9, 10, 0, 0, -1, 125, @sdtNow union all
	--		SELECT @iUnitUID, 128001, 9,  2, 0, 0, -1, 125, @sdtNow union all
	--		SELECT @iUnitUID, 128002, 9,  4, 0, 0, -1, 125, @sdtNow union all
	--		SELECT @iUnitUID, 128003, 9,  6, 0, 0, -1, 125, @sdtNow union all
	--		SELECT @iUnitUID, 128004, 9,  8, 0, 0, -1, 125, @sdtNow union all
	--		SELECT @iUnitUID, 131641, 9,  9, 1, 0, 10000, 125, @sdtNow union all
	--		SELECT @iUnitUID, 111094, 9,  1, 1, 0, 10000, 125, @sdtNow union all
	--		SELECT @iUnitUID, 111095, 9,  3, 1, 0, 10000, 125, @sdtNow union all
	--		SELECT @iUnitUID, 111096, 9,  5, 1, 0, 10000, 125, @sdtNow union all
	--		SELECT @iUnitUID, 111097, 9,  7, 1, 0, 10000, 125, @sdtNow 

			
	--			IF @@ERROR <> 0 OR @@ROWCOUNT <> 10
	--				BEGIN    SELECT @iOK = -28    GOTO FAIL_TRAN    END
	--END

	----아이샤
	--IF @iUnitClass_ = 2
	--BEGIN
	--	INSERT INTO dbo.GSkill_New( UnitUID, SkillID, [Level], CSP)
	--		SELECT  @iUnitUID, 1500, 1, 0 UNION ALL
	--		SELECT  @iUnitUID, 1707, 1, 0
	--			IF @@ERROR <> 0 OR @@ROWCOUNT <> 2
	--				BEGIN    SELECT @iOK = -18    GOTO FAIL_TRAN    END

	--	INSERT INTO dbo.GSkillSlot_New( UnitUID, Slot01, Slot02, Slot03, Slot04 )
	--		SELECT  @iUnitUID, 1500, 1707, 0, 0
	--			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	--				BEGIN    SELECT @iOK = -17    GOTO FAIL_TRAN    END


	--	INSERT INTO dbo.GItem (UnitUID, ItemID, InventoryCategory, SlotID, UsageType, Quantity, Endurance, Inserted, RegDate)
	--		SELECT @iUnitUID, 128010, 9, 10, 0, 0, -1, 125, @sdtNow union all
	--		SELECT @iUnitUID, 128011, 9,  2, 0, 0, -1, 125, @sdtNow union all
	--		SELECT @iUnitUID, 128012, 9,  4, 0, 0, -1, 125, @sdtNow union all
	--		SELECT @iUnitUID, 128013, 9,  6, 0, 0, -1, 125, @sdtNow union all
	--		SELECT @iUnitUID, 128014, 9,  8, 0, 0, -1, 125, @sdtNow union all
	--		SELECT @iUnitUID, 131642, 9,  9, 1, 0, 10000, 125, @sdtNow union all
	--		SELECT @iUnitUID, 111098, 9,  1, 1, 0, 10000, 125, @sdtNow union all
	--		SELECT @iUnitUID, 111099, 9,  3, 1, 0, 10000, 125, @sdtNow union all
	--		SELECT @iUnitUID, 111100, 9,  5, 1, 0, 10000, 125, @sdtNow union all
	--		SELECT @iUnitUID, 111101, 9,  7, 1, 0, 10000, 125, @sdtNow 
	--			IF @@ERROR <> 0 OR @@ROWCOUNT <> 10
	--				BEGIN    SELECT @iOK = -28    GOTO FAIL_TRAN    END					
	--END

	----레나
	--IF @iUnitClass_ = 3
	--BEGIN
	--	INSERT INTO dbo.GSkill_New( UnitUID, SkillID, [Level], CSP)
	--		SELECT  @iUnitUID, 2000, 1, 0 UNION ALL
	--		SELECT  @iUnitUID, 2207, 1, 0
	--			IF @@ERROR <> 0 OR @@ROWCOUNT <> 2
	--				BEGIN    SELECT @iOK = -20    GOTO FAIL_TRAN    END

	--	INSERT INTO dbo.GSkillSlot_New( UnitUID, Slot01, Slot02, Slot03, Slot04 )
	--		SELECT  @iUnitUID, 2000, 2207, 0, 0
	--			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	--				BEGIN    SELECT @iOK = -19    GOTO FAIL_TRAN    END

	--	INSERT INTO dbo.GItem (UnitUID, ItemID, InventoryCategory, SlotID, UsageType, Quantity, Endurance, Inserted, RegDate)
	--		SELECT @iUnitUID, 128005, 9, 10, 0, 0, -1, 125, @sdtNow union all
	--		SELECT @iUnitUID, 128006, 9,  2, 0, 0, -1, 125, @sdtNow union all
	--		SELECT @iUnitUID, 128007, 9,  4, 0, 0, -1, 125, @sdtNow union all
	--		SELECT @iUnitUID, 128008, 9,  6, 0, 0, -1, 125, @sdtNow union all
	--		SELECT @iUnitUID, 128009, 9,  8, 0, 0, -1, 125, @sdtNow union all
	--		SELECT @iUnitUID, 131643, 9,  9, 1, 0, 10000, 125, @sdtNow union all
	--		SELECT @iUnitUID, 111102, 9,  1, 1, 0, 10000, 125, @sdtNow union all
	--		SELECT @iUnitUID, 111103, 9,  3, 1, 0, 10000, 125, @sdtNow union all
	--		SELECT @iUnitUID, 111104, 9,  5, 1, 0, 10000, 125, @sdtNow union all
	--		SELECT @iUnitUID, 111105, 9,  7, 1, 0, 10000, 125, @sdtNow
	--			IF @@ERROR <> 0 OR @@ROWCOUNT <> 10
	--				BEGIN    SELECT @iOK = -28    GOTO FAIL_TRAN    END
	--END

	----레이븐
	--IF @iUnitClass_ = 4
	--BEGIN
	--	INSERT INTO dbo.GSkill_New( UnitUID, SkillID, [Level], CSP)
	--		SELECT  @iUnitUID, 2500, 1, 0 UNION ALL
	--		SELECT  @iUnitUID, 2706, 1, 0
	--			IF @@ERROR <> 0 OR @@ROWCOUNT <> 2
	--				BEGIN    SELECT @iOK = -25    GOTO FAIL_TRAN    END

	--	INSERT INTO dbo.GSkillSlot_New( UnitUID, Slot01, Slot02, Slot03, Slot04 )
	--		SELECT  @iUnitUID, 2500, 2706, 0, 0
	--			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	--				BEGIN    SELECT @iOK = -24    GOTO FAIL_TRAN    END

	--	INSERT INTO dbo.GItem (UnitUID, ItemID, InventoryCategory, SlotID, UsageType, Quantity, Endurance, Inserted, RegDate)
	--		SELECT @iUnitUID, 128072, 9, 10, 0, 0, -1, 125, @sdtNow union all
	--		SELECT @iUnitUID, 128073, 9,  2, 0, 0, -1, 125, @sdtNow union all
	--		SELECT @iUnitUID, 128074, 9,  4, 0, 0, -1, 125, @sdtNow union all
	--		SELECT @iUnitUID, 128075, 9,  6, 0, 0, -1, 125, @sdtNow union all
	--		SELECT @iUnitUID, 128076, 9,  8, 0, 0, -1, 125, @sdtNow union all
	--		SELECT @iUnitUID, 131644, 9,  9, 1, 0, 10000, 125, @sdtNow union all			
	--		SELECT @iUnitUID, 111106, 9,  1, 1, 0, 10000, 125, @sdtNow union all
	--		SELECT @iUnitUID, 111107, 9,  3, 1, 0, 10000, 125, @sdtNow union all
	--		SELECT @iUnitUID, 111108, 9,  5, 1, 0, 10000, 125, @sdtNow union all
	--		SELECT @iUnitUID, 111109, 9,  7, 1, 0, 10000, 125, @sdtNow
			
	--			IF @@ERROR <> 0 OR @@ROWCOUNT <> 10
	--				BEGIN    SELECT @iOK = -28    GOTO FAIL_TRAN    END	
	--END


	----이브
	--IF @iUnitClass_ = 5
	--BEGIN
	--	INSERT INTO dbo.GSkill_New( UnitUID, SkillID, [Level], CSP)
	--		SELECT  @iUnitUID, 3000, 1, 0 UNION ALL
	--		SELECT  @iUnitUID, 3207, 1, 0
	--			IF @@ERROR <> 0 OR @@ROWCOUNT <> 2
	--				BEGIN    SELECT @iOK = -26    GOTO FAIL_TRAN    END

	--	INSERT INTO dbo.GSkillSlot_New( UnitUID, Slot01, Slot02, Slot03, Slot04 )
	--		SELECT  @iUnitUID, 3000, 3207, 0, 0
	--			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	--				BEGIN    SELECT @iOK = -27    GOTO FAIL_TRAN    END
					
	--	INSERT INTO dbo.GItem (UnitUID, ItemID, InventoryCategory, SlotID, UsageType, Quantity, Endurance, Inserted, RegDate)
	--		SELECT @iUnitUID, 130134, 9, 10, 0, 0, -1, 125, @sdtNow union all
	--		SELECT @iUnitUID, 130135, 9,  2, 0, 0, -1, 125, @sdtNow union all
	--		SELECT @iUnitUID, 130136, 9,  4, 0, 0, -1, 125, @sdtNow union all
	--		SELECT @iUnitUID, 130137, 9,  6, 0, 0, -1, 125, @sdtNow union all
	--		SELECT @iUnitUID, 130138, 9,  8, 0, 0, -1, 125, @sdtNow union all
	--		SELECT @iUnitUID, 131645, 9,  9, 1, 0, 10000, 125, @sdtNow union all
	--		SELECT @iUnitUID, 111110, 9,  1, 1, 0, 10000, 125, @sdtNow union all
	--		SELECT @iUnitUID, 111111, 9,  3, 1, 0, 10000, 125, @sdtNow union all
	--		SELECT @iUnitUID, 111112, 9,  5, 1, 0, 10000, 125, @sdtNow union all
	--		SELECT @iUnitUID, 111113, 9,  7, 1, 0, 10000, 125, @sdtNow

	--			IF @@ERROR <> 0 OR @@ROWCOUNT <> 10
	--				BEGIN    SELECT @iOK = -28    GOTO FAIL_TRAN    END	
	--END


	----청
	--IF @iUnitClass_ = 6
	--BEGIN
	--	INSERT INTO dbo.GSkill_New( UnitUID, SkillID, [Level], CSP)
	--		SELECT  @iUnitUID, 4000, 1, 0 UNION ALL
	--		SELECT  @iUnitUID, 4200, 1, 0
	--			IF @@ERROR <> 0 OR @@ROWCOUNT <> 2
	--				BEGIN    SELECT @iOK = -29    GOTO FAIL_TRAN    END

	--	INSERT INTO dbo.GSkillSlot_New( UnitUID, Slot01, Slot02, Slot03, Slot04 )
	--		SELECT  @iUnitUID, 4000, 4200, 0, 0
	--			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	--				BEGIN    SELECT @iOK = -30    GOTO FAIL_TRAN    END
					
	--	INSERT INTO dbo.GItem (UnitUID, ItemID, InventoryCategory, SlotID, UsageType, Quantity, Endurance, Inserted, RegDate)
	--		SELECT @iUnitUID, 133125, 9, 10, 0, 0, -1, 125, @sdtNow union all
	--		SELECT @iUnitUID, 133126, 9,  2, 0, 0, -1, 125, @sdtNow union all
	--		SELECT @iUnitUID, 133127, 9,  4, 0, 0, -1, 125, @sdtNow union all
	--		SELECT @iUnitUID, 133128, 9,  6, 0, 0, -1, 125, @sdtNow union all
	--		SELECT @iUnitUID, 133129, 9,  8, 0, 0, -1, 125, @sdtNow union all
	--		SELECT @iUnitUID, 111114, 9,  9, 1, 0, 10000, 125, @sdtNow union all
	--		SELECT @iUnitUID, 111115, 9,  1, 1, 0, 10000, 125, @sdtNow union all
	--		SELECT @iUnitUID, 111116, 9,  3, 1, 0, 10000, 125, @sdtNow union all
	--		SELECT @iUnitUID, 111117, 9,  5, 1, 0, 10000, 125, @sdtNow union all
	--		SELECT @iUnitUID, 111118, 9,  7, 1, 0, 10000, 125, @sdtNow 
			
	--		IF @@ERROR <> 0 OR @@ROWCOUNT <> 10
	--				BEGIN    SELECT @iOK = -28    GOTO FAIL_TRAN    END

	--END					
	----아라
	--IF @iUnitClass_ = 7 -- 장비 빠져있고 에러부분 체크해야함
	--BEGIN
	--	-- 기본 스킬 레벨 1 찍어주기
	--	INSERT INTO dbo.GSkill_New( UnitUID, SkillID, [Level], CSP)
	--		SELECT  @iUnitUID, 4500, 1, 0 UNION ALL
	--		SELECT  @iUnitUID, 4702, 1, 0
	--			IF @@ERROR <> 0 OR @@ROWCOUNT <> 2
	--				BEGIN    SELECT @iOK = -31    GOTO FAIL_TRAN    END

	--	-- 기본 스킬을 스킬 슬롯에 장착
	--	INSERT INTO dbo.GSkillSlot_New( UnitUID, Slot01, Slot02, Slot03, Slot04 )
	--		SELECT  @iUnitUID, 4500, 4702, 0, 0
	--			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	--				BEGIN    SELECT @iOK = -32    GOTO FAIL_TRAN    END
	
	--	-- 프로모션 & 초보자용 장비 장착
	--	INSERT INTO dbo.GItem (UnitUID, ItemID, InventoryCategory, SlotID, UsageType, Quantity, Endurance, Inserted, RegDate)
	--		SELECT @iUnitUID, 41460, 9, 10, 0, 0, -1, 125, @sdtNow union all		-- 아라 프로모션 무기
	--		SELECT @iUnitUID, 41470, 9,  2, 0, 0, -1, 125, @sdtNow union all		-- 아라 프로모션 상의
	--		SELECT @iUnitUID, 41480, 9,  4, 0, 0, -1, 125, @sdtNow union all		-- 아라 프로모션 하의
	--		SELECT @iUnitUID, 41490, 9,  6, 0, 0, -1, 125, @sdtNow union all		-- 아라 프로모션 장갑
	--		SELECT @iUnitUID, 41500, 9,  8, 0, 0, -1, 125, @sdtNow union all		-- 아라 프로모션 신발
	--		SELECT @iUnitUID, 112700, 9,  9, 1, 0, 10000, 125, @sdtNow union all -- 초보자용 코보 창
	--		SELECT @iUnitUID, 112701, 9,  1, 1, 0, 10000, 125, @sdtNow union all -- 초보자용 코보 무도가 상의
	--		SELECT @iUnitUID, 112702, 9,  3, 1, 0, 10000, 125, @sdtNow union all -- 초보자용 코보 무도가 바지
	--		SELECT @iUnitUID, 112703, 9,  5, 1, 0, 10000, 125, @sdtNow union all -- 초보자용 코보 무도가 장갑
	--		SELECT @iUnitUID, 112704, 9,  7, 1, 0, 10000, 125, @sdtNow			-- 초보자용 코보 무도가 신발
			
	--		IF @@ERROR <> 0 OR @@ROWCOUNT <> 10
	--				BEGIN    SELECT @iOK = -28    GOTO FAIL_TRAN    END
		
	--END	

	-- 근성도 
	INSERT INTO dbo.GSpirit (UnitUID, Spirit, RegDate)
		SELECT @iUnitUID, @iStartSpirit, @sdtNow
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
					BEGIN    SELECT @iOK = -41    GOTO FAIL_TRAN    END

	---- 대전 기본 정보(시즌 2 시작시 주석처리 필요)
	--INSERT INTO dbo.GUnitPVP(UnitUID, OfficialMatchCnt, Rating, MaxRating, RPoint, APoint, IsWinBeforeMatch, Grade, win, lose)
	--	SELECT @iUnitUID, 0, 250, 250, 0, 0, 0, 0, 0, 0
	--		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	--				BEGIN    SELECT @iOK = -42    GOTO FAIL_TRAN    END	
									
	
	-- 헤니르 보상 제한					
	INSERT INTO dbo.GHenirRewardCnt(UnitUID, NormalCnt, PCBangCnt, EventCnt, LastDate)
		SELECT @iUnitUID, 0, 0, 0, @sdtNow
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
					BEGIN    SELECT @iOK = -43    GOTO FAIL_TRAN    END			
					
	-- LastGamepoint 체크
	INSERT INTO	dbo.GUnit_LastPoint WITH (UPDLOCK) (UnitUID, Gamepoint, RegDate)
		SELECT @iUnitUID, 0, @sdtNow
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1 
			BEGIN    SELECT @iOK = -44   GOTO FAIL_TRAN    END
	
	-- 대전 시즌2 기본 정보				
	INSERT INTO dbo.GUnitPVP_Season2 ( UnitUID, OfficialMatchCnt, Rating, MaxRating, RPoint, APoint, IsWinBeforeMatch, Grade, win, lose, KFactor, IsRedistribution, PastSeasonWin )
		SELECT @iUnitUID, 0, 0, 0, 0, 0, 0, 2, 0, 0, 500, 0, 0	
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1 
			BEGIN    SELECT @iOK = -45   GOTO FAIL_TRAN    END
							
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK, @iUnitUID, ISNULL(@sdtNickDate,'2000-01-01 00:00')
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_create_quest]
	@iUnitUID_ [bigint],
	@iQuestID_ [int],
	@iOK [int] = 0
AS
SET NOCOUNT ON;

--이미 진행중인 퀘스트가 있으면 새로 작성하지 않는다.
IF EXISTS(SELECT * FROM dbo.GQuests WITH(NOLOCK) WHERE UnitUID = @iUnitUID_ AND QuestID = @iQuestID_ )
    BEGIN    SELECT @iOK = -1    GOTO END_PROC    END

DECLARE @sdtNow smalldatetime
SELECT  @sdtNow = GetDate()

BEGIN TRAN
    INSERT INTO dbo.GQuests(
                            UnitUID
,                           QuestID
,                           SubQuest0
,                           SubQuest1
,                           SubQuest2
,                           SubQuest3
,                           SubQuest4
,                           RegDate
                         )
        SELECT  @iUnitUID_
,               @iQuestID_
,               0
,               0
,               0
,               0
,               0
,               @sdtNow
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
        BEGIN    SELECT @iOK = -11    GOTO FAIL_TRAN    END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
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
CREATE OR ALTER PROCEDURE [dbo].[P_UnitClassChange_UnsealedSkill]
	@UnitUID	bigint
,	@iOK		int = 0

AS
	SET NOCOUNT ON

	BEGIN TRAN

		IF EXISTS(SELECT * FROM dbo.GSkill_Unsealed WITH(NOLOCK) WHERE UnitUID = @UnitUID and SkillID = 1012) BEGIN
			IF EXISTS(SELECT * FROM dbo.GSkill_Unsealed WITH(NOLOCK) WHERE UnitUID = @UnitUID and SkillID = 1023) BEGIN			
				DELETE FROM dbo.GSkill_Unsealed
				WHERE UnitUID = @UnitUID and SkillID = 1012
				
				IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
					BEGIN    
						SELECT @iOK = -1
						GOTO FAIL_TRAN
					END
			END
			ELSE
			BEGIN
				UPDATE dbo.GSkill_Unsealed
				SET SkillID = 1023
				WHERE UnitUID = @UnitUID and SkillID = 1012

				IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
					BEGIN    
						SELECT @iOK = -2
						GOTO FAIL_TRAN
					END
			END

		END
		ELSE IF EXISTS(SELECT * FROM dbo.GSkill_Unsealed WITH(NOLOCK) WHERE UnitUID = @UnitUID and SkillID = 1014) BEGIN
			IF EXISTS(SELECT * FROM dbo.GSkill_Unsealed WITH(NOLOCK) WHERE UnitUID = @UnitUID and SkillID = 1024) BEGIN			
				DELETE FROM dbo.GSkill_Unsealed
				WHERE UnitUID = @UnitUID and SkillID = 1014
				
				IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
					BEGIN    
						SELECT @iOK = -3
						GOTO FAIL_TRAN
					END
			END
			ELSE
			BEGIN
				UPDATE dbo.GSkill_Unsealed
				SET SkillID = 1024
				WHERE UnitUID = @UnitUID and SkillID = 1014

				IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
					BEGIN    
						SELECT @iOK = -4
						GOTO FAIL_TRAN
					END
			END

		END
		ELSE IF EXISTS(SELECT * FROM dbo.GSkill_Unsealed WITH(NOLOCK) WHERE UnitUID = @UnitUID and SkillID = 1203) BEGIN
			IF EXISTS(SELECT * FROM dbo.GSkill_Unsealed WITH(NOLOCK) WHERE UnitUID = @UnitUID and SkillID = 1208) BEGIN			
				DELETE FROM dbo.GSkill_Unsealed
				WHERE UnitUID = @UnitUID and SkillID = 1203
				
				IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
					BEGIN    
						SELECT @iOK = -5
						GOTO FAIL_TRAN
					END
			END
			ELSE
			BEGIN
				UPDATE dbo.GSkill_Unsealed
				SET SkillID = 1208
				WHERE UnitUID = @UnitUID and SkillID = 1203

				IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
					BEGIN    
						SELECT @iOK = -6
						GOTO FAIL_TRAN
					END
			END

		END

	COMMIT TRAN


GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[P_Unit_Restore_SET]
	@iUnitUID		BIGINT
,	@sdtNickName	NVARCHAR(30)
,	@iOK			INT = 0

AS

/*
	삭제된 캐릭터 복구하기
	2011-10-12
	yj
*/

SET NOCOUNT ON;

DECLARE @sdtDelDate	SMALLDATETIME
,		@iItemCNT	SMALLINT	
SELECT @sdtDelDate = DelDate
	FROM dbo.GUnit WITH (NOLOCK)
		WHERE UnitUID = @iUnitUID


IF EXISTS (SELECT 1 FROM dbo.GUnitNickName WITH (NOLOCK) WHERE NickName = @sdtNickName)
BEGIN
	SELECT @iOK = -99
	GOTO END_PROC
END



IF NOT EXISTS (SELECT 1 FROM dbo.GDeletedNickNameHistory WITH (NOLOCK) WHERE NickName = @sdtNickName AND UnitUID = @iUnitUID)
BEGIN
	SELECT @iOK = -1
	GOTO END_PROC
END


DELETE dbo.GItem_Log
	OUTPUT DELETED.UnitUID, DELETED.ItemID, DELETED.InventoryCategory, DELETED.SlotID, DELETED.UsageType, DELETED.Quantity, DELETED.Endurance, DELETED.Inserted, DELETED.RegDate
	INTO dbo.GItem ( UnitUID, ItemID, InventoryCategory, SlotID, UsageType, Quantity, Endurance, Inserted, RegDate )
WHERE UnitUID = @iUnitUID AND Deleted = 32 AND DelDate = @sdtDelDate

SELECT @iItemCNT = @@ROWCOUNT

UPDATE dbo.GUnitNickName
	SET NickName = @sdtNickName
		WHERE UnitUID = @iUnitUID
		
UPDATE dbo.GUnit
	SET DelDate = RegDate
		WHERE UnitUID = @iUnitUID
	/*

UPDATE [Statistics].dbo.UnitStatistics
	SET Deleted = 0
		WHERE UnitUID = @iUnitUID
*/

END_PROC:
SELECT @iOK, @iItemCNT
GO
-- =============================================
-- Author:		ryul
-- Create date: 2013-05-10
-- Description:	코보 익스프레스 VIP 정보 등록
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GVIPTicket_SET]
	@iUnitUID	BIGINT
,	@iPeriod	INT
,	@iOk		INT = 0
AS
SET NOCOUNT ON;

DECLARE @sdtNow			SMALLDATETIME
,		@iExpireDate	SMALLDATETIME

SET @sdtNow = GETDATE()
SET @iExpireDate = DATEADD(DAY, @iPeriod, @sdtNow)

BEGIN TRAN

	-- UnitUID 가 유효한지 확인
	IF NOT EXISTS (SELECT * FROM GUnit WITH(NOLOCK) WHERE UnitUID = @iUnitUID)
	BEGIN    SELECT @iOK = -1    GOTO FAIL_TRAN    END
	
	IF EXISTS (SELECT * FROM GVIPTicket WITH(NOLOCK) WHERE UnitUID = @iUnitUID)
	BEGIN
	
		UPDATE	GVIPTicket
		SET		Period = Period + @iPeriod
		--,		RegDate = @sdtNow
		,		@iExpireDate = ExpireDate = DATEADD(DAY, @iPeriod, ExpireDate)
		WHERE	UnitUID = @iUnitUID
	
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN    SELECT @iOK = -12    GOTO FAIL_TRAN    END
	
	END
	ELSE
	BEGIN
	
		INSERT INTO GVIPTicket (UnitUID, Period, RegDate, ExpireDate)
		SELECT @iUnitUID, @iPeriod, @sdtNow, @iExpireDate
		
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN    SELECT @iOK = -11    GOTO FAIL_TRAN    END
		
	END

COMMIT TRAN
GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOk AS iOk, @iExpireDate AS ExpireDate
GO
-- =============================================
-- Author:		ryul
-- Create date: 2013-05-10
-- Description:	코보 익스프레스 VIP 정보 조회
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GVIPTicket_SEL]
	@iUnitUID	BIGINT
AS
SET NOCOUNT ON;

SELECT	ExpireDate, RegDate, Period
FROM	GVIPTicket WITH(NOLOCK)
WHERE	UnitUID = @iUnitUID
GO
-- 캐릭터 삭제 대기 정보 확인
CREATE OR ALTER PROCEDURE [dbo].[P_GUnitWaitDelete_SEL]
	@UnitUID		bigint
AS
	SET NOCOUNT ON
	
	SELECT DelDate, DelAbleDate, RestoreAbleDate, Deleted
	FROM dbo.GUnitWaitDelete WITH(NOLOCK)
	WHERE UnitUID = @UnitUID
GO
-- 삭제 대기
CREATE OR ALTER PROCEDURE [dbo].[P_GUnitWaitDelete_INT]
	@UnitUID	bigint
,	@UserUID	bigint					-- 패킷조작 삭제 요청 대비 UserUID 추가[국내 추가 예정으로 미리 추가](Maxpia)
AS
	SET NOCOUNT ON

	DECLARE @Result			int
	DECLARE @ReDelAbleDate	smalldatetime
	,		@sdtNow			smalldatetime
	
	SET @sdtNow	 = GETDATE()
	
	SELECT TOP 1 @ReDelAbleDate = ReDelAbleDate
	FROM dbo.GUnitRestore WITH(NOLOCK)
	WHERE UnitUID = @UnitUID
	ORDER BY LogUID DESC
	
	IF @ReDelAbleDate > GETDATE()
		SET @Result = -22	-- 삭제 가능 기간 아님
	ELSE IF EXISTS ( SELECT * FROM dbo.GUnitWaitDelete WITH(NOLOCK) WHERE UnitUID = @UnitUID )
		SET @Result = -1	-- 이미 삭제 대기 상태
	ELSE IF NOT EXISTS ( SELECT * FROM dbo.GUnit WITH(NOLOCK) WHERE UnitUID = @UnitUID AND UserUID = @UserUID AND Deleted = 0 )	-- 패킷조작 삭제 요청 대비 UserUID 추가[국내 추가 예정으로 미리 추가](Maxpia)
		SET @Result = -1	-- 이미 삭제 상태
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN

			-- 캐릭터 삭제로 변경
			SET @Result = -11
			UPDATE dbo.GUnit
			SET @sdtNow = DelDate = CASE WHEN @sdtNow = RegDate THEN DATEADD(mi, 1, @sdtNow) ELSE @sdtNow END
				OUTPUT DELETED.UnitUID, INSERTED.DelDate, DATEADD(dd, 3, INSERTED.DelDate), DATEADD(dd, 1, INSERTED.DelDate), 0
				--OUTPUT DELETED.UnitUID, INSERTED.DelDate, DATEADD(mi, 1, INSERTED.DelDate), DATEADD(mi, 1, INSERTED.DelDate), 0
				INTO dbo.GUnitWaitDelete ( UnitUID, DelDate, DelAbleDate, RestoreAbleDate, Deleted )
            WHERE UnitUID = @UnitUID
				AND Deleted = 0
			
			-- 사제 시스템에서 지우기
			SET @Result = -12
			UPDATE dbo.GTutor
			SET DelDate = @sdtNow
			WHERE (TeacherUID = @UnitUID OR StudentUID = @UnitUID)
				AND DELETED = 0

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
				SET @Result = -11
		END CATCH
	END

	SELECT ISNULL(@Result, 0) AS Result, @ReDelAbleDate AS ReDelAbleDate
GO
-- 캐릭터 복구
CREATE OR ALTER PROCEDURE [dbo].[P_GUnitRestore_SET]
	@UnitUID	bigint
,	@UserUID	bigint					-- 패킷조작 삭제 요청 대비 UserUID 추가[국내 추가 예정으로 미리 추가](Maxpia)
AS
	SET NOCOUNT ON
	
	DECLARE @Result		int
	DECLARE @sdtNow 			smalldatetime
	DECLARE @RestoreAbleDate	smalldatetime
	
	SELECT @RestoreAbleDate = RestoreAbleDate, @sdtNow = GETDATE()
	FROM dbo.GUnitWaitDelete WITH(NOLOCK)
	WHERE UnitUID = @UnitUID
		AND Deleted = 0
	
	IF @@ROWCOUNT = 0
		SET @Result = -31	-- 삭제 대기 캐릭터 아님
	ELSE IF @RestoreAbleDate > GETDATE()
		SET @Result = -32	-- 복구 가능기간 아님
	ELSE IF NOT EXISTS ( SELECT * FROM dbo.GUnit WITH(NOLOCK) WHERE UnitUID = @UnitUID AND UserUID = @UserUID AND Deleted = 1 )	-- 패킷조작 삭제 요청 대비 UserUID 추가[국내 추가 예정으로 미리 추가](Maxpia)
		SET @Result = -33	-- 삭제 상태 아님
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN

			-- 캐릭터 정상으로 변경
			SET @Result = -11
			UPDATE dbo.GUnit
			SET DelDate = RegDate
            WHERE UnitUID = @UnitUID
				AND Deleted = 1
			
			SET @Result = -34
			DELETE dbo.GUnitWaitDelete
				OUTPUT DELETED.UnitUID, DELETED.DelDate, @sdtNow, DATEADD(dd, 1, @sdtNow)
				INTO dbo.GUnitRestore ( UnitUID, DelDate, RestoreDate, ReDelAbleDate )
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
				SET @Result = -11
		END CATCH
	END

	SELECT ISNULL(@Result, 0) AS Result, ISNULL(@RestoreAbleDate, '2079-06-05') AS RestoreAbleDate
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GUnitRestore_ReDelAbleDate_CHK]
	@UnitUID		bigint
,	@UserUID		bigint
AS
	SET NOCOUNT ON
	
	DECLARE @Result			int
	
	DECLARE @ReDelAbleDate	smalldatetime
	
	IF NOT EXISTS ( SELECT * FROM dbo.GUnit WITH(NOLOCK) WHERE UnitUID = @UnitUID AND UserUID = @UserUID )
		SET @Result = -1	-- 대상 없음
	ELSE BEGIN	
		SELECT TOP 1 @ReDelAbleDate = ReDelAbleDate
		FROM dbo.GUnitRestore WITH(NOLOCK)
		WHERE UnitUID = @UnitUID
		ORDER BY LogUID DESC

		IF @ReDelAbleDate > GETDATE()
			SET @Result = -22	-- 삭제 가능 기간 아님
		ELSE 
			SET @Result = 0	-- 삭제 가능 기간 아님
	END

	SELECT ISNULL(@Result, 0) AS Result, @ReDelAbleDate AS ReDelAbleDate
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GUnitPVPTag_SEL] 
@iUnitUID BIGINT 

AS 
SET NOCOUNT ON; 

IF EXISTS ( SELECT * FROM dbo.GUnitPVPTag WITH(NOLOCK) WHERE UnitUID = @iUnitUID ) BEGIN 

SELECT Win, Lose, Point 
FROM dbo.GUnitPVPTag WITH (NOLOCK) WHERE UnitUID = @iUnitUID 

END 
ELSE BEGIN 

SELECT 0, 0, 0 

END
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GUnitPVPTag_INS]
	@iUnitUID		bigint
,	@iWin			int
,	@iLose			int
,	@iPoint			int
AS
	SET NOCOUNT ON

	DECLARE @Result			int

	IF NOT EXISTS ( SELECT * FROM dbo.GUnit WITH( NOLOCK ) WHERE UnitUID = @iUnitUID AND Deleted = 0 ) BEGIN
		SET @Result = -1
	END
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN

			IF EXISTS ( SELECT * FROM dbo.GUnitPVPTag WITH( NOLOCK ) WHERE UnitUID = @iUnitUID ) BEGIN
			
				UPDATE dbo.GUnitPVPTag
				SET Win				= Win + @iWin
				,	Lose			= Lose + @iLose
				,	Point			= Point + @iPoint
				,	RegDate			= GETDATE()
				WHERE UnitUID = @iUnitUID
				
			END
			ELSE BEGIN
			
				INSERT INTO dbo.GUnitPVPTag
				        ( UnitUID, Win, Lose, Point )
				VALUES  ( @iUnitUID, -- UnitUID - bigint
				          @iWin, -- Win - int
				          @iLose, -- Lose - int
				          @iPoint -- Point - int
				          )
			
			END

			COMMIT TRAN
			SET @Result = 0
		END TRY
		BEGIN CATCH
			DECLARE @NO_XACT_STATE		smallint
			SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

			IF @NO_XACT_STATE <> 0
				ROLLBACK TRAN

			--EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

			IF @Result = 0 OR @Result IS NULL
				SET @Result = -2
		END CATCH
	END

	SELECT ISNULL(@Result, 0) AS Result
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2012.07.23
-- Description:	대전 시즌2(개편) 데이터 업데이트
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GUnitPVP_Season2_UPT]
	@UnitUID			bigint,
	@OfficialMatchCnt	int,
	@Rating				int,
	@MaxRating			int,
	@RPoint				int,
	@APoint				int,
	@IsWinBeforeMatch	bit,
	@Grade				tinyint,
	@win				int,
	@lose				int,
	@KFactor			int

AS
	SET NOCOUNT ON;

	DECLARE @Result		int
	
	IF NOT EXISTS ( SELECT UnitUID FROM dbo.GUnitPVP_Season2 WITH(NOLOCK) WHERE UnitUID = @UnitUID ) BEGIN
		SET @Result = -1
	END
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN

				SET @Result = -2

				UPDATE dbo.GUnitPVP_Season2
				SET OfficialMatchCnt = OfficialMatchCnt + @OfficialMatchCnt,
					Rating = Rating + @Rating,
					MaxRating = MaxRating + @MaxRating,		
					RPoint = RPoint + @RPoint,
					APoint = APoint	+ @APoint,
					IsWinBeforeMatch = @IsWinBeforeMatch,
					Grade = @Grade,
					win   = win + @win,
					lose  = lose + @lose,
					KFactor = KFactor + @KFactor
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
	END

	SELECT ISNULL(@Result, 0) AS Result
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2012.07.23
-- Description:	대전 시즌2(개편) 데이터 읽기
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GUnitPVP_Season2_GET]
	@UnitUID	BIGINT

AS
	SET NOCOUNT ON;
	
	IF NOT EXISTS ( SELECT UnitUID FROM dbo.GUnitPVP_Season2 WITH(NOLOCK) WHERE UnitUID = @UnitUID ) BEGIN
		
		INSERT INTO dbo.GUnitPVP_Season2 ( UnitUID, OfficialMatchCnt, Rating, MaxRating, RPoint, APoint, IsWinBeforeMatch, Grade, win, lose, KFactor, IsRedistribution, PastSeasonWin )
			SELECT @UnitUID, 0, 0, 0, 0, APoint, 0, 2, 0, 0, 500, 0, win
			FROM dbo.GUnitPVP WITH(NOLOCK)
			WHERE UnitUID = @UnitUID
	
	END
	
	SELECT OfficialMatchCnt, Rating, MaxRating, RPoint, APoint, IsWinBeforeMatch, Grade, win, lose, KFactor, IsRedistribution, PastSeasonWin
		FROM dbo.GUnitPVP_Season2 WITH(NOLOCK)
			WHERE UnitUID = @UnitUID
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GUnitPlayInfo_SEL]
	@iUnitUID 		BIGINT
/*
	게임 플레이 정보
	작성자: Hwang
*/
AS
	SET NOCOUNT ON
	
	DECLARE @iMaxHP			int
		,	@iCurHP			int
		,	@iMaxMP			int
		,	@iCurMP			int
		,	@iCurHyperGage	int
		,	@iCharAbilCNT	int

	SELECT @iMaxHP = MaxHP, @iCurHP = CurHP, @iMaxMP = MaxMP, @iCurMP = CurMP, @iCurHyperGage = CurHyperGage, @iCharAbilCNT = CharAbilCNT
	FROM dbo.GUnitPlayInfo WITH(NOLOCK)
	WHERE UnitUID = @iUnitUID

	IF @@ROWCOUNT = 0 BEGIN -- 첫 접속시(캐릭터를 생성 또는 필드 들어가고 첫 진입)
		SELECT @iMaxHP = -1, @iCurHP = -1, @iMaxMP = -1, @iCurMP = -1, @iCurHyperGage = -1, @iCharAbilCNT = -1
	END

	SELECT @iMaxHP AS MaxHP, @iCurHP AS CurHP, @iMaxMP AS MaxMP, @iCurMP AS CurMP, @iCurHyperGage AS CurHyperGage, @iCharAbilCNT AS CharAbilCNT
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GUnitPlayInfo_INS]
	@iUnitUID		bigint
,	@iMaxHP			int
,	@iCurHP			int
,	@iMaxMP			int
,	@iCurMP			int
,	@iCurHyperGage	int
,	@iCharAbilCNT	int

/*
	게임 플레이 정보 삽입 & 변경
	작성자: Hwang
*/
AS
	SET NOCOUNT ON

	DECLARE @Result		int

	IF NOT EXISTS (SELECT 1 FROM dbo.GUnit WITH(NOLOCK) WHERE UnitUID = @iUnitUID)
		SET @Result = -1
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN

			IF EXISTS ( SELECT * FROM dbo.GUnitPlayInfo WITH(NOLOCK) WHERE UnitUID = @iUnitUID ) BEGIN
				SET @Result = -2

				UPDATE dbo.GUnitPlayInfo
				SET MaxHP = @iMaxHP
				,	CurHP = @iCurHP
				,	MaxMP = @iMaxMP
				,	CurMP = @iCurMP
				,	CurHyperGage = @iCurHyperGage
				,	CharAbilCNT = @iCharAbilCNT
				WHERE UnitUID = @iUnitUID
			END
			ELSE BEGIN
				SET @Result = -3

				INSERT INTO	dbo.GUnitPlayInfo ( UnitUID, MaxHP, CurHP, MaxMP, CurMP, CurHyperGage, CharAbilCNT )
				VALUES ( @iUnitUID, @iMaxHP, @iCurHP, @iMaxMP, @iCurMP, @iCurHyperGage, @iCharAbilCNT )
			END

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
-- Create date: 2013.04.23
-- Description:	닉네임으로 UnitUID 조회
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GUnitNickName_SEL_UnitUID]
	@UnitUID	bigint

AS
	SET NOCOUNT ON;
	
	DECLARE @NickName	nvarchar(20)
	SELECT @NickName = NickName FROM dbo.GUnitNickName WHERE UnitUID = @UnitUID
	
	IF @@ROWCOUNT > 0
		SELECT 0 AS Result, @NickName AS NickName
	ELSE
		SELECT -1 AS Result, @NickName AS NickName
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.03.27
-- Description:	친구찾기 이벤트 관련 OID 리턴용
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GUnitNickName_MUser_OID_GET]
	@NickName	nvarchar(20)
	
AS
	SET NOCOUNT ON;
	
	DECLARE @UserUID		bigint
	DECLARE @PublisherSN	int
	
	-- 캐릭터의 UnitUID 조회
	SELECT @UserUID = B.UserUID 
		FROM dbo.GUnitNickName AS A WITH(NOLOCK)
		JOIN dbo.GUnit AS B WITH(NOLOCK)
			ON A.UnitUID = B.UnitUID
			WHERE A.NickName = @NickName
	
	SELECT @PublisherSN = PublisherSN
		FROM [Account].[dbo].[MUser] WITH(NOLOCK)
			WHERE UserUID = @UserUID
			
	IF @@ROWCOUNT = 1	-- 데이터가 있을 때
		SELECT  ISNULL(@PublisherSN, 0) as 'NexonOID'
	ELSE				-- 데이터가 없을 때
		SELECT	0 as 'NexonOID'
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GUnitLastPosition_UPT]
	@UnitUID		bigint
,	@MapID			int
,	@LastLineIndex	smallint
,	@LastPosValue	smallint
/*
	유닛의 마지막 위치정보 업데이트
*/
AS
	SET NOCOUNT ON

	-- 기존 파라미터에서 변수로 변경
	DECLARE @Result			int

	BEGIN TRY
		BEGIN TRAN
			
			SET @Result = -1
		
			UPDATE dbo.GUnitLastPosition
			SET MapID = @MapID
			,	LastLineIndex = @LastLineIndex
			,	LastPosValue = @LastPosValue
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
			SET @Result = -1
	END CATCH

	SELECT ISNULL(@Result, 0) AS Result
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GUnitLastPosition_GET]
	@UnitUID	bigint
/*
	유닛의 마지막 위치정보 가져가기
*/
AS
	SET NOCOUNT ON

	SELECT MapID, LastLineIndex, LastPosValue
	FROM dbo.GUnitLastPosition WITH(NOLOCK)
	WHERE UnitUID = @UnitUID
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GUnit_Userinfo_GET]
	@iUserUID_ [bigint]
AS
	SET NOCOUNT ON;

	SELECT  a.UnitUID
	,       a.UnitClass
	,       a.[Exp]
	,       a.[Level]
	,       a.GamePoint
	,       ISNULL(D.OfficialMatchCnt, 0) as OfficialMatchCnt
	,       ISNULL(D.Grade, 2) as Grade
	,       a.BaseHP
	,       a.AtkPhysic
	,       a.AtkMagic
	,       a.DefPhysic
	,       a.DefMagic
	,       a.SPoint
	,       CASE WHEN b.NickName LIKE '%[_]%' THEN '__DELETED__' ELSE b.NickName END as NickName
	,       a.LastPosition
	--/*	캐릭터 삭제 시스템이 적용될 경우
	,		A.LastDate
	, 		A.Deleted
	, 		C.DelAbleDate
	, 		C.RestoreAbleDate
	--*/
	FROM dbo.GUnit as a WITH(NOLOCK)
	LEFT OUTER JOIN dbo.GUnitWaitDelete AS C WITH(NOLOCK)
		ON A.UnitUID = C.UnitUID
	LEFT OUTER JOIN dbo.GUnitPVP_Season2 AS D WITH (NOLOCK) 
		ON a.UnitUID = D.UnitUID     -- dbo.GUnitPVP 대신 GUnitPVP_Season2 의 값을 읽어 와야 함
	JOIN dbo.GUnitNickName as b WITH(NOLOCK)
		ON a.UserUID = @iUserUID_ 
		--AND a.Deleted = 0 
		--/* 캐릭터 삭제 시스템이 적용될 경우
		AND (
			A.Deleted = 0	-- 삭제된 유저 정보 읽어갈까봐...
			OR ( A.Deleted = 1 AND ISNULL(C.Deleted, 1) = 0)	-- 캐릭터 삭제 대기 추가로 추가(Maxpia)
		) 
		--*/
		AND a.UnitUID = b.UnitUID
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GUnit_UPT_UnitClassChange]
	@UnitUID		bigint
,	@NewUnitClass	tinyint
AS
	SET NOCOUNT ON
/*
	UnitClass 변경
	(gup_update_unit_class 의 경우 치트사용 전직이나 캐시/퀘스트 전직이다)
*/
	DECLARE @Result		int
	,	@OldUnitClass	tinyint

	SELECT @OldUnitClass = UnitClass FROM dbo.GUnit WITH(NOLOCK) WHERE UnitUID = @UnitUID

	-- 해당 유닛이 없는 경우.
	IF NOT EXISTS ( SELECT * FROM dbo.GUnit WITH(NOLOCK) WHERE UnitUID = @UnitUID AND Deleted = 0 ) BEGIN
		SELECT @Result = -1
	END
    ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN

				UPDATE dbo.GUnit
				SET UnitClass = @NewUnitClass
				WHERE UnitUID = @UnitUID

				INSERT INTO dbo.GUnitClassChangeStage ( UnitUID, OldID, [NewID], SPNo, RegDate )
					VALUES ( @UnitUID, @OldUnitClass, @NewUnitClass, 1, getdate())	

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

	SELECT ISNULL(@Result, 0) AS ResultGO
GO
-- =============================================
-- Author:		HWNAG
-- Create date: 2012.08.10
-- Description:	우편 ED 첨부 전송시 사용
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GUnit_UPT_POST_GP]
	@UnitUID	bigint
,	@GamePoint	int

AS
	SET NOCOUNT ON;

	DECLARE @strErrorMSGED	nvarchar(max)
	DECLARE @sdtNow			smalldatetime
	DECLARE @Result	int	
		
	SET @strErrorMSGED = N'%s [P_GUnit_UPT_POST_GP @UnitUID = %I64d, @GamePoint = %d, @Result = %d]'
	SET @sdtNow = GETDATE()
	
	IF NOT EXISTS ( SELECT UnitUID FROM dbo.GUnit WITH( NOLOCK ) WHERE UnitUID = @UnitUID AND Deleted = 0 )
		SET @Result = -1
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN
			SET @Result = -2
			
				-- ED 마이너스 체크 및 업데이트
				IF @GamePoint <> 0 BEGIN
					UPDATE dbo.GUnit
					SET GamePoint = GamePoint + @GamePoint
						OUTPUT INSERTED.UnitUID, INSERTED.GamePoint - DELETED.GamePoint, @sdtNow
						INTO dbo.GUnit_ED ( UnitUID, GamePoint, RegDate)
					WHERE UnitUID = @UnitUID
						AND GamePoint + @GamePoint >= 0

					IF @@ROWCOUNT <> 1 BEGIN
						SET @Result = -2
						RAISERROR(@strErrorMSGED, 15, 1, N'GUnit GamePoint ', @UnitUID, @GamePoint, @Result) WITH SETERROR
					END
				END
			
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
					SET @Result = -3
		END CATCH
	END
	
	SELECT @Result AS Result
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.06.11
-- Description:	전직 변경, 전직 스킬 획득(치트용)
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GUnit_UPD_UnitClass_Admin]
	@iUnitUID		bigint
,	@iUnitClass		tinyint
,	@iSkillID1		smallint
,	@iSkillID2		smallint
,	@iSkillID3		smallint
,	@iSkillID4		smallint
,	@iSkillID5		smallint
,	@iSkillID6		smallint

AS
	SET NOCOUNT ON;
	
	DECLARE @Result		int

	BEGIN TRY
		BEGIN TRAN

			SET @Result = -10
			-- UnitClass 변경
			UPDATE dbo.GUnit
				SET UnitClass = @iUnitClass
					WHERE UnitUID = @iUnitUID
			
			SET @Result = -11
			-- 모든 스킬 삭제
			DELETE FROM dbo.GSKill_New WHERE UnitUID = @iUnitUID
			
			-- 모든 스킬슬롯 삭제
			SET @Result = -12
			UPDATE dbo.GSkillSlot_New
			SET Slot01 = 0, Slot02 = 0, Slot03 = 0, Slot04 = 0
			WHERE UnitUID = @iUnitUID
			
			IF EXISTS ( SELECT UnitUID FROM dbo.GSkillSlot2_New WITH(NOLOCK) WHERE UnitUID = @iUnitUID ) BEGIN
				UPDATE dbo.GSkillSlot2_New
				SET Slot01 = 0, Slot02 = 0, Slot03 = 0, Slot04 = 0
				WHERE UnitUID = @iUnitUID
			END
			
			-- 전직 스킬 획득
			SET @Result = -13
			IF @iSkillID1 > 0 OR @iSkillID2 > 0 BEGIN
				INSERT INTO dbo.GSKill_New(UnitUID, SkillID, [Level], CSP)
				SELECT @iUnitUID, SkillID, 1, 0
				FROM (
					SELECT @iSkillID1 AS SkillID
					UNION ALL
					SELECT @iSkillID2
					UNION ALL
					SELECT @iSkillID3
					UNION ALL
					SELECT @iSkillID4
					UNION ALL
					SELECT @iSkillID5
					UNION ALL
					SELECT @iSkillID6		
				) AS TempTable
				WHERE SkillID > 0
			END

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
-- Create date: 2013.06.11
-- Description:	전직 변경, 전직 스킬 획득
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GUnit_UPD_UnitClass]
	@iUnitUID		bigint
,	@iUnitClass		tinyint
,	@iSkillID1		smallint
,	@iSkillID2		smallint

AS
	SET NOCOUNT ON;
	
	DECLARE @Result		int

	BEGIN TRY
		BEGIN TRAN

			SET @Result = -10
			-- UnitClass 변경
			UPDATE dbo.GUnit
				SET UnitClass = @iUnitClass
					WHERE UnitUID = @iUnitUID
			
			SET @Result = -11
			-- 전직 스킬 획득
			IF @iSkillID1 > 0 OR @iSkillID2 > 0 BEGIN
				INSERT INTO dbo.GSKill_New(UnitUID, SkillID, [Level], CSP)
				SELECT @iUnitUID, SkillID, 1, 0
				FROM (
					SELECT @iSkillID1 AS SkillID
					UNION ALL
					SELECT @iSkillID2
				) AS TempTable
				WHERE SkillID > 0
			END

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
CREATE OR ALTER PROCEDURE [dbo].[P_GUnit_UPD_GP]
    @iUnitUID   	[bigint]
,   @iGamePoint 	[int]

AS

SET NOCOUNT ON;

DECLARE 
	@sdtNow		smalldatetime,
	@Result		int

SELECT @sdtNow = GetDate()


	-- 해당 유닛이 없는 경우.
	IF NOT EXISTS (SELECT * FROM dbo.GUnit WITH(NOLOCK) WHERE UnitUID = @iUnitUID AND Deleted = 0)
		SET @Result = -1
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN
			
				SET @Result = -2
			    UPDATE dbo.GUnit
				SET GamePoint = GamePoint + @iGamePoint
				WHERE UnitUID = @iUnitUID

				-- ED 증감 저장(DB용)
				INSERT INTO dbo.GUnit_ED (UnitUID, Gamepoint, RegDate)
				VALUES ( @iUnitUID, @iGamePoint, @sdtNow )
				
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
	END
	SELECT ISNULL(@Result, 0) AS Result
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GUnit_MAXLevel_GET]
	@UserUID	BIGINT
AS

SET NOCOUNT ON

DECLARE @MaxLevel TINYINT

SELECT @MaxLevel = MAX([LEVEL])
FROM dbo.GUnit WITH(NOLOCK)
WHERE Deleted = 0
AND UserUID = @UserUID


SELECT ISNULL(@MaxLevel, 0) AS [LEVEL]
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GSkillNew_GET_GM]
	@iUnitUID bigint
	
AS 
SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

SELECT a.Level, b.Name
	FROM dbo.GSkill_New as a, dbo.GSkillCode AS b 
		WHERE a.SkillID = b.Code AND a.UnitUID = @iUnitUID AND a.Deleted = 0
OPTION (MAXDOP 1)
			
SET NOCOUNT OFF
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GSkill_Unsealed_UPT_UnitClassChange]
	@UnitUID		bigint
,	@OldSkillID		smallint
,	@NewSkillID		smallint

AS
	SET NOCOUNT ON
/*
	전직 변경이 되면서 변경될 전직의 캐시 스킬정보(봉인 해제된)를 업데이트 한다
	매칭되는 데이터는 서버가 스크립트에서 가져온다
*/
	
	DECLARE @sdtNow		datetime
	,		@Result		int
		
	SET @sdtNow = GETDATE()
		
	-- 해당유닛이 없는 경우.
	IF NOT EXISTS ( SELECT * FROM dbo.GUnit WITH( NOLOCK ) WHERE UnitUID = @UnitUID AND Deleted = 0 ) BEGIN
			SET @Result = -1
	END
	-- 캐시 스킬이 봉인 해제되지 않은 경우
	ELSE IF NOT EXISTS ( SELECT * FROM dbo.GSkill_Unsealed WITH( NOLOCK ) WHERE UnitUID = @UnitUID AND SkillID = @OldSkillID ) BEGIN
			SET @Result = -2
	END
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN

			UPDATE dbo.GSkill_Unsealed
			SET SkillID = @NewSkillID
			WHERE UnitUID = @UnitUID and SkillID = @OldSkillID

			INSERT INTO dbo.GUnitClassChangeStage ( UnitUID, OldID, [NewID], SPNo, RegDate )
				VALUES ( @UnitUID, @OldSkillID, @NewSkillID, 3, getdate() )

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

	SELECT ISNULL(@Result, 0) AS Result
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GSkill_New_DEL_UnitClassChange]
	@UnitUID		bigint
,	@SPointMax		int
,	@CSPoint		int
,	@BasicSkill		int
,	@BasicSkill2	int

/*
	스킬/스킬 슬롯 초기화
	망각의 드링크 사용과 동일
	(gup_delete_all_skill_new)
*/
AS
	SET NOCOUNT ON

	DECLARE @Result		int

	BEGIN TRY
		BEGIN TRAN

		-- 습득 스킬 지우기
		SET @Result = -1
		DELETE dbo.GSkill_New
        WHERE UnitUID = @UnitUID
			AND SKILLID NOT IN ( @BasicSkill, @BasicSkill2 )

		-- 기본 스킬 레벨 1로 변경
		SET @Result = -6
		UPDATE dbo.GSkill_New
		SET [Level] = 1
		,	CSP = 0
		WHERE UnitUID = @UnitUID

		-- 스킬 포인트 보상
		SET @Result = -2
		UPDATE dbo.GUnit
		SET SPoint = @SPointMax
		WHERE UnitUID = @UnitUID

		-- 캐시 스킬 포인트 보상
		IF ( @CSPoint > 0) BEGIN
			SET @Result = -3
			UPDATE dbo.GSkill_Cash
			SET CsPoint = @CSPoint
			WHERE UnitUID = @UnitUID
		END

		-- 스킬 슬롯 초기화
		SET @Result = -4
		UPDATE dbo.GSkillSlot_New
		SET Slot01  = 0
		,	Slot02	= 0
		,	Slot03	= 0
		,	Slot04	= 0
		WHERE UnitUID = @UnitUID

		IF EXISTS ( SELECT * FROM dbo.GSkillSlot2_New WITH(NOLOCK) WHERE UnitUID = @UnitUID ) BEGIN
			SET @Result = -5
			UPDATE dbo.GSkillSlot2_New
			SET Slot01  = 0
			,	Slot02	= 0
			,	Slot03	= 0
			,	Slot04	= 0
			WHERE UnitUID = @UnitUID
		END

		INSERT INTO dbo.GUnitClassChangeStage ( UnitUID, OldID, [NewID], SPNo, RegDate )
			VALUES ( @UnitUID, 0, 0, 2, getdate())		

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
CREATE OR ALTER PROCEDURE [dbo].[P_GSkill_New_All_DEL_UnitClassChange]
	@UnitUID		bigint
,	@SPointMax		int
,	@CSPoint		int
,	@BasicSkill1	int
,	@BasicSkill2	int
,	@BasicSkill3	int
,	@BasicSkill4	int
,	@BasicSkill5	int
,	@BasicSkill6	int

/*
	스킬/스킬 슬롯 초기화
	전직 변경시 호출
*/
AS
	SET NOCOUNT ON

	DECLARE @Result		int

	BEGIN TRY
		BEGIN TRAN

		-- 습득 스킬 지우기
		SET @Result = -1
		DELETE from dbo.GSkill_New
        WHERE UnitUID = @UnitUID
        
        INSERT INTO dbo.GSkill_New (UnitUID, SkillID, [Level], CSP)
			SELECT @UnitUID, SkillID, 1, 0
			FROM (
					SELECT @BasicSkill1 AS SkillID
					UNION ALL
					SELECT @BasicSkill2
					UNION ALL
					SELECT @BasicSkill3
					UNION ALL
					SELECT @BasicSkill4
					UNION ALL
					SELECT @BasicSkill5
					UNION ALL
					SELECT @BasicSkill6
				) AS TempTable
				WHERE SkillID > 0

		-- 스킬 포인트 보상
		SET @Result = -2
		UPDATE dbo.GUnit
		SET SPoint = @SPointMax
		WHERE UnitUID = @UnitUID

		-- 캐시 스킬 포인트 보상
		IF ( @CSPoint > 0) BEGIN
			SET @Result = -3
			UPDATE dbo.GSkill_Cash
			SET CsPoint = @CSPoint
			WHERE UnitUID = @UnitUID
		END

		-- 스킬 슬롯 초기화
		SET @Result = -4
		UPDATE dbo.GSkillSlot_New
		SET Slot01  = 0
		,	Slot02	= 0
		,	Slot03	= 0
		,	Slot04	= 0
		WHERE UnitUID = @UnitUID

		IF EXISTS ( SELECT * FROM dbo.GSkillSlot2_New WITH(NOLOCK) WHERE UnitUID = @UnitUID ) BEGIN
			SET @Result = -5
			UPDATE dbo.GSkillSlot2_New
			SET Slot01  = 0
			,	Slot02	= 0
			,	Slot03	= 0
			,	Slot04	= 0
			WHERE UnitUID = @UnitUID
		END

		INSERT INTO dbo.GUnitClassChangeStage ( UnitUID, OldID, [NewID], SPNo, RegDate )
			VALUES ( @UnitUID, 0, 0, 2, getdate())		

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
-- Create date: 2013.06.07
-- Description:	스킬 슬롯 초기화
-- =============================================
CREATE OR ALTER PROCEDURE  [dbo].[P_GSkill_New_All_DEL]
	@iUnitUID_		bigint
,	@iSPointMax		int
,	@iCSPoint		int
,	@iBasicSkill1	int
,	@iBasicSkill2	int
,	@iBasicSkill3	int
,	@iBasicSkill4	int
,	@iBasicSkill5	int
,	@iBasicSkill6	int

AS
	SET NOCOUNT ON

	-- 기존 파라미터에서 변수로 변경
	DECLARE @Result		int

	BEGIN TRY
		BEGIN TRAN

		-- 습득 스킬 지우기
		SET @Result = -1
		DELETE dbo.GSkill_New
        WHERE UnitUID = @iUnitUID_
			AND SKILLID NOT IN ( @iBasicSkill1, @iBasicSkill2, @iBasicSkill3, @iBasicSkill4, @iBasicSkill5, @iBasicSkill6 )

		-- 기본 스킬 레벨 1로 변경
		SET @Result = -6
		UPDATE dbo.GSkill_New
		SET [Level] = 1
		,	CSP = 0
		WHERE UnitUID = @iUnitUID_

		-- 스킬 포인트 보상
		SET @Result = -2
		UPDATE dbo.GUnit
		SET SPoint = @iSPointMax
		WHERE UnitUID = @iUnitUID_

		-- 캐시 스킬 포인트 보상
		IF ( @iCSPoint > 0) BEGIN
			SET @Result = -3
			UPDATE dbo.GSkill_Cash
			SET CsPoint = @iCSPoint
			WHERE UnitUID = @iUnitUID_
		END

		-- 스킬 슬롯 초기화
		SET @Result = -4
		UPDATE dbo.GSkillSlot_New
		SET Slot01  = 0
		,	Slot02	= 0
		,	Slot03	= 0
		,	Slot04	= 0
		WHERE UnitUID = @iUnitUID_

		IF EXISTS ( SELECT * FROM dbo.GSkillSlot2_New WITH(NOLOCK) WHERE UnitUID = @iUnitUID_ ) BEGIN
			SET @Result = -5
			UPDATE dbo.GSkillSlot2_New
			SET Slot01  = 0
			,	Slot02	= 0
			,	Slot03	= 0
			,	Slot04	= 0
			WHERE UnitUID = @iUnitUID_
		END

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
CREATE OR ALTER PROCEDURE [dbo].[P_GSkill_Cash_UPD_C]
	@UnitUID	BIGINT
,	@EndDate	SMALLDATETIME
AS

	SET NOCOUNT ON;
/*
	작성자: Hwang
	그노시스 축복 기간 단축
*/

	DECLARE	@Result	INT
		
	IF NOT EXISTS ( SELECT UnitUID FROM dbo.GSkill_Cash WITH(NOLOCK) WHERE UnitUID = @UnitUID )
		SELECT @Result	= -1
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN
			
			SELECT @Result	= -2
			
			UPDATE dbo.GSkill_Cash
				SET EndDate	= @EndDate
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
	END

	SELECT ISNULL(@Result, 0) AS Result
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.04.22
-- Description:	탈 것 정보 수정하기
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GRiding_UPD_Deleted]
	@RidingUID		bigint
,	@UnitUID		bigint

AS
	SET NOCOUNT ON;
	
	DECLARE @Result		int
	DECLARE @Now		smalldatetime
	
	SET @Now = CURRENT_TIMESTAMP
	
	BEGIN TRY
		BEGIN TRAN
				
			UPDATE dbo.GRiding
				SET Deleted = 1
				  , DelDate = @Now
					WHERE UnitUID = @UnitUID AND RidingUID = @RidingUID
	
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
-- Create date: 2013.04.22
-- Description:	탈 것 정보 수정하기
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GRiding_UPD]
	@RidingUID		bigint
,	@UnitUID		bigint
,	@RidingStamina	smallint
,	@LastDate		datetime

AS
	SET NOCOUNT ON;
	
	DECLARE @Result		int
	
	BEGIN TRY
		BEGIN TRAN
				
			UPDATE dbo.GRiding
				SET RidingStamina = @RidingStamina
				  , LastDate	  = @LastDate
					WHERE UnitUID = @UnitUID AND RidingUID = @RidingUID
	
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
-- Create date: 2013.04.22
-- Description:	탈 것 정보 읽어가기
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GRiding_SEL]
	@UnitUID	bigint

AS
	SET NOCOUNT ON;
	
	SELECT RidingUID, RidingID, RidingStamina, DelDate, LastDate 
		FROM dbo.GRiding WITH(NOLOCK)
			WHERE UnitUID = @UnitUID
			AND Deleted = 0
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.04.22
-- Description:	탈 것 정보 입력하기
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GRiding_INT]
	@UnitUID	bigint
,	@RidingID	smallint
,	@Period		int

AS
	SET NOCOUNT ON;
	
	DECLARE @Result		int
	DECLARE @RidingUID	bigint
	DECLARE @RidingCNT	tinyint
	DECLARE @Now		smalldatetime
	DECLARE @DelDate	smalldatetime
	
	SET @Now = CURRENT_TIMESTAMP

	SELECT @RidingCNT = COUNT(RidingUID)
		FROM dbo.GRiding WITH(NOLOCK)
			WHERE UnitUID = @UnitUID AND Deleted = 0

	IF @Period > 0 -- 기간제일 경우에는 만료일 계산
		SET @DelDate = DATEADD( dd, @Period, @Now )
	ELSE -- 만료일이 NULL 이면 서버에서 영구권으로 판단
		SET @DelDate = NULL

	-- 이미 보유한 탈 것이 30마리일 경우(Max: 30마리)
	IF @RidingCNT >= 30
		SET @Result = -2
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN
			
				INSERT INTO dbo.GRiding ( UnitUID, RidingID, RidingStamina, Period, RegDate, DelDate, LastDate, Deleted )
				VALUES ( @UnitUID, @RidingID, 0, @Period, @Now, @DelDate, '1900-01-01 00:00:00', 0 )
				
				SET @RidingUID = SCOPE_IDENTITY()
		
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
	END
		
	SELECT ISNULL(@Result, 0) AS Result, @RidingUID AS RidingUID, @DelDate AS DelDate
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.03.26
-- Description:	추천인 기록
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GRecommend_INS]
	@NewUID		bigint
,	@OldNick	nvarchar(16)

AS
	SET NOCOUNT ON;

	DECLARE @Result				int
	DECLARE @Now				smalldatetime	-- 현재 시각
	DECLARE @OldUID				bigint			-- 추천받는 캐릭터 UID
	DECLARE @OldUserUID			bigint			-- 추천받는 계정 UID
	DECLARE @NewUserUID			bigint			-- 추천하는 계정 UID
	DECLARE @OldUIDCnt			int				-- 추천받는 횟수
	DECLARE @ChannelCode_Old	tinyint			-- 추천받는 계정의 채널코드
	DECLARE @ChannelCode_New	tinyint			-- 추천하는 계정의 채널코드
	
	SELECT	@Now	= GETDATE()
	SELECT	@OldUID = UnitUID FROM dbo.GUnitNickName WITH(NOLOCK) WHERE NickName = @OldNick
	SELECT	@OldUserUID = UserUID FROM dbo.GUnit WITH(NOLOCK) WHERE UnitUID = @OldUID
	SELECT	@NewUserUID = UserUID FROM dbo.GUnit WITH(NOLOCK) WHERE UnitUID = @NewUID
	SELECT	@OldUIDCnt = ISNULL(RecommendCount, 0) FROM dbo.GRecommend_Count WITH(NOLOCK) WHERE UnitUID = @OldUID
	SELECT	@ChannelCode_Old = ChannelCode  FROM [Account].[dbo].[MUser] WITH(NOLOCK) WHERE UserUID = @OldUserUID
	SELECT	@ChannelCode_New = ChannelCode  FROM [Account].[dbo].[MUser] WITH(NOLOCK) WHERE UserUID = @NewUserUID

	-- 추천받는 닉네임이 존재하지 않으면,
	IF ( @OldUID IS NULL ) BEGIN
		SET @Result = -1
	END
	-- 추천하는 유닛과 추천받는 유닛이 동일한 계정인지 검사
	ELSE IF ( @OldUserUID = @NewUserUID ) BEGIN
		SET @Result = -2
	END
	-- 추천받는 유닛이 이미 받은 추천횟수가 12회보다 작은지 검사
	ELSE IF ( @OldUIDCnt >= 12 ) BEGIN
		SET @Result = -3
	END
	-- 투니랜드 계정인지 검사
	ELSE IF ( @ChannelCode_Old <> 0 OR @ChannelCode_New <> 0 ) BEGIN
		SET @Result = -4
	END
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN

				SET @Result = -5
				-- 추천인 유닛 정보 기록
				INSERT INTO dbo.GRecommend (OldUID, NewUID, RegDate)
					VALUES( @OldUID, @NewUID, @Now )
				
				-- 추천 횟수 기록
				IF NOT EXISTS ( SELECT * FROM dbo.GRecommend_Count WITH(NOLOCK) WHERE UnitUID = @OldUID ) BEGIN
				
					SET @Result = -6
					INSERT INTO dbo.GRecommend_Count (UnitUID, RecommendCount)
						VALUES( @OldUID, 1 )
				
				END
				ELSE BEGIN
				
					SET @Result = -7
					UPDATE dbo.GRecommend_Count
					SET RecommendCount = RecommendCount + 1
					WHERE UnitUID = @OldUID
				
				END

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
				SET @Result = -5
		END CATCH
	END

	SELECT ISNULL(@Result, 0) AS Result, @OldUID as OldUID
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GQuests_UPT_UnitClassChange]
	@UnitUID		bigint
,	@OldQuestID		int
,	@NewQuestID		int

AS
	SET NOCOUNT ON
/*
	전직 변경이 되면서 진행 중이던 전직/스킬/메모 퀘스트를 변경될 전직에 맞게 퀘스트ID를 변경한다
	매칭되는 데이터는 서버가 스크립트에서 가져온다
*/
	
	DECLARE	@Result		int
		
	-- 해당유닛이 없는 경우.
	IF NOT EXISTS ( SELECT * FROM dbo.GUnit WITH( NOLOCK ) WHERE UnitUID = @UnitUID AND Deleted = 0 ) BEGIN
			SET @Result = -1
	END
	-- 퀘스트가 진행중이지 않은 경우
	ELSE IF NOT EXISTS ( SELECT * FROM dbo.GQuests WITH( NOLOCK ) WHERE UnitUID = @UnitUID AND QuestID = @OldQuestID ) BEGIN
			SET @Result = -2
	END
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN

			UPDATE dbo.GQuests
			SET QuestID = @NewQuestID, SubQuest0 = 0, SubQuest1 = 0, SubQuest2 = 0, SubQuest3 = 0, SubQuest4 = 0
			WHERE UnitUID = @UnitUID and QuestID = @OldQuestID

			INSERT INTO dbo.GUnitClassChangeStage ( UnitUID, OldID, [NewID], SPNo, RegDate )
				VALUES ( @UnitUID, @OldQuestID, @NewQuestID, 9, getdate() )

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

	SELECT ISNULL(@Result, 0) AS Result
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GQuests_DEL_UnitClassChange]
	@UnitUID		bigint
,	@OldQuestID		int
AS
	SET NOCOUNT ON
/*
	전직 변경 시에 진행중인 퀘스트를 지워야 할 때 호출된다
*/
	DECLARE	@Result		int
		
	-- 해당유닛이 없는 경우.
	IF NOT EXISTS ( SELECT * FROM dbo.GUnit WITH( NOLOCK ) WHERE UnitUID = @UnitUID AND Deleted = 0 ) BEGIN
			SET @Result = -1
	END
	-- 퀘스트가 진행중이지 않은 경우
	ELSE IF NOT EXISTS ( SELECT * FROM dbo.GQuests WITH( NOLOCK ) WHERE UnitUID = @UnitUID AND QuestID = @OldQuestID ) BEGIN
			SET @Result = -2
	END
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN

			DELETE dbo.GQuests
			WHERE UnitUID = @UnitUID and QuestID = @OldQuestID

			INSERT INTO dbo.GUnitClassChangeStage ( UnitUID, OldID, [NewID], SPNo, RegDate )
				VALUES ( @UnitUID, @OldQuestID, 0, 7, getdate() )

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

	SELECT ISNULL(@Result, 0) AS Result
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GQuests_Complete_UPT_UnitClassChange]
	@UnitUID		bigint
,	@OldQuestID		int
,	@NewQuestID		int

AS
	SET NOCOUNT ON
/*
	전직 변경이 되면서 완료한 전직/스킬/메모 퀘스트를 변경되는 전직에 맞춰서 UPDATE 시켜준다
	매칭되는 데이터는 서버가 스크립트에서 가져온다
*/
	
	DECLARE	@Result		int
		
	-- 해당유닛이 없는 경우.
	IF NOT EXISTS ( SELECT * FROM dbo.GUnit WITH( NOLOCK ) WHERE UnitUID = @UnitUID AND Deleted = 0 ) BEGIN
			SET @Result = -1
	END
	-- 퀘스트가 완료되지 않은 경우
	ELSE IF NOT EXISTS ( SELECT * FROM dbo.GQuests_Complete WITH( NOLOCK ) WHERE UnitUID = @UnitUID AND QuestID = @OldQuestID ) BEGIN
			SET @Result = -2
	END
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN

			UPDATE dbo.GQuests_Complete
			SET QuestID = @NewQuestID
			WHERE UnitUID = @UnitUID and QuestID = @OldQuestID

			INSERT INTO dbo.GUnitClassChangeStage ( UnitUID, OldID, [NewID], SPNo, RegDate )
				VALUES ( @UnitUID, @OldQuestID, @NewQuestID, 8, getdate() )

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

	SELECT ISNULL(@Result, 0) AS Result
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GQuests_Complete_DEL_UnitClassChange]
	@UnitUID		bigint
,	@OldQuestID		int
AS
	SET NOCOUNT ON
/*
	시스나이트 2차 나오기전 예외처리
	로드나이트/룬슬레이어 가 시스나이트로 전직 변경을 했을 때, 로드나이트/룬슬레이어 전직 퀘스트 완료 기록을 지워준다
	(로드나이트/룬슬레이어 -> 시스나이트 -> 소드나이트/매직나이트 -> 로드나이트/룬슬레이어 형식으로 전직을 하는 경우 대비)
*/
	DECLARE	@Result		int
		
	-- 해당유닛이 없는 경우.
	IF NOT EXISTS ( SELECT * FROM dbo.GUnit WITH( NOLOCK ) WHERE UnitUID = @UnitUID AND Deleted = 0 ) BEGIN
			SET @Result = -1
	END
	-- 퀘스트가 완료되지 않은 경우
	ELSE IF NOT EXISTS ( SELECT * FROM dbo.GQuests_Complete WITH( NOLOCK ) WHERE UnitUID = @UnitUID AND QuestID = @OldQuestID ) BEGIN
			SET @Result = -2
	END
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN

			DELETE dbo.GQuests_Complete
			WHERE UnitUID = @UnitUID and QuestID = @OldQuestID

			INSERT INTO dbo.GUnitClassChangeStage ( UnitUID, OldID, [NewID], SPNo, RegDate )
				VALUES ( @UnitUID, @OldQuestID, 0, 6, getdate() )

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

	SELECT ISNULL(@Result, 0) AS Result
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GQueryHistory_INS]
	@GMID	nvarchar(20)
,   @Query	nvarchar(1000)
,	@Result	int
AS
SET NOCOUNT ON;

BEGIN TRY
	BEGIN TRAN	
		
		INSERT INTO dbo.GMQueryHistory(GMID, Query, Result)
		SELECT @GMID, @Query, @Result
		
	COMMIT TRAN
END TRY

BEGIN CATCH
	DECLARE @NO_XACT_STATE		smallint
	SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

	IF @NO_XACT_STATE <> 0
		ROLLBACK TRAN
END CATCH
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GPShopItem_SEL]
	@iUnitUID	BIGINT
	
AS
SET NOCOUNT ON;

SELECT  ItemUID
,		ItemID
,		UsageType
,		Quantity
,		Endurance
,		SealCnt
,		ELevel
,		Attribute1
,		Attribute2
,		Attribute3
,		Socket1
,		Socket2
,		Socket3
,		Socket4
,		SocketR1		-- 랜덤소켓
,		SocketR2		-- 랜덤소켓
,		SocketR3		-- 랜덤소켓
,		SocketR4		-- 랜덤소켓
,		SocketR5		-- 랜덤소켓
,		PricePerOne
,		FeePerOne
,		TotalSellEDIn
,		TotalSoldItemQuantity
,		TotalSellCommissionED
,		Category
FROM dbo.GPShopItem WITH(NOLOCK)
WHERE UnitUID = @iUnitUID and deleted = 0
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.05.22
-- Description:	대리상점 물품회수
--				(랜덤소켓 부분 추가)
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GPShopItem_INT_DEL_C_New]
	@UnitUID_S		bigint		-- 판매자
,	@UnitUID_R		bigint		-- 구매자
,	@Quantity		int			-- 구매 개수
,	@ItemUID_P		bigint		-- 판매자 아이템 UID
,	@InsertType		tinyint
,	@ItemUID		bigint = 0 OUTPUT
AS
	SET NOCOUNT ON
	
	DECLARE @Result			int
	
	DECLARE @sdtNow			smalldatetime
		,	@sdtEndDate		smalldatetime
		,	@ItemID			int
		,	@UsageType		tinyint
		,	@Quantity_P_Old	int
		,	@Attribute1		tinyint
		,	@Attribute2		tinyint
		,	@Attribute3		tinyint
		,	@ELevel			smallint
		,	@SealCnt		tinyint
		,	@Socket1		int
		,	@Socket2		int
		,	@Socket3		int
		,	@Socket4		int
		,	@SocketR1		int
		,	@SocketR2		int
		,	@SocketR3		int
		,	@SocketR4		int
		,	@SocketR5		int
		,	@Deleted		tinyint
		
	SET @sdtNow = CURRENT_TIMESTAMP
	
	SELECT	@ItemID = ItemID, @UsageType = UsageType, @Quantity_P_Old = Quantity, @ELevel = ELevel, @SealCnt = SealCnt,
			@Socket1 = Socket1, @Socket2 = Socket2, @Socket3 = Socket3, @Socket4 = Socket4,
			@SocketR1 = SocketR1, @SocketR2 = SocketR2, @SocketR3 = SocketR3, @SocketR4 = SocketR4, @SocketR5 = SocketR5, 
			@Attribute1 = Attribute1, @Attribute2 = Attribute2, @Attribute3 = Attribute3, @Deleted = Deleted
		FROM dbo.GPShopItem WITH(NOLOCK)
			WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_P
	
		
	-- 해당아이템이 없는 경우.
	IF @@ROWCOUNT = 0
		SET @Result = -1
	ELSE IF @Quantity_P_Old - @Quantity < 0
		SET @Result = -2
	ELSE IF @Deleted = 1
		SET @Result = -3
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN
			
				-- 아이템 등록
				SET @Result = -11
				IF ( @Quantity > 0 ) BEGIN

					-- 구매시 인벤토리로 아이템 넣기
					INSERT INTO dbo.GItem ( UnitUID, ItemID, InventoryCategory, UsageType, Quantity, Endurance, SlotID, RegDate, Inserted )
					SELECT @UnitUID_R, @ItemID, 0, @UsageType
						, CASE WHEN @UsageType = 2 THEN @Quantity ELSE 0 END
						, CASE WHEN @UsageType = 1 THEN 10000 ELSE -1 END
						, 0
						, @sdtNow
						, @InsertType

					SET @ItemUID = @@IDENTITY
					
					-- 강화 레벨 옮기기
					IF  @ELevel > 0   BEGIN
						SET @Result = -12
						
						INSERT INTO dbo.GItemEnchant ( UnitUID, ItemUID, Elevel )
						VALUES( @UnitUID_R, @ItemUID, @ELevel )

					END

					-- 속성 옮기기
					IF ( @Attribute1 > 0 OR @Attribute2 > 0 OR @Attribute3 > 0 ) BEGIN
						SET @Result = -13
						
						INSERT INTO dbo.GItemAttribute (UnitUID, ItemUID, SlotNo, Attribute)
						SELECT @UnitUID_R, @ItemUID, SlotNo, Attribute
						FROM (
							SELECT 0 AS SlotNo, @Attribute1 AS Attribute
							UNION ALL
							SELECT 1 AS SlotNo, @Attribute2 AS Attribute
							UNION ALL
							SELECT 2 AS SlotNo, @Attribute3 AS Attribute
						) AS TempTable
						WHERE Attribute > 0 
					END
					
					-- 소켓 옮기기
					IF ( @Socket1 > 0 OR @Socket2 > 0 OR @Socket3 > 0 OR @Socket4 > 0 ) BEGIN
						SET @Result = -14
						
						INSERT INTO dbo.GItemSocket ( UnitUID, ItemUID, Socket1, Socket2, Socket3, Socket4 )
						VALUES ( @UnitUID_R, @ItemUID, @Socket1, @Socket2, @Socket3, @Socket4 )

					END
					
					-- 랜덤 소켓 옮기기
					IF ( @SocketR1 > 0 OR @SocketR2 > 0 OR @SocketR3 > 0 OR @SocketR4 > 0 OR @SocketR5 > 0 ) BEGIN
						SET @Result = -14
						
						INSERT INTO dbo.GItemSocket_Random ( UnitUID, ItemUID, Socket1, Socket2, Socket3, Socket4, Socket5 )
						VALUES ( @UnitUID_R, @ItemUID, @SocketR1, @SocketR2, @SocketR3, @SocketR4, @SocketR5 )

					END
			
					-- 봉인횟수 옮기기(회수)
					IF ( @SealCnt <> 0 ) BEGIN
						SET @Result = -15
						
						INSERT INTO dbo.GItemSeal ( ItemUID, SealCnt )
						VALUES ( @ItemUID, @SealCnt )

					END
					
				END
				
				-- 대리상점에 남은 아이템 삭제처리
				SET @Result = -17
					
				UPDATE dbo.GPShopItem
					SET DelDate = @sdtNow
					,	Deleted = 1
				WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_P
				
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
	END

	RETURN @Result
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GPShopItem_INT_DEL_C]
	@UnitUID_S		bigint ,	-- 판매자
	@UnitUID_R		bigint ,	-- 구매자
	@Quantity		int,		-- 구매 개수
	@ItemUID_P		bigint ,	-- 판매자 아이템 UID
	@InsertType		tinyint,
	@ItemUID		bigint = 0 OUTPUT
AS
	SET NOCOUNT ON
	
	DECLARE @Result			int
	
	DECLARE @sdtNow			smalldatetime
		,	@sdtEndDate		smalldatetime
		,	@ItemID			int
		,	@UsageType		tinyint
		,	@Quantity_P_Old	int
		,	@Attribute1		tinyint
		,	@Attribute2		tinyint
		,	@Attribute3		tinyint
		,	@ELevel			smallint
		,	@SealCnt		tinyint
		,	@Socket1		int
		,	@Socket2		int
		,	@Socket3		int
		,	@Socket4		int
		,	@Deleted		tinyint
		
	SET @sdtNow = CURRENT_TIMESTAMP
	
	SELECT	@ItemID = ItemID, @UsageType = UsageType, @Quantity_P_Old = Quantity, @ELevel = ELevel, @SealCnt = SealCnt,
			@Socket1 = Socket1, @Socket2 = Socket2, @Socket3 = Socket3, @Socket4 = Socket4,
			@Attribute1 = Attribute1, @Attribute2 = Attribute2, @Attribute3 = Attribute3, @Deleted = Deleted
		FROM dbo.GPShopItem WITH(NOLOCK)
			WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_P
	
		
	-- 해당아이템이 없는 경우.
	IF @@ROWCOUNT = 0
		SET @Result = -1
	ELSE IF @Quantity_P_Old - @Quantity < 0
		SET @Result = -2
	ELSE IF @Deleted = 1
		SET @Result = -3
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN
			
				-- 아이템 등록
				SET @Result = -11
				IF ( @Quantity > 0 ) BEGIN

					-- 구매시 인벤토리로 아이템 넣기
					INSERT INTO dbo.GItem ( UnitUID, ItemID, InventoryCategory, UsageType, Quantity, Endurance, SlotID, Inserted, RegDate )
					SELECT @UnitUID_R, @ItemID, 0, @UsageType
						, CASE WHEN @UsageType = 2 THEN @Quantity ELSE 0 END
						, CASE WHEN @UsageType = 1 THEN 10000 ELSE -1 END
						, 0
						, @InsertType
						, @sdtNow

					SET @ItemUID = @@IDENTITY
					
					-- 강화 레벨 옮기기
					IF  @ELevel > 0   BEGIN
						SET @Result = -12
						
						INSERT INTO dbo.GItemEnchant ( UnitUID, ItemUID, Elevel )
						VALUES( @UnitUID_R, @ItemUID, @ELevel )

					END

					-- 속성 옮기기
					IF ( @Attribute1 > 0 OR @Attribute2 > 0 OR @Attribute3 > 0 ) BEGIN
						SET @Result = -13
						
						INSERT INTO dbo.GItemAttribute (UnitUID, ItemUID, SlotNo, Attribute)
						SELECT @UnitUID_R, @ItemUID, SlotNo, Attribute
						FROM (
							SELECT 0 AS SlotNo, @Attribute1 AS Attribute
							UNION ALL
							SELECT 1 AS SlotNo, @Attribute2 AS Attribute
							UNION ALL
							SELECT 2 AS SlotNo, @Attribute3 AS Attribute
						) AS TempTable
						WHERE Attribute > 0 
					END
					
					-- 소켓 옮기기
					IF ( @Socket1 > 0 OR @Socket2 > 0 OR @Socket3 > 0 OR @Socket4 > 0 ) BEGIN
						SET @Result = -14
						
						INSERT INTO dbo.GItemSocket ( UnitUID, ItemUID, Socket1, Socket2, Socket3, Socket4 )
						VALUES ( @UnitUID_R, @ItemUID, @Socket1, @Socket2, @Socket3, @Socket4 )

					END
			
					-- 봉인횟수 옮기기(회수)
					IF ( @SealCnt <> 0 ) BEGIN
						SET @Result = -15
						
						INSERT INTO dbo.GItemSeal ( ItemUID, SealCnt )
						VALUES ( @ItemUID, @SealCnt )

					END
					
				END
				
				-- 대리상점에 남은 아이템 삭제처리
				SET @Result = -17
					
				UPDATE dbo.GPShopItem
					SET DelDate = @sdtNow
					,	Deleted = 1
				WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_P
				
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
	END

	RETURN @Result
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.05.22
-- Description:	대리상점 물품판매
--				(랜덤소켓 부분 추가)
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GPShopItem_INT_DEL_B_New]
	@UnitUID_S		bigint			-- 판매자
,	@UnitUID_R		bigint			-- 구매자
,	@Quantity		int				-- 구매 개수
,	@ItemUID_P		bigint 			-- 판매자 아이템 UID
,	@InsertType		tinyint			-- 아이템 생성 사유
,	@ItemUID		bigint = 0 OUTPUT
AS
	SET NOCOUNT ON
	
	DECLARE @Result			int
	
	DECLARE @sdtNow			smalldatetime
		,	@sdtEndDate		smalldatetime
		,	@ItemID			int
		,	@UsageType		tinyint
		,	@Quantity_P_Old	int
		,	@Attribute1		tinyint
		,	@Attribute2		tinyint
		,	@Attribute3		tinyint
		,	@ELevel			smallint
		,	@SealCnt		tinyint
		,	@Socket1		int
		,	@Socket2		int
		,	@Socket3		int
		,	@Socket4		int
		,	@SocketR1		int
		,	@SocketR2		int
		,	@SocketR3		int
		,	@SocketR4		int
		,	@SocketR5		int
		,	@Deleted		tinyint
		
	SET @sdtNow = CURRENT_TIMESTAMP
	
	SELECT	@ItemID = ItemID, @UsageType = UsageType, @Quantity_P_Old = Quantity, @ELevel = ELevel, @SealCnt = SealCnt,
			@Socket1 = Socket1, @Socket2 = Socket2, @Socket3 = Socket3, @Socket4 = Socket4,
			@SocketR1 = SocketR1, @SocketR2 = SocketR2, @SocketR3 = SocketR3, @SocketR4 = SocketR4, @SocketR5 = SocketR5, 
			@Attribute1 = Attribute1, @Attribute2 = Attribute2, @Attribute3 = Attribute3, @Deleted = Deleted
		FROM dbo.GPShopItem WITH(NOLOCK)
			WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_P
	
		
	-- 해당아이템이 없는 경우.
	IF @@ROWCOUNT = 0
		SET @Result = -1
	ELSE IF @UsageType = 2 AND @Quantity_P_Old - @Quantity < 0
		SET @Result = -2
	ELSE IF @Deleted = 1
		SET @Result = -3
	ELSE IF @Quantity_P_Old = 0
		SET @Result = -4
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN
			
				-- 아이템 등록
				SET @Result = -11

				-- 구매시 인벤토리로 아이템 넣기
				INSERT INTO dbo.GItem ( UnitUID, ItemID, InventoryCategory, UsageType, Quantity, Endurance, SlotID, RegDate, Inserted )
				SELECT @UnitUID_R, @ItemID, 0, @UsageType
					, CASE WHEN @UsageType = 2 THEN @Quantity ELSE 0 END
					, CASE WHEN @UsageType = 1 THEN 10000 ELSE -1 END
					, 0
					, @sdtNow
					, @InsertType

				SET @ItemUID = @@IDENTITY
				
				-- 강화 레벨 옮기기
				IF  @ELevel > 0   BEGIN
					SET @Result = -12
					
					INSERT INTO dbo.GItemEnchant ( UnitUID, ItemUID, Elevel )
					VALUES( @UnitUID_R, @ItemUID, @ELevel )

				END

				-- 속성 옮기기
				IF ( @Attribute1 > 0 OR @Attribute2 > 0 OR @Attribute3 > 0 ) BEGIN
					SET @Result = -13
					
					INSERT INTO dbo.GItemAttribute (UnitUID, ItemUID, SlotNo, Attribute)
					SELECT @UnitUID_R, @ItemUID, SlotNo, Attribute
					FROM (
						SELECT 0 AS SlotNo, @Attribute1 AS Attribute
						UNION ALL
						SELECT 1 AS SlotNo, @Attribute2 AS Attribute
						UNION ALL
						SELECT 2 AS SlotNo, @Attribute3 AS Attribute
					) AS TempTable
					WHERE Attribute > 0 
				END
				
				-- 소켓 옮기기
				IF ( @Socket1 > 0 OR @Socket2 > 0 OR @Socket3 > 0 OR @Socket4 > 0 ) BEGIN
					SET @Result = -14
					
					INSERT INTO dbo.GItemSocket ( UnitUID, ItemUID, Socket1, Socket2, Socket3, Socket4 )
					VALUES ( @UnitUID_R, @ItemUID, @Socket1, @Socket2, @Socket3, @Socket4 )

				END
				
				-- 랜덤 소켓 옮기기(추가)
				IF ( @SocketR1 > 0 OR @SocketR2 > 0 OR @SocketR3 > 0 OR @SocketR4 > 0 OR @SocketR5 > 0 ) BEGIN
					SET @Result = -14
					
					INSERT INTO dbo.GItemSocket_Random ( UnitUID, ItemUID, Socket1, Socket2, Socket3, Socket4, Socket5 )
					VALUES ( @UnitUID_R, @ItemUID, @SocketR1, @SocketR2, @SocketR3, @SocketR4, @SocketR5 )

				END

				-- 봉인횟수 옮기기
				IF ( @SealCnt <> 0 ) BEGIN
					SET @Result = -15
					
					INSERT INTO dbo.GItemSeal ( ItemUID, SealCnt )
					VALUES ( @ItemUID, @SealCnt - 100 )

				END
		
				--> 여기서 부터 인벤토리 아이템 삭제처리
				-- 판매 아이템이 남아있는 경우
				SET @Result = -16
					
				UPDATE dbo.GPShopItem
					SET Quantity = Quantity - @Quantity
					,	TotalSellEDIn = TotalSellEDIn + ( PricePerOne * @Quantity )
				WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_P					
				
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
	END

	RETURN @Result
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GPShopItem_INT_DEL_B]
	@UnitUID_S		bigint ,	-- 판매자
	@UnitUID_R		bigint ,	-- 구매자
	@Quantity		int,		-- 구매 개수
	@ItemUID_P		bigint ,	-- 판매자 아이템 UID
	@InsertType		tinyint,
	@ItemUID		bigint = 0 OUTPUT
AS
	SET NOCOUNT ON
	
	DECLARE @Result			int
	
	DECLARE @sdtNow			smalldatetime
		,	@sdtEndDate		smalldatetime
		,	@ItemID			int
		,	@UsageType		tinyint
		,	@Quantity_P_Old	int
		,	@Attribute1		tinyint
		,	@Attribute2		tinyint
		,	@Attribute3		tinyint
		,	@ELevel			smallint
		,	@SealCnt		tinyint
		,	@Socket1		int
		,	@Socket2		int
		,	@Socket3		int
		,	@Socket4		int
		,	@Deleted		tinyint
		
	SET @sdtNow = CURRENT_TIMESTAMP
	
	SELECT	@ItemID = ItemID, @UsageType = UsageType, @Quantity_P_Old = Quantity, @ELevel = ELevel, @SealCnt = SealCnt,
			@Socket1 = Socket1, @Socket2 = Socket2, @Socket3 = Socket3, @Socket4 = Socket4,
			@Attribute1 = Attribute1, @Attribute2 = Attribute2, @Attribute3 = Attribute3, @Deleted = Deleted
		FROM dbo.GPShopItem WITH(NOLOCK)
			WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_P
	
		
	-- 해당아이템이 없는 경우.
	IF @@ROWCOUNT = 0
		SET @Result = -1
	ELSE IF @UsageType = 2 AND @Quantity_P_Old - @Quantity < 0
		SET @Result = -2
	ELSE IF @Deleted = 1
		SET @Result = -3
	ELSE IF @Quantity_P_Old = 0
		SET @Result = -4
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN
			
				-- 아이템 등록
				SET @Result = -11

				-- 구매시 인벤토리로 아이템 넣기
				INSERT INTO dbo.GItem ( UnitUID, ItemID, InventoryCategory, UsageType, Quantity, Endurance, SlotID, Inserted, RegDate )
				SELECT @UnitUID_R, @ItemID, 0, @UsageType
					, CASE WHEN @UsageType = 2 THEN @Quantity ELSE 0 END
					, CASE WHEN @UsageType = 1 THEN 10000 ELSE -1 END
					, 0
					, @InsertType
					, @sdtNow

				SET @ItemUID = @@IDENTITY
				
				-- 강화 레벨 옮기기
				IF  @ELevel > 0   BEGIN
					SET @Result = -12
					
					INSERT INTO dbo.GItemEnchant ( UnitUID, ItemUID, Elevel )
					VALUES( @UnitUID_R, @ItemUID, @ELevel )

				END

				-- 속성 옮기기
				IF ( @Attribute1 > 0 OR @Attribute2 > 0 OR @Attribute3 > 0 ) BEGIN
					SET @Result = -13
					
					INSERT INTO dbo.GItemAttribute (UnitUID, ItemUID, SlotNo, Attribute)
					SELECT @UnitUID_R, @ItemUID, SlotNo, Attribute
					FROM (
						SELECT 0 AS SlotNo, @Attribute1 AS Attribute
						UNION ALL
						SELECT 1 AS SlotNo, @Attribute2 AS Attribute
						UNION ALL
						SELECT 2 AS SlotNo, @Attribute3 AS Attribute
					) AS TempTable
					WHERE Attribute > 0 
				END
				
				-- 소켓 옮기기
				IF ( @Socket1 > 0 OR @Socket2 > 0 OR @Socket3 > 0 OR @Socket4 > 0 ) BEGIN
					SET @Result = -14
					
					INSERT INTO dbo.GItemSocket ( UnitUID, ItemUID, Socket1, Socket2, Socket3, Socket4 )
					VALUES ( @UnitUID_R, @ItemUID, @Socket1, @Socket2, @Socket3, @Socket4 )

				END

				-- 봉인횟수 옮기기
				IF ( @SealCnt <> 0 ) BEGIN
					SET @Result = -15
					
					INSERT INTO dbo.GItemSeal ( ItemUID, SealCnt )
					VALUES ( @ItemUID, @SealCnt - 100 )

				END
				
				--> 여기서 부터 인벤토리 아이템 삭제처리
				-- 판매 아이템이 남아있는 경우
				SET @Result = -16
					
				UPDATE dbo.GPShopItem
					SET Quantity = Quantity - @Quantity
					,	TotalSellEDIn = TotalSellEDIn + ( PricePerOne * @Quantity )
				WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_P					
				
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
	END

	RETURN @Result
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GPShopItem_INT_DEL_A_New]
	@UnitUID_S		bigint				-- 판매자
,	@Quantity		int					-- 등록 개수
,	@ItemUID_Old	bigint 				-- 판매자 아이템 UID
,	@PricePerOne	int					-- 아이템 한개당 판매가격
,	@Category		tinyint				-- 아이템 카테고리
,	@Reason			tinyint				-- 삭제 사유
,	@ItemUID		bigint = 0 OUTPUT
AS
	SET NOCOUNT ON
	
	DECLARE @Result			int
	
	DECLARE @sdtNow			smalldatetime
		,	@sdtEndDate		smalldatetime
		,	@ItemID			int
		,	@UsageType		tinyint
		,	@Quantity_Old	int
		,	@Attribute1		tinyint
		,	@Attribute2		tinyint
		,	@Attribute3		tinyint
		
	SET @sdtNow = CURRENT_TIMESTAMP
		
	SELECT @Attribute1 = Attribute
		FROM dbo.GItemAttribute with(nolock)
			WHERE UnitUID  = @UnitUID_S AND ItemUID = @ItemUID_Old AND SlotNo = 0

	SELECT @Attribute2 = Attribute
		FROM dbo.GItemAttribute with(nolock)
			WHERE UnitUID  = @UnitUID_S AND ItemUID = @ItemUID_Old AND SlotNo = 1

	SELECT @Attribute3 = Attribute
		FROM dbo.GItemAttribute with(nolock)
			WHERE UnitUID  = @UnitUID_S AND ItemUID = @ItemUID_Old AND SlotNo = 2	
	
	SELECT @ItemID = ItemID, @UsageType = UsageType, @Quantity_Old = Quantity
		FROM dbo.GItem WITH(NOLOCK)
			WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_Old
	
		
	-- 해당아이템이 없는 경우.
	IF @@ROWCOUNT = 0
		SET @Result = -1
	ELSE IF @UsageType = 2 AND @Quantity_Old - @Quantity < 0
		SET @Result = -2
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN
			
			-- 아이템 등록
			SET @Result = -11

			-- 대리상점 테이블에 데이터 삽입
			INSERT INTO dbo.GPShopItem ( UnitUID, ItemID, UsageType, Quantity, Endurance, SealCnt, ELevel, Attribute1, Attribute2, Attribute3,
								Socket1, Socket2, Socket3, Socket4, SocketR1, SocketR2, SocketR3, SocketR4, SocketR5, PricePerOne, FeePerOne, TotalSellEDIn, TotalSoldItemQuantity, TotalSellCommissionED,
								RegDate, DelDate, OldItemUID, Category )
			SELECT @UnitUID_S
				, @ItemID
				, @UsageType
				, CASE WHEN @UsageType = 2 THEN @Quantity ELSE 1 END
				, CASE WHEN @UsageType = 1 THEN 10000 ELSE -1 END
				, ISNULL(SEC.SealCnt, 0) AS SealCnt
				, ISNULL(ENC.ELevel, 0) AS ELevel
				, ISNULL(@Attribute1, 0) AS Attribute1
				, ISNULL(@Attribute2, 0) AS Attribute2
				, ISNULL(@Attribute3, 0) AS Attribute3
				, ISNULL(SOC.Socket1, 0) AS Socket1
				, ISNULL(SOC.Socket2, 0) AS Socket2
				, ISNULL(SOC.Socket3, 0) AS Socket3
				, ISNULL(SOC.Socket4, 0) AS Socket4
				, ISNULL(SOR.Socket1, 0) AS SocketR1
				, ISNULL(SOR.Socket2, 0) AS SocketR2
				, ISNULL(SOR.Socket3, 0) AS SocketR3
				, ISNULL(SOR.Socket4, 0) AS SocketR4
				, ISNULL(SOR.Socket5, 0) AS SocketR5
				, @PricePerOne
				, 0 AS FeePerOne
				, 0 AS TotalSellEDIn
				, 0 AS TotalSoldItemQuantity
				, 0 AS TotalSellCommissionED
				, @sdtNow
				, @sdtNow
				, @ItemUID_Old
				, @Category
			FROM (
				SELECT UnitUID, ItemUID, ItemID, UsageType, Quantity, InventoryCategory
				FROM dbo.GItem WITH(NOLOCK)
				WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_Old
			) AS ITM
			LEFT OUTER JOIN	( -- 봉인
				SELECT ItemUID, SealCnt
				FROM dbo.GItemSeal WITH(NOLOCK)
				WHERE ItemUID = @ItemUID_Old
			) AS SEC
			ON ITM.ItemUID = SEC.ItemUID
			LEFT OUTER JOIN ( -- 강화
				SELECT UnitUID, ItemUID, ELevel
				FROM dbo.GItemEnchant WITH(NOLOCK)
				WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_Old
			)AS ENC 
			ON ENC.UnitUID = ITM.UnitUID AND ITM.ItemUID = ENC.ItemUID
			LEFT OUTER JOIN ( -- 소켓
				SELECT UnitUID, ItemUID, Socket1, Socket2, Socket3, Socket4
				FROM dbo.GItemSocket WITH(NOLOCK)
				WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_Old
			)AS SOC 
			ON SOC.UnitUID = ITM.UnitUID AND ITM.ItemUID = SOC.ItemUID
			LEFT OUTER JOIN ( -- 랜덤소켓
				SELECT UnitUID, ItemUID, Socket1, Socket2, Socket3, Socket4, Socket5
				FROM dbo.GItemSocket_Random WITH(NOLOCK)
				WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_Old
			)AS SOR
			ON SOR.UnitUID = ITM.UnitUID AND ITM.ItemUID = SOR.ItemUID

			SET @ItemUID = SCOPE_IDENTITY() -- 새로 발급된 대리상점 ItemUID
			
			
			--> 여기서 부터 인벤토리 아이템 삭제처리
			-- 장비 아이템이나 악세사리(내구도가 없지만 수량성은 아닌 아이템)
			IF @UsageType IN (0, 1) BEGIN
				SET @Result = -16
				
				DELETE dbo.GItem
					OUTPUT DELETED.ItemUID, DELETED.UnitUID, DELETED.ItemID, DELETED.InventoryCategory, DELETED.SlotID, DELETED.UsageType, DELETED.Quantity, DELETED.Endurance, DELETED.Inserted, DELETED.RegDate, GETDATE(), @Reason
					INTO dbo.GItem_Log ( ItemUID, UnitUID, ItemID, InventoryCategory, SlotID, UsageType, Quantity, Endurance, Inserted, RegDate, DelDate, Deleted )
				WHERE ItemUID = @ItemUID_Old
			END
			
			-- 수량성 아이템의 수량 변경
			ELSE IF @UsageType = 2 AND (@Quantity_Old - @Quantity) > 0 BEGIN
				SET @Result = -17
				
				UPDATE dbo.GItem
					SET Quantity = Quantity - @Quantity
						WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_Old					
				END
			
			-- 수량성 아이템 삭제(한 슬롯의 전체 수량을 거래했을 경우)
			ELSE IF @UsageType = 2 AND (@Quantity_Old - @Quantity) = 0 BEGIN
				SET @Result = -18
				
				DELETE dbo.GItem
					OUTPUT DELETED.ItemUID, DELETED.UnitUID, DELETED.ItemID, DELETED.InventoryCategory, DELETED.SlotID, DELETED.UsageType, DELETED.Quantity, DELETED.Endurance, DELETED.Inserted, DELETED.RegDate, GETDATE(), @Reason
					INTO dbo.GItem_Log ( ItemUID, UnitUID, ItemID, InventoryCategory, SlotID, UsageType, Quantity, Endurance, Inserted, RegDate, DelDate, Deleted )
				WHERE ItemUID = @ItemUID_Old		
			END

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
	END

	RETURN @Result
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GPShopItem_INT_DEL_A]
	@UnitUID_S		bigint ,	-- 판매자
	@Quantity		int,		-- 등록 개수
	@ItemUID_Old	bigint ,	-- 판매자 아이템 UID
	@PricePerOne	int,		-- 아이템 한개당 판매가격
	@Category		tinyint,	-- 아이템 카테고리
	@Reason			tinyint,	-- 삭제 사유
	@ItemUID		bigint = 0 OUTPUT
AS
	SET NOCOUNT ON
	
	DECLARE @Result			int
	
	DECLARE @sdtNow			smalldatetime
		,	@sdtEndDate		smalldatetime
		,	@ItemID			int
		,	@UsageType		tinyint
		,	@Quantity_Old	int
		,	@Attribute1		tinyint
		,	@Attribute2		tinyint
		,	@Attribute3		tinyint
		
	SET @sdtNow = CURRENT_TIMESTAMP
		
	SELECT @Attribute1 = Attribute
		FROM dbo.GItemAttribute with(nolock)
			WHERE UnitUID  = @UnitUID_S AND ItemUID = @ItemUID_Old AND SlotNo = 0

	SELECT @Attribute2 = Attribute
		FROM dbo.GItemAttribute with(nolock)
			WHERE UnitUID  = @UnitUID_S AND ItemUID = @ItemUID_Old AND SlotNo = 1

	SELECT @Attribute3 = Attribute
		FROM dbo.GItemAttribute with(nolock)
			WHERE UnitUID  = @UnitUID_S AND ItemUID = @ItemUID_Old AND SlotNo = 2	
	
	SELECT @ItemID = ItemID, @UsageType = UsageType, @Quantity_Old = Quantity
		FROM dbo.GItem WITH(NOLOCK)
			WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_Old
	
		
	-- 해당아이템이 없는 경우.
	IF @@ROWCOUNT = 0
		SET @Result = -1
	ELSE IF @UsageType = 2 AND @Quantity_Old - @Quantity < 0
		SET @Result = -2
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN
			
			-- 아이템 등록
			SET @Result = -11

			-- 대리상점 테이블에 데이터 삽입
			INSERT INTO dbo.GPShopItem ( UnitUID, ItemID, UsageType, Quantity, Endurance, SealCnt, ELevel, Attribute1, Attribute2, Attribute3,
								Socket1, Socket2, Socket3, Socket4, PricePerOne, FeePerOne, TotalSellEDIn, TotalSoldItemQuantity, TotalSellCommissionED,
								RegDate, DelDate, OldItemUID, Category )
			SELECT @UnitUID_S
				, @ItemID
				, @UsageType
				, CASE WHEN @UsageType = 2 THEN @Quantity ELSE 1 END
				, CASE WHEN @UsageType = 1 THEN 10000 ELSE -1 END
				, ISNULL(SEC.SealCnt, 0) AS SealCnt
				, ISNULL(ENC.ELevel, 0) AS ELevel
				, ISNULL(@Attribute1, 0) AS Attribute1
				, ISNULL(@Attribute2, 0) AS Attribute2
				, ISNULL(@Attribute3, 0) AS Attribute3
				, ISNULL(SOC.Socket1, 0) AS Socket1
				, ISNULL(SOC.Socket2, 0) AS Socket2
				, ISNULL(SOC.Socket3, 0) AS Socket3
				, ISNULL(SOC.Socket4, 0) AS Socket4
				, @PricePerOne
				, 0 AS FeePerOne
				, 0 AS TotalSellEDIn
				, 0 AS TotalSoldItemQuantity
				, 0 AS TotalSellCommissionED
				, @sdtNow
				, @sdtNow
				, @ItemUID_Old
				, @Category
			FROM (
				SELECT UnitUID, ItemUID, ItemID, UsageType, Quantity, InventoryCategory
				FROM dbo.GItem WITH(NOLOCK)
				WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_Old
			) AS ITM
			LEFT OUTER JOIN	( -- 봉인
				SELECT ItemUID, SealCnt
				FROM dbo.GItemSeal WITH(NOLOCK)
				WHERE ItemUID = @ItemUID_Old
			) AS SEC
			ON ITM.ItemUID = SEC.ItemUID
			LEFT OUTER JOIN ( -- 강화
				SELECT UnitUID, ItemUID, ELevel
				FROM dbo.GItemEnchant WITH(NOLOCK)
				WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_Old
			)AS ENC 
			ON ENC.UnitUID = ITM.UnitUID AND ITM.ItemUID = ENC.ItemUID
			LEFT OUTER JOIN ( -- 소켓
				SELECT UnitUID, ItemUID, Socket1, Socket2, Socket3, Socket4
				FROM dbo.GItemSocket WITH(NOLOCK)
				WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_Old
			)AS SOC 
			ON SOC.UnitUID = ITM.UnitUID AND ITM.ItemUID = SOC.ItemUID

			SET @ItemUID = @@IDENTITY -- 새로 발급된 대리상점 ItemUID
			
			
			--> 여기서 부터 인벤토리 아이템 삭제처리
			-- 장비 아이템이나 악세사리(내구도가 없지만 수량성은 아닌 아이템)
			IF @UsageType IN (0, 1) BEGIN
				SET @Result = -16
				
				DELETE dbo.GItem
					OUTPUT DELETED.ItemUID, DELETED.UnitUID, DELETED.ItemID, DELETED.InventoryCategory, DELETED.SlotID, DELETED.UsageType, DELETED.Quantity, DELETED.Endurance, DELETED.Inserted, DELETED.RegDate, GETDATE(), @Reason
					INTO dbo.GItem_Log ( ItemUID, UnitUID, ItemID, InventoryCategory, SlotID, UsageType, Quantity, Endurance, Inserted, RegDate, DelDate, Deleted )
				WHERE ItemUID = @ItemUID_Old
			END
			
			-- 수량성 아이템의 수량 변경
			ELSE IF @UsageType = 2 AND (@Quantity_Old - @Quantity) > 0 BEGIN
				SET @Result = -17
				
				UPDATE dbo.GItem
					SET Quantity = Quantity - @Quantity
						WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_Old					
				END
			
			-- 수량성 아이템 삭제(한 슬롯의 전체 수량을 거래했을 경우)
			ELSE IF @UsageType = 2 AND (@Quantity_Old - @Quantity) = 0 BEGIN
				SET @Result = -18
				
				DELETE dbo.GItem
					OUTPUT DELETED.ItemUID, DELETED.UnitUID, DELETED.ItemID, DELETED.InventoryCategory, DELETED.SlotID, DELETED.UsageType, DELETED.Quantity, DELETED.Endurance, DELETED.Inserted, DELETED.RegDate, GETDATE(), @Reason
					INTO dbo.GItem_Log ( ItemUID, UnitUID, ItemID, InventoryCategory, SlotID, UsageType, Quantity, Endurance, Inserted, RegDate, DelDate, Deleted )
				WHERE ItemUID = @ItemUID_Old		
			END

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
	END

	RETURN @Result
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.04.18
-- Description:	우편에 결혼식UID 정보 입력
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_Gpost_Wedding_INT]
	@PostNo			bigint
,	@WeddingUID		int

AS
	SET NOCOUNT ON;
	
	DECLARE @Result		int

	BEGIN TRY
		BEGIN TRAN

			INSERT INTO dbo.Gpost_Wedding( PostNo, WeddingUID )
			VALUES ( @PostNo, @WeddingUID )


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
-- Create date: 2013.05.27
-- Description:	우편 읽어가기(랜덤소켓 부분 추가)
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_Gpost_SEL]
	@UnitUID	bigint	
,	@iOK		int = 0
AS
SET NOCOUNT ON;

	SELECT A.PostNo, ISNULL(B.nickname,'__DELETED__'), A.toUnitUID, A.Quantity, A.ScType, A.ScIndex, A.RegDate, A.IsReceive, A.IsRead
		 , A.title, A.[Message], C.ELevel, D.socket1, D.socket2, D.socket3, D.socket4, E.Attribute1, E.Attribute2, E.Attribute3
		 , G.Socket1, G.Socket2, G.Socket3, G.Socket4, G.Socket5, F.SealCnt, A.FromUnitUID
		FROM dbo.GPost AS A WITH (NOLOCK)
			JOIN dbo.GUnitNickName AS B WITH (NOLOCK)
				ON a.FromUnitUID = b.UnitUID
			LEFT OUTER JOIN dbo.GPost_Enchant AS C WITH (NOLOCK)		-- 강화
				ON A.PostNo = C.PostNo
			LEFT OUTER JOIN dbo.GPost_Socket AS D WITH (NOLOCK)			-- 소켓
				ON A.PostNo = D.PostNo
			LEFT OUTER JOIN dbo.GPost_Attribute AS E WITH (NOLOCK)		-- 속성
				ON A.PostNo = E.PostNo
			LEFT OUTER JOIN dbo.GPost_Seal AS F WITH (NOLOCK)			-- 봉인
				ON A.PostNo = F.PostNo
			LEFT OUTER JOIN dbo.GPost_Socket_Random AS G WITH (NOLOCK)  -- 랜덤 소켓
				ON A.PostNo = G.PostNo	
		WHERE a.ToUnitUID = @UnitUID AND a.DELETED = 0
GO
-- =============================================
-- Author: Hwang
-- Create date: 2012-08-21
-- Description:	우편 통합 내부 SP_B (우편첨부획득)
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GPost_INT_DEL_B]
	@UnitUID		bigint			-- 첨부 꺼내는 사람
,	@UsageType		tinyint
,	@InsertType		tinyint			-- 생성 사유
,	@RegDate		smalldatetime	-- 첨부 아이템 획득 시간
,	@PostNo			bigint
,	@ItemUID		bigint = 0 OUTPUT
	
AS
	SET NOCOUNT ON
	
	DECLARE @Result				int
	DECLARE @ItemID_Post		int
	DECLARE @Quantity_Post		bigint
	DECLARE @ScType_Post		tinyint
	DECLARE @IsReceive_Post		bit
	DECLARE @Deleted_Post		int
	DECLARE @Attribute1_Post	tinyint
	DECLARE @Attribute2_Post	tinyint
	DECLARE @Attribute3_Post	tinyint

	SELECT @Attribute1_Post = Attribute1, @Attribute2_Post = Attribute2, @Attribute3_Post = Attribute3
		FROM dbo.GPost_Attribute WITH(NOLOCK)
			WHERE PostNo = @PostNo
		
	SELECT @Quantity_Post = Quantity, @ScType_Post = ScType, @ItemID_Post = ScIndex, @IsReceive_Post = IsReceive, @Deleted_Post = Deleted
		FROM dbo.GPost WITH(NOLOCK)
			WHERE ToUnitUID = @UnitUID
			AND PostNo = @PostNo
		
	-- 해당아이템이 없으면 종료
	IF @@ROWCOUNT = 0
		SET @Result = -1
	-- 개인우편이 아니면 종료
	ELSE IF @ScType_Post <> 1
		SET @Result = -2
	-- 이미 첨부를 받았으면 종료
	ELSE IF @IsReceive_Post = 1
		SET @Result = -3
	-- 이미 우편이 삭제되었으면 종료	
	ELSE IF @Deleted_Post = 1
		SET @Result = -4
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN
				-- 첨부 아이템이 ED 가 아니면 인벤토리로 획득
				IF @ItemID_Post <> 127000 BEGIN
			
					-- 아이템 등록
					SET @Result = -5

					INSERT INTO dbo.GItem ( UnitUID, ItemID, InventoryCategory, UsageType, Quantity, Endurance, SlotID, Inserted, RegDate )
						SELECT @UnitUID, @ItemID_Post, 0, @UsageType
							, CASE WHEN @UsageType = 2 THEN @Quantity_Post ELSE 0 END
							, CASE WHEN @UsageType = 1 THEN 10000 ELSE -1 END
							, 0
							, @InsertType
							, @RegDate
					
					SET @ItemUID = @@IDENTITY

					-- 강화
					IF EXISTS ( SELECT * FROM dbo.GPost_Enchant WITH(NOLOCK) WHERE PostNo = @PostNo ) BEGIN
						SET @Result = -6
						
						INSERT INTO dbo.GItemEnchant( UnitUID, ELevel, ItemUID )
							SELECT @UnitUID, ELevel, @ItemUID
								FROM dbo.GPost_Enchant
									WHERE PostNo = @PostNo
					END
					
					-- 소켓
					IF EXISTS ( SELECT * FROM dbo.GPost_Socket WITH(NOLOCK) WHERE PostNo = @PostNo ) BEGIN
						SET @Result = -7
						
						INSERT INTO dbo.GItemSocket( UnitUID, Socket1, Socket2, Socket3, Socket4, ItemUID )
							SELECT @UnitUID, Socket1, Socket2, Socket3, Socket4, @ItemUID
								FROM dbo.GPost_Socket
									WHERE PostNo = @PostNo
					END
					
					-- 속성
					IF @Attribute1_Post > 0 OR @Attribute2_Post > 0 OR @Attribute3_Post > 0 BEGIN
						
						SET @Result = -8
				
						INSERT INTO dbo.GItemAttribute (UnitUID, ItemUID, SlotNo, Attribute)
						SELECT @UnitUID, @ItemUID, SlotNo, Attribute
						FROM (
							SELECT 0 AS SlotNo, @Attribute1_Post AS Attribute
							UNION ALL
							SELECT 1, @Attribute2_Post
							UNION ALL
							SELECT 2, @Attribute3_Post
						) AS TempTable
						WHERE Attribute > 0
					END
					
					-- 봉인
					IF EXISTS ( SELECT * FROM dbo.GPost_Seal WITH( NOLOCK ) WHERE PostNo = @PostNo ) BEGIN
						SET @Result = -9
						
						INSERT INTO dbo.GItemSeal( ItemUID, SealCnt )
							SELECT @ItemUID, SealCnt
								FROM dbo.GPost_Seal
									WHERE PostNo = @PostNo
					END
					
				END
				
				-- 우편 첨부 획득 업데이트
				SET @Result = -10
				
				UPDATE dbo.GPost
					SET IsReceive = 1
						WHERE ToUnitUID = @UnitUID 
						AND PostNo = @PostNo


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
	END

	RETURN @Result
GO
-- =============================================
-- Author: Hwang
-- Create date: 2012-08-21
-- Description:	우편 통합 내부 SP_A (우편보내기)
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GPost_INT_DEL_A]
	@UnitUID_S		bigint ,		-- 보내는 사람
	@UnitUID_R		bigint ,		-- 받는 사람
	@Quantity		int,			-- 거래 개수(수량성 아이템이 아니라면 0)
	@ItemUID_Old	bigint,			-- 주는 사람 아이템의 UID
	@PostItemtype	tinyint,		-- 첨부가 아이템인지 
	@Title			nvarchar(38),	-- 우편 제목
	@Message		nvarchar(600),	-- 우편 내용
	@Reason			tinyint,		-- 삭제 사유
	@PostDate		smalldatetime,
	@PostNo			bigint = 0 OUTPUT
	
AS
	SET NOCOUNT ON
	
	DECLARE @Result			int
	DECLARE @ItemID			int
	DECLARE @UsageType		tinyint
	DECLARE @Quantity_Old	int
	DECLARE @Attribute1		tinyint
	DECLARE @Attribute2		tinyint
	DECLARE @Attribute3		tinyint
		
	SET @PostDate = CURRENT_TIMESTAMP
	
		
	SELECT @Attribute1 = Attribute
		FROM dbo.GItemAttribute with(nolock)
			WHERE UnitUID  = @UnitUID_S AND ItemUID = @ItemUID_Old AND SlotNo = 0

	SELECT @Attribute2 = Attribute
		FROM dbo.GItemAttribute with(nolock)
			WHERE UnitUID  = @UnitUID_S AND ItemUID = @ItemUID_Old AND SlotNo = 1

	SELECT @Attribute3 = Attribute
		FROM dbo.GItemAttribute with(nolock)
			WHERE UnitUID  = @UnitUID_S AND ItemUID = @ItemUID_Old AND SlotNo = 2	
			
	SELECT @ItemID = ItemID, @UsageType = UsageType, @Quantity_Old = Quantity
		FROM dbo.GItem WITH(NOLOCK)
			WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_Old
		
	-- 해당아이템이 없는 경우.
	IF @@ROWCOUNT = 0 AND @PostItemtype = 1
		SET @Result = -1
	ELSE IF @UsageType = 2 AND @Quantity_Old - @Quantity < 0
		SET @Result = -2
	ELSE IF @UnitUID_R IS NULL
		SET @Result = -3
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN	
				-- 우편 등록
				SET @Result = -10
		
				INSERT INTO dbo.GPost( FromUnitUID, ToUnitUID, Quantity, ScType, ScIndex, RegDate, DelDate, IsRead, IsReceive, Title, [Message] )
				SELECT  @UnitUID_S,
						@UnitUID_R,
						@Quantity,
						1,
						CASE WHEN @PostItemtype = 1 THEN @ItemID WHEN @PostItemtype = 2 THEN 127000 ELSE 0 END,
						@PostDate,
						@PostDate,
						0,
						0,
						@Title,
						@Message
				
				SET @PostNo = @@IDENTITY

				-- 아이템 첨부일 경우, 강화/소켓/속성/봉인 넣어주기 & 아이템 삭제 혹은 수량변경
				IF @PostItemtype = 1 BEGIN
					
					IF EXISTS ( SELECT * FROM dbo.GItemEnchant WITH(NOLOCK) WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_Old ) BEGIN
						SET @Result = -20
						
							INSERT INTO dbo.GPost_Enchant (PostNo, ELevel)
								SELECT @PostNo, Elevel
									FROM dbo.GItemEnchant WITH(NOLOCK)
										WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_Old
						END
						
					-- 소켓에 해당된다면,
					IF EXISTS ( SELECT * FROM dbo.GItemSocket WITH( NOLOCK ) WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_Old ) BEGIN
						SET @Result = -21
					
							INSERT INTO dbo.GPost_Socket (PostNo, Socket1, Socket2, Socket3, Socket4)
								SELECT @PostNo, Socket1 , Socket2 , Socket3 , Socket4
									FROM dbo.GItemSocket WITH(NOLOCK)
										WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_Old
						END

					-- 속성에 해당된다면,
					IF @Attribute1 > 0 OR @Attribute2 > 0 OR @Attribute3 > 0  BEGIN
						SET @Result = -22
						
							INSERT INTO GPost_Attribute (PostNo, Attribute1, Attribute2, Attribute3)					
								SELECT @PostNo, ISNULL(@Attribute1, 0) , ISNULL(@Attribute2, 0), ISNULL(@Attribute3, 0)			
						END						

					-- 봉인에 해당된다면,
					IF EXISTS ( SELECT * FROM dbo.GItemSeal WITH( NOLOCK ) WHERE ItemUID = @ItemUID_Old AND SealCnt >= 100) BEGIN
						SET @Result = -23
					
							INSERT INTO dbo.GPost_Seal (PostNo, SealCnt) 
								SELECT @PostNo, SealCnt - 100
									FROM dbo.GItemSeal WITH(NOLOCK)
										WHERE ItemUID = @ItemUID_Old
						END
						
					--> 아이템 삭제처리
					-- 장비 아이템이나 악세사리(내구도가 없지만 수량성은 아닌 아이템)
					IF @UsageType IN (0, 1) BEGIN
						SET @Result = -24
					
						DELETE dbo.GItem
							OUTPUT DELETED.ItemUID, DELETED.UnitUID, DELETED.ItemID, DELETED.InventoryCategory, DELETED.SlotID, DELETED.UsageType, DELETED.Quantity, DELETED.Endurance, DELETED.Inserted, DELETED.RegDate, GETDATE(), @Reason
							INTO dbo.GItem_Log ( ItemUID, UnitUID, ItemID, InventoryCategory, SlotID, UsageType, Quantity, Endurance, Inserted, RegDate, DelDate, Deleted )
						WHERE ItemUID = @ItemUID_Old
					END
					
					-- 수량성 아이템의 수량 변경
					ELSE IF @UsageType = 2 AND (@Quantity_Old - @Quantity) > 0 BEGIN
						SET @Result = -25
						
						UPDATE dbo.GItem
							SET Quantity = Quantity - @Quantity
								WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_Old					
						END
					
					-- 수량성 아이템 삭제(한 슬롯의 전체 수량을 거래했을 경우)
					ELSE IF @UsageType = 2 AND (@Quantity_Old - @Quantity) = 0 BEGIN
						SET @Result = -26
						
						DELETE dbo.GItem
							OUTPUT DELETED.ItemUID, DELETED.UnitUID, DELETED.ItemID, DELETED.InventoryCategory, DELETED.SlotID, DELETED.UsageType, DELETED.Quantity, DELETED.Endurance, DELETED.Inserted, DELETED.RegDate, GETDATE(), @Reason
							INTO dbo.GItem_Log ( ItemUID, UnitUID, ItemID, InventoryCategory, SlotID, UsageType, Quantity, Endurance, Inserted, RegDate, DelDate, Deleted )
						WHERE ItemUID = @ItemUID_Old		
					END
				
			END

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
	END

	RETURN @Result
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.05.27
-- Description:	우편 저장(랜덤소켓 부분 추가)
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GPost_INS]
	@FromUnitUID		bigint
,	@ToUnitNickName		nvarchar(16)
,	@Quantity			int
,	@ScType				tinyint
,	@ScIndex			int
,	@Title				nvarchar(38)
,	@Message			nvarchar(800)
,	@ELevel				smallint
,	@Socket1			int
,	@Socket2			int
,	@Socket3			int
,	@Socket4			int
,	@Attribute1			tinyint
,	@Attribute2			tinyint
,	@Attribute3			tinyint
,	@iSealCnt			tinyint
,	@Socket1R			int
,	@Socket2R			int
,	@Socket3R			int
,	@Socket4R			int
,	@Socket5R			int

AS
	SET NOCOUNT ON

	-- 기존 파라미터에서 변수로 변경
	DECLARE @Result		int

	DECLARE @sdtNow		smalldatetime
	,	@PostNo			bigint
	,	@ToUnitUID		bigint

	SELECT @ToUnitUID = UnitUID, @sdtNow = GETDATE()
	FROM dbo.GunitNickName WITH(NOLOCK)
    WHERE NickName = @ToUnitNickName


	BEGIN TRY
		BEGIN TRAN

		-- 우체국에넣기
		SET @Result = -1
		INSERT INTO dbo.GPost (FromUnitUID, ToUnitUID, Quantity, ScType, ScIndex, RegDate, DelDate, Title, Message )
		VALUES ( @FromUnitUID, @ToUnitUID, @Quantity, @ScType, @ScIndex, @sdtNow, @sdtNow, @Title, @Message )

		SET @PostNo = SCOPE_IDENTITY()

		-- 기타 옵션이 하나도 없을 경우 종료
		IF @ELevel = 0 AND @Socket1 = 0 AND @Socket2 = 0 AND @Socket3 = 0 AND @Socket4 = 0 
			AND @Attribute1 = 0 AND @Attribute2 = 0 AND @Attribute3 = 0 AND @iSealCnt = 0 
			AND @Socket1R = 0 AND @Socket2R = 0 AND @Socket3R = 0 AND @Socket4R = 0 AND @Socket5R = 0
		BEGIN SET @Result = 0 END
		
		ELSE BEGIN		
				-- 강화에 해당 된다면,
				IF @ELevel > 0 BEGIN
					SET @Result = -2

					INSERT INTO dbo.GPost_Enchant (PostNo, ELevel)
					VALUES ( @PostNo, @ELevel )
				END

				-- 소켓에 해당 된다면,
				IF ISNULL(@Socket1, 0) <> 0 OR ISNULL(@Socket2, 0) <> 0 OR ISNULL(@Socket3, 0) <> 0 OR ISNULL(@Socket4, 0) <> 0 BEGIN
					SET @Result = -3
					INSERT INTO dbo.GPost_Socket ( PostNo, Socket1, Socket2, Socket3, Socket4 )
					VALUES ( @PostNo, @Socket1 , @Socket2 , @Socket3 , @Socket4 )
				END

				-- 속성에 해당 된다면,
				IF (@Attribute1 + @Attribute2 + @Attribute3) > 0 BEGIN
					SET @Result = -4
					INSERT INTO GPost_Attribute ( PostNo, Attribute1, Attribute2, Attribute3 )
					VALUES ( @PostNo, @Attribute1, @Attribute2, @Attribute3 )
				END

				-- 봉인 횟수
				IF (@iSealCnt > 0) BEGIN
					SET @Result = -5
					INSERT INTO dbo.GPost_Seal ( PostNo, SealCnt )
					VALUES ( @PostNo, @iSealCnt )
				END
				
				-- 랜덤 소켓에 해당된다면,
				IF ISNULL(@Socket1R, 0) <> 0 OR ISNULL(@Socket2R, 0) <> 0 OR ISNULL(@Socket3R, 0) <> 0 OR ISNULL(@Socket4R, 0) <> 0 OR ISNULL(@Socket5R, 0) <> 0 BEGIN
					SET @Result = -6
					INSERT INTO dbo.GPost_Socket_Random ( PostNo, Socket1, Socket2, Socket3, Socket4, Socket5 )
					VALUES ( @PostNo, @Socket1R , @Socket2R , @Socket3R , @Socket4R, @Socket5R )
				END
		END

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

	SELECT ISNULL(@Result, 0) AS Result, @PostNo AS PostNo, @ToUnitUID AS ToUnitUID, @sdtNow AS RegDate
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.04.16
-- Description:	우편함에서 웨딩 아이템 수령처리(삭제)
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GPost_DEL_Wedding]
	@UnitUID			bigint
,	@PostNo				bigint
,	@ExistWeddingUID	bit

AS
	SET NOCOUNT ON;
	
	DECLARE @Result			int
	DECLARE @Deleted		int
	DECLARE @ToUnitUID		bigint
	DECLARE @WeddingUID		int
	DECLARE @sdtNow			smalldatetime
	DECLARE @WeddingDate	smalldatetime
	
	IF @ExistWeddingUID = 1 BEGIN
		SELECT @WeddingUID = A.WeddingUID, @WeddingDate = B.WeddingDate + 1
		FROM dbo.GPost_Wedding AS A WITH(NOLOCK)
		JOIN dbo.GCouple_WeddingInfo AS B WITH(NOLOCK)
			ON A.WeddingUID = B.WeddingUID
		WHERE A.PostNo = @PostNo
	END
	ELSE BEGIN
		SELECT @WeddingUID = 0, @WeddingDate = ''
	END

	SELECT @Deleted = Deleted, @ToUnitUID = ToUnitUID, @sdtNow = CAST(GETDATE() AS smalldatetime)
	FROM dbo.GPost WITH(NOLOCK)
	WHERE PostNo = @PostNo

	IF @@ROWCOUNT = 0
		SET @Result = -2	-- 해당 우체국번호가 없으면 에러
	ELSE IF @Deleted = 1
		SET @Result = -3	-- 이미 삭제된 아이템이면 에러
	ELSE IF @UnitUID <> @ToUnitUID
		SET @Result = -4	-- 다른 사람의 소포이면
	ELSE IF @WeddingUID IS NULL
		SET @Result = -5	-- 결혼식 정보가 없으면
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN

			UPDATE dbo.GPost
			SET DELDATE = CASE WHEN RegDate = @sdtNow THEN DATEADD(mi, 1, @sdtNow) ELSE @sdtNow END
			WHERE PostNo = @PostNo

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
	END

	SELECT ISNULL(@Result, 0) AS Result, ISNULL(@WeddingUID, 0) AS WeddingUID, @WeddingDate AS WeddingDate
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GPost_DEL_System]
	@iUnitUID	bigint	
,	@iPostNo	bigint
AS
	SET NOCOUNT ON

DECLARE @Result	int
,		@sdtNow	smalldatetime

SELECT	@sdtNow	= DATEADD(MI, 1, GETDATE())

-- 해당 우체국번호가 없으면 에러
SET @Result = -2
IF NOT EXISTS (SELECT * FROM dbo.GPost WHERE PostNo = @iPostNo) BEGIN
	SELECT @Result
	RETURN
END

-- 이미 삭제된 아이템이면 에러
SET @Result = -3
IF (1 = (SELECT DELETED FROM  dbo.GPost WHERE PostNo = @iPostNo)) BEGIN
	SELECT @Result
	RETURN
END

-- 다른 사람의 소포이면
SET @Result = -4
IF (@iUnitUID <> (SELECT ToUnitUID FROM  dbo.GPost WHERE PostNo = @iPostNo)) BEGIN
	SELECT @Result
	RETURN
END

BEGIN TRY
		
	-- 시스템 우편 첨부파일 획득시 IsReceive, DelDate 갱신
	SET @Result = 0
	BEGIN TRAN
	
		UPDATE dbo.GPost
			SET IsReceive = 1
			,	DELDATE = @sdtNow
				WHERE PostNo = @iPostNo
		
	COMMIT TRAN

END TRY
BEGIN CATCH
	DECLARE @NO_XACT_STATE		smallint
	SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

	IF @NO_XACT_STATE <> 0 AND @@NESTLEVEL = 1
		ROLLBACK TRAN

	EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE
	
	SET @Result = -1
END CATCH

SELECT ISNULL(@Result, 0) AS Result
GO
/*
	펫 닉네임 변경
*/

CREATE OR ALTER PROCEDURE [dbo].[P_GPet_Info_UPT]
	@PetUID 		bigint
,	@PetName		nvarchar(16)

AS
	SET NOCOUNT ON

	DECLARE @Result			int
		,	@OldPetName		nvarchar(16)
		
	SELECT @OldPetName = PetName FROM dbo.GPet_Info WITH(NOLOCK) WHERE PetUID = @PetUID

	IF NOT EXISTS ( SELECT * FROM dbo.GPet_Info WITH(NOLOCK) WHERE PetUID = @PetUID )
		SELECT @Result	= -1
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN
	
				-- 펫 닉네임 바꿔주기
				UPDATE dbo.GPet_Info
				SET PetName = @PetName
				WHERE PetUID = @PetUID
				
				insert into dbo.GPetNameChangeLog( PetUID, OldPetName, NewPetName)
				select @PetUID, @OldPetName, @PetName
				
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
CREATE OR ALTER PROCEDURE [dbo].[P_GPet_Info_UPD_ChangePet]
	@PetUID				BIGINT
,	@ChangePetID		INT

AS

SET NOCOUNT ON

DECLARE @Result INT

SET @Result = 0

UPDATE dbo.GPet_Info
SET PetID = @ChangePetID
WHERE PetUID = @PetUID

IF @@ROWCOUNT = 0
	SET @Result = -1

SELECT @Result
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GPet_Info_PickUP_UPT]
	@PetUID		bigint

AS
	SET NOCOUNT ON;
	
	DECLARE @Result	int

	BEGIN TRY
		BEGIN TRAN
		
			SET @Result = -1

			-- 픽업 기능 적용
			UPDATE dbo.GPet_Info
			SET PickUP = 1
			WHERE PetUID = @PetUID
		
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
CREATE OR ALTER PROCEDURE [dbo].[P_GPet_Info_DEL]
	@PetUID		bigint

AS
	SET NOCOUNT ON;
	
	DECLARE @Result		int
	
	BEGIN TRY
		BEGIN TRAN
		
		SET @Result = -1
		
		DELETE dbo.GPet_Info
			OUTPUT DELETED.PetUID, DELETED.UnitUID, DELETED.PetID, DELETED.PetName, DELETED.EvolutionStep, DELETED.Satiety, DELETED.Intimacy, DELETED.Extroversion, DELETED.Emotion, DELETED.RegDate, DELETED.DelDate, DELETED.IsCall, DELETED.AutoFeed, DELETED.LastFeedDate, DELETED.LastcallDate, DELETED.PickUP
			INTO GameDataMgmt.dbo.DeletePetMgmt(PetUID, UnitUID, PetID, PetName, EvolutionStep, Satiety, Intimacy, Extroversion, Emotion, RegDate, DelDate, IsCall, AutoFeed, LastFeedDate, LastcallDate, PickUP)
		WHERE PetUID = @PetUID
		
		IF @@ROWCOUNT = 0
			RAISERROR(N'[Result : %d]P_GPet_Info_DEL %I64d', 15, 1, @Result, @PetUID) WITH SETERROR
				

	
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
CREATE OR ALTER PROCEDURE [dbo].[P_GNote_UPT_UnitClassChange]
	@UnitUID		bigint
,	@OldItemID			int
,	@NewItemID		int

AS
	SET NOCOUNT ON
/*
	전직 변경이 되면서 변경될 전직의 메모정보를 업데이트 한다
	매칭되는 데이터는 서버가 스크립트에서 가져온다
*/
	
	DECLARE @Result			int
		
	-- 해당유닛이 없는 경우.
	IF NOT EXISTS ( SELECT * FROM dbo.GUnit WITH( NOLOCK ) WHERE UnitUID = @UnitUID AND Deleted = 0 ) BEGIN
			SET @Result = -1
	END
	-- 기술의 노트에 메모가 기록되지 않은 경우
	ELSE IF NOT EXISTS ( SELECT * FROM dbo.GNote WITH( NOLOCK ) WHERE UnitUID = @UnitUID AND ItemID = @OldItemID) BEGIN
			SET @Result = -2
	END
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN

			UPDATE dbo.GNote
			SET ItemID = @NewItemID
			WHERE UnitUID = @UnitUID and ItemID = @OldItemID

			INSERT INTO dbo.GUnitClassChangeStage ( UnitUID, OldID, [NewID], SPNo, RegDate )
				VALUES ( @UnitUID, @OldItemID, @NewItemID, 4, getdate() )

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

	SELECT ISNULL(@Result, 0) AS Result
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GItemSocket_Random_SEL]
    @iUnitUID bigint
AS
       SET NOCOUNT ON;

       SELECT ItemUID, Socket1, Socket2, Socket3, Socket4, Socket5
       FROM dbo.GItemSocket_Random      AS A WITH(NOLOCK)
       WHERE UnitUID = @iUnitUID
             AND EXISTS (
                    SELECT *
                    FROM dbo.GItem WITH(NOLOCK)
                    WHERE ItemUID = A.ItemUID
                           AND UnitUID = @iUnitUID
                           AND Inventorycategory IN (1, 2, 8, 9, 13)
             )
GO
-- =============================================
-- Author:          Hwang
-- Create date: 2013.05.14
-- Description:     랜덤 소켓 정보 저장
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GItemSocket_Random_INT_UPD]
	@UnitUID     bigint
,	@ItemUID     bigint
,	@Socket1     int
,	@Socket2     int
,	@Socket3     int
,	@Socket4     int
,	@Socket5     int

AS
SET NOCOUNT ON;
       DECLARE @Result            int

       BEGIN TRY
             BEGIN TRAN
                    IF NOT EXISTS (SELECT ItemUID FROM dbo.GItemSocket_Random WITH (NOLOCK) WHERE UnitUID = @UnitUID AND ItemUID = @ItemUID) BEGIN
                           SET @Result = -10
                    
                           INSERT INTO dbo.GItemSocket_Random (UnitUID, ItemUID, Socket1, Socket2, Socket3, Socket4, Socket5 )
                           VALUES( @UnitUID, @ItemUID, @Socket1, @Socket2, @Socket3, @Socket4, @Socket5 )
                    END
                    ELSE BEGIN
                           SET @Result = -11
                           
                           UPDATE dbo.GItemSocket_Random
                                 SET Socket1 = @Socket1
                                 ,   Socket2 = @Socket2
                                 ,   Socket3 = @Socket3
                                 ,   Socket4 = @Socket4
                                 ,   Socket5 = @Socket5
                                 WHERE UnitUID = @UnitUID AND ItemUID = @ItemUID
                    END
             COMMIT TRAN

             SET @Result = 0
       END TRY
       BEGIN CATCH
             DECLARE @NO_XACT_STATE           smallint
             SET @NO_XACT_STATE               = XACT_STATE()             -- 트랜잭션상태정보

             IF @NO_XACT_STATE <> 0
                    ROLLBACK TRAN

             EXEC dbo.SYS_SP_ErrorLog_INT @NO_XACT_STATE

             IF @Result = 0 OR @Result IS NULL
                    SET @Result = -1
       END CATCH
             
       SELECT ISNULL(@Result, 0) AS Result
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GItemSeal_SEL_BankItem]
	@UnitUID			bigint
AS
	SET NOCOUNT ON

	SELECT ItemUID, SealCnt
	FROM dbo.GItemSeal	AS A WITH(NOLOCK)
	WHERE EXISTS (
		SELECT * FROM dbo.GItem WITH(NOLOCK)
		WHERE UnitUID = @UnitUID AND ItemUID = A.ItemUID
			AND Inventorycategory = 8
	)
GO
-- =============================================
-- Author:		KOG. B.K
-- Create date: 2011. 10.18
-- Description:	캐릭터 은행 크기 확인
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GItemInventorySize_SEL_Bank]
	@UnitUID			bigint
AS
	SET NOCOUNT ON

	SELECT SUM(NumSlot) AS NumSlot
	FROM dbo.GItemInventorySize WITH (NOLOCK)
	WHERE UnitUID = @UnitUID
		AND InventoryCategory = 8
GO
-- =============================================
-- Author:		HWANG
-- Create date: 2012.12.26
-- Description:	인벤토리 확장
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GItemInventorySize_INS]
	@UnitUID			bigint 
,	@InventoryCategory tinyint
,	@NumSlot			tinyint

AS
	SET NOCOUNT ON
	
	DECLARE @Result	INT
	DECLARE	@sdtNow	smalldatetime
	SET	@sdtNow = GETDATE()

	IF NOT EXISTS ( SELECT * FROM dbo.GUnit WITH(NOLOCK) WHERE UnitUID = @UnitUID )
		SELECT @Result	= -1
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN
			
			IF EXISTS ( SELECT * FROM dbo.GItemInventorySize WITH(NOLOCK) WHERE UnitUID = @UnitUID AND InventoryCategory = @InventoryCategory ) BEGIN
				SET @Result = -2

				UPDATE dbo.GItemInventorySize
				SET NumSlot = @NumSlot, RegDate = @sdtNow
				WHERE UnitUID = @UnitUID AND InventoryCategory = @InventoryCategory
				
			END
			ELSE BEGIN
				SET @Result = -3

				INSERT INTO dbo.GItemInventorySize (UnitUID, InventoryCategory, NumSlot, RegDate)
					VALUES ( @UnitUID, @InventoryCategory, @NumSlot, @sdtNow )
				
			END

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
CREATE OR ALTER PROCEDURE [dbo].[P_GItemAttribute_SEL_BankItem]
	@UnitUID			bigint
AS
	SET NOCOUNT ON

	SELECT ItemUID, SlotNo, Attribute, UnitUID
	FROM dbo.GItemAttribute	AS A WITH(NOLOCK)
	WHERE EXISTS (
		SELECT * FROM dbo.GItem WITH(NOLOCK)
		WHERE UnitUID = @UnitUID AND ItemUID = A.ItemUID
			AND Inventorycategory = 8
	)
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GItem_UPT_UnitClassChange]
	@UnitUID		bigint
,	@ItemUID		bigint
,	@NewItemID		int

AS
	SET NOCOUNT ON
/*
	전직 변경이 되면서 변경될 전직의 아이템(스킬, 캐시메모)를 업데이트 한다(인벤토리에 소지하고 있다는 전제)
	매칭되는 데이터는 서버가 스크립트에서 가져온다
*/
	
	DECLARE @OldItemID		int
	,		@Result			int
		
	SELECT @OldItemID = ItemID FROM dbo.GItem WITH( NOLOCK ) WHERE UnitUID = @UnitUID AND ItemUID = @ItemUID
		
	-- 해당유닛이 없는 경우.
	IF NOT EXISTS ( SELECT * FROM dbo.GUnit WITH( NOLOCK ) WHERE UnitUID = @UnitUID AND Deleted = 0 ) BEGIN
			SET @Result = -1
	END
	-- 아이템이 인벤토리에 없는 경우
	ELSE IF NOT EXISTS ( SELECT * FROM dbo.GItem WITH( NOLOCK ) WHERE UnitUID = @UnitUID AND ItemUID = @ItemUID ) BEGIN
			SET @Result = -2
	END
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN

			UPDATE dbo.GItem
			SET ItemID = @NewItemID
			WHERE UnitUID = @UnitUID and ItemUID = @ItemUID

			INSERT INTO dbo.GUnitClassChangeStage ( UnitUID, OldID, [NewID], SPNo, RegDate )
				VALUES ( @UnitUID, @OldItemID, @NewItemID, 5, getdate() )

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

	SELECT ISNULL(@Result, 0) AS Result
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GItem_Trade_BankItem_New]
	@FromUnitUID			bigint
,	@ToUnitUID				bigint
,	@FromItemUID			bigint
,	@ToInventoryCategory	tinyint
,	@ToSlotID				tinyint
,	@ToSealCnt				tinyint
,	@Deleted				tinyint
AS
	SET NOCOUNT ON

	DECLARE @Result			int
	DECLARE @getdate		smalldatetime
	,	@ItemUID			bigint
	,	@UserUID			bigint
	
	SET @getdate = DATEADD(mi, 1, GETDATE())
	
	SELECT @UserUID = UserUID
	FROM dbo.GUnit WITH(NOLOCK)
	WHERE UnitUID = @FromUnitUID
		AND Deleted = 0
	
	IF @@ROWCOUNT = 0
		SET @Result = -9
	ELSE IF NOT EXISTS ( SELECT * FROM dbo.GUnit WITH(NOLOCK) WHERE UnitUID = @ToUnitUID AND UserUID = @UserUID AND Deleted = 0)
		SET @Result = -8
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN
				SET @Result = -11		-- 아이템 삭제

				DELETE dbo.GItem
					OUTPUT DELETED.ItemUID, DELETED.UnitUID, DELETED.ItemID, DELETED.InventoryCategory, DELETED.SlotID, DELETED.UsageType, DELETED.Quantity, DELETED.Endurance, DELETED.Inserted, DELETED.RegDate, @getdate, @Deleted
					INTO dbo.GItem_Log ( ItemUID, UnitUID, ItemID, InventoryCategory, SlotID, UsageType, Quantity, Endurance, Inserted, RegDate, DelDate, Deleted )
				WHERE UnitUID = @FromUnitUID
					AND ItemUID = @FromItemUID				
				
				IF @@ROWCOUNT <> 1
					RAISERROR(N'[Result : %d]P_GItem_Trade_BankItem %I64d, %I64d, %I64d, %d, %d, %d, %d', 15, 1, @Result, @FromUnitUID, @ToUnitUID, @FromItemUID, @ToInventoryCategory, @ToSlotID, @ToSealCnt, @Deleted) WITH SETERROR

				SET @Result = -21		-- 아이템 입력
				
				INSERT INTO dbo.GItem ( UnitUID, ItemID, InventoryCategory, SlotID, UsageType, Quantity, Endurance, Inserted, RegDate )
				SELECT @ToUnitUID, ItemID, @ToInventoryCategory, @ToSlotID, UsageType, Quantity, Endurance, 127, @getdate
					FROM dbo.GItem_Log WITH(NOLOCK)
						WHERE ItemUID = @FromItemUID
				
				SET @ItemUID = SCOPE_IDENTITY()
				
				-- 아이템 속성 정보 입력
				IF EXISTS (SELECT * FROM dbo.GItemAttribute WITH(NOLOCK) WHERE ItemUID = @FromItemUID ) BEGIN
					SET @Result = -12
					INSERT INTO dbo.GItemAttribute ( ItemUID, SlotNo, Attribute, UnitUID )
					SELECT @ItemUID, SlotNo, Attribute, @ToUnitUID
					FROM dbo.GItemAttribute WITH(NOLOCK)
					WHERE ItemUID = @FromItemUID
						AND UnitUID = @FromUnitUID
				END

				-- 아이템 강화 정보 입력
				IF EXISTS (SELECT * FROM dbo.GItemEnchant WITH(NOLOCK) WHERE ItemUID = @FromItemUID ) BEGIN
					SET @Result = -13
					INSERT INTO dbo.GItemEnchant ( ItemUID, ELevel, UnitUID )
					SELECT @ItemUID, ELevel, @ToUnitUID
					FROM dbo.GItemEnchant WITH(NOLOCK)
					WHERE ItemUID = @FromItemUID
				END
				
				-- 아이템 기간 정보 입력
				IF EXISTS (SELECT * FROM dbo.GItemPeriod WITH(NOLOCK) WHERE ItemUID = @FromItemUID ) BEGIN
					SET @Result = -14
					INSERT INTO dbo.GItemPeriod ( ItemUID, Period, ExpirationDate, UnitUID )
					SELECT @ItemUID, Period, ExpirationDate, @ToUnitUID
					FROM dbo.GItemPeriod WITH(NOLOCK)
					WHERE ItemUID = @FromItemUID
				END
				
				-- 아이템 소켓 정보 입력
				IF EXISTS (SELECT * FROM dbo.GItemSocket WITH(NOLOCK) WHERE ItemUID = @FromItemUID ) BEGIN
					SET @Result = -15
					INSERT INTO dbo.GItemSocket ( ItemUID, Socket1, Socket2, Socket3, Socket4, UnitUID )
					SELECT @ItemUID, Socket1, Socket2, Socket3, Socket4, @ToUnitUID
					FROM dbo.GItemSocket WITH(NOLOCK)
					WHERE ItemUID = @FromItemUID
				END
				
				-- 아이템 봉인 정보 입력
				IF @ToSealCnt <> 0 BEGIN
					SET @Result = -16
					INSERT INTO dbo.GItemSeal ( ItemUID, SealCnt )
					VALUES ( @ItemUID, @ToSealCnt )
				END
				
				-- 아이템 랜덤 소켓 정보 입력
				IF EXISTS (SELECT * FROM dbo.GItemSocket_Random WITH(NOLOCK) WHERE ItemUID = @FromItemUID ) BEGIN
					SET @Result = -17
					INSERT INTO dbo.GItemSocket_Random ( ItemUID, Socket1, Socket2, Socket3, Socket4, Socket5, UnitUID )
					SELECT @ItemUID, Socket1, Socket2, Socket3, Socket4, Socket5, @ToUnitUID
					FROM dbo.GItemSocket_Random WITH(NOLOCK)
					WHERE ItemUID = @FromItemUID
				END
				
			COMMIT TRAN
			SET @Result = 0
		END TRY
		BEGIN CATCH
			DECLARE @NO_XACT_STATE		smallint
			SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

			IF @NO_XACT_STATE <> 0
				ROLLBACK TRAN

			IF @Result = 0 OR @Result IS NULL
				SET @Result = -1

			RAISERROR(N'[Result : %d]P_GItem_Trade_BankItem %I64d, %I64d, %I64d, %d, %d, %d, %d', 15, 1, @Result, @FromUnitUID, @ToUnitUID, @FromItemUID, @ToInventoryCategory, @ToSlotID, @ToSealCnt, @Deleted) WITH LOG
		END CATCH
	END

	SELECT @Result AS Result, @ItemUID AS ToItemUID, @getdate AS RegDate
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GItem_Trade_BankItem]
	@FromUnitUID			bigint
,	@ToUnitUID				bigint
,	@FromItemUID			bigint
,	@ToInventoryCategory	tinyint
,	@ToSlotID				tinyint
,	@ToSealCnt				tinyint
,	@Deleted				tinyint
AS
	SET NOCOUNT ON

	DECLARE @Result			int
	DECLARE @getdate		smalldatetime
	,	@ItemUID			bigint
	,	@UserUID			bigint
	
	SET @getdate = DATEADD(mi, 1, GETDATE())
	
	SELECT @UserUID = UserUID
	FROM dbo.GUnit WITH(NOLOCK)
	WHERE UnitUID = @FromUnitUID
		AND Deleted = 0
	
	IF @@ROWCOUNT = 0
		SET @Result = -9
	ELSE IF NOT EXISTS ( SELECT * FROM dbo.GUnit WITH(NOLOCK) WHERE UnitUID = @ToUnitUID AND UserUID = @UserUID AND Deleted = 0)
		SET @Result = -8
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN
				SET @Result = -11		-- 아이템 삭제

				DELETE dbo.GItem
					OUTPUT DELETED.ItemUID, DELETED.UnitUID, DELETED.ItemID, DELETED.InventoryCategory, DELETED.SlotID, DELETED.UsageType, DELETED.Quantity, DELETED.Endurance, DELETED.Inserted, DELETED.RegDate, @getdate, @Deleted
					INTO dbo.GItem_Log ( ItemUID, UnitUID, ItemID, InventoryCategory, SlotID, UsageType, Quantity, Endurance, Inserted, RegDate, DelDate, Deleted )
				WHERE UnitUID = @FromUnitUID
					AND ItemUID = @FromItemUID				
				
				IF @@ROWCOUNT <> 1
					RAISERROR(N'[Result : %d]P_GItem_Trade_BankItem %I64d, %I64d, %I64d, %d, %d, %d, %d', 15, 1, @Result, @FromUnitUID, @ToUnitUID, @FromItemUID, @ToInventoryCategory, @ToSlotID, @ToSealCnt, @Deleted) WITH SETERROR

				SET @Result = -21		-- 아이템 입력
				
				INSERT INTO dbo.GItem ( UnitUID, ItemID, InventoryCategory, SlotID, UsageType, Quantity, Endurance, Inserted, RegDate )
				SELECT @ToUnitUID, ItemID, @ToInventoryCategory, @ToSlotID, UsageType, Quantity, Endurance, 127, @getdate
					FROM dbo.GItem_Log WITH(NOLOCK)
						WHERE ItemUID = @FromItemUID
				
				SET @ItemUID = SCOPE_IDENTITY()
				
				-- 아이템 속성 정보 입력
				IF EXISTS (SELECT * FROM dbo.GItemAttribute WITH(NOLOCK) WHERE ItemUID = @FromItemUID ) BEGIN
					SET @Result = -12
					INSERT INTO dbo.GItemAttribute ( ItemUID, SlotNo, Attribute, UnitUID )
					SELECT @ItemUID, SlotNo, Attribute, @ToUnitUID
					FROM dbo.GItemAttribute WITH(NOLOCK)
					WHERE ItemUID = @FromItemUID
						AND UnitUID = @FromUnitUID
				END

				-- 아이템 강화 정보 입력
				IF EXISTS (SELECT * FROM dbo.GItemEnchant WITH(NOLOCK) WHERE ItemUID = @FromItemUID ) BEGIN
					SET @Result = -13
					INSERT INTO dbo.GItemEnchant ( ItemUID, ELevel, UnitUID )
					SELECT @ItemUID, ELevel, @ToUnitUID
					FROM dbo.GItemEnchant WITH(NOLOCK)
					WHERE ItemUID = @FromItemUID
				END
				
				-- 아이템 기간 정보 입력
				IF EXISTS (SELECT * FROM dbo.GItemPeriod WITH(NOLOCK) WHERE ItemUID = @FromItemUID ) BEGIN
					SET @Result = -14
					INSERT INTO dbo.GItemPeriod ( ItemUID, Period, ExpirationDate, UnitUID )
					SELECT @ItemUID, Period, ExpirationDate, @ToUnitUID
					FROM dbo.GItemPeriod WITH(NOLOCK)
					WHERE ItemUID = @FromItemUID
				END
				
				-- 아이템 소켓 정보 입력
				IF EXISTS (SELECT * FROM dbo.GItemSocket WITH(NOLOCK) WHERE ItemUID = @FromItemUID ) BEGIN
					SET @Result = -15
					INSERT INTO dbo.GItemSocket ( ItemUID, Socket1, Socket2, Socket3, Socket4, UnitUID )
					SELECT @ItemUID, Socket1, Socket2, Socket3, Socket4, @ToUnitUID
					FROM dbo.GItemSocket WITH(NOLOCK)
					WHERE ItemUID = @FromItemUID
				END
				
				-- 아이템 봉인 정보 입력
				IF @ToSealCnt <> 0 BEGIN
					SET @Result = -16
					INSERT INTO dbo.GItemSeal ( ItemUID, SealCnt )
					VALUES ( @ItemUID, @ToSealCnt )
				END
				
			COMMIT TRAN
			SET @Result = 0
		END TRY
		BEGIN CATCH
			DECLARE @NO_XACT_STATE		smallint
			SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

			IF @NO_XACT_STATE <> 0
				ROLLBACK TRAN

			IF @Result = 0 OR @Result IS NULL
				SET @Result = -1

			RAISERROR(N'[Result : %d]P_GItem_Trade_BankItem %I64d, %I64d, %I64d, %d, %d, %d, %d', 15, 1, @Result, @FromUnitUID, @ToUnitUID, @FromItemUID, @ToInventoryCategory, @ToSlotID, @ToSealCnt, @Deleted) WITH LOG
		END CATCH
	END

	SELECT @Result AS Result, @ItemUID AS ToItemUID, @getdate AS RegDate
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GItem_INT_DEL_New]
	@UnitUID_S		bigint ,	-- 주는 사람
	@UnitUID_R		bigint ,	-- 받는 사람
	@Quantity		int,		-- 거래 개수(수량성 아이템이 아니라면 0)
	@ItemUID_Old	bigint ,	-- 주는 사람 아이템의 UID
	@InsertType		tinyint ,	-- 생성 사유
	@Reason			tinyint,	-- 삭제 사유
	@ItemUID		bigint = 0 OUTPUT
AS
	SET NOCOUNT ON
	
	DECLARE @Result			int
	
	DECLARE @sdtNow			datetime
		,	@sdtEndDate		smalldatetime
		,	@ItemID			int
		,	@UsageType		tinyint
		,	@Quantity_Old	int
		
	SET @sdtNow = CURRENT_TIMESTAMP
	
	SELECT @ItemID = ItemID, @UsageType = UsageType, @Quantity_Old = Quantity
		FROM dbo.GItem WITH(NOLOCK)
			WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_Old
		
	-- 해당아이템이 없는 경우.
	IF @@ROWCOUNT = 0
		SET @Result = -1
	ELSE IF @UsageType = 2 AND @Quantity_Old - @Quantity < 0
		SET @Result = -2
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN
			
			-- 아이템 등록
			SET @Result = -11
			
			INSERT INTO dbo.GItem ( UnitUID, ItemID, InventoryCategory, UsageType, Quantity, Endurance, SlotID, RegDate, Inserted )
			SELECT @UnitUID_R, @ItemID, 0, @UsageType
				, CASE WHEN @UsageType = 2 THEN @Quantity ELSE 0 END
				, CASE WHEN @UsageType = 1 THEN 10000 ELSE -1 END
				, 0
				, @sdtNow
				, @InsertType

			SET @ItemUID = SCOPE_IDENTITY()
			
			-- 강화 레벨 옮기기
			IF EXISTS ( SELECT * FROM dbo.GItemEnchant WITH( NOLOCK ) WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_Old ) BEGIN
				SET @Result = -12
				
				INSERT INTO dbo.GItemEnchant ( UnitUID, ItemUID, Elevel )
				SELECT @UnitUID_R, @ItemUID, Elevel
					FROM dbo.GItemEnchant WITH(NOLOCK)
						WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_Old
			END
			
			-- 속성 옮기기
			IF EXISTS ( SELECT * FROM dbo.GItemAttribute WITH( NOLOCK ) WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_Old ) BEGIN
				SET @Result = -13
				
				INSERT INTO dbo.GItemAttribute ( UnitUID, ItemUID, SlotNo, Attribute )
				SELECT @UnitUID_R, @ItemUID, SlotNo, Attribute
					FROM dbo.GItemAttribute WITH(NOLOCK)
						WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_Old
			END
			
			-- 소켓 옮기기
			IF EXISTS ( SELECT * FROM dbo.GItemSocket WITH( NOLOCK ) WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_Old ) BEGIN
				SET @Result = -14
				
				INSERT INTO dbo.GItemSocket ( UnitUID, ItemUID, Socket1, Socket2, Socket3, Socket4 )
				SELECT @UnitUID_R, @ItemUID, Socket1, Socket2, Socket3, Socket4
					FROM dbo.GItemSocket WITH(NOLOCK)
						WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_Old
			END
			
			-- 랜덤소켓 옮기기
			IF EXISTS ( SELECT * FROM dbo.GItemSocket_Random WITH( NOLOCK ) WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_Old ) BEGIN
				SET @Result = -14
				
				INSERT INTO dbo.GItemSocket_Random ( UnitUID, ItemUID, Socket1, Socket2, Socket3, Socket4, Socket5 )
				SELECT @UnitUID_R, @ItemUID, Socket1, Socket2, Socket3, Socket4, Socket5
					FROM dbo.GItemSocket_Random WITH(NOLOCK)
						WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_Old
			END
			
			-- 봉인횟수 옮기기
			IF EXISTS ( SELECT * FROM dbo.GItemSeal WITH( NOLOCK ) WHERE ItemUID = @ItemUID_Old AND SealCnt >= 100) BEGIN
				SET @Result = -15
				
				INSERT INTO dbo.GItemSeal ( ItemUID, SealCnt )
				SELECT @ItemUID, SealCnt - 100
					FROM dbo.GItemSeal WITH(NOLOCK)
						WHERE ItemUID = @ItemUID_Old
			END
			
			--> 여기서 부터 아이템 삭제처리
			-- 장비 아이템이나 악세사리(내구도가 없지만 수량성은 아닌 아이템)
			IF @UsageType IN (0, 1) BEGIN
				SET @Result = -16
				
				DELETE dbo.GItem
					OUTPUT DELETED.ItemUID, DELETED.UnitUID, DELETED.ItemID, DELETED.InventoryCategory, DELETED.SlotID, DELETED.UsageType, DELETED.Quantity, DELETED.Endurance, DELETED.Inserted, DELETED.RegDate, GETDATE(), @Reason
					INTO dbo.GItem_Log ( ItemUID, UnitUID, ItemID, InventoryCategory, SlotID, UsageType, Quantity, Endurance, Inserted, RegDate, DelDate, Deleted )
				WHERE ItemUID = @ItemUID_Old
			END
			
			-- 수량성 아이템의 수량 변경
			ELSE IF @UsageType = 2 AND (@Quantity_Old - @Quantity) > 0 BEGIN
				SET @Result = -17
				
				UPDATE dbo.GItem
					SET Quantity = Quantity - @Quantity
						WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_Old					
				END
			
			-- 수량성 아이템 삭제(한 슬롯의 전체 수량을 거래했을 경우)
			ELSE IF @UsageType = 2 AND (@Quantity_Old - @Quantity) = 0 BEGIN
				SET @Result = -18
				
				DELETE dbo.GItem
					OUTPUT DELETED.ItemUID, DELETED.UnitUID, DELETED.ItemID, DELETED.InventoryCategory, DELETED.SlotID, DELETED.UsageType, DELETED.Quantity, DELETED.Endurance, DELETED.Inserted, DELETED.RegDate, GETDATE(), @Reason
					INTO dbo.GItem_Log ( ItemUID, UnitUID, ItemID, InventoryCategory, SlotID, UsageType, Quantity, Endurance, Inserted, RegDate, DelDate, Deleted )
				WHERE ItemUID = @ItemUID_Old		
			END

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
	END

	RETURN @Result
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GItem_INT_DEL]
	@UnitUID_S		bigint ,	-- 주는 사람
	@UnitUID_R		bigint ,	-- 받는 사람
	@Quantity		int,	-- 거래 개수(수량성 아이템이 아니라면 0)
	@ItemUID_Old	bigint ,		-- 주는 사람 아이템의 UID
	@InsertType		tinyint ,	-- 생성 사유
	@Reason			tinyint,	-- 삭제 사유
	@ItemUID		bigint = 0 OUTPUT
AS
	SET NOCOUNT ON
	
	DECLARE @Result			int
	
	DECLARE @sdtNow			datetime
		,	@sdtEndDate		smalldatetime
		,	@ItemID			int
		,	@UsageType		tinyint
		,	@Quantity_Old	int
		
	SET @sdtNow = CURRENT_TIMESTAMP
	
	SELECT @ItemID = ItemID, @UsageType = UsageType, @Quantity_Old = Quantity
		FROM dbo.GItem WITH(NOLOCK)
			WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_Old
		
	-- 해당아이템이 없는 경우.
	IF @@ROWCOUNT = 0
		SET @Result = -1
	ELSE IF @UsageType = 2 AND @Quantity_Old - @Quantity < 0
		SET @Result = -2
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN
			
			-- 아이템 등록
			SET @Result = -11
			
			INSERT INTO dbo.GItem ( UnitUID, ItemID, InventoryCategory, UsageType, Quantity, Endurance, SlotID, Inserted, RegDate )
			SELECT @UnitUID_R, @ItemID, 0, @UsageType
				, CASE WHEN @UsageType = 2 THEN @Quantity ELSE 0 END
				, CASE WHEN @UsageType = 1 THEN 10000 ELSE -1 END
				, 0
				, @InsertType
				, @sdtNow

			SET @ItemUID = @@IDENTITY
			
			-- 강화 레벨 옮기기
			IF EXISTS ( SELECT * FROM dbo.GItemEnchant WITH( NOLOCK ) WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_Old ) BEGIN
				SET @Result = -12
				
				INSERT INTO dbo.GItemEnchant ( UnitUID, ItemUID, Elevel )
				SELECT @UnitUID_R, @ItemUID, Elevel
					FROM dbo.GItemEnchant WITH(NOLOCK)
						WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_Old
			END
			
			-- 속성 옮기기
			IF EXISTS ( SELECT * FROM dbo.GItemAttribute WITH( NOLOCK ) WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_Old ) BEGIN
				SET @Result = -13
				
				INSERT INTO dbo.GItemAttribute ( UnitUID, ItemUID, SlotNo, Attribute )
				SELECT @UnitUID_R, @ItemUID, SlotNo, Attribute
					FROM dbo.GItemAttribute WITH(NOLOCK)
						WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_Old
			END
			
			-- 소켓 옮기기
			IF EXISTS ( SELECT * FROM dbo.GItemSocket WITH( NOLOCK ) WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_Old ) BEGIN
				SET @Result = -14
				
				INSERT INTO dbo.GItemSocket ( UnitUID, ItemUID, Socket1, Socket2, Socket3, Socket4 )
				SELECT @UnitUID_R, @ItemUID, Socket1, Socket2, Socket3, Socket4
					FROM dbo.GItemSocket WITH(NOLOCK)
						WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_Old
			END
			
			-- 봉인횟수 옮기기
			IF EXISTS ( SELECT * FROM dbo.GItemSeal WITH( NOLOCK ) WHERE ItemUID = @ItemUID_Old AND SealCnt >= 100) BEGIN
				SET @Result = -15
				
				INSERT INTO dbo.GItemSeal ( ItemUID, SealCnt )
				SELECT @ItemUID, SealCnt - 100
					FROM dbo.GItemSeal WITH(NOLOCK)
						WHERE ItemUID = @ItemUID_Old
			END
			
			--> 여기서 부터 아이템 삭제처리
			-- 장비 아이템이나 악세사리(내구도가 없지만 수량성은 아닌 아이템)
			IF @UsageType IN (0, 1) BEGIN
				SET @Result = -16
				
				DELETE dbo.GItem
					OUTPUT DELETED.ItemUID, DELETED.UnitUID, DELETED.ItemID, DELETED.InventoryCategory, DELETED.SlotID, DELETED.UsageType, DELETED.Quantity, DELETED.Endurance, DELETED.Inserted, DELETED.RegDate, GETDATE(), @Reason
					INTO dbo.GItem_Log ( ItemUID, UnitUID, ItemID, InventoryCategory, SlotID, UsageType, Quantity, Endurance, Inserted, RegDate, DelDate, Deleted )
				WHERE ItemUID = @ItemUID_Old
			END
			
			-- 수량성 아이템의 수량 변경
			ELSE IF @UsageType = 2 AND (@Quantity_Old - @Quantity) > 0 BEGIN
				SET @Result = -17
				
				UPDATE dbo.GItem
					SET Quantity = Quantity - @Quantity
						WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_Old					
				END
			
			-- 수량성 아이템 삭제(한 슬롯의 전체 수량을 거래했을 경우)
			ELSE IF @UsageType = 2 AND (@Quantity_Old - @Quantity) = 0 BEGIN
				SET @Result = -18
				
				DELETE dbo.GItem
					OUTPUT DELETED.ItemUID, DELETED.UnitUID, DELETED.ItemID, DELETED.InventoryCategory, DELETED.SlotID, DELETED.UsageType, DELETED.Quantity, DELETED.Endurance, DELETED.Inserted, DELETED.RegDate, GETDATE(), @Reason
					INTO dbo.GItem_Log ( ItemUID, UnitUID, ItemID, InventoryCategory, SlotID, UsageType, Quantity, Endurance, Inserted, RegDate, DelDate, Deleted )
				WHERE ItemUID = @ItemUID_Old		
			END

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
	END

	RETURN @Result
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GItem_INT]
	@UnitUID_S		bigint ,	-- 주는 사람
	@UnitUID_R		bigint ,	-- 받는 사람
	@Quantity		smallint,	-- 거래 개수(수량성 아이템이 아니라면 0)
	@ItemUID_Old	int ,		-- 주는 사람 아이템의 UID
	@InsertType		tinyint ,
	@Result			int = 0 OUTPUT ,
	@ItemUID		bigint = 0 OUTPUT
AS
	SET NOCOUNT ON
	
	DECLARE @sdtNow		datetime
	,	@sdtEndDate		smalldatetime
	,	@ItemID			int
	,	@UsageType		tinyint
		
	SET @sdtNow = GETDATE()
	
	SELECT @ItemID = ItemID, @UsageType = UsageType
		FROM dbo.GItem WITH(NOLOCK)
			WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_Old
		
	-- 해당아이템이 있는 경우.
	IF EXISTS ( SELECT * FROM dbo.GItem WITH( NOLOCK ) WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_Old ) BEGIN
		BEGIN TRY
			BEGIN TRAN
			
			-- 아이템 등록
			SET @Result = -11
			
			INSERT INTO dbo.GItem ( UnitUID, ItemID, InventoryCategory, UsageType, Quantity, Endurance, SlotID, Inserted, RegDate )
			SELECT @UnitUID_R, @ItemID, 0, @UsageType
				, CASE WHEN @UsageType = 2 THEN @Quantity ELSE 0 END
				, CASE WHEN @UsageType = 1 THEN 10000 ELSE -1 END
				, 0
				, @InsertType
				, @sdtNow

			SET @ItemUID = @@IDENTITY
			
			-- 강화 레벨 옮기기
			IF EXISTS ( SELECT * FROM dbo.GItemEnchant WITH( NOLOCK ) WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_Old ) BEGIN
				SET @Result = -12
				
				INSERT INTO dbo.GItemEnchant ( UnitUID, ItemUID, Elevel )
				SELECT @UnitUID_R, @ItemUID, Elevel
					FROM dbo.GItemEnchant WITH(NOLOCK)
						WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_Old
			END
			
			-- 속성 옮기기
			IF EXISTS ( SELECT * FROM dbo.GItemAttribute WITH( NOLOCK ) WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_Old ) BEGIN
				SET @Result = -13
				
				INSERT INTO dbo.GItemAttribute ( UnitUID, ItemUID, SlotNo, Attribute )
				SELECT @UnitUID_R, @ItemUID, SlotNo, Attribute
					FROM dbo.GItemAttribute WITH(NOLOCK)
						WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_Old
			END
			
			-- 소켓 옮기기
			IF EXISTS ( SELECT * FROM dbo.GItemSocket WITH( NOLOCK ) WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_Old ) BEGIN
				SET @Result = -14
				
				INSERT INTO dbo.GItemSocket ( UnitUID, ItemUID, Socket1, Socket2, Socket3, Socket4 )
				SELECT @UnitUID_R, @ItemUID, Socket1, Socket2, Socket3, Socket4
					FROM dbo.GItemSocket WITH(NOLOCK)
						WHERE UnitUID = @UnitUID_S AND ItemUID = @ItemUID_Old
			END
			
			-- 봉인횟수 옮기기
			IF EXISTS ( SELECT * FROM dbo.GItemSeal WITH( NOLOCK ) WHERE ItemUID = @ItemUID_Old AND SealCnt >= 100) BEGIN
				SET @Result = -15
				
				INSERT INTO dbo.GItemSeal ( ItemUID, SealCnt )
				SELECT @ItemUID, SealCnt - 100
					FROM dbo.GItemSeal WITH(NOLOCK)
						WHERE ItemUID = @ItemUID_Old
			END
			
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
	END
	ELSE
		SET @Result = -1
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GItem_GET_BankItem_New]
	@UnitUID			bigint
AS
	SET NOCOUNT ON

	SELECT
		ITM.ItemUID
	,	ITM.ItemID
	,   ITM.UsageType
	,	ISNULL(ITM.Quantity, 0) AS Quantity
	,	ISNULL(ITM.Endurance, -1) AS Endurance
	,	ISNULL(PER.Period, 0) AS Period
	,	PER.ExpirationDate
	,	ISNULL(ENC.Elevel, 0) AS Elevel
	,	ISNULL(SOC.Socket1, 0) AS Socket1
	,	ISNULL(SOC.Socket2, 0) AS Socket2
	,	ISNULL(SOC.Socket3, 0) AS Socket3
	,	ISNULL(SOC.Socket4, 0) AS Socket4
	,	ISNULL(RSC.Socket1, 0) AS RSocket1
	,	ISNULL(RSC.Socket2, 0) AS RSocket2
	,	ISNULL(RSC.Socket3, 0) AS RSocket3
	,	ISNULL(RSC.Socket4, 0) AS RSocket4
	,	ISNULL(RSC.Socket5, 0) AS RSocket5
	,	ITM.InventoryCategory
	,	ITM.SlotID
	FROM dbo.GItem						AS ITM WITH(NOLOCK)
	LEFT OUTER JOIN dbo.GItemEnchant	AS ENC WITH(NOLOCK) ON ENC.UnitUID = @UnitUID AND ITM.ItemUID = ENC.ItemUID  --//CL
	LEFT OUTER JOIN dbo.GItemPeriod		AS PER WITH(NOLOCK) ON PER.UnitUID = @UnitUID AND ITM.ItemUID = PER.ItemUID  --//NC
	LEFT OUTER JOIN dbo.GItemSocket		AS SOC WITH(NOLOCK) ON SOC.UnitUID = @UnitUID AND ITM.ItemUID = SOC.ItemUID  --//NC
	LEFT OUTER JOIN dbo.GItemSocket_Random	AS RSC WITH(NOLOCK) ON RSC.UnitUID = @UnituID AND ITM.ItemUID = RSC.ItemUID
	WHERE ITM.UnitUID = @UnitUID
		AND ITM.Inventorycategory = 8
GO
-- =============================================
-- Author:		KOG. B.K
-- Create date: 2011. 10.18
-- Description:	캐릭터 은행아이템 목록
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GItem_GET_BankItem]
	@UnitUID			bigint
AS
	SET NOCOUNT ON

	SELECT
		ITM.ItemUID
	,	ITM.ItemID
	,   ITM.UsageType
	,	ISNULL(ITM.Quantity, 0) AS Quantity
	,	ISNULL(ITM.Endurance, -1) AS Endurance
	,	ISNULL(PER.Period, 0) AS Period
	,	PER.ExpirationDate
	,	ISNULL(ENC.Elevel, 0) AS Elevel
	,	ISNULL(SOC.Socket1, 0) AS Socket1
	,	ISNULL(SOC.Socket2, 0) AS Socket2
	,	ISNULL(SOC.Socket3, 0) AS Socket3
	,	ISNULL(SOC.Socket4, 0) AS Socket4
	,	ITM.InventoryCategory
	,	ITM.SlotID
	FROM dbo.GItem						AS ITM WITH(NOLOCK)
	LEFT OUTER JOIN dbo.GItemEnchant	AS ENC WITH(NOLOCK) ON ENC.UnitUID = @UnitUID AND ITM.ItemUID = ENC.ItemUID  --//CL
	LEFT OUTER JOIN dbo.GItemPeriod		AS PER WITH(NOLOCK) ON PER.UnitUID = @UnitUID AND ITM.ItemUID = PER.ItemUID  --//NC
	LEFT OUTER JOIN dbo.GItemSocket		AS SOC WITH(NOLOCK) ON SOC.UnitUID = @UnitUID AND ITM.ItemUID = SOC.ItemUID  --//NC
	WHERE ITM.UnitUID = @UnitUID
		AND ITM.Inventorycategory = 8
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GItem_DEL]
	@UnitUID	bigint
,   @ItemUID	bigint
,	@Quantity	smallint
,	@Reason		tinyint
,	@Result		int = 0 OUTPUT
AS
	SET NOCOUNT ON

	DECLARE	@UsageType		tinyint
		,	@Quantity_Old	smallint
	
	SELECT @UsageType = UsageType, @Quantity_Old = Quantity
		FROM dbo.GItem WITH(NOLOCK)
			WHERE UnitUID = @UnitUID AND ItemUID = @ItemUID
			
	IF @UsageType = 2 AND @Quantity_Old - @Quantity < 0
		SET @Result = -1
	ELSE IF EXISTS ( SELECT * FROM dbo.GItem WITH(NOLOCK) WHERE UnitUID = @UnitUID AND ItemUID = @ItemUID ) BEGIN
		BEGIN TRY
			BEGIN TRAN
			
				SET @Result = -2
				
				IF @UsageType IN (0, 1) BEGIN
				
					DELETE dbo.GItem
						OUTPUT DELETED.ItemUID, DELETED.UnitUID, DELETED.ItemID, DELETED.InventoryCategory, DELETED.SlotID, DELETED.UsageType, DELETED.Quantity, DELETED.Endurance, DELETED.Inserted, DELETED.RegDate, GETDATE(), @Reason
						INTO dbo.GItem_Log ( ItemUID, UnitUID, ItemID, InventoryCategory, SlotID, UsageType, Quantity, Endurance, Inserted, RegDate, DelDate, Deleted )
					WHERE ItemUID = @ItemUID
					
				END
				
				ELSE IF @UsageType = 2 AND (@Quantity_Old - @Quantity) > 0 BEGIN
				
					UPDATE dbo.GItem
						SET Quantity = Quantity - @Quantity
							WHERE UnitUID = @UnitUID AND ItemUID = @ItemUID	
										
				END

				ELSE IF @UsageType = 2 AND (@Quantity_Old - @Quantity) = 0 BEGIN
				
					DELETE dbo.GItem
						OUTPUT DELETED.ItemUID, DELETED.UnitUID, DELETED.ItemID, DELETED.InventoryCategory, DELETED.SlotID, DELETED.UsageType, DELETED.Quantity, DELETED.Endurance, DELETED.Inserted, DELETED.RegDate, GETDATE(), @Reason
						INTO dbo.GItem_Log ( ItemUID, UnitUID, ItemID, InventoryCategory, SlotID, UsageType, Quantity, Endurance, Inserted, RegDate, DelDate, Deleted )
					WHERE ItemUID = @ItemUID
									
				END

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
	END
	ELSE
		SET @Result = -3
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GItem_Check]
	@ItemUID			bigint
,	@UnitUID			bigint
AS
	SET NOCOUNT ON

	IF EXISTS (SELECT * FROM dbo.GItem WITH(NOLOCK) WHERE ItemUID = @ItemUID AND UnitUID = @UnitUID)
		SELECT 0 AS Result
	ELSE
		SELECT -1 AS Result
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GGuild_Name_UPT]
       @GuildNo			INT
,      @GuildName		NVARCHAR(30)
AS
	SET NOCOUNT ON
/*
	길드명 변경
	과거 길드명 7일 이내에는 사용할 수 없도록 처리
*/
	DECLARE @Result			int
		,	@OldGuildName	NVARCHAR(30)
	
	SELECT @OldGuildName = GuildName FROM dbo.GGuild WITH(NOLOCK) WHERE GuildNo = @GuildNo
	
	-- GuildNo에 해당하는 길드 존재 여부확인
	IF NOT EXISTS ( SELECT * FROM dbo.GGuild WITH(NOLOCK) WHERE GuildNo = @GuildNo ) BEGIN
		SET @Result	= -1
	END
	-- 길드이름 중복 확인
	ELSE IF EXISTS ( SELECT * FROM dbo.GGuild WITH(NOLOCK) WHERE GuildName = @GuildName ) BEGIN
		SET @Result	= -2
	END
	-- 7일 이내 사용할 수 없는 길드 이름 체크
	ELSE IF EXISTS ( SELECT * FROM dbo.GGuild_Deleted WITH(NOLOCK) WHERE GuildName = @GuildName AND DelDate > DATEADD(dd, -7, GETDATE()) ) BEGIN
		SET @Result	= -3
	END
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN
	
				-- 길드명 바꿔주기 & 7일 이내 과거 길드명 사용하지 못하게 처리
				UPDATE dbo.GGuild
				SET GuildName = @GuildName
					OUTPUT @GuildNo, @OldGuildName, GETDATE()
					INTO dbo.GGuild_Deleted ( GuildNo, GuildName, DelDate )
				WHERE GuildNo = @GuildNo
				
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
				SET @Result = -4
		END CATCH
	END

	SELECT ISNULL(@Result, 0) AS Result
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GGuild_Name_CHK]
      @GuildName          NVARCHAR(30)
/*
	길드명 중복 체크 및 7일이내 사용불가 길드명인지 체크
	(서버 루틴때문에 여기서 한번 체크하고 실제로 길드명 변경될 때 한번 더 체크됨)
	길드명 변경권은 캐시샵에서 사용됨
*/
AS
	SET NOCOUNT ON

	-- 기존 파라미터에서 변수로 변경
	DECLARE @Result		int

	--	같은 이름의 길드가 있는지
	IF EXISTS ( SELECT * FROM dbo.GGuild WITH(NOLOCK) WHERE GuildName = @GuildName )
		SET @Result = -1
	--	동일 이름으로 7일 이내 삭제된 길드가 있는지
	ELSE IF EXISTS ( SELECT * FROM dbo.GGuild_Deleted WITH(NOLOCK) WHERE GuildName = @GuildName AND DelDate > DATEADD(dd, -7, GETDATE()) )
		SET @Result = -2
	ELSE
		SET @Result = 0

	SELECT ISNULL(@Result, 0) AS Result
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.03.25
-- Description:	길드 정보 읽기
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GGuild_Member_GET]
	@iGuildNo		INT

AS

SET NOCOUNT ON;


SELECT a.UnitUID, a.UserUID, b.NickName, a.UnitClass, a.LEVEL, ISNULL(d.Spirit, 0) as Spirit, ISNULL(d.AP, 0) as AP, c.State, c.LastDate, c.MESSAGE
	FROM dbo.GGuild_Member AS c WITH (NOLOCK)
		JOIN dbo.GUnit AS a WITH (NOLOCK)
			ON c.UnitUID = a.UnitUID
		JOIN dbo.GUnitNickName AS b WITH (NOLOCK)
			ON b.UnitUID = c.UnitUID
		LEFT OUTER JOIN dbo.GFriendSystem_UnitInfo AS d WITH(NOLOCK)
			ON c.UnitUID = d.UnitUID
	WHERE c.GuildNo = @iGuildNo AND a.Deleted = 0
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.03.15
-- Description:	유닛 정보 쓰기
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GFriendSystem_UnitInfo_INS]
	@UnitUID	bigint
,	@Spirit		int
,	@AP			int

AS
	SET NOCOUNT ON;

	DECLARE @Result		int
	
	IF NOT EXISTS ( SELECT UnitUID FROM dbo.GUnit WITH(NOLOCK) WHERE UnitUID = @UnitUID ) BEGIN
		SET @Result = -1
	END
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN
				
				IF NOT EXISTS ( SELECT UnitUID FROM dbo.GFriendSystem_UnitInfo WITH(NOLOCK) WHERE UnitUID = @UnitUID ) BEGIN

					SET @Result = -2
					-- 유닛 정보가 없다면 인설트
					INSERT INTO dbo.GFriendSystem_UnitInfo ( UnitUID, Spirit, AP )
					VALUES ( @UnitUID, @Spirit, @AP )
					
				END
				ELSE BEGIN

					SET @Result = -3
					-- 이미 유닛 정보가 있다면 업데이트
					UPDATE dbo.GFriendSystem_UnitInfo
					SET Spirit = Spirit + @Spirit
					  , AP = @AP + @AP
					WHERE UnitUID = @UnitUID
					
				END

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
-- Description:	유닛 정보 읽기
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GFriendSystem_UnitInfo_GET]
	@UnitUID	bigint
	
AS
	SET NOCOUNT ON;
	
	DECLARE @Result		int
	DECLARE @Spirit		int
	DECLARE @AP			int
	DECLARE @NickName	nvarchar(20)
	DECLARE	@Level		tinyint
	DECLARE	@UnitClass	tinyint
	DECLARE	@Num		int
	
	SELECT @Num = Num FROM dbo.GFriendSystem_LastReset WITH(NOLOCK)
	
	SELECT @NickName = C.NickName, @Level = B.Level, @UnitClass = B.UnitClass
		FROM dbo.GUnit as B WITH(NOLOCK)
		JOIN dbo.GUnitNickName AS C WITH(NOLOCK)
			ON B.UnitUID = C.UnitUID
			WHERE B.UnitUID = @UnitUID AND B.Deleted = 0
	
	SELECT @Spirit = Spirit, @AP = AP 
		FROM dbo.GFriendSystem_UnitInfo WITH(NOLOCK)
			WHERE UnitUID = @UnitUID

	IF @@ROWCOUNT = 1
		SELECT 0 as 'Result', @Num as 'Num', @NickName as 'NickNam', @Level as 'Level', @UnitClass as 'UnitClass', @Spirit as 'Spirit', @AP as 'AP'
	ELSE 
		SELECT 0 as 'Result', @Num as 'Num', @NickName as 'NickNam', @Level as 'Level', @UnitClass as 'UnitClass', 0 as 'Spirit', 0 as 'AP'
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.03.15
-- Description: 랭킹 초기화(주간)
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GFriendSystem_Reset]
	@Num		int

AS
	SET NOCOUNT ON;
	
	DECLARE @Result			int
	DECLARE @LastResetDate	smalldatetime
	SET @LastResetDate = GETDATE()
	
	BEGIN TRY
		BEGIN TRAN
			
			SET @Result = -1
			
			UPDATE dbo.GFriendSystem_LastReset
			SET Num = @Num
			  , LastResetDate = @LastResetDate
			  
			SET @Result = -2
			
			DELETE FROM dbo.GFriendSystem_Ranker
			WHERE UnitUID > 0
			
			SET @Result = -3
			
			UPDATE dbo.GFriendSystem_UnitInfo
			SET Spirit = 0
			  , AP = 0

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
CREATE OR ALTER PROCEDURE [dbo].[P_GFriendSystem_RankerInfo_GET]

AS
	SET NOCOUNT ON;

	SELECT A.UnitUID, B.UserUID
	FROM dbo.GFriendSystem_Ranker AS A WITH(NOLOCK)
	JOIN dbo.GUnit AS B WITH(NOLOCK)
		ON A.UnitUID = B.UnitUID
	WHERE B.Deleted = 0
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.03.15
-- Description:	랭커 정보 쓰기
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GFriendSystem_Ranker_INS]
	@UnitUID	bigint

AS
	SET NOCOUNT ON;
	
	DECLARE @Result			int
	-- 이미 랭커이면, 1 반환
	IF EXISTS ( SELECT UnitUID FROM dbo.GFriendSystem_Ranker WITH(NOLOCK) WHERE UnitUID = @UnitUID ) BEGIN
		SET @Result = 1
	END
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN
				
				SET @Result = -1
				
				INSERT INTO dbo.GFriendSystem_Ranker ( UnitUID )
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
CREATE OR ALTER PROCEDURE [dbo].[P_GFriendSystem_Ranker_DEL]
	@UnitUID	bigint

AS
	SET NOCOUNT ON;
	
	DECLARE @Result			int

	BEGIN TRY
		BEGIN TRAN
			
			SET @Result = -1
			
			DELETE FROM dbo.GFriendSystem_Ranker
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
-- Author:		HWANG
-- Create date: 2013.04.08
-- Description:	오프라인 유저 정보 읽어가기(살펴보기) 및 UserUID 얻기
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GFriendSystem_LogoffUserInfo_GET]
	@UnitUID	bigint

AS
	SET NOCOUNT ON;
	
	IF EXISTS ( SELECT UnitUID FROM dbo.GUnit WITH(NOLOCK) WHERE UnitUID = @UnitUID AND Deleted = 0 ) BEGIN
	
		SELECT 0 AS 'Result', A.UserUID, B.NickName, A.Level, A.UnitClass
			FROM dbo.GUnit AS A WITH(NOLOCK)
			JOIN dbo.GUnitNickName AS B WITH(NOLOCK)
			ON A.UnitUID = B.UnitUID
				WHERE A.UnitUID = @UnitUID AND A.Deleted = 0
			
	END
	ELSE BEGIN
		SELECT -1 AS 'Result', 0 AS 'UserUID', N'' AS 'NickName', 0 AS 'Level', 0 AS 'UnitClass'
	END
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.03.15
-- Description:	시스템 정보 읽기
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GFriendSystem_LastReset_GET]

AS
	SET NOCOUNT ON;
	
	DECLARE @Result			int

	IF EXISTS ( SELECT TOP 1 * FROM dbo.GFriendSystem_LastReset WITH(NOLOCK) ) BEGIN

		SELECT Num, LastResetDate
			FROM dbo.GFriendSystem_LastReset WITH(NOLOCK)
	END
	-- 최초 읽어가는 시점에 인설트
	ELSE BEGIN
	
		SET @Result = -1
		
		INSERT INTO dbo.GFriendSystem_LastReset ( Num, LastResetDate )
		VALUES ( 0, '2013-01-01 00:00:00')
		
		SELECT  0, '2013-01-01 00:00:00'
	
	END
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GEventTradeCount_UPD]
	@UnitUID	BIGINT
AS
SET NOCOUNT ON

	DECLARE @Count INT
	SET @Count = 0

	UPDATE dbo.GEventTradeCount
	SET @Count = Count = Count + 1
	WHERE UnitUID = @UnitUID
	
	IF @@ROWCOUNT = 0
	BEGIN
		INSERT INTO dbo.GEventTradeCount(UnitUID, Count, LastDate)
		SELECT @UnitUID, 1, GETDATE()
		
		SET @Count = 1
	END

	SELECT @Count
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GEventTradeCount_GET]
	@UnitUID	BIGINT
AS
SET NOCOUNT ON

DECLARE @Count INT


SELECT @Count = Count
FROM dbo.GEventTradeCount WITH(NOLOCK)
WHERE UnitUID = @UnitUID

SELECT ISNULL(@Count, 0) AS [Count]
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GEventRavenSpirit_SET]
	@UnitUID	BIGINT
,	@RagePoint	INT
,	@PeacePoint	INT
AS

SET NOCOUNT ON

UPDATE dbo.GEventRavenSpirit
SET RagePoint = @RagePoint
,	PeacePoint = @PeacePoint
WHERE UnitUID = @UnitUID

IF @@ROWCOUNT = 0
BEGIN
	INSERT INTO dbo.GEventRavenSpirit(UnitUID, RagePoint, PeacePoint)
	SELECT @UnitUID, @RagePoint, @PeacePoint
END
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GEventRavenSpirit_GET]
	@UnitUID	BIGINT
AS

SELECT RagePoint, PeacePoint
FROM dbo.GEventRavenSpirit WITH(NOLOCK)
WHERE UnitUID = @UnitUID
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GEventNewYear_SET]
	@UserUID		BIGINT
,	@UnitUID		BIGINT
,	@StepID			TINYINT
AS

SET NOCOUNT ON

DECLARE @Result		int

BEGIN TRY
	BEGIN TRAN

	IF @StepID = 1
	BEGIN
		SET @Result = -1
		
		INSERT INTO dbo.GEventNewYear(UserUID, UnitUID, StepID, LastDate)
		SELECT @UserUID, @UnitUID, @StepID, GETDATE()
	END
	ELSE
	BEGIN
		SET @Result = -2
		
		IF(SELECT StepID FROM dbo.GEventNewYear WITH(NOLOCK) WHERE UserUID = @UserUID AND UnitUID = @UnitUID) < @StepID
		BEGIN
			UPDATE dbo.GEventNewYear
			SET StepID = @StepID, LastDate = GETDATE()
			WHERE UserUID = @UserUID AND UnitUID = @UnitUID
		END
		ELSE
			RAISERROR(N'[Result : %d]P_GEventNewYear_SET %I64d, %I64d, %d', 15, 1, @Result, @UserUID, @UnitUID, @StepID) WITH SETERROR
			
	END
	
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
CREATE OR ALTER PROCEDURE [dbo].[P_GEventNewYear_GET]
	@UserUID	BIGINT
,	@UnitUID	BIGINT
AS

SET NOCOUNT ON

DECLARE @TargetUnitUID BIGINT
DECLARE @StepID	 SMALLINT

SELECT 
	@TargetUnitUID = UnitUID
,	@StepID = StepID
FROM dbo.GEventNewYear WITH(NOLOCK)
WHERE UserUID = @UserUID

--신규 캐릭터 조건 체크 추가

IF @@ROWCOUNT = 0
BEGIN
	IF (SELECT RegDate	FROM dbo.GUnit WITH(NOLOCK)	WHERE UnitUID = @UnitUID) < '2014-01-01'
		SET @StepID = -1
END


SELECT ISNULL(@TargetUnitUID, 0), ISNULL(@StepID, 0)
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GEventEveBuff_SET]
	@UnitUID				BIGINT
,	@BuffExpireDate_1		SMALLDATETIME
,	@BuffExpireDate_2		SMALLDATETIME
,	@BuffExpireDate_3		SMALLDATETIME
,	@BuffExpireDate_4		SMALLDATETIME
AS

SET NOCOUNT ON

DECLARE @RowCount TINYINT
SET @RowCount = 0


IF @BuffExpireDate_1 <> ''
BEGIN
	UPDATE dbo.GEventEveBuff
	SET BuffExpireDate_1 = @BuffExpireDate_1
	WHERE UnitUID = @UnitUID	
	SET @RowCount = @RowCount + @@ROWCOUNT
END

IF @BuffExpireDate_2 <> ''
BEGIN
	UPDATE dbo.GEventEveBuff
	SET BuffExpireDate_2 = @BuffExpireDate_2
	WHERE UnitUID = @UnitUID
	SET @RowCount = @RowCount + @@ROWCOUNT
END

IF @BuffExpireDate_3 <> ''
BEGIN
	UPDATE dbo.GEventEveBuff
	SET BuffExpireDate_3 = @BuffExpireDate_3
	WHERE UnitUID = @UnitUID
	SET @RowCount = @RowCount + @@ROWCOUNT
END

IF @BuffExpireDate_4 <> ''
BEGIN
	UPDATE dbo.GEventEveBuff
	SET BuffExpireDate_4 = @BuffExpireDate_4
	WHERE UnitUID = @UnitUID
	SET @RowCount = @RowCount + @@ROWCOUNT
END

IF @RowCount = 0
BEGIN
	INSERT INTO dbo.GEventEveBuff(UnitUID, BuffExpireDate_1, BuffExpireDate_2, BuffExpireDate_3, BuffExpireDate_4)
	SELECT @UnitUID, @BuffExpireDate_1, @BuffExpireDate_2, @BuffExpireDate_3, @BuffExpireDate_4
END
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GEventEveBuff_GET]
	@UnitUID	BIGINT
AS

SET NOCOUNT ON

SELECT
	BuffExpireDate_1
,	BuffExpireDate_2
,	BuffExpireDate_3
,	BuffExpireDate_4
FROM dbo.GEventEveBuff WITH(NOLOCK)
WHERE UnitUID = @UnitUID
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GEventEndYear_UPD]
	@UnitUID		BIGINT
,	@Level			TINYINT
AS

SET NOCOUNT ON

DECLARE @Result INT


--이전 보상 레벨보다 높을 때만 처리
IF (SELECT LastRewardLevel FROM dbo.GEventEndYear WITH(NOLOCK) WHERE UnitUID = @UnitUID) < @Level
BEGIN

	SET @Result = 0
	
	UPDATE dbo.GEventEndYear
	SET LastRewardLevel = @Level, LastDate = GETDATE()
	WHERE UnitUID = @UnitUID
END
ELSE
BEGIN
	SET @Result = -1
END


SELECT @Result AS Result
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GEventEndYear_GET]
	@UnitUID		BIGINT
,	@Level			TINYINT
AS

SET NOCOUNT ON

DECLARE @LastRewardLevel TINYINT

SELECT @LastRewardLevel = LastRewardLevel
FROM dbo.GEventEndYear WITH(NOLOCK)
WHERE UnitUID = @UnitUID

IF @LastRewardLevel IS NULL
BEGIN
	INSERT INTO dbo.GEventEndYear(UnitUID, LastRewardLevel, LastDate)
	SELECT @UnitUID, @Level, GETDATE()
	
	SET @LastRewardLevel = @Level
END

SELECT @LastRewardLevel
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GEventDungeonData_SET]
	@UnitUID		BIGINT
,	@DungeonID		INT
,	@PlayCount		INT
,	@SuccessCount	INT
AS

SET NOCOUNT ON

DECLARE @Result INT

SET @Result = 0

UPDATE dbo.GEventDungeonData
SET PlayCount = @PlayCount, SuccessCount = @SuccessCount
WHERE UnitUID = @UnitUID AND DungeonID = @DungeonID

IF @@ROWCOUNT = 0
BEGIN
	INSERT INTO dbo.GEventDungeonData(UnitUID, DungeonID, PlayCount, SuccessCount, LastResetTime)
	SELECT @UnitUID, @DungeonID, @PlayCount, @SuccessCount, GETDATE()
END

SELECT @Result
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GEventDungeonData_GET]
	@UnitUID	BIGINT
AS

SET NOCOUNT ON

SELECT 
	DungeonID
,	PlayCount
,	SuccessCount
FROM dbo.GEventDungeonData WITH(NOLOCK)
WHERE UnitUID = @UnitUID
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GEvent3vs3PVPData_SET]
	@UnitUID		BIGINT
,	@PlayCount		INT
,	@KillCount		INT
,	@DeathCount		INT

AS

SET NOCOUNT ON

DECLARE @Result INT

SET @Result = 0

UPDATE dbo.GEvent3vs3PVPData
SET KillCount = KillCount + @KillCount, DeathCount = DeathCount + @DeathCount
, PlayCount = PlayCount + @PlayCount, LastUpdateDate = GETDATE()
WHERE UnitUID = @UnitUID

IF(@@ROWCOUNT = 0)
BEGIN
	INSERT INTO dbo.GEvent3vs3PVPData(UnitUID, PlayCount, KillCount, DeathCount, LastUpdateDate)
	SELECT @UnitUID, @PlayCount, @KillCount, @DeathCount, GETDATE()
END

SELECT @Result
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GEvent3vs3PVPData_GET]
	@UnitUID		BIGINT
	
AS

SET NOCOUNT ON

DECLARE @PlayCount		INT
,		@KillCount		INT
,		@DeathCount		INT


SELECT @PlayCount = PlayCount, @KillCount = KillCount, @DeathCount = DeathCount
FROM dbo.GEvent3vs3PVPData WITH(NOLOCK)
WHERE UnitUID = @UnitUID

SELECT ISNULL(@PlayCount, 0), ISNULL(@KillCount, 0), ISNULL(@DeathCount, 0)
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GEvent_PreRaven_CHK]
	@UserUID	BIGINT
AS

SET NOCOUNT ON

DECLARE @Result TINYINT


IF EXISTS ( SELECT * FROM dbo.GUnit WITH(NOLOCK) WHERE Deleted = 0 AND UserUID = @UserUID AND UnitClass = 4 )
	SET @Result = 1
ELSE 
	SET @Result = 0

SELECT @Result
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GEvent_OpenRaven_CHK]
	@UnitUID	BIGINT
AS

SET NOCOUNT ON

DECLARE @Result TINYINT

IF EXISTS ( SELECT * FROM dbo.GUnit WITH(NOLOCK) WHERE UnitUID = @UnituID AND UnitClass = 4 AND RegDate < '2013-09-11 06:00' )
	SET @Result = 1
ELSE 
	SET @Result = 0

SELECT @Result
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.05.13
-- Description:	결혼 시스템 런칭 이벤트
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GEvent_Letter_INT]
	@UnitUID	bigint
,	@Message	nvarchar(700)

AS
	SET NOCOUNT ON;
	
	DECLARE @Result		int
	DECLARE @FirstCheck	bit
	DECLARE	@Now		smalldatetime
	SET @Now = CURRENT_TIMESTAMP
		
	IF NOT EXISTS ( SELECT UnitUID FROM dbo.GEvent_Letter WITH(NOLOCK) WHERE UnitUID = @UnitUID )
		SET @FirstCheck = 1
	ELSE 
		SET @FirstCheck = 0
		
	BEGIN TRY
		BEGIN TRAN

			INSERT INTO dbo.GEvent_Letter ( UnitUID, Message, RegDate )
			VALUES ( @UnitUID, @Message, @Now )
		
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

	SELECT @Result AS 'Result', @FirstCheck AS 'FirstCheck'
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GEvent_CombackUser_CHK]
	@UserUID	BIGINT
,	@UnitUID	BIGINT
,	@iOk		INT = -1
AS
SET NOCOUNT ON;

DECLARE @Result INT

DECLARE @RegDate		SMALLDATETIME
,		@LastLoginDate SMALLDATETIME

IF EXISTS (SELECT * FROM dbo.GEvent_CombackUser WITH(NOLOCK) WHERE UserUID = @UserUID) 
BEGIN

	SET @Result = 0
	
END
ELSE
BEGIN

	--SELECT	@RegDate = RegDate
	--FROM	dbo.GUser WITH(NOLOCK)
	--WHERE	UserUID = @UserUID 
	
	--IF @RegDate >= '2013-11-13 09:00'

	--	SET @Result = 2
		
	--ELSE
	
		SET @Result = 1 

END
		
SELECT @Result
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.05.15
-- Description:	옵션 정보 업데이트
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GDenyOption_UPD]
	@iUnitUID_				bigint
,	@iInsertFriendDeny_		tinyint
,	@iManToManChatDeny_ 	tinyint
,	@iPartyDeny_			tinyint
,	@iPrivateDealDeny_		tinyint
,	@iCoupleDeny_			tinyint
AS
	SET NOCOUNT ON

	-- 기존 파라미터에서 변수로 변경
	DECLARE @Result		int

	-- 해당 Unit이 없는 경우
	IF NOT EXISTS ( SELECT * FROM dbo.GUnit WITH(NOLOCK) WHERE UnitUID = @iUnitUID_ AND Deleted = 0 )
		SET @Result = -1
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN

				IF EXISTS ( SELECT * FROM dbo.GDenyOption WITH(NOLOCK) WHERE UnitUID = @iUnitUID_ ) BEGIN
					SET @Result = -2

					UPDATE dbo.GDenyOption
					SET CodeNo = CASE QuestionNo
						WHEN 1 then @iInsertFriendDeny_
						WHEN 2 then @iManToManChatDeny_
						WHEN 3 then @iPartyDeny_
						WHEN 4 then @iPrivateDealDeny_
						WHEN 5 then @iCoupleDeny_
					END
					WHERE UnitUID = @iUnitUID_ AND QuestionNo IN (1, 2, 3, 4, 5)
				END

				IF @@ROWCOUNT < 5 BEGIN
					SET @Result = -3

					INSERT INTO dbo.GDenyOption ( UnitUID, QuestionNo, CodeNo )
					SELECT @iUnitUID_, QuestionNo, CodeNo
					FROM (
						SELECT 1 AS QuestionNo, @iInsertFriendDeny_ AS CodeNo	UNION ALL
						SELECT 2, @iManToManChatDeny_							UNION ALL
						SELECT 3, @iPartyDeny_									UNION ALL
						SELECT 4, @iPrivateDealDeny_							UNION ALL
						SELECT 5, @iCoupleDeny_	
					) AS TempTable
					WHERE NOT EXISTS ( SELECT * FROM dbo.GDenyOption WITH(NOLOCK) WHERE QuestionNo = TempTable.QuestionNo AND UnitUID = @iUnitUID_ )
				END

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
	END

	SELECT ISNULL(@Result, 0) AS Result
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.05.15
-- Description:	옵션 정보 읽어가기
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GDenyOption_SEL]
	@iUnitUID_ bigint
AS
	SET NOCOUNT ON

	SELECT	ISNULL([1], 1) AS QuestionNo1
	,		ISNULL([2], 1) AS QuestionNo2
	,		ISNULL([3], 1) AS QuestionNo3
	,		ISNULL([4], 1) AS QuestionNo4
	,		ISNULL([5], 1) AS QuestionNo5
	FROM (
		SELECT CodeNo, QuestionNo
		FROM dbo.GDenyOption WITH(NOLOCK)
		WHERE UnitUID = @iUnitUID_
	) AS BASETABLE
	PIVOT (
		MAX(CodeNo) FOR QuestionNo IN ([1], [2], [3], [4], [5])
	) AS PIVOTTABLE
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GDarkGate_LastDate_UPD]
	@UnitUID 			BIGINT
,	@LastCompleteDate	SMALLDATETIME
/*
	어둠의 문을 가장 최근에 완료한 날짜 업데이트
	작성자: Hwang
*/
AS
	SET NOCOUNT ON
	
	DECLARE @Result	INT

	IF NOT EXISTS ( SELECT * FROM dbo.GUnit WITH(NOLOCK) WHERE UnitUID = @UnitUID )
		SELECT @Result	= -1
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN
			
			IF EXISTS ( SELECT * FROM dbo.GDarkGate_LastDate WITH(NOLOCK) WHERE UnitUID = @UnitUID ) BEGIN
				SET @Result = -2

				UPDATE dbo.GDarkGate_LastDate
				SET LastCompleteDate = @LastCompleteDate
				WHERE UnitUID = @UnitUID
				
			END
			ELSE BEGIN
				SET @Result = -3

				INSERT INTO dbo.GDarkGate_LastDate ( UnitUID, LastCompleteDate )
				VALUES( @UnitUID, @LastCompleteDate )
				
			END

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
CREATE OR ALTER PROCEDURE [dbo].[P_GDarkGate_LastDate_SEL]
	@UnitUID 		BIGINT
/*
	어둠의 문을 가장 최근에 완료한 날짜 정보 가져가기
	작성자: Hwang
*/
AS
	SET NOCOUNT ON
	
	DECLARE @LastCompleteDate	smalldatetime

	SELECT @LastCompleteDate = LastCompleteDate
	FROM dbo.GDarkGate_LastDate WITH(NOLOCK)
	WHERE UnitUID = @UnitUID
	
	IF @@ROWCOUNT = 0
		SELECT -1, @LastCompleteDate
	ELSE
		SELECT 0, @LastCompleteDate
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GDarkGate_Itemeffect_UPD]
	@UnitUID 	BIGINT
,	@ItemType	INT
,	@UseDate	DATETIME
/*
	어둠의 문 영약을 사용 데이터 기록
	작성자: Hwang
*/
AS
	SET NOCOUNT ON
	
	DECLARE @Result	INT

	IF NOT EXISTS ( SELECT * FROM dbo.GUnit WITH(NOLOCK) WHERE UnitUID = @UnitUID )
		SELECT @Result	= -1
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN
			
			IF EXISTS ( SELECT * FROM dbo.GDarkGate_Itemeffect WITH(NOLOCK) WHERE UnitUID = @UnitUID ) BEGIN
				SET @Result = -2

				UPDATE dbo.GDarkGate_Itemeffect
				SET ItemType = @ItemType
				,	UseDate = @UseDate
				WHERE UnitUID = @UnitUID
				
			END
			ELSE BEGIN
				SET @Result = -3

				INSERT INTO dbo.GDarkGate_Itemeffect ( UnitUID, ItemType, UseDate )
				VALUES( @UnitUID, @ItemType,@UseDate  )
			END

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
CREATE OR ALTER PROCEDURE [dbo].[lup_delete_arcade_rank_server]

AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

DELETE FROM dbo.GRank_Arcade_Server
	WHERE RANK BETWEEN 1 AND 5
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.04.16
-- Description:	청첩장 아이템 정보 입력
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GCouple_WeddingInvitation_Wedding_INT]
	@ItemUID		bigint
,	@WeddingUID		bigint

AS
	SET NOCOUNT ON;
	
	DECLARE @Result			int
	
	BEGIN TRY
		BEGIN TRAN

			INSERT INTO dbo.GCouple_WeddingInvitation( ItemUID, WeddingUID )
			VALUES ( @ItemUID, @WeddingUID )

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
-- Create date: 2013.04.16
-- Description:	청첩장 아이템 정보 읽어가기
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GCouple_WeddingInvitation_SEL]
	@ItemUID		bigint

AS
	SET NOCOUNT ON;
	
	DECLARE @Result			int
	DECLARE @WeddingUID		int
	
	
	SELECT @WeddingUID = WeddingUID
		FROM dbo.GCouple_WeddingInvitation WITH(NOLOCK)
			WHERE ItemUID = @ItemUID
	
	IF @@ROWCOUNT > 0
		SELECT @WeddingUID as WeddingUID
	ELSE 
		SELECT -1 as WeddingUID
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.04.16
-- Description:	결혼식 성공 업데이트
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GCouple_WeddingInfo_UPD]
	@WeddingUID		int

AS
	SET NOCOUNT ON;
	
	DECLARE @Result		int
	
	-- 해당 결혼식이 없으면
	IF NOT EXISTS( SELECT WeddingUID FROM dbo.GCouple_WeddingInfo WITH(NOLOCK) WHERE WeddingUID = @WeddingUID AND WeddingCheck = 0 )
		SET @Result = -1
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN

				SET @Result = -2

				UPDATE dbo.GCouple_WeddingInfo
				SET WeddingCheck = 1
				WHERE WeddingUID = @WeddingUID

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
-- Create date: 2013.04.16
-- Description:	결혼식 정보 읽어가기(서버켜지고 최초 한번)
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GCouple_WeddingInfo_SEL]

AS
	SET NOCOUNT ON;

	SELECT WeddingUID, GroomUID, BrideUID, WeddingHallType, WeddingNPC, WeddingDate, WeddingMessage
		FROM dbo.GCouple_WeddingInfo WITH(NOLOCK)
			WHERE WeddingDate >= GETDATE() -2
			AND WeddingCheck = 0
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.04.16
-- Description:	결혼식 예약 입력
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GCouple_WeddingInfo_INT]
	@GroomUID			bigint
,	@BrideUID			bigint
,	@WeddingHallType	tinyint
,	@WeddingNPC			tinyint
,	@RegDate			smalldatetime
,	@WeddingDate		smalldatetime
,	@WeddingMessage		nvarchar(80)

AS
	SET NOCOUNT ON;
	
	DECLARE @Result			int
	DECLARE @WeddingUID		int

	BEGIN TRY
		BEGIN TRAN

			INSERT INTO dbo.GCouple_WeddingInfo ( GroomUID, BrideUID, WeddingHallType, WeddingNPC, WeddingDate, RegDate, WeddingCheck, WeddingMessage )
			VALUES ( @GroomUID, @BrideUID, @WeddingHallType, @WeddingNPC, @WeddingDate, @RegDate, 0, @WeddingMessage )
			
			SET @WeddingUID = SCOPE_IDENTITY()
			
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

	SELECT ISNULL(@Result, 0) AS Result, @WeddingUID AS WeddingUID
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.05.06
-- Description:	(커플/결혼) 인연 맺은 시각 변경(치트용)
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GCouple_Info_UPD_RegDate]
	@UnitUID_A	bigint
,	@UnitUID_B	bigint
,	@AddDate	float

AS
	SET NOCOUNT ON;

	DECLARE @Result	INT

	IF NOT EXISTS ( SELECT * FROM dbo.GCouple_Info WITH(NOLOCK) WHERE UnitUID = @UnitUID_A )
		SELECT @Result	= -2
	IF NOT EXISTS ( SELECT * FROM dbo.GCouple_Info WITH(NOLOCK) WHERE UnitUID = @UnitUID_B )
		SELECT @Result	= -3
		
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN
				IF @AddDate < 0 BEGIN
					SELECT @Result	= -4
				
					UPDATE dbo.GCouple_Info
						SET RegDate = RegDate - ABS(@AddDate)
							WHERE UnitUID IN ( @UnitUID_A, @UnitUID_B )
				END
				ELSE BEGIN
					SELECT @Result	= -5
				
					UPDATE dbo.GCouple_Info
						SET RegDate = RegDate + ABS(@AddDate)
							WHERE UnitUID IN ( @UnitUID_A, @UnitUID_B )
				END
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
	END

	SELECT ISNULL(@Result, 0) AS Result
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.04.16
-- Description:	최근 캐릭터 로그오프 시각 저장
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GCouple_Info_UPD_LastLogOffDate]
	@UnitUID			bigint
,	@LastLogOffDate		smalldatetime

AS
	SET NOCOUNT ON;

	DECLARE @Result			int

	IF NOT EXISTS ( SELECT UnitUID FROM dbo.GCouple_Info WITH( NOLOCK ) WHERE UnitUID = @UnitUID )
		SET @Result = -10
	ELSE BEGIN
	
		BEGIN TRY
			BEGIN TRAN
			
				UPDATE dbo.GCouple_Info
					SET LastLogOffDate = @LastLogOffDate
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
				SET @Result = -1
		END CATCH
	END

	SELECT ISNULL(@Result, 0) AS Result
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.04.16
-- Description:	연인의 기본정보 읽어가기
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GCouple_Info_SEL_PartnerInfo]
	@UnitUID		bigint

AS
	SET NOCOUNT ON;
	
	DECLARE @Level			tinyint
	DECLARE @UnitClass		tinyint
	DECLARE @RegDate		smalldatetime

	SELECT @Level = A.Level, @UnitClass = A.UnitClass, @RegDate = B.LastLogOffDate
	FROM dbo.GUnit AS A WITH(NOLOCK)
	JOIN dbo.GCouple_Info AS B WITH(NOLOCK)
		ON A.UnitUID = B.UnitUID AND A.Deleted = 0
			WHERE A.UnitUID = @UnitUID
	
	IF @@ROWCOUNT > 0
		SELECT 0 AS 'Result', @Level AS 'Level', @UnitClass AS 'UnitClass', @RegDate AS 'LastLogout'

	ELSE
		SELECT -1 AS 'Result', 0 AS 'Level', 0 AS 'UnitClass', '1900-01-01 00:00' AS 'LastLogout'
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GCouple_Info_SEL_Check]
	@NickName		nvarchar(20)

AS
	SET NOCOUNT ON;
	
	DECLARE @UnitUID		bigint
	DECLARE @UserUID		bigint
	DECLARE @UnitClass		tinyint
	DECLARE @CoupleType		tinyint
	
	SELECT @UnitUID = A.UnitUID, @UserUID = B.UserUID, @UnitClass = B.UnitClass
		FROM dbo.GUnitNickName AS A WITH(NOLOCK)
		JOIN dbo.GUnit AS B WITH(NOLOCK)	ON A.UnitUID = B.UnitUID
			WHERE A.NickName = @NickName AND B.Deleted = 0
			
	SELECT @CoupleType = CoupleType
		FROM dbo.GCouple_Info WITH(NOLOCK)
			WHERE UnitUID = @UnitUID
	
	IF @UnitUID IS NULL BEGIN
		SELECT -1 AS 'Result', 0 AS 'UserUID', 0 AS 'UnitUID', 0 AS 'UnitClass', 0 AS 'CoupleType'
	END
	ELSE BEGIN	
		IF @CoupleType IS NULL
			SELECT 0 AS 'Result', @UserUID AS 'UserUID', @UnitUID AS 'UnitUID', @UnitClass AS 'UnitClass', 0 AS 'CoupleType'
		ELSE
			SELECT 0 AS 'Result', @UserUID AS 'UserUID', @UnitUID AS 'UnitUID', @UnitClass AS 'UnitClass', @CoupleType AS 'CoupleType'	
	END
GO
CREATE OR ALTER PROCEDURE [dbo].[P_GCouple_Info_SEL]
	@UnitUID		bigint

AS
	SET NOCOUNT ON;

	SELECT PartnerUID, B.NickName, CoupleType, A.RegDate, LoveWord, LastRewardDate, TitleRewardLv
		FROM dbo.GCouple_Info AS A WITH(NOLOCK)
		JOIN dbo.GUnitNickName AS B WITH(NOLOCK)
			ON A.PartnerUID = B.UnitUID
			WHERE A.UnitUID = @UnitUID
			AND A.CoupleType <> 0
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.04.16
-- Description:	인연 정보 업데이트
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GCouple_Info_INT_UPD_Inner]
	@EventType			tinyint
,	@UnitUID			bigint
,	@PartnerUID			bigint
,	@RegDate			smalldatetime
,	@LoveWord			nvarchar(20)
,	@TitleRewardLv		tinyint

AS
	SET NOCOUNT ON;

	DECLARE @Result		int
	DECLARE @Now		smalldatetime
	SET @Now = CURRENT_TIMESTAMP
	
	BEGIN TRY
		BEGIN TRAN
			IF NOT EXISTS ( SELECT UnitUID FROM dbo.GCouple_Info WITH(NOLOCK) WHERE UnitUID = @UnitUID ) BEGIN
				SET @Result = -1
				
				INSERT INTO dbo.GCouple_Info ( UnitUID, PartnerUID, CoupleType, LoveWord, RegDate, LastLogOffDate, LastRewardDate, TitleRewardLv )
				VALUES( @UnitUID, @PartnerUID, @EventType, @LoveWord, @RegDate, @RegDate, @RegDate, @TitleRewardLv )
						
			END
			ELSE BEGIN
					-- 커플
				IF @EventType = 1 BEGIN 
					SET @Result = -2
					
					UPDATE dbo.GCouple_Info
					SET PartnerUID = @PartnerUID
					  ,	CoupleType = @EventType
					  , RegDate = @RegDate
					  ,	LastRewardDate = @RegDate
					WHERE UnitUID = @UnitUID
				END
				-- 결혼
				ELSE IF @EventType = 2 BEGIN 
					SET @Result = -2
					
					UPDATE dbo.GCouple_Info
					SET CoupleType = @EventType
					  , RegDate = @RegDate
					WHERE UnitUID = @UnitUID
				END
				-- 이별(초기화)
				ELSE IF @EventType = 3 BEGIN 
					SET @Result = -2
					
					UPDATE dbo.GCouple_Info
					SET CoupleType = 0
					  ,	PartnerUID = 0
					  , RegDate = @RegDate
					  ,	LoveWord = N''
					  , LastRewardDate = '2000-01-01 00:00'
					  , TitleRewardLv = 0
					WHERE UnitUID = @UnitUID
				END
				-- 애칭 변경
				ELSE IF @EventType = 4 BEGIN
					SET @Result = -3
					
					UPDATE dbo.GCouple_Info
					SET LoveWord = @LoveWord
					WHERE UnitUID = @UnitUID
				END
				-- 최근 보상 받은 시간 업데이트
				ELSE IF @EventType = 5 BEGIN
					SET @Result = -4
					
					UPDATE dbo.GCouple_Info
					SET LastRewardDate = @Now
					WHERE UnitUID = @UnitUID
				END
				-- 칭호 보상 단계 저장
				ELSE IF @EventType = 6 BEGIN
					SET @Result = -5
					
					UPDATE dbo.GCouple_Info
					SET TitleRewardLv = @TitleRewardLv
					WHERE UnitUID = @UnitUID
				END
			END	

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
			SET @Result = -10
	END CATCH


	RETURN @Result
GO
CREATE OR ALTER PROCEDURE [dbo].[P_Manager_Title_INS]
	@UnitUID	BIGINT = 0
,	@TitleID	INT
,	@IsComplete	TINYINT
,	@EndDate	SMALLDATETIME
,	@Result		INT = 0 OUTPUT
AS
SET NOCOUNT ON;

DECLARE @EXEC_SCRIPT	NVARCHAR(MAX)
,		@SQLUser		NVARCHAR(50)

BEGIN TRAN

	IF @IsComplete = 0
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM dbo.GTitle_Complete WHERE UnitUID = @UnitUID AND TitleID = @TitleID) BEGIN
			INSERT INTO dbo.GTitle_Mission (UnitUID, TitleID, SubMission1, SubMission2, SubMission3, SubMission4, SubMission5)
			SELECT @UnitUID, @TitleID, 0, 0, 0, 0, 0
			
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN	SELECT @Result = -1	GOTO FAIL_TRAN	END
		END
		ELSE
			SET @Result = -2
	END
	ELSE IF @IsComplete = 1
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM dbo.GTitle_Mission WHERE UnitUID = @UnitUID AND TitleID = @TitleID) BEGIN
			INSERT INTO dbo.GTitle_Complete (UnitUID, TitleID, EndDate, IsHang)
			SELECT @UnitUID, @TitleID, @EndDate, 0
			
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN	SELECT @Result = -1	GOTO FAIL_TRAN	END
		END
		ELSE
			SET @Result = -3
	END
	
COMMIT TRAN
GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
GO
CREATE OR ALTER PROCEDURE [dbo].[P_Manager_Title_DEL]
	@UnitUID	BIGINT
,	@TitleID	INT
,	@Type		TINYINT
,	@Result		INT = 0 OUTPUT
AS
SET NOCOUNT ON;

DECLARE @EXEC_SCRIPT	NVARCHAR(MAX)
,		@SQLUser		NVARCHAR(50)

BEGIN TRAN
	
	IF @Type = 0 
	BEGIN
		DELETE FROM dbo.GTitle_Mission WHERE UnitUID = @UnitUID AND TitleID = @TitleID
	END
	ELSE IF @Type = 1
	BEGIN
		DELETE FROM dbo.GTitle_Complete WHERE UnitUID = @UnitUID AND TitleID = @TitleID
	END
	
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
CREATE OR ALTER PROCEDURE [dbo].[P_Manager_Quest_INS]
	@UnitUID	BIGINT = 0
,	@QuestID	INT
,	@SubQuest0	TINYINT
,	@SubQuest1	TINYINT
,	@SubQuest2	TINYINT
,	@SubQuest3	TINYINT
,	@SubQuest4	TINYINT
,	@IsComplete	TINYINT
,	@Result		INT = 0 OUTPUT
AS
SET NOCOUNT ON;

DECLARE @EXEC_SCRIPT	NVARCHAR(MAX)
,		@SQLUser		NVARCHAR(50)

BEGIN TRAN
	
	IF @IsComplete = 0
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM dbo.GQuests_Complete WHERE UnitUID = @UnitUID AND QuestID = @QuestID) BEGIN
			INSERT INTO dbo.GQuests (UnitUID, QuestID, SubQuest0, SubQuest1, SubQuest2, SubQuest3, SubQuest4, RegDate)
			SELECT @UnitUID, @QuestID, @SubQuest0, @SubQuest1, @SubQuest2, @SubQuest3, @SubQuest4, GETDATE()
			
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN	SELECT @Result = -1	GOTO FAIL_TRAN	END
		END
		ELSE
			SET @Result = -2
	END
	ELSE IF @IsComplete = 1
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM dbo.GQuests WHERE UnitUID = @UnitUID AND QuestID = @QuestID) BEGIN
			INSERT INTO dbo.GQuests_Complete (UnitUID, QuestID, RegDate, CompleteDate)
			SELECT @UnitUID, @QuestID, GETDATE(), GETDATE()
			
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN	SELECT @Result = -1	GOTO FAIL_TRAN	END
		END
		ELSE
			SET @Result = -3
	END
	
COMMIT TRAN
GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
GO
CREATE OR ALTER PROCEDURE [dbo].[P_Manager_Quest_DEL]
	@UnitUID	BIGINT
,	@QuestID	INT
,	@Result		INT = 0 OUTPUT
AS
SET NOCOUNT ON;

DECLARE @EXEC_SCRIPT	NVARCHAR(MAX)
,		@SQLUser		NVARCHAR(50)

BEGIN TRAN
	
	DELETE FROM dbo.GQuests WHERE UnitUID = @UnitUID AND QuestID = @QuestID
	
	IF @@ERROR <> 0
	BEGIN	SELECT @Result = -1	GOTO FAIL_TRAN	END
	
	DELETE FROM dbo.GQuests_Complete WHERE UnitUID = @UnitUID AND QuestID = @QuestID
	
	IF @@ERROR <> 0
	BEGIN	SELECT @Result = -1	GOTO FAIL_TRAN	END

COMMIT TRAN
GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
GO
CREATE OR ALTER PROCEDURE [dbo].[P_Manager_Post_INS]
	@UnitUID	BIGINT = 0
,	@NickName	NVARCHAR(20) = ''
,	@ItemID		INT
,	@Quantity	INT
,	@Title		NVARCHAR(200)
,	@Message	NVARCHAR(1000)
,	@Result		INT = -1 OUTPUT
AS
SET NOCOUNT ON;

DECLARE @EXEC_SCRIPT	NVARCHAR(MAX)
,		@SQLUser		NVARCHAR(50)

IF @UnitUID = 0
	SELECT @UnitUID = UnitUID FROM dbo.GUnitNickName WITH(NOLOCK) WHERE NickName = @NickName

BEGIN TRAN
	
	IF ISNULL(@UnitUID, 0) <= 0
	BEGIN
		SELECT @Result = -2    
		GOTO FAIL_TRAN
	END
	
	INSERT INTO dbo.GPost (FromUnitUID, ToUnitUID, Quantity, ScType, ScIndex, RegDate, DelDate, IsReceive, IsRead, Title, [Message] )
	SELECT @UnitUID, @UnitUID, @Quantity, 5, @ItemID, GETDATE(), GETDATE(), 0, 0, @Title, @Message
	
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
CREATE OR ALTER PROCEDURE [dbo].[P_Manager_Pet_UPD]
	@UnitUID		BIGINT
,	@PetUID			BIGINT
,	@PetID			INT
,	@PetName		NVARCHAR(16)
,	@EvolutionStep	TINYINT
,	@Satiety		SMALLINT
,	@Intimacy		INT
,	@Extroversion	SMALLINT
,	@Emotion		SMALLINT
,	@IsCall			BIT
,	@Deleted		TINYINT
,	@AutoFeed		BIT
,	@PickUP			BIT
,	@Result			INT = 0 OUTPUT
AS
SET NOCOUNT ON;

DECLARE @EXEC_SCRIPT	NVARCHAR(MAX)
,		@SQLUser		NVARCHAR(50)
,		@NickName		NVARCHAR(20)

BEGIN TRAN
	
	UPDATE dbo.GPet_Info
	SET PetID = @PetID
	,	PetName = @PetName
	,	EvolutionStep = @EvolutionStep
	,	Satiety = @Satiety
	,	Intimacy = @Intimacy
	,	Extroversion = @Extroversion
	,	Emotion = @Emotion
	,	IsCall = @IsCall
	,	AutoFeed = @AutoFeed
	,	PickUP = @PickUP
	WHERE PetUID = @PetUID
	
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
CREATE OR ALTER PROCEDURE [dbo].[P_Manager_Pet_DEL]
	@UnitUID		BIGINT
,	@PetUID			BIGINT
,	@Result		INT = 0 OUTPUT
AS
SET NOCOUNT ON;

DECLARE @EXEC_SCRIPT	NVARCHAR(MAX)
,		@SQLUser		NVARCHAR(50)
,		@NickName		NVARCHAR(20)

BEGIN TRAN
	
	DELETE dbo.GPet_Info
		OUTPUT DELETED.PetUID, DELETED.UnitUID, DELETED.PetID, DELETED.PetName, DELETED.EvolutionStep, DELETED.Satiety, DELETED.Intimacy, DELETED.Extroversion, 
				DELETED.Emotion, DELETED.RegDate, GETDATE(), DELETED.IsCall, DELETED.AutoFeed, DELETED.LastFeedDate, DELETED.LastcallDate, DELETED.PickUP
		INTO GameDataMgmt.dbo.DeletePetMgmt ( PetUID, UnitUID, PetID, PetName, EvolutionStep, Satiety, Intimacy, Extroversion, Emotion, RegDate, DelDate, IsCall, AutoFeed, LastFeedDate, LastcallDate, PickUP )
	WHERE PetUID = @PetUID
	
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
CREATE OR ALTER PROCEDURE [dbo].[P_Manager_NickName_DEL]
	@UnitUID	BIGINT
,	@NickName	NVARCHAR(50)
,	@Result		INT = 0 OUTPUT
AS
SET NOCOUNT ON;

DECLARE @EXEC_SCRIPT	NVARCHAR(MAX)
,		@SQLUser		NVARCHAR(50)

BEGIN TRAN
	
	-- 닉네임 바꿔주기
	UPDATE dbo.GUnitNickName
    SET NickName = NickName + '_' + SUBSTRING(CONVERT(NVARCHAR(10),GETDATE(),112), 3, 6)
    WHERE UnitUID = @UnitUID
            
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
    BEGIN    SELECT @Result = -12    GOTO END_PROC    END

	--  닉네임 과거 기록 저장
	INSERT INTO dbo.GDeletedNickNameHistory (NickName,UnitUID, Regdate)
	SELECT @NickName, @UnitUID, GETDATE()
		
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
    BEGIN    SELECT @Result = -2	GOTO END_PROC    END
	
COMMIT TRAN
GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
GO
CREATE OR ALTER PROCEDURE [dbo].[P_Manager_ItemUsing_DEL]
	@UnitUID	BIGINT
,	@ItemUID	BIGINT
,	@Result		INT = 0 OUTPUT
AS
SET NOCOUNT ON;

DECLARE @EXEC_SCRIPT	NVARCHAR(MAX)
,		@SQLUser		NVARCHAR(50)

BEGIN TRAN
	
	DELETE dbo.GItem
		OUTPUT DELETED.ItemUID, DELETED.UnitUID, DELETED.ItemID, DELETED.InventoryCategory, DELETED.SlotID, DELETED.UsageType, DELETED.Quantity, DELETED.Endurance, DELETED.RegDate, GETDATE(), 41, DELETED.Inserted
		INTO dbo.GItem_Log ( ItemUID, UnitUID, ItemID, InventoryCategory, SlotID, UsageType, Quantity, Endurance, RegDate, DelDate, Deleted, Inserted )
	WHERE UnitUID = @UnitUID
	AND ItemUID = @ItemUID
	
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
CREATE OR ALTER PROCEDURE [dbo].[P_Manager_GuildSkill_UPD]
	@GuildNo	INT
,	@SkillID	INT
,	@Level		INT
,	@Result		INT = 0 OUTPUT
AS
SET NOCOUNT ON;

DECLARE @EXEC_SCRIPT	NVARCHAR(MAX)
,		@SQLUser		NVARCHAR(50)

BEGIN TRAN
	
	UPDATE	dbo.GGuild_Skill
	SET		Level = ISNULL(@Level, Level)
	WHERE	GuildNo = @GuildNo
	AND		SkillID = @SkillID
	
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
--GameDB에 생성할 프로시저
CREATE OR ALTER PROCEDURE [dbo].[P_Manager_GuildMember_DEL]
	@GuildNo	INT
,	@UnitUID	BIGINT
,	@Result		INT = 0 OUTPUT
AS
SET NOCOUNT ON;

DECLARE @EXEC_SCRIPT	NVARCHAR(MAX)
,		@SQLUser		NVARCHAR(50)

BEGIN TRAN
	
	IF NOT EXISTS (SELECT * FROM dbo.GGuild_Member WITH(NOLOCK) WHERE UnitUID = @UnitUID AND GuildNo = @GuildNo)
	BEGIN	
		SELECT @Result = -2    
		GOTO FAIL_TRAN
	END
	ELSE IF EXISTS (SELECT * FROM dbo.GGuild_Member WITH(NOLOCK) WHERE UnitUID = @UnitUID AND State = 1)
	BEGIN	
		SELECT @Result = -3    
		GOTO FAIL_TRAN
	END
			
	DELETE FROM dbo.GGuild_Member WHERE GuildNo = @GuildNo AND UnitUID = @UnitUID
	
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
CREATE OR ALTER PROCEDURE [dbo].[P_Manager_GuildMaster_UPD]
	@GuildNo	INT
,	@OldUnitUID	BIGINT
,	@NewUnitUID	BIGINT
,	@Result		INT = 0 OUTPUT
AS
SET NOCOUNT ON;

DECLARE @EXEC_SCRIPT	NVARCHAR(MAX)
,		@SQLUser		NVARCHAR(50)

BEGIN TRAN

	IF NOT EXISTS (SELECT * FROM dbo.GGuild_Member WITH(NOLOCK) WHERE UnitUID = @OldUnitUID AND GuildNo = @GuildNo AND State = 1)
	BEGIN	
		-- 길드 마스터 확인
		SET @Result = -2	
		GOTO FAIL_TRAN 
	END
	ELSE IF NOT EXISTS (SELECT * FROM dbo.GGuild_Member WITH(NOLOCK) WHERE UnitUID = @NewUnitUID AND GuildNo = @GuildNo)
	BEGIN
		-- 변경할 유저가 길드원인지 확인
		SET @Result = -3
		GOTO FAIL_TRAN 
	END
	
	UPDATE	dbo.GGuild_Member
	SET		[State] = 6 -- 데이터 확인
	WHERE	UnitUID = @OldUnitUID
	AND		GuildNo = @GuildNo
	
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	BEGIN    
		SELECT @Result = -1    
		GOTO FAIL_TRAN    
	END

	UPDATE	dbo.GGuild_Member
	SET		[State] = 1 -- 데이터 확인
	WHERE	UnitUID = @NewUnitUID
	AND		GuildNo = @GuildNo
	
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
CREATE OR ALTER PROCEDURE [dbo].[P_Manager_Guild_UPD]
	@GuildNo	INT
,	@GuildName	NVARCHAR(200)
,	@Exp		INT
,	@MaxNo		INT
,	@SayHello	NVARCHAR(500)
,	@Result		INT = 0 OUTPUT
AS
SET NOCOUNT ON;

DECLARE @EXEC_SCRIPT	NVARCHAR(MAX)
,		@SQLUser		NVARCHAR(50)

BEGIN TRAN
	
	UPDATE	dbo.GGuild 
	SET		GuildName = @GuildName
	,		[EXP] = @Exp
	,		MaxNo = @MaxNo
	,		SayHello = @SayHello
	WHERE	GuildNo = @GuildNo
	
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
CREATE OR ALTER PROCEDURE [dbo].[P_Manager_EventItem_DEL]
	@EventItemType	TINYINT
,	@Result			INT = 0 OUTPUT
AS
SET NOCOUNT ON;

DECLARE @EXEC_SCRIPT	NVARCHAR(MAX)
,		@SQLUser		NVARCHAR(50)

BEGIN TRAN
	
	IF @EventItemType = 0		-- ITEM
	BEGIN

		DELETE dbo.GItem
			OUTPUT DELETED.ItemUID, DELETED.UnitUID, DELETED.ItemID, DELETED.InventoryCategory, DELETED.SlotID, DELETED.UsageType, DELETED.Quantity, DELETED.Endurance, DELETED.RegDate, GETDATE(), DELETED.Inserted, 31
			INTO dbo.GItem_Log ( ItemUID, UnitUID, ItemID, InventoryCategory, SlotID, UsageType, Quantity, Endurance, RegDate, DelDate, Inserted, Deleted )
		WHERE ItemID IN (
			SELECT ItemID FROM GAMEMANAGE.GameManage.dbo.GMTempDeleteItem WITH(NOLOCK) WHERE EventItemType = @EventItemType
		)

		SET @Result = @@ROWCOUNT

		IF @@ERROR <> 0
		BEGIN	SELECT @Result = -1	GOTO FAIL_TRAN	END

	END
	ELSE IF @EventItemType = 1	-- POST
	BEGIN

		UPDATE dbo.GPost
		SET DelDate = GETDATE()
			OUTPUT DELETED.PostNo, DELETED.RegDate, DELETED.DelDate, DELETED.IsReceive, DELETED.IsRead, DELETED.Deleted
			INTO GameDataMgmt.dbo.DeletePostMgmt ( PostNo, RegDate, DelDate, IsReceive, IsRead, Deleted )
		WHERE ScIndex IN ( 
			SELECT ItemID FROM GAMEMANAGE.GameManage.dbo.GMTempDeleteItem WITH(NOLOCK) WHERE EventItemType = @EventItemType
		)
		AND Deleted = 0

		SET @Result = @@ROWCOUNT

		IF @@ERROR <> 0
		BEGIN	SELECT @Result = -1	GOTO FAIL_TRAN	END

	END
	ELSE IF @EventItemType = 2	-- Quest
	BEGIN

		DELETE dbo.GQuests
			OUTPUT DELETED.UnitUID, DELETED.QuestID, DELETED.SubQuest0, DELETED.SubQuest1, DELETED.SubQuest2, DELETED.SubQuest3, DELETED.SubQuest4, DELETED.RegDate, GETDATE()
			INTO GameDataMgmt.dbo.DeleteQuestMgmt ( UnitUID, QuestID, SubQuest0, SubQuest1, SubQuest2, SubQuest3, SubQuest4, RegDate, DelDate )
		WHERE QuestID IN ( 
			SELECT ItemID FROM GAMEMANAGE.GameManage.dbo.GMTempDeleteItem WITH(NOLOCK) WHERE EventItemType = @EventItemType
		)

		SET @Result = @@ROWCOUNT

		IF @@ERROR <> 0
		BEGIN	SELECT @Result = -1	GOTO FAIL_TRAN	END

	END
	ELSE IF @EventItemType = 4	-- Title
	BEGIN

		UPDATE DBO.GTitle_Complete 
		SET EndDate = getdate() 
			OUTPUT DELETED.UnitUID, DELETED.TitleID, DELETED.EndDate, DELETED.IsHang
			INTO GameDataMgmt.dbo.DeleteTitleMgmt ( UnitUID, TitleID, EndDate, IsHang )
		WHERE TitleID IN (
			SELECT ItemID FROM GAMEMANAGE.GameManage.dbo.GMTempDeleteItem WITH(NOLOCK) WHERE EventItemType = @EventItemType
		)

		SET @Result = @@ROWCOUNT

		IF @@ERROR <> 0
		BEGIN	SELECT @Result = -1	GOTO FAIL_TRAN	END

	END

COMMIT TRAN
GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_insert_rank_spacetime_week]
	@iRank			TINYINT
,	@iUnitUID		BIGINT
,	@strNickName	NVARCHAR(16)
,	@iUnitClass		TINYINT
,	@iLevel			TINYINT
,	@iStage			TINYINT
,	@iPlayTime		SMALLINT
,	@sdtRegDate		SMALLDATETIME
,	@sdtDate		SMALLDATETIME
	
	
/*
	2009. 07. 07
	sutamtwo
	주간 랭킹 넣기
*/	
	
AS 
SET NOCOUNT ON;

INSERT INTO dbo.Rank_SpaceTime_Week ([Rank], UnitUID, NickName, UnitClass, [Level], Stage, PlayTime, RegDate, Date)
	SELECT @iRank,	@iUnitUID,	@strNickName, @iUnitClass, @iLevel, @iStage, @iPlayTime, @sdtRegDate, @sdtDate
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_insert_rank_spacetime_month]
	@iRank			TINYINT
,	@iUnitUID		BIGINT
,	@strNickName	NVARCHAR(16)
,	@iUnitClass		TINYINT
,	@iLevel			TINYINT
,	@iStage			TINYINT
,	@iPlayTime		SMALLINT
,	@sdtRegDate		SMALLDATETIME
,	@sdtDate		SMALLDATETIME
	
	
/*
	2009. 07. 07
	sutamtwo
	월간 랭킹 넣기
*/	
	
AS 
SET NOCOUNT ON;

INSERT INTO dbo.Rank_SpaceTime_Month ([Rank], UnitUID, NickName, UnitClass, [Level], Stage, PlayTime, RegDate, Date)
	SELECT @iRank,	@iUnitUID,	@strNickName, @iUnitClass, @iLevel, @iStage, @iPlayTime, @sdtRegDate, @sdtDate
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_insert_rank_spacetime_day]
	@iRank			TINYINT
,	@iUnitUID		BIGINT
,	@strNickName	NVARCHAR(16)
,	@iUnitClass		TINYINT
,	@iLevel			TINYINT
,	@iStage			TINYINT
,	@iPlayTime		SMALLINT
,	@sdtRegDate		SMALLDATETIME
,	@sdtDate		SMALLDATETIME
	
	
/*
	2009. 07. 07
	sutamtwo
	일간 랭킹 넣기
*/	
	
AS 
SET NOCOUNT ON;

INSERT INTO dbo.Rank_SpaceTime_Day ([Rank], UnitUID, NickName, UnitClass, [Level], Stage, PlayTime, RegDate, Date)
	SELECT @iRank,	@iUnitUID,	@strNickName, @iUnitClass, @iLevel, @iStage, @iPlayTime, @sdtRegDate, @sdtDate
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_insert_rank_myrecord]
	@iUnitUID	BIGINT
,	@iStage		TINYINT
,	@iPlayTime	SMALLINT
,	@iLevel		TINYINT
,	@iUnitClass	TINYINT
,	@sdtRegDate	SMALLDATETIME
,	@iOK		INT = 0
	
/*
	2009. 07. 07
	sutamtwo
	나의 최근 랭킹 기록하기
*/	
	
AS 
SET NOCOUNT ON;

BEGIN TRAN


IF NOT EXISTS (SELECT UnitUID FROM dbo.Rank_SpaceTime_MyRecord WITH (NOLOCK) WHERE UnitUID = @iUnitUID)
	BEGIN
		INSERT INTO dbo.Rank_SpaceTime_MyRecord (UnitUID, Stage, [Level], Unitclass, PlayTime, RegDate)
			SELECT @iUnitUID, @iStage, @iLevel, @iUnitClass, @iPlayTime, @sdtRegDate
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END
	END

ELSE
	BEGIN
		UPDATE dbo.Rank_SpaceTime_MyRecord
			SET Stage		= @iStage
			,	PlayTime	= @iPlayTime
			,	[Level]		= @iLevel
			,	UnitClass	= @iUnitClass
			,	RegDate		= @sdtRegDate
				WHERE UnitUID = @iUnitUID
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN	SELECT @iOK = -2	GOTO FAIL_TRAN	END
		
	END
	
COMMIT TRAN	

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[P_skill_delete_all_UnitClassChange]
	@UnitUID		bigint
,	@SPointMax		int
,	@CSPoint		int

/*
	스킬/스킬 슬롯 초기화
	망각의 드링크 사용과 동일
	(gup_delete_all_skill_new)
*/
AS
	SET NOCOUNT ON

	DECLARE @Result		int

	BEGIN TRY
		BEGIN TRAN

		-- 습득 스킬 지우기		SET @Result = -1
		DELETE dbo.GSkill_New
        WHERE UnitUID = @UnitUID

		-- 기본 스킬 레벨 1로 변경
		SET @Result = -6
		insert into dbo.GSkill_New(UnitUID, SkillID, [level], CSP)
		select @UnitUID, 1000, 1, 0 union all
		select @UnitUID, 1207, 1, 0

		-- 스킬 포인트 보상
		SET @Result = -2
		UPDATE dbo.GUnit
		SET SPoint = @SPointMax
		WHERE UnitUID = @UnitUID

		-- 캐시 스킬 포인트 보상
		IF ( @CSPoint > 0) BEGIN
			SET @Result = -3
			UPDATE dbo.GSkill_Cash
			SET CsPoint = @CSPoint
			WHERE UnitUID = @UnitUID
		END

		-- 스킬 슬롯 초기화
		SET @Result = -4
		UPDATE dbo.GSkillSlot_New
		SET Slot01  = 0
		,	Slot02	= 0
		,	Slot03	= 0
		,	Slot04	= 0
		WHERE UnitUID = @UnitUID

		IF EXISTS ( SELECT * FROM dbo.GSkillSlot2_New WITH(NOLOCK) WHERE UnitUID = @UnitUID ) BEGIN
			SET @Result = -5
			UPDATE dbo.GSkillSlot2_New
			SET Slot01  = 0
			,	Slot02	= 0
			,	Slot03	= 0
			,	Slot04	= 0
			WHERE UnitUID = @UnitUID
		END

		INSERT INTO dbo.LUnitClassChangeLog ( UnitUID, OldID, [NewID], SPNo, RegDate )
			VALUES ( @UnitUID, 0, 0, 2, getdate())		

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
CREATE OR ALTER PROCEDURE [dbo].[P_Manager_UnitSkill_DEL_ALL]
	@UnitUID	BIGINT
,	@Result		INT = 0 OUTPUT
AS
SET NOCOUNT ON

DECLARE @MaxSkillPoint	INT
,		@MaxCsPoint		INT

DECLARE @UnitClass		TINYINT

-- 현재 레벨에 적정량의 스킬포인트와 클래스를 조회
SELECT	@MaxSkillPoint = [Level] * 2, @UnitClass = UnitClass
FROM	dbo.GUnit WITH(NOLOCK)
WHERE	UnitUID = @UnitUID

-- 스킬 개편 적용 시
/*

SELECT	@MaxSkillPoint = B.SPoint, @UnitClass = A.UnitClass
FROM	dbo.GUnit AS A WITH(NOLOCK)
		JOIN dbo.GLevel_SPoint AS B WITH(NOLOCK) ON A.Level = B.Level
WHERE	A.UnitUID = @UnitUID

*/

-- 그노시스 축복 정보
SELECT	@MaxCsPoint = ISNULL(MaxCSP, 0)
FROM	dbo.GSkill_Cash WITH(NOLOCK)
WHERE	UnitUID = @UnitUID

BEGIN TRAN

	-- 기본스킬을 제외한 모든 스킬을 삭제 (기본스킬은 스킬개편 때...)
	DELETE	dbo.GSkill_New
	WHERE	UnitUID = @UnitUID
	--AND		SkillID NOT IN (SELECT SkillID FROM GSkill_Default WITH(NOLOCK) WHERE UnitClass = @UnitClass)

	IF @@ERROR <> 0
	BEGIN	SET @Result = -1	GOTO FAIL_TRAN	END

	-- 기본 스킬 레벨 변경
	UPDATE	dbo.GSKill_New
	SET		[Level] = 1, CSP = 0
	WHERE	UnitUID = @UnitUID

	IF @@ERROR <> 0
	BEGIN	SET @Result = -2	GOTO FAIL_TRAN	END

	-- 스킬포인트 보상
	UPDATE	dbo.GUnit
	SET		SPoint = @MaxSkillPoint
	WHERE	UnitUID = @UnitUID

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	BEGIN	SET @Result = -3	GOTO FAIL_TRAN	END

	-- 캐시스킬 보상
	IF @MaxCsPoint > 0 
	BEGIN

		UPDATE	dbo.GSkill_Cash
		SET		CsPoint = @MaxCsPoint
		WHERE	UnitUID = @UnitUID

		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SET @Result = -4	GOTO FAIL_TRAN	END

	END

	-- 스킬 슬롯 초기화
	UPDATE	dbo.GSkillSlot_New
	SET		Slot01 = 0, Slot02 = 0, Slot03 = 0, Slot04 = 0
	WHERE	UnitUID = @UnitUID

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	BEGIN	SET @Result = -5	GOTO FAIL_TRAN	END

	IF EXISTS (SELECT * FROM dbo.GSkillSlot2_New WITH(NOLOCK) WHERE UnitUID = @UnitUID)
	BEGIN

		UPDATE	dbo.GSkillSlot2_New
		SET		Slot01 = 0, Slot02 = 0, Slot03 = 0, Slot04 = 0
		WHERE	UnitUID = @UnitUID

		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SET @Result = -6	GOTO FAIL_TRAN	END

	END

	SET @Result = 0

COMMIT TRAN
GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
GO
CREATE OR ALTER PROCEDURE [dbo].[P_Manager_Unit_UPD]
	@UnitUID	BIGINT
,	@Level		TINYINT
,	@NickName	NVARCHAR(25)
,	@ED			INT
,	@Exp		INT
,	@Spoint		INT
,	@Stone		SMALLINT
,	@Spirit		SMALLINT
,	@Result		INT = 0 OUTPUT
AS
SET NOCOUNT ON;

BEGIN TRAN
	
	IF 1 = (SELECT CASE WHEN UnitUID = @UnitUID THEN 0 ELSE 1 END 
			FROM GUnitNickName WITH(NOLOCK) 
			WHERE NickName = @NickName)
	BEGIN
		SET @Result = -9    
		GOTO FAIL_TRAN  
	END
	
	UPDATE	dbo.GUnit
	SET		GamePoint = ISNULL(@ED, GamePoint)
	,		[Level] = ISNULL(@Level, [Level])
	,		[Exp] = ISNULL(@Exp, [Exp])
	,		Spoint = ISNULL(@Spoint, Spoint)
	WHERE	UnitUID = @UnitUID
	
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	BEGIN    
		SET @Result = -1    
		GOTO FAIL_TRAN    
	END
	
	UPDATE	dbo.GUnitNickName 
	SET		NickName = ISNULL(@NickName, NickName)
	WHERE	UnitUID = @UnitUID
	
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	BEGIN    
		SET @Result = -1    
		GOTO FAIL_TRAN    
	END
			
	UPDATE	dbo.GResurrectionStone
	SET		Quantity = @Stone
	WHERE	UnitUID = @UnitUID
	
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	BEGIN    
		SET @Result = -1    
		GOTO FAIL_TRAN    
	END
			
	UPDATE	dbo.GSpirit
	SET		Spirit = @Spirit
	WHERE	UnitUID = @UnitUID
	
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	BEGIN    
		SET @Result = -1    
		GOTO FAIL_TRAN    
	END

COMMIT TRAN
GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
GO
CREATE OR ALTER PROCEDURE [dbo].[P_Manager_Unit_Restore_UPD]
	@UserUID	BIGINT
,	@UnitUID	BIGINT
,	@Result		INT = 0 OUTPUT
AS
SET NOCOUNT ON;

DECLARE @EXEC_SCRIPT	NVARCHAR(MAX)
,		@SQLUser		NVARCHAR(50)
,		@NickName		NVARCHAR(20)

BEGIN TRAN
	
	SELECT	@NickName = SUBSTRING(NickName, 1, CHARINDEX(N'_', NickName) - 1)
	FROM	dbo.GUnitNickName WITH(NOLOCK)
	WHERE	UnitUID = @UnitUID
	
	IF ISNULL(@NickName, '') = ''
	BEGIN
		SELECT @Result = -2    
		GOTO FAIL_TRAN
	END
	
	EXEC @Result = P_Unit_Restore_SET @UnitUID, @NickName
		
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
-- =============================================
-- Author:		Hwang
-- Create date: 2013.09.03
-- Description:	인연 정보 업데이트
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GCouple_Info_INT_UPD]
	@EventType		tinyint
,	@UnitUID		bigint
,	@PartnerUID		bigint
,	@RegDate		smalldatetime
,	@LoveWord		nvarchar(20)
,	@TitleRewardLv	tinyint

AS
	SET NOCOUNT ON;

	DECLARE @Result			int
	DECLARE @Result_A		int
	DECLARE @Result_B		int
	DECLARE @ErrorMSG		nvarchar(max)
	DECLARE @Now			smalldatetime
	SET @ErrorMSG = N'%s [P_GCouple_Info_INT_UPD_Inner @UnitUID_A = %I64d, @UnitUID_B = %I64d, @EventType = %d, @Result = %d]'

	IF NOT EXISTS ( SELECT UnitUID FROM dbo.GUnit WITH( NOLOCK ) WHERE UnitUID = @UnitUID AND Deleted = 0 )
		SET @Result = -10
	ELSE IF NOT EXISTS ( SELECT UnitUID FROM dbo.GUnit WITH( NOLOCK ) WHERE UnitUID = @PartnerUID AND Deleted = 0 )
		SET @Result = -11
	ELSE BEGIN
	
		BEGIN TRY
			BEGIN TRAN
				-- 커플/결혼/이혼/애칭변경은 두 캐릭터에 모두 업데이트 한다
				IF @EventType <= 4 BEGIN
					EXEC @Result_A = [dbo].[P_GCouple_Info_INT_UPD_Inner] @EventType, @UnitUID, @PartnerUID, @RegDate, @LoveWord, @TitleRewardLv
					IF @Result_A < 0
						RAISERROR(@ErrorMSG, 15, 1, N'P_GCouple_Info_INT_UPD_Inner, ', @UnitUID, @PartnerUID, @EventType, @Result_A) WITH SETERROR
					
					EXEC @Result_B = [dbo].[P_GCouple_Info_INT_UPD_Inner] @EventType, @PartnerUID, @UnitUID, @RegDate, @LoveWord, @TitleRewardLv
					IF @Result_B < 0
						RAISERROR(@ErrorMSG, 15, 1, N'P_GCouple_Info_INT_UPD_Inner, ', @PartnerUID, @UnitUID, @EventType, @Result_A) WITH SETERROR
				END
				-- 접속보상/칭호보상은 캐릭터 접속 시점에 각각 처리한다(보상받은 시각 다를 수 있음)
				ELSE BEGIN
					EXEC @Result_A = [dbo].[P_GCouple_Info_INT_UPD_Inner] @EventType, @UnitUID, @PartnerUID, @RegDate, @LoveWord, @TitleRewardLv
					IF @Result_A < 0
						RAISERROR(@ErrorMSG, 15, 1, N'P_GCouple_Info_INT_UPD_Inner, ', @UnitUID, @PartnerUID, @EventType, @Result_A) WITH SETERROR
				END
				
				
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
	END

	SELECT ISNULL(@Result, 0) AS Result
GO
-- =============================================
-- Author: Hwang
-- Create date: 2012-04-17
-- Description:	아이템거래(이동) SP
--				(랜덤소켓 부분 추가)
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GItem_Total_Trade_New]
	@TradeType			tinyint			-- 개인상점: 5, 개인거래: 6
,	@UnitUID_A			bigint
,	@UnitUID_B			bigint
,	@ED_A				int
,	@ED_B				int
,	@ItemUID_A_0		bigint	,	@Quantity_A_0		int
,	@ItemUID_A_1		bigint	,	@Quantity_A_1		int
,	@ItemUID_A_2		bigint	,	@Quantity_A_2		int
,	@ItemUID_A_3		bigint	,	@Quantity_A_3		int
,	@ItemUID_A_4		bigint	,	@Quantity_A_4		int
,	@ItemUID_A_5		bigint	,	@Quantity_A_5		int
,	@ItemUID_A_6		bigint	,	@Quantity_A_6		int
,	@ItemUID_A_7		bigint	,	@Quantity_A_7		int
,	@ItemUID_A_8		bigint	,	@Quantity_A_8		int
,	@ItemUID_A_9		bigint	,	@Quantity_A_9		int
,	@ItemUID_B_0		bigint	,	@Quantity_B_0		int
,	@ItemUID_B_1		bigint	,	@Quantity_B_1		int
,	@ItemUID_B_2		bigint	,	@Quantity_B_2		int
,	@ItemUID_B_3		bigint	,	@Quantity_B_3		int
,	@ItemUID_B_4		bigint	,	@Quantity_B_4		int
,	@ItemUID_B_5		bigint	,	@Quantity_B_5		int
,	@ItemUID_B_6		bigint	,	@Quantity_B_6		int
,	@ItemUID_B_7		bigint	,	@Quantity_B_7		int
,	@ItemUID_B_8		bigint	,	@Quantity_B_8		int
,	@ItemUID_B_9		bigint	,	@Quantity_B_9		int

AS
	SET NOCOUNT ON;

	DECLARE @strErrorMSG	nvarchar(max)
	,		@strErrorMSGED	nvarchar(max)

		,	@sdtNow			smalldatetime
	SET @strErrorMSG = N'%s [P_GItem_Total_Trade_New @UnitUID_A = %I64d, @UnitUID_B = %I64d, @Quantity_A_0 = %d, @ItemUID_A_0 = %I64d, @TradeType = %d, @Result = %d]'
	SET @strErrorMSGED = N'%s [P_GItem_Total_Trade_New @UnitUID_A = %I64d, @ED_A = %d, @Result = %d]'
	SET @sdtNow = GETDATE()

	DECLARE @Result	int		
		,	@InsertType	tinyint 
		,	@Reason		tinyint
		,	@Result_A_0 int	, @Result_A_0_I bigint
		,	@Result_A_1 int	, @Result_A_1_I bigint
		,	@Result_A_2 int	, @Result_A_2_I bigint
		,	@Result_A_3 int	, @Result_A_3_I bigint
		,	@Result_A_4 int	, @Result_A_4_I bigint
		,	@Result_A_5 int	, @Result_A_5_I bigint
		,	@Result_A_6 int	, @Result_A_6_I bigint
		,	@Result_A_7 int	, @Result_A_7_I bigint
		,	@Result_A_8 int	, @Result_A_8_I bigint
		,	@Result_A_9 int	, @Result_A_9_I bigint
		,	@Result_B_0 int	, @Result_B_0_I bigint
		,	@Result_B_1 int	, @Result_B_1_I bigint
		,	@Result_B_2 int	, @Result_B_2_I bigint
		,	@Result_B_3 int	, @Result_B_3_I bigint
		,	@Result_B_4 int	, @Result_B_4_I bigint
		,	@Result_B_5 int	, @Result_B_5_I bigint
		,	@Result_B_6 int	, @Result_B_6_I bigint
		,	@Result_B_7 int	, @Result_B_7_I bigint
		,	@Result_B_8 int	, @Result_B_8_I bigint
		,	@Result_B_9 int	, @Result_B_9_I bigint

	-- 해당유닛이 있는 경우.
	IF NOT EXISTS ( SELECT UnitUID FROM dbo.GUnit WITH( NOLOCK ) WHERE UnitUID = @UnitUID_A AND Deleted = 0 )
		SET @Result = -10
	ELSE IF NOT EXISTS ( SELECT UnitUID FROM dbo.GUnit WITH( NOLOCK ) WHERE UnitUID = @UnitUID_B AND Deleted = 0 )
		SET @Result = -11
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN
				-- ED 마이너스 체크 및 업데이트
				IF @ED_A <> 0 BEGIN
					UPDATE dbo.GUnit
					SET GamePoint = GamePoint + @ED_A
						OUTPUT INSERTED.UnitUID, INSERTED.GamePoint - DELETED.GamePoint, @sdtNow
						INTO dbo.GUnit_ED ( UnitUID, GamePoint, RegDate)
					WHERE UnitUID = @UnitUID_A
						AND GamePoint + @ED_A >= 0

					IF @@ROWCOUNT <> 1 BEGIN
						SET @Result = -90
						RAISERROR(@strErrorMSGED, 15, 1, N'GUnit GamePoint A', @UnitUID_A, @ED_A, @Result) WITH SETERROR
					END
				END

				IF @ED_B <> 0 BEGIN
					UPDATE dbo.GUnit
					SET GamePoint = GamePoint + @ED_B
						OUTPUT INSERTED.UnitUID, INSERTED.GamePoint - DELETED.GamePoint, @sdtNow
						INTO dbo.GUnit_ED ( UnitUID, GamePoint, RegDate)
					WHERE UnitUID = @UnitUID_B
						AND GamePoint + @ED_B >= 0

					IF @@ROWCOUNT <> 1 BEGIN
						SET @Result = -91
						RAISERROR(@strErrorMSGED, 15, 1, N'GUnit GamePoint B', @UnitUID_B, @ED_B, @Result) WITH SETERROR
					END
				END

				SET @InsertType = CASE WHEN @TradeType = 5 THEN 113 ELSE 105 END
				SET	@Reason = CASE WHEN @TradeType = 5 THEN 6 ELSE 5 END
				SET @Result = -101

				-- 개인거래 및 상점 거래
				-- A -> B (INSERT)
				IF @ItemUID_A_0 > 0 BEGIN
					EXEC @Result_A_0 = dbo.P_GItem_INT_DEL_New @UnitUID_A, @UnitUID_B, @Quantity_A_0, @ItemUID_A_0, @InsertType, @Reason, @Result_A_0_I OUTPUT

					IF @Result_A_0 < 0
						RAISERROR(@strErrorMSG, 15, 1, N'P_GItem_INT_DEL_New, ', @UnitUID_A, @UnitUID_B, @Quantity_A_0, @ItemUID_A_0, @TradeType, @Result_A_0) WITH SETERROR
				END

				-- 개인거래
				IF @TradeType = 6 BEGIN
					IF @ItemUID_A_1 > 0 BEGIN
						EXEC @Result_A_1 = dbo.P_GItem_INT_DEL_New @UnitUID_A, @UnitUID_B, @Quantity_A_1, @ItemUID_A_1, @InsertType, @Reason, @Result_A_1_I OUTPUT

						IF @Result_A_1 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GItem_INT_DEL_New, ', @UnitUID_A, @UnitUID_B, @Quantity_A_1, @ItemUID_A_1, @TradeType, @Result_A_1) WITH SETERROR
					END
					IF @ItemUID_A_2 > 0 BEGIN
						EXEC @Result_A_2 = dbo.P_GItem_INT_DEL_New @UnitUID_A, @UnitUID_B, @Quantity_A_2, @ItemUID_A_2, @InsertType, @Reason, @Result_A_2_I OUTPUT

						IF @Result_A_2 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GItem_INT_DEL_New, ', @UnitUID_A, @UnitUID_B, @Quantity_A_2, @ItemUID_A_2, @TradeType, @Result_A_2) WITH SETERROR
					END
					IF @ItemUID_A_3 > 0 BEGIN
						EXEC @Result_A_3 = dbo.P_GItem_INT_DEL_New @UnitUID_A, @UnitUID_B, @Quantity_A_3, @ItemUID_A_3, @InsertType, @Reason, @Result_A_3_I OUTPUT

						IF @Result_A_3 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GItem_INT_DEL_New, ', @UnitUID_A, @UnitUID_B, @Quantity_A_3, @ItemUID_A_3, @TradeType, @Result_A_3) WITH SETERROR
					END
					IF @ItemUID_A_4 > 0 BEGIN
						EXEC @Result_A_4 = dbo.P_GItem_INT_DEL_New @UnitUID_A, @UnitUID_B, @Quantity_A_4, @ItemUID_A_4, @InsertType, @Reason, @Result_A_4_I OUTPUT

						IF @Result_A_4 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GItem_INT_DEL_New, ', @UnitUID_A, @UnitUID_B, @Quantity_A_4, @ItemUID_A_4, @TradeType, @Result_A_4) WITH SETERROR
					END
					IF @ItemUID_A_5 > 0 BEGIN
						EXEC @Result_A_5 = dbo.P_GItem_INT_DEL_New @UnitUID_A, @UnitUID_B, @Quantity_A_5, @ItemUID_A_5, @InsertType, @Reason, @Result_A_5_I OUTPUT

						IF @Result_A_5 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GItem_INT_DEL_New, ', @UnitUID_A, @UnitUID_B, @Quantity_A_5, @ItemUID_A_5, @TradeType, @Result_A_5) WITH SETERROR
					END
					IF @ItemUID_A_6 > 0 BEGIN
						EXEC @Result_A_6 = dbo.P_GItem_INT_DEL_New @UnitUID_A, @UnitUID_B, @Quantity_A_6, @ItemUID_A_6, @InsertType, @Reason, @Result_A_6_I OUTPUT

						IF @Result_A_6 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GItem_INT_DEL_New, ', @UnitUID_A, @UnitUID_B, @Quantity_A_6, @ItemUID_A_6, @TradeType, @Result_A_6) WITH SETERROR
					END
					IF @ItemUID_A_7 > 0 BEGIN
						EXEC @Result_A_7 = dbo.P_GItem_INT_DEL_New @UnitUID_A, @UnitUID_B, @Quantity_A_7, @ItemUID_A_7, @InsertType, @Reason, @Result_A_7_I OUTPUT

						IF @Result_A_7 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GItem_INT_DEL_New, ', @UnitUID_A, @UnitUID_B, @Quantity_A_7, @ItemUID_A_7, @TradeType, @Result_A_7) WITH SETERROR
					END
					IF @ItemUID_A_8 > 0 BEGIN
						EXEC @Result_A_8 = dbo.P_GItem_INT_DEL_New @UnitUID_A, @UnitUID_B, @Quantity_A_8, @ItemUID_A_8, @InsertType, @Reason, @Result_A_8_I OUTPUT

						IF @Result_A_8 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GItem_INT_DEL_New, ', @UnitUID_A, @UnitUID_B, @Quantity_A_8, @ItemUID_A_8, @TradeType, @Result_A_8) WITH SETERROR
					END
					IF @ItemUID_A_9 > 0 BEGIN
						EXEC @Result_A_9 = dbo.P_GItem_INT_DEL_New @UnitUID_A, @UnitUID_B, @Quantity_A_9, @ItemUID_A_9, @InsertType, @Reason, @Result_A_9_I OUTPUT

						IF @Result_A_9 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GItem_INT_DEL_New, ', @UnitUID_A, @UnitUID_B, @Quantity_A_9, @ItemUID_A_9, @TradeType, @Result_A_9) WITH SETERROR
					END

					-- B -> A (INSERT)
					IF @ItemUID_B_0 > 0 BEGIN
						EXEC @Result_B_0 = dbo.P_GItem_INT_DEL_New @UnitUID_B, @UnitUID_A, @Quantity_B_0, @ItemUID_B_0, @InsertType, @Reason, @Result_B_0_I OUTPUT

						IF @Result_B_0 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GItem_INT_DEL_New, ', @UnitUID_B, @UnitUID_A, @Quantity_B_0, @ItemUID_B_0, @TradeType, @Result_B_0) WITH SETERROR
					END
					IF @ItemUID_B_1 > 0 BEGIN
						EXEC @Result_B_1 = dbo.P_GItem_INT_DEL_New @UnitUID_B, @UnitUID_A, @Quantity_B_1, @ItemUID_B_1, @InsertType, @Reason, @Result_B_1_I OUTPUT

						IF @Result_B_1 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GItem_INT_DEL_New, ', @UnitUID_B, @UnitUID_A, @Quantity_B_1, @ItemUID_B_1, @TradeType, @Result_B_1) WITH SETERROR
					END
					IF @ItemUID_B_2 > 0 BEGIN
						EXEC @Result_B_2 = dbo.P_GItem_INT_DEL_New @UnitUID_B, @UnitUID_A, @Quantity_B_2, @ItemUID_B_2, @InsertType, @Reason, @Result_B_2_I OUTPUT

						IF @Result_B_2 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GItem_INT_DEL_New, ', @UnitUID_B, @UnitUID_A, @Quantity_B_2, @ItemUID_B_2, @TradeType, @Result_B_2) WITH SETERROR
					END
					IF @ItemUID_B_3 > 0 BEGIN
						EXEC @Result_B_3 = dbo.P_GItem_INT_DEL_New @UnitUID_B, @UnitUID_A, @Quantity_B_3, @ItemUID_B_3, @InsertType, @Reason, @Result_B_3_I OUTPUT

						IF @Result_B_3 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GItem_INT_DEL_New, ', @UnitUID_B, @UnitUID_A, @Quantity_B_3, @ItemUID_B_3, @TradeType, @Result_B_3) WITH SETERROR
					END
					IF @ItemUID_B_4 > 0 BEGIN
						EXEC @Result_B_4 = dbo.P_GItem_INT_DEL_New @UnitUID_B, @UnitUID_A, @Quantity_B_4, @ItemUID_B_4, @InsertType, @Reason, @Result_B_4_I OUTPUT

						IF @Result_B_4 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GItem_INT_DEL_New, ', @UnitUID_B, @UnitUID_A, @Quantity_B_4, @ItemUID_B_4, @TradeType, @Result_B_4) WITH SETERROR
					END
					IF @ItemUID_B_5 > 0 BEGIN
						EXEC @Result_B_5 = dbo.P_GItem_INT_DEL_New @UnitUID_B, @UnitUID_A, @Quantity_B_5, @ItemUID_B_5, @InsertType, @Reason, @Result_B_5_I OUTPUT

						IF @Result_B_5 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GItem_INT_DEL_New, ', @UnitUID_B, @UnitUID_A, @Quantity_B_5, @ItemUID_B_5, @TradeType, @Result_B_5) WITH SETERROR
					END
					IF @ItemUID_B_6 > 0 BEGIN
						EXEC @Result_B_6 = dbo.P_GItem_INT_DEL_New @UnitUID_B, @UnitUID_A, @Quantity_B_6, @ItemUID_B_6, @InsertType, @Reason, @Result_B_6_I OUTPUT

						IF @Result_B_6 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GItem_INT_DEL_New, ', @UnitUID_B, @UnitUID_A, @Quantity_B_6, @ItemUID_B_6, @TradeType, @Result_B_6) WITH SETERROR
					END
					IF @ItemUID_B_7 > 0 BEGIN
						EXEC @Result_B_7 = dbo.P_GItem_INT_DEL_New @UnitUID_B, @UnitUID_A, @Quantity_B_7, @ItemUID_B_7, @InsertType, @Reason, @Result_B_7_I OUTPUT

						IF @Result_B_7 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GItem_INT_DEL_New, ', @UnitUID_B, @UnitUID_A, @Quantity_B_7, @ItemUID_B_7, @TradeType, @Result_B_7) WITH SETERROR
					END
					IF @ItemUID_B_8 > 0 BEGIN
						EXEC @Result_B_8 = dbo.P_GItem_INT_DEL_New @UnitUID_B, @UnitUID_A, @Quantity_B_8, @ItemUID_B_8, @InsertType, @Reason, @Result_B_8_I OUTPUT

						IF @Result_B_8 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GItem_INT_DEL_New, ', @UnitUID_B, @UnitUID_A, @Quantity_B_8, @ItemUID_B_8, @TradeType, @Result_B_8) WITH SETERROR
					END
					IF @ItemUID_B_9 > 0 BEGIN
						EXEC @Result_B_9 = dbo.P_GItem_INT_DEL_New @UnitUID_B, @UnitUID_A, @Quantity_B_9, @ItemUID_B_9, @InsertType, @Reason, @Result_B_9_I OUTPUT

						IF @Result_B_9 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GItem_INT_DEL_New, ', @UnitUID_B, @UnitUID_A, @Quantity_B_9, @ItemUID_B_9, @TradeType, @Result_B_9) WITH SETERROR
					END

				END

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
	END

	SELECT	@Result AS Result,
			@Result_A_0_I AS ItemUID_A_0_N, @Result_A_1_I AS ItemUID_A_1_N,
			@Result_A_2_I AS ItemUID_A_2_N, @Result_A_3_I AS ItemUID_A_3_N,
			@Result_A_4_I AS ItemUID_A_4_N, @Result_A_5_I AS ItemUID_A_5_N,
			@Result_A_6_I AS ItemUID_A_6_N, @Result_A_7_I AS ItemUID_A_7_N,
			@Result_A_8_I AS ItemUID_A_8_N, @Result_A_9_I AS ItemUID_A_9_N,
			@Result_B_0_I AS ItemUID_B_0_N, @Result_B_1_I AS ItemUID_B_1_N,
			@Result_B_2_I AS ItemUID_B_2_N, @Result_B_3_I AS ItemUID_B_3_N,
			@Result_B_4_I AS ItemUID_B_4_N, @Result_B_5_I AS ItemUID_B_5_N,
			@Result_B_6_I AS ItemUID_B_6_N, @Result_B_7_I AS ItemUID_B_7_N,
			@Result_B_8_I AS ItemUID_B_8_N, @Result_B_9_I AS ItemUID_B_9_N
GO
-- =============================================
-- Author: Hwang
-- Create date: 2012-04-17
-- Description:	아이템거래(이동) SP
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GItem_Total_Trade]
	@TradeType			tinyint			-- 개인상점: 5, 개인거래: 6
,	@UnitUID_A			bigint
,	@UnitUID_B			bigint
,	@ED_A				int
,	@ED_B				int
,	@ItemUID_A_0		bigint	,	@Quantity_A_0		int
,	@ItemUID_A_1		bigint	,	@Quantity_A_1		int
,	@ItemUID_A_2		bigint	,	@Quantity_A_2		int
,	@ItemUID_A_3		bigint	,	@Quantity_A_3		int
,	@ItemUID_A_4		bigint	,	@Quantity_A_4		int
,	@ItemUID_A_5		bigint	,	@Quantity_A_5		int
,	@ItemUID_A_6		bigint	,	@Quantity_A_6		int
,	@ItemUID_A_7		bigint	,	@Quantity_A_7		int
,	@ItemUID_A_8		bigint	,	@Quantity_A_8		int
,	@ItemUID_A_9		bigint	,	@Quantity_A_9		int
,	@ItemUID_B_0		bigint	,	@Quantity_B_0		int
,	@ItemUID_B_1		bigint	,	@Quantity_B_1		int
,	@ItemUID_B_2		bigint	,	@Quantity_B_2		int
,	@ItemUID_B_3		bigint	,	@Quantity_B_3		int
,	@ItemUID_B_4		bigint	,	@Quantity_B_4		int
,	@ItemUID_B_5		bigint	,	@Quantity_B_5		int
,	@ItemUID_B_6		bigint	,	@Quantity_B_6		int
,	@ItemUID_B_7		bigint	,	@Quantity_B_7		int
,	@ItemUID_B_8		bigint	,	@Quantity_B_8		int
,	@ItemUID_B_9		bigint	,	@Quantity_B_9		int

AS
	SET NOCOUNT ON;

	DECLARE @strErrorMSG	nvarchar(max)
	,		@strErrorMSGED	nvarchar(max)

		,	@sdtNow			smalldatetime
	SET @strErrorMSG = N'%s [P_GItem_Total_Trade @UnitUID_A = %I64d, @UnitUID_B = %I64d, @Quantity_A_0 = %d, @ItemUID_A_0 = %I64d, @TradeType = %d, @Result = %d]'
	SET @strErrorMSGED = N'%s [P_GItem_Total_Trade @UnitUID_A = %I64d, @ED_A = %d, @Result = %d]'
	SET @sdtNow = GETDATE()

	DECLARE @Result	int	, @InsertType	tinyint , @Reason	tinyint
		,	@Result_A_0 int	, @Result_A_0_I bigint 
		,	@Result_A_1 int, @Result_A_1_I bigint
		,	@Result_A_2 int, @Result_A_2_I bigint
		,	@Result_A_3 int, @Result_A_3_I bigint
		,	@Result_A_4 int, @Result_A_4_I bigint
		,	@Result_A_5 int, @Result_A_5_I bigint
		,	@Result_A_6 int, @Result_A_6_I bigint
		,	@Result_A_7 int, @Result_A_7_I bigint
		,	@Result_A_8 int, @Result_A_8_I bigint
		,	@Result_A_9 int, @Result_A_9_I bigint
		,	@Result_B_0 int, @Result_B_0_I bigint
		,	@Result_B_1 int, @Result_B_1_I bigint
		,	@Result_B_2 int, @Result_B_2_I bigint
		,	@Result_B_3 int, @Result_B_3_I bigint
		,	@Result_B_4 int, @Result_B_4_I bigint
		,	@Result_B_5 int, @Result_B_5_I bigint
		,	@Result_B_6 int, @Result_B_6_I bigint
		,	@Result_B_7 int, @Result_B_7_I bigint
		,	@Result_B_8 int, @Result_B_8_I bigint
		,	@Result_B_9 int, @Result_B_9_I bigint
		
	-- 2005는 기본값 할당 따로해야 됨
	SET @Result_A_0 = 0;	SET @Result_A_0_I = 0;
	SET @Result_A_1 = 0;	SET @Result_A_1_I = 0;
	SET @Result_A_2 = 0;	SET @Result_A_2_I = 0;
	SET @Result_A_3 = 0;	SET @Result_A_3_I = 0;
	SET @Result_A_4 = 0;	SET @Result_A_4_I = 0;
	SET @Result_A_5 = 0;	SET @Result_A_5_I = 0;
	SET @Result_A_6 = 0;	SET @Result_A_6_I = 0;
	SET @Result_A_7 = 0;	SET @Result_A_7_I = 0;
	SET @Result_A_8 = 0;	SET @Result_A_8_I = 0;
	SET @Result_A_9 = 0;	SET @Result_A_9_I = 0;
	SET @Result_B_0 = 0;	SET @Result_B_0_I = 0;
	SET @Result_B_1 = 0;	SET @Result_B_1_I = 0;
	SET @Result_B_2 = 0;	SET @Result_B_2_I = 0;
	SET @Result_B_3 = 0;	SET @Result_B_3_I = 0;
	SET @Result_B_4 = 0;	SET @Result_B_4_I = 0;
	SET @Result_B_5 = 0;	SET @Result_B_5_I = 0;
	SET @Result_B_6 = 0;	SET @Result_B_6_I = 0;
	SET @Result_B_7 = 0;	SET @Result_B_7_I = 0;
	SET @Result_B_8 = 0;	SET @Result_B_8_I = 0;
	SET @Result_B_9 = 0;	SET @Result_B_9_I = 0;

	-- 해당유닛이 있는 경우.
	IF NOT EXISTS ( SELECT UnitUID FROM dbo.GUnit WITH( NOLOCK ) WHERE UnitUID = @UnitUID_A AND Deleted = 0 )
		SET @Result = -10
	ELSE IF NOT EXISTS ( SELECT UnitUID FROM dbo.GUnit WITH( NOLOCK ) WHERE UnitUID = @UnitUID_B AND Deleted = 0 )
		SET @Result = -11
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN
				-- ED 마이너스 체크 및 업데이트
				IF @ED_A <> 0 BEGIN
					UPDATE dbo.GUnit
					SET GamePoint = GamePoint + @ED_A
						OUTPUT INSERTED.UnitUID, INSERTED.GamePoint - DELETED.GamePoint, @sdtNow
						INTO dbo.GUnit_ED ( UnitUID, GamePoint, RegDate)
					WHERE UnitUID = @UnitUID_A
						AND GamePoint + @ED_A >= 0

					IF @@ROWCOUNT <> 1 BEGIN
						SET @Result = -90
						RAISERROR(@strErrorMSGED, 15, 1, N'GUnit GamePoint A', @UnitUID_A, @ED_A, @Result) WITH SETERROR
					END
				END

				IF @ED_B <> 0 BEGIN
					UPDATE dbo.GUnit
					SET GamePoint = GamePoint + @ED_B
						OUTPUT INSERTED.UnitUID, INSERTED.GamePoint - DELETED.GamePoint, @sdtNow
						INTO dbo.GUnit_ED ( UnitUID, GamePoint, RegDate)
					WHERE UnitUID = @UnitUID_B
						AND GamePoint + @ED_B >= 0

					IF @@ROWCOUNT <> 1 BEGIN
						SET @Result = -91
						RAISERROR(@strErrorMSGED, 15, 1, N'GUnit GamePoint B', @UnitUID_B, @ED_B, @Result) WITH SETERROR
					END
				END

				SET @InsertType = CASE WHEN @TradeType = 5 THEN 113 ELSE 105 END
				SET	@Reason = CASE WHEN @TradeType = 5 THEN 6 ELSE 5 END
				SET @Result = -101

				-- 개인거래 및 상점 거래
				-- A -> B (INSERT)
				IF @ItemUID_A_0 > 0 BEGIN
					EXEC @Result_A_0 = dbo.P_GItem_INT_DEL @UnitUID_A, @UnitUID_B, @Quantity_A_0, @ItemUID_A_0, @InsertType, @Reason, @Result_A_0_I OUTPUT

					IF @Result_A_0 < 0
						RAISERROR(@strErrorMSG, 15, 1, N'P_GItem_INT_DEL, ', @UnitUID_A, @UnitUID_B, @Quantity_A_0, @ItemUID_A_0, @TradeType, @Result_A_0) WITH SETERROR
				END

				-- 개인거래
				IF @TradeType = 6 BEGIN
					IF @ItemUID_A_1 > 0 BEGIN
						EXEC @Result_A_1 = dbo.P_GItem_INT_DEL @UnitUID_A, @UnitUID_B, @Quantity_A_1, @ItemUID_A_1, @InsertType, @Reason, @Result_A_1_I OUTPUT

						IF @Result_A_1 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GItem_INT_DEL, ', @UnitUID_A, @UnitUID_B, @Quantity_A_1, @ItemUID_A_1, @TradeType, @Result_A_1) WITH SETERROR
					END
					IF @ItemUID_A_2 > 0 BEGIN
						EXEC @Result_A_2 = dbo.P_GItem_INT_DEL @UnitUID_A, @UnitUID_B, @Quantity_A_2, @ItemUID_A_2, @InsertType, @Reason, @Result_A_2_I OUTPUT

						IF @Result_A_2 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GItem_INT_DEL, ', @UnitUID_A, @UnitUID_B, @Quantity_A_2, @ItemUID_A_2, @TradeType, @Result_A_2) WITH SETERROR
					END
					IF @ItemUID_A_3 > 0 BEGIN
						EXEC @Result_A_3 = dbo.P_GItem_INT_DEL @UnitUID_A, @UnitUID_B, @Quantity_A_3, @ItemUID_A_3, @InsertType, @Reason, @Result_A_3_I OUTPUT

						IF @Result_A_3 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GItem_INT_DEL, ', @UnitUID_A, @UnitUID_B, @Quantity_A_3, @ItemUID_A_3, @TradeType, @Result_A_3) WITH SETERROR
					END
					IF @ItemUID_A_4 > 0 BEGIN
						EXEC @Result_A_4 = dbo.P_GItem_INT_DEL @UnitUID_A, @UnitUID_B, @Quantity_A_4, @ItemUID_A_4, @InsertType, @Reason, @Result_A_4_I OUTPUT

						IF @Result_A_4 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GItem_INT_DEL, ', @UnitUID_A, @UnitUID_B, @Quantity_A_4, @ItemUID_A_4, @TradeType, @Result_A_4) WITH SETERROR
					END
					IF @ItemUID_A_5 > 0 BEGIN
						EXEC @Result_A_5 = dbo.P_GItem_INT_DEL @UnitUID_A, @UnitUID_B, @Quantity_A_5, @ItemUID_A_5, @InsertType, @Reason, @Result_A_5_I OUTPUT

						IF @Result_A_5 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GItem_INT_DEL, ', @UnitUID_A, @UnitUID_B, @Quantity_A_5, @ItemUID_A_5, @TradeType, @Result_A_5) WITH SETERROR
					END
					IF @ItemUID_A_6 > 0 BEGIN
						EXEC @Result_A_6 = dbo.P_GItem_INT_DEL @UnitUID_A, @UnitUID_B, @Quantity_A_6, @ItemUID_A_6, @InsertType, @Reason, @Result_A_6_I OUTPUT

						IF @Result_A_6 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GItem_INT_DEL, ', @UnitUID_A, @UnitUID_B, @Quantity_A_6, @ItemUID_A_6, @TradeType, @Result_A_6) WITH SETERROR
					END
					IF @ItemUID_A_7 > 0 BEGIN
						EXEC @Result_A_7 = dbo.P_GItem_INT_DEL @UnitUID_A, @UnitUID_B, @Quantity_A_7, @ItemUID_A_7, @InsertType, @Reason, @Result_A_7_I OUTPUT

						IF @Result_A_7 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GItem_INT_DEL, ', @UnitUID_A, @UnitUID_B, @Quantity_A_7, @ItemUID_A_7, @TradeType, @Result_A_7) WITH SETERROR
					END
					IF @ItemUID_A_8 > 0 BEGIN
						EXEC @Result_A_8 = dbo.P_GItem_INT_DEL @UnitUID_A, @UnitUID_B, @Quantity_A_8, @ItemUID_A_8, @InsertType, @Reason, @Result_A_8_I OUTPUT

						IF @Result_A_8 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GItem_INT_DEL, ', @UnitUID_A, @UnitUID_B, @Quantity_A_8, @ItemUID_A_8, @TradeType, @Result_A_8) WITH SETERROR
					END
					IF @ItemUID_A_9 > 0 BEGIN
						EXEC @Result_A_9 = dbo.P_GItem_INT_DEL @UnitUID_A, @UnitUID_B, @Quantity_A_9, @ItemUID_A_9, @InsertType, @Reason, @Result_A_9_I OUTPUT

						IF @Result_A_9 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GItem_INT_DEL, ', @UnitUID_A, @UnitUID_B, @Quantity_A_9, @ItemUID_A_9, @TradeType, @Result_A_9) WITH SETERROR
					END

					-- B -> A (INSERT)
					IF @ItemUID_B_0 > 0 BEGIN
						EXEC @Result_B_0 = dbo.P_GItem_INT_DEL @UnitUID_B, @UnitUID_A, @Quantity_B_0, @ItemUID_B_0, @InsertType, @Reason, @Result_B_0_I OUTPUT

						IF @Result_B_0 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GItem_INT_DEL, ', @UnitUID_B, @UnitUID_A, @Quantity_B_0, @ItemUID_B_0, @TradeType, @Result_B_0) WITH SETERROR
					END
					IF @ItemUID_B_1 > 0 BEGIN
						EXEC @Result_B_1 = dbo.P_GItem_INT_DEL @UnitUID_B, @UnitUID_A, @Quantity_B_1, @ItemUID_B_1, @InsertType, @Reason, @Result_B_1_I OUTPUT

						IF @Result_B_1 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GItem_INT_DEL, ', @UnitUID_B, @UnitUID_A, @Quantity_B_1, @ItemUID_B_1, @TradeType, @Result_B_1) WITH SETERROR
					END
					IF @ItemUID_B_2 > 0 BEGIN
						EXEC @Result_B_2 = dbo.P_GItem_INT_DEL @UnitUID_B, @UnitUID_A, @Quantity_B_2, @ItemUID_B_2, @InsertType, @Reason, @Result_B_2_I OUTPUT

						IF @Result_B_2 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GItem_INT_DEL, ', @UnitUID_B, @UnitUID_A, @Quantity_B_2, @ItemUID_B_2, @TradeType, @Result_B_2) WITH SETERROR
					END
					IF @ItemUID_B_3 > 0 BEGIN
						EXEC @Result_B_3 = dbo.P_GItem_INT_DEL @UnitUID_B, @UnitUID_A, @Quantity_B_3, @ItemUID_B_3, @InsertType, @Reason, @Result_B_3_I OUTPUT

						IF @Result_B_3 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GItem_INT_DEL, ', @UnitUID_B, @UnitUID_A, @Quantity_B_3, @ItemUID_B_3, @TradeType, @Result_B_3) WITH SETERROR
					END
					IF @ItemUID_B_4 > 0 BEGIN
						EXEC @Result_B_4 = dbo.P_GItem_INT_DEL @UnitUID_B, @UnitUID_A, @Quantity_B_4, @ItemUID_B_4, @InsertType, @Reason, @Result_B_4_I OUTPUT

						IF @Result_B_4 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GItem_INT_DEL, ', @UnitUID_B, @UnitUID_A, @Quantity_B_4, @ItemUID_B_4, @TradeType, @Result_B_4) WITH SETERROR
					END
					IF @ItemUID_B_5 > 0 BEGIN
						EXEC @Result_B_5 = dbo.P_GItem_INT_DEL @UnitUID_B, @UnitUID_A, @Quantity_B_5, @ItemUID_B_5, @InsertType, @Reason, @Result_B_5_I OUTPUT

						IF @Result_B_5 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GItem_INT_DEL, ', @UnitUID_B, @UnitUID_A, @Quantity_B_5, @ItemUID_B_5, @TradeType, @Result_B_5) WITH SETERROR
					END
					IF @ItemUID_B_6 > 0 BEGIN
						EXEC @Result_B_6 = dbo.P_GItem_INT_DEL @UnitUID_B, @UnitUID_A, @Quantity_B_6, @ItemUID_B_6, @InsertType, @Reason, @Result_B_6_I OUTPUT

						IF @Result_B_6 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GItem_INT_DEL, ', @UnitUID_B, @UnitUID_A, @Quantity_B_6, @ItemUID_B_6, @TradeType, @Result_B_6) WITH SETERROR
					END
					IF @ItemUID_B_7 > 0 BEGIN
						EXEC @Result_B_7 = dbo.P_GItem_INT_DEL @UnitUID_B, @UnitUID_A, @Quantity_B_7, @ItemUID_B_7, @InsertType, @Reason, @Result_B_7_I OUTPUT

						IF @Result_B_7 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GItem_INT_DEL, ', @UnitUID_B, @UnitUID_A, @Quantity_B_7, @ItemUID_B_7, @TradeType, @Result_B_7) WITH SETERROR
					END
					IF @ItemUID_B_8 > 0 BEGIN
						EXEC @Result_B_8 = dbo.P_GItem_INT_DEL @UnitUID_B, @UnitUID_A, @Quantity_B_8, @ItemUID_B_8, @InsertType, @Reason, @Result_B_8_I OUTPUT

						IF @Result_B_8 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GItem_INT_DEL, ', @UnitUID_B, @UnitUID_A, @Quantity_B_8, @ItemUID_B_8, @TradeType, @Result_B_8) WITH SETERROR
					END
					IF @ItemUID_B_9 > 0 BEGIN
						EXEC @Result_B_9 = dbo.P_GItem_INT_DEL @UnitUID_B, @UnitUID_A, @Quantity_B_9, @ItemUID_B_9, @InsertType, @Reason, @Result_B_9_I OUTPUT

						IF @Result_B_9 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GItem_INT_DEL, ', @UnitUID_B, @UnitUID_A, @Quantity_B_9, @ItemUID_B_9, @TradeType, @Result_B_9) WITH SETERROR
					END

				END

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
	END

	SELECT @Result AS Result,
		 @Result_A_0_I AS ItemUID_A_0_N, @Result_A_1_I AS ItemUID_A_1_N, @Result_A_2_I AS ItemUID_A_2_N, @Result_A_3_I AS ItemUID_A_3_N, @Result_A_4_I AS ItemUID_A_4_N,
		 @Result_A_5_I AS ItemUID_A_5_N, @Result_A_6_I AS ItemUID_A_6_N, @Result_A_7_I AS ItemUID_A_7_N, @Result_A_8_I AS ItemUID_A_8_N, @Result_A_9_I AS ItemUID_A_9_N,
		 @Result_B_0_I AS ItemUID_B_0_N, @Result_B_1_I AS ItemUID_B_1_N, @Result_B_2_I AS ItemUID_B_2_N, @Result_B_3_I AS ItemUID_B_3_N, @Result_B_4_I AS ItemUID_B_4_N,
		 @Result_B_5_I AS ItemUID_B_5_N, @Result_B_6_I AS ItemUID_B_6_N, @Result_B_7_I AS ItemUID_B_7_N, @Result_B_8_I AS ItemUID_B_8_N, @Result_B_9_I AS ItemUID_B_9_N
GO
-- =============================================
-- Author: Hwang
-- Create date: 2012-06-05
-- Description:	대리상점 통합 SP
--				(랜덤소켓 부분 추가)
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GItem_Total_Pshop_New]
	@TradeType		tinyint			-- 물품등록: 2, 물품판매: 3, 물품회수: 4
,	@UnitUID_A		bigint			-- 판매자
,	@UnitUID_B		bigint			-- 구매자
,	@ED_A			int				-- 판매자 증감 ED
,	@ED_B			int				-- 구매자 증감 ED
,	@ItemUID_A_0	bigint ,	@Quantity_A_0	int,	@PricePerOne_A_0	int	,	@Category_A_0	tinyint
,	@ItemUID_A_1	bigint ,	@Quantity_A_1	int,	@PricePerOne_A_1	int	,	@Category_A_1	tinyint
,	@ItemUID_A_2	bigint ,	@Quantity_A_2	int,	@PricePerOne_A_2	int	,	@Category_A_2	tinyint
,	@ItemUID_A_3	bigint ,	@Quantity_A_3	int,	@PricePerOne_A_3	int	,	@Category_A_3	tinyint
,	@ItemUID_A_4	bigint ,	@Quantity_A_4	int,	@PricePerOne_A_4	int	,	@Category_A_4	tinyint
,	@ItemUID_A_5	bigint ,	@Quantity_A_5	int,	@PricePerOne_A_5	int	,	@Category_A_5	tinyint
,	@ItemUID_A_6	bigint ,	@Quantity_A_6	int,	@PricePerOne_A_6	int	,	@Category_A_6	tinyint
,	@ItemUID_A_7	bigint ,	@Quantity_A_7	int,	@PricePerOne_A_7	int	,	@Category_A_7	tinyint
,	@ItemUID_A_8	bigint ,	@Quantity_A_8	int,	@PricePerOne_A_8	int	,	@Category_A_8	tinyint
,	@PShopName		nvarchar(50)


AS
	SET NOCOUNT ON;	
	
	DECLARE @strErrorMSG	nvarchar(max)
		,	@sdtNow			smalldatetime
	SET @strErrorMSG = N'%s [P_GItem_Total_Pshop_New @UnitUID_A = %I64d, @UnitUID_B = %I64d, @Quantity_A_0 = %d, @ItemUID_A_0 = %I64d, @Result = %d]'
	SET @sdtNow = GETDATE()
	
	DECLARE @Result		int			
		,	@InsertType	tinyint
		,	@Reason		tinyint
		,	@Result_A_0 int,	@Result_A_0_I bigint
		,	@Result_A_1 int,	@Result_A_1_I bigint
		,	@Result_A_2 int,	@Result_A_2_I bigint
		,	@Result_A_3 int,	@Result_A_3_I bigint
		,	@Result_A_4 int,	@Result_A_4_I bigint
		,	@Result_A_5 int,	@Result_A_5_I bigint
		,	@Result_A_6 int,	@Result_A_6_I bigint
		,	@Result_A_7 int,	@Result_A_7_I bigint
		,	@Result_A_8 int,	@Result_A_8_I bigint
		,	@Result_A_9 int,	@Result_A_9_I bigint
		,	@Result_B_0 int,	@Result_B_0_I bigint
		,	@Result_B_1 int,	@Result_B_1_I bigint
		,	@Result_B_2 int,	@Result_B_2_I bigint
		,	@Result_B_3 int,	@Result_B_3_I bigint
		,	@Result_B_4 int,	@Result_B_4_I bigint
		,	@Result_B_5 int,	@Result_B_5_I bigint
		,	@Result_B_6 int,	@Result_B_6_I bigint
		,	@Result_B_7 int,	@Result_B_7_I bigint
		,	@Result_B_8 int,	@Result_B_8_I bigint
		,	@Result_B_9 int,	@Result_B_9_I bigint
	
	-- 해당유닛이 있는 경우.
	IF NOT EXISTS ( SELECT UnitUID FROM dbo.GUnit WITH( NOLOCK ) WHERE UnitUID = @UnitUID_A) 
		SET @Result = -10
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN
			
				-- 대리상점 물품등록
				IF @TradeType = 2 BEGIN
					SET	@Reason = 39
					
					SET @Result = -60
					UPDATE dbo.GPShopInfo
						SET PShopName = @PShopName
					WHERE UnitUID = @UnitUID_A
					
					-- A -> B (INSERT)
					IF @ItemUID_A_0 > 0 BEGIN
						SET @Result = -61
						EXEC @Result_A_0 = dbo.P_GPShopItem_INT_DEL_A_New @UnitUID_A, @Quantity_A_0, @ItemUID_A_0, @PricePerOne_A_0, @Category_A_0, @Reason, @Result_A_0_I OUTPUT
						
						IF @Result_A_0 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GPShopItem_INT_DEL_A_New 2, ', @UnitUID_A, @UnitUID_B, @Quantity_A_0, @ItemUID_A_0, @Result_A_0) WITH SETERROR
					END
					IF @ItemUID_A_1 > 0 BEGIN
						SET @Result = -62
						EXEC @Result_A_1 = dbo.P_GPShopItem_INT_DEL_A_New @UnitUID_A, @Quantity_A_1, @ItemUID_A_1, @PricePerOne_A_1, @Category_A_1, @Reason, @Result_A_1_I OUTPUT
						
						IF @Result_A_1 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GPShopItem_INT_DEL_A_New 2, ', @UnitUID_A, @UnitUID_B, @Quantity_A_1, @ItemUID_A_1, @Result_A_1) WITH SETERROR
					END
					IF @ItemUID_A_2 > 0 BEGIN	
						SET @Result = -63
						EXEC @Result_A_2 = dbo.P_GPShopItem_INT_DEL_A_New @UnitUID_A, @Quantity_A_2, @ItemUID_A_2, @PricePerOne_A_2, @Category_A_2, @Reason, @Result_A_2_I OUTPUT
						
						IF @Result_A_2 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GPShopItem_INT_DEL_A_New 2, ', @UnitUID_A, @UnitUID_B, @Quantity_A_2, @ItemUID_A_2, @Result_A_2) WITH SETERROR
					END
					IF @ItemUID_A_3 > 0 BEGIN
						SET @Result = -64
						EXEC @Result_A_3 = dbo.P_GPShopItem_INT_DEL_A_New @UnitUID_A, @Quantity_A_3, @ItemUID_A_3, @PricePerOne_A_3, @Category_A_3, @Reason, @Result_A_3_I OUTPUT
						
						IF @Result_A_3 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GPShopItem_INT_DEL_A_New 2, ', @UnitUID_A, @UnitUID_B, @Quantity_A_3, @ItemUID_A_3, @Result_A_3) WITH SETERROR
					END
					IF @ItemUID_A_4 > 0 BEGIN
						SET @Result = -65
						EXEC @Result_A_4 = dbo.P_GPShopItem_INT_DEL_A_New @UnitUID_A, @Quantity_A_4, @ItemUID_A_4, @PricePerOne_A_4, @Category_A_4, @Reason, @Result_A_4_I OUTPUT
						
						IF @Result_A_4 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GPShopItem_INT_DEL_A_New 2, ', @UnitUID_A, @UnitUID_B, @Quantity_A_4, @ItemUID_A_4, @Result_A_4) WITH SETERROR
					END																												 
					IF @ItemUID_A_5 > 0 BEGIN
						SET @Result = -66
						EXEC @Result_A_5 = dbo.P_GPShopItem_INT_DEL_A_New @UnitUID_A, @Quantity_A_5, @ItemUID_A_5, @PricePerOne_A_5, @Category_A_5, @Reason, @Result_A_5_I OUTPUT
						
						IF @Result_A_5 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GPShopItem_INT_DEL_A_New 2, ', @UnitUID_A, @UnitUID_B, @Quantity_A_5, @ItemUID_A_5, @Result_A_5) WITH SETERROR
					END																												 
					IF @ItemUID_A_6 > 0 BEGIN
						SET @Result = -67
						EXEC @Result_A_6 = dbo.P_GPShopItem_INT_DEL_A_New @UnitUID_A, @Quantity_A_6, @ItemUID_A_6, @PricePerOne_A_6, @Category_A_6, @Reason, @Result_A_6_I OUTPUT
						
						IF @Result_A_6 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GPShopItem_INT_DEL_A_New 2, ', @UnitUID_A, @UnitUID_B, @Quantity_A_6, @ItemUID_A_6, @Result_A_6) WITH SETERROR
					END																												 
					IF @ItemUID_A_7 > 0 BEGIN
						SET @Result = -68
						EXEC @Result_A_7 = dbo.P_GPShopItem_INT_DEL_A_New @UnitUID_A, @Quantity_A_7, @ItemUID_A_7, @PricePerOne_A_7, @Category_A_7, @Reason, @Result_A_7_I OUTPUT
						
						IF @Result_A_7 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GPShopItem_INT_DEL_A_New 2, ', @UnitUID_A, @UnitUID_B, @Quantity_A_7, @ItemUID_A_7, @Result_A_7) WITH SETERROR
					END																												 
					IF @ItemUID_A_8 > 0 BEGIN
						SET @Result = -69
						EXEC @Result_A_8 = dbo.P_GPShopItem_INT_DEL_A_New @UnitUID_A, @Quantity_A_8, @ItemUID_A_8, @PricePerOne_A_8, @Category_A_8, @Reason, @Result_A_8_I OUTPUT
						
						IF @Result_A_8 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GPShopItem_INT_DEL_A_New 2, ', @UnitUID_A, @UnitUID_B, @Quantity_A_8, @ItemUID_A_8, @Result_A_8) WITH SETERROR
					END																				
				END
	
				-- 대리상점 물품판매
				IF @TradeType = 3 BEGIN
					SET	@InsertType = 113
					SET @Result = -70
					
					UPDATE dbo.GUnit
						SET GamePoint = GamePoint + @ED_B
							OUTPUT INSERTED.UnitUID, INSERTED.GamePoint - DELETED.GamePoint, @sdtNow
							INTO dbo.GUnit_ED ( UnitUID, GamePoint, RegDate)
						WHERE ( UnitUID = @UnitUID_B AND @ED_B <> 0)
						
					-- A -> B (INSERT)
					IF @ItemUID_A_0 > 0 BEGIN
						SET @Result = -71
						
						EXEC @Result_A_0 = dbo.P_GPShopItem_INT_DEL_B_New @UnitUID_A, @UnitUID_B, @Quantity_A_0, @ItemUID_A_0, @InsertType, @Result_A_0_I OUTPUT
						
						IF @Result_A_0 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GPShopItem_INT_DEL_B_New 3, ', @UnitUID_A, @UnitUID_B, @Quantity_A_0, @ItemUID_A_0, @Result_A_0) WITH SETERROR
					END
								
				END
				
				-- 대리상점 물품회수
				IF @TradeType = 4 BEGIN
					SET	@InsertType = 120
					SET @Result = -80
					
					UPDATE dbo.GUnit
						SET GamePoint = GamePoint + @ED_A 
							OUTPUT INSERTED.UnitUID, INSERTED.GamePoint - DELETED.GamePoint, @sdtNow
							INTO dbo.GUnit_ED ( UnitUID, GamePoint, RegDate)
						WHERE ( UnitUID = @UnitUID_A AND @ED_A <> 0)
						
					-- A -> B (INSERT)
					IF @ItemUID_A_0 > 0 BEGIN
						SET @Result = -81
						
						EXEC @Result_A_0 = dbo.P_GPShopItem_INT_DEL_C_New @UnitUID_A, @UnitUID_A, @Quantity_A_0, @ItemUID_A_0, @InsertType, @Result_A_0_I OUTPUT
						
						IF @Result_A_0 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GPShopItem_INT_DEL_C_New 4, ', @UnitUID_A, @UnitUID_B, @Quantity_A_0, @ItemUID_A_0, @Result_A_0) WITH SETERROR
					END
					IF @ItemUID_A_1 > 0 BEGIN
						SET @Result = -82
						
						EXEC @Result_A_1 = dbo.P_GPShopItem_INT_DEL_C_New @UnitUID_A, @UnitUID_A, @Quantity_A_1, @ItemUID_A_1, @InsertType, @Result_A_1_I OUTPUT
						
						IF @Result_A_1 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GPShopItem_INT_DEL_C_New 4, ', @UnitUID_A, @UnitUID_B, @Quantity_A_1, @ItemUID_A_1, @Result_A_1) WITH SETERROR
					END
					IF @ItemUID_A_2 > 0 BEGIN
						SET @Result = -83
						
						EXEC @Result_A_2 = dbo.P_GPShopItem_INT_DEL_C_New @UnitUID_A, @UnitUID_A, @Quantity_A_2, @ItemUID_A_2, @InsertType, @Result_A_2_I OUTPUT
						
						IF @Result_A_2 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GPShopItem_INT_DEL_C_New 4, ', @UnitUID_A, @UnitUID_B, @Quantity_A_2, @ItemUID_A_2, @Result_A_2) WITH SETERROR
					END
					IF @ItemUID_A_3 > 0 BEGIN
						SET @Result = -84
						
						EXEC @Result_A_3 = dbo.P_GPShopItem_INT_DEL_C_New @UnitUID_A, @UnitUID_A, @Quantity_A_3, @ItemUID_A_3, @InsertType, @Result_A_3_I OUTPUT
						
						IF @Result_A_3 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GPShopItem_INT_DEL_C_New 4, ', @UnitUID_A, @UnitUID_B, @Quantity_A_3, @ItemUID_A_3, @Result_A_3) WITH SETERROR
					END
					IF @ItemUID_A_4 > 0 BEGIN
						SET @Result = -85
						
						EXEC @Result_A_4 = dbo.P_GPShopItem_INT_DEL_C_New @UnitUID_A, @UnitUID_A, @Quantity_A_4, @ItemUID_A_4, @InsertType, @Result_A_4_I OUTPUT
						
						IF @Result_A_4 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GPShopItem_INT_DEL_C_New 4, ', @UnitUID_A, @UnitUID_B, @Quantity_A_4, @ItemUID_A_4, @Result_A_4) WITH SETERROR
					END
					IF @ItemUID_A_5 > 0 BEGIN
						SET @Result = -86
						
						EXEC @Result_A_5 = dbo.P_GPShopItem_INT_DEL_C_New @UnitUID_A, @UnitUID_A, @Quantity_A_5, @ItemUID_A_5, @InsertType, @Result_A_5_I OUTPUT
						
						IF @Result_A_5 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GPShopItem_INT_DEL_C_New 4, ', @UnitUID_A, @UnitUID_B, @Quantity_A_5, @ItemUID_A_5, @Result_A_5) WITH SETERROR
					END
					IF @ItemUID_A_6 > 0 BEGIN
						SET @Result = -87
						
						EXEC @Result_A_6 = dbo.P_GPShopItem_INT_DEL_C_New @UnitUID_A, @UnitUID_A, @Quantity_A_6, @ItemUID_A_6, @InsertType, @Result_A_6_I OUTPUT
						
						IF @Result_A_6 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GPShopItem_INT_DEL_C_New 4, ', @UnitUID_A, @UnitUID_B, @Quantity_A_6, @ItemUID_A_6, @Result_A_6) WITH SETERROR
					END
					IF @ItemUID_A_7 > 0 BEGIN
						SET @Result = -88
						
						EXEC @Result_A_7 = dbo.P_GPShopItem_INT_DEL_C_New @UnitUID_A, @UnitUID_A, @Quantity_A_7, @ItemUID_A_7, @InsertType, @Result_A_7_I OUTPUT
						
						IF @Result_A_7 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GPShopItem_INT_DEL_C_New 4, ', @UnitUID_A, @UnitUID_B, @Quantity_A_7, @ItemUID_A_7, @Result_A_7) WITH SETERROR
					END
					IF @ItemUID_A_8 > 0 BEGIN
						SET @Result = -89
						
						EXEC @Result_A_8 = dbo.P_GPShopItem_INT_DEL_C_New @UnitUID_A, @UnitUID_A, @Quantity_A_8, @ItemUID_A_8, @InsertType, @Result_A_8_I OUTPUT
						
						IF @Result_A_8 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GPShopItem_INT_DEL_C_New 4, ', @UnitUID_A, @UnitUID_B, @Quantity_A_8, @ItemUID_A_8, @Result_A_8) WITH SETERROR
					END
				END

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
	END

	SELECT @Result AS Result, 
		 @Result_A_0_I AS ItemUID_A_0_N, @Result_A_1_I AS ItemUID_A_1_N, @Result_A_2_I AS ItemUID_A_2_N, 
		 @Result_A_3_I AS ItemUID_A_3_N, @Result_A_4_I AS ItemUID_A_4_N, @Result_A_5_I AS ItemUID_A_5_N, 
		 @Result_A_6_I AS ItemUID_A_6_N, @Result_A_7_I AS ItemUID_A_7_N, @Result_A_8_I AS ItemUID_A_8_N
GO
-- =============================================
-- Author: Hwang
-- Create date: 2012-06-05
-- Description:	대리상점 통합 SP
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GItem_Total_Pshop]
	@TradeType		tinyint			-- 물품등록: 2, 물품판매: 3, 물품회수: 4
,	@UnitUID_A		bigint
,	@UnitUID_B		bigint
,	@ED_A			int
,	@ED_B			int
,	@ItemUID_A_0	bigint ,	@Quantity_A_0	int,	@PricePerOne_A_0	int	,	@Category_A_0	tinyint
,	@ItemUID_A_1	bigint ,	@Quantity_A_1	int,	@PricePerOne_A_1	int	,	@Category_A_1	tinyint
,	@ItemUID_A_2	bigint ,	@Quantity_A_2	int,	@PricePerOne_A_2	int	,	@Category_A_2	tinyint
,	@ItemUID_A_3	bigint ,	@Quantity_A_3	int,	@PricePerOne_A_3	int	,	@Category_A_3	tinyint
,	@ItemUID_A_4	bigint ,	@Quantity_A_4	int,	@PricePerOne_A_4	int	,	@Category_A_4	tinyint
,	@ItemUID_A_5	bigint ,	@Quantity_A_5	int,	@PricePerOne_A_5	int	,	@Category_A_5	tinyint
,	@ItemUID_A_6	bigint ,	@Quantity_A_6	int,	@PricePerOne_A_6	int	,	@Category_A_6	tinyint
,	@ItemUID_A_7	bigint ,	@Quantity_A_7	int,	@PricePerOne_A_7	int	,	@Category_A_7	tinyint
,	@ItemUID_A_8	bigint ,	@Quantity_A_8	int,	@PricePerOne_A_8	int	,	@Category_A_8	tinyint
,	@PShopName		nvarchar(50)


AS
	SET NOCOUNT ON;	
	
	DECLARE @strErrorMSG	nvarchar(max)
		,	@sdtNow			smalldatetime
	SET @strErrorMSG = N'%s [P_GItem_Total_Pshop @UnitUID_A = %I64d, @UnitUID_B = %I64d, @Quantity_A_0 = %d, @ItemUID_A_0 = %I64d, @Result = %d]'
	SET @sdtNow = GETDATE()
	
	DECLARE @Result		int			
		,	@InsertType	tinyint
		,	@Reason		tinyint
		,	@Result_A_0 int	, @Result_A_0_I bigint
		,	@Result_A_1 int	, @Result_A_1_I bigint
		,	@Result_A_2 int	, @Result_A_2_I bigint
		,	@Result_A_3 int	, @Result_A_3_I bigint
		,	@Result_A_4 int	, @Result_A_4_I bigint
		,	@Result_A_5 int	, @Result_A_5_I bigint
		,	@Result_A_6 int	, @Result_A_6_I bigint
		,	@Result_A_7 int	, @Result_A_7_I bigint
		,	@Result_A_8 int	, @Result_A_8_I bigint
		,	@Result_A_9 int	, @Result_A_9_I bigint
		,	@Result_B_0 int	, @Result_B_0_I bigint
		,	@Result_B_1 int	, @Result_B_1_I bigint
		,	@Result_B_2 int	, @Result_B_2_I bigint
		,	@Result_B_3 int	, @Result_B_3_I bigint
		,	@Result_B_4 int	, @Result_B_4_I bigint
		,	@Result_B_5 int	, @Result_B_5_I bigint
		,	@Result_B_6 int	, @Result_B_6_I bigint
		,	@Result_B_7 int	, @Result_B_7_I bigint
		,	@Result_B_8 int	, @Result_B_8_I bigint
		,	@Result_B_9 int	, @Result_B_9_I bigint
		
		SET	@Result_A_0 = 0	SET	@Result_A_0_I = 0
		SET	@Result_A_1 = 0	SET	@Result_A_1_I = 0
		SET	@Result_A_2 = 0	SET	@Result_A_2_I = 0
		SET	@Result_A_3 = 0	SET	@Result_A_3_I = 0
		SET	@Result_A_4 = 0	SET	@Result_A_4_I = 0
		SET	@Result_A_5 = 0	SET	@Result_A_5_I = 0
		SET	@Result_A_6 = 0	SET	@Result_A_6_I = 0
		SET	@Result_A_7 = 0	SET	@Result_A_7_I = 0
		SET	@Result_A_8 = 0	SET	@Result_A_8_I = 0
		SET	@Result_A_9 = 0	SET	@Result_A_9_I = 0
		SET	@Result_B_0 = 0	SET	@Result_B_0_I = 0
		SET	@Result_B_1 = 0	SET	@Result_B_1_I = 0
		SET	@Result_B_2 = 0	SET	@Result_B_2_I = 0
		SET	@Result_B_3 = 0	SET	@Result_B_3_I = 0
		SET	@Result_B_4 = 0	SET	@Result_B_4_I = 0
		SET	@Result_B_5 = 0	SET	@Result_B_5_I = 0
		SET	@Result_B_6 = 0	SET	@Result_B_6_I = 0
		SET	@Result_B_7 = 0	SET	@Result_B_7_I = 0
		SET	@Result_B_8 = 0	SET	@Result_B_8_I = 0
		SET	@Result_B_9 = 0	SET	@Result_B_9_I = 0
	
	-- 해당유닛이 있는 경우.
	IF NOT EXISTS ( SELECT UnitUID FROM dbo.GUnit WITH( NOLOCK ) WHERE UnitUID = @UnitUID_A) 
		SET @Result = -10
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN
			
				-- 대리상점 물품등록
				IF @TradeType = 2 BEGIN
					SET	@Reason = 39
					
					SET @Result = -60
					UPDATE dbo.GPShopInfo
						SET PShopName = @PShopName
					WHERE UnitUID = @UnitUID_A
					
					-- A -> B (INSERT)
					IF @ItemUID_A_0 > 0 BEGIN
						SET @Result = -61
						EXEC @Result_A_0 = dbo.P_GPShopItem_INT_DEL_A @UnitUID_A, @Quantity_A_0, @ItemUID_A_0, @PricePerOne_A_0, @Category_A_0, @Reason, @Result_A_0_I OUTPUT
						
						IF @Result_A_0 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GPShopItem_INT_DEL_A 2, ', @UnitUID_A, @UnitUID_B, @Quantity_A_0, @ItemUID_A_0, @Result_A_0) WITH SETERROR
					END
					IF @ItemUID_A_1 > 0 BEGIN
						SET @Result = -62
						EXEC @Result_A_1 = dbo.P_GPShopItem_INT_DEL_A @UnitUID_A, @Quantity_A_1, @ItemUID_A_1, @PricePerOne_A_1, @Category_A_1, @Reason, @Result_A_1_I OUTPUT
						
						IF @Result_A_1 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GPShopItem_INT_DEL_A 2, ', @UnitUID_A, @UnitUID_B, @Quantity_A_1, @ItemUID_A_1, @Result_A_1) WITH SETERROR
					END
					IF @ItemUID_A_2 > 0 BEGIN	
						SET @Result = -63
						EXEC @Result_A_2 = dbo.P_GPShopItem_INT_DEL_A @UnitUID_A, @Quantity_A_2, @ItemUID_A_2, @PricePerOne_A_2, @Category_A_2, @Reason, @Result_A_2_I OUTPUT
						
						IF @Result_A_2 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GPShopItem_INT_DEL_A 2, ', @UnitUID_A, @UnitUID_B, @Quantity_A_2, @ItemUID_A_2, @Result_A_2) WITH SETERROR
					END
					IF @ItemUID_A_3 > 0 BEGIN
						SET @Result = -64
						EXEC @Result_A_3 = dbo.P_GPShopItem_INT_DEL_A @UnitUID_A, @Quantity_A_3, @ItemUID_A_3, @PricePerOne_A_3, @Category_A_3, @Reason, @Result_A_3_I OUTPUT
						
						IF @Result_A_3 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GPShopItem_INT_DEL_A 2, ', @UnitUID_A, @UnitUID_B, @Quantity_A_3, @ItemUID_A_3, @Result_A_3) WITH SETERROR
					END
					IF @ItemUID_A_4 > 0 BEGIN
						SET @Result = -65
						EXEC @Result_A_4 = dbo.P_GPShopItem_INT_DEL_A @UnitUID_A, @Quantity_A_4, @ItemUID_A_4, @PricePerOne_A_4, @Category_A_4, @Reason, @Result_A_4_I OUTPUT
						
						IF @Result_A_4 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GPShopItem_INT_DEL_A 2, ', @UnitUID_A, @UnitUID_B, @Quantity_A_4, @ItemUID_A_4, @Result_A_4) WITH SETERROR
					END																												 
					IF @ItemUID_A_5 > 0 BEGIN
						SET @Result = -66
						EXEC @Result_A_5 = dbo.P_GPShopItem_INT_DEL_A @UnitUID_A, @Quantity_A_5, @ItemUID_A_5, @PricePerOne_A_5, @Category_A_5, @Reason, @Result_A_5_I OUTPUT
						
						IF @Result_A_5 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GPShopItem_INT_DEL_A 2, ', @UnitUID_A, @UnitUID_B, @Quantity_A_5, @ItemUID_A_5, @Result_A_5) WITH SETERROR
					END																												 
					IF @ItemUID_A_6 > 0 BEGIN
						SET @Result = -67
						EXEC @Result_A_6 = dbo.P_GPShopItem_INT_DEL_A @UnitUID_A, @Quantity_A_6, @ItemUID_A_6, @PricePerOne_A_6, @Category_A_6, @Reason, @Result_A_6_I OUTPUT
						
						IF @Result_A_6 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GPShopItem_INT_DEL_A 2, ', @UnitUID_A, @UnitUID_B, @Quantity_A_6, @ItemUID_A_6, @Result_A_6) WITH SETERROR
					END																												 
					IF @ItemUID_A_7 > 0 BEGIN
						SET @Result = -68
						EXEC @Result_A_7 = dbo.P_GPShopItem_INT_DEL_A @UnitUID_A, @Quantity_A_7, @ItemUID_A_7, @PricePerOne_A_7, @Category_A_7, @Reason, @Result_A_7_I OUTPUT
						
						IF @Result_A_7 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GPShopItem_INT_DEL_A 2, ', @UnitUID_A, @UnitUID_B, @Quantity_A_7, @ItemUID_A_7, @Result_A_7) WITH SETERROR
					END																												 
					IF @ItemUID_A_8 > 0 BEGIN
						SET @Result = -69
						EXEC @Result_A_8 = dbo.P_GPShopItem_INT_DEL_A @UnitUID_A, @Quantity_A_8, @ItemUID_A_8, @PricePerOne_A_8, @Category_A_8, @Reason, @Result_A_8_I OUTPUT
						
						IF @Result_A_8 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GPShopItem_INT_DEL_A 2, ', @UnitUID_A, @UnitUID_B, @Quantity_A_8, @ItemUID_A_8, @Result_A_8) WITH SETERROR
					END																				
				END
	
				-- 대리상점 물품판매
				IF @TradeType = 3 BEGIN
					SET	@InsertType = 113
					SET @Result = -70
					
					UPDATE dbo.GUnit
						SET GamePoint = GamePoint + @ED_B
							OUTPUT INSERTED.UnitUID, INSERTED.GamePoint - DELETED.GamePoint, @sdtNow
							INTO dbo.GUnit_ED ( UnitUID, GamePoint, RegDate)
						WHERE ( UnitUID = @UnitUID_B AND @ED_B <> 0)
						
					-- A -> B (INSERT)
					IF @ItemUID_A_0 > 0 BEGIN
						SET @Result = -71
						
						EXEC @Result_A_0 = dbo.P_GPShopItem_INT_DEL_B @UnitUID_A, @UnitUID_B, @Quantity_A_0, @ItemUID_A_0, @InsertType, @Result_A_0_I OUTPUT
						
						IF @Result_A_0 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GPShopItem_INT_DEL_B 3, ', @UnitUID_A, @UnitUID_B, @Quantity_A_0, @ItemUID_A_0, @Result_A_0) WITH SETERROR
					END
								
				END
				
				-- 대리상점 물품회수
				IF @TradeType = 4 BEGIN
					SET	@InsertType = 120
					SET @Result = -80
					
					UPDATE dbo.GUnit
						SET GamePoint = GamePoint + @ED_A 
							OUTPUT INSERTED.UnitUID, INSERTED.GamePoint - DELETED.GamePoint, @sdtNow
							INTO dbo.GUnit_ED ( UnitUID, GamePoint, RegDate)
						WHERE ( UnitUID = @UnitUID_A AND @ED_A <> 0)
						
					-- A -> B (INSERT)
					IF @ItemUID_A_0 > 0 BEGIN
						SET @Result = -81
						
						EXEC @Result_A_0 = dbo.P_GPShopItem_INT_DEL_C @UnitUID_A, @UnitUID_A, @Quantity_A_0, @ItemUID_A_0, @InsertType, @Result_A_0_I OUTPUT
						
						IF @Result_A_0 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GPShopItem_INT_DEL_C 4, ', @UnitUID_A, @UnitUID_B, @Quantity_A_0, @ItemUID_A_0, @Result_A_0) WITH SETERROR
					END
					IF @ItemUID_A_1 > 0 BEGIN
						SET @Result = -82
						
						EXEC @Result_A_1 = dbo.P_GPShopItem_INT_DEL_C @UnitUID_A, @UnitUID_A, @Quantity_A_1, @ItemUID_A_1, @InsertType, @Result_A_1_I OUTPUT
						
						IF @Result_A_1 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GPShopItem_INT_DEL_C 4, ', @UnitUID_A, @UnitUID_B, @Quantity_A_1, @ItemUID_A_1, @Result_A_1) WITH SETERROR
					END
					IF @ItemUID_A_2 > 0 BEGIN
						SET @Result = -83
						
						EXEC @Result_A_2 = dbo.P_GPShopItem_INT_DEL_C @UnitUID_A, @UnitUID_A, @Quantity_A_2, @ItemUID_A_2, @InsertType, @Result_A_2_I OUTPUT
						
						IF @Result_A_2 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GPShopItem_INT_DEL_C 4, ', @UnitUID_A, @UnitUID_B, @Quantity_A_2, @ItemUID_A_2, @Result_A_2) WITH SETERROR
					END
					IF @ItemUID_A_3 > 0 BEGIN
						SET @Result = -84
						
						EXEC @Result_A_3 = dbo.P_GPShopItem_INT_DEL_C @UnitUID_A, @UnitUID_A, @Quantity_A_3, @ItemUID_A_3, @InsertType, @Result_A_3_I OUTPUT
						
						IF @Result_A_3 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GPShopItem_INT_DEL_C 4, ', @UnitUID_A, @UnitUID_B, @Quantity_A_3, @ItemUID_A_3, @Result_A_3) WITH SETERROR
					END
					IF @ItemUID_A_4 > 0 BEGIN
						SET @Result = -85
						
						EXEC @Result_A_4 = dbo.P_GPShopItem_INT_DEL_C @UnitUID_A, @UnitUID_A, @Quantity_A_4, @ItemUID_A_4, @InsertType, @Result_A_4_I OUTPUT
						
						IF @Result_A_4 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GPShopItem_INT_DEL_C 4, ', @UnitUID_A, @UnitUID_B, @Quantity_A_4, @ItemUID_A_4, @Result_A_4) WITH SETERROR
					END
					IF @ItemUID_A_5 > 0 BEGIN
						SET @Result = -86
						
						EXEC @Result_A_5 = dbo.P_GPShopItem_INT_DEL_C @UnitUID_A, @UnitUID_A, @Quantity_A_5, @ItemUID_A_5, @InsertType, @Result_A_5_I OUTPUT
						
						IF @Result_A_5 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GPShopItem_INT_DEL_C 4, ', @UnitUID_A, @UnitUID_B, @Quantity_A_5, @ItemUID_A_5, @Result_A_5) WITH SETERROR
					END
					IF @ItemUID_A_6 > 0 BEGIN
						SET @Result = -87
						
						EXEC @Result_A_6 = dbo.P_GPShopItem_INT_DEL_C @UnitUID_A, @UnitUID_A, @Quantity_A_6, @ItemUID_A_6, @InsertType, @Result_A_6_I OUTPUT
						
						IF @Result_A_6 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GPShopItem_INT_DEL_C 4, ', @UnitUID_A, @UnitUID_B, @Quantity_A_6, @ItemUID_A_6, @Result_A_6) WITH SETERROR
					END
					IF @ItemUID_A_7 > 0 BEGIN
						SET @Result = -88
						
						EXEC @Result_A_7 = dbo.P_GPShopItem_INT_DEL_C @UnitUID_A, @UnitUID_A, @Quantity_A_7, @ItemUID_A_7, @InsertType, @Result_A_7_I OUTPUT
						
						IF @Result_A_7 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GPShopItem_INT_DEL_C 4, ', @UnitUID_A, @UnitUID_B, @Quantity_A_7, @ItemUID_A_7, @Result_A_7) WITH SETERROR
					END
					IF @ItemUID_A_8 > 0 BEGIN
						SET @Result = -89
						
						EXEC @Result_A_8 = dbo.P_GPShopItem_INT_DEL_C @UnitUID_A, @UnitUID_A, @Quantity_A_8, @ItemUID_A_8, @InsertType, @Result_A_8_I OUTPUT
						
						IF @Result_A_8 < 0
							RAISERROR(@strErrorMSG, 15, 1, N'P_GPShopItem_INT_DEL_C 4, ', @UnitUID_A, @UnitUID_B, @Quantity_A_8, @ItemUID_A_8, @Result_A_8) WITH SETERROR
					END
				END

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
	END

	SELECT @Result AS Result, 
		 @Result_A_0_I AS ItemUID_A_0_N, @Result_A_1_I AS ItemUID_A_1_N, @Result_A_2_I AS ItemUID_A_2_N, @Result_A_3_I AS ItemUID_A_3_N, @Result_A_4_I AS ItemUID_A_4_N, 
		 @Result_A_5_I AS ItemUID_A_5_N, @Result_A_6_I AS ItemUID_A_6_N, @Result_A_7_I AS ItemUID_A_7_N, @Result_A_8_I AS ItemUID_A_8_N
GO
-- =============================================
-- Author: Hwang
-- Create date: 2012-08-21
-- Description:	우편 통합 SP
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_GItem_Total_Post]
	@TradeType			tinyint			--  0: 우편 보내기, 1: 우편(첨부) 받기
,	@UnitUID_A			bigint
,	@NickName_B			nvarchar(20)
,	@ED					int
,	@ItemUID			bigint
,	@Quantity			int
,	@UsageType			tinyint
,	@PostItemtype		tinyint			-- 1: 아이템 첨부, 2: ED 첨부, 3: 첨부 없음 
,	@Title				nvarchar(38)
,	@Message			nvarchar(600)
,	@PostNo				bigint

AS
	SET NOCOUNT ON;

	DECLARE @strErrorMSG	nvarchar(max)
	DECLARE @strErrorMSGED	nvarchar(max)
	DECLARE @sdtNow			smalldatetime
		
	SET @strErrorMSG = N'%s [P_GItem_Total_Post @UnitUID_A = %I64d, @UnitUID_B = %I64d, @Quantity = %d, @ItemUID = %I64d, @TradeType = %d, @Result = %d]'
	SET @strErrorMSGED = N'%s [P_GItem_Total_Post @UnitUID_A = %I64d, @ED = %d, @Result = %d]'
	SET @sdtNow = GETDATE()

	DECLARE @UnitUID_B	bigint	
	DECLARE @Result		int		-- 전체 결과
	DECLARE @InsertType	tinyint	-- 생성 사유
	DECLARE @Reason		tinyint -- 삭제 사유
	DECLARE @Result_A	int		-- 내부 SP 결과
	DECLARE @Result_I	bigint	-- 내부 SP 에서 생성된 ITEMUID
	
	SET @Result_A = 0	-- 내부 SP 결과
	SET @Result_I = 0	
	SELECT @UnitUID_B = UnitUID
		FROM dbo.GUnitNickName WITH(NOLOCK)
			WHERE NickName = @NickName_B

	-- 해당유닛이 있는 경우.
		BEGIN TRY
			BEGIN TRAN
				-- ED 마이너스 체크 및 업데이트
				IF @ED <> 0 BEGIN
					UPDATE dbo.GUnit
					SET GamePoint = GamePoint + @ED
						OUTPUT INSERTED.UnitUID, INSERTED.GamePoint - DELETED.GamePoint, @sdtNow
						INTO dbo.GUnit_ED ( UnitUID, GamePoint, RegDate)
					WHERE UnitUID = @UnitUID_A
						AND GamePoint + @ED >= 0

					IF @@ROWCOUNT <> 1 BEGIN
						SET @Result = -10
						RAISERROR(@strErrorMSGED, 15, 1, N'GUnit GamePoint A', @UnitUID_A, @ED, @Result) WITH SETERROR
					END
				END
				
				SET @InsertType = 114
				SET	@Reason = 7
				
				-- 우편을 보낼 때
				IF @TradeType = 0 BEGIN
					SET @Result = -11
				
					EXEC @Result_A = dbo.P_GPost_INT_DEL_A @UnitUID_A, @UnitUID_B, @Quantity, @ItemUID, @PostItemtype, @Title, @Message, @Reason, @sdtNow, @PostNo OUTPUT

					IF @Result_A < 0
						RAISERROR(@strErrorMSG, 15, 1, N'P_GPost_INT_DEL_A, ', @UnitUID_A, @UnitUID_B, @Quantity, @ItemUID, @TradeType, @Result_A) WITH SETERROR
				END
				
				-- 첨부 아이템을 꺼낼 때
				IF @TradeType = 1 BEGIN
					SET @Result = -12
				
					EXEC @Result_A = dbo.P_GPost_INT_DEL_B @UnitUID_A, @UsageType, @InsertType, @sdtNow, @PostNo, @Result_I OUTPUT
					
					IF @Result_A < 0
						RAISERROR(@strErrorMSG, 15, 1, N'P_GPost_INT_DEL_B, ', @UnitUID_A, @UnitUID_B, @Quantity, @ItemUID, @TradeType, @Result_A) WITH SETERROR
				END

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
					SET @Result = -200
		END CATCH


	SELECT @Result AS Result, @PostNo AS PostNo, ISNULL(@UnitUID_B, 0) AS ToUnitUID, @sdtNow as RegDate, @Result_I
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_create_promotion_unit]
	@strUserID	nvarchar(16)
,	@iOK [int] = 0
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRAN

IF NOT EXISTS (SELECT * FROM [Account].[dbo].[MUser] WHERE USERID = @strUserID)
	BEGIN	SELECT @iOK = -1 GOTO FAIL_TRAN	END

DECLARE	@strNick1	nvarchar(16)
,		@strNick2	nvarchar(16)
,		@strNick3	nvarchar(16)
,		@strNick4	nvarchar(16)
,		@strNick5	nvarchar(16)
,		@iUserUID	bigint
,		@iUnitUID1	bigint
,		@iUnitUID2	bigint
,		@iUnitUID3	bigint
,		@iUnitUID4	bigint
,		@iUnitUID5	bigint
,		@sdtNow		smalldatetime

SELECT	@strNick1 = @strUserID + '1'
,		@strNick2 = @strUserID + '2'
,		@strNick3 = @strUserID + '3'	
,		@strNick4 = @strUserID + '4'	
,		@strNick5 = @strUserID + '5'	
,		@sdtNow = getdate()

SELECT @iUserUID = UserUID	
	FROM [Account].[dbo].[MUser]
		WHERE USERID = @strUserID

IF NOT EXISTS (SELECT * FROM dbo.GUser WHERE UserUID = @iUserUID)
	BEGIN
		INSERT INTO dbo.GUser (UserUID, UserID,USSize, RegDate, DelDate)
			SELECT @iUserUID, @strUserID, 6, @sdtNow, @sdtNow
	END

IF EXISTS (SELECT * FROM DBO.GUnitNickname WHERE Nickname in (@strNick1,@strNick2,@strNick3,@strNick4,@strNick5))
	BEGIN	SELECT @iOK = -2 GOTO FAIL_TRAN	END	


-- 유닛 생성
EXEC [dbo].[gup_create_unit] @iUserUID, @strNick1, 1, 0
EXEC [dbo].[gup_create_unit] @iUserUID, @strNick2, 2, 0
EXEC [dbo].[gup_create_unit] @iUserUID, @strNick3, 3, 0
EXEC [dbo].[gup_create_unit] @iUserUID, @strNick4, 4, 0
EXEC [dbo].[gup_create_unit] @iUserUID, @strNick5, 5, 0

-- 유닛 UID 추출
SELECT	@iUnitUID1	= UnitUID	FROM dbo.GUnitNickName	WHERE Nickname = @strNick1
SELECT	@iUnitUID2	= UnitUID	FROM dbo.GUnitNickName	WHERE Nickname = @strNick2
SELECT	@iUnitUID3	= UnitUID	FROM dbo.GUnitNickName	WHERE Nickname = @strNick3
SELECT	@iUnitUID4	= UnitUID	FROM dbo.GUnitNickName	WHERE Nickname = @strNick4
SELECT	@iUnitUID5	= UnitUID	FROM dbo.GUnitNickName	WHERE Nickname = @strNick5

-- 유닛 1 프로모션 의상 
EXEC [dbo].[gup_insert_item] @iUnitUID1, 128000, 0, 0, 0, 0, 0, 0, 0, 0, 125
EXEC [dbo].[gup_insert_item] @iUnitUID1, 128001, 0, 0, 0, 0, 0, 0, 0, 0, 125
EXEC [dbo].[gup_insert_item] @iUnitUID1, 128002, 0, 0, 0, 0, 0, 0, 0, 0, 125
EXEC [dbo].[gup_insert_item] @iUnitUID1, 128003, 0, 0, 0, 0, 0, 0, 0, 0, 125
EXEC [dbo].[gup_insert_item] @iUnitUID1, 128004, 0, 0, 0, 0, 0, 0, 0, 0, 125

-- 유닛 2 프로모션 의상 
EXEC [dbo].[gup_insert_item] @iUnitUID2, 128010, 0, 0, 0, 0, 0, 0, 0, 0, 125
EXEC [dbo].[gup_insert_item] @iUnitUID2, 128011, 0, 0, 0, 0, 0, 0, 0, 0, 125
EXEC [dbo].[gup_insert_item] @iUnitUID2, 128012, 0, 0, 0, 0, 0, 0, 0, 0, 125
EXEC [dbo].[gup_insert_item] @iUnitUID2, 128013, 0, 0, 0, 0, 0, 0, 0, 0, 125
EXEC [dbo].[gup_insert_item] @iUnitUID2, 128014, 0, 0, 0, 0, 0, 0, 0, 0, 125

-- 유닛 3 프로모션 의상 
EXEC [dbo].[gup_insert_item] @iUnitUID3, 128005, 0, 0, 0, 0, 0, 0, 0, 0, 125   
EXEC [dbo].[gup_insert_item] @iUnitUID3, 128006, 0, 0, 0, 0, 0, 0, 0, 0, 125   
EXEC [dbo].[gup_insert_item] @iUnitUID3, 128007, 0, 0, 0, 0, 0, 0, 0, 0, 125   
EXEC [dbo].[gup_insert_item] @iUnitUID3, 128008, 0, 0, 0, 0, 0, 0, 0, 0, 125   
EXEC [dbo].[gup_insert_item] @iUnitUID3, 128009, 0, 0, 0, 0, 0, 0, 0, 0, 125  

-- 유닛 4 프로모션 의상 
EXEC [dbo].[gup_insert_item] @iUnitUID4, 128072, 0, 0, 0, 0, 0, 0, 0, 0, 125  
EXEC [dbo].[gup_insert_item] @iUnitUID4, 128073, 0, 0, 0, 0, 0, 0, 0, 0, 125   
EXEC [dbo].[gup_insert_item] @iUnitUID4, 128074, 0, 0, 0, 0, 0, 0, 0, 0, 125   
EXEC [dbo].[gup_insert_item] @iUnitUID4, 128075, 0, 0, 0, 0, 0, 0, 0, 0, 125  
EXEC [dbo].[gup_insert_item] @iUnitUID4, 128076, 0, 0, 0, 0, 0, 0, 0, 0, 125   

-- 유닛 5 프로모션 의상 
EXEC [dbo].[gup_insert_item] @iUnitUID5, 130134, 0, 0, 0, 0, 0, 0, 0, 0, 125   
EXEC [dbo].[gup_insert_item] @iUnitUID5, 130135, 0, 0, 0, 0, 0, 0, 0, 0, 125   
EXEC [dbo].[gup_insert_item] @iUnitUID5, 130136, 0, 0, 0, 0, 0, 0, 0, 0, 125   
EXEC [dbo].[gup_insert_item] @iUnitUID5, 130137, 0, 0, 0, 0, 0, 0, 0, 0, 125   
EXEC [dbo].[gup_insert_item] @iUnitUID5, 130138, 0, 0, 0, 0, 0, 0, 0, 0, 125   



-- 유닛 1 던전 클리어
EXEC [dbo].[gup_all_dungeonclear] @iUnitUID1

 -- 유닛 2 던전 클리어    
EXEC [dbo].[gup_all_dungeonclear] @iUnitUID2
                                                                  
 -- 유닛 3 던전 클리어    
EXEC [dbo].[gup_all_dungeonclear] @iUnitUID3

 -- 유닛 4 던전 클리어  
EXEC [dbo].[gup_all_dungeonclear] @iUnitUID4

 -- 유닛 5 던전 클리어  
EXEC [dbo].[gup_all_dungeonclear] @iUnitUID5


-- 유닛 기본 능력 세팅
UPDATE dbo.GUnit
	SET	[EXP] = 6500000
,		Gamepoint = 50000000
,		spoint = 801
		WHERE UnitUID in (@iUnitUID1, @iUnitUID2, @iUnitUID3, @iUnitUID4, @iUnitUID5)


-- 프로모션 무기 입히기	
UPDATE dbo.GItem
	SET InventoryCategory = 9
,		SlotID = 10
		WHERE UnitUID in (@iUnitUID1, @iUnitUID2, @iUnitUID3, @iUnitUID4, @iUnitUID5)
			AND ItemID in (128000,128010, 128005, 128072, 130134)

-- 프로모션 상의 입히기
UPDATE dbo.GItem
	SET InventoryCategory = 9
,		SlotID = 2
		WHERE UnitUID in (@iUnitUID1, @iUnitUID2, @iUnitUID3, @iUnitUID4, @iUnitUID5)
			AND ItemID in (128001, 128011, 128006, 128073, 130135)

-- 프로모션 하의 입히기
UPDATE dbo.GItem
	SET InventoryCategory = 9
,		SlotID = 4
		WHERE UnitUID in (@iUnitUID1, @iUnitUID2, @iUnitUID3, @iUnitUID4, @iUnitUID5)
			AND ItemID in (128002, 128012, 128007, 128074, 130136)

-- 프로모션 장갑 입히기
UPDATE dbo.GItem
	SET InventoryCategory = 9
,		SlotID = 6
		WHERE UnitUID in (@iUnitUID1, @iUnitUID2, @iUnitUID3, @iUnitUID4, @iUnitUID5)
			AND ItemID in (128003, 128013, 128008, 128075, 130137)

-- 프로모션 신발 입히기
UPDATE dbo.GItem
	SET InventoryCategory = 9
,		SlotID = 8
		WHERE UnitUID in (@iUnitUID1, @iUnitUID2, @iUnitUID3, @iUnitUID4, @iUnitUID5)
			AND ItemID in (128004, 128014, 128009, 128076, 130138)



COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK, @strUserID
GO
