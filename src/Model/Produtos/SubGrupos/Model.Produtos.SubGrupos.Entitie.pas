unit Model.Produtos.SubGrupos.Entitie;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Model.Produtos.SubGrupos.Interfaces;

type
  TModelProdutosSubGruposEntitie = class
  private
    [weak]
    FParent: IModelProdutosSubGruposFactory<TModelProdutosSubGruposEntitie>;

    FGrupo: Integer;
    FId: Integer;
    FNome: string;
  public
    constructor Create(AParent: IModelProdutosSubGruposFactory<TModelProdutosSubGruposEntitie>);
    destructor Destroy; override;
    function End_Entitie: IModelProdutosSubGruposFactory<TModelProdutosSubGruposEntitie>;

    function Grupo(AValue: string): TModelProdutosSubGruposEntitie; overload;
    function Grupo(AValue: Integer): TModelProdutosSubGruposEntitie; overload;
    function Grupo: Integer; overload;
    function Id(AValue: string): TModelProdutosSubGruposEntitie; overload;
    function Id(AValue: Integer): TModelProdutosSubGruposEntitie; overload;
    function Id: Integer; overload;
    function Nome(AValue: string): TModelProdutosSubGruposEntitie; overload;
    function Nome: string; overload;
  end;

implementation

constructor TModelProdutosSubGruposEntitie.Create(AParent: IModelProdutosSubGruposFactory<TModelProdutosSubGruposEntitie>);
begin
end;

destructor TModelProdutosSubGruposEntitie.Destroy;
begin
   inherited;
end;

function TModelProdutosSubGruposEntitie.End_Entitie: IModelProdutosSubGruposFactory<TModelProdutosSubGruposEntitie>;
begin
   Result := FParent;
end;

function TModelProdutosSubGruposEntitie.Grupo(AValue: string): TModelProdutosSubGruposEntitie;
begin
   Result := Self;
   Self.Grupo(StrToInt(AValue.Trim));
end;

function TModelProdutosSubGruposEntitie.Grupo(AValue: Integer): TModelProdutosSubGruposEntitie;
begin
   Result := Self;
   FGrupo := AValue;
end;

function TModelProdutosSubGruposEntitie.Grupo: Integer;
begin
   Result := FGrupo;
end;

function TModelProdutosSubGruposEntitie.Id(AValue: string): TModelProdutosSubGruposEntitie;
begin
   Result := Self;
   Self.Id(StrToInt(AValue.Trim));
end;

function TModelProdutosSubGruposEntitie.Id(AValue: Integer): TModelProdutosSubGruposEntitie;
begin
   Result := Self;
   FId    := AValue;
end;

function TModelProdutosSubGruposEntitie.Id: Integer;
begin
   Result := FId;
end;

function TModelProdutosSubGruposEntitie.Nome(AValue: string): TModelProdutosSubGruposEntitie;
begin
   Result  := Self;
   FNome := AValue.Trim;
end;

function TModelProdutosSubGruposEntitie.Nome: string;
begin
   Result := FNome;
end;

end.
