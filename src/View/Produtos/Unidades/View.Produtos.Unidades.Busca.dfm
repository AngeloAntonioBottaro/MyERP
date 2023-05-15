inherited ViewProdutosUnidadesBusca: TViewProdutosUnidadesBusca
  Caption = 'Busca de unidade de produto'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnTop: TPanel
    inherited pnBuscarConteudo: TPanel
      inherited lbBusca: TLabel
        Width = 380
      end
    end
  end
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
      object rdBuscarSigla: TRadioButton
        Left = 196
        Top = 20
        Width = 65
        Height = 17
        Caption = 'Sigla (F4)'
        TabOrder = 2
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
          Title.Caption = 'Nome/Descri'#231#227'o'
          Width = 594
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SIGLA'
          Title.Caption = 'Sigla'
          Width = 72
          Visible = True
        end>
    end
    inherited pnOptions: TPanel
      inherited lbTotalRegistros: TLabel
        Height = 14
      end
    end
  end
  inherited MenuBusca: TPopupMenu
    inherited Excluir1: TMenuItem
      Tag = 0
      Visible = True
    end
  end
end
