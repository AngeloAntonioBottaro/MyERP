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
    procedure AtualizarVisibilidades(AListaVisibilidadeManual: IModelMainIconesListaVisibilidadeManual);
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

procedure TModelMainIconesLista.AtualizarVisibilidades(AListaVisibilidadeManual: IModelMainIconesListaVisibilidadeManual);
var
 LIndex: TMainIconName;
 LConfigurationName: string;
 LVisible: Boolean;
begin
   for LIndex in FListaPairsIconesFields.ToSortKeys do
   begin
      LConfigurationName := FListaPairsIconesFields.Items[LIndex].ComponentName;
      LVisible := True;

      if(LVisible)then
      begin
         if(AListaVisibilidadeManual.Lista.ContainsKey(LConfigurationName))then
           AListaVisibilidadeManual.Lista.TryGetValue(LConfigurationName, LVisible);
      end;

      FListaPairsIconesFields.Items[LIndex].Visible(LVisible);
   end;
end;

end.
