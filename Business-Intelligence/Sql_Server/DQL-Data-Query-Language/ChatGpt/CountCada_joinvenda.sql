USE [powerbi]
GO

SELECT
	CODFORNEC,
    CODRCA,
    COUNT(CODCLI) AS TotalClientes,
    SUM(VENDA) AS TotalVendas,
    SUM(CASE WHEN VENDA >= 50 THEN 1 ELSE 0 END) AS TotalVendasMaiorIgualA50,
	COUNT(TotCliCadAtivo) As TOtCliCadAtivo
FROM (
SELECT
	FV.[CODFORNEC] as CODFORNEC,
    FV.[CODUSUR] AS CODRCA,
	FV.[CODCLI] AS CODCLI,
	COUNT(DISTINCT FV.[CODPROD]) AS TotalProdutos,
	SUM(FV.[QTCLIENTE]) AS QTClI,
	SubConsulta.[TotalRegistros] AS TotCliCadAtivo,
	SUM(FV.[QTCLIENTE])/SubConsulta.[TotalRegistros]*100 AS PercBase,
	SUM(FV.[VLVENDA]) AS VENDA   
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
GROUP BY
	FV.[CODFORNEC]
	, FV.[CODUSUR]
	, FV.[CODCLI] 
	, SubConsulta.[TotalRegistros]
	) AS SubSelect
GROUP BY 
	CODFORNEC
	, CODRCA
GO
