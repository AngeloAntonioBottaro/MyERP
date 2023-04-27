unit Model.Behavior.ReportMemoryLeaks;

interface

type
  TModelBehaviorReportMemoryLeaks = class
  public
    class procedure Configurar;
  end;

implementation

class procedure TModelBehaviorReportMemoryLeaks.Configurar;
begin
   ReportMemoryLeaksOnShutdown := True; //FileExists('C:\Temp\adm.lock');
end;

end.
