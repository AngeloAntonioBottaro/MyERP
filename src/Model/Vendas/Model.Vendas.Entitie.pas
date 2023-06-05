unit Model.Vendas.Entitie;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Utils.Types;

type
  TModelVendasEntitie = class
  private
    FId: Integer;
    FData: TDate;
    FIdCliente: Integer;
    FNomeCliente: string;
    FFormaPagamento: TFormaPagamento;
    FObservacao: string;
  public
    constructor Create;
    function Id(AValue: string): TModelVendasEntitie; overload;
    function Id(AValue: Integer): TModelVendasEntitie; overload;
    function Id: Integer; overload;
    function IdMascara: string;
    function Data(AValue: string): TModelVendasEntitie; overload;
    function Data(AValue: TDate): TModelVendasEntitie; overload;
    function Data: TDate; overload;
    function Hora: TTime; overload;
    function IdCliente(AValue: string): TModelVendasEntitie; overload;
    function IdCliente(AValue: Integer): TModelVendasEntitie; overload;
    function IdCliente: Integer; overload;
    function IdClienteMascara: string;
    function NomeCliente(AValue: string): TModelVendasEntitie; overload;
    function NomeCliente: string; overload;
    function FormaPagamento(AValue: Integer): TModelVendasEntitie; overload;
    function FormaPagamento(AValue: TFormaPagamento): TModelVendasEntitie; overload;
    function FormaPagamento: TFormaPagamento; overload;
    function Observacao(AValue: string): TModelVendasEntitie; overload;
    function Observacao: string; overload;
  end;

implementation

uses
  Common.Utils.MyLibrary;

constructor TModelVendasEntitie.Create;
begin
   FId   := 1;
   FData := Date;
   FFormaPagamento := TFormaPagamento.Vista;
end;

function TModelVendasEntitie.Id(AValue: string): TModelVendasEntitie;
begin
   Result := Self;
   Self.Id(TMyLibrary.StrToIntDef(AValue));
end;

function TModelVendasEntitie.Id(AValue: Integer): TModelVendasEntitie;
begin
   Result := Self;
   FId    := AValue;
end;

function TModelVendasEntitie.Id: Integer;
begin
   Result := FId;
end;

function TModelVendasEntitie.IdMascara: string;
begin
   Result := TMyLibrary.CompLeft(FId);
end;

function TModelVendasEntitie.Data(AValue: string): TModelVendasEntitie;
begin
   Result := Self;
   Self.Data(StrToDateDef(AValue, Date));
end;

function TModelVendasEntitie.Data(AValue: TDate): TModelVendasEntitie;
begin
   Result := Self;
   FData  := AValue;
end;

function TModelVendasEntitie.Data: TDate;
begin
   Result := FData;
end;

function TModelVendasEntitie.Hora: TTime;
begin
   Result := Time;
end;

function TModelVendasEntitie.IdCliente(AValue: string): TModelVendasEntitie;
begin
   Result := Self;
   Self.IdCliente(TMyLibrary.StrToIntDef(AValue));
end;

function TModelVendasEntitie.IdCliente(AValue: Integer): TModelVendasEntitie;
begin
   Result     := Self;
   FIdCliente := AValue;
end;

function TModelVendasEntitie.IdCliente: Integer;
begin
   Result := FIdCliente;
end;

function TModelVendasEntitie.IdClienteMascara: string;
begin
   Result := TMyLibrary.CompLeft(FIdCliente);
end;

function TModelVendasEntitie.NomeCliente(AValue: string): TModelVendasEntitie;
begin
   Result       := Self;
   FNomeCliente := AValue.Trim;
end;

function TModelVendasEntitie.NomeCliente: string;
begin
   Result := FNomeCliente;
end;

function TModelVendasEntitie.FormaPagamento(AValue: Integer): TModelVendasEntitie;
begin
   Result := Self;
   Self.FormaPagamento(TFormaPagamento(AValue));
end;

function TModelVendasEntitie.FormaPagamento(AValue: TFormaPagamento): TModelVendasEntitie;
begin
   Result          := Self;
   FFormaPagamento := AValue;
end;

function TModelVendasEntitie.FormaPagamento: TFormaPagamento;
begin
   Result := FFormaPagamento;
end;

function TModelVendasEntitie.Observacao(AValue: string): TModelVendasEntitie;
begin
   Result      := Self;
   FObservacao := AValue.Trim;
end;

function TModelVendasEntitie.Observacao: string;
begin
   Result := FObservacao;
end;

end.
