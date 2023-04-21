unit View.FormasPagamento.Cad;

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
  Model.FormasPagamento.Interfaces,
  Model.FormasPagamento.Entitie;

type
  TViewFormasPagamentoCad = class(TViewBaseCadastros)
    pnTela: TPanel;
    lbId: TLabel;
    lbNome: TLabel;
    lbTipoLancamento: TLabel;
    cBoxTipoLancamento: TComboBox;
    edtId: TEdit;
    edtNome: TEdit;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
  private
    FFormaPag: IModelFormasPagamentoFactory<TModelFormasPagamentoEntitie>;
    procedure FillEntitie;
  public
    procedure InitialConfiguration; override;
    procedure NewEntitie; override;
    procedure FillFields; override;
    procedure OnBusca(AId: Integer); override;
  end;

var
  ViewFormasPagamentoCad: TViewFormasPagamentoCad;

implementation

{$R *.dfm}

uses
  MyMessage,
  Utils.MyConsts,
  Utils.MyLibrary,
  Utils.MyVclLibrary,
  Utils.GlobalConsts,
  Utils.LibrarySistema,
  Model.FormasPagamento.Factory,
  View.FormasPagamento.Busca;

procedure TViewFormasPagamentoCad.btnAlterarClick(Sender: TObject);
begin
   inherited;
   if(not Assigned(FFormaPag))then
     Exit;

   if(not (FFormaPag.Entitie.Id > 0))then
     Exit;

   Self.StartOperations;
end;

procedure TViewFormasPagamentoCad.btnBuscarClick(Sender: TObject);
begin
   inherited;
   CriarFormMsgJaAberto(TViewFormasPagamentoBusca, ViewFormasPagamentoBusca);
   try
     ViewFormasPagamentoBusca.btnCadastro.Enabled := False;
     ViewFormasPagamentoBusca.FOnBusca := Self.OnBusca;
     ViewFormasPagamentoBusca.ShowModal;
   finally
     FreeAndNil(ViewFormasPagamentoBusca);
   end;
end;

procedure TViewFormasPagamentoCad.btnExcluirClick(Sender: TObject);
begin
   inherited;
   if(edtId.Text = EmptyStr)then
     Exit;

   FFormaPag.Deletar;
   Self.EndOperations;
   Self.EmptyFields;
end;

procedure TViewFormasPagamentoCad.btnGravarClick(Sender: TObject);
begin
   inherited;
   Self.FillEntitie;
   FFormaPag.Gravar;

   Self.EndOperations;
   Self.FillFields;
end;

procedure TViewFormasPagamentoCad.btnNovoClick(Sender: TObject);
begin
   inherited;
   cBoxTipoLancamento.ItemIndex := 0;
   TMyVclLibrary.SetFocusOn(edtNome);
end;

procedure TViewFormasPagamentoCad.FillEntitie;
begin
   FFormaPag
    .Entitie
     .Id(edtId.Text)
     .Nome(edtNome.Text)
     .TipoLancamento(cBoxTipoLancamento.Text)
     .End_Entitie
end;

procedure TViewFormasPagamentoCad.FillFields;
begin
   if(not Assigned(FFormaPag))then
     Exit;

   edtId.Text                   := FFormaPag.Entitie.IdMascara;
   edtNome.Text                 := FFormaPag.Entitie.Nome;
   cBoxTipoLancamento.ItemIndex := FFormaPag.Entitie.TipoLancamentoComboBox;
end;

procedure TViewFormasPagamentoCad.InitialConfiguration;
begin
   CriarComboBoxTipoLancamentoFinanceiro(cBoxTipoLancamento.Items);
end;

procedure TViewFormasPagamentoCad.NewEntitie;
begin
   FFormaPag := TModelFormasPagamentoFactory.New('Cadastro de forma de pagamento');
end;

procedure TViewFormasPagamentoCad.OnBusca(AId: Integer);
begin
   Self.NewEntitie;

   FFormaPag
    .Entitie
     .Id(AId)
     .End_Entitie
    .ConsultarEntitie;

   Self.FillFields;
end;

end.
