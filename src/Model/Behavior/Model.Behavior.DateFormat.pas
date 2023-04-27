unit Model.Behavior.DateFormat;

interface

uses
  System.SysUtils;

type
  TModelBehaviorDateFormat = class
  public
    class procedure Configurar;
  end;

implementation

class procedure TModelBehaviorDateFormat.Configurar;
begin
   FormatSettings.ShortDateFormat := 'dd/mm/yyyy';
end;

end.
