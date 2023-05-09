unit Model.Cidades.Busca;

interface

uses
  System.SysUtils,
  Data.DB,
  MyConnection,
  Utils.Types;

type
  TModelCidadesBusca = class
  private
    FQueryBusca: IMyQuery;
    FTipoBusca: TTipoBuscaCidade;
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
    function TipoBusca(ATipoBusca: TTipoBuscaCidade): TModelCidadesBusca;
    function Inativos(AInativos: Boolean): TModelCidadesBusca;
    function DataSource(ADataSource: TDataSource): TModelCidadesBusca;
    function ConteudoBusca(AConteudoBusca: string): TModelCidadesBusca;
    function IndexFieldNames(AIndex: string): TModelCidadesBusca;
    procedure Buscar;
  end;

implementation

uses
  Common.Utils.MyConsts,
  Utils.LibrarySistema;

constructor TModelCidadesBusca.Create;
begin
   FQueryBusca := MyQueryNew;
end;

procedure TModelCidadesBusca.Buscar;
begin
   if(Assigned(FDataSource))then
     FQueryBusca.DataSource(FDataSource);

   Self.GetSQLInicial;
   Self.GetSQLCondicao;
   Self.GetSQLOrderBy;
   Self.ExecutarBusca;
end;

procedure TModelCidadesBusca.GetSQLInicial;
begin
   FQueryBusca
    .Clear
    .Add('SELECT ')
    .Add('CIDADES.ID, CIDADES.NOME, CIDADES.UF, CIDADES.IBGE')
    .Add('FROM CIDADES ');
end;

procedure TModelCidadesBusca.GetSQLCondicao;
begin
   FQueryBusca
    .Add('WHERE');

   case(FTipoBusca)of
    TTipoBuscaCidade.Id: FQueryBusca.Add('(CIDADES.ID CONTAINING :ID)').AddParam('ID', FConteudoBusca);
    TTipoBuscaCidade.Nome:
    begin
       if(Length(FConteudoBusca) > 60)then
         Abort;

       FQueryBusca.Add('(CIDADES.NOME CONTAINING :NOME)').AddParam('NOME', FConteudoBusca);
    end;
    TTipoBuscaCidade.UF:
    begin
       if(Length(FConteudoBusca) > 2)then
         Abort;

       FQueryBusca.Add('(CIDADES.UF CONTAINING :UF)').AddParam('UF', FConteudoBusca);
    end;
    TTipoBuscaCidade.IBGE: FQueryBusca.Add('(CIDADES.IBGE CONTAINING :IBGE)').AddParam('IBGE', FConteudoBusca);
   else
     Abort;
   end;

   Self.GetSQLInativos;
end;

procedure TModelCidadesBusca.GetSQLInativos;
begin
   //
end;

procedure TModelCidadesBusca.GetSQLOrderBy;
begin
   FQueryBusca.Add('ORDER BY ');
   case(FTipoBusca)of
    TTipoBuscaCidade.Nome: FQueryBusca.Add('NOME');
    TTipoBuscaCidade.UF: FQueryBusca.Add('UF, NOME');
    TTipoBuscaCidade.IBGE: FQueryBusca.Add('IBGE');
   else
     FQueryBusca.Add('ID');
   end;
end;

procedure TModelCidadesBusca.ExecutarBusca;
begin
   ShowDebug(FQueryBusca.SQL.Text);
   FQueryBusca.Open;
   Self.ConfFieldsMask;
end;

procedure TModelCidadesBusca.ConfFieldsMask;
begin
   FQueryBusca
    .DisplayFormat('ID', DISPLAY_FORMAT_CODIGO);
end;

function TModelCidadesBusca.ConteudoBusca(AConteudoBusca: string): TModelCidadesBusca;
begin
   Result         := Self;
   FConteudoBusca := AConteudoBusca;
end;

function TModelCidadesBusca.DataSource(ADataSource: TDataSource): TModelCidadesBusca;
begin
   Result      := Self;
   FDataSource := ADataSource;
end;

function TModelCidadesBusca.Inativos(AInativos: Boolean): TModelCidadesBusca;
begin
   Result    := Self;
   FInativos := AInativos;
end;

function TModelCidadesBusca.TipoBusca(ATipoBusca: TTipoBuscaCidade): TModelCidadesBusca;
begin
   Result     := Self;
   FTipoBusca := ATipoBusca;
end;

function TModelCidadesBusca.IndexFieldNames(AIndex: string): TModelCidadesBusca;
begin
   Result := Self;
   FQueryBusca.IndexFieldNames(AIndex);
   Self.Buscar;
end;

end.
