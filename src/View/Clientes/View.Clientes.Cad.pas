unit View.Clientes.Cad;

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
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.DBCtrls,
  Vcl.Mask,
  Vcl.ComCtrls,
  View.Base.Cadastros,
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
    procedure btnNovoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure edtIdCidadeExit(Sender: TObject);
    procedure edtIdCidadeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FCliente: IModelClientesFactory<TModelClientesEntitie>;
    procedure FillEntitie;
  public
    procedure InitialConfiguration; override;
    procedure NewEntitie; override;
    procedure FillFields; override;
    procedure OnBusca(AId: Integer); override;
  end;

var
  ViewClientesCad: TViewClientesCad;

implementation

{$R *.dfm}

uses
  MyMessage,
  MyVclLibrary,
  Common.Utils.MyConsts,
  Common.Utils.MyLibrary,
  Utils.GlobalConsts,
  Utils.LibrarySistema,
  Utils.EditsKeyDownExit,
  Model.Clientes.Factory,
  View.Clientes.Busca;

procedure TViewClientesCad.btnAlterarClick(Sender: TObject);
begin
   inherited;
   if(not Assigned(FCliente))then
     Exit;

   if(not (FCliente.Entitie.Id > 0))then
     Exit;

   Self.StartOperations;
   Self.ConfComponents(nil);
end;

procedure TViewClientesCad.btnBuscarClick(Sender: TObject);
begin
   inherited;
   CriarFormMsgJaAberto(TViewClientesBusca, ViewClientesBusca);
   try
     ViewClientesBusca.btnCadastro.Enabled := False;
     ViewClientesBusca.FOnBusca := Self.OnBusca;
     ViewClientesBusca.ShowModal;
   finally
     FreeAndNil(ViewClientesBusca);
   end;
end;

procedure TViewClientesCad.btnCancelarClick(Sender: TObject);
begin
   inherited;
   Self.ConfComponents(nil);
end;

procedure TViewClientesCad.btnExcluirClick(Sender: TObject);
begin
   inherited;
   if(edtId.Text = EmptyStr)then
     Exit;

   FCliente.Deletar;
   Self.EndOperations;
   Self.EmptyFields;
end;

procedure TViewClientesCad.btnGravarClick(Sender: TObject);
begin
   inherited;
   Self.FillEntitie;
   FCliente.Gravar;

   Self.EndOperations;
   Self.FillFields;
   Self.ConfComponents(nil);
end;

procedure TViewClientesCad.btnNovoClick(Sender: TObject);
begin
   inherited;
   dtpDataNascimento.Date := Now;
   cBoxTipoJuridico.ItemIndex := 0;
   Self.ConfComponents(nil);
   TMyVclLibrary.SetFocusOn(edtRazaoSocial);
end;

procedure TViewClientesCad.FillEntitie;
begin
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
     .End_Entitie
end;

procedure TViewClientesCad.FillFields;
begin
   if(not Assigned(FCliente))then
     Exit;

   edtId.Text                 := FCliente.Entitie.IdMascara;
   edtRazaoSocial.Text        := FCliente.Entitie.RazaoSocial;
   edtNomeFantasia.Text       := FCliente.Entitie.NomeFantasia;
   edtEndereco.Text           := FCliente.Entitie.Endereco;
   edtNumero.Text             := FCliente.Entitie.Numero;
   edtBairro.Text             := FCliente.Entitie.Bairro;
   edtCep.Text                := FCliente.Entitie.CepMascara;
   edtIdCidade.Text           := FCliente.Entitie.CidadeMascara;
   dtpDataNascimento.Date     := FCliente.Entitie.DataNascimento;
   edtTelefone.Text           := FCliente.Entitie.TelefoneMascara;
   edtTelefone2.Text          := FCliente.Entitie.Telefone2Mascara;
   edtCelular.Text            := FCliente.Entitie.CelularMascara;
   edtFax.Text                := FCliente.Entitie.FaxMascara;
   edtEmail.Text              := FCliente.Entitie.Email;
   edtCNPJ.Text               := FCliente.Entitie.CnpjMascara;
   edtIE.Text                 := FCliente.Entitie.IE;
   edtCPF.Text                := FCliente.Entitie.CpfMascara;
   edtRG.Text                 := FCliente.Entitie.RG;
   edtRGOrgaoExpedidor.Text   := FCliente.Entitie.RgOrgaoExpedidor;
   cBoxTipoJuridico.ItemIndex := FCliente.Entitie.TipoJuridicoComboBox;
end;

procedure TViewClientesCad.InitialConfiguration;
begin
   dtpDataNascimento.Date := Now;
   edtIdCidade.ShowHint   := True;
   edtIdCidade.Hint       := HINT_ATALHO_CONSULTA;

   CriarComboBoxTipoJuridico(cBoxTipoJuridico.Items);

   Self.ConfComponents(nil);
end;

procedure TViewClientesCad.NewEntitie;
begin
   FCliente := TModelClientesFactory.New('Cadastro de cliente');
end;

procedure TViewClientesCad.OnBusca(AId: Integer);
begin
   Self.NewEntitie;

   FCliente
    .Entitie
     .Id(AId)
     .End_Entitie
    .ConsultarEntitie;

   Self.FillFields;
   Self.ConfComponents(nil);
   edtIdCidadeExit(edtIdCidade);
end;

procedure TViewClientesCad.ConfComponents(Sender: TObject);
begin
   //*VARIOS
   edtCNPJ.Enabled             := cBoxTipoJuridico.Text = PESSOA_JURIDICA;
   edtIE.Enabled               := cBoxTipoJuridico.Text = PESSOA_JURIDICA;
   edtCPF.Enabled              := cBoxTipoJuridico.Text = PESSOA_FISICA;
   edtRG.Enabled               := cBoxTipoJuridico.Text = PESSOA_FISICA;
   edtRGOrgaoExpedidor.Enabled := cBoxTipoJuridico.Text = PESSOA_FISICA;

   edtIdade.Text := TMyLibrary.CalculateAge(dtpDataNascimento.Date).ToString + ' anos';

   if(not Assigned(FCliente))then
     Self.NewEntitie;

   Self.FillEntitie;

   edtId.Text        := FCliente.Entitie.IdMascara;
   edtCep.Text       := FCliente.Entitie.CepMascara;
   edtIdCidade.Text  := FCliente.Entitie.CidadeMascara;
   edtTelefone.Text  := FCliente.Entitie.TelefoneMascara;
   edtTelefone2.Text := FCliente.Entitie.Telefone2Mascara;
   edtCelular.Text   := FCliente.Entitie.CelularMascara;
   edtFax.Text       := FCliente.Entitie.FaxMascara;
   edtCNPJ.Text      := FCliente.Entitie.CnpjMascara;
   edtCPF.Text       := FCliente.Entitie.CpfMascara;

   try
     FCliente.ValidarCNPJ;
   except on E: Exception do
   begin
      TMyVclLibrary.SetFocusOn(edtCNPJ);
      ShowWarning(E.Message)
   end;
   end;

   try
     FCliente.ValidarCPF;
   except on E: Exception do
   begin
      TMyVclLibrary.SetFocusOn(edtCPF);
      ShowWarning(E.Message)
   end;
   end;

   try
     FCliente.ValidarEmail;
   except on E: Exception do
   begin
      TMyVclLibrary.SetFocusOn(edtEmail);
      ShowWarning(E.Message)
   end;
   end;
end;

procedure TViewClientesCad.edtIdCidadeExit(Sender: TObject);
begin
   IdCidadeExit(edtIdCidade, edtCidade, edtUF);
end;

procedure TViewClientesCad.edtIdCidadeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   IdCidadeKeyDown(edtIdCidade, Key, Shift);
end;

end.
