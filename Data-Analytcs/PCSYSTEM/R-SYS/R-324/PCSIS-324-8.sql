----------------------------------
Timestamp: 08:42:15.164
SELECT COUNT(*) CONTADOR
  FROM PCLIB
 WHERE CODTABELA = 3
   AND CODIGON = 999999
   AND CODFUNC = :CODFUNC
CODFUNC = 1261
----------------------------------
Timestamp: 08:42:15.193
SELECT COUNT(*) CONTADOR
  FROM PCLIB
 WHERE CODTABELA = 3
   AND CODIGON = 999999
   AND CODFUNC = :CODFUNC
CODFUNC = 1261
----------------------------------
Timestamp: 08:42:15.213
SELECT COUNT(*) ACESSO
  FROM PCLIB
 WHERE PCLIB.CODTABELA = 1
   AND PCLIB.CODFUNC = 1261
   AND PCLIB.CODIGOA = '99'
----------------------------------
Timestamp: 08:42:15.230
SELECT
  CODIGO,
  RAZAOSOCIAL
FROM PCFILIAL
 WHERE CODIGO IN  (SELECT PCLIB.CODIGOA    FROM PCLIB  WHERE PCLIB.CODFUNC = 1261    AND PCLIB.CODTABELA = 1 )
 AND TO_CHAR(CODIGO) = :PARAM1
PARAM1 = '2'
----------------------------------
Timestamp: 08:42:16.570
SELECT      SUM(CASE                                                                                                                            
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
      ,ROUND( SUM(DECODE(PCPEDC.CONDVENDA,                                                                                                        
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
                  0)),2) VLBONIFIC                                                                                                           
FROM PCPEDI, PCPEDC, PCSUPERV, PCUSUARI, PCPRODUT,PCFORNEC 

WHERE (PCPEDC.DATA BETWEEN :DATAI AND :DATAF)
AND (PCPEDI.DATA BETWEEN :DATAI AND :DATAF)
AND PCPEDC.DTCANCEL IS NULL
AND PCPEDI.NUMPED = PCPEDC.NUMPED
AND PCSUPERV.CODSUPERVISOR =  PCPEDC.CODSUPERVISOR 
AND PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC 
AND PCUSUARI.CODUSUR = PCPEDC.CODUSUR
AND PCPRODUT.CODPROD = PCPEDI.CODPROD 
AND PCPEDC.CODFILIAL IN ('2')
AND PCPEDC.CONDVENDA NOT IN (4,8,10,13,20,98,99)
 AND PCPEDC.CODFILIAL IN (SELECT PCLIB.CODIGOA
                                  FROM PCLIB
                                 WHERE CODTABELA = 1
                                  AND CODFUNC = 1261)
DATAI = '01/10/2023'
DATAF = '31/10/2023'
----------------------------------
Timestamp: 08:42:16.776
SELECT COUNT(*) CONTADOR
  FROM PCLIB
 WHERE CODTABELA = 3
   AND CODIGON = 999999
   AND CODFUNC = :CODFUNC
CODFUNC = 1261
----------------------------------
Timestamp: 08:42:16.817
SELECT COUNT(*) ACESSO
  FROM PCLIB
 WHERE PCLIB.CODTABELA = 1
   AND PCLIB.CODFUNC = 1261
   AND PCLIB.CODIGOA = '99'
----------------------------------
Timestamp: 08:42:16.843
SELECT
  CODIGO,
  RAZAOSOCIAL
FROM PCFILIAL
 WHERE CODIGO IN  (SELECT PCLIB.CODIGOA    FROM PCLIB  WHERE PCLIB.CODFUNC = 1261    AND PCLIB.CODTABELA = 1 )
 AND TO_CHAR(CODIGO) = :PARAM1
PARAM1 = '2'
----------------------------------
Timestamp: 08:42:16.898
SELECT COUNT(*) CONTADOR
  FROM PCLIB
 WHERE CODTABELA = 3
   AND CODIGON = 999999
   AND CODFUNC = :CODFUNC
CODFUNC = 1261
----------------------------------
Timestamp: 08:42:19.530
SELECT PCPRODUT.CODFORNEC,   
       PCFORNEC.FORNECEDOR, 
       (SELECT  
               COUNT(*) CONT 
          FROM PCPRODUT PT 
         WHERE PT.DTEXCLUSAO IS NULL 
           AND NVL(PT.OBS2, '') <> 'FL' 
           AND PT.CODFORNEC = PCPRODUT.CODFORNEC) ITENSATIVO, 
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
                      END) PVENDA,                                                                                                        
   SUM((PCPEDI.qt)*NVL(PCPEDI.vlcustofin,0)) AS VLCUSTOFIN,
   SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') <> 'N' THEN 0 ELSE NVL(PCPEDI.QT, 0) END,5,0,6,0,11,0,12,0,
NVL(PCPEDI.QT,0))) QT,
SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') = 'S' THEN NVL(PCPEDI.QT, 0) ELSE 0 END,5,NVL(PCPEDI.QT, 0),6,
NVL(PCPEDI.QT, 0),11,NVL(PCPEDI.QT, 0),12,NVL(PCPEDI.QT, 0),0)) QTBNF,
       COUNT(DISTINCT PCCLIENT.CODCLI) AS QTCLIENTE, 
       SUM(NVL(PCPEDI.QT, 0) * NVL(PCPRODUT.PESOBRUTO, 0)) AS PESO, 
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
  FROM PCPEDI, 
       PCPEDC, 
       PCPRODUT, 
       PCFORNEC, 
       PCDEPTO, 
       PCUSUARI, 
       PCCLIENT, 
       PCPRACA, PCSUPERV 

 WHERE PCPEDC.DATA BETWEEN :DATAI AND :DATAF 
   AND (PCPEDI.DATA >=:DATAI AND PCPEDC.DATA <=:DATAF)
   AND PCPEDI.NUMPED = PCPEDC.NUMPED 
   AND PCPEDI.CODPROD = PCPRODUT.CODPROD 
   AND PCPRODUT.CODEPTO = PCDEPTO.CODEPTO 
   AND PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC 
   AND  PCPEDC.CODUSUR  = PCUSUARI.CODUSUR 
   AND PCPEDC.CODCLI = PCCLIENT.CODCLI 
   AND PCPEDC.CODPRACA = PCPRACA.CODPRACA 
   AND PCPEDC.DTCANCEL IS NULL 
   AND  PCPEDC.CODSUPERVISOR  = PCSUPERV.CODSUPERVISOR
AND PCPEDC.CONDVENDA NOT IN (4,8,10,13,20,98,99)
AND PCPEDC.CODFILIAL IN ('2')
 AND PCPEDC.CODFILIAL IN (SELECT PCLIB.CODIGOA
                                  FROM PCLIB
                                 WHERE CODTABELA = 1
                                  AND CODFUNC = 1261)
 GROUP BY PCPRODUT.CODFORNEC, 
          PCFORNEC.FORNECEDOR 
ORDER BY PVENDA DESC
DATAI = '01/10/2023'
DATAF = '31/10/2023'