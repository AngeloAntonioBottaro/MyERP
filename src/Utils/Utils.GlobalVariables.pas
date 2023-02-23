unit Utils.GlobalVariables;

interface

uses
  System.SysUtils,
  System.StrUtils,
  System.UITypes,
  Utils.MyConsts,
  Utils.MyLibrary;

var
  //PASTAS
  VG_PastaPadrao: string;
  VG_PastaArquivos: string;
  VG_PastaBackups: string;
  VG_PastaImagens: string;
  VG_PastaRelatorios: string;
  VG_PastaTemporaria: string;
  VG_PastaAppData: string;

  //SISTEMA
  VG_Direitos: string;
  VG_Logo: string;
  VG_Impressora: string;

  VG_DataHoraAberturaSistema: TDateTime;

  //USUARIO
  VG_UsuarioLogadoId: Integer;
  VG_UsuarioLogadoNome: string;

procedure RefreshVariables;
procedure CreateAppDirectories;

implementation

procedure RefreshVariables;
begin
   //PASTAS
   VG_PastaPadrao     := PASTA_PADRAO + 'ERP\';
   VG_PastaArquivos   := VG_PastaPadrao + PASTA_ARQUIVO;
   VG_PastaBackups    := VG_PastaPadrao + PASTA_BACKUP;
   VG_PastaImagens    := VG_PastaArquivos + PASTA_IMAGEM;
   VG_PastaRelatorios := VG_PastaPadrao + PASTA_RELATORIO;
   VG_PastaTemporaria := PASTA_TEMP;
   VG_PastaAppData    := TMyLibrary.GetPathAppDataLocal;

   //SISTEMA
   VG_Direitos   := DIREITOS_SISTEMA;
   VG_Logo       := IncludeTrailingPathDelimiter(VG_PastaImagens) + IMAGE_LOGO;
   VG_Impressora := EmptyStr;

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

   if(not DirectoryExists(VG_PastaTemporaria))then
     ForceDirectories(VG_PastaTemporaria);
end;

end.
