import cx_Oracle
import pandas as pd
# Defina a string de conexão com seu banco de dados Oracle
#connection = cx_Oracle.connect("seu_usuario/sua_senha@nome_do_banco_de_dados")
connection = cx_Oracle.connect("FRIOBOM/friobom147123@WINT")

# Crie um cursor para executar consultas SQL
cursor = connection.cursor()

Select = "SELECT Cliente"
From = " FROM PCCLIENT"
Where = " WHERE Rownum < 5"


#Sql = "SELECT Cliente FROM PCCLIENT WHERE Rownum < 5"
Sql = Select + From + Where


df = pd.read_sql_query(Sql, connection)

# Feche o cursor e a conexão quando terminar
cursor.close()
connection.close()


# Agora, 'df' é um DataFrame contendo os resultados da consulta
print(df)