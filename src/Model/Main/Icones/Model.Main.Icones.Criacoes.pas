unit Model.Main.Icones.Criacoes;

interface

uses
  Vcl.Forms,
  Model.Main.Icones.Interfaces,
  Model.Main.Icones.Componentes.PanelAtalhos;

type
  TModelMainIconesCriacoes = class(TInterfacedObject, IModelMainIconesCriacoes)
  private
    FFormulario: TForm;
    function Formulario: TForm; overload;
  protected
    function Formulario(AFormulario: TForm): IModelMainIconesCriacoes; overload;
    procedure CriarPanelIcones;
    procedure CriarCheckBoxIcones;
  public
    class function New: IModelMainIconesCriacoes;
  end;

implementation

uses
  C4D.Exceptions;

class function TModelMainIconesCriacoes.New: IModelMainIconesCriacoes;
begin
   Result := Self.Create;
end;

function TModelMainIconesCriacoes.Formulario(AFormulario: TForm): IModelMainIconesCriacoes;
begin
   Result := Self;
   FFormulario := AFormulario;
end;

function TModelMainIconesCriacoes.Formulario: TForm;
begin
   if(not Assigned(FFormulario))then
     raise ExceptionOb.Create('Formulário não informado');

   Result := FFormulario;
end;

procedure TModelMainIconesCriacoes.CriarPanelIcones;
begin
   TModelMainIconesComponentesPanelAtalhos.New(Formulario).CriarComponente;
end;

procedure TModelMainIconesCriacoes.CriarCheckBoxIcones;
begin

end;

end.
