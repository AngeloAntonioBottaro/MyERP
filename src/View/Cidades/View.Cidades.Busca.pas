unit View.Cidades.Busca;

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
  View.Base;

type
  TViewCidadesBusca = class(TViewBase)
  private
  public
  end;

var
  ViewCidadesBusca: TViewCidadesBusca;

implementation

{$R *.dfm}

uses View.Cidades.Cad;

end.
