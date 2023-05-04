inherited ViewSistemaSenhaAdm: TViewSistemaSenhaAdm
  Caption = 'Senha de administrador'
  ClientHeight = 98
  ClientWidth = 361
  OnShow = FormShow
  ExplicitWidth = 377
  ExplicitHeight = 137
  PixelsPerInch = 96
  TextHeight = 13
  object pnBotton: TPanel
    Left = 0
    Top = 57
    Width = 361
    Height = 41
    Align = alBottom
    Padding.Top = 3
    Padding.Bottom = 3
    TabOrder = 0
    ExplicitLeft = -551
    ExplicitTop = 96
    ExplicitWidth = 1041
    object btnCancelar: TButton
      Left = 260
      Top = 4
      Width = 100
      Height = 33
      Align = alRight
      Caption = 'Cancelar'
      ImageIndex = 0
      ImageMargins.Left = 10
      Images = ModelSistemaImagensDM.imgListButtons
      TabOrder = 1
      OnClick = btnCancelarClick
      ExplicitLeft = 940
    end
    object btnOk: TButton
      Left = 160
      Top = 4
      Width = 100
      Height = 33
      Align = alRight
      Caption = 'OK'
      ImageIndex = 7
      ImageMargins.Left = 10
      Images = ModelSistemaImagensDM.imgListButtons
      TabOrder = 0
      OnClick = btnOkClick
      ExplicitLeft = 840
    end
  end
  object pnTela: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 355
    Height = 51
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitLeft = -213
    ExplicitWidth = 703
    ExplicitHeight = 59
    object lbSenha: TLabel
      Left = 8
      Top = 8
      Width = 101
      Height = 13
      Caption = 'Senha administrativa'
    end
    object edtSenha: TEdit
      Left = 8
      Top = 22
      Width = 337
      Height = 21
      PasswordChar = '*'
      TabOrder = 0
    end
  end
end
