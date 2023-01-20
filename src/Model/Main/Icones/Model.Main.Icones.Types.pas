unit Model.Main.Icones.Types;

interface

uses
  System.SysUtils,
  System.TypInfo,
  Utils.MyObjectDictionary,
  Model.Main.Icones.Fields;

type
  {$SCOPEDENUMS ON}
  TMainIconName = (ckClientes, ckProdutos, ckConsultaProdutos, ckFornecedores, ckFuncionarios, ckCidades, ckBackupSistema);
  {$SCOPEDENUMS OFF}

  TPairMainIconesFields     = TUtilsMyObjectDictionary<TMainIconName, TModelMainIconesFields>;
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
