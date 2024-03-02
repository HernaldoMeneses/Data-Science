SELECT owner, name, type
FROM dba_dependencies
WHERE referenced_name = 'NOME_DA_FUNCAO';