USE [master]
GO

/****** Object:  Database [BDLoja]     ******/
CREATE DATABASE [BDLoja]
 CONTAINMENT = NONE  
GO

ALTER DATABASE [BDLoja] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [BDLoja] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [BDLoja] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [BDLoja] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [BDLoja] SET ARITHABORT OFF 
GO

ALTER DATABASE [BDLoja] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [BDLoja] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [BDLoja] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [BDLoja] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [BDLoja] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [BDLoja] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [BDLoja] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [BDLoja] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [BDLoja] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [BDLoja] SET  DISABLE_BROKER 
GO

ALTER DATABASE [BDLoja] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [BDLoja] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [BDLoja] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [BDLoja] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [BDLoja] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [BDLoja] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [BDLoja] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [BDLoja] SET RECOVERY SIMPLE 
GO

ALTER DATABASE [BDLoja] SET  MULTI_USER 
GO

ALTER DATABASE [BDLoja] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [BDLoja] SET DB_CHAINING OFF 
GO

ALTER DATABASE [BDLoja] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [BDLoja] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [BDLoja] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [BDLoja] SET QUERY_STORE = OFF
GO

ALTER DATABASE [BDLoja] SET  READ_WRITE 
GO


USE [BDLoja]
GO
/****** Object:  Table [dbo].[Produtos]     ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Produtos](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descricao] [varchar](50) NULL,
	[Quantidade] [decimal](18, 3) NULL,
	[Valor] [decimal](18, 3) NULL,
 CONSTRAINT [PK_Produtos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VendasItens]     ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VendasItens](
	[Pedido] [int] NOT NULL,
	[Produto] [int] NOT NULL,
	[ValUnit] [decimal](18, 0) NULL,
	[QuantProd] [int] NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_VendasItens] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vendas]    ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vendas](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CodCli] [int] NOT NULL,
	[Data] [datetime] NULL,
	[Total] [decimal](18, 0) NULL,
	[Cliente] [varchar](50) NULL,
 CONSTRAINT [PK_Vendas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ContProdVend]     ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ContProdVend] AS
SELECT  Top 10 COUNT(VI.PRODUTO) VENDAS,
	   P.DESCRICAO,
       VI.PRODUTO as IDPRODUTO
FROM VENDAS V
INNER JOIN VENDASITENS  VI ON VI.PEDIDO = V.ID
INNER JOIN PRODUTOS P ON P.ID = VI.PRODUTO
WHERE YEAR(V.DATA) = 2020
GROUP BY VI.PRODUTO,
         P.DESCRICAO
ORDER BY Vendas
 
GO
/****** Object:  Table [dbo].[Clientes]     ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clientes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](100) NULL,
 CONSTRAINT [PK_Clientes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Vendas3MaioresClienteNome]     ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Vendas3MaioresClienteNome] AS
Select T.Nome From(SELECT  Top 3 Sum(Vi.ValUnit) VENDAS,
	   C.Nome
FROM VENDAS V
Inner join VendasItens Vi on Vi.Pedido = V.Id
Inner join Clientes C on C.Id = V.CodCli
WHERE V.Data between '01/04/2020' and '30/06/2020'
Group By C.Nome)T


 
GO
/****** Object:  View [dbo].[Vendas2MaioresClienteValor]     ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Vendas2MaioresClienteValor] AS
SELECT        TOP (2) SUM(Vi.ValUnit) AS VENDAS, C.Nome
FROM            dbo.Vendas AS V INNER JOIN
                         dbo.VendasItens AS Vi ON Vi.Pedido = V.Id INNER JOIN
                         dbo.Clientes AS C ON C.Id = V.CodCli
WHERE        V.Data between '01/04/2020' and '30/06/2020'
GROUP BY C.Nome
GO

SET IDENTITY_INSERT [dbo].[Clientes] ON 

INSERT [dbo].[Clientes] ([Id], [Nome]) VALUES (1, N'Raimundo Nonato')
INSERT [dbo].[Clientes] ([Id], [Nome]) VALUES (2, N'Eudes Gomes')
INSERT [dbo].[Clientes] ([Id], [Nome]) VALUES (3, N'Kelly Oliveira')
INSERT [dbo].[Clientes] ([Id], [Nome]) VALUES (4, N'Francisco Silva')
INSERT [dbo].[Clientes] ([Id], [Nome]) VALUES (5, N'Gilberto Honorato')
SET IDENTITY_INSERT [dbo].[Clientes] OFF

SET IDENTITY_INSERT [dbo].[Produtos] ON 

INSERT [dbo].[Produtos] ([Id], [Descricao], [Quantidade], [Valor]) VALUES (1, N'Arroz', CAST(23.000 AS Decimal(18, 3)), CAST(55.000 AS Decimal(18, 3)))
INSERT [dbo].[Produtos] ([Id], [Descricao], [Quantidade], [Valor]) VALUES (2, N'Macarrão', CAST(12.000 AS Decimal(18, 3)), CAST(45.000 AS Decimal(18, 3)))
INSERT [dbo].[Produtos] ([Id], [Descricao], [Quantidade], [Valor]) VALUES (3, N'Feijão', CAST(10.000 AS Decimal(18, 3)), CAST(56.000 AS Decimal(18, 3)))
INSERT [dbo].[Produtos] ([Id], [Descricao], [Quantidade], [Valor]) VALUES (4, N'Farinha', CAST(12.000 AS Decimal(18, 3)), CAST(3.000 AS Decimal(18, 3)))
INSERT [dbo].[Produtos] ([Id], [Descricao], [Quantidade], [Valor]) VALUES (5, N'Limão', CAST(13.000 AS Decimal(18, 3)), CAST(2.000 AS Decimal(18, 3)))
INSERT [dbo].[Produtos] ([Id], [Descricao], [Quantidade], [Valor]) VALUES (6, N'Melão', CAST(12.000 AS Decimal(18, 3)), CAST(5.000 AS Decimal(18, 3)))
INSERT [dbo].[Produtos] ([Id], [Descricao], [Quantidade], [Valor]) VALUES (7, N'Produto Teste', CAST(12.000 AS Decimal(18, 3)), CAST(12.000 AS Decimal(18, 3)))
INSERT [dbo].[Produtos] ([Id], [Descricao], [Quantidade], [Valor]) VALUES (8, N'Farinha Seca', CAST(2.000 AS Decimal(18, 3)), CAST(9.000 AS Decimal(18, 3)))
INSERT [dbo].[Produtos] ([Id], [Descricao], [Quantidade], [Valor]) VALUES (9, N'Tomilho', CAST(14.000 AS Decimal(18, 3)), CAST(5.000 AS Decimal(18, 3)))
INSERT [dbo].[Produtos] ([Id], [Descricao], [Quantidade], [Valor]) VALUES (10, N'Laranja', CAST(19.000 AS Decimal(18, 3)), CAST(33.000 AS Decimal(18, 3)))
SET IDENTITY_INSERT [dbo].[Produtos] OFF
GO
SET IDENTITY_INSERT [dbo].[Vendas] ON 

INSERT [dbo].[Vendas] ([Id], [CodCli], [Data], [Total], [Cliente]) VALUES (34, 1, CAST(N'2020-06-16T00:00:00.000' AS DateTime), CAST(0 AS Decimal(18, 0)), N'Consumidor')
INSERT [dbo].[Vendas] ([Id], [CodCli], [Data], [Total], [Cliente]) VALUES (35, 3, CAST(N'2020-04-10T00:00:00.000' AS DateTime), CAST(50 AS Decimal(18, 0)), N'Kelly Oliveira')
INSERT [dbo].[Vendas] ([Id], [CodCli], [Data], [Total], [Cliente]) VALUES (36, 3, CAST(N'2020-05-15T00:00:00.000' AS DateTime), CAST(60 AS Decimal(18, 0)), N'Kelly Oliveira')
INSERT [dbo].[Vendas] ([Id], [CodCli], [Data], [Total], [Cliente]) VALUES (37, 2, CAST(N'2020-06-10T00:00:00.000' AS DateTime), CAST(100 AS Decimal(18, 0)), N'Eudes Andrade')
INSERT [dbo].[Vendas] ([Id], [CodCli], [Data], [Total], [Cliente]) VALUES (38, 2, CAST(N'2020-04-15T00:00:00.000' AS DateTime), CAST(50 AS Decimal(18, 0)), N'Eudes Anfrade')
SET IDENTITY_INSERT [dbo].[Vendas] OFF
GO
SET IDENTITY_INSERT [dbo].[VendasItens] ON 

INSERT [dbo].[VendasItens] ([Pedido], [Produto], [ValUnit], [QuantProd], [Id]) VALUES (34, 1, CAST(55 AS Decimal(18, 0)), 2, 1)
INSERT [dbo].[VendasItens] ([Pedido], [Produto], [ValUnit], [QuantProd], [Id]) VALUES (34, 10, CAST(33 AS Decimal(18, 0)), 3, 2)
INSERT [dbo].[VendasItens] ([Pedido], [Produto], [ValUnit], [QuantProd], [Id]) VALUES (34, 10, CAST(33 AS Decimal(18, 0)), 2, 3)
INSERT [dbo].[VendasItens] ([Pedido], [Produto], [ValUnit], [QuantProd], [Id]) VALUES (34, 1, CAST(55 AS Decimal(18, 0)), 1, 4)
INSERT [dbo].[VendasItens] ([Pedido], [Produto], [ValUnit], [QuantProd], [Id]) VALUES (34, 2, CAST(45 AS Decimal(18, 0)), 1, 5)
INSERT [dbo].[VendasItens] ([Pedido], [Produto], [ValUnit], [QuantProd], [Id]) VALUES (34, 2, CAST(56 AS Decimal(18, 0)), 1, 6)
INSERT [dbo].[VendasItens] ([Pedido], [Produto], [ValUnit], [QuantProd], [Id]) VALUES (34, 8, CAST(9 AS Decimal(18, 0)), 1, 7)
INSERT [dbo].[VendasItens] ([Pedido], [Produto], [ValUnit], [QuantProd], [Id]) VALUES (34, 10, CAST(33 AS Decimal(18, 0)), 1, 8)
INSERT [dbo].[VendasItens] ([Pedido], [Produto], [ValUnit], [QuantProd], [Id]) VALUES (34, 10, CAST(33 AS Decimal(18, 0)), 1, 9)
INSERT [dbo].[VendasItens] ([Pedido], [Produto], [ValUnit], [QuantProd], [Id]) VALUES (34, 1, CAST(55 AS Decimal(18, 0)), 1, 10)
INSERT [dbo].[VendasItens] ([Pedido], [Produto], [ValUnit], [QuantProd], [Id]) VALUES (35, 3, CAST(56 AS Decimal(18, 0)), 2, 11)
INSERT [dbo].[VendasItens] ([Pedido], [Produto], [ValUnit], [QuantProd], [Id]) VALUES (36, 3, CAST(56 AS Decimal(18, 0)), 3, 12)
INSERT [dbo].[VendasItens] ([Pedido], [Produto], [ValUnit], [QuantProd], [Id]) VALUES (36, 4, CAST(3 AS Decimal(18, 0)), 2, 13)
INSERT [dbo].[VendasItens] ([Pedido], [Produto], [ValUnit], [QuantProd], [Id]) VALUES (37, 2, CAST(45 AS Decimal(18, 0)), 2, 14)
INSERT [dbo].[VendasItens] ([Pedido], [Produto], [ValUnit], [QuantProd], [Id]) VALUES (38, 4, CAST(60 AS Decimal(18, 0)), 2, 15)
SET IDENTITY_INSERT [dbo].[VendasItens] OFF
GO
ALTER TABLE [dbo].[VendasItens]  WITH CHECK ADD  CONSTRAINT [FK_VendasItens_Vendas] FOREIGN KEY([Pedido])
REFERENCES [dbo].[Vendas] ([Id])
GO
ALTER TABLE [dbo].[VendasItens] CHECK CONSTRAINT [FK_VendasItens_Vendas]
GO
USE [master]
GO
ALTER DATABASE [BDLoja] SET  READ_WRITE 
GO