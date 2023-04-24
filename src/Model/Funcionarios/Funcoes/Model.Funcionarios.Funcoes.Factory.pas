unit Model.Funcionarios.Funcoes.Factory;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Model.Funcionarios.Funcoes.Interfaces,
  Model.Funcionarios.Funcoes.Entitie;

const
  THIS   = 'Função';
  TABELA = 'FUNCIONARIOS_FUNCOES';

type
  TModelFuncionariosFuncoesFactory = class(TInterfacedObject, IModelFuncionariosFuncoesFactory<TModelFuncionariosFuncoesEntitie>)
  private
    FEntitie: TModelFuncionariosFuncoesEntitie;
    FTelaOrigem: string;
    procedure SQLInsert;
    procedure SQLUpdate;
  protected
    function Entitie: TModelFuncionariosFuncoesEntitie;

    function ConsultarEntitie: IModelFuncionariosFuncoesFactory<TModelFuncionariosFuncoesEntitie>;
    function Deletar: IModelFuncionariosFuncoesFactory<TModelFuncionariosFuncoesEntitie>;
    function Gravar: IModelFuncionariosFuncoesFactory<TModelFuncionariosFuncoesEntitie>;
  public
    class function New(ATelaOrigem: string): IModelFuncionariosFuncoesFactory<TModelFuncionariosFuncoesEntitie>;
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
  Model.Logs;

class function TModelFuncionariosFuncoesFactory.New(ATelaOrigem: string): IModelFuncionariosFuncoesFactory<TModelFuncionariosFuncoesEntitie>;
begin
   if(ATelaOrigem.Trim.IsEmpty)then
     raise ExceptionRequired.Create('Tela de origem da factory funções de funcionários necessária');

   Result := Self.Create(ATelaOrigem);
end;

constructor TModelFuncionariosFuncoesFactory.Create(ATelaOrigem: string);
begin
   FTelaOrigem := ATelaOrigem;
   FEntitie    := TModelFuncionariosFuncoesEntitie.Create(Self);
end;

destructor TModelFuncionariosFuncoesFactory.Destroy;
begin
   if(Assigned(FEntitie))then
     FEntitie.Free;
   inherited;
end;

function TModelFuncionariosFuncoesFactory.Entitie: TModelFuncionariosFuncoesEntitie;
begin
   Result := FEntitie;
end;

function TModelFuncionariosFuncoesFactory.ConsultarEntitie: IModelFuncionariosFuncoesFactory<TModelFuncionariosFuncoesEntitie>;
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
        raise ExceptionError.Create('Não foi possível consultar a função',
                                    THIS + ': ' + FEntitie.IdMascara + sLineBreak +
                                    'Mensagem: ' + E.Message);
   end;
   end;
   FEntitie.Id(0);

   Self.Entitie
    .Id(MyQuery.FieldByName('ID').AsString)
    .Nome(MyQuery.FieldByName('NOME').AsString)
    .End_Entitie;
end;

function TModelFuncionariosFuncoesFactory.Deletar: IModelFuncionariosFuncoesFactory<TModelFuncionariosFuncoesEntitie>;
begin
   Result := Self;

   if(not (FEntitie.Id > 0))then
     ExceptionMsgRegistroNaoInformadoExclusao(THIS);

   if(not ShowQuestionNo('Deseja excluir o registro ' + FEntitie.Id.ToString + ' - ' + FEntitie.Nome))then
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
        raise ExceptionError.Create('Não foi possível deletar a função',
                                    THIS + ': ' + FEntitie.IdMascara + sLineBreak +
                                    'Mensagem: ' + E.Message);
   end;
   end;
   TModelLogs.New.Gravar(FTelaOrigem,
                         'Exclusão de função de funcionário',
                         'Usuário excluiu a função ' + FEntitie.Id.ToString + ' - ' + FEntitie.Nome,
                         FEntitie.Id);
   FEntitie.Id(0);

   ShowDone('Exclusão realizada');
end;

function TModelFuncionariosFuncoesFactory.Gravar: IModelFuncionariosFuncoesFactory<TModelFuncionariosFuncoesEntitie>;
var
  LAcao: string;
begin
   Result := Self;

   if(FEntitie.Id > 0)then
     Self.SQLUpdate
   else
     Self.SQLInsert;

   MyQuery
    .AddParam('NOME', FEntitie.Nome);

   try
     ShowDebug(MyQuery.SQL.Text);
     if(FEntitie.Id > 0)then
     begin
        LAcao := 'Alteração';
        MyQuery.ExecSQL;
     end
     else
     begin
        LAcao := 'Gravação';
        MyQuery.Open;
        FEntitie.Id(MyQuery.FieldByName('ID').AsInteger);
     end;
   except on E: Exception do
   begin
      if(not MyQuery.ExceptionZeroRecordsUpdated)then
        raise ExceptionError.Create('Não foi possível gravar a função',
                                    'Mensagem: ' + E.Message);
   end;
   end;

   TModelLogs.New.Gravar(FTelaOrigem,
                         LAcao + ' de função de funcionário',
                         'Usuário gravou a função ' + FEntitie.Id.ToString,
                         FEntitie.Id);

   ShowDone('Gravação realizada');
end;

procedure TModelFuncionariosFuncoesFactory.SQLInsert;
begin
   MyQueryNew
    .Add('INSERT INTO '+TABELA)
    .Add('(NOME)')
    .Add('VALUES')
    .Add('(:NOME)')
    .Add('RETURNING ID');
end;

procedure TModelFuncionariosFuncoesFactory.SQLUpdate;
begin
   MyQueryNew
    .Add('UPDATE '+TABELA+' SET')
    .Add('NOME = :NOME')
    .Add('WHERE('+TABELA+'.ID = :ID)')
    .AddParam('ID', FEntitie.Id);
end;

end.
