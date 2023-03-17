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
  Vcl.ExtCtrls,
  Vcl.Menus,
  Utils.MyTypes, Vcl.ComCtrls;

type
  TViewClientesBusca = class(TViewBaseBusca)
    rdBuscarNome: TRadioButton;
    rdBuscarCodigo: TRadioButton;
    rdBuscarCPF_CNPJ: TRadioButton;
    rdBuscarCidade: TRadioButton;
    procedure btnCadastroClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    function GetTipoBusca: TTipoBuscaCliente;
  public
    procedure Buscar; override;
  end;

var
  ViewClientesBusca: TViewClientesBusca;

implementation

{$R *.dfm}

uses
  MyExceptions,
  Utils.MyConsts,
  View.Clientes.Cad,
  Model.Clientes.Busca;

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
var
  LBusca: TModelClientesBusca;
begin
   LBusca := TModelClientesBusca.Create;
   try
     LBusca
      .DataSource(DS_Busca)
      .ConteudoBusca(edtBusca.Text)
      .TipoBusca(Self.GetTipoBusca)
      .Inativos(ckBuscarInativos.Enabled and ckBuscarInativos.Checked)
      .Buscar;
   finally
     LBusca.Free;
   end;

   inherited;
end;

procedure TViewClientesBusca.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   inherited;
   case(Key)of
    VK_F2: if(Shift = [])then rdBuscarCodigo.Checked   := True;
    VK_F3: if(Shift = [])then rdBuscarNome.Checked     := True;
    VK_F4: if(Shift = [])then rdBuscarCPF_CNPJ.Checked := True;
    VK_F6: if(Shift = [])then rdBuscarCidade.Checked   := True;
   end;
end;

function TViewClientesBusca.GetTipoBusca: TTipoBuscaCliente;
begin
   Result := TTipoBuscaCliente.Nome;

   if(rdBuscarCodigo.Enabled and rdBuscarCodigo.Checked)then
     Result := TTipoBuscaCliente.Id
   else if(rdBuscarCPF_CNPJ.Enabled and rdBuscarCPF_CNPJ.Checked)then
     Result := TTipoBuscaCliente.CPF_CNPJ
   else if(rdBuscarCidade.Enabled and rdBuscarCidade.Checked)then
     Result := TTipoBuscaCliente.Cidade;
end;

end.
