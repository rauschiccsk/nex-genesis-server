object F_DocCom: TF_DocCom
  Left = 253
  Top = 182
  Width = 364
  Height = 176
  Caption = 'Prenos dokladov'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object DinamicPanel1: TDinamicPanel
    Left = 0
    Top = 0
    Width = 356
    Height = 142
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    ColorThemes = acsStandard
    AutoExpand = False
    object DoubleBevel1: TDoubleBevel
      Left = 8
      Top = 8
      Width = 340
      Height = 34
    end
    object DoubleBevel2: TDoubleBevel
      Left = 8
      Top = 50
      Width = 340
      Height = 60
    end
    object RightLabel1: TRightLabel
      Left = 16
      Top = 17
      Width = 76
      Height = 15
      Alignment = taRightJustify
      Caption = #268#237'slo dokladu:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      FixedSize = False
    end
    object RightLabel2: TRightLabel
      Left = 206
      Top = 17
      Width = 80
      Height = 15
      Alignment = taRightJustify
      Caption = 'Po'#269'et polo'#382'iek:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      FixedSize = False
    end
    object CenterLabel1: TCenterLabel
      Left = 13
      Top = 52
      Width = 330
      Height = 15
      Alignment = taCenter
      AutoSize = False
      Caption = 'CenterLabel1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      FixedSize = False
    end
    object PB_Item: TProgressBar
      Left = 13
      Top = 69
      Width = 330
      Height = 20
      Min = 0
      Max = 100
      Smooth = True
      TabOrder = 0
    end
    object L_DocNum: TNameInfo
      Left = 96
      Top = 14
      Width = 100
      Height = 20
      Alignment = taLeftJustify
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
    end
    object L_ItmQnt: TLongInfo
      Left = 291
      Top = 14
      Width = 50
      Height = 20
      Alignment = taRightJustify
      Text = '0'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Long = 0
    end
    object PB_Doc: TProgressBar
      Left = 13
      Top = 93
      Width = 330
      Height = 10
      Min = 0
      Max = 100
      Smooth = True
      TabOrder = 3
    end
    object CancelButton1: TCancelButton
      Left = 127
      Top = 117
      Width = 90
      Height = 25
      Caption = 'Storno'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ModalResult = 2
      ParentFont = False
      TabOrder = 4
      OnClick = CancelButton1Click
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      ButtonType = btNone
    end
  end
end
