select tab4.*,
       :DTINICIO DT_INICIO,
       :DTFIM DT_FIM,
       :COD_FILIAL filial,
       tab4.total_geral-tab4.comissaoliquidez diferenca
       from (
select tab3.*, 
       vlr_meta_fin+vlr_meta_forn_pos+vlr_inad+vlr_meta_forn_fin+vlr_meta_lucro total_recibo,
       vlr_meta_fin+vlr_meta_forn_pos+vlr_inad+vlr_meta_forn_fin+vlr_meta_lucro+sal_fixoinss total_com_mes,
       ((tab3.sal_fixo*(133/100))/12) ferias,
       (tab3.sal_fixo/12) d13,
       ((tab3.sal_fixo*(8/100))) fgts,
       (vlr_meta_fin+vlr_meta_forn_pos+vlr_inad+vlr_meta_forn_fin+vlr_meta_lucro+sal_fixoinss)
          +
        ((tab3.sal_fixo*(133/100))/12)
         +
         (tab3.sal_fixo/12) 
         +
         ((tab3.sal_fixo*(8/100))) total_geral
        
      from 
         (
select tab2.*,
        case when tab2.perc_meta_fin between tab2.perc_min_meta_fin and tab2.perc_max_meta_fin then
               
       ((tab2.comissaoliquidez-tab2.sal_fixo)*(tab2.peso_meta_fin/100))*(tab2.perc_meta_fin/100) 
              when tab2.perc_meta_fin>tab2.perc_max_meta_fin then
          ((tab2.comissaoliquidez-tab2.sal_fixo)*(tab2.peso_meta_fin/100))*( tab2.perc_max_meta_fin/100) 
         else 0 end vlr_meta_fin,
       case when tab2.perc_cob_forn_pos between tab2.PERC_MIN_META_POS_FOR and tab2.PERC_MAX_META_POS_FOR then
       ((tab2.comissaoliquidez-tab2.sal_fixo)*(tab2.PESO_META_POS_FOR/100))*(tab2.perc_cob_forn_pos/100) 
             when tab2.perc_cob_forn_pos>tab2.PERC_MAX_META_POS_FOR then
       ((tab2.comissaoliquidez-tab2.sal_fixo)*(tab2.PESO_META_POS_FOR/100))*(tab2.PERC_MAX_META_POS_FOR/100)
         else 0 end vlr_meta_forn_pos,
       case when tab2.perc_inad<=5 then
       ((tab2.comissaoliquidez-tab2.sal_fixo)*(tab2.PESO_INAD/100))*(100/100)
        when tab2.perc_inad between 5.01 and 7 then
       ((tab2.comissaoliquidez-tab2.sal_fixo)*(tab2.PESO_INAD/100))*(75/100)
        when tab2.perc_inad between 7.01 and 10 then
       ((tab2.comissaoliquidez-tab2.sal_fixo)*(tab2.PESO_INAD/100))*(50/100)
        else 0 end vlr_inad,
       case when tab2.perc_cob_forn_fin between tab2.PERC_MIN_META_fin_FOR and tab2.PERC_MAX_META_fin_FOR then
       ((tab2.comissaoliquidez-tab2.sal_fixo)*(tab2.PESO_META_fin_FOR/100))*(tab2.perc_cob_forn_fin/100)
         when tab2.perc_cob_forn_fin>tab2.PERC_MAX_META_fin_FOR then
       ((tab2.comissaoliquidez-tab2.sal_fixo)*(tab2.PESO_META_fin_FOR/100))*(tab2.PERC_MAX_META_fin_FOR/100)  
         else 0 end vlr_meta_forn_fin,
       
        case when tab2.perc_cob_lucro between tab2.PERC_MIN_LUCRO and tab2.PERC_MAX_LUCRO then
       ((tab2.comissaoliquidez-tab2.sal_fixo)*(tab2.PESO_LUCRO/100))*(tab2.perc_cob_LUCRO/100) 
            when tab2.perc_cob_lucro>tab2.PERC_MAX_LUCRO  then
              ((tab2.comissaoliquidez-tab2.sal_fixo)*(tab2.PESO_LUCRO/100))*(tab2.PERC_MAX_LUCRO/100)  
         else 0 end vlr_meta_lucro,    
         
       tab2.sal_fixo-(tab2.sal_fixo*(INSS/100)) sal_fixoinss
             
                   
      from (
select
       TAB1.*,
       CASE when tab1.vlmetatotal>0 then round(((tab1.vlvenda/tab1.vlmetatotal)*100),2) 
            else 0 end perc_meta_fin,
       tab1.FIXO SAL_FIXO,
       :INSS INSS,
       
       :PERC_MIN_META_FIN PERC_MIN_META_FIN,
       :PERC_MAX_META_FIN PERC_MAX_META_FIN,
       :PESO_META_FIN PESO_META_FIN,
       
       :PERC_MIN_META_FIN_FOR PERC_MIN_META_FIN_FOR,
       :PERC_MAX_META_FIN_FOR PERC_MAX_META_FIN_FOR,
       :PESO_META_FIN_FOR PESO_META_FIN_FOR,
       
       :PERC_MIN_META_POS_FOR PERC_MIN_META_POS_FOR,
       :PERC_MAX_META_POS_FOR PERC_MAX_META_POS_FOR,
       :PESO_META_POS_FOR PESO_META_POS_FOR,
       
       :PERC_MIN_INAD PERC_MIN_INAD,
       :PERC_MAX_INAD PERC_MAX_INAD,
       :PESO_INAD PESO_INAD,
       
       :PERC_MIN_LUCRO PERC_MIN_LUCRO,
       :PERC_MAX_LUCRO PERC_MAX_LUCRO,
       :PESO_LUCRO PESO_LUCRO,
       
       
       fnc_wn_premiacao_comissao(:COD_FILIAL, TAB1.CODUSUR, to_date(:DTINICIO,'dd-mm-rrrr'), to_date(:DTFIM,'dd-mm-rrrr'), 1) LIQUIDEZ,
       fnc_wn_premiacao_comissao(:COD_FILIAL, TAB1.CODUSUR, to_date(:DTINICIO,'dd-mm-rrrr'), to_date(:DTFIM,'dd-mm-rrrr'), 2) COMISSAOLIQUIDEZ,
       fnc_wn_premiacao_comissao(:COD_FILIAL, TAB1.CODUSUR, to_date(:DTINICIO,'dd-mm-rrrr'), to_date(:DTFIM,'dd-mm-rrrr'), 3) PERC_INAD,
       fnc_wn_premiacao_comissao(:COD_FILIAL, TAB1.CODUSUR, to_date(:DTINICIO,'dd-mm-rrrr'), to_date(:DTFIM,'dd-mm-rrrr'), 4) PERC_COB_FORN_FIN,
       fnc_wn_premiacao_comissao(:COD_FILIAL, TAB1.CODUSUR, to_date(:DTINICIO,'dd-mm-rrrr'), to_date(:DTFIM,'dd-mm-rrrr'), 5) PERC_COB_FORN_POS,  
       fnc_wn_premiacao_comissao(:COD_FILIAL, TAB1.CODUSUR, to_date(:DTINICIO,'dd-mm-rrrr'), to_date(:DTFIM,'dd-mm-rrrr'), 6) PERC_COB_LUCRO,
       fnc_wn_premiacao_comissao(:COD_FILIAL, TAB1.CODUSUR, to_date(:DTINICIO,'dd-mm-rrrr'), to_date(:DTFIM,'dd-mm-rrrr'), 7) META_LUCRO,
       fnc_wn_premiacao_comissao(:COD_FILIAL, TAB1.CODUSUR, to_date(:DTINICIO,'dd-mm-rrrr'), to_date(:DTFIM,'dd-mm-rrrr'), 8) PERC_LUCRO
       from ( 
     
SELECT pcusuari.codsupervisor,
      
       pcsuperv.nome AS nomesup, 
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
       NVL (vendas.vlvenda, 0) vlvenda, 
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
      
( SELECT COUNT(DISTINCT(PCCLIENT.CODCLI)) QTCLIATIVOS FROM PCCLIENT
WHERE ( (PCCLIENT.CODUSUR1 = PCUSUARI.CODUSUR)  OR ( (PCCLIENT.CODUSUR2 = PCUSUARI.CODUSUR ) AND ( NVL(PCCLIENT.codusur1,0) <> NVL(PCCLIENT.codusur2,0)) )  OR
         EXISTS (SELECT PCUSURCLI.CODUSUR
                   FROM PCUSURCLI
                  WHERE PCUSURCLI.CODUSUR = PCUSUARI.CODUSUR
                  AND NVL(PCUSURCLI.CODUSUR,0) <> NVL(PCCLIENT.codusur1,0)
                   AND NVL(PCUSURCLI.CODUSUR,0) <> NVL(PCCLIENT.codusur2,0)
                    AND PCUSURCLI.CODCLI  = PCCLIENT.CODCLI))
AND ( PCCLIENT.DTULTCOMP >= trunc(sysdate - (SELECT nvl(numdiascliinativ,0) FROM pcconsum) ) )
  ) clqtcliativ
  
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
)tab2
) tab3
) tab4