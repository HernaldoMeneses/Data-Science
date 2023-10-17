
-- Criação da nova tabela com as colunas explicitamente definidas
USE [powerbi]
GO

/****** Object:  Table [dbo].[NaturalOne]    Script Date: 17/10/2023 11:31:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NaturalOne]') AND type in (N'U'))
DROP TABLE [dbo].[NaturalOne]
GO

/****** Object:  Table [dbo].[NaturalOne]    Script Date: 17/10/2023 11:31:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[NaturalOne](
    [CODSUPERVISOR] INT,
    [CODGERENTE] INT,
    [CODUSUR] INT,
    [CODFILIAL] INT,
    [CODFORNEC] INT,
    [CODCLI] INT,
    [TotalVLVENDA] DECIMAL(18, 2), -- Defina o tipo de dados e precisão apropriados
    [QTCLIENTE] INT,
    [QuantidadeVendasVLVENDA] INT
);
INSERT INTO [NaturalOne] ([CODSUPERVISOR], [CODGERENTE], [CODUSUR], [CODFILIAL], [CODFORNEC], [CODCLI], [TotalVLVENDA], [QTCLIENTE], [QuantidadeVendasVLVENDA])
SELECT [CODSUPERVISOR]
      ,[CODGERENTE]
      ,[CODUSUR]
      ,[CODFILIAL]
      ,[CODFORNEC]
      ,[CODCLI]
      ,SUM([VLVENDA]) AS TotalVLVENDA
      ,[QTCLIENTE]
      ,COUNT(CASE WHEN SUM([VLVENDA]) >= 50 THEN [CODUSUR] END) OVER (PARTITION BY [CODCLI]) AS QuantidadeVendasVLVENDA
  FROM [dbo].[fato_Venda324I]
WHERE [CODFORNEC] = 3309
  AND [CODFILIAL] = 2
  AND MONTH([DATA]) = MONTH(GETDATE()) 
  AND YEAR([DATA]) = YEAR(GETDATE())
GROUP BY [CODSUPERVISOR], [CODGERENTE], [CODUSUR], [CODFILIAL], [CODFORNEC], [CODCLI], [QTCLIENTE]
GO
