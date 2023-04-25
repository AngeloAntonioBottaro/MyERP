unit Model.Behavior;

interface

uses
  System.SysUtils,
  Vcl.Forms;

type
 TModelBehavior = class
  private
  public
    constructor Create;
    destructor Destroy; override;
 end;

var
  ModelBehaviors: TModelBehavior;

implementation

uses
  Model.Behavior.Exceptions;

constructor TModelBehavior.Create;
begin
   ReportMemoryLeaksOnShutdown    := True; //FileExists('C:\Temp\adm.lock');
   Application.HintPause          := 10;
   Application.HintShortPause     := 5;
   FormatSettings.ShortDateFormat := 'dd/mm/yyyy';
   TModelBehaviorExceptions.Configurar;
end;

destructor TModelBehavior.Destroy;
begin
   inherited;
end;

initialization
  ModelBehaviors := TModelBehavior.Create;

finalization
  ModelBehaviors.DisposeOf;

end.

