unit Utils.LibrarySistema;

interface

uses
  System.SysUtils,
  System.StrUtils,
  System.Classes;

procedure CriarComboBoxTipoJuridico(ALines: TStrings);

implementation

uses
  Utils.GlobalConsts;

procedure CriarComboBoxTipoJuridico(ALines: TStrings);
begin
   ALines.Clear;
   ALines.Add(PESSOA_FISICA);
   ALines.Add(PESSOA_JURIDICA);
end;

end.
