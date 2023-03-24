unit Model.Funcionarios.Interfaces;

interface

type
  IModelFuncionariosFactory<T> = interface
   ['{84FA9028-8BE8-406F-9952-DE90F0FCDC93}']
   function Entitie: T;
   procedure ValidarCPF;
   procedure ValidarCNPJ;
   procedure ValidarEmail;

   function AlterarStatus: IModelFuncionariosFactory<T>;
   function ConsultarEntitie: IModelFuncionariosFactory<T>;
   function Deletar: IModelFuncionariosFactory<T>;
   function Gravar: IModelFuncionariosFactory<T>;
  end;

implementation

end.
