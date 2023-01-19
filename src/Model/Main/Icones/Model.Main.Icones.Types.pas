unit Model.Main.Icones.Types;

interface

uses
  System.SysUtils,
  System.TypInfo,
  C4D.Utils.ObjectDictionary,
  Model.Main.Icones.Fields;

type
  {$SCOPEDENUMS ON}
  TMainIconName = (cbClientes, cbLimiteDiario, cbDescPreEspeciais, cbTuristico, cbVeiculos, cbProdutos, cbConsultaProdutos, cbAjusteEstoque,
                   cbGrades, cbBarras, cbFunc, cbPontoFunc, cbFornecedores, cbBackupSistema);
  {$SCOPEDENUMS OFF}

  TPairMainIconesFields     = TC4DUtilsObjectDictionary<TMainIconName, TModelMainIconesFields>;
  TProcPairMainIconesFields = TProc<TPairMainIconesFields>;

  TMainIconNameHelper = record helper for TMainIconName
  public
    function ToString: String;
  end;

implementation

function TMainIconNameHelper.ToString: String;
begin
   Result := GetEnumName(TypeInfo(TMainIconName), Integer(Self));
end;

end.
