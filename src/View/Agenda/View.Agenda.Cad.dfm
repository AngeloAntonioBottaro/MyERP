﻿inherited ViewAgendaCad: TViewAgendaCad
  Caption = 'Agenda de compromissos'
  ClientHeight = 253
  ExplicitHeight = 292
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnButtons: TPanel
    Top = 212
    ExplicitTop = 212
  end
  object pnTela: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 703
    Height = 206
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object lbStatus: TLabel
      Left = 251
      Top = 48
      Width = 41
      Height = 13
      Caption = 'Situa'#231#227'o'
    end
    object lbIdCliente: TLabel
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
    object lbCliente: TLabel
      Left = 74
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
      Left = 394
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
      Left = 460
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
    object cBoxStatus: TComboBox
      Left = 251
      Top = 62
      Width = 142
      Height = 21
      Style = csDropDownList
      TabOrder = 6
    end
    object edtIdCliente: TEdit
      Left = 8
      Top = 22
      Width = 65
      Height = 21
      NumbersOnly = True
      TabOrder = 0
      OnExit = edtIdClienteExit
      OnKeyDown = edtIdClienteKeyDown
    end
    object edtCliente: TEdit
      Left = 74
      Top = 22
      Width = 319
      Height = 21
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 1
    end
    object edtIdFuncionario: TEdit
      Left = 394
      Top = 22
      Width = 65
      Height = 21
      NumbersOnly = True
      TabOrder = 2
      OnExit = edtIdFuncionarioExit
      OnKeyDown = edtIdFuncionarioKeyDown
    end
    object edtFuncionario: TEdit
      Left = 460
      Top = 22
      Width = 241
      Height = 21
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 3
    end
    object mmObservacao: TMemo
      Left = 8
      Top = 106
      Width = 693
      Height = 89
      Lines.Strings = (
        'mmObservacao')
      ScrollBars = ssVertical
      TabOrder = 7
    end
    object DateTimePicker1: TDateTimePicker
      Left = 8
      Top = 62
      Width = 120
      Height = 21
      Date = 45015.000000000000000000
      Time = 0.553204305557301300
      TabOrder = 4
    end
    object DateTimePicker2: TDateTimePicker
      Left = 129
      Top = 62
      Width = 120
      Height = 21
      Date = 45015.000000000000000000
      Time = 0.553204305557301300
      Kind = dtkTime
      TabOrder = 5
    end
  end
end