unit Utils.Terminal;

interface

uses
  System.SysUtils;

type
  ITerminal = interface
   ['{5BBE0697-E1BB-40CD-BFBF-E49580FBD217}']
   procedure VerificarTerminal;
  end;

  TUtilsTerminal = class(TInterfacedObject, ITerminal)
  private
    FNomeTerminal: string;
    procedure ValidarIni;
    procedure ConsultarTerminal;
    procedure CadastrarTerminal;
  protected
    procedure VerificarTerminal;
  public
    class function New: ITerminal;
  end;

implementation

uses
  MyConnection,
  Utils.GlobalVariables;

class function TUtilsTerminal.New: ITerminal;
begin
   Result := Self.Create;
end;

procedure TUtilsTerminal.VerificarTerminal;
begin
   Self.ValidarIni;
   Self.ConsultarTerminal;
end;

procedure TUtilsTerminal.ValidarIni;
begin
   FNomeTerminal := 'Servidor';
end;

procedure TUtilsTerminal.ConsultarTerminal;
begin
   {if(FNomeTerminal.Trim.IsEmpty)then
     Self.CadastrarTerminal;

   MyQueryNew
    .Add('SELECT * FROM TERMINAIS')
    .Add('WHERE(TERMINAIS.NOME_TERMINAL = :NOME)')
    .AddParam('NOME', FNomeTerminal.Trim)
    .Open;

   if(MyQuery.IsEmpty)then

   VG_IdTerminal   := MyQuery.FieldByName('ID').AsInteger;
   VG_NomeTerminal := MyQuery.FieldByName('NOME_TERMINAL').AsString;}

   VG_IdTerminal   := 1;
   VG_NomeTerminal := FNomeTerminal;
end;

procedure TUtilsTerminal.CadastrarTerminal;
begin

end;

end.
