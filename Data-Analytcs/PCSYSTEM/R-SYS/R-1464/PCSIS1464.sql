SELECT 

VENDAS.codusur
, VENDAS.NOME
, VENDAS.CODMARCA 
, VENDAS.MARCA 
--, COUNT(DISTINCT(VENDAS.CODCLI)) AS "QTCLIATIVOS"
--, VENDAS.QTCLIPOS AS "QTCLIPOS"
--, VENDAS.QTCLIPOS/COUNT(DISTINCT(VENDAS.CODCLI)) AS "% PosiCarteira"
, sum(VENDAS.VLVENDA) AS "VL.Faturado"
, sum(VENDAS.TOTPESO) AS "PESO (Kg)"
, sum(VENDAS.VOLUME) AS "VOLUME (m°)"
, sum(VENDAS.LITRAGEM) AS "VOLUME (L)"
 FROM (  SELECT PCNFSAID.NUMTRANSVENDA, PCMOV.CODCLI,
       PCCLIENT.CLIENTE,
       PCFORNEC.CODFORNECPRINC,
     PCFORNEC.FORNECEDOR,
       PCFORNEC.CODFORNEC,
 PCNFSAID.CODUSUR  CODUSUR, 
       PCUSUARI.NOME, 
 NVL(PCNFSAID.CODSUPERVISOR,PCSUPERV.CODSUPERVISOR)  CODSUPERVISOR, 
       PCSUPERV.NOME SUPERV, 
       PCPRODUT.CODEPTO, 
       PCPRODUT.CODSEC, 
       PCDEPTO.DESCRICAO DEPARTAMENTO, 
       PCSECAO.DESCRICAO SECAO, 
       PCNFSAID.CODPRACA, 
       PCPRACA.PRACA, 
       PCPRODUT.CODMARCA, 
       PCMARCA.MARCA, 
       PCCLIENT.ESTENT, 
       PCCLIENT.MUNICENT,
       PCCLIENT.CODCIDADE,
       PCCIDADE.NOMECIDADE,
       NVL(PCCLIENT.CODCLIPRINC, PCCLIENT.CODCLI) CODCLIPRINC, 
       (SELECT X.CLIENTE 
          FROM PCCLIENT X 
         WHERE X.CODCLI = NVL(PCCLIENT.CODCLIPRINC, PCCLIENT.CODCLI)) CLIENTEPRINC, 
       ROUND( (NVL(PCPRODUT.VOLUME, 0) * NVL(PCMOV.QT, 0)),2)  VOLUME, 
      (NVL(PCPRODUT.LITRAGEM, 0) * NVL(PCMOV.QT, 0))  LITRAGEM, 
       PCATIVI.RAMO,
       PCATIVI.CODATIV,
       PCMOV.CODPROD,
       PCPRODUT.DESCRICAO,
       PCPRODUT.EMBALAGEM,
       PCPRODUT.UNIDADE,
       PCPRODUT.CODFAB,
       PCNFSAID.CODPLPAG,
       PCNFSAID.NUMPED,
       PCNFSAID.CODCOB,
       PCCLIENT.CODPLPAG CODPLANOCLI,
       PCPLPAG.DESCRICAO DESCRICAOPCPLPAG,
       PCPLPAG.NUMDIAS, 
       0 QTMETA,
       0 QTPESOMETA,
       0 MIXPREV,
       0 CLIPOSPREV,
       ROUND((DECODE(PCMOV.CODOPER,  
                     'SB',         
                     PCMOV.QTCONT,   
                     0)) *           
       NVL(PCMOV.VLREPASSE, 0),      
       2) VLREPASSEBNF,              
         ROUND((NVL(PCMOV.QT, 0) * 
         DECODE(PCNFSAID.CONDVENDA,
                 5,
                 0,
                 6,
                 0,
                 11,
                 0,
                 12,
                 0,
                 DECODE(PCMOV.CODOPER,'SB',0,nvl(pcmov.VLIPI,0)))),2) VALORIPI,
                 0 VALORIPIX,
         ROUND(NVL(PCMOV.QT, 0) * 
         DECODE(PCNFSAID.CONDVENDA,
                 5,
                 0,
                 6,
                 0,
                 11,
                 0,
                 12,
                 0,
                 DECODE(PCMOV.CODOPER,'SB',0,(nvl(pcmov.ST,0)+NVL(PCMOVCOMPLE.VLSTTRANSFCD,0)))),2) VALORST,
                 0 VALORSTX,
         (SELECT PCCLIENT.CODPLPAG || ' - ' || PCPLPAG.DESCRICAO  FROM PCPLPAG WHERE PCCLIENT.CODPLPAG = PCPLPAG.CODPLPAG) 
DESCRICAOPLANOCLI,
       ((DECODE(PCMOV.CODOPER,  
                           'S', 
                           (NVL(DECODE(PCNFSAID.CONDVENDA, 
                                       7, 
                                       PCMOV.QTCONT, 
                                       PCMOV.QT), 
                                0)), 
                           'SM', 
                           (NVL(DECODE(PCNFSAID.CONDVENDA, 
                                       7, 
                                       PCMOV.QTCONT, 
                                       PCMOV.QT), 
                                0)), 
                           'ST', 
                           (NVL(DECODE(PCNFSAID.CONDVENDA, 
                                       7, 
                                       PCMOV.QTCONT, 
                                       PCMOV.QT), 
                                0)), 
                           'SB', 
                           (NVL(DECODE(PCNFSAID.CONDVENDA, 
                                       7, 
                                       PCMOV.QTCONT, 
                                       PCMOV.QT), 
                                0)), 
                           0))) QTVENDA, 
                  ((DECODE(PCMOV.CODOPER                                
                          ,'S'                                        
                          ,(NVL(DECODE(PCNFSAID.CONDVENDA,              
                                       7,                               
                                       PCMOV.QTCONT,                    
                                       PCMOV.QT),                       
                                0))                                     
                          ,'ST'                                       
                          ,(NVL(DECODE(PCNFSAID.CONDVENDA,              
                                       7,                               
                                       PCMOV.QTCONT,                    
                                       PCMOV.QT),                       
                                0))                                     
                          ,'SM'                                       
                          ,(NVL(DECODE(PCNFSAID.CONDVENDA,              
                                       7,                               
                                       PCMOV.QTCONT,                    
                                       PCMOV.QT),                       
                                0))                                     
                          ,'SB'                                       
                          ,(NVL(DECODE(PCNFSAID.CONDVENDA,              
                                       7,                               
                                       PCMOV.QTCONT,                    
                                       PCMOV.QT),                       
                                0))                                     
                          ,0)) * (NVL(PCMOV.CUSTOFIN, 0)   
                          )) VLCUSTOFIN,  
 CASE WHEN NVL(PCMOVCOMPLE.VLSUBTOTITEM,0) <> 0 THEN  
  DECODE(NVL(PCMOV.TIPOITEM,'N'),'C',0,NVL(PCMOVCOMPLE.VLSUBTOTITEM,0)) - 
       (  ROUND((NVL(PCMOV.QT, 0) * 
         DECODE(PCNFSAID.CONDVENDA,
                 5,
                 0,
                 6,
                 0,
                 11,
                 0,
                 12,
                 0,
                 DECODE(PCMOV.CODOPER,'SB',0,nvl(pcmov.VLIPI,0)))),2)) -  
       (  ROUND(NVL(PCMOV.QT, 0) * 
         DECODE(PCNFSAID.CONDVENDA,
                 5,
                 0,
                 6,
                 0,
                 11,
                 0,
                 12,
                 0,
                 DECODE(PCMOV.CODOPER,'SB',0,nvl(pcmov.ST,0))),2)) 
 ELSE                                                
       ROUND((((DECODE(PCMOV.CODOPER,                                           
                       'S',                                                   
                       (NVL(DECODE(PCNFSAID.CONDVENDA,                          
                                   7,                                           
                                   PCMOV.QTCONT,                                
                                   PCMOV.QT),                                   
                            0)),                                                
                       'ST',                                                  
                       (NVL(DECODE(PCNFSAID.CONDVENDA,                          
                                   7,                                           
                                   PCMOV.QTCONT,                                
                                   PCMOV.QT),                                   
                            0)),                                                
                       'SM',                                                  
                       (NVL(DECODE(PCNFSAID.CONDVENDA,                          
                                   7,                                           
                                   PCMOV.QTCONT,                                
                                   PCMOV.QT),                                   
                            0)),                                                
                       0)) *                                                    
             (NVL(DECODE(PCNFSAID.CONDVENDA,                                    
                           7,                                                   
                           (NVL(PUNITCONT, 0) - NVL(PCMOV.VLIPI, 0) -           
                           (nvl(pcmov.ST,0)+NVL(PCMOVCOMPLE.VLSTTRANSFCD,0))) + NVL(PCMOV.VLFRETE, 0) +          
                           NVL(PCMOV.VLOUTRASDESP, 0) +                         
                           NVL(PCMOV.VLFRETE_RATEIO, 0) +                       
                           DECODE(PCMOV.TIPOITEM,                               
                                  'C',                                        
                                  (SELECT NVL((SUM(M.QTCONT *                   
                                                   NVL(M.VLOUTROS, 0)) /        
                                          PCMOV.QT), 0) VLOUTROS                
                                     FROM PCMOV M                               
                                    WHERE M.NUMTRANSVENDA =                     
                                          PCMOV.NUMTRANSVENDA                   
                                      AND M.TIPOITEM = 'I'                    
                                      AND CODPRODPRINC = PCMOV.CODPROD),        
 'I', NVL(PCMOV.VLOUTROS, 0),DECODE(NVL(PCNFSAID.SOMAREPASSEOUTRASDESPNF,'N'),'N',NVL((PCMOV.VLOUTROS), 0),'S',
NVL((PCMOV.VLOUTROS-PCMOV.VLREPASSE), 0)))
                           ,(NVL(PCMOV.PUNIT, 0) - NVL(PCMOV.VLIPI, 0) -         
                           (nvl(pcmov.ST,0)+NVL(PCMOVCOMPLE.VLSTTRANSFCD,0))) + NVL(PCMOV.VLFRETE, 0) +          
                           NVL(PCMOV.VLOUTRASDESP, 0) +                         
                           NVL(PCMOV.VLFRETE_RATEIO, 0) +                       
                           DECODE(PCMOV.TIPOITEM,                               
                                  'C',                                        
                                  (SELECT NVL((SUM(M.QTCONT *                   
                                                   NVL(M.VLOUTROS, 0)) /        
                                          PCMOV.QT), 0) VLOUTROS                
                                     FROM PCMOV M                               
                                    WHERE M.NUMTRANSVENDA =                     
                                          PCMOV.NUMTRANSVENDA                   
                                      AND M.TIPOITEM = 'I'                    
                                      AND CODPRODPRINC = PCMOV.CODPROD),        
 'I', NVL(PCMOV.VLOUTROS, 0), DECODE(NVL(PCNFSAID.SOMAREPASSEOUTRASDESPNF,'N'),'N',NVL((PCMOV.VLOUTROS), 0),'S',
NVL((PCMOV.VLOUTROS-PCMOV.VLREPASSE), 0)))
                    ),0)))),                                                    
             2) END AS VLVENDA,                                                 
                                                                                
       (((DECODE(PCMOV.CODOPER,                                                 
                 'S',                                                         
                 (NVL(DECODE(PCNFSAID.CONDVENDA, 7, PCMOV.QTCONT, PCMOV.QT),    
                      0)),                                                      
                 'ST',                                                        
                 (NVL(DECODE(PCNFSAID.CONDVENDA, 7, PCMOV.QTCONT, PCMOV.QT),    
                      0)),                                                      
                 'SM',                                                        
                 (NVL(DECODE(PCNFSAID.CONDVENDA, 7, PCMOV.QTCONT, PCMOV.QT),    
                      0)),                                                      
                 0)) *                                                          
       (NVL(DECODE(PCNFSAID.CONDVENDA,                                          
                     7,                                                         
                     PCMOV.PUNITCONT,                                           
                     NVL(PCMOV.PUNIT, 0) + NVL(PCMOV.VLFRETE, 0) +              
                     NVL(PCMOV.VLOUTRASDESP, 0) +                               
                     NVL(PCMOV.VLFRETE_RATEIO, 0) +                             
                     DECODE(PCMOV.TIPOITEM,                                     
                            'C',                                              
                            (SELECT (SUM(M.QTCONT * NVL(M.VLOUTROS, 0)) /       
                                    PCMOV.QT) VLOUTROS                          
                               FROM PCMOV M                                     
                              WHERE M.NUMTRANSVENDA = PCMOV.NUMTRANSVENDA       
                                AND M.TIPOITEM = 'I'                          
                                AND CODPRODPRINC = PCMOV.CODPROD),              
 'I', NVL(PCMOV.VLOUTROS, 0), DECODE(NVL(PCNFSAID.SOMAREPASSEOUTRASDESPNF,'N'),'N',NVL((PCMOV.VLOUTROS), 0),'S',
NVL((PCMOV.VLOUTROS-PCMOV.VLREPASSE), 0)))
                      - (nvl(pcmov.ST,0)+NVL(PCMOVCOMPLE.VLSTTRANSFCD,0))),               
              0)))) VLVENDA_SEMST,                                              
      ROUND(    (NVL(PCMOV.QT, 0) *(
       DECODE(PCNFSAID.CONDVENDA,
               5,
               DECODE(PCMOV.PBONIFIC, NULL, PCMOV.PTABELA, PCMOV.PBONIFIC)
               ,6,
               DECODE(PCMOV.PBONIFIC, NULL, PCMOV.PTABELA, PCMOV.PBONIFIC),
               11,
               DECODE(PCMOV.PBONIFIC, NULL, PCMOV.PTABELA, PCMOV.PBONIFIC),
               1,
               NVL(PCMOV.PBONIFIC,0),                                      
               14,
               NVL(PCMOV.PBONIFIC,0),                                      
               12,
               DECODE(PCMOV.PBONIFIC, NULL, PCMOV.PTABELA, PCMOV.PBONIFIC),
               0)) 
),2) VLBONIFIC,
               ((DECODE(PCMOV.CODOPER,
                           'S',
                           (NVL(DECODE(PCNFSAID.CONDVENDA,
                                       7,
                                       PCMOV.QTCONT,
                                       PCMOV.QT),
                                0)),
                           'ST',
                           (NVL(DECODE(PCNFSAID.CONDVENDA,
                                       7,
                                       PCMOV.QTCONT,
                                       PCMOV.QT),
                                0)),
                           'SM',
                           (NVL(DECODE(PCNFSAID.CONDVENDA,
                                       7,
                                       PCMOV.QTCONT,
                                       PCMOV.QT),
                                0)),
                           0))) QTVENDIDA,
       ROUND( (NVL(PCPRODUT.PESOBRUTO,PCMOV.PESOBRUTO) * NVL(PCMOV.QT, 0)),2) AS TOTPESO,
       ROUND(PCMOV.QT * (PCMOV.PTABELA
                       + NVL (pcmov.vlfrete, 0) + NVL (pcmov.vloutrasdesp, 0) + NVL (pcmov.vlfrete_rateio, 0) + NVL 
(pcmov.vloutros, 0) 
  ),2) VLTABELA,
       PCMOV.CODCLI QTCLIPOS,
       PCNFSAID.NUMTRANSVENDA QTNUMTRANSVENDA, 
       PCNFSAID.CODFILIAL, 
      (SELECT PCFILIAL.FANTASIA 
              FROM PCNFSAID P, PCFILIAL  
             WHERE P.CODFILIAL = PCFILIAL.CODIGO 
               AND P.NUMTRANSVENDA = PCNFSAID.NUMTRANSVENDA  AND ROWNUM = 1) FILIAL,
       PCPRODUT.CODPROD AS QTMIXCAD,
       PCMOV.CODPROD AS QTMIX, 
   (SELECT COUNT(*) FROM PCPRODUT P
WHERE P.CODFORNEC = PCFORNEC.CODFORNEC AND NVL(P.REVENDA,'S')  = 'S' ) QTMIXCADNOVO,
 PCGERENTE.NOMEGERENTE,
 DECODE(PCNFSAID.NUMTRANSVENDA,NULL,PCSUPERV.CODGERENTE,PCNFSAID.CODGERENTE) CODGERENTE, 
 PCPRACA.ROTA,
 PCROTAEXP.DESCRICAO DESCROTA,
               (NVL(PCMOV.VLREPASSE,0) * DECODE(PCNFSAID.CONDVENDA,
              5,0,6,0,11,0,12,0,DECODE(PCMOV.CODOPER,'SB',0,NVL(PCMOV.QT, 0)) ))  AS VLREPASSE,
 PCPRODUT.CODAUXILIAR
  FROM PCNFSAID,
       PCPRODUT,
       PCMOV,
       PCCLIENT,
       PCUSUARI,
       PCSUPERV,
       PCPLPAG,
       PCFORNEC,
       PCATIVI, 
       PCPRACA,
       PCDEPTO,
       PCSECAO,
       PCPEDC,
       PCGERENTE,
       PCCIDADE,
       PCMARCA,
       PCROTAEXP,
       PCMOVCOMPLE
 WHERE PCMOV.NUMTRANSVENDA = PCNFSAID.NUMTRANSVENDA
   AND PCMOV.DTMOV BETWEEN  TO_DATE('01/11/2023', 'DD/MM/YYYY') AND 
                                 TO_DATE('30/11/2023', 'DD/MM/YYYY') 
   AND PCMOV.CODPROD = PCPRODUT.CODPROD
   AND PCNFSAID.CODPRACA = PCPRACA.CODPRACA(+)
   AND PCATIVI.CODATIV(+) = PCCLIENT.CODATV1
   AND PCMOV.CODCLI = PCCLIENT.CODCLI
   AND PCFORNEC.CODFORNEC = PCPRODUT.CODFORNEC
   AND  PCNFSAID.CODUSUR   = PCUSUARI.CODUSUR 
   AND PCPRACA.ROTA = PCROTAEXP.CODROTA(+)
   AND PCMOV.NUMTRANSITEM = PCMOVCOMPLE.NUMTRANSITEM(+)
   AND PCPRODUT.CODMARCA = PCMARCA.CODMARCA(+)
   AND PCCLIENT.CODCIDADE = PCCIDADE.CODCIDADE(+)
  AND PCMOV.CODOPER <> 'SR' 
  AND NVL(PCNFSAID.TIPOVENDA,'X') NOT IN ('SR', 'DF')
  AND PCMOV.CODOPER <> 'SO' 
   AND  NVL(PCNFSAID.CODSUPERVISOR,PCSUPERV.CODSUPERVISOR)   = PCSUPERV.CODSUPERVISOR
   AND PCNFSAID.CODPLPAG = PCPLPAG.CODPLPAG
   AND PCNFSAID.NUMPED = PCPEDC.NUMPED(+)
   AND PCPRODUT.CODEPTO = PCDEPTO.CODEPTO(+)
   AND PCPRODUT.CODSEC = PCSECAO.CODSEC(+)
   AND PCNFSAID.CODGERENTE = PCGERENTE.CODGERENTE(+) 
   AND PCNFSAID.CODFISCAL NOT IN (522, 622, 722, 532, 632, 732)
   AND PCNFSAID.CONDVENDA NOT IN (4, 8, 10, 13, 20, 98, 99)
   AND (PCNFSAID.DTCANCEL IS NULL)
   AND (PCPRODUT.CODFORNEC IN ( 3395,3420,3663 )) 
   AND PCNFSAID.DTSAIDA BETWEEN  TO_DATE('01/11/2023', 'DD/MM/YYYY') AND 
                                 TO_DATE('30/11/2023', 'DD/MM/YYYY') 
           AND PCMOV.CODFILIAL IN('2')
           AND PCNFSAID.CODFILIAL IN('2')
           AND PCMOV.DTMOV >= (SELECT MIN(DTMOV) FROM PCMOV)
 		       AND PCPEDC.NUMPED >= (SELECT MIN(NUMPED) FROM PCPEDC)
 		       AND PCPEDC.DATA >= (SELECT MIN(DATA) FROM PCPEDC)
 		       AND PCNFSAID.DTSAIDA >= (SELECT MIN(DTSAIDA) FROM PCNFSAID)
) VENDAS

where VENDAS.codusur in (:codRCA)
Group By 
VENDAS.codusur
, VENDAS.NOME
, VENDAS.CODMARCA 
, VENDAS.MARCA 