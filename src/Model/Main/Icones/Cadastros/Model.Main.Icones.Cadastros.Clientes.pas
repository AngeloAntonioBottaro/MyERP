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
               .Hint('Cadastro de clientes')
               .OnClickViewMain(ViewMain.CadastrosClientesCadastro1Click)
               .OnMouseMoveViewMain(ViewMain.MainIconesMouseMove)
               );
end;

initialization
  TModelMainIconesListaRegistrarProc.GetInstance.Add(Registrar);

end.
