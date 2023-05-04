unit Model.Produtos.SubGrupos.Entitie;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Model.Produtos.SubGrupos.Interfaces;

type
  TModelProdutosSubGruposEntitie = class
  private
    [weak]
    FParent: IModelProdutosSubGruposFactory<TModelProdutosSubGruposEntitie>;

    FGrupo: Integer;
    FId: Integer;
    FNome: string;
  public
    constructor Create(AParent: IModelProdutosSubGruposFactory<TModelProdutosSubGruposEntitie>);
    destructor Destroy; override;
    function End_Entitie: IModelProdutosSubGruposFactory<TModelProdutosSubGruposEntitie>;

    function Grupo(AValue: string): TModelProdutosSubGruposEntitie; overload;
    function Grupo(AValue: Integer): TModelProdutosSubGruposEntitie; overload;
    function Grupo: Integer; overload;
    function GrupoMascara: string;
    function Id(AValue: string): TModelProdutosSubGruposEntitie; overload;
    function Id(AValue: Integer): TModelProdutosSubGruposEntitie; overload;
    function Id: Integer; overload;
    function IdMascara: string;
    function IdNome: string;
    function Nome(AValue: string): TModelProdutosSubGruposEntitie; overload;
    function Nome: string; overload;
  end;

implementation

uses
  Utils.MyLibrary;

constructor TModelProdutosSubGruposEntitie.Create(AParent: IModelProdutosSubGruposFactory<TModelProdutosSubGruposEntitie>);
begin
   FParent := AParent;
end;

destructor TModelProdutosSubGruposEntitie.Destroy;
begin
   inherited;
end;

function TModelProdutosSubGruposEntitie.End_Entitie: IModelProdutosSubGruposFactory<TModelProdutosSubGruposEntitie>;
begin
   Result := FParent;
end;

function TModelProdutosSubGruposEntitie.Grupo(AValue: string): TModelProdutosSubGruposEntitie;
begin
   Result := Self;
   Self.Grupo(TMyLibrary.StrToIntDef(AValue.Trim));
end;

function TModelProdutosSubGruposEntitie.Grupo(AValue: Integer): TModelProdutosSubGruposEntitie;
begin
   Result := Self;
   FGrupo := AValue;
end;

function TModelProdutosSubGruposEntitie.Grupo: Integer;
begin
   Result := FGrupo;
end;

function TModelProdutosSubGruposEntitie.GrupoMascara: string;
begin
   Result := EmptyStr;
   if(Self.Grupo > 0)then
     Result := TMyLibrary.CompLeft(Self.Grupo);
end;

function TModelProdutosSubGruposEntitie.Id(AValue: string): TModelProdutosSubGruposEntitie;
begin
   Result := Self;
   Self.Id(TMyLibrary.StrToIntDef(AValue.Trim));
end;

function TModelProdutosSubGruposEntitie.Id(AValue: Integer): TModelProdutosSubGruposEntitie;
begin
   Result := Self;
   FId    := AValue;
end;

function TModelProdutosSubGruposEntitie.Id: Integer;
begin
   Result := FId;
end;

function TModelProdutosSubGruposEntitie.IdMascara: string;
begin
   Result := EmptyStr;
   if(Self.Id > 0)then
     Result := TMyLibrary.CompLeft(Self.Id);
end;

function TModelProdutosSubGruposEntitie.IdNome: string;
begin
   Result := Self.Nome;
   Result := IfThen(Result.IsEmpty, Self.IdMascara, Self.IdMascara + ' - ' + Result);
end;

function TModelProdutosSubGruposEntitie.Nome(AValue: string): TModelProdutosSubGruposEntitie;
begin
   Result  := Self;
   FNome := AValue.Trim;
end;

function TModelProdutosSubGruposEntitie.Nome: string;
begin
   Result := FNome;
end;

end.
