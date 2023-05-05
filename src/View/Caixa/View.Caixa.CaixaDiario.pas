unit View.Caixa.CaixaDiario;

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
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.ComCtrls,
  View.Base,
  Data.DB;

type
  TViewCaixaCaixaDiario = class(TViewBase)
    pnGrid: TPanel;
    GridBusca: TDBGrid;
    pnRegistros: TPanel;
    lbTotalRegistros: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    dtpDataCaixa: TDateTimePicker;
    lbDataCaixa: TLabel;
    lbCredito: TLabel;
    lbDebito: TLabel;
    lbTotal: TLabel;
    lbValorCredito: TLabel;
    lbValorDebito: TLabel;
    lbValorSaldo: TLabel;
  private
  public
  end;

var
  ViewCaixaCaixaDiario: TViewCaixaCaixaDiario;

implementation

{$R *.dfm}

end.
