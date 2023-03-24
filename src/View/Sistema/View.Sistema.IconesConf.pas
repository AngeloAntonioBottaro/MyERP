unit View.Sistema.IconesConf;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  View.Base,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.DBCtrls,
  Vcl.ComCtrls,
  Data.DB,
  Datasnap.DBClient, Vcl.Imaging.pngimage;

type
  TViewSistemaIconesConf = class(TViewBase)
    pnTop: TPanel;
    pnBotton: TPanel;
    lbFuncionario: TLabel;
    edtFuncionario: TEdit;
    edtIdFuncionario: TEdit;
    btnMarcarTodos: TButton;
    btnDesmarcarTodos: TButton;
    btnFechar: TButton;
    btnGravar: TButton;
    imgOptions: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtIdFuncionarioExit(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure edtIdFuncionarioKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure imgOptionsClick(Sender: TObject);
  private
    FFuncionarioKeyValueAtual: Integer;
    procedure CreatePageControlIcons;
    procedure CarregarFuncionariosOnShow;
    procedure MostrarAbaCadastrosOnShow;
    procedure HabilitarTodosCheckBox;
    procedure DesmarcarTodos;
    procedure MarcarConformeConfigurado;
    function IdFuncionarioSelecionado: Integer;
    function RetornaListaIconesMarcadosParaInsert: string;
    procedure MarcarCheckBoxEspecifico(ANome: string);
  public
  end;

var
  ViewSistemaIconesConf: TViewSistemaIconesConf;

implementation

{$R *.dfm}

uses
  MyConnection,
  MyExceptions,
  MyMessage,
  Utils.MyConsts,
  Utils.GlobalVariables,
  Utils.EditsKeyDownExit,
  Model.Main.Icones,
  Model.Main.Icones.Types,
  Model.Main.Icones.Consts,
  Model.Sistema.Imagens.DM, Utils.LibrarySistema;

procedure TViewSistemaIconesConf.FormCreate(Sender: TObject);
begin
   inherited;
   Self.CreatePageControlIcons;
   edtIdFuncionario.ShowHint := True;
   edtIdFuncionario.Hint := HINT_ATALHO_CONSULTA;
end;

procedure TViewSistemaIconesConf.FormShow(Sender: TObject);
begin
   inherited;
   FFuncionarioKeyValueAtual := -1;
   Self.CarregarFuncionariosOnShow;
   Self.MostrarAbaCadastrosOnShow;
end;

procedure TViewSistemaIconesConf.HabilitarTodosCheckBox;
var
  I: Integer;
begin
   for I := 0 to Pred(Self.ComponentCount) do
   Begin
      if(Self.Components[I].ClassType = TCheckBox)then
        TCheckBox(Self.Components[I]).Enabled := True;
   end;
end;

function TViewSistemaIconesConf.IdFuncionarioSelecionado: Integer;
begin
   Result := StrToIntDef(edtIdFuncionario.Text, -1);
end;

procedure TViewSistemaIconesConf.imgOptionsClick(Sender: TObject);
begin
   inherited;
   Self.MarcarCheckBoxEspecifico('ckClientes');
   Self.MarcarCheckBoxEspecifico('ckProdutos');
end;

procedure TViewSistemaIconesConf.CreatePageControlIcons;
begin
   TModelMainIcones
    .GetInstance
     .PageControlIcones
      .Formulario(Self)
      .CriarComponente;
end;

procedure TViewSistemaIconesConf.DesmarcarTodos;
begin
   btnDesmarcarTodos.Click;
end;

procedure TViewSistemaIconesConf.btnFecharClick(Sender: TObject);
begin
   Self.Close;
end;

procedure TViewSistemaIconesConf.btnGravarClick(Sender: TObject);
begin
   if(Self.IdFuncionarioSelecionado < 0)then
     raise ExceptionInformation.Create('Para continuar selecione um funcionário');

   if(Self.IdFuncionarioSelecionado = 0)then
     if(not ShowQuestionYes('Deseja lançar a configuração de icones para TODOS ?'))then
       Exit;

   MyQueryNew
    .Add('DELETE FROM CONFIGURACOES_ICONES WHERE(FUNCIONARIO = :ID)')
    .AddParam('ID', edtIdFuncionario.Text)
    .ExecSQL;

   MyQueryNew
    .Add('INSERT INTO CONFIGURACOES_ICONES (ICONE, FUNCIONARIO) VALUES ' + Self.RetornaListaIconesMarcadosParaInsert);

  try
    ShowDebug(MyQuery.SQL.Text);
    MyQuery.ExecSQL;
  except on E: Exception do
    ShowError('Não foi possível cadastrar os ícones', 'Mensagem: ' + E.Message);
  end;
end;

procedure TViewSistemaIconesConf.btnMarcarTodosClick(Sender: TObject);
var
  I: Integer;
  LOpcao: Boolean;
begin
   LOpcao := True;
   if(TButton(Sender).Tag = 2)then
     LOpcao := False;

   for I := 0 to Pred(Self.ComponentCount) do
   Begin
      if(Self.Components[I].ClassType = TCheckBox)then
      begin
         if(TCheckBox(Self.Components[I]).Enabled)then
           TCheckBox(Self.Components[I]).Checked := LOpcao;
      end;
   end;
end;

procedure TViewSistemaIconesConf.CarregarFuncionariosOnShow;
begin
   edtIdFuncionario.Text := VG_UsuarioLogadoId.ToString;
   edtIdFuncionarioExit(edtIdFuncionario);
end;

procedure TViewSistemaIconesConf.MarcarCheckBoxEspecifico(ANome: string);
var
 LCheckBox: TCheckBox;
begin
   LCheckBox := TCheckBox(Self.FindComponent(ANome.Trim));
   if(Assigned(LCheckBox))then
     LCheckBox.Checked := True;
end;

procedure TViewSistemaIconesConf.MarcarConformeConfigurado;
var
  LNomeCheckBox: String;
  LCheckBox: TCheckBox;
begin
   MyQueryNew
    .Add('SELECT * FROM CONFIGURACOES_ICONES WHERE (FUNCIONARIO = :ID)OR(FUNCIONARIO = 0)')
    .Add('ORDER BY FUNCIONARIO DESC')
    .AddParam('ID', edtIdFuncionario.Text)
    .Open;

   MyQuery.DataSet.First;
   while(not MyQuery.DataSet.Eof)do
   begin
      LNomeCheckBox := PREFIX_CHECKBOX_NAME + MyQuery.FieldByName('ICONE').AsString;

      LCheckBox := TCheckBox(Self.FindComponent(LNomeCheckBox));
      if(Assigned(LCheckBox))then
      begin
         LCheckBox.Checked := True;
         if(Self.IdFuncionarioSelecionado <> 0)then
           LCheckBox.Enabled := MyQuery.FieldByName('FUNCIONARIO').AsInteger <> 0;
      end;

      MyQuery.DataSet.Next;
   end;
end;

procedure TViewSistemaIconesConf.MostrarAbaCadastrosOnShow;
var
 LTabCadastro: TTabSheet;
begin
   LTabCadastro := TTabSheet(Self.FindComponent(TABSHEET_NAME + IntToStr(TMainIconesGroup.Cadastros.ToInteger)));
   if(not Assigned(LTabCadastro))then
     Exit;

   if(not LTabCadastro.Showing)then
     LTabCadastro.Show;
end;

function TViewSistemaIconesConf.RetornaListaIconesMarcadosParaInsert: string;
var
  I: Integer;
  LNomeIcone: string;
begin
   Result := '("nada","' + edtIdFuncionario.Text + '")';

   for I := 0 to Pred(Self.ComponentCount) do
   begin
      if(Self.Components[I].ClassType = TCheckBox)then
      begin
         if(TCheckBox(Self.Components[I]).Checked)and(TCheckBox(Self.Components[I]).Enabled)then
         begin
            LNomeIcone := StringReplace(TCheckBox(Self.Components[I]).Name, PREFIX_CHECKBOX_NAME, '', [rfIgnoreCase]);
            Result := Result + ', ("' + LNomeIcone + '", "' + edtIdFuncionario.Text + '")';
         end;
      end;
   end;
end;

procedure TViewSistemaIconesConf.edtIdFuncionarioExit(Sender: TObject);
begin
   btnGravar.Enabled := False;
   edtFuncionario.Clear;
   if(Self.IdFuncionarioSelecionado = 0)then
   begin
      edtIdFuncionario.Text := '0';
      edtFuncionario.Text   := 'Todos';
   end
   else
     IdFuncionarioExit(edtIdFuncionario, edtFuncionario);

   if(Self.IdFuncionarioSelecionado < 0)then
     Exit;

   Self.HabilitarTodosCheckBox;
   Self.DesmarcarTodos;
   Self.MarcarConformeConfigurado;
   pnTop.SetFocus;
   btnGravar.Enabled := True;
end;

procedure TViewSistemaIconesConf.edtIdFuncionarioKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   IdFuncaoFuncionarioKeyDown(edtIdFuncionario, Key, Shift);
end;

end.
