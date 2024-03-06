SELECT 
PCLANC.RECNUM AS NUMEROLANCAMENTO, 
PCLANC.HISTORICO, 
PCLANC.HISTORICO2,
PCLANC.DUPLIC AS PRESTACAO, 
PCLANC.LOCALIZACAO,
PCLANC.INDICE,
PCLANC.NUMCHEQUE AS NUMEROCHEQUE,
PCLANC.NUMBORDERO AS NUMEROBORDERO,
PCLANC.TIPOPAGTO AS TIPOPAGAMENTO,
DECODE (PCLANC.DTPAGTO, NULL, 'ABERTO', 'PAGO') AS SITUACAO,
PCLANC.CODROTINABAIXA AS CODIGOROTINABAIXA,
PCLANC.TIPOLANC AS TIPOLANCAMENTO,
PCLANC.PRORROG AS DIASPRORROGACAO,


CASE WHEN PCLANC.TIPOPARCEIRO = 'C' THEN 'CLIENTE'
     WHEN PCLANC.TIPOPARCEIRO = 'R' THEN 'RCA'
     WHEN PCLANC.TIPOPARCEIRO = 'F' THEN 'FORNECEDOR'
     WHEN PCLANC.TIPOPARCEIRO = 'M' THEN 'MOTORISTA'
     ELSE 'OUTROS' END AS TIPOPARCEIRO,


CASE WHEN PCLANC.TIPOPARCEIRO = 'C' THEN (SELECT CLI.CLIENTE FROM PCCLIENT CLI WHERE PCLANC.CODFORNEC = CLI.CODCLI) 
     WHEN PCLANC.TIPOPARCEIRO = 'R' THEN (SELECT USU.NOME FROM PCUSUARI USU WHERE PCLANC.CODFORNEC = USU.CODUSUR)
     WHEN PCLANC.TIPOPARCEIRO = 'F' THEN (SELECT FORN.FORNECEDOR FROM PCFORNEC FORN WHERE PCLANC.CODFORNEC  = FORN.CODFORNEC)
     WHEN PCLANC.TIPOPARCEIRO = 'M' THEN (SELECT EMP.NOME FROM PCEMPR EMP WHERE PCLANC.CODFORNEC = EMP.MATRICULA)
     ELSE 'OUTRO'
END PARCEIRO    









FROM PCLANC
  WHERE TO_CHAR(PCLANC.DTVENC, 'YYYY') >= TO_CHAR(ADD_MONTHS(SYSDATE, -132), 'YYYY')