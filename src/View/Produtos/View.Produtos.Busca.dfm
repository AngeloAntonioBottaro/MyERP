inherited ViewProdutosBusca: TViewProdutosBusca
  Caption = 'Busca de produto'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnBotton: TPanel
    inherited pnButtons: TPanel
      inherited btnCadastro: TButton
        OnClick = btnCadastroClick
      end
    end
    inherited gBoxTipoConsulta: TGroupBox
      object rdBuscarCodigo: TRadioButton
        Left = 10
        Top = 20
        Width = 78
        Height = 17
        Caption = 'C'#243'digo (F2)'
        TabOrder = 0
        OnClick = ConfComponents
      end
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
      object rdBuscarCodBarras: TRadioButton
        Left = 200
        Top = 20
        Width = 108
        Height = 17
        Caption = 'C'#243'digo barras (F4)'
        TabOrder = 2
        OnClick = ConfComponents
      end
    end
    inherited ckBuscarInativos: TCheckBox
      Visible = True
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
          Title.Caption = 'Produto'
          Width = 369
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CUSTO'
          Title.Caption = 'Custo'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRECO_VENDA_VISTA'
          Title.Caption = 'Pre'#231'o vista'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRECO_VENDA_PRAZO'
          Title.Caption = 'Pre'#231'o prazo'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ESTOQUE'
          Title.Caption = 'Estoque'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOME_GRUPO'
          Title.Caption = 'Grupo'
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOME_SUBGRUPO'
          Title.Caption = 'Subgrupo'
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CODIGO_BARRAS'
          Title.Caption = 'C'#243'digo barras'
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SIGLA'
          Title.Caption = 'UN'
          Width = 50
          Visible = True
        end>
    end
  end
  inherited MenuBusca: TPopupMenu
    inherited AtivarInativar1: TMenuItem
      Visible = True
    end
    inherited Excluir1: TMenuItem
      Visible = True
    end
  end
end
