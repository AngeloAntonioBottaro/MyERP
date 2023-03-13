unit Model.Produtos.SubGrupos.Factory;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Model.Produtos.SubGrupos.Interfaces,
  Model.Produtos.SubGrupos.Entitie;

type
  TModelProdutosSubGruposFactory = class(TInterfacedObject, IModelProdutosSubGruposFactory<TModelProdutosSubGruposEntitie>)
  private
    FEntitie: TModelProdutosSubGruposEntitie;
  protected
    function Entitie: TModelProdutosSubGruposEntitie;
  public
    class function New: IModelProdutosSubGruposFactory<TModelProdutosSubGruposEntitie>;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

class function TModelProdutosSubGruposFactory.New: IModelProdutosSubGruposFactory<TModelProdutosSubGruposEntitie>;
begin
   Result := Self.Create;
end;

constructor TModelProdutosSubGruposFactory.Create;
begin
   FEntitie := TModelProdutosSubGruposEntitie.Create(Self);
end;

destructor TModelProdutosSubGruposFactory.Destroy;
begin
   if(Assigned(FEntitie))then
     FEntitie.Free;
   inherited;
end;

function TModelProdutosSubGruposFactory.Entitie: TModelProdutosSubGruposEntitie;
begin
   Result := FEntitie;
end;

end.
