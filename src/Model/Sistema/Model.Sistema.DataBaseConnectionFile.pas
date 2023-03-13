unit Model.Sistema.DataBaseConnectionFile;

interface

uses
  System.SysUtils,
  System.Classes,
  Utils.MyLibrary,
  Utils.MyIniLibrary;

const
  IDENTIFIER_HOST     = 'HOST';
  DEFAULT_HOST        = 'Localhost';
  IDENTIFIER_DATABASE = 'DATABASE';
  DEFAULT_DATABASE    = 'DATABASE.FDB';
  IDENTIFIER_PASSWORD = 'PASSWORD';
  CURRENT_PASSWORD    = 'masterkey';

type
  TModelSistemaDataBaseConnectionFile = class
  private
    FIniFile: IMyIniLibrary;
    FMensage: string;
    FHost: string;
    FDatabase: string;
    FPassword: string;
    function INIPath: string;
    function ININame: string;
    procedure GetConfigurationFile;
    procedure CreateNewConfigurationFile;
    procedure LoadConfigurationFile;

    function Default_Password: string;
    function IniFilePathName: string;
  public
    constructor Create;
    property Mensage: string read FMensage write FMensage;
    property Host: string read FHost write FHost;
    property Database: string read FDatabase write FDatabase;
    property Password: string read FPassword write FPassword;
  end;

implementation

uses
  Utils.MyVCLLibrary;

constructor TModelSistemaDataBaseConnectionFile.Create;
begin
   FMensage := EmptyStr;
   Self.GetConfigurationFile;
end;

function TModelSistemaDataBaseConnectionFile.ININame: string;
begin
   Result := TMyVclLibrary.GetAppName;
end;

function TModelSistemaDataBaseConnectionFile.INIPath: string;
begin
   Result := TMyVclLibrary.GetAppPath;
end;

function TModelSistemaDataBaseConnectionFile.IniFilePathName: string;
begin
   Result := IncludeTrailingPathDelimiter(Self.INIPath) + Self.ININame + '.ini';
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

procedure TModelSistemaDataBaseConnectionFile.CreateNewConfigurationFile;
begin
   MyIniLibrary
    .Path(Self.INIPath)
    .Name(Self.ININame)
    .Section(TMyLibrary.CreateGuidStr)
    .Identifier(IDENTIFIER_HOST).WriteIniFile(DEFAULT_HOST)
    .Identifier(IDENTIFIER_DATABASE).WriteIniFile(DEFAULT_DATABASE)
    .Identifier(IDENTIFIER_PASSWORD).WriteIniFile(Default_Password)
end;

procedure TModelSistemaDataBaseConnectionFile.LoadConfigurationFile;
var
  LSections: TStrings;
  LSection: string;
begin
   FIniFile := TMyIniLibrary.New;
   FIniFile
    .Path(Self.INIPath)
    .Name(Self.ININame);

   LSection  := '';
   LSections := TStringList.Create;
   try
     try
       FIniFile.ReadSections(LSections);
       LSection := LSections[0];
     except on E: Exception do
     begin
        FMensage := E.Message;
        Exit;
     end;
     end;
   finally
     LSections.Free;
   end;

   if(not FMensage.IsEmpty)then
     Exit;

   FIniFile.Section(LSection);

   FHost     := FIniFile.Identifier(IDENTIFIER_HOST).ReadIniFileStr(DEFAULT_HOST);
   FDatabase := FIniFile.Identifier(IDENTIFIER_DATABASE).ReadIniFileStr(DEFAULT_DATABASE);
   FPassword := FIniFile.Identifier(IDENTIFIER_PASSWORD).ReadIniFileStr(Default_Password);
   FPassword := TMyLibrary.Decrypt(FPassword);
end;

end.
