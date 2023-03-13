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
  Vcl.ExtCtrls,
  Model.Produtos.Grupos.Interfaces,
  Model.Produtos.Grupos.Entitie;

type
  TViewProdutosGruposCad = class(TViewBaseCadastros)
    pnTela: TPanel;
    lbId: TLabel;
    lbGrupo: TLabel;
    edtId: TEdit;
    edtGrupo: TEdit;
    procedure btnBuscarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
  private
    FGrupo: IModelProdutosGruposFactory<TModelProdutosGruposEntitie>;
    procedure NewEntitie;
    procedure FillFields;
  public
  end;

var
  ViewProdutosGruposCad: TViewProdutosGruposCad;

implementation

{$R *.dfm}

uses
  Model.Produtos.Grupos.Factory,
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
   Self.FillFields;
end;

procedure TViewProdutosGruposCad.btnGravarClick(Sender: TObject);
begin
   inherited;
   FGrupo
    .Entitie
     .Id(edtId.Text)
     .Nome(edtGrupo.Text)
     .End_Entitie;
end;

procedure TViewProdutosGruposCad.btnNovoClick(Sender: TObject);
begin
   inherited;
   Self.NewEntitie;
end;

procedure TViewProdutosGruposCad.FillFields;
begin
   if(not Assigned(FGrupo))then
     Exit;

   edtId.Text    := FGrupo.Entitie.Id.ToString;
   edtGrupo.Text := FGrupo.Entitie.Nome;
end;

procedure TViewProdutosGruposCad.NewEntitie;
begin
   FGrupo := TModelProdutosGruposFactory.New;
end;

end.
