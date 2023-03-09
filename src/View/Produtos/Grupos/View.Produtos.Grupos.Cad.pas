unit View.Produtos.Grupos.Cad;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  View.Base.Cadastros,
  Vcl.Forms,
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
    procedure btnBuscarClick(Sender: TObject);
  private
  public
  end;

var
  ViewProdutosGruposCad: TViewProdutosGruposCad;

implementation

{$R *.dfm}

uses
  View.Produtos.Grupos.Busca;

procedure TViewProdutosGruposCad.btnBuscarClick(Sender: TObject);
begin
   inherited;
   if(ViewProdutosGruposBusca = nil)then Application.CreateForm(TViewProdutosGruposBusca, ViewProdutosGruposBusca);
   try
     ViewProdutosGruposBusca.btnCadastro.Enabled := False;
     ViewProdutosGruposBusca.ShowModal;
   finally
     FreeAndNil(ViewProdutosGruposBusca);
   end;
end;

end.
