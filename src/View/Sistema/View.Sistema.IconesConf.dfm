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
      Height = 25
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
      ExplicitHeight = 16
    end
    object edtFuncionario: TEdit
      AlignWithMargins = True
      Left = 156
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
    ExplicitLeft = 8
    object imgOptions: TImage
      Left = 201
      Top = 4
      Width = 24
      Height = 33
      Align = alLeft
      Center = True
      Picture.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D49484452000000300000
        003008060000005702F98700000006624B474400FF00FF00FFA0BDA793000001
        D14944415478DAEDD65D4AC3401007F099F8103D9105AB52A8602FE1C7499A9C
        44EB25145AA88A423D51ED8359475BD0E66B776726DD14327909A4CDFE7FB390
        1D843D2F0C1DA003840ED0014207E800A103B41660E6473D38C8C660E88AA214
        4F971F7B0130F3C3214426A1DB93DCA377C830C1C1E7AC95809AE0F952858801
        1EC11B81B00182E0AA106F806270158833A0C1E0228815B0C3E02C4825E0DF77
        FC92B7BE5950809456A0CB8C69A96326E4B1EE1C2900C41D4798C1172D3858BE
        E51AD2DF3464C88494EE4811F0121BDEFBD71DC7C1EAA9F657CFF148B22378BE
        DACA2C075474DCCA65EE881E80195C0A9103948273217C80677073073DFACFF8
        E7162248F10A9CA6511BC41FE01B7C420B1B48A06C1A4548F01A9C0EA82A883B
        402F78BE44103BE0359E36145C058267AB8B5A806B09828B20F9F29F46F582AB
        40DCA7D1E6828B20F6697477C15990EA69F4EF3BCE9C466141F094CE00848CDE
        83209846ABCF91E25748DEF1D966C1ED69F401FABF10104CA3253B5204DC0373
        1A5D771C6FA17E1A9DC048B22378039673C01F50DA715B71774413C00A2E8568
        0054827321124023C17D211CC04E82BB427C004182DB202E80691B82574108A0
        338DB6A53A40E8EA00A1AB0384AEBD077C03714F50403024CFAD000000004945
        4E44AE426082}
      Proportional = True
      OnClick = imgOptionsClick
    end
    object btnMarcarTodos: TButton
      Tag = 1
      Left = 1
      Top = 4
      Width = 100
      Height = 33
      Align = alLeft
      Caption = 'Marcar todos'
      TabOrder = 0
      OnClick = btnMarcarTodosClick
    end
    object btnDesmarcarTodos: TButton
      Tag = 2
      Left = 101
      Top = 4
      Width = 100
      Height = 33
      Align = alLeft
      Caption = 'Desmarcar todos'
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
      ImageIndex = 3
      ImageMargins.Left = 10
      Images = ModelSistemaImagensDM.imgListButtons
      TabOrder = 2
      OnClick = btnFecharClick
      ExplicitLeft = 604
    end
    object btnGravar: TButton
      Left = 840
      Top = 4
      Width = 100
      Height = 33
      Align = alRight
      Caption = 'Gravar'
      ImageIndex = 6
      ImageMargins.Left = 10
      Images = ModelSistemaImagensDM.imgListButtons
      TabOrder = 3
      ExplicitLeft = 104
    end
  end
end
