unit Utils.ConfGrid;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Vcl.ExtCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.Menus,
  Vcl.Imaging.pngimage,
  MyDBGridLibrary;

type
  TUtilsConfGrid = class
  private
    FGridLib: TMyGridLibrary;
    FPopupMenu: TPopupMenu;
    procedure CriarItensMenu;
    procedure CriarPopupMenu(AImage: TImage);
    procedure ConfigurarImagem(AImage: TImage);
  public
    class function New(AImage: TImage; AGrid: TDBGrid; ANomeConf: string): TUtilsConfGrid;
    constructor Create(AImage: TImage; AGrid: TDBGrid; ANomeConf: string);
    destructor Destroy; override;

    procedure AumentarFonte1Click(Sender: TObject);
    procedure DeixarNegrito1Click(Sender: TObject);
    procedure DiminuirFonte1Click(Sender: TObject);
    procedure GravarConfiguracoes1Click(Sender: TObject);
    procedure RestaurarConfiguracoes1Click(Sender: TObject);
    procedure TirarNegrito1Click(Sender: TObject);
    procedure imgConfGridClick(Sender: TObject);
  end;

implementation

uses
  MyExceptions,
  MyVclLibrary,
  Model.Sistema.Imagens.DM;

class function TUtilsConfGrid.New(AImage: TImage; AGrid: TDBGrid; ANomeConf: string): TUtilsConfGrid;
begin
   if(AImage = nil)then
     raise ExceptionWarning.Create('Imagem de configuração do menu da grid não informada');

   if(AGrid = nil)then
     raise ExceptionWarning.Create('Grid para configuração do menu não informada');

   if(ANomeConf.IsEmpty)then
     raise ExceptionWarning.Create('Nome da configuração do menu da grid não informado');

   Result := Self.Create(AImage, AGrid, ANomeConf);
end;

constructor TUtilsConfGrid.Create(AImage: TImage; AGrid: TDBGrid; ANomeConf: string);
begin
   FGridLib := TMyGridLibrary.New(AGrid, ANomeConf);
   FGridLib.CarregarConfiguracoes;

   Self.CriarPopupMenu(AImage);
   Self.CriarItensMenu;
   Self.ConfigurarImagem(AImage);
end;

destructor TUtilsConfGrid.Destroy;
begin
   if(Assigned(FGridLib))then
     FGridLib.Free;

   if(Assigned(FPopupMenu))then
     FPopupMenu.Free;

   inherited;
end;

procedure TUtilsConfGrid.ConfigurarImagem(AImage: TImage);
var
  LPngImage: TPngImage;
begin
   LPngImage := TPngImage.Create;
   try
     LPngImage.LoadFromResourceName(HInstance, 'confgrid');
     AImage.Picture.Assign(LPngImage);
   finally
     LPngImage.Free;
   end;

   AImage.ShowHint     := True;
   AImage.Hint         := 'Configurar grid';
   AImage.Center       := True;
   AImage.Proportional := True;
   AImage.OnClick      := imgConfGridClick;
   AImage.PopupMenu    := FPopupMenu;
end;

procedure TUtilsConfGrid.imgConfGridClick(Sender: TObject);
begin
   TMyVclLibrary.PopUpMenuSelfActive(TImage(Sender));
end;

procedure TUtilsConfGrid.AumentarFonte1Click(Sender: TObject);
begin
   FGridLib.AumentarFonte;
end;

procedure TUtilsConfGrid.DiminuirFonte1Click(Sender: TObject);
begin
   FGridLib.DiminuirFonte;
end;

procedure TUtilsConfGrid.DeixarNegrito1Click(Sender: TObject);
begin
   FGridLib.DeixarNegrito;
end;

procedure TUtilsConfGrid.TirarNegrito1Click(Sender: TObject);
begin
   FGridLib.TirarNegrito;
end;

procedure TUtilsConfGrid.GravarConfiguracoes1Click(Sender: TObject);
begin
   FGridLib.SalvarConfiguracoes;
end;

procedure TUtilsConfGrid.RestaurarConfiguracoes1Click(Sender: TObject);
begin
   FGridLib.RestaurarPadrao;
end;

procedure TUtilsConfGrid.CriarPopupMenu(AImage: TImage);
begin
   FPopupMenu        := TPopupMenu.Create(AImage);
   FPopupMenu.Name   := 'pMenuConfGrid';
   FPopupMenu.Images := ModelSistemaImagensDM.imgListPopupMenuConfGrid;
end;

procedure TUtilsConfGrid.CriarItensMenu;
var
  LItem: TMenuItem;
begin
   LItem := TMenuItem.Create(FPopupMenu);
   LItem.Caption    := 'Aumentar fonte da grid';
   LItem.OnClick    := AumentarFonte1Click;
   LItem.ImageIndex := 0;
   FPopupMenu.Items.Add(LItem);

   LItem := TMenuItem.Create(FPopupMenu);
   LItem.Caption    := 'Diminuir fonte da grid';
   LItem.OnClick    := DiminuirFonte1Click;
   LItem.ImageIndex := 1;
   FPopupMenu.Items.Add(LItem);

   LItem := TMenuItem.Create(FPopupMenu);
   LItem.Caption    := 'Deixar grid em negrito';
   LItem.OnClick    := DeixarNegrito1Click;
   LItem.ImageIndex := 2;
   FPopupMenu.Items.Add(LItem);

   LItem := TMenuItem.Create(FPopupMenu);
   LItem.Caption    := 'Tirar negrito da grid';
   LItem.OnClick    := TirarNegrito1Click;
   LItem.ImageIndex := 3;
   FPopupMenu.Items.Add(LItem);

   LItem := TMenuItem.Create(FPopupMenu);
   LItem.Caption := '-';
   FPopupMenu.Items.Add(LItem);

   LItem := TMenuItem.Create(FPopupMenu);
   LItem.Caption    := 'Gravar configurações da grid';
   LItem.OnClick    := GravarConfiguracoes1Click;
   LItem.ImageIndex := 4;
   FPopupMenu.Items.Add(LItem);

   LItem := TMenuItem.Create(FPopupMenu);
   LItem.Caption    := 'Restaurar configuração padrão da grid';
   LItem.OnClick    := RestaurarConfiguracoes1Click;
   LItem.ImageIndex := 5;
   FPopupMenu.Items.Add(LItem);
end;

end.
