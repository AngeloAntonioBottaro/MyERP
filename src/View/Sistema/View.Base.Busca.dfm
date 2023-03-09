inherited ViewBaseBusca: TViewBaseBusca
  Caption = 'ViewBaseBusca'
  ClientHeight = 373
  ClientWidth = 755
  OnClose = FormClose
  ExplicitWidth = 771
  ExplicitHeight = 412
  PixelsPerInch = 96
  TextHeight = 13
  object pnTop: TPanel
    Left = 0
    Top = 0
    Width = 755
    Height = 65
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 0
    ExplicitLeft = 24
    ExplicitTop = -6
    ExplicitWidth = 836
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
      Width = 297
      Height = 21
      TabOrder = 0
    end
  end
  object pnBotton: TPanel
    Left = 0
    Top = 286
    Width = 755
    Height = 87
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 336
    ExplicitWidth = 836
    DesignSize = (
      755
      87)
    object pnButtons: TPanel
      Left = 541
      Top = 36
      Width = 209
      Height = 46
      Anchors = [akRight, akBottom]
      BevelOuter = bvNone
      Padding.Left = 5
      Padding.Top = 5
      Padding.Right = 5
      Padding.Bottom = 5
      TabOrder = 0
      ExplicitLeft = 626
      object btnCadastro: TButton
        Left = 4
        Top = 5
        Width = 100
        Height = 36
        Align = alRight
        Caption = 'Cadastrar'
        TabOrder = 0
        ExplicitLeft = 85
        ExplicitTop = 4
        ExplicitHeight = 33
      end
      object btnVincular: TButton
        Left = 104
        Top = 5
        Width = 100
        Height = 36
        Align = alRight
        Caption = 'Vincular'
        TabOrder = 1
        ExplicitLeft = 85
        ExplicitTop = 8
        ExplicitHeight = 33
      end
    end
  end
  object GridBusca: TDBGrid
    Left = 0
    Top = 65
    Width = 755
    Height = 221
    Align = alClient
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDrawColumnCell = GridBuscaDrawColumnCell
  end
end
