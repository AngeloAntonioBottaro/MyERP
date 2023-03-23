unit Model.Produtos.Grupos.Factory;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Model.Produtos.Grupos.Interfaces,
  Model.Produtos.Grupos.Entitie;

type
  TModelProdutosGruposFactory = class(TInterfacedObject, IModelProdutosGruposFactory<TModelProdutosGruposEntitie>)
  private
    FEntitie: TModelProdutosGruposEntitie;
    procedure UpdateGrupo;
    procedure InsertGrupo;
  protected
    function Entitie: TModelProdutosGruposEntitie;

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

function TModelProdutosGruposFactory.Deletar: IModelProdutosGruposFactory<TModelProdutosGruposEntitie>;
begin
   Result := Self;

   if(not (FEntitie.Id > 0))then
     Exit;

   MyQueryNew
    .Add('DELETE FROM PRODUTOS_GRUPOS ')
    .Add('WHERE(PRODUTOS_GRUPOS.ID = :ID)')
    .AddParam('ID', FEntitie.Id);

   ShowDebug(MyQuery.SQL.Text);
   MyQuery.ExecSQL;

   ShowDone('Exclusão realizada');
end;

function TModelProdutosGruposFactory.Gravar: IModelProdutosGruposFactory<TModelProdutosGruposEntitie>;
begin
   Result := Self;

   if(FEntitie.Id > 0)then
     Self.UpdateGrupo
   else
     Self.InsertGrupo;

   MyQuery
    .AddParam('GRUPO', FEntitie.Nome);

   try
     ShowDebug(MyQuery.SQL.Text);
     MyQuery.ExecSQL;
   except on E: Exception do
   begin
      if(not MyQuery.ExceptionZeroRecordsUpdated)then
        raise ExceptionError.Create('Não foi possível cadastrar o grupo', E.Message);
   end;
   end;

   ShowDone('Gravação realizada');
end;

procedure TModelProdutosGruposFactory.InsertGrupo;
begin
   MyQueryNew
    .Add('INSERT INTO PRODUTOS_GRUPOS ')
    .Add('(GRUPO)')
    .Add('VALUES')
    .Add('(:GRUPO)');
end;

procedure TModelProdutosGruposFactory.UpdateGrupo;
begin
   MyQueryNew
    .Add('UPDATE PRODUTOS_GRUPOS SET')
    .Add('GRUPO = :GRUPO')
    .Add('WHERE(PRODUTOS_GRUPOS.ID = :ID)')
    .AddParam('ID', FEntitie.Id);
end;

end.
