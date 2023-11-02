----------------------------------
Timestamp: 10:07:55.036
SELECT C.CODCLI,
       C.CLIENTE,
       P.NUMREGIAO,
       C.CODUSUR1,
       C.TIPOFJ,
       PERACRESTRANSF,
       NVL(C.TIPOCUSTOTRANSF, 'F') TIPOCUSTOTRANSF,
       C.CODPRACA,
       C.TIPOEMPRESA,
       C.CONSUMIDORFINAL,
       C.ESTENT,
       C.UTILIZAIESIMPLIFICADA,
       C.IEENT,
       NVL(C.ISENTOICMS, 'N') ISENTOICMS,
       NVL(C.CALCULAST, 'N') CALCULAST,
       NVL(C.CLIENTEFONTEST, 'N') CLIENTEFONTEST,
       NVL(C.CONTRIBUINTE, 'N') CONTRIBUINTE
  FROM PCCLIENT C, PCPRACA P
 WHERE C.CODPRACA = P.CODPRACA
   AND C.DTBLOQ IS NULL
 AND TO_CHAR(C.CODCLI) = :PARAM1
PARAM1 = '101003'
----------------------------------
Timestamp: 10:07:55.116
SELECT C.CODCLI,
       C.CLIENTE,
       P.NUMREGIAO,
       C.CODUSUR1,
       C.TIPOFJ,
       PERACRESTRANSF,
       NVL(C.TIPOCUSTOTRANSF, 'F') TIPOCUSTOTRANSF,
       C.CODPRACA,
       C.TIPOEMPRESA,
       C.ESTENT,
       C.UTILIZAIESIMPLIFICADA,
       C.IEENT,
       NVL(C.ISENTOICMS, 'N') ISENTOICMS,
       NVL(C.CALCULAST, 'N') CALCULAST,
       NVL(C.CLIENTEFONTEST, 'N') CLIENTEFONTEST,
       NVL(C.CONTRIBUINTE, 'N') CONTRIBUINTE,
       NVL(C.SIMPLESNACIONAL,'N') SIMPLESNACIONAL,
       NVL(C.CONSUMIDORFINAL,'N') CONSUMIDORFINAL,
       NVL(C.PARTICIPAFUNCEP, 'N') PARTICIPAFUNCEP,       
       (DECODE(C.IEENT, NULL,     'S',
                        'ISENTA', 'S',
                        'ISENTO', 'S',
                        'N')) AS IE_ISENTO
  FROM PCCLIENT C, PCPRACA P
 WHERE C.CODPRACA = P.CODPRACA
   AND C.CODCLI = :CODCLI
   AND C.DTBLOQ IS NULL
CODCLI = 101003
----------------------------------
Timestamp: 10:07:55.201
SELECT PCTABPRCLI.CODFILIALNF,
       PCTABPRCLI.NUMREGIAO,
       PCREGIAO.PERFRETE
FROM   PCTABPRCLI, PCREGIAO, PCFILIAL
WHERE  PCTABPRCLI.CODCLI = :CODCLI
AND    PCTABPRCLI.NUMREGIAO = PCREGIAO.NUMREGIAO
AND    PCTABPRCLI.CODFILIALNF = PCFILIAL.CODIGO
AND    PCTABPRCLI.CODFILIALNF = :CODFILIALNF
CODCLI = 101003
CODFILIALNF = '2'
----------------------------------
Timestamp: 10:07:55.247
SELECT C.CODCLI,
       C.CLIENTE,
       P.NUMREGIAO,
       C.CODUSUR1,
       C.TIPOFJ,
       PERACRESTRANSF,
       NVL(C.TIPOCUSTOTRANSF, 'F') TIPOCUSTOTRANSF,
       C.CODPRACA,
       C.TIPOEMPRESA,
       C.CONSUMIDORFINAL,
       C.ESTENT,
       C.UTILIZAIESIMPLIFICADA,
       C.IEENT,
       NVL(C.ISENTOICMS, 'N') ISENTOICMS,
       NVL(C.CALCULAST, 'N') CALCULAST,
       NVL(C.CLIENTEFONTEST, 'N') CLIENTEFONTEST,
       NVL(C.CONTRIBUINTE, 'N') CONTRIBUINTE
  FROM PCCLIENT C, PCPRACA P
 WHERE C.CODPRACA = P.CODPRACA
   AND C.DTBLOQ IS NULL
 AND TO_CHAR(C.CODCLI) = :PARAM1
PARAM1 = '101003'
----------------------------------
Timestamp: 10:08:05.788
SELECT CODFORNEC,
       FORNECEDOR
  FROM PCFORNEC
WHERE NVL(REVENDA,'S') = 'S'
 AND TO_CHAR(CODFORNEC) = :PARAM1
PARAM1 = '1214'
----------------------------------
Timestamp: 10:08:09.240
SELECT PCPRODUT.CODPROD, 
       PCPRODUT.DESCRICAO,
       PCPRODUT.EMBALAGEM, 
       PCPRODUT.UNIDADE,
       PCPRODUT.UNIDADEMASTER,
       PCPRODUT.QTUNITCX, 
       PCPRODUT.CODEPTO,
       PCPRODUT.CODFORNEC,
       PCPRODUT.CODSEC,
       NVL(PCPRODUT.ESTOQUEPORLOTE,'N') ESTOQUEPORLOTE,
       NVL(PCPRODUT.VLPAUTAIPI,0) VLPAUTAIPI,
       NVL(PCPRODUT.VLPAUTAIPIVENDA,0) VLPAUTAIPIVENDA,
       NVL(PCPRODUT.VLIPIPORKGVENDA,0) VLIPIPORKGVENDA,
       NVL(PCPRODUT.PERCIPIVENDA,0) PERCIPIVENDA,
       NVL(PCPRODUT.PESOBRUTO,0) PESOBRUTO,
       NVL(PCPRODUT.PERPIS,0) PERPIS,
       NVL(PCPRODUT.PERCOFINS,0) PERCOFINS,
       PCPRODUT.TIPOMERC AS TIPOMERCADORIA,
       NVL(PCPRODFILIAL.ACEITAVENDAFRACAO,'S') ACEITAVENDAFRACAO, 
       NVL(PCPRODFILIAL.MULTIPLO,1) MULTIPLO,
       NVL(PCPRODFILIAL.CALCULAIPI,(SELECT NVL(PCPARAMFILIAL.VALOR,'N') FROM PCPARAMFILIAL WHERE NOME LIKE 
'FIL_CALCULARIPIVENDA%' AND CODFILIAL = '2')) CALCULAIPI,
       PCDEPTO.TIPOMERC
FROM PCPRODUT, PCDEPTO, PCPRODFILIAL
 WHERE NVL(TRIM(PCPRODUT.OBS),'*') <> 'EQ'
   AND PCPRODUT.CODEPTO = PCDEPTO.CODEPTO
   AND PCPRODUT.CODPROD = PCPRODFILIAL.CODPROD
AND PCPRODUT.CODFORNEC = 1214
AND PCPRODUT.CODPROD IN (SELECT PCEST.CODPROD FROM PCEST
                WHERE PCEST.CODPROD = PCPRODUT.CODPROD
                      AND PCEST.CODFILIAL = '2'
                      AND  ( NVL(PCEST.QTESTGER,0) - 
                             NVL(PCEST.QTRESERV,0) - 
                             NVL(PCEST.QTBLOQUEADA,0) ) > 0 )
 AND PCPRODFILIAL.CODFILIAL = '2'