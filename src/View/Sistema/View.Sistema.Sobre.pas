unit View.Sistema.Sobre;

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
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.Imaging.pngimage;

type
  TViewSistemaSobre = class(TViewBase)
    Panel1: TPanel;
    lbSistema: TLabel;
    pnGithub: TPanel;
    lbGithub: TLabel;
    imgGithub: TImage;
    Panel4: TPanel;
    Label4: TLabel;
    Image3: TImage;
    pnEmail: TPanel;
    lbEmail: TLabel;
    imgEmail: TImage;
    pnTelefone: TPanel;
    lbTelefone: TLabel;
    imgTelefone: TImage;
    procedure pnGithubClick(Sender: TObject);
    procedure pnEmailClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lbGithubMouseEnter(Sender: TObject);
    procedure lbGithubMouseLeave(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  ViewSistemaSobre: TViewSistemaSobre;

implementation

{$R *.dfm}

uses
  Common.Utils.MyVclLibrary,
  Common.Utils.Myconsts;

procedure TViewSistemaSobre.FormCreate(Sender: TObject);
begin
   inherited;
   Self.BorderIcons := [biSystemMenu];
end;

procedure TViewSistemaSobre.FormShow(Sender: TObject);
begin
   inherited;
   lbSistema.Caption  := Application.Title;
   lbEmail.Caption    := EMAIL_DESENVOLVEDOR;
   lbTelefone.Caption := TELEFONE_DESENVOLVEDOR;
   lbGithub.Caption   := GITHUB_DESENVOLVEDOR;
end;

procedure TViewSistemaSobre.pnEmailClick(Sender: TObject);
begin
   TMyVclLibrary.CopyToClipBoard(EMAIL_DESENVOLVEDOR);
end;

procedure TViewSistemaSobre.pnGithubClick(Sender: TObject);
begin
   TMyVclLibrary.OpenLink(lbGithub.Caption);
end;

procedure TViewSistemaSobre.lbGithubMouseEnter(Sender: TObject);
begin
   lbGithub.StyleElements := [];
   lbGithub.Font.Color := clBlue;
end;

procedure TViewSistemaSobre.lbGithubMouseLeave(Sender: TObject);
begin
   lbGithub.StyleElements := [seFont, seClient, seBorder];
   lbGithub.Font.Color := clWindowText;
end;

end.
