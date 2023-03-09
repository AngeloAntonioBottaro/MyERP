unit View.Cidades.Cad;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  View.Base.Cadastros,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TViewCidadesCad = class(TViewBaseCadastros)
    pnTela: TPanel;
    lbId: TLabel;
    lbNome: TLabel;
    lbIBGE: TLabel;
    lbUF: TLabel;
    edtId: TEdit;
    edtCidade: TEdit;
    cBoxUF: TComboBox;
    edtIBGE: TEdit;
    procedure btnBuscarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure InitialConfiguration;
  public
  end;

var
  ViewCidadesCad: TViewCidadesCad;

implementation

{$R *.dfm}

uses
  View.Cidades.Busca,
  Utils.MyConsts;

procedure TViewCidadesCad.btnBuscarClick(Sender: TObject);
begin
   inherited;
   if(ViewCidadesBusca = nil)then Application.CreateForm(TViewCidadesBusca, ViewCidadesBusca);
   try
     ViewCidadesBusca.btnCadastro.Enabled := False;
     ViewCidadesBusca.ShowModal;
   finally
     FreeAndNil(ViewCidadesBusca);
   end;
end;

procedure TViewCidadesCad.FormCreate(Sender: TObject);
begin
   inherited;
   Self.InitialConfiguration;
end;

procedure TViewCidadesCad.InitialConfiguration;
var
  I: Integer;
begin
   cBoxUF.Items.Clear;
   for I := Low(ESTADOS) to High(ESTADOS) do
     cBoxUF.Items.Add(ESTADOS[I]);

   cBoxUF.ItemIndex := -1;
end;

end.
