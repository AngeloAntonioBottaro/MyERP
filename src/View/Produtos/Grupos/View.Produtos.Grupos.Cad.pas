unit View.Produtos.Grupos.Cad;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  View.Base.Cadastros,
  Vcl.StdCtrls,
  Vcl.Controls,
  Vcl.ExtCtrls;

type
  TViewProdutosGruposCad = class(TViewBaseCadastros)
    pnTela: TPanel;
    lbId: TLabel;
    lbGrupo: TLabel;
    edtId: TEdit;
    edtGrupo: TEdit;
  private
  public
  end;

var
  ViewProdutosGruposCad: TViewProdutosGruposCad;

implementation

{$R *.dfm}

end.
