SELECT

CEN.CODIGOCENTROCUSTO AS CODIGOCENTROCUSTO,
CEN.DESCRICAO AS CENTROCUSTO,
CEN.ATIVO AS ATIVO,
CEN.RECEBE_LANCTO AS RECEBELANCAMENTO,
PCLANC.RECNUM AS NUMEROLANCAMENTO

FROM PCRATEIOCENTROCUSTO RATEIO
LEFT JOIN PCCENTROCUSTO CEN ON CEN.CODIGOCENTROCUSTO = RATEIO.CODIGOCENTROCUSTO
LEFT JOIN PCLANC ON RATEIO.RECNUM = PCLANC.RECNUM