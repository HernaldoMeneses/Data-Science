@echo off
setlocal
echo "Bem vindo ao seu buscador de Arquvios para Windows"
set /p filename="Digiete o nome do arquivo e telce enter"
dir c:\%filename% /s
endlocal