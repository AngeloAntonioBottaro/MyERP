unit Model.FormasPagamento.Factory;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Model.FormasPagamento.Interfaces,
  Model.FormasPagamento.Entitie;

const
  THIS   = 'Forma de pagamento';
  TABELA = 'FORMA_PAGAMENTO';

type
  TModelFormasPagamentoFactory = class(TInterfacedObject, IModelFormasPagamentoFactory<TModelFormasPagamentoEntitie>)
  private
    FEntitie: TModelFormasPagamentoEntitie;
    FTelaOrigem: string;
    procedure SQLInsert;
    procedure SQLUpdate;
  protected
    function Entitie: TModelFormasPagamentoEntitie;

    function AlterarStatus: IModelFormasPagamentoFactory<TModelFormasPagamentoEntitie>;
    function ConsultarEntitie: IModelFormasPagamentoFactory<TModelFormasPagamentoEntitie>;
    function Deletar: IModelFormasPagamentoFactory<TModelFormasPagamentoEntitie>;
    function Gravar: IModelFormasPagamentoFactory<TModelFormasPagamentoEntitie>;
  public
    class function New(ATelaOrigem: string): IModelFormasPagamentoFactory<TModelFormasPagamentoEntitie>;
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

class function TModelFormasPagamentoFactory.New(ATelaOrigem: string): IModelFormasPagamentoFactory<TModelFormasPagamentoEntitie>;
begin
   if(ATelaOrigem.Trim.IsEmpty)then
     raise ExceptionRequired.Create('Tela de origem da factory forma de pagamento necessária');

   Result := Self.Create(ATelaOrigem);
end;

constructor TModelFormasPagamentoFactory.Create(ATelaOrigem: string);
begin
   FTelaOrigem := ATelaOrigem;
   FEntitie    := TModelFormasPagamentoEntitie.Create(Self);
end;

destructor TModelFormasPagamentoFactory.Destroy;
begin
   if(Assigned(FEntitie))then
     FEntitie.Free;
   inherited;
end;

function TModelFormasPagamentoFactory.Entitie: TModelFormasPagamentoEntitie;
begin
   Result := FEntitie;
end;

function TModelFormasPagamentoFactory.AlterarStatus: IModelFormasPagamentoFactory<TModelFormasPagamentoEntitie>;
var
  LStatusNovo: string;
begin
   Result := Self;

   if(not (FEntitie.Id > 0))then
     ExceptionMsgRegistroNaoInformadoAlteracaoStatus(THIS);

   if(FEntitie.Id <= 3)then
     raise ExceptionWarning.Create('Forma de pagamento padrão do sistema não pode ser inativada');

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
        raise ExceptionError.Create('Não foi possível alterar o status da forma de pagamento',
                                    THIS + ': ' + FEntitie.IdMascara + sLineBreak +
                                    'Mensagem: ' + E.Message);
   end;
   end;

   TModelLogs.New.Gravar(FTelaOrigem,
                         'Alteração de status',
                         'Usuário alterou o status da forma de pagamento ' + FEntitie.IdNome + ' para ' + LStatusNovo,
                         FEntitie.Id);

   ShowDone(THIS + IfThen(LStatusNovo.Equals(STATUS_ATIVO), ' ativado', ' inativado'));
end;

function TModelFormasPagamentoFactory.ConsultarEntitie: IModelFormasPagamentoFactory<TModelFormasPagamentoEntitie>;
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
        raise ExceptionError.Create('Não foi possível consultar a forma de pagamento',
                                    THIS + ': ' + FEntitie.IdMascara + sLineBreak +
                                    'Mensagem: ' + E.Message);
   end;
   end;

   Self.Entitie
    .Id(MyQuery.FieldByName('ID').AsString)
    .Nome(MyQuery.FieldByName('NOME').AsString)
    .Status(MyQuery.FieldByName('STATUS').AsString)
    .TipoLancamento(MyQuery.FieldByName('TIPO_LANCAMENTO').AsString)
    .End_Entitie;
end;

function TModelFormasPagamentoFactory.Deletar: IModelFormasPagamentoFactory<TModelFormasPagamentoEntitie>;
begin
   Result := Self;

   if(not (FEntitie.Id > 0))then
     ExceptionMsgRegistroNaoInformadoExclusao(THIS);

   if(not ShowQuestionNo('Deseja excluir o registro ' + FEntitie.IdNome))then
     Exit;

   MyQueryNew
    .Add('DELETE FROM '+TABELA+' ')
    .Add('WHERE('+TABELA+'.ID = :ID)')
    .AddParam('ID', FEntitie.Id);

   try
     ShowDebug(MyQuery.SQL.Text);
     MyQuery.ExecSQL;
   except on E: Exception do
   begin
      if(not MyQuery.ExceptionZeroRecordsUpdated)then
        raise ExceptionError.Create('Não foi possível deletar a forma de pagamento',
                                    THIS + ': ' + FEntitie.IdMascara + sLineBreak +
                                    'Mensagem: ' + E.Message);
   end;
   end;

   TModelLogs.New.Gravar(FTelaOrigem,
                         'Exclusão de forma de pagamento',
                         'Usuário excluiu a forma de pagamento ' + FEntitie.IdNome,
                         FEntitie.Id);
   FEntitie.Id(0);

   ShowDone('Exclusão realizada');
end;

function TModelFormasPagamentoFactory.Gravar: IModelFormasPagamentoFactory<TModelFormasPagamentoEntitie>;
var
  LAcao: string;
begin
   Result := Self;

   if(FEntitie.Id > 0)then
     Self.SQLUpdate
   else
     Self.SQLInsert;

   MyQuery
    .AddParam('NOME', FEntitie.Nome)
    .AddParam('TIPO_LANCAMENTO', FEntitie.TipoLancamento);

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
        raise ExceptionError.Create('Não foi possível gravar a forma de pagamento',
                                    'Mensagem: ' + E.Message);
   end;
   end;

   TModelLogs.New.Gravar(FTelaOrigem,
                         LAcao + ' de forma de pagamento',
                         'Usuário gravou a forma de pagamento ' + FEntitie.IdNome,
                         FEntitie.Id);

   ShowDone('Gravação realizada');
end;

procedure TModelFormasPagamentoFactory.SQLInsert;
begin
   MyQueryNew
    .Add('INSERT INTO '+TABELA)
    .Add('(STATUS, NOME, TIPO_LANCAMENTO)')
    .Add('VALUES')
    .Add('(:STATUS, :NOME, :TIPO_LANCAMENTO)')
    .Add('RETURNING ID')
    .AddParam('STATUS', STATUS_ATIVO);
end;

procedure TModelFormasPagamentoFactory.SQLUpdate;
begin
   MyQueryNew
    .Add('UPDATE '+TABELA+' SET')
    .Add('NOME = :NOME, TIPO_LANCAMENTO = :TIPO_LANCAMENTO')
    .Add('WHERE('+TABELA+'.ID = :ID)')
    .AddParam('ID', FEntitie.Id);
end;

end.
