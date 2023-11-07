
#path <- "E:\\Data-Since\\R\\11-2023"
#pwd = "D:\\Github\\Data-Science\\Machine-Learning\\data\\"
#pwd = "E:\\Github\\Data-Science\\Machine-Learning\\data\\"
pwd = readLines("pwd.txt")



csv_file <- "Result.csv"
#setando o local de trabalho
setwd(pwd)

# Leia a planilha do arquivo XLSX
csv_df <- read.csv(csv_file, sep = ",")

# Leia o arquivo .xlsx e armazene-o em um data frame
#xlsx_df <- read_xlsx(xlsx_file)

#df <- xlsx_df
df <- csv_df

#?View
#View(df,"deucerto")
#View(df)
#str(df)
summary(df)
#str(df$id)
#str(df$CodFornecedor)
#class(df$id)
#class(df$CodFornecedor)
#class(df$Fornecedor)
#class(df$CodProduto)
#df$CodFornecedor

#fat_df <- df[1:3]
#str(fat_df)

#?c
#df[0]
options(repos = c(CRAN = "https://cloud.r-project.org"))


#install.packages("ggplot2")

# Carregue a biblioteca ggplot2
library(ggplot2)

colunas <- names(df)
print(colunas)


# Carregue a biblioteca ggplot2
library(ggplot2)
seu_dataframe <- df
# Substitua "seu_dataframe" pelo nome do seu DataFrame
ggplot(data = seu_dataframe, aes(x = qtAtivos, y = ValorStoAtual)) +
  geom_point() +
  labs(x = "Título do Eixo X", y = "Título do Eixo Y") +
  ggtitle("Título do Gráfico")



# Carregue a biblioteca ggplot2
library(ggplot2)
seu_dataframe <- df
# Suponha que você deseja usar a primeira e segunda coluna do DataFrame
# Substitua "seu_dataframe" pelo nome do seu DataFrame
ggplot(data = seu_dataframe, aes(x = seu_dataframe[, 1], y = seu_dataframe[, 2])) +
  geom_point() +
  labs(x = "Título do Eixo X", y = "Título do Eixo Y") +
  ggtitle("Título do Gráfico")






