select 
 a.data as TheDate,
 to_number(substr(to_char(a.data),7,4)) as Ano,
 
 case
     when to_number(substr(to_char(a.data),4,2)) in (1,2,3) then '1°-Trimestre'
     when to_number(substr(to_char(a.data),4,2)) in (4,5,6) then '2°-Trimestre'
     when to_number(substr(to_char(a.data),4,2)) in (7,8,9) then '3°-Trimestre'
     when to_number(substr(to_char(a.data),4,2)) in (10,11,12) then '4°-Trimestre'
     else 'try'
 end as Trimestre,
 
 to_number(substr(to_char(a.data),4,2)) as MesNumero,
 
  case
      when (substr(to_char(a.data),4,2) in ('01')) then '1-Janeiro'
      when (substr(to_char(a.data),4,2) in ('02')) then '2-Fevereiro'
      when (substr(to_char(a.data),4,2) in ('03')) then '3-Março'
      when (substr(to_char(a.data),4,2) in ('04')) then '4-Abril'
      when (substr(to_char(a.data),4,2) in ('05')) then '5-Maio'
      when (substr(to_char(a.data),4,2) in ('06')) then '6-Junho'
      when (substr(to_char(a.data),4,2) in ('07')) then '7-Julho'
      when (substr(to_char(a.data),4,2) in ('08')) then '8-Agosto'
      when (substr(to_char(a.data),4,2) in ('09')) then '9-Setembro'
      when (substr(to_char(a.data),4,2) in ('10')) then '10-Outubro'
      when (substr(to_char(a.data),4,2) in ('11')) then '11-Novembro'
      when (substr(to_char(a.data),4,2) in ('12')) then '12-Dezembro'  
      else 'try'
 end as Mes,
 
  
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
 end as MesAbrev,
 
 to_char(to_date(a.data,'dd/mm/yyyy')) as Data,
 
  to_number(substr(to_char(a.data),1,2)) as Dia,
  
  
 Decode(to_char(a.data,'d'),1,'Domingo',
                                    2,'Segunda-Feira',
                                    3,'Terça-Feira',
                                    4,'Quarta-Feira',
                                    5,'Quinta-Feira',
                                    6,'Sexta-Feira',
                                    7,'Sábado') as DiaSemana, 
 

CASE WHEN DIAUTIL = 'N' THEN 'DIA NÃO ÚTIL' ELSE 'DIA ÚTIL' END AS DIAUTIL,

 to_number(to_char(a.data,'d')) DiaSemanaNumero,
 
 
  case
     when to_number(substr(to_char(a.data),4,2)) in (1,2,3) then 1
     when to_number(substr(to_char(a.data),4,2)) in (4,5,6) then 2
     when to_number(substr(to_char(a.data),4,2)) in (7,8,9) then 3
     when to_number(substr(to_char(a.data),4,2)) in (10,11,12) then 4
     else 0
 end as TrimestreNumero,


CASE WHEN (DIAUTIL = 'S'  OR DIAUTIL IS NULL )THEN 1 ELSE 0 END AS QUANTIDADEDIASUTIL,
CASE WHEN DIAUTIL = 'N' THEN 1 ELSE 0 END AS QUANTIDADEDIASNAOUTIL
 
from 
   pcdatas a

where
    TO_CHAR( a.data , 'YYYY') >= TO_CHAR(ADD_MONTHS(SYSDATE, -24), 'YYYY')