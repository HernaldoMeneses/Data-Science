select 
fatoDay.*
, fatoMonth.VLVENDA as VLVENDAMES
, fatoMonth.QTCLIENTE as QTCLIENTEMES 

from (

SELECT  
PCPEDC.CODSUPERVISOR
, PCSUPERV.nome
, PCPEDC.CODUSUR
, PCUSUARI.NOME as Vendedor
, PCFORNEC.codfornec
, PCFORNEC.FORNECEDOR



,      SUM(CASE                                                                                                                            
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
                      END) VLVENDA
                                                                                                           
--, SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') <> 'N' THEN 0 ELSE NVL(PCPEDI.QT, 0) END,5,0,6,0,11,0,12,0, NVL(PCPEDI.QT,0))) QT
,COUNT(DISTINCT PCCLIENT.CODCLI) AS QTCLIENTE
--,COUNT(DISTINCT PCPEDC.CODCLI) AS QTCLIENTEPEDC
--, COUNT(DISTINCT(PCPEDC.NUMPED)) AS QTPED
                                                                                                    
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
AND PCPEDC.DATA >= to_date(sysdate,'dd/mm/yyyy') 
AND PCPEDI.DATA >= to_date(sysdate,'dd/mm/yyyy') 
--AND PCPEDC.DATA >= to_date(sysdate,'dd/mm/yyyy') AND PCPEDC.DATA <= to_date('31/12/2023','dd/mm/yyyy')
--AND PCPEDI.DATA >= to_date(sysdate,'dd/mm/yyyy') AND PCPEDI.DATA <= to_date('31/12/2023','dd/mm/yyyy')

AND PCPEDI.NUMPED = PCPEDC.NUMPED
AND  PCPEDC.CODSUPERVISOR  = PCSUPERV.CODSUPERVISOR
AND PCPEDI.CODPROD = PCPRODUT.CODPROD
AND PCPRODUT.CODEPTO = PCDEPTO.CODEPTO
AND  PCPEDC.CODUSUR  = PCUSUARI.CODUSUR
AND PCPEDC.CODCLI = PCCLIENT.CODCLI
AND PCPEDC.CODPRACA = PCPRACA.CODPRACA
AND PCPEDC.DTCANCEL IS NULL
AND PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC
/*
AND PCPRODUT.CODFORNEC in (
3314
,3461
,3642
,3743
,3248
,3570
,3486
,3330
,403
,2993
,3209
,3446
,3468
,3571
,405
,3549
,3592
,1203
,19
,346
,2971
,3356
,975
)
*/
AND PCPEDC.CODFILIAL IN ('2')
AND PCPEDC.CODSUPERVISOR IN (:CodSuperv)

GROUP BY
PCPEDC.CODSUPERVISOR
, PCSUPERV.nome
, PCPEDC.CODUSUR
, PCUSUARI.NOME
, PCFORNEC.codfornec
, PCFORNEC.FORNECEDOR

                      ) fatoDay ,
                            
                            
(
SELECT  
PCPEDC.CODSUPERVISOR
, PCSUPERV.nome
, PCPEDC.CODUSUR
, PCUSUARI.NOME as Vendedor
, PCFORNEC.codfornec
, PCFORNEC.FORNECEDOR



,      SUM(CASE                                                                                                                            
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
                      END) VLVENDA
                                                                                                           
--, SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') <> 'N' THEN 0 ELSE NVL(PCPEDI.QT, 0) END,5,0,6,0,11,0,12,0, NVL(PCPEDI.QT,0))) QT
,COUNT(DISTINCT PCCLIENT.CODCLI) AS QTCLIENTE
--,COUNT(DISTINCT PCPEDC.CODCLI) AS QTCLIENTEPEDC
--, COUNT(DISTINCT(PCPEDC.NUMPED)) AS QTPED
                                                                                                    
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
--AND PCPEDC.DATA >= to_date(sysdate,'dd/mm/yyyy') 
--AND PCPEDI.DATA >= to_date(sysdate,'dd/mm/yyyy') 
AND PCPEDC.DATA >= to_date('01/12/2023','dd/mm/yyyy') AND PCPEDC.DATA <= to_date('31/12/2023','dd/mm/yyyy')
AND PCPEDI.DATA >= to_date('01/12/2023','dd/mm/yyyy') AND PCPEDI.DATA <= to_date('31/12/2023','dd/mm/yyyy')

AND PCPEDI.NUMPED = PCPEDC.NUMPED
AND  PCPEDC.CODSUPERVISOR  = PCSUPERV.CODSUPERVISOR
AND PCPEDI.CODPROD = PCPRODUT.CODPROD
AND PCPRODUT.CODEPTO = PCDEPTO.CODEPTO
AND  PCPEDC.CODUSUR  = PCUSUARI.CODUSUR
AND PCPEDC.CODCLI = PCCLIENT.CODCLI
AND PCPEDC.CODPRACA = PCPRACA.CODPRACA
AND PCPEDC.DTCANCEL IS NULL
AND PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC
/*
AND PCPRODUT.CODFORNEC in (
3314
,3461
,3642
,3743
,3248
,3570
,3486
,3330
,403
,2993
,3209
,3446
,3468
,3571
,405
,3549
,3592
,1203
,19
,346
,2971
,3356
,975
)
*/
AND PCPEDC.CODFILIAL IN ('2')
AND PCPEDC.CODSUPERVISOR IN (:CodSuperv)

GROUP BY
PCPEDC.CODSUPERVISOR
, PCSUPERV.nome
, PCPEDC.CODUSUR
, PCUSUARI.NOME
, PCFORNEC.codfornec
, PCFORNEC.FORNECEDOR


                       )  fatoMonth
    where fatoDay.codsupervisor = fatoMonth.codsupervisor
    and   fatoDay.codusur = fatoMonth.codusur
    and   fatoDay.codfornec = fatoMonth.codfornec