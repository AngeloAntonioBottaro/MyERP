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
  Utils.GlobalVariables,
  Model.Sistema.DatabaseConnectionFile,
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
  FDBCon: TModelSistemaDataBaseConnectionFile;
begin
   Self.WriteInformation('Acessando arquivo de configurações de conexão');
   FDBCon := TModelSistemaDataBaseConnectionFile.Create;
   try
     if(not FDBCon.Mensage.IsEmpty)then
       raise Exception.Create('Leitura do arquivo de configurações não realizada: ' + FDBCon.Mensage);

     Self.WriteInformation('Realizando conexão com o banco de dados');

     VG_Host     := FDBCon.Host;
     VG_Database := FDBCon.Database;

     MyConn
      .Configuration
       .ClearConfiguration
       .DriverID('FB')
       .Host(VG_Host)
       .UserName('sysdba')
       .Database(VG_Database)
       .Password(FDBCon.Password)
       .Port(FDBCon.Port)
       .ComponentTypeFireDac
       .ConnectionSingletonOn;

      MyConn.Connection.TestConnection;
   finally
     FDBCon.Free;
   end;
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
