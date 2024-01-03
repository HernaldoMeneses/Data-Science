
select 
 sum(CASE WHEN (DIAUTIL = 'S'  OR DIAUTIL IS NULL )THEN 1 ELSE 0 END) AS qt_works_days
 
from 
   pcdatas a
 where a.data >= to_date('01/01/2024','dd/mm/yyyy')
 and a.data <= to_date('31/12/2024','dd/mm/yyyy')

   
   

   
