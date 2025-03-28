USE [master]
GO
/****** Object:  Database [JustLearnDB]    Script Date: 3/27/2025 11:49:23 PM ******/
CREATE DATABASE [JustLearnDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'JustLearnDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\JustLearnDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'JustLearnDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\JustLearnDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [JustLearnDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [JustLearnDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [JustLearnDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [JustLearnDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [JustLearnDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [JustLearnDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [JustLearnDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [JustLearnDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [JustLearnDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [JustLearnDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [JustLearnDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [JustLearnDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [JustLearnDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [JustLearnDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [JustLearnDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [JustLearnDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [JustLearnDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [JustLearnDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [JustLearnDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [JustLearnDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [JustLearnDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [JustLearnDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [JustLearnDB] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [JustLearnDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [JustLearnDB] SET RECOVERY FULL 
GO
ALTER DATABASE [JustLearnDB] SET  MULTI_USER 
GO
ALTER DATABASE [JustLearnDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [JustLearnDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [JustLearnDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [JustLearnDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [JustLearnDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [JustLearnDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'JustLearnDB', N'ON'
GO
ALTER DATABASE [JustLearnDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [JustLearnDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [JustLearnDB]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 3/27/2025 11:49:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoleClaims]    Script Date: 3/27/2025 11:49:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoleClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 3/27/2025 11:49:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](256) NULL,
	[NormalizedName] [nvarchar](256) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 3/27/2025 11:49:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 3/27/2025 11:49:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](450) NOT NULL,
	[ProviderKey] [nvarchar](450) NOT NULL,
	[ProviderDisplayName] [nvarchar](max) NULL,
	[UserId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 3/27/2025 11:49:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](450) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 3/27/2025 11:49:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](450) NOT NULL,
	[Discriminator] [nvarchar](max) NOT NULL,
	[UserName] [nvarchar](256) NULL,
	[NormalizedUserName] [nvarchar](256) NULL,
	[Email] [nvarchar](256) NULL,
	[NormalizedEmail] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
 CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserTokens]    Script Date: 3/27/2025 11:49:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserTokens](
	[UserId] [nvarchar](450) NOT NULL,
	[LoginProvider] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](450) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[LoginProvider] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AssignmentFiles]    Script Date: 3/27/2025 11:49:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AssignmentFiles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FileName] [nvarchar](max) NOT NULL,
	[FilePath] [nvarchar](max) NOT NULL,
	[AssignmentId] [int] NOT NULL,
	[UploadDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_AssignmentFiles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Assignments]    Script Date: 3/27/2025 11:49:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Assignments](
	[AssignmentID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Detail] [nvarchar](max) NOT NULL,
	[DueDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Assignments] PRIMARY KEY CLUSTERED 
(
	[AssignmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 3/27/2025 11:49:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](30) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 3/27/2025 11:49:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[OrderDetailId] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NOT NULL,
	[OrderId] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[UserId] [nvarchar](450) NOT NULL,
	[Username] [nvarchar](max) NULL,
 CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[OrderDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 3/27/2025 11:49:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[CreditNumber] [int] NOT NULL,
	[ExpirationDate] [int] NOT NULL,
	[CVC] [int] NOT NULL,
	[Phone] [nvarchar](max) NULL,
	[Address] [nvarchar](max) NULL,
	[OrderTotal] [decimal](18, 2) NOT NULL,
	[OrderPlaced] [datetime2](7) NOT NULL,
	[Email] [nvarchar](max) NULL,
	[UserId] [nvarchar](450) NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 3/27/2025 11:49:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[Detail] [nvarchar](max) NULL,
	[ImageUrl] [nvarchar](max) NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[IsTrendingProduct] [bit] NOT NULL,
	[CategoryId] [int] NOT NULL,
	[UserId] [nvarchar](max) NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ShoppingCartItems]    Script Date: 3/27/2025 11:49:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShoppingCartItems](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NULL,
	[Qty] [int] NOT NULL,
	[ShoppingCartId] [nvarchar](max) NULL,
 CONSTRAINT [PK_ShoppingCartItems] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserAssignments]    Script Date: 3/27/2025 11:49:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserAssignments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](450) NOT NULL,
	[AssignmentId] [int] NOT NULL,
	[IsSubmitted] [bit] NOT NULL,
	[SubmissionDate] [datetime2](7) NULL,
	[Score] [int] NULL,
	[UserAnswer] [nvarchar](max) NULL,
	[Feedback] [nvarchar](max) NULL,
	[IsGraded] [bit] NOT NULL,
 CONSTRAINT [PK_UserAssignments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20250325190717_init', N'7.0.11')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20250327180200_AddUserAssignmentFeedbackAndGradedFields', N'7.0.11')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20250327181137_AddUserIdAndEmailToOrder', N'7.0.11')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20250327185252_updated', N'7.0.11')
GO
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'1F31941B-9E30-40EF-B36E-86C8B4448584', N'User', N'USER', N'3')
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'2EEBDDA7-75A2-403E-80A1-2ABE5E677406', N'Instructor', N'INSTRUCTOR', N'2')
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'BDB88FE1-1EF3-42FB-A8E2-4905366827A2', N'Admin', N'ADMIN', N'1')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'0324B075-1A94-471D-AA37-1F2E90091E28', N'1F31941B-9E30-40EF-B36E-86C8B4448584')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'4b313e71-cae2-4072-be02-dc1ff09d3af1', N'1F31941B-9E30-40EF-B36E-86C8B4448584')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'C29ECF44-6388-45D8-BDF9-D4722284D635', N'1F31941B-9E30-40EF-B36E-86C8B4448584')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'043EC290-43A3-44DD-9B09-FB28E9BEFA3B', N'2EEBDDA7-75A2-403E-80A1-2ABE5E677406')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'76FF27CC-FFF0-45EF-B5B4-9C037DA81F71', N'2EEBDDA7-75A2-403E-80A1-2ABE5E677406')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'190a7819-bac6-447a-b553-e30459274945', N'BDB88FE1-1EF3-42FB-A8E2-4905366827A2')
GO
INSERT [dbo].[AspNetUsers] ([Id], [Discriminator], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'0324B075-1A94-471D-AA37-1F2E90091E28', N'ApplicationUser', N'student2@example.com', N'STUDENT2@EXAMPLE.COM', N'student2@example.com', N'STUDENT2@EXAMPLE.COM', 1, N'AQAAAAIAAYagAAAAEPVf5Q2Z9dZkjOsLHxkoI3CiwfwXyWCUqz8Hm+ZzTj9pPxFNTKISMSgJvScV+Pnb9w==', N'VVPCRDAS3MJWQD5CSW2GWPRADBXLWVZR', N'38af4fd7-2afa-4dc6-b550-e00c1bdc931e', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [Discriminator], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'043EC290-43A3-44DD-9B09-FB28E9BEFA3B', N'ApplicationUser', N'instructor1@example.com', N'INSTRUCTOR1@EXAMPLE.COM', N'instructor1@example.com', N'INSTRUCTOR1@EXAMPLE.COM', 1, N'AQAAAAIAAYagAAAAEHJpZeaa/6Smpo+37ZyB6QBFTVry/yYOEaB1iFdNF/woJUSTNM7yHzEdmJQCM3R5Mg==', N'VVPCRDAS3MJWQD5CSW2GWPRADBXLWVZO', N'9b8c7ab5-6f89-4f57-b9f6-88a707681973', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [Discriminator], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'190a7819-bac6-447a-b553-e30459274945', N'IdentityUser', N'deneme@admin.com', N'DENEME@ADMIN.COM', N'deneme@admin.com', N'DENEME@ADMIN.COM', 0, N'AQAAAAIAAYagAAAAEKlXmhVlmFmedKndX8y1HhmpOh0Q4ZM18A7jPu66q7ASO3Da110b6/rJoDDJyUHipQ==', N'DOWBXIHJOUXYUHNU3S6XSIVMDRY5PA2H', N'6b5918fd-b5aa-4eef-b6f7-e080f0d9bd21', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [Discriminator], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'4b313e71-cae2-4072-be02-dc1ff09d3af1', N'IdentityUser', N'normal@com', N'NORMAL@COM', N'normal@com', N'NORMAL@COM', 0, N'AQAAAAIAAYagAAAAEHJpZeaa/6Smpo+37ZyB6QBFTVry/yYOEaB1iFdNF/woJUSTNM7yHzEdmJQCM3R5Mg==', N'MB7U3VOQOMZYPWPYFBRNF3GCGS4MCZPQ', N'509abd0c-c04b-471c-a557-e648d31277aa', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [Discriminator], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'76FF27CC-FFF0-45EF-B5B4-9C037DA81F71', N'ApplicationUser', N'instructor2@example.com', N'INSTRUCTOR2@EXAMPLE.COM', N'instructor2@example.com', N'INSTRUCTOR2@EXAMPLE.COM', 1, N'AQAAAAIAAYagAAAAEPVf5Q2Z9dZkjOsLHxkoI3CiwfwXyWCUqz8Hm+ZzTj9pPxFNTKISMSgJvScV+Pnb9w==', N'VVPCRDAS3MJWQD5CSW2GWPRADBXLWVZP', N'18af4fd7-2afa-4dc6-b550-e00c1bdc931c', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [Discriminator], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'C29ECF44-6388-45D8-BDF9-D4722284D635', N'ApplicationUser', N'student1@example.com', N'STUDENT1@EXAMPLE.COM', N'student1@example.com', N'STUDENT1@EXAMPLE.COM', 1, N'AQAAAAIAAYagAAAAEHJpZeaa/6Smpo+37ZyB6QBFTVry/yYOEaB1iFdNF/woJUSTNM7yHzEdmJQCM3R5Mg==', N'VVPCRDAS3MJWQD5CSW2GWPRADBXLWVZQ', N'a8a75b90-4c9e-454f-a3e4-e4a358c678a3', NULL, 0, 0, NULL, 1, 0)
GO
SET IDENTITY_INSERT [dbo].[AssignmentFiles] ON 

INSERT [dbo].[AssignmentFiles] ([Id], [FileName], [FilePath], [AssignmentId], [UploadDate]) VALUES (1, N'mvc_models_tutorial.pdf', N'uploads/assignments/mvc_models_tutorial.pdf', 1, CAST(N'2025-03-27T23:15:21.5233333' AS DateTime2))
INSERT [dbo].[AssignmentFiles] ([Id], [FileName], [FilePath], [AssignmentId], [UploadDate]) VALUES (2, N'view_layout_examples.zip', N'uploads/assignments/view_layout_examples.zip', 2, CAST(N'2025-03-27T23:15:21.5233333' AS DateTime2))
INSERT [dbo].[AssignmentFiles] ([Id], [FileName], [FilePath], [AssignmentId], [UploadDate]) VALUES (3, N'linq_exercises.docx', N'uploads/assignments/linq_exercises.docx', 3, CAST(N'2025-03-27T23:15:21.5233333' AS DateTime2))
INSERT [dbo].[AssignmentFiles] ([Id], [FileName], [FilePath], [AssignmentId], [UploadDate]) VALUES (4, N'nodejs_api_documentation.pdf', N'uploads/assignments/nodejs_api_documentation.pdf', 4, CAST(N'2025-03-27T23:15:21.5233333' AS DateTime2))
SET IDENTITY_INSERT [dbo].[AssignmentFiles] OFF
GO
SET IDENTITY_INSERT [dbo].[Assignments] ON 

INSERT [dbo].[Assignments] ([AssignmentID], [ProductID], [Name], [Detail], [DueDate]) VALUES (1, 1, N'MVC Model Oluşturma', N'ASP.NET Core MVC kullanarak bir blog sistemi için model sınıflarını oluşturun.', CAST(N'2025-04-10T23:15:21.5233333' AS DateTime2))
INSERT [dbo].[Assignments] ([AssignmentID], [ProductID], [Name], [Detail], [DueDate]) VALUES (2, 1, N'View ve Layout Tasarımı', N'Blog sistemi için ana sayfa, blog detay ve kategori sayfalarını tasarlayın.', CAST(N'2025-04-17T23:15:21.5233333' AS DateTime2))
INSERT [dbo].[Assignments] ([AssignmentID], [ProductID], [Name], [Detail], [DueDate]) VALUES (3, 2, N'C# LINQ Sorguları', N'Verilen veri setini LINQ sorguları kullanarak filtreleyin ve manipüle edin.', CAST(N'2025-04-06T23:15:21.5233333' AS DateTime2))
INSERT [dbo].[Assignments] ([AssignmentID], [ProductID], [Name], [Detail], [DueDate]) VALUES (4, 3, N'RESTful API Oluşturma', N'Node.js ve Express.js kullanarak bir kullanıcı yönetim API''si geliştirin.', CAST(N'2025-04-10T23:15:21.5233333' AS DateTime2))
INSERT [dbo].[Assignments] ([AssignmentID], [ProductID], [Name], [Detail], [DueDate]) VALUES (5, 4, N'React Component Geliştirme', N'Yeniden kullanılabilir bir form component''i oluşturun ve validasyon ekleyin.', CAST(N'2025-04-03T23:15:21.5233333' AS DateTime2))
INSERT [dbo].[Assignments] ([AssignmentID], [ProductID], [Name], [Detail], [DueDate]) VALUES (6, 5, N'Veri Görselleştirme Projesi', N'Verilen veri seti üzerinde en az 3 farklı görselleştirme yapın ve bir rapor hazırlayın.', CAST(N'2025-04-17T23:15:21.5233333' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Assignments] OFF
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([Id], [Name], [DisplayOrder]) VALUES (1, N'Web', 1)
INSERT [dbo].[Category] ([Id], [Name], [DisplayOrder]) VALUES (2, N'Backend', 2)
INSERT [dbo].[Category] ([Id], [Name], [DisplayOrder]) VALUES (3, N'Language', 3)
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderDetails] ON 

INSERT [dbo].[OrderDetails] ([OrderDetailId], [ProductId], [OrderId], [Quantity], [Price], [UserId], [Username]) VALUES (1, 1, 1, 1, CAST(299.99 AS Decimal(18, 2)), N'C29ECF44-6388-45D8-BDF9-D4722284D635', N'student1@example.com')
INSERT [dbo].[OrderDetails] ([OrderDetailId], [ProductId], [OrderId], [Quantity], [Price], [UserId], [Username]) VALUES (2, 2, 1, 1, CAST(249.99 AS Decimal(18, 2)), N'C29ECF44-6388-45D8-BDF9-D4722284D635', N'student1@example.com')
INSERT [dbo].[OrderDetails] ([OrderDetailId], [ProductId], [OrderId], [Quantity], [Price], [UserId], [Username]) VALUES (3, 3, 2, 1, CAST(349.99 AS Decimal(18, 2)), N'0324B075-1A94-471D-AA37-1F2E90091E28', N'student2@example.com')
INSERT [dbo].[OrderDetails] ([OrderDetailId], [ProductId], [OrderId], [Quantity], [Price], [UserId], [Username]) VALUES (4, 5, 3, 1, CAST(399.99 AS Decimal(18, 2)), N'C29ECF44-6388-45D8-BDF9-D4722284D635', N'student1@example.com')
SET IDENTITY_INSERT [dbo].[OrderDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([Id], [Name], [CreditNumber], [ExpirationDate], [CVC], [Phone], [Address], [OrderTotal], [OrderPlaced], [Email], [UserId]) VALUES (1, N'Öğrenci 1', 1234567890, 1224, 123, N'5551234567', N'Ankara, Çankaya', CAST(549.98 AS Decimal(18, 2)), CAST(N'2025-03-17T23:15:21.5233333' AS DateTime2), N'student1@example.com', N'C29ECF44-6388-45D8-BDF9-D4722284D635')
INSERT [dbo].[Orders] ([Id], [Name], [CreditNumber], [ExpirationDate], [CVC], [Phone], [Address], [OrderTotal], [OrderPlaced], [Email], [UserId]) VALUES (2, N'Öğrenci 2', 987654321, 625, 456, N'5559876543', N'İstanbul, Kadıköy', CAST(349.99 AS Decimal(18, 2)), CAST(N'2025-03-22T23:15:21.5233333' AS DateTime2), N'student2@example.com', N'0324B075-1A94-471D-AA37-1F2E90091E28')
INSERT [dbo].[Orders] ([Id], [Name], [CreditNumber], [ExpirationDate], [CVC], [Phone], [Address], [OrderTotal], [OrderPlaced], [Email], [UserId]) VALUES (3, N'Öğrenci 1', 1122334455, 325, 789, N'5551234567', N'Ankara, Çankaya', CAST(399.99 AS Decimal(18, 2)), CAST(N'2025-03-25T23:15:21.5233333' AS DateTime2), N'student1@example.com', N'C29ECF44-6388-45D8-BDF9-D4722284D635')
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([Id], [Name], [Detail], [ImageUrl], [Price], [IsTrendingProduct], [CategoryId], [UserId]) VALUES (1, N'ASP.NET Core MVC Temel Kurs', N'Bu kurs ile ASP.NET Core MVC''nin temellerini öğreneceksiniz. Model, View ve Controller yapılarını, route mekanizmasını ve çok daha fazlasını detaylı şekilde inceleyeceğiz.', N'/images/courses/aspnetcore.jpg', CAST(299.99 AS Decimal(18, 2)), 1, 1, N'043EC290-43A3-44DD-9B09-FB28E9BEFA3B')
INSERT [dbo].[Products] ([Id], [Name], [Detail], [ImageUrl], [Price], [IsTrendingProduct], [CategoryId], [UserId]) VALUES (2, N'C# Programlama Dili', N'C# programlama dilini sıfırdan öğrenin. Nesne yönelimli programlama, LINQ, asenkron programlama ve daha fazlası.', N'/images/courses/csharp.jpg', CAST(249.99 AS Decimal(18, 2)), 1, 3, N'043EC290-43A3-44DD-9B09-FB28E9BEFA3B')
INSERT [dbo].[Products] ([Id], [Name], [Detail], [ImageUrl], [Price], [IsTrendingProduct], [CategoryId], [UserId]) VALUES (3, N'Node.js ile Backend Geliştirme', N'Node.js kullanarak ölçeklenebilir backend uygulamaları geliştirmeyi öğrenin. Express.js, MongoDB, RESTful API tasarımı konularını işleyeceğiz.', N'/images/courses/nodejs.jpg', CAST(349.99 AS Decimal(18, 2)), 0, 2, N'76FF27CC-FFF0-45EF-B5B4-9C037DA81F71')
INSERT [dbo].[Products] ([Id], [Name], [Detail], [ImageUrl], [Price], [IsTrendingProduct], [CategoryId], [UserId]) VALUES (4, N'React.js Temelleri', N'Modern web uygulamaları geliştirmek için React kütüphanesini öğrenin. Component yapısı, state yönetimi, hooks ve daha fazlası.', N'/images/courses/reactjs.jpg', CAST(279.99 AS Decimal(18, 2)), 1, 1, N'76FF27CC-FFF0-45EF-B5B4-9C037DA81F71')
INSERT [dbo].[Products] ([Id], [Name], [Detail], [ImageUrl], [Price], [IsTrendingProduct], [CategoryId], [UserId]) VALUES (5, N'Python ile Veri Analizi', N'Python programlama dili kullanarak veri analizi yapmayı öğrenin. Pandas, NumPy, Matplotlib kütüphaneleri ile veri manipülasyonu ve görselleştirme.', N'/images/courses/python.jpg', CAST(399.99 AS Decimal(18, 2)), 1, 5, N'043EC290-43A3-44DD-9B09-FB28E9BEFA3B')
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[ShoppingCartItems] ON 

INSERT [dbo].[ShoppingCartItems] ([Id], [ProductId], [Qty], [ShoppingCartId]) VALUES (1, 4, 1, N'tempshoppingcart-123')
INSERT [dbo].[ShoppingCartItems] ([Id], [ProductId], [Qty], [ShoppingCartId]) VALUES (2, 5, 1, N'tempshoppingcart-456')
INSERT [dbo].[ShoppingCartItems] ([Id], [ProductId], [Qty], [ShoppingCartId]) VALUES (3, 3, 1, N'f3183a42-aa54-4de7-9fe9-a8bb5fddd92b')
SET IDENTITY_INSERT [dbo].[ShoppingCartItems] OFF
GO
SET IDENTITY_INSERT [dbo].[UserAssignments] ON 

INSERT [dbo].[UserAssignments] ([Id], [UserId], [AssignmentId], [IsSubmitted], [SubmissionDate], [Score], [UserAnswer], [Feedback], [IsGraded]) VALUES (1, N'C29ECF44-6388-45D8-BDF9-D4722284D635', 1, 1, CAST(N'2025-03-22T23:15:21.5233333' AS DateTime2), 85, N'MVC model sınıflarım: BlogPost, Category, Comment. BlogPost sınıfı: Id, Title, Content, PublishDate, AuthorId, CategoryId özellikleri içerir. İlişkiler: BlogPost-Category (çoka-bir), BlogPost-Comment (bire-çok).', N'İyi çalışma, model ilişkileri doğru kurulmuş. Navigation property''leri de ekleyebilirdiniz.', 1)
INSERT [dbo].[UserAssignments] ([Id], [UserId], [AssignmentId], [IsSubmitted], [SubmissionDate], [Score], [UserAnswer], [Feedback], [IsGraded]) VALUES (2, N'C29ECF44-6388-45D8-BDF9-D4722284D635', 2, 1, CAST(N'2025-03-26T23:15:21.5233333' AS DateTime2), NULL, N'View ve Layout tasarımları ekteki dosyalarda yer almaktadır. Bootstrap ve özel CSS kullanarak responsive bir tasarım oluşturdum.', NULL, 0)
INSERT [dbo].[UserAssignments] ([Id], [UserId], [AssignmentId], [IsSubmitted], [SubmissionDate], [Score], [UserAnswer], [Feedback], [IsGraded]) VALUES (3, N'0324B075-1A94-471D-AA37-1F2E90091E28', 4, 1, CAST(N'2025-03-24T23:15:21.5233333' AS DateTime2), 92, N'Node.js ve Express kullanarak kullanıcı API''si geliştirdim. CRUD işlemleri, JWT authentication, ve MongoDB entegrasyonu içermektedir. Kodlar GitHub reposunda: github.com/student2/nodejs-api', N'Mükemmel çalışma. Authentication güvenli şekilde implemente edilmiş ve dokümantasyon çok iyi.', 1)
INSERT [dbo].[UserAssignments] ([Id], [UserId], [AssignmentId], [IsSubmitted], [SubmissionDate], [Score], [UserAnswer], [Feedback], [IsGraded]) VALUES (4, N'C29ECF44-6388-45D8-BDF9-D4722284D635', 3, 0, NULL, NULL, N'', NULL, 0)
SET IDENTITY_INSERT [dbo].[UserAssignments] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetRoleClaims_RoleId]    Script Date: 3/27/2025 11:49:23 PM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetRoleClaims_RoleId] ON [dbo].[AspNetRoleClaims]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [RoleNameIndex]    Script Date: 3/27/2025 11:49:23 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]
(
	[NormalizedName] ASC
)
WHERE ([NormalizedName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetUserClaims_UserId]    Script Date: 3/27/2025 11:49:23 PM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserClaims_UserId] ON [dbo].[AspNetUserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetUserLogins_UserId]    Script Date: 3/27/2025 11:49:23 PM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserLogins_UserId] ON [dbo].[AspNetUserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetUserRoles_RoleId]    Script Date: 3/27/2025 11:49:23 PM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserRoles_RoleId] ON [dbo].[AspNetUserRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [EmailIndex]    Script Date: 3/27/2025 11:49:23 PM ******/
CREATE NONCLUSTERED INDEX [EmailIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UserNameIndex]    Script Date: 3/27/2025 11:49:23 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedUserName] ASC
)
WHERE ([NormalizedUserName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_AssignmentFiles_AssignmentId]    Script Date: 3/27/2025 11:49:23 PM ******/
CREATE NONCLUSTERED INDEX [IX_AssignmentFiles_AssignmentId] ON [dbo].[AssignmentFiles]
(
	[AssignmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Assignments_ProductID]    Script Date: 3/27/2025 11:49:23 PM ******/
CREATE NONCLUSTERED INDEX [IX_Assignments_ProductID] ON [dbo].[Assignments]
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_OrderDetails_OrderId]    Script Date: 3/27/2025 11:49:23 PM ******/
CREATE NONCLUSTERED INDEX [IX_OrderDetails_OrderId] ON [dbo].[OrderDetails]
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_OrderDetails_ProductId]    Script Date: 3/27/2025 11:49:23 PM ******/
CREATE NONCLUSTERED INDEX [IX_OrderDetails_ProductId] ON [dbo].[OrderDetails]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_OrderDetails_UserId]    Script Date: 3/27/2025 11:49:23 PM ******/
CREATE NONCLUSTERED INDEX [IX_OrderDetails_UserId] ON [dbo].[OrderDetails]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Orders_UserId]    Script Date: 3/27/2025 11:49:23 PM ******/
CREATE NONCLUSTERED INDEX [IX_Orders_UserId] ON [dbo].[Orders]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Products_CategoryId]    Script Date: 3/27/2025 11:49:23 PM ******/
CREATE NONCLUSTERED INDEX [IX_Products_CategoryId] ON [dbo].[Products]
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ShoppingCartItems_ProductId]    Script Date: 3/27/2025 11:49:23 PM ******/
CREATE NONCLUSTERED INDEX [IX_ShoppingCartItems_ProductId] ON [dbo].[ShoppingCartItems]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserAssignments_AssignmentId]    Script Date: 3/27/2025 11:49:23 PM ******/
CREATE NONCLUSTERED INDEX [IX_UserAssignments_AssignmentId] ON [dbo].[UserAssignments]
(
	[AssignmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_UserAssignments_UserId]    Script Date: 3/27/2025 11:49:23 PM ******/
CREATE NONCLUSTERED INDEX [IX_UserAssignments_UserId] ON [dbo].[UserAssignments]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AssignmentFiles] ADD  DEFAULT ('0001-01-01T00:00:00.0000000') FOR [UploadDate]
GO
ALTER TABLE [dbo].[UserAssignments] ADD  DEFAULT (CONVERT([bit],(0))) FOR [IsGraded]
GO
ALTER TABLE [dbo].[AspNetRoleClaims]  WITH NOCHECK ADD  CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetRoleClaims] CHECK CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH NOCHECK ADD  CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH NOCHECK ADD  CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH NOCHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH NOCHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserTokens]  WITH NOCHECK ADD  CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserTokens] CHECK CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AssignmentFiles]  WITH NOCHECK ADD  CONSTRAINT [FK_AssignmentFiles_Assignments_AssignmentId] FOREIGN KEY([AssignmentId])
REFERENCES [dbo].[Assignments] ([AssignmentID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AssignmentFiles] CHECK CONSTRAINT [FK_AssignmentFiles_Assignments_AssignmentId]
GO
ALTER TABLE [dbo].[Assignments]  WITH NOCHECK ADD  CONSTRAINT [FK_Assignments_Products_ProductID] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Assignments] CHECK CONSTRAINT [FK_Assignments_Products_ProductID]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH NOCHECK ADD  CONSTRAINT [FK_OrderDetails_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH NOCHECK ADD  CONSTRAINT [FK_OrderDetails_Orders_OrderId] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Orders_OrderId]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH NOCHECK ADD  CONSTRAINT [FK_OrderDetails_Products_ProductId] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Products_ProductId]
GO
ALTER TABLE [dbo].[Orders]  WITH NOCHECK ADD  CONSTRAINT [FK_Orders_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[Products]  WITH NOCHECK ADD  CONSTRAINT [FK_Products_Category_CategoryId] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Category_CategoryId]
GO
ALTER TABLE [dbo].[ShoppingCartItems]  WITH NOCHECK ADD  CONSTRAINT [FK_ShoppingCartItems_Products_ProductId] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[ShoppingCartItems] CHECK CONSTRAINT [FK_ShoppingCartItems_Products_ProductId]
GO
ALTER TABLE [dbo].[UserAssignments]  WITH NOCHECK ADD  CONSTRAINT [FK_UserAssignments_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserAssignments] CHECK CONSTRAINT [FK_UserAssignments_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[UserAssignments]  WITH NOCHECK ADD  CONSTRAINT [FK_UserAssignments_Assignments_AssignmentId] FOREIGN KEY([AssignmentId])
REFERENCES [dbo].[Assignments] ([AssignmentID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserAssignments] CHECK CONSTRAINT [FK_UserAssignments_Assignments_AssignmentId]
GO
USE [master]
GO
ALTER DATABASE [JustLearnDB] SET  READ_WRITE 
GO
