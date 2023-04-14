program MyERP;

{$R *.dres}

uses
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  System.SysUtils,
  View.Sistema.Main in 'src\View\Sistema\View.Sistema.Main.pas' {ViewSistemaMain},
  View.Sistema.Splash in 'src\View\Sistema\View.Sistema.Splash.pas' {ViewSistemaSplash},
  View.Base in 'src\View\Sistema\Base\View.Base.pas' {ViewBase},
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
  Model.Main.Icones.Itens.Produtos in 'src\Model\Main\Icones\Itens\Model.Main.Icones.Itens.Produtos.pas',
  Model.Main.Icones.Consts in 'src\Model\Main\Icones\Model.Main.Icones.Consts.pas',
  View.Base.Cadastros in 'src\View\Sistema\Base\View.Base.Cadastros.pas' {ViewBaseCadastros},
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
  Model.Clientes.Factory in 'src\Model\Clientes\Model.Clientes.Factory.pas',
  Model.Clientes.Interfaces in 'src\Model\Clientes\Model.Clientes.Interfaces.pas',
  Model.Clientes.Entitie in 'src\Model\Clientes\Model.Clientes.Entitie.pas',
  View.Base.Busca in 'src\View\Sistema\Base\View.Base.Busca.pas' {ViewBaseBusca},
  View.Cidades.Busca in 'src\View\Cidades\View.Cidades.Busca.pas' {ViewCidadesBusca},
  View.Clientes.Busca in 'src\View\Clientes\View.Clientes.Busca.pas' {ViewClientesBusca},
  View.Fornecedores.Busca in 'src\View\Fornecedores\View.Fornecedores.Busca.pas' {ViewFornecedoresBusca},
  View.Funcionarios.Busca in 'src\View\Funcionarios\View.Funcionarios.Busca.pas' {ViewFuncionariosBusca},
  View.Funcionarios.Funcoes.Busca in 'src\View\Funcionarios\Funcoes\View.Funcionarios.Funcoes.Busca.pas' {ViewFuncionarioFuncoesBusca},
  View.Produtos.Busca in 'src\View\Produtos\View.Produtos.Busca.pas' {ViewProdutosBusca},
  View.Produtos.Grupos.Busca in 'src\View\Produtos\Grupos\View.Produtos.Grupos.Busca.pas' {ViewProdutosGruposBusca},
  View.Produtos.SubGrupos.Busca in 'src\View\Produtos\SubGrupos\View.Produtos.SubGrupos.Busca.pas' {ViewProdutosSubGruposBusca},
  Model.Fornecedores.Interfaces in 'src\Model\Fornecedores\Model.Fornecedores.Interfaces.pas',
  Model.Funcionarios.Interfaces in 'src\Model\Funcionarios\Model.Funcionarios.Interfaces.pas',
  Model.Fornecedores.Entitie in 'src\Model\Fornecedores\Model.Fornecedores.Entitie.pas',
  Utils.GlobalConsts in 'src\Utils\Utils.GlobalConsts.pas',
  Model.Fornecedores.Factory in 'src\Model\Fornecedores\Model.Fornecedores.Factory.pas',
  Model.Funcionarios.Entitie in 'src\Model\Funcionarios\Model.Funcionarios.Entitie.pas',
  Model.Funcionarios.Factory in 'src\Model\Funcionarios\Model.Funcionarios.Factory.pas',
  Model.Funcionarios.Funcoes.Interfaces in 'src\Model\Funcionarios\Funcoes\Model.Funcionarios.Funcoes.Interfaces.pas',
  Model.Funcionarios.Funcoes.Entitie in 'src\Model\Funcionarios\Funcoes\Model.Funcionarios.Funcoes.Entitie.pas',
  Model.Funcionarios.Funcoes.Factory in 'src\Model\Funcionarios\Funcoes\Model.Funcionarios.Funcoes.Factory.pas',
  Model.Cidades.Interfaces in 'src\Model\Cidades\Model.Cidades.Interfaces.pas',
  Model.Cidades.Entitie in 'src\Model\Cidades\Model.Cidades.Entitie.pas',
  Model.Cidades.Factory in 'src\Model\Cidades\Model.Cidades.Factory.pas',
  Model.Produtos.Grupos.Interfaces in 'src\Model\Produtos\Grupos\Model.Produtos.Grupos.Interfaces.pas',
  Model.Produtos.Grupos.Entitie in 'src\Model\Produtos\Grupos\Model.Produtos.Grupos.Entitie.pas',
  Model.Produtos.Grupos.Factory in 'src\Model\Produtos\Grupos\Model.Produtos.Grupos.Factory.pas',
  Model.Produtos.SubGrupos.Interfaces in 'src\Model\Produtos\SubGrupos\Model.Produtos.SubGrupos.Interfaces.pas',
  Model.Produtos.SubGrupos.Entitie in 'src\Model\Produtos\SubGrupos\Model.Produtos.SubGrupos.Entitie.pas',
  Model.Produtos.SubGrupos.Factory in 'src\Model\Produtos\SubGrupos\Model.Produtos.SubGrupos.Factory.pas',
  Utils.MyIniLibrary in '..\MyUtilsLibrary\Utils.MyIniLibrary.pas',
  MyConnection.Configuration in '..\MyConnection\src\MyConnection.Configuration.pas',
  MyConnection.FireDAC.ComponentConnection in '..\MyConnection\src\MyConnection.FireDAC.ComponentConnection.pas',
  MyConnection.FireDAC.Query in '..\MyConnection\src\MyConnection.FireDAC.Query.pas',
  MyConnection.Interfaces in '..\MyConnection\src\MyConnection.Interfaces.pas',
  MyConnection in '..\MyConnection\src\MyConnection.pas',
  MyConnection.Types in '..\MyConnection\src\MyConnection.Types.pas',
  Utils.LibrarySistema in 'src\Utils\Utils.LibrarySistema.pas',
  Model.Clientes.Busca in 'src\Model\Clientes\Busca\Model.Clientes.Busca.pas',
  MyConnectionConfiguration.Consts in '..\MyConnectionConfiguration\src\MyConnectionConfiguration.Consts.pas',
  MyConnectionConfiguration.Ini in '..\MyConnectionConfiguration\src\MyConnectionConfiguration.Ini.pas',
  MyConnectionConfiguration in '..\MyConnectionConfiguration\src\MyConnectionConfiguration.pas',
  MyConnectionConfiguration.View.Lista in '..\MyConnectionConfiguration\src\MyConnectionConfiguration.View.Lista.pas' {ViewLista},
  MyConnectionConfiguration.View.Manutencao in '..\MyConnectionConfiguration\src\MyConnectionConfiguration.View.Manutencao.pas' {ViewManutencao},
  MyConnectionConfiguration.View.SelecionarConexao in '..\MyConnectionConfiguration\src\MyConnectionConfiguration.View.SelecionarConexao.pas' {ViewSelecionarConexao},
  Utils.EditsKeyDownExit in 'src\Utils\Utils.EditsKeyDownExit.pas',
  Model.Cidades.Busca in 'src\Model\Cidades\Busca\Model.Cidades.Busca.pas',
  Model.Fornecedores.Busca in 'src\Model\Fornecedores\Busca\Model.Fornecedores.Busca.pas',
  Model.Funcionarios.Busca in 'src\Model\Funcionarios\Busca\Model.Funcionarios.Busca.pas',
  Model.Funcionarios.Funcoes.Busca in 'src\Model\Funcionarios\Funcoes\Busca\Model.Funcionarios.Funcoes.Busca.pas',
  Model.Produtos.Grupos.Busca in 'src\Model\Produtos\Grupos\Busca\Model.Produtos.Grupos.Busca.pas',
  Model.Produtos.SubGrupos.Busca in 'src\Model\Produtos\SubGrupos\Busca\Model.Produtos.SubGrupos.Busca.pas',
  Model.Produtos.Busca in 'src\Model\Produtos\Busca\Model.Produtos.Busca.pas',
  Model.Produtos.Factory in 'src\Model\Produtos\Model.Produtos.Factory.pas',
  Model.Produtos.Interfaces in 'src\Model\Produtos\Model.Produtos.Interfaces.pas',
  Model.Produtos.Entitie in 'src\Model\Produtos\Model.Produtos.Entitie.pas',
  Utils.MyGridLibrary in '..\MyUtilsLibrary\Utils.MyGridLibrary.pas',
  Model.Main.Icones.Itens.Vendas in 'src\Model\Main\Icones\Itens\Model.Main.Icones.Itens.Vendas.pas',
  Model.Main.Icones.Itens.Compras in 'src\Model\Main\Icones\Itens\Model.Main.Icones.Itens.Compras.pas',
  Model.Main.Icones.Itens.Caixa in 'src\Model\Main\Icones\Itens\Model.Main.Icones.Itens.Caixa.pas',
  Model.Main.Icones.Itens.ContasReceberConsulta in 'src\Model\Main\Icones\Itens\Model.Main.Icones.Itens.ContasReceberConsulta.pas',
  Model.Main.Icones.Itens.ContasReceberCadastro in 'src\Model\Main\Icones\Itens\Model.Main.Icones.Itens.ContasReceberCadastro.pas',
  Model.Main.Icones.Itens.ContasPagarConsulta in 'src\Model\Main\Icones\Itens\Model.Main.Icones.Itens.ContasPagarConsulta.pas',
  Model.Main.Icones.Itens.ContasPagarCadastro in 'src\Model\Main\Icones\Itens\Model.Main.Icones.Itens.ContasPagarCadastro.pas',
  Model.Produtos.Unidades.Interfaces in 'src\Model\Produtos\Unidades\Model.Produtos.Unidades.Interfaces.pas',
  Model.Produtos.Unidades.Entitie in 'src\Model\Produtos\Unidades\Model.Produtos.Unidades.Entitie.pas',
  Model.Produtos.Unidades.Factory in 'src\Model\Produtos\Unidades\Model.Produtos.Unidades.Factory.pas',
  View.Produtos.Unidades.Busca in 'src\View\Produtos\Unidades\View.Produtos.Unidades.Busca.pas' {ViewProdutosUnidadesBusca},
  View.Produtos.Unidades.Cad in 'src\View\Produtos\Unidades\View.Produtos.Unidades.Cad.pas' {ViewProdutosUnidadesCad},
  Model.Produtos.Unidades.Busca in 'src\Model\Produtos\Unidades\Busca\Model.Produtos.Unidades.Busca.pas',
  View.FormasPagamento.Cad in 'src\View\FormasPagamento\View.FormasPagamento.Cad.pas' {ViewFormasPagamentoCad},
  View.FormasPagamento.Busca in 'src\View\FormasPagamento\View.FormasPagamento.Busca.pas' {ViewFormasPagamentoBusca},
  Model.FormasPagamento.Interfaces in 'src\Model\FormasPagamento\Model.FormasPagamento.Interfaces.pas',
  Model.FormasPagamento.Entitie in 'src\Model\FormasPagamento\Model.FormasPagamento.Entitie.pas',
  Model.FormasPagamento.Factory in 'src\Model\FormasPagamento\Model.FormasPagamento.Factory.pas',
  Model.FormasPagamento.Busca in 'src\Model\FormasPagamento\Busca\Model.FormasPagamento.Busca.pas',
  View.Sistema.Empresa.Cad in 'src\View\Sistema\View.Sistema.Empresa.Cad.pas' {ViewSistemaEmpresaCad},
  Model.Empresas.Interfaces in 'src\Model\Empresas\Model.Empresas.Interfaces.pas',
  Model.Empresas.Entitie in 'src\Model\Empresas\Model.Empresas.Entitie.pas',
  Model.Empresas.Factory in 'src\Model\Empresas\Model.Empresas.Factory.pas',
  Model.Main.Icones.Itens.Agenda in 'src\Model\Main\Icones\Itens\Model.Main.Icones.Itens.Agenda.pas',
  View.Agenda.Cad in 'src\View\Agenda\View.Agenda.Cad.pas' {ViewAgendaCad},
  Model.Agenda.Interfaces in 'src\Model\Agenda\Model.Agenda.Interfaces.pas',
  Model.Agenda.Entitie in 'src\Model\Agenda\Model.Agenda.Entitie.pas',
  Model.Agenda.Factory in 'src\Model\Agenda\Model.Agenda.Factory.pas',
  View.Agenda.Busca in 'src\View\Agenda\View.Agenda.Busca.pas' {ViewAgendaBusca},
  Model.Agenda.Busca in 'src\Model\Agenda\Busca\Model.Agenda.Busca.pas',
  View.Sistema.MenuConf in 'src\View\Sistema\View.Sistema.MenuConf.pas' {ViewSistemaMenuConf};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TViewSistemaMenuConf, ViewSistemaMenuConf);
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
