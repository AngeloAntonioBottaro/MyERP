inherited ViewCaixaCaixaDiario: TViewCaixaCaixaDiario
  Caption = 'Caixa di'#225'rio'
  ClientHeight = 427
  ClientWidth = 696
  ExplicitWidth = 712
  ExplicitHeight = 466
  PixelsPerInch = 96
  TextHeight = 13
  object pnGrid: TPanel
    Left = 0
    Top = 65
    Width = 696
    Height = 285
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object GridBusca: TDBGrid
      Left = 0
      Top = 0
      Width = 696
      Height = 269
      Align = alClient
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
    object pnRegistros: TPanel
      Left = 0
      Top = 269
      Width = 696
      Height = 16
      Align = alBottom
      BevelOuter = bvLowered
      TabOrder = 1
      object lbTotalRegistros: TLabel
        AlignWithMargins = True
        Left = 613
        Top = 1
        Width = 77
        Height = 14
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 5
        Margins.Bottom = 0
        Align = alRight
        Caption = 'lbTotalRegistros'
        ExplicitHeight = 13
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 696
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object lbDataCaixa: TLabel
      Left = 16
      Top = 4
      Width = 112
      Height = 19
      Caption = 'Data do caixa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object dtpDataCaixa: TDateTimePicker
      Left = 16
      Top = 26
      Width = 161
      Height = 31
      Date = 45051.000000000000000000
      Time = 0.567627905089466400
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 350
    Width = 696
    Height = 77
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object lbCredito: TLabel
      Left = 16
      Top = 6
      Width = 101
      Height = 19
      Caption = 'Cr'#233'dito.......:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      StyleElements = [seFont, seBorder]
    end
    object lbDebito: TLabel
      Left = 16
      Top = 27
      Width = 100
      Height = 19
      Caption = 'D'#233'bito........:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      StyleElements = [seFont, seBorder]
    end
    object lbTotal: TLabel
      Left = 16
      Top = 49
      Width = 100
      Height = 19
      Caption = 'Saldo total.:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      StyleElements = [seFont, seBorder]
    end
    object lbValorCredito: TLabel
      Left = 120
      Top = 6
      Width = 19
      Height = 19
      Caption = 'R$'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      StyleElements = [seFont, seBorder]
    end
    object lbValorDebito: TLabel
      Left = 120
      Top = 27
      Width = 19
      Height = 19
      Caption = 'R$'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      StyleElements = [seFont, seBorder]
    end
    object lbValorSaldo: TLabel
      Left = 120
      Top = 49
      Width = 19
      Height = 19
      Caption = 'R$'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      StyleElements = [seFont, seBorder]
    end
  end
end
