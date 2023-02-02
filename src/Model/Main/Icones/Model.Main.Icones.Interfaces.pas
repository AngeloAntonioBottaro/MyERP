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

  IModelMainIconesListaVisibilidadeManual = interface
   ['{A2F863A3-F8F5-46F7-BB8A-921E9ECA30E1}']
   function Add(AKey: string; AValue: Boolean): IModelMainIconesListaVisibilidadeManual;
   function LimparLista: IModelMainIconesListaVisibilidadeManual;
   function Lista: TDictionaryStringBool;
  end;

  IModelMainIconesList = interface
   ['{53A9E3C2-C544-45D3-B61A-5557025D2EAE}']
   function Lista: TPairMainIconesFields;
   procedure AtualizarVisibilidades(AListaVisibilidadeManual: IModelMainIconesListaVisibilidadeManual);
  end;

implementation

end.
