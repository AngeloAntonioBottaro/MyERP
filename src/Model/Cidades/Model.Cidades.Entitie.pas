unit Model.Cidades.Entitie;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Model.Cidades.Interfaces;

type
  TModelCidadesEntitie = class
  private
    [weak]
    FParent: IModelCidadesFactory<TModelCidadesEntitie>;

    FIBGE: Integer;
    FId: Integer;
    FNome: string;
    FUF: string;
  public
    constructor Create(AParent: IModelCidadesFactory<TModelCidadesEntitie>);
    destructor Destroy; override;
    function End_Entitie: IModelCidadesFactory<TModelCidadesEntitie>;

    function IBGE(AValue: string): TModelCidadesEntitie; overload;
    function IBGE(AValue: Integer): TModelCidadesEntitie; overload;
    function IBGE: Integer; overload;
    function Id(AValue: string): TModelCidadesEntitie; overload;
    function Id(AValue: Integer): TModelCidadesEntitie; overload;
    function Id: Integer; overload;
    function IdMascara: string;
    function IdNome: string;
    function Nome(AValue: string): TModelCidadesEntitie; overload;
    function Nome: string; overload;
    function UF(AValue: string): TModelCidadesEntitie; overload;
    function UF: string; overload;
    function UFComboBox: Integer;
  end;

implementation

uses
  Common.Utils.MyLibrary,
  Common.Utils.MyConsts;

constructor TModelCidadesEntitie.Create(AParent: IModelCidadesFactory<TModelCidadesEntitie>);
begin
   FParent := AParent;
end;

destructor TModelCidadesEntitie.Destroy;
begin
   inherited;
end;

function TModelCidadesEntitie.End_Entitie: IModelCidadesFactory<TModelCidadesEntitie>;
begin
   Result := FParent;
end;

function TModelCidadesEntitie.IBGE(AValue: string): TModelCidadesEntitie;
begin
   Result := Self;
   Self.IBGE(TMyLibrary.StrToIntDef(AValue.Trim));
end;

function TModelCidadesEntitie.IBGE(AValue: Integer): TModelCidadesEntitie;
begin
   Result := Self;
   FIBGE  := AValue;
end;

function TModelCidadesEntitie.IBGE: Integer;
begin
   Result := FIBGE;
end;

function TModelCidadesEntitie.Id(AValue: string): TModelCidadesEntitie;
begin
   Result := Self;
   Self.Id(TMyLibrary.StrToIntDef(AValue.Trim));
end;

function TModelCidadesEntitie.Id(AValue: Integer): TModelCidadesEntitie;
begin
   Result := Self;
   FId    := AValue;
end;

function TModelCidadesEntitie.Id: Integer;
begin
   Result := FId;
end;

function TModelCidadesEntitie.IdMascara: string;
begin
   Result := EmptyStr;
   if(Self.Id > 0)then
     Result := TMyLibrary.CompLeft(Self.Id);
end;

function TModelCidadesEntitie.IdNome: string;
begin
   Result := Self.Nome;
   Result := IfThen(Result.IsEmpty, Self.IdMascara, Self.IdMascara + ' - ' + Result);
end;

function TModelCidadesEntitie.Nome(AValue: string): TModelCidadesEntitie;
begin
   Result  := Self;
   FNome := AValue.Trim;
end;

function TModelCidadesEntitie.Nome: string;
begin
   Result := FNome;
end;

function TModelCidadesEntitie.UF(AValue: string): TModelCidadesEntitie;
begin
   Result := Self;
   FUF := UpperCase(AValue.Trim);
end;

function TModelCidadesEntitie.UF: string;
begin
   Result := FUF;
end;

function TModelCidadesEntitie.UFComboBox: Integer;
var
  I: Integer;
begin
   Result := -1;
   for I := Low(ESTADOS) to High(ESTADOS) do
   begin
      if(Self.UF.Equals(ESTADOS[I]))then
        Result := I -1;
   end;
end;

end.
