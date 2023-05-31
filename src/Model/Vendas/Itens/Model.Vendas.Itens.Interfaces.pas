unit Model.Vendas.Itens.Interfaces;

interface

uses
  Model.Vendas.Itens.Entitie;

type
  IModelVendasItensFactory = interface
   ['{7C0B2293-649A-40EE-98C9-879000DD96D1}']
   function NewItem: TModelVendasItensEntitie;
   procedure AddItem;
  end;

implementation

end.
