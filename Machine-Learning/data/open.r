
#path <- "E:\\Data-Since\\R\\11-2023"
pwd = "E:\\Github\\Data-Science\\Machine-Learning\\data\\"



csv_file <- "103.csv"
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




