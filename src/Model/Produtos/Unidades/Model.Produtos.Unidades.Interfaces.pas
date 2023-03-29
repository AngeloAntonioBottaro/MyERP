unit Model.Produtos.Unidades.Interfaces;

interface

type
  IModelProdutosUnidadesFactory<T> = interface
   ['{E30BA03F-A103-4FCE-B8CA-0DA9CB2A4650}']
   function Entitie: T;

   function ConsultarEntitie: IModelProdutosUnidadesFactory<T>;
   function Deletar: IModelProdutosUnidadesFactory<T>;
   function Gravar: IModelProdutosUnidadesFactory<T>;
  end;

implementation

end.
