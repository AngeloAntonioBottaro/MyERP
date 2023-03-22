inherited ViewBaseBusca: TViewBaseBusca
  Caption = 'ViewBaseBusca'
  ClientHeight = 408
  ClientWidth = 755
  OnClose = FormClose
  OnShow = FormShow
  ExplicitWidth = 771
  ExplicitHeight = 447
  PixelsPerInch = 96
  TextHeight = 13
  object pnTop: TPanel
    Left = 0
    Top = 0
    Width = 755
    Height = 49
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 0
    object pnBuscarPeriodo: TPanel
      AlignWithMargins = True
      Left = 397
      Top = 1
      Width = 230
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
        Width = 224
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
    Top = 288
    Width = 755
    Height = 120
    Align = alBottom
    TabOrder = 2
    DesignSize = (
      755
      120)
    object pnButtons: TPanel
      Left = 440
      Top = 69
      Width = 310
      Height = 46
      Anchors = [akRight, akBottom]
      BevelOuter = bvNone
      Padding.Left = 5
      Padding.Top = 5
      Padding.Right = 5
      Padding.Bottom = 5
      TabOrder = 0
      object btnCadastro: TButton
        Left = 5
        Top = 5
        Width = 100
        Height = 36
        Align = alRight
        Caption = 'Cadastrar'
        ImageIndex = 4
        ImageMargins.Left = 10
        Images = ModelSistemaImagensDM.imgListButtons
        TabOrder = 1
      end
      object btnVincular: TButton
        Left = 105
        Top = 5
        Width = 100
        Height = 36
        Align = alRight
        Caption = 'Vincular'
        ImageIndex = 11
        ImageMargins.Left = 10
        Images = ModelSistemaImagensDM.imgListButtons
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
        ImageIndex = 3
        ImageMargins.Left = 10
        Images = ModelSistemaImagensDM.imgListButtons
        TabOrder = 2
        OnClick = btnFecharClick
      end
    end
    object gBoxTipoConsulta: TGroupBox
      AlignWithMargins = True
      Left = 4
      Top = 20
      Width = 435
      Height = 96
      Align = alLeft
      Caption = '  Buscar  '
      TabOrder = 1
    end
    object pnOptions: TPanel
      Left = 1
      Top = 1
      Width = 753
      Height = 16
      Align = alTop
      BevelOuter = bvLowered
      TabOrder = 2
      object lbTotalRegistros: TLabel
        AlignWithMargins = True
        Left = 670
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
    object ckBuscarInativos: TCheckBox
      Left = 445
      Top = 31
      Width = 60
      Height = 17
      Caption = 'Inativos'
      TabOrder = 3
    end
  end
  object GridBusca: TDBGrid
    Left = 0
    Top = 49
    Width = 755
    Height = 239
    Align = alClient
    DataSource = DS_Busca
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    PopupMenu = PopupMenu
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDrawColumnCell = GridBuscaDrawColumnCell
    OnDblClick = GridBuscaDblClick
  end
  object DS_Busca: TDataSource
    Left = 48
    Top = 112
  end
  object TimerBuscar: TTimer
    Enabled = False
    Interval = 400
    OnTimer = TimerBuscarTimer
    Left = 704
    Top = 8
  end
  object PopupMenu: TPopupMenu
    Left = 616
    Top = 8
    object Atualizar1: TMenuItem
      Caption = 'Atualizar - F5'
      OnClick = Atualizar1Click
    end
    object AtivarInativar1: TMenuItem
      Caption = 'Ativar/Inativar'
      Visible = False
      OnClick = AtivarInativar1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Excluir1: TMenuItem
      Caption = 'Excluir'
      Visible = False
      OnClick = Excluir1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
  end
end
