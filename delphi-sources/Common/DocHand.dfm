object F_DocHand: TF_DocHand
  Left = 271
  Top = 575
  Width = 350
  Height = 98
  Caption = 'Vysporiadanie skladu'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Times New Roman'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 14
  object P_Back: TDinamicPanel
    Left = 0
    Top = 0
    Width = 334
    Height = 59
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    ColorThemes = acsStandard
    AutoExpand = False
    object DoubleBevel1: TDoubleBevel
      Left = 8
      Top = 9
      Width = 328
      Height = 52
    end
    object DoubleBevel3: TDoubleBevel
      Left = 8
      Top = 200
      Width = 328
      Height = 46
    end
    object L_Describe: TCenterLabel
      Left = 14
      Top = 204
      Width = 315
      Height = 15
      Alignment = taCenter
      AutoSize = False
      Caption = 'x'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      FixedSize = False
    end
    object L_InfoLine: TCenterLabel
      Left = 14
      Top = 13
      Width = 315
      Height = 15
      Alignment = taCenter
      AutoSize = False
      Caption = 'Vysporiadanie skladu'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      FixedSize = False
    end
    object PB_Indicator: TProgressBar
      Left = 14
      Top = 31
      Width = 315
      Height = 16
      Min = 0
      Max = 100
      Smooth = True
      TabOrder = 0
    end
    object PB_Correction: TProgressBar
      Left = 14
      Top = 222
      Width = 315
      Height = 16
      Min = 0
      Max = 100
      Smooth = True
      TabOrder = 1
    end
  end
  object btICH: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    DOSStrings = True
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 8
    Top = 16
  end
  object btICI: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    DOSStrings = True
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 40
    Top = 16
  end
end
