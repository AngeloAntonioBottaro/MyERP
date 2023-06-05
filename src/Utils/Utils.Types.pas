unit Utils.Types;

interface

uses
  System.TypInfo;

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

  TFormaPagamento = (Vista, Prazo);
  {$SCOPEDENUMS OFF}

  TFormaPagamentoHelper = record helper for TFormaPagamento
   function ToString: string;
   function ToShortString: string;
   function ToInteger: Integer;
  end;

implementation

function TFormaPagamentoHelper.ToInteger: Integer;
begin
   Result := Integer(Self);
end;

function TFormaPagamentoHelper.ToShortString: string;
begin
   case(Self)of
    TFormaPagamento.Vista: Result := 'V';
    TFormaPagamento.Prazo: Result := 'P';
   end;
end;

function TFormaPagamentoHelper.ToString: string;
begin
   Result := GetEnumName(TypeInfo(TFormaPagamento), Integer(Self));
end;

end.
