select tab1.CODFORNEC, tab1.FORNECEDOR, tab1.codprod, tab1.DESCRICAO,
round(tab1.qtvend4/sum(datas.QUANTIDADEDIASUTIL),2) as GiroDia,
tab1.custoreal, 
round(round(tab1.qtvend4/sum(datas.QUANTIDADEDIASUTIL),2) * tab1.custoreal,2) as custodia

 from (
SELECT 
PCPRODUT.CODFORNEC,
       (SELECT FORNECEDOR 
          FROM PCFORNEC 
         WHERE CODFORNEC = PCPRODUT.CODFORNEC) FORNECEDOR ,
       PCPRODUT.CODPROD, 
       PCPRODUT.DESCRICAO, 

       (PCEST.QTVENDMES + PCEST.QTVENDMES1 + 
       PCEST.QTVENDMES2 + PCEST.QTVENDMES3) qtvend4,
       pcest.custoreal

  FROM PCPRODUT, 
       PCEST, 
       PCFORNEC, 
       PCPRODFILIAL 
 WHERE PCEST.CODPROD = PCPRODUT.CODPROD 
   AND PCFORNEC.CODFORNEC = PCPRODUT.CODFORNEC 
   --AND PCFORNEC.CODFORNEC = 3175
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
) tab1, (
select 
 a.data as TheDate,

CASE WHEN DIAUTIL = 'N' THEN 'DIA NÃO ÚTIL' ELSE 'DIA ÚTIL' END AS DIAUTIL,


CASE WHEN (DIAUTIL = 'S'  OR DIAUTIL IS NULL )THEN 1 ELSE 0 END AS QUANTIDADEDIASUTIL,
CASE WHEN DIAUTIL = 'N' THEN 1 ELSE 0 END AS QUANTIDADEDIASNAOUTIL
 
from 
   pcdatas a

where
    --TO_CHAR( a.data , 'YYYY') >= TO_CHAR(ADD_MONTHS(SYSDATE, -132), 'YYYY')
    a.data >= to_date('01/12/2023','dd/mm/yyyy')
    and a.data <= to_date('29/02/2024','dd/mm/yyyy')

) datas

group by
tab1.CODFORNEC, tab1.FORNECEDOR, tab1.codprod, tab1.DESCRICAO,
tab1.qtvend4, tab1.custoreal