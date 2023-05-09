unit View.Produtos.Cad;

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
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.ComCtrls,
  Vcl.Mask,
  View.Base.Cadastros,
  Model.Produtos.Interfaces,
  Model.Produtos.Entitie;

type
  TViewProdutosCad = class(TViewBaseCadastros)
    pnTela: TPanel;
    lbId: TLabel;
    lbNome: TLabel;
    edtId: TEdit;
    edtNome: TEdit;
    lbCusto: TLabel;
    lbDescricao: TLabel;
    edtDescricao: TEdit;
    lbPorcLucroVista: TLabel;
    lbPrecoVendaVista: TLabel;
    lbPorcLucroPrazo: TLabel;
    lbPrecoVendaPrazo: TLabel;
    lbIdSubgrupo: TLabel;
    lbGrupo: TLabel;
    edtIdSubGrupo: TEdit;
    edtGrupo: TEdit;
    lbSubGrupo: TLabel;
    edtSubGrupo: TEdit;
    lbEstoque: TLabel;
    lbCodBarras: TLabel;
    edtCodBarras: TEdit;
    lbEstoqueMin: TLabel;
    lbEstoqueMax: TLabel;
    lbIdUnidade: TLabel;
    lbUnidadeDesc: TLabel;
    edtIdUnidade: TEdit;
    edtUnidadeNome: TEdit;
    edtUnidadeSigla: TEdit;
    lbUnidadeSigla: TLabel;
    edtCusto: TEdit;
    edtPorcLucroVista: TEdit;
    edtPrecoVendaVista: TEdit;
    edtPorcLucroPrazo: TEdit;
    edtPrecoVendaPrazo: TEdit;
    edtEstoqueMinimo: TEdit;
    edtEstoqueMaximo: TEdit;
    edtEstoque: TEdit;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure edtIdSubGrupoExit(Sender: TObject);
    procedure edtIdSubGrupoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtIdUnidadeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtIdUnidadeExit(Sender: TObject);
  private
    FProduto: IModelProdutosFactory<TModelProdutosEntitie>;
    procedure FillEntitie;
  public
    procedure InitialConfiguration; override;
    procedure NewEntitie; override;
    procedure FillFields; override;
    procedure OnBusca(AId: Integer); override;
  end;

var
  ViewProdutosCad: TViewProdutosCad;

implementation

{$R *.dfm}

uses
  MyMessage,
  Common.Utils.MyConsts,
  Common.Utils.MyLibrary,
  Common.Utils.MyVclLibrary,
  Utils.GlobalConsts,
  Utils.LibrarySistema,
  Utils.EditsKeyDownExit,
  Model.Produtos.Factory,
  View.Produtos.Busca;

procedure TViewProdutosCad.btnAlterarClick(Sender: TObject);
begin
   inherited;
   if(not Assigned(FProduto))then
     Exit;

   if(not (FProduto.Entitie.Id > 0))then
     Exit;

   Self.StartOperations;
end;

procedure TViewProdutosCad.btnBuscarClick(Sender: TObject);
begin
   inherited;
   CriarFormMsgJaAberto(TViewProdutosBusca, ViewProdutosBusca);
   try
     ViewProdutosBusca.btnCadastro.Enabled := False;
     ViewProdutosBusca.FOnBusca := Self.OnBusca;
     ViewProdutosBusca.ShowModal;
   finally
     FreeAndNil(ViewProdutosBusca);
   end;
end;

procedure TViewProdutosCad.btnExcluirClick(Sender: TObject);
begin
   inherited;
   if(edtId.Text = EmptyStr)then
     Exit;

   FProduto.Deletar;
   Self.EndOperations;
   Self.EmptyFields;
end;

procedure TViewProdutosCad.btnGravarClick(Sender: TObject);
begin
   inherited;
   Self.FillEntitie;
   FProduto.Gravar;

   Self.EndOperations;
   Self.FillFields;
end;

procedure TViewProdutosCad.btnNovoClick(Sender: TObject);
begin
   inherited;
   TMyVclLibrary.SetFocusOn(edtNome);
end;

procedure TViewProdutosCad.FillEntitie;
begin
   FProduto
    .Entitie
     .Id(edtId.Text)
     .Nome(edtNome.Text)
     .Descricao(edtDescricao.Text)
     .Subgrupo(edtIdSubGrupo.Text)
     .Custo(edtCusto.Text)
     .PorcentoLucroVendaVista(edtPorcLucroVista.Text)
     .PrecoVendaVista(edtPrecoVendaVista.Text)
     .PorcentoLucroVendaPrazo(edtPorcLucroPrazo.Text)
     .PrecoVendaPrazo(edtPrecoVendaPrazo.Text)
     .Estoque(edtEstoque.Text)
     .EstoqueMaximo(edtEstoqueMaximo.Text)
     .EstoqueMinimo(edtEstoqueMinimo.Text)
     .CodigoBarras(edtCodBarras.Text)
     .Unidade(edtIdUnidade.Text)
     .End_Entitie
end;

procedure TViewProdutosCad.FillFields;
begin
   if(not Assigned(FProduto))then
     Exit;

   edtId.Text              := FProduto.Entitie.IdMascara;
   edtNome.Text            := FProduto.Entitie.Nome;
   edtDescricao.Text       := FProduto.Entitie.Descricao;
   edtIdSubGrupo.Text      := FProduto.Entitie.SubgrupoMascara;
   edtCusto.Text           := FProduto.Entitie.Custo.ToString;
   edtPorcLucroVista.Text  := FProduto.Entitie.PorcentoLucroVendaVista.ToString;
   edtPrecoVendaVista.Text := FProduto.Entitie.PrecoVendaVista.ToString;
   edtPorcLucroPrazo.Text  := FProduto.Entitie.PorcentoLucroVendaPrazo.ToString;
   edtPrecoVendaPrazo.Text := FProduto.Entitie.PrecoVendaPrazo.ToString;
   edtEstoque.Text         := FProduto.Entitie.Estoque.ToString;
   edtEstoqueMaximo.Text   := FProduto.Entitie.EstoqueMaximo.ToString;
   edtEstoqueMinimo.Text   := FProduto.Entitie.EstoqueMinimo.ToString;
   edtCodBarras.Text       := FProduto.Entitie.CodigoBarras;
   edtIdUnidade.Text       := FProduto.Entitie.UnidadeMascara;
end;

procedure TViewProdutosCad.InitialConfiguration;
begin
   edtIdSubGrupo.ShowHint := True;
   edtIdSubGrupo.Hint     := HINT_ATALHO_CONSULTA;
   edtIdUnidade.ShowHint  := True;
   edtIdUnidade.Hint      := HINT_ATALHO_CONSULTA;
end;

procedure TViewProdutosCad.NewEntitie;
begin
   FProduto := TModelProdutosFactory.New('Cadastro de produtos');
end;

procedure TViewProdutosCad.OnBusca(AId: Integer);
begin
   Self.NewEntitie;

   FProduto
    .Entitie
     .Id(AId)
     .End_Entitie
    .ConsultarEntitie;

   Self.FillFields;
   edtIdSubGrupoExit(edtIdSubGrupo);
   edtIdUnidadeExit(edtIdUnidade);
end;

procedure TViewProdutosCad.edtIdSubGrupoExit(Sender: TObject);
begin
   IdSubGrupoProdutoExit(edtIdSubGrupo, edtSubGrupo, edtGrupo);
end;

procedure TViewProdutosCad.edtIdSubGrupoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   IdSubGrupoProdutoKeyDown(edtIdSubGrupo, Key, Shift);
end;

procedure TViewProdutosCad.edtIdUnidadeExit(Sender: TObject);
begin
   IdUnidadeProdutoExit(edtIdUnidade, edtUnidadeSigla, edtUnidadeNome);
end;

procedure TViewProdutosCad.edtIdUnidadeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   IdUnidadeProdutoKeyDown(edtIdUnidade, Key, Shift);
end;

end.
