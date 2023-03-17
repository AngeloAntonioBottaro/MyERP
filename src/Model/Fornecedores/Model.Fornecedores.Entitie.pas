unit Model.Fornecedores.Entitie;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Model.Fornecedores.Interfaces;

type
  TModelFornecedoresEntitie = class
  private
    [weak]
    FParent: IModelFornecedoresFactory<TModelFornecedoresEntitie>;

    FBairro: string;
    FCelular: string;
    FCep: string;
    FCidade: Integer;
    FCnpj: string;
    FCpf: string;
    FDataCadastro: TDateTime;
    FDataNascimento: TDateTime;
    FEmail: string;
    FEndereco: string;
    FFax: string;
    FId: Integer;
    FIE: string;
    FNomeFantasia: string;
    FNumero: string;
    FRazaoSocial: string;
    FRG: string;
    FRgOrgaoExpedidor: string;
    FStatusCliente: string;
    FTelefone: string;
    FTelefone2: string;
    FTipoJuridico: string;
  public
    constructor Create(AParent: IModelFornecedoresFactory<TModelFornecedoresEntitie>);
    destructor Destroy; override;
    function End_Entitie: IModelFornecedoresFactory<TModelFornecedoresEntitie>;

    function Bairro(AValue: string): TModelFornecedoresEntitie; overload;
    function Bairro: string; overload;
    function Celular(AValue: string): TModelFornecedoresEntitie; overload;
    function Celular: string; overload;
    function Cep(AValue: string): TModelFornecedoresEntitie; overload;
    function Cep: string; overload;
    function Cidade(AValue: string): TModelFornecedoresEntitie; overload;
    function Cidade(AValue: Integer): TModelFornecedoresEntitie; overload;
    function Cidade: Integer; overload;
    function Cnpj(AValue: string): TModelFornecedoresEntitie; overload;
    function Cnpj: string; overload;
    function Cpf(AValue: string): TModelFornecedoresEntitie; overload;
    function Cpf: string; overload;
    function DataCadastro(AValue: string): TModelFornecedoresEntitie; overload;
    function DataCadastro(AValue: TDateTime): TModelFornecedoresEntitie; overload;
    function DataCadastro: TDateTime; overload;
    function DataNascimento(AValue: string): TModelFornecedoresEntitie; overload;
    function DataNascimento(AValue: TDateTime): TModelFornecedoresEntitie; overload;
    function DataNascimento: TDateTime; overload;
    function Email(AValue: string): TModelFornecedoresEntitie; overload;
    function Email: string; overload;
    function Endereco(AValue: string): TModelFornecedoresEntitie; overload;
    function Endereco: string; overload;
    function Fax(AValue: string): TModelFornecedoresEntitie; overload;
    function Fax: string; overload;
    function Id(AValue: string): TModelFornecedoresEntitie; overload;
    function Id(AValue: Integer): TModelFornecedoresEntitie; overload;
    function Id: Integer; overload;
    function IE(AValue: string): TModelFornecedoresEntitie; overload;
    function IE: string; overload;
    function NomeFantasia(AValue: string): TModelFornecedoresEntitie; overload;
    function NomeFantasia: string; overload;
    function Numero(AValue: string): TModelFornecedoresEntitie; overload;
    function Numero: string; overload;
    function RazaoSocial(AValue: string): TModelFornecedoresEntitie; overload;
    function RazaoSocial: string; overload;
    function RG(AValue: string): TModelFornecedoresEntitie; overload;
    function RG: string; overload;
    function RgOrgaoExpedidor(AValue: string): TModelFornecedoresEntitie; overload;
    function RgOrgaoExpedidor: string; overload;
    function StatusCliente(AValue: string): TModelFornecedoresEntitie; overload;
    function StatusCliente: string; overload;
    function Telefone(AValue: string): TModelFornecedoresEntitie; overload;
    function Telefone: string; overload;
    function Telefone2(AValue: string): TModelFornecedoresEntitie; overload;
    function Telefone2: string; overload;
    function TipoJuridico(AValue: string): TModelFornecedoresEntitie; overload;
    function TipoJuridico: string; overload;
    function TipoJuridicoComboBox: Integer;
  end;

implementation

uses
  Utils.GlobalConsts;

constructor TModelFornecedoresEntitie.Create(AParent: IModelFornecedoresFactory<TModelFornecedoresEntitie>);
begin
   FParent        := AParent;
   FStatusCliente := STATUS_ATIVO;
   FTipoJuridico  := PESSOA_FISICA;
end;

destructor TModelFornecedoresEntitie.Destroy;
begin
   inherited;
end;

function TModelFornecedoresEntitie.End_Entitie: IModelFornecedoresFactory<TModelFornecedoresEntitie>;
begin
   Result := FParent;
end;

function TModelFornecedoresEntitie.Bairro(AValue: string): TModelFornecedoresEntitie;
begin
   Result  := Self;
   FBairro := AValue.Trim;
end;

function TModelFornecedoresEntitie.Bairro: string;
begin
   Result := FBairro;
end;

function TModelFornecedoresEntitie.Celular(AValue: string): TModelFornecedoresEntitie;
begin
   Result   := Self;
   FCelular := AValue.Trim;
end;

function TModelFornecedoresEntitie.Celular: string;
begin
   Result := FCelular;
end;

function TModelFornecedoresEntitie.Cep(AValue: string): TModelFornecedoresEntitie;
begin
   Result := Self;
   FCep   := AValue;
end;

function TModelFornecedoresEntitie.Cep: string;
begin
   Result := FCep;
end;

function TModelFornecedoresEntitie.Cidade(AValue: string): TModelFornecedoresEntitie;
begin
   Result := Self;
   Self.Cidade(StrToIntDef(AValue.Trim, 0));
end;

function TModelFornecedoresEntitie.Cidade(AValue: Integer): TModelFornecedoresEntitie;
begin
   Result  := Self;
   FCidade := AValue;
end;

function TModelFornecedoresEntitie.Cidade: Integer;
begin
   Result := FCidade;
end;

function TModelFornecedoresEntitie.Cnpj(AValue: string): TModelFornecedoresEntitie;
begin
   Result := Self;
   FCnpj  := AValue.Trim;
end;

function TModelFornecedoresEntitie.Cnpj: string;
begin
   Result := FCnpj;
end;

function TModelFornecedoresEntitie.Cpf(AValue: string): TModelFornecedoresEntitie;
begin
   Result := Self;
   FCpf   := AValue.Trim;
end;

function TModelFornecedoresEntitie.Cpf: string;
begin
   Result := FCpf;
end;

function TModelFornecedoresEntitie.DataCadastro(AValue: string): TModelFornecedoresEntitie;
begin
   Result := Self;
   Self.DataCadastro(StrToDate(AValue.Trim));
end;

function TModelFornecedoresEntitie.DataCadastro(AValue: TDateTime): TModelFornecedoresEntitie;
begin
   Result        := Self;
   FDataCadastro := AValue;
end;

function TModelFornecedoresEntitie.DataCadastro: TDateTime;
begin
   Result := FDataCadastro;
end;

function TModelFornecedoresEntitie.DataNascimento(AValue: string): TModelFornecedoresEntitie;
begin
   Result := Self;
   Self.DataNascimento(StrToDate(AValue.Trim));
end;

function TModelFornecedoresEntitie.DataNascimento(AValue: TDateTime): TModelFornecedoresEntitie;
begin
   Result          := Self;
   FDataNascimento := AValue;
end;

function TModelFornecedoresEntitie.DataNascimento: TDateTime;
begin
   Result := FDataNascimento;
end;

function TModelFornecedoresEntitie.Email(AValue: string): TModelFornecedoresEntitie;
begin
   Result := Self;
   FEmail := AValue.Trim;
end;

function TModelFornecedoresEntitie.Email: string;
begin
   Result := FEmail;
end;

function TModelFornecedoresEntitie.Endereco(AValue: string): TModelFornecedoresEntitie;
begin
   Result    := Self;
   FEndereco := AValue.Trim;
end;

function TModelFornecedoresEntitie.Endereco: string;
begin
   Result := FEndereco;
end;

function TModelFornecedoresEntitie.Fax(AValue: string): TModelFornecedoresEntitie;
begin
   Result := Self;
   FFax   := AValue.Trim;
end;

function TModelFornecedoresEntitie.Fax: string;
begin
   Result := FFax;
end;

function TModelFornecedoresEntitie.Id(AValue: string): TModelFornecedoresEntitie;
begin
   Result := Self;
   Self.Id(StrToIntDef(AValue.Trim, 0));
end;

function TModelFornecedoresEntitie.Id(AValue: Integer): TModelFornecedoresEntitie;
begin
   Result := Self;
   FId    := AValue;
end;

function TModelFornecedoresEntitie.Id: Integer;
begin
   Result := FId;
end;

function TModelFornecedoresEntitie.IE(AValue: string): TModelFornecedoresEntitie;
begin
   Result := Self;
   FIE    := AValue.Trim;
end;

function TModelFornecedoresEntitie.IE: string;
begin
   Result := FIE;
end;

function TModelFornecedoresEntitie.NomeFantasia(AValue: string): TModelFornecedoresEntitie;
begin
   Result        := Self;
   FNomeFantasia := AValue.Trim;
end;

function TModelFornecedoresEntitie.NomeFantasia: string;
begin
   Result := FNomeFantasia;
end;

function TModelFornecedoresEntitie.Numero(AValue: string): TModelFornecedoresEntitie;
begin
   Result  := Self;
   FNumero := AValue.Trim;
end;

function TModelFornecedoresEntitie.Numero: string;
begin
   Result := FNumero;
end;

function TModelFornecedoresEntitie.RazaoSocial(AValue: string): TModelFornecedoresEntitie;
begin
   Result       := Self;
   FRazaoSocial := AValue.Trim;
end;

function TModelFornecedoresEntitie.RazaoSocial: string;
begin
   Result := FRazaoSocial;
end;

function TModelFornecedoresEntitie.RG(AValue: string): TModelFornecedoresEntitie;
begin
   Result := Self;
   FRG    := AValue.Trim;
end;

function TModelFornecedoresEntitie.RG: string;
begin
   Result := FRG;
end;

function TModelFornecedoresEntitie.RgOrgaoExpedidor(AValue: string): TModelFornecedoresEntitie;
begin
   Result            := Self;
   FRgOrgaoExpedidor := AValue.Trim;
end;

function TModelFornecedoresEntitie.RgOrgaoExpedidor: string;
begin
   Result := FRgOrgaoExpedidor;
end;

function TModelFornecedoresEntitie.StatusCliente(AValue: string): TModelFornecedoresEntitie;
begin
   Result         := Self;
   FStatusCliente := AValue.Trim;
end;

function TModelFornecedoresEntitie.StatusCliente: string;
begin
   Result := FStatusCliente;
end;

function TModelFornecedoresEntitie.Telefone(AValue: string): TModelFornecedoresEntitie;
begin
   Result    := Self;
   FTelefone := AValue.Trim;
end;

function TModelFornecedoresEntitie.Telefone: string;
begin
   Result := FTelefone;
end;

function TModelFornecedoresEntitie.Telefone2(AValue: string): TModelFornecedoresEntitie;
begin
   Result     := Self;
   FTelefone2 := AValue.Trim;
end;

function TModelFornecedoresEntitie.Telefone2: string;
begin
   Result := FTelefone2;
end;

function TModelFornecedoresEntitie.TipoJuridico(AValue: string): TModelFornecedoresEntitie;
var
  LTipo: string;
begin
   Result := Self;

   LTipo := UpperCase(AValue.Trim);

   FTipoJuridico := PESSOA_FISICA_DATABASE;
   if(LTipo.Equals(PESSOA_JURIDICA))then
     FTipoJuridico := PESSOA_JURIDICA_DATABASE;

   if(LTipo.Equals(PESSOA_FISICA_DATABASE) or LTipo.Equals(PESSOA_JURIDICA_DATABASE))then
     FTipoJuridico := LTipo;
end;

function TModelFornecedoresEntitie.TipoJuridico: string;
begin
   Result := FTipoJuridico;
end;

function TModelFornecedoresEntitie.TipoJuridicoComboBox: Integer;
begin
   Result := -1;
   if(Self.TipoJuridico.Equals(PESSOA_FISICA_DATABASE))then
     Result := 0
   else if(Self.TipoJuridico.Equals(PESSOA_JURIDICA_DATABASE))then
     Result := 1;
end;

end.
