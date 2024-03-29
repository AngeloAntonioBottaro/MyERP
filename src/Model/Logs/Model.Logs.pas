unit Model.Logs;

interface

uses
  System.SysUtils,
  System.StrUtils;

type
  ILog = interface
   ['{3AEF44F8-4BFA-496F-924A-C066C5480A7E}']
   procedure Gravar(AModulo, AAcao, ADescricao: string; AIdReferencia: string = ''); overload;
   procedure Gravar(AModulo, AAcao, ADescricao: string; AIdReferencia: Integer = 0); overload;
  end;

  TModelLogs = class(TInterfacedObject, ILog)
  private
    FModulo: string;
    FAcao: string;
    FIdReferencia: Integer;
    FDescricao: string;
    procedure GravarNoBanco;
  protected
    procedure Gravar(AModulo, AAcao, ADescricao, AIdReferencia: string); overload;
    procedure Gravar(AModulo, AAcao, ADescricao: string; AIdReferencia: Integer); overload;
  public
    class function New: ILog;
  end;

implementation

uses
  MyConnection,
  MyExceptions,
  MyMessage,
  Utils.GlobalVariables;

class function TModelLogs.New: ILog;
begin
   Result := Self.Create;
end;

procedure TModelLogs.Gravar(AModulo, AAcao, ADescricao: string; AIdReferencia: string);
begin
   FModulo       := AModulo.Trim;
   FAcao         := AAcao.Trim;
   FIdReferencia := StrToIntDef(AIdReferencia, 0);
   FDescricao    := ADescricao.Trim;
   Self.GravarNoBanco;
end;

procedure TModelLogs.Gravar(AModulo, AAcao, ADescricao: string; AIdReferencia: Integer);
begin
   FModulo       := AModulo.Trim;
   FAcao         := AAcao.Trim;
   FIdReferencia := AIdReferencia;
   FDescricao    := ADescricao.Trim;
   Self.GravarNoBanco;
end;

procedure TModelLogs.GravarNoBanco;
begin
   try
     MyQueryNew
      .Add('INSERT INTO LOGS(DATA, HORA, ID_FUNCIONARIO, MODULO, ACAO, DESCRICAO, REFERENCIA, ID_TERMINAL) VALUES ')
      .Add('(:DATA, :HORA, :ID_FUNCIONARIO, :MODULO, :ACAO, :DESCRICAO, :REFERENCIA, :ID_TERMINAL)')
      .AddParam('DATA', Date)
      .AddParam('HORA', Time)
      .AddParam('ID_FUNCIONARIO', VG_UsuarioLogadoId)
      .AddParam('MODULO', FModulo)
      .AddParam('ACAO', FAcao)
      .AddParam('DESCRICAO', FDescricao)
      .AddParam('REFERENCIA', FIdReferencia)
      .AddParam('ID_TERMINAL', VG_IdTerminal)
      .ExecSQL;
   except on E: Exception do
     raise ExceptionError.Create('Falha ao salvar o log' + sLineBreak + 'Mensagem: ' + E.Message);
   end;
end;

end.
