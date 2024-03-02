----------------------------------
Timestamp: 15:54:22.232
SELECT PCUSUARI.CODUSUR,
         PCUSUARI.NOME
    FROM PCUSUARI
   WHERE 1 = 1
     AND ((PCUSUARI.CODSUPERVISOR IN (SELECT CODIGON
                                        FROM PCLIB
                                       WHERE PCLIB.CODTABELA = 7
                                         AND CODIGON <> 9999
                                         AND CODFUNC = 1261)) OR
           EXISTS (SELECT CODIGON
                     FROM PCLIB
                    WHERE PCLIB.CODTABELA = 7
                      AND CODIGON = 9999
                      AND CODFUNC = 1261))
 AND TO_CHAR(PCUSUARI.CODUSUR) = :PARAM1
PARAM1 = '1291'
----------------------------------
Timestamp: 15:54:22.355
SELECT PCUSUARI.CODUSUR,
         PCUSUARI.NOME
    FROM PCUSUARI
   WHERE 1 = 1
     AND ((PCUSUARI.CODSUPERVISOR IN (SELECT CODIGON
                                        FROM PCLIB
                                       WHERE PCLIB.CODTABELA = 7
                                         AND CODIGON <> 9999
                                         AND CODFUNC = 1261)) OR
           EXISTS (SELECT CODIGON
                     FROM PCLIB
                    WHERE PCLIB.CODTABELA = 7
                      AND CODIGON = 9999
                      AND CODFUNC = 1261))
 AND TO_CHAR(PCUSUARI.CODUSUR) = :PARAM1
PARAM1 = '1291'
----------------------------------
Timestamp: 15:54:22.676
SELECT PCUSUARI.CODSUPERVISOR, PCSUPERV.NOME NOMESUPERV,
PCUSUARI.CODUSUR, PCUSUARI.NOME,
       0 clPERATIVOS, 0 clPERINATIVOS, 0 clTOTALCLICAD, 
           (SELECT COUNT(DISTINCT(PCCLIENT.CODCLI)) TOTALCLIATIVOS
          FROM PCCLIENT, PCPRACA
         WHERE ((PCCLIENT.CODUSUR1 = PCUSUARI.CODUSUR) OR
               (PCCLIENT.CODUSUR2 = PCUSUARI.CODUSUR) OR
               (PCCLIENT.CODCLI IN
               (SELECT PCUSURCLI.CODCLI
                    FROM PCUSURCLI
                   WHERE PCUSURCLI.CODCLI = PCCLIENT.CODCLI
                     AND PCUSURCLI.CODUSUR = PCUSUARI.CODUSUR)))
           AND (PCCLIENT.DTULTCOMP >= :DTREFERENCIA) 
           AND (PCCLIENT.CODPRACA = PCPRACA.CODPRACA(+))
           AND PCUSUARI.CODUSUR = PCUSUARI.CODUSUR) TOTALCLIATIVOS,
       (SELECT COUNT(*) TOTALCLICOMPRA
          FROM PCCLIENT, PCPRACA
         WHERE ((PCCLIENT.CODUSUR1 = PCUSUARI.CODUSUR) OR
               (PCCLIENT.CODUSUR2 = PCUSUARI.CODUSUR) OR
               (PCCLIENT.CODCLI IN
               (SELECT PCUSURCLI.CODCLI
                    FROM PCUSURCLI
                   WHERE PCUSURCLI.CODCLI = PCCLIENT.CODCLI
                     AND PCUSURCLI.CODUSUR = PCUSUARI.CODUSUR)))
           AND (PCCLIENT.CODPRACA = PCPRACA.CODPRACA(+))
           AND ((PCCLIENT.DTULTCOMP < :DTREFERENCIA) OR
               PCCLIENT.DTULTCOMP IS NULL)
           AND PCUSUARI.CODUSUR = PCUSUARI.CODUSUR ) TOTALCLICOMPRA, 
       (SELECT COUNT(*) TOTALCLIBLOQ
          FROM PCCLIENT, PCPRACA
         WHERE ((PCCLIENT.CODUSUR1 = PCUSUARI.CODUSUR) OR
               (PCCLIENT.CODUSUR2 = PCUSUARI.CODUSUR) OR
               (PCCLIENT.CODCLI IN
               (SELECT PCUSURCLI.CODCLI
                    FROM PCUSURCLI
                   WHERE PCUSURCLI.CODCLI = PCCLIENT.CODCLI
                     AND PCUSURCLI.CODUSUR = PCUSUARI.CODUSUR)))
           AND (PCCLIENT.CODPRACA = PCPRACA.CODPRACA(+))
           AND PCCLIENT.BLOQUEIO = 'S'
           AND PCUSUARI.CODUSUR = PCUSUARI.CODUSUR) TOTALCLIBLOQ,
       (SELECT COUNT(*) TOTALCLI
          FROM PCCLIENT, PCPRACA
         WHERE ((PCCLIENT.CODUSUR1 = PCUSUARI.CODUSUR) OR
               (PCCLIENT.CODUSUR2 = PCUSUARI.CODUSUR) OR 
               (PCCLIENT.CODCLI IN
               (SELECT PCUSURCLI.CODCLI
                    FROM PCUSURCLI
                   WHERE PCUSURCLI.CODCLI = PCCLIENT.CODCLI
                     AND PCUSURCLI.CODUSUR = PCUSUARI.CODUSUR)))
           AND (PCCLIENT.CODPRACA = PCPRACA.CODPRACA(+))
           AND PCUSUARI.CODUSUR = PCUSUARI.CODUSUR) TOTALCLI
FROM PCUSUARI, PCSUPERV
WHERE PCUSUARI.CODSUPERVISOR = PCSUPERV.CODSUPERVISOR
  AND (PCUSUARI.CODUSUR in ('1291'))
  and PCUSUARI.CODUSUR IN (SELECT PCCLIENT.CODUSUR1 CODUSUR
                             FROM PCCLIENT
                                 ,PCPRACA
                              WHERE PCCLIENT.CODUSUR1 = PCUSUARI.CODUSUR
                              and PCCLIENT.CODPRACA   = PCPRACA.CODPRACA
                              UNION
                             SELECT PCCLIENT.CODUSUR2 CODUSUR
                             FROM PCCLIENT
                                 ,PCPRACA
                              WHERE PCCLIENT.CODUSUR2 = PCUSUARI.CODUSUR
                              and PCCLIENT.CODPRACA   = PCPRACA.CODPRACA
                              UNION
                             SELECT PCUSURCLI.CODUSUR
                               FROM PCUSURCLI, PCCLIENT, PCPRACA
                              WHERE PCUSURCLI.codcli    = PCCLIENT.CODCLI
                                AND PCUSURCLI.CODUSUR   = PCUSUARI.CODUSUR
                                and PCCLIENT.CODPRACA   = PCPRACA.CODPRACA)
ORDER BY PCSUPERV.NOME
DTREFERENCIA = '01/10/2023'
----------------------------------
Timestamp: 15:54:22.834
SELECT '' TABLE_CATALOG, IC.TABLE_OWNER TABLE_SCHEMA, IC.TABLE_NAME, '' INDEX_CATALOG, IC.INDEX_OWNER INDEX_SCHEMA, 
IC.INDEX_NAME, IC.COLUMN_NAME, IC.COLUMN_POSITION, DECODE(IC.DESCEND, 'ASC', 0, 1) DESCENDING FROM SYS.ALL_IND_COLUMNS IC, 
SYS.ALL_INDEXES I, SYS.ALL_CONSTRAINTS C WHERE IC.TABLE_OWNER = 'FRIOBOM' AND IC.TABLE_NAME = 'PCUSUARI' AND I.UNIQUENESS = 
'UNIQUE' AND        I.OWNER = IC.INDEX_OWNER AND I.INDEX_NAME = IC.INDEX_NAME AND       C.TABLE_NAME (+) = IC.TABLE_NAME AND 
C.INDEX_NAME (+) = IC.INDEX_NAME AND C.OWNER (+)= IC.TABLE_OWNER ORDER BY DECODE(IC.INDEX_OWNER, 'FRIOBOM', 0, 'PUBLIC', 1, 2), 
DECODE(C.CONSTRAINT_TYPE, 'P', 1, 'U', 2, 3), IC.INDEX_OWNER, IC.TABLE_OWNER, IC.TABLE_NAME, IC.INDEX_NAME, IC.COLUMN_POSITION
----------------------------------
Timestamp: 15:54:23.286
SELECT PCCLIENT.CODCLI, PCCLIENT.CLIENTE CLIENTE, PCCLIENT.CODATV1, PCCLIENT.BLOQUEIO,

       PCCLIENT.ENDERCOB AS ENDERENT, PCCLIENT.MUNICCOB AS MUNICENT, PCCLIENT.BAIRROCOB AS BAIRROENT, 
       PCCLIENT.NUMEROCOB NUMEROENT, PCCLIENT.TELCOB AS TELENT, PCCLIENT.CEPCOB AS CEPENT, PCCLIENT.COMPLEMENTOCOB AS 
COMPLEMENTOENT,
       PCCLIENT.CODUSUR1,
	   PCCLIENT.CODUSUR2, PCCLIENT.CODPRACA, PCCLIENT.CODCOB,
       PCCLIENT.TIPOFJ, PCCLIENT.FANTASIA FANTASIA, PCCLIENT.DTULTCOMP, PCCLIENT.IEENT,
       PCCLIENT.CGCENT, PCCLIENT.LIMCRED, PCCLIENT.DTBLOQ , PCCLIENT.ESTENT ESTENT,
       PCPRACA.NUMREGIAO, PCCLIENT.OBSCREDITO, TRUNC(PCCLIENT.DTCADASTRO) DTCADASTRO, PCCLIENT.OBS,
       PCPLPAG.NUMDIAS, PCPLPAG.CODPLPAG, PCCLIENT.PONTOREFER, PCCLIENT.FAXCLI,
       PCCLIENT.NUMSEQ NUMSEQ, PCCLIENT.RG, PCCLIENT.TELCELENT, PCCLIENT.CODPLPAGPADRAO,
       PCCLIENT.RATINGSCI, PCCLIENT.CLASSEVENDA,
       PCCLIENT.CODCIDADE,
       PCCIDADE.NOMECIDADE,
	   0 clTOTACLI, 0 clVLDISP, '                              ' NOMECLIENTE, '                              ' TIPOBLOQUEIO,
	   '                              ' clNOMECLIENTE, '                              ' clRAMO, '                              ' 
clCONTATO

       , ( SELECT SUM ( valor ) valor
             FROM pcprest
            WHERE dtpag IS NULL
              AND codcli = pcclient.codcli
              AND codcob NOT IN ( 'DESD', 'DEVT', 'DEVP' )
            ) clvlreceber
       , ( SELECT SUM ( vlatend ) vlatend
             FROM pcpedc
            WHERE posicao NOT IN ( 'F', 'C' ) AND codcli = pcclient.codcli
            )clvlpendente
       , ( SELECT MAX(vlatend)
           FROM pcpedc
          WHERE posicao NOT IN ( 'F', 'C' )
            AND ( condvenda NOT IN ( 4, 5, 6, 11, 12 ))
            AND ( dtcancel IS NULL )
            AND codcli = pcclient.codcli
            AND DATA =
                ( SELECT MAX ( c.DATA )
                    FROM pcpedc c
                   WHERE c.posicao NOT IN ( 'F', 'C' )
                     AND c.condvenda NOT IN ( 4, 5, 6, 11, 12 )
                     AND c.dtcancel IS NULL
                     AND c.codcli = pcpedc.codcli )
            ) clvalorultimopedido
       , ( SELECT MAX ( DATA )
           FROM pcpedc
          WHERE posicao NOT IN ( 'F', 'C' )
            AND ( condvenda NOT IN ( 4, 5, 6, 11, 12 ))
            AND ( dtcancel IS NULL )
            AND pcpedc.codcli = pcclient.codcli ) cldtultpednaofaturado
	   ,
	   TO_CHAR(
	   ( SELECT MAX ( pcpedc.DATA ) AS DATA
           FROM pcpedc
          WHERE posicao = 'F'
            AND ( condvenda NOT IN ( 4, 5, 6, 11, 12 ))
            AND ( dtcancel IS NULL )
            AND codcli = pcclient.codcli)
		,'DD/MM/YYYY')
			cldataultimopedido			

       , ( SELECT MAX(vlatend)
           FROM pcpedc
          WHERE posicao = 'F'
            AND ( condvenda NOT IN ( 4, 5, 6, 11, 12 ))
            AND ( dtcancel IS NULL )
            AND codcli = pcclient.codcli
            AND DATA =
                   ( SELECT MAX ( c.DATA )
                      FROM pcpedc c
                     WHERE c.posicao = 'F'
                       AND c.condvenda NOT IN ( 4, 5, 6, 11, 12 )
                       AND c.dtcancel IS NULL
                       AND c.codcli = pcpedc.codcli ))
                                                  clvalorultimopedidofaturado,
           pcpraca.praca clpraca
        FROM PCCLIENT,  PCPRACA, PCPLPAG, PCCIDADE

     , PCUSUARI



       WHERE (PCCLIENT.CODPRACA = PCPRACA.CODPRACA(+))
         AND (PCCLIENT.CODPLPAG = PCPLPAG.CODPLPAG(+))
         AND (PCCLIENT.CODCIDADE = PCCIDADE.CODCIDADE(+))

         AND (PCCLIENT.CODUSUR1 = PCUSUARI.CODUSUR)         
  
    AND (PCUSUARI.CODUSUR = :CODUSUR)


AND NVL(PCCLIENT.DTULTCOMP, :DtReferencia) < :DtReferencia 
UNION
SELECT PCCLIENT.CODCLI, PCCLIENT.CLIENTE CLIENTE, PCCLIENT.CODATV1, PCCLIENT.BLOQUEIO,

       PCCLIENT.ENDERCOB AS ENDERENT, PCCLIENT.MUNICCOB AS MUNICENT, PCCLIENT.BAIRROCOB AS BAIRROENT, 
       PCCLIENT.NUMEROCOB NUMEROENT, PCCLIENT.TELCOB AS TELENT, PCCLIENT.CEPCOB AS CEPENT, PCCLIENT.COMPLEMENTOCOB AS 
COMPLEMENTOENT,
       PCCLIENT.CODUSUR2 AS CODUSUR1,
	   PCCLIENT.CODUSUR2, PCCLIENT.CODPRACA, PCCLIENT.CODCOB,
       PCCLIENT.TIPOFJ, PCCLIENT.FANTASIA FANTASIA, PCCLIENT.DTULTCOMP, PCCLIENT.IEENT,
       PCCLIENT.CGCENT, PCCLIENT.LIMCRED, PCCLIENT.DTBLOQ , PCCLIENT.ESTENT ESTENT,
       PCPRACA.NUMREGIAO, PCCLIENT.OBSCREDITO, TRUNC(PCCLIENT.DTCADASTRO) DTCADASTRO, PCCLIENT.OBS,
       PCPLPAG.NUMDIAS, PCPLPAG.CODPLPAG, PCCLIENT.PONTOREFER, PCCLIENT.FAXCLI,
       PCCLIENT.NUMSEQ NUMSEQ, PCCLIENT.RG, PCCLIENT.TELCELENT, PCCLIENT.CODPLPAGPADRAO,
       PCCLIENT.RATINGSCI, PCCLIENT.CLASSEVENDA,
       PCCLIENT.CODCIDADE,
       PCCIDADE.NOMECIDADE,
	   0 clTOTACLI, 0 clVLDISP, '                              ' NOMECLIENTE, '                              ' TIPOBLOQUEIO,
	   '                              ' clNOMECLIENTE, '                              ' clRAMO, '                              ' 
clCONTATO

       , ( SELECT SUM ( valor ) valor
             FROM pcprest
            WHERE dtpag IS NULL
              AND codcli = pcclient.codcli
              AND codcob NOT IN ( 'DESD', 'DEVT', 'DEVP' )
            ) clvlreceber
       , ( SELECT SUM ( vlatend ) vlatend
             FROM pcpedc
            WHERE posicao NOT IN ( 'F', 'C' ) AND codcli = pcclient.codcli
            )clvlpendente
       , ( SELECT MAX(vlatend)
           FROM pcpedc
          WHERE posicao NOT IN ( 'F', 'C' )
            AND ( condvenda NOT IN ( 4, 5, 6, 11, 12 ))
            AND ( dtcancel IS NULL )
            AND codcli = pcclient.codcli
            AND DATA =
                ( SELECT MAX ( c.DATA )
                    FROM pcpedc c
                   WHERE c.posicao NOT IN ( 'F', 'C' )
                     AND c.condvenda NOT IN ( 4, 5, 6, 11, 12 )
                     AND c.dtcancel IS NULL
                     AND c.codcli = pcpedc.codcli )
            ) clvalorultimopedido
       , ( SELECT MAX ( DATA )
           FROM pcpedc
          WHERE posicao NOT IN ( 'F', 'C' )
            AND ( condvenda NOT IN ( 4, 5, 6, 11, 12 ))
            AND ( dtcancel IS NULL )
            AND pcpedc.codcli = pcclient.codcli ) cldtultpednaofaturado
	   ,
	   TO_CHAR(
	   ( SELECT MAX ( pcpedc.DATA ) AS DATA
           FROM pcpedc
          WHERE posicao = 'F'
            AND ( condvenda NOT IN ( 4, 5, 6, 11, 12 ))
            AND ( dtcancel IS NULL )
            AND codcli = pcclient.codcli)
		,'DD/MM/YYYY')
			cldataultimopedido			

       , ( SELECT MAX(vlatend)
           FROM pcpedc
          WHERE posicao = 'F'
            AND ( condvenda NOT IN ( 4, 5, 6, 11, 12 ))
            AND ( dtcancel IS NULL )
            AND codcli = pcclient.codcli
            AND DATA =
                   ( SELECT MAX ( c.DATA )
                      FROM pcpedc c
                     WHERE c.posicao = 'F'
                       AND c.condvenda NOT IN ( 4, 5, 6, 11, 12 )
                       AND c.dtcancel IS NULL
                       AND c.codcli = pcpedc.codcli ))
                                                  clvalorultimopedidofaturado,
           pcpraca.praca clpraca
        FROM PCCLIENT,  PCPRACA, PCPLPAG, PCCIDADE

     , PCUSUARI



       WHERE (PCCLIENT.CODPRACA = PCPRACA.CODPRACA(+))
         AND (PCCLIENT.CODPLPAG = PCPLPAG.CODPLPAG(+))
         AND (PCCLIENT.CODCIDADE = PCCIDADE.CODCIDADE(+))

         AND (PCCLIENT.CODUSUR2 = PCUSUARI.CODUSUR)
  
    AND (PCUSUARI.CODUSUR = :CODUSUR)


AND NVL(PCCLIENT.DTULTCOMP, :DtReferencia) < :DtReferencia 
UNION
SELECT PCCLIENT.CODCLI, PCCLIENT.CLIENTE CLIENTE, PCCLIENT.CODATV1, PCCLIENT.BLOQUEIO,

       PCCLIENT.ENDERCOB AS ENDERENT, PCCLIENT.MUNICCOB AS MUNICENT, PCCLIENT.BAIRROCOB AS BAIRROENT, 
       PCCLIENT.NUMEROCOB NUMEROENT, PCCLIENT.TELCOB AS TELENT, PCCLIENT.CEPCOB AS CEPENT, PCCLIENT.COMPLEMENTOCOB AS 
COMPLEMENTOENT,
      PCUSURCLI.CODUSUR AS CODUSUR1,


	   PCCLIENT.CODUSUR2, PCCLIENT.CODPRACA, PCCLIENT.CODCOB,
       PCCLIENT.TIPOFJ, PCCLIENT.FANTASIA FANTASIA, PCCLIENT.DTULTCOMP, PCCLIENT.IEENT,
       PCCLIENT.CGCENT, PCCLIENT.LIMCRED, PCCLIENT.DTBLOQ , PCCLIENT.ESTENT ESTENT,
       PCPRACA.NUMREGIAO, PCCLIENT.OBSCREDITO, TRUNC(PCCLIENT.DTCADASTRO) DTCADASTRO, PCCLIENT.OBS,
       PCPLPAG.NUMDIAS, PCPLPAG.CODPLPAG, PCCLIENT.PONTOREFER, PCCLIENT.FAXCLI,
       PCCLIENT.NUMSEQ NUMSEQ, PCCLIENT.RG, PCCLIENT.TELCELENT, PCCLIENT.CODPLPAGPADRAO,
       PCCLIENT.RATINGSCI, PCCLIENT.CLASSEVENDA,
       PCCLIENT.CODCIDADE,
       PCCIDADE.NOMECIDADE,
	   0 clTOTACLI, 0 clVLDISP, '                              ' NOMECLIENTE, '                              ' TIPOBLOQUEIO,
	   '                              ' clNOMECLIENTE, '                              ' clRAMO, '                              ' 
clCONTATO

       , ( SELECT SUM ( valor ) valor
             FROM pcprest
            WHERE dtpag IS NULL
              AND codcli = pcclient.codcli
              AND codcob NOT IN ( 'DESD', 'DEVT', 'DEVP' )
            ) clvlreceber
       , ( SELECT SUM ( vlatend ) vlatend
             FROM pcpedc
            WHERE posicao NOT IN ( 'F', 'C' ) AND codcli = pcclient.codcli
            )clvlpendente
       , ( SELECT MAX(vlatend)
           FROM pcpedc
          WHERE posicao NOT IN ( 'F', 'C' )
            AND ( condvenda NOT IN ( 4, 5, 6, 11, 12 ))
            AND ( dtcancel IS NULL )
            AND codcli = pcclient.codcli
            AND DATA =
                ( SELECT MAX ( c.DATA )
                    FROM pcpedc c
                   WHERE c.posicao NOT IN ( 'F', 'C' )
                     AND c.condvenda NOT IN ( 4, 5, 6, 11, 12 )
                     AND c.dtcancel IS NULL
                     AND c.codcli = pcpedc.codcli )
            ) clvalorultimopedido
       , ( SELECT MAX ( DATA )
           FROM pcpedc
          WHERE posicao NOT IN ( 'F', 'C' )
            AND ( condvenda NOT IN ( 4, 5, 6, 11, 12 ))
            AND ( dtcancel IS NULL )
            AND pcpedc.codcli = pcclient.codcli ) cldtultpednaofaturado
	   ,
	   TO_CHAR(
	   ( SELECT MAX ( pcpedc.DATA ) AS DATA
           FROM pcpedc
          WHERE posicao = 'F'
            AND ( condvenda NOT IN ( 4, 5, 6, 11, 12 ))
            AND ( dtcancel IS NULL )
            AND codcli = pcclient.codcli)
		,'DD/MM/YYYY')
			cldataultimopedido			

       , ( SELECT MAX(vlatend)
           FROM pcpedc
          WHERE posicao = 'F'
            AND ( condvenda NOT IN ( 4, 5, 6, 11, 12 ))
            AND ( dtcancel IS NULL )
            AND codcli = pcclient.codcli
            AND DATA =
                   ( SELECT MAX ( c.DATA )
                      FROM pcpedc c
                     WHERE c.posicao = 'F'
                       AND c.condvenda NOT IN ( 4, 5, 6, 11, 12 )
                       AND c.dtcancel IS NULL
                       AND c.codcli = pcpedc.codcli ))
                                                  clvalorultimopedidofaturado,
           pcpraca.praca clpraca
        FROM PCCLIENT,  PCPRACA, PCPLPAG, PCCIDADE

     , PCUSUARI

           , PCUSURCLI


       WHERE (PCCLIENT.CODPRACA = PCPRACA.CODPRACA(+))
         AND (PCCLIENT.CODPLPAG = PCPLPAG.CODPLPAG(+))
         AND (PCCLIENT.CODCIDADE = PCCIDADE.CODCIDADE(+))

         AND (PCCLIENT.CODCLI = PCUSURCLI.CODCLI)
		 AND (PCUSURCLI.CODUSUR = PCUSUARI.CODUSUR)
  
    AND (PCUSUARI.CODUSUR = :CODUSUR)


AND NVL(PCCLIENT.DTULTCOMP, :DtReferencia) < :DtReferencia 
ORDER BY NUMSEQ
CODUSUR = 1291
DtReferencia = '01/10/2023'
----------------------------------
Timestamp: 15:54:23.730
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:23.744
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 3080
----------------------------------
Timestamp: 15:54:23.762
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:23.774
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 3080
----------------------------------
Timestamp: 15:54:23.793
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 3080
----------------------------------
Timestamp: 15:54:23.814
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:23.826
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 3080
----------------------------------
Timestamp: 15:54:23.857
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 3080
----------------------------------
Timestamp: 15:54:23.885
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 3080
----------------------------------
Timestamp: 15:54:23.924
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 3080
----------------------------------
Timestamp: 15:54:23.949
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:24.037
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 3080
----------------------------------
Timestamp: 15:54:24.096
SELECT '' TABLE_CATALOG, IC.TABLE_OWNER TABLE_SCHEMA, IC.TABLE_NAME, '' INDEX_CATALOG, IC.INDEX_OWNER INDEX_SCHEMA, 
IC.INDEX_NAME, IC.COLUMN_NAME, IC.COLUMN_POSITION, DECODE(IC.DESCEND, 'ASC', 0, 1) DESCENDING FROM SYS.ALL_IND_COLUMNS IC, 
SYS.ALL_INDEXES I, SYS.ALL_CONSTRAINTS C WHERE IC.TABLE_OWNER = 'FRIOBOM' AND IC.TABLE_NAME = 'PCCLIENT' AND I.UNIQUENESS = 
'UNIQUE' AND        I.OWNER = IC.INDEX_OWNER AND I.INDEX_NAME = IC.INDEX_NAME AND       C.TABLE_NAME (+) = IC.TABLE_NAME AND 
C.INDEX_NAME (+) = IC.INDEX_NAME AND C.OWNER (+)= IC.TABLE_OWNER ORDER BY DECODE(IC.INDEX_OWNER, 'FRIOBOM', 0, 'PUBLIC', 1, 2), 
DECODE(C.CONSTRAINT_TYPE, 'P', 1, 'U', 2, 3), IC.INDEX_OWNER, IC.TABLE_OWNER, IC.TABLE_NAME, IC.INDEX_NAME, IC.COLUMN_POSITION
----------------------------------
Timestamp: 15:54:24.124
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:24.141
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 4820
----------------------------------
Timestamp: 15:54:24.163
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:24.180
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 4820
----------------------------------
Timestamp: 15:54:24.202
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 4820
----------------------------------
Timestamp: 15:54:24.221
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:24.236
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 4820
----------------------------------
Timestamp: 15:54:24.263
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 4820
----------------------------------
Timestamp: 15:54:24.284
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 4820
----------------------------------
Timestamp: 15:54:24.316
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 4820
----------------------------------
Timestamp: 15:54:24.341
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:24.497
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 4820
----------------------------------
Timestamp: 15:54:24.546
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:24.561
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 5413
----------------------------------
Timestamp: 15:54:24.579
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:24.595
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 5413
----------------------------------
Timestamp: 15:54:24.613
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 5413
----------------------------------
Timestamp: 15:54:24.633
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:24.647
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 5413
----------------------------------
Timestamp: 15:54:24.674
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 5413
----------------------------------
Timestamp: 15:54:24.694
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 5413
----------------------------------
Timestamp: 15:54:24.722
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 5413
----------------------------------
Timestamp: 15:54:24.747
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:24.767
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 5413
----------------------------------
Timestamp: 15:54:24.818
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:24.837
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 10094
----------------------------------
Timestamp: 15:54:24.860
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:24.877
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 10094
----------------------------------
Timestamp: 15:54:24.898
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 10094
----------------------------------
Timestamp: 15:54:24.924
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:24.939
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 10094
----------------------------------
Timestamp: 15:54:24.966
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 10094
----------------------------------
Timestamp: 15:54:24.987
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 10094
----------------------------------
Timestamp: 15:54:25.018
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 10094
----------------------------------
Timestamp: 15:54:25.041
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:25.089
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 10094
----------------------------------
Timestamp: 15:54:25.138
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:25.156
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 102794
----------------------------------
Timestamp: 15:54:25.176
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:25.190
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 102794
----------------------------------
Timestamp: 15:54:25.211
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 102794
----------------------------------
Timestamp: 15:54:25.236
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:25.254
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 102794
----------------------------------
Timestamp: 15:54:25.277
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 102794
----------------------------------
Timestamp: 15:54:25.299
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 102794
----------------------------------
Timestamp: 15:54:25.332
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 102794
----------------------------------
Timestamp: 15:54:25.356
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:25.435
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 102794
----------------------------------
Timestamp: 15:54:25.491
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. AUT. POR 90 DIAS INATIVO'
----------------------------------
Timestamp: 15:54:25.516
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:25.531
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 103087
----------------------------------
Timestamp: 15:54:25.548
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:25.562
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 103087
----------------------------------
Timestamp: 15:54:25.578
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 103087
----------------------------------
Timestamp: 15:54:25.601
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:25.612
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 103087
----------------------------------
Timestamp: 15:54:25.640
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 103087
----------------------------------
Timestamp: 15:54:25.662
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 103087
----------------------------------
Timestamp: 15:54:25.693
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 103087
----------------------------------
Timestamp: 15:54:25.717
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:25.853
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 103087
----------------------------------
Timestamp: 15:54:25.909
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:25.924
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 110335
----------------------------------
Timestamp: 15:54:25.949
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:25.964
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 110335
----------------------------------
Timestamp: 15:54:25.986
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 110335
----------------------------------
Timestamp: 15:54:26.008
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:26.019
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 110335
----------------------------------
Timestamp: 15:54:26.050
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 110335
----------------------------------
Timestamp: 15:54:26.073
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 110335
----------------------------------
Timestamp: 15:54:26.106
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 110335
----------------------------------
Timestamp: 15:54:26.127
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:26.149
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 110335
----------------------------------
Timestamp: 15:54:26.190
SELECT '' TABLE_CATALOG, IC.TABLE_OWNER TABLE_SCHEMA, IC.TABLE_NAME, '' INDEX_CATALOG, IC.INDEX_OWNER INDEX_SCHEMA, 
IC.INDEX_NAME, IC.COLUMN_NAME, IC.COLUMN_POSITION, DECODE(IC.DESCEND, 'ASC', 0, 1) DESCENDING FROM SYS.ALL_IND_COLUMNS IC, 
SYS.ALL_INDEXES I, SYS.ALL_CONSTRAINTS C WHERE IC.TABLE_OWNER = 'FRIOBOM' AND IC.TABLE_NAME = 'PCHIST' AND I.UNIQUENESS = 
'UNIQUE' AND        I.OWNER = IC.INDEX_OWNER AND I.INDEX_NAME = IC.INDEX_NAME AND       C.TABLE_NAME (+) = IC.TABLE_NAME AND 
C.INDEX_NAME (+) = IC.INDEX_NAME AND C.OWNER (+)= IC.TABLE_OWNER ORDER BY DECODE(IC.INDEX_OWNER, 'FRIOBOM', 0, 'PUBLIC', 1, 2), 
DECODE(C.CONSTRAINT_TYPE, 'P', 1, 'U', 2, 3), IC.INDEX_OWNER, IC.TABLE_OWNER, IC.TABLE_NAME, IC.INDEX_NAME, IC.COLUMN_POSITION
----------------------------------
Timestamp: 15:54:26.207
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. AUTOMATICO DEFINITIVO'
----------------------------------
Timestamp: 15:54:26.228
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:26.242
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 110902
----------------------------------
Timestamp: 15:54:26.258
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:26.273
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 110902
----------------------------------
Timestamp: 15:54:26.291
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 110902
----------------------------------
Timestamp: 15:54:26.311
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:26.324
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 110902
----------------------------------
Timestamp: 15:54:26.351
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 110902
----------------------------------
Timestamp: 15:54:26.372
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 110902
----------------------------------
Timestamp: 15:54:26.402
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 110902
----------------------------------
Timestamp: 15:54:26.423
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:26.589
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 110902
----------------------------------
Timestamp: 15:54:26.632
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:26.648
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 113109
----------------------------------
Timestamp: 15:54:26.666
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:26.678
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 113109
----------------------------------
Timestamp: 15:54:26.696
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 113109
----------------------------------
Timestamp: 15:54:26.720
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:26.731
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 113109
----------------------------------
Timestamp: 15:54:26.761
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 113109
----------------------------------
Timestamp: 15:54:26.786
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 113109
----------------------------------
Timestamp: 15:54:26.822
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 113109
----------------------------------
Timestamp: 15:54:26.848
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:26.928
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 113109
----------------------------------
Timestamp: 15:54:26.986
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:27.005
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 115041
----------------------------------
Timestamp: 15:54:27.036
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:27.067
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 115041
----------------------------------
Timestamp: 15:54:27.106
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 115041
----------------------------------
Timestamp: 15:54:27.151
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:27.177
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 115041
----------------------------------
Timestamp: 15:54:27.228
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 115041
----------------------------------
Timestamp: 15:54:27.250
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 115041
----------------------------------
Timestamp: 15:54:27.283
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 115041
----------------------------------
Timestamp: 15:54:27.307
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:27.383
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 115041
----------------------------------
Timestamp: 15:54:27.436
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:27.455
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 115611
----------------------------------
Timestamp: 15:54:27.490
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:27.513
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 115611
----------------------------------
Timestamp: 15:54:27.563
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 115611
----------------------------------
Timestamp: 15:54:27.600
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:27.617
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 115611
----------------------------------
Timestamp: 15:54:27.649
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 115611
----------------------------------
Timestamp: 15:54:27.675
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 115611
----------------------------------
Timestamp: 15:54:27.710
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 115611
----------------------------------
Timestamp: 15:54:27.737
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:27.760
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 115611
----------------------------------
Timestamp: 15:54:27.805
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. AUT. POR 90 DIAS INATIVO'
----------------------------------
Timestamp: 15:54:27.827
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:27.843
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 116471
----------------------------------
Timestamp: 15:54:27.860
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:27.874
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 116471
----------------------------------
Timestamp: 15:54:27.891
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 116471
----------------------------------
Timestamp: 15:54:27.911
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:27.924
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 116471
----------------------------------
Timestamp: 15:54:27.949
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 116471
----------------------------------
Timestamp: 15:54:27.973
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 116471
----------------------------------
Timestamp: 15:54:28.000
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 116471
----------------------------------
Timestamp: 15:54:28.026
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:28.094
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 116471
----------------------------------
Timestamp: 15:54:28.148
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. SEFAZ'
----------------------------------
Timestamp: 15:54:28.178
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:28.204
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 119057
----------------------------------
Timestamp: 15:54:28.230
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:28.244
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 119057
----------------------------------
Timestamp: 15:54:28.262
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 119057
----------------------------------
Timestamp: 15:54:28.284
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:28.298
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 119057
----------------------------------
Timestamp: 15:54:28.330
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 119057
----------------------------------
Timestamp: 15:54:28.358
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 119057
----------------------------------
Timestamp: 15:54:28.394
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 119057
----------------------------------
Timestamp: 15:54:28.426
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:28.513
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 119057
----------------------------------
Timestamp: 15:54:28.557
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. AUT. POR 90 DIAS INATIVO'
----------------------------------
Timestamp: 15:54:28.576
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:28.593
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 119890
----------------------------------
Timestamp: 15:54:28.614
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:28.628
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 119890
----------------------------------
Timestamp: 15:54:28.648
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 119890
----------------------------------
Timestamp: 15:54:28.666
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:28.679
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 119890
----------------------------------
Timestamp: 15:54:28.726
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 119890
----------------------------------
Timestamp: 15:54:28.762
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 119890
----------------------------------
Timestamp: 15:54:28.811
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 119890
----------------------------------
Timestamp: 15:54:28.850
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:28.899
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 119890
----------------------------------
Timestamp: 15:54:28.957
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. AUT. POR 90 DIAS INATIVO'
----------------------------------
Timestamp: 15:54:28.982
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:28.998
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 120057
----------------------------------
Timestamp: 15:54:29.019
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:29.033
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 120057
----------------------------------
Timestamp: 15:54:29.057
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 120057
----------------------------------
Timestamp: 15:54:29.077
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:29.101
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 120057
----------------------------------
Timestamp: 15:54:29.129
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 120057
----------------------------------
Timestamp: 15:54:29.149
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 120057
----------------------------------
Timestamp: 15:54:29.178
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 120057
----------------------------------
Timestamp: 15:54:29.201
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:29.299
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 120057
----------------------------------
Timestamp: 15:54:29.344
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:29.360
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 120291
----------------------------------
Timestamp: 15:54:29.381
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:29.392
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 120291
----------------------------------
Timestamp: 15:54:29.411
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 120291
----------------------------------
Timestamp: 15:54:29.433
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:29.449
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 120291
----------------------------------
Timestamp: 15:54:29.544
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 120291
----------------------------------
Timestamp: 15:54:29.581
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 120291
----------------------------------
Timestamp: 15:54:29.625
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 120291
----------------------------------
Timestamp: 15:54:29.655
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:29.696
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 120291
----------------------------------
Timestamp: 15:54:29.768
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. SEFAZ'
----------------------------------
Timestamp: 15:54:29.814
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:29.844
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 120297
----------------------------------
Timestamp: 15:54:29.872
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:29.893
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 120297
----------------------------------
Timestamp: 15:54:29.920
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 120297
----------------------------------
Timestamp: 15:54:29.941
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:29.955
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 120297
----------------------------------
Timestamp: 15:54:29.978
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 120297
----------------------------------
Timestamp: 15:54:30.005
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 120297
----------------------------------
Timestamp: 15:54:30.041
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 120297
----------------------------------
Timestamp: 15:54:30.064
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:30.130
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 120297
----------------------------------
Timestamp: 15:54:30.177
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. SEFAZ'
----------------------------------
Timestamp: 15:54:30.201
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:30.217
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 120890
----------------------------------
Timestamp: 15:54:30.239
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:30.253
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 120890
----------------------------------
Timestamp: 15:54:30.271
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 120890
----------------------------------
Timestamp: 15:54:30.291
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:30.302
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 120890
----------------------------------
Timestamp: 15:54:30.329
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 120890
----------------------------------
Timestamp: 15:54:30.350
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 120890
----------------------------------
Timestamp: 15:54:30.380
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 120890
----------------------------------
Timestamp: 15:54:30.401
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:30.435
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 120890
----------------------------------
Timestamp: 15:54:30.486
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. AUT. POR 90 DIAS INATIVO'
----------------------------------
Timestamp: 15:54:30.507
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:30.526
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 123334
----------------------------------
Timestamp: 15:54:30.547
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:30.563
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 123334
----------------------------------
Timestamp: 15:54:30.582
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 123334
----------------------------------
Timestamp: 15:54:30.604
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:30.615
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 123334
----------------------------------
Timestamp: 15:54:30.646
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 123334
----------------------------------
Timestamp: 15:54:30.666
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 123334
----------------------------------
Timestamp: 15:54:30.694
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 123334
----------------------------------
Timestamp: 15:54:30.718
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:30.822
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 123334
----------------------------------
Timestamp: 15:54:30.865
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:30.880
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 125639
----------------------------------
Timestamp: 15:54:30.904
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:30.917
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 125639
----------------------------------
Timestamp: 15:54:30.936
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 125639
----------------------------------
Timestamp: 15:54:30.954
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:30.968
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 125639
----------------------------------
Timestamp: 15:54:30.998
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 125639
----------------------------------
Timestamp: 15:54:31.022
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 125639
----------------------------------
Timestamp: 15:54:31.060
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 125639
----------------------------------
Timestamp: 15:54:31.083
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:31.131
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 125639
----------------------------------
Timestamp: 15:54:31.177
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:31.193
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 126024
----------------------------------
Timestamp: 15:54:31.217
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:31.234
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 126024
----------------------------------
Timestamp: 15:54:31.252
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 126024
----------------------------------
Timestamp: 15:54:31.276
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:31.287
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 126024
----------------------------------
Timestamp: 15:54:31.312
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 126024
----------------------------------
Timestamp: 15:54:31.335
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 126024
----------------------------------
Timestamp: 15:54:31.370
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 126024
----------------------------------
Timestamp: 15:54:31.394
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:31.456
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 126024
----------------------------------
Timestamp: 15:54:31.511
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. AUTOMATICO TIT. ATRASADOS'
----------------------------------
Timestamp: 15:54:31.531
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:31.549
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 126136
----------------------------------
Timestamp: 15:54:31.570
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:31.584
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 126136
----------------------------------
Timestamp: 15:54:31.601
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 126136
----------------------------------
Timestamp: 15:54:31.626
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:31.638
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 126136
----------------------------------
Timestamp: 15:54:31.663
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 126136
----------------------------------
Timestamp: 15:54:31.687
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 126136
----------------------------------
Timestamp: 15:54:31.719
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 126136
----------------------------------
Timestamp: 15:54:31.743
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:31.788
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 126136
----------------------------------
Timestamp: 15:54:31.831
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:31.846
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 128232
----------------------------------
Timestamp: 15:54:31.869
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:31.884
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 128232
----------------------------------
Timestamp: 15:54:31.903
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 128232
----------------------------------
Timestamp: 15:54:31.923
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:31.940
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 128232
----------------------------------
Timestamp: 15:54:31.968
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 128232
----------------------------------
Timestamp: 15:54:31.992
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 128232
----------------------------------
Timestamp: 15:54:32.028
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 128232
----------------------------------
Timestamp: 15:54:32.052
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:32.081
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 128232
----------------------------------
Timestamp: 15:54:32.132
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. AUT. POR 90 DIAS INATIVO'
----------------------------------
Timestamp: 15:54:32.151
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:32.167
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 128279
----------------------------------
Timestamp: 15:54:32.187
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:32.202
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 128279
----------------------------------
Timestamp: 15:54:32.221
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 128279
----------------------------------
Timestamp: 15:54:32.240
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:32.251
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 128279
----------------------------------
Timestamp: 15:54:32.283
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 128279
----------------------------------
Timestamp: 15:54:32.305
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 128279
----------------------------------
Timestamp: 15:54:32.335
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 128279
----------------------------------
Timestamp: 15:54:32.359
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:32.388
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 128279
----------------------------------
Timestamp: 15:54:32.432
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. SEFAZ'
----------------------------------
Timestamp: 15:54:32.455
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:32.475
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 128443
----------------------------------
Timestamp: 15:54:32.496
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:32.510
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 128443
----------------------------------
Timestamp: 15:54:32.527
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 128443
----------------------------------
Timestamp: 15:54:32.546
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:32.559
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 128443
----------------------------------
Timestamp: 15:54:32.588
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 128443
----------------------------------
Timestamp: 15:54:32.611
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 128443
----------------------------------
Timestamp: 15:54:32.645
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 128443
----------------------------------
Timestamp: 15:54:32.668
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:32.728
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 128443
----------------------------------
Timestamp: 15:54:32.776
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. AUT. POR 90 DIAS INATIVO'
----------------------------------
Timestamp: 15:54:32.799
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:32.812
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 128893
----------------------------------
Timestamp: 15:54:32.832
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:32.845
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 128893
----------------------------------
Timestamp: 15:54:32.863
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 128893
----------------------------------
Timestamp: 15:54:32.883
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:32.897
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 128893
----------------------------------
Timestamp: 15:54:32.924
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 128893
----------------------------------
Timestamp: 15:54:32.947
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 128893
----------------------------------
Timestamp: 15:54:32.978
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 128893
----------------------------------
Timestamp: 15:54:33.009
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:33.059
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 128893
----------------------------------
Timestamp: 15:54:33.112
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:33.127
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 130882
----------------------------------
Timestamp: 15:54:33.149
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:33.164
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 130882
----------------------------------
Timestamp: 15:54:33.184
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 130882
----------------------------------
Timestamp: 15:54:33.211
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:33.225
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 130882
----------------------------------
Timestamp: 15:54:33.252
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 130882
----------------------------------
Timestamp: 15:54:33.279
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 130882
----------------------------------
Timestamp: 15:54:33.312
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 130882
----------------------------------
Timestamp: 15:54:33.336
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:33.354
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 130882
----------------------------------
Timestamp: 15:54:33.396
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. AUT. POR 90 DIAS INATIVO'
----------------------------------
Timestamp: 15:54:33.418
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:33.434
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 130984
----------------------------------
Timestamp: 15:54:33.453
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:33.468
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 130984
----------------------------------
Timestamp: 15:54:33.492
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 130984
----------------------------------
Timestamp: 15:54:33.514
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:33.526
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 130984
----------------------------------
Timestamp: 15:54:33.555
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 130984
----------------------------------
Timestamp: 15:54:33.577
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 130984
----------------------------------
Timestamp: 15:54:33.611
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 130984
----------------------------------
Timestamp: 15:54:33.632
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:33.680
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 130984
----------------------------------
Timestamp: 15:54:33.728
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. AUT. POR 90 DIAS INATIVO'
----------------------------------
Timestamp: 15:54:33.750
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:33.768
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 131035
----------------------------------
Timestamp: 15:54:33.785
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:33.800
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 131035
----------------------------------
Timestamp: 15:54:33.819
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 131035
----------------------------------
Timestamp: 15:54:33.838
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:33.851
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 131035
----------------------------------
Timestamp: 15:54:33.878
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 131035
----------------------------------
Timestamp: 15:54:33.901
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 131035
----------------------------------
Timestamp: 15:54:33.935
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 131035
----------------------------------
Timestamp: 15:54:33.956
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:33.986
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 131035
----------------------------------
Timestamp: 15:54:34.037
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. AUT. POR 90 DIAS INATIVO'
----------------------------------
Timestamp: 15:54:34.059
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:34.077
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 136325
----------------------------------
Timestamp: 15:54:34.097
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:34.110
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 136325
----------------------------------
Timestamp: 15:54:34.129
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 136325
----------------------------------
Timestamp: 15:54:34.149
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:34.164
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 136325
----------------------------------
Timestamp: 15:54:34.191
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 136325
----------------------------------
Timestamp: 15:54:34.216
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 136325
----------------------------------
Timestamp: 15:54:34.247
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 136325
----------------------------------
Timestamp: 15:54:34.269
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:34.317
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 136325
----------------------------------
Timestamp: 15:54:34.367
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:34.381
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 136554
----------------------------------
Timestamp: 15:54:34.401
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:34.417
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 136554
----------------------------------
Timestamp: 15:54:34.441
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 136554
----------------------------------
Timestamp: 15:54:34.462
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:34.479
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 136554
----------------------------------
Timestamp: 15:54:34.510
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 136554
----------------------------------
Timestamp: 15:54:34.533
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 136554
----------------------------------
Timestamp: 15:54:34.567
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 136554
----------------------------------
Timestamp: 15:54:34.590
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:34.658
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 136554
----------------------------------
Timestamp: 15:54:34.704
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. AUTOMATICO TIT. ATRASADOS'
----------------------------------
Timestamp: 15:54:34.727
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:34.744
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 136600
----------------------------------
Timestamp: 15:54:34.762
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:34.775
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 136600
----------------------------------
Timestamp: 15:54:34.793
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 136600
----------------------------------
Timestamp: 15:54:34.812
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:34.826
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 136600
----------------------------------
Timestamp: 15:54:34.855
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 136600
----------------------------------
Timestamp: 15:54:34.880
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 136600
----------------------------------
Timestamp: 15:54:34.911
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 136600
----------------------------------
Timestamp: 15:54:34.934
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:34.953
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 136600
----------------------------------
Timestamp: 15:54:34.993
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:35.005
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 137254
----------------------------------
Timestamp: 15:54:35.027
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:35.047
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 137254
----------------------------------
Timestamp: 15:54:35.063
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 137254
----------------------------------
Timestamp: 15:54:35.081
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:35.092
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 137254
----------------------------------
Timestamp: 15:54:35.112
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 137254
----------------------------------
Timestamp: 15:54:35.132
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 137254
----------------------------------
Timestamp: 15:54:35.160
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 137254
----------------------------------
Timestamp: 15:54:35.178
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:35.191
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 137254
----------------------------------
Timestamp: 15:54:35.234
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:35.246
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 137458
----------------------------------
Timestamp: 15:54:35.264
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:35.277
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 137458
----------------------------------
Timestamp: 15:54:35.295
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 137458
----------------------------------
Timestamp: 15:54:35.312
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:35.322
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 137458
----------------------------------
Timestamp: 15:54:35.346
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 137458
----------------------------------
Timestamp: 15:54:35.365
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 137458
----------------------------------
Timestamp: 15:54:35.389
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 137458
----------------------------------
Timestamp: 15:54:35.406
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:35.422
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 137458
----------------------------------
Timestamp: 15:54:35.467
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:35.482
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 139612
----------------------------------
Timestamp: 15:54:35.499
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:35.513
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 139612
----------------------------------
Timestamp: 15:54:35.531
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 139612
----------------------------------
Timestamp: 15:54:35.552
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:35.566
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 139612
----------------------------------
Timestamp: 15:54:35.596
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 139612
----------------------------------
Timestamp: 15:54:35.619
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 139612
----------------------------------
Timestamp: 15:54:35.651
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 139612
----------------------------------
Timestamp: 15:54:35.670
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:35.684
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 139612
----------------------------------
Timestamp: 15:54:35.748
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:35.771
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 140508
----------------------------------
Timestamp: 15:54:35.789
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:35.802
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 140508
----------------------------------
Timestamp: 15:54:35.820
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 140508
----------------------------------
Timestamp: 15:54:35.837
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:35.849
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 140508
----------------------------------
Timestamp: 15:54:35.871
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 140508
----------------------------------
Timestamp: 15:54:35.891
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 140508
----------------------------------
Timestamp: 15:54:35.917
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 140508
----------------------------------
Timestamp: 15:54:35.933
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:35.965
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 140508
----------------------------------
Timestamp: 15:54:36.064
SELECT NOMECONTATO,CARGO, CELULAR, EMAIL,  TELEFONE, TIPOCONTATO
FROM PCCONTATO
WHERE CODCLI=:CODCLI
CODCLI = 140508
----------------------------------
Timestamp: 15:54:36.158
SELECT PCCLIENT.CODCLI, PCCLIENT.CLIENTE CLIENTE, PCCLIENT.CODATV1, PCCLIENT.BLOQUEIO,

       PCCLIENT.ENDERCOB AS ENDERENT, PCCLIENT.MUNICCOB AS MUNICENT, PCCLIENT.BAIRROCOB AS BAIRROENT, 
       PCCLIENT.NUMEROCOB NUMEROENT, PCCLIENT.TELCOB AS TELENT, PCCLIENT.CEPCOB AS CEPENT, PCCLIENT.COMPLEMENTOCOB AS 
COMPLEMENTOENT,
       PCCLIENT.CODUSUR1,
	   PCCLIENT.CODUSUR2, PCCLIENT.CODPRACA, PCCLIENT.CODCOB,
       PCCLIENT.TIPOFJ, PCCLIENT.FANTASIA FANTASIA, PCCLIENT.DTULTCOMP, PCCLIENT.IEENT,
       PCCLIENT.CGCENT, PCCLIENT.LIMCRED, PCCLIENT.DTBLOQ , PCCLIENT.ESTENT ESTENT,
       PCPRACA.NUMREGIAO, PCCLIENT.OBSCREDITO, TRUNC(PCCLIENT.DTCADASTRO) DTCADASTRO, PCCLIENT.OBS,
       PCPLPAG.NUMDIAS, PCPLPAG.CODPLPAG, PCCLIENT.PONTOREFER, PCCLIENT.FAXCLI,
       PCCLIENT.NUMSEQ NUMSEQ, PCCLIENT.RG, PCCLIENT.TELCELENT, PCCLIENT.CODPLPAGPADRAO,
       PCCLIENT.RATINGSCI, PCCLIENT.CLASSEVENDA,
       PCCLIENT.CODCIDADE,
       PCCIDADE.NOMECIDADE,
	   0 clTOTACLI, 0 clVLDISP, '                              ' NOMECLIENTE, '                              ' TIPOBLOQUEIO,
	   '                              ' clNOMECLIENTE, '                              ' clRAMO, '                              ' 
clCONTATO

       , ( SELECT SUM ( valor ) valor
             FROM pcprest
            WHERE dtpag IS NULL
              AND codcli = pcclient.codcli
              AND codcob NOT IN ( 'DESD', 'DEVT', 'DEVP' )
            ) clvlreceber
       , ( SELECT SUM ( vlatend ) vlatend
             FROM pcpedc
            WHERE posicao NOT IN ( 'F', 'C' ) AND codcli = pcclient.codcli
            )clvlpendente
       , ( SELECT MAX(vlatend)
           FROM pcpedc
          WHERE posicao NOT IN ( 'F', 'C' )
            AND ( condvenda NOT IN ( 4, 5, 6, 11, 12 ))
            AND ( dtcancel IS NULL )
            AND codcli = pcclient.codcli
            AND DATA =
                ( SELECT MAX ( c.DATA )
                    FROM pcpedc c
                   WHERE c.posicao NOT IN ( 'F', 'C' )
                     AND c.condvenda NOT IN ( 4, 5, 6, 11, 12 )
                     AND c.dtcancel IS NULL
                     AND c.codcli = pcpedc.codcli )
            ) clvalorultimopedido
       , ( SELECT MAX ( DATA )
           FROM pcpedc
          WHERE posicao NOT IN ( 'F', 'C' )
            AND ( condvenda NOT IN ( 4, 5, 6, 11, 12 ))
            AND ( dtcancel IS NULL )
            AND pcpedc.codcli = pcclient.codcli ) cldtultpednaofaturado
	   ,
	   TO_CHAR(
	   ( SELECT MAX ( pcpedc.DATA ) AS DATA
           FROM pcpedc
          WHERE posicao = 'F'
            AND ( condvenda NOT IN ( 4, 5, 6, 11, 12 ))
            AND ( dtcancel IS NULL )
            AND codcli = pcclient.codcli)
		,'DD/MM/YYYY')
			cldataultimopedido			

       , ( SELECT MAX(vlatend)
           FROM pcpedc
          WHERE posicao = 'F'
            AND ( condvenda NOT IN ( 4, 5, 6, 11, 12 ))
            AND ( dtcancel IS NULL )
            AND codcli = pcclient.codcli
            AND DATA =
                   ( SELECT MAX ( c.DATA )
                      FROM pcpedc c
                     WHERE c.posicao = 'F'
                       AND c.condvenda NOT IN ( 4, 5, 6, 11, 12 )
                       AND c.dtcancel IS NULL
                       AND c.codcli = pcpedc.codcli ))
                                                  clvalorultimopedidofaturado,
           pcpraca.praca clpraca
        FROM PCCLIENT,  PCPRACA, PCPLPAG, PCCIDADE

     , PCUSUARI



       WHERE (PCCLIENT.CODPRACA = PCPRACA.CODPRACA(+))
         AND (PCCLIENT.CODPLPAG = PCPLPAG.CODPLPAG(+))
         AND (PCCLIENT.CODCIDADE = PCCIDADE.CODCIDADE(+))

         AND (PCCLIENT.CODUSUR1 = PCUSUARI.CODUSUR)         
  
    AND (PCUSUARI.CODUSUR = :CODUSUR)


AND NVL(PCCLIENT.DTULTCOMP, :DtReferencia) < :DtReferencia 
UNION
SELECT PCCLIENT.CODCLI, PCCLIENT.CLIENTE CLIENTE, PCCLIENT.CODATV1, PCCLIENT.BLOQUEIO,

       PCCLIENT.ENDERCOB AS ENDERENT, PCCLIENT.MUNICCOB AS MUNICENT, PCCLIENT.BAIRROCOB AS BAIRROENT, 
       PCCLIENT.NUMEROCOB NUMEROENT, PCCLIENT.TELCOB AS TELENT, PCCLIENT.CEPCOB AS CEPENT, PCCLIENT.COMPLEMENTOCOB AS 
COMPLEMENTOENT,
       PCCLIENT.CODUSUR2 AS CODUSUR1,
	   PCCLIENT.CODUSUR2, PCCLIENT.CODPRACA, PCCLIENT.CODCOB,
       PCCLIENT.TIPOFJ, PCCLIENT.FANTASIA FANTASIA, PCCLIENT.DTULTCOMP, PCCLIENT.IEENT,
       PCCLIENT.CGCENT, PCCLIENT.LIMCRED, PCCLIENT.DTBLOQ , PCCLIENT.ESTENT ESTENT,
       PCPRACA.NUMREGIAO, PCCLIENT.OBSCREDITO, TRUNC(PCCLIENT.DTCADASTRO) DTCADASTRO, PCCLIENT.OBS,
       PCPLPAG.NUMDIAS, PCPLPAG.CODPLPAG, PCCLIENT.PONTOREFER, PCCLIENT.FAXCLI,
       PCCLIENT.NUMSEQ NUMSEQ, PCCLIENT.RG, PCCLIENT.TELCELENT, PCCLIENT.CODPLPAGPADRAO,
       PCCLIENT.RATINGSCI, PCCLIENT.CLASSEVENDA,
       PCCLIENT.CODCIDADE,
       PCCIDADE.NOMECIDADE,
	   0 clTOTACLI, 0 clVLDISP, '                              ' NOMECLIENTE, '                              ' TIPOBLOQUEIO,
	   '                              ' clNOMECLIENTE, '                              ' clRAMO, '                              ' 
clCONTATO

       , ( SELECT SUM ( valor ) valor
             FROM pcprest
            WHERE dtpag IS NULL
              AND codcli = pcclient.codcli
              AND codcob NOT IN ( 'DESD', 'DEVT', 'DEVP' )
            ) clvlreceber
       , ( SELECT SUM ( vlatend ) vlatend
             FROM pcpedc
            WHERE posicao NOT IN ( 'F', 'C' ) AND codcli = pcclient.codcli
            )clvlpendente
       , ( SELECT MAX(vlatend)
           FROM pcpedc
          WHERE posicao NOT IN ( 'F', 'C' )
            AND ( condvenda NOT IN ( 4, 5, 6, 11, 12 ))
            AND ( dtcancel IS NULL )
            AND codcli = pcclient.codcli
            AND DATA =
                ( SELECT MAX ( c.DATA )
                    FROM pcpedc c
                   WHERE c.posicao NOT IN ( 'F', 'C' )
                     AND c.condvenda NOT IN ( 4, 5, 6, 11, 12 )
                     AND c.dtcancel IS NULL
                     AND c.codcli = pcpedc.codcli )
            ) clvalorultimopedido
       , ( SELECT MAX ( DATA )
           FROM pcpedc
          WHERE posicao NOT IN ( 'F', 'C' )
            AND ( condvenda NOT IN ( 4, 5, 6, 11, 12 ))
            AND ( dtcancel IS NULL )
            AND pcpedc.codcli = pcclient.codcli ) cldtultpednaofaturado
	   ,
	   TO_CHAR(
	   ( SELECT MAX ( pcpedc.DATA ) AS DATA
           FROM pcpedc
          WHERE posicao = 'F'
            AND ( condvenda NOT IN ( 4, 5, 6, 11, 12 ))
            AND ( dtcancel IS NULL )
            AND codcli = pcclient.codcli)
		,'DD/MM/YYYY')
			cldataultimopedido			

       , ( SELECT MAX(vlatend)
           FROM pcpedc
          WHERE posicao = 'F'
            AND ( condvenda NOT IN ( 4, 5, 6, 11, 12 ))
            AND ( dtcancel IS NULL )
            AND codcli = pcclient.codcli
            AND DATA =
                   ( SELECT MAX ( c.DATA )
                      FROM pcpedc c
                     WHERE c.posicao = 'F'
                       AND c.condvenda NOT IN ( 4, 5, 6, 11, 12 )
                       AND c.dtcancel IS NULL
                       AND c.codcli = pcpedc.codcli ))
                                                  clvalorultimopedidofaturado,
           pcpraca.praca clpraca
        FROM PCCLIENT,  PCPRACA, PCPLPAG, PCCIDADE

     , PCUSUARI



       WHERE (PCCLIENT.CODPRACA = PCPRACA.CODPRACA(+))
         AND (PCCLIENT.CODPLPAG = PCPLPAG.CODPLPAG(+))
         AND (PCCLIENT.CODCIDADE = PCCIDADE.CODCIDADE(+))

         AND (PCCLIENT.CODUSUR2 = PCUSUARI.CODUSUR)
  
    AND (PCUSUARI.CODUSUR = :CODUSUR)


AND NVL(PCCLIENT.DTULTCOMP, :DtReferencia) < :DtReferencia 
UNION
SELECT PCCLIENT.CODCLI, PCCLIENT.CLIENTE CLIENTE, PCCLIENT.CODATV1, PCCLIENT.BLOQUEIO,

       PCCLIENT.ENDERCOB AS ENDERENT, PCCLIENT.MUNICCOB AS MUNICENT, PCCLIENT.BAIRROCOB AS BAIRROENT, 
       PCCLIENT.NUMEROCOB NUMEROENT, PCCLIENT.TELCOB AS TELENT, PCCLIENT.CEPCOB AS CEPENT, PCCLIENT.COMPLEMENTOCOB AS 
COMPLEMENTOENT,
      PCUSURCLI.CODUSUR AS CODUSUR1,


	   PCCLIENT.CODUSUR2, PCCLIENT.CODPRACA, PCCLIENT.CODCOB,
       PCCLIENT.TIPOFJ, PCCLIENT.FANTASIA FANTASIA, PCCLIENT.DTULTCOMP, PCCLIENT.IEENT,
       PCCLIENT.CGCENT, PCCLIENT.LIMCRED, PCCLIENT.DTBLOQ , PCCLIENT.ESTENT ESTENT,
       PCPRACA.NUMREGIAO, PCCLIENT.OBSCREDITO, TRUNC(PCCLIENT.DTCADASTRO) DTCADASTRO, PCCLIENT.OBS,
       PCPLPAG.NUMDIAS, PCPLPAG.CODPLPAG, PCCLIENT.PONTOREFER, PCCLIENT.FAXCLI,
       PCCLIENT.NUMSEQ NUMSEQ, PCCLIENT.RG, PCCLIENT.TELCELENT, PCCLIENT.CODPLPAGPADRAO,
       PCCLIENT.RATINGSCI, PCCLIENT.CLASSEVENDA,
       PCCLIENT.CODCIDADE,
       PCCIDADE.NOMECIDADE,
	   0 clTOTACLI, 0 clVLDISP, '                              ' NOMECLIENTE, '                              ' TIPOBLOQUEIO,
	   '                              ' clNOMECLIENTE, '                              ' clRAMO, '                              ' 
clCONTATO

       , ( SELECT SUM ( valor ) valor
             FROM pcprest
            WHERE dtpag IS NULL
              AND codcli = pcclient.codcli
              AND codcob NOT IN ( 'DESD', 'DEVT', 'DEVP' )
            ) clvlreceber
       , ( SELECT SUM ( vlatend ) vlatend
             FROM pcpedc
            WHERE posicao NOT IN ( 'F', 'C' ) AND codcli = pcclient.codcli
            )clvlpendente
       , ( SELECT MAX(vlatend)
           FROM pcpedc
          WHERE posicao NOT IN ( 'F', 'C' )
            AND ( condvenda NOT IN ( 4, 5, 6, 11, 12 ))
            AND ( dtcancel IS NULL )
            AND codcli = pcclient.codcli
            AND DATA =
                ( SELECT MAX ( c.DATA )
                    FROM pcpedc c
                   WHERE c.posicao NOT IN ( 'F', 'C' )
                     AND c.condvenda NOT IN ( 4, 5, 6, 11, 12 )
                     AND c.dtcancel IS NULL
                     AND c.codcli = pcpedc.codcli )
            ) clvalorultimopedido
       , ( SELECT MAX ( DATA )
           FROM pcpedc
          WHERE posicao NOT IN ( 'F', 'C' )
            AND ( condvenda NOT IN ( 4, 5, 6, 11, 12 ))
            AND ( dtcancel IS NULL )
            AND pcpedc.codcli = pcclient.codcli ) cldtultpednaofaturado
	   ,
	   TO_CHAR(
	   ( SELECT MAX ( pcpedc.DATA ) AS DATA
           FROM pcpedc
          WHERE posicao = 'F'
            AND ( condvenda NOT IN ( 4, 5, 6, 11, 12 ))
            AND ( dtcancel IS NULL )
            AND codcli = pcclient.codcli)
		,'DD/MM/YYYY')
			cldataultimopedido			

       , ( SELECT MAX(vlatend)
           FROM pcpedc
          WHERE posicao = 'F'
            AND ( condvenda NOT IN ( 4, 5, 6, 11, 12 ))
            AND ( dtcancel IS NULL )
            AND codcli = pcclient.codcli
            AND DATA =
                   ( SELECT MAX ( c.DATA )
                      FROM pcpedc c
                     WHERE c.posicao = 'F'
                       AND c.condvenda NOT IN ( 4, 5, 6, 11, 12 )
                       AND c.dtcancel IS NULL
                       AND c.codcli = pcpedc.codcli ))
                                                  clvalorultimopedidofaturado,
           pcpraca.praca clpraca
        FROM PCCLIENT,  PCPRACA, PCPLPAG, PCCIDADE

     , PCUSUARI

           , PCUSURCLI


       WHERE (PCCLIENT.CODPRACA = PCPRACA.CODPRACA(+))
         AND (PCCLIENT.CODPLPAG = PCPLPAG.CODPLPAG(+))
         AND (PCCLIENT.CODCIDADE = PCCIDADE.CODCIDADE(+))

         AND (PCCLIENT.CODCLI = PCUSURCLI.CODCLI)
		 AND (PCUSURCLI.CODUSUR = PCUSUARI.CODUSUR)
  
    AND (PCUSUARI.CODUSUR = :CODUSUR)


AND NVL(PCCLIENT.DTULTCOMP, :DtReferencia) < :DtReferencia 
ORDER BY NUMSEQ
CODUSUR = 1291
DtReferencia = '01/10/2023'
----------------------------------
Timestamp: 15:54:36.608
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:36.621
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 3080
----------------------------------
Timestamp: 15:54:36.638
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:36.651
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 3080
----------------------------------
Timestamp: 15:54:36.669
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 3080
----------------------------------
Timestamp: 15:54:36.686
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:36.697
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 3080
----------------------------------
Timestamp: 15:54:36.720
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 3080
----------------------------------
Timestamp: 15:54:36.738
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 3080
----------------------------------
Timestamp: 15:54:36.765
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 3080
----------------------------------
Timestamp: 15:54:36.782
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:36.794
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 3080
----------------------------------
Timestamp: 15:54:36.834
SELECT '' TABLE_CATALOG, IC.TABLE_OWNER TABLE_SCHEMA, IC.TABLE_NAME, '' INDEX_CATALOG, IC.INDEX_OWNER INDEX_SCHEMA, 
IC.INDEX_NAME, IC.COLUMN_NAME, IC.COLUMN_POSITION, DECODE(IC.DESCEND, 'ASC', 0, 1) DESCENDING FROM SYS.ALL_IND_COLUMNS IC, 
SYS.ALL_INDEXES I, SYS.ALL_CONSTRAINTS C WHERE IC.TABLE_OWNER = 'FRIOBOM' AND IC.TABLE_NAME = 'PCCLIENT' AND I.UNIQUENESS = 
'UNIQUE' AND        I.OWNER = IC.INDEX_OWNER AND I.INDEX_NAME = IC.INDEX_NAME AND       C.TABLE_NAME (+) = IC.TABLE_NAME AND 
C.INDEX_NAME (+) = IC.INDEX_NAME AND C.OWNER (+)= IC.TABLE_OWNER ORDER BY DECODE(IC.INDEX_OWNER, 'FRIOBOM', 0, 'PUBLIC', 1, 2), 
DECODE(C.CONSTRAINT_TYPE, 'P', 1, 'U', 2, 3), IC.INDEX_OWNER, IC.TABLE_OWNER, IC.TABLE_NAME, IC.INDEX_NAME, IC.COLUMN_POSITION
----------------------------------
Timestamp: 15:54:36.862
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:36.878
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 4820
----------------------------------
Timestamp: 15:54:36.896
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:36.908
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 4820
----------------------------------
Timestamp: 15:54:36.926
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 4820
----------------------------------
Timestamp: 15:54:36.943
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:36.953
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 4820
----------------------------------
Timestamp: 15:54:36.979
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 4820
----------------------------------
Timestamp: 15:54:36.997
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 4820
----------------------------------
Timestamp: 15:54:37.031
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 4820
----------------------------------
Timestamp: 15:54:37.053
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:37.071
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 4820
----------------------------------
Timestamp: 15:54:37.116
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:37.129
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 5413
----------------------------------
Timestamp: 15:54:37.148
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:37.166
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 5413
----------------------------------
Timestamp: 15:54:37.183
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 5413
----------------------------------
Timestamp: 15:54:37.201
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:37.214
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 5413
----------------------------------
Timestamp: 15:54:37.238
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 5413
----------------------------------
Timestamp: 15:54:37.258
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 5413
----------------------------------
Timestamp: 15:54:37.284
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 5413
----------------------------------
Timestamp: 15:54:37.302
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:37.316
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 5413
----------------------------------
Timestamp: 15:54:37.357
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:37.369
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 10094
----------------------------------
Timestamp: 15:54:37.386
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:37.399
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 10094
----------------------------------
Timestamp: 15:54:37.413
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 10094
----------------------------------
Timestamp: 15:54:37.432
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:37.444
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 10094
----------------------------------
Timestamp: 15:54:37.471
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 10094
----------------------------------
Timestamp: 15:54:37.490
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 10094
----------------------------------
Timestamp: 15:54:37.516
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 10094
----------------------------------
Timestamp: 15:54:37.536
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:37.550
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 10094
----------------------------------
Timestamp: 15:54:37.593
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:37.607
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 102794
----------------------------------
Timestamp: 15:54:37.624
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:37.638
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 102794
----------------------------------
Timestamp: 15:54:37.658
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 102794
----------------------------------
Timestamp: 15:54:37.675
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:37.686
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 102794
----------------------------------
Timestamp: 15:54:37.708
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 102794
----------------------------------
Timestamp: 15:54:37.726
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 102794
----------------------------------
Timestamp: 15:54:37.759
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 102794
----------------------------------
Timestamp: 15:54:37.791
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:37.807
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 102794
----------------------------------
Timestamp: 15:54:37.850
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. AUT. POR 90 DIAS INATIVO'
----------------------------------
Timestamp: 15:54:37.868
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:37.880
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 103087
----------------------------------
Timestamp: 15:54:37.896
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:37.907
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 103087
----------------------------------
Timestamp: 15:54:37.924
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 103087
----------------------------------
Timestamp: 15:54:37.941
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:37.953
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 103087
----------------------------------
Timestamp: 15:54:37.974
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 103087
----------------------------------
Timestamp: 15:54:37.993
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 103087
----------------------------------
Timestamp: 15:54:38.020
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 103087
----------------------------------
Timestamp: 15:54:38.042
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:38.058
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 103087
----------------------------------
Timestamp: 15:54:38.101
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:38.114
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 110335
----------------------------------
Timestamp: 15:54:38.131
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:38.144
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 110335
----------------------------------
Timestamp: 15:54:38.162
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 110335
----------------------------------
Timestamp: 15:54:38.181
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:38.191
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 110335
----------------------------------
Timestamp: 15:54:38.216
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 110335
----------------------------------
Timestamp: 15:54:38.236
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 110335
----------------------------------
Timestamp: 15:54:38.263
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 110335
----------------------------------
Timestamp: 15:54:38.282
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:38.293
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 110335
----------------------------------
Timestamp: 15:54:38.331
SELECT '' TABLE_CATALOG, IC.TABLE_OWNER TABLE_SCHEMA, IC.TABLE_NAME, '' INDEX_CATALOG, IC.INDEX_OWNER INDEX_SCHEMA, 
IC.INDEX_NAME, IC.COLUMN_NAME, IC.COLUMN_POSITION, DECODE(IC.DESCEND, 'ASC', 0, 1) DESCENDING FROM SYS.ALL_IND_COLUMNS IC, 
SYS.ALL_INDEXES I, SYS.ALL_CONSTRAINTS C WHERE IC.TABLE_OWNER = 'FRIOBOM' AND IC.TABLE_NAME = 'PCHIST' AND I.UNIQUENESS = 
'UNIQUE' AND        I.OWNER = IC.INDEX_OWNER AND I.INDEX_NAME = IC.INDEX_NAME AND       C.TABLE_NAME (+) = IC.TABLE_NAME AND 
C.INDEX_NAME (+) = IC.INDEX_NAME AND C.OWNER (+)= IC.TABLE_OWNER ORDER BY DECODE(IC.INDEX_OWNER, 'FRIOBOM', 0, 'PUBLIC', 1, 2), 
DECODE(C.CONSTRAINT_TYPE, 'P', 1, 'U', 2, 3), IC.INDEX_OWNER, IC.TABLE_OWNER, IC.TABLE_NAME, IC.INDEX_NAME, IC.COLUMN_POSITION
----------------------------------
Timestamp: 15:54:38.342
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. AUTOMATICO DEFINITIVO'
----------------------------------
Timestamp: 15:54:38.359
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:38.372
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 110902
----------------------------------
Timestamp: 15:54:38.390
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:38.404
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 110902
----------------------------------
Timestamp: 15:54:38.420
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 110902
----------------------------------
Timestamp: 15:54:38.437
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:38.450
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 110902
----------------------------------
Timestamp: 15:54:38.476
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 110902
----------------------------------
Timestamp: 15:54:38.498
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 110902
----------------------------------
Timestamp: 15:54:38.525
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 110902
----------------------------------
Timestamp: 15:54:38.542
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:38.559
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 110902
----------------------------------
Timestamp: 15:54:38.601
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:38.615
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 113109
----------------------------------
Timestamp: 15:54:38.631
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:38.644
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 113109
----------------------------------
Timestamp: 15:54:38.660
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 113109
----------------------------------
Timestamp: 15:54:38.677
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:38.688
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 113109
----------------------------------
Timestamp: 15:54:38.710
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 113109
----------------------------------
Timestamp: 15:54:38.729
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 113109
----------------------------------
Timestamp: 15:54:38.754
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 113109
----------------------------------
Timestamp: 15:54:38.771
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:38.785
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 113109
----------------------------------
Timestamp: 15:54:38.827
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:38.840
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 115041
----------------------------------
Timestamp: 15:54:38.856
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:38.868
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 115041
----------------------------------
Timestamp: 15:54:38.884
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 115041
----------------------------------
Timestamp: 15:54:38.901
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:38.913
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 115041
----------------------------------
Timestamp: 15:54:38.935
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 115041
----------------------------------
Timestamp: 15:54:38.956
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 115041
----------------------------------
Timestamp: 15:54:38.984
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 115041
----------------------------------
Timestamp: 15:54:39.001
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:39.015
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 115041
----------------------------------
Timestamp: 15:54:39.062
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:39.075
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 115611
----------------------------------
Timestamp: 15:54:39.094
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:39.106
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 115611
----------------------------------
Timestamp: 15:54:39.124
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 115611
----------------------------------
Timestamp: 15:54:39.142
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:39.154
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 115611
----------------------------------
Timestamp: 15:54:39.176
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 115611
----------------------------------
Timestamp: 15:54:39.194
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 115611
----------------------------------
Timestamp: 15:54:39.219
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 115611
----------------------------------
Timestamp: 15:54:39.237
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:39.248
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 115611
----------------------------------
Timestamp: 15:54:39.287
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. AUT. POR 90 DIAS INATIVO'
----------------------------------
Timestamp: 15:54:39.305
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:39.317
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 116471
----------------------------------
Timestamp: 15:54:39.335
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:39.348
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 116471
----------------------------------
Timestamp: 15:54:39.363
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 116471
----------------------------------
Timestamp: 15:54:39.382
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:39.391
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 116471
----------------------------------
Timestamp: 15:54:39.415
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 116471
----------------------------------
Timestamp: 15:54:39.433
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 116471
----------------------------------
Timestamp: 15:54:39.485
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 116471
----------------------------------
Timestamp: 15:54:39.504
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:39.516
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 116471
----------------------------------
Timestamp: 15:54:39.559
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. SEFAZ'
----------------------------------
Timestamp: 15:54:39.578
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:39.590
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 119057
----------------------------------
Timestamp: 15:54:39.613
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:39.625
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 119057
----------------------------------
Timestamp: 15:54:39.644
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 119057
----------------------------------
Timestamp: 15:54:39.663
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:39.673
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 119057
----------------------------------
Timestamp: 15:54:39.697
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 119057
----------------------------------
Timestamp: 15:54:39.714
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 119057
----------------------------------
Timestamp: 15:54:39.740
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 119057
----------------------------------
Timestamp: 15:54:39.757
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:39.772
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 119057
----------------------------------
Timestamp: 15:54:39.814
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. AUT. POR 90 DIAS INATIVO'
----------------------------------
Timestamp: 15:54:39.833
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:39.845
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 119890
----------------------------------
Timestamp: 15:54:39.863
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:39.876
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 119890
----------------------------------
Timestamp: 15:54:39.893
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 119890
----------------------------------
Timestamp: 15:54:39.912
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:39.922
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 119890
----------------------------------
Timestamp: 15:54:39.945
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 119890
----------------------------------
Timestamp: 15:54:39.964
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 119890
----------------------------------
Timestamp: 15:54:39.988
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 119890
----------------------------------
Timestamp: 15:54:40.006
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:40.018
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 119890
----------------------------------
Timestamp: 15:54:40.067
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. AUT. POR 90 DIAS INATIVO'
----------------------------------
Timestamp: 15:54:40.085
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:40.098
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 120057
----------------------------------
Timestamp: 15:54:40.114
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:40.125
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 120057
----------------------------------
Timestamp: 15:54:40.144
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 120057
----------------------------------
Timestamp: 15:54:40.163
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:40.173
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 120057
----------------------------------
Timestamp: 15:54:40.198
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 120057
----------------------------------
Timestamp: 15:54:40.218
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 120057
----------------------------------
Timestamp: 15:54:40.244
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 120057
----------------------------------
Timestamp: 15:54:40.261
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:40.274
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 120057
----------------------------------
Timestamp: 15:54:40.313
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:40.326
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 120291
----------------------------------
Timestamp: 15:54:40.342
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:40.356
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 120291
----------------------------------
Timestamp: 15:54:40.371
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 120291
----------------------------------
Timestamp: 15:54:40.389
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:40.401
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 120291
----------------------------------
Timestamp: 15:54:40.425
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 120291
----------------------------------
Timestamp: 15:54:40.443
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 120291
----------------------------------
Timestamp: 15:54:40.474
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 120291
----------------------------------
Timestamp: 15:54:40.494
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:40.509
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 120291
----------------------------------
Timestamp: 15:54:40.552
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. SEFAZ'
----------------------------------
Timestamp: 15:54:40.569
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:40.584
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 120297
----------------------------------
Timestamp: 15:54:40.602
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:40.616
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 120297
----------------------------------
Timestamp: 15:54:40.638
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 120297
----------------------------------
Timestamp: 15:54:40.655
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:40.666
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 120297
----------------------------------
Timestamp: 15:54:40.688
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 120297
----------------------------------
Timestamp: 15:54:40.706
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 120297
----------------------------------
Timestamp: 15:54:40.730
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 120297
----------------------------------
Timestamp: 15:54:40.747
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:40.757
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 120297
----------------------------------
Timestamp: 15:54:40.798
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. SEFAZ'
----------------------------------
Timestamp: 15:54:40.817
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:40.828
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 120890
----------------------------------
Timestamp: 15:54:40.845
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:40.857
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 120890
----------------------------------
Timestamp: 15:54:40.874
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 120890
----------------------------------
Timestamp: 15:54:40.891
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:40.904
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 120890
----------------------------------
Timestamp: 15:54:40.927
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 120890
----------------------------------
Timestamp: 15:54:40.946
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 120890
----------------------------------
Timestamp: 15:54:40.971
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 120890
----------------------------------
Timestamp: 15:54:40.989
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:41.001
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 120890
----------------------------------
Timestamp: 15:54:41.051
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. AUT. POR 90 DIAS INATIVO'
----------------------------------
Timestamp: 15:54:41.070
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:41.084
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 123334
----------------------------------
Timestamp: 15:54:41.102
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:41.116
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 123334
----------------------------------
Timestamp: 15:54:41.134
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 123334
----------------------------------
Timestamp: 15:54:41.152
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:41.162
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 123334
----------------------------------
Timestamp: 15:54:41.187
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 123334
----------------------------------
Timestamp: 15:54:41.206
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 123334
----------------------------------
Timestamp: 15:54:41.234
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 123334
----------------------------------
Timestamp: 15:54:41.251
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:41.262
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 123334
----------------------------------
Timestamp: 15:54:41.303
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:41.316
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 125639
----------------------------------
Timestamp: 15:54:41.331
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:41.342
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 125639
----------------------------------
Timestamp: 15:54:41.360
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 125639
----------------------------------
Timestamp: 15:54:41.377
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:41.389
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 125639
----------------------------------
Timestamp: 15:54:41.411
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 125639
----------------------------------
Timestamp: 15:54:41.430
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 125639
----------------------------------
Timestamp: 15:54:41.455
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 125639
----------------------------------
Timestamp: 15:54:41.476
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:41.488
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 125639
----------------------------------
Timestamp: 15:54:41.531
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:41.543
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 126024
----------------------------------
Timestamp: 15:54:41.560
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:41.573
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 126024
----------------------------------
Timestamp: 15:54:41.589
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 126024
----------------------------------
Timestamp: 15:54:41.608
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:41.620
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 126024
----------------------------------
Timestamp: 15:54:41.649
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 126024
----------------------------------
Timestamp: 15:54:41.670
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 126024
----------------------------------
Timestamp: 15:54:41.694
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 126024
----------------------------------
Timestamp: 15:54:41.711
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:41.723
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 126024
----------------------------------
Timestamp: 15:54:41.763
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. AUTOMATICO TIT. ATRASADOS'
----------------------------------
Timestamp: 15:54:41.783
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:41.794
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 126136
----------------------------------
Timestamp: 15:54:41.810
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:41.823
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 126136
----------------------------------
Timestamp: 15:54:41.840
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 126136
----------------------------------
Timestamp: 15:54:41.858
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:41.868
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 126136
----------------------------------
Timestamp: 15:54:41.890
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 126136
----------------------------------
Timestamp: 15:54:41.910
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 126136
----------------------------------
Timestamp: 15:54:41.936
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 126136
----------------------------------
Timestamp: 15:54:41.954
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:41.965
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 126136
----------------------------------
Timestamp: 15:54:42.005
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:42.020
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 128232
----------------------------------
Timestamp: 15:54:42.040
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:42.058
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 128232
----------------------------------
Timestamp: 15:54:42.076
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 128232
----------------------------------
Timestamp: 15:54:42.093
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:42.104
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 128232
----------------------------------
Timestamp: 15:54:42.126
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 128232
----------------------------------
Timestamp: 15:54:42.148
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 128232
----------------------------------
Timestamp: 15:54:42.173
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 128232
----------------------------------
Timestamp: 15:54:42.191
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:42.203
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 128232
----------------------------------
Timestamp: 15:54:42.243
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. AUT. POR 90 DIAS INATIVO'
----------------------------------
Timestamp: 15:54:42.261
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:42.275
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 128279
----------------------------------
Timestamp: 15:54:42.291
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:42.304
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 128279
----------------------------------
Timestamp: 15:54:42.319
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 128279
----------------------------------
Timestamp: 15:54:42.337
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:42.347
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 128279
----------------------------------
Timestamp: 15:54:42.370
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 128279
----------------------------------
Timestamp: 15:54:42.388
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 128279
----------------------------------
Timestamp: 15:54:42.412
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 128279
----------------------------------
Timestamp: 15:54:42.429
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:42.442
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 128279
----------------------------------
Timestamp: 15:54:42.487
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. SEFAZ'
----------------------------------
Timestamp: 15:54:42.504
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:42.517
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 128443
----------------------------------
Timestamp: 15:54:42.534
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:42.547
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 128443
----------------------------------
Timestamp: 15:54:42.565
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 128443
----------------------------------
Timestamp: 15:54:42.584
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:42.595
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 128443
----------------------------------
Timestamp: 15:54:42.618
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 128443
----------------------------------
Timestamp: 15:54:42.637
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 128443
----------------------------------
Timestamp: 15:54:42.665
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 128443
----------------------------------
Timestamp: 15:54:42.681
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:42.693
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 128443
----------------------------------
Timestamp: 15:54:42.737
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. AUT. POR 90 DIAS INATIVO'
----------------------------------
Timestamp: 15:54:42.755
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:42.768
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 128893
----------------------------------
Timestamp: 15:54:42.785
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:42.798
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 128893
----------------------------------
Timestamp: 15:54:42.814
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 128893
----------------------------------
Timestamp: 15:54:42.833
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:42.843
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 128893
----------------------------------
Timestamp: 15:54:42.872
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 128893
----------------------------------
Timestamp: 15:54:42.893
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 128893
----------------------------------
Timestamp: 15:54:42.919
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 128893
----------------------------------
Timestamp: 15:54:42.936
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:42.947
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 128893
----------------------------------
Timestamp: 15:54:42.987
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:43.000
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 130882
----------------------------------
Timestamp: 15:54:43.016
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:43.028
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 130882
----------------------------------
Timestamp: 15:54:43.052
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 130882
----------------------------------
Timestamp: 15:54:43.071
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:43.082
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 130882
----------------------------------
Timestamp: 15:54:43.106
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 130882
----------------------------------
Timestamp: 15:54:43.126
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 130882
----------------------------------
Timestamp: 15:54:43.153
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 130882
----------------------------------
Timestamp: 15:54:43.171
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:43.181
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 130882
----------------------------------
Timestamp: 15:54:43.221
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. AUT. POR 90 DIAS INATIVO'
----------------------------------
Timestamp: 15:54:43.239
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:43.252
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 130984
----------------------------------
Timestamp: 15:54:43.270
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:43.283
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 130984
----------------------------------
Timestamp: 15:54:43.298
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 130984
----------------------------------
Timestamp: 15:54:43.315
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:43.326
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 130984
----------------------------------
Timestamp: 15:54:43.347
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 130984
----------------------------------
Timestamp: 15:54:43.366
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 130984
----------------------------------
Timestamp: 15:54:43.390
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 130984
----------------------------------
Timestamp: 15:54:43.407
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:43.419
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 130984
----------------------------------
Timestamp: 15:54:43.458
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. AUT. POR 90 DIAS INATIVO'
----------------------------------
Timestamp: 15:54:43.477
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:43.492
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 131035
----------------------------------
Timestamp: 15:54:43.508
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:43.521
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 131035
----------------------------------
Timestamp: 15:54:43.538
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 131035
----------------------------------
Timestamp: 15:54:43.557
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:43.575
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 131035
----------------------------------
Timestamp: 15:54:43.598
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 131035
----------------------------------
Timestamp: 15:54:43.617
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 131035
----------------------------------
Timestamp: 15:54:43.642
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 131035
----------------------------------
Timestamp: 15:54:43.660
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:43.673
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 131035
----------------------------------
Timestamp: 15:54:43.711
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. AUT. POR 90 DIAS INATIVO'
----------------------------------
Timestamp: 15:54:43.729
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:43.745
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 136325
----------------------------------
Timestamp: 15:54:43.766
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:43.779
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 136325
----------------------------------
Timestamp: 15:54:43.796
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 136325
----------------------------------
Timestamp: 15:54:43.815
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:43.826
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 136325
----------------------------------
Timestamp: 15:54:43.848
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 136325
----------------------------------
Timestamp: 15:54:43.867
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 136325
----------------------------------
Timestamp: 15:54:43.892
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 136325
----------------------------------
Timestamp: 15:54:43.910
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:43.939
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 136325
----------------------------------
Timestamp: 15:54:43.982
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:43.995
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 136554
----------------------------------
Timestamp: 15:54:44.015
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:44.029
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 136554
----------------------------------
Timestamp: 15:54:44.054
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 136554
----------------------------------
Timestamp: 15:54:44.074
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:44.085
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 136554
----------------------------------
Timestamp: 15:54:44.108
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 136554
----------------------------------
Timestamp: 15:54:44.126
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 136554
----------------------------------
Timestamp: 15:54:44.152
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 136554
----------------------------------
Timestamp: 15:54:44.170
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:44.181
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 136554
----------------------------------
Timestamp: 15:54:44.223
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. AUTOMATICO TIT. ATRASADOS'
----------------------------------
Timestamp: 15:54:44.240
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:44.254
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 136600
----------------------------------
Timestamp: 15:54:44.270
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:44.283
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 136600
----------------------------------
Timestamp: 15:54:44.299
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 136600
----------------------------------
Timestamp: 15:54:44.318
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:44.327
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 136600
----------------------------------
Timestamp: 15:54:44.349
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 136600
----------------------------------
Timestamp: 15:54:44.367
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 136600
----------------------------------
Timestamp: 15:54:44.393
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 136600
----------------------------------
Timestamp: 15:54:44.410
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:44.422
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 136600
----------------------------------
Timestamp: 15:54:44.462
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:44.479
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 137254
----------------------------------
Timestamp: 15:54:44.496
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:44.508
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 137254
----------------------------------
Timestamp: 15:54:44.527
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 137254
----------------------------------
Timestamp: 15:54:44.547
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:44.559
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 137254
----------------------------------
Timestamp: 15:54:44.583
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 137254
----------------------------------
Timestamp: 15:54:44.603
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 137254
----------------------------------
Timestamp: 15:54:44.628
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 137254
----------------------------------
Timestamp: 15:54:44.648
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:44.660
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 137254
----------------------------------
Timestamp: 15:54:44.701
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:44.714
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 137458
----------------------------------
Timestamp: 15:54:44.744
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:44.771
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 137458
----------------------------------
Timestamp: 15:54:44.790
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 137458
----------------------------------
Timestamp: 15:54:44.807
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:44.819
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 137458
----------------------------------
Timestamp: 15:54:44.861
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 137458
----------------------------------
Timestamp: 15:54:44.881
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 137458
----------------------------------
Timestamp: 15:54:44.912
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 137458
----------------------------------
Timestamp: 15:54:44.929
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:44.941
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 137458
----------------------------------
Timestamp: 15:54:44.983
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:44.996
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 139612
----------------------------------
Timestamp: 15:54:45.015
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:45.029
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 139612
----------------------------------
Timestamp: 15:54:45.052
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 139612
----------------------------------
Timestamp: 15:54:45.072
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:45.084
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 139612
----------------------------------
Timestamp: 15:54:45.110
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 139612
----------------------------------
Timestamp: 15:54:45.128
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 139612
----------------------------------
Timestamp: 15:54:45.157
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 139612
----------------------------------
Timestamp: 15:54:45.175
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:45.187
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 139612
----------------------------------
Timestamp: 15:54:45.226
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:45.240
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 140508
----------------------------------
Timestamp: 15:54:45.255
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:45.268
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 140508
----------------------------------
Timestamp: 15:54:45.283
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 140508
----------------------------------
Timestamp: 15:54:45.304
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:45.314
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 140508
----------------------------------
Timestamp: 15:54:45.337
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 140508
----------------------------------
Timestamp: 15:54:45.355
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 140508
----------------------------------
Timestamp: 15:54:45.380
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 140508
----------------------------------
Timestamp: 15:54:45.398
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:45.409
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 140508
----------------------------------
Timestamp: 15:54:45.448
SELECT '' TABLE_CATALOG, IC.TABLE_OWNER TABLE_SCHEMA, IC.TABLE_NAME, '' INDEX_CATALOG, IC.INDEX_OWNER INDEX_SCHEMA, 
IC.INDEX_NAME, IC.COLUMN_NAME, IC.COLUMN_POSITION, DECODE(IC.DESCEND, 'ASC', 0, 1) DESCENDING FROM SYS.ALL_IND_COLUMNS IC, 
SYS.ALL_INDEXES I, SYS.ALL_CONSTRAINTS C WHERE IC.TABLE_OWNER = 'FRIOBOM' AND IC.TABLE_NAME = 'PCCONTATO' AND I.UNIQUENESS = 
'UNIQUE' AND        I.OWNER = IC.INDEX_OWNER AND I.INDEX_NAME = IC.INDEX_NAME AND       C.TABLE_NAME (+) = IC.TABLE_NAME AND 
C.INDEX_NAME (+) = IC.INDEX_NAME AND C.OWNER (+)= IC.TABLE_OWNER ORDER BY DECODE(IC.INDEX_OWNER, 'FRIOBOM', 0, 'PUBLIC', 1, 2), 
DECODE(C.CONSTRAINT_TYPE, 'P', 1, 'U', 2, 3), IC.INDEX_OWNER, IC.TABLE_OWNER, IC.TABLE_NAME, IC.INDEX_NAME, IC.COLUMN_POSITION
----------------------------------
Timestamp: 15:54:45.459
SELECT NOMECONTATO,CARGO, CELULAR, EMAIL,  TELEFONE, TIPOCONTATO
FROM PCCONTATO
WHERE CODCLI=:CODCLI
CODCLI = 140508
----------------------------------
Timestamp: 15:54:45.608
SELECT SUM(TOTALCLI.ATIVO) TOTALCLIATIVOS,
       SUM(TOTALCLI.INATIVO) TOTALCLIINATIVOS,
       SUM(TOTALCLI.BLOQUEADO) TOTALCLIBLOQ,
       COUNT(DISTINCT(TOTALCLI.CODCLI)) TOTALCLI
  FROM ( SELECT DISTINCT
           CODCLI,
           CASE WHEN EXCLUIDO = 'N' AND ATIVO = 'S' THEN 1 ELSE 0 END ATIVO,
           CASE WHEN EXCLUIDO = 'N' AND ATIVO = 'S' THEN 0 ELSE 1 END INATIVO,
           CASE WHEN BLOQUEADO = 'S' THEN 1 ELSE 0 END BLOQUEADO
    FROM 
       (SELECT PCCLIENT.CODCLI
            , CASE WHEN PCCLIENT.DTULTCOMP >= :DTREFERENCIA THEN 'S' ELSE 'N' END ATIVO
            , CASE WHEN PCCLIENT.DTEXCLUSAO IS NULL THEN 'N' ELSE 'S' END EXCLUIDO
            , CASE WHEN PCCLIENT.BLOQUEIO = 'S' THEN 'N' ELSE 'S' END BLOQUEADO
          FROM PCCLIENT, PCUSUARI
             , PCPRACA
         WHERE PCCLIENT.CODUSUR1 = PCUSUARI.CODUSUR
           AND PCCLIENT.CODPRACA = PCPRACA.CODPRACA(+)
		   AND (PCUSUARI.CODSUPERVISOR IN ( '42' ))
	  AND NVL(PCCLIENT.DTULTCOMP, :DTREFERENCIA) < :DTREFERENCIA
        UNION
        SELECT PCCLIENT.CODCLI
            , CASE WHEN PCCLIENT.DTULTCOMP >= :DTREFERENCIA THEN 'S' ELSE 'N' END ATIVO
            , CASE WHEN PCCLIENT.DTEXCLUSAO IS NULL THEN 'N' ELSE 'S' END EXCLUIDO
            , CASE WHEN PCCLIENT.BLOQUEIO = 'S' THEN 'N' ELSE 'S' END BLOQUEADO
          FROM PCCLIENT, PCUSUARI
             , PCPRACA
         WHERE PCCLIENT.CODUSUR2 = PCUSUARI.CODUSUR
           AND PCCLIENT.CODPRACA = PCPRACA.CODPRACA(+)
		   AND (PCUSUARI.CODSUPERVISOR IN ( '42' ))
	  AND NVL(PCCLIENT.DTULTCOMP, :DTREFERENCIA) < :DTREFERENCIA
        UNION
        SELECT PCCLIENT.CODCLI
             , CASE WHEN PCCLIENT.DTULTCOMP >= :DTREFERENCIA THEN 'S' ELSE 'N' END ATIVO
             , CASE WHEN PCCLIENT.DTEXCLUSAO IS NULL THEN 'N' ELSE 'S' END EXCLUIDO
             , CASE WHEN PCCLIENT.BLOQUEIO = 'S' THEN 'N' ELSE 'S' END BLOQUEADO
          FROM PCCLIENT, PCUSURCLI, PCUSUARI
             , PCPRACA
         WHERE PCUSURCLI.CODUSUR = PCUSUARI.CODUSUR
           AND PCCLIENT.CODPRACA = PCPRACA.CODPRACA(+)
		   AND (PCUSUARI.CODSUPERVISOR IN ( '42' ))
	  AND NVL(PCCLIENT.DTULTCOMP, :DTREFERENCIA) < :DTREFERENCIA
           AND PCCLIENT.CODCLI = PCUSURCLI.CODCLI
		   ) TOTALCLI
    ) TOTALCLI
DTREFERENCIA = '01/10/2023'
----------------------------------
Timestamp: 15:54:45.764
SELECT PCCLIENT.CODCLI, PCCLIENT.CLIENTE CLIENTE, PCCLIENT.CODATV1, PCCLIENT.BLOQUEIO,

       PCCLIENT.ENDERCOB AS ENDERENT, PCCLIENT.MUNICCOB AS MUNICENT, PCCLIENT.BAIRROCOB AS BAIRROENT, 
       PCCLIENT.NUMEROCOB NUMEROENT, PCCLIENT.TELCOB AS TELENT, PCCLIENT.CEPCOB AS CEPENT, PCCLIENT.COMPLEMENTOCOB AS 
COMPLEMENTOENT,
       PCCLIENT.CODUSUR1,
	   PCCLIENT.CODUSUR2, PCCLIENT.CODPRACA, PCCLIENT.CODCOB,
       PCCLIENT.TIPOFJ, PCCLIENT.FANTASIA FANTASIA, PCCLIENT.DTULTCOMP, PCCLIENT.IEENT,
       PCCLIENT.CGCENT, PCCLIENT.LIMCRED, PCCLIENT.DTBLOQ , PCCLIENT.ESTENT ESTENT,
       PCPRACA.NUMREGIAO, PCCLIENT.OBSCREDITO, TRUNC(PCCLIENT.DTCADASTRO) DTCADASTRO, PCCLIENT.OBS,
       PCPLPAG.NUMDIAS, PCPLPAG.CODPLPAG, PCCLIENT.PONTOREFER, PCCLIENT.FAXCLI,
       PCCLIENT.NUMSEQ NUMSEQ, PCCLIENT.RG, PCCLIENT.TELCELENT, PCCLIENT.CODPLPAGPADRAO,
       PCCLIENT.RATINGSCI, PCCLIENT.CLASSEVENDA,
       PCCLIENT.CODCIDADE,
       PCCIDADE.NOMECIDADE,
	   0 clTOTACLI, 0 clVLDISP, '                              ' NOMECLIENTE, '                              ' TIPOBLOQUEIO,
	   '                              ' clNOMECLIENTE, '                              ' clRAMO, '                              ' 
clCONTATO

       , ( SELECT SUM ( valor ) valor
             FROM pcprest
            WHERE dtpag IS NULL
              AND codcli = pcclient.codcli
              AND codcob NOT IN ( 'DESD', 'DEVT', 'DEVP' )
            ) clvlreceber
       , ( SELECT SUM ( vlatend ) vlatend
             FROM pcpedc
            WHERE posicao NOT IN ( 'F', 'C' ) AND codcli = pcclient.codcli
            )clvlpendente
       , ( SELECT MAX(vlatend)
           FROM pcpedc
          WHERE posicao NOT IN ( 'F', 'C' )
            AND ( condvenda NOT IN ( 4, 5, 6, 11, 12 ))
            AND ( dtcancel IS NULL )
            AND codcli = pcclient.codcli
            AND DATA =
                ( SELECT MAX ( c.DATA )
                    FROM pcpedc c
                   WHERE c.posicao NOT IN ( 'F', 'C' )
                     AND c.condvenda NOT IN ( 4, 5, 6, 11, 12 )
                     AND c.dtcancel IS NULL
                     AND c.codcli = pcpedc.codcli )
            ) clvalorultimopedido
       , ( SELECT MAX ( DATA )
           FROM pcpedc
          WHERE posicao NOT IN ( 'F', 'C' )
            AND ( condvenda NOT IN ( 4, 5, 6, 11, 12 ))
            AND ( dtcancel IS NULL )
            AND pcpedc.codcli = pcclient.codcli ) cldtultpednaofaturado
	   ,
	   TO_CHAR(
	   ( SELECT MAX ( pcpedc.DATA ) AS DATA
           FROM pcpedc
          WHERE posicao = 'F'
            AND ( condvenda NOT IN ( 4, 5, 6, 11, 12 ))
            AND ( dtcancel IS NULL )
            AND codcli = pcclient.codcli)
		,'DD/MM/YYYY')
			cldataultimopedido			

       , ( SELECT MAX(vlatend)
           FROM pcpedc
          WHERE posicao = 'F'
            AND ( condvenda NOT IN ( 4, 5, 6, 11, 12 ))
            AND ( dtcancel IS NULL )
            AND codcli = pcclient.codcli
            AND DATA =
                   ( SELECT MAX ( c.DATA )
                      FROM pcpedc c
                     WHERE c.posicao = 'F'
                       AND c.condvenda NOT IN ( 4, 5, 6, 11, 12 )
                       AND c.dtcancel IS NULL
                       AND c.codcli = pcpedc.codcli ))
                                                  clvalorultimopedidofaturado,
           pcpraca.praca clpraca
        FROM PCCLIENT,  PCPRACA, PCPLPAG, PCCIDADE

     , PCUSUARI



       WHERE (PCCLIENT.CODPRACA = PCPRACA.CODPRACA(+))
         AND (PCCLIENT.CODPLPAG = PCPLPAG.CODPLPAG(+))
         AND (PCCLIENT.CODCIDADE = PCCIDADE.CODCIDADE(+))

         AND (PCCLIENT.CODUSUR1 = PCUSUARI.CODUSUR)         
  
    AND (PCUSUARI.CODUSUR = :CODUSUR)


AND NVL(PCCLIENT.DTULTCOMP, :DtReferencia) < :DtReferencia 
UNION
SELECT PCCLIENT.CODCLI, PCCLIENT.CLIENTE CLIENTE, PCCLIENT.CODATV1, PCCLIENT.BLOQUEIO,

       PCCLIENT.ENDERCOB AS ENDERENT, PCCLIENT.MUNICCOB AS MUNICENT, PCCLIENT.BAIRROCOB AS BAIRROENT, 
       PCCLIENT.NUMEROCOB NUMEROENT, PCCLIENT.TELCOB AS TELENT, PCCLIENT.CEPCOB AS CEPENT, PCCLIENT.COMPLEMENTOCOB AS 
COMPLEMENTOENT,
       PCCLIENT.CODUSUR2 AS CODUSUR1,
	   PCCLIENT.CODUSUR2, PCCLIENT.CODPRACA, PCCLIENT.CODCOB,
       PCCLIENT.TIPOFJ, PCCLIENT.FANTASIA FANTASIA, PCCLIENT.DTULTCOMP, PCCLIENT.IEENT,
       PCCLIENT.CGCENT, PCCLIENT.LIMCRED, PCCLIENT.DTBLOQ , PCCLIENT.ESTENT ESTENT,
       PCPRACA.NUMREGIAO, PCCLIENT.OBSCREDITO, TRUNC(PCCLIENT.DTCADASTRO) DTCADASTRO, PCCLIENT.OBS,
       PCPLPAG.NUMDIAS, PCPLPAG.CODPLPAG, PCCLIENT.PONTOREFER, PCCLIENT.FAXCLI,
       PCCLIENT.NUMSEQ NUMSEQ, PCCLIENT.RG, PCCLIENT.TELCELENT, PCCLIENT.CODPLPAGPADRAO,
       PCCLIENT.RATINGSCI, PCCLIENT.CLASSEVENDA,
       PCCLIENT.CODCIDADE,
       PCCIDADE.NOMECIDADE,
	   0 clTOTACLI, 0 clVLDISP, '                              ' NOMECLIENTE, '                              ' TIPOBLOQUEIO,
	   '                              ' clNOMECLIENTE, '                              ' clRAMO, '                              ' 
clCONTATO

       , ( SELECT SUM ( valor ) valor
             FROM pcprest
            WHERE dtpag IS NULL
              AND codcli = pcclient.codcli
              AND codcob NOT IN ( 'DESD', 'DEVT', 'DEVP' )
            ) clvlreceber
       , ( SELECT SUM ( vlatend ) vlatend
             FROM pcpedc
            WHERE posicao NOT IN ( 'F', 'C' ) AND codcli = pcclient.codcli
            )clvlpendente
       , ( SELECT MAX(vlatend)
           FROM pcpedc
          WHERE posicao NOT IN ( 'F', 'C' )
            AND ( condvenda NOT IN ( 4, 5, 6, 11, 12 ))
            AND ( dtcancel IS NULL )
            AND codcli = pcclient.codcli
            AND DATA =
                ( SELECT MAX ( c.DATA )
                    FROM pcpedc c
                   WHERE c.posicao NOT IN ( 'F', 'C' )
                     AND c.condvenda NOT IN ( 4, 5, 6, 11, 12 )
                     AND c.dtcancel IS NULL
                     AND c.codcli = pcpedc.codcli )
            ) clvalorultimopedido
       , ( SELECT MAX ( DATA )
           FROM pcpedc
          WHERE posicao NOT IN ( 'F', 'C' )
            AND ( condvenda NOT IN ( 4, 5, 6, 11, 12 ))
            AND ( dtcancel IS NULL )
            AND pcpedc.codcli = pcclient.codcli ) cldtultpednaofaturado
	   ,
	   TO_CHAR(
	   ( SELECT MAX ( pcpedc.DATA ) AS DATA
           FROM pcpedc
          WHERE posicao = 'F'
            AND ( condvenda NOT IN ( 4, 5, 6, 11, 12 ))
            AND ( dtcancel IS NULL )
            AND codcli = pcclient.codcli)
		,'DD/MM/YYYY')
			cldataultimopedido			

       , ( SELECT MAX(vlatend)
           FROM pcpedc
          WHERE posicao = 'F'
            AND ( condvenda NOT IN ( 4, 5, 6, 11, 12 ))
            AND ( dtcancel IS NULL )
            AND codcli = pcclient.codcli
            AND DATA =
                   ( SELECT MAX ( c.DATA )
                      FROM pcpedc c
                     WHERE c.posicao = 'F'
                       AND c.condvenda NOT IN ( 4, 5, 6, 11, 12 )
                       AND c.dtcancel IS NULL
                       AND c.codcli = pcpedc.codcli ))
                                                  clvalorultimopedidofaturado,
           pcpraca.praca clpraca
        FROM PCCLIENT,  PCPRACA, PCPLPAG, PCCIDADE

     , PCUSUARI



       WHERE (PCCLIENT.CODPRACA = PCPRACA.CODPRACA(+))
         AND (PCCLIENT.CODPLPAG = PCPLPAG.CODPLPAG(+))
         AND (PCCLIENT.CODCIDADE = PCCIDADE.CODCIDADE(+))

         AND (PCCLIENT.CODUSUR2 = PCUSUARI.CODUSUR)
  
    AND (PCUSUARI.CODUSUR = :CODUSUR)


AND NVL(PCCLIENT.DTULTCOMP, :DtReferencia) < :DtReferencia 
UNION
SELECT PCCLIENT.CODCLI, PCCLIENT.CLIENTE CLIENTE, PCCLIENT.CODATV1, PCCLIENT.BLOQUEIO,

       PCCLIENT.ENDERCOB AS ENDERENT, PCCLIENT.MUNICCOB AS MUNICENT, PCCLIENT.BAIRROCOB AS BAIRROENT, 
       PCCLIENT.NUMEROCOB NUMEROENT, PCCLIENT.TELCOB AS TELENT, PCCLIENT.CEPCOB AS CEPENT, PCCLIENT.COMPLEMENTOCOB AS 
COMPLEMENTOENT,
      PCUSURCLI.CODUSUR AS CODUSUR1,


	   PCCLIENT.CODUSUR2, PCCLIENT.CODPRACA, PCCLIENT.CODCOB,
       PCCLIENT.TIPOFJ, PCCLIENT.FANTASIA FANTASIA, PCCLIENT.DTULTCOMP, PCCLIENT.IEENT,
       PCCLIENT.CGCENT, PCCLIENT.LIMCRED, PCCLIENT.DTBLOQ , PCCLIENT.ESTENT ESTENT,
       PCPRACA.NUMREGIAO, PCCLIENT.OBSCREDITO, TRUNC(PCCLIENT.DTCADASTRO) DTCADASTRO, PCCLIENT.OBS,
       PCPLPAG.NUMDIAS, PCPLPAG.CODPLPAG, PCCLIENT.PONTOREFER, PCCLIENT.FAXCLI,
       PCCLIENT.NUMSEQ NUMSEQ, PCCLIENT.RG, PCCLIENT.TELCELENT, PCCLIENT.CODPLPAGPADRAO,
       PCCLIENT.RATINGSCI, PCCLIENT.CLASSEVENDA,
       PCCLIENT.CODCIDADE,
       PCCIDADE.NOMECIDADE,
	   0 clTOTACLI, 0 clVLDISP, '                              ' NOMECLIENTE, '                              ' TIPOBLOQUEIO,
	   '                              ' clNOMECLIENTE, '                              ' clRAMO, '                              ' 
clCONTATO

       , ( SELECT SUM ( valor ) valor
             FROM pcprest
            WHERE dtpag IS NULL
              AND codcli = pcclient.codcli
              AND codcob NOT IN ( 'DESD', 'DEVT', 'DEVP' )
            ) clvlreceber
       , ( SELECT SUM ( vlatend ) vlatend
             FROM pcpedc
            WHERE posicao NOT IN ( 'F', 'C' ) AND codcli = pcclient.codcli
            )clvlpendente
       , ( SELECT MAX(vlatend)
           FROM pcpedc
          WHERE posicao NOT IN ( 'F', 'C' )
            AND ( condvenda NOT IN ( 4, 5, 6, 11, 12 ))
            AND ( dtcancel IS NULL )
            AND codcli = pcclient.codcli
            AND DATA =
                ( SELECT MAX ( c.DATA )
                    FROM pcpedc c
                   WHERE c.posicao NOT IN ( 'F', 'C' )
                     AND c.condvenda NOT IN ( 4, 5, 6, 11, 12 )
                     AND c.dtcancel IS NULL
                     AND c.codcli = pcpedc.codcli )
            ) clvalorultimopedido
       , ( SELECT MAX ( DATA )
           FROM pcpedc
          WHERE posicao NOT IN ( 'F', 'C' )
            AND ( condvenda NOT IN ( 4, 5, 6, 11, 12 ))
            AND ( dtcancel IS NULL )
            AND pcpedc.codcli = pcclient.codcli ) cldtultpednaofaturado
	   ,
	   TO_CHAR(
	   ( SELECT MAX ( pcpedc.DATA ) AS DATA
           FROM pcpedc
          WHERE posicao = 'F'
            AND ( condvenda NOT IN ( 4, 5, 6, 11, 12 ))
            AND ( dtcancel IS NULL )
            AND codcli = pcclient.codcli)
		,'DD/MM/YYYY')
			cldataultimopedido			

       , ( SELECT MAX(vlatend)
           FROM pcpedc
          WHERE posicao = 'F'
            AND ( condvenda NOT IN ( 4, 5, 6, 11, 12 ))
            AND ( dtcancel IS NULL )
            AND codcli = pcclient.codcli
            AND DATA =
                   ( SELECT MAX ( c.DATA )
                      FROM pcpedc c
                     WHERE c.posicao = 'F'
                       AND c.condvenda NOT IN ( 4, 5, 6, 11, 12 )
                       AND c.dtcancel IS NULL
                       AND c.codcli = pcpedc.codcli ))
                                                  clvalorultimopedidofaturado,
           pcpraca.praca clpraca
        FROM PCCLIENT,  PCPRACA, PCPLPAG, PCCIDADE

     , PCUSUARI

           , PCUSURCLI


       WHERE (PCCLIENT.CODPRACA = PCPRACA.CODPRACA(+))
         AND (PCCLIENT.CODPLPAG = PCPLPAG.CODPLPAG(+))
         AND (PCCLIENT.CODCIDADE = PCCIDADE.CODCIDADE(+))

         AND (PCCLIENT.CODCLI = PCUSURCLI.CODCLI)
		 AND (PCUSURCLI.CODUSUR = PCUSUARI.CODUSUR)
  
    AND (PCUSUARI.CODUSUR = :CODUSUR)


AND NVL(PCCLIENT.DTULTCOMP, :DtReferencia) < :DtReferencia 
ORDER BY NUMSEQ
CODUSUR = 1291
DtReferencia = '01/10/2023'
----------------------------------
Timestamp: 15:54:46.238
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:46.250
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 3080
----------------------------------
Timestamp: 15:54:46.267
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:46.279
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 3080
----------------------------------
Timestamp: 15:54:46.296
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 3080
----------------------------------
Timestamp: 15:54:46.313
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:46.325
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 3080
----------------------------------
Timestamp: 15:54:46.346
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 3080
----------------------------------
Timestamp: 15:54:46.364
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 3080
----------------------------------
Timestamp: 15:54:46.389
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 3080
----------------------------------
Timestamp: 15:54:46.406
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:46.418
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 3080
----------------------------------
Timestamp: 15:54:46.456
SELECT '' TABLE_CATALOG, IC.TABLE_OWNER TABLE_SCHEMA, IC.TABLE_NAME, '' INDEX_CATALOG, IC.INDEX_OWNER INDEX_SCHEMA, 
IC.INDEX_NAME, IC.COLUMN_NAME, IC.COLUMN_POSITION, DECODE(IC.DESCEND, 'ASC', 0, 1) DESCENDING FROM SYS.ALL_IND_COLUMNS IC, 
SYS.ALL_INDEXES I, SYS.ALL_CONSTRAINTS C WHERE IC.TABLE_OWNER = 'FRIOBOM' AND IC.TABLE_NAME = 'PCCLIENT' AND I.UNIQUENESS = 
'UNIQUE' AND        I.OWNER = IC.INDEX_OWNER AND I.INDEX_NAME = IC.INDEX_NAME AND       C.TABLE_NAME (+) = IC.TABLE_NAME AND 
C.INDEX_NAME (+) = IC.INDEX_NAME AND C.OWNER (+)= IC.TABLE_OWNER ORDER BY DECODE(IC.INDEX_OWNER, 'FRIOBOM', 0, 'PUBLIC', 1, 2), 
DECODE(C.CONSTRAINT_TYPE, 'P', 1, 'U', 2, 3), IC.INDEX_OWNER, IC.TABLE_OWNER, IC.TABLE_NAME, IC.INDEX_NAME, IC.COLUMN_POSITION
----------------------------------
Timestamp: 15:54:46.483
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:46.499
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 4820
----------------------------------
Timestamp: 15:54:46.517
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:46.530
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 4820
----------------------------------
Timestamp: 15:54:46.548
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 4820
----------------------------------
Timestamp: 15:54:46.564
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:46.576
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 4820
----------------------------------
Timestamp: 15:54:46.600
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 4820
----------------------------------
Timestamp: 15:54:46.620
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 4820
----------------------------------
Timestamp: 15:54:46.645
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 4820
----------------------------------
Timestamp: 15:54:46.664
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:46.680
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 4820
----------------------------------
Timestamp: 15:54:46.723
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:46.735
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 5413
----------------------------------
Timestamp: 15:54:46.751
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:46.765
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 5413
----------------------------------
Timestamp: 15:54:46.781
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 5413
----------------------------------
Timestamp: 15:54:46.799
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:46.810
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 5413
----------------------------------
Timestamp: 15:54:46.832
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 5413
----------------------------------
Timestamp: 15:54:46.850
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 5413
----------------------------------
Timestamp: 15:54:46.875
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 5413
----------------------------------
Timestamp: 15:54:46.892
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:46.903
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 5413
----------------------------------
Timestamp: 15:54:46.943
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:46.954
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 10094
----------------------------------
Timestamp: 15:54:46.971
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:46.982
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 10094
----------------------------------
Timestamp: 15:54:46.999
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 10094
----------------------------------
Timestamp: 15:54:47.020
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:47.031
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 10094
----------------------------------
Timestamp: 15:54:47.060
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 10094
----------------------------------
Timestamp: 15:54:47.081
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 10094
----------------------------------
Timestamp: 15:54:47.111
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 10094
----------------------------------
Timestamp: 15:54:47.130
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:47.143
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 10094
----------------------------------
Timestamp: 15:54:47.184
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:47.196
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 102794
----------------------------------
Timestamp: 15:54:47.212
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:47.226
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 102794
----------------------------------
Timestamp: 15:54:47.243
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 102794
----------------------------------
Timestamp: 15:54:47.261
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:47.273
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 102794
----------------------------------
Timestamp: 15:54:47.295
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 102794
----------------------------------
Timestamp: 15:54:47.312
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 102794
----------------------------------
Timestamp: 15:54:47.339
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 102794
----------------------------------
Timestamp: 15:54:47.358
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:47.370
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 102794
----------------------------------
Timestamp: 15:54:47.409
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. AUT. POR 90 DIAS INATIVO'
----------------------------------
Timestamp: 15:54:47.428
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:47.441
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 103087
----------------------------------
Timestamp: 15:54:47.458
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:47.473
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 103087
----------------------------------
Timestamp: 15:54:47.491
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 103087
----------------------------------
Timestamp: 15:54:47.509
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:47.519
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 103087
----------------------------------
Timestamp: 15:54:47.542
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 103087
----------------------------------
Timestamp: 15:54:47.561
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 103087
----------------------------------
Timestamp: 15:54:47.587
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 103087
----------------------------------
Timestamp: 15:54:47.606
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:47.623
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 103087
----------------------------------
Timestamp: 15:54:47.666
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:47.678
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 110335
----------------------------------
Timestamp: 15:54:47.694
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:47.707
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 110335
----------------------------------
Timestamp: 15:54:47.724
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 110335
----------------------------------
Timestamp: 15:54:47.743
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:47.752
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 110335
----------------------------------
Timestamp: 15:54:47.776
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 110335
----------------------------------
Timestamp: 15:54:47.793
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 110335
----------------------------------
Timestamp: 15:54:47.818
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 110335
----------------------------------
Timestamp: 15:54:47.834
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:47.847
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 110335
----------------------------------
Timestamp: 15:54:47.887
SELECT '' TABLE_CATALOG, IC.TABLE_OWNER TABLE_SCHEMA, IC.TABLE_NAME, '' INDEX_CATALOG, IC.INDEX_OWNER INDEX_SCHEMA, 
IC.INDEX_NAME, IC.COLUMN_NAME, IC.COLUMN_POSITION, DECODE(IC.DESCEND, 'ASC', 0, 1) DESCENDING FROM SYS.ALL_IND_COLUMNS IC, 
SYS.ALL_INDEXES I, SYS.ALL_CONSTRAINTS C WHERE IC.TABLE_OWNER = 'FRIOBOM' AND IC.TABLE_NAME = 'PCHIST' AND I.UNIQUENESS = 
'UNIQUE' AND        I.OWNER = IC.INDEX_OWNER AND I.INDEX_NAME = IC.INDEX_NAME AND       C.TABLE_NAME (+) = IC.TABLE_NAME AND 
C.INDEX_NAME (+) = IC.INDEX_NAME AND C.OWNER (+)= IC.TABLE_OWNER ORDER BY DECODE(IC.INDEX_OWNER, 'FRIOBOM', 0, 'PUBLIC', 1, 2), 
DECODE(C.CONSTRAINT_TYPE, 'P', 1, 'U', 2, 3), IC.INDEX_OWNER, IC.TABLE_OWNER, IC.TABLE_NAME, IC.INDEX_NAME, IC.COLUMN_POSITION
----------------------------------
Timestamp: 15:54:47.899
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. AUTOMATICO DEFINITIVO'
----------------------------------
Timestamp: 15:54:47.916
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:47.930
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 110902
----------------------------------
Timestamp: 15:54:47.951
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:47.965
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 110902
----------------------------------
Timestamp: 15:54:47.985
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 110902
----------------------------------
Timestamp: 15:54:48.005
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:48.017
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 110902
----------------------------------
Timestamp: 15:54:48.045
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 110902
----------------------------------
Timestamp: 15:54:48.067
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 110902
----------------------------------
Timestamp: 15:54:48.095
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 110902
----------------------------------
Timestamp: 15:54:48.112
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:48.130
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 110902
----------------------------------
Timestamp: 15:54:48.178
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:48.190
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 113109
----------------------------------
Timestamp: 15:54:48.208
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:48.220
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 113109
----------------------------------
Timestamp: 15:54:48.236
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 113109
----------------------------------
Timestamp: 15:54:48.254
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:48.265
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 113109
----------------------------------
Timestamp: 15:54:48.290
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 113109
----------------------------------
Timestamp: 15:54:48.309
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 113109
----------------------------------
Timestamp: 15:54:48.334
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 113109
----------------------------------
Timestamp: 15:54:48.352
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:48.366
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 113109
----------------------------------
Timestamp: 15:54:48.407
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:48.421
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 115041
----------------------------------
Timestamp: 15:54:48.437
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:48.450
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 115041
----------------------------------
Timestamp: 15:54:48.470
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 115041
----------------------------------
Timestamp: 15:54:48.489
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:48.499
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 115041
----------------------------------
Timestamp: 15:54:48.522
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 115041
----------------------------------
Timestamp: 15:54:48.540
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 115041
----------------------------------
Timestamp: 15:54:48.565
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 115041
----------------------------------
Timestamp: 15:54:48.584
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:48.599
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 115041
----------------------------------
Timestamp: 15:54:48.644
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:48.658
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 115611
----------------------------------
Timestamp: 15:54:48.677
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:48.689
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 115611
----------------------------------
Timestamp: 15:54:48.706
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 115611
----------------------------------
Timestamp: 15:54:48.725
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:48.735
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 115611
----------------------------------
Timestamp: 15:54:48.760
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 115611
----------------------------------
Timestamp: 15:54:48.778
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 115611
----------------------------------
Timestamp: 15:54:48.805
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 115611
----------------------------------
Timestamp: 15:54:48.823
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:48.835
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 115611
----------------------------------
Timestamp: 15:54:48.877
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. AUT. POR 90 DIAS INATIVO'
----------------------------------
Timestamp: 15:54:48.896
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:48.909
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 116471
----------------------------------
Timestamp: 15:54:48.927
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:48.939
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 116471
----------------------------------
Timestamp: 15:54:48.958
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 116471
----------------------------------
Timestamp: 15:54:48.975
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:48.985
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 116471
----------------------------------
Timestamp: 15:54:49.011
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 116471
----------------------------------
Timestamp: 15:54:49.035
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 116471
----------------------------------
Timestamp: 15:54:49.064
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 116471
----------------------------------
Timestamp: 15:54:49.082
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:49.096
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 116471
----------------------------------
Timestamp: 15:54:49.141
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. SEFAZ'
----------------------------------
Timestamp: 15:54:49.161
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:49.175
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 119057
----------------------------------
Timestamp: 15:54:49.192
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:49.205
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 119057
----------------------------------
Timestamp: 15:54:49.223
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 119057
----------------------------------
Timestamp: 15:54:49.242
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:49.251
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 119057
----------------------------------
Timestamp: 15:54:49.275
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 119057
----------------------------------
Timestamp: 15:54:49.293
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 119057
----------------------------------
Timestamp: 15:54:49.318
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 119057
----------------------------------
Timestamp: 15:54:49.337
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:49.353
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 119057
----------------------------------
Timestamp: 15:54:49.395
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. AUT. POR 90 DIAS INATIVO'
----------------------------------
Timestamp: 15:54:49.412
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:49.425
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 119890
----------------------------------
Timestamp: 15:54:49.443
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:49.456
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 119890
----------------------------------
Timestamp: 15:54:49.474
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 119890
----------------------------------
Timestamp: 15:54:49.493
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:49.504
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 119890
----------------------------------
Timestamp: 15:54:49.528
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 119890
----------------------------------
Timestamp: 15:54:49.547
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 119890
----------------------------------
Timestamp: 15:54:49.574
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 119890
----------------------------------
Timestamp: 15:54:49.592
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:49.604
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 119890
----------------------------------
Timestamp: 15:54:49.646
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. AUT. POR 90 DIAS INATIVO'
----------------------------------
Timestamp: 15:54:49.664
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:49.677
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 120057
----------------------------------
Timestamp: 15:54:49.695
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:49.708
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 120057
----------------------------------
Timestamp: 15:54:49.726
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 120057
----------------------------------
Timestamp: 15:54:49.744
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:49.754
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 120057
----------------------------------
Timestamp: 15:54:49.779
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 120057
----------------------------------
Timestamp: 15:54:49.796
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 120057
----------------------------------
Timestamp: 15:54:49.821
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 120057
----------------------------------
Timestamp: 15:54:49.838
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:49.851
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 120057
----------------------------------
Timestamp: 15:54:49.892
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:49.906
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 120291
----------------------------------
Timestamp: 15:54:49.923
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:49.936
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 120291
----------------------------------
Timestamp: 15:54:49.953
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 120291
----------------------------------
Timestamp: 15:54:49.971
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:49.982
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 120291
----------------------------------
Timestamp: 15:54:50.007
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 120291
----------------------------------
Timestamp: 15:54:50.026
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 120291
----------------------------------
Timestamp: 15:54:50.060
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 120291
----------------------------------
Timestamp: 15:54:50.078
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:50.091
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 120291
----------------------------------
Timestamp: 15:54:50.129
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. SEFAZ'
----------------------------------
Timestamp: 15:54:50.149
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:50.163
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 120297
----------------------------------
Timestamp: 15:54:50.180
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:50.192
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 120297
----------------------------------
Timestamp: 15:54:50.210
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 120297
----------------------------------
Timestamp: 15:54:50.229
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:50.239
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 120297
----------------------------------
Timestamp: 15:54:50.261
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 120297
----------------------------------
Timestamp: 15:54:50.279
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 120297
----------------------------------
Timestamp: 15:54:50.306
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 120297
----------------------------------
Timestamp: 15:54:50.328
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:50.343
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 120297
----------------------------------
Timestamp: 15:54:50.385
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. SEFAZ'
----------------------------------
Timestamp: 15:54:50.409
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:50.424
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 120890
----------------------------------
Timestamp: 15:54:50.443
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:50.456
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 120890
----------------------------------
Timestamp: 15:54:50.479
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 120890
----------------------------------
Timestamp: 15:54:50.497
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:50.509
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 120890
----------------------------------
Timestamp: 15:54:50.536
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 120890
----------------------------------
Timestamp: 15:54:50.559
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 120890
----------------------------------
Timestamp: 15:54:50.593
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 120890
----------------------------------
Timestamp: 15:54:50.616
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:50.637
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 120890
----------------------------------
Timestamp: 15:54:50.681
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. AUT. POR 90 DIAS INATIVO'
----------------------------------
Timestamp: 15:54:50.704
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:50.720
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 123334
----------------------------------
Timestamp: 15:54:50.739
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:50.755
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 123334
----------------------------------
Timestamp: 15:54:50.775
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 123334
----------------------------------
Timestamp: 15:54:50.795
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:50.810
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 123334
----------------------------------
Timestamp: 15:54:50.836
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 123334
----------------------------------
Timestamp: 15:54:50.861
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 123334
----------------------------------
Timestamp: 15:54:50.910
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 123334
----------------------------------
Timestamp: 15:54:50.930
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:50.951
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 123334
----------------------------------
Timestamp: 15:54:50.995
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:51.012
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 125639
----------------------------------
Timestamp: 15:54:51.040
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:51.057
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 125639
----------------------------------
Timestamp: 15:54:51.075
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 125639
----------------------------------
Timestamp: 15:54:51.097
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:51.108
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 125639
----------------------------------
Timestamp: 15:54:51.137
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 125639
----------------------------------
Timestamp: 15:54:51.162
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 125639
----------------------------------
Timestamp: 15:54:51.194
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 125639
----------------------------------
Timestamp: 15:54:51.219
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:51.235
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 125639
----------------------------------
Timestamp: 15:54:51.282
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:51.299
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 126024
----------------------------------
Timestamp: 15:54:51.321
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:51.336
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 126024
----------------------------------
Timestamp: 15:54:51.358
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 126024
----------------------------------
Timestamp: 15:54:51.380
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:51.393
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 126024
----------------------------------
Timestamp: 15:54:51.418
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 126024
----------------------------------
Timestamp: 15:54:51.443
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 126024
----------------------------------
Timestamp: 15:54:51.476
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 126024
----------------------------------
Timestamp: 15:54:51.498
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:51.520
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 126024
----------------------------------
Timestamp: 15:54:51.569
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. AUTOMATICO TIT. ATRASADOS'
----------------------------------
Timestamp: 15:54:51.593
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:51.610
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 126136
----------------------------------
Timestamp: 15:54:51.628
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:51.650
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 126136
----------------------------------
Timestamp: 15:54:51.679
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 126136
----------------------------------
Timestamp: 15:54:51.698
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:51.713
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 126136
----------------------------------
Timestamp: 15:54:51.742
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 126136
----------------------------------
Timestamp: 15:54:51.766
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 126136
----------------------------------
Timestamp: 15:54:51.797
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 126136
----------------------------------
Timestamp: 15:54:51.827
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:51.840
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 126136
----------------------------------
Timestamp: 15:54:51.884
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:51.898
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 128232
----------------------------------
Timestamp: 15:54:51.920
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:51.940
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 128232
----------------------------------
Timestamp: 15:54:51.959
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 128232
----------------------------------
Timestamp: 15:54:51.980
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:51.990
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 128232
----------------------------------
Timestamp: 15:54:52.023
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 128232
----------------------------------
Timestamp: 15:54:52.052
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 128232
----------------------------------
Timestamp: 15:54:52.088
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 128232
----------------------------------
Timestamp: 15:54:52.112
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:52.126
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 128232
----------------------------------
Timestamp: 15:54:52.174
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. AUT. POR 90 DIAS INATIVO'
----------------------------------
Timestamp: 15:54:52.197
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:52.210
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 128279
----------------------------------
Timestamp: 15:54:52.240
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:52.265
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 128279
----------------------------------
Timestamp: 15:54:52.286
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 128279
----------------------------------
Timestamp: 15:54:52.306
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:52.323
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 128279
----------------------------------
Timestamp: 15:54:52.352
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 128279
----------------------------------
Timestamp: 15:54:52.378
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 128279
----------------------------------
Timestamp: 15:54:52.408
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 128279
----------------------------------
Timestamp: 15:54:52.432
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:52.450
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 128279
----------------------------------
Timestamp: 15:54:52.501
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. SEFAZ'
----------------------------------
Timestamp: 15:54:52.521
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:52.537
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 128443
----------------------------------
Timestamp: 15:54:52.558
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:52.572
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 128443
----------------------------------
Timestamp: 15:54:52.590
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 128443
----------------------------------
Timestamp: 15:54:52.613
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:52.625
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 128443
----------------------------------
Timestamp: 15:54:52.654
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 128443
----------------------------------
Timestamp: 15:54:52.679
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 128443
----------------------------------
Timestamp: 15:54:52.712
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 128443
----------------------------------
Timestamp: 15:54:52.736
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:52.753
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 128443
----------------------------------
Timestamp: 15:54:52.797
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. AUT. POR 90 DIAS INATIVO'
----------------------------------
Timestamp: 15:54:52.821
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:52.837
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 128893
----------------------------------
Timestamp: 15:54:52.858
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:52.874
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 128893
----------------------------------
Timestamp: 15:54:52.893
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 128893
----------------------------------
Timestamp: 15:54:52.913
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:52.929
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 128893
----------------------------------
Timestamp: 15:54:52.952
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 128893
----------------------------------
Timestamp: 15:54:52.977
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 128893
----------------------------------
Timestamp: 15:54:53.014
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 128893
----------------------------------
Timestamp: 15:54:53.047
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:53.073
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 128893
----------------------------------
Timestamp: 15:54:53.127
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:53.142
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 130882
----------------------------------
Timestamp: 15:54:53.162
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:53.180
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 130882
----------------------------------
Timestamp: 15:54:53.200
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 130882
----------------------------------
Timestamp: 15:54:53.220
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:53.233
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 130882
----------------------------------
Timestamp: 15:54:53.260
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 130882
----------------------------------
Timestamp: 15:54:53.284
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 130882
----------------------------------
Timestamp: 15:54:53.315
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 130882
----------------------------------
Timestamp: 15:54:53.342
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:53.357
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 130882
----------------------------------
Timestamp: 15:54:53.401
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. AUT. POR 90 DIAS INATIVO'
----------------------------------
Timestamp: 15:54:53.428
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:53.439
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 130984
----------------------------------
Timestamp: 15:54:53.459
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:53.475
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 130984
----------------------------------
Timestamp: 15:54:53.491
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 130984
----------------------------------
Timestamp: 15:54:53.510
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:53.520
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 130984
----------------------------------
Timestamp: 15:54:53.543
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 130984
----------------------------------
Timestamp: 15:54:53.561
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 130984
----------------------------------
Timestamp: 15:54:53.588
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 130984
----------------------------------
Timestamp: 15:54:53.606
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:53.619
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 130984
----------------------------------
Timestamp: 15:54:53.666
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. AUT. POR 90 DIAS INATIVO'
----------------------------------
Timestamp: 15:54:53.683
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:53.699
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 131035
----------------------------------
Timestamp: 15:54:53.716
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:53.730
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 131035
----------------------------------
Timestamp: 15:54:53.753
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 131035
----------------------------------
Timestamp: 15:54:53.772
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:53.784
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 131035
----------------------------------
Timestamp: 15:54:53.812
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 131035
----------------------------------
Timestamp: 15:54:53.836
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 131035
----------------------------------
Timestamp: 15:54:53.870
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 131035
----------------------------------
Timestamp: 15:54:53.892
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:53.907
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 131035
----------------------------------
Timestamp: 15:54:53.950
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. AUT. POR 90 DIAS INATIVO'
----------------------------------
Timestamp: 15:54:53.973
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:53.989
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 136325
----------------------------------
Timestamp: 15:54:54.009
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:54.025
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 136325
----------------------------------
Timestamp: 15:54:54.050
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 136325
----------------------------------
Timestamp: 15:54:54.071
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:54.084
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 136325
----------------------------------
Timestamp: 15:54:54.110
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 136325
----------------------------------
Timestamp: 15:54:54.131
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 136325
----------------------------------
Timestamp: 15:54:54.167
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 136325
----------------------------------
Timestamp: 15:54:54.188
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:54.204
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 136325
----------------------------------
Timestamp: 15:54:54.249
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:54.266
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 136554
----------------------------------
Timestamp: 15:54:54.286
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:54.302
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 136554
----------------------------------
Timestamp: 15:54:54.322
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 136554
----------------------------------
Timestamp: 15:54:54.345
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:54.357
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 136554
----------------------------------
Timestamp: 15:54:54.386
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 136554
----------------------------------
Timestamp: 15:54:54.407
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 136554
----------------------------------
Timestamp: 15:54:54.441
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 136554
----------------------------------
Timestamp: 15:54:54.464
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:54.484
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 136554
----------------------------------
Timestamp: 15:54:54.530
SELECT COUNT(*) AS CONTADOR
FROM PCHIST
WHERE TIPO = 'B'
AND HISTORICO = :HISTORICO
HISTORICO = 'BLOQ. AUTOMATICO TIT. ATRASADOS'
----------------------------------
Timestamp: 15:54:54.552
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:54.568
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 136600
----------------------------------
Timestamp: 15:54:54.590
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:54.610
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 136600
----------------------------------
Timestamp: 15:54:54.631
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 136600
----------------------------------
Timestamp: 15:54:54.654
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:54.676
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 136600
----------------------------------
Timestamp: 15:54:54.704
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 136600
----------------------------------
Timestamp: 15:54:54.731
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 136600
----------------------------------
Timestamp: 15:54:54.764
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 136600
----------------------------------
Timestamp: 15:54:54.789
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:54.804
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 136600
----------------------------------
Timestamp: 15:54:54.851
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:54.868
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 137254
----------------------------------
Timestamp: 15:54:54.890
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:54.907
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 137254
----------------------------------
Timestamp: 15:54:54.927
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 137254
----------------------------------
Timestamp: 15:54:54.951
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:54.970
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 137254
----------------------------------
Timestamp: 15:54:54.998
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 137254
----------------------------------
Timestamp: 15:54:55.023
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 137254
----------------------------------
Timestamp: 15:54:55.060
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 137254
----------------------------------
Timestamp: 15:54:55.085
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:55.102
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 137254
----------------------------------
Timestamp: 15:54:55.150
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:55.163
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 137458
----------------------------------
Timestamp: 15:54:55.189
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:55.206
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 137458
----------------------------------
Timestamp: 15:54:55.225
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 137458
----------------------------------
Timestamp: 15:54:55.249
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:55.263
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 137458
----------------------------------
Timestamp: 15:54:55.290
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 137458
----------------------------------
Timestamp: 15:54:55.315
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 137458
----------------------------------
Timestamp: 15:54:55.349
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 137458
----------------------------------
Timestamp: 15:54:55.371
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:55.387
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 137458
----------------------------------
Timestamp: 15:54:55.444
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:55.465
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 139612
----------------------------------
Timestamp: 15:54:55.486
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:55.500
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 139612
----------------------------------
Timestamp: 15:54:55.518
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 139612
----------------------------------
Timestamp: 15:54:55.539
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:55.553
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 139612
----------------------------------
Timestamp: 15:54:55.577
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 139612
----------------------------------
Timestamp: 15:54:55.603
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 139612
----------------------------------
Timestamp: 15:54:55.634
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 139612
----------------------------------
Timestamp: 15:54:55.656
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:55.675
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 139612
----------------------------------
Timestamp: 15:54:55.722
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:55.740
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 140508
----------------------------------
Timestamp: 15:54:55.759
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 15:54:55.775
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 140508
----------------------------------
Timestamp: 15:54:55.794
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 140508
----------------------------------
Timestamp: 15:54:55.818
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 15:54:55.829
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 140508
----------------------------------
Timestamp: 15:54:55.858
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 140508
----------------------------------
Timestamp: 15:54:55.881
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 140508
----------------------------------
Timestamp: 15:54:55.912
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 140508
----------------------------------
Timestamp: 15:54:55.934
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 15:54:55.951
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 140508
----------------------------------
Timestamp: 15:54:55.993
SELECT NOMECONTATO,CARGO, CELULAR, EMAIL,  TELEFONE, TIPOCONTATO
FROM PCCONTATO
WHERE CODCLI=:CODCLI
CODCLI = 140508