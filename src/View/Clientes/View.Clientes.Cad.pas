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
    Label1: TLabel;
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
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtCPFExit(Sender: TObject);
  private
    FCliente: IModelClientesFactory<TModelClientesEntitie>;
    procedure InitialConfiguration;
    procedure NewClient;
  public
  end;

var
  ViewClientesCad: TViewClientesCad;

implementation

{$R *.dfm}

uses
  MyExceptions,
  Utils.GlobalConsts,
  Utils.MyVclLibrary,
  Model.Clientes.Factory;

procedure TViewClientesCad.btnGravarClick(Sender: TObject);
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
     //.cidade
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
   Self.NewClient;
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

procedure TViewClientesCad.FormCreate(Sender: TObject);
begin
   inherited;
   Self.InitialConfiguration;
   Self.NewClient;
end;

procedure TViewClientesCad.InitialConfiguration;
begin
   edtIdCidade.ShowHint := True;
   edtIdCidade.Hint     := HINT_ATALHO_CONSULTA;
end;

procedure TViewClientesCad.NewClient;
begin
   FCliente := TModelClientesFactory.New;
end;

end.
