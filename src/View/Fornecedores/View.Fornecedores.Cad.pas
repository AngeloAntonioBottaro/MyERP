unit View.Fornecedores.Cad;

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
  Vcl.Mask,
  Vcl.DBCtrls,
  Vcl.ComCtrls,
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
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure edtCPFExit(Sender: TObject);
    procedure edtCNPJExit(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
  private
    FFornecedor: IModelFornecedoresFactory<TModelFornecedoresEntitie>;
  public
    procedure InitialConfiguration; override;
    procedure FillFields; override;
    procedure NewEntitie; override;
  end;

var
  ViewFornecedoresCad: TViewFornecedoresCad;

implementation

{$R *.dfm}

uses
  MyMessage,
  MyExceptions,
  Utils.MyConsts,
  Utils.MyVclLibrary,
  Utils.GlobalConsts,
  Utils.LibrarySistema,
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
end;

procedure TViewFornecedoresCad.btnBuscarClick(Sender: TObject);
begin
   inherited;
   if(ViewFornecedoresBusca = nil)then Application.CreateForm(TViewFornecedoresBusca, ViewFornecedoresBusca);
   try
     ViewFornecedoresBusca.btnCadastro.Enabled := False;
     ViewFornecedoresBusca.ShowModal;
   finally
     FreeAndNil(ViewFornecedoresBusca);
   end;
   Self.FillFields;
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
end;

procedure TViewFornecedoresCad.btnGravarClick(Sender: TObject);
begin
   inherited;
   try
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
       .End_Entitie;

     Self.EndOperations;
     ShowDone('Gravação realizada');
   except on E: Exception do
     ShowInformation(E.Message);
   end;
end;

procedure TViewFornecedoresCad.btnNovoClick(Sender: TObject);
begin
   inherited;
   cBoxTipoJuridico.ItemIndex := 0;
   Self.ConfComponents(nil);
   TMyVclLibrary.SetFocusOn(edtRazaoSocial);
end;

procedure TViewFornecedoresCad.ConfComponents(Sender: TObject);
begin
   //*VARIOS
   edtCNPJ.Enabled              := cBoxTipoJuridico.Text = PESSOA_JURIDICA;
   edtIE.Enabled                := cBoxTipoJuridico.Text = PESSOA_JURIDICA;
   edtCPF.Enabled               := cBoxTipoJuridico.Text = PESSOA_FISICA;
   edtRG.Enabled                := cBoxTipoJuridico.Text = PESSOA_FISICA;
   edtRGOrgaoExpedidor.Enabled  := cBoxTipoJuridico.Text = PESSOA_FISICA;
end;

procedure TViewFornecedoresCad.edtCNPJExit(Sender: TObject);
begin
   if(not Assigned(FFornecedor))then
     Exit;

   if(FFornecedor.Entitie.Cnpj(edtCNPJ.Text).End_Entitie.ValidarCNPJ)then
     Exit;

   edtCPF.SetFocus;
   raise ExceptionInformation.Create('CNPJ inválido');
end;

procedure TViewFornecedoresCad.edtCPFExit(Sender: TObject);
begin
   if(not Assigned(FFornecedor))then
     Exit;

   if(FFornecedor.Entitie.Cpf(edtCPF.Text).End_Entitie.ValidarCPF)then
     Exit;

   edtCPF.SetFocus;
   raise ExceptionInformation.Create('CPF inválido');
end;

procedure TViewFornecedoresCad.FillFields;
begin
   if(not Assigned(FFornecedor))then
     Exit;

   edtId.Text                 := FFornecedor.Entitie.Id.ToString;
   edtRazaoSocial.Text        := FFornecedor.Entitie.RazaoSocial;
   edtNomeFantasia.Text       := FFornecedor.Entitie.NomeFantasia;
   edtEndereco.Text           := FFornecedor.Entitie.Endereco;
   edtNumero.Text             := FFornecedor.Entitie.Numero;
   edtBairro.Text             := FFornecedor.Entitie.Bairro;
   edtCep.Text                := FFornecedor.Entitie.Cep.ToString;
   edtIdCidade.Text           := FFornecedor.Entitie.Cidade.ToString;
   dtpDataNascimento.Date     := FFornecedor.Entitie.DataNascimento;
   edtTelefone.Text           := FFornecedor.Entitie.Telefone;
   edtTelefone2.Text          := FFornecedor.Entitie.Telefone2;
   edtCelular.Text            := FFornecedor.Entitie.Celular;
   edtFax.Text                := FFornecedor.Entitie.Fax;
   edtEmail.Text              := FFornecedor.Entitie.Email;
   edtCNPJ.Text               := FFornecedor.Entitie.Cnpj;
   edtIE.Text                 := FFornecedor.Entitie.IE;
   edtCPF.Text                := FFornecedor.Entitie.Cpf;
   edtRG.Text                 := FFornecedor.Entitie.RG;
   edtRGOrgaoExpedidor.Text   := FFornecedor.Entitie.RgOrgaoExpedidor;
   cBoxTipoJuridico.ItemIndex := FFornecedor.Entitie.TipoJuridicoComboBox;
end;

procedure TViewFornecedoresCad.FormCreate(Sender: TObject);
begin
   inherited;
   Self.InitialConfiguration;
end;

procedure TViewFornecedoresCad.InitialConfiguration;
begin
   edtIdCidade.ShowHint := True;
   edtIdCidade.Hint     := HINT_ATALHO_CONSULTA;

   CriarComboBoxTipoJuridico(cBoxTipoJuridico.Items);

   Self.ConfComponents(nil);
end;

procedure TViewFornecedoresCad.NewEntitie;
begin
   FFornecedor := TModelFornecedoresFactory.New;
end;

end.
