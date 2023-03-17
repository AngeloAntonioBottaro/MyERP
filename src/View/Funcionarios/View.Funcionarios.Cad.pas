unit View.Funcionarios.Cad;

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
  Model.Funcionarios.Interfaces,
  Model.Funcionarios.Entitie;

type
  TViewFuncionariosCad = class(TViewBaseCadastros)
    pnTela: TPanel;
    lbIdFuncao: TLabel;
    edtIdFuncao: TEdit;
    edtFuncao: TEdit;
    lbFuncao: TLabel;
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
    edtSalario: TEdit;
    lbSalario: TLabel;
    lbLogin: TLabel;
    lbSenha: TLabel;
    edtLogin: TEdit;
    edtSenha: TEdit;
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
    FFuncionario: IModelFuncionariosFactory<TModelFuncionariosEntitie>;
  public
    procedure InitialConfiguration; override;
    procedure FillFields; override;
    procedure NewEntitie; override;
  end;

var
  ViewFuncionariosCad: TViewFuncionariosCad;

implementation

{$R *.dfm}

uses
  MyMessage,
  MyExceptions,
  Utils.MyConsts,
  Utils.MyVclLibrary,
  Utils.GlobalConsts,
  Utils.LibrarySistema,
  Model.Funcionarios.Factory,
  View.Funcionarios.Busca;

procedure TViewFuncionariosCad.btnAlterarClick(Sender: TObject);
begin
   inherited;
   if(not Assigned(FFuncionario))then
     Exit;

   if(not (FFuncionario.Entitie.Id > 0))then
     Exit;

   Self.StartOperations;
end;

procedure TViewFuncionariosCad.btnBuscarClick(Sender: TObject);
begin
   inherited;
   if(ViewFuncionariosBusca = nil)then Application.CreateForm(TViewFuncionariosBusca, ViewFuncionariosBusca);
   try
     ViewFuncionariosBusca.btnCadastro.Enabled := False;
     ViewFuncionariosBusca.ShowModal;
   finally
     FreeAndNil(ViewFuncionariosBusca);
   end;
   Self.FillFields;
end;

procedure TViewFuncionariosCad.btnCancelarClick(Sender: TObject);
begin
   inherited;
   Self.ConfComponents(nil);
end;

procedure TViewFuncionariosCad.btnExcluirClick(Sender: TObject);
begin
   inherited;
   if(edtId.Text = EmptyStr)then
     Exit;
end;

procedure TViewFuncionariosCad.btnGravarClick(Sender: TObject);
begin
   inherited;
   try
     FFuncionario
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
       .Funcao(edtIdFuncao.Text)
       .Salario(edtSalario.Text)
       .Login(edtLogin.Text)
       .Senha(edtSenha.Text)
       .End_Entitie;

     Self.EndOperations;
     ShowDone('Gravação realizada');
   except on E: Exception do
     ShowInformation(E.Message);
   end;
end;

procedure TViewFuncionariosCad.btnNovoClick(Sender: TObject);
begin
   inherited;
   cBoxTipoJuridico.ItemIndex := 0;
   Self.ConfComponents(nil);
   TMyVclLibrary.SetFocusOn(edtRazaoSocial);
end;

procedure TViewFuncionariosCad.ConfComponents(Sender: TObject);
begin
   //*VARIOS
   edtCNPJ.Enabled              := cBoxTipoJuridico.Text = PESSOA_JURIDICA;
   edtIE.Enabled                := cBoxTipoJuridico.Text = PESSOA_JURIDICA;
   edtCPF.Enabled               := cBoxTipoJuridico.Text = PESSOA_FISICA;
   edtRG.Enabled                := cBoxTipoJuridico.Text = PESSOA_FISICA;
   edtRGOrgaoExpedidor.Enabled  := cBoxTipoJuridico.Text = PESSOA_FISICA;
end;

procedure TViewFuncionariosCad.edtCNPJExit(Sender: TObject);
begin
   if(not Assigned(FFuncionario))then
     Exit;

   if(FFuncionario.Entitie.Cnpj(edtCNPJ.Text).End_Entitie.ValidarCNPJ)then
     Exit;

   edtCPF.SetFocus;
   raise ExceptionInformation.Create('CNPJ inválido');
end;

procedure TViewFuncionariosCad.edtCPFExit(Sender: TObject);
begin
   if(not Assigned(FFuncionario))then
     Exit;

   if(FFuncionario.Entitie.Cpf(edtCPF.Text).End_Entitie.ValidarCPF)then
     Exit;

   edtCPF.SetFocus;
   raise ExceptionInformation.Create('CPF inválido');
end;

procedure TViewFuncionariosCad.FillFields;
begin
   if(not Assigned(FFuncionario))then
     Exit;

   edtId.Text                 := FFuncionario.Entitie.Id.ToString;
   edtRazaoSocial.Text        := FFuncionario.Entitie.RazaoSocial;
   edtNomeFantasia.Text       := FFuncionario.Entitie.NomeFantasia;
   edtEndereco.Text           := FFuncionario.Entitie.Endereco;
   edtNumero.Text             := FFuncionario.Entitie.Numero;
   edtBairro.Text             := FFuncionario.Entitie.Bairro;
   edtCep.Text                := FFuncionario.Entitie.Cep;
   edtIdCidade.Text           := FFuncionario.Entitie.Cidade.ToString;
   dtpDataNascimento.Date     := FFuncionario.Entitie.DataNascimento;
   edtTelefone.Text           := FFuncionario.Entitie.Telefone;
   edtTelefone2.Text          := FFuncionario.Entitie.Telefone2;
   edtCelular.Text            := FFuncionario.Entitie.Celular;
   edtFax.Text                := FFuncionario.Entitie.Fax;
   edtEmail.Text              := FFuncionario.Entitie.Email;
   edtCNPJ.Text               := FFuncionario.Entitie.Cnpj;
   edtIE.Text                 := FFuncionario.Entitie.IE;
   edtCPF.Text                := FFuncionario.Entitie.Cpf;
   edtRG.Text                 := FFuncionario.Entitie.RG;
   edtRGOrgaoExpedidor.Text   := FFuncionario.Entitie.RgOrgaoExpedidor;
   edtIdFuncao.Text           := FFuncionario.Entitie.Funcao.ToString;
   edtSalario.Text            := FFuncionario.Entitie.Salario.ToString;
   edtLogin.Text              := FFuncionario.Entitie.Login;
   edtSenha.Text              := FFuncionario.Entitie.Senha;
   cBoxTipoJuridico.ItemIndex := FFuncionario.Entitie.TipoJuridicoComboBox;
end;

procedure TViewFuncionariosCad.FormCreate(Sender: TObject);
begin
   inherited;
   Self.InitialConfiguration;
end;

procedure TViewFuncionariosCad.InitialConfiguration;
begin
   edtIdCidade.ShowHint := True;
   edtIdCidade.Hint     := HINT_ATALHO_CONSULTA;
   edtIdFuncao.ShowHint := True;
   edtIdFuncao.Hint     := HINT_ATALHO_CONSULTA;

   CriarComboBoxTipoJuridico(cBoxTipoJuridico.Items);

   Self.ConfComponents(nil);
end;

procedure TViewFuncionariosCad.NewEntitie;
begin
   FFuncionario := TModelFuncionariosFactory.New;
end;

end.
