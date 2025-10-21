object GscLstV: TGscLstV
  Tag = 1105
  Left = 516
  Top = 138
  Width = 764
  Height = 548
  Caption = 'Zoznam tovarov'#253'ch polo'#382'iek'
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object Splitter1: TSplitter
    Left = 233
    Top = 42
    Width = 4
    Height = 472
    Cursor = crHSplit
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 756
    Height = 42
    ButtonHeight = 38
    ButtonWidth = 41
    Caption = 'ToolBar1'
    Flat = True
    Images = dmSYS.imLrgIco
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Action = A_Exit
      ParentShowHint = False
      ShowHint = True
    end
    object B_TreeView: TToolButton
      Left = 41
      Top = 0
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      Visible = False
      OnClick = B_TreeViewClick
    end
    object ToolButton3: TToolButton
      Left = 82
      Top = 0
      Width = 9
      Caption = 'ToolButton3'
      Style = tbsSeparator
    end
  end
  object P_TreeView: TxpSinglePanel
    Left = 0
    Top = 42
    Width = 233
    Height = 472
    SystemColor = True
    BasicColor = 16769505
    BorderColor = 16754085
    GradEndColor = 16769505
    GradStartColor = 16769505
    GradFillDir = fdXP
    BGStyle = bgsNone
    Color = 16769505
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 13107200
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = []
    Align = alLeft
    Visible = False
    TabOrder = 1
    object TV_MgTree: TTreeView
      Left = 0
      Top = 22
      Width = 233
      Height = 450
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Indent = 19
      ReadOnly = True
      TabOrder = 0
    end
    object SystemLine1: TSystemLine
      Left = 0
      Top = 0
      Width = 233
      Height = 22
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Zoznam tovarov'#253'ch skup'#237'n'
      Color = 16735838
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  object Pc_Gsl: TxpPageControl
    Left = 237
    Top = 42
    Width = 519
    Height = 472
    ActivePage = Ts_GslStc
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    Style = pcsXP
    TabIndex = 2
    TabOrder = 2
    TabPosition = tpBottom
    OnChange = Pc_GslChange
    TabTextAlignment = taCenter
    TabsShow = True
    SystemColor = False
    BasicColor = 16769505
    BorderColor = 16754085
    Color = 16769505
    object Ts_GslGsc: TxpTabSheet
      Caption = '&Evidencia tovaru'
      SystemColor = True
      BasicColor = 16769505
      Color = 16764365
      BGStyle = bgsGradient
      GradientStartColor = 16769505
      GradientEndColor = 16769505
      GradientFillDir = fdBottomToTop
      object Tv_GslGsc: TTableView
        Left = 0
        Top = 0
        Width = 517
        Height = 449
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
        DGDName = 'GSLGSC'
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
        OnSelected = Tv_GslSrcSelected
        DatabaseType = dtBtrieve
        ShowButtonPanel = False
      end
    end
    object Ts_GslPlc: TxpTabSheet
      Caption = '&Predajn'#253' cenn'#237'k'
      SystemColor = True
      BasicColor = 16769505
      Color = 16764365
      BGStyle = bgsGradient
      GradientStartColor = 16769505
      GradientEndColor = 16769505
      GradientFillDir = fdBottomToTop
      object Tv_GslPlc: TTableView
        Left = 0
        Top = 0
        Width = 517
        Height = 449
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
        DGDName = 'GSLPLC'
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
        OnSelected = Tv_GslSrcSelected
        DatabaseType = dtBtrieve
        ShowButtonPanel = False
      end
    end
    object Ts_GslStc: TxpTabSheet
      Caption = '&Skladov'#233' karty'
      SystemColor = True
      BasicColor = 16769505
      Color = 16764365
      BGStyle = bgsGradient
      GradientStartColor = 16769505
      GradientEndColor = 16769505
      GradientFillDir = fdBottomToTop
      object Tv_GslStc: TTableView
        Left = 0
        Top = 0
        Width = 517
        Height = 449
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
        DGDName = 'GSLSTC'
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
        OnSelected = Tv_GslSrcSelected
        OnDrawColorRow = Tv_GslStcDrawColorRow
        DatabaseType = dtBtrieve
        ShowButtonPanel = False
      end
    end
    object Ts_GslSlc: TxpTabSheet
      Caption = '&Filtrovan'#253' zoznam'
      SystemColor = True
      BasicColor = 16769505
      Color = 16764365
      BGStyle = bgsGradient
      GradientStartColor = 16769505
      GradientEndColor = 16769505
      GradientFillDir = fdBottomToTop
      object Tv_GslSrc: TTableView
        Left = 0
        Top = 0
        Width = 517
        Height = 431
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
        DGDName = 'GSLSRC'
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
        OnSelected = Tv_GslSrcSelected
        DatabaseType = dtBtrieve
        ShowButtonPanel = False
        DesignSize = (
          517
          431)
        object E_NonDia: TxpCheckBox
          Left = 208
          Top = 412
          Width = 114
          Height = 17
          SystemColor = True
          AutoCR = True
          Caption = 'Odstranit diakritiku'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Anchors = [akTop]
          ParentColor = False
          TabOrder = 4
          TabStop = True
          Transparent = False
          BasicColor = 16769505
          Color = 16769505
          CheckColor = 40960
          Checked = True
          CheckData = 'A'
        end
        object E_Upper: TxpCheckBox
          Left = 332
          Top = 412
          Width = 184
          Height = 17
          SystemColor = True
          AutoCR = True
          Caption = 'Nerozli'#353'ova'#357' ve'#318'ke a mal'#225' znaky'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Anchors = [akTop]
          ParentColor = False
          TabOrder = 5
          TabStop = True
          Transparent = False
          BasicColor = 16769505
          Color = 16769505
          CheckColor = 40960
          Checked = True
          CheckData = 'A'
        end
      end
      object E_SrcTxt: TxpEdit
        Left = 0
        Top = 431
        Width = 517
        Height = 18
        NumSepar = True
        SystemColor = True
        EditColors.Changed = True
        EditColors.BGNormal = clWhite
        EditColors.BGReadOnly = 16761795
        EditColors.BGInfoField = 16774645
        EditColors.BGActive = 16756655
        EditColors.BGModify = 16761795
        EditColors.BGExtText = 16764365
        EditColors.InactBorder = 16754085
        EditColors.ActBorder = 16743805
        BasicColor = 16769505
        Rounded = True
        RoundRadius = 3
        MarginLeft = 2
        MarginRight = 2
        Alignment = taLeftJustify
        EditorType = etString
        Frac = 0
        AsInteger = 0
        AutoFieldSet = True
        AutoCR = True
        ExtTextShow = False
        ExtMargin = 0
        InfoField = False
        Align = alBottom
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnModified = E_SrcTxtModified
      end
    end
  end
  object ActionList1: TActionList
    Left = 8
    Top = 160
    object A_Exit: TAction
      Caption = 'A_Exit'
      ImageIndex = 0
      ShortCut = 27
      OnExecute = A_ExitExecute
    end
    object A_ItmInfo: TAction
      Caption = 'A_ItmInfo'
      ShortCut = 115
    end
    object A_Insert: TAction
      Caption = 'A_Insert'
      ShortCut = 45
    end
    object A_Edit: TAction
      Caption = 'A_Edit'
      ShortCut = 16397
    end
    object A_StcLst: TAction
      Caption = 'A_StcLst'
      ShortCut = 32851
    end
    object A_PlsSlct: TAction
      Caption = 'A_PlsSlct'
      ShortCut = 117
    end
    object A_FifLst: TAction
      Caption = 'A_FifLst'
      ShortCut = 32837
    end
    object A_StmLst: TAction
      Caption = 'A_StmLst'
      ShortCut = 32840
    end
    object A_BcSrch: TAction
      Caption = 'A_BcSrch'
      ShortCut = 16450
    end
    object A_TreeView: TAction
      Caption = 'A_TreeView'
      ShortCut = 123
    end
  end
end
