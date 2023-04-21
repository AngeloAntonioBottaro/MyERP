unit View.Logs.Busca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, View.Base, Data.DB, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.ComCtrls;

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
    edtBusca: TEdit;
    gBoxTipoConsulta: TGroupBox;
    cBoxBusca: TComboBox;
    pnBuscaFuncionario: TPanel;
    Edit1: TEdit;
    Edit2: TEdit;
    ckBuscaPeriodo: TCheckBox;
    ckBuscaFuncionario: TCheckBox;
    ckBuscaModulo: TCheckBox;
    ckBuscaAcao: TCheckBox;
    ckBuscaReferencia: TCheckBox;
    pnBuscaAcao: TPanel;
    Edit3: TEdit;
    ComboBox1: TComboBox;
    pnBuscaReferencia: TPanel;
    Edit5: TEdit;
    Panel2: TPanel;
    btnBuscar: TButton;
    DS_Busca: TDataSource;
    procedure ckBuscaPeriodoClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
  private
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
  Utils.MyLibrary,
  Utils.MyVclLibrary,
  Utils.MyConsts,
  Model.Sistema.Imagens.DM;

procedure TViewLogsBusca.btnBuscarClick(Sender: TObject);
begin


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

procedure TViewLogsBusca.FormCreate(Sender: TObject);
begin
   inherited;
   dtpPeriodoInicial.Date := Date;
   dtpPeriodoFinal.Date   := Date;
   ckBuscaPeriodo.Checked := True;
   Self.ConfComponentes;
   Self.GetTotalRegistros;
   btnBuscar.Click;
end;

procedure TViewLogsBusca.GetTotalRegistros;
begin
   lbTotalRegistros.Caption := TOTAL_REGISTROS_LABEL + TOTAL_REGISTROS_DEFAULT;

   if(DS_Busca.DataSet = nil)then
     Exit;

   lbTotalRegistros.Caption := TOTAL_REGISTROS_LABEL + TMyLibrary.CompLeft(DS_Busca.DataSet.RecordCount.ToString, '0', 6);
end;

end.
