unit Model.Main.Icones.Cadastros.Funcionarios;

interface

implementation

uses
  Model.Main.Icones.Fields,
  Model.Main.Icones.Types,
  Model.Main.Icones.Lista.RegistrarProc,
  View.Main;

procedure Registrar(AValue: TPairMainIconesFields);
begin
   AValue.Add(TMainIconName.cbFunc,
              TModelMainIconesFields.Create
               .Caption('funcionários')
               .ComponentName(TMainIconName.cbFunc.ToString)
               .ResourceName('func')
               .Hint('Cadastro de funcionários'));
end;

initialization
  TModelMainIconesListaRegistrarProc.GetInstance.Add(Registrar);

end.
