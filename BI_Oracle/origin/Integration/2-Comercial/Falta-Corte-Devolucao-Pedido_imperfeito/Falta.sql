SELECT 
FAL.NUMPED AS NUMEROPEDIDO,
PED.NUMTRANSVENDA AS NUMEROTRANSACAOVENDA,
PED.CODFILIAL AS CODIGOFILIAL,
PED.CODUSUR AS CODIGORCA,
PED.CODCLI AS CODIGOCLIENTE,
FAL.CODPROD AS CODIGOPRODUTO,
PED.CODPLPAG AS CODIGOPLANOPAGAMENTO,
PED.CODCOB AS CODIGOCOBRANCA, 
FAL.DATA AS DATAFALTA,
PED.DATA AS DATAVENDA,
FAL.QT AS QUANTIDADE,
FAL.PVENDA AS PRECOVENDAUNITARIO
FROM PCFALTA FAL
INNER JOIN PCPEDC PED ON PED.NUMPED = FAL.NUMPED
WHERE PED.CONDVENDA NOT IN (10)