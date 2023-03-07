unit Model.Main.Icones.Itens.Clientes;

interface

implementation

uses
  Model.Main.Icones.Fields,
  Model.Main.Icones.Types,
  Model.Main.Icones.Lista.RegistrarProc,
  View.Sistema.Main;

procedure Registrar(AValue: TPairMainIconesFields);
begin
   AValue.Add(TMainIconName.Clientes,
              TModelMainIconesFields.Create
               .Caption('Clientes')
               .ComponentName(TMainIconName.Clientes.ToString)
               .ResourceName('clientes')
               .Hint('Cadastro de clientes')
               .OnClickViewMain(ViewSistemaMain.CadastrosClientesCadastro1Click)
               .GroupOwner(TMainIconesGroup.Cadastros.ToInteger)
               );
end;

initialization
  TModelMainIconesListaRegistrarProc.GetInstance.Add(Registrar);

end.
