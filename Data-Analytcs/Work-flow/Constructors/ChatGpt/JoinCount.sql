USE [powerbi]
GO

SELECT
    FV.[CODUSUR] AS CODRCA,
    DCC.[alguma_coluna_da_Dim_CarteiraCliente],
	COUNT(DISTINCT DCC.[CodigoCliente]) AS TotalClientesCAr,
    COUNT(DISTINCT FV.[CODCLI]) AS TotalClientes
FROM [dbo].[fato_Venda324I] AS FV
JOIN [dbo].[Dim_CarteiraCliente] AS DCC ON FV.[CODUSUR] = DCC.[CodigoRCA]
WHERE MONTH(FV.[DATA]) = MONTH(GETDATE()) 
    AND YEAR(FV.[DATA]) = YEAR(GETDATE())
    AND FV.[CODFORNEC] = 3309
GROUP BY FV.[CODUSUR]
        , DCC.[CodigoRCA]
ORDER BY FV.[CODUSUR]
GO
