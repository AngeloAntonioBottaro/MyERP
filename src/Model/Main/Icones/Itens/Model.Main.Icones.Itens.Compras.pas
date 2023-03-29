unit Model.Main.Icones.Itens.Compras;

interface

implementation

uses
  Model.Main.Icones.Fields,
  Model.Main.Icones.Types,
  Model.Main.Icones.Lista.RegistrarProc,
  View.Sistema.Main;

procedure Registrar(AValue: TPairMainIconesFields);
begin
   AValue.Add(TMainIconName.Compras,
              TModelMainIconesFields.Create
               .Caption('Compras')
               .ComponentName(TMainIconName.Compras.ToString)
               .ResourceName('compras')
               .Hint('Tela de compras')
               //.OnClickViewMain(ViewSistemaMain.)
               .GroupOwner(TMainIconesGroup.Movimentacoes.ToInteger)
               );
end;

initialization
  TModelMainIconesListaRegistrarProc.GetInstance.Add(Registrar);

end.
