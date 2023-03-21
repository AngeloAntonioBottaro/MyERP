unit Utils.GlobalVariables;

interface

uses
  System.SysUtils,
  System.StrUtils,
  System.UITypes,
  Utils.MyConsts,
  Utils.MyLibrary,
  Utils.MyVCLLibrary;

var
  //PASTAS
  VG_PastaPadrao: string;
  VG_PastaArquivos: string;
  VG_PastaBackups: string;
  VG_PastaImagens: string;
  VG_PastaRelatorios: string;
  VG_PastaTemporaria: string;
  VG_PastaBancoDados: string;
  VG_PastaAppData: string;

  //DEV
  VG_DEBUG: Boolean;

  //SISTEMA
  VG_DataHoraAberturaSistema: TDateTime;
  VG_Host: string;
  VG_Database: string;
  VG_Direitos: string;
  VG_Logo: string;
  VG_Impressora: string;
  VG_IdEmpresaLog: Integer;

  //USUARIO
  VG_UsuarioLogadoId: Integer;
  VG_UsuarioLogadoNome: string;

procedure RefreshVariables;
procedure CreateAppDirectories;

implementation

procedure RefreshVariables;
begin
   //DEV
   VG_DEBUG := False;

   //PASTAS
   VG_PastaPadrao     := TMyVclLibrary.GetAppPath + 'ERP\';
   VG_PastaArquivos   := VG_PastaPadrao + FOLDER_ARQUIVO;
   VG_PastaBackups    := VG_PastaPadrao + FOLDER_BACKUP;
   VG_PastaImagens    := VG_PastaArquivos + FOLDER_IMAGEM;
   VG_PastaRelatorios := VG_PastaPadrao + FOLDER_RELATORIO;
   VG_PastaBancoDados := VG_PastaPadrao + FOLDER_DATABASE;
   VG_PastaTemporaria := FOLDER_TEMP;
   VG_PastaAppData    := TMyLibrary.GetPathAppDataLocal;

   //SISTEMA
   VG_Direitos     := DIREITOS_SISTEMA;
   VG_Logo         := IncludeTrailingPathDelimiter(VG_PastaImagens) + IMAGE_LOGO;
   VG_Impressora   := EmptyStr;
   VG_IdEmpresaLog := 0;

   //USUARIO
   VG_UsuarioLogadoId   := 0;
   VG_UsuarioLogadoNome := EmptyStr;
end;

procedure CreateAppDirectories;
begin
   if(not DirectoryExists(VG_PastaPadrao))then
     ForceDirectories(VG_PastaPadrao);

   if(not DirectoryExists(VG_PastaArquivos))then
     ForceDirectories(VG_PastaArquivos);

   if(not DirectoryExists(VG_PastaBackups))then
     ForceDirectories(VG_PastaBackups);

   if(not DirectoryExists(VG_PastaImagens))then
     ForceDirectories(VG_PastaImagens);

   if(not DirectoryExists(VG_PastaRelatorios))then
     ForceDirectories(VG_PastaRelatorios);

   if(not DirectoryExists(VG_PastaBancoDados))then
     ForceDirectories(VG_PastaBancoDados);

   if(not DirectoryExists(VG_PastaTemporaria))then
     ForceDirectories(VG_PastaTemporaria);
end;

end.
