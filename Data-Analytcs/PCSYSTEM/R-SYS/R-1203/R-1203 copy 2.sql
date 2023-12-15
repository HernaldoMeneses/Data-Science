SELECT NVL(DECODE((SELECT COUNT(1)
                    FROM PCPREST
                   WHERE PCPREST.NUMTRANSVENDA = P.NUMTRANSVENDA
                     AND PCPREST.PREST         = P.PREST
                     AND NVL(PCPREST.NUMTRANSVENDAST, 0) > 0),
                  0,
                 'N',
                 'S'),
          'N') TITULOST,
       P.CODCLI,
       C.CLIENTE,
       NVL(P.VALOR, 0) VALOR,
       /*NVL(P.VALORDESC, 0) VALORDESC,
       (P.VALOR + NVL(P.TXPERMPREVISTO, 0)) VALORCOMJURPREV,
       P.CODCOBBANCO,
       P.CODBANCO,
       P.CODBANCOCUSTODIA,
       */
       P.DTBAIXA,
       --P.ALINEA,
       P.DTVENC,
       NVL(P.VPAGO, 0) VPAGO,
       --P.DTEMISSAO,
       NVL(P.DTEMISSAOORIG, P.DTEMISSAO) DTEMISSAOORIG,
       --E.NOME,
       --P.NOSSONUMBCO,
       --P.CODPORTADOR,
       P.DUPLIC,
       --NVL(P.VLTXBOLETO, 0) VLTXBOLETO,
       P.DTPAG,
       P.STATUS,
       --P.OBS,
       --P.OBS2,
       --NVL(P.DTVENCORIG, P.DTVENC) DTVENCORIG,
       --P.TIPOPRORROG,
       P.NUMCAR,
       --NVL(P.CARTORIO,'N') CARTORIO,
       --NVL(P.PROTESTO,'N') PROTESTO,
      -- DECODE(LTRIM(RTRIM(C.ENDERCOB)),'O MESMO', C.TELENT, C.TELCOB) TELEFONE,
      -- TRUNC(SYSDATE) HOJE,
       P.PREST,
       P.CODFILIAL,
       P.CODCOB,
       P.CODUSUR,
       U.NOME NOMERCA,
       P.NUMTRANSVENDA
       --P.CODBAIXA,
       --P.NUMBANCO,
       --P.NUMAGENCIA,
       --P.NUMCHEQUE,
       --P.DTINCLUSAO,
       --P.CODFUNCINC
       /*
       NVL(P.VALORORIG, P.VALOR) VALORORIG,
       NVL(P.CODCOBORIG, P.CODCOB) CODCOBORIG,
       P.DTFECHA,
       B.BOLETO,
       P.CODBARRA,
       P.LINHADIG,
       P.CODBANCOCM,
       NVL(F.USADIAUTILFILIAL,'N') USADIAUTILFILIAL,
       P.DTULTALTER,
       P.CODFUNCULTALTER,
       C.CGCENT,
       P.OBSCUSTODIA,
       P.DTDESCONTADO,
       P.DTABERTURACONTA,
       P.DTESTORNO,
       NVL(P.TXPERM, 0) TXPERM,
       P.CODAGENTECOBRANCA,
       P.CODEMITENTEPEDIDO,
       NVL(P.VLROUTROSACRESC, 0) VLROUTROSACRESC,
       (SELECT E1.NOME
          FROM PCEMPR E1
         WHERE E1.MATRICULA = P.CODEMITENTEPEDIDO) NOMEEMITENTEPEDIDO,
       -------NOME AGENTE DE COBRANÇA-----------------------
       (SELECT PCEMPR.NOME
          FROM PCEMPR
         WHERE PCEMPR.MATRICULA = P.CODAGENTECOBRANCA) AS AGENTECOBRANCA,
       --------------NUMTRANSVENDA DO DESDOBRAMENTO-----------------
       (SELECT MAX(D.NUMTRANSVENDADEST)
          FROM PCDESD D
         WHERE D.NUMTRANSVENDADEST = P.NUMTRANSVENDA
           AND D.PRESTDEST = P.PREST) AS NUMTRANSVENDADEST,
       -------------------OCORRENCIA DE BAIXA É DE CARTÓRIO----------------
       NVL((SELECT NVL(OCORCARTORIO,'N')
             FROM PCOCORBC
            WHERE NUMBANCO = BA.NUMBANCO
              AND NUMEROS(CODOCORRENCIA) = P.CODOCORRBAIXA
              AND ROWNUM = 1),
          'N') OCORCARTORIO,
       ---------------------NOME DO FUNCIONARIO QUE FEZ A ULTIMA ALTERACAO NO TITULO-----------------
       (SELECT NOME FROM PCEMPR WHERE MATRICULA = P.CODFUNCULTALTER) CNOMEULT,
       ----------------------NOME DO FUNCIONÁRIO QUE FEZ A INCLUSÃO DO TITULO-----------------------
       (SELECT NOME FROM PCEMPR WHERE MATRICULA = P.CODFUNCINC) CNOMEINC,
       E.NOME NOMEUSUARIOEMISSAO,
       CASE NVL(B.CALCJUROSCOBRANCA,'N') --ANALISANDO SE UTILIZA TAXA CADASTRADA NA COBRANCA
         WHEN'S'THEN
          NVL(B.TXJUROS, 0) --SIM: ENTAO PEGA A TAXA DA COBRANCA
         WHEN'N'THEN
          CASE B.CODCOB --NAO: ANALISA O TIPO DA COBRANCA E OBTEM O VALOR DO PARAMETRO DA 132
            WHEN'DESD'THEN
             0
            WHEN'ESTR'THEN
             0
            WHEN'CANC'THEN
             0
            WHEN'CRED'THEN
             0
            WHEN'BNF'THEN
             0
            WHEN'BNFT'THEN
             0
            WHEN'BNFR'THEN
             0
            WHEN'BNTR'THEN
             0
            WHEN'BNRP'THEN
             0
            WHEN'DEVP'THEN
             0
            WHEN'DEVT'THEN
             0
            WHEN'TR'THEN
             0
            ELSE
             PARAMFILIAL.OBTERCOMONUMBER('CON_PERCJUROSMORA')
          END
         ELSE
          0
       END AS TXJUROS,
       C.DTCADASTRO,
       C.LIMCRED,
       C.CEPCOB,
       C.ESTCOB,
       C.MUNICCOB,
       C.FAXCLI,
       C.FAXCOM,
       C.IEENT,
       C.SITE,
       C.OBS,
       C.OBS2,
       C.OBS3,
       C.OBS4,
       C.OBS5,
       C.OBSERVACAO,
       C.OBS_ADIC,
       C.OBSCREDITO,
       DECODE(C.BLOQUEIO,'S', C.BLOQUEIO,'N') BLOQUEIO,
       C.CODUSUR1,
       (SELECT PCUSUARI.NOME
          FROM PCUSUARI
         WHERE PCUSUARI.CODUSUR = C.CODUSUR1) NOMECODUSUR1,
       C.CODUSUR2,
       (SELECT PCUSUARI.NOME
          FROM PCUSUARI
         WHERE PCUSUARI.CODUSUR = C.CODUSUR2) NOMECODUSUR2,
       S.NUMNOTA,
       S.DTSAIDA,
       S.DTENTREGA,
       S.TIPOVENDA,
       S.CODFILIAL,
       -----NOME DE UM DOS CONTATOS DO CLIENTE---------------
       (SELECT NOMECONTATO
          FROM PCCONTATO
         WHERE CODCLI = C.CODCLI
           AND ROWNUM = 1) NOMECONTATO,
       ------------------EMAIL DO CONTATO-------------------
       (SELECT EMAIL
          FROM PCCONTATO
         WHERE CODCLI = C.CODCLI
           AND ROWNUM = 1) EMAIL,
       ------------ULTIMO CLIENTE A REALIZAR ALTERACAO NO CLIENTE PELA ROTINA 302---------
       (SELECT MATRICULA
          FROM PCLOGALTCLI
         WHERE UPPER(ROTINA) ='302 - CAD CLIENTE
        '
           AND CODCLI = C.CODCLI
           AND DTALTERACAO =
               (SELECT MAX(DTALTERACAO)
                  FROM PCLOGALTCLI
                 WHERE UPPER(ROTINA) ='302 - CAD CLIENTE'
                   AND CODCLI = C.CODCLI)
           AND ROWNUM = 1) MATRICULA,
       ------------DATA DA ULTIMA ALTERACAO NO CLIENTE PELA ROTINA 302---------
       (SELECT MAX(DTALTERACAO)
          FROM PCLOGALTCLI
         WHERE UPPER(ROTINA) ='302 - CAD CLIENTE'
           AND CODCLI = C.CODCLI) DTALTERACAO,
       ----------------DIAS DE ATRASO NO TITULO-------------------------
       NVL(F_QTDIASVENCIDOS(TRUNC(CASE WHEN P.DTRECEBIMENTOPREVISTO IS NULL THEN P.DTVENC 
                            WHEN TRUNC(P.DTRECEBIMENTOPREVISTO) > TRUNC(SYSDATE) OR       
                                 TRUNC(P.DTRECEBIMENTOPREVISTO) > TRUNC(P.DTVENC)         
                            THEN P.DTRECEBIMENTOPREVISTO ELSE P.DTVENC END),              
                            NVL(DTPAG, TRUNC(SYSDATE)),
                            P.CODCOB,
                            P.CODFILIAL,
                            NVL(F.USADIAUTILFILIAL,'N'),
                            :RETORNARNEGATIVO),
           0) ATRASO,
       -----------------DIAS DE ATRASO ORIG NO TITULO--------------------
       NVL(F_QTDIASVENCIDOS(P.DTVENCORIG,
                            NVL(DTPAG, TRUNC(SYSDATE)),
                            P.CODCOB,
                            P.CODFILIAL,
                            NVL(F.USADIAUTILFILIAL,'N'),
                            :RETORNARNEGATIVO),
           0) ATRASOORIG,
       ---------------------SALDO DO TITULO-----------------------------
       DECODE(P.DTPAG,
              NULL,
              0,
              ((NVL(P.VALOR, 0) + NVL(P.TXPERM, 0)) - (NVL(P.VPAGO, 0)))) SALDO,
       -----------------------------QUANTIDADE DE DIAS PARA VENCER O TITULO EM ABERTO -----
       DECODE(P.DTPAG,
              NULL,
              NVL(P.DTVENC, P.DTVENCORIG) - TRUNC(SYSDATE),
              0) DIASAVENCER,
       ------------------------PRAZO PARA PAGAMENTO------------------
       (NVL(P.DTVENCORIG, P.DTVENC) - P.DTEMISSAO) CLPRAZO,
       P.NUMTRANSVENDA || P.PREST NUMTRANSVENDAPREST,
       -------------------------------DESDOBRADO----------------------
       DECODE((SELECT MAX(D.NUMTRANSVENDADEST)
                FROM PCDESD D
               WHERE D.NUMTRANSVENDADEST = P.NUMTRANSVENDA
                 AND D.PRESTDEST = P.PREST),
              NULL,
             'N',
             'S') DESDOBRADO,
       ----------------------QT DE DIAS DE PRORROGAÇÃO QUE TEVE O TITULO--
       ROUND(P.DTVENC - NVL(P.DTVENCORIG, P.DTVENC)) DIASPRORROG,
       ------------------------VALOR TOTAL DE PEDIDO BLOQUEADO E PENDENTE-----
       NVL((SELECT SUM(NVL(VLATEND, 0))
             FROM PCPEDC
            WHERE CODCLI = P.CODCLI
              AND POSICAO IN ('P','B')
              AND DTCANCEL IS NULL),
           0) CKPEDPENDBLOQ,
       ------------------------IDENTIFICA SE O TITULO ESTA VENCIDO OU NÃO----
       NVL(CASE
             WHEN P.DTPAG IS NULL AND
       NVL(F_QTDIASVENCIDOS(TRUNC(CASE WHEN P.DTRECEBIMENTOPREVISTO IS NULL THEN P.DTVENC 
                            WHEN TRUNC(P.DTRECEBIMENTOPREVISTO) > TRUNC(SYSDATE) OR       
                                 TRUNC(P.DTRECEBIMENTOPREVISTO) > TRUNC(P.DTVENC)         
                            THEN P.DTRECEBIMENTOPREVISTO ELSE P.DTVENC END),              
                                       TRUNC(SYSDATE),
                                       P.CODCOB,
                                       P.CODFILIAL,
                                       NVL(F.USADIAUTILFILIAL,'N')),
                      0) > 0 THEN
             'S'
             ELSE
             'N'
           END,
          'N') CLVENCIMENTO,
       ------------------------------------------------
       DECODE(P.STATUS,'A', NULL, P.STATUS) STATUS2,
       ----ENDEREÇO DE COBRANÇA---------------
       DECODE(UPPER(C.ENDERCOB),'O MESMO', C.ENDERENT, C.ENDERCOB) ENDERCOB,
       DECODE(UPPER(C.ENDERCOB),'O MESMO', C.MUNICENT, C.MUNICCOB) MUNICCOB,
       DECODE(UPPER(C.ENDERCOB),'O MESMO', C.CEPENT, C.CEPCOB) CEPCOB,
       DECODE(UPPER(C.ENDERCOB),'O MESMO', C.NUMEROENT, C.NUMEROCOB) NUMEROCOB,
       DECODE(UPPER(C.ENDERCOB),'O MESMO', C.BAIRROENT, C.BAIRROCOB) BAIRROCOB,
       DECODE(UPPER(C.ENDERCOB),'O MESMO', C.ESTENT, C.ESTCOB) ESTCOB,
       DECODE(UPPER(C.ENDERCOB),'O MESMO', C.TELENT, C.TELCOB) TELCOB,
       ------------ENDEREÇO COMERCIAL--------
       DECODE(UPPER(C.ENDERCOM),'O MESMO', C.ENDERENT, C.ENDERCOM) ENDERCOM,
       DECODE(UPPER(C.ENDERCOM),'O MESMO', C.MUNICENT, C.MUNICCOM) MUNICCOM,
       DECODE(UPPER(C.ENDERCOM),'O MESMO', C.CEPENT, C.CEPCOM) CEPCOM,
       DECODE(UPPER(C.ENDERCOM),'O MESMO', C.NUMEROENT, C.NUMEROCOM) NUMEROCOM,
       DECODE(UPPER(C.ENDERCOM),'O MESMO', C.BAIRROENT, C.BAIRROCOM) BAIRROCOM,
       DECODE(UPPER(C.ENDERCOM),'O MESMO', C.ESTENT, C.ESTCOM) ESTCOM,
       DECODE(UPPER(C.ENDERCOM),'O MESMO', C.TELENT, C.TELCOM) TELCOM,
       -------------ENDEREÇO DE ENTREGA----------------
       C.ENDERENT,
       C.MUNICENT,
       C.CEPENT,
       C.NUMEROENT,
       C.BAIRROENT,
       C.ESTENT,
       C.TELENT,
       ---------------------------------
       NVL(CASE
             WHEN ((SELECT NVL(CHECARDIASUTEISTITPGNLIB,'N')
                      FROM PCCONSUM
                     WHERE ROWNUM = 1) ='S') AND
                  (SELECT USER_OBJECTS.STATUS
                     FROM USER_OBJECTS
                    WHERE USER_OBJECTS.OBJECT_NAME ='FNC_DTFINAL') ='
              VALID'THEN
              (SELECT SUM(NVL(PCPREST.VALOR, 0)) VLCHEQUE
                 FROM PCPREST, PCCOB
                WHERE PCPREST.CODCLI = P.CODCLI
                  AND PCPREST.CODCOB = PCCOB.CODCOB
                  AND PCPREST.CODCOB NOT IN
                      ('DESD','ESTR','DEVT','DEVP','CANC')
                  AND PCPREST.DTPAG IS NOT NULL
                  AND FNC_DTFINAL(PCPREST.DTPAG,
                                  NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0),
                                 'S') > TRUNC(SYSDATE))
             ELSE
              (SELECT SUM(NVL(PCPREST.VALOR, 0)) VLCHEQUE
                 FROM PCPREST, PCCOB
                WHERE PCPREST.CODCLI = P.CODCLI
                  AND PCPREST.CODCOB = PCCOB.CODCOB
                  AND PCPREST.CODCOB NOT IN
                      ('DESD','ESTR','DEVT','DEVP','CANC')
                  AND PCPREST.DTPAG IS NOT NULL
                  AND (PCPREST.DTPAG + NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)) >
                      TRUNC(SYSDATE))
           END,
           0) CKVLRTITPAGONLIBERADO,
       B.DIASCARENCIA,
       0 VLRJUROS,
       0 VLRJUROSDIA,
       0 VLRTOTAL,
       P.DTRECEBIMENTOPREVISTO,
       NVL(P.TXPERMPREVREAL, 0) TXPERMPREVREAL,
       NVL(P.TXPERMPREVISTO, 0) TXPERMPREVISTO,
       P.DTENVIOSERASA,
       P.DTRETIRADASERASA,
       P.OBSTITULO,
       P.ROWID RID,
       CASE
         WHEN INSTR(TGI.CODOCORRENCIA,'001') > 0 THEN
         'Entrada de Titulo'
         WHEN INSTR(TGI.CODOCORRENCIA,'002') > 0 THEN
         'Entrada Confirmada – Aguardando Comando'
         WHEN INSTR(TGI.CODOCORRENCIA,'105') > 0 THEN
         'Notificação Protocolada'
         WHEN INSTR(TGI.CODOCORRENCIA,'108') > 0 THEN
         'Notificação Paga no Banco'
         WHEN INSTR(TGI.CODOCORRENCIA,'112') > 0 THEN
         'Titulo Finalizado Durante o Processo de Notificação'
         WHEN INSTR(TGI.CODOCORRENCIA,'205') > 0 THEN
         'Titulo Protocolado para Protesto'
         WHEN INSTR(TGI.CODOCORRENCIA,'304') > 0 THEN
         'Protesto Baixado com Carta de Anuência'
         ELSE
         'Título não enviado para o TGi.'
       END SOLICITACAO,
       S.NUMNOTAVINCULADA,
       (SELECT COUNT(1) QTDE_DIAS_UTEIS
          FROM PCDIASUTEIS
         WHERE DATA BETWEEN
               (P.DTVENC + F_VERIFICARQTDIASCARENCIAS(B.CODCOB)) AND
               (TRUNC(SYSDATE) - 1)
           AND CODFILIAL = P.CODFILIAL
           AND DIAFINANCEIRO ='S') QTDE_DIAS_UTEIS,
(CASE WHEN (P.DTPAG IS NOT NULL ) THEN 
       NVL(P.VALORMULTA,0)             
      ELSE                             
       0                               
     END) AS VLMULTA,                  
       NVL(B.PERCMULTA, 0) PERCMULTA
     , NVL(B.COBSUPPLIERCARD,'N') AS COBSUPPLIERCARD 
     , P.PERMITEESTORNO
     */
  FROM PCPREST    P,
       PCCLIENT   C,
       PCEMPR     E,
       PCCOB      B,
       PCNFSAID   S,
       PCFILIAL   F,
       PCBANCO    BA,
       PCUSUARI   U,
       PCTGIPREST TGI
 WHERE P.CODCLI = C.CODCLI
   AND P.NUMTRANSVENDA = S.NUMTRANSVENDA(+)
   AND P.CODFILIAL = F.CODIGO(+)
   AND P.CODBANCO = BA.CODBANCO(+)
   AND P.CODCLI = 119859
   AND P.CODCLI = C.CODCLI
   AND P.NUMTRANSVENDA = TGI.NUMTRANSVENDA(+)
   AND P.PREST = TGI.PREST(+)
AND   P.CODCOB  = B.CODCOB(+)
AND P.CODBAIXA = E.MATRICULA(+)
AND P.CODUSUR = U.CODUSUR      
AND P.DTCANCEL IS NULL
AND P.CODCOB<>'CANC'
AND P.CODFILIAL = '2'
  AND (TRUNC(P.DTEMISSAO) >= to_date('01/01/2023','dd/mm/yyyy'))
  AND (TRUNC(P.DTEMISSAO) <= to_date('31/12/2023','dd/mm/yyyy'))
AND P.DTPAG IS NULL 
ORDER BY P.DTEMISSAO DESC, P.DUPLIC, P.PREST

