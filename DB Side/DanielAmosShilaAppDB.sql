USE [master]
GO
/****** Object:  Database [DanielAmosDB]    Script Date: 15/12/2024 11:22:02 ******/
CREATE DATABASE [DanielAmosDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DanielAmosDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\DanielAmosDB.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DanielAmosDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\DanielAmosDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [DanielAmosDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DanielAmosDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DanielAmosDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DanielAmosDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DanielAmosDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DanielAmosDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DanielAmosDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [DanielAmosDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DanielAmosDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DanielAmosDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DanielAmosDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DanielAmosDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DanielAmosDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DanielAmosDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DanielAmosDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DanielAmosDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DanielAmosDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DanielAmosDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DanielAmosDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DanielAmosDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DanielAmosDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DanielAmosDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DanielAmosDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DanielAmosDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DanielAmosDB] SET RECOVERY FULL 
GO
ALTER DATABASE [DanielAmosDB] SET  MULTI_USER 
GO
ALTER DATABASE [DanielAmosDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DanielAmosDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DanielAmosDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DanielAmosDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DanielAmosDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DanielAmosDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'DanielAmosDB', N'ON'
GO
ALTER DATABASE [DanielAmosDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [DanielAmosDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [DanielAmosDB]
GO
/****** Object:  UserDefinedFunction [dbo].[ValidateEmail]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Function [dbo].[ValidateEmail](
@email varchar(255)
)
returns BIT
AS
Begin
    if @email like '%[a-zA-Z0-9._%+-]@[a-zA-Z0-9.-]%.[a-zA-Z]{2,}%' 
        return 1;
    return 0;
End;
GO
/****** Object:  Table [dbo].[Action]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Action](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Type] [varchar](255) NOT NULL,
	[Description] [text] NOT NULL,
 CONSTRAINT [PK_Action] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [varchar](255) NOT NULL,
	[Phone] [varchar](20) NOT NULL,
	[Email] [varchar](255) NOT NULL,
	[Password] [varchar](255) NOT NULL,
	[Created] [datetime] NOT NULL,
	[GUID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[History]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[History](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NOT NULL,
	[ActionID] [int] NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[ManagerID] [int] NOT NULL,
 CONSTRAINT [PK_History] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Log]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Log](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Type] [varchar](50) NOT NULL,
	[Info] [text] NOT NULL,
	[Created] [datetime] NOT NULL,
	[RequestData] [text] NULL,
	[ExceptionData] [text] NULL,
 CONSTRAINT [PK_Log] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Manager]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Manager](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Role] [varchar](255) NOT NULL,
	[Department] [varchar](255) NOT NULL,
	[Start] [datetime] NOT NULL,
	[EmployeeID] [int] NOT NULL,
 CONSTRAINT [PK_Manager] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ManagerWithEmployee]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ManagerWithEmployee](
	[ManagerID] [int] NOT NULL,
	[EmployeeID] [int] NOT NULL,
 CONSTRAINT [PK_ManagerWithEmployee_1] PRIMARY KEY CLUSTERED 
(
	[ManagerID] ASC,
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Action] ON 

INSERT [dbo].[Action] ([ID], [Type], [Description]) VALUES (1, N' משוב והערכה', N' ו ביצוע הערכה חודשית/רבעונית/שנתית לבדיקת רמת הביצועים, השגת יעדים')
INSERT [dbo].[Action] ([ID], [Type], [Description]) VALUES (2, N'משוב והערכה', N'מתן משוב: מתן משוב בונה וחיובי כדי לשפר את ביצועי העובד ולשמור על מוטיבציה גבוהה.')
INSERT [dbo].[Action] ([ID], [Type], [Description]) VALUES (3, N'משוב והערכה', N'שיחות אישיות: קיום שיחות אישיות במטרה להבין את האתגרים שהעובד חווה ולהציע פתרונות.')
INSERT [dbo].[Action] ([ID], [Type], [Description]) VALUES (4, N' פיתוח מקצועי והדרכה', N'הדרכות והכשרות: שליחת העובד להדרכות או סדנאות לשיפור מיומנויות מקצועיות ורכות.')
INSERT [dbo].[Action] ([ID], [Type], [Description]) VALUES (5, N'פיתוח מקצועי והדרכה', N'השתלמויות: מימון השתתפות בקורסים או כנסים מקצועיים להרחבת הידע של העובד.')
INSERT [dbo].[Action] ([ID], [Type], [Description]) VALUES (6, N' פיתוח מקצועי והדרכה ', N'הצמדת מנטור: הצמדת מנטור מתוך הארגון או מחוצה לו כדי להנחות את העובד ולהעשיר את כישוריו.')
INSERT [dbo].[Action] ([ID], [Type], [Description]) VALUES (7, N'ניהול משימות ופרויקטים', N'הצבת יעדים: קביעת יעדים אישיים ומדידים בהתאם לחזון הארגון.')
INSERT [dbo].[Action] ([ID], [Type], [Description]) VALUES (8, N'ניהול משימות ופרויקטים', N'חלוקת משימות: הקצאת משימות בהתאם לכישורי העובד ולתעדוף הצוות.')
INSERT [dbo].[Action] ([ID], [Type], [Description]) VALUES (9, N'ניהול משימות ופרויקטים', N'בקרה וניטור: מעקב אחר ההתקדמות בביצוע המשימות והפרויקטים.')
INSERT [dbo].[Action] ([ID], [Type], [Description]) VALUES (10, N'מעורבות בקבלת החלטות ', N'שיתוף בתהליכים: שיתוף העובד בקבלת החלטות ובנושאים אסטרטגיים של המחלקה.')
INSERT [dbo].[Action] ([ID], [Type], [Description]) VALUES (12, N'string', N'string')
INSERT [dbo].[Action] ([ID], [Type], [Description]) VALUES (14, N'שירה', N'שירה שירה שירה')
INSERT [dbo].[Action] ([ID], [Type], [Description]) VALUES (15, N'דדדד', N'דדדד')
INSERT [dbo].[Action] ([ID], [Type], [Description]) VALUES (16, N'sssss', N'ssssss')
INSERT [dbo].[Action] ([ID], [Type], [Description]) VALUES (17, N'שירה', N'mp3')
INSERT [dbo].[Action] ([ID], [Type], [Description]) VALUES (18, N'a', N'a')
SET IDENTITY_INSERT [dbo].[Action] OFF
GO
SET IDENTITY_INSERT [dbo].[Employee] ON 

INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (2, N'Daniel Amos', N'0523565655', N'a@a.com', N'AQAAAAIAAYagAAAAEPdNIqnVCv5g/T2Jeo5HiuCnHOMA1PqfJ1hN3UfO9jI3z0genA7Q+U8f4RSo9lPG1Q==', CAST(N'2024-12-13T17:23:35.673' AS DateTime), N'0aa9466c-9436-4a31-a7c7-557dee5dabde')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (4, N'Tehila Naim', N'0507432498', N'b@b.com', N'AQAAAAIAAYagAAAAEPdNIqnVCv5g/T2Jeo5HiuCnHOMA1PqfJ1hN3UfO9jI3z0genA7Q+U8f4RSo9lPG1Q==', CAST(N'2024-12-13T17:24:07.493' AS DateTime), N'33a1abe7-2f9d-4df4-81e8-76dff70ab554')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (5, N'Itay Ch', N'0523212322', N'c@c.com', N'AQAAAAIAAYagAAAAEPdNIqnVCv5g/T2Jeo5HiuCnHOMA1PqfJ1hN3UfO9jI3z0genA7Q+U8f4RSo9lPG1Q==', CAST(N'2024-12-13T17:24:30.620' AS DateTime), N'2d649686-4a47-4e4f-8fd5-420af72a7523')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (6, N'Netan Kr', N'0543212322', N'd@d.com', N'AQAAAAIAAYagAAAAEPdNIqnVCv5g/T2Jeo5HiuCnHOMA1PqfJ1hN3UfO9jI3z0genA7Q+U8f4RSo9lPG1Q==', CAST(N'2024-12-13T17:24:52.193' AS DateTime), N'a47bfc3c-356a-4921-b562-7224789c033c')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (7, N'Ran Abram', N'0523898592', N'ranabram@clalit.org.il', N'AQAAAAIAAYagAAAAEPdNIqnVCv5g/T2Jeo5HiuCnHOMA1PqfJ1hN3UfO9jI3z0genA7Q+U8f4RSo9lPG1Q==', CAST(N'2024-12-13T17:26:14.970' AS DateTime), N'b2f01fdc-408a-4b6d-8c3e-6fa9073e9ae2')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (8, N'Clalit Smile', N'0545654344', N'clalitsmile@clalit.com', N'AQAAAAIAAYagAAAAEPdNIqnVCv5g/T2Jeo5HiuCnHOMA1PqfJ1hN3UfO9jI3z0genA7Q+U8f4RSo9lPG1Q==', CAST(N'2024-12-13T17:27:41.590' AS DateTime), N'70cb5042-85dc-4515-a8a7-472c3d59f139')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (10, N'Ido Slo', N'0523212322', N'ido@gmail.com', N'AQAAAAIAAYagAAAAEPdNIqnVCv5g/T2Jeo5HiuCnHOMA1PqfJ1hN3UfO9jI3z0genA7Q+U8f4RSo9lPG1Q==', CAST(N'2024-12-13T17:39:31.297' AS DateTime), N'd6695f08-264d-440d-9d22-2f506adbf670')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (11, N'Hugo go', N'0543232322', N'hugo24@hug.co.il', N'AQAAAAIAAYagAAAAEPdNIqnVCv5g/T2Jeo5HiuCnHOMA1PqfJ1hN3UfO9jI3z0genA7Q+U8f4RSo9lPG1Q==', CAST(N'2024-12-13T17:40:15.413' AS DateTime), N'8bc21aa1-6c83-4271-a36b-0547c17e9ff5')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (12, N'Simbe Art', N'0432343222', N'Sim@simba.com', N'AQAAAAIAAYagAAAAEPdNIqnVCv5g/T2Jeo5HiuCnHOMA1PqfJ1hN3UfO9jI3z0genA7Q+U8f4RSo9lPG1Q==', CAST(N'2024-12-13T17:40:45.903' AS DateTime), N'1fbf0d7b-1f61-41c5-9df1-d27ac57e46b2')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (16, N'Clalit Cute', N'0543232311', N'Sim@cute.com', N'AQAAAAIAAYagAAAAEPdNIqnVCv5g/T2Jeo5HiuCnHOMA1PqfJ1hN3UfO9jI3z0genA7Q+U8f4RSo9lPG1Q==', CAST(N'2024-12-13T18:25:02.260' AS DateTime), N'35c8c3ab-b512-4c5e-90ed-5c96fae150e7')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (17, N'Aden', N'0523474755', N'Aden@ad.co.il', N'AQAAAAIAAYagAAAAEPdNIqnVCv5g/T2Jeo5HiuCnHOMA1PqfJ1hN3UfO9jI3z0genA7Q+U8f4RSo9lPG1Q==', CAST(N'2024-12-13T19:23:18.850' AS DateTime), N'a3616c35-9f7b-4198-bbf2-0c2a1b99859d')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (18, N'Dvir An', N'0587898977', N'Dvir@Dvivo.com', N'AQAAAAIAAYagAAAAEPdNIqnVCv5g/T2Jeo5HiuCnHOMA1PqfJ1hN3UfO9jI3z0genA7Q+U8f4RSo9lPG1Q==', CAST(N'2024-12-13T19:24:02.757' AS DateTime), N'9d6116ea-291e-4dd5-98c0-dd33a0f6ef8e')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (19, N'Bar Bo', N'0545645655', N'Bo2024@gmail.com', N'AQAAAAIAAYagAAAAEPdNIqnVCv5g/T2Jeo5HiuCnHOMA1PqfJ1hN3UfO9jI3z0genA7Q+U8f4RSo9lPG1Q==', CAST(N'2024-12-13T19:24:33.643' AS DateTime), N'eca1f5d7-df67-41f0-b930-488c67904a1c')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (29, N'AAA', N'0543232311', N'aa@aa.aa', N'AQAAAAIAAYagAAAAEPdNIqnVCv5g/T2Jeo5HiuCnHOMA1PqfJ1hN3UfO9jI3z0genA7Q+U8f4RSo9lPG1Q==', CAST(N'2024-12-14T05:22:15.273' AS DateTime), N'f9feb78a-10c7-4d23-a8da-2bc27dca6167')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (33, N'ccc', N'0534534534', N'cc@cc.cc', N'AQAAAAIAAYagAAAAEPdNIqnVCv5g/T2Jeo5HiuCnHOMA1PqfJ1hN3UfO9jI3z0genA7Q+U8f4RSo9lPG1Q==', CAST(N'2024-12-14T05:22:56.487' AS DateTime), N'da5165e7-1b1e-4e1c-a181-03bae145ed51')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (38, N'string', N'0523565655', N'user@example.com', N'AQAAAAIAAYagAAAAEJR7mRYIJflpXwemf1jVf3r9229K/EC/EpQN8zVF+ZagXLe0WgtAcW4y4D8+ZPepTw==', CAST(N'2024-12-14T02:40:11.930' AS DateTime), N'd0a852e8-0e3f-420b-8f4d-a5702e22e297')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (39, N'string', N'0523565655', N'1user@example.com', N'AQAAAAIAAYagAAAAEGfBnULktAbnWct/vZoilXW1s7184nIOjYcW2CulLrZfBcI3vVsYQ7oQ21PM2I6ASQ==', CAST(N'2024-12-14T09:07:46.150' AS DateTime), N'e184e9b4-79d6-45a9-aeb3-c190c7dd8193')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (44, N'sss', N'0523565655', N's@1s.com', N'ss', CAST(N'2024-12-14T11:46:58.900' AS DateTime), N'609b1cef-28d1-4f92-8098-9dc7a23c4ade')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (50, N'sss', N'0523565655', N's@231s.com', N'ss', CAST(N'2024-12-14T11:54:20.160' AS DateTime), N'fc25c052-54b1-4af9-bdd6-6afbeadaeef4')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (53, N'sss', N'0523565655', N's@2331s.com', N'ss', CAST(N'2024-12-14T11:58:35.863' AS DateTime), N'7499e1ec-2522-46fc-b6a5-75e3184d9830')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (54, N'sss', N'0523565655', N's@כ2331s.com', N'ss', CAST(N'2024-12-14T11:59:09.380' AS DateTime), N'6ef8f654-a55e-47e3-8dd3-4d56837faac2')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (56, N'string', N'0523565655', N'23user@example.com', N'AQAAAAIAAYagAAAAEH98vVsJ1fXjUD7Y/b27ho6+BkLZ5W5qxvAtiOdoLYN2+F5Tfk92TD2wA4E/JZZGsQ==', CAST(N'2024-12-14T09:07:46.150' AS DateTime), N'd14da49b-cfba-4f74-9d6e-186b88624fb5')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (58, N'stringaaa', N'0523565655', N'123user@example.com', N'AQAAAAIAAYagAAAAEB+mtX9r8I/fVuOEnIN+CVpUqLW6yGBM5GTRN9BkjumySJmzTRX7JZEtcRx5ddgoFg==', CAST(N'2024-12-14T09:07:46.150' AS DateTime), N'b9d4b776-c744-4201-9068-6900808b1788')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (60, N'string', N'0523565655', N'12233user@example.com', N'AQAAAAIAAYagAAAAECAqIJz3gUqsOD+KbQU6nMPR0+IsOO1GdcEKdgWMXHbOM284xAp/hkpx0u91lWNMBQ==', CAST(N'2024-12-14T09:07:46.150' AS DateTime), N'b43dfe8c-9e80-4c47-a00c-2669efecc30b')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (61, N'aaaaa', N'0523565655', N'edardaniel20001030@gmail.com', N'AQAAAAIAAYagAAAAEHvqeVHOV+KiWxw0UVrbtQrR8GtTnS8hxf2Vw85WGMoLrI2x/tsGMidbBxmz7BPymg==', CAST(N'2024-12-14T11:55:00.000' AS DateTime), N'8edb5979-0f01-49c8-886e-427d281f6325')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (70, N'דדדדד', N'0523565655', N'edard2aniel20001030@gmail.com', N'AQAAAAIAAYagAAAAEAun7KkCCsbgNmdo6ROgt7LhaWs81I6PPvkqNrVLqBM/shGn6Qrd4Rt28sY1ItjdqA==', CAST(N'2024-12-14T13:00:00.000' AS DateTime), N'452cbd38-4c48-497b-bde2-d618e2fc084d')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (72, N'ssss', N'0523565655', N'edardaniel20001030@gmail.com1', N'AQAAAAIAAYagAAAAEAEd2lOZCIs5tTPSSf8JSP1dvA0jjnb0wtjk4BEuFSH0t1AwiO0yLC0xrkXhnbACbA==', CAST(N'2024-12-14T13:05:00.000' AS DateTime), N'28095694-ec15-4c64-8935-cbc78ac4d28d')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (74, N'ssss', N'0523565655', N'edardangiel20001030@gmail.com1', N'AQAAAAIAAYagAAAAEJzxp4s9ToXVrJ5BgezE20EJ413PKgZARxm5kR9xCrpRNnCtf8yvRfh9Kv/58lJwng==', CAST(N'2024-12-14T13:07:00.000' AS DateTime), N'c1ac518b-4ce3-421e-b26f-5cfc2a0569fb')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (75, N'גגגגג', N'0523565655', N'edardaniel20001030@gmail.com121', N'AQAAAAIAAYagAAAAELYdTjYO3+/S8EJZJ3t4lBfDqEuXHORUh0KXie5e7lnx9beoOX5GUBGO7DrqZ6YyfA==', CAST(N'2024-12-14T13:58:00.000' AS DateTime), N'67ccd448-0aa1-49ff-b79b-f875b7404971')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (78, N'aaaa', N'0523565655', N'edardaniel2lll0001030@gmail.com', N'AQAAAAIAAYagAAAAECB/+ZTBvqzty8qA3v0VMqmT5n2XcE9DGtL40isXZ7YeTVPCDxStYoxVGgc9S0nQQw==', CAST(N'2024-12-14T15:28:00.000' AS DateTime), N'b45ce200-b1b1-4009-8ac0-b940a334755c')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (79, N'ssssss', N'0523565655', N'edardaniaael20001030@gmail.com', N'AQAAAAIAAYagAAAAEJq3y9luFn6pRnDjzFmRRiih+sYNz4pp2cMB0P96lv55EGaKZNiQrPcje861No8jeA==', CAST(N'2024-12-14T16:03:00.000' AS DateTime), N'e735ee9e-656f-4cb0-b343-69b4f3448f8a')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (80, N'ssss', N'0523565655', N'a@aaaa.aaaa', N'Aasd!', CAST(N'2024-12-14T22:54:07.373' AS DateTime), N'83f0f66e-dccf-465a-ad4b-9befd281f0b4')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (81, N'dddd', N'0523543233', N'sss@sss.ss', N'aasas', CAST(N'2024-12-14T22:55:26.980' AS DateTime), N'1d98dc21-4dd6-48b1-8f6f-47a6d4c6a1bc')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (83, N'dddd', N'0523543233', N'sss@sssss.ss', N'aasas', CAST(N'2024-12-14T23:01:43.820' AS DateTime), N'c6776d9f-aa9b-49a6-97cd-ad562a96338d')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (85, N'dddd', N'0523543233', N'sss@sssssss.ss', N'aasas', CAST(N'2024-12-14T23:03:08.037' AS DateTime), N'65e97a73-3d16-4131-8262-79f86197ecb2')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (89, N'dddd', N'0523543233', N'sss@sssssssssss.ss', N'aasas', CAST(N'2024-12-14T23:08:20.030' AS DateTime), N'd16a4aa1-7c6d-4631-a2c4-75e7724e0c32')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (91, N'ddd', N'0523212322', N'a@1.a', N'ssss', CAST(N'2024-12-14T23:57:17.827' AS DateTime), N'17b15fa0-97b7-438d-a472-82fbda3ab74d')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (92, N'sssss', N'0543232322', N'edardaniel200012121030@gmail.com', N'AQAAAAIAAYagAAAAEKsF4XE5u+1IVzmBaWdApQx8+vvV615laMpqDJhEsgKRgGBuv7vZXjUbTGWWrtodrw==', CAST(N'2024-12-14T19:58:00.000' AS DateTime), N'fdd2df20-edac-4803-bad0-b42fb8b8b4f8')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (94, N'sssss', N'0543232322', N'edardaniel20001212aa1030@gmail.com', N'AQAAAAIAAYagAAAAEOZNDJo1pbUQs/FrmaPZNqDcQyrsLUAdRmrOAoEzAHMt4duResQCVFVMijYx/due0A==', CAST(N'2024-12-14T19:58:00.000' AS DateTime), N'b8e27307-1ccd-4c5a-b7e7-369bcae875bd')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (95, N'sssss', N'0543232322', N'edardaniel2000aa1212aa1030@gmail.com', N'AQAAAAIAAYagAAAAEPSytXjw8KI/GlDIhEzGffZwxLTcFzpi/J0IV0F6vM9OzKN/e9H/98u0hTTwxvOf6Q==', CAST(N'2024-12-14T19:58:00.000' AS DateTime), N'879879a5-45bf-45ee-8bab-ba345143c43b')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (96, N'sssss', N'0543232322', N'edardassniel2000aa1212aa1030@gmail.com', N'AQAAAAIAAYagAAAAELWm53kgf163+WLQz4b2JQWEjMtgA8xdViLr7WSffoqBfaOFqFDiz+sEfu+8JXmmhQ==', CAST(N'2024-12-14T19:58:00.000' AS DateTime), N'01426b27-b90f-4930-b30d-985f8e255c99')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (97, N'sssss', N'0543232322', N'edardassnissel2000aa1212aa1030@gmail.com', N'AQAAAAIAAYagAAAAEGneWhEYsEdDygLeOF2juPYqiEYf4o5EU/aT4glRAVpIt5miVbty26Dxv3+PWVjzug==', CAST(N'2024-12-14T19:58:00.000' AS DateTime), N'99f822a7-01d7-4352-96f4-6dbe7ff3d076')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (98, N'sssss', N'0543232322', N'edardassnissel2aa1212aa1030@gmail.com', N'AQAAAAIAAYagAAAAEOkNIVhzz/WrQPnbi+hYXtnhvU75vvMUHUQ8MtFYV+2wfUYsRD82PbDuoUcHvl8UHw==', CAST(N'2024-12-14T19:58:00.000' AS DateTime), N'5504bf2b-3c08-4f90-9912-ac73619e7ee3')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (99, N'aaaa', N'0521232122', N'edardaniel2a0001030@gmail.com', N'AQAAAAIAAYagAAAAEGDm7CzovPia2kmdbRbOWb/EMD3pex6sQcKTJ1lB3auau2MhesKw0PqvpyY5QYxn1w==', CAST(N'2024-12-14T20:10:00.000' AS DateTime), N'c207a8da-0229-4c1e-a9b9-81519a79ebaa')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (100, N'ssss', N'0523121233', N'edardaniel20001030@gmail.coma', N'AQAAAAIAAYagAAAAECrRy7kAAPA7EAPaohcRMX8+W24jjPskNpws5kyjUfRAuVMpWoKhq87aNROwwmD+rg==', CAST(N'2024-12-14T20:12:00.000' AS DateTime), N'6f96b5b3-03a9-4f74-b4c9-ed179b45f145')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (101, N'cccccc', N'0523432122', N'edardaniessssl20001030@gmail.com', N'AQAAAAIAAYagAAAAEAp5a7mrBUFd3XGm+U/o9v+ZHv08QUWdQSY0W14Kz7GMg9hYlcttif/fsN5hiweq7A==', CAST(N'2024-12-14T20:12:00.000' AS DateTime), N'26612933-518e-4de3-984f-7ef9e31ed338')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (102, N'ffff', N'0528757544', N'edardaniel20ssss001030@gmail.com', N'AQAAAAIAAYagAAAAELLzyhA5+VkEkYmlyureuqEPt0aA0zounHZHbaD+yumwm9Ahvq6OMVUZ0emVW6TrDQ==', CAST(N'2024-12-06T00:36:00.000' AS DateTime), N'795f8c84-d908-4845-bd65-7df12273b290')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (104, N'sss', N'0555555555', N'edardasssniel20001030@gmail.com', N'AQAAAAIAAYagAAAAEDIXtG8Hc4Hk6V1Hs8t5j/ZhHa6QMA1hceYEkIX8i6eSdsSvuuzd9dart5n5FUP7UQ==', CAST(N'2024-12-15T01:27:00.000' AS DateTime), N'ec904dfd-9b56-449d-9452-a0b25a58a0c8')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (106, N'sss', N'0555555555', N'edardasssniel200dd01030@gmail.com', N'AQAAAAIAAYagAAAAEGFgptaqLPpUMFsvc3VMdDpea2dEcSVtd28LW2zKjqrvafrPY6bL15kAQF282UeMCA==', CAST(N'2024-12-15T01:27:00.000' AS DateTime), N'05fa4eb1-1c72-47d6-8d8b-fe7ce7689b73')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (107, N'sss', N'0523212322', N'a@A.ccc', N'aaaa', CAST(N'2024-12-15T05:33:01.230' AS DateTime), N'4a030661-6cfc-42ef-a2f1-38285edcaf1b')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (109, N'sss', N'0523212322', N'a@ASW.ccc', N'aaaa', CAST(N'2024-12-15T05:36:48.143' AS DateTime), N'6d4433cb-1c14-434e-bab3-1c91187f9f2e')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (112, N'ssssss', N'0555555555', N'edardaniel20005551030@gmail.com', N'AQAAAAIAAYagAAAAELem46RHgTvTq/NGy2E6boy8hZVbjB9w7UoP2tMCcJuRSU980zW7kb7gSX/chmfbnA==', CAST(N'2024-12-15T01:41:00.000' AS DateTime), N'cf00e2b1-9a43-4026-abd9-8f562fea58ff')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (113, N'ssssss', N'0555555555', N'edassssrdaniel20005551030@gmail.com', N'AQAAAAIAAYagAAAAEEfup4whv1axoe4xUo0kwMUN6txRJmkirWwBYiORl5NxtIDaLA4tHReYSklwT/vF0Q==', CAST(N'2024-12-15T01:41:00.000' AS DateTime), N'179f6422-82bc-4daa-a585-219ce4128887')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (114, N'ssssss', N'0555555555', N'edasssssssssssssrdaniel20005551030@gmail.com', N'AQAAAAIAAYagAAAAEOPfp6tj64f/OxrKeQUXKXytnKsWWtI4o0zk2cOgZ0KS3B6rUY89trZMcKSdjMz7+w==', CAST(N'2024-12-15T01:41:00.000' AS DateTime), N'8ae64499-1821-45b3-8b2a-dedb9c93ff55')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (115, N'sssssss', N'0555555555', N'edardaniel200dddd01030@gmail.com', N'AQAAAAIAAYagAAAAENwO5JlnnKgN6atDEu5sn4QQEjguVpiGDjcNL4Q4aVQK2tiDrEWCQwByS0bj4XLLJA==', CAST(N'2024-12-15T05:48:00.000' AS DateTime), N'66a25d9f-7651-4727-9beb-e7c8ba4ab76b')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (116, N'ssss', N'0523232322', N'a@ww.a', N'AQAAAAIAAYagAAAAENG0Q0arulC8ero/f7e0hO4sKm2ty/2EfKQHLRy1gvYhvkuWFTsJLwSR3SPFqc81zA==', CAST(N'2024-12-15T05:51:00.000' AS DateTime), N'af9d4416-420e-4ede-ba14-7a8774ca9fd3')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (117, N'ddd', N'0565656565', N'a@aaaaa.a', N'aaa', CAST(N'2024-12-15T10:00:15.700' AS DateTime), N'a02c7d5d-8ca1-45e7-9425-4b3208c1a133')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (118, N'sss', N'0555555555', N'aa@aa.aaa', N'AQAAAAIAAYagAAAAEAIZWMbZJ5dlecFz5+0R4JUC3yqO4ci1UukRNzfofHyw/qie2lnLen4+rOiw+TbgIQ==', CAST(N'2024-12-15T05:59:00.000' AS DateTime), N'2d1d78b8-3117-4871-bcb1-4ee6ab2c98c5')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (119, N'aaaaaaaaaaaa', N'0555555555', N'aaaa@aaa.aaaaaa', N'AQAAAAIAAYagAAAAENSxyop4ed76CmGXxkQIDpRKYej2GaCHpnlbImsKOx/B6NO3pjnsgjyblo5HmtTaaw==', CAST(N'2024-12-15T06:28:00.000' AS DateTime), N'155c93db-8405-4eb3-a049-c14cba49942a')
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (120, N'dddddd', N'0555555555', N'wwww@www.w', N'AQAAAAIAAYagAAAAEM8c4Gs4ZrNOl/qwx54TwvMBugW+5ebJG1VvBbuSiKUmP9KmwSYERvzTbOzAEBSwBQ==', CAST(N'2024-12-15T06:47:00.000' AS DateTime), N'36a5e391-773a-4e99-9c88-f18651b8e067')
SET IDENTITY_INSERT [dbo].[Employee] OFF
GO
SET IDENTITY_INSERT [dbo].[History] ON 

INSERT [dbo].[History] ([ID], [Date], [ActionID], [EmployeeID], [ManagerID]) VALUES (4, CAST(N'2024-12-13T18:50:39.933' AS DateTime), 1, 2, 1)
INSERT [dbo].[History] ([ID], [Date], [ActionID], [EmployeeID], [ManagerID]) VALUES (5, CAST(N'2024-12-13T18:51:00.157' AS DateTime), 1, 4, 1)
INSERT [dbo].[History] ([ID], [Date], [ActionID], [EmployeeID], [ManagerID]) VALUES (6, CAST(N'2024-12-13T18:51:15.730' AS DateTime), 1, 5, 1)
INSERT [dbo].[History] ([ID], [Date], [ActionID], [EmployeeID], [ManagerID]) VALUES (7, CAST(N'2024-12-13T18:51:19.790' AS DateTime), 1, 6, 1)
INSERT [dbo].[History] ([ID], [Date], [ActionID], [EmployeeID], [ManagerID]) VALUES (8, CAST(N'2024-12-13T18:51:24.000' AS DateTime), 1, 7, 1)
INSERT [dbo].[History] ([ID], [Date], [ActionID], [EmployeeID], [ManagerID]) VALUES (9, CAST(N'2024-12-13T18:51:27.670' AS DateTime), 1, 8, 1)
INSERT [dbo].[History] ([ID], [Date], [ActionID], [EmployeeID], [ManagerID]) VALUES (10, CAST(N'2024-12-13T18:51:40.880' AS DateTime), 1, 10, 1)
INSERT [dbo].[History] ([ID], [Date], [ActionID], [EmployeeID], [ManagerID]) VALUES (11, CAST(N'2024-12-13T18:51:43.913' AS DateTime), 1, 11, 1)
INSERT [dbo].[History] ([ID], [Date], [ActionID], [EmployeeID], [ManagerID]) VALUES (12, CAST(N'2024-12-13T18:51:46.657' AS DateTime), 1, 12, 1)
INSERT [dbo].[History] ([ID], [Date], [ActionID], [EmployeeID], [ManagerID]) VALUES (14, CAST(N'2024-12-13T18:52:06.377' AS DateTime), 1, 16, 1)
INSERT [dbo].[History] ([ID], [Date], [ActionID], [EmployeeID], [ManagerID]) VALUES (15, CAST(N'2024-12-13T18:52:29.090' AS DateTime), 2, 2, 2)
INSERT [dbo].[History] ([ID], [Date], [ActionID], [EmployeeID], [ManagerID]) VALUES (16, CAST(N'2024-12-13T18:52:34.940' AS DateTime), 2, 4, 2)
INSERT [dbo].[History] ([ID], [Date], [ActionID], [EmployeeID], [ManagerID]) VALUES (18, CAST(N'2024-12-13T18:52:44.407' AS DateTime), 2, 10, 2)
INSERT [dbo].[History] ([ID], [Date], [ActionID], [EmployeeID], [ManagerID]) VALUES (19, CAST(N'2024-12-13T18:52:49.263' AS DateTime), 3, 4, 3)
INSERT [dbo].[History] ([ID], [Date], [ActionID], [EmployeeID], [ManagerID]) VALUES (20, CAST(N'2024-12-13T18:52:56.010' AS DateTime), 4, 2, 3)
INSERT [dbo].[History] ([ID], [Date], [ActionID], [EmployeeID], [ManagerID]) VALUES (21, CAST(N'2024-12-13T18:53:10.380' AS DateTime), 6, 2, 1)
INSERT [dbo].[History] ([ID], [Date], [ActionID], [EmployeeID], [ManagerID]) VALUES (22, CAST(N'2024-12-13T18:53:22.800' AS DateTime), 6, 4, 2)
INSERT [dbo].[History] ([ID], [Date], [ActionID], [EmployeeID], [ManagerID]) VALUES (24, CAST(N'2024-12-14T13:16:02.630' AS DateTime), 3, 2, 16)
INSERT [dbo].[History] ([ID], [Date], [ActionID], [EmployeeID], [ManagerID]) VALUES (25, CAST(N'2024-12-14T13:16:08.713' AS DateTime), 3, 2, 16)
INSERT [dbo].[History] ([ID], [Date], [ActionID], [EmployeeID], [ManagerID]) VALUES (26, CAST(N'2024-12-14T13:19:48.240' AS DateTime), 3, 2, 16)
INSERT [dbo].[History] ([ID], [Date], [ActionID], [EmployeeID], [ManagerID]) VALUES (27, CAST(N'2024-12-15T00:39:10.013' AS DateTime), 3, 101, 1)
INSERT [dbo].[History] ([ID], [Date], [ActionID], [EmployeeID], [ManagerID]) VALUES (29, CAST(N'2024-12-15T00:39:35.420' AS DateTime), 2, 101, 16)
INSERT [dbo].[History] ([ID], [Date], [ActionID], [EmployeeID], [ManagerID]) VALUES (30, CAST(N'2024-12-15T00:39:50.723' AS DateTime), 2, 101, 2)
INSERT [dbo].[History] ([ID], [Date], [ActionID], [EmployeeID], [ManagerID]) VALUES (31, CAST(N'2024-12-15T03:31:59.477' AS DateTime), 6, 10, 2)
INSERT [dbo].[History] ([ID], [Date], [ActionID], [EmployeeID], [ManagerID]) VALUES (34, CAST(N'2024-12-15T00:01:00.000' AS DateTime), 1, 16, 27)
INSERT [dbo].[History] ([ID], [Date], [ActionID], [EmployeeID], [ManagerID]) VALUES (35, CAST(N'2024-12-15T00:01:00.000' AS DateTime), 1, 16, 27)
INSERT [dbo].[History] ([ID], [Date], [ActionID], [EmployeeID], [ManagerID]) VALUES (36, CAST(N'2024-12-15T00:01:00.000' AS DateTime), 1, 16, 27)
INSERT [dbo].[History] ([ID], [Date], [ActionID], [EmployeeID], [ManagerID]) VALUES (37, CAST(N'2024-12-17T07:51:00.000' AS DateTime), 4, 16, 29)
INSERT [dbo].[History] ([ID], [Date], [ActionID], [EmployeeID], [ManagerID]) VALUES (38, CAST(N'2024-12-15T09:59:29.817' AS DateTime), 3, 115, 16)
INSERT [dbo].[History] ([ID], [Date], [ActionID], [EmployeeID], [ManagerID]) VALUES (39, CAST(N'2024-12-17T09:06:00.000' AS DateTime), 3, 89, 31)
SET IDENTITY_INSERT [dbo].[History] OFF
GO
SET IDENTITY_INSERT [dbo].[Log] ON 

INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (1, N'Info', N'נפתחה בקשה להוספת עובד חדש', CAST(N'2024-12-13T18:34:10.990' AS DateTime), N'
  "Request": {
    "employeeName": "Navi",
	}', NULL)
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (2, N'info', N'נפתחה בקשה להוספת מנהל חדש', CAST(N'2024-12-13T18:35:00.477' AS DateTime), NULL, NULL)
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (3, N'error', N'שגיאת בשירות להוספת עובד חדש', CAST(N'2024-12-13T18:36:45.170' AS DateTime), NULL, N'
  "error": {
    "message": "Invalid credentials provided",
    "code": 401,
    "stackTrace": "Error: Invalid credentials\n    at AuthService.login (authService.js:45)\n    at processRequest (handler.js:22)\n    at asyncMiddleware (middleware.js:18)"
  }')
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (4, N'error', N'שגיאת בשירות להוספת מנהל חדש
', CAST(N'2024-12-13T18:37:35.523' AS DateTime), NULL, N'
  "error": {
    "message": "Invalid credentials server",
    "code": 404
  }
  ')
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (5, N'error', N'שגיאת בשירות לחיפוש עובד
', CAST(N'2024-12-13T18:38:32.650' AS DateTime), NULL, N'
  "error": {
    "message": "Invalid credentials find",
    "code": 420
  }')
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (6, N'error', N'שגיאת בשירות לחיפוש מנהל ', CAST(N'2024-12-13T18:40:09.420' AS DateTime), NULL, N'
  "error": {
    "message": "Invalid url server",
    "code": 500
  }')
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (7, N'error', N'שגיאת בשירות לעריכת מנהל ', CAST(N'2024-12-13T18:41:35.400' AS DateTime), NULL, N'
  "error": {
    "message": "Invalid credentials provided",
    "code": 413,
    "stackTrace": "Error: Invalid credentials\n    at MyAuthService.login (authService.js:45)\n    at processRequest (handler.js:22)\n    at asyncMiddleware (middleware.js:18)"
  }')
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (8, N'info', N'נפתחה בקשה לעריכת עובד', CAST(N'2024-12-13T18:43:31.457' AS DateTime), N'
  "Request":{
  
  "message": "Editor open",
  "ManagerID":1312
  
  }', NULL)
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (9, N'error', N'שגיאת בשירות לעריכת עובד ', CAST(N'2024-12-13T18:44:29.543' AS DateTime), NULL, NULL)
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (10, N'info', N'נפתחה בקשה לתוספת שכר למנהל', CAST(N'2024-12-13T18:45:29.560' AS DateTime), N'
  "Request":{
  
  "message": "Add Query open",
  "ManagerID":1312
  
  }', NULL)
SET IDENTITY_INSERT [dbo].[Log] OFF
GO
SET IDENTITY_INSERT [dbo].[Manager] ON 

INSERT [dbo].[Manager] ([ID], [Role], [Department], [Start], [EmployeeID]) VALUES (1, N'CTO', N'מרכז שירות לקוחות רפואי', CAST(N'2024-12-13T17:36:29.180' AS DateTime), 7)
INSERT [dbo].[Manager] ([ID], [Role], [Department], [Start], [EmployeeID]) VALUES (2, N'Team Leader', N'מחלקת תיקים רפואיים דיגיטליים', CAST(N'2024-12-13T17:37:28.570' AS DateTime), 16)
INSERT [dbo].[Manager] ([ID], [Role], [Department], [Start], [EmployeeID]) VALUES (3, N'Project', N'מרכז מערכות מידע רפואיות', CAST(N'2024-12-13T17:38:09.823' AS DateTime), 11)
INSERT [dbo].[Manager] ([ID], [Role], [Department], [Start], [EmployeeID]) VALUES (5, N'CEO', N'מדיקל טאץ''', CAST(N'2024-12-13T19:03:08.637' AS DateTime), 8)
INSERT [dbo].[Manager] ([ID], [Role], [Department], [Start], [EmployeeID]) VALUES (13, N'HR', N'd', CAST(N'2024-12-14T12:02:18.280' AS DateTime), 2)
INSERT [dbo].[Manager] ([ID], [Role], [Department], [Start], [EmployeeID]) VALUES (14, N'HR', N'string', CAST(N'2024-12-14T09:07:46.150' AS DateTime), 56)
INSERT [dbo].[Manager] ([ID], [Role], [Department], [Start], [EmployeeID]) VALUES (15, N'HR', N'string', CAST(N'2024-12-14T09:07:46.150' AS DateTime), 58)
INSERT [dbo].[Manager] ([ID], [Role], [Department], [Start], [EmployeeID]) VALUES (16, N'HR', N'string', CAST(N'2024-12-14T09:07:46.150' AS DateTime), 60)
INSERT [dbo].[Manager] ([ID], [Role], [Department], [Start], [EmployeeID]) VALUES (17, N'Quality', N'ddsds', CAST(N'2024-12-14T11:55:00.000' AS DateTime), 61)
INSERT [dbo].[Manager] ([ID], [Role], [Department], [Start], [EmployeeID]) VALUES (18, N'CEO', N'גגגג', CAST(N'2024-12-14T13:00:00.000' AS DateTime), 70)
INSERT [dbo].[Manager] ([ID], [Role], [Department], [Start], [EmployeeID]) VALUES (19, N'Quality', N'sss', CAST(N'2024-12-14T13:05:00.000' AS DateTime), 72)
INSERT [dbo].[Manager] ([ID], [Role], [Department], [Start], [EmployeeID]) VALUES (20, N'Quality', N'sss', CAST(N'2024-12-14T13:07:00.000' AS DateTime), 74)
INSERT [dbo].[Manager] ([ID], [Role], [Department], [Start], [EmployeeID]) VALUES (21, N'CEO', N'2222', CAST(N'2024-12-14T13:58:00.000' AS DateTime), 75)
INSERT [dbo].[Manager] ([ID], [Role], [Department], [Start], [EmployeeID]) VALUES (22, N'Sales', N'sss', CAST(N'2024-12-14T15:28:00.000' AS DateTime), 78)
INSERT [dbo].[Manager] ([ID], [Role], [Department], [Start], [EmployeeID]) VALUES (23, N'CISO', N'sssss', CAST(N'2024-12-14T16:03:00.000' AS DateTime), 79)
INSERT [dbo].[Manager] ([ID], [Role], [Department], [Start], [EmployeeID]) VALUES (24, N'Quality', N'dddd', CAST(N'2024-12-14T19:58:00.000' AS DateTime), 98)
INSERT [dbo].[Manager] ([ID], [Role], [Department], [Start], [EmployeeID]) VALUES (25, N'Quality', N'dsdsd', CAST(N'2024-12-14T20:10:00.000' AS DateTime), 99)
INSERT [dbo].[Manager] ([ID], [Role], [Department], [Start], [EmployeeID]) VALUES (26, N'CEO', N'sss', CAST(N'2024-12-14T20:12:00.000' AS DateTime), 100)
INSERT [dbo].[Manager] ([ID], [Role], [Department], [Start], [EmployeeID]) VALUES (27, N'Sales', N'ddd', CAST(N'2024-12-14T20:12:00.000' AS DateTime), 101)
INSERT [dbo].[Manager] ([ID], [Role], [Department], [Start], [EmployeeID]) VALUES (28, N'Quality', N'ssss', CAST(N'2024-12-06T00:36:00.000' AS DateTime), 102)
INSERT [dbo].[Manager] ([ID], [Role], [Department], [Start], [EmployeeID]) VALUES (29, N'CEO', N'44', CAST(N'2024-12-15T05:48:00.000' AS DateTime), 115)
INSERT [dbo].[Manager] ([ID], [Role], [Department], [Start], [EmployeeID]) VALUES (30, N'Customer Service', N'sdsdsdsd', CAST(N'2024-12-15T06:28:00.000' AS DateTime), 119)
INSERT [dbo].[Manager] ([ID], [Role], [Department], [Start], [EmployeeID]) VALUES (31, N'Quality', N'545555', CAST(N'2024-12-15T06:47:00.000' AS DateTime), 120)
SET IDENTITY_INSERT [dbo].[Manager] OFF
GO
INSERT [dbo].[ManagerWithEmployee] ([ManagerID], [EmployeeID]) VALUES (1, 11)
INSERT [dbo].[ManagerWithEmployee] ([ManagerID], [EmployeeID]) VALUES (1, 17)
INSERT [dbo].[ManagerWithEmployee] ([ManagerID], [EmployeeID]) VALUES (1, 18)
INSERT [dbo].[ManagerWithEmployee] ([ManagerID], [EmployeeID]) VALUES (1, 85)
INSERT [dbo].[ManagerWithEmployee] ([ManagerID], [EmployeeID]) VALUES (1, 89)
INSERT [dbo].[ManagerWithEmployee] ([ManagerID], [EmployeeID]) VALUES (2, 10)
INSERT [dbo].[ManagerWithEmployee] ([ManagerID], [EmployeeID]) VALUES (2, 12)
INSERT [dbo].[ManagerWithEmployee] ([ManagerID], [EmployeeID]) VALUES (2, 17)
INSERT [dbo].[ManagerWithEmployee] ([ManagerID], [EmployeeID]) VALUES (2, 19)
INSERT [dbo].[ManagerWithEmployee] ([ManagerID], [EmployeeID]) VALUES (2, 81)
INSERT [dbo].[ManagerWithEmployee] ([ManagerID], [EmployeeID]) VALUES (3, 2)
INSERT [dbo].[ManagerWithEmployee] ([ManagerID], [EmployeeID]) VALUES (3, 4)
INSERT [dbo].[ManagerWithEmployee] ([ManagerID], [EmployeeID]) VALUES (3, 5)
INSERT [dbo].[ManagerWithEmployee] ([ManagerID], [EmployeeID]) VALUES (3, 6)
INSERT [dbo].[ManagerWithEmployee] ([ManagerID], [EmployeeID]) VALUES (3, 118)
INSERT [dbo].[ManagerWithEmployee] ([ManagerID], [EmployeeID]) VALUES (5, 11)
INSERT [dbo].[ManagerWithEmployee] ([ManagerID], [EmployeeID]) VALUES (5, 16)
INSERT [dbo].[ManagerWithEmployee] ([ManagerID], [EmployeeID]) VALUES (13, 83)
INSERT [dbo].[ManagerWithEmployee] ([ManagerID], [EmployeeID]) VALUES (13, 91)
INSERT [dbo].[ManagerWithEmployee] ([ManagerID], [EmployeeID]) VALUES (15, 112)
INSERT [dbo].[ManagerWithEmployee] ([ManagerID], [EmployeeID]) VALUES (15, 113)
INSERT [dbo].[ManagerWithEmployee] ([ManagerID], [EmployeeID]) VALUES (15, 114)
INSERT [dbo].[ManagerWithEmployee] ([ManagerID], [EmployeeID]) VALUES (23, 109)
INSERT [dbo].[ManagerWithEmployee] ([ManagerID], [EmployeeID]) VALUES (24, 116)
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Employee_FullName]    Script Date: 15/12/2024 11:22:02 ******/
CREATE NONCLUSTERED INDEX [IX_Employee_FullName] ON [dbo].[Employee]
(
	[FullName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Employees_Email]    Script Date: 15/12/2024 11:22:02 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Employees_Email] ON [dbo].[Employee]
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_History_Date]    Script Date: 15/12/2024 11:22:02 ******/
CREATE NONCLUSTERED INDEX [IX_History_Date] ON [dbo].[History]
(
	[Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Log_Created]    Script Date: 15/12/2024 11:22:02 ******/
CREATE NONCLUSTERED INDEX [IX_Log_Created] ON [dbo].[Log]
(
	[Created] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Manager_Department]    Script Date: 15/12/2024 11:22:02 ******/
CREATE NONCLUSTERED INDEX [IX_Manager_Department] ON [dbo].[Manager]
(
	[Department] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Employee] ADD  CONSTRAINT [DF_Employee_Created]  DEFAULT (getdate()) FOR [Created]
GO
ALTER TABLE [dbo].[Employee] ADD  CONSTRAINT [DF__Employee__GUID__5EBF139D]  DEFAULT (newid()) FOR [GUID]
GO
ALTER TABLE [dbo].[History] ADD  CONSTRAINT [DF_History_Date]  DEFAULT (getdate()) FOR [Date]
GO
ALTER TABLE [dbo].[Log] ADD  CONSTRAINT [DF_Log_Created]  DEFAULT (getdate()) FOR [Created]
GO
ALTER TABLE [dbo].[Manager] ADD  CONSTRAINT [DF_Manager_Start]  DEFAULT (getdate()) FOR [Start]
GO
ALTER TABLE [dbo].[History]  WITH CHECK ADD  CONSTRAINT [FK_History_Action] FOREIGN KEY([ActionID])
REFERENCES [dbo].[Action] ([ID])
GO
ALTER TABLE [dbo].[History] CHECK CONSTRAINT [FK_History_Action]
GO
ALTER TABLE [dbo].[History]  WITH CHECK ADD  CONSTRAINT [FK_History_Employee] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([ID])
GO
ALTER TABLE [dbo].[History] CHECK CONSTRAINT [FK_History_Employee]
GO
ALTER TABLE [dbo].[History]  WITH CHECK ADD  CONSTRAINT [FK_History_Manager] FOREIGN KEY([ManagerID])
REFERENCES [dbo].[Manager] ([ID])
GO
ALTER TABLE [dbo].[History] CHECK CONSTRAINT [FK_History_Manager]
GO
ALTER TABLE [dbo].[Manager]  WITH CHECK ADD  CONSTRAINT [FK_Manager_Employee] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([ID])
GO
ALTER TABLE [dbo].[Manager] CHECK CONSTRAINT [FK_Manager_Employee]
GO
ALTER TABLE [dbo].[ManagerWithEmployee]  WITH CHECK ADD  CONSTRAINT [FK_ManagerWithEmployee_Employee] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([ID])
GO
ALTER TABLE [dbo].[ManagerWithEmployee] CHECK CONSTRAINT [FK_ManagerWithEmployee_Employee]
GO
ALTER TABLE [dbo].[ManagerWithEmployee]  WITH CHECK ADD  CONSTRAINT [FK_ManagerWithEmployee_Manager] FOREIGN KEY([ManagerID])
REFERENCES [dbo].[Manager] ([ID])
GO
ALTER TABLE [dbo].[ManagerWithEmployee] CHECK CONSTRAINT [FK_ManagerWithEmployee_Manager]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [checkEmailFormat] CHECK  (([Email] like '%@%.%'))
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [checkEmailFormat]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [checkPhoneFormat] CHECK  (([Phone] like '[0-9]%' AND (len([Phone])=(10) OR len([Phone])=(12))))
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [checkPhoneFormat]
GO
ALTER TABLE [dbo].[Log]  WITH CHECK ADD  CONSTRAINT [type Check] CHECK  (([Type]='ERROR' OR [Type]='INFO'))
GO
ALTER TABLE [dbo].[Log] CHECK CONSTRAINT [type Check]
GO
ALTER TABLE [dbo].[Manager]  WITH CHECK ADD  CONSTRAINT [Check Role] CHECK  (([Role]='Team Leader' OR [Role]='Content' OR [Role]='Logistics' OR [Role]='Creative Director' OR [Role]='CISO' OR [Role]='Quality' OR [Role]='Customer Service' OR [Role]='Sales' OR [Role]='Project' OR [Role]='HR' OR [Role]='CTO' OR [Role]='CMO' OR [Role]='CFO' OR [Role]='COO' OR [Role]='CEO'))
GO
ALTER TABLE [dbo].[Manager] CHECK CONSTRAINT [Check Role]
GO
/****** Object:  StoredProcedure [dbo].[Action_Delete]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Deleting Action
-- =============================================
CREATE PROCEDURE [dbo].[Action_Delete]

	@Original_ID int,
	@Original_Type varchar(255),
	@Original_Description text

	 AS
		DELETE FROM Action
		WHERE	(ID = @Original_ID) 
			and (Description like @Original_Description) 
			and (Type = @Original_Type) 

	     -- Check if the deletion was successful
		 If @@ROWCOUNT = 0
			Begin
				RAISERROR ('No rows were deleted :<', 16, 1);
			END
		Else
			BEGIN
				RAISERROR ('The deletion was successful :>', 16, 1);
			END
GO
/****** Object:  StoredProcedure [dbo].[Action_Insert]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Creating New ManagerWithEmployee
-- =============================================
CREATE PROCEDURE [dbo].[Action_Insert]

	@Type varchar(255),
	@Description text
	
	AS

	INSERT INTO Action
			   (Type, Description)
			Values
			   (@Type, @Description)

--We will retrieve the last values saved in the table to verify the process integrity
	Declare @ActionID INT = SCOPE_IDENTITY() -- Used to retrieve the last value of the IDENTITY column 
											   -- generated after adding a new row to the table.
	Select ID, Type, Description
	From Action
	Where ID = @ActionID
GO
/****** Object:  StoredProcedure [dbo].[Action_Select]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Select All Actions
-- =============================================
CREATE PROCEDURE [dbo].[Action_Select]

	AS

	SET NOCOUNT ON;

		Select 
				ID, Type, Description
		From	Action WITH(NOLOCK)
GO
/****** Object:  StoredProcedure [dbo].[Action_SelectByID]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Select Action by ID
-- =============================================
CREATE PROCEDURE [dbo].[Action_SelectByID]

	@ID INT
	AS

	SET NOCOUNT ON;

		Select 
				ID,	Type, Description
		From	Action WITH(NOLOCK)
		Where	ID = @ID
GO
/****** Object:  StoredProcedure [dbo].[Action_Update]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Updating Action
-- =============================================
CREATE PROCEDURE [dbo].[Action_Update]
	
	@Type varchar(255),
	@Description text,
	@ID int,
	@Original_Description text,
	@Original_Type varchar(255)
	
	AS

		Update Action
		Set 
			Type = @Type,
			Description = @Description
		Where	(ID = @ID) 
			and (Type = @Original_Type)
			and (Description like @Original_Description)

		-- Retrieving the updated rows
		SELECT *
		From	Action with (nolock)
		Where	(ID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[Employee_Delete]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Deleting Employee
-- =============================================
CREATE PROCEDURE [dbo].[Employee_Delete]

	@Original_ID int,
	@Original_FullName varchar(255),
	@Original_Phone varchar(20),
	@Original_Email varchar(255),
	@Original_Created datetime

	 AS

	 -- Delete from anothers before the main

	 DELETE FROM History
		WHERE	(EmployeeID = @Original_ID) 

		DELETE FROM History
		WHERE	(EmployeeID = @Original_ID) 

	 DELETE FROM ManagerWithEmployee
		WHERE	(EmployeeID = @Original_ID) 

	 DELETE FROM Manager
		WHERE	(EmployeeID = @Original_ID) 


		DELETE FROM Employee
		WHERE	(ID = @Original_ID) 
			and (FullName = @Original_FullName) 
			and (Email = @Original_Email) 
			and (Phone = @Original_Phone) 
			and (Created = @Original_Created) 

	  
GO
/****** Object:  StoredProcedure [dbo].[Employee_GetThePasswordByEmail]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Get Employee Password by Email
-- =============================================
CREATE PROCEDURE [dbo].[Employee_GetThePasswordByEmail]

	@email varchar(255)
	AS

	SET NOCOUNT ON;

		Select Password
		From	Employee with(nolock)
		where (Email = @email)
			
GO
/****** Object:  StoredProcedure [dbo].[Employee_Insert]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Creating New Employee
-- =============================================
CREATE PROCEDURE [dbo].[Employee_Insert]

	@FullName varchar(255),
	@Phone varchar(20),
	@Email varchar(255),
	@Password varchar(255),
	@Created datetime = NULL,
	@ManagerID int = NULL
	
	AS

	--Check if a date has not been entered
	If @Created IS NULL
		Begin
			INSERT INTO Employee
			   (FullName, Phone, Email, Password)
			Values
			   (@FullName, @Phone, @Email, @Password)
	End

	Else
		Begin
			INSERT INTO Employee
			   (FullName, Phone, Email, Password, Created)
			Values
			   (@FullName, @Phone, @Email, @Password, @Created)
	End

		--We will retrieve the last values saved in the table to verify the process integrity
	Declare @EmployeeID INT = SCOPE_IDENTITY() -- Used to retrieve the last value of the IDENTITY column 
											   -- generated after adding a new row to the table.


	-- In a case where we add an employee, we want there to be a manager responsible for them.									
	If @ManagerID Is Not Null 
	Begin    
		INSERT INTO dbo.ManagerWithEmployee 
				(ManagerID, EmployeeID)
			Values (@ManagerID, @EmployeeID);

		select @ManagerID
	End
	

	Select ID, FullName, Phone, Email, Password, Created
	From Employee With(nolock)
	Where ID = @EmployeeID


GO
/****** Object:  StoredProcedure [dbo].[Employee_Insert2]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Creating New Employee
-- =============================================
Create PROCEDURE [dbo].[Employee_Insert2]

	@FullName varchar(255),
	@Phone varchar(20),
	@Email varchar(255),
	@Password varchar(255),
	@Created datetime = NULL,
	@ManagerEmployeeID int = NULL
	
	AS

	--Check if a date has not been entered
	If @Created IS NULL
		Begin
			INSERT INTO Employee
			   (FullName, Phone, Email, Password)
			Values
			   (@FullName, @Phone, @Email, @Password)
	End

	Else
		Begin
			INSERT INTO Employee
			   (FullName, Phone, Email, Password, Created)
			Values
			   (@FullName, @Phone, @Email, @Password, @Created)
	End

		--We will retrieve the last values saved in the table to verify the process integrity
	Declare @EmployeeID INT = SCOPE_IDENTITY() -- Used to retrieve the last value of the IDENTITY column 
											   -- generated after adding a new row to the table.


	-- In a case where we add an employee, we want there to be a manager responsible for them.									
	If @ManagerEmployeeID Is Not Null 
	Begin

	    Declare @ManagerID INT;
		Select @ManagerID = id
		FROM Manager
		WHERE EmployeeID = @ManagerEmployeeID;
		
		INSERT INTO dbo.ManagerWithEmployee 
				(ManagerID, EmployeeID)
			Values (@ManagerID, @EmployeeID);

		select @ManagerID
	End
	

	Select ID, FullName, Phone, Email, Password, Created
	From Employee With(nolock)
	Where ID = @EmployeeID


GO
/****** Object:  StoredProcedure [dbo].[Employee_Select]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Select Employee by Password and Fullname
-- =============================================
CREATE PROCEDURE [dbo].[Employee_Select]

	@Password varchar(255),
	@FullName varchar(255)
	AS

	SET NOCOUNT ON;

		Select 
				FullName, Phone, Email, Password, Created, GUID
		From	Employee WITH(NOLOCK)
		where	(Password = @Password)
			and (FullName = @FullName)
GO
/****** Object:  StoredProcedure [dbo].[Employee_SelectByContaintsFullName]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Select Employees by a containts full name. 
-- =============================================
CREATE PROCEDURE [dbo].[Employee_SelectByContaintsFullName]

	@fullName varchar(255)
	AS

	SET NOCOUNT ON;

		
		Select top 50 ID,FullName, Email, Phone, Password, Created
		From Employee with(nolock)
		where FullName like '%' + @fullname + '%'


		
GO
/****** Object:  StoredProcedure [dbo].[Employee_SelectByEmail]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Select Employee by Email
-- =============================================
CREATE PROCEDURE [dbo].[Employee_SelectByEmail]

	@email varchar(255)
	AS

	SET NOCOUNT ON;

		Select 
				Employee.ID, FullName, Phone, Email, Created,
				Case 
				When Manager.EmployeeID IS NOT NULL 
				Then 1 
				Else 0 
				End as IsManager ,
				Case 
				When Manager.EmployeeID IS NOT NULL 
				Then Role  
				Else null 
				End as Role,
				Case 
				When Manager.EmployeeID IS NOT NULL 
				Then Department  
				Else null 
				End as Department,
				Case 
				When Manager.EmployeeID IS NOT NULL 
				Then Start  
				Else null 
				End as Start

		From	Employee with(nolock)
		left join Manager with(nolock)
			on Manager.EmployeeID = Employee.ID
		where (Email = @email)
			
			
GO
/****** Object:  StoredProcedure [dbo].[Employee_SelectByEmailAndPassword]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Select Employee by Email and Password
-- =============================================
CREATE PROCEDURE [dbo].[Employee_SelectByEmailAndPassword]

	@email varchar(255),
	@password varchar(255)
	AS

	SET NOCOUNT ON;

		Select 
				Employee.ID, FullName, Phone, Email, Password, Created,
				Case 
				When Manager.EmployeeID IS NOT NULL 
				Then 1 
				Else 0 
				End as IsManager ,
				Case 
				When Manager.EmployeeID IS NOT NULL 
				Then Role  
				Else null 
				End as Role,
				Case 
				When Manager.EmployeeID IS NOT NULL 
				Then Department  
				Else null 
				End as Department,
				Case 
				When Manager.EmployeeID IS NOT NULL 
				Then Start  
				Else null 
				End as Start

		From	Employee with(nolock)
		left join Manager with(nolock)
			on Manager.EmployeeID = Employee.ID
		where (Email = @email)
		and (Password = @password)
			
			
GO
/****** Object:  StoredProcedure [dbo].[Employee_SelectByFullnameAndPassword]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Select Employee by Password and Fullname
-- =============================================
CREATE PROCEDURE [dbo].[Employee_SelectByFullnameAndPassword]

	@FullName varchar(255),
	@Password varchar(255)
	AS

	SET NOCOUNT ON;

		Select 
				Employee.ID, FullName, Phone, Email, Password, Created,
				Case 
				When Manager.EmployeeID IS NOT NULL 
				Then 1 
				Else 0 
				End as IsManager ,
				Case 
				When Manager.EmployeeID IS NOT NULL 
				Then Role  
				Else null 
				End as Role,
				Case 
				When Manager.EmployeeID IS NOT NULL 
				Then Department  
				Else null 
				End as Department,
				Case 
				When Manager.EmployeeID IS NOT NULL 
				Then Start  
				Else null 
				End as Start

		From	Employee with(nolock)
		left join Manager with(nolock)
			on Manager.EmployeeID = Employee.ID
		where	(Password = @Password)
			and (FullName = @FullName)
			
GO
/****** Object:  StoredProcedure [dbo].[Employee_SelectByID]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Select Employee by ID
-- =============================================
CREATE PROCEDURE [dbo].[Employee_SelectByID]

	@ID INT
	AS

	SET NOCOUNT ON;

		Select 
				FullName, Phone, Email, Password, Created, GUID
		From	Employee WITH(NOLOCK)
		Where	ID = @ID
GO
/****** Object:  StoredProcedure [dbo].[Employee_SelectByManager]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Select Employees of a Specific Manager. 
-- =============================================
CREATE PROCEDURE [dbo].[Employee_SelectByManager]

	@ID int
	AS

	SET NOCOUNT ON;
		
		Select ID, FullName, Phone, Email, Password, Created
		From ManagerWithEmployee with(nolock)
		inner join Employee with(nolock)
		on ManagerWithEmployee.EmployeeID = Employee.ID
		where ManagerWithEmployee.ManagerID = @ID


		
GO
/****** Object:  StoredProcedure [dbo].[Employee_SelectByPasswordFullname]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Select Employee by Password and Fullname
-- =============================================
CREATE PROCEDURE [dbo].[Employee_SelectByPasswordFullname]

	@FullName varchar(255),
	@Password varchar(255)
	AS

	SET NOCOUNT ON;

		Select 
				Employee.ID, FullName, Phone, Email, Password, Created,
				Case 
				When Manager.EmployeeID IS NOT NULL 
				Then 1 
				Else 0 
				End as IsManager
		From	Employee with(nolock)
		left join Manager with(nolock)
			on Manager.EmployeeID = Employee.ID
		where	(Password = @Password)
			and (FullName = @FullName)
			
GO
/****** Object:  StoredProcedure [dbo].[Employee_Update]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Updating Employee
-- =============================================
CREATE PROCEDURE [dbo].[Employee_Update]

	@FullName varchar(255),
	@Phone varchar(20),
	@Email varchar(255),
	@ID int
	
	
	AS

		Update Employee
		Set 
			FullName = @FullName,
			Phone = @Phone,
			Email = @Email
		Where	(ID = @ID) 

		-- Retrieving the updated rows
		Select ID, FullName, Phone, Email, Password, Created
		From Employee With(nolock)
		Where ID = @ID
GO
/****** Object:  StoredProcedure [dbo].[History_Delete]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Deleting History
-- =============================================
CREATE PROCEDURE [dbo].[History_Delete]

	@Original_ID int,
	@Original_Date datetime,
	@Original_ActionID int,
	@Original_EmployeeID int,
	@Original_ManagerID int

	 AS
		DELETE FROM History
		WHERE	(ID = @Original_ID) 
			and (Date = @Original_Date) 
			and (ActionID = @Original_ActionID) 
			and (EmployeeID = @Original_EmployeeID) 
			and (ManagerID = @Original_ManagerID) 

 

	     -- Check if the deletion was successful
		 If @@ROWCOUNT = 0
			Begin
				RAISERROR ('No rows were deleted :<', 16, 1);
			END
		Else
			BEGIN
				RAISERROR ('The deletion was successful :>', 16, 1);
			END
GO
/****** Object:  StoredProcedure [dbo].[History_Insert]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Creating New History
-- =============================================
CREATE PROCEDURE [dbo].[History_Insert]

	
	
	@Date datetime = null,
	@ActionID int,
	@EmployeeID int,
	@ManagerEmployeeID int
	
	AS
		Declare @ManagerID INT;
		Select @ManagerID = id
		FROM Manager
		WHERE EmployeeID = @ManagerEmployeeID;

	--Check if a date has not been entered
	If @Date IS NULL
		Begin
			INSERT INTO History
			   (ActionID, EmployeeID, ManagerID)
			Values
			   (@ActionID, @EmployeeID, @ManagerID)
	End

	Else
		Begin
			INSERT INTO History
			   (Date, ActionID, EmployeeID, ManagerID)
			Values
			   (@Date, @ActionID, @EmployeeID, @ManagerID)
		End

	--We will retrieve the last values saved in the table to verify the process integrity
	Declare @HistoryID INT = SCOPE_IDENTITY() -- Used to retrieve the last value of the IDENTITY column 
											   -- generated after adding a new row to the table.
	Select ID, Date, ActionID, EmployeeID, ManagerID
	From History
	Where ID = @HistoryID

GO
/****** Object:  StoredProcedure [dbo].[History_Select]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Select History by ID
-- =============================================
CREATE PROCEDURE [dbo].[History_Select]

	@ID INT
	AS

	SET NOCOUNT ON;

		Select 
				ID,	Date, ActionID, EmployeeID, ManagerID
		From	History WITH(NOLOCK)
		Where	ID = @ID
GO
/****** Object:  StoredProcedure [dbo].[History_SelectByEmployeeID]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Select History by Employee ID
-- =============================================
CREATE PROCEDURE [dbo].[History_SelectByEmployeeID]

	@employeeID INT
	AS

	SET NOCOUNT ON;

		Select 
				History.ID, Date, Action.Type, Action.Description , ManagerEmployee.FullName as ManagerFullName
		From	History with(nolock)
		inner join Action with(nolock)
			on History.ActionID = Action.ID
		inner join Manager with(nolock)
			on History.ManagerID = Manager.ID
		inner join Employee as ManagerEmployee with(nolock) 
			on Manager.EmployeeID = ManagerEmployee.ID
		Where	History.EmployeeID = @employeeID
GO
/****** Object:  StoredProcedure [dbo].[History_SelectByID]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Select History by ID
-- =============================================
Create PROCEDURE [dbo].[History_SelectByID]

	@ID INT
	AS

	SET NOCOUNT ON;

		Select 
				ID,	Date, ActionID, EmployeeID, ManagerID
		From	History WITH(NOLOCK)
		Where	ID = @ID
GO
/****** Object:  StoredProcedure [dbo].[History_Update]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Updating History
-- =============================================
CREATE PROCEDURE [dbo].[History_Update]

	@Date datetime,
	@ActionID int,
	@EmployeeID int,
	@ManagerID int,
	@ID int,
	@Original_Date datetime,
	@Original_ActionID int,
	@Original_EmployeeID int,
	@Original_ManagerID int
	
	
	AS

		Update History
		Set 
			Date = @Date, 
			ActionID = @ActionID,
			EmployeeID = @EmployeeID,
			ManagerID = @ManagerID
		Where	(ID = @ID) 
			and (Date = @Original_Date)
			and (ActionID = @Original_ActionID) 
			and (EmployeeID = @Original_EmployeeID)
			and (ManagerID = @Original_ManagerID)

		-- Retrieving the updated rows
		SELECT *
		From	History with (nolock)
		Where	(ID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[Log_Delete]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Deleting Log
-- =============================================
CREATE PROCEDURE [dbo].[Log_Delete]

	@Original_ID int,
	@Original_Type varchar(50),
	@Original_Info text,
	@Original_Created datetime,
	@Original_RequestData text,
	@Original_ExceptionData text

	 AS
		DELETE FROM Log
		WHERE	(ID = @Original_ID) 
			and (Type = @Original_Type) 
			and (Info like @Original_Info) 
			and (Created = @Original_Created) 
			and (RequestData like @Original_RequestData) 
			and (ExceptionData like @Original_ExceptionData) 

	     -- Check if the deletion was successful
		 If @@ROWCOUNT = 0
			Begin
				RAISERROR ('No rows were deleted :<', 16, 1);
			END
		Else
			BEGIN
				RAISERROR ('The deletion was successful :>', 16, 1);
			END
GO
/****** Object:  StoredProcedure [dbo].[Log_Insert]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Creating New Log
-- =============================================
CREATE PROCEDURE [dbo].[Log_Insert]

	
	@Type varchar(50),
	@Info text,
	@Created datetime,
	@RequestData text = NULL ,
	@ExceptionData text = NULL
	
	AS

	--Check if a date has not been entered
	If @Created IS NULL
		Begin
			INSERT INTO Log
			   (Type, Info, RequestData, ExceptionData)
			Values
			   (@Type, @Info, @RequestData, @ExceptionData)
	End

	Else
		Begin
			INSERT INTO Log
			   (Type, Info, Created, RequestData, ExceptionData)
			Values
			   (@Type, @Info, @Created, @RequestData, @ExceptionData)
	End

	INSERT INTO Log
			   (Type, Info, Created, RequestData, ExceptionData)
			Values
			   (@Type, @Info, @Created, @RequestData, @ExceptionData)

	--We will retrieve the last values saved in the table to verify the process integrity
	Declare @LogID INT = SCOPE_IDENTITY() -- Used to retrieve the last value of the IDENTITY column 
											   -- generated after adding a new row to the table.
	Select ID, Type, Info, Created, RequestData, ExceptionData
	From Log
	Where ID = @LogID

GO
/****** Object:  StoredProcedure [dbo].[Log_Select]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Select all Logs
-- =============================================
CREATE PROCEDURE [dbo].[Log_Select]
	as
		SELECT  ID,	Type, Info, Created, RequestData, ExceptionData
		From	Log with (nolock)
GO
/****** Object:  StoredProcedure [dbo].[Log_SelectByID]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Select Log by ID
-- =============================================
Create PROCEDURE [dbo].[Log_SelectByID]

	@ID INT
	AS

	SET NOCOUNT ON;

		Select 
				ID,	Type, Info, Created, RequestData, ExceptionData
		From	Log WITH(NOLOCK)
		Where	ID = @ID
GO
/****** Object:  StoredProcedure [dbo].[Log_SelectByType]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 13.12.24
-- Description:	Select Log by Type from now until 7 days ago
-- =============================================
CREATE PROCEDURE [dbo].[Log_SelectByType]

	@type varchar(50)
	AS

	SET NOCOUNT ON;

		Select top 100
				ID,	Type, Info, Created, RequestData, ExceptionData
		From	Log WITH(NOLOCK)
		Where	Type = @Type
				and Created >= DATEADD(DAY, -7, GETDATE() )
GO
/****** Object:  StoredProcedure [dbo].[Log_Update]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Updating Log
-- =============================================
CREATE PROCEDURE [dbo].[Log_Update]

	
	@Type varchar(50),
	@Info text,
	@Created datetime,
	@RequestData text,
	@ExceptionData text,
	@ID int,
	@Original_Type varchar(50),
	@Original_Info text,
	@Original_Created datetime,
	@Original_RequestData text,
	@Original_ExceptionData text
	
	
	AS

		Update Log
		Set 
			Type = @Type, 
			Info = @Info,
			Created = @Created,
			RequestData = @RequestData,
			ExceptionData = @ExceptionData
		Where	(ID = @ID) 
			and (Type = @Original_Type)
			and (Info like @Original_Info) 
			and (Created = @Original_Created)
			and (RequestData like @Original_RequestData)
			and (ExceptionData like @Original_ExceptionData)

		-- Retrieving the updated rows
		SELECT *
		From	Log with (nolock)
		Where	(ID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[Manager_Delete]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Deleting Manager
-- =============================================
CREATE PROCEDURE [dbo].[Manager_Delete]

	@Original_ID int,
	@Original_Role varchar(255),
	@Original_Department varchar(255),
	@Original_Start datetime,
	@Original_EmployeeID int

	 AS
		DELETE FROM Manager
		WHERE	(ID = @Original_ID) 
			and (Role = @Original_Role) 
			and (Department = @Original_Department) 
			and (Start = @Original_Start) 
			and (EmployeeID = @Original_EmployeeID) 
 

	     -- Check if the deletion was successful
		 If @@ROWCOUNT = 0
			Begin
				RAISERROR ('No rows were deleted :<', 16, 1);
			END
		Else
			BEGIN
				RAISERROR ('The deletion was successful :>', 16, 1);
			END
GO
/****** Object:  StoredProcedure [dbo].[Manager_FullDataSelectByID]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Select AllData of Manager by ID
-- =============================================
CREATE PROCEDURE [dbo].[Manager_FullDataSelectByID]

	@id INT
	AS

	SET NOCOUNT ON;

		Select

		 Manager.Role, Manager.Department, Manager.Start, 
			   Employee.FullName , Employee.Phone, Employee.Email,
			   Employee.Created,
			   ManagerEmployee.FullName as ManagerFullName
		-- Manager as an employee.
		From Employee with(nolock) 
		left join  Manager with(nolock) 
			on Manager.EmployeeID = Employee.ID

		-- Not certain that the manager has a manager above them.
		left join ManagerWithEmployee with(nolock)
			on ManagerWithEmployee.EmployeeID = Employee.ID

		-- Manager as a a manager employee .
		left join Manager as ManagerOfEmployee with(nolock)
			on ManagerWithEmployee.ManagerID = ManagerOfEmployee.ID
		left join Employee as ManagerEmployee with(nolock)
			on ManagerOfEmployee.EmployeeID = ManagerEmployee.ID
		where Employee.ID = @id
GO
/****** Object:  StoredProcedure [dbo].[Manager_Insert]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Creating New Manager
-- =============================================
CREATE PROCEDURE [dbo].[Manager_Insert]

	
	@Role varchar(255),
	@Department varchar(255),
	@Start datetime = null,
	@EmployeeID int
	
	AS

	If @Start IS NULL
		Begin
			INSERT INTO Manager
			   (Role, Department, EmployeeID)
			Values
			   (@Role, @Department, @EmployeeID)
	End

	Else
		Begin
		INSERT INTO Manager
			   (Role, Department, Start, EmployeeID)
			Values
			   (@Role, @Department, @Start, @EmployeeID)
			
	End

	--We will retrieve the last values saved in the table to verify the process integrity
	Declare @ManagerID INT = SCOPE_IDENTITY() -- Used to retrieve the last value of the IDENTITY column 
											   -- generated after adding a new row to the table.
	Select ID ,Role, Department, Start, EmployeeID
	From Manager
	Where ID = @ManagerID

GO
/****** Object:  StoredProcedure [dbo].[Manager_Select]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Select all Managers
-- =============================================
CREATE PROCEDURE [dbo].[Manager_Select]
	as
		SELECT  Manager.ID,	Role, Department, Start, EmployeeID, FullName as EmployeeName
		From	Manager with (nolock)
		inner join Employee
			on Manager.EmployeeID = Employee.ID

GO
/****** Object:  StoredProcedure [dbo].[Manager_SelectByID]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Select Manager by ID
-- =============================================
Create PROCEDURE [dbo].[Manager_SelectByID]

	@ID INT
	AS

	SET NOCOUNT ON;

		Select 
				ID,	Role, Department, Start, EmployeeID
		From	Manager WITH(NOLOCK)
		Where	ID = @ID
GO
/****** Object:  StoredProcedure [dbo].[Manager_SelectMainData]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Select Main Data for Managers
-- =============================================
Create PROCEDURE [dbo].[Manager_SelectMainData]
	as
		SELECT  Employee.ID, FullName
		From	Manager with (nolock)
		inner join Employee with(nolock)
			on Manager.EmployeeID = Employee.ID

		

GO
/****** Object:  StoredProcedure [dbo].[Manager_Update]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Updating Manager
-- =============================================
CREATE PROCEDURE [dbo].[Manager_Update]

	
	
	@Role varchar(255),
	@Department varchar(255),
	@Start datetime,
	@EmployeeID int,
	@ID int,
	@Original_Role varchar(255),
	@Original_Department varchar(255),
	@Original_Start datetime,
	@Original_EmployeeID int
	
	
	AS

		Update Manager
		Set 
			Role = @Role, 
			Department = @Department,
			Start = @Start,
			EmployeeID = @EmployeeID
		Where	(ID = @ID) 
			and (Role = @Original_Role)
			and (Department = @Original_Department) 
			and (Start = @Original_Start)
			and (EmployeeID = @Original_EmployeeID)

		-- Retrieving the updated rows
		SELECT *
		From	Manager with (nolock)
		Where	(ID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[ManagerWithEmployee_Delete]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Deleting ManagerWithEmployee
-- =============================================
Create PROCEDURE [dbo].[ManagerWithEmployee_Delete]

	@Original_ManagerID int,
	@Original_EmployeeID int

	 AS
		DELETE FROM ManagerWithEmployee
		WHERE	(ManagerID = @Original_ManagerID) 
			and (EmployeeID = @Original_EmployeeID) 

	     -- Check if the deletion was successful
		 If @@ROWCOUNT = 0
			Begin
				RAISERROR ('No rows were deleted :<', 16, 1);
			END
		Else
			BEGIN
				RAISERROR ('The deletion was successful :>', 16, 1);
			END
GO
/****** Object:  StoredProcedure [dbo].[ManagerWithEmployee_Insert]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Creating New ManagerWithEmployee
-- =============================================
CREATE PROCEDURE [dbo].[ManagerWithEmployee_Insert]

	@managerEmployeeID int,
	@employeeID int
	
	AS

		Declare @ManagerID INT;
		Select @ManagerID = id
		FROM Manager
		WHERE EmployeeID = @managerEmployeeID

	INSERT INTO ManagerWithEmployee
			   (ManagerID, EmployeeID)
			Values
			   (@ManagerID, @employeeID)

	Select ManagerID, EmployeeID
	From ManagerWithEmployee
	Where ManagerID = @ManagerID
		 and EmployeeID = @EmployeeID

GO
/****** Object:  StoredProcedure [dbo].[ManagerWithEmployee_Select]    Script Date: 15/12/2024 11:22:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Select All ManagerWithEmployee
-- =============================================
Create PROCEDURE [dbo].[ManagerWithEmployee_Select]

	@Original_ManagerID int,
	@Original_EmployeeID int
	AS

	SET NOCOUNT ON;

		Select 
				ManagerID, EmployeeID
		From	ManagerWithEmployee WITH(NOLOCK)
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Action id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Action', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Action type' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Action', @level2type=N'COLUMN',@level2name=N'Type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Action description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Action', @level2type=N'COLUMN',@level2name=N'Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Employee id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Employee full name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'FullName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Employee full name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Employee email' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Employee password' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Password'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Employee create date' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Created'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'CONSTRAINT',@level2name=N'PK_Employee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' For performance improvement in search' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'INDEX',@level2name=N'IX_Employee_FullName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Since it is a column with unique values' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'INDEX',@level2name=N'IX_Employees_Email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'HistoryID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'History', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Action date' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'History', @level2type=N'COLUMN',@level2name=N'Date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Key to Action' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'History', @level2type=N'COLUMN',@level2name=N'ActionID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Key to Employee' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'History', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Key to Manager' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'History', @level2type=N'COLUMN',@level2name=N'ManagerID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' For performance improvement in search' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'History', @level2type=N'INDEX',@level2name=N'IX_History_Date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Log id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Log', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Log type' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Log', @level2type=N'COLUMN',@level2name=N'Type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Log info' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Log', @level2type=N'COLUMN',@level2name=N'Info'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Log create date' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Log', @level2type=N'COLUMN',@level2name=N'Created'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Log request data' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Log', @level2type=N'COLUMN',@level2name=N'RequestData'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Log exception data' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Log', @level2type=N'COLUMN',@level2name=N'ExceptionData'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'for performance improvement in search queries by name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Log', @level2type=N'INDEX',@level2name=N'IX_Log_Created'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Checks the log type' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Log', @level2type=N'CONSTRAINT',@level2name=N'type Check'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Manager id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Manager', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Manager role type' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Manager', @level2type=N'COLUMN',@level2name=N'Role'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Manager department' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Manager', @level2type=N'COLUMN',@level2name=N'Department'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Manager start date' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Manager', @level2type=N'COLUMN',@level2name=N'Start'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Key to Employee' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Manager', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'for performance improvement in search queries by name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Manager', @level2type=N'INDEX',@level2name=N'IX_Manager_Department'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check Role type' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Manager', @level2type=N'CONSTRAINT',@level2name=N'Check Role'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Key to Manager' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ManagerWithEmployee', @level2type=N'COLUMN',@level2name=N'ManagerID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Key to Employee' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ManagerWithEmployee', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
USE [master]
GO
ALTER DATABASE [DanielAmosDB] SET  READ_WRITE 
GO
