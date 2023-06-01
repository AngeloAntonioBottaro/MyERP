unit Model.Vendas.Factory;

interface

uses
  System.SysUtils,
  MyConnection,
  Data.DB,
  Model.Vendas.Itens.Interfaces;

type
  IModelVendasFactory = interface
   ['{69D89281-ACB5-4961-8B6B-DEB53097220F}']
   function DataSourceVenda(AValue: TDataSource): IModelVendasFactory;
   function DataSourceItens(AValue: TDataSource): IModelVendasFactory;
   function NovaVenda: IModelVendasFactory;
   function Itens: IModelVendasItensFactory;
   procedure Gravar;
  end;

  TModelVendasFactory = class(TInterfacedObject, IModelVendasFactory)
  private
    FTBVenda: IMyTable;
    FTBItensVenda: IMyTable;
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
    procedure Gravar;
  public
    class function New: IModelVendasFactory;
  end;

implementation

uses
  MyExceptions,
  MyMessage,
  Model.Vendas.Itens.Factory, Model.Logs;

{$REGION 'PUBLIC'}
class function TModelVendasFactory.New: IModelVendasFactory;
begin
   Result := Self.Create;
end;
{$ENDREGION 'PUBLIC'}

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
   Result := FItensFactory;
end;

procedure TModelVendasFactory.Gravar;
var
  LIdVenda: Integer;
begin
   LIdVenda := FTBVenda.SaveOnDatabase.LastIDCreated;

   FTBItensVenda.DataSet.First;
   while(not FTBItensVenda.DataSet.Eof)do
   begin
      FTBItensVenda.DataSet.Edit;
      FTBItensVenda.DataSet.FieldByName('ID_VENDA').AsInteger := LIdVenda;
      FTBItensVenda.DataSet.Post;
      FTBItensVenda.DataSet.Next;
   end;

   FTBItensVenda.SaveOnDatabase;

   TModelLogs.New.Gravar('Tela de Vendas', 'Gravação de venda', 'Usuário gravou a venda nº: ' + LIdVenda.ToString, LIdVenda);
   ShowDone('Venda gravada com sucesso');
end;
{$ENDREGION 'PROTECTED'}

{$REGION 'PRIVATE'}
procedure TModelVendasFactory.NovaTabelaVenda;
begin
   FTBVenda := MyMemTableNew.Open('SELECT FIRST 0 FROM VENDAS', 'ID');

   if(Assigned(FDataSourceVenda))then
     FDataSourceVenda.DataSet := FTBVenda.DataSet;
end;

procedure TModelVendasFactory.NovaTabelaItensVenda;
begin
   FTBVenda := MyMemTableNew.Open('SELECT FIRST 0 FROM VENDAS_ITENS', 'ID');

   if(Assigned(FDataSourceVenda))then
     FDataSourceVenda.DataSet := FTBVenda.DataSet;

   FItensFactory := TModelVendasItensFactory.New(FTBItensVenda);
end;
{$ENDREGION 'PRIVATE'}

end.
