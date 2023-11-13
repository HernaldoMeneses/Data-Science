WITH UNIDADE AS (                                                               
  SELECT PCPRODUT.ROWID RID                                                     
       , DECODE(NVL(PCPRODUT.QTUNITCX, 0), 0, 1, PCPRODUT.QTUNITCX) QTUNITCX    
       , DECODE(NVL(PCPRODUT.PESOBRUTO, 0), 0, 1, PCPRODUT.PESOBRUTO) PESOBRUTO 
    FROM PCPRODUT)  
                                                                
SELECT 
Distinct(PCPRODUT.CODFORNEC)  
, PCPRODUT.CODPROD

--,  case when  NVL(PCEST.QTGIRODIA,0) != ((NVL(PCEST.QTVENDMES1, 0) + NVL(PCEST.QTVENDMES2, 0) + NVL(PCEST.QTVENDMES3, 0)) / :DIASUTEISTRIMESTRE) then 1 else 0 end c
   , NVL(PCEST.QTGIRODIA,0) GIRODIA_103
 --    , ((NVL(PCEST.QTVENDMES1, 0) + NVL(PCEST.QTVENDMES2, 0) + NVL(PCEST.QTVENDMES3, 0)) / :DIASUTEISTRIMESTRE) QTGIRODIA_227 
 /*
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
                           TO_CHAR( a.data , 'YYYY') >= TO_CHAR(ADD_MONTHS(SYSDATE, -3), 'YYYY')
                           AND TO_CHAR( a.data , 'mm') >= TO_CHAR(ADD_MONTHS(SYSDATE, -3), 'mm')
                     )
         )
    ) QTGIRODIA_util                                                 
 */  
   , NVL(PCEST.QTVENDMES3, 0) QTVENDMES3
   , NVL(PCEST.QTVENDMES2, 0) QTVENDMES2
   , NVL(PCEST.QTVENDMES1, 0) QTVENDMES1  
   , NVL(PCEST.QTVENDMES,  0) QTVENDMES                          
                       
                         

    ,  NVL(PCEST.QTVENDMES,  0) + NVL(PCEST.QTVENDMES1,  0) + NVL(PCEST.QTVENDMES2,  0) + NVL(PCEST.QTVENDMES3,  0) as QTVENDATotal4

  
   --  , case when  NVL(PCEST.QTVENDMES3,  0) > 0 then 1 else 0 end qtmes3
   --   , case when  NVL(PCEST.QTVENDMES2,  0) > 0 then 1 else 0 end qtmes2  
   --     , case when  NVL(PCEST.QTVENDMES1,  0) > 0 then 1 else 0 end qtmes1
   --  , case when  NVL(PCEST.QTVENDMES,  0) > 0 then 1 else 0 end qtmes

          , case when  NVL(PCEST.QTVENDMES3,  0) > 0 
            And  NVL(PCEST.QTVENDMES2,  0) > 0 
            And  NVL(PCEST.QTVENDMES1,  0) > 0 
            --And  NVL(PCEST.QTVENDMES,  0) >= 0 
            And  (NVL(PCEST.QTESTGER, 0) -  NVL(PCEST.QTRESERV,   0)  - NVL(PCEST.QTPENDENTE, 0) - NVL(PCEST.QTBLOQUEADA, 0))/ NVL(PCEST.QTGIRODIA,0) < 45
            then power(2,4)else 0 end ARup4

         , case when NVL(PCEST.QTVENDMES3,  0) = 0 
            AND  NVL(PCEST.QTVENDMES2,  0) > 0 
            And  NVL(PCEST.QTVENDMES1,  0) > 0 
            --And  NVL(PCEST.QTVENDMES,  0) = 0 
            And  (NVL(PCEST.QTESTGER, 0) -  NVL(PCEST.QTRESERV,   0)  - NVL(PCEST.QTPENDENTE, 0) - NVL(PCEST.QTBLOQUEADA, 0))/ NVL(PCEST.QTGIRODIA,0) < 45
            then power(2,3) else 0 end ARup3

         , case when NVL(PCEST.QTVENDMES3,  0) = 0 
            AND  NVL(PCEST.QTVENDMES2,  0) = 0   
           and NVL(PCEST.QTVENDMES1,  0) > 0 
            --And  NVL(PCEST.QTVENDMES,  0) = 0 
            And  (NVL(PCEST.QTESTGER, 0) -  NVL(PCEST.QTRESERV,   0)  - NVL(PCEST.QTPENDENTE, 0) - NVL(PCEST.QTBLOQUEADA, 0))/ NVL(PCEST.QTGIRODIA,0) < 45
            then power(2,2) else 0 end ARup2

     --, ((NVL(PCEST.QTVENDMES1, 0) + NVL(PCEST.QTVENDMES2, 0) + NVL(PCEST.QTVENDMES3, 0)) / 3) QTGIROMES 

     , NVL(PCEST.QTESTGER, 0) QTESTGER  
     , NVL(PCEST.QTRESERV,   0) QTRESERV                           
     , NVL(PCEST.QTPENDENTE, 0) QTPENDENTE                          
     , NVL(PCEST.QTBLOQUEADA, 0) QTBLOQUEADA
     , NVL(PCEST.QTESTGER, 0) -  NVL(PCEST.QTRESERV,   0)  - NVL(PCEST.QTPENDENTE, 0) - NVL(PCEST.QTBLOQUEADA, 0) QTDisponivel   


     ,case when PCEST.QTGIRODIA > 0 AND 
       round((DECODE(NVL(PCEST.QTGIRODIA, 0), 0, 0,                                                                
       ((PKG_ESTOQUE.ESTOQUE_DISPONIVEL(PCEST.CODPROD, PCEST.CODFILIAL, 'C') 
         - (DECODE(PCFILIAL.CONSIDERAESTPENDSUGCOMPRA, 'N', 0, NVL(PCEST.QTPENDENTE,0)))  ) 
         / DECODE(NVL(PCEST.QTGIRODIA,0),0,1,PCEST.QTGIRODIA)))),2) < 1000 then
         
         round((DECODE(NVL(PCEST.QTGIRODIA, 0), 0, 0,                                                                
       ((PKG_ESTOQUE.ESTOQUE_DISPONIVEL(PCEST.CODPROD, PCEST.CODFILIAL, 'C') 
         - (DECODE(PCFILIAL.CONSIDERAESTPENDSUGCOMPRA, 'N', 0, NVL(PCEST.QTPENDENTE,0)))  ) 
         / DECODE(NVL(PCEST.QTGIRODIA,0),0,1,PCEST.QTGIRODIA)))),2)  
           else 0 end ESTDIAS  
               

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
     
     


   /*  , (PKG_ESTOQUE.ESTOQUE_DISPONIVEL(PCEST.CODPROD, PCEST.CODFILIAL, 'C') / DECODE(NVL(PCEST.QTGIRODIA,0),0,1,
PCEST.QTGIRODIA)) QTESTOQUEDIAS 
    , NVL(PCEST.QTESTGER, 0) /  DECODE(NVL(PCEST.QTGIRODIA,0),0,1,
PCEST.QTGIRODIA) QTESTOQUEDIAS2 
*/

/***********************************************************************************************************************************************/  
     
   

     , NVL(PCPRODUT.PERCST, 0) PERCST      
     , NVL(PCEST.VLVENDMES, 0) VLVENDAMES                                       
     , round((PCEST.VLVENDMES /                                                      
        (DECODE(NVL ((SELECT SUM(E.VLVENDMES)                                     
                        FROM PCEST E, PCPRODUT P                                      
                       WHERE E.CODPROD = P.CODPROD                                    
                         AND P.CODFORNEC = PCPRODUT.CODFORNEC                         
                         AND E.CODFILIAL = PCEST.CODFILIAL), 1), 0,1,                 
                NVL ((SELECT SUM(E.VLVENDMES)                                    
                        FROM PCEST E, PCPRODUT P                                      
                       WHERE E.CODPROD = P.CODPROD                                    
                         AND P.CODFORNEC = PCPRODUT.CODFORNEC                         
                         AND E.CODFILIAL = PCEST.CODFILIAL), 1)))) * 100,2) PARTICIPITEM


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
   --AND PCREGIAO.NUMREGIAO = :NUMREGIAO  
   AND (PCPRODUT.CODFILIAL IN ('2')  OR (PCPRODUT.CODFILIAL IS NULL) OR (PCPRODUT.CODFILIAL = '99'))
   AND ((PCFORNEC.BLOQUEIO NOT IN ('S')) OR (PCFORNEC.BLOQUEIO IS NULL))  
   AND (((PCPRODUT.OBS2 NOT IN ('FL')) OR (PCPRODUT.OBS2 IS NULL)) AND ((PCPRODFILIAL.FORALINHA NOT IN ('S')) OR 
(PCPRODFILIAL.FORALINHA IS NULL))) 


AND PCPRODUT.CODFORNEC in (
2901 ,3175 ,297 ,1214 ,3114 ,2620 ,989 ,2589 ,2280 ,3026
,3235 ,3309 ,3383 ,3639 ,3640 ,3582 ,3715 ,3726 ,3718 ,1174
,390 ,3470 ,405 ,394 ,3468 ,976 ,1118 ,4 ,1360 ,3446 ,1203 ,403 ,2971 ,975 ,346 ,2993 ,3248
,3258 ,3330 ,3356
,3420 ,3424
,3333 ,3461
,3314 ,3423
,3485 ,3486
,3492 ,3549
,3570 ,3209
,3361 ,3642
,19 ,3356
,3743 ,3592
,14 ,2946
,125 ,1662
,1970 ,2591
,3459 ,3018
,2841 ,2789
,3222 ,3241
,3326 ,3313
,1068 ,3466
,3542 ,3396
,3077 ,3074
,2902 ,2746
,2908 ,3207
,1721 ,2811
,3317 ,3329
,2834 ,3334
,3345 ,3373
,3427 ,2824
,3457 ,3441
,3589 ,3546
,3552 ,3632
,3634 ,3469
,3606 ,3675 ,3623

)

   ORDER BY 
         PCPRODUT.CODPROD

