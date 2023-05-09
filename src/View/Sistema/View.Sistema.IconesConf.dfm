inherited ViewSistemaIconesConf: TViewSistemaIconesConf
  Caption = 'Configura'#231#227'o de '#237'cones'
  ClientHeight = 489
  ClientWidth = 1041
  OnShow = FormShow
  ExplicitWidth = 1057
  ExplicitHeight = 528
  PixelsPerInch = 96
  TextHeight = 13
  object pnTop: TPanel
    Left = 0
    Top = 0
    Width = 1041
    Height = 33
    Align = alTop
    TabOrder = 0
    object lbFuncionario: TLabel
      AlignWithMargins = True
      Left = 11
      Top = 4
      Width = 82
      Height = 16
      Margins.Left = 10
      Align = alLeft
      Alignment = taCenter
      Caption = 'Funcion'#225'rio: '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
    end
    object edtFuncionario: TEdit
      AlignWithMargins = True
      Left = 154
      Top = 6
      Width = 309
      Height = 21
      Margins.Left = 0
      Margins.Top = 5
      Margins.Bottom = 5
      TabStop = False
      Align = alLeft
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 1
    end
    object edtIdFuncionario: TEdit
      AlignWithMargins = True
      Left = 99
      Top = 6
      Width = 54
      Height = 21
      Margins.Top = 5
      Margins.Right = 1
      Margins.Bottom = 5
      Align = alLeft
      Alignment = taRightJustify
      NumbersOnly = True
      TabOrder = 0
      OnExit = edtIdFuncionarioExit
      OnKeyDown = edtIdFuncionarioKeyDown
    end
  end
  object pnBotton: TPanel
    Left = 0
    Top = 448
    Width = 1041
    Height = 41
    Align = alBottom
    Padding.Top = 3
    Padding.Bottom = 3
    TabOrder = 1
    object imgOptions: TImage
      AlignWithMargins = True
      Left = 244
      Top = 7
      Width = 24
      Height = 27
      Cursor = crHandPoint
      Align = alLeft
      Center = True
      ParentShowHint = False
      Picture.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D49484452000000300000
        003008060000005702F98700000006624B474400FF00FF00FFA0BDA793000002
        674944415478DAED97594EC3301086EDF78433B4BD152780A6EC2028FBBE0989
        3D4E4FC0B112CED0F8DD4C2AB50A4D9C7819132A655E52D1DAF37D76127E53B2
        E0459B0668059A0668059A0668055C4EDE61E383ECFA1D2C3D2E9C402F4C2F04
        25E79326825CC603FF626104F2F0B3468E24D005CAE05D4AA00A54C1BB924013
        50817721812290BD6D28A10F25938F88005E4A56E6BF13440C31DE4ED602B295
        07EEFBEFC03B9A0886FC9E52312C3447D8092B0115F8697518BFA3441C624B18
        0B54DCF37749E01F978D7121612460023FAD2E4B6FE17234FF7753096D01293C
        25B749DF3F51990353424B00037E2611A537F0B014764B574259A0E2B6B981DB
        E6B46C4C5D98839DB8864B415C474249400A2FC87532F0CFEAC65401D94AD40A
        D8C2AB0075C3F40A480ABBA8225129208387415771E09FEB8C71252115C08657
        01EAB1F4521072A633462EC0F803E49583B99F3F2581B76F0AAF02D465E327F8
        C5DE6F48FA1807DEB074AEAA46AA0FA22CCCC16A7E65DD61EC72F13B7998D339
        CD293DC4D955BAEDF2FF0D2C59F5D62682110FA1515F6727EAFA2A0BD4C955C2
        676B3F596E41BB23FE09CB1EE848A8948B3017267D6F7D063FAD4C22E21FF069
        8029811DE63E007EB3009F9760FC1DBAAE6149E0853941DEE10DB52585CF4B44
        FC0D3EAD6348A084394AC95BBCEA6DD7C2E725187F85EE1BB612D6610E26788D
        FBDE8E327C4EA237E22F42904D1B09AB30577674D42DDB539A799853387DA996
        CD01C728CC991C606A250C0F38DA61AE2A465B4B189C0D34C39C784E82A55D17
        F0D3EA44E3672AE8F66F48C7610EBBF2B1DA79987326F11761EE3F542BD074B5
        024D572BD074FD00927CD340FF06ECC70000000049454E44AE426082}
      PopupMenu = pMenuOptions
      Proportional = True
      ShowHint = False
      OnClick = imgOptionsClick
      ExplicitLeft = 201
      ExplicitTop = 4
      ExplicitHeight = 33
    end
    object btnMarcarTodos: TButton
      Tag = 1
      Left = 1
      Top = 4
      Width = 120
      Height = 33
      Align = alLeft
      Caption = 'Marcar todos'
      ImageIndex = 5
      ImageMargins.Left = 5
      Images = ModelSistemaImagensDM.imgListButtons
      TabOrder = 0
      OnClick = btnMarcarTodosClick
    end
    object btnDesmarcarTodos: TButton
      Tag = 2
      Left = 121
      Top = 4
      Width = 120
      Height = 33
      Align = alLeft
      Caption = 'Desmarcar todos'
      ImageIndex = 6
      ImageMargins.Left = 5
      Images = ModelSistemaImagensDM.imgListButtons
      TabOrder = 1
      OnClick = btnMarcarTodosClick
    end
    object btnFechar: TButton
      Left = 940
      Top = 4
      Width = 100
      Height = 33
      Align = alRight
      Caption = 'Fechar'
      ImageIndex = 0
      ImageMargins.Left = 10
      Images = ModelSistemaImagensDM.imgListButtons
      TabOrder = 2
      OnClick = btnFecharClick
    end
    object btnGravar: TButton
      Left = 840
      Top = 4
      Width = 100
      Height = 33
      Align = alRight
      Caption = 'Gravar'
      ImageIndex = 2
      ImageMargins.Left = 10
      Images = ModelSistemaImagensDM.imgListButtonsProperties
      TabOrder = 3
      OnClick = btnGravarClick
    end
  end
  object pMenuOptions: TPopupMenu
    Left = 24
    Top = 48
    object MarcarIconesPadroes1: TMenuItem
      Caption = 'Marcar '#237'cones padr'#245'es'
      ImageIndex = 20
      OnClick = MarcarIconesPadroes1Click
    end
  end
end
