----------------------------------
Timestamp: 11:43:19.670
["Describe only" statement]
Select vtd.task_id,vtd.priority_level,vtd.task_status_id,qcms_task_has_link(vtd.task_id) as hasLink,qcms_object_has_attachment(vtd.task_id,1) as hasAttachment,vtd.task_type_id
,vtd.REQUEST_ID
,vtd.SHORT_DESCRIPTION
,vtd.TASK_STATUS_DESC
,vtd.RESOURCE_ASSIGNED
,vtd.PRIORITY_DESC
,vtd.ASSIGNED_DATE
,vtd.REQUEST_COMPONENT
,vtd.REQUEST_TYPE
From qs_view_task_details vtd, qs_requests Req
where vtd.request_id=req.request_id
and vtd.assigned_to = 11649
----------------------------------
Timestamp: 11:43:19.732
Select vtd.task_id,vtd.priority_level,vtd.task_status_id,qcms_task_has_link(vtd.task_id) as hasLink,qcms_object_has_attachment(vtd.task_id,1) as hasAttachment,vtd.task_type_id
,vtd.REQUEST_ID
,vtd.SHORT_DESCRIPTION
,vtd.TASK_STATUS_DESC
,vtd.RESOURCE_ASSIGNED
,vtd.PRIORITY_DESC
,vtd.ASSIGNED_DATE
,vtd.REQUEST_COMPONENT
,vtd.REQUEST_TYPE
From qs_view_task_details vtd, qs_requests Req
where vtd.request_id=req.request_id
and vtd.assigned_to = 11649
----------------------------------
Timestamp: 14:39:57.456
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '69.33.830530'
----------------------------------
Timestamp: 14:39:57.476
UPDATE PCMANIFDESTINATARIO
SET
  SITCONFIRMACAODEST = :SITUACAOMANIF, JUSTIFICATIVA = :JUSTIFICATIVA
WHERE
  CODIGO = :Old_CODIGO
SITUACAOMANIF = 0
JUSTIFICATIVA = <NULL>
Old_CODIGO = 71118
----------------------------------
Timestamp: 14:40:46.674
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '69.33.830530'
----------------------------------
Timestamp: 14:40:46.694
Successful rollback.
----------------------------------
Timestamp: 14:40:46.915
SELECT 'N' AS SELECIONADO,
       PCMANIFDESTINATARIO.CODIGO,
       TO_NUMBER(SUBSTR(PCMANIFDESTINATARIO.CHAVENFE, 26, 9)) NUMNOTA,
       SUBSTR(PCMANIFDESTINATARIO.CHAVENFE, 23, 3) SERIE,
       PCMANIFDESTINATARIO.DATAEMISSAO,
       NVL(PCMANIFDESTINATARIO.DATAENTRADA, '') AS DATAENTRADA,
       DECODE(NVL(PCNFENT.CODFILIALNF, PCNFENT.CODFILIAL),
              PCMANIFDESTINATARIO.CODFILIAL,
              NVL(PCNFENT.DTENT, ''),
              '') AS DTENT,
       PCMANIFDESTINATARIO.NOME AS FORNECEDOR,
       PCFORNEC.CODFORNEC,
       PCMANIFDESTINATARIO.CNPJCPF,       
       NVL(PCMANIFDESTINATARIO.SITCONFIRMACAODEST, 0) AS SITUACAOMANIF,
       NVL(PCMANIFDESTINATARIO.SITCONFIRMACAODESTANT, 0) AS SITUACAOMANIFANT,
       PCMANIFDESTINATARIO.VLTOTALNFE,
       PCMANIFDESTINATARIO.CHAVENFE,
       PCMANIFDESTINATARIO.DATARECEBDOCUMENTO,
       DECODE(PCMANIFDESTINATARIO.SITUACAONFE,
              1,
              'USO AUTORIZADO',
              2,
              'DENEGADA',
              3,
              'CANCELADA') AS SITUACAONFE,
       DECODE(PCMANIFDESTINATARIO.TIPODOCUMENTO,
              0,
              'NF-e',
              1,
              'CANCELAMENTO',
              2,
              'CC-e') AS TIPODOC,
       DECODE(PCMANIFDESTINATARIO.AMBIENTE,
              'H',
              'HOMOLOGACAO',
              'P',
              'PRODUCAO') AS AMBIENTE,
       PCMANIFDESTINATARIO.JUSTIFICATIVA,
       NVL(PCNFENT.ESPECIE, 'X') AS ESPECIE,
       NVL(PCNFENT.NUMTRANSENT, 0) AS NUMTRANSENT
--Atenção ao alterar ou identar codigos apos o where pois o select é alterado 
dinamincamente também  FROM PCFILIAL, PCFORNEC PCFORNEC2, PCMANIFDESTINATARIO, PCFORNEC, PCNFENT

 WHERE PCMANIFDESTINATARIO.CODFILIAL = :CODFILIAL

   and PCMANIFDESTINATARIO.CNPJCPF = REPLACE(REPLACE(REPLACE(PCFORNEC.CGC(+), 
'.', ''), '/', ''), '-', '')   and PCMANIFDESTINATARIO.CHAVENFE = PCNFENT.CHAVENFE(+)
   and PCMANIFDESTINATARIO.DATAEMISSAO = PCNFENT.DTEMISSAO(+)---new

   ------------ATENÇÃO COM O CODIGO ABAIXC-----------------                                                                                  
   --subselect abaixo serve para não apresentar notas onde a filial é apenas o 
transportador da nota, e não o destinatario                      and nvl((select pcfornec.cgc
             from pcnfsaid, pcfornec, pcclient
            where pcnfsaid.codfornecfrete = pcfornec.codfornec

              and nvl(pcnfsaid.codfilialnf, pcnfsaid.codfilial) = 
PCMANIFDESTINATARIO.CODFILIAL              and exists (select 1 from pcfilial where cgc = pcfornec.cgc)
              and pcnfsaid.codcli = pcclient.codcli
              and pcnfsaid.chavenfe = PCMANIFDESTINATARIO.CHAVENFE
              and pcnfsaid.especie = 'NF'----new

              and pcnfsaid.numnota = 
TO_NUMBER(SUBSTR(PCMANIFDESTINATARIO.CHAVENFE, 26, 9))----new
              and REPLACE(REPLACE(REPLACE(pcfornec.cgc, '.', ''), '/', ''), '-',
 '') <> REPLACE(REPLACE(REPLACE(pcclient.cgcent, '.', ''), '/', ''), '-', '')), 
'X') <> pcfilial.cgc   AND NOME IS NOT NULL
   AND VLTOTALNFE IS NOT NULL

   ----------Se for o Op. Logistico não mostrar notas do destinatário ----------                                                                AND PCMANIFDESTINATARIO.CHAVENFE NOT IN
       (SELECT I.CHAVENFE
          FROM PCCONHECIMENTOFRETEI I, PCNFSAID S
         WHERE I.CHAVENFE = PCMANIFDESTINATARIO.CHAVENFE
           AND NVL(s.CODFILIALNF, s.CODFILIAL) = PCMANIFDESTINATARIO.CODFILIAL
           AND S.NUMTRANSVENDA = I.NUMTRANSCONHEC
           AND NVL(S.ESPECIE, 'NF') IN ('CO', 'CT', 'CE'))

---------------------------------------------------------                                                                                 
 AND (('VALIDO'  = NVL(PCFORNEC.CGC,'VALIDO'))OR (PCFORNEC.CODFORNEC =  (SELECT 
MAX(PCFORNEC.CODFORNEC) FROM PCFORNEC  WHERE PCMANIFDESTINATARIO.CNPJCPF = 
REPLACE(REPLACE(REPLACE(PCFORNEC.CGC,'.',''), '/',''),'-','') )))   
AND NVL(PCMANIFDESTINATARIO.DATAEMISSAO, PCNFENT.DTEMISSAO) BETWEEN 
:DATAINICIAL AND :DATAFINALAND NVL(PCMANIFDESTINATARIO.SITCONFIRMACAODEST, 0) IN (0)

AND (SUBSTR(PCMANIFDESTINATARIO.CHAVENFE, 7, 14)) <> 
REPLACE(REPLACE(REPLACE(NVL(PCFORNEC2.CGC, PCFILIAL.CGC),'.',''), '/',''),'-',
'') AND PCFORNEC2.CODFORNEC = PCFILIAL.CODFORNEC
AND PCFILIAL.CODIGO = PCMANIFDESTINATARIO.CODFILIAL
AND NVL(especie, 'X') <> 'OE' 
ORDER BY NUMNOTA
CODFILIAL = '2'
DATAINICIAL = '25/03/2024'
DATAFINAL = '01/04/2024'
----------------------------------
Timestamp: 14:40:47.088
Successful commit.
----------------------------------
Timestamp: 14:40:47.090
begin  :result := sys.dbms_transaction.local_transaction_id(true); end;
result = '53.10.1461594'
----------------------------------
Timestamp: 14:40:47.096
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '53.10.1461594'
----------------------------------
Timestamp: 14:41:49.270
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '53.10.1461594'
----------------------------------
Timestamp: 14:41:49.281
UPDATE PCMANIFDESTINATARIO
SET
  SITCONFIRMACAODEST = :SITUACAOMANIF, JUSTIFICATIVA = :JUSTIFICATIVA
WHERE
  CODIGO = :Old_CODIGO
SITUACAOMANIF = 1
JUSTIFICATIVA = <NULL>
Old_CODIGO = 71014
----------------------------------
Timestamp: 14:42:02.582
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '53.10.1461594'
----------------------------------
Timestamp: 14:42:02.596
UPDATE PCMANIFDESTINATARIO
SET
  SITCONFIRMACAODEST = :SITUACAOMANIF, JUSTIFICATIVA = :JUSTIFICATIVA
WHERE
  CODIGO = :Old_CODIGO
SITUACAOMANIF = 4
JUSTIFICATIVA = <NULL>
Old_CODIGO = 71118
----------------------------------
Timestamp: 14:42:13.734
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '53.10.1461594'
----------------------------------
Timestamp: 14:42:13.748
UPDATE PCMANIFDESTINATARIO
SET
  SITCONFIRMACAODEST = :SITUACAOMANIF, JUSTIFICATIVA = :JUSTIFICATIVA
WHERE
  CODIGO = :Old_CODIGO
SITUACAOMANIF = 0
JUSTIFICATIVA = <NULL>
Old_CODIGO = 71014
----------------------------------
Timestamp: 14:42:15.797
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '53.10.1461594'
----------------------------------
Timestamp: 14:42:15.814
UPDATE PCMANIFDESTINATARIO
SET
  SITCONFIRMACAODEST = :SITUACAOMANIF, JUSTIFICATIVA = :JUSTIFICATIVA
WHERE
  CODIGO = :Old_CODIGO
SITUACAOMANIF = 1
JUSTIFICATIVA = <NULL>
Old_CODIGO = 71110
----------------------------------
Timestamp: 14:42:31.975
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '53.10.1461594'
----------------------------------
Timestamp: 14:42:31.985
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '53.10.1461594'
----------------------------------
Timestamp: 14:42:31.994

SELECT '' TABLE_CATALOG, IC.TABLE_OWNER TABLE_SCHEMA, IC.TABLE_NAME, '' 
INDEX_CATALOG, IC.INDEX_OWNER INDEX_SCHEMA, IC.INDEX_NAME, IC.COLUMN_NAME, 
IC.COLUMN_POSITION, DECODE(IC.DESCEND, 'ASC', 0, 1) DESCENDING FROM 
SYS.ALL_IND_COLUMNS IC, SYS.ALL_INDEXES I, SYS.ALL_CONSTRAINTS C WHERE 
IC.TABLE_OWNER = 'FRIOBOM' AND IC.TABLE_NAME = 'PCFILIAL' AND I.UNIQUENESS = 
'UNIQUE' AND        I.OWNER = IC.INDEX_OWNER AND I.INDEX_NAME = IC.INDEX_NAME 
AND       C.TABLE_NAME (+) = IC.TABLE_NAME AND C.INDEX_NAME (+) = IC.INDEX_NAME 
AND C.OWNER (+)= IC.TABLE_OWNER ORDER BY DECODE(IC.INDEX_OWNER, 'FRIOBOM', 0, 
'PUBLIC', 1, 2), DECODE(C.CONSTRAINT_TYPE, 'P', 1, 'U', 2, 3), IC.INDEX_OWNER, 
IC.TABLE_OWNER, IC.TABLE_NAME, IC.INDEX_NAME, IC.COLUMN_POSITION----------------------------------
Timestamp: 14:42:32.011
----------------------------------
Timestamp: 14:42:45.373
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '53.10.1461594'
----------------------------------
Timestamp: 14:42:45.392
Successful commit.
----------------------------------
Timestamp: 14:43:27.999
UPDATE PCMANIFDESTINATARIO
SET
  SITCONFIRMACAODEST = :SITUACAOMANIF, JUSTIFICATIVA = :JUSTIFICATIVA
WHERE
  CODIGO = :Old_CODIGO
SITUACAOMANIF = 0
JUSTIFICATIVA = <NULL>
Old_CODIGO = 70991
----------------------------------
Timestamp: 14:43:32.224
UPDATE PCMANIFDESTINATARIO
SET
  SITCONFIRMACAODEST = :SITUACAOMANIF, JUSTIFICATIVA = :JUSTIFICATIVA
WHERE
  CODIGO = :Old_CODIGO
SITUACAOMANIF = 4
JUSTIFICATIVA = <NULL>
Old_CODIGO = 71118
----------------------------------
Timestamp: 14:43:32.255
SELECT DFSEQ_IDREMESSAMANIF.CURRVAL AS VALOR
FROM DUAL
----------------------------------
Timestamp: 14:43:32.268
Successful commit.
----------------------------------
Timestamp: 14:43:32.270
begin  :result := sys.dbms_transaction.local_transaction_id(true); end;
result = '69.1.830477'
----------------------------------
Timestamp: 14:43:32.280
begin  :result := sys.dbms_transaction.local_transaction_id; end;
result = '69.1.830477'
----------------------------------
Timestamp: 14:43:32.297
UPDATE PCMANIFDESTINATARIO
SET
  IDREMESSA = :IDREMESSA
WHERE CODIGO = :CODIGO
IDREMESSA = 17094
CODIGO = 71118
----------------------------------
Timestamp: 14:43:32.315
Successful commit.
----------------------------------
Timestamp: 14:43:38.626
UPDATE PCMANIFDESTINATARIO
SET
  SITCONFIRMACAODEST = NVL(SITCONFIRMACAODESTANT, 0)
WHERE IDREMESSA = :IDREMESSA
AND NVL(CODSTATUS, 0) NOT IN (135, 136)
IDREMESSA = 17094
----------------------------------
Timestamp: 14:43:38.650
UPDATE PCMANIFDESTINATARIO
SET
  SITCONFIRMACAODESTANT = NVL(SITCONFIRMACAODEST, 0)
WHERE IDREMESSA = :IDREMESSA
AND NVL(CODSTATUS, 0) IN (135, 136)
IDREMESSA = 17094
----------------------------------
Timestamp: 14:43:38.675
Successful commit.
----------------------------------
Timestamp: 14:43:38.680
SELECT CODIGO, 
       TO_NUMBER(SUBSTR(CHAVENFE, 26, 9)) NUMNOTA,
       SUBSTR(CHAVENFE, 23, 3) SERIE,
       DATAEMISSAO,
       CNPJCPF, 
       NOME AS FORNECEDOR,
       SITCONFIRMACAODEST,
       DECODE(SITCONFIRMACAODEST,
              0,
              'SEM MANIFESTAÇÃO',
              1,
              'CONFIRMAÇÃO DA OPERAÇÃO',
              2,
              'DESCONHECIMENTO DA OPERAÇÃO',
              3,
              'OPERAÇÃO NÃO REALIZADA',
              4,
              'CIÊNCIA DA OPERAÇÃO') AS SITUACAOMANIF,
       DECODE(CODSTATUS, 135, 0, 136, 0, 1) AS STATUS,
       CHAVENFE,
       CODSTATUS,
       DESCSTATUS
FROM PCMANIFDESTINATARIO
WHERE IDREMESSA = :IDREMESSA
IDREMESSA = 17094
----------------------------------
Timestamp: 14:43:38.742
INSERT INTO PCMANIFDESTINATARIOLOG (
  CODFUNCLANC,
  MAQUINA,
  USUARIOSO,
  DATA,
  OPCAOUTILIZADA,
  SITCONFIRMACAODEST,
  CODIGO,
  CODFILIAL
  ) VALUES (
  :CODFUNCLANC,
  (SELECT USERENV('TERMINAL') FROM DUAL),
   (SELECT UPPER(SYS_CONTEXT('USERENV', 'OS_USER')) FROM DUAL),
  SYSDATE,
  :OPCAOUTILIZADA,
  :SITCONFIRMACAODEST,
  :CODIGO,
  :CODFILIAL
  )
CODFUNCLANC = 1261
OPCAOUTILIZADA = 1
SITCONFIRMACAODEST = 4
CODIGO = 71118
CODFILIAL = '2'
----------------------------------
Timestamp: 14:43:38.785
Successful commit.
----------------------------------
Timestamp: 14:43:53.712
SELECT DFSEQ_IDREMESSAMANIF.NEXTVAL AS VALOR
FROM DUAL
----------------------------------
Timestamp: 14:43:53.743
UPDATE PCMANIFDESTINATARIO SET 
IDREMESSADOWNLOAD = :IDREMESSA, 
CODSTATUSDOWNLOAD = NULL, 
DESCSTATUSDOWNLOAD = NULL 
WHERE CODIGO IN (71118)
IDREMESSA = 17096
----------------------------------
Timestamp: 14:43:53.780
Successful commit.
----------------------------------
Timestamp: 14:43:53.867
SELECT CODIGO, 
       TO_NUMBER(SUBSTR(CHAVENFE, 26, 9)) NUMNOTA,
       SUBSTR(CHAVENFE, 23, 3) SERIE,
       DATAEMISSAO,
       CNPJCPF, 
       NOME AS FORNECEDOR,
       SITCONFIRMACAODEST,
       DECODE(SITCONFIRMACAODEST,
              0,
              'SEM MANIFESTAÇÃO',
              1,
              'CONFIRMAÇÃO DA OPERAÇÃO',
              2,
              'DESCONHECIMENTO DA OPERAÇÃO',
              3,
              'OPERAÇÃO NÃO REALIZADA',
              4,
              'CIÊNCIA DA OPERAÇÃO') AS SITUACAOMANIF,
              
       CASE WHEN NVL(CODSTATUSDOWNLOAD, -1) = -1 THEN
             -1        
            WHEN NVL(CODSTATUSDOWNLOAD, -1) = 140 THEN
             0
       ELSE
             1
       END AS STATUS,            
       --DECODE(NVL(CODSTATUSDOWNLOAD, -1), 140, 0, 1) AS STATUS,
       CHAVENFE,
       CODSTATUSDOWNLOAD AS CODSTATUS,
       DESCSTATUSDOWNLOAD AS DESCSTATUS
FROM PCMANIFDESTINATARIO
WHERE IDREMESSADOWNLOAD = :IDREMESSA
IDREMESSA = 17096
----------------------------------
Timestamp: 14:43:53.895
Successful commit.
----------------------------------
Timestamp: 14:43:54.932

SELECT 'HTTP://'|| PARAMFILIAL.OBTERCOMOVARCHAR2('CON_IPNFE')||':'|| 
PARAMFILIAL.OBTERCOMOVARCHAR2('PORTADOCFISCAL') URL FROM DUAL----------------------------------
Timestamp: 14:43:56.439

SELECT '' TABLE_CATALOG, IC.TABLE_OWNER TABLE_SCHEMA, IC.TABLE_NAME, '' 
INDEX_CATALOG, IC.INDEX_OWNER INDEX_SCHEMA, IC.INDEX_NAME, IC.COLUMN_NAME, 
IC.COLUMN_POSITION, DECODE(IC.DESCEND, 'ASC', 0, 1) DESCENDING FROM 
SYS.ALL_IND_COLUMNS IC, SYS.ALL_INDEXES I, SYS.ALL_CONSTRAINTS C WHERE 
IC.TABLE_OWNER = 'FRIOBOM' AND IC.TABLE_NAME = 'PCMANIFDESTINATARIO' AND 
I.UNIQUENESS = 'UNIQUE' AND        I.OWNER = IC.INDEX_OWNER AND I.INDEX_NAME = 
IC.INDEX_NAME AND       C.TABLE_NAME (+) = IC.TABLE_NAME AND C.INDEX_NAME (+) = 
IC.INDEX_NAME AND C.OWNER (+)= IC.TABLE_OWNER ORDER BY DECODE(IC.INDEX_OWNER, 
'FRIOBOM', 0, 'PUBLIC', 1, 2), DECODE(C.CONSTRAINT_TYPE, 'P', 1, 'U', 2, 3), 
IC.INDEX_OWNER, IC.TABLE_OWNER, IC.TABLE_NAME, IC.INDEX_NAME, IC.COLUMN_POSITION----------------------------------
Timestamp: 14:43:56.464
SELECT CODIGO, 
       TO_NUMBER(SUBSTR(CHAVENFE, 26, 9)) NUMNOTA,
       SUBSTR(CHAVENFE, 23, 3) SERIE,
       DATAEMISSAO,
       CNPJCPF, 
       NOME AS FORNECEDOR,
       SITCONFIRMACAODEST,
       DECODE(SITCONFIRMACAODEST,
              0,
              'SEM MANIFESTAÇÃO',
              1,
              'CONFIRMAÇÃO DA OPERAÇÃO',
              2,
              'DESCONHECIMENTO DA OPERAÇÃO',
              3,
              'OPERAÇÃO NÃO REALIZADA',
              4,
              'CIÊNCIA DA OPERAÇÃO') AS SITUACAOMANIF,
              
       CASE WHEN NVL(CODSTATUSDOWNLOAD, -1) = -1 THEN
             -1        
            WHEN NVL(CODSTATUSDOWNLOAD, -1) = 140 THEN
             0
       ELSE
             1
       END AS STATUS,            
       --DECODE(NVL(CODSTATUSDOWNLOAD, -1), 140, 0, 1) AS STATUS,
       CHAVENFE,
       CODSTATUSDOWNLOAD AS CODSTATUS,
       DESCSTATUSDOWNLOAD AS DESCSTATUS
FROM PCMANIFDESTINATARIO
WHERE IDREMESSADOWNLOAD = :IDREMESSA
IDREMESSA = 17096