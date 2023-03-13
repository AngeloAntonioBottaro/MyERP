unit Model.Fornecedores.Factory;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Model.Fornecedores.Interfaces,
  Model.Fornecedores.Entitie;

type
  TModelFornecedoresFactory = class(TInterfacedObject, IModelFornecedoresFactory<TModelFornecedoresEntitie>)
  private
    FEntitie: TModelFornecedoresEntitie;
  protected
    function Entitie: TModelFornecedoresEntitie;
    function ValidarCPF: Boolean;
    function ValidarCNPJ: Boolean;
  public
    class function New: IModelFornecedoresFactory<TModelFornecedoresEntitie>;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

class function TModelFornecedoresFactory.New: IModelFornecedoresFactory<TModelFornecedoresEntitie>;
begin
   Result := Self.Create;
end;

constructor TModelFornecedoresFactory.Create;
begin
   FEntitie := TModelFornecedoresEntitie.Create(Self);
end;

destructor TModelFornecedoresFactory.Destroy;
begin
   if(Assigned(FEntitie))then
     FEntitie.Free;
   inherited;
end;

function TModelFornecedoresFactory.ValidarCNPJ: Boolean;
begin
   Result := True;

   if(FEntitie.Cnpj = EmptyStr)then
     Exit;

   if(Length(FEntitie.Cnpj) = 14)then
     Exit;

   Result := False;
end;

function TModelFornecedoresFactory.ValidarCPF: Boolean;
begin
   Result := True;

   if(FEntitie.Cpf = EmptyStr)then
     Exit;

   if(Length(FEntitie.Cpf) = 11)then
     Exit;

   Result := False;
end;

function TModelFornecedoresFactory.Entitie: TModelFornecedoresEntitie;
begin
   Result := FEntitie;
end;

end.
