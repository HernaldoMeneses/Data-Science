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
     tab3.qtcli/tab3.clqtcliativ*100 as Perc_Positva
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
         -- AND pcusuari.codusur in (:COD_RCA)
          AND PCUSUARI.CODSUPERVISOR in (:Cod_Super)
          AND NVL(VLVENDA, 0) <> 0 
          ORDER BY PCUSUARI.CODSUPERVISOR,VLVENDA DESC
     ) tab1, --Obj1.1__
     (SELECT --Obj1.2_init
          --'NOMEUSUARIOLOGADO'  USUARIO,
         -- (SELECT fnc_dp_ret_dados_consulta((select listagg(pf.codigo, ',') WITHIN GROUP
         -- (ORDER BY pf.codigo) codigo from pcfilial pf where pf.codigo in (:COD_FILIAL)), 1) FROM DUAL) FILIAL,
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
                              and p.CODSUPERVISOR in (:Cod_Super)  
                              --AND P.CONDVENDA IN (1)                        
                         group by p.CODUSUR, p.CODSUPERVISOR    

                    ) tab
                    group by tab.rca, tab.sup    
                    order by sup,per_lucro desc    
   ) tab2