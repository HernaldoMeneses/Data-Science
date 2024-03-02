 
 select A.*from (
 select S.DTSAIDA, S.NUMNOTA, S.CODCLI, S.CLIente, S.MUNICIPIO
 , s.prazomedio
 --,  substr(to_char(PLP.DESCRICAO),0,2) as PRAZOMEDIOCADASTRO
 ,  plp.numdias as PRAZOMEDIOCADASTRO
 ,  S.VLTOTAL, S.CODUSUR, U.NOMe as VENDEDOR, Sup.CODSUPERVISOR, SUP.NOME as Supervisor
--, case when (substr(to_char(PLP.DESCRICAO),0,2)) = to_char(S.prazomedio) then 'Nao' else 'Sim' end MODIFICADO
, case when plp.numdias > S.prazomedio then 'Sim' else 'Nao' end MODIFICADO

from PCNFSAID   S,        
    PCUSUARI   U,--
    PCSUPERV   sup,--
     PCPLPAG PLP,
    PCCLIENT   C--

where 
  S.CODCLI = C.CODCLI
  AND PLP.CODPLPAG = C.CODPLPAG
 AND S.CODUSUR = sup.COD_CADRCA--
AND S.CODUSUR = U.CODUSUR

 AND     (TRUNC(S.DTSAIDA) >= to_date(:data_init,'dd/mm/yyyy'))
 AND (TRUNC(S.DTSAIDA) <= to_date(:data_end,'dd/mm/yyyy'))
AND Sup.CODSUPERVISOR in (:codSuperv)
 order by
 S.NUMNOTA

 ) A
where A.MODIFICADO in (:status_)