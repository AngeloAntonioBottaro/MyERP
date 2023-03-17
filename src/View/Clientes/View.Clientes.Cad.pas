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
    procedure edtCNPJExit(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
  private
    FCliente: IModelClientesFactory<TModelClientesEntitie>;
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
  MyConnection,
  MyMessage,
  MyExceptions,
  Utils.MyConsts,
  Utils.MyLibrary,
  Utils.MyVclLibrary,
  Utils.GlobalConsts,
  Utils.LibrarySistema,
  Model.Clientes.Factory,
  View.Clientes.Busca;

procedure TViewClientesCad.FormCreate(Sender: TObject);
begin
   inherited;
   Self.InitialConfiguration;
end;

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
   if(ViewClientesBusca = nil)then Application.CreateForm(TViewClientesBusca, ViewClientesBusca);

   if(ViewClientesBusca.Showing)then
     raise ExceptionInformation.Create(MSG_TELA_JA_ABERTA);

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
     .End_Entitie
    .Gravar;

   Self.EndOperations;
   if(Trim(edtId.Text).IsEmpty)then
     Self.EmptyFields;

   ShowDone('Gravação realizada');
end;

procedure TViewClientesCad.btnNovoClick(Sender: TObject);
begin
   inherited;
   cBoxTipoJuridico.ItemIndex := 0;
   Self.ConfComponents(nil);
   TMyVclLibrary.SetFocusOn(edtRazaoSocial);
end;

procedure TViewClientesCad.edtCNPJExit(Sender: TObject);
begin
   if(not Assigned(FCliente))then
     Exit;

   try
     FCliente.Entitie.Cpf(edtCNPJ.Text).End_Entitie.ValidarCNPJ;
   except on E: Exception do
   begin
      TMyVclLibrary.SetFocusOn(edtCNPJ);
      ShowWarning(E.Message)
   end;
   end;
end;

procedure TViewClientesCad.edtCPFExit(Sender: TObject);
begin
   if(not Assigned(FCliente))then
     Exit;

   try
     FCliente.Entitie.Cpf(edtCPF.Text).End_Entitie.ValidarCPF;
   except on E: Exception do
   begin
      TMyVclLibrary.SetFocusOn(edtCPF);
      ShowWarning(E.Message)
   end;
   end;
end;

procedure TViewClientesCad.FillFields;
begin
   if(not Assigned(FCliente))then
     Exit;

   edtId.Text                 := FCliente.Entitie.Id.ToString;
   edtRazaoSocial.Text        := FCliente.Entitie.RazaoSocial;
   edtNomeFantasia.Text       := FCliente.Entitie.NomeFantasia;
   edtEndereco.Text           := FCliente.Entitie.Endereco;
   edtNumero.Text             := FCliente.Entitie.Numero;
   edtBairro.Text             := FCliente.Entitie.Bairro;
   edtCep.Text                := FCliente.Entitie.Cep;
   edtIdCidade.Text           := FCliente.Entitie.Cidade.ToString;
   dtpDataNascimento.Date     := FCliente.Entitie.DataNascimento;
   edtTelefone.Text           := FCliente.Entitie.Telefone;
   edtTelefone2.Text          := FCliente.Entitie.Telefone2;
   edtCelular.Text            := FCliente.Entitie.Celular;
   edtFax.Text                := FCliente.Entitie.Fax;
   edtEmail.Text              := FCliente.Entitie.Email;
   edtCNPJ.Text               := FCliente.Entitie.Cnpj;
   edtIE.Text                 := FCliente.Entitie.IE;
   edtCPF.Text                := FCliente.Entitie.Cpf;
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
   FCliente := TModelClientesFactory.New;
end;

procedure TViewClientesCad.OnBusca(AId: Integer);
begin
   Self.NewEntitie;

   MyQueryNew
    .Add('SELECT * FROM CLIENTES WHERE(CLIENTES.ID = :ID)')
    .AddParam('ID', AId)
    .Open;

   FCliente
      .Entitie
       .Id(MyQuery.FieldByName('ID').AsString)
       .RazaoSocial(MyQuery.FieldByName('RAZAO_SOCIAL').AsString)
       .NomeFantasia(MyQuery.FieldByName('NOME_FANTASIA').AsString)
       .Endereco(MyQuery.FieldByName('ENDERECO').AsString)
       .Numero(MyQuery.FieldByName('NUMERO').AsString)
       .Bairro(MyQuery.FieldByName('BAIRRO').AsString)
       .Cep(MyQuery.FieldByName('CEP').AsString)
       .Cidade(MyQuery.FieldByName('CIDADE').AsString)
       .DataNascimento(MyQuery.FieldByName('DATA_NASCIMENTO').AsDateTime)
       .Telefone(MyQuery.FieldByName('TELEFONE').AsString)
       .Telefone2(MyQuery.FieldByName('TELEFONE2').AsString)
       .Celular(MyQuery.FieldByName('CELULAR').AsString)
       .Fax(MyQuery.FieldByName('FAX').AsString)
       .Email(MyQuery.FieldByName('EMAIL').AsString)
       .TipoJuridico(MyQuery.FieldByName('TIPO_JURIDICO').AsString)
       .Cnpj(MyQuery.FieldByName('CNPJ').AsString)
       .IE(MyQuery.FieldByName('INSCRICAO_ESTADUAL').AsString)
       .Cpf(MyQuery.FieldByName('CPF').AsString)
       .RG(MyQuery.FieldByName('RG').AsString)
       .RgOrgaoExpedidor(MyQuery.FieldByName('RG_ORGAO_EXPEDIDOR').AsString)
       .End_Entitie;

   Self.FillFields;
   Self.ConfComponents(nil);
end;

procedure TViewClientesCad.ConfComponents(Sender: TObject);
begin
   //*VARIOS
   edtCNPJ.Enabled              := cBoxTipoJuridico.Text = PESSOA_JURIDICA;
   edtIE.Enabled                := cBoxTipoJuridico.Text = PESSOA_JURIDICA;
   edtCPF.Enabled               := cBoxTipoJuridico.Text = PESSOA_FISICA;
   edtRG.Enabled                := cBoxTipoJuridico.Text = PESSOA_FISICA;
   edtRGOrgaoExpedidor.Enabled  := cBoxTipoJuridico.Text = PESSOA_FISICA;

   edtIdade.Text := TMyLibrary.CalculateAge(dtpDataNascimento.Date).ToString + ' anos';
end;

end.
