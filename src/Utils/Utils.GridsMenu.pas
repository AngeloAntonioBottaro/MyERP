unit Utils.GridsMenu;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Vcl.ExtCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.Menus,
  Vcl.Imaging.pngimage,
  Utils.MyGridLibrary;

type
  TUtilsGridsMenu = class
  private
    FGridLib: TMyGridLibrary;
    FPopupMenu: TPopupMenu;
    procedure CriarItensMenu;
    procedure CriarPopupMenu(AImage: TImage);
    procedure CarregarImagem(AImage: TImage);
  public
    class function New(AImage: TImage; AGrid: TDBGrid; ANomeConf: string): TUtilsGridsMenu;
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
  Model.Sistema.Imagens.DM,
  Utils.MyVclLibrary;

class function TUtilsGridsMenu.New(AImage: TImage; AGrid: TDBGrid; ANomeConf: string): TUtilsGridsMenu;
begin
   if(AImage = nil)then
     raise ExceptionWarning.Create('Imagem de configuração do menu da grid não informada');

   if(AGrid = nil)then
     raise ExceptionWarning.Create('Grid para configuração do menu não informada');

   if(ANomeConf.IsEmpty)then
     raise ExceptionWarning.Create('Nome da configuração do menu da grid não informado');

   Result := Self.Create(AImage, AGrid, ANomeConf);
end;

constructor TUtilsGridsMenu.Create(AImage: TImage; AGrid: TDBGrid; ANomeConf: string);
begin
   FGridLib := TMyGridLibrary.New(AGrid, ANomeConf);
   FGridLib.CarregarConfiguracoes;

   Self.CriarPopupMenu(AImage);
   Self.CriarItensMenu;
   Self.CarregarImagem(AImage);
   AImage.OnClick   := imgConfGridClick;
   AImage.PopupMenu := FPopupMenu;
end;

destructor TUtilsGridsMenu.Destroy;
begin
   if(Assigned(FGridLib))then
     FGridLib.Free;

   if(Assigned(FPopupMenu))then
     FPopupMenu.Free;

   inherited;
end;

procedure TUtilsGridsMenu.CarregarImagem(AImage: TImage);
var
  LPngImage: TPngImage;
begin
   LPngImage := TPngImage.Create;
   try
     LPngImage.LoadFromResourceName(HInstance, 'confgrid');
     AImage.Picture.Assign(LPngImage);
     AImage.Center       := True;
     AImage.Proportional := True;
   finally
     LPngImage.Free;
   end;
end;

procedure TUtilsGridsMenu.imgConfGridClick(Sender: TObject);
begin
   TMyVclLibrary.PopUpMenuSelfActive(TImage(Sender));
end;

procedure TUtilsGridsMenu.AumentarFonte1Click(Sender: TObject);
begin
   FGridLib.AumentarFonte;
end;

procedure TUtilsGridsMenu.DiminuirFonte1Click(Sender: TObject);
begin
   FGridLib.DiminuirFonte;
end;

procedure TUtilsGridsMenu.DeixarNegrito1Click(Sender: TObject);
begin
   FGridLib.DeixarNegrito;
end;

procedure TUtilsGridsMenu.TirarNegrito1Click(Sender: TObject);
begin
   FGridLib.TirarNegrito;
end;

procedure TUtilsGridsMenu.GravarConfiguracoes1Click(Sender: TObject);
begin
   FGridLib.SalvarConfiguracoes;
end;

procedure TUtilsGridsMenu.RestaurarConfiguracoes1Click(Sender: TObject);
begin
   FGridLib.RestaurarPadrao;
end;

procedure TUtilsGridsMenu.CriarPopupMenu(AImage: TImage);
begin
   FPopupMenu        := TPopupMenu.Create(AImage);
   FPopupMenu.Name   := 'pMenuConfGrid';
   FPopupMenu.Images := ModelSistemaImagensDM.imgListPopupMenuConfGrid;
end;

procedure TUtilsGridsMenu.CriarItensMenu;
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
