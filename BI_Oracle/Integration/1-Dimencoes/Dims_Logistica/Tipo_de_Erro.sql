SELECT
    tipoerro.codigo AS CodigoErro,
    tipoerro.descricao AS Descricao,
    tipoerro.pesoerro AS PesoErro,
    tipoerro.pesoacerto AS PesoAcerto,
    tipoerro.tipoos AS TipoOS
FROM pcwmstipoerro tipoerro
ORDER BY tipoerro.codigo