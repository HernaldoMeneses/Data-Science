SELECT 
CAR.NUMCAR AS NUMEROCARREGAMENTO,
CAR.DESTINO,
CAR.CODMOTORISTA AS CODIGOMOTORISTA,
EMP.NOME AS MOTORISTA,
VEI.CODVEICULO AS CODIGOVEICULO,
VEI.DESCRICAO AS VEICULO,
VEI.MARCA, 
VEI.TIPOVEICULO, 
VEI.PROPRIO, 
VEI.SITUACAO
FROM PCCARREG CAR
LEFT JOIN PCVEICUL VEI ON VEI.CODVEICULO = CAR.CODVEICULO
LEFT JOIN PCEMPR EMP ON EMP.MATRICULA = CAR.CODMOTORISTA
WHERE CAR.DTFAT >= ADD_MONTHS(SYSDATE, -24)