unit View.Permissoes.Grupos.Cad;

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
  Vcl.ExtCtrls,
  View.Base.Cadastros,
  Model.Permissoes.Grupos.Interfaces,
  Model.Permissoes.Grupos.Entitie;

type
  TViewPermissoesGruposCad = class(TViewBaseCadastros)
    pnTela: TPanel;
    lbId: TLabel;
    lbGrupo: TLabel;
    edtId: TEdit;
    edtNome: TEdit;
    lbDescricao: TLabel;
    edtDescricao: TEdit;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
  private
    FGrupo: IModelPermissoesGruposFactory<TModelPermissoesGruposEntitie>;
    procedure FillEntitie;
  public
    procedure InitialConfiguration; override;
    procedure NewEntitie; override;
    procedure FillFields; override;
    procedure OnBusca(AId: Integer); override;
  end;

var
  ViewPermissoesGruposCad: TViewPermissoesGruposCad;

implementation

{$R *.dfm}

uses
  Common.Utils.MyVclLibrary,
  Utils.LibrarySistema,
  Model.Permissoes.Grupos.Factory,
  View.Permissoes.Grupos.Busca;

procedure TViewPermissoesGruposCad.btnAlterarClick(Sender: TObject);
begin
   inherited;
   if(not Assigned(FGrupo))then
     Exit;

   if(not (FGrupo.Entitie.Id > 0))then
     Exit;

   Self.StartOperations;
end;

procedure TViewPermissoesGruposCad.btnBuscarClick(Sender: TObject);
begin
   inherited;
   CriarFormMsgJaAberto(TViewPermissoesGruposBusca, ViewPermissoesGruposBusca);
   try
     ViewPermissoesGruposBusca.btnCadastro.Enabled := False;
     ViewPermissoesGruposBusca.FOnBusca            := Self.OnBusca;
     ViewPermissoesGruposBusca.ShowModal;
   finally
     FreeAndNil(ViewPermissoesGruposBusca);
   end;
end;

procedure TViewPermissoesGruposCad.btnExcluirClick(Sender: TObject);
begin
   inherited;
   if(edtId.Text = EmptyStr)then
     Exit;

   FGrupo.Deletar;
   Self.EndOperations;
   Self.EmptyFields;
end;

procedure TViewPermissoesGruposCad.btnGravarClick(Sender: TObject);
begin
   inherited;
   Self.FillEntitie;
   FGrupo.Gravar;

   Self.EndOperations;
   Self.FillFields;
end;

procedure TViewPermissoesGruposCad.btnNovoClick(Sender: TObject);
begin
   inherited;
   TMyVclLibrary.SetFocusOn(edtNome);
end;

procedure TViewPermissoesGruposCad.FillEntitie;
begin
   FGrupo
    .Entitie
     .Id(edtId.Text)
     .Nome(edtNome.Text)
     .Descricao(edtDescricao.Text)
     .End_Entitie;
end;

procedure TViewPermissoesGruposCad.FillFields;
begin
   if(not Assigned(FGrupo))then
     Exit;

   edtId.Text        := FGrupo.Entitie.IdMascara;
   edtNome.Text      := FGrupo.Entitie.Nome;
   edtDescricao.Text := FGrupo.Entitie.Descricao;
end;

procedure TViewPermissoesGruposCad.InitialConfiguration;
begin
   //
end;

procedure TViewPermissoesGruposCad.NewEntitie;
begin
   FGrupo := TModelPermissoesGruposFactory.New('Cadastro de grupos de permissões');
end;

procedure TViewPermissoesGruposCad.OnBusca(AId: Integer);
begin
   Self.NewEntitie;

   FGrupo
    .Entitie
     .Id(AId)
     .End_Entitie
    .ConsultarEntitie;

   Self.FillFields;
end;

end.
