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
    FDOCancel: TProc;
  protected
    function DoCancel(ACancel: TProc): IModelSistemaLogin;
    function UsuarioLogin(AValue: string): IModelSistemaLogin;
    function UsuarioSenha(AValue: string): IModelSistemaLogin;
    function ProcessaLogin: IModelSistemaLogin;
  public
    class function New: IModelSistemaLogin;
  end;

implementation

uses
  MyExceptions,
  Utils.GlobalVariables;

class function TModelSistemaLogin.New: IModelSistemaLogin;
begin
   Result := Self.Create;
end;

function TModelSistemaLogin.DoCancel(ACancel: TProc): IModelSistemaLogin;
begin
   Result := Self;
   FDOCancel := ACancel;
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
     raise ExceptionMsg.Create('Login do usuário não informado');

   if(FUsuarioSenha.IsEmpty)then
     raise ExceptionMsg.Create('Senha do usuário não informada');

   if(FUsuarioLogin <> '1')or(FUsuarioSenha <> '1')then
     raise ExceptionMsg.Create('Usuário não encontrado');

   VG_UsuarioLogadoId   := 1;
   VG_UsuarioLogadoNome := 'Master';
end;

end.
