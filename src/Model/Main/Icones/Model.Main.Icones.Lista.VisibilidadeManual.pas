unit Model.Main.Icones.Lista.VisibilidadeManual;

interface

uses
  Model.Main.Icones.Types,
  Model.Main.Icones.Interfaces;

type
  TModelMainIconesListaVisibilidadeManual = class(TInterfacedObject, IModelMainIconesListaVisibilidadeManual)
  private
    FListaVisibilidadeManual: TDictionaryStringBool;
  public
    function Add(AKey: string; AValue: Boolean): IModelMainIconesListaVisibilidadeManual;
    function LimparLista: IModelMainIconesListaVisibilidadeManual;
    function Lista: TDictionaryStringBool;
    class function New: IModelMainIconesListaVisibilidadeManual;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

class function TModelMainIconesListaVisibilidadeManual.New: IModelMainIconesListaVisibilidadeManual;
begin
   Result := Self.Create;
end;

constructor TModelMainIconesListaVisibilidadeManual.Create;
begin
   FListaVisibilidadeManual := TDictionaryStringBool.Create;
end;

destructor TModelMainIconesListaVisibilidadeManual.Destroy;
begin
   FListaVisibilidadeManual.Free;
   inherited;
end;

function TModelMainIconesListaVisibilidadeManual.Add(AKey: string; AValue: Boolean): IModelMainIconesListaVisibilidadeManual;
begin
   Result := Self;
   FListaVisibilidadeManual.AddOrSetValue(AKey, AValue);
end;

function TModelMainIconesListaVisibilidadeManual.LimparLista: IModelMainIconesListaVisibilidadeManual;
begin
   Result := Self;
   FListaVisibilidadeManual.Clear;
end;

function TModelMainIconesListaVisibilidadeManual.Lista: TDictionaryStringBool;
begin
   Result := FListaVisibilidadeManual;
end;

end.
