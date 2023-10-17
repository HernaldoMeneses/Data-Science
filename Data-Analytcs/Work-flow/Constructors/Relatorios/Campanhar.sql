SELECT 
	TAB1.[CodigoRCA],
	COUNT(TAB1.QTATIVOS)
FROM
	(SELECT
		DCC.[CodigoRCA]
		, DCC.[CodigoCliente]
		, COUNT( DC.[Status]) AS QTATIVOS
		FROM [dbo].[Dim_Cliente] AS DC
		JOIN [dbo].[Dim_CarteiraCliente] AS DCC 
			ON DC.[CodigoCliente] = DCC.[CodigoCliente]
		WHERE DC.[Status] = 'ATIVO'
		GROUP BY 
			DCC.[CodigoRCA]
			, DCC.[CodigoCliente]
	) TAB1



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