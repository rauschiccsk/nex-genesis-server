object F_JrnAccF: TF_JrnAccF
  Tag = 1202
  Left = 531
  Top = 694
  Width = 469
  Height = 153
  Caption = 'Vyhotovenie '#250#269'tovn'#253'ch z'#225'pisov'
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 453
    Height = 66
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    object LeftLabel1: TLeftLabel
      Left = 11
      Top = 3
      Width = 110
      Height = 15
      Caption = 'Stru'#269'n'#233' inform'#225'cie:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
      FixedSize = False
    end
    object LeftLabel2: TLeftLabel
      Left = 28
      Top = 19
      Width = 425
      Height = 46
      AutoSize = False
      Caption = 
        'T'#225'to funkcia roz'#250#269'tuje vybran'#253' doklad a ulo'#382#237' vytvoren'#233' '#250#269'tovn'#233' ' +
        'z'#225'pisy do denn'#237'ka UZ. Ak dan'#253' doklad u'#382' bol roz'#250#269'tovan'#253' potom st' +
        'ar'#233' '#250#269'tovn'#233' z'#225'pisy bud'#250' odstr'#225'nen'#233' z denn'#237'ka UZ.'
      WordWrap = True
      FixedSize = False
    end
    object L_ExtNum: TNameInfo
      Left = 371
      Top = 1
      Width = 90
      Height = 20
      Alignment = taLeftJustify
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Visible = False
    end
  end
  object DinamicPanel1: TDinamicPanel
    Left = 0
    Top = 66
    Width = 453
    Height = 48
    Align = alClient
    BevelInner = bvLowered
    BorderWidth = 3
    Caption = ' '
    TabOrder = 1
    ColorThemes = acsStandard
    AutoExpand = False
    DesignSize = (
      453
      48)
    object CenterLabel1: TCenterLabel
      Left = 106
      Top = 11
      Width = 283
      Height = 15
      Alignment = taCenter
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 'Roz'#250#269'tovanie vybran'#233'ho dokladu'
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      FixedSize = True
    end
    object CenterLabel2: TCenterLabel
      Left = 392
      Top = 11
      Width = 58
      Height = 15
      Alignment = taCenter
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = 'Polo'#382'ky'
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      FixedSize = True
    end
    object CenterLabel3: TCenterLabel
      Left = 11
      Top = 11
      Width = 91
      Height = 15
      Alignment = taCenter
      AutoSize = False
      Caption = 'Doklad'
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      FixedSize = True
    end
    object PB_Indicator: TIcProgressBar
      Left = 107
      Top = 26
      Width = 283
      Height = 20
      Anchors = [akLeft, akTop, akRight]
      Min = 0
      Max = 100
      TabOrder = 0
      Skip = 0
    end
    object L_ItmCnt: TLongInfo
      Left = 393
      Top = 26
      Width = 59
      Height = 20
      Alignment = taRightJustify
      Text = '0'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Anchors = [akTop, akRight]
      Long = 0
    end
    object L_DocNum: TNameInfo
      Left = 12
      Top = 26
      Width = 90
      Height = 20
      Alignment = taLeftJustify
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
    end
  end
  object ptACC: TPxTable
    BeforeOpen = ptACCBeforeOpen
    TableName = 'ACC'
    Left = 1
    Top = 65534
  end
  object btSTKLST: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'STKLST'
    TableName = 'STKLST'
    DOSStrings = True
    DefName = 'STKLST.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 60
    Top = 65534
  end
  object btJOURNAL: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'JOURNAL'
    TableName = 'JOURNAL'
    DOSStrings = True
    DefName = 'JOURNAL.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 30
    Top = 65534
  end
  object btWRILST: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'WRILST'
    TableName = 'WRILST'
    DOSStrings = True
    DefName = 'WRILST.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 89
    Top = 65534
  end
  object btSMLST: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'SMLST'
    TableName = 'SMLST'
    DOSStrings = True
    DefName = 'SMLST.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 117
    Top = 65535
  end
  object btICI: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'ICI'
    TableName = 'ICI'
    DOSStrings = True
    DefName = 'ICI.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 149
    Top = 65535
  end
  object btSOI: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'SOI'
    DOSStrings = True
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 178
    Top = 65535
  end
  object btISI: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'ISI'
    DOSStrings = True
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 208
    Top = 65534
  end
  object btCSI: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'CSI'
    DOSStrings = True
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 238
  end
  object btTCH: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'TCH'
    DOSStrings = True
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 272
  end
  object btTSH: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'TSH'
    DOSStrings = True
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 304
  end
  object btACCANL: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'ACCANL'
    DOSStrings = True
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 336
  end
  object btOWI: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'OWI'
    DOSStrings = True
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 2
    Top = 26
  end
  object btPMI: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'PMI'
    DOSStrings = True
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 34
    Top = 26
  end
end
