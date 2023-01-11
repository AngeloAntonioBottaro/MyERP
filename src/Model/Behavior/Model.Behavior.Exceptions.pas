unit Model.Behavior.Exceptions;

interface

uses
  Vcl.Forms;

type
  TModelBehaviorExceptions = class
  public
    class procedure Configurar;
  end;

implementation

uses
  MyExceptions;

class procedure TModelBehaviorExceptions.Configurar;
begin
   Application.OnException := TMyExceptions.OnException;
end;

end.
