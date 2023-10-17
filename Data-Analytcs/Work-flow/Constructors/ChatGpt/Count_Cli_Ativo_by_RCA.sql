USE [powerbi]
GO

SELECT DCC.[CodigoRCA]
      ,COUNT(DC.[Cliente]) AS QuantidadeClientesAtivos
FROM [dbo].[Dim_CarteiraCliente] DCC
INNER JOIN [dbo].[Dim_Cliente] DC ON DCC.[CodigoCliente] = DC.[CodigoCliente]
WHERE DC.[Status] = 'ATIVO'
GROUP BY DCC.[CodigoRCA]
