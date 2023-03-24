unit Model.Sistema.Busca.Entities.Interfaces;

interface

type
  IModelSistemaBuscaEntities = interface
   ['{ABDA9AFF-4FBA-4734-962B-00E5BFC27689}']
   function TipoBusca(ATipoBusca: TTipoBuscaProdutoSubGrupo): IModelSistemaBuscaEntities;
   function Inativos(AInativos: Boolean): IModelSistemaBuscaEntities;
   function DataSource(ADataSource: TDataSource): IModelSistemaBuscaEntities;
   function ConteudoBusca(AConteudoBusca: string): IModelSistemaBuscaEntities;
   function IndexFieldNames(AIndex: string): IModelSistemaBuscaEntities;
   procedure Buscar;
  end;

implementation

end.
