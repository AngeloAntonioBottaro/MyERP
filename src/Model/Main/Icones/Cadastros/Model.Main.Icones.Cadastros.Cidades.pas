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
               .Caption('Cidades')
               .ComponentName(TMainIconName.ckCidades.ToString)
               .ResourceName('cidades')
               .Hint('Cadastro de cidades')
               .OnClickViewMain(ViewMain.CadastrosCidades1Cadastro1Click)
               );
end;

initialization
  TModelMainIconesListaRegistrarProc.GetInstance.Add(Registrar);

end.
