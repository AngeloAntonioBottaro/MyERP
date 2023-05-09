unit Model.Permissoes.Grupos.Busca;

interface

uses
  System.SysUtils,
  Data.DB,
  MyConnection,
  Utils.Types;

type
  TModelPermissoesGruposBusca = class
  private
    FQueryBusca: IMyQuery;
    FTipoBusca: TTipoBuscaPermissoesGrupo;
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
    function TipoBusca(ATipoBusca: TTipoBuscaPermissoesGrupo): TModelPermissoesGruposBusca;
    function Inativos(AInativos: Boolean): TModelPermissoesGruposBusca;
    function DataSource(ADataSource: TDataSource): TModelPermissoesGruposBusca;
    function ConteudoBusca(AConteudoBusca: string): TModelPermissoesGruposBusca;
    function IndexFieldNames(AIndex: string): TModelPermissoesGruposBusca;
    procedure Buscar;
  end;

implementation

uses
  Common.Utils.MyConsts,
  Utils.LibrarySistema;

constructor TModelPermissoesGruposBusca.Create;
begin
   FQueryBusca := MyQueryNew;
end;

procedure TModelPermissoesGruposBusca.Buscar;
begin
   if(Assigned(FDataSource))then
     FQueryBusca.DataSource(FDataSource);

   Self.GetSQLInicial;
   Self.GetSQLCondicao;
   Self.GetSQLOrderBy;
   Self.ExecutarBusca;
end;

procedure TModelPermissoesGruposBusca.GetSQLInicial;
begin
   FQueryBusca
    .Clear
    .Add('SELECT ')
    .Add('PERMISSOES_GRUPO.ID, PERMISSOES_GRUPO.NOME, PERMISSOES_GRUPO.DESCRICAO')
    .Add('FROM PERMISSOES_GRUPO ');
end;

procedure TModelPermissoesGruposBusca.GetSQLCondicao;
begin
   FQueryBusca
    .Add('WHERE');

   case(FTipoBusca)of
    TTipoBuscaPermissoesGrupo.Id: FQueryBusca.Add('(PERMISSOES_GRUPO.ID CONTAINING :ID)').AddParam('ID', FConteudoBusca);
    TTipoBuscaPermissoesGrupo.Nome:
    begin
       if(Length(FConteudoBusca) > 50)then
         Abort;

       FQueryBusca.Add('(PERMISSOES_GRUPO.NOME CONTAINING :NOME)').AddParam('NOME', FConteudoBusca);
    end;
    TTipoBuscaPermissoesGrupo.Descricao:
    begin
       if(Length(FConteudoBusca) > 200)then
         Abort;

       FQueryBusca.Add('(PERMISSOES_GRUPO.DESCRICAO CONTAINING :DESCRICAO)').AddParam('DESCRICAO', FConteudoBusca);
    end;
   else
    Abort;
   end;

   Self.GetSQLInativos;
end;

procedure TModelPermissoesGruposBusca.GetSQLInativos;
begin
   //
end;

procedure TModelPermissoesGruposBusca.GetSQLOrderBy;
begin
   FQueryBusca.Add('ORDER BY ');
   case(FTipoBusca)of
    TTipoBuscaPermissoesGrupo.Nome: FQueryBusca.Add('NOME, ID');
    TTipoBuscaPermissoesGrupo.Descricao: FQueryBusca.Add('DESCRICAO, ID');
   else
     FQueryBusca.Add('ID');
   end;
end;

procedure TModelPermissoesGruposBusca.ExecutarBusca;
begin
   ShowDebug(FQueryBusca.SQL.Text);
   FQueryBusca.Open;
   Self.ConfFieldsMask;
end;

procedure TModelPermissoesGruposBusca.ConfFieldsMask;
begin
   FQueryBusca
    .DisplayFormat('ID', DISPLAY_FORMAT_CODIGO);
end;

function TModelPermissoesGruposBusca.ConteudoBusca(AConteudoBusca: string): TModelPermissoesGruposBusca;
begin
   Result         := Self;
   FConteudoBusca := AConteudoBusca;
end;

function TModelPermissoesGruposBusca.DataSource(ADataSource: TDataSource): TModelPermissoesGruposBusca;
begin
   Result      := Self;
   FDataSource := ADataSource;
end;

function TModelPermissoesGruposBusca.Inativos(AInativos: Boolean): TModelPermissoesGruposBusca;
begin
   Result    := Self;
   FInativos := AInativos;
end;

function TModelPermissoesGruposBusca.TipoBusca(ATipoBusca: TTipoBuscaPermissoesGrupo): TModelPermissoesGruposBusca;
begin
   Result     := Self;
   FTipoBusca := ATipoBusca;
end;

function TModelPermissoesGruposBusca.IndexFieldNames(AIndex: string): TModelPermissoesGruposBusca;
begin
   Result := Self;
   FQueryBusca.IndexFieldNames(AIndex);
   Self.Buscar;
end;

end.
