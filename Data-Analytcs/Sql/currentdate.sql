select 
current_date
, localtimestamp
, sysdate
, to_char(current_date, 'Day')
, to_char(current_date, 'Month')
, to_char(current_date, 'Yaer')
, datediff('day',date('2020-05-31'), date('2020-06-30')) as days
from dual