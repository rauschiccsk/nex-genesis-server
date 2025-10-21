object F_ViewTmp: TF_ViewTmp
  Left = 226
  Top = 106
  Width = 544
  Height = 375
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Times New Roman'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 14
  object ApplicView: TApplicView
    Left = 0
    Top = 0
    Width = 536
    Height = 348
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
    Head = 'Table Head'
    HeadFont.Charset = DEFAULT_CHARSET
    HeadFont.Color = clYellow
    HeadFont.Height = -16
    HeadFont.Name = 'Times New Roman'
    HeadFont.Style = [fsBold]
    ToolBarHeight = 0
    ShowRecNo = False
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
    DatabaseType = dtBtrieve
    ShowButtonPanel = False
    ShowButtons = [sbExitButton]
    AskBeforExit = True
  end
  object IcActionList1: TIcActionList
    Left = 24
    Top = 80
    object A_Exit: TAction
      Caption = 'A_Exit'
      ShortCut = 27
      OnExecute = A_ExitExecute
    end
  end
end
