inherited ViewProdutosCad: TViewProdutosCad
  Caption = 'Cadastro de produtos'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnButtons: TPanel
    inherited btnBuscar: TButton
      OnClick = btnBuscarClick
    end
  end
end
