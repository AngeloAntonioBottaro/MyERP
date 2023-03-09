unit Model.Clientes.Factory;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Model.Clientes.Interfaces,
  Model.Clientes.Entitie;

type
  TModelClientesFactory = class(TInterfacedObject, IModelClientesFactory<TModelClientesEntitie>)
  private
    FEntitie: TModelClientesEntitie;
  protected
    function Entitie: TModelClientesEntitie;
    function ValidarCPF: Boolean;
  public
    class function New: IModelClientesFactory<TModelClientesEntitie>;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

class function TModelClientesFactory.New: IModelClientesFactory<TModelClientesEntitie>;
begin
   Result := Self.Create;
end;

constructor TModelClientesFactory.Create;
begin
   FEntitie := TModelClientesEntitie.Create(Self);
end;

destructor TModelClientesFactory.Destroy;
begin
   if(Assigned(FEntitie))then
     FEntitie.Free;
   inherited;
end;

function TModelClientesFactory.ValidarCPF: Boolean;
begin
   Result := True;

   if(FEntitie.Cpf = EmptyStr)then
     Exit;

   if(Length(FEntitie.Cpf) = 11)then
     Exit;

   Result := False;
end;

function TModelClientesFactory.Entitie: TModelClientesEntitie;
begin
   Result := FEntitie;
end;

end.
