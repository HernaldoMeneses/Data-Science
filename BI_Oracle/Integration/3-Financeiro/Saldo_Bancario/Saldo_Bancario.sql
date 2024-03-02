SELECT 
PCESTCR.CODBANCO AS CODIGOBANCO, 
PCESTCR.CODCOB AS CODIGOCOBRANCA, 
PCBANCO.CODFILIAL AS CODIGOFILIAL,
PCESTCR.VALOR AS SALDO
FROM PCESTCR
INNER JOIN PCBANCO ON PCESTCR.CODBANCO = PCBANCO.CODBANCO               
WHERE   
PCESTCR.CODCOB IN ( 'D', 'APLI')