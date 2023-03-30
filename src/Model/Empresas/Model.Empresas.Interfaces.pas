unit Model.Empresas.Interfaces;

interface

type
  IModelEmpresasFactory<T> = interface
   ['{84FA9028-8BE8-406F-9952-DE90F0FCDC93}']
   function Entitie: T;
   procedure ValidarCPF;
   procedure ValidarCNPJ;
   procedure ValidarEmail;

   function ConsultarEntitie: IModelEmpresasFactory<T>;
   function Gravar: IModelEmpresasFactory<T>;
  end;

implementation

end.
