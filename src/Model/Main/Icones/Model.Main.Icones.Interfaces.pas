unit Model.Main.Icones.Interfaces;

interface

uses
  Vcl.Forms,
  Model.Main.Icones.Types;

type
  IModelMainIconesComponentes = interface
   ['{0B626A25-DF2A-4666-B4AC-6CEDEF9B4D81}']
   function Formulario(AFormulario: TForm): IModelMainIconesComponentes;
   procedure CriarComponente;
   procedure LimparComponente;
  end;

  IModelMainIconesList = interface
   ['{53A9E3C2-C544-45D3-B61A-5557025D2EAE}']
   function Lista: TPairMainIconesFields;
   procedure AtualizarVisibilidades;
  end;

implementation

end.
