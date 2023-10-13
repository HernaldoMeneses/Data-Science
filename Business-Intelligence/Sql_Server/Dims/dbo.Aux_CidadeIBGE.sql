USE [powerbi]
GO

/****** Object:  Table [dbo].[Aux_CidadeIBGE]    Script Date: 13/10/2023 15:52:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Aux_CidadeIBGE]') AND type in (N'U'))
DROP TABLE [dbo].[Aux_CidadeIBGE]
GO

/****** Object:  Table [dbo].[Aux_CidadeIBGE]    Script Date: 13/10/2023 15:52:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Aux_CidadeIBGE](
	[CodigoIBGE] [varchar](50) NULL,
	[Cidade] [varchar](120) NULL,
	[UF] [varchar](2) NULL,
	[Estado] [varchar](120) NULL,
	[Populacao] [numeric](18, 0) NULL,
	[Area] [numeric](18, 6) NULL,
	[Regiao] [varchar](50) NULL
) ON [PRIMARY]
GO