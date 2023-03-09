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
  Vcl.ComCtrls;

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
  private
    procedure InitialConfiguration;
    procedure FillFields;
  public
  end;

var
  ViewFornecedoresCad: TViewFornecedoresCad;

implementation

{$R *.dfm}

uses
  Utils.MyConsts,
  View.Fornecedores.Busca;

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

procedure TViewFornecedoresCad.btnGravarClick(Sender: TObject);
begin
   inherited;
   {FFornecedor
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
     .End_Entitie;}
end;

procedure TViewFornecedoresCad.ConfComponents(Sender: TObject);
begin
   //
end;

procedure TViewFornecedoresCad.FillFields;
begin
   {if(not Assigned(FFornecedor))then
     Exit;

   edtId.Text               := FFornecedor.Entitie.Id.ToString;
   edtRazaoSocial.Text      := FFornecedor.Entitie.RazaoSocial;
   edtNomeFantasia.Text     := FFornecedor.Entitie.NomeFantasia;
   edtEndereco.Text         := FFornecedor.Entitie.Endereco;
   edtNumero.Text           := FFornecedor.Entitie.Numero;
   edtBairro.Text           := FFornecedor.Entitie.Bairro;
   edtCep.Text              := FFornecedor.Entitie.Cep.ToString;
   edtIdCidade.Text         := FFornecedor.Entitie.Cidade.ToString;
   dtpDataNascimento.Date   := FFornecedor.Entitie.DataNascimento;
   edtTelefone.Text         := FFornecedor.Entitie.Telefone;
   edtTelefone2.Text        := FFornecedor.Entitie.Telefone2;
   edtCelular.Text          := FFornecedor.Entitie.Celular;
   edtFax.Text              := FFornecedor.Entitie.Fax;
   edtEmail.Text            := FFornecedor.Entitie.Email;
   edtCNPJ.Text             := FFornecedor.Entitie.Cnpj;
   edtIE.Text               := FFornecedor.Entitie.IE;
   edtCPF.Text              := FFornecedor.Entitie.Cpf;
   edtRG.Text               := FFornecedor.Entitie.RG;
   edtRGOrgaoExpedidor.Text := FFornecedor.Entitie.RgOrgaoExpedidor;

   cBoxTipoJuridico.ItemIndex := 0;
   if(FFornecedor.Entitie.TipoJuridico.Equals(PESSOA_JURIDICA))then
     cBoxTipoJuridico.ItemIndex := 1;}
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

   cBoxTipoJuridico.Items.Clear;
   //cBoxTipoJuridico.Items.Add(PESSOA_FISICA);
   //cBoxTipoJuridico.Items.Add(PESSOA_JURIDICA);

   Self.ConfComponents(nil);
end;

end.
