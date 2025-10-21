object dmSTATIS: TdmSTATIS
  OldCreateOrder = False
  Left = 198
  Top = 106
  Height = 375
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
end
