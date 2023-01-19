unit Model.Main.Icones.Lista.RegistrarProc;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  Model.Main.Icones.Types,
  Model.Main.Icones.Fields,
  Model.Main.Icones.Interfaces;

type
  TModelMainIconesListaRegistrarProc = class
  private
    class var FInstance: TModelMainIconesListaRegistrarProc;
    FLista: TList<TProcPairMainIconesFields>;
    constructor Create;
  public
    class function GetInstance: TModelMainIconesListaRegistrarProc;
    destructor Destroy; override;
    procedure Add(AValue: TProcPairMainIconesFields);
    function Lista: TList<TProcPairMainIconesFields>;
  end;

implementation

constructor TModelMainIconesListaRegistrarProc.Create;
begin
   FLista := TList<TProcPairMainIconesFields>.Create;
end;

destructor TModelMainIconesListaRegistrarProc.Destroy;
begin
   FLista.Free;
   inherited;
end;

class function TModelMainIconesListaRegistrarProc.GetInstance: TModelMainIconesListaRegistrarProc;
begin
   if(not Assigned(FInstance))then
     FInstance := Self.Create;
   Result := FInstance;
end;

procedure TModelMainIconesListaRegistrarProc.Add(AValue: TProcPairMainIconesFields);
begin
   Self.Lista.Add(AValue);
end;

function TModelMainIconesListaRegistrarProc.Lista: TList<TProcPairMainIconesFields>;
begin
   Result := FLista;
end;

initialization

finalization
  TModelMainIconesListaRegistrarProc.FInstance.Free;

end.
