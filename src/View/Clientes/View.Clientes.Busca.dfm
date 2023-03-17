inherited ViewClientesBusca: TViewClientesBusca
  Caption = 'Busca de cliente'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnBotton: TPanel
    inherited pnButtons: TPanel
      inherited btnCadastro: TButton
        OnClick = btnCadastroClick
      end
    end
    inherited gBoxTipoConsulta: TGroupBox
      object rdBuscarNome: TRadioButton
        Left = 94
        Top = 20
        Width = 50
        Height = 17
        Caption = 'Nome'
        Checked = True
        TabOrder = 0
        TabStop = True
      end
      object rdBuscarCodigo: TRadioButton
        Left = 10
        Top = 20
        Width = 61
        Height = 17
        Caption = 'C'#243'digo'
        TabOrder = 1
      end
      object rdBuscarCPF_CNPJ: TRadioButton
        Left = 158
        Top = 20
        Width = 80
        Height = 17
        Caption = 'CPF / CNPJ'
        TabOrder = 2
      end
      object rdBuscarCidade: TRadioButton
        Left = 252
        Top = 20
        Width = 53
        Height = 17
        Caption = 'Cidade'
        TabOrder = 3
      end
    end
    inherited pnOptions: TPanel
      inherited lbTotalRegistros: TLabel
        Height = 14
      end
    end
  end
  inherited GridBusca: TDBGrid
    Columns = <
      item
        Expanded = False
        FieldName = 'ID'
        Title.Caption = 'C'#243'digo'
        Width = 40
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RAZAO_SOCIAL'
        Title.Caption = 'Raz'#227'o social'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_FANTASIA'
        Title.Caption = 'Nome fantasia'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TELEFONE'
        Title.Caption = 'Telefone'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CELULAR'
        Title.Caption = 'Celular'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CPF'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CNPJ'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_CIDADE'
        Title.Caption = 'Cidade'
        Width = 100
        Visible = True
      end>
  end
end
