SELECT 
distinct(PCPRODUT.CODPROD) AS CodigoProduto,
--PCPRODUT.CODPROD AS CodigoProduto,  
PCProdut.codfornec as CodigoFornecedor, 
PCEST.CODFILIAL AS CodigoFilial,
PCTABPR.NUMREGIAO AS CodigoRegiao,
PCEST.CODDEVOL AS CodigoMotivoDevolucao,

CAST(ROUND(NVL(PCEST.CUSTOULTENT, 0),2) AS NUMERIC(18,6)) AS  CustoUltimaEntradaUnitario,
CAST(ROUND(NVL(PCEST.CUSTOREAL,0),2)AS NUMERIC(18,6)) AS CustoRealUnitario,
CAST(ROUND(NVL(PCEST.CUSTOFIN,0) ,2)AS NUMERIC(18,6)) AS CustoFinanceiroUnitario,
CAST(ROUND(NVL(PCEST.CUSTOCONT,0),2)AS NUMERIC(18,6)) AS CustoContabilUnitario,
CAST(ROUND(NVL(PCEST.CUSTOREP,0),2)AS NUMERIC(18,6)) AS CustoReposicaoUnitario,


CAST(ROUND(PCEST.QTESTGER,2)AS NUMERIC(18,6)) AS QuantidadeGerencial,
CAST(ROUND(PCEST.QTINDENIZ,2)AS NUMERIC(18,6)) AS QuantidadeAvaria, 
CAST(ROUND(PCEST.QTBLOQUEADA, 2)AS NUMERIC(18,6)) AS QuantidadeBloqueada,
CAST(ROUND(PCEST.QTRESERV,2)AS NUMERIC(18,6)) AS QuantidadeReservada, 
CAST(ROUND(PCEST.QTPEDIDA,2)AS NUMERIC(18,6)) AS QuantidadePedida, 
CAST(ROUND(PCEST.QTPENDENTE,2) AS NUMERIC(18,6)) AS QuantidadePendente, 


CAST(ROUND(PCEST.QTBLOQUEADA,2) as NUMERIC(18,6)) AS
QuantidadeBloqueioVenda,


PCEST.QTGIRODIA AS GiroDia,
CASE WHEN EXTRACT( YEAR FROM PCEST.DTULTENT) < 2010 OR PCEST.DTULTENT IS NULL THEN NULL ELSE 
TO_CHAR(TO_CHAR(TRUNC(PCEST.DTULTENT), 'YYYY-MM-DD')||' 00:00:00.000') END AS DataUltimaCompra,
CAST((CASE WHEN PCEST.DTULTENT IS NULL THEN 0 ELSE  ROUND(TRUNC(SYSDATE) - TRUNC(PCEST.DTULTENT), 0) END) AS NUMERIC(8,0) ) AS DiasSemCompra,
CASE WHEN EXTRACT( YEAR FROM PCEST.DTULTSAIDA) < 2010 OR PCEST.DTULTSAIDA IS NULL THEN NULL ELSE 
TO_CHAR(TO_CHAR(TRUNC(PCEST.DTULTSAIDA), 'YYYY-MM-DD')||' 00:00:00.000')END  AS DataUltimaVenda,
CAST((CASE WHEN PCEST.DTULTSAIDA IS NULL THEN 0 ELSE  ROUND(TRUNC(SYSDATE) - TRUNC(PCEST.DTULTSAIDA), 0) END) AS NUMERIC(8,0) ) AS DiasSemVenda,


CAST(
CASE                                                                                   
   WHEN PC.VALOR = 'S' THEN                                                           
                                                          
        (SELECT ROUND(NVL(PCEMBALAGEM.PVENDA, 0),2)                                           
          FROM PCEMBALAGEM                                                              
          WHERE PCEMBALAGEM.CODFILIAL = PCEST.CODFILIAL                                 
          AND (PCEMBALAGEM.CODPROD = PCEST.CODPROD)                                     
          AND PCEMBALAGEM.QTUNIT = 1                                                    
          AND ROWNUM = 1)                                                             
   ELSE                                                                                                                         
         ROUND(NVL(PCTABPR.PVENDA, 0) ,2)                                              
                                      
 END AS NUMERIC(18,6)) AS ValorVendaUnitario, 


PCPRODUT.PESOBRUTO AS PesoBrutoUnitario,
PCPRODUT.PESOLIQ AS PesoLiquidoUnitario, 
CAST(PCPRODUT.VOLUME AS NUMERIC(18,6))  AS VolumeUnitario,
CAST(ROUND(PCPRODUT.QTUNIT, 2)AS NUMERIC(18,6)) AS QuantidadeUnitaria,
CAST(ROUND(PCPRODUT.QTUNITCX, 2)AS NUMERIC(18,6)) AS QuantidadeUnitariaCaixa, 


CAST( NVL(PCFORNEC.PRAZOENTREGA, 0) AS NUMERIC(18,6)) AS PrazoEntrega,
CAST( NVL(PCPRODUT.TEMREPOS, 0) AS NUMERIC(18,6)) AS 
TempoReposicao

 
 FROM                                                                 
  PCPRODUT,
  PCEST,                                                     
  PCFORNEC,                                                          
  PCMARCA,                                                           
  PCLINHAPROD,                                                       
  PCDEPTO,                                                           
  PCSECAO,                                                           
  PCCONSUM,                                                          
  (SELECT CODFILIAL, VALOR                                           
   FROM PCPARAMFILIAL                                                
   WHERE NOME = 'FIL_PRECOPOREMBALAGEM') PC,
   
   PCTABPR,
   
   (SELECT DISTINCT(VALOR)
    FROM  PCPARAMFILIAL
    where NOME = 'FIL_NUMREGIAOPADRAO') RP
                            
WHERE   PCTABPR.CODPROD    = PCPRODUT.CODPROD                                                                
  AND PCPRODUT.CODPROD  = PCEST.CODPROD 
  --AND PCPRODUT.CODPROD  = 197                                  
  AND PCPRODUT.CODMARCA = PCMARCA.CODMARCA(+)                        
  AND PCPRODUT.CODLINHAPROD = PCLINHAPROD.CODLINHA(+)                
 
 AND PCPRODUT.DTEXCLUSAO IS NULL 
  AND PCEST.CODFILIAL = PC.CODFILIAL
  AND PCEST.CODFILIAL = 2                                                           
  AND PCPRODUT.CODEPTO = PCDEPTO.CODEPTO                                                       
  AND PCPRODUT.CODSEC = PCSECAO.CODSEC(+)                                                      
  AND NVL(PCDEPTO.TIPOMERC, 'XX') NOT IN ('IM','CI')                                     
  AND PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC
  
  AND PCTABPR.NUMREGIAO IN RP.VALOR
  and pctabpr.numregiao = 1
--  and pcprodut.codfornec = 1360