unit View.Base.Busca;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Data.DB,
  View.Base,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Vcl.Menus,
  Vcl.ComCtrls,
  Vcl.Imaging.pngimage,
  Utils.ConfGrid,
  Utils.ConfMenu;

type
  TViewBaseBusca = class(TViewBase)
    pnTop: TPanel;
    pnBotton: TPanel;
    pnButtons: TPanel;
    btnCadastro: TButton;
    btnVincular: TButton;
    DS_Busca: TDataSource;
    btnFechar: TButton;
    TimerBuscar: TTimer;
    MenuBusca: TPopupMenu;
    Atualizar1: TMenuItem;
    gBoxTipoConsulta: TGroupBox;
    pnBuscarPeriodo: TPanel;
    pnBuscarConteudo: TPanel;
    lbBusca: TLabel;
    edtBusca: TEdit;
    ckBuscarInativos: TCheckBox;
    lbBuscaPeriodo: TLabel;
    dtpPeriodoInicial: TDateTimePicker;
    Label1: TLabel;
    dtpPeriodoFinal: TDateTimePicker;
    N1: TMenuItem;
    Excluir1: TMenuItem;
    N2: TMenuItem;
    AtivarInativar1: TMenuItem;
    pnGrid: TPanel;
    GridBusca: TDBGrid;
    imgConfGrid: TImage;
    pnBuscarComboBox: TPanel;
    Label2: TLabel;
    cBoxBusca: TComboBox;
    imgConfMenu: TImage;
    pnOptions: TPanel;
    lbTotalRegistros: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GridBuscaDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnVincularClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure TimerBuscarTimer(Sender: TObject);
    procedure Atualizar1Click(Sender: TObject);
    procedure edtBuscaKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GridBuscaDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Excluir1Click(Sender: TObject);
    procedure AtivarInativar1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cBoxBuscaChange(Sender: TObject);
    procedure dtpPeriodoInicialExit(Sender: TObject);
  private
    FConfGrid: TUtilsConfGrid;
    FConfMenu: TUtilsConfMenu;
    procedure ValidacoesBasicas;
    procedure GetTotalRegistros;
  public
    FGridConf: TDBGrid;
    FNomeConf: string;
    FOnBusca: TProc<Integer>;
    procedure Buscar; virtual;
  end;

var
  ViewBaseBusca: TViewBaseBusca;

implementation

{$R *.dfm}

uses
  MyExceptions,
  MyConnection,
  MyVclLibrary,
  MyDBGridLibrary,
  Common.Utils.MyLibrary,
  Common.Utils.MyConsts,
  Model.Sistema.Imagens.DM;

procedure TViewBaseBusca.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   inherited;
   btnCadastro.Enabled := True;
   btnVincular.Enabled := True;
   FOnBusca            := nil;
end;

procedure TViewBaseBusca.FormCreate(Sender: TObject);
begin
   inherited;
   FConfGrid := TUtilsConfGrid.New(imgConfGrid, FGridConf, FNomeConf);
   FConfMenu := TUtilsConfMenu.New(imgConfMenu, MenuBusca, FNomeConf);

   TimerBuscar.Enabled    := False;
   dtpPeriodoInicial.Date := Now;
   dtpPeriodoFinal.Date   := Now;
end;

procedure TViewBaseBusca.FormDestroy(Sender: TObject);
begin
   FConfMenu.Free;
   FConfGrid.Free;
   inherited;
end;

procedure TViewBaseBusca.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   inherited;
   case(Key)of
    VK_F5: if(Shift = [])then Self.Buscar;
    VK_UP, VK_DOWN: if(ActiveControl <> GridBusca)then GridBusca.SetFocus;
   end;
end;

procedure TViewBaseBusca.FormShow(Sender: TObject);
begin
   Self.GetTotalRegistros;
end;

procedure TViewBaseBusca.AtivarInativar1Click(Sender: TObject);
begin
   inherited;
   Self.ValidacoesBasicas;
end;

procedure TViewBaseBusca.Atualizar1Click(Sender: TObject);
begin
   Self.Buscar;
end;

procedure TViewBaseBusca.btnFecharClick(Sender: TObject);
begin
   inherited;
   Self.Close;
   Self.ModalResult := mrClose;
end;

procedure TViewBaseBusca.btnVincularClick(Sender: TObject);
begin
   inherited;
   Self.ValidacoesBasicas;

   if(not Assigned(FOnBusca))then
     raise ExceptionRequired.Create('Procedimento para v�nculo n�o informado');

   FOnBusca(DS_Busca.DataSet.FieldByName('ID').AsInteger);
   Self.Close;
   Self.ModalResult := mrOk;
end;

procedure TViewBaseBusca.Buscar;
begin
   Self.GetTotalRegistros;
end;

procedure TViewBaseBusca.cBoxBuscaChange(Sender: TObject);
begin
   TimerBuscar.Enabled := False;
   TimerBuscar.Enabled := True;
end;

procedure TViewBaseBusca.edtBuscaKeyPress(Sender: TObject; var Key: Char);
begin
   TimerBuscar.Enabled := False;
   TimerBuscar.Enabled := True;
end;

procedure TViewBaseBusca.Excluir1Click(Sender: TObject);
begin
   inherited;
   Self.ValidacoesBasicas;
end;

procedure TViewBaseBusca.GetTotalRegistros;
begin
   lbTotalRegistros.Caption := TOTAL_REGISTROS_LABEL + TOTAL_REGISTROS_DEFAULT;

   if(DS_Busca.DataSet = nil)then
     Exit;

   lbTotalRegistros.Caption := TOTAL_REGISTROS_LABEL + TMyLibrary.CompLeft(DS_Busca.DataSet.RecordCount);
end;

procedure TViewBaseBusca.GridBuscaDblClick(Sender: TObject);
begin
   inherited;
   if(btnVincular.Visible)and(btnVincular.Enabled)then
     btnVincular.Click;
end;

procedure TViewBaseBusca.GridBuscaDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   TUtilsDBGrid.GridDrawColumnCell(TDBGrid(Sender), Rect, DataCol, Column, Vcl.Grids.TGridDrawState(State));
end;

procedure TViewBaseBusca.TimerBuscarTimer(Sender: TObject);
begin
   TimerBuscar.Enabled := False;
   Self.Buscar;
end;

procedure TViewBaseBusca.ValidacoesBasicas;
var
  LMsg: string;
begin
   LMsg := 'A��o n�o pode ser realizada. Nenhum registro encontrado';
   if(DS_Busca.DataSet = nil)then
     raise ExceptionRequired.Create(LMsg, 'Query de busca n�o informada');

   if(DS_Busca.DataSet.IsEmpty)then
     raise ExceptionRequired.Create(LMsg);
end;

procedure TViewBaseBusca.dtpPeriodoInicialExit(Sender: TObject);
begin
   if(dtpPeriodoInicial.Date > dtpPeriodoFinal.Date)then
     raise ExceptionWarning.Create('Data inicial n�o pode ser maior que a data final', dtpPeriodoFinal);
end;

end.
