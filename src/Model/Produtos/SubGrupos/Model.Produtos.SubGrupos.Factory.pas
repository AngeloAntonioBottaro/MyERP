unit Model.Produtos.SubGrupos.Factory;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Model.Produtos.SubGrupos.Interfaces,
  Model.Produtos.SubGrupos.Entitie;

const
  THIS   = 'Sub-Grupo';
  TABELA = 'PRODUTOS_SUBGRUPOS';

type
  TModelProdutosSubGruposFactory = class(TInterfacedObject, IModelProdutosSubGruposFactory<TModelProdutosSubGruposEntitie>)
  private
    FEntitie: TModelProdutosSubGruposEntitie;
    FTelaOrigem: string;
    procedure SQLInsert;
    procedure SQLUpdate;
  protected
    function Entitie: TModelProdutosSubGruposEntitie;

    function ConsultarEntitie: IModelProdutosSubGruposFactory<TModelProdutosSubGruposEntitie>;
    function Deletar: IModelProdutosSubGruposFactory<TModelProdutosSubGruposEntitie>;
    function Gravar: IModelProdutosSubGruposFactory<TModelProdutosSubGruposEntitie>;
  public
    class function New(ATelaOrigem: string): IModelProdutosSubGruposFactory<TModelProdutosSubGruposEntitie>;
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

class function TModelProdutosSubGruposFactory.New(ATelaOrigem: string): IModelProdutosSubGruposFactory<TModelProdutosSubGruposEntitie>;
begin
   if(ATelaOrigem.Trim.IsEmpty)then
     raise ExceptionRequired.Create('Tela de origem da factory subgrupos de produtos necessária');

   Result := Self.Create(ATelaOrigem);
end;

constructor TModelProdutosSubGruposFactory.Create(ATelaOrigem: string);
begin
   FEntitie := TModelProdutosSubGruposEntitie.Create(Self);
end;

destructor TModelProdutosSubGruposFactory.Destroy;
begin
   if(Assigned(FEntitie))then
     FEntitie.Free;
   inherited;
end;

function TModelProdutosSubGruposFactory.Entitie: TModelProdutosSubGruposEntitie;
begin
   Result := FEntitie;
end;

function TModelProdutosSubGruposFactory.ConsultarEntitie: IModelProdutosSubGruposFactory<TModelProdutosSubGruposEntitie>;
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
        raise ExceptionError.Create('Não foi possível consultar o subgrupo',
                                    THIS + ': ' + FEntitie.IdMascara + sLineBreak +
                                    'Mensagem: ' + E.Message);
   end;
   end;

   Self.Entitie
    .Id(MyQuery.FieldByName('ID').AsString)
    .Nome(MyQuery.FieldByName('NOME').AsString)
    .Grupo(MyQuery.FieldByName('GRUPO').AsInteger)
    .End_Entitie;
end;

function TModelProdutosSubGruposFactory.Deletar: IModelProdutosSubGruposFactory<TModelProdutosSubGruposEntitie>;
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
        raise ExceptionError.Create('Não foi possível deletar o subgrupo',
                                    THIS + ': ' + FEntitie.IdMascara + sLineBreak +
                                    'Mensagem: ' + E.Message);
   end;
   end;
   TModelLogs.New.Gravar(FTelaOrigem,
                         'Exclusão de subgrupo de produto',
                         'Usuário excluiu o subgrupo ' + FEntitie.Id.ToString,
                         FEntitie.Id);
   FEntitie.Id(0);

   ShowDone('Exclusão realizada');
end;

function TModelProdutosSubGruposFactory.Gravar: IModelProdutosSubGruposFactory<TModelProdutosSubGruposEntitie>;
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
    .AddParam('GRUPO', FEntitie.Grupo);

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
        raise ExceptionError.Create('Não foi possível gravar o subgrupo',
                                    'Mensagem: ' + E.Message);
   end;
   end;

   TModelLogs.New.Gravar(FTelaOrigem,
                         LAcao + ' de subgrupo de produto',
                         'Usuário gravou o subgrupo ' + FEntitie.IdNome,
                         FEntitie.Id);

   ShowDone('Gravação realizada');
end;

procedure TModelProdutosSubGruposFactory.SQLInsert;
begin
   MyQueryNew
    .Add('INSERT INTO '+TABELA)
    .Add('(NOME, GRUPO)')
    .Add('VALUES')
    .Add('(:NOME, :GRUPO)')
    .Add('RETURNING ID');
end;

procedure TModelProdutosSubGruposFactory.SQLUpdate;
begin
   MyQueryNew
    .Add('UPDATE '+TABELA+' SET')
    .Add('NOME = :NOME, GRUPO = :GRUPO')
    .Add('WHERE('+TABELA+'.ID = :ID)')
    .AddParam('ID', FEntitie.Id);
end;

end.
