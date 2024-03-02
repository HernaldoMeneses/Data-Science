-- CODSUPERV | CODUSUR | VLTOTAL
SELECT --Obj1.4_init
  PCUSUARI.CODSUPERVISOR,
  PCUSUARI.CODusur,
  DECODE(SUM(PCNFENT.VLTOTAL),0,SUM(PCESTCOM.VLDEVOLUCAO),SUM(PCNFENT.VLTOTAL)) AS VLTOTAL
  FROM PCNFENT, PCESTCOM, PCTABDEV, PCCLIENT, PCEMPR, PCUSUARI, PCSUPERV, PCEMPR FUNC, PCNFSAID, PCDEVCONSUM
 WHERE  ( PCNFENT.CODDEVOL = PCTABDEV.CODDEVOL(+) )
   AND PCNFENT.NUMTRANSENT = PCESTCOM.NUMTRANSENT (+)
   AND   ( PCNFENT.CODFORNEC  = PCCLIENT.CODCLI )
   AND ( PCNFENT.NUMTRANSENT = PCDEVCONSUM.NUMTRANSENT(+) )
   AND NVL(PCNFENT.CODFILIALNF, PCNFENT.CODFILIAL) = :COD_FILIAL
   AND   ( PCNFENT.CODFUNCLANC       = FUNC.MATRICULA(+))
   AND   ( PCNFENT.CODMOTORISTADEVOL = PCEMPR.MATRICULA(+))
   AND   (  PCNFENT.CODUSURDEVOL  = PCUSUARI.CODUSUR )
   AND   ( PCUSUARI.CODSUPERVISOR    = PCSUPERV.CODSUPERVISOR(+))
   AND   ( PCNFENT.DTENT BETWEEN  :DTINICIO AND :DTFIM  )
   AND   ( PCNFENT.TIPODESCARGA IN ('6','7','T') ) 
   AND   ( NVL(PCNFENT.OBS, 'X') <> 'NF CANCELADA')
   AND   ( PCNFENT.CODFISCAL IN ('131','132','231','232','199','299') )
   AND EXISTS (SELECT PCPRODUT.CODPROD 
                 FROM PCPRODUT, PCMOV
                WHERE PCMOV.CODPROD = PCPRODUT.CODPROD
                  AND PCMOV.NUMTRANSENT = PCNFENT.NUMTRANSENT
                  AND PCMOV.NUMNOTA = PCNFENT.NUMNOTA
                  AND PCMOV.DTCANCEL IS NULL
                  AND ( EXISTS ( SELECT CODEPTO 
                                   FROM PCDEPTO 
                                  WHERE PCPRODUT.CODEPTO = PCDEPTO.CODEPTO 
                                    AND PCDEPTO.CODEPTO NOT IN (9999, 999999) 
                                    AND ((SELECT COUNT(1) 
                                            FROM PCLIB 
                                           WHERE CODTABELA = 2 
                                             --AND PCLIB.CODFUNC = :CODFUNCX 
                                             AND ((PCLIB.CODIGON = 9999) OR (PCLIB.CODIGON = 999999))) > 0 
                                              OR (SELECT COUNT(1) 
                                                    FROM PCLIB 
                                                   WHERE CODTABELA = 2 
                                                     --AND PCLIB.CODFUNC = :CODFUNCX 
                                                     AND PCLIB.CODIGON = PCDEPTO.CODEPTO 
                                                     AND PCLIB.CODIGON IS NOT NULL) > 0))) 
                                                     AND (EXISTS (SELECT CODFORNEC 
                                                                    FROM PCFORNEC 
                                                                   WHERE PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC 
                                                                     AND PCFORNEC.CODFORNEC NOT IN (9999, 999999) 
                                                                     AND ((SELECT COUNT(1) 
                                                                            FROM PCLIB 
                                                                           WHERE CODTABELA = 3 
                                                                             --AND PCLIB.CODFUNC = :CODFUNCX 
                                                                             AND ((PCLIB.CODIGON = 9999) OR (PCLIB.CODIGON = 999999))) > 0 
                                                                              OR (SELECT COUNT(1) 
                                                                                    FROM PCLIB 
                                                                                   WHERE CODTABELA = 3 
                                                                                     --AND PCLIB.CODFUNC = :CODFUNCX 
                                                                                     AND PCLIB.CODIGON = PCFORNEC.CODFORNEC 
                                                                                     AND PCLIB.CODIGON IS NOT NULL) > 0))) 
                                                                                     AND PCMOV.CODFILIAL = PCNFENT.CODFILIAL)
                                                                                     AND (EXISTS (SELECT CODSUPERVISOR 
                                                                                                    FROM PCUSUARI 
                                                                                                   WHERE PCUSUARI.CODSUPERVISOR = PCUSUARI.CODSUPERVISOR 
                                                                                                     AND PCUSUARI.CODSUPERVISOR NOT IN (9999, 999999) 
                                                                                                     AND ((SELECT COUNT(1) 
                                                                                                            FROM PCLIB 
                                                                                                           WHERE CODTABELA = 7 
                                                                                                             --AND PCLIB.CODFUNC = :CODFUNCX 
                                                                                                             AND ((PCLIB.CODIGON = 9999) OR (PCLIB.CODIGON = 999999))) > 0 
                                                                                                              OR (SELECT COUNT(1) 
                                                                                                                    FROM PCLIB 
                                                                                                                   WHERE CODTABELA = 7 
                                                                                                                     --AND PCLIB.CODFUNC = :CODFUNCX 
                                                                                                                     AND PCLIB.CODIGON = PCUSUARI.CODSUPERVISOR 
                                                                                                                     AND PCLIB.CODIGON IS NOT NULL) > 0))) 
                                                                                                                     AND PCESTCOM.NUMTRANSVENDA = PCNFSAID.NUMTRANSVENDA(+) 
                                                                                                                     AND NVl(PCNFSAID.CONDVENDA,0) NOT IN (4, 8, 10, 13, 20, 98, 99)
                                                                                                                     AND PCESTCOM.NUMTRANSVENDA = PCNFSAID.NUMTRANSVENDA(+) 
GROUP BY     
  PCUSUARI.CODSUPERVISOR,
  PCUSUARI.CODusur
  --PCNFENT.VLTOTAL,
  --PCESTCOM.VLDEVOLUCAO                     
ORDER BY    
  PCUSUARI.CODSUPERVISOR,
  PCUSUARI.CODusur