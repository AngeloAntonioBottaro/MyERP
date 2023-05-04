unit Model.Empresas.Entitie;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Model.Empresas.Interfaces;

type
  TModelEmpresasEntitie = class
  private
    [weak]
    FParent: IModelEmpresasFactory<TModelEmpresasEntitie>;

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
    FServidorHash: string;
  public
    constructor Create(AParent: IModelEmpresasFactory<TModelEmpresasEntitie>);
    destructor Destroy; override;
    function End_Entitie: IModelEmpresasFactory<TModelEmpresasEntitie>;

    function Bairro(AValue: string): TModelEmpresasEntitie; overload;
    function Bairro: string; overload;
    function Celular(AValue: string): TModelEmpresasEntitie; overload;
    function Celular: string; overload;
    function CelularMascara: string;
    function Cep(AValue: string): TModelEmpresasEntitie; overload;
    function Cep: string; overload;
    function CepMascara: string;
    function Cidade(AValue: string): TModelEmpresasEntitie; overload;
    function Cidade(AValue: Integer): TModelEmpresasEntitie; overload;
    function Cidade: Integer; overload;
    function CidadeMascara: string;
    function Cnpj(AValue: string): TModelEmpresasEntitie; overload;
    function Cnpj: string; overload;
    function CnpjMascara: string;
    function Cpf(AValue: string): TModelEmpresasEntitie; overload;
    function Cpf: string; overload;
    function CpfMascara: string;
    function DataCadastro(AValue: string): TModelEmpresasEntitie; overload;
    function DataCadastro(AValue: TDateTime): TModelEmpresasEntitie; overload;
    function DataCadastro: TDateTime; overload;
    function DataNascimento(AValue: string): TModelEmpresasEntitie; overload;
    function DataNascimento(AValue: TDateTime): TModelEmpresasEntitie; overload;
    function DataNascimento: TDateTime; overload;
    function Email(AValue: string): TModelEmpresasEntitie; overload;
    function Email: string; overload;
    function Endereco(AValue: string): TModelEmpresasEntitie; overload;
    function Endereco: string; overload;
    function Fax(AValue: string): TModelEmpresasEntitie; overload;
    function Fax: string; overload;
    function FaxMascara: string;
    function Id(AValue: string): TModelEmpresasEntitie; overload;
    function Id(AValue: Integer): TModelEmpresasEntitie; overload;
    function Id: Integer; overload;
    function IdMascara: string;
    function IdNome: string;
    function IE(AValue: string): TModelEmpresasEntitie; overload;
    function IE: string; overload;
    function NomeFantasia(AValue: string): TModelEmpresasEntitie; overload;
    function NomeFantasia: string; overload;
    function Numero(AValue: string): TModelEmpresasEntitie; overload;
    function Numero: string; overload;
    function RazaoSocial(AValue: string): TModelEmpresasEntitie; overload;
    function RazaoSocial: string; overload;
    function RG(AValue: string): TModelEmpresasEntitie; overload;
    function RG: string; overload;
    function RgOrgaoExpedidor(AValue: string): TModelEmpresasEntitie; overload;
    function RgOrgaoExpedidor: string; overload;
    function Status(AValue: string): TModelEmpresasEntitie; overload;
    function Status: string; overload;
    function Telefone(AValue: string): TModelEmpresasEntitie; overload;
    function Telefone: string; overload;
    function TelefoneMascara: string;
    function Telefone2(AValue: string): TModelEmpresasEntitie; overload;
    function Telefone2: string; overload;
    function Telefone2Mascara: string;
    function TipoJuridico(AValue: string): TModelEmpresasEntitie; overload;
    function TipoJuridico: string; overload;
    function TipoJuridicoComboBox: Integer;
    function ServidorHash(AValue: string): TModelEmpresasEntitie; overload;
    function ServidorHash: string; overload;
  end;

implementation

uses
  Utils.MyLibrary,
  Utils.GlobalConsts;

constructor TModelEmpresasEntitie.Create(AParent: IModelEmpresasFactory<TModelEmpresasEntitie>);
begin
   FParent       := AParent;
   FStatus       := STATUS_ATIVO;
   FTipoJuridico := PESSOA_FISICA;
end;

destructor TModelEmpresasEntitie.Destroy;
begin
   inherited;
end;

function TModelEmpresasEntitie.End_Entitie: IModelEmpresasFactory<TModelEmpresasEntitie>;
begin
   Result := FParent;
end;

function TModelEmpresasEntitie.Bairro(AValue: string): TModelEmpresasEntitie;
begin
   Result  := Self;
   FBairro := AValue.Trim;
end;

function TModelEmpresasEntitie.Bairro: string;
begin
   Result := FBairro;
end;

function TModelEmpresasEntitie.Celular(AValue: string): TModelEmpresasEntitie;
begin
   Result   := Self;
   FCelular := TMyLibrary.NumbersOnly(AValue.Trim);
end;

function TModelEmpresasEntitie.Celular: string;
begin
   Result := FCelular;
end;

function TModelEmpresasEntitie.CelularMascara: string;
begin
   Result := TMyLibrary.ArrangeFone(Self.Celular);
end;

function TModelEmpresasEntitie.Cep(AValue: string): TModelEmpresasEntitie;
begin
   Result := Self;
   FCep   := TMyLibrary.NumbersOnly(AValue.Trim);
end;

function TModelEmpresasEntitie.Cep: string;
begin
   Result := FCep;
end;

function TModelEmpresasEntitie.CepMascara: string;
begin
   Result := TMyLibrary.ArrangeCEP(Self.Cep);
end;

function TModelEmpresasEntitie.Cidade(AValue: string): TModelEmpresasEntitie;
begin
   Result := Self;
   Self.Cidade(TMyLibrary.StrToIntDef(AValue.Trim));
end;

function TModelEmpresasEntitie.Cidade(AValue: Integer): TModelEmpresasEntitie;
begin
   Result  := Self;
   FCidade := AValue;
end;

function TModelEmpresasEntitie.Cidade: Integer;
begin
   Result := FCidade;
end;

function TModelEmpresasEntitie.CidadeMascara: string;
begin
   Result := EmptyStr;
   if(Self.Cidade > 0)then
     Result := TMyLibrary.CompLeft(Self.Cidade);
end;

function TModelEmpresasEntitie.Cnpj(AValue: string): TModelEmpresasEntitie;
begin
   Result := Self;
   FCnpj  := TMyLibrary.NumbersOnly(AValue.Trim);
end;

function TModelEmpresasEntitie.Cnpj: string;
begin
   Result := FCnpj;
end;

function TModelEmpresasEntitie.CnpjMascara: string;
begin
   Result := TMyLibrary.ArrangeCNPJ(Self.Cnpj);
end;

function TModelEmpresasEntitie.Cpf(AValue: string): TModelEmpresasEntitie;
begin
   Result := Self;
   FCpf   := TMyLibrary.NumbersOnly(AValue.Trim);
end;

function TModelEmpresasEntitie.Cpf: string;
begin
   Result := FCpf;
end;

function TModelEmpresasEntitie.CpfMascara: string;
begin
   Result := TMyLibrary.ArrangeCPF(Self.Cpf);
end;

function TModelEmpresasEntitie.DataCadastro(AValue: string): TModelEmpresasEntitie;
begin
   Result := Self;
   Self.DataCadastro(StrToDate(AValue.Trim));
end;

function TModelEmpresasEntitie.DataCadastro(AValue: TDateTime): TModelEmpresasEntitie;
begin
   Result        := Self;
   FDataCadastro := AValue;
end;

function TModelEmpresasEntitie.DataCadastro: TDateTime;
begin
   Result := FDataCadastro;
end;

function TModelEmpresasEntitie.DataNascimento(AValue: string): TModelEmpresasEntitie;
begin
   Result := Self;
   Self.DataNascimento(StrToDate(AValue.Trim));
end;

function TModelEmpresasEntitie.DataNascimento(AValue: TDateTime): TModelEmpresasEntitie;
begin
   Result          := Self;
   FDataNascimento := AValue;
end;

function TModelEmpresasEntitie.DataNascimento: TDateTime;
begin
   Result := FDataNascimento;
end;

function TModelEmpresasEntitie.Email(AValue: string): TModelEmpresasEntitie;
begin
   Result := Self;
   FEmail := AValue.Trim;
end;

function TModelEmpresasEntitie.Email: string;
begin
   Result := FEmail;
end;

function TModelEmpresasEntitie.Endereco(AValue: string): TModelEmpresasEntitie;
begin
   Result    := Self;
   FEndereco := AValue.Trim;
end;

function TModelEmpresasEntitie.Endereco: string;
begin
   Result := FEndereco;
end;

function TModelEmpresasEntitie.Fax(AValue: string): TModelEmpresasEntitie;
begin
   Result := Self;
   FFax   := TMyLibrary.NumbersOnly(AValue.Trim);
end;

function TModelEmpresasEntitie.Fax: string;
begin
   Result := FFax;
end;

function TModelEmpresasEntitie.FaxMascara: string;
begin
   Result := TMyLibrary.ArrangeFone(Self.Fax);
end;

function TModelEmpresasEntitie.Id(AValue: string): TModelEmpresasEntitie;
begin
   Result := Self;
   Self.Id(TMyLibrary.StrToIntDef(AValue.Trim));
end;

function TModelEmpresasEntitie.Id(AValue: Integer): TModelEmpresasEntitie;
begin
   Result := Self;
   FId    := AValue;
end;

function TModelEmpresasEntitie.Id: Integer;
begin
   Result := FId;
end;

function TModelEmpresasEntitie.IdMascara: string;
begin
   Result := EmptyStr;
   if(Self.Id > 0)then
     Result := TMyLibrary.CompLeft(Self.Id);
end;

function TModelEmpresasEntitie.IdNome: string;
begin
   Result := Self.NomeFantasia;
   if(Result.IsEmpty)then
     Result := Self.RazaoSocial;

   Result := IfThen(Result.IsEmpty, Self.IdMascara, Self.IdMascara + ' - ' + Result);
end;

function TModelEmpresasEntitie.IE(AValue: string): TModelEmpresasEntitie;
begin
   Result := Self;
   FIE    := TMyLibrary.NumbersOnly(AValue.Trim);
end;

function TModelEmpresasEntitie.IE: string;
begin
   Result := FIE;
end;

function TModelEmpresasEntitie.NomeFantasia(AValue: string): TModelEmpresasEntitie;
begin
   Result        := Self;
   FNomeFantasia := AValue.Trim;
end;

function TModelEmpresasEntitie.NomeFantasia: string;
begin
   Result := FNomeFantasia;
end;

function TModelEmpresasEntitie.Numero(AValue: string): TModelEmpresasEntitie;
begin
   Result  := Self;
   FNumero := AValue.Trim;
end;

function TModelEmpresasEntitie.Numero: string;
begin
   Result := FNumero;
end;

function TModelEmpresasEntitie.RazaoSocial(AValue: string): TModelEmpresasEntitie;
begin
   Result       := Self;
   FRazaoSocial := AValue.Trim;
end;

function TModelEmpresasEntitie.RazaoSocial: string;
begin
   Result := FRazaoSocial;
end;

function TModelEmpresasEntitie.RG(AValue: string): TModelEmpresasEntitie;
begin
   Result := Self;
   FRG    := TMyLibrary.NumbersOnly(AValue.Trim);
end;

function TModelEmpresasEntitie.RG: string;
begin
   Result := FRG;
end;

function TModelEmpresasEntitie.RgOrgaoExpedidor(AValue: string): TModelEmpresasEntitie;
begin
   Result            := Self;
   FRgOrgaoExpedidor := AValue.Trim;
end;

function TModelEmpresasEntitie.RgOrgaoExpedidor: string;
begin
   Result := FRgOrgaoExpedidor;
end;

function TModelEmpresasEntitie.Status(AValue: string): TModelEmpresasEntitie;
begin
   Result  := Self;
   FStatus := AValue.Trim;
end;

function TModelEmpresasEntitie.Status: string;
begin
   Result := FStatus;
end;

function TModelEmpresasEntitie.Telefone(AValue: string): TModelEmpresasEntitie;
begin
   Result    := Self;
   FTelefone := TMyLibrary.NumbersOnly(AValue.Trim);
end;

function TModelEmpresasEntitie.Telefone: string;
begin
   Result := FTelefone;
end;

function TModelEmpresasEntitie.TelefoneMascara: string;
begin
   Result := TMyLibrary.ArrangeFone(Self.Telefone);
end;

function TModelEmpresasEntitie.Telefone2(AValue: string): TModelEmpresasEntitie;
begin
   Result     := Self;
   FTelefone2 := TMyLibrary.NumbersOnly(AValue.Trim);
end;

function TModelEmpresasEntitie.Telefone2: string;
begin
   Result := FTelefone2;
end;

function TModelEmpresasEntitie.Telefone2Mascara: string;
begin
   Result := TMyLibrary.ArrangeFone(Self.Telefone2);
end;

function TModelEmpresasEntitie.TipoJuridico(AValue: string): TModelEmpresasEntitie;
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

function TModelEmpresasEntitie.TipoJuridico: string;
begin
   Result := FTipoJuridico;
end;

function TModelEmpresasEntitie.TipoJuridicoComboBox: Integer;
begin
   Result := -1;
   if(Self.TipoJuridico.Equals(PESSOA_FISICA_DATABASE))then
     Result := 0
   else if(Self.TipoJuridico.Equals(PESSOA_JURIDICA_DATABASE))then
     Result := 1;
end;

function TModelEmpresasEntitie.ServidorHash(AValue: string): TModelEmpresasEntitie;
begin
   Result        := Self;
   FServidorHash := AValue.Trim;
end;

function TModelEmpresasEntitie.ServidorHash: string;
begin
   Result := FServidorHash;
end;

end.
