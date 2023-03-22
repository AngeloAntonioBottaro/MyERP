unit Model.Produtos.SubGrupos.Busca;

interface

uses
  Data.DB,
  MyConnection,
  Utils.MyTypes;

type
  TModelProdutosSubGruposBusca = class
  private
    FQueryBusca: IMyQuery;
    FTipoBusca: TTipoBuscaProdutoSubGrupo;
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
    function TipoBusca(ATipoBusca: TTipoBuscaProdutoSubGrupo): TModelProdutosSubGruposBusca;
    function Inativos(AInativos: Boolean): TModelProdutosSubGruposBusca;
    function DataSource(ADataSource: TDataSource): TModelProdutosSubGruposBusca;
    function ConteudoBusca(AConteudoBusca: string): TModelProdutosSubGruposBusca;
    procedure Buscar;
  end;

implementation

uses
  Utils.LibrarySistema,
  Utils.GlobalConsts;

constructor TModelProdutosSubGruposBusca.Create;
begin
   FQueryBusca := MyQueryNew;
end;

procedure TModelProdutosSubGruposBusca.Buscar;
begin
   if(Assigned(FDataSource))then
     FQueryBusca.DataSource(FDataSource);

   Self.GetSQLInicial;
   Self.GetSQLCondicao;
   Self.GetSQLOrderBy;
   Self.ExecutarBusca;
end;

procedure TModelProdutosSubGruposBusca.GetSQLInicial;
begin
   FQueryBusca
    .Clear
    .Add('SELECT ')
    .Add('PRODUTOS_SUBGRUPOS.ID, PRODUTOS_SUBGRUPOS.SUBGRUPO, PRODUTOS_SUBGRUPOS.GRUPO')
    .Add('PRODUTOS_GRUPOS.GRUPO AS NOME_GRUPO')
    .Add('FROM PRODUTOS_GRUPOS ')
    .Add('LEFT JOIN PRODUTOS_GRUPOS ON(PRODUTOS_GRUPOS.ID = PRODUTOS_SUBGRUPOS.GRUPO)');
end;

procedure TModelProdutosSubGruposBusca.GetSQLCondicao;
begin
   FQueryBusca
    .Add('WHERE');

   case(FTipoBusca)of
    TTipoBuscaProdutoSubGrupo.Id: FQueryBusca.Add('(PRODUTOS_SUBGRUPOS.ID CONTAINING :ID)').AddParam('ID', FConteudoBusca);
    TTipoBuscaProdutoSubGrupo.Nome: FQueryBusca.Add('(PRODUTOS_SUBGRUPOS.SUBGRUPO CONTAINING :NOME)').AddParam('NOME', FConteudoBusca);
    TTipoBuscaProdutoSubGrupo.GrupoId: FQueryBusca.Add('(PRODUTOS_SUBGRUPOS.GRUPO CONTAINING :NOME)').AddParam('NOME', FConteudoBusca);
    TTipoBuscaProdutoSubGrupo.GrupoNome: FQueryBusca.Add('(PRODUTOS_GRUPOS.GRUPO CONTAINING :NOME)').AddParam('NOME', FConteudoBusca);
   end;

   Self.GetSQLInativos;
end;

procedure TModelProdutosSubGruposBusca.GetSQLInativos;
begin
   if(not FInativos)then
     FQueryBusca.Add('AND(PRODUTOS_SUBGRUPOS.STATUS = :STATUS)').AddParam('STATUS', STATUS_ATIVO);
end;

procedure TModelProdutosSubGruposBusca.GetSQLOrderBy;
begin
   FQueryBusca.Add('ORDER BY ');
   case(FTipoBusca)of
    TTipoBuscaProdutoSubGrupo.Nome: FQueryBusca.Add('SUBGRUPO');
    TTipoBuscaProdutoSubGrupo.GrupoId: FQueryBusca.Add('GRUPO');
    TTipoBuscaProdutoSubGrupo.GrupoNome: FQueryBusca.Add('NOME_GRUPO');
   else
     FQueryBusca.Add('ID');
   end;
end;

procedure TModelProdutosSubGruposBusca.ExecutarBusca;
begin
   ShowDebug(FQueryBusca.SQL.Text);
   FQueryBusca.Open;
end;

function TModelProdutosSubGruposBusca.ConteudoBusca(AConteudoBusca: string): TModelProdutosSubGruposBusca;
begin
   Result         := Self;
   FConteudoBusca := AConteudoBusca;
end;

function TModelProdutosSubGruposBusca.DataSource(ADataSource: TDataSource): TModelProdutosSubGruposBusca;
begin
   Result      := Self;
   FDataSource := ADataSource;
end;

function TModelProdutosSubGruposBusca.Inativos(AInativos: Boolean): TModelProdutosSubGruposBusca;
begin
   Result    := Self;
   FInativos := AInativos;
end;

function TModelProdutosSubGruposBusca.TipoBusca(ATipoBusca: TTipoBuscaProdutoSubGrupo): TModelProdutosSubGruposBusca;
begin
   Result     := Self;
   FTipoBusca := ATipoBusca;
end;

end.
