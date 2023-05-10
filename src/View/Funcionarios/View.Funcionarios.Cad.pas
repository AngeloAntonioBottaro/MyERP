unit View.Funcionarios.Cad;

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
    lbSalario: TLabel;
    lbLogin: TLabel;
    lbSenha: TLabel;
    edtLogin: TEdit;
    edtSenha: TEdit;
    edtSalario: TEdit;
    lbCodPermissao: TLabel;
    lbPermissao: TLabel;
    edtIdGrupoPermissao: TEdit;
    edtGrupoPermissao: TEdit;
    procedure ConfComponents(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure edtIdCidadeExit(Sender: TObject);
    procedure edtIdCidadeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtIdFuncaoExit(Sender: TObject);
    procedure edtIdFuncaoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtIdGrupoPermissaoExit(Sender: TObject);
    procedure edtIdGrupoPermissaoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FFuncionario: IModelFuncionariosFactory<TModelFuncionariosEntitie>;
    procedure FillEntitie;
  public
    procedure InitialConfiguration; override;
    procedure NewEntitie; override;
    procedure FillFields; override;
    procedure OnBusca(AId: Integer); override;
  end;

var
  ViewFuncionariosCad: TViewFuncionariosCad;

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
   Self.ConfComponents(nil);
end;

procedure TViewFuncionariosCad.btnBuscarClick(Sender: TObject);
begin
   inherited;
   CriarFormMsgJaAberto(TViewFuncionariosBusca, ViewFuncionariosBusca);
   try
     ViewFuncionariosBusca.btnCadastro.Enabled := False;
     ViewFuncionariosBusca.FOnBusca := Self.OnBusca;
     ViewFuncionariosBusca.ShowModal;
   finally
     FreeAndNil(ViewFuncionariosBusca);
   end;
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

   FFuncionario.Deletar;
   Self.EndOperations;
   Self.EmptyFields;
end;

procedure TViewFuncionariosCad.btnGravarClick(Sender: TObject);
begin
   inherited;
   Self.FillEntitie;
   FFuncionario.Gravar;

   Self.EndOperations;
   Self.FillFields;
   Self.ConfComponents(nil);
end;

procedure TViewFuncionariosCad.btnNovoClick(Sender: TObject);
begin
   inherited;
   dtpDataNascimento.Date := Now;
   cBoxTipoJuridico.ItemIndex := 0;
   Self.ConfComponents(nil);
   TMyVclLibrary.SetFocusOn(edtRazaoSocial);
end;

procedure TViewFuncionariosCad.FillEntitie;
begin
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
     .GrupoPermissao(edtIdGrupoPermissao.Text)
     .Login(edtLogin.Text)
     .Senha(edtSenha.Text)
     .Salario(edtSalario.Text)
     .End_Entitie;
end;

procedure TViewFuncionariosCad.FillFields;
begin
   if(not Assigned(FFuncionario))then
     Exit;

   edtId.Text                 := FFuncionario.Entitie.IdMascara;
   edtRazaoSocial.Text        := FFuncionario.Entitie.RazaoSocial;
   edtNomeFantasia.Text       := FFuncionario.Entitie.NomeFantasia;
   edtEndereco.Text           := FFuncionario.Entitie.Endereco;
   edtNumero.Text             := FFuncionario.Entitie.Numero;
   edtBairro.Text             := FFuncionario.Entitie.Bairro;
   edtCep.Text                := FFuncionario.Entitie.CepMascara;
   edtIdCidade.Text           := FFuncionario.Entitie.CidadeMascara;
   dtpDataNascimento.Date     := FFuncionario.Entitie.DataNascimento;
   edtTelefone.Text           := FFuncionario.Entitie.TelefoneMascara;
   edtTelefone2.Text          := FFuncionario.Entitie.Telefone2Mascara;
   edtCelular.Text            := FFuncionario.Entitie.CelularMascara;
   edtFax.Text                := FFuncionario.Entitie.FaxMascara;
   edtEmail.Text              := FFuncionario.Entitie.Email;
   edtCNPJ.Text               := FFuncionario.Entitie.CnpjMascara;
   edtIE.Text                 := FFuncionario.Entitie.IE;
   edtCPF.Text                := FFuncionario.Entitie.CpfMascara;
   edtRG.Text                 := FFuncionario.Entitie.RG;
   edtRGOrgaoExpedidor.Text   := FFuncionario.Entitie.RgOrgaoExpedidor;
   cBoxTipoJuridico.ItemIndex := FFuncionario.Entitie.TipoJuridicoComboBox;
   edtIdFuncao.Text           := FFuncionario.Entitie.FuncaoMascara;
   edtIdGrupoPermissao.Text   := FFuncionario.Entitie.GrupoPermissaoMascara;
   edtLogin.Text              := FFuncionario.Entitie.Login;
   edtSenha.Text              := FFuncionario.Entitie.Senha;
   edtSalario.Text            := FFuncionario.Entitie.Salario.ToString;
end;

procedure TViewFuncionariosCad.InitialConfiguration;
begin
   dtpDataNascimento.Date       := Now;
   edtIdCidade.ShowHint         := True;
   edtIdCidade.Hint             := HINT_ATALHO_CONSULTA;
   edtIdFuncao.ShowHint         := True;
   edtIdFuncao.Hint             := HINT_ATALHO_CONSULTA;
   edtIdGrupoPermissao.ShowHint := True;
   edtIdGrupoPermissao.Hint     := HINT_ATALHO_CONSULTA;

   CriarComboBoxTipoJuridico(cBoxTipoJuridico.Items);
   Self.ConfComponents(nil);
end;

procedure TViewFuncionariosCad.NewEntitie;
begin
   FFuncionario := TModelFuncionariosFactory.New('Cadastro de funcionários');
end;

procedure TViewFuncionariosCad.OnBusca(AId: Integer);
begin
   Self.NewEntitie;

   FFuncionario
    .Entitie
     .Id(AId)
     .End_Entitie
    .ConsultarEntitie;

   Self.FillFields;
   Self.ConfComponents(nil);
   edtIdCidadeExit(edtIdCidade);
   edtIdFuncaoExit(edtIdFuncao);
   edtIdGrupoPermissaoExit(edtIdGrupoPermissao);
end;

procedure TViewFuncionariosCad.ConfComponents(Sender: TObject);
begin
   //*VARIOS
   edtCNPJ.Enabled             := cBoxTipoJuridico.Text = PESSOA_JURIDICA;
   edtIE.Enabled               := cBoxTipoJuridico.Text = PESSOA_JURIDICA;
   edtCPF.Enabled              := cBoxTipoJuridico.Text = PESSOA_FISICA;
   edtRG.Enabled               := cBoxTipoJuridico.Text = PESSOA_FISICA;
   edtRGOrgaoExpedidor.Enabled := cBoxTipoJuridico.Text = PESSOA_FISICA;

   edtIdade.Text := TMyLibrary.CalculateAge(dtpDataNascimento.Date).ToString + ' anos';

   if(not Assigned(FFuncionario))then
     Self.NewEntitie;

   Self.FillEntitie;

   edtId.Text        := FFuncionario.Entitie.IdMascara;
   edtCep.Text       := FFuncionario.Entitie.CepMascara;
   edtIdCidade.Text  := FFuncionario.Entitie.CidadeMascara;
   edtTelefone.Text  := FFuncionario.Entitie.TelefoneMascara;
   edtTelefone2.Text := FFuncionario.Entitie.Telefone2Mascara;
   edtCelular.Text   := FFuncionario.Entitie.CelularMascara;
   edtFax.Text       := FFuncionario.Entitie.FaxMascara;
   edtCNPJ.Text      := FFuncionario.Entitie.CnpjMascara;
   edtCPF.Text       := FFuncionario.Entitie.CpfMascara;

   try
     FFuncionario.ValidarCNPJ;
   except on E: Exception do
   begin
      TMyVclLibrary.SetFocusOn(edtCNPJ);
      ShowWarning(E.Message)
   end;
   end;

   try
     FFuncionario.ValidarCPF;
   except on E: Exception do
   begin
      TMyVclLibrary.SetFocusOn(edtCPF);
      ShowWarning(E.Message)
   end;
   end;

   try
     FFuncionario.ValidarEmail;
   except on E: Exception do
   begin
      TMyVclLibrary.SetFocusOn(edtEmail);
      ShowWarning(E.Message)
   end;
   end;
end;

procedure TViewFuncionariosCad.edtIdCidadeExit(Sender: TObject);
begin
   IdCidadeExit(edtIdCidade, edtCidade, edtUF);
end;

procedure TViewFuncionariosCad.edtIdCidadeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   IdCidadeKeyDown(edtIdCidade, Key, Shift);
end;

procedure TViewFuncionariosCad.edtIdFuncaoExit(Sender: TObject);
begin
   IdFuncaoFuncionarioExit(edtIdFuncao, edtFuncao);
end;

procedure TViewFuncionariosCad.edtIdFuncaoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   IdFuncaoFuncionarioKeyDown(edtIdFuncao, Key, Shift);
end;

procedure TViewFuncionariosCad.edtIdGrupoPermissaoExit(Sender: TObject);
begin
   IdPermissoesGrupoExit(edtIdGrupoPermissao, edtGrupoPermissao);
end;

procedure TViewFuncionariosCad.edtIdGrupoPermissaoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   IdPermissoesGrupoKeyDown(edtIdGrupoPermissao, Key, Shift);
end;

end.
