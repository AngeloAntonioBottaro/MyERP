unit Model.Produtos.Entitie;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Model.Produtos.Interfaces;

type
  TModelProdutosEntitie = class
  private
    [weak]
    FParent: IModelProdutosFactory<TModelProdutosEntitie>;

    FCodigoBarras: string;
    FCusto: Double;
    FDataCadastro: TDate;
    FDescricao: string;
    FEstoque: Double;
    FEstoqueMaximo: Double;
    FEstoqueMinimo: Double;
    FId: Integer;
    FNome: string;
    FPorcentoLucroVendaVista: Double;
    FPorcentoLucroVendaPrazo: Double;
    FPrecoVendaVista: Double;
    FPrecoVendaPrazo: Double;
    FStatus: string;
    FSubgrupo: Integer;
    FUnidade: Integer;
  public
    constructor Create(AParent: IModelProdutosFactory<TModelProdutosEntitie>);
    destructor Destroy; override;
    function End_Entitie: IModelProdutosFactory<TModelProdutosEntitie>;

    function CodigoBarras(AValue: string): TModelProdutosEntitie; overload;
    function CodigoBarras: string; overload;
    function Custo(AValue: string): TModelProdutosEntitie; overload;
    function Custo(AValue: Double): TModelProdutosEntitie; overload;
    function Custo: Double; overload;
    function DataCadastro(AValue: string): TModelProdutosEntitie; overload;
    function DataCadastro(AValue: TDate): TModelProdutosEntitie; overload;
    function DataCadastro: TDate; overload;
    function Descricao(AValue: string): TModelProdutosEntitie; overload;
    function Descricao: string; overload;
    function Estoque(AValue: string): TModelProdutosEntitie; overload;
    function Estoque(AValue: Double): TModelProdutosEntitie; overload;
    function Estoque: Double; overload;
    function EstoqueMaximo(AValue: string): TModelProdutosEntitie; overload;
    function EstoqueMaximo(AValue: Double): TModelProdutosEntitie; overload;
    function EstoqueMaximo: Double; overload;
    function EstoqueMinimo(AValue: string): TModelProdutosEntitie; overload;
    function EstoqueMinimo(AValue: Double): TModelProdutosEntitie; overload;
    function EstoqueMinimo: Double; overload;
    function Id(AValue: string): TModelProdutosEntitie; overload;
    function Id(AValue: Integer): TModelProdutosEntitie; overload;
    function Id: Integer; overload;
    function IdMascara: string;
    function IdNome: string;
    function Nome(AValue: string): TModelProdutosEntitie; overload;
    function Nome: string; overload;
    function PorcentoLucroVendaVista(AValue: string): TModelProdutosEntitie; overload;
    function PorcentoLucroVendaVista(AValue: Double): TModelProdutosEntitie; overload;
    function PorcentoLucroVendaVista: Double; overload;
    function PorcentoLucroVendaPrazo(AValue: string): TModelProdutosEntitie; overload;
    function PorcentoLucroVendaPrazo(AValue: Double): TModelProdutosEntitie; overload;
    function PorcentoLucroVendaPrazo: Double; overload;
    function PrecoVendaVista(AValue: string): TModelProdutosEntitie; overload;
    function PrecoVendaVista(AValue: Double): TModelProdutosEntitie; overload;
    function PrecoVendaVista: Double; overload;
    function PrecoVendaPrazo(AValue: string): TModelProdutosEntitie; overload;
    function PrecoVendaPrazo(AValue: Double): TModelProdutosEntitie; overload;
    function PrecoVendaPrazo: Double; overload;
    function Status(AValue: string): TModelProdutosEntitie; overload;
    function Status: string; overload;
    function Subgrupo(AValue: string): TModelProdutosEntitie; overload;
    function Subgrupo(AValue: Integer): TModelProdutosEntitie; overload;
    function Subgrupo: Integer; overload;
    function SubgrupoMascara: string;
    function Unidade(AValue: string): TModelProdutosEntitie; overload;
    function Unidade(AValue: Integer): TModelProdutosEntitie; overload;
    function Unidade: Integer; overload;
    function UnidadeMascara: string;
  end;

implementation

uses
  Common.Utils.MyLibrary,
  Utils.GlobalConsts;

constructor TModelProdutosEntitie.Create(AParent: IModelProdutosFactory<TModelProdutosEntitie>);
begin
   FParent := AParent;
   FStatus := STATUS_ATIVO;
end;

destructor TModelProdutosEntitie.Destroy;
begin
   inherited;
end;

function TModelProdutosEntitie.End_Entitie: IModelProdutosFactory<TModelProdutosEntitie>;
begin
   Result := FParent;
end;

function TModelProdutosEntitie.CodigoBarras(AValue: string): TModelProdutosEntitie;
begin
   Result        := Self;
   FCodigoBarras := AValue.Trim;
end;

function TModelProdutosEntitie.CodigoBarras: string;
begin
   Result := FCodigoBarras;
end;

function TModelProdutosEntitie.Custo(AValue: string): TModelProdutosEntitie;
begin
   Result := Self;
   Self.Custo(TMyLibrary.StrToFloatDef(AValue.Trim));
end;

function TModelProdutosEntitie.Custo(AValue: Double): TModelProdutosEntitie;
begin
   Result := Self;
   FCusto := AValue;
end;

function TModelProdutosEntitie.Custo: Double;
begin
   Result := FCusto;
end;

function TModelProdutosEntitie.DataCadastro(AValue: string): TModelProdutosEntitie;
begin
   Result := Self;
   Self.DataCadastro(StrToDateDef(AValue.Trim, Now));
end;

function TModelProdutosEntitie.DataCadastro(AValue: TDate): TModelProdutosEntitie;
begin
   Result        := Self;
   FDataCadastro := AValue;
end;

function TModelProdutosEntitie.DataCadastro: TDate;
begin
   Result := FDataCadastro;
end;

function TModelProdutosEntitie.Descricao(AValue: string): TModelProdutosEntitie;
begin
   Result     := Self;
   FDescricao := AValue.Trim;
end;

function TModelProdutosEntitie.Descricao: string;
begin
   Result := FDescricao;
end;

function TModelProdutosEntitie.Estoque(AValue: string): TModelProdutosEntitie;
begin
   Result := Self;
   Self.Estoque(TMyLibrary.StrToFloatDef(AValue.Trim));
end;

function TModelProdutosEntitie.Estoque(AValue: Double): TModelProdutosEntitie;
begin
   Result   := Self;
   FEstoque := AValue;
end;

function TModelProdutosEntitie.Estoque: Double;
begin
   Result := FEstoque;
end;

function TModelProdutosEntitie.EstoqueMaximo(AValue: string): TModelProdutosEntitie;
begin
   Result := Self;
   Self.EstoqueMaximo(TMyLibrary.StrToFloatDef(AValue.Trim));
end;

function TModelProdutosEntitie.EstoqueMaximo(AValue: Double): TModelProdutosEntitie;
begin
   Result         := Self;
   FEstoqueMaximo := AValue;
end;

function TModelProdutosEntitie.EstoqueMaximo: Double;
begin
   Result := FEstoqueMaximo;
end;

function TModelProdutosEntitie.EstoqueMinimo(AValue: string): TModelProdutosEntitie;
begin
   Result := Self;
   Self.EstoqueMinimo(TMyLibrary.StrToFloatDef(AValue.Trim));
end;

function TModelProdutosEntitie.EstoqueMinimo(AValue: Double): TModelProdutosEntitie;
begin
   Result         := Self;
   FEstoqueMinimo := AValue;
end;

function TModelProdutosEntitie.EstoqueMinimo: Double;
begin
   Result := FEstoqueMinimo;
end;

function TModelProdutosEntitie.Id(AValue: string): TModelProdutosEntitie;
begin
   Result := Self;
   Self.Id(TMyLibrary.StrToIntDef(AValue.Trim));
end;

function TModelProdutosEntitie.Id(AValue: Integer): TModelProdutosEntitie;
begin
   Result := Self;
   FId    := AValue;
end;

function TModelProdutosEntitie.Id: Integer;
begin
   Result := FId;
end;

function TModelProdutosEntitie.IdMascara: string;
begin
   Result := EmptyStr;
   if(Self.Id > 0)then
     Result := TMyLibrary.CompLeft(Self.Id);
end;

function TModelProdutosEntitie.IdNome: string;
begin
   Result := Self.Nome;
   Result := IfThen(Result.IsEmpty, Self.IdMascara, Self.IdMascara + ' - ' + Result);
end;

function TModelProdutosEntitie.Nome(AValue: string): TModelProdutosEntitie;
begin
   Result := Self;
   FNome  := AValue;
end;

function TModelProdutosEntitie.Nome: string;
begin
   Result := FNome;
end;

function TModelProdutosEntitie.PorcentoLucroVendaVista(AValue: string): TModelProdutosEntitie;
begin
   Result := Self;
   Self.PorcentoLucroVendaVista(TMyLibrary.StrToFloatDef(AValue.Trim));
end;

function TModelProdutosEntitie.PorcentoLucroVendaVista(AValue: Double): TModelProdutosEntitie;
begin
   Result                   := Self;
   FPorcentoLucroVendaVista := AValue;
end;

function TModelProdutosEntitie.PorcentoLucroVendaVista: Double;
begin
   Result := FPorcentoLucroVendaVista;
end;

function TModelProdutosEntitie.PorcentoLucroVendaPrazo(AValue: string): TModelProdutosEntitie;
begin
   Result := Self;
   Self.PorcentoLucroVendaPrazo(TMyLibrary.StrToFloatDef(AValue.Trim));
end;

function TModelProdutosEntitie.PorcentoLucroVendaPrazo(AValue: Double): TModelProdutosEntitie;
begin
   Result                   := Self;
   FPorcentoLucroVendaPrazo := AValue;
end;

function TModelProdutosEntitie.PorcentoLucroVendaPrazo: Double;
begin
   Result := FPorcentoLucroVendaPrazo;
end;

function TModelProdutosEntitie.PrecoVendaVista(AValue: string): TModelProdutosEntitie;
begin
   Result := Self;
   Self.PrecoVendaVista(TMyLibrary.StrToFloatDef(AValue.Trim));
end;

function TModelProdutosEntitie.PrecoVendaVista(AValue: Double): TModelProdutosEntitie;
begin
   Result           := Self;
   FPrecoVendaVista := AValue;
end;

function TModelProdutosEntitie.PrecoVendaVista: Double;
begin
   Result := FPrecoVendaVista;
end;

function TModelProdutosEntitie.PrecoVendaPrazo(AValue: string): TModelProdutosEntitie;
begin
   Result := Self;
   Self.PrecoVendaPrazo(TMyLibrary.StrToFloatDef(AValue.Trim));
end;

function TModelProdutosEntitie.PrecoVendaPrazo(AValue: Double): TModelProdutosEntitie;
begin
   Result           := Self;
   FPrecoVendaPrazo := AValue;
end;

function TModelProdutosEntitie.PrecoVendaPrazo: Double;
begin
   Result := FPrecoVendaPrazo;
end;

function TModelProdutosEntitie.Status(AValue: string): TModelProdutosEntitie;
begin
   Result  := Self;
   FStatus := AValue.Trim;
end;

function TModelProdutosEntitie.Status: string;
begin
   Result := FStatus;
end;

function TModelProdutosEntitie.Subgrupo(AValue: string): TModelProdutosEntitie;
begin
   Result := Self;
   Self.Subgrupo(TMyLibrary.StrToIntDef(AValue.Trim));
end;

function TModelProdutosEntitie.Subgrupo(AValue: Integer): TModelProdutosEntitie;
begin
   Result    := Self;
   FSubgrupo := AValue;
end;

function TModelProdutosEntitie.Subgrupo: Integer;
begin
   Result := FSubgrupo;
end;

function TModelProdutosEntitie.SubgrupoMascara: string;
begin
   Result := EmptyStr;
   if(Self.Subgrupo > 0)then
     Result := TMyLibrary.CompLeft(Self.Subgrupo);
end;

function TModelProdutosEntitie.Unidade(AValue: string): TModelProdutosEntitie;
begin
   Result := Self;
   Self.Unidade(TMyLibrary.StrToIntDef(AValue.Trim));
end;

function TModelProdutosEntitie.Unidade(AValue: Integer): TModelProdutosEntitie;
begin
   Result   := Self;
   FUnidade := AValue;
end;

function TModelProdutosEntitie.Unidade: Integer;
begin
   Result := FUnidade
end;

function TModelProdutosEntitie.UnidadeMascara: string;
begin
   Result := EmptyStr;
   if(Self.Unidade > 0)then
     Result := TMyLibrary.CompLeft(Self.Unidade);
end;

end.
