USE [powerbi]
GO

SELECT [CodigoCliente]
      ,[Cliente]
      ,[CPFCNPJ]
      ,[TipoCliente]
      ,[CodigoIBGE]
      ,[Bairro]
      ,[CEP]
      ,[Endereco]
      ,[NomeFantasia]
      ,[Classe]
      ,[Classificacao]
      ,[EmailCliente]
      ,[CodigoRamoAtividade]
      ,[RamoAtividade]
      ,[Grupo]
      ,[Praca]
      ,[CodigoRota]
      ,[Rota]
      ,[CodigoRede]
      ,[Rede]
      ,[Regiao]
      ,[UFRegiao]
      ,[NomeFantasiaClientePrincipal]
      ,[ClientePrincipal]
      ,[Status]
      ,[DiasInativos]
  FROM [dbo].[Dim_Cliente]

GO


