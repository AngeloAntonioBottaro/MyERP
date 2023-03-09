unit View.Clientes.Busca;

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
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TViewClientesBusca = class(TViewBaseBusca)
  private
  public
  end;

var
  ViewClientesBusca: TViewClientesBusca;

implementation

{$R *.dfm}

end.
