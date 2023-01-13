unit Utils.GlobalVariables;

interface

uses
  System.StrUtils,
  System.SysUtils,
  Utils.MyLibrary,
  Utils.GlobalConstants;

var
  //PASTAS
  VG_PastaPadrao: string;
  VG_PastaRelatorios: string;
  VG_PastaImagens: string;
  VG_PastaArquivos: string;
  VG_PastaBackup: string;
  VG_PastaTemporaria: string;

  //SISTEMA
  VG_Direitos: string;
  VG_Logo: string;

  //USUARIO
  VG_UsuarioLogadoId: Integer;
  VG_UsuarioLogadoNome: string;

procedure RefreshVariables;
procedure CreateAppDirectories;

implementation

procedure RefreshVariables;
begin
   //PASTAS
   VG_PastaPadrao     := PASTA_PADRAO + '\ERP';
   VG_PastaRelatorios := VG_PastaPadrao + PASTA_RELATORIO;
   VG_PastaImagens    := VG_PastaPadrao + PASTA_IMAGEM;
   VG_PastaArquivos   := VG_PastaPadrao + PASTA_ARQUIVO;
   VG_PastaBackup     := VG_PastaPadrao + PASTA_BACKUP;
   VG_PastaTemporaria := VG_PastaPadrao + PASTA_TEMP;

   //SISTEMA
   VG_Direitos := CG_DIREITOS_SISTEMA;
   VG_Logo     := IncludeTrailingPathDelimiter(VG_PastaImagens) + CG_LOGO;

   //USUARIO
   VG_UsuarioLogadoId   := 0;
   VG_UsuarioLogadoNome := EmptyStr;
end;

procedure CreateAppDirectories;
begin
   if(not DirectoryExists(VG_PastaPadrao))then
     ForceDirectories(VG_PastaPadrao);

   if(not DirectoryExists(VG_PastaRelatorios))then
     ForceDirectories(VG_PastaRelatorios);

   if(not DirectoryExists(VG_PastaImagens))then
     ForceDirectories(VG_PastaImagens);

   if(not DirectoryExists(VG_PastaArquivos))then
     ForceDirectories(VG_PastaArquivos);

   if(not DirectoryExists(VG_PastaBackup))then
     ForceDirectories(VG_PastaBackup);

   if(not DirectoryExists(VG_PastaTemporaria))then
     ForceDirectories(VG_PastaTemporaria);
end;

end.
