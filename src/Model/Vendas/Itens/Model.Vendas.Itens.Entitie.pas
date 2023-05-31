unit Model.Vendas.Itens.Entitie;

interface

uses
  System.SysUtils;

type
  TModelVendasItensEntitie = class
  private
    FIdProduto: Integer;
    FNome: string;
  public
    function IdProduto(AValue: string): TModelVendasItensEntitie; overload;
    function IdProduto(AValue: Integer): TModelVendasItensEntitie; overload;
    function IdProduto: Integer; overload;
    function Nome(AValue: string): TModelVendasItensEntitie; overload;
    function Nome: string; overload;
  end;

implementation

uses
  Common.Utils.MyLibrary;

function TModelVendasItensEntitie.IdProduto(AValue: string): TModelVendasItensEntitie;
begin
   Result := Self;
   Self.IdProduto(TMyLibrary.StrToIntDef(AValue));
end;

function TModelVendasItensEntitie.IdProduto(AValue: Integer): TModelVendasItensEntitie;
begin
   Result     := Self;
   FIdProduto := AValue;
end;

function TModelVendasItensEntitie.IdProduto: Integer;
begin
   Result := FIdProduto;
end;

function TModelVendasItensEntitie.Nome(AValue: string): TModelVendasItensEntitie;
begin
   Result := Self;
   FNome  := AValue.Trim;
end;

function TModelVendasItensEntitie.Nome: string;
begin
   Result := FNome;
end;

end.
