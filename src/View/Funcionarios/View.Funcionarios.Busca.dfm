inherited ViewFuncionariosBusca: TViewFuncionariosBusca
  Caption = 'Busca de funcion'#225'rio'
  OnDestroy = FormDestroy
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
      object rdBuscarCPF_CNPJ: TRadioButton
        Left = 198
        Top = 20
        Width = 96
        Height = 17
        Caption = 'CPF / CNPJ (F4)'
        TabOrder = 2
        OnClick = ConfComponents
      end
      object rdBuscarCidade: TRadioButton
        Left = 308
        Top = 20
        Width = 77
        Height = 17
        Caption = 'Cidade (F6)'
        TabOrder = 3
        OnClick = ConfComponents
      end
    end
    inherited pnOptions: TPanel
      inherited lbTotalRegistros: TLabel
        Height = 14
      end
    end
    inherited ckBuscarInativos: TCheckBox
      Visible = True
    end
  end
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
        Width = 150
        Visible = True
      end>
  end
  inherited PopupMenu: TPopupMenu
    inherited AtivarInativar1: TMenuItem
      Visible = True
    end
    inherited Excluir1: TMenuItem
      Visible = True
    end
  end
end
