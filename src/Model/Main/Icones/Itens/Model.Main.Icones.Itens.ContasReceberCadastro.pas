unit Model.Main.Icones.Itens.ContasReceberCadastro;

interface

implementation

uses
  Model.Main.Icones.Fields,
  Model.Main.Icones.Types,
  Model.Main.Icones.Lista.RegistrarProc,
  View.Sistema.Main;

procedure Registrar(AValue: TPairMainIconesFields);
begin
   AValue.Add(TMainIconName.ContasReceberCadastro,
              TModelMainIconesFields.Create
               .Caption('Cadastro de contas à receber')
               .ComponentName(TMainIconName.ContasReceberCadastro.ToString)
               .ResourceName('cadastro_contas_receber')
               .Hint('Cadastro de contas à receber')
               .OnClickViewMain(ViewSistemaMain.FinanceiroCadastroContasReceber1Click)
               .GroupOwner(TMainIconesGroup.Financeiro.ToInteger)
               );
end;

initialization
  TModelMainIconesListaRegistrarProc.GetInstance.Add(Registrar);

end.
