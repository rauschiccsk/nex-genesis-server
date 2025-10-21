object dmPRN: TdmPRN
  OldCreateOrder = False
  Left = 294
  Top = 28
  Height = 574
  Width = 617
  object ptMPDLST: TPxTable
    BeforeOpen = ptMPDLSTBeforeOpen
    TableName = 'MPDLST'
    Left = 14
    Top = 53
  end
  object ptSTMREP: TPxTable
    BeforeOpen = ptSTMREPBeforeOpen
    TableName = 'STMREP'
    Left = 16
    Top = 101
  end
  object ptSUVA: TPxTable
    BeforeOpen = ptSUVABeforeOpen
    BeforePost = ptSUVABeforePost
    TableName = 'SUV_A'
    Left = 16
    Top = 141
  end
  object ptSUVP: TPxTable
    BeforeOpen = ptSUVPBeforeOpen
    BeforePost = ptSUVPBeforePost
    TableName = 'SUV_P'
    Left = 64
    Top = 141
  end
  object ptIVITEM: TPxTable
    BeforeOpen = ptIVITEMBeforeOpen
    TableName = 'IVITEM'
    Left = 408
    Top = 8
  end
  object ptDOCREP: TPxTable
    BeforeOpen = ptDOCREPBeforeOpen
    TableName = 'DOCREP'
    Left = 16
    Top = 189
  end
  object ptIVMGSUM: TPxTable
    BeforeOpen = ptIVMGSUMBeforeOpen
    TableName = 'IVMGSUM'
    Left = 464
    Top = 54
  end
  object ptSTMMGSUM: TPxTable
    BeforeOpen = ptSTMMGSUMBeforeOpen
    TableName = 'STMMGSUM'
    Left = 88
    Top = 93
  end
  object ptCSDOC: TPxTable
    BeforeOpen = ptCSDOCBeforeOpen
    TableName = 'CSDOC'
    Left = 104
    Top = 235
  end
  object ptFIFOPRN: TPxTable
    BeforeOpen = ptFIFOPRNBeforeOpen
    TableName = 'FIFOPRN'
    Left = 160
    Top = 101
  end
  object ptFINJOUR: TPxTable
    BeforeOpen = ptFINJOURBeforeOpen
    TableName = 'FINJOUR'
    Left = 16
    Top = 235
  end
  object ptACCOUNT: TPxTable
    BeforeOpen = ptACCOUNTBeforeOpen
    TableName = 'ACCOUNT'
    Left = 392
    Top = 100
  end
  object ptCOI: TPxTable
    BeforeOpen = ptCOIBeforeOpen
    TableName = 'COI'
    Left = 248
    Top = 104
  end
  object ptCSH: TPxTable
    BeforeOpen = ptCSHBeforeOpen
    TableName = 'CSH'
    Left = 152
    Top = 235
  end
  object ptCSHEAD: TPxTable
    BeforeOpen = ptCSHEADBeforeOpen
    TableName = 'CSHEAD'
    Left = 200
    Top = 235
  end
  object ptFXL: TPxTable
    BeforeOpen = ptFXLBeforeOpen
    TableName = 'PRNFXL'
    Left = 470
    Top = 196
  end
  object ptISHEAD: TPxTable
    BeforeOpen = ptISHEADBeforeOpen
    TableName = 'ISHEAD'
    Left = 257
    Top = 235
  end
  object ptFXA: TPxTable
    BeforeOpen = ptFXABeforeOpen
    TableName = 'FXA'
    Left = 419
    Top = 196
  end
  object ptNOPAIR: TPxTable
    BeforeOpen = ptNOPAIRBeforeOpen
    TableName = 'NOPAIR'
    Left = 324
    Top = 144
  end
  object ptSMA: TPxTable
    BeforeOpen = ptSMABeforeOpen
    TableName = 'SMA'
    Left = 336
    Top = 200
  end
  object ptVYS: TPxTable
    BeforeOpen = ptVYSBeforeOpen
    BeforePost = ptVYSBeforePost
    TableName = 'VYS'
    Left = 112
    Top = 141
  end
  object ptRECOPROF: TPxTable
    BeforeOpen = ptRECOPROFBeforeOpen
    TableName = 'RECOPROF'
    Left = 392
    Top = 144
  end
  object ptAFTPAYIC: TPxTable
    BeforeOpen = ptAFTPAYICBeforeOpen
    TableName = 'AFTPAYIC'
    Left = 16
    Top = 480
  end
  object ptNOPAYIC: TPxTable
    BeforeOpen = ptNOPAYICBeforeOpen
    TableName = 'NOPAYIC'
    Left = 88
    Top = 480
  end
  object ptPLSLAB: TPxTable
    BeforeOpen = ptPLSLABBeforeOpen
    TableName = 'PLSLAB'
    Left = 504
    Top = 56
  end
  object ptICH: TPxTable
    BeforeOpen = ptICHBeforeOpen
    TableName = 'ICH'
    Left = 320
    Top = 464
  end
  object ptACCFNJ: TPxTable
    BeforeOpen = ptACCFNJBeforeOpen
    TableName = 'ACCFNJ'
    Left = 384
    Top = 464
  end
  object ptJRNHEAD: TPxTable
    BeforeOpen = ptJRNHEADBeforeOpen
    TableName = 'JRNHEAD'
    Left = 504
    Top = 104
  end
  object ptJRNITEM: TPxTable
    TableName = 'JRNITEM'
    Left = 508
    Top = 150
  end
  object ptREFUND: TNexPxTable
    Active = False
    TableName = 'REFUND'
    DefName = 'REFUND.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 464
    Top = 8
  end
  object ptPFRONT: TNexPxTable
    Active = False
    TableName = 'PFRONT'
    FixName = 'PFRONT'
    DefName = 'PFRONT.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 24
    Top = 8
  end
  object ptDOCHEAD: TNexPxTable
    Active = False
    TableName = 'DHEAD'
    FixName = 'DHEAD'
    DefName = 'DHEAD.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 88
    Top = 8
  end
  object ptDHEAD: TNexPxTable
    Active = False
    TableName = 'DHEAD'
    FixName = 'DHEAD'
    DefName = 'DHEAD.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 152
    Top = 8
  end
  object btLHEAD: TNexPxTable
    Active = False
    TableName = 'LHEAD'
    FixName = 'LHEAD'
    DefName = 'LHEAD.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 208
    Top = 8
  end
  object ptNOTICES: TNexPxTable
    Active = False
    TableName = 'NOTICE'
    FixName = 'NOTICE'
    DefName = 'NOTICE.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 264
    Top = 8
  end
  object ptTOPCUS: TNexPxTable
    Active = False
    TableName = 'TOPCUS'
    FixName = 'TOPCUS'
    DefName = 'TOPCUS.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 368
    Top = 240
  end
  object ptSALEVL: TNexPxTable
    Active = False
    TableName = 'SALEVL'
    FixName = 'SALEVL'
    DefName = 'SALEVL.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 296
    Top = 216
  end
  object ptDRBLST: TNexPxTable
    Active = False
    TableName = 'DRBLST'
    FixName = 'DRBLST'
    DefName = 'DRBLST.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 200
    Top = 56
  end
  object ptSTMSUM: TNexPxTable
    Active = False
    TableName = 'STMSUM'
    FixName = 'STMSUM'
    DefName = 'STMSUM.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 320
    Top = 56
  end
  object ptTOPSAP: TNexPxTable
    Active = False
    TableName = 'TOPSAP'
    FixName = 'TOPSAP'
    DefName = 'TOPSAP.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 424
    Top = 240
  end
  object ptSNTSUM: TNexPxTable
    Active = False
    TableName = 'SNTSUM'
    FixName = 'SNTSUM'
    DefName = 'SNTSUM.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 172
    Top = 186
  end
  object ptICDPRF: TNexPxTable
    Active = False
    TableName = 'ICDPRF'
    FixName = 'ICDPRF'
    DefName = 'ICDPRF.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 480
    Top = 240
  end
  object ptBOOKVER: TNexPxTable
    Active = False
    TableName = 'BOOKVER'
    FixName = 'BOOKVER'
    DefName = 'BOOKVER.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 360
    Top = 288
  end
  object ptDOCVER: TNexPxTable
    Active = False
    TableName = 'DOCVER'
    FixName = 'DOCVER'
    DefName = 'DOCVER.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 424
    Top = 288
  end
  object ptMGCMOV: TNexPxTable
    Active = False
    TableName = 'MGCMOV'
    FixName = 'MGCMOV'
    DefName = 'MGCMOV.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 528
    Top = 288
  end
  object ptPCKVER: TNexPxTable
    Active = False
    TableName = 'PCKVER'
    FixName = 'PCKVER'
    DefName = 'PCKVER.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 536
    Top = 200
  end
  object ptFHEAD: TNexPxTable
    Active = False
    TableName = 'FHEAD'
    FixName = 'FHEAD'
    DefName = 'FHEAD.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 320
    Top = 8
  end
  object ptWRIEVL: TNexPxTable
    Active = False
    TableName = 'WRIEVL'
    FixName = 'WRIEVL'
    DefName = 'WRIEVL.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 16
    Top = 280
  end
  object ptWMGEVL: TNexPxTable
    Active = False
    TableName = 'WMGEVL'
    FixName = 'WMGEVL'
    DefName = 'WMGEVL.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 145
    Top = 280
  end
  object ptWRIEVLH: TNexPxTable
    Active = False
    TableName = 'WRIEVLH'
    FixName = 'WRIEVLH'
    DefName = 'WRIEVLH.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 80
    Top = 280
  end
  object ptWGSEVL: TNexPxTable
    Active = False
    TableName = 'WGSEVL'
    FixName = 'WGSEVL'
    DefName = 'WGSEVL.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 208
    Top = 280
  end
  object ptCTYSAL: TNexPxTable
    Active = False
    TableName = 'CTYSAL'
    FixName = 'CTYSAL'
    DefName = 'CTYSAL.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 536
    Top = 240
  end
  object ptCNSSAL: TNexPxTable
    Active = False
    TableName = 'CNSSAL'
    FixName = 'CNSSAL'
    DefName = 'CNSSAL.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 160
    Top = 51
  end
  object ptVTD: TNexPxTable
    Active = False
    TableName = 'VTD'
    FixName = 'VTD'
    DefName = 'VTD.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 448
    Top = 104
  end
  object ptLAPCHG: TNexPxTable
    Active = False
    TableName = 'LAPCHG'
    FixName = 'LAPCHG'
    DefName = 'LAPCHG.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 248
    Top = 160
  end
  object ptBPCVER: TNexPxTable
    Active = False
    TableName = 'BPCVER'
    FixName = 'BPCVER'
    DefName = 'BPCVER.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 288
    Top = 288
  end
  object ptBACDUP: TNexPxTable
    Active = False
    TableName = 'BACDUP'
    FixName = 'BACDUP'
    DefName = 'BACDUP.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 96
    Top = 192
  end
  object ptDAYGSM: TNexPxTable
    Active = False
    TableName = 'DAYGSM'
    FixName = 'DAYGSM'
    DefName = 'DAYGSM.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 168
    Top = 144
  end
  object ptCAGSSRCH: TNexPxTable
    Active = False
    TableName = 'CAGSSRCH'
    FixName = 'CAGSSRCH'
    DefName = 'CAGSSRCH.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 528
    Top = 8
  end
  object ptBHEAD: TNexPxTable
    Active = False
    TableName = 'BHEAD'
    FixName = 'BHEAD'
    DefName = 'BHEAD.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 368
    Top = 9
  end
  object ptWRSEVL: TNexPxTable
    Active = False
    BeforePost = ptWRSEVLBeforePost
    TableName = 'WRSEVL'
    DefName = 'WRSEVL.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 15
    Top = 336
  end
  object ptSCIPRN: TNexPxTable
    Active = False
    TableName = 'SCIPRN'
    FixName = 'SCIPRN'
    DefName = 'SCIPRN.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 88
    Top = 336
  end
  object ptSCHPRN: TNexPxTable
    Active = False
    TableName = 'SCHPRN'
    FixName = 'SCHPRN'
    DefName = 'SCHPRN.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 152
    Top = 336
  end
  object ptREPHEAD: TNexPxTable
    Active = False
    TableName = 'REPHEAD'
    FixName = 'REPHEAD'
    DefName = 'REPHEAD.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 208
    Top = 336
  end
  object ptRWMVER: TNexPxTable
    Active = False
    TableName = 'RWMVER'
    FixName = 'RWMVER'
    DefName = 'RWMVER.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 336
    Top = 352
  end
  object ptWICHVER: TNexPxTable
    Active = False
    TableName = 'WICHVER'
    FixName = 'WICHVER'
    DefName = 'ICH.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 432
    Top = 352
  end
  object ptTMP: TNexPxTable
    Active = False
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 24
    Top = 392
  end
  object ptOPDSCP: TNexPxTable
    Active = False
    TableName = 'OPDSCP'
    FixName = 'OPDSCP'
    DefName = 'OPDSCP.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 104
    Top = 400
  end
  object ptOPDSCG: TNexPxTable
    Active = False
    TableName = 'OPDSCG'
    FixName = 'OPDSCG'
    DefName = 'OPDSCG.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 168
    Top = 400
  end
  object ptOPDSCA: TNexPxTable
    Active = False
    TableName = 'OPDSCA'
    FixName = 'OPDSCA'
    DefName = 'OPDSCA.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 232
    Top = 400
  end
  object ptDAYSUM: TNexPxTable
    Active = False
    TableName = 'DAYSUM'
    FixName = 'DAYSUM'
    DefName = 'DAYSUM.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 336
    Top = 400
  end
  object ptPACSUM: TNexPxTable
    Active = False
    TableName = 'PACSUM'
    FixName = 'PACSUM'
    DefName = 'PACSUM.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 384
    Top = 400
  end
  object ptACMPAS: TNexPxTable
    Active = False
    TableName = 'ACMPAS'
    FixName = 'ACMPAS'
    DefName = 'ACMPAS.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 472
    Top = 456
  end
  object ptANLSUM: TNexPxTable
    Active = False
    TableName = 'ANLSUM'
    FixName = 'ANLSUM'
    DefName = 'ANLSUM.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 321
    Top = 100
  end
  object ptSTMACC: TNexPxTable
    Active = False
    TableName = 'STMACC'
    FixName = 'STMACC'
    DefName = 'STMACC.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 390
    Top = 56
  end
  object ptBLCCLVER: TNexPxTable
    Active = False
    TableName = 'BLCCLVER.DB'
    FixName = 'BLCCLVER'
    DefName = 'blcclver.tdf'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 224
    Top = 480
  end
end
