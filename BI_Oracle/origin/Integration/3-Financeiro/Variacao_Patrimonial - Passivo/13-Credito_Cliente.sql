SELECT  
  '13-CREDITO CLIENTE' AS INDICADOR,
  PCFINANC.CODFILIAL AS CODIGOFILIAL,
  DATA+1 AS DATAINICIAL,
  DATA AS DATAFINAL,
  PCFINANC.SALDOCREDCLI AS SALDO
FROM     
    PCFINANC
WHERE  TO_CHAR(PCFINANC.DATA, 'YYYY') >= TO_CHAR(SYSDATE, 'YYYY') - 8