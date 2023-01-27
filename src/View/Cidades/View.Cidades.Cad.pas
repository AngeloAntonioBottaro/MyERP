unit View.Cidades.Cad;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  View.Base,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TViewCidadesCad = class(TViewBase)
  private
  public
  end;

var
  ViewCidadesCad: TViewCidadesCad;

implementation

{$R *.dfm}

uses
  View.Cidades.Busca;

end.
