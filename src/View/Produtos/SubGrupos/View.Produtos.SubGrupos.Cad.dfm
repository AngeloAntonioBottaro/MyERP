inherited ViewProdutosSubgruposCad: TViewProdutosSubgruposCad
  Caption = 'Cadastro de sub-grupos de produtos'
  ClientHeight = 106
  ClientWidth = 609
  ExplicitWidth = 625
  ExplicitHeight = 145
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnButtons: TPanel
    Top = 65
    Width = 609
    ExplicitTop = 65
    ExplicitWidth = 609
  end
  object pnTela: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 603
    Height = 59
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object lbIdsubgrupo: TLabel
      Left = 286
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
    object lbIdGrupo: TLabel
      Left = 10
      Top = 8
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
    end
    object lbNomeGrupo: TLabel
      Left = 82
      Top = 8
      Width = 58
      Height = 13
      Caption = 'Nome grupo'
    end
    object lbNomeSubGrupo: TLabel
      Left = 352
      Top = 8
      Width = 79
      Height = 13
      Caption = 'Nome sub-grupo'
    end
    object edtIdGrupo: TEdit
      Left = 10
      Top = 22
      Width = 65
      Height = 21
      Alignment = taRightJustify
      NumbersOnly = True
      TabOrder = 0
    end
    object edtGrupo: TEdit
      Left = 76
      Top = 22
      Width = 209
      Height = 21
      TabOrder = 1
    end
    object edtId: TEdit
      Left = 286
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
      TabOrder = 2
    end
    object edtSubGrupo: TEdit
      Left = 352
      Top = 22
      Width = 249
      Height = 21
      TabOrder = 3
    end
  end
end
