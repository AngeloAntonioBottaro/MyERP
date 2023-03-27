unit Model.Main.Icones.Itens.Produtos;

interface

implementation

uses
  Model.Main.Icones.Fields,
  Model.Main.Icones.Types,
  Model.Main.Icones.Lista.RegistrarProc,
  View.Sistema.Main;

procedure Registrar(AValue: TPairMainIconesFields);
begin
   AValue.Add(TMainIconName.Produtos,
              TModelMainIconesFields.Create
               .Caption('Produtos')
               .ComponentName(TMainIconName.Produtos.ToString)
               .ResourceName('produtos')
               .Hint('Cadastro de produtos')
               .OnClickViewMain(ViewSistemaMain.CadastrosProdutosCadastro1Click)
               .GroupOwner(TMainIconesGroup.Cadastros.ToInteger)
               );
end;

initialization
  TModelMainIconesListaRegistrarProc.GetInstance.Add(Registrar);

end.
