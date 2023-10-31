SELECT
/*  Columns without functios agrup
*       General Dins
*/
    Min(PCPEDC.DATA) AS Init_
    , Max(PCPEDC.DATA) As END_

    , PCPEDC.CODFILIAL 
    , PCPEDC.CODGERENTE
    , PCPEDC.CODSUPERVISOR AS CODSUPERV
    , PCSUPERV.NOME AS SUPERVISOR
    --, PCPEDC.POSICAO

    , PCPEDC.CODUSUR AS COd_VEndedor
    , PCUSUARI.NOME AS Vendedor

    --, PCPRODUT.CODEPTO
    , PCFORNEC.codfornec
    , PCPRODUT.CODPROD
    , PCPRODUT.DESCRICAO
    , PCPEDC.CODCLI
    , PCCLIENT.CLIENTE

/*Columns with functions agrup*/

/*Init Venda*/
    ,   SUM(CASE                                                                                                                            
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
             ELSE  0  END) - SUM(CASE                                                                                                                 
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
                        ELSE 0 END) VLVENDA,
/*End Venda*/ 

   SUM((PCPEDI.qt)*NVL(PCPEDI.vlcustofin,0)) AS VLCUSTOFIN,
   SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') <> 'N' THEN 0 ELSE NVL(PCPEDI.QT, 0) END,5,0,6,0,11,0,12,0,
NVL(PCPEDI.QT,0))) QT,
SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') IN ('S','F') THEN NVL(PCPEDI.QT, 0) ELSE 0 END,5,NVL(PCPEDI.QT,
 0),6,NVL(PCPEDI.QT, 0),11,NVL(PCPEDI.QT, 0),12,NVL(PCPEDI.QT, 0),0)) QTBNF,
COUNT(DISTINCT PCCLIENT.CODCLI) AS QTCLIENTE,
SUM( NVL(PCPEDI.QT,0) * NVL(PCPRODUT.PESOBRUTO,0) ) AS PESO,
COUNT(DISTINCT(PCPEDC.NUMPED)) AS QTPED, 
       SUM(DECODE(PCPEDC.CONDVENDA,                                                                                                        
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
                  0)) VLBONIFIC                                                                                                            
FROM 
    PCPEDI
    , PCPEDC
    , PCSUPERV
    , PCPRODUT
    , PCDEPTO
    , PCCLIENT
    , PCUSUARI
    , PCPRACA
    , PCFORNEC

WHERE 1=1
/*Fill Date
    AND PCPEDI.DATA >= to_date('01/10/2023','dd/mm/yyyy')  AND PCPEDI.DATA <= to_date('31/10/2023','dd/mm/yyyy') 
    AND PCPEDC.DATA >= to_date('01/10/2023','dd/mm/yyyy')  AND PCPEDC.DATA <= to_date('31/10/2023','dd/mm/yyyy') 
*/
/*Fill Date dinamic*/
    AND PCPEDI.DATA >= to_date(:Data_init,'dd/mm/yyyy')  AND PCPEDI.DATA <= to_date(:Data_fim,'dd/mm/yyyy') 
    AND PCPEDC.DATA >= to_date(:Data_init,'dd/mm/yyyy')  AND PCPEDC.DATA <= to_date(:Data_fim,'dd/mm/yyyy') 

/*Relatios*/
    AND PCPEDI.NUMPED = PCPEDC.NUMPED
    AND  PCPEDC.CODSUPERVISOR  = PCSUPERV.CODSUPERVISOR
    AND PCPEDI.CODPROD = PCPRODUT.CODPROD
    AND PCPRODUT.CODEPTO = PCDEPTO.CODEPTO
    AND  PCPEDC.CODUSUR  = PCUSUARI.CODUSUR
    AND PCPEDC.CODCLI = PCCLIENT.CODCLI
    AND PCPEDC.CODPRACA = PCPRACA.CODPRACA
    AND PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC

/*ParametsFills rESTICTIONS*/
    AND PCPEDC.DTCANCEL IS NULL
    AND PCPEDC.CODFILIAL IN ('2')
    AND PCPEDC.CONDVENDA NOT IN (4,8,10,13,20,98,99)

--AND PCPRODUT.CODFORNEC = 3715 -- Leblom
--AND PCPRODUT.CODFORNEC = 3091 -- Massa Leve
    AND PCPRODUT.CODFORNEC = (:COD_Fornec)

/*General Grup for all columns without function agrup in line*/
GROUP BY
    PCPEDC.CODFILIAL 
    , PCPEDC.CODGERENTE
    , PCPEDC.CODSUPERVISOR
    , PCSUPERV.NOME
    --, PCPEDC.POSICAO

    , PCPEDC.CODUSUR
    , PCUSUARI.NOME

    --, PCPRODUT.CODEPTO
    , PCFORNEC.codfornec
    , PCPRODUT.CODPROD
    , PCPRODUT.DESCRICAO
    , PCPEDC.CODCLI
    , PCCLIENT.CLIENTE
ORDER BY 
    VLVENDA