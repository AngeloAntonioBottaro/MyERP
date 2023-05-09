unit Utils.LibrarySistema;

interface

uses
  System.SysUtils,
  System.StrUtils,
  System.Classes,
  Vcl.Forms;

procedure DebugOnOFF;
procedure CriarComboBoxTipoJuridico(ALines: TStrings);
procedure CriarComboBoxTipoLancamentoFinanceiro(ALines: TStrings);

procedure CriarFormMsgJaAberto(AClass: TComponentClass; var Reference);
{$REGION 'MENSSAGES'}
procedure ShowDebug(AMsg: string);
procedure ExceptionMsgRegistroNaoInformadoAlteracaoStatus(AEntitie: string);
procedure ExceptionMsgRegistroNaoInformadoConsulta(AEntitie: string);
procedure ExceptionMsgRegistroNaoInformadoExclusao(AEntitie: string);
{$ENDREGION 'MENSSAGES'}


implementation

uses
  MyMessage,
  MyExceptions,
  Common.Utils.MyConsts,
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

procedure CriarComboBoxTipoJuridico(ALines: TStrings);
begin
   ALines.Clear;
   ALines.Add(PESSOA_FISICA);
   ALines.Add(PESSOA_JURIDICA);
end;

procedure CriarComboBoxTipoLancamentoFinanceiro(ALines: TStrings);
begin
   ALines.Clear;
   ALines.Add(TIPO_LANCAMENTO_CAIXA);
   ALines.Add(TIPO_LANCAMENTO_FINANCEIRO);
   ALines.Add(TIPO_LANCAMENTO_SEMCONTROLE);
end;

procedure CriarFormMsgJaAberto(AClass: TComponentClass; var Reference);
begin
   if(TForm(Reference) = nil)then Application.CreateForm(AClass, Reference);
   if(TForm(Reference).Showing)then
     raise ExceptionInformation.Create(MSG_TELA_JA_ABERTA);
end;

{$REGION 'MENSSAGES'}
procedure ShowDebug(AMsg: string);
begin
   if(not VG_DEBUG)then
     Exit;

   VG_DEBUG := ShowQuestionYes('Deseja continuar em modo Debug?', AMsg);

   if(not VG_DEBUG)then
     DebugOnOFF;
end;

procedure ExceptionMsgRegistroNaoInformado(AEntitie, AAcao: string);
begin
   raise ExceptionRequired.Create(AEntitie + ' não selecionado(a)/informado(a) para ' + AAcao);
end;

procedure ExceptionMsgRegistroNaoInformadoAlteracaoStatus(AEntitie: string);
begin
   ExceptionMsgRegistroNaoInformado(AEntitie, 'alteração de status');
end;

procedure ExceptionMsgRegistroNaoInformadoConsulta(AEntitie: string);
begin
   ExceptionMsgRegistroNaoInformado(AEntitie, 'consulta');
end;

procedure ExceptionMsgRegistroNaoInformadoExclusao(AEntitie: string);
begin
   ExceptionMsgRegistroNaoInformado(AEntitie, 'exclusão');
end;
{$ENDREGION 'MENSSAGES'}

end.
