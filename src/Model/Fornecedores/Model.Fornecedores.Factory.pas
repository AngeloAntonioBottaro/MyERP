unit Model.Fornecedores.Factory;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Model.Fornecedores.Interfaces,
  Model.Fornecedores.Entitie;

const
  THIS   = 'Fornecedor';
  TABELA = 'FORNECEDORES';

type
  TModelFornecedoresFactory = class(TInterfacedObject, IModelFornecedoresFactory<TModelFornecedoresEntitie>)
  private
    FEntitie: TModelFornecedoresEntitie;
    FTelaOrigem: string;
    procedure SQLInsert;
    procedure SQLUpdate;
    procedure ValidarCampos;
  protected
    function Entitie: TModelFornecedoresEntitie;

    procedure ValidarCPF;
    procedure ValidarCNPJ;
    procedure ValidarEmail;

    function AlterarStatus: IModelFornecedoresFactory<TModelFornecedoresEntitie>;
    function ConsultarEntitie: IModelFornecedoresFactory<TModelFornecedoresEntitie>;
    function Deletar: IModelFornecedoresFactory<TModelFornecedoresEntitie>;
    function Gravar: IModelFornecedoresFactory<TModelFornecedoresEntitie>;
  public
    class function New(ATelaOrigem: string): IModelFornecedoresFactory<TModelFornecedoresEntitie>;
    constructor Create(ATelaOrigem: string);
    destructor Destroy; override;
  end;

implementation

uses
  MyConnection,
  MyMessage,
  MyExceptions,
  Common.Utils.MyLibrary,
  Utils.LibrarySistema,
  Utils.GlobalConsts,
  Model.Logs;

class function TModelFornecedoresFactory.New(ATelaOrigem: string): IModelFornecedoresFactory<TModelFornecedoresEntitie>;
begin
   if(ATelaOrigem.Trim.IsEmpty)then
     raise ExceptionRequired.Create('Tela de origem da factory fornecedores necessária');

   Result := Self.Create(ATelaOrigem);
end;

constructor TModelFornecedoresFactory.Create(ATelaOrigem: string);
begin
   FTelaOrigem := ATelaOrigem;
   FEntitie    := TModelFornecedoresEntitie.Create(Self);
end;

destructor TModelFornecedoresFactory.Destroy;
begin
   if(Assigned(FEntitie))then
     FEntitie.Free;
   inherited;
end;

function TModelFornecedoresFactory.Entitie: TModelFornecedoresEntitie;
begin
   Result := FEntitie;
end;

procedure TModelFornecedoresFactory.ValidarCampos;
begin
   if((FEntitie.RazaoSocial = EmptyStr) and (FEntitie.NomeFantasia = EmptyStr))then
     raise ExceptionRequired.Create('Razão social é obrigatório');

   Self.ValidarCNPJ;
   Self.ValidarCPF;

   if(not (FEntitie.Cidade > 0))then
     raise ExceptionRequired.Create('Cidade não informada');
end;

procedure TModelFornecedoresFactory.ValidarCNPJ;
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

procedure TModelFornecedoresFactory.ValidarCPF;
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

procedure TModelFornecedoresFactory.ValidarEmail;
begin
   if(FEntitie.Email = EmptyStr)then
     Exit;

   if(TMyLibrary.ValidateEmail(FEntitie.Email))then
     Exit;

   raise ExceptionWarning.Create('E-mail inválido/incorreto');
end;

function TModelFornecedoresFactory.AlterarStatus: IModelFornecedoresFactory<TModelFornecedoresEntitie>;
var
  LStatusNovo: string;
begin
   Result := Self;

   if(not (FEntitie.Id > 0))then
     ExceptionMsgRegistroNaoInformadoAlteracaoStatus(THIS);

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
        raise ExceptionError.Create('Não foi possível alterar o status do fornecedor',
                                    THIS + ': ' + FEntitie.IdMascara + sLineBreak +
                                    'Mensagem: ' + E.Message);
   end;
   end;

   TModelLogs.New.Gravar(FTelaOrigem,
                         'Alteração de status',
                         'Usuário alterou o status do fornecedor ' + FEntitie.IdNome + ' para ' + LStatusNovo,
                         FEntitie.Id);

   ShowDone(THIS + IfThen(LStatusNovo.Equals(STATUS_ATIVO), ' ativado', ' inativado'));
end;

function TModelFornecedoresFactory.ConsultarEntitie: IModelFornecedoresFactory<TModelFornecedoresEntitie>;
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
        raise ExceptionError.Create('Não foi possível consultar o fornecedor',
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

function TModelFornecedoresFactory.Deletar: IModelFornecedoresFactory<TModelFornecedoresEntitie>;
begin
   Result := Self;

   if(not (FEntitie.Id > 0))then
     ExceptionMsgRegistroNaoInformadoExclusao(THIS);

   if(not ShowQuestionNo('Deseja excluir o registro ' + FEntitie.IdNome))then
     Exit;

   MyQueryNew
    .Add('DELETE FROM ' + TABELA)
    .Add('WHERE('+TABELA+'.ID = :ID)')
    .AddParam('ID', FEntitie.Id);

   try
     ShowDebug(MyQuery.SQL.Text);
     MyQuery.ExecSQL;
   except on E: Exception do
   begin
      if(not MyQuery.ExceptionZeroRecordsUpdated)then
        raise ExceptionError.Create('Não foi possível deletar o fornecedor',
                                    THIS + ': ' + FEntitie.IdMascara + sLineBreak +
                                    'Mensagem: ' + E.Message);
   end;
   end;

   TModelLogs.New.Gravar(FTelaOrigem,
                         'Exclusão de fornecedor',
                         'Usuário excluiu o fornecedor ' + FEntitie.IdNome,
                         FEntitie.Id);
   FEntitie.Id(0);

   ShowDone('Exclusão realizada');
end;

function TModelFornecedoresFactory.Gravar: IModelFornecedoresFactory<TModelFornecedoresEntitie>;
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
    .AddParam('RG_ORGAO_EXPEDIDOR', FEntitie.RgOrgaoExpedidor);

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
        raise ExceptionError.Create('Não foi possível gravar o fornecedor',
                                    'Mensagem: ' + E.Message);
   end;
   end;

   TModelLogs.New.Gravar(FTelaOrigem,
                         LAcao + ' de fornecedor',
                         'Usuário gravou o fornecedor ' + FEntitie.IdNome,
                         FEntitie.Id);

   ShowDone('Gravação realizada');
end;

procedure TModelFornecedoresFactory.SQLInsert;
begin
   MyQueryNew
    .Add('INSERT INTO '+TABELA)
    .Add('(STATUS, RAZAO_SOCIAL, NOME_FANTASIA, ENDERECO, NUMERO, BAIRRO, CEP, CIDADE, DATA_NASCIMENTO, TELEFONE, TELEFONE2, CELULAR, FAX,')
    .Add('EMAIL, TIPO_JURIDICO, CNPJ, INSCRICAO_ESTADUAL, CPF, RG, RG_ORGAO_EXPEDIDOR, DATA_CADASTRO)')
    .Add('VALUES')
    .Add('(:STATUS, :RAZAO_SOCIAL, :NOME_FANTASIA, :ENDERECO, :NUMERO, :BAIRRO, :CEP, :CIDADE, :DATA_NASCIMENTO, :TELEFONE, :TELEFONE2, :CELULAR, :FAX,')
    .Add(':EMAIL, :TIPO_JURIDICO, :CNPJ, :INSCRICAO_ESTADUAL, :CPF, :RG, :RG_ORGAO_EXPEDIDOR, :DATA_CADASTRO)')
    .Add('RETURNING ID')
    .AddParam('STATUS', FEntitie.Status)
    .AddParam('DATA_CADASTRO', Now);
end;

procedure TModelFornecedoresFactory.SQLUpdate;
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
