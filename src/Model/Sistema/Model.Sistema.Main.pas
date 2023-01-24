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
    FFormulario: TForm;
    procedure DoLoggin;
    procedure ConfiguraFormulario;
    procedure ProcessStatus;
    procedure ProcessImageLogo;
    procedure CriarIconesAtalhos;
  protected
    function FormShow: IModelSistemaMain;
  public
    class function New: IModelSistemaMain;
  end;

implementation

uses
  View.Login;

class function TModelSistemaMain.New(AFormulario: TForm): IModelSistemaMain;
begin
   Result := Self.Create;
end;

{$REGION 'FormEvents'}
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
   if(ViewLogin = nil)then Application.CreateForm(TViewLogin, ViewLogin);
   try
     ViewLogin.ShowModal;
   finally
     FreeAndNil(ViewLogin);
   end;
end;

procedure TModelSistemaMain.ConfiguraFormulario;
var
 LTask: ITask;
begin
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

end;

procedure TModelSistemaMain.ProcessImageLogo;
begin

end;

procedure TModelSistemaMain.CriarIconesAtalhos;
begin

end;
{$ENDREGION 'Procedures'}

end.
