unit Model.Sistema.Splash;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Model.Sistema.Interfaces;

type
  TModelSistemaSplash = class(TInterfacedObject, IModelSistemaSplash)
  private
    FDisplayInformation: TProc<string>;
    FLoadingComplete: Boolean;

    procedure WriteInformation(AValue: String);
    procedure CriarPastasSistema;
    procedure CriarDataModules;

    procedure CriarDM(InstanceClass: TComponentClass; var Reference; AMensagem: string);
  protected
    function DisplayInformation(AValue: TProc<string>): IModelSistemaSplash;
    function LoadingComplete: Boolean;
    function StartApplication: IModelSistemaSplash;
  public
    class function New: IModelSistemaSplash;
    constructor Create;
  end;

implementation

uses
  MyMessage,
  Utils.GlobalVariables,
  Model.Sistema.Imagens.DM;

class function TModelSistemaSplash.New: IModelSistemaSplash;
begin
   Result := Self.Create;
end;

constructor TModelSistemaSplash.Create;
begin
   FLoadingComplete := False;
end;

function TModelSistemaSplash.DisplayInformation(AValue: TProc<string>): IModelSistemaSplash;
begin
   Result              := Self;
   FDisplayInformation := AValue;
end;

function TModelSistemaSplash.LoadingComplete: Boolean;
begin
   Result := FLoadingComplete;
end;

function TModelSistemaSplash.StartApplication: IModelSistemaSplash;
begin
   Result := Self;

   try
     Self.CriarPastasSistema;

     Self.CriarDataModules;

     FLoadingComplete := True;
   except on E: Exception do
     TMyMessage.New.Mensagem('Falha ao iniciar o sistema').MensagemCompleta(E.Message).MsgErro;
   end;
end;

procedure TModelSistemaSplash.CriarPastasSistema;
begin
   Self.WriteInformation('Criando pastas do sistema');
   CreateAppDirectories;
end;

procedure TModelSistemaSplash.CriarDataModules;
begin
   Self.CriarDM(TModelSistemaImagensDM, ModelSistemaImagensDM, 'Criando o modulo de imagens');
end;

procedure TModelSistemaSplash.CriarDM(InstanceClass: TComponentClass; var Reference; AMensagem: string);
begin
   Self.WriteInformation(AMensagem);
   Application.CreateForm(InstanceClass, Reference);
end;

procedure TModelSistemaSplash.WriteInformation(AValue: String);
begin
   if(Assigned(FDisplayInformation))then
     FDisplayInformation(Trim(AValue));
end;

end.