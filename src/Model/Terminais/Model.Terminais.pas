unit Model.Terminais;

interface

uses
  System.SysUtils;

type
  IModelTerminais = interface
   ['{5BBE0697-E1BB-40CD-BFBF-E49580FBD217}']
   procedure VerificarTerminal;
  end;

  TModelTerminais = class(TInterfacedObject, IModelTerminais)
  private
    FNomeTerminal: string;
    procedure ValidarIni;
    procedure RegistrarTerminalIni;
    procedure ConsultarTerminal;
    procedure CadastrarTerminal;
  protected
    procedure VerificarTerminal;
  public
    class function New: IModelTerminais;
  end;

implementation

uses
  MyConnection,
  Utils.GlobalVariables;

class function TModelTerminais.New: IModelTerminais;
begin
   Result := Self.Create;
end;

procedure TModelTerminais.VerificarTerminal;
begin
   Self.ValidarIni;
   Self.ConsultarTerminal;
end;

procedure TModelTerminais.ValidarIni;
begin
   FNomeTerminal := 'Servidor';
   Self.RegistrarTerminalIni;
end;

procedure TModelTerminais.RegistrarTerminalIni;
begin

end;

procedure TModelTerminais.ConsultarTerminal;
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

   if(True)then
     Self.CadastrarTerminal;

   VG_IdTerminal   := 1;
   VG_NomeTerminal := FNomeTerminal;
end;

procedure TModelTerminais.CadastrarTerminal;
begin

end;

end.
