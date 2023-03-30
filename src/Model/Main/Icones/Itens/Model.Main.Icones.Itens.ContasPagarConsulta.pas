unit Model.Main.Icones.Itens.ContasPagarConsulta;

interface

implementation

uses
  Model.Main.Icones.Fields,
  Model.Main.Icones.Types,
  Model.Main.Icones.Lista.RegistrarProc,
  View.Sistema.Main;

procedure Registrar(AValue: TPairMainIconesFields);
begin
   AValue.Add(TMainIconName.ContasPagarConsulta,
              TModelMainIconesFields.Create
               .Caption('Contas à pagar')
               .CaptionShort('Consulta de contas à pagar')
               .ComponentName(TMainIconName.ContasPagarConsulta.ToString)
               .ResourceName('consulta_contas_pagar')
               .Hint('Consulta de contas à pagar')
               .OnClickViewMain(ViewSistemaMain.FinanceiroConsultaContasPagar1Click)
               .GroupOwner(TMainIconesGroup.Financeiro.ToInteger)
               );
end;

initialization
  TModelMainIconesListaRegistrarProc.GetInstance.Add(Registrar);

end.
