unit Model.Main.Icones.Itens.Fornecedores;

interface

implementation

uses
  Model.Main.Icones.Fields,
  Model.Main.Icones.Types,
  Model.Main.Icones.Lista.RegistrarProc,
  View.Sistema.Main;

procedure Registrar(AValue: TPairMainIconesFields);
begin
   AValue.Add(TMainIconName.Fornecedores,
              TModelMainIconesFields.Create
               .Caption('Fornecedores')
               .ComponentName(TMainIconName.Fornecedores.ToString)
               .ResourceName('fornecedores')
               .Hint('Cadastro de Fornecedores')
               .OnClickViewMain(ViewSistemaMain.CadastrosFornecedoresCadastro1Click)
               .GroupOwner(TMainIconesGroup.Movimentacoes.ToInteger)
               );
end;

initialization
  TModelMainIconesListaRegistrarProc.GetInstance.Add(Registrar);

end.
