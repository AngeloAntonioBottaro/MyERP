unit Model.Main.Icones.Criacoes;

interface

uses
  Vcl.Forms,
  Model.Main.Icones.Interfaces,
  Model.Main.Icones.Componentes.PanelAtalhos;

type
  TModelMainIconesCriacoes = class(TInterfacedObject, IModelMainIconesComponentes)
  private
    FFormulario: TForm;
    function Formulario: TForm; overload;
  protected
    function Formulario(AFormulario: TForm): IModelMainIconesComponentes; overload;
    procedure CriarPanelIcones;
  public
    class function New: IModelMainIconesComponentes;
  end;

implementation

uses
  MyExceptions;

class function TModelMainIconesCriacoes.New: IModelMainIconesComponentes;
begin
   Result := Self.Create;
end;

function TModelMainIconesCriacoes.Formulario(AFormulario: TForm): IModelMainIconesComponentes;
begin
   Result      := Self;
   FFormulario := AFormulario;
end;

function TModelMainIconesCriacoes.Formulario: TForm;
begin
   if(not Assigned(FFormulario))then
     raise ExceptionInformation.Create('Formulário não informado');

   Result := FFormulario;
end;

procedure TModelMainIconesCriacoes.CriarPanelIcones;
begin
   TModelMainIconesComponentesPanelAtalhos.New(Formulario).CriarComponente;
end;

end.
