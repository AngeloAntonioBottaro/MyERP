unit View.Produtos.SubGrupos.Cad;

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
  TViewProdutosSubgruposCad = class(TViewBaseCadastros)
    pnTela: TPanel;
    lbIdsubgrupo: TLabel;
    lbIdGrupo: TLabel;
    lbNomeGrupo: TLabel;
    lbNomeSubGrupo: TLabel;
    edtIdGrupo: TEdit;
    edtGrupo: TEdit;
    edtId: TEdit;
    edtSubGrupo: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
  private
    procedure InitialConfiguration;
  public
  end;

var
  ViewProdutosSubgruposCad: TViewProdutosSubgruposCad;

implementation

{$R *.dfm}

uses
  Utils.MyConsts,
  View.Produtos.SubGrupos.Busca;

procedure TViewProdutosSubgruposCad.btnBuscarClick(Sender: TObject);
begin
   inherited;
   if(ViewProdutosSubGruposBusca = nil)then Application.CreateForm(TViewProdutosSubGruposBusca, ViewProdutosSubGruposBusca);
   try
     ViewProdutosSubGruposBusca.btnCadastro.Enabled := False;
     ViewProdutosSubGruposBusca.ShowModal;
   finally
     FreeAndNil(ViewProdutosSubGruposBusca);
   end;
end;

procedure TViewProdutosSubgruposCad.FormCreate(Sender: TObject);
begin
   inherited;
   Self.InitialConfiguration;
end;

procedure TViewProdutosSubgruposCad.InitialConfiguration;
begin
   edtIdGrupo.ShowHint := True;
   edtIdGrupo.Hint     := HINT_ATALHO_CONSULTA;
end;

end.
