unit View.Produtos.SubGrupos.Busca;

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
  Model.Produtos.SubGrupos.Busca;

type
  TViewProdutosSubGruposBusca = class(TViewBaseBusca)
    rdBuscarNome: TRadioButton;
    rdBuscarCodigo: TRadioButton;
    rdBuscarCodGrupo: TRadioButton;
    rdBuscarNomeGrupo: TRadioButton;
    procedure ConfComponents(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCadastroClick(Sender: TObject);
    procedure Excluir1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FBusca: TModelProdutosSubGruposBusca;
    function GetTipoBusca: TTipoBuscaProdutoSubGrupo;
  public
    procedure Buscar; override;
  end;

var
  ViewProdutosSubGruposBusca: TViewProdutosSubGruposBusca;

implementation

{$R *.dfm}

uses
  MyExceptions,
  Utils.MyConsts,
  Utils.MyVclLibrary,
  Utils.GlobalConsts,
  View.Produtos.SubGrupos.Cad,
  Model.Produtos.SubGrupos.Factory;

procedure TViewProdutosSubGruposBusca.FormCreate(Sender: TObject);
begin
   inherited;
   FBusca := TModelProdutosSubGruposBusca.Create;
   FBusca
    .DataSource(DS_Busca);
end;

procedure TViewProdutosSubGruposBusca.FormDestroy(Sender: TObject);
begin
   inherited;
   FBusca.Free;
end;

procedure TViewProdutosSubGruposBusca.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   inherited;
   case(Key)of
    VK_F2: if(Shift = [])then rdBuscarCodigo.Checked    := True;
    VK_F3: if(Shift = [])then rdBuscarNome.Checked      := True;
    VK_F4: if(Shift = [])then rdBuscarCodGrupo.Checked  := True;
    VK_F6: if(Shift = [])then rdBuscarNomeGrupo.Checked := True;
   end;
end;

procedure TViewProdutosSubGruposBusca.btnCadastroClick(Sender: TObject);
begin
   inherited;
   if(ViewProdutosSubgruposCad = nil)then Application.CreateForm(TViewProdutosSubgruposCad, ViewProdutosSubgruposCad);

   if(ViewProdutosSubgruposCad.Showing)then
     raise ExceptionInformation.Create(MSG_TELA_JA_ABERTA);

   try
     ViewProdutosSubgruposCad.ShowModal;
   finally
     FreeAndNil(ViewProdutosSubgruposCad);
   end;
end;

procedure TViewProdutosSubGruposBusca.Buscar;
begin
   FBusca
    .ConteudoBusca(edtBusca.Text)
    .TipoBusca(Self.GetTipoBusca)
    .Inativos(ckBuscarInativos.Enabled and ckBuscarInativos.Checked)
    .Buscar;
   inherited;
end;

procedure TViewProdutosSubGruposBusca.ConfComponents(Sender: TObject);
begin
   edtBusca.Clear;
   TMyVclLibrary.SetFocusOn(edtBusca);
end;

procedure TViewProdutosSubGruposBusca.Excluir1Click(Sender: TObject);
begin
   inherited;
   {TModelProdutosSubGruposFactory.New
    .Entitie
     .Id(DS_Busca.DataSet.FieldByName('ID').AsInteger)
     .End_Entitie
    .Deletar;}
end;

function TViewProdutosSubGruposBusca.GetTipoBusca: TTipoBuscaProdutoSubGrupo;
begin
   Result := TTipoBuscaProdutoSubGrupo.Nome;

   if(rdBuscarCodigo.Enabled and rdBuscarCodigo.Checked)then
     Result := TTipoBuscaProdutoSubGrupo.Id
   else if(rdBuscarCodGrupo.Enabled and rdBuscarCodGrupo.Checked)then
     Result := TTipoBuscaProdutoSubGrupo.GrupoId
   else if(rdBuscarNomeGrupo.Enabled and rdBuscarNomeGrupo.Checked)then
     Result := TTipoBuscaProdutoSubGrupo.GrupoNome;
end;

end.
