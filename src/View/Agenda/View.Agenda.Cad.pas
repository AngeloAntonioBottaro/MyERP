unit View.Agenda.Cad;

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
  View.Base.Cadastros,
  Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TViewAgendaCad = class(TViewBaseCadastros)
    pnTela: TPanel;
    lbStatus: TLabel;
    cBoxStatus: TComboBox;
    lbIdCliente: TLabel;
    lbCliente: TLabel;
    edtIdCliente: TEdit;
    edtCliente: TEdit;
    lbIdFuncionario: TLabel;
    lbFuncionario: TLabel;
    edtIdFuncionario: TEdit;
    edtFuncionario: TEdit;
    mmObservacao: TMemo;
    lbObservação: TLabel;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    lbData: TLabel;
    lbHora: TLabel;
    procedure edtIdClienteExit(Sender: TObject);
    procedure edtIdClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtIdFuncionarioExit(Sender: TObject);
    procedure edtIdFuncionarioKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    procedure FillEntitie;
  public
    procedure InitialConfiguration; override;
    procedure NewEntitie; override;
    procedure FillFields; override;
    procedure OnBusca(AId: Integer); override;
  end;

var
  ViewAgendaCad: TViewAgendaCad;

implementation

{$R *.dfm}

uses
  MyMessage,
  Utils.MyVclLibrary,
  Utils.LibrarySistema,
  Utils.EditsKeyDownExit,
  Utils.GlobalConsts;

procedure TViewAgendaCad.FillEntitie;
begin

end;

procedure TViewAgendaCad.FillFields;
begin
   inherited;

end;

procedure TViewAgendaCad.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if(Key = #13)and(ActiveControl = mmObservacao)then
     Exit;

   inherited;
end;

procedure TViewAgendaCad.InitialConfiguration;
var
  I: Integer;
begin
   cBoxStatus.Items.Clear;
   for I := Low(AGENDA_STATUS) to High(AGENDA_STATUS) do
     cBoxStatus.Items.Add(AGENDA_STATUS[I]);

   cBoxStatus.ItemIndex := -1;
end;

procedure TViewAgendaCad.NewEntitie;
begin
  inherited;

end;

procedure TViewAgendaCad.OnBusca(AId: Integer);
begin
   inherited;

end;

procedure TViewAgendaCad.edtIdClienteExit(Sender: TObject);
begin
   IdClienteExit(edtIdCliente, edtCliente);
end;

procedure TViewAgendaCad.edtIdClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   IdClienteKeyDown(edtIdCliente, Key, Shift);
end;

procedure TViewAgendaCad.edtIdFuncionarioExit(Sender: TObject);
begin
   IdFuncionarioExit(edtIdFuncionario, edtFuncionario);
end;

procedure TViewAgendaCad.edtIdFuncionarioKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   IdFuncionarioKeyDown(edtIdFuncionario, Key, Shift);
end;

end.
