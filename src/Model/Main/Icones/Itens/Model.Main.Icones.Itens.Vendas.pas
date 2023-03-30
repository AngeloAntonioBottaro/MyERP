unit Model.Main.Icones.Itens.Vendas;

interface

implementation

uses
  Model.Main.Icones.Fields,
  Model.Main.Icones.Types,
  Model.Main.Icones.Lista.RegistrarProc,
  View.Sistema.Main;

procedure Registrar(AValue: TPairMainIconesFields);
begin
   AValue.Add(TMainIconName.Vendas,
              TModelMainIconesFields.Create
               .Caption('Vendas')
               .ComponentName(TMainIconName.Vendas.ToString)
               .ResourceName('vendas')
               .Hint('Tela de vendas')
               .OnClickViewMain(ViewSistemaMain.MovimentacoesVendas1Click)
               .GroupOwner(TMainIconesGroup.Movimentacoes.ToInteger)
               );
end;

initialization
  TModelMainIconesListaRegistrarProc.GetInstance.Add(Registrar);

end.
