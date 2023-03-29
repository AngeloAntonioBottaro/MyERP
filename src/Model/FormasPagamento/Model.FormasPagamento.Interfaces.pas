unit Model.FormasPagamento.Interfaces;

interface

type
  IModelFormasPagamentoFactory<T> = interface
   ['{E5571A52-42F1-49ED-83D8-C5D34F20B46D}']
   function Entitie: T;

   function AlterarStatus: IModelFormasPagamentoFactory<T>;
   function ConsultarEntitie: IModelFormasPagamentoFactory<T>;
   function Deletar: IModelFormasPagamentoFactory<T>;
   function Gravar: IModelFormasPagamentoFactory<T>;
  end;

implementation

end.
