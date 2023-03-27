inherited ViewProdutosCad: TViewProdutosCad
  Caption = 'Cadastro de produtos'
  ClientHeight = 261
  ExplicitHeight = 300
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnButtons: TPanel
    Top = 220
    inherited btnBuscar: TButton
      OnClick = btnBuscarClick
    end
  end
  object pnTela: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 703
    Height = 214
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
    object lbRazaoSocial: TLabel
      Left = 74
      Top = 8
      Width = 27
      Height = 13
      Caption = 'Nome'
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
    object edtRazaoSocial: TEdit
      Left = 74
      Top = 22
      Width = 359
      Height = 21
      TabOrder = 1
    end
  end
end
