select  MainTabFat.*,  pcfornec.fornecedor, pcprodut.DESCRICAO As DescricaoProduto from (
SELECT 
 to_date(A.DTMOV,'dd/mm/yyyy') As Data
, substr(to_char(A.DTMOV),1,2) as dia
, substr(to_char(A.DTMOV),4,2) as mes
, substr(to_char(A.DTMOV),7,4) as ano

, A.CODCLI
, A.NUMNOTA
, A.CODFORNEC
, A.CODPROD
, A.CODFISCAL
--, A.QT
, A.QTCONT
, Round(A.PUNITCONT,2) AS PUNID
--, A.QT * A.PUNITCONT AS TOTAL
 

, Round((CASE WHEN (('1' IN ('CF','CP','SF')) OR (SUBSTR(SA.CHAVENFE,21,2) = '65')) THEN 
        ROUND(NVL(C.VLSUBTOTITEM,0),2) 
      WHEN (SA.TIPOVENDA = 'DF' OR A.CODOPER = 'SD') THEN 
        CASE WHEN SA.ROTINACAD NOT LIKE '%1302%' THEN 
          ROUND(A.QTCONT * (NVL(A.PUNITCONT, 0) - NVL(A.VLFRETE, 0)), 2)
        ELSE
          ROUND(A.QTCONT *  NVL(A.PTABELA,0),2)
          - ROUND(A.QTCONT * NVL(A.VLDESCONTO,0), 2) 
          - ROUND(A.QTCONT * NVL(A.VLSUFRAMA,0), 2) 
          - ROUND(A.QTCONT * NVL(C.VLICMSDESONERACAO,0), 2) 
          + ROUND(A.QTCONT * NVL(A.VLFRETE,0), 2) 
          + ROUND(A.QTCONT * NVL(A.VLDESPDENTRONF,0), 2) 
          + ROUND(A.QTCONT * NVL(A.VLSEGURO,0), 2) 
          + ROUND(A.QTCONT * NVL(C.VLFECP,0), 2) 
          + ROUND(A.QTCONT * DECODE(NVL(C.VLIPIDEVFORNEC,0),0,NVL (A.VLIPI, 0),NVL(C.VLIPIDEVFORNEC,0)), 2) 
          + ROUND(A.QTCONT * DECODE(NVL(C.VLSTDEVFORNEC,0),0,NVL (A.ST, 0),NVL(C.VLSTDEVFORNEC,0)), 2) 
        END 
      ELSE 
        ROUND(A.QTCONT * (NVL(A.PUNITCONT,0) - NVL(A.ST,0) - NVL(A.VLIPI,0) - NVL(C.VLIPIDEVFORNEC,0)), 2) + 
        ROUND((NVL(A.QTCONT,0) * NVL(A.ST,0)), 2) + 
        ROUND((NVL(A.QTCONT,0) * NVL(A.VLIPI,0)), 2) + 
        ROUND((NVL(A.QTCONT,0) * NVL(A.VLOUTROS,0)), 2) + 
        ROUND((NVL(A.QTCONT,0) * NVL(C.VLIPIDEVFORNEC,0)), 2) + 
        ROUND((NVL(A.QTCONT,0) * NVL(A.VLFRETE,0)), 2) 
      END),2) VLTOTAL

--, A.QTCONT *  A.PUNITCONT AS VLTOTAL
, A.RoTinalanc
, A.CODFUNCLANC
, A.FUNCLANC
FROM PCMOV A,
     PCNFSAID SA, 
     PCMOVCOMPLE C
WHERE 
   A.NUMTRANSITEM = C.NUMTRANSITEM(+) 
  AND A.NUMTRANSVENDA = SA.NUMTRANSVENDA 
  --AND A.NUMNOTA = 9681
  AND A.NUMTRANSVENDA > 0
  AND A.STATUS <> 'B'
 -- AND A.CODFISCAL = 5927
   -- And A.NUMNOTA = 3432366
    --AND  A.DTMOV >= to_date('01/09/2023','dd/mm/yyyy')
  --AND  A.DTMOV < to_date('01/10/2023','dd/mm/yyyy')

AND A.CODFISCAL =  :CODFISCAL

--AND DTMOV >= To_date('01/01/2023','dd/mm/yyyy')
AND A.DTMOV >= To_date(:Data_init,'dd/mm/yyyy')
AND A.DTMOV <= To_date(:Data_final,'dd/mm/yyyy')


ORDER BY  A.DTMOV, A.NUMNOTA, A.CODPROD
) MainTabFat, pcfornec, pcprodut

where MainTabFat.codfornec = pcfornec.codfornec
and MainTabFat.codprod = pcprodut.codprod