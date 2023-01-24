unit Model.Sistema.Main;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Threading,
  Vcl.Forms,
  Model.Sistema.Interfaces;

type
  TModelSistemaMain = class(TInterfacedObject, IModelSistemaMain)
  private
    class var FInstance: IModelSistemaMain;

    FDoCriarIconesAtalhos: TProc;
    FDoFormResize: TProc;
    FDoLoggin: TProc;
    FDoProcessImageLogo: TProc<string>;
    FDoProcessStatus: TProc;

    constructor create;

    procedure DoLoggin;
    procedure ProcessStatus;
    procedure ProcessImageLogo;
    procedure CriarIconesAtalhos;
  protected
    function OnCriarIconesAtalhos(ACriarIconesAtalhos: TProc): IModelSistemaMain;
    function OnFormResize(AFormResize: TProc): IModelSistemaMain;
    function OnLoggin(ALoggin: TProc): IModelSistemaMain;
    function OnProcessImageLogo(AProcessImageLogo: TProc<string>): IModelSistemaMain;
    function OnProcessStatus(AProcessStatus: TProc): IModelSistemaMain;
    function ConfiguraFormulario: IModelSistemaMain;
    function FormResize: IModelSistemaMain;
    function FormShow: IModelSistemaMain;
  public
    class function GetInstance: IModelSistemaMain;
  end;

implementation

uses
  Utils.GlobalVariables;

{$REGION 'ClassEvents'}
class function TModelSistemaMain.GetInstance: IModelSistemaMain;
begin
   if(not Assigned(FInstance))then
     FInstance := TModelSistemaMain.Create;

   Result := FInstance;
end;

constructor TModelSistemaMain.create;
begin
   //
end;

function TModelSistemaMain.OnCriarIconesAtalhos(ACriarIconesAtalhos: TProc): IModelSistemaMain;
begin
   Result := Self;
   FDoCriarIconesAtalhos := ACriarIconesAtalhos;
end;

function TModelSistemaMain.OnFormResize(AFormResize: TProc): IModelSistemaMain;
begin
   Result := Self;
   FDoFormResize := AFormResize;
end;

function TModelSistemaMain.OnLoggin(ALoggin: TProc): IModelSistemaMain;
begin
   Result := Self;
   FDoLoggin := ALoggin;
end;

function TModelSistemaMain.OnProcessImageLogo(AProcessImageLogo: TProc<string>): IModelSistemaMain;
begin
   Result := Self;
   FDoProcessImageLogo := AProcessImageLogo;
end;

function TModelSistemaMain.OnProcessStatus(AProcessStatus: TProc): IModelSistemaMain;
begin
   Result := Self;
   FDoProcessStatus := AProcessStatus;
end;
{$ENDREGION 'ClassEvents'}

{$REGION 'FormEvents'}
function TModelSistemaMain.FormResize: IModelSistemaMain;
begin
   Result := Self;

   if(Assigned(FDoFormResize))then
     FDoFormResize();
end;

function TModelSistemaMain.FormShow: IModelSistemaMain;
begin
   Result := Self;
   Self.DoLoggin;
   Self.ConfiguraFormulario;
end;
{$ENDREGION 'FormEvents'}

{$REGION 'Procedures'}
procedure TModelSistemaMain.DoLoggin;
begin
   if(Assigned(FDoLoggin))then
     FDoLoggin();
end;

function TModelSistemaMain.ConfiguraFormulario: IModelSistemaMain;
var
 LTask: ITask;
begin
   Result := Self;
   LTask := TTask.Create(
     procedure
     begin
        TThread.Synchronize(nil,
          procedure
          begin
             Sleep(50);
             Self.ProcessStatus;
             Self.ProcessImageLogo;
             Self.CriarIconesAtalhos;
          end);
     end
    );
   LTask.Start;
end;

procedure TModelSistemaMain.ProcessStatus;
begin
   if(Assigned(FDoProcessStatus))then
     FDoProcessStatus();
end;

procedure TModelSistemaMain.ProcessImageLogo;
begin
   if(Assigned(FDoProcessImageLogo))then
     FDoProcessImageLogo(VG_Logo);
end;

procedure TModelSistemaMain.CriarIconesAtalhos;
begin
   if(Assigned(FDoCriarIconesAtalhos))then
     FDoCriarIconesAtalhos();
end;
{$ENDREGION 'Procedures'}

end.
