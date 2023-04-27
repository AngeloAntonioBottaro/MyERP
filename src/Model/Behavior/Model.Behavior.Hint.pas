unit Model.Behavior.Hint;

interface

uses
  Vcl.Forms;

type
  TModelBehaviorHint = class
  public
    class procedure Configurar;
  end;

implementation

class procedure TModelBehaviorHint.Configurar;
begin
   Application.HintPause      := 10;
   Application.HintShortPause := 5;
end;

end.
