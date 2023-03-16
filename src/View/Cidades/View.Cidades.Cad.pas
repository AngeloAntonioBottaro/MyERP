unit View.Cidades.Cad;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  View.Base.Cadastros,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Model.Cidades.Interfaces,
  Model.Cidades.Entitie;

type
  TViewCidadesCad = class(TViewBaseCadastros)
    pnTela: TPanel;
    lbId: TLabel;
    lbNome: TLabel;
    lbIBGE: TLabel;
    lbUF: TLabel;
    edtId: TEdit;
    edtCidade: TEdit;
    cBoxUF: TComboBox;
    edtIBGE: TEdit;
    procedure btnBuscarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
  private
    FCidade: IModelCidadesFactory<TModelCidadesEntitie>;
  public
    procedure InitialConfiguration; override;
    procedure NewEntitie; override;
    procedure FillFields; override;
  end;

var
  ViewCidadesCad: TViewCidadesCad;

implementation

{$R *.dfm}

uses
  View.Cidades.Busca,
  Model.Cidades.Factory,
  Utils.MyConsts;

procedure TViewCidadesCad.btnBuscarClick(Sender: TObject);
begin
   inherited;
   if(ViewCidadesBusca = nil)then Application.CreateForm(TViewCidadesBusca, ViewCidadesBusca);
   try
     ViewCidadesBusca.btnCadastro.Enabled := False;
     ViewCidadesBusca.ShowModal;
   finally
     FreeAndNil(ViewCidadesBusca);
   end;
   Self.FillFields;
end;

procedure TViewCidadesCad.btnGravarClick(Sender: TObject);
begin
   inherited;
   FCidade
    .Entitie
     .Id(edtId.Text)
     .Nome(edtCidade.Text)
     .IBGE(edtIBGE.Text)
     .End_Entitie;
end;

procedure TViewCidadesCad.btnNovoClick(Sender: TObject);
begin
   inherited;
   Self.NewEntitie;
end;

procedure TViewCidadesCad.FillFields;
begin
   if(not Assigned(FCidade))then
     Exit;

   edtId.Text     := FCidade.Entitie.Id.ToString;
   edtCidade.Text := FCidade.Entitie.Nome;
   edtIBGE.Text   := FCidade.Entitie.IBGE.ToString;
end;

procedure TViewCidadesCad.FormCreate(Sender: TObject);
begin
   inherited;
   Self.InitialConfiguration;
end;

procedure TViewCidadesCad.InitialConfiguration;
var
  I: Integer;
begin
   cBoxUF.Items.Clear;
   for I := Low(ESTADOS) to High(ESTADOS) do
     cBoxUF.Items.Add(ESTADOS[I]);

   cBoxUF.ItemIndex := -1;
end;

procedure TViewCidadesCad.NewEntitie;
begin
   FCidade := TModelCidadesFactory.New;
end;

end.
