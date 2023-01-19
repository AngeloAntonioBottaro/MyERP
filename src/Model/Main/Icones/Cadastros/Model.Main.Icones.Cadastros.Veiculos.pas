unit Model.Main.Icones.Cadastros.Veiculos;

interface

implementation

uses
  Model.Main.Icones.Fields,
  Model.Main.Icones.Types,
  Model.Main.Icones.Lista.RegistrarProc,
  View.Main;

procedure Registrar(AValue: TPairMainIconesFields);
begin
   AValue.Add(TMainIconName.cbVeiculos,
              TModelMainIconesFields.Create
               .Caption('Cadastro de veículos')
               .ComponentName(TMainIconName.cbVeiculos.ToString)
               .ResourceName('veiculos')
               .Hint('Cadastro de veículos')
               .PopupMenu(ViewMain.pMenuVeiculos));
end;

initialization
  TModelMainIconesListaRegistrarProc.GetInstance.Add(Registrar);

end.
