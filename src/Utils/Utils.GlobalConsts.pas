unit Utils.GlobalConsts;

interface

const
  PESSOA_FISICA            = 'Pessoa Física';
  PESSOA_JURIDICA          = 'Pessoa Jurídica';
  PESSOA_FISICA_DATABASE   = 'F';
  PESSOA_JURIDICA_DATABASE = 'J';

  STATUS_ATIVO   = 'A';
  STATUS_INATIVO = 'I';

  TIPO_LANCAMENTO_CAIXA                = 'Caixa';
  TIPO_LANCAMENTO_FINANCEIRO           = 'Financeiro';
  TIPO_LANCAMENTO_SEMCONTROLE          = 'Sem controle';
  TIPO_LANCAMENTO_CAIXA_DATABASE       = 'C';
  TIPO_LANCAMENTO_FINANCEIRO_DATABASE  = 'F';
  TIPO_LANCAMENTO_SEMCONTROLE_DATABASE = 'S';

  AGENDA_STATUS: array[1..4] of String = ('Aberto', 'Confirmado', 'Concluido', 'Cancelado');

implementation

end.
