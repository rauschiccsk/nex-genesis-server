object DacF: TDacF
  Tag = 1202
  Left = 306
  Top = 151
  Width = 490
  Height = 405
  Caption = 'Roz'#250#269'tovanie dokladu'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Times New Roman'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 15
  object P_Err: TxpSinglePanel
    Left = 0
    Top = 114
    Width = 482
    Height = 245
    BorderColor = 13816575
    SystemColor = False
    Color = 16774388
    Align = alClient
    TabOrder = 3
    object T_Err: TxpLabel
      Left = 0
      Top = 0
      Width = 482
      Height = 19
      SystemColor = False
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = 'Doklad nie je mo'#382'n'#233' roz'#250#269'tova'#357' kv'#244'li nasleduj'#250'cim chyb'#225'm'
      Color = 13816575
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object E_Err: TxpMemo
      Left = 0
      Top = 19
      Width = 482
      Height = 186
      MemoColors.BGNormal = clWhite
      MemoColors.BGActive = 16756655
      MemoColors.BGModify = 16761795
      MemoColors.InactBorder = 13816575
      MemoColors.ActBorder = 13816575
      SystemColor = False
      Align = alTop
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object B_Exi: TxpBitBtn
      Left = 198
      Top = 210
      Width = 90
      Height = 29
      SystemColor = True
      Caption = 'Opusti'#357
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 13107200
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      TabOrder = 1
      MarginLeft = 8
      MarginRight = 8
      MarginTop = 8
      MarginBottom = 8
      GlyphSpace = 10
      LineSpace = 2
      Layout = blGlyphLeft
      AlignText = atCenter
      Down = False
      GroupIndex = 0
      OnClick = B_ExiClick
    end
  end
  object P_WinHed: TPanel
    Left = 0
    Top = 0
    Width = 482
    Height = 66
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    DesignSize = (
      482
      66)
    object L_WinTit: TLeftLabel
      Left = 11
      Top = 3
      Width = 110
      Height = 15
      Caption = 'Stru'#269'n'#233' inform'#225'cie:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
      FixedSize = False
    end
    object L_WinDes: TLeftLabel
      Left = 25
      Top = 19
      Width = 440
      Height = 46
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 
        'T'#225'to funkcia roz'#250#269'tuje zadan'#253' doklad a ulo'#382#237' vytvoren'#233' '#250#269'tovn'#233' z' +
        #225'pisy do denn'#237'ka u'#269'tovn'#237'ch z'#225'pisov. Ak dan'#253' doklad u'#382' bol roz'#250#269't' +
        'ovan'#253' potom star'#233' '#250#269'tovn'#233' z'#225'pisy bud'#250' zamenen'#233' nov'#253'mi.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      WordWrap = True
      FixedSize = False
    end
  end
  object P_WinBas: TxpSinglePanel
    Left = 0
    Top = 66
    Width = 482
    Height = 48
    BorderColor = 16754085
    SystemColor = True
    Color = 16769505
    Align = alTop
    TabOrder = 1
    object T_DocNum: TxpLabel
      Left = 5
      Top = 6
      Width = 108
      Height = 19
      SystemColor = False
      Alignment = taCenter
      AutoSize = False
      Caption = #268#237'slo dokladu'
      Color = 16759225
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object T_DocDate: TxpLabel
      Left = 117
      Top = 6
      Width = 89
      Height = 19
      SystemColor = False
      Alignment = taCenter
      AutoSize = False
      Caption = 'D'#225'tum'
      Color = 16759225
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object E_DocNum: TxpEdit
      Left = 5
      Top = 26
      Width = 108
      Height = 18
      NumSepar = True
      SystemColor = True
      EditColors.Changed = True
      EditColors.BGNormal = clWhite
      EditColors.BGReadOnly = 16761795
      EditColors.BGInfoField = 16774645
      EditColors.BGActive = 16756655
      EditColors.BGModify = 16761795
      EditColors.BGExtText = 16764365
      EditColors.InactBorder = 16754085
      EditColors.ActBorder = 16743805
      Rounded = True
      RoundRadius = 3
      MarginLeft = 2
      MarginRight = 2
      Alignment = taLeftJustify
      EditorType = etString
      Frac = 0
      AsInteger = 0
      AutoFieldSet = True
      AutoCR = True
      ExtTextShow = False
      ExtMargin = 0
      InfoField = True
      MaxLength = 50
      ReadOnly = True
      Color = 16774645
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TabStop = False
    end
    object E_DocDate: TxpEdit
      Left = 117
      Top = 26
      Width = 90
      Height = 18
      NumSepar = True
      SystemColor = True
      EditColors.Changed = True
      EditColors.BGNormal = clWhite
      EditColors.BGReadOnly = 16761795
      EditColors.BGInfoField = 16774645
      EditColors.BGActive = 16756655
      EditColors.BGModify = 16761795
      EditColors.BGExtText = 16764365
      EditColors.InactBorder = 16754085
      EditColors.ActBorder = 16743805
      Rounded = True
      RoundRadius = 3
      MarginLeft = 2
      MarginRight = 2
      Alignment = taLeftJustify
      EditorType = etDate
      Frac = 0
      AsInteger = 0
      AutoFieldSet = True
      AutoCR = True
      ExtTextShow = False
      ExtMargin = 0
      InfoField = True
      ReadOnly = True
      Color = 16774645
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      TabStop = False
    end
    object P_Ind: TxpSinglePanel
      Left = 210
      Top = 6
      Width = 270
      Height = 38
      BorderColor = 16754085
      SystemColor = False
      Color = 16774388
      TabOrder = 2
      object T_Ind: TxpLabel
        Left = 0
        Top = 0
        Width = 270
        Height = 19
        SystemColor = False
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = 'Za'#250#269'tovanie '#250'dajov'
        Color = 16759225
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
      end
      object PB_Ind: TProgressBar
        Left = 0
        Top = 19
        Width = 218
        Height = 19
        Align = alClient
        Min = 0
        Max = 100
        TabOrder = 0
      end
      object C_Ind: TxpEdit
        Left = 218
        Top = 19
        Width = 52
        Height = 19
        NumSepar = True
        AsString = '0'
        SystemColor = True
        EditColors.Changed = True
        EditColors.BGNormal = clWhite
        EditColors.BGReadOnly = 16761795
        EditColors.BGInfoField = 16774645
        EditColors.BGActive = 16756655
        EditColors.BGModify = 16761795
        EditColors.BGExtText = 16764365
        EditColors.InactBorder = 16754085
        EditColors.ActBorder = 16743805
        Rounded = True
        RoundRadius = 3
        MarginLeft = 2
        MarginRight = 2
        Alignment = taRightJustify
        EditorType = etInteger
        Frac = 0
        AsInteger = 0
        AutoFieldSet = False
        FieldName = 'GSCode'
        AutoCR = True
        ExtTextShow = False
        ExtMargin = 0
        InfoField = True
        ReadOnly = True
        Align = alRight
        Color = 16774645
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        TabStop = False
        Text = '0'
      end
    end
  end
  object StatusLine: TxpStatusLine
    Left = 0
    Top = 359
    Width = 482
    Height = 19
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'StatusLine'
    Color = 16769505
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    BorderColorL = clWhite
    BorderColorD = 16743805
    LineColor = 16756655
    SystemColor = True
    Text = '2010;;;'
  end
end
