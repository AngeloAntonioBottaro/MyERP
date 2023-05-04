unit View.Permissoes.Grupos.Busca;

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
  View.Base.Busca,
  Data.DB,
  Utils.Types,
  Model.Permissoes.Grupos.Busca;

const
  TELA = 'Busca de grupos de permissões';

type
  TViewPermissoesGruposBusca = class(TViewBaseBusca)
    rdBuscarNome: TRadioButton;
    rdBuscarCodigo: TRadioButton;
    rdBuscarDescricao: TRadioButton;
    procedure ConfComponents(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Excluir1Click(Sender: TObject);
    procedure GridBuscaTitleClick(Column: TColumn);
    procedure btnCadastroClick(Sender: TObject);
  private
    FBusca: TModelPermissoesGruposBusca;
    function GetTipoBusca: TTipoBuscaPermissoesGrupo;
  public
    procedure Buscar; override;
  end;

var
  ViewPermissoesGruposBusca: TViewPermissoesGruposBusca;

implementation

{$R *.dfm}

uses
  MyExceptions,
  Utils.MyConsts,
  Utils.MyVclLibrary,
  Utils.GlobalConsts,
  View.Permissoes.Grupos.Cad,
  Model.Permissoes.Grupos.Factory;

procedure TViewPermissoesGruposBusca.FormCreate(Sender: TObject);
begin
   FGridConf := Self.GridBusca;
   FNomeConf := Self.Name;

   inherited;

   FBusca := TModelPermissoesGruposBusca.Create;
   FBusca
    .DataSource(DS_Busca);
end;

procedure TViewPermissoesGruposBusca.FormDestroy(Sender: TObject);
begin
   inherited;
   FBusca.Free;
end;

procedure TViewPermissoesGruposBusca.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   inherited;
   case(Key)of
    VK_F2: if(Shift = [])then rdBuscarCodigo.Checked    := True;
    VK_F3: if(Shift = [])then rdBuscarNome.Checked      := True;
    VK_F4: if(Shift = [])then rdBuscarDescricao.Checked := True;
   end;
end;

procedure TViewPermissoesGruposBusca.btnCadastroClick(Sender: TObject);
begin
   inherited;
   if(ViewPermissoesGruposCad = nil)then Application.CreateForm(TViewPermissoesGruposCad, ViewPermissoesGruposCad);

   if(ViewPermissoesGruposCad.Showing)then
     raise ExceptionInformation.Create(MSG_TELA_JA_ABERTA);

   try
     ViewPermissoesGruposCad.ShowModal;
   finally
     FreeAndNil(ViewPermissoesGruposCad);
   end;
end;

procedure TViewPermissoesGruposBusca.Buscar;
begin
   FBusca
    .ConteudoBusca(edtBusca.Text)
    .TipoBusca(Self.GetTipoBusca)
    .Inativos(ckBuscarInativos.Enabled and ckBuscarInativos.Checked)
    .Buscar;
   inherited;
end;

procedure TViewPermissoesGruposBusca.ConfComponents(Sender: TObject);
begin
   edtBusca.Clear;
   TMyVclLibrary.SetFocusOn(edtBusca);
end;

procedure TViewPermissoesGruposBusca.Excluir1Click(Sender: TObject);
begin
   inherited;
   TModelPermissoesGruposFactory.New(TELA)
    .Entitie
     .Id(DS_Busca.DataSet.FieldByName('ID').AsInteger)
     .End_Entitie
    .Deletar;
end;

function TViewPermissoesGruposBusca.GetTipoBusca: TTipoBuscaPermissoesGrupo;
begin
   Result := TTipoBuscaPermissoesGrupo.Nome;

   if(rdBuscarCodigo.Enabled and rdBuscarCodigo.Checked)then
     Result := TTipoBuscaPermissoesGrupo.Id
   else if(rdBuscarDescricao.Enabled and rdBuscarDescricao.Checked)then
     Result := TTipoBuscaPermissoesGrupo.Descricao;
end;

procedure TViewPermissoesGruposBusca.GridBuscaTitleClick(Column: TColumn);
begin
   inherited;
   FBusca.IndexFieldNames(Column.FieldName);
end;

end.
