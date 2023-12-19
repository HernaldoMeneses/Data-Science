select * from (
SELECT --Obj1.3_init
     pcsuperv.codgerente,
          pcusuari.codsupervisor,

         ((SELECT --Obj1.3.1_init
               COUNT(DISTINCT(PCCLIENT.CODCLI)) 
               FROM pcclient 
               WHERE pcclient.codusur1 = pcusuari.codusur)
               + (SELECT COUNT(DISTINCT(PCCLIENT.CODCLI)) 
               FROM pcclient
               WHERE pcclient.codusur2 = pcusuari.codusur
               AND NVL(PCCLIENT.codusur1,0) <> NVL(PCCLIENT.codusur2,0))
               + (SELECT COUNT(DISTINCT(PCCLIENT.CODCLI))
               FROM pcusurcli, pcclient
               WHERE pcusurcli.codusur = pcusuari.codusur
               AND pcusurcli.codcli = pcclient.codcli
               AND PCUSURCLI.CODUSUR <> NVL(PCCLIENT.CODUSUR1, 0)
               AND PCUSURCLI.CODUSUR <> NVL(PCCLIENT.CODUSUR2, 0))
          ) clqtclicad,

          ( SELECT 
               COUNT(DISTINCT(PCCLIENT.CODCLI)) QTCLIATIVOS FROM PCCLIENT
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

          vendas.qtcli
 
          FROM 
               pcusuari, 
               pcsuperv, 
               (SELECT  
                    PCPEDC.CODUSUR  codusur,
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
                    --AND  PCPEDC.CODSUPERVISOR  = :Cod_Super
                    --AND pcusuari.codsupervisor = :Cod_Super
                    --AND pcusuari.codsupervisor = :Cod_Super
                    AND pcsuperv.codgerente = :Cod_Ger
                    GROUP BY  PCPEDC.CODUSUR  ) vendas,

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
                    --AND  PCPEDC.CODSUPERVISOR = :Cod_Super
                    GROUP BY  PCPEDC.CODUSUR  ) MIX

                    WHERE pcusuari.codsupervisor = pcsuperv.codsupervisor
                    AND pcusuari.codusur = vendas.codusur(+)
                   -- AND pcusuari.codusur = financ.codusur(+)
                    --AND pcusuari.codusur = inandimp.codusur(+)
                    AND pcusuari.codusur = mix.codusur(+)
                    --AND PCUSUARI.CODSUPERVISOR = :Cod_Super
                    AND NVL(VLVENDA, 0) <> 0 
                    ORDER BY PCUSUARI.CODSUPERVISOR,VLVENDA DESC
                    )