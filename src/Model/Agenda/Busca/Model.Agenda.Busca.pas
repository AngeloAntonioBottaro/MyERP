unit Model.Agenda.Busca;

interface

uses
  System.SysUtils,
  Data.DB,
  MyConnection,
  Utils.MyTypes;

type
  TModelAgendaBusca = class
  private
    FQueryBusca: IMyQuery;
    FTipoBusca: TTipoBuscaAgenda;
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
    function TipoBusca(ATipoBusca: TTipoBuscaAgenda): TModelAgendaBusca;
    function Inativos(AInativos: Boolean): TModelAgendaBusca;
    function DataSource(ADataSource: TDataSource): TModelAgendaBusca;
    function ConteudoBusca(AConteudoBusca: string): TModelAgendaBusca;
    function IndexFieldNames(AIndex: string): TModelAgendaBusca;
    procedure Buscar;
  end;

implementation

uses
  Utils.MyConsts,
  Utils.LibrarySistema;

constructor TModelAgendaBusca.Create;
begin
   FQueryBusca := MyQueryNew;
end;

procedure TModelAgendaBusca.Buscar;
begin
   if(Assigned(FDataSource))then
     FQueryBusca.DataSource(FDataSource);

   Self.GetSQLInicial;
   Self.GetSQLCondicao;
   Self.GetSQLOrderBy;
   Self.ExecutarBusca;
end;

procedure TModelAgendaBusca.GetSQLInicial;
begin
   FQueryBusca
    .Clear
    .Add('SELECT ')
    .Add('AGENDA.ID, AGENDA.CLIENTE, AGENDA.FUNCIONARIO, AGENDA.STATUS, AGENDA.DATA, AGENDA.HORA,')
    .Add('CLIENTES.NOME_FANTASIA AS CLIENTE_NOME,')
    .Add('FUNCIONARIOS.NOME_FANTASIA AS FUNCIONARIO_NOME')
    .Add('FROM AGENDA ')
    .Add('LEFT JOIN CLIENTES ON (CLIENTES.ID = AGENDA.CLIENTE)')
    .Add('LEFT JOIN FUNCIONARIOS ON (FUNCIONARIOS.ID = AGENDA.FUNCIONARIO)');
end;

procedure TModelAgendaBusca.GetSQLCondicao;
begin
   FQueryBusca
    .Add('WHERE');

   case(FTipoBusca)of
    TTipoBuscaAgenda.Id: FQueryBusca.Add('(AGENDA.ID CONTAINING :ID)').AddParam('ID', FConteudoBusca);
    TTipoBuscaAgenda.Cliente:
    begin
       if(Length(FConteudoBusca) > 100)then
         Abort;

       FQueryBusca
        .Add('((CLIENTES.RAZAO_SOCIAL CONTAINING :NOME)or(CLIENTES.NOME_FANTASIA CONTAINING :NOME))')
        .AddParam('NOME', FConteudoBusca);
    end;
    TTipoBuscaAgenda.Funcionario:
    begin
       if(Length(FConteudoBusca) > 100)then
         Abort;

       FQueryBusca
        .Add('((FUNCIONARIOS.RAZAO_SOCIAL CONTAINING :NOME)or(FUNCIONARIOS.NOME_FANTASIA CONTAINING :NOME))')
        .AddParam('NOME', FConteudoBusca);
    end;
    TTipoBuscaAgenda.Status: FQueryBusca.Add('(AGENDA.STATUS CONTAINING :STATUS)').AddParam('STATUS', FConteudoBusca);
   else
     Abort;
   end;

   Self.GetSQLInativos;
end;

procedure TModelAgendaBusca.GetSQLOrderBy;
begin
   FQueryBusca.Add('ORDER BY ');
   case(FTipoBusca)of
    TTipoBuscaAgenda.Cliente: FQueryBusca.Add('CLIENTE_NOME, CLIENTE');
    TTipoBuscaAgenda.Funcionario: FQueryBusca.Add('FUNCIONARIO_NOME, FUNCIONARIO');
    TTipoBuscaAgenda.Status: FQueryBusca.Add('STATUS');
   else
     FQueryBusca.Add('ID');
   end;

   FQueryBusca.Add(', DATA, HORA');
end;

procedure TModelAgendaBusca.GetSQLInativos;
begin
   //
end;

procedure TModelAgendaBusca.ExecutarBusca;
begin
   ShowDebug(FQueryBusca.SQL.Text);
   FQueryBusca.Open;
   Self.ConfFieldsMask;
end;

procedure TModelAgendaBusca.ConfFieldsMask;
begin
   FQueryBusca
    .DisplayFormat('ID', DISPLAY_FORMAT_CODIGO)
    .DisplayFormat('CLIENTE', DISPLAY_FORMAT_CODIGO)
    .DisplayFormat('FUNCIONARIO', DISPLAY_FORMAT_CODIGO);
end;

function TModelAgendaBusca.ConteudoBusca(AConteudoBusca: string): TModelAgendaBusca;
begin
   Result         := Self;
   FConteudoBusca := AConteudoBusca;
end;

function TModelAgendaBusca.DataSource(ADataSource: TDataSource): TModelAgendaBusca;
begin
   Result      := Self;
   FDataSource := ADataSource;
end;

function TModelAgendaBusca.Inativos(AInativos: Boolean): TModelAgendaBusca;
begin
   Result    := Self;
   FInativos := AInativos;
end;

function TModelAgendaBusca.TipoBusca(ATipoBusca: TTipoBuscaAgenda): TModelAgendaBusca;
begin
   Result     := Self;
   FTipoBusca := ATipoBusca;
end;

function TModelAgendaBusca.IndexFieldNames(AIndex: string): TModelAgendaBusca;
begin
   Result := Self;
   FQueryBusca.IndexFieldNames(AIndex);
   Self.Buscar;
end;

end.
