unit View.Clientes.Busca;

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
  Model.Clientes.Busca;

type
  TViewClientesBusca = class(TViewBaseBusca)
    rdBuscarNome: TRadioButton;
    rdBuscarCodigo: TRadioButton;
    rdBuscarCPF_CNPJ: TRadioButton;
    rdBuscarCidade: TRadioButton;
    procedure ConfComponents(Sender: TObject);
    procedure btnCadastroClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Excluir1Click(Sender: TObject);
    procedure AtivarInativar1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure GridBuscaDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure GridBuscaTitleClick(Column: TColumn);
  private
    FBusca: TModelClientesBusca;
    function GetTipoBusca: TTipoBuscaCliente;
  public
    procedure Buscar; override;
  end;

var
  ViewClientesBusca: TViewClientesBusca;

implementation

{$R *.dfm}

uses
  MyExceptions,
  Utils.MyConsts,
  Utils.MyVclLibrary,
  Utils.GlobalConsts,
  View.Clientes.Cad,
  Model.Clientes.Factory;

procedure TViewClientesBusca.FormCreate(Sender: TObject);
begin
   FGridConf := Self.GridBusca;
   FNomeConf := Self.Name;

   inherited;

   FBusca := TModelClientesBusca.Create;
   FBusca
    .DataSource(DS_Busca);
end;

procedure TViewClientesBusca.FormDestroy(Sender: TObject);
begin
   inherited;
   FBusca.Free;
end;

procedure TViewClientesBusca.AtivarInativar1Click(Sender: TObject);
begin
   inherited;
   TModelClientesFactory.New
    .Entitie
     .Id(DS_Busca.DataSet.FieldByName('ID').AsInteger)
     .End_Entitie
    .AlterarStatus;
end;

procedure TViewClientesBusca.btnCadastroClick(Sender: TObject);
begin
   inherited;
   if(ViewClientesCad = nil)then Application.CreateForm(TViewClientesCad, ViewClientesCad);

   if(ViewClientesCad.Showing)then
     raise ExceptionInformation.Create(MSG_TELA_JA_ABERTA);

   try
     ViewClientesCad.ShowModal;
   finally
     FreeAndNil(ViewClientesCad);
   end;
end;

procedure TViewClientesBusca.Buscar;
begin
   FBusca
    .ConteudoBusca(edtBusca.Text)
    .TipoBusca(Self.GetTipoBusca)
    .Inativos(ckBuscarInativos.Enabled and ckBuscarInativos.Checked)
    .Buscar;
   inherited;
end;

procedure TViewClientesBusca.Excluir1Click(Sender: TObject);
begin
   inherited;
   TModelClientesFactory.New
    .Entitie
     .Id(DS_Busca.DataSet.FieldByName('ID').AsInteger)
     .End_Entitie
    .Deletar;
end;

procedure TViewClientesBusca.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   inherited;
   case(Key)of
    VK_F2: if(Shift = [])then rdBuscarCodigo.Checked   := True;
    VK_F3: if(Shift = [])then rdBuscarNome.Checked     := True;
    VK_F4: if(Shift = [])then rdBuscarCPF_CNPJ.Checked := True;
    VK_F6: if(Shift = [])then rdBuscarCidade.Checked   := True;
   end;
end;

function TViewClientesBusca.GetTipoBusca: TTipoBuscaCliente;
begin
   Result := TTipoBuscaCliente.Nome;

   if(rdBuscarCodigo.Enabled and rdBuscarCodigo.Checked)then
     Result := TTipoBuscaCliente.Id
   else if(rdBuscarCPF_CNPJ.Enabled and rdBuscarCPF_CNPJ.Checked)then
     Result := TTipoBuscaCliente.CPF_CNPJ
   else if(rdBuscarCidade.Enabled and rdBuscarCidade.Checked)then
     Result := TTipoBuscaCliente.Cidade;
end;

procedure TViewClientesBusca.GridBuscaDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   inherited;
   if(DS_Busca.DataSet.FieldByName('STATUS').AsString.Equals(STATUS_INATIVO))then
   begin
      TDBGrid(Sender).Canvas.Font.Color := clRed;
      TDBGrid(Sender).Canvas.FillRect(Rect);
      TDBGrid(Sender).DefaultDrawDataCell(rect, Column.Field, state);
   end;
end;

procedure TViewClientesBusca.GridBuscaTitleClick(Column: TColumn);
begin
   inherited;
   FBusca.IndexFieldNames(Column.FieldName);
end;

procedure TViewClientesBusca.ConfComponents(Sender: TObject);
begin
   edtBusca.Clear;
   TMyVclLibrary.SetFocusOn(edtBusca);
end;

end.
