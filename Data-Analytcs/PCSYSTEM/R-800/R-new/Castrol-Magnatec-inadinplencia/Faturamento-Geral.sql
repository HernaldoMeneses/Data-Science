select base.* 
      , round((base."Com Fixa (1%)" +  base."Geral (0,25%)" + base."MAGNATEC(0,75%)" + base."%INADIMPLÊNCIA (1,00%)"),2) as "COMISSAO TOTAL"
      , (base."Com Fixa (1%)" +  base."Geral (0,25%)" + base."MAGNATEC(0,75%)" + base."%INADIMPLÊNCIA (1,00%)")/Base.FAturamento*100 as "% COMISSAO TOTAL"
from (
select 
fat.codusur
, fat.NOME
, Round(sum(fat.vlvenda),2) As FAturamento
, Round(sum(fat.vlvenda)* 1/100,2) as "Com Fixa (1%)"
--, Round(sum(fat.vlvenda)* 0.25/100,2) as "Geral (0,25%)"
, case 
    when fat.codusur = 1139 AND  Round(sum(fatMagnatec.TOTPESO)/600*100,2) >1 then Round(sum(fat.VLVENDA)*0.25/100,2)
    when fat.codusur = 1140 AND  Round(sum(fatMagnatec.TOTPESO)/500*100,2) >1 then Round(sum(fat.VLVENDA)*0.25/100,2)
    when fat.codusur = 1141 AND Round(sum(fatMagnatec.TOTPESO)/250*100,2) >1 then Round(sum(fat.VLVENDA)*0.25/100,2)
    when fat.codusur = 1143 AND  Round(sum(fatMagnatec.TOTPESO)/800*100,2) >1 then Round(sum(fat.VLVENDA)*0.25/100,2)
    when fat.codusur = 1157 AND  Round(sum(fatMagnatec.TOTPESO)/50*100,2) >1 then Round(sum(fat.VLVENDA)*0.25/100,2)
    when fat.codusur = 1269 AND  Round(sum(fatMagnatec.TOTPESO)/90*100,2) >1 then Round(sum(fat.VLVENDA)*0.25/100,2)
    when fat.codusur = 1379 AND  Round(sum(fatMagnatec.TOTPESO)/600*100,2) >1 then Round(sum(fat.VLVENDA)*0.25/100,2)
    else 0 end "Geral (0,25%)"


, Round(sum(fat.totpeso),2) As TotalPeso

, case 
    when fat.codusur = 1139 then 8000
    when fat.codusur = 1140 then 5000
    when fat.codusur = 1141 then 6000
    when fat.codusur = 1143 then 7000
    when fat.codusur = 1157 then 2500
    when fat.codusur = 1269 then 900
    when fat.codusur = 1379 then 1000
    else 0 end "MGL - Nov"

, case 
    when fat.codusur = 1139 then  Round(sum(fat.TOTPESO)/8000*100,2)
    when fat.codusur = 1140 then  Round(sum(fat.TOTPESO)/5000*100,2)
    when fat.codusur = 1141 then  Round(sum(fat.TOTPESO)/6000*100,2)
    when fat.codusur = 1143 then  Round(sum(fat.TOTPESO)/7000*100,2)
    when fat.codusur = 1157 then  Round(sum(fat.TOTPESO)/2500*100,2)
    when fat.codusur = 1269 then  Round(sum(fat.TOTPESO)/900*100,2)
    when fat.codusur = 1379 then  Round(sum(fat.TOTPESO)/1000*100,2)
    else 0 end "%Litros Geral"



, Round(sum(fatMagnatec.VLVENDA),2) AS "VL.Faturado_MAGNA"
--, Round(sum(fatMagnatec.VLVENDA)*0.75/100,2) AS "MAGNATEC(0,75%)"
, case 
    when fat.codusur = 1139 AND  Round(sum(fatMagnatec.TOTPESO)/600*100,2) >1 then Round(sum(fat.VLVENDA)*0.75/100,2)
    when fat.codusur = 1140 AND  Round(sum(fatMagnatec.TOTPESO)/500*100,2) >1 then Round(sum(fat.VLVENDA)*0.75/100,2)
    when fat.codusur = 1141 AND Round(sum(fatMagnatec.TOTPESO)/250*100,2) >1 then Round(sum(fat.VLVENDA)*0.75/100,2)
    when fat.codusur = 1143 AND  Round(sum(fatMagnatec.TOTPESO)/800*100,2) >1 then Round(sum(fat.VLVENDA)*0.75/100,2)
    when fat.codusur = 1157 AND  Round(sum(fatMagnatec.TOTPESO)/50*100,2) >1 then Round(sum(fat.VLVENDA)*0.75/100,2)
    when fat.codusur = 1269 AND  Round(sum(fatMagnatec.TOTPESO)/90*100,2) >1 then Round(sum(fat.VLVENDA)*0.75/100,2)
    when fat.codusur = 1379 AND  Round(sum(fatMagnatec.TOTPESO)/600*100,2) >1 then Round(sum(fat.VLVENDA)*0.75/100,2)
    else 0 end "MAGNATEC(0,75%)"

, Round(sum(fatMagnatec.TOTPESO),2) AS "PESO (Kg) MAGNA"


, case 
    when fat.codusur = 1139 then 600
    when fat.codusur = 1140 then 500
    when fat.codusur = 1141 then 250
    when fat.codusur = 1143 then 800
    when fat.codusur = 1157 then 50
    when fat.codusur = 1269 then 90
    when fat.codusur = 1379 then 600
    else 0 end "ML MAG - Nov"

, case 
    when fat.codusur = 1139 then  Round(sum(fatMagnatec.TOTPESO)/600*100,2)
    when fat.codusur = 1140 then  Round(sum(fatMagnatec.TOTPESO)/500*100,2)
    when fat.codusur = 1141 then  Round(sum(fatMagnatec.TOTPESO)/250*100,2)
    when fat.codusur = 1143 then  Round(sum(fatMagnatec.TOTPESO)/800*100,2)
    when fat.codusur = 1157 then  Round(sum(fatMagnatec.TOTPESO)/50*100,2)
    when fat.codusur = 1269 then  Round(sum(fatMagnatec.TOTPESO)/90*100,2)
    when fat.codusur = 1379 then  Round(sum(fatMagnatec.TOTPESO)/600*100,2)
    else 0 end "%Litros MAG"

, inad."Meta %Inadimplência" 
, inad.VLRECEBER As "Inadimplência"
, inad.VLTITULOS As "TotalTitulos"

, case when inad.VLRECEBER>0 then round(inad.VLRECEBER/inad.VLTITULOS * 100,2) else 100  end "% Inadimplência"
, case when inad.VLRECEBER>0 and round(inad.VLRECEBER/inad.VLTITULOS * 100,2) >= 100  then   Round(sum(fat.vlvenda)* 1/100,2)
       when inad.VLRECEBER=0                                                          then   Round(sum(fat.vlvenda)* 1/100,2) else 0 end "%INADIMPLÊNCIA (1,00%)"

--, Round(sum(fat.vlvenda)* 1/100 +  sum(fat.vlvenda)* 0.25/100 + round(sum(fatMagnatec.VLVENDA)*0.75,2),2) As "ComissãoTotal"
--, Round(sum(fat.vlvenda)* 1/100 +  sum(fat.vlvenda)* 0.25/100 + round(sum(fatMagnatec.VLVENDA)*0.75,2)/sum(fat.vlvenda),2) As "%_ComissãoTotal"

from (
 SELECT 
 
 PCNFSAID.CODUSUR  CODUSUR, 
       PCUSUARI.NOME, 

 sum(CASE WHEN NVL(PCMOVCOMPLE.VLSUBTOTITEM,0) <> 0 THEN  
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
             2) END) AS VLVENDA                                               
                                                                           


, sum(ROUND( (NVL(PCPRODUT.PESOBRUTO,PCMOV.PESOBRUTO) * NVL(PCMOV.QT, 0)),2)) AS TOTPESO

-----------------------------------------------------------------------------------------------------



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
                 AND PCNFSAID.CODUSUR in (1139,1140,1141,1143,1157,1269,1379)

group by
PCNFSAID.CODUSUR, 
       PCUSUARI.NOME
                 ) fat,


/*


--------------------------------------------------------------------------------------------------
------------------------------------Faturamento MagnaTec


Divisão de Tabelas


*/


(
 SELECT 
 
 PCNFSAID.CODUSUR  CODUSUR, 
       PCUSUARI.NOME, 

 sum(CASE WHEN NVL(PCMOVCOMPLE.VLSUBTOTITEM,0) <> 0 THEN  
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
             2) END) AS VLVENDA                                               
                                                                           


, sum(ROUND( (NVL(PCPRODUT.PESOBRUTO,PCMOV.PESOBRUTO) * NVL(PCMOV.QT, 0)),2)) AS TOTPESO

-----------------------------------------------------------------------------------------------------



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
   AND PCPRODUT.CODMARCA = 67 -- MAGNATEC
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
                 AND PCNFSAID.CODUSUR in (1139,1140,1141,1143,1157,1269,1379)

group by
PCNFSAID.CODUSUR, 
       PCUSUARI.NOME
                 ) fatMagnatec,


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
       SUM(TOTAL.DIASATRASO) MEDIAATRASO,  
       1 As "Meta %Inadimplência"          
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


) inad

where fat.codusur = fatMagnatec.codusur
and fat.codusur = inad.codusur


group by 
fat.codusur
, fat.NOME
, inad.VLRECEBER
, inad.VLTITULOS
, inad."Meta %Inadimplência"

) base