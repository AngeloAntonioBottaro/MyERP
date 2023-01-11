unit View.Login;

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
  TViewLogin = class(TViewBase)
    edtUsuarioLogin: TLabeledEdit;
    edtUsuarioSenha: TLabeledEdit;
    btnLogar: TButton;
    btnCancelar: TButton;
    Image1: TImage;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnLogarClick(Sender: TObject);
  private
    procedure SystemTerminate;
  public
  end;

var
  ViewLogin: TViewLogin;

implementation

{$R *.dfm}

uses
  Utils.GlobalVariables,
  Model.Sistema.Login;

procedure TViewLogin.btnCancelarClick(Sender: TObject);
begin
   Self.SystemTerminate;
end;

procedure TViewLogin.btnLogarClick(Sender: TObject);
begin
   TModelSistemaLogin.New
    .DoCancel(Self.SystemTerminate)
    .UsuarioLogin(edtUsuarioLogin.Text)
    .UsuarioSenha(edtUsuarioSenha.Text)
    .ProcessaLogin;

   if(VG_UsuarioLogadoId = 0)then
     Exit;

   Self.Close;
   ModalResult := mrOk;
end;

procedure TViewLogin.SystemTerminate;
begin
   Application.Terminate;
end;

end.
