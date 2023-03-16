unit View.Base.Busca;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Data.DB,
  View.Base,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Menus;

type
  TViewBaseBusca = class(TViewBase)
    pnTop: TPanel;
    pnBotton: TPanel;
    GridBusca: TDBGrid;
    pnButtons: TPanel;
    btnCadastro: TButton;
    btnVincular: TButton;
    lbBusca: TLabel;
    edtBusca: TEdit;
    DS_Busca: TDataSource;
    btnFechar: TButton;
    TimerBuscar: TTimer;
    PopupMenu: TPopupMenu;
    Atualizar1: TMenuItem;
    gBoxTipoConsulta: TGroupBox;
    ckBuscarInativos: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GridBuscaDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnVincularClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure TimerBuscarTimer(Sender: TObject);
    procedure Atualizar1Click(Sender: TObject);
    procedure edtBuscaKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    procedure Buscar; virtual;
  public
    FOnBusca: TProc<Integer>;
  end;

var
  ViewBaseBusca: TViewBaseBusca;

implementation

{$R *.dfm}

uses
  MyExceptions,
  Utils.MyConsts;

procedure TViewBaseBusca.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   inherited;
   btnCadastro.Enabled := True;
   btnVincular.Enabled := True;
   FOnBusca            := nil;
end;

procedure TViewBaseBusca.FormCreate(Sender: TObject);
begin
   inherited;
   TimerBuscar.Enabled := False;
end;

procedure TViewBaseBusca.Atualizar1Click(Sender: TObject);
begin
   Self.Buscar;
end;

procedure TViewBaseBusca.btnFecharClick(Sender: TObject);
begin
   inherited;
   Self.Close;
   Self.ModalResult := mrClose;
end;

procedure TViewBaseBusca.btnVincularClick(Sender: TObject);
begin
   inherited;
   if(not Assigned(FOnBusca))then
     raise ExceptionRequired.Create('Procedimento para v�nculo n�o informado');

   if(DS_Busca.DataSet = nil)then
     raise ExceptionRequired.Create('Query de busca n�o informada');

   if(DS_Busca.DataSet.IsEmpty)then
     raise ExceptionRequired.Create('Nenhum registro encontrado para v�nculo');

   FOnBusca(DS_Busca.DataSet.FieldByName('ID').AsInteger);
   Self.Close;
   Self.ModalResult := mrOk;
end;

procedure TViewBaseBusca.Buscar;
begin
   raise ExceptionWarning.Create('Buscar n�o implementado')
end;

procedure TViewBaseBusca.edtBuscaKeyPress(Sender: TObject; var Key: Char);
begin
   TimerBuscar.Enabled := False;
   TimerBuscar.Enabled := True;
end;

procedure TViewBaseBusca.GridBuscaDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if(odd(TDBGrid(Sender).DataSource.DataSet.RecNo))then
     Exit;

   if((gdSelected in State))then
     Exit;

   TDBGrid(Sender).Canvas.Brush.Color := COLOR_GRID;
   TDBGrid(Sender).Canvas.FillRect(Rect);
   TDBGrid(Sender).DefaultDrawDataCell(rect,Column.Field,state);
end;

procedure TViewBaseBusca.TimerBuscarTimer(Sender: TObject);
begin
   TimerBuscar.Enabled := False;
   Self.Buscar;
end;

end.
