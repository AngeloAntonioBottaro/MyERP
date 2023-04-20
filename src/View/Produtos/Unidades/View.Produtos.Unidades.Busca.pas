unit View.Produtos.Unidades.Busca;

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
  Vcl.Menus,
  Vcl.ExtCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Vcl.ComCtrls,
  Vcl.Imaging.pngimage,
  View.Base.Busca,
  Data.DB,
  Utils.Types,
  Model.Produtos.Unidades.Busca;

type
  TViewProdutosUnidadesBusca = class(TViewBaseBusca)
    rdBuscarNome: TRadioButton;
    rdBuscarCodigo: TRadioButton;
    rdBuscarSigla: TRadioButton;
    procedure ConfComponents(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCadastroClick(Sender: TObject);
    procedure Excluir1Click(Sender: TObject);
    procedure GridBuscaTitleClick(Column: TColumn);
  private
    FBusca: TModelProdutosUnidadesBusca;
    function GetTipoBusca: TTipoBuscaProdutoUnidade;
  public
    procedure Buscar; override;
  end;

var
  ViewProdutosUnidadesBusca: TViewProdutosUnidadesBusca;

implementation

{$R *.dfm}

uses
  MyExceptions,
  Utils.MyConsts,
  Utils.MyVclLibrary,
  Utils.GlobalConsts,
  View.Produtos.Unidades.Cad,
  Model.Produtos.Unidades.Factory;

procedure TViewProdutosUnidadesBusca.FormCreate(Sender: TObject);
begin
   FGridConf := Self.GridBusca;
   FNomeConf := Self.Name;

   inherited;

   FBusca := TModelProdutosUnidadesBusca.Create;
   FBusca
    .DataSource(DS_Busca);
end;

procedure TViewProdutosUnidadesBusca.FormDestroy(Sender: TObject);
begin
   inherited;
   FBusca.Free;
end;

procedure TViewProdutosUnidadesBusca.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   inherited;
   case(Key)of
    VK_F2: if(Shift = [])then rdBuscarCodigo.Checked := True;
    VK_F3: if(Shift = [])then rdBuscarNome.Checked   := True;
    VK_F4: if(Shift = [])then rdBuscarSigla.Checked  := True;
   end;
end;

procedure TViewProdutosUnidadesBusca.btnCadastroClick(Sender: TObject);
begin
   inherited;
   if(ViewProdutosUnidadesCad = nil)then Application.CreateForm(TViewProdutosUnidadesCad, ViewProdutosUnidadesCad);

   if(ViewProdutosUnidadesCad.Showing)then
     raise ExceptionInformation.Create(MSG_TELA_JA_ABERTA);

   try
     ViewProdutosUnidadesCad.ShowModal;
   finally
     FreeAndNil(ViewProdutosUnidadesCad);
   end;
end;

procedure TViewProdutosUnidadesBusca.Buscar;
begin
   FBusca
    .ConteudoBusca(edtBusca.Text)
    .TipoBusca(Self.GetTipoBusca)
    .Inativos(ckBuscarInativos.Enabled and ckBuscarInativos.Checked)
    .Buscar;
   inherited;
end;

procedure TViewProdutosUnidadesBusca.ConfComponents(Sender: TObject);
begin
   edtBusca.Clear;
   TMyVclLibrary.SetFocusOn(edtBusca);
end;

procedure TViewProdutosUnidadesBusca.Excluir1Click(Sender: TObject);
begin
   inherited;
   TModelProdutosUnidadesFactory.New
    .Entitie
     .Id(DS_Busca.DataSet.FieldByName('ID').AsInteger)
     .End_Entitie
    .Deletar;
end;

function TViewProdutosUnidadesBusca.GetTipoBusca: TTipoBuscaProdutoUnidade;
begin
   Result := TTipoBuscaProdutoUnidade.Nome;

   if(rdBuscarCodigo.Enabled and rdBuscarCodigo.Checked)then
     Result := TTipoBuscaProdutoUnidade.Id
   else if(rdBuscarSigla.Enabled and rdBuscarSigla.Checked)then
     Result := TTipoBuscaProdutoUnidade.Sigla;
end;

procedure TViewProdutosUnidadesBusca.GridBuscaTitleClick(Column: TColumn);
begin
   inherited;
   FBusca.IndexFieldNames(Column.FieldName);
end;

end.
