unit Model.Sistema.Imagens.DM;

interface

uses
  System.SysUtils,
  System.Classes,
  System.ImageList,
  Vcl.ImgList,
  Vcl.Controls;

type
  TModelSistemaImagensDM = class(TDataModule)
    imgListMainMenus: TImageList;
    imgListButtonsProperties: TImageList;
    imgListPopupMenuConfGrid: TImageList;
    imgPopupMenuMain: TImageList;
    imgListButtons: TImageList;
    imgPopupMenuBusca: TImageList;
    imgListPopupMenuConfMenu: TImageList;
  private
  public
  end;

var
  ModelSistemaImagensDM: TModelSistemaImagensDM;

implementation

{$R *.dfm}

end.
