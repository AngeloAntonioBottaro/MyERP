unit Model.Produtos.SubGrupos.Busca;

interface

uses
  System.SysUtils,
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
    procedure ConfFieldsMask;
  public
    constructor Create;
    function TipoBusca(ATipoBusca: TTipoBuscaProdutoSubGrupo): TModelProdutosSubGruposBusca;
    function Inativos(AInativos: Boolean): TModelProdutosSubGruposBusca;
    function DataSource(ADataSource: TDataSource): TModelProdutosSubGruposBusca;
    function ConteudoBusca(AConteudoBusca: string): TModelProdutosSubGruposBusca;
    function IndexFieldNames(AIndex: string): TModelProdutosSubGruposBusca;
    procedure Buscar;
  end;

implementation

uses
  Utils.MyConsts,
  Utils.LibrarySistema;

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
    .Add('PRODUTOS_SUBGRUPOS.ID, PRODUTOS_SUBGRUPOS.NOME, PRODUTOS_SUBGRUPOS.GRUPO,')
    .Add('PRODUTOS_GRUPOS.NOME AS NOME_GRUPO')
    .Add('FROM PRODUTOS_SUBGRUPOS ')
    .Add('LEFT JOIN PRODUTOS_GRUPOS ON(PRODUTOS_GRUPOS.ID = PRODUTOS_SUBGRUPOS.GRUPO)');
end;

procedure TModelProdutosSubGruposBusca.GetSQLCondicao;
begin
   FQueryBusca
    .Add('WHERE');

   case(FTipoBusca)of
    TTipoBuscaProdutoSubGrupo.Id: FQueryBusca.Add('(PRODUTOS_SUBGRUPOS.ID CONTAINING :ID)').AddParam('ID', FConteudoBusca);
    TTipoBuscaProdutoSubGrupo.Nome:
    begin
       if(Length(FConteudoBusca) > 50)then
         Abort;

       FQueryBusca.Add('(PRODUTOS_SUBGRUPOS.NOME CONTAINING :NOME)').AddParam('NOME', FConteudoBusca);
    end;
    TTipoBuscaProdutoSubGrupo.GrupoId: FQueryBusca.Add('(PRODUTOS_SUBGRUPOS.GRUPO CONTAINING :GRUPO)').AddParam('GRUPO', FConteudoBusca);
    TTipoBuscaProdutoSubGrupo.GrupoNome:
    begin
       if(Length(FConteudoBusca) > 50)then
         Abort;

       FQueryBusca.Add('(PRODUTOS_GRUPOS.NOME CONTAINING :GRUPO)').AddParam('GRUPO', FConteudoBusca);
    end
   else
    Abort;
   end;

   Self.GetSQLInativos;
end;

procedure TModelProdutosSubGruposBusca.GetSQLInativos;
begin
   //
end;

procedure TModelProdutosSubGruposBusca.GetSQLOrderBy;
begin
   FQueryBusca.Add('ORDER BY ');
   case(FTipoBusca)of
    TTipoBuscaProdutoSubGrupo.Nome: FQueryBusca.Add('NOME');
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
   Self.ConfFieldsMask;
end;

procedure TModelProdutosSubGruposBusca.ConfFieldsMask;
begin
   FQueryBusca
    .DisplayFormat('ID', DISPLAY_FORMAT_CODIGO)
    .DisplayFormat('GRUPO', DISPLAY_FORMAT_CODIGO);
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

function TModelProdutosSubGruposBusca.IndexFieldNames(AIndex: string): TModelProdutosSubGruposBusca;
begin
   Result := Self;
   FQueryBusca.IndexFieldNames(AIndex);
   Self.Buscar;
end;

end.
