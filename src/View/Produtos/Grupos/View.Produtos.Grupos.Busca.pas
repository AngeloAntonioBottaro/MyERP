unit View.Produtos.Grupos.Busca;

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
  TViewProdutosGruposBusca = class(TViewBaseBusca)
  private
  public
  end;

var
  ViewProdutosGruposBusca: TViewProdutosGruposBusca;

implementation

{$R *.dfm}

end.
