unit Model.Vendas.Itens.Factory;

interface

uses
  System.SysUtils,
  MyConnection,
  Model.Vendas.Itens.Interfaces,
  Model.Vendas.Itens.Entitie;

type
  TModelVendasItensFactory = class(TInterfacedObject, IModelVendasItensFactory)
  private
    FItem: TModelVendasItensEntitie;
    FTBItensVenda: IMyTable;
  protected
    function NewItem: TModelVendasItensEntitie;
    procedure AddItem;
  public
    class function New(AQItensVenda: IMyTable): IModelVendasItensFactory;
    constructor Create(AQItensVenda: IMyTable);
    destructor Destroy; override;
  end;

implementation

uses
  Common.Utils.MyLibrary;

{$REGION 'PUBLIC'}
class function TModelVendasItensFactory.New(AQItensVenda: IMyTable): IModelVendasItensFactory;
begin
   Result := Self.Create(AQItensVenda);
end;

constructor TModelVendasItensFactory.Create(AQItensVenda: IMyTable);
begin
   FTBItensVenda := AQItensVenda;
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

   FItem := TModelVendasItensEntitie.Create;
   Result := FItem;
end;

procedure TModelVendasItensFactory.AddItem;
begin
   FTBItensVenda.DataSet.Append;
   FTBItensVenda.DataSet.FieldByName('ID_PRODUTO').AsInteger := FItem.IdProduto;
   FTBItensVenda.DataSet.FieldByName('NOME_PRODUTO').AsString := FItem.Nome;
   FTBItensVenda.DataSet.Post;
end;
{$ENDREGION 'PROTECTED'}

end.

