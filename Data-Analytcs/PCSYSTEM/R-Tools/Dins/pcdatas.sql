select 
 a.data,
 substr(to_char(a.data),1,2) as dia,
 substr(to_char(a.data),4,2) as mes,
 substr(to_char(a.data),7,4) as ano,
 case
      when (substr(to_char(a.data),4,2) in ('01')) then '1-JAN'
      when (substr(to_char(a.data),4,2) in ('02')) then '2-FEV'
      when (substr(to_char(a.data),4,2) in ('03')) then '3-MAR'
      when (substr(to_char(a.data),4,2) in ('04')) then '4-ABR'
      when (substr(to_char(a.data),4,2) in ('05')) then '5-MAI'
      when (substr(to_char(a.data),4,2) in ('06')) then '6-JUN'
      when (substr(to_char(a.data),4,2) in ('07')) then '7-JUL'
      when (substr(to_char(a.data),4,2) in ('08')) then '8-AGO'
      when (substr(to_char(a.data),4,2) in ('09')) then '9-SET'
      when (substr(to_char(a.data),4,2) in ('10')) then '10-OUT'
      when (substr(to_char(a.data),4,2) in ('11')) then '11-NOV'
      when (substr(to_char(a.data),4,2) in ('12')) then '12-DEZ'  
      else 'try'
 end as mesabrv,
 
 a.diautil,
 

CASE WHEN DIAUTIL = 'N' THEN 'DIA NÃO ÚTIL' ELSE 'DIA ÚTIL' END AS DIAUTIL,
CASE WHEN (DIAUTIL = 'S'  OR DIAUTIL IS NULL )THEN 1 ELSE 0 END AS QUANTIDADEDIASUTIL,
CASE WHEN DIAUTIL = 'N' THEN 1 ELSE 0 END AS QUANTIDADEDIASNAOUTIL
 
from 
   pcdatas a
   
   

   
