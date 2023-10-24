
#!/bin/bash
echo "Bem vindo ao Seu Buscador de Arquvio Linux"
read -p "Digite o nome do arquivo" filename
sudo find / -name "$filename"