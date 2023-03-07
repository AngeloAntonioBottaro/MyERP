unit View.Sistema.Splash;

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
  Vcl.Imaging.jpeg,
  Model.Sistema.Interfaces;

type
  TViewSistemaSplash = class(TForm)
    lbInformacoes: TLabel;
    TimerShow: TTimer;
    imgBack: TImage;
    lbDireitosAutorais: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure TimerShowTimer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    procedure StartSystem;
    procedure ConfComponents;
    procedure WriteMessages(pMessage: String);
    procedure SystemTerminate;
  public
  end;

var
  ViewSistemaSplash: TViewSistemaSplash;

implementation

{$R *.dfm}

uses
  View.Sistema.Main,
  Utils.MyConsts,
  Utils.GlobalVariables,
  Model.Sistema.Splash;

procedure TViewSistemaSplash.FormCreate(Sender: TObject);
begin
   Application.Title := EMPRESA_DESENVOLVEDOR + ' - ERP Simples';
   RefreshVariables;
end;

procedure TViewSistemaSplash.FormShow(Sender: TObject);
begin
   Self.Repaint;
   Self.Visible := True;
   Self.ConfComponents;
end;

procedure TViewSistemaSplash.ConfComponents;
begin
   lbDireitosAutorais.Caption       := VG_Direitos;
   lbDireitosAutorais.Top           := Self.Top + 15;
   lbDireitosAutorais.Width         := Self.Width;
   lbDireitosAutorais.Left          := 0;
   lbDireitosAutorais.Color         := clWhite;
   lbDireitosAutorais.Font.Color    := clWhite;
   lbDireitosAutorais.Font.Name     := 'Tahoma';
   lbDireitosAutorais.Font.Style    := [fsBold];
   lbDireitosAutorais.StyleElements := lbDireitosAutorais.StyleElements - [seClient];

   lbInformacoes.Caption       := EmptyStr;
   lbInformacoes.Top           := Self.Height - 30;
   lbInformacoes.Width         := Self.Width;
   lbInformacoes.Left          := 0;
   lbInformacoes.Color         := clWhite;
   lbInformacoes.Font.Color    := clWhite;
   lbInformacoes.Font.Name     := 'Tahoma';
   lbInformacoes.Font.Style    := [fsBold];
   lbInformacoes.StyleElements := lbInformacoes.StyleElements - [seClient];

   TimerShow.Enabled := True;
end;

procedure TViewSistemaSplash.TimerShowTimer(Sender: TObject);
begin
   TimerShow.Enabled := False;
   Self.StartSystem;
end;

procedure TViewSistemaSplash.StartSystem;
begin
   TModelSistemaSplash.GetInstance
    .DisplayInformation(WriteMessages)
    .StartApplication;

   if(not TModelSistemaSplash.GetInstance.LoadingComplete)then
      Self.SystemTerminate;

   Self.Close;
end;

procedure TViewSistemaSplash.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   CanClose := not TimerShow.Enabled;
end;

procedure TViewSistemaSplash.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Application.CreateForm(TViewSistemaMain, ViewSistemaMain);
   Self.Visible := False;
   Self.Hide;
   Self.Refresh;
end;

procedure TViewSistemaSplash.SystemTerminate;
begin
   Application.Terminate;
   Abort;
end;

procedure TViewSistemaSplash.WriteMessages(pMessage: String);
begin
   lbInformacoes.Caption := pMessage;
   Application.ProcessMessages;
end;

end.
