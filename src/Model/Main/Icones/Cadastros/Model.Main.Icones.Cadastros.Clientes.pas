unit Model.Main.Icones.Cadastros.Clientes;

interface

implementation

uses
  Model.Main.Icones.Fields,
  Model.Main.Icones.Types,
  Model.Main.Icones.Lista.RegistrarProc,
  View.Main;

procedure Registrar(AValue: TPairMainIconesFields);
begin
   AValue.Add(TMainIconName.ckClientes,
              TModelMainIconesFields.Create
               .Caption('Clientes')
               .ComponentName(TMainIconName.ckClientes.ToString)
               .ResourceName('clientes')
               .Hint('Tela de cadastro de clientes')
               //.PopupMenu(ViewMain.pMenuRelatorios)
               .Tag(789001));
end;

initialization
  TModelMainIconesListaRegistrarProc.GetInstance.Add(Registrar);

end.
