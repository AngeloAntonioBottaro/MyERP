unit View.Funcionarios.Funcoes.Busca;

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
  Model.Funcionarios.Funcoes.Busca;

type
  TViewFuncionarioFuncoesBusca = class(TViewBaseBusca)
    rdBuscarNome: TRadioButton;
    rdBuscarCodigo: TRadioButton;
    procedure ConfComponents(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCadastroClick(Sender: TObject);
    procedure Excluir1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridBuscaTitleClick(Column: TColumn);
  private
    FBusca: TModelFuncionariosFuncoesBusca;
    function GetTipoBusca: TTipoBuscaFuncionarioFuncao;
  public
    procedure Buscar; override;
  end;

var
  ViewFuncionarioFuncoesBusca: TViewFuncionarioFuncoesBusca;

implementation

{$R *.dfm}

uses
  MyExceptions,
  Utils.MyConsts,
  Utils.MyVclLibrary,
  Utils.GlobalConsts,
  View.Funcionarios.Funcoes.Cad,
  Model.Funcionarios.Funcoes.Factory;

procedure TViewFuncionarioFuncoesBusca.FormCreate(Sender: TObject);
begin
   FGridConf := Self.GridBusca;
   FNomeConf := Self.Name;

   inherited;

   FBusca := TModelFuncionariosFuncoesBusca.Create;
   FBusca
    .DataSource(DS_Busca);
end;

procedure TViewFuncionarioFuncoesBusca.FormDestroy(Sender: TObject);
begin
   inherited;
   FBusca.Free;
end;

procedure TViewFuncionarioFuncoesBusca.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   inherited;
   case(Key)of
    VK_F2: if(Shift = [])then rdBuscarCodigo.Checked   := True;
    VK_F3: if(Shift = [])then rdBuscarNome.Checked     := True;
   end;
end;

procedure TViewFuncionarioFuncoesBusca.btnCadastroClick(Sender: TObject);
begin
   inherited;
   if(ViewFuncionariosFuncoesCad = nil)then Application.CreateForm(TViewFuncionariosFuncoesCad, ViewFuncionariosFuncoesCad);

   if(ViewFuncionariosFuncoesCad.Showing)then
     raise ExceptionInformation.Create(MSG_TELA_JA_ABERTA);

   try
     ViewFuncionariosFuncoesCad.ShowModal;
   finally
     FreeAndNil(ViewFuncionariosFuncoesCad);
   end;
end;

procedure TViewFuncionarioFuncoesBusca.Buscar;
begin
   FBusca
    .ConteudoBusca(edtBusca.Text)
    .TipoBusca(Self.GetTipoBusca)
    .Inativos(ckBuscarInativos.Enabled and ckBuscarInativos.Checked)
    .Buscar;
   inherited;
end;

procedure TViewFuncionarioFuncoesBusca.ConfComponents(Sender: TObject);
begin
   edtBusca.Clear;
   TMyVclLibrary.SetFocusOn(edtBusca);
end;

procedure TViewFuncionarioFuncoesBusca.Excluir1Click(Sender: TObject);
begin
   inherited;
   TModelFuncionariosFuncoesFactory.New
    .Entitie
     .Id(DS_Busca.DataSet.FieldByName('ID').AsInteger)
     .End_Entitie
    .Deletar;
end;

function TViewFuncionarioFuncoesBusca.GetTipoBusca: TTipoBuscaFuncionarioFuncao;
begin
   Result := TTipoBuscaFuncionarioFuncao.Nome;

   if(rdBuscarCodigo.Enabled and rdBuscarCodigo.Checked)then
     Result := TTipoBuscaFuncionarioFuncao.Id;
end;

procedure TViewFuncionarioFuncoesBusca.GridBuscaTitleClick(Column: TColumn);
begin
   inherited;
   FBusca.IndexFieldNames(Column.FieldName);
end;

end.
