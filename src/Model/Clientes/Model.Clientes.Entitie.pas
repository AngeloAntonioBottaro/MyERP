unit Model.Clientes.Entitie;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Model.Clientes.Interfaces;

type
  TModelClientesEntitie = class
  private
    [weak]
    FParent: IModelClientesFactory<TModelClientesEntitie>;

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
    constructor Create(AParent: IModelClientesFactory<TModelClientesEntitie>);
    destructor Destroy; override;
    function End_Entitie: IModelClientesFactory<TModelClientesEntitie>;

    function Bairro(AValue: string): TModelClientesEntitie; overload;
    function Bairro: string; overload;
    function Celular(AValue: string): TModelClientesEntitie; overload;
    function Celular: string; overload;
    function CelularMascara: string;
    function Cep(AValue: string): TModelClientesEntitie; overload;
    function Cep: string; overload;
    function CepMascara: string;
    function Cidade(AValue: string): TModelClientesEntitie; overload;
    function Cidade(AValue: Integer): TModelClientesEntitie; overload;
    function Cidade: Integer; overload;
    function Cnpj(AValue: string): TModelClientesEntitie; overload;
    function Cnpj: string; overload;
    function CnpjMascara: string;
    function Cpf(AValue: string): TModelClientesEntitie; overload;
    function Cpf: string; overload;
    function CpfMascara: string;
    function DataCadastro(AValue: string): TModelClientesEntitie; overload;
    function DataCadastro(AValue: TDateTime): TModelClientesEntitie; overload;
    function DataCadastro: TDateTime; overload;
    function DataNascimento(AValue: string): TModelClientesEntitie; overload;
    function DataNascimento(AValue: TDateTime): TModelClientesEntitie; overload;
    function DataNascimento: TDateTime; overload;
    function Email(AValue: string): TModelClientesEntitie; overload;
    function Email: string; overload;
    function Endereco(AValue: string): TModelClientesEntitie; overload;
    function Endereco: string; overload;
    function Fax(AValue: string): TModelClientesEntitie; overload;
    function Fax: string; overload;
    function FaxMascara: string;
    function Id(AValue: string): TModelClientesEntitie; overload;
    function Id(AValue: Integer): TModelClientesEntitie; overload;
    function Id: Integer; overload;
    function IE(AValue: string): TModelClientesEntitie; overload;
    function IE: string; overload;
    function NomeFantasia(AValue: string): TModelClientesEntitie; overload;
    function NomeFantasia: string; overload;
    function Numero(AValue: string): TModelClientesEntitie; overload;
    function Numero: string; overload;
    function RazaoSocial(AValue: string): TModelClientesEntitie; overload;
    function RazaoSocial: string; overload;
    function RG(AValue: string): TModelClientesEntitie; overload;
    function RG: string; overload;
    function RgOrgaoExpedidor(AValue: string): TModelClientesEntitie; overload;
    function RgOrgaoExpedidor: string; overload;
    function StatusCliente(AValue: string): TModelClientesEntitie; overload;
    function StatusCliente: string; overload;
    function Telefone(AValue: string): TModelClientesEntitie; overload;
    function Telefone: string; overload;
    function TelefoneMascara: string;
    function Telefone2(AValue: string): TModelClientesEntitie; overload;
    function Telefone2: string; overload;
    function Telefone2Mascara: string;
    function TipoJuridico(AValue: string): TModelClientesEntitie; overload;
    function TipoJuridico: string; overload;
    function TipoJuridicoComboBox: Integer;
  end;

implementation

uses
  Utils.MyLibrary,
  Utils.GlobalConsts;

constructor TModelClientesEntitie.Create(AParent: IModelClientesFactory<TModelClientesEntitie>);
begin
   FParent        := AParent;
   FStatusCliente := STATUS_ATIVO;
   FTipoJuridico  := PESSOA_FISICA;
end;

destructor TModelClientesEntitie.Destroy;
begin
   inherited;
end;

function TModelClientesEntitie.End_Entitie: IModelClientesFactory<TModelClientesEntitie>;
begin
   Result := FParent;
end;

function TModelClientesEntitie.Bairro(AValue: string): TModelClientesEntitie;
begin
   Result  := Self;
   FBairro := AValue.Trim;
end;

function TModelClientesEntitie.Bairro: string;
begin
   Result := FBairro;
end;

function TModelClientesEntitie.Celular(AValue: string): TModelClientesEntitie;
begin
   Result   := Self;
   FCelular := TMyLibrary.NumbersOnly(AValue.Trim);
end;

function TModelClientesEntitie.Celular: string;
begin
   Result := FCelular;
end;

function TModelClientesEntitie.CelularMascara: string;
begin
   Result := TMyLibrary.ArrangeFone(Self.Celular);
end;

function TModelClientesEntitie.Cep(AValue: string): TModelClientesEntitie;
begin
   Result := Self;
   FCep   := TMyLibrary.NumbersOnly(AValue);
end;

function TModelClientesEntitie.Cep: string;
begin
   Result := FCep;
end;

function TModelClientesEntitie.CepMascara: string;
begin
   Result := TMyLibrary.ArrangeCEP(Self.Cep);
end;

function TModelClientesEntitie.Cidade(AValue: string): TModelClientesEntitie;
begin
   Result := Self;
   Self.Cidade(TMyLibrary.StrToIntDef(AValue.Trim));
end;

function TModelClientesEntitie.Cidade(AValue: Integer): TModelClientesEntitie;
begin
   Result  := Self;
   FCidade := AValue;
end;

function TModelClientesEntitie.Cidade: Integer;
begin
   Result := FCidade;
end;

function TModelClientesEntitie.Cnpj(AValue: string): TModelClientesEntitie;
begin
   Result := Self;
   FCnpj  := TMyLibrary.NumbersOnly(AValue.Trim);
end;

function TModelClientesEntitie.Cnpj: string;
begin
   Result := FCnpj;
end;

function TModelClientesEntitie.CnpjMascara: string;
begin
   Result := TMyLibrary.ArrangeCNPJ(Self.Cnpj);
end;

function TModelClientesEntitie.Cpf(AValue: string): TModelClientesEntitie;
begin
   Result := Self;
   FCpf   := TMyLibrary.NumbersOnly(AValue.Trim);
end;

function TModelClientesEntitie.Cpf: string;
begin
   Result := FCpf;
end;

function TModelClientesEntitie.CpfMascara: string;
begin
   Result := TMyLibrary.ArrangeCPF(Self.Cpf);
end;

function TModelClientesEntitie.DataCadastro(AValue: string): TModelClientesEntitie;
begin
   Result := Self;
   Self.DataCadastro(StrToDate(AValue.Trim));
end;

function TModelClientesEntitie.DataCadastro(AValue: TDateTime): TModelClientesEntitie;
begin
   Result        := Self;
   FDataCadastro := AValue;
end;

function TModelClientesEntitie.DataCadastro: TDateTime;
begin
   Result := FDataCadastro;
end;

function TModelClientesEntitie.DataNascimento(AValue: string): TModelClientesEntitie;
begin
   Result := Self;
   Self.DataNascimento(StrToDate(AValue.Trim));
end;

function TModelClientesEntitie.DataNascimento(AValue: TDateTime): TModelClientesEntitie;
begin
   Result          := Self;
   FDataNascimento := AValue;
end;

function TModelClientesEntitie.DataNascimento: TDateTime;
begin
   Result := FDataNascimento;
end;

function TModelClientesEntitie.Email(AValue: string): TModelClientesEntitie;
begin
   Result := Self;
   FEmail := AValue.Trim;
end;

function TModelClientesEntitie.Email: string;
begin
   Result := FEmail;
end;

function TModelClientesEntitie.Endereco(AValue: string): TModelClientesEntitie;
begin
   Result    := Self;
   FEndereco := AValue.Trim;
end;

function TModelClientesEntitie.Endereco: string;
begin
   Result := FEndereco;
end;

function TModelClientesEntitie.Fax(AValue: string): TModelClientesEntitie;
begin
   Result := Self;
   FFax   := TMyLibrary.NumbersOnly(AValue.Trim);
end;

function TModelClientesEntitie.Fax: string;
begin
   Result := FFax;
end;

function TModelClientesEntitie.FaxMascara: string;
begin
   Result := TMyLibrary.ArrangeFone(Self.Fax);
end;

function TModelClientesEntitie.Id(AValue: string): TModelClientesEntitie;
begin
   Result := Self;
   Self.Id(TMyLibrary.StrToIntDef(AValue.Trim));
end;

function TModelClientesEntitie.Id(AValue: Integer): TModelClientesEntitie;
begin
   Result := Self;
   FId    := AValue;
end;

function TModelClientesEntitie.Id: Integer;
begin
   Result := FId;
end;

function TModelClientesEntitie.IE(AValue: string): TModelClientesEntitie;
begin
   Result := Self;
   FIE    := TMyLibrary.NumbersOnly(AValue.Trim);
end;

function TModelClientesEntitie.IE: string;
begin
   Result := FIE;
end;

function TModelClientesEntitie.NomeFantasia(AValue: string): TModelClientesEntitie;
begin
   Result        := Self;
   FNomeFantasia := AValue.Trim;
end;

function TModelClientesEntitie.NomeFantasia: string;
begin
   Result := FNomeFantasia;
end;

function TModelClientesEntitie.Numero(AValue: string): TModelClientesEntitie;
begin
   Result  := Self;
   FNumero := AValue.Trim;
end;

function TModelClientesEntitie.Numero: string;
begin
   Result := FNumero;
end;

function TModelClientesEntitie.RazaoSocial(AValue: string): TModelClientesEntitie;
begin
   Result       := Self;
   FRazaoSocial := AValue.Trim;
end;

function TModelClientesEntitie.RazaoSocial: string;
begin
   Result := FRazaoSocial;
end;

function TModelClientesEntitie.RG(AValue: string): TModelClientesEntitie;
begin
   Result := Self;
   FRG    := TMyLibrary.NumbersOnly(AValue.Trim);
end;

function TModelClientesEntitie.RG: string;
begin
   Result := FRG;
end;

function TModelClientesEntitie.RgOrgaoExpedidor(AValue: string): TModelClientesEntitie;
begin
   Result            := Self;
   FRgOrgaoExpedidor := AValue.Trim;
end;

function TModelClientesEntitie.RgOrgaoExpedidor: string;
begin
   Result := FRgOrgaoExpedidor;
end;

function TModelClientesEntitie.StatusCliente(AValue: string): TModelClientesEntitie;
begin
   Result         := Self;
   FStatusCliente := AValue.Trim;
end;

function TModelClientesEntitie.StatusCliente: string;
begin
   Result := FStatusCliente;
end;

function TModelClientesEntitie.Telefone(AValue: string): TModelClientesEntitie;
begin
   Result    := Self;
   FTelefone := TMyLibrary.NumbersOnly(AValue.Trim);
end;

function TModelClientesEntitie.Telefone: string;
begin
   Result := FTelefone;
end;

function TModelClientesEntitie.Telefone2(AValue: string): TModelClientesEntitie;
begin
   Result     := Self;
   FTelefone2 := TMyLibrary.NumbersOnly(AValue.Trim);
end;

function TModelClientesEntitie.Telefone2: string;
begin
   Result := FTelefone2;
end;

function TModelClientesEntitie.Telefone2Mascara: string;
begin
   Result := TMyLibrary.ArrangeFone(Self.Telefone2);
end;

function TModelClientesEntitie.TelefoneMascara: string;
begin
   Result := TMyLibrary.ArrangeFone(Self.Telefone);
end;

function TModelClientesEntitie.TipoJuridico(AValue: string): TModelClientesEntitie;
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

function TModelClientesEntitie.TipoJuridico: string;
begin
   Result := FTipoJuridico;
end;

function TModelClientesEntitie.TipoJuridicoComboBox: Integer;
begin
   Result := -1;
   if(Self.TipoJuridico.Equals(PESSOA_FISICA_DATABASE))then
     Result := 0
   else if(Self.TipoJuridico.Equals(PESSOA_JURIDICA_DATABASE))then
     Result := 1;
end;

end.
