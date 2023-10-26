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
   AND (PCPRODUT.CODFORNEC IN ( 3420 )) 
AND PCPEDC.CONDVENDA NOT IN (4,8,10,13,20,98,99)
 AND PCPEDC.CODFILIAL IN (SELECT PCLIB.CODIGOA
                                  FROM PCLIB
                                 WHERE CODTABELA = 1
                                  AND CODFUNC = 1261)
GROUP BY PCPEDI.CODPROD, PCPRODUT.DESCRICAO,
PCPRODUT.EMBALAGEM, PCPRODUT.UNIDADE, PCPRODUT.MARCA, PCFORNEC.FORNECEDOR, 
PCPRODUT.CLASSE, PCPRODUT.CODFAB, PCFORNEC.CODCOMPRADOR, PCPRODUT.PESOBRUTO
ORDER BY VLVENDA DESC
