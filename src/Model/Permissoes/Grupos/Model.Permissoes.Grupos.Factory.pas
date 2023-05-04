unit Model.Permissoes.Grupos.Factory;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Model.Permissoes.Grupos.Interfaces,
  Model.Permissoes.Grupos.Entitie;

const
  THIS   = 'Grupo de permissões';
  TABELA = 'PERMISSOES_GRUPO';

type
  TModelPermissoesGruposFactory = class(TInterfacedObject, IModelPermissoesGruposFactory<TModelPermissoesGruposEntitie>)
  private
    FEntitie: TModelPermissoesGruposEntitie;
    FTelaOrigem: string;
    procedure SQLInsert;
    procedure SQLUpdate;
  protected
    function Entitie: TModelPermissoesGruposEntitie;

    function ConsultarEntitie: IModelPermissoesGruposFactory<TModelPermissoesGruposEntitie>;
    function Deletar: IModelPermissoesGruposFactory<TModelPermissoesGruposEntitie>;
    function Gravar: IModelPermissoesGruposFactory<TModelPermissoesGruposEntitie>;
  public
    class function New(ATelaOrigem: string): IModelPermissoesGruposFactory<TModelPermissoesGruposEntitie>;
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

class function TModelPermissoesGruposFactory.New(ATelaOrigem: string): IModelPermissoesGruposFactory<TModelPermissoesGruposEntitie>;
begin
   if(ATelaOrigem.Trim.IsEmpty)then
     raise ExceptionRequired.Create('Tela de origem da factory grupos de permissões necessária');

   Result := Self.Create(ATelaOrigem);
end;

constructor TModelPermissoesGruposFactory.Create(ATelaOrigem: string);
begin
   FEntitie := TModelPermissoesGruposEntitie.Create(Self);
end;

destructor TModelPermissoesGruposFactory.Destroy;
begin
   if(Assigned(FEntitie))then
     FEntitie.Free;
   inherited;
end;

function TModelPermissoesGruposFactory.Entitie: TModelPermissoesGruposEntitie;
begin
   Result := FEntitie;
end;

function TModelPermissoesGruposFactory.ConsultarEntitie: IModelPermissoesGruposFactory<TModelPermissoesGruposEntitie>;
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
        raise ExceptionError.Create('Não foi possível consultar o grupo de permissões',
                                    THIS + ': ' + FEntitie.IdMascara + sLineBreak +
                                    'Mensagem: ' + E.Message);
   end;
   end;

   Self.Entitie
    .Id(MyQuery.FieldByName('ID').AsString)
    .Nome(MyQuery.FieldByName('NOME').AsString)
    .Descricao(MyQuery.FieldByName('DESCRICAO').AsString)
    .End_Entitie;
end;

function TModelPermissoesGruposFactory.Deletar: IModelPermissoesGruposFactory<TModelPermissoesGruposEntitie>;
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
        raise ExceptionError.Create('Não foi possível deletar o grupo de permissões',
                                    THIS + ': ' + FEntitie.IdMascara + sLineBreak +
                                    'Mensagem: ' + E.Message);
   end;
   end;

   TModelLogs.New.Gravar(FTelaOrigem,
                         'Exclusão de grupo de permissões',
                         'Usuário excluiu o grupo ' + FEntitie.Id.ToString,
                         FEntitie.Id);
   FEntitie.Id(0);

   ShowDone('Exclusão realizada');
end;

function TModelPermissoesGruposFactory.Gravar: IModelPermissoesGruposFactory<TModelPermissoesGruposEntitie>;
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
    .AddParam('DESCRICAO', FEntitie.Descricao);

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
        raise ExceptionError.Create('Não foi possível gravar o grupo de permissões',
                                    'Mensagem: ' + E.Message);
   end;
   end;

   TModelLogs.New.Gravar(FTelaOrigem,
                         LAcao + ' de grupo de permissões',
                         'Usuário gravou o grupo de permissões ' + FEntitie.IdNome,
                         FEntitie.Id);

   ShowDone('Gravação realizada');
end;

procedure TModelPermissoesGruposFactory.SQLInsert;
begin
   MyQueryNew
    .Add('INSERT INTO '+TABELA)
    .Add('(NOME, DESCRICAO)')
    .Add('VALUES')
    .Add('(:NOME, :DESCRICAO)')
    .Add('RETURNING ID');
end;

procedure TModelPermissoesGruposFactory.SQLUpdate;
begin
   MyQueryNew
    .Add('UPDATE '+TABELA+' SET')
    .Add('NOME = :NOME, DESCRICAO = :DESCRICAO')
    .Add('WHERE('+TABELA+'.ID = :ID)')
    .AddParam('ID', FEntitie.Id);
end;

end.
