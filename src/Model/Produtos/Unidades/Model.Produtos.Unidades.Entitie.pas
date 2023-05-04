unit Model.Produtos.Unidades.Entitie;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Model.Produtos.Unidades.Interfaces;

type
  TModelProdutosUnidadesEntitie = class
  private
    [weak]
    FParent: IModelProdutosUnidadesFactory<TModelProdutosUnidadesEntitie>;

    FId: Integer;
    FNome: string;
    FSigla: string;
  public
    constructor Create(AParent: IModelProdutosUnidadesFactory<TModelProdutosUnidadesEntitie>);
    destructor Destroy; override;
    function End_Entitie: IModelProdutosUnidadesFactory<TModelProdutosUnidadesEntitie>;

    function Id(AValue: string): TModelProdutosUnidadesEntitie; overload;
    function Id(AValue: Integer): TModelProdutosUnidadesEntitie; overload;
    function Id: Integer; overload;
    function IdMascara: string;
    function IdNome: string;
    function Nome(AValue: string): TModelProdutosUnidadesEntitie; overload;
    function Nome: string; overload;
    function Sigla(AValue: string): TModelProdutosUnidadesEntitie; overload;
    function Sigla: string; overload;
  end;

implementation

uses
  Utils.MyLibrary;

constructor TModelProdutosUnidadesEntitie.Create(AParent: IModelProdutosUnidadesFactory<TModelProdutosUnidadesEntitie>);
begin
   FParent := AParent;
end;

destructor TModelProdutosUnidadesEntitie.Destroy;
begin
   inherited;
end;

function TModelProdutosUnidadesEntitie.End_Entitie: IModelProdutosUnidadesFactory<TModelProdutosUnidadesEntitie>;
begin
   Result := FParent;
end;

function TModelProdutosUnidadesEntitie.Id(AValue: string): TModelProdutosUnidadesEntitie;
begin
   Result := Self;
   Self.Id(TMyLibrary.StrToIntDef(AValue.Trim));
end;

function TModelProdutosUnidadesEntitie.Id(AValue: Integer): TModelProdutosUnidadesEntitie;
begin
   Result := Self;
   FId    := AValue;
end;

function TModelProdutosUnidadesEntitie.Id: Integer;
begin
   Result := FId;
end;

function TModelProdutosUnidadesEntitie.IdMascara: string;
begin
   Result := EmptyStr;
   if(Self.Id > 0)then
     Result := TMyLibrary.CompLeft(Self.Id);
end;

function TModelProdutosUnidadesEntitie.IdNome: string;
begin
   Result := Self.Nome;
   Result := IfThen(Result.IsEmpty, Self.IdMascara, Self.IdMascara + ' - ' + Result);
end;

function TModelProdutosUnidadesEntitie.Nome(AValue: string): TModelProdutosUnidadesEntitie;
begin
   Result := Self;
   FNome  := AValue.Trim;
end;

function TModelProdutosUnidadesEntitie.Nome: string;
begin
   Result := FNome;
end;

function TModelProdutosUnidadesEntitie.Sigla(AValue: string): TModelProdutosUnidadesEntitie;
begin
   Result := Self;
   FSigla := AValue.Trim;
end;

function TModelProdutosUnidadesEntitie.Sigla: string;
begin
   Result := FSigla;
end;

end.
