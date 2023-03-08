unit View.Cidades.Cad;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  View.Base.Cadastros,
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
  private
  public
  end;

var
  ViewCidadesCad: TViewCidadesCad;

implementation

{$R *.dfm}

end.
