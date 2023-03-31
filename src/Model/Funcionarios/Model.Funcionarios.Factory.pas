unit Model.Funcionarios.Factory;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Model.Funcionarios.Interfaces,
  Model.Funcionarios.Entitie;

const
  THIS = 'Funcionário';
  TABELA = 'FUNCIONARIOS';

type
  TModelFuncionariosFactory = class(TInterfacedObject, IModelFuncionariosFactory<TModelFuncionariosEntitie>)
  private
    FEntitie: TModelFuncionariosEntitie;
    procedure SQLInsert;
    procedure SQLUpdate;
    procedure ValidarCampos;
    procedure ValidarLoginSenha;
  protected
    function Entitie: TModelFuncionariosEntitie;

    procedure ValidarCPF;
    procedure ValidarCNPJ;
    procedure ValidarEmail;

    function AlterarStatus: IModelFuncionariosFactory<TModelFuncionariosEntitie>;
    function ConsultarEntitie: IModelFuncionariosFactory<TModelFuncionariosEntitie>;
    function Deletar: IModelFuncionariosFactory<TModelFuncionariosEntitie>;
    function Gravar: IModelFuncionariosFactory<TModelFuncionariosEntitie>;
  public
    class function New: IModelFuncionariosFactory<TModelFuncionariosEntitie>;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  MyConnection,
  MyMessage,
  MyExceptions,
  Utils.MyLibrary,
  Utils.LibrarySistema,
  Utils.GlobalConsts;

class function TModelFuncionariosFactory.New: IModelFuncionariosFactory<TModelFuncionariosEntitie>;
begin
   Result := Self.Create;
end;

constructor TModelFuncionariosFactory.Create;
begin
   FEntitie := TModelFuncionariosEntitie.Create(Self);
end;

destructor TModelFuncionariosFactory.Destroy;
begin
   if(Assigned(FEntitie))then
     FEntitie.Free;
   inherited;
end;

function TModelFuncionariosFactory.Entitie: TModelFuncionariosEntitie;
begin
   Result := FEntitie;
end;

procedure TModelFuncionariosFactory.ValidarCampos;
begin
   if((FEntitie.RazaoSocial = EmptyStr) and (FEntitie.NomeFantasia = EmptyStr))then
     raise ExceptionRequired.Create('Razão social é obrigatório');

   Self.ValidarCNPJ;
   Self.ValidarCPF;

   if(not (FEntitie.Cidade > 0))then
     raise ExceptionRequired.Create('Cidade não informada');

   if(not (FEntitie.Funcao > 0))then
     raise ExceptionRequired.Create('Função não informada');

   Self.ValidarLoginSenha;
end;

procedure TModelFuncionariosFactory.ValidarCNPJ;
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

procedure TModelFuncionariosFactory.ValidarCPF;
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

procedure TModelFuncionariosFactory.ValidarEmail;
begin
   if(FEntitie.Email = EmptyStr)then
     Exit;

   if(TMyLibrary.ValidateEmail(FEntitie.Email))then
     Exit;

   raise ExceptionWarning.Create('E-mail inválido/incorreto');
end;

procedure TModelFuncionariosFactory.ValidarLoginSenha;
begin
   if(FEntitie.Login().IsEmpty and FEntitie.Senha().IsEmpty)then
     Exit;

   if(FEntitie.Login().IsEmpty)then
     raise ExceptionRequired.Create('Campo login obrigatório');

   if(FEntitie.Senha().IsEmpty)then
     raise ExceptionRequired.Create('Campo senha obrigatório');

   MyQueryNew
    .Add('SELECT FIRST 1 LOGIN, SENHA FROM ' + TABELA)
    .Add('WHERE (LOGIN = :LOGIN) AND (SENHA = :SENHA)')
    .AddParam('LOGIN', FEntitie.Login)
    .AddParam('SENHA', FEntitie.Senha);

   if(FEntitie.Id > 0)then
     MyQuery.Add('AND( '+TABELA+'.ID <> :ID )').AddParam('ID', FEntitie.Id);

   try
     ShowDebug(MyQuery.SQL.Text);
     MyQuery.Open;
   except on E: Exception do
   begin
      if(not MyQuery.ExceptionZeroRecordsUpdated)then
        raise ExceptionError.Create('Não foi possível consultar os logins e senhas cadastrados',
                                    THIS + ': ' + FEntitie.IdMascara + sLineBreak +
                                    'Mensagem: ' + E.Message);
   end;
   end;

   if(not MyQuery.IsEmpty)then
     raise ExceptionWarning.Create('Senha não pode ser utilizada');
end;

function TModelFuncionariosFactory.AlterarStatus: IModelFuncionariosFactory<TModelFuncionariosEntitie>;
var
  LStatusNovo: string;
begin
   Result := Self;

   if(not (FEntitie.Id > 0))then
     ExceptionMsgRegistroNaoInformadoAlteracaoStatus(THIS);

   if(FEntitie.Id = 1)then
     raise ExceptionWarning.Create('Funcionário padrão do sistema não pode ser inativado');

   MyQueryNew
    .Add('SELECT STATUS FROM ' + TABELA)
    .Add('WHERE('+TABELA+'.ID = :ID)')
    .AddParam('ID', FEntitie.Id)
    .Open;

   LStatusNovo := STATUS_ATIVO;
   if(MyQuery.FieldByName('STATUS').AsString.Equals(STATUS_ATIVO))then
     LStatusNovo := STATUS_INATIVO;

   MyQueryNew
    .Add('UPDATE '+TABELA+' SET STATUS = :STATUS')
    .Add('WHERE('+TABELA+'.ID = :ID)')
    .AddParam('ID', FEntitie.Id)
    .AddParam('STATUS', LStatusNovo);

   try
     ShowDebug(MyQuery.SQL.Text);
     MyQuery.ExecSQL;
   except on E: Exception do
   begin
      if(not MyQuery.ExceptionZeroRecordsUpdated)then
        raise ExceptionError.Create('Não foi possível alterar o status do funcionário',
                                    THIS + ': ' + FEntitie.IdMascara + sLineBreak +
                                    'Mensagem: ' + E.Message);
   end;
   end;

   ShowDone(THIS + IfThen(LStatusNovo.Equals(STATUS_ATIVO), ' ativado', ' inativado'));
end;

function TModelFuncionariosFactory.ConsultarEntitie: IModelFuncionariosFactory<TModelFuncionariosEntitie>;
begin
   if(not (FEntitie.Id > 0))then
     ExceptionMsgRegistroNaoInformadoConsulta(THIS);

   MyQueryNew
    .Add('SELECT * FROM '+TABELA+' WHERE('+TABELA+'.ID = :ID)')
    .AddParam('ID', FEntitie.Id);

   try
     ShowDebug(MyQuery.SQL.Text);
     MyQuery.Open;
   except on E: Exception do
   begin
      if(not MyQuery.ExceptionZeroRecordsUpdated)then
        raise ExceptionError.Create('Não foi possível consultar o cliente',
                                    THIS + ': ' + FEntitie.IdMascara + sLineBreak +
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
    .Funcao(MyQuery.FieldByName('FUNCAO').AsInteger)
    .Salario(MyQuery.FieldByName('SALARIO').AsFloat)
    .Login(MyQuery.FieldByName('LOGIN').AsString)
    .Senha(MyQuery.FieldByName('SENHA').AsString)
    .End_Entitie;
end;

function TModelFuncionariosFactory.Deletar: IModelFuncionariosFactory<TModelFuncionariosEntitie>;
begin
   Result := Self;

   if(not (FEntitie.Id > 0))then
     ExceptionMsgRegistroNaoInformadoExclusao(THIS);

   if(FEntitie.Id = 1)then
     raise ExceptionWarning.Create('Funcionário padrão do sistema não pode ser excluído');

   MyQueryNew
    .Add('DELETE FROM '+TABELA)
    .Add('WHERE('+TABELA+'.ID = :ID)')
    .AddParam('ID', FEntitie.Id);

   try
     ShowDebug(MyQuery.SQL.Text);
     MyQuery.ExecSQL;
   except on E: Exception do
   begin
      if(not MyQuery.ExceptionZeroRecordsUpdated)then
        raise ExceptionError.Create('Não foi possível deletar o funcionário',
                                    THIS + ': ' + FEntitie.IdMascara + sLineBreak +
                                    'Mensagem: ' + E.Message);
   end;
   end;
   FEntitie.Id(0);

   ShowDone('Exclusão realizada');
end;

function TModelFuncionariosFactory.Gravar: IModelFuncionariosFactory<TModelFuncionariosEntitie>;
begin
   Result := Self;

   if(FEntitie.Id = 1)then
     raise ExceptionWarning.Create('Funcionário padrão do sistema bloqueado para alterações');

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
    .AddParam('SALARIO', FEntitie.Salario)
    .AddParam('FUNCAO', FEntitie.Funcao)
    .AddParam('LOGIN', FEntitie.Login)
    .AddParam('SENHA', FEntitie.Senha);

   try
     ShowDebug(MyQuery.SQL.Text);
     MyQuery.ExecSQL;
   except on E: Exception do
   begin
      if(not MyQuery.ExceptionZeroRecordsUpdated)then
        raise ExceptionError.Create('Não foi possível gravar o funcionário',
                                    'Mensagem: ' + E.Message);
   end;
   end;

   ShowDone('Gravação realizada');
end;

procedure TModelFuncionariosFactory.SQLInsert;
begin
   MyQueryNew
    .Add('INSERT INTO '+TABELA)
    .Add('(STATUS, RAZAO_SOCIAL, NOME_FANTASIA, ENDERECO, NUMERO, BAIRRO, CEP, CIDADE, DATA_NASCIMENTO, TELEFONE, TELEFONE2, CELULAR, FAX,')
    .Add('EMAIL, TIPO_JURIDICO, CNPJ, INSCRICAO_ESTADUAL, CPF, RG, RG_ORGAO_EXPEDIDOR, DATA_CADASTRO, SALARIO, FUNCAO, LOGIN, SENHA)')
    .Add('VALUES')
    .Add('(:STATUS, :RAZAO_SOCIAL, :NOME_FANTASIA, :ENDERECO, :NUMERO, :BAIRRO, :CEP, :CIDADE, :DATA_NASCIMENTO, :TELEFONE, :TELEFONE2, :CELULAR, :FAX,')
    .Add(':EMAIL, :TIPO_JURIDICO, :CNPJ, :INSCRICAO_ESTADUAL, :CPF, :RG, :RG_ORGAO_EXPEDIDOR, :DATA_CADASTRO, :SALARIO, :FUNCAO, :LOGIN, :SENHA)')
    .AddParam('STATUS', FEntitie.Status)
    .AddParam('DATA_CADASTRO', Now);
end;

procedure TModelFuncionariosFactory.SQLUpdate;
begin
   MyQueryNew
    .Add('UPDATE '+TABELA+' SET')
    .Add('RAZAO_SOCIAL = :RAZAO_SOCIAL, NOME_FANTASIA = :NOME_FANTASIA, ENDERECO = :ENDERECO, NUMERO = :NUMERO, BAIRRO = :BAIRRO, ')
    .Add('CEP = :CEP, CIDADE = :CIDADE, DATA_NASCIMENTO = :DATA_NASCIMENTO, TELEFONE = :TELEFONE, TELEFONE2 = :TELEFONE2, ')
    .Add('CELULAR = :CELULAR, FAX = :FAX, EMAIL = :EMAIL, TIPO_JURIDICO = :TIPO_JURIDICO, CNPJ = :CNPJ, INSCRICAO_ESTADUAL = :INSCRICAO_ESTADUAL, ')
    .Add('CPF = :CPF, RG = :RG, RG_ORGAO_EXPEDIDOR = :RG_ORGAO_EXPEDIDOR, SALARIO = :SALARIO, FUNCAO = :FUNCAO, LOGIN = :LOGIN, SENHA = :SENHA')
    .Add('WHERE('+TABELA+'.ID = :ID)')
    .AddParam('ID', FEntitie.Id);
end;

end.
