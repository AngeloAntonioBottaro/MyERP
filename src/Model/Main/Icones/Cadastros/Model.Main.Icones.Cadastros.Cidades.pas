unit Model.Main.Icones.Cadastros.Cidades;

interface

implementation

uses
  Model.Main.Icones.Fields,
  Model.Main.Icones.Types,
  Model.Main.Icones.Lista.RegistrarProc,
  View.Main;

procedure Registrar(AValue: TPairMainIconesFields);
begin
   AValue.Add(TMainIconName.ckCidades,
              TModelMainIconesFields.Create
               .Caption('Cadastro de cidades')
               .ComponentName(TMainIconName.ckCidades.ToString)
               .ResourceName('cidades')
               .Hint('Cadastro de cidades')
               //.PopupMenu(ViewMain.pMenuVeiculos)
               );
end;

initialization
  TModelMainIconesListaRegistrarProc.GetInstance.Add(Registrar);

end.
