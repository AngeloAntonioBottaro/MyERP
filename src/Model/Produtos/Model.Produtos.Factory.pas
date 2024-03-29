unit Model.Produtos.Factory;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Model.Produtos.Interfaces,
  Model.Produtos.Entitie;

const
  THIS   = 'Produto';
  TABELA = 'PRODUTOS';

type
  TModelProdutosFactory = class(TInterfacedObject, IModelProdutosFactory<TModelProdutosEntitie>)
  private
    FEntitie: TModelProdutosEntitie;
    FTelaOrigem: string;
    procedure SQLInsert;
    procedure SQLUpdate;
  protected
    function Entitie: TModelProdutosEntitie;

    function AlterarStatus: IModelProdutosFactory<TModelProdutosEntitie>;
    function ConsultarEntitie: IModelProdutosFactory<TModelProdutosEntitie>;
    function Deletar: IModelProdutosFactory<TModelProdutosEntitie>;
    function Gravar: IModelProdutosFactory<TModelProdutosEntitie>;
  public
    class function New(ATelaOrigem: string): IModelProdutosFactory<TModelProdutosEntitie>;
    constructor Create(ATelaOrigem: string);
    destructor Destroy; override;
  end;

implementation

uses
  MyConnection,
  MyMessage,
  MyExceptions,
  Common.Utils.MyLibrary,
  Utils.LibrarySistema,
  Utils.GlobalConsts,
  Model.Logs;

class function TModelProdutosFactory.New(ATelaOrigem: string): IModelProdutosFactory<TModelProdutosEntitie>;
begin
   if(ATelaOrigem.Trim.IsEmpty)then
     raise ExceptionRequired.Create('Tela de origem da factory produtos necess�ria');

   Result := Self.Create(ATelaOrigem);
end;

constructor TModelProdutosFactory.Create(ATelaOrigem: string);
begin
   FTelaOrigem := ATelaOrigem;
   FEntitie    := TModelProdutosEntitie.Create(Self);
end;

destructor TModelProdutosFactory.Destroy;
begin
   if(Assigned(FEntitie))then
     FEntitie.Free;
   inherited;
end;

function TModelProdutosFactory.Entitie: TModelProdutosEntitie;
begin
   Result := FEntitie;
end;

function TModelProdutosFactory.AlterarStatus: IModelProdutosFactory<TModelProdutosEntitie>;
var
  LStatusNovo: string;
begin
   Result := Self;

   if(not (FEntitie.Id > 0))then
     ExceptionMsgRegistroNaoInformadoAlteracaoStatus(THIS);

   if(FEntitie.Id = 1)then
     raise ExceptionWarning.Create('Produto padr�o do sistema n�o pode ser inativado');

   MyQueryNew
    .Add('SELECT STATUS FROM '+TABELA)
    .Add('WHERE('+TABELA+'.ID = :ID)')
    .AddParam('ID', FEntitie.Id)
    .Open;

   LStatusNovo := STATUS_ATIVO;
   if(MyQuery.FieldByName('STATUS').AsString.Equals(STATUS_ATIVO))then
     LStatusNovo := STATUS_INATIVO;

   MyQueryNew
    .Add('UPDATE '+TABELA+' SET STATUS = :STATUS')
    .Add('WHERE('+TABELA+'.ID = :ID)')
    .AddParam('ID', FEntitie.Id)
    .AddParam('STATUS', LStatusNovo);

   try
     ShowDebug(MyQuery.SQL.Text);
     MyQuery.ExecSQL;
   except on E: Exception do
   begin
      if(not MyQuery.ExceptionZeroRecordsUpdated)then
        raise ExceptionError.Create('N�o foi poss�vel alterar o status do produto',
                                    THIS + ': ' + FEntitie.IdMascara + sLineBreak +
                                    'Mensagem: ' + E.Message);
   end;
   end;

   TModelLogs.New.Gravar(FTelaOrigem,
                         'Altera��o de status',
                         'Usu�rio alterou o status do produto ' + FEntitie.IdNome + ' para ' + LStatusNovo,
                         FEntitie.Id);

   ShowDone(THIS + IfThen(LStatusNovo.Equals(STATUS_ATIVO), ' ativado', ' inativado'));
end;

function TModelProdutosFactory.ConsultarEntitie: IModelProdutosFactory<TModelProdutosEntitie>;
begin
   if(not (FEntitie.Id > 0))then
     ExceptionMsgRegistroNaoInformadoConsulta(THIS);

   MyQueryNew
    .Add('SELECT * FROM '+TABELA+' WHERE('+TABELA+'.ID = :ID)')
    .AddParam('ID', FEntitie.Id);

   try
     ShowDebug(MyQuery.SQL.Text);
     MyQuery.Open;
   except on E: Exception do
   begin
      if(not MyQuery.ExceptionZeroRecordsUpdated)then
        raise ExceptionError.Create('N�o foi poss�vel consultar o produto',
                                    THIS + ': ' + FEntitie.IdMascara + sLineBreak +
                                    'Mensagem: ' + E.Message);
   end;
   end;

   Self.Entitie
    .Id(MyQuery.FieldByName('ID').AsString)
    .Nome(MyQuery.FieldByName('NOME').AsString)
    .Descricao(MyQuery.FieldByName('DESCRICAO').AsString)
    .Subgrupo(MyQuery.FieldByName('ID_SUBGRUPO').AsInteger)
    .Custo(MyQuery.FieldByName('CUSTO').AsFloat)
    .PorcentoLucroVendaVista(MyQuery.FieldByName('PORCENTO_LUCRO_VENDA_VISTA').AsFloat)
    .PrecoVendaVista(MyQuery.FieldByName('PRECO_VENDA_VISTA').AsFloat)
    .PorcentoLucroVendaPrazo(MyQuery.FieldByName('PORCENTO_LUCRO_VENDA_PRAZO').AsFloat)
    .PrecoVendaPrazo(MyQuery.FieldByName('PRECO_VENDA_PRAZO').AsFloat)
    .Estoque(MyQuery.FieldByName('ESTOQUE').AsFloat)
    .EstoqueMaximo(MyQuery.FieldByName('ESTOQUE_MAXIMO').AsFloat)
    .EstoqueMinimo(MyQuery.FieldByName('ESTOQUE_MINIMO').AsFloat)
    .CodigoBarras(MyQuery.FieldByName('CODIGO_BARRAS').AsString)
    .Unidade(MyQuery.FieldByName('ID_UNIDADE').AsInteger)
    .End_Entitie;
end;

function TModelProdutosFactory.Deletar: IModelProdutosFactory<TModelProdutosEntitie>;
begin
   Result := Self;

   if(not (FEntitie.Id > 0))then
     ExceptionMsgRegistroNaoInformadoExclusao(THIS);

   if(FEntitie.Id = 1)then
     raise ExceptionWarning.Create('Produto padr�o do sistema n�o pode ser exclu�do');

   if(not ShowQuestionNo('Deseja excluir o registro ' + FEntitie.IdNome))then
     Exit;

   MyQueryNew
    .Add('DELETE FROM '+TABELA)
    .Add('WHERE('+TABELA+'.ID = :ID)')
    .AddParam('ID', FEntitie.Id);

   try
     ShowDebug(MyQuery.SQL.Text);
     MyQuery.ExecSQL;
   except on E: Exception do
   begin
      if(not MyQuery.ExceptionZeroRecordsUpdated)then
        raise ExceptionError.Create('N�o foi poss�vel deletar o produto',
                                    THIS + ': ' + FEntitie.IdMascara + sLineBreak +
                                    'Mensagem: ' + E.Message);
   end;
   end;

   TModelLogs.New.Gravar(FTelaOrigem,
                         'Exclus�o de produto',
                         'Usu�rio excluiu o produto ' + FEntitie.IdNome,
                         FEntitie.Id);
   FEntitie.Id(0);

   ShowDone('Exclus�o realizada');
end;

function TModelProdutosFactory.Gravar: IModelProdutosFactory<TModelProdutosEntitie>;
var
  LAcao: string;
begin
   Result := Self;

   if(FEntitie.Id = 1)then
     raise ExceptionWarning.Create('Produto padr�o do sistema bloqueado para altera��es');

   if(FEntitie.Id > 0)then
     Self.SQLUpdate
   else
     Self.SQLInsert;

   MyQuery
    .AddParam('NOME', FEntitie.Nome)
    .AddParam('DESCRICAO', FEntitie.Descricao)
    .AddParam('CUSTO', FEntitie.Custo)
    .AddParam('PRECO_VENDA_VISTA', FEntitie.PrecoVendaVista)
    .AddParam('PORCENTO_LUCRO_VENDA_VISTA', FEntitie.PorcentoLucroVendaVista)
    .AddParam('PRECO_VENDA_PRAZO', FEntitie.PrecoVendaPrazo)
    .AddParam('PORCENTO_LUCRO_VENDA_PRAZO', FEntitie.PorcentoLucroVendaPrazo)
    .AddParam('ID_SUBGRUPO', FEntitie.Subgrupo)
    .AddParam('ESTOQUE', FEntitie.Estoque)
    .AddParam('ESTOQUE_MAXIMO', FEntitie.EstoqueMaximo)
    .AddParam('ESTOQUE_MINIMO', FEntitie.EstoqueMinimo)
    .AddParam('CODIGO_BARRAS', FEntitie.CodigoBarras)
    .AddParam('ID_UNIDADE', FEntitie.Unidade);

   try
     ShowDebug(MyQuery.SQL.Text);
     if(FEntitie.Id > 0)then
     begin
        LAcao := 'Altera��o';
        MyQuery.ExecSQL;
     end
     else
     begin
        LAcao := 'Cadastro';
        MyQuery.Open;
        FEntitie.Id(MyQuery.FieldByName('ID').AsInteger);
     end;
   except on E: Exception do
   begin
      if(not MyQuery.ExceptionZeroRecordsUpdated)then
        raise ExceptionError.Create('N�o foi poss�vel gravar o produto',
                                    'Mensagem: ' + E.Message);
   end;
   end;

   TModelLogs.New.Gravar(FTelaOrigem,
                         LAcao + ' de produto',
                         'Usu�rio gravou o produto ' + FEntitie.IdNome,
                         FEntitie.Id);

   ShowDone('Grava��o realizada');
end;

procedure TModelProdutosFactory.SQLInsert;
begin
   MyQueryNew
    .Add('INSERT INTO '+TABELA)
    .Add('(STATUS, DATA_CADASTRO, NOME, DESCRICAO, CUSTO, ')
    .Add('PRECO_VENDA_VISTA, PORCENTO_LUCRO_VENDA_VISTA, PRECO_VENDA_PRAZO, PORCENTO_LUCRO_VENDA_PRAZO, ID_SUBGRUPO, ')
    .Add('ESTOQUE, ESTOQUE_MAXMIO, ESTOQUE_MINIMO, CODIGO_BARRAS, ID_UNIDADE)')
    .Add('VALUES')
    .Add('(:STATUS, :DATA_CADASTRO, :NOME, :DESCRICAO, :CUSTO, ')
    .Add(':PRECO_VENDA_VISTA, :PORCENTO_LUCRO_VENDA_VISTA, :PRECO_VENDA_PRAZO, :PORCENTO_LUCRO_VENDA_PRAZO, :ID_SUBGRUPO, ')
    .Add(':ESTOQUE, :ESTOQUE_MAXIMO, :ESTOQUE_MINIMO, :CODIGO_BARRAS, :ID_UNIDADE)')
    .Add('RETURNING ID')
    .AddParam('STATUS', FEntitie.Status)
    .AddParam('DATA_CADASTRO', Now);
end;

procedure TModelProdutosFactory.SQLUpdate;
begin
   MyQueryNew
    .Add('UPDATE '+TABELA+' SET')
    .Add('NOME = :NOME, DESCRICAO = :DESCRICAO, CUSTO = :CUSTO, PRECO_VENDA_VISTA = :PRECO_VENDA_VISTA, PORCENTO_LUCRO_VENDA_VISTA = :PORCENTO_LUCRO_VENDA_VISTA, ')
    .Add('PRECO_VENDA_PRAZO = :PRECO_VENDA_PRAZO, PORCENTO_LUCRO_VENDA_PRAZO = :PORCENTO_LUCRO_VENDA_PRAZO, ID_SUBGRUPO = :ID_SUBGRUPO, ')
    .Add('ESTOQUE = :ESTOQUE, ESTOQUE_MAXIMO = :ESTOQUE_MAXIMO, ESTOQUE_MINIMO = :ESTOQUE_MINIMO, CODIGO_BARRAS = :CODIGO_BARRAS, ')
    .Add('ID_UNIDADE = :ID_UNIDADE')
    .Add('WHERE('+TABELA+'.ID = :ID)')
    .AddParam('ID', FEntitie.Id);
end;

end.
