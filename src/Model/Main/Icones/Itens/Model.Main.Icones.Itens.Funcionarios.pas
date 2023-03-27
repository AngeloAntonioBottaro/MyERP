unit Model.Main.Icones.Itens.Funcionarios;

interface

implementation

uses
  Model.Main.Icones.Fields,
  Model.Main.Icones.Types,
  Model.Main.Icones.Lista.RegistrarProc,
  View.Sistema.Main;

procedure Registrar(AValue: TPairMainIconesFields);
begin
   AValue.Add(TMainIconName.Funcionarios,
              TModelMainIconesFields.Create
               .Caption('funcion�rios')
               .ComponentName(TMainIconName.Funcionarios.ToString)
               .ResourceName('funcionarios')
               .Hint('Cadastro de funcion�rios')
               .OnClickViewMain(ViewSistemaMain.CadastrosFuncionariosCadastro1Click)
               .GroupOwner(TMainIconesGroup.Cadastros.ToInteger)
               );
end;

initialization
  TModelMainIconesListaRegistrarProc.GetInstance.Add(Registrar);

end.
