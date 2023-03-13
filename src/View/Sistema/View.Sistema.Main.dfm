object ViewSistemaMain: TViewSistemaMain
  Tag = 20
  Left = 0
  Top = 0
  Caption = 'ViewSistemaMain'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu
  OldCreateOrder = False
  PopupMenu = pMenuMain
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object imgLogo: TImage
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 629
    Height = 274
    Align = alClient
    Center = True
    Proportional = True
    ExplicitLeft = 360
    ExplicitTop = 16
    ExplicitWidth = 105
    ExplicitHeight = 105
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 280
    Width = 635
    Height = 19
    Panels = <
      item
        Text = 'Usu'#225'rio:'
        Width = 200
      end
      item
        Text = 'Terminal:'
        Width = 200
      end
      item
        Text = 'Servidor: '
        Width = 200
      end
      item
        Width = 50
      end>
    OnClick = StatusBarClick
  end
  object MainMenu: TMainMenu
    Images = ModelSistemaImagensDM.imgListMenus
    Left = 24
    Top = 24
    object Cadastros1: TMenuItem
      Caption = '&Cadastros'
      object CadastrosClientes1: TMenuItem
        Bitmap.Data = {
          76060000424D7606000000000000360000002800000014000000140000000100
          20000000000040060000C40E0000C40E00000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000000000000F2AC
          0028F4A903FFF4A903FFF4A903FFF4A903FFF4A903FFF4A903FFF4A903FFF4A9
          03FFF4A903FFF4A903FFF4A903FFF4A903FFF4A903FFF4A903FFF4A903FFF4A9
          03FFF6A7001D0000000000000000F4A903FFF4A903FFF4A903FFF4A903FFF4A9
          03FFF4A903FFF4A903FFF4A903FFF4A903FFF4A903FFF4A903FFF4A903FFF4A9
          03FFF4A903FFF4A903FFF4A903FFF4A903FFF4A903FF0000000000000000F4A9
          03FFF4A903FFF4A903FFF4A903FFF4A903FFF4A903FFF4A903FFF4A903FFF4A9
          03FFF4A903FFF4A903FFF4A903FFF4A903FFF4A903FFF4A903FFF4A903FFF4A9
          03FFF4A903FF0000000000000000F4A903FFF4A903FFFDF2E3FFFDF2E3FFFDF2
          E3FFFDF2E3FFFDF2E3FFFDF2E3FFF4A903FFF4A903FFF4A903FFF4A903FFF4A9
          03FFF4A903FFF4A903FFF4A903FFF4A903FFF4A903FF0000000000000000F4A9
          03FFF4A903FFF4A903FFF5AD0FFFFCECD0FFFCEDD4FFFBDC9FFFF4A903FFF4A9
          03FFF4A903FFF4A903FFF4A903FFF4A903FFF4A903FFF4A903FFF4A903FFF4A9
          03FFF4A903FF0000000000000000F4A903FFF4A903FFF4A903FFF4A903FFF4A9
          03FFF4A903FFF4A903FFF4A903FFF4A903FFF4A903FFF4A903FFF4A903FFF4A9
          03FFF4A903FFF4A903FFF4A903FFF4A903FFF4A903FF0000000000000000F4A9
          03FFF4A903FFF4A903FFF4A903FFFDF2E3FFFDF2E3FFFDF2E3FFF4A903FFF4A9
          03FFF4A903FFF4A903FFF4A903FFF4A903FFF4A903FFF4A903FFF4A903FFF4A9
          03FFF4A903FF0000000000000000F4A903FFF4A903FFF4A903FFF4A903FFFDF2
          E3FFFDF2E3FFFDF2E3FFF4A903FFF4A903FFF4A903FFF4A903FFF4A903FFF4A9
          03FFF4A903FFF4A903FFF4A903FFF4A903FFF4A903FF0000000000000000F4A9
          03FFF4A903FFF4A903FFF4A903FFFDF2E3FFFDF2E3FFFCEDD4FFF4A903FFF4A9
          03FFFDF2E3FFFDF2E3FFFDF2E3FFFDF2E3FFFDF2E3FFFDF2E3FFFDF2E3FFF4A9
          03FFF4A903FF0000000000000000F4A903FFF4A903FFF4A903FFF4A903FFF4A9
          03FFF4A903FFF4A903FFF4A903FFF4A903FFF4A903FFF4A903FFF4A903FFF4A9
          03FFF4A903FFF4A903FFF4A903FFF4A903FFF4A903FF0000000000000000F4A9
          03FFF4A903FFF4A903FFF4A903FFF4A903FFF4A903FFF4A903FFF4A903FFF4A9
          03FFF4A903FFF4A903FFF4A903FFF4A903FFF4A903FFF4A903FFF4A903FFF4A9
          03FFF4A903FF0000000000000000F7AA001EF4A903FFF4A903FFF4A903FFF4A9
          03FFF4A903FFF4A903FFF4A903FFF4A903FFF4A903FFF4A903FFF4A903FFF4A9
          03FFF4A903FFF4A903FFF4A903FFF4A903FFF6A7001D00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Caption = '&Clientes'
        ImageIndex = 0
        object CadastrosClientesCadastro1: TMenuItem
          Caption = '&Cadastro'
          ImageIndex = 1
          OnClick = CadastrosClientesCadastro1Click
        end
      end
      object CadastrosProdutos1: TMenuItem
        Bitmap.Data = {
          76060000424D7606000000000000360000002800000014000000140000000100
          20000000000040060000C40E0000C40E00000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000098FFFF0098FFFF0098
          FFFF0098FFFF0098FFFF0098FFFF0098FFFF0098FFFF0098FFFF0098FFFF0098
          FFFF0098FFFF0098FFFF0098FFFF000000000000000000000000000000000000
          0000000000000098FFFF0098FFFF0098FFFF0098FFFF0098FFFF0098FFFF0098
          FFFF0098FFFF0098FFFF004675FF004675FF004675FF0098FFFF0098FFFF0000
          000000000000000000000000000000000000000000000098FFFF0098FFFF0098
          FFFF0098FFFF0098FFFF0098FFFF0098FFFF0098FFFF0098FFFF004675FF0098
          FFFF004675FF0098FFFF0098FFFF000000000000000000000000000000000000
          0000000000000098FFFF0098FFFF0098FFFF0098FFFF0098FFFF0098FFFF0098
          FFFF0098FFFF0098FFFF004675FF0098FFFF004675FF0098FFFF0098FFFF0000
          000000000000000000000000000000000000000000000098FFFF0098FFFF0098
          FFFF0098FFFF0098FFFF0098FFFF0098FFFF0098FFFF0098FFFF007ED4FF0098
          FFFF007ED4FF0098FFFF0098FFFF000000000000000000000000000000000000
          0000000000000098FFFF0098FFFF0098FFFF0098FFFF0098FFFF0098FFFF0098
          FFFF0098FFFF0098FFFF0098FFFF0098FFFF0098FFFF0098FFFF0098FFFF0000
          000000000000000000000000000000000000000000000098FFFF0098FFFF0098
          FFFF0098FFFF0098FFFF0098FFFF0098FFFF0098FFFF0098FFFF0098FFFF0098
          FFFF0098FFFF0098FFFF0098FFFF000000000000000000000000000000000000
          0000000000000098FFFF0098FFFF0098FFFF0098FFFF0098FFFF0098FFFF0098
          FFFF0098FFFF0098FFFF0098FFFF0098FFFF0098FFFF0098FFFF0098FFFF0000
          000000000000000000000000000000000000000000000098FFFF0098FFFF0098
          FFFF0098FFFF0098FFFF0098FFFF0098FFFF0098FFFF0098FFFF0098FFFF0098
          FFFF0098FFFF0098FFFF0098FFFF000000000000000000000000000000000000
          0000000000000098FFFF0098FFFF0098FFFF0098FFFF0098FFFF0098FFFF0098
          FFFF0098FFFF0098FFFF0098FFFF0098FFFF0098FFFF0098FFFF0098FFFF0000
          000000000000000000000000000000000000000000000098FFFF0098FFFF0098
          FFFF0098FFFF0098FFFF0098FFFF0098FFFF0098FFFF0098FFFF0098FFFF0098
          FFFF0098FFFF0098FFFF0098FFFF000000000000000000000000000000000000
          00002EAAFFFF2EAAFFFF2EAAFFFF2EAAFFFF2EAAFFFF2EAAFFFF2EAAFFFF2EAA
          FFFF2EAAFFFF2EAAFFFF2EAAFFFF2EAAFFFF2EAAFFFF2EAAFFFF2EAAFFFF2EAA
          FFFF000000000000000000000000000000002EAAFFFF2EAAFFFF2EAAFFFF2EAA
          FFFF2EAAFFFF2EAAFFFF2EAAFFFF2EAAFFFF2EAAFFFF2EAAFFFF2EAAFFFF2EAA
          FFFF2EAAFFFF2EAAFFFF2EAAFFFF2EAAFFFF0000000000000000000000000000
          00002EAAFFFF2EAAFFFF2EAAFFFF2EAAFFFF2EAAFFFF2EAAFFFF2EAAFFFF2EAA
          FFFF2EAAFFFF2EAAFFFF2EAAFFFF2EAAFFFF2EAAFFFF2EAAFFFF2EAAFFFF2EAA
          FFFF0000000000000000000000000000000030AAFF4B2EAAFFFF2EAAFFFF2EAA
          FFFF2EAAFFFF2EAAFFFF2EAAFFFF2EAAFFFF2EAAFFFF2EAAFFFF2EAAFFFF2EAA
          FFFF2EAAFFFF2EAAFFFF2EAAFFFF2EAAFFDD0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Caption = '&Produtos'
        ImageIndex = 8
        object CadastrosProdutosCadastro1: TMenuItem
          Caption = '&Cadastro'
          ImageIndex = 9
          OnClick = CadastrosProdutosCadastro1Click
        end
        object CadastrosGruposProdutos1: TMenuItem
          Bitmap.Data = {
            76060000424D7606000000000000360000002800000014000000140000000100
            20000000000040060000C40E0000C40E00000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000046A1
            435447A043FF47A043FF47A043FF47A043FF0000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000047A043FF47A043FF47A043FF47A043FF47A0
            43FF47A043FF0000000000000000000000000000000007C1FFFF07C1FFFF07C1
            FFFF07C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1FFFF47A043FF47A0
            43FF47A043FFFFFFFFFFFFFFFFFF47A043FF47A043FF47A043FF000000000000
            00000000000007C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1
            FFFF07C1FFFF07C1FFFF47A043FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF47A043FF47A043FF00000000000000000000000007C1FFFF07C1FFFF07C1
            FFFF07C1FFFF07C1FFFF0890E2FF0985DBFF0985DBFF0891E2FF47A043FFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF47A043FF47A043FF000000000000
            00000000000007C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1FFFF0985DBFF0985
            DBFF0985DBFF0985DBFF47A043FF47A043FF47A043FFFFFFFFFFFFFFFFFF47A0
            43FF47A043FF47A043FF00000000000000000000000007C1FFFF07C1FFFF07C1
            FFFF07C1FFFF07C1FFFF0985DBFF0985DBFF0985DBFF0985DBFF1C8FADFF47A0
            43FF47A043FFFFFFFFFFFFFFFFFF47A043FF47A043FF469F424D000000000000
            00000000000008ACF2FF0985DBFF0985DBFF0985DBFF0985DBFF0985DBFF0985
            DBFF0985DBFF0985DBFF0985DBFF1D8EA9FF47A043FF47A043FF47A043FF47A0
            43FF000000000000000000000000000000000000000007C1FFFF0985DBFF0985
            DBFF0985DBFF0985DBFF0985DBFF0985DBFF0985DBFF0985DBFF0985DBFF0985
            DBFF0985DBFF0985DBFF07C1FFFF00FFFF020000000000000000000000000000
            00000000000007C1FFFF0985DBFF0985DBFF0985DBFF0985DBFF0985DBFF0985
            DBFF0985DBFF0985DBFF0985DBFF0985DBFF0985DBFF0985DBFF07C1FFFF0000
            0000000000000000000000000000000000000000000008B5F8EE0898E6FF0985
            DBFF0985DBFF0985DBFF0985DBFF0985DBFF0985DBFF0985DBFF0985DBFF0985
            DBFF0985DBFF0898E6FF08B5F7ED000000000000000000000000000000000000
            00000000000007A9F27408B4F7FF0985DBFF0985DBFF0985DBFF0985DBFF0985
            DBFF0985DBFF0985DBFF0985DBFF0985DBFF0985DBFF08B5F8FF07A6EF730000
            000000000000000000000000000000000000000000000000000007C1FFFF0985
            DBFF0985DBFF0985DBFF0985DBFF0985DBFF0985DBFF0985DBFF0985DBFF0985
            DBFF0985DBFF07C1FFFF00000000000000000000000000000000000000000000
            0000000000000000000007C1FFFF0985DBFF0985DBFF0985DBFF0985DBFF0985
            DBFF0985DBFF0985DBFF0985DBFF0985DBFF0985DBFF07C1FFFF000000000000
            000000000000000000000000000000000000000000000000000007A8F0960985
            DBFF0985DBFF0985DBFF0985DBFF0985DBFF0985DBFF0985DBFF0985DBFF0985
            DBFF0985DBFF07A9F19400000000000000000000000000000000000000000000
            0000000000000000000000000000089EEAFF0985DBFF0985DBFF0985DBFF0985
            DBFF0985DBFF0985DBFF0985DBFF0985DBFF089FEAFF00000000000000000000
            00000000000000000000000000000000000000000000000000000000000007BB
            FBFB07C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1
            FFFF07BBFBFB0000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000}
          Caption = '&Grupos'
          ImageIndex = 10
          OnClick = CadastrosGruposProdutos1Click
        end
        object CadastrosSubgruposProdutos1: TMenuItem
          Bitmap.Data = {
            76060000424D7606000000000000360000002800000014000000140000000100
            20000000000040060000C40E0000C40E00000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000000000000000000007C0FFD007C1
            FFC10000000000000000469F435847A043F747A043D549924907000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000CCFF0A07C1FFFF07C1FFFF07C1FFFF28B09CFF47A043FF47A043FF47A0
            43FF47A043FF47A043FF47A043FF000000000000000000000000000000000000
            000000000000000000000000000000CCFF0A07C1FFFF07C1FFFF07C1FFFF07C1
            FFFF47A043FF47A043FF47A043FFFFFFFFFFFFFFFFFF47A043FF47A043FF47A0
            43D400000000000000000000000000000000000000000000000000CCFF0A07C1
            FFFF07C1FFFF07C1FFFF07C1FFFF07C1FFFF47A043FFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFF47A043FF47A043FF0000000000000000000000000000
            00000000000000CCFF0A07C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1
            FFFF47A043FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF47A043FF47A0
            43FF000000000000000000000000000000000000000007C1FFFF07C1FFFF07C1
            FFFF07C1FFFF07C1FFFF07C1FFFF07C1FFFF47A043FF47A043FF47A043FFFFFF
            FFFFFFFFFFFF47A043FF47A043FF47A043FF0000000000000000000000000000
            000007C0FFD407C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1
            FFFF47A043FF47A043FF47A043FFFFFFFFFFFFFFFFFF47A043FF47A043FF469F
            424D0000000000000000000000000000000006C1FFC507C1FFFF07C1FFFF07C1
            FFFF07C1FFFF07C1FFFF07C1FFFF07C1FFFF08C1FDFF47A043FF47A043FF47A0
            43FF47A043FF47A043FF2BAF96FF000000000000000000000000000000000000
            00000000000007C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1
            FFFF07C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1
            FFFF00000000000000000000000000000000000000000000000007C1FFFF07C1
            FFFF07C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1
            FFFF07C1FFFF07C1FFFF07C1FFFF07C1FFFF0000000000000000000000000000
            000000000000000000000000000007C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1
            FFFF07C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1
            FFFF000000000000000000000000000000000000000000000000000000000000
            000007C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1
            FFFF07C1FFFF07C1FFFF07C1FFFF07C1FFFF0000000000000000000000000000
            0000000000000000000000000000000000000000000007C1FFFF07C1FFFF07C1
            FFFF07C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1
            FFFF000000000000000000000000000000000000000000000000000000000000
            0000000000000000000007C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1
            FFFF07C1FFFF0000000007C1FFFF07C1FFFF0000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000007C1
            FFFF07C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1FFFF07C1
            FFFF000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000007C1FFFF07C1FFFF07C1FFFF07C1
            FFFF07C1FFFF07C1FFFF07C1FFFF06C1FFEC0000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000}
          Caption = '&Sub-grupo'
          ImageIndex = 11
          OnClick = CadastrosSubgruposProdutos1Click
        end
      end
      object CadastrosFornecedores1: TMenuItem
        Caption = '&Fornecedores'
        ImageIndex = 13
        object CadastrosFornecedoresCadastro1: TMenuItem
          Caption = '&Cadastro'
          ImageIndex = 16
          OnClick = CadastrosFornecedoresCadastro1Click
        end
      end
      object CadastrosFuncionarios1: TMenuItem
        Bitmap.Data = {
          76060000424D7606000000000000360000002800000014000000140000000100
          20000000000040060000C40E0000C40E00000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000007A6E
          54FF7A6E54FF7A6E54FF7A6E54FF7A6E54FF7A6E54FF7A6E54FF7A6E54FF7A6E
          54FF7A6E54FF7A6E54FF7A6E54FFDCD8CFFFDCD8CFFFDCD8CFFFDCD8CFFFDCD8
          CFFFDCD8CFFF0000000000000000796F54BD7A6E54FF7A6E54FF7A6E54FF7A6E
          54FF7A6E54FF7A6E54FF7A6E54FF7A6E54FF7A6E54FF7A6E54FF7A6E54FFDCD8
          CFFFDCD8CFFFDCD8CFFFDCD8CFFFDCD8CFFFDFD9CC2800000000000000000000
          00007A6E54FF7A6E54FF7A6E54FF7A6E54FF7A6E54FF7A6E54FF7A6E54FF7A6E
          54FF7A6E54FF7A6E54FFADA696FFDCD8CFFFDCD8CFFFDCD8CFFFDCD8CFFFDCD8
          CFFE00000000000000000000000000000000806060087A6E54FF7A6E54FF7A6E
          54FF7A6E54FF7A6E54FF7A6E54FF7A6E54FF7A6E54FF7E7259C1DCD8CFFDDCD8
          CFFFDCD8CFFFDCD8CFFFDBD8CFA4000000000000000000000000000000000000
          000000000000000000007B6E53877A6E54FF7A6E54FF7A6E54FF7A6E54FF7A6E
          54EE000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000000000000DCD8
          CFCBDCD8CFF8CCCCCC0500000000000000000000000000000000000000000000
          000000000000000000000000000051B9FF164DB7FFCA4DB7FFF549B6FF150000
          00000000000000000000DCD8CFFFDCD8CFFFDCD8CFFFDCD8CFFFDDD8CE690000
          0000000000000000000000000000000000000000000000000000000000004DB7
          FFFF4DB7FFFF4DB7FFFF4DB7FFFF4EB7FF520000000000000000DCD8CFFFDCD8
          CFFFDCD8CFFFDCD8CFFFDCD8CFF2000000000000000000000000000000000000
          000000000000000000004DB6FF824DB7FFFF4DB7FFFF4DB7FFFF4DB7FFFF4DB7
          FFFF0000000000000000DCD8CFFFDCD8CFFFDCD8CFFFDCD8CFFFDDD7CFC80000
          00000000000000000000000000000000000000000000000000004DB7FFF34DB7
          FFFF4DB7FFFF4DB7FFFF4DB7FFFF4DB7FFFF0000000000000000D9D9D01BDCD8
          CFFFDCD8CFFFDCD8CECD00000000000000000000000000000000000000000000
          000000000000000000004DB6FF824DB7FFFF4DB7FFFF4DB7FFFF4DB7FFFF4DB7
          FFFF000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000004DB7
          FFF44DB7FFFF4DB7FFFF4DB7FFF3000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Caption = 'F&uncion'#225'rios'
        ImageIndex = 3
        object CadastrosFuncionariosCadastro1: TMenuItem
          Bitmap.Data = {
            76060000424D7606000000000000360000002800000014000000140000000100
            20000000000040060000C40E0000C40E00000000000000000000000000000000
            0000000000000000000000000000000000070000001B00000032000000530000
            005D00000055000000440000002B000000110000000200000000000000000000
            000000000000000000000000000000000000000000000000000200000027050D
            579D0715A4E90A1EADFF0C26B2FF0B23B0FF0614A6FF02049BFE00008BDA0000
            149A000000800000002400000006000000000000000000000000000000000000
            0000000000000615566C0F31B9FE1E5CD7FF1D5AD4FF1C56D2FF194FCEFF184A
            CAFF1440C3FF1239BFFF0F32BBFF0510A3FF040DA2FF00003FA60000007D0000
            000C00000000000000000000000000000000000000002268DEFF1B53D0FF2269
            DFFF2167DEFF2063DBFF1D5BD6FF1B55D1FF1749CAFF1541C4FF1239BFFF0E2A
            B5FF0B23B0FF0817A7FF00004BA20000000D0000000000000000000000000000
            000000000000236CE2FF2572E5FF2573E5FF2570E4FF236CE1FF2063DBFF1D5B
            D6FF194FCDFF1646C8FF133DC2FF0F30B9FF0C27B3FF071BAAFF00001D890000
            000200000000000000000000000000000000000000002167DDFF2A80EEFF2A81
            EFFF297FEDFF2777E8FF236BE0FF2063DBFF1B55D1FF184CCBFF1542C5FF1034
            BCFF0D2BB5FF02079EFF00000030000000000000000000000000000000000000
            0000000000002165DCE32E89F3FF2F8CF5FF2C85F1FF297EECFF2470E3FF2166
            DDFF1C57D3FF194ECDFF1644C6FF1136BDFF0E2CB6FF000069AA000000070000
            000000000000000000000000000000000000000000002577F71F2E8CF7FF3094
            FCFF2D8AF5FF1A60DCFF335BC2FF1042C7FF1D5AD4FF194FCDFF1645C7FF1136
            BDFF0E2EB8FF0000002300000000000000000000000000000000000000000000
            000000000000000000002A7DF01B2E8CF6FF297FEFFFD8D4CDFFBCBBBAFFABAA
            A9FF0520B3FF194FCEFF1745C7FF040EA1FE0000292F00000000000000000000
            0000000000000000000000000000000000000000000000000000000000002679
            EE5F236ADFFE90BCEBFF309AFFFF2F9AFFFF7790B0FF123BC0FF0716A7F70000
            0009000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000009273D1948A6FFFF5CB2FFFF5AB1FFFF57AF
            FFFF52ABFFFF3D9FFFFF00000097000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000003094
            F7E666B9FFFF66B8FFFF64B7FFFF61B5FFFF59B0FFFF54AEFFFF2A84CFD10000
            0008000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000052ABFFFF6EBEFFFF6FBEFFFF6DBDFFFF69BB
            FFFF61B5FFFF5AB1FFFF3EA0FFFF000000190000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000007BC6
            FFFF7CC6FFFF7EC7FFFF7BC5FFFF76C2FFFF6BBCFFFF63B7FFFF53ADFFFF0043
            62AD000000270000000000000000000000000000000000000000000000000000
            000000000000000000000000000186CBFFFF85CCFFFF88CEFFFF83CBFFFF7DC7
            FFFF70BFFFFF6ABAFFFF51AAF8FF0075A7FE0000004C00000000000000000000
            00000000000000000000000000000000000000000000000000000000000283CA
            FFFF90D3FFFF98D8FFFF8ED2FFFF83CBFFFF7AC5FFFF007EB0FF0089BCFF0081
            B4FF0000005A0000000000000000000000000000000000000000000000000000
            0000000000000000000000000000096D9FFF92D4FFFF98D8FFFF8DD1FFFF84CB
            FFFF61B4F0FF008CBFFF008CBFFF0085B8FF0000004100000000000000000000
            0000000000000000000000000000000000000000000000000000000000000074
            A7FF4499CAFF92D4FFFF8BCFFFFF84CCFFFF007AADFF008FC2FF0091C4FF0083
            B6F50000001B0000000000000000000000000000000000000000000000000000
            0000000000000000000000000000006598DE0079ACFF007EB1FF0085B8FF0089
            BCFF008FC2FF0094C7FF0098CBFF0000002C0000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000069A0A60072A5FF007DB0FF007EB1FF0087BAFF008ABDFF0080AE950000
            0001000000000000000000000000000000000000000000000000}
          Caption = '&Cadastro'
          ImageIndex = 4
          OnClick = CadastrosFuncionariosCadastro1Click
        end
        object CadastrosFuncionariosFuncoes1: TMenuItem
          Bitmap.Data = {
            76060000424D7606000000000000360000002800000014000000140000000100
            20000000000040060000C40E0000C40E00000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000004DB7FFFF4DB7FFFF4DB7FFFF4DB7FFFF4DB7
            FFFF56B8F9FEDBC6A4FFF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA
            90FFF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CB90EE00000000000000004DB7
            FFFF4DB7FFFF4DB7FFFF4DB7FFFF4DB7FFFF4DB7FFFF4DB7FFFF5CB9F6FFE6C8
            9DFFF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA
            90FFF9CA90FF00000000000000004DB7FFFF4DB7FFFF4DB7FFFF4DB7FFFF4DB7
            FFFF4DB7FFFF4DB7FFFF4DB7FFFF50B8FFFF7ABCE1FFF9CA90FFCACA80FF8896
            00FF889600FF889600FF889600FFFDF2E3FFF9CA90FF00000000000000004DB7
            FFFF4DB7FFFF4DB7FFFF4DB7FFFF4DB7FFFF4DB7FFFF4DB7FFFF4DB7FFFF80CC
            FFFF64C0FFFFF8CA90FFFDF2E3FFDAD69EFF0098FFFFDBD8A1FFFDF2E3FFFDF2
            E3FFF9CA90FF00000000000000004DB7FFFF4DB7FFFF4DB7FFFF4DB7FFFF0098
            FFFFF9CA90FFACC2C2FF4DB7FFFF68C2FFFF4FB7FEFFF9CA90FFFDF2E3FFBEDD
            EDFF4DB7FFFFB6DAEEFFFDF2E3FFFDF2E3FFF9CA90FF00000000000000004DB7
            FFFF4DB7FFFF4DB7FFFF4DB7FFFF0098FFFFF9CA90FFD27619FFD27619FFD276
            19FFD27619FFF9CA90FFFDF2E3FF4B9FD9FF4DB7FFFF4B9FD9FFFDF2E3FFFDF2
            E3FFF9CA90FF00000000000000004CB7FF4A4DB7FFFF4DB7FFFF4DB7FFFF0399
            FFFFF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA90FFFDF2E3FF4242
            42FF456174FF43474AFFFDF2E3FFFDF2E3FFF9CA90FF00000000000000000000
            00004CB8FF9D4DB7FFFF4DB7FFFF2DAAFFFFF9CA90FFD27619FFD27619FFD276
            19FFD27619FFF9CA90FFFDF2E3FFEDE3D5FF525150FFFDF2E3FFFDF2E3FFFDF2
            E3FFF9CA90FF000000000000000000000000000000004DB7FFF24DB7FFFF4DB7
            FFFFF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA
            90FFF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA90FF00000000000000000000
            000000000000000000004DB7FFFE4DB7FFFFECC998FFF9CA90FFF9CA90FFF9CA
            90FFF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA
            90FFF9CA90ED0000000000000000000000000000000000000000000000004DB7
            FF9F4DB7FFC451BCFF1300000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000}
          Caption = '&Fun'#231#245'es'
          ImageIndex = 6
          OnClick = CadastrosFuncionariosFuncoes1Click
        end
      end
      object CadastrosCidades1: TMenuItem
        Bitmap.Data = {
          76060000424D7606000000000000360000002800000014000000140000000100
          20000000000040060000C40E0000C40E00000000000000000000B5513FFFB551
          3FFFB5513FFFB5513FFFB5513FFFB5513FFFAE8170FF28CAFFFF28CAFFFF28CA
          FFFF28CAFFFF28CAFFFF28CAFFFFE9CAC5FFE9CAC5FFE9CAC5FFE9CAC5FFE9CA
          C5FFE9CAC5FFE9CAC5FFB5513FFFDAA89FFFDAA89FFFB5513FFFDAA89FFFBD63
          52FFAE8170FF28CAFFFF008CFBFF28CAFFFF0899FCFF008CFBFF28CAFFFFE9CA
          C5FFC06B5CFFE0B7B0FFE9CAC5FFE9CAC5FFC06B5CFFE9CAC5FFB5513FFFDAA8
          9FFFDAA89FFFB5513FFFDAA89FFFBD6352FFAE8170FF28CAFFFF008CFBFF28CA
          FFFF0899FCFF008CFBFF28CAFFFFE9CAC5FFC06B5CFFE0B7B0FFE9CAC5FFE9CA
          C5FFC06B5CFFE9CAC5FFB5513FFFB5513FFFB5513FFFB5513FFFB5513FFFB551
          3FFFAE8170FF28CAFFFF28CAFFFF28CAFFFF28CAFFFF28CAFFFF28CAFFFFE9CA
          C5FFE9CAC5FFE9CAC5FFE9CAC5FFE9CAC5FFE9CAC5FFE9CAC5FFB5513FFFDAA8
          9FFFDAA89FFFB5513FFFDAA89FFFBD6352FFAE8170FF28CAFFFF008CFBFF28CA
          FFFF0899FCFF008CFBFF28CAFFFFE9CAC5FFC06B5CFFE0B7B0FFE9CAC5FFE9CA
          C5FFC06B5CFFE9CAC5FFB5513FFFC26E5FFFC26E5FFFB5513FFFC26E5FFFB857
          45FFAE8170FF28CAFFFF1BB6FEFF28CAFFFF1DB9FEFF1BB6FEFF28CAFFFFE9CA
          C5FFDBABA2FFE6C4BFFFE9CAC5FFE9CAC5FFDBABA2FFE9CAC5FFB5513FFFB551
          3FFFB5513FFFB5513FFFB5513FFFB5513FFFAE8170FF28CAFFFF28CAFFFF28CA
          FFFF28CAFFFF28CAFFFF28CAFFFFE9CAC5FFE9CAC5FFE9CAC5FFE9CAC5FFE9CA
          C5FFE9CAC5FFE9CAC5FFB5513FFFDAA89FFFDAA89FFFB5513FFFDAA89FFFBD63
          52FFAE8170FF28CAFFFF008CFBFF28CAFFFF0899FCFF008CFBFF28CAFFFFE9CA
          C5FFC06B5CFFE0B7B0FFE9CAC5FFE9CAC5FFC06B5CFFE9CAC5FFB5513FFFB551
          3FFFB5513FFFB5513FFFB5513FFFB5513FFFAE8170FF28CAFFFF28CAFFFF28CA
          FFFF28CAFFFF28CAFFFF28CAFFFFE9CAC5FFE9CAC5FFE9CAC5FFE9CAC5FFE9CA
          C5FFE9CAC5FFE9CAC5FFB5513FFFC26E5FFFC26E5FFFB5513FFFC26E5FFFB857
          45FFBA816BFF6DCADAFF6DCADAFF6DCADAFF28C9FFAB28C9FFAB28C9FFABE9CA
          C5FFDBABA2FFE6C4BFFFE9CAC5FFE9CAC5FFDBABA2FFE9CAC5FFB5513FFFDAA8
          9FFFDAA89FFFB5513FFFDAA89FFFBD6352FFD0815FFFF9CA90FFF9CA90FFF9CA
          90FF000000000000000000000000E9CAC5FFC06B5CFFE0B7B0FFE9CAC5FFE9CA
          C5FFC06B5CFFE9CAC5FFB5513FFFB5513FFFB5513FFFB5513FFFB5513FFFB551
          3FFFD0815FFFF9CA90FFF9CA90FFF9CA90FF000000000000000000000000E9CA
          C5FFE9CAC5FFE9CAC5FFE9CAC5FFE9CAC5FFE9CAC5FFE9CAC5FFB4513F55B451
          3F55B4513F55E2A275FFE2A275FFE2A275FFEBB280FFF9CA90FFF9CA90FFF9CA
          90FF000000000000000000000000E9CAC5FFCE8B7FFFE4BDB7FFE9CAC5FFE9CA
          C5FFCE8B7FFFE9CAC5FF000000000000000000000000F9CA90FFF9CA90FFF9CA
          90FFF9CA90FFF9CA90FFF9CA90FFF9CA90FF000000000000000000000000E9CA
          C5FFC06B5CFFE0B7B0FFE9CAC5FFE9CAC5FFC06B5CFFE9CAC5FF000000000000
          000000000000F9CA90FFF2B46AFFF7C689FFF9CA90FFF2B46AFFF7C281FFF9CA
          90FF000000000000000000000000E9CAC5FFE9CAC5FFE9CAC5FFE9CAC5FFE9CA
          C5FFE9CAC5FFE9CAC5FF000000000000000000000000F9CA90FFE5881EFFF5BD
          79FFF9CA90FFE5881EFFF1AF62FFF9CA90FF000000000000000000000000E9CA
          C5FFC06B5CFFE0B7B0FFE9CAC5FFE9CAC5FFC06B5CFFE9CAC5FF000000000000
          000000000000F9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA
          90FF000000000000000000000000E9CAC5FFC06B5CFFE0B7B0FFE9CAC5FFE9CA
          C5FFC06B5CFFE9CAC5FF000000000000000000000000F9CA90FFEC9E43FFF7C1
          81FFF9CA90FFEC9E43FFF4B872FFF9CA90FF000000000000000000000000E9CA
          C5FFE9CAC5FFE9CAC5FFE9CAC5FFE9CAC5FFE9CAC5FFE9CAC5FF000000000000
          000000000000F9CA90FFE5881EFFF5BD79FFF9CA90FFE5881EFFF1AF62FFF9CA
          90FF000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000F9CA90FFF9CA90FFF9CA
          90FFF9CA90FFF9CA90FFF9CA90FFF9CA90FF0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Caption = 'C&idades'
        ImageIndex = 12
        object CadastrosCidades1Cadastro1: TMenuItem
          Caption = '&Cadastro'
          ImageIndex = 14
          OnClick = CadastrosCidades1Cadastro1Click
        end
      end
    end
    object Movimentacoes1: TMenuItem
      Caption = '&Movimenta'#231#245'es'
    end
    object Financeiro1: TMenuItem
      Caption = '&Financeiro'
    end
    object Relatorios1: TMenuItem
      Caption = '&Relat'#243'rios'
    end
    object Suporte1: TMenuItem
      Caption = 'Suporte'
      object SuporteSobreSistema1: TMenuItem
        Caption = 'Sobre o sistema'
        OnClick = SuporteSobreSistema1Click
      end
    end
    object Sair1: TMenuItem
      Caption = '&Sair'
      OnClick = Sair1Click
    end
  end
  object pMenuMain: TPopupMenu
    Left = 88
    Top = 24
    object AtualizarIconesDeAtalhos1: TMenuItem
      Caption = 'Atualizar '#237'cones de atalhos'
      OnClick = AtualizarIconesDeAtalhos1Click
    end
    object OcultarIcones1: TMenuItem
      Caption = 'Ocultar '#237'cones'
      OnClick = OcultarIcones1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Configurarcones1: TMenuItem
      Caption = 'Configurar '#237'cones'
      OnClick = Configurarcones1Click
    end
  end
  object TimerFormResize: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerFormResizeTimer
    Left = 32
    Top = 120
  end
end