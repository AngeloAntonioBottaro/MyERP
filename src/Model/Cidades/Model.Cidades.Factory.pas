unit Model.Cidades.Factory;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Model.Cidades.Interfaces,
  Model.Cidades.Entitie;

type
  TModelCidadesFactory = class(TInterfacedObject, IModelCidadesFactory<TModelCidadesEntitie>)
  private
    FEntitie: TModelCidadesEntitie;
  protected
    function Entitie: TModelCidadesEntitie;
  public
    class function New: IModelCidadesFactory<TModelCidadesEntitie>;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

class function TModelCidadesFactory.New: IModelCidadesFactory<TModelCidadesEntitie>;
begin
   Result := Self.Create;
end;

constructor TModelCidadesFactory.Create;
begin
   FEntitie := TModelCidadesEntitie.Create(Self);
end;

destructor TModelCidadesFactory.Destroy;
begin
   if(Assigned(FEntitie))then
     FEntitie.Free;
   inherited;
end;

function TModelCidadesFactory.Entitie: TModelCidadesEntitie;
begin
   Result := FEntitie;
end;

end.
