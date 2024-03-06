SELECT 
       PCPEDC.NUMPED AS NUMEROPEDIDO,      
       (CASE WHEN PCPEDC.POSICAO = 'L' THEN 'LIBERADO'
                  WHEN PCPEDC.POSICAO = 'P' THEN 'PENDENTE'
                  WHEN PCPEDC.POSICAO = 'B' THEN 'BLOQUEADO'
                  WHEN PCPEDC.POSICAO = 'M' THEN 'MONTADO'
                  WHEN PCPEDC.POSICAO = 'F' THEN 'FATURADO'
               ELSE 'POSICAO DESCONHECIDA' END ) AS SITUACAO,

       PCPEDC.HORA, 
       PCPEDC.MINUTO, 

       CASE
WHEN NVL (PCPEDC.BRINDE, 'N') = 'S' THEN 'PEDIDO BRINDE'
WHEN PCPEDC.CONDVENDA IN (1, 9) THEN 'VENDA NORMAL' 
WHEN PCPEDC.CONDVENDA IN (4) THEN 'SIMPLES FATURA'
WHEN PCPEDC.CONDVENDA IN (5,6) THEN 'BONIFICAÇÃO'
WHEN PCPEDC.CONDVENDA IN (7) THEN 'VENDA ENTREGA FUTURA'
WHEN PCPEDC.CONDVENDA IN (8) THEN 'SIMPLES ENTREGA'
WHEN PCPEDC.CONDVENDA IN (9) THEN 'VENDA NORMAL' 
WHEN PCPEDC.CONDVENDA IN (10) THEN 'TRANSFERÊNCIA'
WHEN PCPEDC.CONDVENDA IN (11) THEN 'VENDA COM TROCA'
WHEN PCPEDC.CONDVENDA IN (13) THEN 'MANIFESTO'  
WHEN PCPEDC.CONDVENDA IN (13) THEN 'VENDA COM MANIFESTO'
WHEN PCPEDC.CONDVENDA IN (20) THEN 'VENDA CONSIGNAÇÃO'
ELSE 'NÃO IDENTIFICADO'  END AS CONDICAOVENDADESCRICAO,
       
       CASE WHEN PCPEDC.DTCANCEL IS NULL THEN 'NÃO CANCELADO'
            ELSE 'CANCELADO' END AS CANCELADO,

PCPEDC.NUMITENS AS QUANTIDADEITENS,
       CASE
          WHEN NVL (PCPEDC.BRINDE, 'N') = 'S'
             THEN 'PEDIDO BRINDE'
          WHEN PCPEDC.CONDVENDA IN (5, 6, 11, 12)
             THEN 'PEDIDO BONIFICAÇÃO'
          WHEN PCPEDC.CONDVENDA = 10
             THEN 'PEDIDO TRANSFERÊNCIA'
          ELSE 'PEDIDO DE VENDA'
       END AS TIPOPEDIDO,
       
       PCPEDC.CONDVENDA AS CODIGOTIPOPEDIDO,
       PCPEDC.CODCONDICAOVENDA AS CONDICAOVENDA,
(DECODE(PCPEDC.ORIGEMPED,'T','TELEMARKETING','F','FORÇA DE VENDAS','R',
'BALCÃO RESERVA','A','FRENTE DE CAIXA','B','BALCÃO', 'C', 'CALL CENTER',
 'W', 'WEBSERVICE','','OUTROS')) AS ORIGEM_PEDIDO

       
  FROM PCPEDC
  WHERE TO_CHAR(PCPEDC.DATA, 'YYYY') >= TO_CHAR(ADD_MONTHS(SYSDATE, -96), 'YYYY')