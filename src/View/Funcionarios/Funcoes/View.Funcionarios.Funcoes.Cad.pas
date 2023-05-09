unit View.Funcionarios.Funcoes.Cad;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Forms,
  Vcl.StdCtrls,
  Vcl.Controls,
  Vcl.ExtCtrls,
  View.Base.Cadastros,
  Model.Funcionarios.Funcoes.Interfaces,
  Model.Funcionarios.Funcoes.Entitie;

type
  TViewFuncionariosFuncoesCad = class(TViewBaseCadastros)
    pnTela: TPanel;
    lbId: TLabel;
    lbFuncao: TLabel;
    edtId: TEdit;
    edtFuncao: TEdit;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
  private
    FFuncao: IModelFuncionariosFuncoesFactory<TModelFuncionariosFuncoesEntitie>;
    procedure FillEntitie;
  public
    procedure InitialConfiguration; override;
    procedure NewEntitie; override;
    procedure FillFields; override;
    procedure OnBusca(AId: Integer); override;
  end;

var
  ViewFuncionariosFuncoesCad: TViewFuncionariosFuncoesCad;

implementation

{$R *.dfm}

uses
  Common.Utils.MyVclLibrary,
  Utils.LibrarySistema,
  Model.Funcionarios.Funcoes.Factory,
  View.Funcionarios.Funcoes.Busca;

procedure TViewFuncionariosFuncoesCad.btnAlterarClick(Sender: TObject);
begin
   inherited;
   if(not Assigned(FFuncao))then
     Exit;

   if(not (FFuncao.Entitie.Id > 0))then
     Exit;

   Self.StartOperations;
end;

procedure TViewFuncionariosFuncoesCad.btnBuscarClick(Sender: TObject);
begin
   inherited;
   CriarFormMsgJaAberto(TViewFuncionarioFuncoesBusca, ViewFuncionarioFuncoesBusca);
   try
     ViewFuncionarioFuncoesBusca.btnCadastro.Enabled := False;
     ViewFuncionarioFuncoesBusca.FOnBusca := Self.OnBusca;
     ViewFuncionarioFuncoesBusca.ShowModal;
   finally
     FreeAndNil(ViewFuncionarioFuncoesBusca);
   end;
end;

procedure TViewFuncionariosFuncoesCad.btnExcluirClick(Sender: TObject);
begin
   inherited;
   if(edtId.Text = EmptyStr)then
     Exit;

   FFuncao.Deletar;
   Self.EndOperations;
   Self.EmptyFields;
end;

procedure TViewFuncionariosFuncoesCad.btnGravarClick(Sender: TObject);
begin
   inherited;
   Self.FillEntitie;
   FFuncao.Gravar;

   Self.EndOperations;
   Self.FillFields;
end;

procedure TViewFuncionariosFuncoesCad.btnNovoClick(Sender: TObject);
begin
   inherited;
   TMyVclLibrary.SetFocusOn(edtFuncao);
end;

procedure TViewFuncionariosFuncoesCad.FillEntitie;
begin
   FFuncao
    .Entitie
     .Id(edtId.Text)
     .Nome(edtFuncao.Text)
     .End_Entitie;
end;

procedure TViewFuncionariosFuncoesCad.FillFields;
begin
   if(not Assigned(FFuncao))then
     Exit;

   edtId.Text     := FFuncao.Entitie.IdMascara;
   edtFuncao.Text := FFuncao.Entitie.Nome;
end;

procedure TViewFuncionariosFuncoesCad.InitialConfiguration;
begin
   //
end;

procedure TViewFuncionariosFuncoesCad.NewEntitie;
begin
   FFuncao := TModelFuncionariosFuncoesFactory.New('Cadastro de funções de funcioário');
end;

procedure TViewFuncionariosFuncoesCad.OnBusca(AId: Integer);
begin
   Self.NewEntitie;

   FFuncao
    .Entitie
     .Id(AId)
     .End_Entitie
    .ConsultarEntitie;

   Self.FillFields;
end;

end.
