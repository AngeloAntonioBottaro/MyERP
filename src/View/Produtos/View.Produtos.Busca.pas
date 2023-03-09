unit View.Produtos.Busca;

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
  TViewProdutosBusca = class(TViewBaseBusca)
  private
  public
  end;

var
  ViewProdutosBusca: TViewProdutosBusca;

implementation

{$R *.dfm}

end.
