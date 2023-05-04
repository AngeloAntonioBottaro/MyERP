unit Model.Produtos.Grupos.Factory;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Model.Produtos.Grupos.Interfaces,
  Model.Produtos.Grupos.Entitie;

const
  THIS   = 'Grupo';
  TABELA = 'PRODUTOS_GRUPOS';

type
  TModelProdutosGruposFactory = class(TInterfacedObject, IModelProdutosGruposFactory<TModelProdutosGruposEntitie>)
  private
    FEntitie: TModelProdutosGruposEntitie;
    FTelaOrigem: string;
    procedure SQLInsert;
    procedure SQLUpdate;
  protected
    function Entitie: TModelProdutosGruposEntitie;

    function ConsultarEntitie: IModelProdutosGruposFactory<TModelProdutosGruposEntitie>;
    function Deletar: IModelProdutosGruposFactory<TModelProdutosGruposEntitie>;
    function Gravar: IModelProdutosGruposFactory<TModelProdutosGruposEntitie>;
  public
    class function New(ATelaOrigem: string): IModelProdutosGruposFactory<TModelProdutosGruposEntitie>;
    constructor Create(ATelaOrigem: string);
    destructor Destroy; override;
  end;

implementation

uses
  MyConnection,
  MyMessage,
  MyExceptions,
  Utils.MyLibrary,
  Utils.LibrarySistema,
  Model.Logs;

class function TModelProdutosGruposFactory.New(ATelaOrigem: string): IModelProdutosGruposFactory<TModelProdutosGruposEntitie>;
begin
   if(ATelaOrigem.Trim.IsEmpty)then
     raise ExceptionRequired.Create('Tela de origem da factory grupos de produtos necessária');

   Result := Self.Create(ATelaOrigem);
end;

constructor TModelProdutosGruposFactory.Create(ATelaOrigem: string);
begin
   FEntitie := TModelProdutosGruposEntitie.Create(Self);
end;

destructor TModelProdutosGruposFactory.Destroy;
begin
   if(Assigned(FEntitie))then
     FEntitie.Free;
   inherited;
end;

function TModelProdutosGruposFactory.Entitie: TModelProdutosGruposEntitie;
begin
   Result := FEntitie;
end;

function TModelProdutosGruposFactory.ConsultarEntitie: IModelProdutosGruposFactory<TModelProdutosGruposEntitie>;
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
        raise ExceptionError.Create('Não foi possível consultar o grupo',
                                    THIS + ': ' + FEntitie.IdMascara + sLineBreak +
                                    'Mensagem: ' + E.Message);
   end;
   end;

   Self.Entitie
    .Id(MyQuery.FieldByName('ID').AsString)
    .Nome(MyQuery.FieldByName('NOME').AsString)
    .End_Entitie;
end;

function TModelProdutosGruposFactory.Deletar: IModelProdutosGruposFactory<TModelProdutosGruposEntitie>;
begin
   Result := Self;

   if(not (FEntitie.Id > 0))then
     ExceptionMsgRegistroNaoInformadoExclusao(THIS);

   if(not ShowQuestionNo('Deseja excluir o registro ' + FEntitie.Id.ToString + ' - ' + FEntitie.Nome))then
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
        raise ExceptionError.Create('Não foi possível deletar o grupo',
                                    THIS + ': ' + FEntitie.IdMascara + sLineBreak +
                                    'Mensagem: ' + E.Message);
   end;
   end;

   TModelLogs.New.Gravar(FTelaOrigem,
                         'Exclusão de grupo de produto',
                         'Usuário excluiu o grupo ' + FEntitie.Id.ToString,
                         FEntitie.Id);
   FEntitie.Id(0);

   ShowDone('Exclusão realizada');
end;

function TModelProdutosGruposFactory.Gravar: IModelProdutosGruposFactory<TModelProdutosGruposEntitie>;
var
  LAcao: string;
begin
   Result := Self;

   if(FEntitie.Id > 0)then
     Self.SQLUpdate
   else
     Self.SQLInsert;

   MyQuery
    .AddParam('NOME', FEntitie.Nome);

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
        raise ExceptionError.Create('Não foi possível gravar o grupo',
                                    'Mensagem: ' + E.Message);
   end;
   end;

   TModelLogs.New.Gravar(FTelaOrigem,
                         LAcao + ' de grupo de produto',
                         'Usuário gravou o grupo ' + FEntitie.IdNome,
                         FEntitie.Id);

   ShowDone('Gravação realizada');
end;

procedure TModelProdutosGruposFactory.SQLInsert;
begin
   MyQueryNew
    .Add('INSERT INTO '+TABELA)
    .Add('(NOME)')
    .Add('VALUES')
    .Add('(:NOME)')
    .Add('RETURNING ID');
end;

procedure TModelProdutosGruposFactory.SQLUpdate;
begin
   MyQueryNew
    .Add('UPDATE '+TABELA+' SET')
    .Add('NOME = :NOME')
    .Add('WHERE('+TABELA+'.ID = :ID)')
    .AddParam('ID', FEntitie.Id);
end;

end.
