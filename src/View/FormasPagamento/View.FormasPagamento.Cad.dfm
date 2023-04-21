inherited ViewFormasPagamentoCad: TViewFormasPagamentoCad
  Caption = 'Cadastro de formas de pagamento'
  ClientHeight = 99
  ClientWidth = 709
  ExplicitWidth = 725
  ExplicitHeight = 138
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnButtons: TPanel
    Top = 58
    Width = 709
    ExplicitTop = 58
    ExplicitWidth = 709
    inherited btnGravar: TButton
      OnClick = btnGravarClick
    end
    inherited btnExcluir: TButton
      OnClick = btnExcluirClick
    end
    inherited btnBuscar: TButton
      OnClick = btnBuscarClick
    end
    inherited btnAlterar: TButton
      OnClick = btnAlterarClick
    end
  end
  object pnTela: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 703
    Height = 52
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object lbId: TLabel
      Left = 8
      Top = 8
      Width = 38
      Height = 13
      Caption = 'C'#243'digo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbNome: TLabel
      Left = 74
      Top = 8
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
    end
    object lbTipoLancamento: TLabel
      Left = 544
      Top = 8
      Width = 78
      Height = 13
      Caption = 'Tipo lan'#231'amento'
    end
    object cBoxTipoLancamento: TComboBox
      Left = 544
      Top = 22
      Width = 157
      Height = 21
      Style = csDropDownList
      TabOrder = 2
      Items.Strings = (
        'Pessoa f'#237'sica'
        'Pessoa Jur'#237'dica')
    end
    object edtId: TEdit
      Left = 8
      Top = 22
      Width = 65
      Height = 21
      TabStop = False
      Alignment = taRightJustify
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object edtNome: TEdit
      Left = 74
      Top = 22
      Width = 469
      Height = 21
      TabOrder = 1
    end
  end
end
