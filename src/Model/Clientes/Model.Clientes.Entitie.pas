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
    FCep: Integer;
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
    function Cep(AValue: string): TModelClientesEntitie; overload;
    function Cep(AValue: Integer): TModelClientesEntitie; overload;
    function Cep: Integer; overload;   
    function Cidade(AValue: string): TModelClientesEntitie; overload;
    function Cidade(AValue: Integer): TModelClientesEntitie; overload;
    function Cidade: Integer; overload;
    function Cnpj(AValue: string): TModelClientesEntitie; overload;
    function Cnpj: string; overload;
    function Cpf(AValue: string): TModelClientesEntitie; overload;
    function Cpf: string; overload;
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
    function Telefone2(AValue: string): TModelClientesEntitie; overload;
    function Telefone2: string; overload;
    function TipoJuridico(AValue: string): TModelClientesEntitie; overload;
    function TipoJuridico: string; overload;
  end;

implementation

uses
  Utils.GlobalConsts;

constructor TModelClientesEntitie.Create(AParent: IModelClientesFactory<TModelClientesEntitie>);
begin
   FParent        := AParent;
   FStatusCliente := STATUS_PADRAO;
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
   FCelular := AValue.Trim;
end;

function TModelClientesEntitie.Celular: string;
begin
   Result := FCelular;
end;

function TModelClientesEntitie.Cep(AValue: string): TModelClientesEntitie;
begin
   Result := Self;
   Self.Cep(StrToInt(AValue.Trim));
end;

function TModelClientesEntitie.Cep(AValue: Integer): TModelClientesEntitie;
begin
   Result := Self;
   FCep   := AValue;
end;

function TModelClientesEntitie.Cep: Integer;
begin
   Result := FCep;
end;

function TModelClientesEntitie.Cidade(AValue: string): TModelClientesEntitie;
begin
   Result := Self;
   Self.Cidade(StrToInt(AValue.Trim));
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
   FCnpj  := AValue.Trim;
end;

function TModelClientesEntitie.Cnpj: string;
begin
   Result := FCnpj;
end;

function TModelClientesEntitie.Cpf(AValue: string): TModelClientesEntitie;
begin
   Result := Self;
   FCpf   := AValue.Trim;
end;

function TModelClientesEntitie.Cpf: string;
begin
   Result := FCpf;
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
   FFax   := AValue.Trim;
end;

function TModelClientesEntitie.Fax: string;
begin
   Result := FFax;
end;

function TModelClientesEntitie.Id(AValue: string): TModelClientesEntitie;
begin
   Result := Self;
   Self.Id(StrToInt(AValue.Trim));
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
   FIE    := AValue.Trim;
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
   FRG    := AValue.Trim;
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
   FTelefone := AValue.Trim;
end;

function TModelClientesEntitie.Telefone: string;
begin
   Result := FTelefone;
end;

function TModelClientesEntitie.Telefone2(AValue: string): TModelClientesEntitie;
begin
   Result     := Self;
   FTelefone2 := AValue.Trim;
end;

function TModelClientesEntitie.Telefone2: string;
begin
   Result := FTelefone2;
end;

function TModelClientesEntitie.TipoJuridico(AValue: string): TModelClientesEntitie;
begin
   Result        := Self;
   FTipoJuridico := AValue.Trim;
end;

function TModelClientesEntitie.TipoJuridico: string;
begin
   Result := FTipoJuridico;
end;

end.
