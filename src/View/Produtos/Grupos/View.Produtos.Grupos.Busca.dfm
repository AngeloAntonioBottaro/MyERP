inherited ViewProdutosGruposBusca: TViewProdutosGruposBusca
  Caption = 'Busca de grupo de produto'
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
          Title.Caption = 'Grupo'
          Width = 671
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
