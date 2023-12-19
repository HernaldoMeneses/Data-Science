select 
     tabInit1.codgerente
     , tabInit1.codsupervisor
     , tabInit1.nomesup
     ,  sum(tabInit1.FIXO) as FIXO
     , sum(tabInit1.vlmetatotal) as VLMETATOTAL
     , sum(tabInit1.vlvenda)   as VLVENDA
from (
SELECT --Obj1.1_init
          pcsuperv.codgerente,
          pcusuari.codsupervisor,
          pcsuperv.nome AS nomesup,
          --pcusuari.codusur, 
          --pcusuari.nome, 
          nvl(pcusuari.comissaofixa,0) FIXO, 
          NVL ((SELECT SUM (pcmetarca.vlvendaprev)
               FROM pcmetarca
              WHERE pcmetarca.codusur = pcusuari.codusur
                AND pcmetarca.codfilial IN (:COD_FILIAL)
                AND pcmetarca.DATA BETWEEN TRUNC(to_date(:DTINICIO,'dd-mm-rrrr'),'mm') AND LAST_DAY(to_date(:DTFIM,'dd-mm-rrrr'))),
            0
           ) AS vlmetatotal,
          NVL (vendas.vlvenda, 0) vlvenda
          FROM --Obj1.1 
               pcusuari, 
               pcsuperv, 
               (SELECT   pcpedc.codusur, 
                    SUM(ROUND(DECODE(PCPEDC.CONDVENDA,5,0,6,0,11,0,12,0,NVL(PCPEDI.PVENDA, 0) * NVL(PCPEDI.QT, 0)),2)) AS vlvenda,
                    COUNT(DISTINCT(PCPEDC.NUMPED)) QTNF,
                    COUNT(PCPEDI.CODPROD) NUMITENS,
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
                    WHERE PCPEDI.NUMPED = PCPEDC.NUMPED
                    AND PCCLIENT.CODCIDADE = PCCIDADE.CODCIDADE(+)
                    AND PCPEDC.CODCLI = PCCLIENT.CODCLI
                    AND PCCLIENT.CODATV1 = PCATIVI.CODATIV(+)
                    AND PCPEDC.DTCANCEL IS NULL
                    AND PCPEDI.CODPROD = PCPRODUT.CODPROD
                    AND PCPRODUT.CODEPTO = PCDEPTO.CODEPTO
                    AND PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC
                    AND PCPEDC.CODUSUR = PCUSUARI.CODUSUR
                    AND PCPEDC.CODSUPERVISOR = PCSUPERV.CODSUPERVISOR
                    AND PCPEDC.CODPRACA = PCPRACA.CODPRACA
                    AND PCPEDC.CONDVENDA IN (1, 2, 3, 7, 9, 14, 15, 17, 18, 19, 98)
                    AND pcpedc.dtcancel IS NULL
                    AND pcpedc.vlatend > 0 
                    AND pcpedc.codfilial IN (2)
                    AND pcpedc.DATA BETWEEN to_date(:DTINICIO,'dd-mm-rrrr') AND to_date(:DTFIM, 'dd-mm-rrrr')
                    GROUP BY pcpedc.codusur) vendas,

                    (SELECT   
                         pcprest.codusur, 
                         (SUM(PCPREST.VALOR) ) valor,
                         COUNT (*) qtpend 
                         FROM pcprest, pcusuari
                         WHERE pcprest.dtpag IS NULL
                         AND pcprest.codusur = pcusuari.codusur
                         AND pcprest.codfilial IN (2)
                         GROUP BY pcprest.codusur) financ,

                    (SELECT pcprest.codusur, SUM(VALOR) vpago
                         FROM PCPREST, PCCLIENT, PCUSUARI, PCSUPERV, PCCOB
                         WHERE PCPREST.CODCLI = PCCLIENT.CODCLI
                         and PCPREST.CODUSUR = PCUSUARI.CODUSUR
                         and PCUSUARI.CODSUPERVISOR = PCSUPERV.CODSUPERVISOR
                         and PCPREST.CODCOB = PCCOB.CODCOB
                         and PCPREST.CODCOB not in ('DEVP', 'DEVT', 'BNF', 'BNFT', 'BNFR', 'BNTR', 'BNRP', 'CRED')
                         and PCPREST.DTPAG is NULL
                         and (PCPREST.DTVENC + NVL(PCCOB.DIASCARENCIA,0)) <= (TRUNC(SYSDATE) - 1)
                         and (Pcprest.CODFILIAL IN (:COD_FILIAL))
                         GROUP BY pcprest.codusur) inandimp,

                    (SELECT PCPEDC.CODUSUR,COUNT(DISTINCT(PCPEDI.CODPROD)) AS QTMIX
                         FROM PCPEDI, PCUSUARI, PCSUPERV, PCPEDC
                         WHERE PCPEDI.NUMPED = PCPEDC.NUMPED
                         AND PCPEDC.CODUSUR = PCUSUARI.CODUSUR
                         AND PCPEDC.DATA BETWEEN to_date(:DTINICIO,'dd-mm-rrrr') AND to_date(:DTFIM,'dd-mm-rrrr') 
                         AND PCPEDC.CONDVENDA IN (1, 2, 3, 7, 9, 14, 15, 17, 18, 19, 98)
                         AND PCPEDC.DTCANCEL IS NULL
                         AND pcpedc.vlatend > 0 
                         AND PCUSUARI.CODSUPERVISOR = PCSUPERV.CODSUPERVISOR
                         AND PCPEDC.CODFILIAL IN (2)
                         GROUP BY PCPEDC.codusur) MIX

          WHERE pcusuari.codsupervisor = pcsuperv.codsupervisor
          AND pcusuari.codusur = vendas.codusur(+)
          AND pcusuari.codusur = financ.codusur(+)
          AND pcusuari.codusur = inandimp.codusur(+)
          AND pcusuari.codusur = mix.codusur(+)
          and pcsuperv.codgerente in (:Cod_Ger)
          AND NVL(VLVENDA, 0) <> 0 
          --ORDER BY PCUSUARI.CODSUPERVISOR,VLVENDA DESC
     ) tabInit1
     group by tabInit1.codgerente, tabInit1.codsupervisor, tabInit1.nomesup