object PacLstV: TPacLstV
  Tag = 1907001
  Left = 388
  Top = 248
  Width = 598
  Height = 375
  Caption = 'Zoznam obchodn'#253'ch partnerov'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Times New Roman'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 14
  object TV_PacLst: TTableView
    Left = 0
    Top = 0
    Width = 590
    Height = 341
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
    Head = 'Zoznam firiem'
    HeadFont.Charset = DEFAULT_CHARSET
    HeadFont.Color = clWhite
    HeadFont.Height = -16
    HeadFont.Name = 'Times New Roman'
    HeadFont.Style = []
    ToolBarHeight = 28
    ShowRecNo = False
    DGDName = 'PACLST'
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
    OnInsPressed = B_InsertClick
    OnSelected = TV_PacLstSelected
    DatabaseType = dtBtrieve
    ShowButtonPanel = True
    object B_Exit: TSpecSpeedButton
      Left = 6
      Top = 30
      Width = 25
      Height = 25
      Hint = 'Opusti'#357' zoznam firiem (ESC)'
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
    object B_Insert: TSpecSpeedButton
      Left = 32
      Top = 30
      Width = 25
      Height = 25
      Hint = 'Prida'#357' nov'#250' firmu do zoznamu (INS)'
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333333FF33333333FF333993333333300033388F3333333888333993333333
        300033F88FFF3333388839999993333333333888888F3333333F399999933333
        33003888888333333388333993333333330033388F3333333388333993333333
        3333333883333333333F333333333333330033333333F33333883333333C3333
        330033333338FF3333883333333CC333333333FFFFF88FFF3FF33CCCCCCCCCC3
        993338888888888F88F33CCCCCCCCCC3993338888888888388333333333CC333
        333333333338833333FF3333333C333330003333333833333888333333333333
        3000333333333333388833333333333333333333333333333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = B_InsertClick
      ButtonType = btInsert
    end
    object B_Edit: TSpecSpeedButton
      Left = 58
      Top = 30
      Width = 25
      Height = 25
      Hint = 'Zmeni'#357' '#250'daje vybranej firmy (Ctrl+ENTER)'
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        555555FFFFFFFFFF55555000000000055555588888888885FFFF00B7B7B7B7B0
        0000885F5555555888880B0B7B7B7B7B0FF08F85F555555585F80FB0B7B7B7B7
        B0F08F585FFFFFFFF8F80BFB0000000000F08F558888888888580FBFBF0FFFFF
        FFF08F55558F5FFFFFF80BFBFB0F000000F08F55558F888888580FBFBF0FFFFF
        FFF085F5558F5FFFFFF850FBFB0F000000F0585FFF8F888888585800000FFFFF
        FFF05588888F5FF55FF85555550F00FF00005555558F885588885555550FFFFF
        0F055555558F55558F855555550FFFFF00555555558FFFFF8855555555000000
        0555555555888888855555555555555555555555555555555555}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = B_EditClick
      ButtonType = btEdit
    end
  end
  object ActionList1: TActionList
    Left = 552
    Top = 24
    object A_Exit: TAction
      Caption = 'A_Exit'
      ShortCut = 27
      OnExecute = B_ExitClick
    end
    object A_Edit: TAction
      Caption = 'A_Edit'
      ShortCut = 16397
      OnExecute = B_EditClick
    end
    object A_Insert: TAction
      Caption = 'A_Insert'
      ShortCut = 45
      OnExecute = B_InsertClick
    end
  end
end
