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
  Vcl.StdCtrls;

type
  TViewBaseBusca = class(TViewBase)
    pnTop: TPanel;
    pnBotton: TPanel;
    GridBusca: TDBGrid;
    pnButtons: TPanel;
    btnCadastro: TButton;
    btnVincular: TButton;
    lbBusca: TLabel;
    edtBusca: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GridBuscaDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
  public
  end;

var
  ViewBaseBusca: TViewBaseBusca;

implementation

{$R *.dfm}

uses
  Utils.MyConsts;

procedure TViewBaseBusca.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   inherited;
   btnCadastro.Enabled := True;
   btnVincular.Enabled := True;
end;

procedure TViewBaseBusca.GridBuscaDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if(odd(TDBGrid(Sender).DataSource.DataSet.RecNo))then
     Exit;

   if((gdSelected in State))then
     Exit;

   TDBGrid(Sender).Canvas.Brush.Color := COLOR_GRID;
   TDBGrid(Sender).Canvas.FillRect(Rect);
   TDBGrid(Sender).DefaultDrawDataCell(rect,Column.Field,state);
end;

end.
