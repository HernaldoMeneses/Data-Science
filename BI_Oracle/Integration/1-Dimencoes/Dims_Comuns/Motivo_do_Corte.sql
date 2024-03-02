select 

    pctabdev.coddevol as Codigo,
    pctabdev.motivo as Motivo,
    concat( pctabdev.coddevol,concat('-', pctabdev.motivo)) as Descricao

from 
    pctabdev

order by 1