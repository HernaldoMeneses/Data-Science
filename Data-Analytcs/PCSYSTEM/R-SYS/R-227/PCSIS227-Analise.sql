WITH UNIDADE AS (                                                               
  SELECT PCPRODUT.ROWID RID                                                     
       , DECODE(NVL(PCPRODUT.QTUNITCX, 0), 0, 1, PCPRODUT.QTUNITCX) QTUNITCX    
       , DECODE(NVL(PCPRODUT.PESOBRUTO, 0), 0, 1, PCPRODUT.PESOBRUTO) PESOBRUTO 
    FROM PCPRODUT)                                                              
SELECT 
PCPRODUT.CODFORNEC  
, PCPRODUT.CODPROD

--,  case when  NVL(PCEST.QTGIRODIA,0) != ((NVL(PCEST.QTVENDMES1, 0) + NVL(PCEST.QTVENDMES2, 0) + NVL(PCEST.QTVENDMES3, 0)) / :DIASUTEISTRIMESTRE) then 1 else 0 end c
   , NVL(PCEST.QTGIRODIA,0) GIRODIA_103
     , ((NVL(PCEST.QTVENDMES1, 0) + NVL(PCEST.QTVENDMES2, 0) + NVL(PCEST.QTVENDMES3, 0)) / :DIASUTEISTRIMESTRE) QTGIRODIA_227 
   , ((NVL(PCEST.QTVENDMES1, 0) + NVL(PCEST.QTVENDMES2, 0) + NVL(PCEST.QTVENDMES3, 0)) 
      / (select 
               --min(Data)
               --, max(Data)
               sum(QtUtil)
               from (select 
                        to_char(to_date(a.data,'dd/mm/yyyy')) as Data,
                        CASE WHEN (DIAUTIL = 'S'  OR DIAUTIL IS NULL )THEN 1 ELSE 0 END AS QtUtil
                        from 
                           pcdatas a
                        where
                           TO_CHAR( a.data , 'YYYY') >= TO_CHAR(ADD_MONTHS(SYSDATE, -4), 'YYYY')
                           AND TO_CHAR( a.data , 'mm') >= TO_CHAR(ADD_MONTHS(SYSDATE, -4), 'mm')
                     )
         )
    ) QTGIRODIA_util                                                 
   
   , NVL(PCEST.QTVENDMES3, 0) QTVENDMES3
   , NVL(PCEST.QTVENDMES2, 0) QTVENDMES2
   , NVL(PCEST.QTVENDMES1, 0) QTVENDMES1  
   , NVL(PCEST.QTVENDMES,  0) QTVENDMES                          
                       
                         

    ,  NVL(PCEST.QTVENDMES,  0) + NVL(PCEST.QTVENDMES1,  0) + NVL(PCEST.QTVENDMES2,  0) + NVL(PCEST.QTVENDMES3,  0) as QTVENDATotal4

  
     , case when  NVL(PCEST.QTVENDMES3,  0) > 0 then 1 else 0 end qtmes3
      , case when  NVL(PCEST.QTVENDMES2,  0) > 0 then 1 else 0 end qtmes2  
        , case when  NVL(PCEST.QTVENDMES1,  0) > 0 then 1 else 0 end qtmes1
     , case when  NVL(PCEST.QTVENDMES,  0) > 0 then 1 else 0 end qtmes

          , case when  NVL(PCEST.QTVENDMES3,  0) > 0 
            And  NVL(PCEST.QTVENDMES2,  0) > 0 
            And  NVL(PCEST.QTVENDMES1,  0) > 0 
            And  NVL(PCEST.QTVENDMES,  0) = 0 
            then 1 else 0 end AlertRup4

         , case when  NVL(PCEST.QTVENDMES2,  0) > 0 
            And  NVL(PCEST.QTVENDMES1,  0) > 0 
            And  NVL(PCEST.QTVENDMES,  0) = 0 
            then 1 else 0 end AlertRup3

         , case when  NVL(PCEST.QTVENDMES1,  0) > 0 
            And  NVL(PCEST.QTVENDMES,  0) = 0 
            then 1 else 0 end AlertRup2

     --, ((NVL(PCEST.QTVENDMES1, 0) + NVL(PCEST.QTVENDMES2, 0) + NVL(PCEST.QTVENDMES3, 0)) / 3) QTGIROMES 

     , NVL(PCEST.QTESTGER, 0) QTESTGER  
     , NVL(PCEST.QTRESERV,   0) QTRESERV                           
     , NVL(PCEST.QTPENDENTE, 0) QTPENDENTE                          
     , NVL(PCEST.QTBLOQUEADA, 0) QTBLOQUEADA
     , NVL(PCEST.QTESTGER, 0) -  NVL(PCEST.QTRESERV,   0)  - NVL(PCEST.QTPENDENTE, 0) - NVL(PCEST.QTBLOQUEADA, 0) QTDisponivel                      

/*
     , NVL(PCEST.QTDEVOLMES,  0) QTDEVOLMES                          
     , NVL(PCEST.QTDEVOLMES1, 0) QTDEVOLMES1                         
     , NVL(PCEST.QTDEVOLMES2, 0) QTDEVOLMES2                         
     , NVL(PCEST.QTDEVOLMES3, 0) QTDEVOLMES3 
*/



     , PCEST.DTULTSAIDA 
     , TO_DATE(Sysdate,'dd/mm/yyyy') - PCEST.DTULTSAIDA AS DiasSemVenda                                           
     , PCEST.DTULTENT 
     , TO_DATE(Sysdate,'dd/mm/yyyy') - PCEST.DTULTENT  as DiasSemCompra
      , PCFORNEC.DTBLOQUEIO 
   , TO_DATE(Sysdate,'dd/mm/yyyy') - PCFORNEC.DTBLOQUEIO  as DiasBloqueado


     , PCEST.QTULTENT                                              
     , NVL(PCEST.QTPEDIDA, 0) QTPEDIDA                             
     
     
     , (DECODE(NVL(PCEST.QTGIRODIA, 0), 0, 0,                                                                
       ((PKG_ESTOQUE.ESTOQUE_DISPONIVEL(PCEST.CODPROD, PCEST.CODFILIAL, 'C') 
         - (DECODE(PCFILIAL.CONSIDERAESTPENDSUGCOMPRA, 'N', 0, NVL(PCEST.QTPENDENTE,0)))  ) 
         / DECODE(NVL(PCEST.QTGIRODIA,0),0,1,PCEST.QTGIRODIA)))) AS ESTDIAS 

     , (PKG_ESTOQUE.ESTOQUE_DISPONIVEL(PCEST.CODPROD, PCEST.CODFILIAL, 'C') / DECODE(NVL(PCEST.QTGIRODIA,0),0,1,
PCEST.QTGIRODIA)) QTESTOQUEDIAS 
    , NVL(PCEST.QTESTGER, 0) /  DECODE(NVL(PCEST.QTGIRODIA,0),0,1,
PCEST.QTGIRODIA) QTESTOQUEDIAS2

/***********************************************************************************************************************************************/  
     
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
