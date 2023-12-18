select distinct(A.dtsaida) from (
SELECT 
      s.dtsaida, 
      --s.dtwms,
       S.NUMNOTA,
       P.DUPLIC,
       P.CODCLI,
       C.CLIENTE,

       P.CODUSUR,
       U.NOME NOMERCA,
       S.codsupervisor,
       sup.nome as Supervisor,
       NVL(P.VALOR, 0) VALOR,

       to_number(substr(to_char(PLP.DESCRICAO),0,2)) as PRAZOMEDIOCADASTRO,
        S.prazomedio As PrazoMediNOta,
        case when to_number(substr(to_char(PLP.DESCRICAO),0,2)) > S.prazomedio then 'Sim' else 'Nao' end MODIFICADO
          

  FROM PCPREST    P,--
       PCCLIENT   C,--
       PCEMPR     E,
       PCCOB      B,
       PCNFSAID   S,--
       PCFILIAL   F,
       --PCBANCO    BA,
       PCUSUARI   U,--
       PCSUPERV   sup,--
       PCTGIPREST TGI,
       PCPLPAG PLP--


 WHERE PLP.CODPLPAG = C.CODPLPAG
 AND P.CODCLI = C.CODCLI
 AND S.codsupervisor = sup.codsupervisor
   AND P.NUMTRANSVENDA = S.NUMTRANSVENDA(+)
   AND P.CODFILIAL = 2
   --AND P.CODBANCO = BA.CODBANCO(+)
   --AND P.CODCLI in (119859)
     AND (TRUNC(P.DTEMISSAO) >= to_date(:data_init,'dd/mm/yyyy'))
 AND (TRUNC(P.DTEMISSAO) <= to_date(:data_end,'dd/mm/yyyy'))
   --AND U.CODSUPERVISOR = :Cod_Super
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

--AND P.DTPAG IS NULL 


/*
 WHERE PLP.CODPLPAG = C.CODPLPAG
 AND P.CODCLI = C.CODCLI
 AND S.codsupervisor = sup.codsupervisor
   AND P.NUMTRANSVENDA = S.NUMTRANSVENDA RIGHT JOIN
   AND P.CODFILIAL = 2
  ri AND P.CODBANCO = BA.CODBANCO RIGHT JOIN
    AND P.CODCLI in (119859)
     AND (TRUNC(P.DTEMISSAO) >= to_date(:data_init,'dd/mm/yyyy'))
 AND (TRUNC(P.DTEMISSAO) <= to_date(:data_end,'dd/mm/yyyy'))
   --AND U.CODSUPERVISOR = :Cod_Super
   AND P.CODCLI = C.CODCLI
   AND P.NUMTRANSVENDA = TGI.NUMTRANSVENDA
   AND P.PREST = TGI.PREST RIGHT JOIN
   --and P.NUMTRANSVENDA = :numtransvenda
AND   P.CODCOB  = B.CODCOB RIGHT JOIN
AND P.CODBAIXA = E.MATRICULA RIGHT JOIN
AND P.CODUSUR = U.CODUSUR      
AND P.DTCANCEL IS NULL
AND P.CODCOB<>'CANC'
AND P.CODFILIAL = '2'

--AND P.DTPAG IS NULL 
*/


ORDER BY 
S.NUMNOTA,
P.DTEMISSAO DESC, P.DUPLIC, P.PREST
) A
where A.MODIFICADO in (:status_)