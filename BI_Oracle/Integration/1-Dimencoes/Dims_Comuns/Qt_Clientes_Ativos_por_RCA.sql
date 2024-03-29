SELECT 
DISTINCT(CODUSUR)
,COUNT(DISTINCT(CODCLI)) QTCLIATIVOS
   FROM (SELECT A.CODUSUR, PCCLIENT.CODCLI
 FROM PCCLIENT, PCUSUARI A
          WHERE PCCLIENT.CODUSUR1 = A.CODUSUR
            AND (PCCLIENT.DTULTCOMP >= (TRUNC(SYSDATE - 90)))
            --AND A.CODUSUR = :CODUSUR 
            AND A.CODSUPERVISOR NOT IN ('9999', '999999')
AND (A.CODFILIAL IN ('2') OR (NVL(A.CODFILIAL,'99') = '99' ))
 
         UNION
         SELECT B.CODUSUR, PCCLIENT.CODCLI
           FROM PCCLIENT, PCUSUARI B
          WHERE PCCLIENT.CODUSUR2 = B.CODUSUR
            AND (PCCLIENT.DTULTCOMP >= (TRUNC(SYSDATE - 90)))
            --AND B.CODUSUR = :CODUSUR 
            AND B.CODSUPERVISOR NOT IN ('9999', '999999')
AND (B.CODFILIAL IN ('2') OR (NVL(B.CODFILIAL,'99') = '99' ))
 
         UNION
         SELECT C.CODUSUR C, PCCLIENT.CODCLI
           FROM PCCLIENT, PCUSURCLI, PCUSUARI C
          WHERE PCCLIENT.CODCLI = PCUSURCLI.CODCLI
            AND PCUSURCLI.CODUSUR = C.CODUSUR
            AND (PCCLIENT.DTULTCOMP >= (TRUNC(SYSDATE - 90)))
            --AND PCUSURCLI.CODUSUR = :CODUSUR 
            AND C.CODSUPERVISOR NOT IN ('9999', '999999')
AND (C.CODFILIAL IN ('2') OR (NVL(C.CODFILIAL,'99') = '99' )))
group by
CODUSUR