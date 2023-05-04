unit Model.Permissoes.Grupos.Entitie;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Model.Permissoes.Grupos.Interfaces;

type
  TModelPermissoesGruposEntitie = class
  private
    [weak]
    FParent: IModelPermissoesGruposFactory<TModelPermissoesGruposEntitie>;

    FDescricao: string;
    FId: Integer;
    FNome: string;
  public
    constructor Create(AParent: IModelPermissoesGruposFactory<TModelPermissoesGruposEntitie>);
    destructor Destroy; override;
    function End_Entitie: IModelPermissoesGruposFactory<TModelPermissoesGruposEntitie>;

    function Descricao(AValue: string): TModelPermissoesGruposEntitie; overload;
    function Descricao: string; overload;
    function Id(AValue: string): TModelPermissoesGruposEntitie; overload;
    function Id(AValue: Integer): TModelPermissoesGruposEntitie; overload;
    function Id: Integer; overload;
    function IdMascara: string;
    function IdNome: string;
    function Nome(AValue: string): TModelPermissoesGruposEntitie; overload;
    function Nome: string; overload;
  end;

implementation

uses
  Utils.MyLibrary;

constructor TModelPermissoesGruposEntitie.Create(AParent: IModelPermissoesGruposFactory<TModelPermissoesGruposEntitie>);
begin
   FParent := AParent;
end;

destructor TModelPermissoesGruposEntitie.Destroy;
begin
   inherited;
end;

function TModelPermissoesGruposEntitie.End_Entitie: IModelPermissoesGruposFactory<TModelPermissoesGruposEntitie>;
begin
   Result := FParent;
end;

function TModelPermissoesGruposEntitie.Descricao(AValue: string): TModelPermissoesGruposEntitie;
begin
   Result     := Self;
   FDescricao := AValue.Trim;
end;

function TModelPermissoesGruposEntitie.Descricao: string;
begin
   Result := FDescricao;
end;

function TModelPermissoesGruposEntitie.Id(AValue: string): TModelPermissoesGruposEntitie;
begin
   Result := Self;
   Self.Id(TMyLibrary.StrToIntDef(AValue.Trim));
end;

function TModelPermissoesGruposEntitie.Id(AValue: Integer): TModelPermissoesGruposEntitie;
begin
   Result := Self;
   FId    := AValue;
end;

function TModelPermissoesGruposEntitie.Id: Integer;
begin
   Result := FId;
end;

function TModelPermissoesGruposEntitie.IdMascara: string;
begin
   Result := EmptyStr;
   if(Self.Id > 0)then
     Result := TMyLibrary.CompLeft(Self.Id);
end;

function TModelPermissoesGruposEntitie.IdNome: string;
begin
   Result := Self.Nome;
   if(not Result.IsEmpty)then
     Result := Self.IdMascara + ' - ' + Result;
end;

function TModelPermissoesGruposEntitie.Nome(AValue: string): TModelPermissoesGruposEntitie;
begin
   Result := Self;
   FNome  := AValue.Trim;
end;

function TModelPermissoesGruposEntitie.Nome: string;
begin
   Result := FNome;
end;

end.
