SELECT  
  '1-SALDO CAIXA' AS INDICADOR,
  PCFINANC.CODFILIAL AS CODIGOFILIAL,
  DATA+1 AS DATAINICIAL,
  DATA AS DATAFINAL,
  PCFINANC.SALDOCX AS SALDO
FROM PCFINANC
WHERE TO_CHAR(PCFINANC.DATA, 'YYYY') >= TO_CHAR(SYSDATE, 'YYYY') - 2