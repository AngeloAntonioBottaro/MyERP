unit View.Funcionarios.Funcoes.Cad;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  View.Base.Cadastros,
  Vcl.Forms,
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
    procedure btnBuscarClick(Sender: TObject);
  private
  public
  end;

var
  ViewFuncionariosFuncoesCad: TViewFuncionariosFuncoesCad;

implementation

{$R *.dfm}

uses View.Funcionarios.Funcoes.Busca;

procedure TViewFuncionariosFuncoesCad.btnBuscarClick(Sender: TObject);
begin
   inherited;
   if(ViewFuncionarioFuncoesBusca = nil)then Application.CreateForm(TViewFuncionarioFuncoesBusca, ViewFuncionarioFuncoesBusca);
   try
     ViewFuncionarioFuncoesBusca.btnCadastro.Enabled := False;
     ViewFuncionarioFuncoesBusca.ShowModal;
   finally
     FreeAndNil(ViewFuncionarioFuncoesBusca);
   end;
end;

end.
