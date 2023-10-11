select distinct(f.codfornec)
, f.fornecedor  
 from pcprodut p , pcfornec f
 where p.codfornec = f.codfornec
 and p.descricao like '%LC COXINHA PRE%'
 order by f.codfornec
 
 --like ('Sheffa','Bonita','Casamia','Marcoboni','Asa', 'Palmeiron', 'Vitamilho', 'Cabeça de Touro', 'Tourinho')