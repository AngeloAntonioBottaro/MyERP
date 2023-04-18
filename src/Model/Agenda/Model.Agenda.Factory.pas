unit Model.Agenda.Factory;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Model.Agenda.Interfaces,
  Model.Agenda.Entitie;

const
  THIS   = 'Agenda';
  TABELA = 'AGENDA';

type
  TModelAgendaFactory = class(TInterfacedObject, IModelAgendaFactory<TModelAgendaEntitie>)
  private
    FEntitie: TModelAgendaEntitie;
    procedure InsertCidade;
    procedure UpdateCidade;
    procedure ValidarCampos;
  protected
    function Entitie: TModelAgendaEntitie;

    function ConsultarEntitie: IModelAgendaFactory<TModelAgendaEntitie>;
    function Deletar: IModelAgendaFactory<TModelAgendaEntitie>;
    function Gravar: IModelAgendaFactory<TModelAgendaEntitie>;
  public
    class function New: IModelAgendaFactory<TModelAgendaEntitie>;
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

class function TModelAgendaFactory.New: IModelAgendaFactory<TModelAgendaEntitie>;
begin
   Result := Self.Create;
end;

constructor TModelAgendaFactory.Create;
begin
   FEntitie := TModelAgendaEntitie.Create(Self);
end;

destructor TModelAgendaFactory.Destroy;
begin
   if(Assigned(FEntitie))then
     FEntitie.Free;
   inherited;
end;

function TModelAgendaFactory.Entitie: TModelAgendaEntitie;
begin
   Result := FEntitie;
end;

procedure TModelAgendaFactory.ValidarCampos;
begin
   if(FEntitie.Cliente <= 0)then
     raise ExceptionRequired.Create('Cliente obrigatório');

   if(FEntitie.Funcionario <= 0)then
     raise ExceptionRequired.Create('Funcionário obrigatório');
end;

function TModelAgendaFactory.ConsultarEntitie: IModelAgendaFactory<TModelAgendaEntitie>;
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
        raise ExceptionError.Create('Não foi possível consultar o registro',
                                    THIS + ': ' + FEntitie.IdMascara + sLineBreak +
                                    'Mensagem: ' + E.Message);
   end;
   end;

   FEntitie
    .Id(MyQuery.FieldByName('ID').AsInteger)
    .Cliente(MyQuery.FieldByName('CLIENTE').AsInteger)
    .Funcionario(MyQuery.FieldByName('FUNCIONARIO').AsString)
    .Data(MyQuery.FieldByName('DATA').AsDateTime)
    .Hora(MyQuery.FieldByName('HORA').AsDateTime)
    .Observacao(MyQuery.FieldByName('TITULO').AsString)
    .Observacao(MyQuery.FieldByName('OBSERVACAO').AsString)
    .Status(MyQuery.FieldByName('STATUS').AsString)
    .End_Entitie;
end;

function TModelAgendaFactory.Deletar: IModelAgendaFactory<TModelAgendaEntitie>;
begin
   Result := Self;

   if(not (FEntitie.Id > 0))then
     ExceptionMsgRegistroNaoInformadoExclusao(THIS);

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
        raise ExceptionError.Create('Não foi possível deletar o registro',
                                    THIS + ': ' + FEntitie.IdMascara + sLineBreak +
                                    'Mensagem: ' + E.Message);
   end;
   end;
   FEntitie.Id(0);

   ShowDone('Exclusão realizada');
end;

function TModelAgendaFactory.Gravar: IModelAgendaFactory<TModelAgendaEntitie>;
begin
   Result := Self;

   Self.ValidarCampos;

   if(FEntitie.Id > 0)then
     Self.UpdateCidade
   else
     Self.InsertCidade;

   MyQuery
    .AddParam('CLIENTE', FEntitie.Cliente)
    .AddParam('FUNCIONARIO', FEntitie.Funcionario)
    .AddParam('DATA', FEntitie.Data)
    .AddParam('HORA', FEntitie.Hora)
    .AddParam('TITULO', FEntitie.Titulo)
    .AddParam('OBSERVACAO', FEntitie.Observacao)
    .AddParam('STATUS', FEntitie.Status)
    .AddParam('DATA_ULTIMA_ALTERACAO', Now);

   try
     ShowDebug(MyQuery.SQL.Text);
     MyQuery.ExecSQL;
   except on E: Exception do
   begin
      if(not MyQuery.ExceptionZeroRecordsUpdated)then
        raise ExceptionError.Create('Não foi possível gravar o registro',
                                    'Mensagem: ' + E.Message);
   end;
   end;

   ShowDone('Gravação realizada');
end;

procedure TModelAgendaFactory.InsertCidade;
begin
   MyQueryNew
    .Add('INSERT INTO '+TABELA)
    .Add('(CLIENTE, FUNCIONARIO, DATA, HORA, TITULO, OBSERVACAO, STATUS, DATA_CADASTRO, DATA_ULTIMA_ALTERACAO)')
    .Add('VALUES')
    .Add('(:CLIENTE, :FUNCIONARIO, :DATA, :HORA, :TITULO, :OBSERVACAO, :STATUS, :DATA_CADASTRO, :DATA_ULTIMA_ALTERACAO)')
    .AddParam('DATA_CADASTRO', Now);
end;

procedure TModelAgendaFactory.UpdateCidade;
begin
   MyQueryNew
    .Add('UPDATE '+TABELA+' SET')
    .Add('CLIENTE = :CLIENTE, FUNCIONARIO = :FUNCIONARIO, DATA = :DATA, HORA = :HORA, TITULO = :TITULO, OBSERVACAO = :OBSERVACAO, ')
    .Add('STATUS = :STATUS, DATA_ULTIMA_ALTERACAO = :DATA_ULTIMA_ALTERACAO')
    .Add('WHERE('+TABELA+'.ID = :ID)')
    .AddParam('ID', FEntitie.Id);
end;

end.
