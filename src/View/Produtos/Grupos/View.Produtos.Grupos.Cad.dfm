inherited ViewProdutosGruposCad: TViewProdutosGruposCad
  Caption = 'Cadastro de grupos de produtos'
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
    object lbGrupo: TLabel
      Left = 74
      Top = 8
      Width = 29
      Height = 13
      Caption = 'Grupo'
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
    object edtGrupo: TEdit
      Left = 74
      Top = 22
      Width = 527
      Height = 21
      TabOrder = 1
    end
  end
end
