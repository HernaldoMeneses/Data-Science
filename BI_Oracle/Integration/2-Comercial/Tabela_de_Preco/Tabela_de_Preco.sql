SELECT  
AB.CODPROD AS CODIGOPRODUTO,
AB.NUMREGIAO AS NUMEROREGIAO,
AB.PTABELA AS PRECOTABELA,
AB.PVENDA AS PRECOVENDA,
AB.PTABELA1 AS PRECOTABELA1,
AB.PTABELA2 AS PRECOTABELA2,
AB.PTABELA3 AS PRECOTABELA3,
AB.PTABELA4 AS PRECOTABELA4,
AB.PTABELA5 AS PRECOTABELA5,
AB.VLST AS VALORST,
TRI.IVA AS VALORIVA,
TRI.PAUTA AS VALORPAUTA
FROM PCTABPR AB, PCTRIBUT TRI
where AB.CODST = TRI.CODST