----------------------------------
Timestamp: 18:07:56.311
SELECT CODFISCAL,
             DESCCFO,
             CODOPER
FROM PCCFO
WHERE CODFISCAL BETWEEN 1000 AND 3999
 AND TO_CHAR(CODFISCAL) = :PARAM1
PARAM1 = '1949'
----------------------------------
Timestamp: 18:08:07.997
SELECT TRUNC(SYSDATE)
  FROM DUAL
----------------------------------
Timestamp: 18:08:08.022
SELECT CODFISCAL,
             DESCCFO,
             CODOPER
FROM PCCFO
WHERE CODFISCAL BETWEEN 1000 AND 3999
 AND TO_CHAR(CODFISCAL) = :PARAM1
PARAM1 = '1949'
----------------------------------
Timestamp: 18:08:21.251
SELECT TAB2.CODPROD,
       TAB2.DESCRICAO,
       TAB2.UNIDADE,
       TAB2.IMPORTADO,
       SUM(TAB2.QTCONT) QTCONT,
       SUM(TAB2.VLITEM) VLITEM,
       SUM(TAB2.VLCONTABIL) VLCONTABIL,
       SUM(TAB2.VLBASEPISCOFINS) VLBASEPISCOFINS,
       SUM(TAB2.VLNAOTRIBUTADO) VLNAOTRIBUTADO,
       SUM(TAB2.VLPIS) VLPIS,
       SUM(TAB2.VLCOFINS) VLCOFINS,
       SUM(TAB2.VLDESCONTO) VLDESCONTO
FROM (
SELECT TAB1.CODPROD,
       (SELECT P.DESCRICAO FROM PCPRODUT P WHERE P.CODPROD = TAB1.CODPROD) DESCRICAO,
       (SELECT P.UNIDADE   FROM PCPRODUT P WHERE P.CODPROD = TAB1.CODPROD) UNIDADE,
       (SELECT P.IMPORTADO FROM PCPRODUT P WHERE P.CODPROD = TAB1.CODPROD) IMPORTADO,
       TAB1.QTCONT,
       TAB1.VLITEM,
       TAB1.VLCONTABIL,
       TAB1.VLBASEPISCOFINS,
       TAB1.VLNAOTRIBUTADO,
       TAB1.VLPIS,
       TAB1.VLCOFINS,
       TAB1.VLDESCONTO
FROM (
SELECT CODPROD,
       DESCRICAO,
       UNIDADE,
       IMPORTADO, 
       SUM(QTCONT) QTCONT, 
       SUM(NVL(VLITEM,0)) VLITEM, 
       SUM(NVL(VLCONTABIL,0)) VLCONTABIL, 
       SUM(NVL(VLBASEPISCOFINS,0)) VLBASEPISCOFINS, 
       SUM(NVL(VLNAOTRIBUTADO,0)) VLNAOTRIBUTADO, 
       SUM(NVL(VLPIS,0)) VLPIS, 
       SUM(NVL(VLCOFINS,0)) VLCOFINS, 
       SUM(NVL(VLDESCONTO,0)) VLDESCONTO 
FROM (
-- Dados de Entradas ou Saídas 
---------------------------------------------------------------------------------------------- 
SELECT ENTSAI.NUMNOTA, 
       ENTSAI.SERIE, 
       ENTSAI.CODFILIAL, 
       ENTSAI.DATA, 
       ENTSAI.VLTOTAL, 
       TO_CHAR(ENTSAI.CODPART) CODPART, 
       ENTSAI.PARTICIPANTE, 
       ENTSAI.CODSITTRIBPISCOFINS, 
       ENTSAI.CODFISCAL, 
       ENTSAI.IMPORTADO, 
       ENTSAI.UNIDADE, 
       ENTSAI.CODPROD, 
       ENTSAI.DESCRICAO, 
       ENTSAI.NBM NCM, 
       ENTSAI.PERPIS, 
       ENTSAI.PERCOFINS, 
       ENTSAI.QTCONT * DECODE(ENTSAI.QTLITRAGEM, 0, 1, ENTSAI.QTLITRAGEM) QTCONT, 
       NVL(ENTSAI.VLITEM,0) VLITEM, 
       NVL(ENTSAI.VLCONTABIL,0) VLCONTABIL, 
       NVL(ENTSAI.VLBASEPISCOFINS,0) VLBASEPISCOFINS, 
       GREATEST( NVL(ENTSAI.VLCONTABIL,0) - NVL(ENTSAI.VLBASEPISCOFINS,0), 0) VLNAOTRIBUTADO, 
       ROUND(NVL(ENTSAI.VLPIS,0),2) VLPIS, 
       ROUND(NVL(ENTSAI.VLCOFINS,0),2) VLCOFINS, 
       NVL(ENTSAI.VLDESCONTO,0) VLDESCONTO, 
       ENTSAI.CAIXA 
FROM (
 -- Dados de Entradas 
SELECT N.CGC,
       N.ESPECIE,
       N.SERIE,
       N.DTENT DATA,
       'N' CONSUMIDORFINAL,
       N.TIPODESCARGA,
       N.NUMTRANSENT TRANSACAO,
       N.NUMNOTA,
       N.VLTOTAL,
       NVL(N.CODFORNECNF, N.CODFORNEC) CODPART,
       N.FORNECEDOR PARTICIPANTE,
       NVL(N.CODFILIALNF, N.CODFILIAL) CODFILIAL,
       M.CODSITTRIBPISCOFINS,
       M.CODFISCAL,
       DECODE(DECODE(MC.Usapiscofinslit, 'S', NVL(MC.QTLITRAGEM,P.LITRAGEM),0), 0, NVL(M.PERPIS,0), NVL(M.VLCREDPIS,0)) PERPIS,
       DECODE(DECODE(MC.Usapiscofinslit, 'S', NVL(MC.QTLITRAGEM,P.LITRAGEM),0), 0, NVL(M.PERCOFINS,0), NVL(M.VLCREDCOFINS,0)) 
PERCOFINS,
       ------------------------------------------------------
       ROUND(
       DECODE(DECODE(MC.Usapiscofinslit, 'S', NVL(MC.QTLITRAGEM,P.LITRAGEM),0),
              0,
              M.QTCONT * NVL(M.VLCREDPIS, 0),
              M.QTCONT * NVL(MC.QTLITRAGEM,P.LITRAGEM) * NVL(M.VLCREDPIS, 0)),
              2) VLPIS,
       ------------------------------------------------------
       ROUND(
       DECODE(DECODE(MC.Usapiscofinslit, 'S', NVL(MC.QTLITRAGEM,P.LITRAGEM),0),
              0,
              M.QTCONT * NVL(M.VLCREDCOFINS, 0),
              M.QTCONT * NVL(MC.QTLITRAGEM,P.LITRAGEM) * NVL(M.VLCREDCOFINS, 0)),
              2) VLCOFINS,
       ------------------------------------------------------
       NVL(M.VLCREDPIS, 0) VLPIS_UNITARIO,
       NVL(M.VLCREDCOFINS, 0) VLCOFINS_UNITARIO,
       M.CODPROD,
       M.CODINTERNO,
       NVL(M.IMPORTADO, P.IMPORTADO) IMPORTADO,
       NVL(MC.DESCRICAONFE, P.DESCRICAO) AS DESCRICAO,  
       DECODE(NVL(P.FATORCONVTRIB,0), 0, P.UNIDADE, NVL(P.UNIDADETRIB, P.UNIDADE)) UNIDADE,
       NVL(M.NBM,P.NBM) NBM,
       M.QTCONT * DECODE(NVL(P.FATORCONVTRIB,0), 0, 1, P.FATORCONVTRIB) QTCONT,
       NVL(MC.EXTIPI,P.EXTIPI) EXTIPI,
       ROUND(M.QTCONT * DECODE(NVL(N.VLDESCONTO, 0), 0, 0, NVL(M.VLDESCONTO, 0)),2) VLDESCONTO,
       DECODE(MC.Usapiscofinslit, 'S', NVL(MC.QTLITRAGEM,P.LITRAGEM),0) QTLITRAGEM,
       ------------------------------------------------------
       ROUND(
       DECODE(DECODE(MC.Usapiscofinslit, 'S', NVL(MC.QTLITRAGEM,P.LITRAGEM),0),
              0,
              M.QTCONT * NVL(M.VLBASEPISCOFINS, 0),
              M.QTCONT * NVL(MC.QTLITRAGEM,P.LITRAGEM) * DECODE(NVL(M.VLCREDPIS,0), 0, 0, 1)),
              2) VLBASEPISCOFINS,
       ------------------------------------------------------
       ROUND(M.QTCONT * (M.PUNITCONT 
                         - NVL(M.VLDESCONTO, 0)
        + DECODE(M.CALCCREDIPI, 'S', 0, NVL(M.VLIPI, 0))  
        + DECODE(N.AGREGASTVLMERC, 'S', NVL(M.ST, 0), 0) 
        + DECODE(NVL(MC.VLBASEFCPST,0), 0, 0, NVL(MC.VLFECP,0))), 2) VLITEM, 
       ------------------------------------------------------
       (ROUND(M.QTCONT * M.PUNITCONT,2) - 
        ROUND(M.QTCONT * NVL(MC.VLICMSDESONERACAO,0), 2) - 
        ROUND(M.QTCONT * NVL(M.VLDESCONTO,0), 2) + 
        ROUND(M.QTCONT * NVL(M.ST,0), 2) + 
        ROUND(M.QTCONT * DECODE(NVL(MC.VLBASEFCPST,0), 0, 0, NVL(MC.VLFECP,0)), 2) + 
        ROUND(M.QTCONT * NVL(M.VLIPI,0),2) - 
        ROUND(M.QTCONT * NVL(M.VLSUFRAMA,0),2) + 
        ROUND(M.QTCONT * 
              (CASE WHEN N.CHAVENFE IS null AND NVL(N.MODELO,'X') <> '55' THEN 
                  0 
               ELSE  
                  NVL(M.VLFRETE,0) + NVL(M.VLOUTRASDESP,0) 
               END) 
              , 2)) VLCONTABIL, 
       ------------------------------------------------------
       N.NUMDIIMPORTACAO, 
       MC.NUMDRAWBACK, 
       ------------------------------------------------------
       CASE WHEN N.TIPODESCARGA in ('F', 'N') THEN
                 ROUND(M.QTCONT * NVL(M.VLCREDPIS, 0),2)
            ELSE 
                 0 
       END VLPISIMP,
       ------------------------------------------------------
       CASE WHEN N.TIPODESCARGA in ('F', 'N') THEN
                 ROUND(M.QTCONT * NVL(M.VLCREDCOFINS, 0),2)
            ELSE 
                 0 
       END VLCOFINSIMP, 
       ------------------------------------------------------
       N.MODELO, 
       N.CHAVENFE, 
       MC.CODCEST, 
       NULL CAIXA, 
       M.PRODDESCRICAOCONTRATO, 
       M.SITTRIBUT, 
       ROUND(M.QTCONT * (M.PUNITCONT + NVL(M.VLFRETE,0) + NVL(M.VLDESPADICIONAL,0) + NVL(M.ST,0) + NVL(M.VLDESPADICIONAL,0) + 
DECODE(NVL(M.CALCCREDIPI,'N'), 'N', NVL(M.VLIPI,0), 0)), 2) VLMERC, 
       ROUND(M.QTCONT * (NVL(M.BASEICMS,0) + NVL(MC.VLBASEFRETE,0) + NVL(MC.VLBASEOUTROS,0)), 2) VLBASEICMS, 
       NVL(M.PERCICM,0) PERCICMS, 
       ROUND(M.QTCONT * (NVL(M.BASEICMS,0) + NVL(MC.VLBASEFRETE,0) + NVL(MC.VLBASEOUTROS,0)) * NVL(M.PERCICM,0) / 100, 2) VLICMS, 
       MC.CODCONTACONTSPED 
FROM   PCNFENT    N,
       PCMOV      M,
       PCPRODUT   P,
       PCMOVCOMPLE MC
WHERE  N.NUMTRANSENT = M.NUMTRANSENT
and    N.NUMNOTA = M.NUMNOTA
and    N.NUMNOTA = M.NUMNOTA
and    P.CODPROD = M.CODPROD
and    MC.NUMTRANSITEM(+) = M.NUMTRANSITEM
and    N.ESPECIE = 'NF' 
and    N.TIPODESCARGA NOT IN ('6', 'T', '8', 'N', 'F')
and    DECODE( N.TIPODESCARGA , 'G', 1, ROUND(M.QTCONT * (M.PUNITCONT - NVL(M.VLDESCONTO, 0)),2)) > 0
and    NVL(N.MODELO, 'X') NOT IN ('6', '06', '21', '22', '28', '29', '3', '03')
and    M.QTCONT > 0
and    M.DTCANCEL is null
and    M.STATUS in ('A', 'AB')
-------------------------------------------------------------
UNION ALL
-------------------------------------------------------------
