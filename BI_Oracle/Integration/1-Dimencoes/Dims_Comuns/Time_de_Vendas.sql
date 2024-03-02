SELECT RCA.CODUSUR AS CODIGORCA,
RCA.NOME AS RCA,
SUP.CODSUPERVISOR AS CODIGOSUPERVISOR,
SUP.NOME AS SUPERVISOR,
GER.CODGERENTE AS CODIGOGERENTE,
GER.NOMEGERENTE AS GERENTE ,
concat(RCA.CODUSUR, concat(' - ',RCA.NOME)) as "Descricao-Rca",
concat(RCA.CODUSUR, concat(' - ',RCA.NOME)) as "Descricao-Supervisor",
concat(GER.CODGERENTE, concat(' - ',GER.NOMEGERENTE)) as "Descricao-Gerente",
CASE 
WHEN RCA.DTTERMINO IS NULL THEN 'ATIVO'
ELSE 'INATIVO' 
END AS SITUACAO,
CASE RCA.TIPOVEND
    WHEN   'R' THEN 'REPRESENTANTE' 
    WHEN 'P' THEN 'PROFISSIONAL' 
    WHEN 'I' THEN 'INTERNO' 
    WHEN 'E' THEN 'EXTERNO' 
  ELSE 'NÃO DEFINIDO'  END TIPO
FROM PCUSUARI RCA
LEFT JOIN PCSUPERV SUP ON SUP.CODSUPERVISOR = RCA.CODSUPERVISOR
LEFT JOIN PCGERENTE GER ON GER.CODGERENTE = SUP.CODGERENTE