inherited ViewProdutosCad: TViewProdutosCad
  Caption = 'Cadastro de produtos'
  ClientHeight = 222
  ClientWidth = 709
  ExplicitWidth = 725
  ExplicitHeight = 261
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnButtons: TPanel
    Top = 181
    Width = 709
    ExplicitTop = 181
    ExplicitWidth = 709
    inherited btnGravar: TButton
      OnClick = btnGravarClick
    end
    inherited btnExcluir: TButton
      OnClick = btnExcluirClick
    end
    inherited btnBuscar: TButton
      OnClick = btnBuscarClick
    end
    inherited btnAlterar: TButton
      OnClick = btnAlterarClick
    end
  end
  object pnTela: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 703
    Height = 175
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object lbId: TLabel
      Left = 8
      Top = 8
      Width = 38
      Height = 13
      Caption = 'C'#243'digo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbNome: TLabel
      Left = 74
      Top = 8
      Width = 27
      Height = 13
      Caption = 'Nome'
    end
    object lbCusto: TLabel
      Left = 247
      Top = 94
      Width = 28
      Height = 13
      Caption = 'Custo'
    end
    object lbDescricao: TLabel
      Left = 402
      Top = 8
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
    end
    object lbPorcLucroVista: TLabel
      Left = 338
      Top = 94
      Width = 77
      Height = 13
      Caption = 'Porc. lucro vista'
    end
    object lbPrecoVendaVista: TLabel
      Left = 429
      Top = 94
      Width = 62
      Height = 13
      Caption = 'Pre'#231'o '#224' vista'
    end
    object lbPorcLucroPrazo: TLabel
      Left = 520
      Top = 94
      Width = 81
      Height = 13
      Caption = 'Porc. lucro prazo'
    end
    object lbPrecoVendaPrazo: TLabel
      Left = 611
      Top = 94
      Width = 66
      Height = 13
      Caption = 'Pre'#231'o a prazo'
    end
    object lbIdSubgrupo: TLabel
      Left = 8
      Top = 52
      Width = 38
      Height = 13
      Caption = 'C'#243'digo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbGrupo: TLabel
      Left = 74
      Top = 52
      Width = 29
      Height = 13
      Caption = 'Grupo'
    end
    object lbSubGrupo: TLabel
      Left = 235
      Top = 52
      Width = 51
      Height = 13
      Caption = 'Sub-Grupo'
    end
    object lbEstoque: TLabel
      Left = 190
      Top = 134
      Width = 39
      Height = 13
      Caption = 'Estoque'
    end
    object lbCodBarras: TLabel
      Left = 8
      Top = 94
      Width = 82
      Height = 13
      Caption = 'C'#243'digo de barras'
    end
    object lbEstoqueMin: TLabel
      Left = 8
      Top = 134
      Width = 74
      Height = 13
      Caption = 'Estoque m'#237'nimo'
    end
    object lbEstoqueMax: TLabel
      Left = 99
      Top = 134
      Width = 78
      Height = 13
      Caption = 'Estoque m'#225'ximo'
    end
    object lbIdUnidade: TLabel
      Left = 402
      Top = 52
      Width = 38
      Height = 13
      Caption = 'C'#243'digo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbUnidadeDesc: TLabel
      Left = 468
      Top = 52
      Width = 39
      Height = 13
      Caption = 'Unidade'
    end
    object lbUnidadeSigla: TLabel
      Left = 643
      Top = 52
      Width = 22
      Height = 13
      Caption = 'Sigla'
    end
    object edtId: TEdit
      Left = 8
      Top = 22
      Width = 65
      Height = 21
      TabStop = False
      Alignment = taRightJustify
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object edtNome: TEdit
      Left = 74
      Top = 22
      Width = 327
      Height = 21
      TabOrder = 1
    end
    object edtDescricao: TEdit
      Left = 402
      Top = 22
      Width = 299
      Height = 21
      TabOrder = 2
    end
    object edtIdSubGrupo: TEdit
      Left = 8
      Top = 66
      Width = 65
      Height = 21
      TabStop = False
      Alignment = taRightJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      NumbersOnly = True
      ParentFont = False
      TabOrder = 3
      OnExit = edtIdSubGrupoExit
      OnKeyDown = edtIdSubGrupoKeyDown
    end
    object edtGrupo: TEdit
      Left = 74
      Top = 66
      Width = 160
      Height = 21
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 4
    end
    object edtSubGrupo: TEdit
      Left = 235
      Top = 66
      Width = 166
      Height = 21
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 5
    end
    object edtCodBarras: TEdit
      Left = 8
      Top = 108
      Width = 238
      Height = 21
      TabOrder = 9
    end
    object edtIdUnidade: TEdit
      Left = 402
      Top = 66
      Width = 65
      Height = 21
      TabStop = False
      Alignment = taRightJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      NumbersOnly = True
      ParentFont = False
      TabOrder = 6
      OnExit = edtIdUnidadeExit
      OnKeyDown = edtIdUnidadeKeyDown
    end
    object edtUnidadeNome: TEdit
      Left = 468
      Top = 66
      Width = 174
      Height = 21
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 7
    end
    object edtUnidadeSigla: TEdit
      Left = 643
      Top = 66
      Width = 58
      Height = 21
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 8
    end
    object edtCusto: TEdit
      Left = 247
      Top = 108
      Width = 90
      Height = 21
      NumbersOnly = True
      TabOrder = 10
    end
    object edtPorcLucroVista: TEdit
      Left = 338
      Top = 108
      Width = 90
      Height = 21
      NumbersOnly = True
      TabOrder = 11
    end
    object edtPrecoVendaVista: TEdit
      Left = 429
      Top = 108
      Width = 90
      Height = 21
      NumbersOnly = True
      TabOrder = 12
    end
    object edtPorcLucroPrazo: TEdit
      Left = 520
      Top = 108
      Width = 90
      Height = 21
      NumbersOnly = True
      TabOrder = 13
    end
    object edtPrecoVendaPrazo: TEdit
      Left = 611
      Top = 108
      Width = 90
      Height = 21
      NumbersOnly = True
      TabOrder = 14
    end
    object edtEstoqueMinimo: TEdit
      Left = 8
      Top = 148
      Width = 90
      Height = 21
      NumbersOnly = True
      TabOrder = 15
    end
    object edtEstoqueMaximo: TEdit
      Left = 99
      Top = 148
      Width = 90
      Height = 21
      NumbersOnly = True
      TabOrder = 16
    end
    object edtEstoque: TEdit
      Left = 190
      Top = 148
      Width = 90
      Height = 21
      Color = clBtnFace
      NumbersOnly = True
      ReadOnly = True
      TabOrder = 17
    end
  end
end
