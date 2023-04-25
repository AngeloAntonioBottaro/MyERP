unit Utils.ConfMenu;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Vcl.ExtCtrls,
  Vcl.Menus,
  Vcl.Imaging.pngimage;

type
  TUtilsConfMenu = class
  private
    FPopupMenu: TPopupMenu;
    FMenu: TMenu;
    FFormulario: string;
    procedure CriarItensMenu;
    procedure CriarPopupMenu(AImage: TImage);
    procedure CarregarImagem(AImage: TImage);
  public
    class function New(AImage: TImage; AMenu: TMenu; AFormulario: string): TUtilsConfMenu;
    constructor Create(AImage: TImage; AMenu: TMenu; AFormulario: string);
    destructor Destroy; override;

    procedure ConfigurarMenuClick(Sender: TObject);
    procedure imgConfMenuClick(Sender: TObject);
  end;

implementation

uses
  MyExceptions,
  Model.Sistema.Imagens.DM,
  Utils.MyVclLibrary,
  View.Sistema.MenuConf;

class function TUtilsConfMenu.New(AImage: TImage; AMenu: TMenu; AFormulario: string): TUtilsConfMenu;
begin
   if(AImage = nil)then
     raise ExceptionWarning.Create('Imagem de configuração de menu não informada');

   if(AMenu = nil)then
     raise ExceptionWarning.Create('Menu para configuração não informada');

   if(AFormulario.IsEmpty)then
     raise ExceptionWarning.Create('Nome do formulário para configuração do menu não informado');

   Result := Self.Create(AImage, AMenu, AFormulario);
end;

constructor TUtilsConfMenu.Create(AImage: TImage; AMenu: TMenu; AFormulario: string);
begin
   CarregarConfiguracoesMenu(AMenu, AFormulario);

   FMenu       := AMenu;
   FFormulario := AFormulario;

   Self.CriarPopupMenu(AImage);
   Self.CriarItensMenu;
   Self.CarregarImagem(AImage);
   AImage.OnClick   := imgConfMenuClick;
   AImage.PopupMenu := FPopupMenu;
end;

destructor TUtilsConfMenu.Destroy;
begin
   if(Assigned(FPopupMenu))then
     FPopupMenu.Free;
   inherited;
end;

procedure TUtilsConfMenu.CarregarImagem(AImage: TImage);
var
  LPngImage: TPngImage;
begin
   LPngImage := TPngImage.Create;
   try
     LPngImage.LoadFromResourceName(HInstance, 'confmenu');
     AImage.Picture.Assign(LPngImage);
     AImage.Center       := True;
     AImage.Proportional := True;
   finally
     LPngImage.Free;
   end;
end;

procedure TUtilsConfMenu.imgConfMenuClick(Sender: TObject);
begin
   TMyVclLibrary.PopUpMenuSelfActive(TImage(Sender));
end;

procedure TUtilsConfMenu.CriarPopupMenu(AImage: TImage);
begin
   FPopupMenu        := TPopupMenu.Create(AImage);
   FPopupMenu.Name   := 'pMenuConfMenus';
end;

procedure TUtilsConfMenu.CriarItensMenu;
var
  LItem: TMenuItem;
begin
   LItem := TMenuItem.Create(FPopupMenu);
   LItem.Caption    := 'Configurar itens do menu';
   LItem.OnClick    := ConfigurarMenuClick;
   FPopupMenu.Items.Add(LItem);
end;

procedure TUtilsConfMenu.ConfigurarMenuClick(Sender: TObject);
begin
   ConfigurarMenu(FMenu, FFormulario);
end;

end.
