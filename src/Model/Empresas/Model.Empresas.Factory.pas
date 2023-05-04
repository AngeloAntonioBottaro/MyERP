unit Model.Empresas.Factory;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Model.Empresas.Interfaces,
  Model.Empresas.Entitie;

const
  THIS   = 'Empresa';
  TABELA = 'EMPRESAS';

type
  TModelEmpresasFactory = class(TInterfacedObject, IModelEmpresasFactory<TModelEmpresasEntitie>)
  private
    FEntitie: TModelEmpresasEntitie;
    FTelaOrigem: string;
    procedure SQLInsert;
    procedure SQLUpdate;
    procedure ValidarCampos;
  protected
    function Entitie: TModelEmpresasEntitie;

    procedure ValidarCPF;
    procedure ValidarCNPJ;
    procedure ValidarEmail;

    function ConsultarEntitie: IModelEmpresasFactory<TModelEmpresasEntitie>;
    function Gravar: IModelEmpresasFactory<TModelEmpresasEntitie>;
  public
    class function New(ATelaOrigem: string): IModelEmpresasFactory<TModelEmpresasEntitie>;
    constructor Create(ATelaOrigem: string);
    destructor Destroy; override;
  end;

implementation

uses
  MyConnection,
  MyMessage,
  MyExceptions,
  Utils.MyLibrary,
  Utils.LibrarySistema,
  Utils.GlobalConsts,
  Model.Logs;

class function TModelEmpresasFactory.New(ATelaOrigem: string): IModelEmpresasFactory<TModelEmpresasEntitie>;
begin
   if(ATelaOrigem.Trim.IsEmpty)then
     raise ExceptionRequired.Create('Tela de origem da factory empresa necessária');

   Result := Self.Create(ATelaOrigem);
end;

constructor TModelEmpresasFactory.Create(ATelaOrigem: string);
begin
   FTelaOrigem := ATelaOrigem;
   FEntitie    := TModelEmpresasEntitie.Create(Self);
end;

destructor TModelEmpresasFactory.Destroy;
begin
   if(Assigned(FEntitie))then
     FEntitie.Free;
   inherited;
end;

function TModelEmpresasFactory.Entitie: TModelEmpresasEntitie;
begin
   Result := FEntitie;
end;

procedure TModelEmpresasFactory.ValidarCampos;
begin
   if((FEntitie.RazaoSocial = EmptyStr))then
     raise ExceptionRequired.Create('Razão social da empresa é obrigatório');

   if((FEntitie.NomeFantasia = EmptyStr))then
     raise ExceptionRequired.Create('Fantasia da empresa é obrigatório');

   if((FEntitie.Cnpj = EmptyStr) and (FEntitie.Cpf = EmptyStr))then
     raise ExceptionRequired.Create('CNPJ/CPF da empresa é obrigatório');

   Self.ValidarCNPJ;
   Self.ValidarCPF;

   if(not (FEntitie.Cidade > 0))then
     raise ExceptionRequired.Create('Cidade não informada');
end;

procedure TModelEmpresasFactory.ValidarCNPJ;
begin
   if(FEntitie.Cnpj = EmptyStr)then
     Exit;

   if(TMyLibrary.IdentifyCNPJ(FEntitie.Cnpj))then
   begin
      if(TMyLibrary.ValidateCNPJ(FEntitie.Cnpj))then
        Exit;
   end;

   raise ExceptionWarning.Create('CNPJ inválido');
end;

procedure TModelEmpresasFactory.ValidarCPF;
begin
   if(FEntitie.Cpf = EmptyStr)then
     Exit;

   if(TMyLibrary.IdentifyCPF(FEntitie.Cpf))then
   begin
      if(TMyLibrary.ValidateCPF(FEntitie.Cpf))then
        Exit;
   end;

   raise ExceptionWarning.Create('CPF inválido');
end;

procedure TModelEmpresasFactory.ValidarEmail;
begin
   if(FEntitie.Email = EmptyStr)then
     Exit;

   if(TMyLibrary.ValidateEmail(FEntitie.Email))then
     Exit;

   raise ExceptionWarning.Create('E-mail inválido/incorreto');
end;

function TModelEmpresasFactory.ConsultarEntitie: IModelEmpresasFactory<TModelEmpresasEntitie>;
begin
   MyQueryNew
    .Add('SELECT FIRST 1 * FROM ' + TABELA);

   try
     ShowDebug(MyQuery.SQL.Text);
     MyQuery.Open;
   except on E: Exception do
   begin
      if(not MyQuery.ExceptionZeroRecordsUpdated)then
        raise ExceptionError.Create('Não foi possível consultar a empresa',
                                    'Mensagem: ' + E.Message);
   end;
   end;

   FEntitie
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
    .ServidorHash(MyQuery.FieldByName('SERVIDOR_HASH').AsString)
    .End_Entitie;
end;

function TModelEmpresasFactory.Gravar: IModelEmpresasFactory<TModelEmpresasEntitie>;
var
  LAcao: string;
begin
   Result := Self;

   Self.ValidarCampos;

   if(FEntitie.Id > 0)then
     Self.SQLUpdate
   else
     Self.SQLInsert;

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
    .AddParam('RG_ORGAO_EXPEDIDOR', FEntitie.RgOrgaoExpedidor)
    .AddParam('DATA_CADASTRO', Now);

   try
     ShowDebug(MyQuery.SQL.Text);
     if(FEntitie.Id > 0)then
     begin
        LAcao := 'Alteração';
        MyQuery.ExecSQL;
     end
     else
     begin
        LAcao := 'Cadastro';
        MyQuery.Open;
        FEntitie.Id(MyQuery.FieldByName('ID').AsInteger);
     end;
   except on E: Exception do
   begin
      if(not MyQuery.ExceptionZeroRecordsUpdated)then
        raise ExceptionError.Create('Não foi possível gravar a empresa',
                                    'Mensagem: ' + E.Message);
   end;
   end;

   TModelLogs.New.Gravar(FTelaOrigem,
                         LAcao + ' de empresa',
                         'Usuário gravou a empresa ' + FEntitie.IdNome,
                         FEntitie.Id);

   ShowDone('Gravação realizada');
end;

procedure TModelEmpresasFactory.SQLInsert;
begin
   MyQueryNew
    .Add('INSERT INTO '+TABELA)
    .Add('(RAZAO_SOCIAL, NOME_FANTASIA, ENDERECO, NUMERO, BAIRRO, CEP, CIDADE, DATA_NASCIMENTO, TELEFONE, TELEFONE2, CELULAR, FAX,')
    .Add('EMAIL, TIPO_JURIDICO, CNPJ, INSCRICAO_ESTADUAL, CPF, RG, RG_ORGAO_EXPEDIDOR, DATA_CADASTRO)')
    .Add('VALUES')
    .Add('(:RAZAO_SOCIAL, :NOME_FANTASIA, :ENDERECO, :NUMERO, :BAIRRO, :CEP, :CIDADE, :DATA_NASCIMENTO, :TELEFONE, :TELEFONE2, :CELULAR, :FAX,')
    .Add(':EMAIL, :TIPO_JURIDICO, :CNPJ, :INSCRICAO_ESTADUAL, :CPF, :RG, :RG_ORGAO_EXPEDIDOR, :DATA_CADASTRO)')
    .Add('RETURNING ID');
end;

procedure TModelEmpresasFactory.SQLUpdate;
begin
   MyQueryNew
    .Add('UPDATE '+TABELA+' SET')
    .Add('RAZAO_SOCIAL = :RAZAO_SOCIAL, NOME_FANTASIA = :NOME_FANTASIA, ENDERECO = :ENDERECO, NUMERO = :NUMERO, BAIRRO = :BAIRRO, ')
    .Add('CEP = :CEP, CIDADE = :CIDADE, DATA_NASCIMENTO = :DATA_NASCIMENTO, TELEFONE = :TELEFONE, TELEFONE2 = :TELEFONE2, ')
    .Add('CELULAR = :CELULAR, FAX = :FAX, EMAIL = :EMAIL, TIPO_JURIDICO = :TIPO_JURIDICO, CNPJ = :CNPJ, INSCRICAO_ESTADUAL = :INSCRICAO_ESTADUAL, ')
    .Add('CPF = :CPF, RG = :RG, RG_ORGAO_EXPEDIDOR = :RG_ORGAO_EXPEDIDOR, DATA_CADASTRO = :DATA_CADASTRO')
    .Add('WHERE('+TABELA+'.ID = :ID)')
    .AddParam('ID', FEntitie.Id);
end;

end.
