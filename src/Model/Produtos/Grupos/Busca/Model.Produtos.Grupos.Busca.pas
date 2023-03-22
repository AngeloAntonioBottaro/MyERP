unit Model.Produtos.Grupos.Busca;

interface

uses
  Data.DB,
  MyConnection,
  Utils.MyTypes;

type
  TModelProdutosGruposBusca = class
  private
    FQueryBusca: IMyQuery;
    FTipoBusca: TTipoBuscaProdutoGrupo;
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
    function TipoBusca(ATipoBusca: TTipoBuscaProdutoGrupo): TModelProdutosGruposBusca;
    function Inativos(AInativos: Boolean): TModelProdutosGruposBusca;
    function DataSource(ADataSource: TDataSource): TModelProdutosGruposBusca;
    function ConteudoBusca(AConteudoBusca: string): TModelProdutosGruposBusca;
    procedure Buscar;
  end;

implementation

uses
  Utils.LibrarySistema,
  Utils.GlobalConsts;

constructor TModelProdutosGruposBusca.Create;
begin
   FQueryBusca := MyQueryNew;
end;

procedure TModelProdutosGruposBusca.Buscar;
begin
   if(Assigned(FDataSource))then
     FQueryBusca.DataSource(FDataSource);

   Self.GetSQLInicial;
   Self.GetSQLCondicao;
   Self.GetSQLOrderBy;
   Self.ExecutarBusca;
end;

procedure TModelProdutosGruposBusca.GetSQLInicial;
begin
   FQueryBusca
    .Clear
    .Add('SELECT ')
    .Add('PRODUTOS_GRUPOS.ID, PRODUTOS_GRUPOS.GRUPO')
    .Add('FROM PRODUTOS_GRUPOS ');
end;

procedure TModelProdutosGruposBusca.GetSQLCondicao;
begin
   FQueryBusca
    .Add('WHERE');

   case(FTipoBusca)of
    TTipoBuscaFuncionarioFuncao.Id: FQueryBusca.Add('(PRODUTOS_GRUPOS.ID CONTAINING :ID)').AddParam('ID', FConteudoBusca);
    TTipoBuscaFuncionarioFuncao.Nome: FQueryBusca.Add('(PRODUTOS_GRUPOS.GRUPO CONTAINING :NOME)').AddParam('NOME', FConteudoBusca);
   end;

   Self.GetSQLInativos;
end;

procedure TModelProdutosGruposBusca.GetSQLInativos;
begin
   if(not FInativos)then
     FQueryBusca.Add('AND(PRODUTOS_GRUPOS.STATUS = :STATUS)').AddParam('STATUS', STATUS_ATIVO);
end;

procedure TModelProdutosGruposBusca.GetSQLOrderBy;
begin
   FQueryBusca.Add('ORDER BY ');
   case(FTipoBusca)of
    TTipoBuscaProdutoGrupo.Nome: FQueryBusca.Add('GRUPO');
   else
     FQueryBusca.Add('ID');
   end;
end;

procedure TModelProdutosGruposBusca.ExecutarBusca;
begin
   ShowDebug(FQueryBusca.SQL.Text);
   FQueryBusca.Open;
end;

function TModelProdutosGruposBusca.ConteudoBusca(AConteudoBusca: string): TModelProdutosGruposBusca;
begin
   Result         := Self;
   FConteudoBusca := AConteudoBusca;
end;

function TModelProdutosGruposBusca.DataSource(ADataSource: TDataSource): TModelProdutosGruposBusca;
begin
   Result      := Self;
   FDataSource := ADataSource;
end;

function TModelProdutosGruposBusca.Inativos(AInativos: Boolean): TModelProdutosGruposBusca;
begin
   Result    := Self;
   FInativos := AInativos;
end;

function TModelProdutosGruposBusca.TipoBusca(ATipoBusca: TTipoBuscaProdutoGrupo): TModelProdutosGruposBusca;
begin
   Result     := Self;
   FTipoBusca := ATipoBusca;
end;

end.
