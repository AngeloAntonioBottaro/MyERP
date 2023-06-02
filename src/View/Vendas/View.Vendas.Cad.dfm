inherited ViewVendasCad: TViewVendasCad
  Caption = 'Vendas'
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnButtons: TPanel
    inherited btnImprimir: TButton
      Visible = True
    end
  end
  object pnTela: TPanel
    Left = 0
    Top = 0
    Width = 808
    Height = 328
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object pnCabecalho: TPanel
      Left = 0
      Top = 0
      Width = 808
      Height = 49
      Align = alTop
      TabOrder = 0
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
      object lbDataVenda: TLabel
        Left = 74
        Top = 8
        Width = 56
        Height = 13
        Caption = 'Data venda'
      end
      object lbIdCliente: TLabel
        Left = 170
        Top = 8
        Width = 39
        Height = 13
        Caption = 'Cliente'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbNomeCliente: TLabel
        Left = 236
        Top = 8
        Width = 32
        Height = 13
        Caption = 'Nome'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbFormaPag: TLabel
        Left = 659
        Top = 8
        Width = 102
        Height = 13
        Caption = 'Forma de pagamento'
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
      object dtpDataVenda: TDateTimePicker
        Left = 74
        Top = 22
        Width = 95
        Height = 21
        Date = 44993.000000000000000000
        Time = 0.445778391200292400
        Color = clBtnFace
        Enabled = False
        TabOrder = 1
      end
      object edtIdCliente: TEdit
        Left = 170
        Top = 22
        Width = 65
        Height = 21
        NumbersOnly = True
        TabOrder = 2
        OnExit = edtIdClienteExit
        OnKeyDown = edtIdClienteKeyDown
      end
      object edtCliente: TEdit
        Left = 236
        Top = 22
        Width = 422
        Height = 21
        TabStop = False
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 3
      end
      object cBoxFormaPag: TComboBox
        Left = 659
        Top = 22
        Width = 145
        Height = 21
        Style = csDropDownList
        TabOrder = 4
        Items.Strings = (
          #193' Vista'
          'A Prazo')
      end
    end
    object pnFinalizacaoVenda: TPanel
      Left = 0
      Top = 279
      Width = 808
      Height = 49
      Align = alBottom
      TabOrder = 3
    end
    object pnItens: TPanel
      Left = 0
      Top = 49
      Width = 808
      Height = 49
      Align = alTop
      TabOrder = 1
      object lbIdProduto: TLabel
        Left = 8
        Top = 8
        Width = 45
        Height = 13
        Caption = 'Produto'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbProduto: TLabel
        Left = 74
        Top = 8
        Width = 32
        Height = 13
        Caption = 'Nome'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbQuantidade: TLabel
        Left = 391
        Top = 8
        Width = 56
        Height = 13
        Caption = 'Quantidade'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbPreco: TLabel
        Left = 457
        Top = 8
        Width = 27
        Height = 13
        Caption = 'Pre'#231'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbSubTotal: TLabel
        Left = 631
        Top = 8
        Width = 44
        Height = 13
        Caption = 'Sub-total'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbDesconto: TLabel
        Left = 544
        Top = 8
        Width = 61
        Height = 13
        Caption = 'Desconto R$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object edtIdProduto: TEdit
        Left = 8
        Top = 21
        Width = 65
        Height = 21
        NumbersOnly = True
        TabOrder = 0
        OnExit = edtIdProdutoExit
        OnKeyDown = edtIdProdutoKeyDown
      end
      object btnIncluirItem: TButton
        Left = 718
        Top = 16
        Width = 86
        Height = 27
        Caption = 'Incluir'
        ImageIndex = 2
        Images = ModelSistemaImagensDM.imgListButtons
        TabOrder = 6
        OnClick = btnIncluirItemClick
      end
      object edtQuantidade: TDBEdit
        Left = 391
        Top = 21
        Width = 65
        Height = 21
        DataField = 'QUANTIDADE'
        DataSource = DSItensVenda
        TabOrder = 2
        OnExit = edtQuantidadeExit
      end
      object edtPreco: TDBEdit
        Left = 457
        Top = 21
        Width = 86
        Height = 21
        DataField = 'PRECO'
        DataSource = DSItensVenda
        TabOrder = 3
        OnExit = edtQuantidadeExit
      end
      object edtDesconto: TDBEdit
        Left = 544
        Top = 21
        Width = 86
        Height = 21
        DataField = 'DESCONTO'
        DataSource = DSItensVenda
        TabOrder = 4
        OnExit = edtQuantidadeExit
      end
      object edtTotal: TDBEdit
        Left = 631
        Top = 21
        Width = 86
        Height = 21
        Color = clBtnFace
        DataField = 'TOTAL'
        DataSource = DSItensVenda
        ReadOnly = True
        TabOrder = 5
        OnExit = edtQuantidadeExit
      end
      object edtNomeProduto: TDBEdit
        Left = 74
        Top = 21
        Width = 316
        Height = 21
        Color = clBtnFace
        DataField = 'NOME_PRODUTO'
        DataSource = DSItensVenda
        ReadOnly = True
        TabOrder = 1
      end
    end
    object pnGrid: TPanel
      Left = 0
      Top = 98
      Width = 808
      Height = 181
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 2
      object GridItensVenda: TDBGrid
        Left = 0
        Top = 0
        Width = 785
        Height = 165
        Align = alClient
        DataSource = DSItensVenda
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'ID_PRODUTO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOME_PRODUTO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'UNIDADE_PRODUTO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'QUANTIDADE'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PRECO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESCONTO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TOTAL'
            Visible = True
          end>
      end
      object pnOptions: TPanel
        Left = 0
        Top = 165
        Width = 808
        Height = 16
        Align = alBottom
        BevelOuter = bvLowered
        TabOrder = 1
        object lbTotalRegistros: TLabel
          AlignWithMargins = True
          Left = 725
          Top = 1
          Width = 77
          Height = 14
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 5
          Margins.Bottom = 0
          Align = alRight
          Caption = 'lbTotalRegistros'
          ExplicitHeight = 13
        end
      end
      object pnConfGrid: TPanel
        Left = 785
        Top = 0
        Width = 23
        Height = 165
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 2
        object imgConfGrid: TImage
          Left = 0
          Top = 0
          Width = 23
          Height = 25
          Cursor = crHandPoint
          Align = alTop
          Center = True
          Proportional = True
          ExplicitLeft = -2
          ExplicitTop = 22
          ExplicitWidth = 25
        end
      end
    end
  end
  object DSItensVenda: TDataSource
    Left = 696
    Top = 138
  end
  object DSVenda: TDataSource
    Left = 696
    Top = 90
  end
end
