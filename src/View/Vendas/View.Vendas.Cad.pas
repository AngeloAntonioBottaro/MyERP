unit View.Vendas.Cad;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.ComCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  View.Base.Cadastros,
  Data.DB,
  Utils.ConfGrid,
  Model.Vendas.Factory;

type
  TViewVendasCad = class(TViewBaseCadastros)
    pnTela: TPanel;
    pnCabecalho: TPanel;
    pnFinalizacaoVenda: TPanel;
    pnItens: TPanel;
    lbId: TLabel;
    edtId: TEdit;
    lbDataVenda: TLabel;
    dtpDataVenda: TDateTimePicker;
    lbIdCliente: TLabel;
    lbNomeCliente: TLabel;
    edtIdCliente: TEdit;
    edtCliente: TEdit;
    lbFormaPag: TLabel;
    cBoxFormaPag: TComboBox;
    lbIdProduto: TLabel;
    lbProduto: TLabel;
    edtIdProduto: TEdit;
    edtProduto: TEdit;
    pnGrid: TPanel;
    GridItensVenda: TDBGrid;
    pnOptions: TPanel;
    lbTotalRegistros: TLabel;
    pnConfGrid: TPanel;
    imgConfGrid: TImage;
    DS_ItensVenda: TDataSource;
    lbQuantidade: TLabel;
    edtQuantidade: TEdit;
    lbPreco: TLabel;
    edtPreco: TEdit;
    edtSubTotal: TEdit;
    lbSubTotal: TLabel;
    Button1: TButton;
    procedure edtIdClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtIdClienteExit(Sender: TObject);
    procedure edtIdProdutoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtIdProdutoExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    FVendasFactory: IModelVendasFactory;
    FConfGrid: TUtilsConfGrid;
    procedure GetTotalRegistros;
  public
    procedure InitialConfiguration; override;
    procedure NewEntitie; override;
  end;

var
  ViewVendasCad: TViewVendasCad;

implementation

{$R *.dfm}

uses
  MyMessage,
  Common.Utils.MyConsts,
  Common.Utils.MyLibrary,
  Utils.EditsKeyDownExit,
  Model.Sistema.Imagens.DM;

procedure TViewVendasCad.btnNovoClick(Sender: TObject);
begin
   inherited;
   FVendasFactory.NovaVenda;
   Self.GetTotalRegistros;
   dtpDataVenda.Date := Date;
   edtIdCliente.SetFocus;
end;

procedure TViewVendasCad.Button1Click(Sender: TObject);
begin
   FVendasFactory
    .Itens
     .NewItem
      .IdProduto(edtIdProduto.Text)
      .Nome(edtProduto.Text);

   FVendasFactory
    .Itens
     .AddItem;
end;

procedure TViewVendasCad.edtIdClienteExit(Sender: TObject);
begin
   IdClienteExit(edtIdCliente, edtCliente);
end;

procedure TViewVendasCad.edtIdClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   IdClienteKeyDown(edtIdCliente, Key, Shift);
end;

procedure TViewVendasCad.edtIdProdutoExit(Sender: TObject);
begin
   IdProdutoExit(edtIdProduto, edtProduto);
end;

procedure TViewVendasCad.edtIdProdutoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  LKey: Word;
  LShift: TShiftState;
begin
   LKey   := Key;
   LShift := Shift;
   if((Key = VK_RETURN)or(Key = VK_TAB))and(Trim(edtIdProduto.Text).IsEmpty)then
   begin
      LKey   := VK_F2;
      LShift := [];
   end;

   IdProdutoKeyDown(edtIdProduto, LKey, LShift);
end;

procedure TViewVendasCad.FormCreate(Sender: TObject);
begin
   inherited;
   FConfGrid := TUtilsConfGrid.New(imgConfGrid, GridItensVenda, Self.Name);
end;

procedure TViewVendasCad.FormDestroy(Sender: TObject);
begin
   FConfGrid.Free;
   inherited;
end;

procedure TViewVendasCad.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if(Key = #13)then
   begin
      if(ActiveControl = edtIdCliente)and(Trim(edtIdCliente.Text).IsEmpty)then Exit;
      if(ActiveControl = edtIdProduto)and(Trim(edtIdProduto.Text).IsEmpty)then Exit;

      Perform(CM_DialogKey, VK_TAB, 0);
      Key := #0;
   end;
end;

procedure TViewVendasCad.GetTotalRegistros;
begin
   lbTotalRegistros.Caption := TOTAL_REGISTROS_LABEL + TOTAL_REGISTROS_DEFAULT;

   if(DS_ItensVenda.DataSet = nil)then
     Exit;

   lbTotalRegistros.Caption := TOTAL_REGISTROS_LABEL + TMyLibrary.CompLeft(DS_ItensVenda.DataSet.RecordCount);
end;

procedure TViewVendasCad.InitialConfiguration;
begin
   Self.GetTotalRegistros;
end;

procedure TViewVendasCad.NewEntitie;
begin
   FVendasFactory := TModelVendasFactory.New.DataSourceItens(DS_ItensVenda);
end;

end.
