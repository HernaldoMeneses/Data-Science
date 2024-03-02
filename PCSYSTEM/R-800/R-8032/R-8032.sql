--SCRIPT NOVO ALTERADO DIA 01-09-2022 
 
--SEM MACROS

 SELECT 
        B.USUARIO, B.DATA_INICIAL, B.DATA_FINAL, B.cod_supervisor, B.nome_sup,
        B.cod_rca, 
        B.nome_rca, 
        B.cod_fornec, 
        B.nome_fornec, B.venda,

        NVL((SELECT SUM(vw_vendaspedido.PVENDA) 
               FROM vw_vendaspedido, PCCLIENT
              WHERE vw_vendaspedido.CODCLI = PCCLIENT.CODCLI 
                AND vw_vendaspedido.CODUSUR = B.cod_rca 
                AND vw_vendaspedido.CODSUPERVISOR = B.cod_supervisor 
                AND vw_vendaspedido.CODFORNEC = B.cod_fornec
                AND vw_vendaspedido.CODFILIAL IN (2)
                AND PCCLIENT.CODREDE IN (1,2,4,5)
                AND vw_vendaspedido.DATA between :DATA_INI and :DATA_FIM),0) VENDA_REDE,
        B.positivacao, 
        B.meta_fim, 
        B.meta_pos, 
        B.perc_meta_fim, B.perc_meta_pos
 
FROM 

(        select 
        'NOMEUSUARIOLOGADO'  USUARIO,
       
       (SELECT fnc_dp_ret_dados_consulta((select listagg(pf.codigo, ',') WITHIN GROUP
          --(ORDER BY pf.codigo) codigo from pcfilial pf where pf.codigo in (:COD_FILIAL)), 1) FROM DUAL) FILIAL,
          (ORDER BY pf.codigo) codigo from pcfilial pf where pf.codigo in (2)), 1) FROM DUAL) FILIAL,
       :DATA_INI DATA_INICIAL,
       :DATA_FIM DATA_FINAL,
       tab2.*,            
  -- fnc_wn_premiacao_comissao(:COD_FILIAL, tab.cod_rca, to_date(:DATA_INI,'dd-mm-rrrr'), to_date(:DATA_FIM,'dd-mm-rrrr'), 4) perc_meta_fim,
  -- fnc_wn_premiacao_comissao(:COD_FILIAL, tab.cod_rca, to_date(:DATA_INI,'dd-mm-rrrr'), to_date(:DATA_FIM,'dd-mm-rrrr'), 5) perc_meta_pos
      case when tab2.meta_fim>0 then 
                  round(((tab2.venda/tab2.meta_fim)*100),2)
              else 0 end perc_meta_fim ,
              
        case when tab2.meta_pos>0 then 
                  round(((tab2.positivacao/tab2.meta_pos)*100),2)
              else 0 end perc_meta_pos            
             
    from (
select 
  tab.cod_supervisor,
      tab.nome_sup,
       tab.cod_rca,
       tab.nome_rca,
       tab.cod_fornec,
       tab.nome_fornec,
       sum(tab.venda) venda,
       sum(tab.positivacao) positivacao,
       sum(tab.meta_fin) meta_fim,
       sum(tab.meta_pos) meta_pos
   from (
select sp.codsupervisor cod_supervisor,
       sp.nome nome_sup,
       us.codusur cod_rca,
       us.nome nome_rca,
       pf.codfornec cod_fornec,
       pf.fornecedor nome_fornec,
       SUM(vd.PVENDA) venda,
       count(distinct vd.CODCLI) positivacao,
       0 meta_fin,
       0 meta_pos
    from pcusuari us, 
         pcsuperv sp,
         vw_vendaspedido vd,
         pcfornec pf,
         pcprodut pp
     where 1=1 
       and us.codsupervisor=sp.codsupervisor
       and us.codusur=vd.CODUSUR
       AND VD.DATA between :DATA_INI and :DATA_FIM
       and vd.CODFILIAL in (2)
       and US.CODSUPERVISOR in (:COD_SUPERVISOR)
       and US.CODUSUR in (:COD_RCA)
       and vd.CODPROD=pp.codprod
       and pf.codfornec=pp.codfornec  
     group by sp.codsupervisor,
       sp.nome,
       us.codusur,
       us.nome,
       pf.codfornec,
       pf.fornecedor
       
             
     union all
     
     select 
     sp.codsupervisor cod_supervisor,
       sp.nome nome_sup,
       us.codusur cod_rca,
       us.nome nome_rca,
       pf.codfornec cod_fornec,
       pf.fornecedor nome_fornec,
       0 venda,
       0 positivacao,
       SUM(NVL(mt.VLVENDAPREV,0)) meta_fin,
       SUM(NVL(mt.CLIPOSPREV,0)) meta_pos
    from pcusuari us, 
         pcsuperv sp,
         pcmeta mt,
         pcfornec pf
     where us.codsupervisor=sp.codsupervisor
       and us.codusur=mt.CODUSUR
       AND mt.DATA between :DATA_INI and :DATA_FIM
       and mt.CODFILIAL in (2)
       and US.CODSUPERVISOR in (:COD_SUPERVISOR)
       and US.CODUSUR in (:COD_RCA)
       and mt.codigo=pf.codfornec 
       AND mt.TIPOMETA = 'F' 
     group by 
     sp.codsupervisor,
       sp.nome,
       us.codusur,
       us.nome,
       pf.codfornec,
       pf.fornecedor   
       ) tab   
       group by 
       tab.cod_supervisor,
       tab.nome_sup,
       tab.cod_rca,
       tab.nome_rca,
       tab.cod_fornec,
       tab.nome_fornec
       )tab2
       where tab2.meta_fim>0
        order by 
        tab2.cod_supervisor, 
        tab2.cod_rca, tab2.nome_fornec ) B


   
