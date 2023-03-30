unit Model.Main.Icones.Itens.ContasPagarCadastro;

interface

implementation

uses
  Model.Main.Icones.Fields,
  Model.Main.Icones.Types,
  Model.Main.Icones.Lista.RegistrarProc,
  View.Sistema.Main;

procedure Registrar(AValue: TPairMainIconesFields);
begin
   AValue.Add(TMainIconName.ContasPagarCadastro,
              TModelMainIconesFields.Create
               .Caption('Cadastro de contas à pagar')
               .ComponentName(TMainIconName.ContasPagarCadastro.ToString)
               .ResourceName('cadastro_contas_pagar')
               .Hint('Cadastro de contas à pagar')
               .OnClickViewMain(ViewSistemaMain.FinanceiroCadastroContasPagar1Click)
               .GroupOwner(TMainIconesGroup.Financeiro.ToInteger)
               );
end;

initialization
  TModelMainIconesListaRegistrarProc.GetInstance.Add(Registrar);

end.
