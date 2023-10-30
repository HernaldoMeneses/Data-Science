USE [powerbi]
GO

ALTER TABLE [dbo].[Fato_Compra] DROP CONSTRAINT [DF_Fato_Compra_VolumeUnitario]
GO

ALTER TABLE [dbo].[Fato_Compra] DROP CONSTRAINT [DF_Fato_Compra_PesoUnitarioLiquido]
GO

ALTER TABLE [dbo].[Fato_Compra] DROP CONSTRAINT [DF_Fato_Compra_PesoUnitarioBruto]
GO

ALTER TABLE [dbo].[Fato_Compra] DROP CONSTRAINT [DF_Fato_Compra_ValorUnitarioDesconto]
GO

ALTER TABLE [dbo].[Fato_Compra] DROP CONSTRAINT [DF_Fato_Compra_ValorUnitarioCusto]
GO

ALTER TABLE [dbo].[Fato_Compra] DROP CONSTRAINT [DF_Fato_Compra_ValorUnitarioTabela]
GO

ALTER TABLE [dbo].[Fato_Compra] DROP CONSTRAINT [DF_Fato_Compra_ValorUnitario]
GO

ALTER TABLE [dbo].[Fato_Compra] DROP CONSTRAINT [DF_Fato_Compra_Quantidade]
GO

/****** Object:  Table [dbo].[Fato_Compra]    Script Date: 30/10/2023 11:27:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Fato_Compra]') AND type in (N'U'))
DROP TABLE [dbo].[Fato_Compra]
GO

/****** Object:  Table [dbo].[Fato_Compra]    Script Date: 30/10/2023 11:27:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Fato_Compra](
	[NumeroTransacaoEntrada] [numeric](10, 0) NULL,
	[CodigoProduto] [int] NULL,
	[CodigoFornecedor] [int] NULL,
	[CodigoFilial] [varchar](4) NULL,
	[NumeroNota] [numeric](10, 0) NULL,
	[DataEntrada] [datetime] NULL,
	[DataMovimentacao] [datetime] NULL,
	[Quantidade] [numeric](18, 6) NULL,
	[ValorUnitario] [numeric](18, 6) NULL,
	[ValorUnitarioTabela] [numeric](18, 6) NULL,
	[ValorUnitarioCusto] [numeric](18, 6) NULL,
	[ValorUnitarioDesconto] [numeric](18, 6) NULL,
	[PesoUnitarioBruto] [numeric](18, 6) NULL,
	[PesoUnitarioLiquido] [numeric](18, 6) NULL,
	[VolumeUnitario] [numeric](18, 6) NULL,
	[ValorTotal]  AS ([Quantidade]*[ValorUnitario]),
	[ValorTotalTabela]  AS ([Quantidade]*[ValorUnitarioTabela]),
	[ValorTotalCusto]  AS ([Quantidade]*[ValorUnitarioCusto]),
	[ValorTotalDesconto]  AS ([Quantidade]*[ValorUnitarioDesconto]),
	[PesoTotalBruto]  AS ([Quantidade]*[PesoUnitarioBruto]),
	[PesoTotalLiquido]  AS ([Quantidade]*[PesoUnitarioLiquido]),
	[VolumeTotal]  AS ([Quantidade]*[VolumeUnitario]),
	[PercentualDesconto] [numeric](18, 6) NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Fato_Compra] ADD  CONSTRAINT [DF_Fato_Compra_Quantidade]  DEFAULT ((0)) FOR [Quantidade]
GO

ALTER TABLE [dbo].[Fato_Compra] ADD  CONSTRAINT [DF_Fato_Compra_ValorUnitario]  DEFAULT ((0)) FOR [ValorUnitario]
GO

ALTER TABLE [dbo].[Fato_Compra] ADD  CONSTRAINT [DF_Fato_Compra_ValorUnitarioTabela]  DEFAULT ((0)) FOR [ValorUnitarioTabela]
GO

ALTER TABLE [dbo].[Fato_Compra] ADD  CONSTRAINT [DF_Fato_Compra_ValorUnitarioCusto]  DEFAULT ((0)) FOR [ValorUnitarioCusto]
GO

ALTER TABLE [dbo].[Fato_Compra] ADD  CONSTRAINT [DF_Fato_Compra_ValorUnitarioDesconto]  DEFAULT ((0)) FOR [ValorUnitarioDesconto]
GO

ALTER TABLE [dbo].[Fato_Compra] ADD  CONSTRAINT [DF_Fato_Compra_PesoUnitarioBruto]  DEFAULT ((0)) FOR [PesoUnitarioBruto]
GO

ALTER TABLE [dbo].[Fato_Compra] ADD  CONSTRAINT [DF_Fato_Compra_PesoUnitarioLiquido]  DEFAULT ((0)) FOR [PesoUnitarioLiquido]
GO

ALTER TABLE [dbo].[Fato_Compra] ADD  CONSTRAINT [DF_Fato_Compra_VolumeUnitario]  DEFAULT ((0)) FOR [VolumeUnitario]
GO

