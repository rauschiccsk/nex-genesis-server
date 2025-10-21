object F_NxbLstV: TF_NxbLstV
  Tag = 1203
  Left = 257
  Top = 148
  Width = 434
  Height = 375
  Caption = 'Zoznam kn'#237'h vybran'#233'ho modulu'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Times New Roman'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object TV_NxbLst: TTableView
    Left = 0
    Top = 0
    Width = 418
    Height = 336
    GridFont.Charset = DEFAULT_CHARSET
    GridFont.Color = clWindowText
    GridFont.Height = -15
    GridFont.Name = 'Arial'
    GridFont.Style = []
    Align = alClient
    TabStop = True
    SearchLnClear = True
    TabOrder = 0
    EnableMultiSelect = False
    BevelOuter = bvRaised
    BevelInner = bvLowered
    BorderWidth = 3
    BevelWidth = 1
    Head = 'Zoznam kn'#237'h vybran'#233'ho modulu'
    HeadFont.Charset = DEFAULT_CHARSET
    HeadFont.Color = clYellow
    HeadFont.Height = -16
    HeadFont.Name = 'Times New Roman'
    HeadFont.Style = [fsBold]
    ToolBarHeight = 28
    ShowRecNo = False
    DGDName = 'NXBOKLST'
    LoginName = '--------'
    ShowOnlyUserSet = False
    ServiceMode = False
    GDChange = True
    TabSet = -1
    GridModify = True
    ReadOnly = True
    Enabled = True
    MultiSelect = False
    MarkData.NormalColor = clBlack
    MarkData.SelMultiRowColor = 1947184
    MarkData.SelMultiCellColor = clGreen
    MarkData.SelRowColor = 16732240
    MarkData.SelCellColor = clNavy
    MarkData.SelInactRowColor = 10526880
    MarkData.SelInactCellColor = clGray
    IndexColor.IndexBadColor = clRed
    IndexColor.IndexEmptyColor = clWindow
    IndexColor.IndexFindColor = clLime
    IndexColor.IndexSelColor = clYellow
    SearchLnFocused = False
    EnabledReadActSet = True
    OnEscPressed = B_ExitClick
    OnSelected = TV_NxbLstSelected
    DatabaseType = dtStandard
    ShowButtonPanel = True
    object B_Exit: TSpecSpeedButton
      Left = 6
      Top = 26
      Width = 25
      Height = 25
      Hint = 'Opusti'#357' programov'#250' funkciu'
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
        03333388888888888F333301BBBBBBBB033333883F3333338F3333011BBBBBBB
        0333338F83F333338F33330111BBBBBB0333338F383F33338F333301110BBBBB
        0333338F338F33338F333301110BBBBB0333338F338F33338F333301110BBBBB
        0333338F338F33338F333301110BBBBB0333338F338F33338F333301110BBBBB
        0333338F338F33338F333301110BBBBB0333338F338FF3338F33330111B0BBBB
        0333338F338833338F333301110BBBBB0333338F338F33338F333301110BBBBB
        0333338F3F8F33338F333301E10BBBBB0333338F8F8F33338F333301EE0BBBBB
        0333338F888FFFFF8F3333000000000003333388888888888333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = B_ExitClick
      ButtonType = btExit
    end
  end
  object IcActionList1: TIcActionList
    Left = 16
    Top = 104
    object A_Insert: TAction
      Caption = 'A_Insert'
      ShortCut = 45
    end
    object A_Delete: TAction
      Caption = 'A_Delete'
      ShortCut = 46
    end
    object A_Exit: TAction
      Caption = 'A_Exit'
      ShortCut = 27
      OnExecute = B_ExitClick
    end
  end
end
