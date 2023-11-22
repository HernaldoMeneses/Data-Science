select ntile 
, min(qt) as lower_qt
, max(qt) as upper_qt
, count(qt) as qts
, percent_rank
from (
    select distinct(p.codprod), p.qt, p.punit
    , ntile(4) over (order by p.qt) as ntile 
    , percent_rank() over (partition by p.qt order by p.qt) as percent_rank
    from pcmov p 
    where p.dtmov > to_date('20/11/2023','dd/mm/yyyy')
    order by ntile
)
group by ntile
, percent_rank
order by ntile