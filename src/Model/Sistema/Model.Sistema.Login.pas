unit Model.Sistema.Login;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Model.Sistema.Interfaces;

type
  TModelSistemaLogin = class(TInterfacedObject, IModelSistemaLogin)
  private
    FUsuarioLogin: string;
    FUsuarioSenha: string;
    FDoError: TProc;
    procedure OnError(AMessage: string = '');
  protected
    function DoError(AError: TProc): IModelSistemaLogin;
    function UsuarioLogin(AValue: string): IModelSistemaLogin;
    function UsuarioSenha(AValue: string): IModelSistemaLogin;
    function ProcessaLogin: IModelSistemaLogin;
  public
    class function New: IModelSistemaLogin;
  end;

implementation

uses
  MyMessage,
  Myconnection,
  Utils.GlobalVariables,
  Utils.Versao,
  Model.Logs;

class function TModelSistemaLogin.New: IModelSistemaLogin;
begin
   Result := Self.Create;
end;

function TModelSistemaLogin.DoError(AError: TProc): IModelSistemaLogin;
begin
   Result   := Self;
   FDoError := AError;
end;

function TModelSistemaLogin.UsuarioLogin(AValue: string): IModelSistemaLogin;
begin
   Result := Self;
   FUsuarioLogin := AValue.Trim;
end;

function TModelSistemaLogin.UsuarioSenha(AValue: string): IModelSistemaLogin;
begin
   Result := Self;
   FUsuarioSenha := AValue.Trim;
end;

function TModelSistemaLogin.ProcessaLogin: IModelSistemaLogin;
begin
   Result := Self;

   if(FUsuarioLogin.IsEmpty)then
     Self.OnError('Login do usuário não informado');

   if(FUsuarioSenha.IsEmpty)then
     Self.OnError('Senha do usuário não informada');

   MyQueryNew
    .Add('select id, razao_social from funcionarios where(login = :login)and(senha = :senha);')
    .AddParam('login', FUsuarioLogin)
    .AddParam('senha', FUsuarioSenha)
    .Open;

   if(MyQuery.IsEmpty)then
     Self.OnError('Usuário/senha não encontrados');

   VG_UsuarioLogadoId   := MyQuery.FieldByName('id').AsInteger;
   VG_UsuarioLogadoNome := MyQuery.FieldByName('razao_social').AsString;

   TModelLogs.New.Gravar('Tela de login',
                         'Logando no sistema',
                         'Usuário logou no sistema pelo terminal: "' + VG_IdTerminal.ToString + '-' + VG_NomeTerminal + '".' +
                         TUtilsVersao.CompleteVersion,
                         VG_UsuarioLogadoId);
end;

procedure TModelSistemaLogin.OnError(AMessage: string = '');
begin
   if(not AMessage.IsEmpty)then
     ShowInformation(AMessage);

   if(Assigned(FDoError))then
     FDoError();

   Abort;
end;

end.
