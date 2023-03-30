unit Model.FormasPagamento.Busca;

interface

uses
  System.SysUtils,
  Data.DB,
  MyConnection,
  Utils.MyTypes;

type
  TModelFormasPagamentoBusca = class
  private
    FQueryBusca: IMyQuery;
    FTipoBusca: TTipoBuscaFormaPagamento;
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
    function TipoBusca(ATipoBusca: TTipoBuscaFormaPagamento): TModelFormasPagamentoBusca;
    function Inativos(AInativos: Boolean): TModelFormasPagamentoBusca;
    function DataSource(ADataSource: TDataSource): TModelFormasPagamentoBusca;
    function ConteudoBusca(AConteudoBusca: string): TModelFormasPagamentoBusca;
    function IndexFieldNames(AIndex: string): TModelFormasPagamentoBusca;
    procedure Buscar;
  end;

implementation

uses
  Utils.MyConsts,
  Utils.MyLibrary,
  Utils.LibrarySistema,
  Utils.GlobalConsts;

constructor TModelFormasPagamentoBusca.Create;
begin
   FQueryBusca := MyQueryNew;
end;

procedure TModelFormasPagamentoBusca.Buscar;
begin
   if(Assigned(FDataSource))then
     FQueryBusca.DataSource(FDataSource);

   Self.GetSQLInicial;
   Self.GetSQLCondicao;
   Self.GetSQLOrderBy;
   Self.ExecutarBusca;
end;

procedure TModelFormasPagamentoBusca.GetSQLInicial;
begin
   FQueryBusca
    .Clear
    .Add('SELECT ')
    .Add('FORMA_PAGAMENTO.ID, FORMA_PAGAMENTO.NOME, FORMA_PAGAMENTO.TIPO_LANCAMENTO, FORMA_PAGAMENTO.STATUS')
    .Add('FROM FORMA_PAGAMENTO ');
end;

procedure TModelFormasPagamentoBusca.GetSQLCondicao;
begin
   FQueryBusca
    .Add('WHERE');

   case(FTipoBusca)of
    TTipoBuscaFormaPagamento.Id: FQueryBusca.Add('(FORMA_PAGAMENTO.ID CONTAINING :ID)').AddParam('ID', FConteudoBusca);
    TTipoBuscaFormaPagamento.Nome:
    begin
       if(Length(FConteudoBusca) > 30)then
         Abort;

       FQueryBusca
        .Add('(FORMA_PAGAMENTO.NOME CONTAINING :NOME)')
        .AddParam('NOME', FConteudoBusca);
    end;
   else
     Abort;
   end;

   Self.GetSQLInativos;
end;

procedure TModelFormasPagamentoBusca.GetSQLInativos;
begin
   if(not FInativos)then
     FQueryBusca.Add('AND(FORMA_PAGAMENTO.STATUS = :STATUS)').AddParam('STATUS', STATUS_ATIVO);
end;

procedure TModelFormasPagamentoBusca.GetSQLOrderBy;
begin
   FQueryBusca.Add('ORDER BY ');
   case(FTipoBusca)of
    TTipoBuscaFormaPagamento.Nome: FQueryBusca.Add('NOME');
   else
     FQueryBusca.Add('ID');
   end;
end;

procedure TModelFormasPagamentoBusca.ExecutarBusca;
begin
   ShowDebug(FQueryBusca.SQL.Text);
   FQueryBusca.Open;
   Self.ConfFieldsMask;
end;

procedure TModelFormasPagamentoBusca.ConfFieldsMask;
begin
   FQueryBusca
    .DisplayFormat('ID', DISPLAY_FORMAT_CODIGO);
end;

function TModelFormasPagamentoBusca.ConteudoBusca(AConteudoBusca: string): TModelFormasPagamentoBusca;
begin
   Result         := Self;
   FConteudoBusca := AConteudoBusca;
end;

function TModelFormasPagamentoBusca.DataSource(ADataSource: TDataSource): TModelFormasPagamentoBusca;
begin
   Result      := Self;
   FDataSource := ADataSource;
end;

function TModelFormasPagamentoBusca.Inativos(AInativos: Boolean): TModelFormasPagamentoBusca;
begin
   Result    := Self;
   FInativos := AInativos;
end;

function TModelFormasPagamentoBusca.TipoBusca(ATipoBusca: TTipoBuscaFormaPagamento): TModelFormasPagamentoBusca;
begin
   Result     := Self;
   FTipoBusca := ATipoBusca;
end;

function TModelFormasPagamentoBusca.IndexFieldNames(AIndex: string): TModelFormasPagamentoBusca;
begin
   Result := Self;
   FQueryBusca.IndexFieldNames(AIndex);
   Self.Buscar;
end;

end.
