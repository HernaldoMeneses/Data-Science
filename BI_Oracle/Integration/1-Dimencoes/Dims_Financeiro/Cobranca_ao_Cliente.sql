SELECT 
COB.NUMREGCOB AS NUMEROCOBRANCA,
COB.TIPOCONTATO,
COB.CONTATO AS NOMECONTATO,
COB.OBS1 AS OBSERVACAO1,
COB.OBS2 AS OBSERVACAO2,
COB.OBS3 AS OBSERVACAO3,
COB.OBS4 AS OBSERVACAO4,
TO_CHAR(COB.DATA, 'HH24') AS HORA,
TO_CHAR(COB.DATA, 'MI') AS MINUTO
FROM PCHISTCOB COB
WHERE COB.NUMREGCOB IS NOT NULL