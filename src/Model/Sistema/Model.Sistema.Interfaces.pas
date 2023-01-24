unit Model.Sistema.Interfaces;

interface

uses
  System.SysUtils;

type
  IModelSistemaSplash = interface
   ['{B36FD284-E0A3-4C21-AB5F-6334B02FD0B8}']
   function DisplayInformation(AValue: TProc<string>): IModelSistemaSplash;
   function StartApplication: IModelSistemaSplash;
   function LoadingComplete: Boolean;
  end;

  IModelSistemaLogin = interface
   ['{B36FD284-E0A3-4C21-AB5F-6334B02FD0B8}']
   function DoError(AError: TProc): IModelSistemaLogin;
   function UsuarioLogin(AValue: string): IModelSistemaLogin;
   function UsuarioSenha(AValue: string): IModelSistemaLogin;
   function ProcessaLogin: IModelSistemaLogin;
  end;

  IModelSistemaMain = interface
   ['{1654D3E6-CB56-4575-A40C-5C71FD6E8997}']
   function OnCriarIconesAtalhos(ACriarIconesAtalhos: TProc): IModelSistemaMain;
   function OnFormResize(AFormResize: TProc): IModelSistemaMain;
   function OnLoggin(ALoggin: TProc): IModelSistemaMain;
   function OnProcessImageLogo(AProcessImageLogo: TProc<string>): IModelSistemaMain;
   function OnProcessStatus(AProcessStatus: TProc): IModelSistemaMain;
   function ConfiguraFormulario: IModelSistemaMain;
   function FormResize: IModelSistemaMain;
   function FormShow: IModelSistemaMain;
  end;

implementation

end.
