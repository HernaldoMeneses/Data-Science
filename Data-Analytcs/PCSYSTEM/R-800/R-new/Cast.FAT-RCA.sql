select  fat."VL.Faturado"
, fat."PESO (Kg)"
, geral.*,  magna.*, inad.*
from (
SELECT
pcpedi.codusur
, pcusuari.NOME
--,       SUM(PCPEDI.QT) AS QT,
,       SUM(ROUND(NVL(PCPEDI.QT,0)*(NVL(PCPEDI.PVENDA, 0) + NVL(PCPEDI.VLOUTRASDESP, 0) + NVL(PCPEDI.VLFRETE, 0)),2)) AS PVENDA
,       SUM(ROUND(NVL(PCPEDI.QT,0)*(NVL(PCPEDI.PVENDA, 0) + NVL(PCPEDI.VLOUTRASDESP, 0) + NVL(PCPEDI.VLFRETE, 0)),2))* 1/100 as "Com Fixa (1%)"
,       SUM(ROUND(NVL(PCPEDI.QT,0)*(NVL(PCPEDI.PVENDA, 0) + NVL(PCPEDI.VLOUTRASDESP, 0) + NVL(PCPEDI.VLFRETE, 0)),2))* 0.25/100 as "Geral (0,25%)"

, case 
    when pcpedi.codusur = 1139 then 10000
    when pcpedi.codusur = 1140 then 7000
    when pcpedi.codusur = 1141 then 8000
    when pcpedi.codusur = 1143 then 15000
    when pcpedi.codusur = 1157 then 2500
    when pcpedi.codusur = 1269 then 3500
    when pcpedi.codusur = 1379 then 1500
    else 0 end "MGL - Nov"
    




--,       SUM(ROUND(NVL(PCPRODUT.PESOBRUTO,0)*NVL(PCPEDI.QT,0),2)) AS TOTPESO
, sum(ROUND( (NVL(PCPRODUT.PESOBRUTO,PCMOV.PESOBRUTO) * NVL(PCMOV.QT, 0)),2)) AS TOTPESO


    , case 
    when pcpedi.codusur = 1139 then SUM(ROUND(NVL(PCPRODUT.PESOBRUTO,0)*NVL(PCPEDI.QT,0),2))/10000
    when pcpedi.codusur = 1140 then SUM(ROUND(NVL(PCPRODUT.PESOBRUTO,0)*NVL(PCPEDI.QT,0),2))/7000
    when pcpedi.codusur = 1141 then SUM(ROUND(NVL(PCPRODUT.PESOBRUTO,0)*NVL(PCPEDI.QT,0),2))/8000
    when pcpedi.codusur = 1143 then SUM(ROUND(NVL(PCPRODUT.PESOBRUTO,0)*NVL(PCPEDI.QT,0),2))/15000
    when pcpedi.codusur = 1157 then SUM(ROUND(NVL(PCPRODUT.PESOBRUTO,0)*NVL(PCPEDI.QT,0),2))/2500
    when pcpedi.codusur = 1269 then SUM(ROUND(NVL(PCPRODUT.PESOBRUTO,0)*NVL(PCPEDI.QT,0),2))/3500
    when pcpedi.codusur = 1379 then SUM(ROUND(NVL(PCPRODUT.PESOBRUTO,0)*NVL(PCPEDI.QT,0),2))/1500
    else 0 end "%Litros Geral"



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
pcusuari, 
pcmov  
WHERE 1=1 
AND PCPEDC.DATA BETWEEN :DATAI AND :DATAF
AND PCPEDC.CODFILIAL IN ('2')
AND PCPEDC.CONDVENDA IN (1, 2, 3, 7, 9, 14, 15, 17, 18, 19, 98)
and PCPEDC.NUMPED    = PCPEDI.NUMPED
AND pcmov.CODPROD = pcpedi.codprod
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
--AND PCPEDC.NUMPED >= (SELECT MIN(NUMPED) FROM PCPEDC)
--AND PCPEDI.CODPROD >= (SELECT MIN(CODPROD) FROM PCPEDI)

Group By pcpedi.codusur
, pcusuari.NOME

Order by pcpedi.codusur
, pcusuari.NOME
) Geral,
(
SELECT
pcpedi.codusur
--, pcusuari.NOME
--,       SUM(PCPEDI.QT) AS QT,

,       SUM(ROUND(NVL(PCPEDI.QT,0)*(NVL(PCPEDI.PVENDA, 0) + NVL(PCPEDI.VLOUTRASDESP, 0) + NVL(PCPEDI.VLFRETE, 0)),2)) AS PVENDAMag
,       SUM(ROUND(NVL(PCPEDI.QT,0)*(NVL(PCPEDI.PVENDA, 0) + NVL(PCPEDI.VLOUTRASDESP, 0) + NVL(PCPEDI.VLFRETE, 0)),2))* 1/100 as "MAGNATEC (75%)"
--,       SUM(ROUND(NVL(PCPEDI.QT,0)*(NVL(PCPEDI.PVENDA, 0) + NVL(PCPEDI.VLOUTRASDESP, 0) + NVL(PCPEDI.VLFRETE, 0)),2))* 0.25/100 as "Geral (0,25%) Mag"

, case 
    when pcpedi.codusur = 1139 then 800
    when pcpedi.codusur = 1140 then 600
    when pcpedi.codusur = 1141 then 500
    when pcpedi.codusur = 1143 then 1000
    when pcpedi.codusur = 1157 then 100
    when pcpedi.codusur = 1269 then 600
    when pcpedi.codusur = 1379 then 700
    else 0 end "MML - Nov"

,       SUM(ROUND(NVL(PCPRODUT.PESOBRUTO,0)*NVL(PCPEDI.QT,0),2)) AS "TOTPESO-MGT"

, case 
    when pcpedi.codusur = 1139 then SUM(ROUND(NVL(PCPRODUT.PESOBRUTO,0)*NVL(PCPEDI.QT,0),2))/800
    when pcpedi.codusur = 1140 then SUM(ROUND(NVL(PCPRODUT.PESOBRUTO,0)*NVL(PCPEDI.QT,0),2))/600
    when pcpedi.codusur = 1141 then SUM(ROUND(NVL(PCPRODUT.PESOBRUTO,0)*NVL(PCPEDI.QT,0),2))/500
    when pcpedi.codusur = 1143 then SUM(ROUND(NVL(PCPRODUT.PESOBRUTO,0)*NVL(PCPEDI.QT,0),2))/1000
    when pcpedi.codusur = 1157 then SUM(ROUND(NVL(PCPRODUT.PESOBRUTO,0)*NVL(PCPEDI.QT,0),2))/100
    when pcpedi.codusur = 1269 then SUM(ROUND(NVL(PCPRODUT.PESOBRUTO,0)*NVL(PCPEDI.QT,0),2))/600
    when pcpedi.codusur = 1379 then SUM(ROUND(NVL(PCPRODUT.PESOBRUTO,0)*NVL(PCPEDI.QT,0),2))/700
    else 0 end "%Litros MGT"


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
AND PCProdut.codmarca = 67 -- MAGNATEC
AND   pcusuari.codusur = pcpedi.codusur
AND   PCLIB.CODTABELA  = 2
 AND NVL(PCPEDI.BONIFIC, 'N') =  'N' 

AND PCPEDC.POSICAO = 'F'
AND PCPRODUT.CODFORNEC IN(3395,3663,3420)
AND   PCPEDC.DTCANCEL IS NULL
--AND PCPEDC.NUMPED >= (SELECT MIN(NUMPED) FROM PCPEDC)
--AND PCPEDI.CODPROD >= (SELECT MIN(CODPROD) FROM PCPEDI)

Group By pcpedi.codusur
, pcusuari.NOME

Order by pcpedi.codusur
, pcusuari.NOME
) magna,


(
SELECT 
TOTAL.CODUSUR,                               
--       PCUSUARI.NOME NOMERCA,                       
--       TOTAL.CODSUPERVISOR,                         
--       PCSUPERV.NOME NOMESUP,                       
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
--AND PCUSUARI.CODSUPERVISOR = 65    
                                                                       
GROUP BY PCUSUARI.CODSUPERVISOR                                             
, PCUSUARI.CODUSUR                                                          
)                                                                              
) TOTAL, PCUSUARI, PCSUPERV                         
 WHERE TOTAL.CODUSUR = PCUSUARI.CODUSUR             
   AND TOTAL.CODSUPERVISOR = PCSUPERV.CODSUPERVISOR 
GROUP BY TOTAL.CODSUPERVISOR, TOTAL.CODUSUR,        
          PCSUPERV.NOME, PCUSUARI.NOME              
ORDER BY TOTAL.CODSUPERVISOR, TOTAL.CODUSUR


) inad,

(
SELECT 

VENDAS.codusur
, VENDAS.NOME
--, COUNT(DISTINCT(VENDAS.CODCLI)) AS "QTCLIATIVOS"
--, VENDAS.QTCLIPOS AS "QTCLIPOS"
--, VENDAS.QTCLIPOS/COUNT(DISTINCT(VENDAS.CODCLI)) AS "% PosiCarteira"
, sum(VENDAS.VLVENDA) AS "VL.Faturado"
, sum(VENDAS.TOTPESO) AS "PESO (Kg)"
--, sum(VENDAS.VOLUME) AS "VOLUME (m°)"
--, sum(VENDAS.LITRAGEM) AS "VOLUME (L)"
 FROM (  SELECT PCNFSAID.NUMTRANSVENDA, PCMOV.CODCLI,
       PCCLIENT.CLIENTE,
       PCFORNEC.CODFORNECPRINC,
     PCFORNEC.FORNECEDOR,
       PCFORNEC.CODFORNEC,
 PCNFSAID.CODUSUR  CODUSUR, 
       PCUSUARI.NOME, 
 NVL(PCNFSAID.CODSUPERVISOR,PCSUPERV.CODSUPERVISOR)  CODSUPERVISOR, 
       PCSUPERV.NOME SUPERV, 
       PCPRODUT.CODEPTO, 
       PCPRODUT.CODSEC, 
       PCDEPTO.DESCRICAO DEPARTAMENTO, 
       PCSECAO.DESCRICAO SECAO, 
       PCNFSAID.CODPRACA, 
       PCPRACA.PRACA, 
       PCPRODUT.CODMARCA, 
       PCMARCA.MARCA, 
       PCCLIENT.ESTENT, 
       PCCLIENT.MUNICENT,
       PCCLIENT.CODCIDADE,
       PCCIDADE.NOMECIDADE,
       NVL(PCCLIENT.CODCLIPRINC, PCCLIENT.CODCLI) CODCLIPRINC, 
       (SELECT X.CLIENTE 
          FROM PCCLIENT X 
         WHERE X.CODCLI = NVL(PCCLIENT.CODCLIPRINC, PCCLIENT.CODCLI)) CLIENTEPRINC, 
       ROUND( (NVL(PCPRODUT.VOLUME, 0) * NVL(PCMOV.QT, 0)),2)  VOLUME, 
      (NVL(PCPRODUT.LITRAGEM, 0) * NVL(PCMOV.QT, 0))  LITRAGEM, 
       PCATIVI.RAMO,
       PCATIVI.CODATIV,
       PCMOV.CODPROD,
       PCPRODUT.DESCRICAO,
       PCPRODUT.EMBALAGEM,
       PCPRODUT.UNIDADE,
       PCPRODUT.CODFAB,
       PCNFSAID.CODPLPAG,
       PCNFSAID.NUMPED,
       PCNFSAID.CODCOB,
       PCCLIENT.CODPLPAG CODPLANOCLI,
       PCPLPAG.DESCRICAO DESCRICAOPCPLPAG,
       PCPLPAG.NUMDIAS, 
       0 QTMETA,
       0 QTPESOMETA,
       0 MIXPREV,
       0 CLIPOSPREV,
       ROUND((DECODE(PCMOV.CODOPER,  
                     'SB',         
                     PCMOV.QTCONT,   
                     0)) *           
       NVL(PCMOV.VLREPASSE, 0),      
       2) VLREPASSEBNF,              
         ROUND((NVL(PCMOV.QT, 0) * 
         DECODE(PCNFSAID.CONDVENDA,
                 5,
                 0,
                 6,
                 0,
                 11,
                 0,
                 12,
                 0,
                 DECODE(PCMOV.CODOPER,'SB',0,nvl(pcmov.VLIPI,0)))),2) VALORIPI,
                 0 VALORIPIX,
         ROUND(NVL(PCMOV.QT, 0) * 
         DECODE(PCNFSAID.CONDVENDA,
                 5,
                 0,
                 6,
                 0,
                 11,
                 0,
                 12,
                 0,
                 DECODE(PCMOV.CODOPER,'SB',0,(nvl(pcmov.ST,0)+NVL(PCMOVCOMPLE.VLSTTRANSFCD,0)))),2) VALORST,
                 0 VALORSTX,
         (SELECT PCCLIENT.CODPLPAG || ' - ' || PCPLPAG.DESCRICAO  FROM PCPLPAG WHERE PCCLIENT.CODPLPAG = PCPLPAG.CODPLPAG) 
DESCRICAOPLANOCLI,
       ((DECODE(PCMOV.CODOPER,  
                           'S', 
                           (NVL(DECODE(PCNFSAID.CONDVENDA, 
                                       7, 
                                       PCMOV.QTCONT, 
                                       PCMOV.QT), 
                                0)), 
                           'SM', 
                           (NVL(DECODE(PCNFSAID.CONDVENDA, 
                                       7, 
                                       PCMOV.QTCONT, 
                                       PCMOV.QT), 
                                0)), 
                           'ST', 
                           (NVL(DECODE(PCNFSAID.CONDVENDA, 
                                       7, 
                                       PCMOV.QTCONT, 
                                       PCMOV.QT), 
                                0)), 
                           'SB', 
                           (NVL(DECODE(PCNFSAID.CONDVENDA, 
                                       7, 
                                       PCMOV.QTCONT, 
                                       PCMOV.QT), 
                                0)), 
                           0))) QTVENDA, 
                  ((DECODE(PCMOV.CODOPER                                
                          ,'S'                                        
                          ,(NVL(DECODE(PCNFSAID.CONDVENDA,              
                                       7,                               
                                       PCMOV.QTCONT,                    
                                       PCMOV.QT),                       
                                0))                                     
                          ,'ST'                                       
                          ,(NVL(DECODE(PCNFSAID.CONDVENDA,              
                                       7,                               
                                       PCMOV.QTCONT,                    
                                       PCMOV.QT),                       
                                0))                                     
                          ,'SM'                                       
                          ,(NVL(DECODE(PCNFSAID.CONDVENDA,              
                                       7,                               
                                       PCMOV.QTCONT,                    
                                       PCMOV.QT),                       
                                0))                                     
                          ,'SB'                                       
                          ,(NVL(DECODE(PCNFSAID.CONDVENDA,              
                                       7,                               
                                       PCMOV.QTCONT,                    
                                       PCMOV.QT),                       
                                0))                                     
                          ,0)) * (NVL(PCMOV.CUSTOFIN, 0)   
                          )) VLCUSTOFIN,  
 CASE WHEN NVL(PCMOVCOMPLE.VLSUBTOTITEM,0) <> 0 THEN  
  DECODE(NVL(PCMOV.TIPOITEM,'N'),'C',0,NVL(PCMOVCOMPLE.VLSUBTOTITEM,0)) - 
       (  ROUND((NVL(PCMOV.QT, 0) * 
         DECODE(PCNFSAID.CONDVENDA,
                 5,
                 0,
                 6,
                 0,
                 11,
                 0,
                 12,
                 0,
                 DECODE(PCMOV.CODOPER,'SB',0,nvl(pcmov.VLIPI,0)))),2)) -  
       (  ROUND(NVL(PCMOV.QT, 0) * 
         DECODE(PCNFSAID.CONDVENDA,
                 5,
                 0,
                 6,
                 0,
                 11,
                 0,
                 12,
                 0,
                 DECODE(PCMOV.CODOPER,'SB',0,nvl(pcmov.ST,0))),2)) 
 ELSE                                                
       ROUND((((DECODE(PCMOV.CODOPER,                                           
                       'S',                                                   
                       (NVL(DECODE(PCNFSAID.CONDVENDA,                          
                                   7,                                           
                                   PCMOV.QTCONT,                                
                                   PCMOV.QT),                                   
                            0)),                                                
                       'ST',                                                  
                       (NVL(DECODE(PCNFSAID.CONDVENDA,                          
                                   7,                                           
                                   PCMOV.QTCONT,                                
                                   PCMOV.QT),                                   
                            0)),                                                
                       'SM',                                                  
                       (NVL(DECODE(PCNFSAID.CONDVENDA,                          
                                   7,                                           
                                   PCMOV.QTCONT,                                
                                   PCMOV.QT),                                   
                            0)),                                                
                       0)) *                                                    
             (NVL(DECODE(PCNFSAID.CONDVENDA,                                    
                           7,                                                   
                           (NVL(PUNITCONT, 0) - NVL(PCMOV.VLIPI, 0) -           
                           (nvl(pcmov.ST,0)+NVL(PCMOVCOMPLE.VLSTTRANSFCD,0))) + NVL(PCMOV.VLFRETE, 0) +          
                           NVL(PCMOV.VLOUTRASDESP, 0) +                         
                           NVL(PCMOV.VLFRETE_RATEIO, 0) +                       
                           DECODE(PCMOV.TIPOITEM,                               
                                  'C',                                        
                                  (SELECT NVL((SUM(M.QTCONT *                   
                                                   NVL(M.VLOUTROS, 0)) /        
                                          PCMOV.QT), 0) VLOUTROS                
                                     FROM PCMOV M                               
                                    WHERE M.NUMTRANSVENDA =                     
                                          PCMOV.NUMTRANSVENDA                   
                                      AND M.TIPOITEM = 'I'                    
                                      AND CODPRODPRINC = PCMOV.CODPROD),        
 'I', NVL(PCMOV.VLOUTROS, 0),DECODE(NVL(PCNFSAID.SOMAREPASSEOUTRASDESPNF,'N'),'N',NVL((PCMOV.VLOUTROS), 0),'S',
NVL((PCMOV.VLOUTROS-PCMOV.VLREPASSE), 0)))
                           ,(NVL(PCMOV.PUNIT, 0) - NVL(PCMOV.VLIPI, 0) -         
                           (nvl(pcmov.ST,0)+NVL(PCMOVCOMPLE.VLSTTRANSFCD,0))) + NVL(PCMOV.VLFRETE, 0) +          
                           NVL(PCMOV.VLOUTRASDESP, 0) +                         
                           NVL(PCMOV.VLFRETE_RATEIO, 0) +                       
                           DECODE(PCMOV.TIPOITEM,                               
                                  'C',                                        
                                  (SELECT NVL((SUM(M.QTCONT *                   
                                                   NVL(M.VLOUTROS, 0)) /        
                                          PCMOV.QT), 0) VLOUTROS                
                                     FROM PCMOV M                               
                                    WHERE M.NUMTRANSVENDA =                     
                                          PCMOV.NUMTRANSVENDA                   
                                      AND M.TIPOITEM = 'I'                    
                                      AND CODPRODPRINC = PCMOV.CODPROD),        
 'I', NVL(PCMOV.VLOUTROS, 0), DECODE(NVL(PCNFSAID.SOMAREPASSEOUTRASDESPNF,'N'),'N',NVL((PCMOV.VLOUTROS), 0),'S',
NVL((PCMOV.VLOUTROS-PCMOV.VLREPASSE), 0)))
                    ),0)))),                                                    
             2) END AS VLVENDA,                                                 
                                                                                
       (((DECODE(PCMOV.CODOPER,                                                 
                 'S',                                                         
                 (NVL(DECODE(PCNFSAID.CONDVENDA, 7, PCMOV.QTCONT, PCMOV.QT),    
                      0)),                                                      
                 'ST',                                                        
                 (NVL(DECODE(PCNFSAID.CONDVENDA, 7, PCMOV.QTCONT, PCMOV.QT),    
                      0)),                                                      
                 'SM',                                                        
                 (NVL(DECODE(PCNFSAID.CONDVENDA, 7, PCMOV.QTCONT, PCMOV.QT),    
                      0)),                                                      
                 0)) *                                                          
       (NVL(DECODE(PCNFSAID.CONDVENDA,                                          
                     7,                                                         
                     PCMOV.PUNITCONT,                                           
                     NVL(PCMOV.PUNIT, 0) + NVL(PCMOV.VLFRETE, 0) +              
                     NVL(PCMOV.VLOUTRASDESP, 0) +                               
                     NVL(PCMOV.VLFRETE_RATEIO, 0) +                             
                     DECODE(PCMOV.TIPOITEM,                                     
                            'C',                                              
                            (SELECT (SUM(M.QTCONT * NVL(M.VLOUTROS, 0)) /       
                                    PCMOV.QT) VLOUTROS                          
                               FROM PCMOV M                                     
                              WHERE M.NUMTRANSVENDA = PCMOV.NUMTRANSVENDA       
                                AND M.TIPOITEM = 'I'                          
                                AND CODPRODPRINC = PCMOV.CODPROD),              
 'I', NVL(PCMOV.VLOUTROS, 0), DECODE(NVL(PCNFSAID.SOMAREPASSEOUTRASDESPNF,'N'),'N',NVL((PCMOV.VLOUTROS), 0),'S',
NVL((PCMOV.VLOUTROS-PCMOV.VLREPASSE), 0)))
                      - (nvl(pcmov.ST,0)+NVL(PCMOVCOMPLE.VLSTTRANSFCD,0))),               
              0)))) VLVENDA_SEMST,                                              
      ROUND(    (NVL(PCMOV.QT, 0) *(
       DECODE(PCNFSAID.CONDVENDA,
               5,
               DECODE(PCMOV.PBONIFIC, NULL, PCMOV.PTABELA, PCMOV.PBONIFIC)
               ,6,
               DECODE(PCMOV.PBONIFIC, NULL, PCMOV.PTABELA, PCMOV.PBONIFIC),
               11,
               DECODE(PCMOV.PBONIFIC, NULL, PCMOV.PTABELA, PCMOV.PBONIFIC),
               1,
               NVL(PCMOV.PBONIFIC,0),                                      
               14,
               NVL(PCMOV.PBONIFIC,0),                                      
               12,
               DECODE(PCMOV.PBONIFIC, NULL, PCMOV.PTABELA, PCMOV.PBONIFIC),
               0)) 
),2) VLBONIFIC,
               ((DECODE(PCMOV.CODOPER,
                           'S',
                           (NVL(DECODE(PCNFSAID.CONDVENDA,
                                       7,
                                       PCMOV.QTCONT,
                                       PCMOV.QT),
                                0)),
                           'ST',
                           (NVL(DECODE(PCNFSAID.CONDVENDA,
                                       7,
                                       PCMOV.QTCONT,
                                       PCMOV.QT),
                                0)),
                           'SM',
                           (NVL(DECODE(PCNFSAID.CONDVENDA,
                                       7,
                                       PCMOV.QTCONT,
                                       PCMOV.QT),
                                0)),
                           0))) QTVENDIDA,
       ROUND( (NVL(PCPRODUT.PESOBRUTO,PCMOV.PESOBRUTO) * NVL(PCMOV.QT, 0)),2) AS TOTPESO,
       ROUND(PCMOV.QT * (PCMOV.PTABELA
                       + NVL (pcmov.vlfrete, 0) + NVL (pcmov.vloutrasdesp, 0) + NVL (pcmov.vlfrete_rateio, 0) + NVL 
(pcmov.vloutros, 0) 
  ),2) VLTABELA,
       PCMOV.CODCLI QTCLIPOS,
       PCNFSAID.NUMTRANSVENDA QTNUMTRANSVENDA, 
       PCNFSAID.CODFILIAL, 
      (SELECT PCFILIAL.FANTASIA 
              FROM PCNFSAID P, PCFILIAL  
             WHERE P.CODFILIAL = PCFILIAL.CODIGO 
               AND P.NUMTRANSVENDA = PCNFSAID.NUMTRANSVENDA  AND ROWNUM = 1) FILIAL,
       PCPRODUT.CODPROD AS QTMIXCAD,
       PCMOV.CODPROD AS QTMIX, 
   (SELECT COUNT(*) FROM PCPRODUT P
WHERE P.CODFORNEC = PCFORNEC.CODFORNEC AND NVL(P.REVENDA,'S')  = 'S' ) QTMIXCADNOVO,
 PCGERENTE.NOMEGERENTE,
 DECODE(PCNFSAID.NUMTRANSVENDA,NULL,PCSUPERV.CODGERENTE,PCNFSAID.CODGERENTE) CODGERENTE, 
 PCPRACA.ROTA,
 PCROTAEXP.DESCRICAO DESCROTA,
               (NVL(PCMOV.VLREPASSE,0) * DECODE(PCNFSAID.CONDVENDA,
              5,0,6,0,11,0,12,0,DECODE(PCMOV.CODOPER,'SB',0,NVL(PCMOV.QT, 0)) ))  AS VLREPASSE,
 PCPRODUT.CODAUXILIAR
  FROM PCNFSAID,
       PCPRODUT,
       PCMOV,
       PCCLIENT,
       PCUSUARI,
       PCSUPERV,
       PCPLPAG,
       PCFORNEC,
       PCATIVI, 
       PCPRACA,
       PCDEPTO,
       PCSECAO,
       PCPEDC,
       PCGERENTE,
       PCCIDADE,
       PCMARCA,
       PCROTAEXP,
       PCMOVCOMPLE
 WHERE PCMOV.NUMTRANSVENDA = PCNFSAID.NUMTRANSVENDA
   AND PCMOV.DTMOV BETWEEN  TO_DATE(:DATAI, 'DD/MM/YYYY') AND 
                                 TO_DATE(:DATAF, 'DD/MM/YYYY') 
   AND PCMOV.CODPROD = PCPRODUT.CODPROD
   AND PCNFSAID.CODPRACA = PCPRACA.CODPRACA(+)
   AND PCATIVI.CODATIV(+) = PCCLIENT.CODATV1
   AND PCMOV.CODCLI = PCCLIENT.CODCLI
   AND PCFORNEC.CODFORNEC = PCPRODUT.CODFORNEC
   AND  PCNFSAID.CODUSUR   = PCUSUARI.CODUSUR 
   AND PCPRACA.ROTA = PCROTAEXP.CODROTA(+)
   AND PCMOV.NUMTRANSITEM = PCMOVCOMPLE.NUMTRANSITEM(+)
   AND PCPRODUT.CODMARCA = PCMARCA.CODMARCA(+)
   AND PCCLIENT.CODCIDADE = PCCIDADE.CODCIDADE(+)
  AND PCMOV.CODOPER <> 'SR' 
  AND NVL(PCNFSAID.TIPOVENDA,'X') NOT IN ('SR', 'DF')
  AND PCMOV.CODOPER <> 'SO' 
   AND  NVL(PCNFSAID.CODSUPERVISOR,PCSUPERV.CODSUPERVISOR)   = PCSUPERV.CODSUPERVISOR
   AND PCNFSAID.CODPLPAG = PCPLPAG.CODPLPAG
   AND PCNFSAID.NUMPED = PCPEDC.NUMPED(+)
   AND PCPRODUT.CODEPTO = PCDEPTO.CODEPTO(+)
   AND PCPRODUT.CODSEC = PCSECAO.CODSEC(+)
   AND PCNFSAID.CODGERENTE = PCGERENTE.CODGERENTE(+) 
   AND PCNFSAID.CODFISCAL NOT IN (522, 622, 722, 532, 632, 732)
   AND PCNFSAID.CONDVENDA NOT IN (4, 8, 10, 13, 20, 98, 99)
   AND (PCNFSAID.DTCANCEL IS NULL)
   AND (PCPRODUT.CODFORNEC IN ( 3395,3420,3663 )) 
   AND PCNFSAID.DTSAIDA BETWEEN  TO_DATE(:DATAI, 'DD/MM/YYYY') AND 
                                 TO_DATE(:DATAF, 'DD/MM/YYYY') 
           AND PCMOV.CODFILIAL IN('2')
           AND PCNFSAID.CODFILIAL IN('2')
           AND PCMOV.DTMOV >= (SELECT MIN(DTMOV) FROM PCMOV)
 		       AND PCPEDC.NUMPED >= (SELECT MIN(NUMPED) FROM PCPEDC)
 		       AND PCPEDC.DATA >= (SELECT MIN(DATA) FROM PCPEDC)
 		       AND PCNFSAID.DTSAIDA >= (SELECT MIN(DTSAIDA) FROM PCNFSAID)
) VENDAS

where VENDAS.codusur in (1139,1140,1141,1143,1157,1269,1379)
Group By 
VENDAS.codusur
, VENDAS.NOME


) fat



where Geral.codusur = magna.codusur
AND Geral.codusur = inad.codusur
AND Geral.codusur = fat.codusur
AND geral."MGL - Nov" > 0