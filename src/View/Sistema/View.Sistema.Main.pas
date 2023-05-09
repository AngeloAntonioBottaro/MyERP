unit View.Sistema.Main;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Threading,
  System.SyncObjs,
  View.Base,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.Menus,
  Vcl.ComCtrls,
  Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TViewSistemaMain = class(TViewBase)
    MainMenu: TMainMenu;
    Cadastros1: TMenuItem;
    CadastrosClientes1: TMenuItem;
    CadastrosProdutos1: TMenuItem;
    StatusBar: TStatusBar;
    CadastrosFuncionarios1: TMenuItem;
    CadastrosProdutosCadastro1: TMenuItem;
    CadastrosGruposProdutos1: TMenuItem;
    CadastrosSubgruposProdutos1: TMenuItem;
    Movimentacoes1: TMenuItem;
    Financeiro1: TMenuItem;
    Relatorios1: TMenuItem;
    imgLogo: TImage;
    CadastrosFuncionariosCadastro1: TMenuItem;
    CadastrosFuncionariosFuncoes1: TMenuItem;
    CadastrosCidades1: TMenuItem;
    Sair1: TMenuItem;
    pMenuMain: TPopupMenu;
    AtualizarIconesDeAtalhos1: TMenuItem;
    CadastrosFornecedores1: TMenuItem;
    CadastrosFornecedoresCadastro1: TMenuItem;
    CadastrosClientesCadastro1: TMenuItem;
    OcultarIcones1: TMenuItem;
    CadastrosCidades1Cadastro1: TMenuItem;
    Suporte1: TMenuItem;
    SuporteSobreSistema1: TMenuItem;
    TimerFormResize: TTimer;
    N1: TMenuItem;
    Configurarcones1: TMenuItem;
    CadastrosUnidadeProdutos1: TMenuItem;
    FormaPagamento1: TMenuItem;
    CadastroFormaPagamentoCadastro1: TMenuItem;
    Configuracoes1: TMenuItem;
    ConfiguracoesEmpresa1: TMenuItem;
    N2: TMenuItem;
    ConfiguracoesParametrosDoSistema1: TMenuItem;
    MovimentacoesVendas1: TMenuItem;
    MovimentacoesCompras1: TMenuItem;
    FinanceiroCaixadiario1: TMenuItem;
    FinanceiroContasReceber: TMenuItem;
    FinanceiroConsultaContasReceber1: TMenuItem;
    FinanceiroCadastroContasReceber1: TMenuItem;
    FinanceiroContasPagar1: TMenuItem;
    FinanceiroConsultaContasPagar1: TMenuItem;
    FinanceiroCadastroContasPagar1: TMenuItem;
    MovimentacoesAgenda1: TMenuItem;
    N3: TMenuItem;
    SuporteExtras1: TMenuItem;
    SuporteExtrasTelasCriadas1: TMenuItem;
    Logs1: TMenuItem;
    RelatoriosClientes1: TMenuItem;
    RelatoriosProdutos1: TMenuItem;
    RelatoriosCompras1: TMenuItem;
    RelatoriosVendas1: TMenuItem;
    RelatoriosAgenda1: TMenuItem;
    RelatoriosCaixa1: TMenuItem;
    RelatoriosContaReceber1: TMenuItem;
    RelatoriosContasPagar1: TMenuItem;
    ConfiguracoesPermissoes1: TMenuItem;
    Cadastros2: TMenuItem;
    RelatoriosFornecedores1: TMenuItem;
    Movimentacoes2: TMenuItem;
    Financeiro2: TMenuItem;
    N4: TMenuItem;
    CadastrosFuncionariosGrupoPermissoes1: TMenuItem;
    N5: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CadastrosProdutosCadastro1Click(Sender: TObject);
    procedure CadastrosGruposProdutos1Click(Sender: TObject);
    procedure CadastrosSubgruposProdutos1Click(Sender: TObject);
    procedure CadastrosFuncionariosCadastro1Click(Sender: TObject);
    procedure CadastrosFuncionariosFuncoes1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Sair1Click(Sender: TObject);
    procedure AtualizarIconesDeAtalhos1Click(Sender: TObject);
    procedure CadastrosClientesCadastro1Click(Sender: TObject);
    procedure CadastrosFornecedoresCadastro1Click(Sender: TObject);
    procedure OcultarIcones1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CadastrosCidades1Cadastro1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure TimerFormResizeTimer(Sender: TObject);
    procedure SuporteSobreSistema1Click(Sender: TObject);
    procedure Configurarcones1Click(Sender: TObject);
    procedure CadastrosUnidadeProdutos1Click(Sender: TObject);
    procedure CadastroFormaPagamentoCadastro1Click(Sender: TObject);
    procedure MovimentacoesVendas1Click(Sender: TObject);
    procedure MovimentacoesCompras1Click(Sender: TObject);
    procedure FinanceiroCaixadiario1Click(Sender: TObject);
    procedure FinanceiroConsultaContasReceber1Click(Sender: TObject);
    procedure FinanceiroCadastroContasReceber1Click(Sender: TObject);
    procedure FinanceiroConsultaContasPagar1Click(Sender: TObject);
    procedure FinanceiroCadastroContasPagar1Click(Sender: TObject);
    procedure ConfiguracoesEmpresa1Click(Sender: TObject);
    procedure MovimentacoesAgenda1Click(Sender: TObject);
    procedure SuporteExtrasTelasCriadas1Click(Sender: TObject);
    procedure Logs1Click(Sender: TObject);
    procedure CadastrosFuncionariosGrupoPermissoes1Click(Sender: TObject);
    procedure ConfiguracoesParametrosDoSistema1Click(Sender: TObject);
    procedure ConfiguracoesPermissoes1Click(Sender: TObject);
  private
    procedure DoLoggin;
    procedure ProcessStatus;
    procedure ProcessImageLogo(AImageFile: string);
    procedure CreateShortcutIcons;
    procedure ValidarDadosEmpresa;
  public
  end;

var
  ViewSistemaMain: TViewSistemaMain;

implementation

{$R *.dfm}

uses
  Common.Utils.MyVclLibrary,
  Common.Utils.MyLibrary,
  Common.Utils.MyFormLibrary,
  Utils.Versao,
  Utils.GlobalVariables,
  MyMessage,
  MyExceptions,
  Model.Sistema.Imagens.DM,
  Model.Main.Icones,
  View.Sistema.Login,
  View.Sistema.IconesConf,
  View.Sistema.Sobre,
  View.Sistema.Empresa.Cad,
  View.Cidades.Cad,
  View.Clientes.Cad,
  View.Produtos.Cad,
  View.Produtos.Grupos.Cad,
  View.Produtos.SubGrupos.Cad,
  View.Produtos.Unidades.Cad,
  View.Funcionarios.Cad,
  View.Funcionarios.Funcoes.Cad,
  View.Fornecedores.Cad,
  View.FormasPagamento.Cad,
  View.Agenda.Cad,
  View.Logs.Busca,
  View.Permissoes.Grupos.Cad, View.Sistema.SenhaAdm, View.Compras.Cad, View.Vendas.Cad, View.Caixa.CaixaDiario;

{$REGION 'FormEvents'}
procedure TViewSistemaMain.FormCreate(Sender: TObject);
begin
   Self.Caption := Application.Title + TUtilsVersao.CompleteVersion;

   TMyFormLibrary.New
    .FormMaximized
    .ConfForm(Self);
end;

procedure TViewSistemaMain.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case(Key)of
    VK_ESCAPE: if(Shift = [])then Sair1.Click;
   end;

   inherited;
end;

procedure TViewSistemaMain.FormShow(Sender: TObject);
var
 LTask: ITask;
begin
   Self.DoLoggin;
   LTask := TTask.Create(
     procedure
     begin
        TThread.Synchronize(nil,
          procedure
          begin
             Sleep(50);
             Self.ProcessStatus;
             Self.ProcessImageLogo(VG_Logo);
          end);
     end
    );
   LTask.Start;
   Self.ValidarDadosEmpresa;
end;

procedure TViewSistemaMain.FormResize(Sender: TObject);
begin
   TimerFormResize.Enabled := False;
   TimerFormResize.Enabled := True;
end;

procedure TViewSistemaMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if(not ShowQuestionNo('Deseja encerrar o sistema?'))then
     Abort;
end;
{$ENDREGION 'FormEvents'}

{$REGION 'EVENTS'}
procedure TViewSistemaMain.TimerFormResizeTimer(Sender: TObject);
begin
   TimerFormResize.Enabled := False;
   Self.CreateShortcutIcons;
end;

{$ENDREGION 'EVENTS'}

{$REGION 'MenuEvents'}
procedure TViewSistemaMain.Logs1Click(Sender: TObject);
begin
   if(ViewLogsBusca = nil)then Application.CreateForm(TViewLogsBusca, ViewLogsBusca);
   try
     ViewLogsBusca.ShowModal;
   finally
     FreeAndNil(ViewLogsBusca);
   end;
end;

procedure TViewSistemaMain.AtualizarIconesDeAtalhos1Click(Sender: TObject);
begin
   Self.CreateShortcutIcons;
end;

procedure TViewSistemaMain.OcultarIcones1Click(Sender: TObject);
begin
   TModelMainIcones.GetInstance
    .PanelIcones
     .Formulario(Self)
     .LimparComponente;
end;

procedure TViewSistemaMain.MovimentacoesCompras1Click(Sender: TObject);
begin
   if(ViewComprasCad = nil)then Application.CreateForm(TViewComprasCad, ViewComprasCad);
   try
     ViewComprasCad.ShowModal;
   finally
     FreeAndNil(ViewComprasCad);
   end;
end;

procedure TViewSistemaMain.MovimentacoesVendas1Click(Sender: TObject);
begin
   if(ViewVendasCad = nil)then Application.CreateForm(TViewVendasCad, ViewVendasCad);
   try
     ViewVendasCad.ShowModal;
   finally
     FreeAndNil(ViewVendasCad);
   end;
end; 

procedure TViewSistemaMain.FinanceiroCaixadiario1Click(Sender: TObject);
begin
   if(ViewCaixaCaixaDiario = nil)then Application.CreateForm(TViewCaixaCaixaDiario, ViewCaixaCaixaDiario);
   try
     ViewCaixaCaixaDiario.ShowModal;
   finally
     FreeAndNil(ViewCaixaCaixaDiario);
   end;
end;

procedure TViewSistemaMain.FinanceiroCadastroContasPagar1Click(Sender: TObject);
begin
   //
end;

procedure TViewSistemaMain.FinanceiroCadastroContasReceber1Click(Sender: TObject);
begin
   //
end;

procedure TViewSistemaMain.FinanceiroConsultaContasPagar1Click(Sender: TObject);
begin
   //
end;

procedure TViewSistemaMain.FinanceiroConsultaContasReceber1Click(Sender: TObject);
begin
   //
end;

procedure TViewSistemaMain.MovimentacoesAgenda1Click(Sender: TObject);
begin
   if(ViewAgendaCad = nil)then Application.CreateForm(TViewAgendaCad, ViewAgendaCad);
   try
     ViewAgendaCad.ShowModal;
   finally
     FreeAndNil(ViewAgendaCad);
   end;
end;

procedure TViewSistemaMain.ConfiguracoesEmpresa1Click(Sender: TObject);
begin
   if(ViewSistemaEmpresaCad = nil)then Application.CreateForm(TViewSistemaEmpresaCad, ViewSistemaEmpresaCad);
   try
     ViewSistemaEmpresaCad.ShowModal;
   finally
     FreeAndNil(ViewSistemaEmpresaCad);
   end;
end;

procedure TViewSistemaMain.ConfiguracoesParametrosDoSistema1Click(Sender: TObject);
begin
   if(not ChamaSenhaAdministrativa)then
     Exit;

   //TELA CONFIGURACOES
end;

procedure TViewSistemaMain.ConfiguracoesPermissoes1Click(Sender: TObject);
begin
   if(not ChamaSenhaAdministrativa)then
     Exit;

   //TELA PERMISSOES
end;

procedure TViewSistemaMain.CadastroFormaPagamentoCadastro1Click(Sender: TObject);
begin
   if(ViewFormasPagamentoCad = nil)then Application.CreateForm(TViewFormasPagamentoCad, ViewFormasPagamentoCad);
   try
     ViewFormasPagamentoCad.ShowModal;
   finally
     FreeAndNil(ViewFormasPagamentoCad);
   end;
end;

procedure TViewSistemaMain.CadastrosCidades1Cadastro1Click(Sender: TObject);
begin
   if(ViewCidadesCad = nil)then Application.CreateForm(TViewCidadesCad, ViewCidadesCad);
   try
     ViewCidadesCad.ShowModal;
   finally
     FreeAndNil(ViewCidadesCad);
   end;
end;

procedure TViewSistemaMain.CadastrosClientesCadastro1Click(Sender: TObject);
begin
   if(ViewClientesCad = nil)then Application.CreateForm(TViewClientesCad, ViewClientesCad);
   try
     ViewClientesCad.ShowModal;
   finally
     FreeAndNil(ViewClientesCad);
   end;
end;

procedure TViewSistemaMain.CadastrosFornecedoresCadastro1Click(Sender: TObject);
begin
   if(ViewFornecedoresCad = nil)then Application.CreateForm(TViewFornecedoresCad, ViewFornecedoresCad);
   try
     ViewFornecedoresCad.ShowModal;
   finally
     FreeAndNil(ViewFornecedoresCad);
   end;
end;

procedure TViewSistemaMain.CadastrosFuncionariosCadastro1Click(Sender: TObject);
begin
   if(ViewFuncionariosCad = nil)then Application.CreateForm(TViewFuncionariosCad, ViewFuncionariosCad);
   try
     ViewFuncionariosCad.ShowModal;
   finally
     FreeAndNil(ViewFuncionariosCad);
   end;
end;

procedure TViewSistemaMain.CadastrosFuncionariosFuncoes1Click(Sender: TObject);
begin
   if(ViewFuncionariosFuncoesCad = nil)then Application.CreateForm(TViewFuncionariosFuncoesCad, ViewFuncionariosFuncoesCad);
   try
     ViewFuncionariosFuncoesCad.ShowModal;
   finally
     FreeAndNil(ViewFuncionariosFuncoesCad);
   end;
end;

procedure TViewSistemaMain.CadastrosFuncionariosGrupoPermissoes1Click(Sender: TObject);
begin
   inherited;
   if(ViewPermissoesGruposCad = nil)then Application.CreateForm(TViewPermissoesGruposCad, ViewPermissoesGruposCad);
   try
     ViewPermissoesGruposCad.ShowModal;
   finally
     FreeAndNil(ViewPermissoesGruposCad);
   end;
end;

procedure TViewSistemaMain.CadastrosGruposProdutos1Click(Sender: TObject);
begin
   if(ViewProdutosGruposCad = nil)then Application.CreateForm(TViewProdutosGruposCad, ViewProdutosGruposCad);
   try
     ViewProdutosGruposCad.ShowModal;
   finally
     FreeAndNil(ViewProdutosGruposCad);
   end;
end;

procedure TViewSistemaMain.CadastrosProdutosCadastro1Click(Sender: TObject);
begin
   if(ViewProdutosCad = nil)then Application.CreateForm(TViewProdutosCad, ViewProdutosCad);
   try
     ViewProdutosCad.ShowModal;
   finally
     FreeAndNil(ViewProdutosCad);
   end;
end;

procedure TViewSistemaMain.CadastrosSubgruposProdutos1Click(Sender: TObject);
begin
   if(ViewProdutosSubGruposCad = nil)then Application.CreateForm(TViewProdutosSubGruposCad, ViewProdutosSubGruposCad);
   try
     ViewProdutosSubGruposCad.ShowModal;
   finally
     FreeAndNil(ViewProdutosSubGruposCad);
   end;
end;

procedure TViewSistemaMain.Configurarcones1Click(Sender: TObject);
begin
   if(ViewSistemaIconesConf = nil)then Application.CreateForm(TViewSistemaIconesConf, ViewSistemaIconesConf);
   try
     ViewSistemaIconesConf.ShowModal;
   finally
     FreeAndNil(ViewSistemaIconesConf);
   end;
   Self.CreateShortcutIcons;
end;

procedure TViewSistemaMain.SuporteExtrasTelasCriadas1Click(Sender: TObject);
var
  I: integer;
  LTemp: String;
begin
   for I := 0 to Pred(Screen.FormCount) do
     LTemp := LTemp + Screen.Forms[I].Name + ' [' + Screen.Forms[I].Caption + ']' + sLineBreak;

   ShowInformation('Clique em ver mais detalhes', LTemp);
end;

procedure TViewSistemaMain.SuporteSobreSistema1Click(Sender: TObject);
begin
   if(ViewSistemaSobre = nil)then Application.CreateForm(TViewSistemaSobre, ViewSistemaSobre);
   try
     ViewSistemaSobre.ShowModal;
   finally
     FreeAndNil(ViewSistemaSobre);
   end;
end;

procedure TViewSistemaMain.Sair1Click(Sender: TObject);
begin
   Self.Close;
end;

procedure TViewSistemaMain.CadastrosUnidadeProdutos1Click(Sender: TObject);
begin
   if(ViewProdutosUnidadesCad = nil)then Application.CreateForm(TViewProdutosUnidadesCad, ViewProdutosUnidadesCad);
   try
     ViewProdutosUnidadesCad.ShowModal;
   finally
     FreeAndNil(ViewProdutosUnidadesCad);
   end;
end;

{$ENDREGION'MenuEvents'}

{$REGION 'Procedures'}
procedure TViewSistemaMain.ProcessStatus;
begin
   //STATUS BAR
   StatusBar.Panels[0].Text := 'Usuário: '  + VG_UsuarioLogadoId.ToString + ' - ' + VG_UsuarioLogadoNome;
   StatusBar.Panels[1].Text := 'Terminal: ' + TMyLibrary.GetNetUserName;
   StatusBar.Panels[2].Text := 'Servidor: ' + VG_Host;
   StatusBar.Panels[3].Text := 'Dados: '    + VG_Database;
end;

procedure TViewSistemaMain.ProcessImageLogo(AImageFile: string);
begin
   if(not FileExists(AImageFile))then
     Exit;

   try
     imgLogo.Picture.LoadFromFile(AImageFile);
   except on E: Exception do
     showError('Não foi possível carregar a logo do sistema');
   end;
end;

procedure TViewSistemaMain.CreateShortcutIcons;
var
  LTask: ITask;
begin
   if(VG_UsuarioLogadoId = 0)then
     Exit;

   LTask := TTask.Create(
              procedure
              begin
                 TThread.Synchronize(nil,
                   procedure
                   begin
                       try
                         TModelMainIcones.GetInstance
                          .PanelIcones
                           .Formulario(Self)
                           .CriarComponente;
                       except on E: Exception do
                         ShowError(E.Message);
                       end;
                   end);
              end
             );
   LTask.Start;
end;

procedure TViewSistemaMain.DoLoggin;
begin
   if(ViewSistemaLogin = nil)then Application.CreateForm(TViewSistemaLogin, ViewSistemaLogin);
   try
     ViewSistemaLogin.ShowModal;
   finally
     FreeAndNil(ViewSistemaLogin);
   end;
end;

procedure TViewSistemaMain.ValidarDadosEmpresa;
begin
   if(TMyLibrary.UnlockSpecialComands)then
     Exit;

   GetEmpresaLogada.ConsultarEntitie;
   if(GetEmpresaLogada.Entitie.Cnpj().IsEmpty and GetEmpresaLogada.Entitie.Cpf().IsEmpty)then
     Self.ConfiguracoesEmpresa1.Click;
end;
{$ENDREGION 'Procedures'}

end.
