Select 
Fat.Codmarca, Fat.Marca, fat.codusur, fat.nome, fat.pvenda, fat.totpeso

, inad.QTTITULOS       
, inad.VLTITULOS

, inad.QTTITRECEBER 
, inad.VLRECEBER              
              
, round(inad.vlreceber/inad.vltitulos*100,2) as "%_inad" 
--, inad.MEDIAATRASO 
from (
SELECT
pcmarca.codmarca
, pcmarca.marca
, pcpedi.codusur
, pcusuari.NOME
--,       SUM(PCPEDI.QT) AS QT,
,       SUM(ROUND(NVL(PCPEDI.QT,0)*(NVL(PCPEDI.PVENDA, 0) + NVL(PCPEDI.VLOUTRASDESP, 0) + NVL(PCPEDI.VLFRETE, 0)),2)) AS PVENDA
,       SUM(ROUND(NVL(PCPRODUT.PESOBRUTO,0)*NVL(PCPEDI.QT,0),2)) AS TOTPESO
--,       COUNT(DISTINCT(PCPEDC.CODCLI)) AS QTCLIPOS,
--,       SUM(ROUND(NVL(PCPEDI.QT,0)*NVL(PCPEDI.VLCUSTOFIN,0),2)) AS VLCUSTOFIN,
--,  ((SUM(ROUND(NVL(PCPEDI.QT,0)*(NVL(PCPEDI.PVENDA, 0) + NVL(PCPEDI.VLOUTRASDESP, 0) + NVL(PCPEDI.VLFRETE, 0)),2))
--  -  SUM(ROUND(NVL(PCPEDI.QT,0)*NVL(PCPEDI.VLCUSTOFIN,0),2))) /  decode(SUM(ROUND(NVL(PCPEDI.QT,0)*NVL(PCPEDI.PVENDA,0),2)),0,1,
--SUM(ROUND(NVL(PCPEDI.QT,0)*NVL(PCPEDI.PVENDA,0),2))) * 100 ) as clPERLUC
FROM     
PCPEDI,  
PCPEDC,  
PCPRODUT,
PCCLIENT,
PCFORNEC,
PCLIB,
pcmarca,
pcusuari   
WHERE 1=1 
AND PCPEDC.DATA BETWEEN :DATAI AND :DATAF
AND PCPEDC.CODFILIAL IN ('2')
AND PCPEDC.CONDVENDA IN (1, 2, 3, 7, 9, 14, 15, 17, 18, 19, 98)
and PCPEDC.NUMPED    = PCPEDI.NUMPED
AND   PCPEDI.CODPROD   = PCPRODUT.CODPROD
AND   PCPEDC.CODCLI    = PCCLIENT.CODCLI
AND   PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC
AND   PCPRODUT.CODEPTO = PCLIB.CODIGON
AND   pcprodut.codmarca = pcmarca.codmarca
AND   pcusuari.codusur = pcpedi.codusur
AND   PCLIB.CODTABELA  = 2
 AND NVL(PCPEDI.BONIFIC, 'N') =  'N' 

AND PCPEDC.POSICAO = 'F'
AND PCPRODUT.CODFORNEC IN(3395,3663,3420)
AND   PCPEDC.DTCANCEL IS NULL
AND PCPEDC.NUMPED >= (SELECT MIN(NUMPED) FROM PCPEDC)
AND PCPEDI.CODPROD >= (SELECT MIN(CODPROD) FROM PCPEDI)

Group By
pcmarca.codmarca
, pcmarca.marca
, pcpedi.codusur
, pcusuari.NOME

Order by
pcmarca.codmarca
, pcmarca.marca
, pcpedi.codusur
, pcusuari.NOME

) Fat,

(
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
                        AND PCPREST.DTVENC BETWEEN :DATAI AND :DATAF       
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
 AND    PCPREST.DTVENC BETWEEN :DATAI AND LEAST( TRUNC(SYSDATE)-1, :DATAF) 

 AND CASE WHEN (DIAUTIL.VALOR) ='S' THEN                                     
    --F_QTDIASVENCIDOS(PCPREST.DTVENC,TRUNC(NVL(:DATAREF,SYSDATE)),PCPREST.CODCOB,PCPREST.CODFILIAL,DIAUTIL.VALOR)
    F_QTDIASVENCIDOS(PCPREST.DTVENC,TRUNC((SYSDATE)),PCPREST.CODCOB,PCPREST.CODFILIAL,DIAUTIL.VALOR)    
 ELSE  
    TRUNC((SYSDATE))-PCPREST.DTVENC END > 0                              
 AND PCPREST.CODFILIAL IN('2') 
                   
--AND PCUSUARI.CODUSUR=:CODUSUR                                                                            
--AND PCUSUARI.CODUSUR= 1157 
AND PCUSUARI.CODSUPERVISOR = 65    
                                                                       
GROUP BY PCUSUARI.CODSUPERVISOR                                             
, PCUSUARI.CODUSUR                                                          
)                                                                              
) TOTAL, PCUSUARI, PCSUPERV                         
 WHERE TOTAL.CODUSUR = PCUSUARI.CODUSUR             
   AND TOTAL.CODSUPERVISOR = PCSUPERV.CODSUPERVISOR 
GROUP BY TOTAL.CODSUPERVISOR, TOTAL.CODUSUR,        
          PCSUPERV.NOME, PCUSUARI.NOME              
ORDER BY TOTAL.CODSUPERVISOR, TOTAL.CODUSUR


) inad

where fat.codusur = inad.codusur