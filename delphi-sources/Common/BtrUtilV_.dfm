object F_BtrUtilV: TF_BtrUtilV
  Tag = 1002
  Left = 104
  Top = 90
  Width = 1000
  Height = 480
  Caption = 'Prezeranie datab'#225'zov'#253'ch s'#250'borov'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object TV_Table: TTableView
    Left = 0
    Top = 331
    Width = 992
    Height = 115
    GridFont.Charset = DEFAULT_CHARSET
    GridFont.Color = clWindowText
    GridFont.Height = -11
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
    OnChangeIndex = TV_TableChangeIndex
    OnCtrlDelPressed = TV_TableCtrlDelPressed
    OnDataChange = TV_TableDataChange
    OnInsPressed = TV_TableInsPressed
    DatabaseType = dtBtrieve
    ShowButtonPanel = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 296
    Width = 992
    Height = 35
    Align = alTop
    TabOrder = 1
    object DBN_Table: TDBNavigator
      Left = 4
      Top = 4
      Width = 225
      Height = 25
      DataSource = DS_Table
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbRefresh]
      Flat = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object ChB_ReadOnly: TCheckButton
      Left = 235
      Top = 2
      Width = 164
      Height = 17
      Caption = 'Len prezera'#357
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 1
      OnClick = ChB_ReadOnlyClick
    end
    object ChB_AskBeforeDelete: TCheckButton
      Left = 235
      Top = 16
      Width = 164
      Height = 17
      Caption = 'Potvrdi'#357' pri zru'#353'en'#237' '#250'dajov'
      Checked = True
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 2
      OnClick = ChB_AskBeforeDeleteClick
    end
    object ChB_Search: TCheckButton
      Left = 404
      Top = 2
      Width = 154
      Height = 17
      Caption = 'Sekven'#269'n'#233' vyh'#318'ad'#225'vanie'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = ChB_SearchClick
    end
    object ChB_Replace: TCheckButton
      Left = 404
      Top = 16
      Width = 154
      Height = 17
      Caption = 'Nahradi'#357' re'#357'azec'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = ChB_ReplaceClick
    end
    object ChB_Filter: TCheckButton
      Left = 563
      Top = 2
      Width = 96
      Height = 17
      Caption = 'Filtrova'#357
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = ChB_FilterClick
    end
    object I_Actpos: TNwNumInfo
      Left = 562
      Top = 18
      Width = 87
      Height = 15
      CharCount = 10
      Alignment = taRightJustify
      Long = 0
      Doub = 123456789
      Value = 123456789
      Fract = 0
      BorderColor = clBackground
      Color = 16773087
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clActiveCaption
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      TabOrder = 6
      DesignSize = (
        87
        15)
    end
    object I_IndexName: TNwNameInfo
      Left = 651
      Top = 16
      Width = 247
      Height = 17
      CharCount = 30
      Alignment = taLeftJustify
      BorderColor = clBackground
      Color = 16773087
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      TabOrder = 7
      DesignSize = (
        247
        17)
    end
    object B_DelToBtr: TButton
      Left = 904
      Top = 8
      Width = 80
      Height = 25
      Caption = 'DEL to BTR'
      Enabled = False
      TabOrder = 8
      Visible = False
      OnClick = B_DelToBtrClick
    end
  end
  object GB_Search: TGroupBox
    Left = 0
    Top = 0
    Width = 992
    Height = 101
    Align = alTop
    Caption = ' Sekven'#269'n'#233' vyh'#318'ad'#225'vanie '
    TabOrder = 2
    Visible = False
    object SpecLabel1: TSpecLabel
      Left = 12
      Top = 48
      Width = 94
      Height = 15
      Caption = 'Vyh'#318'ada'#357' re'#357'azec'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      FixedSize = False
    end
    object SpecLabel2: TSpecLabel
      Left = 12
      Top = 21
      Width = 104
      Height = 15
      Caption = 'Vyh'#318'ad'#225'va'#357' na poli'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      FixedSize = False
    end
    object ChB_Find: TCheckButton
      Left = 128
      Top = 72
      Width = 149
      Height = 17
      Caption = 'H'#318'ada'#357' presne'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object B_FindFirst: TSpecButton
      Left = 548
      Top = 12
      Width = 121
      Height = 25
      Caption = 'H'#318'ada'#357' prv'#253
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = B_FindFirstClick
      Glyph.Data = {00000000}
      ButtonType = btNone
    end
    object B_FindNext: TSpecButton
      Left = 548
      Top = 40
      Width = 121
      Height = 25
      Caption = 'H'#318'ada'#357' '#271'al'#353#237
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = B_FindNextClick
      Glyph.Data = {00000000}
      ButtonType = btNone
    end
    object CB_SearchField: TIcComboBox
      Left = 128
      Top = 16
      Width = 161
      Height = 23
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 15
      ParentFont = False
      TabOrder = 3
    end
    object ChB_NoCaseSensitive: TCheckButton
      Left = 284
      Top = 72
      Width = 233
      Height = 17
      Caption = 'Nerozli'#353'ova'#357' mal'#233' a ve'#318'k'#233' p'#237'smen'#225
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 4
    end
    object B_SearchCancel: TSpecButton
      Left = 548
      Top = 68
      Width = 121
      Height = 25
      Caption = 'Preru'#353'i'#357
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = B_CancelClick
      Glyph.Data = {00000000}
      ButtonType = btNone
    end
    object E_SearchText: TNameEdit
      Left = 128
      Top = 44
      Width = 409
      Height = 20
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 40
      ParentFont = False
      TabOrder = 6
      FixedFont = False
    end
  end
  object GB_Replace: TGroupBox
    Left = 0
    Top = 181
    Width = 992
    Height = 115
    Align = alTop
    Caption = ' Nahradi'#357' re'#357'azec '
    TabOrder = 3
    Visible = False
    object SpecLabel3: TSpecLabel
      Left = 12
      Top = 21
      Width = 104
      Height = 15
      Caption = 'Vyh'#318'ad'#225'va'#357' na poli'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      FixedSize = False
    end
    object SpecLabel4: TSpecLabel
      Left = 12
      Top = 46
      Width = 94
      Height = 15
      Caption = 'Vyh'#318'ada'#357' re'#357'azec'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      FixedSize = False
    end
    object SpecLabel5: TSpecLabel
      Left = 12
      Top = 68
      Width = 90
      Height = 15
      Caption = 'Nahradi'#357' re'#357'azec'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      FixedSize = False
    end
    object Label1: TLabel
      Left = 292
      Top = 21
      Width = 18
      Height = 13
      Caption = '<<<'
    end
    object CB_ReplaceField: TIcComboBox
      Left = 128
      Top = 16
      Width = 161
      Height = 23
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 15
      ParentFont = False
      TabOrder = 0
    end
    object E_ReplStrSrc: TNameEdit
      Left = 128
      Top = 42
      Width = 409
      Height = 20
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 40
      ParentFont = False
      TabOrder = 1
      FixedFont = False
    end
    object E_ReplStrTrg: TNameEdit
      Left = 128
      Top = 64
      Width = 409
      Height = 20
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 40
      ParentFont = False
      TabOrder = 2
      FixedFont = False
    end
    object B_ReplaceFirst: TSpecButton
      Left = 548
      Top = 12
      Width = 121
      Height = 25
      Caption = 'Nahradi'#357' prv'#253
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = B_ReplaceFirstClick
      Glyph.Data = {00000000}
      ButtonType = btNone
    end
    object B_ReplaceNext: TSpecButton
      Left = 548
      Top = 40
      Width = 121
      Height = 25
      Caption = 'Nahradi'#357' '#271'al'#353#237
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = B_ReplaceNextClick
      Glyph.Data = {00000000}
      ButtonType = btNone
    end
    object B_ReplaceCancel: TSpecButton
      Left = 548
      Top = 68
      Width = 121
      Height = 25
      Caption = 'Preru'#353'i'#357
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = B_CancelClick
      Glyph.Data = {00000000}
      ButtonType = btNone
    end
    object ChB_ReplaceAll: TCheckButton
      Left = 128
      Top = 92
      Width = 108
      Height = 17
      Caption = 'Nahradi'#357' v'#353'etky'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
    object ChB_ReplaceFind: TCheckButton
      Left = 243
      Top = 92
      Width = 100
      Height = 17
      Caption = 'H'#318'ada'#357' presne'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 7
    end
    object ChB_FillField: TCheckButton
      Left = 345
      Top = 92
      Width = 90
      Height = 17
      Caption = 'Doplni'#357' pole'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      OnClick = ChB_FillFieldClick
    end
    object CB_SourceField: TIcComboBox
      Left = 313
      Top = 16
      Width = 161
      Height = 23
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 15
      ParentFont = False
      TabOrder = 9
    end
    object ChB_CopyField: TCheckButton
      Left = 438
      Top = 92
      Width = 101
      Height = 17
      Caption = 'Kop'#237'rova'#357' pole'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      OnClick = ChB_FillFieldClick
    end
  end
  object GB_Filter: TGroupBox
    Left = 0
    Top = 101
    Width = 992
    Height = 80
    Align = alTop
    Caption = ' Filtrovanie '
    TabOrder = 4
    Visible = False
    object SpecLabel6: TSpecLabel
      Left = 12
      Top = 39
      Width = 92
      Height = 15
      Caption = 'Filtrovac'#237' re'#357'azec'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      FixedSize = False
    end
    object SpecLabel7: TSpecLabel
      Left = 12
      Top = 15
      Width = 83
      Height = 15
      Caption = 'Filtrovan'#233' pole '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      FixedSize = False
    end
    object ChB_FilterBTR: TCheckButton
      Left = 128
      Top = 58
      Width = 149
      Height = 17
      Caption = 'Filtrova'#357' datab'#225'zu'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = ChB_FilterBTRClick
    end
    object E_FilterStr: TNameEdit
      Left = 128
      Top = 37
      Width = 409
      Height = 20
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 100
      ParentFont = False
      TabOrder = 1
      Text = '[0]<{10}'
      FixedFont = False
    end
    object CB_FilterField: TIcComboBox
      Left = 128
      Top = 11
      Width = 161
      Height = 23
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 15
      ParentFont = False
      TabOrder = 2
    end
    object SB_InsFilterField: TSpecButton
      Left = 292
      Top = 10
      Width = 121
      Height = 25
      Caption = 'Vlo'#382'i'#357' filtrovan'#233' pole'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = SB_InsFilterFieldClick
      Glyph.Data = {00000000}
      ButtonType = btNone
    end
    object B_Renumber: TSpecButton
      Left = 544
      Top = 10
      Width = 155
      Height = 25
      Caption = 'Pre'#269#237'slova'#357' pole z konca'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = B_RenumberClick
      Glyph.Data = {00000000}
      ButtonType = btNone
    end
    object B_RenumberF: TSpecButton
      Left = 543
      Top = 42
      Width = 155
      Height = 25
      Caption = 'Pre'#269#237'slova'#357' pole od za'#269'iatku'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = B_RenumberFClick
      Glyph.Data = {00000000}
      ButtonType = btNone
    end
    object Button1: TButton
      Left = 704
      Top = 10
      Width = 193
      Height = 25
      Caption = 'Zrusit filtrovane polozky'
      TabOrder = 6
      OnClick = Button1Click
    end
  end
  object DS_Table: TDataSource
    DataSet = bt_Perview
    Left = 408
    Top = 12
  end
  object bt_Perview: TBtrieveTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    DOSStrings = True
    AutoCreate = True
    CrtDat = True
    Modify = False
    Sended = False
    Archive = False
    FieldDefs = <>
    Left = 368
    Top = 8
  end
  object IcActionList1: TIcActionList
    Left = 448
    Top = 8
    object A_Exit: TAction
      Caption = 'A_Exit'
      ShortCut = 27
      OnExecute = A_ExitExecute
    end
  end
end
