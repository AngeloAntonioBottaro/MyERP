unit View.Sistema.MenuConf;

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
  Vcl.CheckLst,
  Vcl.ExtCtrls;

type
  TItemMenu = class
  private
    FNome: string;
  public
    constructor Create(ANomeItem: string);
    function Nome: string;
  end;

type
  TViewSistemaMenuConf = class(TViewBase)
    ckList: TCheckListBox;
    pnButtons: TPanel;
    btnGravar: TButton;
    btnFechar: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnFecharClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
  public
  end;

var
  ViewSistemaMenuConf: TViewSistemaMenuConf;

implementation

{$R *.dfm}

uses
  Model.Sistema.Imagens.DM;

{ TItemMenu }

constructor TItemMenu.Create(ANomeItem: string);
begin
   FNome := ANomeItem;
end;

function TItemMenu.Nome: string;
begin
   Result := FNome;
end;

procedure TViewSistemaMenuConf.btnFecharClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TViewSistemaMenuConf.btnGravarClick(Sender: TObject);
begin
   inherited;
   ShowMessage(TItemMenu(ckList.Items.Objects[0]).Nome);
end;

procedure TViewSistemaMenuConf.FormClose(Sender: TObject; var Action: TCloseAction);
var
  I: Integer;
begin
   inherited;
   for I := 0 to Pred(ckList.Count) do
   begin
      if(ckList.Checked[I])then
        ckList.Items.Objects[I].Free;
   end;
end;

procedure TViewSistemaMenuConf.FormShow(Sender: TObject);
var
  I: Integer;
begin
   inherited;
   {for I := 0 to Pred(MENU.Count) do
   begin
      ckList.AddItem(MENU.Caption, TItemMenu.Create(MENU.Name));
   end; }
end;

end.
