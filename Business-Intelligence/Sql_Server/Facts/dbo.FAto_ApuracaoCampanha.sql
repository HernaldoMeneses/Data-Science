USE [powerbi]
GO

/****** Object:  Table [dbo].[Fato_ApuracaoCampanha]    Script Date: 13/10/2023 15:49:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Fato_ApuracaoCampanha]') AND type in (N'U'))
DROP TABLE [dbo].[Fato_ApuracaoCampanha]
GO

/****** Object:  Table [dbo].[Fato_ApuracaoCampanha]    Script Date: 13/10/2023 15:49:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Fato_ApuracaoCampanha](
	[CodigoFilial] [varchar](4) NULL,
	[CodigoRCA] [int] NULL,
	[TipoMeta] [varchar](4) NULL,
	[CodigoEntidade] [varchar](20) NULL,
	[Metrica] [varchar](60) NULL,
	[Referencia] [varchar](10) NULL,
	[Data] [datetime] NULL,
	[Previsto] [numeric](18, 6) NULL,
	[Realizado] [numeric](18, 6) NULL,
	[Premio] [numeric](18, 6) NULL
) ON [PRIMARY]
GO
