unit Utils.EditsKeyDownExit;

interface

uses
  Winapi.Windows,
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.StdCtrls;

procedure OnBuscaID(AId: Integer);

{$REGION 'CIDADES'}
procedure IdCidadeKeyDown(ASender: TEdit; AKey: Word; AShift: TShiftState);
procedure IdCidadeExit(AEdtId: TEdit); overload;
procedure IdCidadeExit(AEdtId, AEdtNome: TEdit); overload;
procedure IdCidadeExit(AEdtId, AEdtNome, AEdtUF: TEdit); overload;
{$ENDREGION 'CIDADES'}

{$REGION 'CLIENTES'}
procedure IdClienteKeyDown(ASender: TEdit; AKey: Word; AShift: TShiftState);
procedure IdClienteExit(AEdtId: TEdit); overload;
procedure IdClienteExit(AEdtId, AEdtNome: TEdit); overload;
{$ENDREGION 'CLIENTES'}

{$REGION 'FORNECEDORES'}
procedure IdFornecedorKeyDown(ASender: TEdit; AKey: Word; AShift: TShiftState);
procedure IdFornecedorExit(AEdtId: TEdit); overload;
procedure IdFornecedorExit(AEdtId, AEdtNome: TEdit); overload;
{$ENDREGION 'FORNECEDORES'}

{$REGION 'FUNCIONARIOS'}
procedure IdFuncionarioKeyDown(ASender: TEdit; AKey: Word; AShift: TShiftState);
procedure IdFuncionarioExit(AEdtId: TEdit); overload;
procedure IdFuncionarioExit(AEdtId, AEdtNome: TEdit); overload;
{$ENDREGION 'FUNCIONARIOS'}

{$REGION 'FUNCIONARIOS.FUNCOES'}
procedure IdFuncaoFuncionarioKeyDown(ASender: TEdit; AKey: Word; AShift: TShiftState);
procedure IdFuncaoFuncionarioExit(AEdtId: TEdit); overload;
procedure IdFuncaoFuncionarioExit(AEdtId, AEdtNome: TEdit); overload;
{$ENDREGION 'FUNCIONARIOS.FUNCOES'}

{$REGION 'PRODUTOS'}
procedure IdProdutoKeyDown(ASender: TEdit; AKey: Word; AShift: TShiftState);
procedure IdProdutoExit(AEdtId: TEdit); overload;
procedure IdProdutoExit(AEdtId, AEdtNome: TEdit); overload;
{$ENDREGION 'PRODUTOS'}

{$REGION 'PRODUTOS.GRUPOS'}
procedure IdGrupoProdutoKeyDown(ASender: TEdit; AKey: Word; AShift: TShiftState);
procedure IdGrupoProdutoExit(AEdtId: TEdit); overload;
procedure IdGrupoProdutoExit(AEdtId, AEdtNome: TEdit); overload;
{$ENDREGION 'PRODUTOS.GRUPOS'}

{$REGION 'PRODUTOS.SUBGRUPOS'}
procedure IdSubGrupoProdutoKeyDown(ASender: TEdit; AKey: Word; AShift: TShiftState);
procedure IdSubGrupoProdutoExit(AEdtId: TEdit); overload;
procedure IdSubGrupoProdutoExit(AEdtId, AEdtSubgrupo: TEdit); overload;
procedure IdSubGrupoProdutoExit(AEdtId, AEdtSubgrupo, AEdtGrupo: TEdit); overload;
{$ENDREGION 'PRODUTOS.SUBGRUPOS'}

{$REGION 'PRODUTOS.UNIDADES'}
procedure IdUnidadeProdutoKeyDown(ASender: TEdit; AKey: Word; AShift: TShiftState);
procedure IdUnidadeProdutoExit(AEdtId: TEdit); overload;
procedure IdUnidadeProdutoExit(AEdtId, AEdtSigla: TEdit); overload;
procedure IdUnidadeProdutoExit(AEdtId, AEdtSigla, AEdtNome: TEdit); overload;
{$ENDREGION 'PRODUTOS.UNIDADES'}

{$REGION 'FORMAS_PAGAMENTOS'}
procedure IdFormaPagamentoKeyDown(ASender: TEdit; AKey: Word; AShift: TShiftState);
procedure IdFormaPagamentoExit(AEdtId: TEdit); overload;
procedure IdFormaPagamentoExit(AEdtId, AEdtNome: TEdit); overload;
{$ENDREGION 'FORMAS_PAGAMENTOS'}

var
  FId: Integer;

implementation

uses
  MyConnection,
  Utils.MyLibrary,
  Utils.LibrarySistema,
  View.Cidades.Busca,
  View.Clientes.Busca,
  View.Fornecedores.Busca,
  View.Funcionarios.Busca,
  View.Funcionarios.Funcoes.Busca,
  View.Produtos.Busca,
  View.Produtos.Grupos.Busca,
  View.Produtos.SubGrupos.Busca,
  View.Produtos.Unidades.Busca,
  View.FormasPagamento.Busca;

procedure OnBuscaID(AId: Integer);
begin
   FId := AId;
end;

{$REGION 'CIDADES'}
procedure IdCidadeKeyDown(ASender: TEdit; AKey: Word; AShift: TShiftState);
begin
   if(not ((AKey = VK_F2)and(AShift = [])))then
     Exit;

   FId := 0;
   if(ViewCidadesBusca = nil)then Application.CreateForm(TViewCidadesBusca, ViewCidadesBusca);
   try
     ViewCidadesBusca.FOnBusca := OnBuscaId;
     ViewCidadesBusca.ShowModal;
   finally
     FreeAndNil(ViewCidadesBusca);
   end;

   if(FId > 0)then
     ASender.Text := TMyLibrary.CompLeft(FId);
end;

procedure IdCidadeExit(AEdtId: TEdit);
begin
   IdCidadeExit(AEdtId, nil);
end;

procedure IdCidadeExit(AEdtId, AEdtNome: TEdit);
begin
   IdCidadeExit(AEdtId, AEdtNome, nil);
end;

procedure IdCidadeExit(AEdtId, AEdtNome, AEdtUF: TEdit);
var
  LId: Integer;
begin
   if(AEdtId = nil)then
     Exit;

   if(AEdtUF <> nil)then
     AEdtUF.Clear;

   if(AEdtNome <> nil)then
     AEdtNome.Clear;

   LId := StrToIntDef(AEdtId.Text, 0);
   if(LId <= 0)then
   begin
      AEdtId.Clear;
      Exit;
   end;

   MyQueryNew
    .Add('SELECT ID, NOME, UF FROM CIDADES WHERE(CIDADES.ID = :ID)')
    .AddParam('ID', LId);

   ShowDebug(MyQuery.SQL.Text);
   MyQuery.Open;

   AEdtId.Text := TMyLibrary.CompLeft(MyQuery.FieldByName('ID').AsInteger);

   if(AEdtNome <> nil)then
     AEdtNome.Text := MyQuery.FieldByName('NOME').AsString;

   if(AEdtUF <> nil)then
     AEdtUF.Text := MyQuery.FieldByName('UF').AsString;
end;
{$ENDREGION 'CIDADES'}

{$REGION 'CLIENTES'}
procedure IdClienteKeyDown(ASender: TEdit; AKey: Word; AShift: TShiftState);
begin
   if(not ((AKey = VK_F2)and(AShift = [])))then
     Exit;

   FId := 0;
   if(ViewClientesBusca = nil)then Application.CreateForm(TViewClientesBusca, ViewClientesBusca);
   try
     ViewClientesBusca.FOnBusca := OnBuscaId;
     ViewClientesBusca.ShowModal;
   finally
     FreeAndNil(ViewClientesBusca);
   end;

   if(FId > 0)then
     ASender.Text := TMyLibrary.CompLeft(FId);
end;

procedure IdClienteExit(AEdtId: TEdit);
begin
   IdClienteExit(AEdtId, nil);
end;

procedure IdClienteExit(AEdtId, AEdtNome: TEdit);
var
  LId: Integer;
begin
   if(AEdtId = nil)then
     Exit;

   if(AEdtNome <> nil)then
     AEdtNome.Clear;

   LId := StrToIntDef(AEdtId.Text, 0);
   if(LId <= 0)then
   begin
      AEdtId.Clear;
      Exit;
   end;

   MyQueryNew
    .Add('SELECT ID, RAZAO_SOCIAL, NOME_FANTASIA FROM CLIENTES WHERE(CLIENTES.ID = :ID)')
    .AddParam('ID', LId);

   ShowDebug(MyQuery.SQL.Text);
   MyQuery.Open;

   AEdtId.Text := TMyLibrary.CompLeft(MyQuery.FieldByName('ID').AsInteger);

   if(AEdtNome <> nil)then
   begin
      AEdtNome.Text := MyQuery.FieldByName('NOME_FANTASIA').AsString;
      if(AEdtNome.Text = EmptyStr)then
        AEdtNome.Text := MyQuery.FieldByName('RAZAO_SOCIAL').AsString;
   end;
end;
{$ENDREGION 'CLIENTES'}

{$REGION 'FORNECEDORES'}
procedure IdFornecedorKeyDown(ASender: TEdit; AKey: Word; AShift: TShiftState);
begin
   if(not ((AKey = VK_F2)and(AShift = [])))then
     Exit;

   FId := 0;
   if(ViewFornecedoresBusca = nil)then Application.CreateForm(TViewFornecedoresBusca, ViewFornecedoresBusca);
   try
     ViewFornecedoresBusca.FOnBusca := OnBuscaId;
     ViewFornecedoresBusca.ShowModal;
   finally
     FreeAndNil(ViewFornecedoresBusca);
   end;

   if(FId > 0)then
     ASender.Text := TMyLibrary.CompLeft(FId);
end;

procedure IdFornecedorExit(AEdtId: TEdit); overload;
begin
   IdFornecedorExit(AEdtId, nil);
end;

procedure IdFornecedorExit(AEdtId, AEdtNome: TEdit); overload;
var
  LId: Integer;
begin
   if(AEdtId = nil)then
     Exit;

   if(AEdtNome <> nil)then
     AEdtNome.Clear;

   LId := StrToIntDef(AEdtId.Text, 0);
   if(LId <= 0)then
   begin
      AEdtId.Clear;
      Exit;
   end;

   MyQueryNew
    .Add('SELECT ID, RAZAO_SOCIAL, NOME_FANTASIA FROM FORNECEDORES WHERE(FORNECEDORES.ID = :ID)')
    .AddParam('ID', LId);

   ShowDebug(MyQuery.SQL.Text);
   MyQuery.Open;

   AEdtId.Text := TMyLibrary.CompLeft(MyQuery.FieldByName('ID').AsInteger);

   if(AEdtNome <> nil)then
   begin
      AEdtNome.Text := MyQuery.FieldByName('NOME_FANTASIA').AsString;
      if(AEdtNome.Text = EmptyStr)then
        AEdtNome.Text := MyQuery.FieldByName('RAZAO_SOCIAL').AsString;
   end;
end;
{$ENDREGION 'FORNECEDORES'}

{$REGION 'FUNCIONARIOS'}
procedure IdFuncionarioKeyDown(ASender: TEdit; AKey: Word; AShift: TShiftState);
begin
   if(not ((AKey = VK_F2)and(AShift = [])))then
     Exit;

   FId := 0;
   if(ViewFuncionariosBusca = nil)then Application.CreateForm(TViewFuncionariosBusca, ViewFuncionariosBusca);
   try
     ViewFuncionariosBusca.FOnBusca := OnBuscaId;
     ViewFuncionariosBusca.ShowModal;
   finally
     FreeAndNil(ViewFuncionariosBusca);
   end;

   if(FId > 0)then
     ASender.Text := TMyLibrary.CompLeft(FId);
end;

procedure IdFuncionarioExit(AEdtId: TEdit); overload;
begin
   IdFuncionarioExit(AEdtId, nil);
end;

procedure IdFuncionarioExit(AEdtId, AEdtNome: TEdit); overload;
var
  LId: Integer;
begin
   if(AEdtId = nil)then
     Exit;

   if(AEdtNome <> nil)then
     AEdtNome.Clear;

   LId := StrToIntDef(AEdtId.Text, 0);
   if(LId <= 0)then
   begin
      AEdtId.Clear;
      Exit;
   end;

   MyQueryNew
    .Add('SELECT ID, RAZAO_SOCIAL, NOME_FANTASIA FROM FUNCIONARIOS WHERE(FUNCIONARIOS.ID = :ID)')
    .AddParam('ID', LId);

   ShowDebug(MyQuery.SQL.Text);
   MyQuery.Open;

   AEdtId.Text := TMyLibrary.CompLeft(MyQuery.FieldByName('ID').AsInteger);

   if(AEdtNome <> nil)then
   begin
      AEdtNome.Text := MyQuery.FieldByName('NOME_FANTASIA').AsString;
      if(AEdtNome.Text = EmptyStr)then
        AEdtNome.Text := MyQuery.FieldByName('RAZAO_SOCIAL').AsString;
   end;
end;
{$ENDREGION 'FUNCIONARIOS'}

{$REGION 'FUNCIONARIOS.FUNCOES'}
procedure IdFuncaoFuncionarioKeyDown(ASender: TEdit; AKey: Word; AShift: TShiftState);
begin
   if(not ((AKey = VK_F2)and(AShift = [])))then
     Exit;

   FId := 0;
   if(ViewFuncionarioFuncoesBusca = nil)then Application.CreateForm(TViewFuncionarioFuncoesBusca, ViewFuncionarioFuncoesBusca);
   try
     ViewFuncionarioFuncoesBusca.FOnBusca := OnBuscaId;
     ViewFuncionarioFuncoesBusca.ShowModal;
   finally
     FreeAndNil(ViewFuncionarioFuncoesBusca);
   end;

   if(FId > 0)then
     ASender.Text := TMyLibrary.CompLeft(FId);
end;

procedure IdFuncaoFuncionarioExit(AEdtId: TEdit); overload;
begin
   IdFuncaoFuncionarioExit(AEdtId, nil);
end;

procedure IdFuncaoFuncionarioExit(AEdtId, AEdtNome: TEdit); overload;
var
  LId: Integer;
begin
   if(AEdtId = nil)then
     Exit;

   if(AEdtNome <> nil)then
     AEdtNome.Clear;

   LId := StrToIntDef(AEdtId.Text, 0);
   if(LId <= 0)then
   begin
      AEdtId.Clear;
      Exit;
   end;

   MyQueryNew
    .Add('SELECT ID, NOME FROM FUNCIONARIOS_FUNCOES WHERE(FUNCIONARIOS_FUNCOES.ID = :ID)')
    .AddParam('ID', LId);

   ShowDebug(MyQuery.SQL.Text);
   MyQuery.Open;

   AEdtId.Text := TMyLibrary.CompLeft(MyQuery.FieldByName('ID').AsInteger);

   if(AEdtNome <> nil)then
     AEdtNome.Text := MyQuery.FieldByName('NOME').AsString;
end;
{$ENDREGION 'FUNCIONARIOS.FUNCOES'}

{$REGION 'PRODUTOS'}
procedure IdProdutoKeyDown(ASender: TEdit; AKey: Word; AShift: TShiftState); 
begin
   if(not ((AKey = VK_F2)and(AShift = [])))then
     Exit;

   FId := 0;
   if(ViewProdutosBusca = nil)then Application.CreateForm(TViewProdutosBusca, ViewProdutosBusca);
   try
     ViewProdutosBusca.FOnBusca := OnBuscaId;
     ViewProdutosBusca.ShowModal;
   finally
     FreeAndNil(ViewProdutosBusca);
   end;

   if(FId > 0)then
     ASender.Text := TMyLibrary.CompLeft(FId);
end;

procedure IdProdutoExit(AEdtId: TEdit); overload;
begin
   IdProdutoExit(AEdtId, nil);
end;

procedure IdProdutoExit(AEdtId, AEdtNome: TEdit); overload;
var
  LId: Integer;
begin
   if(AEdtId = nil)then
     Exit;

   if(AEdtNome <> nil)then
     AEdtNome.Clear;

   LId := StrToIntDef(AEdtId.Text, 0);
   if(LId <= 0)then
   begin
      AEdtId.Clear;
      Exit;
   end;

   MyQueryNew
    .Add('SELECT ID, NOME FROM PRODUTOS WHERE(PRODUTOS.ID = :ID)')
    .AddParam('ID', LId);

   ShowDebug(MyQuery.SQL.Text);
   MyQuery.Open;

   AEdtId.Text := TMyLibrary.CompLeft(MyQuery.FieldByName('ID').AsInteger);

   if(AEdtNome <> nil)then
     AEdtNome.Text := MyQuery.FieldByName('NOME').AsString;
end;
{$ENDREGION 'PRODUTOS'}

{$REGION 'PRODUTOS.GRUPOS'}
procedure IdGrupoProdutoKeyDown(ASender: TEdit; AKey: Word; AShift: TShiftState);
begin
   if(not ((AKey = VK_F2)and(AShift = [])))then
     Exit;

   FId := 0;
   if(ViewProdutosGruposBusca = nil)then Application.CreateForm(TViewProdutosGruposBusca, ViewProdutosGruposBusca);
   try
     ViewProdutosGruposBusca.FOnBusca := OnBuscaId;
     ViewProdutosGruposBusca.ShowModal;
   finally
     FreeAndNil(ViewProdutosGruposBusca);
   end;

   if(FId > 0)then
     ASender.Text := TMyLibrary.CompLeft(FId);
end;

procedure IdGrupoProdutoExit(AEdtId: TEdit); overload;
begin
   IdGrupoProdutoExit(AEdtId, nil);
end;

procedure IdGrupoProdutoExit(AEdtId, AEdtNome: TEdit); overload;
var
  LId: Integer;
begin
   if(AEdtId = nil)then
     Exit;

   if(AEdtNome <> nil)then
     AEdtNome.Clear;

   LId := StrToIntDef(AEdtId.Text, 0);
   if(LId <= 0)then
   begin
      AEdtId.Clear;
      Exit;
   end;

   MyQueryNew
    .Add('SELECT ID, NOME FROM PRODUTOS_GRUPOS WHERE(PRODUTOS_GRUPOS.ID = :ID)')
    .AddParam('ID', LId);

   ShowDebug(MyQuery.SQL.Text);
   MyQuery.Open;

   AEdtId.Text := TMyLibrary.CompLeft(MyQuery.FieldByName('ID').AsInteger);

   if(AEdtNome <> nil)then
     AEdtNome.Text := MyQuery.FieldByName('NOME').AsString;
end;
{$ENDREGION 'PRODUTOS.GRUPOS'}

{$REGION 'PRODUTOS.SUBGRUPOS'}
procedure IdSubGrupoProdutoKeyDown(ASender: TEdit; AKey: Word; AShift: TShiftState);
begin
   if(not ((AKey = VK_F2)and(AShift = [])))then
     Exit;

   FId := 0;
   if(ViewProdutosSubGruposBusca = nil)then Application.CreateForm(TViewProdutosSubGruposBusca, ViewProdutosSubGruposBusca);
   try
     ViewProdutosSubGruposBusca.FOnBusca := OnBuscaId;
     ViewProdutosSubGruposBusca.ShowModal;
   finally
     FreeAndNil(ViewProdutosSubGruposBusca);
   end;

   if(FId > 0)then
     ASender.Text := TMyLibrary.CompLeft(FId);
end;

procedure IdSubGrupoProdutoExit(AEdtId: TEdit); overload;
begin
   IdSubGrupoProdutoExit(AEdtId, nil);
end;

procedure IdSubGrupoProdutoExit(AEdtId, AEdtSubgrupo: TEdit); overload;
begin
   IdSubGrupoProdutoExit(AEdtId, AEdtSubgrupo, nil);
end;

procedure IdSubGrupoProdutoExit(AEdtId, AEdtSubgrupo, AEdtGrupo: TEdit); overload;
var
  LId: Integer;
begin
   if(AEdtId = nil)then
     Exit;

   if(AEdtSubgrupo <> nil)then
     AEdtSubgrupo.Clear;

   if(AEdtGrupo <> nil)then
     AEdtGrupo.Clear;

   LId := StrToIntDef(AEdtId.Text, 0);
   if(LId <= 0)then
   begin
      AEdtId.Clear;
      Exit;
   end;

   MyQueryNew
    .Add('SELECT PRODUTOS_SUBGRUPOS.ID, PRODUTOS_SUBGRUPOS.NOME, PRODUTOS_GRUPOS.NOME AS NOME_GRUPO')
    .Add('FROM PRODUTOS_SUBGRUPOS ')
    .Add('LEFT JOIN PRODUTOS_GRUPOS ON(PRODUTOS_GRUPOS.ID = PRODUTOS_SUBGRUPOS.GRUPO)')
    .Add('WHERE(PRODUTOS_SUBGRUPOS.ID = :ID)')
    .AddParam('ID', LId);

   ShowDebug(MyQuery.SQL.Text);
   MyQuery.Open;

   AEdtId.Text := TMyLibrary.CompLeft(MyQuery.FieldByName('ID').AsInteger);

   if(AEdtSubgrupo <> nil)then
     AEdtSubgrupo.Text := MyQuery.FieldByName('NOME').AsString;

   if(AEdtGrupo <> nil)then
     AEdtGrupo.Text := MyQuery.FieldByName('NOME_GRUPO').AsString;
end;
{$ENDREGION 'PRODUTOS.SUBGRUPOS'}

{$REGION 'PRODUTOS.UNIDADES'}
procedure IdUnidadeProdutoKeyDown(ASender: TEdit; AKey: Word; AShift: TShiftState);
begin
   if(not ((AKey = VK_F2)and(AShift = [])))then
     Exit;

   FId := 0;
   if(ViewProdutosUnidadesBusca = nil)then Application.CreateForm(TViewProdutosUnidadesBusca, ViewProdutosUnidadesBusca);
   try
     ViewProdutosUnidadesBusca.FOnBusca := OnBuscaId;
     ViewProdutosUnidadesBusca.ShowModal;
   finally
     FreeAndNil(ViewProdutosUnidadesBusca);
   end;

   if(FId > 0)then
     ASender.Text := TMyLibrary.CompLeft(FId);
end;

procedure IdUnidadeProdutoExit(AEdtId: TEdit); overload;
begin
   IdUnidadeProdutoExit(AEdtId, nil);
end;

procedure IdUnidadeProdutoExit(AEdtId, AEdtSigla: TEdit); overload;
begin
   IdUnidadeProdutoExit(AEdtId, AEdtSigla, nil);
end;

procedure IdUnidadeProdutoExit(AEdtId, AEdtSigla, AEdtNome: TEdit); overload;
var
  LId: Integer;
begin
   if(AEdtId = nil)then
     Exit;

   if(AEdtSigla <> nil)then
     AEdtSigla.Clear;

   if(AEdtNome <> nil)then
     AEdtNome.Clear;

   LId := StrToIntDef(AEdtId.Text, 0);
   if(LId <= 0)then
   begin
      AEdtId.Clear;
      Exit;
   end;

   MyQueryNew
    .Add('SELECT PRODUTOS_UNIDADES.ID, PRODUTOS_UNIDADES.NOME, PRODUTOS_UNIDADES.SIGLA')
    .Add('FROM PRODUTOS_UNIDADES ')
    .Add('WHERE(PRODUTOS_UNIDADES.ID = :ID)')
    .AddParam('ID', LId);

   ShowDebug(MyQuery.SQL.Text);
   MyQuery.Open;

   AEdtId.Text := TMyLibrary.CompLeft(MyQuery.FieldByName('ID').AsInteger);

   if(AEdtSigla <> nil)then
     AEdtSigla.Text := MyQuery.FieldByName('SIGLA').AsString;

   if(AEdtNome <> nil)then
     AEdtNome.Text := MyQuery.FieldByName('NOME').AsString;
end;

{$ENDREGION 'PRODUTOS.UNIDADES'}

{$REGION 'FORMAS_PAGAMENTOS'}
procedure IdFormaPagamentoKeyDown(ASender: TEdit; AKey: Word; AShift: TShiftState);
begin
   if(not ((AKey = VK_F2)and(AShift = [])))then
     Exit;

   FId := 0;
   if(ViewFormasPagamentoBusca = nil)then Application.CreateForm(TViewFormasPagamentoBusca, ViewFormasPagamentoBusca);
   try
     ViewFormasPagamentoBusca.FOnBusca := OnBuscaId;
     ViewFormasPagamentoBusca.ShowModal;
   finally
     FreeAndNil(ViewFormasPagamentoBusca);
   end;

   if(FId > 0)then
     ASender.Text := TMyLibrary.CompLeft(FId);
end;

procedure IdFormaPagamentoExit(AEdtId: TEdit); overload;
begin
   IdFormaPagamentoExit(AEdtId, nil);
end;

procedure IdFormaPagamentoExit(AEdtId, AEdtNome: TEdit); overload;
var
  LId: Integer;
begin
   if(AEdtId = nil)then
     Exit;

   if(AEdtNome <> nil)then
     AEdtNome.Clear;

   LId := StrToIntDef(AEdtId.Text, 0);
   if(LId <= 0)then
   begin
      AEdtId.Clear;
      Exit;
   end;

   MyQueryNew
    .Add('SELECT FORMA_PAGAMENTO.ID, FORMA_PAGAMENTO.NOME')
    .Add('FROM FORMA_PAGAMENTO ')
    .Add('WHERE(FORMA_PAGAMENTO.ID = :ID)')
    .AddParam('ID', LId);

   ShowDebug(MyQuery.SQL.Text);
   MyQuery.Open;

   AEdtId.Text := TMyLibrary.CompLeft(MyQuery.FieldByName('ID').AsInteger);

   if(AEdtNome <> nil)then
     AEdtNome.Text := MyQuery.FieldByName('NOME').AsString;
end;
{$ENDREGION 'FORMAS_PAGAMENTOS'}

end.
