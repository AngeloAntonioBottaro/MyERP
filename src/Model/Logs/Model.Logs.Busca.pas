unit Model.Logs.Busca;

interface

uses
  System.SysUtils,
  Data.DB,
  MyConnection,
  Utils.Types;

type

  TModelLogsBusca = class
  private
    FQueryBusca: IMyQuery;
    FDataSource: TDataSource;

    FUtilizarPeriodo: Boolean;
    FUtilizarFuncionario: Boolean;
    FUtilizarModulo: Boolean;
    FUtilizarAcao: Boolean;
    FUtilizarReferencia: Boolean;

    FPeriodoInicial: TDate;
    FPeriodoFinal: TDate;
    FFuncionario: Integer;
    FModulo: string;
    FTipoModulo: Integer;
    FAcao: string;
    FTipoAcao: Integer;
    FReferencia: Integer;

    procedure GetSQLInicial;
    procedure GetSQLCondicao;
    procedure SQLPeriodo;
    procedure SQLFuncionario;
    procedure SQLModulo;
    procedure SQLAcao;
    procedure SQLReferencia;
    procedure GetSQLOrderBy;
    procedure ExecutarBusca;
    procedure ConfFieldsMask;

    function TipoConsulta(ATipo: Integer): string;
  public
    constructor Create;
    function DataSource(ADataSource: TDataSource): TModelLogsBusca;
    function IndexFieldNames(AIndex: string): TModelLogsBusca;

    function Periodo(AUtilizar: Boolean; APeriodoIni, APeriodoFim: TDate): TModelLogsBusca;
    function Funcionario(AUtilizar: Boolean; AIdFuncionario: string): TModelLogsBusca; overload;
    function Funcionario(AUtilizar: Boolean; AIdFuncionario: Integer): TModelLogsBusca; overload;
    function Modulo(AUtilizar: Boolean; AModulo: string; ATipoBusca: Integer): TModelLogsBusca;
    function Acao(AUtilizar: Boolean; AAcao: string; ATipoBusca: Integer): TModelLogsBusca;
    function Referencia(AUtilizar: Boolean; AIdReferencia: string): TModelLogsBusca; overload;
    function Referencia(AUtilizar: Boolean; AIdReferencia: Integer): TModelLogsBusca; overload;

    procedure Buscar;
  end;

implementation

uses
  MyExceptions,
  Common.Utils.MyConsts,
  Utils.LibrarySistema;

constructor TModelLogsBusca.Create;
begin
   FQueryBusca := MyQueryNew;
end;

procedure TModelLogsBusca.Buscar;
begin
   if(Assigned(FDataSource))then
     FQueryBusca.DataSource(FDataSource);

   Self.GetSQLInicial;
   Self.GetSQLCondicao;
   Self.GetSQLOrderBy;
   Self.ExecutarBusca;
end;

procedure TModelLogsBusca.GetSQLInicial;
begin
   FQueryBusca
    .Clear
    .Add('SELECT ')
    .Add('LOGS.ID, LOGS.DATA, LOGS.HORA, LOGS.ID_FUNCIONARIO, LOGS.MODULO, LOGS.ACAO, LOGS.DESCRICAO, LOGS.REFERENCIA, ')
    .Add('FUNCIONARIOS.RAZAO_SOCIAL AS FUNCIONARIO')
    .Add('FROM LOGS ')
    .Add('LEFT JOIN FUNCIONARIOS ON(FUNCIONARIOS.ID = LOGS.ID_FUNCIONARIO)');
end;

procedure TModelLogsBusca.GetSQLCondicao;
begin
   Self.SQLPeriodo;
   Self.SQLFuncionario;
   Self.SQLModulo;
   Self.SQLAcao;
   Self.SQLReferencia;
end;

procedure TModelLogsBusca.GetSQLOrderBy;
begin
   FQueryBusca.Add('ORDER BY LOGS.DATA, LOGS.HORA, LOGS.ID');
end;

procedure TModelLogsBusca.ExecutarBusca;
begin
   ShowDebug(FQueryBusca.SQL.Text);
   FQueryBusca.Open;
   Self.ConfFieldsMask;
end;

procedure TModelLogsBusca.ConfFieldsMask;
begin
   FQueryBusca
    .DisplayFormat('ID', DISPLAY_FORMAT_CODIGO)
    .DisplayFormat('REFERENCIA', DISPLAY_FORMAT_CODIGO)
    .DisplayFormat('ID_FUNCIONARIO', DISPLAY_FORMAT_CODIGO);
end;

function TModelLogsBusca.DataSource(ADataSource: TDataSource): TModelLogsBusca;
begin
   Result      := Self;
   FDataSource := ADataSource;
end;

function TModelLogsBusca.IndexFieldNames(AIndex: string): TModelLogsBusca;
begin
   Result := Self;
   FQueryBusca.IndexFieldNames(AIndex);
   Self.Buscar;
end;

procedure TModelLogsBusca.SQLPeriodo;
begin
   FQueryBusca
    .Add('WHERE')
    .Add('((LOGS.DATA >= :INICIO)AND(LOGS.DATA <= :FIM))');

   FQueryBusca
    .AddParam('INICIO', StrToDate('01/01/2000'))
    .AddParam('FIM', Date);

   if(FUtilizarPeriodo)then
     FQueryBusca
      .AddParam('INICIO', FPeriodoInicial)
       .AddParam('FIM', FPeriodoFinal);
end;

procedure TModelLogsBusca.SQLFuncionario;
begin
   if(not FUtilizarFuncionario)then
     Exit;

   if(FFuncionario <= 0)then
     raise ExceptionRequired.Create('Funcionário não informado');

   FQueryBusca
    .Add('AND(LOGS.ID_FUNCIONARIO = :FUNCIONARIO)')
    .AddParam('FUNCIONARIO', FFuncionario);
end;

procedure TModelLogsBusca.SQLModulo;
begin
   if(not FUtilizarModulo)then
     Exit;

   if(FModulo.IsEmpty)then
     raise ExceptionRequired.Create('Módulo não informado');

   FQueryBusca
    .Add('AND(LOGS.MODULO ' + Self.TipoConsulta(FTipoModulo) + ' :MODULO)')
    .AddParam('MODULO', FModulo);
end;

procedure TModelLogsBusca.SQLAcao;
begin
   if(not FUtilizarAcao)then
     Exit;

   if(FAcao.IsEmpty)then
     raise ExceptionRequired.Create('Ação não informado');

   FQueryBusca
    .Add('AND(LOGS.ACAO ' + Self.TipoConsulta(FTipoAcao) + ' :ACAO)')
    .AddParam('ACAO', FAcao);
end;

procedure TModelLogsBusca.SQLReferencia;
begin
   if(not FUtilizarReferencia)then
     Exit;

   if(FFuncionario < 0)then
     raise ExceptionRequired.Create('Referência não informada');

   FQueryBusca
    .Add('AND(LOGS.REFERENCIA = :REFERENCIA)')
    .AddParam('REFERENCIA', FReferencia);
end;

function TModelLogsBusca.TipoConsulta(ATipo: Integer): string;
begin
   case(ATipo)of
     0: Result := ' CONTAINING ';
     1: Result := ' = ';
     2: Result := ' <> ';
   else
     raise ExceptionRequired.Create('Informe o tipo de consulta a ser utilizado');
   end;
end;

function TModelLogsBusca.Periodo(AUtilizar: Boolean; APeriodoIni, APeriodoFim: TDate): TModelLogsBusca;
begin
   Result := Self;
   FUtilizarPeriodo := AUtilizar;
   FPeriodoInicial  := APeriodoIni;
   FPeriodoFinal    := APeriodoFim;
end;

function TModelLogsBusca.Funcionario(AUtilizar: Boolean; AIdFuncionario: string): TModelLogsBusca;
begin
   Result := Self;
   Self.Funcionario(AUtilizar, StrToIntDef(AIdFuncionario, 0));
end;

function TModelLogsBusca.Funcionario(AUtilizar: Boolean; AIdFuncionario: Integer): TModelLogsBusca;
begin
   Result := Self;
   FUtilizarFuncionario := AUtilizar;
   FFuncionario         := AIdFuncionario;
end;

function TModelLogsBusca.Modulo(AUtilizar: Boolean; AModulo: string; ATipoBusca: Integer): TModelLogsBusca;
begin
   Result := Self;
   FUtilizarModulo := AUtilizar;
   FModulo         := AModulo;
   FTipoModulo     := ATipoBusca;
end;

function TModelLogsBusca.Acao(AUtilizar: Boolean; AAcao: string; ATipoBusca: Integer): TModelLogsBusca;
begin
   Result := Self;
   FUtilizarAcao := AUtilizar;
   FAcao         := AAcao;
   FTipoAcao     := ATipoBusca;
end;

function TModelLogsBusca.Referencia(AUtilizar: Boolean; AIdReferencia: string): TModelLogsBusca;
begin
   Result := Self;
   Self.Referencia(AUtilizar, StrToIntDef(AIdReferencia, 0));
end;

function TModelLogsBusca.Referencia(AUtilizar: Boolean; AIdReferencia: Integer): TModelLogsBusca;
begin
   Result := Self;
   FUtilizarReferencia := AUtilizar;
   FReferencia         := AIdReferencia;
end;

end.

