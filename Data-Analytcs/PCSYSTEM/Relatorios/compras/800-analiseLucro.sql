select LIneBY_bP1.codfornec, 
--LIneBY_bP1.qt,  LIneBY_bP1.pLU324,  LIneBY_bP1.qtbnf,  
--LIneBY_bP2.qt,  LIneBY_bP2.pLU324,  LIneBY_bP2.qtbnf,  
--LIneBY_bP3.qt,  LIneBY_bP3.pLU324,  LIneBY_bP3.qtbnf,  
--LIneBY_bP4.qt,  LIneBY_bP4.pLU324,  LIneBY_bP4.qtbnf  

LIneBY_bP1.pLU324,
LIneBY_bP2.pLU324,
LIneBY_bP3.pLU324, 
LIneBY_bP4.pLU324,
LIneBY_bP5.pLU324,
LIneBY_bP6.pLU324,
LIneBY_bP7.pLU324,
LIneBY_bP8.pLU324,
LIneBY_bP9.pLU324,
LIneBY_bP10.pLU324,
LIneBY_bP11.pLU324,
LIneBY_bP12.pLU324,
LIneBY_bP13.pLU324

--LIneBY_bP2.*, LIneBY_bP3.* 
from (

select LineBy_b1.codfornec, 
LineBy_b1.qt,
--LineBy_b1.vlvenda,
--round((LineBy_b1.vlcustofin-LineBy_b1.Cust_BONIFIC),2) as CustoFin_venda,
--case when LineBy_b1.vlvenda > 0 then round((LineBy_b1.vlvenda - (LineBy_b1.vlcustofin-LineBy_b1.Cust_BONIFIC) )/LineBy_b1.vlvenda*100,2) else 0 end "%LU",
case when LineBy_b1.vlvenda > 0 then round((LineBy_b1.vlvenda - (LineBy_b1.vlcustofin) )/LineBy_b1.vlvenda*100,2) else 0 end pLU324,


LineBy_b1.qtbnf
--LineBy_b1.vlbonific,
--case when LineBy_b1.vlbonific > 0 then round((LineBy_b1.vlbonific - LineBy_b1.Cust_BONIFIC )/LineBy_b1.vlbonific*100,2) else 0 end "%LB",


--LineBy_b1.Cust_BONIFIC,

--round(LineBy_b1.vlcustofin,2) as vlcustofin
/*_LineBy_b1.**/ from (
SELECT  
--PCPEDC.CODGERENTE, PCPEDC.CODUSUR, 
--PCPEDC.CODSUPERVISOR,
PCFORNEC.codfornec,
--PCPEDC.POSICAO,PCPEDC.DATA,PCPEDC.CODFILIAL, PCPRODUT.CODEPTO, PCPRODUT.CODPROD, PCPEDC.CODCLI,

   SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') <> 'N' THEN 0 ELSE NVL(PCPEDI.QT, 0) END,5,0,6,0,11,0,12,0,
NVL(PCPEDI.QT,0))) QT,
       SUM(CASE                                                                                                                            
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
 


 
 /*_LineBy_01_ 
 
COUNT(DISTINCT PCCLIENT.CODCLI) AS QTCLIENTE,
SUM( NVL(PCPEDI.QT,0) * NVL(PCPRODUT.PESOBRUTO,0) ) AS PESO,
COUNT(DISTINCT(PCPEDC.NUMPED)) AS QTPED, 

_LineBy_01_*/

        SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') IN ('S','F') THEN NVL(PCPEDI.QT, 0) ELSE 0 END,5,NVL(PCPEDI.QT,0),6,NVL(PCPEDI.QT, 0),11,NVL(PCPEDI.QT, 0),12,NVL(PCPEDI.QT, 0),0)) QTBNF,
 
 
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
                  0)) VLBONIFIC,   
                  
                  
                   
                    
                    
                    
                    SUM(DECODE(PCPEDC.CONDVENDA,                                                                                                        
                  5,                                                                                                                       
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  6,                                                                                                                       
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  1,                                                                                                                       
                  CASE                                                                                                                     
                    WHEN NVL(PCPEDI.BONIFIC, 'N') <> 'N' THEN                                                                          
                     NVL(PCPEDI.QT, 0) *                                                                                                   
                     NVL(PCPEDI.vlcustofin,0)                                                 
                    ELSE                                                                                                                   
                     0                                                                                                                     
                  END,                                                                                                                     
                  11,                                                                                                                      
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  12,                                                                                                                      
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  0)) Cust_BONIFIC,
                  
                  
                   SUM((PCPEDI.qt)*NVL(PCPEDI.vlcustofin,0)) AS VLCUSTOFIN
                    
                    
                                                                                                                           
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
--H.Meneses
--AND PCPEDC.DATA >= to_date('01/01/2023','dd/mm/yyyy') 
--AND PCPEDC.DATA <= to_date('31/12/2023','dd/mm/yyyy')

--AND PCPEDI.DATA >= to_date('01/01/2023','dd/mm/yyyy') 
--AND PCPEDI.DATA <= to_date('31/12/2023','dd/mm/yyyy')


--H.Meneses
AND PCPEDC.DATA >= to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 0) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy') 
--AND PCPEDC.DATA <= to_date(last_day(to_date((SELECT ADD_MONTHS(TO_DATE('2023-01-01', 'YYYY-MM-DD'), 0) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy')),'dd/mm/yyyy')

AND PCPEDI.DATA >= to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 0) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy') 
--AND PCPEDI.DATA <=  to_date(last_day(to_date((SELECT ADD_MONTHS(TO_DATE('2023-01-01', 'YYYY-MM-DD'), 0) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy')),'dd/mm/yyyy')


--H.Meneses
--AND PCPEDC.DATA >= to_date((SELECT ADD_MONTHS(TO_DATE('2023-01-01', 'YYYY-MM-DD'), 11) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy') 
AND PCPEDC.DATA <= to_date(last_day(to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 11) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy')),'dd/mm/yyyy')

--AND PCPEDI.DATA >= to_date((SELECT ADD_MONTHS(TO_DATE('2023-01-01', 'YYYY-MM-DD'), 11) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy') 
AND PCPEDI.DATA <=  to_date(last_day(to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 11) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy')),'dd/mm/yyyy')



AND PCPEDI.NUMPED = PCPEDC.NUMPED
AND  PCPEDC.CODSUPERVISOR  = PCSUPERV.CODSUPERVISOR
AND PCPEDI.CODPROD = PCPRODUT.CODPROD
AND PCPRODUT.CODEPTO = PCDEPTO.CODEPTO
AND  PCPEDC.CODUSUR  = PCUSUARI.CODUSUR
AND PCPEDC.CODCLI = PCCLIENT.CODCLI
AND PCPEDC.CODPRACA = PCPRACA.CODPRACA
AND PCPEDC.DTCANCEL IS NULL
AND PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC
AND PCPEDC.CODFILIAL IN ('2')
AND PCPEDC.CONDVENDA NOT IN (4,8,10,13,20,98,99)

GROUP BY 
 
--PCPEDC.CODGERENTE, 
--PCPEDC.CODSUPERVISOR,
--PCPEDC.CODUSUR, 
PCFORNEC.codfornec
) LineBy_b1 ) LIneBY_bP1 


left join (

    select LineBy_b1.codfornec, 
LineBy_b1.qt,
--LineBy_b1.vlvenda,
--round((LineBy_b1.vlcustofin-LineBy_b1.Cust_BONIFIC),2) as CustoFin_venda,
--case when LineBy_b1.vlvenda > 0 then round((LineBy_b1.vlvenda - (LineBy_b1.vlcustofin-LineBy_b1.Cust_BONIFIC) )/LineBy_b1.vlvenda*100,2) else 0 end "%LU",
case when LineBy_b1.vlvenda > 0 then round((LineBy_b1.vlvenda - (LineBy_b1.vlcustofin) )/LineBy_b1.vlvenda*100,2) else 0 end pLU324,


LineBy_b1.qtbnf
--LineBy_b1.vlbonific,
--case when LineBy_b1.vlbonific > 0 then round((LineBy_b1.vlbonific - LineBy_b1.Cust_BONIFIC )/LineBy_b1.vlbonific*100,2) else 0 end "%LB",


--LineBy_b1.Cust_BONIFIC,

--round(LineBy_b1.vlcustofin,2) as vlcustofin
/*_LineBy_b1.**/ from (
SELECT  
--PCPEDC.CODGERENTE, PCPEDC.CODUSUR, 
--PCPEDC.CODSUPERVISOR,
PCFORNEC.codfornec,
--PCPEDC.POSICAO,PCPEDC.DATA,PCPEDC.CODFILIAL, PCPRODUT.CODEPTO, PCPRODUT.CODPROD, PCPEDC.CODCLI,

   SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') <> 'N' THEN 0 ELSE NVL(PCPEDI.QT, 0) END,5,0,6,0,11,0,12,0,
NVL(PCPEDI.QT,0))) QT,
       SUM(CASE                                                                                                                            
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
 


 
 /*_LineBy_01_ 
 
COUNT(DISTINCT PCCLIENT.CODCLI) AS QTCLIENTE,
SUM( NVL(PCPEDI.QT,0) * NVL(PCPRODUT.PESOBRUTO,0) ) AS PESO,
COUNT(DISTINCT(PCPEDC.NUMPED)) AS QTPED, 

_LineBy_01_*/

        SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') IN ('S','F') THEN NVL(PCPEDI.QT, 0) ELSE 0 END,5,NVL(PCPEDI.QT,0),6,NVL(PCPEDI.QT, 0),11,NVL(PCPEDI.QT, 0),12,NVL(PCPEDI.QT, 0),0)) QTBNF,
 
 
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
                  0)) VLBONIFIC,   
                  
                  
                   
                    
                    
                    
                    SUM(DECODE(PCPEDC.CONDVENDA,                                                                                                        
                  5,                                                                                                                       
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  6,                                                                                                                       
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  1,                                                                                                                       
                  CASE                                                                                                                     
                    WHEN NVL(PCPEDI.BONIFIC, 'N') <> 'N' THEN                                                                          
                     NVL(PCPEDI.QT, 0) *                                                                                                   
                     NVL(PCPEDI.vlcustofin,0)                                                 
                    ELSE                                                                                                                   
                     0                                                                                                                     
                  END,                                                                                                                     
                  11,                                                                                                                      
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  12,                                                                                                                      
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  0)) Cust_BONIFIC,
                  
                  
                   SUM((PCPEDI.qt)*NVL(PCPEDI.vlcustofin,0)) AS VLCUSTOFIN
                    
                    
                                                                                                                           
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
--H.Meneses
AND PCPEDC.DATA >= to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 0) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy') 
AND PCPEDC.DATA <= to_date(last_day(to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 0) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy')),'dd/mm/yyyy')

AND PCPEDI.DATA >= to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 0) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy') 
AND PCPEDI.DATA <=  to_date(last_day(to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 0) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy')),'dd/mm/yyyy')

AND PCPEDI.NUMPED = PCPEDC.NUMPED
AND  PCPEDC.CODSUPERVISOR  = PCSUPERV.CODSUPERVISOR
AND PCPEDI.CODPROD = PCPRODUT.CODPROD
AND PCPRODUT.CODEPTO = PCDEPTO.CODEPTO
AND  PCPEDC.CODUSUR  = PCUSUARI.CODUSUR
AND PCPEDC.CODCLI = PCCLIENT.CODCLI
AND PCPEDC.CODPRACA = PCPRACA.CODPRACA
AND PCPEDC.DTCANCEL IS NULL
AND PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC
AND PCPEDC.CODFILIAL IN ('2')
AND PCPEDC.CONDVENDA NOT IN (4,8,10,13,20,98,99)

GROUP BY 
 
--PCPEDC.CODGERENTE, 
--PCPEDC.CODSUPERVISOR,
--PCPEDC.CODUSUR, 
PCFORNEC.codfornec
) LineBy_b1 
) LIneBY_bP2 on  LIneBY_bP1.codfornec = LIneBY_bP2.codfornec












left join (

    select LineBy_b1.codfornec, 
LineBy_b1.qt,
--LineBy_b1.vlvenda,
--round((LineBy_b1.vlcustofin-LineBy_b1.Cust_BONIFIC),2) as CustoFin_venda,
--case when LineBy_b1.vlvenda > 0 then round((LineBy_b1.vlvenda - (LineBy_b1.vlcustofin-LineBy_b1.Cust_BONIFIC) )/LineBy_b1.vlvenda*100,2) else 0 end "%LU",
case when LineBy_b1.vlvenda > 0 then round((LineBy_b1.vlvenda - (LineBy_b1.vlcustofin) )/LineBy_b1.vlvenda*100,2) else 0 end pLU324,


LineBy_b1.qtbnf
--LineBy_b1.vlbonific,
--case when LineBy_b1.vlbonific > 0 then round((LineBy_b1.vlbonific - LineBy_b1.Cust_BONIFIC )/LineBy_b1.vlbonific*100,2) else 0 end "%LB",


--LineBy_b1.Cust_BONIFIC,

--round(LineBy_b1.vlcustofin,2) as vlcustofin
/*_LineBy_b1.**/ from (
SELECT  
--PCPEDC.CODGERENTE, PCPEDC.CODUSUR, 
--PCPEDC.CODSUPERVISOR,
PCFORNEC.codfornec,
--PCPEDC.POSICAO,PCPEDC.DATA,PCPEDC.CODFILIAL, PCPRODUT.CODEPTO, PCPRODUT.CODPROD, PCPEDC.CODCLI,

   SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') <> 'N' THEN 0 ELSE NVL(PCPEDI.QT, 0) END,5,0,6,0,11,0,12,0,
NVL(PCPEDI.QT,0))) QT,
       SUM(CASE                                                                                                                            
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
 


 
 /*_LineBy_01_ 
 
COUNT(DISTINCT PCCLIENT.CODCLI) AS QTCLIENTE,
SUM( NVL(PCPEDI.QT,0) * NVL(PCPRODUT.PESOBRUTO,0) ) AS PESO,
COUNT(DISTINCT(PCPEDC.NUMPED)) AS QTPED, 

_LineBy_01_*/

        SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') IN ('S','F') THEN NVL(PCPEDI.QT, 0) ELSE 0 END,5,NVL(PCPEDI.QT,0),6,NVL(PCPEDI.QT, 0),11,NVL(PCPEDI.QT, 0),12,NVL(PCPEDI.QT, 0),0)) QTBNF,
 
 
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
                  0)) VLBONIFIC,   
                  
                  
                   
                    
                    
                    
                    SUM(DECODE(PCPEDC.CONDVENDA,                                                                                                        
                  5,                                                                                                                       
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  6,                                                                                                                       
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  1,                                                                                                                       
                  CASE                                                                                                                     
                    WHEN NVL(PCPEDI.BONIFIC, 'N') <> 'N' THEN                                                                          
                     NVL(PCPEDI.QT, 0) *                                                                                                   
                     NVL(PCPEDI.vlcustofin,0)                                                 
                    ELSE                                                                                                                   
                     0                                                                                                                     
                  END,                                                                                                                     
                  11,                                                                                                                      
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  12,                                                                                                                      
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  0)) Cust_BONIFIC,
                  
                  
                   SUM((PCPEDI.qt)*NVL(PCPEDI.vlcustofin,0)) AS VLCUSTOFIN
                    
                    
                                                                                                                           
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
--H.Meneses
AND PCPEDC.DATA >= to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 1) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy') 
AND PCPEDC.DATA <= to_date(last_day(to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 1) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy')),'dd/mm/yyyy')

AND PCPEDI.DATA >= to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 1) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy') 
AND PCPEDI.DATA <=  to_date(last_day(to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 1) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy')),'dd/mm/yyyy')

AND PCPEDI.NUMPED = PCPEDC.NUMPED
AND  PCPEDC.CODSUPERVISOR  = PCSUPERV.CODSUPERVISOR
AND PCPEDI.CODPROD = PCPRODUT.CODPROD
AND PCPRODUT.CODEPTO = PCDEPTO.CODEPTO
AND  PCPEDC.CODUSUR  = PCUSUARI.CODUSUR
AND PCPEDC.CODCLI = PCCLIENT.CODCLI
AND PCPEDC.CODPRACA = PCPRACA.CODPRACA
AND PCPEDC.DTCANCEL IS NULL
AND PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC
AND PCPEDC.CODFILIAL IN ('2')
AND PCPEDC.CONDVENDA NOT IN (4,8,10,13,20,98,99)

GROUP BY 
 
--PCPEDC.CODGERENTE, 
--PCPEDC.CODSUPERVISOR,
--PCPEDC.CODUSUR, 
PCFORNEC.codfornec
) LineBy_b1 
) LIneBY_bP3 on  LIneBY_bP1.codfornec = LIneBY_bP3.codfornec































left join (

    select LineBy_b1.codfornec, 
LineBy_b1.qt,
--LineBy_b1.vlvenda,
--round((LineBy_b1.vlcustofin-LineBy_b1.Cust_BONIFIC),2) as CustoFin_venda,
--case when LineBy_b1.vlvenda > 0 then round((LineBy_b1.vlvenda - (LineBy_b1.vlcustofin-LineBy_b1.Cust_BONIFIC) )/LineBy_b1.vlvenda*100,2) else 0 end "%LU",
case when LineBy_b1.vlvenda > 0 then round((LineBy_b1.vlvenda - (LineBy_b1.vlcustofin) )/LineBy_b1.vlvenda*100,2) else 0 end pLU324,


LineBy_b1.qtbnf
--LineBy_b1.vlbonific,
--case when LineBy_b1.vlbonific > 0 then round((LineBy_b1.vlbonific - LineBy_b1.Cust_BONIFIC )/LineBy_b1.vlbonific*100,2) else 0 end "%LB",


--LineBy_b1.Cust_BONIFIC,

--round(LineBy_b1.vlcustofin,2) as vlcustofin
/*_LineBy_b1.**/ from (
SELECT  
--PCPEDC.CODGERENTE, PCPEDC.CODUSUR, 
--PCPEDC.CODSUPERVISOR,
PCFORNEC.codfornec,
--PCPEDC.POSICAO,PCPEDC.DATA,PCPEDC.CODFILIAL, PCPRODUT.CODEPTO, PCPRODUT.CODPROD, PCPEDC.CODCLI,

   SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') <> 'N' THEN 0 ELSE NVL(PCPEDI.QT, 0) END,5,0,6,0,11,0,12,0,
NVL(PCPEDI.QT,0))) QT,
       SUM(CASE                                                                                                                            
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
 


 
 /*_LineBy_01_ 
 
COUNT(DISTINCT PCCLIENT.CODCLI) AS QTCLIENTE,
SUM( NVL(PCPEDI.QT,0) * NVL(PCPRODUT.PESOBRUTO,0) ) AS PESO,
COUNT(DISTINCT(PCPEDC.NUMPED)) AS QTPED, 

_LineBy_01_*/

        SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') IN ('S','F') THEN NVL(PCPEDI.QT, 0) ELSE 0 END,5,NVL(PCPEDI.QT,0),6,NVL(PCPEDI.QT, 0),11,NVL(PCPEDI.QT, 0),12,NVL(PCPEDI.QT, 0),0)) QTBNF,
 
 
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
                  0)) VLBONIFIC,   
                  
                  
                   
                    
                    
                    
                    SUM(DECODE(PCPEDC.CONDVENDA,                                                                                                        
                  5,                                                                                                                       
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  6,                                                                                                                       
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  1,                                                                                                                       
                  CASE                                                                                                                     
                    WHEN NVL(PCPEDI.BONIFIC, 'N') <> 'N' THEN                                                                          
                     NVL(PCPEDI.QT, 0) *                                                                                                   
                     NVL(PCPEDI.vlcustofin,0)                                                 
                    ELSE                                                                                                                   
                     0                                                                                                                     
                  END,                                                                                                                     
                  11,                                                                                                                      
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  12,                                                                                                                      
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  0)) Cust_BONIFIC,
                  
                  
                   SUM((PCPEDI.qt)*NVL(PCPEDI.vlcustofin,0)) AS VLCUSTOFIN
                    
                    
                                                                                                                           
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
--H.Meneses
AND PCPEDC.DATA >= to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 2) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy') 
AND PCPEDC.DATA <= to_date(last_day(to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 2) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy')),'dd/mm/yyyy')

AND PCPEDI.DATA >= to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 2) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy') 
AND PCPEDI.DATA <=  to_date(last_day(to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 2) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy')),'dd/mm/yyyy')

AND PCPEDI.NUMPED = PCPEDC.NUMPED
AND  PCPEDC.CODSUPERVISOR  = PCSUPERV.CODSUPERVISOR
AND PCPEDI.CODPROD = PCPRODUT.CODPROD
AND PCPRODUT.CODEPTO = PCDEPTO.CODEPTO
AND  PCPEDC.CODUSUR  = PCUSUARI.CODUSUR
AND PCPEDC.CODCLI = PCCLIENT.CODCLI
AND PCPEDC.CODPRACA = PCPRACA.CODPRACA
AND PCPEDC.DTCANCEL IS NULL
AND PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC
AND PCPEDC.CODFILIAL IN ('2')
AND PCPEDC.CONDVENDA NOT IN (4,8,10,13,20,98,99)

GROUP BY 
 
--PCPEDC.CODGERENTE, 
--PCPEDC.CODSUPERVISOR,
--PCPEDC.CODUSUR, 
PCFORNEC.codfornec
) LineBy_b1 
) LIneBY_bP4 on  LIneBY_bP1.codfornec = LIneBY_bP4.codfornec































left join (

    select LineBy_b1.codfornec, 
LineBy_b1.qt,
--LineBy_b1.vlvenda,
--round((LineBy_b1.vlcustofin-LineBy_b1.Cust_BONIFIC),2) as CustoFin_venda,
--case when LineBy_b1.vlvenda > 0 then round((LineBy_b1.vlvenda - (LineBy_b1.vlcustofin-LineBy_b1.Cust_BONIFIC) )/LineBy_b1.vlvenda*100,2) else 0 end "%LU",
case when LineBy_b1.vlvenda > 0 then round((LineBy_b1.vlvenda - (LineBy_b1.vlcustofin) )/LineBy_b1.vlvenda*100,2) else 0 end pLU324,


LineBy_b1.qtbnf
--LineBy_b1.vlbonific,
--case when LineBy_b1.vlbonific > 0 then round((LineBy_b1.vlbonific - LineBy_b1.Cust_BONIFIC )/LineBy_b1.vlbonific*100,2) else 0 end "%LB",


--LineBy_b1.Cust_BONIFIC,

--round(LineBy_b1.vlcustofin,2) as vlcustofin
/*_LineBy_b1.**/ from (
SELECT  
--PCPEDC.CODGERENTE, PCPEDC.CODUSUR, 
--PCPEDC.CODSUPERVISOR,
PCFORNEC.codfornec,
--PCPEDC.POSICAO,PCPEDC.DATA,PCPEDC.CODFILIAL, PCPRODUT.CODEPTO, PCPRODUT.CODPROD, PCPEDC.CODCLI,

   SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') <> 'N' THEN 0 ELSE NVL(PCPEDI.QT, 0) END,5,0,6,0,11,0,12,0,
NVL(PCPEDI.QT,0))) QT,
       SUM(CASE                                                                                                                            
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
 


 
 /*_LineBy_01_ 
 
COUNT(DISTINCT PCCLIENT.CODCLI) AS QTCLIENTE,
SUM( NVL(PCPEDI.QT,0) * NVL(PCPRODUT.PESOBRUTO,0) ) AS PESO,
COUNT(DISTINCT(PCPEDC.NUMPED)) AS QTPED, 

_LineBy_01_*/

        SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') IN ('S','F') THEN NVL(PCPEDI.QT, 0) ELSE 0 END,5,NVL(PCPEDI.QT,0),6,NVL(PCPEDI.QT, 0),11,NVL(PCPEDI.QT, 0),12,NVL(PCPEDI.QT, 0),0)) QTBNF,
 
 
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
                  0)) VLBONIFIC,   
                  
                  
                   
                    
                    
                    
                    SUM(DECODE(PCPEDC.CONDVENDA,                                                                                                        
                  5,                                                                                                                       
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  6,                                                                                                                       
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  1,                                                                                                                       
                  CASE                                                                                                                     
                    WHEN NVL(PCPEDI.BONIFIC, 'N') <> 'N' THEN                                                                          
                     NVL(PCPEDI.QT, 0) *                                                                                                   
                     NVL(PCPEDI.vlcustofin,0)                                                 
                    ELSE                                                                                                                   
                     0                                                                                                                     
                  END,                                                                                                                     
                  11,                                                                                                                      
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  12,                                                                                                                      
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  0)) Cust_BONIFIC,
                  
                  
                   SUM((PCPEDI.qt)*NVL(PCPEDI.vlcustofin,0)) AS VLCUSTOFIN
                    
                    
                                                                                                                           
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
--H.Meneses
AND PCPEDC.DATA >= to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 3) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy') 
AND PCPEDC.DATA <= to_date(last_day(to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 3) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy')),'dd/mm/yyyy')

AND PCPEDI.DATA >= to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 3) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy') 
AND PCPEDI.DATA <=  to_date(last_day(to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 3) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy')),'dd/mm/yyyy')

AND PCPEDI.NUMPED = PCPEDC.NUMPED
AND  PCPEDC.CODSUPERVISOR  = PCSUPERV.CODSUPERVISOR
AND PCPEDI.CODPROD = PCPRODUT.CODPROD
AND PCPRODUT.CODEPTO = PCDEPTO.CODEPTO
AND  PCPEDC.CODUSUR  = PCUSUARI.CODUSUR
AND PCPEDC.CODCLI = PCCLIENT.CODCLI
AND PCPEDC.CODPRACA = PCPRACA.CODPRACA
AND PCPEDC.DTCANCEL IS NULL
AND PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC
AND PCPEDC.CODFILIAL IN ('2')
AND PCPEDC.CONDVENDA NOT IN (4,8,10,13,20,98,99)

GROUP BY 
 
--PCPEDC.CODGERENTE, 
--PCPEDC.CODSUPERVISOR,
--PCPEDC.CODUSUR, 
PCFORNEC.codfornec
) LineBy_b1 
) LIneBY_bP5 on  LIneBY_bP1.codfornec = LIneBY_bP5.codfornec































left join (

    select LineBy_b1.codfornec, 
LineBy_b1.qt,
--LineBy_b1.vlvenda,
--round((LineBy_b1.vlcustofin-LineBy_b1.Cust_BONIFIC),2) as CustoFin_venda,
--case when LineBy_b1.vlvenda > 0 then round((LineBy_b1.vlvenda - (LineBy_b1.vlcustofin-LineBy_b1.Cust_BONIFIC) )/LineBy_b1.vlvenda*100,2) else 0 end "%LU",
case when LineBy_b1.vlvenda > 0 then round((LineBy_b1.vlvenda - (LineBy_b1.vlcustofin) )/LineBy_b1.vlvenda*100,2) else 0 end pLU324,


LineBy_b1.qtbnf
--LineBy_b1.vlbonific,
--case when LineBy_b1.vlbonific > 0 then round((LineBy_b1.vlbonific - LineBy_b1.Cust_BONIFIC )/LineBy_b1.vlbonific*100,2) else 0 end "%LB",


--LineBy_b1.Cust_BONIFIC,

--round(LineBy_b1.vlcustofin,2) as vlcustofin
/*_LineBy_b1.**/ from (
SELECT  
--PCPEDC.CODGERENTE, PCPEDC.CODUSUR, 
--PCPEDC.CODSUPERVISOR,
PCFORNEC.codfornec,
--PCPEDC.POSICAO,PCPEDC.DATA,PCPEDC.CODFILIAL, PCPRODUT.CODEPTO, PCPRODUT.CODPROD, PCPEDC.CODCLI,

   SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') <> 'N' THEN 0 ELSE NVL(PCPEDI.QT, 0) END,5,0,6,0,11,0,12,0,
NVL(PCPEDI.QT,0))) QT,
       SUM(CASE                                                                                                                            
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
 


 
 /*_LineBy_01_ 
 
COUNT(DISTINCT PCCLIENT.CODCLI) AS QTCLIENTE,
SUM( NVL(PCPEDI.QT,0) * NVL(PCPRODUT.PESOBRUTO,0) ) AS PESO,
COUNT(DISTINCT(PCPEDC.NUMPED)) AS QTPED, 

_LineBy_01_*/

        SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') IN ('S','F') THEN NVL(PCPEDI.QT, 0) ELSE 0 END,5,NVL(PCPEDI.QT,0),6,NVL(PCPEDI.QT, 0),11,NVL(PCPEDI.QT, 0),12,NVL(PCPEDI.QT, 0),0)) QTBNF,
 
 
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
                  0)) VLBONIFIC,   
                  
                  
                   
                    
                    
                    
                    SUM(DECODE(PCPEDC.CONDVENDA,                                                                                                        
                  5,                                                                                                                       
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  6,                                                                                                                       
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  1,                                                                                                                       
                  CASE                                                                                                                     
                    WHEN NVL(PCPEDI.BONIFIC, 'N') <> 'N' THEN                                                                          
                     NVL(PCPEDI.QT, 0) *                                                                                                   
                     NVL(PCPEDI.vlcustofin,0)                                                 
                    ELSE                                                                                                                   
                     0                                                                                                                     
                  END,                                                                                                                     
                  11,                                                                                                                      
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  12,                                                                                                                      
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  0)) Cust_BONIFIC,
                  
                  
                   SUM((PCPEDI.qt)*NVL(PCPEDI.vlcustofin,0)) AS VLCUSTOFIN
                    
                    
                                                                                                                           
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
--H.Meneses
AND PCPEDC.DATA >= to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 4) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy') 
AND PCPEDC.DATA <= to_date(last_day(to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 4) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy')),'dd/mm/yyyy')

AND PCPEDI.DATA >= to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 4) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy') 
AND PCPEDI.DATA <=  to_date(last_day(to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 4) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy')),'dd/mm/yyyy')

AND PCPEDI.NUMPED = PCPEDC.NUMPED
AND  PCPEDC.CODSUPERVISOR  = PCSUPERV.CODSUPERVISOR
AND PCPEDI.CODPROD = PCPRODUT.CODPROD
AND PCPRODUT.CODEPTO = PCDEPTO.CODEPTO
AND  PCPEDC.CODUSUR  = PCUSUARI.CODUSUR
AND PCPEDC.CODCLI = PCCLIENT.CODCLI
AND PCPEDC.CODPRACA = PCPRACA.CODPRACA
AND PCPEDC.DTCANCEL IS NULL
AND PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC
AND PCPEDC.CODFILIAL IN ('2')
AND PCPEDC.CONDVENDA NOT IN (4,8,10,13,20,98,99)

GROUP BY 
 
--PCPEDC.CODGERENTE, 
--PCPEDC.CODSUPERVISOR,
--PCPEDC.CODUSUR, 
PCFORNEC.codfornec
) LineBy_b1 
) LIneBY_bP6 on  LIneBY_bP1.codfornec = LIneBY_bP6.codfornec






























left join (

    select LineBy_b1.codfornec, 
LineBy_b1.qt,
--LineBy_b1.vlvenda,
--round((LineBy_b1.vlcustofin-LineBy_b1.Cust_BONIFIC),2) as CustoFin_venda,
--case when LineBy_b1.vlvenda > 0 then round((LineBy_b1.vlvenda - (LineBy_b1.vlcustofin-LineBy_b1.Cust_BONIFIC) )/LineBy_b1.vlvenda*100,2) else 0 end "%LU",
case when LineBy_b1.vlvenda > 0 then round((LineBy_b1.vlvenda - (LineBy_b1.vlcustofin) )/LineBy_b1.vlvenda*100,2) else 0 end pLU324,


LineBy_b1.qtbnf
--LineBy_b1.vlbonific,
--case when LineBy_b1.vlbonific > 0 then round((LineBy_b1.vlbonific - LineBy_b1.Cust_BONIFIC )/LineBy_b1.vlbonific*100,2) else 0 end "%LB",


--LineBy_b1.Cust_BONIFIC,

--round(LineBy_b1.vlcustofin,2) as vlcustofin
/*_LineBy_b1.**/ from (
SELECT  
--PCPEDC.CODGERENTE, PCPEDC.CODUSUR, 
--PCPEDC.CODSUPERVISOR,
PCFORNEC.codfornec,
--PCPEDC.POSICAO,PCPEDC.DATA,PCPEDC.CODFILIAL, PCPRODUT.CODEPTO, PCPRODUT.CODPROD, PCPEDC.CODCLI,

   SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') <> 'N' THEN 0 ELSE NVL(PCPEDI.QT, 0) END,5,0,6,0,11,0,12,0,
NVL(PCPEDI.QT,0))) QT,
       SUM(CASE                                                                                                                            
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
 


 
 /*_LineBy_01_ 
 
COUNT(DISTINCT PCCLIENT.CODCLI) AS QTCLIENTE,
SUM( NVL(PCPEDI.QT,0) * NVL(PCPRODUT.PESOBRUTO,0) ) AS PESO,
COUNT(DISTINCT(PCPEDC.NUMPED)) AS QTPED, 

_LineBy_01_*/

        SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') IN ('S','F') THEN NVL(PCPEDI.QT, 0) ELSE 0 END,5,NVL(PCPEDI.QT,0),6,NVL(PCPEDI.QT, 0),11,NVL(PCPEDI.QT, 0),12,NVL(PCPEDI.QT, 0),0)) QTBNF,
 
 
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
                  0)) VLBONIFIC,   
                  
                  
                   
                    
                    
                    
                    SUM(DECODE(PCPEDC.CONDVENDA,                                                                                                        
                  5,                                                                                                                       
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  6,                                                                                                                       
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  1,                                                                                                                       
                  CASE                                                                                                                     
                    WHEN NVL(PCPEDI.BONIFIC, 'N') <> 'N' THEN                                                                          
                     NVL(PCPEDI.QT, 0) *                                                                                                   
                     NVL(PCPEDI.vlcustofin,0)                                                 
                    ELSE                                                                                                                   
                     0                                                                                                                     
                  END,                                                                                                                     
                  11,                                                                                                                      
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  12,                                                                                                                      
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  0)) Cust_BONIFIC,
                  
                  
                   SUM((PCPEDI.qt)*NVL(PCPEDI.vlcustofin,0)) AS VLCUSTOFIN
                    
                    
                                                                                                                           
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
--H.Meneses
AND PCPEDC.DATA >= to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 5) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy') 
AND PCPEDC.DATA <= to_date(last_day(to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 5) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy')),'dd/mm/yyyy')

AND PCPEDI.DATA >= to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 5) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy') 
AND PCPEDI.DATA <=  to_date(last_day(to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 5) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy')),'dd/mm/yyyy')

AND PCPEDI.NUMPED = PCPEDC.NUMPED
AND  PCPEDC.CODSUPERVISOR  = PCSUPERV.CODSUPERVISOR
AND PCPEDI.CODPROD = PCPRODUT.CODPROD
AND PCPRODUT.CODEPTO = PCDEPTO.CODEPTO
AND  PCPEDC.CODUSUR  = PCUSUARI.CODUSUR
AND PCPEDC.CODCLI = PCCLIENT.CODCLI
AND PCPEDC.CODPRACA = PCPRACA.CODPRACA
AND PCPEDC.DTCANCEL IS NULL
AND PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC
AND PCPEDC.CODFILIAL IN ('2')
AND PCPEDC.CONDVENDA NOT IN (4,8,10,13,20,98,99)

GROUP BY 
 
--PCPEDC.CODGERENTE, 
--PCPEDC.CODSUPERVISOR,
--PCPEDC.CODUSUR, 
PCFORNEC.codfornec
) LineBy_b1 
) LIneBY_bP7 on  LIneBY_bP1.codfornec = LIneBY_bP7.codfornec







left join (

    select LineBy_b1.codfornec, 
LineBy_b1.qt,
--LineBy_b1.vlvenda,
--round((LineBy_b1.vlcustofin-LineBy_b1.Cust_BONIFIC),2) as CustoFin_venda,
--case when LineBy_b1.vlvenda > 0 then round((LineBy_b1.vlvenda - (LineBy_b1.vlcustofin-LineBy_b1.Cust_BONIFIC) )/LineBy_b1.vlvenda*100,2) else 0 end "%LU",
case when LineBy_b1.vlvenda > 0 then round((LineBy_b1.vlvenda - (LineBy_b1.vlcustofin) )/LineBy_b1.vlvenda*100,2) else 0 end pLU324,


LineBy_b1.qtbnf
--LineBy_b1.vlbonific,
--case when LineBy_b1.vlbonific > 0 then round((LineBy_b1.vlbonific - LineBy_b1.Cust_BONIFIC )/LineBy_b1.vlbonific*100,2) else 0 end "%LB",


--LineBy_b1.Cust_BONIFIC,

--round(LineBy_b1.vlcustofin,2) as vlcustofin
/*_LineBy_b1.**/ from (
SELECT  
--PCPEDC.CODGERENTE, PCPEDC.CODUSUR, 
--PCPEDC.CODSUPERVISOR,
PCFORNEC.codfornec,
--PCPEDC.POSICAO,PCPEDC.DATA,PCPEDC.CODFILIAL, PCPRODUT.CODEPTO, PCPRODUT.CODPROD, PCPEDC.CODCLI,

   SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') <> 'N' THEN 0 ELSE NVL(PCPEDI.QT, 0) END,5,0,6,0,11,0,12,0,
NVL(PCPEDI.QT,0))) QT,
       SUM(CASE                                                                                                                            
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
 


 
 /*_LineBy_01_ 
 
COUNT(DISTINCT PCCLIENT.CODCLI) AS QTCLIENTE,
SUM( NVL(PCPEDI.QT,0) * NVL(PCPRODUT.PESOBRUTO,0) ) AS PESO,
COUNT(DISTINCT(PCPEDC.NUMPED)) AS QTPED, 

_LineBy_01_*/

        SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') IN ('S','F') THEN NVL(PCPEDI.QT, 0) ELSE 0 END,5,NVL(PCPEDI.QT,0),6,NVL(PCPEDI.QT, 0),11,NVL(PCPEDI.QT, 0),12,NVL(PCPEDI.QT, 0),0)) QTBNF,
 
 
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
                  0)) VLBONIFIC,   
                  
                  
                   
                    
                    
                    
                    SUM(DECODE(PCPEDC.CONDVENDA,                                                                                                        
                  5,                                                                                                                       
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  6,                                                                                                                       
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  1,                                                                                                                       
                  CASE                                                                                                                     
                    WHEN NVL(PCPEDI.BONIFIC, 'N') <> 'N' THEN                                                                          
                     NVL(PCPEDI.QT, 0) *                                                                                                   
                     NVL(PCPEDI.vlcustofin,0)                                                 
                    ELSE                                                                                                                   
                     0                                                                                                                     
                  END,                                                                                                                     
                  11,                                                                                                                      
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  12,                                                                                                                      
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  0)) Cust_BONIFIC,
                  
                  
                   SUM((PCPEDI.qt)*NVL(PCPEDI.vlcustofin,0)) AS VLCUSTOFIN
                    
                    
                                                                                                                           
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
--H.Meneses
AND PCPEDC.DATA >= to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 6) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy') 
AND PCPEDC.DATA <= to_date(last_day(to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 6) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy')),'dd/mm/yyyy')

AND PCPEDI.DATA >= to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 6) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy') 
AND PCPEDI.DATA <=  to_date(last_day(to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 6) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy')),'dd/mm/yyyy')

AND PCPEDI.NUMPED = PCPEDC.NUMPED
AND  PCPEDC.CODSUPERVISOR  = PCSUPERV.CODSUPERVISOR
AND PCPEDI.CODPROD = PCPRODUT.CODPROD
AND PCPRODUT.CODEPTO = PCDEPTO.CODEPTO
AND  PCPEDC.CODUSUR  = PCUSUARI.CODUSUR
AND PCPEDC.CODCLI = PCCLIENT.CODCLI
AND PCPEDC.CODPRACA = PCPRACA.CODPRACA
AND PCPEDC.DTCANCEL IS NULL
AND PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC
AND PCPEDC.CODFILIAL IN ('2')
AND PCPEDC.CONDVENDA NOT IN (4,8,10,13,20,98,99)

GROUP BY 
 
--PCPEDC.CODGERENTE, 
--PCPEDC.CODSUPERVISOR,
--PCPEDC.CODUSUR, 
PCFORNEC.codfornec
) LineBy_b1 
) LIneBY_bP8 on  LIneBY_bP1.codfornec = LIneBY_bP8.codfornec






















left join (

    select LineBy_b1.codfornec, 
LineBy_b1.qt,
--LineBy_b1.vlvenda,
--round((LineBy_b1.vlcustofin-LineBy_b1.Cust_BONIFIC),2) as CustoFin_venda,
--case when LineBy_b1.vlvenda > 0 then round((LineBy_b1.vlvenda - (LineBy_b1.vlcustofin-LineBy_b1.Cust_BONIFIC) )/LineBy_b1.vlvenda*100,2) else 0 end "%LU",
case when LineBy_b1.vlvenda > 0 then round((LineBy_b1.vlvenda - (LineBy_b1.vlcustofin) )/LineBy_b1.vlvenda*100,2) else 0 end pLU324,


LineBy_b1.qtbnf
--LineBy_b1.vlbonific,
--case when LineBy_b1.vlbonific > 0 then round((LineBy_b1.vlbonific - LineBy_b1.Cust_BONIFIC )/LineBy_b1.vlbonific*100,2) else 0 end "%LB",


--LineBy_b1.Cust_BONIFIC,

--round(LineBy_b1.vlcustofin,2) as vlcustofin
/*_LineBy_b1.**/ from (
SELECT  
--PCPEDC.CODGERENTE, PCPEDC.CODUSUR, 
--PCPEDC.CODSUPERVISOR,
PCFORNEC.codfornec,
--PCPEDC.POSICAO,PCPEDC.DATA,PCPEDC.CODFILIAL, PCPRODUT.CODEPTO, PCPRODUT.CODPROD, PCPEDC.CODCLI,

   SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') <> 'N' THEN 0 ELSE NVL(PCPEDI.QT, 0) END,5,0,6,0,11,0,12,0,
NVL(PCPEDI.QT,0))) QT,
       SUM(CASE                                                                                                                            
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
 


 
 /*_LineBy_01_ 
 
COUNT(DISTINCT PCCLIENT.CODCLI) AS QTCLIENTE,
SUM( NVL(PCPEDI.QT,0) * NVL(PCPRODUT.PESOBRUTO,0) ) AS PESO,
COUNT(DISTINCT(PCPEDC.NUMPED)) AS QTPED, 

_LineBy_01_*/

        SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') IN ('S','F') THEN NVL(PCPEDI.QT, 0) ELSE 0 END,5,NVL(PCPEDI.QT,0),6,NVL(PCPEDI.QT, 0),11,NVL(PCPEDI.QT, 0),12,NVL(PCPEDI.QT, 0),0)) QTBNF,
 
 
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
                  0)) VLBONIFIC,   
                  
                  
                   
                    
                    
                    
                    SUM(DECODE(PCPEDC.CONDVENDA,                                                                                                        
                  5,                                                                                                                       
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  6,                                                                                                                       
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  1,                                                                                                                       
                  CASE                                                                                                                     
                    WHEN NVL(PCPEDI.BONIFIC, 'N') <> 'N' THEN                                                                          
                     NVL(PCPEDI.QT, 0) *                                                                                                   
                     NVL(PCPEDI.vlcustofin,0)                                                 
                    ELSE                                                                                                                   
                     0                                                                                                                     
                  END,                                                                                                                     
                  11,                                                                                                                      
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  12,                                                                                                                      
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  0)) Cust_BONIFIC,
                  
                  
                   SUM((PCPEDI.qt)*NVL(PCPEDI.vlcustofin,0)) AS VLCUSTOFIN
                    
                    
                                                                                                                           
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
--H.Meneses
AND PCPEDC.DATA >= to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 7) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy') 
AND PCPEDC.DATA <= to_date(last_day(to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 7) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy')),'dd/mm/yyyy')

AND PCPEDI.DATA >= to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 7) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy') 
AND PCPEDI.DATA <=  to_date(last_day(to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 7) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy')),'dd/mm/yyyy')

AND PCPEDI.NUMPED = PCPEDC.NUMPED
AND  PCPEDC.CODSUPERVISOR  = PCSUPERV.CODSUPERVISOR
AND PCPEDI.CODPROD = PCPRODUT.CODPROD
AND PCPRODUT.CODEPTO = PCDEPTO.CODEPTO
AND  PCPEDC.CODUSUR  = PCUSUARI.CODUSUR
AND PCPEDC.CODCLI = PCCLIENT.CODCLI
AND PCPEDC.CODPRACA = PCPRACA.CODPRACA
AND PCPEDC.DTCANCEL IS NULL
AND PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC
AND PCPEDC.CODFILIAL IN ('2')
AND PCPEDC.CONDVENDA NOT IN (4,8,10,13,20,98,99)

GROUP BY 
 
--PCPEDC.CODGERENTE, 
--PCPEDC.CODSUPERVISOR,
--PCPEDC.CODUSUR, 
PCFORNEC.codfornec
) LineBy_b1 
) LIneBY_bP9 on  LIneBY_bP1.codfornec = LIneBY_bP9.codfornec
















































left join (

    select LineBy_b1.codfornec, 
LineBy_b1.qt,
--LineBy_b1.vlvenda,
--round((LineBy_b1.vlcustofin-LineBy_b1.Cust_BONIFIC),2) as CustoFin_venda,
--case when LineBy_b1.vlvenda > 0 then round((LineBy_b1.vlvenda - (LineBy_b1.vlcustofin-LineBy_b1.Cust_BONIFIC) )/LineBy_b1.vlvenda*100,2) else 0 end "%LU",
case when LineBy_b1.vlvenda > 0 then round((LineBy_b1.vlvenda - (LineBy_b1.vlcustofin) )/LineBy_b1.vlvenda*100,2) else 0 end pLU324,


LineBy_b1.qtbnf
--LineBy_b1.vlbonific,
--case when LineBy_b1.vlbonific > 0 then round((LineBy_b1.vlbonific - LineBy_b1.Cust_BONIFIC )/LineBy_b1.vlbonific*100,2) else 0 end "%LB",


--LineBy_b1.Cust_BONIFIC,

--round(LineBy_b1.vlcustofin,2) as vlcustofin
/*_LineBy_b1.**/ from (
SELECT  
--PCPEDC.CODGERENTE, PCPEDC.CODUSUR, 
--PCPEDC.CODSUPERVISOR,
PCFORNEC.codfornec,
--PCPEDC.POSICAO,PCPEDC.DATA,PCPEDC.CODFILIAL, PCPRODUT.CODEPTO, PCPRODUT.CODPROD, PCPEDC.CODCLI,

   SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') <> 'N' THEN 0 ELSE NVL(PCPEDI.QT, 0) END,5,0,6,0,11,0,12,0,
NVL(PCPEDI.QT,0))) QT,
       SUM(CASE                                                                                                                            
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
 


 
 /*_LineBy_01_ 
 
COUNT(DISTINCT PCCLIENT.CODCLI) AS QTCLIENTE,
SUM( NVL(PCPEDI.QT,0) * NVL(PCPRODUT.PESOBRUTO,0) ) AS PESO,
COUNT(DISTINCT(PCPEDC.NUMPED)) AS QTPED, 

_LineBy_01_*/

        SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') IN ('S','F') THEN NVL(PCPEDI.QT, 0) ELSE 0 END,5,NVL(PCPEDI.QT,0),6,NVL(PCPEDI.QT, 0),11,NVL(PCPEDI.QT, 0),12,NVL(PCPEDI.QT, 0),0)) QTBNF,
 
 
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
                  0)) VLBONIFIC,   
                  
                  
                   
                    
                    
                    
                    SUM(DECODE(PCPEDC.CONDVENDA,                                                                                                        
                  5,                                                                                                                       
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  6,                                                                                                                       
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  1,                                                                                                                       
                  CASE                                                                                                                     
                    WHEN NVL(PCPEDI.BONIFIC, 'N') <> 'N' THEN                                                                          
                     NVL(PCPEDI.QT, 0) *                                                                                                   
                     NVL(PCPEDI.vlcustofin,0)                                                 
                    ELSE                                                                                                                   
                     0                                                                                                                     
                  END,                                                                                                                     
                  11,                                                                                                                      
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  12,                                                                                                                      
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  0)) Cust_BONIFIC,
                  
                  
                   SUM((PCPEDI.qt)*NVL(PCPEDI.vlcustofin,0)) AS VLCUSTOFIN
                    
                    
                                                                                                                           
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
--H.Meneses
AND PCPEDC.DATA >= to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 8) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy') 
AND PCPEDC.DATA <= to_date(last_day(to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 8) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy')),'dd/mm/yyyy')

AND PCPEDI.DATA >= to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 8) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy') 
AND PCPEDI.DATA <=  to_date(last_day(to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 8) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy')),'dd/mm/yyyy')

AND PCPEDI.NUMPED = PCPEDC.NUMPED
AND  PCPEDC.CODSUPERVISOR  = PCSUPERV.CODSUPERVISOR
AND PCPEDI.CODPROD = PCPRODUT.CODPROD
AND PCPRODUT.CODEPTO = PCDEPTO.CODEPTO
AND  PCPEDC.CODUSUR  = PCUSUARI.CODUSUR
AND PCPEDC.CODCLI = PCCLIENT.CODCLI
AND PCPEDC.CODPRACA = PCPRACA.CODPRACA
AND PCPEDC.DTCANCEL IS NULL
AND PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC
AND PCPEDC.CODFILIAL IN ('2')
AND PCPEDC.CONDVENDA NOT IN (4,8,10,13,20,98,99)

GROUP BY 
 
--PCPEDC.CODGERENTE, 
--PCPEDC.CODSUPERVISOR,
--PCPEDC.CODUSUR, 
PCFORNEC.codfornec
) LineBy_b1 
) LIneBY_bP10 on  LIneBY_bP1.codfornec = LIneBY_bP10.codfornec







































left join (

    select LineBy_b1.codfornec, 
LineBy_b1.qt,
--LineBy_b1.vlvenda,
--round((LineBy_b1.vlcustofin-LineBy_b1.Cust_BONIFIC),2) as CustoFin_venda,
--case when LineBy_b1.vlvenda > 0 then round((LineBy_b1.vlvenda - (LineBy_b1.vlcustofin-LineBy_b1.Cust_BONIFIC) )/LineBy_b1.vlvenda*100,2) else 0 end "%LU",
case when LineBy_b1.vlvenda > 0 then round((LineBy_b1.vlvenda - (LineBy_b1.vlcustofin) )/LineBy_b1.vlvenda*100,2) else 0 end pLU324,


LineBy_b1.qtbnf
--LineBy_b1.vlbonific,
--case when LineBy_b1.vlbonific > 0 then round((LineBy_b1.vlbonific - LineBy_b1.Cust_BONIFIC )/LineBy_b1.vlbonific*100,2) else 0 end "%LB",


--LineBy_b1.Cust_BONIFIC,

--round(LineBy_b1.vlcustofin,2) as vlcustofin
/*_LineBy_b1.**/ from (
SELECT  
--PCPEDC.CODGERENTE, PCPEDC.CODUSUR, 
--PCPEDC.CODSUPERVISOR,
PCFORNEC.codfornec,
--PCPEDC.POSICAO,PCPEDC.DATA,PCPEDC.CODFILIAL, PCPRODUT.CODEPTO, PCPRODUT.CODPROD, PCPEDC.CODCLI,

   SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') <> 'N' THEN 0 ELSE NVL(PCPEDI.QT, 0) END,5,0,6,0,11,0,12,0,
NVL(PCPEDI.QT,0))) QT,
       SUM(CASE                                                                                                                            
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
 


 
 /*_LineBy_01_ 
 
COUNT(DISTINCT PCCLIENT.CODCLI) AS QTCLIENTE,
SUM( NVL(PCPEDI.QT,0) * NVL(PCPRODUT.PESOBRUTO,0) ) AS PESO,
COUNT(DISTINCT(PCPEDC.NUMPED)) AS QTPED, 

_LineBy_01_*/

        SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') IN ('S','F') THEN NVL(PCPEDI.QT, 0) ELSE 0 END,5,NVL(PCPEDI.QT,0),6,NVL(PCPEDI.QT, 0),11,NVL(PCPEDI.QT, 0),12,NVL(PCPEDI.QT, 0),0)) QTBNF,
 
 
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
                  0)) VLBONIFIC,   
                  
                  
                   
                    
                    
                    
                    SUM(DECODE(PCPEDC.CONDVENDA,                                                                                                        
                  5,                                                                                                                       
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  6,                                                                                                                       
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  1,                                                                                                                       
                  CASE                                                                                                                     
                    WHEN NVL(PCPEDI.BONIFIC, 'N') <> 'N' THEN                                                                          
                     NVL(PCPEDI.QT, 0) *                                                                                                   
                     NVL(PCPEDI.vlcustofin,0)                                                 
                    ELSE                                                                                                                   
                     0                                                                                                                     
                  END,                                                                                                                     
                  11,                                                                                                                      
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  12,                                                                                                                      
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  0)) Cust_BONIFIC,
                  
                  
                   SUM((PCPEDI.qt)*NVL(PCPEDI.vlcustofin,0)) AS VLCUSTOFIN
                    
                    
                                                                                                                           
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
--H.Meneses
AND PCPEDC.DATA >= to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 9) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy') 
AND PCPEDC.DATA <= to_date(last_day(to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 9) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy')),'dd/mm/yyyy')

AND PCPEDI.DATA >= to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 9) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy') 
AND PCPEDI.DATA <=  to_date(last_day(to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 9) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy')),'dd/mm/yyyy')

AND PCPEDI.NUMPED = PCPEDC.NUMPED
AND  PCPEDC.CODSUPERVISOR  = PCSUPERV.CODSUPERVISOR
AND PCPEDI.CODPROD = PCPRODUT.CODPROD
AND PCPRODUT.CODEPTO = PCDEPTO.CODEPTO
AND  PCPEDC.CODUSUR  = PCUSUARI.CODUSUR
AND PCPEDC.CODCLI = PCCLIENT.CODCLI
AND PCPEDC.CODPRACA = PCPRACA.CODPRACA
AND PCPEDC.DTCANCEL IS NULL
AND PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC
AND PCPEDC.CODFILIAL IN ('2')
AND PCPEDC.CONDVENDA NOT IN (4,8,10,13,20,98,99)

GROUP BY 
 
--PCPEDC.CODGERENTE, 
--PCPEDC.CODSUPERVISOR,
--PCPEDC.CODUSUR, 
PCFORNEC.codfornec
) LineBy_b1 
) LIneBY_bP11 on  LIneBY_bP1.codfornec = LIneBY_bP11.codfornec














































left join (

    select LineBy_b1.codfornec, 
LineBy_b1.qt,
--LineBy_b1.vlvenda,
--round((LineBy_b1.vlcustofin-LineBy_b1.Cust_BONIFIC),2) as CustoFin_venda,
--case when LineBy_b1.vlvenda > 0 then round((LineBy_b1.vlvenda - (LineBy_b1.vlcustofin-LineBy_b1.Cust_BONIFIC) )/LineBy_b1.vlvenda*100,2) else 0 end "%LU",
case when LineBy_b1.vlvenda > 0 then round((LineBy_b1.vlvenda - (LineBy_b1.vlcustofin) )/LineBy_b1.vlvenda*100,2) else 0 end pLU324,


LineBy_b1.qtbnf
--LineBy_b1.vlbonific,
--case when LineBy_b1.vlbonific > 0 then round((LineBy_b1.vlbonific - LineBy_b1.Cust_BONIFIC )/LineBy_b1.vlbonific*100,2) else 0 end "%LB",


--LineBy_b1.Cust_BONIFIC,

--round(LineBy_b1.vlcustofin,2) as vlcustofin
/*_LineBy_b1.**/ from (
SELECT  
--PCPEDC.CODGERENTE, PCPEDC.CODUSUR, 
--PCPEDC.CODSUPERVISOR,
PCFORNEC.codfornec,
--PCPEDC.POSICAO,PCPEDC.DATA,PCPEDC.CODFILIAL, PCPRODUT.CODEPTO, PCPRODUT.CODPROD, PCPEDC.CODCLI,

   SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') <> 'N' THEN 0 ELSE NVL(PCPEDI.QT, 0) END,5,0,6,0,11,0,12,0,
NVL(PCPEDI.QT,0))) QT,
       SUM(CASE                                                                                                                            
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
 


 
 /*_LineBy_01_ 
 
COUNT(DISTINCT PCCLIENT.CODCLI) AS QTCLIENTE,
SUM( NVL(PCPEDI.QT,0) * NVL(PCPRODUT.PESOBRUTO,0) ) AS PESO,
COUNT(DISTINCT(PCPEDC.NUMPED)) AS QTPED, 

_LineBy_01_*/

        SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') IN ('S','F') THEN NVL(PCPEDI.QT, 0) ELSE 0 END,5,NVL(PCPEDI.QT,0),6,NVL(PCPEDI.QT, 0),11,NVL(PCPEDI.QT, 0),12,NVL(PCPEDI.QT, 0),0)) QTBNF,
 
 
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
                  0)) VLBONIFIC,   
                  
                  
                   
                    
                    
                    
                    SUM(DECODE(PCPEDC.CONDVENDA,                                                                                                        
                  5,                                                                                                                       
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  6,                                                                                                                       
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  1,                                                                                                                       
                  CASE                                                                                                                     
                    WHEN NVL(PCPEDI.BONIFIC, 'N') <> 'N' THEN                                                                          
                     NVL(PCPEDI.QT, 0) *                                                                                                   
                     NVL(PCPEDI.vlcustofin,0)                                                 
                    ELSE                                                                                                                   
                     0                                                                                                                     
                  END,                                                                                                                     
                  11,                                                                                                                      
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  12,                                                                                                                      
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  0)) Cust_BONIFIC,
                  
                  
                   SUM((PCPEDI.qt)*NVL(PCPEDI.vlcustofin,0)) AS VLCUSTOFIN
                    
                    
                                                                                                                           
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
--H.Meneses
AND PCPEDC.DATA >= to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 10) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy') 
AND PCPEDC.DATA <= to_date(last_day(to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 10) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy')),'dd/mm/yyyy')

AND PCPEDI.DATA >= to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 10) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy') 
AND PCPEDI.DATA <=  to_date(last_day(to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 10) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy')),'dd/mm/yyyy')

AND PCPEDI.NUMPED = PCPEDC.NUMPED
AND  PCPEDC.CODSUPERVISOR  = PCSUPERV.CODSUPERVISOR
AND PCPEDI.CODPROD = PCPRODUT.CODPROD
AND PCPRODUT.CODEPTO = PCDEPTO.CODEPTO
AND  PCPEDC.CODUSUR  = PCUSUARI.CODUSUR
AND PCPEDC.CODCLI = PCCLIENT.CODCLI
AND PCPEDC.CODPRACA = PCPRACA.CODPRACA
AND PCPEDC.DTCANCEL IS NULL
AND PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC
AND PCPEDC.CODFILIAL IN ('2')
AND PCPEDC.CONDVENDA NOT IN (4,8,10,13,20,98,99)

GROUP BY 
 
--PCPEDC.CODGERENTE, 
--PCPEDC.CODSUPERVISOR,
--PCPEDC.CODUSUR, 
PCFORNEC.codfornec
) LineBy_b1 
) LIneBY_bP12 on  LIneBY_bP1.codfornec = LIneBY_bP12.codfornec










































left join (

    select LineBy_b1.codfornec, 
LineBy_b1.qt,
--LineBy_b1.vlvenda,
--round((LineBy_b1.vlcustofin-LineBy_b1.Cust_BONIFIC),2) as CustoFin_venda,
--case when LineBy_b1.vlvenda > 0 then round((LineBy_b1.vlvenda - (LineBy_b1.vlcustofin-LineBy_b1.Cust_BONIFIC) )/LineBy_b1.vlvenda*100,2) else 0 end "%LU",
case when LineBy_b1.vlvenda > 0 then round((LineBy_b1.vlvenda - (LineBy_b1.vlcustofin) )/LineBy_b1.vlvenda*100,2) else 0 end pLU324,


LineBy_b1.qtbnf
--LineBy_b1.vlbonific,
--case when LineBy_b1.vlbonific > 0 then round((LineBy_b1.vlbonific - LineBy_b1.Cust_BONIFIC )/LineBy_b1.vlbonific*100,2) else 0 end "%LB",


--LineBy_b1.Cust_BONIFIC,

--round(LineBy_b1.vlcustofin,2) as vlcustofin
/*_LineBy_b1.**/ from (
SELECT  
--PCPEDC.CODGERENTE, PCPEDC.CODUSUR, 
--PCPEDC.CODSUPERVISOR,
PCFORNEC.codfornec,
--PCPEDC.POSICAO,PCPEDC.DATA,PCPEDC.CODFILIAL, PCPRODUT.CODEPTO, PCPRODUT.CODPROD, PCPEDC.CODCLI,

   SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') <> 'N' THEN 0 ELSE NVL(PCPEDI.QT, 0) END,5,0,6,0,11,0,12,0,
NVL(PCPEDI.QT,0))) QT,
       SUM(CASE                                                                                                                            
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
 


 
 /*_LineBy_01_ 
 
COUNT(DISTINCT PCCLIENT.CODCLI) AS QTCLIENTE,
SUM( NVL(PCPEDI.QT,0) * NVL(PCPRODUT.PESOBRUTO,0) ) AS PESO,
COUNT(DISTINCT(PCPEDC.NUMPED)) AS QTPED, 

_LineBy_01_*/

        SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') IN ('S','F') THEN NVL(PCPEDI.QT, 0) ELSE 0 END,5,NVL(PCPEDI.QT,0),6,NVL(PCPEDI.QT, 0),11,NVL(PCPEDI.QT, 0),12,NVL(PCPEDI.QT, 0),0)) QTBNF,
 
 
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
                  0)) VLBONIFIC,   
                  
                  
                   
                    
                    
                    
                    SUM(DECODE(PCPEDC.CONDVENDA,                                                                                                        
                  5,                                                                                                                       
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  6,                                                                                                                       
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  1,                                                                                                                       
                  CASE                                                                                                                     
                    WHEN NVL(PCPEDI.BONIFIC, 'N') <> 'N' THEN                                                                          
                     NVL(PCPEDI.QT, 0) *                                                                                                   
                     NVL(PCPEDI.vlcustofin,0)                                                 
                    ELSE                                                                                                                   
                     0                                                                                                                     
                  END,                                                                                                                     
                  11,                                                                                                                      
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  12,                                                                                                                      
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  NVL(PCPEDI.vlcustofin,0),                                                                                                 
                  0)) Cust_BONIFIC,
                  
                  
                   SUM((PCPEDI.qt)*NVL(PCPEDI.vlcustofin,0)) AS VLCUSTOFIN
                    
                    
                                                                                                                           
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
--H.Meneses
AND PCPEDC.DATA >= to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 11) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy') 
AND PCPEDC.DATA <= to_date(last_day(to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 11) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy')),'dd/mm/yyyy')

AND PCPEDI.DATA >= to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 11) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy') 
AND PCPEDI.DATA <=  to_date(last_day(to_date((SELECT ADD_MONTHS(TO_DATE(:data_init, 'dd/mm/yyyy'), 11) AS data_com_um_mes_a_mais FROM dual),'dd/mm/yyyy')),'dd/mm/yyyy')

AND PCPEDI.NUMPED = PCPEDC.NUMPED
AND  PCPEDC.CODSUPERVISOR  = PCSUPERV.CODSUPERVISOR
AND PCPEDI.CODPROD = PCPRODUT.CODPROD
AND PCPRODUT.CODEPTO = PCDEPTO.CODEPTO
AND  PCPEDC.CODUSUR  = PCUSUARI.CODUSUR
AND PCPEDC.CODCLI = PCCLIENT.CODCLI
AND PCPEDC.CODPRACA = PCPRACA.CODPRACA
AND PCPEDC.DTCANCEL IS NULL
AND PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC
AND PCPEDC.CODFILIAL IN ('2')
AND PCPEDC.CONDVENDA NOT IN (4,8,10,13,20,98,99)

GROUP BY 
 
--PCPEDC.CODGERENTE, 
--PCPEDC.CODSUPERVISOR,
--PCPEDC.CODUSUR, 
PCFORNEC.codfornec
) LineBy_b1 
) LIneBY_bP13 on  LIneBY_bP1.codfornec = LIneBY_bP13.codfornec
