unit Utils.LibrarySistema;

interface

uses
  System.SysUtils,
  System.StrUtils,
  System.Classes;

procedure DebugOnOFF;
procedure ShowDebug(AMsg: string);
procedure CriarComboBoxTipoJuridico(ALines: TStrings);

implementation

uses
  MyMessage,
  Utils.MyConsts,
  Utils.GlobalVariables,
  Utils.GlobalConsts,
  View.Sistema.Main;

procedure DebugOnOFF;
begin
   if(not Assigned(ViewSistemaMain))then
     Exit;

   ViewSistemaMain.Caption := StringReplace(ViewSistemaMain.Caption, DEBUG_CAPTION, '', [rfReplaceAll, rfIgnoreCase]);
   if(VG_DEBUG)then
     ViewSistemaMain.Caption := ViewSistemaMain.Caption + DEBUG_CAPTION;
end;

procedure ShowDebug(AMsg: string);
begin
   if(not VG_DEBUG)then
     Exit;

   VG_DEBUG := ShowQuestionYes('Deseja continuar em modo Debug?', AMsg);

   if(not VG_DEBUG)then
     DebugOnOFF;
end;

procedure CriarComboBoxTipoJuridico(ALines: TStrings);
begin
   ALines.Clear;
   ALines.Add(PESSOA_FISICA);
   ALines.Add(PESSOA_JURIDICA);
end;

end.
