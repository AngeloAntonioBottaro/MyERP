unit Model.Main.Icones.Lista;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
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
  C4D.Exceptions,
  Data.DB,
  Utils.Solusys,
  Common.Utils.Variaveis,
  Model.Sistema.DM;

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
   if(not cons_TB_conf_icones('where(id_funcionario = "' + V_IdFuncLog + '" or id_funcionario = "0") ' + 'and(id_empresa = "' + V_IdEmpresaLog + '") '))then
     raise ExceptionOb.Create('N�o foi poss�vel consultar os icones');

   for LIndex in FListaPairsIconesFields.ToSortKeys do
   begin
      FListaPairsIconesFields.Items[LIndex].Visible(False);
      if(ModelSistemaDm.TB_conf_icones.Locate('icone', FListaPairsIconesFields.Items[LIndex].ComponentName, [loCaseInsensitive]))then
        FListaPairsIconesFields.Items[LIndex].Visible(True);
   end;
end;

end.