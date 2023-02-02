unit Model.Main.Icones;

interface

uses
  System.Sysutils,
  Model.Main.Icones.Lista,
  Model.Main.Icones.Types,
  Model.Main.Icones.Interfaces,
  Model.Main.Icones.Lista.VisibilidadeManual;

type
  TModelMainIcones = class
  private
    class var FInstance: TModelMainIcones;

    FModelMainIconesList: IModelMainIconesList;
    FModelMainIconesListaVisibilidadeManual: IModelMainIconesListaVisibilidadeManual;

    constructor Create;
    procedure RegistrarIcones;
  public
    function ListaIcones: TPairMainIconesFields;
    function ListaVisibilidadeManual: IModelMainIconesListaVisibilidadeManual;
    function AtualizarVisibilidades: TModelMainIcones;
    function PanelIcones: IModelMainIconesComponentes;
    function PageControlIcones: IModelMainIconesComponentes;

    destructor Destroy; override;
    class function GetInstance: TModelMainIcones;
  end;

implementation

uses
  Model.Main.Icones.Lista.RegistrarProc,
  Model.Main.Icones.Componentes.PanelIcones,
  Model.Main.Icones.Componentes.PageControlIcones;

class function TModelMainIcones.GetInstance: TModelMainIcones;
begin
   if(not Assigned(FInstance))then
     FInstance := TModelMainIcones.Create;

   Result := FInstance;
end;

constructor TModelMainIcones.Create;
begin
   FModelMainIconesList                    := TModelMainIconesLista.Create;
   FModelMainIconesListaVisibilidadeManual := TModelMainIconesListaVisibilidadeManual.New;

   Self.RegistrarIcones;
end;

destructor TModelMainIcones.Destroy;
begin
   inherited;
end;

function TModelMainIcones.ListaIcones: TPairMainIconesFields;
begin
   Result := FModelMainIconesList.Lista;
end;

function TModelMainIcones.ListaVisibilidadeManual: IModelMainIconesListaVisibilidadeManual;
begin
   Result := FModelMainIconesListaVisibilidadeManual;
end;

function TModelMainIcones.PanelIcones: IModelMainIconesComponentes;
begin
   Result := TModelMainIconesComponentesPanelIcones.New(Self);
end;

function TModelMainIcones.PageControlIcones: IModelMainIconesComponentes;
begin
   Result := TModelMainIconesComponentesPageControlIcones.New(Self);
end;

function TModelMainIcones.AtualizarVisibilidades: TModelMainIcones;
begin
   Result := Self;
   FModelMainIconesList.AtualizarVisibilidades(FModelMainIconesListaVisibilidadeManual);
end;

procedure TModelMainIcones.RegistrarIcones;
var
 LRegistra: TProcPairMainIconesFields;
 I: Integer;
begin
   for I := 0 to TModelMainIconesListaRegistrarProc.GetInstance.Lista.Count -1 do
   begin
      LRegistra := TModelMainIconesListaRegistrarProc.GetInstance.Lista.Items[I];
      LRegistra(Self.ListaIcones);
   end;
end;

initialization

finalization
  if(Assigned(TModelMainIcones.FInstance))then
    TModelMainIcones.FInstance.Free;

end.
