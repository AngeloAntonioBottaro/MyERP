unit Model.Produtos.Grupos.Interfaces;

interface

type
  IModelProdutosGruposFactory<T> = interface
   ['{4A0227A7-F9F6-451D-AEC3-83CA99339B7F}']
   function Entitie: T;

   function ConsultarEntitie: IModelProdutosGruposFactory<T>;
   function Deletar: IModelProdutosGruposFactory<T>;
   function Gravar: IModelProdutosGruposFactory<T>;
  end;

implementation

end.
