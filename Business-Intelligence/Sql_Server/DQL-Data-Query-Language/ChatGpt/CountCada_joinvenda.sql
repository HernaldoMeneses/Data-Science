USE [powerbi]
GO

SELECT
    FV.[CODUSUR] AS CODRCA,
	SUM(FV.[QT]) AS QT,
	SUM(FV.[QTCLIENTE]) AS QTClI,
	SUM(FV.[QTPED]) AS QTPED,
	SUM(FV.[VLVENDA]) AS VENDA,
    COUNT(*) AS TotalRegistros,
    SubConsulta.[TotalRegistros] AS TotCliCadAtivo
FROM [dbo].[fato_Venda324I] AS FV
LEFT JOIN (
    SELECT
        DCC.[CodigoRCA],
        COUNT(*) AS TotalRegistros
    FROM [dbo].[Dim_CarteiraCliente] AS DCC
    JOIN [dbo].[Dim_Cliente] AS DC ON DCC.[CodigoCliente] = DC.[CodigoCliente]
    WHERE DC.[Status] = 'ATIVO'
    GROUP BY DCC.[CodigoRCA]
) AS SubConsulta ON FV.[CODUSUR] = SubConsulta.[CodigoRCA]
WHERE MONTH(FV.[DATA]) = MONTH(GETDATE()) 
    AND YEAR(FV.[DATA]) = YEAR(GETDATE())
    AND FV.[CODFORNEC] = 3309
GROUP BY FV.[CODUSUR], SubConsulta.[TotalRegistros]
ORDER BY TotalRegistros
GO
