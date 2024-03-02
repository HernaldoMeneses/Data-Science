--########### - Guia Inicial.
--#
--# - Objetivo: Otimização da rotina 8008 - Relatório Comissão Ficha Liq-Friobom
--# - Obs     : Suprimi várias colunas da 8008, inclusive umas 2 tabelas inteiras.
--#
--# - Titulo  : Acompanhamento Geral - por Vendedor.
--# - Tema    : Otimização da rotina 8008.
--#
--# - Autor   : Hernaldo Meneses 
--# - Criação : 09/10/2023
--# - Infrastrutura de compilação e informações ao final do Script.
--#--------------------------------------------------------------------Thanks.
select  p1.nomesup, p1."META_Geral", 
p1."VEnda_Geral", p1."Perc_VENDA_Geral", 
round(p1."VEnda_Geral"/p2.qt_today*p2.qt_total,2) as tendencia,
round(round(p1."VEnda_Geral"/p2.qt_today*p2.qt_total,2)/ p1."META_Geral" * 100,2) as perc_tendencia, 
  p1."BAse Clientes", p1."CLI. Posit.", p1."perc_Posit"
, p1."Perc_Venda_IND.", p1."Perc_Posit_IND", p1."META_LUCRO", p1."Perc_Lucrat",  p1."LIQUIDADO",  p1.Devol, p1."Perc_DEVOL", p1."Perc_INADIMP"
 from (


select 
--distinct(Gerentes.DTINICIO) as DTINICIO,
--Gerentes.DTFIM,
--pcgerente.codgerente,
--pcgerente.nomegerente, 
--Gerentes.codsupervisor, 
Gerentes.nomesup,

 sum(Gerentes.vlmetatotal) as  "META_Geral",
  sum(Gerentes.vlvenda) as "VEnda_Geral",
   case when sum(Gerentes.vlmetatotal)>0 then round(sum(Gerentes.vlvenda)/sum(Gerentes.vlmetatotal)*100,2) else 0 end "Perc_VENDA_Geral",


 sum(Gerentes.clqtcliativ) as "BAse Clientes",
     sum(Gerentes.Positivacao) as "CLI. Posit.",
     case when sum(Gerentes.clqtcliativ)>0 then round( sum(Gerentes.Positivacao)/sum(Gerentes.clqtcliativ)*100,2) else 0 end "perc_Posit",

     
     round(avg(Gerentes.PERC_COB_FORN_FIN),2) as "Perc_Venda_IND.",
    round(avg(Gerentes.PERC_COB_FORN_POS),2) as "Perc_Posit_IND",
     
     '19%' as META_LUCRO,

     --sum(Gerentes.lucro) as LUCRO,
     --round(avg(Gerentes.PERC_COB_LUCRO),2) as "% Lucrat",
     case when  sum(Gerentes.vlvenda)>0 then round(sum(Gerentes.lucro)/ sum(Gerentes.vlvenda)/0.19,2)*100 else 0 end  "Perc_Lucrat",
     
   sum(Gerentes.LIQUIDEZ) as LIQUIDADO,
     
--     tabelao.per_lucro,
--     tabelao.venda,

    sum(Gerentes.Devol) as Devol,
     case when sum(Gerentes.vlvenda) > 0 then round(COALESCE( sum(Gerentes.Devol),0)/sum(Gerentes.vlvenda)*100,2) else 0 end "Perc_DEVOL",
      round(avg(Gerentes.PERC_INAD),2) as "Perc_INADIMP"




 from (
select 
     tabelao.DTINICIO,
     tabelao.DTFIM,
     tabelao.codsupervisor, tabelao.nomesup,
     tabelao.codusur, tabelao.nome,
      
     tabelao.vlmetatotal, 
     tabelao.vlvenda,
     tabelao.perc_meta_fin,
     
     tabelao.clqtcliativ,
     tabelao.Positivacao,
     tabelao.Perc_Positva,
     
     tabelao.PERC_COB_FORN_FIN,
     tabelao.PERC_COB_FORN_POS,
     
     tabelao.META_LUCRO,
     tabelao.PERC_LUCRO,
     tabelao.lucro as LUCRO,
     tabelao.PERC_COB_LUCRO,
     
     tabelao.LIQUIDEZ,
     
--     tabelao.per_lucro,
--     tabelao.venda,

     COALESCE(tab4.VLTOTAL,0) as Devol,
     case when tabelao.vlvenda > 0 then COALESCE(tab4.VLTOTAL,0)/tabelao.vlvenda*100 else 0 end Perc_Devol,
      tabelao.PERC_INAD
from (
SELECT --Obj1_init
     to_date(:DTINICIO,'dd-mm-rrrr') As DTINICIO,
     to_date(:DTFIM,'dd-mm-rrrr') AS DTFIM,
     TAB1.codsupervisor, TAB1.nomesup,
     TAB1.codusur, TAB1.nome, 
     TAB1.vlmetatotal, TAB1.vlvenda,
     CASE when tab1.vlmetatotal>0 
          then round(((tab1.vlvenda/tab1.vlmetatotal)*100),2) 
          else 0 end perc_meta_fin,
     
     TAB1.vlvenda * (fnc_wn_premiacao_comissao(:COD_FILIAL, TAB1.CODUSUR, to_date(:DTINICIO,'dd-mm-rrrr'), to_date(:DTFIM,'dd-mm-rrrr'), 8))/100  as Lucro,
     fnc_wn_premiacao_comissao(:COD_FILIAL, TAB1.CODUSUR, to_date(:DTINICIO,'dd-mm-rrrr'), to_date(:DTFIM,'dd-mm-rrrr'), 4) PERC_COB_FORN_FIN,
     fnc_wn_premiacao_comissao(:COD_FILIAL, TAB1.CODUSUR, to_date(:DTINICIO,'dd-mm-rrrr'), to_date(:DTFIM,'dd-mm-rrrr'), 5) PERC_COB_FORN_POS,
     fnc_wn_premiacao_comissao(:COD_FILIAL, TAB1.CODUSUR, to_date(:DTINICIO,'dd-mm-rrrr'), to_date(:DTFIM,'dd-mm-rrrr'), 7) META_LUCRO,
     fnc_wn_premiacao_comissao(:COD_FILIAL, TAB1.CODUSUR, to_date(:DTINICIO,'dd-mm-rrrr'), to_date(:DTFIM,'dd-mm-rrrr'), 8) PERC_LUCRO,
     fnc_wn_premiacao_comissao(:COD_FILIAL, TAB1.CODUSUR, to_date(:DTINICIO,'dd-mm-rrrr'), to_date(:DTFIM,'dd-mm-rrrr'), 6) PERC_COB_LUCRO,
     fnc_wn_premiacao_comissao(:COD_FILIAL, TAB1.CODUSUR, to_date(:DTINICIO,'dd-mm-rrrr'), to_date(:DTFIM,'dd-mm-rrrr'), 1) LIQUIDEZ,
     tab2.per_lucro,
     tab2.venda,
     tab2.dev,
     tab2.cmv,
     fnc_wn_premiacao_comissao(:COD_FILIAL, TAB1.CODUSUR, to_date(:DTINICIO,'dd-mm-rrrr'), to_date(:DTFIM,'dd-mm-rrrr'), 3) PERC_INAD,
     tab3.clqtcliativ,
     tab3.qtcli as Positivacao,
     case when tab3.clqtcliativ > 0 then tab3.qtcli/tab3.clqtcliativ*100 else 0 end Perc_Positva
     --COALESCE(tab4.VLTOTAL,0) as Devol
     --tab4.VLTOTAL/TAB1.vlvenda*100 as Perc_Devol                 
FROM --Obj1       
     (SELECT --Obj1.1_init
          pcusuari.codsupervisor,
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
          NVL (vendas.vlvenda, 0) vlvenda
          FROM --Obj1.1 
               pcusuari, 
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
                    (SELECT   
                         pcprest.codusur, 
                         (SUM(PCPREST.VALOR) ) valor,
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
          --AND pcusuari.codusur in (:COD_RCA)
          AND PCUSUARI.CODSUPERVISOR in (select pcsuperv.codsupervisor from pcsuperv where pcsuperv.codgerente = :Cod_ger)
          AND NVL(VLVENDA, 0) <> 0 
          ORDER BY PCUSUARI.CODSUPERVISOR,VLVENDA DESC
     ) tab1, --Obj1.1__
     (SELECT --Obj1.2_init
          'NOMEUSUARIOLOGADO'  USUARIO,
          (SELECT fnc_dp_ret_dados_consulta((select listagg(pf.codigo, ',') WITHIN GROUP
          (ORDER BY pf.codigo) codigo from pcfilial pf where pf.codigo in (:COD_FILIAL)), 1) FROM DUAL) FILIAL,
          to_date(:DTINICIO,'dd-mm-rrrr') data_ini,
          to_date(:DTFIM,'dd-mm-rrrr') data_fin,
          tab.rca cod_rca,
          (select v.nome from pcusuari v where v.codusur=tab.rca) nome_rca,     
          (select v.comissaoservicoprestado from pcusuari v where v.codusur=tab.rca) margem_padrao,  
          tab.sup cod_sup,
          (select s.nome from pcsuperv s where s.codsupervisor=tab.sup) nome_sup,
          round(sum(tab.venda),2) venda,
          round(sum(tab.venda_afat),2) venda_afat,
          round(sum(tab.dev),2) dev,
          round(sum(tab.venda) - sum(tab.dev),2) venda_liq,
          round(sum(custofin),2) cmv,
          round((sum(tab.venda)-sum(tab.dev))-sum(custofin),2) vlr_lucro,   
          case when (sum(tab.venda))<= 0 then 0 
            else round((((sum(tab.venda)-sum(tab.dev))-sum(custofin))/(sum(tab.venda))*100),2)
                end  per_lucro
          from (select p.CODUSUR rca, 
                    p.CODSUPERVISOR sup, 
                    sum(p.PVENDA) venda, 
                    0 dev ,
                    SUM(P.VLCUSTOFIN) custofin ,
                    --(sum(p.vlcustofin)-(sum((select sum(pi.qt*nvl(pi.vlverbacmv,0))+sum(pi.qt*nvl(pi.vlrebaixacmv,0))+sum(pi.qt*nvl(pi.vlverbacmvcli,0)) from pcpedi pi where pi.numped=p.numped)))) custofin , 
                    0 venda_afat
                    from vw_vendaspedido_8022 p
               
                              where  TO_DATE(p.DATA, 'DD-MM-RRRR') between to_date(:DTINICIO,'dd-mm-rrrr') and to_date(:DTFIM,'dd-mm-rrrr')
                              --and p.DTCANCEL is null
                              and p.CODFILIAL=:COD_FILIAL
                              --and p.CODUSUR in (:COD_RCA)
                              --To_gerentes>H.Meneses
                              --and p.CODSUPERVISOR in (:Cod_Super)  
                              and p.CODGERENTE in (:Cod_ger)  
                              --AND P.CONDVENDA IN (1)                        
                         group by p.CODUSUR, p.CODSUPERVISOR    

                    ) tab
                    group by tab.rca, tab.sup    
                    order by sup,per_lucro desc    
   ) tab2, --Obj1.2__
   (SELECT --Obj1.3_init
          pcusuari.codusur, 
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
                    AND pcpedc.DATA BETWEEN to_date(:DTINICIO,'dd/mm/yyyy') AND to_date(:DTFIM,'dd/mm/yyyy') 
                    AND pcpedI.DATA BETWEEN to_date(:DTINICIO,'dd/mm/yyyy') AND to_date(:DTFIM,'dd/mm/yyyy') 
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
                    AND  PCPEDC.codgerente  in (:Cod_ger)  
                    GROUP BY  PCPEDC.CODUSUR  ) vendas,
               (SELECT   
                    pcprest.codusur, (SUM(PCPREST.VALOR) ) valor,
                    COUNT (*) qtpend 
                    FROM pcprest, pcusuari
                    WHERE pcprest.dtpag IS NULL
                    AND pcprest.codusur = pcusuari.codusur
                    AND pcprest.codfilial IN ('2')
                    AND pcusuari.codsupervisor in (select pcsuperv.codsupervisor from pcsuperv where pcsuperv.codgerente = :Cod_ger)
                    GROUP BY pcprest.codusur) financ,
               (SELECT 
                    pcprest.codusur, SUM(VALOR) vpago
                    FROM PCPREST, PCCLIENT, PCUSUARI, PCSUPERV, PCCOB
                    WHERE PCPREST.CODCLI = PCCLIENT.CODCLI
                    and PCPREST.CODUSUR = PCUSUARI.CODUSUR
                    and PCUSUARI.CODSUPERVISOR = PCSUPERV.CODSUPERVISOR
                    and PCPREST.CODCOB = PCCOB.CODCOB
                    and PCPREST.CODCOB not in ('DEVP', 'DEVT', 'BNF', 'BNFT', 'BNFR', 'BNTR', 'BNRP', 'CRED')
                    and PCUSUARI.CODSUPERVISOR in (select pcsuperv.codsupervisor from pcsuperv where pcsuperv.codgerente = :Cod_ger)
                    and PCPREST.DTPAG is NULL
                    and (PCPREST.DTVENC + NVL(PCCOB.DIASCARENCIA,0)) <= (TRUNC(SYSDATE) - 1)
                    and (Pcprest.CODFILIAL IN ('2'))
                    GROUP BY pcprest.codusur) inandimp,
               (SELECT  PCPEDC.CODUSUR  CODUSUR,COUNT(DISTINCT(PCPEDI.CODPROD)) AS QTMIX
                    FROM PCPEDI, PCUSUARI, PCSUPERV, PCPEDC
                    WHERE PCPEDI.NUMPED = PCPEDC.NUMPED
                    AND NVL(PCPEDI.BONIFIC, 'N') =  'N' 
                    AND  PCPEDC.CODUSUR  = PCUSUARI.CODUSUR
                    AND PCPEDC.DATA BETWEEN to_date(:DTINICIO,'dd/mm/yyyy') AND to_date(:DTFIM,'dd/mm/yyyy') 
                    AND PCPEDC.CONDVENDA IN (1, 2, 3, 7, 9, 14, 15, 17, 18, 19, 98)
                    AND PCPEDC.DTCANCEL IS NULL
                    AND pcpedc.vlatend > 0 
                    AND PCUSUARI.CODSUPERVISOR = PCSUPERV.CODSUPERVISOR
                    AND PCPEDC.CODFILIAL IN ('2')
                    AND  PCPEDC.CODSUPERVISOR in (select pcsuperv.codsupervisor from pcsuperv where pcsuperv.codgerente = :Cod_ger)
                    GROUP BY  PCPEDC.CODUSUR  ) MIX
                    WHERE pcusuari.codsupervisor = pcsuperv.codsupervisor
                    AND pcusuari.codusur = vendas.codusur(+)
                    AND pcusuari.codusur = financ.codusur(+)
                    AND pcusuari.codusur = inandimp.codusur(+)
                    AND pcusuari.codusur = mix.codusur(+)
                    AND PCUSUARI.CODSUPERVISOR in (select pcsuperv.codsupervisor from pcsuperv where pcsuperv.codgerente = :Cod_ger)
                    AND NVL(VLVENDA, 0) <> 0 
                    ORDER BY PCUSUARI.CODSUPERVISOR,VLVENDA DESC
     ) tab3 
     
     WHERE TAB1.codusur = tab2.cod_rca
AND tab2.cod_rca = tab3.codusur
     ) tabelao
      --Obj1.3__
    LEFT JOIN (SELECT --Obj1.4_init
  PCUSUARI.CODSUPERVISOR,
  PCUSUARI.CODusur,
  DECODE(SUM(PCNFENT.VLTOTAL),0,SUM(PCESTCOM.VLDEVOLUCAO),SUM(PCNFENT.VLTOTAL)) AS VLTOTAL
  FROM PCNFENT, PCESTCOM, PCTABDEV, PCCLIENT, PCEMPR, PCUSUARI, PCSUPERV, PCEMPR FUNC, PCNFSAID, PCDEVCONSUM
 WHERE  ( PCNFENT.CODDEVOL = PCTABDEV.CODDEVOL(+) )
   AND PCNFENT.NUMTRANSENT = PCESTCOM.NUMTRANSENT (+)
   AND   ( PCNFENT.CODFORNEC  = PCCLIENT.CODCLI )
   AND ( PCNFENT.NUMTRANSENT = PCDEVCONSUM.NUMTRANSENT(+) )
   AND NVL(PCNFENT.CODFILIALNF, PCNFENT.CODFILIAL) = :COD_FILIAL
   AND   ( PCNFENT.CODFUNCLANC       = FUNC.MATRICULA(+))
   AND   ( PCNFENT.CODMOTORISTADEVOL = PCEMPR.MATRICULA(+))
   AND   (  PCNFENT.CODUSURDEVOL  = PCUSUARI.CODUSUR )
   AND   ( PCUSUARI.CODSUPERVISOR    = PCSUPERV.CODSUPERVISOR(+))
   AND   ( PCNFENT.DTENT BETWEEN  to_date(:DTINICIO,'dd/mm/yyyy') AND to_date(:DTFIM,'dd/mm/yyyy')  )
   AND   ( PCNFENT.TIPODESCARGA IN ('6','7','T') ) 
   AND   ( NVL(PCNFENT.OBS, 'X') <> 'NF CANCELADA')
   AND   ( PCNFENT.CODFISCAL IN ('131','132','231','232','199','299') )
   AND EXISTS (SELECT PCPRODUT.CODPROD 
                 FROM PCPRODUT, PCMOV
                WHERE PCMOV.CODPROD = PCPRODUT.CODPROD
                  AND PCMOV.NUMTRANSENT = PCNFENT.NUMTRANSENT
                  AND PCMOV.NUMNOTA = PCNFENT.NUMNOTA
                  AND PCMOV.DTCANCEL IS NULL
                  AND ( EXISTS ( SELECT CODEPTO 
                                   FROM PCDEPTO 
                                  WHERE PCPRODUT.CODEPTO = PCDEPTO.CODEPTO 
                                    AND PCDEPTO.CODEPTO NOT IN (9999, 999999) 
                                    AND ((SELECT COUNT(1) 
                                            FROM PCLIB 
                                           WHERE CODTABELA = 2 
                                             --AND PCLIB.CODFUNC = :CODFUNCX 
                                             AND ((PCLIB.CODIGON = 9999) OR (PCLIB.CODIGON = 999999))) > 0 
                                              OR (SELECT COUNT(1) 
                                                    FROM PCLIB 
                                                   WHERE CODTABELA = 2 
                                                     --AND PCLIB.CODFUNC = :CODFUNCX 
                                                     AND PCLIB.CODIGON = PCDEPTO.CODEPTO 
                                                     AND PCLIB.CODIGON IS NOT NULL) > 0))) 
                                                     AND (EXISTS (SELECT CODFORNEC 
                                                                    FROM PCFORNEC 
                                                                   WHERE PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC 
                                                                     AND PCFORNEC.CODFORNEC NOT IN (9999, 999999) 
                                                                     AND ((SELECT COUNT(1) 
                                                                            FROM PCLIB 
                                                                           WHERE CODTABELA = 3 
                                                                             --AND PCLIB.CODFUNC = :CODFUNCX 
                                                                             AND ((PCLIB.CODIGON = 9999) OR (PCLIB.CODIGON = 999999))) > 0 
                                                                              OR (SELECT COUNT(1) 
                                                                                    FROM PCLIB 
                                                                                   WHERE CODTABELA = 3 
                                                                                     --AND PCLIB.CODFUNC = :CODFUNCX 
                                                                                     AND PCLIB.CODIGON = PCFORNEC.CODFORNEC 
                                                                                     AND PCLIB.CODIGON IS NOT NULL) > 0))) 
                                                                                     AND PCMOV.CODFILIAL = PCNFENT.CODFILIAL)
                                                                                     AND (EXISTS (SELECT CODSUPERVISOR 
                                                                                                    FROM PCUSUARI 
                                                                                                   WHERE PCUSUARI.CODSUPERVISOR = PCUSUARI.CODSUPERVISOR 
                                                                                                     AND PCUSUARI.CODSUPERVISOR NOT IN (9999, 999999) 
                                                                                                     AND ((SELECT COUNT(1) 
                                                                                                            FROM PCLIB 
                                                                                                           WHERE CODTABELA = 7 
                                                                                                             --AND PCLIB.CODFUNC = :CODFUNCX 
                                                                                                             AND ((PCLIB.CODIGON = 9999) OR (PCLIB.CODIGON = 999999))) > 0 
                                                                                                              OR (SELECT COUNT(1) 
                                                                                                                    FROM PCLIB 
                                                                                                                   WHERE CODTABELA = 7 
                                                                                                                     --AND PCLIB.CODFUNC = :CODFUNCX 
                                                                                                                     AND PCLIB.CODIGON = PCUSUARI.CODSUPERVISOR 
                                                                                                                     AND PCLIB.CODIGON IS NOT NULL) > 0))) 
                                                                                                                     AND PCESTCOM.NUMTRANSVENDA = PCNFSAID.NUMTRANSVENDA(+) 
                                                                                                                     AND NVl(PCNFSAID.CONDVENDA,0) NOT IN (4, 8, 10, 13, 20, 98, 99)
                                                                                                                     AND PCESTCOM.NUMTRANSVENDA = PCNFSAID.NUMTRANSVENDA(+) 
GROUP BY     
  PCUSUARI.CODSUPERVISOR,
  PCUSUARI.CODusur
  --PCNFENT.VLTOTAL,
  --PCESTCOM.VLDEVOLUCAO                     
ORDER BY    
  PCUSUARI.CODSUPERVISOR,
  PCUSUARI.CODusur
     ) tab4 on tabelao.codusur = tab4.codusur


) Gerentes, pcgerente, pcsuperv
where pcsuperv.codgerente = :Cod_Ger
ANd pcsuperv.codgerente = pcgerente.codgerente
ANd pcsuperv.codsupervisor = gerentes.codsupervisor
group by 
--DTINICIO,
--Gerentes.DTFIM, 
--pcgerente.codgerente,
--pcgerente.nomegerente, 
--Gerentes.codsupervisor, 
Gerentes.nomesup
--AND tab2.cod_rca = tab4.codusur

) p1, (



select until_today.*, Until_end.*, (Until_end.qt_end + until_today.qt_today) as qt_total
from (
select 
 sum(CASE WHEN (DIAUTIL = 'S'  OR DIAUTIL IS NULL )THEN 1 ELSE 0 END) AS qt_today
 
from 
   pcdatas a
 where a.data >= to_date(:DTINICIO,'dd/mm/yyyy')
 and a.data <= to_date(sysdate,'dd/mm/yyyy')
      ) until_today ,
      (
     select 
     sum(CASE WHEN (DIAUTIL = 'S'  OR DIAUTIL IS NULL )THEN 1 ELSE 0 END) AS qt_end
     
     from 
     pcdatas a
     where a.data >= to_date(sysdate,'dd/mm/yyyy')
     and a.data <= to_date(:DTFIM,'dd/mm/yyyy')

      ) Until_end
   

) p2


--############# - Compile_By.
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
--# - Created by : Hernaldo Meneses (Matrix_total)
--# - Hello... please if you find something wrong,  contact-me.
--#--------------------------------------------------------------------Follow the white rabbit.