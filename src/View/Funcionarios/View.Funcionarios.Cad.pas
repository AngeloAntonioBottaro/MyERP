unit View.Funcionarios.Cad;

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
  TViewFuncionariosCad = class(TViewBaseCadastros)
  private
  public
  end;

var
  ViewFuncionariosCad: TViewFuncionariosCad;

implementation

{$R *.dfm}

end.
