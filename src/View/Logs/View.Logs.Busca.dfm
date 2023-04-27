inherited ViewLogsBusca: TViewLogsBusca
  Caption = 'Consulta de logs'
  ClientHeight = 520
  ClientWidth = 1083
  OnDestroy = FormDestroy
  ExplicitWidth = 1099
  ExplicitHeight = 559
  PixelsPerInch = 96
  TextHeight = 13
  object pnGrid: TPanel
    Left = 0
    Top = 163
    Width = 1083
    Height = 292
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object GridBusca: TDBGrid
      Left = 0
      Top = 0
      Width = 1083
      Height = 232
      Align = alClient
      DataSource = DS_Busca
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnTitleClick = GridBuscaTitleClick
      Columns = <
        item
          Expanded = False
          FieldName = 'DATA'
          Title.Caption = 'Data'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'HORA'
          Title.Caption = 'Hora'
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ID_FUNCIONARIO'
          Title.Caption = 'C'#243'd. func.'
          Width = 58
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FUNCIONARIO'
          Title.Caption = 'Funcion'#225'rio'
          Width = 139
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MODULO'
          Title.Caption = 'M'#243'dulo'
          Width = 152
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ACAO'
          Title.Caption = 'A'#231#227'o'
          Width = 141
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'REFERENCIA'
          Title.Caption = 'C'#243'd. ref.'
          Width = 48
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCRICAO'
          Title.Caption = 'Descri'#231#227'o'
          Width = 465
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ID'
          Title.Caption = 'C'#243'digo'
          Visible = True
        end>
    end
    object DBMemo1: TDBMemo
      Left = 0
      Top = 232
      Width = 1083
      Height = 60
      Align = alBottom
      DataField = 'DESCRICAO'
      DataSource = DS_Busca
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 1
    end
  end
  object pnBotton: TPanel
    Left = 0
    Top = 455
    Width = 1083
    Height = 65
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      1083
      65)
    object pnButtons: TPanel
      Left = 768
      Top = 14
      Width = 310
      Height = 46
      Anchors = [akRight, akBottom]
      BevelOuter = bvNone
      Padding.Left = 5
      Padding.Top = 5
      Padding.Right = 5
      Padding.Bottom = 5
      TabOrder = 0
      object btnImprimir: TButton
        Left = 105
        Top = 5
        Width = 100
        Height = 36
        Align = alRight
        Caption = 'Imprimir'
        ImageIndex = 8
        ImageMargins.Left = 10
        Images = ModelSistemaImagensDM.imgListButtonsProperties
        TabOrder = 0
      end
      object btnFechar: TButton
        Left = 205
        Top = 5
        Width = 100
        Height = 36
        Align = alRight
        Caption = 'Fechar'
        ImageIndex = 0
        ImageMargins.Left = 10
        Images = ModelSistemaImagensDM.imgListButtons
        TabOrder = 1
        OnClick = btnFecharClick
      end
    end
    object pnOptions: TPanel
      Left = 1
      Top = 1
      Width = 1081
      Height = 16
      Align = alTop
      BevelOuter = bvLowered
      TabOrder = 1
      object lbTotalRegistros: TLabel
        AlignWithMargins = True
        Left = 998
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
    Width = 1083
    Height = 163
    Align = alTop
    TabOrder = 2
    DesignSize = (
      1083
      163)
    object imgConfGrid: TImage
      Left = 1055
      Top = 137
      Width = 25
      Height = 25
      Cursor = crHandPoint
      Center = True
      Proportional = True
    end
    object gBoxTipoConsulta: TGroupBox
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 437
      Height = 155
      Align = alLeft
      Caption = '  Buscar  '
      TabOrder = 0
      object pnBuscaModulo: TPanel
        AlignWithMargins = True
        Left = 89
        Top = 67
        Width = 347
        Height = 27
        Margins.Left = 5
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        BevelOuter = bvNone
        TabOrder = 0
        object edtModulo: TEdit
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 246
          Height = 21
          Align = alLeft
          TabOrder = 0
        end
        object cBoxModulo: TComboBox
          AlignWithMargins = True
          Left = 252
          Top = 3
          Width = 74
          Height = 21
          Margins.Left = 0
          Align = alLeft
          Style = csDropDownList
          TabOrder = 1
          Items.Strings = (
            'Cont'#234'm'
            'Igual'
            'Diferente')
        end
      end
      object pnBuscaPeriodo: TPanel
        AlignWithMargins = True
        Left = 92
        Top = 13
        Width = 232
        Height = 22
        Margins.Left = 5
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        BevelOuter = bvNone
        TabOrder = 1
        Visible = False
        object Label1: TLabel
          AlignWithMargins = True
          Left = 84
          Top = 3
          Width = 12
          Height = 16
          Align = alLeft
          Caption = ' '#224' '
          Layout = tlCenter
          ExplicitHeight = 13
        end
        object dtpPeriodoInicial: TDateTimePicker
          Left = 0
          Top = 0
          Width = 81
          Height = 22
          Align = alLeft
          Date = 45002.000000000000000000
          Time = 0.743960381943907100
          TabOrder = 0
        end
        object dtpPeriodoFinal: TDateTimePicker
          Left = 99
          Top = 0
          Width = 81
          Height = 22
          Align = alLeft
          Date = 45002.000000000000000000
          Time = 0.743960381943907100
          TabOrder = 1
        end
      end
      object pnBuscaFuncionario: TPanel
        AlignWithMargins = True
        Left = 89
        Top = 38
        Width = 347
        Height = 27
        Margins.Left = 5
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        BevelOuter = bvNone
        TabOrder = 2
        object edtFuncionario: TEdit
          AlignWithMargins = True
          Left = 54
          Top = 3
          Width = 275
          Height = 21
          Margins.Left = 0
          Align = alLeft
          Color = clBtnFace
          ReadOnly = True
          TabOrder = 0
        end
        object edtIdFuncionario: TEdit
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 50
          Height = 21
          Margins.Right = 1
          Align = alLeft
          NumbersOnly = True
          TabOrder = 1
          OnExit = edtIdFuncionarioExit
          OnKeyDown = edtIdFuncionarioKeyDown
        end
      end
      object ckBuscaPeriodo: TCheckBox
        Left = 8
        Top = 16
        Width = 57
        Height = 17
        Caption = 'Per'#237'odo'
        TabOrder = 3
        OnClick = ckBuscaPeriodoClick
      end
      object ckBuscaFuncionario: TCheckBox
        Left = 8
        Top = 44
        Width = 77
        Height = 17
        Caption = 'Funcion'#225'rio'
        TabOrder = 4
        OnClick = ckBuscaPeriodoClick
      end
      object ckBuscaModulo: TCheckBox
        Left = 8
        Top = 73
        Width = 57
        Height = 17
        Caption = 'M'#243'dulo'
        TabOrder = 5
        OnClick = ckBuscaPeriodoClick
      end
      object ckBuscaAcao: TCheckBox
        Left = 8
        Top = 101
        Width = 49
        Height = 17
        Caption = 'A'#231#227'o'
        TabOrder = 6
        OnClick = ckBuscaPeriodoClick
      end
      object ckBuscaReferencia: TCheckBox
        Left = 8
        Top = 130
        Width = 73
        Height = 17
        Caption = 'Refer'#234'ncia'
        TabOrder = 7
        OnClick = ckBuscaPeriodoClick
      end
      object pnBuscaAcao: TPanel
        AlignWithMargins = True
        Left = 89
        Top = 95
        Width = 347
        Height = 27
        Margins.Left = 5
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        BevelOuter = bvNone
        TabOrder = 8
        object edtAcao: TEdit
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 246
          Height = 21
          Align = alLeft
          TabOrder = 0
        end
        object cBoxAcao: TComboBox
          AlignWithMargins = True
          Left = 252
          Top = 3
          Width = 74
          Height = 21
          Margins.Left = 0
          Align = alLeft
          Style = csDropDownList
          TabOrder = 1
          Items.Strings = (
            'Cont'#234'm'
            'Igual'
            'Diferente')
        end
      end
      object pnBuscaReferencia: TPanel
        AlignWithMargins = True
        Left = 89
        Top = 124
        Width = 347
        Height = 27
        Margins.Left = 5
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        BevelOuter = bvNone
        TabOrder = 9
        object edtReferencia: TEdit
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 326
          Height = 21
          Align = alLeft
          NumbersOnly = True
          TabOrder = 0
        end
      end
    end
    object Panel2: TPanel
      Left = 443
      Top = 118
      Width = 116
      Height = 46
      Anchors = [akRight, akBottom]
      BevelOuter = bvNone
      Padding.Left = 5
      Padding.Top = 5
      Padding.Right = 5
      Padding.Bottom = 5
      TabOrder = 1
      object btnBuscar: TButton
        Left = 11
        Top = 5
        Width = 100
        Height = 36
        Align = alRight
        Caption = 'Consultar'
        ImageIndex = 5
        ImageMargins.Left = 10
        Images = ModelSistemaImagensDM.imgListButtonsProperties
        TabOrder = 0
        OnClick = btnBuscarClick
      end
    end
  end
  object DS_Busca: TDataSource
    Left = 24
    Top = 208
  end
end
