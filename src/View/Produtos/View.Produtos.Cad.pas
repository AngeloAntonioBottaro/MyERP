unit View.Produtos.Cad;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  View.Base.Cadastros,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TViewProdutosCad = class(TViewBaseCadastros)
    pnTela: TPanel;
    lbId: TLabel;
    lbRazaoSocial: TLabel;
    edtId: TEdit;
    edtRazaoSocial: TEdit;
    procedure btnBuscarClick(Sender: TObject);
  private
  public
  end;

var
  ViewProdutosCad: TViewProdutosCad;

implementation

{$R *.dfm}

uses
  View.Produtos.Busca;

procedure TViewProdutosCad.btnBuscarClick(Sender: TObject);
begin
   inherited;
   if(ViewProdutosBusca = nil)then Application.CreateForm(TViewProdutosBusca, ViewProdutosBusca);
   try
     ViewProdutosBusca.btnCadastro.Enabled := False;
     ViewProdutosBusca.ShowModal;
   finally
     FreeAndNil(ViewProdutosBusca);
   end;
end;

end.
