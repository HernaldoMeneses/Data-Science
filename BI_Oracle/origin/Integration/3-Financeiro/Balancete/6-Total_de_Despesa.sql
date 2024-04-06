SELECT 
'6-Total de Despesas' AS INDICADOR,  
PCLANC.CODFILIAL AS CODIGOFILIAL,
PCLANC.DTPAGTO AS DATA ,       
(nvl(PCLANC.VPAGO, 0) * (-1))  AS VALOR
/*                                                                                
       (DECODE(PCCONTA.TIPO,'R',0,                                                                                            
 CASE WHEN PCLANC.CODCONTA = PCCONSUM.CODCONTAADIANTFOR OR                                                                         
             PCLANC.CODCONTA = PCCONSUM.CODCONTAADIANTFOROUTROS THEN                                                               
             ((NVL(PCLANC.VALOR, 0)) -                                                                                          
             (NVL(PCLANC.VLRUTILIZADOADIANTFORNEC, 0)) +                                                                        
             (NVL(PCLANC.VLVARIACAOCAMBIAL, 0))) * (-1)                                                                         
   ELSE                                                                                                                            
     (nvl(PCLANC.VPAGO, 0) * (-1)) END )) VALOR                                                                   */
FROM  PCLANC, PCCONTA, PCNFSAID /*, PCCONSUM  */
WHERE PCLANC.CODCONTA = PCCONTA.CODCONTA(+)         
AND PCLANC.DTPAGTO IS NOT NULL     
AND PCLANC.NUMTRANSVENDA = PCNFSAID.NUMTRANSVENDA(+)
AND NVL(PCLANC.CODROTINABAIXA,0) <> 737                                
AND NVL (PCNFSAID.CONDVENDA, 0) NOT IN (10, 20, 98, 99)   
AND NVL(PCNFSAID.CODFISCAL,0) NOT IN (522,622,722,532,632,732) 
AND (NOT EXISTS (SELECT D.NUMTRANSENT     
                 FROM PCESTCOM D, PCNFSAID N         
                 WHERE D.NUMTRANSENT = PCLANC.NUMTRANSENT 
                 AND D.NUMTRANSVENDA = N.NUMTRANSVENDA          
                 AND N.CONDVENDA IN (20)))         
AND (PCLANC.DTPAGTO IS NOT NULL) 
AND NVL(PCLANC.VPAGO,0) <> 0        
AND (NVL(PCCONTA.INVESTIMENTO,'N') <> 'S')      
AND PCCONTA.GRUPOCONTA >= 200  
AND PCCONTA.GRUPOCONTA <= 900     
AND TO_CHAR(PCLANC.DTPAGTO, 'YYYY') >= TO_CHAR(SYSDATE, 'YYYY') - 10