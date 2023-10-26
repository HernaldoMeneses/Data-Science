----------------------------------
Timestamp: 08:37:05.980
SELECT COUNT(*) CONTADOR
  FROM PCLIB
 WHERE CODTABELA = 3
   AND CODIGON = 999999
   AND CODFUNC = :CODFUNC
CODFUNC = 1261
----------------------------------
Timestamp: 08:37:06.012
SELECT COUNT(*) CONTADOR
  FROM PCLIB
 WHERE CODTABELA = 3
   AND CODIGON = 999999
   AND CODFUNC = :CODFUNC
CODFUNC = 1261
----------------------------------
Timestamp: 08:37:06.039
SELECT COUNT(*) ACESSO
  FROM PCLIB
 WHERE PCLIB.CODTABELA = 1
   AND PCLIB.CODFUNC = 1261
   AND PCLIB.CODIGOA = '99'
----------------------------------
Timestamp: 08:37:06.061
SELECT
  CODIGO,
  RAZAOSOCIAL
FROM PCFILIAL
 WHERE CODIGO IN  (SELECT PCLIB.CODIGOA    FROM PCLIB  WHERE PCLIB.CODFUNC = 1261    AND PCLIB.CODTABELA = 1 )
 AND TO_CHAR(CODIGO) = :PARAM1
PARAM1 = '2'
----------------------------------
Timestamp: 08:37:09.310
SELECT        SUM(CASE                                                                                                                            
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
FROM PCPEDI, PCPEDC, PCCLIENT, PCPRODUT, PCPRACA, PCUSUARI, PCFORNEC, PCSUPERV

WHERE (PCPEDC.DATA >=:DATAI AND PCPEDC.DATA <=:DATAF)
AND (PCPEDI.DATA >=:DATAI AND PCPEDI.DATA <=:DATAF)
AND PCPEDI.NUMPED = PCPEDC.NUMPED
AND PCPEDI.CODPROD = PCPRODUT.CODPROD
AND PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC
AND PCPEDI.CODPROD = PCPRODUT.CODPROD
AND PCPEDC.CODCLI = PCCLIENT.CODCLI
AND  PCPEDC.CODSUPERVISOR  = PCSUPERV.CODSUPERVISOR
AND  PCPEDC.CODUSUR  = PCUSUARI.CODUSUR
AND PCPEDC.CODPRACA = PCPRACA.CODPRACA
AND PCPEDC.DTCANCEL IS NULL
AND PCPEDC.DTCANCEL IS NULL
AND PCPEDC.CODFILIAL IN ('2')
AND PCPEDC.CONDVENDA NOT IN (4,8,10,13,20,98,99)
DATAI = '01/10/2023'
DATAF = '31/10/2023'
----------------------------------
Timestamp: 08:37:09.582
SELECT COUNT(*) CONTADOR
  FROM PCLIB
 WHERE CODTABELA = 3
   AND CODIGON = 999999
   AND CODFUNC = :CODFUNC
CODFUNC = 1261
----------------------------------
Timestamp: 08:37:09.622
SELECT COUNT(*) ACESSO
  FROM PCLIB
 WHERE PCLIB.CODTABELA = 1
   AND PCLIB.CODFUNC = 1261
   AND PCLIB.CODIGOA = '99'
----------------------------------
Timestamp: 08:37:09.648
SELECT
  CODIGO,
  RAZAOSOCIAL
FROM PCFILIAL
 WHERE CODIGO IN  (SELECT PCLIB.CODIGOA    FROM PCLIB  WHERE PCLIB.CODFUNC = 1261    AND PCLIB.CODTABELA = 1 )
 AND TO_CHAR(CODIGO) = :PARAM1
PARAM1 = '2'
----------------------------------
Timestamp: 08:37:09.692
SELECT COUNT(*) CONTADOR
  FROM PCLIB
 WHERE CODTABELA = 3
   AND CODIGON = 999999
   AND CODFUNC = :CODFUNC
CODFUNC = 1261
----------------------------------
Timestamp: 08:37:14.950
SELECT PCPEDI.CODPROD, PCPRODUT.DESCRICAO, PCPRODUT.CODFAB,
PCPRODUT.EMBALAGEM, PCPRODUT.UNIDADE, TO_CHAR(PCPRODUT.MARCA) MARCA, PCFORNEC.FORNECEDOR, 
PCPRODUT.CLASSE,
             PCFORNEC.CODCOMPRADOR,
       (SELECT PCEMPR.NOME
          FROM PCEMPR
         WHERE 1=1
               AND PCFORNEC.CODCOMPRADOR = PCEMPR.MATRICULA
               AND PCEMPR.CODSETOR IN
               (SELECT PCCONSUM.CODSETORCOMPRADOR FROM PCCONSUM)
           ) COMPRADOR,
              (CASE WHEN PCPRODUT.PESOBRUTO = 0 THEN 0 
               ELSE (PCPRODUT.PESOBRUTO * SUM(PCPEDI.QT)) END) PESOBRUTO, 
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
                      END) VLVENDAV, 
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
      ROUND( SUM(DECODE(PCPEDC.CONDVENDA,                                                                                                        
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
                  0)),2) VLBONIFIC,                                                                                                           
   SUM((PCPEDI.qt)*NVL(PCPEDI.vlcustofin,0)) AS VLCUSTOFIN,
   SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') <> 'N' THEN 0 ELSE NVL(PCPEDI.QT, 0) END,5,0,6,0,11,0,12,0,
NVL(PCPEDI.QT,0))) QT,
   SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') <> 'N' THEN 0 ELSE NVL(PCPEDI.QT, 0) / 
DECODE(NVL(PCPRODUT.QTUNITCX,0),0,1,PCPRODUT.QTUNITCX) END,5,0,6,0,11,0,12,0,NVL(PCPEDI.qt, 0)
  / DECODE(NVL(PCPRODUT.QTUNITCX,0),0,1,PCPRODUT.QTUNITCX))) AS QTCX,
SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') = 'S' THEN NVL(PCPEDI.QT, 0) ELSE 0 END,5,NVL(PCPEDI.QT, 0),6,
NVL(PCPEDI.QT, 0),11,NVL(PCPEDI.QT, 0),12,NVL(PCPEDI.QT, 0),0)) QTBNF,
SUM((DECODE(PCPEDC.CONDVENDA,5,0,6,0,11,0,12,0,1))) AS QTPEDIDOS
FROM PCPEDI, PCPEDC, PCCLIENT, PCPRODUT, PCPRACA, PCUSUARI, PCFORNEC, PCDEPTO, PCSUPERV

WHERE (PCPEDC.DATA >=:DATAI AND PCPEDC.DATA <=:DATAF)
AND (PCPEDI.DATA >=:DATAI AND PCPEDI.DATA <=:DATAF)
AND PCPEDI.NUMPED = PCPEDC.NUMPED
AND PCPEDI.CODPROD = PCPRODUT.CODPROD
AND PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC
AND PCPEDI.CODPROD = PCPRODUT.CODPROD
AND PCPEDC.CODCLI = PCCLIENT.CODCLI
AND PCPRODUT.CODEPTO = PCDEPTO.CODEPTO
AND  PCPEDC.CODSUPERVISOR  = PCSUPERV.CODSUPERVISOR
AND  PCPEDC.CODUSUR  = PCUSUARI.CODUSUR
AND PCPEDC.CODPRACA = PCPRACA.CODPRACA
AND PCPEDC.DTCANCEL IS NULL
AND PCPEDC.DTCANCEL IS NULL
AND PCPEDC.CODFILIAL IN ('2')
AND PCPEDC.CONDVENDA NOT IN (4,8,10,13,20,98,99)
 AND PCPEDC.CODFILIAL IN (SELECT PCLIB.CODIGOA
                                  FROM PCLIB
                                 WHERE CODTABELA = 1
                                  AND CODFUNC = 1261)
GROUP BY PCPEDI.CODPROD, PCPRODUT.DESCRICAO,
PCPRODUT.EMBALAGEM, PCPRODUT.UNIDADE, PCPRODUT.MARCA, PCFORNEC.FORNECEDOR, 
PCPRODUT.CLASSE, PCPRODUT.CODFAB, PCFORNEC.CODCOMPRADOR, PCPRODUT.PESOBRUTO
ORDER BY VLVENDA DESC
DATAI = '01/10/2023'
DATAF = '31/10/2023'
----------------------------------
Timestamp: 08:37:15.227
SELECT PARAMFILIAL.OBTERCOMOVARCHAR2('CON_DIRWINTHOR', '99')
  FROM DUAL