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
    function Nome(AValue: string): TModelCidadesEntitie; overload;
    function Nome: string; overload;
  end;

implementation

constructor TModelCidadesEntitie.Create(AParent: IModelCidadesFactory<TModelCidadesEntitie>);
begin
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
   Self.IBGE(StrToInt(AValue.Trim));
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
   Self.Id(StrToInt(AValue.Trim));
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

function TModelCidadesEntitie.Nome(AValue: string): TModelCidadesEntitie;
begin
   Result  := Self;
   FNome := AValue.Trim;
end;

function TModelCidadesEntitie.Nome: string;
begin
   Result := FNome;
end;

end.
