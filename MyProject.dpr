program MyProject;

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
  Utils.VclLibrary in '..\MyLibrary\Utils.VclLibrary.pas',
  MySearchComponents.Interfaces in '..\MySearchScreen\Src\MySearchComponents.Interfaces.pas',
  MySearchComponents in '..\MySearchScreen\Src\MySearchComponents.pas',
  MySearchComponents.Search in '..\MySearchScreen\Src\MySearchComponents.Search.pas',
  MySearchComponents.Utils in '..\MySearchScreen\Src\MySearchComponents.Utils.pas',
  MySearchComponents.View in '..\MySearchScreen\Src\MySearchComponents.View.pas' {MySearchComponentsView},
  Utils.MyLibrary in '..\MyLibrary\Utils.MyLibrary.pas',
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
  MyMessage.Interfaces in '..\MyMsg\src\MyMessage.Interfaces.pas',
  MyMessage in '..\MyMsg\src\MyMessage.pas',
  MyMessage.Types in '..\MyMsg\src\MyMessage.Types.pas',
  Model.Behavior.Exceptions in 'src\Model\Behavior\Model.Behavior.Exceptions.pas',
  Model.Behavior in 'src\Model\Behavior\Model.Behavior.pas',
  MyExceptions.Base in '..\MyExceptions\Src\MyExceptions.Base.pas',
  MyExceptions in '..\MyExceptions\Src\MyExceptions.pas',
  MyMessage.View in '..\MyMsg\src\MyMessage.View.pas' {MyMessageView},
  Model.Sistema.Login in 'src\Model\Sistema\Model.Sistema.Login.pas',
  Model.Sistema.Imagens.DM in 'src\Model\Sistema\Model.Sistema.Imagens.DM.pas' {ModelSistemaImagensDM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  TStyleManager.TrySetStyle('Amethyst Kamri');
  Application.Title := 'AAB Softwares';

  Application.CreateForm(TModelSistemaImagensDM, ModelSistemaImagensDM);
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
