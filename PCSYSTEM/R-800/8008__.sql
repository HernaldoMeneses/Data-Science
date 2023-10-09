--########### - Guia Inicial.
--#
--# - Objetivo: Otimização da rotina 8008 - Relatório Comissão Ficha Liq-Friobom
--# - Obs     : Suprimi várias colunas da 8008, inclusive uma 2 tabelas inteiras.
--#
--# - Titulo  : Acompanhamento Geral - por Vendedor.
--# - Tema    : Otimização da rotina 8008.
--#
--# - Autor   : Hernaldo Meneses 
--# - Criação : 09/10/2023
--# - Infrastrutura de compilação e informações ao final do Script.
--#--------------------------------------------------------------------Thanks.

select
       TAB1.codusur, TAB1.nome, TAB1.vlmetatotal, TAB1.vlvenda,
       CASE when tab1.vlmetatotal>0 then round(((tab1.vlvenda/tab1.vlmetatotal)*100),2) 
            else 0 end perc_meta_fin,

       fnc_wn_premiacao_comissao(:COD_FILIAL, TAB1.CODUSUR, to_date(:DTINICIO,'dd-mm-rrrr'), to_date(:DTFIM,'dd-mm-rrrr'), 4) PERC_COB_FORN_FIN,
       fnc_wn_premiacao_comissao(:COD_FILIAL, TAB1.CODUSUR, to_date(:DTINICIO,'dd-mm-rrrr'), to_date(:DTFIM,'dd-mm-rrrr'), 5) PERC_COB_FORN_POS,
      fnc_wn_premiacao_comissao(:COD_FILIAL, TAB1.CODUSUR, to_date(:DTINICIO,'dd-mm-rrrr'), to_date(:DTFIM,'dd-mm-rrrr'), 7) META_LUCRO,
      fnc_wn_premiacao_comissao(:COD_FILIAL, TAB1.CODUSUR, to_date(:DTINICIO,'dd-mm-rrrr'), to_date(:DTFIM,'dd-mm-rrrr'), 8) PERC_LUCRO,
       fnc_wn_premiacao_comissao(:COD_FILIAL, TAB1.CODUSUR, to_date(:DTINICIO,'dd-mm-rrrr'), to_date(:DTFIM,'dd-mm-rrrr'), 6) PERC_COB_LUCRO,
       
       
       fnc_wn_premiacao_comissao(:COD_FILIAL, TAB1.CODUSUR, to_date(:DTINICIO,'dd-mm-rrrr'), to_date(:DTFIM,'dd-mm-rrrr'), 3) PERC_INAD
       from ( 
     
SELECT --pcusuari.codsupervisor,
      
       --pcsuperv.nome AS nomesup, 
       pcusuari.codusur, 
       pcusuari.nome, 
        nvl(pcusuari.comissaofixa,0) FIXO, 


       NVL ((SELECT SUM (pcmetarca.vlvendaprev)
               FROM pcmetarca
              WHERE pcmetarca.codusur = pcusuari.codusur
                AND pcmetarca.codfilial IN (:COD_FILIAL)
                AND pcmetarca.DATA BETWEEN TRUNC(to_date(:DTINICIO,'dd-mm-rrrr'),'mm') AND LAST_DAY(to_date(:DTFIM,'dd-mm-rrrr'))),
            0
           ) AS vlmetatotal,
       NVL (vendas.vlvenda, 0) vlvenda
  
  FROM pcusuari, 
       pcsuperv, 
       (SELECT   pcpedc.codusur, 
      SUM(ROUND(DECODE(PCPEDC.CONDVENDA,5,0,6,0,11,0,12,0,NVL(PCPEDI.PVENDA, 0) * NVL(PCPEDI.QT, 0)),2)) AS vlvenda,
                 COUNT(DISTINCT(PCPEDC.NUMPED)) QTNF,
                 COUNT(PCPEDI.CODPROD) NUMITENS,
                 SUM(NVL(PCPEDI.PBASERCA, NVL(PCPEDI.PTABELA, 0)) * NVL(PCPEDI.QT, 0)) AS vltabela,
                 SUM(NVL(PCPEDC.PRAZOMEDIO, 0) *  (NVL(PCPEDI.QT, 0) * NVL(PCPEDI.PVENDA,0)) ) AS prazomedio,
      SUM(ROUND(DECODE(PCPEDC.CONDVENDA,5,0,6,0,11,0,12,0,NVL(PCPEDI.PVENDA, 0) * NVL(PCPEDI.QT, 0)),2)) AS VLVENDA1,
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
             AND pcpedc.codfilial IN (:COD_FILIAL)
             AND pcpedc.DATA BETWEEN to_date(:DTINICIO,'dd-mm-rrrr') AND to_date(:DTFIM, 'dd-mm-rrrr')
        GROUP BY pcpedc.codusur) vendas,
       (SELECT   pcprest.codusur, (SUM(PCPREST.VALOR) ) valor,
                 COUNT (*) qtpend 
            FROM pcprest, pcusuari
           WHERE pcprest.dtpag IS NULL
             AND pcprest.codusur = pcusuari.codusur
           AND pcprest.codfilial IN (:COD_FILIAL)
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
           AND PCPEDC.CODFILIAL IN (:COD_FILIAL)
        GROUP BY PCPEDC.codusur) MIX
 WHERE pcusuari.codsupervisor = pcsuperv.codsupervisor
   AND pcusuari.codusur = vendas.codusur(+)
   AND pcusuari.codusur = financ.codusur(+)
   AND pcusuari.codusur = inandimp.codusur(+)
   AND pcusuari.codusur = mix.codusur(+)
   AND pcusuari.codusur in (:COD_RCA)
   AND PCUSUARI.CODSUPERVISOR in (:Cod_Super)

 AND NVL(VLVENDA, 0) <> 0 
ORDER BY PCUSUARI.CODSUPERVISOR,VLVENDA DESC
   ) tab1


--   ########### - Compile_By.
--#
--# - coding: utf-8
--# - Última Atualização: 09/10/2023
--# - Winthor Version: Distribuição e Vareho (Linha WinThor) v.31.0.08.002 A
--# - IDE: Rotina 860 Winthor PcSistem
--# - SO:  Windows 11 Pro.22H2
--#
--# - Obs: no bugs.
--# - Obs: 09/10/2023.
--#
--# - Hello... please if you find something wrong,  contact-me.
--#--------------------------------------------------------------------Follow the white rabbit.
