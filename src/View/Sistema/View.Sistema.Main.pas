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
    procedure CadastroProdutosConsultaProdutosClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure StatusBarClick(Sender: TObject);
    procedure TimerFormResizeTimer(Sender: TObject);
    procedure SuporteSobreSistema1Click(Sender: TObject);
    procedure Configurarcones1Click(Sender: TObject);
  private
    FCount: Integer;
    procedure DoLoggin;
    procedure ProcessStatus;
    procedure ProcessImageLogo(AImageFile: string);
    procedure CreateShortcutIcons;
  public
  end;

var
  ViewSistemaMain: TViewSistemaMain;

implementation

{$R *.dfm}

uses
  Utils.MyVclLibrary,
  Utils.MyLibrary,
  Utils.MyFormLibrary,
  Utils.Versao,
  Utils.GlobalVariables,
  MyMessage,
  MyExceptions,
  Model.Sistema.Imagens.DM,
  Model.Main.Icones,
  View.Sistema.Login,
  View.Sistema.IconesConf,
  View.Sistema.Sobre,
  View.Cidades.Cad,
  View.Clientes.Cad,
  View.Produtos.Cad,
  View.Produtos.Grupos.Cad,
  View.Produtos.SubGrupos.Cad,
  View.Funcionarios.Cad,
  View.Funcionarios.Funcoes.Cad,
  View.Fornecedores.Cad,
  View.Produtos.Busca;

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

{$REGION 'MenuEvents'}
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

procedure TViewSistemaMain.CadastroProdutosConsultaProdutosClick(Sender: TObject);
begin
   if(ViewProdutosBusca = nil)then Application.CreateForm(TViewProdutosBusca, ViewProdutosBusca);
   try
     ViewProdutosBusca.ShowModal;
   finally
     FreeAndNil(ViewProdutosBusca);
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
procedure TViewSistemaMain.StatusBarClick(Sender: TObject);
begin
   inherited;
   FCount := 0;
end;

procedure TViewSistemaMain.TimerFormResizeTimer(Sender: TObject);
begin
   TimerFormResize.Enabled := False;
   Inc(FCount);
                         StatusBar.Panels[3].Text := FCount.ToString;
   Self.CreateShortcutIcons;
end;

{$ENDREGION'MenuEvents'}

{$REGION 'Procedures'}
procedure TViewSistemaMain.ProcessStatus;
begin
   //STATUS BAR
   StatusBar.Panels[0].Text := 'Usu?rio: ' + VG_UsuarioLogadoId.ToString + ' - ' + VG_UsuarioLogadoNome;
   StatusBar.Panels[1].Text := 'Terminal: ' + TMyLibrary.GetNetUserName;
   StatusBar.Panels[2].Text := 'Servidor: localhost';
end;

procedure TViewSistemaMain.ProcessImageLogo(AImageFile: string);
begin
   if(not FileExists(AImageFile))then
     Exit;

   try
     imgLogo.Picture.LoadFromFile(AImageFile);
   except on E: Exception do
     showError('N?o foi poss?vel carregar a logo do sistema');
   end;
end;

procedure TViewSistemaMain.CreateShortcutIcons;
var
  LTask: ITask;
begin
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

{$ENDREGION 'Procedures'}

end.
