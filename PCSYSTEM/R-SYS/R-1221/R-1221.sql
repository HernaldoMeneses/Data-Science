SELECT 
S.CODSUPERVISOR,
U.CODUSUR,
C.CODCLI, 
P.DUPLIC, P.DTEMISSAO, P.NUMBANCO,P.NUMCHEQUE,P.NUMAGENCIA,P.NUMCONTACORRENTE,    
 CASE                                                                               
  WHEN ((NVL(P.DTRECEBIMENTOPREVISTO, P.DTVENC) > P.DTVENC) AND (P.TXPERMPREVISTO > 0)) THEN 
    P.DTRECEBIMENTOPREVISTO                                                   
  ELSE  P.DTVENC                                                              
  END DTVENC,                                                                       
P.VALOR, C.CLIENTE, C.FANTASIA, P.CODCLI, P.CODFILIAL, P.PREST,P.DVAGENCIA,P.DVCONTA,P.DVCHEQUE,  
(P.VALOR + NVL(P.TXPERMPREVISTO, 0)) VALORCOMJURPREV,                                             
P.CODCOB, P.VALORDESC, LTRIM(RTRIM(P.OBS2)) OBS2, LTRIM(RTRIM(P.OBS)) OBS,                        
( ( ( P.VALOR-NVL(P.VALORDESC,0))+NVL(P.TXPERM,0))-NVL(P.VPAGO,0)) AS SALDO,                      
U.NOME, U.CODUSUR, P.NUMTRANSVENDA, P.DTVENCORIG, NVL(P.VALORORIG,0) VALORORIG,                   
C.OBSERVACAO AS OBSADICIONAIS, C.NUMEROENT, P.DTRECEBIMENTOPREVISTO,                              
CASE WHEN P.DTRECEBIMENTOPREVISTO >= TRUNC(SYSDATE) THEN 'Sim' ELSE 'N o' END JUROSNEGOCIADO, 
P.TXPERMPREVISTO, P.TXPERMPREVREAL,                                                               
       CASE                                                                                       
           WHEN P.DTRECEBIMENTOPREVISTO >= TRUNC(SYSDATE)  THEN                                   
            '**'                                                                                
           ELSE                                                                                   
            ''                                                                                  
         END TITULOCOMDATAPREVISTA,                                                               
0 DiasAtraso,                                                                                     
0 JurosCalc,                                                                                      
0 JurosCalc2,                                                                                     
0 ValorPagar,                                                                                     
(SELECT MAX(N.NUMNOTA)                                                                            
 FROM   PCNFSAID N                                                                                
 WHERE  P.NUMTRANSVENDA = NVL(N.NUMTRANSVENDAORIGEM, N.NUMTRANSVENDA)                             
   AND  N.CODFILIAL = P.CODFILIAL                                                                 
   AND  N.NUMCAR    = P.NUMCAR                                                                    
   ) AS NUMNOTA,                                                                                  
NVL(P.CODUSUR2,0) AS CODUSUR2,                                                                    
NVL(P.CODUSUR3,0) AS CODUSUR3,                                                                    
NVL(P.CODUSUR4,0) AS CODUSUR4                                                                     
FROM PCPREST P, PCCLIENT C, PCUSUARI U, PCSUPERV S                                                
WHERE C.CODCLI = P.CODCLI                                                                         
AND  P.DTPAG IS NULL                                                                              
AND P.CODUSUR = U.CODUSUR
AND U.CODSUPERVISOR = S.CODSUPERVISOR                                                      
   AND (P.CODFILIAL IN ( '2' )) 
AND P.DTVENC BETWEEN :DTVENC1 AND :DTVENC2                                                    
--AND U.CODSUPERVISOR = :SUPERVISOR                                                           
--AND P.CODUSUR = :RCA


--AND P.VALOR BETWEEN :VLRINI AND :VLRFIM  
AND P.VALOR > 0                                                        
  AND --Script para retornar apenas registros com permiss o rotina 131  
 EXISTS( SELECT 1                                                 
           FROM PCLIB                                             
          WHERE CODTABELA = TO_CHAR(8)                           
            AND (CODIGOA  = NVL(P.CODCOB, CODIGOA) OR CODIGOA = '9999') 
            AND CODFUNC   = 1043                                    
            AND PCLIB.CODIGOA IS NOT NULL)                        
   AND (P.CODCOB IN ( '104','237','CHDV','JUR','PEND','PROT' )) 
ORDER BY P.DTPAG, P.CODSUPERVISOR, P.CODUSUR, P.DTVENC