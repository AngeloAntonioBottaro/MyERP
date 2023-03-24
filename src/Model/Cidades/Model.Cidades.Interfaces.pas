unit Model.Cidades.Interfaces;

interface

type
  IModelCidadesFactory<T> = interface
   ['{8EEB52F0-F8B6-4AA6-B9BD-9C238092ADE8}']
   function Entitie: T;

   function ConsultarEntitie: IModelCidadesFactory<T>;
   function Deletar: IModelCidadesFactory<T>;
   function Gravar: IModelCidadesFactory<T>;
  end;

implementation

end.
