import cx_Oracle
import pandas as pd
# Defina a string de conexão com seu banco de dados Oracle
#connection = cx_Oracle.connect("seu_usuario/sua_senha@nome_do_banco_de_dados")
connection = cx_Oracle.connect("FRIOBOM/friobom147123@WINT")

# Crie um cursor para executar consultas SQL
cursor = connection.cursor()

# Exemplo de consulta SQL
# cursor.execute("SELECT * FROM PCCLIENT WHERE Rownum < 5")
#Sql = "SELECT Cliente FROM PCCLIENT WHERE Rownum < 5"
Sql = ''
with open ('sql.txt', 'r') as file:
    for line in file:
        Sql += line

#cursor.execute(Sql)
# Recupere os resultados
#for row in cursor:
#    print(row)
#print(Sql)
df = pd.read_sql_query(Sql, connection)
# to CSV
df.to_csv(('slq.csv'), index=False) 
df.to_excel(('slq.xlsx'), index=False) 
# Feche o cursor e a conexão quando terminar
cursor.close()
connection.close()


# Agora, 'df' é um DataFrame contendo os resultados da consulta
#print(df)