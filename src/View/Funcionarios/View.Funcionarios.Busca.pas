unit View.Funcionarios.Busca;

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
  Model.Funcionarios.Busca;

const
  TELA = 'Busca de funcionários';

type
  TViewFuncionariosBusca = class(TViewBaseBusca)
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
    FBusca: TModelFuncionariosBusca;
    function GetTipoBusca: TTipoBuscaFuncionario;
  public
    procedure Buscar; override;
  end;

var
  ViewFuncionariosBusca: TViewFuncionariosBusca;

implementation

{$R *.dfm}

uses
  MyExceptions,
  MyVclLibrary,
  Common.Utils.MyConsts,
  Utils.GlobalConsts,
  View.Funcionarios.Cad,
  Model.Funcionarios.Factory;

procedure TViewFuncionariosBusca.FormCreate(Sender: TObject);
begin
   FGridConf := Self.GridBusca;
   FNomeConf := Self.Name;

   inherited;

   FBusca := TModelFuncionariosBusca.Create;
   FBusca
    .DataSource(DS_Busca);
end;

procedure TViewFuncionariosBusca.FormDestroy(Sender: TObject);
begin
   inherited;
   FBusca.Free;
end;

procedure TViewFuncionariosBusca.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   inherited;
   case(Key)of
    VK_F2: if(Shift = [])then rdBuscarCodigo.Checked   := True;
    VK_F3: if(Shift = [])then rdBuscarNome.Checked     := True;
    VK_F4: if(Shift = [])then rdBuscarCPF_CNPJ.Checked := True;
    VK_F6: if(Shift = [])then rdBuscarCidade.Checked   := True;
   end;
end;

procedure TViewFuncionariosBusca.AtivarInativar1Click(Sender: TObject);
begin
   inherited;
   TModelFuncionariosFactory.New(TELA)
    .Entitie
     .Id(DS_Busca.DataSet.FieldByName('ID').AsInteger)
     .End_Entitie
    .AlterarStatus;
end;

procedure TViewFuncionariosBusca.btnCadastroClick(Sender: TObject);
begin
   inherited;
   if(ViewFuncionariosCad = nil)then Application.CreateForm(TViewFuncionariosCad, ViewFuncionariosCad);

   if(ViewFuncionariosCad.Showing)then
     raise ExceptionInformation.Create(MSG_TELA_JA_ABERTA);

   try
     ViewFuncionariosCad.ShowModal;
   finally
     FreeAndNil(ViewFuncionariosCad);
   end;
end;

procedure TViewFuncionariosBusca.Buscar;
begin
   FBusca
    .ConteudoBusca(edtBusca.Text)
    .TipoBusca(Self.GetTipoBusca)
    .Inativos(ckBuscarInativos.Enabled and ckBuscarInativos.Checked)
    .Buscar;
   inherited;
end;

procedure TViewFuncionariosBusca.ConfComponents(Sender: TObject);
begin
   edtBusca.Clear;
   TMyVclLibrary.SetFocusOn(edtBusca);
end;

procedure TViewFuncionariosBusca.Excluir1Click(Sender: TObject);
begin
   inherited;
   TModelFuncionariosFactory.New(TELA)
    .Entitie
     .Id(DS_Busca.DataSet.FieldByName('ID').AsInteger)
     .End_Entitie
    .Deletar;
end;

function TViewFuncionariosBusca.GetTipoBusca: TTipoBuscaFuncionario;
begin
   Result := TTipoBuscaFuncionario.Nome;

   if(rdBuscarCodigo.Enabled and rdBuscarCodigo.Checked)then
     Result := TTipoBuscaFuncionario.Id
   else if(rdBuscarCPF_CNPJ.Enabled and rdBuscarCPF_CNPJ.Checked)then
     Result := TTipoBuscaFuncionario.CPF_CNPJ
   else if(rdBuscarCidade.Enabled and rdBuscarCidade.Checked)then
     Result := TTipoBuscaFuncionario.Cidade;
end;

procedure TViewFuncionariosBusca.GridBuscaDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   inherited;
   if(DS_Busca.DataSet.FieldByName('STATUS').AsString.Equals(STATUS_INATIVO))then
   begin
      TDBGrid(Sender).Canvas.Font.Color := clRed;
      TDBGrid(Sender).Canvas.FillRect(Rect);
      TDBGrid(Sender).DefaultDrawDataCell(rect,Column.Field,state);
   end;
end;

procedure TViewFuncionariosBusca.GridBuscaTitleClick(Column: TColumn);
begin
   inherited;
   FBusca.IndexFieldNames(Column.FieldName);
end;

end.
