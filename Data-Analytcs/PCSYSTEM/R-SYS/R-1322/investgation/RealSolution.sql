select 
Max(to_date(DTMOV,'dd/mm/yyyy')) As MaiorDATA 
to_date(DTMOV,'dd/mm/yyyy') As Data
, NUMNOTA
, CODPROD
, CODFISCAL
, QT
, PUNITCONT
, QT * PUNITCONT AS TOTAL
from pcmov 
where 1=1
--AND RoTinalanc = 'PCSIS1322.EXE'
AND CODFISCAL =  5927

AND DTMOV >= To_date('01/01/2023','dd/mm/yyyy')
--AND DTMOV <= To_date('31/12/2023','dd/mm/yyyy')
order by DTMOV