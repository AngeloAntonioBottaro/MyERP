unit Model.Cidades.Factory;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Model.Cidades.Interfaces,
  Model.Cidades.Entitie;

type
  TModelCidadesFactory = class(TInterfacedObject, IModelCidadesFactory<TModelCidadesEntitie>)
  private
    FEntitie: TModelCidadesEntitie;
    procedure InsertCidade;
    procedure UpdateCidade;
  protected
    function Entitie: TModelCidadesEntitie;

    function Deletar: IModelCidadesFactory<TModelCidadesEntitie>;
    function Gravar: IModelCidadesFactory<TModelCidadesEntitie>;
  public
    class function New: IModelCidadesFactory<TModelCidadesEntitie>;
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

class function TModelCidadesFactory.New: IModelCidadesFactory<TModelCidadesEntitie>;
begin
   Result := Self.Create;
end;

constructor TModelCidadesFactory.Create;
begin
   FEntitie := TModelCidadesEntitie.Create(Self);
end;

destructor TModelCidadesFactory.Destroy;
begin
   if(Assigned(FEntitie))then
     FEntitie.Free;
   inherited;
end;

function TModelCidadesFactory.Entitie: TModelCidadesEntitie;
begin
   Result := FEntitie;
end;

function TModelCidadesFactory.Deletar: IModelCidadesFactory<TModelCidadesEntitie>;
begin
   Result := Self;

   if(not (FEntitie.Id > 0))then
     Exit;

   MyQueryNew
    .Add('DELETE FROM CIDADES ')
    .Add('WHERE(CIDADES.ID = :ID)')
    .AddParam('ID', FEntitie.Id);

   ShowDebug(MyQuery.SQL.Text);
   MyQuery.ExecSQL;

   ShowDone('Exclusão realizada');
end;

function TModelCidadesFactory.Gravar: IModelCidadesFactory<TModelCidadesEntitie>;
begin
   Result := Self;

   if(FEntitie.Id > 0)then
     Self.UpdateCidade
   else
     Self.InsertCidade;

   MyQuery
    .AddParam('NOME', FEntitie.Nome)
    .AddParam('UF', FEntitie.UF)
    .AddParam('IBGE', FEntitie.IBGE);

   try
     ShowDebug(MyQuery.SQL.Text);
     MyQuery.ExecSQL;
   except on E: Exception do
   begin
      if(not MyQuery.ExceptionZeroRecordsUpdated)then
        raise ExceptionError.Create('Não foi possível cadastrar a cidade', E.Message);
   end;
   end;

   ShowDone('Gravação realizada');
end;

procedure TModelCidadesFactory.InsertCidade;
begin
   MyQueryNew
    .Add('INSERT INTO CIDADES ')
    .Add('(NOME, UF, IBGE)')
    .Add('VALUES')
    .Add('(:NOME, :UF, :IBGE)');
end;

procedure TModelCidadesFactory.UpdateCidade;
begin
   MyQueryNew
    .Add('UPDATE CIDADES SET')
    .Add('NOME = :NOME, UF = :UF, IBGE = :IBGE')
    .Add('WHERE(CIDADES.ID = :ID)')
    .AddParam('ID', FEntitie.Id);
end;

end.
