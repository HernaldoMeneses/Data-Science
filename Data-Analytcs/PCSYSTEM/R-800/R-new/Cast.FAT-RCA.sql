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
    when pcpedi.codusur = 1169 then 3500
    when pcpedi.codusur = 1179 then 1500
    else 0 end "MGL - Nov"



,       SUM(ROUND(NVL(PCPRODUT.PESOBRUTO,0)*NVL(PCPEDI.QT,0),2)) AS TOTPESO
--,       COUNT(DISTINCT(PCPEDC.CODCLI)) AS QTCLIPOS,
--,       SUM(ROUND(NVL(PCPEDI.QT,0)*NVL(PCPEDI.VLCUSTOFIN,0),2)) AS VLCUSTOFIN,
--,  ((SUM(ROUND(NVL(PCPEDI.QT,0)*(NVL(PCPEDI.PVENDA, 0) + NVL(PCPEDI.VLOUTRASDESP, 0) + NVL(PCPEDI.VLFRETE, 0)),2))
--  -  SUM(ROUND(NVL(PCPEDI.QT,0)*NVL(PCPEDI.VLCUSTOFIN,0),2))) /  decode(SUM(ROUND(NVL(PCPEDI.QT,0)*NVL(PCPEDI.PVENDA,0),2)),0,1,
--SUM(ROUND(NVL(PCPEDI.QT,0)*NVL(PCPEDI.PVENDA,0),2))) * 100 ) as clPERLUC


, case 
    when pcpedi.codusur = 1139 then 800
    when pcpedi.codusur = 1140 then 600
    when pcpedi.codusur = 1141 then 500
    when pcpedi.codusur = 1143 then 1000
    when pcpedi.codusur = 1157 then 100
    when pcpedi.codusur = 1169 then 600
    when pcpedi.codusur = 1179 then 700
    else 0 end "MML - Nov"
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
--AND PCPEDC.NUMPED >= (SELECT MIN(NUMPED) FROM PCPEDC)
--AND PCPEDI.CODPROD >= (SELECT MIN(CODPROD) FROM PCPEDI)

Group By pcpedi.codusur
, pcusuari.NOME

Order by pcpedi.codusur
, pcusuari.NOME
