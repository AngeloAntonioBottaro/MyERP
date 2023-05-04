unit View.Compras.Busca;

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
  View.Base.Busca,
  Data.DB,
  Vcl.Menus,
  Vcl.ExtCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Vcl.ComCtrls;

type
  TViewComprasBusca = class(TViewBaseBusca)
  private
  public
  end;

var
  ViewComprasBusca: TViewComprasBusca;

implementation

{$R *.dfm}

end.
