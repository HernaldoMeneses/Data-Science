USE [powerbi]
GO

/****** Object:  Table [dbo].[Dim_CarteiraCliente]    Script Date: 13/10/2023 15:41:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Dim_CarteiraCliente]') AND type in (N'U'))
DROP TABLE [dbo].[Dim_CarteiraCliente]
GO

/****** Object:  Table [dbo].[Dim_CarteiraCliente]    Script Date: 13/10/2023 15:41:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Dim_CarteiraCliente](
	[CodigoRCA] [int] NULL,
	[Rca] [varchar](100) NULL,
	[CodigoCliente] [int] NULL,
	[Cliente] [varchar](100) NULL,
	[TipoVinculo] [varchar](50) NULL
) ON [PRIMARY]
GO