inherited ViewSistemaMenuConf: TViewSistemaMenuConf
  Caption = 'Configura'#231#227'o de menu'
  ClientHeight = 420
  ClientWidth = 525
  OnClose = FormClose
  OnShow = FormShow
  ExplicitWidth = 541
  ExplicitHeight = 459
  PixelsPerInch = 96
  TextHeight = 13
  object ckList: TCheckListBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 519
    Height = 354
    Align = alClient
    ItemHeight = 13
    TabOrder = 0
    ExplicitWidth = 378
    ExplicitHeight = 348
  end
  object pnButtons: TPanel
    Left = 0
    Top = 379
    Width = 525
    Height = 41
    Align = alBottom
    Padding.Left = 3
    Padding.Top = 3
    Padding.Right = 3
    Padding.Bottom = 3
    TabOrder = 1
    ExplicitTop = 354
    ExplicitWidth = 384
    object btnGravar: TButton
      Left = 321
      Top = 4
      Width = 100
      Height = 33
      Align = alRight
      Caption = 'Gravar'
      ImageIndex = 2
      ImageMargins.Left = 10
      Images = ModelSistemaImagensDM.imgListButtonsProperties
      TabOrder = 0
      OnClick = btnGravarClick
      ExplicitLeft = 180
    end
    object btnFechar: TButton
      Left = 421
      Top = 4
      Width = 100
      Height = 33
      Align = alRight
      Caption = 'Fechar'
      ImageIndex = 0
      ImageMargins.Left = 10
      Images = ModelSistemaImagensDM.imgListButtons
      TabOrder = 1
      OnClick = btnFecharClick
      ExplicitLeft = 280
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 360
    Width = 525
    Height = 19
    Panels = <
      item
        Width = 200
      end
      item
        Width = 400
      end>
    ExplicitLeft = 272
    ExplicitTop = 248
    ExplicitWidth = 0
  end
end
