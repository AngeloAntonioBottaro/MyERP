unit View.Produtos.Busca;

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
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Menus,
  Vcl.ComCtrls,
  View.Base.Busca,
  Data.DB,
  Utils.MyTypes,
  Model.Produtos.Busca,
  Vcl.Imaging.pngimage;

type
  TViewProdutosBusca = class(TViewBaseBusca)
    rdBuscarCodigo: TRadioButton;
    rdBuscarNome: TRadioButton;
    rdBuscarCodBarras: TRadioButton;
    procedure ConfComponents(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure AtivarInativar1Click(Sender: TObject);
    procedure btnCadastroClick(Sender: TObject);
    procedure Excluir1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridBuscaDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure GridBuscaTitleClick(Column: TColumn);
  private
    FBusca: TModelProdutosBusca;
    function GetTipoBusca: TTipoBuscaProduto;
  public
    procedure Buscar; override;
  end;

var
  ViewProdutosBusca: TViewProdutosBusca;

implementation

{$R *.dfm}

uses
  MyExceptions,
  Utils.MyConsts,
  Utils.MyVclLibrary,
  Utils.GlobalConsts,
  View.Produtos.Cad,
  Model.Produtos.Factory;

procedure TViewProdutosBusca.FormCreate(Sender: TObject);
begin
   FGridConf := Self.GridBusca;
   FNomeConf := Self.Name;

   inherited;

   FBusca := TModelProdutosBusca.Create;
   FBusca
    .DataSource(DS_Busca);
end;

procedure TViewProdutosBusca.FormDestroy(Sender: TObject);
begin
   inherited;
   FBusca.Free;
end;

procedure TViewProdutosBusca.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   inherited;
   case(Key)of
    VK_F2: if(Shift = [])then rdBuscarCodigo.Checked    := True;
    VK_F3: if(Shift = [])then rdBuscarNome.Checked      := True;
    VK_F4: if(Shift = [])then rdBuscarCodBarras.Checked := True;
   end;
end;

procedure TViewProdutosBusca.AtivarInativar1Click(Sender: TObject);
begin
   inherited;
   TModelProdutosFactory.New
    .Entitie
     .Id(DS_Busca.DataSet.FieldByName('ID').AsInteger)
     .End_Entitie
    .AlterarStatus;
end;

procedure TViewProdutosBusca.btnCadastroClick(Sender: TObject);
begin
   inherited;
   if(ViewProdutosCad = nil)then Application.CreateForm(TViewProdutosCad, ViewProdutosCad);

   if(ViewProdutosCad.Showing)then
     raise ExceptionInformation.Create(MSG_TELA_JA_ABERTA);

   try
     ViewProdutosCad.ShowModal;
   finally
     FreeAndNil(ViewProdutosCad);
   end;
end;

procedure TViewProdutosBusca.Buscar;
begin
   FBusca
    .ConteudoBusca(edtBusca.Text)
    .TipoBusca(Self.GetTipoBusca)
    .Inativos(ckBuscarInativos.Enabled and ckBuscarInativos.Checked)
    .Buscar;
   inherited;
end;

procedure TViewProdutosBusca.ConfComponents(Sender: TObject);
begin
   edtBusca.Clear;
   TMyVclLibrary.SetFocusOn(edtBusca);
end;

procedure TViewProdutosBusca.Excluir1Click(Sender: TObject);
begin
   inherited;
   TModelProdutosFactory.New
    .Entitie
     .Id(DS_Busca.DataSet.FieldByName('ID').AsInteger)
     .End_Entitie
    .Deletar;
end;

function TViewProdutosBusca.GetTipoBusca: TTipoBuscaProduto;
begin
   Result := TTipoBuscaProduto.Nome;

   if(rdBuscarCodigo.Enabled and rdBuscarCodigo.Checked)then
     Result := TTipoBuscaProduto.Id
   else if(rdBuscarCodBarras.Enabled and rdBuscarCodBarras.Checked)then
     Result := TTipoBuscaProduto.CodigoBarras;
end;

procedure TViewProdutosBusca.GridBuscaDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   inherited;
   if(DS_Busca.DataSet.FieldByName('STATUS').AsString.Equals(STATUS_INATIVO))then
   begin
      if(not (gdSelected in State))then
        TDBGrid(Sender).Canvas.Font.Color := clRed;
      TDBGrid(Sender).Canvas.FillRect(Rect);
      TDBGrid(Sender).DefaultDrawDataCell(rect,Column.Field,state);
   end;
end;

procedure TViewProdutosBusca.GridBuscaTitleClick(Column: TColumn);
begin
   inherited;
   FBusca.IndexFieldNames(Column.FieldName);
end;

end.
