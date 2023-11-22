-- DATA_INI | DATA_FIN | COD_RCA | NOME_RCA | MARGEM_PADRAO | COD_SUP | VENDA | VENDA_AFA | DEV | VENDA_LIQ | CMV | VLR_LUCRO | PER_LUCRO
SELECT --Obj1.2_init
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
                              and p.CODUSUR in (:COD_RCA)
                              and p.CODSUPERVISOR in (:Cod_Super)  
                              --AND P.CONDVENDA IN (1)                        
                         group by p.CODUSUR, p.CODSUPERVISOR    

                    ) tab
                    group by tab.rca, tab.sup    
                    order by sup,per_lucro desc    