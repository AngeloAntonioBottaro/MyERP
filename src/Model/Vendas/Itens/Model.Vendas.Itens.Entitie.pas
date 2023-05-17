unit Model.Vendas.Itens.Entitie;

interface

uses
  System.SysUtils,
  Model.Vendas.Itens.Interfaces;

type
  TModelVendasItensEntitie = class
  private
    [weak]
    FParent: IModelVendasItensFactory;

    FIdProduto: Integer;
    FNome: string;
  public
    constructor Create(AParent: IModelVendasItensFactory);
    function End_Itens: IModelVendasItensFactory;
    function IdProduto(AValue: string): TModelVendasItensEntitie; overload;
    function IdProduto(AValue: Integer): TModelVendasItensEntitie; overload;
    function IdProduto: Integer; overload;
    function Nome(AValue: string): TModelVendasItensEntitie; overload;
    function Nome: string; overload;
  end;

implementation

uses
  Common.Utils.MyLibrary;

constructor TModelVendasItensEntitie.Create(AParent: IModelVendasItensFactory);
begin
   FParent := AParent;
end;

function TModelVendasItensEntitie.End_Itens: IModelVendasItensFactory;
begin
   Result := FParent;
end;

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
