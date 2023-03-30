inherited ViewCidadesCad: TViewCidadesCad
  Caption = 'Cadastro de cidades'
  ClientHeight = 106
  ClientWidth = 709
  ExplicitWidth = 725
  ExplicitHeight = 145
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnButtons: TPanel
    Top = 65
    Width = 709
    ExplicitTop = 65
    ExplicitWidth = 808
    inherited btnGravar: TButton
      OnClick = btnGravarClick
    end
    inherited btnExcluir: TButton
      OnClick = btnExcluirClick
    end
    inherited btnBuscar: TButton
      OnClick = btnBuscarClick
      ExplicitLeft = 604
    end
    inherited btnFechar: TButton
      ExplicitLeft = 704
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
    Height = 59
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitWidth = 802
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
      Width = 33
      Height = 13
      Caption = 'Cidade'
    end
    object lbIBGE: TLabel
      Left = 580
      Top = 8
      Width = 23
      Height = 13
      Caption = 'IBGE'
    end
    object lbUF: TLabel
      Left = 518
      Top = 8
      Width = 13
      Height = 13
      Caption = 'UF'
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
    object edtCidade: TEdit
      Left = 74
      Top = 22
      Width = 443
      Height = 21
      TabOrder = 1
    end
    object cBoxUF: TComboBox
      Left = 518
      Top = 22
      Width = 61
      Height = 21
      Style = csDropDownList
      TabOrder = 2
    end
    object edtIBGE: TEdit
      Left = 580
      Top = 22
      Width = 121
      Height = 21
      TabOrder = 3
    end
  end
end
