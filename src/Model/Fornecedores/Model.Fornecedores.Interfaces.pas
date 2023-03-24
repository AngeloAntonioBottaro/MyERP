unit Model.Fornecedores.Interfaces;

interface

type
  IModelFornecedoresFactory<T> = interface
   ['{84FA9028-8BE8-406F-9952-DE90F0FCDC93}']
   function Entitie: T;
   procedure ValidarCPF;
   procedure ValidarCNPJ;
   procedure ValidarEmail;

   function AlterarStatus: IModelFornecedoresFactory<T>;
   function ConsultarEntitie: IModelFornecedoresFactory<T>;
   function Deletar: IModelFornecedoresFactory<T>;
   function Gravar: IModelFornecedoresFactory<T>;
  end;

implementation

end.
