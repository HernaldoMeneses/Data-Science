SELECT TOTAL.CODUSUR,                               
       PCUSUARI.NOME NOMERCA,                       
       TOTAL.CODSUPERVISOR,                         
       PCSUPERV.NOME NOMESUP,                       
       SUM(TOTAL.VLRECEBER) VLRECEBER,              
       SUM(TOTAL.QTTITRECEBER) QTTITRECEBER,        
       SUM(TOTAL.VLTITULOS) VLTITULOS,              
       SUM(TOTAL.QTTITULOS) QTTITULOS,              
       SUM(TOTAL.DIASATRASO) MEDIAATRASO            
  FROM (                                            
( SELECT PCUSUARI.CODSUPERVISOR                                            
,SUM(PCPREST.VALOR) VLPREVISTO                                                 
,0 VLRECEBDIA                                                                  
,0 VLRECEBATR                                                                  
,0 VLINADIMP                                                                   
    ,PCUSUARI.CODUSUR                                                        
       ,SUM(DECODE(PCPREST.DTPAG,                                            
                  NULL,                                                      
                  CASE                                                       
                    WHEN DTVENC <= to_date((TRUNC(SYSDATE) - 1),'dd/mm/yyyy') THEN     
                     PCPREST.VALOR                                           
                    ELSE                                                     
                     0                                                       
                  END,                                                       
                  0)) VLRECEBER                                              
       ,SUM(DECODE(PCPREST.DTPAG,                                            
                  NULL,                                                      
                  CASE                                                       
                    WHEN DTVENC <= to_date((TRUNC(SYSDATE) - 1),'dd/mm/yyyy') THEN     
                     1                                                       
                    ELSE                                                     
                     0                                                       
                  END,                                                       
                  0)) QTTITRECEBER                                           
       ,SUM(PCPREST.VALOR) VLTITULOS                                         
,ROUND(SUM(CASE WHEN (PCPREST.DTPAG > PCPREST.DTVENC)                       
                  THEN PCPREST.DTPAG - PCPREST.DTVENC                       
                ELSE 0                                                      
           END) / ((SELECT DECODE(COUNT(*), 0, 1, (COUNT(*)))  FROM PCPREST 
                        WHERE PCPREST.CODUSUR = PCUSUARI.CODUSUR            
                        AND PCPREST.DTVENC BETWEEN :DTINI AND :DTFIM        
   AND PCPREST.CODCOB NOT IN ('DEVP', 'DEVT', 'BNF', 'BNFT', 'BNFR', 'BNTR',
                             'BNRP', 'CRED', 'DESD')                  
   AND PCPREST.DTPAG > PCPREST.DTVENC )),2) DIASATRASO
       ,COUNT(*) QTTITULOS                                                  
FROM PCPREST, PCCLIENT, PCUSUARI, PCCOB, PCNFSAID,                              
     (SELECT VALOR,                                                                                                                
        CODFILIAL                                                                                                                  
 FROM PCPARAMFILIAL                                                                                                                
 WHERE NOME = 'FIL_USADIAUTILFILIAL') DIAUTIL                                                                                    
 WHERE PCPREST.CODCLI = PCCLIENT.CODCLI                                        
AND PCPREST.CODUSUR = PCUSUARI.CODUSUR                                         
AND PCPREST.CODFILIAL = DIAUTIL.CODFILIAL                                     
AND PCPREST.NUMTRANSVENDA = PCNFSAID.NUMTRANSVENDA(+)                          
AND PCPREST.CODCOB = PCCOB.CODCOB                                              
AND PCPREST.CODCOB NOT IN ('DEVP', 'DEVT', 'BNF', 'BNFT',              
                           'BNFR', 'BNTR', 'BNRP', 'CRED','DESD')    
 AND    PCPREST.DTVENC BETWEEN :DTINI AND LEAST( TRUNC(SYSDATE)-1, :DTFIM) 
 AND CASE WHEN (DIAUTIL.VALOR) ='S' THEN                                     
    --F_QTDIASVENCIDOS(PCPREST.DTVENC,TRUNC(NVL(:DATAREF,SYSDATE)),PCPREST.CODCOB,PCPREST.CODFILIAL,DIAUTIL.VALOR)
    F_QTDIASVENCIDOS(PCPREST.DTVENC,TRUNC((SYSDATE)),PCPREST.CODCOB,PCPREST.CODFILIAL,DIAUTIL.VALOR)    
 ELSE  
    TRUNC((SYSDATE))-PCPREST.DTVENC END > 0                              
 AND PCPREST.CODFILIAL IN('2') 
                   
--AND PCUSUARI.CODUSUR=:CODUSUR                                                                            
--AND PCUSUARI.CODUSUR= 5     
                                                                       
GROUP BY PCUSUARI.CODSUPERVISOR                                             
, PCUSUARI.CODUSUR                                                          
)                                                                              
) TOTAL, PCUSUARI, PCSUPERV                         
 WHERE TOTAL.CODUSUR = PCUSUARI.CODUSUR             
   AND TOTAL.CODSUPERVISOR = PCSUPERV.CODSUPERVISOR 
GROUP BY TOTAL.CODSUPERVISOR, TOTAL.CODUSUR,        
          PCSUPERV.NOME, PCUSUARI.NOME              
ORDER BY TOTAL.CODSUPERVISOR, TOTAL.CODUSUR