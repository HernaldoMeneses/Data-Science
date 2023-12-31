SELECT NVL(PCPRODUT.ESTOQUEPORLOTE,'N') ESTOQUEPORLOTE, 
       PCPRODUT.CODPROD, 
       PCPRODUT.DESCRICAO, 
       PCPRODUT.EMBALAGEM, 
       PCPRODUT.UNIDADE, 
       PCPRODUT.CODFAB, 
       PCPRODUT.RUA, 
       PCPRODUT.MODULO, 
       PCPRODUT.CODAUXILIAR, 
       (CASE 
         WHEN (PCPRODUT.OBS2 = 'FL' OR PCPRODFILIAL.FORALINHA = 'S') THEN 
           'FL' 
         ELSE 
           NULL 
       END) OBS2, 
       PCPRODUT.CLASSE, 
       PCPRODUT.CODMARCA, 
       (SELECT MARCA 
          FROM PCMARCA 
         WHERE CODMARCA = PCPRODUT.CODMARCA) MARCA, 
       NVL(PCEST.QTESTGER, 0) QTESTGER, 
       NVL(PCEST.QTRESERV, 0) QTRESERV, 
       (PKG_ESTOQUE.ESTOQUE_DISPONIVEL(PCEST.CODPROD, PCEST.CODFILIAL, 'V')) QTDISP, 
       NVL(PCEST.QTBLOQUEADA, 0) - NVL(PCEST.QTINDENIZ,0) AS QTBLOQUEADA, 
       NVL(PCEST.QTINDENIZ, 0) QTINDENIZ, 
       NVL(PCEST.QTINDUSTRIA, 0) QTINDUSTRIA, 
       PCEST.QTVENDMES, PCEST.QTVENDMES1, 
       PCEST.QTVENDMES2, PCEST.QTVENDMES3, 
       (SELECT PCPRINCIPATIVO.DESCRICAO 
          FROM PCPRINCIPATIVO 
         WHERE PCPRINCIPATIVO.CODPRINCIPATIVO = PCPRODUT.CODPRINCIPATIVO) AS PRINCIPIOATIVO, 
       PCPRODUT.CODFORNEC, 
       (SELECT FANTASIA 
          FROM PCFORNEC 
         WHERE CODFORNEC = PCPRODUT.CODFORNEC) FANTASIA, 
       (SELECT FORNECEDOR 
          FROM PCFORNEC 
         WHERE CODFORNEC = PCPRODUT.CODFORNEC) FORNECEDOR 
  FROM PCPRODUT, 
       PCEST, 
       PCFORNEC, 
       PCPRODFILIAL 
 WHERE PCEST.CODPROD = PCPRODUT.CODPROD 
   AND PCFORNEC.CODFORNEC = PCPRODUT.CODFORNEC 
   AND (PCPRODUT.CODFILIAL IS NULL OR 
        PCPRODUT.CODFILIAL = '99' OR 
        PCPRODUT.CODFILIAL = PCEST.CODFILIAL) 
   AND PCEST.CODPROD = PCPRODFILIAL.CODPROD(+) 
   AND PCEST.CODFILIAL = PCPRODFILIAL.CODFILIAL(+) 
   AND PCEST.CODFILIAL = 2
   AND (CASE 
         WHEN (SELECT COUNT (1) 
                 FROM PCPRODFILIAL 
                WHERE CODPROD = PCPRODUT.CODPROD 
                  AND CODFILIAL = PCEST.CODFILIAL 
                  AND NVL(PROIBIDAVENDA, 'N') = 'S') > 0 THEN 
           1 
         ELSE 
           (CASE 
             WHEN ((SELECT COUNT (1) 
                      FROM PCPRODUT P 
                     WHERE P.CODPROD = PCPRODUT.CODPROD 
                       AND P.OBS = 'PV') > 0) THEN 
               1 
             ELSE 
               0 
           END) 
       END) = 0 
   AND (((PCPRODUT.OBS2 NOT IN ('FL')) OR (PCPRODUT.OBS2 IS NULL)) AND
 ((PCPRODFILIAL.FORALINHA = 'N') OR (PCPRODFILIAL.FORALINHA IS NULL)))
ORDER BY PCPRODUT.CODPROD