unit View.Produtos.SubGrupos.Busca;

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
  TViewProdutosSubGruposBusca = class(TViewBaseBusca)
  private
  public
  end;

var
  ViewProdutosSubGruposBusca: TViewProdutosSubGruposBusca;

implementation

{$R *.dfm}

end.
