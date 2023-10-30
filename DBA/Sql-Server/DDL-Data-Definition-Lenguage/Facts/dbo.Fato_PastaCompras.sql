USE [powerbi]
GO

/****** Object:  Table [dbo].[Fato_PastaCompras]    Script Date: 30/10/2023 11:32:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Fato_PastaCompras]') AND type in (N'U'))
DROP TABLE [dbo].[Fato_PastaCompras]
GO

/****** Object:  Table [dbo].[Fato_PastaCompras]    Script Date: 30/10/2023 11:32:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Fato_PastaCompras](
	[PASTA] [int] NULL,
	[codfornec] [int] NULL
) ON [PRIMARY]
GO


