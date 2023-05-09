inherited ViewPermissoesGruposCad: TViewPermissoesGruposCad
  Caption = 'Cadastro de grupos de permiss'#245'es'
  ClientHeight = 96
  ClientWidth = 712
  ExplicitWidth = 728
  ExplicitHeight = 135
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnButtons: TPanel
    Top = 55
    Width = 712
    ExplicitTop = 55
    ExplicitWidth = 712
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
    Width = 706
    Height = 49
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitWidth = 703
    ExplicitHeight = 59
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
    object lbGrupo: TLabel
      Left = 74
      Top = 8
      Width = 29
      Height = 13
      Caption = 'Grupo'
    end
    object lbDescricao: TLabel
      Left = 314
      Top = 8
      Width = 46
      Height = 13
      Caption = 'Descricao'
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
      Width = 239
      Height = 21
      TabOrder = 1
    end
    object edtDescricao: TEdit
      Left = 314
      Top = 22
      Width = 387
      Height = 21
      TabOrder = 2
    end
  end
end
