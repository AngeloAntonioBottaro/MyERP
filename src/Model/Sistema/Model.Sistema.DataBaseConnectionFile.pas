unit Model.Sistema.DataBaseConnectionFile;

interface

uses
  System.SysUtils,
  System.Classes,
  Utils.MyLibrary,
  Utils.Myconsts,
  Utils.MyIniLibrary;

const
  INI_NAME            = 'Config.ini';
  IDENTIFIER_HOST     = 'HOST';
  DEFAULT_HOST        = 'Localhost';
  IDENTIFIER_DATABASE = 'DATABASE';
  DEFAULT_DATABASE    = 'DATABASE.FDB';
  IDENTIFIER_PASSWORD = 'PASSWORD';
  CURRENT_PASSWORD    = 'masterkey';
  IDENTIFIER_PORT     = 'PORT';
  DEFAULT_PORT        = '3050';

type
  TModelSistemaDataBaseConnectionFile = class
  private
    FIniFile: IMyIniLibrary;
    FMensage: string;
    FHost: string;
    FDatabase: string;
    FPassword: string;
    FPort: STRING;
    function INIPath: string;
    procedure GetConfigurationFile;
    procedure CreateNewConfigurationFile;
    procedure LoadConfigurationFile;

    function Default_Password: string;
    function IniFilePathName: string;
    function GetSelectedSection: string;
  public
    constructor Create;
    property Mensage: string read FMensage write FMensage;
    property Host: string read FHost write FHost;
    property Database: string read FDatabase write FDatabase;
    property Password: string read FPassword write FPassword;
    property Port: STRING read FPort write FPort;
  end;

implementation

uses
  MyExceptions,
  Utils.MyVCLLibrary;

constructor TModelSistemaDataBaseConnectionFile.Create;
begin
   FMensage := EmptyStr;
   Self.GetConfigurationFile;
end;

function TModelSistemaDataBaseConnectionFile.INIPath: string;
begin
   Result := TMyVclLibrary.GetAppPath;
end;

function TModelSistemaDataBaseConnectionFile.IniFilePathName: string;
begin
   Result := IncludeTrailingPathDelimiter(Self.INIPath) + INI_NAME;
end;

function TModelSistemaDataBaseConnectionFile.Default_Password: string;
begin
   Result := TMyLibrary.Encrypt(CURRENT_PASSWORD);
end;

procedure TModelSistemaDataBaseConnectionFile.GetConfigurationFile;
begin
   if(not FileExists(Self.IniFilePathName))then
     Self.CreateNewConfigurationFile;

   Self.LoadConfigurationFile;
end;

function TModelSistemaDataBaseConnectionFile.GetSelectedSection: string;
var
  LSections: TStrings;
begin
   Result := EmptyStr;
   LSections := TStringList.Create;
   try
     try
       FIniFile.ReadSections(LSections);
       Result := LSections[0];
     except on E: Exception do
     begin
        FMensage := E.Message;
        Exit;
     end;
     end;
   finally
     LSections.Free;
   end;
end;

procedure TModelSistemaDataBaseConnectionFile.CreateNewConfigurationFile;
begin
   MyIniLibrary
    .Path(Self.INIPath)
    .Name(INI_NAME)
    .Identifier(IDENTIFIER_HOST).WriteIniFile(DEFAULT_HOST)
    .Identifier(IDENTIFIER_DATABASE).WriteIniFile(DEFAULT_DATABASE)
    .Identifier(IDENTIFIER_PASSWORD).WriteIniFile(Default_Password)
    .Identifier(IDENTIFIER_PORT).WriteIniFile(DEFAULT_PORT);
end;

procedure TModelSistemaDataBaseConnectionFile.LoadConfigurationFile;
var
  LSection: string;
begin
   FIniFile := TMyIniLibrary.New;
   FIniFile
    .Path(Self.INIPath)
    .Name(INI_NAME);

   LSection  := Self.GetSelectedSection;

   if(LSection.IsEmpty)then
     raise ExceptionInformation.Create('Não foi possível acessar as informações da configuração selecionada', FMensage);

   FIniFile.Section(LSection);

   FHost     := FIniFile.Identifier(IDENTIFIER_HOST).ReadIniFileStr(DEFAULT_HOST);
   FDatabase := Self.INIPath + FOULDER_DATABASE + FIniFile.Identifier(IDENTIFIER_DATABASE).ReadIniFileStr(DEFAULT_DATABASE);
   FPassword := FIniFile.Identifier(IDENTIFIER_PASSWORD).ReadIniFileStr(Default_Password);
   FPassword := TMyLibrary.Decrypt(FPassword);
   FPort     := FIniFile.Identifier(IDENTIFIER_PORT).ReadIniFileStr(DEFAULT_PORT);
end;

end.
