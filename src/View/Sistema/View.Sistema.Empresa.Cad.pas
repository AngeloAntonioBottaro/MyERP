unit View.Sistema.Empresa.Cad;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.UITypes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.ComCtrls,
  View.Base.Cadastros,
  Model.Empresas.Interfaces,
  Model.Empresas.Entitie;

type
  TViewSistemaEmpresaCad = class(TViewBaseCadastros)
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
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtIdCidadeExit(Sender: TObject);
    procedure edtIdCidadeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FEmpresa: IModelEmpresasFactory<TModelEmpresasEntitie>;
    procedure FillEntitie;
    function DadosIniciais: Boolean;
  public
    procedure InitialConfiguration; override;
    procedure NewEntitie; override;
    procedure FillFields; override;
    procedure OnBusca(AId: Integer); override;
  end;

var
  ViewSistemaEmpresaCad: TViewSistemaEmpresaCad;

implementation

{$R *.dfm}

uses
  MyMessage,
  Common.Utils.MyConsts,
  Common.Utils.MyLibrary,
  Common.Utils.MyVclLibrary,
  Utils.GlobalConsts,
  Utils.GlobalVariables,
  Utils.LibrarySistema,
  Utils.EditsKeyDownExit,
  Model.Empresas.Factory,
  View.Sistema.SenhaAdm;

procedure TViewSistemaEmpresaCad.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   inherited;
   GetEmpresaLogada.ConsultarEntitie;
   if(Self.DadosIniciais)then
   begin
      if(ShowQuestionYes('Não informado os dados de uma empresa válida. Deseja informálos?'))then
        Abort;

      Self.SystemTerminate;
      Abort;
   end;
end;

procedure TViewSistemaEmpresaCad.FormShow(Sender: TObject);
begin
   inherited;
   Self.OnBusca(0);

   if(Self.DadosIniciais)then
     btnAlterar.Click;
end;

procedure TViewSistemaEmpresaCad.btnAlterarClick(Sender: TObject);
begin
   inherited;
   if(not Assigned(FEmpresa))then
     Exit;

   if(not (FEmpresa.Entitie.Id > 0))then
     Exit;

   if(not ChamaSenhaAdministrativa)then
     Exit;

   Self.StartOperations;
   Self.ConfComponents(nil);
end;

procedure TViewSistemaEmpresaCad.btnCancelarClick(Sender: TObject);
begin
   inherited;
   Self.OnBusca(0);
   Self.ConfComponents(nil);
end;

procedure TViewSistemaEmpresaCad.btnGravarClick(Sender: TObject);
begin
   inherited;
   Self.FillEntitie;
   FEmpresa.Gravar;

   Self.EndOperations;
   if(Trim(edtId.Text).IsEmpty)then
     Self.EmptyFields;
end;

procedure TViewSistemaEmpresaCad.FillEntitie;
begin
   FEmpresa
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

procedure TViewSistemaEmpresaCad.FillFields;
begin
   if(not Assigned(FEmpresa))then
     Exit;

   edtId.Text                 := FEmpresa.Entitie.IdMascara;
   edtRazaoSocial.Text        := FEmpresa.Entitie.RazaoSocial;
   edtNomeFantasia.Text       := FEmpresa.Entitie.NomeFantasia;
   edtEndereco.Text           := FEmpresa.Entitie.Endereco;
   edtNumero.Text             := FEmpresa.Entitie.Numero;
   edtBairro.Text             := FEmpresa.Entitie.Bairro;
   edtCep.Text                := FEmpresa.Entitie.CepMascara;
   edtIdCidade.Text           := FEmpresa.Entitie.CidadeMascara;
   dtpDataNascimento.Date     := FEmpresa.Entitie.DataNascimento;
   edtTelefone.Text           := FEmpresa.Entitie.TelefoneMascara;
   edtTelefone2.Text          := FEmpresa.Entitie.Telefone2Mascara;
   edtCelular.Text            := FEmpresa.Entitie.CelularMascara;
   edtFax.Text                := FEmpresa.Entitie.FaxMascara;
   edtEmail.Text              := FEmpresa.Entitie.Email;
   edtCNPJ.Text               := FEmpresa.Entitie.CnpjMascara;
   edtIE.Text                 := FEmpresa.Entitie.IE;
   edtCPF.Text                := FEmpresa.Entitie.CpfMascara;
   edtRG.Text                 := FEmpresa.Entitie.RG;
   edtRGOrgaoExpedidor.Text   := FEmpresa.Entitie.RgOrgaoExpedidor;
   cBoxTipoJuridico.ItemIndex := FEmpresa.Entitie.TipoJuridicoComboBox;
end;

procedure TViewSistemaEmpresaCad.InitialConfiguration;
begin
   dtpDataNascimento.Date := Now;
   edtIdCidade.ShowHint   := True;
   edtIdCidade.Hint       := HINT_ATALHO_CONSULTA;

   CriarComboBoxTipoJuridico(cBoxTipoJuridico.Items);
   Self.ConfComponents(nil);
end;

procedure TViewSistemaEmpresaCad.NewEntitie;
begin
   FEmpresa := TModelEmpresasFactory.New('Cadastro de empresa');
end;

procedure TViewSistemaEmpresaCad.OnBusca(AId: Integer);
begin
   Self.NewEntitie;

   FEmpresa.ConsultarEntitie;

   Self.FillFields;
   Self.ConfComponents(nil);
   edtIdCidadeExit(edtIdCidade);
end;

procedure TViewSistemaEmpresaCad.ConfComponents(Sender: TObject);
begin
   //*VARIOS
   edtCNPJ.Enabled             := cBoxTipoJuridico.Text = PESSOA_JURIDICA;
   edtIE.Enabled               := cBoxTipoJuridico.Text = PESSOA_JURIDICA;
   edtCPF.Enabled              := cBoxTipoJuridico.Text = PESSOA_FISICA;
   edtRG.Enabled               := cBoxTipoJuridico.Text = PESSOA_FISICA;
   edtRGOrgaoExpedidor.Enabled := cBoxTipoJuridico.Text = PESSOA_FISICA;

   edtIdade.Text := TMyLibrary.CalculateAge(dtpDataNascimento.Date).ToString + ' anos';

   lbCNPJ.Font.Style := lbCNPJ.Font.Style - [fsBold];
   if(edtCNPJ.Enabled)then
     lbCNPJ.Font.Style := lbCNPJ.Font.Style + [fsBold];

   lbCPF.Font.Style := lbCPF.Font.Style - [fsBold];
   if(edtCPF.Enabled)then
     lbCPF.Font.Style := lbCPF.Font.Style + [fsBold];

   if(not Assigned(FEmpresa))then
     Self.NewEntitie;

   Self.FillEntitie;

   edtId.Text        := FEmpresa.Entitie.IdMascara;
   edtCep.Text       := FEmpresa.Entitie.CepMascara;
   edtIdCidade.Text  := FEmpresa.Entitie.CidadeMascara;
   edtTelefone.Text  := FEmpresa.Entitie.TelefoneMascara;
   edtTelefone2.Text := FEmpresa.Entitie.Telefone2Mascara;
   edtCelular.Text   := FEmpresa.Entitie.CelularMascara;
   edtFax.Text       := FEmpresa.Entitie.FaxMascara;
   edtCNPJ.Text      := FEmpresa.Entitie.CnpjMascara;
   edtCPF.Text       := FEmpresa.Entitie.CpfMascara;

   try
     FEmpresa.ValidarCNPJ;
   except on E: Exception do
   begin
      TMyVclLibrary.SetFocusOn(edtCNPJ);
      ShowWarning(E.Message)
   end;
   end;

   try
     FEmpresa.ValidarCPF;
   except on E: Exception do
   begin
      TMyVclLibrary.SetFocusOn(edtCPF);
      ShowWarning(E.Message)
   end;
   end;

   try
     FEmpresa.ValidarEmail;
   except on E: Exception do
   begin
      TMyVclLibrary.SetFocusOn(edtEmail);
      ShowWarning(E.Message)
   end;
   end;
end;

function TViewSistemaEmpresaCad.DadosIniciais: Boolean;
begin
   if(TMyLibrary.UnlockSpecialComands)then
    Exit(False);

   Result := GetEmpresaLogada.Entitie.Cnpj().IsEmpty and GetEmpresaLogada.Entitie.Cpf().IsEmpty;
end;

procedure TViewSistemaEmpresaCad.edtIdCidadeExit(Sender: TObject);
begin
   IdCidadeExit(edtIdCidade, edtCidade, edtUF);
end;

procedure TViewSistemaEmpresaCad.edtIdCidadeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   IdCidadeKeyDown(edtIdCidade, Key, Shift);
end;

end.
