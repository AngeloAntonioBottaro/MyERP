unit Model.Produtos.Unidades.Busca;

interface

uses
  System.SysUtils,
  Data.DB,
  MyConnection,
  Utils.Types;

type
  TModelProdutosUnidadesBusca = class
  private
    FQueryBusca: IMyQuery;
    FTipoBusca: TTipoBuscaProdutoUnidade;
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
    function TipoBusca(ATipoBusca: TTipoBuscaProdutoUnidade): TModelProdutosUnidadesBusca;
    function Inativos(AInativos: Boolean): TModelProdutosUnidadesBusca;
    function DataSource(ADataSource: TDataSource): TModelProdutosUnidadesBusca;
    function ConteudoBusca(AConteudoBusca: string): TModelProdutosUnidadesBusca;
    function IndexFieldNames(AIndex: string): TModelProdutosUnidadesBusca;
    procedure Buscar;
  end;

implementation

uses
  Utils.MyConsts,
  Utils.LibrarySistema;

constructor TModelProdutosUnidadesBusca.Create;
begin
   FQueryBusca := MyQueryNew;
end;

procedure TModelProdutosUnidadesBusca.Buscar;
begin
   if(Assigned(FDataSource))then
     FQueryBusca.DataSource(FDataSource);

   Self.GetSQLInicial;
   Self.GetSQLCondicao;
   Self.GetSQLOrderBy;
   Self.ExecutarBusca;
end;

procedure TModelProdutosUnidadesBusca.GetSQLInicial;
begin
   FQueryBusca
    .Clear
    .Add('SELECT ')
    .Add('PRODUTOS_UNIDADES.ID, PRODUTOS_UNIDADES.NOME, PRODUTOS_UNIDADES.SIGLA')
    .Add('FROM PRODUTOS_UNIDADES ');
end;

procedure TModelProdutosUnidadesBusca.GetSQLCondicao;
begin
   FQueryBusca
    .Add('WHERE');

   case(FTipoBusca)of
    TTipoBuscaProdutoUnidade.Id: FQueryBusca.Add('(PRODUTOS_UNIDADES.ID CONTAINING :ID)').AddParam('ID', FConteudoBusca);
    TTipoBuscaProdutoUnidade.Nome:
    begin
       if(Length(FConteudoBusca) > 30)then
         Abort;

       FQueryBusca.Add('(PRODUTOS_UNIDADES.NOME CONTAINING :NOME)').AddParam('NOME', FConteudoBusca);
    end;
    TTipoBuscaProdutoUnidade.Sigla:
    begin
       if(Length(FConteudoBusca) > 3)then
         Abort;

       FQueryBusca.Add('(PRODUTOS_UNIDADES.SIGLA CONTAINING :SIGLA)').AddParam('SIGLA', FConteudoBusca);
    end;
   else
    Abort;
   end;

   Self.GetSQLInativos;
end;

procedure TModelProdutosUnidadesBusca.GetSQLInativos;
begin
   //
end;

procedure TModelProdutosUnidadesBusca.GetSQLOrderBy;
begin
   FQueryBusca.Add('ORDER BY ');
   case(FTipoBusca)of
    TTipoBuscaProdutoUnidade.Nome: FQueryBusca.Add('NOME');
    TTipoBuscaProdutoUnidade.Sigla: FQueryBusca.Add('SIGLA');
   else
     FQueryBusca.Add('ID');
   end;
end;

procedure TModelProdutosUnidadesBusca.ExecutarBusca;
begin
   ShowDebug(FQueryBusca.SQL.Text);
   FQueryBusca.Open;
   Self.ConfFieldsMask;
end;

procedure TModelProdutosUnidadesBusca.ConfFieldsMask;
begin
   FQueryBusca
    .DisplayFormat('ID', DISPLAY_FORMAT_CODIGO);
end;

function TModelProdutosUnidadesBusca.ConteudoBusca(AConteudoBusca: string): TModelProdutosUnidadesBusca;
begin
   Result         := Self;
   FConteudoBusca := AConteudoBusca;
end;

function TModelProdutosUnidadesBusca.DataSource(ADataSource: TDataSource): TModelProdutosUnidadesBusca;
begin
   Result      := Self;
   FDataSource := ADataSource;
end;

function TModelProdutosUnidadesBusca.Inativos(AInativos: Boolean): TModelProdutosUnidadesBusca;
begin
   Result    := Self;
   FInativos := AInativos;
end;

function TModelProdutosUnidadesBusca.TipoBusca(ATipoBusca: TTipoBuscaProdutoUnidade): TModelProdutosUnidadesBusca;
begin
   Result     := Self;
   FTipoBusca := ATipoBusca;
end;

function TModelProdutosUnidadesBusca.IndexFieldNames(AIndex: string): TModelProdutosUnidadesBusca;
begin
   Result := Self;
   FQueryBusca.IndexFieldNames(AIndex);
   Self.Buscar;
end;

end.

