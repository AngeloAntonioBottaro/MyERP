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
  Vcl.Mask,
  Vcl.DBCtrls,
  View.Base.Cadastros,
  Data.DB,
  Utils.ConfGrid,
  Model.Vendas.Factory;

type
  TViewVendasCad = class(TViewBaseCadastros)
    pnTela: TPanel;
    pnCabecalho: TPanel;
    pnTotalVenda: TPanel;
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
    pnGrid: TPanel;
    GridItensVenda: TDBGrid;
    pnOptions: TPanel;
    lbTotalRegistros: TLabel;
    pnConfGrid: TPanel;
    imgConfGrid: TImage;
    DSItensVenda: TDataSource;
    lbQuantidade: TLabel;
    lbPreco: TLabel;
    lbSubTotal: TLabel;
    btnIncluirItem: TButton;
    lbDesconto: TLabel;
    DSVenda: TDataSource;
    edtQuantidade: TDBEdit;
    edtPreco: TDBEdit;
    edtDesconto: TDBEdit;
    edtTotal: TDBEdit;
    edtNomeProduto: TDBEdit;
    DSItemVenda: TDataSource;
    procedure edtIdClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtIdClienteExit(Sender: TObject);
    procedure edtIdProdutoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtIdProdutoExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnIncluirItemClick(Sender: TObject);
    procedure edtQuantidadeExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cBoxFormaPagExit(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    FVendasFactory: IModelVendasFactory;
    FConfGrid: TUtilsConfGrid;
    procedure GetTotalRegistros;
    procedure Liga;
    procedure Desliga;
    procedure EmptyItensFields;
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
  Utils.Types,
  Utils.EditsKeyDownExit,
  Model.Sistema.Imagens.DM;

procedure TViewVendasCad.btnCancelarClick(Sender: TObject);
begin
   if(not ShowQuestionNo('Confirmar cancelamento da venda?'))then
     Exit;

   inherited;
   Self.Desliga;
   DSItensVenda.DataSet := nil;
   Self.GetTotalRegistros;
end;

procedure TViewVendasCad.btnNovoClick(Sender: TObject);
begin
   inherited;
   FVendasFactory.NovaVenda;
   Self.Liga;
   Self.GetTotalRegistros;
   dtpDataVenda.Date := Date;
   edtIdCliente.SetFocus;
end;

procedure TViewVendasCad.cBoxFormaPagExit(Sender: TObject);
begin
   inherited;
   FVendasFactory.Entitie.FormaPagamento(cBoxFormaPag.ItemIndex);
end;

procedure TViewVendasCad.btnGravarClick(Sender: TObject);
begin
   inherited;
   FVendasFactory
    .Entitie
     .Id(edtId.Text)
     .Data(dtpDataVenda.Date)
     .IdCliente(edtIdCliente.Text)
     .FormaPagamento(cBoxFormaPag.ItemIndex)
     .Observacao('');

   //FVendasFactory.GravarVenda;
end;

procedure TViewVendasCad.btnIncluirItemClick(Sender: TObject);
begin
   FVendasFactory.SalvarItem;
   edtIdProduto.SetFocus;
   Self.GetTotalRegistros;
   Self.EmptyItensFields;
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
   FVendasFactory.NovoItem(edtIdProduto.Text);
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

procedure TViewVendasCad.edtQuantidadeExit(Sender: TObject);
begin
   FVendasFactory.CalcularValores;
end;

procedure TViewVendasCad.EmptyItensFields;
begin
   edtIdProduto.Clear;
   edtNomeProduto.Clear;
   edtQuantidade.Clear;
   edtPreco.Clear;
   edtDesconto.Clear;
   edtTotal.Clear;
end;

procedure TViewVendasCad.FormCreate(Sender: TObject);
var
  I: TFormaPagamento;
begin
   inherited;
   cBoxFormaPag.Items.Clear;
   for I := Low(TFormaPagamento) to High(TFormaPagamento) do
     cBoxFormaPag.Items.Add(I.ToString);

   cBoxFormaPag.ItemIndex := -1;

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

procedure TViewVendasCad.FormShow(Sender: TObject);
begin
   inherited;
   Self.Desliga;
end;

procedure TViewVendasCad.GetTotalRegistros;
begin
   lbTotalRegistros.Caption := TOTAL_REGISTROS_LABEL + TOTAL_REGISTROS_DEFAULT;

   if(DSItensVenda.DataSet = nil)then
     Exit;

   lbTotalRegistros.Caption := TOTAL_REGISTROS_LABEL + TMyLibrary.CompLeft(DSItensVenda.DataSet.RecordCount);
end;

procedure TViewVendasCad.InitialConfiguration;
begin
   Self.GetTotalRegistros;
end;

procedure TViewVendasCad.Liga;
begin
   pnCabecalho.Enabled  := True;
   pnItens.Enabled      := True;
   pnTotalVenda.Enabled := True;
end;

procedure TViewVendasCad.Desliga;
begin
   pnCabecalho.Enabled  := False;
   pnItens.Enabled      := False;
   pnTotalVenda.Enabled := False;
end;

procedure TViewVendasCad.NewEntitie;
begin
   FVendasFactory := TModelVendasFactory.New.DataSourceVenda(DSVenda).DataSourceItem(DSItemVenda).DataSourceItens(DSItensVenda);
end;

end.
