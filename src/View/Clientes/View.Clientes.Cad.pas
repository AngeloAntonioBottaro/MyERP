unit View.Clientes.Cad;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  View.Base.Cadastros,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.DBCtrls,
  Vcl.Mask,
  Vcl.ComCtrls,
  Model.Clientes.Interfaces,
  Model.Clientes.Entitie;

type
  TViewClientesCad = class(TViewBaseCadastros)
    pnTela: TPanel;
    lbId: TLabel;
    lbRazaoSocial: TLabel;
    lbNomeFantasia: TLabel;
    lbTelefone: TLabel;
    lbTelefone2: TLabel;
    lbEndereco: TLabel;
    lbBairro: TLabel;
    lbCEP: TLabel;
    lbIdCidade: TLabel;
    lbUF: TLabel;
    lbCPF: TLabel;
    lbRG: TLabel;
    cBoxTipoJuridico: TComboBox;
    lbTipoJuridico: TLabel;
    lbNomeCidade: TLabel;
    lbCNPJ: TLabel;
    lbIE: TLabel;
    edtId: TEdit;
    edtRazaoSocial: TEdit;
    edtNomeFantasia: TEdit;
    edtEndereco: TEdit;
    edtBairro: TEdit;
    lbNumero: TLabel;
    edtNumero: TEdit;
    edtCep: TEdit;
    edtIdCidade: TEdit;
    edtCidade: TEdit;
    edtUF: TEdit;
    edtTelefone: TEdit;
    edtTelefone2: TEdit;
    dtpDataNascimento: TDateTimePicker;
    lbDataNascimento: TLabel;
    lbIdade: TLabel;
    edtIdade: TEdit;
    lbCelular: TLabel;
    edtCelular: TEdit;
    lbFax: TLabel;
    edtFax: TEdit;
    lbEmail: TLabel;
    edtEmail: TEdit;
    edtCPF: TEdit;
    edtRG: TEdit;
    edtCNPJ: TEdit;
    edtIE: TEdit;
    edtRGOrgaoExpedidor: TEdit;
    lbRgOrgaoExpedidor: TLabel;
    procedure ConfComponents(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtCPFExit(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    FCliente: IModelClientesFactory<TModelClientesEntitie>;
    procedure InitialConfiguration;
    procedure NewClient;
    procedure FillFields;
  public
  end;

var
  ViewClientesCad: TViewClientesCad;

implementation

{$R *.dfm}

uses
  MyExceptions,
  Utils.MyConsts,
  Utils.MyVclLibrary,
  Model.Clientes.Factory,
  View.Clientes.Busca;

procedure TViewClientesCad.FormCreate(Sender: TObject);
begin
   inherited;
   Self.InitialConfiguration;
end;

procedure TViewClientesCad.btnBuscarClick(Sender: TObject);
begin
   inherited;
   if(ViewClientesBusca = nil)then Application.CreateForm(TViewClientesBusca, ViewClientesBusca);
   try
     ViewClientesBusca.btnCadastro.Enabled := False;
     ViewClientesBusca.ShowModal;
   finally
     FreeAndNil(ViewClientesBusca);
   end;
   Self.FillFields;
end;

procedure TViewClientesCad.btnExcluirClick(Sender: TObject);
begin
   inherited;
   if(edtId.Text = EmptyStr)then
     Exit;
end;

procedure TViewClientesCad.btnGravarClick(Sender: TObject);
begin
   inherited;
   FCliente
    .Entitie
     .Id(edtId.Text)
     .RazaoSocial(edtRazaoSocial.Text)
     .NomeFantasia(edtNomeFantasia.Text)
     .Endereco(edtEndereco.Text)
     .Numero(edtNumero.Text)
     .Bairro(edtBairro.Text)
     .Cep(edtCep.Text)
     .Cidade(edtIdCidade.Text)
     .DataNascimento(dtpDataNascimento.Date)
     .Telefone(edtTelefone.Text)
     .Telefone2(edtTelefone2.Text)
     .Celular(edtCelular.Text)
     .Fax(edtFax.Text)
     .Email(edtEmail.Text)
     .TipoJuridico(cBoxTipoJuridico.Text)
     .Cnpj(edtCNPJ.Text)
     .IE(edtIE.Text)
     .Cpf(edtCPF.Text)
     .RG(edtRG.Text)
     .RgOrgaoExpedidor(edtRGOrgaoExpedidor.Text)
     .End_Entitie;
end;

procedure TViewClientesCad.btnNovoClick(Sender: TObject);
begin
   inherited;
   Self.NewClient;

   TMyVclLibrary.SetFocusOn(edtRazaoSocial);
end;

procedure TViewClientesCad.edtCPFExit(Sender: TObject);
begin
   if(not Assigned(FCliente))then
     Exit;

   if(FCliente.Entitie.Cpf(edtCPF.Text).End_Entitie.ValidarCPF)then
     Exit;

   edtCPF.SetFocus;
   raise ExceptionInformation.Create('CPF inválido');
end;

procedure TViewClientesCad.FillFields;
begin
   if(not Assigned(FCliente))then
     Exit;

   edtId.Text               := FCliente.Entitie.Id.ToString;
   edtRazaoSocial.Text      := FCliente.Entitie.RazaoSocial;
   edtNomeFantasia.Text     := FCliente.Entitie.NomeFantasia;
   edtEndereco.Text         := FCliente.Entitie.Endereco;
   edtNumero.Text           := FCliente.Entitie.Numero;
   edtBairro.Text           := FCliente.Entitie.Bairro;
   edtCep.Text              := FCliente.Entitie.Cep.ToString;
   edtIdCidade.Text         := FCliente.Entitie.Cidade.ToString;
   dtpDataNascimento.Date   := FCliente.Entitie.DataNascimento;
   edtTelefone.Text         := FCliente.Entitie.Telefone;
   edtTelefone2.Text        := FCliente.Entitie.Telefone2;
   edtCelular.Text          := FCliente.Entitie.Celular;
   edtFax.Text              := FCliente.Entitie.Fax;
   edtEmail.Text            := FCliente.Entitie.Email;
   edtCNPJ.Text             := FCliente.Entitie.Cnpj;
   edtIE.Text               := FCliente.Entitie.IE;
   edtCPF.Text              := FCliente.Entitie.Cpf;
   edtRG.Text               := FCliente.Entitie.RG;
   edtRGOrgaoExpedidor.Text := FCliente.Entitie.RgOrgaoExpedidor;

   cBoxTipoJuridico.ItemIndex := 0;
   if(FCliente.Entitie.TipoJuridico.Equals(PESSOA_JURIDICA))then
     cBoxTipoJuridico.ItemIndex := 1;
end;

procedure TViewClientesCad.InitialConfiguration;
begin
   edtIdCidade.ShowHint := True;
   edtIdCidade.Hint     := HINT_ATALHO_CONSULTA;

   cBoxTipoJuridico.Items.Clear;
   cBoxTipoJuridico.Items.Add(PESSOA_FISICA);
   cBoxTipoJuridico.Items.Add(PESSOA_JURIDICA);

   Self.ConfComponents(nil);
end;

procedure TViewClientesCad.NewClient;
begin
   FCliente := TModelClientesFactory.New;
end;

procedure TViewClientesCad.ConfComponents(Sender: TObject);
begin
   //*VARIOS
   edtCNPJ.Enabled              := cBoxTipoJuridico.Text = PESSOA_JURIDICA;
   edtIE.Enabled                := cBoxTipoJuridico.Text = PESSOA_JURIDICA;
   edtCPF.Enabled               := cBoxTipoJuridico.Text = PESSOA_FISICA;
   edtRG.Enabled                := cBoxTipoJuridico.Text = PESSOA_FISICA;
   edtRGOrgaoExpedidor.Enabled  := cBoxTipoJuridico.Text = PESSOA_FISICA;
end;

end.
