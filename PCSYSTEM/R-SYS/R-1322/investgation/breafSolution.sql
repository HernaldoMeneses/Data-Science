select * from pcmov 
where 1=1 
AND rownum < 5
AND RoTinalanc = 'PCSIS1322.EXE'
AND CODFISCAL =  5927
And DTMOV >= to_date('01/06/2015','dd/mm/yyyy')

/***
select * from pcmov 
where 1=1 
AND rownum < 5
AND RoTinalanc = 'PCSIS1322.EXE'
AND CODFISCAL =  5927
And DTMOV >= to_date('01/01/2023','dd/mm/yyyy')
**/

select * from pcmov 
where 1=1 
--AND rownum < 5
--AND RoTinalanc = 'PCSIS1322.EXE'
AND CODFISCAL =  5927
And DTMOV >= to_date('01/01/2023','dd/mm/yyyy')