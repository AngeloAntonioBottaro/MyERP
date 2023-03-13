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
  Vcl.ExtCtrls,
  Model.Produtos.SubGrupos.Interfaces,
  Model.Produtos.SubGrupos.Entitie;

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
    procedure btnNovoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    FSubGrupo: IModelProdutosSubGruposFactory<TModelProdutosSubGruposEntitie>;
    procedure InitialConfiguration;
    procedure NewEntitie;
    procedure FillFields;
  public
  end;

var
  ViewProdutosSubgruposCad: TViewProdutosSubgruposCad;

implementation

{$R *.dfm}

uses
  Utils.MyConsts,
  Model.Produtos.SubGrupos.Factory,
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
   Self.FillFields;
end;

procedure TViewProdutosSubgruposCad.btnGravarClick(Sender: TObject);
begin
   inherited;
   FSubGrupo
    .Entitie
     .Id(edtId.Text)
     .Nome(edtGrupo.Text)
     .Grupo(edtIdGrupo.Text)
     .End_Entitie;
end;

procedure TViewProdutosSubgruposCad.btnNovoClick(Sender: TObject);
begin
   inherited;
   Self.NewEntitie;
end;

procedure TViewProdutosSubgruposCad.FillFields;
begin
   if(not Assigned(FSubGrupo))then
     Exit;

   edtId.Text       := FSubGrupo.Entitie.Id.ToString;
   edtSubGrupo.Text := FSubGrupo.Entitie.Nome;
   edtIdGrupo.Text  := FSubGrupo.Entitie.Grupo.ToString;
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

procedure TViewProdutosSubgruposCad.NewEntitie;
begin
   FSubGrupo := TModelProdutosSubGruposFactory.New;
end;

end.
