unit Model.Funcionarios.Funcoes.Entitie;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Model.Funcionarios.Funcoes.Interfaces;

type
  TModelFuncionariosFuncoesEntitie = class
  private
    [weak]
    FParent: IModelFuncionariosFuncoesFactory<TModelFuncionariosFuncoesEntitie>;

    FFuncao: string;
    FId: Integer;
  public
    constructor Create(AParent: IModelFuncionariosFuncoesFactory<TModelFuncionariosFuncoesEntitie>);
    destructor Destroy; override;
    function End_Entitie: IModelFuncionariosFuncoesFactory<TModelFuncionariosFuncoesEntitie>;

    function Funcao(AValue: string): TModelFuncionariosFuncoesEntitie; overload;
    function Funcao: string; overload;
    function Id(AValue: string): TModelFuncionariosFuncoesEntitie; overload;
    function Id(AValue: Integer): TModelFuncionariosFuncoesEntitie; overload;
    function Id: Integer; overload;
  end;

implementation

constructor TModelFuncionariosFuncoesEntitie.Create(AParent: IModelFuncionariosFuncoesFactory<TModelFuncionariosFuncoesEntitie>);
begin
end;

destructor TModelFuncionariosFuncoesEntitie.Destroy;
begin
   inherited;
end;

function TModelFuncionariosFuncoesEntitie.End_Entitie: IModelFuncionariosFuncoesFactory<TModelFuncionariosFuncoesEntitie>;
begin
   Result := FParent;
end;

function TModelFuncionariosFuncoesEntitie.Funcao(AValue: string): TModelFuncionariosFuncoesEntitie;
begin
   Result  := Self;
   FFuncao := AValue.Trim;
end;

function TModelFuncionariosFuncoesEntitie.Funcao: string;
begin
   Result := FFuncao;
end;

function TModelFuncionariosFuncoesEntitie.Id(AValue: string): TModelFuncionariosFuncoesEntitie;
begin
   Result := Self;
   Self.Id(StrToInt(AValue.Trim));
end;

function TModelFuncionariosFuncoesEntitie.Id(AValue: Integer): TModelFuncionariosFuncoesEntitie;
begin
   Result := Self;
   FId    := AValue;
end;

function TModelFuncionariosFuncoesEntitie.Id: Integer;
begin
   Result := FId;
end;

end.
