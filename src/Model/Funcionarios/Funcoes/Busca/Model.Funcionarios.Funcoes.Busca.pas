unit Model.Funcionarios.Funcoes.Busca;

interface

uses
  Data.DB,
  MyConnection,
  Utils.MyTypes;

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
  public
    constructor Create;
    function TipoBusca(ATipoBusca: TTipoBuscaFuncionarioFuncao): TModelFuncionariosFuncoesBusca;
    function Inativos(AInativos: Boolean): TModelFuncionariosFuncoesBusca;
    function DataSource(ADataSource: TDataSource): TModelFuncionariosFuncoesBusca;
    function ConteudoBusca(AConteudoBusca: string): TModelFuncionariosFuncoesBusca;
    procedure Buscar;
  end;

implementation

uses
  Utils.LibrarySistema,
  Utils.GlobalConsts;

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
    .Add('FUNCIONARIOS_FUNCOES.ID, FUNCIONARIOS_FUNCOES.FUNCAO')
    .Add('FROM FUNCIONARIOS_FUNCOES ');
end;

procedure TModelFuncionariosFuncoesBusca.GetSQLCondicao;
begin
   FQueryBusca
    .Add('WHERE');

   case(FTipoBusca)of
    TTipoBuscaFuncionarioFuncao.Id: FQueryBusca.Add('(FUNCIONARIOS_FUNCOES.ID CONTAINING :ID)').AddParam('ID', FConteudoBusca);
    TTipoBuscaFuncionarioFuncao.Nome: FQueryBusca.Add('(FUNCIONARIOS_FUNCOES.FUNCAO CONTAINING :NOME)').AddParam('NOME', FConteudoBusca);
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
    TTipoBuscaFuncionarioFuncao.Nome: FQueryBusca.Add('FUNCAO');
   else
     FQueryBusca.Add('ID');
   end;
end;

procedure TModelFuncionariosFuncoesBusca.ExecutarBusca;
begin
   ShowDebug(FQueryBusca.SQL.Text);
   FQueryBusca.Open;
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

end.
