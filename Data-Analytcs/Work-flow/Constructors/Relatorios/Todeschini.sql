
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

--, PCPEDC.POSICAO
--,PCPEDC.DATA
,PCPEDC.CODUSUR
,MAX(PCPEDC.CODCLI) AS CODCLI
--,PCPEDC.CODFILIAL
--, PCPRODUT.CODEPTO
,PCPRODUT.CODPROD
--Utilizei decode para susbstituir os codprod especiais por um só codigo = 10
--Depois com Count pra contar quantas vezes ocorre
--, Count(DECODE(PCPRODUT.CODPROD, 112687, 10, 112632, 10, 112634,10, PCPRODUT.CODPROD)) as FILL3
, DECODE(PCPRODUT.CODPROD, 112687, 1, 112632, 1, 112634,1, 0) As FILL_1
/***
, Case when PCPRODUT.CODPROD not in (112687,112632,112634)
       then 1 else 0 end fill_1 

, Case when PCPRODUT.CODPROD in (112687,112632,112634)
       then 1 else 0 end fill_2
***/



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
/***
--SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') IN ('S','F') THEN NVL(PCPEDI.QT, 0) ELSE 0 END,5,NVL(PCPEDI.QT,0),6,NVL(PCPEDI.QT, 0),11,NVL(PCPEDI.QT, 0),12,NVL(PCPEDI.QT, 0),0)) QTBNF,
--COUNT(DISTINCT PCCLIENT.CODCLI) AS QTCLIENTE,

--SUM( NVL(PCPEDI.QT,0) * NVL(PCPRODUT.PESOBRUTO,0) ) AS PESO,
--COUNT(DISTINCT(PCPEDC.NUMPED)) AS QTPED 
       
     SUM(DECODE(PCPEDC.CONDVENDA,                                                                                                        
                  5,                                                                                                                       
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  DECODE(NVL(PCPEDI.PBONIFIC, 0),                                                                                          
                         0,                                                                                                                
                         PCPEDI.PTABELA,                                                                                                   
                         PCPEDI.PBONIFIC),                                                                                                 
                  6,                                                                                                                       
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  DECODE(NVL(PCPEDI.PBONIFIC, 0),                                                                                          
                         0,                                                                                                                
                         PCPEDI.PTABELA,                                                                                                   
                         PCPEDI.PBONIFIC),                                                                                                 
                  1,                                                                                                                       
                  CASE                                                                                                                     
                    WHEN NVL(PCPEDI.BONIFIC, 'N') <> 'N' THEN                                                                          
                     NVL(PCPEDI.QT, 0) *                                                                                                   
                     DECODE(NVL(PCPEDI.PBONIFIC, 0), 0, PCPEDI.PTABELA, PCPEDI.PBONIFIC)                                                   
                    ELSE                                                                                                                   
                     0                                                                                                                     
                  END,                                                                                                                     
                  11,                                                                                                                      
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  DECODE(NVL(PCPEDI.PBONIFIC, 0),                                                                                          
                         0,                                                                                                                
                         PCPEDI.PTABELA,                                                                                                   
                         PCPEDI.PBONIFIC),                                                                                                 
                  12,                                                                                                                      
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  DECODE(NVL(PBONIFIC, 0),                                                                                                 
                         0,                                                                                                                
                         PCPEDI.PTABELA,                                                                                                   
                         PCPEDI.PBONIFIC),                                                                                                 
                  0)) VLBONIFIC     
           ***/                                                                                                       
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

--AND TO_CHAR(PCPEDC.DATA , 'YYYY') >= TO_CHAR(ADD_MONTHS(SYSDATE, -1), 'YYYY')
--AND TO_CHAR(PCPEDI.DATA , 'YYYY') >= TO_CHAR(ADD_MONTHS(SYSDATE, -1), 'YYYY')

AND PCPEDI.NUMPED = PCPEDC.NUMPED
AND  PCPEDC.CODSUPERVISOR  = PCSUPERV.CODSUPERVISOR
AND PCPEDI.CODPROD = PCPRODUT.CODPROD
AND PCPEDI.CODPROD in  (112692, 112687, 112632, 112634)
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
--, PCPEDC.POSICAO
--, PCPEDC.DATA
, PCPEDC.CODUSUR
, PCPEDC.CODFILIAL
--, PCPRODUT.CODEPTO
, PCFORNEC.codfornec
, PCPRODUT.CODPROD
--, PCPEDC.CODCLI
, PCPEDC.CODGERENTE


) tab1
GROUP BY
tab1.codfornec
--, tab1.DATA
, tab1.CODGERENTE  
, tab1.CODSUPERVISOR 
, tab1.CODUSUR
, tab1.fill_1