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
  View.Base.Cadastros,
  Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TViewVendasCad = class(TViewBaseCadastros)
  private
  public
  end;

var
  ViewVendasCad: TViewVendasCad;

implementation

{$R *.dfm}

end.
