unit View.Produtos.Grupos.Cad;

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
  Model.Produtos.Grupos.Interfaces,
  Model.Produtos.Grupos.Entitie;

type
  TViewProdutosGruposCad = class(TViewBaseCadastros)
    pnTela: TPanel;
    lbId: TLabel;
    lbGrupo: TLabel;
    edtId: TEdit;
    edtNome: TEdit;
    procedure btnBuscarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    FGrupo: IModelProdutosGruposFactory<TModelProdutosGruposEntitie>;
    procedure FillEntitie;
  public
    procedure InitialConfiguration; override;
    procedure NewEntitie; override;
    procedure FillFields; override;
    procedure OnBusca(AId: Integer); override;
  end;

var
  ViewProdutosGruposCad: TViewProdutosGruposCad;

implementation

{$R *.dfm}

uses
  MyVclLibrary,
  Utils.LibrarySistema,
  Model.Produtos.Grupos.Factory,
  View.Produtos.Grupos.Busca;

procedure TViewProdutosGruposCad.btnAlterarClick(Sender: TObject);
begin
   inherited;
   if(not Assigned(FGrupo))then
     Exit;

   if(not (FGrupo.Entitie.Id > 0))then
     Exit;

   Self.StartOperations;
end;

procedure TViewProdutosGruposCad.btnBuscarClick(Sender: TObject);
begin
   inherited;
   CriarFormMsgJaAberto(TViewProdutosGruposBusca, ViewProdutosGruposBusca);
   try
     ViewProdutosGruposBusca.btnCadastro.Enabled := False;
     ViewProdutosGruposBusca.FOnBusca            := Self.OnBusca;
     ViewProdutosGruposBusca.ShowModal;
   finally
     FreeAndNil(ViewProdutosGruposBusca);
   end;
end;

procedure TViewProdutosGruposCad.btnExcluirClick(Sender: TObject);
begin
   inherited;
   if(edtId.Text = EmptyStr)then
     Exit;

   FGrupo.Deletar;
   Self.EndOperations;
   Self.EmptyFields;
end;

procedure TViewProdutosGruposCad.btnGravarClick(Sender: TObject);
begin
   inherited;
   Self.FillEntitie;
   FGrupo.Gravar;

   Self.EndOperations;
   Self.FillFields;
end;

procedure TViewProdutosGruposCad.btnNovoClick(Sender: TObject);
begin
   inherited;
   TMyVclLibrary.SetFocusOn(edtNome);
end;

procedure TViewProdutosGruposCad.FillEntitie;
begin
   FGrupo
    .Entitie
     .Id(edtId.Text)
     .Nome(edtNome.Text)
     .End_Entitie;
end;

procedure TViewProdutosGruposCad.FillFields;
begin
   if(not Assigned(FGrupo))then
     Exit;

   edtId.Text   := FGrupo.Entitie.IdMascara;
   edtNome.Text := FGrupo.Entitie.Nome;
end;

procedure TViewProdutosGruposCad.InitialConfiguration;
begin
   //
end;

procedure TViewProdutosGruposCad.NewEntitie;
begin
   FGrupo := TModelProdutosGruposFactory.New('Cadastro de grupos de produtos');
end;

procedure TViewProdutosGruposCad.OnBusca(AId: Integer);
begin
   Self.NewEntitie;

   FGrupo
    .Entitie
     .Id(AId)
     .End_Entitie
    .ConsultarEntitie;

   Self.FillFields;
end;

end.
