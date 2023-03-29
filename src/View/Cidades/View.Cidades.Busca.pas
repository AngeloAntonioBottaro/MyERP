unit View.Cidades.Busca;

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
  Model.Cidades.Busca, Vcl.Imaging.pngimage;

type
  TViewCidadesBusca = class(TViewBaseBusca)
    rdBuscarNome: TRadioButton;
    rdBuscarCodigo: TRadioButton;
    rdBuscarUF: TRadioButton;
    rdBuscarIBGE: TRadioButton;
    procedure ConfComponents(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCadastroClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridBuscaTitleClick(Column: TColumn);
  private
    FBusca: TModelCidadesBusca;
    function GetTipoBusca: TTipoBuscaCidade;
  public
    procedure Buscar; override;
  end;

var
  ViewCidadesBusca: TViewCidadesBusca;

implementation

{$R *.dfm}

uses
  MyExceptions,
  Utils.MyConsts,
  Utils.MyVclLibrary,
  View.Cidades.Cad,
  Model.Cidades.Factory;

procedure TViewCidadesBusca.FormCreate(Sender: TObject);
begin
   FGridConf := Self.GridBusca;
   FNomeConf := Self.Name;

   inherited;

   FBusca := TModelCidadesBusca.Create;
   FBusca
    .DataSource(DS_Busca);
end;

procedure TViewCidadesBusca.FormDestroy(Sender: TObject);
begin
   inherited;
   FBusca.Free;
end;

procedure TViewCidadesBusca.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   inherited;
   case(Key)of
    VK_F2: if(Shift = [])then rdBuscarCodigo.Checked := True;
    VK_F3: if(Shift = [])then rdBuscarNome.Checked   := True;
    VK_F4: if(Shift = [])then rdBuscarUF.Checked     := True;
    VK_F6: if(Shift = [])then rdBuscarIBGE.Checked   := True;
   end;
end;

procedure TViewCidadesBusca.btnCadastroClick(Sender: TObject);
begin
   inherited;
   if(ViewCidadesCad = nil)then Application.CreateForm(TViewCidadesCad, ViewCidadesCad);

   if(ViewCidadesCad.Showing)then
     raise ExceptionInformation.Create(MSG_TELA_JA_ABERTA);

   try
     ViewCidadesCad.ShowModal;
   finally
     FreeAndNil(ViewCidadesCad);
   end;
end;

procedure TViewCidadesBusca.Buscar;
begin
   FBusca
    .ConteudoBusca(edtBusca.Text)
    .TipoBusca(Self.GetTipoBusca)
    .Inativos(ckBuscarInativos.Enabled and ckBuscarInativos.Checked)
    .Buscar;
   inherited;
end;

procedure TViewCidadesBusca.ConfComponents(Sender: TObject);
begin
   edtBusca.Clear;
   TMyVclLibrary.SetFocusOn(edtBusca);
end;

function TViewCidadesBusca.GetTipoBusca: TTipoBuscaCidade;
begin
   Result := TTipoBuscaCidade.Nome;

   if(rdBuscarCodigo.Enabled and rdBuscarCodigo.Checked)then
     Result := TTipoBuscaCidade.Id
   else if(rdBuscarUF.Enabled and rdBuscarUF.Checked)then
     Result := TTipoBuscaCidade.UF
   else if(rdBuscarIBGE.Enabled and rdBuscarIBGE.Checked)then
     Result := TTipoBuscaCidade.IBGE;
end;

procedure TViewCidadesBusca.GridBuscaTitleClick(Column: TColumn);
begin
   inherited;
   FBusca.IndexFieldNames(Column.FieldName);
end;

end.
