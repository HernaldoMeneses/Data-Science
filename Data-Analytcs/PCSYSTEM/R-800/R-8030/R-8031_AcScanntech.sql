select finaly.* 
,  finaly.meta - finaly.realizado as FAlTA 
, case when finaly.meta> 0 then round(finaly.realizado/finaly.meta*100,2) else 0 end "%"
from (
Select relatorio.CODGERENTE, relatorio.CODSUPERVISOR, relatorio.nome, relatorio.CODCLI, relatorio.cliente,  relatorio.MUNICCOB,

Case    					
when relatorio.CODCLI =  101719 Then 15000 					
when relatorio.CODCLI =  111174 Then 9000 					
when relatorio.CODCLI =  116811 Then 13000 					
when relatorio.CODCLI =  119859 Then 12000 					
when relatorio.CODCLI =  4219 Then 6500 					
when relatorio.CODCLI =  3534 Then 1500 					
when relatorio.CODCLI =  100334 Then 5000 					
when relatorio.CODCLI =  124882 Then 13000 									
when relatorio.CODCLI =  7855 Then 20000 					
when relatorio.CODCLI =  124456 Then 4000 					
when relatorio.CODCLI =  110243 Then 11000 					
when relatorio.CODCLI =  139931 Then 27000 	else 0 end Meta,									


sum(relatorio.VLVENDA) as Realizado
from (
SELECT  PCPEDC.CODSUPERVISOR, PCSUPERV.NOME, PCPEDC.CODGERENTE, PCPEDC.POSICAO,PCPEDC.DATA,PCPEDC.CODUSUR,PCPEDC.CODFILIAL, PCPRODUT.CODEPTO, PCFORNEC.codfornec,PCPRODUT.CODPROD, PCPEDC.CODCLI, PCCLIENT.cliente, PCCLIENT.MUNICCOB,
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
   SUM((PCPEDI.qt)*NVL(PCPEDI.vlcustofin,0)) AS VLCUSTOFIN,
   SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') <> 'N' THEN 0 ELSE NVL(PCPEDI.QT, 0) END,5,0,6,0,11,0,12,0,
NVL(PCPEDI.QT,0))) QT,
SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') IN ('S','F') THEN NVL(PCPEDI.QT, 0) ELSE 0 END,5,NVL(PCPEDI.QT,
 0),6,NVL(PCPEDI.QT, 0),11,NVL(PCPEDI.QT, 0),12,NVL(PCPEDI.QT, 0),0)) QTBNF,
COUNT(DISTINCT PCCLIENT.CODCLI) AS QTCLIENTE,
SUM( NVL(PCPEDI.QT,0) * NVL(PCPRODUT.PESOBRUTO,0) ) AS PESO,
COUNT(DISTINCT(PCPEDC.NUMPED)) AS QTPED, 
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
--AND PCPEDC.DATA >= to_date('11/12/2023','dd/mm/yyyy') AND PCPEDC.DATA <= to_date('31/12/2023','dd/mm/yyyy')
--AND PCPEDI.DATA >= to_date('11/12/2023','dd/mm/yyyy') AND PCPEDI.DATA <= to_date('31/12/2023','dd/mm/yyyy')

AND PCPEDC.DATA >= to_date(:datai,'dd/mm/yyyy') AND PCPEDC.DATA <= to_date(:dataf,'dd/mm/yyyy')
AND PCPEDI.DATA >= to_date(:datai,'dd/mm/yyyy') AND PCPEDI.DATA <= to_date(:dataf,'dd/mm/yyyy')



--AND PCPEDC.DATA >= to_date('01/12/2023','dd/mm/yyyy') AND PCPEDC.DATA <= to_date('31/12/2023','dd/mm/yyyy')
--AND PCPEDI.DATA >= to_date('01/12/2023','dd/mm/yyyy') AND PCPEDI.DATA <= to_date('31/12/2023','dd/mm/yyyy')

--AND PCPEDC.DATA >= to_date('01/11/2023','dd/mm/yyyy') AND PCPEDC.DATA <= to_date('30/11/2023','dd/mm/yyyy')
--AND PCPEDI.DATA >= to_date('01/11/2023','dd/mm/yyyy') AND PCPEDI.DATA <= to_date('30/11/2023','dd/mm/yyyy')

--and(PCPEDC.DATA BETWEEN '01/01/2023' AND '31/08/2023')
--AND (PCPEDI.DATA BETWEEN '01/01/2023' AND '31/08/2023')


--AND TO_CHAR(PCPEDC.DATA , 'YYYY') >= TO_CHAR(ADD_MONTHS(SYSDATE, -24), 'YYYY')
--AND TO_CHAR(PCPEDI.DATA , 'YYYY') >= TO_CHAR(ADD_MONTHS(SYSDATE, -24), 'YYYY')

--AND TO_CHAR(PCPEDC.DATA , 'YYYY') >= TO_CHAR(ADD_MONTHS(SYSDATE, -4), 'YYYY')
--AND TO_CHAR(PCPEDI.DATA , 'YYYY') >= TO_CHAR(ADD_MONTHS(SYSDATE, -4), 'YYYY')

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

GROUP BY  PCPEDC.CODSUPERVISOR , PCSUPERV.NOME, PCPEDC.POSICAO, PCPEDC.DATA, PCPEDC.CODUSUR, PCPEDC.CODFILIAL, PCPRODUT.CODEPTO, PCFORNEC.codfornec, PCPRODUT.CODPROD, PCPEDC.CODCLI, PCCLIENT.cliente, PCPEDC.CODGERENTE, PCCLIENT.MUNICCOB
ORDER BY VLVENDA
) relatorio

where relatorio.codfornec in (1214)
AND   relatorio.CODGERENTE in (:codGER)

Group by  relatorio.CODGERENTE, relatorio.CODSUPERVISOR, relatorio.nome, relatorio.CODCLI, relatorio.cliente, relatorio.MUNICCOB
) finaly
Order by  finaly.meta desc