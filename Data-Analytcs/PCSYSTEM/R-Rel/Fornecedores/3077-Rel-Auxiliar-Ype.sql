SELECT 
PCPEDC.DATA, 
    to_number(substr(to_char(PCPEDC.DATA),8,4)) as Ano,
    
  case
      when (substr(to_char(PCPEDC.DATA),4,2) in ('01')) then 'JANEIRO'
      when (substr(to_char(PCPEDC.DATA),4,2) in ('02')) then 'FEVEREIRO'
      when (substr(to_char(PCPEDC.DATA),4,2) in ('03')) then 'MARÇO'
      when (substr(to_char(PCPEDC.DATA),4,2) in ('04')) then 'ABRIL'
      when (substr(to_char(PCPEDC.DATA),4,2) in ('05')) then 'MAIO'
      when (substr(to_char(PCPEDC.DATA),4,2) in ('06')) then 'JUNHO'
      when (substr(to_char(PCPEDC.DATA),4,2) in ('07')) then 'JULHO'
      when (substr(to_char(PCPEDC.DATA),4,2) in ('08')) then 'AGOSTO'
      when (substr(to_char(PCPEDC.DATA),4,2) in ('09')) then 'SETEMBRO'
      when (substr(to_char(PCPEDC.DATA),4,2) in ('10')) then 'OUTUBRO'
      when (substr(to_char(PCPEDC.DATA),4,2) in ('11')) then 'NOVEMBRO'
      when (substr(to_char(PCPEDC.DATA),4,2) in ('12')) then 'DEZEMBRO'  
      else 'try'
 end as Mes,
 
         
     to_number(substr(to_char(PCPEDC.DATA),1,2)) as Dia,
     
     CASE WHEN PCCIDADE.CODIBGE IS NULL THEN 999 
        ELSE PCCIDADE.CODIBGE END ClienteCodigoIBGE,
     
     
     
     
 concat(concat(PCPEDC.CODSUPERVISOR , ' - '), pcsuperv.nome) as RCADescriçãoSupervisor,
concat(concat(PCPEDC.CODUSUR , ' - '), pcusuari.nome) as RCADescriçãoRCA,
concat(concat(PCPEDC.CODCLI, ' - '), pcclient.cliente) as ClienteDescriçãoCliente,
concat(concat(PCPRODUT.CODPROD, ' - '), pcprodut.descricao) as ProdutoDescriçãoProduto,
  
PCPRODUT.embalagem as ProdutoEmbalagem,
 

       SUM(CASE                                                                                                                            
             WHEN NVL(PCPEDI.BONIFIC, 'N') = 'N' THEN                                                                                  
              DECODE(PCPEDC.CONDVENDA,                                                                                                     
                     5,                                                                                                                    
                    0,
                     6,                                                                                                                    
                     0,                                                                                                                    
                     11,                                                                                                                   
                     0,                                                                                                                    
                     12,                                                                                                                   
                     0,                                                                                                                    
                     NVL(PCPEDI.VLSUBTOTITEM,                                                                                              
                         (DECODE(NVL(PCPEDI.TRUNCARITEM, 'N'),                                                                           
                                 'N',                                                                                                    
                                 ROUND((NVL(PCPEDI.QT, 0)) * (NVL(PCPEDI.PVENDA, 0) + nvl(pcpedi.vloutrasdesp,0) + 
nvl(pcpedi.vlfrete,0)), 
                                       2),                                                                                                 
                                 TRUNC((NVL(PCPEDI.QT, 0)) * (NVL(PCPEDI.PVENDA, 0) + nvl(pcpedi.vloutrasdesp,0) + 
nvl(pcpedi.vlfrete,0)), 
                                       2)))))                                                                                              
             ELSE                                                                                                                          
    0 
           END) - SUM(CASE                                                                                                                 
                        WHEN NVL(PCPEDI.BONIFIC, 'N') = 'N' THEN                                                                       
                         DECODE(PCPEDC.CONDVENDA,                                                                                          
                                5,                                                                                                         
                                0,                                                                                                         
                                6,                                                                                                         
                                0,                                                                                                         
                                11,                                                                                                        
                                0,                                                                                                         
                                12,                                                                                                        
                                0,                                                                                                         
                                NVL(PCPEDI.qt, 0) * (0 + 0))                                                                               
                        ELSE                                                                                                               
                    0
                      END) ValorVenda, 
                      
                      pctabpr.ptabela as ValorTabela,
                                                                                                                             
---CAST(ROUND(PCPRODUT.QTUNITCX, 2)AS NUMERIC(18,6)) AS QuantidadeUnitariaCaixa,
round(SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') <> 'N' THEN 0 ELSE NVL(PCPEDI.QT, 0) END,5,0,6,0,11,0,12,0,
NVL(PCPEDI.QT,0)))  / CAST(ROUND(PCPRODUT.QTUNITCX, 2)AS NUMERIC(18,6)),2) AS QtdCxs, 
   SUM(DECODE(PCPEDC.CONDVENDA,1,CASE WHEN NVL(PCPEDI.BONIFIC, 'N') <> 'N' THEN 0 ELSE NVL(PCPEDI.QT, 0) END,5,0,6,0,11,0,12,0,
NVL(PCPEDI.QT,0))) as QtdUni

                                                                                                                  
FROM PCPEDI
, PCPEDC
, PCCLIENT
, PCPRODUT
, PCPRACA
, PCUSUARI
, PCFORNEC
, PCSUPERV

, PCDEPTO
, PCCIDADE
, pctabpr





WHERE 1=1
--H.Meneses
AND PCPEDC.DATA >= to_date('01/07/2023','dd/mm/yyyy') AND PCPEDC.DATA <= to_date('31/12/2024','dd/mm/yyyy')
AND PCPEDI.DATA >= to_date('01/07/2023','dd/mm/yyyy') AND PCPEDI.DATA <= to_date('31/12/2024','dd/mm/yyyy')

AND PCPEDI.NUMPED = PCPEDC.NUMPED
AND  PCPEDC.CODSUPERVISOR  = PCSUPERV.CODSUPERVISOR
AND PCPEDI.CODPROD = PCPRODUT.CODPROD
AND PCPRODUT.CODEPTO = PCDEPTO.CODEPTO
AND  PCPEDC.CODUSUR  = PCUSUARI.CODUSUR
AND PCPEDC.CODCLI = PCCLIENT.CODCLI
AND PCPEDC.CODPRACA = PCPRACA.CODPRACA
AND PCPEDC.DTCANCEL IS NULL
AND PCPRODUT.CODFORNEC = PCFORNEC.CODFORNEC
AND PCPEDC.CODFILIAL IN ('2')
AND PCPEDC.CONDVENDA NOT IN (4,8,10,13,20,98,99)
AND PCPEDC.CONDVENDA NOT IN (5,11)

AND PCCIDADE.CODCIDADE = PCCLIENT.codcidade
AND pctabpr.codprod = pcprodut.codprod

AND PCFORNEC.CODFORNEC in 3077



GROUP BY  
PCPEDC.DATA,
PCPEDC.CODSUPERVISOR , PCSUPERV.NOME, 
PCPEDC.CODUSUR, pcusuari.nome, 
PCPEDC.CODCLI,  pcclient.cliente,   
PCPRODUT.CODPROD, pcprodut.descricao, PCPRODUT.embalagem,PCPRODUT.QTUNITCX,
PCCIDADE.CODIBGE,
pctabpr.ptabela