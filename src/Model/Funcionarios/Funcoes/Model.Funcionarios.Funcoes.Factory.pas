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
    procedure SQLInsert;
    procedure SQLUpdate;
  protected
    function Entitie: TModelFuncionariosFuncoesEntitie;

    function ConsultarEntitie: IModelFuncionariosFuncoesFactory<TModelFuncionariosFuncoesEntitie>;
    function Deletar: IModelFuncionariosFuncoesFactory<TModelFuncionariosFuncoesEntitie>;
    function Gravar: IModelFuncionariosFuncoesFactory<TModelFuncionariosFuncoesEntitie>;
  public
    class function New: IModelFuncionariosFuncoesFactory<TModelFuncionariosFuncoesEntitie>;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  MyConnection,
  MyMessage,
  MyExceptions,
  Utils.MyLibrary,
  Utils.LibrarySistema;

class function TModelFuncionariosFuncoesFactory.New: IModelFuncionariosFuncoesFactory<TModelFuncionariosFuncoesEntitie>;
begin
   Result := Self.Create;
end;

constructor TModelFuncionariosFuncoesFactory.Create;
begin
   FEntitie := TModelFuncionariosFuncoesEntitie.Create(Self);
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

   ShowDone('Exclusão realizada');
end;

function TModelFuncionariosFuncoesFactory.Gravar: IModelFuncionariosFuncoesFactory<TModelFuncionariosFuncoesEntitie>;
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
     MyQuery.ExecSQL;
   except on E: Exception do
   begin
      if(not MyQuery.ExceptionZeroRecordsUpdated)then
        raise ExceptionError.Create('Não foi possível gravar a função',
                                    'Mensagem: ' + E.Message);
   end;
   end;

   ShowDone('Gravação realizada');
end;

procedure TModelFuncionariosFuncoesFactory.SQLInsert;
begin
   MyQueryNew
    .Add('INSERT INTO '+TABELA)
    .Add('(NOME)')
    .Add('VALUES')
    .Add('(:NOME)');
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
