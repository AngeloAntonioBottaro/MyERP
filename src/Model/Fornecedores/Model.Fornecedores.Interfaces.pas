unit Model.Fornecedores.Interfaces;

interface

type
  IModelFornecedoresFactory<T> = interface
   ['{84FA9028-8BE8-406F-9952-DE90F0FCDC93}']
   function Entitie: T;
   function ValidarCPF: Boolean;
   function ValidarCNPJ: Boolean;
  end;

implementation

end.
