unit Model.Main.Icones.Cadastros.Produtos;

interface

implementation

uses
  Model.Main.Icones.Fields,
  Model.Main.Icones.Types,
  Model.Main.Icones.Lista.RegistrarProc,
  View.Main;

procedure Registrar(AValue: TPairMainIconesFields);
begin
   AValue.Add(TMainIconName.ckProdutos,
              TModelMainIconesFields.Create
               .Caption('Produtos')
               .ComponentName(TMainIconName.ckProdutos.ToString)
               .ResourceName('produtos')
               .Hint('Cadastro de produtos')
               .OnClickViewMain(ViewMain.CadastrosProdutosCadastro1Click)
               .OnMouseMoveViewMain(ViewMain.MainIconesMouseMove)
               );
end;

initialization
  TModelMainIconesListaRegistrarProc.GetInstance.Add(Registrar);

end.
