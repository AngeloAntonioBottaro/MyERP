unit View.Fornecedores.Busca;

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
  Vcl.Imaging.pngimage,
  View.Base.Busca,
  Data.DB,
  Utils.Types,
  Model.Fornecedores.Busca;

const
  TELA = 'Busca de fornecedores';

type
  TViewFornecedoresBusca = class(TViewBaseBusca)
    rdBuscarNome: TRadioButton;
    rdBuscarCodigo: TRadioButton;
    rdBuscarCPF_CNPJ: TRadioButton;
    rdBuscarCidade: TRadioButton;
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
    FBusca: TModelFornecedoresBusca;
    function GetTipoBusca: TTipoBuscaFornecedor;
  public
    procedure Buscar; override;
  end;

var
  ViewFornecedoresBusca: TViewFornecedoresBusca;

implementation

{$R *.dfm}

uses
  MyExceptions,
  MyVclLibrary,
  Common.Utils.MyConsts,
  Utils.GlobalConsts,
  View.Fornecedores.Cad,
  Model.Fornecedores.Factory;

procedure TViewFornecedoresBusca.FormCreate(Sender: TObject);
begin
   FGridConf := Self.GridBusca;
   FNomeConf := Self.Name;

   inherited;

   FBusca := TModelFornecedoresBusca.Create;
   FBusca
    .DataSource(DS_Busca);
end;

procedure TViewFornecedoresBusca.FormDestroy(Sender: TObject);
begin
   inherited;
   FBusca.Free;
end;

procedure TViewFornecedoresBusca.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   inherited;
   case(Key)of
    VK_F2: if(Shift = [])then rdBuscarCodigo.Checked   := True;
    VK_F3: if(Shift = [])then rdBuscarNome.Checked     := True;
    VK_F4: if(Shift = [])then rdBuscarCPF_CNPJ.Checked := True;
    VK_F6: if(Shift = [])then rdBuscarCidade.Checked   := True;
   end;
end;

procedure TViewFornecedoresBusca.AtivarInativar1Click(Sender: TObject);
begin
   inherited;
   TModelFornecedoresFactory.New(TELA)
    .Entitie
     .Id(DS_Busca.DataSet.FieldByName('ID').AsInteger)
     .End_Entitie
    .AlterarStatus;
end;

procedure TViewFornecedoresBusca.btnCadastroClick(Sender: TObject);
begin
   inherited;
   if(ViewFornecedoresCad = nil)then Application.CreateForm(TViewFornecedoresCad, ViewFornecedoresCad);

   if(ViewFornecedoresCad.Showing)then
     raise ExceptionInformation.Create(MSG_TELA_JA_ABERTA);

   try
     ViewFornecedoresCad.ShowModal;
   finally
     FreeAndNil(ViewFornecedoresCad);
   end;
end;

procedure TViewFornecedoresBusca.Buscar;
begin
   FBusca
    .ConteudoBusca(edtBusca.Text)
    .TipoBusca(Self.GetTipoBusca)
    .Inativos(ckBuscarInativos.Enabled and ckBuscarInativos.Checked)
    .Buscar;
   inherited;
end;

function TViewFornecedoresBusca.GetTipoBusca: TTipoBuscaFornecedor;
begin
   Result := TTipoBuscaFornecedor.Nome;

   if(rdBuscarCodigo.Enabled and rdBuscarCodigo.Checked)then
     Result := TTipoBuscaFornecedor.Id
   else if(rdBuscarCPF_CNPJ.Enabled and rdBuscarCPF_CNPJ.Checked)then
     Result := TTipoBuscaFornecedor.CPF_CNPJ
   else if(rdBuscarCidade.Enabled and rdBuscarCidade.Checked)then
     Result := TTipoBuscaFornecedor.Cidade;
end;

procedure TViewFornecedoresBusca.GridBuscaDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   inherited;
   if(DS_Busca.DataSet.FieldByName('STATUS').AsString.Equals(STATUS_INATIVO))then
   begin
      TDBGrid(Sender).Canvas.Font.Color := clRed;
      TDBGrid(Sender).Canvas.FillRect(Rect);
      TDBGrid(Sender).DefaultDrawDataCell(rect,Column.Field,state);
   end;
end;

procedure TViewFornecedoresBusca.GridBuscaTitleClick(Column: TColumn);
begin
   inherited;
   FBusca.IndexFieldNames(Column.FieldName);
end;

procedure TViewFornecedoresBusca.ConfComponents(Sender: TObject);
begin
   edtBusca.Clear;
   TMyVclLibrary.SetFocusOn(edtBusca);
end;

procedure TViewFornecedoresBusca.Excluir1Click(Sender: TObject);
begin
   inherited;
   TModelFornecedoresFactory.New(TELA)
    .Entitie
     .Id(DS_Busca.DataSet.FieldByName('ID').AsInteger)
     .End_Entitie
    .Deletar;
end;

end.
