inherited ViewBaseCadastros: TViewBaseCadastros
  Caption = 'Tela de cadastro de '
  ClientHeight = 369
  ClientWidth = 709
  OnClose = FormClose
  ExplicitWidth = 725
  ExplicitHeight = 408
  PixelsPerInch = 96
  TextHeight = 13
  object pnButtons: TPanel
    Left = 0
    Top = 328
    Width = 709
    Height = 41
    Align = alBottom
    Padding.Left = 3
    Padding.Top = 3
    Padding.Right = 3
    Padding.Bottom = 3
    TabOrder = 0
    object btnNovo: TButton
      Left = 4
      Top = 4
      Width = 100
      Height = 33
      Align = alLeft
      Caption = 'Novo'
      TabOrder = 0
      OnClick = btnNovoClick
    end
    object btnGravar: TButton
      Left = 104
      Top = 4
      Width = 100
      Height = 33
      Align = alLeft
      Caption = 'Gravar'
      TabOrder = 1
    end
    object btnCancelar: TButton
      Left = 204
      Top = 4
      Width = 100
      Height = 33
      Align = alLeft
      Caption = 'Cancelar'
      TabOrder = 2
      OnClick = btnCancelarClick
    end
    object btnExcluir: TButton
      Left = 404
      Top = 4
      Width = 100
      Height = 33
      Align = alLeft
      Caption = 'Excluir'
      TabOrder = 3
    end
    object btnBuscar: TButton
      Left = 504
      Top = 4
      Width = 100
      Height = 33
      Align = alLeft
      Caption = 'Buscar'
      TabOrder = 4
    end
    object btnFechar: TButton
      Left = 604
      Top = 4
      Width = 100
      Height = 33
      Align = alLeft
      Caption = 'Fechar'
      TabOrder = 5
      OnClick = btnFecharClick
    end
    object btnAlterar: TButton
      Left = 304
      Top = 4
      Width = 100
      Height = 33
      Align = alLeft
      Caption = 'Alterar'
      TabOrder = 6
    end
  end
end
