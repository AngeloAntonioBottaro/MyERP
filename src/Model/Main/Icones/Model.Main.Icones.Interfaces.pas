unit Model.Main.Icones.Interfaces;

interface

uses
  Vcl.Forms,
  Model.Main.Icones.Types;

type
  IModelMainIconesCriacoesComponentes = interface
   ['{0B626A25-DF2A-4666-B4AC-6CEDEF9B4D81}']
   procedure CriarComponente;
  end;

  IModelMainIconesComponentes = interface
   ['{E4A90298-8199-4E90-AE91-D4F36545449E}']
   function Formulario(AFormulario: TForm): IModelMainIconesComponentes;
   procedure CriarPanelIcones;
  end;

  IModelMainIconesList = interface
   ['{53A9E3C2-C544-45D3-B61A-5557025D2EAE}']
   function Lista: TPairMainIconesFields;
   procedure AtualizaVisibilidades;
  end;

  IModelMainIcones = interface
   ['{F2DDD9F2-206A-49F4-9DD0-A719AE4C9F87}']
   function Lista: TPairMainIconesFields;
   function AtualizaVisibilidades: IModelMainIcones;
   function Componentes: IModelMainIconesComponentes;
  end;

implementation

end.
