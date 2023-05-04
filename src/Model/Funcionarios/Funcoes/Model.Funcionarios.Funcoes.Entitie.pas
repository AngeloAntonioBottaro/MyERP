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

    FId: Integer;
    FNome: string;
  public
    constructor Create(AParent: IModelFuncionariosFuncoesFactory<TModelFuncionariosFuncoesEntitie>);
    destructor Destroy; override;
    function End_Entitie: IModelFuncionariosFuncoesFactory<TModelFuncionariosFuncoesEntitie>;

    function Id(AValue: string): TModelFuncionariosFuncoesEntitie; overload;
    function Id(AValue: Integer): TModelFuncionariosFuncoesEntitie; overload;
    function Id: Integer; overload;
    function IdMascara: string;
    function IdNome: string;
    function Nome(AValue: string): TModelFuncionariosFuncoesEntitie; overload;
    function Nome: string; overload;
  end;

implementation

uses
  Utils.MyLibrary;

constructor TModelFuncionariosFuncoesEntitie.Create(AParent: IModelFuncionariosFuncoesFactory<TModelFuncionariosFuncoesEntitie>);
begin
   FParent := AParent;
end;

destructor TModelFuncionariosFuncoesEntitie.Destroy;
begin
   inherited;
end;

function TModelFuncionariosFuncoesEntitie.End_Entitie: IModelFuncionariosFuncoesFactory<TModelFuncionariosFuncoesEntitie>;
begin
   Result := FParent;
end;

function TModelFuncionariosFuncoesEntitie.Id(AValue: string): TModelFuncionariosFuncoesEntitie;
begin
   Result := Self;
   Self.Id(TMyLibrary.StrToIntDef(AValue.Trim));
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

function TModelFuncionariosFuncoesEntitie.IdMascara: string;
begin
   Result := EmptyStr;
   if(Self.Id > 0)then
     Result := TMyLibrary.CompLeft(Self.Id);
end;

function TModelFuncionariosFuncoesEntitie.IdNome: string;
begin
   Result := Self.Nome;
   if(not Result.IsEmpty)then
     Result := Self.IdMascara + ' - ' + Result;
end;

function TModelFuncionariosFuncoesEntitie.Nome(AValue: string): TModelFuncionariosFuncoesEntitie;
begin
   Result := Self;
   FNome  := AValue.Trim;
end;

function TModelFuncionariosFuncoesEntitie.Nome: string;
begin
   Result := FNome;
end;

end.
