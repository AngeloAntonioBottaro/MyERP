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
  Utils.GlobalVariables;

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

   if(FUsuarioLogin <> '1')or(FUsuarioSenha <> '1')then
     Self.OnError('Usuário não encontrado');

   VG_UsuarioLogadoId   := 1;
   VG_UsuarioLogadoNome := 'Master';
end;

procedure TModelSistemaLogin.OnError(AMessage: string = '');
begin
   if(not AMessage.IsEmpty)then
     showInformacao(AMessage);

   if(Assigned(FDoError))then
     FDoError();

   Abort;
end;

end.
