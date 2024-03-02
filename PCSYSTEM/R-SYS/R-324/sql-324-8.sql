SELECT  
--PCPEDC.CODSUPERVISOR CODSUPERVISOR, PCPEDC.CODGERENTE, PCPEDC.POSICAO,PCPEDC.DATA,PCPEDC.CODUSUR,PCPEDC.CODFILIAL, PCPRODUT.CODEPTO, 
PCFORNEC.codfornec, 
--PCPEDC.CODCLI,
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

            SUM((PCPEDI.qt)*NVL(PCPEDI.vlcustofin,0)) as CustoFin
                                                                                                     
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
and PCPEDC.DATA >= to_date('01/11/2023','dd/mm/yyyy') AND PCPEDC.DATA <= to_date('30/11/2023','dd/mm/yyyy')
and PCPEDI.DATA >= to_date('01/11/2023','dd/mm/yyyy') AND PCPEDI.DATA <= to_date('30/11/2023','dd/mm/yyyy')
--AND (PCPEDI.DATA BETWEEN '01/11/2023' AND '30/11/2023')


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
--AND PCPRODUT.CODFORNEC = 4
AND PCPEDC.CODFILIAL IN ('2')
AND PCPEDC.CONDVENDA NOT IN (4,8,10,13,20,98,99)

GROUP BY  PCFORNEC.codfornec
ORDER BY PCFORNEC.codfornec