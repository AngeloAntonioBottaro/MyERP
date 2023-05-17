unit Model.Vendas.Itens.Factory;

interface

uses
  System.SysUtils,
  MyConnection,
  Datasnap.DBClient,
  Model.Vendas.Itens.Interfaces,
  Model.Vendas.Itens.Entitie;

type
  TModelVendasItensFactory = class(TInterfacedObject, IModelVendasItensFactory)
  private
    FItem: TModelVendasItensEntitie;
    FQItensVenda: TClientDataSet;
  protected
    function NewItem: TModelVendasItensEntitie;
    procedure AddItem;
  public
    class function New(AQItensVenda: TClientDataSet): IModelVendasItensFactory;
    constructor Create(AQItensVenda: TClientDataSet);
    destructor Destroy; override;
  end;

implementation

uses
  Common.Utils.MyLibrary;

{$REGION 'PUBLIC'}
class function TModelVendasItensFactory.New(AQItensVenda: TClientDataSet): IModelVendasItensFactory;
begin
   Result := Self.Create(AQItensVenda);
end;

constructor TModelVendasItensFactory.Create(AQItensVenda: TClientDataSet);
begin
   FQItensVenda := AQItensVenda;
end;

destructor TModelVendasItensFactory.Destroy;
begin
   if(Assigned(FItem))then
     FItem.Free;

   inherited;
end;
{$ENDREGION 'PUBLIC'}

{$REGION 'PROTECTED'}
function TModelVendasItensFactory.NewItem: TModelVendasItensEntitie;
begin
   if(Assigned(FItem))then
     FItem.Free;

   FItem := TModelVendasItensEntitie.Create(Self);
   Result := FItem;
end;

procedure TModelVendasItensFactory.AddItem;
begin
   FQItensVenda.Insert;
   FQItensVenda.FieldByName('ID').AsInteger := FItem.IdProduto;
   FQItensVenda.FieldByName('NOME').AsInteger := FItem.Nome;
   FQItensVenda.Post;
end;
{$ENDREGION 'PROTECTED'}

end.

