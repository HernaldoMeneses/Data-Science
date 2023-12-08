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
distinct(giro.codfornec)
, giro.CODPROD
, round(giro.GIRODIA,2) as GIRODIA
, round(giro.ESTDIAS,2) as ESTDIAS
, round(giro.ESTDIAS-3-ficha.leadtime,0) as stodiasrepo
--, to_date(to_date(SYSDATE,'dd/mm/yyyy') + round(giro.ESTDIAS-3-ficha.leadtime,0),'dd/mm/yyyy') as repor
, TO_CHAR(ADD_month(sysdate, +  round(giro.ESTDIAS-3-ficha.leadtime,0))) as repor
, round(real_.VLCUSTOREAL,2) AS VLCUSTOREAL

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
       PCPRODUT.CODFORNEC,  
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
   --H.Matrix
   AND PCPRODUT.OBS2 != 'FL'
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

where giro.CODPROD = real_.CODPROD
AND giro.CODPROD = ficha.CODPROD

order by repor, codfornec