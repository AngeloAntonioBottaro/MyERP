unit Model.Sistema.Imagens.DM;

interface

uses
  System.SysUtils, System.Classes, System.ImageList, Vcl.ImgList, Vcl.Controls;

type
  TModelSistemaImagensDM = class(TDataModule)
    imgListMenus: TImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ModelSistemaImagensDM: TModelSistemaImagensDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
