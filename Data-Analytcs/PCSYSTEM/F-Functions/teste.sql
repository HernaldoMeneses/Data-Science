  select --case when count(*)>0 then sum(perc_meta)/count(*) 
         --else 0 end
       sum(perc_meta)/count(*) 
        --sum(perc_meta)
       into
       V_RETORNO
       from
      (
SELECT DISTINCT 
       PCPRODUT.CODFORNEC, 
       PCFORNEC.FORNECEDOR,
       NVL(VENDAS.PVENDA,0) PVENDA,
       NVL(METAS.VLMETA,0) VLMETA,
       case when NVL(METAS.VLMETA,0)=0 then 0
           else 
       round((NVL(VENDAS.PVENDA,0)/NVL(METAS.VLMETA,0)*100),2) end perc_meta,
       NVL(VENDAS.QTCLIPOS,0) QTCLIPOS,
       NVL(METAS.CLIPOSPREV,0) CLIPOSPREV,
       case when NVL(METAS.CLIPOSPREV,0)=0 then 0 
            else 
       round((NVL(VENDAS.QTCLIPOS,0)/NVL(METAS.CLIPOSPREV,0)*100),2) end perc_pos
FROM PCPRODUT, PCFORNEC,
( 
/* SQL UTILIZADO PELA ROTINA PCSIS322 RELATORIO(S) - 4 */ SELECT 
       PCPRODUT.CODFORNEC, 
       COUNT(DISTINCT(PCPEDC.CODCLI)) QTCLIPOS,
       SUM(ROUND(NVL(PCPEDI.QT,0)*NVL(PCPEDI.PVENDA,0),2)) PVENDA,
       SUM(PCPEDI.QT) QT,
       SUM(ROUND(NVL(PCPRODUT.PESOBRUTO,0)*NVL(PCPEDI.QT,0),2)) AS TOTPESO,
       SUM(NVL(PCPEDI.QT,0) / DECODE(NVL(PCPRODUT.QTUNIT,0),0,1,NVL(PCPRODUT.QTUNIT,1))) TOTQTUNIT,
       SUM(NVL(PCPEDI.QT,0) / DECODE(NVL(PCPRODUT.QTUNITCX,0),0,1,NVL(PCPRODUT.QTUNITCX,1))) TOTQTUNITCX,
       ROUND(SUM(NVL(PCPRODUT.VOLUME,0)*NVL(PCPEDI.QT,0)) ,2) Volume,
       ROUND(SUM(NVL(PCPRODUT.LITRAGEM, 0)*NVL(PCPEDI.QT,0)) ,2) LITRAGEM,
       COUNT(DISTINCT(PCPEDC.NUMPED)) AS QTPEDIDO,
       COUNT(DISTINCT(PCPEDI.CODPROD)) AS QTMIX,
       COUNT(PCPEDI.CODPROD) NUMITENS,
MAX((/* SQL UTILIZADO PELA ROTINA PCSIS322 RELATORIO(S) - 4 */ SELECT COUNT(P.CODPROD) FROM PCPRODUT P,PCDEPTO D WHERE P.CODEPTO = D.CODEPTO
   AND P.CODFORNEC = PCFORNEC.CODFORNEC
   AND NVL(P.OBS2,'  ') <> ('FL'))) AS QTMIXCAD
FROM PCPEDI, PCPEDC, PCPRODUT, PCFORNEC, PCDEPTO, PCCLIENT,
     PCUSUARI, PCATIVI, PCPRACA, PCCIDADE
WHERE PCPEDI.NUMPED = PCPEDC.NUMPED
AND PCUSUARI.CODSUPERVISOR NOT IN ('9999')
AND PCPEDC.DATA BETWEEN P_DATA_INI AND P_DATA_FIM
AND PCPEDC.CODFILIAL IN (P_FILIAL)
AND PCPEDC.CODUSUR IN (P_RCA)
AND PCPEDC.CONDVENDA IN (1, 2, 3, 7, 9, 14, 15, 17, 18, 19, 98)

--AND PCPRODUT.CODFORNEC IN (/* SQL UTILIZADO PELA ROTINA PCSIS322 PARA TODOS RELATORIO(S) */ SELECT CODIGON FROM PCLIB WHERE CODFUNC = 1 AND CODTABELA = 3)

AND PCCLIENT.CODCIDADE = PCCIDADE.CODCIDADE(+)
AND PCPEDC.CODCLI = PCCLIENT.CODCLI(+)
AND PCCLIENT.CODATV1 = PCATIVI.CODATIV(+)
AND PCPEDC.DTCANCEL IS NULL
AND PCPEDI.CODPROD = PCPRODUT.CODPROD(+)
AND PCPRODUT.CODEPTO = PCDEPTO.CODEPTO(+)
and nvl(PCCLIENT.Codrede,99) not in (1,2)
AND PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC(+)
AND PCPEDC.CODUSUR = PCUSUARI.CODUSUR(+)
AND PCPEDC.CODPRACA = PCPRACA.CODPRACA(+)
GROUP BY  
PCPRODUT.CODFORNEC
) VENDAS,
( 
     SELECT PCMETA.CODIGO,
       SUM(NVL(PCMETA.VLVENDAPREV,0)) VLMETA,
       SUM(NVL(PCMETA.CLIPOSPREV,0)) CLIPOSPREV
  FROM PCMETA, PCUSUARI 
         ,PCFORNEC 
WHERE PCMETA.CODUSUR = PCUSUARI.CODUSUR
AND PCUSUARI.CODSUPERVISOR NOT IN ('9999')
         AND PCMETA.TIPOMETA = 'F'
         AND PCFORNEC.CODFORNEC = PCMETA.CODIGO
 AND PCMETA.DATA BETWEEN P_DATA_INI AND P_DATA_FIM
 AND PCMETA.CODFILIAL IN (P_FILIAL)
AND PCUSUARI.CODUSUR IN(P_RCA)
 
GROUP BY PCMETA.CODIGO
) METAS
WHERE 
 PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC(+)
AND PCPRODUT.CODFORNEC = VENDAS.CODFORNEC(+)
AND PCPRODUT.CODFORNEC = METAS.CODIGO(+)
--and PCFORNEC.Codfornec in (1214, 1468, 976, 1360, 2591, 390, 4)
and PCFORNEC.Codfornec in (select p.codfornec from pcfornec p where p.wn_rel8008='S')
AND NVL(METAS.VLMETA,0) +  NVL(METAS.CLIPOSPREV,0) > 0

--AND PCPRODUT.CODFORNEC IN (/* SQL UTILIZADO PELA ROTINA PCSIS322 PARA TODOS RELATORIO(S) */ SELECT CODIGON FROM PCLIB WHERE CODFUNC = 1 AND CODTABELA = 3)
  
ORDER BY NVL(VENDAS.PVENDA,0) DESC
)tab1
where NVL(tab1.VLMETA,0) > 0