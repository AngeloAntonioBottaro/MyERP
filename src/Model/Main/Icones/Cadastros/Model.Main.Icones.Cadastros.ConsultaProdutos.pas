unit Model.Main.Icones.Cadastros.ConsultaProdutos;

interface

implementation

uses
  Model.Main.Icones.Fields,
  Model.Main.Icones.Types,
  Model.Main.Icones.Lista.RegistrarProc,
  View.Main;

procedure Registrar(AValue: TPairMainIconesFields);
begin
   AValue.Add(TMainIconName.cbConsultaProdutos,
              TModelMainIconesFields.Create
               .Caption('Consulta produtos')
               .ComponentName(TMainIconName.cbConsultaProdutos.ToString)
               .ResourceName('consulta_produtos')
               .Hint('Tela de consulta de produtos')
               .PopupMenu(ViewMain.PopupMenuProdutos));
end;

initialization
  TModelMainIconesListaRegistrarProc.GetInstance.Add(Registrar);

end.
