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
    imgListMenus: TImageList;
    imgListButtons: TImageList;
    imgListMenusSmall: TImageList;
  private
  public
  end;

var
  ModelSistemaImagensDM: TModelSistemaImagensDM;

implementation

{$R *.dfm}

end.
