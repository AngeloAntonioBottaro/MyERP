unit View.Funcionarios.Funcoes.Cad;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  View.Base.Cadastros,
  Vcl.StdCtrls,
  Vcl.Controls,
  Vcl.ExtCtrls;

type
  TViewFuncionariosFuncoesCad = class(TViewBaseCadastros)
    pnTela: TPanel;
    lbId: TLabel;
    lbFuncao: TLabel;
    edtId: TEdit;
    edtFuncao: TEdit;
  private
  public
  end;

var
  ViewFuncionariosFuncoesCad: TViewFuncionariosFuncoesCad;

implementation

{$R *.dfm}

end.
