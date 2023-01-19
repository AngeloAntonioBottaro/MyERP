unit Model.Main.Icones.Cadastros.Fornecedores;

interface

implementation

uses
  Model.Main.Icones.Fields,
  Model.Main.Icones.Types,
  Model.Main.Icones.Lista.RegistrarProc,
  View.Main;

procedure Registrar(AValue: TPairMainIconesFields);
begin
   AValue.Add(TMainIconName.cbFornecedores,
              TModelMainIconesFields.Create
               .Caption('Fornecedores')
               .ComponentName(TMainIconName.cbFornecedores.ToString)
               .ResourceName('fornecedores')
               .Hint('Cadastro de Fornecedores')
               .PopupMenu(ViewMain.pMenuRelatorios)
               .Tag(789011));
end;

initialization
  TModelMainIconesListaRegistrarProc.GetInstance.Add(Registrar);

end.
