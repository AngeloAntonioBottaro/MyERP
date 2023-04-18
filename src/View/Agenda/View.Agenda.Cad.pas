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
  Vcl.ExtCtrls,
  Vcl.ComCtrls,
  Model.Agenda.Interfaces,
  Model.Agenda.Entitie;

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
    dtpData: TDateTimePicker;
    dtpHora: TDateTimePicker;
    lbData: TLabel;
    lbHora: TLabel;
    lbId: TLabel;
    edtId: TEdit;
    lbTitulo: TLabel;
    edtTitulo: TEdit;
    procedure edtIdClienteExit(Sender: TObject);
    procedure edtIdClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtIdFuncionarioExit(Sender: TObject);
    procedure edtIdFuncionarioKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
  private
    FAgenda: IModelAgendaFactory<TModelAgendaEntitie>;
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
  Utils.MyConsts,
  Utils.GlobalConsts,
  Model.Agenda.Factory,
  View.Agenda.Busca;

procedure TViewAgendaCad.btnAlterarClick(Sender: TObject);
begin
   inherited;
   if(not Assigned(FAgenda))then
     Exit;

   if(not (FAgenda.Entitie.Id > 0))then
     Exit;

   Self.StartOperations;
end;

procedure TViewAgendaCad.btnBuscarClick(Sender: TObject);
begin
   inherited;
   CriarFormMsgJaAberto(TViewAgendaBusca, ViewAgendaBusca);
   try
     ViewAgendaBusca.btnCadastro.Enabled := False;
     ViewAgendaBusca.FOnBusca := Self.OnBusca;
     ViewAgendaBusca.ShowModal;
   finally
     FreeAndNil(ViewAgendaBusca);
   end;
end;

procedure TViewAgendaCad.btnExcluirClick(Sender: TObject);
begin
   inherited;
   if(edtId.Text = EmptyStr)then
     Exit;

   FAgenda.Deletar;
   Self.EndOperations;
   Self.EmptyFields;
end;

procedure TViewAgendaCad.btnGravarClick(Sender: TObject);
begin
   inherited;
   Self.FillEntitie;
   FAgenda.Gravar;

   Self.EndOperations;
   if(Trim(edtId.Text).IsEmpty)then
     Self.EmptyFields;
end;

procedure TViewAgendaCad.btnNovoClick(Sender: TObject);
begin
   inherited;
   dtpData.Date := Now;
   dtpHora.Time := Now;
   cBoxStatus.ItemIndex := 0;
   TMyVclLibrary.SetFocusOn(edtIdCliente);
end;

procedure TViewAgendaCad.FillEntitie;
begin
   FAgenda
    .Entitie
     .Id(edtId.Text)
     .Cliente(edtIdCliente.Text)
     .Funcionario(edtIdFuncionario.Text)
     .Data(DateToStr(dtpData.Date))
     .Hora(TimeToStr(dtpHora.Time))
     .Titulo(edtTitulo.Text)
     .Observacao(mmObservacao.Lines.Text)
     .Status(cBoxStatus.Text)
     .End_Entitie;
end;

procedure TViewAgendaCad.FillFields;
begin
   if(not Assigned(FAgenda))then
     Exit;

   edtId.Text            := FAgenda.Entitie.IdMascara;
   edtIdCliente.Text     := FAgenda.Entitie.ClienteMascara;
   edtIdFuncionario.Text := FAgenda.Entitie.FuncionarioMascara;
   dtpData.Date          := FAgenda.Entitie.Data;
   dtpHora.Time          := FAgenda.Entitie.Hora;
   edtTitulo.Text        := FAgenda.Entitie.Titulo;
   cBoxStatus.ItemIndex  := FAgenda.Entitie.StatusComboBox;
   mmObservacao.Lines.Clear;
   mmObservacao.Lines.Add(FAgenda.Entitie.Observacao);
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

   dtpData.Date              := Now;
   dtpHora.Time              := Now;
   mmObservacao.MaxLength    := 1000;
   mmObservacao.Lines.Clear;
   edtIdCliente.ShowHint     := True;
   edtIdCliente.Hint         := HINT_ATALHO_CONSULTA;
   edtIdFuncionario.ShowHint := True;
   edtIdFuncionario.Hint     := HINT_ATALHO_CONSULTA;
end;

procedure TViewAgendaCad.NewEntitie;
begin
   FAgenda := TModelAgendaFactory.New;
end;

procedure TViewAgendaCad.OnBusca(AId: Integer);
begin
   Self.NewEntitie;
   FAgenda
    .Entitie
     .Id(AId)
     .End_Entitie
    .ConsultarEntitie;
   Self.FillFields;
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
