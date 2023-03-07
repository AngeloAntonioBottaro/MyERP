unit Model.Main.Icones.Itens.Cidades;

interface

implementation

uses
  Model.Main.Icones.Fields,
  Model.Main.Icones.Types,
  Model.Main.Icones.Lista.RegistrarProc,
  View.Sistema.Main;

procedure Registrar(AValue: TPairMainIconesFields);
begin
   AValue.Add(TMainIconName.Cidades,
              TModelMainIconesFields.Create
               .Caption('Cidades')
               .ComponentName(TMainIconName.Cidades.ToString)
               .ResourceName('cidades')
               .Hint('Cadastro de cidades')
               .OnClickViewMain(ViewSistemaMain.CadastrosCidades1Cadastro1Click)
               .GroupOwner(TMainIconesGroup.Cadastros.ToInteger)
               );
end;

initialization
  TModelMainIconesListaRegistrarProc.GetInstance.Add(Registrar);

end.
