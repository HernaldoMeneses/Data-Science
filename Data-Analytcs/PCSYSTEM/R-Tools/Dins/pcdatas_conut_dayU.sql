
select until_today.*, Until_end.*, (Until_end.qt_end + until_today.qt_today) as qt_total
from (
select 
 sum(CASE WHEN (DIAUTIL = 'S'  OR DIAUTIL IS NULL )THEN 1 ELSE 0 END) AS qt_today
 
from 
   pcdatas a
 where a.data >= to_date('01/12/2023','dd/mm/yyyy')
 and a.data <= to_date(sysdate,'dd/mm/yyyy')
      ) until_today ,
      (
     select 
     sum(CASE WHEN (DIAUTIL = 'S'  OR DIAUTIL IS NULL )THEN 1 ELSE 0 END) AS qt_end
     
     from 
     pcdatas a
     where a.data >= to_date(sysdate,'dd/mm/yyyy')
     and a.data <= to_date('31/12/2023','dd/mm/yyyy')

      ) Until_end
   
   

   
