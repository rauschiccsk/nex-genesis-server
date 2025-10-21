object F_CntWinF: TF_CntWinF
  Left = 314
  Top = 171
  BorderStyle = bsToolWindow
  ClientHeight = 172
  ClientWidth = 287
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Times New Roman'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 14
  object DinamicPanel1: TDinamicPanel
    Left = 0
    Top = 0
    Width = 287
    Height = 153
    Align = alClient
    Caption = ' '
    TabOrder = 0
    ColorThemes = acsStandard
    AutoExpand = False
    object LeftLabel1: TLeftLabel
      Left = 8
      Top = 114
      Width = 137
      Height = 15
      Caption = 'Celkový poèet záznamov :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
      FixedSize = False
    end
    object LeftLabel2: TLeftLabel
      Left = 8
      Top = 134
      Width = 156
      Height = 15
      Caption = 'Poèet preèítanýchzáznamov :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
      FixedSize = False
    end
    object NumLabel1: TNumLabel
      Left = 180
      Top = 117
      Width = 49
      Height = 15
      Alignment = taRightJustify
      Caption = '1000000'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
      FixedSize = False
      ValueInt = 1000000
      ValueDoub = 1000000
    end
    object NumLabel2: TNumLabel
      Left = 180
      Top = 133
      Width = 49
      Height = 15
      Alignment = taRightJustify
      Caption = '1000000'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
      FixedSize = False
      ValueInt = 1000000
      ValueDoub = 1000000
    end
    object ProgressBar1: TProgressBar
      Left = 6
      Top = 92
      Width = 273
      Height = 20
      Min = 0
      Max = 100
      TabOrder = 0
    end
    object Animate1: TAnimate
      Left = 8
      Top = 30
      Width = 272
      Height = 60
      Active = False
      CommonAVI = aviCopyFiles
      StopFrame = 34
    end
    object DinamicPanel2: TDinamicPanel
      Left = 1
      Top = 1
      Width = 285
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Prenos udajov'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      ColorThemes = acsStandard
      AutoExpand = False
    end
  end
  object StatusLine1: TStatusLine
    Left = 0
    Top = 153
    Width = 287
    Height = 19
    Panels = <
      item
        Text = '  1 : 0'
        Width = 80
      end
      item
        Width = 50
      end>
    SimplePanel = False
    TabPosition = 0
    CursorPosition = 0
  end
end
