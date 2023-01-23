unit View.Main;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Threading,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.Menus,
  Vcl.ComCtrls,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  View.Base;

type
  TViewMain = class(TViewBase)
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
    AtualizarSistema1: TMenuItem;
    CadastrosCidades1Cadastro1: TMenuItem;
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
    procedure AtualizarSistema1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CadastrosCidades1Cadastro1Click(Sender: TObject);
    procedure CadastroProdutosConsultaProdutosClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    procedure DoLoggin;
    procedure ConfForm;
    procedure ProcessStatus;
    procedure ProcessImageLogo;
    procedure CriarIconesAtalhos;
  public
  end;

var
  ViewMain: TViewMain;

implementation

{$R *.dfm}

uses
  Utils.MyVclLibrary,
  Utils.MyLibrary,
  Utils.Versao,
  Utils.GlobalVariables,
  MyMessage,
  MyExceptions,
  Model.Sistema.Imagens.DM,
  Model.Main.Icones,
  View.Login,
  View.Cidades.Cad,
  View.Clientes.Cad,
  View.Produtos.Cad,
  View.Produtos.Grupos.Cad,
  View.Produtos.SubGrupos.Cad,
  View.Funcionarios.Cad,
  View.Funcionarios.Funcoes.Cad,
  View.Fornecedores.Cad,
  View.Produtos.Busca;

procedure TViewMain.FormCreate(Sender: TObject);
begin
   TMyVclLibrary.New
    .FormMaximized
    .ConfForm(Self);

   Self.Caption := Application.Title + TUtilsVersao.CompleteVersion;
end;

procedure TViewMain.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case(Key)of
    VK_ESCAPE: if(Shift = [])then Sair1.Click;
   end;

   inherited;
end;

procedure TViewMain.FormShow(Sender: TObject);
begin
   Self.DoLoggin;
   Self.ConfForm;
end;

procedure TViewMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if(not showPerguntaN('Deseja encerrar o sistema?'))then
     Abort;
end;

procedure TViewMain.AtualizarIconesDeAtalhos1Click(Sender: TObject);
begin
   Self.CriarIconesAtalhos;
end;

procedure TViewMain.AtualizarSistema1Click(Sender: TObject);
begin
   Self.ConfForm;
end;

procedure TViewMain.CadastroProdutosConsultaProdutosClick(Sender: TObject);
begin
   if(ViewProdutosBusca = nil)then Application.CreateForm(TViewProdutosBusca, ViewProdutosBusca);
   try
     ViewProdutosBusca.ShowModal;
   finally
     FreeAndNil(ViewProdutosBusca);
   end;
end;

procedure TViewMain.CadastrosCidades1Cadastro1Click(Sender: TObject);
begin
   if(ViewCidadesCad = nil)then Application.CreateForm(TViewCidadesCad, ViewCidadesCad);
   try
     ViewCidadesCad.ShowModal;
   finally
     FreeAndNil(ViewCidadesCad);
   end;
end;

procedure TViewMain.CadastrosClientesCadastro1Click(Sender: TObject);
begin
   if(ViewClientesCad = nil)then Application.CreateForm(TViewClientesCad, ViewClientesCad);
   try
     ViewClientesCad.ShowModal;
   finally
     FreeAndNil(ViewClientesCad);
   end;
end;

procedure TViewMain.CadastrosFornecedoresCadastro1Click(Sender: TObject);
begin
   if(ViewFornecedoresCad = nil)then Application.CreateForm(TViewFornecedoresCad, ViewFornecedoresCad);
   try
     ViewFornecedoresCad.ShowModal;
   finally
     FreeAndNil(ViewFornecedoresCad);
   end;
end;

procedure TViewMain.CadastrosFuncionariosCadastro1Click(Sender: TObject);
begin
   if(ViewFuncionariosCad = nil)then Application.CreateForm(TViewFuncionariosCad, ViewFuncionariosCad);
   try
     ViewFuncionariosCad.ShowModal;
   finally
     FreeAndNil(ViewFuncionariosCad);
   end;
end;

procedure TViewMain.CadastrosFuncionariosFuncoes1Click(Sender: TObject);
begin
   if(ViewFuncionariosFuncoesCad = nil)then Application.CreateForm(TViewFuncionariosFuncoesCad, ViewFuncionariosFuncoesCad);
   try
     ViewFuncionariosFuncoesCad.ShowModal;
   finally
     FreeAndNil(ViewFuncionariosFuncoesCad);
   end;
end;

procedure TViewMain.CadastrosGruposProdutos1Click(Sender: TObject);
begin
   if(ViewProdutosGruposCad = nil)then Application.CreateForm(TViewProdutosGruposCad, ViewProdutosGruposCad);
   try
     ViewProdutosGruposCad.ShowModal;
   finally
     FreeAndNil(ViewProdutosGruposCad);
   end;
end;

procedure TViewMain.CadastrosProdutosCadastro1Click(Sender: TObject);
begin
   if(ViewProdutosCad = nil)then Application.CreateForm(TViewProdutosCad, ViewProdutosCad);
   try
     ViewProdutosCad.ShowModal;
   finally
     FreeAndNil(ViewProdutosCad);
   end;
end;

procedure TViewMain.CadastrosSubgruposProdutos1Click(Sender: TObject);
begin
   if(ViewProdutosSubGruposCad = nil)then Application.CreateForm(TViewProdutosSubGruposCad, ViewProdutosSubGruposCad);
   try
     ViewProdutosSubGruposCad.ShowModal;
   finally
     FreeAndNil(ViewProdutosSubGruposCad);
   end;
end;

procedure TViewMain.DoLoggin;
begin
   if(ViewLogin = nil)then Application.CreateForm(TViewLogin, ViewLogin);
   try
     ViewLogin.ShowModal;
   finally
     FreeAndNil(ViewLogin);
   end;
end;

procedure TViewMain.ConfForm;
var
 LTask: ITask;
begin
   LTask := TTask.Create(
    procedure
    begin
       TThread.Synchronize(nil,
         procedure
         begin
            Sleep(50);
            Self.ProcessStatus;
            Self.ProcessImageLogo;
            Self.CriarIconesAtalhos;
         end);
    end
   );
   LTask.Start;
end;

procedure TViewMain.ProcessStatus;
begin
   //STATUS BAR
   StatusBar.Panels[0].Text := 'Usuário: ' + VG_UsuarioLogadoId.ToString + ' - ' + VG_UsuarioLogadoNome;
   StatusBar.Panels[1].Text := 'Terminal: ' + TMyLibrary.GetNetUserName;
   StatusBar.Panels[2].Text := 'Servidor: localhost';
end;

procedure TViewMain.ProcessImageLogo;
begin
   if(not FileExists(VG_Logo))then
     Exit;

   try
     imgLogo.Picture.LoadFromFile(VG_Logo);
   except on E: Exception do
     showErro('Não foi possível carregar a logo do sistema');
   end;
end;

procedure TViewMain.CriarIconesAtalhos;
begin
   try
     TModelMainIcones.GetInstance
      .AtualizaVisibilidades
      .Componentes
       .Formulario(Self)
       .CriarPanelIcones;
   except on E: Exception do
   end;
end;

procedure TViewMain.Sair1Click(Sender: TObject);
begin
   Self.Close;
end;

procedure TViewMain.FormResize(Sender: TObject);
var
 LTask: ITask;
begin
   LTask := TTask.Create(
    procedure
    begin
       TThread.Synchronize(nil,
         procedure
         begin
            Sleep(50);
            Self.CriarIconesAtalhos;
         end);
    end
   );
   LTask.Start;
end;

end.
