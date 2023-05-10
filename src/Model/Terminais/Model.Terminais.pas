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
    FNetUserName: string;
    FMachineName: string;
    procedure ConsultarTerminal;
    procedure CadastrarTerminal;
  protected
    procedure VerificarTerminal;
  public
    class function New: IModelTerminais;
    constructor Create;
  end;

implementation

uses
  MyConnection,
  MyExceptions,
  Common.Utils.MyLibrary,
  Utils.GlobalVariables;

class function TModelTerminais.New: IModelTerminais;
begin
   Result := Self.Create;
end;

constructor TModelTerminais.Create;
begin
   FNetUserName := TMyLibrary.GetNetUserName;
   FMachineName := TMyLibrary.GetMachineName;
end;

procedure TModelTerminais.VerificarTerminal;
begin
   if(FNetUserName.IsEmpty)or(FMachineName.IsEmpty)then
     raise ExceptionRequired.Create('Dados do terminal não encontrados');

   Self.ConsultarTerminal;
   if(MyQuery.IsEmpty)then
     Self.CadastrarTerminal;

   VG_IdTerminal   := MyQuery.FieldByName('ID').AsInteger;
   VG_NomeTerminal := MyQuery.FieldByName('NOME').AsString;
end;

procedure TModelTerminais.ConsultarTerminal;
begin
   MyQueryNew
    .Add('SELECT FIRST 1 * FROM TERMINAIS')
    .Add('WHERE(TERMINAIS.NOME_USUARIO = :NOME_USUARIO)AND(TERMINAIS.NOME_PC = :NOME_PC)')
    .AddParam('NOME_USUARIO', FNetUserName)
    .AddParam('NOME_PC', FMachineName)
    .Open;
end;

procedure TModelTerminais.CadastrarTerminal;
begin
   MyQueryNew
    .Add('INSERT INTO TERMINAIS(NOME, NOME_USUARIO, NOME_PC)')
    .Add('VALUES(:NOME, :NOME_USUARIO, :NOME_PC)')
    .AddParam('NOME', FNetUserName)
    .AddParam('NOME_USUARIO', FNetUserName)
    .AddParam('NOME_PC', FMachineName)
    .ExecSQL;

   Self.ConsultarTerminal;
end;

end.
