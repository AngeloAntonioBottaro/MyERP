unit View.Produtos.Unidades.Cad;

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
  View.Base.Cadastros,
  Model.Produtos.Unidades.Interfaces,
  Model.Produtos.Unidades.Entitie;

type
  TViewProdutosUnidadesCad = class(TViewBaseCadastros)
    pnTela: TPanel;
    lbId: TLabel;
    lbNome: TLabel;
    edtId: TEdit;
    edtNome: TEdit;
    edtSigla: TEdit;
    lbSigla: TLabel;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
  private
    FUnidade: IModelProdutosUnidadesFactory<TModelProdutosUnidadesEntitie>;
    procedure FillEntitie;
  public
    procedure InitialConfiguration; override;
    procedure NewEntitie; override;
    procedure FillFields; override;
    procedure OnBusca(AId: Integer); override;
  end;

var
  ViewProdutosUnidadesCad: TViewProdutosUnidadesCad;

implementation

{$R *.dfm}

uses
  MyVclLibrary,
  Utils.LibrarySistema,
  Model.Produtos.Unidades.Factory,
  View.Produtos.Unidades.Busca;

procedure TViewProdutosUnidadesCad.btnAlterarClick(Sender: TObject);
begin
   inherited;
   if(not Assigned(FUnidade))then
     Exit;

   if(not (FUnidade.Entitie.Id > 0))then
     Exit;

   Self.StartOperations;
end;

procedure TViewProdutosUnidadesCad.btnBuscarClick(Sender: TObject);
begin
   inherited;
   CriarFormMsgJaAberto(TViewProdutosUnidadesBusca, ViewProdutosUnidadesBusca);
   try
     ViewProdutosUnidadesBusca.btnCadastro.Enabled := False;
     ViewProdutosUnidadesBusca.FOnBusca            := Self.OnBusca;
     ViewProdutosUnidadesBusca.ShowModal;
   finally
     FreeAndNil(ViewProdutosUnidadesBusca);
   end;
end;

procedure TViewProdutosUnidadesCad.btnExcluirClick(Sender: TObject);
begin
   inherited;
   if(edtId.Text = EmptyStr)then
     Exit;

   FUnidade.Deletar;
   Self.EndOperations;
   Self.EmptyFields;
end;

procedure TViewProdutosUnidadesCad.btnGravarClick(Sender: TObject);
begin
   inherited;
   Self.FillEntitie;
   FUnidade.Gravar;

   Self.EndOperations;
   Self.FillFields;
end;

procedure TViewProdutosUnidadesCad.btnNovoClick(Sender: TObject);
begin
   inherited;
   TMyVclLibrary.SetFocusOn(edtNome);
end;

procedure TViewProdutosUnidadesCad.FillEntitie;
begin
   FUnidade
    .Entitie
     .Id(edtId.Text)
     .Nome(edtNome.Text)
     .Sigla(edtSigla.Text)
     .End_Entitie;
end;

procedure TViewProdutosUnidadesCad.FillFields;
begin
   if(not Assigned(FUnidade))then
     Exit;

   edtId.Text    := FUnidade.Entitie.IdMascara;
   edtNome.Text  := FUnidade.Entitie.Nome;
   edtSigla.Text := FUnidade.Entitie.Sigla;
end;

procedure TViewProdutosUnidadesCad.InitialConfiguration;
begin
   //
end;

procedure TViewProdutosUnidadesCad.NewEntitie;
begin
   FUnidade := TModelProdutosUnidadesFactory.New('Cadastro de unidade de produto');
end;

procedure TViewProdutosUnidadesCad.OnBusca(AId: Integer);
begin
   Self.NewEntitie;

   FUnidade
    .Entitie
     .Id(AId)
     .End_Entitie
    .ConsultarEntitie;

   Self.FillFields;
end;

end.
