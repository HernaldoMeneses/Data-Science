/*
COMPOSIÇÃO DA COMISSÃO DOS REPRESENTANTES E SUPERVISORES;
---COMISSÃO DEPENDE DO TIPO DE RCA (VAREJO OU REDE)
*/
-- if P_OPCAO = 1 then --- RETORNA A LIQUEDEZ DO RCA

SELECT  TAB1.CODUSUR,
        TAB1.RCA RCA,
        TAB1.VALOR VALOR,
        TAB1.VALORCOMISSAO
     FROM (SELECT NVL(G.VALORCOMISSAO, 0) VALORCOMISSAOARECEBER,                             
            (T.VALORCOMISSAO-T.VALES-DECODE('N','S',T.VALORESTORNO,0)) COMISSAOLIQUIDA,
            ROUND(CASE WHEN NVL(T.VALOR,0)>0 THEN
            T.VALORCOMISSAO/T.VALOR*100                                                       
            ELSE 0                                                                            
            END,4) PERCOM                                                                     
            , T.*                                                                             
            FROM (SELECT COUNT(PCPREST.NUMTRANSVENDA || PCPREST.PREST) QTTITULOS,             
              PCUSUARI.CODUSUR,                                                    
              PCUSUARI.PERCENT,                                                    
              PCUSUARI.PERCENT2,                                                   
              PCUSUARI.NOME RCA,                                                       
              PCUSUARI.TIPOVEND,                                                   
              PCUSUARI.EMAIL,                                                      
              PCUSUARI.CGC,                                                        
              PCUSUARI.BLOQCOMIS,                                                  
              PCUSUARI.NUMBANCO,                                                   
              PCUSUARI.NUMAGENCIA,                                                 
              PCUSUARI.NUMCCORRENTE,                                               
              PCUSUARI.NUMDVCCORRENTE,                                             
              PCUSUARI.INDICERATEIOCOMISSAO,                                       
              PCSUPERV.CODSUPERVISOR,                                              
              PCSUPERV.NOME AS NOMESUPERVISOR,                                     
              --------------VALOR COMISSÃO POR NOTA OU POR TITULO------------------
              ROUND(SUM(NVL(DECODE('P',                                    
                          'P',                                                    
                          DECODE('NF',                                     
                                 'NF',                                            
                        PCPREST.VALOR *(PCNFSAID.COMISSAO/DECODE(NVL(PCNFSAID.VLTOTGER,0),0,1,PCNFSAID.VLTOTGER)),
                        PCPREST.VALOR * NVL(PCPREST.PERCOM,0) /100 ),                                           
                 ----------COMISSAO POR RCA-------------                          
                 ROUND((PCPREST.VALOR * NVL(DECODE(PCNFSAID.TIPOVENDA,        
                                                             'VV',              
                                                             PCUSUARI.PERCENT,    
                                                             PCUSUARI.PERCENT2),  
                                                      0) / 100),                  
                       2)                                                         
                                                                                  
                       ),0)),2)                                                   
                                                                                  
             VALORCOMISSAO,                                                       
             ---------------------VALES--------------------                       
             NVL((SELECT SUM(DECODE(TIPOLANC, 'D', VALOR, VALOR * -1))          
                 FROM PCCORREN C1                                                 
                 WHERE C1.CODFUNC = PCUSUARI.CODUSUR                              
                 AND C1.TIPOFUNC = 'R'                                          
                 AND C1.CODFILIAL = 2                                 
                 ),0) VALES,                                                        
             -------------Retornar Devolução---------------------------           
             NVL((SELECT SUM(E.VLESTORNO)                                         
                 FROM PCCRECLI C, PCESTCOM E                                      
                 WHERE C.DTDESCONTO >= to_date('01/01/2024','dd/mm/yyyy')
                 --C.DTDESCONTO BETWEEN P_DATA_INI AND P_DATA_FIM                
                 AND C.CODFILIAL = 2                                     
                 AND C.NUMTRANSENTDEVCLI IS NOT NULL                              
                 AND C.NUMTRANSENTDEVCLI = E.NUMTRANSENT                          
                 AND E.CODUSUR = PCUSUARI.CODUSUR),                               
                 0) VALORESTORNO,                                                 
             ------------------------------                                       
             ROUND(NVL(SUM(
                         PCNFSAID.VLTOTGER - (PCNFSAID.ICMSRETIDO + PCNFSAID.VLOUTRASDESP)),        
                       0),                                                        
                   0) VLTOTGERSEMSTVLOUTRASDESP,                                  
             ROUND(NVL(SUM(PCNFSAID.COMISSAO /                                    
                           DECODE((PCNFSAID.VLTOTGER -                            
                                  (PCNFSAID.ICMSRETIDO +                          
                                  PCNFSAID.VLOUTRASDESP)),                        
                                  0,                                              
                                  1,                                              
                                  (PCNFSAID.VLTOTGER - (PCNFSAID.ICMSRETIDO +     
                                  PCNFSAID.VLOUTRASDESP)))),                      
                       0) * 100,                                                  
                   2) PERCOMSEMSTVLOUTRASDESP,                                    
             ROUND(SUM(PCNFSAID.VLTOTGER * (NVL(PCUSUARI.PERCENT, 0) / 100)),     
                   2) AS VLCOMISSAORCA,                                           
             ROUND(SUM(PCNFSAID.VLTOTGER * (NVL(PCUSUARI.PERCENT2, 0) / 100)),    
                   2) AS VLCOMISSAORCA2,                                          
SUM(PCPREST.VALOR) VALOR 
      FROM PCPREST, PCNFSAID, PCUSUARI, PCSUPERV, PCCLIENT, PCCOB                 
      WHERE PCPREST.NUMTRANSVENDA = PCNFSAID.NUMTRANSVENDA                        
      AND PCPREST.CODUSUR = PCUSUARI.CODUSUR(+)                                   
      AND PCPREST.DTPAG IS NOT NULL                                               
      AND PCPREST.CODCOB = PCCOB.CODCOB                                           
      AND PCCOB.PAGCOMISSAO = 'S'                                               
      AND PCPREST.CODCOB NOT IN ('DESD', 'DEVP', 'DEVT', 'BNF')           
      AND PCUSUARI.CODSUPERVISOR = PCSUPERV.CODSUPERVISOR                         
      AND PCNFSAID.CODFISCAL IN (511, 611, 512, 612, 711, 712)                    
      AND PCNFSAID.CONDVENDA <> 4                                                 
      AND PCPREST.CODCLI = PCCLIENT.CODCLI                                        
      AND PCNFSAID.DTCANCEL IS NULL                                               
      AND ((NVL(PCPREST.PERMITEESTORNO, 'S') = 'S') OR                        
            (((NVL(PCPREST.PERMITEESTORNO, 'S') = 'N') AND                    
            (PCPREST.DTESTORNO IS NOT NULL) AND                                   
            (NVL(PCPREST.VALORESTORNO, 0) < NVL(PCPREST.VPAGO, 0)))))             
      AND NVL(PCUSUARI.BLOQCOMIS, 'N') <> 'S'                                 
AND PCPREST.DTPAGCOMISSAO IS NULL
--AND PCPREST.Dtbaixa BETWEEN P_DATA_INI AND P_DATA_FIM
 and PCPREST.Dtbaixa >= to_date('01/01/2024','dd/mm/yyyy')
AND NVL(PCCOB.TIPOCOMISSAO,'A') IN ('L','A')
      AND (PCPREST.CODFILIAL = 2) 
      GROUP BY PCUSUARI.CODUSUR,                                                  
               PCUSUARI.NOME,                                                     
                                                                                  
                PCUSUARI.PERCENT,                                                 
             PCUSUARI.PERCENT2,                                                   
               PCUSUARI.TIPOVEND,                                                 
               PCUSUARI.EMAIL,                                                    
               PCUSUARI.CGC,                                                      
               PCUSUARI.BLOQCOMIS,                                                
               PCUSUARI.NUMBANCO,                                                 
               PCUSUARI.NUMAGENCIA,                                               
               PCUSUARI.NUMCCORRENTE,                                             
               PCUSUARI.NUMDVCCORRENTE,                                           
               PCUSUARI.INDICERATEIOCOMISSAO,                                     
               PCSUPERV.CODSUPERVISOR,                                            
               PCSUPERV.NOME) T,                                                  
     (SELECT U.CODUSUR,                                                           
             U.NOME,                                                              
             COUNT(DISTINCT(P.NUMTRANSVENDA || P.PREST)) QTDOC,                   
             SUM(P.VALOR) VALORARECEBER,                                          
             -----------------------------------                                  
              --------------VALOR COMISSÃO POR NOTA OU POR TITULO-----------------
             ROUND(SUM(NVL(DECODE('P',                                    
                        'P',                                                    
                        DECODE('NF',                                     
                               'NF',                                            
                               P.VALOR* decode(nvl(F.VLTOTGER,0),0,1,(F.COMISSAO/F.VLTOTGER))  
                               ,                                                  
                               (NVL(P.VALOR,0) *                                  
                                  NVL(P.PERCOM,0)                                 
                               /100 )),                                           
                 ----------COMISSAO POR RCA-------------                          
                 ROUND((F.VLTOTGER * NVL(DECODE(F.TIPOVENDA,                      
                                                             'VV',              
                                                             U.PERCENT,           
                                                             U.PERCENT2),         
                                                      0) / 100),                  
                       2)                                                         
                                                                                  
                       ),0)),2)                                                   
                                                                                  
             VALORCOMISSAO,                                                       
                                                                                  
                                                                                  
             ROUND((SUM((P.VALOR * ROUND(NVL(DECODE('P',                  
                                                    'P',                        
                                                    P.PERCOM,                     
                                                    U.PERCENT2),                  
                                             0),                                  
                                         2) / 100) / CASE                         
                          WHEN P.VALOR <= 0 THEN                                  
                           1                                                      
                          ELSE                                                    
                           P.VALOR                                                
                        END * 100)),                                              
                   2) PERCOMISSAO                                                 
                                                                                  
      FROM PCPREST  P,                                                            
           PCNFSAID F,                                                            
           PCCOB    B,                                                            
                                                                                  
           PCUSUARI U                                                             
      WHERE P.NUMTRANSVENDA = F.NUMTRANSVENDA                                     
      AND P.CODUSUR = U.CODUSUR                                                   
                                                                                  
      AND P.DTPAG IS NULL                                                         
      AND P.CODCOB = B.CODCOB                                                     
      AND NVL(B.PAGCOMISSAO, 'N') = 'S'                                       
      AND NVL(U.BLOQCOMIS, 'N') = 'N'                                         
      AND F.CODFISCAL IN (511, 611, 512, 612, 711, 712)                           
      AND F.CONDVENDA NOT IN (4)                                                  
AND NVL(B.TIPOCOMISSAO,'A') IN ('L','A')
           ---------------------------------------------------                    
      AND P.CODFILIAL = 2
      AND F.DTCANCEL IS NULL                                                      
      AND P.CODCOB NOT IN ('DESD', 'ESTR', 'DEVT', 'DEVP', 'BNF', 'CANC','CRED')
      GROUP BY U.CODUSUR, U.NOME) G                                               
WHERE T.CODUSUR = G.CODUSUR(+) 
 -- AND T.CODUSUR = P_RCA                                                   
ORDER BY T.CODSUPERVISOR, T.CODUSUR
) TAB1
      