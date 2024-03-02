SELECT 
PCPEDC.DATA
,PCPEDC.CODFILIAL
, PCFORNEC.codfornec 

, PCPEDC.CODGERENTE
, PCPEDC.CODSUPERVISOR CODSUPERVISOR
--, PCPEDC.POSICAO
,PCPEDC.CODUSUR
--, PCPEDC.CODCLI
--, PCPRODUT.CODEPTO

--, Max(PCPRODUT.CODPROD)
,case when count(distinct(PCPRODUT.CODPROD))> 1 then 1 else 0 end Post_c
, pcpedc.numnota
--, PCPEDC.CODCLI

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
NVL(PCPEDI.QT,0))) QT,
/**
SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') IN ('S','F') THEN NVL(PCPEDI.QT, 0) ELSE 0 END,5,NVL(PCPEDI.QT,
 0),6,NVL(PCPEDI.QT, 0),11,NVL(PCPEDI.QT, 0),12,NVL(PCPEDI.QT, 0),0)) QTBNF,
**/
--COUNT(DISTINCT PCCLIENT.CODCLI) AS QTCLIENTE,
--SUM( NVL(PCPEDI.QT,0) * NVL(PCPRODUT.PESOBRUTO,0) ) AS PESO,
COUNT(DISTINCT(PCPEDC.NUMPED)) AS QTPED 
    /**
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
    **/                                                                                                           
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
and PCPEDC.DATA >= to_date('01/09/2023','dd/mm/yyyy') and PCPEDC.DATA <= to_date('31/10/2023','dd/mm/yyyy') 
and PCPEDI.DATA >= to_date('01/09/2023','dd/mm/yyyy') and PCPEDI.DATA <= to_date('31/10/2023','dd/mm/yyyy') 
--AND (PCPEDI.DATA BETWEEN '01/01/2023' AND '31/08/2023')


--AND TO_CHAR(PCPEDC.DATA , 'YYYY') >= TO_CHAR(ADD_MONTHS(SYSDATE, -24), 'YYYY')
--AND TO_CHAR(PCPEDI.DATA , 'YYYY') >= TO_CHAR(ADD_MONTHS(SYSDATE, -24), 'YYYY')

AND PCPEDI.NUMPED = PCPEDC.NUMPED
AND  PCPEDC.CODSUPERVISOR  = PCSUPERV.CODSUPERVISOR
AND PCPEDI.CODPROD = PCPRODUT.CODPROD
AND PCPRODUT.CODEPTO = PCDEPTO.CODEPTO
AND  PCPEDC.CODUSUR  = PCUSUARI.CODUSUR
AND  PCPEDC.CODUSUR  = 426
AND PCPEDC.CODCLI = PCCLIENT.CODCLI
AND PCPEDC.CODPRACA = PCPRACA.CODPRACA
AND PCPEDC.DTCANCEL IS NULL
AND PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC
AND PCPRODUT.CODFORNEC = 3210
AND PCPEDC.CODFILIAL IN ('2')
AND PCPEDC.CONDVENDA NOT IN (4,8,10,13,20,98,99)

GROUP BY 
PCPEDC.DATA
,PCPEDC.CODFILIAL
, PCFORNEC.codfornec 
, PCPEDC.CODSUPERVISOR
, PCPEDC.CODGERENTE
, pcpedc.numnota
, PCPEDC.POSICAO
,PCPEDC.CODUSUR
--, PCPEDC.CODCLI
, PCPEDC.CODCLI
ORDER BY 
PCPEDC.DATA
,PCPEDC.CODFILIAL 
, PCFORNEC.codfornec

, PCPEDC.CODGERENTE
, PCPEDC.CODSUPERVISOR

, PCPEDC.POSICAO
,PCPEDC.CODUSUR

--, PCPRODUT.CODEPTO

--, PCPRODUT.CODPROD
, pcpedc.numnota
, PCPEDC.CODCLI