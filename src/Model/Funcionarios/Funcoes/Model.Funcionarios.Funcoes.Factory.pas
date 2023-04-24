unit Model.Funcionarios.Funcoes.Factory;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Model.Funcionarios.Funcoes.Interfaces,
  Model.Funcionarios.Funcoes.Entitie;

const
  THIS   = 'Fun��o';
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
     raise ExceptionRequired.Create('Tela de origem da factory fun��es de funcion�rios necess�ria');

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
        raise ExceptionError.Create('N�o foi poss�vel consultar a fun��o',
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
        raise ExceptionError.Create('N�o foi poss�vel deletar a fun��o',
                                    THIS + ': ' + FEntitie.IdMascara + sLineBreak +
                                    'Mensagem: ' + E.Message);
   end;
   end;
   TModelLogs.New.Gravar(FTelaOrigem,
                         'Exclus�o de fun��o de funcion�rio',
                         'Usu�rio excluiu a fun��o ' + FEntitie.Id.ToString + ' - ' + FEntitie.Nome,
                         FEntitie.Id);
   FEntitie.Id(0);

   ShowDone('Exclus�o realizada');
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
        LAcao := 'Altera��o';
        MyQuery.ExecSQL;
     end
     else
     begin
        LAcao := 'Grava��o';
        MyQuery.Open;
        FEntitie.Id(MyQuery.FieldByName('ID').AsInteger);
     end;
   except on E: Exception do
   begin
      if(not MyQuery.ExceptionZeroRecordsUpdated)then
        raise ExceptionError.Create('N�o foi poss�vel gravar a fun��o',
                                    'Mensagem: ' + E.Message);
   end;
   end;

   TModelLogs.New.Gravar(FTelaOrigem,
                         LAcao + ' de fun��o de funcion�rio',
                         'Usu�rio gravou a fun��o ' + FEntitie.Id.ToString,
                         FEntitie.Id);

   ShowDone('Grava��o realizada');
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
