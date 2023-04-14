inherited ViewSistemaMenuConf: TViewSistemaMenuConf
  Caption = 'configura'#231#227'o de menu'
  ClientHeight = 395
  ClientWidth = 384
  OnClose = FormClose
  OnShow = FormShow
  ExplicitWidth = 400
  ExplicitHeight = 434
  PixelsPerInch = 96
  TextHeight = 13
  object ckList: TCheckListBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 378
    Height = 348
    Align = alClient
    ItemHeight = 13
    TabOrder = 0
  end
  object pnButtons: TPanel
    Left = 0
    Top = 354
    Width = 384
    Height = 41
    Align = alBottom
    Padding.Left = 3
    Padding.Top = 3
    Padding.Right = 3
    Padding.Bottom = 3
    TabOrder = 1
    object btnGravar: TButton
      Left = 180
      Top = 4
      Width = 100
      Height = 33
      Align = alRight
      Caption = 'Gravar'
      ImageIndex = 6
      ImageMargins.Left = 10
      Images = ModelSistemaImagensDM.imgListButtons
      TabOrder = 0
      OnClick = btnGravarClick
      ExplicitLeft = 4
    end
    object btnFechar: TButton
      Left = 280
      Top = 4
      Width = 100
      Height = 33
      Align = alRight
      Caption = 'Fechar'
      ImageIndex = 3
      ImageMargins.Left = 10
      Images = ModelSistemaImagensDM.imgListButtons
      TabOrder = 1
      OnClick = btnFecharClick
      ExplicitLeft = 204
    end
  end
end
