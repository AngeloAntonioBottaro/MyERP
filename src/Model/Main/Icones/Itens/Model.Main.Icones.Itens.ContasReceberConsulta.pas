unit Model.Main.Icones.Itens.ContasReceberConsulta;

interface

implementation

uses
  Model.Main.Icones.Fields,
  Model.Main.Icones.Types,
  Model.Main.Icones.Lista.RegistrarProc,
  View.Sistema.Main;

procedure Registrar(AValue: TPairMainIconesFields);
begin
   AValue.Add(TMainIconName.ContasReceberConsulta,
              TModelMainIconesFields.Create
               .Caption('Contas à receber')
               .CaptionShort('Consulta de contas à receber')
               .ComponentName(TMainIconName.ContasReceberConsulta.ToString)
               .ResourceName('consulta_contas_receber')
               .Hint('Consulta de contas à receber')
               //.OnClickViewMain(ViewSistemaMain.)
               .GroupOwner(TMainIconesGroup.Financeiro.ToInteger)
               );
end;

initialization
  TModelMainIconesListaRegistrarProc.GetInstance.Add(Registrar);

end.
