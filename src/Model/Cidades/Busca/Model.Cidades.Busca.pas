unit Model.Cidades.Busca;

interface

uses
  Data.DB,
  MyConnection,
  Utils.MyTypes;

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
  public
    constructor Create;
    function TipoBusca(ATipoBusca: TTipoBuscaCidade): TModelCidadesBusca;
    function Inativos(AInativos: Boolean): TModelCidadesBusca;
    function DataSource(ADataSource: TDataSource): TModelCidadesBusca;
    function ConteudoBusca(AConteudoBusca: string): TModelCidadesBusca;
    procedure Buscar;
  end;

implementation

uses
  Utils.LibrarySistema,
  Utils.GlobalConsts;

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
    .Add('CIDADES.NOME, CIDADES.UF, CIDADES.IBGE')
    .Add('FROM CIDADES ');
end;

procedure TModelCidadesBusca.GetSQLCondicao;
begin
   FQueryBusca
    .Add('WHERE');

   case(FTipoBusca)of
    TTipoBuscaCidade.Id: FQueryBusca.Add('(CIDADES.ID CONTAINING :ID)').AddParam('ID', FConteudoBusca);
    TTipoBuscaCidade.Nome: FQueryBusca.Add('(CIDADES.NOME CONTAINING :NOME)').AddParam('NOME', FConteudoBusca);
    TTipoBuscaCidade.UF: FQueryBusca.Add('(CIDADES.UF CONTAINING :UF)').AddParam('UF', FConteudoBusca);
    TTipoBuscaCidade.IBGE: FQueryBusca.Add('(CIDADES.IBGE CONTAINING :IBGE)').AddParam('IBGE', FConteudoBusca);
   end;
end;

procedure TModelCidadesBusca.GetSQLInativos;
begin
   //
end;

procedure TModelCidadesBusca.GetSQLOrderBy;
begin
   FQueryBusca.Add('ORDER BY ');
   case(FTipoBusca)of
    TTipoBuscaCliente.Nome: FQueryBusca.Add('NOME');
    TTipoBuscaCliente.CPF_CNPJ: FQueryBusca.Add('UF, NOME');
    TTipoBuscaCliente.Cidade: FQueryBusca.Add('IBGE');
   else
     FQueryBusca.Add('ID');
   end;
end;

procedure TModelCidadesBusca.ExecutarBusca;
begin
   ShowDebug(FQueryBusca.SQL.Text);
   FQueryBusca.Open;
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

end.
