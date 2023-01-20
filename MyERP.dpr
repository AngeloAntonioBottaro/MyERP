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
  Utils.GlobalConstants in 'src\Utils\Utils.GlobalConstants.pas',
  View.Cidades.Cad in 'src\View\Cidades\View.Cidades.Cad.pas' {ViewCidadesCad},
  View.Cidades.Busca in 'src\View\Cidades\View.Cidades.Busca.pas' {ViewCidadesBusca},
  View.Clientes.Cad in 'src\View\Clientes\View.Clientes.Cad.pas' {ViewClientesCad},
  View.Clientes.Busca in 'src\View\Clientes\View.Clientes.Busca.pas' {ViewClientesBusca},
  View.Produtos.Cad in 'src\View\Produtos\View.Produtos.Cad.pas' {ViewProdutosCad},
  View.Produtos.Busca in 'src\View\Produtos\View.Produtos.Busca.pas' {ViewProdutosBusca},
  View.Produtos.Grupos.Cad in 'src\View\Produtos\Grupos\View.Produtos.Grupos.Cad.pas' {ViewProdutosGruposCad},
  View.Produtos.Grupos.Busca in 'src\View\Produtos\Grupos\View.Produtos.Grupos.Busca.pas' {ViewProdutosGruposBusca},
  View.Produtos.SubGrupos.Cad in 'src\View\Produtos\SubGrupos\View.Produtos.SubGrupos.Cad.pas' {ViewProdutosSubGruposCad},
  View.Produtos.SubGrupos.Busca in 'src\View\Produtos\SubGrupos\View.Produtos.SubGrupos.Busca.pas' {ViewProdutosSubGruposBusca},
  View.Funcionarios.Cad in 'src\View\Funcionarios\View.Funcionarios.Cad.pas' {ViewFuncionariosCad},
  View.Funcionarios.Busca in 'src\View\Funcionarios\View.Funcionarios.Busca.pas' {ViewFuncionariosBusca},
  View.Funcionarios.Funcoes.Cad in 'src\View\Funcionarios\Funcoes\View.Funcionarios.Funcoes.Cad.pas' {ViewFuncionariosFuncoesCad},
  View.Funcionarios.Funcoes.Busca in 'src\View\Funcionarios\Funcoes\View.Funcionarios.Funcoes.Busca.pas' {ViewFuncionariosFuncoesBusca},
  Model.Behavior.Exceptions in 'src\Model\Behavior\Model.Behavior.Exceptions.pas',
  Model.Behavior in 'src\Model\Behavior\Model.Behavior.pas',
  MyExceptions.Base in '..\MyExceptions\Src\MyExceptions.Base.pas',
  MyExceptions in '..\MyExceptions\Src\MyExceptions.pas',
  Model.Sistema.Login in 'src\Model\Sistema\Model.Sistema.Login.pas',
  Model.Sistema.Imagens.DM in 'src\Model\Sistema\Model.Sistema.Imagens.DM.pas' {ModelSistemaImagensDM: TDataModule},
  Utils.MyLibrary in '..\MyUtilsLibrary\Utils.MyLibrary.pas',
  MyMessage.Interfaces in '..\MyMessage\src\MyMessage.Interfaces.pas',
  MyMessage in '..\MyMessage\src\MyMessage.pas',
  MyMessage.Types in '..\MyMessage\src\MyMessage.Types.pas',
  MyMessage.View in '..\MyMessage\src\MyMessage.View.pas' {MyMessageView},
  Utils.MyVclLibrary in '..\MyUtilsLibrary\Utils.MyVclLibrary.pas',
  Model.Main.Icones.Criacoes in 'src\Model\Main\Icones\Model.Main.Icones.Criacoes.pas',
  Model.Main.Icones.Fields in 'src\Model\Main\Icones\Model.Main.Icones.Fields.pas',
  Model.Main.Icones.Interfaces in 'src\Model\Main\Icones\Model.Main.Icones.Interfaces.pas',
  Model.Main.Icones.Lista in 'src\Model\Main\Icones\Model.Main.Icones.Lista.pas',
  Model.Main.Icones.Lista.RegistrarProc in 'src\Model\Main\Icones\Model.Main.Icones.Lista.RegistrarProc.pas',
  Model.Main.Icones in 'src\Model\Main\Icones\Model.Main.Icones.pas',
  Model.Main.Icones.Types in 'src\Model\Main\Icones\Model.Main.Icones.Types.pas',
  Model.Main.Icones.Componentes.PanelAtalhos in 'src\Model\Main\Icones\Componentes\Model.Main.Icones.Componentes.PanelAtalhos.pas',
  Model.Main.Icones.Componentes in 'src\Model\Main\Icones\Componentes\Model.Main.Icones.Componentes.pas',
  Model.Main.Icones.Cadastros.Clientes in 'src\Model\Main\Icones\Cadastros\Model.Main.Icones.Cadastros.Clientes.pas',
  Model.Main.Icones.Cadastros.ConsultaProdutos in 'src\Model\Main\Icones\Cadastros\Model.Main.Icones.Cadastros.ConsultaProdutos.pas',
  Model.Main.Icones.Cadastros.Fornecedores in 'src\Model\Main\Icones\Cadastros\Model.Main.Icones.Cadastros.Fornecedores.pas',
  Model.Main.Icones.Cadastros.Funcionarios in 'src\Model\Main\Icones\Cadastros\Model.Main.Icones.Cadastros.Funcionarios.pas',
  Model.Main.Icones.Cadastros.Produtos in 'src\Model\Main\Icones\Cadastros\Model.Main.Icones.Cadastros.Produtos.pas',
  Model.Main.Icones.Cadastros.Cidades in 'src\Model\Main\Icones\Cadastros\Model.Main.Icones.Cadastros.Cidades.pas',
  Utils.MyObjectDictionary in '..\MyUtilsLibrary\Utils.MyObjectDictionary.pas',
  View.Fornecedores.Cad in 'src\View\Fornecedores\View.Fornecedores.Cad.pas' {ViewFornecedoresCad},
  View.Fornecedores.Busca in 'src\View\Fornecedores\View.Fornecedores.Busca.pas' {ViewFornecedoresBusca};

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
