inherited ViewSistemaIconesConf: TViewSistemaIconesConf
  Caption = 'Configura'#231#227'o de '#237'cones'
  ClientHeight = 489
  ClientWidth = 1041
  OnShow = FormShow
  ExplicitWidth = 1057
  ExplicitHeight = 528
  PixelsPerInch = 96
  TextHeight = 13
  object pnTop: TPanel
    Left = 0
    Top = 0
    Width = 1041
    Height = 33
    Align = alTop
    TabOrder = 0
    ExplicitLeft = 24
    object lbFuncionario: TLabel
      AlignWithMargins = True
      Left = 11
      Top = 4
      Width = 82
      Height = 25
      Margins.Left = 10
      Align = alLeft
      Alignment = taCenter
      Caption = 'Funcion'#225'rio: '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      ExplicitHeight = 16
    end
    object edtFuncionario: TEdit
      AlignWithMargins = True
      Left = 156
      Top = 6
      Width = 309
      Height = 21
      Margins.Left = 0
      Margins.Top = 5
      Margins.Bottom = 5
      Align = alLeft
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
    end
    object edtIdFuncionario: TEdit
      AlignWithMargins = True
      Left = 99
      Top = 6
      Width = 54
      Height = 21
      Margins.Top = 5
      Margins.Bottom = 5
      Align = alLeft
      Alignment = taRightJustify
      NumbersOnly = True
      TabOrder = 1
      OnExit = edtIdFuncionarioExit
    end
  end
  object pnBotton: TPanel
    Left = 0
    Top = 448
    Width = 1041
    Height = 41
    Align = alBottom
    Padding.Top = 3
    Padding.Bottom = 3
    TabOrder = 1
    ExplicitLeft = 8
    object btnGravar: TButton
      Left = 940
      Top = 4
      Width = 100
      Height = 33
      Align = alRight
      Caption = 'Gravar'
      TabOrder = 0
      OnClick = btnGravarClick
      ExplicitLeft = 25
      ExplicitTop = 1
      ExplicitHeight = 39
    end
    object btnMarcarTodos: TButton
      Tag = 1
      Left = 1
      Top = 4
      Width = 100
      Height = 33
      Align = alLeft
      Caption = 'Marcar todos'
      TabOrder = 1
      OnClick = btnMarcarTodosClick
      ExplicitLeft = 25
      ExplicitTop = 1
      ExplicitHeight = 39
    end
    object btnDesmarcarTodos: TButton
      Tag = 2
      Left = 101
      Top = 4
      Width = 100
      Height = 33
      Align = alLeft
      Caption = 'Desmarcar todos'
      TabOrder = 2
      OnClick = btnMarcarTodosClick
      ExplicitLeft = 193
      ExplicitTop = -4
    end
  end
end
