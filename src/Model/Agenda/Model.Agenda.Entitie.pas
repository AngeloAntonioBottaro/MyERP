unit Model.Agenda.Entitie;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Model.Agenda.Interfaces;

type
  TModelAgendaEntitie = class
  private
    [weak]
    FParent: IModelAgendaFactory<TModelAgendaEntitie>;

    FCliente: Integer;
    FData: TDateTime;
    FDataCadastro: TDateTime;
    FDataUltimaAlteracao: TDateTime;
    FFuncionario: Integer;
    FHora: TDateTime;
    FId: Integer;
    FObservacao: string;
    FStatus: string;
    FTitulo: string;
  public
    constructor Create(AParent: IModelAgendaFactory<TModelAgendaEntitie>);
    destructor Destroy; override;
    function End_Entitie: IModelAgendaFactory<TModelAgendaEntitie>;

    function Cliente(AValue: string): TModelAgendaEntitie; overload;
    function Cliente(AValue: Integer): TModelAgendaEntitie; overload;
    function Cliente: Integer; overload;
    function ClienteMascara: string;
    function Data(AValue: string): TModelAgendaEntitie; overload;
    function Data(AValue: TDateTime): TModelAgendaEntitie; overload;
    function Data: TDateTime; overload;
    function DataCadastro(AValue: string): TModelAgendaEntitie; overload;
    function DataCadastro(AValue: TDateTime): TModelAgendaEntitie; overload;
    function DataCadastro: TDateTime; overload;
    function DataUltimaAlteracao(AValue: string): TModelAgendaEntitie; overload;
    function DataUltimaAlteracao(AValue: TDateTime): TModelAgendaEntitie; overload;
    function DataUltimaAlteracao: TDateTime; overload;
    function Funcionario(AValue: string): TModelAgendaEntitie; overload;
    function Funcionario(AValue: Integer): TModelAgendaEntitie; overload;
    function Funcionario: Integer; overload;
    function FuncionarioMascara: string;
    function Hora(AValue: string): TModelAgendaEntitie; overload;
    function Hora(AValue: TDateTime): TModelAgendaEntitie; overload;
    function Hora: TDateTime; overload;
    function Id(AValue: string): TModelAgendaEntitie; overload;
    function Id(AValue: Integer): TModelAgendaEntitie; overload;
    function Id: Integer; overload;
    function IdMascara: string;
    function IdTitulo: string;
    function Observacao(AValue: string): TModelAgendaEntitie; overload;
    function Observacao: string; overload;
    function Status(AValue: string): TModelAgendaEntitie; overload;
    function Status: string; overload;
    function StatusComboBox: Integer;
    function Titulo(AValue: string): TModelAgendaEntitie; overload;
    function Titulo: string; overload;
  end;

implementation

uses
  Common.Utils.MyLibrary,
  Utils.GlobalConsts;

constructor TModelAgendaEntitie.Create(AParent: IModelAgendaFactory<TModelAgendaEntitie>);
begin
   FParent := AParent;
end;

destructor TModelAgendaEntitie.Destroy;
begin
   inherited;
end;

function TModelAgendaEntitie.End_Entitie: IModelAgendaFactory<TModelAgendaEntitie>;
begin
   Result := FParent;
end;

function TModelAgendaEntitie.Cliente(AValue: string): TModelAgendaEntitie;
begin
   Result := Self;
   Self.Cliente(TMyLibrary.StrToIntDef(AValue.Trim));
end;

function TModelAgendaEntitie.Cliente(AValue: Integer): TModelAgendaEntitie;
begin
   Result   := Self;
   FCliente := AValue;
end;

function TModelAgendaEntitie.Cliente: Integer;
begin
   Result := FCliente;
end;

function TModelAgendaEntitie.ClienteMascara: string;
begin
   Result := EmptyStr;
   if(Self.Cliente > 0)then
     Result := TMyLibrary.CompLeft(Self.Cliente);
end;

function TModelAgendaEntitie.Data(AValue: string): TModelAgendaEntitie;
begin
   Result := Self;
   Self.Data(StrToDateTime(AValue.Trim));
end;

function TModelAgendaEntitie.Data(AValue: TDateTime): TModelAgendaEntitie;
begin
   Result := Self;
   FData  := AValue;
end;

function TModelAgendaEntitie.Data: TDateTime;
begin
   Result := FData;
end;

function TModelAgendaEntitie.DataCadastro(AValue: string): TModelAgendaEntitie;
begin
   Result := Self;
   Self.DataCadastro(StrToDateTime(AValue.Trim));
end;

function TModelAgendaEntitie.DataCadastro(AValue: TDateTime): TModelAgendaEntitie;
begin
   Result        := Self;
   FDataCadastro := AValue;
end;

function TModelAgendaEntitie.DataCadastro: TDateTime;
begin
   Result := FDataCadastro
end;

function TModelAgendaEntitie.DataUltimaAlteracao(AValue: string): TModelAgendaEntitie;
begin
   Result := Self;
   Self.DataUltimaAlteracao(StrToDateTime(AValue.Trim));
end;

function TModelAgendaEntitie.DataUltimaAlteracao(AValue: TDateTime): TModelAgendaEntitie;
begin
   Result               := Self;
   FDataUltimaAlteracao := AValue;
end;

function TModelAgendaEntitie.DataUltimaAlteracao: TDateTime;
begin
   Result := FDataUltimaAlteracao;
end;

function TModelAgendaEntitie.Funcionario(AValue: string): TModelAgendaEntitie;
begin
   Result := Self;
   Self.Funcionario(TMyLibrary.StrToIntDef(AValue.Trim));
end;

function TModelAgendaEntitie.Funcionario(AValue: Integer): TModelAgendaEntitie;
begin
   Result       := Self;
   FFuncionario := AValue;
end;

function TModelAgendaEntitie.Funcionario: Integer;
begin
   Result := FFuncionario;
end;

function TModelAgendaEntitie.FuncionarioMascara: string;
begin
   Result := EmptyStr;
   if(Self.Funcionario > 0)then
     Result := TMyLibrary.CompLeft(Self.Funcionario);
end;

function TModelAgendaEntitie.Hora(AValue: string): TModelAgendaEntitie;
begin
   Result := Self;
   Self.Hora(StrToDateTime(AValue.Trim));
end;

function TModelAgendaEntitie.Hora(AValue: TDateTime): TModelAgendaEntitie;
begin
   Result := Self;
   FHora  := AValue;
end;

function TModelAgendaEntitie.Hora: TDateTime;
begin
   Result := FHora;
end;

function TModelAgendaEntitie.Id(AValue: string): TModelAgendaEntitie;
begin
   Result := Self;
   Self.Id(TMyLibrary.StrToIntDef(AValue.Trim));
end;

function TModelAgendaEntitie.Id(AValue: Integer): TModelAgendaEntitie;
begin
   Result := Self;
   FId    := AValue;
end;

function TModelAgendaEntitie.Id: Integer;
begin
   Result := FId;
end;

function TModelAgendaEntitie.IdMascara: string;
begin
   Result := EmptyStr;
   if(Self.Id > 0)then
     Result := TMyLibrary.CompLeft(Self.Id);
end;

function TModelAgendaEntitie.IdTitulo: string;
begin
   Result := Self.Titulo;
   Result := IfThen(Result.IsEmpty, Self.IdMascara, Self.IdMascara + ' - ' + Result);
end;

function TModelAgendaEntitie.Observacao(AValue: string): TModelAgendaEntitie;
begin
   Result      := Self;
   FObservacao := AValue;
end;

function TModelAgendaEntitie.Observacao: string;
begin
   Result := FObservacao;
end;

function TModelAgendaEntitie.Status(AValue: string): TModelAgendaEntitie;
begin
   Result  := Self;
   FStatus := AValue.Trim;
end;

function TModelAgendaEntitie.Status: string;
begin
   Result := FStatus;
end;

function TModelAgendaEntitie.StatusComboBox: Integer;
var
  I: Integer;
begin
   Result := -1;
   for I := Low(AGENDA_STATUS) to High(AGENDA_STATUS) do
   begin
      if(Self.Status.Equals(AGENDA_STATUS[I]))then
        Result := I -1;
   end;
end;

function TModelAgendaEntitie.Titulo(AValue: string): TModelAgendaEntitie;
begin
   Result := Self;
   FTitulo := AValue.Trim;
end;

function TModelAgendaEntitie.Titulo: string;
begin
   Result := FTitulo;
end;

end.
