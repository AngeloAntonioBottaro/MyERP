unit Model.Clientes.Interfaces;

interface

type
  IModelClientesFactory<T> = interface
   ['{3B0CCCF4-95AA-45E7-9A56-AD293200C9AC}']
   function Entitie: T;
   procedure ValidarCPF;
   procedure ValidarCNPJ;
   procedure ValidarEmail;

   function Gravar: IModelClientesFactory<T>;
   function Deletar: IModelClientesFactory<T>;
   function AlterarStatus: IModelClientesFactory<T>;
  end;

implementation

end.
