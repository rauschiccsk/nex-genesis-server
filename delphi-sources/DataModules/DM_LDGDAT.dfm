object dmLDG: TdmLDG
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 483
  Top = 164
  Height = 671
  Width = 917
  object btSACLST: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'SACLST'
    TableName = 'SACLST'
    DOSStrings = True
    DefName = 'SACLST.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 24
    Top = 3
  end
  object btSACITM: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'SACITM'
    TableName = 'SACITM'
    DOSStrings = True
    DefName = 'SACITM.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 80
    Top = 3
  end
  object ptSACITM: TNexPxTable
    Active = False
    TableName = 'SACITM'
    FixName = 'SACITM'
    DefName = 'SACITM.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 136
    Top = 3
  end
  object ptJRNHEAD: TPxTable
    BeforeOpen = ptJRNHEADBeforeOpen
    TableName = 'JRNHEAD'
    Left = 192
    Top = 3
  end
  object btICH: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'ICH'
    TableName = 'ICH'
    DOSStrings = True
    DefName = 'ICH.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    BeforePost = btICHBeforePost
    FieldDefs = <>
    Left = 66
    Top = 46
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
    Left = 127
    Top = 46
  end
  object ptICI: TNexPxTable
    Active = False
    TableName = 'ICI'
    FixName = 'ICI'
    DefName = 'ICI.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 156
    Top = 46
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
    Left = 24
    Top = 327
  end
  object btICN: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'ICN'
    TableName = 'ICN'
    DOSStrings = True
    DefName = 'ICN.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 186
    Top = 46
  end
  object T_LdgDat: TTimer
    Interval = 3000
    OnTimer = T_LdgDatTimer
    Left = 482
    Top = 65535
  end
  object ptICH: TNexPxTable
    Active = False
    TableName = 'ICH'
    FixName = 'ICH'
    DefName = 'ICH.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 97
    Top = 46
  end
  object btFXBLST: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'FXBLST'
    TableName = 'FXBLST'
    DOSStrings = True
    DefName = 'FXBLST.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    AfterOpen = btFXBLSTAfterOpen
    Left = 24
    Top = 162
  end
  object btFXA: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'FXA'
    TableName = 'FXA'
    DOSStrings = True
    DefName = 'FXA.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 68
    Top = 162
  end
  object btFXN: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'FXN'
    TableName = 'FXN'
    DOSStrings = True
    DefName = 'FXN.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 103
    Top = 162
  end
  object btFXT: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'FXT'
    TableName = 'FXT'
    DOSStrings = True
    DefName = 'FXT.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 149
    Top = 162
  end
  object ptFXT: TNexPxTable
    Active = False
    TableName = 'FXT'
    FixName = 'FXT'
    DefName = 'FXT.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 189
    Top = 162
  end
  object btFXL: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'FXL'
    TableName = 'FXL'
    DOSStrings = True
    DefName = 'FXL.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 229
    Top = 162
  end
  object ptFXL: TNexPxTable
    Active = False
    TableName = 'FXL'
    FixName = 'FXL'
    DefName = 'FXL.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 269
    Top = 162
  end
  object btFXC: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'FXC'
    TableName = 'FXC'
    DOSStrings = True
    DefName = 'FXC.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 309
    Top = 162
  end
  object ptFXC: TNexPxTable
    Active = False
    TableName = 'FXC'
    FixName = 'FXC'
    DefName = 'FXC.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 349
    Top = 162
  end
  object btFXAGRP: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'FXAGRP'
    TableName = 'FXAGRP'
    DOSStrings = True
    DefName = 'FXAGRP.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 396
    Top = 162
  end
  object btFXTGRP: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'FXTGRP'
    TableName = 'FXTGRP'
    DOSStrings = True
    DefName = 'FXTGRP.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 453
    Top = 162
  end
  object ptICIHIS: TNexPxTable
    Active = False
    TableName = 'ICIHIS'
    FixName = 'ICIHIS'
    DefName = 'ICIHIS.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 274
    Top = 45
  end
  object ptNOPVAT: TNexPxTable
    Active = False
    TableName = 'NOPVAT'
    FixName = 'NOPVAT'
    DefName = 'NOPVAT.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 748
    Top = 382
  end
  object btSPBLST: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'SPBLST'
    TableName = 'SPBLST'
    DOSStrings = True
    DefName = 'SPBLST.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    BeforePost = btSPBLSTBeforePost
    FieldDefs = <>
    Left = 24
    Top = 286
  end
  object btSPD: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'SPD'
    TableName = 'SPD'
    DOSStrings = True
    DefName = 'SPD.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 128
    Top = 286
  end
  object btISH: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'ISH'
    TableName = 'ISH'
    DOSStrings = True
    DefName = 'ISH.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 67
    Top = 87
  end
  object ptSPBLST: TNexPxTable
    Active = False
    TableName = 'SPBLST'
    FixName = 'SPBLST'
    DefName = 'SPBLST.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 79
    Top = 286
  end
  object ptSPD: TNexPxTable
    Active = False
    TableName = 'SPD'
    FixName = 'SPD'
    DefName = 'SPD.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 168
    Top = 285
  end
  object btISI: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'ISI'
    TableName = 'ISI'
    DOSStrings = True
    DefName = 'ISI.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 98
    Top = 87
  end
  object btISN: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'ISN'
    TableName = 'ISN'
    DOSStrings = True
    DefName = 'ISN.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 160
    Top = 87
  end
  object btFINJRN: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'FINJRN'
    TableName = 'FINJRN'
    DOSStrings = True
    DefName = 'FINJRN.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 504
    Top = 95
  end
  object ptFINJOUR: TNexPxTable
    Active = False
    TableName = 'FINJOUR'
    FixName = 'FINJOUR'
    DefName = 'FINJOUR.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 504
    Top = 47
  end
  object btACCANL: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'ACCANL'
    TableName = 'ACCANL'
    DOSStrings = True
    DefName = 'ACCANL.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 144
    Top = 327
  end
  object btCSH: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'CSH'
    TableName = 'CSH'
    DOSStrings = True
    DefName = 'CSH.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 69
    Top = 203
  end
  object btCSI: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'CSI'
    TableName = 'CSI'
    DOSStrings = True
    DefName = 'CSI.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 110
    Top = 203
  end
  object btCSN: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'CSN'
    TableName = 'CSN'
    DOSStrings = True
    DefName = 'CSN.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 190
    Top = 203
  end
  object btPMBLSTx: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'PMBLST'
    TableName = 'PMBLST'
    DOSStrings = True
    DefName = 'PMBLST.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 337
    Top = 368
  end
  object btSOHx: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'SOH'
    TableName = 'SOH'
    DOSStrings = True
    DefName = 'SOH.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 73
    Top = 369
  end
  object btSOIx: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'SOI'
    TableName = 'SOI'
    DOSStrings = True
    DefName = 'SOI.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 120
    Top = 369
  end
  object ptSOIx: TNexPxTable
    Active = False
    TableName = 'SOI'
    FixName = 'SOI'
    DefName = 'SOI.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 171
    Top = 369
  end
  object btPMIx: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'PMI'
    TableName = 'PMI'
    DOSStrings = True
    DefName = 'PMI.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 388
    Top = 368
  end
  object btSPV: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'SPV'
    TableName = 'SPV'
    DOSStrings = True
    DefName = 'SPV.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 208
    Top = 285
  end
  object ptCSI: TNexPxTable
    Active = False
    TableName = 'CSI'
    FixName = 'CSI'
    DefName = 'CSI.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 149
    Top = 203
  end
  object btCSOINC: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'CSOINC'
    TableName = 'CSOINC'
    DOSStrings = True
    DefName = 'CSOINC.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 294
    Top = 203
  end
  object btCSOEXP: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'CSOEXP'
    TableName = 'CSOEXP'
    DOSStrings = True
    DefName = 'CSOEXP.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 345
    Top = 203
  end
  object btACCSNT: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'ACCSNT'
    TableName = 'ACCSNT'
    DOSStrings = True
    DefName = 'ACCSNT.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 85
    Top = 327
  end
  object ptISI: TNexPxTable
    Active = False
    TableName = 'ISI'
    FixName = 'ISI'
    DefName = 'ISI.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 129
    Top = 88
  end
  object btIDH: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'IDH'
    TableName = 'IDH'
    DOSStrings = True
    DefName = 'IDH.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 69
    Top = 244
  end
  object btIDI: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'IDI'
    TableName = 'IDI'
    DOSStrings = True
    DefName = 'IDI.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 110
    Top = 244
  end
  object btIDN: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'IDN'
    TableName = 'IDN'
    DOSStrings = True
    DefName = 'IDN.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 190
    Top = 244
  end
  object ptIDI: TNexPxTable
    Active = False
    TableName = 'IDI'
    FixName = 'IDI'
    DefName = 'IDI.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 150
    Top = 245
  end
  object btIDMLST: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'IDMLST'
    TableName = 'IDMLST'
    DOSStrings = True
    DefName = 'IDMLST.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 292
    Top = 244
  end
  object btSOMLSTx: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'SOMLST'
    TableName = 'SOMLST'
    DOSStrings = True
    DefName = 'SOMLST.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 222
    Top = 369
  end
  object btACCTRN: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'ACCTRN'
    TableName = 'ACCTRN'
    DOSStrings = True
    DefName = 'ACCTRN.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 200
    Top = 327
  end
  object btISRLST: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'ISRLST'
    TableName = 'ISRLST'
    DOSStrings = True
    DefName = 'ISRLST.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 234
    Top = 87
  end
  object ptISH: TNexPxTable
    Active = False
    TableName = 'ISH'
    FixName = 'ISH'
    DefName = 'ISH.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 191
    Top = 87
  end
  object ptACC: TNexPxTable
    Active = False
    TableName = 'ACC'
    FixName = 'ACC'
    DefName = 'ACC.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 248
    Top = 327
  end
  object ptSPDSUM: TNexPxTable
    Active = False
    TableName = 'SPDSUM'
    FixName = 'SPDSUM'
    DefName = 'SPDSUM.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 354
    Top = 284
  end
  object btICRLST: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'ICRLST'
    TableName = 'ICRLST'
    DOSStrings = True
    DefName = 'ICRLST.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 227
    Top = 45
  end
  object btVTBLST: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'VTBLST'
    TableName = 'VTBLST'
    DOSStrings = True
    DefName = 'VTBLST.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 742
    Top = 269
  end
  object btVTBDOC: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'VTBDOC'
    TableName = 'VTBDOC'
    DOSStrings = True
    DefName = 'VTBDOC.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 744
    Top = 311
  end
  object ptVTBDOC: TNexPxTable
    Active = False
    TableName = 'VTBDOC'
    FixName = 'VTBDOC'
    DefName = 'VTBDOC.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 746
    Top = 354
  end
  object ptJOURNAL: TNexPxTable
    Active = False
    TableName = 'JRN'
    FixName = 'JRN'
    DefName = 'JOURNAL.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 304
    Top = 327
  end
  object btSNTINV: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'SNTINV'
    TableName = 'SNTINV'
    DOSStrings = True
    DefName = 'SNTINV.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 360
    Top = 326
  end
  object ptVTBSUM: TNexPxTable
    Active = False
    TableName = 'VTBSUM'
    FixName = 'VTBSUM'
    DefName = 'VTBSUM.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 747
    Top = 454
  end
  object btSRDOC: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'SRDOC'
    TableName = 'SRDOC'
    DOSStrings = True
    DefName = 'SRDOC.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 73
    Top = 453
  end
  object btSRMOV: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'SRMOV'
    TableName = 'SRMOV'
    DOSStrings = True
    DefName = 'SRMOV.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 123
    Top = 453
  end
  object btSRSTA: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'SRSTA'
    TableName = 'SRSTA'
    DOSStrings = True
    DefName = 'SRSTA.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 225
    Top = 452
  end
  object btSRCAT: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'SRCAT'
    TableName = 'SRCAT'
    DOSStrings = True
    DefName = 'SRCAT.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 24
    Top = 453
  end
  object ptSRMOV: TNexPxTable
    Active = False
    TableName = 'SRMOV'
    FixName = 'SRMOV'
    DefName = 'SRMOV.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 173
    Top = 452
  end
  object ptSRSTA: TNexPxTable
    Active = False
    TableName = 'SRSTA'
    FixName = 'SRSTA'
    DefName = 'SRSTA.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 277
    Top = 453
  end
  object ptSPV: TNexPxTable
    Active = False
    TableName = 'SPV'
    FixName = 'SPV'
    DefName = 'SPV.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 250
    Top = 285
  end
  object btPQH: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'PQH'
    TableName = 'PQH'
    DOSStrings = True
    DefName = 'PQH.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 8
    Top = 411
  end
  object btPQI: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'PQI'
    TableName = 'PQI'
    DOSStrings = True
    DefName = 'PQI.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 55
    Top = 411
  end
  object ptPQI: TNexPxTable
    Active = False
    TableName = 'PQI'
    FixName = 'PQI'
    DefName = 'PQI.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 106
    Top = 411
  end
  object ptCSH: TNexPxTable
    Active = False
    TableName = 'CSH'
    FixName = 'CSH'
    DefName = 'CSH.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 396
    Top = 203
  end
  object ptSRPRNS: TNexPxTable
    Active = False
    TableName = 'SRPRNS'
    FixName = 'SRPRNS'
    DefName = 'SRPRNS.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 330
    Top = 452
  end
  object ptSRPRNM: TNexPxTable
    Active = False
    TableName = 'SRPRNM'
    FixName = 'SRPRNM'
    DefName = 'SRPRNM.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 389
    Top = 452
  end
  object ptSRPRNH: TNexPxTable
    Active = False
    TableName = 'SRPRNH'
    FixName = 'SRPRNH'
    DefName = 'SRPRNH.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 448
    Top = 452
  end
  object btSUVDEF: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'SUVDEF'
    TableName = 'SUVDEF'
    DOSStrings = True
    DefName = 'SUVDEF.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 24
    Top = 496
  end
  object btVYSDEF: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'VYSDEF'
    TableName = 'VYSDEF'
    DOSStrings = True
    DefName = 'VYSDEF.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 80
    Top = 496
  end
  object btSUVCALC: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'SUVCALC'
    TableName = 'SUVCALC'
    DOSStrings = True
    DefName = 'SUVCALC.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 139
    Top = 496
  end
  object btVYSCALC: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'VYSCALC'
    TableName = 'VYSCALC'
    DOSStrings = True
    DefName = 'VYSCALC.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 200
    Top = 496
  end
  object btBLCLST: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'BLCLST'
    TableName = 'BLCLST'
    DOSStrings = True
    DefName = 'BLCLST.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 257
    Top = 496
  end
  object btSUV: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'SUV'
    TableName = 'SUV'
    DOSStrings = True
    DefName = 'SUV.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 305
    Top = 496
  end
  object btVYS: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'VYS'
    TableName = 'VYS'
    DOSStrings = True
    DefName = 'VYS.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 353
    Top = 496
  end
  object ptSUVCALC: TNexPxTable
    Active = False
    TableName = 'SUVCALC'
    FixName = 'SUVCALC'
    DefName = 'SUVCALC.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 401
    Top = 496
  end
  object ptVYSCALC: TNexPxTable
    Active = False
    TableName = 'VYSCALC'
    FixName = 'VYSCALC'
    DefName = 'VYSCALC.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 469
    Top = 496
  end
  object ptIDH: TNexPxTable
    Active = False
    TableName = 'IDH'
    FixName = 'IDH'
    DefName = 'IDH.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 344
    Top = 243
  end
  object imLedger: TImageList
    Height = 32
    Width = 32
    Left = 437
    Bitmap = {
      494C01010B000E00040020002000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000800000008000000001002000000000000000
      0100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000002152A5001063F7002942
      4A00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000294A6300294A7B003139
      3100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000633129001821
      1800000000000000000000000000000000001821180018211800182118001821
      1800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000002152A5001063F7001063F7002942
      4A00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000294A6300185AC6002152A5003139
      3100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000525252000000000073737300A59C
      9C00A59C9C00BDBDBD00BDBDBD00A59C9C007373730000000000182118000000
      0000182118001821180000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000002152A5001063F7001063F7001063F7002942
      4A00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000294A6300105AC6001063F700215AAD003139
      3100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001821180000000000A59C9C000000000000000000DEDE
      DE00DEDEDE00DEDEDE00DEDEDE00A59C9C00A59C9C0094949400949494007373
      7300000000000000000018211800182118000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000002152A5001063F7001063F7001063F7001063F700105A
      D6001863CE002163D600216BD600216BD600216BD6002163D600185AC600105A
      C600105AC600105AC600105AC600105AC600105AC600105AC600105AC600105A
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000029425A00185AC6001063F7001063F700215AAD003139
      3100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000001821180073737300DEDEDE00DEDEDE0000000000000000000000
      000073737300DEDEDE00DEDEDE00BDBDBD0052525200A59C9C00A59C9C007373
      7300525252004242420000000000182118001821180018211800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000029424A001063F7001063F7001063F7001063F7001063F7001063
      F7001063F7001063F7001063F7001063F7001063F7001063F7001063F7001063
      F7001063F7001063F7001063F7001063F7001063F7001063F7001063F7001063
      F700000000000000000000000000000000000000000000000000000000000000
      00000000000029425200185ABD001063F7001063F7001063F700105ACE002952
      8400294A7300294A7300294A7300294A7300294A7300294A7300294A7300294A
      7300294A7300294A7300294A7300294A7300294A7300294A7300294A7300294A
      7300294A73000000000000000000000000000000000000000000000000000000
      00000000000042424200A59C9C00A59C9C00DEDEDE00DEDEDE00000000007373
      7300A59C9C00A59C9C00DEDEDE00949494007373730073737300A59C9C007373
      7300737373005252520000000000182118001821180018211800182118001821
      1800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000031310800426B94001063F7001063F7001063F7001063F70052A5
      F7006BBDF7006BBDF7006BBDF7006BBDF7006BBDF7006BBDF7006BBDF7006BB5
      F7006BB5EF0063ADE7005A9CDE004A84BD0031639C00105AC6001063F7001063
      F700000000000000000000000000000000000000000000000000000000000000
      000031392900185AB5001063F7001063F7001063F7001063F7001063F7001063
      E7001063DE001063DE001063DE001063DE001063DE001063DE001063DE001063
      DE001063DE001063DE001063DE001063DE001063DE001063DE001063DE001063
      DE001063DE000000000000000000000000000000000000000000000000000000
      00000000000042424200A59C9C00A59C9C00A59C9C00DEDEDE00000000007373
      7300A59C9C00A59C9C00DEDEDE00949494007373730073737300A59C9C007373
      7300525252005252520000000000182118001821180018211800182118001821
      1800182118001821180000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000031310800637B4A00A5C694007BC6E7001063F7001063F7001063F7009CDE
      E700CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFF
      CE00CEFFCE00CEFFCE00CEFFCE00BDE7B5008CAD7B00316BA5001063F7001063
      F700000000000000000000000000000000000000000000000000000000000000
      000031393900185ABD001063F7001063F7001063F7001063F700105AF700186B
      E700297BF7002984FF002984FF002984FF002984FF002984FF002984FF002984
      FF002173EF001063DE001063DE001063DE001063DE001063DE00105AEF001063
      F7001063F7000000000000000000000000000000000000000000000000000000
      00000000000042424200A59C9C0073737300A59C9C00DEDEDE00000000007373
      7300A59C9C00A59C9C00DEDEDE00949494007373730073737300A59C9C007373
      7300182118005252520000000000182118001821180018211800182118001821
      1800182118001821180018211800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000526331009CC69400C6F7C600CEFFCE0084CEEF001063F7001063F7009CDE
      E700CEFFCE00C6F7C600BDEFBD00BDE7B500BDEFBD00CEFFC600CEFFCE00CEFF
      CE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00C6EFBD005294CE001063F7001063
      F700000000000000000000000000000000000000000000000000000000000000
      00000000000031425200105AC6001063F7001063F7001063F700105ACE00427B
      B50084C6EF0084CEEF0084CEEF0084CEEF0084CEEF0084CEEF0084CEEF0084CE
      EF006BADD60039638C00294A6B00294A6B00294A6B0029528400105AC6001063
      F7001063F7000000000000000000000000000000000000000000000000000000
      00000000000042424200A59C9C0073737300A59C9C00DEDEDE00000000007373
      7300A59C9C00A59C9C00DEDEDE00949494007373730073737300A59C9C007373
      7300182118005252520000000000182118001821180018211800182118001821
      1800182118001821180018211800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084A57300BDEFBD00CEFFCE00CEFFCE00CEFFCE0084CEEF001063F7009CDE
      E700A5CE9C008CA57B007B9463007B8C5A007B9463008CAD7B00A5C69400C6F7
      C600CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE0063ADEF001063F7001063
      F700000000000000000000000000000000000000000000000000000000000000
      0000000000000000000031425200105AC6001063F7001063F7002963B50084A5
      9C00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFF
      CE00CEFFCE006B7B4A00393908000000000000000000313931002152A5001063
      F7001063F7000000000000000000000000000000000000000000000000000000
      00000000000042424200A59C9C0073737300A59C9C00DEDEDE00000000007373
      7300A59C9C00A59C9C00DEDEDE00949494007373730073737300A59C9C007373
      7300182118005252520000000000182118001821180018211800182118001821
      1800182118001821180018211800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000003939
      1000ADD69C00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE0084CEEF008CBD
      BD005A6B39003939100000000000000000000000000039390800525A2900ADD6
      A500CEFFC600CEFFCE00CEFFCE00CEFFCE00CEFFCE006BB5F7001063F7001063
      F700000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000029425200105ACE001063F7003173C600A5D6
      CE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFF
      CE00CEFFCE009CBD8C00525A29000000000000000000313931002152A5001063
      F7001063F7000000000000000000000000000000000000000000000000000000
      00000000000042424200A59C9C0073737300A59C9C00DEDEDE00000000007373
      7300A59C9C00A59C9C00DEDEDE00949494007373730073737300A59C9C007373
      7300182118005252520000000000182118001821180018211800182118001821
      1800182118001821180018211800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005263
      3100B5E7AD00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00C6F7C6005A63
      310039390800000000000000000000000000000000000000000039390800849C
      6B00C6EFBD00CEFFCE00CEFFCE00CEFFCE00CEFFCE006BB5F7001063F7001063
      F700000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000031311000294252001863CE003984DE00ADEF
      DE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFF
      CE00CEFFCE00BDEFBD006B7B4A003131080000000000313931002152A5001063
      F7001063F7000000000000000000000000000000000000000000000000000000
      00000000000042424200A59C9C0073737300A59C9C00DEDEDE00000000007373
      7300A59C9C00A59C9C00DEDEDE00949494007373730073737300A59C9C007373
      7300182118005252520000000000182118001821180018211800182118001821
      1800182118001821180018211800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000525A
      3100B5DEAD00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00BDEFBD003939
      1000000000000000000000000000000000000000000000000000393908008CA5
      7B00C6F7BD00CEFFCE00CEFFCE00CEFFCE00CEFFCE006BBDF7001063F7001063
      F700000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000313110004A738C0073B5CE00BDF7
      DE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00BDEFBD00CEFFCE00CEFFCE00CEFF
      CE00CEFFCE00CEFFCE008CA57B004A4A210000000000313931002152A5001063
      F7001063F7000000000000000000000000000000000000000000000000000000
      00000000000042424200A59C9C0073737300A59C9C00DEDEDE00000000007373
      7300A59C9C00A59C9C00DEDEDE00949494007373730073737300A59C9C007373
      7300182118005252520000000000182118001821180018211800182118001821
      1800182118001821180000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000003942
      10005A633900636B4200636B4200636B4200636B4200636B42005A6B39003131
      08000000000000000000000000000000000031310800424A18007B8C6300C6F7
      BD00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE006BBDF7001063F7001063
      F700000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000393908007B9C7B00B5EFCE00C6FF
      D600CEFFCE00CEFFCE00CEFFCE00C6F7BD007B8C6300BDEFB500CEFFCE00CEFF
      CE00CEFFCE00CEFFCE00B5DEAD0063734A0000000000313931002152A5001063
      F7001063F7000000000000000000000000000000000000000000000000000000
      00000000000042424200A59C9C0073737300A59C9C00DEDEDE00000000007373
      7300A59C9C00A59C9C00DEDEDE00949494007373730073737300A59C9C007373
      7300182118005252520000000000182118001821180018211800182118001821
      1800182118000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000003131
      0800393908003939080039390800393908003939080039390800393908000000
      0000393908004A4A18005A6B3900738C5A0094AD7B00B5DEA500BDEFBD00CEFF
      CE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE006BB5F7001063F7001063
      F700000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000052633100A5C69400CEFFCE00CEFF
      CE00CEFFCE00CEFFCE00CEFFCE00B5DEA500424210008CA57B00C6F7C600CEFF
      CE00CEFFCE00CEFFCE00CEFFC6008CA57300424A1800313931002152A5001063
      F7001063F7000000000000000000000000000000000000000000000000000000
      00000000000042424200A59C9C0073737300A59C9C00DEDEDE00000000007373
      7300A59C9C00A59C9C00DEDEDE00949494007373730073737300A59C9C007373
      7300182118005252520000000000182118001821180018211800182118001821
      1800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000393908005263310073845A008CA5
      73009CBD8C00A5C69400ADD6A500B5E7B500C6F7BD00CEFFCE00CEFFCE00CEFF
      CE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE0063ADEF001063F7001063
      F700000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B8C6300BDEFBD00CEFFCE00CEFF
      CE00CEFFCE00CEFFCE00C6F7BD0084A573003131080052633100C6EFBD00CEFF
      CE00CEFFCE00CEFFCE00CEFFCE00ADD69C00636B4200313931002152A5001063
      F7001063F7000000000000000000000000000000000000000000000000000000
      00000000000042424200A59C9C0073737300A59C9C00DEDEDE00000000007373
      7300A59C9C00A59C9C00DEDEDE00949494007373730073737300A59C9C007373
      7300182118005252520000000000182118001821180018211800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000004242100063734200849C6B00A5C69400B5DEAD00C6F7
      BD00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFF
      CE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00C6F7BD0073A5B500315A94002952
      8C00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000004A4A18009CBD8400CEFFCE00CEFFCE00CEFF
      CE00CEFFCE00CEFFCE00B5E7B500525A31000000000039390800A5C69400CEFF
      C600CEFFCE00CEFFCE00CEFFCE00C6F7BD00849C6B00394239002152A5001063
      F7001063F7000000000000000000000000000000000000000000000000000000
      00000000000042424200A59C9C0073737300A59C9C00DEDEDE0000000000BDBD
      BD00A59C9C00BDBDBD00EFFFFF00A59C9C0063636300A59C9C00A59C9C00A59C
      9C00182118004242420000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004A5229007B946300A5CE9C00C6F7C600CEFFCE00CEFFCE00CEFF
      CE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFF
      CE00CEFFCE00CEFFCE00CEFFC600B5DEAD008CA57B005A633900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000006B845200B5DEAD00CEFFCE00CEFFCE00CEFF
      CE00CEFFCE00C6F7C6009CBD8C0039390800000000000000000073845200BDEF
      BD00CEFFCE00CEFFCE00CEFFCE00CEFFCE00A5C694004A635A002152A5001063
      F7001063F7000000000000000000000000000000000000000000000000000000
      00000000000042424200A59C9C00A59C9C00A59C9C0000000000DEDEDE00DEDE
      DE00DEDEDE00BDBDBD00BDBDBD00A59C9C009494940073737300737373007373
      7300737373004242420000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000042421000849C6B00BDE7B500CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFF
      CE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00C6EF
      BD00B5E7B500A5CE9C0094B5840073845A004A52210000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000003939100094B58400CEFFC600CEFFCE00CEFFCE00CEFF
      CE00CEFFCE00BDE7B50073845200000000000000000000000000424A1800ADD6
      9C00CEFFCE00CEFFCE00CEFFCE00CEFFCE00BDEFBD007394840021529400105A
      EF00105AEF000000000000000000000000000000000000000000000000000000
      00000000000042424200A59C9C00BDBDBD00BDBDBD0094949400949494006363
      6300424242004242420042424200293129002931290029312900525252005252
      5200525252004242420000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006B7B4A00B5DEAD00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFF
      CE00CEFFCE00CEFFCE00C6F7C600BDEFB500B5E7AD00B5DEA500A5CE9C008CA5
      7B00738C5A00525A310039391000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000005A6B3900ADD6A500CEFFCE00CEFFCE00CEFFCE00CEFF
      CE00CEFFCE00A5CE9C004A4A21000000000000000000000000000000000084A5
      7300C6EFBD00CEFFCE00CEFFCE00CEFFCE00CEFFCE0094BD9C00395A73002952
      8C0029528C000000000000000000000000000000000000000000000000000000
      00000000000042424200737373005252520063636300BDBDBD00DEDEDE00DEDE
      DE00DEDEDE00BDBDBD00A59C9C00A59C9C009494940073737300525252002931
      2900293129004242420000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009CBD8400C6F7C600CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFF
      CE00C6F7C600B5E7B5009CBD84007B8C6300637342004A522100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000393108008CA57B00C6F7BD00CEFFCE00CEFFCE00CEFFCE00CEFF
      CE00C6F7BD008CA5730000000000000000000000000000000000000000005A63
      3900B5DEAD00CEFFCE00CEFFCE00CEFFCE00CEFFCE00B5E7AD0073845A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000633129001821180042424200DEDEDE00DEDEDE000000000000000000DEDE
      DE00DEDEDE00BDBDBD00A59C9C00A59C9C009494940073737300636363006363
      6300636363001821180000000000737373000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000ADD6A500CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00C6F7
      BD00849C6B004A4A180031310800313108000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004A4A2100ADD6A500CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFF
      CE00ADD6A5005A6B390000000000000000000000000000000000000000003939
      10009CBD8C00CEFFC600CEFFCE00CEFFCE00CEFFCE00CEFFC60094B584004242
      1000000000000000000000000000000000000000000000000000000000000000
      00004242420094949400DEDEDE00DEDEDE00DEDEDE00DEDEDE00BDBDBD00BDBD
      BD00BDBDBD00A59C9C0094949400949494007373730063636300636363006363
      6300636363005252520042424200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000ADD6A500CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFC60094AD
      84004A4A2100313108000000000000000000000000000000000031310800738C
      5A0094AD7B0094B5840094B5840094B5840094B584008CA57300525A29000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B8C6300BDEFB500CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFF
      C60094B584003939100000000000000000000000000000000000000000000000
      000073845200B5E7AD00CEFFCE00CEFFCE00CEFFCE00CEFFCE00B5DEAD006B7B
      4A00000000000000000000000000000000000000000000000000000000000000
      00004242420094949400DEDEDE00BDBDBD00BDBDBD00BDBDBD00DEDEDE000000
      000000000000DEDEDE00DEDEDE00BDBDBD00BDBDBD0094949400525252005252
      5200525252005252520042424200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A5C69400CEFFC600CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE009CBD
      8400424A1000000000000000000000000000000000000000000042421000ADD6
      9C00C6EFBD00C6F7BD00C6F7BD00C6F7BD00C6F7BD00ADD6A500526331000000
      0000000000000000000000000000000000000000000000000000000000000000
      000039390800A5CE9C00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00BDE7
      B500738C5A000000000000000000000000000000000000000000000000000000
      00004A4A2100A5C69400CEFFCE00CEFFCE00CEFFCE00CEFFCE00C6F7BD0094AD
      7B00393908000000000000000000000000000000000000000000000000000000
      0000424242007373730094949400DEDEDE000000000000000000000000000000
      000000000000DEDEDE00DEDEDE00CECECE00BDBDBD00A59C9C00A59C9C009494
      9400949494004242420042424200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000849C6B00BDEFB500CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00BDEF
      B500849C6B005A6B42004A5229004A4A21004A522900637342008CAD7B00C6F7
      C600CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00ADD69C00424210000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000636B4200BDE7B500CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE009CBD
      8C004A5229000000000000000000000000000000000000000000000000000000
      000000000000849C6B00BDEFBD00CEFFCE00CEFFCE00CEFFCE00CEFFCE00B5DE
      A500525A31000000000000000000000000000000000000000000000000000000
      00004242420073737300DEDEDE00000000000000000000000000000000000000
      000000000000DEDEDE00DEDEDE00949494007373730073737300737373009494
      9400A59C9C009494940052525200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000525A3100A5CE9C00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFF
      CE00BDEFBD00A5CE9C0094B5840094B584009CBD8400A5CE9C00C6F7BD00CEFF
      CE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00BDEFBD0084A57300000000000000
      0000000000000000000000000000000000000000000000000000000000003131
      080094B58400C6F7C600CEFFCE00CEFFCE00CEFFCE00CEFFCE00C6F7BD00849C
      6B00313108000000000000000000000000000000000000000000000000000000
      0000000000005A6B3900A5CE9C00CEFFCE00CEFFCE00CEFFCE00CEFFCE00C6EF
      BD008CA573003131080000000000000000000000000000000000000000000000
      000042424200BDBDBD00DEDEDE00000000000000000000000000000000000000
      0000000000000000000000000000182118004242420042424200737373009494
      9400A59C9C009494940073737300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00003131080073845A00B5DEA500CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFF
      CE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFF
      CE00CEFFCE00CEFFCE00CEFFCE00CEFFC600A5C69400525A3100000000000000
      0000000000000000000000000000000000000000000000000000000000004A52
      2100BDEFBD00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00ADD69C006373
      4200000000000000000000000000000000000000000000000000000000000000
      000000000000393910008CAD7B00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFF
      CE00B5DEAD004242100000000000000000000000000000000000000000000000
      000042424200A59C9C00BDBDBD00DEDEDE000000000000000000000000000000
      0000DEDEDE00BDBDBD00BDBDBD0063636300000000001821180073737300A59C
      9C00949494009494940052525200424242000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004242100073845A00A5CE9C00BDEFB500CEFFCE00CEFFCE00CEFF
      CE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFF
      CE00CEFFCE00CEFFCE00BDEFBD00A5C694006B7B4A0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000849C
      6B00C6F7C600CEFFCE00CEFFCE00CEFFCE00CEFFCE00CEFFCE008CA57B004242
      1000000000000000000000000000000000000000000000000000000000000000
      000000000000000000006B7B4A00B5DEA500CEFFCE00CEFFCE00CEFFCE00CEFF
      CE00BDEFBD007B8C630000000000000000000000000000000000000000000000
      0000000000004242420042424200BDBDBD00DEDEDE00DEDEDE00000000004242
      42001821180042424200BDBDBD00636363009494940000000000A59C9C009494
      9400949494004242420000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000031310800525A29007B946300A5CE9C00B5E7AD00BDEF
      BD00C6EFBD00C6F7C600C6F7C600C6F7C600C6F7C600C6F7C600C6F7BD00BDEF
      BD00B5E7B500ADD69C0084A57300525A29000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BDE7
      B500C6F7BD00C6F7BD00C6F7BD00C6F7BD00C6F7BD00BDE7B500738452000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000424A18008CAD7B00C6F7BD00C6F7BD00C6F7BD00C6F7
      BD00C6EFBD00A5C6940000000000000000000000000000000000000000000000
      0000000000000000000000000000424242004242420094949400DEDEDE004242
      4200949494001821180018211800293129009494940000000000949494000000
      0000424242009494940000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000393908005A6331007B8C
      63008CA57B009CBD8C00A5CE9C00A5CE9C00A5CE9C00A5C694008CAD7B007B94
      63005A6B39003942100000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005263
      310052633100526331005263310052633100526331004A522100393908000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000424A18005263310052633100526331005263
      310052633100525A290039391000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000042424200424242004242
      4200424242001821180042424200000000000000000000000000424242000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000525252000000
      00000000000094949400DEDEDE00182118000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000393908003939080039390800393908003939080039390800393908003939
      0800393908003939080039390800393908003939080039390800393908003939
      0800393908003939080039390800393908003939080039390800393908003939
      0800000000000000000000000000000000000000000000000000393910003939
      1000393910003939100052523100525A52004A4A290039391000393908003939
      0800393908003939080039390800393908003939080039390800393908003939
      0800393908003939080039390800393908003939080039391000393910003939
      1000393910003939100000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000003939
      0800393908003939080039390800393908003939080039391000313908003939
      0800393908003939080039390800393908003939080039390800393908003939
      0800393908003939080039390800393908003939080039390800393908003939
      0800393908000000000000000000000000000000000000000000393910003939
      1000393910003939100063635A00425A73005263630042422100393908003939
      0800393908003939080039390800393908003939080039390800393908003939
      0800393908003939080039390800393908003939080039390800393910003939
      1000393910003939100000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000063000800420008002900080073424A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E7EFE700DEE7DE00D6E7
      D600CEDEC600C6D6C600BDCEB500B5CEAD00ADBDA5006B848400948C84006363
      4A004A4A18003939080031310800313108003131080039390800424A18005252
      29006B734A007B8C6B00A5BD9C00B5C6AD00BDCEB500BDD6BD00CED6C600CEDE
      CE00DEE7D600DEEFDE00000000000000000000000000FFFFFF00FFFFFF00F7FF
      F700EFF7EF00EFF7EF0084A5AD00B5C6BD008C7B6B0052636B00BDCEBD00CED6
      C600C6D6BD00BDCEBD00BDCEB500BDCEB500BDCEB500BDCEB500BDD6BD00C6D6
      BD00CEDEC600CEDECE00D6E7D600DEE7D600E7EFDE00E7EFE700EFF7EF00F7F7
      F700F7FFF700FFFFFF00FFFFFF00000000000000000000000000FFE7E700FFDE
      DE00FFDEDE00FFDEDE00FFDEDE00FFDEDE00FFDEDE00FFDEDE00FFDEDE00FFDE
      DE00FFDEDE00FFDEDE00FFDEDE00FFDEDE00FFDEDE00FFDEDE00FFDEDE00DEBD
      BD009C848C004A42420021212100393939005A5A5A0073737300ADA59C00FFEF
      EF00FFF7EF00FFF7F70000000000000000000000000000000000FFEFEF00FFE7
      E700FFE7E700FFE7E700FFDEDE00FFDEDE00FFDEDE00FFDEDE00FFDEDE00FFDE
      DE00FFDEDE00FFDEDE00FFDEDE00FFDEDE00FFDEDE00FFDEDE00393939005A5A
      5A007B7B7B0094949400ADADAD00CECECE00DED6D600EFDED600C6C6C6009C94
      9400FFF7F700FFFFF700000000000000000000000000DEE7DE00D6DECE00CEDE
      C600BDD6BD00BDCEB500ADBDA500737B5A00424210006BADC600ADCED6007B73
      6B004A4A29003131080031310800313108003131080031310800313108003131
      08003131080031310800424210006B734A00A5BD9C00B5CEAD00BDCEB500C6D6
      BD00CEDECE00D6E7D600393908000000000000000000FFFFFF00FFFFFF00F7F7
      F700EFF7EF00E7EFE700DEE7DE009CBDBD00C6CEC6006B635A0063737B00B5C6
      B500BDCEB500B5C6AD00ADC6AD00ADC6A500ADC6A500ADC6AD00B5CEAD00BDCE
      B500BDD6BD00C6D6C600CEDECE00D6DECE00DEE7D600DEEFDE00EFEFE700EFF7
      EF00F7F7F700FFFFFF00FFFFFF00000000000000000000000000FFDEDE00FFDE
      DE00FFDED600FFDEDE00FFDEDE00FFDEDE00FFDEDE00FFDED600FFD6D600FFD6
      D600FFD6D600FFD6D600FFDEDE00FFDEDE00FFDEDE00393939005A5A5A007B7B
      7B0094949400ADADAD00CECECE00DED6D600EFDED600C6C6C6009C949400FFEF
      EF00FFEFEF00FFF7EF0000000000000000000000000000000000FFE7E700FFE7
      E700FFDEDE00FFDEDE00FFDEDE00FFDEDE00FFDEDE00FFDED600FFDED600FFDE
      D600FFDED600FFDED600FFDED600FFDED600FFDED600FFDEDE00A5A5A500D6D6
      CE00EFE7DE00DEE7DE007B94AD00F7F7EF009C429C00BD947300CECECE008C84
      8C00FFF7F700FFFFF700000000000000000039390800DEE7D600CEDECE00C6D6
      BD00B5CEB5006B7B520039390800313108003131080031310800636B6300ADCE
      CE00737B73004A4A210031310800313108003131080031310800313108003131
      080031310800313108003131080031310800393108005A634200ADC6AD00BDCE
      B500C6D6C600CEDECE00393908000000000039391000FFFFFF00F7FFF700EFF7
      EF00E7EFE700DEEFDE00D6E7D600D6DECE0094B5C6009CB5AD00636B63006B84
      8C00424218003131080031310800313108003131080031310800313108003131
      080031310800848C7300CED6C600CEDECE00D6DECE00DEE7D600E7EFDE00EFEF
      E700F7F7F700F7FFF700FFFFFF00000000000000000000000000FFDEDE00FFDE
      DE00FFDED600FFD6D600FFD6D600FFD6D600FFD6D600FFD6D600FFD6D600FFD6
      D600FFD6D600FFD6D600FFD6D600FFD6D600FFD6D600A5A5A500D6D6CE00EFE7
      DE00DEE7DE007B94AD00F7F7EF009C429C00BD947300CECECE008C848400FFEF
      EF00FFEFEF00FFEFEF006B101000000000000000000000000000FFE7E700FFDE
      DE00FFDEDE00FFDEDE00FFDEDE00FFDEDE00FFD6D600FFD6D600FFD6D600FFD6
      D600FFD6D600FFD6D600FFD6D600FFD6D600FFD6D600FFDED600ADADA500736B
      9400DEC6AD00D6DED6009CC6BD00FFF7EF00FF7B7300B5CEA500D6D6D6001818
      18003131310039393900000000000000000039390800D6E7D600CEDEC600BDD6
      BD007B8C6B0039310800313108003131080031310800313108003131080063A5
      CE0094ADAD007B7B73004A4A2100313108003131080031310800313108003131
      0800313108003131080031310800313108003131080031310800636B4200ADBD
      A500BDCEB500C6D6C600393908003939080039391000FFFFFF00F7F7F700EFF7
      EF00E7EFDE00DEE7D600D6DECE00CEDECE00C6D6C6008CB5BD00A5AD9C007373
      6B00526B6B003939180031310800313108003131080031310800313108003131
      08003131080042421000C6D6BD00CEDEC600CEDECE00D6E7D600DEE7DE00E7EF
      E700EFF7EF00F7F7F700FFFFFF00393910000000000000000000FFD6D600FFD6
      D600FFD6D600FFD6D600FFD6D600FFD6D600FFD6D600FFD6D600FFD6D600FFD6
      D600FFD6D600FFD6D600FFD6D600FFD6D600FFD6D600ADADA500736B9400DEC6
      AD00D6DED6009CC6BD00FFF7EF00FF7B7300B5CEA500D6D6D600181818003131
      3100393939004242420029001000000000000000000000000000FFE7E700FFDE
      DE00FFDEDE00FFDEDE00FFD6D600FFD6D600FFD6D600FFD6D600FFD6D600FFD6
      D600FFD6D600FFD6D600FFD6D600FFD6D600FFD6D600635A5A00A5A5A500D6AD
      BD00EFD6D600DEE7DE00736B6B00F7F7F7004A736B00BDCEC600DEDEDE004242
      4200BDBDBD00CECECE00000000000000000039390800D6E7D600CEDEC6008C94
      7B00393908003131080031310800313108003131080031310800313108003939
      08005A635A0094BDB5006B6B6300393910003131080031310800313108003131
      080031310800313108003131080031310800313108003131080031310800525A
      2900B5C6AD00BDD6BD00393908003939080039391000F7FFF700F7F7F700E7EF
      E700DEE7DE00D6E7D600CEDEC600C6D6C600BDD6BD00BDCEB5008CB5B500ADB5
      B5007B7B730042636B0039390800313108003131080031310800313108003131
      08003131080031310800ADBDA500C6D6BD00CEDEC600CEDECE00D6E7D600DEEF
      DE00EFEFEF00F7F7F700F7FFF700393910000000000000000000FFD6D600FFD6
      D600FFD6D600FFD6D600FFD6D600FFD6D600FFD6D600FFD6D600FFD6CE00FFD6
      CE00FFD6CE00FFD6D600FFD6D600FFD6D600635A5A00A5A5A500D6ADBD00EFD6
      D600DEE7DE00736B6B00F7F7F7004A736B00BDCEC600DEDEDE0042424200BDBD
      BD00CECECE00A5A5A50021000800000000000000000000000000FFE7E700FFDE
      DE00FFDEDE00FFD6D600FFD6D600FFD6D600FFD6D600FFD6D600FFD6D600FFD6
      D600FFD6D600FFD6D600FFD6D600FFD6D600FFD6D6009C9C9C00ADA5A5008494
      6B00CEC6D600E7D6DE00737B4200F7F7F7007BA59C008CBDB500DEDEDE005252
      4A0094BDB5006373A500000000000000000039390800D6E7D600CEDEC6005252
      2100313108003131080031310800313108003131080031310800313108003131
      080039390800739C9C009CB5AD007B847300636B4A004A522900424218003131
      0800313108003131080031310800313108003131080031310800313108003939
      08009CB59400B5CEB500393908003939080039391000F7F7F700EFF7EF00E7EF
      E700DEE7D600CEDECE00C6D6C600BDD6BD00BDCEB500B5CEAD00A5B59400739C
      9C00ADAD9C005A6B7300425A5A00393908003131080031310800313108003131
      0800313108003131080063633900BDCEB500C6D6BD00CEDEC600D6DECE00DEE7
      D600E7EFE700EFF7EF00F7FFF700393910000000000000000000FFD6D600FFD6
      D600FFD6D600EFB5BD00DEA5A500D6949C00D68C9400CE8C9400CE8C9400CE8C
      9400CE8C9400CE8C9400D6949C00DE9CA5009C9C9C00ADA5A50084946B00CEC6
      D600E7D6DE00737B4200F7F7F7007BA59C008CBDB500DEDEDE0052524A0094BD
      B5006373A500BDBDBD0021080800000000000000000000000000FFDEDE00FFDE
      DE00FFDEDE00FFD6D600FFD6D600FFD6D600FFD6CE00FFD6CE00FFD6D600FFD6
      D600FFD6D600FFD6D600FFD6D600FFD6D600FFD6D6009C9C9C00ADA59C00CE9C
      9400BD7B7B00B5635A007B524200313131003131310039393900212121004A4A
      42007B9C94008CBDBD00000000000000000039390800D6E7D600CEDEC6003931
      0800313108003131080031310800313108003131080031310800313108005263
      31007B9463007B9C73007B8C8400A5BDB5007B8C7300739463006B945A006384
      4A00394208003131080031310800313108003131080031310800313108003131
      08006B734A00B5C6AD00393908003939080039391000F7F7F700EFF7EF00DEE7
      DE00D6DECE00CEDEC600BDD6BD00BDCEB500B5C6AD00ADC6A500737B5A003131
      08006B8C8C00ADBDAD005A736B004A5A5A003939100031310800313108003131
      0800313108003131080039391000A5B59C00BDD6BD00C6D6BD00CEDECE00D6DE
      CE00E7EFDE00EFEFEF00F7F7F700393910000000000000000000FFD6D600EFB5
      BD00CE8C9400CE8C9400CE8C9400C67B84009C4A52008C3139007B1821007B18
      21007B18210094394200AD5A6300CE8C94009C9C9C00ADA59C00CE9C9400BD7B
      7B00B5635A007B524200313131003131310039393900212121004A4A42007B9C
      94008CBDBD00C6C6BD0021081000000000000000000000000000FFDEDE00FFDE
      DE00FFD6D600FFD6D600FFD6D600E7C6D600D6B5DE00F7BDC600F7BDC600F7BD
      C600F7BDC600F7BDC600F7BDC600F7BDC600D6C6AD009C9C9C009C8C8C007B00
      08007B0008007B000800945252003131310094948C00A59C9400393129004242
      4200CED6CE00D6CEC600000000000000000039390800D6E7D600C6D6C6003131
      0800313108003131080031310800313108003131080031310800393908007B9C
      6B007B9C6B007B9C6B007B9C6B0073ADAD00A5BDB500848473006B8C5A00638C
      52004A6329003131080031310800313108003131080031310800313108003131
      08004A522900ADC6A500393908003939080039391000EFF7EF00E7EFE700DEE7
      D600CEDECE00C6D6BD00BDCEB500B5CEAD00ADC6A5009CB59400424210003131
      0800313108006B8C8C00B5AD9C007373630052635A0039391000313108003131
      08003131080031310800313108005A5A3100BDCEB500BDD6BD00CED6C600CEDE
      CE00DEE7DE00E7EFE700F7F7EF00393910000000000000000000CE8C9400CE8C
      9400A5525A006B08100000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009C9C9C009C8C8C007B0008007B00
      08007B000800945252003131310094948C00A59C94003931290042424200CED6
      CE00D6CEC600D6CEC60018081000000000000000000000000000FFDEDE00FFDE
      DE00FFD6D600FFD6D600FFD6D600D6B5DE00DEADB50000000000000000000000
      000000000000000000000000000000000000CE9494009C9C9C00A5948C008C31
      21008C392900944239009C5242009C5A52009C635A00A56B63009C736B003939
      39009473A5005A5A5200000000000000000039390800D6DECE00C6D6C6003131
      08003131080031310800313108003131080031310800313108004A5221007B9C
      6B007B9C6B007B9C6B007B9C6B00739C6B007B8C73009CBDBD00737B6B006384
      6300526B31003131080031310800313108003131080031310800313108003131
      08004A4A1800ADC6A500393908003939080039391000EFF7EF00E7EFDE00D6DE
      CE00C6D6C600BDCEBD00B5C6AD00ADC6A500A5BD9C00636B4200313108003131
      080031310800313108006B8C84009CB5AD003939390052636300424221003131
      080031310800313108003131080039390800ADBDA500BDCEB500C6D6BD00CEDE
      C600D6E7D600E7EFDE00EFF7EF00393910000000000000000000CE8C8C00A54A
      5200000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009C9C9C00A5948C008C3121008C39
      2900944239009C5242009C5A52009C635A00A56B63009C736B00393939009473
      A5005A5A5200D6C6BD0018081000000000000000000000000000FFDEDE00FFDE
      DE00FFD6D600FFD6D600FFD6D600D6B5DE007329520000000000000000000000
      000000000000000000000000000000000000844A42009C9C9C00848C84007B7B
      7B0094948C008C8484009C9494009C9494009C9494009C9C9C009C9C9C006B6B
      6B00C694B500A59C4A00000000000000000039390800D6DECE00C6D6BD005A63
      42005A633900525A3100525A3100525A31004A5A29004A5A29005A6B42007B9C
      6B007B9C6B007B9C6B007B9C6B00739C6B0073946B0073A5A5006B8C84005A6B
      6300525A39004242180039310800313108003131080031310800313108003131
      08004A4A1800ADC6A500393908003939080039391000E7EFE700DEE7DE00CEDE
      CE00C6D6BD00BDCEB500ADC6A500A5BDA5009CBD940042421000313108003131
      080031310800313108003131080084A59C00737B6B0029394200526B73005252
      39004A4A3100393918003131080031310800848C6B00B5CEAD00BDCEB500C6D6
      BD00D6DECE00DEE7DE00EFEFE7003939100000000000000000008C3139000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009C9C9C00848C84007B7B7B009494
      8C008C8484009C9494009C9494009C9494009C9C9C009C9C9C006B6B6B00C694
      B500A59C4A00D6D6BD0018101000000000000000000000000000FFDED600FFD6
      D600FFD6D600FFD6D600DEC6C600E7ADBD005200290000000000000000000000
      0000000000000000000000000000000000004A0029009C9C9C009CCEC6006BB5
      B500EFEFEF009C948C008C181000841810008418100084211800424239003939
      39002929290042424200000000000000000039390800D6DECE00C6D6BD00BDCE
      B500ADC6A500A5BD9C009CB5940094AD840084A57B0084A573007BA573007B9C
      6B007BA573007BA573007B9C6B007B9C6B00739463006B7B5A00737B73002131
      42000810390018215A0039425200393910003131080031310800313108003131
      08005A633900B5CEAD00393908003939080039391000E7EFDE00D6E7D600CEDE
      C600BDCEB500B5CEAD00ADC6A500A5BD9C00849C730031310800313108003131
      0800313108003131080031310800313108005A7B6B0063848400081021001831
      4A000821420039424200424218003131080042421000A5BD9C00BDCEB500BDD6
      BD00CEDEC600D6E7D600E7EFE700393910000000000000000000000000000000
      0000000000000000000000000000000000000000000073081000842931009439
      4200842931007308100000000000000000009C9C9C009CCEC6006BB5B500EFEF
      EF009C948C008C18100084181000841810008421180042423900393939002929
      2900424242002929290018181800000000000000000000000000FFDEDE00FFD6
      D600FFD6D600FFD6D600D6BDC600843952000000000000000000000000000000
      0000000000000000000000000000000000004A0029009C9C9C0094B5B5008C6B
      6300EFEFEF009C8C8C007B0008007B0008007B00080084181000ADA5A5008484
      7B00635A5A00ADADA500000000000000000039390800D6DECE00C6D6BD00BDCE
      B500ADC6A500A5BD9C009CB5940094AD840084A57B0084A573007BA573007BA5
      73007B946B006B7B52005A6B42004A522900394210003131080073736B004A6B
      9400849CBD0029427B0018214A004A4A31003131080031310800313108003131
      08007B846300BDCEB500393908003939080039390800DEE7D600D6DECE00C6D6
      BD00B5CEAD00ADC6AD00A5BD9C00A5BD9C005A63390031310800313108003131
      08003131080031310800313108003139080063844A0021527300213152002131
      6B000810630008104A0039424A0039390800313108007B846300B5CEAD00BDCE
      B500C6D6C600CEDECE00DEE7DE00393908000000000000000000000000000000
      000000000000000000000000000000000000CE8C9400CE8C9400D6949400D694
      9C00D6949400CE8C9400CE8C9400000000009C9C9C0094B5B5008C6B6300EFEF
      EF009C8C8C007B0008007B0008007B00080084181000ADA5A50084847B00635A
      5A00ADADA5003129290021181800000000000000000000000000FFDEDE00FFD6
      D600FFD6D600FFDEBD00D6BDC600520018000000000000000000000000000000
      000000000000000000000000000000000000000000009C9C9C00C69CB500A59C
      4A00EFEFEF009C949400A5847B00A57B7300A5736B009C6B63009C635A009C5A
      520094525200944A4A00000000000000000039390800D6DECE00C6D6BD00BDCE
      B500ADC6A500A5BD9C009CB594008CAD84007B9C6B005A6B3900424A21003939
      080031310800313108003131080031310800313108003131080073736B005273
      9400636BB50018216B0021296B00213163002929420031310800313108004242
      1000B5C6AD00C6D6BD00393908003939080039390800D6E7D600CEDECE00BDD6
      BD00B5C6AD00ADC6A500A5BD9C008CA57B003939080031310800313108003131
      08003131080031310800313108004A5A29006B945A00397BA5008CA5BD005263
      AD00102952000008420008184A00424A52004242210042421000B5C6AD00B5CE
      AD00C6D6BD00CEDEC600DEE7D600393908000000000000000000000000000000
      000000000000000000000000000073101800CE8C9400F7C6C600FFD6D600FFD6
      D600FFD6CE00D6949C00CE8C94006B0010009C9C9C00C69CB500A59C4A00EFEF
      EF009C949400A5847B00A57B7300A5736B009C6B63009C635A009C5A52009452
      5200944A4A008C4A390021212100000000000000000000000000FFD6D600FFD6
      D600FFD6D600FFDEB500EFB5BD004A0018000000000000000000000000000000
      000000000000000000000000000000000000000000009C9C9400EFDED600F7E7
      DE00F7EFEF00B5B5B500ADADA500A5A5A5009C9C9C0094949400949494008C8C
      8C00848484008C8C8C00000000000000000039390800D6DECE00C6D6BD00BDCE
      B500ADC6A500A5BD9C008CA58400525A31003939080031310800313108003131
      08003131080031310800313108003131080031310800313108006B6B6300319C
      CE003963B500636BC600424294004242940029296B004A4A2900393108007384
      5A00BDCEBD00CED6C600393908003939080039390800D6DECE00C6D6C600BDCE
      B500ADC6A500ADC6A500A5BD9C005A6339003131080031310800313108003131
      080031310800313108003131080063844A00739C63003984A500636BB5003139
      840018185A002129730010295A0010184A00424A52003939080094AD8400B5CE
      AD00BDCEB500C6D6C600D6DECE00393908000000000000000000842131008421
      310084213100842131008421310094424A00D68C9400FFD6CE00F7C6C600E7AD
      B500CE8C9400CE8C9400BD6B7B00000000009C9C9400EFDED600F7E7DE00F7EF
      EF00B5B5B500ADADA500A5A5A5009C9C9C0094949400949494008C8C8C008484
      84008C8C8C008C8C8C0029292100000000000000000000000000FFD6D600FFD6
      D600FFD6D600FFDEB50063183100000000000000000000000000000000000000
      0000731018006B0810000000000000000000000000009C8C8C007B0008007B00
      08007B0008007B0008007B0808005A3129002929290039393900313131004242
      42005A5A5A00F7E7EF00000000000000000039390800D6DECE00C6D6C600BDCE
      B500ADBDA500525A310031310800313108003131080031310800313108003131
      0800313108003131080031310800313108003131080031310800424218006363
      5A00298CDE005A8CDE00737BC6003942940042429C003139730084947B00ADC6
      AD00BDD6BD00CEDEC600393908003939080039390800CEDECE00C6D6BD00B5CE
      AD00ADC6A500A5BD9C009CB59400393908003131080031310800313108003131
      08003131080031310800394210007B9C6B007B9C6B004A94B500394A9C004242
      A5004A4AA50042429C00313984001810520010185200293139005A633900ADC6
      A500BDCEB500C6D6BD00CEDECE00393908000000000000000000DE9CA500DE9C
      A500DE9CA500D6949C00CE8C9400CE8C9400CE8C9400CE8C9400CE848C00BD73
      7B009C4A52006B00100000000000000000009C8C8C007B0008007B0008007B00
      08007B0008007B0808005A312900292929003939390031313100424242005A5A
      5A00FFE7E700FFE7E70084314200000000000000000000000000FFD6D600FFD6
      D600FFD6D600E7B5B5004A001800000000000000000000000000000000000000
      0000CE848C009C424A000000000000000000000000009C948C008C3929008C29
      2100841810007B0810007B0808009C4A39006B4A3900AD948C005A4A42004A42
      42004A424200F7E7E700000000000000000039390800D6DECE00C6D6BD00B5C6
      AD005A6339003131080031310800313108003131080031310800313108003131
      0800313108003131080031310800313108003131080031310800313108003939
      100063635A00298CD600738CDE008C94E70039428C004242A50029396B008C9C
      9400BDD6BD00CEDEC600393908003939080039390800C6D6C600BDCEBD00B5C6
      AD00A5BDA500A5BD9C007B8C6B00313108003131080031310800313108003131
      080031310800313108005263310084A5730084A5730084A57B00398CCE004A8C
      DE00848CE700525AA50039399C003939940018185A0010104A00424A390094A5
      8400B5CEAD00BDCEB500CEDEC600393908000000000000000000FFD6CE00F7C6
      C600D6949400CE8C9400CE8C9400BD737B00943942007B212900000000000000
      0000000000000000000000000000000000009C948C008C3929008C2921008418
      10007B0810007B0808009C4A39006B4A3900AD948C005A4A42004A4242004A42
      4200F7E7DE00FFE7E70000000000000000000000000000000000FFD6D600F7CE
      CE00FFD6D6007331390000000000000000000000000000000000000000007308
      1000EFBDBD00EFBDBD00000000000000000000000000735A630084737B008C84
      8400948C8C009C949400A58C8400A5847B009C6B6B009C5A4A00944231008431
      18005A4A4A00F7E7E700000000000000000039390800CEDECE00BDD6BD008494
      7300393908003131080031310800313108003131080031310800313108003131
      0800313108003131080031310800313108003131080031310800313108003939
      0800525A390063849C005284DE00738CE7007B84CE0029317B00394294004A5A
      7300BDCEBD00CEDEC600393908003939080039390800C6D6BD00BDCEB500ADC6
      A500A5BD9C009CB594004A522100313108003131080031310800313108003131
      08003131080039391000849C73008CAD7B008CAD7B008CAD840094AD8400428C
      C600638CDE008C94E700394294004242A50031318C0010185200212952005A63
      5200B5C6AD00BDCEB500C6D6BD00393908000000000000000000D6949400CE8C
      9400BD737B008421310000000000000000000000000000000000000000000000
      000000000000000000000000000000000000735A630084737B008C848400948C
      8C009C949400A58C8400A5847B009C6B6B009C5A4A0094423100843118005A4A
      4A00F7E7E700FFE7E70000000000000000000000000000000000FFD6D600E7C6
      C600FFD6D600520810000000000000000000000000000000000000000000AD63
      6B00F7BDC600F7BDC6006B001000000000000000000000000000000000004A08
      0000D6C6AD00FFD6AD00FFCECE00EFC6C600D6B5B500B59C9C00A5949400948C
      8C006B6B6B00EFDEDE00000000000000000039390800CEDEC600BDCEB500525A
      3100313108003131080031310800313108003131080031310800313108003131
      08003131080031310800394210004A5A29005A7342006B8C5A00739C63007B9C
      6B007B9C6B007B9C7300848C84002984D600638CDE00848CDE004A4A9C004239
      9C004A527B00A5ADB500393908000000000039390800BDCEB500B5CEAD00ADC6
      A500A5BD9C008494730031310800313108003131080031310800313108003131
      080031310800525A310094B58C0094AD8C0094AD8C0094B58C009CB594009CB5
      9400398CCE00738CE700848CE7005A63AD003139940039428C00102952002131
      52008C9C8C00B5CEAD00BDD6BD00393908000000000000000000CE8C8C00B563
      6B006B0010000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BD73
      7B00CE8C9400F7BDBD00EFC6C600D6B5B500B59C9C00A5949400948C8C006B6B
      6B00EFDEDE00FFE7E70000000000000000000000000000000000FFD6D600D6BD
      C600D69CA500000000000000000000000000000000000000000000000000EFB5
      B500F7BDC600F7BDBD00B56B7300000000000000000000000000000000004A08
      0000945A5A00FFDEAD00FFD6D600FFD6CE00FFD6D600FFD6D600FFD6D600FFDE
      D600FFDEDE00FFE7E700000000000000000039390800CED6C600B5CEAD003942
      1000313108003131080031310800313108003131080031310800313108003131
      0800394A10005A734200638C52006B945A0073946300739C6300739C6B007B9C
      6B007B9C6B0084A57300849C840084848400297BCE006384D6006B73BD004242
      9C004242A500525A8400393908000000000039390800B5CEB500ADC6AD00A5BD
      9C00A5BD94004A52210031310800313108003131080031310800313108003131
      0800313108008CA584009CBD94009CBD94009CBD9400A5BD9400A5BD9400A5BD
      9C00A5BD9C004A84D600638CDE008494DE004A4A9C0042399C0031397B000821
      5200212952009CAD9C00B5CEB500393908000000000000000000AD5A6B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B212900BD737B00CE8C9400CE8C
      9400EFB5B500FFD6D600FFD6D600FFD6D600FFD6D600FFDEDE00FFDEDE00FFDE
      DE00FFE7E700FFE7E70000000000000000000000000000000000EFCECE00D6BD
      C60052082100000000000000000000000000000000000000000073081000F7BD
      C600FFCECE00FFCECE00F7BDBD00731010000000000000000000000000000000
      000052100800E7B5B500FFD6BD00FFD6D600FFD6D600FFD6D600FFD6D600FFDE
      DE00FFDEDE00FFDEDE00000000000000000039390800C6D6C600B5CEAD003939
      0800313108003131080031310800313108003131080031310800313108004A63
      29005A844A00638C52006B9452006B945A0073946300739C63007B9C6B007B9C
      6B00739463006B845200738C5A007B8C6B007B8484002173BD006B7BD6008484
      DE0031398C0039429400393908000000000039390800BDCEB500B5C6AD00ADC6
      A5009CB594003939080031310800313108003131080031310800313108003131
      080039391000A5BD9C00A5BD9C00A5BDA500A5BDA500A5BDA500ADC6A500ADC6
      A500ADC6A5008C9C7B003184C6004A84D6007B8CDE006363B500393994003131
      8C00101863004A527300ADB5A5003939080000000000000000006B0010000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000094394200BD738400CE848C00CE8C9400CE8C9400D6949C00FFCE
      CE00FFD6D600FFD6D600FFD6D600FFD6D600FFD6D600FFDED600FFDEDE00FFE7
      E700FFE7E700FFEFEF0000000000000000000000000000000000DEC6C600D69C
      9C004A0018000000000000000000000000000000000000000000C67B8400F7BD
      C600FFD6CE00FFD6D600F7BDBD00A5525A000000000000000000000000000000
      00004A0800009C5A5A00FFD6AD00FFD6D600FFD6D600FFD6D600FFD6D600FFD6
      D600FFDED600FFDEDE00000000000000000039390800CEDEC600B5CEB5004242
      1000313108003131080031310800313108003131080031310800313108005A84
      4A00638C5200638C52006B945A006B945A0073946300739C63007B9C6B007BA5
      730052633100313108003131080031310800423910005A5A42003173C600637B
      D6006B6BC60042429C00000000000000000039390800BDCEB500B5CEAD00ADC6
      A50073845A003131080031310800313108003131080031310800313108003131
      08006B735200ADC6AD00B5C6AD00B5CEAD00B5CEAD00B5C6AD00B5C6AD00B5C6
      AD00B5C6AD00ADC6A50031422900317BC6005A84D6007B8CDE004A52AD004242
      A500313184001821630039426B00424229000000000000000000000000000000
      00000000000000000000000000000000000000000000A54A5200CE848C00CE8C
      9400CE8C9400CE8C9400DE9C9C00DE9C9C00DE9CA500DEA5A500DEA5A500DEA5
      A500DEA5A500E7ADAD00FFD6D600FFD6D600FFD6D600FFDEDE00FFDEDE00FFDE
      DE00FFE7E700FFEFEF0000000000000000000000000000000000D6BDC6006318
      310000000000000000000000000000000000000000006B081000EFBDBD00FFCE
      CE00FFD6D600FFD6D600F7C6C600F7BDC6000000000000000000000000000000
      00000000000052003100FFD6AD00EFC6DE00FFD6CE00FFD6D600FFD6D600FFD6
      D600FFDEDE00FFDEDE00000000000000000039390800CEDECE00BDCEBD005A63
      4200313108003131080031310800313108003131080031310800313108004A52
      21006B8C5A00739C6300739C6B007B9C6B007BA5730084A5730084A57B007B94
      6B0031310800313108003131080031310800313108003939100063635A005273
      9400105AA500104A8C00000000000000000039390800BDD6BD00B5CEB500ADC6
      A500424A18003131080031310800313108003131080031310800313108003939
      0800A5B59400B5CEB500BDCEB500BDCEB500BDCEB500BDCEB500BDCEB500BDCE
      B500B5CEB500B5CEAD005A63390031310800316BA5005A73D600848CE700424A
      9C00313994002129730010105A00394239000000000000000000000000000000
      000000000000000000000000000000000000CE8C9400CE8C9400D68C9400EFB5
      B500FFD6CE00EFB5B500CE8C9400C67B8400C67B8400C67B8400C67B8400C67B
      8400C67B8C00DEA5A500FFD6D600FFD6D600FFD6D600FFDEDE00FFDEDE00FFDE
      DE00FFE7E700FFE7E70000000000000000000000000000000000D6BDC6004A00
      18000000000000000000000000000000000000000000AD5A6300F7BDC600FFD6
      D600FFD6D600FFD6D600FFCECE00F7BDBD006B08100000000000000000000000
      00000000000000000000DEADAD00DEBDDE00FFD6D600FFD6D600FFD6D600FFD6
      D600FFDEDE00FFDEDE00000000000000000039390800D6DECE00C6D6BD008C94
      7300313108003131080031310800313108003131080031310800313108003131
      0800424A18006B845200738C63007B946B007B9C6B007B946B0063734A003942
      1000313108003131080031310800313108003131080031310800313108006363
      4200D6DECE00DEE7D600000000000000000039390800C6D6BD00BDCEB5007B84
      6300313108003131080031310800313108003131080031310800313108005A63
      3900BDCEBD00C6D6BD00C6D6BD00C6D6C600C6D6C600C6D6C600C6D6BD00C6D6
      BD00BDD6BD00BDCEB500A5B59400393910003131080042637B00637BDE006B73
      C6004A4AA50018187B00394A8400393910000000000000000000000000000000
      000000000000000000000000000000000000CE8C9400CE8C9400EFBDBD00FFCE
      CE00E7ADB500CE8C9400CE8C8C00000000000000000000000000000000000000
      000094394200DEA5A500FFD6CE00FFD6D600FFD6D600FFDEDE00FFDEDE00FFDE
      DE00FFE7E700FFE7E70000000000000000000000000000000000B57384004A00
      18000000000000000000000000000000000000000000EFB5B500F7BDC600FFD6
      CE00FFD6D600FFD6D600FFD6D600F7C6C600BD737B0000000000000000000000
      0000000000000000000073312900DEBDDE00F7CED600FFD6CE00FFD6D600FFD6
      D600FFD6D600FFDEDE00000000000000000039390800DEE7D600CEDEC600BDD6
      BD00636B4A003131080031310800313108003131080031310800313108003131
      0800313108003131080031310800313108003131080031310800313108003131
      080031310800313108003131080031310800313108003131080042421000ADB5
      9C00D6DECE00DEE7D600000000000000000039390800C6D6BD00BDD6BD004242
      100031310800313108003131080031310800313108003131080031310800B5CE
      B500C6D6BD00CEDEC600CEDEC600CEDECE00CEDECE00CEDECE00CEDEC600CED6
      C600C6D6C600C6D6BD00BDD6BD00737B5A003131080031310800315A8C00215A
      AD00184A9400214A7B004A5A5A003939080000000000000000006B0810000000
      0000000000000000000000000000000000006B001000AD5A6B00CE848C00CE84
      8C00CE848C009C424A0000000000000000000000000000000000000000000000
      0000BD738400E7ADAD00FFD6D600FFD6D600FFD6D600FFDEDE00FFDEDE00FFDE
      DE00FFE7E700FFEFEF0000000000000000000000000000000000520818000000
      00000000000000000000000000000000000000000000F7BDC600FFCECE00FFD6
      D600FFD6D600FFD6D600FFD6D600FFCECE00EFB5BD006B081000000000000000
      0000000000000000000052003100DEA5A500E7C6DE00FFD6CE00FFD6D600FFD6
      D600FFD6D600FFDEDE00000000000000000000000000DEE7DE00D6DECE00CEDE
      C600ADBDA5004242100031310800313108003131080031310800313108003131
      0800313108003131080031310800313108003131080031310800313108003131
      08003131080031310800313108003131080031310800313108007B846300CEDE
      C600D6DECE00DEE7D600000000000000000039390800CEDEC600ADBDA5003131
      080031310800313108003131080031310800313108003131080042421000C6D6
      C600CEDEC600CEDECE00D6DECE00D6E7D600D6E7D600D6E7D600D6DECE00CEDE
      CE00CEDEC600CED6C600C6D6C600ADB59C003131080031310800313108003139
      2900313108003131080039390800393908000000000000000000BD737B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007308
      1800CE8C9400F7C6C600FFD6D600FFD6D600FFD6D600FFDEDE00FFDEDE00FFDE
      DE00FFE7E700FFEFEF00000000000000000000000000000000004A0018000000
      000000000000000000000000000000000000BD738400F7BDC600FFD6CE00FFD6
      D600FFD6D600FFD6D600FFD6D600FFD6D600F7BDBD00AD5A6B00000000000000
      000000000000000000000000000073393100DEBDDE00FFD6D600FFD6CE00FFD6
      D600FFD6D600FFD6D600000000000000000000000000E7EFE700DEE7D600D6DE
      CE00C6D6C600B5C6AD006B734A00393108003131080031310800313108003131
      0800313108003131080031310800313108003131080031310800313108003131
      0800313108003131080031310800313108003939080073846300C6D6BD00CEDE
      C600D6DECE00DEE7D600000000000000000039390800CEDEC600636B4A003131
      0800313108003131080031310800313108003131080031310800848C7300CEDE
      C600CEDECE00D6E7D600DEE7D600DEE7D600DEE7D600DEE7D600DEE7D600D6E7
      D600CEDECE00CEDECE00CEDEC600CEDEC6004A4A180031310800313108003131
      0800313108003131080031310800393108000000000000000000CE8C8C00BD6B
      7300000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006B001000CE84
      8C00CE8C9400FFD6CE00FFD6D600FFD6D600FFD6D600FFDED600FFDEDE00FFE7
      E700FFE7E700FFEFEF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EFB5B500F7C6C600FFD6CE00FFD6
      D600FFD6D600FFD6D600FFD6D600FFD6D600F7BDBD00EFB5B500000000000000
      000000000000000000000000000052003100DEBDE700FFCEE700FFD6CE00FFD6
      D600FFD6D600FFD6D600000000000000000000000000EFF7EF00E7EFDE00DEE7
      D600D6DECE00CEDEC600C6D6BD008C947B005252290039310800313108003131
      0800313108003131080031310800313108003131080031310800313108003131
      08003131080031310800393908004A5221009CAD9400C6D6BD00CEDEC600D6DE
      CE00DEE7D600E7EFDE00000000000000000039390800CEDECE00393910003131
      0800313108003131080031310800313108003131080042421000B5C6AD00D6DE
      CE00DEE7D600DEE7DE00E7EFDE00E7EFE700E7EFE700E7EFDE00E7EFDE00DEE7
      DE00D6E7D600D6DECE00CEDECE00CEDECE007B84630031310800313108003131
      0800313108003131080031310800313108000000000000000000D6949C00CE8C
      9400AD636B007310180000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000073081000B56B7300CE8C
      9400E7ADAD00FFD6D600FFD6D600FFD6D600FFD6D600FFDEDE00FFDEDE00FFE7
      E700FFE7E700FFEFEF0000000000000000000000000000000000000000000000
      0000000000000000000000000000AD5A6300F7BDC600FFD6D600FFD6D600FFD6
      D600FFD6D600FFDED600FFD6D600FFD6D600FFCECE00F7BDBD00731018000000
      000000000000000000000000000052003100B5738C00FFCEE700FFD6D600FFD6
      D600FFD6D600FFD6D600000000000000000000000000EFF7EF00EFEFE700E7EF
      DE00DEE7D600D6DECE00CEDEC600C6D6C600BDD6BD00B5C6AD008C9C8400737B
      5A00636B420052522900424A1800424210004242100042421000525A31005A63
      3900737B5A008C9C7B00B5C6AD00BDD6BD00C6D6C600CEDEC600D6DECE00DEE7
      D600E7EFDE00EFEFE700000000000000000039390800A5AD8C00313108003131
      08003131080031310800313108003131080031310800737B5A00D6E7D600DEE7
      D600DEEFDE00E7EFE700EFEFE700EFEFEF00EFEFEF00EFEFEF00EFEFE700E7EF
      DE00DEE7DE00DEE7D600D6E7D600D6E7D600C6D6C60039391000313108003131
      0800313108003131080031310800313108000000000000000000FFD6D600F7BD
      BD00CE8C9400CE8C9400CE848C00A55263008C3139007B182100730818007308
      1800730818007B18210084293900A5525A00C6848C00CE8C9400CE8C9400F7C6
      C600FFD6D600FFD6D600FFD6D600FFD6D600FFDEDE00FFDEDE00FFDEDE00FFE7
      E700FFE7E700FFEFEF0000000000000000000000000000000000000000000000
      0000000000000000000000000000DEA5A500F7BDC600FFD6CE00FFD6D600FFD6
      D600FFD6D600FFDEDE00FFD6D600FFD6D600FFD6D600F7BDBD00B56B73000000
      00000000000000000000000000000000000073214A00FFCEE700F7CEDE00FFD6
      CE00FFD6D600FFD6D600000000000000000000000000F7FFF700F7F7EF00EFF7
      EF00E7EFE700DEEFDE00DEE7D600D6DECE00CEDECE00C6D6C600BDD6BD00BDCE
      B500B5CEAD00B5CEAD00B5C6AD00B5C6AD00B5C6AD00B5C6AD00B5CEAD00B5CE
      AD00BDCEB500BDD6BD00C6D6C600CEDEC600D6DECE00DEE7D600DEE7DE00E7EF
      E700EFF7EF00EFF7EF00000000000000000039390800DEE7D600DEE7D600D6E7
      D600D6E7D600D6E7D600D6E7D600D6E7D600D6E7D600DEE7D600DEE7D600DEE7
      DE00E7EFE700EFEFEF00EFF7EF00EFF7EF00EFF7EF00EFF7EF00EFF7EF00EFEF
      E700E7EFE700DEE7DE00DEE7D600DEE7D600DEE7D600DEE7D600DEE7D600DEE7
      D600DEE7D600DEE7D600DEE7D600393908000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000039390800393908003939080039390800393908003939
      0800393908003939080039390800393908003939080039390800393908003939
      0800393908003939080039390800393908003939080039390800000000000000
      0000000000000000000000000000000000003939080039390800393908003939
      0800393908003939080039390800393908003939080039390800393908003939
      0800393908003939100039391000393910003939100039391000393910003939
      1000393908003939080039390800393908003939080039390800393908003939
      0800393908003939080039390800393908000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BDBDBD00BDBDBD00000000000000000000000000BDBDBD00BDBDBD000000
      00000000000000000000BDBDBD00BDBDBD000000000000000000000000000000
      000000000000000000000000000000000000BDBDBD00BDBDBD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B0000000000000000000000000000000000000000000000000029212100847B
      7B00847B7B00847B7B008C848400847B7B007B737B00847B7B0084737B006B63
      6B0084847B007B73730000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BDBDBD000000
      00000000000000000000BDBDBD00BDBDBD00000000000000000000000000BDBD
      BD00BDBDBD00000000000000000000000000BDBDBD00BDBDBD00000000000000
      0000FFFF0000FFFF000000000000000000000000000000000000BDBDBD00BDBD
      BD000000000000000000000000000000000000000000000000000000000000FF
      FF0000FFFF0000FFFF00000000000000000000000000BDBDBD00BDBDBD00BDBD
      BD0000000000000000000000000000000000000000007B7B7B00000000000000
      00000000000000000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B00000000000000000000000000000000001010100042393900393131006B63
      63008C7B7B00847B7B00847B7B00847B7B007B6B6B007B736B007B7B7B007373
      6B00D6CECE00C6BDBD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BDBD
      BD00BDBDBD00000000000000000000000000BDBDBD00BDBDBD00000000000000
      000000000000BDBDBD00BDBDBD00000000000000000000000000BDBDBD000000
      0000FFFF0000FFFF00007B7B000000000000BDBDBD0000000000000000000000
      0000BDBDBD00BDBDBD00000000000000000000000000FFFF00000000000000FF
      FF0000FFFF0000FFFF000000000000FFFF0000000000BDBDBD00BDBDBD00BDBD
      BD00000000007B7B7B0000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF000000FF00000000000000FF00
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007B7B7B00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007B7B7B00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000007B7B
      7B0000000000000000000000000000000000000000009C949400F7EFEF00F7EF
      EF00EFE7E700E7DEDE00E7DEDE00DED6D600DED6D600D6CECE00BDB5B500847B
      7B00B5ADAD00D6CECE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BDBDBD00BDBDBD00000000000000
      000000000000BDBDBD00BDBDBD00000000000000000000000000BDBDBD00BDBD
      BD00000000000000000000000000BDBDBD00BDBDBD0000000000000000000000
      0000FFFF0000FFFF00007B7B00007B7B000000000000BDBDBD00BDBDBD000000
      00000000000000000000BDBDBD00BDBDBD0000000000FFFF00000000000000FF
      FF0000FFFF0000FFFF0000000000BDBDBD0000000000BDBDBD00BDBDBD00BDBD
      BD00000000007B7B7B007B7B7B0000000000000000007B7B7B00000000007B7B
      7B000000FF0000000000FF000000FF000000FF000000FF00000000000000FF00
      0000FF000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007B7B7B00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007B7B7B00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000007B7B
      7B00000000000000000000000000000000000000000031293100F7EFEF00F7F7
      F700EFE7EF00EFE7E700E7E7E700DED6D600DED6D600CEC6C600CECECE00948C
      8C007B737300D6C6CE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BDBDBD00BDBD
      BD00000000000000000000000000BDBDBD00BDBDBD0000000000000000000000
      0000BDBDBD00BDBDBD00000000000000000000000000BDBDBD00BDBDBD000000
      0000FFFF0000FFFF00007B7B00007B7B00007B7B00000000000000000000BDBD
      BD00BDBDBD0000000000000000000000000000000000FFFF00000000000000FF
      FF0000FFFF0000FFFF000000000000FFFF0000000000BDBDBD00BDBDBD00BDBD
      BD00000000007B7B7B007B7B7B00000000000000000000000000000000000000
      00007B7B7B0000000000FF000000FF000000FF000000FF00000000000000FF00
      0000FF000000FF0000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007B7B7B00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007B7B7B00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000007B7B
      7B0000000000000000000000000000000000000000000000000031313100DEDE
      DE00F7EFEF00F7EFEF00EFE7E700EFE7E700D6D6D600D6D6D600D6CECE00C6BD
      BD007B7B7B00ADA5A50039393100181818001818100029212100211818001810
      1000080008000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BDBDBD0000000000000000000000
      0000BDBDBD00BDBDBD00000000000000000000000000BDBDBD00BDBDBD000000
      00000000000000000000BDBDBD00BDBDBD000000000000000000000000000000
      0000FFFF0000FFFF00007B7B00007B7B00007B7B00007B7B0000000000000000
      000000000000BDBDBD00BDBDBD000000000000000000FFFF00000000000000FF
      FF0000FFFF0000FFFF0000000000BDBDBD0000000000BDBDBD00BDBDBD00BDBD
      BD00000000007B7B7B007B7B7B007B7B7B00000000007B7B7B00000000007B7B
      7B000000FF0000000000FF000000FF000000FF000000FF00000000000000FF00
      0000FF000000FF000000FF000000000000000000000000000000000000007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B00000000007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B00000000007B7B
      7B00000000000000000000000000000000000000000000000000000000003131
      3100F7F7F700F7EFEF00EFEFEF00F7EFEF00E7E7E700E7E7E700E7DEDE00D6D6
      CE009C9494006B6B63006B5A5A0042393900524A4A006B6363005A4A52002121
      1800181010001810100000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BDBDBD00BDBDBD00000000000000
      0000FFFF0000FFFF00007B7B00007B7B00007B7B00007B7B00007B7B00000000
      00000000000000000000000000000000000000000000FFFF00000000000000FF
      FF0000FFFF0000FFFF000000000000FFFF0000000000BDBDBD00BDBDBD00BDBD
      BD00000000007B7B7B007B7B7B00000000000000000000000000000000000000
      00007B7B7B0000000000FF000000FF000000FF000000FF00000000000000FF00
      0000FF000000FF000000FF00000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007B7B7B00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000007B7B7B00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000007B7B
      7B00000000000000000000000000000000000000000000000000000000000000
      000031313100DEDEDE00F7EFEF00F7EFEF00EFE7EF00E7DEE700C6BDBD008473
      7B00423939004A424200736B6B009C9494009C94940094848C007B6B6B004239
      3100313129002118180021181800100808000808080000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000BDBDBD00BDBDBD00000000000000000000000000BDBDBD000000
      0000FFFF0000FFFF00007B7B00007B7B00007B7B00007B7B00007B7B00000000
      00007B7B7B00BDBDBD00000000000000000000000000FFFF00000000000000FF
      FF0000FFFF0000FFFF0000000000BDBDBD0000000000BDBDBD00BDBDBD00BDBD
      BD00000000007B7B7B007B7B7B007B7B7B00000000007B7B7B00000000007B7B
      7B000000FF0000000000FF000000FF000000FF000000FF00000000000000FF00
      0000FF000000FF000000FF00000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007B7B7B00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000FFFF00000000000000
      0000BDBDBD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000007B7B
      7B00000000000000000000000000000000000000000000000000000000000000
      00000000000031313100524A4A00524A4A00524A5200524A4A004A3942005A52
      5200847B7B009C949400847B7B00B5ADAD00A5949C00948C94007B7373004239
      3100393931002921210021212100181010002921210008080800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000BDBDBD00BDBDBD0000000000000000000000
      0000FFFF0000FFFF00007B7B00007B7B00007B7B00007B7B00007B7B00000000
      00007B7B7B00BDBDBD00000000000000000000000000FFFF00000000000000FF
      FF0000FFFF0000FFFF000000000000FFFF0000000000BDBDBD00BDBDBD00BDBD
      BD00000000007B7B7B007B7B7B00000000000000000000000000000000000000
      00007B7B7B0000000000FF000000FF000000FF000000FF00000000000000FF00
      0000FF000000FF000000FF00000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007B7B7B00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000007B7B7B007B7B
      7B0000000000BDBDBD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000007B7B
      7B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000100808004242390073737300ADA5A500B5A5
      AD00C6BDBD00C6BDBD008C848400B5ADAD00A5949C009C9494007B7373003931
      310039313100423931004A393900312929001810100021101800312929001818
      1800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BDBDBD000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFF0000FFFF00007B7B00007B7B00007B7B00007B7B00007B7B00000000
      00007B7B7B00BDBDBD00000000000000000000000000FFFF00000000000000FF
      FF0000FFFF0000FFFF0000000000BDBDBD0000000000BDBDBD00BDBDBD00BDBD
      BD00000000007B7B7B007B7B7B007B7B7B00000000007B7B7B00000000007B7B
      7B000000FF0000000000FF000000FF000000FF000000FF00000000000000FF00
      0000FF000000FF000000FF000000000000000000000000000000000000007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B000000000000FFFF0000FF
      FF007B7B7B00000000007B7B7B007B7B7B007B7B7B007B7B7B00000000007B7B
      7B00000000000000000000000000000000000000000000000000000000000000
      00000000000018181000524A4A008C848400ADADAD00C6BDBD00C6BDBD00D6CE
      CE00D6D6D600ADA5AD00948C8400B5ADAD00A59C9C00AD9CA5007B7373003939
      31004239310039393100393931004A3939002921210018101000211818003131
      3100212121000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BDBDBD00BDBD
      BD00000000007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B000000
      0000FFFF0000FFFF00007B7B00007B7B00007B7B00007B7B00007B7B00000000
      00007B7B7B00BDBDBD00000000000000000000000000FFFF00000000000000FF
      FF000000000000FFFF000000000000FFFF0000000000BDBDBD0000000000BDBD
      BD00000000007B7B7B007B7B7B00000000000000000000000000000000000000
      00007B7B7B0000000000FF000000FF000000FF000000FF00000000000000FF00
      0000FF000000FF000000FF00000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007B7B7B00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF0000FFFF007B7B7B0000000000BDBDBD00FFFFFF00FFFFFF00000000007B7B
      7B00000000000000000000000000000000000000000000000000100808003931
      3100736B6B00ADA5A500CEC6C600D6CECE00D6CECE00D6CECE00BDBDBD00A59C
      9C007B7B73008C848400A59C9C00C6BDBD00AD9CA500AD9CA500847373003931
      3100393931003931310042393900423931004239390042393900212118001810
      1000292121003931310018181800080808000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BDBD
      BD00000000007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B000000
      0000FFFF0000FFFF00007B7B00007B7B00007B7B00007B7B00007B7B00000000
      00007B7B7B00BDBDBD00000000000000000000000000FFFF00000000000000FF
      FF000000000000FFFF0000000000BDBDBD0000000000BDBDBD0000000000BDBD
      BD00000000007B7B7B007B7B7B007B7B7B00000000007B7B7B00000000007B7B
      7B000000FF0000000000FF000000FF000000FF000000FF00000000000000FF00
      0000FF000000FF000000FF00000000000000000000000000000000000000BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD007B7B7B00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00FFFFFF00FFFFFF007B7B7B000000
      0000FFFFFF0000FFFF007B7B7B0000000000BDBDBD00FFFFFF00000000007B7B
      7B0000000000000000000000000000000000100808003129290073737300BDB5
      B500DED6D600DEDEDE00E7DEDE00E7E7E700B5ADA500948C8C00847373009C9C
      9C00B5ADAD00B5ADB500A59C9C00BDBDBD00AD9CA500A5949C007B6B6B003929
      2900393931003131310039313100393131003931310039393100423939003129
      2900181810002110180042393900393939000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B00000000
      0000000000007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B000000
      0000FFFF0000FFFF00007B7B00007B7B00007B7B00007B7B00007B7B00000000
      00007B7B7B00BDBDBD00000000000000000000000000FFFF00000000000000FF
      FF0000FFFF0000FFFF000000000000FFFF0000000000BDBDBD0000000000BDBD
      BD00000000007B7B7B007B7B7B00000000000000000000000000000000000000
      00007B7B7B0000000000FF000000FF000000FF000000FF00000000000000FF00
      0000FF000000FF000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000BDBDBD00BDBDBD00FFFFFF007B7B7B00FFFF
      FF0000000000FFFFFF0000FFFF007B7B7B0000000000BDBDBD00000000000000
      0000000000000000000000000000000000004A424200EFE7E7009C948C00F7EF
      EF00DED6D600D6CECE009C949400847B7B009C949400BDB5B500C6BDBD00C6BD
      BD00BDB5B500BDB5B5009C949400BDB5B500BDBDBD00C6BDBD009C9494003931
      3100313129003931310042313100393131003931310039313100423939004239
      3900393131002118180018101000292121000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B00007B7B
      0000000000007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B000000
      0000FFFF0000FFFF00007B7B000000000000000000007B7B00007B7B00000000
      00007B7B7B00BDBDBD00000000000000000000000000FFFF00000000000000FF
      FF000000000000FFFF0000000000BDBDBD0000000000BDBDBD00BDBDBD00BDBD
      BD00000000007B7B7B007B7B7B007B7B7B00000000007B7B7B00000000007B7B
      7B000000FF0000000000FF000000FF000000FF000000FF00000000000000FF00
      0000FF000000FF000000FF0000000000000000000000000000007B7B00007B7B
      00007B7B00007B7B00007B7B00007B7B00007B7B00007B7B00007B7B00007B7B
      00007B7B00007B7B00007B7B0000000000007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B0000000000FFFFFF0000FFFF007B7B7B0000000000000000007B7B
      7B0000000000000000000000000000000000524A4A00F7EFEF00948C8C00C6BD
      C6009C9494008C848400B5ADAD00CEC6C600CECECE00D6CECE00C6BDBD00B5B5
      B500BDADB500BDB5B500B5A5AD00E7DEDE00D6CECE00B5B5AD00948C8C004239
      3900423939004239310031312900393131004239310042393100393131003931
      31004A4242004A42390021181800181010000000000000000000000000000000
      0000BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD0000000000FFFF00007B7B
      00007B7B0000000000007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B000000
      0000FFFF0000FFFF0000000000007B7B7B00000000007B7B00007B7B00000000
      00007B7B7B00BDBDBD00000000000000000000000000FFFF00000000000000FF
      FF000000000000FFFF000000000000FFFF0000000000BDBDBD00BDBDBD00BDBD
      BD00000000007B7B7B007B7B7B00000000000000000000000000000000000000
      00007B7B7B0000000000FF000000FF000000FF000000FF00000000000000FF00
      0000FF000000FF000000FF000000000000000000000000000000FFFF00000000
      0000000000007B7B000000000000000000007B7B000000000000000000007B7B
      000000000000000000007B7B000000000000BDBDBD00FFFFFF007B7B7B00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF0000000000BDBDBD00000000007B7B
      7B00FFFFFF0000000000000000000000000052525200F7EFEF008C8484009C94
      9C00D6CECE00E7DEDE00D6D6D600DED6D600D6CECE00D6CECE00D6CECE00DED6
      D600D6CECE00D6CECE00B5ADAD00B5ADB500A59C9C00AD9CA50084737B001810
      1000292121004239390042393900393131003931310039313100423931004239
      310039313100423939004A39390029182100000000000000000000000000BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD0000000000FFFF0000FFFF
      00007B7B00007B7B0000000000007B7B7B007B7B7B007B7B7B007B7B7B000000
      0000FFFF0000FFFF00000000000000000000000000007B7B00007B7B00000000
      00007B7B7B00BDBDBD00000000000000000000000000FFFF00000000000000FF
      FF000000000000FFFF0000000000BDBDBD0000000000BDBDBD00BDBDBD00BDBD
      BD00000000007B7B7B007B7B7B007B7B7B00000000007B7B7B00000000007B7B
      7B000000FF0000000000FF000000FF000000FF000000FF00000000000000FF00
      0000FF000000FF000000FF000000000000000000000000000000FFFF0000FFFF
      0000000000007B7B0000FFFF0000000000007B7B0000FFFF0000000000007B7B
      0000FFFF0000000000007B7B000000000000BDBDBD00FFFFFF007B7B7B00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF0000FFFF007B7B7B000000
      0000FFFFFF00FFFFFF00000000000000000052525200F7E7EF00C6B5BD00E7DE
      DE00DEDEDE00DED6D600DEDEDE00E7DEDE00D6CECE00E7E7DE00E7DEE700E7DE
      DE00B5ADAD00BDB5B500AD9C9C00BDADAD00B5ADB500BDADB5008C8484002929
      21002118180021181800423939004A4242003939310039313100423939004239
      3900393131004239390039393100181010000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFF0000FFFF
      0000FFFF00007B7B00007B7B0000000000007B7B7B007B7B7B007B7B7B000000
      0000FFFF0000FFFF00007B7B000000000000000000007B7B00007B7B00000000
      00007B7B7B00BDBDBD00000000000000000000000000FFFF00000000000000FF
      FF0000FFFF0000FFFF000000000000FFFF0000000000BDBDBD00BDBDBD00BDBD
      BD00000000007B7B7B007B7B7B00000000000000000000000000000000000000
      00007B7B7B0000000000FF000000FF000000FF000000FF00000000000000FF00
      0000FF000000FF000000FF000000000000000000000000000000FFFF00007B7B
      00007B7B00007B7B00007B7B00007B7B00007B7B00007B7B00007B7B00007B7B
      00007B7B00007B7B00007B7B000000000000BDBDBD00FFFFFF007B7B7B00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF0000FFFF007B7B
      7B0000000000FFFFFF00000000000000000052525200EFE7EF00C6BDBD00EFE7
      E700E7DEDE00DED6DE00E7E7E700EFE7E700E7DEDE00CEC6C600B5ADAD00B5AD
      AD00C6BDBD00C6BDBD00C6BDBD00CEC6C600CEC6CE00CEBDC600CEC6C600524A
      420029212100292121002121210039313100423939004A4242004A3939004A39
      390042313100393931004A4242002118180000000000000000007B7B00007B7B
      00007B7B00007B7B00007B7B00007B7B00007B7B00007B7B0000FFFF0000FFFF
      0000FFFF0000FFFF00007B7B00007B7B0000000000007B7B7B007B7B7B000000
      0000FFFF0000FFFF00007B7B00007B7B00007B7B00007B7B00007B7B00000000
      00007B7B7B00BDBDBD00000000000000000000000000FFFF00000000000000FF
      FF000000000000FFFF0000000000BDBDBD0000000000BDBDBD00BDBDBD00BDBD
      BD00000000007B7B7B007B7B7B007B7B7B00000000007B7B7B00000000007B7B
      7B000000FF0000000000FF000000FF000000FF000000FF00000000000000FF00
      0000FF000000FF000000FF000000000000000000000000000000FFFF00000000
      0000000000007B7B000000000000000000007B7B000000000000000000007B7B
      000000000000000000007B7B0000000000007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B0000000000FFFFFF0000FF
      FF007B7B7B0000000000000000000000000052525200EFE7E700C6BDBD00EFEF
      EF00EFE7E700E7DEE700CEC6CE00C6BDC600BDADB500C6B5BD00D6CECE00D6CE
      CE00CECEC600CECECE00E7DEE700EFEFEF00F7F7F700E7DEDE00D6CECE00ADA5
      A5005A524A0031292900312929002929210029212100423939004A3939004A39
      390042313100393931004A393900181010000000000000000000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF00007B7B00007B7B0000000000007B7B7B000000
      0000FFFF0000FFFF00007B7B00007B7B00007B7B00007B7B00007B7B00000000
      00007B7B7B00BDBDBD00000000000000000000000000FFFF00000000000000FF
      FF000000000000FFFF000000000000FFFF0000000000BDBDBD00BDBDBD00BDBD
      BD00000000007B7B7B007B7B7B007B7B7B000000000000000000000000000000
      FF007B7B7B0000000000FF000000FF000000FF000000FF00000000000000FF00
      0000FF000000FF000000FF000000000000000000000000000000FFFF0000FFFF
      0000000000007B7B0000FFFF0000000000007B7B0000FFFF0000000000007B7B
      0000FFFF0000000000007B7B000000000000BDBDBD00FFFFFF007B7B7B00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF0000FFFF007B7B7B00000000000000000052525200EFE7EF00CEC6C600DED6
      D600C6C6C600C6BDBD00BDB5B500D6CECE00DEDEDE00D6D6D600DED6D600DEDE
      D600E7E7E700EFEFEF00E7D6DE00E7DEDE00C6BDBD00BDB5B500B5A5AD00AD9C
      AD00B5B5B5009C9494006B636300393131003129290029212100312121005242
      4200423939003931310042393900181010000000000000000000FFFF0000FFFF
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFF0000FFFF00007B7B0000000000007B7B7B000000
      0000FFFF0000FFFF00007B7B00007B7B00007B7B00007B7B00007B7B00000000
      00007B7B7B00BDBDBD00000000000000000000000000FFFF00000000000000FF
      FF000000000000FFFF0000000000BDBDBD0000000000BDBDBD00BDBDBD00BDBD
      BD00000000007B7B7B007B7B7B007B7B7B007B7B7B0000000000BDBDBD000000
      00000000FF0000000000FF00000000000000FF000000FF00000000000000FF00
      0000FF000000FF000000FF000000000000000000000000000000FFFF00007B7B
      00007B7B00007B7B00007B7B00007B7B00007B7B00007B7B00007B7B00007B7B
      00007B7B00007B7B00007B7B000000000000BDBDBD00FFFFFF007B7B7B00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000FFFFFF00000000000000000000000000524A4A00E7DEDE00BDB5B500C6BD
      BD00CEC6C600DED6D600EFE7E700DED6D600F7EFEF00EFEFE700EFEFEF00F7F7
      F700CECECE0094948C008C848400C6BDBD00D6CECE00BDB5BD00BDB5B500BDAD
      B500BDB5B500BDB5B500BDB5B500948C8C004A42390031292900212118003129
      2900393131004A4242004A424200181010000000000000000000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      000000000000FFFF0000FFFF00007B7B0000000000007B7B7B007B7B7B000000
      0000FFFF0000FFFF00007B7B00007B7B00007B7B00007B7B00007B7B00000000
      00007B7B7B00BDBDBD00000000000000000000000000FFFF00000000000000FF
      FF000000000000FFFF000000000000FFFF000000000000000000000000000000
      0000000000007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B0000000000BDBD
      BD000000000000000000FF0000000000000000000000FF00000000000000FF00
      0000FF000000FF000000FF000000000000000000000000000000FFFF00000000
      0000000000007B7B000000000000000000007B7B000000000000000000007B7B
      000000000000000000007B7B000000000000BDBDBD00FFFFFF007B7B7B00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000007B7B
      7B000000000000000000FFFFFF000000000052525200E7DEDE00DED6D600E7E7
      E700EFE7E700EFEFEF00EFE7EF00E7E7E700D6CED600C6B5BD00A59C9C008473
      7B00635A5A0031292900211818004A4242009C9C9400CEC6C600D6CECE00D6CE
      CE00CEC6C600BDB5B500C6BDBD00D6CECE00C6BDBD008C848400423939003129
      2900292121003131290042393900181010000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFF00000000
      0000FFFF0000FFFF00007B7B0000000000007B7B7B007B7B7B007B7B7B000000
      0000FFFF0000FFFF00007B7B00007B7B00007B7B00007B7B00007B7B00000000
      00007B7B7B00BDBDBD00000000000000000000000000FFFF00000000000000FF
      FF000000000000FFFF0000000000BDBDBD0000FFFF0000000000BDBDBD00BDBD
      BD00BDBDBD00000000007B7B7B007B7B7B007B7B7B007B7B7B00000000000000
      0000BDBDBD0000000000FF000000FF000000FF000000FF00000000000000FF00
      0000FF000000FF000000FF000000000000000000000000000000FFFF0000FFFF
      0000000000007B7B0000FFFF0000000000007B7B0000FFFF0000000000007B7B
      0000FFFF0000000000007B7B0000000000007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B00000000007B7B
      7B00000000000000000000000000000000004A4A4A00F7EFEF00EFE7E700EFE7
      E700F7F7F700E7E7E700C6BDC600ADA5A500736B6B006B5A5A008C848400B5AD
      AD00D6CECE00BDB5B5007B737300524A4A00292929004A424200ADA5A500DEDE
      DE00DED6DE00DED6D600E7D6DE00E7DEDE00EFEFEF00EFE7EF00ADA5A5003129
      2900313131002929210029212100100808000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFF0000FFFF
      0000FFFF00007B7B0000000000007B7B7B007B7B7B007B7B7B007B7B7B000000
      0000FFFF0000FFFF00007B7B00007B7B00007B7B00007B7B00007B7B00000000
      00007B7B7B00BDBDBD00000000000000000000000000FFFF00000000000000FF
      FF0000FFFF0000FFFF000000000000FFFF00BDBDBD0000FFFF0000000000BDBD
      BD00BDBDBD00BDBDBD00000000007B7B7B007B7B7B007B7B7B00000000000000
      00000000000000000000FF000000FF000000FF000000FF00000000000000FF00
      0000FF000000FF000000FF000000000000000000000000000000FFFF00007B7B
      00007B7B00007B7B00007B7B00007B7B00007B7B00007B7B00007B7B00007B7B
      00007B7B00007B7B00007B7B000000000000BDBDBD00FFFFFF007B7B7B00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000007B7B
      7B0000000000000000000000000000000000524A4A00F7F7F700E7DEDE00D6D6
      D6009C9C940073736B0073736B0084847B00BDB5B500E7E7E700F7F7F700F7F7
      F700EFE7EF00EFE7E700F7EFEF00D6CECE00ADA5AD00847B7B005A5252006363
      5A00BDB5B500EFEFEF00F7F7F700F7F7F700EFEFEF00E7DEDE00B5ADAD00B5AD
      A500393131002929290031312900181010000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFF0000FFFF
      00007B7B0000000000007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B000000
      0000FFFF0000FFFF00007B7B00007B7B00007B7B00007B7B00007B7B00000000
      00007B7B7B00BDBDBD00000000000000000000000000000000000000000000FF
      FF0000FFFF0000FFFF0000000000BDBDBD0000FFFF00BDBDBD0000FFFF000000
      0000BDBDBD00BDBDBD00BDBDBD00000000007B7B7B007B7B7B00000000000000
      00000000000000000000FF000000FF000000FF000000FF00000000000000FF00
      0000FF000000FF000000FF000000000000000000000000000000FFFF00000000
      0000000000007B7B000000000000000000007B7B000000000000000000007B7B
      000000000000000000007B7B000000000000BDBDBD00FFFFFF007B7B7B00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000007B7B
      7B0000000000000000000000000000000000181818004A4A4A00E7DEE700C6C6
      BD0063635A006B636300CEC6C600F7EFEF00F7FFF700F7F7F700F7F7F700F7EF
      EF00F7EFEF00EFE7E700EFE7EF00DED6D600CEC6C600A5A59C0084737300635A
      5A0042393900ADA5A500DEDEDE00B5B5B500635A5A0042393900101008004A42
      42009C9C9C003129290031292900181010000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFF00007B7B
      0000000000007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B000000
      0000FFFF0000FFFF00007B7B00007B7B00007B7B00007B7B00007B7B00000000
      00007B7B7B00BDBDBD0000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF00BDBDBD0000FFFF00BDBDBD0000FF
      FF0000000000BDBDBD00BDBDBD00BDBDBD00000000007B7B7B00000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000FF000000FF000000FF000000000000000000000000000000FFFF0000FFFF
      0000000000007B7B0000FFFF0000000000007B7B0000FFFF0000000000007B7B
      0000FFFF0000000000007B7B000000000000BDBDBD00FFFFFF007B7B7B00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000007B7B
      7B00000000000000000000000000000000000000000000000000000000000000
      00009C9C9C00736B6B0084848400736B6B00847B7B00ADADAD00CECEC600CEC6
      C600D6D6CE00C6BDBD008C8484007B737300635A5A005A525200736B6B00736B
      6B00AD9C9C005A5252009C949400736B6B0008000000080000006B6B63005A5A
      5A0094949400A59C9C0039313100181010000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B00000000
      0000000000007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B0000000000FFFF0000FFFF00007B7B00007B7B00007B7B00007B7B00000000
      00007B7B7B00BDBDBD0000000000000000000000000000000000000000000000
      0000BDBDBD00BDBDBD00BDBDBD000000000000FFFF00BDBDBD0000FFFF00BDBD
      BD0000FFFF0000000000BDBDBD00BDBDBD00BDBDBD0000000000000000000000
      0000000000000000000000000000BDBDBD00BDBDBD00BDBDBD00BDBDBD000000
      0000FF000000FF000000FF000000000000000000000000000000FFFF00007B7B
      00007B7B00007B7B00007B7B00007B7B00007B7B00007B7B00007B7B00007B7B
      00007B7B00007B7B00007B7B0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000004A424200949494006B63630029212100423939004A42
      4200423939004A4242005A5A5200847373007B737300948C8C00736B6B003129
      2900524A4A001810100031313100B5ADAD006B6B6B00736B6B00B5B5B500D6D6
      D600F7F7F700DEDEDE007B737300292121000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B0000000000FFFF0000FFFF00007B7B00007B7B00007B7B00000000
      00007B7B7B00BDBDBD0000000000000000000000000000000000000000000000
      000000000000BDBDBD00BDBDBD00BDBDBD000000000000FFFF00BDBDBD0000FF
      FF00BDBDBD000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BDBDBD00BDBDBD00BDBDBD00BDBD
      BD0000000000FF000000FF000000000000000000000000000000FFFF00007B7B
      00007B7B00007B7B00007B7B00007B7B00007B7B00007B7B00007B7B00007B7B
      00007B7B00007B7B00007B7B0000000000007B7B7B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B5B5B500DED6D6006B6B6B002118
      180021212100635A5A005A525200525252001810100021181800211818002118
      1800423939006B5A6300ADADA500EFEFE700F7F7F700EFEFEF00CECECE00A59C
      9C007B7373002121210000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B007B7B7B0000000000FFFF0000FFFF00007B7B00007B7B00000000
      00007B7B7B00BDBDBD0000000000000000000000000000000000000000000000
      00000000000000000000BDBDBD00BDBDBD00BDBDBD000000000000FFFF00BDBD
      BD0000FFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDBDBD00BDBDBD00BDBD
      BD00BDBDBD0000000000FF000000000000000000000000000000FFFF00000000
      0000BDBDBD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000007B7B0000000000007B7B7B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000010101000A5A5A500D6D6D6007373
      6B001810100029212100080000001810100010080800393131008C848400B5AD
      AD00E7E7DE00EFF7EF00F7F7F700E7DEDE00A5A5A50042424200292121000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B0000000000FFFF0000FFFF00007B7B00000000
      00007B7B7B00BDBDBD0000000000000000000000000000000000000000000000
      0000000000000000000000000000BDBDBD00BDBDBD00BDBDBD000000000000FF
      FF00BDBDBD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BDBDBD00BDBD
      BD00BDBDBD00BDBDBD0000000000000000000000000000000000FFFF00000000
      0000BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00000000007B7B0000000000007B7B7B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009C9C9C00EFE7
      E700736B630031292100736B7300A59C9C00DEDED600EFEFEF00F7F7EF00EFEF
      E7009C949C008C84840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B0000000000FFFF0000FFFF00000000
      00007B7B7B000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BDBDBD00BDBDBD00BDBDBD000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007B7B0000000000007B7B7B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000010101000A59C
      9C00E7DEDE00CECECE00F7F7F700F7FFF700E7E7E700CEC6CE004A4A4A004242
      4200000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDBDBD00BDBDBD00BDBD
      BD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF00007B7B0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008C8484009C9494008C8C8C007B7373000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000080000000800000000100010000000000000800000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF8FFFFFFF8FFFFFFFC00FFF00000000
      FF0FFFFFFF0FFFFFFF0003FF00000000FE0FFFFFFE0FFFFFFC6000FF00000000
      FC00000FFC0FFFFFF870003F00000000F800000FF8000007F820000F00000000
      F800000FF0000007F820000300000000F000000FF0000007F820000100000000
      F000000FF8000007F820000100000000F000000FFC000187F820000100000000
      E003800FFE000187F820000100000000E007C00FFE000087F820000100000000
      E00FC00FFF000087F820000300000000E00F000FFF000087F820000700000000
      E010000FFF000007F820000F00000000FF00000FFF000007F820003F00000000
      FC00000FFE008007F82001FF00000000F800003FFE00C007F84001FF00000000
      F000007FFC01C007F80001FF00000000F00001FFFC01E007F80001FF00000000
      F0003FFFF803E01FF06000FF00000000F000FFFFF803E00FF00000FF00000000
      F003C01FF803F00FF01800FF00000000F007C01FF007F007F0F800FF00000000
      F000001FF007F807F1F800FF00000000F000003FE007F803F1FE00FF00000000
      F000003FE00FF803F0F000FF00000000F800007FE00FFC03F82001FF00000000
      FC0000FFE01FFC03FE0003FF00000000FF8003FFE01FFE01FF811FFF00000000
      FFFFFFFFFFFFFFFFFFC0FFFF00000000FFFFFFFFFFFFFFFFFFF9FFFF00000000
      FFFFFFFFFFFFFFFFFFFFFFFF00000000F000000FC0000003FFFFFFFFFFFFFFFF
      E0000007C0000003FFFFFE1FFFFFFFFF8000000380000001C0000003C0000003
      8000000180000001C0000003C00000030000000100000001C0000001C0000003
      0000000000000000C0000001C00000030000000000000000C0000001C0000003
      0000000000000000C0000001C00000030000000000000000C0000001C0000003
      0000000000000000C3FF0001C07F00030000000000000000CFFF0001C07F0003
      0000000000000000DFFF0001C07F00030000000000000000FF830001C0FF0003
      0000000000000000FF010001C0FF80030000000000000000FE000001C0FF8003
      0000000000000000C0010001C1F380030000000000000000C0030001C1F38003
      0000000000000000C03F0003C3E380030000000000000000C3FF0003C3E1E003
      0000000100000000C7FFE003C7E1E0030000000100000000DFFF0003C7C0F003
      0000000100000000DFF80003C7C0F0030000000300000000FF800003CF80F803
      0000000300000000FF000003CF807C030000000300000000FF01F003CF807C03
      0000000300000000DF03F003DF803C038000000300000000DFFFE003DF003E03
      8000000300000000CFFFC003FF003E038000000300000000C3FF8003FE001E03
      8000000300000000C0000003FE001F038000000300000000FFFFFFFFFFFFFFFF
      FC00003F00000000FFFFFFFFFFFFFFFFF39CE33FC107181FE000000FC003FFFF
      DCE721CF0003080FC000000F0003FFFFE739C07300000007C000000F8003FFFF
      39CE601C00000003C000000F8003FFFFCE73802700000001C000000FC00003FF
      739CE01900000000C000000FE00003FF0007200000000000C000000FF000007F
      FFF1C00300000000C000000FF800003FFFF6600300000000C000000FFC00000F
      FFD0000300000000C000000FF8000007FF80000300000000C000000FC0000000
      FF80000300000000C000000F00000000FF80000300000000C000000F00000000
      FF800003000000008000000700000000F0000003000000008000000300000000
      E0000103000000008000000100000000C0000003000000008000000100000000
      8000000300000000800000010000000080000003000000008000000100000000
      8FFC000300000000800000010000000080080003000000008000000000000000
      C0100003000000008000000C00000000FF800003000010008000000F00000000
      FF800003000018008000000F00000000FF800003800018008000000FF0000000
      FF800003C0001C008000001FFC000000FF900003E0001E0080007FFFFF000003
      FFF00003F003FF0080007FFFFF00001FFFF00003F803FF8080007FFFFFC003FF
      FFF00007FC03FFC080007FFFFFC00FFFFFF0000FFF03FFFF8000FFFFFFF0FFFF
      FFFFFFFFFF83FFFFC001FFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object ptACCTRNH: TNexPxTable
    Active = False
    TableName = 'ACCTRNH'
    FixName = 'ACCTRNH'
    DefName = 'ACCTRNH.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 418
    Top = 313
  end
  object ptACCTRNI: TNexPxTable
    Active = False
    TableName = 'ACCTRNI'
    FixName = 'ACCTRNI'
    DefName = 'ACCTRNI.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 480
    Top = 312
  end
  object btVTBAWR: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'VTBAWR'
    TableName = 'VTBAWR'
    DOSStrings = True
    DefName = 'VTBAWR.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 742
    Top = 241
  end
  object btVTC: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'VTC'
    TableName = 'VTC'
    DOSStrings = True
    DefName = 'VTC.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 742
    Top = 214
  end
  object btMTBSTC: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'MTBSTC'
    TableName = 'MTBSTC'
    DOSStrings = True
    DefName = 'MTBSTC.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 632
    Top = 8
  end
  object btMTBIMD: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'MTBIMD'
    TableName = 'MTBIMD'
    DOSStrings = True
    DefName = 'MTBIMD.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 634
    Top = 53
  end
  object btMTBOMD: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'MTBOMD'
    TableName = 'MTBOMD'
    DOSStrings = True
    DefName = 'MTBOMD.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 635
    Top = 99
  end
  object ptMTBSTM: TNexPxTable
    Active = False
    TableName = 'MTBSTM'
    FixName = 'MTBSTM'
    DefName = 'MTBSTM.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 388
    Top = 1
  end
  object ptMTBIMD: TNexPxTable
    Active = False
    TableName = 'MTBIMD'
    FixName = 'MTBIMD'
    DefName = 'MTBIMD.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 568
    Top = 53
  end
  object ptMTBSTC: TNexPxTable
    Active = False
    TableName = 'MTBSTC'
    FixName = 'MTBSTC'
    DefName = 'MTBSTC.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 568
    Top = 8
  end
  object ptMTBOMD: TNexPxTable
    Active = False
    TableName = 'MTBOMD'
    FixName = 'MTBOMD'
    DefName = 'MTBOMD.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 569
    Top = 100
  end
  object ptSRPRN: TNexPxTable
    Active = False
    TableName = 'SRPRN_A'
    FixName = 'SRPRN_A'
    DefName = 'SRPRN_A.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 512
    Top = 451
  end
  object ptSRPAL: TPxTable
    BeforeOpen = ptSRPALBeforeOpen
    TableName = 'SRPAL'
    Left = 565
    Top = 451
  end
  object btICDPEN: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'ICDPEN'
    TableName = 'ICDPEN'
    DOSStrings = True
    DefName = 'ICDPEN.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 424
    Top = 48
  end
  object ptVTBVER: TNexPxTable
    Active = False
    TableName = 'VTBVER'
    FixName = 'VTBVER'
    DefName = 'VTBVER.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 558
    Top = 529
  end
  object ptFXSUI: TPxTable
    BeforeOpen = ptFXSUIBeforeOpen
    TableName = 'FXSUI'
    Left = 268
    Top = 411
  end
  object ptFXACRDI: TPxTable
    BeforeOpen = ptFXACRDIBeforeOpen
    TableName = 'FXACRDI'
    Left = 436
    Top = 409
  end
  object ptFXACRDH: TPxTable
    BeforeOpen = ptFXACRDHBeforeOpen
    TableName = 'FXACRDH'
    Left = 373
    Top = 410
  end
  object ptFXSUH: TPxTable
    BeforeOpen = ptFXSUHBeforeOpen
    TableName = 'FXSUH'
    Left = 315
    Top = 411
  end
  object btFXM: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'FXM'
    TableName = 'FXM'
    DOSStrings = True
    DefName = 'FXM.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 547
    Top = 162
  end
  object ptFXM: TNexPxTable
    Active = False
    TableName = 'FXM'
    FixName = 'FXM'
    DefName = 'FXM.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 587
    Top = 162
  end
  object ptJRNVER: TPxTable
    BeforeOpen = ptJRNVERBeforeOpen
    TableName = 'JRNVER'
    Left = 440
    Top = 240
  end
  object btRCHS: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'RCHS'
    TableName = 'RCHS'
    DOSStrings = True
    DefName = 'RCHS.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 576
    Top = 216
  end
  object btRCIS: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'RCIS'
    TableName = 'RCIS'
    DOSStrings = True
    DefName = 'RCIS.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 576
    Top = 264
  end
  object ptRCIS: TNexPxTable
    Active = False
    TableName = 'RCIS'
    FixName = 'RCIS'
    DefName = 'RCIS.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 576
    Top = 312
  end
  object btRCHC: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'RCHC'
    TableName = 'RCHC'
    DOSStrings = True
    DefName = 'RCHC.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 623
    Top = 216
  end
  object btRCIC: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'RCIC'
    TableName = 'RCIC'
    DOSStrings = True
    DefName = 'RCIC.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 623
    Top = 264
  end
  object ptRCIC: TNexPxTable
    Active = False
    TableName = 'RCIC'
    FixName = 'RCIC'
    DefName = 'RCIC.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 623
    Top = 312
  end
  object btCRSHIS: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'CRSHIS'
    TableName = 'CRSHIS'
    DOSStrings = True
    DefName = 'CRSHIS.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 340
  end
  object btCRSLST: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'CRSLST'
    TableName = 'CRSLST'
    DOSStrings = True
    DefName = 'CRSLST.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    AfterOpen = btCRSLSTAfterOpen
    Left = 286
    Top = 1
  end
  object ptABODOC: TNexPxTable
    Active = False
    TableName = 'ABODOC'
    FixName = 'ABODOC'
    DefName = 'ABODOC.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 171
    Top = 412
  end
  object ptABOITM: TNexPxTable
    Active = False
    TableName = 'ABOITM'
    FixName = 'ABOITM'
    DefName = 'ABOITM.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 221
    Top = 412
  end
  object ptVATVER: TNexPxTable
    Active = False
    TableName = 'VATVER'
    FixName = 'VATVER'
    DefName = 'VATVER.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 592
    Top = 528
  end
  object ptACCBLC: TNexPxTable
    Active = False
    TableName = 'ACCBLC'
    FixName = 'ACCBLC'
    DefName = 'ACCBLC.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 448
    Top = 312
  end
  object btOWH: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'OWH'
    TableName = 'OWH'
    DOSStrings = True
    DefName = 'OWH.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 74
    Top = 129
  end
  object btOWI: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'OWI'
    TableName = 'OWI'
    DOSStrings = True
    DefName = 'OWI.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 112
    Top = 129
  end
  object btOWN: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'OWN'
    TableName = 'OWN'
    DOSStrings = True
    DefName = 'OWN.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 188
    Top = 129
  end
  object ptOWI: TNexPxTable
    Active = False
    TableName = 'OWI'
    FixName = 'OWI'
    DefName = 'OWI.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 147
    Top = 130
  end
  object ptOWH: TNexPxTable
    Active = False
    TableName = 'OWH'
    FixName = 'OWH'
    DefName = 'OWH.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 227
    Top = 129
  end
  object ptFXTGRP: TNexPxTable
    Active = False
    TableName = 'FXTGRP'
    FixName = 'FXTGRP'
    DefName = 'FXTGRP.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 499
    Top = 162
  end
  object ptFXA: TNexPxTable
    Active = False
    TableName = 'FXA'
    FixName = 'FXA'
    DefName = 'FXA.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 624
    Top = 162
  end
  object ptVTBSRL: TNexPxTable
    Active = False
    TableName = 'VTBSRL'
    FixName = 'VTBSRL'
    DefName = 'VTBSRL.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 747
    Top = 426
  end
  object ptVTBSRW: TNexPxTable
    Active = False
    TableName = 'VTBSRW'
    FixName = 'VTBSRW'
    DefName = 'VTBSRW.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 746
    Top = 498
  end
  object btVTCSPCx: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'VTCSPC'
    TableName = 'VTCSPC'
    DOSStrings = True
    DefName = 'VTCSPC.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 740
    Top = 185
  end
  object ptACCVER: TNexPxTable
    Active = False
    TableName = 'ACCVER'
    FixName = 'ACCVER'
    DefName = 'ACCVER.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 689
    Top = 48
  end
  object ptPAYVER: TNexPxTable
    Active = False
    TableName = 'PAYVER'
    FixName = 'PAYVER'
    DefName = 'PAYVER.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 442
    Top = 272
  end
  object btPMQ: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'PMQ'
    TableName = 'PMQ'
    DOSStrings = True
    DefName = 'PMQ.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 429
    Top = 368
  end
  object btREWDOC: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'REWDOC'
    TableName = 'REWDOC'
    DOSStrings = True
    DefName = 'REWDOC.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 737
    Top = 4
  end
  object btREWITM: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'REWITM'
    TableName = 'REWITM'
    DOSStrings = True
    DefName = 'REWITM.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 737
    Top = 47
  end
  object ptREWITM: TNexPxTable
    Active = False
    TableName = 'REWITM'
    FixName = 'REWITM'
    DefName = 'REWITM.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 737
    Top = 90
  end
  object ptREWHIS: TNexPxTable
    Active = False
    TableName = 'REWHIS'
    FixName = 'REWHIS'
    DefName = 'REWHIS.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 739
    Top = 133
  end
  object ptCSFREP: TNexPxTable
    Active = False
    TableName = 'CSFREP'
    FixName = 'CSFREP'
    DefName = 'CSFREP.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 492
    Top = 203
  end
  object btICDSPC: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'ICDSPC'
    TableName = 'ICDSPC'
    DOSStrings = True
    DefName = 'ICDSPC.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 321
    Top = 45
  end
  object btISDSPC: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'ISDSPC'
    TableName = 'ISDSPC'
    DOSStrings = True
    DefName = 'ISDSPC.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 337
    Top = 86
  end
  object ptSRPRH: TNexPxTable
    Active = False
    TableName = 'SRPRH'
    FixName = 'SRPRH'
    DefName = 'SRPRH_B.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 616
    Top = 450
  end
  object btVTRLST: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'VTRLST'
    TableName = 'VTRLST'
    DOSStrings = True
    DefName = 'VTRLST.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 671
    Top = 225
  end
  object btVTR: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'VTR'
    TableName = 'VTR'
    DOSStrings = True
    DefName = 'VTR.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 672
    Top = 268
  end
  object btVTDSPC: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'VTDSPC'
    TableName = 'VTDSPC'
    DOSStrings = True
    DefName = 'VTDSPC.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 672
    Top = 313
  end
  object btVTRAWR: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'VTRAWR'
    TableName = 'VTRAWR'
    DOSStrings = True
    DefName = 'VTRAWR.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 673
    Top = 357
  end
  object ptVTRSUM: TNexPxTable
    Active = False
    TableName = 'VTRSUM'
    FixName = 'VTRSUM'
    DefName = 'VTRSUM.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 672
    Top = 400
  end
  object btACT: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'ACT'
    TableName = 'ACT'
    DOSStrings = True
    DefName = 'ACT.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 552
    Top = 400
  end
  object btACTLST: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'ACTLST'
    TableName = 'ACTLST'
    DOSStrings = True
    DefName = 'ACTLST.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 592
    Top = 400
  end
  object btICPDEF: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'ICPDEF'
    TableName = 'ICPDEF'
    DOSStrings = True
    DefName = 'ICPDEF.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 529
    Top = 288
  end
  object ptICPEVL: TNexPxTable
    Active = False
    TableName = 'ICPEVL'
    FixName = 'ICPEVL'
    DefName = 'ICPEVL.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 527
    Top = 245
  end
  object btICC: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'ICC'
    TableName = 'ICC'
    DOSStrings = True
    DefName = 'ICI.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 364
    Top = 44
  end
  object btVTRANL: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'VTRANL'
    TableName = 'VTRANL'
    DOSStrings = True
    DefName = 'VTRANL.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 672
    Top = 451
  end
  object ptVTR: TNexPxTable
    Active = False
    AfterCancel = btCRSLSTAfterOpen
    TableName = 'VTR'
    FixName = 'VTR'
    DefName = 'VTR.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 672
    Top = 499
  end
  object btABODAT: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'ABODAT'
    TableName = 'ABODAT'
    DOSStrings = True
    DefName = 'ABODAT.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 277
    Top = 369
  end
  object btFXAASD: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'FXAASD'
    TableName = 'FXAASD'
    DOSStrings = True
    DefName = 'FXAASD.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 672
    Top = 162
  end
  object ptVTRAWR: TNexPxTable
    Active = False
    TableName = 'VTRAWR'
    FixName = 'VTRAWR'
    DefName = 'VTRAWR.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 674
    Top = 549
  end
  object ptISPEVL: TNexPxTable
    Active = False
    TableName = 'ISPEVL'
    FixName = 'ISPEVL'
    DefName = 'ISPEVL.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 284
    Top = 86
  end
  object btISPDEF: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'ISPDEF'
    TableName = 'ISPDEF'
    DOSStrings = True
    DefName = 'ISPDEF.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 392
    Top = 85
  end
  object ptICPITM: TNexPxTable
    Active = False
    TableName = 'ICPITM'
    FixName = 'ICPITM'
    DefName = 'ICPITM.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 487
    Top = 261
  end
  object btWABLST: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'WABLST'
    DOSStrings = True
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 24
    Top = 560
  end
  object btWAH: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'WAH'
    DOSStrings = True
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 88
    Top = 560
  end
  object btWAI: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'WAI'
    DOSStrings = True
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 144
    Top = 560
  end
  object btWARDEF: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'WARDEF'
    DOSStrings = True
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 200
    Top = 560
  end
  object ptCSBLST: TNexPxTable
    Active = False
    TableName = 'CSBLST'
    FixName = 'CSBLST'
    DefName = 'CSBLST.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 440
    Top = 203
  end
  object btVTI: TNexBtrTable
    Tag = 1806012
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'VTR'
    TableName = 'VTI'
    DOSStrings = True
    DefName = 'VTI.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 808
    Top = 268
  end
end
