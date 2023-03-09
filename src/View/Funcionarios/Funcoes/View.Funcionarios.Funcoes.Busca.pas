unit View.Funcionarios.Funcoes.Busca;

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
  TViewFuncionarioFuncoesBusca = class(TViewBaseBusca)
  private
  public
  end;

var
  ViewFuncionarioFuncoesBusca: TViewFuncionarioFuncoesBusca;

implementation

{$R *.dfm}

end.
