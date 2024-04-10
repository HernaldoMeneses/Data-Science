-- if P_OPCAO = 3 then --- RETORNA A % de inadimplencia vide 1221
  select     
  tab1.DTVENC,
  pcsuperv.codgerente,
    tab1.codsupervisor,
    tab1.CODUSUR,
    sum(valor30) as valores16,
      sum(valor5) as valores5 
    
    from (
  
  select
  DTVENC,
    codsupervisor, 
      CODUSUR,
      sum(valor30) as valor30,
      sum(valor5) as valor5
       --round((sum(valor30)/(sum(valor30)+sum(valor5))*100),2) as percent_inad
    from (
select
    DTVENC,
      codsupervisor,
      CODUSUR,
       valor valor5,
       0  valor30 
      from (
SELECT
PCPREST.DTVENC

, pcprest.codsupervisor
, PCPREST.CODUSUR
, DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),5),5,5   
,DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),15),15,15      
,DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),30),30,30      
,DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),60),60,60      
,DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),90),90,90      
,91))))) DIASVENC,                                              
SUM(PCPREST.VALOR) VALOR, COUNT(*) QT                           
 FROM PCPREST 
 WHERE PCPREST.DTPAG IS NULL                                                                                  
   AND (PCPREST.CODFILIAL IN ( 2 )) 

   --AND (PCPREST.CODUSUR IN ( P_RCA )) 


AND PCPREST.VALOR BETWEEN 0 AND 999999999                                                               
AND PCPREST.CODCOB NOT IN ('DEVP', 'DEVT', 'BNF',                                               
                           'BNFT', 'BNFR', 'BNTR',                                        
                           'BNRP', 'CRED', 'DESD')                                             
GROUP BY 
PCPREST.DTVENC
, pcprest.codsupervisor
,PCPREST.CODUSUR
, DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),5),5,5 
,DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),15),15,15      
,DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),30),30,30      
,DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),60),60,60      
,DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),90),90,90      
,91)))))
) tab1
where tab1.diasvenc=5
--group by CODUSUR, valor5, valor30 

union all

select  
    DTVENC,
     codsupervisor,
      CODUSUR,
       0 valor5,
       sum(valor)  valor30 
      from (
SELECT
PCPREST.DTVENC
, pcprest.codsupervisor 
,PCPREST.CODUSUR
,DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),5),5,5   
,DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),15),15,15      
,DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),30),30,30      
,DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),60),60,60      
,DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),90),90,90      
,91))))) DIASVENC,                                              
SUM(PCPREST.VALOR) VALOR, COUNT(*) QT                           
 FROM PCPREST 
 WHERE PCPREST.DTPAG IS NULL                                                                                  
   AND (PCPREST.CODFILIAL IN ( 2 )) 

   --AND (PCPREST.CODUSUR IN ( P_RCA )) 


AND PCPREST.VALOR BETWEEN 0 AND 999999999                                                               
AND PCPREST.CODCOB NOT IN ('DEVP', 'DEVT', 'BNF',                                               
                           'BNFT', 'BNFR', 'BNTR',                                        
                           'BNRP', 'CRED', 'DESD')                                             
GROUP BY 
 PCPREST.DTVENC
, pcprest.codsupervisor
,PCPREST.CODUSUR
,DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),5),5,5 
,DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),15),15,15      
,DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),30),30,30      
,DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),60),60,60      
,DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),90),90,90      
,91)))))
) tab1
where tab1.diasvenc>16
group by 
    DTVENC
    , codsupervisor
      ,CODUSUR
    )
    group by 
    DTVENC
    , codsupervisor
      ,CODUSUR

      ) tab1
INNER JOIN PCSUPERV ON tab1.codsupervisor = PCSUPERV.codsupervisor
GROUP BY
    tab1.DTVENC,
    pcsuperv.codgerente,
    tab1.codsupervisor,
    tab1.CODUSUR;