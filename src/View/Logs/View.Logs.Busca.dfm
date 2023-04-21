inherited ViewLogsBusca: TViewLogsBusca
  Caption = 'Consulta de logs'
  ClientHeight = 520
  ClientWidth = 1083
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
      Height = 292
      Align = alClient
      DataSource = DS_Busca
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'DATA_HORA'
          Title.Caption = 'Data'
          Width = 97
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
          Width = 119
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ACAO'
          Title.Caption = 'A'#231#227'o'
          Width = 102
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'REFERENCIA'
          Title.Caption = 'C'#243'd. refer'#234'ncia'
          Width = 79
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
        ImageIndex = 12
        ImageMargins.Left = 10
        Images = ModelSistemaImagensDM.imgListButtons
        TabOrder = 0
      end
      object btnFechar: TButton
        Left = 205
        Top = 5
        Width = 100
        Height = 36
        Align = alRight
        Caption = 'Fechar'
        ImageIndex = 3
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
        object edtBusca: TEdit
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 246
          Height = 21
          Align = alLeft
          TabOrder = 0
        end
        object cBoxBusca: TComboBox
          AlignWithMargins = True
          Left = 255
          Top = 3
          Width = 74
          Height = 21
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
        object Edit1: TEdit
          AlignWithMargins = True
          Left = 59
          Top = 3
          Width = 270
          Height = 21
          Align = alLeft
          Color = clBtnFace
          ReadOnly = True
          TabOrder = 0
        end
        object Edit2: TEdit
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 50
          Height = 21
          Align = alLeft
          NumbersOnly = True
          TabOrder = 1
        end
      end
      object ckBuscaPeriodo: TCheckBox
        Left = 16
        Top = 16
        Width = 57
        Height = 17
        Caption = 'Per'#237'odo'
        TabOrder = 3
        OnClick = ckBuscaPeriodoClick
      end
      object ckBuscaFuncionario: TCheckBox
        Left = 16
        Top = 44
        Width = 73
        Height = 17
        Caption = 'Funcion'#225'rio'
        TabOrder = 4
        OnClick = ckBuscaPeriodoClick
      end
      object ckBuscaModulo: TCheckBox
        Left = 16
        Top = 73
        Width = 57
        Height = 17
        Caption = 'M'#243'dulo'
        TabOrder = 5
        OnClick = ckBuscaPeriodoClick
      end
      object ckBuscaAcao: TCheckBox
        Left = 16
        Top = 101
        Width = 49
        Height = 17
        Caption = 'A'#231#227'o'
        TabOrder = 6
        OnClick = ckBuscaPeriodoClick
      end
      object ckBuscaReferencia: TCheckBox
        Left = 16
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
        object Edit3: TEdit
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 246
          Height = 21
          Align = alLeft
          TabOrder = 0
        end
        object ComboBox1: TComboBox
          AlignWithMargins = True
          Left = 255
          Top = 3
          Width = 74
          Height = 21
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
        object Edit5: TEdit
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
      Left = 917
      Top = 118
      Width = 161
      Height = 46
      Anchors = [akRight, akBottom]
      BevelOuter = bvNone
      Padding.Left = 5
      Padding.Top = 5
      Padding.Right = 5
      Padding.Bottom = 5
      TabOrder = 1
      object btnBuscar: TButton
        Left = 56
        Top = 5
        Width = 100
        Height = 36
        Align = alRight
        Caption = 'Consultar'
        ImageIndex = 9
        ImageMargins.Left = 10
        Images = ModelSistemaImagensDM.imgListButtons
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
