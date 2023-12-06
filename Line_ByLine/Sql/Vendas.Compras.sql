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
SELECT
to_date(PCPEDI.DATA,'dd/mm/yyyy') as Data, 
PCFORNEC.CODCOMPRADOR,
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

   round(SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') <> 'N' THEN 0 ELSE NVL(PCPEDI.QT, 0) / 
DECODE(NVL(PCPRODUT.QTUNITCX,0),0,1,PCPRODUT.QTUNITCX) END,5,0,6,0,11,0,12,0,NVL(PCPEDI.qt, 0)
  / DECODE(NVL(PCPRODUT.QTUNITCX,0),0,1,PCPRODUT.QTUNITCX))),2) AS QTCX,

  
SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') = 'S' THEN NVL(PCPEDI.QT, 0) ELSE 0 END,5,NVL(PCPEDI.QT, 0),6,
NVL(PCPEDI.QT, 0),11,NVL(PCPEDI.QT, 0),12,NVL(PCPEDI.QT, 0),0)) QTBNF,
SUM((DECODE(PCPEDC.CONDVENDA,5,0,6,0,11,0,12,0,1))) AS QTPEDIDOS



FROM PCPEDI, PCPEDC, PCCLIENT, PCPRODUT, PCPRACA, PCUSUARI, PCFORNEC, PCDEPTO, PCSUPERV

WHERE 1=1 

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
   AND PCPRODUT.CODFORNEC IN (2901 ,3175 ,297 ,1214 ,3114 ,2620,989,2589,2280,3026
,3235,3309,3383,3639,3640,3582,3715,3726,3718,1174
,3809,390,3470,405,394,3468,976,1118,4,1360,3446
,1203,403,2971,975,346,2993,3248,3258,3330,3356,3420
,3424,3333,3461,3314,3423,3485,3486,3492,3549,3570,3209
,3361,3642,19,3356,3743,3592,14,2946,125,1662,1970
,2591,3459,3018,2841,2789,3222,3241,3326,3313,1068
,3466,3542,3396,3077,3074,2902,2746,2908,3207,1721,2811
,3317,3329,2834,3334,3345,3373,3427,2824,3457,3441,3589
,3546,3552,3632,3634,3469,3606,3675,3623   

   ) 




AND PCPEDC.CONDVENDA NOT IN (4,8,10,13,20,98,99)

GROUP BY
PCPEDI.DATA, 
PCPEDI.CODPROD, 
--PCPRODUT.DESCRICAO,
PCPRODUT.CODFORNEC, 
PCFORNEC.CODCOMPRADOR,
PCPRODUT.PESOBRUTO
ORDER BY 
PCPEDI.DATA,
PCPEDI.CODPROD

