unit View.Clientes.Busca;

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
  View.Base.Busca,
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Menus;

type
  TViewClientesBusca = class(TViewBaseBusca)
    procedure btnCadastroClick(Sender: TObject);
  private
  public
    procedure Buscar; override;
  end;

var
  ViewClientesBusca: TViewClientesBusca;

implementation

{$R *.dfm}

uses
  MyConnection,
  MyExceptions,
  Utils.MyConsts,
  View.Clientes.Cad;

procedure TViewClientesBusca.btnCadastroClick(Sender: TObject);
begin
   inherited;
   if(ViewClientesCad = nil)then Application.CreateForm(TViewClientesCad, ViewClientesCad);

   if(ViewClientesBusca.Showing)then
       raise ExceptionInformation.Create(MSG_TELA_JA_ABERTA);

   try
     ViewClientesCad.ShowModal;
   finally
     FreeAndNil(ViewClientesCad);
   end;
end;

procedure TViewClientesBusca.Buscar;
begin
   MyQueryNew
    .DataSource(DS_Busca)
    .Add('select * from clientes where');

   MyQuery
    .Add('(razao_social like :condicao)')
    .AddParam('condicao', '%'+edtBusca.Text+'%')
    .Open;

   inherited;
end;

end.
