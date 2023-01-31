unit View.Clientes.Cad;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  View.Base.Cadastros,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TViewClientesCad = class(TViewBaseCadastros)
  private
  public
  end;

var
  ViewClientesCad: TViewClientesCad;

implementation

{$R *.dfm}

end.
