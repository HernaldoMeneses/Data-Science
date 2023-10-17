USE [powerbi]
GO

/****** Object:  Table [dbo].[fato_Venda324I]    Script Date: 17/10/2023 09:55:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fato_Venda324I]') AND type in (N'U'))
DROP TABLE [dbo].[fato_Venda324I]
GO

/****** Object:  Table [dbo].[fato_Venda324I]    Script Date: 17/10/2023 09:55:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[fato_Venda324I](
	[CODSUPERVISOR] [numeric](4, 0) NULL,
	[CODGERENTE] [numeric](4, 0) NULL,
	[POSICAO] [nvarchar](2) NULL,
	[DATA] [date] NULL,
	[CODUSUR] [numeric](4, 0) NULL,
	[CODFILIAL] [numeric](2, 0) NULL,
	[CODEPTO] [numeric](6, 0) NULL,
	[CODFORNEC] [int] NULL,
	[CODPROD] [numeric](12, 0) NULL,
	[CODCLI] [numeric](12, 0) NULL,
	[VLVENDA] [numeric](12, 2) NULL,
	[VLCUSTOFIN] [numeric](12, 2) NULL,
	[QT] [numeric](12, 0) NULL,
	[QTBNF] [numeric](12, 0) NULL,
	[QTCLIENTE] [numeric](12, 0) NULL,
	[PESO] [numeric](12, 6) NULL,
	[QTPED] [numeric](12, 0) NULL,
	[VLBONIFIC] [numeric](12, 2) NULL
) ON [PRIMARY]
GO