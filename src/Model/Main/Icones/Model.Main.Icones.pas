unit Model.Main.Icones;

interface

uses
  System.Sysutils,
  Model.Main.Icones.Lista,
  Model.Main.Icones.Types,
  Model.Main.Icones.Interfaces,
  Model.Main.Icones.Componentes;

type
  TModelMainIcones = class
  private
    class var FInstance: TModelMainIcones;
    FModelMainIconesList: IModelMainIconesList;
    FModelMainIconesComponentes: IModelMainIconesComponentes;
    constructor Create;
    procedure RegistrarIcones;
  public
    function Lista: TPairMainIconesFields;
    function AtualizaVisibilidades: TModelMainIcones;
    function Componentes: IModelMainIconesComponentes;
    destructor Destroy; override;
    class function GetInstance: TModelMainIcones;
  end;

implementation

uses
  Model.Main.Icones.Lista.RegistrarProc;

class function TModelMainIcones.GetInstance: TModelMainIcones;
begin
   if(not Assigned(FInstance))then
     FInstance := TModelMainIcones.Create;

   Result := FInstance;
end;

constructor TModelMainIcones.Create;
begin
   FModelMainIconesList := TModelMainIconesLista.Create;
   Self.RegistrarIcones;
end;

destructor TModelMainIcones.Destroy;
begin
   inherited;
end;

function TModelMainIcones.Lista: TPairMainIconesFields;
begin
   Result := FModelMainIconesList.Lista;
end;

function TModelMainIcones.AtualizaVisibilidades: TModelMainIcones;
begin
   Result := Self;
   FModelMainIconesList.AtualizaVisibilidades;
end;

function TModelMainIcones.Componentes: IModelMainIconesComponentes;
begin
   if(not Assigned(FModelMainIconesComponentes))then
     FModelMainIconesComponentes := TModelMainIconesComponentes.Create;

   Result := FModelMainIconesComponentes;
end;

procedure TModelMainIcones.RegistrarIcones;
var
 LRegistra: TProcPairMainIconesFields;
 I: Integer;
begin
   for I := 0 to TModelMainIconesListaRegistrarProc.GetInstance.Lista.Count -1 do
   begin
      LRegistra := TModelMainIconesListaRegistrarProc.GetInstance.Lista.Items[I];
      LRegistra(Self.Lista);
   end;
end;

initialization

finalization
  if(Assigned(TModelMainIcones.FInstance))then
    TModelMainIcones.FInstance.Free;

end.
