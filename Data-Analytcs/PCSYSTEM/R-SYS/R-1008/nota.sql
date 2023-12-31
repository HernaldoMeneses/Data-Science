----------------------------------
Timestamp: 16:02:40.395
SELECT * FROM ( 
SELECT A.NUMTRANSVENDA,
       A.NUMTRANSVENDAORIGEM,
       A.NUMNOTA,
       A.SERIE,
       A.ESPECIE,
       A.CODFISCAL,
       A.VLTOTAL,
       A.DTENTREGA,
       A.DTSAIDA,
       A.ICMSRETIDO,
       A.BCST,
       DECODE(NVL(A.VLDESCONTO,0), 0, 
       (SELECT SUM(ROUND(M.QTCONT * NVL(M.VLDESCONTO, 0),2))
        FROM   PCMOV M
        WHERE  M.NUMNOTA = A.NUMNOTA
        AND    M.NUMTRANSVENDA = A.NUMTRANSVENDA
        AND    M.QTCONT > 0
        AND    M.DTCANCEL IS NULL), A.VLDESCONTO) VLDESCONTO,
       A.OBS,
       A.CODCLI,
       NVL(A.CODCLINF, A.CODCLI) CODCLINF,
       A.CLIENTE,
       A.UF,
       A.CGC,
       A.NUMPED,
       A.CODCONT,
       A.CODFILIAL,
       A.CODFILIALNF,
       A.VLIPI,
       A.VLBASEIPI,
       A.VLFRETE,
       A.VLOUTRASDESP,
       A.CODPRACA,
       A.CAIXA,
       A.CODUSUR,
       A.TIPOVENDA,
       A.NUMSERIEEQUIP,
       A.DTCANCEL,
       (SELECT SUM(ROUND(M.QTCONT * (M.PUNITCONT + NVL(M.VLOUTROS, 0)),2)) +
               NVL(A.VLFRETE, 0)
        FROM   PCMOV M
        WHERE  M.NUMNOTA = A.NUMNOTA
        AND    M.NUMTRANSVENDA = A.NUMTRANSVENDA
        AND    M.QTCONT > 0
        AND    M.DTCANCEL IS NULL) SOMA,
       (SELECT MAX(M.NUMNOTAENT)
        FROM   PCDEVFORNEC M
        WHERE  A.NUMTRANSVENDA = M.NUMTRANSVENDA) NFORIGEM,
       A.PERBASEREDOUTRASDESP,
       A.NUMIDF,
       A.NUMFORMULARIO,
       A.NSU,
       DECODE(A.CHAVENFE, NULL, 'N', 'S') POSSUICHAVE_NFE,
       A.AUTENTPGTOGNRE,
       A.BANCOPGTOGNRE,
       A.AGENCIAPGTOGNRE,
       A.SITUACAONFE,
       A.CHAVENFE,
       A.PROTOCOLONFE,
       M.DESCRICAO MENSAGEMNFE,
       A.CODREMETENTEFRETE,
       A.CODDESTINATARIOFRETE,
       A.OBSCONHECFRETE,
       A.IE,
       A.ENDERECO,
       A.BAIRRO,
       A.MUNICIPIO,
       A.CODMUNICIPIO,
       A.CODIBGE,
       A.CEP,
       A.TIPOFJ,
       A.ATACADISTA,
       A.TIPOEMPRESA,
       A.CONSUMIDORFINAL,
       A.TRANSPORTADORA,
       A.CGCFRETE,
       A.IEFRETE,
       A.UFFRETE,
       A.CODATV1,
       A.CODPAIS,
       A.DESCPAIS,
       A.CGCFILIAL,
       A.IEFILIAL,
       A.UFFILIAL,
       A.CODCONTCLI,
       A.AGREGARSTPRODSINTEGRA,
       A.TIPOALIQOUTRASDESP,
       A.IESUBSTTRIBUT,
       A.UFPLACAVEIC,
       A.PLACAVEIC,
       A.UFCODIGO,
       A.VLPAUTAFRETE,
       A.CLIENTEFONTEST,
       A.SULFRAMA,
       A.COBRANCA,
       A.CODFISCALFRETE,
       A.CODFISCALOUTRASDESP,
       A.PERCICMFRETE,
       A.ALIQICMOUTRASDESP,
       A.TIPOFRETE,
       A.FRETEDESPACHO,
       A.BCSTGNRE,
       A.ICMSRETIDOGNRE,
       A.TOTDIFALIQUOTAS,
       NVL(A.CONFERIDO,'N') CONFERIDO,
       A.VLPIS,
       A.VLCOFINS,
       A.VLBASEPISCOFINS,
       A.PERPIS,
       A.PERCOFINS,
       A.CODSITTRIBPISCOFINS,       
       A.SITDOC,
       NVL(A.FINALIDADENFE, 'O') FINALIDADENFE,
       A.EMAILDEST,
       A.TELEFONE,
       A.NUMENDERECO,
       A.CODFORNECFRETE,
       A.TIPOEMISSAO,
       A.NORMAREGESPECIAL,
       A.SITUACAOCTE,
       A.CHAVECTE,
       A.GERARBCRNFE,
       C.DESCRICAO MENSAGEMCTE,
       A.CSLLRETIDO,
       A.PISRETIDO,
       A.COFINSRETIDO,
       A.VLISS,
       A.RESPSEGURO,
       A.NOMESEGURADORA,
       A.NUMEROAPOLICE,
       A.NUMEROAVERBACAO, 
       A.NUMTRANSENTORIGEM, 
       A.CODPRODNFAJUSTE,
       A.DESCRICAOPRODNFAJUSTE,
       A.NCMNFAJUSTE,
       A.UNIDADENFAJUSTE, 
       A.VLTOTBRUTOPRODAJUSTE,  
       A.OBSNFAJUSTE,  
       A.CHAVESAT,
       A.DOCEMISSAO,
       A.SITUACAOSAT,
       DECODE(A.GERANFVENDA, 'N', DECODE(A.SITUACAONFE, 0, 'N'), NVL(A.EMISSNUMAUTOMATICO, 'S') )  EMISSNUMAUTOMATICO,
       A.AMBIENTENFE,
       A.CONTRIBUINTE,
       A.TIPODOCARRECGNRE,
       A.UFBENEFICIARIA,
       A.NUMDOCARREC,
       A.CODAUTENTICACAO,
       A.VLDOCARRECADACAO,
       A.DTVENCARREC,
       A.DTPAGARREC,
       A.CODMUNINICTE,
       A.CODMUNFIMCTE,
       NVL(A.IDTIPOPRESENCA, '9') IDTIPOPRESENCA,            
       'N' AS NOVOPROCESSO,
       A.ROTINACAD
FROM   PCNFSAID      A,
       PCMENSAGEMNFE M,
       PCMENSAGEMCTE C
WHERE  A.SITUACAONFE = M.CODMENSAGEM(+)
AND    A.SITUACAOCTE = C.CODMENSAGEM(+)
AND    NVL(A.CODFILIALNF, A.CODFILIAL) IN ('2')

  AND A.NUMNOTA BETWEEN :NUMNOTA1 AND :NUMNOTA2
  AND A.DTSAIDA >= (SELECT MIN(DTSAIDA) FROM PCNFSAID) 
  AND A.DTSAIDA >= (SELECT MIN(DTSAIDA) FROM PCNFSAID) 
UNION ALL
SELECT A.NUMTRANSVENDA,
       A.NUMTRANSVENDAORIGEM,
       A.NUMNOTA,
       A.SERIE,
       A.ESPECIE,
       A.CODFISCAL,
       A.VLTOTAL,
       A.DTENTREGA,
       A.DTSAIDA,
       A.ICMSRETIDO,
       A.BCST,
       DECODE(NVL(A.VLDESCONTO,0), 0, 
       (SELECT SUM(ROUND(M.QTCONT * NVL(M.VLDESCONTO, 0),2))
        FROM   PCMOV M
        WHERE  M.NUMNOTA = A.NUMNOTA
        AND    M.NUMTRANSVENDA = A.NUMTRANSVENDA
        AND    M.QTCONT > 0
        AND    M.DTCANCEL IS NULL), A.VLDESCONTO) VLDESCONTO,
       A.OBS,
       A.CODCLI,
       NVL(A.CODCLINF, A.CODCLI) CODCLINF,
       A.CLIENTE,
       A.UF,
       A.CGC,
       A.NUMPED,
       A.CODCONT,
       A.CODFILIAL,
       A.CODFILIALNF,
       A.VLIPI,
       A.VLBASEIPI,
       A.VLFRETE,
       A.VLOUTRASDESP,
       A.CODPRACA,
       A.CAIXA,
       A.CODUSUR,
       A.TIPOVENDA,
       A.NUMSERIEEQUIP,
       A.DTCANCEL,
       (SELECT SUM(ROUND(M.QTCONT * (M.PUNITCONT + NVL(M.VLOUTROS, 0)),2)) +
               NVL(A.VLFRETE, 0)
        FROM   PCMOV M
        WHERE  M.NUMNOTA = A.NUMNOTA
        AND    M.NUMTRANSVENDA = A.NUMTRANSVENDA
        AND    M.QTCONT > 0
        AND    M.DTCANCEL IS NULL) SOMA,
       (SELECT MAX(M.NUMNOTAENT)
        FROM   PCDEVFORNEC M
        WHERE  A.NUMTRANSVENDA = M.NUMTRANSVENDA) NFORIGEM,
       A.PERBASEREDOUTRASDESP,
       A.NUMIDF,
       A.NUMFORMULARIO,
       A.NSU,
       DECODE(A.CHAVENFE, NULL, 'N', 'S') POSSUICHAVE_NFE,
       A.AUTENTPGTOGNRE,
       A.BANCOPGTOGNRE,
       A.AGENCIAPGTOGNRE,
       A.SITUACAONFE,
       A.CHAVENFE,
       A.PROTOCOLONFE,
       M.DESCRICAO MENSAGEMNFE,
       A.CODREMETENTEFRETE,
       A.CODDESTINATARIOFRETE,
       A.OBSCONHECFRETE,
       A.IE,
       A.ENDERECO,
       A.BAIRRO,
       A.MUNICIPIO,
       A.CODMUNICIPIO,
       A.CODIBGE,
       A.CEP,
       A.TIPOFJ,
       A.ATACADISTA,
       A.TIPOEMPRESA,
       A.CONSUMIDORFINAL,
       A.TRANSPORTADORA,
       A.CGCFRETE,
       A.IEFRETE,
       A.UFFRETE,
       A.CODATV1,
       A.CODPAIS,
       A.DESCPAIS,
       A.CGCFILIAL,
       A.IEFILIAL,
       A.UFFILIAL,
       A.CODCONTCLI,
       A.AGREGARSTPRODSINTEGRA,
       A.TIPOALIQOUTRASDESP,
       A.IESUBSTTRIBUT,
       A.UFPLACAVEIC,
       A.PLACAVEIC,
       A.UFCODIGO,
       A.VLPAUTAFRETE,
       A.CLIENTEFONTEST,
       A.SULFRAMA,
       A.COBRANCA,
       A.CODFISCALFRETE,
       A.CODFISCALOUTRASDESP,
       A.PERCICMFRETE,
       A.ALIQICMOUTRASDESP,
       A.TIPOFRETE,
       A.FRETEDESPACHO,
       A.BCSTGNRE,
       A.ICMSRETIDOGNRE,
       A.TOTDIFALIQUOTAS,
       NVL(A.CONFERIDO,'N') CONFERIDO,
       A.VLPIS,
       A.VLCOFINS,
       A.VLBASEPISCOFINS,
       A.PERPIS,
       A.PERCOFINS,
       A.CODSITTRIBPISCOFINS,       
       A.SITDOC,
       NVL(A.FINALIDADENFE, 'O') FINALIDADENFE,
       A.EMAILDEST,
       A.TELEFONE,
       A.NUMENDERECO,
       A.CODFORNECFRETE,
       A.TIPOEMISSAO,
       A.NORMAREGESPECIAL,
       A.SITUACAOCTE,
       A.CHAVECTE,
       A.GERARBCRNFE,
       C.DESCRICAO MENSAGEMCTE,
       A.CSLLRETIDO,
       A.PISRETIDO,
       A.COFINSRETIDO,
       A.VLISS,
       A.RESPSEGURO,
       A.NOMESEGURADORA,
       A.NUMEROAPOLICE,
       A.NUMEROAVERBACAO, 
       A.NUMTRANSENTORIGEM, 
       A.CODPRODNFAJUSTE,
       A.DESCRICAOPRODNFAJUSTE,
       A.NCMNFAJUSTE,
       A.UNIDADENFAJUSTE, 
       A.VLTOTBRUTOPRODAJUSTE,  
       A.OBSNFAJUSTE,  
       A.CHAVESAT,
       A.DOCEMISSAO,
       A.SITUACAOSAT,
       NVL(A.EMISSNUMAUTOMATICO, 'S') EMISSNUMAUTOMATICO,
       A.AMBIENTENFE,
       A.CONTRIBUINTE,
       A.TIPODOCARRECGNRE,
       A.UFBENEFICIARIA,
       A.NUMDOCARREC,
       A.CODAUTENTICACAO,
       A.VLDOCARRECADACAO,
       A.DTVENCARREC,
       A.DTPAGARREC,
       A.CODMUNINICTE,
       A.CODMUNFIMCTE,       
       NVL(A.IDTIPOPRESENCA, '9') IDTIPOPRESENCA,
       'S' AS NOVOPROCESSO,
       A.ROTINACAD 
FROM   PCNFSAIDPREFAT A,
       PCMENSAGEMNFE M,
       PCMENSAGEMCTE C
WHERE  A.SITUACAONFE = M.CODMENSAGEM(+)
AND    A.SITUACAOCTE = C.CODMENSAGEM(+)
AND    NOT EXISTS(SELECT 1 FROM PCNFSAID WHERE PCNFSAID.NUMTRANSVENDA = A.NUMTRANSVENDA)
AND    NVL(A.CODFILIALNF, A.CODFILIAL) IN ('2')

  AND A.NUMNOTA BETWEEN :NUMNOTA1 AND :NUMNOTA2
  AND A.DTSAIDA >= (SELECT MIN(DTSAIDA) FROM PCNFSAIDPREFAT) 
  AND A.DTSAIDA >= (SELECT MIN(DTSAIDA) FROM PCNFSAIDPREFAT) 
 ) 
ORDER BY DTSAIDA, CODFILIAL, NUMNOTA, ESPECIE, SERIE
NUMNOTA1 = 9681
NUMNOTA2 = 9681