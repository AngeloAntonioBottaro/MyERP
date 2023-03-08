unit View.Base.Cadastros;

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
  Vcl.StdCtrls;

type
  TViewBaseCadastros = class(TViewBase)
    pnButtons: TPanel;
    btnNovo: TButton;
    btnGravar: TButton;
    btnCancelar: TButton;
    btnExcluir: TButton;
    btnBuscar: TButton;
    btnFechar: TButton;
    procedure btnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  public
  end;

var
  ViewBaseCadastros: TViewBaseCadastros;

implementation

{$R *.dfm}

procedure TViewBaseCadastros.btnFecharClick(Sender: TObject);
begin
   Self.Close;
end;

procedure TViewBaseCadastros.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if(not btnFechar.Enabled)then
     Exit;
end;

end.
