USE [powerbi]
GO
/****** Object:  Table [dbo].[ADO NET Destination]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ADO NET Destination](
	[CODSUPERVISOR] [numeric](4, 0) NULL,
	[CODGERENTE] [numeric](4, 0) NULL,
	[POSICAO] [nvarchar](2) NULL,
	[DATA] [datetime] NULL,
	[CODUSUR] [numeric](4, 0) NULL,
	[CODFILIAL] [nvarchar](2) NULL,
	[CODEPTO] [numeric](6, 0) NULL,
	[CODFORNEC] [numeric](6, 0) NULL,
	[CODPROD] [numeric](6, 0) NULL,
	[CODCLI] [numeric](6, 0) NULL,
	[VLVENDA] [nvarchar](40) NULL,
	[VLCUSTOFIN] [nvarchar](40) NULL,
	[QT] [nvarchar](40) NULL,
	[QTBNF] [nvarchar](40) NULL,
	[QTCLIENTE] [nvarchar](40) NULL,
	[PESO] [nvarchar](40) NULL,
	[QTPED] [nvarchar](40) NULL,
	[VLBONIFIC] [nvarchar](40) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Aux_CidadeIBGE]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Aux_CidadeIBGE](
	[CodigoIBGE] [varchar](50) NULL,
	[Cidade] [varchar](120) NULL,
	[UF] [varchar](2) NULL,
	[Estado] [varchar](120) NULL,
	[Populacao] [numeric](18, 0) NULL,
	[Area] [numeric](18, 6) NULL,
	[Regiao] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Camp_Todeschini]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Camp_Todeschini](
	[CODUSUR] [int] NULL,
	[POSIT] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_ApuracaoCampanha]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_ApuracaoCampanha](
	[CodigoFilial] [varchar](4) NULL,
	[CodigoRCA] [int] NULL,
	[TipoMeta] [varchar](4) NULL,
	[CodigoEntidade] [varchar](20) NULL,
	[Referencia] [varchar](10) NULL,
	[Metrica] [varchar](60) NULL,
	[TipoPremio] [varchar](40) NULL,
	[ValeGerado] [varchar](10) NULL,
	[DescricaoTipoMeta] [varchar](40) NULL,
	[EntidadeMeta] [varchar](120) NULL,
	[Data] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Banco]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Banco](
	[CodigoBanco] [int] NULL,
	[NumeroBanco] [int] NULL,
	[Banco] [varchar](40) NULL,
	[Agencia] [varchar](10) NULL,
	[Conta] [varchar](10) NULL,
	[CodigoFilial] [varchar](4) NULL,
	[Filial] [varchar](40) NULL,
	[FluxoCaixa] [varchar](20) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Bonus]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Bonus](
	[NumeroBonus] [int] NULL,
	[Processamento] [varchar](20) NULL,
	[Fechamento] [varchar](20) NULL,
	[Falta] [varchar](20) NULL,
	[Avaria] [varchar](20) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Carregamento]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Carregamento](
	[NumeroCarregamento] [varchar](20) NULL,
	[Destino] [varchar](40) NULL,
	[CodigoMotorista] [varchar](8) NULL,
	[Motorista] [varchar](120) NULL,
	[CodigoVeiculo] [int] NULL,
	[Veiculo] [varchar](40) NULL,
	[Marca] [varchar](20) NULL,
	[TipoVeiculo] [varchar](20) NULL,
	[Proprio] [varchar](20) NULL,
	[Situacao] [varchar](20) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_CarteiraCliente]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_CarteiraCliente](
	[CodigoRCA] [int] NULL,
	[Rca] [varchar](100) NULL,
	[CodigoCliente] [int] NULL,
	[Cliente] [varchar](100) NULL,
	[TipoVinculo] [varchar](50) NULL,
	[Status] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_CentroCusto]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_CentroCusto](
	[CodigoCentroCusto] [varchar](40) NULL,
	[CentroCusto] [varchar](40) NULL,
	[Ativo] [varchar](1) NULL,
	[RecebeLancamento] [varchar](1) NULL,
	[NumeroLancamento] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Cliente]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Cliente](
	[CodigoCliente] [int] NOT NULL,
	[Cliente] [varchar](120) NULL,
	[CPFCNPJ] [varchar](80) NULL,
	[TipoCliente] [varchar](40) NULL,
	[CodigoIBGE] [varchar](50) NULL,
	[Bairro] [varchar](80) NULL,
	[CEP] [varchar](50) NULL,
	[Endereco] [varchar](40) NULL,
	[NomeFantasia] [varchar](120) NULL,
	[Classe] [varchar](80) NULL,
	[Classificacao] [varchar](2) NULL,
	[EmailCliente] [varchar](200) NULL,
	[CodigoRamoAtividade] [varchar](20) NULL,
	[RamoAtividade] [varchar](80) NULL,
	[Grupo] [varchar](80) NULL,
	[Praca] [varchar](60) NULL,
	[CodigoRota] [varchar](4) NULL,
	[Rota] [varchar](60) NULL,
	[CodigoRede] [varchar](8) NULL,
	[Rede] [varchar](80) NULL,
	[Regiao] [varchar](60) NULL,
	[UFRegiao] [varchar](2) NULL,
	[NomeFantasiaClientePrincipal] [varchar](120) NULL,
	[ClientePrincipal] [varchar](120) NULL,
	[Status] [varchar](80) NULL,
	[DiasInativos] [varchar](80) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_ClientesAtivos_RCA]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_ClientesAtivos_RCA](
	[CODUSUR] [int] NULL,
	[QTCLIATIVOS] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Cobranca]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Cobranca](
	[CodigoCobranca] [varchar](4) NULL,
	[Cobranca] [varchar](30) NULL,
	[TaxaJuros] [numeric](18, 6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_CobrancaCliente]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_CobrancaCliente](
	[NumeroCobranca] [varchar](10) NULL,
	[TipoContato] [varchar](4) NULL,
	[NomeContato] [varchar](40) NULL,
	[Observacao1] [varchar](200) NULL,
	[Observacao2] [varchar](200) NULL,
	[Observacao3] [varchar](200) NULL,
	[Observacao4] [varchar](200) NULL,
	[Hora] [varchar](2) NULL,
	[Minuto] [varchar](2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Colaborador]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Colaborador](
	[Matricula] [int] NULL,
	[Colaborador] [varchar](60) NULL,
	[Funcao] [varchar](50) NULL,
	[DataAdmissao] [date] NULL,
	[DataNascimento] [date] NULL,
	[EstadoCivil] [char](1) NULL,
	[Sexo] [char](1) NULL,
	[Departamento] [varchar](50) NULL,
	[DataDemissao] [date] NULL,
	[Situacao] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Conta]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Conta](
	[CodigoConta] [int] NULL,
	[Conta] [varchar](120) NULL,
	[CodigoGrupo] [int] NULL,
	[Grupo] [varchar](120) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_ContaPagar]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_ContaPagar](
	[NumeroLancamento] [int] NOT NULL,
	[Historico] [varchar](200) NULL,
	[Historico2] [varchar](200) NULL,
	[Prestacao] [varchar](50) NULL,
	[Localizacao] [varchar](50) NULL,
	[Indice] [varchar](50) NULL,
	[NumeroCheque] [varchar](50) NULL,
	[NumeroBordero] [int] NULL,
	[TipoPagamento] [varchar](50) NULL,
	[Situacao] [varchar](50) NULL,
	[CodigoRotinaBaixa] [int] NULL,
	[TipoLancamento] [varchar](2) NULL,
	[DiasProrrogacao] [int] NULL,
	[TipoParceiro] [varchar](20) NULL,
	[Parceiro] [varchar](80) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_ContaReceber]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_ContaReceber](
	[NumeroTransacaoVenda] [numeric](18, 0) NULL,
	[Prestacao] [varchar](8) NULL,
	[NumeroNota] [numeric](10, 0) NULL,
	[Situacao] [varchar](20) NULL,
	[Inadimplencia] [varchar](20) NULL,
	[Atraso] [varchar](20) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Departamentos]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Departamentos](
	[CODEPTO] [numeric](6, 0) NULL,
	[DESCRICAO] [nvarchar](25) NULL,
	[TIPOMERC] [nvarchar](2) NULL,
	[EMITEQTUNIT] [nvarchar](1) NULL,
	[ATUALIZAINVGERAL] [nvarchar](1) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Endereco]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Endereco](
	[CodigoEndereco] [numeric](10, 0) NULL,
	[CodigoFilial] [varchar](4) NULL,
	[Deposito] [int] NULL,
	[Rua] [int] NULL,
	[Predio] [int] NULL,
	[Nivel] [int] NULL,
	[Apartamento] [int] NULL,
	[Estacao] [int] NULL,
	[TipoEndereco] [varchar](20) NULL,
	[Situacao] [varchar](20) NULL,
	[Bloqueio] [varchar](20) NULL,
	[Status] [varchar](20) NULL,
	[TamanhoEndereco] [varchar](40) NULL,
	[TipoEstrutura] [varchar](40) NULL,
	[DepositoVirtual] [varchar](4) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_EstoqueAtual]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_EstoqueAtual](
	[CodigoProduto] [int] NULL,
	[CodigoFornecedor] [int] NULL,
	[CodigoFilial] [varchar](4) NULL,
	[NivelGiroDia] [varchar](30) NULL,
	[EscalaGiroDia] [varchar](30) NULL,
	[EscalaDiasEstoque] [varchar](30) NULL,
	[ForaLinha] [varchar](30) NULL,
	[Situacao] [varchar](20) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Filial]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Filial](
	[CodigoFilial] [varchar](4) NOT NULL,
	[Filial] [varchar](120) NULL,
	[UF] [varchar](2) NULL,
	[Cidade] [varchar](120) NULL,
	[Email] [varchar](120) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Fornecedor]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Fornecedor](
	[CODIGOFORNECEDOR] [int] NULL,
	[FORNECEDOR] [nvarchar](60) NULL,
	[FANTASIA] [nvarchar](60) NULL,
	[CODCOMPRADOR] [numeric](8, 0) NULL,
	[EMAILFORNECEDOR] [nvarchar](100) NULL,
	[ESTADO] [nvarchar](2) NULL,
	[CIDADE] [nvarchar](15) NULL,
	[CEP] [nvarchar](9) NULL,
	[INSCRICAOESTADUAL] [nvarchar](15) NULL,
	[CNPJCPF] [nvarchar](18) NULL,
	[BAIRRO] [nvarchar](20) NULL,
	[PRAZOENTREGA] [numeric](4, 0) NULL,
	[BLOQUEIO] [nvarchar](1) NULL,
	[REVENDA] [nvarchar](1) NULL,
	[ESTRATEGICO] [nvarchar](1) NULL,
	[CLASSEVENDA] [nvarchar](1) NULL,
	[CLASSECOMPRA] [nvarchar](1) NULL,
	[CLASSEESTOQUE] [nvarchar](1) NULL,
	[TIPO] [nvarchar](1) NULL,
	[SIMPLESNACIONAL] [nvarchar](1) NULL,
	[CODIGOFORNECEDORPRINCIAPAL] [numeric](6, 0) NULL,
	[FORNECEDORPRINCIPAL] [nvarchar](60) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Fornecedor_C]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Fornecedor_C](
	[PASTA] [int] NULL,
	[CODIGOFORNECEDOR] [int] NULL,
	[FORNECEDOR] [nvarchar](60) NULL,
	[FANTASIA] [nvarchar](60) NULL,
	[CODIGOFORNECEDORPRINCIAPAL] [numeric](6, 0) NULL,
	[FORNECEDORPRINCIPAL] [nvarchar](60) NULL,
	[CODCOMPRADOR] [int] NULL,
	[EMAILFORNECEDOR] [nvarchar](100) NULL,
	[ESTADO] [nvarchar](2) NULL,
	[CIDADE] [nvarchar](15) NULL,
	[CEP] [nvarchar](9) NULL,
	[INSCRICAOESTADUAL] [nvarchar](15) NULL,
	[CNPJCPF] [nvarchar](18) NULL,
	[BAIRRO] [nvarchar](20) NULL,
	[PRAZOENTREGA] [numeric](4, 0) NULL,
	[BLOQUEIO] [nvarchar](1) NULL,
	[REVENDA] [nvarchar](1) NULL,
	[ESTRATEGICO] [nvarchar](1) NULL,
	[CLASSEVENDA] [nvarchar](1) NULL,
	[CLASSECOMPRA] [nvarchar](1) NULL,
	[CLASSEESTOQUE] [nvarchar](1) NULL,
	[TIPO] [nvarchar](1) NULL,
	[SIMPLESNACIONAL] [nvarchar](1) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Funcionario]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Funcionario](
	[CodigoFuncionario] [int] NULL,
	[Funcionario] [varchar](40) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Gerente]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Gerente](
	[CODGERENTE] [numeric](4, 0) NULL,
	[NOMEGERENTE] [nvarchar](40) NULL,
	[COD_CADRCA] [numeric](4, 0) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_GrupoProduto]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_GrupoProduto](
	[CodigoGrupo] [varchar](10) NULL,
	[CodigoFilial] [varchar](4) NULL,
	[Grupo] [varchar](120) NULL,
	[Tipo] [varchar](4) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Inventario]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Inventario](
	[NumeroInventario] [numeric](10, 0) NULL,
	[TipoInventario] [varchar](20) NULL,
	[Status] [varchar](20) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Motivo]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Motivo](
	[CODIGO] [numeric](4, 0) NULL,
	[MOTIVO] [nvarchar](30) NULL,
	[DESCRICAO] [nvarchar](71) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_MotivoAvaria]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_MotivoAvaria](
	[CodigoMotivoAvaria] [int] NULL,
	[Descricao] [varchar](80) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_MotivoCorte]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_MotivoCorte](
	[CODIGO] [numeric](4, 0) NULL,
	[MOTIVOCORTE] [varchar](80) NULL,
	[DESCRICAO] [varchar](80) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_MotivoDevolucao]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_MotivoDevolucao](
	[CodigoMotivoDevolucao] [int] NULL,
	[MotivoDevolucao] [varchar](30) NULL,
	[Tipo] [varchar](20) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_NotaDevolucao]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_NotaDevolucao](
	[NumeroNotaDevolucao] [numeric](10, 0) NULL,
	[TipoDescarga] [varchar](8) NULL,
	[CodigoFiscal] [varchar](8) NULL,
	[TipoDevolucao] [varchar](20) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_NotaEntrada]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_NotaEntrada](
	[NumeroTransacaoEntrada] [numeric](10, 0) NULL,
	[NumeroNota] [numeric](10, 0) NULL,
	[Serie] [varchar](8) NULL,
	[Especie] [varchar](8) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_NotaSaida]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_NotaSaida](
	[NumeroNotaVenda] [numeric](10, 0) NULL,
	[NumeroTransacaoVenda] [numeric](10, 0) NULL,
	[TipoVenda] [varchar](8) NULL,
	[CondicaoVenda] [varchar](8) NULL,
	[CondicaoVendaDescricao] [varchar](50) NULL,
	[Cancelado] [varchar](20) NULL,
	[Especie] [varchar](8) NULL,
	[Serie] [varchar](8) NULL,
	[QuantidadeItens] [varchar](8) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_OrdemServico]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_OrdemServico](
	[NumeroOS] [int] NULL,
	[CodigoOperacional] [varchar](20) NULL,
	[NumeroTransacaoWMS] [int] NULL,
	[Estorno] [varchar](20) NULL,
	[Posicao] [varchar](20) NULL,
	[Hora] [int] NULL,
	[Minuto] [int] NULL,
	[TipoOS] [varchar](50) NULL,
	[CodigoTipoOS] [int] NULL,
	[Aplicacao] [varchar](500) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Parceiro]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Parceiro](
	[CodigoParceiro] [varchar](15) NULL,
	[NomeParceiro] [varchar](60) NULL,
	[TipoParceiro] [varchar](15) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_PastaCompras]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_PastaCompras](
	[PASTA] [int] NULL,
	[COMPRADOR] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_PedidoCompra]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_PedidoCompra](
	[NumeroPedido] [varchar](20) NULL,
	[Frete] [varchar](8) NULL,
	[Paletizado] [varchar](8) NULL,
	[TipoEmbalagemPedido] [varchar](8) NULL,
	[TipoDescarga] [varchar](8) NULL,
	[TipoVencimento] [varchar](8) NULL,
	[TipoBonificacao] [varchar](8) NULL,
	[Exportado] [varchar](8) NULL,
	[Orcamento] [varchar](8) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_PedidoVenda]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_PedidoVenda](
	[NumeroPedido] [numeric](10, 0) NULL,
	[Situacao] [varchar](50) NULL,
	[Hora] [int] NULL,
	[Minuto] [int] NULL,
	[CondicaoVendaDescricao] [varchar](50) NULL,
	[Cancelado] [varchar](50) NULL,
	[QuantidadeItens] [varchar](8) NULL,
	[TipoPedido] [varchar](80) NULL,
	[CodigoTipoPedido] [varchar](20) NULL,
	[CondicaoVenda] [varchar](50) NULL,
	[OrigemPedido] [varchar](80) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Periodo]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Periodo](
	[THEDATE] [date] NULL,
	[ANO] [nvarchar](40) NULL,
	[TRIMESTRE] [nvarchar](12) NULL,
	[MESNUMERO] [nvarchar](40) NULL,
	[MES] [nvarchar](11) NULL,
	[MESABREV] [nvarchar](6) NULL,
	[DATA] [nvarchar](8) NULL,
	[DIA] [nvarchar](40) NULL,
	[DIASEMANA] [nvarchar](13) NULL,
	[DIAUTIL] [nvarchar](12) NULL,
	[DIASEMANANUMERO] [nvarchar](40) NULL,
	[TRIMESTRENUMERO] [nvarchar](40) NULL,
	[QUANTIDADEDIASUTIL] [int] NULL,
	[QUANTIDADEDIASNAOUTIL] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_PlanoPagamento]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_PlanoPagamento](
	[CodigoPlanoPagamento] [int] NULL,
	[PlanoPagamento] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Produto]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Produto](
	[CodigoProduto] [int] NOT NULL,
	[Produto] [varchar](120) NULL,
	[CodigoFornecedor] [int] NULL,
	[Fornecedor] [varchar](60) NULL,
	[FornecedorFantasia] [varchar](200) NULL,
	[CodigoCategoria] [int] NULL,
	[Categoria] [varchar](80) NULL,
	[TipoMedicamento] [varchar](20) NULL,
	[CodigoSubCategoria] [int] NULL,
	[SubCategoria] [varchar](80) NULL,
	[CodigoSecao] [int] NULL,
	[Secao] [varchar](80) NULL,
	[CodigoDepartamento] [int] NULL,
	[Departamento] [varchar](80) NULL,
	[Embalagem] [varchar](12) NULL,
	[EmbalagemMaster] [varchar](12) NULL,
	[CodigoFabrica] [varchar](40) NULL,
	[Classe] [varchar](8) NULL,
	[Marca] [varchar](80) NULL,
	[Importado] [varchar](2) NULL,
	[LinhaProduto] [varchar](80) NULL,
	[ForaLinha] [varchar](40) NULL,
	[UFFornecedor] [varchar](4) NULL,
	[CidadeFornecedor] [varchar](80) NULL,
	[CodigoComprador] [int] NULL,
	[Comprador] [varchar](60) NULL,
	[CodigoFornecedorPrincipal] [int] NULL,
	[FornecedorPrincipal] [varchar](60) NULL,
	[CodigoDistribuicao] [varchar](20) NULL,
	[Distribuicao] [varchar](40) NULL,
	[Situacao] [varchar](20) NULL,
	[EmailFornecedor] [varchar](200) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_ProdutoFilial]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_ProdutoFilial](
	[CodigoProduto] [int] NOT NULL,
	[CodigoFilial] [varchar](4) NULL,
	[CodigoComprador] [int] NULL,
	[ProibidaVenda] [varchar](1) NULL,
	[ForaLinha] [varchar](1) NULL,
	[Revenda] [varchar](1) NULL,
	[Comprador] [varchar](60) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_RCA]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_RCA](
	[CODIGORCA] [int] NULL,
	[RCA] [nvarchar](40) NULL,
	[EMAILRCA] [nvarchar](100) NULL,
	[CODIGOSUPERVISOR] [int] NULL,
	[SUPERVISOR] [nvarchar](40) NULL,
	[EMAILSUPERVISOR] [nvarchar](100) NULL,
	[CODIGOGERENTE] [int] NULL,
	[GERENTE] [nvarchar](40) NULL,
	[EMAILGERENTE] [nvarchar](max) NULL,
	[SITUACAO] [nvarchar](7) NULL,
	[TIPO] [nvarchar](13) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Regiao]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Regiao](
	[NumeroRegiao] [varchar](20) NULL,
	[Regiao] [varchar](80) NULL,
	[UF] [varchar](4) NULL,
	[Status] [varchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Supervisor]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Supervisor](
	[CODSUPERVISOR] [numeric](4, 0) NULL,
	[NOME] [nvarchar](40) NULL,
	[COD_CADRCA] [numeric](4, 0) NULL,
	[CODGERENTE] [numeric](4, 0) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Time_Vendas]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Time_Vendas](
	[CODIGORCA] [int] NULL,
	[RCA] [nvarchar](40) NULL,
	[CODIGOSUPERVISOR] [int] NULL,
	[SUPERVISOR] [nvarchar](40) NULL,
	[CODIGOGERENTE] [int] NULL,
	[GERENTE] [nvarchar](40) NULL,
	[Descricao-Rca] [nvarchar](83) NULL,
	[Descricao-Supervisor] [nvarchar](83) NULL,
	[Descricao-Gerente] [nvarchar](83) NULL,
	[SITUACAO] [nvarchar](7) NULL,
	[TIPO] [nvarchar](13) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_TipoErro]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_TipoErro](
	[CodigoErro] [int] NULL,
	[Descricao] [varchar](80) NULL,
	[PesoErro] [numeric](18, 6) NULL,
	[PesoAcerto] [numeric](18, 6) NULL,
	[TipoOS] [varchar](2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_TipoItemVenda]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_TipoItemVenda](
	[CodigoTipoItemVenda] [varchar](1) NULL,
	[Descricao] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_TipoMetaLogistica]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_TipoMetaLogistica](
	[CodigoTipoMeta] [int] NULL,
	[TipoMeta] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_TipoOperacao]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_TipoOperacao](
	[CodigoOperacao] [varchar](2) NULL,
	[TipoOperacao] [varchar](50) NULL,
	[NaturezaOperacao] [varchar](20) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Treinamento]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Treinamento](
	[CodigoTreinamento] [int] NOT NULL,
	[Titulo] [varchar](60) NOT NULL,
	[Instrutor] [varchar](60) NOT NULL,
	[Descricao] [varchar](150) NOT NULL,
	[Data] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Visita]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Visita](
	[CodigoVisita] [int] NOT NULL,
	[Visitado] [varchar](8) NULL,
	[Descricao] [varchar](60) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fat_Sto_Compras]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fat_Sto_Compras](
	[CODPROD] [int] NULL,
	[GIRODIA] [nvarchar](40) NULL,
	[ESTDIAS] [nvarchar](40) NULL,
	[STODIASREPO] [nvarchar](40) NULL,
	[REPOR] [date] NULL,
	[VLCUSTOREAL] [numeric](38, 4) NULL,
	[QTGERENCIAL] [nvarchar](40) NULL,
	[QTRESERV] [nvarchar](40) NULL,
	[QTPENDENTE] [nvarchar](40) NULL,
	[QTBLOQUEADA] [nvarchar](40) NULL,
	[DTULTSAIDA] [date] NULL,
	[QTVENDMES] [nvarchar](40) NULL,
	[QTVENDMES1] [nvarchar](40) NULL,
	[QTVENDMES2] [nvarchar](40) NULL,
	[QTVENDMES3] [nvarchar](40) NULL,
	[DTULTENT] [date] NULL,
	[QTULTENT] [numeric](16, 3) NULL,
	[LEADTIME] [numeric](38, 4) NULL,
	[QTPEDIDA] [nvarchar](40) NULL,
	[DATA] [date] NULL,
	[CODCOMPRADOR] [numeric](8, 0) NULL,
	[CODFORNEC] [numeric](6, 0) NULL,
	[PESOBRUTO] [nvarchar](40) NULL,
	[VLVENDA] [nvarchar](40) NULL,
	[VLBONIFIC] [nvarchar](40) NULL,
	[VLCUSTOFIN] [nvarchar](40) NULL,
	[QT] [nvarchar](40) NULL,
	[QTCX] [nvarchar](40) NULL,
	[QTBNF] [nvarchar](40) NULL,
	[QTPEDIDOS] [nvarchar](40) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fat_Sto_Manegement]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fat_Sto_Manegement](
	[CODFORNEC] [int] NULL,
	[CODPROD] [int] NULL,
	[GIRODIA] [nvarchar](40) NULL,
	[ESTDIAS] [nvarchar](40) NULL,
	[STODIASREPO] [nvarchar](40) NULL,
	[REPOR] [date] NULL,
	[VLCUSTOREAL] [nvarchar](40) NULL,
	[QTGERENCIAL] [nvarchar](40) NULL,
	[QTRESERV] [nvarchar](40) NULL,
	[QTPENDENTE] [nvarchar](40) NULL,
	[QTBLOQUEADA] [nvarchar](40) NULL,
	[DTULTSAIDA] [date] NULL,
	[QTVENDMES] [nvarchar](40) NULL,
	[QTVENDMES1] [nvarchar](40) NULL,
	[QTVENDMES2] [nvarchar](40) NULL,
	[QTVENDMES3] [nvarchar](40) NULL,
	[DTULTENT] [date] NULL,
	[QTULTENT] [numeric](16, 3) NULL,
	[LEADTIME] [numeric](38, 4) NULL,
	[QTPEDIDA] [nvarchar](40) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fat_Venda_Compras]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fat_Venda_Compras](
	[DATA] [date] NULL,
	[CODCOMPRADOR] [numeric](8, 0) NULL,
	[CODFORNEC] [int] NULL,
	[CODPROD] [int] NULL,
	[PESOBRUTO] [nvarchar](40) NULL,
	[VLVENDA] [nvarchar](40) NULL,
	[VLBONIFIC] [nvarchar](40) NULL,
	[VLCUSTOFIN] [nvarchar](40) NULL,
	[QT] [nvarchar](40) NULL,
	[QTCX] [nvarchar](40) NULL,
	[QTBNF] [nvarchar](40) NULL,
	[QTPEDIDOS] [nvarchar](40) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_ApuracaoCampanha]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_ApuracaoCampanha](
	[CodigoFilial] [varchar](4) NULL,
	[CodigoRCA] [int] NULL,
	[TipoMeta] [varchar](4) NULL,
	[CodigoEntidade] [varchar](20) NULL,
	[Metrica] [varchar](60) NULL,
	[Referencia] [varchar](10) NULL,
	[Data] [datetime] NULL,
	[Previsto] [numeric](18, 6) NULL,
	[Realizado] [numeric](18, 6) NULL,
	[Premio] [numeric](18, 6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_Balancete]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_Balancete](
	[CodigoFilial] [varchar](4) NULL,
	[Data] [datetime] NULL,
	[Indicador] [varchar](60) NULL,
	[Valor] [numeric](18, 6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_BoletimFinanceiro]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_BoletimFinanceiro](
	[CodigoFilial] [varchar](4) NULL,
	[DataInicial] [datetime] NULL,
	[DataFinal] [datetime] NULL,
	[SaldoBancario] [numeric](18, 6) NULL,
	[SaldoContasReceber] [numeric](18, 6) NULL,
	[SaldoEstoque] [numeric](18, 6) NULL,
	[SaldoContasPagar] [numeric](18, 6) NULL,
	[SaldoCaixa] [numeric](18, 6) NULL,
	[SaldoVale] [numeric](18, 6) NULL,
	[SaldoEmprestimoReceber] [numeric](18, 6) NULL,
	[SaldoEmprestimoPagar] [numeric](18, 6) NULL,
	[SaldoContaTransitoria] [numeric](18, 6) NULL,
	[SaldoContasReceberFornecedor] [numeric](18, 6) NULL,
	[SaldoInvestimentoAtivo] [numeric](18, 6) NULL,
	[SaldoInvestimentoPassivo] [numeric](18, 6) NULL,
	[SaldoAdiantamentoFornecedor] [numeric](18, 6) NULL,
	[SaldoCredito] [numeric](18, 6) NULL,
	[SaldoTituloDesconto] [numeric](18, 6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_Bonus]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_Bonus](
	[CodigoFilial] [varchar](4) NULL,
	[CodigoProduto] [int] NULL,
	[NumeroBonus] [int] NULL,
	[CodigoFuncionarioCRM] [int] NULL,
	[CodigoFuncionarioFechamento] [int] NULL,
	[CodigoFuncionarioBonus] [int] NULL,
	[CodigoFuncionarioCancelamento] [int] NULL,
	[CodigoMotivoDevolucao] [int] NULL,
	[DataBonus] [datetime] NULL,
	[DataCancelamento] [datetime] NULL,
	[DataFechamento] [datetime] NULL,
	[QuantidadeNota] [numeric](18, 6) NULL,
	[QuantidadeEntrada] [numeric](18, 6) NULL,
	[QuantidadeFalta]  AS ([QuantidadeNota]-[QuantidadeEntrada]),
	[QuantidadeAvaria] [numeric](18, 6) NULL,
	[Falta] [int] NULL,
	[Avaria] [int] NULL,
	[PesoBrutoUnitario] [numeric](18, 6) NULL,
	[PesoLiquidoUnitario] [numeric](18, 6) NULL,
	[VolumeUnitario] [numeric](18, 6) NULL,
	[PesoBrutoTotal]  AS ([PesoBrutoUnitario]*[QuantidadeEntrada]),
	[PesoLiquidoTotal]  AS ([PesoLiquidoUnitario]*[QuantidadeEntrada]),
	[VolumeTotal]  AS ([VolumeUnitario]*[QuantidadeEntrada])
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_BonusWMS]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_BonusWMS](
	[NumeroTransWMS] [numeric](10, 0) NULL,
	[NumeroPedido] [numeric](10, 0) NULL,
	[NumeroBonus] [int] NULL,
	[CodigoProduto] [int] NULL,
	[CodigoFilial] [varchar](4) NULL,
	[CodigoOperacao] [varchar](2) NULL,
	[DataEntrada] [datetime] NULL,
	[Quantidade] [numeric](18, 6) NULL,
	[QuantidadeUnitariaCaixa] [numeric](18, 6) NULL,
	[QuantidadeCaixaPalete] [numeric](18, 6) NULL,
	[QuantidadeAvaria] [numeric](18, 6) NULL,
	[QuantidadeBloqueada] [numeric](18, 6) NULL,
	[PesoLiquidoUnitario] [numeric](18, 6) NULL,
	[PesoBrutoUnitario] [numeric](18, 6) NULL,
	[PesoTotal] [numeric](18, 6) NULL,
	[VolumeUnitario] [numeric](18, 6) NULL,
	[VolumeTotal] [numeric](18, 6) NULL,
	[ValorTotal] [numeric](18, 6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_Carregamento]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_Carregamento](
	[NumeroCarregamento] [varchar](20) NULL,
	[CodigoVeiculo] [int] NULL,
	[CodigoMotorista] [int] NULL,
	[CodigoFilial] [varchar](4) NULL,
	[CodigoFuncionario] [int] NULL,
	[CodigoRota] [int] NULL,
	[CodigoRotaPrincipal] [int] NULL,
	[DataFechamento] [datetime] NULL,
	[DataFaturamento] [datetime] NULL,
	[DataSaida] [datetime] NULL,
	[QuantidadeNota] [numeric](18, 6) NULL,
	[VolumeVeiculo] [numeric](18, 6) NULL,
	[VolumeTotal] [numeric](18, 6) NULL,
	[PesoTotal] [numeric](18, 6) NULL,
	[ValorTotal] [numeric](18, 6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_Cidade]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_Cidade](
	[CodigoIBGE] [varchar](30) NULL,
	[Cidade] [varchar](120) NULL,
	[UF] [varchar](50) NULL,
	[Estado] [varchar](120) NULL,
	[Populacao] [numeric](18, 0) NULL,
	[Perimetro] [numeric](18, 6) NULL,
	[Area] [numeric](18, 6) NULL,
	[Regiao] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_Cliente]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_Cliente](
	[CodigoCliente] [int] NULL,
	[DiasCadastro] [int] NULL,
	[DiasUltimasVenda] [int] NULL,
	[DataCadastro] [datetime] NULL,
	[DataUltimaVenda] [datetime] NULL,
	[LimiteCredito] [numeric](18, 6) NULL,
	[ValorPedidoFaturar] [numeric](18, 6) NULL,
	[ValorReceber] [numeric](18, 6) NULL,
	[DiasUltimaCobranca] [int] NULL,
	[ValorDescontoFinanceiro] [numeric](18, 6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_CobrancaCliente]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_CobrancaCliente](
	[CodigoCliente] [int] NULL,
	[CodigoFuncionario] [int] NULL,
	[DataCobranca] [datetime] NULL,
	[NumeroCobranca] [nvarchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_Colaborador]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_Colaborador](
	[Matricula] [int] NULL,
	[DataAdmissao] [date] NULL,
	[DataNascimento] [date] NULL,
	[DataDemissao] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_Compra]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_Compra](
	[NumeroTransacaoEntrada] [numeric](10, 0) NULL,
	[CodigoProduto] [int] NULL,
	[CodigoFornecedor] [int] NULL,
	[CodigoFilial] [varchar](4) NULL,
	[NumeroNota] [numeric](10, 0) NULL,
	[DataEntrada] [datetime] NULL,
	[DataMovimentacao] [datetime] NULL,
	[Quantidade] [numeric](18, 6) NULL,
	[ValorUnitario] [numeric](18, 6) NULL,
	[ValorUnitarioTabela] [numeric](18, 6) NULL,
	[ValorUnitarioCusto] [numeric](18, 6) NULL,
	[ValorUnitarioDesconto] [numeric](18, 6) NULL,
	[PesoUnitarioBruto] [numeric](18, 6) NULL,
	[PesoUnitarioLiquido] [numeric](18, 6) NULL,
	[VolumeUnitario] [numeric](18, 6) NULL,
	[ValorTotal]  AS ([Quantidade]*[ValorUnitario]),
	[ValorTotalTabela]  AS ([Quantidade]*[ValorUnitarioTabela]),
	[ValorTotalCusto]  AS ([Quantidade]*[ValorUnitarioCusto]),
	[ValorTotalDesconto]  AS ([Quantidade]*[ValorUnitarioDesconto]),
	[PesoTotalBruto]  AS ([Quantidade]*[PesoUnitarioBruto]),
	[PesoTotalLiquido]  AS ([Quantidade]*[PesoUnitarioLiquido]),
	[VolumeTotal]  AS ([Quantidade]*[VolumeUnitario]),
	[PercentualDesconto] [numeric](18, 6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_CompraPedido]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_CompraPedido](
	[NumeroPedido] [varchar](20) NULL,
	[CodigoFilial] [varchar](4) NULL,
	[CodigoProduto] [int] NULL,
	[DataEmissao] [datetime] NULL,
	[DataPrevisaoEntrega] [datetime] NULL,
	[DataFaturamento] [datetime] NULL,
	[DataEmbarque] [datetime] NULL,
	[PrazoEntrega] [int] NULL,
	[QuantidadePedida] [numeric](18, 6) NULL,
	[QuantidadeEntregue] [numeric](18, 6) NULL,
	[ValorTotal] [numeric](18, 6) NULL,
	[ValorEntregue] [numeric](18, 6) NULL,
	[Situacao] [varchar](40) NULL,
	[ValorPendente]  AS ([ValorTotal]-[ValorEntregue]),
	[QuantidadePendente]  AS ([QuantidadePedida]-[QuantidadeEntregue])
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_ContasPagar]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_ContasPagar](
	[NumeroLancamento] [int] NOT NULL,
	[CodigoConta] [int] NOT NULL,
	[CodigoFilial] [varchar](4) NOT NULL,
	[CodigoParceiro] [varchar](15) NOT NULL,
	[ValorLancamento] [numeric](18, 6) NULL,
	[ValorPagamento] [numeric](18, 6) NULL,
	[ValorDevolucao] [numeric](18, 6) NULL,
	[ValorDesconto] [numeric](18, 6) NULL,
	[ValorJuros] [numeric](18, 6) NULL,
	[DataPagamento] [datetime] NULL,
	[DataTitulo] [datetime] NULL,
	[DataVencimento] [datetime] NULL,
	[DataCompetencia] [datetime] NULL,
	[NumeroNota] [numeric](10, 0) NULL,
	[NumeroNotaDevolucao] [numeric](10, 0) NULL,
	[CodigoBanco] [int] NULL,
	[CodigoFornecedor] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_ContasReceber]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_ContasReceber](
	[Prestacao] [varchar](10) NULL,
	[NumeroTransacaoVenda] [numeric](10, 0) NULL,
	[CodigoCliente] [int] NOT NULL,
	[CodigoCobranca] [varchar](4) NULL,
	[CodigoFilial] [varchar](2) NULL,
	[CodigoRCA] [int] NULL,
	[NumeroCarregamento] [varchar](20) NULL,
	[ValorTitulo] [numeric](18, 6) NULL,
	[ValorPago] [numeric](18, 6) NULL,
	[ValorJuros] [numeric](18, 6) NULL,
	[ValorInadimplente] [numeric](18, 6) NULL,
	[ValorPagoAtraso] [numeric](18, 6) NULL,
	[ValorJurosDevido] [numeric](18, 6) NULL,
	[ValorDesconto] [numeric](18, 6) NULL,
	[DataTitulo] [datetime] NULL,
	[DataBaixa] [datetime] NULL,
	[DataEmissao] [datetime] NULL,
	[DataVencimento] [datetime] NULL,
	[DataPagamento] [datetime] NULL,
	[Prazo] [int] NULL,
	[DiasAtraso] [int] NULL,
	[Inadimplente] [int] NULL,
	[Atrasado] [int] NULL,
	[CodigoBanco] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_Corte]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_Corte](
	[CodigoFilial] [varchar](4) NULL,
	[CodigoRCA] [int] NULL,
	[CodigoCliente] [int] NULL,
	[CodigoProduto] [int] NULL,
	[CodigoCobranca] [varchar](4) NULL,
	[CodigoPlanoPagamento] [int] NULL,
	[CodigoFuncionario] [int] NULL,
	[NumeroPedido] [numeric](10, 0) NULL,
	[NumeroTransacaoVenda] [numeric](10, 0) NULL,
	[DataCorte] [datetime] NULL,
	[DataVenda] [datetime] NULL,
	[QuantidadeSeparada] [numeric](18, 6) NULL,
	[QuantidadeCortada] [numeric](18, 6) NULL,
	[MotivoCorte] [varchar](80) NULL,
	[PrecoVenda] [numeric](18, 6) NULL,
	[PrecoTotalCorte]  AS ([PrecoVenda]*[QuantidadeCortada])
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_Data]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_Data](
	[Data] [datetime] NULL,
	[DiaUtil] [int] NULL,
	[DiaNaoUtil] [int] NULL,
	[DiasTranscorridos] [int] NULL,
	[DiasNoMes] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_DevolucaoFornecedor]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_DevolucaoFornecedor](
	[CodigoFilial] [varchar](4) NULL,
	[NumeroBonus] [int] NULL,
	[CodigoMotivoDevolucao] [int] NULL,
	[DataDevolucao] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[fato_DevolucaoNormal]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[fato_DevolucaoNormal](
	[CODUSUR] [numeric](4, 0) NULL,
	[CODSUPERVISOR] [numeric](38, 4) NULL,
	[CODFILIAL] [numeric](2, 0) NULL,
	[CODDEVOL] [numeric](4, 0) NULL,
	[DTENT] [date] NULL,
	[NOME] [nvarchar](40) NULL,
	[QTNF] [numeric](12, 0) NULL,
	[VLTOTAL] [numeric](12, 6) NULL,
	[TOTPESO] [numeric](12, 6) NULL,
	[VLOUTRAS] [numeric](12, 6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_Endereco]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_Endereco](
	[CodigoEndereco] [numeric](10, 0) NULL,
	[Volume] [numeric](18, 6) NULL,
	[Altura] [numeric](18, 6) NULL,
	[Largura] [numeric](18, 6) NULL,
	[Comprimento] [numeric](18, 6) NULL,
	[Peso] [numeric](18, 6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_EntradaInventario]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_EntradaInventario](
	[CodigoProduto] [int] NULL,
	[CodigoFilial] [varchar](4) NULL,
	[CodigoFornecedor] [int] NULL,
	[DataMovimentacao] [datetime] NULL,
	[Quantidade] [numeric](18, 6) NULL,
	[ValorUnitario] [numeric](18, 6) NULL,
	[ValorUnitarioCusto] [numeric](18, 6) NULL,
	[ValorCustoTotal] [numeric](18, 6) NULL,
	[PesoUnitarioLiquido] [numeric](18, 6) NULL,
	[PesoUnitarioBruto] [numeric](18, 6) NULL,
	[VolumeUnitario] [numeric](18, 6) NULL,
	[ValorTotal]  AS ([Quantidade]*[ValorUnitario]),
	[PesoLiquidoTotal]  AS ([Quantidade]*[PesoUnitarioLiquido]),
	[PesoBrutoTotal]  AS ([Quantidade]*[PesoUnitarioBruto]),
	[VolumeTotal]  AS ([Quantidade]*[VolumeUnitario])
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_ErroWMS]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_ErroWMS](
	[CodigoFilial] [varchar](4) NULL,
	[CodigoErro] [int] NULL,
	[NumeroOS] [int] NULL,
	[CodigoFuncionarioErro] [int] NULL,
	[CodigoFuncionarioAcerto] [int] NULL,
	[DataErro] [datetime] NULL,
	[Quantidade] [numeric](18, 6) NULL,
	[PesoErro] [numeric](18, 6) NULL,
	[TotalErro] [numeric](18, 6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_EstoqueAtual]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_EstoqueAtual](
	[CodigoProduto] [int] NULL,
	[CodigoFornecedor] [int] NULL,
	[CodigoFilial] [int] NULL,
	[CodigoRegiao] [int] NULL,
	[CodigoMobivoDevolucao] [int] NULL,
	[CustoUltimaEntrada] [numeric](18, 6) NULL,
	[CustoRealUnitario] [numeric](18, 6) NULL,
	[CustoFinanceiroUnitario] [numeric](18, 6) NULL,
	[CustoContabilUnitario] [numeric](18, 6) NULL,
	[CustoReposicaoUnitario] [numeric](18, 6) NULL,
	[QuantidadeGerencial] [numeric](18, 6) NULL,
	[QuantidadeAvaria] [numeric](18, 6) NULL,
	[QuantidadeBloqueada] [numeric](18, 6) NULL,
	[QuantidadeReservada] [numeric](18, 6) NULL,
	[QuantidadePedida] [numeric](18, 6) NULL,
	[QuantidadePendente] [numeric](18, 6) NULL,
	[QuantidadeBloqueioVenda] [numeric](18, 6) NULL,
	[GiroDia] [numeric](18, 6) NULL,
	[DataUltimaCompra] [datetime] NULL,
	[DiasSemCompra] [int] NULL,
	[DataUltimaVenda] [datetime] NULL,
	[DiasSemVenda] [int] NULL,
	[ValorVendaUnitario] [numeric](18, 6) NULL,
	[PesoBrutoUnitario] [numeric](18, 6) NULL,
	[PesoLiquidoUnitario] [numeric](18, 6) NULL,
	[VolumeUnitario] [numeric](18, 6) NULL,
	[QuantidadeUnitaria] [numeric](18, 6) NULL,
	[QuantidadeUnitariaCaixa] [numeric](18, 6) NULL,
	[PrazoEntrega] [numeric](18, 6) NULL,
	[TempoReposicao] [numeric](18, 6) NULL,
	[QuantidadeDisponivel]  AS (([QuantidadeGerencial]-[QuantidadeReservada])-[QuantidadeBloqueada]),
	[CustoFinanceiroTotal]  AS ((([QuantidadeGerencial]-[QuantidadeReservada])-[QuantidadeAvaria])*[CustoFinanceiroUnitario]),
	[CustoRealTotal]  AS ((([QuantidadeGerencial]-[QuantidadeReservada])-[QuantidadeAvaria])*[CustoRealUnitario]),
	[CustoReposicaoTotal]  AS ((([QuantidadeGerencial]-[QuantidadeReservada])-[QuantidadeAvaria])*[CustoReposicaoUnitario]),
	[CustoContabilTotal]  AS ((([QuantidadeGerencial]-[QuantidadeReservada])-[QuantidadeAvaria])*[CustoContabilUnitario]),
	[ValorVendaTotal]  AS ([ValorVendaUnitario]*(([QuantidadeGerencial]-[QuantidadeReservada])-[QuantidadeAvaria])),
	[PesoBrutoTotal]  AS ([QuantidadeGerencial]*[PesoBrutoUnitario]),
	[PesoLiquidoTotal]  AS ([QuantidadeGerencial]*[PesoLiquidoUnitario]),
	[VolumeTotal]  AS ([QuantidadeGerencial]*[VolumeUnitario]),
	[EstoqueIdeal]  AS ([GiroDia]*([TempoReposicao]+[PrazoEntrega])),
	[SugestaoCompra]  AS (case when (([QuantidadeGerencial]-[QuantidadeReservada])-[QuantidadeAvaria])<[GiroDia]*([TempoReposicao]+[PrazoEntrega]) then (([QuantidadeGerencial]-[QuantidadeReservada])-[QuantidadeAvaria])-[GiroDia]*([TempoReposicao]+[PrazoEntrega]) else (0) end),
	[VendaPerdida]  AS (case when [GiroDia]>((([QuantidadeGerencial]-[QuantidadeReservada])-[QuantidadeBloqueada])-[QuantidadeBloqueioVenda]) then ([GiroDia]-((([QuantidadeGerencial]-[QuantidadeReservada])-[QuantidadeBloqueada])-[QuantidadeBloqueioVenda]))*[CustoFinanceiroUnitario] else (0) end),
	[QuantidadeExcesso]  AS (case when (([QuantidadeGerencial]-[QuantidadeReservada])-[QuantidadeBloqueada])>([GiroDia]*([TempoReposicao]+[PrazoEntrega]))*(2) then (([QuantidadeGerencial]-[QuantidadeReservada])-[QuantidadeBloqueada])-([GiroDia]*([TempoReposicao]+[PrazoEntrega]))*(2) else (0) end),
	[QuantidadeFalta]  AS (case when (([QuantidadeGerencial]-[QuantidadeReservada])-[QuantidadeBloqueada])<([GiroDia]*([TempoReposicao]+[PrazoEntrega]))*(0.5) then ((([QuantidadeGerencial]-[QuantidadeReservada])-[QuantidadeBloqueada])-([GiroDia]*([TempoReposicao]+[PrazoEntrega]))*(0.5))*(-1) else (0) end),
	[ProdutoExcesso]  AS (case when (([QuantidadeGerencial]-[QuantidadeReservada])-[QuantidadeBloqueada])>([GiroDia]*([TempoReposicao]+[PrazoEntrega]))*(2) then (1) else (0) end),
	[ProdutoFalta]  AS (case when (([QuantidadeGerencial]-[QuantidadeReservada])-[QuantidadeBloqueada])<([GiroDia]*([TempoReposicao]+[PrazoEntrega]))*(0.5) then (1) else (0) end),
	[ValorExcesso]  AS (case when (([QuantidadeGerencial]-[QuantidadeReservada])-[QuantidadeBloqueada])>([GiroDia]*([TempoReposicao]+[PrazoEntrega]))*(2) then ((([QuantidadeGerencial]-[QuantidadeReservada])-[QuantidadeBloqueada])-([GiroDia]*([TempoReposicao]+[PrazoEntrega]))*(2))*[CustoFinanceiroUnitario] else (0) end),
	[ValorFalta]  AS (case when (([QuantidadeGerencial]-[QuantidadeReservada])-[QuantidadeBloqueada])<([GiroDia]*([TempoReposicao]+[PrazoEntrega]))*(0.5) then (((([QuantidadeGerencial]-[QuantidadeReservada])-[QuantidadeBloqueada])-([GiroDia]*([TempoReposicao]+[PrazoEntrega]))*(0.5))*[CustoFinanceiroUnitario])*(-1) else (0) end),
	[ProdutoRuptura]  AS (case when [GiroDia]>(([QuantidadeGerencial]-[QuantidadeReservada])-[QuantidadeBloqueada]) then (1) else (0) end),
	[QuantidadeRuptura]  AS (case when [GiroDia]>(([QuantidadeGerencial]-[QuantidadeReservada])-[QuantidadeBloqueada]) then ([GiroDia]*([TempoReposicao]+[PrazoEntrega])-(([QuantidadeGerencial]-[QuantidadeReservada])-[QuantidadeBloqueada]))-[QuantidadePedida] else (0) end)
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_EstoqueAvaria]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_EstoqueAvaria](
	[CodigoProduto] [int] NULL,
	[CodigoFilial] [varchar](4) NULL,
	[CodigoOperacao] [varchar](2) NULL,
	[CodigoMotivoDevolucao] [int] NULL,
	[Data] [datetime] NULL,
	[CustoUltimaEntrada] [numeric](18, 6) NULL,
	[CustoRealUnitario] [numeric](18, 6) NULL,
	[CustoFinanceiroUnitario] [numeric](18, 6) NULL,
	[CustoContabilUnitario] [numeric](18, 6) NULL,
	[CustoReposicaoUnitario] [numeric](18, 6) NULL,
	[QuantidadeGerencial] [numeric](18, 6) NULL,
	[QuantidadeBloqueada] [numeric](18, 6) NULL,
	[QuantidadeReservada] [numeric](18, 6) NULL,
	[QuantidadePendente] [numeric](18, 6) NULL,
	[QuantidadeAvaria] [numeric](18, 6) NULL,
	[QuantidadeBloqueioVenda] [numeric](18, 6) NULL,
	[QuantidadePedida] [numeric](18, 6) NULL,
	[CustoFinanceiroTotal]  AS ((([QuantidadeGerencial]-[QuantidadeReservada])-[QuantidadeAvaria])*[CustoFinanceiroUnitario]),
	[CustoRealTotal]  AS ((([QuantidadeGerencial]-[QuantidadeReservada])-[QuantidadeAvaria])*[CustoRealUnitario]),
	[CustoReposicaoTotal]  AS ((([QuantidadeGerencial]-[QuantidadeReservada])-[QuantidadeAvaria])*[CustoReposicaoUnitario]),
	[CustoContabilTotal]  AS ((([QuantidadeGerencial]-[QuantidadeReservada])-[QuantidadeAvaria])*[CustoContabilUnitario]),
	[QuantidadeDisponivel]  AS ((([QuantidadeGerencial]-[QuantidadeReservada])-[QuantidadeBloqueada])-[QuantidadeBloqueioVenda]),
	[ValorVendaUnitario] [numeric](18, 6) NULL,
	[ValorVendaTotal]  AS ([ValorVendaUnitario]*(([QuantidadeGerencial]-[QuantidadeReservada])-[QuantidadeAvaria])),
	[PesoBrutoUnitario] [numeric](18, 6) NULL,
	[PesoLiquidoUnitario] [numeric](18, 6) NULL,
	[VolumeUnitario] [numeric](18, 6) NULL,
	[QuantidadeUnitaria] [numeric](18, 6) NULL,
	[QuantidadeUnitariaCaixa] [numeric](18, 6) NULL,
	[PesoBrutoTotal]  AS ([QuantidadeGerencial]*[PesoBrutoUnitario]),
	[PesoLiquidoTotal]  AS ([QuantidadeGerencial]*[PesoLiquidoUnitario]),
	[VolumeTotal]  AS ([QuantidadeGerencial]*[VolumeUnitario]),
	[PrazoEntrega] [numeric](18, 6) NULL,
	[TempoReposicao] [numeric](18, 6) NULL,
	[GiroDia] [numeric](18, 6) NULL,
	[ProdutoRuptura]  AS (case when (([GiroDia]-(([QuantidadeGerencial]-[QuantidadeReservada])-[QuantidadeBloqueada]))-[QuantidadeBloqueioVenda])*[PrazoEntrega]>(0) then (1) else (0) end),
	[QuantidadeRuptura]  AS (case when (([GiroDia]-(([QuantidadeGerencial]-[QuantidadeReservada])-[QuantidadeBloqueada]))-[QuantidadeBloqueioVenda])*[PrazoEntrega]>(0) then (([GiroDia]-(([QuantidadeGerencial]-[QuantidadeReservada])-[QuantidadeBloqueada]))-[QuantidadeBloqueioVenda])*[PrazoEntrega] else (0) end),
	[VendaPerdida]  AS (case when [GiroDia]>((([QuantidadeGerencial]-[QuantidadeReservada])-[QuantidadeBloqueada])-[QuantidadeBloqueioVenda]) then ([GiroDia]-((([QuantidadeGerencial]-[QuantidadeReservada])-[QuantidadeBloqueada])-[QuantidadeBloqueioVenda]))*[CustoFinanceiroUnitario] else (0) end),
	[ValorAvariaTotal]  AS ([QuantidadeAvaria]*[CustoFinanceiroUnitario])
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_EstoqueHistorico]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_EstoqueHistorico](
	[CODIGOPRODUTO] [numeric](6, 0) NULL,
	[CODIGOFILIAL] [int] NULL,
	[CODFORNEC] [int] NULL,
	[DATA] [date] NULL,
	[CUSTOULTIMAENTRADA] [numeric](18, 6) NULL,
	[CUSTOREALUNITARIO] [numeric](18, 6) NULL,
	[CUSTOFINANCEIROUNITARIO] [numeric](18, 6) NULL,
	[CUSTOCONTABILUNITARIO] [numeric](18, 6) NULL,
	[CUSTOREPOSICAOUNITARIO] [numeric](18, 6) NULL,
	[QUANTIDADEGERENCIAL] [numeric](22, 8) NULL,
	[QUANTIDADEBLOQUEADO] [numeric](16, 3) NULL,
	[QUANTIDADERESERVADO] [numeric](22, 8) NULL,
	[QUANTIDADEPENDENTE] [numeric](16, 3) NULL,
	[QUANTIDADEAVARIA] [numeric](16, 3) NULL,
	[QUANTIDADEDISPONIVEL] [numeric](22, 8) NULL,
	[VALORVENDAUNITARIO] [numeric](14, 2) NULL,
	[PESOBRUTO] [numeric](12, 6) NULL,
	[PESOLIQUIDO] [numeric](12, 6) NULL,
	[VOLUME] [numeric](20, 8) NULL,
	[QUANTIDADEUNITARIA] [numeric](6, 2) NULL,
	[QUANTIDADEUNITARIACAIXA] [numeric](8, 2) NULL,
	[PRAZOENTREGA] [numeric](8, 0) NULL,
	[TEMPOREPOSICAO] [numeric](8, 0) NULL,
	[GIRODIA] [numeric](38, 4) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_EstoqueWMS]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_EstoqueWMS](
	[CodigoEndereco] [numeric](10, 0) NULL,
	[CodigoProduto] [int] NULL,
	[CodigoFilial] [varchar](4) NULL,
	[Quantidade] [numeric](18, 6) NULL,
	[QuantidadeBloqueada] [numeric](18, 6) NULL,
	[QuantidadeReservada] [numeric](18, 6) NULL,
	[QuantidadePendenteSaida] [numeric](18, 6) NULL,
	[QuantidadePendenteEntrada] [numeric](18, 6) NULL,
	[DataValidade] [datetime] NULL,
	[QuantidadeDisponivelAvaria]  AS (([Quantidade]+[QuantidadePendenteEntrada])-[QuantidadePendenteSaida]),
	[QuantidadeDisponivel]  AS ((([Quantidade]+[QuantidadePendenteEntrada])-[QuantidadePendenteSaida])-[QuantidadeBloqueada]),
	[VolumeUnitario] [numeric](20, 8) NULL,
	[VolumeTotal]  AS ([VolumeUnitario]*[Quantidade])
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_Falta]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_Falta](
	[CodigoFilial] [varchar](4) NULL,
	[CodigoRCA] [int] NULL,
	[CodigoCliente] [int] NULL,
	[CodigoProduto] [int] NULL,
	[CodigoCobranca] [varchar](4) NULL,
	[CodigoPlanoPagamento] [int] NULL,
	[NumeroTransacaoVenda] [numeric](10, 0) NULL,
	[DataFalta] [datetime] NULL,
	[Quantidade] [numeric](18, 6) NULL,
	[PrecoVendaUnitario] [numeric](18, 6) NULL,
	[PrecoVendaTotal]  AS ([Quantidade]*[PrecoVendaUnitario]),
	[NumeroPedido] [numeric](10, 0) NULL,
	[DataVenda] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_GrupoProduto]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_GrupoProduto](
	[CodigoGrupo] [varchar](10) NULL,
	[CodigoFilial] [varchar](4) NULL,
	[CodigoProduto] [int] NULL,
	[SituacaoItem] [varchar](20) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_Inventario]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_Inventario](
	[NumeroInventario] [numeric](10, 0) NULL,
	[CodigoFilial] [varchar](4) NULL,
	[CodigoProduto] [int] NULL,
	[CodigoEndereco] [numeric](10, 0) NULL,
	[NumeroLote] [varchar](20) NULL,
	[DataGeracao] [datetime] NULL,
	[DataAtualizacao] [datetime] NULL,
	[QuantidadeAnterior] [numeric](18, 6) NULL,
	[QuantidadeInventario] [numeric](18, 6) NULL,
	[DiferencaQuantidade]  AS ([QuantidadeAnterior]-[QuantidadeInventario]),
	[StatusDivergencia] [varchar](20) NULL,
	[ContagemDivergente] [int] NULL,
	[ProdutoSemDivergencia] [varchar](45) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_InventarioContagemInformacao]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_InventarioContagemInformacao](
	[NumeroInventario] [numeric](10, 0) NULL,
	[DataInicioContagem] [datetime] NULL,
	[DataFimContagem] [datetime] NULL,
	[TempoContagem] [numeric](18, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_InventarioInformacao]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_InventarioInformacao](
	[NumeroInventario] [numeric](10, 0) NULL,
	[DataGeracao] [datetime] NULL,
	[DataAtualizacao] [datetime] NULL,
	[TempoInventario] [numeric](18, 2) NULL,
	[DataInicioContagem] [datetime] NULL,
	[DataFimContagem] [datetime] NULL,
	[TempoContagem] [numeric](18, 2) NULL,
	[TempoGestao]  AS ([TempoInventario]-[TempoContagem])
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_LoteProduto]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_LoteProduto](
	[NumeroTransacaoEntrada] [numeric](10, 0) NULL,
	[NumeroLote] [varchar](20) NULL,
	[CodigoProduto] [int] NULL,
	[CodigoFilial] [varchar](4) NULL,
	[DataEntrada] [datetime] NULL,
	[DataSaida] [datetime] NULL,
	[DataValidade] [datetime] NULL,
	[Quantidade] [numeric](18, 6) NULL,
	[QuantidadeReservada] [numeric](18, 6) NULL,
	[QuantidadeBloqueada] [numeric](18, 6) NULL,
	[QuantidadeIndenizada] [numeric](18, 6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_MetaCategoria]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_MetaCategoria](
	[CodigoEntidadeMeta] [int] NULL,
	[CodigoEntidadeMeta2] [int] NULL,
	[CodigoFilial] [varchar](4) NULL,
	[CodigoRCA] [int] NULL,
	[Data] [datetime] NULL,
	[Valor] [numeric](18, 6) NULL,
	[QuantidadeVenda] [numeric](18, 6) NULL,
	[QuantidadePedidos] [numeric](18, 6) NULL,
	[Mix] [numeric](18, 6) NULL,
	[MixMedio] [numeric](18, 6) NULL,
	[Positivacao] [numeric](18, 6) NULL,
	[ClienteCadastrado] [numeric](18, 6) NULL,
	[QuantidadeClienteAtivo] [numeric](18, 6) NULL,
	[Margem] [numeric](18, 6) NULL,
	[Peso] [numeric](18, 6) NULL,
	[Volume] [numeric](18, 6) NULL,
	[DescontoValorVenda] [numeric](18, 6) NULL,
	[Efetividade] [numeric](18, 6) NULL,
	[EfetividadeDiaria] [numeric](18, 6) NULL,
	[MediaItens] [numeric](18, 6) NULL,
	[MediaItensCliente] [numeric](18, 6) NULL,
	[PercentualValorDevolucao] [numeric](18, 6) NULL,
	[PercentualItensDevolucao] [numeric](18, 6) NULL,
	[PercentualInadimplencia] [numeric](18, 6) NULL,
	[PrazoMedio] [numeric](18, 6) NULL,
	[ValorMedioItem] [numeric](18, 6) NULL,
	[ValorMedioPedido] [numeric](18, 6) NULL,
	[ValorMedioPedidoDia] [numeric](18, 6) NULL,
	[PrecoMedio] [numeric](18, 6) NULL,
	[PrecoMedioPeso] [numeric](18, 6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_MetaCliente]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_MetaCliente](
	[CodigoEntidadeMeta] [int] NULL,
	[CodigoEntidadeMeta2] [int] NULL,
	[CodigoFilial] [varchar](4) NULL,
	[CodigoRCA] [int] NULL,
	[Data] [datetime] NULL,
	[Valor] [numeric](18, 6) NULL,
	[QuantidadeVenda] [numeric](18, 6) NULL,
	[QuantidadePedidos] [numeric](18, 6) NULL,
	[Mix] [numeric](18, 6) NULL,
	[MixMedio] [numeric](18, 6) NULL,
	[Positivacao] [numeric](18, 6) NULL,
	[ClienteCadastrado] [numeric](18, 6) NULL,
	[QuantidadeClienteAtivo] [numeric](18, 6) NULL,
	[Margem] [numeric](18, 6) NULL,
	[Peso] [numeric](18, 6) NULL,
	[Volume] [numeric](18, 6) NULL,
	[DescontoValorVenda] [numeric](18, 6) NULL,
	[Efetividade] [numeric](18, 6) NULL,
	[EfetividadeDiaria] [numeric](18, 6) NULL,
	[MediaItens] [numeric](18, 6) NULL,
	[MediaItensCliente] [numeric](18, 6) NULL,
	[PercentualValorDevolucao] [numeric](18, 6) NULL,
	[PercentualItensDevolucao] [numeric](18, 6) NULL,
	[PercentualInadimplencia] [numeric](18, 6) NULL,
	[PrazoMedio] [numeric](18, 6) NULL,
	[ValorMedioItem] [numeric](18, 6) NULL,
	[ValorMedioPedido] [numeric](18, 6) NULL,
	[ValorMedioPedidoDia] [numeric](18, 6) NULL,
	[PrecoMedio] [numeric](18, 6) NULL,
	[PrecoMedioPeso] [numeric](18, 6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_MetaDepartamento]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_MetaDepartamento](
	[CodigoEntidadeMeta] [int] NULL,
	[CodigoEntidadeMeta2] [int] NULL,
	[CodigoFilial] [varchar](4) NULL,
	[CodigoRCA] [int] NULL,
	[Data] [datetime] NULL,
	[Valor] [numeric](18, 6) NULL,
	[QuantidadeVenda] [numeric](18, 6) NULL,
	[QuantidadePedidos] [numeric](18, 6) NULL,
	[Mix] [numeric](18, 6) NULL,
	[MixMedio] [numeric](18, 6) NULL,
	[Positivacao] [numeric](18, 6) NULL,
	[ClienteCadastrado] [numeric](18, 6) NULL,
	[QuantidadeClienteAtivo] [numeric](18, 6) NULL,
	[Margem] [numeric](18, 6) NULL,
	[Peso] [numeric](18, 6) NULL,
	[Volume] [numeric](18, 6) NULL,
	[DescontoValorVenda] [numeric](18, 6) NULL,
	[Efetividade] [numeric](18, 6) NULL,
	[EfetividadeDiaria] [numeric](18, 6) NULL,
	[MediaItens] [numeric](18, 6) NULL,
	[MediaItensCliente] [numeric](18, 6) NULL,
	[PercentualValorDevolucao] [numeric](18, 6) NULL,
	[PercentualItensDevolucao] [numeric](18, 6) NULL,
	[PercentualInadimplencia] [numeric](18, 6) NULL,
	[PrazoMedio] [numeric](18, 6) NULL,
	[ValorMedioItem] [numeric](18, 6) NULL,
	[ValorMedioPedido] [numeric](18, 6) NULL,
	[ValorMedioPedidoDia] [numeric](18, 6) NULL,
	[PrecoMedio] [numeric](18, 6) NULL,
	[PrecoMedioPeso] [numeric](18, 6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_MetaFornecedor]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_MetaFornecedor](
	[CodigoEntidadeMeta] [int] NULL,
	[CodigoEntidadeMeta2] [int] NULL,
	[CodigoFilial] [varchar](4) NULL,
	[CodigoRCA] [int] NULL,
	[Data] [datetime] NULL,
	[Valor] [numeric](18, 6) NULL,
	[QuantidadeVenda] [numeric](18, 6) NULL,
	[QuantidadePedidos] [numeric](18, 6) NULL,
	[Mix] [numeric](18, 6) NULL,
	[MixMedio] [numeric](18, 6) NULL,
	[Positivacao] [numeric](18, 6) NULL,
	[ClienteCadastrado] [numeric](18, 6) NULL,
	[QuantidadeClienteAtivo] [numeric](18, 6) NULL,
	[Margem] [numeric](18, 6) NULL,
	[Peso] [numeric](18, 6) NULL,
	[Volume] [numeric](18, 6) NULL,
	[DescontoValorVenda] [numeric](18, 6) NULL,
	[Efetividade] [numeric](18, 6) NULL,
	[EfetividadeDiaria] [numeric](18, 6) NULL,
	[MediaItens] [numeric](18, 6) NULL,
	[MediaItensCliente] [numeric](18, 6) NULL,
	[PercentualValorDevolucao] [numeric](18, 6) NULL,
	[PercentualItensDevolucao] [numeric](18, 6) NULL,
	[PercentualInadimplencia] [numeric](18, 6) NULL,
	[PrazoMedio] [numeric](18, 6) NULL,
	[ValorMedioItem] [numeric](18, 6) NULL,
	[ValorMedioPedido] [numeric](18, 6) NULL,
	[ValorMedioPedidoDia] [numeric](18, 6) NULL,
	[PrecoMedio] [numeric](18, 6) NULL,
	[PrecoMedioPeso] [numeric](18, 6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_MetaGrupoProduto]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_MetaGrupoProduto](
	[CodigoEntidadeMeta] [varchar](10) NULL,
	[CodigoEntidadeMeta2] [int] NULL,
	[CodigoFilial] [varchar](4) NULL,
	[CodigoRCA] [int] NULL,
	[Data] [datetime] NULL,
	[Valor] [numeric](18, 6) NULL,
	[QuantidadeVenda] [numeric](18, 6) NULL,
	[QuantidadePedidos] [numeric](18, 6) NULL,
	[Mix] [numeric](18, 6) NULL,
	[MixMedio] [numeric](18, 6) NULL,
	[Positivacao] [numeric](18, 6) NULL,
	[ClienteCadastrado] [numeric](18, 6) NULL,
	[QuantidadeClienteAtivo] [numeric](18, 6) NULL,
	[Margem] [numeric](18, 6) NULL,
	[Peso] [numeric](18, 6) NULL,
	[Volume] [numeric](18, 6) NULL,
	[DescontoValorVenda] [numeric](18, 6) NULL,
	[Efetividade] [numeric](18, 6) NULL,
	[EfetividadeDiaria] [numeric](18, 6) NULL,
	[MediaItens] [numeric](18, 6) NULL,
	[MediaItensCliente] [numeric](18, 6) NULL,
	[PercentualValorDevolucao] [numeric](18, 6) NULL,
	[PercentualItensDevolucao] [numeric](18, 6) NULL,
	[PercentualInadimplencia] [numeric](18, 6) NULL,
	[PrazoMedio] [numeric](18, 6) NULL,
	[ValorMedioItem] [numeric](18, 6) NULL,
	[ValorMedioPedido] [numeric](18, 6) NULL,
	[ValorMedioPedidoDia] [numeric](18, 6) NULL,
	[PrecoMedio] [numeric](18, 6) NULL,
	[PrecoMedioPeso] [numeric](18, 6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_MetaLinhaProduto]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_MetaLinhaProduto](
	[CodigoEntidadeMeta] [int] NULL,
	[CodigoEntidadeMeta2] [int] NULL,
	[CodigoFilial] [varchar](4) NULL,
	[CodigoRCA] [int] NULL,
	[Data] [datetime] NULL,
	[Valor] [numeric](18, 6) NULL,
	[QuantidadeVenda] [numeric](18, 6) NULL,
	[QuantidadePedidos] [numeric](18, 6) NULL,
	[Mix] [numeric](18, 6) NULL,
	[MixMedio] [numeric](18, 6) NULL,
	[Positivacao] [numeric](18, 6) NULL,
	[ClienteCadastrado] [numeric](18, 6) NULL,
	[QuantidadeClienteAtivo] [numeric](18, 6) NULL,
	[Margem] [numeric](18, 6) NULL,
	[Peso] [numeric](18, 6) NULL,
	[Volume] [numeric](18, 6) NULL,
	[DescontoValorVenda] [numeric](18, 6) NULL,
	[Efetividade] [numeric](18, 6) NULL,
	[EfetividadeDiaria] [numeric](18, 6) NULL,
	[MediaItens] [numeric](18, 6) NULL,
	[MediaItensCliente] [numeric](18, 6) NULL,
	[PercentualValorDevolucao] [numeric](18, 6) NULL,
	[PercentualItensDevolucao] [numeric](18, 6) NULL,
	[PercentualInadimplencia] [numeric](18, 6) NULL,
	[PrazoMedio] [numeric](18, 6) NULL,
	[ValorMedioItem] [numeric](18, 6) NULL,
	[ValorMedioPedido] [numeric](18, 6) NULL,
	[ValorMedioPedidoDia] [numeric](18, 6) NULL,
	[PrecoMedio] [numeric](18, 6) NULL,
	[PrecoMedioPeso] [numeric](18, 6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_MetaLogistica]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_MetaLogistica](
	[Data] [datetime] NULL,
	[CodigoTipoMeta] [int] NULL,
	[Valor] [numeric](18, 6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_MetaMarca]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_MetaMarca](
	[CodigoEntidadeMeta] [int] NULL,
	[CodigoEntidadeMeta2] [int] NULL,
	[CodigoFilial] [varchar](4) NULL,
	[CodigoRCA] [int] NULL,
	[Data] [datetime] NULL,
	[Valor] [numeric](18, 6) NULL,
	[QuantidadeVenda] [numeric](18, 6) NULL,
	[QuantidadePedidos] [numeric](18, 6) NULL,
	[Mix] [numeric](18, 6) NULL,
	[MixMedio] [numeric](18, 6) NULL,
	[Positivacao] [numeric](18, 6) NULL,
	[ClienteCadastrado] [numeric](18, 6) NULL,
	[QuantidadeClienteAtivo] [numeric](18, 6) NULL,
	[Margem] [numeric](18, 6) NULL,
	[Peso] [numeric](18, 6) NULL,
	[Volume] [numeric](18, 6) NULL,
	[DescontoValorVenda] [numeric](18, 6) NULL,
	[Efetividade] [numeric](18, 6) NULL,
	[EfetividadeDiaria] [numeric](18, 6) NULL,
	[MediaItens] [numeric](18, 6) NULL,
	[MediaItensCliente] [numeric](18, 6) NULL,
	[PercentualValorDevolucao] [numeric](18, 6) NULL,
	[PercentualItensDevolucao] [numeric](18, 6) NULL,
	[PercentualInadimplencia] [numeric](18, 6) NULL,
	[PrazoMedio] [numeric](18, 6) NULL,
	[ValorMedioItem] [numeric](18, 6) NULL,
	[ValorMedioPedido] [numeric](18, 6) NULL,
	[ValorMedioPedidoDia] [numeric](18, 6) NULL,
	[PrecoMedio] [numeric](18, 6) NULL,
	[PrecoMedioPeso] [numeric](18, 6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_MetaProduto]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_MetaProduto](
	[CodigoEntidadeMeta] [int] NULL,
	[CodigoEntidadeMeta2] [int] NULL,
	[CodigoFilial] [varchar](4) NULL,
	[CodigoRCA] [int] NULL,
	[Data] [datetime] NULL,
	[Valor] [numeric](18, 6) NULL,
	[QuantidadeVenda] [numeric](18, 6) NULL,
	[QuantidadePedidos] [numeric](18, 6) NULL,
	[Mix] [numeric](18, 6) NULL,
	[MixMedio] [numeric](18, 6) NULL,
	[Positivacao] [numeric](18, 6) NULL,
	[ClienteCadastrado] [numeric](18, 6) NULL,
	[QuantidadeClienteAtivo] [numeric](18, 6) NULL,
	[Margem] [numeric](18, 6) NULL,
	[Peso] [numeric](18, 6) NULL,
	[Volume] [numeric](18, 6) NULL,
	[DescontoValorVenda] [numeric](18, 6) NULL,
	[Efetividade] [numeric](18, 6) NULL,
	[EfetividadeDiaria] [numeric](18, 6) NULL,
	[MediaItens] [numeric](18, 6) NULL,
	[MediaItensCliente] [numeric](18, 6) NULL,
	[PercentualValorDevolucao] [numeric](18, 6) NULL,
	[PercentualItensDevolucao] [numeric](18, 6) NULL,
	[PercentualInadimplencia] [numeric](18, 6) NULL,
	[PrazoMedio] [numeric](18, 6) NULL,
	[ValorMedioItem] [numeric](18, 6) NULL,
	[ValorMedioPedido] [numeric](18, 6) NULL,
	[ValorMedioPedidoDia] [numeric](18, 6) NULL,
	[PrecoMedio] [numeric](18, 6) NULL,
	[PrecoMedioPeso] [numeric](18, 6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_MetaRamoAtividade]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_MetaRamoAtividade](
	[CodigoEntidadeMeta] [int] NULL,
	[CodigoEntidadeMeta2] [int] NULL,
	[CodigoFilial] [varchar](4) NULL,
	[CodigoRCA] [int] NULL,
	[Data] [datetime] NULL,
	[Valor] [numeric](18, 6) NULL,
	[QuantidadeVenda] [numeric](18, 6) NULL,
	[QuantidadePedidos] [numeric](18, 6) NULL,
	[Mix] [numeric](18, 6) NULL,
	[MixMedio] [numeric](18, 6) NULL,
	[Positivacao] [numeric](18, 6) NULL,
	[ClienteCadastrado] [numeric](18, 6) NULL,
	[QuantidadeClienteAtivo] [numeric](18, 6) NULL,
	[Margem] [numeric](18, 6) NULL,
	[Peso] [numeric](18, 6) NULL,
	[Volume] [numeric](18, 6) NULL,
	[DescontoValorVenda] [numeric](18, 6) NULL,
	[Efetividade] [numeric](18, 6) NULL,
	[EfetividadeDiaria] [numeric](18, 6) NULL,
	[MediaItens] [numeric](18, 6) NULL,
	[MediaItensCliente] [numeric](18, 6) NULL,
	[PercentualValorDevolucao] [numeric](18, 6) NULL,
	[PercentualItensDevolucao] [numeric](18, 6) NULL,
	[PercentualInadimplencia] [numeric](18, 6) NULL,
	[PrazoMedio] [numeric](18, 6) NULL,
	[ValorMedioItem] [numeric](18, 6) NULL,
	[ValorMedioPedido] [numeric](18, 6) NULL,
	[ValorMedioPedidoDia] [numeric](18, 6) NULL,
	[PrecoMedio] [numeric](18, 6) NULL,
	[PrecoMedioPeso] [numeric](18, 6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_MetaRCA]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_MetaRCA](
	[CodigoEntidadeMeta] [int] NULL,
	[CodigoEntidadeMeta2] [int] NULL,
	[CodigoFilial] [varchar](4) NULL,
	[CodigoRCA] [int] NULL,
	[Data] [datetime] NULL,
	[Valor] [numeric](18, 6) NULL,
	[QuantidadeVenda] [numeric](18, 6) NULL,
	[QuantidadePedidos] [numeric](18, 6) NULL,
	[Mix] [numeric](18, 6) NULL,
	[MixMedio] [numeric](18, 6) NULL,
	[Positivacao] [numeric](18, 6) NULL,
	[ClienteCadastrado] [numeric](18, 6) NULL,
	[QuantidadeClienteAtivo] [numeric](18, 6) NULL,
	[Margem] [numeric](18, 6) NULL,
	[Peso] [numeric](18, 6) NULL,
	[Volume] [numeric](18, 6) NULL,
	[DescontoValorVenda] [numeric](18, 6) NULL,
	[Efetividade] [numeric](18, 6) NULL,
	[EfetividadeDiaria] [numeric](18, 6) NULL,
	[MediaItens] [numeric](18, 6) NULL,
	[MediaItensCliente] [numeric](18, 6) NULL,
	[PercentualValorDevolucao] [numeric](18, 6) NULL,
	[PercentualItensDevolucao] [numeric](18, 6) NULL,
	[PercentualInadimplencia] [numeric](18, 6) NULL,
	[PrazoMedio] [numeric](18, 6) NULL,
	[ValorMedioItem] [numeric](18, 6) NULL,
	[ValorMedioPedido] [numeric](18, 6) NULL,
	[ValorMedioPedidoDia] [numeric](18, 6) NULL,
	[PrecoMedio] [numeric](18, 6) NULL,
	[PrecoMedioPeso] [numeric](18, 6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_MetaRCA_PorFornecedor]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_MetaRCA_PorFornecedor](
	[COD_RCA] [numeric](4, 0) NULL,
	[COD_FORNEC] [numeric](6, 0) NULL,
	[META_FIM] [numeric](12, 2) NULL,
	[META_POS] [numeric](6, 0) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_MetaRCA353]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_MetaRCA353](
	[CODFILIAL] [numeric](2, 0) NULL,
	[CODGERENTE] [numeric](4, 0) NULL,
	[CODSUPERVISOR] [numeric](4, 0) NULL,
	[CodigoRCA] [numeric](4, 0) NULL,
	[Data] [date] NULL,
	[Valor] [numeric](18, 6) NULL,
	[QuantidadeVenda] [numeric](18, 6) NULL,
	[QuantidadePedidos] [numeric](18, 6) NULL,
	[Positivacao] [numeric](18, 6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_MetasCompras]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_MetasCompras](
	[codfornec] [int] NULL,
	[FORNECEDOR] [nvarchar](255) NULL,
	[PASTA] [int] NULL,
	[COMPRADOR] [nvarchar](255) NULL,
	[LEADTIME] [int] NULL,
	[R$_META_VENDA] [numeric](16, 2) NULL,
	[Margem_META] [float] NULL,
	[META_DE_ESTOQUE_(DIAS)] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_MetaSecao]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_MetaSecao](
	[CodigoEntidadeMeta] [int] NULL,
	[CodigoEntidadeMeta2] [int] NULL,
	[CodigoFilial] [varchar](4) NULL,
	[CodigoRCA] [int] NULL,
	[Data] [datetime] NULL,
	[Valor] [numeric](18, 6) NULL,
	[QuantidadeVenda] [numeric](18, 6) NULL,
	[QuantidadePedidos] [numeric](18, 6) NULL,
	[Mix] [numeric](18, 6) NULL,
	[MixMedio] [numeric](18, 6) NULL,
	[Positivacao] [numeric](18, 6) NULL,
	[ClienteCadastrado] [numeric](18, 6) NULL,
	[QuantidadeClienteAtivo] [numeric](18, 6) NULL,
	[Margem] [numeric](18, 6) NULL,
	[Peso] [numeric](18, 6) NULL,
	[Volume] [numeric](18, 6) NULL,
	[DescontoValorVenda] [numeric](18, 6) NULL,
	[Efetividade] [numeric](18, 6) NULL,
	[EfetividadeDiaria] [numeric](18, 6) NULL,
	[MediaItens] [numeric](18, 6) NULL,
	[MediaItensCliente] [numeric](18, 6) NULL,
	[PercentualValorDevolucao] [numeric](18, 6) NULL,
	[PercentualItensDevolucao] [numeric](18, 6) NULL,
	[PercentualInadimplencia] [numeric](18, 6) NULL,
	[PrazoMedio] [numeric](18, 6) NULL,
	[ValorMedioItem] [numeric](18, 6) NULL,
	[ValorMedioPedido] [numeric](18, 6) NULL,
	[ValorMedioPedidoDia] [numeric](18, 6) NULL,
	[PrecoMedio] [numeric](18, 6) NULL,
	[PrecoMedioPeso] [numeric](18, 6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_MovimentacaoWMS]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_MovimentacaoWMS](
	[CodigoFilial] [varchar](4) NULL,
	[CodigoProduto] [int] NULL,
	[CodigoEndereco] [numeric](10, 0) NULL,
	[NumeroPedido] [numeric](10, 0) NULL,
	[NumeroOS] [int] NULL,
	[NumeroBonus] [int] NULL,
	[NumeroCarregamento] [varchar](20) NULL,
	[NumeroTransVenda] [numeric](10, 0) NULL,
	[CodigoMotivoDevolucao] [int] NULL,
	[CodigoEmbalador] [int] NULL,
	[CodigoConferente] [int] NULL,
	[CodigoSeparador] [int] NULL,
	[DataGeracaoOS] [datetime] NULL,
	[DataInicioOS] [datetime] NULL,
	[DataFimOS] [datetime] NULL,
	[Quantidade] [numeric](18, 6) NULL,
	[PesoBruto] [numeric](18, 6) NULL,
	[Volume] [numeric](18, 6) NULL,
	[PesoLiquido] [numeric](18, 6) NULL,
	[PesoBrutoTotal]  AS ([Quantidade]*[PesoBruto]),
	[PesoLiquidoTotal]  AS ([Quantidade]*[PesoLiquido]),
	[VolumeTotal]  AS ([Volume]*[Quantidade])
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_Orcamento]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_Orcamento](
	[CodigoFilial] [varchar](4) NULL,
	[CodigoConta] [int] NULL,
	[DataReferencia] [datetime] NULL,
	[ValorOrcamento] [numeric](12, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_OrcamentoCentroCusto]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_OrcamentoCentroCusto](
	[CodigoCentroCusto] [varchar](40) NULL,
	[Valor] [numeric](18, 6) NULL,
	[CodigoFilial] [varchar](4) NULL,
	[CodigoConta] [int] NULL,
	[Data] [datetime] NULL,
	[PercentualRateio] [numeric](18, 6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_OrdemServico]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_OrdemServico](
	[NumeroOS] [int] NULL,
	[DataOS] [datetime] NULL,
	[DataInicioOS] [datetime] NULL,
	[DataFimOS] [datetime] NULL,
	[DataFimSeparacao] [datetime] NULL,
	[DataInicioConferencia] [datetime] NULL,
	[DataFimConferencia] [datetime] NULL,
	[TempoOS] [numeric](18, 6) NULL,
	[TempoSeparacao] [numeric](18, 6) NULL,
	[TempoConferencia] [numeric](18, 6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_PastaCompras]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_PastaCompras](
	[PASTA] [int] NULL,
	[codfornec] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_PedidoVendaDevolucao]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_PedidoVendaDevolucao](
	[CodigoCliente] [int] NULL,
	[CodigoRCA] [int] NULL,
	[CodigoFilial] [varchar](4) NULL,
	[NumeroPedido] [numeric](10, 0) NULL,
	[DataVenda] [datetime] NULL,
	[DataEstorno] [datetime] NULL,
	[ValorDevolucao] [numeric](18, 6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_PedidoVendaImperfeito]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_PedidoVendaImperfeito](
	[NumeroPedido] [numeric](10, 0) NULL,
	[CodigoFilial] [varchar](4) NULL,
	[CodigoRCA] [int] NULL,
	[CodigoCliente] [int] NULL,
	[DataVenda] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_Produto]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_Produto](
	[CodigoProduto] [int] NULL,
	[ValorUnitarioVenda] [numeric](18, 6) NULL,
	[TempoReposicao] [numeric](18, 6) NULL,
	[PrazoEntrega] [numeric](18, 6) NULL,
	[MargemIdeal] [numeric](18, 6) NULL,
	[DataCadastro] [datetime] NULL,
	[DiasCadastro] [int] NULL,
	[DescontoMaximo] [numeric](18, 6) NULL,
	[DescontoMaximoBalcao] [numeric](18, 6) NULL,
	[PesoBruto] [numeric](18, 6) NULL,
	[PesoLiquido] [numeric](18, 6) NULL,
	[Volume] [numeric](18, 6) NULL,
	[QuantidadeUnitaria] [numeric](18, 6) NULL,
	[QuantidadeUnitariaMaster] [numeric](18, 6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_ProdutoAvaria]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_ProdutoAvaria](
	[CodigoAvaria] [int] NULL,
	[CodigoFilial] [varchar](4) NULL,
	[CodigoFornecedor] [int] NULL,
	[CodigoFuncaoLancamento] [int] NULL,
	[CodigoMotivoAvaria] [int] NULL,
	[CodigoProduto] [int] NULL,
	[Data] [datetime] NULL,
	[Quantidade] [numeric](18, 6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_RateioCentroCusto]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_RateioCentroCusto](
	[NumeroLancamento] [int] NULL,
	[CodigoConta] [int] NULL,
	[CodigoCentroCusto] [varchar](40) NULL,
	[CodigoFilial] [varchar](4) NULL,
	[CodigoParceiro] [varchar](15) NULL,
	[NumeroBanco] [int] NULL,
	[DataLancamento] [datetime] NULL,
	[DataVencimento] [datetime] NULL,
	[DataTitulo] [datetime] NULL,
	[DataPagamento] [datetime] NULL,
	[PercentualRateio] [numeric](18, 6) NULL,
	[ValorRateio] [numeric](18, 6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_RotaCliente]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_RotaCliente](
	[CodigoCliente] [int] NULL,
	[CodigoRCA] [int] NULL,
	[DiaSemana] [varchar](15) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_SaidaInventario]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_SaidaInventario](
	[CodigoProduto] [int] NULL,
	[CodigoFilial] [varchar](4) NULL,
	[CodigoFornecedor] [int] NULL,
	[DataMovimentacao] [datetime] NULL,
	[Quantidade] [numeric](18, 6) NULL,
	[ValorUnitario] [numeric](18, 6) NULL,
	[ValorUnitarioCusto] [numeric](18, 6) NULL,
	[ValorCustoTotal] [numeric](18, 6) NULL,
	[PesoUnitarioLiquido] [numeric](18, 6) NULL,
	[PesoUnitarioBruto] [numeric](18, 6) NULL,
	[VolumeUnitario] [numeric](18, 6) NULL,
	[ValorTotal]  AS ([Quantidade]*[ValorUnitario]),
	[PesoLiquidoTotal]  AS ([Quantidade]*[PesoUnitarioLiquido]),
	[PesoBrutoTotal]  AS ([Quantidade]*[PesoUnitarioBruto]),
	[VolumeTotal]  AS ([Quantidade]*[VolumeUnitario])
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_SaldoBancario]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_SaldoBancario](
	[CodigoBanco] [int] NULL,
	[CodigoCobranca] [varchar](4) NULL,
	[CodigoFilial] [varchar](4) NULL,
	[Saldo] [numeric](18, 6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_TabelaPreco]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_TabelaPreco](
	[CodigoProduto] [int] NULL,
	[NumeroRegiao] [varchar](20) NULL,
	[PrecoTabela] [numeric](18, 6) NULL,
	[PrecoVenda] [numeric](18, 6) NULL,
	[ValorST] [numeric](18, 6) NULL,
	[Iva] [numeric](18, 6) NULL,
	[Pauta] [numeric](18, 6) NULL,
	[PrecoTabela1] [numeric](18, 6) NULL,
	[PrecoTabela2] [numeric](18, 6) NULL,
	[PrecoTabela3] [numeric](18, 6) NULL,
	[PrecoTabela4] [numeric](18, 6) NULL,
	[PrecoTabela5] [numeric](18, 6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_Treinamento]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_Treinamento](
	[CodigoTreinamento] [int] NOT NULL,
	[MatriculaColaborador] [int] NULL,
	[Data] [datetime] NULL,
	[HoraPrevista] [numeric](10, 2) NOT NULL,
	[HoraRealizada] [numeric](10, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_VariacaoPatrimonial]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_VariacaoPatrimonial](
	[Indicador] [varchar](80) NULL,
	[Saldo] [numeric](18, 6) NULL,
	[DataFinal] [datetime] NULL,
	[DataInicio] [datetime] NULL,
	[CodigoFilial] [varchar](4) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[fato_Venda324I]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[fato_Venda324I](
	[CODSUPERVISOR] [numeric](4, 0) NULL,
	[CODGERENTE] [numeric](4, 0) NULL,
	[POSICAO] [nvarchar](2) NULL,
	[DATA] [datetime] NULL,
	[CODUSUR] [numeric](4, 0) NULL,
	[CODFILIAL] [nvarchar](2) NULL,
	[CODEPTO] [numeric](6, 0) NULL,
	[CODFORNEC] [numeric](6, 0) NULL,
	[CODPROD] [numeric](6, 0) NULL,
	[CODCLI] [numeric](6, 0) NULL,
	[VLVENDA] [numeric](18, 2) NULL,
	[VLCUSTOFIN] [nvarchar](40) NULL,
	[QT] [nvarchar](40) NULL,
	[QTBNF] [nvarchar](40) NULL,
	[QTCLIENTE] [nvarchar](40) NULL,
	[PESO] [nvarchar](40) NULL,
	[QTPED] [nvarchar](40) NULL,
	[VLBONIFIC] [nvarchar](40) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_VendaAutorizada]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_VendaAutorizada](
	[CodigoFilial] [varchar](4) NULL,
	[CodigoProduto] [int] NULL,
	[CodigoCliente] [int] NULL,
	[CodigoRCA] [int] NULL,
	[CodigoPlanoPagamento] [int] NULL,
	[CodigoCobranca] [varchar](8) NULL,
	[NumeroPedido] [numeric](10, 0) NULL,
	[NumeroAutorizacao] [int] NULL,
	[DataAutorizacao] [datetime] NULL,
	[Quantidade] [numeric](18, 6) NULL,
	[ValorOriginal] [numeric](18, 6) NULL,
	[ValorVendido] [numeric](18, 6) NULL,
	[ValorCusto] [numeric](18, 6) NULL,
	[ValorDesconto]  AS ([ValorOriginal]-[ValorVendido]),
	[ValorLucroVendido]  AS ([ValorVendido]-[ValorCusto]),
	[ValorOriginalTotal]  AS ([ValorOriginal]*[Quantidade]),
	[ValorVendidoTotal]  AS ([ValorVendido]*[Quantidade]),
	[ValorDescontoTotal]  AS (([ValorOriginal]-[ValorVendido])*[Quantidade]),
	[ValorLucroVendidoTotal]  AS ([ValorVendido]*[Quantidade]-[ValorCusto]*[Quantidade]),
	[CodigoFuncionarioResponsavel] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_VendaCancelada]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_VendaCancelada](
	[CodigoProduto] [int] NULL,
	[CodigoRCA] [int] NULL,
	[CodigoCliente] [int] NULL,
	[CodigoFilial] [varchar](4) NULL,
	[CodigoCobranca] [varchar](8) NULL,
	[CodigoPlanoPagamento] [int] NULL,
	[NumeroTransacaoVenda] [numeric](10, 0) NULL,
	[NumeroPedido] [numeric](10, 0) NULL,
	[DataFaturamento] [datetime] NULL,
	[DataCancelamento] [datetime] NULL,
	[Quantidade] [numeric](18, 6) NULL,
	[ValorUnitario] [numeric](18, 6) NULL,
	[ValorTotal]  AS ([Quantidade]*[ValorUnitario]),
	[DiferencaDias] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_VendaDevolucao]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_VendaDevolucao](
	[CodigoProduto] [int] NULL,
	[CodigoRCA] [int] NULL,
	[CodigoCliente] [int] NULL,
	[CodigoFilial] [varchar](4) NULL,
	[CodigoMotivoDevolucao] [int] NULL,
	[CodigoPlanoPagamento] [int] NULL,
	[CodigoCobranca] [varchar](8) NULL,
	[NumeroTransacaoVenda] [numeric](10, 0) NULL,
	[NumeroNotaDevolucao] [numeric](10, 0) NULL,
	[NumeroPedidoVenda] [numeric](10, 0) NULL,
	[DataDevolucao] [datetime] NULL,
	[DataVenda] [datetime] NULL,
	[Quantidade] [numeric](18, 6) NULL,
	[ValorUnitario] [numeric](18, 6) NULL,
	[QuantidadeUnitariaMaster] [numeric](18, 0) NULL,
	[QuantidadeMaster]  AS ([Quantidade]/[QuantidadeUnitariaMaster]),
	[CustoUnitario] [numeric](18, 6) NULL,
	[ValorPIS] [numeric](18, 6) NULL,
	[ValorIPI] [numeric](18, 6) NULL,
	[ValorCofins] [numeric](18, 6) NULL,
	[ValorST] [numeric](18, 6) NULL,
	[ValorICMS] [numeric](18, 6) NULL,
	[ValorTotal] [numeric](18, 6) NULL,
	[CustoTotal] [numeric](18, 6) NULL,
	[ValorTotalST]  AS ([Quantidade]*[ValorST]),
	[ValorTotalCofins]  AS ([Quantidade]*[ValorCofins]),
	[ValorTotalIPI]  AS ([Quantidade]*[ValorIPI]),
	[ValorTotalPIS]  AS ([Quantidade]*[ValorPIS]),
	[ValorTotalICMS]  AS ([Quantidade]*[ValorICMS]),
	[Lucro]  AS ([Quantidade]*([ValorUnitario]-[CustoUnitario])),
	[QuantidadeBonificada] [numeric](18, 6) NULL,
	[ValorUnitarioBonificado] [numeric](18, 6) NULL,
	[ValorTotalBonificado]  AS ([QuantidadeBonificada]*[ValorUnitarioBonificado]),
	[CustoTotalBonificado]  AS ([QuantidadeBonificada]*[CustoUnitario]),
	[NumeroCarregamento] [varchar](20) NULL,
	[PesoLiquidoUnitario] [numeric](18, 6) NULL,
	[PesoBrutoUnitario] [numeric](18, 6) NULL,
	[VolumeUnitario] [numeric](18, 6) NULL,
	[PesoLiquidoTotal]  AS ([Quantidade]*[PesoLiquidoUnitario]),
	[PesoBrutoTotal] [numeric](18, 6) NULL,
	[VolumeTotal]  AS ([Quantidade]*[VolumeUnitario]),
	[ValorTotalDevolucaoAvulsa] [numeric](18, 6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_VendaFaturamento]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_VendaFaturamento](
	[NumeroPedido] [numeric](10, 0) NULL,
	[NumeroTransacaoVenda] [numeric](10, 0) NULL,
	[CodigoProduto] [int] NULL,
	[CodigoRCA] [int] NULL,
	[CodigoCliente] [int] NULL,
	[CodigoFilial] [varchar](4) NULL,
	[CodigoPlanoPagamento] [int] NULL,
	[CodigoTipoItemVenda] [varchar](1) NULL,
	[CodigoCobranca] [varchar](8) NULL,
	[NumeroCarregamento] [varchar](20) NULL,
	[DataFaturamento] [datetime] NULL,
	[Quantidade] [numeric](18, 6) NULL,
	[QuantidadeCaixa] [numeric](18, 6) NULL,
	[QuantidadeMaster]  AS ([Quantidade]/[QuantidadeCaixa]),
	[ValorST] [numeric](18, 6) NULL,
	[ValorPIS] [numeric](18, 6) NULL,
	[ValorCOFINS] [numeric](18, 6) NULL,
	[ValorIPI] [numeric](18, 6) NULL,
	[ValorICMS] [numeric](18, 6) NULL,
	[ValorSTTotal]  AS ([Quantidade]*[ValorST]),
	[ValorPISTotal]  AS ([Quantidade]*[ValorPIS]),
	[ValorCOFINSTotal]  AS ([Quantidade]*[ValorCOFINS]),
	[ValorIPITotal]  AS ([Quantidade]*[ValorIPI]),
	[ValorICMSTotal]  AS ([Quantidade]*[ValorICMS]),
	[ImpostoUnitario]  AS (((([ValorST]+[ValorPIS])+[ValorCOFINS])+[ValorIPI])+[ValorICMS]),
	[ImpostoTotal]  AS ((((([ValorST]+[ValorPIS])+[ValorCOFINS])+[ValorIPI])+[ValorICMS])*[Quantidade]),
	[ValorFrete] [numeric](18, 6) NULL,
	[ValorOutrasDespesas] [numeric](18, 6) NULL,
	[ValorUnitario] [numeric](18, 6) NULL,
	[ValorUnitarioTabela] [numeric](18, 6) NULL,
	[ValorUnitarioCusto] [numeric](18, 6) NULL,
	[PesoUnitarioBruto] [numeric](18, 6) NULL,
	[PesoUnitarioLiquido] [numeric](18, 6) NULL,
	[VolumeUnitario] [numeric](18, 6) NULL,
	[ValorTotal] [numeric](18, 6) NULL,
	[ValorTotalTabela]  AS ([ValorUnitarioTabela]*[Quantidade]),
	[ValorTotalCusto] [numeric](18, 6) NULL,
	[PesoBrutoTotal] [numeric](18, 6) NULL,
	[PesoLiquidoTotal]  AS ([PesoUnitarioLiquido]*[Quantidade]),
	[VolumeTotal]  AS ([VolumeUnitario]*[Quantidade]),
	[LucroTotal]  AS (([ValorUnitario]-[ValorUnitarioCusto])*[Quantidade]),
	[ValorTotalBonificado]  AS ([ValorUnitarioBonificado]*[QuantidadeBonificada]),
	[ValorUnitarioBonificado] [numeric](18, 6) NULL,
	[QuantidadeBonificada] [numeric](18, 6) NULL,
	[ValorTotalDesconto]  AS ([Quantidade]*([ValorUnitarioTabela]-[ValorUnitario])),
	[PercentualComissao] [numeric](18, 6) NULL,
	[Comissao]  AS (([Quantidade]*[ValorUnitario])*[PercentualComissao]),
	[ValorVerbaUnitario] [numeric](18, 6) NULL,
	[ValorVerbaTotal]  AS ([Quantidade]*[ValorVerbaUnitario]),
	[CodigoAuxiliar] [varchar](80) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_Verba]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_Verba](
	[NumeroTransacao] [int] NULL,
	[NumeroVerba] [int] NULL,
	[CodigoFornecedor] [int] NULL,
	[CodigoFilial] [varchar](4) NULL,
	[DataMovimentacao] [datetime] NULL,
	[DataVencimento] [datetime] NULL,
	[ValorDebito] [numeric](18, 6) NULL,
	[ValorCredito] [numeric](18, 6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fato_Visita]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fato_Visita](
	[CodigoVisita] [int] NULL,
	[CodigoCliente] [int] NULL,
	[CodigoRCA] [int] NULL,
	[Data] [datetime] NULL,
	[NumeroPedido] [numeric](10, 0) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LineBy_227_Analytcs_]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LineBy_227_Analytcs_](
	[CODFORNEC] [int] NULL,
	[CODPROD] [int] NULL,
	[GIRODIA_103] [numeric](16, 3) NULL,
	[QTVENDMES3] [numeric](16, 3) NULL,
	[QTVENDMES2] [numeric](16, 3) NULL,
	[QTVENDMES1] [numeric](16, 3) NULL,
	[QTVENDMES] [numeric](16, 3) NULL,
	[QTVENDATOTAL4] [numeric](16, 3) NULL,
	[ARUP4] [int] NULL,
	[ARUP3] [int] NULL,
	[ARUP2] [int] NULL,
	[QTESTGER] [numeric](16, 3) NULL,
	[QTRESERV] [numeric](16, 3) NULL,
	[QTPENDENTE] [numeric](16, 3) NULL,
	[QTBLOQUEADA] [numeric](16, 3) NULL,
	[QTDISPONIVEL] [numeric](16, 3) NULL,
	[ESTDIAS] [numeric](16, 3) NULL,
	[DTULTSAIDA] [datetime] NULL,
	[DIASSEMVENDA] [int] NULL,
	[DTULTENT] [date] NULL,
	[DIASSEMCOMPRA] [numeric](16, 3) NULL,
	[DTBLOQUEIO] [date] NULL,
	[DIASBLOQUEADO] [int] NULL,
	[QTULTENT] [numeric](16, 3) NULL,
	[QTPEDIDA] [numeric](16, 3) NULL,
	[PERCST] [numeric](16, 3) NULL,
	[VLVENDAMES] [numeric](16, 3) NULL,
	[PARTICIPITEM] [numeric](16, 3) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Metas_AiltonP]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Metas_AiltonP](
	[COD] [int] NULL,
	[META] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rel_A_R_Pinheiro_3809_C]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rel_A_R_Pinheiro_3809_C](
	[CODGERENTE] [int] NULL,
	[CODSUPERVISOR] [int] NULL,
	[CODUSUR] [int] NULL,
	[CODFORNEC] [int] NULL,
	[CODCLI] [int] NULL,
	[VLVENDA] [float] NULL,
	[50++] [float] NULL,
	[QT] [int] NULL,
	[QTCLIENTE] [int] NULL,
	[QTPED] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rel_Camp_Ciacarne]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rel_Camp_Ciacarne](
	[CODCLI] [int] NULL,
	[CODFILIAL] [int] NULL,
	[CODFORNEC] [int] NULL,
	[CODGERENTE] [int] NULL,
	[CODSUPERVISOR] [int] NULL,
	[CODUSUR] [int] NULL,
	[Post_c] [int] NULL,
	[VLVENDA] [float] NULL,
	[QT] [float] NULL,
	[QTPED] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rel_Fato_Castrol]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rel_Fato_Castrol](
	[Origin] [nvarchar](255) NULL,
	[Mes] [nvarchar](255) NULL,
	[Código Produto] [nvarchar](255) NULL,
	[Produto] [nvarchar](255) NULL,
	[Marca] [nvarchar](255) NULL,
	[Faturamento - Valor] [float] NULL,
	[Faturamento - Peso Líquido] [float] NULL,
	[Faturamento - Positivação] [float] NULL,
	[Mês_in] [nvarchar](255) NULL,
	[Marca_in] [nvarchar](255) NULL,
	[Ano] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rel_Marcas_Castrol]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rel_Marcas_Castrol](
	[Marca] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rel_Metas_Castrol]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rel_Metas_Castrol](
	[Mês_in] [nvarchar](255) NULL,
	[Marca] [nvarchar](255) NULL,
	[Meta] [float] NULL,
	[Mes] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rel_metas_hadassa]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rel_metas_hadassa](
	[CODFORNEC] [int] NULL,
	[MetaVenda] [numeric](12, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rel_metas_J_de_R]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rel_metas_J_de_R](
	[CODFORNEC] [int] NULL,
	[MetaVenda] [numeric](12, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rel_metas_saturn]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rel_metas_saturn](
	[CODFORNEC] [int] NULL,
	[MetaVenda] [numeric](12, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rel_NatOne]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rel_NatOne](
	[CODGERENTE] [int] NULL,
	[CODSUPERVISOR] [int] NULL,
	[CODUSUR] [int] NULL,
	[CODFORNEC] [int] NULL,
	[CODCLI] [int] NULL,
	[VLVENDA] [float] NULL,
	[50++] [float] NULL,
	[QT] [int] NULL,
	[QTCLIENTE] [int] NULL,
	[QTPED] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rel_Periodo_Castrol]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rel_Periodo_Castrol](
	[Mes] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Venda_324_PWBI]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Venda_324_PWBI](
	[CODSUPERVISOR] [int] NULL,
	[CODGERENTE] [int] NULL,
	[POSICAO] [nvarchar](2) NULL,
	[DATA] [date] NULL,
	[CODUSUR] [int] NULL,
	[CODFILIAL] [nvarchar](2) NULL,
	[CODEPTO] [numeric](6, 0) NULL,
	[CODFORNEC] [int] NULL,
	[CODPROD] [int] NULL,
	[CODCLI] [int] NULL,
	[VLVENDA] [numeric](18, 2) NULL,
	[VLCUSTOFIN] [numeric](18, 2) NULL,
	[QT] [int] NULL,
	[QTBNF] [numeric](18, 2) NULL,
	[QTCLIENTE] [int] NULL,
	[PESO] [numeric](18, 2) NULL,
	[QTPED] [int] NULL,
	[VLBONIFIC] [numeric](18, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VendaTotal]    Script Date: 18/01/2024 09:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VendaTotal](
	[CODSUPERVISOR] [numeric](4, 0) NULL,
	[CODGERENTE] [numeric](4, 0) NULL,
	[POSICAO] [nvarchar](2) NULL,
	[DATA] [datetime] NULL,
	[CODUSUR] [numeric](4, 0) NULL,
	[CODFILIAL] [nvarchar](2) NULL,
	[CODEPTO] [numeric](6, 0) NULL,
	[CODFORNEC] [numeric](6, 0) NULL,
	[CODPROD] [numeric](6, 0) NULL,
	[CODCLI] [numeric](6, 0) NULL,
	[VLVENDA] [nvarchar](40) NULL,
	[VLCUSTOFIN] [nvarchar](40) NULL,
	[QT] [nvarchar](40) NULL,
	[QTBNF] [nvarchar](40) NULL,
	[QTCLIENTE] [nvarchar](40) NULL,
	[PESO] [nvarchar](40) NULL,
	[QTPED] [nvarchar](40) NULL,
	[VLBONIFIC] [nvarchar](40) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Dim_NotaSaida] ADD  CONSTRAINT [DF_Dim_NotaSaida_QuantidadeItens]  DEFAULT ((0)) FOR [QuantidadeItens]
GO
ALTER TABLE [dbo].[Fato_Cliente] ADD  CONSTRAINT [DF_Fato_Cliente_LimiteCredito]  DEFAULT ((0)) FOR [LimiteCredito]
GO
ALTER TABLE [dbo].[Fato_Cliente] ADD  CONSTRAINT [DF_Fato_Cliente_ValorPedidoFaturar]  DEFAULT ((0)) FOR [ValorPedidoFaturar]
GO
ALTER TABLE [dbo].[Fato_Cliente] ADD  CONSTRAINT [DF_Fato_Cliente_ValorReceber]  DEFAULT ((0)) FOR [ValorReceber]
GO
ALTER TABLE [dbo].[Fato_Compra] ADD  CONSTRAINT [DF_Fato_Compra_Quantidade]  DEFAULT ((0)) FOR [Quantidade]
GO
ALTER TABLE [dbo].[Fato_Compra] ADD  CONSTRAINT [DF_Fato_Compra_ValorUnitario]  DEFAULT ((0)) FOR [ValorUnitario]
GO
ALTER TABLE [dbo].[Fato_Compra] ADD  CONSTRAINT [DF_Fato_Compra_ValorUnitarioTabela]  DEFAULT ((0)) FOR [ValorUnitarioTabela]
GO
ALTER TABLE [dbo].[Fato_Compra] ADD  CONSTRAINT [DF_Fato_Compra_ValorUnitarioCusto]  DEFAULT ((0)) FOR [ValorUnitarioCusto]
GO
ALTER TABLE [dbo].[Fato_Compra] ADD  CONSTRAINT [DF_Fato_Compra_ValorUnitarioDesconto]  DEFAULT ((0)) FOR [ValorUnitarioDesconto]
GO
ALTER TABLE [dbo].[Fato_Compra] ADD  CONSTRAINT [DF_Fato_Compra_PesoUnitarioBruto]  DEFAULT ((0)) FOR [PesoUnitarioBruto]
GO
ALTER TABLE [dbo].[Fato_Compra] ADD  CONSTRAINT [DF_Fato_Compra_PesoUnitarioLiquido]  DEFAULT ((0)) FOR [PesoUnitarioLiquido]
GO
ALTER TABLE [dbo].[Fato_Compra] ADD  CONSTRAINT [DF_Fato_Compra_VolumeUnitario]  DEFAULT ((0)) FOR [VolumeUnitario]
GO
ALTER TABLE [dbo].[Fato_ContasPagar] ADD  CONSTRAINT [DF_Fato_ContasPagar_ValorPagamento]  DEFAULT ((0)) FOR [ValorPagamento]
GO
ALTER TABLE [dbo].[Fato_ContasPagar] ADD  CONSTRAINT [DF_Fato_ContasPagar_ValorDevolucao]  DEFAULT ((0)) FOR [ValorDevolucao]
GO
ALTER TABLE [dbo].[Fato_ContasPagar] ADD  CONSTRAINT [DF_Fato_ContasPagar_ValorDesconto]  DEFAULT ((0)) FOR [ValorDesconto]
GO
ALTER TABLE [dbo].[Fato_ContasPagar] ADD  CONSTRAINT [DF_Fato_ContasPagar_ValorJuros]  DEFAULT ((0)) FOR [ValorJuros]
GO
ALTER TABLE [dbo].[Fato_ContasReceber] ADD  CONSTRAINT [DF_Fato_ContasReceber_Prazo]  DEFAULT ((0)) FOR [Prazo]
GO
ALTER TABLE [dbo].[Fato_ContasReceber] ADD  CONSTRAINT [DF_Fato_ContasReceber_Atraso]  DEFAULT ((0)) FOR [DiasAtraso]
GO
ALTER TABLE [dbo].[Fato_ContasReceber] ADD  CONSTRAINT [DF_Fato_ContasReceber_Inadimplente]  DEFAULT ((0)) FOR [Inadimplente]
GO
ALTER TABLE [dbo].[Fato_ContasReceber] ADD  CONSTRAINT [DF_Fato_ContasReceber_Atrasado]  DEFAULT ((0)) FOR [Atrasado]
GO
ALTER TABLE [dbo].[Fato_Data] ADD  CONSTRAINT [DF_Fato_Data_DiasTranscorridos]  DEFAULT ((0)) FOR [DiasTranscorridos]
GO
ALTER TABLE [dbo].[Fato_EstoqueWMS] ADD  CONSTRAINT [DF_Fato_EstoqueWMS_Quantidade]  DEFAULT ((0)) FOR [Quantidade]
GO
ALTER TABLE [dbo].[Fato_EstoqueWMS] ADD  CONSTRAINT [DF_Fato_EstoqueWMS_QuantidadeBloqueada]  DEFAULT ((0)) FOR [QuantidadeBloqueada]
GO
ALTER TABLE [dbo].[Fato_EstoqueWMS] ADD  CONSTRAINT [DF_Fato_EstoqueWMS_QuantidadeReservada]  DEFAULT ((0)) FOR [QuantidadeReservada]
GO
ALTER TABLE [dbo].[Fato_EstoqueWMS] ADD  CONSTRAINT [DF_Fato_EstoqueWMS_QuantidadePendenteSaida]  DEFAULT ((0)) FOR [QuantidadePendenteSaida]
GO
ALTER TABLE [dbo].[Fato_EstoqueWMS] ADD  CONSTRAINT [DF_Fato_EstoqueWMS_QuantidadePendeteEntrada]  DEFAULT ((0)) FOR [QuantidadePendenteEntrada]
GO
ALTER TABLE [dbo].[Fato_EstoqueWMS] ADD  CONSTRAINT [DF_Fato_EstoqueWMS_VolumeUnitario]  DEFAULT ((0)) FOR [VolumeUnitario]
GO
ALTER TABLE [dbo].[Fato_Inventario] ADD  CONSTRAINT [DF_Fato_Inventario_QuantidadeAnterior]  DEFAULT ((0)) FOR [QuantidadeAnterior]
GO
ALTER TABLE [dbo].[Fato_Inventario] ADD  CONSTRAINT [DF_Fato_Inventario_QuantidadeInventario]  DEFAULT ((0)) FOR [QuantidadeInventario]
GO
ALTER TABLE [dbo].[Fato_MetaCategoria] ADD  CONSTRAINT [DF_Fato_MetaCategoria5_VALORMETA]  DEFAULT ((0)) FOR [Valor]
GO
ALTER TABLE [dbo].[Fato_MetaCategoria] ADD  CONSTRAINT [DF_Fato_MetaCategoria5_QUANTIDADEMETA]  DEFAULT ((0)) FOR [QuantidadeVenda]
GO
ALTER TABLE [dbo].[Fato_MetaCategoria] ADD  CONSTRAINT [DF_Fato_MetaCategoria5_QUANTIDADEPEDIDOSMETA]  DEFAULT ((0)) FOR [QuantidadePedidos]
GO
ALTER TABLE [dbo].[Fato_MetaCategoria] ADD  CONSTRAINT [DF_Fato_MetaCategoria5_MIXMETA]  DEFAULT ((0)) FOR [Mix]
GO
ALTER TABLE [dbo].[Fato_MetaCategoria] ADD  CONSTRAINT [DF_Fato_MetaCategoria5_MIXMEDIOMETA]  DEFAULT ((0)) FOR [MixMedio]
GO
ALTER TABLE [dbo].[Fato_MetaCategoria] ADD  CONSTRAINT [DF_Fato_MetaCategoria5_POSITIVACAOMETA]  DEFAULT ((0)) FOR [Positivacao]
GO
ALTER TABLE [dbo].[Fato_MetaCategoria] ADD  CONSTRAINT [DF_Fato_MetaCategoria5_CLIENTECADASTRADOMETA]  DEFAULT ((0)) FOR [ClienteCadastrado]
GO
ALTER TABLE [dbo].[Fato_MetaCategoria] ADD  CONSTRAINT [DF_Fato_MetaCategoria5_QUANTIDADECLIENTESATIVOMETA]  DEFAULT ((0)) FOR [QuantidadeClienteAtivo]
GO
ALTER TABLE [dbo].[Fato_MetaCategoria] ADD  CONSTRAINT [DF_Fato_MetaCategoria5_MARGEMMETA]  DEFAULT ((0)) FOR [Margem]
GO
ALTER TABLE [dbo].[Fato_MetaCategoria] ADD  CONSTRAINT [DF_Fato_MetaCategoria5_PESOMETA]  DEFAULT ((0)) FOR [Peso]
GO
ALTER TABLE [dbo].[Fato_MetaCategoria] ADD  CONSTRAINT [DF_Fato_MetaCategoria5_VOLUMEMETA]  DEFAULT ((0)) FOR [Volume]
GO
ALTER TABLE [dbo].[Fato_MetaCategoria] ADD  CONSTRAINT [DF_Fato_MetaCategoria5_DESCONTOVALORVENDAMETA]  DEFAULT ((0)) FOR [DescontoValorVenda]
GO
ALTER TABLE [dbo].[Fato_MetaCategoria] ADD  CONSTRAINT [DF_Fato_MetaCategoria5_EFETIVIDADEPREVISTA]  DEFAULT ((0)) FOR [Efetividade]
GO
ALTER TABLE [dbo].[Fato_MetaCategoria] ADD  CONSTRAINT [DF_Fato_MetaCategoria5_EFETIVIDADEDIARIAMETA]  DEFAULT ((0)) FOR [EfetividadeDiaria]
GO
ALTER TABLE [dbo].[Fato_MetaCategoria] ADD  CONSTRAINT [DF_Fato_MetaCategoria5_MEDIAITENSMETA]  DEFAULT ((0)) FOR [MediaItens]
GO
ALTER TABLE [dbo].[Fato_MetaCategoria] ADD  CONSTRAINT [DF_Fato_MetaCategoria5_MEDIAITENSCLIENTEMETA]  DEFAULT ((0)) FOR [MediaItensCliente]
GO
ALTER TABLE [dbo].[Fato_MetaCategoria] ADD  CONSTRAINT [DF_Fato_MetaCategoria5_PERCENTUALVALORDEVOLUCAOMETA]  DEFAULT ((0)) FOR [PercentualValorDevolucao]
GO
ALTER TABLE [dbo].[Fato_MetaCategoria] ADD  CONSTRAINT [DF_Fato_MetaCategoria5_PERCENTUALITENSDEVOLUCAOMETA]  DEFAULT ((0)) FOR [PercentualItensDevolucao]
GO
ALTER TABLE [dbo].[Fato_MetaCategoria] ADD  CONSTRAINT [DF_Fato_MetaCategoria5_PERCENTUALINADIMPLENCIAMETA]  DEFAULT ((0)) FOR [PercentualInadimplencia]
GO
ALTER TABLE [dbo].[Fato_MetaCategoria] ADD  CONSTRAINT [DF_Fato_MetaCategoria5_PRAZOMEDIOMETA]  DEFAULT ((0)) FOR [PrazoMedio]
GO
ALTER TABLE [dbo].[Fato_MetaCategoria] ADD  CONSTRAINT [DF_Fato_MetaCategoria5_VALORMEDIOITEMMETA]  DEFAULT ((0)) FOR [ValorMedioItem]
GO
ALTER TABLE [dbo].[Fato_MetaCategoria] ADD  CONSTRAINT [DF_Fato_MetaCategoria5_VALORMEDIOPEDIDOMETA]  DEFAULT ((0)) FOR [ValorMedioPedido]
GO
ALTER TABLE [dbo].[Fato_MetaCategoria] ADD  CONSTRAINT [DF_Fato_MetaCategoria5_VALORMEDIOPEDIDODIAMETA]  DEFAULT ((0)) FOR [ValorMedioPedidoDia]
GO
ALTER TABLE [dbo].[Fato_MetaCategoria] ADD  CONSTRAINT [DF_Fato_MetaCategoria5_PRECOMEDIOMETA]  DEFAULT ((0)) FOR [PrecoMedio]
GO
ALTER TABLE [dbo].[Fato_MetaCategoria] ADD  CONSTRAINT [DF_Fato_MetaCategoria5_PRECOMEDIOPESOMETA]  DEFAULT ((0)) FOR [PrecoMedioPeso]
GO
ALTER TABLE [dbo].[Fato_MetaCliente] ADD  CONSTRAINT [DF_Fato_MetaCliente5_VALORMETA]  DEFAULT ((0)) FOR [Valor]
GO
ALTER TABLE [dbo].[Fato_MetaCliente] ADD  CONSTRAINT [DF_Fato_MetaCliente5_QUANTIDADEMETA]  DEFAULT ((0)) FOR [QuantidadeVenda]
GO
ALTER TABLE [dbo].[Fato_MetaCliente] ADD  CONSTRAINT [DF_Fato_MetaCliente5_QUANTIDADEPEDIDOSMETA]  DEFAULT ((0)) FOR [QuantidadePedidos]
GO
ALTER TABLE [dbo].[Fato_MetaCliente] ADD  CONSTRAINT [DF_Fato_MetaCliente5_MIXMETA]  DEFAULT ((0)) FOR [Mix]
GO
ALTER TABLE [dbo].[Fato_MetaCliente] ADD  CONSTRAINT [DF_Fato_MetaCliente5_MIXMEDIOMETA]  DEFAULT ((0)) FOR [MixMedio]
GO
ALTER TABLE [dbo].[Fato_MetaCliente] ADD  CONSTRAINT [DF_Fato_MetaCliente5_POSITIVACAOMETA]  DEFAULT ((0)) FOR [Positivacao]
GO
ALTER TABLE [dbo].[Fato_MetaCliente] ADD  CONSTRAINT [DF_Fato_MetaCliente5_CLIENTECADASTRADOMETA]  DEFAULT ((0)) FOR [ClienteCadastrado]
GO
ALTER TABLE [dbo].[Fato_MetaCliente] ADD  CONSTRAINT [DF_Fato_MetaCliente5_QUANTIDADECLIENTESATIVOMETA]  DEFAULT ((0)) FOR [QuantidadeClienteAtivo]
GO
ALTER TABLE [dbo].[Fato_MetaCliente] ADD  CONSTRAINT [DF_Fato_MetaCliente5_MARGEMMETA]  DEFAULT ((0)) FOR [Margem]
GO
ALTER TABLE [dbo].[Fato_MetaCliente] ADD  CONSTRAINT [DF_Fato_MetaCliente5_PESOMETA]  DEFAULT ((0)) FOR [Peso]
GO
ALTER TABLE [dbo].[Fato_MetaCliente] ADD  CONSTRAINT [DF_Fato_MetaCliente5_VOLUMEMETA]  DEFAULT ((0)) FOR [Volume]
GO
ALTER TABLE [dbo].[Fato_MetaCliente] ADD  CONSTRAINT [DF_Fato_MetaCliente5_DESCONTOVALORVENDAMETA]  DEFAULT ((0)) FOR [DescontoValorVenda]
GO
ALTER TABLE [dbo].[Fato_MetaCliente] ADD  CONSTRAINT [DF_Fato_MetaCliente5_EFETIVIDADEPREVISTA]  DEFAULT ((0)) FOR [Efetividade]
GO
ALTER TABLE [dbo].[Fato_MetaCliente] ADD  CONSTRAINT [DF_Fato_MetaCliente5_EFETIVIDADEDIARIAMETA]  DEFAULT ((0)) FOR [EfetividadeDiaria]
GO
ALTER TABLE [dbo].[Fato_MetaCliente] ADD  CONSTRAINT [DF_Fato_MetaCliente5_MEDIAITENSMETA]  DEFAULT ((0)) FOR [MediaItens]
GO
ALTER TABLE [dbo].[Fato_MetaCliente] ADD  CONSTRAINT [DF_Fato_MetaCliente5_MEDIAITENSCLIENTEMETA]  DEFAULT ((0)) FOR [MediaItensCliente]
GO
ALTER TABLE [dbo].[Fato_MetaCliente] ADD  CONSTRAINT [DF_Fato_MetaCliente5_PERCENTUALVALORDEVOLUCAOMETA]  DEFAULT ((0)) FOR [PercentualValorDevolucao]
GO
ALTER TABLE [dbo].[Fato_MetaCliente] ADD  CONSTRAINT [DF_Fato_MetaCliente5_PERCENTUALITENSDEVOLUCAOMETA]  DEFAULT ((0)) FOR [PercentualItensDevolucao]
GO
ALTER TABLE [dbo].[Fato_MetaCliente] ADD  CONSTRAINT [DF_Fato_MetaCliente5_PERCENTUALINADIMPLENCIAMETA]  DEFAULT ((0)) FOR [PercentualInadimplencia]
GO
ALTER TABLE [dbo].[Fato_MetaCliente] ADD  CONSTRAINT [DF_Fato_MetaCliente5_PRAZOMEDIOMETA]  DEFAULT ((0)) FOR [PrazoMedio]
GO
ALTER TABLE [dbo].[Fato_MetaCliente] ADD  CONSTRAINT [DF_Fato_MetaCliente5_VALORMEDIOITEMMETA]  DEFAULT ((0)) FOR [ValorMedioItem]
GO
ALTER TABLE [dbo].[Fato_MetaCliente] ADD  CONSTRAINT [DF_Fato_MetaCliente5_VALORMEDIOPEDIDOMETA]  DEFAULT ((0)) FOR [ValorMedioPedido]
GO
ALTER TABLE [dbo].[Fato_MetaCliente] ADD  CONSTRAINT [DF_Fato_MetaCliente5_VALORMEDIOPEDIDODIAMETA]  DEFAULT ((0)) FOR [ValorMedioPedidoDia]
GO
ALTER TABLE [dbo].[Fato_MetaCliente] ADD  CONSTRAINT [DF_Fato_MetaCliente5_PRECOMEDIOMETA]  DEFAULT ((0)) FOR [PrecoMedio]
GO
ALTER TABLE [dbo].[Fato_MetaCliente] ADD  CONSTRAINT [DF_Fato_MetaCliente5_PRECOMEDIOPESOMETA]  DEFAULT ((0)) FOR [PrecoMedioPeso]
GO
ALTER TABLE [dbo].[Fato_MetaDepartamento] ADD  CONSTRAINT [DF_Fato_MetaDepartamento5_VALORMETA]  DEFAULT ((0)) FOR [Valor]
GO
ALTER TABLE [dbo].[Fato_MetaDepartamento] ADD  CONSTRAINT [DF_Fato_MetaDepartamento5_QUANTIDADEMETA]  DEFAULT ((0)) FOR [QuantidadeVenda]
GO
ALTER TABLE [dbo].[Fato_MetaDepartamento] ADD  CONSTRAINT [DF_Fato_MetaDepartamento5_QUANTIDADEPEDIDOSMETA]  DEFAULT ((0)) FOR [QuantidadePedidos]
GO
ALTER TABLE [dbo].[Fato_MetaDepartamento] ADD  CONSTRAINT [DF_Fato_MetaDepartamento5_MIXMETA]  DEFAULT ((0)) FOR [Mix]
GO
ALTER TABLE [dbo].[Fato_MetaDepartamento] ADD  CONSTRAINT [DF_Fato_MetaDepartamento5_MIXMEDIOMETA]  DEFAULT ((0)) FOR [MixMedio]
GO
ALTER TABLE [dbo].[Fato_MetaDepartamento] ADD  CONSTRAINT [DF_Fato_MetaDepartamento5_POSITIVACAOMETA]  DEFAULT ((0)) FOR [Positivacao]
GO
ALTER TABLE [dbo].[Fato_MetaDepartamento] ADD  CONSTRAINT [DF_Fato_MetaDepartamento5_CLIENTECADASTRADOMETA]  DEFAULT ((0)) FOR [ClienteCadastrado]
GO
ALTER TABLE [dbo].[Fato_MetaDepartamento] ADD  CONSTRAINT [DF_Fato_MetaDepartamento5_QUANTIDADECLIENTESATIVOMETA]  DEFAULT ((0)) FOR [QuantidadeClienteAtivo]
GO
ALTER TABLE [dbo].[Fato_MetaDepartamento] ADD  CONSTRAINT [DF_Fato_MetaDepartamento5_MARGEMMETA]  DEFAULT ((0)) FOR [Margem]
GO
ALTER TABLE [dbo].[Fato_MetaDepartamento] ADD  CONSTRAINT [DF_Fato_MetaDepartamento5_PESOMETA]  DEFAULT ((0)) FOR [Peso]
GO
ALTER TABLE [dbo].[Fato_MetaDepartamento] ADD  CONSTRAINT [DF_Fato_MetaDepartamento5_VOLUMEMETA]  DEFAULT ((0)) FOR [Volume]
GO
ALTER TABLE [dbo].[Fato_MetaDepartamento] ADD  CONSTRAINT [DF_Fato_MetaDepartamento5_DESCONTOVALORVENDAMETA]  DEFAULT ((0)) FOR [DescontoValorVenda]
GO
ALTER TABLE [dbo].[Fato_MetaDepartamento] ADD  CONSTRAINT [DF_Fato_MetaDepartamento5_EFETIVIDADEPREVISTA]  DEFAULT ((0)) FOR [Efetividade]
GO
ALTER TABLE [dbo].[Fato_MetaDepartamento] ADD  CONSTRAINT [DF_Fato_MetaDepartamento5_EFETIVIDADEDIARIAMETA]  DEFAULT ((0)) FOR [EfetividadeDiaria]
GO
ALTER TABLE [dbo].[Fato_MetaDepartamento] ADD  CONSTRAINT [DF_Fato_MetaDepartamento5_MEDIAITENSMETA]  DEFAULT ((0)) FOR [MediaItens]
GO
ALTER TABLE [dbo].[Fato_MetaDepartamento] ADD  CONSTRAINT [DF_Fato_MetaDepartamento5_MEDIAITENSCLIENTEMETA]  DEFAULT ((0)) FOR [MediaItensCliente]
GO
ALTER TABLE [dbo].[Fato_MetaDepartamento] ADD  CONSTRAINT [DF_Fato_MetaDepartamento5_PERCENTUALVALORDEVOLUCAOMETA]  DEFAULT ((0)) FOR [PercentualValorDevolucao]
GO
ALTER TABLE [dbo].[Fato_MetaDepartamento] ADD  CONSTRAINT [DF_Fato_MetaDepartamento5_PERCENTUALITENSDEVOLUCAOMETA]  DEFAULT ((0)) FOR [PercentualItensDevolucao]
GO
ALTER TABLE [dbo].[Fato_MetaDepartamento] ADD  CONSTRAINT [DF_Fato_MetaDepartamento5_PERCENTUALINADIMPLENCIAMETA]  DEFAULT ((0)) FOR [PercentualInadimplencia]
GO
ALTER TABLE [dbo].[Fato_MetaDepartamento] ADD  CONSTRAINT [DF_Fato_MetaDepartamento5_PRAZOMEDIOMETA]  DEFAULT ((0)) FOR [PrazoMedio]
GO
ALTER TABLE [dbo].[Fato_MetaDepartamento] ADD  CONSTRAINT [DF_Fato_MetaDepartamento5_VALORMEDIOITEMMETA]  DEFAULT ((0)) FOR [ValorMedioItem]
GO
ALTER TABLE [dbo].[Fato_MetaDepartamento] ADD  CONSTRAINT [DF_Fato_MetaDepartamento5_VALORMEDIOPEDIDOMETA]  DEFAULT ((0)) FOR [ValorMedioPedido]
GO
ALTER TABLE [dbo].[Fato_MetaDepartamento] ADD  CONSTRAINT [DF_Fato_MetaDepartamento5_VALORMEDIOPEDIDODIAMETA]  DEFAULT ((0)) FOR [ValorMedioPedidoDia]
GO
ALTER TABLE [dbo].[Fato_MetaDepartamento] ADD  CONSTRAINT [DF_Fato_MetaDepartamento5_PRECOMEDIOMETA]  DEFAULT ((0)) FOR [PrecoMedio]
GO
ALTER TABLE [dbo].[Fato_MetaDepartamento] ADD  CONSTRAINT [DF_Fato_MetaDepartamento5_PRECOMEDIOPESOMETA]  DEFAULT ((0)) FOR [PrecoMedioPeso]
GO
ALTER TABLE [dbo].[Fato_MetaFornecedor] ADD  CONSTRAINT [DF_Fato_MetaFornecedor5_VALORMETA]  DEFAULT ((0)) FOR [Valor]
GO
ALTER TABLE [dbo].[Fato_MetaFornecedor] ADD  CONSTRAINT [DF_Fato_MetaFornecedor5_QUANTIDADEMETA]  DEFAULT ((0)) FOR [QuantidadeVenda]
GO
ALTER TABLE [dbo].[Fato_MetaFornecedor] ADD  CONSTRAINT [DF_Fato_MetaFornecedor5_QUANTIDADEPEDIDOSMETA]  DEFAULT ((0)) FOR [QuantidadePedidos]
GO
ALTER TABLE [dbo].[Fato_MetaFornecedor] ADD  CONSTRAINT [DF_Fato_MetaFornecedor5_MIXMETA]  DEFAULT ((0)) FOR [Mix]
GO
ALTER TABLE [dbo].[Fato_MetaFornecedor] ADD  CONSTRAINT [DF_Fato_MetaFornecedor5_MIXMEDIOMETA]  DEFAULT ((0)) FOR [MixMedio]
GO
ALTER TABLE [dbo].[Fato_MetaFornecedor] ADD  CONSTRAINT [DF_Fato_MetaFornecedor5_POSITIVACAOMETA]  DEFAULT ((0)) FOR [Positivacao]
GO
ALTER TABLE [dbo].[Fato_MetaFornecedor] ADD  CONSTRAINT [DF_Fato_MetaFornecedor5_CLIENTECADASTRADOMETA]  DEFAULT ((0)) FOR [ClienteCadastrado]
GO
ALTER TABLE [dbo].[Fato_MetaFornecedor] ADD  CONSTRAINT [DF_Fato_MetaFornecedor5_QUANTIDADECLIENTESATIVOMETA]  DEFAULT ((0)) FOR [QuantidadeClienteAtivo]
GO
ALTER TABLE [dbo].[Fato_MetaFornecedor] ADD  CONSTRAINT [DF_Fato_MetaFornecedor5_MARGEMMETA]  DEFAULT ((0)) FOR [Margem]
GO
ALTER TABLE [dbo].[Fato_MetaFornecedor] ADD  CONSTRAINT [DF_Fato_MetaFornecedor5_PESOMETA]  DEFAULT ((0)) FOR [Peso]
GO
ALTER TABLE [dbo].[Fato_MetaFornecedor] ADD  CONSTRAINT [DF_Fato_MetaFornecedor5_VOLUMEMETA]  DEFAULT ((0)) FOR [Volume]
GO
ALTER TABLE [dbo].[Fato_MetaFornecedor] ADD  CONSTRAINT [DF_Fato_MetaFornecedor5_DESCONTOVALORVENDAMETA]  DEFAULT ((0)) FOR [DescontoValorVenda]
GO
ALTER TABLE [dbo].[Fato_MetaFornecedor] ADD  CONSTRAINT [DF_Fato_MetaFornecedor5_EFETIVIDADEPREVISTA]  DEFAULT ((0)) FOR [Efetividade]
GO
ALTER TABLE [dbo].[Fato_MetaFornecedor] ADD  CONSTRAINT [DF_Fato_MetaFornecedor5_EFETIVIDADEDIARIAMETA]  DEFAULT ((0)) FOR [EfetividadeDiaria]
GO
ALTER TABLE [dbo].[Fato_MetaFornecedor] ADD  CONSTRAINT [DF_Fato_MetaFornecedor5_MEDIAITENSMETA]  DEFAULT ((0)) FOR [MediaItens]
GO
ALTER TABLE [dbo].[Fato_MetaFornecedor] ADD  CONSTRAINT [DF_Fato_MetaFornecedor5_MEDIAITENSCLIENTEMETA]  DEFAULT ((0)) FOR [MediaItensCliente]
GO
ALTER TABLE [dbo].[Fato_MetaFornecedor] ADD  CONSTRAINT [DF_Fato_MetaFornecedor5_PERCENTUALVALORDEVOLUCAOMETA]  DEFAULT ((0)) FOR [PercentualValorDevolucao]
GO
ALTER TABLE [dbo].[Fato_MetaFornecedor] ADD  CONSTRAINT [DF_Fato_MetaFornecedor5_PERCENTUALITENSDEVOLUCAOMETA]  DEFAULT ((0)) FOR [PercentualItensDevolucao]
GO
ALTER TABLE [dbo].[Fato_MetaFornecedor] ADD  CONSTRAINT [DF_Fato_MetaFornecedor5_PERCENTUALINADIMPLENCIAMETA]  DEFAULT ((0)) FOR [PercentualInadimplencia]
GO
ALTER TABLE [dbo].[Fato_MetaFornecedor] ADD  CONSTRAINT [DF_Fato_MetaFornecedor5_PRAZOMEDIOMETA]  DEFAULT ((0)) FOR [PrazoMedio]
GO
ALTER TABLE [dbo].[Fato_MetaFornecedor] ADD  CONSTRAINT [DF_Fato_MetaFornecedor5_VALORMEDIOITEMMETA]  DEFAULT ((0)) FOR [ValorMedioItem]
GO
ALTER TABLE [dbo].[Fato_MetaFornecedor] ADD  CONSTRAINT [DF_Fato_MetaFornecedor5_VALORMEDIOPEDIDOMETA]  DEFAULT ((0)) FOR [ValorMedioPedido]
GO
ALTER TABLE [dbo].[Fato_MetaFornecedor] ADD  CONSTRAINT [DF_Fato_MetaFornecedor5_VALORMEDIOPEDIDODIAMETA]  DEFAULT ((0)) FOR [ValorMedioPedidoDia]
GO
ALTER TABLE [dbo].[Fato_MetaFornecedor] ADD  CONSTRAINT [DF_Fato_MetaFornecedor5_PRECOMEDIOMETA]  DEFAULT ((0)) FOR [PrecoMedio]
GO
ALTER TABLE [dbo].[Fato_MetaFornecedor] ADD  CONSTRAINT [DF_Fato_MetaFornecedor5_PRECOMEDIOPESOMETA]  DEFAULT ((0)) FOR [PrecoMedioPeso]
GO
ALTER TABLE [dbo].[Fato_MetaGrupoProduto] ADD  CONSTRAINT [DF_Fato_MetaGrupoProduto5_VALORMETA]  DEFAULT ((0)) FOR [Valor]
GO
ALTER TABLE [dbo].[Fato_MetaGrupoProduto] ADD  CONSTRAINT [DF_Fato_MetaGrupoProduto5_QUANTIDADEMETA]  DEFAULT ((0)) FOR [QuantidadeVenda]
GO
ALTER TABLE [dbo].[Fato_MetaGrupoProduto] ADD  CONSTRAINT [DF_Fato_MetaGrupoProduto5_QUANTIDADEPEDIDOSMETA]  DEFAULT ((0)) FOR [QuantidadePedidos]
GO
ALTER TABLE [dbo].[Fato_MetaGrupoProduto] ADD  CONSTRAINT [DF_Fato_MetaGrupoProduto5_MIXMETA]  DEFAULT ((0)) FOR [Mix]
GO
ALTER TABLE [dbo].[Fato_MetaGrupoProduto] ADD  CONSTRAINT [DF_Fato_MetaGrupoProduto5_MIXMEDIOMETA]  DEFAULT ((0)) FOR [MixMedio]
GO
ALTER TABLE [dbo].[Fato_MetaGrupoProduto] ADD  CONSTRAINT [DF_Fato_MetaGrupoProduto5_POSITIVACAOMETA]  DEFAULT ((0)) FOR [Positivacao]
GO
ALTER TABLE [dbo].[Fato_MetaGrupoProduto] ADD  CONSTRAINT [DF_Fato_MetaGrupoProduto5_CLIENTECADASTRADOMETA]  DEFAULT ((0)) FOR [ClienteCadastrado]
GO
ALTER TABLE [dbo].[Fato_MetaGrupoProduto] ADD  CONSTRAINT [DF_Fato_MetaGrupoProduto5_QUANTIDADECLIENTESATIVOMETA]  DEFAULT ((0)) FOR [QuantidadeClienteAtivo]
GO
ALTER TABLE [dbo].[Fato_MetaGrupoProduto] ADD  CONSTRAINT [DF_Fato_MetaGrupoProduto5_MARGEMMETA]  DEFAULT ((0)) FOR [Margem]
GO
ALTER TABLE [dbo].[Fato_MetaGrupoProduto] ADD  CONSTRAINT [DF_Fato_MetaGrupoProduto5_PESOMETA]  DEFAULT ((0)) FOR [Peso]
GO
ALTER TABLE [dbo].[Fato_MetaGrupoProduto] ADD  CONSTRAINT [DF_Fato_MetaGrupoProduto5_VOLUMEMETA]  DEFAULT ((0)) FOR [Volume]
GO
ALTER TABLE [dbo].[Fato_MetaGrupoProduto] ADD  CONSTRAINT [DF_Fato_MetaGrupoProduto5_DESCONTOVALORVENDAMETA]  DEFAULT ((0)) FOR [DescontoValorVenda]
GO
ALTER TABLE [dbo].[Fato_MetaGrupoProduto] ADD  CONSTRAINT [DF_Fato_MetaGrupoProduto5_EFETIVIDADEPREVISTA]  DEFAULT ((0)) FOR [Efetividade]
GO
ALTER TABLE [dbo].[Fato_MetaGrupoProduto] ADD  CONSTRAINT [DF_Fato_MetaGrupoProduto5_EFETIVIDADEDIARIAMETA]  DEFAULT ((0)) FOR [EfetividadeDiaria]
GO
ALTER TABLE [dbo].[Fato_MetaGrupoProduto] ADD  CONSTRAINT [DF_Fato_MetaGrupoProduto5_MEDIAITENSMETA]  DEFAULT ((0)) FOR [MediaItens]
GO
ALTER TABLE [dbo].[Fato_MetaGrupoProduto] ADD  CONSTRAINT [DF_Fato_MetaGrupoProduto5_MEDIAITENSCLIENTEMETA]  DEFAULT ((0)) FOR [MediaItensCliente]
GO
ALTER TABLE [dbo].[Fato_MetaGrupoProduto] ADD  CONSTRAINT [DF_Fato_MetaGrupoProduto5_PERCENTUALVALORDEVOLUCAOMETA]  DEFAULT ((0)) FOR [PercentualValorDevolucao]
GO
ALTER TABLE [dbo].[Fato_MetaGrupoProduto] ADD  CONSTRAINT [DF_Fato_MetaGrupoProduto5_PERCENTUALITENSDEVOLUCAOMETA]  DEFAULT ((0)) FOR [PercentualItensDevolucao]
GO
ALTER TABLE [dbo].[Fato_MetaGrupoProduto] ADD  CONSTRAINT [DF_Fato_MetaGrupoProduto5_PERCENTUALINADIMPLENCIAMETA]  DEFAULT ((0)) FOR [PercentualInadimplencia]
GO
ALTER TABLE [dbo].[Fato_MetaGrupoProduto] ADD  CONSTRAINT [DF_Fato_MetaGrupoProduto5_PRAZOMEDIOMETA]  DEFAULT ((0)) FOR [PrazoMedio]
GO
ALTER TABLE [dbo].[Fato_MetaGrupoProduto] ADD  CONSTRAINT [DF_Fato_MetaGrupoProduto5_VALORMEDIOITEMMETA]  DEFAULT ((0)) FOR [ValorMedioItem]
GO
ALTER TABLE [dbo].[Fato_MetaGrupoProduto] ADD  CONSTRAINT [DF_Fato_MetaGrupoProduto5_VALORMEDIOPEDIDOMETA]  DEFAULT ((0)) FOR [ValorMedioPedido]
GO
ALTER TABLE [dbo].[Fato_MetaGrupoProduto] ADD  CONSTRAINT [DF_Fato_MetaGrupoProduto5_VALORMEDIOPEDIDODIAMETA]  DEFAULT ((0)) FOR [ValorMedioPedidoDia]
GO
ALTER TABLE [dbo].[Fato_MetaGrupoProduto] ADD  CONSTRAINT [DF_Fato_MetaGrupoProduto5_PRECOMEDIOMETA]  DEFAULT ((0)) FOR [PrecoMedio]
GO
ALTER TABLE [dbo].[Fato_MetaGrupoProduto] ADD  CONSTRAINT [DF_Fato_MetaGrupoProduto5_PRECOMEDIOPESOMETA]  DEFAULT ((0)) FOR [PrecoMedioPeso]
GO
ALTER TABLE [dbo].[Fato_MetaLinhaProduto] ADD  CONSTRAINT [DF_Fato_MetaLinhaProduto5_VALORMETA]  DEFAULT ((0)) FOR [Valor]
GO
ALTER TABLE [dbo].[Fato_MetaLinhaProduto] ADD  CONSTRAINT [DF_Fato_MetaLinhaProduto5_QUANTIDADEMETA]  DEFAULT ((0)) FOR [QuantidadeVenda]
GO
ALTER TABLE [dbo].[Fato_MetaLinhaProduto] ADD  CONSTRAINT [DF_Fato_MetaLinhaProduto5_QUANTIDADEPEDIDOSMETA]  DEFAULT ((0)) FOR [QuantidadePedidos]
GO
ALTER TABLE [dbo].[Fato_MetaLinhaProduto] ADD  CONSTRAINT [DF_Fato_MetaLinhaProduto5_MIXMETA]  DEFAULT ((0)) FOR [Mix]
GO
ALTER TABLE [dbo].[Fato_MetaLinhaProduto] ADD  CONSTRAINT [DF_Fato_MetaLinhaProduto5_MIXMEDIOMETA]  DEFAULT ((0)) FOR [MixMedio]
GO
ALTER TABLE [dbo].[Fato_MetaLinhaProduto] ADD  CONSTRAINT [DF_Fato_MetaLinhaProduto5_POSITIVACAOMETA]  DEFAULT ((0)) FOR [Positivacao]
GO
ALTER TABLE [dbo].[Fato_MetaLinhaProduto] ADD  CONSTRAINT [DF_Fato_MetaLinhaProduto5_CLIENTECADASTRADOMETA]  DEFAULT ((0)) FOR [ClienteCadastrado]
GO
ALTER TABLE [dbo].[Fato_MetaLinhaProduto] ADD  CONSTRAINT [DF_Fato_MetaLinhaProduto5_QUANTIDADECLIENTESATIVOMETA]  DEFAULT ((0)) FOR [QuantidadeClienteAtivo]
GO
ALTER TABLE [dbo].[Fato_MetaLinhaProduto] ADD  CONSTRAINT [DF_Fato_MetaLinhaProduto5_MARGEMMETA]  DEFAULT ((0)) FOR [Margem]
GO
ALTER TABLE [dbo].[Fato_MetaLinhaProduto] ADD  CONSTRAINT [DF_Fato_MetaLinhaProduto5_PESOMETA]  DEFAULT ((0)) FOR [Peso]
GO
ALTER TABLE [dbo].[Fato_MetaLinhaProduto] ADD  CONSTRAINT [DF_Fato_MetaLinhaProduto5_VOLUMEMETA]  DEFAULT ((0)) FOR [Volume]
GO
ALTER TABLE [dbo].[Fato_MetaLinhaProduto] ADD  CONSTRAINT [DF_Fato_MetaLinhaProduto5_DESCONTOVALORVENDAMETA]  DEFAULT ((0)) FOR [DescontoValorVenda]
GO
ALTER TABLE [dbo].[Fato_MetaLinhaProduto] ADD  CONSTRAINT [DF_Fato_MetaLinhaProduto5_EFETIVIDADEPREVISTA]  DEFAULT ((0)) FOR [Efetividade]
GO
ALTER TABLE [dbo].[Fato_MetaLinhaProduto] ADD  CONSTRAINT [DF_Fato_MetaLinhaProduto5_EFETIVIDADEDIARIAMETA]  DEFAULT ((0)) FOR [EfetividadeDiaria]
GO
ALTER TABLE [dbo].[Fato_MetaLinhaProduto] ADD  CONSTRAINT [DF_Fato_MetaLinhaProduto5_MEDIAITENSMETA]  DEFAULT ((0)) FOR [MediaItens]
GO
ALTER TABLE [dbo].[Fato_MetaLinhaProduto] ADD  CONSTRAINT [DF_Fato_MetaLinhaProduto5_MEDIAITENSCLIENTEMETA]  DEFAULT ((0)) FOR [MediaItensCliente]
GO
ALTER TABLE [dbo].[Fato_MetaLinhaProduto] ADD  CONSTRAINT [DF_Fato_MetaLinhaProduto5_PERCENTUALVALORDEVOLUCAOMETA]  DEFAULT ((0)) FOR [PercentualValorDevolucao]
GO
ALTER TABLE [dbo].[Fato_MetaLinhaProduto] ADD  CONSTRAINT [DF_Fato_MetaLinhaProduto5_PERCENTUALITENSDEVOLUCAOMETA]  DEFAULT ((0)) FOR [PercentualItensDevolucao]
GO
ALTER TABLE [dbo].[Fato_MetaLinhaProduto] ADD  CONSTRAINT [DF_Fato_MetaLinhaProduto5_PERCENTUALINADIMPLENCIAMETA]  DEFAULT ((0)) FOR [PercentualInadimplencia]
GO
ALTER TABLE [dbo].[Fato_MetaLinhaProduto] ADD  CONSTRAINT [DF_Fato_MetaLinhaProduto5_PRAZOMEDIOMETA]  DEFAULT ((0)) FOR [PrazoMedio]
GO
ALTER TABLE [dbo].[Fato_MetaLinhaProduto] ADD  CONSTRAINT [DF_Fato_MetaLinhaProduto5_VALORMEDIOITEMMETA]  DEFAULT ((0)) FOR [ValorMedioItem]
GO
ALTER TABLE [dbo].[Fato_MetaLinhaProduto] ADD  CONSTRAINT [DF_Fato_MetaLinhaProduto5_VALORMEDIOPEDIDOMETA]  DEFAULT ((0)) FOR [ValorMedioPedido]
GO
ALTER TABLE [dbo].[Fato_MetaLinhaProduto] ADD  CONSTRAINT [DF_Fato_MetaLinhaProduto5_VALORMEDIOPEDIDODIAMETA]  DEFAULT ((0)) FOR [ValorMedioPedidoDia]
GO
ALTER TABLE [dbo].[Fato_MetaLinhaProduto] ADD  CONSTRAINT [DF_Fato_MetaLinhaProduto5_PRECOMEDIOMETA]  DEFAULT ((0)) FOR [PrecoMedio]
GO
ALTER TABLE [dbo].[Fato_MetaLinhaProduto] ADD  CONSTRAINT [DF_Fato_MetaLinhaProduto5_PRECOMEDIOPESOMETA]  DEFAULT ((0)) FOR [PrecoMedioPeso]
GO
ALTER TABLE [dbo].[Fato_MetaMarca] ADD  CONSTRAINT [DF_Fato_MetaMarca5_VALORMETA]  DEFAULT ((0)) FOR [Valor]
GO
ALTER TABLE [dbo].[Fato_MetaMarca] ADD  CONSTRAINT [DF_Fato_MetaMarca5_QUANTIDADEMETA]  DEFAULT ((0)) FOR [QuantidadeVenda]
GO
ALTER TABLE [dbo].[Fato_MetaMarca] ADD  CONSTRAINT [DF_Fato_MetaMarca5_QUANTIDADEPEDIDOSMETA]  DEFAULT ((0)) FOR [QuantidadePedidos]
GO
ALTER TABLE [dbo].[Fato_MetaMarca] ADD  CONSTRAINT [DF_Fato_MetaMarca5_MIXMETA]  DEFAULT ((0)) FOR [Mix]
GO
ALTER TABLE [dbo].[Fato_MetaMarca] ADD  CONSTRAINT [DF_Fato_MetaMarca5_MIXMEDIOMETA]  DEFAULT ((0)) FOR [MixMedio]
GO
ALTER TABLE [dbo].[Fato_MetaMarca] ADD  CONSTRAINT [DF_Fato_MetaMarca5_POSITIVACAOMETA]  DEFAULT ((0)) FOR [Positivacao]
GO
ALTER TABLE [dbo].[Fato_MetaMarca] ADD  CONSTRAINT [DF_Fato_MetaMarca5_CLIENTECADASTRADOMETA]  DEFAULT ((0)) FOR [ClienteCadastrado]
GO
ALTER TABLE [dbo].[Fato_MetaMarca] ADD  CONSTRAINT [DF_Fato_MetaMarca5_QUANTIDADECLIENTESATIVOMETA]  DEFAULT ((0)) FOR [QuantidadeClienteAtivo]
GO
ALTER TABLE [dbo].[Fato_MetaMarca] ADD  CONSTRAINT [DF_Fato_MetaMarca5_MARGEMMETA]  DEFAULT ((0)) FOR [Margem]
GO
ALTER TABLE [dbo].[Fato_MetaMarca] ADD  CONSTRAINT [DF_Fato_MetaMarca5_PESOMETA]  DEFAULT ((0)) FOR [Peso]
GO
ALTER TABLE [dbo].[Fato_MetaMarca] ADD  CONSTRAINT [DF_Fato_MetaMarca5_VOLUMEMETA]  DEFAULT ((0)) FOR [Volume]
GO
ALTER TABLE [dbo].[Fato_MetaMarca] ADD  CONSTRAINT [DF_Fato_MetaMarca5_DESCONTOVALORVENDAMETA]  DEFAULT ((0)) FOR [DescontoValorVenda]
GO
ALTER TABLE [dbo].[Fato_MetaMarca] ADD  CONSTRAINT [DF_Fato_MetaMarca5_EFETIVIDADEPREVISTA]  DEFAULT ((0)) FOR [Efetividade]
GO
ALTER TABLE [dbo].[Fato_MetaMarca] ADD  CONSTRAINT [DF_Fato_MetaMarca5_EFETIVIDADEDIARIAMETA]  DEFAULT ((0)) FOR [EfetividadeDiaria]
GO
ALTER TABLE [dbo].[Fato_MetaMarca] ADD  CONSTRAINT [DF_Fato_MetaMarca5_MEDIAITENSMETA]  DEFAULT ((0)) FOR [MediaItens]
GO
ALTER TABLE [dbo].[Fato_MetaMarca] ADD  CONSTRAINT [DF_Fato_MetaMarca5_MEDIAITENSCLIENTEMETA]  DEFAULT ((0)) FOR [MediaItensCliente]
GO
ALTER TABLE [dbo].[Fato_MetaMarca] ADD  CONSTRAINT [DF_Fato_MetaMarca5_PERCENTUALVALORDEVOLUCAOMETA]  DEFAULT ((0)) FOR [PercentualValorDevolucao]
GO
ALTER TABLE [dbo].[Fato_MetaMarca] ADD  CONSTRAINT [DF_Fato_MetaMarca5_PERCENTUALITENSDEVOLUCAOMETA]  DEFAULT ((0)) FOR [PercentualItensDevolucao]
GO
ALTER TABLE [dbo].[Fato_MetaMarca] ADD  CONSTRAINT [DF_Fato_MetaMarca5_PERCENTUALINADIMPLENCIAMETA]  DEFAULT ((0)) FOR [PercentualInadimplencia]
GO
ALTER TABLE [dbo].[Fato_MetaMarca] ADD  CONSTRAINT [DF_Fato_MetaMarca5_PRAZOMEDIOMETA]  DEFAULT ((0)) FOR [PrazoMedio]
GO
ALTER TABLE [dbo].[Fato_MetaMarca] ADD  CONSTRAINT [DF_Fato_MetaMarca5_VALORMEDIOITEMMETA]  DEFAULT ((0)) FOR [ValorMedioItem]
GO
ALTER TABLE [dbo].[Fato_MetaMarca] ADD  CONSTRAINT [DF_Fato_MetaMarca5_VALORMEDIOPEDIDOMETA]  DEFAULT ((0)) FOR [ValorMedioPedido]
GO
ALTER TABLE [dbo].[Fato_MetaMarca] ADD  CONSTRAINT [DF_Fato_MetaMarca5_VALORMEDIOPEDIDODIAMETA]  DEFAULT ((0)) FOR [ValorMedioPedidoDia]
GO
ALTER TABLE [dbo].[Fato_MetaMarca] ADD  CONSTRAINT [DF_Fato_MetaMarca5_PRECOMEDIOMETA]  DEFAULT ((0)) FOR [PrecoMedio]
GO
ALTER TABLE [dbo].[Fato_MetaMarca] ADD  CONSTRAINT [DF_Fato_MetaMarca5_PRECOMEDIOPESOMETA]  DEFAULT ((0)) FOR [PrecoMedioPeso]
GO
ALTER TABLE [dbo].[Fato_MetaProduto] ADD  CONSTRAINT [DF_Fato_MetaProduto5_VALORMETA]  DEFAULT ((0)) FOR [Valor]
GO
ALTER TABLE [dbo].[Fato_MetaProduto] ADD  CONSTRAINT [DF_Fato_MetaProduto5_QUANTIDADEMETA]  DEFAULT ((0)) FOR [QuantidadeVenda]
GO
ALTER TABLE [dbo].[Fato_MetaProduto] ADD  CONSTRAINT [DF_Fato_MetaProduto5_QUANTIDADEPEDIDOSMETA]  DEFAULT ((0)) FOR [QuantidadePedidos]
GO
ALTER TABLE [dbo].[Fato_MetaProduto] ADD  CONSTRAINT [DF_Fato_MetaProduto5_MIXMETA]  DEFAULT ((0)) FOR [Mix]
GO
ALTER TABLE [dbo].[Fato_MetaProduto] ADD  CONSTRAINT [DF_Fato_MetaProduto5_MIXMEDIOMETA]  DEFAULT ((0)) FOR [MixMedio]
GO
ALTER TABLE [dbo].[Fato_MetaProduto] ADD  CONSTRAINT [DF_Fato_MetaProduto5_POSITIVACAOMETA]  DEFAULT ((0)) FOR [Positivacao]
GO
ALTER TABLE [dbo].[Fato_MetaProduto] ADD  CONSTRAINT [DF_Fato_MetaProduto5_CLIENTECADASTRADOMETA]  DEFAULT ((0)) FOR [ClienteCadastrado]
GO
ALTER TABLE [dbo].[Fato_MetaProduto] ADD  CONSTRAINT [DF_Fato_MetaProduto5_QUANTIDADECLIENTESATIVOMETA]  DEFAULT ((0)) FOR [QuantidadeClienteAtivo]
GO
ALTER TABLE [dbo].[Fato_MetaProduto] ADD  CONSTRAINT [DF_Fato_MetaProduto5_MARGEMMETA]  DEFAULT ((0)) FOR [Margem]
GO
ALTER TABLE [dbo].[Fato_MetaProduto] ADD  CONSTRAINT [DF_Fato_MetaProduto5_PESOMETA]  DEFAULT ((0)) FOR [Peso]
GO
ALTER TABLE [dbo].[Fato_MetaProduto] ADD  CONSTRAINT [DF_Fato_MetaProduto5_VOLUMEMETA]  DEFAULT ((0)) FOR [Volume]
GO
ALTER TABLE [dbo].[Fato_MetaProduto] ADD  CONSTRAINT [DF_Fato_MetaProduto5_DESCONTOVALORVENDAMETA]  DEFAULT ((0)) FOR [DescontoValorVenda]
GO
ALTER TABLE [dbo].[Fato_MetaProduto] ADD  CONSTRAINT [DF_Fato_MetaProduto5_EFETIVIDADEPREVISTA]  DEFAULT ((0)) FOR [Efetividade]
GO
ALTER TABLE [dbo].[Fato_MetaProduto] ADD  CONSTRAINT [DF_Fato_MetaProduto5_EFETIVIDADEDIARIAMETA]  DEFAULT ((0)) FOR [EfetividadeDiaria]
GO
ALTER TABLE [dbo].[Fato_MetaProduto] ADD  CONSTRAINT [DF_Fato_MetaProduto5_MEDIAITENSMETA]  DEFAULT ((0)) FOR [MediaItens]
GO
ALTER TABLE [dbo].[Fato_MetaProduto] ADD  CONSTRAINT [DF_Fato_MetaProduto5_MEDIAITENSCLIENTEMETA]  DEFAULT ((0)) FOR [MediaItensCliente]
GO
ALTER TABLE [dbo].[Fato_MetaProduto] ADD  CONSTRAINT [DF_Fato_MetaProduto5_PERCENTUALVALORDEVOLUCAOMETA]  DEFAULT ((0)) FOR [PercentualValorDevolucao]
GO
ALTER TABLE [dbo].[Fato_MetaProduto] ADD  CONSTRAINT [DF_Fato_MetaProduto5_PERCENTUALITENSDEVOLUCAOMETA]  DEFAULT ((0)) FOR [PercentualItensDevolucao]
GO
ALTER TABLE [dbo].[Fato_MetaProduto] ADD  CONSTRAINT [DF_Fato_MetaProduto5_PERCENTUALINADIMPLENCIAMETA]  DEFAULT ((0)) FOR [PercentualInadimplencia]
GO
ALTER TABLE [dbo].[Fato_MetaProduto] ADD  CONSTRAINT [DF_Fato_MetaProduto5_PRAZOMEDIOMETA]  DEFAULT ((0)) FOR [PrazoMedio]
GO
ALTER TABLE [dbo].[Fato_MetaProduto] ADD  CONSTRAINT [DF_Fato_MetaProduto5_VALORMEDIOITEMMETA]  DEFAULT ((0)) FOR [ValorMedioItem]
GO
ALTER TABLE [dbo].[Fato_MetaProduto] ADD  CONSTRAINT [DF_Fato_MetaProduto5_VALORMEDIOPEDIDOMETA]  DEFAULT ((0)) FOR [ValorMedioPedido]
GO
ALTER TABLE [dbo].[Fato_MetaProduto] ADD  CONSTRAINT [DF_Fato_MetaProduto5_VALORMEDIOPEDIDODIAMETA]  DEFAULT ((0)) FOR [ValorMedioPedidoDia]
GO
ALTER TABLE [dbo].[Fato_MetaProduto] ADD  CONSTRAINT [DF_Fato_MetaProduto5_PRECOMEDIOMETA]  DEFAULT ((0)) FOR [PrecoMedio]
GO
ALTER TABLE [dbo].[Fato_MetaProduto] ADD  CONSTRAINT [DF_Fato_MetaProduto5_PRECOMEDIOPESOMETA]  DEFAULT ((0)) FOR [PrecoMedioPeso]
GO
ALTER TABLE [dbo].[Fato_MetaRamoAtividade] ADD  CONSTRAINT [DF_Fato_MetaRamoAtividade5_VALORMETA]  DEFAULT ((0)) FOR [Valor]
GO
ALTER TABLE [dbo].[Fato_MetaRamoAtividade] ADD  CONSTRAINT [DF_Fato_MetaRamoAtividade5_QUANTIDADEMETA]  DEFAULT ((0)) FOR [QuantidadeVenda]
GO
ALTER TABLE [dbo].[Fato_MetaRamoAtividade] ADD  CONSTRAINT [DF_Fato_MetaRamoAtividade5_QUANTIDADEPEDIDOSMETA]  DEFAULT ((0)) FOR [QuantidadePedidos]
GO
ALTER TABLE [dbo].[Fato_MetaRamoAtividade] ADD  CONSTRAINT [DF_Fato_MetaRamoAtividade5_MIXMETA]  DEFAULT ((0)) FOR [Mix]
GO
ALTER TABLE [dbo].[Fato_MetaRamoAtividade] ADD  CONSTRAINT [DF_Fato_MetaRamoAtividade5_MIXMEDIOMETA]  DEFAULT ((0)) FOR [MixMedio]
GO
ALTER TABLE [dbo].[Fato_MetaRamoAtividade] ADD  CONSTRAINT [DF_Fato_MetaRamoAtividade5_POSITIVACAOMETA]  DEFAULT ((0)) FOR [Positivacao]
GO
ALTER TABLE [dbo].[Fato_MetaRamoAtividade] ADD  CONSTRAINT [DF_Fato_MetaRamoAtividade5_CLIENTECADASTRADOMETA]  DEFAULT ((0)) FOR [ClienteCadastrado]
GO
ALTER TABLE [dbo].[Fato_MetaRamoAtividade] ADD  CONSTRAINT [DF_Fato_MetaRamoAtividade5_QUANTIDADECLIENTESATIVOMETA]  DEFAULT ((0)) FOR [QuantidadeClienteAtivo]
GO
ALTER TABLE [dbo].[Fato_MetaRamoAtividade] ADD  CONSTRAINT [DF_Fato_MetaRamoAtividade5_MARGEMMETA]  DEFAULT ((0)) FOR [Margem]
GO
ALTER TABLE [dbo].[Fato_MetaRamoAtividade] ADD  CONSTRAINT [DF_Fato_MetaRamoAtividade5_PESOMETA]  DEFAULT ((0)) FOR [Peso]
GO
ALTER TABLE [dbo].[Fato_MetaRamoAtividade] ADD  CONSTRAINT [DF_Fato_MetaRamoAtividade5_VOLUMEMETA]  DEFAULT ((0)) FOR [Volume]
GO
ALTER TABLE [dbo].[Fato_MetaRamoAtividade] ADD  CONSTRAINT [DF_Fato_MetaRamoAtividade5_DESCONTOVALORVENDAMETA]  DEFAULT ((0)) FOR [DescontoValorVenda]
GO
ALTER TABLE [dbo].[Fato_MetaRamoAtividade] ADD  CONSTRAINT [DF_Fato_MetaRamoAtividade5_EFETIVIDADEPREVISTA]  DEFAULT ((0)) FOR [Efetividade]
GO
ALTER TABLE [dbo].[Fato_MetaRamoAtividade] ADD  CONSTRAINT [DF_Fato_MetaRamoAtividade5_EFETIVIDADEDIARIAMETA]  DEFAULT ((0)) FOR [EfetividadeDiaria]
GO
ALTER TABLE [dbo].[Fato_MetaRamoAtividade] ADD  CONSTRAINT [DF_Fato_MetaRamoAtividade5_MEDIAITENSMETA]  DEFAULT ((0)) FOR [MediaItens]
GO
ALTER TABLE [dbo].[Fato_MetaRamoAtividade] ADD  CONSTRAINT [DF_Fato_MetaRamoAtividade5_MEDIAITENSCLIENTEMETA]  DEFAULT ((0)) FOR [MediaItensCliente]
GO
ALTER TABLE [dbo].[Fato_MetaRamoAtividade] ADD  CONSTRAINT [DF_Fato_MetaRamoAtividade5_PERCENTUALVALORDEVOLUCAOMETA]  DEFAULT ((0)) FOR [PercentualValorDevolucao]
GO
ALTER TABLE [dbo].[Fato_MetaRamoAtividade] ADD  CONSTRAINT [DF_Fato_MetaRamoAtividade5_PERCENTUALITENSDEVOLUCAOMETA]  DEFAULT ((0)) FOR [PercentualItensDevolucao]
GO
ALTER TABLE [dbo].[Fato_MetaRamoAtividade] ADD  CONSTRAINT [DF_Fato_MetaRamoAtividade5_PERCENTUALINADIMPLENCIAMETA]  DEFAULT ((0)) FOR [PercentualInadimplencia]
GO
ALTER TABLE [dbo].[Fato_MetaRamoAtividade] ADD  CONSTRAINT [DF_Fato_MetaRamoAtividade5_PRAZOMEDIOMETA]  DEFAULT ((0)) FOR [PrazoMedio]
GO
ALTER TABLE [dbo].[Fato_MetaRamoAtividade] ADD  CONSTRAINT [DF_Fato_MetaRamoAtividade5_VALORMEDIOITEMMETA]  DEFAULT ((0)) FOR [ValorMedioItem]
GO
ALTER TABLE [dbo].[Fato_MetaRamoAtividade] ADD  CONSTRAINT [DF_Fato_MetaRamoAtividade5_VALORMEDIOPEDIDOMETA]  DEFAULT ((0)) FOR [ValorMedioPedido]
GO
ALTER TABLE [dbo].[Fato_MetaRamoAtividade] ADD  CONSTRAINT [DF_Fato_MetaRamoAtividade5_VALORMEDIOPEDIDODIAMETA]  DEFAULT ((0)) FOR [ValorMedioPedidoDia]
GO
ALTER TABLE [dbo].[Fato_MetaRamoAtividade] ADD  CONSTRAINT [DF_Fato_MetaRamoAtividade5_PRECOMEDIOMETA]  DEFAULT ((0)) FOR [PrecoMedio]
GO
ALTER TABLE [dbo].[Fato_MetaRamoAtividade] ADD  CONSTRAINT [DF_Fato_MetaRamoAtividade5_PRECOMEDIOPESOMETA]  DEFAULT ((0)) FOR [PrecoMedioPeso]
GO
ALTER TABLE [dbo].[Fato_MetaRCA] ADD  CONSTRAINT [DF_Fato_MetaRCA5_VALORMETA]  DEFAULT ((0)) FOR [Valor]
GO
ALTER TABLE [dbo].[Fato_MetaRCA] ADD  CONSTRAINT [DF_Fato_MetaRCA5_QUANTIDADEMETA]  DEFAULT ((0)) FOR [QuantidadeVenda]
GO
ALTER TABLE [dbo].[Fato_MetaRCA] ADD  CONSTRAINT [DF_Fato_MetaRCA5_QUANTIDADEPEDIDOSMETA]  DEFAULT ((0)) FOR [QuantidadePedidos]
GO
ALTER TABLE [dbo].[Fato_MetaRCA] ADD  CONSTRAINT [DF_Fato_MetaRCA5_MIXMETA]  DEFAULT ((0)) FOR [Mix]
GO
ALTER TABLE [dbo].[Fato_MetaRCA] ADD  CONSTRAINT [DF_Fato_MetaRCA5_MIXMEDIOMETA]  DEFAULT ((0)) FOR [MixMedio]
GO
ALTER TABLE [dbo].[Fato_MetaRCA] ADD  CONSTRAINT [DF_Fato_MetaRCA5_POSITIVACAOMETA]  DEFAULT ((0)) FOR [Positivacao]
GO
ALTER TABLE [dbo].[Fato_MetaRCA] ADD  CONSTRAINT [DF_Fato_MetaRCA5_CLIENTECADASTRADOMETA]  DEFAULT ((0)) FOR [ClienteCadastrado]
GO
ALTER TABLE [dbo].[Fato_MetaRCA] ADD  CONSTRAINT [DF_Fato_MetaRCA5_QUANTIDADECLIENTESATIVOMETA]  DEFAULT ((0)) FOR [QuantidadeClienteAtivo]
GO
ALTER TABLE [dbo].[Fato_MetaRCA] ADD  CONSTRAINT [DF_Fato_MetaRCA5_MARGEMMETA]  DEFAULT ((0)) FOR [Margem]
GO
ALTER TABLE [dbo].[Fato_MetaRCA] ADD  CONSTRAINT [DF_Fato_MetaRCA5_PESOMETA]  DEFAULT ((0)) FOR [Peso]
GO
ALTER TABLE [dbo].[Fato_MetaRCA] ADD  CONSTRAINT [DF_Fato_MetaRCA5_VOLUMEMETA]  DEFAULT ((0)) FOR [Volume]
GO
ALTER TABLE [dbo].[Fato_MetaRCA] ADD  CONSTRAINT [DF_Fato_MetaRCA5_DESCONTOVALORVENDAMETA]  DEFAULT ((0)) FOR [DescontoValorVenda]
GO
ALTER TABLE [dbo].[Fato_MetaRCA] ADD  CONSTRAINT [DF_Fato_MetaRCA5_EFETIVIDADEPREVISTA]  DEFAULT ((0)) FOR [Efetividade]
GO
ALTER TABLE [dbo].[Fato_MetaRCA] ADD  CONSTRAINT [DF_Fato_MetaRCA5_EFETIVIDADEDIARIAMETA]  DEFAULT ((0)) FOR [EfetividadeDiaria]
GO
ALTER TABLE [dbo].[Fato_MetaRCA] ADD  CONSTRAINT [DF_Fato_MetaRCA5_MEDIAITENSMETA]  DEFAULT ((0)) FOR [MediaItens]
GO
ALTER TABLE [dbo].[Fato_MetaRCA] ADD  CONSTRAINT [DF_Fato_MetaRCA5_MEDIAITENSCLIENTEMETA]  DEFAULT ((0)) FOR [MediaItensCliente]
GO
ALTER TABLE [dbo].[Fato_MetaRCA] ADD  CONSTRAINT [DF_Fato_MetaRCA5_PERCENTUALVALORDEVOLUCAOMETA]  DEFAULT ((0)) FOR [PercentualValorDevolucao]
GO
ALTER TABLE [dbo].[Fato_MetaRCA] ADD  CONSTRAINT [DF_Fato_MetaRCA5_PERCENTUALITENSDEVOLUCAOMETA]  DEFAULT ((0)) FOR [PercentualItensDevolucao]
GO
ALTER TABLE [dbo].[Fato_MetaRCA] ADD  CONSTRAINT [DF_Fato_MetaRCA5_PERCENTUALINADIMPLENCIAMETA]  DEFAULT ((0)) FOR [PercentualInadimplencia]
GO
ALTER TABLE [dbo].[Fato_MetaRCA] ADD  CONSTRAINT [DF_Fato_MetaRCA5_PRAZOMEDIOMETA]  DEFAULT ((0)) FOR [PrazoMedio]
GO
ALTER TABLE [dbo].[Fato_MetaRCA] ADD  CONSTRAINT [DF_Fato_MetaRCA5_VALORMEDIOITEMMETA]  DEFAULT ((0)) FOR [ValorMedioItem]
GO
ALTER TABLE [dbo].[Fato_MetaRCA] ADD  CONSTRAINT [DF_Fato_MetaRCA5_VALORMEDIOPEDIDOMETA]  DEFAULT ((0)) FOR [ValorMedioPedido]
GO
ALTER TABLE [dbo].[Fato_MetaRCA] ADD  CONSTRAINT [DF_Fato_MetaRCA5_VALORMEDIOPEDIDODIAMETA]  DEFAULT ((0)) FOR [ValorMedioPedidoDia]
GO
ALTER TABLE [dbo].[Fato_MetaRCA] ADD  CONSTRAINT [DF_Fato_MetaRCA5_PRECOMEDIOMETA]  DEFAULT ((0)) FOR [PrecoMedio]
GO
ALTER TABLE [dbo].[Fato_MetaRCA] ADD  CONSTRAINT [DF_Fato_MetaRCA5_PRECOMEDIOPESOMETA]  DEFAULT ((0)) FOR [PrecoMedioPeso]
GO
ALTER TABLE [dbo].[Fato_MetaSecao] ADD  CONSTRAINT [DF_Fato_MetaSecao5_VALORMETA]  DEFAULT ((0)) FOR [Valor]
GO
ALTER TABLE [dbo].[Fato_MetaSecao] ADD  CONSTRAINT [DF_Fato_MetaSecao5_QUANTIDADEMETA]  DEFAULT ((0)) FOR [QuantidadeVenda]
GO
ALTER TABLE [dbo].[Fato_MetaSecao] ADD  CONSTRAINT [DF_Fato_MetaSecao5_QUANTIDADEPEDIDOSMETA]  DEFAULT ((0)) FOR [QuantidadePedidos]
GO
ALTER TABLE [dbo].[Fato_MetaSecao] ADD  CONSTRAINT [DF_Fato_MetaSecao5_MIXMETA]  DEFAULT ((0)) FOR [Mix]
GO
ALTER TABLE [dbo].[Fato_MetaSecao] ADD  CONSTRAINT [DF_Fato_MetaSecao5_MIXMEDIOMETA]  DEFAULT ((0)) FOR [MixMedio]
GO
ALTER TABLE [dbo].[Fato_MetaSecao] ADD  CONSTRAINT [DF_Fato_MetaSecao5_POSITIVACAOMETA]  DEFAULT ((0)) FOR [Positivacao]
GO
ALTER TABLE [dbo].[Fato_MetaSecao] ADD  CONSTRAINT [DF_Fato_MetaSecao5_CLIENTECADASTRADOMETA]  DEFAULT ((0)) FOR [ClienteCadastrado]
GO
ALTER TABLE [dbo].[Fato_MetaSecao] ADD  CONSTRAINT [DF_Fato_MetaSecao5_QUANTIDADECLIENTESATIVOMETA]  DEFAULT ((0)) FOR [QuantidadeClienteAtivo]
GO
ALTER TABLE [dbo].[Fato_MetaSecao] ADD  CONSTRAINT [DF_Fato_MetaSecao5_MARGEMMETA]  DEFAULT ((0)) FOR [Margem]
GO
ALTER TABLE [dbo].[Fato_MetaSecao] ADD  CONSTRAINT [DF_Fato_MetaSecao5_PESOMETA]  DEFAULT ((0)) FOR [Peso]
GO
ALTER TABLE [dbo].[Fato_MetaSecao] ADD  CONSTRAINT [DF_Fato_MetaSecao5_VOLUMEMETA]  DEFAULT ((0)) FOR [Volume]
GO
ALTER TABLE [dbo].[Fato_MetaSecao] ADD  CONSTRAINT [DF_Fato_MetaSecao5_DESCONTOVALORVENDAMETA]  DEFAULT ((0)) FOR [DescontoValorVenda]
GO
ALTER TABLE [dbo].[Fato_MetaSecao] ADD  CONSTRAINT [DF_Fato_MetaSecao5_EFETIVIDADEPREVISTA]  DEFAULT ((0)) FOR [Efetividade]
GO
ALTER TABLE [dbo].[Fato_MetaSecao] ADD  CONSTRAINT [DF_Fato_MetaSecao5_EFETIVIDADEDIARIAMETA]  DEFAULT ((0)) FOR [EfetividadeDiaria]
GO
ALTER TABLE [dbo].[Fato_MetaSecao] ADD  CONSTRAINT [DF_Fato_MetaSecao5_MEDIAITENSMETA]  DEFAULT ((0)) FOR [MediaItens]
GO
ALTER TABLE [dbo].[Fato_MetaSecao] ADD  CONSTRAINT [DF_Fato_MetaSecao5_MEDIAITENSCLIENTEMETA]  DEFAULT ((0)) FOR [MediaItensCliente]
GO
ALTER TABLE [dbo].[Fato_MetaSecao] ADD  CONSTRAINT [DF_Fato_MetaSecao5_PERCENTUALVALORDEVOLUCAOMETA]  DEFAULT ((0)) FOR [PercentualValorDevolucao]
GO
ALTER TABLE [dbo].[Fato_MetaSecao] ADD  CONSTRAINT [DF_Fato_MetaSecao5_PERCENTUALITENSDEVOLUCAOMETA]  DEFAULT ((0)) FOR [PercentualItensDevolucao]
GO
ALTER TABLE [dbo].[Fato_MetaSecao] ADD  CONSTRAINT [DF_Fato_MetaSecao5_PERCENTUALINADIMPLENCIAMETA]  DEFAULT ((0)) FOR [PercentualInadimplencia]
GO
ALTER TABLE [dbo].[Fato_MetaSecao] ADD  CONSTRAINT [DF_Fato_MetaSecao5_PRAZOMEDIOMETA]  DEFAULT ((0)) FOR [PrazoMedio]
GO
ALTER TABLE [dbo].[Fato_MetaSecao] ADD  CONSTRAINT [DF_Fato_MetaSecao5_VALORMEDIOITEMMETA]  DEFAULT ((0)) FOR [ValorMedioItem]
GO
ALTER TABLE [dbo].[Fato_MetaSecao] ADD  CONSTRAINT [DF_Fato_MetaSecao5_VALORMEDIOPEDIDOMETA]  DEFAULT ((0)) FOR [ValorMedioPedido]
GO
ALTER TABLE [dbo].[Fato_MetaSecao] ADD  CONSTRAINT [DF_Fato_MetaSecao5_VALORMEDIOPEDIDODIAMETA]  DEFAULT ((0)) FOR [ValorMedioPedidoDia]
GO
ALTER TABLE [dbo].[Fato_MetaSecao] ADD  CONSTRAINT [DF_Fato_MetaSecao5_PRECOMEDIOMETA]  DEFAULT ((0)) FOR [PrecoMedio]
GO
ALTER TABLE [dbo].[Fato_MetaSecao] ADD  CONSTRAINT [DF_Fato_MetaSecao5_PRECOMEDIOPESOMETA]  DEFAULT ((0)) FOR [PrecoMedioPeso]
GO
ALTER TABLE [dbo].[Fato_MovimentacaoWMS] ADD  CONSTRAINT [DF_Fato_MovimentacaoWMS_Quantidade]  DEFAULT ((0)) FOR [Quantidade]
GO
ALTER TABLE [dbo].[Fato_MovimentacaoWMS] ADD  CONSTRAINT [DF_Fato_MovimentacaoWMS_PesoBruto]  DEFAULT ((0)) FOR [PesoBruto]
GO
ALTER TABLE [dbo].[Fato_MovimentacaoWMS] ADD  CONSTRAINT [DF_Fato_MovimentacaoWMS_Volume]  DEFAULT ((0)) FOR [Volume]
GO
ALTER TABLE [dbo].[Fato_VendaAutorizada] ADD  CONSTRAINT [DF_Fato_VendaAutorizada_Quantidade]  DEFAULT ((0)) FOR [Quantidade]
GO
ALTER TABLE [dbo].[Fato_VendaAutorizada] ADD  CONSTRAINT [DF_Fato_VendaAutorizada_ValorOriginal]  DEFAULT ((0)) FOR [ValorOriginal]
GO
ALTER TABLE [dbo].[Fato_VendaAutorizada] ADD  CONSTRAINT [DF_Fato_VendaAutorizada_ValorVendido]  DEFAULT ((0)) FOR [ValorVendido]
GO
ALTER TABLE [dbo].[Fato_VendaAutorizada] ADD  CONSTRAINT [DF_Fato_VendaAutorizada_ValorCusto]  DEFAULT ((0)) FOR [ValorCusto]
GO
ALTER TABLE [dbo].[Fato_VendaDevolucao] ADD  CONSTRAINT [DF_Fato_VendaDevolucao_Quantidade]  DEFAULT ((0)) FOR [Quantidade]
GO
ALTER TABLE [dbo].[Fato_VendaDevolucao] ADD  CONSTRAINT [DF_Fato_VendaDevolucao_ValorUnitario]  DEFAULT ((0)) FOR [ValorUnitario]
GO
ALTER TABLE [dbo].[Fato_VendaDevolucao] ADD  CONSTRAINT [DF_Fato_VendaDevolucao_QuantidadeUnitariaMaster]  DEFAULT ((1)) FOR [QuantidadeUnitariaMaster]
GO
ALTER TABLE [dbo].[Fato_VendaDevolucao] ADD  CONSTRAINT [DF_Fato_VendaDevolucao_ValorPIS]  DEFAULT ((0)) FOR [ValorPIS]
GO
ALTER TABLE [dbo].[Fato_VendaDevolucao] ADD  CONSTRAINT [DF_Fato_VendaDevolucao_ValorIPI]  DEFAULT ((0)) FOR [ValorIPI]
GO
ALTER TABLE [dbo].[Fato_VendaDevolucao] ADD  CONSTRAINT [DF_Fato_VendaDevolucao_ValorCofins]  DEFAULT ((0)) FOR [ValorCofins]
GO
ALTER TABLE [dbo].[Fato_VendaDevolucao] ADD  CONSTRAINT [DF_Fato_VendaDevolucao_ValorST]  DEFAULT ((0)) FOR [ValorST]
GO
ALTER TABLE [dbo].[Fato_VendaDevolucao] ADD  CONSTRAINT [DF_Fato_VendaDevolucao_PesoLiquidoUnitario]  DEFAULT ((0)) FOR [PesoLiquidoUnitario]
GO
ALTER TABLE [dbo].[Fato_VendaDevolucao] ADD  CONSTRAINT [DF_Fato_VendaDevolucao_PesoBrutoUnitario]  DEFAULT ((0)) FOR [PesoBrutoUnitario]
GO
ALTER TABLE [dbo].[Fato_VendaDevolucao] ADD  CONSTRAINT [DF_Fato_VendaDevolucao_VolumeUnitario]  DEFAULT ((0)) FOR [VolumeUnitario]
GO
ALTER TABLE [dbo].[Fato_VendaFaturamento] ADD  CONSTRAINT [DF_Fato_VendaFaturamento_CodigoTipoItemVenda]  DEFAULT ('N') FOR [CodigoTipoItemVenda]
GO
ALTER TABLE [dbo].[Fato_VendaFaturamento] ADD  CONSTRAINT [DF_Fato_VendaFaturamento_QuantidadeCaixa]  DEFAULT ((1)) FOR [QuantidadeCaixa]
GO
ALTER TABLE [dbo].[Fato_VendaFaturamento] ADD  CONSTRAINT [DF_Fato_VendaFaturamento_ValorST]  DEFAULT ((0)) FOR [ValorST]
GO
ALTER TABLE [dbo].[Fato_VendaFaturamento] ADD  CONSTRAINT [DF_Fato_VendaFaturamento_ValorPIS]  DEFAULT ((0)) FOR [ValorPIS]
GO
ALTER TABLE [dbo].[Fato_VendaFaturamento] ADD  CONSTRAINT [DF_Fato_VendaFaturamento_ValorCOFINS]  DEFAULT ((0)) FOR [ValorCOFINS]
GO
ALTER TABLE [dbo].[Fato_VendaFaturamento] ADD  CONSTRAINT [DF_Fato_VendaFaturamento_ValorIPI]  DEFAULT ((0)) FOR [ValorIPI]
GO
ALTER TABLE [dbo].[Fato_VendaFaturamento] ADD  CONSTRAINT [DF_Fato_VendaFaturamento_ValorICMS]  DEFAULT ((0)) FOR [ValorICMS]
GO
ALTER TABLE [dbo].[Fato_VendaFaturamento] ADD  CONSTRAINT [DF_Fato_VendaFaturamento_ValorUnitarioBonificado]  DEFAULT ((0)) FOR [ValorUnitarioBonificado]
GO
ALTER TABLE [dbo].[Fato_VendaFaturamento] ADD  CONSTRAINT [DF_Fato_VendaFaturamento_QuantidadeBonificada]  DEFAULT ((0)) FOR [QuantidadeBonificada]
GO
ALTER TABLE [dbo].[Fato_VendaFaturamento] ADD  CONSTRAINT [DF_Fato_VendaFaturamento_PercentualComissao]  DEFAULT ((0)) FOR [PercentualComissao]
GO
