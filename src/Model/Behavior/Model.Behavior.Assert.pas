unit Model.Behavior.Assert;

interface

uses
  System.SysUtils;

type
  TModelBehaviorAssert = class
  public
    class procedure Configurar;
  end;

implementation

uses
  C4D.LogFile,
  C4D.Assert;

procedure AssertLogProcHandlerC4D(const Message, Filename: string; LineNumber: Integer);
begin
   C4DLogFile.AddLog('#C4DAssert: ' + ExtractFileName(Filename) + ' (linha ' + LineNumber.ToString + ') - ' + Message.Trim);
end;

class procedure TModelBehaviorAssert.Configurar;
begin
   C4DAssert.SetAssertLogProcC4D(AssertLogProcHandlerC4D);
   C4DAssert.TratarAssertON;
end;

end.

