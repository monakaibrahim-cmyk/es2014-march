-- =============================================================================
-- Elsword Database Schema: [Account]
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
DECLARE @SqlCmd NVARCHAR(400) = N'ALTER DATABASE [Account] SET COMPATIBILITY_LEVEL = ' + CAST(@CompatLevel AS NVARCHAR(10));
EXEC sp_executesql @SqlCmd;
GO

ALTER DATABASE [Account] SET ANSI_NULL_DEFAULT ON
GO
ALTER DATABASE [Account] SET ANSI_NULLS ON
GO
ALTER DATABASE [Account] SET ANSI_PADDING ON
GO
ALTER DATABASE [Account] SET ANSI_WARNINGS ON
GO
ALTER DATABASE [Account] SET ARITHABORT ON
GO
ALTER DATABASE [Account] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [Account] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [Account] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [Account] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [Account] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [Account] SET CURSOR_DEFAULT GLOBAL
GO
ALTER DATABASE [Account] SET CONCAT_NULL_YIELDS_NULL ON
GO
ALTER DATABASE [Account] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [Account] SET QUOTED_IDENTIFIER ON
GO
ALTER DATABASE [Account] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [Account] SET DISABLE_BROKER
GO
ALTER DATABASE [Account] SET AUTO_UPDATE_STATISTICS_ASYNC ON
GO
ALTER DATABASE [Account] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [Account] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [Account] SET ALLOW_SNAPSHOT_ISOLATION ON
GO
ALTER DATABASE [Account] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [Account] SET READ_COMMITTED_SNAPSHOT ON
GO
ALTER DATABASE [Account] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [Account] SET READ_WRITE
GO
ALTER DATABASE [Account] SET RECOVERY SIMPLE
GO
ALTER DATABASE [Account] SET MULTI_USER
GO
ALTER DATABASE [Account] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [Account] SET DB_CHAINING OFF
GO
ALTER DATABASE [Account] SET TARGET_RECOVERY_TIME = 60 SECONDS
GO
USE [Account]
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
IF DATABASE_PRINCIPAL_ID(N'billjob_user') IS NULL
    CREATE USER [billjob_user] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo];
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
IF OBJECT_ID(N'[dbo].[ServerTUser]', N'U') IS NULL
CREATE TABLE [dbo].[ServerTUser](
	[ID] [nvarchar](20) NOT NULL,
	[PW] [nvarchar](20) NULL,
	[ToolAuth] [tinyint] NULL,
 CONSTRAINT [PK_ServerTUser_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[MComebackUserEvent]', N'U') IS NULL
CREATE TABLE [dbo].[MComebackUserEvent](
	[UserUID] [bigint] NOT NULL,
 CONSTRAINT [PK__MComebac__A1F26A8A62AFA012] PRIMARY KEY CLUSTERED 
(
	[UserUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[MChatOption]', N'U') IS NULL
CREATE TABLE [dbo].[MChatOption](
	[UserUID] [bigint] NOT NULL,
	[ChatOption] [tinyint] NOT NULL,
	[OnOff] [bit] NOT NULL,
 CONSTRAINT [PKC_MChatOption_] PRIMARY KEY CLUSTERED 
(
	[UserUID] ASC,
	[ChatOption] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[MUserKeyBoard]', N'U') IS NULL
CREATE TABLE [dbo].[MUserKeyBoard](
	[UserUID] [bigint] NOT NULL,
	[UserKey] [smallint] NOT NULL,
	[Value] [smallint] NOT NULL,
 CONSTRAINT [PKC_MUserKeyBoard_UserUID_UserKey] PRIMARY KEY CLUSTERED 
(
	[UserUID] ASC,
	[UserKey] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[AConnectLog]', N'U') IS NULL
CREATE TABLE [dbo].[AConnectLog](
	[UserUID] [bigint] NOT NULL,
	[IP] [nvarchar](15) NOT NULL,
	[LoginTime] [smalldatetime] NOT NULL,
	[LogoutTime] [smalldatetime] NOT NULL,
	[LoginFail] [bit] NOT NULL,
	[LogoutFail] [bit] NOT NULL,
	[TotalPlayTime] [int] NOT NULL,
	[VsPlayTime] [int] NOT NULL,
	[IsInternal] [bit] NOT NULL,
	[DisconnectReason] [tinyint] NOT NULL,
	[DisconnectUserFSM] [int] NOT NULL,
	[ArcadePlayTime] [int] NOT NULL,
	[ServerGroupID] [tinyint] NOT NULL,
	[MachineID] [nvarchar](50) NULL,
	[ConnectUID] [bigint] IDENTITY(1,1) NOT NULL,
	[DungeonPlayTime] [int] NULL,
	[FieldPlayTime] [int] NULL,
	[ChannelCode] [tinyint] NULL,
	[PCBangFlag] [bit] NOT NULL,
 CONSTRAINT [PK_AConnectLog_ConnectUID] PRIMARY KEY CLUSTERED 
(
	[ConnectUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[MQuests_Repeat]', N'U') IS NULL
CREATE TABLE [dbo].[MQuests_Repeat](
	[UserUID] [bigint] NOT NULL,
	[UnitUID] [bigint] NOT NULL,
	[QuestID] [int] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL,
	[CompleteDate] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[MQuests_Complete]', N'U') IS NULL
CREATE TABLE [dbo].[MQuests_Complete](
	[UserUID] [bigint] NOT NULL,
	[UnitUID] [bigint] NOT NULL,
	[QuestID] [int] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL,
	[CompleteDate] [smalldatetime] NOT NULL,
 CONSTRAINT [PKC_MQuests_Complete_UserUID_QuestID] PRIMARY KEY CLUSTERED 
(
	[UserUID] ASC,
	[QuestID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[MQuests]', N'U') IS NULL
CREATE TABLE [dbo].[MQuests](
	[UserUID] [bigint] NOT NULL,
	[QuestID] [int] NOT NULL,
	[SubQuest0] [tinyint] NOT NULL,
	[SubQuest1] [tinyint] NOT NULL,
	[SubQuest2] [tinyint] NOT NULL,
	[SubQuest3] [tinyint] NOT NULL,
	[SubQuest4] [tinyint] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL,
 CONSTRAINT [PKC_MQuests_UserUID_QuestID] PRIMARY KEY CLUSTERED 
(
	[UserUID] ASC,
	[QuestID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[MPenalty_Log]', N'U') IS NULL
CREATE TABLE [dbo].[MPenalty_Log](
	[PenaltyUID] [bigint] NULL,
	[PenaltyType] [tinyint] NULL,
	[PenaltyTarget] [nvarchar](255) NULL,
	[StartDate] [smalldatetime] NULL,
	[EndDate] [smalldatetime] NULL,
	[Contents] [nvarchar](500) NULL,
	[RegDate] [smalldatetime] NULL,
	[Reason] [tinyint] NULL,
	[ExpiredDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[MPenalty]', N'U') IS NULL
CREATE TABLE [dbo].[MPenalty](
	[PenaltyUID] [bigint] IDENTITY(1,1) NOT NULL,
	[PenaltyType] [tinyint] NULL,
	[PenaltyTarget] [nvarchar](255) NULL,
	[StartDate] [smalldatetime] NULL,
	[EndDate] [smalldatetime] NULL,
	[Contents] [nvarchar](500) NULL,
	[RegDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[MInternalID]', N'U') IS NULL
CREATE TABLE [dbo].[MInternalID](
	[ID] [nvarchar](20) NOT NULL,
	[UserUID] [bigint] NULL,
 CONSTRAINT [PKC_LInternalID_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[MFriendSystem_UserInfo]', N'U') IS NULL
CREATE TABLE [dbo].[MFriendSystem_UserInfo](
	[UserUID] [bigint] NOT NULL,
	[Category] [int] NOT NULL,
	[Gender] [tinyint] NOT NULL,
	[Birth] [bigint] NOT NULL,
	[UserProfile] [nvarchar](20) NULL,
	[UpdateDate] [smalldatetime] NOT NULL,
	[UsageCheck] [tinyint] NOT NULL,
 CONSTRAINT [PKC_MFriendSystem_UserInfo_UserUID] PRIMARY KEY CLUSTERED 
(
	[UserUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[MEvent_ExchangeQuantity]', N'U') IS NULL
CREATE TABLE [dbo].[MEvent_ExchangeQuantity](
	[FromItemID] [int] NOT NULL,
	[ToItemID] [int] NOT NULL,
	[MaxQuantity] [int] NOT NULL,
	[NowQuantity] [int] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[MessengerSN]', N'U') IS NULL
CREATE TABLE [dbo].[MessengerSN](
	[SN] [int] IDENTITY(1,1) NOT NULL,
	[userUID] [bigint] NOT NULL,
	[ServerGroupID] [tinyint] NOT NULL,
	[unitUID] [bigint] NOT NULL,
 CONSTRAINT [PKC_NexsonSN_SN] PRIMARY KEY CLUSTERED 
(
	[SN] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY],
 CONSTRAINT [UK_NexsonSN_UserUID] UNIQUE NONCLUSTERED 
(
	[unitUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[HackingUser]', N'U') IS NULL
CREATE TABLE [dbo].[HackingUser](
	[UserUID] [bigint] NOT NULL,
	[IP] [nvarchar](15) NOT NULL,
	[RegDate] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[HackingModulelist]', N'U') IS NULL
CREATE TABLE [dbo].[HackingModulelist](
	[DLLName] [nvarchar](20) NULL,
	[Allow] [smallint] NULL
) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[FieldServey]', N'U') IS NULL
CREATE TABLE [dbo].[FieldServey](
	[UserUID] [bigint] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL,
 CONSTRAINT [PKC_FieldServey_UserUID] PRIMARY KEY CLUSTERED 
(
	[UserUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MServerDBConnectionInfo] (VS 2026 / SQL 2017-2025 Manager DB) ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'[dbo].[MServerDBConnectionInfo]', N'U') IS NULL
CREATE TABLE [dbo].[MServerDBConnectionInfo](
	[ServerType] [int] NOT NULL,
	[ServerGroupID] [int] NOT NULL DEFAULT ((-1)),
	[DBType] [int] NOT NULL,
	[EncryptedConnStr] [nvarchar](1024) NOT NULL,
	[ThreadCount] [int] NOT NULL DEFAULT ((4)),
 CONSTRAINT [PK_MServerDBConnectionInfo] PRIMARY KEY CLUSTERED 
(
	[ServerType] ASC,
	[ServerGroupID] ASC,
	[DBType] ASC
)
) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'NC_SYS_SP_ErrorLog_DT_ERROR_DATE' AND object_id = OBJECT_ID(N'[dbo].[SYS_SP_ErrorLog]'))
CREATE NONCLUSTERED INDEX [NC_SYS_SP_ErrorLog_DT_ERROR_DATE] ON [dbo].[SYS_SP_ErrorLog] 
(
	[DT_ERROR_DATE] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'NC_SYS_SP_ErrorLog_ST_ERROR_PROCEDURE' AND object_id = OBJECT_ID(N'[dbo].[SYS_SP_ErrorLog]'))
CREATE NONCLUSTERED INDEX [NC_SYS_SP_ErrorLog_ST_ERROR_PROCEDURE] ON [dbo].[SYS_SP_ErrorLog] 
(
	[ST_ERROR_PROCEDURE] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_AConnectLog_LoginTime' AND object_id = OBJECT_ID(N'[dbo].[AConnectLog]'))
CREATE NONCLUSTERED INDEX [IX_AConnectLog_LoginTime] ON [dbo].[AConnectLog] 
(
	[LoginTime] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_AConnectLog_LogoutTime' AND object_id = OBJECT_ID(N'[dbo].[AConnectLog]'))
CREATE NONCLUSTERED INDEX [IX_AConnectLog_LogoutTime] ON [dbo].[AConnectLog] 
(
	[LogoutTime] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_AConnectLog_UserUID' AND object_id = OBJECT_ID(N'[dbo].[AConnectLog]'))
CREATE NONCLUSTERED INDEX [IX_AConnectLog_UserUID] ON [dbo].[AConnectLog] 
(
	[UserUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_MQuests_Repeat_UserUID' AND object_id = OBJECT_ID(N'[dbo].[MQuests_Repeat]'))
CREATE CLUSTERED INDEX [IXC_MQuests_Repeat_UserUID] ON [dbo].[MQuests_Repeat] 
(
	[UserUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'CL_MPenalty_Log_EndDate' AND object_id = OBJECT_ID(N'[dbo].[MPenalty_Log]'))
CREATE CLUSTERED INDEX [CL_MPenalty_Log_EndDate] ON [dbo].[MPenalty_Log] 
(
	[EndDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_MPenalty_Log_PenaltyTarget' AND object_id = OBJECT_ID(N'[dbo].[MPenalty_Log]'))
CREATE NONCLUSTERED INDEX [IX_MPenalty_Log_PenaltyTarget] ON [dbo].[MPenalty_Log] 
(
	[PenaltyTarget] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'CL_MPenalty_StartDate' AND object_id = OBJECT_ID(N'[dbo].[MPenalty]'))
CREATE CLUSTERED INDEX [CL_MPenalty_StartDate] ON [dbo].[MPenalty] 
(
	[EndDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_MPenalty_PenaltyTarget' AND object_id = OBJECT_ID(N'[dbo].[MPenalty]'))
CREATE NONCLUSTERED INDEX [IX_MPenalty_PenaltyTarget] ON [dbo].[MPenalty] 
(
	[PenaltyTarget] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IXC_HackingModulelist_DLLName' AND object_id = OBJECT_ID(N'[dbo].[HackingModulelist]'))
CREATE CLUSTERED INDEX [IXC_HackingModulelist_DLLName] ON [dbo].[HackingModulelist] 
(
	[DLLName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF OBJECT_ID(N'[dbo].[DF_TUserLoginHistory_RegDate]') IS NULL
/****** Object:  Default [DF_TUserLoginHistory_RegDate]    Script Date: 01/25/2014 12:17:35 ******/
ALTER TABLE [dbo].[TUserLoginHistory] ADD  CONSTRAINT [DF_TUserLoginHistory_RegDate]  DEFAULT (getdate()) FOR [RegDate]
GO
IF OBJECT_ID(N'[dbo].[DF_TUser_authlevel]') IS NULL
/****** Object:  Default [DF_TUser_authlevel]    Script Date: 01/25/2014 12:17:35 ******/
ALTER TABLE [dbo].[TUser] ADD  CONSTRAINT [DF_TUser_authlevel]  DEFAULT ((0)) FOR [authlevel]
GO
IF OBJECT_ID(N'[dbo].[DF_MUser_PlayDayCnt]') IS NULL
/****** Object:  Default [DF_MUser_PlayDayCnt]    Script Date: 01/25/2014 12:17:35 ******/
ALTER TABLE [dbo].[MUser] ADD  CONSTRAINT [DF_MUser_PlayDayCnt]  DEFAULT ((1)) FOR [PlayDayCnt]
GO
IF OBJECT_ID(N'[dbo].[DF_MUser_LastLogin]') IS NULL
/****** Object:  Default [DF_MUser_LastLogin]    Script Date: 01/25/2014 12:17:35 ******/
ALTER TABLE [dbo].[MUser] ADD  CONSTRAINT [DF_MUser_LastLogin]  DEFAULT (getdate()) FOR [LastLogin]
GO
IF OBJECT_ID(N'[dbo].[DF_MUser_IsRecommend]') IS NULL
/****** Object:  Default [DF_MUser_IsRecommend]    Script Date: 01/25/2014 12:17:35 ******/
ALTER TABLE [dbo].[MUser] ADD  CONSTRAINT [DF_MUser_IsRecommend]  DEFAULT ((0)) FOR [IsRecommend]
GO
IF OBJECT_ID(N'[dbo].[DF_MUser_IsExperience]') IS NULL
/****** Object:  Default [DF_MUser_IsExperience]    Script Date: 01/25/2014 12:17:35 ******/
ALTER TABLE [dbo].[MUser] ADD  CONSTRAINT [DF_MUser_IsExperience]  DEFAULT ((0)) FOR [GuestUser]
GO
IF OBJECT_ID(N'[dbo].[DF_MUser_IsLogin]') IS NULL
/****** Object:  Default [DF_MUser_IsLogin]    Script Date: 01/25/2014 12:17:35 ******/
ALTER TABLE [dbo].[MUser] ADD  CONSTRAINT [DF_MUser_IsLogin]  DEFAULT ((0)) FOR [IsLogin]
GO
IF OBJECT_ID(N'[dbo].[DF_MUser_SecurityType]') IS NULL
/****** Object:  Default [DF_MUser_SecurityType]    Script Date: 01/25/2014 12:17:35 ******/
ALTER TABLE [dbo].[MUser] ADD  CONSTRAINT [DF_MUser_SecurityType]  DEFAULT ((0)) FOR [SecurityType]
GO
IF OBJECT_ID(N'[dbo].[DF_MUser_ChannelCode]') IS NULL
/****** Object:  Default [DF_MUser_ChannelCode]    Script Date: 01/25/2014 12:17:35 ******/
ALTER TABLE [dbo].[MUser] ADD  CONSTRAINT [DF_MUser_ChannelCode]  DEFAULT ((0)) FOR [ChannelCode]
GO
IF OBJECT_ID(N'[dbo].[DF_AConnectLog_TotalPlayTime]') IS NULL
/****** Object:  Default [DF_AConnectLog_TotalPlayTime]    Script Date: 01/25/2014 12:17:35 ******/
ALTER TABLE [dbo].[AConnectLog] ADD  CONSTRAINT [DF_AConnectLog_TotalPlayTime]  DEFAULT ((0)) FOR [TotalPlayTime]
GO
IF OBJECT_ID(N'[dbo].[DF_AConnectLog_VsPlayTime]') IS NULL
/****** Object:  Default [DF_AConnectLog_VsPlayTime]    Script Date: 01/25/2014 12:17:35 ******/
ALTER TABLE [dbo].[AConnectLog] ADD  CONSTRAINT [DF_AConnectLog_VsPlayTime]  DEFAULT ((0)) FOR [VsPlayTime]
GO
IF OBJECT_ID(N'[dbo].[DF_AConnectLog_IsInternal]') IS NULL
/****** Object:  Default [DF_AConnectLog_IsInternal]    Script Date: 01/25/2014 12:17:35 ******/
ALTER TABLE [dbo].[AConnectLog] ADD  CONSTRAINT [DF_AConnectLog_IsInternal]  DEFAULT ((0)) FOR [IsInternal]
GO
IF OBJECT_ID(N'[dbo].[DF_AConnectLog_ArcadePlayTime]') IS NULL
/****** Object:  Default [DF_AConnectLog_ArcadePlayTime]    Script Date: 01/25/2014 12:17:35 ******/
ALTER TABLE [dbo].[AConnectLog] ADD  CONSTRAINT [DF_AConnectLog_ArcadePlayTime]  DEFAULT ((0)) FOR [ArcadePlayTime]
GO
IF OBJECT_ID(N'[dbo].[DF_AConnectLog_PCBangFlag]') IS NULL
/****** Object:  Default [DF_AConnectLog_PCBangFlag]    Script Date: 01/25/2014 12:17:35 ******/
ALTER TABLE [dbo].[AConnectLog] ADD  CONSTRAINT [DF_AConnectLog_PCBangFlag]  DEFAULT ((0)) FOR [PCBangFlag]
GO
CREATE OR ALTER PROCEDURE [dbo].[P_NewAccount_GET_Nickname]
	@pagesize				int
,	@lastsize				int
,	@eventdate				smalldatetime
--,	@SearchType				tinyint
,	@SearchValue			nvarchar(128)
AS
	SET NOCOUNT ON
	
	DECLARE @StartNum		int
	,	@EndNum				int

	SET @StartNum = @lastsize 
	SET @EndNum = @StartNum + @pagesize - 1
	
	DECLARE @SQL	nvarchar(max)
	,	@SQLParam	nvarchar(1000)
	,	@SQLWhere	nvarchar(1000)
	
	SELECT @SQL = N'', @SQLWhere = N''
	SET @SQLParam = N'@StartNum int, @EndNum int, @eventdate smalldatetime, @SearchValue nvarchar(1500)'
	
	SET @SQLWhere = N''
	
	If ISDATE(@eventdate) = 1 BEGIN
		SET @SQLWhere = N'WHERE a.regdate >= @eventdate AND a.regdate < DATEADD(dd, 1, @eventdate)'
	END
	ELSE BEGIN
		SET @SQLWhere = N'WHERE a.regdate >= convert(nvarchar(10),getdate(),121)'
	END
		
--	IF @SearchType > 0 BEGIN
--		SET @SQLWhere = @SQLWhere + N' AND ' + CASE @SearchType 
--			WHEN 1 THEN N'EventName = @SearchValue'
--			WHEN 2 THEN N'ScriptID = CAST(@SearchValue AS int)'
--			ELSE N'' END

--		IF RIGHT(@SQLWhere, 5) = N' AND '
--			SET @SQLWhere = LEFT(@SQLWhere, LEN(@SQLWhere) - 4)
--	END

	SET @SQL = N'
	select userid, useruid, nickname, [password],  Unit_RegDate
	from (
		Select 
					a.userid, 
					a.useruid, 
					c.nickname, 
					a.[password], 
					b.regdate as Unit_RegDate,
					ROW_NUMBER() OVER(ORDER BY b.regdate DESC) AS RowNum
				FROM dbo.muser as A with(nolock)
				JOIN [Game01].[dbo].[GUnit] as B with(nolock)
				on a.useruid = b.useruid
				JOIN [Game01].[dbo].[GUnitNickName] as C with(nolock)
				on b.unituid = c.unituid
				'+ @SQLWhere +N'
	) AS TempTable
	WHERE RowNum BETWEEN @StartNum AND @EndNum
	ORDER BY RowNum ASC'
	
	BEGIN TRY
		EXEC sp_executesql @SQL, @SQLParam, @StartNum, @EndNum, @eventdate, @SearchValue
	END TRY
	BEGIN CATCH
		PRINT @SQL
	END CATCH
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

	SELECT @int1 as COLUMNAME
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
CREATE OR ALTER PROCEDURE [dbo].[P_Manager_BlockIP_INS]
	@ClassIP	NVARCHAR(11)
,	@IPBegin	TINYINT
,	@IPEnd		TINYINT
,	@Result		INT = 0 OUTPUT
AS
SET NOCOUNT ON;

DECLARE @EXEC_SCRIPT	NVARCHAR(MAX)
,		@SQLUser		NVARCHAR(50)

BEGIN TRAN
	
	INSERT INTO ABlockIP (ClassIP, IPBagin, IPEnd)
		SELECT @ClassIP, @IPBegin, @IPEnd
	
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
CREATE OR ALTER PROCEDURE [dbo].[P_Manager_BlockIP_DEL]
	@ClassIP	NVARCHAR(11)
,	@IPBegin	TINYINT
,	@IPEnd		TINYINT
,	@Result		INT = 0 OUTPUT
AS
SET NOCOUNT ON;

BEGIN TRAN
	
	DELETE FROM ABlockIP 
	WHERE ClassIP = @ClassIP 
	AND IPBagin = @IPBegin
	AND IPEnd = @IPEnd
	
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	BEGIN	SELECT @Result = -1	GOTO FAIL_TRAN	END

COMMIT TRAN
GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
GO
CREATE OR ALTER PROCEDURE [dbo].[mup_get_serversn_check]
	@iServerSN		BIGINT
/*
	2011.11.10
	제재된(로그인 할 수 없는) ServerSN 체크
*/
AS
	SET NOCOUNT ON

	SELECT ISAbnormalSN
	FROM dbo.Temp_MID_SN WITH(NOLOCK)
	WHERE ServerSN = @iServerSN
GO
CREATE OR ALTER PROCEDURE [dbo].[mup_get_second_pw_Info]
	@iUserUID	BIGINT
	
AS
SET NOCOUNT ON;

SELECT IsSecondPW, SecondPW, FailedCount, LastAuthDate
	FROM dbo.MUserSecondPW WITH (NOLOCK) 
		WHERE UserUID = @iUserUID
GO
CREATE OR ALTER PROCEDURE [dbo].[mup_get_Retaining_User]
	@iUserUID		BIGINT

AS
SET NOCOUNT ON;

SELECT TOP 1 RegDate
	FROM dbo.RetainingUser WITH (NOLOCK)
		WHERE UserUID = @iUserUID
GO
CREATE OR ALTER PROCEDURE [dbo].[mup_get_release_tick]

AS
SET NOCOUNT ON;


select [Type], [Count]
	from dbo.ReleaseTick WITH (NOLOCK)
GO
CREATE OR ALTER PROCEDURE [dbo].[mup_get_rejected_user]


AS
SET NOCOUNT ON;



SELECT UserUID
	FROM dbo.RejectedUser WITH (NOLOCK)
GO
CREATE OR ALTER PROCEDURE [dbo].[mup_get_mid_sn]
	@iServerSN	bigint
,	@strMID		nvarchar(24)
/*
	2011.11.10
	MID에 대응되는 ServerSN, ServerSN에 대응되는 MID 전달
*/
AS
	SET NOCOUNT ON

	DECLARE @strMID_	NVARCHAR(24) --반환해줄 MID
	,		@iServerSN_	BIGINT		 --반환해줄 SN
	,		@Result		INT

	IF EXISTS ( SELECT ServerSN FROM dbo.Temp_MID_SN WITH(NOLOCK) WHERE MID = @strMID AND IsAbnormalSN = 1) BEGIN
		SELECT @strMID_ = MID
		FROM dbo.Temp_MID_SN WITH(NOLOCK)
		WHERE ServerSN = @iServerSN
			
			
		SELECT @iServerSN_ = ServerSN
		FROM dbo.Temp_MID_SN WITH(NOLOCK)
		WHERE MID = @strMID
	
		SET @Result = 1
	END
	ELSE BEGIN
		SELECT @strMID_ = MID
		FROM dbo.Temp_MID_SN WITH(NOLOCK)
		WHERE ServerSN = @iServerSN
			
			
		SELECT @iServerSN_ = ServerSN
		FROM dbo.Temp_MID_SN WITH(NOLOCK)
		WHERE MID = @strMID
	
		SET @Result = 0
	END
	
	SELECT @strMID_, @iServerSN_, @Result
GO
CREATE OR ALTER PROCEDURE [dbo].[mup_get_MessengerSN]
	@ServerSetID	TINYINT
 ,   @iUnitUID_		[bigint]
,	@iMessengerSN	[int] = 0
AS
/* 
작성자 : sutamtwo
작성일 : 2007년 11월 27일
사용 :  넥슨 플러그에 사용될 SN값을 Account.MessengerSN 디비에서 불러온다
결과값 : SN이 0이면 실패, 아닐 경우 성공

*/
SET NOCOUNT ON;
SET XACT_ABORT ON;

	SELECT @iMessengerSN = SN 
			FROM dbo.MessengerSN WITH (NOLOCK)
				WHERE UnitUID = @iUnitUID_	AND ServerGroupID = @ServerSetID	

SELECT @iMessengerSN
GO
/*
	2008. 06. 02
	sutamtwo
	해킹 의심 유저 리스트에 가져가기
*/

CREATE OR ALTER PROCEDURE [dbo].[mup_get_hackerlist] 
	@iUserUID	bigint
,	@iOK		int = 0
AS
SET NOCOUNT ON;

IF NOT EXISTS ( SELECT * FROM dbo.MUserHackerList WITH(NOLOCK) WHERE UserUID = @iUserUID)
    BEGIN    GOTO END_PROC    END --해당 유저는 일반유저
 

	SELECT	@iOK = IsAgree 
		FROM dbo.MUserHackerList WITH (NOLOCK)
			WHERE USERUID = @iUserUID
	
	IF @iOK = 0
		BEGIN	SELECT @iOK = 2	END


END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[mup_get_Comebackuser_info_web]
	@strUserID	NVARCHAR(20)

/*
	휴먼 복귀 유저 시스템
		: 웹에서 휴면 유저인지 판단
*/

AS
SET NOCOUNT ON;

DECLARE @iUserUID     BIGINT

SELECT @iUserUID = UserUID FROM dbo.MUser WITH (NOLOCK) WHERE UserID = @strUserID

SELECT DATEDIFF(dd,LogoutTime, GETDATE()) AS Total
	FROM dbo.MUserComeback_Logout
		WHERE UserUID = @iUserUID
GO
CREATE OR ALTER PROCEDURE [dbo].[mup_get_Comebackuser_info]
	@iUserUID	BIGINT

/*
	휴먼 복귀 유저 시스템
		: 복귀 유저 정보 얻기
*/

AS
SET NOCOUNT ON;
    
SELECT IsComeBackUser, RewardEndDate
	FROM dbo.MUserComeback WITH (NOLOCK)
		WHERE UserUID = @iUserUID
GO
CREATE OR ALTER PROCEDURE [dbo].[mup_get_comeback_logout] 
	@iUserUID		BIGINT
AS
SET NOCOUNT ON;

SELECT LogoutTime
	FROM dbo.MUserComeback_Logout
		WHERE UserUID = @iUserUID
GO
CREATE OR ALTER PROCEDURE [dbo].[mup_get_authority_list]
	@iAuthLevel	[tinyint]
AS
SET NOCOUNT ON;

SELECT UserID, UserName FROM dbo.MUser WITH(NOLOCK) WHERE UserUID IN ( SELECT UserUID FROM dbo.MUserAuthority WHERE AuthLevel = @iAuthLevel )
GO
CREATE OR ALTER PROCEDURE [dbo].[mup_event_connect_user]
	@strUserID_ [nvarchar](24)
AS
SET NOCOUNT ON;

DECLARE @ConnectList TABLE
(
    UserID nvarchar(24) not null,
    LoginHour int not null
)

DECLARE @iUserUID [bigint]

SELECT	@iUserUID = UserUID
	FROM dbo.MUser WITH (NOLOCK)
		WHERE UserID = @strUserID_

SELECT @strUserID_, Sum(DateDiff(n,LoginTime,LogoutTime)) From 
		dbo.AConnectLog WITH (NOLOCK) 
			WHERE DateDiff(dd,'2010-10-01',LoginTime) >= 0 And DateDiff(dd,'2010-10-31',LoginTime) <= 0 AND UserUID = @iUserUID
GO
CREATE OR ALTER PROCEDURE [dbo].[mup_delete_second_pw]
	@iUserUID		BIGINT,
	@strSecondPW	NVARCHAR(8),
	@iOK			INT = 0
	
AS
SET NOCOUNT ON;

DECLARE @strSecondPW_	NVARCHAR(8),
		@sdtNow smalldatetime
SELECT @sdtNow = GetDate()
SELECT @strSecondPW_ = SecondPW FROM dbo.MUserSecondPW WITH (NOLOCK) WHERE UserUID = @iUserUID

IF(@strSecondPW <> @strSecondPW_)
BEGIN
	SELECT @iOK = -1 GOTO END_PROC
END

BEGIN TRAN
    UPDATE dbo.MUserSecondPW WITH (ROWLOCK)
		SET IsSecondPW = 0, FailedCount = 0, DeleteDate = @sdtNow
			WHERE UserUID = @iUserUID
    
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
    BEGIN    SELECT @iOK = -11   GOTO FAIL_TRAN    END
    
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[mup_create_second_pw]
	@iUserUID		BIGINT,
	@strSecondPW	NVARCHAR(8),
	@iOK			INT = 0
	
AS
SET NOCOUNT ON;

IF NOT EXISTS(SELECT * FROM dbo.MUser WITH(NOLOCK) WHERE UserUID = @iUserUID )
    BEGIN    SELECT @iOK = -1    GOTO END_PROC    END
    
DECLARE @sdtNow smalldatetime
SELECT @sdtNow = GetDate()

BEGIN TRAN

	IF NOT EXISTS (SELECT * FROM dbo.MUserSecondPW WITH(NOLOCK) WHERE UserUID = @iUserUID)
		BEGIN	
			INSERT INTO dbo.MUserSecondPW(UserUID, SecondPW, IsSecondPW, FailedCount, LastAuthDate, CreateDate, DeleteDate)
				SELECT @iUserUID, @strSecondPW, 1, 0, @sdtNow, @sdtNow, @sdtNow
    
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN    SELECT @iOK = -11   GOTO FAIL_TRAN    END	
		END
	ELSE
		BEGIN
			UPDATE dbo.MUserSecondPW WITH (ROWLOCK)
				SET SecondPW = @strSecondPW, IsSecondPW = 1, FailedCount = 0, LastAuthDate = @sdtNow, CreateDate = @sdtNow
					WHERE UserUID = @iUserUID
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN    SELECT @iOK = -12   GOTO FAIL_TRAN    END
		END
    
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[mup_create_global_user]
	@strUserID_ [nvarchar](20),
	@strPassword_ [nvarchar](20),
    @iPublisherSN_ [int],
    @bGender_ [bit],
    @iAge_ [tinyint],
	@strUserName_ [nvarchar](16),
	@iGuestUser_ [bit],
	@iChannelCode	tinyint	= 0,	
	@iUserUID [bigint] = 0,
	@bPlayGuide [bit] = 1,
	@bInternalUser [bit] = 0,
	@iOK [int] = 0

AS
SET NOCOUNT ON;

-- 중복되는 UserID
IF EXISTS( SELECT * FROM dbo.Muser WITH(NOLOCK) WHERE UserID = @strUserID_ )
BEGIN
    SELECT @iOK = -1
    GOTO END_PROC
END

DECLARE @sdtNow smalldatetime
SELECT @sdtNow = GetDate()

BEGIN TRAN
    INSERT INTO   dbo.MUser(
                            UserID
,                           Password
,                           PublisherSN
,                           Gender
,                           Age
,                           UserName
,                           RegDate
,                           DelDate
,                           PlayGuide
,							GuestUser
,							ChannelCode
                           )
        SELECT  @strUserID_
,               @strPassword_
,               @iPublisherSN_
,               @bGender_
,               @iAge_
,               @strUserName_
,               @sdtNow
,               @sdtNow
,               1
,				@iGuestUser_
,				@iChannelCode
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1 --이건 한개만 입력되어야 하삼
    BEGIN
        SELECT @iOK = -11
        GOTO FAIL_TRAN
    END

    SELECT @iUserUID = @@IDENTITY

	INSERT INTO dbo.MUserOTP( UserUID, OTP ) SELECT @iUserUID, @strPassword_
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1 --이건 한개만 입력되어야 하삼
    BEGIN
        SELECT @iOK = -12
        GOTO FAIL_TRAN
    END


COMMIT TRAN

-- 사내 또는 gash 유저인지 식별한다.
IF EXISTS( SELECT * FROM dbo.MInternalID WITH( NOLOCK ) WHERE ID = @strUserID_ )
BEGIN
    SET @bInternalUser = 1
END

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK, @iUserUID, @bPlayGuide, @bInternalUser, 0
GO
CREATE OR ALTER PROCEDURE [dbo].[mup_create_Comebackuser_info]
	@iUserUID			BIGINT
,	@iRewardLevel		TINYINT
,	@sdtRewardEndDate	SMALLDATETIME
,	@sdtRegDate			SMALLDATETIME
,	@iOK				INT = 0

/*
	휴먼 복귀 유저 시스템
		: 복귀 유저 정보 저장
*/

AS
SET NOCOUNT ON;

IF NOT EXISTS(SELECT * FROM dbo.Muser WITH (NOLOCK) WHERE UserUID = @iUserUID)
    BEGIN    SELECT @iOK = -1    GOTO END_PROC    END

BEGIN TRAN
	IF NOT EXISTS(SELECT * FROM dbo.MUserComeback WITH (NOLOCK) WHERE UserUID = @iUserUID)
		BEGIN
			INSERT INTO dbo.MUserComeback WITH(UPDLOCK) (UserUID, IsComeBackUser, RewardLevel, RewardEndDate, RegDate)
				SELECT @iUserUID, 1, @iRewardLevel, @sdtRewardEndDate, @sdtRegDate

			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN
					SELECT @iOK = -2	GOTO FAIL_TRAN
				END
		END
	ELSE
		BEGIN
			UPDATE dbo.MUserComeback WITH (UPDLOCK)
				SET IsComeBackUser = 1, RewardLevel = @iRewardLevel, RewardEndDate = @sdtRewardEndDate, RegDate = @sdtRegDate
					WHERE UserUID = @iUserUID
					
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
CREATE OR ALTER PROCEDURE [dbo].[mup_auth_user]
    @bDebugAuth [bit],
	@strUserID_ [nvarchar](20),
	@strPassword_ [nvarchar](20),
	@iAge_ [int],
	@iPublisherSN_ [int],
	@iOK [int] = 0,
	@iUserUID [bigint] = 0,
    @bPlayGuide [bit] = 1,
	@iAuthLevel [int] = 0,
    @bInternalUser [bit] = 0
AS
SET NOCOUNT ON;

DECLARE @strPassword nvarchar(20)
,       @strUserName nvarchar(16)
,		@iAge int
,       @bDeleted bit
,		@sdtEnddate smalldatetime
,		@strReason	nvarchar(100)
,		@bIsRecommend bit
,		@iPublisherSN	INT
,		@iSkillOption bit
,		@sdtRegdate	SMALLDATETIME
,		@sdtLastLogin SMALLDATETIME


SELECT  @sdtEnddate = getdate()
,		@strReason = '제재 이유'

SELECT  @iUserUID = UserUID
,       @strPassword = Password
,       @strUserName = UserName
,		@iAge = Age
,       @bPlayGuide = PlayGuide
,       @bDeleted = Deleted
,		@bIsRecommend = IsRecommend
,		@iPublisherSN = PublisherSN
,		@sdtRegdate = RegDate
,		@sdtLastLogin = LastLogin
    FROM dbo.MUser WITH(NOLOCK)
        WHERE UserID = @strUserID_


-- 스킬 옵션 얻어가기
SELECT @iSkillOption = SkillOption 
	FROM dbo.MUserSkillOption WITH (NOLOCK)
		WHERE USERUID = @iUserUID
		
		

IF @iUserUID = 0 --유저가 존재하지 않음
    BEGIN    SELECT @iOK = -1    GOTO END_PROC    END

IF @bDeleted = 1 --삭제된 유저임
    BEGIN    SELECT @iOK = -2    GOTO END_PROC    END

IF @bDebugAuth = 1
BEGIN
	IF @strPassword_ <> @strPassword --틀린 팻흐워두
		BEGIN    SELECT @iOK = -3    GOTO END_PROC    END
END

-- 나이는 변할 수 있다
IF @iAge_ <> @iAge
BEGIN
	UPDATE dbo.MUser SET Age = @iAge_ WHERE UserID = @strUserID_
END

SELECT @iAuthLevel = AuthLevel FROM dbo.MUserAuthority WITH (NOLOCK) WHERE UserUID = @iUserUID

-- 일반 유저라면, 계정 블럭 상태인가 파악한다
IF @iAuthLevel = 0	
	BEGIN
		SELECT @iAuthLevel = authlevel, @sdtEndDate = enddate, @strReason = reason
			from dbo.userauthlevel with (nolock)
				where useruid = @iUserUID
	END

-- 블럭상태가 ON인 유저라면 EndDate가 오늘보다 이전 날짜인지 판단
IF @iAuthLevel < 0
	BEGIN
		IF @sdtEnddate < getdate()
			BEGIN
				UPDATE dbo.userauthlevel 
					SET authlevel = 0
						WHERE userUID = @iuserUID

				SELECT @iAuthLevel = 0
			END

	END


-- 사내 또는 넥슨 유저인지 식별한다.
IF EXISTS( SELECT * FROM dbo.MInternalID WITH( NOLOCK ) WHERE ID = @strUserID_ )
BEGIN
    SET @bInternalUser = 1
END

END_PROC:
--마지막 행 추가 0
SELECT @iOK, @iUserUID, @strUserName, @iAuthLevel, @bPlayGuide, @bInternalUser, @sdtEnddate, @strReason, @bIsRecommend, @sdtRegdate, @sdtLastLogin, @iPublisherSN
GO
CREATE OR ALTER PROCEDURE [dbo].[mup_auth_global_user]
	@strUserID_ [nvarchar](20),		/*@strOTP_ [nvarchar](32), -- OTP 입력 해당 SP에서 안함*/
	@iOK [int] = 0,
	@iUserUID [bigint] = 0

AS
SET NOCOUNT ON;

DECLARE @PublisherSN	INT

SELECT @iUserUID = UserUID, @PublisherSN = PublisherSN FROM dbo.Muser WITH(NOLOCK) WHERE UserID = @strUserID_ 

IF @iUserUID = 0
BEGIN
    SELECT @iOK = -1
    GOTO END_PROC
END

--{{ 유럽은 신속한 빠른 블록 처리를 위해 AuthLevel을 0으로 처리하면 로그인에 실패함
DECLARE @iAuthLevel int

SELECT @iAuthLevel = AuthLevel FROM dbo.MUserAuthority WITH (NOLOCK) WHERE UserUID = @iUserUID

IF @iAuthLevel = -4
	Begin
		SELECT @iOK = -5    GOTO END_PROC
	End
--}}

IF NOT EXISTS ( SELECT * FROM dbo.MUserOTP WITH(NOLOCK) WHERE UserUID = @iUserUID)
    BEGIN    SELECT @iOK = -2    GOTO END_PROC    END
/* -- KOG_OTP_MODIFY 해당 부분 주석 처리함. UPDATE를 여기서 처리하면 안됨
BEGIN TRAN

    UPDATE dbo.MUserOTP WITH (ROWLOCK)
		SET OTP = @strOTP_
			WHERE UserUID = @iUserUID
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1 --이건 한개만 입력되어야 하삼
    BEGIN    SELECT @iOK = -3   GOTO FAIL_TRAN    END

COMMIT TRAN
*/

GOTO END_PROC

--FAIL_TRAN:
--ROLLBACK TRAN

END_PROC:
SELECT @iOK, @iUserUID, @PublisherSN
GO
CREATE OR ALTER PROCEDURE [dbo].[mup_insert_MessengerSN] 
	@iUserUID_			[bigint]
,	@iServerGroupID_	[tinyint]
,   @iUnitUID_			[bigint]
,	@iOK				[int] = 0
AS
/* 
작성자 : sutamtwo
작성일 : 2007년 11월 27일
사용 :  캐릭터 선택 시 호출이되며, 호출되면 캐릭터의 UnitUID를 받아 
		넥슨 플러그에 사용될 SN값을 Account.MessengerSN 디비에서 불러온다
결과값 : SN이 0이면 실패, 아닐 경우 성공

*/
SET NOCOUNT ON;
SET XACT_ABORT ON;


BEGIN TRAN
	-- NexonSN 부여 
	INSERT INTO dbo.MessengerSN (UserUID, ServerGroupID, UnitUID)
		SELECT @iUserUID_, @iServerGroupID_, @iUnitUID_
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
CREATE OR ALTER PROCEDURE [dbo].[mup_insert_hacking_user]
	@iUserUID	BIGINT,
	@strIP	NVARCHAR(15),
	@iOK		[int] = 0	

AS
SET NOCOUNT ON;			
						
BEGIN TRAN	
			
INSERT INTO dbo.HackingUser (UserUID, IP, RegDate)
	SELECT @iUserUID, @strIP, GETDATE()
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
	2008. 06. 02
	sutamtwo
	해킹 의심 유저 리스트에 등록하기
*/

CREATE OR ALTER PROCEDURE [dbo].[mup_insert_hackerlist] 
	@iUserUID	bigint
,	@iOK		int = 0
AS
SET NOCOUNT ON;

IF EXISTS ( SELECT * FROM dbo.MUserHackerList WITH(NOLOCK) WHERE UserUID = @iUserUID)
    BEGIN    SELECT @iOK = -1    GOTO END_PROC    END --중복되는 유저ID 있삼
 
DECLARE @sdtNow smalldatetime
SELECT	@sdtNow = GetDate()

BEGIN TRAN
    INSERT INTO	dbo.MUserHackerList (UserUID, IsAgree, RegDate)
        SELECT @iUserUID, 0, @sdtNow

    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1 --이건 한개만 입력되어야 하삼
    BEGIN    SELECT @iOK = -2   GOTO FAIL_TRAN    END
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[mup_insert_comeback_logout] 
	@iUserUID		BIGINT
,	@sdtLogoutTime	SMALLDATETIME
,	@iOK			INT = 0
AS
SET NOCOUNT ON;

IF NOT EXISTS ( SELECT * FROM dbo.MUser WITH(NOLOCK) WHERE UserUID = @iUserUID)
    BEGIN    SELECT @iOK = -1    GOTO END_PROC    END 
 

BEGIN TRAN
	IF EXISTS ( SELECT * FROM dbo.MUserComeback_Logout WITH(NOLOCK) WHERE UserUID = @iUserUID)
		BEGIN
			UPDATE dbo.MUserComeback_Logout WITH (UPDLOCK)
			SET LogoutTime = @sdtLogoutTime
			WHERE UserUID = @iUserUID
			
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1 
			BEGIN    SELECT @iOK = -3   GOTO FAIL_TRAN    END
		END
	ELSE
		BEGIN
			INSERT INTO	dbo.MUserComeback_Logout WITH (UPDLOCK) (UserUID, LogoutTime)
			SELECT @iUserUID, @sdtLogoutTime

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
CREATE OR ALTER PROCEDURE [dbo].[mup_get_UserUID_Count]
	@iUserUID	BIGINT

AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

SELECT 	[Type],	[Count]
    FROM dbo.MUserUID_Count WITH (NOLOCK)
		WHERE UserUID = @iUserUID
GO
CREATE OR ALTER PROCEDURE [dbo].[mup_get_userinfo]
	@strUserID		NVARCHAR(20),
	@iOK			INT = 0	
	
AS
SET NOCOUNT ON;

DECLARE @iUserUID	BIGINT

IF NOT EXISTS(SELECT * FROM dbo.Muser WITH(NOLOCK) WHERE UserID = @strUserID )
    BEGIN    SELECT @iOK = -1    GOTO END_PROC    END

SELECT @iUserUID = UserUID
	FROM dbo.MUser WITH (NOLOCK)
		WHERE UserID = @strUserID
		
END_PROC:
	SELECT @iUserUID, @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[mup_get_user_info]
	@iUserUID_ [bigint]
,   @iOK [int] = 0
AS
SET NOCOUNT ON;

DECLARE @strName nvarchar(16)
,       @iAuthLevel int


SELECT @iAuthLevel = 0

SELECT @strName = UserName
	FROM dbo.MUser WITH(NOLOCK) 
		WHERE UserUID = @iUserUID_ AND Deleted = 0

IF @strName IS NULL
	BEGIN
		SELECT @iOK = -1
		SELECT @strName = N'NULL'
		GOTO END_PROC
	END

SELECT @iAuthLevel = AuthLevel 
	FROM MUserAuthority  WITH (NOLOCK) 
		WHERE UserUID = @iUserUID_

END_PROC:
SELECT @iOK, @strName, @iAuthLevel
GO
CREATE OR ALTER PROCEDURE [dbo].[mup_get_user_authkey]
	@strUserID	NVARCHAR(24)
	

AS
SET NOCOUNT ON;

DECLARE @iAuthKey INT

	SELECT @iAuthKey = AuthKey
		FROM dbo.MUserAuthentication WITH (NOLOCK)
			WHERE UserID = @strUserID

	IF @iAuthKey IS NULL
		BEGIN
			SELECT -1, -1
		END
	ELSE
		BEGIN
			SELECT @iAuthKey, 0
		END
GO
CREATE OR ALTER PROCEDURE [dbo].[mup_get_TradeBlock_user]


AS
SET NOCOUNT ON;



SELECT UserUID
	FROM dbo.TradeBlock WITH (NOLOCK)
GO
CREATE OR ALTER PROCEDURE [dbo].[mcp_get_character_block_info]
	@iUserUID		BIGINT,
	@iauthlevel		INT = 0 OUTPUT,
	@strReason		NVARCHAR(100) = N'' OUTPUT,
	@strsession		NVARCHAR(16) = N'' OUTPUT,
	@sdtstartdate	SMALLDATETIME = '20000101' OUTPUT,
	@sdtenddate		SMALLDATETIME = '20000101' OUTPUT
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

SELECT @iauthlevel = authlevel, @strReason = reason, @strsession = session, @sdtstartdate = startdate, @sdtenddate = enddate
	FROM dbo.UserAuthLevelhistory WITH (NOLOCK)
		WHERE UserUID = @iUserUID
			ORDER BY HistoryNo DESC
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_get_tool_login_history]
	@strSession_	[nvarchar](20)
,	@strIP_			[nvarchar](15)
,	@iOK			[int] = 0

AS
SET NOCOUNT ON;

DECLARE @sdtNow smalldatetime
SELECT @sdtNow = getdate()


BEGIN TRAN
	
	insert into [Account].[dbo].[TUserLoginHistory] (Session, IP, RegDate)
		select @strSession_, @strIP_, @sdtNow

    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
        BEGIN    SELECT @iOK = -1    GOTO FAIL_TRAN    END

COMMIT TRAN


GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
/*
	2009. 08. 12
	jseop
	user otp verify
*/

CREATE OR ALTER PROCEDURE [dbo].[mup_verify_user_otp]
	@iUserUID	bigint
,	@wstrOTP	nvarchar( 32 )
,	@iOK		int = 0
AS
SET NOCOUNT ON;

DECLARE @wstrOTPCurrent nvarchar( 32 )
SELECT @wstrOTPCurrent = OTP FROM dbo.MUserOTP WITH(NOLOCK) WHERE UserUID = @iUserUID
IF @wstrOTPCurrent IS NULL
    BEGIN    SELECT @iOK = -1    GOTO END_PROC    END

IF @wstrOTPCurrent <> @wstrOTP
    BEGIN    SELECT @iOK = -2    GOTO END_PROC    END

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[mup_user_Blocking]
	@strUserID	nvarchar(24)
,	@iAuthLevel	int
,	@reason		varchar(300)
,	@iOK		int	= 0

AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE	@iUserUID	bigint
SELECT	@iUserUID	= UserUID	
	FROM dbo.MUser WITH (NOLOCK)
		WHERE UserID = @strUserID
		

IF @iUserUID IS NULL	
BEGIN
	SELECT @iOK = -1	GOTO END_PROC
END

DECLARE	@howlong varchar(20), @Ucnt	int

IF @iAuthLevel < 0 or @iAuthLevel > 4
	BEGIN
		SELECT @iOK = -1	GOTO END_PROC
	END	
	
IF @iAuthLevel = 0
	SET @howlong = getdate()
ELSE IF @iAuthLevel = 1
	SET @howlong = getdate()
ELSE IF @iAuthLevel = 2
	SET @howlong = DATEADD(d,7,getdate())
ELSE IF @iAuthLevel = 3
	SET @howlong = DATEADD(d,30,getdate())
ELSE IF @iAuthLevel = 4
	SET @howlong = DATEADD(yy,30,getdate())
ELSE
	BEGIN
		SELECT @iOK = -1	GOTO END_PROC
	END
	
SELECT	@Ucnt = Count(*)
	FROM dbo.Userauthlevel WITH (NOLOCK)
		WHERE UserUID = @iUserUID
		
IF @Ucnt > 0
	BEGIN
		UPDATE dbo.UserAuthlevel
			SET AuthLevel = -Convert(int,@iAuthLevel), StartDate = getdate(), EndDate = @howlong, Reason = @reason
				WHERE UserUID = @iUserUID
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN
				SELECT @iOK = -2	GOTO END_PROC
			END
	END

ELSE
	BEGIN
		INSERT INTO dbo.UserAuthlevel (UserUID, AuthLevel, StartDate, EndDate, Reason)
			SELECT @iUserUID, -Convert(int,@iAuthLevel), getdate(), @howlong, @reason
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN
				SELECT @iOK = -3	GOTO END_PROC
			END	
	END

END_PROC:
SELECT	@iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[mup_update_UserUID_Count]
	@iUserUID	BIGINT,
	@iType		TINYINT,
	@iCount		INT,
	@iOK        [int] = 0
AS

SET NOCOUNT ON;

BEGIN TRAN
	IF NOT EXISTS( SELECT * FROM dbo.MUserUID_Count WITH (NOLOCK) WHERE UserUID = @iUserUID and [Type] = @iType )
	BEGIN
		INSERT INTO dbo.MUserUID_Count (UserUID, [Type], [Count])
			SELECT @iUserUID, @iType, @iCount
	END
	
	ELSE	
	BEGIN
		UPDATE dbo.MUserUID_Count WITH (ROWLOCK) 
		SET [count] = [count] + @iCount
		WHERE UserUID = @iUserUID AND [Type] = @iType
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
/*
	2009. 08. 12
	jseop
	user otp update
*/

CREATE OR ALTER PROCEDURE [dbo].[mup_update_user_otp]
	@iUserUID	bigint
,	@wstrOTP	nvarchar( 32 )
,	@iOK		int = 0
AS
SET NOCOUNT ON;

IF NOT EXISTS ( SELECT * FROM dbo.MUserOTP WITH(NOLOCK) WHERE UserUID = @iUserUID)
    BEGIN    SELECT @iOK = -1    GOTO END_PROC    END
 
BEGIN TRAN

    UPDATE dbo.MUserOTP WITH (ROWLOCK)
		SET OTP = @wstrOTP
			WHERE UserUID = @iUserUID
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1 --이건 한개만 입력되어야 하삼
    BEGIN    SELECT @iOK = -2   GOTO FAIL_TRAN    END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[mup_update_tool_authlevel]
	@strUserID	NVARCHAR(24)
,	@iAuthLevel	TINYINT
,	@iOK		INT	= 0

AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE	@iUserUID	BIGINT
SELECT	@iUserUID	= UserUID	
	FROM dbo.MUser WITH (NOLOCK)
		WHERE UserID = @strUserID
		

IF @iUserUID IS NULL	
BEGIN
	SELECT @iOK = -1	GOTO END_PROC
END

		
IF EXISTS (SELECT UserUID	FROM dbo.MUserAuthority WITH (NOLOCK) WHERE UserUID = @iUserUID)
	BEGIN
		UPDATE dbo.MUserAuthority
			SET AuthLevel = @iAuthLevel
				WHERE UserUID = @iUserUID
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN
				SELECT @iOK = -2	GOTO END_PROC
			END
	END

ELSE
	BEGIN
		INSERT INTO dbo.MUserAuthority (UserUID, AuthLevel)
			SELECT @iUserUID, @iAuthLevel
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN
				SELECT @iOK = -3	GOTO END_PROC
			END	
	END


END_PROC:
SELECT	@iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[mup_update_securitytype]
	@iUserUID		BIGINT
,	@iSecurityType	TINYINT
,	@iOK			INT = 0

AS
SET NOCOUNT ON;

BEGIN TRAN
	UPDATE dbo.MUser WITH (UPDLOCK)
		SET SecurityType = @iSecurityType
			WHERE UserUID = @iUserUID

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1 
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[mup_update_second_pw_authsuccess]
	@iUserUID		BIGINT,
	@sdtNow			SMALLDATETIME,
	@iOK			INT = 0
	
AS
SET NOCOUNT ON;

DECLARE @sdtLastAuthDate_Old	SMALLDATETIME

IF NOT EXISTS(SELECT * FROM dbo.MUserSecondPW WITH(NOLOCK) WHERE UserUID = @iUserUID )
    BEGIN    SELECT @iOK = -1    GOTO END_PROC    END
    
SELECT @sdtLastAuthDate_Old = LastAuthDate
	FROM dbo.MUserSecondPW WITH (NOLOCK)
		WHERE UserUID = @iUserUID

BEGIN TRAN

    UPDATE dbo.MUserSecondPW WITH (ROWLOCK)
		SET FailedCount = 0, LastAuthDate = @sdtNow
			WHERE UserUID = @iUserUID
    
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
    BEGIN    SELECT @iOK = -11   GOTO FAIL_TRAN    END
    
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK, @sdtLastAuthDate_Old
GO
CREATE OR ALTER PROCEDURE [dbo].[mup_update_second_pw_authfailed]
	@iUserUID		BIGINT,
	@iOK			INT = 0
	
AS
SET NOCOUNT ON;

DECLARE @iFailedCount	TINYINT
SELECT @iFailedCount = FailedCount
	FROM dbo.MUserSecondPW WITH (NOLOCK)
		WHERE UserUID = @iUserUID

BEGIN TRAN

	SELECT @iFailedCount = @iFailedCount + 1

    UPDATE dbo.MUserSecondPW WITH (ROWLOCK)
		SET FailedCount = @iFailedCount
			WHERE UserUID = @iUserUID
    
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
    BEGIN    SELECT @iOK = -11   GOTO FAIL_TRAN    END
    
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK, @iFailedCount
GO
CREATE OR ALTER PROCEDURE [dbo].[mup_update_second_pw]
	@iUserUID			BIGINT,
	@strSecondPW_Old	NVARCHAR(8),
	@strSecondPW_New	NVARCHAR(8),
	@iOK			INT = 0
	
AS
SET NOCOUNT ON;

DECLARE	@strSecondPW_	NVARCHAR(8)
SELECT @strSecondPW_ = SecondPW 
	FROM dbo.MUserSecondPW WITH (NOLOCK)
		WHERE UserUID = @iUserUID

IF NOT EXISTS(SELECT * FROM dbo.MUserSecondPW WITH(NOLOCK) WHERE UserUID = @iUserUID )
    BEGIN    SELECT @iOK = -1    GOTO END_PROC    END

IF (@strSecondPW_ <> @strSecondPW_Old)
	BEGIN	 SELECT @iOK = -11    GOTO END_PROC	  END


BEGIN TRAN

    UPDATE dbo.MUserSecondPW WITH (ROWLOCK)
		SET SecondPW = @strSecondPW_New, IsSecondPW = 1, FailedCount = 0
			WHERE UserUID = @iUserUID
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
    BEGIN    SELECT @iOK = -101   GOTO FAIL_TRAN    END
    
	INSERT INTO dbo.SecondPWChangeLog( UserUID, RegDate )
		VALUES( @iUserUID, GETDATE() )
    
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
    BEGIN    SELECT @iOK = -111   GOTO FAIL_TRAN    END
    
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
/*
	수정일 2007.11.08
	sutamtwo
	
	Account.Muser 의 LastLogin 값을 최신 값으로 수정한다 
	( User Login 시 )
	
	Play Day Cnt 를 구한다.

OK값:
	 0  : 정상
	-1	: 해당 UID를 가진 유저가 없음
   -10	: Update 쿼리 에러 (LastLogin)
   -11	: Update 쿼리 에러 (PlayDayCnt)

*/

CREATE OR ALTER PROCEDURE [dbo].[mup_update_login_time]
	@iUserUID_	bigint
,	@iOK_		int = 0
AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE	@sdtNow	smalldatetime
,		@sdtBefore	smalldatetime
SELECT	@sdtNow = GetDate()

SELECT @sdtBefore = LastLogin
	FROM dbo.MUser	WITH (NOLOCK)
		WHERE UserUID = @iUserUID_

BEGIN TRAN
	
	-- 해당 유저가 없다.
	IF NOT EXISTS ( SELECT * FROM dbo.MUser WITH (NOLOCK) WHERE UserUID = @iUserUID_ )
		BEGIN
			SELECT @iOK_ = -1     GOTO END_PROC   
		END	

	UPDATE dbo.MUser WITH (UPDLOCK)
		SET LastLogin = @sdtNow
			WHERE UserUID = @iUserUID_

	-- UPDATE 실패
	IF @@ERROR <> 0
		BEGIN	SELECT @iOK_ = -10	GOTO FAIL_TRAN	END


--	IF (CONVERT(nvarchar(10),@sdtNow,12) > convert(nvarchar(10),@sdtBefore,12))
	IF (DateDiff ( day, @sdtBefore, @sdtNow ) > 0)
		BEGIN
			UPDATE dbo.Muser WITH (UPDLOCK)
				SET	PlayDayCnt = PlayDayCnt + 1
					WHERE UserUID = @iUserUID_
			IF @@ERROR <> 0
				BEGIN	SELECT @iOK_ = -11	GOTO FAIL_TRAN	END

		END

		
	

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK_
GO
CREATE OR ALTER PROCEDURE [dbo].[mup_update_isrecommend]
	@UserUID	bigint	
,	@iOK		int = 0
AS
SET NOCOUNT ON;

BEGIN TRAN
	
	UPDATE dbo.MUser WITH (UPDLOCK)
		SET	IsRecommend = 1
			WHERE UserUID = @UserUID
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT	@iOK = -1	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
/*
	2008. 05. 13
	sutamtwo
	로그인/로그아웃 시 MUser 값 갱신
*/

CREATE OR ALTER PROCEDURE [dbo].[mup_update_islogin]
	@iUserUID_ [bigint]
,	@iIsLogin_	[bit]
,   @iOK [int] = 0
AS
SET NOCOUNT ON;


BEGIN TRAN
	UPDATE dbo.MUser WITH (UPDLOCK)
		SET IsLogin = @iIsLogin_
			WHERE UserUID = @iUserUID_

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1 
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[Mail_Day_Info_2]

AS
SET NOCOUNT ON;


declare @iUniq	int
,		@iAvgPT	int
,		@iAvgVsPT int


select	@iUniq = count(distinct(useruid)) from dbo.AConnectlog with (nolock) where logintime  
between convert(nvarchar(10), dateadd( day, -3, getdate()), 120)+' 00:00' and convert(nvarchar(10), dateadd( day, -3, getdate()), 120)+' 23:59' and vsplaytime between 0 and 180000 and totalplaytime between 0 and 180000 

select @iAvgPT = sum(totalplaytime)/@iUniq, @iAvgVsPT = sum(vsplaytime)/@iUniq 
	from dbo.Aconnectlog with (nolock)
		where logintime  between convert(nvarchar(10), dateadd( day, -3, getdate()), 120)+' 00:00' and convert(nvarchar(10), dateadd( day, -3, getdate()), 120)+' 23:59' and vsplaytime between 0 and 180000 and totalplaytime between 0 and 180000 
			and vsplaytime between 0 and 180000 and totalplaytime between 0 and 180000 


select topconnectcnt, topconnecttime, avgconnectcnt, newuniquser, totaluser, dayuniquser,avgDT, @iAvgPT, @iAvgVsPT, AVGArcadePT
	from dbo.CBT3rdDailyUserStats with (nolock)
		where date = convert(nvarchar(10), dateadd( day, -3, getdate()), 120)
GO
CREATE OR ALTER PROCEDURE [dbo].[Mail_Day_Info_1]

AS
SET NOCOUNT ON;


declare @iUniq	int
,		@iAvgPT	int
,		@iAvgVsPT int


select	@iUniq = count(distinct(useruid)) from dbo.AConnectlog with (nolock) where logintime  
between convert(nvarchar(10), dateadd( day, -2, getdate()), 120)+' 00:00' and convert(nvarchar(10), dateadd( day, -2, getdate()), 120)+' 23:59' and vsplaytime between 0 and 180000 and totalplaytime between 0 and 180000 

select @iAvgPT = sum(totalplaytime)/@iUniq, @iAvgVsPT = sum(vsplaytime)/@iUniq 
	from dbo.Aconnectlog with (nolock)
		where logintime  between convert(nvarchar(10), dateadd( day, -2, getdate()), 120)+' 00:00' and convert(nvarchar(10), dateadd( day, -2, getdate()), 120)+' 23:59' and vsplaytime between 0 and 180000 and totalplaytime between 0 and 180000 
			and vsplaytime between 0 and 180000 and totalplaytime between 0 and 180000 

--일간 정보
select topconnectcnt, topconnecttime, avgconnectcnt, newuniquser, totaluser, dayuniquser,avgDT, @iAvgPT, @iAvgVsPT, AVGArcadePT
	from dbo.CBT3rdDailyUserStats with (nolock)
		where date = convert(nvarchar(10), dateadd( day, -2, getdate()), 120)
GO
CREATE OR ALTER PROCEDURE [dbo].[Mail_Day_Info]

AS
SET NOCOUNT ON;


declare @iUniq	int
,		@iAvgPT	int
,		@iAvgVsPT int


select	@iUniq = count(distinct(useruid)) from dbo.AConnectlog with (nolock) where logintime  
between convert(nvarchar(10), dateadd( day, -1, getdate()), 120)+' 00:00' and convert(nvarchar(10), dateadd( day, -1, getdate()), 120)+' 23:59' and vsplaytime between 0 and 180000 and totalplaytime between 0 and 180000 

select @iAvgPT = sum(totalplaytime)/@iUniq, @iAvgVsPT = sum(vsplaytime)/@iUniq 
	from dbo.Aconnectlog with (nolock)
		where logintime  between convert(nvarchar(10), dateadd( day, -1, getdate()), 120)+' 00:00' and convert(nvarchar(10), dateadd( day, -1, getdate()), 120)+' 23:59' and vsplaytime between 0 and 180000 and totalplaytime between 0 and 180000 
			and vsplaytime between 0 and 180000 and totalplaytime between 0 and 180000 


select topconnectcnt, topconnecttime, avgconnectcnt, newuniquser, totaluser, dayuniquser,avgDT, @iAvgPT, @iAvgVsPT, AVGArcadePT
	from dbo.CBT3rdDailyUserStats with (nolock)
		where date = convert(nvarchar(10), dateadd( day, -1, getdate()), 120)
GO
CREATE OR ALTER PROCEDURE [dbo].[mup_insert_user_authkey]
	@strUserID	NVARCHAR(24),
	@iAuthKey	INT,
	@iOK		INT = 0
	

AS
SET NOCOUNT ON;

BEGIN TRAN				
				
	IF EXISTS ( SELECT * FROM dbo.MUserAuthentication WITH(NOLOCK) WHERE UserID = @strUserID)
		BEGIN
			UPDATE dbo.MUserAuthentication WITH (UPDLOCK)
			SET AuthKey = @iAuthKey
			WHERE UserID =  @strUserID
			
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1 
			BEGIN    SELECT @iOK = -1   GOTO FAIL_TRAN    END
		END
	ELSE
		BEGIN
			INSERT INTO	dbo.MUserAuthentication WITH (UPDLOCK) (UserID, AuthKey)
			SELECT @strUserID, @iAuthKey

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
CREATE OR ALTER PROCEDURE [dbo].[mup_insert_TradeBlock_user]
	@iUserUID	BIGINT,
	@ireason	TINYINT,
	@iOK		[int] = 0	

AS
SET NOCOUNT ON;			
						
BEGIN TRAN	
			
INSERT INTO dbo.TradeBlock (UserUID, RegDate, reason)
	SELECT @iUserUID, GETDATE(), @ireason
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1				
			BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END
	
UPDATE dbo.ReleaseTick
	SET [count] = [count] + 1
	WHERE [Type] = 1 -- [type] = 1 은 거래블럭 전용
	IF @@ERROR <> 0
			BEGIN	SELECT @iOK = -2	GOTO FAIL_TRAN	END
	
COMMIT TRAN						
						
GOTO END_PROC						
						
FAIL_TRAN:						
ROLLBACK TRAN						
						
END_PROC:						
SELECT @iOK
GO
/*
	2008. 11. 28
	sutamtwo
	스킬 시전 방식을 저장하는 옵션 (없어질 수도 있음)
*/

CREATE OR ALTER PROCEDURE [dbo].[mup_insert_skill_option] 
	@iUserUID	bigint
,	@bSkillOption	bit
,	@iOK		int = 0
AS
SET NOCOUNT ON;


BEGIN TRAN
	IF NOT EXISTS (SELECT * FROM dbo.MUserSkillOption WITH (NOLOCK) WHERE USERUID = @iUserUID)
		BEGIN
			INSERT INTO dbo.MUserSkillOption (UserUID, SkillOption)
				SELECT @iUserUID, @bSkillOption
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1 
				BEGIN    SELECT @iOK = -1   GOTO FAIL_TRAN    END
		END
	ELSE
		BEGIN
			UPDATE dbo.MUserSkillOption 
				SET SkillOption = @bSkillOption
					WHERE UserUID = @iUserUID
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1 
				BEGIN    SELECT @iOK = -2   GOTO FAIL_TRAN    END
		END
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK


--create table dbo.MUserSkillOption
--(
--	UserUID		bigint
--,	SkillOption	bit
--,	CONSTRAINT PKC_MUserSkillOption_UserUID PRIMARY KEY CLUSTERED (UserUID) WITH FILLFACTOR = 80
--)
GO
CREATE OR ALTER PROCEDURE [dbo].[mup_insert_Retaining_User]
	@iUserUID		BIGINT,
	@iItemID		INT,
	@sdtRegDate		SMALLDATETIME,
	@iOK			INT = 0

AS
SET NOCOUNT ON;

IF NOT EXISTS ( SELECT * FROM dbo.MUser WITH(NOLOCK) WHERE UserUID = @iUserUID)
    BEGIN    SELECT @iOK = -1    GOTO END_PROC    END 

BEGIN TRAN

			INSERT INTO dbo.RetainingUser (UserUID, ItemID, RegDate)
				SELECT @iUserUID, @iItemID, @sdtRegDate
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN	SELECT @iOK = -2	GOTO FAIL_TRAN	END
	
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[mup_insert_rejected_user]
	@iUserUID	BIGINT,
	@ireason	TINYINT,
	@iOK		[int] = 0	

AS
SET NOCOUNT ON;			
						
BEGIN TRAN	
			
INSERT INTO dbo.RejectedUser (UserUID, RegDate, reason)
	SELECT @iUserUID, GETDATE(), @ireason
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1				
			BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END
	
UPDATE dbo.ReleaseTick
	SET [count] = [count] + 1
	WHERE [Type] = 0
	IF @@ERROR <> 0
			BEGIN	SELECT @iOK = -2	GOTO FAIL_TRAN	END
	
COMMIT TRAN						
						
GOTO END_PROC						
						
FAIL_TRAN:						
ROLLBACK TRAN						
						
END_PROC:						
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[mup_insert_querystats]
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
CREATE OR ALTER PROCEDURE [dbo].[P_HackingModulelist_GET]
/*
	DLL 블랙 리스트 읽어가는 SP
	ReleaseTick 타입은 5
*/
AS
	SET NOCOUNT ON;

	SELECT DLLName, Allow
		FROM dbo.HackingModulelist WITH (NOLOCK)
GO
CREATE OR ALTER PROCEDURE [dbo].[P_MChatOption_GET]
	@UserUID	bigint
	
/*
	작성자: Hwang
	유저가 설정한 채팅옵션 정보를 퍼감
*/
AS
	SET NOCOUNT ON
	
	-- 데이터가 존재하지 않으면 -1 반환(결과값)
	IF NOT EXISTS ( SELECT USERUID FROM dbo.MChatOption WITH(NOLOCK) WHERE UserUID = @UserUID ) BEGIN
		SELECT -1 as Result, 0 as ChatOption, 0 as OnOff
	END
	ELSE BEGIN
		SELECT 0 as Result, ChatOption, OnOff
		FROM dbo.MChatOption WITH(NOLOCK)
		WHERE UserUID = @UserUID
	END
GO
CREATE OR ALTER PROCEDURE [dbo].[P_Manager_UserBlock_INS]
	@Type		TINYINT				-- 0 : 유저제재 / 1 : 거래정지
,	@UserUID	BIGINT = 0
,	@UserID		NVARCHAR(20) = ''
,	@Reason		TINYINT
,	@Result		INT = 0 OUTPUT
AS
SET NOCOUNT ON;

DECLARE @EXEC_SCRIPT	NVARCHAR(MAX)
,		@SQLUser		NVARCHAR(50)

IF @UserUID = 0
		SELECT @UserUID = UserUID FROM dbo.MUser WITH(NOLOCK) WHERE UserID = @UserID

BEGIN TRAN
	
	IF ISNULL(@UserUID, 0) <= 0
	BEGIN	
		SELECT @Result = -2    
		GOTO FAIL_TRAN
	END
		
	IF @Type = 0		-- 유저제재
	BEGIN
		INSERT INTO dbo.RejectedUser (UserUID, RegDate, reason)
		SELECT @UserUID, GETDATE(), @Reason
	END
	ELSE IF @Type = 1		-- 거래정지
	BEGIN
		INSERT INTO dbo.TradeBlock (UserUID, RegDate, reason)
		SELECT @UserUID, GETDATE(), @Reason
	END
			
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	BEGIN    
		SELECT @Result = -1    
		GOTO FAIL_TRAN    
	END
	ELSE
	BEGIN
		-- Tick 변경 (불필요시 삭제)
		UPDATE dbo.ReleaseTick SET [Count] = [Count] + 1
	END

COMMIT TRAN
GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
GO
CREATE OR ALTER PROCEDURE [dbo].[P_Manager_UserBlock_DEL]
	@Type			TINYINT
,	@UserUID		BIGINT
,	@Result			INT = 0 OUTPUT
AS
SET NOCOUNT ON;

DECLARE @EXEC_SCRIPT	NVARCHAR(MAX)
,		@SQLUser		NVARCHAR(50)

BEGIN TRAN
	
	IF @Type = 0		-- 유저제재
		DELETE FROM dbo.RejectedUser WHERE UserUID = @UserUID
	ELSE IF @Type = 1	-- 거래정지
		DELETE FROM dbo.TradeBlock WHERE UserUID = @UserUID
	
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	BEGIN    
		SELECT @Result = -1    
		GOTO FAIL_TRAN    
	END
	ELSE
	BEGIN
		-- Tick 변경 (불필요시 삭제)
		UPDATE dbo.ReleaseTick SET [Count] = [Count] + 1
	END

COMMIT TRAN
GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
GO
CREATE OR ALTER PROCEDURE [dbo].[P_Manager_TradeBlock_INS]
	@UserUID	BIGINT = 0
,	@UserID		NVARCHAR(20) = ''
,	@UnitUID	BIGINT = 0
,	@EndDate	NVARCHAR(16)
,	@Reason		TINYINT
,	@DungeonID	INT = 0
,	@Block		INT = NULL --?
,	@Comment	NVARCHAR(100) = N''
,	@Result		INT = 0 OUTPUT
AS
SET NOCOUNT ON;

DECLARE @EXEC_SCRIPT	NVARCHAR(MAX)
,		@SQLUser		NVARCHAR(50)

SET @Result = -1

BEGIN TRY

	BEGIN TRAN
	
		SET @Result = -2
			
		IF NOT EXISTS (SELECT * FROM TradeBlock WITH(NOLOCK) WHERE UserUID = @UserUID)
		BEGIN
		
			SET @Result = 0
			
			INSERT INTO TradeBlock (UserUID, RegDate, Reason)
			SELECT	@UserUID, GETDATE(), @Reason
			
		END
				
	COMMIT TRAN

END TRY
BEGIN CATCH

	DECLARE @NO_XACT_STATE		SMALLINT
	SET @NO_XACT_STATE			= XACT_STATE()		-- 트랜잭션 상태 정보

	IF @NO_XACT_STATE <> 0
		ROLLBACK TRAN

END CATCH
GO
CREATE OR ALTER PROCEDURE [dbo].[P_Manager_SecondPW_DEL]
	@UserUID	BIGINT
,	@Result		INT = 0 OUTPUT
AS
SET NOCOUNT ON;

BEGIN TRAN
	
	UPDATE MUserSecondPW
	SET IsSecondPW = 0, FailedCount = 0, DeleteDate = GETDATE()
	WHERE UserUID = @UserUID
	
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	BEGIN	SELECT @Result = -1	GOTO FAIL_TRAN	END

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
CREATE OR ALTER PROCEDURE [dbo].[P_Manager_Penalty_UPD]
	@PenaltyUID		BIGINT
,	@PenaltyType	TINYINT
,	@PenaltyTarget	NVARCHAR(255)
,	@StartDate		CHAR(16)
,	@EndDate		CHAR(16)
,	@Contents		NVARCHAR(500)
,	@Result		INT = 0 OUTPUT
AS
SET NOCOUNT ON;

DECLARE @EXEC_SCRIPT	NVARCHAR(MAX)
,		@SQLUser		NVARCHAR(50)

BEGIN TRAN
	
	UPDATE	dbo.MPenalty
	SET		PenaltyType = @PenaltyType
	,		PenaltyTarget = @PenaltyTarget
	,		StartDate = @StartDate
	,		EndDate = @EndDate
	,		Contents = @Contents
	WHERE	PenaltyUID = @PenaltyUID
	
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
CREATE OR ALTER PROCEDURE [dbo].[P_Manager_Penalty_INS]
	@PenaltyType	TINYINT
,	@PenaltyTarget	NVARCHAR(255)
,	@StartDate		CHAR(16)
,	@EndDate		CHAR(16)
,	@Contents		NVARCHAR(500)
,	@Result		INT = 0 OUTPUT
AS
SET NOCOUNT ON;

DECLARE @EXEC_SCRIPT	NVARCHAR(MAX)
,		@SQLUser		NVARCHAR(50)

BEGIN TRAN
	
	INSERT INTO MPenalty (PenaltyType, PenaltyTarget, StartDate, EndDate, Contents, RegDate)
	SELECT @PenaltyType, @PenaltyTarget, @StartDate, @EndDate, @Contents, GETDATE()
			
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
CREATE OR ALTER PROCEDURE [dbo].[P_Manager_Penalty_DEL]
	@PenaltyUID		BIGINT
,	@Result		INT = 0 OUTPUT
AS
SET NOCOUNT ON;

DECLARE @EXEC_SCRIPT	NVARCHAR(MAX)
,		@SQLUser		NVARCHAR(50)

BEGIN TRAN
	
	DELETE FROM dbo.MPenalty WHERE PenaltyUID = @PenaltyUID
	
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
/*
	2008. 06. 02
	sutamtwo
	해킹 의심 유저 정보 수집 동의 처리
*/

CREATE OR ALTER PROCEDURE [dbo].[mup_update_hackerlist]
	@iUserUID	bigint
,	@bAgree		bit
,	@iOK		int = 0
AS
SET NOCOUNT ON;

IF NOT EXISTS ( SELECT * FROM dbo.MUserHackerList WITH(NOLOCK) WHERE UserUID = @iUserUID)
    BEGIN    SELECT @iOK = -1    GOTO END_PROC    END	-- 해당 UserUID가 없어 동의할 수 없음
 
BEGIN TRAN

    UPDATE dbo.MUserHackerList WITH (ROWLOCK)
		SET IsAgree = @bAgree
			WHERE UserUID = @iUserUID
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1 --이건 한개만 입력되어야 하삼
    BEGIN    SELECT @iOK = -2   GOTO FAIL_TRAN    END

COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[mup_update_Comebackuser_finish]
	@iUserUID	BIGINT
,	@iOK				INT = 0

/*
	휴먼 유저 복귀 시스템
		: 복귀 버프 종료 update
*/
	
AS
SET NOCOUNT ON;

IF NOT EXISTS(SELECT * FROM dbo.MUserComeback WITH (NOLOCK) WHERE UserUID = @iUserUID)
    BEGIN    SELECT @iOK = -1    GOTO END_PROC    END

BEGIN TRAN
	
	UPDATE dbo.MUserComeback WITH (UPDLOCK)
		SET IsComeBackUser = 0
			WHERE UserUID = @iUserUID
			
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
CREATE OR ALTER PROCEDURE [dbo].[mup_set_user_authority]
    @strUserID_ [nvarchar](20),
	@iAuthLevel [tinyint],
    @iOK        [int] = 0
AS

SET NOCOUNT ON;

--권한 레벨이 잘못된경우
IF @iAuthLevel < 0 OR @iAuthLevel > 4
BEGIN
	SELECT @iOK = -1
	GOTO END_PROC
END

-- 해당 유저가 없는경우
IF NOT EXISTS( SELECT * FROM dbo.MUser WITH( NOLOCK ) WHERE UserID = @strUserID_ )
BEGIN
    SELECT @iOK = -2
    GOTO END_PROC
END

DECLARE @iUserUID [bigint]
--유저가 있으면 UID를 받아온다.
SELECT  @iUserUID = UserUID
    FROM dbo.MUser WITH(NOLOCK)
        WHERE UserID = @strUserID_

--권한을 새로 설정할지 수정할지 체크한다.
DECLARE @iChangeAuth [tinyint]
IF EXISTS ( SELECT * FROM dbo.MUserAuthority WITH (NOLOCK) WHERE UserUID = @iUserUID )
	BEGIN
		SELECT @iChangeAuth = 1
	END
ELSE
	SELECT @iChangeAuth = 0

BEGIN TRAN
	IF @iChangeAuth = 1
		BEGIN
			UPDATE dbo.MUserAuthority WITH( ROWLOCK )
			SET AuthLevel = @iAuthLevel
			WHERE UserUID = @iUserUID
			IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			BEGIN	SELECT @iOK = -11	GOTO FAIL_TRAN	END
		END
	ELSE
		BEGIN
			INSERT INTO   dbo.MUserAuthority(
										UserUID
			,                           AuthLevel
									   )
					SELECT  @iUserUID
			,               @iAuthLevel
				IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
				BEGIN    SELECT @iOK = -12   GOTO FAIL_TRAN    END
		END
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[mup_set_play_guide]
    @iUserUID_ [bigint],
	@bOn_ [bit],
	@iOK [int] = 0
AS
SET NOCOUNT ON;

IF NOT EXISTS( SELECT * FROM dbo.MUser WITH (NOLOCK) WHERE UserUID = @iUserUID_ )
BEGIN
    SELECT @iOK = -1
    GOTO END_PROC
END

BEGIN TRAN
    UPDATE dbo.MUser WITH(ROWLOCK)
        SET PlayGuide = @bOn_
        WHERE UserUID = @iUserUID_
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
    BEGIN
        SELECT @iOK = -11
        GOTO FAIL_TRAN
    END
COMMIT TRAN
GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
CREATE OR ALTER PROCEDURE [dbo].[mup_login_mornitor_user_old]
	@strUserID_ [nvarchar](10),
	@strPassword_ [nvarchar](20),
    @iOK [int] = 0
AS
SET NOCOUNT ON;
set xact_abort on;
DECLARE @authLevel_ [tinyint]

SELECT @authLevel_ = MTAuthLevel FROM dbo.TUser with(nolock) WHERE id = @strUserID_ AND pw = @strPassword_
IF @authLevel_ IS NOT NULL
BEGIN
    SET @iOK = 1
END

SELECT @iOK, @authLevel_
GO
CREATE OR ALTER PROCEDURE [dbo].[mup_login_mornitor_user]
	@strUserID_ [nvarchar](10),
	@strPassword_ [nvarchar](20),
    @iOK [int] = 0
AS
SET NOCOUNT ON;

DECLARE @iMTAuthLevel_ [tinyint]

BEGIN TRAN
	IF NOT EXISTS (SELECT * FROM dbo.TUser WITH (NOLOCK) WHERE ID = @strUserID_)
		BEGIN
			SELECT @iOK = -1
			GOTO END_PROC
		END

	ELSE
		BEGIN
			SELECT @iMTauthLevel_ = MTAuthLevel
				FROM dbo.TUser
					WHERE id = @strUserID_ AND pw = @strPassword_
			
			SELECT @iOK = @iMTauthLevel_

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
-- Create date: 2012.10.18
-- Description: 설문조사 했는지 여부 확인
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_FieldServey_GET]
	@UserUID		bigint

AS
	SET NOCOUNT ON
	
	DECLARE @UserUID_	BIGINT

	SELECT @UserUID_ = UserUID
	FROM dbo.FieldServey WITH(NOLOCK)
	WHERE UserUID = @UserUID
	
	IF @@ROWCOUNT > 0
		SELECT 1
	ELSE
		SELECT 0
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.03.15
-- Description:	유저 정보 읽기
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_MFriendSystem_UserInfo_GET]
	@UserUID	bigint
	
AS
	SET NOCOUNT ON;
	
	DECLARE @Result			int
	DECLARE @Category		int				-- 지역
	DECLARE @Gender			tinyint			-- 성별
	DECLARE @Birth			bigint			-- 생일
	DECLARE @UserProfile	nvarchar(20)	-- 소개
	DECLARE @UpdateDate		smalldatetime	-- 지역 변경 일자
	DECLARE @UsageCheck		tinyint			-- 유저 정보 공개 여부
	
	SELECT @Category = Category, @Gender = Gender, @Birth = Birth, @UserProfile = UserProfile, @UpdateDate = UpdateDate, @UsageCheck = UsageCheck
	FROM dbo.MFriendSystem_UserInfo WITH(NOLOCK)
	WHERE UserUID = @UserUID
	
	IF @@ROWCOUNT = 1	-- 데이터가 이미 있을 때
		SELECT  0, @UsageCheck as 'UsageCheck', @Category as 'Category', @Gender as 'Gender', @Birth as 'Birth', @UserProfile as 'serProfile', @UpdateDate as 'UpdateDate'
	ELSE				-- 데이터가 없을 때
		SELECT	0, 0 as 'UsageCheck', -1 as 'Category', 0 as 'Gender', 0 as 'Birth', N'' as 'serProfile', N'' as 'UpdateDate'
GO
-- =============================================
-- Author:		HWANG
-- Create date: 2012.12.18
-- Description:	완료된 계정 공용 퀘스트 정보
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_MQuests_Complete_GET]
	@UserUID		bigint

AS
	SET NOCOUNT ON;
	
	SELECT QuestID, CompleteDate
		FROM dbo.MQuests_Complete WITH(NOLOCK)
			WHERE UserUID = @UserUID
GO
CREATE OR ALTER PROCEDURE [dbo].[P_MPenalty_GET]
AS

SET NOCOUNT ON

SELECT 
	PenaltyUID		
,	PenaltyType		
,	PenaltyTarget	
,	StartDate
,	EndDate

FROM dbo.MPenalty WITH(NOLOCK)
WHERE EndDate >= GETDATE()
GO
-- =============================================
-- Author:		HWANG
-- Create date: 2012.12.18
-- Description:	진행중인 계정 공용 퀘스트 정보
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_MQuests_GET]
	@UserUID		bigint

AS
	SET NOCOUNT ON;
	
	SELECT QuestID, SubQuest0, SubQuest1, SubQuest2, SubQuest3, SubQuest4
		FROM dbo.MQuests WITH(NOLOCK)
			WHERE UserUID = @UserUID
GO
-- =============================================
-- Author:		HWANG
-- Create date: 2013.04.09
-- Description:	완료한 계정 일일 퀘스트 정보
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_MQuests_Repeat_GET]
	@UserUID		bigint

AS
	SET NOCOUNT ON;
	
	SELECT QuestID, MAX(CompleteDate)
		FROM dbo.MQuests_Repeat WITH(NOLOCK)
			WHERE UserUID = @UserUID
				GROUP BY QuestID
GO
/* 대만 오픈 테섭 전용 */
CREATE OR ALTER PROCEDURE [dbo].[P_MUser_CHK_TW]
	@strUserID_ [nvarchar](20),		/*@strOTP_ [nvarchar](32), -- OTP 입력 해당 SP에서 안함*/
	@strPassword_ [nvarchar](20),	
	@iOK [int] = 0,
	@iUserUID [bigint] = 0

AS
SET NOCOUNT ON;

DECLARE @Password NVARCHAR(20)

SELECT @iUserUID = UserUID, @Password = [Password] FROM dbo.Muser WITH(NOLOCK) WHERE UserID = @strUserID_ 

IF @iUserUID = 0
BEGIN
    SELECT @iOK = -1
    GOTO END_PROC
END

ELSE IF @Password <> @strPassword_		/* 대만 오픈 테섭용 Password체크 */
BEGIN
	SELECT @iOK = -7
    GOTO END_PROC
END


--{{ 유럽은 신속한 빠른 블록 처리를 위해 AuthLevel을 0으로 처리하면 로그인에 실패함
DECLARE @iAuthLevel int

SELECT @iAuthLevel = AuthLevel FROM dbo.MUserAuthority WITH (NOLOCK) WHERE UserUID = @iUserUID

IF @iAuthLevel = -4
	Begin
		SELECT @iOK = -5    GOTO END_PROC
	End
--}}

IF NOT EXISTS ( SELECT * FROM dbo.MUserOTP WITH(NOLOCK) WHERE UserUID = @iUserUID)
    BEGIN    SELECT @iOK = -2    GOTO END_PROC    END
/* -- KOG_OTP_MODIFY 해당 부분 주석 처리함. UPDATE를 여기서 처리하면 안됨
BEGIN TRAN

    UPDATE dbo.MUserOTP WITH (ROWLOCK)
		SET OTP = @strOTP_
			WHERE UserUID = @iUserUID
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1 --이건 한개만 입력되어야 하삼
    BEGIN    SELECT @iOK = -3   GOTO FAIL_TRAN    END

COMMIT TRAN
*/

GOTO END_PROC

--FAIL_TRAN:
--ROLLBACK TRAN

END_PROC:
SELECT @iOK, @iUserUID
GO
CREATE OR ALTER PROCEDURE [dbo].[P_SNMonitoring_SEL]
	@iServerSN	bigint
/*
	작성자: Hwang
	SN 모니터링
	Flag 값으로 감시 혹은 접속블럭 처리
*/
AS
	SET NOCOUNT ON

	DECLARE @iFlag		smallint

	SELECT @iFlag = Flag
	FROM dbo.SNMonitoring WITH(NOLOCK)
	WHERE ServerSN = @iServerSN

	IF @@ROWCOUNT = 0 BEGIN
		SET @iFlag = -1
	END
	
	SELECT @iFlag AS Flag
GO
CREATE OR ALTER PROCEDURE [dbo].[P_ReleaseTick_SEL]
	@iServerSetID	TINYINT = NULL
AS
SET NOCOUNT ON;

SELECT Type, COUNT
FROM dbo.ReleaseTick WITH(NOLOCK)
GO
CREATE OR ALTER PROCEDURE [dbo].[P_MUserKeyBoard_GET]
	@UserUID	bigint
	
/*
	작성자: Hwang
	유저가 설정한 키 정보를 퍼감
*/
AS
	SET NOCOUNT ON
	
	-- 데이터가 존재하지 않으면 -1 반환(결과값)
	IF NOT EXISTS ( SELECT USERUID FROM dbo.MUserKeyBoard WITH(NOLOCK) WHERE UserUID = @UserUID ) BEGIN
		SELECT -1, 0, 0
	END
	ELSE BEGIN
		SELECT 0, UserKey, Value
		FROM dbo.MUserKeyBoard WITH(NOLOCK)
		WHERE UserUID = @UserUID
	END
GO
CREATE OR ALTER PROCEDURE [dbo].[P_MUserKeyBoard_INT]
	@UserUID	bigint
,	@UserKey	smallint
,	@Value		smallint
	
/*
	작성자: Hwang
	유저가 설정한 키 정보를 삽입 및 변경
*/
AS
	SET NOCOUNT ON
	
	DECLARE @Result			int
	
	BEGIN TRY
		BEGIN TRAN

		-- 해당 유저의 특정 키 설정 기록이 없는 경우
		IF NOT EXISTS( SELECT UserUID FROM dbo.MUserKeyBoard WITH(NOLOCK) WHERE UserUID = @UserUID AND UserKey = @UserKey ) BEGIN
			SET @Result = -1
			
			INSERT INTO dbo.MUserKeyBoard ( UserUID, UserKey, Value )
			VALUES ( @UserUID, @UserKey, @Value )
		END
		ELSE BEGIN
			SET @Result = -2
			
			UPDATE dbo.MUserKeyBoard
			SET Value = @Value
			WHERE UserUID = @UserUID AND UserKey = @UserKey
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
CREATE OR ALTER PROCEDURE [dbo].[P_MUser_INS_TW]
	@strUserID_ [nvarchar](20),
	@strPassword_ [nvarchar](20),
	@strUserName_ [nvarchar](25),
	@iGuestUser_ [bit],
	@iOK [int] = 0,
	@iUserUID [bigint] = 0
AS
SET NOCOUNT ON;

IF EXISTS(SELECT * FROM dbo.Muser WITH(NOLOCK) WHERE UserID = @strUserID_ )
    BEGIN    SELECT @iOK = -1    GOTO END_PROC    END --중복되는 유저ID 있삼
 
DECLARE @sdtNow smalldatetime
SELECT @sdtNow = GetDate()

BEGIN TRAN
    INSERT INTO   dbo.MUser(
                            UserID
,                           Password
,                           UserName
,                           RegDate
,                           DelDate
,                           PlayGuide
,							Age
                           )
        SELECT  @strUserID_
,               @strPassword_
,               @strUserName_
,               @sdtNow
,               @sdtNow
,               1
,				@iGuestUser_

    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1 --이건 한개만 입력되어야 하삼
    BEGIN    SELECT @iOK = -11   GOTO FAIL_TRAN    END

    SELECT @iUserUID = @@IDENTITY
    
    
    INSERT INTO dbo.MUserOTP( UserUID, OTP ) 
    SELECT @iUserUID, @strPassword_
    IF @@ERROR <> 0 OR @@ROWCOUNT <> 1 --이건 한개만 입력되어야 하삼
    BEGIN
        SELECT @iOK = -12
        GOTO FAIL_TRAN
    END
    
    -- Event Cash
    IF NOT EXISTS (SELECT * FROM [ES_BILLING].[dbo].EB_Cash WITH(NOLOCK) WHERE CD_USERUID = @iUserUID)
    BEGIN
    
		EXEC [ES_BILLING].[dbo].EBI_Cash_Charge_SET @iUserUID, @strUserID_, 99999, 99999
		
    END

    
COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK, @iUserUID
GO
-- =============================================
-- Author:		HWANG
-- Create date: 2013.04.09
-- Description:	완료된 계정 반복 퀘스트 정보 기록, 
--				진행중인 퀘스트에서 삭제
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_MQuests_Repeat_INT]
	@UserUID		bigint
,	@UnitUID		bigint
,	@QuestID		int
,	@CompleteDate	smalldatetime

AS
	SET NOCOUNT ON

	DECLARE @Result		int

	-- 해당 계정이 완료하려고 하는 퀘스트를 보유중인지 확인
	IF NOT EXISTS ( SELECT UserUID FROM dbo.MQuests WITH(NOLOCK) WHERE UserUID = @UserUID AND QuestID = @QuestID )
		SET @Result = -1
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN

				SET @Result = -2

					DELETE dbo.MQuests
						OUTPUT DELETED.UserUID, @UnitUID, DELETED.QuestID, DELETED.RegDate, @CompleteDate
						INTO dbo.MQuests_Repeat ( UserUID, UnitUID, QuestID, RegDate, CompleteDate )
					WHERE UserUID = @UserUID AND QuestID = @QuestID

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

	SELECT @Result AS Result
GO
-- =============================================
-- Author:		HWANG
-- Create date: 2012.12.18
-- Description:	진행중인 퀘스트에서 정보 기록 및 업데이트
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_MQuests_INS_UPT]
	@UserUID		bigint
,	@QuestID		int
,	@SubQuest0		tinyint
,	@SubQuest1		tinyint
,	@SubQuest2		tinyint
,	@SubQuest3		tinyint
,	@SubQuest4		tinyint
,	@RegDate		smalldatetime

AS
	SET NOCOUNT ON

	DECLARE @Result		int

	BEGIN TRY
		BEGIN TRAN
			-- 해당 퀘스트를 수락한 기록이 없다면
			IF NOT EXISTS (SELECT UserUID FROM dbo.MQuests WITH(NOLOCK) WHERE UserUID = @UserUID AND QuestID = @QuestID)
				BEGIN
					SET @Result = -1

					INSERT INTO dbo.MQuests ( UserUID, QuestID, SubQuest0, SubQuest1, SubQuest2, SubQuest3, SubQuest4, RegDate )
					VALUES ( @UserUID, @QuestID, @SubQuest0, @SubQuest1, @SubQuest2, @SubQuest3, @SubQuest4, @RegDate )
				END
			-- 이미 수락했다면
			ELSE 
				BEGIN
					SET @Result = -2
					
					UPDATE dbo.MQuests
					SET SubQuest0 = @SubQuest0
					 ,	SubQuest1 = @SubQuest1
					 ,	SubQuest2 = @SubQuest2
					 ,	SubQuest3 = @SubQuest3
					 ,	SubQuest4 = @SubQuest4
					WHERE UserUID = @UserUID AND QuestID = @QuestID
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
			SET @Result = -3
	END CATCH

	SELECT @Result AS Result
GO
-- =============================================
-- Author:		HWANG
-- Create date: 2012.12.18
-- Description:	완료된 계정 공용 퀘스트 정보 기록, 
--				진행중인 퀘스트에서 삭제
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_MQuests_Complete_INT]
	@UserUID		bigint
,	@UnitUID		bigint
,	@QuestID		int
,	@CompleteDate	smalldatetime

AS
	SET NOCOUNT ON

	DECLARE @Result		int

	-- 해당 계정이 특정 퀘스트를 완료했는지 여부 확인
	IF EXISTS ( SELECT UserUID FROM dbo.MQuests_Complete WITH(NOLOCK) WHERE UserUID = @UserUID AND QuestID = @QuestID )
		SET @Result = -1
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN

				SET @Result = -2

					DELETE dbo.MQuests
						OUTPUT DELETED.UserUID, @UnitUID, DELETED.QuestID, DELETED.RegDate, @CompleteDate
						INTO dbo.MQuests_Complete ( UserUID, UnitUID, QuestID, RegDate, CompleteDate )
					WHERE UserUID = @UserUID AND QuestID = @QuestID

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

	SELECT @Result AS Result
GO
-- =============================================
-- Author:		Hwang
-- Create date: 2013.03.15
-- Description:	유저 정보 쓰기
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_MFriendSystem_UserInfo_INS]
	@UserUID		bigint
,	@UsageCheck		tinyint
,	@Category		int
,	@Gender			tinyint
,	@Birth			bigint
,	@UserProfile	nvarchar(20)


AS
	SET NOCOUNT ON;
	
	DECLARE @Result			int
	DECLARE @UpdateDate	smalldatetime
	
	SET @UpdateDate = GETDATE()
	
	IF NOT EXISTS ( SELECT UserUID FROM dbo.MUser WITH(NOLOCK) WHERE UserUID = @UserUID ) BEGIN
		SET @Result = -1
	END
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN
				
				IF NOT EXISTS ( SELECT UserUID FROM dbo.MFriendSystem_UserInfo WITH(NOLOCK) WHERE UserUID = @UserUID ) BEGIN

					SET @Result = -2
					-- 유저 정보가 없다면 인설트
					INSERT INTO dbo.MFriendSystem_UserInfo ( UserUID, Category, Gender, Birth, UserProfile, UpdateDate, UsageCheck )
					VALUES ( @UserUID, @Category, @Gender, @Birth, @UserProfile, @UpdateDate, @UsageCheck )
					
				END
				ELSE BEGIN

					SET @Result = -3
					-- 이미 유저 정보가 있다면 업데이트
					UPDATE dbo.MFriendSystem_UserInfo
					SET Category = @Category
					  , Gender = @Gender
					  , Birth = @Birth
					  , UserProfile = @UserProfile
					  , UpdateDate = @UpdateDate
					  ,	UsageCheck = @UsageCheck
					WHERE UserUID = @UserUID
					
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

	SELECT ISNULL(@Result, 0) AS Result, @UpdateDate AS UpdateDate
GO
CREATE OR ALTER PROCEDURE [dbo].[P_Temp_MID_SN_UPD_MID]
	@ServerSN	bigint
,	@MID		nvarchar(24)
,	@UserID		nvarchar(24)

AS
	SET NOCOUNT ON
/*
	SN은 존재하지만 MID가 매칭되지 않을 때 MID를 업데이트함
*/
	
	DECLARE	@Result		int

		BEGIN TRY
			BEGIN TRAN

			UPDATE dbo.Temp_MID_SN
			SET MID = @MID
			WHERE ServerSN = @ServerSN
			
			INSERT INTO dbo.Temp_MID_SN_History( MID, ServerSN, UserID, RegDate )
			VALUES( @MID, @ServerSN, @UserID, GETDATE() )

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
-- Author:		HWANG
-- Create date: 2012.12.18
-- Description:	교환 수량 업데이트
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_MEvent_ExchangeQuantity_UPT]
	@FromItemID		int
,	@ToItemID		int
,	@Quantity		int -- 증분값

AS
	SET NOCOUNT ON

	DECLARE @Result		int

	-- 교환으로 받을 수 있는 아이템이 있다면
	IF NOT EXISTS (SELECT 1 FROM dbo.MEvent_ExchangeQuantity WITH(NOLOCK) WHERE NowQuantity+@Quantity <= MaxQuantity and FromItemID = @FromItemID AND ToItemID = @ToItemID)
					SET @Result = -1
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN
			
				SET @Result = -2
						
				UPDATE dbo.MEvent_ExchangeQuantity
				SET NowQuantity	= NowQuantity + @Quantity
				WHERE FromItemID = @FromItemID AND ToItemID = @ToItemID
					
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
CREATE OR ALTER PROCEDURE [dbo].[P_MChatOption_INT]
	@UserUID	bigint
,	@ChatOption	tinyint
,	@OnOff		bit
	
/*
	작성자: Hwang
	유저가 설정한 채팅옵션 정보를 삽입 및 변경
*/
AS
	SET NOCOUNT ON
	
	DECLARE @Result			int
	
	BEGIN TRY
		BEGIN TRAN

		-- 유저가 설정한 채팅옵션 기록이 없는 경우
		IF NOT EXISTS( SELECT UserUID FROM dbo.MChatOption WITH(NOLOCK) WHERE UserUID = @UserUID AND ChatOption = @ChatOption ) BEGIN
			SET @Result = -1
			
			INSERT INTO dbo.MChatOption ( UserUID, ChatOption, OnOff )
			VALUES ( @UserUID, @ChatOption, @OnOff )
		END
		ELSE BEGIN
			SET @Result = -2
			
			UPDATE dbo.MChatOption
			SET OnOff = @OnOff
			WHERE UserUID = @UserUID AND ChatOption = @ChatOption
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
CREATE OR ALTER PROCEDURE [dbo].[nmk_get_UserID_UnitUID] 
    @strNick_		[nvarchar](16)
,	@iServerID_		[int]
,	@iOK			[int] = 0

AS
/* 
작성자 : sutamtwo
작성일 : 2007년 9월 7일
사용 : Nickname(CharacterID)과 서버 코드를 받아 UserID와 MessengerSN를 넘겨줌
*/


SET NOCOUNT ON;
set xact_abort on;

declare @iunitUID bigint
,		@iuserUID bigint
,		@strUserID nvarchar(20)
,		@iMessengerSN int


	IF NOT EXISTS(SELECT * FROM [Game01].[dbo].[GUnitNickName] with (NOLOCK) WHERE nickname = @strNick_)
        BEGIN    SELECT @iOK = -1    GOTO END_PROC    END

-- 서버ID를 따로 검사해 줄 코드 테이블 필요....


-- 닉네임으로 unitUID 찾기
select @iunitUID = unitUID
	from [Game01].[dbo].[GUnitNickName] with (nolock)
		where nickname = @strNick_ 
			option (maxdop 1)

select @iuserUID = userUID 
	from [Game01].[dbo].[GUnit] where unitUID = @iunitUID	

-- unitUID가 가진 userUID로 해당되는 UserID 찾음
select @strUserID = userID
	from [Account].[dbo].[MUser] with (nolock)
		where userUID = @iuserUID
			option (maxdop 1)


-- userUID와 unitUID로 SN찾기
select @iMessengerSN = sn
	from [Account].[dbo].[MessengerSN]
		where userUID = @iuserUID and UnitUID = @iunitUID


END_PROC:

select @iOK, @strUserID, @iMessengerSN
GO
CREATE OR ALTER PROCEDURE [dbo].[nmk_get_Nick_ServerCode] 
    @strUserID_			[nvarchar](20)
,	@iMessengerSN_		[int]
,	@iOK				[int] = 0
AS
/* 
작성자 : sutamtwo
작성일 : 2007년 9월 11일
사용 : UserID와 MessengerSN를 받아서 Nickname(characterID)과 서버코드를 넘겨줌

*/

SET NOCOUNT ON;
set xact_abort on;

DECLARE @strNickname nvarchar(16)
,		@iServerID tinyint
,		@iUnitUID bigint
,		@iUserUID bigint

	IF NOT EXISTS(SELECT * FROM [Account].[dbo].[MUser] with (NOLOCK) WHERE userID = @strUserID_)
        BEGIN    SELECT @iOK = -1    GOTO END_PROC    END

	IF NOT EXISTS(SELECT * FROM [Account].[dbo].[MessengerSN] with (NOLOCK) WHERE SN = @iMessengerSN_)
        BEGIN    SELECT @iOK = -2    GOTO END_PROC    END


select @iUserUID = userUID
	from [Account].[dbo].[MUser]   WITH (nolock)
		where userid = @strUserID_

select @iUnitUID = unitUID
	from [Account].[dbo].[MessengerSN]   WITH (nolock)
		where useruid = @iUserUID and SN = @iMessengerSN_
		

select @iServerID = ServerGroupID
	from [Account].[dbo].[MessengerSN]  WITH (nolock)
		where SN = @iMessengerSN_

select @strNickname = nickname
	from [Game01].[dbo].[GUnitNickName]  WITH (nolock)
		where unitUID = @iUnitUID



GOTO END_PROC


END_PROC:

select @iOK, @strNickname, @iServerID
GO
CREATE OR ALTER PROCEDURE [dbo].[mup_insert_user_play_time_all]
    @UserUID            [bigint]
,   @IP                 [nvarchar](15)
,   @LoginTime          [smalldatetime]
,   @LogoutTime         [smalldatetime]
,   @LoginFail          [bit]
,   @LogoutFail         [bit]
,	@iTotalPlayTime		[int]
,	@iVsPlayTime		[int]
,	@iDungeonPlayTime	[int]	-- 2012.11.22 업데이트
,	@iFieldPlayTime		[int]	-- 2012.11.22 업데이트
,	@iDisconnectReason	[tinyint]
,	@iDisconnectUserFSM	[tinyint]
,	@iArcadePlayTime	[int]
,	@iServerGroupID		[tinyint]
,	@strMachineID		[nvarchar](24) -- 머신ID
,	@iChannelCode		tinyint = 0
,	@bPCBangFlag		bit = 0
--,	@iOK                int = 0
AS
	SET NOCOUNT ON
	
	-- 기존 파라미터에서 변수로 변경
	DECLARE @Result			int
	
	BEGIN TRY
		BEGIN TRAN

		INSERT INTO dbo.AConnectLog( UserUID, IP, LoginTime, LogoutTime, LoginFail, LogoutFail, TotalPlayTime, VsPlayTime, DisconnectReason, DisconnectUserFSM, ArcadePlayTime, ServerGroupID, MachineID, DungeonPlayTime, FieldPlayTime, ChannelCode, PCBangFlag )
		SELECT @UserUID, @IP, @LoginTime, @LogoutTime,@LoginFail, @LogoutFail, @iTotalPlayTime, @iVsPlayTime, @iDisconnectReason, @iDisconnectUserFSM, @iArcadePlayTime, @iServerGroupID, @strMachineID, @iDungeonPlayTime, @iFieldPlayTime, @iChannelCode, @bPCBangFlag

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
-- Create date: 2012.10.18
-- Description:	계정당 한번만 10렙 넘은 유저에게 설문조사 팝업을 띄우도록 하는 기능
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[P_FieldServey_INT]
	@UserUID		bigint

AS
	SET NOCOUNT ON

	DECLARE @Result		int
	
	IF EXISTS ( SELECT UserUID FROM dbo.FieldServey WITH(NOLOCK) WHERE UserUID = @UserUID )
		SET @Result = -1
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN
			
			SET @Result = -2

			INSERT INTO	dbo.FieldServey ( UserUID, RegDate )
			VALUES ( @UserUID, GETDATE() )

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

	SELECT @Result
GO
CREATE OR ALTER PROCEDURE [dbo].[mup_insert_mid_sn]
	@strMID			NVARCHAR(24)
,	@sdtRegDate		SMALLDATETIME
/*
	2011.11.10
	MID와 ServerSN(Identity) 삽입
*/
AS
	SET NOCOUNT ON
	
	DECLARE @iServerSN	BIGINT
	,		@Result		int
	
	-- 중복되는 MID 조회
	IF EXISTS ( SELECT * FROM dbo.Temp_MID_SN WITH(NOLOCK) WHERE MID = @strMID ) BEGIN
		SET @Result = -1
	END
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN
			
			SET @Result = -2
			INSERT INTO dbo.Temp_MID_SN ( MID, IsAbnormalSN, RegDate )
			VALUES ( @strMID, 0, @sdtRegDate )
			
				SET @iServerSN = SCOPE_IDENTITY()
			
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
	SELECT @iServerSN AS ServerSN, ISNULL(@Result, 0) AS Result
GO
CREATE OR ALTER PROCEDURE [dbo].[mup_update_isabnormalsn]
	@iServerSN		BIGINT
/*
	2011.11.10
	비정상적인 ServerSN 에 해당하는 ISAbnormalSN 값 업데이트 (0:정상, 1:비정상)
*/
AS
	SET NOCOUNT ON

	DECLARE @Result		int

	IF NOT EXISTS ( SELECT * FROM dbo.Temp_MID_SN WITH(NOLOCK) WHERE ServerSN = @iServerSN )
		SELECT @Result	= -1
	ELSE BEGIN
		BEGIN TRY
			BEGIN TRAN
				UPDATE dbo.Temp_MID_SN
				SET ISAbnormalSN = 1
				WHERE ServerSN = @iServerSN
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
CREATE OR ALTER PROCEDURE [dbo].[mup_get_tool_userInfo]
	@strNick		[nvarchar](16)
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE	@iUnitUID	int
,		@iUserUID	int

SELECT	@iUnitUID = UnitUID
	FROM [Game01].[dbo].[GUnitNickName] WITH (NOLOCK)
		WHERE Nickname = @strNick

SELECT @iUserUID = UserUID
	FROM [Game01].[dbo].[GUnit] WITH (NOLOCK)
		WHERE UnitUID = @iUnitUID


SELECT UserID, UserUID 
	FROM dbo.muser WITH (NOLOCK) 
		WHERE userUID = @iUserUID
GO
CREATE OR ALTER PROCEDURE [dbo].[gup_update_tool_unit_info]
	@strNickName	nvarchar (16)
,	@iEXP			int
,	@iGamePoint		int
,	@iSPoint		int
,	@iStoneCnt		smallint
,	@iSpirit		smallint
,	@iVsPoint		int
,	@iVsPointMax	int
,	@iUnitUID		bigint
,	@strUserID		nvarchar(25)
,	@strIP			nvarchar(15)
,	@ibefore		int
,	@iafter			int
,	@iOK			INT = 0
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;


BEGIN TRAN	

	UPDATE dbo.GUnit	
		SET GamePoint	= @iGamePoint
		,	SPoint		= @iSPoint
		,	VSPoint		= @iVsPoint
		,	VSPointMax	= @iVsPointMax
	WHERE UnitUID	= @iUnitUID

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -1	GOTO FAIL_TRAN	END


	UPDATE dbo.GSpirit
		SET Spirit = @iSpirit
			WHERE UnitUID	= @iUnitUID

	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -2	GOTO FAIL_TRAN	END

	
	UPDATE dbo.GResurrectionStone
		SET Quantity = @iStoneCnt
			WHERE UnitUID	= @iUnitUID
			
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -3	GOTO FAIL_TRAN	END


	INSERT INTO dbo.Tool_Log (UserID, IP, UnitUID, NickName, GamePoint, SPoint, VsPoint, VsPointMax, Spirit, StoneCnt)
		SELECT @strUserID, @strIP, @iUnitUID, @strNickName, @iGamePoint, @iSPoint, @iVsPoint, @iVsPointMax, @iSpirit, @iStoneCnt
		
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
		BEGIN	SELECT @iOK = -4	GOTO FAIL_TRAN	END
		



COMMIT TRAN

GOTO END_PROC

FAIL_TRAN:
ROLLBACK TRAN

END_PROC:
SELECT @iOK
GO
/****** Object:  StoredProcedure [dbo].[temp_get_info] (VS 2026 / SQL 2017-2025 Manager DB) ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [dbo].[temp_get_info]
	@iServerType INT
AS
BEGIN
	SET NOCOUNT ON;
	SELECT [ServerGroupID], [DBType], [EncryptedConnStr], [ThreadCount]
	FROM [dbo].[MServerDBConnectionInfo] WITH (NOLOCK)
	WHERE [ServerType] = @iServerType;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ConfigureServerEndpoints] (Central DSN-less Endpoint Setup) ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [dbo].[sp_ConfigureServerEndpoints]
	@Server     NVARCHAR(256) = N'127.0.0.1,1433',
	@Driver     NVARCHAR(128) = N'{ODBC Driver 18 for SQL Server}',
	@UID        NVARCHAR(128) = NULL,
	@PWD        NVARCHAR(256) = NULL,
	@ExtraFlags NVARCHAR(256) = N'Encrypt=Optional;TrustServerCertificate=Yes;'
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @AuthPart NVARCHAR(512);
	IF @UID IS NULL OR LEN(LTRIM(RTRIM(@UID))) = 0
		SET @AuthPart = N'Trusted_Connection=Yes;';
	ELSE
		SET @AuthPart = N'UID=' + @UID + N';PWD=' + ISNULL(@PWD, N'') + N';';

	DECLARE @ConnAccount    NVARCHAR(1024) = N'DRIVER=' + @Driver + N';SERVER=' + @Server + N';DATABASE=Account;'    + @AuthPart + ISNULL(@ExtraFlags, N'');
	DECLARE @ConnGame01     NVARCHAR(1024) = N'DRIVER=' + @Driver + N';SERVER=' + @Server + N';DATABASE=Game01;'     + @AuthPart + ISNULL(@ExtraFlags, N'');
	DECLARE @ConnStatistics NVARCHAR(1024) = N'DRIVER=' + @Driver + N';SERVER=' + @Server + N';DATABASE=Statistics;' + @AuthPart + ISNULL(@ExtraFlags, N'');
	DECLARE @ConnBilling    NVARCHAR(1024) = N'DRIVER=' + @Driver + N';SERVER=' + @Server + N';DATABASE=ES_BILLING;' + @AuthPart + ISNULL(@ExtraFlags, N'');

	TRUNCATE TABLE [dbo].[MServerDBConnectionInfo];

	-- ESC_CENTER (1): DC_ACCOUNT(0), DC_GAME(1), DC_LOG(2)
	INSERT INTO [dbo].[MServerDBConnectionInfo] ([ServerType], [ServerGroupID], [DBType], [EncryptedConnStr], [ThreadCount]) VALUES
	(1, -1, 0, @ConnAccount,    10),
	(1, -1, 1, @ConnGame01,      5),
	(1, -1, 2, @ConnStatistics, 10);

	-- ESC_LOGIN (2): DC_ACCOUNT(0), DC_GAME(1), DC_LOG(2)
	INSERT INTO [dbo].[MServerDBConnectionInfo] ([ServerType], [ServerGroupID], [DBType], [EncryptedConnStr], [ThreadCount]) VALUES
	(2, -1, 0, @ConnAccount,    20),
	(2, -1, 1, @ConnGame01,     15),
	(2, -1, 2, @ConnStatistics,  5);

	-- ESC_GAME (3): DC_ACCOUNT(0), DC_GAME(1), DC_LOG(2), DC_KOG_BILLING(7)
	INSERT INTO [dbo].[MServerDBConnectionInfo] ([ServerType], [ServerGroupID], [DBType], [EncryptedConnStr], [ThreadCount]) VALUES
	(3, -1, 0, @ConnAccount,    10),
	(3, -1, 1, @ConnGame01,     15),
	(3, -1, 2, @ConnStatistics, 10),
	(3, -1, 7, @ConnBilling,    10);

	-- ESC_CHANNEL (4): DC_ACCOUNT(0), DC_LOG(2)
	INSERT INTO [dbo].[MServerDBConnectionInfo] ([ServerType], [ServerGroupID], [DBType], [EncryptedConnStr], [ThreadCount]) VALUES
	(4, -1, 0, @ConnAccount,    10),
	(4, -1, 2, @ConnStatistics, 10);

	-- ESC_GLOBAL (6): DC_ACCOUNT(0), DC_LOG(2)
	INSERT INTO [dbo].[MServerDBConnectionInfo] ([ServerType], [ServerGroupID], [DBType], [EncryptedConnStr], [ThreadCount]) VALUES
	(6, -1, 0, @ConnAccount,     1),
	(6, -1, 2, @ConnStatistics,  5);
END
GO
-- Seed default server endpoints if table is empty
IF NOT EXISTS (SELECT 1 FROM [dbo].[MServerDBConnectionInfo])
BEGIN
	EXEC [dbo].[sp_ConfigureServerEndpoints];
END
GO
