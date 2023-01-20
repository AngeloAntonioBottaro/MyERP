unit Model.Main.Icones.Lista;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  Data.DB,
  Model.Main.Icones.Fields,
  Model.Main.Icones.Types,
  Model.Main.Icones.Interfaces;

type
  TModelMainIconesLista = class(TInterfacedObject, IModelMainIconesList)
  private
    FListaPairsIconesFields: TPairMainIconesFields;
  public
    function Lista: TPairMainIconesFields;
    procedure AtualizaVisibilidades;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  MyExceptions;

constructor TModelMainIconesLista.Create;
begin
   FListaPairsIconesFields := TPairMainIconesFields.Create([doOwnsValues]);
end;

destructor TModelMainIconesLista.Destroy;
begin
   FListaPairsIconesFields.Free;
   inherited;
end;

function TModelMainIconesLista.Lista: TPairMainIconesFields;
begin
   Result := FListaPairsIconesFields;
end;

procedure TModelMainIconesLista.AtualizaVisibilidades;
var
 LIndex: TMainIconName;
begin
   for LIndex in FListaPairsIconesFields.ToSortKeys do
   begin
      FListaPairsIconesFields.Items[LIndex].Visible(False);
      //if(ModelSistemaDm.TB_conf_icones.Locate('icone', FListaPairsIconesFields.Items[LIndex].ComponentName, [loCaseInsensitive]))then
        FListaPairsIconesFields.Items[LIndex].Visible(True);
   end;
end;

end.
