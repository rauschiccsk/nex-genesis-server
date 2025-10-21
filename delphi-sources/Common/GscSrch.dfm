object GscSrchV: TGscSrchV
  Tag = 1804003
  Left = 349
  Top = 168
  Width = 638
  Height = 444
  Caption = 'Zoznam n'#225'jden'#253'ch polo'#382'iek'
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
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 630
    Height = 42
    ButtonHeight = 38
    ButtonWidth = 41
    Caption = 'ToolBar1'
    Flat = True
    Images = dmSYS.imLrgIco
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    object B_Exi: TToolButton
      Left = 0
      Top = 0
      Action = A_Exi
      ParentShowHint = False
      ShowHint = True
    end
    object ToolButton3: TToolButton
      Left = 41
      Top = 0
      Width = 9
      Caption = 'ToolButton3'
      Style = tbsSeparator
    end
  end
  object Tv_GscSrch: TTableView
    Left = 0
    Top = 42
    Width = 630
    Height = 368
    GridFont.Charset = DEFAULT_CHARSET
    GridFont.Color = clWindowText
    GridFont.Height = -11
    GridFont.Name = 'Arial'
    GridFont.Style = []
    Align = alClient
    TabStop = True
    SearchLnClear = True
    TabOrder = 1
    EnableMultiSelect = False
    BevelOuter = bvNone
    BevelInner = bvNone
    BorderWidth = 0
    BevelWidth = 1
    Head = 'Zoznam tovarov'#253'ch polo'#382'iek'
    HeadFont.Charset = DEFAULT_CHARSET
    HeadFont.Color = clWhite
    HeadFont.Height = -16
    HeadFont.Name = 'Times New Roman'
    HeadFont.Style = []
    ToolBarHeight = 0
    ShowRecNo = False
    DGDName = 'GSCSRCH'
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
    OnSelected = Tv_GscSrchSelected
    DatabaseType = dtBtrieve
    ShowButtonPanel = False
  end
  object ActionList: TActionList
    Left = 8
    Top = 160
    object A_Exi: TAction
      Caption = 'A_Exit'
      ImageIndex = 0
      ShortCut = 27
      OnExecute = A_ExiExecute
    end
  end
end
