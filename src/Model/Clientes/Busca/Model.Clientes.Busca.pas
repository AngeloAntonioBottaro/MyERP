unit Model.Clientes.Busca;

interface

uses
  System.SysUtils,
  Data.DB,
  MyConnection,
  Utils.Types;

type
  TModelClientesBusca = class
  private
    FQueryBusca: IMyQuery;
    FTipoBusca: TTipoBuscaCliente;
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
    function TipoBusca(ATipoBusca: TTipoBuscaCliente): TModelClientesBusca;
    function Inativos(AInativos: Boolean): TModelClientesBusca;
    function DataSource(ADataSource: TDataSource): TModelClientesBusca;
    function ConteudoBusca(AConteudoBusca: string): TModelClientesBusca;
    function IndexFieldNames(AIndex: string): TModelClientesBusca;
    procedure Buscar;
  end;

implementation

uses
  Common.Utils.MyConsts,
  Common.Utils.MyLibrary,
  Utils.LibrarySistema,
  Utils.GlobalConsts;

constructor TModelClientesBusca.Create;
begin
   FQueryBusca := MyQueryNew;
end;

procedure TModelClientesBusca.Buscar;
begin
   if(Assigned(FDataSource))then
     FQueryBusca.DataSource(FDataSource);

   Self.GetSQLInicial;
   Self.GetSQLCondicao;
   Self.GetSQLOrderBy;
   Self.ExecutarBusca;
end;

procedure TModelClientesBusca.GetSQLInicial;
begin
   FQueryBusca
    .Clear
    .Add('SELECT ')
    .Add('CLIENTES.ID, CLIENTES.RAZAO_SOCIAL, CLIENTES.NOME_FANTASIA, CLIENTES.TELEFONE, CLIENTES.CELULAR, ')
    .Add('CLIENTES.CPF, CLIENTES.CNPJ, CLIENTES.STATUS, ')
    .Add('CIDADES.NOME AS NOME_CIDADE')
    .Add('FROM CLIENTES ')
    .Add('LEFT JOIN CIDADES ON(CIDADES.ID = CLIENTES.ID_CIDADE)');
end;

procedure TModelClientesBusca.GetSQLCondicao;
var
  LValorBusca: string;
begin
   FQueryBusca
    .Add('WHERE');

   case(FTipoBusca)of
    TTipoBuscaCliente.Id: FQueryBusca.Add('(CLIENTES.ID CONTAINING :ID)').AddParam('ID', FConteudoBusca);
    TTipoBuscaCliente.Nome:
    begin
       if(Length(FConteudoBusca) > 100)then
         Abort;

       FQueryBusca
        .Add('((CLIENTES.RAZAO_SOCIAL CONTAINING :NOME)or(CLIENTES.NOME_FANTASIA CONTAINING :NOME))')
        .AddParam('NOME', FConteudoBusca);
    end;
    TTipoBuscaCliente.CPF_CNPJ:
    begin
       LValorBusca := TMyLibrary.NumbersOnly(FConteudoBusca);

       if(Length(LValorBusca) > 14)then
         Abort;

       FQueryBusca
        .Add('((CLIENTES.CNPJ CONTAINING :CNPJ)')
        .AddParam('CNPJ', LValorBusca);

       if(Length(LValorBusca) <= 11)then
         FQueryBusca
          .Add('or(CLIENTES.CPF CONTAINING :CPF)')
          .AddParam('CPF', LValorBusca);

       FQueryBusca.Add(')');
    end;
    TTipoBuscaCliente.Cidade:
    begin
       if(Length(FConteudoBusca) > 60)then
         Abort;

       FQueryBusca.Add('(CIDADES.NOME CONTAINING :NOME_CIDADE)').AddParam('NOME_CIDADE', FConteudoBusca);
    end;
   else
     Abort;
   end;

   Self.GetSQLInativos;
end;

procedure TModelClientesBusca.GetSQLInativos;
begin
   if(not FInativos)then
     FQueryBusca.Add('AND(CLIENTES.STATUS = :STATUS)').AddParam('STATUS', STATUS_ATIVO);
end;

procedure TModelClientesBusca.GetSQLOrderBy;
begin
   FQueryBusca.Add('ORDER BY ');
   case(FTipoBusca)of
    TTipoBuscaCliente.Nome: FQueryBusca.Add('RAZAO_SOCIAL, NOME_FANTASIA, ID');
    TTipoBuscaCliente.CPF_CNPJ: FQueryBusca.Add('CPF, CNPJ');
    TTipoBuscaCliente.Cidade: FQueryBusca.Add('NOME_CIDADE');
   else
     FQueryBusca.Add('ID');
   end;
end;

procedure TModelClientesBusca.ExecutarBusca;
begin
   ShowDebug(FQueryBusca.SQL.Text);
   FQueryBusca.Open;
   Self.ConfFieldsMask;
end;

procedure TModelClientesBusca.ConfFieldsMask;
begin
   FQueryBusca
    .DisplayFormat('ID', DISPLAY_FORMAT_CODIGO);
end;

function TModelClientesBusca.ConteudoBusca(AConteudoBusca: string): TModelClientesBusca;
begin
   Result         := Self;
   FConteudoBusca := AConteudoBusca;
end;

function TModelClientesBusca.DataSource(ADataSource: TDataSource): TModelClientesBusca;
begin
   Result      := Self;
   FDataSource := ADataSource;
end;

function TModelClientesBusca.Inativos(AInativos: Boolean): TModelClientesBusca;
begin
   Result    := Self;
   FInativos := AInativos;
end;

function TModelClientesBusca.TipoBusca(ATipoBusca: TTipoBuscaCliente): TModelClientesBusca;
begin
   Result     := Self;
   FTipoBusca := ATipoBusca;
end;

function TModelClientesBusca.IndexFieldNames(AIndex: string): TModelClientesBusca;
begin
   Result := Self;
   FQueryBusca.IndexFieldNames(AIndex);
   Self.Buscar;
end;

end.
