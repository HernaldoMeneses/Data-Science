SELECT
    func.codfilial AS CodigoFilial,
    tipoerro.codigo AS CodigoErro,
    erro.numos AS NumeroOS,
    func.matricula AS CodigoFuncionarioErro,
    funca.matricula AS CodigoFuncionarioAcerto,
    erro.data AS DataErro,
    erro.qt AS Quantidade,
    tipoerro.pesoerro AS PesoErro,
    CAST((erro.qt * tipoerro.pesoerro) AS NUMERIC) AS TotalErro
FROM pcwmserro erro
    INNER JOIN pcwmstipoerro tipoerro ON erro.tipoerro = tipoerro.codigo
    LEFT JOIN pcempr func ON func.matricula = erro.materro
    LEFT JOIN pcempr funca ON funca.matricula = erro.matacerto
WHERE
    erro.data >= ADD_MONTHS(SYSDATE, -2)
ORDER BY erro.data