unit Utils.Versao;

interface

uses
  System.SysUtils;

type
  TUtilsVersao = class
  public
    const
    C_VERSION_MAJOR = 1;
    C_VERSION_MINOR = 0;
    C_VERSION_PATCH = 0;
    C_VERSION_PRE_RELEASE = ''; //'-alpha.0';
    class function Version: String;
    class function CompleteVersion: String;
   end;

implementation

class function TUtilsVersao.CompleteVersion: String;
begin
   Result := ' - Versão: ' + Self.Version;
end;

class function TUtilsVersao.Version: String;
begin
   Result := C_VERSION_MAJOR.toString + '.' + C_VERSION_MINOR.toString + '.' + C_VERSION_PATCH.toString + C_VERSION_PRE_RELEASE ;
end;

end.
