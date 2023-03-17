unit Model.Clientes.Busca;

interface

uses
  Data.DB,
  Utils.MyTypes;

type
  TModelClientesBusca = class
  private
    FTipoBusca: TTipoBuscaCliente;
    FInativos: Boolean;
    FDataSource: TDataSource;
    FConteudoBusca: string;

    procedure GetSQLInicial;
    procedure GetSQLCondicao;
    procedure GetSQLInativos;
    procedure GetSQLOrderBy;
    procedure ExecutarBusca;
  public
    function TipoBusca(ATipoBusca: TTipoBuscaCliente): TModelClientesBusca;
    function Inativos(AInativos: Boolean): TModelClientesBusca;
    function DataSource(ADataSource: TDataSource): TModelClientesBusca;
    function ConteudoBusca(AConteudoBusca: string): TModelClientesBusca;
    procedure Buscar;
  end;

implementation

uses
  MyConnection,
  Utils.LibrarySistema,
  Utils.GlobalConsts;

procedure TModelClientesBusca.Buscar;
begin
   MyQueryNew;

   if(Assigned(FDataSource))then
     MyQuery.DataSource(FDataSource);

   Self.GetSQLInicial;
   Self.GetSQLCondicao;
   Self.GetSQLOrderBy;
   Self.ExecutarBusca;
end;

procedure TModelClientesBusca.GetSQLInicial;
begin
   MyQuery
    .Add('SELECT ')
    .Add('CLIENTES.ID, CLIENTES.RAZAO_SOCIAL, CLIENTES.NOME_FANTASIA, CLIENTES.TELEFONE, CLIENTES.CELULAR, CLIENTES.CPF, CLIENTES.CNPJ, ')
    .Add('CIDADES.NOME AS NOME_CIDADE')
    .Add('FROM CLIENTES ')
    .Add('LEFT JOIN CIDADES ON(CIDADES.ID = CLIENTES.CIDADE)');
end;

procedure TModelClientesBusca.GetSQLCondicao;
begin
   MyQuery
    .Add('WHERE');

   case(FTipoBusca)of
    TTipoBuscaCliente.Id: MyQuery.Add('(CLIENTES.ID CONTAINING :ID)').AddParam('ID', FConteudoBusca);
    TTipoBuscaCliente.Nome:
    begin
       MyQuery
        .Add('((CLIENTES.RAZAO_SOCIAL CONTAINING :NOME)or(CLIENTES.NOME_FANTASIA CONTAINING :NOME))')
        .AddParam('NOME', FConteudoBusca);
    end;
    TTipoBuscaCliente.CPF_CNPJ:
    begin
       MyQuery
        .Add('((CLIENTES.CPF CONTAINING :CPF_CNPJ)or(CLIENTES.CNPJ CONTAINING :CPF_CNPJ))')
        .AddParam('CPF_CNPJ', FConteudoBusca);
    end;
    TTipoBuscaCliente.Cidade: MyQuery.Add('(CIDADES.NOME CONTAINING :NOME_CIDADE)').AddParam('NOME_CIDADE', FConteudoBusca);
   end;

   Self.GetSQLInativos;
end;

procedure TModelClientesBusca.GetSQLOrderBy;
begin
   MyQuery.Add('ORDER BY ');
   case(FTipoBusca)of
    TTipoBuscaCliente.Nome: MyQuery.Add('RAZAO_SOCIAL, NOME_FANTASIA');
    TTipoBuscaCliente.CPF_CNPJ: MyQuery.Add('CPF, CNPJ');
    TTipoBuscaCliente.Cidade: MyQuery.Add('NOME_CIDADE');
   else
     MyQuery.Add('ID');
   end;
end;

procedure TModelClientesBusca.GetSQLInativos;
begin
   if(not FInativos)then
     MyQuery.Add('AND(CLIENTES.STATUS = :STATUS)').AddParam('STATUS', STATUS_ATIVO);
end;

procedure TModelClientesBusca.ExecutarBusca;
begin
   ShowDebug(MyQuery.SQL.Text);
   MyQuery.Open;
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

end.
