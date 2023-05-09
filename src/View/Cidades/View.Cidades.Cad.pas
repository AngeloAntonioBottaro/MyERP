unit View.Cidades.Cad;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  View.Base.Cadastros,
  Model.Cidades.Interfaces,
  Model.Cidades.Entitie;

type
  TViewCidadesCad = class(TViewBaseCadastros)
    pnTela: TPanel;
    lbId: TLabel;
    lbNome: TLabel;
    lbIBGE: TLabel;
    lbUF: TLabel;
    edtId: TEdit;
    edtCidade: TEdit;
    cBoxUF: TComboBox;
    edtIBGE: TEdit;
    procedure btnBuscarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    FCidade: IModelCidadesFactory<TModelCidadesEntitie>;
    procedure FillEntitie;
  public
    procedure InitialConfiguration; override;
    procedure NewEntitie; override;
    procedure FillFields; override;
    procedure OnBusca(AId: Integer); override;
  end;

var
  ViewCidadesCad: TViewCidadesCad;

implementation

{$R *.dfm}

uses
  MyConnection,
  Utils.LibrarySistema,
  Common.Utils.MyConsts,
  Common.Utils.MyVclLibrary,
  View.Cidades.Busca,
  Model.Cidades.Factory;

procedure TViewCidadesCad.btnAlterarClick(Sender: TObject);
begin
   inherited;
   if(not Assigned(FCidade))then
     Exit;

   if(not (FCidade.Entitie.Id > 0))then
     Exit;

   Self.StartOperations;
end;

procedure TViewCidadesCad.btnBuscarClick(Sender: TObject);
begin
   inherited;
   CriarFormMsgJaAberto(TViewCidadesBusca, ViewCidadesBusca);
   try
     ViewCidadesBusca.btnCadastro.Enabled := False;
     ViewCidadesBusca.FOnBusca := Self.OnBusca;
     ViewCidadesBusca.ShowModal;
   finally
     FreeAndNil(ViewCidadesBusca);
   end;
end;

procedure TViewCidadesCad.btnExcluirClick(Sender: TObject);
begin
   inherited;
   if(edtId.Text = EmptyStr)then
     Exit;

   FCidade.Deletar;
   Self.EndOperations;
   Self.EmptyFields;
end;

procedure TViewCidadesCad.btnGravarClick(Sender: TObject);
begin
   inherited;
   Self.FillEntitie;
   FCidade.Gravar;

   Self.EndOperations;
   Self.FillFields;
end;

procedure TViewCidadesCad.btnNovoClick(Sender: TObject);
begin
   inherited;
   cBoxUF.ItemIndex := -1;
   TMyVclLibrary.SetFocusOn(edtCidade);
end;

procedure TViewCidadesCad.FillEntitie;
begin
   FCidade
    .Entitie
     .Id(edtId.Text)
     .Nome(edtCidade.Text)
     .IBGE(edtIBGE.Text)
     .UF(cBoxUF.Text)
     .End_Entitie;
end;

procedure TViewCidadesCad.FillFields;
begin
   if(not Assigned(FCidade))then
     Exit;

   edtId.Text       := FCidade.Entitie.IdMascara;
   edtCidade.Text   := FCidade.Entitie.Nome;
   edtIBGE.Text     := FCidade.Entitie.IBGE.ToString;
   cBoxUF.ItemIndex := FCidade.Entitie.UFComboBox;
end;

procedure TViewCidadesCad.InitialConfiguration;
var
  I: Integer;
begin
   cBoxUF.Items.Clear;
   for I := Low(ESTADOS) to High(ESTADOS) do
     cBoxUF.Items.Add(ESTADOS[I]);

   cBoxUF.ItemIndex := -1;
end;

procedure TViewCidadesCad.NewEntitie;
begin
   FCidade := TModelCidadesFactory.New('Cadastro de cidade');
end;

procedure TViewCidadesCad.OnBusca(AId: Integer);
begin
   Self.NewEntitie;
   FCidade
    .Entitie
     .Id(AId)
     .End_Entitie
    .ConsultarEntitie;
   Self.FillFields;
end;

end.
