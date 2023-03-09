unit View.Fornecedores.Busca;

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
  Vcl.ExtCtrls;

type
  TViewFornecedoresBusca = class(TViewBaseBusca)
  private
  public
  end;

var
  ViewFornecedoresBusca: TViewFornecedoresBusca;

implementation

{$R *.dfm}

end.
