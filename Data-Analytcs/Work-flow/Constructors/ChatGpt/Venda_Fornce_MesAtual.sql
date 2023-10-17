USE [powerbi]
GO

SELECT [CODSUPERVISOR]
      ,[CODGERENTE]
      ,[POSICAO]
      ,[DATA]
      ,[CODUSUR]
      ,[CODFILIAL]
      ,[CODEPTO]
      ,[CODFORNEC]
      ,[CODPROD]
      ,[CODCLI]
      ,[VLVENDA]
      ,[VLCUSTOFIN]
      ,[QT]
      ,[QTBNF]
      ,[QTCLIENTE]
      ,[PESO]
      ,[QTPED]
      ,[VLBONIFIC]
  FROM [dbo].[fato_Venda324I]
WHERE [CODFORNEC] = 3309
  AND MONTH([DATA]) = MONTH(GETDATE()) 
  AND YEAR([DATA]) = YEAR(GETDATE())
