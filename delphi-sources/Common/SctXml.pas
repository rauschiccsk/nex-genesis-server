
{******************************************************************************************}
{                                                                                          }
{                                 Delphi XML Data Binding                                  }
{                                                                                          }
{         Generated on: 13.1.2018 17:26:47                                                 }
{       Generated from: C:\NEX Develop\Aplikácie\Pomocné programy\SEPAXML\SCT\SCT_a1.xml   }
{   Settings stored in: C:\NEX Develop\Aplikácie\Pomocné programy\SEPAXML\SCT\SCT_a1.xdb   }
{                                                                                          }
{******************************************************************************************}
unit SCTXML;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLDocumentType = interface;
  IXMLCstmrCdtTrfInitnType = interface;
  IXMLGrpHdrType = interface;
  IXMLInitgPtyType = interface;
  IXMLPmtInfType = interface;
  IXMLPmtTpInfType = interface;
  IXMLSvcLvlType = interface;
  IXMLDbtrType = interface;
  IXMLPstlAdrType = interface;
  IXMLDbtrAcctType = interface;
  IXMLIdType = interface;
  IXMLDbtrAgtType = interface;
  IXMLFinInstnIdType = interface;
  IXMLCdtTrfTxInfType = interface;
  IXMLCdtTrfTxInfTypeList = interface;
  IXMLPmtIdType = interface;
  IXMLAmtType = interface;
  IXMLInstdAmtType = interface;
  IXMLCdtrAgtType = interface;
  IXMLCdtrType = interface;
  IXMLCdtrAcctType = interface;
  IXMLRmtInfType = interface;
  IXMLString_List = interface;

{ IXMLDocumentType }

  IXMLDocumentType = interface(IXMLNode)
    ['{89771198-6441-4FBE-ACCD-70749E0A3F8B}']
    { Property Accessors }
    function Get_CstmrCdtTrfInitn: IXMLCstmrCdtTrfInitnType;
    { Methods & Properties }
    property CstmrCdtTrfInitn: IXMLCstmrCdtTrfInitnType read Get_CstmrCdtTrfInitn;
  end;

{ IXMLCstmrCdtTrfInitnType }

  IXMLCstmrCdtTrfInitnType = interface(IXMLNode)
    ['{1D55A72B-8B45-443A-B4F1-D0A116CBC7E3}']
    { Property Accessors }
    function Get_GrpHdr: IXMLGrpHdrType;
    function Get_PmtInf: IXMLPmtInfType;
    { Methods & Properties }
    property GrpHdr: IXMLGrpHdrType read Get_GrpHdr;
    property PmtInf: IXMLPmtInfType read Get_PmtInf;
  end;

{ IXMLGrpHdrType }

  IXMLGrpHdrType = interface(IXMLNode)
    ['{18BB01F5-9189-4426-8665-0C1CA746635E}']
    { Property Accessors }
    function Get_MsgId: WideString;
    function Get_CreDtTm: WideString;
    function Get_NbOfTxs: Integer;
    function Get_CtrlSum: WideString;
    function Get_InitgPty: IXMLInitgPtyType;
    procedure Set_MsgId(Value: WideString);
    procedure Set_CreDtTm(Value: WideString);
    procedure Set_NbOfTxs(Value: Integer);
    procedure Set_CtrlSum(Value: WideString);
    { Methods & Properties }
    property MsgId: WideString read Get_MsgId write Set_MsgId;
    property CreDtTm: WideString read Get_CreDtTm write Set_CreDtTm;
    property NbOfTxs: Integer read Get_NbOfTxs write Set_NbOfTxs;
    property CtrlSum: WideString read Get_CtrlSum write Set_CtrlSum;
    property InitgPty: IXMLInitgPtyType read Get_InitgPty;
  end;

{ IXMLInitgPtyType }

  IXMLInitgPtyType = interface(IXMLNode)
    ['{344B1D91-6E91-49B3-9AF4-B50902F90D7B}']
    { Property Accessors }
    function Get_Nm: WideString;
    procedure Set_Nm(Value: WideString);
    { Methods & Properties }
    property Nm: WideString read Get_Nm write Set_Nm;
  end;

{ IXMLPmtInfType }

  IXMLPmtInfType = interface(IXMLNode)
    ['{E2E14583-C677-4A7C-8650-92E69E0D7F06}']
    { Property Accessors }
    function Get_PmtInfId: WideString;
    function Get_PmtMtd: WideString;
    function Get_BtchBookg: WideString;
    function Get_NbOfTxs: Integer;
    function Get_CtrlSum: WideString;
    function Get_PmtTpInf: IXMLPmtTpInfType;
    function Get_ReqdExctnDt: WideString;
    function Get_Dbtr: IXMLDbtrType;
    function Get_DbtrAcct: IXMLDbtrAcctType;
    function Get_DbtrAgt: IXMLDbtrAgtType;
    function Get_ChrgBr: WideString;
    function Get_CdtTrfTxInf: IXMLCdtTrfTxInfTypeList;
    procedure Set_PmtInfId(Value: WideString);
    procedure Set_PmtMtd(Value: WideString);
    procedure Set_BtchBookg(Value: WideString);
    procedure Set_NbOfTxs(Value: Integer);
    procedure Set_CtrlSum(Value: WideString);
    procedure Set_ReqdExctnDt(Value: WideString);
    procedure Set_ChrgBr(Value: WideString);
    { Methods & Properties }
    property PmtInfId: WideString read Get_PmtInfId write Set_PmtInfId;
    property PmtMtd: WideString read Get_PmtMtd write Set_PmtMtd;
    property BtchBookg: WideString read Get_BtchBookg write Set_BtchBookg;
    property NbOfTxs: Integer read Get_NbOfTxs write Set_NbOfTxs;
    property CtrlSum: WideString read Get_CtrlSum write Set_CtrlSum;
    property PmtTpInf: IXMLPmtTpInfType read Get_PmtTpInf;
    property ReqdExctnDt: WideString read Get_ReqdExctnDt write Set_ReqdExctnDt;
    property Dbtr: IXMLDbtrType read Get_Dbtr;
    property DbtrAcct: IXMLDbtrAcctType read Get_DbtrAcct;
    property DbtrAgt: IXMLDbtrAgtType read Get_DbtrAgt;
    property ChrgBr: WideString read Get_ChrgBr write Set_ChrgBr;
    property CdtTrfTxInf: IXMLCdtTrfTxInfTypeList read Get_CdtTrfTxInf;
  end;

{ IXMLPmtTpInfType }

  IXMLPmtTpInfType = interface(IXMLNode)
    ['{BE0094EE-9113-4BE4-9B6A-EA1ED5E7C177}']
    { Property Accessors }
    function Get_InstrPrty: WideString;
    function Get_SvcLvl: IXMLSvcLvlType;
    procedure Set_InstrPrty(Value: WideString);
    { Methods & Properties }
    property InstrPrty: WideString read Get_InstrPrty write Set_InstrPrty;
    property SvcLvl: IXMLSvcLvlType read Get_SvcLvl;
  end;

{ IXMLSvcLvlType }

  IXMLSvcLvlType = interface(IXMLNode)
    ['{95D45685-D216-4A2C-BAD4-6CECDFD4BF60}']
    { Property Accessors }
    function Get_Cd: WideString;
    procedure Set_Cd(Value: WideString);
    { Methods & Properties }
    property Cd: WideString read Get_Cd write Set_Cd;
  end;

{ IXMLDbtrType }

  IXMLDbtrType = interface(IXMLNode)
    ['{1F9B0F18-1B44-4DEA-9CA0-164A2DAD9B57}']
    { Property Accessors }
    function Get_Nm: WideString;
    function Get_PstlAdr: IXMLPstlAdrType;
    procedure Set_Nm(Value: WideString);
    { Methods & Properties }
    property Nm: WideString read Get_Nm write Set_Nm;
    property PstlAdr: IXMLPstlAdrType read Get_PstlAdr;
  end;

{ IXMLPstlAdrType }

  IXMLPstlAdrType = interface(IXMLNode)
    ['{06640FAB-82A6-40C2-82D4-27A49F05C901}']
    { Property Accessors }
    function Get_Ctry: WideString;
    function Get_AdrLine: IXMLString_List;
    procedure Set_Ctry(Value: WideString);
    { Methods & Properties }
    property Ctry: WideString read Get_Ctry write Set_Ctry;
    property AdrLine: IXMLString_List read Get_AdrLine;
  end;

{ IXMLDbtrAcctType }

  IXMLDbtrAcctType = interface(IXMLNode)
    ['{DD438226-5FB7-40CF-BE85-85FB64ACD6DC}']
    { Property Accessors }
    function Get_Id: IXMLIdType;
    function Get_Ccy: WideString;
    procedure Set_Ccy(Value: WideString);
    { Methods & Properties }
    property Id: IXMLIdType read Get_Id;
    property Ccy: WideString read Get_Ccy write Set_Ccy;
  end;

{ IXMLIdType }

  IXMLIdType = interface(IXMLNode)
    ['{9EDFFE7A-9CA6-4932-AE48-36900A197BCB}']
    { Property Accessors }
    function Get_IBAN: WideString;
    procedure Set_IBAN(Value: WideString);
    { Methods & Properties }
    property IBAN: WideString read Get_IBAN write Set_IBAN;
  end;

{ IXMLDbtrAgtType }

  IXMLDbtrAgtType = interface(IXMLNode)
    ['{6ED84DCB-321D-40A3-9CD3-159ED35ED414}']
    { Property Accessors }
    function Get_FinInstnId: IXMLFinInstnIdType;
    { Methods & Properties }
    property FinInstnId: IXMLFinInstnIdType read Get_FinInstnId;
  end;

{ IXMLFinInstnIdType }

  IXMLFinInstnIdType = interface(IXMLNode)
    ['{981BE676-2D2F-4B63-ACC4-194EC4BD1C1D}']
    { Property Accessors }
    function Get_BIC: WideString;
    function Get_Nm: WideString;
    procedure Set_BIC(Value: WideString);
    procedure Set_Nm(Value: WideString);
    { Methods & Properties }
    property BIC: WideString read Get_BIC write Set_BIC;
    property Nm: WideString read Get_Nm write Set_Nm;
  end;

{ IXMLCdtTrfTxInfType }

  IXMLCdtTrfTxInfType = interface(IXMLNode)
    ['{BEA1D3CC-B242-4D75-8448-9C5C3E9E4A44}']
    { Property Accessors }
    function Get_PmtId: IXMLPmtIdType;
    function Get_PmtTpInf: IXMLPmtTpInfType;
    function Get_Amt: IXMLAmtType;
    function Get_ChrgBr: WideString;
    function Get_CdtrAgt: IXMLCdtrAgtType;
    function Get_Cdtr: IXMLCdtrType;
    function Get_CdtrAcct: IXMLCdtrAcctType;
    function Get_RmtInf: IXMLRmtInfType;
    procedure Set_ChrgBr(Value: WideString);
    { Methods & Properties }
    property PmtId: IXMLPmtIdType read Get_PmtId;
    property PmtTpInf: IXMLPmtTpInfType read Get_PmtTpInf;
    property Amt: IXMLAmtType read Get_Amt;
    property ChrgBr: WideString read Get_ChrgBr write Set_ChrgBr;
    property CdtrAgt: IXMLCdtrAgtType read Get_CdtrAgt;
    property Cdtr: IXMLCdtrType read Get_Cdtr;
    property CdtrAcct: IXMLCdtrAcctType read Get_CdtrAcct;
    property RmtInf: IXMLRmtInfType read Get_RmtInf;
  end;

{ IXMLCdtTrfTxInfTypeList }

  IXMLCdtTrfTxInfTypeList = interface(IXMLNodeCollection)
    ['{E2815476-3EFD-429B-A535-449045D0F90B}']
    { Methods & Properties }
    function Add: IXMLCdtTrfTxInfType;
    function Insert(const Index: Integer): IXMLCdtTrfTxInfType;
    function Get_Item(Index: Integer): IXMLCdtTrfTxInfType;
    property Items[Index: Integer]: IXMLCdtTrfTxInfType read Get_Item; default;
  end;

{ IXMLPmtIdType }

  IXMLPmtIdType = interface(IXMLNode)
    ['{409C82F3-82A9-4374-8178-E2B8767BD6E8}']
    { Property Accessors }
    function Get_InstrId: WideString;
    function Get_EndToEndId: WideString;
    procedure Set_InstrId(Value: WideString);
    procedure Set_EndToEndId(Value: WideString);
    { Methods & Properties }
    property InstrId: WideString read Get_InstrId write Set_InstrId;
    property EndToEndId: WideString read Get_EndToEndId write Set_EndToEndId;
  end;

{ IXMLAmtType }

  IXMLAmtType = interface(IXMLNode)
    ['{99E8137F-F7FC-415A-A30F-F4452BB7526F}']
    { Property Accessors }
    function Get_InstdAmt: IXMLInstdAmtType;
    { Methods & Properties }
    property InstdAmt: IXMLInstdAmtType read Get_InstdAmt;
  end;

{ IXMLInstdAmtType }

  IXMLInstdAmtType = interface(IXMLNode)
    ['{90C4C49B-8E84-495F-8750-6810C428119E}']
    { Property Accessors }
    function Get_Ccy: WideString;
    procedure Set_Ccy(Value: WideString);
    { Methods & Properties }
    property Ccy: WideString read Get_Ccy write Set_Ccy;
  end;

{ IXMLCdtrAgtType }

  IXMLCdtrAgtType = interface(IXMLNode)
    ['{0A5E7C60-C7D0-4CC3-B8B6-D85BEDDDE1FF}']
    { Property Accessors }
    function Get_FinInstnId: IXMLFinInstnIdType;
    { Methods & Properties }
    property FinInstnId: IXMLFinInstnIdType read Get_FinInstnId;
  end;

{ IXMLCdtrType }

  IXMLCdtrType = interface(IXMLNode)
    ['{91A8A8CF-233E-46B8-98BC-A8A43FA31A18}']
    { Property Accessors }
    function Get_Nm: WideString;
    procedure Set_Nm(Value: WideString);
    { Methods & Properties }
    property Nm: WideString read Get_Nm write Set_Nm;
  end;

{ IXMLCdtrAcctType }

  IXMLCdtrAcctType = interface(IXMLNode)
    ['{9C744FC0-CC5E-4C36-8F6B-DE2207FC9D34}']
    { Property Accessors }
    function Get_Id: IXMLIdType;
    { Methods & Properties }
    property Id: IXMLIdType read Get_Id;
  end;

{ IXMLRmtInfType }

  IXMLRmtInfType = interface(IXMLNode)
    ['{CA6CEC46-FBAF-469F-839C-B6F26AE0F779}']
    { Property Accessors }
    function Get_Ustrd: WideString;
    procedure Set_Ustrd(Value: WideString);
    { Methods & Properties }
    property Ustrd: WideString read Get_Ustrd write Set_Ustrd;
  end;

{ IXMLString_List }

  IXMLString_List = interface(IXMLNodeCollection)
    ['{92E794B5-36E9-4BD1-ABF1-FF71738B7DFF}']
    { Methods & Properties }
    function Add(const Value: WideString): IXMLNode;
    function Insert(const Index: Integer; const Value: WideString): IXMLNode;
    function Get_Item(Index: Integer): WideString;
    property Items[Index: Integer]: WideString read Get_Item; default;
  end;

{ Forward Decls }

  TXMLDocumentType = class;
  TXMLCstmrCdtTrfInitnType = class;
  TXMLGrpHdrType = class;
  TXMLInitgPtyType = class;
  TXMLPmtInfType = class;
  TXMLPmtTpInfType = class;
  TXMLSvcLvlType = class;
  TXMLDbtrType = class;
  TXMLPstlAdrType = class;
  TXMLDbtrAcctType = class;
  TXMLIdType = class;
  TXMLDbtrAgtType = class;
  TXMLFinInstnIdType = class;
  TXMLCdtTrfTxInfType = class;
  TXMLCdtTrfTxInfTypeList = class;
  TXMLPmtIdType = class;
  TXMLAmtType = class;
  TXMLInstdAmtType = class;
  TXMLCdtrAgtType = class;
  TXMLCdtrType = class;
  TXMLCdtrAcctType = class;
  TXMLRmtInfType = class;
  TXMLString_List = class;

{ TXMLDocumentType }

  TXMLDocumentType = class(TXMLNode, IXMLDocumentType)
  protected
    { IXMLDocumentType }
    function Get_CstmrCdtTrfInitn: IXMLCstmrCdtTrfInitnType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLCstmrCdtTrfInitnType }

  TXMLCstmrCdtTrfInitnType = class(TXMLNode, IXMLCstmrCdtTrfInitnType)
  protected
    { IXMLCstmrCdtTrfInitnType }
    function Get_GrpHdr: IXMLGrpHdrType;
    function Get_PmtInf: IXMLPmtInfType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLGrpHdrType }

  TXMLGrpHdrType = class(TXMLNode, IXMLGrpHdrType)
  protected
    { IXMLGrpHdrType }
    function Get_MsgId: WideString;
    function Get_CreDtTm: WideString;
    function Get_NbOfTxs: Integer;
    function Get_CtrlSum: WideString;
    function Get_InitgPty: IXMLInitgPtyType;
    procedure Set_MsgId(Value: WideString);
    procedure Set_CreDtTm(Value: WideString);
    procedure Set_NbOfTxs(Value: Integer);
    procedure Set_CtrlSum(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLInitgPtyType }

  TXMLInitgPtyType = class(TXMLNode, IXMLInitgPtyType)
  protected
    { IXMLInitgPtyType }
    function Get_Nm: WideString;
    procedure Set_Nm(Value: WideString);
  end;

{ TXMLPmtInfType }

  TXMLPmtInfType = class(TXMLNode, IXMLPmtInfType)
  private
    FCdtTrfTxInf: IXMLCdtTrfTxInfTypeList;
  protected
    { IXMLPmtInfType }
    function Get_PmtInfId: WideString;
    function Get_PmtMtd: WideString;
    function Get_BtchBookg: WideString;
    function Get_NbOfTxs: Integer;
    function Get_CtrlSum: WideString;
    function Get_PmtTpInf: IXMLPmtTpInfType;
    function Get_ReqdExctnDt: WideString;
    function Get_Dbtr: IXMLDbtrType;
    function Get_DbtrAcct: IXMLDbtrAcctType;
    function Get_DbtrAgt: IXMLDbtrAgtType;
    function Get_ChrgBr: WideString;
    function Get_CdtTrfTxInf: IXMLCdtTrfTxInfTypeList;
    procedure Set_PmtInfId(Value: WideString);
    procedure Set_PmtMtd(Value: WideString);
    procedure Set_BtchBookg(Value: WideString);
    procedure Set_NbOfTxs(Value: Integer);
    procedure Set_CtrlSum(Value: WideString);
    procedure Set_ReqdExctnDt(Value: WideString);
    procedure Set_ChrgBr(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLPmtTpInfType }

  TXMLPmtTpInfType = class(TXMLNode, IXMLPmtTpInfType)
  protected
    { IXMLPmtTpInfType }
    function Get_InstrPrty: WideString;
    function Get_SvcLvl: IXMLSvcLvlType;
    procedure Set_InstrPrty(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLSvcLvlType }

  TXMLSvcLvlType = class(TXMLNode, IXMLSvcLvlType)
  protected
    { IXMLSvcLvlType }
    function Get_Cd: WideString;
    procedure Set_Cd(Value: WideString);
  end;

{ TXMLDbtrType }

  TXMLDbtrType = class(TXMLNode, IXMLDbtrType)
  protected
    { IXMLDbtrType }
    function Get_Nm: WideString;
    function Get_PstlAdr: IXMLPstlAdrType;
    procedure Set_Nm(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLPstlAdrType }

  TXMLPstlAdrType = class(TXMLNode, IXMLPstlAdrType)
  private
    FAdrLine: IXMLString_List;
  protected
    { IXMLPstlAdrType }
    function Get_Ctry: WideString;
    function Get_AdrLine: IXMLString_List;
    procedure Set_Ctry(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLDbtrAcctType }

  TXMLDbtrAcctType = class(TXMLNode, IXMLDbtrAcctType)
  protected
    { IXMLDbtrAcctType }
    function Get_Id: IXMLIdType;
    function Get_Ccy: WideString;
    procedure Set_Ccy(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLIdType }

  TXMLIdType = class(TXMLNode, IXMLIdType)
  protected
    { IXMLIdType }
    function Get_IBAN: WideString;
    procedure Set_IBAN(Value: WideString);
  end;

{ TXMLDbtrAgtType }

  TXMLDbtrAgtType = class(TXMLNode, IXMLDbtrAgtType)
  protected
    { IXMLDbtrAgtType }
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
    procedure Set_BIC(Value: WideString);
    procedure Set_Nm(Value: WideString);
  end;

{ TXMLCdtTrfTxInfType }

  TXMLCdtTrfTxInfType = class(TXMLNode, IXMLCdtTrfTxInfType)
  protected
    { IXMLCdtTrfTxInfType }
    function Get_PmtId: IXMLPmtIdType;
    function Get_PmtTpInf: IXMLPmtTpInfType;
    function Get_Amt: IXMLAmtType;
    function Get_ChrgBr: WideString;
    function Get_CdtrAgt: IXMLCdtrAgtType;
    function Get_Cdtr: IXMLCdtrType;
    function Get_CdtrAcct: IXMLCdtrAcctType;
    function Get_RmtInf: IXMLRmtInfType;
    procedure Set_ChrgBr(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLCdtTrfTxInfTypeList }

  TXMLCdtTrfTxInfTypeList = class(TXMLNodeCollection, IXMLCdtTrfTxInfTypeList)
  protected
    { IXMLCdtTrfTxInfTypeList }
    function Add: IXMLCdtTrfTxInfType;
    function Insert(const Index: Integer): IXMLCdtTrfTxInfType;
    function Get_Item(Index: Integer): IXMLCdtTrfTxInfType;
  end;

{ TXMLPmtIdType }

  TXMLPmtIdType = class(TXMLNode, IXMLPmtIdType)
  protected
    { IXMLPmtIdType }
    function Get_InstrId: WideString;
    function Get_EndToEndId: WideString;
    procedure Set_InstrId(Value: WideString);
    procedure Set_EndToEndId(Value: WideString);
  end;

{ TXMLAmtType }

  TXMLAmtType = class(TXMLNode, IXMLAmtType)
  protected
    { IXMLAmtType }
    function Get_InstdAmt: IXMLInstdAmtType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLInstdAmtType }

  TXMLInstdAmtType = class(TXMLNode, IXMLInstdAmtType)
  protected
    { IXMLInstdAmtType }
    function Get_Ccy: WideString;
    procedure Set_Ccy(Value: WideString);
  end;

{ TXMLCdtrAgtType }

  TXMLCdtrAgtType = class(TXMLNode, IXMLCdtrAgtType)
  protected
    { IXMLCdtrAgtType }
    function Get_FinInstnId: IXMLFinInstnIdType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLCdtrType }

  TXMLCdtrType = class(TXMLNode, IXMLCdtrType)
  protected
    { IXMLCdtrType }
    function Get_Nm: WideString;
    procedure Set_Nm(Value: WideString);
  end;

{ TXMLCdtrAcctType }

  TXMLCdtrAcctType = class(TXMLNode, IXMLCdtrAcctType)
  protected
    { IXMLCdtrAcctType }
    function Get_Id: IXMLIdType;
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

{ TXMLString_List }

  TXMLString_List = class(TXMLNodeCollection, IXMLString_List)
  protected
    { IXMLString_List }
    function Add(const Value: WideString): IXMLNode;
    function Insert(const Index: Integer; const Value: WideString): IXMLNode;
    function Get_Item(Index: Integer): WideString;
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
  RegisterChildNode('CstmrCdtTrfInitn', TXMLCstmrCdtTrfInitnType);
  inherited;
end;

function TXMLDocumentType.Get_CstmrCdtTrfInitn: IXMLCstmrCdtTrfInitnType;
begin
  Result := ChildNodes['CstmrCdtTrfInitn'] as IXMLCstmrCdtTrfInitnType;
end;

{ TXMLCstmrCdtTrfInitnType }

procedure TXMLCstmrCdtTrfInitnType.AfterConstruction;
begin
  RegisterChildNode('GrpHdr', TXMLGrpHdrType);
  RegisterChildNode('PmtInf', TXMLPmtInfType);
  inherited;
end;

function TXMLCstmrCdtTrfInitnType.Get_GrpHdr: IXMLGrpHdrType;
begin
  Result := ChildNodes['GrpHdr'] as IXMLGrpHdrType;
end;

function TXMLCstmrCdtTrfInitnType.Get_PmtInf: IXMLPmtInfType;
begin
  Result := ChildNodes['PmtInf'] as IXMLPmtInfType;
end;

{ TXMLGrpHdrType }

procedure TXMLGrpHdrType.AfterConstruction;
begin
  RegisterChildNode('InitgPty', TXMLInitgPtyType);
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

function TXMLGrpHdrType.Get_NbOfTxs: Integer;
begin
  Result := ChildNodes['NbOfTxs'].NodeValue;
end;

procedure TXMLGrpHdrType.Set_NbOfTxs(Value: Integer);
begin
  ChildNodes['NbOfTxs'].NodeValue := Value;
end;

function TXMLGrpHdrType.Get_CtrlSum: WideString;
begin
  Result := ChildNodes['CtrlSum'].NodeValue;
end;

procedure TXMLGrpHdrType.Set_CtrlSum(Value: WideString);
begin
  ChildNodes['CtrlSum'].NodeValue := Value;
end;

function TXMLGrpHdrType.Get_InitgPty: IXMLInitgPtyType;
begin
  Result := ChildNodes['InitgPty'] as IXMLInitgPtyType;
end;

{ TXMLInitgPtyType }

function TXMLInitgPtyType.Get_Nm: WideString;
begin
  Result := ChildNodes['Nm'].Text;
end;

procedure TXMLInitgPtyType.Set_Nm(Value: WideString);
begin
  ChildNodes['Nm'].NodeValue := Value;
end;

{ TXMLPmtInfType }

procedure TXMLPmtInfType.AfterConstruction;
begin
  RegisterChildNode('PmtTpInf', TXMLPmtTpInfType);
  RegisterChildNode('Dbtr', TXMLDbtrType);
  RegisterChildNode('DbtrAcct', TXMLDbtrAcctType);
  RegisterChildNode('DbtrAgt', TXMLDbtrAgtType);
  RegisterChildNode('CdtTrfTxInf', TXMLCdtTrfTxInfType);
  FCdtTrfTxInf := CreateCollection(TXMLCdtTrfTxInfTypeList, IXMLCdtTrfTxInfType, 'CdtTrfTxInf') as IXMLCdtTrfTxInfTypeList;
  inherited;
end;

function TXMLPmtInfType.Get_PmtInfId: WideString;
begin
  Result := ChildNodes['PmtInfId'].Text;
end;

procedure TXMLPmtInfType.Set_PmtInfId(Value: WideString);
begin
  ChildNodes['PmtInfId'].NodeValue := Value;
end;

function TXMLPmtInfType.Get_PmtMtd: WideString;
begin
  Result := ChildNodes['PmtMtd'].Text;
end;

procedure TXMLPmtInfType.Set_PmtMtd(Value: WideString);
begin
  ChildNodes['PmtMtd'].NodeValue := Value;
end;

function TXMLPmtInfType.Get_BtchBookg: WideString;
begin
  Result := ChildNodes['BtchBookg'].Text;
end;

procedure TXMLPmtInfType.Set_BtchBookg(Value: WideString);
begin
  ChildNodes['BtchBookg'].NodeValue := Value;
end;

function TXMLPmtInfType.Get_NbOfTxs: Integer;
begin
  Result := ChildNodes['NbOfTxs'].NodeValue;
end;

procedure TXMLPmtInfType.Set_NbOfTxs(Value: Integer);
begin
  ChildNodes['NbOfTxs'].NodeValue := Value;
end;

function TXMLPmtInfType.Get_CtrlSum: WideString;
begin
  Result := ChildNodes['CtrlSum'].NodeValue;
end;

procedure TXMLPmtInfType.Set_CtrlSum(Value: WideString);
begin
  ChildNodes['CtrlSum'].NodeValue := Value;
end;

function TXMLPmtInfType.Get_PmtTpInf: IXMLPmtTpInfType;
begin
  Result := ChildNodes['PmtTpInf'] as IXMLPmtTpInfType;
end;

function TXMLPmtInfType.Get_ReqdExctnDt: WideString;
begin
  Result := ChildNodes['ReqdExctnDt'].Text;
end;

procedure TXMLPmtInfType.Set_ReqdExctnDt(Value: WideString);
begin
  ChildNodes['ReqdExctnDt'].NodeValue := Value;
end;

function TXMLPmtInfType.Get_Dbtr: IXMLDbtrType;
begin
  Result := ChildNodes['Dbtr'] as IXMLDbtrType;
end;

function TXMLPmtInfType.Get_DbtrAcct: IXMLDbtrAcctType;
begin
  Result := ChildNodes['DbtrAcct'] as IXMLDbtrAcctType;
end;

function TXMLPmtInfType.Get_DbtrAgt: IXMLDbtrAgtType;
begin
  Result := ChildNodes['DbtrAgt'] as IXMLDbtrAgtType;
end;

function TXMLPmtInfType.Get_ChrgBr: WideString;
begin
  Result := ChildNodes['ChrgBr'].Text;
end;

procedure TXMLPmtInfType.Set_ChrgBr(Value: WideString);
begin
  ChildNodes['ChrgBr'].NodeValue := Value;
end;

function TXMLPmtInfType.Get_CdtTrfTxInf: IXMLCdtTrfTxInfTypeList;
begin
  Result := FCdtTrfTxInf;
end;

{ TXMLPmtTpInfType }

procedure TXMLPmtTpInfType.AfterConstruction;
begin
  RegisterChildNode('SvcLvl', TXMLSvcLvlType);
  inherited;
end;

function TXMLPmtTpInfType.Get_InstrPrty: WideString;
begin
  Result := ChildNodes['InstrPrty'].Text;
end;

procedure TXMLPmtTpInfType.Set_InstrPrty(Value: WideString);
begin
  ChildNodes['InstrPrty'].NodeValue := Value;
end;

function TXMLPmtTpInfType.Get_SvcLvl: IXMLSvcLvlType;
begin
  Result := ChildNodes['SvcLvl'] as IXMLSvcLvlType;
end;

{ TXMLSvcLvlType }

function TXMLSvcLvlType.Get_Cd: WideString;
begin
  Result := ChildNodes['Cd'].Text;
end;

procedure TXMLSvcLvlType.Set_Cd(Value: WideString);
begin
  ChildNodes['Cd'].NodeValue := Value;
end;

{ TXMLDbtrType }

procedure TXMLDbtrType.AfterConstruction;
begin
  RegisterChildNode('PstlAdr', TXMLPstlAdrType);
  inherited;
end;

function TXMLDbtrType.Get_Nm: WideString;
begin
  Result := ChildNodes['Nm'].Text;
end;

procedure TXMLDbtrType.Set_Nm(Value: WideString);
begin
  ChildNodes['Nm'].NodeValue := Value;
end;

function TXMLDbtrType.Get_PstlAdr: IXMLPstlAdrType;
begin
  Result := ChildNodes['PstlAdr'] as IXMLPstlAdrType;
end;

{ TXMLPstlAdrType }

procedure TXMLPstlAdrType.AfterConstruction;
begin
  FAdrLine := CreateCollection(TXMLString_List, IXMLNode, 'AdrLine') as IXMLString_List;
  inherited;
end;

function TXMLPstlAdrType.Get_Ctry: WideString;
begin
  Result := ChildNodes['Ctry'].Text;
end;

procedure TXMLPstlAdrType.Set_Ctry(Value: WideString);
begin
  ChildNodes['Ctry'].NodeValue := Value;
end;

function TXMLPstlAdrType.Get_AdrLine: IXMLString_List;
begin
  Result := FAdrLine;
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

function TXMLDbtrAcctType.Get_Ccy: WideString;
begin
  Result := ChildNodes['Ccy'].Text;
end;

procedure TXMLDbtrAcctType.Set_Ccy(Value: WideString);
begin
  ChildNodes['Ccy'].NodeValue := Value;
end;

{ TXMLIdType }

function TXMLIdType.Get_IBAN: WideString;
begin
  Result := ChildNodes['IBAN'].Text;
end;

procedure TXMLIdType.Set_IBAN(Value: WideString);
begin
  ChildNodes['IBAN'].NodeValue := Value;
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

{ TXMLFinInstnIdType }

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

{ TXMLCdtTrfTxInfType }

procedure TXMLCdtTrfTxInfType.AfterConstruction;
begin
  RegisterChildNode('PmtId', TXMLPmtIdType);
  RegisterChildNode('PmtTpInf', TXMLPmtTpInfType);
  RegisterChildNode('Amt', TXMLAmtType);
  RegisterChildNode('CdtrAgt', TXMLCdtrAgtType);
  RegisterChildNode('Cdtr', TXMLCdtrType);
  RegisterChildNode('CdtrAcct', TXMLCdtrAcctType);
  RegisterChildNode('RmtInf', TXMLRmtInfType);
  inherited;
end;

function TXMLCdtTrfTxInfType.Get_PmtId: IXMLPmtIdType;
begin
  Result := ChildNodes['PmtId'] as IXMLPmtIdType;
end;

function TXMLCdtTrfTxInfType.Get_PmtTpInf: IXMLPmtTpInfType;
begin
  Result := ChildNodes['PmtTpInf'] as IXMLPmtTpInfType;
end;

function TXMLCdtTrfTxInfType.Get_Amt: IXMLAmtType;
begin
  Result := ChildNodes['Amt'] as IXMLAmtType;
end;

function TXMLCdtTrfTxInfType.Get_ChrgBr: WideString;
begin
  Result := ChildNodes['ChrgBr'].Text;
end;

procedure TXMLCdtTrfTxInfType.Set_ChrgBr(Value: WideString);
begin
  ChildNodes['ChrgBr'].NodeValue := Value;
end;

function TXMLCdtTrfTxInfType.Get_CdtrAgt: IXMLCdtrAgtType;
begin
  Result := ChildNodes['CdtrAgt'] as IXMLCdtrAgtType;
end;

function TXMLCdtTrfTxInfType.Get_Cdtr: IXMLCdtrType;
begin
  Result := ChildNodes['Cdtr'] as IXMLCdtrType;
end;

function TXMLCdtTrfTxInfType.Get_CdtrAcct: IXMLCdtrAcctType;
begin
  Result := ChildNodes['CdtrAcct'] as IXMLCdtrAcctType;
end;

function TXMLCdtTrfTxInfType.Get_RmtInf: IXMLRmtInfType;
begin
  Result := ChildNodes['RmtInf'] as IXMLRmtInfType;
end;

{ TXMLCdtTrfTxInfTypeList }

function TXMLCdtTrfTxInfTypeList.Add: IXMLCdtTrfTxInfType;
begin
  Result := AddItem(-1) as IXMLCdtTrfTxInfType;
end;

function TXMLCdtTrfTxInfTypeList.Insert(const Index: Integer): IXMLCdtTrfTxInfType;
begin
  Result := AddItem(Index) as IXMLCdtTrfTxInfType;
end;

function TXMLCdtTrfTxInfTypeList.Get_Item(Index: Integer): IXMLCdtTrfTxInfType;
begin
  Result := List[Index] as IXMLCdtTrfTxInfType;
end;

{ TXMLPmtIdType }

function TXMLPmtIdType.Get_InstrId: WideString;
begin
  Result := ChildNodes['InstrId'].Text;
end;

procedure TXMLPmtIdType.Set_InstrId(Value: WideString);
begin
  ChildNodes['InstrId'].NodeValue := Value;
end;

function TXMLPmtIdType.Get_EndToEndId: WideString;
begin
  Result := ChildNodes['EndToEndId'].Text;
end;

procedure TXMLPmtIdType.Set_EndToEndId(Value: WideString);
begin
  ChildNodes['EndToEndId'].NodeValue := Value;
end;

{ TXMLAmtType }

procedure TXMLAmtType.AfterConstruction;
begin
  RegisterChildNode('InstdAmt', TXMLInstdAmtType);
  inherited;
end;

function TXMLAmtType.Get_InstdAmt: IXMLInstdAmtType;
begin
  Result := ChildNodes['InstdAmt'] as IXMLInstdAmtType;
end;

{ TXMLInstdAmtType }

function TXMLInstdAmtType.Get_Ccy: WideString;
begin
  Result := AttributeNodes['Ccy'].Text;
end;

procedure TXMLInstdAmtType.Set_Ccy(Value: WideString);
begin
  SetAttribute('Ccy', Value);
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

{ TXMLCdtrType }

function TXMLCdtrType.Get_Nm: WideString;
begin
  Result := ChildNodes['Nm'].Text;
end;

procedure TXMLCdtrType.Set_Nm(Value: WideString);
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

{ TXMLRmtInfType }

function TXMLRmtInfType.Get_Ustrd: WideString;
begin
  Result := ChildNodes['Ustrd'].Text;
end;

procedure TXMLRmtInfType.Set_Ustrd(Value: WideString);
begin
  ChildNodes['Ustrd'].NodeValue := Value;
end;

{ TXMLString_List }

function TXMLString_List.Add(const Value: WideString): IXMLNode;
begin
  Result := AddItem(-1);
  Result.NodeValue := Value;
end;


function TXMLString_List.Insert(const Index: Integer; const Value: WideString): IXMLNode;
begin
  Result := AddItem(Index);
  Result.NodeValue := Value;
end;


function TXMLString_List.Get_Item(Index: Integer): WideString;
begin
  Result := List[Index].NodeValue;
end;

end.
