unit Model.Clientes.Factory;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Model.Clientes.Interfaces,
  Model.Clientes.Entitie;

type
  TModelClientesFactory = class(TInterfacedObject, IModelClientesFactory<TModelClientesEntitie>)
  private
    FEntitie: TModelClientesEntitie;
    procedure UpdateClient;
    procedure InsertClient;

    procedure ValidarCampos;
  protected
    function Entitie: TModelClientesEntitie;
    procedure ValidarCPF;
    procedure ValidarCNPJ;
    function Gravar: IModelClientesFactory<TModelClientesEntitie>;
    function Deletar: IModelClientesFactory<TModelClientesEntitie>;
  public
    class function New: IModelClientesFactory<TModelClientesEntitie>;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  MyConnection,
  MyExceptions,
  Utils.GlobalConsts;

class function TModelClientesFactory.New: IModelClientesFactory<TModelClientesEntitie>;
begin
   Result := Self.Create;
end;

constructor TModelClientesFactory.Create;
begin
   FEntitie := TModelClientesEntitie.Create(Self);
end;

destructor TModelClientesFactory.Destroy;
begin
   if(Assigned(FEntitie))then
     FEntitie.Free;
   inherited;
end;

procedure TModelClientesFactory.ValidarCampos;
begin
   Self.ValidarCNPJ;
   Self.ValidarCPF;

   if(not (FEntitie.Cidade > 0))then
     raise ExceptionRequired.Create('Cidade não informada');
end;

procedure TModelClientesFactory.ValidarCNPJ;
begin
   if(FEntitie.Cnpj = EmptyStr)then
     Exit;

   if(Length(FEntitie.Cnpj) = 14)then
     Exit;

   raise ExceptionWarning.Create('CNPJ inválido');
end;

procedure TModelClientesFactory.ValidarCPF;
begin
   if(FEntitie.Cpf = EmptyStr)then
     Exit;

   if(Length(FEntitie.Cpf) = 11)then
     Exit;

   raise ExceptionWarning.Create('CPF inválido');
end;

function TModelClientesFactory.Entitie: TModelClientesEntitie;
begin
   Result := FEntitie;
end;

function TModelClientesFactory.Gravar: IModelClientesFactory<TModelClientesEntitie>;
begin
   Result := Self;

   if(FEntitie.Id = 1)then
     raise ExceptionWarning.Create('Cliente padrão do sistema bloqueado para alterações');

   Self.ValidarCampos;

   if(FEntitie.Id > 0)then
     Self.UpdateClient
   else
     Self.InsertClient;

   MyQuery
    .AddParam('RAZAO_SOCIAL', FEntitie.RazaoSocial)
    .AddParam('NOME_FANTASIA', FEntitie.NomeFantasia)
    .AddParam('ENDERECO', FEntitie.Endereco)
    .AddParam('NUMERO', FEntitie.Numero)
    .AddParam('BAIRRO', FEntitie.Bairro)
    .AddParam('CEP', FEntitie.Cep)
    .AddParam('CIDADE', FEntitie.Cidade)
    .AddParam('DATA_NASCIMENTO', FEntitie.DataNascimento)
    .AddParam('TELEFONE', FEntitie.Telefone)
    .AddParam('TELEFONE2', FEntitie.Telefone2)
    .AddParam('CELULAR', FEntitie.Celular)
    .AddParam('FAX', FEntitie.Fax)
    .AddParam('EMAIL', FEntitie.Email)
    .AddParam('TIPO_JURIDICO', FEntitie.TipoJuridico)
    .AddParam('CNPJ', FEntitie.Cnpj)
    .AddParam('INSCRICAO_ESTADUAL', FEntitie.IE)
    .AddParam('CPF', FEntitie.Cpf)
    .AddParam('RG', FEntitie.RG)
    .AddParam('RG_ORGAO_EXPEDIDOR', FEntitie.RgOrgaoExpedidor);

   try
     MyQuery.ExecSQL;
   except on E: Exception do
   begin
      if(MyQuery.ExceptionZeroRecordsUpdated)then
        Exit;

      raise ExceptionError.Create(E.Message);
   end;
   end;
end;

procedure TModelClientesFactory.UpdateClient;
begin
   MyQueryNew
    .Add('UPDATE CLIENTES SET')
    .Add('RAZAO_SOCIAL = :RAZAO_SOCIAL, NOME_FANTASIA = :NOME_FANTASIA, ENDERECO = :ENDERECO, NUMERO = :NUMERO, BAIRRO = :BAIRRO, ')
    .Add('CEP = :CEP, CIDADE = :CIDADE, DATA_NASCIMENTO = :DATA_NASCIMENTO, TELEFONE = :TELEFONE, TELEFONE2 = :TELEFONE2, ')
    .Add('CELULAR = :CELULAR, FAX = :FAX, EMAIL = :EMAIL, TIPO_JURIDICO = :TIPO_JURIDICO, CNPJ = :CNPJ, INSCRICAO_ESTADUAL = :INSCRICAO_ESTADUAL, ')
    .Add('CPF = :CPF, RG = :RG, RG_ORGAO_EXPEDIDOR = :RG_ORGAO_EXPEDIDOR')
    .Add('WHERE(CLIENTES.ID = :ID)')
    .AddParam('ID', FEntitie.Id);
end;

procedure TModelClientesFactory.InsertClient;
begin
   MyQueryNew
    .Add('INSERT INTO CLIENTES ')
    .Add('(STATUS, RAZAO_SOCIAL, NOME_FANTASIA, ENDERECO, NUMERO, BAIRRO, CEP, CIDADE, DATA_NASCIMENTO, TELEFONE, TELEFONE2, CELULAR, FAX,')
    .Add('EMAIL, TIPO_JURIDICO, CNPJ, INSCRICAO_ESTADUAL, CPF, RG, RG_ORGAO_EXPEDIDOR, DATA_CADASTRO)')
    .Add('VALUES')
    .Add('("'+ STATUS_ATIVO +'", :RAZAO_SOCIAL, :NOME_FANTASIA, :ENDERECO, :NUMERO, :BAIRRO, :CEP, :CIDADE, :DATA_NASCIMENTO, :TELEFONE, :TELEFONE2, :CELULAR, :FAX,')
    .Add(':EMAIL, :TIPO_JURIDICO, :CNPJ, :INSCRICAO_ESTADUAL, :CPF, :RG, :RG_ORGAO_EXPEDIDOR, :DATA_CADASTRO)')
    .AddParam('DATA_CADASTRO', Now);
end;

function TModelClientesFactory.Deletar: IModelClientesFactory<TModelClientesEntitie>;
begin
   Result := Self;

   if(not (FEntitie.Id > 0))then
     Exit;

   if(FEntitie.Id = 1)then
     raise ExceptionWarning.Create('Cliente padrão do sistema não pode ser excluído');

   MyQueryNew
    .Add('DELETE FROM CLIENTES ')
    .Add('WHERE(CLIENTES.ID = :ID)')
    .AddParam('ID', FEntitie.Id)
    .ExecSQL;
end;

end.
