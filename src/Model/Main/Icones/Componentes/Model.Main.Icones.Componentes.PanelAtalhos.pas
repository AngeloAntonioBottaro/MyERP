unit Model.Main.Icones.Componentes.PanelAtalhos;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Graphics,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Imaging.pngimage,
  Model.Main.Icones.Interfaces,
  Model.Main.Icones.Fields,
  Model.Main.Icones.Types;

type
  TModelMainIconesComponentesPanelAtalhos = class(TInterfacedObject, IModelMainIconesCriacoesComponentes)
  private
    FFormulario: TForm;
    FCountPanelsTopo: Integer;
    FWidthPanelTotal: Integer;
    FWidthPanelUsado: Integer;
    FPanelIconesTopo: TPanel;
    FPanel: TPanel;
    FImage: TImage;
    FLabel: TLabel;
    FModelMainIconesFields: TModelMainIconesFields;
    procedure LimparPanelsExistentes;
    procedure CriarPanelTopo;
    procedure CriarPanelIcone;
    procedure CriarImageIcone;
    procedure CriarLabelIcone;
    procedure CarregarImagemIcone;
  protected
    procedure CriarComponente;
  public
    class function New(AFormulario: TForm): IModelMainIconesCriacoesComponentes;
    constructor Create(AFormulario: TForm);
  end;

implementation

uses
  Model.Main.Icones;

const
 PANEL_TOPO_NAME    = 'pnTopo';
 PANEL_TOPO_HEIGHT  = 75;
 PANEL_ICONE_NAME   = 'pn';
 PANEL_ICONE_WIDTH  = 130;
 IMAGE_ICONE_NAME   = 'img';
 IMAGE_ICONE_HEIGHT = 40;
 LABEL_ICONE_NAME   = 'lb';


class function TModelMainIconesComponentesPanelAtalhos.New(AFormulario: TForm): IModelMainIconesCriacoesComponentes;
begin
   Result := Self.Create(AFormulario);
end;

constructor TModelMainIconesComponentesPanelAtalhos.Create(AFormulario: TForm);
begin
   FFormulario      := AFormulario;
   FCountPanelsTopo := 0;
   FWidthPanelUsado := 0;
   FWidthPanelTotal := 0;
end;

procedure TModelMainIconesComponentesPanelAtalhos.CriarComponente;
var
 LMainIconName: TMainIconName;
begin
   Screen.Cursor := crHourGlass;
   try
     Self.LimparPanelsExistentes;
     TModelMainIcones.GetInstance.AtualizaVisibilidades;
     for LMainIconName in TModelMainIcones.GetInstance.Lista.ToSortKeys do
     begin
        FModelMainIconesFields := TModelMainIcones.GetInstance.Lista.Items[LMainIconName];

        if(not FModelMainIconesFields.Visible)then
          Continue;

        Self.CriarPanelTopo;
        Self.CriarPanelIcone;
        Self.CriarImageIcone;
        Self.CriarLabelIcone;
     end;
   finally
     Screen.Cursor := crDefault;
   end;
end;

procedure TModelMainIconesComponentesPanelAtalhos.LimparPanelsExistentes;
var
 LPnTopo: TComponent;
 LCountPanelsTopo: Integer;
begin
   LCountPanelsTopo := 1;
   while(LCountPanelsTopo > 0)do
   begin
      LPnTopo := FFormulario.FindComponent(PANEL_TOPO_NAME + LCountPanelsTopo.ToString);

      if(LPnTopo = nil)then
      begin
         LCountPanelsTopo := 0;
         Continue;
      end;

      LPnTopo.Free;
      Inc(LCountPanelsTopo);
   end;
end;

procedure TModelMainIconesComponentesPanelAtalhos.CriarPanelTopo;
begin
   FWidthPanelUsado := FWidthPanelUsado + PANEL_ICONE_WIDTH;

   if((FWidthPanelUsado + PANEL_ICONE_WIDTH) >= FWidthPanelTotal)then
     FWidthPanelTotal := 0;

   if(FWidthPanelTotal <> 0)then
     Exit;

   Inc(FCountPanelsTopo);

   FPanelIconesTopo             := TPanel.Create(FFormulario);
   FPanelIconesTopo.Parent      := FFormulario;
   FPanelIconesTopo.Visible     := True;
   FPanelIconesTopo.Name        := PANEL_TOPO_NAME + FCountPanelsTopo.ToString;
   FPanelIconesTopo.Caption     := EmptyStr;
   FPanelIconesTopo.Align       := alBottom;
   FPanelIconesTopo.Align       := alTop;
   FPanelIconesTopo.ShowHint    := True;
   FPanelIconesTopo.Height      := PANEL_TOPO_HEIGHT;
   FPanelIconesTopo.ParentColor := False;
   FPanelIconesTopo.BevelOuter  := TBevelCut(bvNone);

   FWidthPanelTotal := FPanelIconesTopo.Width;
   FWidthPanelUsado := 0;
end;

procedure TModelMainIconesComponentesPanelAtalhos.CriarPanelIcone;
begin
   FPanel             := TPanel.Create(FFormulario);
   FPanel.Parent      := FPanelIconesTopo;
   FPanel.Visible     := True;
   FPanel.Name        := PANEL_ICONE_NAME + FModelMainIconesFields.ComponentName;
   FPanel.Caption     := EmptyStr;
   FPanel.Align       := alRight;
   FPanel.Align       := alLeft;
   FPanel.Width       := PANEL_ICONE_WIDTH;
   FPanel.ShowHint    := True;
   FPanel.Hint        := FModelMainIconesFields.Hint;
   FPanel.ParentColor := False;
   FPanel.BevelOuter  := TBevelCut(bvNone);
   FPanel.PopupMenu   := FModelMainIconesFields.PopupMenu;
   FPanel.Tag         := FModelMainIconesFields.Tag;

   FPanel.OnClick     := FModelMainIconesFields.OnClickViewMain();
end;

procedure TModelMainIconesComponentesPanelAtalhos.CriarImageIcone;
begin
   FImage                := TImage.Create(FFormulario);
   FImage.Parent         := FPanel;
   FImage.Visible        := True;
   FImage.Name           := IMAGE_ICONE_NAME + FModelMainIconesFields.ComponentName;
   FImage.Align          := alTop;
   FImage.Height         := IMAGE_ICONE_HEIGHT;
   FImage.ParentShowHint := True;
   FImage.Hint           := FModelMainIconesFields.Hint;
   FImage.Proportional   := True;
   FImage.Center         := True;

   FImage.OnClick        := FModelMainIconesFields.OnClickViewMain();

   Self.CarregarImagemIcone;
end;

procedure TModelMainIconesComponentesPanelAtalhos.CriarLabelIcone;
begin
   FLabel                := TLabel.Create(FFormulario);
   FLabel.Parent         := FPanel;
   FLabel.Visible        := True;
   FLabel.Name           := LABEL_ICONE_NAME + FModelMainIconesFields.ComponentName;
   FLabel.Align          := alClient;
   FLabel.Caption        := FModelMainIconesFields.Caption;
   FLabel.ParentShowHint := True;
   FLabel.Hint           := FModelMainIconesFields.Hint;
   FLabel.Alignment      := taCenter;
   FLabel.Font.Color     := clRed;
   FLabel.Font.Size      := FModelMainIconesFields.FontSize;
   FLabel.Font.Name      := 'Arial';
   FLabel.Font.Style     := [fsBold];
   FLabel.Layout         := tlTop;
   FLabel.WordWrap       := True;

   FLabel.OnClick        := FModelMainIconesFields.OnClickViewMain();
end;

procedure TModelMainIconesComponentesPanelAtalhos.CarregarImagemIcone;
var
 LPngImage: TPngImage;
begin
   LPngImage := TPngImage.Create;
   try
     LPngImage.LoadFromResourceName(HInstance, FModelMainIconesFields.ResourceName);
     TImage(FImage).Picture.Assign(LPngImage);
   finally
     LPngImage.Free;
   end;
end;

end.
