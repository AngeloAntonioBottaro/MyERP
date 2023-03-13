unit Model.Produtos.Grupos.Entitie;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Model.Produtos.Grupos.Interfaces;

type
  TModelProdutosGruposEntitie = class
  private
    [weak]
    FParent: IModelProdutosGruposFactory<TModelProdutosGruposEntitie>;

    FId: Integer;
    FNome: string;
  public
    constructor Create(AParent: IModelProdutosGruposFactory<TModelProdutosGruposEntitie>);
    destructor Destroy; override;
    function End_Entitie: IModelProdutosGruposFactory<TModelProdutosGruposEntitie>;

    function Id(AValue: string): TModelProdutosGruposEntitie; overload;
    function Id(AValue: Integer): TModelProdutosGruposEntitie; overload;
    function Id: Integer; overload;
    function Nome(AValue: string): TModelProdutosGruposEntitie; overload;
    function Nome: string; overload;
  end;

implementation

constructor TModelProdutosGruposEntitie.Create(AParent: IModelProdutosGruposFactory<TModelProdutosGruposEntitie>);
begin
end;

destructor TModelProdutosGruposEntitie.Destroy;
begin
   inherited;
end;

function TModelProdutosGruposEntitie.End_Entitie: IModelProdutosGruposFactory<TModelProdutosGruposEntitie>;
begin
   Result := FParent;
end;

function TModelProdutosGruposEntitie.Id(AValue: string): TModelProdutosGruposEntitie;
begin
   Result := Self;
   Self.Id(StrToInt(AValue.Trim));
end;

function TModelProdutosGruposEntitie.Id(AValue: Integer): TModelProdutosGruposEntitie;
begin
   Result := Self;
   FId    := AValue;
end;

function TModelProdutosGruposEntitie.Id: Integer;
begin
   Result := FId;
end;

function TModelProdutosGruposEntitie.Nome(AValue: string): TModelProdutosGruposEntitie;
begin
   Result  := Self;
   FNome := AValue.Trim;
end;

function TModelProdutosGruposEntitie.Nome: string;
begin
   Result := FNome;
end;

end.
