WITH UNIDADE AS (                                                               
  SELECT PCPRODUT.ROWID RID                                                     
       , DECODE(NVL(PCPRODUT.QTUNITCX, 0), 0, 1, PCPRODUT.QTUNITCX) QTUNITCX    
       , DECODE(NVL(PCPRODUT.PESOBRUTO, 0), 0, 1, PCPRODUT.PESOBRUTO) PESOBRUTO 
    FROM PCPRODUT)                                                              
SELECT PCPRODUT.CODPROD

     /*   
     , PCPRODUT.DESCRICAO                                         
      , PCPRODUT.EMBALAGEM  

     , NVL(:DTINICIO, TRUNC(SYSDATE)) DTFALTAINICIO 
     , NVL(:DTFINAL, TRUNC(SYSDATE)) DTFALTAFINAL 

     , PCPRODUT.CODPRODPRINC                                       
     , PCPRODUT.FRETEESPECIAL                                      
     , PCPRODUT.CODMARCA MARCA                                     
     , PCMARCA.MARCA  NOMEMARCA                                    
     , NVL(PCPRODUT.PRECIFICESTRANGEIRA,'N') PRECIFICESTRANGEIRA 
     , 0 COTACAO 
     , PCPRODUT.DESCRICAO1                                         
     , PCPRODUT.DESCRICAO2                                         
     , PCPRODUT.DESCRICAO3                                         
     , PCPRODUT.DESCRICAO4                                         
     , PCPRODUT.DESCRICAO5                                         
     , PCPRODUT.DESCRICAO6                                         
     , PCPRODUT.DESCRICAO7                                         
     , PCPRODUT.NUMORIGINAL                                        
     , PCPRODUT.CODENDERECOAP                                      
     , PCPRODUT.CODENDERECOCX                                      
     , PCPRODUT.CODENDERECOAL                                      
     , PCPRODUT.ALTURAARM                                          
     , PCPRODUT.LARGURAARM                                         
     , PCPRODUT.COMPRIMENTOARM                                     
     , PCPRODUT.VOLUMEARM                                          
     , PCPRODUT.ALTURAM3                                           
     , PCPRODUT.LARGURAM3                                          
     , PCPRODUT.COMPRIMENTOM3                                      
     , PCPRODUT.TIPOPAL                                            
     , PCPRODUT.TIPOARM                                            
     , PCPRODUT.CODCARACPROD                                       
     , PCPRODUT.CODTIPOESTRUTURA                                   
     , PCPRODUT.RESTRICAOBLOCADO                                   
     , PCPRODUT.PONTOREPOSICAO                                     
     , PCPRODUT.TIPOPALPUL                                         
     , PCPRODUT.CODTIPOESTRUTURAPUL                                
     , PCPRODUT.DV 
       

     , PCFORNEC.BLOQUEIO                                           
     , PCFORNEC.DTBLOQUEIO                                         
     , PCFORNEC.OBS                                                
     , PCFORNEC.EMAIL 


     , PCPRODUT.CODFORNEC                                          
     , PCPRODUT.UNIDADE                                            
     , PCPRODUT.UNIDADEMASTER                                      
     , PCPRODUT.EMBALAGEM

     , PCPRODUT.EMBALAGEMMASTER                                    
     , DECODE(NVL(PCPRODFILIAL.ESTOQUEIDEAL,0),0,NVL(PCPRODUT.TEMREPOS,0),NVL(PCPRODFILIAL.ESTOQUEIDEAL,0)) TEMREPOS 
     
 
     , NVL(PCPRODUT.CUSTOREP, 0) CUSTOREP                       
     , PCFORNEC.REPRES                                            
     , PCFORNEC.TELREP                                            
     , NVL(PCFORNEC.PRAZOMIN,0) PRAZOMIN                          
     , nvl(PCPRODUT.PESOBRUTO, 0) PESOBRUTO                       
     , NVL(PCPRODUT.QTUNITCX, 1) QTUNITCX                         
     , NVL(PCPRODUT.PERCIPI, 0) PERCIPI                           
     , DECODE(PCPRODUT.OBS2, 'FL', 'FL', DECODE(NVL(PCPRODFILIAL.FORALINHA, 'N'), 'N','  ', 'FL')) OBS2   
     , NVL(PCPRODUT.PCOMREP1,0) PCOMREP1                          
     , PCFORNEC.TELFAB                                            
     , NVL(PCPRODFILIAL.QTTOTPAL,PCPRODUT.QTTOTPAL) QTTOTPAL      
     , PCPRODUT.CLASSE                                            
     , PCPRODUT.CODEPTO                                           
     , PCDEPTO.DESCRICAO DEPARTAMENTO                             
     , PCFORNEC.FORNECEDOR 


     , DECODE(NVL(PCFORNECFILIAL.PRAZOENTREGA, 0), 0, NVL(PCFORNEC.PRAZOENTREGA,0), PCFORNECFILIAL.PRAZOENTREGA) PRAZOENTREGA 
     

     , PCPRODUT.CODSEC                                            
     , PCPRODUT.CAPACIDADEPICKINGCX                               
     , PCPRODUT.CAPACIDADEPICKINGAL                               
     , NVL(PCPRODUT.PERICM, 0) PERICM                             
     , PCPRODUT.CODCATEGORIA                                      
     , PCPRODUT.CODSUBCATEGORIA                                   
     , PCCATEGORIA.CATEGORIA                                      
     , PCSUBCATEGORIA.SUBCATEGORIA                                
     , NVL(PCPRODUT.PRAZOVAL, 0) PRAZOVAL                         
     , PCSECAO.DESCRICAO SECAO                                    
     , PCFORNEC.PRAZO1                                            
     , PCFORNEC.PRAZO2                                            
     , PCFORNEC.PRAZO3                                            
     , PCFORNEC.PRAZO4                                            
     , PCFORNEC.PRAZO5                                            
     , PCFORNEC.PRAZO6                                            
     , NVL(PCFORNEC.PERCDESCFIN,0) PERCDESCFIN                    
     , NVL(PCFORNEC.PERCDESPFIN,0) PERCDESPFIN                    
     , NVL(PCTABPR.PFRETE, 0) PFRETE                              
     , PCPRODUT.DTULTALTCUSTOREP 

     , NVL(PCTABPR.MARGEM, 0) MARGEM                              
     , NVL(PCPRODUT.QTUNIT, 0) QTUNIT
                              
     , PCFORNEC.OBSERVACAO                              
     , NVL(PCTRIBUT.PERDESCCUSTO, 0) PERDESCCUSTO                 
     , NVL(PCTRIBUT.CODICMTAB, 0) CODICMTAB                       
     , NVL(PCREGIAO.VLFRETEKG, 0) VLFRETEKG                       
     , NVL(PERFRETETERCEIROS,0) PERFRETETERCEIROS                 
     , NVL(PERFRETEESPECIAL, 0) PERFRETEESPECIAL                  
     , PCPRODUT.CODAUXILIAR                                       
     , PCPRODUT.CLASSEVENDA                                       
     , PCPRODUT.DESTAQUEFICHATECNICA                              
     , PCPRODUT.PRECOFIXO                                         
     , PCPRODUT.CODFAB                                            
     , NVL(PCPRODUT.CUSTOREP, 0) ULTPCOMPRA                     
     , PCPRODUT.OBS AS OBS5                                       
    , CASE WHEN (PCFILIAL.USAWMS = 'S') AND (PCPRODUT.USAWMS = 'S')                         
          THEN (SELECT PCPRODUTPICKING.CAPACIDADE                                               
                  FROM PCPRODUTPICKING                                                          
                 WHERE PCPRODUTPICKING.CODPROD   = PCEST.CODPROD                      
                   AND PCPRODUTPICKING.CODFILIAL = FILIAL_ESTOQUEWMS(PCEST.CODFILIAL) 
                   AND PCPRODUTPICKING.TIPO      = 'V')                                       
          ELSE NVL(PCPRODUT.CAPACIDADEPICKING,0) END CAPACIDADEPICKING                                                       
     , NVL(PCPRODFILIAL.LASTROPAL,PCPRODUT.LASTROPAL) LASTROPAL   
     , NVL(PCPRODFILIAL.ALTURAPAL,PCPRODUT.ALTURAPAL) ALTURAPAL   
     , NVL(PCTABPR.PFRETE, 0) PFRETE                              
     , PCTABPR.DESCONTAFRETE                                      
     , NVL(PCPRODUT.PERCFRETE,0) PERCFRETECIF                     
     , NVL(PCPRODUT.PERCFRETEFOB,0) PERCFRETEFOB                  
     , PCEST.CODFILIAL 


     , NVL(PCEST.ESTMIN, 0) ESTMIN                                
     , NVL(PCEST.ESTMAX, 0) ESTMAX
                               
     , ( PCTABPR.PVENDA1
        ) as TABPRPVENDA1
     , ( PCTABPR.PVENDA1
        ) as TABPRPVENDA1CX
     , ( PCTABPR.PTABELA1
        ) as TABPRPTABELA1
     , ( PCTABPR.PTABELA1
        ) as TABPRPTABELA1CX
     , ( PCTABPR.PVENDAATAC1
        ) as TABPRPVENDAATAC1
     , ( PCTABPR.PVENDAATAC1
        ) as TABPRPVENDAATAC1CX
     , ( PCTABPR.PTABELAATAC1
        ) as TABPRPTABELAATAC1
     , ( PCTABPR.PTABELAATAC1
        ) as TABPRPTABELAATAC1CX
     , ( 0
        ) as QTMINGONDOLA
     , ( 0
        ) as QTMAXGONDOLA
     , ( PCTABPR.PVENDA
        ) as TABPRPVENDA
     , ( PCTABPR.PVENDA
        ) as TABPRPVENDACX
     , ( PCTABPR.PVENDAATAC
        ) as TABPRPVENDAATAC
     , ( PCTABPR.PVENDAATAC
        ) as TABPRPVENDAATACCX
     */
     
     , ((NVL(PCEST.QTVENDMES1, 0) + NVL(PCEST.QTVENDMES2, 0) + NVL(PCEST.QTVENDMES3, 0)) / :DIASUTEISTRIMESTRE) QTGIRODIA                                                  
     , ((NVL(PCEST.QTVENDMES1, 0) + NVL(PCEST.QTVENDMES2, 0) + NVL(PCEST.QTVENDMES3, 0)) / 3) QTGIROMES 

/*
     , ((NVL(PCEST.QTVENDMES,0) / :DIASUTEIS) * :TOTALDIASUTEIS) PROJECAOVENDAS 
     , :DIASUTEIS AS NDIASUTEISMES 
     , :TOTALDIASUTEIS AS NTOTALDIASUTEIS
     , (NVL(PCEST.QTGIRODIA, 0) * 7) QTGIROSEMANA
*/                  
     , NVL(PCEST.QTRESERV,   0) QTRESERV                           
     , NVL(PCEST.QTPENDENTE, 0) QTPENDENTE                          
     , NVL(PCEST.QTBLOQUEADA, 0) QTBLOQUEADA                          
     --, NVL(PCPRODUT.PTABELAFORNEC, 0) PTABELAFORNEC

     , NVL(PCEST.QTDEVOLMES,  0) QTDEVOLMES                          
     , NVL(PCEST.QTDEVOLMES1, 0) QTDEVOLMES1                         
     , NVL(PCEST.QTDEVOLMES2, 0) QTDEVOLMES2                         
     , NVL(PCEST.QTDEVOLMES3, 0) QTDEVOLMES3 

     --, PCFORNEC.TELEXREP 

     , NVL(PCEST.QTVENDMES,  0) QTVENDMES                          
     , NVL(PCEST.QTVENDMES1, 0) QTVENDMES1                         
     , NVL(PCEST.QTVENDMES2, 0) QTVENDMES2                         
     , NVL(PCEST.QTVENDMES3, 0) QTVENDMES3

/*
     , NVL(PCEST.QTDEVOLMES,  0) QTDEVOLMES                          
     , NVL(PCEST.QTDEVOLMES1, 0) QTDEVOLMES1                         
     , NVL(PCEST.QTDEVOLMES2, 0) QTDEVOLMES2                         
     , NVL(PCEST.QTDEVOLMES3, 0) QTDEVOLMES3

     , (NVL(PCEST.QTVENDMES, 0) * NVL(PCEST.CUSTOFIN,0)) VLVENDMES 
     , (NVL(PCEST.QTVENDMES1,0) * NVL(PCEST.CUSTOFIN,0)) VLVENDMES1
     , (NVL(PCEST.QTVENDMES2,0) * NVL(PCEST.CUSTOFIN,0)) VLVENDMES2
     , (NVL(PCEST.QTVENDMES3,0) * NVL(PCEST.CUSTOFIN,0)) VLVENDMES3

     , NVL(PCEST.QTVENDSEMANA, 0) QTVENDSEMANA                     
     , NVL(PCEST.QTVENDSEMANA1, 0) QTVENDSEMANA1                   
     , NVL(PCEST.QTVENDSEMANA2, 0) QTVENDSEMANA2                   
     , NVL(PCEST.QTVENDSEMANA3, 0) QTVENDSEMANA3
*/
     , PCEST.DTULTSAIDA                                            
     , PCEST.DTULTENT                                              
     --, NVL(PCEST.VLULTPCOMPRA, 0) VLULTPCOMPRA                       
     --, NVL(PCEST.VALORULTENT, 0) VALORULTENT                       
     , PCEST.QTULTENT                                              
     --, (NVL(PCEST.CUSTOULTENT, 0) / UNIDADE.PESOBRUTO) VLQUILOMEDTRANS 
     , NVL(PCEST.QTPEDIDA, 0) QTPEDIDA                             
     
/*     , NVL(PCEST.VLCUSTODIAFIN, 0) VLCUSTODIAFIN                   
     , NVL(PCEST.VLCUSTOMESFIN, 0) VLCUSTOMESFIN                   
  , NVL(PCEST.CUSTOREAL, 0) CUSTOREAL                                                                                                                                                                   
  , NVL(PCEST.CUSTOFIN, 0) CUSTOFIN                                                                                                                                                                     
  , NVL(PCEST.CUSTOULTENT, 0) CUSTOULTENT                                                                                                                                                               
  , NVL(PCEST.CUSTOULTPEDCOMPRA, 0) CUSTOULTPEDCOMPRA                                                                                                                                                   
  , NVL(PCEST.CUSTOULTENTFIN, 0) CUSTOULTENTFIN                                                                                                                                                         
  , DECODE(PARAMFILIAL.OBTERCOMOVARCHAR2('USAPOLITICACOMERCIALPRODFILIAL'), 'P', NVL(PCPRODUT.CUSTOPROXIMACOMPRA, 0), NVL(PCEST.CUSTOPROXIMACOMPRA, 0)) CUSTOPROXIMACOMPRA                          
  , DECODE(PARAMFILIAL.OBTERCOMOVARCHAR2('USAPOLITICACOMERCIALPRODFILIAL'), 'P', NVL(PCPRODUT.CUSTOFORNEC, 0), NVL(PCEST.CUSTOFORNEC, 0)) CUSTOFORNEC                                               
     , NVL(PCEST.CUSTOREP, 0) REALICMS                             
     , NVL(PCEST.CUSTODOLAR, 0) CUSTODOLAR                         
     , NVL(PCEST.PERCEVOLUCAOVENDA, 0) PERCEVOLUCAOVENDA           
     , (PCEST.QTINDENIZ * PCEST.CUSTOULTENT) RESFOR                                               
     , (NVL(PCEST.QTPEDIDA, 0) * NVL(PCEST.CUSTOFIN, 0)) VLPEDPENDENTE                            
*/     
     , (DECODE(NVL(PCEST.QTGIRODIA, 0), 0, 0,                                                                
       ((PKG_ESTOQUE.ESTOQUE_DISPONIVEL(PCEST.CODPROD, PCEST.CODFILIAL, 'C') 
         - (DECODE(PCFILIAL.CONSIDERAESTPENDSUGCOMPRA, 'N', 0, NVL(PCEST.QTPENDENTE,0)))  ) 
         / DECODE(NVL(PCEST.QTGIRODIA,0),0,1,PCEST.QTGIRODIA)))) AS ESTDIAS 

     --, NVL(PCEST.QTINDENIZ, 0) QTINDENIZ                           
     --, NVL(PCEST.CUSTOREP, 0) CUSTOREPOSICAO  

     , (PKG_ESTOQUE.ESTOQUE_DISPONIVEL(PCEST.CODPROD, PCEST.CODFILIAL, 'C') / DECODE(NVL(PCEST.QTGIRODIA,0),0,1,
PCEST.QTGIRODIA)) QTESTOQUEDIAS 

/*
     , (( NVL(PCEST.QTVENDSEMANA1,0) + NVL(PCEST.QTVENDSEMANA2,0) + NVL(PCEST.QTVENDSEMANA3,0) ) / 3) QTVENDSEMANAFIM                                 
     , ( PCTABPR.PVENDA1
   *        (PKG_ESTOQUE.ESTOQUE_DISPONIVEL(PCEST.CODPROD, PCEST.CODFILIAL, 'C'))                            
        ) as VLESTPVENDA
     , ( PCTABPR.PVENDA1
   *        (PKG_ESTOQUE.ESTOQUE_DISPONIVEL(PCEST.CODPROD, PCEST.CODFILIAL, 'C'))                            
        ) as VLESTPVENDACX
     , ( PCTABPR.PVENDAATAC1
   *        (PKG_ESTOQUE.ESTOQUE_DISPONIVEL(PCEST.CODPROD, PCEST.CODFILIAL, 'C'))                            
        ) as VLESTPVENDAATAC
     , ( PCTABPR.PVENDAATAC1
   *        (PKG_ESTOQUE.ESTOQUE_DISPONIVEL(PCEST.CODPROD, PCEST.CODFILIAL, 'C'))                            
        ) as VLESTPVENDAATACCX
     ,         (PKG_ESTOQUE.ESTOQUE_DISPONIVEL(PCEST.CODPROD, PCEST.CODFILIAL, 'C'))                             AS QTESTGER                                                                                            
     , (       (PKG_ESTOQUE.ESTOQUE_DISPONIVEL(PCEST.CODPROD, PCEST.CODFILIAL, 'C'))                             *         
NVL(PCEST.CUSTOFIN, 0)) AS VLESTDISP                                                                                             
     ,        ((NVL(PCEST.QTGIRODIA,0) * ( DECODE(NVL(PCFORNECFILIAL.PRAZOENTREGA, 0), 0, NVL(PCFORNEC.PRAZOENTREGA,0), 
PCFORNECFILIAL.PRAZOENTREGA) + DECODE(NVL(PCPRODFILIAL.ESTOQUEIDEAL,0),0,NVL(PCPRODUT.TEMREPOS,0),NVL(PCPRODFILIAL.ESTOQUEIDEAL,
0)) )) * (:QTVEZES))  AS  VALORESTOQUEIDEAL                                                                                
*/     
     
     , (      ((NVL(PCEST.QTGIRODIA,0) * ( DECODE(NVL(PCFORNECFILIAL.PRAZOENTREGA, 0), 0, NVL(PCFORNEC.PRAZOENTREGA,0), 
PCFORNECFILIAL.PRAZOENTREGA) + DECODE(NVL(PCPRODFILIAL.ESTOQUEIDEAL,0),0,NVL(PCPRODUT.TEMREPOS,0),NVL(PCPRODFILIAL.ESTOQUEIDEAL,
0)) )) * (:QTVEZES))  -                                                                                                    
                (PKG_ESTOQUE.ESTOQUE_DISPONIVEL(PCEST.CODPROD, PCEST.CODFILIAL, 'C') + NVL(PCEST.QTPEDIDA,0) - 
(DECODE(NVL(PCFILIAL.CONSIDERAESTPENDSUGCOMPRA, 'N'), 'N', 0, NVL(PCEST.QTPENDENTE,0))) ))                                  AS SUGCOMPRA                                                             
     
     , (      (( ((NVL(PCEST.QTVENDMES,0) / :DIASUTEIS)) * ( DECODE(NVL(PCFORNECFILIAL.PRAZOENTREGA, 0), 0, 
NVL(PCFORNEC.PRAZOENTREGA,0), PCFORNECFILIAL.PRAZOENTREGA) + DECODE(NVL(PCPRODFILIAL.ESTOQUEIDEAL,0),0,NVL(PCPRODUT.TEMREPOS,0),
NVL(PCPRODFILIAL.ESTOQUEIDEAL,0)) )) * (:QTVEZES))  -                                                                                            
                (PKG_ESTOQUE.ESTOQUE_DISPONIVEL(PCEST.CODPROD, PCEST.CODFILIAL, 'C') + NVL(PCEST.QTPEDIDA,0) - 
(DECODE(NVL(PCFILIAL.CONSIDERAESTPENDSUGCOMPRA, 'N'), 'N', 0, NVL(PCEST.QTPENDENTE,0))) ))                                  AS SUGESTAOCOMPRASMESATUAL

/*
     ,((      ((NVL(PCEST.QTGIRODIA,0) * ( DECODE(NVL(PCFORNECFILIAL.PRAZOENTREGA, 0), 0, NVL(PCFORNEC.PRAZOENTREGA,0), 
PCFORNECFILIAL.PRAZOENTREGA) + DECODE(NVL(PCPRODFILIAL.ESTOQUEIDEAL,0),0,NVL(PCPRODUT.TEMREPOS,0),NVL(PCPRODFILIAL.ESTOQUEIDEAL,
0)) )) * (:QTVEZES))  -                                                                                                    
                (PKG_ESTOQUE.ESTOQUE_DISPONIVEL(PCEST.CODPROD, PCEST.CODFILIAL, 'C') + NVL(PCEST.QTPEDIDA,0) - 
(DECODE(NVL(PCFILIAL.CONSIDERAESTPENDSUGCOMPRA, 'N'), 'N', 0, NVL(PCEST.QTPENDENTE,0))) ))                                  * 
PCEST.VALORULTENT) AS VLTOTALSUGULTENT                                 
     , (      ((NVL(PCEST.QTGIRODIA,0) * ( DECODE(NVL(PCFORNECFILIAL.PRAZOENTREGA, 0), 0, NVL(PCFORNEC.PRAZOENTREGA,0), 
PCFORNECFILIAL.PRAZOENTREGA) + DECODE(NVL(PCPRODFILIAL.ESTOQUEIDEAL,0),0,NVL(PCPRODUT.TEMREPOS,0),NVL(PCPRODFILIAL.ESTOQUEIDEAL,
0)) )) * (:QTVEZES))  *         NVL(PCEST.CUSTOFIN, 0)) AS VLESTIDEAL  
*/

     , CASE WHEN ((((      ((NVL(PCEST.QTGIRODIA,0) * ( DECODE(NVL(PCFORNECFILIAL.PRAZOENTREGA, 0), 0, 
NVL(PCFORNEC.PRAZOENTREGA,0), PCFORNECFILIAL.PRAZOENTREGA) + DECODE(NVL(PCPRODFILIAL.ESTOQUEIDEAL,0),0,NVL(PCPRODUT.TEMREPOS,0),
NVL(PCPRODFILIAL.ESTOQUEIDEAL,0)) )) * (:QTVEZES))  -                                                                                       
                (PKG_ESTOQUE.ESTOQUE_DISPONIVEL(PCEST.CODPROD, PCEST.CODFILIAL, 'C') + NVL(PCEST.QTPEDIDA,0) - 
(DECODE(NVL(PCFILIAL.CONSIDERAESTPENDSUGCOMPRA, 'N'), 'N', 0, NVL(PCEST.QTPENDENTE,0))) ))                                 ) *                                                                       
                NVL(PCEST.CUSTOFIN, 0))) < 0                                                                                                     
       THEN ((((      ((NVL(PCEST.QTGIRODIA,0) * ( DECODE(NVL(PCFORNECFILIAL.PRAZOENTREGA, 0), 0, NVL(PCFORNEC.PRAZOENTREGA,0), 
PCFORNECFILIAL.PRAZOENTREGA) + DECODE(NVL(PCPRODFILIAL.ESTOQUEIDEAL,0),0,NVL(PCPRODUT.TEMREPOS,0),NVL(PCPRODFILIAL.ESTOQUEIDEAL,
0)) )) * (:QTVEZES))  -                                                                                            
                (PKG_ESTOQUE.ESTOQUE_DISPONIVEL(PCEST.CODPROD, PCEST.CODFILIAL, 'C') + NVL(PCEST.QTPEDIDA,0) - 
(DECODE(NVL(PCFILIAL.CONSIDERAESTPENDSUGCOMPRA, 'N'), 'N', 0, NVL(PCEST.QTPENDENTE,0))) ))                                 ) *                                                                       
                NVL(PCEST.CUSTOFIN, 0))*(-1))                                                                                                    
        ELSE 0                                                                                                                           
        END AS  VLESTEXCESSO  


     , CASE WHEN ((((      ((NVL(PCEST.QTGIRODIA,0) * ( DECODE(NVL(PCFORNECFILIAL.PRAZOENTREGA, 0), 0, 
NVL(PCFORNEC.PRAZOENTREGA,0), PCFORNECFILIAL.PRAZOENTREGA) + DECODE(NVL(PCPRODFILIAL.ESTOQUEIDEAL,0),0,NVL(PCPRODUT.TEMREPOS,0),
NVL(PCPRODFILIAL.ESTOQUEIDEAL,0)) )) * (:QTVEZES))  -                                                                                       
                (PKG_ESTOQUE.ESTOQUE_DISPONIVEL(PCEST.CODPROD, PCEST.CODFILIAL, 'C') + NVL(PCEST.QTPEDIDA,0) - 
(DECODE(NVL(PCFILIAL.CONSIDERAESTPENDSUGCOMPRA, 'N'), 'N', 0, NVL(PCEST.QTPENDENTE,0))) ))                                 ) *                                                                       
                NVL(PCEST.CUSTOFIN, 0))) > 0                                                                                                     
       THEN ((((      ((NVL(PCEST.QTGIRODIA,0) * ( DECODE(NVL(PCFORNECFILIAL.PRAZOENTREGA, 0), 0, NVL(PCFORNEC.PRAZOENTREGA,0), 
PCFORNECFILIAL.PRAZOENTREGA) + DECODE(NVL(PCPRODFILIAL.ESTOQUEIDEAL,0),0,NVL(PCPRODUT.TEMREPOS,0),NVL(PCPRODFILIAL.ESTOQUEIDEAL,
0)) )) * (:QTVEZES))  -                                                                                            
                (PKG_ESTOQUE.ESTOQUE_DISPONIVEL(PCEST.CODPROD, PCEST.CODFILIAL, 'C') + NVL(PCEST.QTPEDIDA,0) - 
(DECODE(NVL(PCFILIAL.CONSIDERAESTPENDSUGCOMPRA, 'N'), 'N', 0, NVL(PCEST.QTPENDENTE,0))) ))                                 ) *                                                                       
                NVL(PCEST.CUSTOFIN, 0)))                                                                                                         
        ELSE 0                                                                                                                           
        END AS VLESTFALTA 


     , ((      ((NVL(PCEST.QTGIRODIA,0) * ( DECODE(NVL(PCFORNECFILIAL.PRAZOENTREGA, 0), 0, NVL(PCFORNEC.PRAZOENTREGA,0), 
PCFORNECFILIAL.PRAZOENTREGA) + DECODE(NVL(PCPRODFILIAL.ESTOQUEIDEAL,0),0,NVL(PCPRODUT.TEMREPOS,0),NVL(PCPRODFILIAL.ESTOQUEIDEAL,
0)) )) * (:QTVEZES))  -                                                                                                    
                 (PKG_ESTOQUE.ESTOQUE_DISPONIVEL(PCEST.CODPROD, PCEST.CODFILIAL, 'C') + NVL(PCEST.QTPEDIDA,0) - 
(DECODE(NVL(PCFILIAL.CONSIDERAESTPENDSUGCOMPRA, 'N'), 'N', 0, NVL(PCEST.QTPENDENTE,0))) ))                                  / 
UNIDADE.QTUNITCX) AS SUGCOMPRACX 

/*
     , (SELECT SUM(PCFALTA.QT)                                                            
          FROM PCFALTA                                                                    
         WHERE PCFALTA.CODPROD   = PCPRODUT.CODPROD                                       
           AND PCFALTA.CODFILIAL = PCEST.CODFILIAL                                        
           AND PCFALTA.DATA BETWEEN :DTINICIO AND :DTFINAL) QTFALTA                       
, (SELECT (SUM(DECODE(PCMOVCRFOR.TIPO,'D',PCMOVCRFOR.VALOR,0)) -          
                SUM(DECODE(PCMOVCRFOR.TIPO,'C',PCMOVCRFOR.VALOR,0)))      
      FROM  PCMOVCRFOR                                                      
           ,PCVERBA                                                         
     WHERE PCMOVCRFOR.NUMVERBA  = PCVERBA.NUMVERBA                          
       AND PCMOVCRFOR.CODFILIAL IN ('2')
       AND PCMOVCRFOR.CODFORNEC = PCFORNEC.CODFORNEC                        
       AND PCVERBA.FORMAPGTO = 'M') VLSALDOMERC                           
     , (SELECT (SUM(DECODE(PCMOVCRFOR.TIPO,'D',PCMOVCRFOR.VALOR,0)) -     
            SUM(DECODE(PCMOVCRFOR.TIPO,'C',PCMOVCRFOR.VALOR,0)))          
      FROM  PCMOVCRFOR                                                      
           ,PCVERBA                                                         
     WHERE PCMOVCRFOR.NUMVERBA  = PCVERBA.NUMVERBA                          
       AND PCMOVCRFOR.CODFILIAL IN ('2')
       AND PCMOVCRFOR.CODFORNEC = PCFORNEC.CODFORNEC                        
       AND NVL(PCVERBA.FORMAPGTO,'M') = 'D') VLSALDODIN                 
     , NVL(PCFORNEC.TIPOFRETECIFFOB, 'C') FRETE 
     , 0 NUMPED                 
     , TO_DATE(NULL) DTEMISSAO 
 */    

     , NVL(PCPRODUT.PERCST, 0) PERCST      
     , NVL(PCEST.VLVENDMES, 0) VLVENDAMES                                       
     , (PCEST.VLVENDMES /                                                      
        (DECODE(NVL ((SELECT SUM(E.VLVENDMES)                                     
                        FROM PCEST E, PCPRODUT P                                      
                       WHERE E.CODPROD = P.CODPROD                                    
                         AND P.CODFORNEC = PCPRODUT.CODFORNEC                         
                         AND E.CODFILIAL = PCEST.CODFILIAL), 1), 0,1,                 
                NVL ((SELECT SUM(E.VLVENDMES)                                    
                        FROM PCEST E, PCPRODUT P                                      
                       WHERE E.CODPROD = P.CODPROD                                    
                         AND P.CODFORNEC = PCPRODUT.CODFORNEC                         
                         AND E.CODFILIAL = PCEST.CODFILIAL), 1)))) * 100 PARTICIPITEM
     /*                     
     , PCPARCELASC.CODPARCELA                            
     , PCPARCELASC.DESCRICAO DESCPARCELA                 
     , (CASE WHEN (NVL(PCPRODUT.SUGVENDA, 0) <= 0) THEN NVL(PCCONSUM.SUGVENDA, 3) ELSE NVL(PCPRODUT.SUGVENDA, 0) END) SUGVENDA 
     , PCPRODUT.CUSTOREPTAB                                                   
     , PCEST.DTULTENT DTEMISSAOULTENT                                         
     , PCEST.VLSTULTENTTAB                                                    
     , PCEST.VLSTGUIAULTENTTAB                                                
     , PCEST.VLSTULTENT                                                       
     , PCEST.VLSTGUIAULTENT                                                   
     , PCEST.CUSTONFSEMSTTAB                                                  
     , PCEST.CUSTONFSEMSTGUIAULTENTTAB                                        
     , PCEST.CUSTONFSEMST                                                     
     , PCEST.CUSTONFSEMSTGUIAULTENT                                           
     , PCEST.VLULTENTCONTSEMST
     */

  FROM PCEST           
     , PCFILIAL        
     , PCPRODUT        
     , PCCONSUM        
     , PCFORNEC        
     , PCDEPTO         
     , PCSECAO         
     , PCTABPR         
     , PCTRIBUT        
     , PCREGIAO        
     , PCPRODFILIAL    
     , PCMARCA         
     , PCCATEGORIA     
     , PCSUBCATEGORIA  
     , PCPARCELASC     
     , UNIDADE         
     , PCFORNECFILIAL 
      
 WHERE PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC                       
   AND PCFILIAL.CODIGO    = PCEST.CODFILIAL                          
   AND PCTABPR.CODPROD    = PCPRODUT.CODPROD                         
   AND PCTABPR.NUMREGIAO  = PCREGIAO.NUMREGIAO                       
   AND PCPRODUT.CODEPTO   = PCDEPTO.CODEPTO                          
   AND PCPRODUT.CODSEC    = PCSECAO.CODSEC                           
   AND ((PCEST.CODFILIAL    = PCPRODUT.CODFILIAL) OR                 
        (PCPRODUT.CODFILIAL = '99') OR                             
        (PCPRODUT.CODFILIAL IS NULL))                                
   AND PCPRODFILIAL.CODPROD  = PCEST.CODPROD                         
   AND PCPRODFILIAL.CODFILIAL  = PCEST.CODFILIAL                     
   AND PCFORNEC.CODFORNEC = PCFORNECFILIAL.CODFORNEC  
   AND PCPRODFILIAL.CODFILIAL = PCFORNECFILIAL.CODFILIAL  
   AND PCPRODUT.CODMARCA  = PCMARCA.CODMARCA (+)                     
   AND PCPRODUT.CODCATEGORIA  = PCCATEGORIA.CODCATEGORIA (+)         
   AND PCFORNEC.CODPARCELA= PCPARCELASC.CODPARCELA(+)                
   AND PCPRODUT.CODSEC        = PCCATEGORIA.CODSEC (+)               
   AND PCPRODUT.CODSEC        = PCSUBCATEGORIA.CODSEC (+)            
   AND PCPRODUT.CODCATEGORIA  = PCSUBCATEGORIA.CODCATEGORIA(+)       
   AND PCPRODUT.CODSUBCATEGORIA  = PCSUBCATEGORIA.CODSUBCATEGORIA(+) 
   AND PCPRODUT.CODPROD   = PCEST.CODPROD                            
   AND PCPRODUT.ROWID     = UNIDADE.RID                              
                                            
 AND ((PCPRODUT.TIPOMERC NOT IN ('CB')) OR (PCPRODUT.TIPOMERC IS NULL))     
   AND (((PCPRODUT.OBS NOT IN ('PV')) OR (PCPRODUT.OBS IS NULL))                             
   AND ((PCPRODFILIAL.PROIBIDAVENDA NOT IN ('S')) OR (PCPRODFILIAL.PROIBIDAVENDA IS NULL))) 
   AND PCTABPR.CODST         = PCTRIBUT.CODST   
   AND PCEST.CODFILIAL IN ('2')     
   AND PCREGIAO.NUMREGIAO = :NUMREGIAO  
   AND (PCPRODUT.CODFILIAL IN ('2')  OR (PCPRODUT.CODFILIAL IS NULL) OR (PCPRODUT.CODFILIAL = '99'))
   AND ((PCFORNEC.BLOQUEIO NOT IN ('S')) OR (PCFORNEC.BLOQUEIO IS NULL))  
   AND (((PCPRODUT.OBS2 NOT IN ('FL')) OR (PCPRODUT.OBS2 IS NULL)) AND ((PCPRODFILIAL.FORALINHA NOT IN ('S')) OR 
(PCPRODFILIAL.FORALINHA IS NULL))) 
   ORDER BY 
         PCPRODUT.CODPROD,
       PCEST.CODFILIAL

/******************************       
DTINICIO = '01/11/2023'
DTFINAL = '30/11/2023 23:59:59'
DIASUTEISTRIMESTRE = 90
DIASUTEIS = 1
TOTALDIASUTEIS = 22
QTVEZES = 1
NUMREGIAO = 1
*********************************/