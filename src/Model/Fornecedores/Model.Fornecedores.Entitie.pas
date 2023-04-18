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
    FStatus: string;
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
    function CelularMascara: string;
    function Cep(AValue: string): TModelFornecedoresEntitie; overload;
    function Cep: string; overload;
    function CepMascara: string;
    function Cidade(AValue: string): TModelFornecedoresEntitie; overload;
    function Cidade(AValue: Integer): TModelFornecedoresEntitie; overload;
    function Cidade: Integer; overload;
    function CidadeMascara: string;
    function Cnpj(AValue: string): TModelFornecedoresEntitie; overload;
    function Cnpj: string; overload;
    function CnpjMascara: string;
    function Cpf(AValue: string): TModelFornecedoresEntitie; overload;
    function Cpf: string; overload;
    function CpfMascara: string;
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
    function FaxMascara: string;
    function Id(AValue: string): TModelFornecedoresEntitie; overload;
    function Id(AValue: Integer): TModelFornecedoresEntitie; overload;
    function Id: Integer; overload;
    function IdMascara: string;
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
    function Status(AValue: string): TModelFornecedoresEntitie; overload;
    function Status: string; overload;
    function Telefone(AValue: string): TModelFornecedoresEntitie; overload;
    function Telefone: string; overload;
    function TelefoneMascara: string;
    function Telefone2(AValue: string): TModelFornecedoresEntitie; overload;
    function Telefone2: string; overload;
    function Telefone2Mascara: string;
    function TipoJuridico(AValue: string): TModelFornecedoresEntitie; overload;
    function TipoJuridico: string; overload;
    function TipoJuridicoComboBox: Integer;
  end;

implementation

uses
  Utils.MyLibrary,
  Utils.GlobalConsts;

constructor TModelFornecedoresEntitie.Create(AParent: IModelFornecedoresFactory<TModelFornecedoresEntitie>);
begin
   FParent       := AParent;
   FStatus       := STATUS_ATIVO;
   FTipoJuridico := PESSOA_FISICA;
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
   FCelular := TMyLibrary.NumbersOnly(AValue.Trim);
end;

function TModelFornecedoresEntitie.Celular: string;
begin
   Result := FCelular;
end;

function TModelFornecedoresEntitie.CelularMascara: string;
begin
   Result := TMyLibrary.ArrangeFone(Self.Celular);
end;

function TModelFornecedoresEntitie.Cep(AValue: string): TModelFornecedoresEntitie;
begin
   Result := Self;
   FCep   := TMyLibrary.NumbersOnly(AValue.Trim);
end;

function TModelFornecedoresEntitie.Cep: string;
begin
   Result := FCep;
end;

function TModelFornecedoresEntitie.CepMascara: string;
begin
   Result := TMyLibrary.ArrangeCEP(Self.Cep);
end;

function TModelFornecedoresEntitie.Cidade(AValue: string): TModelFornecedoresEntitie;
begin
   Result := Self;
   Self.Cidade(TMyLibrary.StrToIntDef(AValue.Trim));
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

function TModelFornecedoresEntitie.CidadeMascara: string;
begin
   Result := EmptyStr;
   if(Self.Cidade > 0)then
     Result := TMyLibrary.CompLeft(Self.Cidade);
end;

function TModelFornecedoresEntitie.Cnpj(AValue: string): TModelFornecedoresEntitie;
begin
   Result := Self;
   FCnpj  := TMyLibrary.NumbersOnly(AValue.Trim);
end;

function TModelFornecedoresEntitie.Cnpj: string;
begin
   Result := FCnpj;
end;

function TModelFornecedoresEntitie.CnpjMascara: string;
begin
   Result := TMyLibrary.ArrangeCNPJ(Self.Cnpj);
end;

function TModelFornecedoresEntitie.Cpf(AValue: string): TModelFornecedoresEntitie;
begin
   Result := Self;
   FCpf   := TMyLibrary.NumbersOnly(AValue.Trim);
end;

function TModelFornecedoresEntitie.Cpf: string;
begin
   Result := FCpf;
end;

function TModelFornecedoresEntitie.CpfMascara: string;
begin
   Result := TMyLibrary.ArrangeCPF(Self.Cpf);
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
   FFax   := TMyLibrary.NumbersOnly(AValue.Trim);
end;

function TModelFornecedoresEntitie.Fax: string;
begin
   Result := FFax;
end;

function TModelFornecedoresEntitie.FaxMascara: string;
begin
   Result := TMyLibrary.ArrangeFone(Self.Fax);
end;

function TModelFornecedoresEntitie.Id(AValue: string): TModelFornecedoresEntitie;
begin
   Result := Self;
   Self.Id(TMyLibrary.StrToIntDef(AValue.Trim));
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

function TModelFornecedoresEntitie.IdMascara: string;
begin
   Result := EmptyStr;
   if(Self.Id > 0)then
     Result := TMyLibrary.CompLeft(Self.Id);
end;

function TModelFornecedoresEntitie.IE(AValue: string): TModelFornecedoresEntitie;
begin
   Result := Self;
   FIE    := TMyLibrary.NumbersOnly(AValue.Trim);
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
   FRG    := TMyLibrary.NumbersOnly(AValue.Trim);
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

function TModelFornecedoresEntitie.Status(AValue: string): TModelFornecedoresEntitie;
begin
   Result  := Self;
   FStatus := AValue.Trim;
end;

function TModelFornecedoresEntitie.Status: string;
begin
   Result := FStatus;
end;

function TModelFornecedoresEntitie.Telefone(AValue: string): TModelFornecedoresEntitie;
begin
   Result    := Self;
   FTelefone := TMyLibrary.NumbersOnly(AValue.Trim);
end;

function TModelFornecedoresEntitie.Telefone: string;
begin
   Result := FTelefone;
end;

function TModelFornecedoresEntitie.TelefoneMascara: string;
begin
   Result := TMyLibrary.ArrangeFone(Self.Telefone);
end;

function TModelFornecedoresEntitie.Telefone2(AValue: string): TModelFornecedoresEntitie;
begin
   Result     := Self;
   FTelefone2 := TMyLibrary.NumbersOnly(AValue.Trim);
end;

function TModelFornecedoresEntitie.Telefone2: string;
begin
   Result := FTelefone2;
end;

function TModelFornecedoresEntitie.Telefone2Mascara: string;
begin
   Result := TMyLibrary.ArrangeFone(Self.Telefone2);
end;

function TModelFornecedoresEntitie.TipoJuridico(AValue: string): TModelFornecedoresEntitie;
var
  LTipo: string;
begin
   Result := Self;

   LTipo := AValue.Trim;
   FTipoJuridico := PESSOA_FISICA_DATABASE;
   if(LTipo.Equals(PESSOA_JURIDICA))then
     FTipoJuridico := PESSOA_JURIDICA_DATABASE;

   LTipo := UpperCase(LTipo);
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
