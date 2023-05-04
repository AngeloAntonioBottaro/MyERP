unit View.Sistema.MenuConf;

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
  View.Base,
  Vcl.StdCtrls,
  Vcl.CheckLst,
  Vcl.ExtCtrls,
  Vcl.Menus,
  Data.DB, Vcl.ComCtrls;

type
  TItemMenu = class
  private
    FNome: string;
  public
    constructor Create(ANomeItem: string);
    function Nome: string;
  end;

type
  TViewSistemaMenuConf = class(TViewBase)
    ckList: TCheckListBox;
    pnButtons: TPanel;
    btnGravar: TButton;
    btnFechar: TButton;
    StatusBar1: TStatusBar;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnFecharClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    FMenu: TMenu;
    FFormulario: string;
    procedure CarregarMenu;
    procedure AddItemNaLista(ACaption, AName: string; AChecked: Boolean);
  public
    property Menu: TMenu write FMenu;
    property Formulario: string write FFormulario;
  end;

procedure ConfigurarMenu(AMenu: TMenu; AFormulario: string);
procedure CarregarConfiguracoesMenu(AMenu: TMenu; AFormulario: string);

var
  ViewSistemaMenuConf: TViewSistemaMenuConf;

implementation

{$R *.dfm}

uses
  Model.Sistema.Imagens.DM,
  Utils.GlobalVariables,
  MyMessage,
  MyExceptions,
  MyConnection;

procedure ConfigurarMenu(AMenu: TMenu; AFormulario: string);
begin
   if(ViewSistemaMenuConf = nil)then Application.CreateForm(TViewSistemaMenuConf, ViewSistemaMenuConf);
   try
     ViewSistemaMenuConf.Menu       := AMenu;
     ViewSistemaMenuConf.Formulario := AFormulario;
     ViewSistemaMenuConf.ShowModal;
   finally
     FreeAndNil(ViewSistemaMenuConf);
   end;
end;

procedure CarregarConfiguracoesMenu(AMenu: TMenu; AFormulario: string);
var
  I: Integer;
begin
   MyQueryNew
    .Add('SELECT * FROM CONFIGURACOES_MENUS')
    .Add('WHERE(ID_FUNCIONARIO = :ID_FUNCIONARIO)AND(FORMULARIO = :FORMULARIO)')
    .AddParam('ID_FUNCIONARIO', VG_UsuarioLogadoId)
    .AddParam('FORMULARIO', AFormulario)
    .Open;

   for I := 0 to Pred(AMenu.Items.Count) do
   begin
      if(AMenu.Items[I].Tag = 999)then
        Continue;

      if(AMenu.Items[I].Caption.Equals('-'))then
        Continue;

      AMenu.Items[I].Visible := MyQuery.DataSet.Locate('NOME_MENU', AMenu.Items[I].Name, [loCaseInsensitive]);
   end;
end;

{ TItemMenu }

constructor TItemMenu.Create(ANomeItem: string);
begin
   FNome := ANomeItem;
end;

function TItemMenu.Nome: string;
begin
   Result := FNome;
end;

procedure TViewSistemaMenuConf.btnFecharClick(Sender: TObject);
begin
   inherited;
   Self.Close;
end;

procedure TViewSistemaMenuConf.btnGravarClick(Sender: TObject);
var
  I: Integer;
begin
   inherited;
   try
     MyQueryNew
      .Add('DELETE FROM CONFIGURACOES_MENUS')
      .Add('WHERE(ID_FUNCIONARIO = :ID_FUNCIONARIO)AND(FORMULARIO = :FORMULARIO)')
      .AddParam('ID_FUNCIONARIO', VG_UsuarioLogadoId)
      .AddParam('FORMULARIO', FFormulario)
      .ExecSQL;

     for I := 0 to Pred(ckList.Count) do
     begin
        if(not ckList.Checked[I])then
          Continue;

        MyQueryNew
         .Add('INSERT INTO CONFIGURACOES_MENUS(ID_FUNCIONARIO, NOME_MENU, FORMULARIO)')
         .Add('VALUES')
         .Add('(:ID_FUNCIONARIO, :NOME_MENU, :FORMULARIO)')
         .AddParam('ID_FUNCIONARIO', VG_UsuarioLogadoId)
         .AddParam('NOME_MENU', TItemMenu(ckList.Items.Objects[I]).Nome)
         .AddParam('FORMULARIO', FFormulario)
         .ExecSQL;
     end;

     ShowDone('Configurações do menu gravadas com sucesso');
   except on E: Exception do
     ShowError('Não foi possível gravar as configurações do menu', 'Mensagem: ' + E.Message);
   end;
end;

procedure TViewSistemaMenuConf.FormClose(Sender: TObject; var Action: TCloseAction);
var
  I: Integer;
begin
   inherited;
   for I := 0 to Pred(ckList.Count) do
   begin
      ckList.Items.Objects[I].Free;
   end;
end;

procedure TViewSistemaMenuConf.FormShow(Sender: TObject);
begin
   inherited;
   if(not Assigned(FMenu))then
   begin
      Self.Close;
      raise ExceptionRequired.Create('Informe o menu para configuração');
   end;

   StatusBar1.Panels[0].Text := 'Menu: ' + FMenu.Name;
   StatusBar1.Panels[1].Text := 'Formulário: ' + FFormulario;

   Self.CarregarMenu;
end;

procedure TViewSistemaMenuConf.CarregarMenu;
var
  I: Integer;
begin
   for I := 0 to Pred(FMenu.Items.Count) do
   begin
      if(FMenu.Items[I].Tag = 999)then
        Continue;

      Self.AddItemNaLista(FMenu.Items[I].Caption, FMenu.Items[I].Name, FMenu.Items[I].Visible);
   end;
end;

procedure TViewSistemaMenuConf.AddItemNaLista(ACaption, AName: string; AChecked: Boolean);
var
  LCaption: string;
begin
   LCaption := StringReplace(ACaption, '&', '', [rfReplaceAll, rfIgnoreCase]);

   if(ACaption.Equals('-'))then
     LCaption := '-------------------------------';

   ckList.AddItem(LCaption, TItemMenu.Create(AName));
   ckList.Checked[ckList.Items.Count -1] := AChecked;

   if(ACaption.Equals('-'))then
     ckList.ItemEnabled[ckList.Items.Count -1] := False;
end;

end.
