unit Model.Vendas.Factory;

interface

uses
  System.SysUtils,
  MyConnection,
  Data.DB,
  Model.Vendas.Entitie;

type
  IModelVendasFactory = interface
   ['{69D89281-ACB5-4961-8B6B-DEB53097220F}']
   function DataSourceVenda(AValue: TDataSource): IModelVendasFactory;
   function DataSourceItem(AValue: TDataSource): IModelVendasFactory;
   function DataSourceItens(AValue: TDataSource): IModelVendasFactory;
   function NovaVenda: IModelVendasFactory;
   function Entitie: TModelVendasEntitie;
   procedure NovoItem(ACodProduto: string);
   procedure CalcularValores;
   procedure SalvarItem;
   procedure GravarVenda;
  end;

  TModelVendasFactory = class(TInterfacedObject, IModelVendasFactory)
  private
    FQVenda: IMyTable;
    FQItensVenda: IMyTable;
    FTBItensVenda: IMyTable;
    FDataSourceVenda: TDataSource;
    FDataSourceItemVenda: TDataSource;
    FDataSourceItensVenda: TDataSource;
    FEntitie: TModelVendasEntitie;
    FCodProduto: string;
    procedure NovaTabelaVenda;
    procedure NovaTabelaItensVenda;
    procedure ConsultarProduto;
    procedure ConsultarProdutoCodBarras(ASQL: string);
    procedure ConsultarProdutoId(ASQL: string);
    procedure PreencherDadosProduto;
    procedure FreeEntitie;
    procedure ListarItens;
  protected
    function DataSourceVenda(AValue: TDataSource): IModelVendasFactory;
    function DataSourceItem(AValue: TDataSource): IModelVendasFactory;
    function DataSourceItens(AValue: TDataSource): IModelVendasFactory;
    function NovaVenda: IModelVendasFactory;
    function Entitie: TModelVendasEntitie;
    procedure NovoItem(ACodProduto: string);
    procedure CalcularValores;
    procedure SalvarItem;
    procedure GravarVenda;
  public
    class function New: IModelVendasFactory;
    destructor Destroy; override;
  end;

implementation

uses
  MyExceptions,
  MyMessage,
  Common.Utils.MYConsts,
  Model.Logs, Utils.Types;

{$REGION 'PUBLIC'}
class function TModelVendasFactory.New: IModelVendasFactory;
begin
   Result := Self.Create;
end;

destructor TModelVendasFactory.Destroy;
begin
   Self.FreeEntitie;
   FTBItensVenda.DataSet.EmptyDataSet;
   inherited;
end;
{$ENDREGION 'PUBLIC'}

{$REGION 'PROTECTED'}
function TModelVendasFactory.DataSourceVenda(AValue: TDataSource): IModelVendasFactory;
begin
   Result := Self;
   FDataSourceVenda := AValue;
end;

function TModelVendasFactory.DataSourceItem(AValue: TDataSource): IModelVendasFactory;
begin
   Result := Self;
   FDataSourceItemVenda := AValue;
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
   Self.FreeEntitie;
   FEntitie := TModelVendasEntitie.Create;
end;

function TModelVendasFactory.Entitie: TModelVendasEntitie;
begin
   Result := FEntitie;
end;

procedure TModelVendasFactory.FreeEntitie;
begin
   if(Assigned(FEntitie))then
     FEntitie.Free;
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
   LTotal := (FQItensVenda.DataSet.FieldByName('QUANTIDADE').AsFloat *
              FQItensVenda.DataSet.FieldByName('PRECO').AsFloat)
              - FQItensVenda.DataSet.FieldByName('DESCONTO').AsFloat;

   if(LTotal <= 0)then
     LTotal := 0;

   FQItensVenda.DataSet.FieldByName('TOTAL').AsFloat := LTotal;
end;

procedure TModelVendasFactory.SalvarItem;
begin
   Self.CalcularValores;

   if(FQItensVenda.DataSet.FieldByName('TOTAL').AsFloat <= 0)then
     raise ExceptionWarning.Create('Total do item não pode ser zero');

   if(not (FQItensVenda.DataSet.State in [dsInsert, dsEdit]))then
     Exit;

   FQItensVenda.DataSet.Post;
   Self.ListarItens;
end;

procedure TModelVendasFactory.GravarVenda;
var
  LIdVenda: Integer;
begin
   FQVenda.DataSet.FieldByName('ID').AsInteger             := FEntitie.Id;
   FQVenda.DataSet.FieldByName('DATA').AsDateTime          := FEntitie.Data;
   FQVenda.DataSet.FieldByName('HORA').AsDateTime          := FEntitie.Hora;
   FQVenda.DataSet.FieldByName('ID_CLIENTE').AsInteger     := FEntitie.IdCliente;
   FQVenda.DataSet.FieldByName('NOME_CLIENTE').AsString    := FEntitie.NomeCliente;
   FQVenda.DataSet.FieldByName('FORMA_PAGAMENTO').AsString := TFormaPagamento(FEntitie.FormaPagamento).ToShortString;
   FQVenda.DataSet.FieldByName('OBSERVACAO').AsString      := FEntitie.Observacao;
   FQVenda.DataSet.Post;

   LIdVenda := FQVenda.SaveOnDatabase.LastIDCreated;

   FQItensVenda.DataSet.First;
   while(not FQItensVenda.DataSet.Eof)do
   begin
      FQItensVenda.DataSet.Edit;
      FQItensVenda.DataSet.FieldByName('ID_VENDA').AsInteger := LIdVenda;
      FQItensVenda.DataSet.Post;
      FQItensVenda.DataSet.Next;
   end;

   FQItensVenda.SaveOnDatabase;

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
   if(TFormaPagamento(FEntitie.FormaPagamento).ToShortString = TFormaPagamento.Prazo.ToShortString)then
     LTipoPreco := 'PRECO_VENDA_PRAZO';

   if(not (FQItensVenda.DataSet.State in [dsInsert, dsEdit]))then
     FQItensVenda.DataSet.Append;

   FQItensVenda.DataSet.FieldByName('ID').AsInteger             := FQItensVenda.DataSet.RecordCount + 1;
   FQItensVenda.DataSet.FieldByName('ID_PRODUTO').AsInteger     := MyQuery.FieldByName('ID').AsInteger;
   FQItensVenda.DataSet.FieldByName('NOME_PRODUTO').AsString    := MyQuery.FieldByName('NOME').AsString;
   FQItensVenda.DataSet.FieldByName('UNIDADE_PRODUTO').AsString := MyQuery.FieldByName('SIGLA').AsString;
   FQItensVenda.DataSet.FieldByName('PRECO').AsFloat            := MyQuery.FieldByName(LTipoPreco).AsFloat;
   FQItensVenda.DataSet.FieldByName('QUANTIDADE').AsFloat       := 1;
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
   FQVenda := MyMemTableNew.Open('SELECT FIRST 0 * FROM VENDAS', 'ID');

   if(Assigned(FDataSourceVenda))then
     FDataSourceVenda.DataSet := FQVenda.DataSet;

   FQVenda.DataSet.Append;
end;

procedure TModelVendasFactory.NovaTabelaItensVenda;
var
  LSql: string;
begin
   LSql := 'SELECT FIRST 0 * FROM VENDAS_ITENS';
   FQItensVenda  := MyMemTableNew.Open(LSql, 'ID');
   FTBItensVenda := MyMemTableNew.Open(LSql, 'ID');

   if(Assigned(FDataSourceItemVenda))then
     FDataSourceItemVenda.DataSet := FQItensVenda.DataSet;

   if(Assigned(FDataSourceItensVenda))then
     FDataSourceItensVenda.DataSet := FTBItensVenda.DataSet;

   TIntegerField(FQItensVenda.DataSet.FieldByName('ID_PRODUTO')).DisplayFormat := DISPLAY_FORMAT_CODIGO;
   TFloatField(FQItensVenda.DataSet.FieldByName('QUANTIDADE')).DisplayFormat   := DISPLAY_FORMAT_DECOMAIS_2;
   TFloatField(FQItensVenda.DataSet.FieldByName('PRECO')).DisplayFormat        := DISPLAY_FORMAT_DECOMAIS_2;
   TFloatField(FQItensVenda.DataSet.FieldByName('DESCONTO')).DisplayFormat     := DISPLAY_FORMAT_DECOMAIS_2;
   TFloatField(FQItensVenda.DataSet.FieldByName('TOTAL')).DisplayFormat        := DISPLAY_FORMAT_DECOMAIS_2;

   TIntegerField(FTBItensVenda.DataSet.FieldByName('ID_PRODUTO')).DisplayFormat := DISPLAY_FORMAT_CODIGO;
   TFloatField(FTBItensVenda.DataSet.FieldByName('QUANTIDADE')).DisplayFormat   := DISPLAY_FORMAT_DECOMAIS_2;
   TFloatField(FTBItensVenda.DataSet.FieldByName('PRECO')).DisplayFormat        := DISPLAY_FORMAT_DECOMAIS_2;
   TFloatField(FTBItensVenda.DataSet.FieldByName('DESCONTO')).DisplayFormat     := DISPLAY_FORMAT_DECOMAIS_2;
   TFloatField(FTBItensVenda.DataSet.FieldByName('TOTAL')).DisplayFormat        := DISPLAY_FORMAT_DECOMAIS_2;
end;

procedure TModelVendasFactory.ListarItens;
var
  I: Integer;
  LFieldName: string;
begin
   FQItensVenda.DataSet.DisableControls;
   FTBItensVenda.DataSet.DisableControls;
   try
     FTBItensVenda.DataSet.EmptyDataSet;

     FQItensVenda.DataSet.First;
     while(not FQItensVenda.DataSet.Eof)do
     begin
        FTBItensVenda.DataSet.Append;
        for I := 0 to Pred(FQItensVenda.DataSet.FieldCount) do
        begin
          LFieldName := UpperCase(FQItensVenda.DataSet.Fields[I].FieldName);
          if(FTBItensVenda.DataSet.FindField(LFieldName) <> nil)then
            FTBItensVenda.DataSet.FieldByName(LFieldName).Value := FQItensVenda.DataSet.FieldByName(LFieldName).Value;
        end;

        FTBItensVenda.DataSet.Post;
        FQItensVenda.DataSet.Next;
     end;
   finally
     FQItensVenda.DataSet.EnableControls;
     FTBItensVenda.DataSet.EnableControls;
   end;
end;
{$ENDREGION 'PRIVATE'}

end.
