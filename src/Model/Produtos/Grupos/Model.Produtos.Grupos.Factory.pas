unit Model.Produtos.Grupos.Factory;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Model.Produtos.Grupos.Interfaces,
  Model.Produtos.Grupos.Entitie;

type
  TModelProdutosGruposFactory = class(TInterfacedObject, IModelProdutosGruposFactory<TModelProdutosGruposEntitie>)
  private
    FEntitie: TModelProdutosGruposEntitie;
  protected
    function Entitie: TModelProdutosGruposEntitie;
  public
    class function New: IModelProdutosGruposFactory<TModelProdutosGruposEntitie>;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

class function TModelProdutosGruposFactory.New: IModelProdutosGruposFactory<TModelProdutosGruposEntitie>;
begin
   Result := Self.Create;
end;

constructor TModelProdutosGruposFactory.Create;
begin
   FEntitie := TModelProdutosGruposEntitie.Create(Self);
end;

destructor TModelProdutosGruposFactory.Destroy;
begin
   if(Assigned(FEntitie))then
     FEntitie.Free;
   inherited;
end;

function TModelProdutosGruposFactory.Entitie: TModelProdutosGruposEntitie;
begin
   Result := FEntitie;
end;

end.
