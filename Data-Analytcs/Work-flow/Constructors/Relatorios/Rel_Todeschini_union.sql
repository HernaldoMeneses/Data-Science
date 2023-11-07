
Select
tab1.codfornec
--, tab1.DATA
, tab1.CODGERENTE  
, tab1.CODSUPERVISOR 
, tab1.CODUSUR
--, Max(tab1.CODPROD) as CODPROD
, Case when ((tab1.fill_1 =0 and SUM(tab1.QT) >=3) or (tab1.fill_1 =1 and SUM(tab1.QT) >=3)) then 1 else 0 end posit
--, SUM(tab1.fill_2) as fill_2
--, Case When SUM(tab1.fill_2) >=3 then 1 else 0 end as fill_3
, Sum(tab1.VLVENDA) as VLVENDA 
, SUM(tab1.QT) as QT 
from (

SELECT  
PCFORNEC.codfornec
, PCPEDC.CODGERENTE
, PCPEDC.CODSUPERVISOR
,PCPEDC.CODUSUR
,MAX(PCPEDC.CODCLI) AS CODCLI
,PCPRODUT.CODPROD
, DECODE(PCPRODUT.CODPROD, 112687, 1, 112632, 1, 112634,1, 0) As FILL_1
,       SUM(CASE                                                                                                                            
             WHEN NVL(PCPEDI.BONIFIC, 'N') = 'N' THEN                                                                                  
              DECODE(PCPEDC.CONDVENDA,                                                                                                     
                     5,                                                                                                                    
                    0,
                     6,                                                                                                                    
                     0,                                                                                                                    
                     11,                                                                                                                   
                     0,                                                                                                                    
                     12,                                                                                                                   
                     0,                                                                                                                    
                     NVL(PCPEDI.VLSUBTOTITEM,                                                                                              
                         (DECODE(NVL(PCPEDI.TRUNCARITEM, 'N'),                                                                           
                                 'N',                                                                                                    
                                 ROUND((NVL(PCPEDI.QT, 0)) * (NVL(PCPEDI.PVENDA, 0) + nvl(pcpedi.vloutrasdesp,0) + 
nvl(pcpedi.vlfrete,0)), 
                                       2),                                                                                                 
                                 TRUNC((NVL(PCPEDI.QT, 0)) * (NVL(PCPEDI.PVENDA, 0) + nvl(pcpedi.vloutrasdesp,0) + 
nvl(pcpedi.vlfrete,0)), 
                                       2)))))                                                                                              
             ELSE                                                                                                                          
    0 
           END) - SUM(CASE                                                                                                                 
                        WHEN NVL(PCPEDI.BONIFIC, 'N') = 'N' THEN                                                                       
                         DECODE(PCPEDC.CONDVENDA,                                                                                          
                                5,                                                                                                         
                                0,                                                                                                         
                                6,                                                                                                         
                                0,                                                                                                         
                                11,                                                                                                        
                                0,                                                                                                         
                                12,                                                                                                        
                                0,                                                                                                         
                                NVL(PCPEDI.qt, 0) * (0 + 0))                                                                               
                        ELSE                                                                                                               
                    0
                      END) VLVENDA,                                                                                                        
   --SUM((PCPEDI.qt)*NVL(PCPEDI.vlcustofin,0)) AS VLCUSTOFIN,
   SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') <> 'N' THEN 0 ELSE NVL(PCPEDI.QT, 0) END,5,0,6,0,11,0,12,0,
NVL(PCPEDI.QT,0))) QT
                                                                                                      
FROM PCPEDI
, PCPEDC
, PCSUPERV
, PCPRODUT
, PCDEPTO
, PCCLIENT
, PCUSUARI
, PCPRACA
, PCFORNEC

WHERE 1=1
AND PCPEDI.DATA >= to_date('01/10/2023','dd/mm/yyyy') and  PCPEDI.DATA <= to_date('31/10/2023','dd/mm/yyyy')
AND PCPEDC.DATA >= to_date('01/10/2023','dd/mm/yyyy') and  PCPEDC.DATA <= to_date('31/10/2023','dd/mm/yyyy')


AND PCPEDI.NUMPED = PCPEDC.NUMPED
AND  PCPEDC.CODSUPERVISOR  = PCSUPERV.CODSUPERVISOR
AND PCPEDI.CODPROD = PCPRODUT.CODPROD
AND PCPEDI.CODPROD not in  (112687, 112632, 112634)
AND PCPRODUT.CODEPTO = PCDEPTO.CODEPTO
AND  PCPEDC.CODUSUR  = PCUSUARI.CODUSUR
AND PCPEDC.CODCLI = PCCLIENT.CODCLI
AND PCPEDC.CODPRACA = PCPRACA.CODPRACA
AND PCPEDC.DTCANCEL IS NULL
AND PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC
AND PCFORNEC.CODFORNEC in (2946)
AND PCPEDC.CODFILIAL IN ('2')
AND PCPEDC.CONDVENDA NOT IN (4,8,10,13,20,98,99)

GROUP BY  PCPEDC.CODSUPERVISOR 

, PCPEDC.CODUSUR
, PCPEDC.CODFILIAL
, PCFORNEC.codfornec
, PCPRODUT.CODPROD
, PCPEDC.CODGERENTE


Union all

SELECT  
PCFORNEC.codfornec
, PCPEDC.CODGERENTE
, PCPEDC.CODSUPERVISOR
,PCPEDC.CODUSUR
,MAX(PCPEDC.CODCLI) AS CODCLI
,PCPRODUT.CODPROD
, DECODE(PCPRODUT.CODPROD, 112687, 1, 112632, 1, 112634,1, 0) As FILL_1
,       SUM(CASE                                                                                                                            
             WHEN NVL(PCPEDI.BONIFIC, 'N') = 'N' THEN                                                                                  
              DECODE(PCPEDC.CONDVENDA,                                                                                                     
                     5,                                                                                                                    
                    0,
                     6,                                                                                                                    
                     0,                                                                                                                    
                     11,                                                                                                                   
                     0,                                                                                                                    
                     12,                                                                                                                   
                     0,                                                                                                                    
                     NVL(PCPEDI.VLSUBTOTITEM,                                                                                              
                         (DECODE(NVL(PCPEDI.TRUNCARITEM, 'N'),                                                                           
                                 'N',                                                                                                    
                                 ROUND((NVL(PCPEDI.QT, 0)) * (NVL(PCPEDI.PVENDA, 0) + nvl(pcpedi.vloutrasdesp,0) + 
nvl(pcpedi.vlfrete,0)), 
                                       2),                                                                                                 
                                 TRUNC((NVL(PCPEDI.QT, 0)) * (NVL(PCPEDI.PVENDA, 0) + nvl(pcpedi.vloutrasdesp,0) + 
nvl(pcpedi.vlfrete,0)), 
                                       2)))))                                                                                              
             ELSE                                                                                                                          
    0 
           END) - SUM(CASE                                                                                                                 
                        WHEN NVL(PCPEDI.BONIFIC, 'N') = 'N' THEN                                                                       
                         DECODE(PCPEDC.CONDVENDA,                                                                                          
                                5,                                                                                                         
                                0,                                                                                                         
                                6,                                                                                                         
                                0,                                                                                                         
                                11,                                                                                                        
                                0,                                                                                                         
                                12,                                                                                                        
                                0,                                                                                                         
                                NVL(PCPEDI.qt, 0) * (0 + 0))                                                                               
                        ELSE                                                                                                               
                    0
                      END) VLVENDA,                                                                                                        
   --SUM((PCPEDI.qt)*NVL(PCPEDI.vlcustofin,0)) AS VLCUSTOFIN,
   SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') <> 'N' THEN 0 ELSE NVL(PCPEDI.QT, 0) END,5,0,6,0,11,0,12,0,
NVL(PCPEDI.QT,0))) QT
                                                                                                      
FROM PCPEDI
, PCPEDC
, PCSUPERV
, PCPRODUT
, PCDEPTO
, PCCLIENT
, PCUSUARI
, PCPRACA
, PCFORNEC

WHERE 1=1
AND PCPEDI.DATA >= to_date('01/10/2023','dd/mm/yyyy') and  PCPEDI.DATA <= to_date('31/10/2023','dd/mm/yyyy')
AND PCPEDC.DATA >= to_date('01/10/2023','dd/mm/yyyy') and  PCPEDC.DATA <= to_date('31/10/2023','dd/mm/yyyy')


AND PCPEDI.NUMPED = PCPEDC.NUMPED
AND  PCPEDC.CODSUPERVISOR  = PCSUPERV.CODSUPERVISOR
AND PCPEDI.CODPROD = PCPRODUT.CODPROD
AND PCPEDI.CODPROD in  (112687, 112632, 112634)
AND PCPRODUT.CODEPTO = PCDEPTO.CODEPTO
AND  PCPEDC.CODUSUR  = PCUSUARI.CODUSUR
AND PCPEDC.CODCLI = PCCLIENT.CODCLI
AND PCPEDC.CODPRACA = PCPRACA.CODPRACA
AND PCPEDC.DTCANCEL IS NULL
AND PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC
AND PCFORNEC.CODFORNEC in (2946)
AND PCPEDC.CODFILIAL IN ('2')
AND PCPEDC.CONDVENDA NOT IN (4,8,10,13,20,98,99)

GROUP BY  PCPEDC.CODSUPERVISOR 

, PCPEDC.CODUSUR
, PCPEDC.CODFILIAL
, PCFORNEC.codfornec
, PCPRODUT.CODPROD
, PCPEDC.CODGERENTE



) tab1
GROUP BY
tab1.codfornec
, tab1.CODGERENTE  
, tab1.CODSUPERVISOR 
, tab1.CODUSUR
, tab1.fill_1