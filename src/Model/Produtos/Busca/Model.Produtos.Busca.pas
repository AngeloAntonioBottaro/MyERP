unit Model.Produtos.Busca;

interface

uses
  System.SysUtils,
  Data.DB,
  MyConnection,
  Utils.MyTypes;

type
  TModelProdutosBusca = class
  private
    FQueryBusca: IMyQuery;
    FTipoBusca: TTipoBuscaProduto;
    FInativos: Boolean;
    FDataSource: TDataSource;
    FConteudoBusca: string;

    procedure GetSQLInicial;
    procedure GetSQLCondicao;
    procedure GetSQLInativos;
    procedure GetSQLOrderBy;
    procedure ExecutarBusca;
    procedure ConfFieldsMask;
  public
    constructor Create;
    function TipoBusca(ATipoBusca: TTipoBuscaProduto): TModelProdutosBusca;
    function Inativos(AInativos: Boolean): TModelProdutosBusca;
    function DataSource(ADataSource: TDataSource): TModelProdutosBusca;
    function ConteudoBusca(AConteudoBusca: string): TModelProdutosBusca;
    function IndexFieldNames(AIndex: string): TModelProdutosBusca;
    procedure Buscar;
  end;

implementation

uses
  Utils.MyLibrary,
  Utils.MyConsts,
  Utils.LibrarySistema,
  Utils.GlobalConsts;

constructor TModelProdutosBusca.Create;
begin
   FQueryBusca := MyQueryNew;
end;

procedure TModelProdutosBusca.Buscar;
begin
   if(Assigned(FDataSource))then
     FQueryBusca.DataSource(FDataSource);

   Self.GetSQLInicial;
   Self.GetSQLCondicao;
   Self.GetSQLOrderBy;
   Self.ExecutarBusca;
end;

procedure TModelProdutosBusca.GetSQLInicial;
begin
   FQueryBusca
    .Clear
    .Add('SELECT ')
    .Add('PRODUTOS.ID, PRODUTOS.NOME, PRODUTOS.CUSTO, PRODUTOS.PRECO_VENDA_VISTA, PRODUTOS.PRECO_VENDA_PRAZO, PRODUTOS.ESTOQUE, PRODUTOS.STATUS,')
    .Add('PRODUTOS_GRUPOS.NOME AS NOME_GRUPO,')
    .Add('PRODUTOS_SUBGRUPOS.NOME AS NOME_SUBGRUPO')
    .Add('FROM PRODUTOS ')
    .Add('LEFT JOIN PRODUTOS_SUBGRUPOS ON(PRODUTOS_SUBGRUPOS.ID = PRODUTOS.SUBGRUPO)')
    .Add('LEFT JOIN PRODUTOS_GRUPOS ON(PRODUTOS_GRUPOS.ID = PRODUTOS_SUBGRUPOS.GRUPO)');
end;

procedure TModelProdutosBusca.GetSQLCondicao;
begin
   FQueryBusca
    .Add('WHERE');

   case(FTipoBusca)of
    TTipoBuscaProduto.Id: FQueryBusca.Add('(PRODUTOS.ID CONTAINING :ID)').AddParam('ID', FConteudoBusca);
    TTipoBuscaProduto.Nome:
    begin
       if(Length(FConteudoBusca) > 80)then
         Abort;

       FQueryBusca.Add('(PRODUTOS.NOME CONTAINING :NOME)').AddParam('NOME', FConteudoBusca);
    end;
   else
    Abort;
   end;

   Self.GetSQLInativos;
end;

procedure TModelProdutosBusca.GetSQLInativos;
begin
   if(not FInativos)then
     FQueryBusca.Add('AND(PRODUTOS.STATUS = :STATUS)').AddParam('STATUS', STATUS_ATIVO);
end;

procedure TModelProdutosBusca.GetSQLOrderBy;
begin
   FQueryBusca.Add('ORDER BY ');
   case(FTipoBusca)of
    TTipoBuscaProduto.Nome: FQueryBusca.Add('NOME');
   else
     FQueryBusca.Add('ID');
   end;
end;

procedure TModelProdutosBusca.ExecutarBusca;
begin
   ShowDebug(FQueryBusca.SQL.Text);
   FQueryBusca.Open;
   Self.ConfFieldsMask;
end;

procedure TModelProdutosBusca.ConfFieldsMask;
begin
   FQueryBusca
    .DisplayFormat('ID', DISPLAY_FORMAT_CODIGO)
    .DisplayFormat('CUSTO', DISPLAY_FORMAT_DOUBLE)
    .DisplayFormat('PRECO_VENDA_VISTA', DISPLAY_FORMAT_DOUBLE)
    .DisplayFormat('PRECO_VENDA_PRAZO', DISPLAY_FORMAT_DOUBLE)
    .DisplayFormat('ESTOQUE', DISPLAY_FORMAT_DOUBLE);
end;

function TModelProdutosBusca.ConteudoBusca(AConteudoBusca: string): TModelProdutosBusca;
begin
   Result         := Self;
   FConteudoBusca := AConteudoBusca;
end;

function TModelProdutosBusca.DataSource(ADataSource: TDataSource): TModelProdutosBusca;
begin
   Result      := Self;
   FDataSource := ADataSource;
end;

function TModelProdutosBusca.Inativos(AInativos: Boolean): TModelProdutosBusca;
begin
   Result    := Self;
   FInativos := AInativos;
end;

function TModelProdutosBusca.TipoBusca(ATipoBusca: TTipoBuscaProduto): TModelProdutosBusca;
begin
   Result     := Self;
   FTipoBusca := ATipoBusca;
end;

function TModelProdutosBusca.IndexFieldNames(AIndex: string): TModelProdutosBusca;
begin
   Result := Self;
   FQueryBusca.IndexFieldNames(AIndex);
   Self.Buscar;
end;

end.
