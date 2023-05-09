unit Model.Produtos.Unidades.Factory;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Model.Produtos.Unidades.Interfaces,
  Model.Produtos.Unidades.Entitie;

const
  THIS   = 'Unidade';
  TABELA = 'PRODUTOS_UNIDADES';

type
  TModelProdutosUnidadesFactory = class(TInterfacedObject, IModelProdutosUnidadesFactory<TModelProdutosUnidadesEntitie>)
  private
    FEntitie: TModelProdutosUnidadesEntitie;
    FTelaOrigem: string;
    procedure SQLInsert;
    procedure SQLUpdate;
  protected
    function Entitie: TModelProdutosUnidadesEntitie;

    function ConsultarEntitie: IModelProdutosUnidadesFactory<TModelProdutosUnidadesEntitie>;
    function Deletar: IModelProdutosUnidadesFactory<TModelProdutosUnidadesEntitie>;
    function Gravar: IModelProdutosUnidadesFactory<TModelProdutosUnidadesEntitie>;
  public
    class function New(ATelaOrigem: string): IModelProdutosUnidadesFactory<TModelProdutosUnidadesEntitie>;
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
  Model.Logs;

class function TModelProdutosUnidadesFactory.New(ATelaOrigem: string): IModelProdutosUnidadesFactory<TModelProdutosUnidadesEntitie>;
begin
   if(ATelaOrigem.Trim.IsEmpty)then
     raise ExceptionRequired.Create('Tela de origem da factory unidades de produtos necessária');

   Result := Self.Create(ATelaOrigem);
end;

constructor TModelProdutosUnidadesFactory.Create(ATelaOrigem: string);
begin
   FEntitie := TModelProdutosUnidadesEntitie.Create(Self);
end;

destructor TModelProdutosUnidadesFactory.Destroy;
begin
   if(Assigned(FEntitie))then
     FEntitie.Free;
   inherited;
end;

function TModelProdutosUnidadesFactory.Entitie: TModelProdutosUnidadesEntitie;
begin
   Result := FEntitie;
end;

function TModelProdutosUnidadesFactory.ConsultarEntitie: IModelProdutosUnidadesFactory<TModelProdutosUnidadesEntitie>;
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
        raise ExceptionError.Create('Não foi possível consultar a unidade',
                                    THIS + ': ' + FEntitie.IdMascara + sLineBreak +
                                    'Mensagem: ' + E.Message);
   end;
   end;

   Self.Entitie
    .Id(MyQuery.FieldByName('ID').AsString)
    .Nome(MyQuery.FieldByName('NOME').AsString)
    .Sigla(MyQuery.FieldByName('SIGLA').AsString)
    .End_Entitie;
end;

function TModelProdutosUnidadesFactory.Deletar: IModelProdutosUnidadesFactory<TModelProdutosUnidadesEntitie>;
begin
   Result := Self;

   if(not (FEntitie.Id > 0))then
     ExceptionMsgRegistroNaoInformadoExclusao(THIS);

   if(not ShowQuestionNo('Deseja excluir o registro ' + FEntitie.IdNome))then
     Exit;

   MyQueryNew
    .Add('DELETE FROM '+TABELA+' ')
    .Add('WHERE('+TABELA+'.ID = :ID)')
    .AddParam('ID', FEntitie.Id);

   try
     ShowDebug(MyQuery.SQL.Text);
     MyQuery.ExecSQL;
   except on E: Exception do
   begin
      if(not MyQuery.ExceptionZeroRecordsUpdated)then
        raise ExceptionError.Create('Não foi possível deletar a unidade',
                                    THIS + ': ' + FEntitie.IdMascara + sLineBreak +
                                    'Mensagem: ' + E.Message);
   end;
   end;

   TModelLogs.New.Gravar(FTelaOrigem,
                         'Exclusão de unidade de produto',
                         'Usuário excluiu a unidade ' + FEntitie.IdNome,
                         FEntitie.Id);
   FEntitie.Id(0);

   ShowDone('Exclusão realizada');
end;

function TModelProdutosUnidadesFactory.Gravar: IModelProdutosUnidadesFactory<TModelProdutosUnidadesEntitie>;
var
  LAcao: string;
begin
   Result := Self;

   if(FEntitie.Id > 0)then
     Self.SQLUpdate
   else
     Self.SQLInsert;

   MyQuery
    .AddParam('NOME', FEntitie.Nome)
    .AddParam('SIGLA', FEntitie.Sigla);

   try
     ShowDebug(MyQuery.SQL.Text);
     if(FEntitie.Id > 0)then
     begin
        LAcao := 'Alteração';
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
        raise ExceptionError.Create('Não foi possível gravar a unidade',
                                    'Mensagem: ' + E.Message);
   end;
   end;

   TModelLogs.New.Gravar(FTelaOrigem,
                         LAcao + ' de unidade de produto',
                         'Usuário gravou a unidade ' + FEntitie.IdNome,
                         FEntitie.Id);

   ShowDone('Gravação realizada');
end;

procedure TModelProdutosUnidadesFactory.SQLInsert;
begin
   MyQueryNew
    .Add('INSERT INTO '+TABELA)
    .Add('(NOME, SIGLA)')
    .Add('VALUES')
    .Add('(:NOME, :SIGLA)')
    .Add('RETURNING ID');
end;

procedure TModelProdutosUnidadesFactory.SQLUpdate;
begin
   MyQueryNew
    .Add('UPDATE '+TABELA+' SET')
    .Add('NOME = :NOME, SIGLA = :SIGLA')
    .Add('WHERE('+TABELA+'.ID = :ID)')
    .AddParam('ID', FEntitie.Id);
end;

end.
