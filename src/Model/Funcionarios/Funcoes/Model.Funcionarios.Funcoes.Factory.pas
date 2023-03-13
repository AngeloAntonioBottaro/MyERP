unit Model.Funcionarios.Funcoes.Factory;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Model.Funcionarios.Funcoes.Interfaces,
  Model.Funcionarios.Funcoes.Entitie;

type
  TModelFuncionariosFuncoesFactory = class(TInterfacedObject, IModelFuncionariosFuncoesFactory<TModelFuncionariosFuncoesEntitie>)
  private
    FEntitie: TModelFuncionariosFuncoesEntitie;
  protected
    function Entitie: TModelFuncionariosFuncoesEntitie;
  public
    class function New: IModelFuncionariosFuncoesFactory<TModelFuncionariosFuncoesEntitie>;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

class function TModelFuncionariosFuncoesFactory.New: IModelFuncionariosFuncoesFactory<TModelFuncionariosFuncoesEntitie>;
begin
   Result := Self.Create;
end;

constructor TModelFuncionariosFuncoesFactory.Create;
begin
   FEntitie := TModelFuncionariosFuncoesEntitie.Create(Self);
end;

destructor TModelFuncionariosFuncoesFactory.Destroy;
begin
   if(Assigned(FEntitie))then
     FEntitie.Free;
   inherited;
end;

function TModelFuncionariosFuncoesFactory.Entitie: TModelFuncionariosFuncoesEntitie;
begin
   Result := FEntitie;
end;

end.
