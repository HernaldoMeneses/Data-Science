#os arquivos xlsx precisam ter cabeçalho

import pandas as pd

txe = '.xlsx'
ext = '.csv'
pwd = "E:\\Github\\Data-Science\\Machine-Learning\\data\\"
h = 'header_'
list = ['103','105','324_8']

for i in range(len(list)):
    #df = pd.read_excel('103.xlsx')
    #df = pd.read_excel('103'+txe)
    df = pd.read_excel(h+list[i]+txe)
    print(df)
    #name = "103.csv"
    #name = "103"+ext
    name = list[i]+ext
    # O argumento 'index=False' evita que o índice seja salvo no arquivo
    #df.to_csv((path+name), index=False) 
    df.to_csv((pwd+name), index=False) 
