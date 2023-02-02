unit Model.Main.Icones.Types;

interface

uses
  System.SysUtils,
  System.TypInfo,
  System.Generics.Collections,
  Utils.MyObjectDictionary,
  Model.Main.Icones.Fields;

type
  {$SCOPEDENUMS ON}
  TMainIconName = (Clientes, Produtos, Fornecedores, Funcionarios, Cidades);
  TMainIconesGroup = (Cadastros, Movimentacoes, Financeiro, Outros);
  {$SCOPEDENUMS OFF}

  TPairMainIconesFields     = TUtilsMyObjectDictionary<TMainIconName, TModelMainIconesFields>;
  TProcPairMainIconesFields = TProc<TPairMainIconesFields>;
  TDictionaryStringBool     = TDictionary<string, Boolean>;

  TMainIconNameHelper = record helper for TMainIconName
  public
    function ToString: String;
  end;

  TMainIconGroupHelper = record helper for TMainIconesGroup
  public
    function ToInteger: Integer;
    function ToString: String;
  end;

implementation

function TMainIconNameHelper.ToString: String;
begin
   Result := GetEnumName(TypeInfo(TMainIconName), Integer(Self));
end;

function TMainIconGroupHelper.ToInteger: Integer;
begin
   Result := Integer(Self);
end;

function TMainIconGroupHelper.ToString: String;
begin
   Result := GetEnumName(TypeInfo(TMainIconesGroup), Integer(Self));
   if(Result = 'Movimentacoes')then
     Result := 'Movimentações';
end;

end.
