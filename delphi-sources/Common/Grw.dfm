object GrwF: TGrwF
  Tag = 1203
  Left = 226
  Top = 160
  Width = 785
  Height = 514
  Hint = 'Kalkula'#269'n'#233' polo'#382'ky v'#253'kazu'
  Caption = '...'
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object P_Back: TDinamicPanel
    Left = 0
    Top = 0
    Width = 777
    Height = 461
    Align = alClient
    AutoSize = True
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    ColorThemes = acsStandard
    AutoExpand = False
    object TV_Grw: TTableView
      Left = 0
      Top = 0
      Width = 777
      Height = 461
      GridFont.Charset = DEFAULT_CHARSET
      GridFont.Color = clWindowText
      GridFont.Height = -11
      GridFont.Name = 'Arial'
      GridFont.Style = []
      Align = alClient
      TabStop = True
      SearchLnClear = True
      TabOrder = 0
      EnableMultiSelect = True
      BevelOuter = bvRaised
      BevelInner = bvLowered
      BorderWidth = 3
      BevelWidth = 1
      Head = '...'
      HeadFont.Charset = DEFAULT_CHARSET
      HeadFont.Color = clYellow
      HeadFont.Height = -16
      HeadFont.Name = 'Times New Roman'
      HeadFont.Style = [fsBold]
      ToolBarHeight = 28
      ShowRecNo = False
      DGDName = 'GRW'
      LoginName = '--------'
      ShowOnlyUserSet = False
      ServiceMode = False
      GDChange = True
      TabSet = -1
      GridModify = True
      ReadOnly = True
      Enabled = True
      MultiSelect = True
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
      OnSelected = B_EdiClick
      OnDrawColorRow = TV_GrwDrawColorRow
      DatabaseType = dtStandard
      ShowButtonPanel = True
      object B_Exi: TSpecSpeedButton
        Left = 7
        Top = 30
        Width = 25
        Height = 25
        Hint = 'Opusti'#357' zoznam'
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
        OnClick = B_ExiClick
        ButtonType = btExit
      end
      object B_Ins: TSpecSpeedButton
        Left = 31
        Top = 30
        Width = 25
        Height = 25
        Hint = 'Prida'#357' nov'#233' pozi'#269'n'#233' miesto'
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
        Visible = False
        OnClick = B_InsClick
        ButtonType = btInsert
      end
      object B_Edi: TSpecSpeedButton
        Left = 56
        Top = 30
        Width = 25
        Height = 25
        Hint = 'Upravi'#357' vybran'#233' pozi'#269'n'#233' miesto'
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
        Visible = False
        OnClick = B_EdiClick
        ButtonType = btEdit
      end
      object B_Del: TSpecSpeedButton
        Left = 81
        Top = 30
        Width = 25
        Height = 25
        Hint = 'Zru'#353'i'#357' vybran'#233' pozi'#269'n'#233' miesto'
        Flat = True
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          0400000000000001000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333FF33333333333330003333333333333888333333333333
          300033FFFFFF3333388839999993333333333888888F3333333F399999933333
          3300388888833333338833333333333333003333333333333388333333333333
          3333333333333333333F333333333333330033333F33333333883333C3333333
          330033338F3333333388333CC3333333333333F88FFFFFFF3FF33CCCCCCCCCC3
          993338888888888F88F33CCCCCCCCCC399333888888888838833333CC3333333
          333333388F33333333FF3333C333333330003333833333333888333333333333
          3000333333333333388833333333333333333333333333333333}
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        Visible = False
        OnClick = B_DelClick
        ButtonType = btDelete
      end
    end
  end
  object StatusLine: TxpStatusLine
    Left = 0
    Top = 461
    Width = 777
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
    TabOrder = 1
    BorderColorL = clWhite
    BorderColorD = 16743805
    LineColor = 16756655
    SystemColor = True
    Text = '2010;;;'
  end
  object ActionList: TActionList
    Left = 17
    Top = 104
    object A_Ins: TAction
      Caption = 'A_Ins'
      ShortCut = 45
      OnExecute = B_InsClick
    end
    object A_Exi: TAction
      Caption = 'A_Exi'
      ShortCut = 27
      OnExecute = B_ExiClick
    end
    object A_Del: TAction
      Caption = 'A_Del'
      ShortCut = 46
      OnExecute = B_DelClick
    end
  end
end
