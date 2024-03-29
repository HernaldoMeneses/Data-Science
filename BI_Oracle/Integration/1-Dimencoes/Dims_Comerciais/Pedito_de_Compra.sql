SELECT 
PED.NUMPED AS NUMEROPEDIDO,
PED.FRETE,
PED.PALETIZADO,
PED.TIPOEMBALAGEMPEDIDO,
PED.TIPODESCARGA,
PED.TIPOVENC AS TIPOVENCIMENTO,
PED.TIPOBONIFIC AS TIPOBONIFICACAO,
PED.EXPORTADO,
PED.ORCAMENTO
FROM PCPEDIDO PED
WHERE TO_CHAR(PED.DTEMISSAO , 'YYYY') >= TO_CHAR(ADD_MONTHS(SYSDATE, -96), 'YYYY')