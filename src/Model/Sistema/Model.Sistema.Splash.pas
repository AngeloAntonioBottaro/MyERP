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
    class var FInstance: IModelSistemaSplash;

    FDisplayInformation: TProc<string>;
    FLoadingComplete: Boolean;

    constructor Create;

    procedure WriteInformation(AValue: String);
    procedure CriarPastasSistema;
    procedure ConnectToDatabase;
    procedure CriarDataModules;

    procedure CriarDM(InstanceClass: TComponentClass; var Reference; AMensagem: string);
  protected
    function DisplayInformation(AValue: TProc<string>): IModelSistemaSplash;
    function LoadingComplete: Boolean;
    function StartApplication: IModelSistemaSplash;
  public
    class function GetInstance: IModelSistemaSplash;
  end;

implementation

uses
  MyMessage,
  MyExceptions,
  MyConnection,
  MyConnectionConfiguration,
  Utils.GlobalVariables,
  Model.Sistema.Imagens.DM;

class function TModelSistemaSplash.GetInstance: IModelSistemaSplash;
begin
   if(not Assigned(FInstance))then
     FInstance := TModelSistemaSplash.Create;

   Result := FInstance;
end;

constructor TModelSistemaSplash.Create;
begin
   FLoadingComplete           := False;
   VG_DataHoraAberturaSistema := Now;
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
     Self.ConnectToDatabase;
     Self.CriarDataModules;

     FLoadingComplete := True;
   except on E: Exception do
     ShowError('Falha ao iniciar o sistema', E.Message);
   end;
end;

procedure TModelSistemaSplash.CriarPastasSistema;
begin
   Self.WriteInformation('Criando pastas do sistema');
   CreateAppDirectories;
end;

procedure TModelSistemaSplash.ConnectToDatabase;
var
  LMCC: TMyConnectionConfiguration;
begin
   Self.WriteInformation('Acessando arquivo de configurações de conexão');
   LMCC := TMyConnectionConfiguration.Create;
   try
     if(LMCC.LoadConfiguration.Cancel)then
     begin
        Application.Terminate;
        Abort;
     end;

     Self.WriteInformation('Realizando conexão com o banco de dados');

     VG_Host     := LMCC.Host;
     VG_Database := LMCC.Database;

     MyConn
      .Configuration
       .ClearConfiguration
       .Host(VG_Host)
       .UserName(LMCC.Username)
       .Database(VG_Database)
       .Password(LMCC.Password)
       .Port(LMCC.Port)
       .DriverFirebird
       .ComponentTypeFireDac
       .ConnectionSingletonOn;
   finally
     LMCC.Free;
   end;

   MyConn.Connection.TestConnection;
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
   Sleep(1000);
   if(Assigned(FDisplayInformation))then
     FDisplayInformation(Trim(AValue));
end;

end.
