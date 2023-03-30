inherited ViewAgendaCad: TViewAgendaCad
  Caption = 'Agenda de compromissos'
  ClientHeight = 331
  ClientWidth = 810
  ExplicitWidth = 826
  ExplicitHeight = 370
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnButtons: TPanel
    Top = 290
    Width = 810
    ExplicitTop = 212
    ExplicitWidth = 810
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
    inherited btnImprimir: TButton
      Visible = True
    end
  end
  object pnTela: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 804
    Height = 284
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitHeight = 206
    object lbStatus: TLabel
      Left = 251
      Top = 48
      Width = 41
      Height = 13
      Caption = 'Situa'#231#227'o'
    end
    object lbIdCliente: TLabel
      Left = 74
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
    object lbCliente: TLabel
      Left = 140
      Top = 8
      Width = 39
      Height = 13
      Caption = 'Cliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbIdFuncionario: TLabel
      Left = 474
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
    object lbFuncionario: TLabel
      Left = 540
      Top = 8
      Width = 65
      Height = 13
      Caption = 'Funcion'#225'rio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbObservação: TLabel
      Left = 8
      Top = 92
      Width = 113
      Height = 13
      Caption = 'Detalhes / observa'#231#245'es'
    end
    object lbData: TLabel
      Left = 8
      Top = 48
      Width = 23
      Height = 13
      Caption = 'Data'
    end
    object lbHora: TLabel
      Left = 129
      Top = 48
      Width = 23
      Height = 13
      Caption = 'Hora'
    end
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
    object cBoxStatus: TComboBox
      Left = 251
      Top = 62
      Width = 142
      Height = 21
      Style = csDropDownList
      TabOrder = 7
    end
    object edtIdCliente: TEdit
      Left = 74
      Top = 22
      Width = 65
      Height = 21
      NumbersOnly = True
      TabOrder = 1
      OnExit = edtIdClienteExit
      OnKeyDown = edtIdClienteKeyDown
    end
    object edtCliente: TEdit
      Left = 140
      Top = 22
      Width = 333
      Height = 21
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 2
    end
    object edtIdFuncionario: TEdit
      Left = 474
      Top = 22
      Width = 65
      Height = 21
      NumbersOnly = True
      TabOrder = 3
      OnExit = edtIdFuncionarioExit
      OnKeyDown = edtIdFuncionarioKeyDown
    end
    object edtFuncionario: TEdit
      Left = 540
      Top = 22
      Width = 261
      Height = 21
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 4
    end
    object mmObservacao: TMemo
      Left = 8
      Top = 106
      Width = 793
      Height = 168
      Lines.Strings = (
        'mmObservacao')
      MaxLength = 1000
      ScrollBars = ssVertical
      TabOrder = 8
    end
    object dtpData: TDateTimePicker
      Left = 8
      Top = 62
      Width = 120
      Height = 21
      Date = 45015.000000000000000000
      Time = 0.553204305557301300
      TabOrder = 5
    end
    object dtpHora: TDateTimePicker
      Left = 129
      Top = 62
      Width = 120
      Height = 21
      Date = 45015.000000000000000000
      Time = 0.553204305557301300
      Kind = dtkTime
      TabOrder = 6
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
  end
end
