unit View.Sistema.SenhaAdm;

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
  View.Base,
  Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TViewSistemaSenhaAdm = class(TViewBase)
    pnBotton: TPanel;
    btnCancelar: TButton;
    btnOk: TButton;
    pnTela: TPanel;
    lbSenha: TLabel;
    edtSenha: TEdit;
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
  public
  end;

var
  ViewSistemaSenhaAdm: TViewSistemaSenhaAdm;

function ChamaSenhaAdministrativa: Boolean;

implementation

{$R *.dfm}

uses
  MyExceptions,
  Utils.MyConsts,
  Utils.MyLibrary,
  Model.Sistema.Imagens.DM;

function ChamaSenhaAdministrativa: Boolean;
begin
   if(TMyLibrary.UnlockSpecialComands)then
     Exit(True);

   if(ViewSistemaSenhaAdm = nil)then Application.CreateForm(TViewSistemaSenhaAdm, ViewSistemaSenhaAdm);
   try
     Result := ViewSistemaSenhaAdm.ShowModal = mrOk;
   finally
     FreeAndNil(ViewSistemaSenhaAdm);
   end;
end;

procedure TViewSistemaSenhaAdm.btnCancelarClick(Sender: TObject);
begin
   Self.Close;
   ModalResult := mrCancel;
end;

procedure TViewSistemaSenhaAdm.btnOkClick(Sender: TObject);
begin
   if(not Trim(edtSenha.Text).Equals(SENHA_ADMINISTRADOR))then
     raise ExceptionWarning.Create('Senha incorreta', edtSenha);

   Self.Close;
   ModalResult := mrOk;
end;

procedure TViewSistemaSenhaAdm.FormShow(Sender: TObject);
begin
   inherited;
   edtSenha.SetFocus;
end;

end.
