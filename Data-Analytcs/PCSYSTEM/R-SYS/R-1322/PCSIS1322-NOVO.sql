----------------------------------
Timestamp: 10:03:48.390
Successful commit.
----------------------------------
Timestamp: 10:03:48.397
begin  :result := sys.dbms_transaction.local_transaction_id(true); end;
result = '21.12.9807524'
----------------------------------
Timestamp: 10:03:48.422
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '21.12.9807524'
----------------------------------
Timestamp: 10:03:48.455
SELECT NVL(PROXNUMTRANSVENDA,1) PROXNUMTRANSVENDA FROM PCCONSUM FOR UPDATE
----------------------------------
Timestamp: 10:03:48.476
UPDATE PCCONSUM SET PROXNUMTRANSVENDA = NVL(PROXNUMTRANSVENDA,1) + 1
----------------------------------
Timestamp: 10:03:48.493
Successful commit.
----------------------------------
Timestamp: 10:03:48.496
SELECT COUNT(*) CONTADOR    
   FROM PCLIB                
  WHERE CODTABELA = 1        
    AND CODIGOA   = '99'   
    AND CODFUNC   = :CODFUNC
CODFUNC = 1261
----------------------------------
Timestamp: 10:03:48.545
SELECT CODIGO                                              
     , RAZAOSOCIAL                                           
     , UF                                                    
     , GERARNSU                                              
     , NVL(USAWMS, 'N') USAWMS                             
     , NVL(INDUSTRIA, 'N') INDUSTRIA                       
     , NVL(PCFILIAL.UTILIZANFE, 'N') UTILIZANFE            
     , NVL(PCFILIAL.CALCULARIPIVENDA, 'N') CALCULARIPIVENDA 
  FROM PCFILIAL                                            
WHERE CODIGO <> '99'                                     
AND CODIGO IN (SELECT CODIGOA FROM PCLIB WHERE CODFUNC = :CODFUNC AND CODTABELA = 1)
ORDER BY CODIGO
CODFUNC = 1261
----------------------------------
Timestamp: 10:03:48.589
SELECT NVL(UTILIZANFE,'N') UTILIZANFE FROM PCFILIAL WHERE CODIGO = :CODIGO
CODIGO = '2'
----------------------------------
Timestamp: 10:03:48.623
SELECT CODCONTCLI,
       NVL(TIPOCUSTO1322, 'C') TIPOCUSTO1322,
       TRUNC(SYSDATE) DATASRV,
       VERIFICAESTOQUECONT,
       UTILIZAPERCBASEREDPF,
       CONSIDERAISENTOSCOMOPF,
       NVL(CALCSTPF, 'N') CALCSTPF,
       USAWMS,
       (SELECT NVL(PCPARAMFILIAL.VALOR,
                   (SELECT NVL(PCCONSUM.VERIFICAESTOQUECONT, 'S')
                      FROM PCCONSUM)) VERIFICAESTOQUECONT
          FROM PCPARAMFILIAL
         WHERE PCPARAMFILIAL.NOME LIKE 'VERIFICAESTOQUECONT%'
           AND PCPARAMFILIAL.CODFILIAL = :CODFILIAL) VERIFICAESTOQUECONT,
       NVL(UTILIZACONTROLELOTE, 'N') UTILIZACONTROLELOTE,
       NVL(USATRIBUTACAOPORUF, 'N') USATRIBUTACAOPORUF,
       NVL(VERIFICAESTOQUECONT, 'N') VERIFICAESTOQUECONT,
       NVL(CALCULARSTCOMIPI, 'N') CALCULARSTCOMIPI,
        (SELECT NVL(PCPARAMFILIAL.VALOR,  
          (SELECT NVL(PCCONSUM.ACEITAVENDABALCAOESTNEG, 'S')
                      FROM PCCONSUM)) ACEITAVENDABALCAOESTNEG
          FROM PCPARAMFILIAL
         WHERE PCPARAMFILIAL.NOME LIKE 'PERMITIRESTGERNEGATIVO%'
           AND PCPARAMFILIAL.CODFILIAL = :CODFILIAL) ACEITAVENDABALCAOESTNEG                   
  FROM PCCONSUM
CODFILIAL = '2'
----------------------------------
Timestamp: 10:03:48.726
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
Timestamp: 10:03:48.804
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
Timestamp: 10:03:48.877
SELECT DTPROCESSAMENTO  FROM PCCONSUM
----------------------------------
Timestamp: 10:03:48.909
SELECT ESPECIE, SERIE, NUMNOTA, VLTOTGER, VLFRETE, ICMSRETIDO,
       DTSAIDA, VLTOTAL, CODCONT, CODPLPAG,TOTPESO,NUMSELONF,
       CODFISCAL, CODCLI, CAIXA, CODUSUR, CODEMITENTE,
       DTENTREGA, CODFILIAL, VLDESCONTO, NUMCAR, CONDVENDA,
       TIPOVENDA, OBS, NUMTRANSVENDA, CODPRACA, VLIPI, VLBASEIPI, BCST,
       FRETEDESPACHO, FRETEREDESPACHO, CODFORNECFRETE, CODSUPERVISOR, ROTINALANC,
       NSU, DTNSU, NUMVOLUME, ESPECIEVOLUME, PLACAVEIC, CODMOTORISTA, TOTDIFALIQUOTAS,
      UFDESEMBARACO, LOCALDESEMBARACO, UFPLACAVEI,UFPLACAVEIC,
      MOTORISTAVEICULO, USAINTEGRACAOWMS, NUMITENS, VLOUTRASDESP, DTSAIDANF, NFBRINDEZERADA, CGC
FROM PCNFSAID
WHERE NUMTRANSVENDA = :NUMTRANSVENDA
AND       CODCONT = :CODCONT
NUMTRANSVENDA = 5820276
CODCONT = 101
----------------------------------
Timestamp: 10:03:48.977
SELECT CODCONTCLI,
       NVL(TIPOCUSTO1322, 'C') TIPOCUSTO1322,
       TRUNC(SYSDATE) DATASRV,
       VERIFICAESTOQUECONT,
       UTILIZAPERCBASEREDPF,
       CONSIDERAISENTOSCOMOPF,
       NVL(CALCSTPF, 'N') CALCSTPF,
       USAWMS,
       (SELECT NVL(PCPARAMFILIAL.VALOR,
                   (SELECT NVL(PCCONSUM.VERIFICAESTOQUECONT, 'S')
                      FROM PCCONSUM)) VERIFICAESTOQUECONT
          FROM PCPARAMFILIAL
         WHERE PCPARAMFILIAL.NOME LIKE 'VERIFICAESTOQUECONT%'
           AND PCPARAMFILIAL.CODFILIAL = :CODFILIAL) VERIFICAESTOQUECONT,
       NVL(UTILIZACONTROLELOTE, 'N') UTILIZACONTROLELOTE,
       NVL(USATRIBUTACAOPORUF, 'N') USATRIBUTACAOPORUF,
       NVL(VERIFICAESTOQUECONT, 'N') VERIFICAESTOQUECONT,
       NVL(CALCULARSTCOMIPI, 'N') CALCULARSTCOMIPI,
        (SELECT NVL(PCPARAMFILIAL.VALOR,  
          (SELECT NVL(PCCONSUM.ACEITAVENDABALCAOESTNEG, 'S')
                      FROM PCCONSUM)) ACEITAVENDABALCAOESTNEG
          FROM PCPARAMFILIAL
         WHERE PCPARAMFILIAL.NOME LIKE 'PERMITIRESTGERNEGATIVO%'
           AND PCPARAMFILIAL.CODFILIAL = :CODFILIAL) ACEITAVENDABALCAOESTNEG                   
  FROM PCCONSUM
CODFILIAL = '2'
----------------------------------
Timestamp: 10:03:49.062
SELECT PCMOV.*,
       PCPRODUT.PESOBRUTO AS PRODPESOBRUTO,
       PCDEPTO.TIPOMERC,
       PCMOVCOMPLE.PERACRESCIMOFUNCEP,
       PCMOVCOMPLE.ALIQICMSFECP,
       PCMOVCOMPLE.VLFECP,
       PCMOVCOMPLE.ALIQFCP, 
       PCMOVCOMPLE.VLBASEFCPICMS,
       PCMOVCOMPLE.VLACRESCIMOFUNCEP,
       PCMOVCOMPLE.VLBASEFCPST,
       PCMOV.PUNIT VALORSEMIMPOSTO,
       LPAD('A',200, 'X') FORMULAFUNCEPICMS, --Campo temporário
       PCMOVCOMPLE.NUMFCI
FROM PCMOV, PCPRODUT, PCDEPTO, PCMOVCOMPLE
WHERE PCMOV.NUMTRANSVENDA = :NUMTRANSVENDA
  AND PCMOV.CODPROD BETWEEN :CODPRODINI AND :CODPRODFIM
  AND PCMOV.NUMSEQ  BETWEEN :NUMSEQINI AND :NUMSEQFIM
  AND PCMOV.CODPROD = PCPRODUT.CODPROD
  AND PCPRODUT.CODEPTO = PCDEPTO.CODEPTO
  AND PCMOVCOMPLE.NUMTRANSITEM(+) = PCMOV.NUMTRANSITEM
NUMTRANSVENDA = 5820276
CODPRODINI = 0
CODPRODFIM = 999999
NUMSEQINI = <NULL>
NUMSEQFIM = <NULL>
----------------------------------
Timestamp: 10:03:49.186
SELECT NUMTRANSVENDA, ALIQUOTA, VLBASE, VLICMS, CODCONT, VLICMSDIFERIDO,
'N' TEM_ACRESCIMO_FUNCEP
FROM PCNFBASE
WHERE NUMTRANSVENDA = :NUMTRANSVENDA
NUMTRANSVENDA = 5820276
----------------------------------
Timestamp: 10:03:49.218
SELECT CODCLI,PREST,DUPLIC,VALOR,DTVENC,CODCOB,VPAGO,TXPERM,DTPAG,
       DTEMISSAO,OPERACAO,CODFILIAL,STATUS,CODUSUR,DTULTALTER,NUMCAR,
       DTVENCORIG,CODSUPERVISOR,NUMTRANSVENDA,VALORORIG,CODCOBORIG,DTSAIDA,
       CODFILIALNF,CODMOTORISTA, DTFECHA, DTCXMOT, CODCOBSEFAZ
FROM   PCPREST
WHERE  NUMTRANSVENDA = :NUMTRANSVENDA
NUMTRANSVENDA = 5820276
----------------------------------
Timestamp: 10:03:49.260
SELECT NOMETABELA, NUMTRANS, COMPLEMENTO1
FROM PCCOMPLEMENTO
WHERE NUMTRANS = :NUMTRANSVENDA
AND PCCOMPLEMENTO.NOMETABELA = 'PCNFSAID'
NUMTRANSVENDA = 5820276
----------------------------------
Timestamp: 10:03:49.295
SELECT CODFISCAL, CODFISCAL || '-' || DESCCFO DESCRICAO
FROM PCCFO
--WHERE CODFISCAL NOT IN ( 512, 511, 612, 611 )
ORDER BY CODFISCAL
----------------------------------
Timestamp: 10:03:49.325
SELECT COUNT(*) CONTADOR    
   FROM PCLIB                
  WHERE CODTABELA = 1        
    AND CODIGOA   = '99'   
    AND CODFUNC   = :CODFUNC
CODFUNC = 1261
----------------------------------
Timestamp: 10:03:49.362
SELECT CODIGO                                              
     , RAZAOSOCIAL                                           
     , UF                                                    
     , GERARNSU                                              
     , NVL(USAWMS, 'N') USAWMS                             
     , NVL(INDUSTRIA, 'N') INDUSTRIA                       
     , NVL(PCFILIAL.UTILIZANFE, 'N') UTILIZANFE            
     , NVL(PCFILIAL.CALCULARIPIVENDA, 'N') CALCULARIPIVENDA 
  FROM PCFILIAL                                            
WHERE CODIGO <> '99'                                     
AND CODIGO IN (SELECT CODIGOA FROM PCLIB WHERE CODFUNC = :CODFUNC AND CODTABELA = 1)
ORDER BY CODIGO
CODFUNC = 1261
----------------------------------
Timestamp: 10:03:49.413
SELECT NVL(UTILIZANFE,'N') UTILIZANFE FROM PCFILIAL WHERE CODIGO = :CODIGO
CODIGO = '2'
----------------------------------
Timestamp: 10:03:49.442
SELECT CODCONTCLI,
       NVL(TIPOCUSTO1322, 'C') TIPOCUSTO1322,
       TRUNC(SYSDATE) DATASRV,
       VERIFICAESTOQUECONT,
       UTILIZAPERCBASEREDPF,
       CONSIDERAISENTOSCOMOPF,
       NVL(CALCSTPF, 'N') CALCSTPF,
       USAWMS,
       (SELECT NVL(PCPARAMFILIAL.VALOR,
                   (SELECT NVL(PCCONSUM.VERIFICAESTOQUECONT, 'S')
                      FROM PCCONSUM)) VERIFICAESTOQUECONT
          FROM PCPARAMFILIAL
         WHERE PCPARAMFILIAL.NOME LIKE 'VERIFICAESTOQUECONT%'
           AND PCPARAMFILIAL.CODFILIAL = :CODFILIAL) VERIFICAESTOQUECONT,
       NVL(UTILIZACONTROLELOTE, 'N') UTILIZACONTROLELOTE,
       NVL(USATRIBUTACAOPORUF, 'N') USATRIBUTACAOPORUF,
       NVL(VERIFICAESTOQUECONT, 'N') VERIFICAESTOQUECONT,
       NVL(CALCULARSTCOMIPI, 'N') CALCULARSTCOMIPI,
        (SELECT NVL(PCPARAMFILIAL.VALOR,  
          (SELECT NVL(PCCONSUM.ACEITAVENDABALCAOESTNEG, 'S')
                      FROM PCCONSUM)) ACEITAVENDABALCAOESTNEG
          FROM PCPARAMFILIAL
         WHERE PCPARAMFILIAL.NOME LIKE 'PERMITIRESTGERNEGATIVO%'
           AND PCPARAMFILIAL.CODFILIAL = :CODFILIAL) ACEITAVENDABALCAOESTNEG                   
  FROM PCCONSUM
CODFILIAL = '2'
----------------------------------
Timestamp: 10:03:49.546
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
Timestamp: 10:03:49.608
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
Timestamp: 10:03:49.680
SELECT DTPROCESSAMENTO  FROM PCCONSUM
----------------------------------
Timestamp: 10:03:49.705
SELECT NVL(SERIE, '1') SERIE    
FROM   PCDOCC                     
WHERE CODDOC IN                   
      (SELECT  CODDOCSR           
       FROM PCFILIAL              
       WHERE CODIGO = :CODFILIAL)
CODFILIAL = '2'
----------------------------------
Timestamp: 10:03:49.760
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
Timestamp: 10:03:49.824
SELECT NVL(UTILIZANFE,'N') UTILIZANFE FROM PCFILIAL WHERE CODIGO = :CODIGO
CODIGO = '2'
----------------------------------
Timestamp: 10:03:49.857
SELECT CODCONTCLI,
       NVL(TIPOCUSTO1322, 'C') TIPOCUSTO1322,
       TRUNC(SYSDATE) DATASRV,
       VERIFICAESTOQUECONT,
       UTILIZAPERCBASEREDPF,
       CONSIDERAISENTOSCOMOPF,
       NVL(CALCSTPF, 'N') CALCSTPF,
       USAWMS,
       (SELECT NVL(PCPARAMFILIAL.VALOR,
                   (SELECT NVL(PCCONSUM.VERIFICAESTOQUECONT, 'S')
                      FROM PCCONSUM)) VERIFICAESTOQUECONT
          FROM PCPARAMFILIAL
         WHERE PCPARAMFILIAL.NOME LIKE 'VERIFICAESTOQUECONT%'
           AND PCPARAMFILIAL.CODFILIAL = :CODFILIAL) VERIFICAESTOQUECONT,
       NVL(UTILIZACONTROLELOTE, 'N') UTILIZACONTROLELOTE,
       NVL(USATRIBUTACAOPORUF, 'N') USATRIBUTACAOPORUF,
       NVL(VERIFICAESTOQUECONT, 'N') VERIFICAESTOQUECONT,
       NVL(CALCULARSTCOMIPI, 'N') CALCULARSTCOMIPI,
        (SELECT NVL(PCPARAMFILIAL.VALOR,  
          (SELECT NVL(PCCONSUM.ACEITAVENDABALCAOESTNEG, 'S')
                      FROM PCCONSUM)) ACEITAVENDABALCAOESTNEG
          FROM PCPARAMFILIAL
         WHERE PCPARAMFILIAL.NOME LIKE 'PERMITIRESTGERNEGATIVO%'
           AND PCPARAMFILIAL.CODFILIAL = :CODFILIAL) ACEITAVENDABALCAOESTNEG                   
  FROM PCCONSUM
CODFILIAL = '2'
----------------------------------
Timestamp: 10:03:49.960
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