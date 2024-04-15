
  
  select
  DTVENC,
  codgerente,
    codsupervisor, 
      CODUSUR,
      sum(valor30) as valor30,
      sum(valor5) as valor5
       --round((sum(valor30)/(sum(valor30)+sum(valor5))*100),2) as percent_inad
    from (
select
    DTVENC,
    codgerente,
      codsupervisor,
      CODUSUR,
       valor valor5,
       0  valor30 
      from (
SELECT
PCPREST.DTVENC
, pcsuperv.codgerente
, pcsuperv.codsupervisor  
, PCPREST.CODUSUR
, DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),5),5,5   
,DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),15),15,15      
,DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),30),30,30      
,DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),60),60,60      
,DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),90),90,90      
,91))))) DIASVENC,                                              
SUM(PCPREST.VALOR) VALOR, COUNT(*) QT                           
 FROM PCPREST, pcsuperv 
 WHERE PCPREST.DTPAG IS NULL 
 and  pcprest.codsupervisor = pcsuperv.codsupervisor                                                                                
   AND (PCPREST.CODFILIAL IN ( 2 )) 

   --AND (PCPREST.CODUSUR IN ( P_RCA )) 


AND PCPREST.VALOR BETWEEN 0 AND 999999999                                                               
AND PCPREST.CODCOB NOT IN ('DEVP', 'DEVT', 'BNF',                                               
                           'BNFT', 'BNFR', 'BNTR',                                        
                           'BNRP', 'CRED', 'DESD')                                             
GROUP BY 
PCPREST.DTVENC
, pcsuperv.codgerente
, pcsuperv.codsupervisor  
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
    codgerente,
     codsupervisor,
      CODUSUR,
       0 valor5,
       sum(valor)  valor30 
      from (
SELECT
PCPREST.DTVENC
, pcsuperv.codgerente
, pcsuperv.codsupervisor
,PCPREST.CODUSUR
,DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),5),5,5   
,DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),15),15,15      
,DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),30),30,30      
,DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),60),60,60      
,DECODE(GREATEST((TRUNC(SYSDATE)-PCPREST.DTVENC),90),90,90      
,91))))) DIASVENC,                                              
SUM(PCPREST.VALOR) VALOR, COUNT(*) QT                           
 FROM PCPREST , pcsuperv
 WHERE PCPREST.DTPAG IS NULL   
 and  pcprest.codsupervisor = pcsuperv.codsupervisor                                                                                 
   AND (PCPREST.CODFILIAL IN ( 2 )) 

   --AND (PCPREST.CODUSUR IN ( P_RCA )) 


AND PCPREST.VALOR BETWEEN 0 AND 999999999                                                               
AND PCPREST.CODCOB NOT IN ('DEVP', 'DEVT', 'BNF',                                               
                           'BNFT', 'BNFR', 'BNTR',                                        
                           'BNRP', 'CRED', 'DESD')                                             
GROUP BY 
 PCPREST.DTVENC
 , pcsuperv.codgerente
, pcsuperv.codsupervisor
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
    ,codgerente
    , codsupervisor
      ,CODUSUR
    )
    group by 
    DTVENC
    ,codgerente
    , codsupervisor
      ,CODUSUR

