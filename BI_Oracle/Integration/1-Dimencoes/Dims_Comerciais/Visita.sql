SELECT VIS.CODVISITA AS CODIGOVISITA,
VIS.VISITADO,
MOT.DESCRICAO AS DESCRICAO
FROM PCVISITA VIS
INNER JOIN PCMOTVISITA MOT ON MOT.CODMOTIVO = VIS.CODMOTIVO