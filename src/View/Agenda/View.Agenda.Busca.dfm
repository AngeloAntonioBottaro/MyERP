inherited ViewAgendaBusca: TViewAgendaBusca
  Caption = 'Busca de compromissos agendados'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnBotton: TPanel
    inherited pnButtons: TPanel
      inherited btnCadastro: TButton
        Visible = False
      end
    end
    inherited gBoxTipoConsulta: TGroupBox
      object rdBuscarCliente: TRadioButton
        Left = 109
        Top = 20
        Width = 75
        Height = 17
        Caption = 'Cliente (F3)'
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = ConfComponents
      end
      object rdBuscarCodigo: TRadioButton
        Left = 10
        Top = 20
        Width = 78
        Height = 17
        Caption = 'C'#243'digo (F2)'
        TabOrder = 1
        OnClick = ConfComponents
      end
      object rdBuscarFuncionario: TRadioButton
        Left = 206
        Top = 20
        Width = 96
        Height = 17
        Caption = 'Funcion'#225'rio (F4)'
        TabOrder = 2
        OnClick = ConfComponents
      end
      object rdBuscarStatus: TRadioButton
        Left = 324
        Top = 20
        Width = 85
        Height = 17
        Caption = 'Situa'#231#227'o (F6)'
        TabOrder = 3
        OnClick = ConfComponents
      end
      object rdBuscarTitulo: TRadioButton
        Left = 10
        Top = 43
        Width = 78
        Height = 17
        Caption = 'T'#237'tulo (F7)'
        TabOrder = 4
        OnClick = ConfComponents
      end
    end
  end
  inherited pnGrid: TPanel
    inherited GridBusca: TDBGrid
      OnTitleClick = GridBuscaTitleClick
      Columns = <
        item
          Expanded = False
          FieldName = 'TITULO'
          Title.Caption = 'T'#237'tulo'
          Width = 178
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CLIENTE'
          Title.Caption = 'C'#243'd. Cliente'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CLIENTE_NOME'
          Title.Caption = 'Cliente'
          Width = 201
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FUNCIONARIO'
          Title.Caption = 'C'#243'd. func.'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FUNCIONARIO_NOME'
          Title.Caption = 'Funcion'#225'rio'
          Width = 143
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATA'
          Title.Caption = 'Data'
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'HORA'
          Title.Caption = 'Hora'
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'STATUS'
          Title.Caption = 'Situa'#231#227'o'
          Width = 87
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ID'
          Title.Caption = 'C'#243'digo'
          Width = 50
          Visible = True
        end>
    end
  end
end
