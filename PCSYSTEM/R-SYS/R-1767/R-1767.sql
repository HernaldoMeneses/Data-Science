--SQL do Relatorio Analitico 
SELECT 
  I.data 
  ,DECODE(:CONDVENDA,-1,'TODOS',:CONDVENDA) CONDVENDA
  ,decode(c.numcar,null,i.numcar,c.numcar) numcar 
  ,p.codprod 
  , decode (p.pesovariavel ,'S', 'Sim','N','Não' ) as pesovariavel
  , p.pesopeca
  , p.pesoembalagem 
  ,decode(p.tipoestoque, 'PA','Padrão', 'FR','Frios' ) as tipoestoque 
  ,(case when p.pesovariavel = 'S' and  p.tipoestoque = 'FR' then (ceil (i.qtseparada / decode (p.pesopeca,0,1,p.pesopeca) )) 
else 0 end) as qtpecas 
 ,(select qtestger from pcest where codprod=p.codprod and codfilial = :filial) qtestger
  ,P.descricao 
  ,(I.QTSEPARADA + I.qtcortada) QTORIGINAL 
  ,((I.QTSEPARADA + I.qtcortada)* I.pvenda) VLORIGINAL 
  ,(I.qtcortada) qtCortada 
  ,(I.qtcortada * I.pvenda) VLCORTADO 
  ,(I.QTSEPARADA) QT 
  ,(I.QTSEPARADA * I.pvenda) VLSEPARADO 
  ,((100 * NVL(I.qtcortada,0))/(case when (I.QTSEPARADA + I.qtcortada)>0 then (I.QTSEPARADA + I.qtcortada) else 1  end) ) 
PerCorte 
  ,i.codfunc 
  ,(Select emp.nome from Pcempr emp where emp.matricula=i.codfunc ) nomeFunc 
  ,i.numped 
  ,p.codepto 
  ,p.codfornec 
  ,(I.QTSEPARADA *I.pvenda) VLATENDIDO 
  ,decode(:quebra,
          0, to_char(p.codepto),
          1,to_char(p.codfornec),
          2, to_char(C.numcar),
          3, to_char(p.codprod),
          4, (select cli.cliente from pcclient cli where cli.codcli = c.codcli),
          5,(select pcusuari.NOME from pcusuari where pcusuari.CODUSUR = c.CODUSUR),
         -1) quebra 
  ,(p.codfornec || ' - ' || f.fornecedor) fornecedor
  ,('DEPARTAMENTO: ' ||  p.codepto) dptoLabel 
  ,('CARREGAMENTO: ' || C.numcar) carLabel 
  ,('PRODUTO: ' ||  p.codprod) prodLabel 
,(select max(deposito) from pcendereco where codendereco in 
(select k.codendereco from pcprodutpicking k where k.codprod = p.codprod and k.codfilial = '2'))depositoap 
,(select max(rua) from pcendereco where codendereco in 
(select k.codendereco from pcprodutpicking k where k.codprod = p.codprod and k.codfilial = '2'))ruaap 
,(select max(predio) from pcendereco where codendereco in 
(select k.codendereco from pcprodutpicking k where k.codprod = p.codprod and k.codfilial = '2'))predioap 
,(select max(nivel) from pcendereco where codendereco in 
(select k.codendereco from pcprodutpicking k where k.codprod = p.codprod and k.codfilial = '2'))nivelap 
,(select max(apto) from pcendereco where codendereco in 
(select k.codendereco from pcprodutpicking k where k.codprod = p.codprod and k.codfilial = '2'))aptoap 
  ,i.hora 
  ,i.minuto 
  ,case when exists (select dev.motivo from pctabdev dev where cast(dev.coddevol as varchar2(15)) = i.motivo) then 
    (select dev.motivo from pctabdev dev where dev.coddevol=NVL(i.motivo,'0')) 
   else 
    i.motivo 
  end motivo 
  ,(select cli.cliente from pcclient cli where cli.codcli = decode(c.codcli,null,i.codcli,c.codcli)) cliente 
  ,(select cli.codcli || ' - ' || cli.cliente from pcclient cli where cli.codcli = decode(c.codcli,null,i.codcli,c.codcli)) 
clientedesc 
  ,(select cli.fantasia from pcclient cli where cli.codcli = decode(c.codcli,null,i.codcli,c.codcli)) nomefantasia 
  ,(select pcusuari.NOME from pcusuari where pcusuari.CODUSUR = c.CODUSUR) RCA 
  /*--,:dtIni FILTRO_DTINICIAL
  --,:dtFim FILTRO_DTFINAL
  --,:filial FILTRO_FILIAL
  ,DECODE(:numcarini,-1,'Todos',:numcarini) FILTRO_NUMCAR_INICIAL
  ,DECODE(:numcarfim,-1,'Todos',:numcarfim) FILTRO_NUMCAR_FINAL
  ,DECODE(:condvenda,-1,'Todos',:condvenda) FILTRO_CONDVENDA
  ,DECODE(:tipocorte,-1,'Todos',:tipocorte) FILTRO_TIPOCORTE
  ,DECODE(:forn,     -1,'Todos',:forn)      FILTRO_FORNECEDOR
  ,DECODE(:prod,     -1,'Todos',:prod)      FILTRO_PRODUTO
  ,DECODE(:depto,    -1,'Todos',:depto)     FILTRO_DEPTO
  ,DECODE(:codusur,  -1,'Todos',:codusur)   FILTRO_RCA
  */
  ,(select cli.fantasia from pcclient cli where cli.codcli = c.codcli) nomefantasia 
FROM pccortei i 
  ,pcprodut p 
  ,pcpedc c 
  ,pcfornec F 
WHERE I.numped = C.numped(+) 
 and i.data + (i.hora / 24) +( i.minuto/1440) between to_date('01/03/2024', 'DD/MM/YY HH24:MI:SS') and to_date('16/03/2024', 'DD/MM/YY HH24:MI:SS') 
AND i.codprod=p.codprod 
AND f.codfornec=p.codfornec 
AND NVL(i.codfilial,'1') = '2'
AND I.data between to_date('01/03/2024', 'DD/MM/YY HH24:MI:SS') and to_date('16/03/2024', 'DD/MM/YY HH24:MI:SS') 

/**
AND (p.CODFORNEC=:forn or :forn =-1) 
AND (P.CODPROD = :prod OR :prod = -1) 
AND (P.codepto = :depto or :depto = -1) 
AND (c.codusur = :codusur or :codusur = 0) 
AND ((nvl(c.numcar,nvl(i.numcar,0)) between :numcarini and :numcarfim ) or (:numcarini = -1)) 
AND (C.condvenda = :condvenda or :condvenda = -1)
*/
ORDER BY 
p.codepto
,I.data

