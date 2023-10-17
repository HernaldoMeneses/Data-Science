SELECT
        DCC.[CodigoRCA],
        COUNT(*) AS TotalRegistros
    FROM [dbo].[Dim_CarteiraCliente] AS DCC
    JOIN [dbo].[Dim_Cliente] AS DC ON DCC.[CodigoCliente] = DC.[CodigoCliente]
    WHERE DC.[Status] = 'ATIVO'
	AND DCC.[CodigoRCA] = 982
    GROUP BY DCC.[CodigoRCA]