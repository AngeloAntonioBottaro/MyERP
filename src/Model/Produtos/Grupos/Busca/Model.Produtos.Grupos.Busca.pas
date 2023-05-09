unit Model.Produtos.Grupos.Busca;

interface

uses
  System.SysUtils,
  Data.DB,
  MyConnection,
  Utils.Types;

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
    procedure ConfFieldsMask;
  public
    constructor Create;
    function TipoBusca(ATipoBusca: TTipoBuscaProdutoGrupo): TModelProdutosGruposBusca;
    function Inativos(AInativos: Boolean): TModelProdutosGruposBusca;
    function DataSource(ADataSource: TDataSource): TModelProdutosGruposBusca;
    function ConteudoBusca(AConteudoBusca: string): TModelProdutosGruposBusca;
    function IndexFieldNames(AIndex: string): TModelProdutosGruposBusca;
    procedure Buscar;
  end;

implementation

uses
  Common.Utils.MyConsts,
  Utils.LibrarySistema;

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
    .Add('PRODUTOS_GRUPOS.ID, PRODUTOS_GRUPOS.NOME')
    .Add('FROM PRODUTOS_GRUPOS ');
end;

procedure TModelProdutosGruposBusca.GetSQLCondicao;
begin
   FQueryBusca
    .Add('WHERE');

   case(FTipoBusca)of
    TTipoBuscaProdutoGrupo.Id: FQueryBusca.Add('(PRODUTOS_GRUPOS.ID CONTAINING :ID)').AddParam('ID', FConteudoBusca);
    TTipoBuscaProdutoGrupo.Nome:
    begin
       if(Length(FConteudoBusca) > 50)then
         Abort;

       FQueryBusca.Add('(PRODUTOS_GRUPOS.NOME CONTAINING :NOME)').AddParam('NOME', FConteudoBusca);
    end;
   else
    Abort;
   end;

   Self.GetSQLInativos;
end;

procedure TModelProdutosGruposBusca.GetSQLInativos;
begin
   //
end;

procedure TModelProdutosGruposBusca.GetSQLOrderBy;
begin
   FQueryBusca.Add('ORDER BY ');
   case(FTipoBusca)of
    TTipoBuscaProdutoGrupo.Nome: FQueryBusca.Add('NOME');
   else
     FQueryBusca.Add('ID');
   end;
end;

procedure TModelProdutosGruposBusca.ExecutarBusca;
begin
   ShowDebug(FQueryBusca.SQL.Text);
   FQueryBusca.Open;
   Self.ConfFieldsMask;
end;

procedure TModelProdutosGruposBusca.ConfFieldsMask;
begin
   FQueryBusca
    .DisplayFormat('ID', DISPLAY_FORMAT_CODIGO);
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

function TModelProdutosGruposBusca.IndexFieldNames(AIndex: string): TModelProdutosGruposBusca;
begin
   Result := Self;
   FQueryBusca.IndexFieldNames(AIndex);
   Self.Buscar;
end;

end.
