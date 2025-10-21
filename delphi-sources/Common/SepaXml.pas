
{***************************************************************************************}
{                                                                                       }
{                                Delphi XML Data Binding                                }
{                                                                                       }
{         Generated on: 4.1.2018 20:56:15                                               }
{       Generated from: C:\NEX Develop\Aplikácie\Pomocné programy\SEPAXML\SEPAXML.xml   }
{   Settings stored in: C:\NEX Develop\Aplikácie\Pomocné programy\SEPAXML\SEPAXML.xdb   }
{                                                                                       }
{***************************************************************************************}
unit SepaXml;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLDocumentType = interface;
  IXMLBkToCstmrStmtType = interface;
  IXMLGrpHdrType = interface;
  IXMLMsgRcptType = interface;
  IXMLPstlAdrType = interface;
  IXMLIdType = interface;
  IXMLOrgIdType = interface;
  IXMLOthrType = interface;
  IXMLStmtType = interface;
  IXMLFrToDtType = interface;
  IXMLAcctType = interface;
  IXMLOwnrType = interface;
  IXMLSvcrType = interface;
  IXMLFinInstnIdType = interface;
  IXMLBalType = interface;
  IXMLBalTypeList = interface;
  IXMLTpType = interface;
  IXMLCdOrPrtryType = interface;
  IXMLAmtType = interface;
  IXMLDtType = interface;
  IXMLCdtLineType = interface;
  IXMLTxsSummryType = interface;
  IXMLTtlNtriesType = interface;
  IXMLTtlCdtNtriesType = interface;
  IXMLTtlDbtNtriesType = interface;
  IXMLNtryType = interface;
  IXMLNtryTypeList = interface;
  IXMLBookgDtType = interface;
  IXMLValDtType = interface;
  IXMLBkTxCdType = interface;
  IXMLPrtryType = interface;
  IXMLNtryDtlsType = interface;
  IXMLTxDtlsType = interface;
  IXMLRefsType = interface;
  IXMLRltdPtiesType = interface;
  IXMLDbtrAcctType = interface;
  IXMLCdtrAcctType = interface;
  IXMLDbtrType = interface;
  IXMLCdtrType = interface;
  IXMLRltdAgtsType = interface;
  IXMLDbtrAgtType = interface;
  IXMLCdtrAgtType = interface;
  IXMLRmtInfType = interface;

{ IXMLDocumentType }

  IXMLDocumentType = interface(IXMLNode)
    ['{AA47AA7C-8A7F-4626-B9A4-7DB3D0AA4382}']
    { Property Accessors }
    function Get_BkToCstmrStmt: IXMLBkToCstmrStmtType;
    { Methods & Properties }
    property BkToCstmrStmt: IXMLBkToCstmrStmtType read Get_BkToCstmrStmt;
  end;

{ IXMLBkToCstmrStmtType }

  IXMLBkToCstmrStmtType = interface(IXMLNode)
    ['{B7017691-AA2A-4878-8B57-EA3B98EC8496}']
    { Property Accessors }
    function Get_GrpHdr: IXMLGrpHdrType;
    function Get_Stmt: IXMLStmtType;
    { Methods & Properties }
    property GrpHdr: IXMLGrpHdrType read Get_GrpHdr;
    property Stmt: IXMLStmtType read Get_Stmt;
  end;

{ IXMLGrpHdrType }

  IXMLGrpHdrType = interface(IXMLNode)
    ['{73A3FE2A-B351-4B99-A1B6-0CF01683AE3A}']
    { Property Accessors }
    function Get_MsgId: WideString;
    function Get_CreDtTm: WideString;
    function Get_MsgRcpt: IXMLMsgRcptType;
    procedure Set_MsgId(Value: WideString);
    procedure Set_CreDtTm(Value: WideString);
    { Methods & Properties }
    property MsgId: WideString read Get_MsgId write Set_MsgId;
    property CreDtTm: WideString read Get_CreDtTm write Set_CreDtTm;
    property MsgRcpt: IXMLMsgRcptType read Get_MsgRcpt;
  end;

{ IXMLMsgRcptType }

  IXMLMsgRcptType = interface(IXMLNode)
    ['{DC403E78-612E-4296-833F-BC7D0006575E}']
    { Property Accessors }
    function Get_Nm: WideString;
    function Get_PstlAdr: IXMLPstlAdrType;
    function Get_Id: IXMLIdType;
    procedure Set_Nm(Value: WideString);
    { Methods & Properties }
    property Nm: WideString read Get_Nm write Set_Nm;
    property PstlAdr: IXMLPstlAdrType read Get_PstlAdr;
    property Id: IXMLIdType read Get_Id;
  end;

{ IXMLPstlAdrType }

  IXMLPstlAdrType = interface(IXMLNode)
    ['{4A611386-326C-4863-A456-991C9AACAF2C}']
    { Property Accessors }
    function Get_StrtNm: WideString;
    function Get_PstCd: Integer;
    function Get_TwnNm: WideString;
    function Get_Ctry: WideString;
    function Get_BldgNb: Integer;
    function Get_AdrLine: WideString;
    procedure Set_StrtNm(Value: WideString);
    procedure Set_PstCd(Value: Integer);
    procedure Set_TwnNm(Value: WideString);
    procedure Set_Ctry(Value: WideString);
    procedure Set_BldgNb(Value: Integer);
    procedure Set_AdrLine(Value: WideString);
    { Methods & Properties }
    property StrtNm: WideString read Get_StrtNm write Set_StrtNm;
    property PstCd: Integer read Get_PstCd write Set_PstCd;
    property TwnNm: WideString read Get_TwnNm write Set_TwnNm;
    property Ctry: WideString read Get_Ctry write Set_Ctry;
    property BldgNb: Integer read Get_BldgNb write Set_BldgNb;
    property AdrLine: WideString read Get_AdrLine write Set_AdrLine;
  end;

{ IXMLIdType }

  IXMLIdType = interface(IXMLNode)
    ['{0CCABA70-CE13-4DDC-BE24-4D415EF33B77}']
    { Property Accessors }
    function Get_OrgId: IXMLOrgIdType;
    function Get_IBAN: WideString;
    procedure Set_IBAN(Value: WideString);
    { Methods & Properties }
    property OrgId: IXMLOrgIdType read Get_OrgId;
    property IBAN: WideString read Get_IBAN write Set_IBAN;
  end;

{ IXMLOrgIdType }

  IXMLOrgIdType = interface(IXMLNode)
    ['{78A5F410-3E8D-40D6-905B-CDCA44A48E12}']
    { Property Accessors }
    function Get_Othr: IXMLOthrType;
    { Methods & Properties }
    property Othr: IXMLOthrType read Get_Othr;
  end;

{ IXMLOthrType }

  IXMLOthrType = interface(IXMLNode)
    ['{FA52F838-8562-4672-8C40-C911ABD524EA}']
    { Property Accessors }
    function Get_Id: WideString;
    procedure Set_Id(Value: WideString);
    { Methods & Properties }
    property Id: WideString read Get_Id write Set_Id;
  end;

{ IXMLStmtType }

  IXMLStmtType = interface(IXMLNode)
    ['{24F1C3C3-400B-4226-A0CF-C66954047AFC}']
    { Property Accessors }
    function Get_Id: WideString;
    function Get_ElctrncSeqNb: Integer;
    function Get_LglSeqNb: Integer;
    function Get_CreDtTm: WideString;
    function Get_FrToDt: IXMLFrToDtType;
    function Get_Acct: IXMLAcctType;
    function Get_Bal: IXMLBalTypeList;
    function Get_TxsSummry: IXMLTxsSummryType;
    function Get_Ntry: IXMLNtryTypeList;
    procedure Set_Id(Value: WideString);
    procedure Set_ElctrncSeqNb(Value: Integer);
    procedure Set_LglSeqNb(Value: Integer);
    procedure Set_CreDtTm(Value: WideString);
    { Methods & Properties }
    property Id: WideString read Get_Id write Set_Id;
    property ElctrncSeqNb: Integer read Get_ElctrncSeqNb write Set_ElctrncSeqNb;
    property LglSeqNb: Integer read Get_LglSeqNb write Set_LglSeqNb;
    property CreDtTm: WideString read Get_CreDtTm write Set_CreDtTm;
    property FrToDt: IXMLFrToDtType read Get_FrToDt;
    property Acct: IXMLAcctType read Get_Acct;
    property Bal: IXMLBalTypeList read Get_Bal;
    property TxsSummry: IXMLTxsSummryType read Get_TxsSummry;
    property Ntry: IXMLNtryTypeList read Get_Ntry;
  end;

{ IXMLFrToDtType }

  IXMLFrToDtType = interface(IXMLNode)
    ['{3E9DB4AE-336B-4043-8514-8AF7C7F5BF63}']
    { Property Accessors }
    function Get_FrDtTm: WideString;
    function Get_ToDtTm: WideString;
    procedure Set_FrDtTm(Value: WideString);
    procedure Set_ToDtTm(Value: WideString);
    { Methods & Properties }
    property FrDtTm: WideString read Get_FrDtTm write Set_FrDtTm;
    property ToDtTm: WideString read Get_ToDtTm write Set_ToDtTm;
  end;

{ IXMLAcctType }

  IXMLAcctType = interface(IXMLNode)
    ['{0C41DF21-8474-4E7C-94CD-49138B30752A}']
    { Property Accessors }
    function Get_Id: IXMLIdType;
    function Get_Ccy: WideString;
    function Get_Nm: WideString;
    function Get_Ownr: IXMLOwnrType;
    function Get_Svcr: IXMLSvcrType;
    procedure Set_Ccy(Value: WideString);
    procedure Set_Nm(Value: WideString);
    { Methods & Properties }
    property Id: IXMLIdType read Get_Id;
    property Ccy: WideString read Get_Ccy write Set_Ccy;
    property Nm: WideString read Get_Nm write Set_Nm;
    property Ownr: IXMLOwnrType read Get_Ownr;
    property Svcr: IXMLSvcrType read Get_Svcr;
  end;

{ IXMLOwnrType }

  IXMLOwnrType = interface(IXMLNode)
    ['{ADE54607-54A5-47FB-885B-33FC6D1F4B0D}']
    { Property Accessors }
    function Get_Nm: WideString;
    function Get_PstlAdr: IXMLPstlAdrType;
    function Get_Id: IXMLIdType;
    procedure Set_Nm(Value: WideString);
    { Methods & Properties }
    property Nm: WideString read Get_Nm write Set_Nm;
    property PstlAdr: IXMLPstlAdrType read Get_PstlAdr;
    property Id: IXMLIdType read Get_Id;
  end;

{ IXMLSvcrType }

  IXMLSvcrType = interface(IXMLNode)
    ['{9F1E3D34-798C-4D28-B430-D1E151E34248}']
    { Property Accessors }
    function Get_FinInstnId: IXMLFinInstnIdType;
    { Methods & Properties }
    property FinInstnId: IXMLFinInstnIdType read Get_FinInstnId;
  end;

{ IXMLFinInstnIdType }

  IXMLFinInstnIdType = interface(IXMLNode)
    ['{601C594A-4283-47C2-9D7D-A155BDFC7448}']
    { Property Accessors }
    function Get_BIC: WideString;
    function Get_Nm: WideString;
    function Get_PstlAdr: IXMLPstlAdrType;
    function Get_Othr: IXMLOthrType;
    procedure Set_BIC(Value: WideString);
    procedure Set_Nm(Value: WideString);
    { Methods & Properties }
    property BIC: WideString read Get_BIC write Set_BIC;
    property Nm: WideString read Get_Nm write Set_Nm;
    property PstlAdr: IXMLPstlAdrType read Get_PstlAdr;
    property Othr: IXMLOthrType read Get_Othr;
  end;

{ IXMLBalType }

  IXMLBalType = interface(IXMLNode)
    ['{7CD1CF30-1484-448B-9030-8889930F3916}']
    { Property Accessors }
    function Get_Tp: IXMLTpType;
    function Get_Amt: IXMLAmtType;
    function Get_CdtDbtInd: WideString;
    function Get_Dt: IXMLDtType;
    function Get_CdtLine: IXMLCdtLineType;
    procedure Set_CdtDbtInd(Value: WideString);
    { Methods & Properties }
    property Tp: IXMLTpType read Get_Tp;
    property Amt: IXMLAmtType read Get_Amt;
    property CdtDbtInd: WideString read Get_CdtDbtInd write Set_CdtDbtInd;
    property Dt: IXMLDtType read Get_Dt;
    property CdtLine: IXMLCdtLineType read Get_CdtLine;
  end;

{ IXMLBalTypeList }

  IXMLBalTypeList = interface(IXMLNodeCollection)
    ['{E871B9FE-57C7-4F5B-85ED-33B965DC5A78}']
    { Methods & Properties }
    function Add: IXMLBalType;
    function Insert(const Index: Integer): IXMLBalType;
    function Get_Item(Index: Integer): IXMLBalType;
    property Items[Index: Integer]: IXMLBalType read Get_Item; default;
  end;

{ IXMLTpType }

  IXMLTpType = interface(IXMLNode)
    ['{73DFD411-3A58-4008-896B-61E1EBDF2EC5}']
    { Property Accessors }
    function Get_CdOrPrtry: IXMLCdOrPrtryType;
    { Methods & Properties }
    property CdOrPrtry: IXMLCdOrPrtryType read Get_CdOrPrtry;
  end;

{ IXMLCdOrPrtryType }

  IXMLCdOrPrtryType = interface(IXMLNode)
    ['{EC92B420-B35A-42A0-9DAD-9F16D47DD030}']
    { Property Accessors }
    function Get_Cd: WideString;
    procedure Set_Cd(Value: WideString);
    { Methods & Properties }
    property Cd: WideString read Get_Cd write Set_Cd;
  end;

{ IXMLAmtType }

  IXMLAmtType = interface(IXMLNode)
    ['{CCCC969D-A293-4D5E-9C0F-E314EDC36024}']
    { Property Accessors }
    function Get_Ccy: WideString;
    procedure Set_Ccy(Value: WideString);
    { Methods & Properties }
    property Ccy: WideString read Get_Ccy write Set_Ccy;
  end;

{ IXMLDtType }

  IXMLDtType = interface(IXMLNode)
    ['{E0F2F5BE-66C1-4594-863B-123725E3FE7B}']
    { Property Accessors }
    function Get_Dt: WideString;
    procedure Set_Dt(Value: WideString);
    { Methods & Properties }
    property Dt: WideString read Get_Dt write Set_Dt;
  end;

{ IXMLCdtLineType }

  IXMLCdtLineType = interface(IXMLNode)
    ['{CB2B380F-9C36-4AAF-8970-A006DC25C9B5}']
    { Property Accessors }
    function Get_Incl: WideString;
    function Get_Amt: IXMLAmtType;
    procedure Set_Incl(Value: WideString);
    { Methods & Properties }
    property Incl: WideString read Get_Incl write Set_Incl;
    property Amt: IXMLAmtType read Get_Amt;
  end;

{ IXMLTxsSummryType }

  IXMLTxsSummryType = interface(IXMLNode)
    ['{3D38C602-D699-4476-BAB0-B55ED93FF932}']
    { Property Accessors }
    function Get_TtlNtries: IXMLTtlNtriesType;
    function Get_TtlCdtNtries: IXMLTtlCdtNtriesType;
    function Get_TtlDbtNtries: IXMLTtlDbtNtriesType;
    { Methods & Properties }
    property TtlNtries: IXMLTtlNtriesType read Get_TtlNtries;
    property TtlCdtNtries: IXMLTtlCdtNtriesType read Get_TtlCdtNtries;
    property TtlDbtNtries: IXMLTtlDbtNtriesType read Get_TtlDbtNtries;
  end;

{ IXMLTtlNtriesType }

  IXMLTtlNtriesType = interface(IXMLNode)
    ['{A67DCD7A-EB36-4F17-9957-641EFF8BB95C}']
    { Property Accessors }
    function Get_NbOfNtries: Integer;
    function Get_Sum: WideString;
    function Get_TtlNetNtryAmt: WideString;
    function Get_CdtDbtInd: WideString;
    procedure Set_NbOfNtries(Value: Integer);
    procedure Set_Sum(Value: WideString);
    procedure Set_TtlNetNtryAmt(Value: WideString);
    procedure Set_CdtDbtInd(Value: WideString);
    { Methods & Properties }
    property NbOfNtries: Integer read Get_NbOfNtries write Set_NbOfNtries;
    property Sum: WideString read Get_Sum write Set_Sum;
    property TtlNetNtryAmt: WideString read Get_TtlNetNtryAmt write Set_TtlNetNtryAmt;
    property CdtDbtInd: WideString read Get_CdtDbtInd write Set_CdtDbtInd;
  end;

{ IXMLTtlCdtNtriesType }

  IXMLTtlCdtNtriesType = interface(IXMLNode)
    ['{7F620797-6B5F-4BFB-8008-10A43BA4B2EA}']
    { Property Accessors }
    function Get_NbOfNtries: Integer;
    function Get_Sum: WideString;
    procedure Set_NbOfNtries(Value: Integer);
    procedure Set_Sum(Value: WideString);
    { Methods & Properties }
    property NbOfNtries: Integer read Get_NbOfNtries write Set_NbOfNtries;
    property Sum: WideString read Get_Sum write Set_Sum;
  end;

{ IXMLTtlDbtNtriesType }

  IXMLTtlDbtNtriesType = interface(IXMLNode)
    ['{DB143C75-5F79-492A-BF0D-594F0E495A39}']
    { Property Accessors }
    function Get_NbOfNtries: Integer;
    function Get_Sum: WideString;
    procedure Set_NbOfNtries(Value: Integer);
    procedure Set_Sum(Value: WideString);
    { Methods & Properties }
    property NbOfNtries: Integer read Get_NbOfNtries write Set_NbOfNtries;
    property Sum: WideString read Get_Sum write Set_Sum;
  end;

{ IXMLNtryType }

  IXMLNtryType = interface(IXMLNode)
    ['{53101135-815D-4089-B23B-2BB2F04A69A4}']
    { Property Accessors }
    function Get_Amt: IXMLAmtType;
    function Get_CdtDbtInd: WideString;
    function Get_RvslInd: WideString;
    function Get_Sts: WideString;
    function Get_BookgDt: IXMLBookgDtType;
    function Get_ValDt: IXMLValDtType;
    function Get_BkTxCd: IXMLBkTxCdType;
    function Get_NtryDtls: IXMLNtryDtlsType;
    function Get_NtryRef: WideString;
    procedure Set_CdtDbtInd(Value: WideString);
    procedure Set_RvslInd(Value: WideString);
    procedure Set_Sts(Value: WideString);
    procedure Set_NtryRef(Value: WideString);
    { Methods & Properties }
    property Amt: IXMLAmtType read Get_Amt;
    property CdtDbtInd: WideString read Get_CdtDbtInd write Set_CdtDbtInd;
    property RvslInd: WideString read Get_RvslInd write Set_RvslInd;
    property Sts: WideString read Get_Sts write Set_Sts;
    property BookgDt: IXMLBookgDtType read Get_BookgDt;
    property ValDt: IXMLValDtType read Get_ValDt;
    property BkTxCd: IXMLBkTxCdType read Get_BkTxCd;
    property NtryDtls: IXMLNtryDtlsType read Get_NtryDtls;
    property NtryRef: WideString read Get_NtryRef write Set_NtryRef;
  end;

{ IXMLNtryTypeList }

  IXMLNtryTypeList = interface(IXMLNodeCollection)
    ['{AB3D45DE-932F-4952-9BC5-84715BF573D4}']
    { Methods & Properties }
    function Add: IXMLNtryType;
    function Insert(const Index: Integer): IXMLNtryType;
    function Get_Item(Index: Integer): IXMLNtryType;
    property Items[Index: Integer]: IXMLNtryType read Get_Item; default;
  end;

{ IXMLBookgDtType }

  IXMLBookgDtType = interface(IXMLNode)
    ['{8E9DCFE6-E7FB-4960-A30A-918BE6FDC502}']
    { Property Accessors }
    function Get_Dt: WideString;
    procedure Set_Dt(Value: WideString);
    { Methods & Properties }
    property Dt: WideString read Get_Dt write Set_Dt;
  end;

{ IXMLValDtType }

  IXMLValDtType = interface(IXMLNode)
    ['{15076C1C-927D-45C5-8998-C4CD58461590}']
    { Property Accessors }
    function Get_Dt: WideString;
    procedure Set_Dt(Value: WideString);
    { Methods & Properties }
    property Dt: WideString read Get_Dt write Set_Dt;
  end;

{ IXMLBkTxCdType }

  IXMLBkTxCdType = interface(IXMLNode)
    ['{8B0F37A0-4569-4BE5-BCEB-61F00C60DF2A}']
    { Property Accessors }
    function Get_Prtry: IXMLPrtryType;
    { Methods & Properties }
    property Prtry: IXMLPrtryType read Get_Prtry;
  end;

{ IXMLPrtryType }

  IXMLPrtryType = interface(IXMLNode)
    ['{CA3A838F-EF5A-49D0-80BA-55CCC3701205}']
    { Property Accessors }
    function Get_Cd: WideString;
    function Get_Issr: WideString;
    procedure Set_Cd(Value: WideString);
    procedure Set_Issr(Value: WideString);
    { Methods & Properties }
    property Cd: WideString read Get_Cd write Set_Cd;
    property Issr: WideString read Get_Issr write Set_Issr;
  end;

{ IXMLNtryDtlsType }

  IXMLNtryDtlsType = interface(IXMLNode)
    ['{76253E56-2E26-4DF4-9DB8-260306DE6914}']
    { Property Accessors }
    function Get_TxDtls: IXMLTxDtlsType;
    { Methods & Properties }
    property TxDtls: IXMLTxDtlsType read Get_TxDtls;
  end;

{ IXMLTxDtlsType }

  IXMLTxDtlsType = interface(IXMLNode)
    ['{A0E354F8-3BEF-4198-90EB-0B4126BF7F8F}']
    { Property Accessors }
    function Get_Refs: IXMLRefsType;
    function Get_BkTxCd: IXMLBkTxCdType;
    function Get_RltdPties: IXMLRltdPtiesType;
    function Get_RltdAgts: IXMLRltdAgtsType;
    function Get_RmtInf: IXMLRmtInfType;
    { Methods & Properties }
    property Refs: IXMLRefsType read Get_Refs;
    property BkTxCd: IXMLBkTxCdType read Get_BkTxCd;
    property RltdPties: IXMLRltdPtiesType read Get_RltdPties;
    property RltdAgts: IXMLRltdAgtsType read Get_RltdAgts;
    property RmtInf: IXMLRmtInfType read Get_RmtInf;
  end;

{ IXMLRefsType }

  IXMLRefsType = interface(IXMLNode)
    ['{C98A9188-FC3E-4DF2-9EC8-325CA98BC344}']
    { Property Accessors }
    function Get_AcctSvcrRef: WideString;
    function Get_EndToEndId: WideString;
    function Get_PmtInfId: WideString;
    function Get_InstrId: WideString;
    procedure Set_AcctSvcrRef(Value: WideString);
    procedure Set_EndToEndId(Value: WideString);
    procedure Set_PmtInfId(Value: WideString);
    procedure Set_InstrId(Value: WideString);
    { Methods & Properties }
    property AcctSvcrRef: WideString read Get_AcctSvcrRef write Set_AcctSvcrRef;
    property EndToEndId: WideString read Get_EndToEndId write Set_EndToEndId;
    property PmtInfId: WideString read Get_PmtInfId write Set_PmtInfId;
    property InstrId: WideString read Get_InstrId write Set_InstrId;
  end;

{ IXMLRltdPtiesType }

  IXMLRltdPtiesType = interface(IXMLNode)
    ['{43B04C45-8331-4D33-AE4C-DA634EEA0622}']
    { Property Accessors }
    function Get_DbtrAcct: IXMLDbtrAcctType;
    function Get_CdtrAcct: IXMLCdtrAcctType;
    function Get_Dbtr: IXMLDbtrType;
    function Get_Cdtr: IXMLCdtrType;
    { Methods & Properties }
    property DbtrAcct: IXMLDbtrAcctType read Get_DbtrAcct;
    property CdtrAcct: IXMLCdtrAcctType read Get_CdtrAcct;
    property Dbtr: IXMLDbtrType read Get_Dbtr;
    property Cdtr: IXMLCdtrType read Get_Cdtr;
  end;

{ IXMLDbtrAcctType }

  IXMLDbtrAcctType = interface(IXMLNode)
    ['{B5F36510-D5E2-4540-93AB-6EE0DCEE2675}']
    { Property Accessors }
    function Get_Id: IXMLIdType;
    function Get_Nm: WideString;
    procedure Set_Nm(Value: WideString);
    { Methods & Properties }
    property Id: IXMLIdType read Get_Id;
    property Nm: WideString read Get_Nm write Set_Nm;
  end;

{ IXMLCdtrAcctType }

  IXMLCdtrAcctType = interface(IXMLNode)
    ['{4C952E9A-EA89-4B24-B43D-76082FD3BB2B}']
    { Property Accessors }
    function Get_Id: IXMLIdType;
    function Get_Nm: WideString;
    procedure Set_Nm(Value: WideString);
    { Methods & Properties }
    property Id: IXMLIdType read Get_Id;
    property Nm: WideString read Get_Nm write Set_Nm;
  end;

{ IXMLDbtrType }

  IXMLDbtrType = interface(IXMLNode)
    ['{0BC5FA7C-07EC-44D5-88AC-A3E40DC2BFF3}']
    { Property Accessors }
    function Get_PstlAdr: IXMLPstlAdrType;
    { Methods & Properties }
    property PstlAdr: IXMLPstlAdrType read Get_PstlAdr;
  end;

{ IXMLCdtrType }

  IXMLCdtrType = interface(IXMLNode)
    ['{CC8932E8-4A7E-4815-9C32-5F84C49387DE}']
    { Property Accessors }
    function Get_PstlAdr: IXMLPstlAdrType;
    { Methods & Properties }
    property PstlAdr: IXMLPstlAdrType read Get_PstlAdr;
  end;

{ IXMLRltdAgtsType }

  IXMLRltdAgtsType = interface(IXMLNode)
    ['{52A5F18F-811B-4512-A59F-B98EA1B63776}']
    { Property Accessors }
    function Get_DbtrAgt: IXMLDbtrAgtType;
    function Get_CdtrAgt: IXMLCdtrAgtType;
    { Methods & Properties }
    property DbtrAgt: IXMLDbtrAgtType read Get_DbtrAgt;
    property CdtrAgt: IXMLCdtrAgtType read Get_CdtrAgt;
  end;

{ IXMLDbtrAgtType }

  IXMLDbtrAgtType = interface(IXMLNode)
    ['{851AD2FE-D261-4CDE-BC34-991CE7EA223C}']
    { Property Accessors }
    function Get_FinInstnId: IXMLFinInstnIdType;
    { Methods & Properties }
    property FinInstnId: IXMLFinInstnIdType read Get_FinInstnId;
  end;

{ IXMLCdtrAgtType }

  IXMLCdtrAgtType = interface(IXMLNode)
    ['{6C069C24-1D6A-43DC-AAE7-183E244255AB}']
    { Property Accessors }
    function Get_FinInstnId: IXMLFinInstnIdType;
    { Methods & Properties }
    property FinInstnId: IXMLFinInstnIdType read Get_FinInstnId;
  end;

{ IXMLRmtInfType }

  IXMLRmtInfType = interface(IXMLNode)
    ['{8AC55EE9-DED4-4CA0-A616-B94F9D3BF72C}']
    { Property Accessors }
    function Get_Ustrd: WideString;
    procedure Set_Ustrd(Value: WideString);
    { Methods & Properties }
    property Ustrd: WideString read Get_Ustrd write Set_Ustrd;
  end;

{ Forward Decls }

  TXMLDocumentType = class;
  TXMLBkToCstmrStmtType = class;
  TXMLGrpHdrType = class;
  TXMLMsgRcptType = class;
  TXMLPstlAdrType = class;
  TXMLIdType = class;
  TXMLOrgIdType = class;
  TXMLOthrType = class;
  TXMLStmtType = class;
  TXMLFrToDtType = class;
  TXMLAcctType = class;
  TXMLOwnrType = class;
  TXMLSvcrType = class;
  TXMLFinInstnIdType = class;
  TXMLBalType = class;
  TXMLBalTypeList = class;
  TXMLTpType = class;
  TXMLCdOrPrtryType = class;
  TXMLAmtType = class;
  TXMLDtType = class;
  TXMLCdtLineType = class;
  TXMLTxsSummryType = class;
  TXMLTtlNtriesType = class;
  TXMLTtlCdtNtriesType = class;
  TXMLTtlDbtNtriesType = class;
  TXMLNtryType = class;
  TXMLNtryTypeList = class;
  TXMLBookgDtType = class;
  TXMLValDtType = class;
  TXMLBkTxCdType = class;
  TXMLPrtryType = class;
  TXMLNtryDtlsType = class;
  TXMLTxDtlsType = class;
  TXMLRefsType = class;
  TXMLRltdPtiesType = class;
  TXMLDbtrAcctType = class;
  TXMLCdtrAcctType = class;
  TXMLDbtrType = class;
  TXMLCdtrType = class;
  TXMLRltdAgtsType = class;
  TXMLDbtrAgtType = class;
  TXMLCdtrAgtType = class;
  TXMLRmtInfType = class;

{ TXMLDocumentType }

  TXMLDocumentType = class(TXMLNode, IXMLDocumentType)
  protected
    { IXMLDocumentType }
    function Get_BkToCstmrStmt: IXMLBkToCstmrStmtType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLBkToCstmrStmtType }

  TXMLBkToCstmrStmtType = class(TXMLNode, IXMLBkToCstmrStmtType)
  protected
    { IXMLBkToCstmrStmtType }
    function Get_GrpHdr: IXMLGrpHdrType;
    function Get_Stmt: IXMLStmtType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLGrpHdrType }

  TXMLGrpHdrType = class(TXMLNode, IXMLGrpHdrType)
  protected
    { IXMLGrpHdrType }
    function Get_MsgId: WideString;
    function Get_CreDtTm: WideString;
    function Get_MsgRcpt: IXMLMsgRcptType;
    procedure Set_MsgId(Value: WideString);
    procedure Set_CreDtTm(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLMsgRcptType }

  TXMLMsgRcptType = class(TXMLNode, IXMLMsgRcptType)
  protected
    { IXMLMsgRcptType }
    function Get_Nm: WideString;
    function Get_PstlAdr: IXMLPstlAdrType;
    function Get_Id: IXMLIdType;
    procedure Set_Nm(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLPstlAdrType }

  TXMLPstlAdrType = class(TXMLNode, IXMLPstlAdrType)
  protected
    { IXMLPstlAdrType }
    function Get_StrtNm: WideString;
    function Get_PstCd: Integer;
    function Get_TwnNm: WideString;
    function Get_Ctry: WideString;
    function Get_BldgNb: Integer;
    function Get_AdrLine: WideString;
    procedure Set_StrtNm(Value: WideString);
    procedure Set_PstCd(Value: Integer);
    procedure Set_TwnNm(Value: WideString);
    procedure Set_Ctry(Value: WideString);
    procedure Set_BldgNb(Value: Integer);
    procedure Set_AdrLine(Value: WideString);
  end;

{ TXMLIdType }

  TXMLIdType = class(TXMLNode, IXMLIdType)
  protected
    { IXMLIdType }
    function Get_OrgId: IXMLOrgIdType;
    function Get_IBAN: WideString;
    procedure Set_IBAN(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLOrgIdType }

  TXMLOrgIdType = class(TXMLNode, IXMLOrgIdType)
  protected
    { IXMLOrgIdType }
    function Get_Othr: IXMLOthrType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLOthrType }

  TXMLOthrType = class(TXMLNode, IXMLOthrType)
  protected
    { IXMLOthrType }
    function Get_Id: WideString;
    procedure Set_Id(Value: WideString);
  end;

{ TXMLStmtType }

  TXMLStmtType = class(TXMLNode, IXMLStmtType)
  private
    FBal: IXMLBalTypeList;
    FNtry: IXMLNtryTypeList;
  protected
    { IXMLStmtType }
    function Get_Id: WideString;
    function Get_ElctrncSeqNb: Integer;
    function Get_LglSeqNb: Integer;
    function Get_CreDtTm: WideString;
    function Get_FrToDt: IXMLFrToDtType;
    function Get_Acct: IXMLAcctType;
    function Get_Bal: IXMLBalTypeList;
    function Get_TxsSummry: IXMLTxsSummryType;
    function Get_Ntry: IXMLNtryTypeList;
    procedure Set_Id(Value: WideString);
    procedure Set_ElctrncSeqNb(Value: Integer);
    procedure Set_LglSeqNb(Value: Integer);
    procedure Set_CreDtTm(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLFrToDtType }

  TXMLFrToDtType = class(TXMLNode, IXMLFrToDtType)
  protected
    { IXMLFrToDtType }
    function Get_FrDtTm: WideString;
    function Get_ToDtTm: WideString;
    procedure Set_FrDtTm(Value: WideString);
    procedure Set_ToDtTm(Value: WideString);
  end;

{ TXMLAcctType }

  TXMLAcctType = class(TXMLNode, IXMLAcctType)
  protected
    { IXMLAcctType }
    function Get_Id: IXMLIdType;
    function Get_Ccy: WideString;
    function Get_Nm: WideString;
    function Get_Ownr: IXMLOwnrType;
    function Get_Svcr: IXMLSvcrType;
    procedure Set_Ccy(Value: WideString);
    procedure Set_Nm(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLOwnrType }

  TXMLOwnrType = class(TXMLNode, IXMLOwnrType)
  protected
    { IXMLOwnrType }
    function Get_Nm: WideString;
    function Get_PstlAdr: IXMLPstlAdrType;
    function Get_Id: IXMLIdType;
    procedure Set_Nm(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLSvcrType }

  TXMLSvcrType = class(TXMLNode, IXMLSvcrType)
  protected
    { IXMLSvcrType }
    function Get_FinInstnId: IXMLFinInstnIdType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLFinInstnIdType }

  TXMLFinInstnIdType = class(TXMLNode, IXMLFinInstnIdType)
  protected
    { IXMLFinInstnIdType }
    function Get_BIC: WideString;
    function Get_Nm: WideString;
    function Get_PstlAdr: IXMLPstlAdrType;
    function Get_Othr: IXMLOthrType;
    procedure Set_BIC(Value: WideString);
    procedure Set_Nm(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLBalType }

  TXMLBalType = class(TXMLNode, IXMLBalType)
  protected
    { IXMLBalType }
    function Get_Tp: IXMLTpType;
    function Get_Amt: IXMLAmtType;
    function Get_CdtDbtInd: WideString;
    function Get_Dt: IXMLDtType;
    function Get_CdtLine: IXMLCdtLineType;
    procedure Set_CdtDbtInd(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLBalTypeList }

  TXMLBalTypeList = class(TXMLNodeCollection, IXMLBalTypeList)
  protected
    { IXMLBalTypeList }
    function Add: IXMLBalType;
    function Insert(const Index: Integer): IXMLBalType;
    function Get_Item(Index: Integer): IXMLBalType;
  end;

{ TXMLTpType }

  TXMLTpType = class(TXMLNode, IXMLTpType)
  protected
    { IXMLTpType }
    function Get_CdOrPrtry: IXMLCdOrPrtryType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLCdOrPrtryType }

  TXMLCdOrPrtryType = class(TXMLNode, IXMLCdOrPrtryType)
  protected
    { IXMLCdOrPrtryType }
    function Get_Cd: WideString;
    procedure Set_Cd(Value: WideString);
  end;

{ TXMLAmtType }

  TXMLAmtType = class(TXMLNode, IXMLAmtType)
  protected
    { IXMLAmtType }
    function Get_Ccy: WideString;
    procedure Set_Ccy(Value: WideString);
  end;

{ TXMLDtType }

  TXMLDtType = class(TXMLNode, IXMLDtType)
  protected
    { IXMLDtType }
    function Get_Dt: WideString;
    procedure Set_Dt(Value: WideString);
  end;

{ TXMLCdtLineType }

  TXMLCdtLineType = class(TXMLNode, IXMLCdtLineType)
  protected
    { IXMLCdtLineType }
    function Get_Incl: WideString;
    function Get_Amt: IXMLAmtType;
    procedure Set_Incl(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLTxsSummryType }

  TXMLTxsSummryType = class(TXMLNode, IXMLTxsSummryType)
  protected
    { IXMLTxsSummryType }
    function Get_TtlNtries: IXMLTtlNtriesType;
    function Get_TtlCdtNtries: IXMLTtlCdtNtriesType;
    function Get_TtlDbtNtries: IXMLTtlDbtNtriesType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLTtlNtriesType }

  TXMLTtlNtriesType = class(TXMLNode, IXMLTtlNtriesType)
  protected
    { IXMLTtlNtriesType }
    function Get_NbOfNtries: Integer;
    function Get_Sum: WideString;
    function Get_TtlNetNtryAmt: WideString;
    function Get_CdtDbtInd: WideString;
    procedure Set_NbOfNtries(Value: Integer);
    procedure Set_Sum(Value: WideString);
    procedure Set_TtlNetNtryAmt(Value: WideString);
    procedure Set_CdtDbtInd(Value: WideString);
  end;

{ TXMLTtlCdtNtriesType }

  TXMLTtlCdtNtriesType = class(TXMLNode, IXMLTtlCdtNtriesType)
  protected
    { IXMLTtlCdtNtriesType }
    function Get_NbOfNtries: Integer;
    function Get_Sum: WideString;
    procedure Set_NbOfNtries(Value: Integer);
    procedure Set_Sum(Value: WideString);
  end;

{ TXMLTtlDbtNtriesType }

  TXMLTtlDbtNtriesType = class(TXMLNode, IXMLTtlDbtNtriesType)
  protected
    { IXMLTtlDbtNtriesType }
    function Get_NbOfNtries: Integer;
    function Get_Sum: WideString;
    procedure Set_NbOfNtries(Value: Integer);
    procedure Set_Sum(Value: WideString);
  end;

{ TXMLNtryType }

  TXMLNtryType = class(TXMLNode, IXMLNtryType)
  protected
    { IXMLNtryType }
    function Get_Amt: IXMLAmtType;
    function Get_CdtDbtInd: WideString;
    function Get_RvslInd: WideString;
    function Get_Sts: WideString;
    function Get_BookgDt: IXMLBookgDtType;
    function Get_ValDt: IXMLValDtType;
    function Get_BkTxCd: IXMLBkTxCdType;
    function Get_NtryDtls: IXMLNtryDtlsType;
    function Get_NtryRef: WideString;
    procedure Set_CdtDbtInd(Value: WideString);
    procedure Set_RvslInd(Value: WideString);
    procedure Set_Sts(Value: WideString);
    procedure Set_NtryRef(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLNtryTypeList }

  TXMLNtryTypeList = class(TXMLNodeCollection, IXMLNtryTypeList)
  protected
    { IXMLNtryTypeList }
    function Add: IXMLNtryType;
    function Insert(const Index: Integer): IXMLNtryType;
    function Get_Item(Index: Integer): IXMLNtryType;
  end;

{ TXMLBookgDtType }

  TXMLBookgDtType = class(TXMLNode, IXMLBookgDtType)
  protected
    { IXMLBookgDtType }
    function Get_Dt: WideString;
    procedure Set_Dt(Value: WideString);
  end;

{ TXMLValDtType }

  TXMLValDtType = class(TXMLNode, IXMLValDtType)
  protected
    { IXMLValDtType }
    function Get_Dt: WideString;
    procedure Set_Dt(Value: WideString);
  end;

{ TXMLBkTxCdType }

  TXMLBkTxCdType = class(TXMLNode, IXMLBkTxCdType)
  protected
    { IXMLBkTxCdType }
    function Get_Prtry: IXMLPrtryType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLPrtryType }

  TXMLPrtryType = class(TXMLNode, IXMLPrtryType)
  protected
    { IXMLPrtryType }
    function Get_Cd: WideString;
    function Get_Issr: WideString;
    procedure Set_Cd(Value: WideString);
    procedure Set_Issr(Value: WideString);
  end;

{ TXMLNtryDtlsType }

  TXMLNtryDtlsType = class(TXMLNode, IXMLNtryDtlsType)
  protected
    { IXMLNtryDtlsType }
    function Get_TxDtls: IXMLTxDtlsType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLTxDtlsType }

  TXMLTxDtlsType = class(TXMLNode, IXMLTxDtlsType)
  protected
    { IXMLTxDtlsType }
    function Get_Refs: IXMLRefsType;
    function Get_BkTxCd: IXMLBkTxCdType;
    function Get_RltdPties: IXMLRltdPtiesType;
    function Get_RltdAgts: IXMLRltdAgtsType;
    function Get_RmtInf: IXMLRmtInfType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLRefsType }

  TXMLRefsType = class(TXMLNode, IXMLRefsType)
  protected
    { IXMLRefsType }
    function Get_AcctSvcrRef: WideString;
    function Get_EndToEndId: WideString;
    function Get_PmtInfId: WideString;
    function Get_InstrId: WideString;
    procedure Set_AcctSvcrRef(Value: WideString);
    procedure Set_EndToEndId(Value: WideString);
    procedure Set_PmtInfId(Value: WideString);
    procedure Set_InstrId(Value: WideString);
  end;

{ TXMLRltdPtiesType }

  TXMLRltdPtiesType = class(TXMLNode, IXMLRltdPtiesType)
  protected
    { IXMLRltdPtiesType }
    function Get_DbtrAcct: IXMLDbtrAcctType;
    function Get_CdtrAcct: IXMLCdtrAcctType;
    function Get_Dbtr: IXMLDbtrType;
    function Get_Cdtr: IXMLCdtrType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLDbtrAcctType }

  TXMLDbtrAcctType = class(TXMLNode, IXMLDbtrAcctType)
  protected
    { IXMLDbtrAcctType }
    function Get_Id: IXMLIdType;
    function Get_Nm: WideString;
    procedure Set_Nm(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLCdtrAcctType }

  TXMLCdtrAcctType = class(TXMLNode, IXMLCdtrAcctType)
  protected
    { IXMLCdtrAcctType }
    function Get_Id: IXMLIdType;
    function Get_Nm: WideString;
    procedure Set_Nm(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLDbtrType }

  TXMLDbtrType = class(TXMLNode, IXMLDbtrType)
  protected
    { IXMLDbtrType }
    function Get_PstlAdr: IXMLPstlAdrType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLCdtrType }

  TXMLCdtrType = class(TXMLNode, IXMLCdtrType)
  protected
    { IXMLCdtrType }
    function Get_PstlAdr: IXMLPstlAdrType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLRltdAgtsType }

  TXMLRltdAgtsType = class(TXMLNode, IXMLRltdAgtsType)
  protected
    { IXMLRltdAgtsType }
    function Get_DbtrAgt: IXMLDbtrAgtType;
    function Get_CdtrAgt: IXMLCdtrAgtType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLDbtrAgtType }

  TXMLDbtrAgtType = class(TXMLNode, IXMLDbtrAgtType)
  protected
    { IXMLDbtrAgtType }
    function Get_FinInstnId: IXMLFinInstnIdType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLCdtrAgtType }

  TXMLCdtrAgtType = class(TXMLNode, IXMLCdtrAgtType)
  protected
    { IXMLCdtrAgtType }
    function Get_FinInstnId: IXMLFinInstnIdType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLRmtInfType }

  TXMLRmtInfType = class(TXMLNode, IXMLRmtInfType)
  protected
    { IXMLRmtInfType }
    function Get_Ustrd: WideString;
    procedure Set_Ustrd(Value: WideString);
  end;

{ Global Functions }

function GetDocument(Doc: IXMLDocument): IXMLDocumentType;
function LoadDocument(const FileName: WideString): IXMLDocumentType;
function NewDocument: IXMLDocumentType;

implementation

{ Global Functions }

function GetDocument(Doc: IXMLDocument): IXMLDocumentType;
begin
  Result := Doc.GetDocBinding('Document', TXMLDocumentType) as IXMLDocumentType;
end;
function LoadDocument(const FileName: WideString): IXMLDocumentType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('Document', TXMLDocumentType) as IXMLDocumentType;
end;

function NewDocument: IXMLDocumentType;
begin
  Result := NewXMLDocument.GetDocBinding('Document', TXMLDocumentType) as IXMLDocumentType;
end;

{ TXMLDocumentType }

procedure TXMLDocumentType.AfterConstruction;
begin
  RegisterChildNode('BkToCstmrStmt', TXMLBkToCstmrStmtType);
  inherited;
end;

function TXMLDocumentType.Get_BkToCstmrStmt: IXMLBkToCstmrStmtType;
begin
  Result := ChildNodes['BkToCstmrStmt'] as IXMLBkToCstmrStmtType;
end;

{ TXMLBkToCstmrStmtType }

procedure TXMLBkToCstmrStmtType.AfterConstruction;
begin
  RegisterChildNode('GrpHdr', TXMLGrpHdrType);
  RegisterChildNode('Stmt', TXMLStmtType);
  inherited;
end;

function TXMLBkToCstmrStmtType.Get_GrpHdr: IXMLGrpHdrType;
begin
  Result := ChildNodes['GrpHdr'] as IXMLGrpHdrType;
end;

function TXMLBkToCstmrStmtType.Get_Stmt: IXMLStmtType;
begin
  Result := ChildNodes['Stmt'] as IXMLStmtType;
end;

{ TXMLGrpHdrType }

procedure TXMLGrpHdrType.AfterConstruction;
begin
  RegisterChildNode('MsgRcpt', TXMLMsgRcptType);
  inherited;
end;

function TXMLGrpHdrType.Get_MsgId: WideString;
begin
  Result := ChildNodes['MsgId'].Text;
end;

procedure TXMLGrpHdrType.Set_MsgId(Value: WideString);
begin
  ChildNodes['MsgId'].NodeValue := Value;
end;

function TXMLGrpHdrType.Get_CreDtTm: WideString;
begin
  Result := ChildNodes['CreDtTm'].Text;
end;

procedure TXMLGrpHdrType.Set_CreDtTm(Value: WideString);
begin
  ChildNodes['CreDtTm'].NodeValue := Value;
end;

function TXMLGrpHdrType.Get_MsgRcpt: IXMLMsgRcptType;
begin
  Result := ChildNodes['MsgRcpt'] as IXMLMsgRcptType;
end;

{ TXMLMsgRcptType }

procedure TXMLMsgRcptType.AfterConstruction;
begin
  RegisterChildNode('PstlAdr', TXMLPstlAdrType);
  RegisterChildNode('Id', TXMLIdType);
  inherited;
end;

function TXMLMsgRcptType.Get_Nm: WideString;
begin
  Result := ChildNodes['Nm'].Text;
end;

procedure TXMLMsgRcptType.Set_Nm(Value: WideString);
begin
  ChildNodes['Nm'].NodeValue := Value;
end;

function TXMLMsgRcptType.Get_PstlAdr: IXMLPstlAdrType;
begin
  Result := ChildNodes['PstlAdr'] as IXMLPstlAdrType;
end;

function TXMLMsgRcptType.Get_Id: IXMLIdType;
begin
  Result := ChildNodes['Id'] as IXMLIdType;
end;

{ TXMLPstlAdrType }

function TXMLPstlAdrType.Get_StrtNm: WideString;
begin
  Result := ChildNodes['StrtNm'].Text;
end;

procedure TXMLPstlAdrType.Set_StrtNm(Value: WideString);
begin
  ChildNodes['StrtNm'].NodeValue := Value;
end;

function TXMLPstlAdrType.Get_PstCd: Integer;
begin
  Result := ChildNodes['PstCd'].NodeValue;
end;

procedure TXMLPstlAdrType.Set_PstCd(Value: Integer);
begin
  ChildNodes['PstCd'].NodeValue := Value;
end;

function TXMLPstlAdrType.Get_TwnNm: WideString;
begin
  Result := ChildNodes['TwnNm'].Text;
end;

procedure TXMLPstlAdrType.Set_TwnNm(Value: WideString);
begin
  ChildNodes['TwnNm'].NodeValue := Value;
end;

function TXMLPstlAdrType.Get_Ctry: WideString;
begin
  Result := ChildNodes['Ctry'].Text;
end;

procedure TXMLPstlAdrType.Set_Ctry(Value: WideString);
begin
  ChildNodes['Ctry'].NodeValue := Value;
end;

function TXMLPstlAdrType.Get_BldgNb: Integer;
begin
  Result := ChildNodes['BldgNb'].NodeValue;
end;

procedure TXMLPstlAdrType.Set_BldgNb(Value: Integer);
begin
  ChildNodes['BldgNb'].NodeValue := Value;
end;

function TXMLPstlAdrType.Get_AdrLine: WideString;
begin
  Result := ChildNodes['AdrLine'].Text;
end;

procedure TXMLPstlAdrType.Set_AdrLine(Value: WideString);
begin
  ChildNodes['AdrLine'].NodeValue := Value;
end;

{ TXMLIdType }

procedure TXMLIdType.AfterConstruction;
begin
  RegisterChildNode('OrgId', TXMLOrgIdType);
  inherited;
end;

function TXMLIdType.Get_OrgId: IXMLOrgIdType;
begin
  Result := ChildNodes['OrgId'] as IXMLOrgIdType;
end;

function TXMLIdType.Get_IBAN: WideString;
begin
  Result := ChildNodes['IBAN'].Text;
end;

procedure TXMLIdType.Set_IBAN(Value: WideString);
begin
  ChildNodes['IBAN'].NodeValue := Value;
end;

{ TXMLOrgIdType }

procedure TXMLOrgIdType.AfterConstruction;
begin
  RegisterChildNode('Othr', TXMLOthrType);
  inherited;
end;

function TXMLOrgIdType.Get_Othr: IXMLOthrType;
begin
  Result := ChildNodes['Othr'] as IXMLOthrType;
end;

{ TXMLOthrType }

function TXMLOthrType.Get_Id: WideString;
begin
  Result := ChildNodes['Id'].Text;
end;

procedure TXMLOthrType.Set_Id(Value: WideString);
begin
  ChildNodes['Id'].NodeValue := Value;
end;

{ TXMLStmtType }

procedure TXMLStmtType.AfterConstruction;
begin
  RegisterChildNode('FrToDt', TXMLFrToDtType);
  RegisterChildNode('Acct', TXMLAcctType);
  RegisterChildNode('Bal', TXMLBalType);
  RegisterChildNode('TxsSummry', TXMLTxsSummryType);
  RegisterChildNode('Ntry', TXMLNtryType);
  FBal := CreateCollection(TXMLBalTypeList, IXMLBalType, 'Bal') as IXMLBalTypeList;
  FNtry := CreateCollection(TXMLNtryTypeList, IXMLNtryType, 'Ntry') as IXMLNtryTypeList;
  inherited;
end;

function TXMLStmtType.Get_Id: WideString;
begin
  Result := ChildNodes['Id'].Text;
end;

procedure TXMLStmtType.Set_Id(Value: WideString);
begin
  ChildNodes['Id'].NodeValue := Value;
end;

function TXMLStmtType.Get_ElctrncSeqNb: Integer;
begin
  Result := ChildNodes['ElctrncSeqNb'].NodeValue;
end;

procedure TXMLStmtType.Set_ElctrncSeqNb(Value: Integer);
begin
  ChildNodes['ElctrncSeqNb'].NodeValue := Value;
end;

function TXMLStmtType.Get_LglSeqNb: Integer;
begin
  Result := ChildNodes['LglSeqNb'].NodeValue;
end;

procedure TXMLStmtType.Set_LglSeqNb(Value: Integer);
begin
  ChildNodes['LglSeqNb'].NodeValue := Value;
end;

function TXMLStmtType.Get_CreDtTm: WideString;
begin
  Result := ChildNodes['CreDtTm'].Text;
end;

procedure TXMLStmtType.Set_CreDtTm(Value: WideString);
begin
  ChildNodes['CreDtTm'].NodeValue := Value;
end;

function TXMLStmtType.Get_FrToDt: IXMLFrToDtType;
begin
  Result := ChildNodes['FrToDt'] as IXMLFrToDtType;
end;

function TXMLStmtType.Get_Acct: IXMLAcctType;
begin
  Result := ChildNodes['Acct'] as IXMLAcctType;
end;

function TXMLStmtType.Get_Bal: IXMLBalTypeList;
begin
  Result := FBal;
end;

function TXMLStmtType.Get_TxsSummry: IXMLTxsSummryType;
begin
  Result := ChildNodes['TxsSummry'] as IXMLTxsSummryType;
end;

function TXMLStmtType.Get_Ntry: IXMLNtryTypeList;
begin
  Result := FNtry;
end;

{ TXMLFrToDtType }

function TXMLFrToDtType.Get_FrDtTm: WideString;
begin
  Result := ChildNodes['FrDtTm'].Text;
end;

procedure TXMLFrToDtType.Set_FrDtTm(Value: WideString);
begin
  ChildNodes['FrDtTm'].NodeValue := Value;
end;

function TXMLFrToDtType.Get_ToDtTm: WideString;
begin
  Result := ChildNodes['ToDtTm'].Text;
end;

procedure TXMLFrToDtType.Set_ToDtTm(Value: WideString);
begin
  ChildNodes['ToDtTm'].NodeValue := Value;
end;

{ TXMLAcctType }

procedure TXMLAcctType.AfterConstruction;
begin
  RegisterChildNode('Id', TXMLIdType);
  RegisterChildNode('Ownr', TXMLOwnrType);
  RegisterChildNode('Svcr', TXMLSvcrType);
  inherited;
end;

function TXMLAcctType.Get_Id: IXMLIdType;
begin
  Result := ChildNodes['Id'] as IXMLIdType;
end;

function TXMLAcctType.Get_Ccy: WideString;
begin
  Result := ChildNodes['Ccy'].Text;
end;

procedure TXMLAcctType.Set_Ccy(Value: WideString);
begin
  ChildNodes['Ccy'].NodeValue := Value;
end;

function TXMLAcctType.Get_Nm: WideString;
begin
  Result := ChildNodes['Nm'].Text;
end;

procedure TXMLAcctType.Set_Nm(Value: WideString);
begin
  ChildNodes['Nm'].NodeValue := Value;
end;

function TXMLAcctType.Get_Ownr: IXMLOwnrType;
begin
  Result := ChildNodes['Ownr'] as IXMLOwnrType;
end;

function TXMLAcctType.Get_Svcr: IXMLSvcrType;
begin
  Result := ChildNodes['Svcr'] as IXMLSvcrType;
end;

{ TXMLOwnrType }

procedure TXMLOwnrType.AfterConstruction;
begin
  RegisterChildNode('PstlAdr', TXMLPstlAdrType);
  RegisterChildNode('Id', TXMLIdType);
  inherited;
end;

function TXMLOwnrType.Get_Nm: WideString;
begin
  Result := ChildNodes['Nm'].Text;
end;

procedure TXMLOwnrType.Set_Nm(Value: WideString);
begin
  ChildNodes['Nm'].NodeValue := Value;
end;

function TXMLOwnrType.Get_PstlAdr: IXMLPstlAdrType;
begin
  Result := ChildNodes['PstlAdr'] as IXMLPstlAdrType;
end;

function TXMLOwnrType.Get_Id: IXMLIdType;
begin
  Result := ChildNodes['Id'] as IXMLIdType;
end;

{ TXMLSvcrType }

procedure TXMLSvcrType.AfterConstruction;
begin
  RegisterChildNode('FinInstnId', TXMLFinInstnIdType);
  inherited;
end;

function TXMLSvcrType.Get_FinInstnId: IXMLFinInstnIdType;
begin
  Result := ChildNodes['FinInstnId'] as IXMLFinInstnIdType;
end;

{ TXMLFinInstnIdType }

procedure TXMLFinInstnIdType.AfterConstruction;
begin
  RegisterChildNode('PstlAdr', TXMLPstlAdrType);
  RegisterChildNode('Othr', TXMLOthrType);
  inherited;
end;

function TXMLFinInstnIdType.Get_BIC: WideString;
begin
  Result := ChildNodes['BIC'].Text;
end;

procedure TXMLFinInstnIdType.Set_BIC(Value: WideString);
begin
  ChildNodes['BIC'].NodeValue := Value;
end;

function TXMLFinInstnIdType.Get_Nm: WideString;
begin
  Result := ChildNodes['Nm'].Text;
end;

procedure TXMLFinInstnIdType.Set_Nm(Value: WideString);
begin
  ChildNodes['Nm'].NodeValue := Value;
end;

function TXMLFinInstnIdType.Get_PstlAdr: IXMLPstlAdrType;
begin
  Result := ChildNodes['PstlAdr'] as IXMLPstlAdrType;
end;

function TXMLFinInstnIdType.Get_Othr: IXMLOthrType;
begin
  Result := ChildNodes['Othr'] as IXMLOthrType;
end;

{ TXMLBalType }

procedure TXMLBalType.AfterConstruction;
begin
  RegisterChildNode('Tp', TXMLTpType);
  RegisterChildNode('Amt', TXMLAmtType);
  RegisterChildNode('Dt', TXMLDtType);
  RegisterChildNode('CdtLine', TXMLCdtLineType);
  inherited;
end;

function TXMLBalType.Get_Tp: IXMLTpType;
begin
  Result := ChildNodes['Tp'] as IXMLTpType;
end;

function TXMLBalType.Get_Amt: IXMLAmtType;
begin
  Result := ChildNodes['Amt'] as IXMLAmtType;
end;

function TXMLBalType.Get_CdtDbtInd: WideString;
begin
  Result := ChildNodes['CdtDbtInd'].Text;
end;

procedure TXMLBalType.Set_CdtDbtInd(Value: WideString);
begin
  ChildNodes['CdtDbtInd'].NodeValue := Value;
end;

function TXMLBalType.Get_Dt: IXMLDtType;
begin
  Result := ChildNodes['Dt'] as IXMLDtType;
end;

function TXMLBalType.Get_CdtLine: IXMLCdtLineType;
begin
  Result := ChildNodes['CdtLine'] as IXMLCdtLineType;
end;

{ TXMLBalTypeList }

function TXMLBalTypeList.Add: IXMLBalType;
begin
  Result := AddItem(-1) as IXMLBalType;
end;

function TXMLBalTypeList.Insert(const Index: Integer): IXMLBalType;
begin
  Result := AddItem(Index) as IXMLBalType;
end;

function TXMLBalTypeList.Get_Item(Index: Integer): IXMLBalType;
begin
  Result := List[Index] as IXMLBalType;
end;

{ TXMLTpType }

procedure TXMLTpType.AfterConstruction;
begin
  RegisterChildNode('CdOrPrtry', TXMLCdOrPrtryType);
  inherited;
end;

function TXMLTpType.Get_CdOrPrtry: IXMLCdOrPrtryType;
begin
  Result := ChildNodes['CdOrPrtry'] as IXMLCdOrPrtryType;
end;

{ TXMLCdOrPrtryType }

function TXMLCdOrPrtryType.Get_Cd: WideString;
begin
  Result := ChildNodes['Cd'].Text;
end;

procedure TXMLCdOrPrtryType.Set_Cd(Value: WideString);
begin
  ChildNodes['Cd'].NodeValue := Value;
end;

{ TXMLAmtType }

function TXMLAmtType.Get_Ccy: WideString;
begin
  Result := AttributeNodes['Ccy'].Text;
end;

procedure TXMLAmtType.Set_Ccy(Value: WideString);
begin
  SetAttribute('Ccy', Value);
end;

{ TXMLDtType }

function TXMLDtType.Get_Dt: WideString;
begin
  Result := ChildNodes['Dt'].Text;
end;

procedure TXMLDtType.Set_Dt(Value: WideString);
begin
  ChildNodes['Dt'].NodeValue := Value;
end;

{ TXMLCdtLineType }

procedure TXMLCdtLineType.AfterConstruction;
begin
  RegisterChildNode('Amt', TXMLAmtType);
  inherited;
end;

function TXMLCdtLineType.Get_Incl: WideString;
begin
  Result := ChildNodes['Incl'].Text;
end;

procedure TXMLCdtLineType.Set_Incl(Value: WideString);
begin
  ChildNodes['Incl'].NodeValue := Value;
end;

function TXMLCdtLineType.Get_Amt: IXMLAmtType;
begin
  Result := ChildNodes['Amt'] as IXMLAmtType;
end;

{ TXMLTxsSummryType }

procedure TXMLTxsSummryType.AfterConstruction;
begin
  RegisterChildNode('TtlNtries', TXMLTtlNtriesType);
  RegisterChildNode('TtlCdtNtries', TXMLTtlCdtNtriesType);
  RegisterChildNode('TtlDbtNtries', TXMLTtlDbtNtriesType);
  inherited;
end;

function TXMLTxsSummryType.Get_TtlNtries: IXMLTtlNtriesType;
begin
  Result := ChildNodes['TtlNtries'] as IXMLTtlNtriesType;
end;

function TXMLTxsSummryType.Get_TtlCdtNtries: IXMLTtlCdtNtriesType;
begin
  Result := ChildNodes['TtlCdtNtries'] as IXMLTtlCdtNtriesType;
end;

function TXMLTxsSummryType.Get_TtlDbtNtries: IXMLTtlDbtNtriesType;
begin
  Result := ChildNodes['TtlDbtNtries'] as IXMLTtlDbtNtriesType;
end;

{ TXMLTtlNtriesType }

function TXMLTtlNtriesType.Get_NbOfNtries: Integer;
begin
  Result := ChildNodes['NbOfNtries'].NodeValue;
end;

procedure TXMLTtlNtriesType.Set_NbOfNtries(Value: Integer);
begin
  ChildNodes['NbOfNtries'].NodeValue := Value;
end;

function TXMLTtlNtriesType.Get_Sum: WideString;
begin
  Result := ChildNodes['Sum'].Text;
end;

procedure TXMLTtlNtriesType.Set_Sum(Value: WideString);
begin
  ChildNodes['Sum'].NodeValue := Value;
end;

function TXMLTtlNtriesType.Get_TtlNetNtryAmt: WideString;
begin
  Result := ChildNodes['TtlNetNtryAmt'].Text;
end;

procedure TXMLTtlNtriesType.Set_TtlNetNtryAmt(Value: WideString);
begin
  ChildNodes['TtlNetNtryAmt'].NodeValue := Value;
end;

function TXMLTtlNtriesType.Get_CdtDbtInd: WideString;
begin
  Result := ChildNodes['CdtDbtInd'].Text;
end;

procedure TXMLTtlNtriesType.Set_CdtDbtInd(Value: WideString);
begin
  ChildNodes['CdtDbtInd'].NodeValue := Value;
end;

{ TXMLTtlCdtNtriesType }

function TXMLTtlCdtNtriesType.Get_NbOfNtries: Integer;
begin
  Result := ChildNodes['NbOfNtries'].NodeValue;
end;

procedure TXMLTtlCdtNtriesType.Set_NbOfNtries(Value: Integer);
begin
  ChildNodes['NbOfNtries'].NodeValue := Value;
end;

function TXMLTtlCdtNtriesType.Get_Sum: WideString;
begin
  Result := ChildNodes['Sum'].Text;
end;

procedure TXMLTtlCdtNtriesType.Set_Sum(Value: WideString);
begin
  ChildNodes['Sum'].NodeValue := Value;
end;

{ TXMLTtlDbtNtriesType }

function TXMLTtlDbtNtriesType.Get_NbOfNtries: Integer;
begin
  Result := ChildNodes['NbOfNtries'].NodeValue;
end;

procedure TXMLTtlDbtNtriesType.Set_NbOfNtries(Value: Integer);
begin
  ChildNodes['NbOfNtries'].NodeValue := Value;
end;

function TXMLTtlDbtNtriesType.Get_Sum: WideString;
begin
  Result := ChildNodes['Sum'].Text;
end;

procedure TXMLTtlDbtNtriesType.Set_Sum(Value: WideString);
begin
  ChildNodes['Sum'].NodeValue := Value;
end;

{ TXMLNtryType }

procedure TXMLNtryType.AfterConstruction;
begin
  RegisterChildNode('Amt', TXMLAmtType);
  RegisterChildNode('BookgDt', TXMLBookgDtType);
  RegisterChildNode('ValDt', TXMLValDtType);
  RegisterChildNode('BkTxCd', TXMLBkTxCdType);
  RegisterChildNode('NtryDtls', TXMLNtryDtlsType);
  inherited;
end;

function TXMLNtryType.Get_Amt: IXMLAmtType;
begin
  Result := ChildNodes['Amt'] as IXMLAmtType;
end;

function TXMLNtryType.Get_CdtDbtInd: WideString;
begin
  Result := ChildNodes['CdtDbtInd'].Text;
end;

procedure TXMLNtryType.Set_CdtDbtInd(Value: WideString);
begin
  ChildNodes['CdtDbtInd'].NodeValue := Value;
end;

function TXMLNtryType.Get_RvslInd: WideString;
begin
  Result := ChildNodes['RvslInd'].Text;
end;

procedure TXMLNtryType.Set_RvslInd(Value: WideString);
begin
  ChildNodes['RvslInd'].NodeValue := Value;
end;

function TXMLNtryType.Get_Sts: WideString;
begin
  Result := ChildNodes['Sts'].Text;
end;

procedure TXMLNtryType.Set_Sts(Value: WideString);
begin
  ChildNodes['Sts'].NodeValue := Value;
end;

function TXMLNtryType.Get_BookgDt: IXMLBookgDtType;
begin
  Result := ChildNodes['BookgDt'] as IXMLBookgDtType;
end;

function TXMLNtryType.Get_ValDt: IXMLValDtType;
begin
  Result := ChildNodes['ValDt'] as IXMLValDtType;
end;

function TXMLNtryType.Get_BkTxCd: IXMLBkTxCdType;
begin
  Result := ChildNodes['BkTxCd'] as IXMLBkTxCdType;
end;

function TXMLNtryType.Get_NtryDtls: IXMLNtryDtlsType;
begin
  Result := ChildNodes['NtryDtls'] as IXMLNtryDtlsType;
end;

function TXMLNtryType.Get_NtryRef: WideString;
begin
  Result := ChildNodes['NtryRef'].Text;
end;

procedure TXMLNtryType.Set_NtryRef(Value: WideString);
begin
  ChildNodes['NtryRef'].NodeValue := Value;
end;

{ TXMLNtryTypeList }

function TXMLNtryTypeList.Add: IXMLNtryType;
begin
  Result := AddItem(-1) as IXMLNtryType;
end;

function TXMLNtryTypeList.Insert(const Index: Integer): IXMLNtryType;
begin
  Result := AddItem(Index) as IXMLNtryType;
end;

function TXMLNtryTypeList.Get_Item(Index: Integer): IXMLNtryType;
begin
  Result := List[Index] as IXMLNtryType;
end;

{ TXMLBookgDtType }

function TXMLBookgDtType.Get_Dt: WideString;
begin
  Result := ChildNodes['Dt'].Text;
end;

procedure TXMLBookgDtType.Set_Dt(Value: WideString);
begin
  ChildNodes['Dt'].NodeValue := Value;
end;

{ TXMLValDtType }

function TXMLValDtType.Get_Dt: WideString;
begin
  Result := ChildNodes['Dt'].Text;
end;

procedure TXMLValDtType.Set_Dt(Value: WideString);
begin
  ChildNodes['Dt'].NodeValue := Value;
end;

{ TXMLBkTxCdType }

procedure TXMLBkTxCdType.AfterConstruction;
begin
  RegisterChildNode('Prtry', TXMLPrtryType);
  inherited;
end;

function TXMLBkTxCdType.Get_Prtry: IXMLPrtryType;
begin
  Result := ChildNodes['Prtry'] as IXMLPrtryType;
end;

{ TXMLPrtryType }

function TXMLPrtryType.Get_Cd: WideString;
begin
  Result := ChildNodes['Cd'].NodeValue;
end;

procedure TXMLPrtryType.Set_Cd(Value: WideString);
begin
  ChildNodes['Cd'].NodeValue := Value;
end;

function TXMLPrtryType.Get_Issr: WideString;
begin
  Result := ChildNodes['Issr'].Text;
end;

procedure TXMLPrtryType.Set_Issr(Value: WideString);
begin
  ChildNodes['Issr'].NodeValue := Value;
end;

{ TXMLNtryDtlsType }

procedure TXMLNtryDtlsType.AfterConstruction;
begin
  RegisterChildNode('TxDtls', TXMLTxDtlsType);
  inherited;
end;

function TXMLNtryDtlsType.Get_TxDtls: IXMLTxDtlsType;
begin
  Result := ChildNodes['TxDtls'] as IXMLTxDtlsType;
end;

{ TXMLTxDtlsType }

procedure TXMLTxDtlsType.AfterConstruction;
begin
  RegisterChildNode('Refs', TXMLRefsType);
  RegisterChildNode('BkTxCd', TXMLBkTxCdType);
  RegisterChildNode('RltdPties', TXMLRltdPtiesType);
  RegisterChildNode('RltdAgts', TXMLRltdAgtsType);
  RegisterChildNode('RmtInf', TXMLRmtInfType);
  inherited;
end;

function TXMLTxDtlsType.Get_Refs: IXMLRefsType;
begin
  Result := ChildNodes['Refs'] as IXMLRefsType;
end;

function TXMLTxDtlsType.Get_BkTxCd: IXMLBkTxCdType;
begin
  Result := ChildNodes['BkTxCd'] as IXMLBkTxCdType;
end;

function TXMLTxDtlsType.Get_RltdPties: IXMLRltdPtiesType;
begin
  Result := ChildNodes['RltdPties'] as IXMLRltdPtiesType;
end;

function TXMLTxDtlsType.Get_RltdAgts: IXMLRltdAgtsType;
begin
  Result := ChildNodes['RltdAgts'] as IXMLRltdAgtsType;
end;

function TXMLTxDtlsType.Get_RmtInf: IXMLRmtInfType;
begin
  Result := ChildNodes['RmtInf'] as IXMLRmtInfType;
end;

{ TXMLRefsType }

function TXMLRefsType.Get_AcctSvcrRef: WideString;
begin
  Result := ChildNodes['AcctSvcrRef'].Text;
end;

procedure TXMLRefsType.Set_AcctSvcrRef(Value: WideString);
begin
  ChildNodes['AcctSvcrRef'].NodeValue := Value;
end;

function TXMLRefsType.Get_EndToEndId: WideString;
begin
  Result := ChildNodes['EndToEndId'].Text;
end;

procedure TXMLRefsType.Set_EndToEndId(Value: WideString);
begin
  ChildNodes['EndToEndId'].NodeValue := Value;
end;

function TXMLRefsType.Get_PmtInfId: WideString;
begin
  Result := ChildNodes['PmtInfId'].NodeValue;
end;

procedure TXMLRefsType.Set_PmtInfId(Value: WideString);
begin
  ChildNodes['PmtInfId'].NodeValue := Value;
end;

function TXMLRefsType.Get_InstrId: WideString;
begin
  Result := ChildNodes['InstrId'].Text;
end;

procedure TXMLRefsType.Set_InstrId(Value: WideString);
begin
  ChildNodes['InstrId'].NodeValue := Value;
end;

{ TXMLRltdPtiesType }

procedure TXMLRltdPtiesType.AfterConstruction;
begin
  RegisterChildNode('DbtrAcct', TXMLDbtrAcctType);
  RegisterChildNode('CdtrAcct', TXMLCdtrAcctType);
  RegisterChildNode('Dbtr', TXMLDbtrType);
  RegisterChildNode('Cdtr', TXMLCdtrType);
  inherited;
end;

function TXMLRltdPtiesType.Get_DbtrAcct: IXMLDbtrAcctType;
begin
  Result := ChildNodes['DbtrAcct'] as IXMLDbtrAcctType;
end;

function TXMLRltdPtiesType.Get_CdtrAcct: IXMLCdtrAcctType;
begin
  Result := ChildNodes['CdtrAcct'] as IXMLCdtrAcctType;
end;

function TXMLRltdPtiesType.Get_Dbtr: IXMLDbtrType;
begin
  Result := ChildNodes['Dbtr'] as IXMLDbtrType;
end;

function TXMLRltdPtiesType.Get_Cdtr: IXMLCdtrType;
begin
  Result := ChildNodes['Cdtr'] as IXMLCdtrType;
end;

{ TXMLDbtrAcctType }

procedure TXMLDbtrAcctType.AfterConstruction;
begin
  RegisterChildNode('Id', TXMLIdType);
  inherited;
end;

function TXMLDbtrAcctType.Get_Id: IXMLIdType;
begin
  Result := ChildNodes['Id'] as IXMLIdType;
end;

function TXMLDbtrAcctType.Get_Nm: WideString;
begin
  Result := ChildNodes['Nm'].Text;
end;

procedure TXMLDbtrAcctType.Set_Nm(Value: WideString);
begin
  ChildNodes['Nm'].NodeValue := Value;
end;

{ TXMLCdtrAcctType }

procedure TXMLCdtrAcctType.AfterConstruction;
begin
  RegisterChildNode('Id', TXMLIdType);
  inherited;
end;

function TXMLCdtrAcctType.Get_Id: IXMLIdType;
begin
  Result := ChildNodes['Id'] as IXMLIdType;
end;

function TXMLCdtrAcctType.Get_Nm: WideString;
begin
  Result := ChildNodes['Nm'].Text;
end;

procedure TXMLCdtrAcctType.Set_Nm(Value: WideString);
begin
  ChildNodes['Nm'].NodeValue := Value;
end;

{ TXMLDbtrType }

procedure TXMLDbtrType.AfterConstruction;
begin
  RegisterChildNode('PstlAdr', TXMLPstlAdrType);
  inherited;
end;

function TXMLDbtrType.Get_PstlAdr: IXMLPstlAdrType;
begin
  Result := ChildNodes['PstlAdr'] as IXMLPstlAdrType;
end;

{ TXMLCdtrType }

procedure TXMLCdtrType.AfterConstruction;
begin
  RegisterChildNode('PstlAdr', TXMLPstlAdrType);
  inherited;
end;

function TXMLCdtrType.Get_PstlAdr: IXMLPstlAdrType;
begin
  Result := ChildNodes['PstlAdr'] as IXMLPstlAdrType;
end;

{ TXMLRltdAgtsType }

procedure TXMLRltdAgtsType.AfterConstruction;
begin
  RegisterChildNode('DbtrAgt', TXMLDbtrAgtType);
  RegisterChildNode('CdtrAgt', TXMLCdtrAgtType);
  inherited;
end;

function TXMLRltdAgtsType.Get_DbtrAgt: IXMLDbtrAgtType;
begin
  Result := ChildNodes['DbtrAgt'] as IXMLDbtrAgtType;
end;

function TXMLRltdAgtsType.Get_CdtrAgt: IXMLCdtrAgtType;
begin
  Result := ChildNodes['CdtrAgt'] as IXMLCdtrAgtType;
end;

{ TXMLDbtrAgtType }

procedure TXMLDbtrAgtType.AfterConstruction;
begin
  RegisterChildNode('FinInstnId', TXMLFinInstnIdType);
  inherited;
end;

function TXMLDbtrAgtType.Get_FinInstnId: IXMLFinInstnIdType;
begin
  Result := ChildNodes['FinInstnId'] as IXMLFinInstnIdType;
end;

{ TXMLCdtrAgtType }

procedure TXMLCdtrAgtType.AfterConstruction;
begin
  RegisterChildNode('FinInstnId', TXMLFinInstnIdType);
  inherited;
end;

function TXMLCdtrAgtType.Get_FinInstnId: IXMLFinInstnIdType;
begin
  Result := ChildNodes['FinInstnId'] as IXMLFinInstnIdType;
end;

{ TXMLRmtInfType }

function TXMLRmtInfType.Get_Ustrd: WideString;
begin
  Result := ChildNodes['Ustrd'].Text;
end;

procedure TXMLRmtInfType.Set_Ustrd(Value: WideString);
begin
  ChildNodes['Ustrd'].NodeValue := Value;
end;

end.
