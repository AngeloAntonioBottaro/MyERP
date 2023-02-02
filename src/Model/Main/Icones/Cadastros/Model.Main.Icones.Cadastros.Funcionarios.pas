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
   AValue.Add(TMainIconName.Funcionarios,
              TModelMainIconesFields.Create
               .Caption('funcionários')
               .ComponentName(TMainIconName.Funcionarios.ToString)
               .ResourceName('funcionarios')
               .Hint('Cadastro de funcionários')
               .OnClickViewMain(ViewMain.CadastrosFuncionariosCadastro1Click)
               );
end;

initialization
  TModelMainIconesListaRegistrarProc.GetInstance.Add(Registrar);

end.
