inherited ViewBaseBusca: TViewBaseBusca
  Caption = 'ViewBaseBusca'
  ClientHeight = 408
  ClientWidth = 866
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 882
  ExplicitHeight = 447
  PixelsPerInch = 96
  TextHeight = 13
  object pnTop: TPanel
    Left = 0
    Top = 0
    Width = 866
    Height = 49
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 0
    ExplicitWidth = 755
    DesignSize = (
      866
      49)
    object imgConfGrid: TImage
      Left = 835
      Top = 22
      Width = 25
      Height = 25
      Cursor = crHandPoint
      Anchors = [akTop, akRight]
      Center = True
      Proportional = True
      ExplicitLeft = 724
    end
    object pnBuscarComboBox: TPanel
      Left = 593
      Top = 1
      Width = 264
      Height = 47
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 2
      Visible = False
      object Label2: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 258
        Height = 13
        Align = alTop
        Caption = 'Selecione o conte'#250'do a ser consultado'
        ExplicitWidth = 184
      end
      object cBoxBusca: TComboBox
        AlignWithMargins = True
        Left = 3
        Top = 22
        Width = 258
        Height = 21
        Align = alClient
        Style = csDropDownList
        TabOrder = 0
        OnChange = cBoxBuscaChange
      end
    end
    object pnBuscarPeriodo: TPanel
      AlignWithMargins = True
      Left = 397
      Top = 1
      Width = 196
      Height = 47
      Margins.Left = 5
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      Visible = False
      object lbBuscaPeriodo: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 190
        Height = 13
        Align = alTop
        Caption = 'Entre com o per'#237'odo a ser consultado'
        ExplicitWidth = 178
      end
      object Label1: TLabel
        AlignWithMargins = True
        Left = 90
        Top = 22
        Width = 12
        Height = 22
        Align = alLeft
        Caption = ' '#224' '
        Layout = tlCenter
        ExplicitHeight = 13
      end
      object dtpPeriodoInicial: TDateTimePicker
        AlignWithMargins = True
        Left = 3
        Top = 22
        Width = 81
        Height = 22
        Align = alLeft
        Date = 45002.000000000000000000
        Time = 0.743960381943907100
        TabOrder = 0
        OnExit = dtpPeriodoInicialExit
        OnKeyPress = edtBuscaKeyPress
      end
      object dtpPeriodoFinal: TDateTimePicker
        AlignWithMargins = True
        Left = 108
        Top = 22
        Width = 81
        Height = 22
        Align = alLeft
        Date = 45002.000000000000000000
        Time = 0.743960381943907100
        TabOrder = 1
        OnExit = dtpPeriodoInicialExit
        OnKeyPress = edtBuscaKeyPress
      end
    end
    object pnBuscarConteudo: TPanel
      AlignWithMargins = True
      Left = 6
      Top = 1
      Width = 386
      Height = 47
      Margins.Left = 5
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 1
      object lbBusca: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 380
        Height = 13
        Align = alTop
        Caption = 'Entre com o conte'#250'do a ser consultado'
        ExplicitWidth = 187
      end
      object edtBusca: TEdit
        AlignWithMargins = True
        Left = 3
        Top = 22
        Width = 380
        Height = 21
        Align = alTop
        TabOrder = 0
        OnKeyPress = edtBuscaKeyPress
      end
    end
  end
  object pnBotton: TPanel
    Left = 0
    Top = 320
    Width = 866
    Height = 88
    Align = alBottom
    TabOrder = 1
    ExplicitWidth = 755
    DesignSize = (
      866
      88)
    object imgConfMenu: TImage
      Left = 835
      Top = 4
      Width = 25
      Height = 25
      Cursor = crHandPoint
      Anchors = [akTop, akRight]
      Center = True
      Proportional = True
      ExplicitLeft = 724
    end
    object pnButtons: TPanel
      Left = 551
      Top = 37
      Width = 310
      Height = 46
      Anchors = [akRight, akBottom]
      BevelOuter = bvNone
      Padding.Left = 5
      Padding.Top = 5
      Padding.Right = 5
      Padding.Bottom = 5
      TabOrder = 0
      ExplicitLeft = 440
      object btnCadastro: TButton
        Left = 5
        Top = 5
        Width = 100
        Height = 36
        Align = alRight
        Caption = 'Cadastrar'
        ImageIndex = 0
        ImageMargins.Left = 10
        Images = ModelSistemaImagensDM.imgListButtonsProperties
        TabOrder = 1
      end
      object btnVincular: TButton
        Left = 105
        Top = 5
        Width = 100
        Height = 36
        Align = alRight
        Caption = 'Vincular'
        ImageIndex = 7
        ImageMargins.Left = 10
        Images = ModelSistemaImagensDM.imgListButtonsProperties
        TabOrder = 0
        OnClick = btnVincularClick
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
        TabOrder = 2
        OnClick = btnFecharClick
      end
    end
    object gBoxTipoConsulta: TGroupBox
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 435
      Height = 80
      Align = alLeft
      Caption = '  Buscar  '
      TabOrder = 1
    end
    object ckBuscarInativos: TCheckBox
      Left = 445
      Top = 12
      Width = 60
      Height = 17
      Caption = 'Inativos'
      TabOrder = 2
      Visible = False
    end
  end
  object pnGrid: TPanel
    Left = 0
    Top = 49
    Width = 866
    Height = 271
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitWidth = 755
    object GridBusca: TDBGrid
      Left = 0
      Top = 0
      Width = 866
      Height = 255
      Align = alClient
      DataSource = DS_Busca
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      PopupMenu = MenuBusca
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDrawColumnCell = GridBuscaDrawColumnCell
      OnDblClick = GridBuscaDblClick
    end
    object pnOptions: TPanel
      Left = 0
      Top = 255
      Width = 866
      Height = 16
      Align = alBottom
      BevelOuter = bvLowered
      TabOrder = 1
      ExplicitWidth = 755
      object lbTotalRegistros: TLabel
        AlignWithMargins = True
        Left = 783
        Top = 1
        Width = 77
        Height = 14
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 5
        Margins.Bottom = 0
        Align = alRight
        Caption = 'lbTotalRegistros'
        ExplicitLeft = 672
        ExplicitHeight = 13
      end
    end
  end
  object DS_Busca: TDataSource
    Left = 48
    Top = 112
  end
  object TimerBuscar: TTimer
    Enabled = False
    Interval = 400
    OnTimer = TimerBuscarTimer
    Left = 672
    Top = 8
  end
  object MenuBusca: TPopupMenu
    Images = ModelSistemaImagensDM.imgPopupMenuBusca
    Left = 616
    Top = 8
    object Atualizar1: TMenuItem
      Caption = 'Atualizar - F5'
      ImageIndex = 0
      OnClick = Atualizar1Click
    end
    object AtivarInativar1: TMenuItem
      Tag = 999
      Caption = 'Ativar/Inativar'
      ImageIndex = 1
      Visible = False
      OnClick = AtivarInativar1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Excluir1: TMenuItem
      Tag = 999
      Caption = 'Excluir'
      ImageIndex = 2
      Visible = False
      OnClick = Excluir1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
  end
end
