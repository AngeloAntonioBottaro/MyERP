inherited ViewPermissoesGruposBusca: TViewPermissoesGruposBusca
  Caption = 'Busca de grupos de permiss'#245'es'
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
        TabOrder = 0
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
      object rdBuscarDescricao: TRadioButton
        Left = 205
        Top = 20
        Width = 92
        Height = 17
        Caption = 'Descri'#231#227'o (F4)'
        Checked = True
        TabOrder = 2
        TabStop = True
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
          Title.Caption = 'Nome'
          Width = 238
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCRICAO'
          Title.Caption = 'Descri'#231#227'o'
          Width = 421
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
