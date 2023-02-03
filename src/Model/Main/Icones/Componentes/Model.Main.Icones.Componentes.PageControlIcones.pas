unit Model.Main.Icones.Componentes.PageControlIcones;

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
  Vcl.ComCtrls,
  Vcl.Imaging.pngimage,
  Model.Main.Icones,
  Model.Main.Icones.Interfaces,
  Model.Main.Icones.Fields,
  Model.Main.Icones.Types;

type
  TModelMainIconesComponentesPageControlIcones = class(TInterfacedObject, IModelMainIconesComponentes)
  private
    FParent: TModelMainIcones;
    FFormulario: TForm;
    FCountPanelsTopo: Integer;
    FWidthPanelTotal: Integer;
    FWidthPanelUsado: Integer;
    FPageControlWidth: Integer;

    FPageControl: TPageControl;
    FPanelTabSheet: TPanel;
    FPanelTopo: TPanel;
    FPanelIcone: TPanel;
    procedure CriarPageControl;
    procedure CriarTabSheet(AMainIconesGroup: TMainIconesGroup);
    procedure CriarPanelTabSheet(ATabSheet: TTabSheet);
    procedure PreencherTabSheet(AMainIconesGroup: TMainIconesGroup);
    procedure CriarPanelTopo;
    procedure CriarPanelIcone(AModelMainIconesFields: TModelMainIconesFields);
    procedure CriarImageIcone(AModelMainIconesFields: TModelMainIconesFields);
    procedure CriarCheckBoxIcone(AModelMainIconesFields: TModelMainIconesFields);
    procedure CarregarImagemIcone(AImage: TImage; AModelMainIconesFields: TModelMainIconesFields);
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

class function TModelMainIconesComponentesPageControlIcones.New(AParent: TModelMainIcones): IModelMainIconesComponentes;
begin
   Result := Self.Create(AParent);
end;

constructor TModelMainIconesComponentesPageControlIcones.Create(AParent: TModelMainIcones);
begin
   FParent          := AParent;
   FCountPanelsTopo := 0;
end;

function TModelMainIconesComponentesPageControlIcones.Formulario(AFormulario: TForm): IModelMainIconesComponentes;
begin
   Result      := Self;
   FFormulario := AFormulario;
end;

function TModelMainIconesComponentesPageControlIcones.Formulario: TForm;
begin
   if(not assigned(FFormulario))then
     raise ExceptionRequired.Create('Formulário não informado');

   Result := FFormulario;
end;

procedure TModelMainIconesComponentesPageControlIcones.LimparComponente;
var
  LPgControl: TComponent;
begin
   LPgControl := Formulario.FindComponent(PAGECONTROL_NAME);

   if(not Assigned(LPgControl))then
     Exit;

   LPgControl.Free;
end;

procedure TModelMainIconesComponentesPageControlIcones.CriarComponente;
var
  LMainIconesGroup: TMainIconesGroup;
begin
   Screen.Cursor := crHourGlass;
   try
     Self.LimparComponente;
     Self.CriarPageControl;

     for LMainIconesGroup := Low(TMainIconesGroup) to High(TMainIconesGroup) do
     begin
        Self.CriarTabSheet(LMainIconesGroup);
     end;
   finally
     Screen.Cursor := crDefault;
     if(Assigned(FPageControl))then
       FPageControl.Visible := True;
   end;
end;

procedure TModelMainIconesComponentesPageControlIcones.CriarPageControl;
begin
   FPageControl                  := TPageControl.Create(Formulario);
   FPageControl.Parent           := Formulario;
   FPageControl.Name             := PAGECONTROL_NAME;
   FPageControl.AlignWithMargins := True;
   FPageControl.Align            := alClient;
   FPageControl.Font.Style       := [fsBold];

   FPageControlWidth := FPageControl.Width + 15;
end;

procedure TModelMainIconesComponentesPageControlIcones.CriarTabSheet(AMainIconesGroup: TMainIconesGroup);
var
  LTabSheet: TTabSheet;
begin
   LTabSheet             := TTabSheet.Create(Formulario);
   LTabSheet.PageControl := FPageControl;
   LTabSheet.Caption     := AMainIconesGroup.ToString;
   LTabSheet.Name        := TABSHEET_NAME + IntToStr(AMainIconesGroup.ToInteger);
   LTabSheet.ParentFont  := False;

   Self.CriarPanelTabSheet(LTabSheet);
   Self.PreencherTabSheet(AMainIconesGroup);
end;

procedure TModelMainIconesComponentesPageControlIcones.CriarPanelTabSheet(ATabSheet: TTabSheet);
begin
   FPanelTabSheet                  := TPanel.Create(Formulario);
   FPanelTabSheet.Parent           := ATabSheet;
   FPanelTabSheet.Name             := TABSHEET_PANEL_NAME + FCountPanelsTopo.ToString;
   FPanelTabSheet.Visible          := True;
   FPanelTabSheet.Align            := alClient;
   FPanelTabSheet.AlignWithMargins := True;
   FPanelTabSheet.BevelOuter       := TBevelCut(bvNone);
   FPanelTabSheet.Caption          := EmptyStr;
   FPanelTabSheet.ShowHint         := True;
   FPanelTabSheet.ParentBackground := False;
end;

procedure TModelMainIconesComponentesPageControlIcones.PreencherTabSheet(AMainIconesGroup: TMainIconesGroup);
var
  LMainIconName: TMainIconName;
  LModelMainIconesFields: TModelMainIconesFields;
begin
   FWidthPanelUsado := 0;
   FWidthPanelTotal := 0;

   for LMainIconName in FParent.ListaIcones.ToSortKeys do
   begin
      LModelMainIconesFields := FParent.ListaIcones.Items[LMainIconName];

      if(LModelMainIconesFields.GroupOwner <> AMainIconesGroup.ToInteger)then
        Continue;

      Self.CriarPanelTopo;
      Self.CriarPanelIcone(LModelMainIconesFields);
      Self.CriarImageIcone(LModelMainIconesFields);
      Self.CriarCheckBoxIcone(LModelMainIconesFields);
   end;
end;

procedure TModelMainIconesComponentesPageControlIcones.CriarPanelTopo;
begin
   FWidthPanelUsado := FWidthPanelUsado + TABSHEET_PANEL_ICON_WIDTH;

   if((FWidthPanelUsado + TABSHEET_PANEL_ICON_WIDTH) >= FWidthPanelTotal)then
     FWidthPanelTotal := 0;

   if(FWidthPanelTotal <> 0)then
     Exit;

   Inc(FCountPanelsTopo);

   FPanelTopo             := TPanel.Create(Formulario);
   FPanelTopo.Parent      := FPanelTabSheet;
   FPanelTopo.Name        := PANEL_TOP_NAME + FCountPanelsTopo.ToString;
   FPanelTopo.Visible     := True;
   FPanelTopo.Align       := alBottom;
   FPanelTopo.Align       := alTop;
   FPanelTopo.AutoSize    := False;
   FPanelTopo.BevelOuter  := TBevelCut(bvNone);
   FPanelTopo.Caption     := EmptyStr;
   FPanelTopo.Height      := TABSHEET_PANEL_TOP_HEIGHT;
   FPanelTopo.ParentColor := False;
   FPanelTopo.ShowHint    := True;
   FPanelTopo.Top         := Screen.Height;

   FWidthPanelTotal := FPageControlWidth;
   FWidthPanelUsado := 0;
end;

procedure TModelMainIconesComponentesPageControlIcones.CriarPanelIcone(AModelMainIconesFields: TModelMainIconesFields);
begin
   FPanelIcone             := TPanel.Create(Formulario);
   FPanelIcone.Parent      := FPanelTopo;
   FPanelIcone.Name        := PREFIX_PANEL_NAME + AModelMainIconesFields.ComponentName;
   FPanelIcone.Align       := alRight;
   FPanelIcone.Align       := alLeft;
   FPanelIcone.AutoSize    := False;
   FPanelIcone.BevelOuter  := TBevelCut(bvNone);
   FPanelIcone.Caption     := EmptyStr;
   FPanelIcone.ParentColor := False;
   FPanelIcone.ShowHint    := True;
   FPanelIcone.Tag         := AModelMainIconesFields.Tag;
   FPanelIcone.Visible     := True;
   FPanelIcone.Width       := TABSHEET_PANEL_ICON_WIDTH;
end;

procedure TModelMainIconesComponentesPageControlIcones.CriarImageIcone(AModelMainIconesFields: TModelMainIconesFields);
var
  LImage: TImage;
begin
   LImage                  := TImage.Create(Formulario);
   LImage.Align            := alLeft;
   LImage.Center           := True;
   LImage.Cursor           := crHandPoint;
   LImage.Hint             := AModelMainIconesFields.Hint;
   LImage.Name             := PREFIX_IMAGE_ICON_NAME + AModelMainIconesFields.ComponentName;
   LImage.Parent           := FPanelIcone;
   LImage.ParentShowHint   := True;
   LImage.Proportional     := True;
   LImage.Visible          := True;
   LImage.Width            := IMAGE_ICON_WIDTH;
   LImage.AlignWithMargins := True;
   LImage.Margins.Left     := 10;

   Self.CarregarImagemIcone(LImage, AModelMainIconesFields);
end;

procedure TModelMainIconesComponentesPageControlIcones.CarregarImagemIcone(AImage: TImage; AModelMainIconesFields: TModelMainIconesFields);
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

procedure TModelMainIconesComponentesPageControlIcones.CriarCheckBoxIcone(AModelMainIconesFields: TModelMainIconesFields);
const
  SPACE_BETWEN_IMAGE_CHECKBOX = 18;
  MARGIN_PANEL = 5;
var
  LCheckBox: TCheckBox;
  LCheckBoxWidth: Integer;
  LCheckBoxWidthMax: Integer;
  LCheckBoxHeight: Integer;
begin
   LCheckBox                := TCheckBox.Create(Formulario);
   LCheckBox.Caption        := AModelMainIconesFields.CaptionShort;
   LCheckBox.Cursor         := crHandPoint;
   LCheckBox.Font.Name      := 'Arial';
   LCheckBox.Hint           := AModelMainIconesFields.Hint;
   LCheckBox.Name           := PREFIX_CHECKBOX_NAME + AModelMainIconesFields.ComponentName;
   LCheckBox.Parent         := FPanelIcone;
   LCheckBox.ParentShowHint := True;
   LCheckBox.Visible        := True;
   LCheckBox.WordWrap       := True;

   LCheckBoxWidthMax := TABSHEET_PANEL_ICON_WIDTH - IMAGE_ICON_WIDTH - SPACE_BETWEN_IMAGE_CHECKBOX - MARGIN_PANEL;
   LCheckBoxWidth    := CHECKBOX_MARGEM + (Length(LCheckBox.Caption) * PIXEL_FOR_LETTER);

   LCheckBoxHeight := CHECKBOX_HEIGHT;
   if(LCheckBoxWidth > LCheckBoxWidthMax)then
   begin
      LCheckBoxHeight := LCheckBoxHeight * 2;
      LCheckBoxWidth  := LCheckBoxWidthMax;
   end;

   LCheckBox.Height := LCheckBoxHeight;
   LCheckBox.Width  := LCheckBoxWidth;
   LCheckBox.Left   := IMAGE_ICON_WIDTH + SPACE_BETWEN_IMAGE_CHECKBOX;
   LCheckBox.Top    := ((TABSHEET_PANEL_TOP_HEIGHT - LCheckBoxHeight) div 2);
end;

end.
