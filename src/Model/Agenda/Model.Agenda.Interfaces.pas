unit Model.Agenda.Interfaces;

interface

type
  IModelAgendaFactory<T> = interface
   ['{8EEB52F0-F8B6-4AA6-B9BD-9C238092ADE8}']
   function Entitie: T;

   function ConsultarEntitie: IModelAgendaFactory<T>;
   function Deletar: IModelAgendaFactory<T>;
   function Gravar: IModelAgendaFactory<T>;
  end;

implementation

end.
