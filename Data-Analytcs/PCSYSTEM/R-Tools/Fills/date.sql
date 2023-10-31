


AND PCPEDI.DATA >= to_date('01/10/2023','dd/mm/yyyy')  AND PCPEDI.DATA <= to_date('31/10/2023','dd/mm/yyyy') 
AND PCPEDC.DATA >= to_date('01/10/2023','dd/mm/yyyy')  AND PCPEDC.DATA <= to_date('31/10/2023','dd/mm/yyyy') 

AND PCPEDI.DATA >= to_date(:Data_init,'dd/mm/yyyy')  AND PCPEDI.DATA <= to_date(:Data_fim,'dd/mm/yyyy') 
AND PCPEDC.DATA >= to_date(:Data_init,'dd/mm/yyyy')  AND PCPEDC.DATA <= to_date(:Data_fim,'dd/mm/yyyy') 

AND TO_CHAR(PCPEDC.DATA , 'YYYY') >= TO_CHAR(ADD_MONTHS(SYSDATE, -24), 'YYYY')
AND TO_CHAR(PCPEDI.DATA , 'YYYY') >= TO_CHAR(ADD_MONTHS(SYSDATE, -24), 'YYYY')