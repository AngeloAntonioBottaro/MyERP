unit Model.Produtos.Entitie;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Model.Produtos.Interfaces;

type
  TModelProdutosEntitie = class
  private
    [weak]
    FParent: IModelProdutosFactory<TModelProdutosEntitie>;

    FId: Integer;
    FNome: string;
    FStatus: string;
  public
    constructor Create(AParent: IModelProdutosFactory<TModelProdutosEntitie>);
    destructor Destroy; override;
    function End_Entitie: IModelProdutosFactory<TModelProdutosEntitie>;

    function Id(AValue: string): TModelProdutosEntitie; overload;
    function Id(AValue: Integer): TModelProdutosEntitie; overload;
    function Id: Integer; overload;
    function IdMascara: string;
    function Nome(AValue: string): TModelProdutosEntitie; overload;
    function Nome: string; overload;
    function Status(AValue: string): TModelProdutosEntitie; overload;
    function Status: string; overload;
  end;

implementation

uses
  Utils.MyLibrary,
  Utils.GlobalConsts;

constructor TModelProdutosEntitie.Create(AParent: IModelProdutosFactory<TModelProdutosEntitie>);
begin
   FParent := AParent;
   FStatus := STATUS_ATIVO;
end;

destructor TModelProdutosEntitie.Destroy;
begin

  inherited;
end;

function TModelProdutosEntitie.End_Entitie: IModelProdutosFactory<TModelProdutosEntitie>;
begin
   Result := FParent;
end;

function TModelProdutosEntitie.Id(AValue: string): TModelProdutosEntitie;
begin
   Result := Self;
   Self.Id(TMyLibrary.StrToIntDef(AValue.Trim));
end;

function TModelProdutosEntitie.Id(AValue: Integer): TModelProdutosEntitie;
begin
   Result := Self;
   FId    := AValue;
end;

function TModelProdutosEntitie.Id: Integer;
begin
   Result := FId;
end;

function TModelProdutosEntitie.IdMascara: string;
begin
   Result := EmptyStr;
   if(Self.Id > 0)then
     Result := TMyLibrary.CompLeft(Self.Id);
end;

function TModelProdutosEntitie.Nome(AValue: string): TModelProdutosEntitie;
begin
   Result := Self;
   FNome  := AValue;
end;

function TModelProdutosEntitie.Nome: string;
begin
   Result := FNome;
end;

function TModelProdutosEntitie.Status(AValue: string): TModelProdutosEntitie;
begin
   Result  := Self;
   FStatus := AValue.Trim;
end;

function TModelProdutosEntitie.Status: string;
begin
   Result := FStatus;
end;

end.
