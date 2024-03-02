----------------------------------
Timestamp: 11:50:52.764
SELECT F.CODIGO
     , F.RAZAOSOCIAL
     , F.FANTASIA
     , F.CODIGO || ' - ' || F.RAZAOSOCIAL FILIAL
     , F.IE
     , F.CGC
     , F.TELEFONE
     , F.ENDERECO
     , F.EMAIL
     , NVL(F.NUMERO2, TO_CHAR(F.NUMERO)) NUMERO
     , F.BAIRRO
     , F.CIDADE
     , F.UF
     , F.CEP
     , F.CONTATO
     , F.CODMUN CODIBGE
     , F.NUMIDF
     , F.CODDOCNFC
     , F.UTILIZANFE
     , F.INDUSTRIA
     , NVL(F.TIPOMONTAGEM, 'R') TIPOMONTAGEM
     , F.INTEGRADORAWMS
  FROM PCFILIAL F
 WHERE F.DTEXCLUSAO IS NULL
   AND (   F.CODIGO IN(SELECT PCLIB.CODIGOA
                         FROM PCLIB
                        WHERE PCLIB.CODTABELA = 1 
                          AND PCLIB.CODFUNC = 1261)
        OR EXISTS(SELECT PCLIB.CODIGOA
                    FROM PCLIB
                   WHERE PCLIB.CODTABELA = 1 
                     AND PCLIB.CODFUNC = 1261 
                     AND PCLIB.CODIGOA = '99'))
 AND UPPER( F.CODIGO  )= UPPER( :PARAM1 ) ORDER BY LPAD(F.CODIGO, 2, 0)
PARAM1 = '2'
----------------------------------
Timestamp: 11:50:53.509
SELECT C.CODCLI
     , C.CLIENTE
     , C.FANTASIA
     , C.CODUSUR1
     , C.CODPRACA
     , DECODE(C.BLOQUEIOSEFAZ, 'S', C.BLOQUEIOSEFAZ, 'N') BLOQUEIOSEFAZ           
     , DECODE(C.BLOQUEIOSEFAZPED, 'S', C.BLOQUEIOSEFAZPED, 'N') BLOQUEIOSEFAZPED  
     , C.DTVALIDASEFAZ                                                                
     , C.MUNICENT
     , C.ESTENT
     , C.DTBLOQ
     , C.CODFILIALNF    
     , C.DTVENCLIMCRED
     , C.DTEXCLUSAO
     , U.CODUSUR CODRCA
     , U.NOME AS NOMERCA
     , U.CODSUPERVISOR
     , C.CODCLIPRINC                                                
     , NVL(C.ANALISECRED, 'N') ANALISECRED                        
     , S.NOME AS NOMESUPERVISOR                                     
     , CPRINC.CLIENTE CLIENTEPRINCIPAL                              
     , C.CODCOB                                                     
     , CASE                                                         
         WHEN C.DTBLOQ IS NOT NULL AND C.BLOQUEIO='S' THEN 'S'  
         ELSE 'N' 
       END BLOQUEIO 
     , (SELECT COUNT(1) 
          FROM PCPREST                                    
         WHERE CODCLI=C.CODCLI
           AND CODCOB IN ('CHDV', 'CHD1', 'CHD3')  
           AND DTPAG IS NULL 
           AND NUMCHEQUE IS NOT NULL 
           AND NUMBANCO IS NOT NULL) QTCHQDEV                  
     , 'Não filtrado' NOMECONTATO 
     , C.CGCENT                             
     , C.DTVENCLIMCRED 
     , (SELECT LIMITECREDDISPONSUPPLI FROM PCSUPPLICLIENTE WHERE CODCLI = C.CODCLI) AS LIMITECREDSUPPLI 
     , C.DTULTCONSULTASERASA 
  FROM PCCLIENT C 
     , PCCLIENT CPRINC 
     , PCUSUARI U 
     , PCSUPERV S 
     , (SELECT MAX(U.CODUSUR) CODUSUR,MAX(U.NOME) NOMERCA,                   
               MAX(S.CODSUPERVISOR) CODSUPERVISOR,MAX(S.NOME) SUPERVISOR,    
               W.CODCLI                                                      
          FROM VW_CLIENTESRCA W
             , PCUSUARI U
             , PCSUPERV S
             , PCCLIENT V            
         WHERE NVL(NVL(V.CODUSUR1,V.CODUSUR2),W.CODUSUR) = U.CODUSUR          
           AND V.CODCLI=W.CODCLI(+)                                          
           AND S.CODSUPERVISOR=U.CODSUPERVISOR                               
      GROUP BY W.CODCLI) T
 WHERE C.CODCLI > 0
   AND C.CODCLI=T.CODCLI
   AND T.CODUSUR=U.CODUSUR(+)
   AND C.DTCADASTRO >= (SELECT MIN(DTCADASTRO) FROM PCCLIENT)
   AND T.CODSUPERVISOR=S.CODSUPERVISOR(+)
   AND C.CODCLIPRINC = CPRINC.CODCLI(+)
   AND TRUNC(C.DTCADASTRO) BETWEEN TRUNC(:DTCAD1) AND TRUNC(:DTCAD2)
   AND (NVL(C.CODFILIALNF,'X') IN ( '2','X','99' )) 
   AND --Script para retornar apenas registros com permissão rotina 131  
 EXISTS( SELECT 1                                                 
           FROM PCLIB                                             
          WHERE CODTABELA = TO_CHAR(1)                           
            AND (CODIGOA  = NVL(C.CODFILIALNF, CODIGOA) OR CODIGOA = '99') 
            AND CODFUNC   = 1261                                    
            AND PCLIB.CODIGOA IS NOT NULL)                        
ORDER BY C.CLIENTE
DTCAD1 = '01/01/2023'
DTCAD2 = '31/12/2023'
----------------------------------
Timestamp: 14:45:03.360
SELECT F.CODIGO
     , F.RAZAOSOCIAL
     , F.FANTASIA
     , F.CODIGO || ' - ' || F.RAZAOSOCIAL FILIAL
     , F.IE
     , F.CGC
     , F.TELEFONE
     , F.ENDERECO
     , F.EMAIL
     , NVL(F.NUMERO2, TO_CHAR(F.NUMERO)) NUMERO
     , F.BAIRRO
     , F.CIDADE
     , F.UF
     , F.CEP
     , F.CONTATO
     , F.CODMUN CODIBGE
     , F.NUMIDF
     , F.CODDOCNFC
     , F.UTILIZANFE
     , F.INDUSTRIA
     , NVL(F.TIPOMONTAGEM, 'R') TIPOMONTAGEM
     , F.INTEGRADORAWMS
  FROM PCFILIAL F
 WHERE F.DTEXCLUSAO IS NULL
 AND UPPER( F.CODIGO  )= UPPER( :PARAM1 ) ORDER BY LPAD(F.CODIGO, 2, 0)
PARAM1 = '2'
----------------------------------
Timestamp: 14:45:03.582
SELECT * FROM PCFORMCONFIG
WHERE ROTINA = :ROTINA
  AND MATRICULA = :MATRICULA
ROTINA = 1203
MATRICULA = 1261
----------------------------------
Timestamp: 14:45:03.712
SELECT F.CODIGO
     , F.RAZAOSOCIAL
     , F.FANTASIA
     , F.CODIGO || ' - ' || F.RAZAOSOCIAL FILIAL
     , F.IE
     , F.CGC
     , F.TELEFONE
     , F.ENDERECO
     , F.EMAIL
     , NVL(F.NUMERO2, TO_CHAR(F.NUMERO)) NUMERO
     , F.BAIRRO
     , F.CIDADE
     , F.UF
     , F.CEP
     , F.CONTATO
     , F.CODMUN CODIBGE
     , F.NUMIDF
     , F.CODDOCNFC
     , F.UTILIZANFE
     , F.INDUSTRIA
     , NVL(F.TIPOMONTAGEM, 'R') TIPOMONTAGEM
     , F.INTEGRADORAWMS
  FROM PCFILIAL F
 WHERE F.DTEXCLUSAO IS NULL
 AND UPPER( F.CODIGO  )= UPPER( :PARAM1 ) ORDER BY LPAD(F.CODIGO, 2, 0)
PARAM1 = '2'
----------------------------------
Timestamp: 14:45:04.284
SELECT NVL(UPPER(ACESSO),'N') ACESSO
FROM PCCONTROI
WHERE CODROTINA = :CODROTINA
  AND CODCONTROLE = :CODCONTROLE
  AND CODUSUARIO = :CODUSUARIO
CODROTINA = 1203
CODCONTROLE = 14
CODUSUARIO = 1261
----------------------------------
Timestamp: 14:45:04.352
SELECT NVL(UPPER(ACESSO),'N') ACESSO
FROM PCCONTROI
WHERE CODROTINA = :CODROTINA
  AND CODCONTROLE = :CODCONTROLE
  AND CODUSUARIO = :CODUSUARIO
CODROTINA = 1203
CODCONTROLE = 21
CODUSUARIO = 1261
----------------------------------
Timestamp: 14:45:04.405
SELECT NVL(UPPER(ACESSO),'N') ACESSO
FROM PCCONTROI
WHERE CODROTINA = :CODROTINA
  AND CODCONTROLE = :CODCONTROLE
  AND CODUSUARIO = :CODUSUARIO
CODROTINA = 1203
CODCONTROLE = 15
CODUSUARIO = 1261
----------------------------------
Timestamp: 14:45:04.467
SELECT SUM(VALOR) AS TOTAL
FROM PCPREST
WHERE CODCLI=:CODCLI
AND DTPAG IS NULL
CODCLI = 140509
----------------------------------
Timestamp: 14:45:04.511
SELECT SUM (NVL (VLATEND, 0)) AS TOTAL
FROM   PCPEDC
WHERE  CODCLI = :CODCLI
AND    POSICAO IN ('L', 'M')
AND    DTCANCEL IS NULL
CODCLI = 140509
----------------------------------
Timestamp: 14:45:04.551
SELECT SUM (NVL (VLATEND, 0)) AS TOTAL
FROM   PCPEDC
WHERE  CODCLI = :CODCLI
AND    POSICAO IN ('P', 'B')
AND    DTCANCEL IS NULL
CODCLI = 140509
----------------------------------
Timestamp: 14:45:04.594
SELECT PCPLPAGCLI.CODPLPAG,
       PCPLPAG.DESCRICAO,
       PCPLPAG.NUMDIAS,
       PCPLPAG.PERTXFIM
FROM   PCPLPAGCLI, PCPLPAG
WHERE  PCPLPAGCLI.CODCLI = :CODCLI
AND    PCPLPAGCLI.CODPLPAG = PCPLPAG.CODPLPAG
CODCLI = 140509
----------------------------------
Timestamp: 14:45:04.639
SELECT U.CODUSUR, R.NOME, S.CODSUPERVISOR, NVL(S.NOME, 'Não informado') SUPERVISOR
  FROM PCUSURCLI U, PCUSUARI R, PCSUPERV S
 where U.CODCLI = :CODCLI
   AND U.CODUSUR = R.CODUSUR
   AND R.CODSUPERVISOR = S.CODSUPERVISOR(+)
UNION
SELECT R.CODUSUR, R.NOME, S.CODSUPERVISOR, NVL(S.NOME, 'Não informado') SUPERVISOR
  FROM PCCLIENT C, PCUSUARI R, PCSUPERV S
 where C.CODCLI = :CODCLI
   AND R.CODSUPERVISOR = S.CODSUPERVISOR(+)
   AND ((C.CODUSUR1 = R.CODUSUR) OR (C.CODUSUR2 = R.CODUSUR) OR
       (C.CODUSUR3 = R.CODUSUR))
CODCLI = 140509
----------------------------------
Timestamp: 14:45:04.690
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 14:45:04.765
SELECT C.CODCLI, C.CLIENTE                                                                                                               
     , C.CODFUNCULTALTER                                                                                                                 
     , C.CODROTINAALT                                                                                                                    
     , DECODE(C.BLOQUEIO, 'S', C.BLOQUEIO, 'N') BLOQUEIO                                                                             
     , C.INICIOATIV, C.CODFUNCULTALTER1203,                                                                                              
       C.DTBLOQ, C.CODFUNCANALISECRED, C.CLASSEVENDA,C.VIP,C.OBS, C.GERENCIAMENTO, C.DTPRIMCOMPRA, TRUNC(SYSDATE) AS HOJE,               
 NVL(C.LIMCRED,0) AS LIMCREDORIGINAL,NVL(C.PRAZOADICIONAL,0) PRAZOADICIONAL                                                              
 ,(SELECT MAX(PCEMPR.VLMAXLIMCREDCLI)                                                                                                    
     FROM PCEMPR                                                                                                                         
    WHERE PCEMPR.MATRICULA = :FUNC                                                                                                       
  ) AS VLMAXLIMCREDCLI,                                                                                                                  
 NVL(C.LIMCREDCPF,0) AS LIMCREDCPF,                                                                                                      
 NVL(QTDIASVENCLIMCRED,0) QTDIASVENCLIMCRED,                                                                                             
       (SELECT MAX(PC.DATA)                                                                                                              
        FROM PCPEDC PC                                                                                                                   
        WHERE PC.CODCLI = C.CODCLI                                                                                                       
        AND   PC.CONDVENDA IN (1,5,8,14,20)) AS DTULTCOMP,                                                                               
       C.DTREGLIM, C.DTVENCLIMCRED, C.CODCOB, C.CODPLPAG, TRUNC(C.DTULTALTER1203) DTULTALTER1203,                                        
       C.EMAIL, C.FAXCLI, C.FANTASIA, C.TELENT, C.OBS2, C.OBS3, C.OBS4, C.OBS5,                                                          
  C.CGCENT,                                                                                                                             
       C.DTULTCONSULTASERASA, C.DTULTCONSULTASCI, C.RATINGSCI, C.PREDIOPROPRIO,                                                          
       C.ANALISECRED, C.CAPITALSOCIAL, C.TELCELENT, C.CODCLIPRINC, C.CODFILIALNF,                                                        
       C.OBSERVACAO, C.RATINGSCI1, C.RATINGSCI2, C.DTULTCONSULTASINTEGRA, C.CODUSUR1,                                                    
       C.DTDESBLOQUEIO,                                                                                                                  
       C.CODCOBTV1, C.CODCOBTV3, C.CODHIST,                                                                                              
       DECODE(C.BLOQUEIODEFINITIVO, 'S', C.BLOQUEIODEFINITIVO, 'N') BLOQUEIODEFINITIVO,                                              
       C.BLOQUEIODATACHEQ,                                                                                                               
       C.TIPOFJ                                                                                                                          
       , DECODE(C.BLOQUEIOSEFAZ, 'S', C.BLOQUEIOSEFAZ, 'N') BLOQUEIOSEFAZ                                                            
       , DECODE(C.BLOQUEIOSEFAZPED, 'S', C.BLOQUEIOSEFAZPED, 'N') BLOQUEIOSEFAZPED,                                                  
       C.OBS_ADIC, C.DTULTAGRUPAMENTO                                                                                                    
       , C.PERIODICIDADEAGRUP                                                                                                            
       , C.CODPLPAGAGRUPAUTOMATIC                                                                                                        
       , C.DTPROXDESDAGENDADO,                                                                                                           
       C.TPCOMUNICADOSERASA, NVL(C.SERASAGERENCIE,'S') SERASAGERENCIE, C.PRAZOSERASAGERENCIE, C.DTSERASAGERENCIE,                      
       C.UTILIZAPLPAGMEDICAMENTO, C.CODPLPAGETICO, C.CODPLPAGGENERICO                                                                    
       ,C.EMAILNFE                                                                                                                       
       ,SUPPLICLIENTE.STATUSSUPPLI                                                                                                       
       ,SUPPLICLIENTE.LIMITECREDDISPONSUPPLI                                                                                             
       ,SUPPLICLIENTE.LIMITECOMPRADISPONIVEL                                                                                             
       ,PED.VALOR AS PEDNAOFATDMAISCRED                                                                                                  
       ,FILASUPPLI.FATNAORETDMAISCRED                                                                                                    
       ,(SUPPLICLIENTE.LIMITECOMPRADISPONIVEL - PED.VALOR - FILASUPPLI.FATNAORETDMAISCRED) AS LIMITEDISPDMAISCRED                        
       ,0 ckVLLIMITESAZONAL                                                                                                              
       ,0 LIMCRED                                                                                                                        
       ,0 VALORPENDENTE                                                                                                                  
       ,0 CKPendAcerto                                                                                                                   
       ,0 ckVlrTitPagoNLiberado                                                                                                          
       ,0 CKPedPendBloq                                                                                                                  
       ,0 CKSaldoDisp                                                                                                                    
       ,0 ckSaldoDispMenosPedBloq                                                                                                        
       ,'XXXXXX' BLOQ                                                                                                                  
       ,0 ckTitulosTerceiros                                                                                                             
       ,0 CKDisponivel                                                                                                                   
       , CODPLPAG || '-' || (SELECT PLP.DESCRICAO                                                                                      
            FROM PCPLPAG PLP                                                                                                             
           WHERE PLP.CODPLPAG = C.CODPLPAG AND ROWNUM = 1) ckPLANOPAG                                                                    
       , c.MOTIVOBLOQ                                                                                                                    
       , NFSAID.CKVLMAIORCOMPRA, NFSAID.ckDTMAIORCOMPRA                                                                                  
       , C.UTILIZAPLPAGMEDICAMENTO, C.CODPLPAGETICO, C.CODPLPAGGENERICO                                                                  
       ,C.EMAILNFE                                                                                                                       
       ,NVL(C.LIMITECREDSUPPLI,0) AS LIMITECREDSUPPLI                                                                                    
       ,0 ckVLLIMITESAZONAL                                                                                                              
       ,0 LIMCRED                                                                                                                        
       ,0 VALORPENDENTE                                                                                                                  
       ,0 CKPendAcerto                                                                                                                   
       ,0 ckVlrTitPagoNLiberado                                                                                                          
       ,0 CKPedPendBloq                                                                                                                  
       ,0 CKSaldoDisp                                                                                                                    
       ,0 ckSaldoDispMenosPedBloq                                                                                                        
       ,'XXXXXX' BLOQ                                                                                                                  
       ,0 ckTitulosTerceiros                                                                                                             
       ,0 CKDisponivel                                                                                                                   
       , CODPLPAG || '-' || (SELECT PLP.DESCRICAO                                                                                      
            FROM PCPLPAG PLP                                                                                                             
           WHERE PLP.CODPLPAG = C.CODPLPAG AND ROWNUM = 1) ckPLANOPAG                                                                    
       , c.MOTIVOBLOQ                                                                                                                    
FROM PCCLIENT C,                                                                                                                         
     (SELECT STATUSSUPPLI,                                                                                                               
             LIMITECREDDISPONSUPPLI,                                                                                                     
             LIMITECOMPRADISPONIVEL,                                                                                                     
             CODCLI                                                                                                                      
        FROM PCSUPPLICLIENTE) SUPPLICLIENTE,                                                                                             
     (SELECT MAX(N.vltotger) ckvlmaiorcompra , MAX(N.dtsaida) as ckdtmaiorcompra, N.codcli                                               
        FROM pcnfsaid n                                                                                                                  
       WHERE n.tipovenda <> 'DF'                                                                                                       
         AND n.condvenda IN (1, 5, 8, 14, 20)                                                                                            
       GROUP BY N.CODCLI) NFSAID,                                                                                                        
      (SELECT NVL(SUM(ROUND(NVL(PCPEDC.VLATEND, 0) - CASE                                                                                
                                                     WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN       
                                                              PCPEDC.VLENTRADA                                                           
                                                     ELSE 0                                                                              
                                                     END, 2)),0) AS VALOR,                                                               
              PCPEDC.CODCLI                                                                                                              
         FROM PCPEDC, PCPLPAG                                                                                                            
        WHERE DTCANCEL IS NULL                                                                                                           
          AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG                                                                                         
          AND POSICAO IN ('L', 'M')                                                                                                  
          AND PCPEDC.CODCOB IN (SELECT CODCOB FROM PCCOB where COBSUPPLIERCARD = 'S')                                                  
        GROUP BY PCPEDC.CODCLI) PED,                                                                                                     
      (SELECT NVL(SUM(S.VLTOTAL), 0) AS FATNAORETDMAISCRED, S.CODCLI                                                                     
         FROM PCFILASUPPLI F                                                                                                             
        INNER JOIN PCNFSAID S ON S.NUMTRANSVENDA = F.NUMTRANSVENDA                                                                       
        WHERE TIPOINF = 1                                                                                                                
          AND ((NVL(ENVIADOSUPPLI, 'N') = 'N') OR (APROVADOSUPPLI <> 'S'))                                                         
        GROUP BY S.CODCLI) FILASUPPLI                                                                                                    
WHERE C.CODCLI = :CODCLI                                                                                                                 
  AND C.CODCLI = SUPPLICLIENTE.CODCLI(+)                                                                                                 
  AND C.CODCLI = NFSAID.CODCLI(+)                                                                                                        
  AND C.CODCLI = PED.CODCLI(+)                                                                                                           
  AND C.CODCLI = FILASUPPLI.CODCLI(+)
FUNC = 1261
CODCLI = 140509
----------------------------------
Timestamp: 14:45:05.073
SELECT percaumento
  FROM pclimcred
 WHERE pclimcred.coddcli = :codcli
   AND TRUNC( SYSDATE ) BETWEEN pclimcred.dtinicio AND pclimcred.dtfim
   AND (    ( pclimcred.codusur IS NULL )
        OR ( pclimcred.codusur = :codusur ) )
codcli = 140509
codusur = 1353
----------------------------------
Timestamp: 14:45:05.184
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 140509
----------------------------------
Timestamp: 14:45:05.242
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 140509
----------------------------------
Timestamp: 14:45:05.302
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 140509
----------------------------------
Timestamp: 14:45:05.365
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 14:45:05.410
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 140509
----------------------------------
Timestamp: 14:45:05.456
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 140509
----------------------------------
Timestamp: 14:45:05.546
SELECT PARAMFILIAL.OBTERCOMOVARCHAR2('CON_ACEITAVENDABLOQ', '99')
  FROM DUAL
----------------------------------
Timestamp: 14:45:05.580
SELECT PARAMFILIAL.OBTERCOMOVARCHAR2('CON_VERIFICALIMCREDCODCOBD', '99')
  FROM DUAL
----------------------------------
Timestamp: 14:45:05.604
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 140509
----------------------------------
Timestamp: 14:45:05.657
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 140509
----------------------------------
Timestamp: 14:45:05.699
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 14:45:05.735
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 140509
----------------------------------
Timestamp: 14:45:05.796
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 140509
----------------------------------
Timestamp: 14:45:05.839
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 14:45:05.879
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 140509
----------------------------------
Timestamp: 14:45:05.910
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 140509
----------------------------------
Timestamp: 14:45:05.952
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 14:45:05.977
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 140509
----------------------------------
Timestamp: 14:45:06.031
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 140509
----------------------------------
Timestamp: 14:45:06.070
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 140509
----------------------------------
Timestamp: 14:45:06.131
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 140509
----------------------------------
Timestamp: 14:45:06.164
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 14:45:06.207
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 140509
----------------------------------
Timestamp: 14:45:06.269
SELECT * FROM PCSUPPLICLIENTE WHERE CODCLI = :CODCLI
CODCLI = 140509
----------------------------------
Timestamp: 14:45:06.393
SELECT L.CODCLI,
       L.DATA,
       L.CODEMITE,
       L.PROGRAMA,
       L.BLOQUEIO,
       L.BLOQUEIOANT,
       L.LIMCRED,
       L.LIMCREDANT,
       L.DTREGLIMANT,
       L.DTVENCLIMCRED,
       L.DTVENCLIMANT,
       L.OBS,
       L.OBSANT,
       L.PRAZO,
       L.PRAZOANT,
       L.CODCOB,
       L.CODCOBANT,
       C.CLIENTE,
       C.CODCLI,
       C.CGCENT,
       L.OBS1,
       L.OBS2,
       L.OBS3,
       L.OBS4,
       L.CODPLPAG,
       L.CODPLPAGANT,
       C.DTBLOQ,
       E.NOME,
       L.LIMCREDCPFANT,
       L.LIMCREDCPF,
       L.BLOQDEFINITIVO,
       L.BLOQDEFINITIVOANT,
       L.UTILIZAPLPAGMEDICAMENTO,
       L.UTILIZAPLPAGMEDICAMENTOANT,
       L.CODPLPAGETICO,
       L.CODPLPAGETICOANT,
       L.CODPLPAGGENERICO,
       L.CODPLPAGGENERICOANT,
       (SELECT P1.DESCRICAO FROM PCPLPAG P1 WHERE P1.CODPLPAG = L.CODPLPAG) AS DESCPAG,
       (SELECT P1.DESCRICAO
          FROM PCPLPAG P1
         WHERE P1.CODPLPAG = L.CODPLPAGANT) AS DESCPAGANT,
       L.DTULTCOMP,
       L.DTULTCOMPANT,
       L.OBSALT
  FROM PCLOGLC L, PCCLIENT C, PCEMPR E
 WHERE (L.CODCLI = :CODCLI)
   AND (L.CODCLI = C.CODCLI)
   AND (L.CODEMITE = E.MATRICULA)
   AND L.OBS NOT IN ('Baixa do Estorno da Perda','Estorno Parcial Baixa da Perda')
 ORDER BY L.DATA DESC
CODCLI = 140509
----------------------------------
Timestamp: 14:45:06.537
SELECT CODIGO || ' - ' || RAZAOSOCIAL as RAZAOSOCIAL, CODIGO
 FROM PCFILIAL
WHERE CODIGO IN
      (DECODE((SELECT COUNT(1)
                FROM PCLIB
               WHERE CODIGOA IN 
                     (SELECT CODIGO FROM PCFILIAL WHERE CODIGO = '99')
                 AND CODTABELA = 1
                 AND CODFUNC = 1261),
              0,
              (SELECT CODIGOA
                 FROM PCLIB
                WHERE CODTABELA = 1
                  AND CODFUNC = 1261
                  AND CODIGOA = CODIGO),
              CODIGO))
ORDER BY CODIGO
----------------------------------
Timestamp: 14:45:06.584
SELECT TO_CHAR(SYSDATE, 'DD/MM/YYYY') AS DATA,
TO_CHAR(SYSDATE, 'HH:MI:SS') AS HORA FROM DUAL
----------------------------------
Timestamp: 14:45:06.615
SELECT DECODE
       ((SELECT COUNT(1)
              FROM PCCOBCLI T
             WHERE T.CODCOB = B.CODCOB
               AND T.CODCLI = :CODCLI),0,'N','S')
     SELECIONADO,
    B.CODCOB,
    B.COBRANCA,
    B.NIVELVENDA,
    B.BOLETO
FROM PCCOB B,PCCOBCLI C
WHERE B.CODCOB=C.CODCOB
AND C.CODCLI=:CODCLI
CODCLI = 140509
----------------------------------
Timestamp: 14:45:06.663
SELECT * FROM PCSUPPLICLIENTE WHERE CODCLI = :CODCLI
CODCLI = 140509
----------------------------------
Timestamp: 14:45:06.706
SELECT A.CODCLI,
       A.CLIENTE,
       A.FANTASIA,
       A.CLASSEVENDA,
       A.VIP1          AS VIP,
       A.CGCENT,
       A.CODATV1,
       A.CODUSUR1,
       A.CODUSUR2,
       A.IEENT,
       A.VIP2          AS VIP,
       A.DTCADASTRO,
       A.NOME,
       A.PRACA,
       A.ENDERENT,
       A.BAIRROENT,
       A.MUNICENT,
       A.ESTENT,
       A.TELENT,
       A.FAXCLI,
       A.ENDERCOB,
       A.BAIRROCOB,
       A.MUNICCOB,
       A.ESTCOB,
       A.CODPRACA,
       A.TELCOB,
       A.PREDIOPROPRIO,
       A.INICIOATIV,
       A.CEPENT,
       A.CEPCOB,
       A.RAMO,
       A.CODCOB,
       A.DTEXCLUSAO,
       A.NUMEROCOM,
       A.NUMEROCOB,
       A.NUMEROENT,
       A.NUMREGIAO,
       PCREGIAO.REGIAO,
       A.ROTA,
       A.DESCROTA
  FROM (SELECT C.CODCLI,
               C.CLIENTE,
               C.FANTASIA,
               C.CLASSEVENDA,
               C.VIP AS VIP1,
               C.CGCENT,
               C.CODATV1,
               C.CODUSUR1,
               C.CODUSUR2,
               C.IEENT,
               C.VIP AS VIP2,
               C.DTCADASTRO,
               U1.NOME,
               P.PRACA,
               C.ENDERENT,
               C.BAIRROENT,
               C.MUNICENT,
               C.ESTENT,
               C.TELENT,
               C.FAXCLI,
               C.ENDERCOB,
               C.BAIRROCOB,
               C.MUNICCOB,
               C.ESTCOB,
               C.CODPRACA,
               C.TELCOB,
               C.PREDIOPROPRIO,
               C.INICIOATIV,
               C.CEPENT,
               C.CEPCOB,
               A.RAMO,
               C.CODCOB,
               C.DTEXCLUSAO,
               C.NUMEROCOM,
               C.NUMEROCOB,
               C.NUMEROENT,
               NVL((SELECT T.NUMREGIAO
                     FROM PCTABPRCLI T
                    WHERE C.CODCLI = T.CODCLI(+)
                      AND C.CODFILIALNF = T.CODFILIALNF(+)),
                   P.NUMREGIAO) AS NUMREGIAO,
               P.ROTA,
               PCROTAEXP.DESCRICAO AS DESCROTA
          FROM PCCLIENT C, PCUSUARI U1, PCPRACA P, PCATIVI A, PCROTAEXP 
         WHERE C.CODCLI = :CODCLI
           AND C.CODUSUR1 = U1.CODUSUR
           AND C.CODPRACA = P.CODPRACA
           AND C.CODATV1 = A.CODATIV
           AND P.ROTA = PCROTAEXP.CODROTA) A,
       PCREGIAO
 WHERE A.NUMREGIAO = PCREGIAO.NUMREGIAO
CODCLI = 140509
----------------------------------
Timestamp: 14:45:06.878
SELECT NOMECONTATO, TIPOCONTATO, CGCCPF, AUTORCH, DTNASCIMENTO,
       HOBBIE, TIME, NOMECONJUGE, DTNASCCONJUGE, ENDERECO, BAIRRO,
       CIDADE, CEP, CARGO, TELEFONE, CELULAR, EMAIL, CODCLI, PARTICIPSOCIO,
       DTSOCIEDADE,OBS   
FROM PCCONTATO
WHERE CODCLI = :CODCLI
AND TIPOCONTATO = 'S'
ORDER BY TIPOCONTATO DESC, NOMECONTATO
CODCLI = 140509
----------------------------------
Timestamp: 14:45:06.919
SELECT C.ID,
       C.DATA,
       DECODE(C.TIPOFJ,'F','FÍSICA','JURÍDICA') AS TIPOFJ,
       CASE C.TIPOFJ WHEN 'J' THEN 
         SUBSTR(C.DOCPESQ, 2, 2)||'.'|| 
         SUBSTR(C.DOCPESQ, 4, 3)||'.'|| 
         SUBSTR(C.DOCPESQ, 7, 3)||'/'|| 
         SUBSTR(C.DOCPESQ, 10, 4)||'-'|| 
         SUBSTR(C.DOCPESQ, 14, 2) 
       WHEN 'F' THEN 
         SUBSTR(C.DOCPESQ, 5, 3)||'.'|| 
         SUBSTR(C.DOCPESQ, 8, 3)||'.'|| 
         SUBSTR(C.DOCPESQ, 11, 3)||'-'|| 
         SUBSTR(C.DOCPESQ, 14, 2)
       END AS DOCPESQ,       
       S.NUMBANCO,
       S.NUMAGENCIA,
       S.NUMCONTA,
       S.NUMCHEQUE,
       S.DVCHEQUE,
       S.UF,
       S.VALOR,
       S.DTVENC,
       CASE S.SITUACAO WHEN 'BL' THEN        
         'BLOQUEADO'
       WHEN 'LI' THEN          
         'LIBERADO'
       WHEN 'LS' THEN          
         'LIBERADO(SUPERVISOR)'
       WHEN 'LV' THEN          
         'LIBERADO(VALOR MÍNIMO)'
       WHEN 'PE' THEN          
         'PENDENTE'
       END AS SITUACAO,        
       NVL(S.OBSERVACAO,'NÃO CONSTAM OCORRÊNCIAS') AS OBSERVACAO      
FROM PCSITUACAOCHEQUES S, PCSERASA_CONSULTAS C
WHERE S.ID_PCSERASA_CONSULTAS = C.ID
AND   S.CODCLI = :CODCLI
ORDER BY C.DATA
CODCLI = 140509
----------------------------------
Timestamp: 14:45:07.021
SELECT L.CODCOBANT, C2.COBRANCA AS NOMECOBANT, L.CODCOB, C1.COBRANCA AS NOMECOB,   
       L.NUMCHEQUE, L.NUMBANCO,                                                    
       L.NUMAGENCIA, L.NUMCONTACORRENTE, E.NOME AS NOMEFUNC,                       
       L.VALOR, L.DTESTORNO, L.CODFUNCESTORNO, L.ALINEA, L.NUMTRANSVENDA, L.PREST, 
       (SELECT PCPREST.CGCCPFCH                                                    
          FROM PCPREST                                                             
         WHERE PCPREST.NUMTRANSVENDA = L.NUMTRANSVENDA                             
           AND PCPREST.PREST = L.PREST) CGCCPFCH,                                  
       (SELECT PCPREST.OBS2                                                        
          FROM PCPREST                                                             
         WHERE PCPREST.NUMTRANSVENDA = L.NUMTRANSVENDA                             
           AND PCPREST.PREST = L.PREST) EMITENTECHEQUE                             
FROM PCLOGCHDV L, PCCOB C1, PCCOB C2, PCEMPR E                                     
WHERE L.CODCLI = :CODCLI                                                           
AND   L.CODCOB = C1.CODCOB(+)                                                      
AND   L.CODCOBANT = C2.CODCOB(+)                                                   
AND   L.CODFUNCESTORNO = E.MATRICULA(+)                                            
ORDER BY CODCLI, DTESTORNO DESC, VALOR DESC
CODCLI = 140509
----------------------------------
Timestamp: 14:45:20.315
SELECT C.CODCLI, C.CLIENTE                                                                                                               
     , C.CODFUNCULTALTER                                                                                                                 
     , C.CODROTINAALT                                                                                                                    
     , DECODE(C.BLOQUEIO, 'S', C.BLOQUEIO, 'N') BLOQUEIO                                                                             
     , C.INICIOATIV, C.CODFUNCULTALTER1203,                                                                                              
       C.DTBLOQ, C.CODFUNCANALISECRED, C.CLASSEVENDA,C.VIP,C.OBS, C.GERENCIAMENTO, C.DTPRIMCOMPRA, TRUNC(SYSDATE) AS HOJE,               
 NVL(C.LIMCRED,0) AS LIMCREDORIGINAL,NVL(C.PRAZOADICIONAL,0) PRAZOADICIONAL                                                              
 ,(SELECT MAX(PCEMPR.VLMAXLIMCREDCLI)                                                                                                    
     FROM PCEMPR                                                                                                                         
    WHERE PCEMPR.MATRICULA = :FUNC                                                                                                       
  ) AS VLMAXLIMCREDCLI,                                                                                                                  
 NVL(C.LIMCREDCPF,0) AS LIMCREDCPF,                                                                                                      
 NVL(QTDIASVENCLIMCRED,0) QTDIASVENCLIMCRED,                                                                                             
       (SELECT MAX(PC.DATA)                                                                                                              
        FROM PCPEDC PC                                                                                                                   
        WHERE PC.CODCLI = C.CODCLI                                                                                                       
        AND   PC.CONDVENDA IN (1,5,8,14,20)) AS DTULTCOMP,                                                                               
       C.DTREGLIM, C.DTVENCLIMCRED, C.CODCOB, C.CODPLPAG, TRUNC(C.DTULTALTER1203) DTULTALTER1203,                                        
       C.EMAIL, C.FAXCLI, C.FANTASIA, C.TELENT, C.OBS2, C.OBS3, C.OBS4, C.OBS5,                                                          
  C.CGCENT,                                                                                                                             
       C.DTULTCONSULTASERASA, C.DTULTCONSULTASCI, C.RATINGSCI, C.PREDIOPROPRIO,                                                          
       C.ANALISECRED, C.CAPITALSOCIAL, C.TELCELENT, C.CODCLIPRINC, C.CODFILIALNF,                                                        
       C.OBSERVACAO, C.RATINGSCI1, C.RATINGSCI2, C.DTULTCONSULTASINTEGRA, C.CODUSUR1,                                                    
       C.DTDESBLOQUEIO,                                                                                                                  
       C.CODCOBTV1, C.CODCOBTV3, C.CODHIST,                                                                                              
       DECODE(C.BLOQUEIODEFINITIVO, 'S', C.BLOQUEIODEFINITIVO, 'N') BLOQUEIODEFINITIVO,                                              
       C.BLOQUEIODATACHEQ,                                                                                                               
       C.TIPOFJ                                                                                                                          
       , DECODE(C.BLOQUEIOSEFAZ, 'S', C.BLOQUEIOSEFAZ, 'N') BLOQUEIOSEFAZ                                                            
       , DECODE(C.BLOQUEIOSEFAZPED, 'S', C.BLOQUEIOSEFAZPED, 'N') BLOQUEIOSEFAZPED,                                                  
       C.OBS_ADIC, C.DTULTAGRUPAMENTO                                                                                                    
       , C.PERIODICIDADEAGRUP                                                                                                            
       , C.CODPLPAGAGRUPAUTOMATIC                                                                                                        
       , C.DTPROXDESDAGENDADO,                                                                                                           
       C.TPCOMUNICADOSERASA, NVL(C.SERASAGERENCIE,'S') SERASAGERENCIE, C.PRAZOSERASAGERENCIE, C.DTSERASAGERENCIE,                      
       C.UTILIZAPLPAGMEDICAMENTO, C.CODPLPAGETICO, C.CODPLPAGGENERICO                                                                    
       ,C.EMAILNFE                                                                                                                       
       ,SUPPLICLIENTE.STATUSSUPPLI                                                                                                       
       ,SUPPLICLIENTE.LIMITECREDDISPONSUPPLI                                                                                             
       ,SUPPLICLIENTE.LIMITECOMPRADISPONIVEL                                                                                             
       ,PED.VALOR AS PEDNAOFATDMAISCRED                                                                                                  
       ,FILASUPPLI.FATNAORETDMAISCRED                                                                                                    
       ,(SUPPLICLIENTE.LIMITECOMPRADISPONIVEL - PED.VALOR - FILASUPPLI.FATNAORETDMAISCRED) AS LIMITEDISPDMAISCRED                        
       ,0 ckVLLIMITESAZONAL                                                                                                              
       ,0 LIMCRED                                                                                                                        
       ,0 VALORPENDENTE                                                                                                                  
       ,0 CKPendAcerto                                                                                                                   
       ,0 ckVlrTitPagoNLiberado                                                                                                          
       ,0 CKPedPendBloq                                                                                                                  
       ,0 CKSaldoDisp                                                                                                                    
       ,0 ckSaldoDispMenosPedBloq                                                                                                        
       ,'XXXXXX' BLOQ                                                                                                                  
       ,0 ckTitulosTerceiros                                                                                                             
       ,0 CKDisponivel                                                                                                                   
       , CODPLPAG || '-' || (SELECT PLP.DESCRICAO                                                                                      
            FROM PCPLPAG PLP                                                                                                             
           WHERE PLP.CODPLPAG = C.CODPLPAG AND ROWNUM = 1) ckPLANOPAG                                                                    
       , c.MOTIVOBLOQ                                                                                                                    
       , NFSAID.CKVLMAIORCOMPRA, NFSAID.ckDTMAIORCOMPRA                                                                                  
       , C.UTILIZAPLPAGMEDICAMENTO, C.CODPLPAGETICO, C.CODPLPAGGENERICO                                                                  
       ,C.EMAILNFE                                                                                                                       
       ,NVL(C.LIMITECREDSUPPLI,0) AS LIMITECREDSUPPLI                                                                                    
       ,0 ckVLLIMITESAZONAL                                                                                                              
       ,0 LIMCRED                                                                                                                        
       ,0 VALORPENDENTE                                                                                                                  
       ,0 CKPendAcerto                                                                                                                   
       ,0 ckVlrTitPagoNLiberado                                                                                                          
       ,0 CKPedPendBloq                                                                                                                  
       ,0 CKSaldoDisp                                                                                                                    
       ,0 ckSaldoDispMenosPedBloq                                                                                                        
       ,'XXXXXX' BLOQ                                                                                                                  
       ,0 ckTitulosTerceiros                                                                                                             
       ,0 CKDisponivel                                                                                                                   
       , CODPLPAG || '-' || (SELECT PLP.DESCRICAO                                                                                      
            FROM PCPLPAG PLP                                                                                                             
           WHERE PLP.CODPLPAG = C.CODPLPAG AND ROWNUM = 1) ckPLANOPAG                                                                    
       , c.MOTIVOBLOQ                                                                                                                    
FROM PCCLIENT C,                                                                                                                         
     (SELECT STATUSSUPPLI,                                                                                                               
             LIMITECREDDISPONSUPPLI,                                                                                                     
             LIMITECOMPRADISPONIVEL,                                                                                                     
             CODCLI                                                                                                                      
        FROM PCSUPPLICLIENTE) SUPPLICLIENTE,                                                                                             
     (SELECT MAX(N.vltotger) ckvlmaiorcompra , MAX(N.dtsaida) as ckdtmaiorcompra, N.codcli                                               
        FROM pcnfsaid n                                                                                                                  
       WHERE n.tipovenda <> 'DF'                                                                                                       
         AND n.condvenda IN (1, 5, 8, 14, 20)                                                                                            
       GROUP BY N.CODCLI) NFSAID,                                                                                                        
      (SELECT NVL(SUM(ROUND(NVL(PCPEDC.VLATEND, 0) - CASE                                                                                
                                                     WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN       
                                                              PCPEDC.VLENTRADA                                                           
                                                     ELSE 0                                                                              
                                                     END, 2)),0) AS VALOR,                                                               
              PCPEDC.CODCLI                                                                                                              
         FROM PCPEDC, PCPLPAG                                                                                                            
        WHERE DTCANCEL IS NULL                                                                                                           
          AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG                                                                                         
          AND POSICAO IN ('L', 'M')                                                                                                  
          AND PCPEDC.CODCOB IN (SELECT CODCOB FROM PCCOB where COBSUPPLIERCARD = 'S')                                                  
        GROUP BY PCPEDC.CODCLI) PED,                                                                                                     
      (SELECT NVL(SUM(S.VLTOTAL), 0) AS FATNAORETDMAISCRED, S.CODCLI                                                                     
         FROM PCFILASUPPLI F                                                                                                             
        INNER JOIN PCNFSAID S ON S.NUMTRANSVENDA = F.NUMTRANSVENDA                                                                       
        WHERE TIPOINF = 1                                                                                                                
          AND ((NVL(ENVIADOSUPPLI, 'N') = 'N') OR (APROVADOSUPPLI <> 'S'))                                                         
        GROUP BY S.CODCLI) FILASUPPLI                                                                                                    
WHERE C.CODCLI = :CODCLI                                                                                                                 
  AND C.CODCLI = SUPPLICLIENTE.CODCLI(+)                                                                                                 
  AND C.CODCLI = NFSAID.CODCLI(+)                                                                                                        
  AND C.CODCLI = PED.CODCLI(+)                                                                                                           
  AND C.CODCLI = FILASUPPLI.CODCLI(+)
FUNC = 1261
CODCLI = 140509
----------------------------------
Timestamp: 14:45:20.546
SELECT percaumento
  FROM pclimcred
 WHERE pclimcred.coddcli = :codcli
   AND TRUNC( SYSDATE ) BETWEEN pclimcred.dtinicio AND pclimcred.dtfim
   AND (    ( pclimcred.codusur IS NULL )
        OR ( pclimcred.codusur = :codusur ) )
codcli = 140509
codusur = 1353
----------------------------------
Timestamp: 14:45:20.593
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 140509
----------------------------------
Timestamp: 14:45:20.639
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 140509
----------------------------------
Timestamp: 14:45:20.696
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 140509
----------------------------------
Timestamp: 14:45:20.726
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 14:45:20.756
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 140509
----------------------------------
Timestamp: 14:45:20.813
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 140509
----------------------------------
Timestamp: 14:45:20.844
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 140509
----------------------------------
Timestamp: 14:45:20.900
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 140509
----------------------------------
Timestamp: 14:45:20.944
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 14:45:20.976
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 140509
----------------------------------
Timestamp: 14:45:21.039
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 140509
----------------------------------
Timestamp: 14:45:21.092
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 14:45:21.109
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 140509
----------------------------------
Timestamp: 14:45:21.145
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 140509
----------------------------------
Timestamp: 14:45:21.183
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 14:45:21.212
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 140509
----------------------------------
Timestamp: 14:45:21.262
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 140509
----------------------------------
Timestamp: 14:45:21.318
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 140509
----------------------------------
Timestamp: 14:45:21.371
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 140509
----------------------------------
Timestamp: 14:45:21.411
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 14:45:21.436
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 140509
----------------------------------
Timestamp: 14:45:21.505
SELECT * FROM PCSUPPLICLIENTE WHERE CODCLI = :CODCLI
CODCLI = 140509
----------------------------------
Timestamp: 14:45:21.542
SELECT USER_OBJECTS.OBJECT_NAME                               
     , USER_OBJECTS.STATUS                                    
     , USER_TRIGGERS.STATUS                                   
  FROM USER_OBJECTS                                           
     , USER_TRIGGERS                                          
 WHERE USER_OBJECTS.OBJECT_NAME = USER_TRIGGERS.TRIGGER_NAME  
   AND USER_OBJECTS.OBJECT_TYPE = 'TRIGGER'                 
   AND USER_OBJECTS.OBJECT_NAME = 'TRG_PCCLIENT_PCLOGLC'   
   AND USER_OBJECTS.STATUS = 'VALID'                        
   AND USER_TRIGGERS.STATUS = 'ENABLED'
----------------------------------
Timestamp: 14:45:21.917
SELECT VLAUMENTOLIMCRED
  FROM PCEMPR
 WHERE MATRICULA = :CODUSU
CODUSU = 1261
----------------------------------
Timestamp: 14:45:21.948
SELECT VLAUMENTOLIMCRED
  FROM PCEMPR
 WHERE MATRICULA = :CODUSU
CODUSU = 1261
----------------------------------
Timestamp: 14:45:22.001
SELECT PARAMFILIAL.OBTERCOMOVARCHAR2('CON_UTILIZACONTROLEMEDICAMENTOS', '99')
  FROM DUAL
----------------------------------
Timestamp: 14:45:22.032
SELECT VLSALDOLIMALTCREDITO
  FROM PCEMPR
 WHERE MATRICULA = :CODUSU
CODUSU = 1261
----------------------------------
Timestamp: 14:45:22.080
SELECT LTRIM(RTRIM(CODCOB)) AS CODCOB,                                                     
 CODCOB || ' - ' || COBRANCA AS COBRANCA,                                                 
 PRAZOMAXIMOVENDA                                                                           
 FROM PCCOB                                                                                 
 WHERE ((NVL(NIVELVENDA,0) > 0) OR                                                          
        (CODCOB in (SELECT NVL(VALOR, 'X')                                                
                    FROM PCPARAMFILIAL                                                      
                    WHERE NOME in ('CON_CODCOBINICIAL', 'CODCOBINICIALPF'))))           
 AND CODCOB NOT IN ('BNF','BNFT','BNFR','BNFN','BNFF','BNFC','BNTR','BNRP') 
 AND --Script para retornar apenas registros com permissão rotina 131  
 EXISTS( SELECT 1                                                 
           FROM PCLIB                                             
          WHERE CODTABELA = TO_CHAR(8)                           
            AND (CODIGOA  = NVL(PCCOB.CODCOB, CODIGOA) OR CODIGOA = '9999') 
            AND CODFUNC   = 1261                                    
            AND PCLIB.CODIGOA IS NOT NULL)                        
 ORDER BY CODCOB
----------------------------------
Timestamp: 14:45:22.124
SELECT 
  CODPLPAG, 
  DESCRICAO,
  NUMDIAS
FROM 
  PCPLPAG
WHERE 
  CODPLPAG > 0
  AND (:CODFILIAL = '99' OR NVL(PCPLPAG.CODFILIAL,'99') = '99' OR NVL(PCPLPAG.CODFILIAL,'99') = :CODFILIAL )
ORDER BY 
  DESCRICAO
CODFILIAL = '2'
----------------------------------
Timestamp: 14:45:22.181
SELECT LTRIM(RTRIM(CODCOB)) AS CODCOB,
CODCOB || ' - ' || COBRANCA AS COBRANCA
FROM PCCOB
WHERE NVL(NIVELVENDA,0) > 0
AND CODCOB NOT LIKE 'BN%'
AND PCCOB.BOLETO = 'S'
AND NVL(PCCOB.NUMBANCO,0) > 0
ORDER BY CODCOB
----------------------------------
Timestamp: 14:45:22.209
SELECT LTRIM(RTRIM(CODCOB)) AS CODCOB,
CODCOB || ' - ' || COBRANCA AS COBRANCA
FROM PCCOB
WHERE NVL(NIVELVENDA,0) > 0
AND CODCOB NOT LIKE 'BN%'
AND PCCOB.BOLETO = 'S'
AND NVL(PCCOB.NUMBANCO,0) > 0
ORDER BY CODCOB
----------------------------------
Timestamp: 14:45:22.251
SELECT CODHIST, HISTORICO
FROM   PCHIST
WHERE  TIPO = 'B'
ORDER BY HISTORICO
----------------------------------
Timestamp: 14:45:22.288
SELECT CODHIST, HISTORICO
FROM   PCHIST
WHERE  TIPO = 'B'
ORDER BY HISTORICO
----------------------------------
Timestamp: 14:45:22.319
select CODPLPAG, DESCRICAO,PRAZO1,
CODPLPAG || ' - ' || DESCRICAO AS PLANOPAG
from PCPLPAG
WHERE CODPLPAG > 0
AND TIPOPRAZO <> 'I'
AND NVL(PCPLPAG.STATUS, 'A') <> 'I'
AND NUMDIAS <= :PRAZOMAXVENDA
AND (:CODFILIAL = '99' OR NVL(PCPLPAG.CODFILIAL,'99') = '99' OR NVL(PCPLPAG.CODFILIAL,'99') = :CODFILIAL )
order by DESCRICAO
PRAZOMAXVENDA = 0
CODFILIAL = '2'
----------------------------------
Timestamp: 14:45:22.386
SELECT OBSERVACAO FROM PCCLIENT
WHERE  CODCLI = :CODCLI
CODCLI = 140509
----------------------------------
Timestamp: 14:45:22.443
SELECT VLAUMENTOLIMCRED
  FROM PCEMPR
 WHERE MATRICULA = :CODUSU
CODUSU = 1261
----------------------------------
Timestamp: 14:45:22.490
SELECT PCEMPR.VLAUMENTOLIMCRED, PCEMPR.PERCEXCLIMCRED 
FROM PCEMPR
WHERE PCEMPR.MATRICULA = :MATRICULA
MATRICULA = 1261
----------------------------------
Timestamp: 14:45:34.818
Successful rollback.
----------------------------------
Timestamp: 14:45:34.858
Successful rollback.
----------------------------------
Timestamp: 14:45:34.861
begin  :Result := SYS_CONTEXT ('USERENV', 'CURRENT_SCHEMA');end;
Result = 'FRIOBOM'
----------------------------------
Timestamp: 14:45:34.905
SELECT '' TABLE_CATALOG, IC.TABLE_OWNER TABLE_SCHEMA, IC.TABLE_NAME, '' INDEX_CATALOG, IC.INDEX_OWNER INDEX_SCHEMA, 
IC.INDEX_NAME, IC.COLUMN_NAME, IC.COLUMN_POSITION, DECODE(IC.DESCEND, 'ASC', 0, 1) DESCENDING FROM SYS.ALL_IND_COLUMNS IC, 
SYS.ALL_INDEXES I, SYS.ALL_CONSTRAINTS C WHERE IC.TABLE_OWNER = 'FRIOBOM' AND IC.TABLE_NAME = 'PCCOB' AND I.UNIQUENESS = 
'UNIQUE' AND        I.OWNER = IC.INDEX_OWNER AND I.INDEX_NAME = IC.INDEX_NAME AND       C.TABLE_NAME (+) = IC.TABLE_NAME AND 
C.INDEX_NAME (+) = IC.INDEX_NAME AND C.OWNER (+)= IC.TABLE_OWNER ORDER BY DECODE(IC.INDEX_OWNER, 'FRIOBOM', 0, 'PUBLIC', 1, 2), 
DECODE(C.CONSTRAINT_TYPE, 'P', 1, 'U', 2, 3), IC.INDEX_OWNER, IC.TABLE_OWNER, IC.TABLE_NAME, IC.INDEX_NAME, IC.COLUMN_POSITION
----------------------------------
Timestamp: 14:45:34.930
SELECT DECODE
       ((SELECT COUNT(1)
              FROM PCCOBCLI T
             WHERE T.CODCOB = B.CODCOB
               AND T.CODCLI = :CODCLI),0,'N','S')
     SELECIONADO,
    B.CODCOB,
    B.COBRANCA,
    B.NIVELVENDA,
    B.BOLETO
FROM PCCOB B,PCCOBCLI C
WHERE B.CODCOB=C.CODCOB
AND C.CODCLI=:CODCLI
CODCLI = 140509
----------------------------------
Timestamp: 14:45:34.986
SELECT L.CODCLI,
       L.DATA,
       L.CODEMITE,
       L.PROGRAMA,
       L.BLOQUEIO,
       L.BLOQUEIOANT,
       L.LIMCRED,
       L.LIMCREDANT,
       L.DTREGLIMANT,
       L.DTVENCLIMCRED,
       L.DTVENCLIMANT,
       L.OBS,
       L.OBSANT,
       L.PRAZO,
       L.PRAZOANT,
       L.CODCOB,
       L.CODCOBANT,
       C.CLIENTE,
       C.CODCLI,
       C.CGCENT,
       L.OBS1,
       L.OBS2,
       L.OBS3,
       L.OBS4,
       L.CODPLPAG,
       L.CODPLPAGANT,
       C.DTBLOQ,
       E.NOME,
       L.LIMCREDCPFANT,
       L.LIMCREDCPF,
       L.BLOQDEFINITIVO,
       L.BLOQDEFINITIVOANT,
       L.UTILIZAPLPAGMEDICAMENTO,
       L.UTILIZAPLPAGMEDICAMENTOANT,
       L.CODPLPAGETICO,
       L.CODPLPAGETICOANT,
       L.CODPLPAGGENERICO,
       L.CODPLPAGGENERICOANT,
       (SELECT P1.DESCRICAO FROM PCPLPAG P1 WHERE P1.CODPLPAG = L.CODPLPAG) AS DESCPAG,
       (SELECT P1.DESCRICAO
          FROM PCPLPAG P1
         WHERE P1.CODPLPAG = L.CODPLPAGANT) AS DESCPAGANT,
       L.DTULTCOMP,
       L.DTULTCOMPANT,
       L.OBSALT
  FROM PCLOGLC L, PCCLIENT C, PCEMPR E
 WHERE (L.CODCLI = :CODCLI)
   AND (L.CODCLI = C.CODCLI)
   AND (L.CODEMITE = E.MATRICULA)
   AND L.OBS NOT IN ('Baixa do Estorno da Perda','Estorno Parcial Baixa da Perda')
 ORDER BY L.DATA DESC
CODCLI = 140509
----------------------------------
Timestamp: 14:45:35.114
SELECT C.CODCLI, C.CLIENTE                                                                                                               
     , C.CODFUNCULTALTER                                                                                                                 
     , C.CODROTINAALT                                                                                                                    
     , DECODE(C.BLOQUEIO, 'S', C.BLOQUEIO, 'N') BLOQUEIO                                                                             
     , C.INICIOATIV, C.CODFUNCULTALTER1203,                                                                                              
       C.DTBLOQ, C.CODFUNCANALISECRED, C.CLASSEVENDA,C.VIP,C.OBS, C.GERENCIAMENTO, C.DTPRIMCOMPRA, TRUNC(SYSDATE) AS HOJE,               
 NVL(C.LIMCRED,0) AS LIMCREDORIGINAL,NVL(C.PRAZOADICIONAL,0) PRAZOADICIONAL                                                              
 ,(SELECT MAX(PCEMPR.VLMAXLIMCREDCLI)                                                                                                    
     FROM PCEMPR                                                                                                                         
    WHERE PCEMPR.MATRICULA = :FUNC                                                                                                       
  ) AS VLMAXLIMCREDCLI,                                                                                                                  
 NVL(C.LIMCREDCPF,0) AS LIMCREDCPF,                                                                                                      
 NVL(QTDIASVENCLIMCRED,0) QTDIASVENCLIMCRED,                                                                                             
       (SELECT MAX(PC.DATA)                                                                                                              
        FROM PCPEDC PC                                                                                                                   
        WHERE PC.CODCLI = C.CODCLI                                                                                                       
        AND   PC.CONDVENDA IN (1,5,8,14,20)) AS DTULTCOMP,                                                                               
       C.DTREGLIM, C.DTVENCLIMCRED, C.CODCOB, C.CODPLPAG, TRUNC(C.DTULTALTER1203) DTULTALTER1203,                                        
       C.EMAIL, C.FAXCLI, C.FANTASIA, C.TELENT, C.OBS2, C.OBS3, C.OBS4, C.OBS5,                                                          
  C.CGCENT,                                                                                                                             
       C.DTULTCONSULTASERASA, C.DTULTCONSULTASCI, C.RATINGSCI, C.PREDIOPROPRIO,                                                          
       C.ANALISECRED, C.CAPITALSOCIAL, C.TELCELENT, C.CODCLIPRINC, C.CODFILIALNF,                                                        
       C.OBSERVACAO, C.RATINGSCI1, C.RATINGSCI2, C.DTULTCONSULTASINTEGRA, C.CODUSUR1,                                                    
       C.DTDESBLOQUEIO,                                                                                                                  
       C.CODCOBTV1, C.CODCOBTV3, C.CODHIST,                                                                                              
       DECODE(C.BLOQUEIODEFINITIVO, 'S', C.BLOQUEIODEFINITIVO, 'N') BLOQUEIODEFINITIVO,                                              
       C.BLOQUEIODATACHEQ,                                                                                                               
       C.TIPOFJ                                                                                                                          
       , DECODE(C.BLOQUEIOSEFAZ, 'S', C.BLOQUEIOSEFAZ, 'N') BLOQUEIOSEFAZ                                                            
       , DECODE(C.BLOQUEIOSEFAZPED, 'S', C.BLOQUEIOSEFAZPED, 'N') BLOQUEIOSEFAZPED,                                                  
       C.OBS_ADIC, C.DTULTAGRUPAMENTO                                                                                                    
       , C.PERIODICIDADEAGRUP                                                                                                            
       , C.CODPLPAGAGRUPAUTOMATIC                                                                                                        
       , C.DTPROXDESDAGENDADO,                                                                                                           
       C.TPCOMUNICADOSERASA, NVL(C.SERASAGERENCIE,'S') SERASAGERENCIE, C.PRAZOSERASAGERENCIE, C.DTSERASAGERENCIE,                      
       C.UTILIZAPLPAGMEDICAMENTO, C.CODPLPAGETICO, C.CODPLPAGGENERICO                                                                    
       ,C.EMAILNFE                                                                                                                       
       ,SUPPLICLIENTE.STATUSSUPPLI                                                                                                       
       ,SUPPLICLIENTE.LIMITECREDDISPONSUPPLI                                                                                             
       ,SUPPLICLIENTE.LIMITECOMPRADISPONIVEL                                                                                             
       ,PED.VALOR AS PEDNAOFATDMAISCRED                                                                                                  
       ,FILASUPPLI.FATNAORETDMAISCRED                                                                                                    
       ,(SUPPLICLIENTE.LIMITECOMPRADISPONIVEL - PED.VALOR - FILASUPPLI.FATNAORETDMAISCRED) AS LIMITEDISPDMAISCRED                        
       ,0 ckVLLIMITESAZONAL                                                                                                              
       ,0 LIMCRED                                                                                                                        
       ,0 VALORPENDENTE                                                                                                                  
       ,0 CKPendAcerto                                                                                                                   
       ,0 ckVlrTitPagoNLiberado                                                                                                          
       ,0 CKPedPendBloq                                                                                                                  
       ,0 CKSaldoDisp                                                                                                                    
       ,0 ckSaldoDispMenosPedBloq                                                                                                        
       ,'XXXXXX' BLOQ                                                                                                                  
       ,0 ckTitulosTerceiros                                                                                                             
       ,0 CKDisponivel                                                                                                                   
       , CODPLPAG || '-' || (SELECT PLP.DESCRICAO                                                                                      
            FROM PCPLPAG PLP                                                                                                             
           WHERE PLP.CODPLPAG = C.CODPLPAG AND ROWNUM = 1) ckPLANOPAG                                                                    
       , c.MOTIVOBLOQ                                                                                                                    
       , NFSAID.CKVLMAIORCOMPRA, NFSAID.ckDTMAIORCOMPRA                                                                                  
       , C.UTILIZAPLPAGMEDICAMENTO, C.CODPLPAGETICO, C.CODPLPAGGENERICO                                                                  
       ,C.EMAILNFE                                                                                                                       
       ,NVL(C.LIMITECREDSUPPLI,0) AS LIMITECREDSUPPLI                                                                                    
       ,0 ckVLLIMITESAZONAL                                                                                                              
       ,0 LIMCRED                                                                                                                        
       ,0 VALORPENDENTE                                                                                                                  
       ,0 CKPendAcerto                                                                                                                   
       ,0 ckVlrTitPagoNLiberado                                                                                                          
       ,0 CKPedPendBloq                                                                                                                  
       ,0 CKSaldoDisp                                                                                                                    
       ,0 ckSaldoDispMenosPedBloq                                                                                                        
       ,'XXXXXX' BLOQ                                                                                                                  
       ,0 ckTitulosTerceiros                                                                                                             
       ,0 CKDisponivel                                                                                                                   
       , CODPLPAG || '-' || (SELECT PLP.DESCRICAO                                                                                      
            FROM PCPLPAG PLP                                                                                                             
           WHERE PLP.CODPLPAG = C.CODPLPAG AND ROWNUM = 1) ckPLANOPAG                                                                    
       , c.MOTIVOBLOQ                                                                                                                    
FROM PCCLIENT C,                                                                                                                         
     (SELECT STATUSSUPPLI,                                                                                                               
             LIMITECREDDISPONSUPPLI,                                                                                                     
             LIMITECOMPRADISPONIVEL,                                                                                                     
             CODCLI                                                                                                                      
        FROM PCSUPPLICLIENTE) SUPPLICLIENTE,                                                                                             
     (SELECT MAX(N.vltotger) ckvlmaiorcompra , MAX(N.dtsaida) as ckdtmaiorcompra, N.codcli                                               
        FROM pcnfsaid n                                                                                                                  
       WHERE n.tipovenda <> 'DF'                                                                                                       
         AND n.condvenda IN (1, 5, 8, 14, 20)                                                                                            
       GROUP BY N.CODCLI) NFSAID,                                                                                                        
      (SELECT NVL(SUM(ROUND(NVL(PCPEDC.VLATEND, 0) - CASE                                                                                
                                                     WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN       
                                                              PCPEDC.VLENTRADA                                                           
                                                     ELSE 0                                                                              
                                                     END, 2)),0) AS VALOR,                                                               
              PCPEDC.CODCLI                                                                                                              
         FROM PCPEDC, PCPLPAG                                                                                                            
        WHERE DTCANCEL IS NULL                                                                                                           
          AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG                                                                                         
          AND POSICAO IN ('L', 'M')                                                                                                  
          AND PCPEDC.CODCOB IN (SELECT CODCOB FROM PCCOB where COBSUPPLIERCARD = 'S')                                                  
        GROUP BY PCPEDC.CODCLI) PED,                                                                                                     
      (SELECT NVL(SUM(S.VLTOTAL), 0) AS FATNAORETDMAISCRED, S.CODCLI                                                                     
         FROM PCFILASUPPLI F                                                                                                             
        INNER JOIN PCNFSAID S ON S.NUMTRANSVENDA = F.NUMTRANSVENDA                                                                       
        WHERE TIPOINF = 1                                                                                                                
          AND ((NVL(ENVIADOSUPPLI, 'N') = 'N') OR (APROVADOSUPPLI <> 'S'))                                                         
        GROUP BY S.CODCLI) FILASUPPLI                                                                                                    
WHERE C.CODCLI = :CODCLI                                                                                                                 
  AND C.CODCLI = SUPPLICLIENTE.CODCLI(+)                                                                                                 
  AND C.CODCLI = NFSAID.CODCLI(+)                                                                                                        
  AND C.CODCLI = PED.CODCLI(+)                                                                                                           
  AND C.CODCLI = FILASUPPLI.CODCLI(+)
FUNC = 1261
CODCLI = 140509
----------------------------------
Timestamp: 14:45:35.375
SELECT percaumento
  FROM pclimcred
 WHERE pclimcred.coddcli = :codcli
   AND TRUNC( SYSDATE ) BETWEEN pclimcred.dtinicio AND pclimcred.dtfim
   AND (    ( pclimcred.codusur IS NULL )
        OR ( pclimcred.codusur = :codusur ) )
codcli = 140509
codusur = 1353
----------------------------------
Timestamp: 14:45:35.427
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 140509
----------------------------------
Timestamp: 14:45:35.483
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 140509
----------------------------------
Timestamp: 14:45:35.514
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 140509
----------------------------------
Timestamp: 14:45:35.568
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 14:45:35.582
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 140509
----------------------------------
Timestamp: 14:45:35.633
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 140509
----------------------------------
Timestamp: 14:45:35.678
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 140509
----------------------------------
Timestamp: 14:45:35.740
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 140509
----------------------------------
Timestamp: 14:45:35.771
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 14:45:35.809
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 140509
----------------------------------
Timestamp: 14:45:35.871
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 140509
----------------------------------
Timestamp: 14:45:35.908
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 14:45:35.944
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 140509
----------------------------------
Timestamp: 14:45:35.975
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 140509
----------------------------------
Timestamp: 14:45:36.016
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 14:45:36.055
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 140509
----------------------------------
Timestamp: 14:45:36.100
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 140509
----------------------------------
Timestamp: 14:45:36.142
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 140509
----------------------------------
Timestamp: 14:45:36.195
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 140509
----------------------------------
Timestamp: 14:45:36.243
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 14:45:36.276
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 140509
----------------------------------
Timestamp: 14:45:36.369
SELECT * FROM PCSUPPLICLIENTE WHERE CODCLI = :CODCLI
CODCLI = 140509
----------------------------------
Timestamp: 14:45:45.930
SELECT * FROM PCFORMCONFIG
WHERE ROTINA = :ROTINA
  AND MATRICULA = :MATRICULA
  AND NOME = :NOME
ROTINA = 1203
MATRICULA = 1261
NOME = '1'
----------------------------------
Timestamp: 14:45:45.992
Successful commit.
----------------------------------
Timestamp: 14:45:45.993
begin  :result := sys.dbms_transaction.local_transaction_id(true); end;
result = '5.30.5391722'
----------------------------------
Timestamp: 14:45:46.050
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '5.30.5391722'
----------------------------------
Timestamp: 14:45:46.089
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '5.30.5391722'
----------------------------------
Timestamp: 14:45:46.118
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '5.30.5391722'
----------------------------------
Timestamp: 14:45:46.164
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '5.30.5391722'
----------------------------------
Timestamp: 14:45:46.188
SELECT '' TABLE_CATALOG, IC.TABLE_OWNER TABLE_SCHEMA, IC.TABLE_NAME, '' INDEX_CATALOG, IC.INDEX_OWNER INDEX_SCHEMA, 
IC.INDEX_NAME, IC.COLUMN_NAME, IC.COLUMN_POSITION, DECODE(IC.DESCEND, 'ASC', 0, 1) DESCENDING FROM SYS.ALL_IND_COLUMNS IC, 
SYS.ALL_INDEXES I, SYS.ALL_CONSTRAINTS C WHERE IC.TABLE_OWNER = 'FRIOBOM' AND IC.TABLE_NAME = 'PCFORMCONFIG' AND I.UNIQUENESS = 
'UNIQUE' AND        I.OWNER = IC.INDEX_OWNER AND I.INDEX_NAME = IC.INDEX_NAME AND       C.TABLE_NAME (+) = IC.TABLE_NAME AND 
C.INDEX_NAME (+) = IC.INDEX_NAME AND C.OWNER (+)= IC.TABLE_OWNER ORDER BY DECODE(IC.INDEX_OWNER, 'FRIOBOM', 0, 'PUBLIC', 1, 2), 
DECODE(C.CONSTRAINT_TYPE, 'P', 1, 'U', 2, 3), IC.INDEX_OWNER, IC.TABLE_OWNER, IC.TABLE_NAME, IC.INDEX_NAME, IC.COLUMN_POSITION
----------------------------------
Timestamp: 14:45:46.225
UPDATE PCFORMCONFIG
SET
  ARQUIVO=EMPTY_BLOB()
WHERE
  CODIGO = :Old_CODIGO
RETURNING
  ARQUIVO
INTO
  :ARQUIVO
Old_CODIGO = 11083
----------------------------------
Timestamp: 14:45:46.340
Successful commit.
----------------------------------
Timestamp: 14:45:46.363
SELECT * FROM PCFORMCONFIG
WHERE ROTINA = :ROTINA
  AND MATRICULA = :MATRICULA
  AND NOME = :NOME
ROTINA = 1203
MATRICULA = 1261
NOME = 'P'
----------------------------------
Timestamp: 14:45:46.429
Successful commit.
----------------------------------
Timestamp: 14:45:46.430
begin  :result := sys.dbms_transaction.local_transaction_id(true); end;
result = '36.33.4630017'
----------------------------------
Timestamp: 14:45:46.488
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '36.33.4630017'
----------------------------------
Timestamp: 14:45:46.523
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '36.33.4630017'
----------------------------------
Timestamp: 14:45:46.567
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '36.33.4630017'
----------------------------------
Timestamp: 14:45:46.599
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '36.33.4630017'
----------------------------------
Timestamp: 14:45:46.634
SELECT '' TABLE_CATALOG, IC.TABLE_OWNER TABLE_SCHEMA, IC.TABLE_NAME, '' INDEX_CATALOG, IC.INDEX_OWNER INDEX_SCHEMA, 
IC.INDEX_NAME, IC.COLUMN_NAME, IC.COLUMN_POSITION, DECODE(IC.DESCEND, 'ASC', 0, 1) DESCENDING FROM SYS.ALL_IND_COLUMNS IC, 
SYS.ALL_INDEXES I, SYS.ALL_CONSTRAINTS C WHERE IC.TABLE_OWNER = 'FRIOBOM' AND IC.TABLE_NAME = 'PCFORMCONFIG' AND I.UNIQUENESS = 
'UNIQUE' AND        I.OWNER = IC.INDEX_OWNER AND I.INDEX_NAME = IC.INDEX_NAME AND       C.TABLE_NAME (+) = IC.TABLE_NAME AND 
C.INDEX_NAME (+) = IC.INDEX_NAME AND C.OWNER (+)= IC.TABLE_OWNER ORDER BY DECODE(IC.INDEX_OWNER, 'FRIOBOM', 0, 'PUBLIC', 1, 2), 
DECODE(C.CONSTRAINT_TYPE, 'P', 1, 'U', 2, 3), IC.INDEX_OWNER, IC.TABLE_OWNER, IC.TABLE_NAME, IC.INDEX_NAME, IC.COLUMN_POSITION
----------------------------------
Timestamp: 14:45:46.690
UPDATE PCFORMCONFIG
SET
  ARQUIVO=EMPTY_BLOB()
WHERE
  CODIGO = :Old_CODIGO
RETURNING
  ARQUIVO
INTO
  :ARQUIVO
Old_CODIGO = 11084
----------------------------------
Timestamp: 14:45:46.752
Successful commit.
----------------------------------
Timestamp: 14:45:46.776
SELECT * FROM PCFORMCONFIG
WHERE ROTINA = :ROTINA
  AND MATRICULA = :MATRICULA
  AND NOME = :NOME
ROTINA = 1203
MATRICULA = 1261
NOME = '1'
----------------------------------
Timestamp: 14:45:46.832
Successful commit.
----------------------------------
Timestamp: 14:45:46.833
begin  :result := sys.dbms_transaction.local_transaction_id(true); end;
result = '12.17.8644716'
----------------------------------
Timestamp: 14:45:46.880
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '12.17.8644716'
----------------------------------
Timestamp: 14:45:46.917
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '12.17.8644716'
----------------------------------
Timestamp: 14:45:46.953
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '12.17.8644716'
----------------------------------
Timestamp: 14:45:46.984
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '12.17.8644716'
----------------------------------
Timestamp: 14:45:47.022
SELECT '' TABLE_CATALOG, IC.TABLE_OWNER TABLE_SCHEMA, IC.TABLE_NAME, '' INDEX_CATALOG, IC.INDEX_OWNER INDEX_SCHEMA, 
IC.INDEX_NAME, IC.COLUMN_NAME, IC.COLUMN_POSITION, DECODE(IC.DESCEND, 'ASC', 0, 1) DESCENDING FROM SYS.ALL_IND_COLUMNS IC, 
SYS.ALL_INDEXES I, SYS.ALL_CONSTRAINTS C WHERE IC.TABLE_OWNER = 'FRIOBOM' AND IC.TABLE_NAME = 'PCFORMCONFIG' AND I.UNIQUENESS = 
'UNIQUE' AND        I.OWNER = IC.INDEX_OWNER AND I.INDEX_NAME = IC.INDEX_NAME AND       C.TABLE_NAME (+) = IC.TABLE_NAME AND 
C.INDEX_NAME (+) = IC.INDEX_NAME AND C.OWNER (+)= IC.TABLE_OWNER ORDER BY DECODE(IC.INDEX_OWNER, 'FRIOBOM', 0, 'PUBLIC', 1, 2), 
DECODE(C.CONSTRAINT_TYPE, 'P', 1, 'U', 2, 3), IC.INDEX_OWNER, IC.TABLE_OWNER, IC.TABLE_NAME, IC.INDEX_NAME, IC.COLUMN_POSITION
----------------------------------
Timestamp: 14:45:47.049
UPDATE PCFORMCONFIG
SET
  ARQUIVO=EMPTY_BLOB()
WHERE
  CODIGO = :Old_CODIGO
RETURNING
  ARQUIVO
INTO
  :ARQUIVO
Old_CODIGO = 11085
----------------------------------
Timestamp: 14:45:47.125
Successful commit.
----------------------------------
Timestamp: 14:45:47.131
SELECT * FROM PCFORMCONFIG
WHERE ROTINA = :ROTINA
  AND MATRICULA = :MATRICULA
  AND NOME = :NOME
ROTINA = 1203
MATRICULA = 1261
NOME = '1'
----------------------------------
Timestamp: 14:45:47.186
Successful commit.
----------------------------------
Timestamp: 14:45:47.188
begin  :result := sys.dbms_transaction.local_transaction_id(true); end;
result = '35.24.5392171'
----------------------------------
Timestamp: 14:45:47.225
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '35.24.5392171'
----------------------------------
Timestamp: 14:45:47.254
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '35.24.5392171'
----------------------------------
Timestamp: 14:45:47.293
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '35.24.5392171'
----------------------------------
Timestamp: 14:45:47.332
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '35.24.5392171'
----------------------------------
Timestamp: 14:45:47.365
SELECT '' TABLE_CATALOG, IC.TABLE_OWNER TABLE_SCHEMA, IC.TABLE_NAME, '' INDEX_CATALOG, IC.INDEX_OWNER INDEX_SCHEMA, 
IC.INDEX_NAME, IC.COLUMN_NAME, IC.COLUMN_POSITION, DECODE(IC.DESCEND, 'ASC', 0, 1) DESCENDING FROM SYS.ALL_IND_COLUMNS IC, 
SYS.ALL_INDEXES I, SYS.ALL_CONSTRAINTS C WHERE IC.TABLE_OWNER = 'FRIOBOM' AND IC.TABLE_NAME = 'PCFORMCONFIG' AND I.UNIQUENESS = 
'UNIQUE' AND        I.OWNER = IC.INDEX_OWNER AND I.INDEX_NAME = IC.INDEX_NAME AND       C.TABLE_NAME (+) = IC.TABLE_NAME AND 
C.INDEX_NAME (+) = IC.INDEX_NAME AND C.OWNER (+)= IC.TABLE_OWNER ORDER BY DECODE(IC.INDEX_OWNER, 'FRIOBOM', 0, 'PUBLIC', 1, 2), 
DECODE(C.CONSTRAINT_TYPE, 'P', 1, 'U', 2, 3), IC.INDEX_OWNER, IC.TABLE_OWNER, IC.TABLE_NAME, IC.INDEX_NAME, IC.COLUMN_POSITION
----------------------------------
Timestamp: 14:45:47.388
UPDATE PCFORMCONFIG
SET
  ARQUIVO=EMPTY_BLOB()
WHERE
  CODIGO = :Old_CODIGO
RETURNING
  ARQUIVO
INTO
  :ARQUIVO
Old_CODIGO = 11086
----------------------------------
Timestamp: 14:45:47.445
Successful commit.
----------------------------------
Timestamp: 14:45:47.451
SELECT * FROM PCFORMCONFIG
WHERE ROTINA = :ROTINA
  AND MATRICULA = :MATRICULA
  AND NOME = :NOME
ROTINA = 1203
MATRICULA = 1261
NOME = '1'
----------------------------------
Timestamp: 14:45:47.517
Successful commit.
----------------------------------
Timestamp: 14:45:47.520
begin  :result := sys.dbms_transaction.local_transaction_id(true); end;
result = '8.8.7558794'
----------------------------------
Timestamp: 14:45:47.573
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '8.8.7558794'
----------------------------------
Timestamp: 14:45:47.601
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '8.8.7558794'
----------------------------------
Timestamp: 14:45:47.636
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '8.8.7558794'
----------------------------------
Timestamp: 14:45:47.670
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '8.8.7558794'
----------------------------------
Timestamp: 14:45:47.702
SELECT '' TABLE_CATALOG, IC.TABLE_OWNER TABLE_SCHEMA, IC.TABLE_NAME, '' INDEX_CATALOG, IC.INDEX_OWNER INDEX_SCHEMA, 
IC.INDEX_NAME, IC.COLUMN_NAME, IC.COLUMN_POSITION, DECODE(IC.DESCEND, 'ASC', 0, 1) DESCENDING FROM SYS.ALL_IND_COLUMNS IC, 
SYS.ALL_INDEXES I, SYS.ALL_CONSTRAINTS C WHERE IC.TABLE_OWNER = 'FRIOBOM' AND IC.TABLE_NAME = 'PCFORMCONFIG' AND I.UNIQUENESS = 
'UNIQUE' AND        I.OWNER = IC.INDEX_OWNER AND I.INDEX_NAME = IC.INDEX_NAME AND       C.TABLE_NAME (+) = IC.TABLE_NAME AND 
C.INDEX_NAME (+) = IC.INDEX_NAME AND C.OWNER (+)= IC.TABLE_OWNER ORDER BY DECODE(IC.INDEX_OWNER, 'FRIOBOM', 0, 'PUBLIC', 1, 2), 
DECODE(C.CONSTRAINT_TYPE, 'P', 1, 'U', 2, 3), IC.INDEX_OWNER, IC.TABLE_OWNER, IC.TABLE_NAME, IC.INDEX_NAME, IC.COLUMN_POSITION
----------------------------------
Timestamp: 14:45:47.728
UPDATE PCFORMCONFIG
SET
  ARQUIVO=EMPTY_BLOB()
WHERE
  CODIGO = :Old_CODIGO
RETURNING
  ARQUIVO
INTO
  :ARQUIVO
Old_CODIGO = 11087
----------------------------------
Timestamp: 14:45:47.783
Successful commit.
----------------------------------
Timestamp: 14:45:47.790
SELECT * FROM PCFORMCONFIG
WHERE ROTINA = :ROTINA
  AND MATRICULA = :MATRICULA
  AND NOME = :NOME
ROTINA = 1203
MATRICULA = 1261
NOME = '1'
----------------------------------
Timestamp: 14:45:47.854
Successful commit.
----------------------------------
Timestamp: 14:45:47.856
begin  :result := sys.dbms_transaction.local_transaction_id(true); end;
result = '47.14.1808747'
----------------------------------
Timestamp: 14:45:47.906
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '47.14.1808747'
----------------------------------
Timestamp: 14:45:47.948
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '47.14.1808747'
----------------------------------
Timestamp: 14:45:47.997
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '47.14.1808747'
----------------------------------
Timestamp: 14:45:48.029
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '47.14.1808747'
----------------------------------
Timestamp: 14:45:48.063
SELECT '' TABLE_CATALOG, IC.TABLE_OWNER TABLE_SCHEMA, IC.TABLE_NAME, '' INDEX_CATALOG, IC.INDEX_OWNER INDEX_SCHEMA, 
IC.INDEX_NAME, IC.COLUMN_NAME, IC.COLUMN_POSITION, DECODE(IC.DESCEND, 'ASC', 0, 1) DESCENDING FROM SYS.ALL_IND_COLUMNS IC, 
SYS.ALL_INDEXES I, SYS.ALL_CONSTRAINTS C WHERE IC.TABLE_OWNER = 'FRIOBOM' AND IC.TABLE_NAME = 'PCFORMCONFIG' AND I.UNIQUENESS = 
'UNIQUE' AND        I.OWNER = IC.INDEX_OWNER AND I.INDEX_NAME = IC.INDEX_NAME AND       C.TABLE_NAME (+) = IC.TABLE_NAME AND 
C.INDEX_NAME (+) = IC.INDEX_NAME AND C.OWNER (+)= IC.TABLE_OWNER ORDER BY DECODE(IC.INDEX_OWNER, 'FRIOBOM', 0, 'PUBLIC', 1, 2), 
DECODE(C.CONSTRAINT_TYPE, 'P', 1, 'U', 2, 3), IC.INDEX_OWNER, IC.TABLE_OWNER, IC.TABLE_NAME, IC.INDEX_NAME, IC.COLUMN_POSITION
----------------------------------
Timestamp: 14:45:48.087
UPDATE PCFORMCONFIG
SET
  ARQUIVO=EMPTY_BLOB()
WHERE
  CODIGO = :Old_CODIGO
RETURNING
  ARQUIVO
INTO
  :ARQUIVO
Old_CODIGO = 11088
----------------------------------
Timestamp: 14:45:48.140
Successful commit.
----------------------------------
Timestamp: 14:45:48.147
SELECT * FROM PCFORMCONFIG
WHERE ROTINA = :ROTINA
  AND MATRICULA = :MATRICULA
  AND NOME = :NOME
ROTINA = 1203
MATRICULA = 1261
NOME = '1'
----------------------------------
Timestamp: 14:45:48.222
Successful commit.
----------------------------------
Timestamp: 14:45:48.223
begin  :result := sys.dbms_transaction.local_transaction_id(true); end;
result = '28.13.6735032'
----------------------------------
Timestamp: 14:45:48.265
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '28.13.6735032'
----------------------------------
Timestamp: 14:45:48.304
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '28.13.6735032'
----------------------------------
Timestamp: 14:45:48.336
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '28.13.6735032'
----------------------------------
Timestamp: 14:45:48.369
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '28.13.6735032'
----------------------------------
Timestamp: 14:45:48.403
SELECT '' TABLE_CATALOG, IC.TABLE_OWNER TABLE_SCHEMA, IC.TABLE_NAME, '' INDEX_CATALOG, IC.INDEX_OWNER INDEX_SCHEMA, 
IC.INDEX_NAME, IC.COLUMN_NAME, IC.COLUMN_POSITION, DECODE(IC.DESCEND, 'ASC', 0, 1) DESCENDING FROM SYS.ALL_IND_COLUMNS IC, 
SYS.ALL_INDEXES I, SYS.ALL_CONSTRAINTS C WHERE IC.TABLE_OWNER = 'FRIOBOM' AND IC.TABLE_NAME = 'PCFORMCONFIG' AND I.UNIQUENESS = 
'UNIQUE' AND        I.OWNER = IC.INDEX_OWNER AND I.INDEX_NAME = IC.INDEX_NAME AND       C.TABLE_NAME (+) = IC.TABLE_NAME AND 
C.INDEX_NAME (+) = IC.INDEX_NAME AND C.OWNER (+)= IC.TABLE_OWNER ORDER BY DECODE(IC.INDEX_OWNER, 'FRIOBOM', 0, 'PUBLIC', 1, 2), 
DECODE(C.CONSTRAINT_TYPE, 'P', 1, 'U', 2, 3), IC.INDEX_OWNER, IC.TABLE_OWNER, IC.TABLE_NAME, IC.INDEX_NAME, IC.COLUMN_POSITION
----------------------------------
Timestamp: 14:45:48.429
UPDATE PCFORMCONFIG
SET
  ARQUIVO=EMPTY_BLOB()
WHERE
  CODIGO = :Old_CODIGO
RETURNING
  ARQUIVO
INTO
  :ARQUIVO
Old_CODIGO = 11089
----------------------------------
Timestamp: 14:45:48.503
Successful commit.
----------------------------------
Timestamp: 14:45:48.507
SELECT * FROM PCFORMCONFIG
WHERE ROTINA = :ROTINA
  AND MATRICULA = :MATRICULA
  AND NOME = :NOME
ROTINA = 1203
MATRICULA = 1261
NOME = '1'
----------------------------------
Timestamp: 14:45:48.575
Successful commit.
----------------------------------
Timestamp: 14:45:48.576
begin  :result := sys.dbms_transaction.local_transaction_id(true); end;
result = '7.20.6521554'
----------------------------------
Timestamp: 14:45:48.618
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '7.20.6521554'
----------------------------------
Timestamp: 14:45:48.651
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '7.20.6521554'
----------------------------------
Timestamp: 14:45:48.686
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '7.20.6521554'
----------------------------------
Timestamp: 14:45:48.719
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '7.20.6521554'
----------------------------------
Timestamp: 14:45:48.753
SELECT '' TABLE_CATALOG, IC.TABLE_OWNER TABLE_SCHEMA, IC.TABLE_NAME, '' INDEX_CATALOG, IC.INDEX_OWNER INDEX_SCHEMA, 
IC.INDEX_NAME, IC.COLUMN_NAME, IC.COLUMN_POSITION, DECODE(IC.DESCEND, 'ASC', 0, 1) DESCENDING FROM SYS.ALL_IND_COLUMNS IC, 
SYS.ALL_INDEXES I, SYS.ALL_CONSTRAINTS C WHERE IC.TABLE_OWNER = 'FRIOBOM' AND IC.TABLE_NAME = 'PCFORMCONFIG' AND I.UNIQUENESS = 
'UNIQUE' AND        I.OWNER = IC.INDEX_OWNER AND I.INDEX_NAME = IC.INDEX_NAME AND       C.TABLE_NAME (+) = IC.TABLE_NAME AND 
C.INDEX_NAME (+) = IC.INDEX_NAME AND C.OWNER (+)= IC.TABLE_OWNER ORDER BY DECODE(IC.INDEX_OWNER, 'FRIOBOM', 0, 'PUBLIC', 1, 2), 
DECODE(C.CONSTRAINT_TYPE, 'P', 1, 'U', 2, 3), IC.INDEX_OWNER, IC.TABLE_OWNER, IC.TABLE_NAME, IC.INDEX_NAME, IC.COLUMN_POSITION
----------------------------------
Timestamp: 14:45:48.780
UPDATE PCFORMCONFIG
SET
  ARQUIVO=EMPTY_BLOB()
WHERE
  CODIGO = :Old_CODIGO
RETURNING
  ARQUIVO
INTO
  :ARQUIVO
Old_CODIGO = 11090
----------------------------------
Timestamp: 14:45:48.825
Successful commit.
----------------------------------
Timestamp: 14:45:48.828
SELECT * FROM PCFORMCONFIG
WHERE ROTINA = :ROTINA
  AND MATRICULA = :MATRICULA
  AND NOME = :NOME
ROTINA = 1203
MATRICULA = 1261
NOME = '1'
----------------------------------
Timestamp: 14:45:48.900
Successful commit.
----------------------------------
Timestamp: 14:45:48.901
begin  :result := sys.dbms_transaction.local_transaction_id(true); end;
result = '62.23.1705921'
----------------------------------
Timestamp: 14:45:48.950
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '62.23.1705921'
----------------------------------
Timestamp: 14:45:48.985
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '62.23.1705921'
----------------------------------
Timestamp: 14:45:49.021
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '62.23.1705921'
----------------------------------
Timestamp: 14:45:49.056
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '62.23.1705921'
----------------------------------
Timestamp: 14:45:49.087
SELECT '' TABLE_CATALOG, IC.TABLE_OWNER TABLE_SCHEMA, IC.TABLE_NAME, '' INDEX_CATALOG, IC.INDEX_OWNER INDEX_SCHEMA, 
IC.INDEX_NAME, IC.COLUMN_NAME, IC.COLUMN_POSITION, DECODE(IC.DESCEND, 'ASC', 0, 1) DESCENDING FROM SYS.ALL_IND_COLUMNS IC, 
SYS.ALL_INDEXES I, SYS.ALL_CONSTRAINTS C WHERE IC.TABLE_OWNER = 'FRIOBOM' AND IC.TABLE_NAME = 'PCFORMCONFIG' AND I.UNIQUENESS = 
'UNIQUE' AND        I.OWNER = IC.INDEX_OWNER AND I.INDEX_NAME = IC.INDEX_NAME AND       C.TABLE_NAME (+) = IC.TABLE_NAME AND 
C.INDEX_NAME (+) = IC.INDEX_NAME AND C.OWNER (+)= IC.TABLE_OWNER ORDER BY DECODE(IC.INDEX_OWNER, 'FRIOBOM', 0, 'PUBLIC', 1, 2), 
DECODE(C.CONSTRAINT_TYPE, 'P', 1, 'U', 2, 3), IC.INDEX_OWNER, IC.TABLE_OWNER, IC.TABLE_NAME, IC.INDEX_NAME, IC.COLUMN_POSITION
----------------------------------
Timestamp: 14:45:49.113
UPDATE PCFORMCONFIG
SET
  ARQUIVO=EMPTY_BLOB()
WHERE
  CODIGO = :Old_CODIGO
RETURNING
  ARQUIVO
INTO
  :ARQUIVO
Old_CODIGO = 11091
----------------------------------
Timestamp: 14:45:49.187
Successful commit.
----------------------------------
Timestamp: 14:45:49.192
SELECT * FROM PCFORMCONFIG
WHERE ROTINA = :ROTINA
  AND MATRICULA = :MATRICULA
  AND NOME = :NOME
ROTINA = 1203
MATRICULA = 1261
NOME = '1'
----------------------------------
Timestamp: 14:45:49.259
Successful commit.
----------------------------------
Timestamp: 14:45:49.260
begin  :result := sys.dbms_transaction.local_transaction_id(true); end;
result = '47.0.1808013'
----------------------------------
Timestamp: 14:45:49.311
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '47.0.1808013'
----------------------------------
Timestamp: 14:45:49.348
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '47.0.1808013'
----------------------------------
Timestamp: 14:45:49.383
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '47.0.1808013'
----------------------------------
Timestamp: 14:45:49.418
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '47.0.1808013'
----------------------------------
Timestamp: 14:45:49.452
SELECT '' TABLE_CATALOG, IC.TABLE_OWNER TABLE_SCHEMA, IC.TABLE_NAME, '' INDEX_CATALOG, IC.INDEX_OWNER INDEX_SCHEMA, 
IC.INDEX_NAME, IC.COLUMN_NAME, IC.COLUMN_POSITION, DECODE(IC.DESCEND, 'ASC', 0, 1) DESCENDING FROM SYS.ALL_IND_COLUMNS IC, 
SYS.ALL_INDEXES I, SYS.ALL_CONSTRAINTS C WHERE IC.TABLE_OWNER = 'FRIOBOM' AND IC.TABLE_NAME = 'PCFORMCONFIG' AND I.UNIQUENESS = 
'UNIQUE' AND        I.OWNER = IC.INDEX_OWNER AND I.INDEX_NAME = IC.INDEX_NAME AND       C.TABLE_NAME (+) = IC.TABLE_NAME AND 
C.INDEX_NAME (+) = IC.INDEX_NAME AND C.OWNER (+)= IC.TABLE_OWNER ORDER BY DECODE(IC.INDEX_OWNER, 'FRIOBOM', 0, 'PUBLIC', 1, 2), 
DECODE(C.CONSTRAINT_TYPE, 'P', 1, 'U', 2, 3), IC.INDEX_OWNER, IC.TABLE_OWNER, IC.TABLE_NAME, IC.INDEX_NAME, IC.COLUMN_POSITION
----------------------------------
Timestamp: 14:45:49.497
UPDATE PCFORMCONFIG
SET
  ARQUIVO=EMPTY_BLOB()
WHERE
  CODIGO = :Old_CODIGO
RETURNING
  ARQUIVO
INTO
  :ARQUIVO
Old_CODIGO = 11092
----------------------------------
Timestamp: 14:45:49.550
Successful commit.
----------------------------------
Timestamp: 14:45:49.554
SELECT * FROM PCFORMCONFIG
WHERE ROTINA = :ROTINA
  AND MATRICULA = :MATRICULA
  AND NOME = :NOME
ROTINA = 1203
MATRICULA = 1261
NOME = '1'
----------------------------------
Timestamp: 14:45:49.618
Successful commit.
----------------------------------
Timestamp: 14:45:49.619
begin  :result := sys.dbms_transaction.local_transaction_id(true); end;
result = '29.8.5185594'
----------------------------------
Timestamp: 14:45:49.665
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '29.8.5185594'
----------------------------------
Timestamp: 14:45:49.707
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '29.8.5185594'
----------------------------------
Timestamp: 14:45:49.738
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '29.8.5185594'
----------------------------------
Timestamp: 14:45:49.773
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '29.8.5185594'
----------------------------------
Timestamp: 14:45:49.808
SELECT '' TABLE_CATALOG, IC.TABLE_OWNER TABLE_SCHEMA, IC.TABLE_NAME, '' INDEX_CATALOG, IC.INDEX_OWNER INDEX_SCHEMA, 
IC.INDEX_NAME, IC.COLUMN_NAME, IC.COLUMN_POSITION, DECODE(IC.DESCEND, 'ASC', 0, 1) DESCENDING FROM SYS.ALL_IND_COLUMNS IC, 
SYS.ALL_INDEXES I, SYS.ALL_CONSTRAINTS C WHERE IC.TABLE_OWNER = 'FRIOBOM' AND IC.TABLE_NAME = 'PCFORMCONFIG' AND I.UNIQUENESS = 
'UNIQUE' AND        I.OWNER = IC.INDEX_OWNER AND I.INDEX_NAME = IC.INDEX_NAME AND       C.TABLE_NAME (+) = IC.TABLE_NAME AND 
C.INDEX_NAME (+) = IC.INDEX_NAME AND C.OWNER (+)= IC.TABLE_OWNER ORDER BY DECODE(IC.INDEX_OWNER, 'FRIOBOM', 0, 'PUBLIC', 1, 2), 
DECODE(C.CONSTRAINT_TYPE, 'P', 1, 'U', 2, 3), IC.INDEX_OWNER, IC.TABLE_OWNER, IC.TABLE_NAME, IC.INDEX_NAME, IC.COLUMN_POSITION
----------------------------------
Timestamp: 14:45:49.832
UPDATE PCFORMCONFIG
SET
  ARQUIVO=EMPTY_BLOB()
WHERE
  CODIGO = :Old_CODIGO
RETURNING
  ARQUIVO
INTO
  :ARQUIVO
Old_CODIGO = 11093
----------------------------------
Timestamp: 14:45:49.882
Successful commit.
----------------------------------
Timestamp: 14:45:49.888
SELECT * FROM PCFORMCONFIG
WHERE ROTINA = :ROTINA
  AND MATRICULA = :MATRICULA
  AND NOME = :NOME
ROTINA = 1203
MATRICULA = 1261
NOME = '1'
----------------------------------
Timestamp: 14:45:49.967
Successful commit.
----------------------------------
Timestamp: 14:45:49.969
begin  :result := sys.dbms_transaction.local_transaction_id(true); end;
result = '18.6.9761916'
----------------------------------
Timestamp: 14:45:50.022
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '18.6.9761916'
----------------------------------
Timestamp: 14:45:50.065
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '18.6.9761916'
----------------------------------
Timestamp: 14:45:50.110
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '18.6.9761916'
----------------------------------
Timestamp: 14:45:50.137
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '18.6.9761916'
----------------------------------
Timestamp: 14:45:50.171
SELECT '' TABLE_CATALOG, IC.TABLE_OWNER TABLE_SCHEMA, IC.TABLE_NAME, '' INDEX_CATALOG, IC.INDEX_OWNER INDEX_SCHEMA, 
IC.INDEX_NAME, IC.COLUMN_NAME, IC.COLUMN_POSITION, DECODE(IC.DESCEND, 'ASC', 0, 1) DESCENDING FROM SYS.ALL_IND_COLUMNS IC, 
SYS.ALL_INDEXES I, SYS.ALL_CONSTRAINTS C WHERE IC.TABLE_OWNER = 'FRIOBOM' AND IC.TABLE_NAME = 'PCFORMCONFIG' AND I.UNIQUENESS = 
'UNIQUE' AND        I.OWNER = IC.INDEX_OWNER AND I.INDEX_NAME = IC.INDEX_NAME AND       C.TABLE_NAME (+) = IC.TABLE_NAME AND 
C.INDEX_NAME (+) = IC.INDEX_NAME AND C.OWNER (+)= IC.TABLE_OWNER ORDER BY DECODE(IC.INDEX_OWNER, 'FRIOBOM', 0, 'PUBLIC', 1, 2), 
DECODE(C.CONSTRAINT_TYPE, 'P', 1, 'U', 2, 3), IC.INDEX_OWNER, IC.TABLE_OWNER, IC.TABLE_NAME, IC.INDEX_NAME, IC.COLUMN_POSITION
----------------------------------
Timestamp: 14:45:50.196
UPDATE PCFORMCONFIG
SET
  ARQUIVO=EMPTY_BLOB()
WHERE
  CODIGO = :Old_CODIGO
RETURNING
  ARQUIVO
INTO
  :ARQUIVO
Old_CODIGO = 11094
----------------------------------
Timestamp: 14:45:50.252
Successful commit.
----------------------------------
Timestamp: 14:46:12.201
SELECT CODCLI,
       CLIENTE,
       FANTASIA,
       CGCENT CGC,
       IEENT,
       ENDERENT,
       BAIRROENT,
       ESTENT,
       CODCIDADE,
       CEPENT,
       TIPOFJ,
       CONSUMIDORFINAL,
       TIPOEMPRESA,
       CODATV1,
       CLIENTEFONTEST,
       SULFRAMA,
       CODCLIPRINC,
       TELENT,
       EMAIL
  FROM PCCLIENT
 WHERE CODCLI IS NOT NULL
 AND CODCLI = NUMEROS( :PARAM1 )
PARAM1 = '4509'
----------------------------------
Timestamp: 14:46:14.152
SELECT CODCLI,
       CLIENTE,
       FANTASIA,
       CGCENT CGC,
       IEENT,
       ENDERENT,
       BAIRROENT,
       ESTENT,
       CODCIDADE,
       CEPENT,
       TIPOFJ,
       CONSUMIDORFINAL,
       TIPOEMPRESA,
       CODATV1,
       CLIENTEFONTEST,
       SULFRAMA,
       CODCLIPRINC,
       TELENT,
       EMAIL
  FROM PCCLIENT
 WHERE CODCLI IS NOT NULL
 AND CODCLI = NUMEROS( :PARAM1 )
PARAM1 = '4509'
----------------------------------
Timestamp: 14:46:14.284
SELECT C.CODCLI
     , C.CLIENTE
     , C.FANTASIA
     , C.CODUSUR1
     , C.CODPRACA
     , DECODE(C.BLOQUEIOSEFAZ, 'S', C.BLOQUEIOSEFAZ, 'N') BLOQUEIOSEFAZ           
     , DECODE(C.BLOQUEIOSEFAZPED, 'S', C.BLOQUEIOSEFAZPED, 'N') BLOQUEIOSEFAZPED  
     , C.DTVALIDASEFAZ                                                                
     , C.MUNICENT
     , C.ESTENT
     , C.DTBLOQ
     , C.CODFILIALNF    
     , C.DTVENCLIMCRED
     , C.DTEXCLUSAO
     , U.CODUSUR CODRCA
     , U.NOME AS NOMERCA
     , U.CODSUPERVISOR
     , C.CODCLIPRINC                                                
     , NVL(C.ANALISECRED, 'N') ANALISECRED                        
     , S.NOME AS NOMESUPERVISOR                                     
     , CPRINC.CLIENTE CLIENTEPRINCIPAL                              
     , C.CODCOB                                                     
     , CASE                                                         
         WHEN C.DTBLOQ IS NOT NULL AND C.BLOQUEIO='S' THEN 'S'  
         ELSE 'N' 
       END BLOQUEIO 
     , (SELECT COUNT(1) 
          FROM PCPREST                                    
         WHERE CODCLI=C.CODCLI
           AND CODCOB IN ('CHDV', 'CHD1', 'CHD3')  
           AND DTPAG IS NULL 
           AND NUMCHEQUE IS NOT NULL 
           AND NUMBANCO IS NOT NULL) QTCHQDEV                  
     , 'Não filtrado' NOMECONTATO 
     , C.CGCENT                             
     , C.DTVENCLIMCRED 
     , (SELECT LIMITECREDDISPONSUPPLI FROM PCSUPPLICLIENTE WHERE CODCLI = C.CODCLI) AS LIMITECREDSUPPLI 
     , C.DTULTCONSULTASERASA 
  FROM PCCLIENT C 
     , PCCLIENT CPRINC 
     , PCUSUARI U 
     , PCSUPERV S 
     , (SELECT MAX(U.CODUSUR) CODUSUR,MAX(U.NOME) NOMERCA,                   
               MAX(S.CODSUPERVISOR) CODSUPERVISOR,MAX(S.NOME) SUPERVISOR,    
               W.CODCLI                                                      
          FROM VW_CLIENTESRCA W
             , PCUSUARI U
             , PCSUPERV S
             , PCCLIENT V            
         WHERE NVL(NVL(V.CODUSUR1,V.CODUSUR2),W.CODUSUR) = U.CODUSUR          
           AND V.CODCLI=W.CODCLI(+)                                          
           AND S.CODSUPERVISOR=U.CODSUPERVISOR                               
      GROUP BY W.CODCLI) T
 WHERE C.CODCLI > 0
   AND C.CODCLI=T.CODCLI
   AND T.CODUSUR=U.CODUSUR(+)
   AND C.DTCADASTRO >= (SELECT MIN(DTCADASTRO) FROM PCCLIENT)
   AND T.CODSUPERVISOR=S.CODSUPERVISOR(+)
   AND C.CODCLIPRINC = CPRINC.CODCLI(+)
   AND(C.CODCLI IN ( 4509 )) 
   AND TRUNC(C.DTCADASTRO) BETWEEN TRUNC(:DTCAD1) AND TRUNC(:DTCAD2)
   AND (NVL(C.CODFILIALNF,'X') IN ( '2','X','99' )) 
   AND --Script para retornar apenas registros com permissão rotina 131  
 EXISTS( SELECT 1                                                 
           FROM PCLIB                                             
          WHERE CODTABELA = TO_CHAR(1)                           
            AND (CODIGOA  = NVL(C.CODFILIALNF, CODIGOA) OR CODIGOA = '99') 
            AND CODFUNC   = 1261                                    
            AND PCLIB.CODIGOA IS NOT NULL)                        
ORDER BY C.CLIENTE
DTCAD1 = '01/01/2023'
DTCAD2 = '31/12/2023'
----------------------------------
Timestamp: 14:50:38.476
SELECT CODCLI,
       CLIENTE,
       FANTASIA,
       CGCENT CGC,
       IEENT,
       ENDERENT,
       BAIRROENT,
       ESTENT,
       CODCIDADE,
       CEPENT,
       TIPOFJ,
       CONSUMIDORFINAL,
       TIPOEMPRESA,
       CODATV1,
       CLIENTEFONTEST,
       SULFRAMA,
       CODCLIPRINC,
       TELENT,
       EMAIL
  FROM PCCLIENT
 WHERE CODCLI IS NOT NULL
 AND CODCLI = NUMEROS( :PARAM1 )
PARAM1 = '4509'
----------------------------------
Timestamp: 14:50:47.519
SELECT CODCLI,
       CLIENTE,
       FANTASIA,
       CGCENT CGC,
       IEENT,
       ENDERENT,
       BAIRROENT,
       ESTENT,
       CODCIDADE,
       CEPENT,
       TIPOFJ,
       CONSUMIDORFINAL,
       TIPOEMPRESA,
       CODATV1,
       CLIENTEFONTEST,
       SULFRAMA,
       CODCLIPRINC,
       TELENT,
       EMAIL
  FROM PCCLIENT
 WHERE CODCLI IS NOT NULL
 AND UPPER(CLIENTE) LIKE  UPPER( :PARAM1 ) || '%' ORDER BY CLIENTE
PARAM1 = '%HADA'
----------------------------------
Timestamp: 14:50:50.451
SELECT CODCLI,
       CLIENTE,
       FANTASIA,
       CGCENT CGC,
       IEENT,
       ENDERENT,
       BAIRROENT,
       ESTENT,
       CODCIDADE,
       CEPENT,
       TIPOFJ,
       CONSUMIDORFINAL,
       TIPOEMPRESA,
       CODATV1,
       CLIENTEFONTEST,
       SULFRAMA,
       CODCLIPRINC,
       TELENT,
       EMAIL
  FROM PCCLIENT
 WHERE CODCLI IS NOT NULL
 AND CODCLI = NUMEROS( :PARAM1 )
PARAM1 = '119859'
----------------------------------
Timestamp: 14:50:50.608
SELECT CODCLI,
       CLIENTE,
       FANTASIA,
       CGCENT CGC,
       IEENT,
       ENDERENT,
       BAIRROENT,
       ESTENT,
       CODCIDADE,
       CEPENT,
       TIPOFJ,
       CONSUMIDORFINAL,
       TIPOEMPRESA,
       CODATV1,
       CLIENTEFONTEST,
       SULFRAMA,
       CODCLIPRINC,
       TELENT,
       EMAIL
  FROM PCCLIENT
 WHERE CODCLI IS NOT NULL
 AND CODCLI = NUMEROS( :PARAM1 )
PARAM1 = '119859'
----------------------------------
Timestamp: 14:50:50.716
SELECT C.CODCLI
     , C.CLIENTE
     , C.FANTASIA
     , C.CODUSUR1
     , C.CODPRACA
     , DECODE(C.BLOQUEIOSEFAZ, 'S', C.BLOQUEIOSEFAZ, 'N') BLOQUEIOSEFAZ           
     , DECODE(C.BLOQUEIOSEFAZPED, 'S', C.BLOQUEIOSEFAZPED, 'N') BLOQUEIOSEFAZPED  
     , C.DTVALIDASEFAZ                                                                
     , C.MUNICENT
     , C.ESTENT
     , C.DTBLOQ
     , C.CODFILIALNF    
     , C.DTVENCLIMCRED
     , C.DTEXCLUSAO
     , U.CODUSUR CODRCA
     , U.NOME AS NOMERCA
     , U.CODSUPERVISOR
     , C.CODCLIPRINC                                                
     , NVL(C.ANALISECRED, 'N') ANALISECRED                        
     , S.NOME AS NOMESUPERVISOR                                     
     , CPRINC.CLIENTE CLIENTEPRINCIPAL                              
     , C.CODCOB                                                     
     , CASE                                                         
         WHEN C.DTBLOQ IS NOT NULL AND C.BLOQUEIO='S' THEN 'S'  
         ELSE 'N' 
       END BLOQUEIO 
     , (SELECT COUNT(1) 
          FROM PCPREST                                    
         WHERE CODCLI=C.CODCLI
           AND CODCOB IN ('CHDV', 'CHD1', 'CHD3')  
           AND DTPAG IS NULL 
           AND NUMCHEQUE IS NOT NULL 
           AND NUMBANCO IS NOT NULL) QTCHQDEV                  
     , 'Não filtrado' NOMECONTATO 
     , C.CGCENT                             
     , C.DTVENCLIMCRED 
     , (SELECT LIMITECREDDISPONSUPPLI FROM PCSUPPLICLIENTE WHERE CODCLI = C.CODCLI) AS LIMITECREDSUPPLI 
     , C.DTULTCONSULTASERASA 
  FROM PCCLIENT C 
     , PCCLIENT CPRINC 
     , PCUSUARI U 
     , PCSUPERV S 
     , (SELECT MAX(U.CODUSUR) CODUSUR,MAX(U.NOME) NOMERCA,                   
               MAX(S.CODSUPERVISOR) CODSUPERVISOR,MAX(S.NOME) SUPERVISOR,    
               W.CODCLI                                                      
          FROM VW_CLIENTESRCA W
             , PCUSUARI U
             , PCSUPERV S
             , PCCLIENT V            
         WHERE NVL(NVL(V.CODUSUR1,V.CODUSUR2),W.CODUSUR) = U.CODUSUR          
           AND V.CODCLI=W.CODCLI(+)                                          
           AND S.CODSUPERVISOR=U.CODSUPERVISOR                               
      GROUP BY W.CODCLI) T
 WHERE C.CODCLI > 0
   AND C.CODCLI=T.CODCLI
   AND T.CODUSUR=U.CODUSUR(+)
   AND C.DTCADASTRO >= (SELECT MIN(DTCADASTRO) FROM PCCLIENT)
   AND T.CODSUPERVISOR=S.CODSUPERVISOR(+)
   AND C.CODCLIPRINC = CPRINC.CODCLI(+)
   AND(C.CODCLI IN ( 119859 )) 
   AND TRUNC(C.DTCADASTRO) BETWEEN TRUNC(:DTCAD1) AND TRUNC(:DTCAD2)
   AND (NVL(C.CODFILIALNF,'X') IN ( '2','X','99' )) 
   AND --Script para retornar apenas registros com permissão rotina 131  
 EXISTS( SELECT 1                                                 
           FROM PCLIB                                             
          WHERE CODTABELA = TO_CHAR(1)                           
            AND (CODIGOA  = NVL(C.CODFILIALNF, CODIGOA) OR CODIGOA = '99') 
            AND CODFUNC   = 1261                                    
            AND PCLIB.CODIGOA IS NOT NULL)                        
ORDER BY C.CLIENTE
DTCAD1 = '01/01/2023'
DTCAD2 = '31/12/2023'
----------------------------------
Timestamp: 14:51:00.849
SELECT CODCLI,
       CLIENTE,
       FANTASIA,
       CGCENT CGC,
       IEENT,
       ENDERENT,
       BAIRROENT,
       ESTENT,
       CODCIDADE,
       CEPENT,
       TIPOFJ,
       CONSUMIDORFINAL,
       TIPOEMPRESA,
       CODATV1,
       CLIENTEFONTEST,
       SULFRAMA,
       CODCLIPRINC,
       TELENT,
       EMAIL
  FROM PCCLIENT
 WHERE CODCLI IS NOT NULL
 AND UPPER(CLIENTE) LIKE  UPPER( :PARAM1 ) || '%' ORDER BY CLIENTE
PARAM1 = '%HADA'
----------------------------------
Timestamp: 14:51:49.112
SELECT CODCLI,
       CLIENTE,
       FANTASIA,
       CGCENT CGC,
       IEENT,
       ENDERENT,
       BAIRROENT,
       ESTENT,
       CODCIDADE,
       CEPENT,
       TIPOFJ,
       CONSUMIDORFINAL,
       TIPOEMPRESA,
       CODATV1,
       CLIENTEFONTEST,
       SULFRAMA,
       CODCLIPRINC,
       TELENT,
       EMAIL
  FROM PCCLIENT
 WHERE CODCLI IS NOT NULL
 AND UPPER(CLIENTE) LIKE  UPPER( :PARAM1 ) || '%' ORDER BY CLIENTE
PARAM1 = '%SUPERMECADO HADASSA'
----------------------------------
Timestamp: 14:51:50.043
SELECT CODCLI,
       CLIENTE,
       FANTASIA,
       CGCENT CGC,
       IEENT,
       ENDERENT,
       BAIRROENT,
       ESTENT,
       CODCIDADE,
       CEPENT,
       TIPOFJ,
       CONSUMIDORFINAL,
       TIPOEMPRESA,
       CODATV1,
       CLIENTEFONTEST,
       SULFRAMA,
       CODCLIPRINC,
       TELENT,
       EMAIL
  FROM PCCLIENT
 WHERE CODCLI IS NOT NULL
 AND UPPER(CLIENTE) LIKE  UPPER( :PARAM1 ) || '%' ORDER BY CLIENTE
PARAM1 = '%SUPERMECADO HADASSA'
----------------------------------
Timestamp: 14:51:59.699
SELECT CODCLI,
       CLIENTE,
       FANTASIA,
       CGCENT CGC,
       IEENT,
       ENDERENT,
       BAIRROENT,
       ESTENT,
       CODCIDADE,
       CEPENT,
       TIPOFJ,
       CONSUMIDORFINAL,
       TIPOEMPRESA,
       CODATV1,
       CLIENTEFONTEST,
       SULFRAMA,
       CODCLIPRINC,
       TELENT,
       EMAIL
  FROM PCCLIENT
 WHERE CODCLI IS NOT NULL
 AND UPPER(CLIENTE) LIKE  UPPER( :PARAM1 ) || '%' ORDER BY CLIENTE
PARAM1 = '%SUPERMERCADO HADASSA'
----------------------------------
Timestamp: 14:52:00.713
SELECT CODCLI,
       CLIENTE,
       FANTASIA,
       CGCENT CGC,
       IEENT,
       ENDERENT,
       BAIRROENT,
       ESTENT,
       CODCIDADE,
       CEPENT,
       TIPOFJ,
       CONSUMIDORFINAL,
       TIPOEMPRESA,
       CODATV1,
       CLIENTEFONTEST,
       SULFRAMA,
       CODCLIPRINC,
       TELENT,
       EMAIL
  FROM PCCLIENT
 WHERE CODCLI IS NOT NULL
 AND UPPER(CLIENTE) LIKE  UPPER( :PARAM1 ) || '%' ORDER BY CLIENTE
PARAM1 = '%SUPERMERCADO HADASSA'
----------------------------------
Timestamp: 14:52:00.890
SELECT CODCLI,
       CLIENTE,
       FANTASIA,
       CGCENT CGC,
       IEENT,
       ENDERENT,
       BAIRROENT,
       ESTENT,
       CODCIDADE,
       CEPENT,
       TIPOFJ,
       CONSUMIDORFINAL,
       TIPOEMPRESA,
       CODATV1,
       CLIENTEFONTEST,
       SULFRAMA,
       CODCLIPRINC,
       TELENT,
       EMAIL
  FROM PCCLIENT
 WHERE CODCLI IS NOT NULL
 AND UPPER(CLIENTE) LIKE  UPPER( :PARAM1 ) || '%' ORDER BY CLIENTE
PARAM1 = '%SUPERMERCADO HADASSA'
----------------------------------
Timestamp: 14:52:01.084
SELECT CODCLI,
       CLIENTE,
       FANTASIA,
       CGCENT CGC,
       IEENT,
       ENDERENT,
       BAIRROENT,
       ESTENT,
       CODCIDADE,
       CEPENT,
       TIPOFJ,
       CONSUMIDORFINAL,
       TIPOEMPRESA,
       CODATV1,
       CLIENTEFONTEST,
       SULFRAMA,
       CODCLIPRINC,
       TELENT,
       EMAIL
  FROM PCCLIENT
 WHERE CODCLI IS NOT NULL
 AND UPPER(CLIENTE) LIKE  UPPER( :PARAM1 ) || '%' ORDER BY CLIENTE
PARAM1 = '%SUPERMERCADO HADASSA'
----------------------------------
Timestamp: 14:52:06.684
SELECT CODCLI,
       CLIENTE,
       FANTASIA,
       CGCENT CGC,
       IEENT,
       ENDERENT,
       BAIRROENT,
       ESTENT,
       CODCIDADE,
       CEPENT,
       TIPOFJ,
       CONSUMIDORFINAL,
       TIPOEMPRESA,
       CODATV1,
       CLIENTEFONTEST,
       SULFRAMA,
       CODCLIPRINC,
       TELENT,
       EMAIL
  FROM PCCLIENT
 WHERE CODCLI IS NOT NULL
 AND UPPER(CLIENTE) LIKE  UPPER( :PARAM1 ) || '%' ORDER BY CLIENTE
PARAM1 = '%HADASSA'
----------------------------------
Timestamp: 14:53:47.253
SELECT CODCLI,
       CLIENTE,
       FANTASIA,
       CGCENT CGC,
       IEENT,
       ENDERENT,
       BAIRROENT,
       ESTENT,
       CODCIDADE,
       CEPENT,
       TIPOFJ,
       CONSUMIDORFINAL,
       TIPOEMPRESA,
       CODATV1,
       CLIENTEFONTEST,
       SULFRAMA,
       CODCLIPRINC,
       TELENT,
       EMAIL
  FROM PCCLIENT
 WHERE CODCLI IS NOT NULL
 AND CODCLI = NUMEROS( :PARAM1 )
PARAM1 = '119859'
----------------------------------
Timestamp: 14:53:47.365
SELECT CODCLI,
       CLIENTE,
       FANTASIA,
       CGCENT CGC,
       IEENT,
       ENDERENT,
       BAIRROENT,
       ESTENT,
       CODCIDADE,
       CEPENT,
       TIPOFJ,
       CONSUMIDORFINAL,
       TIPOEMPRESA,
       CODATV1,
       CLIENTEFONTEST,
       SULFRAMA,
       CODCLIPRINC,
       TELENT,
       EMAIL
  FROM PCCLIENT
 WHERE CODCLI IS NOT NULL
 AND CODCLI = NUMEROS( :PARAM1 )
PARAM1 = '119859'
----------------------------------
Timestamp: 14:53:47.462
SELECT C.CODCLI
     , C.CLIENTE
     , C.FANTASIA
     , C.CODUSUR1
     , C.CODPRACA
     , DECODE(C.BLOQUEIOSEFAZ, 'S', C.BLOQUEIOSEFAZ, 'N') BLOQUEIOSEFAZ           
     , DECODE(C.BLOQUEIOSEFAZPED, 'S', C.BLOQUEIOSEFAZPED, 'N') BLOQUEIOSEFAZPED  
     , C.DTVALIDASEFAZ                                                                
     , C.MUNICENT
     , C.ESTENT
     , C.DTBLOQ
     , C.CODFILIALNF    
     , C.DTVENCLIMCRED
     , C.DTEXCLUSAO
     , U.CODUSUR CODRCA
     , U.NOME AS NOMERCA
     , U.CODSUPERVISOR
     , C.CODCLIPRINC                                                
     , NVL(C.ANALISECRED, 'N') ANALISECRED                        
     , S.NOME AS NOMESUPERVISOR                                     
     , CPRINC.CLIENTE CLIENTEPRINCIPAL                              
     , C.CODCOB                                                     
     , CASE                                                         
         WHEN C.DTBLOQ IS NOT NULL AND C.BLOQUEIO='S' THEN 'S'  
         ELSE 'N' 
       END BLOQUEIO 
     , (SELECT COUNT(1) 
          FROM PCPREST                                    
         WHERE CODCLI=C.CODCLI
           AND CODCOB IN ('CHDV', 'CHD1', 'CHD3')  
           AND DTPAG IS NULL 
           AND NUMCHEQUE IS NOT NULL 
           AND NUMBANCO IS NOT NULL) QTCHQDEV                  
     , 'Não filtrado' NOMECONTATO 
     , C.CGCENT                             
     , C.DTVENCLIMCRED 
     , (SELECT LIMITECREDDISPONSUPPLI FROM PCSUPPLICLIENTE WHERE CODCLI = C.CODCLI) AS LIMITECREDSUPPLI 
     , C.DTULTCONSULTASERASA 
  FROM PCCLIENT C 
     , PCCLIENT CPRINC 
     , PCUSUARI U 
     , PCSUPERV S 
     , (SELECT MAX(U.CODUSUR) CODUSUR,MAX(U.NOME) NOMERCA,                   
               MAX(S.CODSUPERVISOR) CODSUPERVISOR,MAX(S.NOME) SUPERVISOR,    
               W.CODCLI                                                      
          FROM VW_CLIENTESRCA W
             , PCUSUARI U
             , PCSUPERV S
             , PCCLIENT V            
         WHERE NVL(NVL(V.CODUSUR1,V.CODUSUR2),W.CODUSUR) = U.CODUSUR          
           AND V.CODCLI=W.CODCLI(+)                                          
           AND S.CODSUPERVISOR=U.CODSUPERVISOR                               
      GROUP BY W.CODCLI) T
 WHERE C.CODCLI > 0
   AND C.CODCLI=T.CODCLI
   AND T.CODUSUR=U.CODUSUR(+)
   AND C.DTCADASTRO >= (SELECT MIN(DTCADASTRO) FROM PCCLIENT)
   AND T.CODSUPERVISOR=S.CODSUPERVISOR(+)
   AND C.CODCLIPRINC = CPRINC.CODCLI(+)
   AND(C.CODCLI IN ( 119859 )) 
   AND TRUNC(C.DTCADASTRO) BETWEEN TRUNC(:DTCAD1) AND TRUNC(:DTCAD2)
   AND (NVL(C.CODFILIALNF,'X') IN ( '2','X','99' )) 
   AND --Script para retornar apenas registros com permissão rotina 131  
 EXISTS( SELECT 1                                                 
           FROM PCLIB                                             
          WHERE CODTABELA = TO_CHAR(1)                           
            AND (CODIGOA  = NVL(C.CODFILIALNF, CODIGOA) OR CODIGOA = '99') 
            AND CODFUNC   = 1261                                    
            AND PCLIB.CODIGOA IS NOT NULL)                        
ORDER BY C.CLIENTE
DTCAD1 = '01/01/2023'
DTCAD2 = '31/12/2023'
----------------------------------
Timestamp: 14:54:07.718
SELECT CODCLI,
       CLIENTE,
       FANTASIA,
       CGCENT CGC,
       IEENT,
       ENDERENT,
       BAIRROENT,
       ESTENT,
       CODCIDADE,
       CEPENT,
       TIPOFJ,
       CONSUMIDORFINAL,
       TIPOEMPRESA,
       CODATV1,
       CLIENTEFONTEST,
       SULFRAMA,
       CODCLIPRINC,
       TELENT,
       EMAIL
  FROM PCCLIENT
 WHERE CODCLI IS NOT NULL
 AND CODCLI = NUMEROS( :PARAM1 )
PARAM1 = '119859'
----------------------------------
Timestamp: 14:54:07.843
SELECT C.CODCLI
     , C.CLIENTE
     , C.FANTASIA
     , C.CODUSUR1
     , C.CODPRACA
     , DECODE(C.BLOQUEIOSEFAZ, 'S', C.BLOQUEIOSEFAZ, 'N') BLOQUEIOSEFAZ           
     , DECODE(C.BLOQUEIOSEFAZPED, 'S', C.BLOQUEIOSEFAZPED, 'N') BLOQUEIOSEFAZPED  
     , C.DTVALIDASEFAZ                                                                
     , C.MUNICENT
     , C.ESTENT
     , C.DTBLOQ
     , C.CODFILIALNF    
     , C.DTVENCLIMCRED
     , C.DTEXCLUSAO
     , U.CODUSUR CODRCA
     , U.NOME AS NOMERCA
     , U.CODSUPERVISOR
     , C.CODCLIPRINC                                                
     , NVL(C.ANALISECRED, 'N') ANALISECRED                        
     , S.NOME AS NOMESUPERVISOR                                     
     , CPRINC.CLIENTE CLIENTEPRINCIPAL                              
     , C.CODCOB                                                     
     , CASE                                                         
         WHEN C.DTBLOQ IS NOT NULL AND C.BLOQUEIO='S' THEN 'S'  
         ELSE 'N' 
       END BLOQUEIO 
     , (SELECT COUNT(1) 
          FROM PCPREST                                    
         WHERE CODCLI=C.CODCLI
           AND CODCOB IN ('CHDV', 'CHD1', 'CHD3')  
           AND DTPAG IS NULL 
           AND NUMCHEQUE IS NOT NULL 
           AND NUMBANCO IS NOT NULL) QTCHQDEV                  
     , 'Não filtrado' NOMECONTATO 
     , C.CGCENT                             
     , C.DTVENCLIMCRED 
     , (SELECT LIMITECREDDISPONSUPPLI FROM PCSUPPLICLIENTE WHERE CODCLI = C.CODCLI) AS LIMITECREDSUPPLI 
     , C.DTULTCONSULTASERASA 
  FROM PCCLIENT C 
     , PCCLIENT CPRINC 
     , PCUSUARI U 
     , PCSUPERV S 
     , (SELECT MAX(U.CODUSUR) CODUSUR,MAX(U.NOME) NOMERCA,                   
               MAX(S.CODSUPERVISOR) CODSUPERVISOR,MAX(S.NOME) SUPERVISOR,    
               W.CODCLI                                                      
          FROM VW_CLIENTESRCA W
             , PCUSUARI U
             , PCSUPERV S
             , PCCLIENT V            
         WHERE NVL(NVL(V.CODUSUR1,V.CODUSUR2),W.CODUSUR) = U.CODUSUR          
           AND V.CODCLI=W.CODCLI(+)                                          
           AND S.CODSUPERVISOR=U.CODSUPERVISOR                               
      GROUP BY W.CODCLI) T
 WHERE C.CODCLI > 0
   AND C.CODCLI=T.CODCLI
   AND T.CODUSUR=U.CODUSUR(+)
   AND C.DTCADASTRO >= (SELECT MIN(DTCADASTRO) FROM PCCLIENT)
   AND T.CODSUPERVISOR=S.CODSUPERVISOR(+)
   AND C.CODCLIPRINC = CPRINC.CODCLI(+)
   AND(C.CODCLI IN ( 119859 )) 
   AND (NVL(C.CODFILIALNF,'X') IN ( '2','X','99' )) 
   AND --Script para retornar apenas registros com permissão rotina 131  
 EXISTS( SELECT 1                                                 
           FROM PCLIB                                             
          WHERE CODTABELA = TO_CHAR(1)                           
            AND (CODIGOA  = NVL(C.CODFILIALNF, CODIGOA) OR CODIGOA = '99') 
            AND CODFUNC   = 1261                                    
            AND PCLIB.CODIGOA IS NOT NULL)                        
ORDER BY C.CLIENTE
----------------------------------
Timestamp: 14:54:12.376
SELECT F.CODIGO
     , F.RAZAOSOCIAL
     , F.FANTASIA
     , F.CODIGO || ' - ' || F.RAZAOSOCIAL FILIAL
     , F.IE
     , F.CGC
     , F.TELEFONE
     , F.ENDERECO
     , F.EMAIL
     , NVL(F.NUMERO2, TO_CHAR(F.NUMERO)) NUMERO
     , F.BAIRRO
     , F.CIDADE
     , F.UF
     , F.CEP
     , F.CONTATO
     , F.CODMUN CODIBGE
     , F.NUMIDF
     , F.CODDOCNFC
     , F.UTILIZANFE
     , F.INDUSTRIA
     , NVL(F.TIPOMONTAGEM, 'R') TIPOMONTAGEM
     , F.INTEGRADORAWMS
  FROM PCFILIAL F
 WHERE F.DTEXCLUSAO IS NULL
 AND UPPER( F.CODIGO  )= UPPER( :PARAM1 ) ORDER BY LPAD(F.CODIGO, 2, 0)
PARAM1 = '2'
----------------------------------
Timestamp: 14:54:12.566
SELECT * FROM PCFORMCONFIG
WHERE ROTINA = :ROTINA
  AND MATRICULA = :MATRICULA
ROTINA = 1203
MATRICULA = 1261
----------------------------------
Timestamp: 14:54:12.696
SELECT F.CODIGO
     , F.RAZAOSOCIAL
     , F.FANTASIA
     , F.CODIGO || ' - ' || F.RAZAOSOCIAL FILIAL
     , F.IE
     , F.CGC
     , F.TELEFONE
     , F.ENDERECO
     , F.EMAIL
     , NVL(F.NUMERO2, TO_CHAR(F.NUMERO)) NUMERO
     , F.BAIRRO
     , F.CIDADE
     , F.UF
     , F.CEP
     , F.CONTATO
     , F.CODMUN CODIBGE
     , F.NUMIDF
     , F.CODDOCNFC
     , F.UTILIZANFE
     , F.INDUSTRIA
     , NVL(F.TIPOMONTAGEM, 'R') TIPOMONTAGEM
     , F.INTEGRADORAWMS
  FROM PCFILIAL F
 WHERE F.DTEXCLUSAO IS NULL
 AND UPPER( F.CODIGO  )= UPPER( :PARAM1 ) ORDER BY LPAD(F.CODIGO, 2, 0)
PARAM1 = '2'
----------------------------------
Timestamp: 14:54:13.328
SELECT NVL(UPPER(ACESSO),'N') ACESSO
FROM PCCONTROI
WHERE CODROTINA = :CODROTINA
  AND CODCONTROLE = :CODCONTROLE
  AND CODUSUARIO = :CODUSUARIO
CODROTINA = 1203
CODCONTROLE = 14
CODUSUARIO = 1261
----------------------------------
Timestamp: 14:54:13.392
SELECT NVL(UPPER(ACESSO),'N') ACESSO
FROM PCCONTROI
WHERE CODROTINA = :CODROTINA
  AND CODCONTROLE = :CODCONTROLE
  AND CODUSUARIO = :CODUSUARIO
CODROTINA = 1203
CODCONTROLE = 21
CODUSUARIO = 1261
----------------------------------
Timestamp: 14:54:13.446
SELECT NVL(UPPER(ACESSO),'N') ACESSO
FROM PCCONTROI
WHERE CODROTINA = :CODROTINA
  AND CODCONTROLE = :CODCONTROLE
  AND CODUSUARIO = :CODUSUARIO
CODROTINA = 1203
CODCONTROLE = 15
CODUSUARIO = 1261
----------------------------------
Timestamp: 14:54:13.506
SELECT SUM(VALOR) AS TOTAL
FROM PCPREST
WHERE CODCLI=:CODCLI
AND DTPAG IS NULL
CODCLI = 119859
----------------------------------
Timestamp: 14:54:13.536
SELECT SUM (NVL (VLATEND, 0)) AS TOTAL
FROM   PCPEDC
WHERE  CODCLI = :CODCLI
AND    POSICAO IN ('L', 'M')
AND    DTCANCEL IS NULL
CODCLI = 119859
----------------------------------
Timestamp: 14:54:13.565
SELECT SUM (NVL (VLATEND, 0)) AS TOTAL
FROM   PCPEDC
WHERE  CODCLI = :CODCLI
AND    POSICAO IN ('P', 'B')
AND    DTCANCEL IS NULL
CODCLI = 119859
----------------------------------
Timestamp: 14:54:13.598
SELECT PCPLPAGCLI.CODPLPAG,
       PCPLPAG.DESCRICAO,
       PCPLPAG.NUMDIAS,
       PCPLPAG.PERTXFIM
FROM   PCPLPAGCLI, PCPLPAG
WHERE  PCPLPAGCLI.CODCLI = :CODCLI
AND    PCPLPAGCLI.CODPLPAG = PCPLPAG.CODPLPAG
CODCLI = 119859
----------------------------------
Timestamp: 14:54:13.641
SELECT U.CODUSUR, R.NOME, S.CODSUPERVISOR, NVL(S.NOME, 'Não informado') SUPERVISOR
  FROM PCUSURCLI U, PCUSUARI R, PCSUPERV S
 where U.CODCLI = :CODCLI
   AND U.CODUSUR = R.CODUSUR
   AND R.CODSUPERVISOR = S.CODSUPERVISOR(+)
UNION
SELECT R.CODUSUR, R.NOME, S.CODSUPERVISOR, NVL(S.NOME, 'Não informado') SUPERVISOR
  FROM PCCLIENT C, PCUSUARI R, PCSUPERV S
 where C.CODCLI = :CODCLI
   AND R.CODSUPERVISOR = S.CODSUPERVISOR(+)
   AND ((C.CODUSUR1 = R.CODUSUR) OR (C.CODUSUR2 = R.CODUSUR) OR
       (C.CODUSUR3 = R.CODUSUR))
CODCLI = 119859
----------------------------------
Timestamp: 14:54:13.686
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 14:54:13.740
SELECT C.CODCLI, C.CLIENTE                                                                                                               
     , C.CODFUNCULTALTER                                                                                                                 
     , C.CODROTINAALT                                                                                                                    
     , DECODE(C.BLOQUEIO, 'S', C.BLOQUEIO, 'N') BLOQUEIO                                                                             
     , C.INICIOATIV, C.CODFUNCULTALTER1203,                                                                                              
       C.DTBLOQ, C.CODFUNCANALISECRED, C.CLASSEVENDA,C.VIP,C.OBS, C.GERENCIAMENTO, C.DTPRIMCOMPRA, TRUNC(SYSDATE) AS HOJE,               
 NVL(C.LIMCRED,0) AS LIMCREDORIGINAL,NVL(C.PRAZOADICIONAL,0) PRAZOADICIONAL                                                              
 ,(SELECT MAX(PCEMPR.VLMAXLIMCREDCLI)                                                                                                    
     FROM PCEMPR                                                                                                                         
    WHERE PCEMPR.MATRICULA = :FUNC                                                                                                       
  ) AS VLMAXLIMCREDCLI,                                                                                                                  
 NVL(C.LIMCREDCPF,0) AS LIMCREDCPF,                                                                                                      
 NVL(QTDIASVENCLIMCRED,0) QTDIASVENCLIMCRED,                                                                                             
       (SELECT MAX(PC.DATA)                                                                                                              
        FROM PCPEDC PC                                                                                                                   
        WHERE PC.CODCLI = C.CODCLI                                                                                                       
        AND   PC.CONDVENDA IN (1,5,8,14,20)) AS DTULTCOMP,                                                                               
       C.DTREGLIM, C.DTVENCLIMCRED, C.CODCOB, C.CODPLPAG, TRUNC(C.DTULTALTER1203) DTULTALTER1203,                                        
       C.EMAIL, C.FAXCLI, C.FANTASIA, C.TELENT, C.OBS2, C.OBS3, C.OBS4, C.OBS5,                                                          
  C.CGCENT,                                                                                                                             
       C.DTULTCONSULTASERASA, C.DTULTCONSULTASCI, C.RATINGSCI, C.PREDIOPROPRIO,                                                          
       C.ANALISECRED, C.CAPITALSOCIAL, C.TELCELENT, C.CODCLIPRINC, C.CODFILIALNF,                                                        
       C.OBSERVACAO, C.RATINGSCI1, C.RATINGSCI2, C.DTULTCONSULTASINTEGRA, C.CODUSUR1,                                                    
       C.DTDESBLOQUEIO,                                                                                                                  
       C.CODCOBTV1, C.CODCOBTV3, C.CODHIST,                                                                                              
       DECODE(C.BLOQUEIODEFINITIVO, 'S', C.BLOQUEIODEFINITIVO, 'N') BLOQUEIODEFINITIVO,                                              
       C.BLOQUEIODATACHEQ,                                                                                                               
       C.TIPOFJ                                                                                                                          
       , DECODE(C.BLOQUEIOSEFAZ, 'S', C.BLOQUEIOSEFAZ, 'N') BLOQUEIOSEFAZ                                                            
       , DECODE(C.BLOQUEIOSEFAZPED, 'S', C.BLOQUEIOSEFAZPED, 'N') BLOQUEIOSEFAZPED,                                                  
       C.OBS_ADIC, C.DTULTAGRUPAMENTO                                                                                                    
       , C.PERIODICIDADEAGRUP                                                                                                            
       , C.CODPLPAGAGRUPAUTOMATIC                                                                                                        
       , C.DTPROXDESDAGENDADO,                                                                                                           
       C.TPCOMUNICADOSERASA, NVL(C.SERASAGERENCIE,'S') SERASAGERENCIE, C.PRAZOSERASAGERENCIE, C.DTSERASAGERENCIE,                      
       C.UTILIZAPLPAGMEDICAMENTO, C.CODPLPAGETICO, C.CODPLPAGGENERICO                                                                    
       ,C.EMAILNFE                                                                                                                       
       ,SUPPLICLIENTE.STATUSSUPPLI                                                                                                       
       ,SUPPLICLIENTE.LIMITECREDDISPONSUPPLI                                                                                             
       ,SUPPLICLIENTE.LIMITECOMPRADISPONIVEL                                                                                             
       ,PED.VALOR AS PEDNAOFATDMAISCRED                                                                                                  
       ,FILASUPPLI.FATNAORETDMAISCRED                                                                                                    
       ,(SUPPLICLIENTE.LIMITECOMPRADISPONIVEL - PED.VALOR - FILASUPPLI.FATNAORETDMAISCRED) AS LIMITEDISPDMAISCRED                        
       ,0 ckVLLIMITESAZONAL                                                                                                              
       ,0 LIMCRED                                                                                                                        
       ,0 VALORPENDENTE                                                                                                                  
       ,0 CKPendAcerto                                                                                                                   
       ,0 ckVlrTitPagoNLiberado                                                                                                          
       ,0 CKPedPendBloq                                                                                                                  
       ,0 CKSaldoDisp                                                                                                                    
       ,0 ckSaldoDispMenosPedBloq                                                                                                        
       ,'XXXXXX' BLOQ                                                                                                                  
       ,0 ckTitulosTerceiros                                                                                                             
       ,0 CKDisponivel                                                                                                                   
       , CODPLPAG || '-' || (SELECT PLP.DESCRICAO                                                                                      
            FROM PCPLPAG PLP                                                                                                             
           WHERE PLP.CODPLPAG = C.CODPLPAG AND ROWNUM = 1) ckPLANOPAG                                                                    
       , c.MOTIVOBLOQ                                                                                                                    
       , NFSAID.CKVLMAIORCOMPRA, NFSAID.ckDTMAIORCOMPRA                                                                                  
       , C.UTILIZAPLPAGMEDICAMENTO, C.CODPLPAGETICO, C.CODPLPAGGENERICO                                                                  
       ,C.EMAILNFE                                                                                                                       
       ,NVL(C.LIMITECREDSUPPLI,0) AS LIMITECREDSUPPLI                                                                                    
       ,0 ckVLLIMITESAZONAL                                                                                                              
       ,0 LIMCRED                                                                                                                        
       ,0 VALORPENDENTE                                                                                                                  
       ,0 CKPendAcerto                                                                                                                   
       ,0 ckVlrTitPagoNLiberado                                                                                                          
       ,0 CKPedPendBloq                                                                                                                  
       ,0 CKSaldoDisp                                                                                                                    
       ,0 ckSaldoDispMenosPedBloq                                                                                                        
       ,'XXXXXX' BLOQ                                                                                                                  
       ,0 ckTitulosTerceiros                                                                                                             
       ,0 CKDisponivel                                                                                                                   
       , CODPLPAG || '-' || (SELECT PLP.DESCRICAO                                                                                      
            FROM PCPLPAG PLP                                                                                                             
           WHERE PLP.CODPLPAG = C.CODPLPAG AND ROWNUM = 1) ckPLANOPAG                                                                    
       , c.MOTIVOBLOQ                                                                                                                    
FROM PCCLIENT C,                                                                                                                         
     (SELECT STATUSSUPPLI,                                                                                                               
             LIMITECREDDISPONSUPPLI,                                                                                                     
             LIMITECOMPRADISPONIVEL,                                                                                                     
             CODCLI                                                                                                                      
        FROM PCSUPPLICLIENTE) SUPPLICLIENTE,                                                                                             
     (SELECT MAX(N.vltotger) ckvlmaiorcompra , MAX(N.dtsaida) as ckdtmaiorcompra, N.codcli                                               
        FROM pcnfsaid n                                                                                                                  
       WHERE n.tipovenda <> 'DF'                                                                                                       
         AND n.condvenda IN (1, 5, 8, 14, 20)                                                                                            
       GROUP BY N.CODCLI) NFSAID,                                                                                                        
      (SELECT NVL(SUM(ROUND(NVL(PCPEDC.VLATEND, 0) - CASE                                                                                
                                                     WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN       
                                                              PCPEDC.VLENTRADA                                                           
                                                     ELSE 0                                                                              
                                                     END, 2)),0) AS VALOR,                                                               
              PCPEDC.CODCLI                                                                                                              
         FROM PCPEDC, PCPLPAG                                                                                                            
        WHERE DTCANCEL IS NULL                                                                                                           
          AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG                                                                                         
          AND POSICAO IN ('L', 'M')                                                                                                  
          AND PCPEDC.CODCOB IN (SELECT CODCOB FROM PCCOB where COBSUPPLIERCARD = 'S')                                                  
        GROUP BY PCPEDC.CODCLI) PED,                                                                                                     
      (SELECT NVL(SUM(S.VLTOTAL), 0) AS FATNAORETDMAISCRED, S.CODCLI                                                                     
         FROM PCFILASUPPLI F                                                                                                             
        INNER JOIN PCNFSAID S ON S.NUMTRANSVENDA = F.NUMTRANSVENDA                                                                       
        WHERE TIPOINF = 1                                                                                                                
          AND ((NVL(ENVIADOSUPPLI, 'N') = 'N') OR (APROVADOSUPPLI <> 'S'))                                                         
        GROUP BY S.CODCLI) FILASUPPLI                                                                                                    
WHERE C.CODCLI = :CODCLI                                                                                                                 
  AND C.CODCLI = SUPPLICLIENTE.CODCLI(+)                                                                                                 
  AND C.CODCLI = NFSAID.CODCLI(+)                                                                                                        
  AND C.CODCLI = PED.CODCLI(+)                                                                                                           
  AND C.CODCLI = FILASUPPLI.CODCLI(+)
FUNC = 1261
CODCLI = 119859
----------------------------------
Timestamp: 14:54:14.503
SELECT percaumento
  FROM pclimcred
 WHERE pclimcred.coddcli = :codcli
   AND TRUNC( SYSDATE ) BETWEEN pclimcred.dtinicio AND pclimcred.dtfim
   AND (    ( pclimcred.codusur IS NULL )
        OR ( pclimcred.codusur = :codusur ) )
codcli = 119859
codusur = 223
----------------------------------
Timestamp: 14:54:14.555
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 119859
----------------------------------
Timestamp: 14:54:14.600
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 119859
----------------------------------
Timestamp: 14:54:14.643
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 119859
----------------------------------
Timestamp: 14:54:14.690
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 14:54:14.737
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 119859
----------------------------------
Timestamp: 14:54:14.770
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 119859
----------------------------------
Timestamp: 14:54:14.827
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 119859
----------------------------------
Timestamp: 14:54:14.874
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 119859
----------------------------------
Timestamp: 14:54:14.912
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 14:54:15.498
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 119859
----------------------------------
Timestamp: 14:54:15.553
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 119859
----------------------------------
Timestamp: 14:54:15.598
SELECT PEREXCEDELIMCRED
  FROM PCCONSUM
 WHERE ROWNUM = 1
----------------------------------
Timestamp: 14:54:15.628
SELECT LIMCRED
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
CODCLI = 119859
----------------------------------
Timestamp: 14:54:15.662
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 119859
----------------------------------
Timestamp: 14:54:15.695
SELECT NVL(UsaLimCredCPF, 'N') UsaLimCredCPF
  FROM PCCONSUM
----------------------------------
Timestamp: 14:54:15.715
SELECT SUM(NVL(VALOR,0)) VALOR              
  FROM PCPREST                              
 WHERE DTPAG IS NULL                        
       AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                    FROM PCCOB where COBSUPPLIERCARD = 'S') 
   AND CODCOB NOT IN ('BNF','BNFT','BNTR','BNFR', 'BNRP')
 AND CODCLI = :CODCLI
CODCLI = 119859
----------------------------------
Timestamp: 14:54:15.750
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 119859
----------------------------------
Timestamp: 14:54:15.781
SELECT SUM (ROUND(NVL (VLATEND, 0) - CASE WHEN ((PCPLPAG.TIPOENTRADA = 3) AND (PCPLPAG.DESCENTLIMCREDCLI = 'S')) THEN 
PCPEDC.VLENTRADA ELSE 0 END ,2))  VLATEND 
  FROM PCPEDC,PCPLPAG 
 WHERE DTCANCEL IS NULL
   AND PCPEDC.CONDVENDA NOT IN (8, 13)
   AND PCPLPAG.CODPLPAG = PCPEDC.CODPLPAG
   AND POSICAO IN ('L', 'M', 'B')
   AND PCPEDC.CODCOB NOT IN (SELECT CODCOB                               
                                FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
CODCLI = 119859
----------------------------------
Timestamp: 14:54:15.819
SELECT CODCLI, TRIM(UPPER(CLIENTE)) CLIENTE
  FROM PCCLIENT
 WHERE CODCLI = :CODCLI
 AND CLIENTE LIKE TRIM(UPPER('%CONSUMIDOR%'))
CODCLI = 119859
----------------------------------
Timestamp: 14:54:15.847
SELECT NVL(ChecarDiasUteisTitPgnLib, 'N') ChecarDiasUteisTitPgnLib FROM PCCONSUM
----------------------------------
Timestamp: 14:54:15.883
with dados as                                                          
 (SELECT valor,                                                        
         PCPREST.DTPAG +                                               
         (SELECT NVL(PCCOB.NUMDIASLIBERACAOCREDITO, 0)                 
            FROM PCCOB                                                 
           WHERE PCCOB.CODCOB = PCPREST.CODCOB) data_liberacao_credito 
    FROM PCPREST                                                       
   WHERE PCPREST.CODCOB <> 'DESD'                                    
     AND PCPREST.DTPAG IS NOT NULL                                     
     AND NVL(CHEQUETERCEIRO, 'N') = 'N'                            
     AND PCPREST.DTVENC >= (SELECT MIN(DTVENC) FROM PCPREST)           
     AND PCPREST.DTCANCEL IS NULL                                      
     AND PCPREST.CODCOB NOT IN (SELECT CODCOB                               
                                  FROM PCCOB where COBSUPPLIERCARD = 'S') 
 AND CODCLI = :CODCLI
 ) 
select sum(valor) vlcheque                                             
  from dados                                                           
 where dados.data_liberacao_credito > TRUNC(SYSDATE)
CODCLI = 119859
----------------------------------
Timestamp: 14:54:15.956
SELECT * FROM PCSUPPLICLIENTE WHERE CODCLI = :CODCLI
CODCLI = 119859
----------------------------------
Timestamp: 14:54:16.344
SELECT L.CODCLI,
       L.DATA,
       L.CODEMITE,
       L.PROGRAMA,
       L.BLOQUEIO,
       L.BLOQUEIOANT,
       L.LIMCRED,
       L.LIMCREDANT,
       L.DTREGLIMANT,
       L.DTVENCLIMCRED,
       L.DTVENCLIMANT,
       L.OBS,
       L.OBSANT,
       L.PRAZO,
       L.PRAZOANT,
       L.CODCOB,
       L.CODCOBANT,
       C.CLIENTE,
       C.CODCLI,
       C.CGCENT,
       L.OBS1,
       L.OBS2,
       L.OBS3,
       L.OBS4,
       L.CODPLPAG,
       L.CODPLPAGANT,
       C.DTBLOQ,
       E.NOME,
       L.LIMCREDCPFANT,
       L.LIMCREDCPF,
       L.BLOQDEFINITIVO,
       L.BLOQDEFINITIVOANT,
       L.UTILIZAPLPAGMEDICAMENTO,
       L.UTILIZAPLPAGMEDICAMENTOANT,
       L.CODPLPAGETICO,
       L.CODPLPAGETICOANT,
       L.CODPLPAGGENERICO,
       L.CODPLPAGGENERICOANT,
       (SELECT P1.DESCRICAO FROM PCPLPAG P1 WHERE P1.CODPLPAG = L.CODPLPAG) AS DESCPAG,
       (SELECT P1.DESCRICAO
          FROM PCPLPAG P1
         WHERE P1.CODPLPAG = L.CODPLPAGANT) AS DESCPAGANT,
       L.DTULTCOMP,
       L.DTULTCOMPANT,
       L.OBSALT
  FROM PCLOGLC L, PCCLIENT C, PCEMPR E
 WHERE (L.CODCLI = :CODCLI)
   AND (L.CODCLI = C.CODCLI)
   AND (L.CODEMITE = E.MATRICULA)
   AND L.OBS NOT IN ('Baixa do Estorno da Perda','Estorno Parcial Baixa da Perda')
 ORDER BY L.DATA DESC
CODCLI = 119859
----------------------------------
Timestamp: 14:54:16.649
SELECT CODIGO || ' - ' || RAZAOSOCIAL as RAZAOSOCIAL, CODIGO
 FROM PCFILIAL
WHERE CODIGO IN
      (DECODE((SELECT COUNT(1)
                FROM PCLIB
               WHERE CODIGOA IN 
                     (SELECT CODIGO FROM PCFILIAL WHERE CODIGO = '99')
                 AND CODTABELA = 1
                 AND CODFUNC = 1261),
              0,
              (SELECT CODIGOA
                 FROM PCLIB
                WHERE CODTABELA = 1
                  AND CODFUNC = 1261
                  AND CODIGOA = CODIGO),
              CODIGO))
ORDER BY CODIGO
----------------------------------
Timestamp: 14:54:16.695
SELECT TO_CHAR(SYSDATE, 'DD/MM/YYYY') AS DATA,
TO_CHAR(SYSDATE, 'HH:MI:SS') AS HORA FROM DUAL
----------------------------------
Timestamp: 14:54:16.733
SELECT DECODE
       ((SELECT COUNT(1)
              FROM PCCOBCLI T
             WHERE T.CODCOB = B.CODCOB
               AND T.CODCLI = :CODCLI),0,'N','S')
     SELECIONADO,
    B.CODCOB,
    B.COBRANCA,
    B.NIVELVENDA,
    B.BOLETO
FROM PCCOB B,PCCOBCLI C
WHERE B.CODCOB=C.CODCOB
AND C.CODCLI=:CODCLI
CODCLI = 119859
----------------------------------
Timestamp: 14:54:16.778
SELECT * FROM PCSUPPLICLIENTE WHERE CODCLI = :CODCLI
CODCLI = 119859
----------------------------------
Timestamp: 14:54:16.807
SELECT A.CODCLI,
       A.CLIENTE,
       A.FANTASIA,
       A.CLASSEVENDA,
       A.VIP1          AS VIP,
       A.CGCENT,
       A.CODATV1,
       A.CODUSUR1,
       A.CODUSUR2,
       A.IEENT,
       A.VIP2          AS VIP,
       A.DTCADASTRO,
       A.NOME,
       A.PRACA,
       A.ENDERENT,
       A.BAIRROENT,
       A.MUNICENT,
       A.ESTENT,
       A.TELENT,
       A.FAXCLI,
       A.ENDERCOB,
       A.BAIRROCOB,
       A.MUNICCOB,
       A.ESTCOB,
       A.CODPRACA,
       A.TELCOB,
       A.PREDIOPROPRIO,
       A.INICIOATIV,
       A.CEPENT,
       A.CEPCOB,
       A.RAMO,
       A.CODCOB,
       A.DTEXCLUSAO,
       A.NUMEROCOM,
       A.NUMEROCOB,
       A.NUMEROENT,
       A.NUMREGIAO,
       PCREGIAO.REGIAO,
       A.ROTA,
       A.DESCROTA
  FROM (SELECT C.CODCLI,
               C.CLIENTE,
               C.FANTASIA,
               C.CLASSEVENDA,
               C.VIP AS VIP1,
               C.CGCENT,
               C.CODATV1,
               C.CODUSUR1,
               C.CODUSUR2,
               C.IEENT,
               C.VIP AS VIP2,
               C.DTCADASTRO,
               U1.NOME,
               P.PRACA,
               C.ENDERENT,
               C.BAIRROENT,
               C.MUNICENT,
               C.ESTENT,
               C.TELENT,
               C.FAXCLI,
               C.ENDERCOB,
               C.BAIRROCOB,
               C.MUNICCOB,
               C.ESTCOB,
               C.CODPRACA,
               C.TELCOB,
               C.PREDIOPROPRIO,
               C.INICIOATIV,
               C.CEPENT,
               C.CEPCOB,
               A.RAMO,
               C.CODCOB,
               C.DTEXCLUSAO,
               C.NUMEROCOM,
               C.NUMEROCOB,
               C.NUMEROENT,
               NVL((SELECT T.NUMREGIAO
                     FROM PCTABPRCLI T
                    WHERE C.CODCLI = T.CODCLI(+)
                      AND C.CODFILIALNF = T.CODFILIALNF(+)),
                   P.NUMREGIAO) AS NUMREGIAO,
               P.ROTA,
               PCROTAEXP.DESCRICAO AS DESCROTA
          FROM PCCLIENT C, PCUSUARI U1, PCPRACA P, PCATIVI A, PCROTAEXP 
         WHERE C.CODCLI = :CODCLI
           AND C.CODUSUR1 = U1.CODUSUR
           AND C.CODPRACA = P.CODPRACA
           AND C.CODATV1 = A.CODATIV
           AND P.ROTA = PCROTAEXP.CODROTA) A,
       PCREGIAO
 WHERE A.NUMREGIAO = PCREGIAO.NUMREGIAO
CODCLI = 119859
----------------------------------
Timestamp: 14:54:16.980
SELECT NOMECONTATO, TIPOCONTATO, CGCCPF, AUTORCH, DTNASCIMENTO,
       HOBBIE, TIME, NOMECONJUGE, DTNASCCONJUGE, ENDERECO, BAIRRO,
       CIDADE, CEP, CARGO, TELEFONE, CELULAR, EMAIL, CODCLI, PARTICIPSOCIO,
       DTSOCIEDADE,OBS   
FROM PCCONTATO
WHERE CODCLI = :CODCLI
AND TIPOCONTATO = 'S'
ORDER BY TIPOCONTATO DESC, NOMECONTATO
CODCLI = 119859
----------------------------------
Timestamp: 14:54:17.018
SELECT C.ID,
       C.DATA,
       DECODE(C.TIPOFJ,'F','FÍSICA','JURÍDICA') AS TIPOFJ,
       CASE C.TIPOFJ WHEN 'J' THEN 
         SUBSTR(C.DOCPESQ, 2, 2)||'.'|| 
         SUBSTR(C.DOCPESQ, 4, 3)||'.'|| 
         SUBSTR(C.DOCPESQ, 7, 3)||'/'|| 
         SUBSTR(C.DOCPESQ, 10, 4)||'-'|| 
         SUBSTR(C.DOCPESQ, 14, 2) 
       WHEN 'F' THEN 
         SUBSTR(C.DOCPESQ, 5, 3)||'.'|| 
         SUBSTR(C.DOCPESQ, 8, 3)||'.'|| 
         SUBSTR(C.DOCPESQ, 11, 3)||'-'|| 
         SUBSTR(C.DOCPESQ, 14, 2)
       END AS DOCPESQ,       
       S.NUMBANCO,
       S.NUMAGENCIA,
       S.NUMCONTA,
       S.NUMCHEQUE,
       S.DVCHEQUE,
       S.UF,
       S.VALOR,
       S.DTVENC,
       CASE S.SITUACAO WHEN 'BL' THEN        
         'BLOQUEADO'
       WHEN 'LI' THEN          
         'LIBERADO'
       WHEN 'LS' THEN          
         'LIBERADO(SUPERVISOR)'
       WHEN 'LV' THEN          
         'LIBERADO(VALOR MÍNIMO)'
       WHEN 'PE' THEN          
         'PENDENTE'
       END AS SITUACAO,        
       NVL(S.OBSERVACAO,'NÃO CONSTAM OCORRÊNCIAS') AS OBSERVACAO      
FROM PCSITUACAOCHEQUES S, PCSERASA_CONSULTAS C
WHERE S.ID_PCSERASA_CONSULTAS = C.ID
AND   S.CODCLI = :CODCLI
ORDER BY C.DATA
CODCLI = 119859
----------------------------------
Timestamp: 14:54:17.225
SELECT L.CODCOBANT, C2.COBRANCA AS NOMECOBANT, L.CODCOB, C1.COBRANCA AS NOMECOB,   
       L.NUMCHEQUE, L.NUMBANCO,                                                    
       L.NUMAGENCIA, L.NUMCONTACORRENTE, E.NOME AS NOMEFUNC,                       
       L.VALOR, L.DTESTORNO, L.CODFUNCESTORNO, L.ALINEA, L.NUMTRANSVENDA, L.PREST, 
       (SELECT PCPREST.CGCCPFCH                                                    
          FROM PCPREST                                                             
         WHERE PCPREST.NUMTRANSVENDA = L.NUMTRANSVENDA                             
           AND PCPREST.PREST = L.PREST) CGCCPFCH,                                  
       (SELECT PCPREST.OBS2                                                        
          FROM PCPREST                                                             
         WHERE PCPREST.NUMTRANSVENDA = L.NUMTRANSVENDA                             
           AND PCPREST.PREST = L.PREST) EMITENTECHEQUE                             
FROM PCLOGCHDV L, PCCOB C1, PCCOB C2, PCEMPR E                                     
WHERE L.CODCLI = :CODCLI                                                           
AND   L.CODCOB = C1.CODCOB(+)                                                      
AND   L.CODCOBANT = C2.CODCOB(+)                                                   
AND   L.CODFUNCESTORNO = E.MATRICULA(+)                                            
ORDER BY CODCLI, DTESTORNO DESC, VALOR DESC
CODCLI = 119859
----------------------------------
Timestamp: 14:54:43.713
SELECT NVL(VLVENDAMES01,0) VLVENDAMES01, NVL(VLVENDAMES02,0) VLVENDAMES02, NVL(VLVENDAMES03,0) VLVENDAMES03,
       NVL(VLVENDAMES04,0) VLVENDAMES04, NVL(VLVENDAMES05,0) VLVENDAMES05, NVL(VLVENDAMES06,0) VLVENDAMES06,
       NVL(VLVENDAMES07,0) VLVENDAMES07, NVL(VLVENDAMES08,0) VLVENDAMES08, NVL(VLVENDAMES09,0) VLVENDAMES09,
       NVL(VLVENDAMES10,0) VLVENDAMES10, NVL(VLVENDAMES11,0) VLVENDAMES11, NVL(VLVENDAMES12,0) VLVENDAMES12,
       CODCLI, ANO 
FROM PCAUXCLI
WHERE CODCLI = :CODCLI
ORDER BY CODCLI, ANO DESC
CODCLI = 119859
----------------------------------
Timestamp: 14:54:44.163
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
       NVL(P.VALORDESC, 0) VALORDESC,
       (P.VALOR + NVL(P.TXPERMPREVISTO, 0)) VALORCOMJURPREV,
       P.CODCOBBANCO,
       P.CODBANCO,
       P.CODBANCOCUSTODIA,
       P.DTBAIXA,
       P.ALINEA,
       P.DTVENC,
       NVL(P.VPAGO, 0) VPAGO,
       P.DTEMISSAO,
       NVL(P.DTEMISSAOORIG, P.DTEMISSAO) DTEMISSAOORIG,
       E.NOME,
       P.NOSSONUMBCO,
       P.CODPORTADOR,
       P.DUPLIC,
       NVL(P.VLTXBOLETO, 0) VLTXBOLETO,
       P.DTPAG,
       P.STATUS,
       P.OBS,
       P.OBS2,
       NVL(P.DTVENCORIG, P.DTVENC) DTVENCORIG,
       P.TIPOPRORROG,
       P.NUMCAR,
       NVL(P.CARTORIO,'N') CARTORIO,
       NVL(P.PROTESTO,'N') PROTESTO,
       DECODE(LTRIM(RTRIM(C.ENDERCOB)),'O MESMO', C.TELENT, C.TELCOB) TELEFONE,
       TRUNC(SYSDATE) HOJE,
       P.PREST,
       P.CODFILIAL,
       P.CODCOB,
       P.CODUSUR,
       U.NOME NOMERCA,
       P.NUMTRANSVENDA,
       P.CODBAIXA,
       P.NUMBANCO,
       P.NUMAGENCIA,
       P.NUMCHEQUE,
       P.DTINCLUSAO,
       P.CODFUNCINC,
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
   AND P.CODCLI = :CODCLI
   AND P.CODCLI = C.CODCLI
   AND P.NUMTRANSVENDA = TGI.NUMTRANSVENDA(+)
   AND P.PREST = TGI.PREST(+)
AND   P.CODCOB  = B.CODCOB(+)
AND P.CODBAIXA = E.MATRICULA(+)
AND P.CODUSUR = U.CODUSUR      
AND P.DTCANCEL IS NULL
AND P.CODCOB<>'CANC'
AND P.CODFILIAL = '2'
  AND (TRUNC(P.DTEMISSAO) >= :DTINICIO)
  AND (TRUNC(P.DTEMISSAO) <= :DTFIM)
AND P.DTPAG IS NULL 
ORDER BY P.DTEMISSAO DESC, P.DUPLIC, P.PREST
RETORNARNEGATIVO = 'N'
CODCLI = 119859
DTINICIO = '01/01/2023'
DTFIM = '31/12/2023'
----------------------------------
Timestamp: 14:54:45.323
SELECT TRUNC(SYSDATE)
  FROM DUAL
----------------------------------
Timestamp: 14:54:45.341
SELECT PCCOB.CODCOB                                            
      , F_VERIFICARQTDIASCARENCIAS(PCCOB.CODCOB) DIAS_CARENCIA  
   FROM PCCOB                                                   
  WHERE (1=1)
----------------------------------
Timestamp: 14:54:45.371
SELECT PCPARAMFILIAL.CODFILIAL                               
      , NVL(PCPARAMFILIAL.VALOR,'S') USADIAUTILFILIAL       
   FROM PCPARAMFILIAL                                         
  WHERE (1=1)                                                 
  AND PCPARAMFILIAL.NOME = 'FIL_USADIAUTILFILIAL'           
    AND PCPARAMFILIAL.CODFILIAL = :CODIGO
CODIGO = '2'
----------------------------------
Timestamp: 14:55:14.306
SELECT NOMEROTINA 
  FROM PCROTINA 
 WHERE CODIGO = :CODIGO
CODIGO = '1203'
----------------------------------
Timestamp: 14:55:14.437
SELECT pcprest.codfilial, pcprest.codfilialnf, pcprest.codsupervisor, pcsuperv.nome as nome_1,        
       pcprest.codusur, pcusuari.nome, pcprest.codcli, pcclient.cliente,                              
       pcprest.status, pcprest.valor, pcprest.valororig, pcprest.codcob, pcprest.numcar,              
       pcprest.codmotorista, pcempr.nome as nome_2, pcprest.codfunccxmot, pcprest.codfuncfecha,       
       pcprest.vpago, pcprest.valordesc, pcprest.txperm, pcprest.codbaixa,                            
       pcprest.codbanco, pcprest.codcobbanco, pcprest.numtrans, pcprest.numbanco, pcprest.numagencia, 
       pcprest.numcheque, pcprest.codbarra, pcprest.obs, pcprest.obs2, pcprest.alinea,                
       pcprest.nossonumbco, pcprest.tipo, pcprest.vltxboleto, pcprest.linhadig, pcprest.operacao,     
       pcprest.tipoprorrog, pcprest.codcoborig, pcprest.percom, pcprest.valorliqcom,                  
       pcprest.duplic, pcprest.numtransvenda, pcprest.prest, pcprest.vldevol, pcprest.txvendorcli,    
       pcprest.txvendorbco, nvl(pcprest.numdiasprazoprotesto,0) as numdiasprazoprotesto,              
       pcprest.dtemissao, pcprest.dtvenc, pcprest.dtvencorig,                                         
       pcprest.dtcxmot, pcprest.dtfecha, pcprest.dtpag,                                               
       pcprest.dtbaixa, pcprest.dtlancch,                                                             
       decode(nvl(pccob.calcjuroscobranca, 'N') ,'N',                                             
              paramfilial.obtercomonumber('CON_PERCJUROSMORA'),nvl(pccob.txjuros,0)) txjuros,       
       pcprest.numcustodia, pcprest.numlotecustodia,                                                  
       pcprest.codbancocustodia, pcprest.dtcustodia,                                                  
       pcprest.DTENVIOSERASA, pcprest.DTRETIRADASERASA,                                               
       PCPREST.DTRECEBIMENTOPREVISTO                                                                  
     , NVL(PCPREST.TXPERMPREVISTO, 0) TXPERMPREVISTO                                                  
     , EMPRCCXMOT.NOME FUNCCXMOT                                                                      
     , EMPRFECHA.NOME FUNCFECHA                                                                       
     , EMPRBAIXA.NOME FUNCBAIXA                                                                       
     , PCCOB.COBRANCA                                                                                 
     , COBORIG.COBRANCA COBRANCAORIG                                                                  
     , '   ' ENVIADOSERASA                                                                          
     , '   ' RETIRADOSERASA                                                                         
     , NVL(PCPREST.PERDESC,0) AS PERDESC 
  FROM pcprest, pcclient, pcusuari, pcsuperv, pcempr, pccob, pcdepto                                  
     , PCEMPR EMPRCCXMOT                                                                              
     , PCEMPR EMPRFECHA                                                                               
     , PCEMPR EMPRBAIXA                                                                               
     , PCCOB COBORIG                                                                                  
 WHERE pcprest.codcli = pcclient.codcli                                                               
   AND pcprest.codusur = pcusuari.codusur(+)                                                          
   AND pcprest.codsupervisor = pcsuperv.codsupervisor(+)                                              
   AND pcprest.codmotorista = pcempr.matricula(+)                                                     
   AND pcprest.codcob = pccob.codcob(+)                                                               
   AND pcprest.codepto = pcdepto.codepto(+)                                                           
   AND PCPREST.ROWID = :RID                                                                           
   AND PCPREST.CODFUNCCXMOT = EMPRCCXMOT.MATRICULA(+)                                                 
   AND PCPREST.CODFUNCFECHA = EMPRFECHA.MATRICULA(+)                                                  
   AND PCPREST.CODBAIXA = EMPRBAIXA.MATRICULA(+)                                                      
   AND PCPREST.CODCOBORIG = COBORIG.CODCOB(+)                                                         
ORDER BY  pcprest.duplic, pcprest.prest
RID = 'AAAHQIAAiAAHBwYAAN'
----------------------------------
Timestamp: 14:55:14.537
SELECT DTLANCPRORROG FROM PCPREST
WHERE NUMTRANSVENDA=:NT
AND   PREST=:PR
NT = 5898193
PR = '4'
----------------------------------
Timestamp: 14:55:14.651
SELECT DTLANCPRORROG FROM PCPREST
WHERE NUMTRANSVENDA=:NT
AND   PREST=:PR
NT = 5898193
PR = '4'
----------------------------------
Timestamp: 14:55:14.688
SELECT DTLANCPRORROG FROM PCPREST
WHERE NUMTRANSVENDA=:NT
AND   PREST=:PR
NT = 5898193
PR = '4'
----------------------------------
Timestamp: 14:55:14.725
SELECT DTLANCPRORROG FROM PCPREST
WHERE NUMTRANSVENDA=:NT
AND   PREST=:PR
NT = 5898193
PR = '4'
----------------------------------
Timestamp: 14:55:14.770
SELECT DTLANCPRORROG FROM PCPREST
WHERE NUMTRANSVENDA=:NT
AND   PREST=:PR
NT = 5898193
PR = '4'
----------------------------------
Timestamp: 14:55:14.830
SELECT PCMOV.NUMTRANSVENDA, PCMOV.NUMNOTA, PCMOV.CODPROD, PCPRODUT.DESCRICAO,                   
       PCMOV.DTMOV, NVL(PCMOV.QTCONT,0) AS QT, NVL(PCMOV.VLDESCONTO,0) AS VLDESCONTO,           
       DECODE(PCNFSAID.CONDVENDA, 5, NVL(PCMOV.PBONIFIC, PCMOV.PTABELA),                        
                                  6, NVL(PCMOV.PBONIFIC, PCMOV.PTABELA),                        
                                     NVL(PCMOV.PUNIT,0)) AS PUNIT,                              
       DECODE(PCNFSAID.CONDVENDA, 5, (NVL(PCMOV.QTCONT,0)* NVL(PCMOV.PBONIFIC, PCMOV.PTABELA)), 
                                  6, (NVL(PCMOV.QTCONT,0)* NVL(PCMOV.PBONIFIC, PCMOV.PTABELA)), 
                                     (NVL(PCMOV.QTCONT,0)* NVL(PCMOV.PUNIT,0))) AS VLTOTGER     
FROM  PCMOV, PCPRODUT, PCNFSAID                                                                 
WHERE PCMOV.CODPROD = PCPRODUT.CODPROD(+)                                                       
AND   PCMOV.NUMTRANSVENDA = :NUMTRANSVENDA                                                      
AND   PCMOV.NUMTRANSVENDA = PCNFSAID.NUMTRANSVENDA
NUMTRANSVENDA = 5898193
----------------------------------
Timestamp: 14:55:14.881
SELECT PCOCORBC.OCORRENCIA,
       PCOCORBCI.DESCRICAO,
       PCLOGCOBMAG.DATA,
       PCLOGCOBMAG.CODOCORRENCIA,
       PCLOGCOBMAG.CODSUBOCORRENCIA,
       PCLOGCOBMAG.VLCUSTAS,
       PCLOGCOBMAG.VLDESPESAS,
       PCLOGCOBMAG.USUARIO,
       PCLOGCOBMAG.MAQUINA,
       PCLOGCOBMAG.ARQRETORNO,
       PCLOGCOBMAG.ROTINALANC,
       PCPREST.NOMEARQUIVO,
       PCPREST.NUMREMESSA
  FROM PCOCORBC, PCOCORBCI, PCLOGCOBMAG, PCPREST
 WHERE PCOCORBC.CODOCORRENCIA(+) = PCLOGCOBMAG.CODOCORRENCIA
   AND PCOCORBC.NUMBANCO = PCLOGCOBMAG.CODBANCO
   AND PCOCORBCI.NUMBANCO(+) = PCLOGCOBMAG.CODBANCO
   AND PCOCORBCI.CODSUBOCORRENCIA(+) = PCLOGCOBMAG.CODSUBOCORRENCIA
   AND PCOCORBCI.CODOCORRENCIA(+) = PCLOGCOBMAG.CODOCORRENCIA 
   AND PCLOGCOBMAG.NUMTRANSVENDA = PCPREST.NUMTRANSVENDA(+) 
   AND PCLOGCOBMAG.PREST = PCPREST.PREST(+) 
   AND PCLOGCOBMAG.NUMTRANSVENDA = :NUMTRANSVENDA
   AND PCLOGCOBMAG.PREST = :PREST
 ORDER BY PCLOGCOBMAG.DATA DESC
NUMTRANSVENDA = 5898193
PREST = '4'
----------------------------------
Timestamp: 14:55:15.078
select pcprest.codcob,
       pcprest.codcoborig,
       pcprest.duplic,
       pcprest.numtransvenda,
       pcprest.prest,
       pcprest.valor,
       pcprest.valororig,
       pcprest.vldevol,
       pcprest.dtdevol,
       pcprest.txperm,
       pcprest.txpermprevisto,
       pcprest.txpermprevreal,
       pcprest.dtrecebimentoprevisto,
       pcprest.valordesc,
       pcprest.dtvenc,
       pcprest.dtemissao,
       pcprest.codfilial,
       pcprest.codfuncultalter,
       emprAlter.Nome NomeFuncUltAlter,
       pcprest.dtultalter,
       pcprest.codbaixa,
       pcprest.dtpag,
       pcprest.vpago,
       pccob.txjuros,
       0 clJuroPrevisto,
       0 VLRJUROS,
       0 VLRJUROSDIA,
       0 ATRASO,
       (SELECT COUNT(1) QTDE_DIAS_UTEIS                                              
         FROM PCDIASUTEIS                                                            
        WHERE DATA BETWEEN (pcprest.DTVENC + F_VERIFICARQTDIASCARENCIAS(pccob.CODCOB)) AND (TRUNC(SYSDATE) - 1) 
          AND CODFILIAL = pcprest.CODFILIAL                                              
          AND DIAFINANCEIRO = 'S') QTDE_DIAS_UTEIS,                               
       0 VLRTOTAL,
       trunc(sysdate) dataatual,
       emprBaixa.Nome NomeFuncBaixa,
        nullif(to_char(PCPREST.DTDESD, 'DD/MM/YYYY'), 'DD/MM/YYYY') || ' ' ||
               to_char(NVL(PCPREST.HORADESD, 0)) || ':' ||
               to_char(NVL(PCPREST.MINUTODESD, 0)) || ':00' 
               dtDesd,PCPREST.CODUSUR,PCUSUARI.NOME RCA
  from pccob, pcprest, pcempr emprBaixa, pcempr emprAlter, pcdesd,PCUSUARI
 where pcprest.numtransvenda = pcdesd.numtransvendaorig
   and pcprest.prest = pcdesd.prestorig
   and pccob.codcob(+) = pcprest.codcob
   and emprBaixa.Matricula(+) = pcprest.codbaixa
   and PCPREST.CODUSUR=PCUSUARI.CODUSUR(+)
   and emprAlter.Matricula(+) = pcprest.codfuncultalter
   and pcdesd.numtransvendadest = 5898193
   and pcdesd.prestdest = '4'
   and not exists (select pr.numtransvenda
                   from pcnfsaid nf, pcprest pr
                   where nf.numtransvenda = pr.numtransvenda
                   and pr.codcob = 'DESD' 
                   and pr.codcoborig = 'CRED' 
                   and nf.vendaassistida = 'S' 
                   and nf.numtransvenda = pcprest.numtransvenda) 
union
select pcprest.codcob,
       pcprest.codcoborig,
       pcprest.duplic,
       pcprest.numtransvenda,
       pcprest.prest,
       pcprest.valor,
       pcprest.valororig,
       pcprest.vldevol,
       pcprest.dtdevol,
       pcprest.txperm,
       pcprest.txpermprevisto,
       pcprest.txpermprevreal,
       pcprest.dtrecebimentoprevisto,
       pcprest.valordesc,
       pcprest.dtvenc,
       pcprest.dtemissao,
       pcprest.codfilial,
       pcprest.codfuncultalter,
       emprAlter.Nome NomeFuncUltAlter,
       pcprest.dtultalter,
       pcprest.codbaixa,
       pcprest.dtpag,
       pcprest.vpago,
       pccob.txjuros,
       0 clJuroPrevisto,
       0 VLRJUROS,
       0 VLRJUROSDIA,
       0 ATRASO,
       (SELECT COUNT(1) QTDE_DIAS_UTEIS                                              
         FROM PCDIASUTEIS                                                            
        WHERE DATA BETWEEN (pcprest.DTVENC + F_VERIFICARQTDIASCARENCIAS(pccob.CODCOB)) AND (TRUNC(SYSDATE) - 1) 
          AND CODFILIAL = pcprest.CODFILIAL                                              
          AND DIAFINANCEIRO = 'S') QTDE_DIAS_UTEIS,                               
       0 VLRTOTAL,
       trunc(sysdate) dataatual,
       emprBaixa.Nome NomeFuncBaixa,
        nullif(to_char(PCPREST.DTDESD, 'DD/MM/YYYY'), 'DD/MM/YYYY') || ' ' ||
               to_char(NVL(PCPREST.HORADESD, 0)) || ':' ||
               to_char(NVL(PCPREST.MINUTODESD, 0)) || ':00' 
               dtDesd,PCPREST.CODUSUR,PCUSUARI.NOME RCA
  from pccob, pcprest, pcempr emprBaixa, pcempr emprAlter, pcdesd,PCUSUARI
 where pcprest.numtransvenda = pcdesd.numtransvendadest
   and pcprest.prest = pcdesd.prestdest
   and pccob.codcob(+) = pcprest.codcob
   and PCPREST.CODUSUR=PCUSUARI.CODUSUR(+)
   and emprBaixa.Matricula(+) = pcprest.codbaixa
   and emprAlter.Matricula(+) = pcprest.codfuncultalter
   and pcdesd.numtransvendaorig = 5898193
   and pcdesd.prestorig = '4'
   and not exists (select pr.numtransvenda
                   from pcnfsaid nf, pcprest pr
                   where nf.numtransvenda = pr.numtransvenda
                   and pr.codcob = 'DESD' 
                   and pr.codcoborig = 'CRED' 
                   and nf.vendaassistida = 'S' 
                   and nf.numtransvenda = pcprest.numtransvenda)
----------------------------------
Timestamp: 14:55:15.402
SELECT * FROM PCFORMCONFIG
WHERE ROTINA = :ROTINA
  AND MATRICULA = :MATRICULA
ROTINA = 1203
MATRICULA = 1261
----------------------------------
Timestamp: 14:55:23.652
SELECT NUMTRANSVENDA,PREST,OBSGERAIS, OBSACERTO
FROM PCPRESTOBS
WHERE NUMTRANSVENDA = :NUMTRANSVENDA
AND PREST = :PREST
NUMTRANSVENDA = 5898193
PREST = '4'
----------------------------------
Timestamp: 14:55:23.701
SELECT G.OBSACERTO       
 FROM PCCARREG G          
 WHERE G.NUMCAR = :NUMCAR 
 GROUP BY OBSACERTO
NUMCAR = 95200
----------------------------------
Timestamp: 14:55:25.501
SELECT N.DATA,                                                                                                     
       N.NOSSONUMERONOVO AS VALOR_ATUAL1,
       N.NOSSONUMEROANTIGO AS VALOR_ANTERIOR1,
       N.NOSSONUMERO2NOVO AS VALOR_ATUAL2,
       N.NOSSONUMERO2ANTIGO AS VALOR_ANTERIOR2,
       N.USUARIO AS NOME_USUARIO_WINTHOR,
       N.MAQUINA,
       N.ROTINA,
       F.CODIGO,
       F.RAZAOSOCIAL,
       C.CODCLI,
       C.CLIENTE,
       N.NUMTRANSVENDA,
       P.DUPLIC,
       P.PREST,
       B.CODBANCO,
       B.NOME AS BANCO
FROM PCHISTNOSSONUMEROBCO N, PCPREST P,                                                   
      PCCLIENT C, PCBANCO B, PCFILIAL F
WHERE N.NUMTRANSVENDA = :NUMTRANSVENDA
  AND N.PREST = :PREST
  AND N.PREST = P.PREST
  AND N.NUMTRANSVENDA  = P.NUMTRANSVENDA 
  AND N.CODCLI = C.CODCLI 
  AND N.CODCLI = P.CODCLI 
  AND P.CODFILIAL = F.CODIGO
  AND P.CODBANCO = B.CODBANCO(+)
ORDER BY N.DATA DESC
NUMTRANSVENDA = '5'
PREST = '4'
----------------------------------
Timestamp: 14:55:26.867
SELECT NUMTRANSVENDA,PREST,OBSGERAIS, OBSACERTO
FROM PCPRESTOBS
WHERE NUMTRANSVENDA = :NUMTRANSVENDA
AND PREST = :PREST
NUMTRANSVENDA = 5898193
PREST = '4'
----------------------------------
Timestamp: 14:55:26.914
SELECT G.OBSACERTO       
 FROM PCCARREG G          
 WHERE G.NUMCAR = :NUMCAR 
 GROUP BY OBSACERTO
NUMCAR = 95200
----------------------------------
Timestamp: 14:55:39.834
SELECT * FROM PCFORMCONFIG
WHERE ROTINA = :ROTINA
  AND MATRICULA = :MATRICULA
  AND NOME = :NOME
ROTINA = 1203
MATRICULA = 1261
NOME = '1'
----------------------------------
Timestamp: 14:55:39.880
Successful commit.
----------------------------------
Timestamp: 14:55:39.881
begin  :result := sys.dbms_transaction.local_transaction_id(true); end;
result = '15.26.9545338'
----------------------------------
Timestamp: 14:55:39.912
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '15.26.9545338'
----------------------------------
Timestamp: 14:55:39.944
SELECT DFSEQ_PCFORMCONFIG.NEXTVAL
  FROM DUAL
----------------------------------
Timestamp: 14:55:39.961
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '15.26.9545338'
----------------------------------
Timestamp: 14:55:39.987
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '15.26.9545338'
----------------------------------
Timestamp: 14:55:40.012
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '15.26.9545338'
----------------------------------
Timestamp: 14:55:40.035
SELECT '' TABLE_CATALOG, IC.TABLE_OWNER TABLE_SCHEMA, IC.TABLE_NAME, '' INDEX_CATALOG, IC.INDEX_OWNER INDEX_SCHEMA, 
IC.INDEX_NAME, IC.COLUMN_NAME, IC.COLUMN_POSITION, DECODE(IC.DESCEND, 'ASC', 0, 1) DESCENDING FROM SYS.ALL_IND_COLUMNS IC, 
SYS.ALL_INDEXES I, SYS.ALL_CONSTRAINTS C WHERE IC.TABLE_OWNER = 'FRIOBOM' AND IC.TABLE_NAME = 'PCFORMCONFIG' AND I.UNIQUENESS = 
'UNIQUE' AND        I.OWNER = IC.INDEX_OWNER AND I.INDEX_NAME = IC.INDEX_NAME AND       C.TABLE_NAME (+) = IC.TABLE_NAME AND 
C.INDEX_NAME (+) = IC.INDEX_NAME AND C.OWNER (+)= IC.TABLE_OWNER ORDER BY DECODE(IC.INDEX_OWNER, 'FRIOBOM', 0, 'PUBLIC', 1, 2), 
DECODE(C.CONSTRAINT_TYPE, 'P', 1, 'U', 2, 3), IC.INDEX_OWNER, IC.TABLE_OWNER, IC.TABLE_NAME, IC.INDEX_NAME, IC.COLUMN_POSITION
----------------------------------
Timestamp: 14:55:40.068
INSERT INTO PCFORMCONFIG
  (CODIGO, ROTINA, MATRICULA, NOME, ARQUIVO)
VALUES
  (:CODIGO, :ROTINA, :MATRICULA, :NOME, EMPTY_BLOB())
RETURNING
  ARQUIVO
INTO
  :ARQUIVO
CODIGO = 12679
ROTINA = 1203
MATRICULA = 1261
NOME = '1203_1261cxGridDBTableView1.grd'
----------------------------------
Timestamp: 14:55:40.168
Successful commit.
----------------------------------
Timestamp: 14:55:40.174
SELECT * FROM PCFORMCONFIG
WHERE ROTINA = :ROTINA
  AND MATRICULA = :MATRICULA
  AND NOME = :NOME
ROTINA = 1203
MATRICULA = 1261
NOME = '1'
----------------------------------
Timestamp: 14:55:40.230
Successful commit.
----------------------------------
Timestamp: 14:55:40.232
begin  :result := sys.dbms_transaction.local_transaction_id(true); end;
result = '34.3.5176383'
----------------------------------
Timestamp: 14:55:40.272
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '34.3.5176383'
----------------------------------
Timestamp: 14:55:40.293
SELECT DFSEQ_PCFORMCONFIG.NEXTVAL
  FROM DUAL
----------------------------------
Timestamp: 14:55:40.312
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '34.3.5176383'
----------------------------------
Timestamp: 14:55:40.352
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '34.3.5176383'
----------------------------------
Timestamp: 14:55:40.383
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '34.3.5176383'
----------------------------------
Timestamp: 14:55:40.416
SELECT '' TABLE_CATALOG, IC.TABLE_OWNER TABLE_SCHEMA, IC.TABLE_NAME, '' INDEX_CATALOG, IC.INDEX_OWNER INDEX_SCHEMA, 
IC.INDEX_NAME, IC.COLUMN_NAME, IC.COLUMN_POSITION, DECODE(IC.DESCEND, 'ASC', 0, 1) DESCENDING FROM SYS.ALL_IND_COLUMNS IC, 
SYS.ALL_INDEXES I, SYS.ALL_CONSTRAINTS C WHERE IC.TABLE_OWNER = 'FRIOBOM' AND IC.TABLE_NAME = 'PCFORMCONFIG' AND I.UNIQUENESS = 
'UNIQUE' AND        I.OWNER = IC.INDEX_OWNER AND I.INDEX_NAME = IC.INDEX_NAME AND       C.TABLE_NAME (+) = IC.TABLE_NAME AND 
C.INDEX_NAME (+) = IC.INDEX_NAME AND C.OWNER (+)= IC.TABLE_OWNER ORDER BY DECODE(IC.INDEX_OWNER, 'FRIOBOM', 0, 'PUBLIC', 1, 2), 
DECODE(C.CONSTRAINT_TYPE, 'P', 1, 'U', 2, 3), IC.INDEX_OWNER, IC.TABLE_OWNER, IC.TABLE_NAME, IC.INDEX_NAME, IC.COLUMN_POSITION
----------------------------------
Timestamp: 14:55:40.433
INSERT INTO PCFORMCONFIG
  (CODIGO, ROTINA, MATRICULA, NOME, ARQUIVO)
VALUES
  (:CODIGO, :ROTINA, :MATRICULA, :NOME, EMPTY_BLOB())
RETURNING
  ARQUIVO
INTO
  :ARQUIVO
CODIGO = 12680
ROTINA = 1203
MATRICULA = 1261
NOME = '1203_1261tbvDadosHistoricoBK.grd'
----------------------------------
Timestamp: 14:55:40.528
Successful commit.
----------------------------------
Timestamp: 14:55:40.531
SELECT * FROM PCFORMCONFIG
WHERE ROTINA = :ROTINA
  AND MATRICULA = :MATRICULA
  AND NOME = :NOME
ROTINA = 1203
MATRICULA = 1261
NOME = 'P'
----------------------------------
Timestamp: 14:55:40.592
Successful commit.
----------------------------------
Timestamp: 14:55:40.593
begin  :result := sys.dbms_transaction.local_transaction_id(true); end;
result = '30.11.6064463'
----------------------------------
Timestamp: 14:55:40.634
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '30.11.6064463'
----------------------------------
Timestamp: 14:55:40.661
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '30.11.6064463'
----------------------------------
Timestamp: 14:55:40.688
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '30.11.6064463'
----------------------------------
Timestamp: 14:55:40.718
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '30.11.6064463'
----------------------------------
Timestamp: 14:55:40.743
SELECT '' TABLE_CATALOG, IC.TABLE_OWNER TABLE_SCHEMA, IC.TABLE_NAME, '' INDEX_CATALOG, IC.INDEX_OWNER INDEX_SCHEMA, 
IC.INDEX_NAME, IC.COLUMN_NAME, IC.COLUMN_POSITION, DECODE(IC.DESCEND, 'ASC', 0, 1) DESCENDING FROM SYS.ALL_IND_COLUMNS IC, 
SYS.ALL_INDEXES I, SYS.ALL_CONSTRAINTS C WHERE IC.TABLE_OWNER = 'FRIOBOM' AND IC.TABLE_NAME = 'PCFORMCONFIG' AND I.UNIQUENESS = 
'UNIQUE' AND        I.OWNER = IC.INDEX_OWNER AND I.INDEX_NAME = IC.INDEX_NAME AND       C.TABLE_NAME (+) = IC.TABLE_NAME AND 
C.INDEX_NAME (+) = IC.INDEX_NAME AND C.OWNER (+)= IC.TABLE_OWNER ORDER BY DECODE(IC.INDEX_OWNER, 'FRIOBOM', 0, 'PUBLIC', 1, 2), 
DECODE(C.CONSTRAINT_TYPE, 'P', 1, 'U', 2, 3), IC.INDEX_OWNER, IC.TABLE_OWNER, IC.TABLE_NAME, IC.INDEX_NAME, IC.COLUMN_POSITION
----------------------------------
Timestamp: 14:55:40.762
UPDATE PCFORMCONFIG
SET
  ARQUIVO=EMPTY_BLOB()
WHERE
  CODIGO = :Old_CODIGO
RETURNING
  ARQUIVO
INTO
  :ARQUIVO
Old_CODIGO = 11084
----------------------------------
Timestamp: 14:55:40.814
Successful commit.
----------------------------------
Timestamp: 14:55:43.744
SELECT NOMEROTINA 
  FROM PCROTINA 
 WHERE CODIGO = :CODIGO
CODIGO = '1203'
----------------------------------
Timestamp: 14:55:43.862
SELECT pcprest.codfilial, pcprest.codfilialnf, pcprest.codsupervisor, pcsuperv.nome as nome_1,        
       pcprest.codusur, pcusuari.nome, pcprest.codcli, pcclient.cliente,                              
       pcprest.status, pcprest.valor, pcprest.valororig, pcprest.codcob, pcprest.numcar,              
       pcprest.codmotorista, pcempr.nome as nome_2, pcprest.codfunccxmot, pcprest.codfuncfecha,       
       pcprest.vpago, pcprest.valordesc, pcprest.txperm, pcprest.codbaixa,                            
       pcprest.codbanco, pcprest.codcobbanco, pcprest.numtrans, pcprest.numbanco, pcprest.numagencia, 
       pcprest.numcheque, pcprest.codbarra, pcprest.obs, pcprest.obs2, pcprest.alinea,                
       pcprest.nossonumbco, pcprest.tipo, pcprest.vltxboleto, pcprest.linhadig, pcprest.operacao,     
       pcprest.tipoprorrog, pcprest.codcoborig, pcprest.percom, pcprest.valorliqcom,                  
       pcprest.duplic, pcprest.numtransvenda, pcprest.prest, pcprest.vldevol, pcprest.txvendorcli,    
       pcprest.txvendorbco, nvl(pcprest.numdiasprazoprotesto,0) as numdiasprazoprotesto,              
       pcprest.dtemissao, pcprest.dtvenc, pcprest.dtvencorig,                                         
       pcprest.dtcxmot, pcprest.dtfecha, pcprest.dtpag,                                               
       pcprest.dtbaixa, pcprest.dtlancch,                                                             
       decode(nvl(pccob.calcjuroscobranca, 'N') ,'N',                                             
              paramfilial.obtercomonumber('CON_PERCJUROSMORA'),nvl(pccob.txjuros,0)) txjuros,       
       pcprest.numcustodia, pcprest.numlotecustodia,                                                  
       pcprest.codbancocustodia, pcprest.dtcustodia,                                                  
       pcprest.DTENVIOSERASA, pcprest.DTRETIRADASERASA,                                               
       PCPREST.DTRECEBIMENTOPREVISTO                                                                  
     , NVL(PCPREST.TXPERMPREVISTO, 0) TXPERMPREVISTO                                                  
     , EMPRCCXMOT.NOME FUNCCXMOT                                                                      
     , EMPRFECHA.NOME FUNCFECHA                                                                       
     , EMPRBAIXA.NOME FUNCBAIXA                                                                       
     , PCCOB.COBRANCA                                                                                 
     , COBORIG.COBRANCA COBRANCAORIG                                                                  
     , '   ' ENVIADOSERASA                                                                          
     , '   ' RETIRADOSERASA                                                                         
     , NVL(PCPREST.PERDESC,0) AS PERDESC 
  FROM pcprest, pcclient, pcusuari, pcsuperv, pcempr, pccob, pcdepto                                  
     , PCEMPR EMPRCCXMOT                                                                              
     , PCEMPR EMPRFECHA                                                                               
     , PCEMPR EMPRBAIXA                                                                               
     , PCCOB COBORIG                                                                                  
 WHERE pcprest.codcli = pcclient.codcli                                                               
   AND pcprest.codusur = pcusuari.codusur(+)                                                          
   AND pcprest.codsupervisor = pcsuperv.codsupervisor(+)                                              
   AND pcprest.codmotorista = pcempr.matricula(+)                                                     
   AND pcprest.codcob = pccob.codcob(+)                                                               
   AND pcprest.codepto = pcdepto.codepto(+)                                                           
   AND PCPREST.ROWID = :RID                                                                           
   AND PCPREST.CODFUNCCXMOT = EMPRCCXMOT.MATRICULA(+)                                                 
   AND PCPREST.CODFUNCFECHA = EMPRFECHA.MATRICULA(+)                                                  
   AND PCPREST.CODBAIXA = EMPRBAIXA.MATRICULA(+)                                                      
   AND PCPREST.CODCOBORIG = COBORIG.CODCOB(+)                                                         
ORDER BY  pcprest.duplic, pcprest.prest
RID = 'AAAHQIAAiAAHBc9AAV'
----------------------------------
Timestamp: 14:55:43.970
SELECT DTLANCPRORROG FROM PCPREST
WHERE NUMTRANSVENDA=:NT
AND   PREST=:PR
NT = 5932435
PR = '2'
----------------------------------
Timestamp: 14:55:44.097
SELECT DTLANCPRORROG FROM PCPREST
WHERE NUMTRANSVENDA=:NT
AND   PREST=:PR
NT = 5932435
PR = '2'
----------------------------------
Timestamp: 14:55:44.144
SELECT DTLANCPRORROG FROM PCPREST
WHERE NUMTRANSVENDA=:NT
AND   PREST=:PR
NT = 5932435
PR = '2'
----------------------------------
Timestamp: 14:55:44.209
SELECT DTLANCPRORROG FROM PCPREST
WHERE NUMTRANSVENDA=:NT
AND   PREST=:PR
NT = 5932435
PR = '2'
----------------------------------
Timestamp: 14:55:44.257
SELECT DTLANCPRORROG FROM PCPREST
WHERE NUMTRANSVENDA=:NT
AND   PREST=:PR
NT = 5932435
PR = '2'
----------------------------------
Timestamp: 14:55:44.302
SELECT PCMOV.NUMTRANSVENDA, PCMOV.NUMNOTA, PCMOV.CODPROD, PCPRODUT.DESCRICAO,                   
       PCMOV.DTMOV, NVL(PCMOV.QTCONT,0) AS QT, NVL(PCMOV.VLDESCONTO,0) AS VLDESCONTO,           
       DECODE(PCNFSAID.CONDVENDA, 5, NVL(PCMOV.PBONIFIC, PCMOV.PTABELA),                        
                                  6, NVL(PCMOV.PBONIFIC, PCMOV.PTABELA),                        
                                     NVL(PCMOV.PUNIT,0)) AS PUNIT,                              
       DECODE(PCNFSAID.CONDVENDA, 5, (NVL(PCMOV.QTCONT,0)* NVL(PCMOV.PBONIFIC, PCMOV.PTABELA)), 
                                  6, (NVL(PCMOV.QTCONT,0)* NVL(PCMOV.PBONIFIC, PCMOV.PTABELA)), 
                                     (NVL(PCMOV.QTCONT,0)* NVL(PCMOV.PUNIT,0))) AS VLTOTGER     
FROM  PCMOV, PCPRODUT, PCNFSAID                                                                 
WHERE PCMOV.CODPROD = PCPRODUT.CODPROD(+)                                                       
AND   PCMOV.NUMTRANSVENDA = :NUMTRANSVENDA                                                      
AND   PCMOV.NUMTRANSVENDA = PCNFSAID.NUMTRANSVENDA
NUMTRANSVENDA = 5932435
----------------------------------
Timestamp: 14:55:44.351
SELECT PCOCORBC.OCORRENCIA,
       PCOCORBCI.DESCRICAO,
       PCLOGCOBMAG.DATA,
       PCLOGCOBMAG.CODOCORRENCIA,
       PCLOGCOBMAG.CODSUBOCORRENCIA,
       PCLOGCOBMAG.VLCUSTAS,
       PCLOGCOBMAG.VLDESPESAS,
       PCLOGCOBMAG.USUARIO,
       PCLOGCOBMAG.MAQUINA,
       PCLOGCOBMAG.ARQRETORNO,
       PCLOGCOBMAG.ROTINALANC,
       PCPREST.NOMEARQUIVO,
       PCPREST.NUMREMESSA
  FROM PCOCORBC, PCOCORBCI, PCLOGCOBMAG, PCPREST
 WHERE PCOCORBC.CODOCORRENCIA(+) = PCLOGCOBMAG.CODOCORRENCIA
   AND PCOCORBC.NUMBANCO = PCLOGCOBMAG.CODBANCO
   AND PCOCORBCI.NUMBANCO(+) = PCLOGCOBMAG.CODBANCO
   AND PCOCORBCI.CODSUBOCORRENCIA(+) = PCLOGCOBMAG.CODSUBOCORRENCIA
   AND PCOCORBCI.CODOCORRENCIA(+) = PCLOGCOBMAG.CODOCORRENCIA 
   AND PCLOGCOBMAG.NUMTRANSVENDA = PCPREST.NUMTRANSVENDA(+) 
   AND PCLOGCOBMAG.PREST = PCPREST.PREST(+) 
   AND PCLOGCOBMAG.NUMTRANSVENDA = :NUMTRANSVENDA
   AND PCLOGCOBMAG.PREST = :PREST
 ORDER BY PCLOGCOBMAG.DATA DESC
NUMTRANSVENDA = 5932435
PREST = '2'
----------------------------------
Timestamp: 14:55:44.566
select pcprest.codcob,
       pcprest.codcoborig,
       pcprest.duplic,
       pcprest.numtransvenda,
       pcprest.prest,
       pcprest.valor,
       pcprest.valororig,
       pcprest.vldevol,
       pcprest.dtdevol,
       pcprest.txperm,
       pcprest.txpermprevisto,
       pcprest.txpermprevreal,
       pcprest.dtrecebimentoprevisto,
       pcprest.valordesc,
       pcprest.dtvenc,
       pcprest.dtemissao,
       pcprest.codfilial,
       pcprest.codfuncultalter,
       emprAlter.Nome NomeFuncUltAlter,
       pcprest.dtultalter,
       pcprest.codbaixa,
       pcprest.dtpag,
       pcprest.vpago,
       pccob.txjuros,
       0 clJuroPrevisto,
       0 VLRJUROS,
       0 VLRJUROSDIA,
       0 ATRASO,
       (SELECT COUNT(1) QTDE_DIAS_UTEIS                                              
         FROM PCDIASUTEIS                                                            
        WHERE DATA BETWEEN (pcprest.DTVENC + F_VERIFICARQTDIASCARENCIAS(pccob.CODCOB)) AND (TRUNC(SYSDATE) - 1) 
          AND CODFILIAL = pcprest.CODFILIAL                                              
          AND DIAFINANCEIRO = 'S') QTDE_DIAS_UTEIS,                               
       0 VLRTOTAL,
       trunc(sysdate) dataatual,
       emprBaixa.Nome NomeFuncBaixa,
        nullif(to_char(PCPREST.DTDESD, 'DD/MM/YYYY'), 'DD/MM/YYYY') || ' ' ||
               to_char(NVL(PCPREST.HORADESD, 0)) || ':' ||
               to_char(NVL(PCPREST.MINUTODESD, 0)) || ':00' 
               dtDesd,PCPREST.CODUSUR,PCUSUARI.NOME RCA
  from pccob, pcprest, pcempr emprBaixa, pcempr emprAlter, pcdesd,PCUSUARI
 where pcprest.numtransvenda = pcdesd.numtransvendaorig
   and pcprest.prest = pcdesd.prestorig
   and pccob.codcob(+) = pcprest.codcob
   and emprBaixa.Matricula(+) = pcprest.codbaixa
   and PCPREST.CODUSUR=PCUSUARI.CODUSUR(+)
   and emprAlter.Matricula(+) = pcprest.codfuncultalter
   and pcdesd.numtransvendadest = 5932435
   and pcdesd.prestdest = '2'
   and not exists (select pr.numtransvenda
                   from pcnfsaid nf, pcprest pr
                   where nf.numtransvenda = pr.numtransvenda
                   and pr.codcob = 'DESD' 
                   and pr.codcoborig = 'CRED' 
                   and nf.vendaassistida = 'S' 
                   and nf.numtransvenda = pcprest.numtransvenda) 
union
select pcprest.codcob,
       pcprest.codcoborig,
       pcprest.duplic,
       pcprest.numtransvenda,
       pcprest.prest,
       pcprest.valor,
       pcprest.valororig,
       pcprest.vldevol,
       pcprest.dtdevol,
       pcprest.txperm,
       pcprest.txpermprevisto,
       pcprest.txpermprevreal,
       pcprest.dtrecebimentoprevisto,
       pcprest.valordesc,
       pcprest.dtvenc,
       pcprest.dtemissao,
       pcprest.codfilial,
       pcprest.codfuncultalter,
       emprAlter.Nome NomeFuncUltAlter,
       pcprest.dtultalter,
       pcprest.codbaixa,
       pcprest.dtpag,
       pcprest.vpago,
       pccob.txjuros,
       0 clJuroPrevisto,
       0 VLRJUROS,
       0 VLRJUROSDIA,
       0 ATRASO,
       (SELECT COUNT(1) QTDE_DIAS_UTEIS                                              
         FROM PCDIASUTEIS                                                            
        WHERE DATA BETWEEN (pcprest.DTVENC + F_VERIFICARQTDIASCARENCIAS(pccob.CODCOB)) AND (TRUNC(SYSDATE) - 1) 
          AND CODFILIAL = pcprest.CODFILIAL                                              
          AND DIAFINANCEIRO = 'S') QTDE_DIAS_UTEIS,                               
       0 VLRTOTAL,
       trunc(sysdate) dataatual,
       emprBaixa.Nome NomeFuncBaixa,
        nullif(to_char(PCPREST.DTDESD, 'DD/MM/YYYY'), 'DD/MM/YYYY') || ' ' ||
               to_char(NVL(PCPREST.HORADESD, 0)) || ':' ||
               to_char(NVL(PCPREST.MINUTODESD, 0)) || ':00' 
               dtDesd,PCPREST.CODUSUR,PCUSUARI.NOME RCA
  from pccob, pcprest, pcempr emprBaixa, pcempr emprAlter, pcdesd,PCUSUARI
 where pcprest.numtransvenda = pcdesd.numtransvendadest
   and pcprest.prest = pcdesd.prestdest
   and pccob.codcob(+) = pcprest.codcob
   and PCPREST.CODUSUR=PCUSUARI.CODUSUR(+)
   and emprBaixa.Matricula(+) = pcprest.codbaixa
   and emprAlter.Matricula(+) = pcprest.codfuncultalter
   and pcdesd.numtransvendaorig = 5932435
   and pcdesd.prestorig = '2'
   and not exists (select pr.numtransvenda
                   from pcnfsaid nf, pcprest pr
                   where nf.numtransvenda = pr.numtransvenda
                   and pr.codcob = 'DESD' 
                   and pr.codcoborig = 'CRED' 
                   and nf.vendaassistida = 'S' 
                   and nf.numtransvenda = pcprest.numtransvenda)
----------------------------------
Timestamp: 14:55:44.851
SELECT * FROM PCFORMCONFIG
WHERE ROTINA = :ROTINA
  AND MATRICULA = :MATRICULA
ROTINA = 1203
MATRICULA = 1261
----------------------------------
Timestamp: 14:56:10.792
SELECT * FROM PCFORMCONFIG
WHERE ROTINA = :ROTINA
  AND MATRICULA = :MATRICULA
  AND NOME = :NOME
ROTINA = 1203
MATRICULA = 1261
NOME = '1'
----------------------------------
Timestamp: 14:56:10.841
Successful commit.
----------------------------------
Timestamp: 14:56:10.842
begin  :result := sys.dbms_transaction.local_transaction_id(true); end;
result = '40.4.4800696'
----------------------------------
Timestamp: 14:56:10.875
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '40.4.4800696'
----------------------------------
Timestamp: 14:56:10.899
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '40.4.4800696'
----------------------------------
Timestamp: 14:56:10.923
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '40.4.4800696'
----------------------------------
Timestamp: 14:56:10.948
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '40.4.4800696'
----------------------------------
Timestamp: 14:56:10.973
SELECT '' TABLE_CATALOG, IC.TABLE_OWNER TABLE_SCHEMA, IC.TABLE_NAME, '' INDEX_CATALOG, IC.INDEX_OWNER INDEX_SCHEMA, 
IC.INDEX_NAME, IC.COLUMN_NAME, IC.COLUMN_POSITION, DECODE(IC.DESCEND, 'ASC', 0, 1) DESCENDING FROM SYS.ALL_IND_COLUMNS IC, 
SYS.ALL_INDEXES I, SYS.ALL_CONSTRAINTS C WHERE IC.TABLE_OWNER = 'FRIOBOM' AND IC.TABLE_NAME = 'PCFORMCONFIG' AND I.UNIQUENESS = 
'UNIQUE' AND        I.OWNER = IC.INDEX_OWNER AND I.INDEX_NAME = IC.INDEX_NAME AND       C.TABLE_NAME (+) = IC.TABLE_NAME AND 
C.INDEX_NAME (+) = IC.INDEX_NAME AND C.OWNER (+)= IC.TABLE_OWNER ORDER BY DECODE(IC.INDEX_OWNER, 'FRIOBOM', 0, 'PUBLIC', 1, 2), 
DECODE(C.CONSTRAINT_TYPE, 'P', 1, 'U', 2, 3), IC.INDEX_OWNER, IC.TABLE_OWNER, IC.TABLE_NAME, IC.INDEX_NAME, IC.COLUMN_POSITION
----------------------------------
Timestamp: 14:56:10.994
UPDATE PCFORMCONFIG
SET
  ARQUIVO=EMPTY_BLOB()
WHERE
  CODIGO = :Old_CODIGO
RETURNING
  ARQUIVO
INTO
  :ARQUIVO
Old_CODIGO = 12679
----------------------------------
Timestamp: 14:56:11.043
Successful commit.
----------------------------------
Timestamp: 14:56:11.049
SELECT * FROM PCFORMCONFIG
WHERE ROTINA = :ROTINA
  AND MATRICULA = :MATRICULA
  AND NOME = :NOME
ROTINA = 1203
MATRICULA = 1261
NOME = '1'
----------------------------------
Timestamp: 14:56:11.107
Successful commit.
----------------------------------
Timestamp: 14:56:11.108
begin  :result := sys.dbms_transaction.local_transaction_id(true); end;
result = '2.10.5261584'
----------------------------------
Timestamp: 14:56:11.142
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '2.10.5261584'
----------------------------------
Timestamp: 14:56:11.168
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '2.10.5261584'
----------------------------------
Timestamp: 14:56:11.194
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '2.10.5261584'
----------------------------------
Timestamp: 14:56:11.220
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '2.10.5261584'
----------------------------------
Timestamp: 14:56:11.247
SELECT '' TABLE_CATALOG, IC.TABLE_OWNER TABLE_SCHEMA, IC.TABLE_NAME, '' INDEX_CATALOG, IC.INDEX_OWNER INDEX_SCHEMA, 
IC.INDEX_NAME, IC.COLUMN_NAME, IC.COLUMN_POSITION, DECODE(IC.DESCEND, 'ASC', 0, 1) DESCENDING FROM SYS.ALL_IND_COLUMNS IC, 
SYS.ALL_INDEXES I, SYS.ALL_CONSTRAINTS C WHERE IC.TABLE_OWNER = 'FRIOBOM' AND IC.TABLE_NAME = 'PCFORMCONFIG' AND I.UNIQUENESS = 
'UNIQUE' AND        I.OWNER = IC.INDEX_OWNER AND I.INDEX_NAME = IC.INDEX_NAME AND       C.TABLE_NAME (+) = IC.TABLE_NAME AND 
C.INDEX_NAME (+) = IC.INDEX_NAME AND C.OWNER (+)= IC.TABLE_OWNER ORDER BY DECODE(IC.INDEX_OWNER, 'FRIOBOM', 0, 'PUBLIC', 1, 2), 
DECODE(C.CONSTRAINT_TYPE, 'P', 1, 'U', 2, 3), IC.INDEX_OWNER, IC.TABLE_OWNER, IC.TABLE_NAME, IC.INDEX_NAME, IC.COLUMN_POSITION
----------------------------------
Timestamp: 14:56:11.265
UPDATE PCFORMCONFIG
SET
  ARQUIVO=EMPTY_BLOB()
WHERE
  CODIGO = :Old_CODIGO
RETURNING
  ARQUIVO
INTO
  :ARQUIVO
Old_CODIGO = 12680
----------------------------------
Timestamp: 14:56:11.305
Successful commit.
----------------------------------
Timestamp: 14:56:11.308
SELECT * FROM PCFORMCONFIG
WHERE ROTINA = :ROTINA
  AND MATRICULA = :MATRICULA
  AND NOME = :NOME
ROTINA = 1203
MATRICULA = 1261
NOME = 'P'
----------------------------------
Timestamp: 14:56:11.367
Successful commit.
----------------------------------
Timestamp: 14:56:11.370
begin  :result := sys.dbms_transaction.local_transaction_id(true); end;
result = '7.6.6523649'
----------------------------------
Timestamp: 14:56:11.408
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '7.6.6523649'
----------------------------------
Timestamp: 14:56:11.433
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '7.6.6523649'
----------------------------------
Timestamp: 14:56:11.457
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '7.6.6523649'
----------------------------------
Timestamp: 14:56:11.481
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '7.6.6523649'
----------------------------------
Timestamp: 14:56:11.504
SELECT '' TABLE_CATALOG, IC.TABLE_OWNER TABLE_SCHEMA, IC.TABLE_NAME, '' INDEX_CATALOG, IC.INDEX_OWNER INDEX_SCHEMA, 
IC.INDEX_NAME, IC.COLUMN_NAME, IC.COLUMN_POSITION, DECODE(IC.DESCEND, 'ASC', 0, 1) DESCENDING FROM SYS.ALL_IND_COLUMNS IC, 
SYS.ALL_INDEXES I, SYS.ALL_CONSTRAINTS C WHERE IC.TABLE_OWNER = 'FRIOBOM' AND IC.TABLE_NAME = 'PCFORMCONFIG' AND I.UNIQUENESS = 
'UNIQUE' AND        I.OWNER = IC.INDEX_OWNER AND I.INDEX_NAME = IC.INDEX_NAME AND       C.TABLE_NAME (+) = IC.TABLE_NAME AND 
C.INDEX_NAME (+) = IC.INDEX_NAME AND C.OWNER (+)= IC.TABLE_OWNER ORDER BY DECODE(IC.INDEX_OWNER, 'FRIOBOM', 0, 'PUBLIC', 1, 2), 
DECODE(C.CONSTRAINT_TYPE, 'P', 1, 'U', 2, 3), IC.INDEX_OWNER, IC.TABLE_OWNER, IC.TABLE_NAME, IC.INDEX_NAME, IC.COLUMN_POSITION
----------------------------------
Timestamp: 14:56:11.523
UPDATE PCFORMCONFIG
SET
  ARQUIVO=EMPTY_BLOB()
WHERE
  CODIGO = :Old_CODIGO
RETURNING
  ARQUIVO
INTO
  :ARQUIVO
Old_CODIGO = 11084
----------------------------------
Timestamp: 14:56:11.562
Successful commit.
----------------------------------
Timestamp: 14:56:27.034
SELECT NVL(VLVENDAMES01,0) VLVENDAMES01, NVL(VLVENDAMES02,0) VLVENDAMES02, NVL(VLVENDAMES03,0) VLVENDAMES03,
       NVL(VLVENDAMES04,0) VLVENDAMES04, NVL(VLVENDAMES05,0) VLVENDAMES05, NVL(VLVENDAMES06,0) VLVENDAMES06,
       NVL(VLVENDAMES07,0) VLVENDAMES07, NVL(VLVENDAMES08,0) VLVENDAMES08, NVL(VLVENDAMES09,0) VLVENDAMES09,
       NVL(VLVENDAMES10,0) VLVENDAMES10, NVL(VLVENDAMES11,0) VLVENDAMES11, NVL(VLVENDAMES12,0) VLVENDAMES12,
       CODCLI, ANO 
FROM PCAUXCLI
WHERE CODCLI = :CODCLI
ORDER BY CODCLI, ANO DESC
CODCLI = 119859
----------------------------------
Timestamp: 15:35:45.362
SELECT NVL(VLVENDAMES01,0) VLVENDAMES01, NVL(VLVENDAMES02,0) VLVENDAMES02, NVL(VLVENDAMES03,0) VLVENDAMES03,
       NVL(VLVENDAMES04,0) VLVENDAMES04, NVL(VLVENDAMES05,0) VLVENDAMES05, NVL(VLVENDAMES06,0) VLVENDAMES06,
       NVL(VLVENDAMES07,0) VLVENDAMES07, NVL(VLVENDAMES08,0) VLVENDAMES08, NVL(VLVENDAMES09,0) VLVENDAMES09,
       NVL(VLVENDAMES10,0) VLVENDAMES10, NVL(VLVENDAMES11,0) VLVENDAMES11, NVL(VLVENDAMES12,0) VLVENDAMES12,
       CODCLI, ANO 
FROM PCAUXCLI
WHERE CODCLI = :CODCLI
ORDER BY CODCLI, ANO DESC
CODCLI = 119859