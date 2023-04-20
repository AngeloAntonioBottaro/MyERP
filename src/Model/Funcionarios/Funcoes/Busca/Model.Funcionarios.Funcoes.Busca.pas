unit Model.Funcionarios.Funcoes.Busca;

interface

uses
  System.SysUtils,
  Data.DB,
  MyConnection,
  Utils.Types;

type
  TModelFuncionariosFuncoesBusca = class
  private
    FQueryBusca: IMyQuery;
    FTipoBusca: TTipoBuscaFuncionarioFuncao;
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
    function TipoBusca(ATipoBusca: TTipoBuscaFuncionarioFuncao): TModelFuncionariosFuncoesBusca;
    function Inativos(AInativos: Boolean): TModelFuncionariosFuncoesBusca;
    function DataSource(ADataSource: TDataSource): TModelFuncionariosFuncoesBusca;
    function ConteudoBusca(AConteudoBusca: string): TModelFuncionariosFuncoesBusca;
    function IndexFieldNames(AIndex: string): TModelFuncionariosFuncoesBusca;
    procedure Buscar;
  end;

implementation

uses
  Utils.MyConsts,
  Utils.LibrarySistema;

constructor TModelFuncionariosFuncoesBusca.Create;
begin
   FQueryBusca := MyQueryNew;
end;

procedure TModelFuncionariosFuncoesBusca.Buscar;
begin
   if(Assigned(FDataSource))then
     FQueryBusca.DataSource(FDataSource);

   Self.GetSQLInicial;
   Self.GetSQLCondicao;
   Self.GetSQLOrderBy;
   Self.ExecutarBusca;
end;

procedure TModelFuncionariosFuncoesBusca.GetSQLInicial;
begin
   FQueryBusca
    .Clear
    .Add('SELECT ')
    .Add('FUNCIONARIOS_FUNCOES.ID, FUNCIONARIOS_FUNCOES.NOME')
    .Add('FROM FUNCIONARIOS_FUNCOES ');
end;

procedure TModelFuncionariosFuncoesBusca.GetSQLCondicao;
begin
   FQueryBusca
    .Add('WHERE');

   case(FTipoBusca)of
    TTipoBuscaFuncionarioFuncao.Id: FQueryBusca.Add('(FUNCIONARIOS_FUNCOES.ID CONTAINING :ID)').AddParam('ID', FConteudoBusca);
    TTipoBuscaFuncionarioFuncao.Nome:
    begin
       if(Length(FConteudoBusca) > 60)then
         Abort;

       FQueryBusca.Add('(FUNCIONARIOS_FUNCOES.NOME CONTAINING :NOME)').AddParam('NOME', FConteudoBusca);
    end;
   else
    Abort;
   end;

   Self.GetSQLInativos;
end;

procedure TModelFuncionariosFuncoesBusca.GetSQLInativos;
begin
   //
end;

procedure TModelFuncionariosFuncoesBusca.GetSQLOrderBy;
begin
   FQueryBusca.Add('ORDER BY ');
   case(FTipoBusca)of
    TTipoBuscaFuncionarioFuncao.Nome: FQueryBusca.Add('NOME');
   else
     FQueryBusca.Add('ID');
   end;
end;

procedure TModelFuncionariosFuncoesBusca.ExecutarBusca;
begin
   ShowDebug(FQueryBusca.SQL.Text);
   FQueryBusca.Open;
   Self.ConfFieldsMask;
end;

procedure TModelFuncionariosFuncoesBusca.ConfFieldsMask;
begin
   FQueryBusca
    .DisplayFormat('ID', DISPLAY_FORMAT_CODIGO);
end;

function TModelFuncionariosFuncoesBusca.ConteudoBusca(AConteudoBusca: string): TModelFuncionariosFuncoesBusca;
begin
   Result         := Self;
   FConteudoBusca := AConteudoBusca;
end;

function TModelFuncionariosFuncoesBusca.DataSource(ADataSource: TDataSource): TModelFuncionariosFuncoesBusca;
begin
   Result      := Self;
   FDataSource := ADataSource;
end;

function TModelFuncionariosFuncoesBusca.Inativos(AInativos: Boolean): TModelFuncionariosFuncoesBusca;
begin
   Result    := Self;
   FInativos := AInativos;
end;

function TModelFuncionariosFuncoesBusca.TipoBusca(ATipoBusca: TTipoBuscaFuncionarioFuncao): TModelFuncionariosFuncoesBusca;
begin
   Result     := Self;
   FTipoBusca := ATipoBusca;
end;

function TModelFuncionariosFuncoesBusca.IndexFieldNames(AIndex: string): TModelFuncionariosFuncoesBusca;
begin
   Result := Self;
   FQueryBusca.IndexFieldNames(AIndex);
   Self.Buscar;
end;

end.
