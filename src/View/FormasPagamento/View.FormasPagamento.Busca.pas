unit View.FormasPagamento.Busca;

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
  Vcl.Menus,
  Vcl.ExtCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Vcl.ComCtrls,
  Vcl.Imaging.pngimage,
  View.Base.Busca,
  Data.DB,
  Utils.Types,
  Model.FormasPagamento.Busca;

const
  TELA = 'Busca de forma de pagamento';

type
  TViewFormasPagamentoBusca = class(TViewBaseBusca)
    rdBuscarNome: TRadioButton;
    rdBuscarCodigo: TRadioButton;
    procedure ConfComponents(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure AtivarInativar1Click(Sender: TObject);
    procedure btnCadastroClick(Sender: TObject);
    procedure Excluir1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridBuscaDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure GridBuscaTitleClick(Column: TColumn);
  private
    FBusca: TModelFormasPagamentoBusca;
    function GetTipoBusca: TTipoBuscaFormaPagamento;
  public
    procedure Buscar; override;
  end;

var
  ViewFormasPagamentoBusca: TViewFormasPagamentoBusca;

implementation

{$R *.dfm}

uses
  MyExceptions,
  Common.Utils.MyConsts,
  MyVclLibrary,
  Utils.GlobalConsts,
  View.FormasPagamento.Cad,
  Model.FormasPagamento.Factory;

procedure TViewFormasPagamentoBusca.FormCreate(Sender: TObject);
begin
   FGridConf := Self.GridBusca;
   FNomeConf := Self.Name;

   inherited;

   FBusca := TModelFormasPagamentoBusca.Create;
   FBusca
    .DataSource(DS_Busca);
end;

procedure TViewFormasPagamentoBusca.FormDestroy(Sender: TObject);
begin
   inherited;
   FBusca.Free;
end;

procedure TViewFormasPagamentoBusca.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   inherited;
   case(Key)of
    VK_F2: if(Shift = [])then rdBuscarCodigo.Checked   := True;
    VK_F3: if(Shift = [])then rdBuscarNome.Checked     := True;
   end;
end;

procedure TViewFormasPagamentoBusca.AtivarInativar1Click(Sender: TObject);
begin
   inherited;
   TModelFormasPagamentoFactory.New(TELA)
    .Entitie
     .Id(DS_Busca.DataSet.FieldByName('ID').AsInteger)
     .End_Entitie
    .AlterarStatus;
end;

procedure TViewFormasPagamentoBusca.btnCadastroClick(Sender: TObject);
begin
   inherited;
   if(ViewFormasPagamentoCad = nil)then Application.CreateForm(TViewFormasPagamentoCad, ViewFormasPagamentoCad);

   if(ViewFormasPagamentoCad.Showing)then
     raise ExceptionInformation.Create(MSG_TELA_JA_ABERTA);

   try
     ViewFormasPagamentoCad.ShowModal;
   finally
     FreeAndNil(ViewFormasPagamentoCad);
   end;
end;

procedure TViewFormasPagamentoBusca.Buscar;
begin
   FBusca
    .ConteudoBusca(edtBusca.Text)
    .TipoBusca(Self.GetTipoBusca)
    .Inativos(ckBuscarInativos.Enabled and ckBuscarInativos.Checked)
    .Buscar;
   inherited;
end;

procedure TViewFormasPagamentoBusca.Excluir1Click(Sender: TObject);
begin
   inherited;
   inherited;
   TModelFormasPagamentoFactory.New(TELA)
    .Entitie
     .Id(DS_Busca.DataSet.FieldByName('ID').AsInteger)
     .End_Entitie
    .Deletar;
end;

procedure TViewFormasPagamentoBusca.ConfComponents(Sender: TObject);
begin
   edtBusca.Clear;
   TMyVclLibrary.SetFocusOn(edtBusca);
end;

function TViewFormasPagamentoBusca.GetTipoBusca: TTipoBuscaFormaPagamento;
begin
   Result := TTipoBuscaFormaPagamento.Nome;

   if(rdBuscarCodigo.Enabled and rdBuscarCodigo.Checked)then
     Result := TTipoBuscaFormaPagamento.Id;
end;

procedure TViewFormasPagamentoBusca.GridBuscaDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   inherited;
   if(DS_Busca.DataSet.FieldByName('STATUS').AsString.Equals(STATUS_INATIVO))then
   begin
      TDBGrid(Sender).Canvas.Font.Color := clRed;
      TDBGrid(Sender).Canvas.FillRect(Rect);
      TDBGrid(Sender).DefaultDrawDataCell(rect, Column.Field, state);
   end;
end;

procedure TViewFormasPagamentoBusca.GridBuscaTitleClick(Column: TColumn);
begin
   inherited;
   FBusca.IndexFieldNames(Column.FieldName);
end;

end.
