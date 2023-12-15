
SELECT /*NVL(DECODE((SELECT COUNT(1)
                    FROM PCPREST
                   WHERE PCPREST.NUMTRANSVENDA = P.NUMTRANSVENDA
                     AND PCPREST.PREST         = P.PREST
                     AND NVL(PCPREST.NUMTRANSVENDAST, 0) > 0),
                  0,
                 'N',
                 'S'),
          'N') TITULOST,*/
       P.CODCLI,
       C.CLIENTE,
       to_number(substr(to_char(PLP.DESCRICAO),0,2)) as prazo, 
       NVL(P.VALOR, 0) VALOR,

       P.DTBAIXA,

       P.DTVENC,
       NVL(P.VPAGO, 0) VPAGO,

       NVL(P.DTEMISSAOORIG, P.DTEMISSAO) DTEMISSAOORIG,

       P.DUPLIC,

       P.DTPAG,
       (P.DTPAG - P.DTVENC) as dias_ate_pag,
       --P.STATUS,

       P.NUMCAR,

       P.CODFILIAL,
       P.CODCOB,
       P.CODUSUR,
       U.NOME NOMERCA,
       P.NUMTRANSVENDA,
       S.NUMNOTA,
       S.prazomedio
       --PLP.CODPLPAG,
       --PLP.DESCRICAO,
       

  FROM PCPREST    P,
       PCCLIENT   C,
       PCEMPR     E,
       PCCOB      B,
       PCNFSAID   S,
       PCFILIAL   F,
       PCBANCO    BA,
       PCUSUARI   U,
       PCTGIPREST TGI,
       PCPLPAG PLP
 WHERE PLP.CODPLPAG = C.CODPLPAG
 AND P.CODCLI = C.CODCLI
   AND P.NUMTRANSVENDA = S.NUMTRANSVENDA(+)
   AND P.CODFILIAL = F.CODIGO(+)
   AND P.CODBANCO = BA.CODBANCO(+)
   AND P.CODCLI = 119859
   AND P.CODCLI = C.CODCLI
   AND P.NUMTRANSVENDA = TGI.NUMTRANSVENDA(+)
   AND P.PREST = TGI.PREST(+)
   --and P.NUMTRANSVENDA = :numtransvenda
AND   P.CODCOB  = B.CODCOB(+)
AND P.CODBAIXA = E.MATRICULA(+)
AND P.CODUSUR = U.CODUSUR      
AND P.DTCANCEL IS NULL
AND P.CODCOB<>'CANC'
AND P.CODFILIAL = '2'
  AND (TRUNC(P.DTEMISSAO) >= to_date('01/01/2023','dd/mm/yyyy'))
 AND (TRUNC(P.DTEMISSAO) <= to_date('31/12/2023','dd/mm/yyyy'))
--AND P.DTPAG IS NULL 
ORDER BY P.DTEMISSAO DESC, P.DUPLIC, P.PREST
