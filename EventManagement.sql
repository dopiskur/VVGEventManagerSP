USE [master]
GO
/****** Object:  Database [vvgEventManager]    Script Date: 17.1.2025. 17:38:14 ******/
CREATE DATABASE [vvgEventManager]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'vvgEventManager', FILENAME = N'/var/opt/mssql/data/vvgEventManager.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'vvgEventManager_log', FILENAME = N'/var/opt/mssql/data/vvgEventManager_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [vvgEventManager] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [vvgEventManager].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [vvgEventManager] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [vvgEventManager] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [vvgEventManager] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [vvgEventManager] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [vvgEventManager] SET ARITHABORT OFF 
GO
ALTER DATABASE [vvgEventManager] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [vvgEventManager] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [vvgEventManager] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [vvgEventManager] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [vvgEventManager] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [vvgEventManager] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [vvgEventManager] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [vvgEventManager] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [vvgEventManager] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [vvgEventManager] SET  DISABLE_BROKER 
GO
ALTER DATABASE [vvgEventManager] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [vvgEventManager] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [vvgEventManager] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [vvgEventManager] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [vvgEventManager] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [vvgEventManager] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [vvgEventManager] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [vvgEventManager] SET RECOVERY FULL 
GO
ALTER DATABASE [vvgEventManager] SET  MULTI_USER 
GO
ALTER DATABASE [vvgEventManager] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [vvgEventManager] SET DB_CHAINING OFF 
GO
ALTER DATABASE [vvgEventManager] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [vvgEventManager] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [vvgEventManager] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [vvgEventManager] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'vvgEventManager', N'ON'
GO
ALTER DATABASE [vvgEventManager] SET QUERY_STORE = ON
GO
ALTER DATABASE [vvgEventManager] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [vvgEventManager]
GO
/****** Object:  User [vvgadmin]    Script Date: 17.1.2025. 17:38:14 ******/
CREATE USER [vvgadmin] FOR LOGIN [vvgadmin] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [vvgadmin]
GO
/****** Object:  Table [dbo].[event]    Script Date: 17.1.2025. 17:38:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[event](
	[IDEvent] [int] IDENTITY(1,1) NOT NULL,
	[EventName] [varchar](128) NULL,
	[EventTypeID] [int] NULL,
	[Date] [date] NULL,
	[Description] [text] NULL,
	[imageId] [int] NULL,
 CONSTRAINT [PK_event] PRIMARY KEY CLUSTERED 
(
	[IDEvent] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [IX_event] UNIQUE NONCLUSTERED 
(
	[EventName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[eventPerformer]    Script Date: 17.1.2025. 17:38:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[eventPerformer](
	[IDEventPerformer] [int] IDENTITY(1,1) NOT NULL,
	[EventID] [int] NULL,
	[PerformerID] [int] NULL,
 CONSTRAINT [PK_eventPerformer] PRIMARY KEY CLUSTERED 
(
	[IDEventPerformer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[eventRegistration]    Script Date: 17.1.2025. 17:38:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[eventRegistration](
	[IDEventRegistration] [int] IDENTITY(1,1) NOT NULL,
	[EventID] [int] NULL,
	[UserID] [int] NULL,
 CONSTRAINT [PK_eventRegistration] PRIMARY KEY CLUSTERED 
(
	[IDEventRegistration] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[eventType]    Script Date: 17.1.2025. 17:38:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[eventType](
	[IDEventType] [int] IDENTITY(1,1) NOT NULL,
	[EventTypeName] [nvarchar](max) NULL,
 CONSTRAINT [PK_eventType] PRIMARY KEY CLUSTERED 
(
	[IDEventType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[image]    Script Date: 17.1.2025. 17:38:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[image](
	[idImage] [int] IDENTITY(1,1) NOT NULL,
	[ImageName] [varchar](500) NOT NULL,
	[ImageData] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_image_1] PRIMARY KEY CLUSTERED 
(
	[idImage] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[log]    Script Date: 17.1.2025. 17:38:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[log](
	[IDLog] [int] IDENTITY(1,1) NOT NULL,
	[LevelID] [int] NULL,
	[InfoMessage] [nvarchar](max) NULL,
	[Timestamp] [datetime] NULL,
 CONSTRAINT [PK_log] PRIMARY KEY CLUSTERED 
(
	[IDLog] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[logLevel]    Script Date: 17.1.2025. 17:38:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[logLevel](
	[IDLevel] [int] NOT NULL,
	[LevelName] [nvarchar](max) NULL,
 CONSTRAINT [PK_LogLevel] PRIMARY KEY CLUSTERED 
(
	[IDLevel] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[performer]    Script Date: 17.1.2025. 17:38:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[performer](
	[IDPerformer] [int] IDENTITY(1,1) NOT NULL,
	[PerformerName] [varchar](128) NULL,
	[imageId] [int] NULL,
 CONSTRAINT [PK_performer] PRIMARY KEY CLUSTERED 
(
	[IDPerformer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [IX_performer] UNIQUE NONCLUSTERED 
(
	[PerformerName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user]    Script Date: 17.1.2025. 17:38:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user](
	[IDUser] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](128) NULL,
	[PwdHash] [nvarchar](max) NULL,
	[PwdSalt] [nvarchar](max) NULL,
	[FirstName] [nvarchar](max) NULL,
	[LastName] [nvarchar](max) NULL,
	[Email] [nvarchar](max) NULL,
	[Phone] [nvarchar](max) NULL,
	[UserRoleID] [int] NULL,
 CONSTRAINT [PK_user] PRIMARY KEY CLUSTERED 
(
	[IDUser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_User_Username] UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userRole]    Script Date: 17.1.2025. 17:38:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userRole](
	[IDUserRole] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](max) NULL,
 CONSTRAINT [PK_userRole] PRIMARY KEY CLUSTERED 
(
	[IDUserRole] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[log] ADD  CONSTRAINT [DF_log_DateTime]  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[event]  WITH CHECK ADD  CONSTRAINT [FK_event_eventType] FOREIGN KEY([EventTypeID])
REFERENCES [dbo].[eventType] ([IDEventType])
GO
ALTER TABLE [dbo].[event] CHECK CONSTRAINT [FK_event_eventType]
GO
ALTER TABLE [dbo].[event]  WITH CHECK ADD  CONSTRAINT [FK_event_image] FOREIGN KEY([imageId])
REFERENCES [dbo].[image] ([idImage])
GO
ALTER TABLE [dbo].[event] CHECK CONSTRAINT [FK_event_image]
GO
ALTER TABLE [dbo].[eventPerformer]  WITH CHECK ADD  CONSTRAINT [FK_eventPerformer_event] FOREIGN KEY([EventID])
REFERENCES [dbo].[event] ([IDEvent])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[eventPerformer] CHECK CONSTRAINT [FK_eventPerformer_event]
GO
ALTER TABLE [dbo].[eventPerformer]  WITH CHECK ADD  CONSTRAINT [FK_eventPerformer_performer] FOREIGN KEY([PerformerID])
REFERENCES [dbo].[performer] ([IDPerformer])
GO
ALTER TABLE [dbo].[eventPerformer] CHECK CONSTRAINT [FK_eventPerformer_performer]
GO
ALTER TABLE [dbo].[eventRegistration]  WITH CHECK ADD  CONSTRAINT [FK_eventRegistration_event] FOREIGN KEY([EventID])
REFERENCES [dbo].[event] ([IDEvent])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[eventRegistration] CHECK CONSTRAINT [FK_eventRegistration_event]
GO
ALTER TABLE [dbo].[eventRegistration]  WITH CHECK ADD  CONSTRAINT [FK_eventRegistration_user] FOREIGN KEY([UserID])
REFERENCES [dbo].[user] ([IDUser])
GO
ALTER TABLE [dbo].[eventRegistration] CHECK CONSTRAINT [FK_eventRegistration_user]
GO
ALTER TABLE [dbo].[log]  WITH CHECK ADD  CONSTRAINT [FK_log_logLevel1] FOREIGN KEY([LevelID])
REFERENCES [dbo].[logLevel] ([IDLevel])
GO
ALTER TABLE [dbo].[log] CHECK CONSTRAINT [FK_log_logLevel1]
GO
ALTER TABLE [dbo].[user]  WITH CHECK ADD  CONSTRAINT [FK_user_userRole] FOREIGN KEY([UserRoleID])
REFERENCES [dbo].[userRole] ([IDUserRole])
GO
ALTER TABLE [dbo].[user] CHECK CONSTRAINT [FK_user_userRole]
GO
/****** Object:  StoredProcedure [dbo].[EventAdd]    Script Date: 17.1.2025. 17:38:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[EventAdd]
	@eventName varchar(max),
	@description text,
	@date datetime,
	@eventTypeID int,
	@idEvent INT OUTPUT,
	@imageName varchar(max),
	@imageData varbinary(max)
AS 
BEGIN

DECLARE @idImage int
	INSERT INTO [Image] VALUES (@imageName,@imageData)
	SET @idImage = SCOPE_IDENTITY()

INSERT INTO [event] VALUES (@eventName,@eventTypeID,@date,@description,@idImage)
	SET @idEvent = SCOPE_IDENTITY()

Declare @messageResult nvarchar(max)
set @messageResult = 'Event inserted with ID: '+CAST(@idEvent as varchar(255))

insert into [log] (levelID,InfoMessage)
	values (0,@messageResult)

END


GO
/****** Object:  StoredProcedure [dbo].[EventDelete]    Script Date: 17.1.2025. 17:38:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[EventDelete]
		@eventID INT
AS 
BEGIN
declare @imageId int
set @imageId = (select imageId from [event] where [event].IDEvent = @eventID)


delete from [event] where [event].IDEvent=@eventID
delete from image where idImage = @imageId

Declare @messageResult nvarchar(max)
set @messageResult = 'Event deleted with ID: '+CAST(@eventID as varchar(255))

insert into [log] (levelID,InfoMessage)
	values (0,@messageResult)
END
GO
/****** Object:  StoredProcedure [dbo].[EventGet]    Script Date: 17.1.2025. 17:38:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[EventGet]
	@idEvent varchar(128)
AS
SELECT * FROM [event] 
join [image] on [image].idImage = [event].imageId
join eventType on eventType.IDEventType = [event].EventTypeID
WHERE [event].IDEvent = @idEvent
GO
/****** Object:  StoredProcedure [dbo].[EventPerformerAdd]    Script Date: 17.1.2025. 17:38:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[EventPerformerAdd]
	@eventID int,
	@performerID int
AS 
BEGIN
INSERT INTO eventPerformer(eventID, performerID) VALUES (@eventID, @performerID)


DECLARE @value int
SET @value = SCOPE_IDENTITY()

Declare @messageResult nvarchar(max)
set @messageResult = 'EventPerformer inserted with ID: '+CAST(@value as varchar(255))

insert into [log] (levelID,InfoMessage)
	values (0,@messageResult)
END
GO
/****** Object:  StoredProcedure [dbo].[EventPerformerDelete]    Script Date: 17.1.2025. 17:38:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[EventPerformerDelete]
		@eventID INT,
		@performerID INT
AS 
BEGIN
DECLARE @IDEventPerformer int

SET  @IDEventPerformer = (select top 1 IDEventPerformer from eventPerformer where eventPerformer.eventID = @eventID and eventPerformer.performerID = @performerID)


delete from eventPerformer where eventPerformer.eventID = @eventID and eventPerformer.performerID = @performerID

Declare @messageResult nvarchar(max)
set @messageResult = 'EventPerformer deleted with ID: '+CAST(@IDEventPerformer as varchar(255))

insert into [log] (levelID,InfoMessage)
	values (0,@messageResult)
END
GO
/****** Object:  StoredProcedure [dbo].[EventPerformersGet]    Script Date: 17.1.2025. 17:38:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[EventPerformersGet]
	@eventID varchar(128),
	@search varchar(255) = NULL
AS
SELECT * FROM [eventPerformer] 
join performer on performer.IDPerformer = [eventPerformer].performerID
where eventPerformer.EventID = @eventID
GO
/****** Object:  StoredProcedure [dbo].[EventRegistrationAdd]    Script Date: 17.1.2025. 17:38:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[EventRegistrationAdd]
	@userID int,
	@eventID int
AS 
BEGIN
INSERT INTO eventRegistration(UserID, EventID) VALUES (@userID, @eventID)

DECLARE @value int
SET @value = SCOPE_IDENTITY()

Declare @messageResult nvarchar(max)
set @messageResult = 'EventRegistration inserted with ID: '+CAST(@value as varchar(255))

insert into [log] (levelID,InfoMessage)
	values (0,@messageResult)
END
GO
/****** Object:  StoredProcedure [dbo].[EventRegistrationDelete]    Script Date: 17.1.2025. 17:38:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[EventRegistrationDelete]
	@userID int,
	@eventID int
AS 
BEGIN
DECLARE @IDEventRegistration int

SET  @IDEventRegistration = (select top 1 IDEventRegistration from eventRegistration where eventRegistration.eventID = @eventID and eventRegistration.UserID = @userID)

delete from eventRegistration where eventRegistration.eventID = @eventID and eventRegistration.UserID = @userID

Declare @messageResult nvarchar(max)
set @messageResult = 'EventPerformer deleted with ID: '+CAST(@IDEventRegistration as varchar(255))

insert into [log] (levelID,InfoMessage)
	values (0,@messageResult)
END
GO
/****** Object:  StoredProcedure [dbo].[EventRegistrationsGet]    Script Date: 17.1.2025. 17:38:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[EventRegistrationsGet]
	@userID int,
	@search varchar(255) = NULL
AS
BEGIN
IF (@search is NULL)
	BEGIN
	SELECT * FROM eventRegistration 
	join [event] on [event].IDEvent = eventRegistration.EventID
	join [image] on [image].idImage = [event].imageId
	join eventType on eventType.IDEventType = [event].eventTypeID
	END
	ELSE 
	BEGIN
	SELECT * FROM eventRegistration 
	join [event] on [event].IDEvent = eventRegistration.EventID
	join [image] on [image].idImage = [event].imageId
	join eventType on eventType.IDEventType = [event].eventTypeID
	where eventRegistration.UserID = @userID and EventName like '%'+@search+'%'
	END
END
GO
/****** Object:  StoredProcedure [dbo].[EventsGet]    Script Date: 17.1.2025. 17:38:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[EventsGet]
	@search varchar(255) = NULL,
	@category nvarchar(max) = '%'

AS
BEGIN
IF (@search is NULL)
	BEGIN
	SELECT * FROM [event] 
		join [image] on [image].idImage = [event].imageId
		join eventType on eventType.IDEventType = [event].EventTypeID
		where EventTypeName like @category
		order by Date
	END
	ELSE
	BEGIN
		SELECT * FROM [event] 
		join [image] on [image].idImage = [event].imageId
		join eventType on eventType.IDEventType = [event].EventTypeID
		WHERE EventTypeName like @category and EventName like '%'+@search+'%'
		order by Date
	END
END

GO
/****** Object:  StoredProcedure [dbo].[EventTypesGet]    Script Date: 17.1.2025. 17:38:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROC [dbo].[EventTypesGet]
AS
SELECT * FROM eventType
GO
/****** Object:  StoredProcedure [dbo].[EventUpdate]    Script Date: 17.1.2025. 17:38:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[EventUpdate]
	@idEvent int,
	@eventName nvarchar(20),
	@eventTypeID int,
	@date datetime,
	@description text,
	@imageID int = null,
	@imageName nvarchar(max) = null,
	@imageData varbinary(max) = null
AS
BEGIN

IF @imageName IS NOT NULL
	UPDATE [image] SET
		ImageName = @imageName,
		ImageData = @imageData
	WHERE idImage = @imageID

UPDATE [event] SET 
		EventName = @eventName,
		EventTypeID = @eventTypeID,
		[Date] = @date,
		[Description] = @description
	WHERE 
		IDEvent = @idEvent


Declare @messageResult nvarchar(max)
set @messageResult = 'Event updated with ID: '+CAST(@idEvent as varchar(255))

insert into [log] (levelID,InfoMessage)
	values (0,@messageResult)
END
GO
/****** Object:  StoredProcedure [dbo].[LogAdd]    Script Date: 17.1.2025. 17:38:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create PROC [dbo].[LogAdd]
	@LevelID int,
	@InfoMessage nvarchar(max)

AS 
BEGIN
INSERT INTO [log] (
	LevelID,
	InfoMessage

)VALUES (@LevelID, @InfoMessage)

END
GO
/****** Object:  StoredProcedure [dbo].[LogsCount]    Script Date: 17.1.2025. 17:38:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create PROC [dbo].[LogsCount]
AS

SELECT count(*) FROM [Log] 
GO
/****** Object:  StoredProcedure [dbo].[LogsGet]    Script Date: 17.1.2025. 17:38:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[LogsGet]
	@search varchar(max)='%',
	@limit int = 10
AS


SELECT TOP (@limit) * FROM [Log] 
join LogLevel on LogLevel.IDLevel = [log].levelID
where InfoMessage like '%'+@search+'%'
GO
/****** Object:  StoredProcedure [dbo].[MyEventsGet]    Script Date: 17.1.2025. 17:38:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[MyEventsGet]
	@search varchar(255) = NULL

AS
BEGIN
IF (@search is NULL)
	BEGIN
	SELECT * FROM [event] 
		join [image] on [image].idImage = [event].imageId
		join eventType on eventType.IDEventType = [event].EventTypeID
		where [event].IDevent NOT IN (select distinct eventID from eventRegistration)
		order by Date
	END
	ELSE
	BEGIN
		SELECT * FROM [event]
		join [image] on [image].idImage = [event].imageId
		join eventType on eventType.IDEventType = [event].EventTypeID
		where [event].IDevent NOT IN (select distinct eventID from eventRegistration) and EventName like '%'+@search+'%'
		order by Date
	END
END

GO
/****** Object:  StoredProcedure [dbo].[PerformerAdd]    Script Date: 17.1.2025. 17:38:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[PerformerAdd]
	@performerName varchar(max)
AS 
BEGIN
INSERT INTO performer (PerformerName) VALUES (@performerName)

DECLARE @idPerformer int
SET @idPerformer = SCOPE_IDENTITY()

Declare @messageResult nvarchar(max)
set @messageResult = 'Performer inserted with ID: '+CAST(@idPerformer as varchar(255))

insert into [log] (levelID,InfoMessage)
	values (0,@messageResult)
END
GO
/****** Object:  StoredProcedure [dbo].[PerformerDelete]    Script Date: 17.1.2025. 17:38:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[PerformerDelete]
		@idPerformer INT
AS 
BEGIN
delete from eventPerformer where eventPerformer.PerformerID=@idPerformer
delete from [performer] where [performer].IDPerformer=@idPerformer


Declare @messageResult nvarchar(max)
set @messageResult = 'Performer deleted with ID: '+CAST(@idPerformer as varchar(255))

insert into [log] (levelID,InfoMessage)
	values (0,@messageResult)
END
GO
/****** Object:  StoredProcedure [dbo].[PerformerGet]    Script Date: 17.1.2025. 17:38:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create PROC [dbo].[PerformerGet]
	@idPerformer int
AS
SELECT * FROM performer 
WHERE performer.IDPerformer = @idPerformer
GO
/****** Object:  StoredProcedure [dbo].[PerformersGet]    Script Date: 17.1.2025. 17:38:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[PerformersGet]
	@search varchar(max)=NULL
AS 
BEGIN
IF (@search IS NULL)
	BEGIN
		select * from performer
		order by PerformerName
	END
	ELSE
	BEGIN
		select * from performer
		WHERE PerformerName like '%'+@search+'%'
		order by PerformerName
	END
END
GO
/****** Object:  StoredProcedure [dbo].[PerformerUpdate]    Script Date: 17.1.2025. 17:38:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[PerformerUpdate]
	@idPerformer int,
	@performerName nvarchar(20)

AS
BEGIN
UPDATE [performer] SET 
		PerformerName = @performerName

	WHERE 
		IDPerformer = @idPerformer

Declare @messageResult nvarchar(max)
set @messageResult = 'Performer updated with ID: '+CAST(@idPerformer as varchar(255))

insert into [log] (levelID,InfoMessage)
	values (0,@messageResult)
END
GO
/****** Object:  StoredProcedure [dbo].[UserAdd]    Script Date: 17.1.2025. 17:38:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[UserAdd]
	@username varchar(128),
	@pwdHash nvarchar(max),
	@pwdSalt nvarchar(max),
	@firstName nvarchar(max),
	@lastName nvarchar(max),
	@email nvarchar(max),
	@phone nvarchar(max),
	@UserRoleID int,
	@idUser INT OUTPUT
AS 
BEGIN
INSERT INTO [user] (
	Username,
	PwdHash,
	PwdSalt,
	FirstName,
	LastName,
	Email,
	Phone,
	UserRoleID


)VALUES (@username, @pwdHash, @pwdSalt, @firstName, @lastName,@email,@phone,@UserRoleID)
	SET @idUser = SCOPE_IDENTITY()

Declare @messageResult nvarchar(max)
set @messageResult = 'User inserted with ID: '+CAST(@idUser as varchar(255))

insert into [log] (levelID,InfoMessage)
	values (0,@messageResult)

END
GO
/****** Object:  StoredProcedure [dbo].[UserDelete]    Script Date: 17.1.2025. 17:38:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[UserDelete]
		@idUser INT
AS 
BEGIN
delete from [user] where [user].IDUser=@idUser


Declare @messageResult nvarchar(max)
set @messageResult = 'User deleted with ID: '+CAST(@idUser as varchar(255))

insert into [log] (levelID,InfoMessage)
	values (0,@messageResult)
END
GO
/****** Object:  StoredProcedure [dbo].[UserGet]    Script Date: 17.1.2025. 17:38:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[UserGet]
	@idUser int = NULL,
	@username varchar(128) = NULL
AS
BEGIN
if (@username IS NOT null)
	BEGIN
		SELECT * FROM [user] 
		join userRole on userRole.IDUserRole = [user].UserRoleID
		WHERE Username = @username
	END 
	ELSE
	
	BEGIN
			SELECT * FROM [user] 
		join userRole on userRole.IDUserRole = [user].UserRoleID
		WHERE IDUser = @idUser
	END
END




GO
/****** Object:  StoredProcedure [dbo].[UserRolesGet]    Script Date: 17.1.2025. 17:38:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[UserRolesGet]
AS
SELECT * FROM UserRole order by RoleName desc
GO
/****** Object:  StoredProcedure [dbo].[UsersGet]    Script Date: 17.1.2025. 17:38:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[UsersGet]
AS
SELECT * FROM [user] 
join userRole on userRole.IDUserRole = [user].UserRoleID
GO
/****** Object:  StoredProcedure [dbo].[UserUpdate]    Script Date: 17.1.2025. 17:38:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[UserUpdate]
	@idUser int,
	@username varchar(128),
	@pwdHash nvarchar(max),
	@pwdSalt nvarchar(max),
	@firstName nvarchar(max),
	@lastName nvarchar(max),
	@email nvarchar(max),
	@phone nvarchar(max),
	@UserRoleID int
AS
BEGIN
UPDATE [User] SET 
		Username = @username,
		PwdHash = @pwdHash,
		PwdSalt = @pwdSalt,
		FirstName = @firstName,
		LastName = @lastName,
		Email = @email,
		Phone = @phone,
		UserRoleID = @UserRoleID

	WHERE 
		IDUser = @idUser


Declare @messageResult nvarchar(max)
set @messageResult = 'User update with ID: '+CAST(@idUser as varchar(255))

insert into [log] (levelID,InfoMessage)
	values (0,@messageResult)
END
GO
USE [master]
GO
ALTER DATABASE [vvgEventManager] SET  READ_WRITE 
GO
