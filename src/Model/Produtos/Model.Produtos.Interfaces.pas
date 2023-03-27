unit Model.Produtos.Interfaces;

interface

type
  IModelProdutosFactory<T> = interface
   ['{57034314-BDF4-4144-98B4-2FF2FE49AC96}']
   function Entitie: T;

   function AlterarStatus: IModelProdutosFactory<T>;
   function ConsultarEntitie: IModelProdutosFactory<T>;
   function Deletar: IModelProdutosFactory<T>;
   function Gravar: IModelProdutosFactory<T>;
  end;

implementation

end.
