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
  public
    constructor Create;
    function TipoBusca(ATipoBusca: TTipoBuscaProduto): TModelProdutosBusca;
    function Inativos(AInativos: Boolean): TModelProdutosBusca;
    function DataSource(ADataSource: TDataSource): TModelProdutosBusca;
    function ConteudoBusca(AConteudoBusca: string): TModelProdutosBusca;
    procedure Buscar;
  end;

implementation

uses
  Utils.MyLibrary,
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
    .Add('PRODUTOS.ID, PRODUTOS.NOME, PRODUTOS.CUSTO, PRODUTOS.PRECO_VENDA_VISTA, PRODUTOS.PRECO_VENDA_PRAZO, PRODUTOS.SUBGRUPO,')
    .Add('FROM PRODUTOS ');
end;

procedure TModelProdutosBusca.GetSQLCondicao;
begin
   FQueryBusca
    .Add('WHERE');

   case(FTipoBusca)of
    TTipoBuscaProduto.Id: FQueryBusca.Add('(PRODUTOS.ID CONTAINING :ID)').AddParam('ID', FConteudoBusca);
    TTipoBuscaProduto.Nome:
    begin
       if(Length(FConteudoBusca) > 50)then
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

end.
