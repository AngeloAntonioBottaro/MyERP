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
   AValue.Add(TMainIconName.cbProdutos,
              TModelMainIconesFields.Create
               .Caption('Produtos')
               .ComponentName(TMainIconName.cbProdutos.ToString)
               .ResourceName('produtos')
               .Hint('Cadastro de produtos')
               .PopupMenu(ViewMain.PopupMenuProdutos));
end;

initialization
  TModelMainIconesListaRegistrarProc.GetInstance.Add(Registrar);

end.
