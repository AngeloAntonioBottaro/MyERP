unit View.Produtos.SubGrupos.Cad;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Forms,
  Vcl.StdCtrls,
  Vcl.Controls,
  Vcl.ExtCtrls,
  View.Base.Cadastros,
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
    procedure btnBuscarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure edtIdGrupoExit(Sender: TObject);
    procedure edtIdGrupoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FSubGrupo: IModelProdutosSubGruposFactory<TModelProdutosSubGruposEntitie>;
    procedure FillEntitie;
  public
    procedure InitialConfiguration; override;
    procedure NewEntitie; override;
    procedure FillFields; override;
    procedure OnBusca(AId: Integer); override;
  end;

var
  ViewProdutosSubgruposCad: TViewProdutosSubgruposCad;

implementation

{$R *.dfm}

uses
  Utils.MyVclLibrary,
  Utils.LibrarySistema,
  Utils.MyConsts,
  Utils.EditsKeyDownExit,
  Model.Produtos.SubGrupos.Factory,
  View.Produtos.SubGrupos.Busca;

procedure TViewProdutosSubgruposCad.btnAlterarClick(Sender: TObject);
begin
   inherited;
   if(not Assigned(FSubGrupo))then
     Exit;

   if(not (FSubGrupo.Entitie.Id > 0))then
     Exit;

   Self.StartOperations;
end;

procedure TViewProdutosSubgruposCad.btnBuscarClick(Sender: TObject);
begin
   inherited;
   if(ViewProdutosSubGruposBusca = nil)then Application.CreateForm(TViewProdutosSubGruposBusca, ViewProdutosSubGruposBusca);
   try
     ViewProdutosSubGruposBusca.btnCadastro.Enabled := False;
     ViewProdutosSubGruposBusca.FOnBusca := Self.OnBusca;
     ViewProdutosSubGruposBusca.ShowModal;
   finally
     FreeAndNil(ViewProdutosSubGruposBusca);
   end;
end;

procedure TViewProdutosSubgruposCad.btnExcluirClick(Sender: TObject);
begin
   inherited;
   if(edtId.Text = EmptyStr)then
     Exit;

   FSubGrupo.Deletar;
   Self.EndOperations;
   Self.EmptyFields;
end;

procedure TViewProdutosSubgruposCad.btnGravarClick(Sender: TObject);
begin
   inherited;
   Self.FillEntitie;
   FSubGrupo.Gravar;

   Self.EndOperations;
   Self.FillFields;
end;

procedure TViewProdutosSubgruposCad.btnNovoClick(Sender: TObject);
begin
   inherited;
   TMyVclLibrary.SetFocusOn(edtSubGrupo);
end;

procedure TViewProdutosSubgruposCad.FillEntitie;
begin
   FSubGrupo
    .Entitie
     .Id(edtId.Text)
     .Nome(edtSubGrupo.Text)
     .Grupo(edtIdGrupo.Text)
     .End_Entitie;
end;

procedure TViewProdutosSubgruposCad.FillFields;
begin
   if(not Assigned(FSubGrupo))then
     Exit;

   edtId.Text       := FSubGrupo.Entitie.IdMascara;
   edtSubGrupo.Text := FSubGrupo.Entitie.Nome;
   edtIdGrupo.Text  := FSubGrupo.Entitie.GrupoMascara;
end;

procedure TViewProdutosSubgruposCad.InitialConfiguration;
begin
   edtIdGrupo.ShowHint := True;
   edtIdGrupo.Hint     := HINT_ATALHO_CONSULTA;
end;

procedure TViewProdutosSubgruposCad.NewEntitie;
begin
   FSubGrupo := TModelProdutosSubGruposFactory.New('Cadastro de subgrupo de produtos');
end;

procedure TViewProdutosSubgruposCad.OnBusca(AId: Integer);
begin
   Self.NewEntitie;

   FSubGrupo
    .Entitie
     .Id(AId)
     .End_Entitie
    .ConsultarEntitie;

   Self.FillFields;
   edtIdGrupoExit(edtIdGrupo);
end;

procedure TViewProdutosSubgruposCad.edtIdGrupoExit(Sender: TObject);
begin
   IdGrupoProdutoExit(edtIdGrupo, edtGrupo);
end;

procedure TViewProdutosSubgruposCad.edtIdGrupoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   IdGrupoProdutoKeyDown(edtIdGrupo, Key, Shift);
end;

end.
