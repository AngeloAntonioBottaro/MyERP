unit View.Logs.Busca;

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
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.ExtCtrls,
  Vcl.ComCtrls,
  Vcl.DBCtrls,
  View.Base,
  Data.DB,
  Model.Logs.Busca,
  Utils.ConfGrid;

type
  TViewLogsBusca = class(TViewBase)
    pnGrid: TPanel;
    GridBusca: TDBGrid;
    pnBotton: TPanel;
    pnButtons: TPanel;
    btnImprimir: TButton;
    btnFechar: TButton;
    pnOptions: TPanel;
    lbTotalRegistros: TLabel;
    Panel1: TPanel;
    pnBuscaPeriodo: TPanel;
    Label1: TLabel;
    dtpPeriodoInicial: TDateTimePicker;
    dtpPeriodoFinal: TDateTimePicker;
    pnBuscaModulo: TPanel;
    edtModulo: TEdit;
    gBoxTipoConsulta: TGroupBox;
    cBoxModulo: TComboBox;
    pnBuscaFuncionario: TPanel;
    edtFuncionario: TEdit;
    edtIdFuncionario: TEdit;
    ckBuscaPeriodo: TCheckBox;
    ckBuscaFuncionario: TCheckBox;
    ckBuscaModulo: TCheckBox;
    ckBuscaAcao: TCheckBox;
    ckBuscaReferencia: TCheckBox;
    pnBuscaAcao: TPanel;
    edtAcao: TEdit;
    cBoxAcao: TComboBox;
    pnBuscaReferencia: TPanel;
    edtReferencia: TEdit;
    Panel2: TPanel;
    btnBuscar: TButton;
    DS_Busca: TDataSource;
    DBMemo1: TDBMemo;
    imgConfGrid: TImage;
    procedure ckBuscaPeriodoClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure GridBuscaTitleClick(Column: TColumn);
    procedure edtIdFuncionarioKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtIdFuncionarioExit(Sender: TObject);
  private
    FConfGrid: TUtilsConfGrid;
    FBusca: TModelLogsBusca;
    procedure ConfComponentes;
    procedure GetTotalRegistros;
  public
  end;

var
  ViewLogsBusca: TViewLogsBusca;

implementation

{$R *.dfm}

uses
  MyExceptions,
  MyConnection,
  Common.Utils.MyLibrary,
  Common.Utils.MyVclLibrary,
  Common.Utils.MyConsts,
  Utils.EditsKeyDownExit,
  Model.Sistema.Imagens.DM;

procedure TViewLogsBusca.FormCreate(Sender: TObject);
begin
   inherited;
   FConfGrid := TUtilsConfGrid.New(imgConfGrid, GridBusca, Self.Name);

   FBusca := TModelLogsBusca.Create;
   FBusca.DataSource(DS_Busca);

   dtpPeriodoInicial.Date := Date;
   dtpPeriodoFinal.Date   := Date;
   ckBuscaPeriodo.Checked := True;
   Self.ConfComponentes;
   btnBuscar.Click;
end;

procedure TViewLogsBusca.FormDestroy(Sender: TObject);
begin
   FBusca.Free;
   FConfGrid.Free;
   inherited;
end;

procedure TViewLogsBusca.btnBuscarClick(Sender: TObject);
begin
   FBusca
    .Periodo(ckBuscaPeriodo.Checked, dtpPeriodoInicial.Date, dtpPeriodoFinal.Date)
    .Funcionario(ckBuscaFuncionario.Checked, edtIdFuncionario.Text)
    .Modulo(ckBuscaModulo.Checked, edtModulo.Text, cBoxModulo.ItemIndex)
    .Acao(ckBuscaAcao.Checked, edtAcao.Text, cBoxAcao.ItemIndex)
    .Referencia(ckBuscaReferencia.Checked, edtReferencia.Text)
    .Buscar;

   Self.GetTotalRegistros;
end;

procedure TViewLogsBusca.btnFecharClick(Sender: TObject);
begin
   inherited;
   Self.Close;
end;

procedure TViewLogsBusca.ckBuscaPeriodoClick(Sender: TObject);
begin
   //*VARIOS
   Self.ConfComponentes;
end;

procedure TViewLogsBusca.ConfComponentes;
begin
   pnBuscaPeriodo.Visible     := ckBuscaPeriodo.Checked;
   pnBuscaFuncionario.Visible := ckBuscaFuncionario.Checked;
   pnBuscaModulo.Visible      := ckBuscaModulo.Checked;
   pnBuscaAcao.Visible        := ckBuscaAcao.Checked;
   pnBuscaReferencia.Visible  := ckBuscaReferencia.Checked;
end;

procedure TViewLogsBusca.edtIdFuncionarioExit(Sender: TObject);
begin
   IdFuncionarioExit(edtIdFuncionario, edtFuncionario);
end;

procedure TViewLogsBusca.edtIdFuncionarioKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   IdFuncionarioKeyDown(edtIdFuncionario, Key, Shift);
end;

procedure TViewLogsBusca.GetTotalRegistros;
begin
   lbTotalRegistros.Caption := TOTAL_REGISTROS_LABEL + TOTAL_REGISTROS_DEFAULT;

   if(DS_Busca.DataSet = nil)then
     Exit;

   lbTotalRegistros.Caption := TOTAL_REGISTROS_LABEL + TMyLibrary.CompLeft(DS_Busca.DataSet.RecordCount.ToString, '0', 6);
end;

procedure TViewLogsBusca.GridBuscaTitleClick(Column: TColumn);
begin
   inherited;
   FBusca.IndexFieldNames(Column.FieldName);
end;

end.
