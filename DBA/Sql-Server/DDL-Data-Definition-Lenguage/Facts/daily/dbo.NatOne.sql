USE [powerbi]
GO

/****** Object:  Table [dbo].[NatOne]    Script Date: 20/10/2023 09:47:53 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NatOne]') AND type in (N'U'))
DROP TABLE [dbo].[NatOne]
GO

/****** Object:  Table [dbo].[NatOne]    Script Date: 20/10/2023 09:47:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[NatOne](
	[CODGERENTE] [int] NULL,
	[CODSUPERVISOR] [int] NULL,
	[CODUSUR] [int] NULL,
	[CODFORNEC] [int] NULL,
	[CODCLI] [int] NULL,
	[VLVENDA] [float] NULL,
	[50++] [float] NULL,
	[QT] [int] NULL,
	[QTCLIENTE] [int] NULL,
	[QTPED] [int] NULL
) ON [PRIMARY]
GO


GO
TRUNCATE TABlE [dbo].[NatOne];
GO