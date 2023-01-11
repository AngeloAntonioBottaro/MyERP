unit Model.Behavior.LogFile;

interface

type
  TModelBehaviorLogFile = class
  public
    class procedure Configurar;
  end;

implementation

uses
  C4D.LogFile;

class procedure TModelBehaviorLogFile.Configurar;
begin
   C4DLogFile.SetDir('C:\MDKSoft\Sistema\Logs\');
end;

end.
