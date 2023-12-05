    --#-----------------------------------------------------------------------------------------#
--# - Objetivo: Help to conetct and colsult Oracle Data base by Prompt                     -#
--# - Obs     : Using.                                                                     -#
--#                                                                                        -#
--# - Titulo  : Oracle_prompt_sql.                                                         -#
--# - Tema    : conect and consult.                                                        -#
--#                                                                                        -#
--# - Autor   : Hernaldo Meneses                                                           -#
--# - Criação : 25/10/2023                                                                 -#
--# - more info and of Script.                                                             -#
--#-----------------------------------------------------------------------------------------#
select 

distinct(venda.CODCOMPRADOR)
, venda.CODFORNEC
, venda.CODPROD
, venda.PESOBRUTO
, venda.vlvenda
, venda.VLBONIFIC
, venda.qt
, round(venda.QTCX,2) as qtcx
, venda.QTBNF
, venda.QTPEDIDOS
, (venda.vlvenda-venda.vlcustofin) as Lucro_Op

, giro.GIRODIA
, giro.ESTDIAS
, round(giro.ESTDIAS-3-ficha.leadtime,0) as stodiasrepo
, SYSDATE + round(giro.ESTDIAS-3-ficha.leadtime,0) as repor
, real_.VLCUSTOREAL

,  ficha.QTGerencial
,  ficha.QTRESERV
,  ficha.QTPENDENTE
,  ficha.QTBLOQUEADA
,  ficha.DTULTSAIDA
,  ficha.QTVENDMES
,  ficha.QTVENDMES1
,  ficha.QTVENDMES2
,  ficha.QTVENDMES3
,  ficha.DTULTENT
,  ficha.QTULTENT
,  ficha.leadtime
,  ficha.QTPEDIDA

 from

(
SELECT 
PCFORNEC.CODCOMPRADOR,

/*
       (SELECT PCEMPR.NOME
          FROM PCEMPR
         WHERE 1=1
               AND PCFORNEC.CODCOMPRADOR = PCEMPR.MATRICULA
               AND PCEMPR.CODSETOR IN
               (SELECT PCCONSUM.CODSETORCOMPRADOR FROM PCCONSUM)
           ) COMPRADOR,

*/

PCPRODUT.CODFORNEC, 
PCPEDI.CODPROD, 
--PCPRODUT.DESCRICAO,

           
           
              (CASE WHEN PCPRODUT.PESOBRUTO = 0 THEN 0 
               ELSE (PCPRODUT.PESOBRUTO * SUM(PCPEDI.QT)) END) PESOBRUTO, 


       SUM(CASE                                                                                                                            
             WHEN NVL(PCPEDI.BONIFIC, 'N') = 'N' THEN                                                                                  
              DECODE(PCPEDC.CONDVENDA,                                                                                                     
                     5,                                                                                                                    
                    0,
                     6,                                                                                                                    
                     0,                                                                                                                    
                     11,                                                                                                                   
                     0,                                                                                                                    
                     12,                                                                                                                   
                     0,                                                                                                                    
                     NVL(PCPEDI.VLSUBTOTITEM,                                                                                              
                         (DECODE(NVL(PCPEDI.TRUNCARITEM, 'N'),                                                                           
                                 'N',                                                                                                    
                                 ROUND((NVL(PCPEDI.QT, 0)) * (NVL(PCPEDI.PVENDA, 0) + nvl(pcpedi.vloutrasdesp,0) + 
nvl(pcpedi.vlfrete,0)), 
                                       2),                                                                                                 
                                 TRUNC((NVL(PCPEDI.QT, 0)) * (NVL(PCPEDI.PVENDA, 0) + nvl(pcpedi.vloutrasdesp,0) + 
nvl(pcpedi.vlfrete,0)), 
                                       2)))))                                                                                              
             ELSE                                                                                                                          
    0 
           END) - SUM(CASE                                                                                                                 
                        WHEN NVL(PCPEDI.BONIFIC, 'N') = 'N' THEN                                                                       
                         DECODE(PCPEDC.CONDVENDA,                                                                                          
                                5,                                                                                                         
                                0,                                                                                                         
                                6,                                                                                                         
                                0,                                                                                                         
                                11,                                                                                                        
                                0,                                                                                                         
                                12,                                                                                                        
                                0,                                                                                                         
                                NVL(PCPEDI.qt, 0) * (0 + 0))                                                                               
                        ELSE                                                                                                               
                    0
                      END) VLVENDA, 


      ROUND( SUM(DECODE(PCPEDC.CONDVENDA,                                                                                                        
                  5,                                                                                                                       
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  DECODE(NVL(PCPEDI.PBONIFIC, 0),                                                                                          
                         0,                                                                                                                
                         PCPEDI.PTABELA,                                                                                                   
                         PCPEDI.PBONIFIC),                                                                                                 
                  6,                                                                                                                       
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  DECODE(NVL(PCPEDI.PBONIFIC, 0),                                                                                          
                         0,                                                                                                                
                         PCPEDI.PTABELA,                                                                                                   
                         PCPEDI.PBONIFIC),                                                                                                 
                  1,                                                                                                                       
                  CASE                                                                                                                     
                    WHEN NVL(PCPEDI.BONIFIC, 'N') <> 'N' THEN                                                                          
                     NVL(PCPEDI.QT, 0) *                                                                                                   
                     DECODE(NVL(PCPEDI.PBONIFIC, 0), 0, PCPEDI.PTABELA, PCPEDI.PBONIFIC)                                                   
                    ELSE                                                                                                                   
                     0                                                                                                                     
                  END,                                                                                                                     
                  11,                                                                                                                      
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  DECODE(NVL(PCPEDI.PBONIFIC, 0),                                                                                          
                         0,                                                                                                                
                         PCPEDI.PTABELA,                                                                                                   
                         PCPEDI.PBONIFIC),                                                                                                 
                  12,                                                                                                                      
                  NVL(PCPEDI.QT, 0) *                                                                                                      
                  DECODE(NVL(PBONIFIC, 0),                                                                                                 
                         0,                                                                                                                
                         PCPEDI.PTABELA,                                                                                                   
                         PCPEDI.PBONIFIC),                                                                                                 
                  0)),2) VLBONIFIC,                                                                                                           
   SUM((PCPEDI.qt)*NVL(PCPEDI.vlcustofin,0)) AS VLCUSTOFIN,
   SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') <> 'N' THEN 0 ELSE NVL(PCPEDI.QT, 0) END,5,0,6,0,11,0,12,0,
NVL(PCPEDI.QT,0))) QT,

   SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') <> 'N' THEN 0 ELSE NVL(PCPEDI.QT, 0) / 
DECODE(NVL(PCPRODUT.QTUNITCX,0),0,1,PCPRODUT.QTUNITCX) END,5,0,6,0,11,0,12,0,NVL(PCPEDI.qt, 0)
  / DECODE(NVL(PCPRODUT.QTUNITCX,0),0,1,PCPRODUT.QTUNITCX))) AS QTCX,

  
SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') = 'S' THEN NVL(PCPEDI.QT, 0) ELSE 0 END,5,NVL(PCPEDI.QT, 0),6,
NVL(PCPEDI.QT, 0),11,NVL(PCPEDI.QT, 0),12,NVL(PCPEDI.QT, 0),0)) QTBNF,
SUM((DECODE(PCPEDC.CONDVENDA,5,0,6,0,11,0,12,0,1))) AS QTPEDIDOS



FROM PCPEDI, PCPEDC, PCCLIENT, PCPRODUT, PCPRACA, PCUSUARI, PCFORNEC, PCDEPTO, PCSUPERV

WHERE 1=1 
--(PCPEDC.DATA >=:DATAI AND PCPEDC.DATA <=:DATAF)
--AND (PCPEDI.DATA >=:DATAI AND PCPEDI.DATA <=:DATAF)

AND PCPEDC.DATA >= to_date('01/12/2023','dd/mm/yyyy') AND PCPEDC.DATA <= to_date('31/12/2023','dd/mm/yyyy')
AND PCPEDI.DATA >= to_date('01/12/2023','dd/mm/yyyy') AND PCPEDI.DATA <= to_date('31/12/2023','dd/mm/yyyy')

AND PCPEDI.NUMPED = PCPEDC.NUMPED
AND PCPEDI.CODPROD = PCPRODUT.CODPROD
AND PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC
AND PCPEDI.CODPROD = PCPRODUT.CODPROD
AND PCPEDC.CODCLI = PCCLIENT.CODCLI
AND PCPRODUT.CODEPTO = PCDEPTO.CODEPTO
AND  PCPEDC.CODSUPERVISOR  = PCSUPERV.CODSUPERVISOR
AND  PCPEDC.CODUSUR  = PCUSUARI.CODUSUR
AND PCPEDC.CODPRACA = PCPRACA.CODPRACA
AND PCPEDC.DTCANCEL IS NULL
AND PCPEDC.DTCANCEL IS NULL
AND PCPEDC.CODFILIAL IN ('2')


-- | Delimitado de fornecedores | --
   AND PCPRODUT.CODFORNEC IN (2901
,3175
,297
,1214
,3114
,2620
,989
,2589
,2280
,3026
,3235
,3309
,3383
,3639
,3640
,3582
,3715
,3726
,3718
,1174
,3809
,390
,3470
,405
,394
,3468
,976
,1118
,4
,1360
,3446
,1203
,403
,2971
,975
,346
,2993
,3248
,3258
,3330
,3356
,3420
,3424
,3333
,3461
,3314
,3423
,3485
,3486
,3492
,3549
,3570
,3209
,3361
,3642
,19
,3356
,3743
,3592
,14
,2946
,125
,1662
,1970
,2591
,3459
,3018
,2841
,2789
,3222
,3241
,3326
,3313
,1068
,3466
,3542
,3396
,3077
,3074
,2902
,2746
,2908
,3207
,1721
,2811
,3317
,3329
,2834
,3334
,3345
,3373
,3427
,2824
,3457
,3441
,3589
,3546
,3552
,3632
,3634
,3469
,3606
,3675
,3623   

   ) 




AND PCPEDC.CONDVENDA NOT IN (4,8,10,13,20,98,99)

GROUP BY 
PCPEDI.CODPROD, 
--PCPRODUT.DESCRICAO,
PCPRODUT.CODFORNEC, 
PCFORNEC.CODCOMPRADOR,
PCPRODUT.PESOBRUTO
ORDER BY 
PCPEDI.CODPROD


) venda,



( 
SELECT
       --PCPRODUT.CODFORNEC,  
       --PCFORNEC.FORNECEDOR, 
       PCPRODUT.CODPROD, 
       --PCPRODUT.DESCRICAO, 


       NVL(PCEST.QTGIRODIA,0) GIRODIA,

       
       ROUND((DECODE(NVL(PCEST.QTGIRODIA, 0), 
                     0, 
                     (PCEST.QTESTGER - PCEST.QTRESERV - NVL(PCEST.QTINDENIZ,0)),
                     ((PCEST.QTESTGER - PCEST.QTRESERV - NVL(PCEST.QTINDENIZ,0)) / 
                     PCEST.QTGIRODIA))), 
             6) ESTDIAS


  FROM PCPRODUT, 
       PCEST, 
       PCFORNEC, 
       PCDEPTO, 
       PCSECAO, 
       PCMARCA, 
       PCPRODFILIAL PF, 
       PCFILIAL 
 WHERE PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC
   AND PCPRODUT.CODPROD = PCEST.CODPROD
   AND PCPRODUT.CODMARCA = PCMARCA.CODMARCA(+)
   AND PCPRODUT.CODEPTO = PCDEPTO.CODEPTO(+)
   AND PCEST.CODFILIAL = PCFILIAL.CODIGO
   AND PCPRODUT.CODSEC = PCSECAO.CODSEC(+)
   AND PCEST.CODPROD = PF.CODPROD(+) 
   AND PCEST.CODFILIAL = PF.CODFILIAL(+) 
   AND PCDEPTO.TIPOMERC NOT IN ('IM', 'CI') 
   AND ((NVL(PCEST.QTESTGER, 0) - NVL(PCEST.QTRESERV, 0) - NVL(PCEST.QTINDENIZ, 0)) > 0)
   AND ((NVL(PCEST.QTESTGER, 0) - NVL(PCEST.QTRESERV, 0) - NVL(PCEST.QTINDENIZ, 0) ) > 
       (((NVL(QTGIRODIA, 0) * (NVL(PCFORNEC.PRAZOENTREGA, 0) + NVL(PCPRODUT.TEMREPOS, 0))) * 
       (1)))) 
   AND PCEST.CODFILIAL IN('2')
) giro,

(
--grid 
WITH PARAMETROS AS 
 (SELECT CODIGO, 
         NVL(PARAMFILIAL.OBTERCOMOVARCHAR2('BLOQUEIAVENDAESTPENDENTE', 
                                           PCFILIAL.CODIGO), 
             PCCONSUM.BLOQUEIAVENDAESTPENDENTE) BLOQUEIAVENDAESTPENDENTE, 
         NVL(PCFILIAL.PRECOPOREMBALAGEM, PCCONSUM.PRECOPOREMBALAGEM) PRECOPOREMBALAGEM, 
         NVL(PARAMFILIAL.OBTERCOMOVARCHAR2('USAPOLITICACOMERCIALPRODFILIAL'), 
                 'P') USAPOLITICACOMERCIALPRODFILIAL, 
         NVL(PARAMFILIAL.OBTERCOMOVARCHAR2('CON_USANEGFORNEC'), 'N') USANEGFORNEC 
    FROM PCFILIAL, 
         PCCONSUM 
   WHERE CODIGO <> '99' 
   AND CODIGO IN('2')
     AND DTEXCLUSAO IS NULL), 
 PCEST2 AS ( 
    SELECT PCEST.DTULTFAT, PCEST.QTESTGER, PCEST.QTRESERV, PCEST.QTBLOQUEADA,PCEST.QTPENDENTE, PCEST.CUSTOULTENT, 
           PCEST.CODFILIAL, PCEST.CODPROD, PCEST.DTULTENT, PCEST.DTULTSAIDA, PCEST.CUSTOFIN, PCEST.CUSTOREP, 
           PCEST.CUSTOREAL, PCEST.CUSTOPROXIMACOMPRA, PCEST.VALORULTENT, PCEST.CUSTOULTPEDCOMPRA, 
           PCEST.CUSTOULTENTFIN, PCEST.CUSTOFORNEC, PCEST.QTULTENT 
    FROM PCEST, PARAMETROS 
    WHERE PCEST.CODFILIAL = PARAMETROS.CODIGO 
 AND PCEST.CODFILIAL IN ('2')
) 
 select DISTINCT A.* from (  
SELECT DISTINCT 
       PCPRODUT.CODFORNEC, 
       PCFORNEC.FORNECEDOR, 
       PCPRODUT.CODPROD,
       NVL(PCPRODUT.DESCRICAO,'') DESCRICAO, 
       SUM(NVL(PCEST2.QTESTGER,0) * NVL(PCEST2.CUSTOREAL,0)) VLCUSTOREAL 
      
  FROM PCPRODUT, 
       PCEST2, 
       PCFORNEC, 
       PCMARCA, 
       PCLINHAPROD, 
       PCDEPTO, 
       PCSECAO, 
       PCCONSUM, 
       PARAMETROS 
 WHERE PCPRODUT.CODPROD  = PCEST2.CODPROD 
   AND PCPRODUT.CODMARCA = PCMARCA.CODMARCA(+) 
   AND PCPRODUT.CODLINHAPROD = PCLINHAPROD.CODLINHA(+) 
   AND PARAMETROS.CODIGO = PCEST2.CODFILIAL 
 AND PCPRODUT.DTEXCLUSAO IS NULL 
   AND PCPRODUT.CODEPTO = PCDEPTO.CODEPTO                                                       
   AND PCPRODUT.CODSEC = PCSECAO.CODSEC(+)                                                      
   AND NVL(PCDEPTO.TIPOMERC, 'XX') NOT IN ('IM','CI')                                     
   AND PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC                                                  
 GROUP BY PCEST2.CODFILIAL, 
          PARAMETROS.USAPOLITICACOMERCIALPRODFILIAL, 
          PARAMETROS.PRECOPOREMBALAGEM, 
          PCPRODUT.CODPROD, 
          NVL(PCPRODUT.DESCRICAO,''), 
          PCPRODUT.NUMORIGINAL, 
          NVL(PCPRODUT.EMBALAGEM, ''), 
          PCPRODUT.CODEPTO, 
          PCDEPTO.DESCRICAO, 
          PCPRODUT.CODSEC, 
          PCPRODUT.OBS2, 
          PCSECAO.DESCRICAO, 
          PCPRODUT.CODFORNEC, 
          PCFORNEC.FORNECEDOR, 
          PCFORNEC.FANTASIA, 
          PCFORNEC.CODFORNECPRINC, 
          PCPRODUT.CODFAB, 
          PCPRODUT.QTUNITCX, 
          NVL(PCMARCA.MARCA,''), 
          PCLINHAPROD.DESCRICAO, 
          PCPRODUT.CODMARCA, 
          PCPRODUT.CODLINHAPROD, 
          PCPRODUT.CLASSE, 
          PCPRODUT.CLASSEVENDA, 
          PCPRODUT.NBM 
 ) A
WHERE 1=1--A.CODPROD = :CODPROD  
ORDER BY
CODPROD
) real_,


(

WITH UNIDADE AS (                                                               
  SELECT PCPRODUT.ROWID RID                                                     
       , DECODE(NVL(PCPRODUT.QTUNITCX, 0), 0, 1, PCPRODUT.QTUNITCX) QTUNITCX    
       , DECODE(NVL(PCPRODUT.PESOBRUTO, 0), 0, 1, PCPRODUT.PESOBRUTO) PESOBRUTO 
    FROM PCPRODUT)                                                              
SELECT PCPRODUT.CODPROD

                
     , NVL(PCEST.QTESTGER,   0) QTGerencial                           
     , NVL(PCEST.QTRESERV,   0) QTRESERV                           
     , NVL(PCEST.QTPENDENTE, 0) QTPENDENTE                          
     , NVL(PCEST.QTBLOQUEADA, 0) QTBLOQUEADA                          


/*
    ///
     , NVL(PCEST.QTDEVOLMES,  0) QTDEVOLMES                          
     , NVL(PCEST.QTDEVOLMES1, 0) QTDEVOLMES1                         
     , NVL(PCEST.QTDEVOLMES2, 0) QTDEVOLMES2                         
     , NVL(PCEST.QTDEVOLMES3, 0) QTDEVOLMES3 
*/


     , PCEST.DTULTSAIDA 

     , NVL(PCEST.QTVENDMES,  0) QTVENDMES                          
     , NVL(PCEST.QTVENDMES1, 0) QTVENDMES1                         
     , NVL(PCEST.QTVENDMES2, 0) QTVENDMES2                         
     , NVL(PCEST.QTVENDMES3, 0) QTVENDMES3

                                                
     , PCEST.DTULTENT                                                                     
     , PCEST.QTULTENT
                                              
    --, pcfornec.ledtime
    , 15 as leadtime
     , NVL(PCEST.QTPEDIDA, 0) QTPEDIDA                             


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
   ORDER BY 
         PCPRODUT.CODPROD,
       PCEST.CODFILIAL


) ficha

where venda.CODPROD = giro.CODPROD
AND venda.CODPROD = real_.CODPROD
AND venda.CODPROD = ficha.CODPROD


order by
venda.CODCOMPRADOR
, venda.CODFORNEC
, venda.CODPROD