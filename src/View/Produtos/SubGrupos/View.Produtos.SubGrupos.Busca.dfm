inherited ViewProdutosSubGruposBusca: TViewProdutosSubGruposBusca
  Caption = 'Busca de sub grupo de produto'
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
        Left = 103
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
      object rdBuscarCodGrupo: TRadioButton
        Left = 190
        Top = 20
        Width = 112
        Height = 17
        Caption = 'C'#243'digo grupo (F4)'
        TabOrder = 2
        OnClick = ConfComponents
      end
      object rdBuscarNomeGrupo: TRadioButton
        Left = 308
        Top = 20
        Width = 101
        Height = 17
        Caption = 'Nome grupo (F6)'
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
          Title.Caption = 'Sub-grupo'
          Width = 300
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'GRUPO'
          Title.Caption = 'C'#243'd. grupo'
          Width = 63
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOME_GRUPO'
          Title.Caption = 'Grupo'
          Width = 300
          Visible = True
        end>
    end
  end
  inherited PopupMenu: TPopupMenu
    inherited Excluir1: TMenuItem
      Visible = True
    end
  end
end
