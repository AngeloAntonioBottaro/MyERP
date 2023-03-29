unit Model.Main.Icones.Itens.Caixa;

interface

implementation

uses
  Model.Main.Icones.Fields,
  Model.Main.Icones.Types,
  Model.Main.Icones.Lista.RegistrarProc,
  View.Sistema.Main;

procedure Registrar(AValue: TPairMainIconesFields);
begin
   AValue.Add(TMainIconName.Caixa,
              TModelMainIconesFields.Create
               .Caption('Caixa')
               .ComponentName(TMainIconName.Caixa.ToString)
               .ResourceName('caixa')
               .Hint('Caixa diário')
               //.OnClickViewMain(ViewSistemaMain.)
               .GroupOwner(TMainIconesGroup.Financeiro.ToInteger)
               );
end;

initialization
  TModelMainIconesListaRegistrarProc.GetInstance.Add(Registrar);

end.
