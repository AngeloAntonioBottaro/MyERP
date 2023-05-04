unit Utils.Types;

interface

type
  {$SCOPEDENUMS ON}
  TTipoBuscaCidade            = (Id, Nome, UF, IBGE);
  TTipoBuscaCliente           = (Id, Nome, CPF_CNPJ, Cidade);
  TTipoBuscaFornecedor        = (Id, Nome, CPF_CNPJ, Cidade);
  TTipoBuscaFuncionario       = (Id, Nome, CPF_CNPJ, Cidade);
  TTipoBuscaFuncionarioFuncao = (Id, Nome);
  TTipoBuscaProduto           = (Id, Nome, CodigoBarras);
  TTipoBuscaProdutoGrupo      = (Id, Nome);
  TTipoBuscaProdutoSubGrupo   = (Id, Nome, GrupoId, GrupoNome);
  TTipoBuscaProdutoUnidade    = (Id, Nome, Sigla);
  TTipoBuscaFormaPagamento    = (Id, Nome);
  TTipoBuscaAgenda            = (Id, Titulo, Status, Cliente, Funcionario);
  TTipoBuscaPermissoesGrupo   = (Id, Nome, Descricao);
  {$SCOPEDENUMS OFF}

implementation

end.
