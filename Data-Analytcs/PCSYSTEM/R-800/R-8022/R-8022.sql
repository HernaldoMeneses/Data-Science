----------------------------------
Timestamp: 15:10:38.515
SELECT 
  CODRELATORIO,
  ORDEM,
  NOME,
  COMPONENTE,
  LEGENDA,
  VALOR,
  ITENS,
  CONSULTA,
  BUSCA,
  POSESQUERDA,
  TAMANHO,
  OBRIGATORIO
FROM
  PCPARAMETROS
WHERE
  CODRELATORIO = :CODRELATORIO
  AND ORDEM IS NOT NULL 
ORDER BY
  ORDEM, POSESQUERDA
CODRELATORIO = 8022
----------------------------------
Timestamp: 15:10:38.658
select 'HERNALDO'  USUARIO,
(SELECT fnc_dp_ret_dados_consulta((select listagg(pf.codigo, ',') WITHIN GROUP
(ORDER BY pf.codigo) codigo from pcfilial pf where pf.codigo in ('2')), 1) FROM DUAL) FILIAL,
to_date(:DATA_INI,'dd-mm-rrrr') data_ini,
to_date(:DATA_FIN,'dd-mm-rrrr') data_fin,
tab.rca cod_rca,
(select v.nome from pcusuari v where v.codusur=tab.rca) nome_rca,
(select v.comissaoservicoprestado from pcusuari v where v.codusur=tab.rca) margem_padrao,
tab.sup cod_sup,
(select s.nome from pcsuperv s where s.codsupervisor=tab.sup) nome_sup,
round(sum(tab.venda),2) venda,
round(sum(tab.venda_afat),2) venda_afat,
round(sum(tab.dev),2) dev,
round(sum(tab.venda) - sum(tab.dev),2) venda_liq,
round(sum(custofin),2) cmv,
--case when (sum(tab.venda)-sum(tab.dev))<= 0 then 0
--   else round((sum(tab.venda)-sum(tab.dev))-sum(custofin),2)
--      end vlr_lucro,
round((sum(tab.venda)-sum(tab.dev))-sum(custofin),2) vlr_lucro,
case when (sum(tab.venda))<= 0 then 0
else round((((sum(tab.venda)-sum(tab.dev))-sum(custofin))/(sum(tab.venda))*100),2)
end  per_lucro
from (



--pedido a faturar tipo 1
select p.CODUSUR rca,
p.CODSUPERVISOR sup,
sum(p.PVENDA) venda,

0 dev ,
SUM(P.VLCUSTOFIN) custofin ,
--(sum(p.vlcustofin)-(sum((select sum(pi.qt*nvl(pi.vlverbacmv,0))+sum(pi.qt*nvl(pi.vlrebaixacmv,0))+sum(pi.qt*nvl(pi.vlverbacmvcli,0)) from pcpedi pi where pi.numped=p.numped)))) custofin ,
0 venda_afat
from vw_vendaspedido_8022 p

where  TO_DATE(p.DATA, 'DD-MM-RRRR') between to_date(:DATA_INI,'dd-mm-rrrr') and to_date(:DATA_FIN,'dd-mm-rrrr')
--and p.DTCANCEL is null
and p.CODFILIAL='2'
and p.CODUSUR in ('740')
and p.CODSUPERVISOR in ('51')
--AND P.CONDVENDA IN (1)


group by p.CODUSUR, p.CODSUPERVISOR



) tab
group by tab.rca, tab.sup
order by sup,per_lucro desc
DATA_INI = '01/01/2024'
DATA_FIN = '31/01/2024'



-- Incluso Manualmente codigo da VW_VENDASPEDIDO_8022 para comparação By H.meneses
CREATE OR REPLACE VIEW VW_VENDASPEDIDO_8022 AS
SELECT PCPEDC.CODFILIAL
      ,PCPEDC.CODUSUR
      ,PCPEDC.DATA
      ,PCSUPERV.CODSUPERVISOR
      ,PCSUPERV.NOME
      ,PCCLIENT.TIPOFJ
      ,PCCLIENT.CODCLI
      ,PCCLIENT.CLIENTE
      ,PCCLIENT.FANTASIA
      ,PCCLIENT.CODATV1
      ,PCATIVI.CODATIV
      ,PCATIVI.RAMO
      ,PCPRODUT.CODPROD
      ,PCPRODUT.DESCRICAO
      ,PCPRODUT.UNIDADE
      ,PCPRODUT.CODFAB
      ,PCPRODUT.CODMARCA
      ,PCPRODUT.EMBALAGEM
       , round(DECODE(PCPEDC.CONDVENDA,5,0,6,0,11,0,12,0,NVL(PCPEDI.qt,0)*(NVL(PCPEDI.pvenda, 0) + nvl(pcpedi.vloutrasdesp,0) + nvl(pcpedi.vlfrete,0))),2)

       /*   ROUND(NVL(PCPEDI.QT,
                 0) * (NVL(PCPEDI.PVENDA, 0) + NVL(PCPEDI.VLOUTRASDESP, 0) + NVL(PCPEDI.VLFRETE, 0)),
             2)*/
             AS PVENDA
         ,round(DECODE(PCPEDC.CONDVENDA,1,0,NVL(PCPEDI.qt,0)*(NVL(PCPEDI.pvenda, 0) + nvl(pcpedi.vloutrasdesp,0) + nvl(pcpedi.vlfrete,0))),2)

       /*   ROUND(NVL(PCPEDI.QT,
                 0) * (NVL(PCPEDI.PVENDA, 0) + NVL(PCPEDI.VLOUTRASDESP, 0) + NVL(PCPEDI.VLFRETE, 0)),
             2)*/
             AS PVENDA_BNF
       ,ROUND(NVL(PCPEDI.QT,
                 0) * NVL(PCPEDI.PTABELA,
                          0),
             2) AS PTABELA
      ,ROUND(NVL(PCPRODUT.PESOBRUTO,
                 0) * NVL(PCPEDI.QT,
                          0),
             2) AS TOTPESOBRUTO
      ,ROUND(NVL(PCPRODUT.PESOLIQ,
                 0) * NVL(PCPEDI.QT,
                          0),
             2) AS TOTPESOLIQUIDO
      ,ROUND(NVL(PCPRODUT.VOLUME,
                 0) * NVL(PCPEDI.QT,
                          0),
             2) LITRAGEM
      ,ROUND(DECODE(NVL(PCPRODUT.QTUNIT,0),
                    0,
                    1,
                    PCPRODUT.QTUNIT) * NVL(PCPEDI.QT,
                             1),
             2) AS TOTQTUNIT
      ,NVL(PCPEDI.QT,
           0) / DECODE(NVL(PCPRODUT.QTUNITCX,0),
                       0,
                       1,
                       PCPRODUT.QTUNITCX) AS TOTQTUNITCX
      , (PCPEDI.qt)* DECODE(PCPEDC.CONDVENDA,11,0,6,0,12,0,5,0,NVL(PCPEDI.vlcustofin,0)) + (PCPEDI.qt)* DECODE(PCPEDC.CONDVENDA,5,NVL(NVL(PCPEDI.pvenda, 0),0),0)
     /* ,NVL(PCPEDI.QT,
           0) * NVL(PCPEDI.VLCUSTOFIN,
                    0)*/

                    AS VLCUSTOFIN
      ,PCPEDI.QT AS QT
      ,PCPRODUT.QTUNIT
      ,PCPRODUT.CODCATEGORIA
      ,PCCLIENT.CODCIDADE
      ,PCCLIENT.CODCLIPRINC
      ,PCDEPTO.CODEPTO
      ,PCFORNEC.CODFORNEC
      ,PCPRACA.CODPRACA
      ,PCPRODUT.CODPRODPRINC
      ,PCREGIAO.NUMREGIAO
      ,PCCLIENT.CODREDE
      ,PCPRODUT.CODSEC
      ,PCPRODUT.CODSUBCATEGORIA
      ,PCPEDC.POSICAO
      ,PCPRODUT.OBS2
      ,PCCLIENT.DTEXCLUSAO
      ,PCPRODUT.PESOBRUTO
      ,PCPEDC.NUMPED
      ,PCPEDC.VLATEND
      ,PCPEDC.ORIGEMPED
      ,PCPEDC.CONDVENDA
      ,PCPRODUT.CODDISTRIB
      ,PCSUPERV.CODGERENTE
      ,PCPLPAG.CODPLPAG
      ,COMPRADOR.MATRICULA MATRICULA_COMPRADOR
      ,EMITENTE.MATRICULA MATRICULA_EMITENTE
      ,(SELECT COUNT(P.CODPROD)
        FROM   PCPRODUT P
              ,PCDEPTO  D
        WHERE  P.CODEPTO = D.CODEPTO
        AND    P.CODFORNEC = PCFORNEC.CODFORNEC
        AND    NVL(P.OBS2,
                   ' ') <> ('FL')) AS QTMIXCAD
      ,DECODE(PCPEDI.CONDVENDA,
              5,
              NVL(PCPEDI.VLBONIFIC,
                  PCPEDI.PTABELA),
              6,
              NVL(PCPEDI.VLBONIFIC,
                  PCPEDI.PTABELA),
              11,
              NVL(PCPEDI.VLBONIFIC,
                  PCPEDI.PTABELA),
              12,
              NVL(PCPEDI.VLBONIFIC,
                  PCPEDI.PTABELA),
              0) AS VLBONIFIC
    , PCCLIENT.CODBAIRROCOB
    , PCCLIENT.CODBAIRROCOM
    , PCCLIENT.CODBAIRROENT
    , PCFORNEC.CODCOMPRADOR
    , PCPEDI.VLREPASSE
FROM   PCPEDI
      ,PCPEDC
      ,PCPRODUT
      ,PCFORNEC
      ,PCDEPTO
      ,PCCLIENT
      ,PCUSUARI
      ,PCATIVI
      ,PCPRACA
      ,PCCIDADE
      ,PCSUPERV
      ,PCDISTRIB
      ,PCREGIAO
      ,PCGERENTE
      ,PCEMPR COMPRADOR
      ,PCEMPR EMITENTE
      ,PCPLPAG
WHERE  PCPEDI.NUMPED = PCPEDC.NUMPED
AND    PCUSUARI.CODSUPERVISOR NOT IN ('9999')
AND    PCCLIENT.CODCIDADE = PCCIDADE.CODCIDADE(+)
AND    PCPEDC.CODCLI = PCCLIENT.CODCLI
AND    PCSUPERV.CODSUPERVISOR = PCPEDC.CODSUPERVISOR
AND    PCCLIENT.CODATV1 = PCATIVI.CODATIV(+)
AND    PCPEDC.DTCANCEL IS NULL
AND    PCPEDI.CODPROD = PCPRODUT.CODPROD
AND    PCPRODUT.CODEPTO = PCDEPTO.CODEPTO
AND    PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC
AND    PCPEDC.CODUSUR = PCUSUARI.CODUSUR
AND    PCPEDC.CODPRACA = PCPRACA.CODPRACA
AND    PCPEDC.CODPLPAG = PCPLPAG.CODPLPAG(+)
AND    PCPEDC.NUMREGIAO = PCREGIAO.NUMREGIAO(+)
AND    PCPEDC.CODEMITENTE = EMITENTE.MATRICULA(+)
AND    PCFORNEC.CODCOMPRADOR = COMPRADOR.MATRICULA(+)
AND    PCPRODUT.CODDISTRIB = PCDISTRIB.CODDISTRIB(+)
AND    PCSUPERV.CODGERENTE = PCGERENTE.CODGERENTE(+)
AND    PCPEDC.CONDVENDA IN (1, 2, 3, 7, 9, 14, 15, 17, 18, 19, 98, 5, 11);