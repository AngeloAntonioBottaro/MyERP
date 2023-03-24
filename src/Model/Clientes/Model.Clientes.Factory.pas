unit Model.Clientes.Factory;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Model.Clientes.Interfaces,
  Model.Clientes.Entitie;

const
  THIS   = 'Cliente';
  TABELA = 'CLIENTES';

type
  TModelClientesFactory = class(TInterfacedObject, IModelClientesFactory<TModelClientesEntitie>)
  private
    FEntitie: TModelClientesEntitie;
    procedure SQLInsert;
    procedure SQLUpdate;
    procedure ValidarCampos;
  protected
    function Entitie: TModelClientesEntitie;

    procedure ValidarCPF;
    procedure ValidarCNPJ;
    procedure ValidarEmail;

    function AlterarStatus: IModelClientesFactory<TModelClientesEntitie>;
    function ConsultarEntitie: IModelClientesFactory<TModelClientesEntitie>;
    function Deletar: IModelClientesFactory<TModelClientesEntitie>;
    function Gravar: IModelClientesFactory<TModelClientesEntitie>;
  public
    class function New: IModelClientesFactory<TModelClientesEntitie>;
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

function TModelClientesFactory.Entitie: TModelClientesEntitie;
begin
   Result := FEntitie;
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

   if(TMyLibrary.IdentifyCNPJ(FEntitie.Cnpj))then
   begin
      if(TMyLibrary.ValidCNPJ(FEntitie.Cnpj))then
        Exit;
   end;

   raise ExceptionWarning.Create('CNPJ inválido');
end;

procedure TModelClientesFactory.ValidarCPF;
begin
   if(FEntitie.Cpf = EmptyStr)then
     Exit;

   if(TMyLibrary.IdentifyCPF(FEntitie.Cpf))then
   begin
      if(TMyLibrary.ValidCPF(FEntitie.Cpf))then
        Exit;
   end;

   raise ExceptionWarning.Create('CPF inválido');
end;

procedure TModelClientesFactory.ValidarEmail;
begin
   if(FEntitie.Email = EmptyStr)then
     Exit;

   if(TMyLibrary.ValidEmail(FEntitie.Email))then
     Exit;

   raise ExceptionWarning.Create('E-mail inválido/incorreto');
end;

function TModelClientesFactory.AlterarStatus: IModelClientesFactory<TModelClientesEntitie>;
var
  LStatusNovo: string;
begin
   Result := Self;

   if(not (FEntitie.Id > 0))then
     ExceptionMsgRegistroNaoInformadoAlteracaoStatus(THIS);

   if(FEntitie.Id = 1)then
     raise ExceptionWarning.Create('Cliente padrão do sistema não pode ser inativado');

   MyQueryNew
    .Add('SELECT STATUS FROM '+TABELA)
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
        raise ExceptionError.Create('Não foi possível alterar o status do cliente',
                                    THIS + ': ' + FEntitie.IdMascara + sLineBreak +
                                    'Mensagem: ' + E.Message);
   end;
   end;

   ShowDone(THIS + IfThen(LStatusNovo.Equals(STATUS_ATIVO), ' ativado', ' inativado'));
end;

function TModelClientesFactory.ConsultarEntitie: IModelClientesFactory<TModelClientesEntitie>;
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
    .End_Entitie;
end;

function TModelClientesFactory.Deletar: IModelClientesFactory<TModelClientesEntitie>;
begin
   Result := Self;

   if(not (FEntitie.Id > 0))then
     ExceptionMsgRegistroNaoInformadoExclusao(THIS);

   if(FEntitie.Id = 1)then
     raise ExceptionWarning.Create('Cliente padrão do sistema não pode ser excluído');

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
        raise ExceptionError.Create('Não foi possível deletar o cliente',
                                    THIS + ': ' + FEntitie.IdMascara + sLineBreak +
                                    'Mensagem: ' + E.Message);
   end;
   end;
   FEntitie.Id(0);

   ShowDone('Exclusão realizada');
end;

function TModelClientesFactory.Gravar: IModelClientesFactory<TModelClientesEntitie>;
begin
   Result := Self;

   if(FEntitie.Id = 1)then
     raise ExceptionWarning.Create('Cliente padrão do sistema bloqueado para alterações');

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
    .AddParam('RG_ORGAO_EXPEDIDOR', FEntitie.RgOrgaoExpedidor);

   try
     ShowDebug(MyQuery.SQL.Text);
     MyQuery.ExecSQL;
   except on E: Exception do
   begin
      if(not MyQuery.ExceptionZeroRecordsUpdated)then
        raise ExceptionError.Create('Não foi possível gravar o cliente',
                                    'Mensagem: ' + E.Message);
   end;
   end;

   ShowDone('Gravação realizada');
end;

procedure TModelClientesFactory.SQLInsert;
begin
   MyQueryNew
    .Add('INSERT INTO '+TABELA)
    .Add('(STATUS, RAZAO_SOCIAL, NOME_FANTASIA, ENDERECO, NUMERO, BAIRRO, CEP, CIDADE, DATA_NASCIMENTO, TELEFONE, TELEFONE2, CELULAR, FAX,')
    .Add('EMAIL, TIPO_JURIDICO, CNPJ, INSCRICAO_ESTADUAL, CPF, RG, RG_ORGAO_EXPEDIDOR, DATA_CADASTRO)')
    .Add('VALUES')
    .Add('(:STATUS, :RAZAO_SOCIAL, :NOME_FANTASIA, :ENDERECO, :NUMERO, :BAIRRO, :CEP, :CIDADE, :DATA_NASCIMENTO, :TELEFONE, :TELEFONE2, :CELULAR, :FAX,')
    .Add(':EMAIL, :TIPO_JURIDICO, :CNPJ, :INSCRICAO_ESTADUAL, :CPF, :RG, :RG_ORGAO_EXPEDIDOR, :DATA_CADASTRO)')
    .AddParam('STATUS', STATUS_ATIVO)
    .AddParam('DATA_CADASTRO', Now);
end;

procedure TModelClientesFactory.SQLUpdate;
begin
   MyQueryNew
    .Add('UPDATE '+TABELA+' SET')
    .Add('RAZAO_SOCIAL = :RAZAO_SOCIAL, NOME_FANTASIA = :NOME_FANTASIA, ENDERECO = :ENDERECO, NUMERO = :NUMERO, BAIRRO = :BAIRRO, ')
    .Add('CEP = :CEP, CIDADE = :CIDADE, DATA_NASCIMENTO = :DATA_NASCIMENTO, TELEFONE = :TELEFONE, TELEFONE2 = :TELEFONE2, ')
    .Add('CELULAR = :CELULAR, FAX = :FAX, EMAIL = :EMAIL, TIPO_JURIDICO = :TIPO_JURIDICO, CNPJ = :CNPJ, INSCRICAO_ESTADUAL = :INSCRICAO_ESTADUAL, ')
    .Add('CPF = :CPF, RG = :RG, RG_ORGAO_EXPEDIDOR = :RG_ORGAO_EXPEDIDOR')
    .Add('WHERE('+TABELA+'.ID = :ID)')
    .AddParam('ID', FEntitie.Id);
end;

end.
