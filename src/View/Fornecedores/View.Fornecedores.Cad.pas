unit View.Fornecedores.Cad;

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
  Vcl.Mask,
  Vcl.DBCtrls,
  Vcl.ComCtrls,
  View.Base.Cadastros,
  Model.Fornecedores.Interfaces,
  Model.Fornecedores.Entitie;

type
  TViewFornecedoresCad = class(TViewBaseCadastros)
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
    lbTipoJuridico: TLabel;
    lbNomeCidade: TLabel;
    lbCNPJ: TLabel;
    lbIE: TLabel;
    lbNumero: TLabel;
    lbDataNascimento: TLabel;
    lbIdade: TLabel;
    lbCelular: TLabel;
    lbFax: TLabel;
    lbEmail: TLabel;
    lbRgOrgaoExpedidor: TLabel;
    cBoxTipoJuridico: TComboBox;
    edtId: TEdit;
    edtRazaoSocial: TEdit;
    edtNomeFantasia: TEdit;
    edtEndereco: TEdit;
    edtBairro: TEdit;
    edtNumero: TEdit;
    edtCep: TEdit;
    edtIdCidade: TEdit;
    edtCidade: TEdit;
    edtUF: TEdit;
    edtTelefone: TEdit;
    edtTelefone2: TEdit;
    dtpDataNascimento: TDateTimePicker;
    edtIdade: TEdit;
    edtCelular: TEdit;
    edtFax: TEdit;
    edtEmail: TEdit;
    edtCPF: TEdit;
    edtRG: TEdit;
    edtCNPJ: TEdit;
    edtIE: TEdit;
    edtRGOrgaoExpedidor: TEdit;
    procedure ConfComponents(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure edtIdCidadeExit(Sender: TObject);
    procedure edtIdCidadeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FFornecedor: IModelFornecedoresFactory<TModelFornecedoresEntitie>;
    procedure FillEntitie;
  public
    procedure InitialConfiguration; override;
    procedure NewEntitie; override;
    procedure FillFields; override;
    procedure OnBusca(AId: Integer); override;
  end;

var
  ViewFornecedoresCad: TViewFornecedoresCad;

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
  Model.Fornecedores.Factory,
  View.Fornecedores.Busca;

procedure TViewFornecedoresCad.btnAlterarClick(Sender: TObject);
begin
   inherited;
   if(not Assigned(FFornecedor))then
     Exit;

   if(not (FFornecedor.Entitie.Id > 0))then
     Exit;

   Self.StartOperations;
   Self.ConfComponents(nil);
end;

procedure TViewFornecedoresCad.btnBuscarClick(Sender: TObject);
begin
   inherited;
   CriarFormMsgJaAberto(TViewFornecedoresBusca, ViewFornecedoresBusca);
   try
     ViewFornecedoresBusca.btnCadastro.Enabled := False;
     ViewFornecedoresBusca.FOnBusca := Self.OnBusca;
     ViewFornecedoresBusca.ShowModal;
   finally
     FreeAndNil(ViewFornecedoresBusca);
   end;
end;

procedure TViewFornecedoresCad.btnCancelarClick(Sender: TObject);
begin
   inherited;
   Self.ConfComponents(nil);
end;

procedure TViewFornecedoresCad.btnExcluirClick(Sender: TObject);
begin
   inherited;
   if(edtId.Text = EmptyStr)then
     Exit;

   FFornecedor.Deletar;
   Self.EndOperations;
   Self.EmptyFields;
end;

procedure TViewFornecedoresCad.btnGravarClick(Sender: TObject);
begin
   inherited;
   Self.FillEntitie;
   FFornecedor.Gravar;

   Self.EndOperations;
   Self.FillFields;
   Self.ConfComponents(nil);
end;

procedure TViewFornecedoresCad.btnNovoClick(Sender: TObject);
begin
   inherited;
   dtpDataNascimento.Date := Now;
   cBoxTipoJuridico.ItemIndex := 0;
   Self.ConfComponents(nil);
   TMyVclLibrary.SetFocusOn(edtRazaoSocial);
end;

procedure TViewFornecedoresCad.FillEntitie;
begin
   FFornecedor
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

procedure TViewFornecedoresCad.FillFields;
begin
   if(not Assigned(FFornecedor))then
     Exit;

   edtId.Text                 := FFornecedor.Entitie.IdMascara;
   edtRazaoSocial.Text        := FFornecedor.Entitie.RazaoSocial;
   edtNomeFantasia.Text       := FFornecedor.Entitie.NomeFantasia;
   edtEndereco.Text           := FFornecedor.Entitie.Endereco;
   edtNumero.Text             := FFornecedor.Entitie.Numero;
   edtBairro.Text             := FFornecedor.Entitie.Bairro;
   edtCep.Text                := FFornecedor.Entitie.CepMascara;
   edtIdCidade.Text           := FFornecedor.Entitie.CidadeMascara;
   dtpDataNascimento.Date     := FFornecedor.Entitie.DataNascimento;
   edtTelefone.Text           := FFornecedor.Entitie.TelefoneMascara;
   edtTelefone2.Text          := FFornecedor.Entitie.Telefone2Mascara;
   edtCelular.Text            := FFornecedor.Entitie.CelularMascara;
   edtFax.Text                := FFornecedor.Entitie.FaxMascara;
   edtEmail.Text              := FFornecedor.Entitie.Email;
   edtCNPJ.Text               := FFornecedor.Entitie.CnpjMascara;
   edtIE.Text                 := FFornecedor.Entitie.IE;
   edtCPF.Text                := FFornecedor.Entitie.CpfMascara;
   edtRG.Text                 := FFornecedor.Entitie.RG;
   edtRGOrgaoExpedidor.Text   := FFornecedor.Entitie.RgOrgaoExpedidor;
   cBoxTipoJuridico.ItemIndex := FFornecedor.Entitie.TipoJuridicoComboBox;
end;

procedure TViewFornecedoresCad.InitialConfiguration;
begin
   dtpDataNascimento.Date := Now;
   edtIdCidade.ShowHint   := True;
   edtIdCidade.Hint       := HINT_ATALHO_CONSULTA;

   CriarComboBoxTipoJuridico(cBoxTipoJuridico.Items);
   Self.ConfComponents(nil);
end;

procedure TViewFornecedoresCad.NewEntitie;
begin
   FFornecedor := TModelFornecedoresFactory.New('Cadastro de fornecedor');
end;

procedure TViewFornecedoresCad.OnBusca(AId: Integer);
begin
   Self.NewEntitie;

   FFornecedor
    .Entitie
     .Id(AId)
     .End_Entitie
    .ConsultarEntitie;

   Self.FillFields;
   Self.ConfComponents(nil);
   edtIdCidadeExit(edtIdCidade);
end;

procedure TViewFornecedoresCad.ConfComponents(Sender: TObject);
begin
   //*VARIOS
   edtCNPJ.Enabled             := cBoxTipoJuridico.Text = PESSOA_JURIDICA;
   edtIE.Enabled               := cBoxTipoJuridico.Text = PESSOA_JURIDICA;
   edtCPF.Enabled              := cBoxTipoJuridico.Text = PESSOA_FISICA;
   edtRG.Enabled               := cBoxTipoJuridico.Text = PESSOA_FISICA;
   edtRGOrgaoExpedidor.Enabled := cBoxTipoJuridico.Text = PESSOA_FISICA;

   edtIdade.Text := TMyLibrary.CalculateAge(dtpDataNascimento.Date).ToString + ' anos';

   if(not Assigned(FFornecedor))then
     Self.NewEntitie;

   Self.FillEntitie;

   edtId.Text        := FFornecedor.Entitie.IdMascara;
   edtCep.Text       := FFornecedor.Entitie.CepMascara;
   edtIdCidade.Text  := FFornecedor.Entitie.CidadeMascara;
   edtTelefone.Text  := FFornecedor.Entitie.TelefoneMascara;
   edtTelefone2.Text := FFornecedor.Entitie.Telefone2Mascara;
   edtCelular.Text   := FFornecedor.Entitie.CelularMascara;
   edtFax.Text       := FFornecedor.Entitie.FaxMascara;
   edtCNPJ.Text      := FFornecedor.Entitie.CnpjMascara;
   edtCPF.Text       := FFornecedor.Entitie.CpfMascara;

   try
     FFornecedor.ValidarCNPJ;
   except on E: Exception do
   begin
      TMyVclLibrary.SetFocusOn(edtCNPJ);
      ShowWarning(E.Message)
   end;
   end;

   try
     FFornecedor.ValidarCPF;
   except on E: Exception do
   begin
      TMyVclLibrary.SetFocusOn(edtCPF);
      ShowWarning(E.Message)
   end;
   end;

   try
     FFornecedor.ValidarEmail;
   except on E: Exception do
   begin
      TMyVclLibrary.SetFocusOn(edtEmail);
      ShowWarning(E.Message)
   end;
   end;
end;

procedure TViewFornecedoresCad.edtIdCidadeExit(Sender: TObject);
begin
   IdCidadeExit(edtIdCidade, edtCidade, edtUF);
end;

procedure TViewFornecedoresCad.edtIdCidadeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   IdCidadeKeyDown(edtIdCidade, Key, Shift);
end;

end.
