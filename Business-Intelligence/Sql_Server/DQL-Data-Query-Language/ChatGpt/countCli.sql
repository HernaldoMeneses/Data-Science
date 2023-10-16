USE [powerbi]
GO

SELECT
    DCC.[CodigoRCA],
    COUNT(*) AS TotalRegistros
FROM [dbo].[Dim_CarteiraCliente] AS DCC
JOIN [dbo].[Dim_Cliente] AS DC ON DCC.[CodigoCliente] = DC.[CodigoCliente]
WHERE DC.[Status] = 'ATIVO'
GROUP BY DCC.[CodigoRCA]
ORDER BY TotalRegistros
GO
