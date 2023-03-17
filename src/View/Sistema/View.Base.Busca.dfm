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
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 0
    object lbBusca: TLabel
      Left = 8
      Top = 8
      Width = 187
      Height = 13
      Caption = 'Entre com o conte'#250'do a ser consultado'
    end
    object edtBusca: TEdit
      Left = 8
      Top = 22
      Width = 321
      Height = 21
      TabOrder = 0
      OnKeyPress = edtBuscaKeyPress
    end
    object ckBuscarInativos: TCheckBox
      Left = 335
      Top = 26
      Width = 65
      Height = 17
      Caption = 'Inativos'
      TabOrder = 1
    end
  end
  object pnBotton: TPanel
    Left = 0
    Top = 288
    Width = 755
    Height = 120
    Align = alBottom
    TabOrder = 1
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
      ExplicitTop = 36
      object btnCadastro: TButton
        Left = 5
        Top = 5
        Width = 100
        Height = 36
        Align = alRight
        Caption = 'Cadastrar'
        TabOrder = 0
      end
      object btnVincular: TButton
        Left = 105
        Top = 5
        Width = 100
        Height = 36
        Align = alRight
        Caption = 'Vincular'
        TabOrder = 1
        OnClick = btnVincularClick
      end
      object btnFechar: TButton
        Left = 205
        Top = 5
        Width = 100
        Height = 36
        Align = alRight
        Caption = 'Fechar'
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
      ExplicitTop = 4
      ExplicitHeight = 79
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
        Height = 13
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 5
        Margins.Bottom = 0
        Align = alRight
        Caption = 'lbTotalRegistros'
      end
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
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDrawColumnCell = GridBuscaDrawColumnCell
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
  end
end
