object ParLst: TParLst
  Tag = 1105
  Left = 486
  Top = 271
  Width = 1092
  Height = 578
  Caption = 'Zoznam firiem'
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
  object xpStatusLine1: TxpStatusLine
    Left = 0
    Top = 520
    Width = 1076
    Height = 19
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'xpStatusLine1'
    Color = 16769505
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    BorderColorL = clWhite
    BorderColorD = 16743805
    LineColor = 16756655
    SystemColor = True
    Text = '2010;;;'
  end
  object P_Inf: TxpSinglePanel
    Left = 0
    Top = 0
    Width = 1076
    Height = 76
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
    Align = alTop
    TabOrder = 1
    object P_Txt: TPanel
      Left = 77
      Top = 0
      Width = 999
      Height = 76
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 0
      object H_Txt: TLabel
        Left = 3
        Top = 2
        Width = 125
        Height = 16
        Caption = 'Stru'#269'n'#233' inform'#225'cie:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object T_Txt: TLabel
        Left = 15
        Top = 19
        Width = 1253
        Height = 52
        AutoSize = False
        Caption = 
          'T'#225'to funkcia umo'#382'n'#237' vybra'#357' potrebn'#250' firmu, na ktor'#250' chcete zaevi' +
          'dova'#357' doklad.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
    end
    object P_Ico: TxpSinglePanel
      Left = 0
      Top = 0
      Width = 77
      Height = 76
      SystemColor = False
      BasicColor = 16769505
      BorderColor = 14680063
      GradEndColor = 16769505
      GradStartColor = 16769505
      GradFillDir = fdXP
      BGStyle = bgsNone
      Color = 14680063
      Align = alLeft
      TabOrder = 1
      object I_Ico: TImage
        Left = 3
        Top = 3
        Width = 70
        Height = 70
        Proportional = True
        Transparent = True
      end
    end
  end
  object P_EmlHis: TxpSinglePanel
    Left = 0
    Top = 76
    Width = 1076
    Height = 444
    SystemColor = False
    BasicColor = clSilver
    BorderColor = clWhite
    GradEndColor = clSilver
    GradStartColor = clSilver
    GradFillDir = fdXP
    BGStyle = bgsNone
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 3421236
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = []
    Align = alClient
    TabOrder = 2
    object P_DocNum: TxpSinglePanel
      Left = 0
      Top = 0
      Width = 1076
      Height = 35
      SystemColor = False
      BasicColor = 16769505
      BorderColor = clSilver
      GradEndColor = 15132390
      GradStartColor = clSilver
      GradFillDir = fdXP
      BGStyle = bgsGradient
      Color = 16769505
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      Align = alTop
      TabOrder = 0
      object L_HedTxt: TxpLabel
        Left = 0
        Top = 0
        Width = 1076
        Height = 35
        SystemColor = False
        Align = alClient
        Alignment = taCenter
        Caption = 'ZOZNAM FIRIEM'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
      end
    end
    object Tv_ParLst: TTableView
      Left = 0
      Top = 35
      Width = 1076
      Height = 409
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
      BevelOuter = bvRaised
      BevelInner = bvLowered
      BorderWidth = 0
      BevelWidth = 0
      HeadFont.Charset = DEFAULT_CHARSET
      HeadFont.Color = clWhite
      HeadFont.Height = -13
      HeadFont.Name = 'Arial'
      HeadFont.Style = []
      ToolBarHeight = 0
      ShowRecNo = False
      DGDName = 'PARLST'
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
      OnSelected = Tv_ParLstSelected
      DatabaseType = dtStandard
      ShowButtonPanel = False
    end
  end
  object ActionList: TActionList
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
