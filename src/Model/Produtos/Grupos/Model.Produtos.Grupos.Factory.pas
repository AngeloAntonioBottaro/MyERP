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
    procedure SQLInsert;
    procedure SQLUpdate;
  protected
    function Entitie: TModelProdutosGruposEntitie;

    function ConsultarEntitie: IModelProdutosGruposFactory<TModelProdutosGruposEntitie>;
    function Deletar: IModelProdutosGruposFactory<TModelProdutosGruposEntitie>;
    function Gravar: IModelProdutosGruposFactory<TModelProdutosGruposEntitie>;
  public
    class function New: IModelProdutosGruposFactory<TModelProdutosGruposEntitie>;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  MyConnection,
  MyMessage,
  MyExceptions,
  Utils.MyLibrary,
  Utils.LibrarySistema;

class function TModelProdutosGruposFactory.New: IModelProdutosGruposFactory<TModelProdutosGruposEntitie>;
begin
   Result := Self.Create;
end;

constructor TModelProdutosGruposFactory.Create;
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
        raise ExceptionError.Create('N�o foi poss�vel consultar o grupo',
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
        raise ExceptionError.Create('N�o foi poss�vel deletar o grupo',
                                    THIS + ': ' + FEntitie.IdMascara + sLineBreak +
                                    'Mensagem: ' + E.Message);
   end;
   end;
   FEntitie.Id(0);

   ShowDone('Exclus�o realizada');
end;

function TModelProdutosGruposFactory.Gravar: IModelProdutosGruposFactory<TModelProdutosGruposEntitie>;
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
     MyQuery.ExecSQL;
   except on E: Exception do
   begin
      if(not MyQuery.ExceptionZeroRecordsUpdated)then
        raise ExceptionError.Create('N�o foi poss�vel gravar o grupo',
                                    'Mensagem: ' + E.Message);
   end;
   end;

   ShowDone('Grava��o realizada');
end;

procedure TModelProdutosGruposFactory.SQLInsert;
begin
   MyQueryNew
    .Add('INSERT INTO '+TABELA)
    .Add('(NOME)')
    .Add('VALUES')
    .Add('(:NOME)');
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
