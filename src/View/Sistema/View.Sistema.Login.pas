unit View.Sistema.Login;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Imaging.pngimage,
  View.Base;

type
  TViewSistemaLogin = class(TViewBase)
    edtUsuarioSenha: TLabeledEdit;
    btnLogar: TButton;
    btnCancelar: TButton;
    Image1: TImage;
    edtUsuarioLogin: TLabeledEdit;
    imgConf: TImage;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnLogarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure imgConfClick(Sender: TObject);
  private
    procedure OnError;
  public
  end;

var
  ViewSistemaLogin: TViewSistemaLogin;

implementation

{$R *.dfm}

uses
  Utils.MyVclLibrary,
  Utils.GlobalVariables,
  Model.Sistema.Imagens.DM,
  MyConnectionConfiguration,
  Model.Sistema.Login;

procedure TViewSistemaLogin.btnCancelarClick(Sender: TObject);
begin
   Self.SystemTerminate;
end;

procedure TViewSistemaLogin.btnLogarClick(Sender: TObject);
begin
   TModelSistemaLogin.New
    .DoError(Self.OnError)
    .UsuarioLogin(edtUsuarioLogin.Text)
    .UsuarioSenha(edtUsuarioSenha.Text)
    .ProcessaLogin;

   if(VG_UsuarioLogadoId = 0)then
     Exit;

   Self.Close;
end;

procedure TViewSistemaLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if(VG_UsuarioLogadoId = 0)then
     Self.SystemTerminate;
end;

procedure TViewSistemaLogin.imgConfClick(Sender: TObject);
var
  LMCC: TMyConnectionConfiguration;
begin
   LMCC := TMyConnectionConfiguration.Create;
   try
     LMCC.ListConfigurations;
   finally
     LMCC.Free;
   end;
end;

procedure TViewSistemaLogin.OnError;
begin
   TMyVclLibrary.SetFocusOn(edtUsuarioLogin);
end;

end.
