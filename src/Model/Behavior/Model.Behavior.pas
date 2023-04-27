unit Model.Behavior;

interface

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
  Model.Behavior.Exceptions,
  Model.Behavior.ReportMemoryLeaks,
  Model.Behavior.Hint,
  Model.Behavior.DateFormat;

constructor TModelBehavior.Create;
begin
   TModelBehaviorExceptions.Configurar;
   TModelBehaviorReportMemoryLeaks.Configurar;
   TModelBehaviorHint.Configurar;
   TModelBehaviorDateFormat.Configurar;
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

