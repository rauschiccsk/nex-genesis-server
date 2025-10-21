object F_RepPrint: TF_RepPrint
  Left = 226
  Top = 105
  Width = 802
  Height = 612
  Caption = 'Report manager'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000000020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF007777
    7000000000000000000000077777777770777777777777777777777077777777
    70F8888888888888888888870777777770F88888888888888888888770777777
    70F8888888888888888888877077777770777777777777777777777770777777
    0000000000000000000000007077777077777777777777777777777700777707
    8888888888888888888888887077770F8888888888888888888888887707770F
    8888888888888888888888887770770F8888888888888888888888887770770F
    8888888888888888888888887770770F8888888888888888889999887770770F
    8888888888888888888888887770770FFFFFFFFFFFFFFFFFFFFFFFFF77707770
    888888888888888888888888F77077770888800000000000000007888F707777
    700000FFFFFFFFFFFFFF000000007777777770FFCCCCCCCCCCFF077777777777
    777770FFFFFFFFFFFFFF0777777777777777777F7CCCCCCCCC7F777777777777
    7777770FFFFFFFFFFFFFF0777777777777777770FFCCCCCCCCCCFF0777777777
    777777770FFFFFFFFFFFFFF0777777777777777777FCCCCCCCCCCFF777777777
    7777777770FFFFFFFFFFFFFF077777777777777770FFFFFFFFFFFFFF07777777
    7777777770000000000000000777777777777777777777777777777777777777
    7777777777777777777777777777777777777777777777777777777777770000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000}
  OldCreateOrder = True
  Scaled = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object QR_Universal: TIcQuickRep
    Left = 0
    Top = 0
    Width = 794
    Height = 1123
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Functions.Strings = (
      'PAGENUMBER'
      'COLUMNNUMBER'
      'REPORTTITLE')
    Functions.DATA = (
      '0'
      '0'
      #39#39)
    Options = [FirstPageHeader, LastPageFooter]
    Page.Columns = 1
    Page.Orientation = poPortrait
    Page.PaperSize = A4
    Page.Values = (
      100
      2970
      100
      2100
      100
      100
      0)
    PrinterSettings.Copies = 1
    PrinterSettings.Duplex = False
    PrinterSettings.FirstPage = 0
    PrinterSettings.LastPage = 0
    PrinterSettings.OutputBin = First
    PrintIfEmpty = True
    SnapToGrid = True
    Units = Native
    Zoom = 100
    object QRB_ColumnHeader: TIcQRBand
      Left = 38
      Top = 132
      Width = 718
      Height = 22
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Frame.Width = 0
      AlignToBottom = False
      Color = clWhite
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        58.2083333333333
        1899.70833333333)
      BandType = rbColumnHeader
    end
    object QRB_Title: TIcQRBand
      Left = 38
      Top = 108
      Width = 718
      Height = 24
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Frame.Width = 0
      AlignToBottom = False
      Color = clWhite
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        63.5
        1899.70833333333)
      BandType = rbTitle
    end
    object QRB_Detail: TIcQRBand
      Left = 38
      Top = 154
      Width = 718
      Height = 22
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Frame.Width = 0
      AlignToBottom = False
      Color = clWhite
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        58.2083333333333
        1899.70833333333)
      BandType = rbDetail
    end
    object QRB_PageFooter: TIcQRBand
      Left = 38
      Top = 178
      Width = 718
      Height = 24
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Frame.Width = 0
      AlignToBottom = False
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = []
      ForceNewColumn = False
      ForceNewPage = False
      ParentFont = False
      Size.Values = (
        63.5
        1899.70833333333)
      BandType = rbPageFooter
    end
    object QRB_Summary: TIcQRBand
      Left = 38
      Top = 176
      Width = 718
      Height = 2
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Frame.Width = 0
      AlignToBottom = False
      Color = clWhite
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        5.29166666666667
        1899.70833333333)
      BandType = rbSummary
    end
    object QRB_PageHeader: TIcQRBand
      Left = 38
      Top = 38
      Width = 718
      Height = 70
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clWhite
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        185.208333333333
        1899.70833333333)
      BandType = rbPageHeader
    end
  end
  object IH_RepFld: TIniHandle
    Left = 2
  end
  object RepManager1: TRepManager
    FSFileNameMask = '*'
    FSFileExtensionMask = '*'
    Left = 32
  end
  object QRTextFilter1: TQRTextFilter
    Left = 248
  end
  object QRCSVFilter1: TQRCSVFilter
    Separator = ','
    Left = 280
  end
  object QRHTMLFilter1: TQRHTMLFilter
    Left = 312
  end
end
