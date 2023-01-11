unit View.Cidades.Cad;

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
  View.Base;

type
  TViewCidadesCad = class(TViewBase)
  private
  public
  end;

var
  ViewCidadesCad: TViewCidadesCad;

implementation

{$R *.dfm}

uses View.Cidades.Busca;

end.
