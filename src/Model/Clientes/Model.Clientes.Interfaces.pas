unit Model.Clientes.Interfaces;

interface

type
  IModelClientesFactory<T> = interface
   ['{3B0CCCF4-95AA-45E7-9A56-AD293200C9AC}']
   function Entitie: T;
   function ValidarCPF: Boolean;
  end;

implementation

end.
