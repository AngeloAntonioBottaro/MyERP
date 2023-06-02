unit Model.Vendas.Factory;

interface

uses
  System.SysUtils,
  MyConnection,
  Data.DB;

type
  IModelVendasFactory = interface
   ['{69D89281-ACB5-4961-8B6B-DEB53097220F}']
   function DataSourceVenda(AValue: TDataSource): IModelVendasFactory;
   function DataSourceItens(AValue: TDataSource): IModelVendasFactory;
   function NovaVenda: IModelVendasFactory;
   procedure NovoItem(ACodProduto: string);
   procedure CalcularValores;
   procedure SalvarItem;
   procedure GravarVenda;
  end;

  TModelVendasFactory = class(TInterfacedObject, IModelVendasFactory)
  private
    FTBVenda: IMyTable;
    FTBItensVenda: IMyTable;
    FDataSourceVenda: TDataSource;
    FDataSourceItensVenda: TDataSource;
    FCodProduto: string;
    procedure NovaTabelaVenda;
    procedure NovaTabelaItensVenda;
    procedure ConsultarProduto;
    procedure ConsultarProdutoCodBarras(ASQL: string);
    procedure ConsultarProdutoId(ASQL: string);
    procedure PreencherDadosProduto;
  protected
    function DataSourceVenda(AValue: TDataSource): IModelVendasFactory;
    function DataSourceItens(AValue: TDataSource): IModelVendasFactory;
    function NovaVenda: IModelVendasFactory;
    procedure NovoItem(ACodProduto: string);
    procedure CalcularValores;
    procedure SalvarItem;
    procedure GravarVenda;
  public
    class function New: IModelVendasFactory;
  end;

implementation

uses
  MyExceptions,
  MyMessage,
  Common.Utils.MYConsts,
  Model.Logs;

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

procedure TModelVendasFactory.NovoItem(ACodProduto: string);
begin
   if(ACodProduto.Trim.IsEmpty)then
     Exit;

   FCodProduto := ACodProduto;
   Self.ConsultarProduto;
   Self.PreencherDadosProduto;
   Self.CalcularValores;
end;

procedure TModelVendasFactory.ConsultarProduto;
var
  LSQL: string;
begin
   LSQL := 'SELECT PRODUTOS.ID, PRODUTOS.CODIGO_BARRAS, PRODUTOS.NOME, ' + sLineBreak +
           'PRODUTOS.PRECO_VENDA_VISTA, PRODUTOS.PRECO_VENDA_PRAZO, ' + sLineBreak +
           'PRODUTOS_UNIDADES.SIGLA ' + sLineBreak +
           'FROM PRODUTOS ' + sLineBreak +
           'LEFT JOIN PRODUTOS_UNIDADES ON(PRODUTOS_UNIDADES.ID = PRODUTOS.ID_UNIDADE) ' + sLineBreak;

   Self.ConsultarProdutoCodBarras(LSQL);
   if(MyQuery.IsEmpty)then
     Self.ConsultarProdutoId(LSQL);

   if(MyQuery.IsEmpty)then
     raise ExceptionRequired.Create('Produto não encontrado');
end;

procedure TModelVendasFactory.CalcularValores;
var
  LTotal: Double;
begin
   LTotal := (FTBItensVenda.DataSet.FieldByName('QUANTIDADE').AsFloat *
              FTBItensVenda.DataSet.FieldByName('PRECO').AsFloat)
              - FTBItensVenda.DataSet.FieldByName('DESCONTO').AsFloat;

   if(LTotal <= 0)then
     raise ExceptionWarning.Create('Total do item não pode ser zero');

   FTBItensVenda.DataSet.FieldByName('TOTAL').AsFloat := LTotal;
end;

procedure TModelVendasFactory.SalvarItem;
begin
   FTBItensVenda.DataSet.Post;
end;

procedure TModelVendasFactory.GravarVenda;
var
  LIdVenda: Integer;
begin
   FTBVenda.DataSet.Post;

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
procedure TModelVendasFactory.PreencherDadosProduto;
var
  LTipoPreco: string;
begin
   LTipoPreco := 'PRECO_VENDA_VISTA';
   if(False)then
     LTipoPreco := 'PRODUTOS.PRECO_VENDA_PRAZO';

   FTBItensVenda.DataSet.Append;
   FTBItensVenda.DataSet.FieldByName('ID').AsInteger             := FTBItensVenda.DataSet.RecordCount + 1;
   FTBItensVenda.DataSet.FieldByName('ID_PRODUTO').AsInteger     := MyQuery.FieldByName('ID').AsInteger;
   FTBItensVenda.DataSet.FieldByName('NOME_PRODUTO').AsString    := MyQuery.FieldByName('NOME').AsString;
   FTBItensVenda.DataSet.FieldByName('UNIDADE_PRODUTO').AsString := MyQuery.FieldByName('SIGLA').AsString;
   FTBItensVenda.DataSet.FieldByName('PRECO').AsFloat            := MyQuery.FieldByName(LTipoPreco).AsFloat;
   FTBItensVenda.DataSet.FieldByName('QUANTIDADE').AsFloat       := 1;
end;

procedure TModelVendasFactory.ConsultarProdutoCodBarras(ASQL: string);
begin
   MyQueryNew
    .Add(ASQL)
    .Add('WHERE(PRODUTOS.CODIGO_BARRAS = :CODIGO_BARRAS)')
    .AddParam('CODIGO_BARRAS', FCodProduto)
    .Open;
end;

procedure TModelVendasFactory.ConsultarProdutoId(ASQL: string);
begin
   MyQueryNew
    .Add(ASQL)
    .Add('WHERE(PRODUTOS.ID = :ID)')
    .AddParam('ID', FCodProduto)
    .Open;
end;

procedure TModelVendasFactory.NovaTabelaVenda;
begin
   FTBVenda := MyMemTableNew.Open('SELECT FIRST 0 * FROM VENDAS', 'ID');

   if(Assigned(FDataSourceVenda))then
     FDataSourceVenda.DataSet := FTBVenda.DataSet;

   FTBVenda.DataSet.Append;
end;

procedure TModelVendasFactory.NovaTabelaItensVenda;
begin
   FTBItensVenda := MyMemTableNew.Open('SELECT FIRST 0 * FROM VENDAS_ITENS', 'ID');

   if(Assigned(FDataSourceItensVenda))then
     FDataSourceItensVenda.DataSet := FTBItensVenda.DataSet;

   TIntegerField(FTBItensVenda.DataSet.FieldByName('ID_PRODUTO')).DisplayFormat := DISPLAY_FORMAT_CODIGO;
   TFloatField(FTBItensVenda.DataSet.FieldByName('QUANTIDADE')).DisplayFormat   := DISPLAY_FORMAT_DECOMAIS_2;
   TFloatField(FTBItensVenda.DataSet.FieldByName('PRECO')).DisplayFormat        := DISPLAY_FORMAT_DECOMAIS_2;
   TFloatField(FTBItensVenda.DataSet.FieldByName('DESCONTO')).DisplayFormat     := DISPLAY_FORMAT_DECOMAIS_2;
   TFloatField(FTBItensVenda.DataSet.FieldByName('TOTAL')).DisplayFormat        := DISPLAY_FORMAT_DECOMAIS_2;
end;
{$ENDREGION 'PRIVATE'}

end.
