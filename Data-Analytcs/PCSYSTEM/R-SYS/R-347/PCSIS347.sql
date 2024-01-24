----------------------------------
Timestamp: 17:27:38.602
SELECT LAST_DAY(:DTFIM) DATA FROM DUAL
DTFIM = '31/01/2024'
----------------------------------
Timestamp: 17:27:38.617
SELECT TRUNC(SYSDATE) DATA FROM DUAL
----------------------------------
Timestamp: 17:27:38.635
SELECT CODIGO,
       RAZAOSOCIAL,
       CGC
FROM PCFILIAL
WHERE CODIGO IN (SELECT PCLIB.CODIGOA FROM PCLIB WHERE PCLIB.CODFUNC = 1261 AND PCLIB.CODTABELA = 1)
 AND TO_CHAR(CODIGO) = :PARAM1
PARAM1 = '2'
----------------------------------
Timestamp: 17:27:38.673
SELECT NVL(PCFILIAL.USADIAUTILFILIAL,'N') USADIAUTILFILIAL
FROM PCFILIAL
WHERE PCFILIAL.CODIGO = 
'2'
----------------------------------
Timestamp: 17:27:38.692
SELECT CODIGO,
       RAZAOSOCIAL,
       CGC
FROM PCFILIAL
WHERE CODIGO IN (SELECT PCLIB.CODIGOA FROM PCLIB WHERE PCLIB.CODFUNC = 1261 AND PCLIB.CODTABELA = 1)
 AND TO_CHAR(CODIGO) = :PARAM1
PARAM1 = '2'
----------------------------------
Timestamp: 17:27:38.729
SELECT COUNT(*) DIAVENDAS
  FROM PCDIASUTEIS
 WHERE PCDIASUTEIS.DATA BETWEEN :DATA1 AND :DATA2
   AND PCDIASUTEIS.DIAVENDAS = 'S'
   AND PCDIASUTEIS.CODFILIAL = 
'2'
DATA1 = '24/01/2024'
DATA2 = '31/01/2024'
----------------------------------
Timestamp: 17:27:38.766
SELECT CODIGO,
       RAZAOSOCIAL,
       CGC
FROM PCFILIAL
WHERE CODIGO IN (SELECT PCLIB.CODIGOA FROM PCLIB WHERE PCLIB.CODFUNC = 1261 AND PCLIB.CODTABELA = 1)
 AND TO_CHAR(CODIGO) = :PARAM1
PARAM1 = '2'
----------------------------------
Timestamp: 17:27:38.803
SELECT COUNT(*) DIAVENDAS
  FROM PCDIASUTEIS
 WHERE PCDIASUTEIS.DATA BETWEEN :DATA1 AND trunc(sysdate) 
   AND PCDIASUTEIS.DIAVENDAS = 'S'
   AND PCDIASUTEIS.CODFILIAL = 
'2'
DATA1 = '24/01/2024'
----------------------------------
Timestamp: 17:27:38.865
SELECT CODIGO,
       RAZAOSOCIAL,
       CGC
FROM PCFILIAL
WHERE CODIGO IN (SELECT PCLIB.CODIGOA FROM PCLIB WHERE PCLIB.CODFUNC = 1261 AND PCLIB.CODTABELA = 1)
 AND TO_CHAR(CODIGO) = :PARAM1
PARAM1 = '2'
----------------------------------
Timestamp: 17:27:38.926
SELECT CODIGO,
       RAZAOSOCIAL,
       CGC
FROM PCFILIAL
WHERE CODIGO IN (SELECT PCLIB.CODIGOA FROM PCLIB WHERE PCLIB.CODFUNC = 1261 AND PCLIB.CODTABELA = 1)
 AND TO_CHAR(CODIGO) = :PARAM1
PARAM1 = '2'
----------------------------------
Timestamp: 17:27:38.998
SELECT CODIGO,
       RAZAOSOCIAL,
       CGC
FROM PCFILIAL
WHERE CODIGO IN (SELECT PCLIB.CODIGOA FROM PCLIB WHERE PCLIB.CODFUNC = 1261 AND PCLIB.CODTABELA = 1)
 AND TO_CHAR(CODIGO) = :PARAM1
PARAM1 = '2'
----------------------------------
Timestamp: 17:27:39.063
SELECT CODIGO,
       RAZAOSOCIAL,
       CGC
FROM PCFILIAL
WHERE CODIGO IN (SELECT PCLIB.CODIGOA FROM PCLIB WHERE PCLIB.CODFUNC = 1261 AND PCLIB.CODTABELA = 1)
 AND TO_CHAR(CODIGO) = :PARAM1
PARAM1 = '2'
----------------------------------
Timestamp: 17:27:39.122
SELECT CODIGO,
       RAZAOSOCIAL,
       CGC
FROM PCFILIAL
WHERE CODIGO IN (SELECT PCLIB.CODIGOA FROM PCLIB WHERE PCLIB.CODFUNC = 1261 AND PCLIB.CODTABELA = 1)
 AND TO_CHAR(CODIGO) = :PARAM1
PARAM1 = '2'
----------------------------------
Timestamp: 17:27:39.173
SELECT CODIGO,
       RAZAOSOCIAL,
       CGC
FROM PCFILIAL
WHERE CODIGO IN (SELECT PCLIB.CODIGOA FROM PCLIB WHERE PCLIB.CODFUNC = 1261 AND PCLIB.CODTABELA = 1)
 AND TO_CHAR(CODIGO) = :PARAM1
PARAM1 = '2'
----------------------------------
Timestamp: 17:27:39.236
SELECT CODIGO,
       RAZAOSOCIAL,
       CGC
FROM PCFILIAL
WHERE CODIGO IN (SELECT PCLIB.CODIGOA FROM PCLIB WHERE PCLIB.CODFUNC = 1261 AND PCLIB.CODTABELA = 1)
 AND TO_CHAR(CODIGO) = :PARAM1
PARAM1 = '2'
----------------------------------
Timestamp: 17:27:39.286
SELECT COUNT(*) ACESSO
  FROM PCLIB
 WHERE PCLIB.CODTABELA = 7
   AND PCLIB.CODFUNC = 1261
   AND PCLIB.CODIGON = 9999
----------------------------------
Timestamp: 17:27:39.800
SELECT pcusuari.codusur, pcusuari.nome, pcusuari.dtinicio,
       pcusuari.telefone2 AS telefone1, pcusuari.codsupervisor,
       pcusuari.dtinformatiza, pcusuari.dtentregadoc,
       pcsuperv.nome AS nomesup, pcusuari.bloqueio,
       NVL ((SELECT SUM (pcmetarca.vlvendaprev)
               FROM pcmetarca
              WHERE pcmetarca.codusur = pcusuari.codusur
                AND pcmetarca.codfilial IN ('2')
                AND pcmetarca.DATA BETWEEN :DTINICIO AND TRUNC(SYSDATE)),
            0
           ) AS vlmeta,
       NVL ((SELECT SUM (pcmetarca.vlvendaprev)
               FROM pcmetarca
              WHERE pcmetarca.codusur = pcusuari.codusur
                AND pcmetarca.codfilial IN ('2')
                AND pcmetarca.DATA BETWEEN TRUNC(:DTINICIO,'mm') AND LAST_DAY(:DTFIM)),
            0
           ) AS vlmetatotal,
       NVL (vendas.vlvenda, 0) vlvenda, NVL( vendas.vltabela,0) vltabela,
       NVL (decode(NVL(vendas.VLVENDA1,0),0,0,vendas.prazomedio/vendas.VLVENDA1), 0) prazomedio,
       NVL (vendas.qtcli, 0) clqtcli, NVL(FINANC.VALOR, 0) CLVALOR,
       NVL (vendas.QTNF, 0) clqtNF, 
       NVL (vendas.numitens, 0) clnumitens,
       NVL (financ.qtpend, 0) clqtpend, NVL (inandimp.vpago, 0) clvpago,
       NVL (MIX.QTMIX,0) clQtMix,
       (  (SELECT COUNT(DISTINCT(PCCLIENT.CODCLI)) 
             FROM pcclient 
            WHERE pcclient.codusur1 = pcusuari.codusur
)
        + (SELECT COUNT(DISTINCT(PCCLIENT.CODCLI)) 
             FROM pcclient
            WHERE pcclient.codusur2 = pcusuari.codusur
            AND NVL(PCCLIENT.codusur1,0) <> NVL(PCCLIENT.codusur2,0) 
)
        + (SELECT COUNT(DISTINCT(PCCLIENT.CODCLI))
             FROM pcusurcli, pcclient
            WHERE pcusurcli.codusur = pcusuari.codusur
              AND pcusurcli.codcli = pcclient.codcli
              AND PCUSURCLI.CODUSUR <> NVL(PCCLIENT.CODUSUR1, 0)
              AND PCUSURCLI.CODUSUR <> NVL(PCCLIENT.CODUSUR2, 0)
)
       ) clqtclicad,
       (  (SELECT COUNT (*)
             FROM pcclient
            WHERE codusur1 = pcusuari.codusur
              AND pcclient.bloqueio = 'S')
        + (SELECT COUNT (*)
             FROM pcclient
            WHERE codusur2 = pcusuari.codusur
            AND NVL(PCCLIENT.codusur1,0) <> NVL(PCCLIENT.codusur2,0) 
              AND pcclient.bloqueio = 'S')
        + (SELECT COUNT (*)
             FROM pcusurcli, pcclient
            WHERE pcusurcli.codusur = pcusuari.codusur
              AND pcusurcli.codcli = pcclient.codcli 
              AND pcusurcli.codusur <> NVL(pcclient.codusur1,0)
              AND pcusurcli.codusur <> NVL(pcclient.codusur2,0)
              AND pcclient.bloqueio = 'S')
       ) clqtclibloq,
  
( SELECT COUNT(DISTINCT(PCCLIENT.CODCLI)) QTCLIATIVOS FROM PCCLIENT
WHERE ( (PCCLIENT.CODUSUR1 = PCUSUARI.CODUSUR)  OR ( (PCCLIENT.CODUSUR2 = PCUSUARI.CODUSUR ) AND ( NVL(PCCLIENT.codusur1,0) <> 
NVL(PCCLIENT.codusur2,0)) )  OR
         EXISTS (SELECT PCUSURCLI.CODUSUR
                   FROM PCUSURCLI
                  WHERE PCUSURCLI.CODUSUR = PCUSUARI.CODUSUR
                  AND NVL(PCUSURCLI.CODUSUR,0) <> NVL(PCCLIENT.codusur1,0)
                   AND NVL(PCUSURCLI.CODUSUR,0) <> NVL(PCCLIENT.codusur2,0)
                    AND PCUSURCLI.CODCLI  = PCCLIENT.CODCLI))
AND ( PCCLIENT.DTULTCOMP >= trunc(sysdate - (SELECT nvl(numdiascliinativ,0) FROM pcconsum) ) )
  ) clqtcliativ, 
           (SELECT 
      SUM(ROUND(DECODE(PCPEDC.CONDVENDA,5,0,6,0,11,0,12,0,(NVL(PCPEDI.PVENDA, 0) + NVL(PCPEDI.VLOUTRASDESP, 0) + 
NVL(PCPEDI.VLFRETE, 0)) * NVL(PCPEDI.QT, 0)),2)) AS vlvendatotal
                     FROM PCPEDI, 
                          PCPEDC, 
                          PCUSUARI A, 
                          PCPRODUT, 
                          PCFORNEC, 
                          PCDEPTO, 
                          PCCLIENT, 
                          PCATIVI, 
                          PCPRACA, 
                          PCSUPERV 
                    WHERE 1=1  
                      AND pcpedc.DATA BETWEEN :DTINICIO AND :DTFIM 
                      AND pcpedI.DATA BETWEEN :DTINICIO AND :DTFIM 
                    AND pcpedc.codfilial IN ('2')
                      AND PCPEDI.NUMPED = PCPEDC.NUMPED
                      AND A.CODSUPERVISOR NOT IN ('9999') 
                      AND NVL(PCPEDI.BONIFIC, 'N') =  'N' 
                      AND PCPEDC.CODCLI = PCCLIENT.CODCLI 
                      AND PCCLIENT.CODATV1 = PCATIVI.CODATIV(+) 
                      AND PCPEDC.DTCANCEL IS NULL 
                      AND  PCPEDC.CODUSUR  = A.CODUSUR 
                      AND PCPEDI.CODPROD = PCPRODUT.CODPROD 
                      AND PCPRODUT.CODEPTO = PCDEPTO.CODEPTO 
                      AND PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC 
                      AND PCPEDC.CODPRACA = PCPRACA.CODPRACA 
                      AND A.CODSUPERVISOR = PCSUPERV.CODSUPERVISOR 
                      AND A.CODSUPERVISOR = PCUSUARI.CODSUPERVISOR 
                      AND pcpedc.dtcancel IS NULL 
    AND pcpedc.vlatend > 0 
AND PCPEDC.CONDVENDA IN (1, 2, 3, 7, 9, 14, 15, 17, 18, 19, 98)
             AND pcpedc.dtcancel IS NULL
   AND  PCPEDC.CODSUPERVISOR  = :codsupervisor) VLVENDATOTAL
  FROM pcusuari, 
       pcsuperv, 
       (SELECT  PCPEDC.CODUSUR  codusur, 
      SUM(ROUND(DECODE(PCPEDC.CONDVENDA,5,0,6,0,11,0,12,0,(NVL(PCPEDI.PVENDA, 0) + NVL(PCPEDI.VLOUTRASDESP, 0) + 
NVL(PCPEDI.VLFRETE, 0)) * NVL(PCPEDI.QT, 0)),2)) AS vlvenda,
                 COUNT(DISTINCT(PCPEDC.NUMPED)) QTNF,
                 COUNT(PCPEDI.CODPROD) NUMITENS,
                 SUM(NVL(PCPEDI.PTABELA, 0) * NVL(PCPEDI.QT, 0)) AS vltabela,
                 SUM(NVL(PCPEDC.PRAZOMEDIO, 0) *  (NVL(PCPEDI.QT, 0) * (NVL(PCPEDI.PVENDA, 0) + NVL(PCPEDI.VLOUTRASDESP, 0) + 
NVL(PCPEDI.VLFRETE, 0))) ) AS prazomedio,
      SUM(ROUND(DECODE(PCPEDC.CONDVENDA,5,0,6,0,11,0,12,0,(NVL(PCPEDI.PVENDA, 0) + NVL(PCPEDI.VLOUTRASDESP, 0) + 
NVL(PCPEDI.VLFRETE, 0)) * NVL(PCPEDI.QT, 0)),2)) AS VLVENDA1,
                 COUNT (DISTINCT (pcpedc.codcli)) qtcli
          FROM PCPEDI,
               PCPEDC,
               PCPRODUT,
               PCFORNEC,
               PCDEPTO,
               PCCLIENT,
               PCUSUARI,
               PCSUPERV,
               PCATIVI,
               PCPRACA, PCCIDADE
                    WHERE 1=1  
                      AND pcpedc.DATA BETWEEN :DTINICIO AND :DTFIM 
                      AND pcpedI.DATA BETWEEN :DTINICIO AND :DTFIM 
             AND pcpedc.codfilial IN ('2')
                      AND PCPEDI.NUMPED = PCPEDC.NUMPED
AND PCCLIENT.CODCIDADE = PCCIDADE.CODCIDADE(+)
           AND PCPEDC.CODCLI = PCCLIENT.CODCLI
           AND NVL(PCPEDI.BONIFIC, 'N') =  'N' 
           AND PCCLIENT.CODATV1 = PCATIVI.CODATIV(+)
           AND PCPEDC.DTCANCEL IS NULL
           AND PCPEDI.CODPROD = PCPRODUT.CODPROD
           AND PCPRODUT.CODEPTO = PCDEPTO.CODEPTO
           AND PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC
           AND  PCPEDC.CODUSUR  = PCUSUARI.CODUSUR
           AND  PCPEDC.CODSUPERVISOR  = PCSUPERV.CODSUPERVISOR
           AND PCPEDC.CODPRACA = PCPRACA.CODPRACA
AND PCPEDC.CONDVENDA IN (1, 2, 3, 7, 9, 14, 15, 17, 18, 19, 98)
             AND pcpedc.dtcancel IS NULL
    AND pcpedc.vlatend > 0 
             AND  PCPEDC.CODSUPERVISOR  = :codsupervisor
             AND pcusuari.codsupervisor = :codsupervisor
        GROUP BY  PCPEDC.CODUSUR  ) vendas,
       (SELECT   pcprest.codusur, (SUM(PCPREST.VALOR) ) valor,
                 COUNT (*) qtpend 
            FROM pcprest, pcusuari
           WHERE pcprest.dtpag IS NULL
             AND pcprest.codusur = pcusuari.codusur
           AND pcprest.codfilial IN ('2')
           AND pcusuari.codsupervisor = :codsupervisor
        GROUP BY pcprest.codusur) financ,
 (SELECT pcprest.codusur, SUM(VALOR) vpago
    FROM PCPREST, PCCLIENT, PCUSUARI, PCSUPERV, PCCOB
   WHERE PCPREST.CODCLI = PCCLIENT.CODCLI
     and PCPREST.CODUSUR = PCUSUARI.CODUSUR
     and PCUSUARI.CODSUPERVISOR = PCSUPERV.CODSUPERVISOR
     and PCPREST.CODCOB = PCCOB.CODCOB
     and PCPREST.CODCOB not in ('DEVP', 'DEVT', 'BNF', 'BNFT', 'BNFR', 'BNTR', 'BNRP', 'CRED')
     and PCUSUARI.CODSUPERVISOR = :CODSUPERVISOR
     and PCPREST.DTPAG is NULL
     and (PCPREST.DTVENC + NVL(PCCOB.DIASCARENCIA,0)) <= (TRUNC(SYSDATE) - 1)
and (Pcprest.CODFILIAL IN ('2'))
 GROUP BY pcprest.codusur) inandimp,
       (SELECT  PCPEDC.CODUSUR  CODUSUR,COUNT(DISTINCT(PCPEDI.CODPROD)) AS QTMIX
          FROM PCPEDI, PCUSUARI, PCSUPERV, PCPEDC
         WHERE PCPEDI.NUMPED = PCPEDC.NUMPED
           AND NVL(PCPEDI.BONIFIC, 'N') =  'N' 
           AND  PCPEDC.CODUSUR  = PCUSUARI.CODUSUR
           AND PCPEDC.DATA BETWEEN :DTINICIO AND :DTFIM 
AND PCPEDC.CONDVENDA IN (1, 2, 3, 7, 9, 14, 15, 17, 18, 19, 98)
           AND PCPEDC.DTCANCEL IS NULL
    AND pcpedc.vlatend > 0 
           AND PCUSUARI.CODSUPERVISOR = PCSUPERV.CODSUPERVISOR
           AND PCPEDC.CODFILIAL IN ('2')
AND  PCPEDC.CODSUPERVISOR = :CODSUPERVISOR
        GROUP BY  PCPEDC.CODUSUR  ) MIX
 WHERE pcusuari.codsupervisor = pcsuperv.codsupervisor
   AND pcusuari.codusur = vendas.codusur(+)
   AND pcusuari.codusur = financ.codusur(+)
   AND pcusuari.codusur = inandimp.codusur(+)
   AND pcusuari.codusur = mix.codusur(+)
   AND PCUSUARI.CODSUPERVISOR = :CODSUPERVISOR
 AND NVL(VLVENDA, 0) <> 0 
ORDER BY PCUSUARI.CODSUPERVISOR,VLVENDA DESC
DTINICIO = '24/01/2024'
DTFIM = '31/01/2024'
codsupervisor = 42
----------------------------------
Timestamp: 17:27:40.208
SELECT CODIGO,
       RAZAOSOCIAL,
       CGC
FROM PCFILIAL
WHERE CODIGO IN (SELECT PCLIB.CODIGOA FROM PCLIB WHERE PCLIB.CODFUNC = 1261 AND PCLIB.CODTABELA = 1)
 AND TO_CHAR(CODIGO) = :PARAM1
PARAM1 = '2'
----------------------------------
Timestamp: 17:27:40.266
SELECT NVL(PCFILIAL.USADIAUTILFILIAL,'N') USADIAUTILFILIAL
FROM PCFILIAL
WHERE PCFILIAL.CODIGO = 
'2'
----------------------------------
Timestamp: 17:27:40.295
SELECT CODIGO,
       RAZAOSOCIAL,
       CGC
FROM PCFILIAL
WHERE CODIGO IN (SELECT PCLIB.CODIGOA FROM PCLIB WHERE PCLIB.CODFUNC = 1261 AND PCLIB.CODTABELA = 1)
 AND TO_CHAR(CODIGO) = :PARAM1
PARAM1 = '2'
----------------------------------
Timestamp: 17:27:40.341
SELECT COUNT(*) DIAVENDAS
  FROM PCDIASUTEIS
 WHERE PCDIASUTEIS.DATA BETWEEN :DATA1 AND :DATA2
   AND PCDIASUTEIS.DIAVENDAS = 'S'
   AND PCDIASUTEIS.CODFILIAL = 
'2'
DATA1 = '24/01/2024'
DATA2 = '31/01/2024'
----------------------------------
Timestamp: 17:27:40.384
SELECT CODIGO,
       RAZAOSOCIAL,
       CGC
FROM PCFILIAL
WHERE CODIGO IN (SELECT PCLIB.CODIGOA FROM PCLIB WHERE PCLIB.CODFUNC = 1261 AND PCLIB.CODTABELA = 1)
 AND TO_CHAR(CODIGO) = :PARAM1
PARAM1 = '2'
----------------------------------
Timestamp: 17:27:40.439
SELECT COUNT(*) DIAVENDAS
  FROM PCDIASUTEIS
 WHERE PCDIASUTEIS.DATA BETWEEN :DATA1 AND trunc(sysdate) 
   AND PCDIASUTEIS.DIAVENDAS = 'S'
   AND PCDIASUTEIS.CODFILIAL = 
'2'
DATA1 = '24/01/2024'