unit Model.Vendas.Factory;

interface

uses
  MyConnection,
  Data.DB,
  Datasnap.DBClient,
  Model.Vendas.Itens.Interfaces;

type
  IModelVendasFactory = interface
   ['{69D89281-ACB5-4961-8B6B-DEB53097220F}']
   function DataSourceVenda(AValue: TDataSource): IModelVendasFactory;
   function DataSourceItens(AValue: TDataSource): IModelVendasFactory;
   function NovaVenda: IModelVendasFactory;
   function Itens: IModelVendasItensFactory;
  end;

  TModelVendasFactory = class(TInterfacedObject, IModelVendasFactory)
  private
    FTBVenda: TClientDataSet;
    FTBItensVenda: TClientDataSet;
    FDataSourceVenda: TDataSource;
    FDataSourceItensVenda: TDataSource;
    FItensFactory: IModelVendasItensFactory;
    procedure NovaTabelaVenda;
    procedure NovaTabelaItensVenda;
  protected
    function DataSourceVenda(AValue: TDataSource): IModelVendasFactory;
    function DataSourceItens(AValue: TDataSource): IModelVendasFactory;
    function NovaVenda: IModelVendasFactory;
    function Itens: IModelVendasItensFactory;
  public
    class function New: IModelVendasFactory;
  end;

implementation

uses
  MyExceptions,
  Model.Vendas.Itens.Factory;

{$REGION 'PUBLIC'}
class function TModelVendasFactory.New: IModelVendasFactory;
begin
   Result := Self.Create;
end;
{$ENDREGION 'PUBLIC'}

{$REGION 'PRIVATE'}
procedure TModelVendasFactory.NovaTabelaVenda;
begin
   if(Assigned(FTBVenda))then
     FTBVenda.Free;

   FTBVenda := TClientDataSet.Create(nil);

   if(Assigned(FDataSourceVenda))then
     FDataSourceVenda.DataSet := FTBVenda;
end;

procedure TModelVendasFactory.NovaTabelaItensVenda;
begin
   if(Assigned(FTBItensVenda))then
     FTBItensVenda.Free;

   FTBItensVenda := TClientDataSet.Create(nil);

   if(Assigned(FDataSourceItensVenda))then
     FDataSourceItensVenda.DataSet := FTBItensVenda;
end;
{$ENDREGION 'PRIVATE'}

{$REGION 'PROTECTED'}
function TModelVendasFactory.DataSourceVenda(AValue: TDataSource): IModelVendasFactory;
begin
   Result := Self;
   FDataSourceVenda := AValue;
end;

function TModelVendasFactory.DataSourceItens(AValue: TDataSource): IModelVendasFactory;
begin
   Result := Self;
   FDataSourceItensVenda := AValue;
end;

function TModelVendasFactory.NovaVenda: IModelVendasFactory;
begin
   Result := Self;
   Self.NovaTabelaVenda;
   Self.NovaTabelaItensVenda;
end;

function TModelVendasFactory.Itens: IModelVendasItensFactory;
begin
   Result := TModelVendasItensFactory.New(FTBItensVenda);
end;
{$ENDREGION 'PROTECTED'}

end.
