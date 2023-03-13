unit Model.Funcionarios.Factory;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Model.Funcionarios.Interfaces,
  Model.Funcionarios.Entitie;

type
  TModelFuncionariosFactory = class(TInterfacedObject, IModelFuncionariosFactory<TModelFuncionariosEntitie>)
  private
    FEntitie: TModelFuncionariosEntitie;
  protected
    function Entitie: TModelFuncionariosEntitie;
    function ValidarCPF: Boolean;
    function ValidarCNPJ: Boolean;
  public
    class function New: IModelFuncionariosFactory<TModelFuncionariosEntitie>;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

class function TModelFuncionariosFactory.New: IModelFuncionariosFactory<TModelFuncionariosEntitie>;
begin
   Result := Self.Create;
end;

constructor TModelFuncionariosFactory.Create;
begin
   FEntitie := TModelFuncionariosEntitie.Create(Self);
end;

destructor TModelFuncionariosFactory.Destroy;
begin
   if(Assigned(FEntitie))then
     FEntitie.Free;
   inherited;
end;

function TModelFuncionariosFactory.ValidarCNPJ: Boolean;
begin
   Result := True;

   if(FEntitie.Cnpj = EmptyStr)then
     Exit;

   if(Length(FEntitie.Cnpj) = 14)then
     Exit;

   Result := False;
end;

function TModelFuncionariosFactory.ValidarCPF: Boolean;
begin
   Result := True;

   if(FEntitie.Cpf = EmptyStr)then
     Exit;

   if(Length(FEntitie.Cpf) = 11)then
     Exit;

   Result := False;
end;

function TModelFuncionariosFactory.Entitie: TModelFuncionariosEntitie;
begin
   Result := FEntitie;
end;

end.
