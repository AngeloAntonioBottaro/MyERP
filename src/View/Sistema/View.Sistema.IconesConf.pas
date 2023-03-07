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
  Datasnap.DBClient;

type
  TViewSistemaIconesConf = class(TViewBase)
    pnTop: TPanel;
    pnBotton: TPanel;
    lbFuncionario: TLabel;
    edtFuncionario: TEdit;
    edtIdFuncionario: TEdit;
    btnGravar: TButton;
    btnMarcarTodos: TButton;
    btnDesmarcarTodos: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtIdFuncionarioExit(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnMarcarTodosClick(Sender: TObject);
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
  MyExceptions,
  MyMessage,
  Model.Main.Icones,
  Model.Main.Icones.Types,
  Model.Main.Icones.Consts,
  Utils.GlobalVariables;

procedure TViewSistemaIconesConf.FormCreate(Sender: TObject);
begin
   inherited;
   self.CreatePageControlIcons;
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

procedure TViewSistemaIconesConf.btnGravarClick(Sender: TObject);
begin
   if(Self.IdFuncionarioSelecionado < 0)then
     raise ExceptionInformation.Create('Para continuar selecione um funcionário');

   if(Self.IdFuncionarioSelecionado = 0)then
     if(not ShowQuestionYes('Ao lançar a permissão para "Todos", todas as demais permissões de negação dos usuários seram desconsideradas. Deseja continuar mesmo assim?'))then
       Exit;

   {Cons_Q_Universal('delete from conf_icones '+
                    'where (id_funcionario = "' + edtIdFuncionario.Text + '")';

   cons_Q_universal('insert into conf_icones (id_empresa, icone, id_funcionario)values ' + Self.RetornaListaIconesMarcadosParaInsert);}
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
   {if(not cons_TB_conf_icones('where(id_funcionario = "' + IntToStr(DBLookupFuncionario.KeyValue) + '" or id_funcionario = "0")'+
                              'and(id_empresa = "'+ V_IdEmpresaLog +'") '+
                              'order by id_funcionario desc'))
   then
     Exit;

   ModelSistemaDm.TB_conf_icones.First;
   while(not ModelSistemaDm.TB_conf_icones.Eof)do
   begin
      LNomeCheckBox := PREFIX_CHECKBOX_NAME + ModelSistemaDm.TB_conf_iconesicone.AsString;

      LCheckBox := TCheckBox(Self.FindComponent(LNomeCheckBox));
      if(Assigned(LCheckBox))then
      begin
         LCheckBox.Checked := True;
         if(Self.IdFuncionarioSelecionado <> 0)then
           LCheckBox.Enabled := ModelSistemaDm.TB_conf_iconesid_funcionario.AsInteger <> 0;
      end;

      ModelSistemaDm.TB_conf_icones.Next;
   end;}
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
   Result := '("' + VG_IdEmpresaLog.ToString + '","nada","' + edtIdFuncionario.Text + '")';

   for I := 0 to Pred(Self.ComponentCount) do
   begin
      if(Self.Components[I].ClassType = TCheckBox)then
      begin
         if(TCheckBox(Self.Components[I]).Checked)and(TCheckBox(Self.Components[I]).Enabled)then
         begin
            LNomeIcone := StringReplace(TCheckBox(Self.Components[I]).Name, PREFIX_CHECKBOX_NAME, '', [rfIgnoreCase]);
            Result := Result + ', ("' + VG_IdEmpresaLog.ToString + '","' + LNomeIcone + '", "' + edtIdFuncionario.Text + '")';
         end;
      end;
   end;
end;

procedure TViewSistemaIconesConf.edtIdFuncionarioExit(Sender: TObject);
begin
   if(FFuncionarioKeyValueAtual = Self.IdFuncionarioSelecionado)then
     Exit;

   FFuncionarioKeyValueAtual := Self.IdFuncionarioSelecionado;
   Self.HabilitarTodosCheckBox;
   Self.DesmarcarTodos;
   Self.MarcarConformeConfigurado;
end;

end.
