inherited ViewProdutosUnidadesCad: TViewProdutosUnidadesCad
  Caption = 'Cadastro de unidades de produtos'
  ClientHeight = 98
  ClientWidth = 709
  ExplicitWidth = 725
  ExplicitHeight = 137
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnButtons: TPanel
    Top = 57
    Width = 709
    ExplicitTop = 57
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
    Height = 51
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
      Width = 82
      Height = 13
      Caption = 'Nome / descri'#231#227'o'
    end
    object lbSigla: TLabel
      Left = 570
      Top = 8
      Width = 27
      Height = 13
      Caption = 'Sigla'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
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
      Width = 495
      Height = 21
      TabOrder = 1
    end
    object edtSigla: TEdit
      Left = 570
      Top = 22
      Width = 131
      Height = 21
      TabOrder = 2
    end
  end
end
