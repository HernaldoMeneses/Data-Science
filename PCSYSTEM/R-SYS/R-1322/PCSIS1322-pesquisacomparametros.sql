----------------------------------
Timestamp: 10:09:18.139
SELECT NVL(VALOR, 0) QTDEITENS
  FROM PCPARAMFILIAL
 WHERE NOME LIKE 'FIL_NUMMAXITENSNFE'
   AND CODFILIAL = :CODFILIAL
CODFILIAL = '2'
----------------------------------
Timestamp: 10:09:18.179
SELECT PCCONTROI.CODROTINA                           
       , PCCONTROI.CODCONTROLE                         
       , PCROTINAI.DESCRICAO                           
       , NVL(PCCONTROI.ACESSO,'N') ACESSO            
       , PCCONTROI.CODUSUARIO 
    FROM PCCONTROI                                     
       , PCROTINAI                                     
   WHERE PCCONTROI.CODROTINA   = :CODROTINA            
     AND PCCONTROI.CODUSUARIO  = :MATRICULA            
     AND PCCONTROI.CODROTINA   = PCROTINAI.CODROTINA   
     AND PCCONTROI.CODCONTROLE = PCROTINAI.CODCONTROLE 
   ORDER                                               
      BY PCCONTROI.CODROTINA                           
       , PCCONTROI.CODCONTROLE
CODROTINA = 1322
MATRICULA = 1261
----------------------------------
Timestamp: 10:09:18.242
SELECT PCTRIBUT.CODST, PCTRIBUT.FORMULAFUNCEPICMS, PCTRIBUT.PERACRESCIMOFUNCEP, PCTABPR.PVENDA, PCTABPR.PTABELA, 
PCTRIBUT.SITTRIBUT
FROM   PCTABPR, PCTRIBUT
WHERE  PCTABPR.CODPROD = :CODPROD
AND    PCTABPR.NUMREGIAO = :NUMREGIAO
AND    PCTRIBUT.CODST = PCTABPR.CODST
CODPROD = 112562
NUMREGIAO = 1
----------------------------------
Timestamp: 10:09:18.281
SELECT NVL(PCEST.QTESTGER, 0) QTESTGER,
       NVL(PCEST.QTBLOQUEADA, 0) QTBLOQUEADA,
       NVL(PCEST.QTINDENIZ, 0) QTINDENIZ,
       NVL(PCEST.QTEST, 0) QTEST,
       NVL(PCEST.QTRESERV, 0) QTRESERV,
       NVL(PCEST.QTPENDENTE,0) QTPENDENTE,
       pkg_estoque.ESTOQUE_DISPONIVEL(PCEST.CODPROD,PCEST.CODFILIAL,null) QTSALDO,
       PCEST.VALORULTENT,
       PCEST.CUSTOCONT,
       PCEST.CUSTOFIN,
       PCEST.CUSTOREAL,
       PCEST.CUSTOREP,
       PCEST.CUSTOULTENT,
       PCPRODUT.CODSEC,
       PCPRODUT.CODEPTO, 
       PCEST.NUMFCI
  FROM PCEST, PCPRODUT
 WHERE PCEST.CODFILIAL = :CODFILIAL
   AND PCEST.CODPROD = :CODPROD
   AND PCEST.CODPROD = PCPRODUT.CODPROD
CODFILIAL = '2'
CODPROD = 112562
----------------------------------
Timestamp: 10:09:18.735
SELECT NVL(PCEST.QTESTGER, 0) QTESTGER,
       NVL(PCEST.QTBLOQUEADA, 0) QTBLOQUEADA,
       NVL(PCEST.QTINDENIZ, 0) QTINDENIZ,
       NVL(PCEST.QTEST, 0) QTEST,
       NVL(PCEST.QTRESERV, 0) QTRESERV,
       NVL(PCEST.QTPENDENTE,0) QTPENDENTE,
       pkg_estoque.ESTOQUE_DISPONIVEL(PCEST.CODPROD,PCEST.CODFILIAL,null) QTSALDO,
       PCEST.VALORULTENT,
       PCEST.CUSTOCONT,
       PCEST.CUSTOFIN,
       PCEST.CUSTOREAL,
       PCEST.CUSTOREP,
       PCEST.CUSTOULTENT,
       PCPRODUT.CODSEC,
       PCPRODUT.CODEPTO, 
       PCEST.NUMFCI
  FROM PCEST, PCPRODUT
 WHERE PCEST.CODFILIAL = :CODFILIAL
   AND PCEST.CODPROD = :CODPROD
   AND PCEST.CODPROD = PCPRODUT.CODPROD
CODFILIAL = '2'
CODPROD = 112562
----------------------------------
Timestamp: 10:09:18.915
select * from 
table(pkg_tributacao.CALCULAR_PVENDA_SEM_IMPOSTO( :psCodFilial    --        VARCHAR2,
                                                , :psCodFilialNF          --VARCHAR2,
                                                , :psCodFilialRetira     -- VARCHAR2,
                                                , :pCodCli                --IN NUMBER,
                                                , 1 --pCodPlPag              IN NUMBER,
                                                , : pCodProd              -- IN NUMBER,
                                                , 1 --pCodAuxiliar           IN NUMBER,
                                                , 1 --pCondVenda             IN NUMBER,
                                                , 'N' --psVendaExportacao      IN VARCHAR2,
                                                , 1 --pSTPrecificado         IN NUMBER,
                                                , :pVendaSemImposto      -- IN NUMBER,
                                                , :pVenda                 --IN NUMBER
                                       /*,
                                       pRetiraImposto201      IN VARCHAR2 DEFAULT 'N',
                                       pFoiPrecificadoIPI     IN VARCHAR2 DEFAULT 'S',
                                       pItemTV1Bnf            IN VARCHAR2 DEFAULT 'N',
                                       pCodPrecoFixo          IN NUMBER   DEFAULT 0,
                                       psOrigemPedido         IN VARCHAR2 DEFAULT NULL,
                                       pUtilizaCustoVendaTV10 IN VARCHAR2 DEFAULT 'N',
                                       pTransferencia         IN VARCHAR2 DEFAULT 'N',
                                       pVendaLocalEstrangeira IN VARCHAR2 DEFAULT 'N',
                                       pTransferenciaVirtual  IN VARCHAR2 DEFAULT 'N',
                                       pPtabela               IN NUMBER   DEFAULT 0,
                                       pVendaTriangular       IN VARCHAR2 DEFAULT 'N',
                                       pRotinaConsum          IN VARCHAR2 DEFAULT 'T',
                                       pCodBnf                IN NUMBER   DEFAULT 0, -- HIS.03069.2016
                                       pCodEndEnt             IN NUMBER   DEFAULT 0,
                                       pTipoDocumento         IN VARCHAR2 DEFAULT 'N', --Tipo do documento do pedido N = Nota, 
C = Cupom etc...
                                       pconsultardblink       IN VARCHAR2 DEFAULT 'N',  --quando usando banco caixa, se vai no 
servidor ou não
                                       pcontaordem            IN VARCHAR2 DEFAULT 'N', -- Conta e ordem TV8
                                       pValorICMSPartilhaRem  IN NUMBER   DEFAULT 0,
                                       pRetiraFecp            IN VARCHAR2 DEFAULT 'N'*/
                                       )

)
psCodFilial = '2'
psCodFilialNF = '2'
psCodFilialRetira = '2'
pCodCli = 101003
pCodProd = 112562
pVendaSemImposto = 7,07
pVenda = 7,07
----------------------------------
Timestamp: 10:09:19.096
SELECT FERRAMENTAS.VERIFICAR_TIPOST(:CODCLI, :CODST) TIPOST FROM DUAL
CODCLI = '101003'
CODST = '2'
----------------------------------
Timestamp: 10:09:19.134
SELECT FERRAMENTAS.VERIFICAR_TIPOST(:CODCLI, :CODST) TIPOST FROM DUAL
CODCLI = '101003'
CODST = '2'
----------------------------------
Timestamp: 10:09:19.184
SELECT NVL(PCTRIBUT.IVA,0) AS IVA 
      , NVL(PCTRIBUT.PAUTA,0) AS PAUTA  
      , NVL(PCTRIBUT.ALIQICMS1,0) AS ALIQICMS1                                              
      , NVL(PCTRIBUT.ALIQICMS2,0) AS ALIQICMS2                                                                   
      , CASE WHEN NVL(PCTRIBUT.PERCBASEREDST,0) = 0                                            
             THEN 100                                                                          
             ELSE PCTRIBUT.PERCBASEREDST                                                       
        END PERCBASEREDST                                                                      
      , NVL(PCTRIBUT.PERPAUTAICMS, 0) PERPAUTAICMS                                             
      , NVL(PCTRIBUT.USAVALORULTENTBASEST,'S') USAVALORULTENTBASEST                          
      , NVL(PCTRIBUT.PERPAUTAICMSINTER, 0) PERPAUTAICMSINTER,                                  
       CASE WHEN NVL(PCTRIBUT.PERCBASERED,0) = 0                                              
             THEN 100                                                                         
             ELSE PCTRIBUT.PERCBASERED                                                        
        END PERBASERED,                                                                       
       CASE WHEN NVL(PCTRIBUT.PERBASEREDNRPA,0) = 0                                           
             THEN 100                                                                         
             ELSE PCTRIBUT.PERBASEREDNRPA                                                     
        END PERBASEREDNRPA,                                                                   
       CASE WHEN NVL(PCTRIBUT.PERCBASEREDCONSUMIDOR,0) = 0                                    
             THEN 100                                                                         
             ELSE PCTRIBUT.PERCBASEREDCONSUMIDOR                                              
        END PERCBASEREDCONSUMIDOR,                                                            
      NVL(PCTRIBUT.PERPAUTAICMS, 0) PERPAUTAICMS,
      PCTRIBUT.CODICM, PCTRIBUT.CODICMPF, PCTRIBUT.SITTRIBUT,
      PCTRIBUT.CODFISCALSREXT, PCTRIBUT.CODFISCALSRESTSR,
      PCTRIBUT.CODFISCALSRINTE, 
      NVL(PCTRIBUT.PERCDIFALIQUOTAS,0) PERCDIFALIQUOTAS,
      NVL(PCTRIBUT.PERPAUTAICMSINTER, 0) PERPAUTAICMSINTER,
      NVL(PCTRIBUT.UTILIZAPERCBASEREDPF,'N') UTILIZAPERCBASEREDPF,
      NVL(PCTRIBUT.PERDIFEREIMENTOICMS,0) PERDIFEREIMENTOICMS, PCTRIBUT.SITTRIBUTPF
   FROM PCTRIBUT                                                                               
  WHERE PCTRIBUT.CODST = :CODST
CODST = 2
----------------------------------
Timestamp: 10:09:19.283
SELECT ROUND(:VALOR,2) VALOR
FROM   DUAL
VALOR = 0
----------------------------------
Timestamp: 10:09:19.342
SELECT FERRAMENTAS.VERIFICAR_FJ(:CODCLI) TIPOFJ FROM DUAL
CODCLI = '101003'
----------------------------------
Timestamp: 10:09:19.485
begin
  :RESULT := FISCAL.GET_DADOS_TRIBUTACAO_IPI(:P_CODCLI, :P_CODPROD, :P_CODFILIAL, :P_DATAOPERACAO, :P_CST_ENTRADA, :P_CST_SAIDA,
 :P_GERABASEALIQZERO, :P_MSG, :P_CODFISCAL, :P_TIPO_VENDA, :P_TIPO_ENTRADA, :P_CODIGO_OPERACAO, :P_CODENQENTRADA, 
:P_CODENQSAIDA);
end;
RESULT = 'N'
P_CODCLI = 101003
P_CODPROD = 112562
P_CODFILIAL = '2'
P_DATAOPERACAO = '02/11/2023'
P_CST_ENTRADA = <NULL>
P_CST_SAIDA = <NULL>
P_GERABASEALIQZERO = <NULL>
P_MSG = 'FIGURA TRIBUTÁRIA DO IPI INEXISTENTE OU NÃO VINCULADA!'
P_CODFISCAL = 5949
P_TIPO_VENDA = 1
P_TIPO_ENTRADA = <NULL>
P_CODIGO_OPERACAO = 'SR'
P_CODENQENTRADA = <NULL>
P_CODENQSAIDA = <NULL>
----------------------------------
Timestamp: 10:09:19.705
SELECT PCCONTROI.CODROTINA                           
       , PCCONTROI.CODCONTROLE                         
       , PCROTINAI.DESCRICAO                           
       , NVL(PCCONTROI.ACESSO,'N') ACESSO            
       , PCCONTROI.CODUSUARIO 
    FROM PCCONTROI                                     
       , PCROTINAI                                     
   WHERE PCCONTROI.CODROTINA   = :CODROTINA            
     AND PCCONTROI.CODUSUARIO  = :MATRICULA            
     AND PCCONTROI.CODROTINA   = PCROTINAI.CODROTINA   
     AND PCCONTROI.CODCONTROLE = PCROTINAI.CODCONTROLE 
   ORDER                                               
      BY PCCONTROI.CODROTINA                           
       , PCCONTROI.CODCONTROLE
CODROTINA = 1322
MATRICULA = 1261
----------------------------------
Timestamp: 10:09:19.767
SELECT PCCLIENT.TIPOFJ
      ,NVL(PCCLIENT.UTILIZAIESIMPLIFICADA, 'N') UTILIZAIESIMPLIFICADA
      ,NVL(PCCLIENT.CONSUMIDORFINAL, 'N') CONSUMIDORFINAL
      ,PCCLIENT.IEENT
      ,NVL(PCCLIENT.CONTRIBUINTE, 'N') CONTRIBUINTE
      ,NVL(PCCONSUM.CONSIDERAISENTOSCOMOPF, 'N') CONSIDERAISENTOSCOMOPF
  FROM PCCLIENT, PCCONSUM
 WHERE PCCLIENT.CODCLI = :CODCLI
CODCLI = 101003
----------------------------------
Timestamp: 10:09:19.833
SELECT PCCLIENT.TIPOFJ
      ,NVL(PCCLIENT.UTILIZAIESIMPLIFICADA, 'N') UTILIZAIESIMPLIFICADA
      ,NVL(PCCLIENT.CONSUMIDORFINAL, 'N') CONSUMIDORFINAL
      ,PCCLIENT.IEENT
      ,NVL(PCCLIENT.CONTRIBUINTE, 'N') CONTRIBUINTE
      ,NVL(PCCONSUM.CONSIDERAISENTOSCOMOPF, 'N') CONSIDERAISENTOSCOMOPF
  FROM PCCLIENT, PCCONSUM
 WHERE PCCLIENT.CODCLI = :CODCLI
CODCLI = 101003
----------------------------------
Timestamp: 10:09:19.896
SELECT PCCLIENT.TIPOFJ
      ,NVL(PCCLIENT.UTILIZAIESIMPLIFICADA, 'N') UTILIZAIESIMPLIFICADA
      ,NVL(PCCLIENT.CONSUMIDORFINAL, 'N') CONSUMIDORFINAL
      ,PCCLIENT.IEENT
      ,NVL(PCCLIENT.CONTRIBUINTE, 'N') CONTRIBUINTE
      ,NVL(PCCONSUM.CONSIDERAISENTOSCOMOPF, 'N') CONSIDERAISENTOSCOMOPF
  FROM PCCLIENT, PCCONSUM
 WHERE PCCLIENT.CODCLI = :CODCLI
CODCLI = 101003
----------------------------------
Timestamp: 10:09:19.968
SELECT NVL(PCEST.NUMTRANSENTULTENT,0) AS NUMTRANSENT_ULT_NF
  FROM PCEST
 WHERE PCEST.CODPROD = :CODPROD
   AND PCEST.CODFILIAL = :CODFILIAL
CODPROD = 112562
CODFILIAL = '2'
----------------------------------
Timestamp: 10:09:20.016
SELECT NVL(PCMOV.PUNIT,0) AS PUNIT_ULT_NF
  FROM PCMOV
 WHERE NUMTRANSENT = :NUMTRANSENT
   AND CODPROD = :CODPROD
   AND CODFILIAL = :CODFILIAL
NUMTRANSENT = 219354
CODPROD = 112562
CODFILIAL = '2'
----------------------------------
Timestamp: 10:09:20.119
SELECT NVL(PCEST.QTESTGER, 0) QTESTGER,
       NVL(PCEST.QTBLOQUEADA, 0) QTBLOQUEADA,
       NVL(PCEST.QTINDENIZ, 0) QTINDENIZ,
       NVL(PCEST.QTEST, 0) QTEST,
       NVL(PCEST.QTRESERV, 0) QTRESERV,
       NVL(PCEST.QTPENDENTE,0) QTPENDENTE,
       pkg_estoque.ESTOQUE_DISPONIVEL(PCEST.CODPROD,PCEST.CODFILIAL,null) QTSALDO,
       PCEST.VALORULTENT,
       PCEST.CUSTOCONT,
       PCEST.CUSTOFIN,
       PCEST.CUSTOREAL,
       PCEST.CUSTOREP,
       PCEST.CUSTOULTENT,
       PCPRODUT.CODSEC,
       PCPRODUT.CODEPTO, 
       PCEST.NUMFCI
  FROM PCEST, PCPRODUT
 WHERE PCEST.CODFILIAL = :CODFILIAL
   AND PCEST.CODPROD = :CODPROD
   AND PCEST.CODPROD = PCPRODUT.CODPROD
CODFILIAL = '2'
CODPROD = 112562
----------------------------------
Timestamp: 10:09:20.250
begin  :Result := SYS_CONTEXT ('USERENV', 'CURRENT_SCHEMA');end;
Result = 'FRIOBOM'
----------------------------------
Timestamp: 10:09:20.499
SELECT '' TABLE_CATALOG, IC.TABLE_OWNER TABLE_SCHEMA, IC.TABLE_NAME, '' INDEX_CATALOG, IC.INDEX_OWNER INDEX_SCHEMA, 
IC.INDEX_NAME, IC.COLUMN_NAME, IC.COLUMN_POSITION, DECODE(IC.DESCEND, 'ASC', 0, 1) DESCENDING FROM SYS.ALL_IND_COLUMNS IC, 
SYS.ALL_INDEXES I, SYS.ALL_CONSTRAINTS C WHERE IC.TABLE_OWNER = 'FRIOBOM' AND IC.TABLE_NAME = 'PCCONTROI' AND I.UNIQUENESS = 
'UNIQUE' AND        I.OWNER = IC.INDEX_OWNER AND I.INDEX_NAME = IC.INDEX_NAME AND       C.TABLE_NAME (+) = IC.TABLE_NAME AND 
C.INDEX_NAME (+) = IC.INDEX_NAME AND C.OWNER (+)= IC.TABLE_OWNER ORDER BY DECODE(IC.INDEX_OWNER, 'FRIOBOM', 0, 'PUBLIC', 1, 2), 
DECODE(C.CONSTRAINT_TYPE, 'P', 1, 'U', 2, 3), IC.INDEX_OWNER, IC.TABLE_OWNER, IC.TABLE_NAME, IC.INDEX_NAME, IC.COLUMN_POSITION
----------------------------------
Timestamp: 10:09:20.533
SELECT PCCONTROI.CODROTINA                           
       , PCCONTROI.CODCONTROLE                         
       , PCROTINAI.DESCRICAO                           
       , NVL(PCCONTROI.ACESSO,'N') ACESSO            
       , PCCONTROI.CODUSUARIO 
    FROM PCCONTROI                                     
       , PCROTINAI                                     
   WHERE PCCONTROI.CODROTINA   = :CODROTINA            
     AND PCCONTROI.CODUSUARIO  = :MATRICULA            
     AND PCCONTROI.CODROTINA   = PCROTINAI.CODROTINA   
     AND PCCONTROI.CODCONTROLE = PCROTINAI.CODCONTROLE 
   ORDER                                               
      BY PCCONTROI.CODROTINA                           
       , PCCONTROI.CODCONTROLE
CODROTINA = 1322
MATRICULA = 1261
----------------------------------
Timestamp: 10:09:20.605
SELECT FERRAMENTAS.VERIFICAR_TIPOST(:CODCLI, :CODST) TIPOST FROM DUAL
CODCLI = '101003'
CODST = '2'
----------------------------------
Timestamp: 10:09:20.656
SELECT FERRAMENTAS.VERIFICAR_TIPOST(:CODCLI, :CODST) TIPOST FROM DUAL
CODCLI = '101003'
CODST = '2'
----------------------------------
Timestamp: 10:09:20.698
SELECT NVL(PCTRIBUT.IVA,0) AS IVA 
      , NVL(PCTRIBUT.PAUTA,0) AS PAUTA  
      , NVL(PCTRIBUT.ALIQICMS1,0) AS ALIQICMS1                                              
      , NVL(PCTRIBUT.ALIQICMS2,0) AS ALIQICMS2                                                                   
      , CASE WHEN NVL(PCTRIBUT.PERCBASEREDST,0) = 0                                            
             THEN 100                                                                          
             ELSE PCTRIBUT.PERCBASEREDST                                                       
        END PERCBASEREDST                                                                      
      , NVL(PCTRIBUT.PERPAUTAICMS, 0) PERPAUTAICMS                                             
      , NVL(PCTRIBUT.USAVALORULTENTBASEST,'S') USAVALORULTENTBASEST                          
      , NVL(PCTRIBUT.PERPAUTAICMSINTER, 0) PERPAUTAICMSINTER,                                  
       CASE WHEN NVL(PCTRIBUT.PERCBASERED,0) = 0                                              
             THEN 100                                                                         
             ELSE PCTRIBUT.PERCBASERED                                                        
        END PERBASERED,                                                                       
       CASE WHEN NVL(PCTRIBUT.PERBASEREDNRPA,0) = 0                                           
             THEN 100                                                                         
             ELSE PCTRIBUT.PERBASEREDNRPA                                                     
        END PERBASEREDNRPA,                                                                   
       CASE WHEN NVL(PCTRIBUT.PERCBASEREDCONSUMIDOR,0) = 0                                    
             THEN 100                                                                         
             ELSE PCTRIBUT.PERCBASEREDCONSUMIDOR                                              
        END PERCBASEREDCONSUMIDOR,                                                            
      NVL(PCTRIBUT.PERPAUTAICMS, 0) PERPAUTAICMS,
      PCTRIBUT.CODICM, PCTRIBUT.CODICMPF, PCTRIBUT.SITTRIBUT,
      PCTRIBUT.CODFISCALSREXT, PCTRIBUT.CODFISCALSRESTSR,
      PCTRIBUT.CODFISCALSRINTE, 
      NVL(PCTRIBUT.PERCDIFALIQUOTAS,0) PERCDIFALIQUOTAS,
      NVL(PCTRIBUT.PERPAUTAICMSINTER, 0) PERPAUTAICMSINTER,
      NVL(PCTRIBUT.UTILIZAPERCBASEREDPF,'N') UTILIZAPERCBASEREDPF,
      NVL(PCTRIBUT.PERDIFEREIMENTOICMS,0) PERDIFEREIMENTOICMS, PCTRIBUT.SITTRIBUTPF
   FROM PCTRIBUT                                                                               
  WHERE PCTRIBUT.CODST = :CODST
CODST = 2
----------------------------------
Timestamp: 10:09:20.797
SELECT ROUND(:VALOR,2) VALOR
FROM   DUAL
VALOR = 0
----------------------------------
Timestamp: 10:09:20.844
SELECT FERRAMENTAS.VERIFICAR_FJ(:CODCLI) TIPOFJ FROM DUAL
CODCLI = '101003'
----------------------------------
Timestamp: 10:09:20.894
begin
  :RESULT := FISCAL.GET_DADOS_TRIBUTACAO_IPI(:P_CODCLI, :P_CODPROD, :P_CODFILIAL, :P_DATAOPERACAO, :P_CST_ENTRADA, :P_CST_SAIDA,
 :P_GERABASEALIQZERO, :P_MSG, :P_CODFISCAL, :P_TIPO_VENDA, :P_TIPO_ENTRADA, :P_CODIGO_OPERACAO, :P_CODENQENTRADA, 
:P_CODENQSAIDA);
end;
RESULT = 'N'
P_CODCLI = 101003
P_CODPROD = 112562
P_CODFILIAL = '2'
P_DATAOPERACAO = '02/11/2023'
P_CST_ENTRADA = <NULL>
P_CST_SAIDA = <NULL>
P_GERABASEALIQZERO = <NULL>
P_MSG = 'FIGURA TRIBUTÁRIA DO IPI INEXISTENTE OU NÃO VINCULADA!'
P_CODFISCAL = 5949
P_TIPO_VENDA = 1
P_TIPO_ENTRADA = <NULL>
P_CODIGO_OPERACAO = 'SR'
P_CODENQENTRADA = <NULL>
P_CODENQSAIDA = <NULL>
----------------------------------
Timestamp: 10:09:21.102
SELECT PCCONTROI.CODROTINA                           
       , PCCONTROI.CODCONTROLE                         
       , PCROTINAI.DESCRICAO                           
       , NVL(PCCONTROI.ACESSO,'N') ACESSO            
       , PCCONTROI.CODUSUARIO 
    FROM PCCONTROI                                     
       , PCROTINAI                                     
   WHERE PCCONTROI.CODROTINA   = :CODROTINA            
     AND PCCONTROI.CODUSUARIO  = :MATRICULA            
     AND PCCONTROI.CODROTINA   = PCROTINAI.CODROTINA   
     AND PCCONTROI.CODCONTROLE = PCROTINAI.CODCONTROLE 
   ORDER                                               
      BY PCCONTROI.CODROTINA                           
       , PCCONTROI.CODCONTROLE
CODROTINA = 1322
MATRICULA = 1261
----------------------------------
Timestamp: 10:09:21.158
SELECT PCCLIENT.TIPOFJ
      ,NVL(PCCLIENT.UTILIZAIESIMPLIFICADA, 'N') UTILIZAIESIMPLIFICADA
      ,NVL(PCCLIENT.CONSUMIDORFINAL, 'N') CONSUMIDORFINAL
      ,PCCLIENT.IEENT
      ,NVL(PCCLIENT.CONTRIBUINTE, 'N') CONTRIBUINTE
      ,NVL(PCCONSUM.CONSIDERAISENTOSCOMOPF, 'N') CONSIDERAISENTOSCOMOPF
  FROM PCCLIENT, PCCONSUM
 WHERE PCCLIENT.CODCLI = :CODCLI
CODCLI = 101003
----------------------------------
Timestamp: 10:09:21.229
SELECT PCCLIENT.TIPOFJ
      ,NVL(PCCLIENT.UTILIZAIESIMPLIFICADA, 'N') UTILIZAIESIMPLIFICADA
      ,NVL(PCCLIENT.CONSUMIDORFINAL, 'N') CONSUMIDORFINAL
      ,PCCLIENT.IEENT
      ,NVL(PCCLIENT.CONTRIBUINTE, 'N') CONTRIBUINTE
      ,NVL(PCCONSUM.CONSIDERAISENTOSCOMOPF, 'N') CONSIDERAISENTOSCOMOPF
  FROM PCCLIENT, PCCONSUM
 WHERE PCCLIENT.CODCLI = :CODCLI
CODCLI = 101003
----------------------------------
Timestamp: 10:09:21.305
SELECT PCCLIENT.TIPOFJ
      ,NVL(PCCLIENT.UTILIZAIESIMPLIFICADA, 'N') UTILIZAIESIMPLIFICADA
      ,NVL(PCCLIENT.CONSUMIDORFINAL, 'N') CONSUMIDORFINAL
      ,PCCLIENT.IEENT
      ,NVL(PCCLIENT.CONTRIBUINTE, 'N') CONTRIBUINTE
      ,NVL(PCCONSUM.CONSIDERAISENTOSCOMOPF, 'N') CONSIDERAISENTOSCOMOPF
  FROM PCCLIENT, PCCONSUM
 WHERE PCCLIENT.CODCLI = :CODCLI
CODCLI = 101003
----------------------------------
Timestamp: 10:09:21.370
SELECT NVL(PCEST.NUMTRANSENTULTENT,0) AS NUMTRANSENT_ULT_NF
  FROM PCEST
 WHERE PCEST.CODPROD = :CODPROD
   AND PCEST.CODFILIAL = :CODFILIAL
CODPROD = 112562
CODFILIAL = '2'
----------------------------------
Timestamp: 10:09:21.412
SELECT NVL(PCMOV.PUNIT,0) AS PUNIT_ULT_NF
  FROM PCMOV
 WHERE NUMTRANSENT = :NUMTRANSENT
   AND CODPROD = :CODPROD
   AND CODFILIAL = :CODFILIAL
NUMTRANSENT = 219354
CODPROD = 112562
CODFILIAL = '2'
----------------------------------
Timestamp: 10:09:21.539
SELECT * 
    FROM TABLE(PKG_TRIBUTACAO.CALCULAR_ST(:CODFILIAL, 
                                          :CODFILIALNF, 
                                          :CODFILIALRETIRA, 
                                          :CODCLI, 
                                          :CODPLPAG, 
                                          :CODPROD, 
                                          :CODAUXILIAR, 
                                          :CONDVENDA, 
                                          :VENDAEXPORTACAO, 
                                          :PVENDA, 
                                          :PERCDESCINFOR,
                                          :ITEMTV1BNF,
                                          :VALORDESCPIS_COFINS,
                                          :VALORDESCICMS,
                                          :VALORSUFRAMA,
                                           NULL,
                                          :CALCULAIPI,
                                          :TRANSFERENCIA,
                                          :ORIGEMPED,
                                          :VENDALOCALESTRANGEIRA,
                                          :CODPRECOFIXO,
                                          :TRANSFERENCIAVIRTUAL,
                                          :PTABELASEMIMPOSTO,
                                          :VENDATRIANGULAR,
                                          :ROTINACONSUM,
                                          :CODBNF,
                                          :CODENDENT,
                                          'N',
                                          :TIPODOCUMENTO,
                                          'N',
                                          :CONTAORDEM,
                                          :VLICMSPARTREM
                                          ))
CODFILIAL = '2'
CODFILIALNF = '2'
CODFILIALRETIRA = '2'
CODCLI = 101003
CODPLPAG = 1
CODPROD = 112562
CODAUXILIAR = 0
CONDVENDA = 1
VENDAEXPORTACAO = 'N'
PVENDA = 7,07
PERCDESCINFOR = 0
ITEMTV1BNF = 'N'
VALORDESCPIS_COFINS = 0
VALORDESCICMS = 0
VALORSUFRAMA = 0
CALCULAIPI = 'S'
TRANSFERENCIA = 'N'
ORIGEMPED = 'B'
VENDALOCALESTRANGEIRA = 'N'
CODPRECOFIXO = 0
TRANSFERENCIAVIRTUAL = <NULL>
PTABELASEMIMPOSTO = 0
VENDATRIANGULAR = 'N'
ROTINACONSUM = 'T'
CODBNF = 0
CODENDENT = 0
TIPODOCUMENTO = 'N'
CONTAORDEM = 'N'
VLICMSPARTREM = 0
----------------------------------
Timestamp: 10:09:22.021
BEGIN PKG_DEBUGGING_FWPC.DESATIVARDEBUG(); END;
----------------------------------
Timestamp: 10:09:22.172
SELECT *                                    
   FROM PCFWREPOSITORIO                      
  WHERE UPPER(SERVICO) = UPPER(:NOMESERVICO) 
    AND VERSAO = :VERSAOSERVICO
NOMESERVICO = 'w'
VERSAOSERVICO = '1'
----------------------------------
Timestamp: 10:09:22.452
DECLARE
  V_ENTRADA CLOB;
  V_RESULTADOHASH VARCHAR2(32);
BEGIN
  V_ENTRADA := EMPTY_CLOB();
  V_ENTRADA := :ENTRADA;
  V_RESULTADOHASH := RAWTOHEX(DBMS_OBFUSCATION_TOOLKIT.MD5(INPUT => UTL_RAW.CAST_TO_RAW(NVL(V_ENTRADA, EMPTY_CLOB()))));
  :RESULTADOHASH := V_RESULTADOHASH;
END;
RESULTADOHASH = '7'
----------------------------------
Timestamp: 10:09:22.598
declare 
--variaveis output

  FUNCTION F10_ANPEXCECAO(pCODPROD NUMBER) RETURN BOOLEAN
IS 
	QT NUMBER(1);
BEGIN
	PKG_DEBUGGING_FWPC.LOG_MSG('CONSULTANDO EXCEÇÕES DE ANP DO PRODUTO'); 
	SELECT COUNT(*) 
	 INTO QT
	 FROM PCPRODUT
	  WHERE CODPROD = pCODPROD 
	  AND NVL(ANP,0) IN ('820101001', '820101010', '810102001', '810102004', '810102002', '810102003', '810101002', '810101001', 
						 '810101003', '220101003', '220101004', '220101002', '220101001', '220101005', '220101006');	
	  RETURN QT = 0;
END;

FUNCTION F10_CSTEXCECAO(P_CODST NUMBER, P_PESSOAFISICA VARCHAR2, P_ISENTOST VARCHAR2, P_CLIENTEFONTEST VARCHAR2, P_TIPOEMPRESA 
VARCHAR2) RETURN BOOLEAN 
IS
    vssittribut VARCHAR2(3);
    vssittributpf VARCHAR2(3);
    vssittributisentost VARCHAR2(3);
    vssittributsuframa VARCHAR2(3);
    vssittribstfontepf VARCHAR2(3);
    vssittribstfontepj VARCHAR2(3);
    vssittribsimplesnac VARCHAR2(3);
    vncodicmsimplesnac NUMBER(8,4);    
BEGIN
	PKG_DEBUGGING_FWPC.LOG_MSG('CONSULTANDO EXCEÇÕES DE CST'); 
    SELECT TRIB.SITTRIBUTPF,
       NVL(TRIB.SITTRIBUTISENTOST, NVL(TRIB.SITTRIBUT, '000')),
       TRIB.SITTRIBUTSUFRAMA,
       TRIB.SITTRIBSTFONTEPF,
       TRIB.SITTRIBSTFONTEPJ,
       TRIB.CODICMSIMPLESNAC,
       TRIB.SITTRIBUTSIMPLESNAC
       INTO
       vssittribut,
       vssittributisentost,
       vssittributsuframa,
       vssittribstfontepf,
       vssittribstfontepj,
       vncodicmsimplesnac,
       vssittribsimplesnac
          FROM PCTRIBUT TRIB
          WHERE TRIB.CODST = P_CODST;

       IF (P_PESSOAFISICA = 'S') THEN
            vssittribut := vssittributpf;
       END IF;
       
       IF (P_ISENTOST = 'S') THEN
            vssittribut := vssittributisentost;
       END IF;
       
       IF vssittributsuframa IS NOT NULL THEN 
          vssittribut := vssittributsuframa;
       END IF;
   
       IF (P_CLIENTEFONTEST = 'S') THEN
         IF P_PESSOAFISICA = 'S' THEN
          vssittribut := NVL(vssittribstfontepf,vssittribut); 
         ELSE
          vssittribut := NVL(vssittribstfontepj,vssittribut);
         END IF;
       END IF; 
        
       IF (UPPER(TRIM(P_TIPOEMPRESA)) = 'SN') AND
           vncodicmsimplesnac     IS NOT NULL AND 
           vssittribsimplesnac    IS NOT NULL 
       THEN
           vssittribut := vssittribsimplesnac;
       END IF;     
       
       RETURN (vssittribut = 40 OR vssittribut = 41 OR vssittribut = 103 OR vssittribut = 300 OR vssittribut = 400);
END;
  
   procedure F10_CALCULAR_VALORES(P_CODFILIAL         in varchar2
                                 ,P_VLPRODUTO         in number
                                 ,P_DATAOPER          in date
                                 ,P_CLIENTEISENTO     in varchar2
                                 ,P_ALIQOPERACAO      in out number
                                 ,P_ALIQINTERESTADUAL in number
                                 ,P_ALIQINTERNADEST   in number
                                 ,P_ALIQFCP           in number
                                 ,P_PERCBASERED       in out number
                                 ,P_RETORNO           out varchar2) is
      V_VLICMSPARTREM   number(22, 6);
      V_VLBASEPARTDEST  number(22, 6);
      V_VLFCPPART       number(22, 6);
      V_VLICMSPARTDEST  number(22, 6);
      V_PERCPROVPART    number(22, 6);
      V_VLICMSDIFALIQ   number(22, 6);
      V_VLICMSPART      number(22, 6);
      V_ANOOPER         number(4);
      V_XMLRETORNO      XMLTYPE;
      V_AGREGARVLOPER   boolean;
      V_REDUZIRBASEDEST boolean;
   
   begin
      PKG_DEBUGGING_FWPC.LOG_MSG('CALCULANDO PARTILHA DE ICMS');
      V_AGREGARVLOPER := NVL(PARAMFILIAL.OBTERCOMOVARCHAR2('ACRESCICMSPARTILHAPRECO', P_CODFILIAL)
                            ,'N') = 'S';
   
      if V_AGREGARVLOPER
      then
         V_VLBASEPARTDEST := P_VLPRODUTO / (1 + P_ALIQOPERACAO / 100) /
                             ((100 - P_ALIQINTERNADEST - P_ALIQFCP) / 100);
         V_VLICMSPART     := GREATEST(V_VLBASEPARTDEST - P_VLPRODUTO, 0);
      else
         V_VLBASEPARTDEST := P_VLPRODUTO;
         V_VLICMSPART     := 0;
      end if;
   
      -- A ALIQUOTA DE ICMS É ZERADA SE O CLIENTE FOR ISENTO
      if P_CLIENTEISENTO = 'S'
      then
         P_ALIQOPERACAO := 0;
         P_PERCBASERED  := 0;
      end if;
   
      -- VALIDAR SE DEVERÁ REDUZIR A BASE DE CALCULO DE ORIGEM
      begin
         V_REDUZIRBASEDEST := not
                               PARAMFILIAL.OBTERCOMOVARCHAR2('DESCONSREDBASEPARTDEST', P_CODFILIAL) = 'S';
      exception
         when others then
            V_REDUZIRBASEDEST := true;
      end;
   
      if not V_REDUZIRBASEDEST
      then
         P_PERCBASERED := 0;
      end if;
   
      if P_PERCBASERED > 0
      then
         V_VLBASEPARTDEST := V_VLBASEPARTDEST * P_PERCBASERED / 100;
      end if;
   
      V_VLFCPPART      := V_VLBASEPARTDEST * P_ALIQFCP / 100;
      V_VLICMSPARTDEST := V_VLBASEPARTDEST * P_ALIQINTERNADEST / 100;
      V_VLICMSPARTREM  := V_VLBASEPARTDEST * P_ALIQINTERESTADUAL / 100;
      V_ANOOPER        := EXTRACT(year from P_DATAOPER);
      V_PERCPROVPART := case
                           when V_ANOOPER = 2016 then
                            40
                           when V_ANOOPER = 2017 then
                            60
                           when V_ANOOPER = 2018 then
                            80
                           when V_ANOOPER >= 2019 then
                            100
                           else
                            0
                        end;
      V_VLICMSDIFALIQ  := GREATEST(V_VLICMSPARTDEST - V_VLICMSPARTREM, 0);
      V_VLICMSPARTDEST := V_VLICMSDIFALIQ * V_PERCPROVPART / 100;
      V_VLICMSPARTREM  := V_VLICMSDIFALIQ - V_VLICMSPARTDEST;
   
      if NVL(P_ALIQOPERACAO, 0) <= 0
      then
         V_VLICMSPARTREM := 0;
      end if;
   
      select XMLELEMENT("retorno"
                        ,XMLELEMENT("aliqinterestadual"
                                   ,RTRIM(RTRIM(LTRIM(TO_CHAR(P_ALIQINTERESTADUAL
                                                            ,'FM9999999999999999D999999'
                                                            ,'nls_numeric_characters=,.'))
                                              ,0)
                                        ,','))
                        ,XMLELEMENT("aliqinternadest"
                                   ,RTRIM(RTRIM(LTRIM(TO_CHAR(P_ALIQINTERNADEST
                                                            ,'FM9999999999999999D999999'
                                                            ,'nls_numeric_characters=,.'))
                                              ,0)
                                        ,','))
                        ,XMLELEMENT("aliqfcp"
                                   ,RTRIM(RTRIM(LTRIM(TO_CHAR(P_ALIQFCP
                                                            ,'FM9999999999999999D999999'
                                                            ,'nls_numeric_characters=,.'))
                                              ,0)
                                        ,','))
                        ,XMLELEMENT("percbasered"
                                   ,RTRIM(RTRIM(LTRIM(TO_CHAR(P_PERCBASERED
                                                            ,'FM9999999999999999D999999'
                                                            ,'nls_numeric_characters=,.'))
                                              ,0)
                                        ,','))
                        ,XMLELEMENT("vlbasepartdest"
                                   ,RTRIM(RTRIM(LTRIM(TO_CHAR(V_VLBASEPARTDEST
                                                            ,'FM9999999999999999D999999'
                                                            ,'nls_numeric_characters=,.'))
                                              ,0)
                                        ,','))
                        ,XMLELEMENT("vlicmspartrem"
                                   ,RTRIM(RTRIM(LTRIM(TO_CHAR(V_VLICMSPARTREM
                                                            ,'FM9999999999999999D999999'
                                                            ,'nls_numeric_characters=,.'))
                                              ,0)
                                        ,','))
                        ,XMLELEMENT("vlfcppart"
                                   ,RTRIM(RTRIM(LTRIM(TO_CHAR(V_VLFCPPART
                                                            ,'FM9999999999999999D999999'
                                                            ,'nls_numeric_characters=,.'))
                                              ,0)
                                        ,','))
                        ,XMLELEMENT("vlicmspartdest"
                                   ,RTRIM(RTRIM(LTRIM(TO_CHAR(V_VLICMSPARTDEST
                                                            ,'FM9999999999999999D999999'
                                                            ,'nls_numeric_characters=,.'))
                                              ,0)
                                        ,','))
                        ,XMLELEMENT("percprovpart"
                                   ,RTRIM(RTRIM(LTRIM(TO_CHAR(V_PERCPROVPART
                                                            ,'FM9999999999999999D999999'
                                                            ,'nls_numeric_characters=,.'))
                                              ,0)
                                        ,','))
                        ,XMLELEMENT("vlicmsdifaliq"
                                   ,RTRIM(RTRIM(LTRIM(TO_CHAR(V_VLICMSDIFALIQ
                                                            ,'FM9999999999999999D999999'
                                                            ,'nls_numeric_characters=,.'))
                                              ,0)
                                        ,','))
                        ,XMLELEMENT("vlicmspart"
                                   ,RTRIM(RTRIM(LTRIM(TO_CHAR(V_VLICMSPART
                                                            ,'FM9999999999999999D999999'
                                                            ,'nls_numeric_characters=,.'))
                                              ,0)
                                        ,',')))
        into V_XMLRETORNO
        from DUAL;
   
      P_RETORNO := V_XMLRETORNO.GETSTRINGVAL();
   
   end;

   procedure F10_OBTER_PARTILHA_ICMS(P_CODFILIAL    in varchar2
                                    ,P_CODCLI       in number
                                    ,P_UFOPERCONSUM in varchar2
                                    ,P_DATAOPER     in date
                                    ,P_VLPRODUTO    in number
                                    ,P_CODTRIBUT    in number
                                    ,P_CODPROD      in number
                                    ,P_RETORNO      out varchar2
                                    ,P_CODMSG       out number
                                    ,P_MSG          out varchar2) is
      V_TRIBUT_NAO_LOCALIZADA       exception;
      V_TRIBPARTILHA_NAO_LOCALIZADA exception;
   
      V_CODCLIFILIAL      PCFILIAL.CODCLI%type;
      V_UFCLIENTE         PCCLIENT.ESTENT%type;
      V_CONSUMIDOR        PCCLIENT.CONSUMIDORFINAL%type;
      V_CONTRIBUINTE      PCCLIENT.CONTRIBUINTE%type;
      V_IECLIENTE         PCCLIENT.IEENT%type;
      V_UFFILIAL          PCFILIAL.UF%type;
      V_TIPOEMPRESA       PCCLIENT.TIPOEMPRESA%type;
      V_CLIENTEISENTOICMS PCCLIENT.ISENTOICMS%type;
      V_PESSOAFISICA      PCCLIENT.TIPOFJ%type;
      V_PERCBASERED       PCTRIBUT.PERCBASERED%type;
      V_IMPORTADO         PCPRODUT.IMPORTADO%type;
      V_SIMPLESNACIONAL   PCCLIENT.SIMPLESNACIONAL%type;
      
      V_CLIENTEFONTEST    PCCLIENT.CLIENTEFONTEST%type;
      V_ISENTOST          VARCHAR2(1);
      V_EXCECAO           BOOLEAN;
   
      -- VALORES DA PARTILHA
      V_ALIQINTERESTADUAL PCTRIBUT.CODICM%type;
      V_ALIQOPERACAO      PCTRIBUT.CODICM%type;
      V_ALIQINTERNADEST   PCTRIBUT.CODICM%type;
      V_ALIQFCP           PCTRIBUT.PERACRESCIMOFUNCEP%type;
   
      procedure F10_BUSCAR_ALIQUOTAS(P_TIPOEMPRESACLI    in varchar2
                                    ,P_PESSOAFISICA      in varchar2
                                    ,P_CONSUMIDORFINAL   in varchar2
                                    ,P_UFCLIENTE         in varchar2
                                    ,P_UFFILIAL          in varchar2
                                    ,P_CODST             in number
                                    ,P_PRODIMPORTADO     in varchar2
                                    ,P_ALIQOPERACAO      out number
                                    ,P_ALIQINTERESTADUAL out number
                                    ,P_ALIQINTERNADEST   out number
                                    ,P_ALIQFCP           out number
                                    ,P_PERCBASERED       out number) is
      
         V_UTILIZAPERCBASEREDPF  PCTRIBUT.UTILIZAPERCBASEREDPF%type;
         V_ISENTAICMSUFDEST      PCTRIBUT.ISENTAICMSUFDEST%type;
         V_PERCBASEREDCONSUMIDOR PCTRIBUT.PERCBASEREDCONSUMIDOR%type;
      begin
         PKG_DEBUGGING_FWPC.LOG_MSG('VALIDANDO OS DADOS DA TRIBUTAÇÃO');
      
         begin
            select DECODE(P_TIPOEMPRESACLI
                         ,'PR'
                         ,NVL(T.CODICMPRODRURAL, NVL(T.CODICMPF, NVL(T.CODICM, 0)))
                         ,DECODE(P_PESSOAFISICA
                                ,'S'
                                ,NVL(T.CODICMPF, NVL(T.CODICM, 0))
                                ,NVL(T.CODICM, 0))) as ALIQICMS
                  ,T.PERCBASERED
                  ,T.PERCBASEREDCONSUMIDOR
                  ,T.UTILIZAPERCBASEREDPF
              into P_ALIQOPERACAO
                  ,P_PERCBASERED
                  ,V_PERCBASEREDCONSUMIDOR
                  ,V_UTILIZAPERCBASEREDPF
              from PCTRIBUT T
             where T.CODST = P_CODST;
         exception
            when NO_DATA_FOUND then
               raise V_TRIBUT_NAO_LOCALIZADA;
         end;
      
         P_ALIQOPERACAO      := NVL(P_ALIQOPERACAO, 0);
         P_ALIQINTERESTADUAL := P_ALIQOPERACAO;
         if P_ALIQINTERESTADUAL <= 0
         then
            begin
               P_ALIQINTERESTADUAL := NVL(PARAMFILIAL.OBTERCOMONUMBER('ALIQINTERORIGPART'
                                                                     ,P_CODFILIAL)
                                         ,12);
               if P_UFFILIAL in ('MG', 'RJ', 'SP', 'PR', 'RS', 'SC')
                  and P_UFCLIENTE in ('MG', 'RJ', 'SP', 'PR', 'RS', 'SC')
                  and P_ALIQINTERESTADUAL > 4
               then
                  P_ALIQINTERESTADUAL := 12;
               end if;
            exception
               when others then
                  null;
            end;
         
            if P_PRODIMPORTADO in ('S', 'D')
            then
               begin
                  P_ALIQINTERESTADUAL := NVL(PARAMFILIAL.OBTERCOMONUMBER('ALIQINTERORIGIMPPART'
                                                                        ,P_CODFILIAL)
                                            ,4);
               exception
                  when others then
                     P_ALIQINTERESTADUAL := 4;
               end;
            end if;
         end if;
      
         -- Validar qual percentual de redução será utilizada
         if (P_CONSUMIDORFINAL = 'S')
            and (V_PERCBASEREDCONSUMIDOR is not null)
         then
            if (P_PESSOAFISICA = 'S')
               and (PARAMFILIAL.OBTERCOMOVARCHAR2('CON_UTILIZAPERCBASEREDPF') = 'S')
               and (V_UTILIZAPERCBASEREDPF = 'S')
            then
               P_PERCBASERED := V_PERCBASEREDCONSUMIDOR;
            elsif (not P_PESSOAFISICA = 'S')
            then
               P_PERCBASERED := V_PERCBASEREDCONSUMIDOR;
            else
               P_PERCBASERED := 0;
            end if;
         end if;
      
         PKG_DEBUGGING_FWPC.LOG_MSG('VALIDANDO OS DADOS DA TRIBUTAÇÃO PARTILHA');
         begin
            select NVL(T.CODICM, 0) as ALIQICMSINTERNADEST
                  ,NVL(T.PERACRESCIMOFUNCEP, 0) as ALIQFCP
                  ,T.ISENTAICMSUFDEST
              into P_ALIQINTERNADEST
                  ,P_ALIQFCP
                  ,V_ISENTAICMSUFDEST
              from PCTRIBUTPARTILHA P
                  ,PCTRIBUT         T
             where P.CODSTPARTILHA = T.CODST
               and P.CODST = P_CODST
               and P.UF = P_UFCLIENTE;
         exception
            when NO_DATA_FOUND then
               raise V_TRIBPARTILHA_NAO_LOCALIZADA;
         end;
      
         P_ALIQINTERESTADUAL := NVL(P_ALIQINTERESTADUAL, 0);
         P_ALIQINTERNADEST   := NVL(P_ALIQINTERNADEST, 0);
         P_ALIQFCP           := NVL(P_ALIQFCP, 0);
         P_PERCBASERED       := NVL(P_PERCBASERED, 0);
      
         -- Se figura destino for isento de ICMS, zera as aliquotas de destino
         if V_ISENTAICMSUFDEST = 'S'
         then
            P_ALIQINTERNADEST := 0;
            P_ALIQFCP         := 0;
            P_PERCBASERED     := 0;
         end if;
      end;
   
   begin
      PKG_DEBUGGING_FWPC.LOG_MSG('VALIDANDO PARAMETROS DE ENTRADA');
      begin
         select UF
               ,CODCLI
           into V_UFFILIAL
               ,V_CODCLIFILIAL
           from PCFILIAL
          where CODIGO = NVL(P_CODFILIAL, 'XXX');
      exception
         when NO_DATA_FOUND then
            P_CODMSG := 1;
            P_MSG    := 'A filial da operação não foi informada ou é inexistente';
            PKG_DEBUGGING_FWPC.LOG_RETORNO(P_CODMSG, P_MSG);
            return;
      end;
   
      begin
         select SIMPLESNACIONAL into V_SIMPLESNACIONAL from PCCLIENT where CODCLI = V_CODCLIFILIAL;
         if V_SIMPLESNACIONAL = 'S'
         then
            P_CODMSG := 11;
            P_MSG    := 'A filial está definida como Simples Nacional e não partilha ICMS';
            PKG_DEBUGGING_FWPC.LOG_RETORNO(P_CODMSG, P_MSG);
            return;
         end if;
      exception
         when NO_DATA_FOUND then
            P_CODMSG := 12;
            P_MSG    := 'O cliente que representa a filial não foi definido ou é inexistente';
            PKG_DEBUGGING_FWPC.LOG_RETORNO(P_CODMSG, P_MSG);
            return;
      end;
   
      if P_CODCLI > 0
      then
         begin
            select C.ESTENT as UF
                  ,NVL(C.CONSUMIDORFINAL, 'N') as CONSUMIDORFINAL
                  ,NVL(C.CONTRIBUINTE, 'N') as CONTRIBUINTE
                  ,C.TIPOEMPRESA
                  ,C.ISENTOICMS
                  ,DECODE(FERRAMENTAS.VERIFICAR_FJ(C.CODCLI), 'PESSOA FISICA', 'S', 'N') as PF
                  ,GERA_HISTORICO.SOMENTE_NUMERO(C.IEENT) as IE
              into V_UFCLIENTE
                  ,V_CONSUMIDOR
                  ,V_CONTRIBUINTE
                  ,V_TIPOEMPRESA
                  ,V_CLIENTEISENTOICMS
                  ,V_PESSOAFISICA
                  ,V_IECLIENTE
              from PCCLIENT C
             where CODCLI = P_CODCLI;
         
            if V_CONSUMIDOR = 'N'
               or V_CONTRIBUINTE = 'S'
            then
               P_CODMSG := 5;
               P_MSG    := 'O cliente informado não é consumidor final ou é contribuinte do ICMS';
               PKG_DEBUGGING_FWPC.LOG_RETORNO(P_CODMSG, P_MSG);
               return;
            end if;
         exception
            when NO_DATA_FOUND then
               P_CODMSG := 2;
               P_MSG    := 'O cliente informado é inexistente';
               PKG_DEBUGGING_FWPC.LOG_RETORNO(P_CODMSG, P_MSG);
               return;
         end;
      else
         V_UFCLIENTE  := trim(P_UFOPERCONSUM);
         V_CONSUMIDOR := 'S';
         if V_UFCLIENTE is null
         then
            P_CODMSG := 3;
            P_MSG    := 'A UF da operação a consumidor não foi informada';
            PKG_DEBUGGING_FWPC.LOG_RETORNO(P_CODMSG, P_MSG);
            return;
         end if;
      end if;
   
      begin
         select IMPORTADO into V_IMPORTADO from PCPRODUT P where P.CODPROD = P_CODPROD;
      exception
         when NO_DATA_FOUND then
            P_CODMSG := 10;
            P_MSG    := 'O código do produto não foi informado ou é inválido';
            PKG_DEBUGGING_FWPC.LOG_RETORNO(P_CODMSG, P_MSG);
            return;
      end;
   
      if V_UFCLIENTE = V_UFFILIAL
         or V_UFCLIENTE = 'EX'
      then
         P_CODMSG := 4;
         P_MSG    := 'A operação com o cliente não é interestadual';
         PKG_DEBUGGING_FWPC.LOG_RETORNO(P_CODMSG, P_MSG);
         return;
      end if;
   
      if P_DATAOPER is null
      then
         P_CODMSG := 6;
         P_MSG    := 'A data da operação não foi informada';
         PKG_DEBUGGING_FWPC.LOG_RETORNO(P_CODMSG, P_MSG);
         return;
      end if;
      if NVL(P_VLPRODUTO, 0) <= 0
      then
         P_CODMSG := 7;
         P_MSG    := 'O valor do produto deve ser maior que zero';
         PKG_DEBUGGING_FWPC.LOG_RETORNO(P_CODMSG, P_MSG);
         return;
      end if;
   
      begin
         F10_BUSCAR_ALIQUOTAS(V_TIPOEMPRESA
                             ,V_PESSOAFISICA
                             ,V_CONSUMIDOR
                             ,V_UFCLIENTE
                             ,V_UFFILIAL
                             ,P_CODTRIBUT
                             ,V_IMPORTADO
                             ,V_ALIQOPERACAO /*OUT*/
                             ,V_ALIQINTERESTADUAL /*OUT*/
                             ,V_ALIQINTERNADEST /*OUT*/
                             ,V_ALIQFCP /*OUT*/
                             ,V_PERCBASERED /*OUT*/);
      
      exception
         when V_TRIBUT_NAO_LOCALIZADA then
            P_CODMSG := 8;
            P_MSG    := 'A tributação não foi informada ou é inexistente';
            PKG_DEBUGGING_FWPC.LOG_RETORNO(P_CODMSG, P_MSG);
            return;
         when V_TRIBPARTILHA_NAO_LOCALIZADA then
            P_CODMSG := 9;
            P_MSG    := 'Não foi vinculada uma tributação para partilha de ICMS (rotina 514)';
            PKG_DEBUGGING_FWPC.LOG_RETORNO(P_CODMSG, P_MSG);
            return;
      end;
      
      PKG_DEBUGGING_FWPC.LOG_MSG('VERIFICANDO ISENTOS'); 
      V_ISENTOST := 'N';
      IF NVL(P_CODCLI,0) > 0 THEN
         V_ISENTOST := FERRAMENTAS.VERIFICAR_ISENTOST(P_CODCLI, P_CODPROD, P_CODTRIBUT);           	 
      END IF;
   
      PKG_DEBUGGING_FWPC.LOG_MSG('VALIDANDO EXCECAO DE CST');   
      V_EXCECAO := F10_CSTEXCECAO(P_CODTRIBUT, V_PESSOAFISICA, V_ISENTOST, V_CLIENTEFONTEST, V_TIPOEMPRESA);
      IF V_EXCECAO THEN
      	P_CODMSG := 0;
      	P_MSG    := 'Partilha calculada com sucesso'; 
      END IF;
      
      PKG_DEBUGGING_FWPC.LOG_MSG('VALIDANDO EXCECAO DE ANP');
      V_EXCECAO := F10_ANPEXCECAO(P_CODPROD);
      IF V_EXCECAO AND P_DATAOPER >= TO_DATE('01/01/2016','DD/MM/YYYY') THEN
      	P_CODMSG := 0;
      	P_MSG    := 'Partilha calculada com sucesso';
      END IF;
   
      F10_CALCULAR_VALORES(P_CODFILIAL
                          ,P_VLPRODUTO
                          ,P_DATAOPER
                          ,V_CLIENTEISENTOICMS
                          ,V_ALIQOPERACAO
                          ,V_ALIQINTERESTADUAL
                          ,V_ALIQINTERNADEST
                          ,V_ALIQFCP
                          ,V_PERCBASERED
                          ,P_RETORNO);
      P_CODMSG := 0;
      P_MSG    := 'Partilha calculada com sucesso';
   end;


 begin 

F10_OBTER_PARTILHA_ICMS(:CODFILIAL,:CODCLI,:UFOPERCONSUM,:DATAOPER,:VLPRODUTO,:CODTRIBUT,:CODPROD,:RETORNO,:CODMSG,:MSG);

 end;
CODFILIAL = '2'
CODCLI = 101003
UFOPERCONSUM = <NULL>
DATAOPER = '02/11/2023'
VLPRODUTO = 7,07
CODTRIBUT = 2
CODPROD = 112562
RETORNO = <NULL>
CODMSG = 5
MSG = 'O'
----------------------------------
Timestamp: 10:09:23.599
begin
  :RESULT := FISCAL.GET_DADOS_TRIBUTACAO_IPI(:P_CODCLI, :P_CODPROD, :P_CODFILIAL, :P_DATAOPERACAO, :P_CST_ENTRADA, :P_CST_SAIDA,
 :P_GERABASEALIQZERO, :P_MSG, :P_CODFISCAL, :P_TIPO_VENDA, :P_TIPO_ENTRADA, :P_CODIGO_OPERACAO, :P_CODENQENTRADA, 
:P_CODENQSAIDA);
end;
RESULT = 'N'
P_CODCLI = 101003
P_CODPROD = 112562
P_CODFILIAL = '2'
P_DATAOPERACAO = '02/11/2023'
P_CST_ENTRADA = <NULL>
P_CST_SAIDA = <NULL>
P_GERABASEALIQZERO = <NULL>
P_MSG = 'FIGURA TRIBUTÁRIA DO IPI INEXISTENTE OU NÃO VINCULADA!'
P_CODFISCAL = 5949
P_TIPO_VENDA = 1
P_TIPO_ENTRADA = <NULL>
P_CODIGO_OPERACAO = 'SR'
P_CODENQENTRADA = <NULL>
P_CODENQSAIDA = <NULL>
----------------------------------
Timestamp: 10:09:23.778
SELECT PCCONTROI.CODROTINA                           
       , PCCONTROI.CODCONTROLE                         
       , PCROTINAI.DESCRICAO                           
       , NVL(PCCONTROI.ACESSO,'N') ACESSO            
       , PCCONTROI.CODUSUARIO 
    FROM PCCONTROI                                     
       , PCROTINAI                                     
   WHERE PCCONTROI.CODROTINA   = :CODROTINA            
     AND PCCONTROI.CODUSUARIO  = :MATRICULA            
     AND PCCONTROI.CODROTINA   = PCROTINAI.CODROTINA   
     AND PCCONTROI.CODCONTROLE = PCROTINAI.CODCONTROLE 
   ORDER                                               
      BY PCCONTROI.CODROTINA                           
       , PCCONTROI.CODCONTROLE
CODROTINA = 1322
MATRICULA = 1261
----------------------------------
Timestamp: 10:09:23.831
SELECT FERRAMENTAS.VERIFICAR_TIPOST(:CODCLI, :CODST) TIPOST FROM DUAL
CODCLI = '101003'
CODST = '2'
----------------------------------
Timestamp: 10:09:23.879
SELECT FERRAMENTAS.VERIFICAR_TIPOST(:CODCLI, :CODST) TIPOST FROM DUAL
CODCLI = '101003'
CODST = '2'
----------------------------------
Timestamp: 10:09:23.918
SELECT NVL(PCTRIBUT.IVA,0) AS IVA 
      , NVL(PCTRIBUT.PAUTA,0) AS PAUTA  
      , NVL(PCTRIBUT.ALIQICMS1,0) AS ALIQICMS1                                              
      , NVL(PCTRIBUT.ALIQICMS2,0) AS ALIQICMS2                                                                   
      , CASE WHEN NVL(PCTRIBUT.PERCBASEREDST,0) = 0                                            
             THEN 100                                                                          
             ELSE PCTRIBUT.PERCBASEREDST                                                       
        END PERCBASEREDST                                                                      
      , NVL(PCTRIBUT.PERPAUTAICMS, 0) PERPAUTAICMS                                             
      , NVL(PCTRIBUT.USAVALORULTENTBASEST,'S') USAVALORULTENTBASEST                          
      , NVL(PCTRIBUT.PERPAUTAICMSINTER, 0) PERPAUTAICMSINTER,                                  
       CASE WHEN NVL(PCTRIBUT.PERCBASERED,0) = 0                                              
             THEN 100                                                                         
             ELSE PCTRIBUT.PERCBASERED                                                        
        END PERBASERED,                                                                       
       CASE WHEN NVL(PCTRIBUT.PERBASEREDNRPA,0) = 0                                           
             THEN 100                                                                         
             ELSE PCTRIBUT.PERBASEREDNRPA                                                     
        END PERBASEREDNRPA,                                                                   
       CASE WHEN NVL(PCTRIBUT.PERCBASEREDCONSUMIDOR,0) = 0                                    
             THEN 100                                                                         
             ELSE PCTRIBUT.PERCBASEREDCONSUMIDOR                                              
        END PERCBASEREDCONSUMIDOR,                                                            
      NVL(PCTRIBUT.PERPAUTAICMS, 0) PERPAUTAICMS,
      PCTRIBUT.CODICM, PCTRIBUT.CODICMPF, PCTRIBUT.SITTRIBUT,
      PCTRIBUT.CODFISCALSREXT, PCTRIBUT.CODFISCALSRESTSR,
      PCTRIBUT.CODFISCALSRINTE, 
      NVL(PCTRIBUT.PERCDIFALIQUOTAS,0) PERCDIFALIQUOTAS,
      NVL(PCTRIBUT.PERPAUTAICMSINTER, 0) PERPAUTAICMSINTER,
      NVL(PCTRIBUT.UTILIZAPERCBASEREDPF,'N') UTILIZAPERCBASEREDPF,
      NVL(PCTRIBUT.PERDIFEREIMENTOICMS,0) PERDIFEREIMENTOICMS, PCTRIBUT.SITTRIBUTPF
   FROM PCTRIBUT                                                                               
  WHERE PCTRIBUT.CODST = :CODST
CODST = 2
----------------------------------
Timestamp: 10:09:24.013
SELECT ROUND(:VALOR,2) VALOR
FROM   DUAL
VALOR = 0
----------------------------------
Timestamp: 10:09:24.048
SELECT NVL(PCEST.NUMTRANSENTULTENT,0) AS NUMTRANSENT_ULT_NF
  FROM PCEST
 WHERE PCEST.CODPROD = :CODPROD
   AND PCEST.CODFILIAL = :CODFILIAL
CODPROD = 112562
CODFILIAL = '2'
----------------------------------
Timestamp: 10:09:24.105
SELECT NVL(PCMOV.PUNIT,0) AS PUNIT_ULT_NF
  FROM PCMOV
 WHERE NUMTRANSENT = :NUMTRANSENT
   AND CODPROD = :CODPROD
   AND CODFILIAL = :CODFILIAL
NUMTRANSENT = 219354
CODPROD = 112562
CODFILIAL = '2'
----------------------------------
Timestamp: 10:10:41.482
SELECT FERRAMENTAS.VERIFICAR_TIPOST(:CODCLI, :CODST) TIPOST FROM DUAL
CODCLI = '101003'
CODST = '2'
----------------------------------
Timestamp: 10:10:41.560
SELECT FERRAMENTAS.VERIFICAR_TIPOST(:CODCLI, :CODST) TIPOST FROM DUAL
CODCLI = '101003'
CODST = '2'
----------------------------------
Timestamp: 10:10:41.626
SELECT NVL(PCTRIBUT.IVA,0) AS IVA 
      , NVL(PCTRIBUT.PAUTA,0) AS PAUTA  
      , NVL(PCTRIBUT.ALIQICMS1,0) AS ALIQICMS1                                              
      , NVL(PCTRIBUT.ALIQICMS2,0) AS ALIQICMS2                                                                   
      , CASE WHEN NVL(PCTRIBUT.PERCBASEREDST,0) = 0                                            
             THEN 100                                                                          
             ELSE PCTRIBUT.PERCBASEREDST                                                       
        END PERCBASEREDST                                                                      
      , NVL(PCTRIBUT.PERPAUTAICMS, 0) PERPAUTAICMS                                             
      , NVL(PCTRIBUT.USAVALORULTENTBASEST,'S') USAVALORULTENTBASEST                          
      , NVL(PCTRIBUT.PERPAUTAICMSINTER, 0) PERPAUTAICMSINTER,                                  
       CASE WHEN NVL(PCTRIBUT.PERCBASERED,0) = 0                                              
             THEN 100                                                                         
             ELSE PCTRIBUT.PERCBASERED                                                        
        END PERBASERED,                                                                       
       CASE WHEN NVL(PCTRIBUT.PERBASEREDNRPA,0) = 0                                           
             THEN 100                                                                         
             ELSE PCTRIBUT.PERBASEREDNRPA                                                     
        END PERBASEREDNRPA,                                                                   
       CASE WHEN NVL(PCTRIBUT.PERCBASEREDCONSUMIDOR,0) = 0                                    
             THEN 100                                                                         
             ELSE PCTRIBUT.PERCBASEREDCONSUMIDOR                                              
        END PERCBASEREDCONSUMIDOR,                                                            
      NVL(PCTRIBUT.PERPAUTAICMS, 0) PERPAUTAICMS,
      PCTRIBUT.CODICM, PCTRIBUT.CODICMPF, PCTRIBUT.SITTRIBUT,
      PCTRIBUT.CODFISCALSREXT, PCTRIBUT.CODFISCALSRESTSR,
      PCTRIBUT.CODFISCALSRINTE, 
      NVL(PCTRIBUT.PERCDIFALIQUOTAS,0) PERCDIFALIQUOTAS,
      NVL(PCTRIBUT.PERPAUTAICMSINTER, 0) PERPAUTAICMSINTER,
      NVL(PCTRIBUT.UTILIZAPERCBASEREDPF,'N') UTILIZAPERCBASEREDPF,
      NVL(PCTRIBUT.PERDIFEREIMENTOICMS,0) PERDIFEREIMENTOICMS, PCTRIBUT.SITTRIBUTPF
   FROM PCTRIBUT                                                                               
  WHERE PCTRIBUT.CODST = :CODST
CODST = 2
----------------------------------
Timestamp: 10:10:41.722
SELECT ROUND(:VALOR,2) VALOR
FROM   DUAL
VALOR = 0
----------------------------------
Timestamp: 10:10:41.772
SELECT FERRAMENTAS.VERIFICAR_FJ(:CODCLI) TIPOFJ FROM DUAL
CODCLI = '101003'
----------------------------------
Timestamp: 10:10:41.820
begin
  :RESULT := FISCAL.GET_DADOS_TRIBUTACAO_IPI(:P_CODCLI, :P_CODPROD, :P_CODFILIAL, :P_DATAOPERACAO, :P_CST_ENTRADA, :P_CST_SAIDA,
 :P_GERABASEALIQZERO, :P_MSG, :P_CODFISCAL, :P_TIPO_VENDA, :P_TIPO_ENTRADA, :P_CODIGO_OPERACAO, :P_CODENQENTRADA, 
:P_CODENQSAIDA);
end;
RESULT = 'N'
P_CODCLI = 101003
P_CODPROD = 112562
P_CODFILIAL = '2'
P_DATAOPERACAO = '02/11/2023'
P_CST_ENTRADA = <NULL>
P_CST_SAIDA = <NULL>
P_GERABASEALIQZERO = <NULL>
P_MSG = 'FIGURA TRIBUTÁRIA DO IPI INEXISTENTE OU NÃO VINCULADA!'
P_CODFISCAL = 5949
P_TIPO_VENDA = 1
P_TIPO_ENTRADA = <NULL>
P_CODIGO_OPERACAO = 'SR'
P_CODENQENTRADA = <NULL>
P_CODENQSAIDA = <NULL>
----------------------------------
Timestamp: 10:10:42.038
SELECT PCCONTROI.CODROTINA                           
       , PCCONTROI.CODCONTROLE                         
       , PCROTINAI.DESCRICAO                           
       , NVL(PCCONTROI.ACESSO,'N') ACESSO            
       , PCCONTROI.CODUSUARIO 
    FROM PCCONTROI                                     
       , PCROTINAI                                     
   WHERE PCCONTROI.CODROTINA   = :CODROTINA            
     AND PCCONTROI.CODUSUARIO  = :MATRICULA            
     AND PCCONTROI.CODROTINA   = PCROTINAI.CODROTINA   
     AND PCCONTROI.CODCONTROLE = PCROTINAI.CODCONTROLE 
   ORDER                                               
      BY PCCONTROI.CODROTINA                           
       , PCCONTROI.CODCONTROLE
CODROTINA = 1322
MATRICULA = 1261
----------------------------------
Timestamp: 10:10:42.108
SELECT PCCLIENT.TIPOFJ
      ,NVL(PCCLIENT.UTILIZAIESIMPLIFICADA, 'N') UTILIZAIESIMPLIFICADA
      ,NVL(PCCLIENT.CONSUMIDORFINAL, 'N') CONSUMIDORFINAL
      ,PCCLIENT.IEENT
      ,NVL(PCCLIENT.CONTRIBUINTE, 'N') CONTRIBUINTE
      ,NVL(PCCONSUM.CONSIDERAISENTOSCOMOPF, 'N') CONSIDERAISENTOSCOMOPF
  FROM PCCLIENT, PCCONSUM
 WHERE PCCLIENT.CODCLI = :CODCLI
CODCLI = 101003
----------------------------------
Timestamp: 10:10:42.184
SELECT PCCLIENT.TIPOFJ
      ,NVL(PCCLIENT.UTILIZAIESIMPLIFICADA, 'N') UTILIZAIESIMPLIFICADA
      ,NVL(PCCLIENT.CONSUMIDORFINAL, 'N') CONSUMIDORFINAL
      ,PCCLIENT.IEENT
      ,NVL(PCCLIENT.CONTRIBUINTE, 'N') CONTRIBUINTE
      ,NVL(PCCONSUM.CONSIDERAISENTOSCOMOPF, 'N') CONSIDERAISENTOSCOMOPF
  FROM PCCLIENT, PCCONSUM
 WHERE PCCLIENT.CODCLI = :CODCLI
CODCLI = 101003
----------------------------------
Timestamp: 10:10:42.247
SELECT PCCLIENT.TIPOFJ
      ,NVL(PCCLIENT.UTILIZAIESIMPLIFICADA, 'N') UTILIZAIESIMPLIFICADA
      ,NVL(PCCLIENT.CONSUMIDORFINAL, 'N') CONSUMIDORFINAL
      ,PCCLIENT.IEENT
      ,NVL(PCCLIENT.CONTRIBUINTE, 'N') CONTRIBUINTE
      ,NVL(PCCONSUM.CONSIDERAISENTOSCOMOPF, 'N') CONSIDERAISENTOSCOMOPF
  FROM PCCLIENT, PCCONSUM
 WHERE PCCLIENT.CODCLI = :CODCLI
CODCLI = 101003
----------------------------------
Timestamp: 10:10:42.323
SELECT NVL(PCEST.NUMTRANSENTULTENT,0) AS NUMTRANSENT_ULT_NF
  FROM PCEST
 WHERE PCEST.CODPROD = :CODPROD
   AND PCEST.CODFILIAL = :CODFILIAL
CODPROD = 112562
CODFILIAL = '2'
----------------------------------
Timestamp: 10:10:42.367
SELECT NVL(PCMOV.PUNIT,0) AS PUNIT_ULT_NF
  FROM PCMOV
 WHERE NUMTRANSENT = :NUMTRANSENT
   AND CODPROD = :CODPROD
   AND CODFILIAL = :CODFILIAL
NUMTRANSENT = 219354
CODPROD = 112562
CODFILIAL = '2'
----------------------------------
Timestamp: 10:10:42.477
SELECT * 
    FROM TABLE(PKG_TRIBUTACAO.CALCULAR_ST(:CODFILIAL, 
                                          :CODFILIALNF, 
                                          :CODFILIALRETIRA, 
                                          :CODCLI, 
                                          :CODPLPAG, 
                                          :CODPROD, 
                                          :CODAUXILIAR, 
                                          :CONDVENDA, 
                                          :VENDAEXPORTACAO, 
                                          :PVENDA, 
                                          :PERCDESCINFOR,
                                          :ITEMTV1BNF,
                                          :VALORDESCPIS_COFINS,
                                          :VALORDESCICMS,
                                          :VALORSUFRAMA,
                                           NULL,
                                          :CALCULAIPI,
                                          :TRANSFERENCIA,
                                          :ORIGEMPED,
                                          :VENDALOCALESTRANGEIRA,
                                          :CODPRECOFIXO,
                                          :TRANSFERENCIAVIRTUAL,
                                          :PTABELASEMIMPOSTO,
                                          :VENDATRIANGULAR,
                                          :ROTINACONSUM,
                                          :CODBNF,
                                          :CODENDENT,
                                          'N',
                                          :TIPODOCUMENTO,
                                          'N',
                                          :CONTAORDEM,
                                          :VLICMSPARTREM
                                          ))
CODFILIAL = '2'
CODFILIALNF = '2'
CODFILIALRETIRA = '2'
CODCLI = 101003
CODPLPAG = 1
CODPROD = 112562
CODAUXILIAR = 0
CONDVENDA = 1
VENDAEXPORTACAO = 'N'
PVENDA = 7,07
PERCDESCINFOR = 0
ITEMTV1BNF = 'N'
VALORDESCPIS_COFINS = 0
VALORDESCICMS = 0
VALORSUFRAMA = 0
CALCULAIPI = 'S'
TRANSFERENCIA = 'N'
ORIGEMPED = 'B'
VENDALOCALESTRANGEIRA = 'N'
CODPRECOFIXO = 0
TRANSFERENCIAVIRTUAL = <NULL>
PTABELASEMIMPOSTO = 0
VENDATRIANGULAR = 'N'
ROTINACONSUM = 'T'
CODBNF = 0
CODENDENT = 0
TIPODOCUMENTO = 'N'
CONTAORDEM = 'N'
VLICMSPARTREM = 0
----------------------------------
Timestamp: 10:10:42.850
BEGIN PKG_DEBUGGING_FWPC.DESATIVARDEBUG(); END;
----------------------------------
Timestamp: 10:10:42.866
declare 
--variaveis output

  FUNCTION F10_ANPEXCECAO(pCODPROD NUMBER) RETURN BOOLEAN
IS 
	QT NUMBER(1);
BEGIN
	PKG_DEBUGGING_FWPC.LOG_MSG('CONSULTANDO EXCEÇÕES DE ANP DO PRODUTO'); 
	SELECT COUNT(*) 
	 INTO QT
	 FROM PCPRODUT
	  WHERE CODPROD = pCODPROD 
	  AND NVL(ANP,0) IN ('820101001', '820101010', '810102001', '810102004', '810102002', '810102003', '810101002', '810101001', 
						 '810101003', '220101003', '220101004', '220101002', '220101001', '220101005', '220101006');	
	  RETURN QT = 0;
END;

FUNCTION F10_CSTEXCECAO(P_CODST NUMBER, P_PESSOAFISICA VARCHAR2, P_ISENTOST VARCHAR2, P_CLIENTEFONTEST VARCHAR2, P_TIPOEMPRESA 
VARCHAR2) RETURN BOOLEAN 
IS
    vssittribut VARCHAR2(3);
    vssittributpf VARCHAR2(3);
    vssittributisentost VARCHAR2(3);
    vssittributsuframa VARCHAR2(3);
    vssittribstfontepf VARCHAR2(3);
    vssittribstfontepj VARCHAR2(3);
    vssittribsimplesnac VARCHAR2(3);
    vncodicmsimplesnac NUMBER(8,4);    
BEGIN
	PKG_DEBUGGING_FWPC.LOG_MSG('CONSULTANDO EXCEÇÕES DE CST'); 
    SELECT TRIB.SITTRIBUTPF,
       NVL(TRIB.SITTRIBUTISENTOST, NVL(TRIB.SITTRIBUT, '000')),
       TRIB.SITTRIBUTSUFRAMA,
       TRIB.SITTRIBSTFONTEPF,
       TRIB.SITTRIBSTFONTEPJ,
       TRIB.CODICMSIMPLESNAC,
       TRIB.SITTRIBUTSIMPLESNAC
       INTO
       vssittribut,
       vssittributisentost,
       vssittributsuframa,
       vssittribstfontepf,
       vssittribstfontepj,
       vncodicmsimplesnac,
       vssittribsimplesnac
          FROM PCTRIBUT TRIB
          WHERE TRIB.CODST = P_CODST;

       IF (P_PESSOAFISICA = 'S') THEN
            vssittribut := vssittributpf;
       END IF;
       
       IF (P_ISENTOST = 'S') THEN
            vssittribut := vssittributisentost;
       END IF;
       
       IF vssittributsuframa IS NOT NULL THEN 
          vssittribut := vssittributsuframa;
       END IF;
   
       IF (P_CLIENTEFONTEST = 'S') THEN
         IF P_PESSOAFISICA = 'S' THEN
          vssittribut := NVL(vssittribstfontepf,vssittribut); 
         ELSE
          vssittribut := NVL(vssittribstfontepj,vssittribut);
         END IF;
       END IF; 
        
       IF (UPPER(TRIM(P_TIPOEMPRESA)) = 'SN') AND
           vncodicmsimplesnac     IS NOT NULL AND 
           vssittribsimplesnac    IS NOT NULL 
       THEN
           vssittribut := vssittribsimplesnac;
       END IF;     
       
       RETURN (vssittribut = 40 OR vssittribut = 41 OR vssittribut = 103 OR vssittribut = 300 OR vssittribut = 400);
END;
  
   procedure F10_CALCULAR_VALORES(P_CODFILIAL         in varchar2
                                 ,P_VLPRODUTO         in number
                                 ,P_DATAOPER          in date
                                 ,P_CLIENTEISENTO     in varchar2
                                 ,P_ALIQOPERACAO      in out number
                                 ,P_ALIQINTERESTADUAL in number
                                 ,P_ALIQINTERNADEST   in number
                                 ,P_ALIQFCP           in number
                                 ,P_PERCBASERED       in out number
                                 ,P_RETORNO           out varchar2) is
      V_VLICMSPARTREM   number(22, 6);
      V_VLBASEPARTDEST  number(22, 6);
      V_VLFCPPART       number(22, 6);
      V_VLICMSPARTDEST  number(22, 6);
      V_PERCPROVPART    number(22, 6);
      V_VLICMSDIFALIQ   number(22, 6);
      V_VLICMSPART      number(22, 6);
      V_ANOOPER         number(4);
      V_XMLRETORNO      XMLTYPE;
      V_AGREGARVLOPER   boolean;
      V_REDUZIRBASEDEST boolean;
   
   begin
      PKG_DEBUGGING_FWPC.LOG_MSG('CALCULANDO PARTILHA DE ICMS');
      V_AGREGARVLOPER := NVL(PARAMFILIAL.OBTERCOMOVARCHAR2('ACRESCICMSPARTILHAPRECO', P_CODFILIAL)
                            ,'N') = 'S';
   
      if V_AGREGARVLOPER
      then
         V_VLBASEPARTDEST := P_VLPRODUTO / (1 + P_ALIQOPERACAO / 100) /
                             ((100 - P_ALIQINTERNADEST - P_ALIQFCP) / 100);
         V_VLICMSPART     := GREATEST(V_VLBASEPARTDEST - P_VLPRODUTO, 0);
      else
         V_VLBASEPARTDEST := P_VLPRODUTO;
         V_VLICMSPART     := 0;
      end if;
   
      -- A ALIQUOTA DE ICMS É ZERADA SE O CLIENTE FOR ISENTO
      if P_CLIENTEISENTO = 'S'
      then
         P_ALIQOPERACAO := 0;
         P_PERCBASERED  := 0;
      end if;
   
      -- VALIDAR SE DEVERÁ REDUZIR A BASE DE CALCULO DE ORIGEM
      begin
         V_REDUZIRBASEDEST := not
                               PARAMFILIAL.OBTERCOMOVARCHAR2('DESCONSREDBASEPARTDEST', P_CODFILIAL) = 'S';
      exception
         when others then
            V_REDUZIRBASEDEST := true;
      end;
   
      if not V_REDUZIRBASEDEST
      then
         P_PERCBASERED := 0;
      end if;
   
      if P_PERCBASERED > 0
      then
         V_VLBASEPARTDEST := V_VLBASEPARTDEST * P_PERCBASERED / 100;
      end if;
   
      V_VLFCPPART      := V_VLBASEPARTDEST * P_ALIQFCP / 100;
      V_VLICMSPARTDEST := V_VLBASEPARTDEST * P_ALIQINTERNADEST / 100;
      V_VLICMSPARTREM  := V_VLBASEPARTDEST * P_ALIQINTERESTADUAL / 100;
      V_ANOOPER        := EXTRACT(year from P_DATAOPER);
      V_PERCPROVPART := case
                           when V_ANOOPER = 2016 then
                            40
                           when V_ANOOPER = 2017 then
                            60
                           when V_ANOOPER = 2018 then
                            80
                           when V_ANOOPER >= 2019 then
                            100
                           else
                            0
                        end;
      V_VLICMSDIFALIQ  := GREATEST(V_VLICMSPARTDEST - V_VLICMSPARTREM, 0);
      V_VLICMSPARTDEST := V_VLICMSDIFALIQ * V_PERCPROVPART / 100;
      V_VLICMSPARTREM  := V_VLICMSDIFALIQ - V_VLICMSPARTDEST;
   
      if NVL(P_ALIQOPERACAO, 0) <= 0
      then
         V_VLICMSPARTREM := 0;
      end if;
   
      select XMLELEMENT("retorno"
                        ,XMLELEMENT("aliqinterestadual"
                                   ,RTRIM(RTRIM(LTRIM(TO_CHAR(P_ALIQINTERESTADUAL
                                                            ,'FM9999999999999999D999999'
                                                            ,'nls_numeric_characters=,.'))
                                              ,0)
                                        ,','))
                        ,XMLELEMENT("aliqinternadest"
                                   ,RTRIM(RTRIM(LTRIM(TO_CHAR(P_ALIQINTERNADEST
                                                            ,'FM9999999999999999D999999'
                                                            ,'nls_numeric_characters=,.'))
                                              ,0)
                                        ,','))
                        ,XMLELEMENT("aliqfcp"
                                   ,RTRIM(RTRIM(LTRIM(TO_CHAR(P_ALIQFCP
                                                            ,'FM9999999999999999D999999'
                                                            ,'nls_numeric_characters=,.'))
                                              ,0)
                                        ,','))
                        ,XMLELEMENT("percbasered"
                                   ,RTRIM(RTRIM(LTRIM(TO_CHAR(P_PERCBASERED
                                                            ,'FM9999999999999999D999999'
                                                            ,'nls_numeric_characters=,.'))
                                              ,0)
                                        ,','))
                        ,XMLELEMENT("vlbasepartdest"
                                   ,RTRIM(RTRIM(LTRIM(TO_CHAR(V_VLBASEPARTDEST
                                                            ,'FM9999999999999999D999999'
                                                            ,'nls_numeric_characters=,.'))
                                              ,0)
                                        ,','))
                        ,XMLELEMENT("vlicmspartrem"
                                   ,RTRIM(RTRIM(LTRIM(TO_CHAR(V_VLICMSPARTREM
                                                            ,'FM9999999999999999D999999'
                                                            ,'nls_numeric_characters=,.'))
                                              ,0)
                                        ,','))
                        ,XMLELEMENT("vlfcppart"
                                   ,RTRIM(RTRIM(LTRIM(TO_CHAR(V_VLFCPPART
                                                            ,'FM9999999999999999D999999'
                                                            ,'nls_numeric_characters=,.'))
                                              ,0)
                                        ,','))
                        ,XMLELEMENT("vlicmspartdest"
                                   ,RTRIM(RTRIM(LTRIM(TO_CHAR(V_VLICMSPARTDEST
                                                            ,'FM9999999999999999D999999'
                                                            ,'nls_numeric_characters=,.'))
                                              ,0)
                                        ,','))
                        ,XMLELEMENT("percprovpart"
                                   ,RTRIM(RTRIM(LTRIM(TO_CHAR(V_PERCPROVPART
                                                            ,'FM9999999999999999D999999'
                                                            ,'nls_numeric_characters=,.'))
                                              ,0)
                                        ,','))
                        ,XMLELEMENT("vlicmsdifaliq"
                                   ,RTRIM(RTRIM(LTRIM(TO_CHAR(V_VLICMSDIFALIQ
                                                            ,'FM9999999999999999D999999'
                                                            ,'nls_numeric_characters=,.'))
                                              ,0)
                                        ,','))
                        ,XMLELEMENT("vlicmspart"
                                   ,RTRIM(RTRIM(LTRIM(TO_CHAR(V_VLICMSPART
                                                            ,'FM9999999999999999D999999'
                                                            ,'nls_numeric_characters=,.'))
                                              ,0)
                                        ,',')))
        into V_XMLRETORNO
        from DUAL;
   
      P_RETORNO := V_XMLRETORNO.GETSTRINGVAL();
   
   end;

   procedure F10_OBTER_PARTILHA_ICMS(P_CODFILIAL    in varchar2
                                    ,P_CODCLI       in number
                                    ,P_UFOPERCONSUM in varchar2
                                    ,P_DATAOPER     in date
                                    ,P_VLPRODUTO    in number
                                    ,P_CODTRIBUT    in number
                                    ,P_CODPROD      in number
                                    ,P_RETORNO      out varchar2
                                    ,P_CODMSG       out number
                                    ,P_MSG          out varchar2) is
      V_TRIBUT_NAO_LOCALIZADA       exception;
      V_TRIBPARTILHA_NAO_LOCALIZADA exception;
   
      V_CODCLIFILIAL      PCFILIAL.CODCLI%type;
      V_UFCLIENTE         PCCLIENT.ESTENT%type;
      V_CONSUMIDOR        PCCLIENT.CONSUMIDORFINAL%type;
      V_CONTRIBUINTE      PCCLIENT.CONTRIBUINTE%type;
      V_IECLIENTE         PCCLIENT.IEENT%type;
      V_UFFILIAL          PCFILIAL.UF%type;
      V_TIPOEMPRESA       PCCLIENT.TIPOEMPRESA%type;
      V_CLIENTEISENTOICMS PCCLIENT.ISENTOICMS%type;
      V_PESSOAFISICA      PCCLIENT.TIPOFJ%type;
      V_PERCBASERED       PCTRIBUT.PERCBASERED%type;
      V_IMPORTADO         PCPRODUT.IMPORTADO%type;
      V_SIMPLESNACIONAL   PCCLIENT.SIMPLESNACIONAL%type;
      
      V_CLIENTEFONTEST    PCCLIENT.CLIENTEFONTEST%type;
      V_ISENTOST          VARCHAR2(1);
      V_EXCECAO           BOOLEAN;
   
      -- VALORES DA PARTILHA
      V_ALIQINTERESTADUAL PCTRIBUT.CODICM%type;
      V_ALIQOPERACAO      PCTRIBUT.CODICM%type;
      V_ALIQINTERNADEST   PCTRIBUT.CODICM%type;
      V_ALIQFCP           PCTRIBUT.PERACRESCIMOFUNCEP%type;
   
      procedure F10_BUSCAR_ALIQUOTAS(P_TIPOEMPRESACLI    in varchar2
                                    ,P_PESSOAFISICA      in varchar2
                                    ,P_CONSUMIDORFINAL   in varchar2
                                    ,P_UFCLIENTE         in varchar2
                                    ,P_UFFILIAL          in varchar2
                                    ,P_CODST             in number
                                    ,P_PRODIMPORTADO     in varchar2
                                    ,P_ALIQOPERACAO      out number
                                    ,P_ALIQINTERESTADUAL out number
                                    ,P_ALIQINTERNADEST   out number
                                    ,P_ALIQFCP           out number
                                    ,P_PERCBASERED       out number) is
      
         V_UTILIZAPERCBASEREDPF  PCTRIBUT.UTILIZAPERCBASEREDPF%type;
         V_ISENTAICMSUFDEST      PCTRIBUT.ISENTAICMSUFDEST%type;
         V_PERCBASEREDCONSUMIDOR PCTRIBUT.PERCBASEREDCONSUMIDOR%type;
      begin
         PKG_DEBUGGING_FWPC.LOG_MSG('VALIDANDO OS DADOS DA TRIBUTAÇÃO');
      
         begin
            select DECODE(P_TIPOEMPRESACLI
                         ,'PR'
                         ,NVL(T.CODICMPRODRURAL, NVL(T.CODICMPF, NVL(T.CODICM, 0)))
                         ,DECODE(P_PESSOAFISICA
                                ,'S'
                                ,NVL(T.CODICMPF, NVL(T.CODICM, 0))
                                ,NVL(T.CODICM, 0))) as ALIQICMS
                  ,T.PERCBASERED
                  ,T.PERCBASEREDCONSUMIDOR
                  ,T.UTILIZAPERCBASEREDPF
              into P_ALIQOPERACAO
                  ,P_PERCBASERED
                  ,V_PERCBASEREDCONSUMIDOR
                  ,V_UTILIZAPERCBASEREDPF
              from PCTRIBUT T
             where T.CODST = P_CODST;
         exception
            when NO_DATA_FOUND then
               raise V_TRIBUT_NAO_LOCALIZADA;
         end;
      
         P_ALIQOPERACAO      := NVL(P_ALIQOPERACAO, 0);
         P_ALIQINTERESTADUAL := P_ALIQOPERACAO;
         if P_ALIQINTERESTADUAL <= 0
         then
            begin
               P_ALIQINTERESTADUAL := NVL(PARAMFILIAL.OBTERCOMONUMBER('ALIQINTERORIGPART'
                                                                     ,P_CODFILIAL)
                                         ,12);
               if P_UFFILIAL in ('MG', 'RJ', 'SP', 'PR', 'RS', 'SC')
                  and P_UFCLIENTE in ('MG', 'RJ', 'SP', 'PR', 'RS', 'SC')
                  and P_ALIQINTERESTADUAL > 4
               then
                  P_ALIQINTERESTADUAL := 12;
               end if;
            exception
               when others then
                  null;
            end;
         
            if P_PRODIMPORTADO in ('S', 'D')
            then
               begin
                  P_ALIQINTERESTADUAL := NVL(PARAMFILIAL.OBTERCOMONUMBER('ALIQINTERORIGIMPPART'
                                                                        ,P_CODFILIAL)
                                            ,4);
               exception
                  when others then
                     P_ALIQINTERESTADUAL := 4;
               end;
            end if;
         end if;
      
         -- Validar qual percentual de redução será utilizada
         if (P_CONSUMIDORFINAL = 'S')
            and (V_PERCBASEREDCONSUMIDOR is not null)
         then
            if (P_PESSOAFISICA = 'S')
               and (PARAMFILIAL.OBTERCOMOVARCHAR2('CON_UTILIZAPERCBASEREDPF') = 'S')
               and (V_UTILIZAPERCBASEREDPF = 'S')
            then
               P_PERCBASERED := V_PERCBASEREDCONSUMIDOR;
            elsif (not P_PESSOAFISICA = 'S')
            then
               P_PERCBASERED := V_PERCBASEREDCONSUMIDOR;
            else
               P_PERCBASERED := 0;
            end if;
         end if;
      
         PKG_DEBUGGING_FWPC.LOG_MSG('VALIDANDO OS DADOS DA TRIBUTAÇÃO PARTILHA');
         begin
            select NVL(T.CODICM, 0) as ALIQICMSINTERNADEST
                  ,NVL(T.PERACRESCIMOFUNCEP, 0) as ALIQFCP
                  ,T.ISENTAICMSUFDEST
              into P_ALIQINTERNADEST
                  ,P_ALIQFCP
                  ,V_ISENTAICMSUFDEST
              from PCTRIBUTPARTILHA P
                  ,PCTRIBUT         T
             where P.CODSTPARTILHA = T.CODST
               and P.CODST = P_CODST
               and P.UF = P_UFCLIENTE;
         exception
            when NO_DATA_FOUND then
               raise V_TRIBPARTILHA_NAO_LOCALIZADA;
         end;
      
         P_ALIQINTERESTADUAL := NVL(P_ALIQINTERESTADUAL, 0);
         P_ALIQINTERNADEST   := NVL(P_ALIQINTERNADEST, 0);
         P_ALIQFCP           := NVL(P_ALIQFCP, 0);
         P_PERCBASERED       := NVL(P_PERCBASERED, 0);
      
         -- Se figura destino for isento de ICMS, zera as aliquotas de destino
         if V_ISENTAICMSUFDEST = 'S'
         then
            P_ALIQINTERNADEST := 0;
            P_ALIQFCP         := 0;
            P_PERCBASERED     := 0;
         end if;
      end;
   
   begin
      PKG_DEBUGGING_FWPC.LOG_MSG('VALIDANDO PARAMETROS DE ENTRADA');
      begin
         select UF
               ,CODCLI
           into V_UFFILIAL
               ,V_CODCLIFILIAL
           from PCFILIAL
          where CODIGO = NVL(P_CODFILIAL, 'XXX');
      exception
         when NO_DATA_FOUND then
            P_CODMSG := 1;
            P_MSG    := 'A filial da operação não foi informada ou é inexistente';
            PKG_DEBUGGING_FWPC.LOG_RETORNO(P_CODMSG, P_MSG);
            return;
      end;
   
      begin
         select SIMPLESNACIONAL into V_SIMPLESNACIONAL from PCCLIENT where CODCLI = V_CODCLIFILIAL;
         if V_SIMPLESNACIONAL = 'S'
         then
            P_CODMSG := 11;
            P_MSG    := 'A filial está definida como Simples Nacional e não partilha ICMS';
            PKG_DEBUGGING_FWPC.LOG_RETORNO(P_CODMSG, P_MSG);
            return;
         end if;
      exception
         when NO_DATA_FOUND then
            P_CODMSG := 12;
            P_MSG    := 'O cliente que representa a filial não foi definido ou é inexistente';
            PKG_DEBUGGING_FWPC.LOG_RETORNO(P_CODMSG, P_MSG);
            return;
      end;
   
      if P_CODCLI > 0
      then
         begin
            select C.ESTENT as UF
                  ,NVL(C.CONSUMIDORFINAL, 'N') as CONSUMIDORFINAL
                  ,NVL(C.CONTRIBUINTE, 'N') as CONTRIBUINTE
                  ,C.TIPOEMPRESA
                  ,C.ISENTOICMS
                  ,DECODE(FERRAMENTAS.VERIFICAR_FJ(C.CODCLI), 'PESSOA FISICA', 'S', 'N') as PF
                  ,GERA_HISTORICO.SOMENTE_NUMERO(C.IEENT) as IE
              into V_UFCLIENTE
                  ,V_CONSUMIDOR
                  ,V_CONTRIBUINTE
                  ,V_TIPOEMPRESA
                  ,V_CLIENTEISENTOICMS
                  ,V_PESSOAFISICA
                  ,V_IECLIENTE
              from PCCLIENT C
             where CODCLI = P_CODCLI;
         
            if V_CONSUMIDOR = 'N'
               or V_CONTRIBUINTE = 'S'
            then
               P_CODMSG := 5;
               P_MSG    := 'O cliente informado não é consumidor final ou é contribuinte do ICMS';
               PKG_DEBUGGING_FWPC.LOG_RETORNO(P_CODMSG, P_MSG);
               return;
            end if;
         exception
            when NO_DATA_FOUND then
               P_CODMSG := 2;
               P_MSG    := 'O cliente informado é inexistente';
               PKG_DEBUGGING_FWPC.LOG_RETORNO(P_CODMSG, P_MSG);
               return;
         end;
      else
         V_UFCLIENTE  := trim(P_UFOPERCONSUM);
         V_CONSUMIDOR := 'S';
         if V_UFCLIENTE is null
         then
            P_CODMSG := 3;
            P_MSG    := 'A UF da operação a consumidor não foi informada';
            PKG_DEBUGGING_FWPC.LOG_RETORNO(P_CODMSG, P_MSG);
            return;
         end if;
      end if;
   
      begin
         select IMPORTADO into V_IMPORTADO from PCPRODUT P where P.CODPROD = P_CODPROD;
      exception
         when NO_DATA_FOUND then
            P_CODMSG := 10;
            P_MSG    := 'O código do produto não foi informado ou é inválido';
            PKG_DEBUGGING_FWPC.LOG_RETORNO(P_CODMSG, P_MSG);
            return;
      end;
   
      if V_UFCLIENTE = V_UFFILIAL
         or V_UFCLIENTE = 'EX'
      then
         P_CODMSG := 4;
         P_MSG    := 'A operação com o cliente não é interestadual';
         PKG_DEBUGGING_FWPC.LOG_RETORNO(P_CODMSG, P_MSG);
         return;
      end if;
   
      if P_DATAOPER is null
      then
         P_CODMSG := 6;
         P_MSG    := 'A data da operação não foi informada';
         PKG_DEBUGGING_FWPC.LOG_RETORNO(P_CODMSG, P_MSG);
         return;
      end if;
      if NVL(P_VLPRODUTO, 0) <= 0
      then
         P_CODMSG := 7;
         P_MSG    := 'O valor do produto deve ser maior que zero';
         PKG_DEBUGGING_FWPC.LOG_RETORNO(P_CODMSG, P_MSG);
         return;
      end if;
   
      begin
         F10_BUSCAR_ALIQUOTAS(V_TIPOEMPRESA
                             ,V_PESSOAFISICA
                             ,V_CONSUMIDOR
                             ,V_UFCLIENTE
                             ,V_UFFILIAL
                             ,P_CODTRIBUT
                             ,V_IMPORTADO
                             ,V_ALIQOPERACAO /*OUT*/
                             ,V_ALIQINTERESTADUAL /*OUT*/
                             ,V_ALIQINTERNADEST /*OUT*/
                             ,V_ALIQFCP /*OUT*/
                             ,V_PERCBASERED /*OUT*/);
      
      exception
         when V_TRIBUT_NAO_LOCALIZADA then
            P_CODMSG := 8;
            P_MSG    := 'A tributação não foi informada ou é inexistente';
            PKG_DEBUGGING_FWPC.LOG_RETORNO(P_CODMSG, P_MSG);
            return;
         when V_TRIBPARTILHA_NAO_LOCALIZADA then
            P_CODMSG := 9;
            P_MSG    := 'Não foi vinculada uma tributação para partilha de ICMS (rotina 514)';
            PKG_DEBUGGING_FWPC.LOG_RETORNO(P_CODMSG, P_MSG);
            return;
      end;
      
      PKG_DEBUGGING_FWPC.LOG_MSG('VERIFICANDO ISENTOS'); 
      V_ISENTOST := 'N';
      IF NVL(P_CODCLI,0) > 0 THEN
         V_ISENTOST := FERRAMENTAS.VERIFICAR_ISENTOST(P_CODCLI, P_CODPROD, P_CODTRIBUT);           	 
      END IF;
   
      PKG_DEBUGGING_FWPC.LOG_MSG('VALIDANDO EXCECAO DE CST');   
      V_EXCECAO := F10_CSTEXCECAO(P_CODTRIBUT, V_PESSOAFISICA, V_ISENTOST, V_CLIENTEFONTEST, V_TIPOEMPRESA);
      IF V_EXCECAO THEN
      	P_CODMSG := 0;
      	P_MSG    := 'Partilha calculada com sucesso'; 
      END IF;
      
      PKG_DEBUGGING_FWPC.LOG_MSG('VALIDANDO EXCECAO DE ANP');
      V_EXCECAO := F10_ANPEXCECAO(P_CODPROD);
      IF V_EXCECAO AND P_DATAOPER >= TO_DATE('01/01/2016','DD/MM/YYYY') THEN
      	P_CODMSG := 0;
      	P_MSG    := 'Partilha calculada com sucesso';
      END IF;
   
      F10_CALCULAR_VALORES(P_CODFILIAL
                          ,P_VLPRODUTO
                          ,P_DATAOPER
                          ,V_CLIENTEISENTOICMS
                          ,V_ALIQOPERACAO
                          ,V_ALIQINTERESTADUAL
                          ,V_ALIQINTERNADEST
                          ,V_ALIQFCP
                          ,V_PERCBASERED
                          ,P_RETORNO);
      P_CODMSG := 0;
      P_MSG    := 'Partilha calculada com sucesso';
   end;


 begin 

F10_OBTER_PARTILHA_ICMS(:CODFILIAL,:CODCLI,:UFOPERCONSUM,:DATAOPER,:VLPRODUTO,:CODTRIBUT,:CODPROD,:RETORNO,:CODMSG,:MSG);

 end;
CODFILIAL = '2'
CODCLI = 101003
UFOPERCONSUM = <NULL>
DATAOPER = '02/11/2023'
VLPRODUTO = 7,07
CODTRIBUT = 2
CODPROD = 112562
RETORNO = <NULL>
CODMSG = 5
MSG = 'O'
----------------------------------
Timestamp: 10:10:48.441
SELECT VALOR
  FROM PCPARAMFILIAL
 WHERE PCPARAMFILIAL.NOME = 'FIL_OPTANTESIMPLESNAC' 
   AND PCPARAMFILIAL.CODFILIAL = :CODFILIAL
CODFILIAL = '2'
----------------------------------
Timestamp: 10:11:12.355
SELECT CODFISCAL,
       DESCCFO
  FROM PCCFO
WHERE NVL(CODOPER,'XX') = 'SR'
AND CODFISCAL >= 5000 AND CODFISCAL < 6000
 AND TO_CHAR(CODFISCAL) = :PARAM1
PARAM1 = '5927'
----------------------------------
Timestamp: 10:11:26.997
SELECT VALOR
  FROM PCPARAMFILIAL
 WHERE PCPARAMFILIAL.NOME = 'FIL_OPTANTESIMPLESNAC' 
   AND PCPARAMFILIAL.CODFILIAL = :CODFILIAL
CODFILIAL = '2'
----------------------------------
Timestamp: 10:11:30.438
SELECT FERRAMENTAS.VERIFICAR_TIPOST(:CODCLI, :CODST) TIPOST FROM DUAL
CODCLI = '101003'
CODST = '2'
----------------------------------
Timestamp: 10:11:30.495
SELECT FERRAMENTAS.VERIFICAR_TIPOST(:CODCLI, :CODST) TIPOST FROM DUAL
CODCLI = '101003'
CODST = '2'
----------------------------------
Timestamp: 10:11:30.536
SELECT NVL(PCTRIBUT.IVA,0) AS IVA 
      , NVL(PCTRIBUT.PAUTA,0) AS PAUTA  
      , NVL(PCTRIBUT.ALIQICMS1,0) AS ALIQICMS1                                              
      , NVL(PCTRIBUT.ALIQICMS2,0) AS ALIQICMS2                                                                   
      , CASE WHEN NVL(PCTRIBUT.PERCBASEREDST,0) = 0                                            
             THEN 100                                                                          
             ELSE PCTRIBUT.PERCBASEREDST                                                       
        END PERCBASEREDST                                                                      
      , NVL(PCTRIBUT.PERPAUTAICMS, 0) PERPAUTAICMS                                             
      , NVL(PCTRIBUT.USAVALORULTENTBASEST,'S') USAVALORULTENTBASEST                          
      , NVL(PCTRIBUT.PERPAUTAICMSINTER, 0) PERPAUTAICMSINTER,                                  
       CASE WHEN NVL(PCTRIBUT.PERCBASERED,0) = 0                                              
             THEN 100                                                                         
             ELSE PCTRIBUT.PERCBASERED                                                        
        END PERBASERED,                                                                       
       CASE WHEN NVL(PCTRIBUT.PERBASEREDNRPA,0) = 0                                           
             THEN 100                                                                         
             ELSE PCTRIBUT.PERBASEREDNRPA                                                     
        END PERBASEREDNRPA,                                                                   
       CASE WHEN NVL(PCTRIBUT.PERCBASEREDCONSUMIDOR,0) = 0                                    
             THEN 100                                                                         
             ELSE PCTRIBUT.PERCBASEREDCONSUMIDOR                                              
        END PERCBASEREDCONSUMIDOR,                                                            
      NVL(PCTRIBUT.PERPAUTAICMS, 0) PERPAUTAICMS,
      PCTRIBUT.CODICM, PCTRIBUT.CODICMPF, PCTRIBUT.SITTRIBUT,
      PCTRIBUT.CODFISCALSREXT, PCTRIBUT.CODFISCALSRESTSR,
      PCTRIBUT.CODFISCALSRINTE, 
      NVL(PCTRIBUT.PERCDIFALIQUOTAS,0) PERCDIFALIQUOTAS,
      NVL(PCTRIBUT.PERPAUTAICMSINTER, 0) PERPAUTAICMSINTER,
      NVL(PCTRIBUT.UTILIZAPERCBASEREDPF,'N') UTILIZAPERCBASEREDPF,
      NVL(PCTRIBUT.PERDIFEREIMENTOICMS,0) PERDIFEREIMENTOICMS, PCTRIBUT.SITTRIBUTPF
   FROM PCTRIBUT                                                                               
  WHERE PCTRIBUT.CODST = :CODST
CODST = 2
----------------------------------
Timestamp: 10:11:30.627
SELECT ROUND(:VALOR,2) VALOR
FROM   DUAL
VALOR = 0
----------------------------------
Timestamp: 10:11:30.679
SELECT NVL(PCEST.NUMTRANSENTULTENT,0) AS NUMTRANSENT_ULT_NF
  FROM PCEST
 WHERE PCEST.CODPROD = :CODPROD
   AND PCEST.CODFILIAL = :CODFILIAL
CODPROD = 112562
CODFILIAL = '2'
----------------------------------
Timestamp: 10:11:30.736
SELECT NVL(PCMOV.PUNIT,0) AS PUNIT_ULT_NF
  FROM PCMOV
 WHERE NUMTRANSENT = :NUMTRANSENT
   AND CODPROD = :CODPROD
   AND CODFILIAL = :CODFILIAL
NUMTRANSENT = 219354
CODPROD = 112562
CODFILIAL = '2'
----------------------------------
Timestamp: 10:11:30.838
SELECT * 
    FROM TABLE(PKG_TRIBUTACAO.CALCULAR_ST(:CODFILIAL, 
                                          :CODFILIALNF, 
                                          :CODFILIALRETIRA, 
                                          :CODCLI, 
                                          :CODPLPAG, 
                                          :CODPROD, 
                                          :CODAUXILIAR, 
                                          :CONDVENDA, 
                                          :VENDAEXPORTACAO, 
                                          :PVENDA, 
                                          :PERCDESCINFOR,
                                          :ITEMTV1BNF,
                                          :VALORDESCPIS_COFINS,
                                          :VALORDESCICMS,
                                          :VALORSUFRAMA,
                                           NULL,
                                          :CALCULAIPI,
                                          :TRANSFERENCIA,
                                          :ORIGEMPED,
                                          :VENDALOCALESTRANGEIRA,
                                          :CODPRECOFIXO,
                                          :TRANSFERENCIAVIRTUAL,
                                          :PTABELASEMIMPOSTO,
                                          :VENDATRIANGULAR,
                                          :ROTINACONSUM,
                                          :CODBNF,
                                          :CODENDENT,
                                          'N',
                                          :TIPODOCUMENTO,
                                          'N',
                                          :CONTAORDEM,
                                          :VLICMSPARTREM
                                          ))
CODFILIAL = '2'
CODFILIALNF = '2'
CODFILIALRETIRA = '2'
CODCLI = 101003
CODPLPAG = 1
CODPROD = 112562
CODAUXILIAR = 0
CONDVENDA = 1
VENDAEXPORTACAO = 'N'
PVENDA = 7,07
PERCDESCINFOR = 0
ITEMTV1BNF = 'N'
VALORDESCPIS_COFINS = 0
VALORDESCICMS = 0
VALORSUFRAMA = 0
CALCULAIPI = 'S'
TRANSFERENCIA = 'N'
ORIGEMPED = 'B'
VENDALOCALESTRANGEIRA = 'N'
CODPRECOFIXO = 0
TRANSFERENCIAVIRTUAL = <NULL>
PTABELASEMIMPOSTO = 0
VENDATRIANGULAR = 'N'
ROTINACONSUM = 'T'
CODBNF = 0
CODENDENT = 0
TIPODOCUMENTO = 'N'
CONTAORDEM = 'N'
VLICMSPARTREM = 0
----------------------------------
Timestamp: 10:11:34.078
SELECT FERRAMENTAS.VERIFICAR_TIPOST(:CODCLI, :CODST) TIPOST FROM DUAL
CODCLI = '101003'
CODST = '2'
----------------------------------
Timestamp: 10:11:34.106
SELECT FERRAMENTAS.VERIFICAR_TIPOST(:CODCLI, :CODST) TIPOST FROM DUAL
CODCLI = '101003'
CODST = '2'
----------------------------------
Timestamp: 10:11:34.146
SELECT NVL(PCTRIBUT.IVA,0) AS IVA 
      , NVL(PCTRIBUT.PAUTA,0) AS PAUTA  
      , NVL(PCTRIBUT.ALIQICMS1,0) AS ALIQICMS1                                              
      , NVL(PCTRIBUT.ALIQICMS2,0) AS ALIQICMS2                                                                   
      , CASE WHEN NVL(PCTRIBUT.PERCBASEREDST,0) = 0                                            
             THEN 100                                                                          
             ELSE PCTRIBUT.PERCBASEREDST                                                       
        END PERCBASEREDST                                                                      
      , NVL(PCTRIBUT.PERPAUTAICMS, 0) PERPAUTAICMS                                             
      , NVL(PCTRIBUT.USAVALORULTENTBASEST,'S') USAVALORULTENTBASEST                          
      , NVL(PCTRIBUT.PERPAUTAICMSINTER, 0) PERPAUTAICMSINTER,                                  
       CASE WHEN NVL(PCTRIBUT.PERCBASERED,0) = 0                                              
             THEN 100                                                                         
             ELSE PCTRIBUT.PERCBASERED                                                        
        END PERBASERED,                                                                       
       CASE WHEN NVL(PCTRIBUT.PERBASEREDNRPA,0) = 0                                           
             THEN 100                                                                         
             ELSE PCTRIBUT.PERBASEREDNRPA                                                     
        END PERBASEREDNRPA,                                                                   
       CASE WHEN NVL(PCTRIBUT.PERCBASEREDCONSUMIDOR,0) = 0                                    
             THEN 100                                                                         
             ELSE PCTRIBUT.PERCBASEREDCONSUMIDOR                                              
        END PERCBASEREDCONSUMIDOR,                                                            
      NVL(PCTRIBUT.PERPAUTAICMS, 0) PERPAUTAICMS,
      PCTRIBUT.CODICM, PCTRIBUT.CODICMPF, PCTRIBUT.SITTRIBUT,
      PCTRIBUT.CODFISCALSREXT, PCTRIBUT.CODFISCALSRESTSR,
      PCTRIBUT.CODFISCALSRINTE, 
      NVL(PCTRIBUT.PERCDIFALIQUOTAS,0) PERCDIFALIQUOTAS,
      NVL(PCTRIBUT.PERPAUTAICMSINTER, 0) PERPAUTAICMSINTER,
      NVL(PCTRIBUT.UTILIZAPERCBASEREDPF,'N') UTILIZAPERCBASEREDPF,
      NVL(PCTRIBUT.PERDIFEREIMENTOICMS,0) PERDIFEREIMENTOICMS, PCTRIBUT.SITTRIBUTPF
   FROM PCTRIBUT                                                                               
  WHERE PCTRIBUT.CODST = :CODST
CODST = 2
----------------------------------
Timestamp: 10:11:34.235
SELECT ROUND(:VALOR,2) VALOR
FROM   DUAL
VALOR = 0
----------------------------------
Timestamp: 10:11:34.284
SELECT NVL(PCEST.NUMTRANSENTULTENT,0) AS NUMTRANSENT_ULT_NF
  FROM PCEST
 WHERE PCEST.CODPROD = :CODPROD
   AND PCEST.CODFILIAL = :CODFILIAL
CODPROD = 112562
CODFILIAL = '2'
----------------------------------
Timestamp: 10:11:34.329
SELECT NVL(PCMOV.PUNIT,0) AS PUNIT_ULT_NF
  FROM PCMOV
 WHERE NUMTRANSENT = :NUMTRANSENT
   AND CODPROD = :CODPROD
   AND CODFILIAL = :CODFILIAL
NUMTRANSENT = 219354
CODPROD = 112562
CODFILIAL = '2'
----------------------------------
Timestamp: 10:11:34.437
SELECT VALOR
  FROM PCPARAMFILIAL
 WHERE PCPARAMFILIAL.NOME = 'FIL_OPTANTESIMPLESNAC' 
   AND PCPARAMFILIAL.CODFILIAL = :CODFILIAL
CODFILIAL = '2'
----------------------------------
Timestamp: 10:11:34.478
SELECT NVL(PCEST.QTESTGER, 0) QTESTGER,
       NVL(PCEST.QTBLOQUEADA, 0) QTBLOQUEADA,
       NVL(PCEST.QTINDENIZ, 0) QTINDENIZ,
       NVL(PCEST.QTEST, 0) QTEST,
       NVL(PCEST.QTRESERV, 0) QTRESERV,
       NVL(PCEST.QTPENDENTE,0) QTPENDENTE,
       pkg_estoque.ESTOQUE_DISPONIVEL(PCEST.CODPROD,PCEST.CODFILIAL,null) QTSALDO,
       PCEST.VALORULTENT,
       PCEST.CUSTOCONT,
       PCEST.CUSTOFIN,
       PCEST.CUSTOREAL,
       PCEST.CUSTOREP,
       PCEST.CUSTOULTENT,
       PCPRODUT.CODSEC,
       PCPRODUT.CODEPTO, 
       PCEST.NUMFCI
  FROM PCEST, PCPRODUT
 WHERE PCEST.CODFILIAL = :CODFILIAL
   AND PCEST.CODPROD = :CODPROD
   AND PCEST.CODPROD = PCPRODUT.CODPROD
CODFILIAL = '2'
CODPROD = 112562
----------------------------------
Timestamp: 10:11:34.550
SELECT CODFISCAL FROM PCCFO WHERE CODFISCAL = :CODFISCAL AND NVL(CODOPER,'XX') = 'SR'
CODFISCAL = 5927
----------------------------------
Timestamp: 10:11:34.580
SELECT (NVL(QTESTGER,0)-NVL(QTRESERV,0)) QTESTGER
      ,NVL(PCEST.QTBLOQUEADA,0) QTBLOQUEADA
      ,NVL(PCEST.QTINDENIZ,0) QTINDENIZ
  FROM PCEST
 WHERE PCEST.CODPROD = :CODPROD
   AND CODFILIAL = :CODFILIAL
CODPROD = 112562
CODFILIAL = '2'
----------------------------------
Timestamp: 10:11:34.708
--Pesquiar produto                                                  
SELECT PCPRODUT.CODPROD                                     
      ,PCPRODUT.DESCRICAO                                   
      ,NVL(PCPRODUT.TIPOMERC, 'XX') AS TIPOMERC           
      ,NVL(PCPRODUT.ESTOQUEPORLOTE,'N') AS ESTOQUEPORLOTE 
      ,NVL(PCPRODUT.USAWMS,'N') AS USAWMS                 
      ,NVL(PCPRODUT.CODAUXILIAR, 0) AS CODAUXILIAR          
FROM PCPRODUT                                               
WHERE 1=1                                                   
  AND PCPRODUT.CODPROD = :CODPROD
CODPROD = 112562
----------------------------------
Timestamp: 10:11:34.750
--Pesquiar produto filial 
SELECT PCPRODFILIAL.CODPROD 
      ,PCPRODFILIAL.CODFILIAL 
      ,NVL(PCPRODFILIAL.CONTROLANUMSERIE,'N') AS CONTROLANUMSERIE 
      ,NVL(PCPRODFILIAL.NUMEROSSERIECONTROLADOS, 0) AS NUMEROSSERIECONTROLADOS 
FROM PCPRODFILIAL 
WHERE 1=1 
  AND PCPRODFILIAL.CODPROD = :CODPROD 
  AND PCPRODFILIAL.CODFILIAL = :CODFILIAL
CODPROD = 112562
CODFILIAL = '2'
----------------------------------
Timestamp: 10:11:34.852
SELECT ROUND(:VALOR,2) VALOR
FROM   DUAL
VALOR = 1
----------------------------------
Timestamp: 10:11:34.881
SELECT ROUND(:VALOR,2) VALOR
FROM   DUAL
VALOR = 0