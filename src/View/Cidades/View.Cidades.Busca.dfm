inherited ViewCidadesBusca: TViewCidadesBusca
  Caption = 'Busca de cidade'
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
        Left = 109
        Top = 20
        Width = 75
        Height = 17
        Caption = 'Nome (F3)'
        Checked = True
        TabOrder = 1
        TabStop = True
        OnClick = ConfComponents
      end
      object rdBuscarCodigo: TRadioButton
        Left = 10
        Top = 20
        Width = 78
        Height = 17
        Caption = 'C'#243'digo (F2)'
        TabOrder = 0
        OnClick = ConfComponents
      end
      object rdBuscarUF: TRadioButton
        Left = 206
        Top = 20
        Width = 96
        Height = 17
        Caption = 'UF (F4)'
        TabOrder = 2
        OnClick = ConfComponents
      end
      object rdBuscarIBGE: TRadioButton
        Left = 308
        Top = 20
        Width = 77
        Height = 17
        Caption = 'IBGE (F6)'
        TabOrder = 3
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
          FieldName = 'ID'
          Title.Caption = 'C'#243'digo'
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOME'
          Title.Caption = 'Cidade'
          Width = 539
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'UF'
          Title.Caption = 'Estado'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IBGE'
          Width = 80
          Visible = True
        end>
    end
  end
end
