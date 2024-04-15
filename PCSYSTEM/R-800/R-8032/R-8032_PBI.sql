   select tab2.*             
    from (
select
  tab.data,
  tab.cod_gerente,
  tab.cod_supervisor,
      --tab.nome_sup,
       tab.cod_rca,
       --tab.nome_rca,
       tab.cod_fornec,
       --tab.nome_fornec,
       sum(tab.venda) venda,
       sum(tab.positivacao) positivacao,
       sum(tab.meta_fin) meta_fim,
       sum(tab.meta_pos) meta_pos
   from (
select 
VD.DATA,
sp.codgerente cod_gerente,
sp.codsupervisor cod_supervisor,
       --sp.nome nome_sup,
       us.codusur cod_rca,
       --us.nome nome_rca,
       pf.codfornec cod_fornec,
       --pf.fornecedor nome_fornec,
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
       --AND VD.DATA between :DATA_INI and :DATA_FIM
       AND VD.DATA >= to_date('01/04/2024','dd/mm/yyyy')
       and vd.CODFILIAL in (2)
       --and US.CODSUPERVISOR in (:COD_SUPERVISOR)
       --and US.CODUSUR in (:COD_RCA)
       and vd.CODPROD=pp.codprod
       and pf.codfornec=pp.codfornec  
     group by 
     VD.DATA,
     sp.codgerente cod_gerente,
     sp.codsupervisor,
       --sp.nome,
       us.codusur,
       --us.nome,
       pf.codfornec
       --pf.fornecedor
       
             
     union all
     
     select 
      mt.DATA, 
      sp.codgerente cod_gerente,
     sp.codsupervisor cod_supervisor,
       --sp.nome nome_sup,
       us.codusur cod_rca,
       --us.nome nome_rca,
       pf.codfornec cod_fornec,
       --pf.fornecedor nome_fornec,
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
       --AND mt.DATA between :DATA_INI and :DATA_FIM
        AND mt.DATA >= to_date('01/04/2024','dd/mm/yyyy')
       and mt.CODFILIAL in (2)
       --and US.CODSUPERVISOR in (:COD_SUPERVISOR)
       --and US.CODUSUR in (:COD_RCA)
       and mt.codigo=pf.codfornec 
       AND mt.TIPOMETA = 'F' 
     group by 
     mt.DATA,
     sp.codgerente cod_gerente,
     sp.codsupervisor,
       --sp.nome,
       us.codusur,
       --us.nome,
       pf.codfornec
       --pf.fornecedor   
       ) tab   
       group by
       tab.DATA, 
       tab.cod_gerente,
       tab.cod_supervisor,
       --tab.nome_sup,
       tab.cod_rca,
       --tab.nome_rca,
       tab.cod_fornec
       --tab.nome_fornec
       )tab2
       where tab2.meta_fim>0
        order by 
        tab2.cod_supervisor, 
        tab2.cod_rca, tab2.cod_fornec 
