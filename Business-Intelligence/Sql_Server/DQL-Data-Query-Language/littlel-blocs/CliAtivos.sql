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
GROUP BY 