unit Model.Cidades.Factory;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Model.Cidades.Interfaces,
  Model.Cidades.Entitie;

const
  THIS   = 'Cidade';
  TABELA = 'CIDADES';

type
  TModelCidadesFactory = class(TInterfacedObject, IModelCidadesFactory<TModelCidadesEntitie>)
  private
    FEntitie: TModelCidadesEntitie;
    procedure InsertCidade;
    procedure UpdateCidade;
  protected
    function Entitie: TModelCidadesEntitie;

    function ConsultarEntitie: IModelCidadesFactory<TModelCidadesEntitie>;
    function Deletar: IModelCidadesFactory<TModelCidadesEntitie>;
    function Gravar: IModelCidadesFactory<TModelCidadesEntitie>;
  public
    class function New: IModelCidadesFactory<TModelCidadesEntitie>;
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

class function TModelCidadesFactory.New: IModelCidadesFactory<TModelCidadesEntitie>;
begin
   Result := Self.Create;
end;

constructor TModelCidadesFactory.Create;
begin
   FEntitie := TModelCidadesEntitie.Create(Self);
end;

destructor TModelCidadesFactory.Destroy;
begin
   if(Assigned(FEntitie))then
     FEntitie.Free;
   inherited;
end;

function TModelCidadesFactory.Entitie: TModelCidadesEntitie;
begin
   Result := FEntitie;
end;

function TModelCidadesFactory.ConsultarEntitie: IModelCidadesFactory<TModelCidadesEntitie>;
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
        raise ExceptionError.Create('Não foi possível consultar a cidade',
                                    THIS + ': ' + FEntitie.IdMascara + sLineBreak +
                                    'Mensagem: ' + E.Message);
   end;
   end;

   FEntitie
    .Id(MyQuery.FieldByName('ID').AsString)
    .Nome(MyQuery.FieldByName('NOME').AsString)
    .UF(MyQuery.FieldByName('UF').AsString)
    .IBGE(MyQuery.FieldByName('IBGE').AsString)
    .End_Entitie;
end;

function TModelCidadesFactory.Deletar: IModelCidadesFactory<TModelCidadesEntitie>;
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
        raise ExceptionError.Create('Não foi possível deletar a cidade',
                                    THIS + ': ' + FEntitie.IdMascara + sLineBreak +
                                    'Mensagem: ' + E.Message);
   end;
   end;
   FEntitie.Id(0);

   ShowDone('Exclusão realizada');
end;

function TModelCidadesFactory.Gravar: IModelCidadesFactory<TModelCidadesEntitie>;
begin
   Result := Self;

   if(FEntitie.Id > 0)then
     Self.UpdateCidade
   else
     Self.InsertCidade;

   MyQuery
    .AddParam('NOME', FEntitie.Nome)
    .AddParam('UF', FEntitie.UF)
    .AddParam('IBGE', FEntitie.IBGE);

   try
     ShowDebug(MyQuery.SQL.Text);
     MyQuery.ExecSQL;
   except on E: Exception do
   begin
      if(not MyQuery.ExceptionZeroRecordsUpdated)then
        raise ExceptionError.Create('Não foi possível gravar a cidade',
                                    'Mensagem: ' + E.Message);
   end;
   end;

   ShowDone('Gravação realizada');
end;

procedure TModelCidadesFactory.InsertCidade;
begin
   MyQueryNew
    .Add('INSERT INTO '+TABELA)
    .Add('(NOME, UF, IBGE)')
    .Add('VALUES')
    .Add('(:NOME, :UF, :IBGE)');
end;

procedure TModelCidadesFactory.UpdateCidade;
begin
   MyQueryNew
    .Add('UPDATE '+TABELA+' SET')
    .Add('NOME = :NOME, UF = :UF, IBGE = :IBGE')
    .Add('WHERE('+TABELA+'.ID = :ID)')
    .AddParam('ID', FEntitie.Id);
end;

end.
