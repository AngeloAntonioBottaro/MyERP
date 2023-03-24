unit Model.Produtos.SubGrupos.Interfaces;

interface

type
  IModelProdutosSubGruposFactory<T> = interface
   ['{FDDA3B93-9EED-4DEC-B234-F5755501867F}']
   function Entitie: T;

   function ConsultarEntitie: IModelProdutosSubGruposFactory<T>;
   function Deletar: IModelProdutosSubGruposFactory<T>;
   function Gravar: IModelProdutosSubGruposFactory<T>;
  end;

implementation

end.
