unit View.Base.Cadastros;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  View.Base,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ComCtrls,
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
    btnAlterar: TButton;
    procedure btnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnNovoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
    procedure StartOperations;
    procedure EndOperations;
    procedure EmptyFields;
  end;

var
  ViewBaseCadastros: TViewBaseCadastros;

implementation

{$R *.dfm}

procedure TViewBaseCadastros.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if(not btnFechar.Enabled)then
     abort;
end;

procedure TViewBaseCadastros.FormCreate(Sender: TObject);
begin
   inherited;
   Self.EndOperations;
end;

procedure TViewBaseCadastros.btnNovoClick(Sender: TObject);
begin
   Self.EmptyFields;
   Self.StartOperations;
end;

procedure TViewBaseCadastros.btnCancelarClick(Sender: TObject);
begin
   Self.EndOperations;
   Self.EmptyFields;
end;

procedure TViewBaseCadastros.btnFecharClick(Sender: TObject);
begin
   Self.Close;
end;

procedure TViewBaseCadastros.StartOperations;
begin
   btnNovo.Enabled     := False;
   btnGravar.Enabled   := True;
   btnCancelar.Enabled := True;
   btnExcluir.Enabled  := False;
   btnAlterar.Enabled  := False;
   btnFechar.Enabled   := False;
end;

procedure TViewBaseCadastros.EmptyFields;
var
  I: Integer;
begin
   for I := 0 to Pred(Self.ComponentCount) do
   begin
      if(Self.Components[I] is TEdit)then
        TEdit(Self.Components[I]).Clear
      else if(Self.Components[I] is TDateTimePicker)then
        TDateTimePicker(Self.Components[I]).Date := Now
      else if(Self.Components[I] is TComboBox)then
        TComboBox(Self.Components[I]).ItemIndex := -1;
   end;
end;

procedure TViewBaseCadastros.EndOperations;
begin
   btnNovo.Enabled     := True;
   btnGravar.Enabled   := False;
   btnCancelar.Enabled := False;
   btnExcluir.Enabled  := True;
   btnAlterar.Enabled  := True;
   btnFechar.Enabled   := True;
end;

end.
