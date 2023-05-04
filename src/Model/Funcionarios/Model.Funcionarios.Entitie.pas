unit Model.Funcionarios.Entitie;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Model.Funcionarios.Interfaces;

type
  TModelFuncionariosEntitie = class
  private
    [weak]
    FParent: IModelFuncionariosFactory<TModelFuncionariosEntitie>;

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
    FFuncao: Integer;
    FGrupoPermissao: Integer;
    FId: Integer;
    FIE: string;
    FLogin: string;
    FNomeFantasia: string;
    FNumero: string;
    FRazaoSocial: string;
    FRG: string;
    FRgOrgaoExpedidor: string;
    FSalario: Double;
    FSenha: string;
    FStatus: string;
    FTelefone: string;
    FTelefone2: string;
    FTipoJuridico: string;
  public
    constructor Create(AParent: IModelFuncionariosFactory<TModelFuncionariosEntitie>);
    destructor Destroy; override;
    function End_Entitie: IModelFuncionariosFactory<TModelFuncionariosEntitie>;

    function Bairro(AValue: string): TModelFuncionariosEntitie; overload;
    function Bairro: string; overload;
    function Celular(AValue: string): TModelFuncionariosEntitie; overload;
    function Celular: string; overload;
    function CelularMascara: string;
    function Cep(AValue: string): TModelFuncionariosEntitie; overload;
    function Cep: string; overload;
    function CepMascara: string;
    function Cidade(AValue: string): TModelFuncionariosEntitie; overload;
    function Cidade(AValue: Integer): TModelFuncionariosEntitie; overload;
    function Cidade: Integer; overload;
    function CidadeMascara: string;
    function Cnpj(AValue: string): TModelFuncionariosEntitie; overload;
    function Cnpj: string; overload;
    function CnpjMascara: string;
    function Cpf(AValue: string): TModelFuncionariosEntitie; overload;
    function Cpf: string; overload;
    function CpfMascara: string;
    function DataCadastro(AValue: string): TModelFuncionariosEntitie; overload;
    function DataCadastro(AValue: TDateTime): TModelFuncionariosEntitie; overload;
    function DataCadastro: TDateTime; overload;
    function DataNascimento(AValue: string): TModelFuncionariosEntitie; overload;
    function DataNascimento(AValue: TDateTime): TModelFuncionariosEntitie; overload;
    function DataNascimento: TDateTime; overload;
    function Email(AValue: string): TModelFuncionariosEntitie; overload;
    function Email: string; overload;
    function Endereco(AValue: string): TModelFuncionariosEntitie; overload;
    function Endereco: string; overload;
    function Fax(AValue: string): TModelFuncionariosEntitie; overload;
    function Fax: string; overload;
    function FaxMascara: string;
    function Funcao(AValue: string): TModelFuncionariosEntitie; overload;
    function Funcao(AValue: Integer): TModelFuncionariosEntitie; overload;
    function Funcao: Integer; overload;
    function FuncaoMascara: string;
    function GrupoPermissao(AValue: string): TModelFuncionariosEntitie; overload;
    function GrupoPermissao(AValue: Integer): TModelFuncionariosEntitie; overload;
    function GrupoPermissao: Integer; overload;
    function GrupoPermissaoMascara: string;
    function Id(AValue: string): TModelFuncionariosEntitie; overload;
    function Id(AValue: Integer): TModelFuncionariosEntitie; overload;
    function Id: Integer; overload;
    function IdMascara: string;
    function IdNome: string;
    function IE(AValue: string): TModelFuncionariosEntitie; overload;
    function IE: string; overload;
    function Login(AValue: string): TModelFuncionariosEntitie; overload;
    function Login: string; overload;
    function NomeFantasia(AValue: string): TModelFuncionariosEntitie; overload;
    function NomeFantasia: string; overload;
    function Numero(AValue: string): TModelFuncionariosEntitie; overload;
    function Numero: string; overload;
    function RazaoSocial(AValue: string): TModelFuncionariosEntitie; overload;
    function RazaoSocial: string; overload;
    function RG(AValue: string): TModelFuncionariosEntitie; overload;
    function RG: string; overload;
    function RgOrgaoExpedidor(AValue: string): TModelFuncionariosEntitie; overload;
    function RgOrgaoExpedidor: string; overload;
    function Salario(AValue: string): TModelFuncionariosEntitie; overload;
    function Salario(AValue: Double): TModelFuncionariosEntitie; overload;
    function Salario: Double; overload;
    function Senha(AValue: string): TModelFuncionariosEntitie; overload;
    function Senha: string; overload;
    function Status(AValue: string): TModelFuncionariosEntitie; overload;
    function Status: string; overload;
    function Telefone(AValue: string): TModelFuncionariosEntitie; overload;
    function Telefone: string; overload;
    function TelefoneMascara: string;
    function Telefone2(AValue: string): TModelFuncionariosEntitie; overload;
    function Telefone2: string; overload;
    function Telefone2Mascara: string;
    function TipoJuridico(AValue: string): TModelFuncionariosEntitie; overload;
    function TipoJuridico: string; overload;
    function TipoJuridicoComboBox: Integer;
  end;

implementation

uses
  Utils.MyConsts,
  Utils.MyLibrary,
  Utils.GlobalConsts;

constructor TModelFuncionariosEntitie.Create(AParent: IModelFuncionariosFactory<TModelFuncionariosEntitie>);
begin
   FParent       := AParent;
   FStatus       := STATUS_ATIVO;
   FTipoJuridico := PESSOA_FISICA;
end;

destructor TModelFuncionariosEntitie.Destroy;
begin
   inherited;
end;

function TModelFuncionariosEntitie.End_Entitie: IModelFuncionariosFactory<TModelFuncionariosEntitie>;
begin
   Result := FParent;
end;

function TModelFuncionariosEntitie.Bairro(AValue: string): TModelFuncionariosEntitie;
begin
   Result  := Self;
   FBairro := AValue.Trim;
end;

function TModelFuncionariosEntitie.Bairro: string;
begin
   Result := FBairro;
end;

function TModelFuncionariosEntitie.Celular(AValue: string): TModelFuncionariosEntitie;
begin
   Result   := Self;
   FCelular := TMyLibrary.NumbersOnly(AValue.Trim);
end;

function TModelFuncionariosEntitie.Celular: string;
begin
   Result := FCelular;
end;

function TModelFuncionariosEntitie.CelularMascara: string;
begin
   Result := TMyLibrary.ArrangeFone(Self.Celular);
end;

function TModelFuncionariosEntitie.Cep(AValue: string): TModelFuncionariosEntitie;
begin
   Result := Self;
   FCep   := TMyLibrary.NumbersOnly(AValue.Trim);
end;

function TModelFuncionariosEntitie.Cep: string;
begin
   Result := FCep;
end;

function TModelFuncionariosEntitie.CepMascara: string;
begin
   Result := TMyLibrary.ArrangeCEP(Self.Cep);
end;

function TModelFuncionariosEntitie.Cidade(AValue: string): TModelFuncionariosEntitie;
begin
   Result := Self;
   Self.Cidade(TMyLibrary.StrToIntDef(AValue.Trim));
end;

function TModelFuncionariosEntitie.Cidade(AValue: Integer): TModelFuncionariosEntitie;
begin
   Result  := Self;
   FCidade := AValue;
end;

function TModelFuncionariosEntitie.Cidade: Integer;
begin
   Result := FCidade;
end;

function TModelFuncionariosEntitie.CidadeMascara: string;
begin
   Result := EmptyStr;
   if(Self.Cidade > 0)then
     Result := TMyLibrary.CompLeft(Self.Cidade);
end;

function TModelFuncionariosEntitie.Cnpj(AValue: string): TModelFuncionariosEntitie;
begin
   Result := Self;
   FCnpj  := TMyLibrary.NumbersOnly(AValue.Trim);
end;

function TModelFuncionariosEntitie.Cnpj: string;
begin
   Result := FCnpj;
end;

function TModelFuncionariosEntitie.CnpjMascara: string;
begin
   Result := TMyLibrary.ArrangeCNPJ(Self.Cnpj);
end;

function TModelFuncionariosEntitie.Cpf(AValue: string): TModelFuncionariosEntitie;
begin
   Result := Self;
   FCpf   := TMyLibrary.NumbersOnly(AValue.Trim);
end;

function TModelFuncionariosEntitie.Cpf: string;
begin
   Result := FCpf;
end;

function TModelFuncionariosEntitie.CpfMascara: string;
begin
   Result := TMyLibrary.ArrangeCPF(Self.Cpf);
end;

function TModelFuncionariosEntitie.DataCadastro(AValue: string): TModelFuncionariosEntitie;
begin
   Result := Self;
   Self.DataCadastro(StrToDate(AValue.Trim));
end;

function TModelFuncionariosEntitie.DataCadastro(AValue: TDateTime): TModelFuncionariosEntitie;
begin
   Result        := Self;
   FDataCadastro := AValue;
end;

function TModelFuncionariosEntitie.DataCadastro: TDateTime;
begin
   Result := FDataCadastro;
end;

function TModelFuncionariosEntitie.DataNascimento(AValue: string): TModelFuncionariosEntitie;
begin
   Result := Self;
   Self.DataNascimento(StrToDate(AValue.Trim));
end;

function TModelFuncionariosEntitie.DataNascimento(AValue: TDateTime): TModelFuncionariosEntitie;
begin
   Result          := Self;
   FDataNascimento := AValue;
end;

function TModelFuncionariosEntitie.DataNascimento: TDateTime;
begin
   Result := FDataNascimento;
end;

function TModelFuncionariosEntitie.Email(AValue: string): TModelFuncionariosEntitie;
begin
   Result := Self;
   FEmail := AValue.Trim;
end;

function TModelFuncionariosEntitie.Email: string;
begin
   Result := FEmail;
end;

function TModelFuncionariosEntitie.Endereco(AValue: string): TModelFuncionariosEntitie;
begin
   Result    := Self;
   FEndereco := AValue.Trim;
end;

function TModelFuncionariosEntitie.Endereco: string;
begin
   Result := FEndereco;
end;

function TModelFuncionariosEntitie.Fax(AValue: string): TModelFuncionariosEntitie;
begin
   Result := Self;
   FFax   := TMyLibrary.NumbersOnly(AValue.Trim);
end;

function TModelFuncionariosEntitie.Fax: string;
begin
   Result := FFax;
end;

function TModelFuncionariosEntitie.FaxMascara: string;
begin
   Result := TMyLibrary.ArrangeFone(Self.Fax);
end;

function TModelFuncionariosEntitie.Funcao(AValue: string): TModelFuncionariosEntitie;
begin
   Result := Self;
   Self.Funcao(TMyLibrary.StrToIntDef(AValue.Trim));
end;

function TModelFuncionariosEntitie.Funcao(AValue: Integer): TModelFuncionariosEntitie;
begin
   Result  := Self;
   FFuncao := AValue;
end;

function TModelFuncionariosEntitie.Funcao: Integer;
begin
   Result := FFuncao;
end;

function TModelFuncionariosEntitie.FuncaoMascara: string;
begin
   Result := EmptyStr;
   if(Self.Funcao > 0)then
     Result := TMyLibrary.CompLeft(Self.Funcao);
end;

function TModelFuncionariosEntitie.GrupoPermissao(AValue: string): TModelFuncionariosEntitie;
begin
   Result := Self;
   Self.GrupoPermissao(TMyLibrary.StrToIntDef(AValue.Trim));
end;

function TModelFuncionariosEntitie.GrupoPermissao(AValue: Integer): TModelFuncionariosEntitie;
begin
   Result          := Self;
   FGrupoPermissao := AValue;
end;

function TModelFuncionariosEntitie.GrupoPermissao: Integer;
begin
   Result := FGrupoPermissao;
end;

function TModelFuncionariosEntitie.GrupoPermissaoMascara: string;
begin
   Result := EmptyStr;
   if(Self.GrupoPermissao > 0)then
     Result := TMyLibrary.CompLeft(Self.GrupoPermissao);
end;

function TModelFuncionariosEntitie.Id(AValue: string): TModelFuncionariosEntitie;
begin
   Result := Self;
   Self.Id(TMyLibrary.StrToIntDef(AValue.Trim));
end;

function TModelFuncionariosEntitie.Id(AValue: Integer): TModelFuncionariosEntitie;
begin
   Result := Self;
   FId    := AValue;
end;

function TModelFuncionariosEntitie.Id: Integer;
begin
   Result := FId;
end;

function TModelFuncionariosEntitie.IdMascara: string;
begin
   Result := EmptyStr;
   if(Self.Id > 0)then
     Result := TMyLibrary.CompLeft(Self.Id);
end;

function TModelFuncionariosEntitie.IdNome: string;
begin
   Result := Self.NomeFantasia;
   if(Result.IsEmpty)then
     Result := Self.RazaoSocial;

   if(not Result.IsEmpty)then
     Result := Self.IdMascara + ' - ' + Result;
end;

function TModelFuncionariosEntitie.IE(AValue: string): TModelFuncionariosEntitie;
begin
   Result := Self;
   FIE    := TMyLibrary.NumbersOnly(AValue.Trim);
end;

function TModelFuncionariosEntitie.IE: string;
begin
   Result := FIE;
end;

function TModelFuncionariosEntitie.Login(AValue: string): TModelFuncionariosEntitie;
begin
   Result := Self;
   FLogin := AValue.Trim;
end;

function TModelFuncionariosEntitie.Login: string;
begin
   Result := FLogin;
end;

function TModelFuncionariosEntitie.NomeFantasia(AValue: string): TModelFuncionariosEntitie;
begin
   Result        := Self;
   FNomeFantasia := AValue.Trim;
end;

function TModelFuncionariosEntitie.NomeFantasia: string;
begin
   Result := FNomeFantasia;
end;

function TModelFuncionariosEntitie.Numero(AValue: string): TModelFuncionariosEntitie;
begin
   Result  := Self;
   FNumero := AValue.Trim;
end;

function TModelFuncionariosEntitie.Numero: string;
begin
   Result := FNumero;
end;

function TModelFuncionariosEntitie.RazaoSocial(AValue: string): TModelFuncionariosEntitie;
begin
   Result       := Self;
   FRazaoSocial := AValue.Trim;
end;

function TModelFuncionariosEntitie.RazaoSocial: string;
begin
   Result := FRazaoSocial;
end;

function TModelFuncionariosEntitie.RG(AValue: string): TModelFuncionariosEntitie;
begin
   Result := Self;
   FRG    := TMyLibrary.NumbersOnly(AValue.Trim);
end;

function TModelFuncionariosEntitie.RG: string;
begin
   Result := FRG;
end;

function TModelFuncionariosEntitie.RgOrgaoExpedidor(AValue: string): TModelFuncionariosEntitie;
begin
   Result            := Self;
   FRgOrgaoExpedidor := AValue.Trim;
end;

function TModelFuncionariosEntitie.RgOrgaoExpedidor: string;
begin
   Result := FRgOrgaoExpedidor;
end;

function TModelFuncionariosEntitie.Salario(AValue: string): TModelFuncionariosEntitie;
begin
   Result := Self;
   Self.Salario(TMyLibrary.StrToFloatDef(AValue.Trim));
end;

function TModelFuncionariosEntitie.Salario(AValue: Double): TModelFuncionariosEntitie;
begin
   Result   := Self;
   FSalario := AValue;
end;

function TModelFuncionariosEntitie.Salario: Double;
begin
   Result := FSalario;
end;

function TModelFuncionariosEntitie.Senha(AValue: string): TModelFuncionariosEntitie;
begin
   Result := Self;
   FSenha := AValue.Trim;
end;

function TModelFuncionariosEntitie.Senha: string;
begin
   Result := FSenha;
end;

function TModelFuncionariosEntitie.Status(AValue: string): TModelFuncionariosEntitie;
begin
   Result  := Self;
   FStatus := AValue.Trim;
end;

function TModelFuncionariosEntitie.Status: string;
begin
   Result := FStatus;
end;

function TModelFuncionariosEntitie.Telefone(AValue: string): TModelFuncionariosEntitie;
begin
   Result    := Self;
   FTelefone := TMyLibrary.NumbersOnly(AValue.Trim);
end;

function TModelFuncionariosEntitie.Telefone: string;
begin
   Result := FTelefone;
end;

function TModelFuncionariosEntitie.TelefoneMascara: string;
begin
   Result := TMyLibrary.ArrangeFone(Self.Telefone);
end;

function TModelFuncionariosEntitie.Telefone2(AValue: string): TModelFuncionariosEntitie;
begin
   Result     := Self;
   FTelefone2 := TMyLibrary.NumbersOnly(AValue.Trim);
end;

function TModelFuncionariosEntitie.Telefone2: string;
begin
   Result := FTelefone2;
end;

function TModelFuncionariosEntitie.Telefone2Mascara: string;
begin
   Result := TMyLibrary.ArrangeFone(Self.Telefone2);
end;

function TModelFuncionariosEntitie.TipoJuridico(AValue: string): TModelFuncionariosEntitie;
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

function TModelFuncionariosEntitie.TipoJuridico: string;
begin
   Result := FTipoJuridico;
end;

function TModelFuncionariosEntitie.TipoJuridicoComboBox: Integer;
begin
   Result := -1;
   if(Self.TipoJuridico.Equals(PESSOA_FISICA_DATABASE))then
     Result := 0
   else if(Self.TipoJuridico.Equals(PESSOA_JURIDICA_DATABASE))then
     Result := 1;
end;

end.
