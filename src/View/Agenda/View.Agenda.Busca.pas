unit View.Agenda.Busca;

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
  Utils.MyTypes,
  Model.Agenda.Busca;

type
  TViewAgendaBusca = class(TViewBaseBusca)
    rdBuscarCliente: TRadioButton;
    rdBuscarCodigo: TRadioButton;
    rdBuscarFuncionario: TRadioButton;
    rdBuscarStatus: TRadioButton;
    procedure ConfComponents(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridBuscaTitleClick(Column: TColumn);
  private
    FBusca: TModelAgendaBusca;
    function GetTipoBusca: TTipoBuscaAgenda;
    procedure GetConteudoBusca;
  public
    procedure Buscar; override;
  end;

var
  ViewAgendaBusca: TViewAgendaBusca;

implementation

{$R *.dfm}

uses
  MyExceptions,
  Utils.MyConsts,
  Utils.MyVclLibrary,
  Utils.GlobalConsts,
  View.Cidades.Cad,
  Model.Agenda.Factory;

procedure TViewAgendaBusca.FormCreate(Sender: TObject);
var
  I: Integer;
begin
   FGridConf := Self.GridBusca;
   FNomeConf := Self.Name;

   inherited;

   FBusca := TModelAgendaBusca.Create;
   FBusca
    .DataSource(DS_Busca);

   cBoxBusca.Items.Clear;
   for I := Low(AGENDA_STATUS) to High(AGENDA_STATUS) do
     cBoxBusca.Items.Add(AGENDA_STATUS[I]);

   cBoxBusca.ItemIndex := 0;
end;

procedure TViewAgendaBusca.FormDestroy(Sender: TObject);
begin
   inherited;
   FBusca.Free;
end;

procedure TViewAgendaBusca.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   inherited;
   case(Key)of
    VK_F2: if(Shift = [])then rdBuscarCodigo.Checked      := True;
    VK_F3: if(Shift = [])then rdBuscarCliente.Checked     := True;
    VK_F4: if(Shift = [])then rdBuscarFuncionario.Checked := True;
    VK_F6: if(Shift = [])then rdBuscarStatus.Checked      := True;
   end;
end;

procedure TViewAgendaBusca.Buscar;
begin
   Self.GetConteudoBusca;
   FBusca
    .TipoBusca(Self.GetTipoBusca)
    .Inativos(ckBuscarInativos.Enabled and ckBuscarInativos.Checked)
    .Buscar;
   inherited;
end;

procedure TViewAgendaBusca.ConfComponents(Sender: TObject);
begin
   edtBusca.Clear;
   cBoxBusca.ItemIndex := 0;

   pnBuscarConteudo.Visible := not rdBuscarStatus.Checked;
   pnBuscarComboBox.Visible := rdBuscarStatus.Checked;

   if(pnBuscarConteudo.Visible)then
     TMyVclLibrary.SetFocusOn(edtBusca);
end;

procedure TViewAgendaBusca.GetConteudoBusca;
begin
   FBusca.ConteudoBusca(edtBusca.Text);
   if(pnBuscarComboBox.Visible)then
   begin
      if(not cBoxBusca.ItemIndex >= 0)then
        raise ExceptionRequired.Create('Selecione o conteúdo a ser consultado', cBoxBusca);

      FBusca.ConteudoBusca(cBoxBusca.Text);
   end;
end;

function TViewAgendaBusca.GetTipoBusca: TTipoBuscaAgenda;
begin
   Result := TTipoBuscaAgenda.Cliente;

   if(rdBuscarCodigo.Enabled and rdBuscarCodigo.Checked)then
     Result := TTipoBuscaAgenda.Id
   else if(rdBuscarFuncionario.Enabled and rdBuscarFuncionario.Checked)then
     Result := TTipoBuscaAgenda.Funcionario
   else if(rdBuscarStatus.Enabled and rdBuscarStatus.Checked)then
     Result := TTipoBuscaAgenda.Status;
end;

procedure TViewAgendaBusca.GridBuscaTitleClick(Column: TColumn);
begin
   inherited;
   FBusca.IndexFieldNames(Column.FieldName);
end;

end.
