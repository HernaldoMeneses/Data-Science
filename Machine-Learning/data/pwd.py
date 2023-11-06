

# Abre o arquivo no modo de leitura
with open('pwd.txt', 'r') as file:
    # Lê o conteúdo do arquivo e armazena em uma variável
    string_lida = file.read()

# Agora, a variável 'string_lida' contém o conteúdo do arquivo
print(string_lida)