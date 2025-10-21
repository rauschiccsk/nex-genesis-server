object F_ViewForm: TF_ViewForm
  Left = 352
  Top = 172
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
    Height = 322
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
    BorderWidth = 0
    BevelWidth = 1
    Head = 'Table Head'
    HeadFont.Charset = DEFAULT_CHARSET
    HeadFont.Color = clWhite
    HeadFont.Height = -15
    HeadFont.Name = 'Times New Roman'
    HeadFont.Style = []
    ToolBarHeight = 28
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
    ShowButtonPanel = True
    ShowButtons = [sbExitButton, sbAddButton, sbModButton, sbDelButton, sbPrintButton, sbFiltButton]
    AskBeforExit = True
  end
  object StatusLine: TxpStatusLine
    Left = 0
    Top = 322
    Width = 536
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
  object ActionList: TIcActionList
    Left = 32
    Top = 104
    object A_Exi: TAction
      Caption = 'A_Exi'
      ShortCut = 27
      OnExecute = A_ExiExecute
    end
  end
end
