import pandas as pd
# Carregue a planilha em formato XLSX

xlsx_df = pd.read_excel('103.xlsx')

df = xlsx_df
print(df)
path = "E:\\Data-Since\\R\\11-2023\\"
name = "103.csv"
 # O argumento 'index=False' evita que o índice seja salvo no arquivo
df.to_csv((path+name), index=False) 