unit Model.Main.Icones.Componentes.PanelIcones;

interface

uses
  System.SysUtils,
  System.StrUtils,
  System.Classes,
  System.Generics.Collections,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Graphics,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Imaging.pngimage,
  Model.Main.Icones,
  Model.Main.Icones.Interfaces,
  Model.Main.Icones.Fields,
  Model.Main.Icones.Types;

type
  TModelMainIconesComponentesPanelIcones = class(TInterfacedObject, IModelMainIconesComponentes)
  private
    FParent: TModelMainIcones;
    FFormulario: TForm;
    FCountPanelsTopo: Integer;
    FWidthPanelTotal: Integer;
    FWidthPanelUsado: Integer;

    FPanelIconesMain: TScrollBox;
    FPanelIconesTopo: TPanel;
    FPanel: TPanel;
    procedure LimparPanelsExistentes;
    procedure CriarPanelMain;
    procedure CriarPanelTopo;
    procedure CriarPanelIcone(AModelMainIconesFields: TModelMainIconesFields);
    procedure CriarImageIcone(AModelMainIconesFields: TModelMainIconesFields);
    procedure CriarLabelIcone(AModelMainIconesFields: TModelMainIconesFields);
    procedure CarregarImagemIcone(AImage: TImage; AModelMainIconesFields: TModelMainIconesFields);

    procedure MouseEnter(Sender: TObject);
    procedure MouseLeave(Sender: TObject);

    procedure TrocarCorLabel(AComponente: TObject; ACor: TColor);
    function Formulario: TForm; overload;
  protected
    function Formulario(AFormulario: TForm): IModelMainIconesComponentes; overload;
    procedure CriarComponente;
    procedure LimparComponente;
  public
    class function New(AParent: TModelMainIcones): IModelMainIconesComponentes;
    constructor Create(AParent: TModelMainIcones);
  end;

implementation

uses
  MyExceptions,
  Model.Main.Icones.Consts;

class function TModelMainIconesComponentesPanelIcones.New(AParent: TModelMainIcones): IModelMainIconesComponentes;
begin
   Result := Self.Create(AParent);
end;

constructor TModelMainIconesComponentesPanelIcones.Create(AParent: TModelMainIcones);
begin
   FParent          := AParent;
   FCountPanelsTopo := 0;
   FWidthPanelUsado := 0;
   FWidthPanelTotal := 0;
end;

function TModelMainIconesComponentesPanelIcones.Formulario(AFormulario: TForm): IModelMainIconesComponentes;
begin
   Result      := Self;
   FFormulario := AFormulario;
end;

function TModelMainIconesComponentesPanelIcones.Formulario: TForm;
begin
   if(not assigned(FFormulario))then
     raise ExceptionRequiredField.Create('Formulário não informado');

   Result := FFormulario;
end;

procedure TModelMainIconesComponentesPanelIcones.CriarComponente;
var
 LMainIconName: TMainIconName;
 LModelMainIconesFields: TModelMainIconesFields;
begin
   Screen.Cursor := crHourGlass;
   try
     Self.LimparPanelsExistentes;
     FParent.AtualizarVisibilidades;
     for LMainIconName in FParent.Lista.ToSortKeys do
     begin
        LModelMainIconesFields := FParent.Lista.Items[LMainIconName];

        if(not LModelMainIconesFields.Visible())then
          Continue;

        Self.CriarPanelMain;
        Self.CriarPanelTopo;
        Self.CriarPanelIcone(LModelMainIconesFields);
        Self.CriarImageIcone(LModelMainIconesFields);
        Self.CriarLabelIcone(LModelMainIconesFields);
     end;
   finally
     Screen.Cursor := crDefault;
     if(Assigned(FPanelIconesMain))then
       FPanelIconesMain.Visible := True;
   end;
end;

procedure TModelMainIconesComponentesPanelIcones.LimparComponente;
begin
   Self.LimparPanelsExistentes;
end;

procedure TModelMainIconesComponentesPanelIcones.LimparPanelsExistentes;
var
 LPnMain: TComponent;
begin
   LPnMain := Formulario.FindComponent(PANEL_MAIN_NAME);

   if(not Assigned(LPnMain))then
     Exit;

   LPnMain.Free;
end;

procedure TModelMainIconesComponentesPanelIcones.CriarPanelMain;
begin
   if(Assigned(FPanelIconesMain))then
     Exit;

   FPanelIconesMain             := TScrollBox.Create(Formulario);
   FPanelIconesMain.Parent      := Formulario;
   FPanelIconesMain.Name        := PANEL_MAIN_NAME;

   FPanelIconesMain.Align       := alTop;
   FPanelIconesMain.AutoSize    := True;
   FPanelIconesMain.BevelOuter  := TBevelCut(bvNone);
   FPanelIconesMain.borderStyle := bsNone;
   FPanelIconesMain.ParentColor := False;
   FPanelIconesMain.ShowHint    := True;
   FPanelIconesMain.Visible     := False;
end;

procedure TModelMainIconesComponentesPanelIcones.CriarPanelTopo;
begin
   FWidthPanelUsado := FWidthPanelUsado + PANEL_ICONE_WIDTH;

   if((FWidthPanelUsado + PANEL_ICONE_WIDTH) >= FWidthPanelTotal)then
     FWidthPanelTotal := 0;

   if(FWidthPanelTotal <> 0)then
     Exit;

   Inc(FCountPanelsTopo);

   FPanelIconesTopo             := TPanel.Create(Formulario);
   FPanelIconesTopo.Parent      := FPanelIconesMain;
   FPanelIconesTopo.Name        := PANEL_TOPO_NAME + FCountPanelsTopo.ToString;

   FPanelIconesTopo.Visible     := True;
   FPanelIconesTopo.Align       := alBottom;
   FPanelIconesTopo.Align       := alTop;
   FPanelIconesTopo.AutoSize    := False;
   FPanelIconesTopo.BevelOuter  := TBevelCut(bvNone);
   FPanelIconesTopo.Caption     := EmptyStr;
   FPanelIconesTopo.Height      := PANEL_TOPO_HEIGHT;
   FPanelIconesTopo.ParentColor := False;
   FPanelIconesTopo.ShowHint    := True;
   FPanelIconesTopo.Top         := Screen.Height;

   FWidthPanelTotal := FPanelIconesTopo.Width;
   FWidthPanelUsado := 0;
end;

procedure TModelMainIconesComponentesPanelIcones.CriarPanelIcone(AModelMainIconesFields: TModelMainIconesFields);
begin
   FPanel              := TPanel.Create(Formulario);
   FPanel.Parent       := FPanelIconesTopo;
   FPanel.Name         := PANEL_ICONE_NAME + AModelMainIconesFields.ComponentName;
   FPanel.Align        := alRight;
   FPanel.Align        := alLeft;
   FPanel.AutoSize     := False;
   FPanel.BevelOuter   := TBevelCut(bvNone);
   FPanel.Caption      := EmptyStr;
   FPanel.Hint         := AModelMainIconesFields.Hint;
   FPanel.ParentColor  := False;
   FPanel.PopupMenu    := AModelMainIconesFields.PopupMenu;
   FPanel.ShowHint     := True;
   FPanel.Tag          := AModelMainIconesFields.Tag;
   FPanel.Visible      := True;
   FPanel.Width        := PANEL_ICONE_WIDTH;
   FPanel.OnClick      := AModelMainIconesFields.OnClickViewMain();
   FPanel.OnMouseEnter := Self.MouseEnter;
   FPanel.OnMouseLeave := Self.MouseLeave;
end;

procedure TModelMainIconesComponentesPanelIcones.CriarImageIcone(AModelMainIconesFields: TModelMainIconesFields);
var
  LImage: TImage;
begin
   LImage                := TImage.Create(Formulario);
   LImage.Align          := alTop;
   LImage.Center         := True;
   LImage.Cursor         := crHandPoint;
   LImage.Height         := IMAGE_ICONE_HEIGHT;
   LImage.Hint           := AModelMainIconesFields.Hint;
   LImage.Name           := IMAGE_ICONE_NAME + AModelMainIconesFields.ComponentName;
   LImage.Parent         := FPanel;
   LImage.ParentShowHint := True;
   LImage.Proportional   := True;
   LImage.Visible        := True;
   LImage.OnClick        := AModelMainIconesFields.OnClickViewMain();
   LImage.OnMouseEnter   := Self.MouseEnter;
   LImage.OnMouseLeave   := Self.MouseLeave;
   Self.CarregarImagemIcone(LImage, AModelMainIconesFields);
end;

procedure TModelMainIconesComponentesPanelIcones.CriarLabelIcone(AModelMainIconesFields: TModelMainIconesFields);
var
  LLabel: TLabel;
begin
   LLabel                := TLabel.Create(Formulario);
   LLabel.Align          := alClient;
   LLabel.Alignment      := taCenter;
   LLabel.Caption        := AModelMainIconesFields.Caption;
   LLabel.Cursor         := crHandPoint;
   LLabel.Font.Color     := COLOR_MAIN;
   LLabel.Font.Name      := 'Arial';
   LLabel.Font.Size      := AModelMainIconesFields.FontSize;
   LLabel.Font.Style     := [fsBold];
   LLabel.Hint           := AModelMainIconesFields.Hint;
   LLabel.Layout         := tlTop;
   LLabel.Name           := LABEL_ICONE_NAME + AModelMainIconesFields.ComponentName;
   LLabel.Parent         := FPanel;
   LLabel.ParentShowHint := True;
   LLabel.Visible        := True;
   LLabel.WordWrap       := True;
   LLabel.OnClick        := AModelMainIconesFields.OnClickViewMain();
   LLabel.OnMouseEnter   := Self.MouseEnter;
   LLabel.OnMouseLeave   := Self.MouseLeave;
end;

procedure TModelMainIconesComponentesPanelIcones.CarregarImagemIcone(AImage: TImage; AModelMainIconesFields: TModelMainIconesFields);
var
 LPngImage: TPngImage;
begin
   LPngImage := TPngImage.Create;
   try
     LPngImage.LoadFromResourceName(HInstance, AModelMainIconesFields.ResourceName);
     AImage.Picture.Assign(LPngImage);
   finally
     LPngImage.Free;
   end;
end;

procedure TModelMainIconesComponentesPanelIcones.MouseEnter(Sender: TObject);
begin
   Self.TrocarCorLabel(Sender, COLOR_SELECTED);
end;

procedure TModelMainIconesComponentesPanelIcones.MouseLeave(Sender: TObject);
begin
   Self.TrocarCorLabel(Sender, COLOR_MAIN);
end;

procedure TModelMainIconesComponentesPanelIcones.TrocarCorLabel(AComponente: TObject; ACor: TColor);
var
 I: Integer;
 LLabel: TLabel;
begin
   LLabel := nil;
   if(AComponente is TPanel)then
   begin
      for I := 0 to Pred(TPanel(AComponente).ControlCount) do
      begin
         if(TPanel(AComponente).Controls[I] is TLabel)then
           LLabel := TLabel(TPanel(AComponente).Controls[I])
      end;
   end
   else if(AComponente is TImage)then
   begin
      for I := 0 to Pred(TPanel(TImage(AComponente).Parent).ControlCount) do
      begin
         if(TPanel(TImage(AComponente).Parent).Controls[I] is TLabel)then
           LLabel := TLabel(TPanel(TImage(AComponente).Parent).Controls[I])
      end;
   end
   else if(AComponente is TLabel)then
   begin
      LLabel := TLabel(AComponente);
   end;

   if(Assigned(LLabel))then
     LLabel.Font.Color := ACor;
end;

end.
