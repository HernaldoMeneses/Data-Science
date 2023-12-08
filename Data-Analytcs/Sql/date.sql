select 
sysdate
, trunc(sysdate)
, to_date(sysdate,'dd/mm/yyyy') 
, extract(day from sysdate)
, extract(month from sysdate)
, extract(year from sysdate)
from dual