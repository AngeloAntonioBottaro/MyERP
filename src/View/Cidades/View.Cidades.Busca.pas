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
  Vcl.Imaging.pngimage,
  View.Base.Busca,
  Data.DB,
  Utils.Types,
  Model.Cidades.Busca;

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
    procedure GetConteudoBusca;
  public
    procedure Buscar; override;
  end;

var
  ViewCidadesBusca: TViewCidadesBusca;

implementation

{$R *.dfm}

uses
  MyExceptions,
  MyVclLibrary,
  Common.Utils.MyConsts,
  View.Cidades.Cad,
  Model.Cidades.Factory;

procedure TViewCidadesBusca.FormCreate(Sender: TObject);
var
  I: Integer;
begin
   FGridConf := Self.GridBusca;
   FNomeConf := Self.Name;

   inherited;

   FBusca := TModelCidadesBusca.Create;
   FBusca
    .DataSource(DS_Busca);

   cBoxBusca.Items.Clear;
   for I := Low(ESTADOS) to High(ESTADOS) do
     cBoxBusca.Items.Add(ESTADOS[I]);
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
   Self.GetConteudoBusca;

   FBusca
    .TipoBusca(Self.GetTipoBusca)
    .Inativos(ckBuscarInativos.Enabled and ckBuscarInativos.Checked)
    .Buscar;
   inherited;
end;

procedure TViewCidadesBusca.ConfComponents(Sender: TObject);
begin
   edtBusca.Clear;
   TMyVclLibrary.SetFocusOn(edtBusca);

   pnBuscarConteudo.Visible := not rdBuscarUF.Checked;
   pnBuscarComboBox.Visible := rdBuscarUF.Checked;
end;

procedure TViewCidadesBusca.GetConteudoBusca;
begin
   FBusca.ConteudoBusca(edtBusca.Text);
   if(pnBuscarComboBox.Visible)then
   begin
      if(not cBoxBusca.ItemIndex >= 0)then
        raise ExceptionRequired.Create('Selecione o conteúdo a ser consultado', cBoxBusca);

      FBusca.ConteudoBusca(cBoxBusca.Text);
   end;
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
