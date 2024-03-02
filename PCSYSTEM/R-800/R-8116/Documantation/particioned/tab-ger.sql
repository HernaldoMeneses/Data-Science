select 
p.codgerente,
     --p.CODUSUR rca, 
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
                              --and p.CODSUPERVISOR in (:Cod_Super) 
                              and p.codgerente in (:Cod_Ger) 
                              --AND P.CONDVENDA IN (1)                        
                         group by 
                         p.codgerente
                         --,p.CODUSUR
                         , p.CODSUPERVISOR    