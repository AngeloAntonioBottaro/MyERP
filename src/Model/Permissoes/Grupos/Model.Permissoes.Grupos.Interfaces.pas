unit Model.Permissoes.Grupos.Interfaces;

interface

type
  IModelPermissoesGruposFactory<T> = interface
   ['{4A0227A7-F9F6-451D-AEC3-83CA99339B7F}']
   function Entitie: T;

   function ConsultarEntitie: IModelPermissoesGruposFactory<T>;
   function Deletar: IModelPermissoesGruposFactory<T>;
   function Gravar: IModelPermissoesGruposFactory<T>;
  end;

implementation

end.
