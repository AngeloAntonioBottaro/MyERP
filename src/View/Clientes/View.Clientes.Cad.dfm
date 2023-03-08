inherited ViewClientesCad: TViewClientesCad
  Caption = 'Cadastro de clientes'
  ClientHeight = 261
  ClientWidth = 609
  ExplicitWidth = 625
  ExplicitHeight = 300
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnButtons: TPanel
    Top = 220
    Width = 609
    ExplicitTop = 220
    ExplicitWidth = 609
    inherited btnNovo: TButton
      OnClick = btnNovoClick
    end
    inherited btnGravar: TButton
      OnClick = btnGravarClick
    end
  end
  object pnTela: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 603
    Height = 214
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
    object lbRazaoSocial: TLabel
      Left = 74
      Top = 8
      Width = 59
      Height = 13
      Caption = 'Raz'#227'o social'
    end
    object lbNomeFantasia: TLabel
      Left = 362
      Top = 8
      Width = 69
      Height = 13
      Caption = 'Nome fantasia'
    end
    object lbTelefone: TLabel
      Left = 8
      Top = 131
      Width = 42
      Height = 13
      Caption = 'Telefone'
    end
    object lbTelefone2: TLabel
      Left = 106
      Top = 131
      Width = 51
      Height = 13
      Caption = 'Telefone 2'
    end
    object lbEndereco: TLabel
      Left = 8
      Top = 49
      Width = 45
      Height = 13
      Caption = 'Endere'#231'o'
    end
    object lbBairro: TLabel
      Left = 387
      Top = 49
      Width = 28
      Height = 13
      Caption = 'Bairro'
    end
    object lbCEP: TLabel
      Left = 8
      Top = 90
      Width = 19
      Height = 13
      Caption = 'CEP'
    end
    object lbIdCidade: TLabel
      Left = 74
      Top = 90
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
    end
    object Label1: TLabel
      Left = 330
      Top = 90
      Width = 13
      Height = 13
      Caption = 'UF'
    end
    object lbCPF: TLabel
      Left = 343
      Top = 172
      Width = 19
      Height = 13
      Caption = 'CPF'
    end
    object lbRG: TLabel
      Left = 441
      Top = 172
      Width = 14
      Height = 13
      Caption = 'RG'
    end
    object lbTipoJuridico: TLabel
      Left = 8
      Top = 172
      Width = 57
      Height = 13
      Caption = 'Tipo jur'#237'dico'
    end
    object lbNomeCidade: TLabel
      Left = 140
      Top = 90
      Width = 33
      Height = 13
      Caption = 'Cidade'
    end
    object lbCNPJ: TLabel
      Left = 118
      Top = 172
      Width = 25
      Height = 13
      Caption = 'CNPJ'
    end
    object lbIE: TLabel
      Left = 232
      Top = 172
      Width = 87
      Height = 13
      Caption = 'Inscri'#231#227'o estadual'
    end
    object lbNumero: TLabel
      Left = 304
      Top = 49
      Width = 37
      Height = 13
      Caption = 'N'#250'mero'
    end
    object lbDataNascimento: TLabel
      Left = 387
      Top = 90
      Width = 80
      Height = 13
      Caption = 'Data nascimento'
    end
    object lbIdade: TLabel
      Left = 489
      Top = 90
      Width = 28
      Height = 13
      Caption = 'Idade'
    end
    object lbCelular: TLabel
      Left = 204
      Top = 131
      Width = 33
      Height = 13
      Caption = 'Celular'
    end
    object lbFax: TLabel
      Left = 302
      Top = 131
      Width = 18
      Height = 13
      Caption = 'Fax'
    end
    object lbEmail: TLabel
      Left = 400
      Top = 131
      Width = 28
      Height = 13
      Caption = 'E-mail'
    end
    object Label2: TLabel
      Left = 529
      Top = 172
      Width = 69
      Height = 13
      Caption = 'Org'#227'o emissor'
    end
    object cBoxTipoJuridico: TComboBox
      Left = 8
      Top = 186
      Width = 109
      Height = 21
      Style = csDropDownList
      TabOrder = 17
      Items.Strings = (
        'Pessoa f'#237'sica'
        'Pessoa Jur'#237'dica')
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
    object edtRazaoSocial: TEdit
      Left = 74
      Top = 22
      Width = 287
      Height = 21
      TabOrder = 1
    end
    object edtNomeFantasia: TEdit
      Left = 362
      Top = 22
      Width = 239
      Height = 21
      TabOrder = 2
    end
    object edtEndereco: TEdit
      Left = 8
      Top = 63
      Width = 295
      Height = 21
      TabOrder = 3
    end
    object edtBairro: TEdit
      Left = 387
      Top = 63
      Width = 214
      Height = 21
      TabOrder = 5
    end
    object edtNumero: TEdit
      Left = 304
      Top = 63
      Width = 82
      Height = 21
      TabOrder = 4
    end
    object edtCep: TEdit
      Left = 8
      Top = 104
      Width = 65
      Height = 21
      TabOrder = 6
    end
    object edtIdCidade: TEdit
      Left = 74
      Top = 104
      Width = 65
      Height = 21
      TabOrder = 7
    end
    object edtCidade: TEdit
      Left = 140
      Top = 104
      Width = 189
      Height = 21
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 8
    end
    object edtUF: TEdit
      Left = 330
      Top = 104
      Width = 56
      Height = 21
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 9
    end
    object edtTelefone: TEdit
      Left = 8
      Top = 145
      Width = 97
      Height = 21
      TabOrder = 12
    end
    object edtTelefone2: TEdit
      Left = 106
      Top = 145
      Width = 97
      Height = 21
      TabOrder = 13
    end
    object dtpDataNascimento: TDateTimePicker
      Left = 387
      Top = 104
      Width = 101
      Height = 21
      Date = 44993.000000000000000000
      Time = 0.445778391200292400
      TabOrder = 10
    end
    object edtIdade: TEdit
      Left = 489
      Top = 104
      Width = 112
      Height = 21
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 11
    end
    object edtCelular: TEdit
      Left = 204
      Top = 145
      Width = 97
      Height = 21
      TabOrder = 14
    end
    object edtFax: TEdit
      Left = 302
      Top = 145
      Width = 97
      Height = 21
      TabOrder = 15
    end
    object edtEmail: TEdit
      Left = 400
      Top = 145
      Width = 201
      Height = 21
      TabOrder = 16
    end
    object edtCPF: TEdit
      Left = 343
      Top = 186
      Width = 97
      Height = 21
      TabOrder = 20
      OnExit = edtCPFExit
    end
    object edtRG: TEdit
      Left = 441
      Top = 186
      Width = 87
      Height = 21
      TabOrder = 21
    end
    object edtCNPJ: TEdit
      Left = 118
      Top = 186
      Width = 113
      Height = 21
      TabOrder = 18
    end
    object edtIE: TEdit
      Left = 232
      Top = 186
      Width = 110
      Height = 21
      TabOrder = 19
    end
    object edtRGOrgaoExpedidor: TEdit
      Left = 529
      Top = 186
      Width = 72
      Height = 21
      TabOrder = 22
    end
  end
end
