#os arquivos xlsx precisam ter cabeçalho

import pandas as pd

txe = '.xlsx'
ext = '.csv'
#pwd = "E:\\Github\\Data-Science\\Machine-Learning\\data\\"
pwd = "D:\\Github\\Data-Science\\Machine-Learning\\data\\"
h = 'header_'
list = ['103','105','324_8']

df = pd.read_excel(h+list[0]+txe)
#print(df)

#dft = df.loc[:, ['coluna1', 'coluna2', 'coluna3']]
#dft = df.iloc[:, [0, 2, 8]]
df = df.iloc[:, [0, 2, 8]]
print(df)
df = df[df.iloc[:, 0] != 0]
print(df)

df1 = df

df = pd.read_excel(h+list[1]+txe)
df = df[df.iloc[:, 3] != 'FL']
print(df)
df = df.iloc[:, [0, 9, 12]]
print(df)
df = df[df.iloc[:, 0] != 0]
print(df)

df2 = df
#df_final = df1.merge(df2, on='codigo_produto', how='inner')
df_final = df1.merge(df2, left_on=df1.columns[1], right_on=df2.columns[0], how='inner')
print(df_final)

df_final['VendaDiaCusto'] = df_final.iloc[:, 2] * df_final.iloc[:, 4]
print(df_final)

df_final = df_final.drop(df_final.columns[3], axis=1)
print(df_final)

result = df_final.groupby('CodFornecedor').agg(
    qtAtivos=('CodProduto', 'nunique'),  # Conta valores distintos em codprodut
    ValorStoAtual=('Real', 'sum'),  # Substitua 'coluna1' pelo nome das suas colunas
    VendaDiaCusto=('VendaDiaCusto', 'sum'),
    # Adicione mais colunas a serem somadas, se necessário
).reset_index()

# O resultado estará em 'result'
print(result)


# Função personalizada para realizar a divisão tratando divisões por 0
def divisao_com_tratamento(x, y):
    if y == 0:
        return 0
    else:
        return x / y

# Aplicar a função de divisão tratada para criar a coluna 'Dias_Estoques'
result['Dias_Estoques'] = result.apply(lambda row: divisao_com_tratamento(row[2], row[3]), axis=1)

# O DataFrame resultante, 'df', agora contém a coluna 'resultado' com divisões tratadas por 0
print(result)
name = "Result"+ext
result.to_csv((pwd+name), index=False) 
