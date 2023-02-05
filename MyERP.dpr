program MyERP;

{$R *.dres}

uses
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  System.SysUtils,
  View.Main in 'src\View\Sistema\View.Main.pas' {ViewMain},
  View.Splash in 'src\View\Sistema\View.Splash.pas' {ViewSplash},
  View.Base in 'src\View\Sistema\View.Base.pas' {ViewBase},
  View.Login in 'src\View\Sistema\View.Login.pas' {ViewLogin},
  Utils.Versao in 'src\Utils\Utils.Versao.pas',
  Utils.GlobalVariables in 'src\Utils\Utils.GlobalVariables.pas',
  Model.Sistema.Interfaces in 'src\Model\Sistema\Model.Sistema.Interfaces.pas',
  Model.Sistema.Splash in 'src\Model\Sistema\Model.Sistema.Splash.pas',
  MySearchComponents.Interfaces in '..\MySearchScreen\Src\MySearchComponents.Interfaces.pas',
  MySearchComponents in '..\MySearchScreen\Src\MySearchComponents.pas',
  MySearchComponents.Search in '..\MySearchScreen\Src\MySearchComponents.Search.pas',
  MySearchComponents.Utils in '..\MySearchScreen\Src\MySearchComponents.Utils.pas',
  MySearchComponents.View in '..\MySearchScreen\Src\MySearchComponents.View.pas' {MySearchComponentsView},
  View.Cidades.Busca in 'src\View\Cidades\View.Cidades.Busca.pas' {ViewCidadesBusca},
  View.Clientes.Busca in 'src\View\Clientes\View.Clientes.Busca.pas' {ViewClientesBusca},
  View.Produtos.Busca in 'src\View\Produtos\View.Produtos.Busca.pas' {ViewProdutosBusca},
  View.Produtos.Grupos.Busca in 'src\View\Produtos\Grupos\View.Produtos.Grupos.Busca.pas' {ViewProdutosGruposBusca},
  View.Produtos.SubGrupos.Busca in 'src\View\Produtos\SubGrupos\View.Produtos.SubGrupos.Busca.pas' {ViewProdutosSubGruposBusca},
  View.Funcionarios.Busca in 'src\View\Funcionarios\View.Funcionarios.Busca.pas' {ViewFuncionariosBusca},
  View.Funcionarios.Funcoes.Busca in 'src\View\Funcionarios\Funcoes\View.Funcionarios.Funcoes.Busca.pas' {ViewFuncionariosFuncoesBusca},
  Model.Behavior.Exceptions in 'src\Model\Behavior\Model.Behavior.Exceptions.pas',
  Model.Behavior in 'src\Model\Behavior\Model.Behavior.pas',
  Model.Sistema.Login in 'src\Model\Sistema\Model.Sistema.Login.pas',
  Model.Sistema.Imagens.DM in 'src\Model\Sistema\DM\Model.Sistema.Imagens.DM.pas' {ModelSistemaImagensDM: TDataModule},
  Model.Main.Icones.Fields in 'src\Model\Main\Icones\Model.Main.Icones.Fields.pas',
  Model.Main.Icones.Interfaces in 'src\Model\Main\Icones\Model.Main.Icones.Interfaces.pas',
  Model.Main.Icones.Lista in 'src\Model\Main\Icones\Model.Main.Icones.Lista.pas',
  Model.Main.Icones.Lista.RegistrarProc in 'src\Model\Main\Icones\Model.Main.Icones.Lista.RegistrarProc.pas',
  Model.Main.Icones in 'src\Model\Main\Icones\Model.Main.Icones.pas',
  Model.Main.Icones.Types in 'src\Model\Main\Icones\Model.Main.Icones.Types.pas',
  Model.Main.Icones.Cadastros.Clientes in 'src\Model\Main\Icones\Cadastros\Model.Main.Icones.Cadastros.Clientes.pas',
  Model.Main.Icones.Cadastros.Fornecedores in 'src\Model\Main\Icones\Cadastros\Model.Main.Icones.Cadastros.Fornecedores.pas',
  Model.Main.Icones.Cadastros.Funcionarios in 'src\Model\Main\Icones\Cadastros\Model.Main.Icones.Cadastros.Funcionarios.pas',
  Model.Main.Icones.Cadastros.Produtos in 'src\Model\Main\Icones\Cadastros\Model.Main.Icones.Cadastros.Produtos.pas',
  Model.Main.Icones.Cadastros.Cidades in 'src\Model\Main\Icones\Cadastros\Model.Main.Icones.Cadastros.Cidades.pas',
  View.Fornecedores.Busca in 'src\View\Fornecedores\View.Fornecedores.Busca.pas' {ViewFornecedoresBusca},
  Model.Main.Icones.Consts in 'src\Model\Main\Icones\Model.Main.Icones.Consts.pas',
  View.Base.Cadastros in 'src\View\Sistema\View.Base.Cadastros.pas' {ViewBaseCadastros},
  View.Cidades.Cad in 'src\View\Cidades\View.Cidades.Cad.pas' {ViewCidadesCad},
  View.Clientes.Cad in 'src\View\Clientes\View.Clientes.Cad.pas' {ViewClientesCad},
  View.Fornecedores.Cad in 'src\View\Fornecedores\View.Fornecedores.Cad.pas' {ViewFornecedoresCad},
  View.Funcionarios.Cad in 'src\View\Funcionarios\View.Funcionarios.Cad.pas' {ViewFuncionariosCad},
  View.Funcionarios.Funcoes.Cad in 'src\View\Funcionarios\Funcoes\View.Funcionarios.Funcoes.Cad.pas' {ViewFuncionariosFuncoesCad},
  View.Produtos.Cad in 'src\View\Produtos\View.Produtos.Cad.pas' {ViewProdutosCad},
  View.Produtos.Grupos.Cad in 'src\View\Produtos\Grupos\View.Produtos.Grupos.Cad.pas' {ViewProdutosGruposCad},
  View.Produtos.SubGrupos.Cad in 'src\View\Produtos\SubGrupos\View.Produtos.SubGrupos.Cad.pas' {ViewProdutosSubgruposCad},
  Model.Main.Icones.Componentes.PanelIcones in 'src\Model\Main\Icones\Componentes\Model.Main.Icones.Componentes.PanelIcones.pas',
  Model.Main.Icones.Lista.VisibilidadeManual in 'src\Model\Main\Icones\Model.Main.Icones.Lista.VisibilidadeManual.pas',
  Model.Main.Icones.Componentes.PageControlIcones in 'src\Model\Main\Icones\Componentes\Model.Main.Icones.Componentes.PageControlIcones.pas';

{$R *.res}

begin
  Application.Initialize;
  TStyleManager.TrySetStyle('Amethyst Kamri');
  Application.Title := 'AAB Softwares - ERP Simples';

  ViewSplash := TViewSplash.Create(nil);
  try
    ViewSplash.ShowModal;
    ViewSplash.Update;

    repeat
      Application.ProcessMessages;
    until ViewSplash.CloseQuery;
  finally
     FreeAndNil(ViewSplash);
  end;

  Application.Run;
end.
