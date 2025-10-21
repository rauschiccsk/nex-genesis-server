object dmSTA: TdmSTA
  OldCreateOrder = False
  Left = 198
  Top = 106
  Height = 437
  Width = 544
  object dtGSCAT: TDbfTable
    BeforeOpen = dtGSCATBeforeOpen
    TableName = 'GSCAT'
    TableType = ttParadox
    Left = 16
    Top = 9
  end
  object dtMGCAT: TDbfTable
    BeforeOpen = dtMGCATBeforeOpen
    TableName = 'GCAT'
    TableType = ttParadox
    Left = 64
    Top = 9
  end
  object dtGSD: TDbfTable
    BeforeOpen = dtGSDBeforeOpen
    TableName = 'GSD'
    TableType = ttParadox
    Left = 113
    Top = 9
  end
  object dtSADC: TDbfTable
    BeforeOpen = dtSADCBeforeOpen
    BeforePost = dtSADCBeforePost
    TableName = 'SADAYC'
    TableType = ttParadox
    Left = 16
    Top = 58
  end
  object dtSAWC: TDbfTable
    BeforeOpen = dtSAWCBeforeOpen
    BeforePost = dtSAWCBeforePost
    TableName = 'SAWEEKC'
    TableType = ttParadox
    Left = 64
    Top = 58
  end
  object dtSAMC: TDbfTable
    BeforeOpen = dtSAMCBeforeOpen
    BeforePost = dtSAMCBeforePost
    TableName = 'SAMTHC'
    TableType = ttParadox
    Left = 112
    Top = 58
  end
  object dtSAYC: TDbfTable
    BeforeOpen = dtSAYCBeforeOpen
    BeforePost = dtSAYCBeforePost
    TableName = 'SAYEARC'
    TableType = ttParadox
    Left = 160
    Top = 58
  end
  object dtSADP: TDbfTable
    BeforeOpen = dtSADPBeforeOpen
    BeforePost = dtSADPBeforePost
    TableName = 'SADAYP'
    TableType = ttParadox
    Left = 16
    Top = 108
  end
  object dtSAWP: TDbfTable
    BeforeOpen = dtSAWPBeforeOpen
    BeforePost = dtSAWPBeforePost
    TableName = 'SAWEEKP'
    TableType = ttParadox
    Left = 64
    Top = 108
  end
  object dtSAMP: TDbfTable
    BeforeOpen = dtSAMPBeforeOpen
    BeforePost = dtSAMPBeforePost
    TableName = 'SAMTHP'
    TableType = ttParadox
    Left = 112
    Top = 108
  end
  object dtSAYP: TDbfTable
    BeforeOpen = dtSAYPBeforeOpen
    BeforePost = dtSAYPBeforePost
    TableName = 'SAYEARP'
    TableType = ttParadox
    Left = 160
    Top = 108
  end
  object ptSAMGSUM: TPxTable
    BeforeOpen = ptSAMGSUMBeforeOpen
    TableName = 'SAMGSUM'
    TableType = ttParadox
    Left = 16
    Top = 208
  end
  object dtSAMG: TDbfTable
    BeforeOpen = dtSAMGBeforeOpen
    TableName = 'SAMG'
    TableType = ttParadox
    Left = 16
    Top = 160
  end
  object ptSACASSUM: TPxTable
    BeforeOpen = ptSACASSUMBeforeOpen
    TableName = 'SACASSUM'
    Left = 90
    Top = 208
  end
  object dtGSM: TDbfTable
    BeforeOpen = dtGSMBeforeOpen
    TableName = 'GSM'
    TableType = ttParadox
    Left = 164
    Top = 8
  end
  object ptSAGSSUM: TPxTable
    BeforeOpen = ptSAGSSUMBeforeOpen
    TableName = 'SAGSSUM'
    Left = 160
    Top = 208
  end
  object dtMSALST: TDbfTable
    BeforeOpen = dtMSALSTBeforeOpen
    TableName = 'MSALST'
    TableType = ttParadox
    Left = 280
    Top = 8
  end
  object dtMSA: TDbfTable
    BeforeOpen = dtMSABeforeOpen
    TableName = 'MSA'
    TableType = ttParadox
    Left = 280
    Top = 56
  end
  object ptDAYSTM: TNexPxTable
    Active = False
    TableName = 'DAYSTM'
    FixName = 'DAYSTM'
    DefName = 'DAYSTM.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 255
    Top = 220
  end
  object ptCUSGSL: TNexPxTable
    Active = False
    TableName = 'CUSGSL'
    FixName = 'CUSGSL'
    DefName = 'CUSGSL.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 314
    Top = 219
  end
  object ptMGEVAL: TNexPxTable
    Active = False
    TableName = 'MGEVAL'
    FixName = 'MGEVAL'
    DefName = 'MGEVAL.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 382
    Top = 220
  end
  object ptFGEVAL: TNexPxTable
    Active = False
    TableName = 'FGEVAL'
    FixName = 'FGEVAL'
    DefName = 'FGEVAL.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 446
    Top = 220
  end
  object btCSTSALGS: TNexBtrTable
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'CSTSALGS'
    TableName = 'CSTSALGS'
    DOSStrings = True
    DefName = 'CSTSALGS.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 24
    Top = 280
  end
  object btCSTSALMG: TNexBtrTable
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'CSTSALMG'
    TableName = 'CSTSALMG'
    DOSStrings = True
    DefName = 'CSTSALMG.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 98
    Top = 280
  end
  object ptCSTSALMG: TNexPxTable
    Active = False
    TableName = 'CSTSALMG'
    DefName = 'CSTSALMG.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 170
    Top = 280
  end
  object ptCSTTOPPA: TNexPxTable
    Active = False
    TableName = 'CSTTOPPA'
    FixName = 'CSTTOPPA'
    DefName = 'CSTTOPPA.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 386
    Top = 280
  end
  object btCSTPACAX: TNexBtrTable
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'CSTPACAX'
    TableName = 'CSTPACAX'
    DOSStrings = True
    DefName = 'CSTPACAX.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 27
    Top = 328
  end
  object btCSTPACMN: TNexBtrTable
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'CSTPACMN'
    TableName = 'CSTPACMN'
    DOSStrings = True
    DefName = 'CSTPACMN.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 100
    Top = 328
  end
  object ptREWDLR: TNexPxTable
    Active = False
    TableName = 'REWDLR'
    FixName = 'REWDLR'
    DefName = 'REWDLR.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 413
    Top = 16
  end
  object btCSTSTMGS: TNexBtrTable
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'CSTSTMGS'
    TableName = 'CSTSTMGS'
    DOSStrings = True
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 176
    Top = 328
  end
  object ptCSTSALFG: TNexPxTable
    Active = False
    TableName = 'CSTSALFG'
    FixName = 'CSTSALFG'
    DefName = 'CSTSALFG.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 314
    Top = 280
  end
  object btCSTSALFG: TNexBtrTable
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'CSTSALFG'
    TableName = 'CSTSALFG'
    DOSStrings = True
    DefName = 'CSTSALFG.BDF'
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 242
    Top = 280
  end
end
