USE [master]
GO
/****** Object:  Database [FondFoxDB]    Script Date: 25.06.2024 12:54:05 ******/
CREATE DATABASE [FondFoxDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'FondFoxDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\FondFoxDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'FondFoxDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\FondFoxDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [FondFoxDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [FondFoxDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [FondFoxDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [FondFoxDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [FondFoxDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [FondFoxDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [FondFoxDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [FondFoxDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [FondFoxDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [FondFoxDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [FondFoxDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [FondFoxDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [FondFoxDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [FondFoxDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [FondFoxDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [FondFoxDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [FondFoxDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [FondFoxDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [FondFoxDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [FondFoxDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [FondFoxDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [FondFoxDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [FondFoxDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [FondFoxDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [FondFoxDB] SET RECOVERY FULL 
GO
ALTER DATABASE [FondFoxDB] SET  MULTI_USER 
GO
ALTER DATABASE [FondFoxDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [FondFoxDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [FondFoxDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [FondFoxDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [FondFoxDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [FondFoxDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'FondFoxDB', N'ON'
GO
ALTER DATABASE [FondFoxDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [FondFoxDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [FondFoxDB]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 25.06.2024 12:54:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[namedepartment] [nvarchar](100) NULL,
	[description] [nvarchar](250) NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoginHistory]    Script Date: 25.06.2024 12:54:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoginHistory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[date] [datetime] NULL,
	[result] [bit] NULL,
 CONSTRAINT [PK_LoginHistory] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[News]    Script Date: 25.06.2024 12:54:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[News](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[message] [nvarchar](250) NULL,
	[date] [date] NULL,
	[department] [int] NULL,
 CONSTRAINT [PK_News] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 25.06.2024 12:54:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[stock_id] [int] NULL,
	[typeorder] [int] NULL,
	[price] [decimal](18, 2) NULL,
	[date] [datetime] NULL,
	[cost] [int] NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Portfel]    Script Date: 25.06.2024 12:54:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Portfel](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[stock_id] [int] NULL,
	[cost] [int] NULL,
	[price] [decimal](18, 2) NULL,
 CONSTRAINT [PK_Portfel] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 25.06.2024 12:54:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[namerole] [nvarchar](50) NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Stocks]    Script Date: 25.06.2024 12:54:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stocks](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[namestock] [nvarchar](50) NULL,
	[description] [nvarchar](200) NULL,
	[typestock] [int] NULL,
	[price] [decimal](10, 2) NULL,
	[photo] [nvarchar](150) NULL,
 CONSTRAINT [PK_Stocks] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TypeOrder]    Script Date: 25.06.2024 12:54:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TypeOrder](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nametype] [nvarchar](50) NULL,
 CONSTRAINT [PK_TypeOrder] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TypeStock]    Script Date: 25.06.2024 12:54:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TypeStock](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
 CONSTRAINT [PK_TypeStock] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 25.06.2024 12:54:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[firstname] [nvarchar](50) NULL,
	[lastname] [nvarchar](50) NULL,
	[fathername] [nvarchar](50) NULL,
	[role] [int] NULL,
	[department] [int] NULL,
	[login] [nvarchar](50) NULL,
	[password] [nvarchar](50) NULL,
	[balance] [decimal](18, 2) NULL,
	[photo] [nvarchar](150) NULL,
	[email] [nvarchar](100) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Department] ON 

INSERT [dbo].[Department] ([id], [namedepartment], [description]) VALUES (1, N'Отдел Технологического Сектора', N'Отслеживает и анализирует акции компаний, работающих в сфере информационных технологий и коммуникаций. Включает компании-разработчики ПО, интернет-платформы, производители электроники и телекоммуникационные компании.')
INSERT [dbo].[Department] ([id], [namedepartment], [description]) VALUES (2, N'Отдел Энергетического Сектора', N'Специализируется на акциях компаний, работающих в энергетической отрасли. Включает нефтегазовые компании, производителей возобновляемой энергии, а также предприятия, занимающиеся добычей и переработкой угля.')
INSERT [dbo].[Department] ([id], [namedepartment], [description]) VALUES (3, N'Отдел Финансового Сектора', N'Фокусируется на акциях банков, страховых компаний, инвестиционных фондов и других финансовых учреждений. Проводит анализ финансовых показателей и оценивает влияние макроэкономических факторов на финансовые компании.')
INSERT [dbo].[Department] ([id], [namedepartment], [description]) VALUES (4, N'Отдел Потребительского Сектора', N'Отвечает за мониторинг акций компаний, производящих потребительские товары и услуги. Включает розничные сети, производители продуктов питания и напитков, компании, предоставляющие бытовые услуги и товары длительного пользования.
')
INSERT [dbo].[Department] ([id], [namedepartment], [description]) VALUES (5, N'Отдел Развлечений и Медиа', N'Специализируется на акциях компаний, работающих в индустрии развлечений и медиа. Включает киностудии, телекомпании, игровые компании, а также компании, предоставляющие услуги стриминга и медиа-контента.')
SET IDENTITY_INSERT [dbo].[Department] OFF
GO
SET IDENTITY_INSERT [dbo].[LoginHistory] ON 

INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (1, 9, CAST(N'2024-06-24T01:34:04.627' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (2, 7, CAST(N'2024-06-24T01:34:26.607' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (3, 9, CAST(N'2024-06-24T01:53:33.487' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (4, 9, CAST(N'2024-06-24T01:59:03.470' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (5, 9, CAST(N'2024-06-24T02:08:54.603' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (6, 9, CAST(N'2024-06-24T02:10:09.757' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (7, 9, CAST(N'2024-06-24T02:11:04.550' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (8, 9, CAST(N'2024-06-24T02:11:30.367' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (9, 9, CAST(N'2024-06-24T02:12:54.430' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (10, 9, CAST(N'2024-06-24T02:44:55.343' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (11, 9, CAST(N'2024-06-24T02:45:15.127' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (12, 9, CAST(N'2024-06-24T02:47:48.710' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (13, 9, CAST(N'2024-06-24T02:48:54.393' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (14, 9, CAST(N'2024-06-24T02:50:48.167' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (15, 9, CAST(N'2024-06-24T02:51:53.040' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (16, 9, CAST(N'2024-06-24T02:56:33.577' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (17, 9, CAST(N'2024-06-24T02:57:48.380' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (18, 9, CAST(N'2024-06-24T03:06:33.367' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (19, 9, CAST(N'2024-06-24T03:15:20.767' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (20, 9, CAST(N'2024-06-24T03:22:52.583' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (21, 9, CAST(N'2024-06-24T03:31:27.497' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (24, 12, CAST(N'2024-06-24T20:47:44.387' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (25, 9, CAST(N'2024-06-24T21:00:20.940' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (26, 9, CAST(N'2024-06-24T21:04:41.717' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (27, 9, CAST(N'2024-06-24T21:38:21.600' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (28, 9, CAST(N'2024-06-24T21:40:01.847' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (29, 12, CAST(N'2024-06-25T00:09:44.273' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (30, 9, CAST(N'2024-06-25T00:28:29.937' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (31, 9, CAST(N'2024-06-25T00:29:31.100' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (32, 9, CAST(N'2024-06-25T00:31:16.410' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (33, 9, CAST(N'2024-06-25T00:45:19.083' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (34, 9, CAST(N'2024-06-25T00:47:06.597' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (35, 9, CAST(N'2024-06-25T00:49:50.740' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (36, 9, CAST(N'2024-06-25T00:55:31.070' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (37, 9, CAST(N'2024-06-25T00:58:56.413' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (38, 9, CAST(N'2024-06-25T01:01:11.220' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (39, 9, CAST(N'2024-06-25T01:03:18.407' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (40, 9, CAST(N'2024-06-25T01:13:50.240' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (41, 9, CAST(N'2024-06-25T01:18:04.757' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (42, 9, CAST(N'2024-06-25T01:29:27.230' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (43, 9, CAST(N'2024-06-25T01:33:55.617' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (44, 9, CAST(N'2024-06-25T02:09:40.967' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (45, 9, CAST(N'2024-06-25T02:18:21.397' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (46, 9, CAST(N'2024-06-25T02:44:25.703' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (47, 9, CAST(N'2024-06-25T02:45:08.687' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (48, 9, CAST(N'2024-06-25T02:49:50.003' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (49, 9, CAST(N'2024-06-25T02:50:31.883' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (50, 9, CAST(N'2024-06-25T02:52:00.523' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (51, 9, CAST(N'2024-06-25T02:52:59.877' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (52, 9, CAST(N'2024-06-25T02:54:59.460' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (53, 9, CAST(N'2024-06-25T03:02:42.323' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (54, 9, CAST(N'2024-06-25T08:18:29.750' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (55, 9, CAST(N'2024-06-25T08:22:50.843' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (56, 9, CAST(N'2024-06-25T09:42:11.283' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (57, 9, CAST(N'2024-06-25T09:47:23.917' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (58, 9, CAST(N'2024-06-25T09:54:12.580' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (59, 9, CAST(N'2024-06-25T09:57:44.063' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (60, 9, CAST(N'2024-06-25T10:39:48.297' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (61, 9, CAST(N'2024-06-25T11:30:41.677' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (62, 9, CAST(N'2024-06-25T11:35:11.240' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (63, 9, CAST(N'2024-06-25T12:06:38.623' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (64, 9, CAST(N'2024-06-25T12:17:58.703' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (65, 9, CAST(N'2024-06-25T12:18:18.703' AS DateTime), 1)
INSERT [dbo].[LoginHistory] ([id], [user_id], [date], [result]) VALUES (66, 9, CAST(N'2024-06-25T12:24:57.107' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[LoginHistory] OFF
GO
SET IDENTITY_INSERT [dbo].[News] ON 

INSERT [dbo].[News] ([id], [message], [date], [department]) VALUES (1, N'Вы че там все офигели. Почему за последний месяц убыток 120к???', CAST(N'2024-06-25' AS Date), 4)
INSERT [dbo].[News] ([id], [message], [date], [department]) VALUES (2, N'Уволю всех на"@#!', CAST(N'2024-06-25' AS Date), 4)
SET IDENTITY_INSERT [dbo].[News] OFF
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([id], [user_id], [stock_id], [typeorder], [price], [date], [cost]) VALUES (1, 9, 4, 1, CAST(2463.60 AS Decimal(18, 2)), CAST(N'2024-06-25T02:55:03.890' AS DateTime), 6)
INSERT [dbo].[Orders] ([id], [user_id], [stock_id], [typeorder], [price], [date], [cost]) VALUES (2, 9, 9, 1, CAST(1704.25 AS Decimal(18, 2)), CAST(N'2024-06-25T03:02:49.363' AS DateTime), 17)
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[Portfel] ON 

INSERT [dbo].[Portfel] ([id], [user_id], [stock_id], [cost], [price]) VALUES (7, 1, 2, 6, CAST(1300.75 AS Decimal(18, 2)))
INSERT [dbo].[Portfel] ([id], [user_id], [stock_id], [cost], [price]) VALUES (8, 1, 4, 1, CAST(410.60 AS Decimal(18, 2)))
INSERT [dbo].[Portfel] ([id], [user_id], [stock_id], [cost], [price]) VALUES (9, 2, 7, 4, CAST(4600.80 AS Decimal(18, 2)))
INSERT [dbo].[Portfel] ([id], [user_id], [stock_id], [cost], [price]) VALUES (10, 3, 10, 2, CAST(650.80 AS Decimal(18, 2)))
INSERT [dbo].[Portfel] ([id], [user_id], [stock_id], [cost], [price]) VALUES (11, 4, 5, 3, CAST(345.20 AS Decimal(18, 2)))
INSERT [dbo].[Portfel] ([id], [user_id], [stock_id], [cost], [price]) VALUES (12, 5, 2, 3, CAST(1300.75 AS Decimal(18, 2)))
INSERT [dbo].[Portfel] ([id], [user_id], [stock_id], [cost], [price]) VALUES (13, 9, 10, 5, CAST(650.80 AS Decimal(18, 2)))
INSERT [dbo].[Portfel] ([id], [user_id], [stock_id], [cost], [price]) VALUES (14, 9, 4, 1, CAST(410.60 AS Decimal(18, 2)))
INSERT [dbo].[Portfel] ([id], [user_id], [stock_id], [cost], [price]) VALUES (15, 9, 3, 7, CAST(270.40 AS Decimal(18, 2)))
INSERT [dbo].[Portfel] ([id], [user_id], [stock_id], [cost], [price]) VALUES (16, 6, 5, 3, CAST(345.20 AS Decimal(18, 2)))
INSERT [dbo].[Portfel] ([id], [user_id], [stock_id], [cost], [price]) VALUES (17, 6, 3, 1, CAST(270.40 AS Decimal(18, 2)))
INSERT [dbo].[Portfel] ([id], [user_id], [stock_id], [cost], [price]) VALUES (18, 9, 9, 17, CAST(100.25 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[Portfel] OFF
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([id], [namerole]) VALUES (1, N'Брокер')
INSERT [dbo].[Role] ([id], [namerole]) VALUES (2, N'Старший брокер')
INSERT [dbo].[Role] ([id], [namerole]) VALUES (3, N'Администратор')
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].[Stocks] ON 

INSERT [dbo].[Stocks] ([id], [namestock], [description], [typestock], [price], [photo]) VALUES (1, N'Яндекс', N'Российская интернет-компания, предлагающая услуги поиска, рекламы и многих других. Яндекс также активно развивает сервисы на основе искусственного интеллекта и облачных технологий.', 1, CAST(4200.50 AS Decimal(10, 2)), N'yandex_logo.png')
INSERT [dbo].[Stocks] ([id], [namestock], [description], [typestock], [price], [photo]) VALUES (2, N'Mail.ru Group', N'Один из крупнейших интернет-порталов России, предлагающий социальные сети, игры и почту. Mail.ru также предоставляет платформы для электронной коммерции и облачные сервисы.', 1, CAST(1300.75 AS Decimal(10, 2)), N'mail_ru_logo.png')
INSERT [dbo].[Stocks] ([id], [namestock], [description], [typestock], [price], [photo]) VALUES (3, N'Газпром', N'Крупнейшая российская энергетическая компания, занимающаяся добычей, транспортировкой и продажей газа. Компания также владеет значительными активами в электроэнергетике и газохимии.', 2, CAST(270.40 AS Decimal(10, 2)), N'gazprom_logo.png')
INSERT [dbo].[Stocks] ([id], [namestock], [description], [typestock], [price], [photo]) VALUES (4, N'Роснефть', N'Ведущая нефтяная компания России, занимающаяся разведкой, добычей и переработкой нефти. Компания активно расширяет свои международные проекты и инвестирует в инновационные технологии.', 2, CAST(410.60 AS Decimal(10, 2)), N'rosneft_logo.png')
INSERT [dbo].[Stocks] ([id], [namestock], [description], [typestock], [price], [photo]) VALUES (5, N'Сбербанк', N'Крупнейший банк России, предлагающий широкий спектр финансовых услуг. Компания активно внедряет инновационные технологии и развивает экосистему цифровых сервисов.', 3, CAST(345.20 AS Decimal(10, 2)), N'sberbank_logo.png')
INSERT [dbo].[Stocks] ([id], [namestock], [description], [typestock], [price], [photo]) VALUES (6, N'ВТБ', N'Ведущий российский коммерческий банк, предоставляющий услуги для частных и корпоративных клиентов. ВТБ также активно развивает свои международные операции и инвестиционные проекты.', 3, CAST(50.30 AS Decimal(10, 2)), N'vtb_logo.png')
INSERT [dbo].[Stocks] ([id], [namestock], [description], [typestock], [price], [photo]) VALUES (7, N'Магнит', N'Одна из крупнейших розничных сетей в России, занимающаяся продажей продуктов питания и товаров повседневного спроса. Магнит активно расширяет свою сеть и внедряет современные технологии.', 4, CAST(4600.80 AS Decimal(10, 2)), N'magnit_logo.png')
INSERT [dbo].[Stocks] ([id], [namestock], [description], [typestock], [price], [photo]) VALUES (8, N'X5 Retail Group', N'Ведущая розничная компания, управляющая сетями "Пятерочка", "Перекресток" и "Карусель". X5 Retail Group активно развивает свои логистические и дистрибьюторские возможности.', 4, CAST(3900.55 AS Decimal(10, 2)), N'x5_logo.png')
INSERT [dbo].[Stocks] ([id], [namestock], [description], [typestock], [price], [photo]) VALUES (9, N'Первый канал', N'Основной государственный телеканал России, предлагающий разнообразный медиа-контент. Первый канал транслирует новости, развлекательные программы, фильмы и сериалы.', 5, CAST(100.25 AS Decimal(10, 2)), N'first_channel_logo.png')
INSERT [dbo].[Stocks] ([id], [namestock], [description], [typestock], [price], [photo]) VALUES (10, N'Газпром-Медиа', N'Крупнейшая медиахолдинговая компания России, включающая в себя несколько телеканалов и радиостанций. Газпром-Медиа активно развивает новые медиаформаты и цифровые платформы.', 6, CAST(650.80 AS Decimal(10, 2)), N'gazprom_media_logo.png')
INSERT [dbo].[Stocks] ([id], [namestock], [description], [typestock], [price], [photo]) VALUES (11, N'Аэрофлот', N'Аэрофлот — крупнейшая авиакомпания России, одна из старейших в мире, основанная в 1923 году.', 4, CAST(63.23 AS Decimal(10, 2)), N'aeroflot.png')
SET IDENTITY_INSERT [dbo].[Stocks] OFF
GO
SET IDENTITY_INSERT [dbo].[TypeOrder] ON 

INSERT [dbo].[TypeOrder] ([id], [nametype]) VALUES (1, N'Покупка')
INSERT [dbo].[TypeOrder] ([id], [nametype]) VALUES (2, N'Продажа')
SET IDENTITY_INSERT [dbo].[TypeOrder] OFF
GO
SET IDENTITY_INSERT [dbo].[TypeStock] ON 

INSERT [dbo].[TypeStock] ([id], [name]) VALUES (1, N'Технологии')
INSERT [dbo].[TypeStock] ([id], [name]) VALUES (2, N'Энергетика')
INSERT [dbo].[TypeStock] ([id], [name]) VALUES (3, N'Финансы')
INSERT [dbo].[TypeStock] ([id], [name]) VALUES (4, N'Потребительские')
INSERT [dbo].[TypeStock] ([id], [name]) VALUES (5, N'Медиа')
INSERT [dbo].[TypeStock] ([id], [name]) VALUES (6, N'Развлечения')
SET IDENTITY_INSERT [dbo].[TypeStock] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([id], [firstname], [lastname], [fathername], [role], [department], [login], [password], [balance], [photo], [email]) VALUES (1, N'Илон', N'Маск', N'Рив', 1, 1, N'imusk', N'password123', CAST(8215.10 AS Decimal(18, 2)), NULL, N'elon.musk@example.com')
INSERT [dbo].[Users] ([id], [firstname], [lastname], [fathername], [role], [department], [login], [password], [balance], [photo], [email]) VALUES (2, N'Сундар', N'Пичаи', N'Раджарам', 2, 2, N'spichai', N'password123', CAST(18403.20 AS Decimal(18, 2)), NULL, N'sundar.pichai@example.com')
INSERT [dbo].[Users] ([id], [firstname], [lastname], [fathername], [role], [department], [login], [password], [balance], [photo], [email]) VALUES (3, N'Шерил', N'Сандберг', N'Кара', 3, 3, N'ssandberg', N'password123', CAST(1301.60 AS Decimal(18, 2)), NULL, N'sheryl.sandberg@example.com')
INSERT [dbo].[Users] ([id], [firstname], [lastname], [fathername], [role], [department], [login], [password], [balance], [photo], [email]) VALUES (4, N'Тим', N'Кук', N'Дональд', 1, 1, N'tcook', N'password123', CAST(1035.60 AS Decimal(18, 2)), NULL, N'tim.cook@example.com')
INSERT [dbo].[Users] ([id], [firstname], [lastname], [fathername], [role], [department], [login], [password], [balance], [photo], [email]) VALUES (5, N'Сатья', N'Наделла', N'Нараяна', 1, 2, N'snadella', N'password123', CAST(3902.25 AS Decimal(18, 2)), NULL, N'satya.nadella@example.com')
INSERT [dbo].[Users] ([id], [firstname], [lastname], [fathername], [role], [department], [login], [password], [balance], [photo], [email]) VALUES (6, N'Мэри', N'Барра', N'Тереза', 1, 4, N'mbarra', N'password123', CAST(1306.00 AS Decimal(18, 2)), NULL, N'mary.barra@example.com')
INSERT [dbo].[Users] ([id], [firstname], [lastname], [fathername], [role], [department], [login], [password], [balance], [photo], [email]) VALUES (7, N'Брокер', N'Брокер', N'Брокер', 1, 4, N'broker', N'broker', CAST(0.00 AS Decimal(18, 2)), NULL, N'mary.barra@example.com')
INSERT [dbo].[Users] ([id], [firstname], [lastname], [fathername], [role], [department], [login], [password], [balance], [photo], [email]) VALUES (8, N'Старший', N'Брокер', N'Брокер', 2, 4, N'sbroker', N'sbroker', CAST(0.00 AS Decimal(18, 2)), NULL, N'mary.barra@example.com')
INSERT [dbo].[Users] ([id], [firstname], [lastname], [fathername], [role], [department], [login], [password], [balance], [photo], [email]) VALUES (9, N'Админ', N'Админ', N'Админ', 3, 4, N'admin', N'admin', CAST(7261.65 AS Decimal(18, 2)), NULL, N'mary.barra@example.com')
INSERT [dbo].[Users] ([id], [firstname], [lastname], [fathername], [role], [department], [login], [password], [balance], [photo], [email]) VALUES (10, N'Джек', N'Дорси', N'Патрик', 1, 5, N'jdorsey', N'password123', CAST(0.00 AS Decimal(18, 2)), NULL, N'jack.dorsey@example.com')
INSERT [dbo].[Users] ([id], [firstname], [lastname], [fathername], [role], [department], [login], [password], [balance], [photo], [email]) VALUES (11, N'Евгений', N'Пригожин', N'Максимович', 1, NULL, N'vagner', N'top', CAST(0.00 AS Decimal(18, 2)), NULL, N'vagner@gmail.com')
INSERT [dbo].[Users] ([id], [firstname], [lastname], [fathername], [role], [department], [login], [password], [balance], [photo], [email]) VALUES (12, N'Максим', N'Дронов', N'Олегович', 2, NULL, N'gay', N'gym', CAST(0.00 AS Decimal(18, 2)), NULL, N'maxim@gmail.com')
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[LoginHistory]  WITH CHECK ADD  CONSTRAINT [FK_LoginHistory_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[LoginHistory] CHECK CONSTRAINT [FK_LoginHistory_Users]
GO
ALTER TABLE [dbo].[News]  WITH CHECK ADD  CONSTRAINT [FK_News_Department] FOREIGN KEY([department])
REFERENCES [dbo].[Department] ([id])
GO
ALTER TABLE [dbo].[News] CHECK CONSTRAINT [FK_News_Department]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Stocks] FOREIGN KEY([stock_id])
REFERENCES [dbo].[Stocks] ([id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Stocks]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_TypeOrder] FOREIGN KEY([typeorder])
REFERENCES [dbo].[TypeOrder] ([id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_TypeOrder]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Users]
GO
ALTER TABLE [dbo].[Portfel]  WITH CHECK ADD  CONSTRAINT [FK_Portfel_Stocks] FOREIGN KEY([stock_id])
REFERENCES [dbo].[Stocks] ([id])
GO
ALTER TABLE [dbo].[Portfel] CHECK CONSTRAINT [FK_Portfel_Stocks]
GO
ALTER TABLE [dbo].[Portfel]  WITH CHECK ADD  CONSTRAINT [FK_Portfel_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Portfel] CHECK CONSTRAINT [FK_Portfel_Users]
GO
ALTER TABLE [dbo].[Stocks]  WITH CHECK ADD  CONSTRAINT [FK_Stocks_TypeStock] FOREIGN KEY([typestock])
REFERENCES [dbo].[TypeStock] ([id])
GO
ALTER TABLE [dbo].[Stocks] CHECK CONSTRAINT [FK_Stocks_TypeStock]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Department] FOREIGN KEY([department])
REFERENCES [dbo].[Department] ([id])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Department]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Role] FOREIGN KEY([role])
REFERENCES [dbo].[Role] ([id])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Role]
GO
/****** Object:  Trigger [dbo].[trg_UpdateBalance]    Script Date: 25.06.2024 12:54:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].[trg_UpdateBalance]
ON [dbo].[Portfel]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Обновить price в таблице Portfel на основе данных из Stocks
    UPDATE p
    SET p.price = s.price
    FROM dbo.Portfel p
    INNER JOIN dbo.Stocks s ON p.stock_id = s.id;

    -- Обновить баланс всех пользователей, чьи записи в портфеле изменились
    UPDATE u
    SET u.balance = ISNULL(p.TotalValue, 0)
    FROM dbo.Users u
    INNER JOIN (
        SELECT p.user_id, SUM(p.price * p.cost) AS TotalValue
        FROM dbo.Portfel p
        GROUP BY p.user_id
    ) p
    ON u.id = p.user_id;

    -- Установить баланс в 0 для пользователей, у которых нет записей в портфеле
    UPDATE u
    SET u.balance = 0
    FROM dbo.Users u
    WHERE NOT EXISTS (
        SELECT 1
        FROM dbo.Portfel p
        WHERE p.user_id = u.id
    );
END;

GO
ALTER TABLE [dbo].[Portfel] ENABLE TRIGGER [trg_UpdateBalance]
GO
USE [master]
GO
ALTER DATABASE [FondFoxDB] SET  READ_WRITE 
GO
