SELECT  
  '4-SALDO EMPRESTIMO A RECEBER' AS INDICADOR,
  PCFINANC.CODFILIAL AS CODIGOFILIAL,
  DATA+1 AS DATAINICIAL,
  DATA AS DATAFINAL,
  PCFINANC.SALDOEMPRESTATIVO AS SALDO
FROM PCFINANC
WHERE TO_CHAR(PCFINANC.DATA, 'YYYY') >= TO_CHAR(SYSDATE, 'YYYY') - 8