unit Model.Fornecedores.Busca;

interface

uses
  System.SysUtils,
  Data.DB,
  MyConnection,
  Utils.MyTypes;

type
  TModelFornecedoresBusca = class
  private
    FQueryBusca: IMyQuery;
    FTipoBusca: TTipoBuscaFornecedor;
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
    function TipoBusca(ATipoBusca: TTipoBuscaFornecedor): TModelFornecedoresBusca;
    function Inativos(AInativos: Boolean): TModelFornecedoresBusca;
    function DataSource(ADataSource: TDataSource): TModelFornecedoresBusca;
    function ConteudoBusca(AConteudoBusca: string): TModelFornecedoresBusca;
    procedure Buscar;
  end;

implementation

uses
  Utils.MyLibrary,
  Utils.LibrarySistema,
  Utils.GlobalConsts;

constructor TModelFornecedoresBusca.Create;
begin
   FQueryBusca := MyQueryNew;
end;

procedure TModelFornecedoresBusca.Buscar;
begin
   if(Assigned(FDataSource))then
     FQueryBusca.DataSource(FDataSource);

   Self.GetSQLInicial;
   Self.GetSQLCondicao;
   Self.GetSQLOrderBy;
   Self.ExecutarBusca;
end;

procedure TModelFornecedoresBusca.GetSQLInicial;
begin
   FQueryBusca
    .Clear
    .Add('SELECT ')
    .Add('FORNECEDORES.ID, FORNECEDORES.RAZAO_SOCIAL, FORNECEDORES.NOME_FANTASIA, FORNECEDORES.TELEFONE, FORNECEDORES.CELULAR, FORNECEDORES.CPF, FORNECEDORES.CNPJ, FORNECEDORES.STATUS,')
    .Add('CIDADES.NOME AS NOME_CIDADE')
    .Add('FROM FORNECEDORES ')
    .Add('LEFT JOIN CIDADES ON(CIDADES.ID = FORNECEDORES.CIDADE)');
end;

procedure TModelFornecedoresBusca.GetSQLCondicao;
var
  LValorBusca: string;
begin
   FQueryBusca
    .Add('WHERE');

   case(FTipoBusca)of
    TTipoBuscaFornecedor.Id: FQueryBusca.Add('(FORNECEDORES.ID CONTAINING :ID)').AddParam('ID', FConteudoBusca);
    TTipoBuscaFornecedor.Nome:
    begin
       if(Length(FConteudoBusca) > 100)then
         Abort;

       FQueryBusca
        .Add('((FORNECEDORES.RAZAO_SOCIAL CONTAINING :NOME)or(FORNECEDORES.NOME_FANTASIA CONTAINING :NOME))')
        .AddParam('NOME', FConteudoBusca);
    end;
    TTipoBuscaFornecedor.CPF_CNPJ:
    begin
       LValorBusca := TMyLibrary.NumbersOnly(FConteudoBusca);

       if(Length(LValorBusca) > 14)then
         Abort;

       FQueryBusca
        .Add('((FORNECEDORES.CNPJ CONTAINING :CNPJ)')
        .AddParam('CNPJ', LValorBusca);

       if(Length(LValorBusca) <= 11)then
         FQueryBusca
          .Add('or(FORNECEDORES.CPF CONTAINING :CPF)')
          .AddParam('CPF', LValorBusca);

       FQueryBusca.Add(')');
    end;
    TTipoBuscaFornecedor.Cidade:
    begin
       if(Length(FConteudoBusca) > 60)then
         Abort;

       FQueryBusca.Add('(CIDADES.NOME CONTAINING :NOME_CIDADE)').AddParam('NOME_CIDADE', FConteudoBusca);
    end;
   end;

   Self.GetSQLInativos;
end;

procedure TModelFornecedoresBusca.GetSQLInativos;
begin
   if(not FInativos)then
     FQueryBusca.Add('AND(FORNECEDORES.STATUS = :STATUS)').AddParam('STATUS', STATUS_ATIVO);
end;

procedure TModelFornecedoresBusca.GetSQLOrderBy;
begin
   FQueryBusca.Add('ORDER BY ');
   case(FTipoBusca)of
    TTipoBuscaFornecedor.Nome: FQueryBusca.Add('RAZAO_SOCIAL, NOME_FANTASIA, ID');
    TTipoBuscaFornecedor.CPF_CNPJ: FQueryBusca.Add('CPF, CNPJ');
    TTipoBuscaFornecedor.Cidade: FQueryBusca.Add('NOME_CIDADE');
   else
     FQueryBusca.Add('ID');
   end;
end;

procedure TModelFornecedoresBusca.ExecutarBusca;
begin
   ShowDebug(FQueryBusca.SQL.Text);
   FQueryBusca.Open;
end;

function TModelFornecedoresBusca.ConteudoBusca(AConteudoBusca: string): TModelFornecedoresBusca;
begin
   Result         := Self;
   FConteudoBusca := AConteudoBusca;
end;

function TModelFornecedoresBusca.DataSource(ADataSource: TDataSource): TModelFornecedoresBusca;
begin
   Result      := Self;
   FDataSource := ADataSource;
end;

function TModelFornecedoresBusca.Inativos(AInativos: Boolean): TModelFornecedoresBusca;
begin
   Result    := Self;
   FInativos := AInativos;
end;

function TModelFornecedoresBusca.TipoBusca(ATipoBusca: TTipoBuscaFornecedor): TModelFornecedoresBusca;
begin
   Result     := Self;
   FTipoBusca := ATipoBusca;
end;

end.
