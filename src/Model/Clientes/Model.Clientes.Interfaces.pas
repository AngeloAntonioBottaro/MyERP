unit Model.Clientes.Interfaces;

interface

type
  IModelClientesFactory<T> = interface
   ['{3B0CCCF4-95AA-45E7-9A56-AD293200C9AC}']
   function Entitie: T;
   procedure ValidarCPF;
   procedure ValidarCNPJ;
   procedure ValidarEmail;

   function AlterarStatus: IModelClientesFactory<T>;
   function ConsultarEntitie: IModelClientesFactory<T>;
   function Deletar: IModelClientesFactory<T>;
   function Gravar: IModelClientesFactory<T>;
  end;

implementation

end.
