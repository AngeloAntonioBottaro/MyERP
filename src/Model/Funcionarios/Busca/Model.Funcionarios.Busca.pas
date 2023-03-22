unit Model.Funcionarios.Busca;

interface

uses
  Data.DB,
  MyConnection,
  Utils.MyTypes;

type
  TModelFuncionariosBusca = class
  private
    FQueryBusca: IMyQuery;
    FTipoBusca: TTipoBuscaFuncionario;
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
    function TipoBusca(ATipoBusca: TTipoBuscaFuncionario): TModelFuncionariosBusca;
    function Inativos(AInativos: Boolean): TModelFuncionariosBusca;
    function DataSource(ADataSource: TDataSource): TModelFuncionariosBusca;
    function ConteudoBusca(AConteudoBusca: string): TModelFuncionariosBusca;
    procedure Buscar;
  end;

implementation

uses
  Utils.LibrarySistema,
  Utils.GlobalConsts;

constructor TModelFuncionariosBusca.Create;
begin
   FQueryBusca := MyQueryNew;
end;

procedure TModelFuncionariosBusca.Buscar;
begin
   if(Assigned(FDataSource))then
     FQueryBusca.DataSource(FDataSource);

   Self.GetSQLInicial;
   Self.GetSQLCondicao;
   Self.GetSQLOrderBy;
   Self.ExecutarBusca;
end;

procedure TModelFuncionariosBusca.GetSQLInicial;
begin
   FQueryBusca
    .Clear
    .Add('SELECT ')
    .Add('FUNCIONARIOS.ID, FUNCIONARIOS.RAZAO_SOCIAL, FUNCIONARIOS.NOME_FANTASIA, FUNCIONARIOS.TELEFONE, FUNCIONARIOS.CELULAR, FUNCIONARIOS.CPF, FUNCIONARIOS.CNPJ, FUNCIONARIOS.STATUS,')
    .Add('CIDADES.NOME AS NOME_CIDADE')
    .Add('FROM FUNCIONARIOS ')
    .Add('LEFT JOIN CIDADES ON(CIDADES.ID = FUNCIONARIOS.CIDADE)');
end;

procedure TModelFuncionariosBusca.GetSQLCondicao;
begin
   FQueryBusca
    .Add('WHERE');

   case(FTipoBusca)of
    TTipoBuscaFuncionario.Id: FQueryBusca.Add('(FUNCIONARIOS.ID CONTAINING :ID)').AddParam('ID', FConteudoBusca);
    TTipoBuscaFuncionario.Nome:
    begin
       FQueryBusca
        .Add('((FUNCIONARIOS.RAZAO_SOCIAL CONTAINING :NOME)or(FUNCIONARIOS.NOME_FANTASIA CONTAINING :NOME))')
        .AddParam('NOME', FConteudoBusca);
    end;
    TTipoBuscaFuncionario.CPF_CNPJ:
    begin
       FQueryBusca
        .Add('((FUNCIONARIOS.CPF CONTAINING :CPF_CNPJ)or(FUNCIONARIOS.CNPJ CONTAINING :CPF_CNPJ))')
        .AddParam('CPF_CNPJ', FConteudoBusca);
    end;
    TTipoBuscaFuncionario.Cidade: FQueryBusca.Add('(CIDADES.NOME CONTAINING :NOME_CIDADE)').AddParam('NOME_CIDADE', FConteudoBusca);
   end;

   Self.GetSQLInativos;
end;

procedure TModelFuncionariosBusca.GetSQLInativos;
begin
   if(not FInativos)then
     FQueryBusca.Add('AND(FUNCIONARIOS.STATUS = :STATUS)').AddParam('STATUS', STATUS_ATIVO);
end;

procedure TModelFuncionariosBusca.GetSQLOrderBy;
begin
   FQueryBusca.Add('ORDER BY ');
   case(FTipoBusca)of
    TTipoBuscaFuncionario.Nome: FQueryBusca.Add('RAZAO_SOCIAL, NOME_FANTASIA, ID');
    TTipoBuscaFuncionario.CPF_CNPJ: FQueryBusca.Add('CPF, CNPJ');
    TTipoBuscaFuncionario.Cidade: FQueryBusca.Add('NOME_CIDADE');
   else
     FQueryBusca.Add('ID');
   end;
end;

procedure TModelFuncionariosBusca.ExecutarBusca;
begin
   ShowDebug(FQueryBusca.SQL.Text);
   FQueryBusca.Open;
end;

function TModelFuncionariosBusca.ConteudoBusca(AConteudoBusca: string): TModelFuncionariosBusca;
begin
   Result         := Self;
   FConteudoBusca := AConteudoBusca;
end;

function TModelFuncionariosBusca.DataSource(ADataSource: TDataSource): TModelFuncionariosBusca;
begin
   Result      := Self;
   FDataSource := ADataSource;
end;

function TModelFuncionariosBusca.Inativos(AInativos: Boolean): TModelFuncionariosBusca;
begin
   Result    := Self;
   FInativos := AInativos;
end;

function TModelFuncionariosBusca.TipoBusca(ATipoBusca: TTipoBuscaFuncionario): TModelFuncionariosBusca;
begin
   Result     := Self;
   FTipoBusca := ATipoBusca;
end;

end.
