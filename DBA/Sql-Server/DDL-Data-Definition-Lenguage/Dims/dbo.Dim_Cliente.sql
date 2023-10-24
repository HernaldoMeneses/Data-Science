USE [powerbi]
GO

/****** Object:  Table [dbo].[Dim_Cliente]    Script Date: 13/10/2023 15:42:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Dim_Cliente]') AND type in (N'U'))
DROP TABLE [dbo].[Dim_Cliente]
GO

/****** Object:  Table [dbo].[Dim_Cliente]    Script Date: 13/10/2023 15:42:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Dim_Cliente](
	[CodigoCliente] [int] NOT NULL,
	[Cliente] [varchar](120) NULL,
	[CPFCNPJ] [varchar](80) NULL,
	[TipoCliente] [varchar](40) NULL,
	[CodigoIBGE] [varchar](50) NULL,
	[Bairro] [varchar](80) NULL,
	[CEP] [varchar](50) NULL,
	[Endereco] [varchar](40) NULL,
	[NomeFantasia] [varchar](120) NULL,
	[Classe] [varchar](80) NULL,
	[Classificacao] [varchar](2) NULL,
	[EmailCliente] [varchar](200) NULL,
	[CodigoRamoAtividade] [varchar](20) NULL,
	[RamoAtividade] [varchar](80) NULL,
	[Grupo] [varchar](80) NULL,
	[Praca] [varchar](60) NULL,
	[CodigoRota] [varchar](4) NULL,
	[Rota] [varchar](60) NULL,
	[CodigoRede] [varchar](8) NULL,
	[Rede] [varchar](80) NULL,
	[Regiao] [varchar](60) NULL,
	[UFRegiao] [varchar](2) NULL,
	[NomeFantasiaClientePrincipal] [varchar](120) NULL,
	[ClientePrincipal] [varchar](120) NULL,
	[Status] [varchar](80) NULL,
	[DiasInativos] [varchar](80) NULL
) ON [PRIMARY]
GO