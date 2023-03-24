unit Model.Funcionarios.Funcoes.Interfaces;

interface

type
  IModelFuncionariosFuncoesFactory<T> = interface
   ['{3576AA5D-7D70-432A-B464-F35E660E4215}']
   function Entitie: T;

   function ConsultarEntitie: IModelFuncionariosFuncoesFactory<T>;
   function Deletar: IModelFuncionariosFuncoesFactory<T>;
   function Gravar: IModelFuncionariosFuncoesFactory<T>;
  end;

implementation

end.
