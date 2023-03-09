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
  Vcl.ComCtrls;

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
    procedure ConfComponents(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
  private
    procedure InitialConfiguration;
    procedure FillFields;
  public
  end;

var
  ViewFuncionariosCad: TViewFuncionariosCad;

implementation

{$R *.dfm}

uses
  Utils.MyConsts,
  View.Funcionarios.Busca;

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

procedure TViewFuncionariosCad.btnGravarClick(Sender: TObject);
begin
   inherited;
   {FFuncionario
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
     .End_Entitie;}
end;

procedure TViewFuncionariosCad.ConfComponents(Sender: TObject);
begin
   //
end;

procedure TViewFuncionariosCad.FillFields;
begin
   {if(not Assigned(FFuncionario))then
     Exit;

   edtId.Text               := FFuncionario.Entitie.Id.ToString;
   edtRazaoSocial.Text      := FFuncionario.Entitie.RazaoSocial;
   edtNomeFantasia.Text     := FFuncionario.Entitie.NomeFantasia;
   edtEndereco.Text         := FFuncionario.Entitie.Endereco;
   edtNumero.Text           := FFuncionario.Entitie.Numero;
   edtBairro.Text           := FFuncionario.Entitie.Bairro;
   edtCep.Text              := FFuncionario.Entitie.Cep.ToString;
   edtIdCidade.Text         := FFuncionario.Entitie.Cidade.ToString;
   dtpDataNascimento.Date   := FFuncionario.Entitie.DataNascimento;
   edtTelefone.Text         := FFuncionario.Entitie.Telefone;
   edtTelefone2.Text        := FFuncionario.Entitie.Telefone2;
   edtCelular.Text          := FFuncionario.Entitie.Celular;
   edtFax.Text              := FFuncionario.Entitie.Fax;
   edtEmail.Text            := FFuncionario.Entitie.Email;
   edtCNPJ.Text             := FFuncionario.Entitie.Cnpj;
   edtIE.Text               := FFuncionario.Entitie.IE;
   edtCPF.Text              := FFuncionario.Entitie.Cpf;
   edtRG.Text               := FFuncionario.Entitie.RG;
   edtRGOrgaoExpedidor.Text := FFuncionario.Entitie.RgOrgaoExpedidor;
   edtIdFuncao.Text         := FFuncionario.Entitie.Funcao.ToString;
   edtSalario.Text          := FFuncionario.Entitie.Salario.ToString;

   cBoxTipoJuridico.ItemIndex := 0;
   if(FFuncionario.Entitie.TipoJuridico.Equals(PESSOA_JURIDICA))then
     cBoxTipoJuridico.ItemIndex := 1;}
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

   cBoxTipoJuridico.Items.Clear;
   //cBoxTipoJuridico.Items.Add(PESSOA_FISICA);
   //cBoxTipoJuridico.Items.Add(PESSOA_JURIDICA);

   Self.ConfComponents(nil);
end;

end.
