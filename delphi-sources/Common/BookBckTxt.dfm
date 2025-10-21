object F_BookBckTxt: TF_BookBckTxt
  Left = 192
  Top = 114
  Width = 403
  Height = 169
  Caption = 'Archiv'#225'cia dokladov do textov'#233'ho s'#250'boru'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object xpSinglePanel1: TxpSinglePanel
    Left = 0
    Top = 0
    Width = 395
    Height = 135
    BorderColor = 16754085
    SystemColor = True
    Color = 16769505
    Align = alClient
    TabOrder = 0
    DesignSize = (
      395
      135)
    object xpMemo1: TxpMemo
      Left = 0
      Top = 0
      Width = 395
      Height = 65
      TabStop = False
      MemoColors.BGNormal = clWhite
      MemoColors.BGActive = 16756655
      MemoColors.BGModify = 16761795
      MemoColors.InactBorder = 16754085
      MemoColors.ActBorder = 16743805
      SystemColor = True
      Align = alTop
      Color = clWhite
      Font.Charset = EASTEUROPE_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      Lines.Strings = (
        'T'#225'to funkcia z'#225'lohuje doklumenty do  '#353'peci'#225'lneho '
        'textov'#233'ho s'#250'boru do podadres'#225'ra \BCKTXT\.')
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object B_Backup: TxpBitBtn
      Left = 16
      Top = 76
      Width = 125
      Height = 29
      SystemColor = True
      Caption = 'Z'#225'lohova'#357
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
      OnClick = B_BackupClick
    end
    object B_Cancel: TxpBitBtn
      Left = 152
      Top = 76
      Width = 121
      Height = 29
      SystemColor = True
      Caption = 'Preru'#353'i'#357
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 13107200
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      TabOrder = 2
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
      OnClick = B_CancelClick
    end
    object PB_Ind: TProgressBar
      Left = 4
      Top = 113
      Width = 381
      Height = 17
      Anchors = [akLeft, akRight, akBottom]
      Min = 0
      Max = 100
      TabOrder = 3
    end
  end
end
