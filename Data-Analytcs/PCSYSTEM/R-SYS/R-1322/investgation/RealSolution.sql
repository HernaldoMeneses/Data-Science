select 
to_date(pcmov.DTMOV,'dd/mm/yyyy') As Data
, substr(to_char(pcmov.DTMOV),1,2) as dia
, substr(to_char(pcmov.DTMOV),4,2) as mes
, substr(to_char(pcmov.DTMOV),7,4) as ano

, pcmov.CODCLI
, pcmov.NUMNOTA
, pcmov.CODFORNEC
, pcfornec.fornecedor
, pcmov.CODPROD
, pcprodut.descricao
, pcmov.CODFISCAL
, pcmov.QTCONT
, pcmov.PUNITCONT
, pcmov.QTCONT * pcmov.PUNITCONT AS TOTAL

, pcmov.RoTinalanc
, pcmov.CODFUNCLANC
, pcmov.FUNCLANC
from pcmov, pcfornec, PCPRODUT
where 1=1
AND pcmov.codfornec = pcfornec.codfornec
AND pcfornec.codfornec = pcprodut.codfornec

--AND RoTinalanc = 'PCSIS1322.EXE'
--AND CODFISCAL =  5927
AND pcmov.CODFISCAL =  :CODFISCAL

--AND DTMOV >= To_date('01/01/2023','dd/mm/yyyy')
AND pcmov.DTMOV >= To_date(:Data_init,'dd/mm/yyyy')
AND pcmov.DTMOV <= To_date(:Data_final,'dd/mm/yyyy')
--AND DTMOV <= To_date('31/12/2023','dd/mm/yyyy')
order by pcmov.DTMOV