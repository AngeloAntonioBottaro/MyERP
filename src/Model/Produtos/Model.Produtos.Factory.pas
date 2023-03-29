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
    procedure SQLInsert;
    procedure SQLUpdate;
  protected
    function Entitie: TModelProdutosEntitie;

    function AlterarStatus: IModelProdutosFactory<TModelProdutosEntitie>;
    function ConsultarEntitie: IModelProdutosFactory<TModelProdutosEntitie>;
    function Deletar: IModelProdutosFactory<TModelProdutosEntitie>;
    function Gravar: IModelProdutosFactory<TModelProdutosEntitie>;
  public
    class function New: IModelProdutosFactory<TModelProdutosEntitie>;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  MyConnection,
  MyMessage,
  MyExceptions,
  Utils.MyLibrary,
  Utils.LibrarySistema,
  Utils.GlobalConsts;

class function TModelProdutosFactory.New: IModelProdutosFactory<TModelProdutosEntitie>;
begin
   Result := Self.Create;
end;

constructor TModelProdutosFactory.Create;
begin
   FEntitie := TModelProdutosEntitie.Create(Self);
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
     raise ExceptionWarning.Create('Produto padrão do sistema não pode ser inativado');

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
        raise ExceptionError.Create('Não foi possível alterar o status do produto',
                                    THIS + ': ' + FEntitie.IdMascara + sLineBreak +
                                    'Mensagem: ' + E.Message);
   end;
   end;

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
        raise ExceptionError.Create('Não foi possível consultar o produto',
                                    THIS + ': ' + FEntitie.IdMascara + sLineBreak +
                                    'Mensagem: ' + E.Message);
   end;
   end;

   Self.Entitie
    .Id(MyQuery.FieldByName('ID').AsString)
    .Nome(MyQuery.FieldByName('NOME').AsString)
    .Descricao(MyQuery.FieldByName('DESCRICAO').AsString)
    .Subgrupo(MyQuery.FieldByName('SUBGRUPO').AsInteger)
    .Custo(MyQuery.FieldByName('CUSTO').AsFloat)
    .PorcentoLucroVendaVista(MyQuery.FieldByName('PORCENTO_LUCRO_VENDA_VISTA').AsFloat)
    .PrecoVendaVista(MyQuery.FieldByName('PRECO_VENDA_VISTA').AsFloat)
    .PorcentoLucroVendaPrazo(MyQuery.FieldByName('PORCENTO_LUCRO_VENDA_PRAZO').AsFloat)
    .PrecoVendaPrazo(MyQuery.FieldByName('PRECO_VENDA_PRAZO').AsFloat)
    .Estoque(MyQuery.FieldByName('ESTOQUE').AsFloat)
    .EstoqueMaximo(MyQuery.FieldByName('ESTOQUE_MAXIMO').AsFloat)
    .EstoqueMinimo(MyQuery.FieldByName('ESTOQUE_MINIMO').AsFloat)
    .CodigoBarras(MyQuery.FieldByName('CODIGO_BARRAS').AsString)
    .Unidade(MyQuery.FieldByName('UNIDADE').AsInteger)
    .End_Entitie;
end;

function TModelProdutosFactory.Deletar: IModelProdutosFactory<TModelProdutosEntitie>;
begin
   Result := Self;

   if(not (FEntitie.Id > 0))then
     ExceptionMsgRegistroNaoInformadoExclusao(THIS);

   if(FEntitie.Id = 1)then
     raise ExceptionWarning.Create('Produto padrão do sistema não pode ser excluído');

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
        raise ExceptionError.Create('Não foi possível deletar o produto',
                                    THIS + ': ' + FEntitie.IdMascara + sLineBreak +
                                    'Mensagem: ' + E.Message);
   end;
   end;
   FEntitie.Id(0);

   ShowDone('Exclusão realizada');
end;

function TModelProdutosFactory.Gravar: IModelProdutosFactory<TModelProdutosEntitie>;
begin
   Result := Self;

   if(FEntitie.Id = 1)then
     raise ExceptionWarning.Create('Produto padrão do sistema bloqueado para alterações');

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
    .AddParam('SUBGRUPO', FEntitie.Subgrupo)
    .AddParam('ESTOQUE', FEntitie.Estoque)
    .AddParam('ESTOQUE_MAXIMO', FEntitie.EstoqueMaximo)
    .AddParam('ESTOQUE_MINIMO', FEntitie.EstoqueMinimo)
    .AddParam('CODIGO_BARRAS', FEntitie.CodigoBarras)
    .AddParam('UNIDADE', FEntitie.Unidade);

   try
     ShowDebug(MyQuery.SQL.Text);
     MyQuery.ExecSQL;
   except on E: Exception do
   begin
      if(not MyQuery.ExceptionZeroRecordsUpdated)then
        raise ExceptionError.Create('Não foi possível gravar o produto',
                                    'Mensagem: ' + E.Message);
   end;
   end;

   ShowDone('Gravação realizada');
end;

procedure TModelProdutosFactory.SQLInsert;
begin
   MyQueryNew
    .Add('INSERT INTO '+TABELA)
    .Add('(STATUS, DATA_CADASTRO, NOME, DESCRICAO, CUSTO, ')
    .Add('PRECO_VENDA_VISTA, PORCENTO_LUCRO_VENDA_VISTA, PRECO_VENDA_PRAZO, PORCENTO_LUCRO_VENDA_PRAZO, SUBGRUPO, ')
    .Add('ESTOQUE, ESTOQUE_MAXMIO, ESTOQUE_MINIMO, CODIGO_BARRAS, UNIDADE)')
    .Add('VALUES')
    .Add('(:STATUS, :DATA_CADASTRO, :NOME, :DESCRICAO, :CUSTO, ')
    .Add(':PRECO_VENDA_VISTA, :PORCENTO_LUCRO_VENDA_VISTA, :PRECO_VENDA_PRAZO, :PORCENTO_LUCRO_VENDA_PRAZO, :SUBGRUPO, ')
    .Add(':ESTOQUE, :ESTOQUE_MAXIMO, :ESTOQUE_MINIMO, :CODIGO_BARRAS, :UNIDADE)')
    .AddParam('STATUS', FEntitie.Status)
    .AddParam('DATA_CADASTRO', Now);
end;

procedure TModelProdutosFactory.SQLUpdate;
begin
   MyQueryNew
    .Add('UPDATE '+TABELA+' SET')
    .Add('NOME = :NOME, DESCRICAO = :DESCRICAO, CUSTO = :CUSTO, PRECO_VENDA_VISTA = :PRECO_VENDA_VISTA, PORCENTO_LUCRO_VENDA_VISTA = :PORCENTO_LUCRO_VENDA_VISTA, ')
    .Add('PRECO_VENDA_PRAZO = :PRECO_VENDA_PRAZO, PORCENTO_LUCRO_VENDA_PRAZO = :PORCENTO_LUCRO_VENDA_PRAZO, SUBGRUPO = :SUBGRUPO, ')
    .Add('ESTOQUE = :ESTOQUE, ESTOQUE_MAXIMO = :ESTOQUE_MAXIMO, ESTOQUE_MINIMO = :ESTOQUE_MINIMO, CODIGO_BARRAS = :CODIGO_BARRAS, ')
    .Add('UNIDADE = :UNIDADE')
    .Add('WHERE('+TABELA+'.ID = :ID)')
    .AddParam('ID', FEntitie.Id);
end;

end.
