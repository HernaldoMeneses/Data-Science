SELECT  
  '10-SALDO ADIANTAMENTO FORNECEDOR' AS INDICADOR,
  PCFINANC.CODFILIAL AS CODIGOFILIAL,
  DATA+1 AS DATAINICIAL,
  DATA AS DATAFINAL,
  PCFINANC.SALDOADIANTFOR AS SALDO
FROM PCFINANC
WHERE TO_CHAR(PCFINANC.DATA, 'YYYY') >= TO_CHAR(SYSDATE, 'YYYY') - 8