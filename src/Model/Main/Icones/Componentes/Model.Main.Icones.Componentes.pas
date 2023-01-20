unit Model.Main.Icones.Componentes;

interface

uses
  Vcl.Forms,
  Model.Main.Icones.Interfaces,
  Model.Main.Icones.Componentes.PanelAtalhos;

type
  TModelMainIconesComponentes = class(TInterfacedObject, IModelMainIconesComponentes)
  private
    FFormulario: TForm;
    function Formulario: TForm; overload;
  protected
    function Formulario(AFormulario: TForm): IModelMainIconesComponentes; overload;
    procedure CriarPanelIcones;
    procedure CriarCheckBoxIcones;
  public
    class function New: IModelMainIconesComponentes;
  end;

implementation

uses
  MyExceptions;

class function TModelMainIconesComponentes.New: IModelMainIconesComponentes;
begin
   Result := Self.Create;
end;

function TModelMainIconesComponentes.Formulario(AFormulario: TForm): IModelMainIconesComponentes;
begin
   Result := Self;
   FFormulario := AFormulario;
end;

function TModelMainIconesComponentes.Formulario: TForm;
begin
   if(not Assigned(FFormulario))then
     raise ExceptionMsg.Create('Formulário não informado');

   Result := FFormulario;
end;

procedure TModelMainIconesComponentes.CriarPanelIcones;
begin
   TModelMainIconesComponentesPanelAtalhos.New(Formulario).CriarComponente;
end;

procedure TModelMainIconesComponentes.CriarCheckBoxIcones;
begin

end;

end.
