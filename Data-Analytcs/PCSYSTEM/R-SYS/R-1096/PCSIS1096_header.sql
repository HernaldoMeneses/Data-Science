
SELECT 
TAB2.DATA_,
TAB2.Codfornec,
pcfornec.fornecedor,
TAB2.numnota,
TAB2.codpart,
TAB2.PARTICIPANTE,
TAB2.CODPROD,
       TAB2.DESCRICAO,
       TAB2.UNIDADE,
       TAB2.IMPORTADO,
       SUM(TAB2.QTCONT)*SUM(TAB2.VLITEM) As VLTOTal,
       SUM(TAB2.QTCONT) QTCONT,
       SUM(TAB2.VLITEM) VLITEM,
       SUM(TAB2.VLCONTABIL) VLCONTABIL,
       SUM(TAB2.VLBASEPISCOFINS) VLBASEPISCOFINS,
       SUM(TAB2.VLNAOTRIBUTADO) VLNAOTRIBUTADO,
       SUM(TAB2.VLPIS) VLPIS,
       SUM(TAB2.VLCOFINS) VLCOFINS,
       SUM(TAB2.VLDESCONTO) VLDESCONTO
FROM (
SELECT
TAB1.DATA_,
TAB1.Codfornec, 
Tab1.NUMNOTA,
Tab1.codpart,
Tab1.PARTICIPANTE,
TAB1.CODPROD,
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
SELECT
DATA_,
CODfornec, 
NUMNOTA,
codpart,
PARTICIPANTE,
CODPROD,
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
       ENTSAI.DATA_,
       ENTSAI.CODFORNEC, 
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
       N.DTENT DATA_,
       p.codfornec,
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
-- Union All 01
UNION ALL
-------------------------------------------------------------
SELECT DECODE(N.UF, 'EX', '', N.CGC) CGC,
       N.ESPECIE,
       N.SERIE,
       N.DTENT DATA_,
        p.codfornec,
       N.CONSUMIDORFINAL,
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
       ------------------------------------------------------
       ROUND(M.QTCONT * DECODE(NVL(PARAMFILIAL.OBTERCOMOVARCHAR2('PRECOUTILIZADONFE', NVL(N.CODFILIALNF, N.CODFILIAL)), 'B'), 
'B',
             DECODE(NVL(N.VLDESCONTO, 0), 0, 0, NVL(M.VLDESCONTO, 0)), 0),2) VLDESCONTO,
       ------------------------------------------------------
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
             - NVL(M.VLIPI, 0) - NVL(M.ST, 0) + NVL(M.VLOUTRASDESP,0)),2) 
             + ROUND(M.QTCONT * (GREATEST(NVL(M.VLDESCONTO,0) - (DECODE(NVL(PARAMFILIAL.OBTERCOMOVARCHAR2('PRECOUTILIZADONFE',
COALESCE(N.CODFILIALNF,N.CODFILIAL)),'B'),'B',0,NVL(M.VLDESCONTO,0))),0)) ,2) 
        VLITEM, 
       ------------------------------------------------------
       ROUND(M.QTCONT * (M.PUNITCONT + 
             (CASE WHEN N.DESPESASRATEADA = 'S' THEN 
                 NVL(M.VLFRETE,0) + NVL(M.VLOUTROS,0) 
              ELSE 
                 0 
              END)) 
             , 2) VLCONTABIL, 
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
and    P.CODPROD = M.CODPROD
and    MC.NUMTRANSITEM(+) = M.NUMTRANSITEM
and    N.TIPODESCARGA IN ('6', 'T', '8', 'N', 'F')
and    NVL(N.MODELO, 'X') NOT IN ('6', '06', '21', '22', '28', '29', '3', '03')
and    N.ESPECIE = 'NF'
and    ROUND(M.QTCONT * (M.PUNITCONT - NVL(M.ST,0) - NVL(M.VLIPI,0)),2) > 0
and    M.QTCONT > 0
and    M.DTCANCEL is null
and    M.STATUS in ('A', 'AB')
-- UNION ALL 1 END


-------------------------------------------------------------
-- Union All 02
UNION ALL
-------------------------------------------------------------
SELECT DECODE(N.UF, 'EX', '', N.CGC) CGC,
       N.ESPECIE,
       N.SERIE,
       N.DTENT DATA_,
        p.codfornec,
       N.CONSUMIDORFINAL,
       N.TIPODESCARGA,
       N.NUMTRANSENT TRANSACAO,
       N.NUMNOTA,
       N.VLTOTAL,
       NVL(N.CODFORNECNF, N.CODFORNEC) CODPART,
       N.FORNECEDOR PARTICIPANTE,
       NVL(N.CODFILIALNF, N.CODFILIAL) CODFILIAL,
       M.CODSITTRIBPISCOFINS,
       M.CODFISCAL,
       DECODE(DECODE(MC.USAPISCOFINSLIT, 'S', NVL(MC.QTLITRAGEM,P.LITRAGEM),0), 0, NVL(M.PERPIS,0), NVL(M.VLCREDPIS,0)) PERPIS,
       DECODE(DECODE(MC.USAPISCOFINSLIT, 'S', NVL(MC.QTLITRAGEM,P.LITRAGEM),0), 0, NVL(M.PERCOFINS,0), NVL(M.VLCREDCOFINS,0)) 
PERCOFINS,
       ------------------------------------------------------
       ROUND(DECODE(DECODE(MC.USAPISCOFINSLIT, 'S', NVL(MC.QTLITRAGEM,P.LITRAGEM),0),
                    0, M.QTCONT * NVL(M.VLCREDPIS,0),
                    M.QTCONT * NVL(MC.QTLITRAGEM,P.LITRAGEM) * NVL(M.VLCREDPIS, 0)), 2) VLPIS,
       ------------------------------------------------------
       ROUND(DECODE(DECODE(MC.USAPISCOFINSLIT, 'S', NVL(MC.QTLITRAGEM,P.LITRAGEM),0),
                    0, M.QTCONT * NVL(M.VLCREDCOFINS, 0),
                    M.QTCONT * NVL(MC.QTLITRAGEM,P.LITRAGEM) * NVL(M.VLCREDCOFINS, 0)), 2) VLCOFINS,
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
       ------------------------------------------------------
       ROUND(M.QTCONT * DECODE(NVL(PARAMFILIAL.OBTERCOMOVARCHAR2('PRECOUTILIZADONFE', NVL(N.CODFILIALNF, N.CODFILIAL)), 'B'), 
'B',
             DECODE(NVL(N.VLDESCONTO, 0), 0, 0, NVL(M.VLDESCONTO, 0)), 0),2) VLDESCONTO,
       ------------------------------------------------------
       DECODE(MC.Usapiscofinslit, 'S', NVL(MC.QTLITRAGEM,P.LITRAGEM),0) QTLITRAGEM,
       ------------------------------------------------------
       ROUND(DECODE(DECODE(MC.Usapiscofinslit, 'S', NVL(MC.QTLITRAGEM,P.LITRAGEM),0),
                    0, M.QTCONT * NVL(M.VLBASEPISCOFINS, 0),
                    M.QTCONT * NVL(MC.QTLITRAGEM,P.LITRAGEM) * DECODE(NVL(M.VLCREDPIS,0), 0, 0, 1)), 2) VLBASEPISCOFINS,
       ------------------------------------------------------
       ROUND(M.QTCONT * NVL(M.PUNITCONT,0), 2) VLITEM, 
       ------------------------------------------------------
       ROUND(M.QTCONT * (NVL(M.PUNITCONT,0) + 
             (CASE WHEN N.DESPESASRATEADA = 'S' THEN 
                 NVL(M.VLFRETE,0) + NVL(M.VLOUTROS,0) 
              ELSE 
                 0 
              END)), 2) VLCONTABIL, 
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
WHERE N.NUMTRANSENT = M.NUMTRANSENT
  AND N.NUMNOTA = M.NUMNOTA
  AND P.CODPROD = M.CODPROD
  AND MC.NUMTRANSITEM(+) = M.NUMTRANSITEM
  AND N.TIPODESCARGA IN ('C','6','T','8')
  AND NVL(N.MODELO, 'X') NOT IN ('6', '06', '21', '22', '28', '29', '3', '03')
  AND N.ESPECIE = 'NF'
  AND M.QTCONT > 0 
  AND NVL(M.PUNITCONT,0) = 0 
  AND NVL(N.VLTOTAL,0) = 0 
  AND (DECODE(DECODE(MC.USAPISCOFINSLIT, 'S', NVL(MC.QTLITRAGEM,P.LITRAGEM),0), 0, NVL(M.PERPIS,0), NVL(M.VLCREDPIS,0)) > 0 
   OR  DECODE(DECODE(MC.USAPISCOFINSLIT, 'S', NVL(MC.QTLITRAGEM,P.LITRAGEM),0), 0, NVL(M.PERCOFINS,0), NVL(M.VLCREDCOFINS,0)) > 
0 
   OR  (NVL(M.ST,0) + NVL(M.VLDESPADICIONAL,0)) > 0 
   OR  ((NVL(M.BASEICMS,0) + NVL(MC.VLBASEFRETE,0) + NVL(MC.VLBASEOUTROS,0)) * NVL(M.PERCICM,0) / 100) > 0) 
  AND M.DTCANCEL IS NULL 
  AND M.STATUS in ('A', 'AB') 

  --END UNION All 2

-------------------------------------------------------------
-- Union All 03
UNION ALL
-------------------------------------------------------------
SELECT N.CGC,
       N.ESPECIE,
       N.SERIE,
       N.DTENT DATA_,
        p.codfornec,
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
       NVL(M.PERPIS,0) PERPIS,
       NVL(M.PERCOFINS,0) PERCOFINS,
       ROUND(M.QTCONT * NVL(M.VLPIS, 0),2) VLPIS,
       ROUND(M.QTCONT * NVL(M.VLCOFINS, 0),2) VLCOFINS,
       NVL(M.VLPIS, 0) VLPIS_UNITARIO,
       NVL(M.VLCOFINS, 0) VLCOFINS_UNITARIO,
       TO_NUMBER('1' || TO_CHAR(M.CODPROD, 'FM000000')) CODPROD,
       NULL CODINTERNO,
       P.IMPORTADO,
       P.DESCRICAO,
       'UN' UNIDADE,
       P.CODNCM NBM,
       M.QTCONT,
       P.EXTIPI,
       ROUND(M.QTCONT * NVL(M.VLDESCONTO, 0),2) VLDESCONTO,
       0 QTLITRAGEM,
       ROUND(M.QTCONT * NVL(M.VLBASEPISCOFINS, 0),2) VLBASEPISCOFINS,
       ROUND(M.VLITEM,2) VLITEM, 
       ROUND(NVL(M.VLITEM,0),2) VLCONTABIL, 
       N.NUMDIIMPORTACAO, 
       NULL NUMDRAWBACK, 
       0 VLPISIMP,
       0 VLCOFINSIMP, 
       N.MODELO, 
       N.CHAVENFE, 
       M.CODCEST, 
       NULL CAIXA, 
       NULL PRODDESCRICAOCONTRATO, 
       M.SITTRIBUT, 
       ROUND(M.QTCONT * (M.PUNITCONT + NVL(M.VLFRETE,0) + NVL(M.VLDESCONTO,0) + NVL(M.ST,0) + NVL(M.VLIPI,0)), 2) VLMERC, 
       ROUND(M.QTCONT * NVL(M.BASEICMS,0), 2) VLBASEICMS, 
       NVL(M.ALIQICMS1,0) PERCICMS, 
       ROUND(M.QTCONT * NVL(M.BASEICMS,0) * NVL(M.ALIQICMS1,0) / 100, 2) VLICMS, 
       M.CODCONTACONTSPED 
FROM   PCNFENT    N,
       PCMOVCIAP  M,
       PCPRODCIAP P 
WHERE  N.NUMTRANSENT = M.NUMTRANSENT 
and    N.NUMNOTA = M.NUMNOTA 
and    P.CODPROD = M.CODPROD 
and    N.TIPODESCARGA NOT IN ('6', 'T', '8', 'N', 'F') 
and    NVL(N.MODELO, 'X') NOT IN ('6', '06', '21', '22', '28', '29', '3', '03') 
and    N.ESPECIE = 'NF' 
and    ROUND(M.QTCONT * (M.PUNITCONT - NVL(M.VLDESCONTO,0)),2) > 0 
and    M.QTCONT > 0 

-- End Union all 3



-------------------------------------------------------------
-- Union All 04
UNION ALL 
-------------------------------------------------------------
--Documentos sem itens (Sem PCMOV e sem PCMOVCIAP 
SELECT NF.CGC, 
       NF.ESPECIE, 
       NF.SERIE, 
       NF.DTENT DATA_,
       000 codfornec, 
       'N' CONSUMIDORFINAL, 
       NF.TIPODESCARGA, 
       NF.NUMTRANSENT TRANSACAO, 
       NF.NUMNOTA, 
       NF.VLTOTAL, 
       NVL(NF.CODFORNECNF, NF.CODFORNEC) CODPART, 
       NF.FORNECEDOR PARTICIPANTE, 
       NVL(NF.CODFILIALNF, NF.CODFILIAL) CODFILIAL, 
       ------------------------------------------------------
       NVL((SELECT MAX(PC.CODTRIBPISCOFINS) 
              FROM PCNFENTPISCOFINS PC 
              WHERE PC.NUMTRANSENT = B.NUMTRANSENT 
                AND PC.NUMTRANSPISCOFINS = B.NUMTRANSPISCOFINS), 
             NVL(NF.CODTRIBPISCOFINS,'70')) CODSITTRIBPISCOFINS, 
       ------------------------------------------------------
       B.CODFISCAL, 
       ------------------------------------------------------
       NVL((SELECT NVL(MAX(PC.PERPIS),0) 
            FROM PCNFENTPISCOFINS PC 
            WHERE PC.NUMTRANSENT = B.NUMTRANSENT 
              AND PC.NUMTRANSPISCOFINS = B.NUMTRANSPISCOFINS), 
           NVL(NF.PERPIS,0)) PERPIS, 
       ------------------------------------------------------
       NVL((SELECT NVL(MAX(PC.PERCOFINS),0) 
            FROM PCNFENTPISCOFINS PC 
            WHERE PC.NUMTRANSENT = B.NUMTRANSENT 
              AND PC.NUMTRANSPISCOFINS = B.NUMTRANSPISCOFINS), 
           NVL(NF.PERCOFINS,0)) PERCOFINS, 
       ------------------------------------------------------
       ------------------------------------------------------
       ROUND(NVL((SELECT SUM(NVL(PC.VLPIS,0)) 
                  FROM PCNFENTPISCOFINS PC 
                  WHERE PC.NUMTRANSENT = B.NUMTRANSENT 
                    AND PC.NUMTRANSPISCOFINS = B.NUMTRANSPISCOFINS), 
                 NVL(NF.VLPIS,0)), 2) VLPIS, 
       ------------------------------------------------------
       ------------------------------------------------------
       ROUND(NVL((SELECT SUM(NVL(PC.VLCOFINS,0)) 
                  FROM PCNFENTPISCOFINS PC 
                  WHERE PC.NUMTRANSENT = B.NUMTRANSENT 
                    AND PC.NUMTRANSPISCOFINS = B.NUMTRANSPISCOFINS), 
                 NVL(NF.VLCOFINS,0)), 2) VLCOFINS, 
       ------------------------------------------------------
       ------------------------------------------------------
       ROUND(NVL((SELECT SUM(NVL(PC.VLPIS,0)) 
                  FROM PCNFENTPISCOFINS PC 
                  WHERE PC.NUMTRANSENT = B.NUMTRANSENT 
                    AND PC.NUMTRANSPISCOFINS = B.NUMTRANSPISCOFINS), 
                 NVL(NF.VLPIS,0)),2) VLPIS_UNITARIO, 
       ------------------------------------------------------
       ------------------------------------------------------
       ROUND(NVL((SELECT SUM(NVL(PC.VLCOFINS,0)) 
                  FROM PCNFENTPISCOFINS PC 
                  WHERE PC.NUMTRANSENT = B.NUMTRANSENT 
                    AND PC.NUMTRANSPISCOFINS = B.NUMTRANSPISCOFINS), 
                 NVL(NF.VLCOFINS,0)), 2) VLCOFINS_UNITARIO, 
       ------------------------------------------------------
       ------------------------------------------------------
       99999999 CODPROD, 
       NULL CODINTERNO, 
       'N' IMPORTADO, 
       'ITEM COMPLEMENTAR' DESCRICAO, 
       'UN' UNIDADE, 
       '00000000' NBM, 
       1 QTCONT, 
       NULL EXTIPI, 
       0 VLDESCONTO, 
       0 QTLITRAGEM, 
       ------------------------------------------------------
       ROUND(NVL((SELECT SUM(NVL(PC.VLBASEPIS,0)) 
                  FROM PCNFENTPISCOFINS PC 
                  WHERE PC.NUMTRANSENT = B.NUMTRANSENT 
                    AND PC.NUMTRANSPISCOFINS = B.NUMTRANSPISCOFINS), 
                 NVL(NVL(NF.VLBASEPIS,NF.VLBASECOFINS),0)), 2) VLBASEPISCOFINS, 
       ------------------------------------------------------
       SUM(NVL(B.VLCONTABIL,0)) VLITEM, 
       SUM(NVL(B.VLCONTABIL,0)) VLCONTABIL, 
       NF.NUMDIIMPORTACAO, 
       NULL NUMDRAWBACK, 
       0 VLPISIMP, 
       0 VLCOFINSIMP, 
       NF.MODELO, 
       NF.CHAVENFE, 
       NULL CODCEST, 
       NULL CAIXA, 
       NULL PRODDESCRICAOCONTRATO, 
       DECODE(NVL(B.TIPO,'1'), '1', B.SITTRIBUT, '90') SITTRIBUT, 
       SUM(NVL(B.VLCONTABIL,0)) VLMERC, 
       SUM(DECODE(NVL(B.TIPO,'1'), '1', NVL(B.VLBASE,0), 0)) VLBASEICMS, 
       DECODE(NVL(B.TIPO,'1'), '1', NVL(B.ALIQUOTA,0), 0) PERCICMS, 
       SUM(DECODE(NVL(B.TIPO,'1'), '1', NVL(B.VLICMS,0), 0)) VLICMS, 
       B.CODCONTACONTSPED 
FROM PCNFENT NF, 
     PCNFBASE B 
WHERE B.NUMTRANSENT = NF.NUMTRANSENT 
  AND B.CODCONT = NF.CODCONT 
  AND NF.ESPECIE = 'NF' 
  AND NF.VLTOTAL > 0 
  AND NVL(NF.MODELO,'X') NOT IN ('3','03','6','06','21','22','28','29') 
  AND NOT EXISTS (SELECT 1 
                  FROM PCMOV M1 
                  WHERE M1.NUMTRANSENT = NF.NUMTRANSENT 
                    AND M1.NUMNOTA = NF.NUMNOTA) 
  AND NOT EXISTS (SELECT 1 
                  FROM PCMOVCIAP C1 
                  WHERE C1.NUMTRANSENT = NF.NUMTRANSENT 
                    AND C1.NUMNOTA = NF.NUMNOTA) 
GROUP BY NVL(NF.CODFILIALNF, NF.CODFILIAL), NF.CGC, NF.DTENT,
         NF.TIPODESCARGA, NF.NUMTRANSENT, B.NUMTRANSENT, 
         NF.NUMNOTA, B.NUMTRANSPISCOFINS, 
         NF.VLTOTAL, NVL(NF.CODFORNECNF, NF.CODFORNEC), 
         NF.FORNECEDOR,NF.NUMDIIMPORTACAO, NF.CHAVENFE, 
         NF.CODCONT, NF.ESPECIE, NF.SERIE, NF.MODELO, 
         NF.CODTRIBPISCOFINS, NF.VLBASEPIS, NF.VLBASECOFINS, 
         NF.PERPIS, NF.PERCOFINS, NF.VLPIS, NF.VLCOFINS, 
         B.CODFISCAL, B.SITTRIBUT, NVL(B.ALIQUOTA,0), B.TIPO, B.CODCONTACONTSPED 
         
-- END UNION ALL 4


-------------------------------------------------------------
-- Union All 05
UNION ALL 
-------------------------------------------------------------
SELECT NF.CGC,
       N.ESPECIE,
       N.SERIE,
       N.DTENTRADA DATA_,
       000  codfornec,
       'N' CONSUMIDORFINAL,
       N.TIPODESCARGA,
       N.NUMTRANSENT TRANSACAO,
       N.NUMNOTA,
       N.VLTOTAL,
       N.CODFORNEC CODPART,
       N.FORNECEDOR PARTICIPANTE,
       N.CODFILIALNF CODFILIAL,
       NVL((SELECT MAX(CODSITTRIBPISCOFINS) FROM PCMOV WHERE NUMTRANSENT = NF.NUMTRANSENT AND NUMNOTA = NF.NUMNOTA), 70) 
CODSITTRIBPISCOFINS,
       N.CODFISCAL,
       0 PERPIS, 
       0 PERCOFINS, 
       0 VLPIS,
       0 VLCOFINS,
       0 VLPIS_UNITARIO,
       0 VLCOFINS_UNITARIO,
       88888888 CODPROD,
       NULL CODINTERNO,
       'N' IMPORTADO,
       'DESPESA ACESSORIA' DESCRICAO,
       'UN' UNIDADE,
       NULL NBM, 
       1 QTCONT, 
       NULL EXTIPI, 
       0 VLDESCONTO, 
       0 QTLITRAGEM,
       0 VLBASEPISCOFINS,
       N.VLOUTRASDESP VLITEM, 
       N.VLOUTRASDESP VLCONTABIL, 
       NULL NUMDIIMPORTACAO, 
       NULL NUMDRAWBACK, 
       0 VLPISIMP,
       0 VLCOFINSIMP, 
       NF.MODELO, 
       NF.CHAVENFE, 
       NULL CODCEST, 
       NULL CAIXA, 
       NULL PRODDESCRICAOCONTRATO, 
       N.SITTRIBUT, 
       NVL(N.VLDESDOBRADO,0) VLMERC, 
       NVL(N.VLBASE,0) VLBASEICMS, 
       NVL(N.PERCICM,0) PERCICMS, 
       NVL(N.VLICMS,0) VLICMS, 
       ------------------------------------------------------
       (SELECT MAX(NVL(PC.CODCONTACONTSPED,B.CODCONTACONTSPED)) 
        FROM PCNFENTPISCOFINS PC, 
             PCNFBASE B 
        WHERE PC.NUMTRANSENT = B.NUMTRANSENT 
          AND PC.NUMTRANSPISCOFINS = B.NUMTRANSPISCOFINS 
          AND B.NUMTRANSENT = NF.NUMTRANSENT 
          AND B.CODCONT = NF.CODCONT 
          AND B.CODFISCAL = N.CODFISCAL 
       ) CODCONTACONTSPED 
       ------------------------------------------------------
FROM   PCNFBASEENT N,
       PCNFENT NF
WHERE  N.NUMTRANSENT = NF.NUMTRANSENT
and    N.NUMNOTA = NF.NUMNOTA
and    NF.ESPECIE = N.ESPECIE
and    N.ESPECIE = 'NF'
and    N.VLOUTRASDESP > 0
and    NVL(NF.DESPESASRATEADA,'N') = 'N'
and    (NF.CHAVENFE is null AND NVL(NF.MODELO,'X') <> '55')
and    NVL(NF.MODELO,'X') NOT IN ('3', '03', '6', '06', '21', '22', '28', '29')
AND    NVL((select max(P.UTILIZAOUTRASDESPCALCICMS) 
    from   PCPEDIDO P,  
           PCMOV    M  
    where  M.NUMTRANSENT = NF.NUMTRANSENT 
    and    P.NUMPED = M.NUMPED 
    and    ROWNUM = 1), 
    'N')  = 'N'  

    --- END UNION ALL 5

-------------------------------------------------------------
-- Union All 06
UNION ALL 
-------------------------------------------------------------
SELECT NF.CGC,
       N.ESPECIE,
       N.SERIE,
       N.DTENTRADA DATA_,
       000 codfornec,
       'N' CONSUMIDORFINAL,
       N.TIPODESCARGA,
       N.NUMTRANSENT TRANSACAO,
       N.NUMNOTA,
       N.VLTOTAL,
       N.CODFORNEC CODPART,
       N.FORNECEDOR PARTICIPANTE,
       N.CODFILIALNF CODFILIAL,
       NVL((SELECT MAX(CODSITTRIBPISCOFINS) FROM PCMOV WHERE NUMTRANSENT = NF.NUMTRANSENT AND NUMNOTA = NF.NUMNOTA), 70) 
CODSITTRIBPISCOFINS,
       N.CODFISCAL,
       0 PERPIS, 
       0 PERCOFINS, 
       0 VLPIS,
       0 VLCOFINS,
       0 VLPIS_UNITARIO,
       0 VLCOFINS_UNITARIO,
       77777777 CODPROD,
       NULL CODINTERNO,
       'N' IMPORTADO,
       'FRETE' DESCRICAO,
       'UN' UNIDADE,
       NULL NBM, 
       1 QTCONT, 
       NULL EXTIPI, 
       0 VLDESCONTO, 
       0 QTLITRAGEM,
       0 VLBASEPISCOFINS,
       N.VLFRETE VLITEM, 
       N.VLFRETE VLCONTABIL, 
       NULL NUMDIIMPORTACAO, 
       NULL NUMDRAWBACK, 
       0 VLPISIMP,
       0 VLCOFINSIMP, 
       NF.MODELO, 
       NF.CHAVENFE, 
       NULL CODCEST, 
       NULL CAIXA, 
       NULL PRODDESCRICAOCONTRATO, 
       N.SITTRIBUT, 
       NVL(N.VLDESDOBRADO,0) VLMERC, 
       NVL(N.VLBASE,0) VLBASEICMS, 
       NVL(N.PERCICM,0) PERCICMS, 
       NVL(N.VLICMS,0) VLICMS, 
       ------------------------------------------------------
       (SELECT MAX(NVL(PC.CODCONTACONTSPED,B.CODCONTACONTSPED)) 
        FROM PCNFENTPISCOFINS PC, 
             PCNFBASE B 
        WHERE PC.NUMTRANSENT = B.NUMTRANSENT 
          AND PC.NUMTRANSPISCOFINS = B.NUMTRANSPISCOFINS 
          AND B.NUMTRANSENT = NF.NUMTRANSENT 
          AND B.CODCONT = NF.CODCONT 
          AND B.CODFISCAL = N.CODFISCAL 
       ) CODCONTACONTSPED 
       ------------------------------------------------------
FROM   PCNFBASEENT N,
       PCNFENT NF 
WHERE  N.NUMTRANSENT = NF.NUMTRANSENT 
and    N.NUMNOTA = NF.NUMNOTA 
and    NF.ESPECIE = N.ESPECIE 
and    N.ESPECIE = 'NF' 
and    N.VLFRETE > 0 
and    NVL(NF.DESPESASRATEADA,'N') = 'N'
and    (NF.CHAVENFE is null AND NVL(NF.MODELO,'X') <> '55') 
and    NVL(NF.MODELO,'X') NOT IN ('3', '03', '6', '06', '21', '22', '28', '29') 
and    NVL(NF.DESPESASRATEADA, 'N') = 'N' 
AND    NVL((select max(P.UTILIZAFRETECALCICMS) 
    from   PCPEDIDO P,  
           PCMOV    M  
    where  M.NUMTRANSENT = NF.NUMTRANSENT 
    and    P.NUMPED = M.NUMPED 
    and    ROWNUM = 1), 
    'N')  = 'N'  


) ENTSAI
 WHERE 0 = 0 
 AND ENTSAI.CODFISCAL IN (1949)
 --AND ENTSAI.CODFISCAL IN (:codfiscal)
 --And ENTSAI.CODPART in (910)
 --And ENTSAI.CODPART in (:CODFORNEC)
 And ENTSAI.CODfornec in (:CODFORNEC)
AND ENTSAI.DATa_ >= to_date(:datai,'dd/mm/yyyy')  AND ENTSAI.DATa_ <= to_date(:dataf,'dd/mm/yyyy')
) 
group by
DATA_,
codfornec,
NUMNOTA,
codpart,
PARTICIPANTE,
CODPROD,
       DESCRICAO,
       UNIDADE,
       IMPORTADO
) tab1 ) tab2, PcFornec
where tab2.codfornec = pcfornec.codfornec
Group by
TAB2.DATA_,
tab2.codfornec,
pcfornec.fornecedor,
TAB2.numnota,
TAB2.codpart,
TAB2.PARTICIPANTE,
TAB2.CODPROD,
       TAB2.DESCRICAO,
       TAB2.UNIDADE,
       TAB2.IMPORTADO

Order by
TAB2.DATA_,
tab2.codfornec,
pcfornec.fornecedor,
TAB2.numnota,
TAB2.codpart,
TAB2.PARTICIPANTE,
TAB2.CODPROD,
       TAB2.DESCRICAO,
       TAB2.UNIDADE,
       TAB2.IMPORTADO