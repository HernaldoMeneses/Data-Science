SELECT 
PCNFSAID.NUMTRANSVENDA AS NUMEROTRANSACAOVENDA,
PCNFSAID.NUMPED AS NUMEROPEDIDO,
PCMOV.CODPROD AS CODIGOPRODUTO,
PCMOV.CODUSUR AS CODIGORCA,
PCMOV.CODCLI AS CODIGOCLIENTE,
PCMOV.CODFILIAL AS CODIGOFILIAL,
PCMOV.CODPLPAG AS CODIGOPLANOPAGAMENTO,
PCNFSAID.CODCOB AS CODIGOCOBRANCA,
PCMOV.DTMOV AS DATAFATURAMENTO,
TRUNC(PCNFSAID.DTCANCEL) AS DATACANCELAMENTO,
CAST( ROUND(PCNFSAID.DTCANCEL - PCMOV.DTMOV, 0) AS NUMERIC(18,6)) AS DIFERENCADIAS,
PCMOV.QT AS QUANTIDADE,
PCMOV.PUNIT AS VALORUNITARIO
FROM PCNFSAID,
       PCMOV,
       PCCLIENT,
       PCUSUARI,
       PCPRODUT,
       PCFILIAL

 WHERE PCNFSAID.NUMTRANSVENDA = PCMOV.NUMTRANSVENDA
   AND PCMOV.CODCLI = PCCLIENT.CODCLI
   AND PCMOV.CODUSUR = PCUSUARI.CODUSUR
   AND PCMOV.CODPROD = PCPRODUT.CODPROD
   AND PCMOV.CODFILIAL = PCFILIAL.CODIGO
   AND PCNFSAID.DTCANCEL IS NOT NULL
   AND PCMOV.QT > 0
   AND TO_CHAR(PCMOV.DTMOV , 'YYYY') >= TO_CHAR(ADD_MONTHS(SYSDATE, -36), 'YYYY')