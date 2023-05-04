unit Model.FormasPagamento.Entitie;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Model.FormasPagamento.Interfaces;

type
  TModelFormasPagamentoEntitie = class
  private
    [weak]
    FParent: IModelFormasPagamentoFactory<TModelFormasPagamentoEntitie>;

    FId: Integer;
    FNome: string;
    FStatus: string;
    FTipoLancamento: string;
  public
    constructor Create(AParent: IModelFormasPagamentoFactory<TModelFormasPagamentoEntitie>);
    destructor Destroy; override;
    function End_Entitie: IModelFormasPagamentoFactory<TModelFormasPagamentoEntitie>;

    function Id(AValue: string): TModelFormasPagamentoEntitie; overload;
    function Id(AValue: Integer): TModelFormasPagamentoEntitie; overload;
    function Id: Integer; overload;
    function IdMascara: string;
    function IdNome: string;
    function Nome(AValue: string): TModelFormasPagamentoEntitie; overload;
    function Nome: string; overload;
    function Status(AValue: string): TModelFormasPagamentoEntitie; overload;
    function Status: string; overload;
    function TipoLancamento(AValue: string): TModelFormasPagamentoEntitie; overload;
    function TipoLancamento: string; overload;
    function TipoLancamentoComboBox: Integer;
  end;

implementation

uses
  Utils.MyLibrary,
  Utils.GlobalConsts;

constructor TModelFormasPagamentoEntitie.Create(AParent: IModelFormasPagamentoFactory<TModelFormasPagamentoEntitie>);
begin
   FParent         := AParent;
   FStatus         := STATUS_ATIVO;
   FTipoLancamento := TIPO_LANCAMENTO_SEMCONTROLE;
end;

destructor TModelFormasPagamentoEntitie.Destroy;
begin
   inherited;
end;

function TModelFormasPagamentoEntitie.End_Entitie: IModelFormasPagamentoFactory<TModelFormasPagamentoEntitie>;
begin
   Result := FParent;
end;

function TModelFormasPagamentoEntitie.Id(AValue: string): TModelFormasPagamentoEntitie;
begin
   Result := Self;
   Self.Id(TMyLibrary.StrToIntDef(AValue.Trim));
end;

function TModelFormasPagamentoEntitie.Id(AValue: Integer): TModelFormasPagamentoEntitie;
begin
   Result := Self;
   FId    := AValue;
end;

function TModelFormasPagamentoEntitie.Id: Integer;
begin
   Result := FId;
end;

function TModelFormasPagamentoEntitie.IdMascara: string;
begin
   Result := EmptyStr;
   if(Self.Id > 0)then
     Result := TMyLibrary.CompLeft(Self.Id);
end;

function TModelFormasPagamentoEntitie.IdNome: string;
begin
   Result := Self.Nome;
   if(not Result.IsEmpty)then
     Result := Self.IdMascara + ' - ' + Result;
end;

function TModelFormasPagamentoEntitie.Nome(AValue: string): TModelFormasPagamentoEntitie;
begin
   Result  := Self;
   FNome := AValue.Trim;
end;

function TModelFormasPagamentoEntitie.Nome: string;
begin
   Result := FNome;
end;

function TModelFormasPagamentoEntitie.Status(AValue: string): TModelFormasPagamentoEntitie;
begin
   Result  := Self;
   FStatus := AValue.Trim;
end;

function TModelFormasPagamentoEntitie.Status: string;
begin
   Result := FStatus;
end;

function TModelFormasPagamentoEntitie.TipoLancamento(AValue: string): TModelFormasPagamentoEntitie;
var
  LTipo: string;
begin
   Result := Self;

   LTipo := UpperCase(AValue.Trim);

   FTipoLancamento := TIPO_LANCAMENTO_SEMCONTROLE_DATABASE;
   if(LTipo.Equals(TIPO_LANCAMENTO_CAIXA))then
     FTipoLancamento := TIPO_LANCAMENTO_CAIXA_DATABASE
   else if(LTipo.Equals(TIPO_LANCAMENTO_FINANCEIRO))then
     FTipoLancamento := TIPO_LANCAMENTO_FINANCEIRO_DATABASE;

   if(LTipo.Equals(TIPO_LANCAMENTO_CAIXA_DATABASE) or
      LTipo.Equals(TIPO_LANCAMENTO_FINANCEIRO_DATABASE) or
      LTipo.Equals(TIPO_LANCAMENTO_SEMCONTROLE_DATABASE)
   )then
     FTipoLancamento := LTipo;
end;

function TModelFormasPagamentoEntitie.TipoLancamento: string;
begin
   Result := FTipoLancamento;
end;

function TModelFormasPagamentoEntitie.TipoLancamentoComboBox: Integer;
begin
   Result := -1;
   if(Self.TipoLancamento.Equals(TIPO_LANCAMENTO_CAIXA_DATABASE))then
     Result := 0
   else if(Self.TipoLancamento.Equals(TIPO_LANCAMENTO_FINANCEIRO_DATABASE))then
     Result := 1
   else if(Self.TipoLancamento.Equals(TIPO_LANCAMENTO_SEMCONTROLE_DATABASE))then
     Result := 2;
end;

end.
