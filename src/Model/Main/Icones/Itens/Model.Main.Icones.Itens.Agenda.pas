unit Model.Main.Icones.Itens.Agenda;

interface

implementation

uses
  Model.Main.Icones.Fields,
  Model.Main.Icones.Types,
  Model.Main.Icones.Lista.RegistrarProc,
  View.Sistema.Main;

procedure Registrar(AValue: TPairMainIconesFields);
begin
   AValue.Add(TMainIconName.Agenda,
              TModelMainIconesFields.Create
               .Caption('Agenda')
               .ComponentName(TMainIconName.Agenda.ToString)
               .ResourceName('agenda')
               .Hint('Agenda de compromissos')
               .OnClickViewMain(ViewSistemaMain.MovimentacoesAgenda1Click)
               .GroupOwner(TMainIconesGroup.Outros.ToInteger)
               );
end;

initialization
  TModelMainIconesListaRegistrarProc.GetInstance.Add(Registrar);

end.
