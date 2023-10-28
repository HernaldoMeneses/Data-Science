#Local config path powerBi to Python
# c:\Users\FRIOBOM54\AppData\Local\Microsoft\WindowsApps\

'''
    Script simples para plotar
'''


# O código a seguir para criar um dataframe e remover as linhas duplicadas sempre é executado e age como um preâmbulo para o script: 

# dataset = pandas.DataFrame(undefined)
# dataset = dataset.drop_duplicates()

# Cole ou digite aqui seu código de script:
import pandas as pd
import matplotlib.pyplot as plt

# Criar um DataFrame de exemplo
data = pd.DataFrame({'Categoria': ['A', 'B', 'C', 'D'],
                     'Valores': [10, 25, 15, 30]})

# Criar um gráfico de barras
plt.bar(data['Categoria'], data['Valores'])

# Definir rótulos e título
plt.xlabel('Categoria')
plt.ylabel('Valores')
plt.title('Gráfico de Barras de Exemplo')

# Exibir o gráfico
plt.show()



# Especifique o caminho para o arquivo Excel
#caminho_arquivo = "caminho/para/sua/planilha.xlsx"
caminho_arquivo = "C:/Users/FRIOBOM54/Desktop/Matrix/Github/Data-Science/Data-Analytcs/Python/Rel_Compras/_103.xlsx"

# Use o método 'read_excel' para abrir a planilha
df = pd.read_excel(caminho_arquivo)
print(df)

# Agora 'df' é um DataFrame do Pandas que contém os dados da planilha
# Você pode realizar operações e análises nos dados com o Pandas
