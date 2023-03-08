program MyERP;



{$R *.dres}

uses
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  System.SysUtils,
  View.Sistema.Main in 'src\View\Sistema\View.Sistema.Main.pas' {ViewSistemaMain},
  View.Sistema.Splash in 'src\View\Sistema\View.Sistema.Splash.pas' {ViewSistemaSplash},
  View.Base in 'src\View\Sistema\View.Base.pas' {ViewBase},
  View.Sistema.Login in 'src\View\Sistema\View.Sistema.Login.pas' {ViewSistemaLogin},
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
  Model.Main.Icones.Itens.Clientes in 'src\Model\Main\Icones\Itens\Model.Main.Icones.Itens.Clientes.pas',
  Model.Main.Icones.Itens.Fornecedores in 'src\Model\Main\Icones\Itens\Model.Main.Icones.Itens.Fornecedores.pas',
  Model.Main.Icones.Itens.Funcionarios in 'src\Model\Main\Icones\Itens\Model.Main.Icones.Itens.Funcionarios.pas',
  Model.Main.Icones.Itens.Produtos in 'src\Model\Main\Icones\Itens\Model.Main.Icones.Itens.Produtos.pas',
  Model.Main.Icones.Itens.Cidades in 'src\Model\Main\Icones\Itens\Model.Main.Icones.Itens.Cidades.pas',
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
  Model.Main.Icones.Componentes.PageControlIcones in 'src\Model\Main\Icones\Componentes\Model.Main.Icones.Componentes.PageControlIcones.pas',
  View.Sistema.Sobre in 'src\View\Sistema\View.Sistema.Sobre.pas' {ViewSistemaSobre},
  Utils.MyConsts in '..\MyUtilsLibrary\Utils.MyConsts.pas',
  Utils.MyLibrary in '..\MyUtilsLibrary\Utils.MyLibrary.pas',
  Utils.MyVclLibrary in '..\MyUtilsLibrary\Utils.MyVclLibrary.pas',
  MyExceptions.Base in '..\MyExceptions\Src\MyExceptions.Base.pas',
  MyExceptions in '..\MyExceptions\Src\MyExceptions.pas',
  Utils.MyObjectDictionary in '..\MyUtilsLibrary\Utils.MyObjectDictionary.pas',
  Utils.MyTypes in '..\MyUtilsLibrary\Utils.MyTypes.pas',
  MyMessage.Consts in '..\MyMessage\src\MyMessage.Consts.pas',
  MyMessage.Helpers.TMemo in '..\MyMessage\src\MyMessage.Helpers.TMemo.pas',
  MyMessage.Interfaces in '..\MyMessage\src\MyMessage.Interfaces.pas',
  MyMessage in '..\MyMessage\src\MyMessage.pas',
  MyMessage.Types in '..\MyMessage\src\MyMessage.Types.pas',
  MyMessage.View in '..\MyMessage\src\MyMessage.View.pas' {MyMessageView},
  View.Sistema.IconesConf in 'src\View\Sistema\View.Sistema.IconesConf.pas' {ViewSistemaIconesConf},
  Utils.MyFormLibrary in '..\MyUtilsLibrary\Utils.MyFormLibrary.pas',
  Utils.GlobalConsts in 'src\Utils\Utils.GlobalConsts.pas',
  Model.Clientes.Factory in 'src\Model\Clientes\Model.Clientes.Factory.pas',
  Model.Clientes.Interfaces in 'src\Model\Clientes\Model.Clientes.Interfaces.pas',
  Model.Clientes.Entitie in 'src\Model\Clientes\Model.Clientes.Entitie.pas';

{$R *.res}

begin
  Application.Initialize;
  TStyleManager.TrySetStyle('Amethyst Kamri');

  ViewSistemaSplash := TViewSistemaSplash.Create(nil);
  try
    ViewSistemaSplash.ShowModal;
    ViewSistemaSplash.Update;

    repeat
      Application.ProcessMessages;
    until ViewSistemaSplash.CloseQuery;
  finally
     FreeAndNil(ViewSistemaSplash);
  end;

  Application.Run;
end.
