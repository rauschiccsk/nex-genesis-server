unit CasFMHand;

interface

  uses
    SallyComUtils, //JvHidControllerClass,
    IcConv, IcTools, TxtWrap, NexPath, DateUtils, Math, SallyMsg, TxtFile, Dialogs,
    Forms, Controls, Windows, Classes, SysUtils, IdTCPConnection, IdTCPClient;

  const
    zNul    = Chr (0);
    zS      = Chr (1);
    zSTX    = Chr (2);
    zETX    = Chr (3);
    zEOT    = Chr (4);
    zENQ    = Chr (5);
    zACK    = Chr (6);
    zHT     = Chr (9);
    zNAK    = Chr (21);
    zETB    = Chr (23);
    zESC    = Chr (27);
    zCR     = Chr (13);
    zLF     = Chr (10);
    zDLE    = Chr (16);
    zRVI    = Chr (16)+Chr (64);
    zDC1    = Chr (17);
    zSOH    = Chr (13);
    zFF     = Chr (12);

    zBeg    = Chr($1C)+Chr($20);

    ptNone    = 0;
    ptParalel = 1;
    ptSerial  = 2;
    ptIP      = 3;

 ChWinToLatin2: array [128..255] of byte =    ( 128,  32,
  {130}  39,  32,  34,  32,  32,  32,  32,  32, 230,  32,
  {140} 151, 155, 166, 141,  32,  39,  39,  34,  34, 186,
  {150} 196, 196,  32,  32, 231,  32, 151, 156, 167, 141,
  {160}  32, 243, 244, 157, 207, 164,  58, 245, 249,  99,
  {170} 184, 174, 170,  32,  82, 189, 248,  32, 242, 136,
  {180} 239,  32,  32, 250, 247, 165, 173, 175, 149, 241,
  {190} 150, 190, 232, 181, 182, 198, 142, 149, 143, 128,
  {200} 172, 144, 168, 211, 183, 214, 215, 210, 209, 227,
  {210} 213, 224, 226, 138, 153, 158, 252, 222, 233, 235,
  {220} 154, 237, 221, 225, 234, 160, 131, 199, 132, 146,
  {230} 134, 135, 159, 130, 169, 137, 216, 161, 140, 212,
  {240} 208, 228, 229, 162, 147, 139, 148, 246, 253, 133,
  {250} 163, 251, 129, 236, 238, 250);


  type
    TFldData = array [1..300] of record
      ID  : string;
      Num : double;
      Str : string;
      Typ : byte;    //0-string, 1-integer, 2-double, 3- double strip zero frac, 4-date, 5-time
    end;

    TPortSet = record
      Port  : string;
      Baud  : longint;
      Parity: string;
      Data  : longint;
      Stop  : longint;
      Flag  : longint;
      ReadIntervalTimeout        : longint;
      ReadTotalTimeoutMultiplier : longint;
      ReadTotalTimeoutConstant   : longint;
      WriteTotalTimeoutMultiplier: longint;
      WriteTotalTimeoutConstant  : longint;
      Debug : boolean;
    end;

    TIPSet = record
      IPAdress: string;
      IPPort  : longint;
      IPConnectTimeout: longint;
      IPReadTimeOut   : longint;
    end;

    TPrnEscSet = record
      OpenCash : string;
      CutEsc   : string;
      BoldOn   : string;
      BoldOff  : string;
      DoubleOn : string;
      DoubleOff: string;
      DispType : string;
      LnFeedCnt: longint;
      ASCIITbl : longint;
    end;

    TPrnSet = record
      PrnType  : longint;
      PortSet  : TPortSet;
      IPSet    : TIPSet;
      PrnEscSet: TPrnEscSet;
    end;

    TExtDispSet = record
      DispUse : boolean;
      DispType: byte;
      PortSet : TPortSet;
      Mask    : string;
    end;

    TFMMasks = record
      IntDisp : string;
      Blk     : string;
      ICBlk   : string;
      ExpDoc  : string;
      IncDoc  : string;
      IncFMDoc: string;
      ChgDoc  : string;
      RepDoc  : string;
      Coins   : string;
      ICls    : string;
      XCls    : string;
      DCls    : string;
      MCls    : string;
      OrdDoc  : string;
      OutDoc  : string;
      BidDoc  : string;
    end;

    TPrintersSet = record
      FMPrn        : TPrnSet;
      FMMasks      : TFMMasks;
      ExtPrn       : array [1..3] of TPrnSet;
      ExtDisp      : TExtDispSet;
      OrdDocPrnType: longint;
      OrdDocPrn1   : longint;
      OrdDocPrn2   : longint;
      OrdDocPrn3   : longint;
      OrdDocPrn4   : longint;
      OrdSort      : longint;
      OutDocPrn    : longint;
      OutDocAutoPrn: boolean;
      BidDocPrn    : longint;
    end;

    TFMInfo = record
      Initialized: boolean;
      FMType     : string;
      FMDateTime : TDateTime;
      Version    : string;
      VatPrc     : array [1..5] of integer;
      CassaID    : string;
      Error      : boolean;
      Blocked    : boolean;
    end;

//  Ovládaè tlaèiarní: LPT, COM, IP
    TPortComHand = class
      oPortSet  : TPortSet;
      oIPSet    : TIPSet;
      oOpened   : boolean;

      constructor Create (pPortType:longint);
      destructor  Destroy; override;
      function    OpenPort:boolean;
      function    ClosePort:boolean;
      function    WriteToPort (pData:string):boolean;
      function    ReadInPortLen  (pLen:integer):string;
      function    ReadInPortETX:string;
      function    ReadInPortLF:string;
      function    ReadInPortBCScan:string;
      procedure   Delay (pMSec:longint);
      procedure   SetDefFlowControl;
      procedure   SetFlowControlOff;
    private
      oPortType  : longint;
      oPortHand  : THandle;
      oTCPClient : TIdTCPClient;
      oErr       : longint;
      oPortOpened: boolean;
      oError     : longint;
      function   GetErrorText:string;
      procedure  WritePortDebug (pStr:string);
    public
      property Opened:boolean read oOpened write oOpened;
      property Error:longint read oError write oError;
      property ErrorText:string read GetErrorText;
    end;

    TFT4000Err = record
      Blocked       : boolean;
      DisconnectMem : boolean;
      DisconnectDisp: boolean;
      DisconnectPrn : boolean;
      DispBusy      : boolean;
      PrnBusy       : boolean;
      DCloseRequired: boolean;
      DCloseRequiredShowErr: boolean;
      FullMem       : boolean;
      KeyPress      : boolean;
      CallService   : boolean;
      OpenDoc       : boolean;
      DClosePrinted : boolean;
    end;

//  Ovládanie tlaèiarne na porte COM, LPT a IP
    TSallyPrinter = class
      constructor Create (pPortComHand:TPortComHand);
      destructor  Destroy; override;

      function  PrintData (pText:string):boolean;
      function  ChangeESCCodes (pText, pBegMark, pEndMark, pBegESC, pEndESC:string):string;
    private
      oPortComHand : TPortComHand;
    end;

    TFTInfo = record
      FMDocNum  : longint;
      DCloseNum : longint;
      BValue    : array [1..5] of double;
      VatVal    : array [1..5] of double;
      ClaimVal  : double;
      DscVal    : double;
      NegVal    : double;
      RetVal    : double;
      RndP      : double;
      RndN      : double;
      TreningVal: double;
      Date      : TDate;
      Time      : TTime;
    end;

    TFTDCloseVals = record
      Date      : TDate;
      Time      : TTime;
      BValue    : array [1..5] of double;
      VatVal    : array [1..5] of double;
      VatPrc    : array [1..5] of double;
      ClaimVal  : double;
      DscVal    : double;
      NegVal    : double;
      RetVal    : double;
    end;

//  Ovládanie fiškálneho modulu FT4000
    TFMFT4000 = class
      oInfo      : TFTInfo;
      oPortComHand : TPortComHand;

      constructor Create (pPortComHand:TPortComHand);
      destructor  Destroy; override;

      function  Initialize:boolean;

      function  PrintICDocHead:boolean;

      function  PrintDocHead (pHead:string):boolean;
      function  PrintDocItem (pItem:string;pVatPrc:longint;pQnt:double;pNegItmType:string):boolean;
      function  PrintSumDoc:boolean;
      function  PrintDocPay (pFMPayNum:longint;pVal:double):boolean;
      function  PrintDocNote (pNote:string):boolean;
      function  PrintDocClose:boolean;

      function  PrintLastBlock:boolean;
      function  PrintIClose:boolean;
      function  PrintDClose:boolean;
      function  PrintMClose:boolean;

      function  PrintIntDateClose (pDateF, pDateL:TDate; pDetails:boolean):boolean;
      function  PrintIntNumClose (pNumF, pNumL:longint; pDetails:boolean):boolean;

      function  PrintIncDocHead (pHead:string):boolean;
      function  PrintIncDocPay (pFMPayNum:longint;pVal:double):boolean;
      function  PrintIncDocFoot (pFoot:string):boolean;

      function  PrintExpDocHead (pHead:string):boolean;
      function  PrintExpDocPay (pFMPayNum:longint;pVal:double):boolean;
      function  PrintExpDocFoot (pFoot:string):boolean;

      function  PrintIntDoc (pText:string):boolean;

      function  WriteToDisp (pText:string):boolean;

      function  GetDateTime:TDateTime;
      function  SetDateTime (pDateTime:TDateTime):boolean;
      function  OpenCashBox:boolean;
      function  GetFMBegValue:double;

      procedure ClearInfo;
      function  ReadInfo (pLongWait:boolean):boolean;
      function  ReadFMType:string;
      function  ReadVersion:string;
      function  ReadLastDoc:string;
      function  ReadDoc (pDClsNum,pDocNum:longint):string;
      function  ReadDClose (pDClsNum:longint):string;
      function  ReadDCloseVals (pDClsNum:longint):boolean;
      function  ReadVatList:boolean;
      function  ReadDispLen:longint;
      function  ReadCasID:string;
      function  ReadPrinterStatus (pShowErrMsg:boolean):boolean;
      function  ReadStatus:string;
      function  ReadCassaID:boolean;
    private
      oItmVal   : double;
      oDocVal   : double;
      oFMPaySchedule: boolean;
      oFT4000Err: TFT4000Err;
      oPrevDocNum: longint;

      function  GetVatSymb (pVatPrc:longint;pQnt:double):string;
      function  ReadBlockData (pCom:string):string;
      function  ReadFindData (pCom:string):string;
      function  PrinterReady:boolean;
      procedure WaitEndPrint;
      function  ChangeESCCodes (pText:string):string;
    public
      property ItmVal:double read oItmVal write oItmVal;
      property DocVal:double read oDocVal write oDocVal;
      property FMPaySchedule:boolean read oFMPaySchedule write oFMPaySchedule;
    end;

// PEGAS
    TFMPEGAS = class
      oInfo      : TFTInfo;
      oPortComHand : TPortComHand;

      constructor Create (pPortComHand:TPortComHand);
      destructor  Destroy; override;

      function  Initialize:boolean;
      function  ReadCassaID:boolean;
      procedure OpenDay;

      function  PrintLastBlock:boolean;
      function  PrintIClose:boolean;
      function  PrintDClose:boolean;
      function  PrintMClose:boolean;

      function  PrintIntDateClose (pDateF, pDateL:TDate; pDetails:boolean):boolean;
      function  PrintIntNumClose (pNumF, pNumL:longint; pDetails:boolean):boolean;

      function  PrintICDocHead:boolean;

      function  PrintDocHead (pHead:string):boolean;
      function  PrintDocItem (pItem, pGsName,pMsName:string;pVatPrc:longint;pQnt, pPrice:double;pNegItmType:string):boolean;
      function  PrintDocPay (pPayNum, pFMPayNum:longint;pVal:double):boolean;
      function  PrintDocNote (pNote:string):boolean;
      function  PrintDocClose:boolean;

      function  PrintIncDocHead (pHead:string):boolean;
      function  PrintIncDocPay (pFMPayNum:longint; pPayName:string; pVal:double):boolean;
      function  PrintIncDocFoot (pFoot:string):boolean;

      function  PrintExpDocHead (pHead:string):boolean;
      function  PrintExpDocPay (pFMPayNum:longint; pPayName:string; pVal:double):boolean;
      function  PrintExpDocFoot (pFoot:string):boolean;

      function  PrintChgDocHead (pHead:string):boolean;
      function  PrintChgDocPay (pFMPayNumI, pFMPayNumE:longint; pPayNameI,pPayNameE:string; pVal:double):boolean;
      function  PrintChgDocFoot (pFoot:string):boolean;

      function  PrintItmNote (pNote:string):boolean;

      function  ReadLastDoc:string;

      function  WriteToDisp (pText, pType:string):boolean;

      function  PrintIntDoc (pText:string):boolean;
      function  CancelDoc:boolean;

      function  GetDateTime:TDateTime;
      function  SetDateTime (pDateTime:TDateTime):boolean;
      function  OpenCashBox:boolean;

      function  GetVatSymb (pVatPrc:double):string;
      function  GetDCloseNum:longint;
      function  GetFMDocNum:longint;
      function  ReadDCloseVals:boolean;
      function  ReadDCloseData (pPrevDClsNum:longint):boolean;
      function  GetFMBegValue:double;
      function  GetStatus:string;
      function  GetLnNum:longint;
      function  GetNextBlkLnNum (pBlkLnNum: longint):longint;
      function  CutEscCharsInText (pText:string):string;
      function  ChangeESCCodes (pText:string):string;
      function  FillDoubleESCCode (pStr, pBegMark, pEndMark, pESC:string):string;
    private
      oErrCode : longint;
      oErrNAK  : longint;
      oBlkLnNum: longint;

      oItmVal   : double;
      oDocVal   : double;
      oFMPaySchedule: boolean;

      oPrevDocNum: longint;

      function  GetData (pCom:string; var pData:string):boolean;
      function  CalcBCC(pStr:string):byte;
      function  ReadEndSec:boolean;
      procedure ClearInfo;
      procedure WaitEndPrint;
      procedure ShowPegasErr (pErr:longint);
    public
      property ItmVal:double read oItmVal write oItmVal;
      property DocVal:double read oDocVal write oDocVal;
      property FMPaySchedule:boolean read oFMPaySchedule write oFMPaySchedule;
    end;

// EFOX
    TFMEFox = class
      oInfo        : TFTInfo;
      oPortComHand : TPortComHand;

      constructor Create (pPortComHand:TPortComHand);
      destructor  Destroy; override;

      function  Initialize:boolean;
      function  Connect:boolean;
      function  GetConnect:longint;
      function  Disconnect:boolean;
      function  GetPrinerState:longint;
      function  GetFiscalState:longint;
      function  GetFMType:string;
      function  GetVersion:string;
      function  GetVatList:boolean;
      function  ReadCassaID:boolean;
      function  GetDateTime:TDateTime;
      function  SetDateTime (pDateTime:TDateTime):boolean;
      function  GetFMDocNum:longint;
      function  GetDCloseNum:longint;
      function  OpenCashBox:boolean;

      function  PrintIntDoc (pText:string):boolean;
      function  PrintIntDocLn (pText:string):boolean;

      function  PrintICDocHead:boolean;
      function  PrintDocHead (pHead:string):boolean;
      function  PrintDocItem (pItem:string; pPrice, pQnt, pValue:double; pVatPrc:longint; pGsName, pMsName, pNegItmType:string):boolean;
      function  PrintDocPay (pDocVal:double; pFMPayNum:longint;pVal:double):boolean;
      function  PrintDocNote (pNote:string):boolean;
      function  PrintDocClose:boolean;

      function  PrintIncDocHead (pHead:string):boolean;
      function  PrintIncDocPay (pFMPayNum:longint;pVal:double):boolean;
      function  PrintIncDocFoot (pFoot:string):boolean;

      function  PrintExpDocHead (pHead:string):boolean;
      function  PrintExpDocPay (pFMPayNum:longint;pVal:double):boolean;
      function  PrintExpDocFoot (pFoot:string):boolean;

      function  PrintIClose:boolean;
      function  PrintDClose:boolean;
      function  PrintMClose:boolean;
      function  PrintLastBlock:boolean;

      function  PrintIntDateClose (pDateF, pDateL:TDate; pDetails:boolean):boolean;
      function  PrintIntNumClose (pNumF, pNumL:longint; pDetails:boolean):boolean;

      function  ReadLastDoc:string;
      function  GetFMBegValue:double;
      function  WriteToDisp (pText:string):boolean;
      function  ExportJournal:boolean;

      function  ReadDCloseVals:boolean;
    private
      oPrevDocNum   : longint;
      oFMPaySchedule: boolean;
      oICVat        : string;
      oBlkType      : longint;

      function  PrinterStatusVerify:boolean;
      procedure ResetPrinter;
      function  ReadInEFoxLn (pCom:string):string;
      function  ReadAnswer (pID:string):longint;
      function  GetComData (pID, pCom:string; var pErr:longint):string;
      function  SendComData (pID, pCom:string):longint;
      function  PrintBeginFiscalBlk (pBlkType:longint):boolean;
      function  PrintSaleItem (pItem:string; pPrice, pQnt, pValue:double; pVatID, pGsName, pMsName:string):boolean;
      function  PrintNegItem (pPrice, pQnt, pValue:double; pVatID, pGsName, pMsName:string):boolean;
      function  PrintDscItem (pValue:double; pVatID, pGsName:string):boolean;
      function  GetVatID (pVatPrc:longint):string;
      function  GetTotalizerValue (pVatID,pValueID:longint):double;
      function  ExportJournalData (pBinary:boolean):boolean;

      procedure ShowFMErr (pErr:string);
    public
      property FMPaySchedule:boolean read oFMPaySchedule write oFMPaySchedule;
    end;

// Ovládaè externých displejov
    TExtDispHand = class
      constructor Create (pExtDispSet:TExtDispSet);
      destructor  Destroy; override;

      function  WriteDispLn (pLn:byte; pStr:string):boolean;
      function  WriteDispBuff (pStr:string):boolean;
      function  ClearDisp:boolean;
      function  InitDisp:boolean;
      function  DispVersion:boolean;

    private
      oExtDispSet: TExtDispSet;
//      oHidDev    : TJvHidDevice;

//      function  FindHidDev (pProductID,pVendorID:word):TJvHidDevice;
    end;

//  Zberný ovládaè fiškálnych modulov a tlaèiarní
    TCasFMHand = class
      constructor Create (pPrnNum:longint;pCasFMHandSet:TPrintersSet;pRepMask:string);
      destructor  Destroy; override;

    private
      oPrnNum      : longint;
      oPrnType     : longint;
      oCasFMHandSet: TPrintersSet;
      oRepMask     : string;
      oIntDispMask : string;
      oExtDispMask : string;
      oBackupFile  : string;
      oOnLinePrn   : boolean;
      oCopies      : longint;
      oActBlk      : TStringList;
      oFullBlk     : TStringList;

      oFldData   : TFldData;
      oFldDataQnt: longint;

      oRepName   : string;

      oExtHeadUse: boolean;
      oIntHeadUse: boolean;
      oVarFootUse: boolean;
      oFixFootUse: boolean;

      oExtHead   : TStringList;
      oIntHead   : TStringList;
      oVarFoot   : TStringList;
      oFixFoot   : TStringList;
      oBlockHead : TStringList;
      oBlockItem : TStringList;
      oShortItem : TStringList;
      oSubHead   : TStringList;
      oSubFoot   : TStringList;
      oSumFoot   : TStringList;
      oInfoFoot  : TStringList;
      oBonusFoot : TStringList;
      oAppHead   : TStringList;
      oAppItem   : TStringList;
      oAppData   : TStringList;
      oItmData   : TStringList;
      oAItmData  : TStringList;

      oIntDispO  : TStringList;
      oIntDispI  : TStringList;
      oIntDispM  : TStringList;
      oIntDispE  : TStringList;
      oIntDispC  : TStringList;
      oIntDispX  : TStringList;
      oIntDispN  : TStringList;
      oIntDispP  : TStringList;

      oExtDispO  : TStringList;
      oExtDispI  : TStringList;
      oExtDispM  : TStringList;
      oExtDispE  : TStringList;
      oExtDispC  : TStringList;
      oExtDispX  : TStringList;
      oExtDispN  : TStringList;
      oExtDispP  : TStringList;

      oPrice     : double;
      oQnt       : double;
      oItmVal    : double;
      oVatPrc    : longint;
      oNegItmType: string;
      oGsName    : string;
      oGsNameID  : string;
      oMsName    : string;
      oMsNameID  : string;
      oDocVal    : double;

      oFMIncExp  : boolean;
      oFMPaySchedule: boolean;

      oPortComHand : TPortComHand;
      oSallyPrinter: TSallyPrinter;
      oFMFT4000    : TFMFT4000;
      oFMPEGAS     : TFMPEGAS;
      oFMEFox      : TFMEFox;

      oExtDisp     : TExtDispHand;
      oPrintBonusFoot: boolean;

      procedure SetIntDispMask (pValue:string);
      procedure SetExtDispMask (pValue:string);

      procedure ReadRepFile;
      procedure ReadRepName (pLn:string);
      procedure ReadExtHeadUse;
      procedure ReadIntHeadUse;
      procedure ReadBlockHead (pLn:string);
      procedure ReadBlockItem (pLn:string);
      procedure ReadShortItem (pLn:string);
      procedure ReadSubHead (pLn:string);
      procedure ReadSubFoot (pLn:string);
      procedure ReadSumFoot (pLn:string);
      procedure ReadVarFootUse;
      procedure ReadInfoFoot (pLn:string);
      procedure ReadFixFootUse;
      procedure ReadBonusFoot (pLn:string);
      procedure ReadAppnHead (pLn:string);
      procedure ReadAppItem (pLn:string);

      procedure ReadIntDisp;
      procedure ReadIntDispO (pLn:string);
      procedure ReadIntDispI (pLn:string);
      procedure ReadIntDispM (pLn:string);
      procedure ReadIntDispE (pLn:string);
      procedure ReadIntDispC (pLn:string);
      procedure ReadIntDispN (pLn:string);
      procedure ReadIntDispX (pLn:string);
      procedure ReadIntDispP (pLn:string);

      procedure ReadExtDisp;
      procedure ReadExtDispO (pLn:string);
      procedure ReadExtDispI (pLn:string);
      procedure ReadExtDispM (pLn:string);
      procedure ReadExtDispE (pLn:string);
      procedure ReadExtDispC (pLn:string);
      procedure ReadExtDispN (pLn:string);
      procedure ReadExtDispX (pLn:string);
      procedure ReadExtDispP (pLn:string);

      function  FindFldID (pID:string;var pPos:longint):boolean;
      function  GetFldID (pID:string;var pPos:longint):boolean;
      function  FillAllFld (pStr:string):string;
      function  FillAllFldASCIIConv (pStr:string):string;
      procedure FillStandFld (var pStr:string);
      procedure FillSpecFld (var pStr:string);
      procedure FillVarLenFld (var pStr:string);
      procedure ScanFldParam (pBeg:longint;pStr,pID:string;pVarFld:boolean;var pLen,pFrac:longint);
      procedure ChangeVal (pHide:boolean;pBeg,pLen,pFrac,pItm:longint;var pStr:string);
      function  DelHiddenLn (pStr:string):string;

      function  GetFldLen (pLn,pID:string):longint;

      procedure InitPrnType;
      procedure AddBlkText(pText:string);
      procedure AddBlkFreeLn (pFreeLnNum:longint);
      procedure AddBlkEsc (pEsc:string);
//      function  MyOpenPort:boolean;
//      procedure MyClosePort (pMyOpen:boolean);
      procedure OpenPort;
      procedure ClosePort;

      procedure ClearDCloseVals;
      function  GetASCIITblNum:longint;
    public
      procedure ClearFlds;
      procedure SetStrFld (pID,pVal:string);
      procedure SetIntFld (pID:string;pVal:longint);
      procedure SetDoubFld (pID:string;pVal:double);
      procedure SetSpecDoubFld (pID:string;pVal:double);
      procedure SetDateFld (pID:string;pVal:TDateTime);
      procedure SetTimeFld (pID:string;pVal:TDateTime);

      procedure SetExtHead (pS:string);
      procedure SetIntHead (pS:string);
      procedure SetVarFoot (pS:string);
      procedure SetFixFoot (pS:string);

      procedure SetPriceFld (pID:string;pVal:double);
      procedure SetQntFld (pID:string;pVal:double);
      procedure SetItmValFld (pID:string;pVal:double);
      procedure SetVatPrcFld (pID:string;pVal:longint);
      procedure SetNegItmTypeFld (pID:string;pVal:string);
      procedure SetGsNameFld (pID:string;pVal:string);
      procedure SetMsNameFld (pID:string;pVal:string);
      procedure SetDocValFld (pID:string;pVal:double);

      procedure SetPay (pNum:longint;pName:string;pPayVal:double);

      function  Initialize:boolean;
      function  ReadCassaID:boolean;
      function  GetDCloseNum:longint;

      function  PrintICDocHead:boolean;

      function  PrintDocHead:boolean;
      function  PrintDocItem:boolean;
      function  PrintSumDoc:boolean;
      function  PrintDocPay (pPayNum, pFMPayNum:longint;pVal:double):boolean;
      function  PrintDocNote:boolean;
      function  PrintDocClose:boolean;

      function  PrintIncDocHead:boolean;
      function  PrintIncDocPay (pPayNumID:string;pPayNum:longint;pFMPayNumID:string;pFMPayNum:integer;pPayNameID,pPayName,pExpValID:string;pIncVal:double):boolean;
      function  PrintIncDocFoot:boolean;

      function  PrintExpDocHead:boolean;
      function  PrintExpDocPay (pPayNumID:string;pPayNum:longint;pFMPayNumID:string;pFMPayNum:integer;pPayNameID,pPayName,pExpValID:string;pExpVal:double):boolean;
      function  PrintExpDocFoot:boolean;

      function  PrintChgDocHead:boolean;
      function  PrintChgDocPay (pExpPayNumID:string;pExpPayNum:longint;pFMExpPayNumID:string;pFMExpPayNum:integer;pExpPayNameID,pExpPayName,pIncPayNumID:string;pIncPayNum:longint;pFMIncPayNumID:string;pFMIncPayNum:integer;pIncPayNameID,pIncPayName,pValID:string;pVal:double):boolean;
      function  PrintChgDocFoot:boolean;

      function  PrintChgDocOHead:boolean;
      function  PrintChgDocOPay (pExpPayNumID:string;pExpPayNum:longint;pFMExpPayNumID:string;pFMExpPayNum:integer;pExpPayNameID,pExpPayName,pIncPayNumID:string;pIncPayNum:longint;pFMIncPayNumID:string;pFMIncPayNum:integer;pIncPayNameID,pIncPayName,pValID:string;pVal:double):boolean;
      function  PrintChgDocOFoot:boolean;

      function  PrintChgDocIHead:boolean;
      function  PrintChgDocIPay (pExpPayNumID:string;pExpPayNum:longint;pFMExpPayNumID:string;pFMExpPayNum:integer;pExpPayNameID,pExpPayName,pIncPayNumID:string;pIncPayNum:longint;pFMIncPayNumID:string;pFMIncPayNum:integer;pIncPayNameID,pIncPayName,pValID:string;pVal:double):boolean;
      function  PrintChgDocIFoot:boolean;

      procedure PrintHead;
      procedure PrintItem;
      procedure PrintSubHead;
      procedure PrintSubFoot;
      procedure PrintAppHead;
      procedure PrintAppItem;
      function  PrintFoot (pDocType:string):boolean;

//      procedure CloseDoc;
//      procedure CancelDoc;

      function  PrintIClose:boolean;
      function  PrintDClose:boolean;
      function  PrintMClose:boolean;

      function  PrintIntDateClose (pDateF, pDateL:TDate; pDetails:boolean):boolean;
      function  PrintIntNumClose (pNumF, pNumL:longint; pDetails:boolean):boolean;

      function  PrintLastBlock:boolean;

      function  ExportJournal:boolean;

      function  WriteToDispO:boolean;
      function  WriteToDispI:boolean;
      function  WriteToDispM:boolean;
      function  WriteToDispE:boolean;
      function  WriteToDispC:boolean;
      function  WriteToDispN:boolean;
      function  WriteToDispX:boolean;
      function  WriteToDispP:boolean;
      function  WriteToExtDisp (pStr:string):boolean;

      function  GetDateTime:TDateTime;
      function  SetDateTime (pDateTime:TDateTime):boolean;
      function  OpenCashBox:boolean;
      procedure OpenExtCashBox;
      function  GetFMBegValue:double;

      function  ReadLastDoc:string;

      procedure Delay (pMSec:longint);

      property IntDispMask:string read oIntDispMask write SetIntDispMask;
      property ExtDispMask:string read oExtDispMask write SetExtDispMask;
      property BackupFile:string read oBackupFile write oBackupFile;
      property OnLinePrn:boolean read oOnLinePrn write oOnLinePrn;
      property FMPaySchedule:boolean read oFMPaySchedule write oFMPaySchedule;
      property FMIncExp:boolean read oFMIncExp write oFMIncExp;
      property Copies:longint read oCopies write oCopies;
      property PrintBonusFoot:boolean read oPrintBonusFoot write oPrintBonusFoot;
    end;

//  Ovládaè snímaèa èiarového kódu
    TScanHand = class
      constructor Create (pPortSet:TPortSet);
      destructor  Destroy; override;
      function    OpenScan:boolean;
      function    CloseScan:boolean;
      function    ReadScan:string;
    private
      oPortComHand : TPortComHand;
      oErr         : longint;
      oOpened      : boolean;

    public
      property Opened:boolean read oOpened write oOpened;
    end;

    var
      gPrintersSet: TPrintersSet;
      gFMInfo     : TFMInfo;

  procedure SaveToCFile (pDoc,pPath:string;pCasNum,pIntDocQnt:longint;pDocDate:TDate;pDocTime:TTime;pDocType:string;pLocalDocQnt:longint);
  procedure SaveCFileToSD (pSDParam:TSharedDirParam; pComs:TComsDef; pLocSize:longint; pCDoc, pFileName, pCasPath:string);
  procedure SaveCFileToIPC (pIPCParam:TIPCParam; pComs:TComsDef; pType, pCDoc, pFileName, pCasPath:string; pCasNum:longint);
  function GetCFileName (pDate:TDate;pCasNum:longint):string;
  function DecodeCFileName (pName:string):TDate;
  function BCDToDoub (pData:string;pPos:longint):double;
  function BCDToDate (pData:string;pPos:longint):TDate;
  function BCDToTime (pData:string;pPos:longint):TTime;

  function Win1250ToLatin2(pStr: string):string;
  function Latin2ToWin1250(pStr: string):string;
  function ConvStrToSetASCIITbl (pS:string;pASCIITbl:longint):string;
  function DecodeStrToSetASCIITbl (pS:string;pASCIITbl:longint):string;

  function FillESCCodes (pStr, pMark, pESC:string):string;

implementation

  uses SallyUtils, IdIOHandler;

//  ***** TPortComHand *****

constructor TPortComHand.Create (pPortType:longint);
begin
  oPortType := pPortType;

  oError := 0;

  oPortSet.Port  := '';
  oPortSet.Baud  := 0;
  oPortSet.Parity:= '';
  oPortSet.Data  := 0;
  oPortSet.Stop  := 0;
  oPortSet.Flag  := 0;
  oPortSet.ReadIntervalTimeout        := 0;
  oPortSet.ReadTotalTimeoutMultiplier := 0;
  oPortSet.ReadTotalTimeoutConstant   := 0;
  oPortSet.WriteTotalTimeoutMultiplier:= 0;
  oPortSet.WriteTotalTimeoutConstant  := 0;

  oIPSet.IPAdress := '';
  oIPSet.IPPort   := 0;
  oIPSet.IPConnectTimeout := 0;
  oIPSet.IPReadTimeOut    := 0;

  oPortHand := 0;
  oPortOpened := FALSE;
  oOpened := FALSE;
end;

destructor  TPortComHand.Destroy;
begin
  ClosePort;
end;

function  TPortComHand.OpenPort:boolean;
var mDCB:TDCB; mParam:string; mTO :_COMMTIMEOUTS; mExit:boolean;
begin
  Result := FALSE;
  oOpened := (oPortType=ptNone);
  If (oPortSet.Port<>'') and ((oPortType=ptSerial) or (oPortType=ptParalel)) then begin
    oPortHand := CreateFile(PChar (oPortSet.Port),GENERIC_READ or GENERIC_WRITE,0,nil,OPEN_EXISTING, 0, 0);
    oErr := GetLastError;
    Result := (oErr=0);
    WritePortDebug ('Open: '+StrInt (oPortSet.Baud,0)+','+oPortSet.Parity+','+StrInt (oPortSet.Data,0)+','+StrInt (oPortSet.Stop,0)+','+StrInt (oPortSet.Flag,0));
    If oErr<>0 then WritePortDebug ('Open error: '+StrInt (oErr,0)+' '+SysErrorMessage (oErr));
    If oErr=0 then begin
      oOpened := TRUE;
      oPortOpened := TRUE;
      If Copy (oPortSet.Port,1,3)='COM' then begin
        mParam := oPortSet.Port+':'+StrInt (oPortSet.Baud,0)+','+oPortSet.Parity+','+StrInt (oPortSet.Data,0)+','+StrInt (oPortSet.Stop,0);
        GetCommState(oPortHand,mDCB);
        BuildCommDCB (PCHar (mParam),mDCB);
        mDCB.Flags := oPortSet.Flag;
        SetCommState(oPortHand,mDCB);
        GetCommState(oPortHand,mDCB);
        // Nastavenie èasu vypršania
        GetCommTimeouts(oPortHand,mTO);
        mTO.ReadIntervalTimeout := oPortSet.ReadIntervalTimeout;
        mTO.ReadTotalTimeoutMultiplier := oPortSet.ReadTotalTimeoutMultiplier;
        mTO.ReadTotalTimeoutConstant := oPortSet.ReadTotalTimeoutConstant;
        mTO.WriteTotalTimeoutMultiplier := oPortSet.WriteTotalTimeoutMultiplier;
        mTO.WriteTotalTimeoutConstant := oPortSet.WriteTotalTimeoutConstant;
        SetCommTimeouts(oPortHand,mTO);
      end;
    end else ShowMsgErr('Port_OpenPortError',StrInt (oErr,0)+','+ErrorText+','+oPortSet.Port);
  end;

  If (oIPSet.IPAdress<>'') and (oPortType=ptIP) then begin
    oOpened := TRUE;
    oTCPClient := TIdTCPClient.Create;
    oTCPClient.Host := oIPSet.IPAdress;
    oTCPClient.Port := oIPSet.IPPort;
    oTCPClient.ConnectTimeout := oIPSet.IPConnectTimeout;
    oTCPClient.ReadTimeout := oIPSet.IPReadTimeOut;
    mExit := FALSE;
    Repeat
      try
        oTCPClient.Connect;
        Result := TRUE;
      except end;
      mExit := oTCPClient.Connected;
      If not mExit then mExit := ShowAskWarn('PrnHand_IPPrnNotConnected', oTCPClient.Host+','+StrInt (oTCPClient.Port, 0))=mrNo;
    until mExit;
  end;
end;

function    TPortComHand.ClosePort:boolean;
begin
  If oOpened then begin
    If (oPortHand<>0) and ((oPortType=ptSerial) or (oPortType=ptParalel)) then begin
      try CloseHandle (oPortHand); except end;
      oErr := GetLastError;
      WritePortDebug ('Close');
      If oErr<>0 then WritePortDebug ('Close error: '+StrInt (oErr,0)+' '+SysErrorMessage (oErr));
    end;
    If (oTCPClient<>nil) and (oPortType=ptIP) then begin
      try
        If oTCPClient.Connected then oTCPClient.Disconnect;
      except end;
    end;
    oOpened := FALSE;
  end;
end;

function    TPortComHand.WriteToPort (pData:string):boolean;
var I:longint; mWN:cardinal; mS:string;
  mPCh:array [1..500000] of char;
begin
  For I:=1 to 500000 do
    mPCh[I] := #0;
  For I:=1 to Length (pData) do
    mPCh[I] := pData[I];
  Result := WriteFile(oPortHand, mPCh, Length (pData),mWN,nil);
  Result := (Length (pData)=mWN);
  WritePortDebug ('Write: '+pData);
  If not Result then begin
    oErr := GetLastError;
    If oErr<>0 then begin
      WritePortDebug ('Write error: '+StrInt (oErr,0)+' '+SysErrorMessage (oErr));
      ShowMsgErr('Port_WriteError',StrInt (oErr,0)+','+ErrorText+','+oPortSet.Port);
    end;
  end;
end;

function   TPortComHand.ReadInPortLen  (pLen:integer):string;
var mStr :array [1..500000] of char;
    I:longint; mLp:LongWord;
begin
  Result := '';
  If ReadFile(oPortHand,mStr,pLen,mLP,nil) then begin
    If mLP>0 then begin
      For I:=1 to mLP do
        Result := Result+mStr[I];
    end;
    WritePortDebug ('Read: '+Result);
  end else begin
    oErr := GetLastError;
    If oErr<>0 then WritePortDebug ('Read error: '+StrInt (oErr,0)+' '+SysErrorMessage (oErr));
    ShowMsgErr('Port_ReadError',StrInt (oErr,0)+','+ErrorText+','+oPortSet.Port);
  end;
end;

function  TPortComHand.ReadInPortETX:string;
var mChar:char; I:longint; mLp:LongWord; mEnd:boolean; mAllData:string;
begin
  Result := ''; mAllData := '';
  Repeat
    If ReadFile(oPortHand,mChar,1,mLP,nil) then begin
      If mLP=1 then begin
        mAllData := mAllData+mChar;
        mEnd := (mChar=zETX);
        If not mEnd then Result := Result+mChar;
      end else Application.ProcessMessages;
    end else begin
      oErr := GetLastError;
      ShowMsgErr('Port_ReadError',StrInt (oErr,0)+','+ErrorText+','+oPortSet.Port);
    end;
  until mEnd or (mLP=0) or (oErr<>0);
  If Result<>'' then WritePortDebug ('Read: '+mAllData);
  If oErr<>0 then WritePortDebug ('Read error: '+StrInt (oErr,0)+' '+SysErrorMessage (oErr));
end;

function  TPortComHand.ReadInPortLF:string;
var mChar:char; I:longint; mLp:LongWord; mEnd:boolean; mAllData:string; mTime:TDateTime;
begin
  Result := ''; mAllData := '';
  mTime := IncMilliSecond (Now, 10000);
  Repeat
    If ReadFile(oPortHand, mChar, 1, mLP, nil) then begin
      If mLP=1 then begin
        mAllData := mAllData+mChar;
        mEnd := (mChar=zLF);
        If not mEnd then Result := Result+mChar;
      end else Application.ProcessMessages;
      If Result='' then begin
        mEnd := (mTime<Now);
        If not mEnd then Wait(5);
      end else mEnd := (mLP=0);
    end else begin
      oErr := GetLastError;
      ShowMsgErr('Port_ReadError',StrInt (oErr,0)+','+ErrorText+','+oPortSet.Port);
    end;
  until mEnd or (oErr<>0);
  If Result<>'' then WritePortDebug ('Read: '+mAllData);
  If oErr<>0 then WritePortDebug ('Read error: '+StrInt (oErr,0)+' '+SysErrorMessage (oErr));
end;

(*
function    TPortComHand.ReadInPortCR:string;
var mCh:string;
begin
  Result := '';
  Repeat
    mCh := ReadInPortLen (1);
    If (oErr=0) and (mCh<>'') then begin
      If mCh[1]<>zCR then Result := Result+mCh;
    end;
  until (mCh='') or (mCh=zCR);
end;
*)

function    TPortComHand.ReadInPortBCScan:string;
var mChar:char; I:longint; mLp:LongWord; mEnd:boolean; mAllData:string;
begin
  Result := ''; mAllData := '';
  Repeat
    If ReadFile(oPortHand,mChar,1,mLP,nil) then begin
      If mLP=1 then begin
        mAllData := mAllData+mChar;
        mEnd := (mChar=zCR);
        If (mChar<>zCR) and (mChar<>zLF) then Result := Result+mChar;
      end;
    end else begin
      oErr := GetLastError;
      ShowMsgErr('Port_ReadError',StrInt (oErr,0)+','+ErrorText+','+oPortSet.Port);
    end;
  until mEnd or (mLP=0) or (oErr<>0);
  If Result<>'' then WritePortDebug ('Read: '+mAllData);
  If oErr<>0 then WritePortDebug ('Read error: '+StrInt (oErr,0)+' '+SysErrorMessage (oErr));
end;

procedure   TPortComHand.Delay (pMSec:longint);
var mTime:TDateTime;
begin
  mTime  :=  IncMilliSecond (Now,pMSec);
  Repeat
    Application.ProcessMessages;
  until Now>=mTime;
end;

procedure  TPortComHand.SetDefFlowControl;
var mDCB:TDCB;
begin
  GetCommState(oPortHand,mDCB);
  mDCB.Flags := oPortSet.Flag;
  SetCommState(oPortHand,mDCB);
end;

procedure  TPortComHand.SetFlowControlOff;
var mDCB:TDCB; mFlag:longint;
begin
  mFlag := oPortSet.Flag;
  If mFlag and 4 = 4 then mFlag := mFlag-4;
  If mFlag and 8 = 8 then mFlag := mFlag-8;
  If mFlag and 16 = 16 then mFlag := mFlag-16;
  If mFlag and 32 = 32 then mFlag := mFlag-32;
  If mFlag and 4096 = 4096 then mFlag := mFlag-4096;
  If mFlag and 8192 = 8192 then mFlag := mFlag-8192;
  GetCommState(oPortHand,mDCB);
  mDCB.Flags := mFlag;
  SetCommState(oPortHand,mDCB);
end;

function   TPortComHand.GetErrorText:string;
begin
  Result := '';
  If oErr<>0 then Result := SysErrorMessage (oErr);
end;

procedure  TPortComHand.WritePortDebug (pStr:string);
var mT:TextFile; mErr:longint;mDate:string;
begin
  If oPortSet.Debug then begin
    If OpenTxtFileWrite(mT,gPath.SysPath+'p'+oPortSet.Port+'.debug',mErr) then begin
      mDate := FormatDateTime('dd.mm.yyyy hh:mm:ss,zzz',Now);
      WriteLnTxtFile(mT,mDate+' '+pStr,mErr);
      CloseTxtFile(mT,mErr);
    end;
  end;
end;

//  Ovládanie tlaèiarne na porte COM, LPT a IP
constructor TSallyPrinter.Create (pPortComHand:TPortComHand);
begin
  oPortComHand := pPortComHand;
end;

destructor  TSallyPrinter.Destroy;
begin
end;

function   TSallyPrinter.PrintData (pText:string):boolean;
begin
  Result := FALSE;
  case oPortComHand.oPortType of
    1,2 : Result := oPortComHand.WriteToPort(pText);
    3   : If oPortComHand.oTCPClient.Connected then begin
//            oPortComHand.oTCPClient.IOHandler.DefStringEncoding
//            oPortComHand.oTCPClient.IOHandler.DefAnsiEncoding
            oPortComHand.oTCPClient.IOHandler.Write(pText);
            Result := TRUE;
          end;
  end;
end;

function  TSallyPrinter.ChangeESCCodes (pText, pBegMark, pEndMark, pBegESC, pEndESC:string):string;
var mSList:TStringList; I:longint; mS:string;
begin
  Result := '';
  If pText<>'' then begin
    mSList := TStringList.Create;
    mSList.Text := pText;
    For I:=0 to mSList.Count-1 do begin
      mS := mSList.Strings[I];
      mS := FillESCCodes (mS, pBegMark, pBegESC);
      mS := FillESCCodes (mS, pEndMark, pEndESC);
      mSList.Strings[I] := mS;
    end;
    Result := mSList.Text;
    FreeAndNil (mSList);
  end;
end;

//  Ovládanie fiškálneho modulu FT4000
constructor TFMFT4000.Create (pPortComHand:TPortComHand);
begin
  oFMPaySchedule := FALSE;
  oPortComHand := pPortComHand;
  oPrevDocNum := 0;
end;

destructor  TFMFT4000.Destroy;
begin
end;

function  TFMFT4000.Initialize:boolean;
var mS:string; I:longint; mNow:TDateTime;
begin
  Result := FALSE;
  gFMInfo.Initialized := FALSE;
  gFMInfo.FMDateTime := 0;
  gFMInfo.Error := FALSE;
  gFMInfo.FMType := '';
  gFMInfo.Version := '';
  For I:=1 to 5 do
    gFMInfo.VatPrc[I] := 0;
  If ReadPrinterStatus (TRUE) then begin
    gFMInfo.Error := oFT4000Err.Blocked or oFT4000Err.DisconnectMem or oFT4000Err.DisconnectDisp
                     or oFT4000Err.DisconnectPrn or oFT4000Err.PrnBusy //or oFT4000Err.DispBusy
                      or oFT4000Err.FullMem; //or oFT4000Err.DCloseRequired
    If not gFMInfo.Error then begin
      mS := ReadFMType;
      If mS<>'' then begin
        gFMInfo.FMType := mS;
        mS := ReadVersion;
        If mS<>'' then begin
          gFMInfo.Version := mS;
          If ReadVatList then begin
            If ReadCassaID then begin
              If ReadInfo(FALSE) then begin
                gFMInfo.FMDateTime := oInfo.Date+oInfo.Time;
                gCasGlobVals.FMDocQnt := oInfo.FMDocNum;
                gCasGlobVals.DDocQnt := oInfo.FMDocNum;
                mNow := Now;
                If Abs (gFMInfo.FMDateTime-mNow)>StrToTime ('0:10:00') then ShowMsgInf('Cas_DifferentFMTime',DateTimeToStr (gFMInfo.FMDateTime)+','+DateTimeToStr (mNow));
                gFMInfo.Initialized := TRUE;
                Result := TRUE;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

function   TFMFT4000.GetVatSymb (pVatPrc:longint;pQnt:double):string;
begin
  Result := '1';
  If pQnt<0 then begin
    If gFMInfo.VatPrc[5]=pVatPrc then Result := '9';
    If gFMInfo.VatPrc[4]=pVatPrc then Result := '8';
    If gFMInfo.VatPrc[3]=pVatPrc then Result := '6';
    If gFMInfo.VatPrc[2]=pVatPrc then Result := '5';
    If gFMInfo.VatPrc[1]=pVatPrc then Result := '4';
  end else begin
    If gFMInfo.VatPrc[5]=pVatPrc then Result := '0';
    If gFMInfo.VatPrc[4]=pVatPrc then Result := '7';
    If gFMInfo.VatPrc[3]=pVatPrc then Result := '3';
    If gFMInfo.VatPrc[2]=pVatPrc then Result := '2';
    If gFMInfo.VatPrc[1]=pVatPrc then Result := '1';
  end;
end;

function   TFMFT4000.ReadBlockData (pCom:string):string;
var mS:string; mLen:word; mB: array [1..2] of char;
begin
  Result := '';
  If oPortComHand.WriteToPort(pCom) then begin
    mS := oPortComHand.ReadInPortLen(2);
    If Length (mS)=2 then begin
      mB[1] := mS[2];
      mB[2] := mS[1];
      Move (mB,mLen,2);
      mS := oPortComHand.ReadInPortLen(mLen);
      If Length (mS)=mLen then Result := mS;
    end;
  end;
end;

function   TFMFT4000.ReadFindData (pCom:string):string;
var mS:string; mLen:word; mB: array [1..2] of char;
begin
  Result := '';
  If oPortComHand.WriteToPort(pCom) then begin
    mS := oPortComHand.ReadInPortLen(1);
    If mS=zACK then begin
      mS := oPortComHand.ReadInPortLen(2);
      If Length (mS)=2 then begin
        mB[1] := mS[2];
        mB[2] := mS[1];
        Move (mB,mLen,2);
        mS := oPortComHand.ReadInPortLen(mLen);
        If Length (mS)=mLen then Result := mS;
      end;
    end;
  end;
end;

function   TFMFT4000.PrinterReady:boolean;
var mTimeOut:boolean; mTime:TDateTime; mOK:boolean;
begin
  mTime := IncMilliSecond (Now,5000);
  Repeat
    mOK := ReadPrinterStatus (FALSE);
    mTimeOut := (mTime<Now);
    If not mOK then oPortComHand.Delay(50);
  until (not oFT4000Err.PrnBusy and mOK) or mTimeOut;
  Result := not mTimeOut;
end;

procedure  TFMFT4000.WaitEndPrint;
var mTimeOut, mRetry:boolean; mTime:TDateTime; mOK:boolean;
begin
  Repeat
    mTime := IncMilliSecond (Now,5000);
    oPortComHand.Delay(100);
    Repeat
      mOK := ReadPrinterStatus (FALSE);
      mTimeOut := (mTime<Now);
      If not mOK then oPortComHand.Delay(50);
    until (not oFT4000Err.OpenDoc and mOK) or mTimeOut;
    If not oFT4000Err.OpenDoc and mOK
      then mRetry := FALSE
      else begin
        mRetry := not ReadPrinterStatus (TRUE);
        If mRetry then mRetry := ShowAskErr('Cas_FMErrorRetry', '', [mbAbort, mbRetry])=mrRetry;
      end;
  until not mRetry;
end;

function  TFMFT4000.ChangeESCCodes (pText:string):string;
var mSList:TStringList; I:longint; mS:string;
begin
  Result := '';
  If pText<>'' then begin
    mSList := TStringList.Create;
    mSList.Text := pText;
    For I:=0 to mSList.Count-1 do begin
      mS := mSList.Strings[I];
      mS := FillESCCodes (mS, '{', '^H');
      mS := FillESCCodes (mS, '}', '^N');
      mS := FillESCCodes (mS, '[', '^B');
      mS := FillESCCodes (mS, ']', '^N');
      mSList.Strings[I] := mS;
    end;
    Result := mSList.Text;
    FreeAndNil (mSList);
  end;
end;

function  TFMFT4000.PrintICDocHead:boolean;
begin
  Result := FALSE;
  If ReadInfo(FALSE) then begin
    oPrevDocNum := oInfo.FMDocNum;
    gCasGlobVals.FMDocQnt := oInfo.FMDocNum;
    gCasGlobVals.DDocQnt := oInfo.FMDocNum;
    Result := oPortComHand.WriteToPort(zESC+'B');
  end;
end;

function  TFMFT4000.PrintDocHead (pHead:string):boolean;
begin
  Result := FALSE;
  If ReadInfo(FALSE) then begin
    oPrevDocNum := oInfo.FMDocNum;
    gCasGlobVals.FMDocQnt := oInfo.FMDocNum;
    gCasGlobVals.DDocQnt := oInfo.FMDocNum;
    Result := oPortComHand.WriteToPort(zESC+'b');
    If Result and (pHead<>'') then begin
      Result := oPortComHand.WriteToPort(pHead);
  ///    oPortComHand.Delay(250);
    end;
  end;
end;

function  TFMFT4000.PrintDocItem (pItem:string;pVatPrc:longint;pQnt:double;pNegItmType:string):boolean;
var mVat,mS:string; mPos:longint;
begin
  Result := FALSE;
  If PrinterReady then begin
    mPos := Length (pItem);
    If pItem<>'' then begin
      If Pos ('«',pItem)>0
        then mPos := Pos ('«',pItem)
        else mPos := Length (pItem)-2;
      pItem := ReplaceStr(pItem,'«','');
    end;
    mVat := GetVatSymb (pVatPrc,pQnt);
    If pNegItmType='C' then mVat := mVat+'A';
    If pNegItmType='D' then mVat := mVat+'B';
    If pNegItmType='N' then mVat := mVat+'C';
    If pNegItmType='S' then mVat := mVat+'D';
    mS := zESC+mVat+' '+StrDoub (oItmVal,10,2);
    Insert (mS,pItem,mPos);
    Result := oPortComHand.WriteToPort(pItem);
///    oPortComHand.Delay(50);
  end;
end;

function   TFMFT4000.PrintSumDoc:boolean;
begin
  Result := FALSE;
  If PrinterReady then begin
    Result := oPortComHand.WriteToPort (zESC+'k'+StrDoub (oDocVal,0,2)+' '+zCR+zLF);
  end;
end;

function   TFMFT4000.PrintDocPay (pFMPayNum:longint;pVal:double):boolean;
var mPay:string;
begin
  Result := TRUE;
  If PrinterReady then begin
    If oFMPaySchedule then begin
      If not (pFMPayNum in [1..10])  then pFMPayNum := 1;
      mPay := Chr (48+pFMPayNum);
      If PrinterReady then begin
        Result := oPortComHand.WriteToPort (zESC+'P'+mPay+' '+StrDoub (pVal,0,2)+zCR+zLF);
///        oPortComHand.Delay(30);
      end;
    end;
  end;
end;

function   TFMFT4000.PrintDocNote (pNote:string):boolean;
begin
  Result := FALSE;
  If PrinterReady then begin
    Result := oPortComHand.WriteToPort(pNote);
  end;
end;

function   TFMFT4000.PrintDocClose:boolean;
begin
  Result := FALSE;
  If PrinterReady then begin
    If oPortComHand.WriteToPort(zESC+'e') then begin
      WaitEndPrint;
      If gFMInfo.CassaID<>'' then begin
        If ReadInfo(FALSE) then begin
          Result := (oPrevDocNum<>oInfo.FMDocNum) and (oInfo.FMDocNum>0);
          gCasGlobVals.FMDocQnt := oInfo.FMDocNum;
          gCasGlobVals.DDocQnt := oInfo.FMDocNum;
        end;
      end else Result := TRUE;
    end;
  end;
end;

function  TFMFT4000.PrintLastBlock:boolean;
begin
  Result := oPortComHand.WriteToPort(zESC+'c');
end;

function   TFMFT4000.PrintIClose:boolean;
begin
  Result := oPortComHand.WriteToPort(zESC+'x');
end;

function   TFMFT4000.PrintDClose:boolean;
begin
  Result := oPortComHand.WriteToPort(zESC+'d');
end;

function  TFMFT4000.PrintMClose:boolean;
begin
  Result := oPortComHand.WriteToPort(zESC+'m');
end;

function  TFMFT4000.PrintIntDateClose (pDateF, pDateL:TDate; pDetails:boolean):boolean;
var mD,mM,mY:word; mDateS1, mDateS2:string;
begin
  DecodeDate(pDateF, mY, mM, mD);
  mDateS1 := StrInt (mY, 4)+StrIntZero (mM, 2)+StrIntZero (mD, 2);
  DecodeDate(pDateL, mY, mM, mD);
  mDateS2 := StrInt (mY, 4)+StrIntZero (mM, 2)+StrIntZero (mD, 2);
  If pDetails
    then Result := oPortComHand.WriteToPort(zESC+'Xd'+mDateS1+zCR+mDateS2+zCR)
    else Result := oPortComHand.WriteToPort(zESC+'XM'+mDateS1+zCR+mDateS2+zCR);
end;

function  TFMFT4000.PrintIntNumClose (pNumF, pNumL:longint; pDetails:boolean):boolean;
begin
  If pDetails
    then Result := oPortComHand.WriteToPort(zESC+'XP'+StrIntZero (pNumF, 3)+zCR+StrIntZero (pNumL, 3)+zCR)
    else Result := oPortComHand.WriteToPort(zESC+'XS'+StrIntZero (pNumF, 3)+zCR+StrIntZero (pNumL, 3)+zCR);
end;

function  TFMFT4000.PrintIncDocHead (pHead:string):boolean;
begin
  If ReadInfo(FALSE) then begin
    oPrevDocNum := oInfo.FMDocNum;
    gCasGlobVals.FMDocQnt := oInfo.FMDocNum;
    gCasGlobVals.DDocQnt := oInfo.FMDocNum;
    If PrinterReady then begin
      Result := oPortComHand.WriteToPort(zESC+'V');
      If Result then Result := oPortComHand.WriteToPort(pHead);
    end;
  end;
end;

function   TFMFT4000.PrintIncDocPay (pFMPayNum:longint;pVal:double):boolean;
var mPayChar:string;
begin
  mPayChar := '1';
  If pFMPayNum in [1..10] then mPayChar := Char (48+pFMPayNum);
  Result := oPortComHand.WriteToPort(zESC+'P'+mPayChar+' '+StrDoub (pVal,0,2)+zCR+zLF);
end;

function   TFMFT4000.PrintIncDocFoot (pFoot:string):boolean;
begin
  Result:= FALSE;
  If oPortComHand.WriteToPort(pFoot) then begin
    If oPortComHand.WriteToPort(zESC+'e') then begin
      WaitEndPrint;
      If ReadInfo(FALSE) then begin
        Result :=  oPrevDocNum<>oInfo.FMDocNum;
      end;
    end;
  end;
end;

function   TFMFT4000.PrintExpDocHead (pHead:string):boolean;
begin
  If ReadInfo(FALSE) then begin
    oPrevDocNum := oInfo.FMDocNum;
    gCasGlobVals.FMDocQnt := oInfo.FMDocNum;
    gCasGlobVals.DDocQnt := oInfo.FMDocNum;
    If PrinterReady then begin
      Result := oPortComHand.WriteToPort(zESC+'v');
      If Result then Result := oPortComHand.WriteToPort(pHead);
    end;
  end;
end;

function   TFMFT4000.PrintExpDocPay (pFMPayNum:longint;pVal:double):boolean;
var mPayChar:string;
begin
  mPayChar := '1';
  If pFMPayNum in [1..10] then mPayChar := Char (48+pFMPayNum);
  Result := oPortComHand.WriteToPort(zESC+'P'+mPayChar+' '+StrDoub (pVal,0,2)+zCR+zLF);
end;

function   TFMFT4000.PrintExpDocFoot (pFoot:string):boolean;
begin
  Result := oPortComHand.WriteToPort(pFoot);
  If Result then begin
    If oPortComHand.WriteToPort(zESC+'e') then begin
      WaitEndPrint;
      If ReadInfo(FALSE) then begin
        Result :=  oPrevDocNum<>oInfo.FMDocNum;
      end;
    end;
  end;
end;

function   TFMFT4000.PrintIntDoc (pText:string):boolean;
begin
  Result := oPortComHand.WriteToPort(zESC+'n');
  If Result then Result := oPortComHand.WriteToPort(pText);
  If Result then Result := oPortComHand.WriteToPort(zFF);
end;

function   TFMFT4000.WriteToDisp (pText:string):boolean;
begin
  Result := oPortComHand.WriteToPort(zESC+'>'+pText+zETX);
end;

function  TFMFT4000.GetDateTime:TDateTime;
var mTime:TDateTime; mS:string; mSList:TStringList;
begin
  Result := 0;
  If oPortComHand.WriteToPort(zESC+'I') then begin
    mTime := IncMilliSecond (Now,1000);
    Repeat
      mS := oPortComHand.ReadInPortETX;
    until (mS<>'') or (mTime<Now);
  end;
  If mS<>'' then begin
    mSList := TStringList.Create;
    mSList.Text := mS;
    If mSList.Count>=22 then begin
      try
        Result := StrToDate (mSList.Strings[20]);
      except Result := 0; end;
      If Result>0 then begin
        try
          Result := Result+StrToTime (mSList.Strings[21]);
        except Result := 0; end;
      end;
    end;
  end;
end;

function  TFMFT4000.SetDateTime (pDateTime:TDateTime):boolean;
var mDateS, mS:string;
begin
  mDateS := FormatDateTime ('ddmmyyhhnn', Now);
  mS := '6'+mDateS[2]+'7'+mDateS[1]+'8'+mDateS[4]+'9'+mDateS[3]+':'+mDateS[6]+';'+mDateS[5]
        +'4'+mDateS[8]+'5'+mDateS[7]+'2'+mDateS[10]+'3'+mDateS[9];
  Result := oPortComHand.WriteToPort(zESC+'t11111'+mS+zCR);
end;

function   TFMFT4000.OpenCashBox:boolean;
begin
  Result := oPortComHand.WriteToPort(zESC+'o');
end;

function   TFMFT4000.GetFMBegValue:double;
var mS:string; mSList:TStringList;
begin
  Result := 0;
  If ReadPrinterStatus(TRUE) then begin
    mS := ReadBlockData(zESC+'!V');
    If mS<>'' then begin
      mSList := TStringList.Create;
      mSList.Text := mS;
      If mSList.Count>=6 then Result := ValDoub (mSList.Strings[3]);
      FreeAndNil (mSList);
    end;
  end;
end;

procedure  TFMFT4000.ClearInfo;
var I:longint;
begin
  oInfo.FMDocNum := 0;
  oInfo.DCloseNum := 0;
  For I:=1 to 5 do begin
    oInfo.BValue[I] := 0;
    oInfo.VatVal[I] := 0;
  end;
  oInfo.ClaimVal := 0;
  oInfo.DscVal := 0;
  oInfo.NegVal := 0;
  oInfo.RetVal := 0;
  oInfo.RndP := 0;
  oInfo.RndN := 0;
  oInfo.TreningVal := 0;
  oInfo.Date := 0;
  oInfo.Time := 0;
end;

function  TFMFT4000.ReadInfo (pLongWait:boolean):boolean;
var mSList:TStringList; mS:string; I:longint; mTime:TDateTime; mCnt:longint;
begin
  ClearInfo;
  Result := FALSE;
  If PrinterReady then begin
    mS := '';
    mCnt := 0;
    mSList := TStringList.Create;
    If oPortComHand.WriteToPort(zESC+'I') then begin
      If pLongWait
        then mTime := IncMilliSecond (Now,120000)
        else mTime := IncMilliSecond (Now,1000);
      Repeat
        mS := oPortComHand.ReadInPortETX;
      until (mS<>'') or (mTime<Now);
    end;
    If mS<>'' then begin
      mSList.Text := mS;
      If mSList.Count<22 then begin
        Inc (mCnt);
        mS := '';
      end;
    end;
    mSList.Clear;
    If mS<>'' then begin
      mSList.Text := mS;
      If mSList.Count>=22 then begin
        oInfo.FMDocNum := ValInt (mSList.Strings[1]);
        oInfo.DCloseNum := ValInt (mSList.Strings[2]);
        For I:=1 to 5 do begin
          oInfo.BValue[I] := ValDoub (mSList.Strings[I+2]);
          oInfo.VatVal[I] := ValDoub (mSList.Strings[I+14]);
        end;
        oInfo.ClaimVal := ValDoub (mSList.Strings[8]);
        oInfo.DscVal := ValDoub (mSList.Strings[9]);
        oInfo.NegVal := ValDoub (mSList.Strings[10]);
        oInfo.RetVal := ValDoub (mSList.Strings[11]);
        oInfo.RndP := ValDoub (mSList.Strings[12]);
        oInfo.RndN := ValDoub (mSList.Strings[13]);
        oInfo.TreningVal := ValDoub (mSList.Strings[14]);
        try
          oInfo.Date := StrToDate (mSList.Strings[20]);
        except end;
        try
          oInfo.Time := StrToTime (mSList.Strings[21]);
        except end;
        Result := TRUE;
      end;
    end;
    FreeAndNil (mSList);
  end;
end;

function  TFMFT4000.ReadFMType:string;
begin
  Result := '';
  If oPortComHand.WriteToPort(zESC+'i') then Result := oPortComHand.ReadInPortLen(8);
end;

function  TFMFT4000.ReadVersion:string;
var mS:string;
begin
  Result := '';
  mS := ReadBlockData(zESC+'!v');
  If Length (mS)=4 then Result := mS[1]+'.'+mS[2]+'.'+mS[3]+'.'+mS[4];
end;

function  TFMFT4000.ReadLastDoc:string;
begin
  Result := '';
  If oPortComHand.WriteToPort(zESC+'Q') then Result := oPortComHand.ReadInPortETX;
end;

function  TFMFT4000.ReadDoc (pDClsNum,pDocNum:longint):string;
begin
  Result := ReadFindData (zESC+'q'+StrInt (pDClsNum,0)+zCR+StrInt (pDocNum,0)+zCR);
end;

function  TFMFT4000.ReadDClose (pDClsNum:longint):string;
begin
  Result := ReadFindData (zESC+'q'+StrInt (pDClsNum,0)+zCR+StrInt (9999,0)+zCR);
end;

function  TFMFT4000.ReadDCloseVals (pDClsNum:longint):boolean;
var mS:string; mLen:word; mWA:array [1..2] of char; mD:double;
  I,mStart:longint; mW:word;
begin
  Result := FALSE;
  ClearCasClsVals;
  If oPortComHand.WriteToPort(zESC+'q'+StrInt (pDClsNum,0)+zCR+StrInt (8888,0)+zCR) then begin
    mS := oPortComHand.ReadInPortLen(1);
    If Length (mS)=1 then begin
      If mS[1]=zACK then begin
        mS := oPortComHand.ReadInPortLen(2);
        If Length (mS)=2 then begin
          mWA[1] := mS[2];
          mWA[2] := mS[1];
          Move (mWA,mLen,2);
          mS := oPortComHand.ReadInPortLen(mLen+2);
          gCasClsVals.ClsNum := pDClsNum;
          gCasClsVals.Date := BCDToDate (mS, 4);
          gCasClsVals.Time := BCDToTime (mS, 8);

          mStart := 21;
          For I:=0 to 11 do begin
            mD := BCDToDoub (mS,mStart+I*6);
            If I in [0..4] then begin
              gCasClsVals.BValue[I+1] := mD;
            end;
          end;

          mStart := 93;
          For I:=0 to 4 do begin
            mD := BCDToDoub (mS,mStart+I*6);
            gCasClsVals.VatVal[I+1] := mD;
          end;

          mStart := 123;
          For I:=0 to 29 do begin
            mD := BCDToDoub (mS,mStart+I*6);
          end;

          mStart := 337;
          For I:=0 to 4 do begin
            mD := Ord (mS[mStart+I]);
            gCasClsVals.VatPrc[I+1] := Round (mD);
          end;

          mStart := 373;
          mWA[1] := mS[mStart+1];
          mWA[2] := mS[mStart];
          Move (mWA,mW,2);
          gCasClsVals.DocQnt := mW-1;
          Result := TRUE;
        end;
      end;
    end;
  end;
end;

function  TFMFT4000.ReadVatList:boolean;
var mS:string; mSList:TStringList; I:longint;
begin
  For I:=1 to 5 do
    gFMInfo.VatPrc[I] := 0;
  mS := ReadBlockData(zESC+'!d');
  If mS<>'' then begin
    mSList := TStringList.Create;
    mSList.Text := mS;
    If mSList.Count=5 then begin
      Result := TRUE;
      For I:=1 to 5 do
        gFMInfo.VatPrc[I] := ValInt(mSList.Strings[I-1]);
    end;
    FreeAndNil (mSList);
  end;
end;

function  TFMFT4000.ReadDispLen:longint;
var mS:string;
begin
  mS := ReadBlockData(zESC+'!l');
  Result := 0;
  If Length (mS)=4 then begin
    Result := Ord (mS[4]);
  end;
end;

function  TFMFT4000.ReadCasID:string;
begin
  Result := ReadBlockData(zESC+'!D');
end;

function  TFMFT4000.ReadPrinterStatus (pShowErrMsg:boolean):boolean;
var mS:string; mB1,mB2:byte; mErrList:TStringList; mDCloseRequiredShowErr:boolean;
begin
  oFT4000Err.Blocked := FALSE;
  oFT4000Err.DisconnectMem := FALSE;
  oFT4000Err.DisconnectDisp := FALSE;
  oFT4000Err.DisconnectPrn := FALSE;
  oFT4000Err.DispBusy := FALSE;
  oFT4000Err.PrnBusy := FALSE;
  oFT4000Err.DCloseRequired := FALSE;
  oFT4000Err.FullMem := FALSE;
  oFT4000Err.KeyPress := FALSE;
  oFT4000Err.CallService := FALSE;
  oFT4000Err.OpenDoc := FALSE;
  oFT4000Err.DClosePrinted := FALSE;
  Result := FALSE;
//  oPortComHand.SetFlowControlOff;
  If oPortComHand.WriteToPort(zESC+zDC1) then begin
    mS := oPortComHand.ReadInPortLen(5);
    If Length (mS)=5 then begin
      If Copy (mS,1,2)='FS' then begin
        mB1 := Ord (mS[3]);
        mB2 := Ord (mS[4]);
        oFT4000Err.Blocked := ((mB1 and 192)=192);
        If not oFT4000Err.Blocked then begin
          oFT4000Err.DisconnectMem := ((mB2 and 128)=128);
          oFT4000Err.DisconnectDisp := ((mB2 and 64)=64);
          oFT4000Err.DisconnectPrn := ((mB2 and 32)=32);

          oFT4000Err.DispBusy := ((mB1 and 8)=8);
          oFT4000Err.PrnBusy := ((mB1 and 16)=16);
          oFT4000Err.DCloseRequired := ((mB1 and 64)=64);
          oFT4000Err.FullMem := ((mB1 and 1)=1);
          oFT4000Err.KeyPress := ((mB1 and 4)=4);
          oFT4000Err.CallService := ((mB1 and 2)=2);
          oFT4000Err.OpenDoc := ((mB1 and 128)=128);
          oFT4000Err.DClosePrinted := ((mB1 and 32)=32);
        end;
        Result := TRUE;
      end;
    end;
  end;
//  oPortComHand.SetDefFlowControl;
//  oFT4000Err.DispBusy := FALSE;
  If pShowErrMsg then begin
    mDCloseRequiredShowErr := oFT4000Err.DCloseRequired and oFT4000Err.DCloseRequiredShowErr;
    If oFT4000Err.DisconnectMem or oFT4000Err.DisconnectDisp or oFT4000Err.DisconnectPrn
       or oFT4000Err.DispBusy or oFT4000Err.PrnBusy or mDCloseRequiredShowErr
       or oFT4000Err.FullMem or oFT4000Err.KeyPress or oFT4000Err.CallService
       or oFT4000Err.OpenDoc or oFT4000Err.DClosePrinted then begin

      If oFT4000Err.DisconnectMem or oFT4000Err.DisconnectDisp or oFT4000Err.DisconnectPrn
                or oFT4000Err.DispBusy or oFT4000Err.PrnBusy  or oFT4000Err.FullMem or oFT4000Err.KeyPress
        then Result := FALSE
        else Result := TRUE;
      mErrList := TStringList.Create;
      mErrList.Clear;
      mErrList.Add('');
      If oFT4000Err.Blocked then mErrList.Add(GetSallyText('Cas_FMErr_Blocked'));
      If oFT4000Err.DisconnectMem then mErrList.Add(GetSallyText('Cas_FMErr_DisconnectMem'));
      If oFT4000Err.DisconnectDisp then mErrList.Add(GetSallyText('Cas_FMErr_DisconnectDisp'));
      If oFT4000Err.DisconnectPrn then mErrList.Add(GetSallyText('Cas_FMErr_DisconnectPrn'));
      If oFT4000Err.DispBusy then mErrList.Add(GetSallyText('Cas_FMErr_DispBusy'));
      If oFT4000Err.PrnBusy then mErrList.Add(GetSallyText('Cas_FMErr_PrnBusy'));
      If mDCloseRequiredShowErr then mErrList.Add(GetSallyText('Cas_FMErr_DCloseRequired'));
      If oFT4000Err.FullMem then mErrList.Add(GetSallyText('Cas_FMErr_FullMem'));
      If oFT4000Err.KeyPress then mErrList.Add(GetSallyText('Cas_FMErr_KeyPress'));
      If oFT4000Err.CallService then mErrList.Add(GetSallyText('Cas_FMErr_CallService'));
      If oFT4000Err.OpenDoc then mErrList.Add(GetSallyText('Cas_FMErr_OpenDoc'));
      If oFT4000Err.DClosePrinted then mErrList.Add(GetSallyText('Cas_FMErr_DClosePrinted'));
      ShowMsgErr ('Cas_FMError', mErrList.Text);
      FreeAndNil (mErrList);
    end;
  end;
end;

function  TFMFT4000.ReadStatus:string;
begin
  Result := '';
  If oPortComHand.WriteToPort(zESC+'!I') then Result := oPortComHand.ReadInPortLen(30);
end;

function  TFMFT4000.ReadCassaID:boolean;
var mS:String;
begin
  gFMInfo.CassaID := '';
  mS := ReadBlockData(zESC+'!D');
  Result := oPortComHand.Error=0;
  If Result then gFMInfo.CassaID := mS;
end;

//  ***** TFMPEGAS*****
constructor TFMPEGAS.Create (pPortComHand:TPortComHand);
begin
  oPortComHand := pPortComHand;
  oPrevDocNum := 0;
  oFMPaySchedule := FALSE;
end;

destructor  TFMPEGAS.Destroy;
begin
end;

function  TFMPEGAS.Initialize:boolean;
var mData, mS:string; mOK:boolean; I:longint; mNow:TDateTime;
begin
  Result := FALSE;
  ClearInfo;
  gFMInfo.Initialized := FALSE;
  gFMInfo.FMDateTime := 0;
  gFMInfo.Error := FALSE;
  gFMInfo.FMType := '';
  gFMInfo.Version := '';
  gFMInfo.CassaID := '';
  For I:=1 to 5 do
    gFMInfo.VatPrc[I] := 0;
  If GetData ('F11', mData) then begin
    gFMInfo.FMType := 'PEGAS';
    gFMInfo.Version := LineElement(mData, 7, ';');
    mOK := TRUE;
    For I:=1 to 5 do begin
      mOK := GetData ('13'+StrInt (I, 1), mData);
      If mOK then begin
        gFMInfo.VatPrc[I] := ValInt (LineElement(mData, 1, ';'));
        oInfo.BValue[I] := ValDoub (LineElement(mData, 2, ';'));
        oInfo.VatVal[I] := ValDoub (LineElement(mData, 3, ';'));
      end else Break;
    end;
    If mOK then begin
      If GetData ('E11', mData) then begin
        oInfo.DCloseNum := ValInt (LineElement(mData, 1, ';'));
        gCasGlobVals.DClsNum := oInfo.DCloseNum;
        If GetData ('E21',mData) then begin
          oInfo.FMDocNum := ValInt (LineElement(mData, 1, ';'));
          gCasGlobVals.FMDocQnt := oInfo.FMDocNum;
          gCasGlobVals.DDocQnt := oInfo.FMDocNum;
          If GetData ('1B2', mData) then begin
            oInfo.ClaimVal := ValDoub (LineElement(mData, 1, ';'));
            oInfo.RetVal := ValDoub (LineElement(mData, 3, ';'));
            If ValDoub (LineElement(mData, 8, ';'))>0
              then oInfo.RndP := ValDoub (LineElement(mData, 8, ';'))
              else oInfo.RndN := ValDoub (LineElement(mData, 8, ';'));
            If GetData ('1A2', mData) then begin
              oInfo.DscVal := ValDoub (LineElement(mData, 2, ';'))+ValDoub (LineElement(mData, 6, ';'));
              If GetData ('1D2', mData) then begin
                oInfo.NegVal := ValDoub (LineElement(mData, 4, ';'));
                If GetData ('E51',mData) then begin
                  mS := LineElement(mData,1,';');
                  oInfo.Date := StrToDate  (Copy (mS,1,2)+'.'+Copy (mS,3,2)+'.'+Copy (mS,5,4));
                  mS := LineElement(mData,2,';');
                  oInfo.Time := StrToTime  (Copy (mS,1,2)+':'+Copy (mS,3,2));
                  gFMInfo.FMDateTime := oInfo.Date+oInfo.Time;
                  mNow := Now;
                  If Abs (gFMInfo.FMDateTime-mNow)>StrToTime ('0:10:00') then ShowMsgInf('Cas_DifferentFMTime',DateTimeToStr (gFMInfo.FMDateTime)+','+DateTimeToStr (mNow));
                  If GetData ('E31', mData) then begin
                    gFMInfo.CassaID := LineElement(mData, 4, ';');
                    gFMInfo.Initialized := TRUE;
                    Result := TRUE;
                  end;
                end;
              end;
            end
          end;
        end
      end;
    end;
  end;
end;

function  TFMPEGAS.ReadCassaID:boolean;
var mData:string;
begin
  Result:= FALSE;
  gFMInfo.CassaID := '';
  If GetData ('E31', mData) then begin
    gFMInfo.CassaID := LineElement(mData, 4, ';');
    Result := TRUE;
  end;
end;

procedure TFMPEGAS.OpenDay;
var mS:string;
begin
  mS := GetStatus;
  If mS='0' then begin
    mS := zBeg+Chr($29)+'1'+zNul+zEOT;
    oPortComHand.WriteToPort (mS+Chr(CalcBCC(mS)));
    ReadEndSec;
  end;
end;

function  TFMPEGAS.PrintLastBlock:boolean;
var mS:string;
begin
  mS := zBeg+Chr($2A)+zEOT;
  oPortComHand.WriteToPort (mS+Chr(CalcBCC(mS)));
  Result := ReadEndSec;
end;

function  TFMPEGAS.PrintIClose:boolean;
var mS:string;
begin
  mS := zBeg+Chr($50)+'X'+zNul+'1'+zNul+zEOT;
  oPortComHand.WriteToPort (mS+Chr(CalcBCC(mS)));
  Result := ReadEndSec;
end;

function  TFMPEGAS.PrintDClose:boolean;
var mS:string;
begin
  mS := zBeg+Chr($50)+'Z'+zNul+'1'+zNul+zEOT;
  oPortComHand.WriteToPort (mS+Chr(CalcBCC(mS)));
  Result := ReadEndSec;
end;

function  TFMPEGAS.PrintMClose:boolean;
var mS:string; mD,mM,mY:word; mDS, mMS, mYS:string;
begin
  OpenDay;
  DecodeDate(Now, mY, mM, mD);
  mDS := StrIntZero (mD, 2);
  mMS := StrIntZero (mM, 2);
  mYS := StrInt (mY, 4);
  mS := zBeg+Chr($52)+'1'+zNul+'01'+mMS+mYS+zNul+mDS+mMS+mYS+zNul+zEOT;
  oPortComHand.WriteToPort (mS+Chr(CalcBCC(mS)));
  Result := ReadEndSec;
end;

function  TFMPEGAS.PrintIntDateClose (pDateF, pDateL:TDate; pDetails:boolean):boolean;
var mS:string; mD,mM,mY:word; mDateS1, mDateS2:string; mDetails:string;
begin
  If pDetails
    then mDetails := '0'
    else mDetails := '1';
  DecodeDate(pDateF, mY, mM, mD);
  mDateS1 := StrIntZero (mD, 2)+StrIntZero (mM, 2)+StrInt (mY, 4);
  DecodeDate(pDateL, mY, mM, mD);
  mDateS2 := StrIntZero (mD, 2)+StrIntZero (mM, 2)+StrInt (mY, 4);
  mS := zBeg+Chr($52)+mDetails+zNul+mDateS1+zNul+mDateS2+zNul+zEOT;
  oPortComHand.WriteToPort (mS+Chr(CalcBCC(mS)));
  Result := ReadEndSec;
end;

function  TFMPEGAS.PrintIntNumClose (pNumF, pNumL:longint; pDetails:boolean):boolean;
var mS:string; mDetails:string;
begin
  If pDetails
    then mDetails := '0'
    else mDetails := '1';
  mS := zBeg+Chr($53)+mDetails+zNul+StrInt (pNumF, 0)+zNul+StrInt (pNumL, 0)+zNul+zEOT;
  oPortComHand.WriteToPort (mS+Chr(CalcBCC(mS)));
  Result := ReadEndSec;
end;

function  TFMPEGAS.PrintICDocHead:boolean;
var mS:string; mStatus:string;
begin
  oDocVal := 0;
  mStatus := GetStatus;
  If mStatus='0' then OpenDay;
  If (mStatus='2') or (mStatus='3') or (mStatus='4') or (mStatus='10') or (mStatus='20') or (mStatus='32') or (mStatus='34') then CancelDoc;
  oInfo.FMDocNum := GetFMDocNum;
  oPrevDocNum := oInfo.FMDocNum;
  gCasGlobVals.FMDocQnt := oInfo.FMDocNum;
  gCasGlobVals.DDocQnt := oInfo.FMDocNum;
  mS := zBeg+Chr($20)+'0'+zNul
        +'9'+zNul                     //Úhrada FA
        +'1'+zNul                     //Typ prenosu: riadkový/blokový
        +'0'+zNul                     //Typ bloèku: kladný/záporný
        +'0'+zNul                     //Typ rekapitulácie: skrátená/plná
        +'0'+zNul+zEOT;               //grafická hlavièka: 0-6
  oPortComHand.WriteToPort (mS+Chr(CalcBCC(mS)));
  Result := ReadEndSec;
  oBlkLnNum := 0;
end;

function  TFMPEGAS.PrintDocHead (pHead:string):boolean;
var mS:string; mStatus:string;
begin
  oDocVal := 0;
  mStatus := GetStatus;
  If mStatus='0' then OpenDay;
  If (mStatus='2') or (mStatus='3') or (mStatus='4') or (mStatus='10') or (mStatus='20') or (mStatus='32') or (mStatus='34') then CancelDoc;
  oInfo.FMDocNum := GetFMDocNum;
  oPrevDocNum := oInfo.FMDocNum;
  gCasGlobVals.FMDocQnt := oInfo.FMDocNum;
  gCasGlobVals.DDocQnt := oInfo.FMDocNum;
  mS := zBeg+Chr($20)+'0'+zNul
        +'0'+zNul                     //Maloobchod/ve¾koobchod
        +'1'+zNul                     //Typ prenosu: riadkový/blokový
        +'0'+zNul                     //Typ bloèku: kladný/záporný
        +'0'+zNul                     //Typ rekapitulácie: skrátená/plná
        +'0'+zNul+zEOT;               //grafická hlavièka: 0-6
  oPortComHand.WriteToPort (mS+Chr(CalcBCC(mS)));
  Result := ReadEndSec;
  oBlkLnNum := 0;
  If Result and (pHead<>'') then Result := PrintItmNote(pHead);
end;

function  TFMPEGAS.PrintDocItem (pItem, pGsName, pMsName:string;pVatPrc:longint;pQnt, pPrice:double;pNegItmType:string):boolean;
var mVatPrc, mCom, mS, mName:string; mSList:TStringList;
begin
    mVatPrc := GetVatSymb (pVatPrc);
    If pQnt>=0 then begin
      mCom := Chr($24);
    end else begin
      If pNegItmType='C' then begin
        mCom := Chr($28);
      end else begin
        If pNegItmType='D'
          then mCom := Chr($26)
          else mCom := Chr($2D);
      end;
    end;
    mSList := TStringList.Create;
    mSList.Text := pItem;
    mName := '';
    If mSList.Count>0 then begin
      mName := mSList.Strings[0];
      mSList.Delete(0);
    end;
    If mSList.Count>0 then begin
      Result := PrintItmNote(mSList.Text);
    end else Result := TRUE;
    If Result then begin
      oBlkLnNum := GetNextBlkLnNum (oBlkLnNum);
      If pNegItmType='D' then begin
        mS := zBeg+mCom+StrInt (oBlkLnNum, 1)+zNul
        +pGsName+zNul
        +'0'+zNul
        +StrDoub (Abs (oItmVal),0,2)+zNul
        +mVatPrc+zNul+zEOT;
      end else begin
        mS := zBeg+mCom+StrInt (oBlkLnNum, 1)+zNul
        +mName+zNul
        +StrDoub (Abs (oItmVal),0,2)+zNul
        +mVatPrc+zNul
        +StripFractZero (StrDoub (pQnt,0,3))+zNul
        +StrDoub (pPrice,0,2)+zNul
        +Copy (pMsName, 1, 3)+zNul+zEOT;
      end;
      oPortComHand.WriteToPort (mS+Chr(CalcBCC(mS)));
      Result := ReadEndSec;
    end;
    FreeAndNil (mSList);
end;

function  TFMPEGAS.PrintDocPay (pPayNum, pFMPayNum:longint;pVal:double):boolean;
var mS:string; mName:string;
begin
  mName := ConvStrToSetASCIITbl (gCasSet.Pays[pPayNum].Name, gPrintersSet.FMPrn.PrnEscSet.ASCIITbl);
  If Length (mName)>10 then mName := Copy (mName,1,10);
  oBlkLnNum := GetNextBlkLnNum (oBlkLnNum);
  mS := zBeg+Chr($30)+StrInt (oBlkLnNum, 0)+zNul
  +StrInt (pFMPayNum,0)+zNul
  +StrDoub(oDocVal,0,2)+zNul
  +StrDoub(pVal,0,2)+zNul
  +'0'+zNul
  +mName+zNul+zEOT;
  oPortComHand.WriteToPort (mS+Chr(CalcBCC(mS)));
  Result := ReadEndSec;
end;

function  TFMPEGAS.PrintDocNote (pNote:string):boolean;
var mS, mStr:string; mSList:TStringList; I:longint;
begin
  mSList := TStringList.Create;
  mSList.Text := pNote;
  If mSList.Count>0 then begin
    For I:=0 to mSList.Count-1 do begin
      oBlkLnNum := GetNextBlkLnNum (oBlkLnNum);
      mStr := mSList.Strings[I];
      If Length (mStr)>40 then mStr := Copy (mStr, 1, 40);
      mS := zBeg+Chr($31)+StrInt (oBlkLnNum, 0)+zNul+mStr+zNul+zEOT;
      oPortComHand.WriteToPort (mS+Chr(CalcBCC(mS)));
      Result := ReadEndSec;
      If not Result then Break;
    end;
  end;
  FreeAndNil(mSList);
end;

function  TFMPEGAS.PrintDocClose:boolean;
var mS:string;
begin
  oBlkLnNum := GetNextBlkLnNum (oBlkLnNum);
  mS := zBeg+Chr($22)+StrInt (oBlkLnNum, 0)+zNul+'0'+zNul+zEOT;
  oPortComHand.WriteToPort (mS+Chr(CalcBCC(mS)));
  Result := ReadEndSec;
  If Result  then begin
    WaitEndPrint;
    oInfo.FMDocNum := GetFMDocNum;
    Result :=  (oPrevDocNum<>oInfo.FMDocNum) and (oInfo.FMDocNum>0);
    gCasGlobVals.FMDocQnt := oInfo.FMDocNum;
    gCasGlobVals.DDocQnt := oInfo.FMDocNum;
  end;
end;

function  TFMPEGAS.PrintIncDocHead (pHead:string):boolean;
var mS:string;
begin
  Result := FALSE;
  OpenDay;
  If CancelDoc then begin
    oInfo.FMDocNum := GetFMDocNum;
    oPrevDocNum := oInfo.FMDocNum;
    gCasGlobVals.FMDocQnt := oInfo.FMDocNum;
    gCasGlobVals.DDocQnt := oInfo.FMDocNum;
    mS := zBeg+Chr($20)+'0'+zNul
          +'5'+zNul              //Typ dokladu
          +'1'+zNul              //Typ prenosu: riadkový/blokový
          +'0'+zNul              //Typ bloèku: kladný/záporný
          +'0'+zNul              //Typ rekapitulácie: skrátená/plná
          +StrInt(0, 0)+zNul+zEOT; //grafická hlavièka: 0-6
    oPortComHand.WriteToPort (mS+Chr(CalcBCC(mS)));
    Result := ReadEndSec;
    oBlkLnNum := 0;
    If Result then Result := PrintItmNote (pHead);
  end;
end;

function  TFMPEGAS.PrintIncDocPay (pFMPayNum:longint; pPayName:string; pVal:double):boolean;
var mS:string;
begin
  oBlkLnNum := GetNextBlkLnNum (oBlkLnNum);
  mS := zBeg+Chr($2E)+StrInt (oBlkLnNum, 0)+zNul
        +ConvStrToSetASCIITbl (pPayName, gPrintersSet.FMPrn.PrnEscSet.ASCIITbl)+zNul //Popis
        +'0'+zNul                         //Typ operácie: 0-vklad/1-výber
        +StrDoub (pVal, 0, 2)+zNul        //Suma
        +StrInt (pFMPayNum, 0)+zNul+zEOT; //Èíslo platidla
  oPortComHand.WriteToPort (mS+Chr(CalcBCC(mS)));
  Result := ReadEndSec;
end;

function  TFMPEGAS.PrintIncDocFoot (pFoot:string):boolean;
var mS:string;
begin
  Result := FALSE;
  If PrintItmNote (pFoot) then begin
    oBlkLnNum := GetNextBlkLnNum (oBlkLnNum);
    mS := zBeg+Chr($22)+StrInt (oBlkLnNum, 0)+zNul+'0'+zNul+zEOT;
    oPortComHand.WriteToPort (mS+Chr(CalcBCC(mS)));
    Result := ReadEndSec;
  end;
end;

function  TFMPEGAS.PrintExpDocHead (pHead:string):boolean;
var mS:string;
begin
  Result := FALSE;
  OpenDay;
  If CancelDoc then begin
    oInfo.FMDocNum := GetFMDocNum;
    oPrevDocNum := oInfo.FMDocNum;
    gCasGlobVals.FMDocQnt := oInfo.FMDocNum;
    gCasGlobVals.DDocQnt := oInfo.FMDocNum;
    mS := zBeg+Chr($20)+'0'+zNul
          +'5'+zNul              //Typ dokladu
          +'1'+zNul              //Typ prenosu: riadkový/blokový
          +'0'+zNul              //Typ bloèku: kladný/záporný
          +'0'+zNul              //Typ rekapitulácie: skrátená/plná
          +StrInt(0, 0)+zNul+zEOT; //grafická hlavièka: 0-6
    oPortComHand.WriteToPort (mS+Chr(CalcBCC(mS)));
    Result := ReadEndSec;
    oBlkLnNum := 0;
    If Result then Result := PrintItmNote (pHead);
  end;
end;

function  TFMPEGAS.PrintExpDocPay (pFMPayNum:longint; pPayName:string; pVal:double):boolean;
var mS:string;
begin
  oBlkLnNum := GetNextBlkLnNum (oBlkLnNum);
  mS := zBeg+Chr($2E)+StrInt (oBlkLnNum, 0)+zNul
        +ConvStrToSetASCIITbl (pPayName, gPrintersSet.FMPrn.PrnEscSet.ASCIITbl)+zNul //Popis
        +'1'+zNul                         //Typ operácie: 0-vklad/1-výber
        +StrDoub (pVal, 0, 2)+zNul        //Suma
        +StrInt (pFMPayNum, 0)+zNul+zEOT; //Èíslo platidla
  oPortComHand.WriteToPort (mS+Chr(CalcBCC(mS)));
  Result := ReadEndSec;
end;

function  TFMPEGAS.PrintExpDocFoot (pFoot:string):boolean;
var mS:string;
begin
  Result := FALSE;
  If PrintItmNote (pFoot) then begin
    oBlkLnNum := GetNextBlkLnNum (oBlkLnNum);
    mS := zBeg+Chr($22)+StrInt (oBlkLnNum, 0)+zNul+'0'+zNul+zEOT;
    oPortComHand.WriteToPort (mS+Chr(CalcBCC(mS)));
    Result := ReadEndSec;
  end;
end;

function  TFMPEGAS.PrintChgDocHead (pHead:string):boolean;
var mS:string;
begin
  Result := FALSE;
  OpenDay;
  If CancelDoc then begin
    oInfo.FMDocNum := GetFMDocNum;
    oPrevDocNum := oInfo.FMDocNum;
    gCasGlobVals.FMDocQnt := oInfo.FMDocNum;
    gCasGlobVals.DDocQnt := oInfo.FMDocNum;
    mS := zBeg+Chr($20)+'0'+zNul
          +'5'+zNul              //Typ dokladu
          +'1'+zNul              //Typ prenosu: riadkový/blokový
          +'0'+zNul              //Typ bloèku: kladný/záporný
          +'0'+zNul              //Typ rekapitulácie: skrátená/plná
          +StrInt(0, 0)+zNul+zEOT; //grafická hlavièka: 0-6
    oPortComHand.WriteToPort (mS+Chr(CalcBCC(mS)));
    Result := ReadEndSec;
    oBlkLnNum := 0;
    If Result then Result := PrintItmNote (pHead);
  end;
end;

function  TFMPEGAS.PrintChgDocPay (pFMPayNumI, pFMPayNumE:longint; pPayNameI,pPayNameE:string; pVal:double):boolean;
var mS:string;
begin
  oBlkLnNum := GetNextBlkLnNum (oBlkLnNum);
  mS := zBeg+Chr($2E)+StrInt (oBlkLnNum, 0)+zNul
        +ConvStrToSetASCIITbl (GetSallyText('CasFM_PayExpID')+pPayNameE, gPrintersSet.FMPrn.PrnEscSet.ASCIITbl)+zNul                    //Popis
        +'1'+zNul                         //Typ operácie: 0-vklad/1-výber
        +StrDoub (pVal, 0, 2)+zNul        //Suma
        +StrInt (pFMPayNumE, 0)+zNul+zEOT; //Èíslo platidla
  oPortComHand.WriteToPort (mS+Chr(CalcBCC(mS)));
  Result := ReadEndSec;
  If Result then begin
    oBlkLnNum := GetNextBlkLnNum (oBlkLnNum);
    mS := zBeg+Chr($2E)+StrInt (oBlkLnNum, 0)+zNul
          +ConvStrToSetASCIITbl (GetSallyText('CasFM_PayIncID')+pPayNameI, gPrintersSet.FMPrn.PrnEscSet.ASCIITbl)+zNul                    //Popis
          +'0'+zNul                         //Typ operácie: 0-vklad/1-výber
          +StrDoub (pVal, 0, 2)+zNul        //Suma
          +StrInt (pFMPayNumI, 0)+zNul+zEOT; //Èíslo platidla
    oPortComHand.WriteToPort (mS+Chr(CalcBCC(mS)));
    Result := ReadEndSec;
  end;
end;

function  TFMPEGAS.PrintChgDocFoot (pFoot:string):boolean;
var mS:string;
begin
  Result := FALSE;
  If PrintItmNote (pFoot) then begin
    oBlkLnNum := GetNextBlkLnNum (oBlkLnNum);
    mS := zBeg+Chr($22)+StrInt (oBlkLnNum, 0)+zNul+'0'+zNul+zEOT;
    oPortComHand.WriteToPort (mS+Chr(CalcBCC(mS)));
    Result := ReadEndSec;
  end;
end;

function  TFMPEGAS.PrintItmNote (pNote:string):boolean;
var mSList:TStringList; I:longint; mS:string;
begin
  Result := TRUE;
  If pNote<>'' then begin
    mSList := TStringList.Create;
    mSList.Text := pNote;
    For I:=0 to mSList.Count-1 do begin
      oBlkLnNum := GetNextBlkLnNum (oBlkLnNum);
      mS := zBeg+Chr($32)+StrInt (oBlkLnNum, 0)+zNul+mSList.Strings[I]+zNul+zEOT;
      oPortComHand.WriteToPort (mS+Chr(CalcBCC(mS)));
      Result := ReadEndSec;
      If not Result then Break;
    end;
    FreeAndNil (mSList);
  end;
end;

function  TFMPEGAS.ReadLastDoc:string;
var mS, mSErr, mCheck:string; mEnd:boolean; mLen:longint;
begin
  Result := '';
  oErrCode := -1;
  mS := zBeg+Chr($93)+zEOT;
  oPortComHand.WriteToPort (mS+Chr(CalcBCC(mS)));
  mEnd := FALSE;
  Repeat
    mS := oPortComHand.ReadInPortLen(1);
    If mS=zEOT then begin
      mEnd := TRUE;
      oErrCode := 4;
    end;
    If mS=zNAK then begin
      oErrCode := 3;
      mSErr := oPortComHand.ReadInPortLen(1);
      If Length (mSErr)>0 then oErrNAK := Ord (mSErr[1]);
      mEnd := TRUE;
    end;
    If mS=Chr($3A) then begin
      mS := oPortComHand.ReadInPortLen(1);
      If mS<>'' then begin
        mLen := Ord (mS[1]);
        mS := oPortComHand.ReadInPortLen(mLen+1);
        mS := ReplaceStr(mS, zLF+zCR, zCR+zLF);
        mCheck := oPortComHand.ReadInPortLen(2);
        If Length (mCheck)=2 then begin
          If mCheck[1]=zETB then oPortComHand.WriteToPort (Chr($06));
          If mCheck[1]=zETX then begin
            oPortComHand.WriteToPort (zETX);
            mEnd := TRUE;
          end;
          Result := Result+mS;
        end;
      end;
    end;
    If mS='' then begin
      oErrCode := 1;
      mEnd := TRUE;
    end;
  until mEnd;
  Result := CutEscCharsInText (Result);
end;

function  TFMPEGAS.WriteToDisp (pText, pType:string):boolean;
var mS,mEsc,mType:string;
begin
  Result := FALSE;
  pText := ReplaceStr(pText, zCR+zLF, '');
  mType := LineElement (pType, 0, ',');
  mEsc := LineElement (pType, 1, ',');
  mS := zBeg+Chr($C6)+mType+zNul+mEsc+zNul+zEOT;
  oPortComHand.WriteToPort (mS+Chr(CalcBCC(mS)));
  If ReadEndSec then begin
    mS := zBeg+Chr($C5)+mType+zNul+zNul+pText+zNul+zEOT;
    oPortComHand.WriteToPort (mS+Chr(CalcBCC(mS)));
    Result := ReadEndSec;
  end;
end;

function  TFMPEGAS.PrintIntDoc (pText:string):boolean;
var mS:string; mSList:TStringList; mOK:boolean; I,mCnt:longint;
begin
  Result := FALSE;
  OpenDay;
  If CancelDoc then begin         //3
    mS := zBeg+Chr($20)+'0'+zNul+'6'+zNul+'0'+zNul+'0'+zNul+'0'+zNul+'0'+zNul+zEOT;
    oPortComHand.WriteToPort (mS+Chr(CalcBCC(mS)));
    If ReadEndSec then begin
      mSList := TStringList.Create;
      mSList.Text := pText;
      mOK := TRUE;
      mCnt := 1;
      If mSList.Count>0 then begin
        For I:=0 to mSList.Count-1 do begin
          mS := zBeg+Chr($31)+StrInt (mCnt,0)+zNul+mSList.Strings[I]+zNul+zEOT;
          oPortComHand.WriteToPort (mS+Chr(CalcBCC(mS)));
          mOK := ReadEndSec;
          If not mOK then Break;
          mCnt := GetNextBlkLnNum (mCnt);
        end;
      end;
      FreeAndNil (mSList);
      If mOK then begin
        mS := zBeg+Chr($22)+StrInt (mCnt, 0)+zNul+'0'+zNul+zEOT;
        oPortComHand.WriteToPort (mS+Chr(CalcBCC(mS)));
        Result := ReadEndSec;
      end;
    end;
    If not Result then CancelDoc;
  end;
end;

function  TFMPEGAS.CancelDoc:boolean;
var mStatus, mS:string; mLnNum, I:longint;
begin
  Result := FALSE;
  mStatus := GetStatus;
  If (mStatus<>'-') then begin
    If (mStatus<>'0') and (mStatus<>'1') then begin
      mLnNum := GetLnNum;
      If mStatus='10' then begin
        mS := zBeg+Chr($22)+StrInt (mLnNum, 0)+zNul+'0'+zNul+zEOT;
        oPortComHand.WriteToPort (mS+Chr(CalcBCC(mS)));
        Result := ReadEndSec;
      end else begin
        mS := zBeg+Chr($2B)+StrInt (mLnNum, 0)+zNul+ConvStrToSetASCIITbl ('Storno dokladu', gPrintersSet.FMPrn.PrnEscSet.ASCIITbl)+zNul+zEOT;
        oPortComHand.WriteToPort (mS+Chr(CalcBCC(mS)));
        Result := ReadEndSec;
      end;
    end else Result := TRUE;
  end;
end;

function  TFMPEGAS.GetDateTime:TDateTime;
var mData, mS:string;
begin
  Result := 0;
  If GetData ('E51', mData) then begin
    mS := LineElement(mData,1,';');
    Result := StrToDate  (Copy (mS,1,2)+'.'+Copy (mS,3,2)+'.'+Copy (mS,5,4));
    mS := LineElement(mData,2,';');
    Result := Result+StrToTime  (Copy (mS,1,2)+':'+Copy (mS,3,2));
  end;
end;

function  TFMPEGAS.SetDateTime (pDateTime:TDateTime):boolean;
var mStr:string; mD,mM,mY,mH,mN,mS, mMS:word;
begin
  DecodeDateTime(Now, mY, mM, mD, mH, mN, mS, mMS);
  mStr := zBeg+Chr($BF)+StrIntZero (mD, 2)+StrIntZero (mM, 2)+StrInt (mY, 4)+StrIntZero (mH, 2)+StrIntZero (mN, 2)+StrIntZero (mS, 2)+zNul+zEOT;
  oPortComHand.WriteToPort (mStr+Chr(CalcBCC(mStr)));
  Result := ReadEndSec;
end;

function  TFMPEGAS.OpenCashBox:boolean;
var mS, mEsc, mSS, mNS:string; mNum:byte;
begin
  Result := FALSE;
  If gPrintersSet.FMPrn.PrnEscSet.OpenCash<>'' then begin
    mEsc := '';
    mSS := gPrintersSet.FMPrn.PrnEscSet.OpenCash;
    Repeat
      If Pos (',', mSS)>0 then begin
        mNS := Copy (mSS, 1, Pos (',', mSS)-1);
        Delete (mSS, 1, Pos (',', mSS));
      end else begin
        mNS := mSS;
        mSS := '';
      end;
      If mNS<>'' then begin
        mNum := ValInt (mNS);
        mEsc := mEsc+'~'+DecToHEX(mNum, 2);
      end;
    until mSS='';
    mS := zBeg+Chr($C7)+mEsc+zNul+zEOT;
    oPortComHand.WriteToPort (mS+Chr(CalcBCC(mS)));
    Result := ReadEndSec;
  end;
end;

function  TFMPEGAS.GetVatSymb (pVatPrc:double):string;
begin
  Result := 'A';
  If pVatPrc=gFMInfo.VatPrc[5] then Result := 'E';
  If pVatPrc=gFMInfo.VatPrc[4] then Result := 'D';
  If pVatPrc=gFMInfo.VatPrc[3] then Result := 'C';
  If pVatPrc=gFMInfo.VatPrc[2] then Result := 'B';
  If pVatPrc=gFMInfo.VatPrc[1] then Result := 'A';
end;

function  TFMPEGAS.GetDCloseNum:longint;
var mData:string;
begin
  Result := -1;
  If GetData ('E11', mData) then begin
    Result := ValInt (LineElement (mData, 1, ';'));
  end;
end;

function  TFMPEGAS.GetFMDocNum:longint;
var mData:string;
begin
  Result := 0;
  If GetData ('E21', mData) then begin
    Result := ValInt (LineElement(mData, 1, ';'));
  end;
end;

function  TFMPEGAS.ReadDCloseVals:boolean;
var mData:string; I:longint;
begin
  Result := FALSE;
  ClearCasClsVals;
  If GetData ('E21', mData) then begin
    gCasClsVals.DocQnt := ValInt (LineElement (mData, 1, ';'));
    For I:=1 to 5 do begin
      If GetData ('13'+StrInt (I,1), mData) then begin
        gCasClsVals.BValue[I] := ValDoub (LineElement (mData, 2, ';'));
        gCasClsVals.VatVal[I] := ValDoub (LineElement (mData, 3, ';'));
        gCasClsVals.VatPrc[I] := ValInt (LineElement (mData, 1, ';'));
        Result := TRUE;
      end else begin
        Result := FALSE;
        Break;
      end;
    end;
  end;
end;

function  TFMPEGAS.ReadDCloseData (pPrevDClsNum:longint):boolean;
var mData, mS:string; mD,mM,mY,mH,mN:word;
begin
  Result := FALSE;
  gCasClsVals.ClsNum := GetDCloseNum-1;
  oInfo.DCloseNum := gCasClsVals.ClsNum;
  If GetData ('E81', mData) then begin
    If (pPrevDClsNum<>gCasClsVals.ClsNum) and (gCasClsVals.ClsNum>0) then begin
      If ValInt (LineElement (mData, 1, ';'))=gCasClsVals.ClsNum then begin
        mS := LineElement (mData, 2, ';');
        mD := ValInt (Copy (mS, 1, 2));
        mM := ValInt (Copy (mS, 3, 2));
        mY := ValInt (Copy (mS, 5, 4));
        mH := ValInt (Copy (mS, 9, 2));
        mN := ValInt (Copy (mS, 11, 2));
        try
          gCasClsVals.Date := EncodeDate (mY, Mm, mD);
        except end;
        try
          gCasClsVals.Time := EncodeTime (mH, mN, 0, 0);
        except end;
        Result := TRUE;
      end;
    end;
  end;
end;

function  TFMPEGAS.GetFMBegValue:double;
var mData:string;
begin
  Result := 0;
  If GetData ('1CG', mData) then begin
    Result := ValDoub (LineElement (mData, 1, ';'));
  end;
end;

function  TFMPEGAS.GetStatus:string;
var mData:string;
begin
  Result := '-';
  If GetData ('F11', mData) then begin
    Result := LineElement (mData,5,';');
  end;
end;

function  TFMPEGAS.GetLnNum:longint;
var mData:string;
begin
  Result := 0;
  If GetData ('F11', mData) then begin
    Result := ValInt (LineElement (mData, 4, ';'));
  end;
end;

function  TFMPEGAS.GetNextBlkLnNum (pBlkLnNum: longint):longint;
begin
  Result := pBlkLnNum+1;
  If Result>=10 then Result := 0;
end;

function  TFMPEGAS.CutEscCharsInText (pText:string):string;
var mPos, mLen:longint;
begin
  Result := pText;
  While Pos (#28, Result)>0 do begin
    mPos := Pos (#28, Result);
    mLen := Pos (#4+#5, Result)-mPos+2;
    If mLen>0 then Delete (Result, mPos, mLen);;
  end;
  Result := ReplaceStr (Result, #0, '');
end;

function  TFMPEGAS.ChangeESCCodes (pText:string):string;
var mSList:TStringList; I:longint; mS:string;
begin
  Result := '';
  If pText<>'' then begin
    mSList := TStringList.Create;
    mSList.Text := pText;
    For I:=0 to mSList.Count-1 do begin
      mS := mSList.Strings[I];
      mS := FillDoubleESCCode (mS, '{', '}', #31);
      mS := FillESCCodes (mS, '[', '~1B~45~01');
      mS := FillESCCodes (mS, ']', '~1B~45~00');
      mSList.Strings[I] := mS;
    end;
    Result := mSList.Text;
    FreeAndNil (mSList);
  end;
end;

function  TFMPEGAS.FillDoubleESCCode (pStr, pBegMark, pEndMark, pESC:string):string;
var mBeg, mEnd, I:longint; mS, mSubStr:string;
begin
  While (Pos (pBegMark, pStr)>0) and (Pos (pEndMark, pStr)>Pos (pBegMark, pStr)) do begin
    mBeg := Pos (pBegMark, pStr);
    mEnd := Pos (pEndMark, pStr);
    mS := Copy (pStr, mBeg+1, mEnd-mBeg-1);
    Delete (pStr, mBeg, mEnd-mBeg+1);
    mSubStr := '';
    For I:=1 to Length (mS) do
      mSubStr := mSubStr+pESC+mS[I];
    Insert (mSubStr, pStr, mBeg);
  end;
  Result := pStr;
end;

function  TFMPEGAS.GetData (pCom:string; var pData:string):boolean;
var mS,mCheck:string; mLen:byte;
begin
  oErrCode := 0; oErrNAK := 0;
  pData := '';
  Result := FALSE;
  mS := zBeg+Chr($92)+pCom+zNul+zEOT;
  If oPortComHand.WriteToPort (mS+Chr(CalcBCC(mS))) then begin
    mS := oPortComHand.ReadInPortLen(1);
    If Length (mS)>0 then begin
      If mS=':' then begin
        mS := oPortComHand.ReadInPortLen(1);
        mLen := Ord (mS[1]);
        mS := oPortComHand.ReadInPortLen(mLen+1);
        mCheck := oPortComHand.ReadInPortLen(2);
        If Length (mS)>0 then begin
          oPortComHand.WriteToPort (zETX);
          Result := TRUE;
          pData := ReplaceStr (mS,zCR+zLF,'');
        end;
      end else begin
        oErrCode := 3;
        mS := oPortComHand.ReadInPortLen(1);
        If Length (mS)>0 then oErrNAK := Ord (mS[1]);
        ShowPegasErr (oErrNAK);
      end;
    end else begin
      oErrCode := 1;
      ShowMsgErr('CasFM_TimeOut', '');
    end;
  end else begin
    oErrCode := 1;
    ShowMsgErr('CasFM_TimeOut', '');
  end;
end;

function TFMPEGAS.CalcBCC(pStr:string):byte;
var I:longint;
begin
 Result := 0;
 For I:=1 to Length (pStr) do
   Result := Result xor Ord (pStr[I]);
end;

function  TFMPEGAS.ReadEndSec:boolean;
var mS:string;
begin
  Result := FALSE;
  oErrCode := 0; oErrNAK := 0;
  mS := oPortComHand.ReadInPortLen(1);
  If mS<>'' then begin
    If mS=zNAK then begin
      oErrCode := 3;
      mS := oPortComHand.ReadInPortLen(1);
      If Length (mS)=1 then oErrNAK := Ord (mS[1]);
      ShowPegasErr (oErrNAK);
    end else begin
      If mS=zACK then begin
        Result := TRUE;
      end else begin
        oErrCode := 2;
        ShowMsgErr('CasFM_BadAnsw', '');
      end;
    end;
  end else begin
    oErrCode := 1;
    ShowMsgErr('CasFM_TimeOut', '');
  end;
end;

procedure TFMPEGAS.ClearInfo;
var I:longint;
begin
  oInfo.FMDocNum := 0;
  oInfo.DCloseNum := 0;
  For I:=1 to 5 do begin
    oInfo.BValue[I] := 0;
    oInfo.VatVal[I] := 0;
  end;
  oInfo.ClaimVal := 0;
  oInfo.DscVal := 0;
  oInfo.NegVal := 0;
  oInfo.RetVal := 0;
  oInfo.RndP := 0;
  oInfo.RndN := 0;
  oInfo.TreningVal := 0;
  oInfo.Date := 0;
  oInfo.Time := 0;
end;

procedure TFMPEGAS.WaitEndPrint;
var mData:string; mOK, mBusy:boolean;
begin
  Repeat
    mOK := GetData ('F11', mData);
    If mOK then mBusy := (LineElement (mData, 2, ';')='1');
  until not mOK or not mBusy;
end;

procedure TFMPEGAS.ShowPegasErr (pErr:longint);
var mErrStr:string;
begin
  mErrStr := '';
  If pErr>0 then mErrStr := GetSallyText('Err_PEGAS_'+StrInt (pErr, 0));
  ShowMsgErr('CasFM_ErrNAK', mErrStr+','+StrInt (pErr, 0));
end;

//  ***** TFMEFox *****

constructor TFMEFox.Create (pPortComHand:TPortComHand);
begin
  oFMPaySchedule := FALSE;
  oPortComHand := pPortComHand;
  oPrevDocNum := 0;
end;

destructor  TFMEFox.Destroy;
begin
end;

procedure TFMEFox.ResetPrinter;
begin
  SendComData('rP', '');
end;

function  TFMEFox.PrinterStatusVerify:boolean;
var mPrinterState:longint;
begin
  Result := FALSE;
  mPrinterState := GetPrinerState;
  If mPrinterState>1 then begin
    ResetPrinter;
    mPrinterState := GetPrinerState;
  end;
  Result := (mPrinterState=1);
end;

function  TFMEFox.ReadInEFoxLn (pCom:string):string;
var mS:string; mEnd:boolean;
begin
  Result := '';
  Result := oPortComHand.ReadInPortLF;
  If Result<>'' then begin
    If (LineELement (Result, 0, zHT)<>pCom) or (LineELement (Result, 1, zHT)<>'RSP')
      then Result := ''
      else begin
        Delete (Result, 1, Pos (zHT, Result));
        Delete (Result, 1, Pos (zHT, Result));
        ShowFMErr (LineElement (Result, 0, zHT));
      end;
  end;
end;

function  TFMEFox.ReadAnswer (pID:string):longint;
var mS:string;
begin
  Result := -1;
  mS := ReadInEFoxLn (pID);
  If mS<>''
    then Result := ValInt (mS)
    else Result := -2;
end;

function  TFMEFox.GetComData (pID, pCom:string; var pErr:longint):string;
var mRetry:boolean; mS:string;
begin
  If pCom<>'' then pCom := zHT+pCom;
  Repeat
    pErr := -10;
    If oPortComHand.WriteToPort(pID+zHT+'REQ'+pCom+zLF) then begin
      mS := ReadInEFoxLn (pID);
      If mS<>'' then begin
        Result := mS;
        pErr := ValInt (LineElement (mS, 0, zHT));
      end else pErr := -1;
    end else pErr := -9;
    If pErr=0
      then mRetry := FALSE
      else mRetry := ShowAskWarn('Err_EFOX_PrintRetry', '', [mbRetry, mbAbort])=mrRetry;
  until not mRetry;
  If pErr<0 then ShowMsgWarn ('Err_EFOX_NoAnswer', StrInt (pErr, 0));
end;

function  TFMEFox.SendComData (pID, pCom:string):longint;
var mS:string; mRes, mErr:longint;
begin
  mS := GetComData (pID, pCom, mRes);
  If mRes=0 then begin
    Val (mS, mRes, mErr);
    If mErr=0
      then Result := mRes
      else Result := -8;
  end else Result := mRes;
end;

function  TFMEFox.PrintBeginFiscalBlk (pBlkType:longint):boolean;
begin
  PrinterStatusVerify;
  Result := (SendComData ('bFR', StrInt (pBlkType, 0)+zHT)=0);
  If Result then oBlkType := pBlkType;
end;

function  TFMEFox.PrintSaleItem (pItem:string; pPrice, pQnt, pValue:double; pVatID, pGsName, pMsName:string):boolean;
var mCom:string;
begin
  Result := TRUE;
  If pItem<>'' then Result := PrintDocNote (pItem);
  If Result then begin
    mCom := pGsName+zHT+StrDoub (pValue, 0, 2)+zHT+StrDoub (pQnt, 0, 3)+zHT+pVatID+zHT+StrDoub (pPrice, 0, 2)+zHT+Copy (pMsName, 1, 3)+zHT+zHT;
    Result := (SendComData('pRI', mCom)=0);
  end;
end;

function  TFMEFox.PrintNegItem (pPrice, pQnt, pValue:double; pVatID, pGsName, pMsName:string):boolean;
var mCom:string;
begin
  Result := FALSE;
  pQnt := Abs (pQnt);
  pValue := Abs (pValue);
  mCom := pGsName+zHT+StrDoub (pValue, 0, 2)+zHT+StrDoub (pQnt, 0, 3)+zHT+pVatID+zHT+StrDoub (pPrice, 0, 2)+zHT+Copy (pMsName, 1, 3)+zHT+zHT;
  Result := (SendComData('pRIR', mCom)=0);
end;

function  TFMEFox.PrintDscItem (pValue:double; pVatID, pGsName:string):boolean;
var mCom:string;
begin
  Result := FALSE;
  pValue := Abs (pValue);
  mCom := '1'+zHT+pGsName+zHT+StrDoub (pValue, 0, 2)+zHT+pVatID+zHT+zHT;
  Result := (SendComData('pRIA', mCom)=0);
end;

function  TFMEFox.GetVatID (pVatPrc:longint):string;
var I:longint;
begin
  If oBlkType=5 then begin
    Result := oICVat;
  end else begin
    Result := '1';
    For I:=5 downto 1 do begin
      If gFMInfo.VatPrc[I]=pVatPrc then Result := StrInt (I, 0);
    end;
  end;
end;

function  TFMEFox.GetTotalizerValue (pVatID,pValueID:longint):double;
var mS:string ; mErr:longint;
begin
  Result := 0;
  mS := GetComData('gT', '1'+zHT+StrInt (pVatID, 0)+zHT+StrInt (pValueID, 0), mErr);
  If mErr=0 then begin
    Result := ValDoub (LineElement (mS, 1, zHT));
  end;
end;

function  TFMEFox.ExportJournalData (pBinary:boolean):boolean;
var mS, mJourType:string; mErr:longint;
begin
  Result := FALSE;
  If pBinary then mJourType := '2' else mJourType := '1';
  mErr := SendComData('eJ', mJourType+zHT+'1');
  If mErr=0 then begin
    Repeat
      mS := GetComData('oP', '', mErr);
      If mErr=0 then Result := (LineElement (mS, 1, zHT)='100');
    until Result or (mErr<>0);
    If Result then Result := (SendComData('cJ', mJourType)=0);
  end;
  If not Result then ResetPrinter;
end;

procedure TFMEFox.ShowFMErr (pErr:string);
var mErr:longint;
begin
  mErr := ValInt (pErr);
  If mErr>0 then ShowMsgWarn('Err_EFOX_'+pErr, pErr);
end;

function  TFMEFox.Initialize:boolean;
var mS:string; I:longint; mNow:TDateTime; mPrinterState, mFiscalState:longint;
begin
  Result := FALSE;
  gFMInfo.Initialized := FALSE;
  gFMInfo.FMDateTime := 0;
  gFMInfo.Error := FALSE;
  gFMInfo.FMType := '';
  gFMInfo.Version := '';
  For I:=1 to 5 do
    gFMInfo.VatPrc[I] := 0;
  If PrinterStatusVerify then begin
    mFiscalState := GetFiscalState;
    If mFiscalState in [1,2] then begin
      gFMInfo.FMType := GetFMType;
      If gFMInfo.FMType<>'' then begin
        gFMInfo.Version := GetVersion;
        If gFMInfo.Version<>'' then begin
          If GetVatList then begin
            gFMInfo.FMDateTime := GetDateTime;
            If gFMInfo.FMDateTime>0 then begin
              If ReadCassaID then begin
                oInfo.FMDocNum := GetFMDocNum;
                gCasGlobVals.FMDocQnt := oInfo.FMDocNum;
                gCasGlobVals.DDocQnt := oInfo.FMDocNum;
                oInfo.DCloseNum := GetDCloseNum;
                gCasGlobVals.DClsNum := oInfo.DCloseNum;
                mNow := Now;
                If Abs (gFMInfo.FMDateTime-mNow)>StrToTime ('0:10:00') then ShowMsgInf('Cas_DifferentFMTime',DateTimeToStr (gFMInfo.FMDateTime)+','+DateTimeToStr (mNow));
                gFMInfo.Initialized := TRUE;
                Result := TRUE;
              end;
            end;
          end;
        end;
      end;
    end else begin
      ShowMsgWarn('Err_EFOX_FiscalState', StrInt (mFiscalState, 0));
    end;
  end;
end;

function  TFMEFox.Connect:boolean;
var mS:string; mStat:longint;
begin
  Result := FALSE;
  mStat := GetConnect;
  If (mStat=0) or (mStat=301) then begin
    If mStat=301 then mStat := GetConnect;
    Result := (mStat=0);
  end;
end;

function  TFMEFox.GetConnect:longint;
begin
  Result := SendComData ('CONNECT', '');
end;

function  TFMEFox.Disconnect:boolean;
var mErr:longint;
begin
  Result := (SendComData ('DISCONNECT', '')=0);
end;

function  TFMEFox.GetPrinerState:longint;
var mS, mID, mData:string; mErr:longint;
begin
  mID := '1';
  mS := GetComData ('gP', mID, mErr);
  gFMInfo.Error := FALSE;
  Result := 0;
  If mErr=0 then begin
    If LineElement(mS, 0, zHT)='0' then begin
      If LineElement(mS, 1, zHT)=mID then begin
        mData := LineElement(mS, 2, zHT);
        Result := ValInt (mData);
        gFMInfo.Error := (Result=7);
      end else begin
        ShowMsgWarn('Err_EFOX_BadAnswer', 'ID');
      end;
    end;
  end;
(*
1 FP_PS_MONITOR
  FP sa nachádza v základnom stave, v tomto stave FP prijíma všetky jednoduché príkazy (viï. stavový diagram) a príkazy begin.... Ak TrainingModeActive = TRUE, potom sa FP používa len na tréningové úèely a prípustné sú len príkazy beginFiscalReceipt a endTraining.
2 FP_PS_FISCAL_RECEIPT
  FP práve spracováva fiskálnu úètenku (položky úètenky). V tomto stave FP akceptuje niektorý z príkazov printRec.... Ak navyše TrainingModeActive =TRUE, potom sa FP používa len na tréningové úèely.
3 FP_PS_FISCAL_RECEIPT_TOTAL
  FP už akceptoval najmenej jednu platbu, ale celý totál nákupu ešte nebol úplne splatený. V tomto stave FP akceptuje len príkazy printRecTotal, printRecMessage a printRecVoid. Ak navyše TrainingModeActive =TRUE, potom sa FP používa len na tréningové úèely.
4 FP_PS_FISCAL_RECEIPT_ENDING
  FP už skompletizoval fiskálnu úètenku (èi už úspešne alebo neúspešne) a akceptuje už len príkazy printRecMessage a endFiscalReceipt. Ak navyše TrainingModeActive =TRUE, potom sa FP používa len na tréningové úèely.
5 FP_PS_NONFISCAL
  FP práve spracováva nefiskálnu úètenku. V tomto stave akceptuje príkazy printRecNormal a endFiscalReceipt. 6 FP_PS_REPORT FP práve spracováva jednu z možných uzávierok. V tomto stave FP neakceptuje žiaden z príkazov (poèas vykonávania periodickej uzávierky FP akceptuje príkazy cancelRest a obtainProgress), až kým uzávierka nie je ukonèená
7 FP_PS_LOCKED
  FP narazil na nenávratný HW problém a autorizovaný servisný technik musí by kontaktovaný, pre opustenie tohto stavu. FP akceptuje všetky príkazy get... 8 FP_PS_PROGRESS Bol odštartovaný nejaký asynchrónny proces, ktorý beží na pozadí. V tomto stave sú prístupné len príkazy obtainProgress, cancelRest a v prípade vzniku chyby aj resetPrinter
*)
end;

function  TFMEFox.GetFiscalState:longint;
var mS, mID, mData:string; mErr:longint;
begin
  mID := '2';
  mS := GetComData ('gP', mID, mErr);
  Result := 0;
  gFMInfo.Error := FALSE;
  If mErr=0 then begin
    If LineElement(mS, 0, zHT)='0' then begin
      If LineElement(mS, 1, zHT)=mID then begin
        mData := LineElement(mS, 2, zHT);
        Result := ValInt (mData);
        gFMInfo.Error := (Result=3);
      end else begin
        ShowMsgWarn('Err_EFOX_BadAnswer', 'ID');
      end;
    end;
  end;
(*
1 FP_FS_PREFISCAL FP ešte nebol uvedený do prevádzky
2 FP_FS_FISCAL FP je uvedený do prevádzky
3 FP_FS_READONLY FP je v stave, v ktorom nie je možné vydáva fiskálne úètenky
*)
end;

function  TFMEFox.GetFMType:string;
var mS, mID:string; mErr:longint;
begin
  Result := '';
  mID := '10';
  mS :=GetComData('gP', mID, mErr);
  If mErr=0 then begin
    If LineElement(mS, 0, zHT)='0' then begin
      If LineElement(mS, 1, zHT)=mID
        then Result := LineElement(mS, 2, zHT)
        else ShowMsgWarn('Err_EFOX_BadAnswer', 'ID');
    end;
  end;
end;

function  TFMEFox.GetVersion:string;
var mS, mID:string; mErr:longint;
begin
  Result := '';
  mID := '8';
  mS :=GetComData('gP', mID, mErr);
  If mErr=0 then begin
    If LineElement(mS, 0, zHT)='0' then begin
      If LineElement(mS, 1, zHT)=mID
        then Result := LineElement(mS, 2, zHT)
        else ShowMsgWarn('Err_EFOX_BadAnswer', 'ID');
    end;
  end;
end;

function  TFMEFox.GetVatList:boolean;
var I:longint; mS, mVatID, mVatFlag:string; mVat:double; mErr:longint;
begin
  Result := TRUE;
  For I:=1 to 5 do
    gFMInfo.VatPrc[I] := 0;
  oICVat := '';
  For I:=1 to 7 do begin
    mVatID := StrInt (I, 0);
    mS :=GetComData('gVE', mVatID, mErr);
    If mErr=0 then begin
      If (LineElement(mS, 0, zHT)='0') then begin
        If (LineElement(mS, 1, zHT)=mVatID) then begin
          mVatFlag := LineElement(mS, 2, zHT);
          mVat := ValDoub(LineElement(mS, 3, zHT));
          If I in [1..5] then begin
            If mVatFlag='1'
              then gFMInfo.VatPrc[I] := Round (Int (mVat))
              else gFMInfo.VatPrc[I] := 100;
          end;
          If mVatFlag='5' then oICVat := StrInt (I, 0);
        end else begin
          Result := FALSE;
          ShowMsgWarn('Err_EFOX_BadAnswer', 'ID');
        end;
      end else Result := FALSE;
    end else Result := FALSE;
    If not Result then Break;
  end;
end;

function  TFMEFox.ReadCassaID:boolean;
var mS, mID:string; mErr:longint;
begin
  Result := FALSE;
  mID := '32';
  mS := GetComData('gD', mID+zHT+'0', mErr);
  If mErr=0 then begin
    If LineElement(mS, 0, zHT)='0' then begin
      gFMInfo.CassaID := LineElement(mS, 1, zHT);
      Result :=TRUE;
    end;
  end;
end;

function  TFMEFox.GetDateTime:TDateTime;
var mS, mData:string; mErr:longint;
begin
  Result := 0;
  mS := GetComData('gDT', '4', mErr);
  If mErr=0 then begin
    If LineElement(mS, 0, zHT)='0' then begin
      mData := LineElement(mS, 2, zHT);
      If Length (mData)=14 then begin
        try
          Result := EncodeDate(ValInt (Copy (mData, 5, 4)), ValInt (Copy (mData, 3, 2)), ValInt (Copy (mData, 1, 2)));
          Result := Result+EncodeTime(ValInt (Copy (mData, 9, 2)), ValInt (Copy (mData, 11, 2)), ValInt (Copy (mData, 13, 2)), 0);
        except Result := 0 end;
      end;
    end;
  end;
end;

function  TFMEFox.SetDateTime (pDateTime:TDateTime):boolean;
var mSS, mDateS:string; mD, mM, mY, mH, mN, mS, mMS:word;
begin
  Result := FALSE;
  DecodeDate(Date, mY, mM, mD);
  DecodeTime (Time, mH, mN, mS, mMS);
  mDateS := StrIntZero (mD, 2)+StrIntZero (mM, 2)+StrInt (mY, 4)+StrIntZero (mH, 2)+StrIntZero (mN, 2);
  SendComData('sD', mDateS);
end;

function  TFMEFox.GetFMDocNum:longint;
var mS:string; mErr:longint;
begin
  Result := -1;
  mS := GetComData('gD', '46'+zHT+'0', mErr);
  If mErr=0 then begin
    If LineElement(mS, 0, zHT)='0' then Result := ValInt (LineElement(mS, 1, zHT));
  end;
end;

function  TFMEFox.GetDCloseNum:longint;
var mS:string; mErr:longint;
begin
  Result := -1;
  mS := GetComData('gD', '75'+zHT+'0', mErr);
  If mErr=0 then begin
    If (LineElement(mS, 0, zHT)='0') then Result := ValInt (LineElement(mS, 1, zHT));
  end;
end;

function  TFMEFox.OpenCashBox:boolean;
var mErr:longint;
begin
  Result := (SendComData('oD', '1')=1);
end;

function  TFMEFox.PrintIntDoc (pText:string):boolean;
var mOK:boolean; mErr, I:longint; mSList:TStringList;
begin
  Result := FALSE;
  mOK := FALSE;
  PrinterStatusVerify;
  mOK := (SendComData ('bNF', '')=0);
  If mOK then begin
    mOK := FALSE;
    mSList := TStringList.Create;
    mSList.Text := pText;
    If mSList.Count>0 then begin
      For I:=0 to mSList.Count-1 do begin
        mOK := PrintIntDocLn (mSList.Strings[I]);
        If not mOK then Break;
      end;
      FreeAndNil (mSList);
    end;
  end;
  If mOK then mOK := (SendComData ('eNF', '1')=0);
  Result := mOK;
end;

function  TFMEFox.PrintIntDocLn (pText:string):boolean;
var mErr:longint;
begin
  Result := FALSE;
  If pText='' then pText := ' ';
  mErr := SendComData ('pN', pText);
  Result := (mErr=0);
end;

function  TFMEFox.PrintICDocHead:boolean;
var mDocNum:longint;
begin
  Result := FALSE;
  mDocNum := GetFMDocNum;
  If mDocNum>-1 then begin
    oInfo.FMDocNum := mDocNum;
    oPrevDocNum := oInfo.FMDocNum;
    gCasGlobVals.FMDocQnt := oInfo.FMDocNum;
    gCasGlobVals.DDocQnt := oInfo.FMDocNum;
    Result := PrintBeginFiscalBlk (5); //5 FP_RT_SIMPLE_INVOICE úètenka úhrady faktúr(y)
  end;
end;

function  TFMEFox.PrintDocHead (pHead:string):boolean;
var mDocNum:longint;
begin
  Result := FALSE;
  mDocNum := GetFMDocNum;
  If mDocNum>-1 then begin
    oInfo.FMDocNum := mDocNum;
    oPrevDocNum := oInfo.FMDocNum;
    gCasGlobVals.FMDocQnt := oInfo.FMDocNum;
    gCasGlobVals.DDocQnt := oInfo.FMDocNum;
    Result := PrintBeginFiscalBlk (1); //1 FP_RT_SALES úètenka predaja
    If Result and (pHead<>'') then begin
      Result := PrintDocNote (pHead);
    end;
  end;
end;

function  TFMEFox.PrintDocItem (pItem:string; pPrice, pQnt, pValue:double; pVatPrc:longint; pGsName, pMsName, pNegItmType:string):boolean;
var mVatID:string;
begin
  Result := FALSE;
  mVatID := GetVatID (pVatPrc);
  If oBlkType=5 then begin
    pGsName := Copy (pItem, 1, Length (pItem)-2);
    pItem := '';
  end;
  If pQnt<0 then begin
    If (pNegItmType='C') or (pNegItmType='N') then begin
      Result := PrintNegItem (pPrice, pQnt, pValue, mVatID, pGsName, pMsName);
    end else begin
      If (pNegItmType='D') then Result := PrintDscItem (pValue, mVatID, pGsName);
    end;
  end else Result := PrintSaleItem (pItem, pPrice, pQnt, pValue, mVatID, pGsName, pMsName);
end;

function  TFMEFox.PrintDocPay (pDocVal:double; pFMPayNum:longint;pVal:double):boolean;
var mCom:string;
begin
  If pDocVal<0 then pVal := 0;
  mCom := StrDoub (pDocVal, 0, 2)+zHT+StrDoub (pVal, 0, 2)+zHT+StrInt (pFMPayNum, 0)+zHT+zHT;
  Result := (SendComData('pRT', mCom)=0);
end;

function  TFMEFox.PrintDocNote (pNote:string):boolean;
var I:longint; mSList:TStringList;
begin
  Result := TRUE;
  If pNote<>'' then begin
    mSList := TStringList.Create;
    mSList.Text := pNote;
    If mSList.Count>0 then begin
      For I:=0 to mSList.Count-1 do begin
        Result := (SendComData('pRM', '1'+zHT+mSList.Strings[I])=0);
        If not Result then Break;
      end;
    end;
    FreeAndNil (mSList);
  end;
end;

function  TFMEFox.PrintDocClose:boolean;
begin
  Result := (SendComData('eFR', '1')=0);
  If Result  then begin
    oInfo.FMDocNum := GetFMDocNum;
    Result :=  (oPrevDocNum<>oInfo.FMDocNum) and (oInfo.FMDocNum>0);
    gCasGlobVals.FMDocQnt := oInfo.FMDocNum;
    gCasGlobVals.DDocQnt := oInfo.FMDocNum;
    oBlkType := 0;
  end;
end;

function  TFMEFox.PrintIncDocHead (pHead:string):boolean;
begin
  oInfo.FMDocNum := GetFMDocNum;
  oPrevDocNum := oInfo.FMDocNum;
  gCasGlobVals.FMDocQnt := oInfo.FMDocNum;
  gCasGlobVals.DDocQnt := oInfo.FMDocNum;
  Result := PrintBeginFiscalBlk (3); //3 FP_RT_CASH_IN úètenka vkladu hotovosti
  If pHead<>'' then Result := PrintDocNote (pHead);
end;

function  TFMEFox.PrintIncDocPay (pFMPayNum:longint;pVal:double):boolean;
begin
  Result := (SendComData('pRC', StrDoub (pVal, 0, 2)+zHT+StrInt (pFMPayNum, 0))=0);
end;

function  TFMEFox.PrintIncDocFoot (pFoot:string):boolean;
var mErr:longint;
begin
  Result := TRUE;
  If pFoot<>'' then Result := PrintDocNote (pFoot);
  If Result then Result := (SendComData('eFR', '1')=0);
end;

function  TFMEFox.PrintExpDocHead (pHead:string):boolean;
var mErr:longint;
begin
  oInfo.FMDocNum := GetFMDocNum;
  oPrevDocNum := oInfo.FMDocNum;
  gCasGlobVals.FMDocQnt := oInfo.FMDocNum;
  gCasGlobVals.DDocQnt := oInfo.FMDocNum;
  Result := PrintBeginFiscalBlk (4); //4 FP_RT_CASH_OUT úètenka výberu hotovosti
  If pHead<>'' then Result := PrintDocNote (pHead);
end;

function  TFMEFox.PrintExpDocPay (pFMPayNum:longint;pVal:double):boolean;
begin
  Result := (SendComData('pRC', StrDoub (pVal, 0, 2)+zHT+StrInt (pFMPayNum, 0))=0);
end;

function  TFMEFox.PrintExpDocFoot (pFoot:string):boolean;
var mErr:longint;
begin
  Result := FALSE;
  If pFoot<>'' then Result := PrintDocNote (pFoot);
  If Result then Result := (SendComData('eFR', '1')=0);
end;

function  TFMEFox.PrintIClose:boolean;
begin
  PrinterStatusVerify;
  Result := (SendComData('pXR', '')=0);
end;

function  TFMEFox.PrintDClose:boolean;
var mErr:longint;
begin
  PrinterStatusVerify;
  Result := (SendComData('pZR', '')=0);
end;

function  TFMEFox.PrintMClose:boolean;
var mDateF:TDate; mD, mM, mY:word;
begin
  DecodeDate (Date, mY, mM, mD);
  mDateF := EncodeDate (mY, mM, 1);
  Result := PrintIntDateClose (mDateF, Date, FALSE);
end;

function  TFMEFox.PrintLastBlock:boolean;
begin
  Result := (SendComData('pDR', '')=0);
end;

function  TFMEFox.PrintIntDateClose (pDateF, pDateL:TDate; pDetails:boolean):boolean;
var mErr:longint; mCom, mStart, mEnd, mType:string; mD,mM,mY:word;
begin
  If pDetails then mType := '1' else mType := '2';
  DecodeDate(pDateF, mY, mM, mD);
  mStart := StrIntZero (mD, 2)+StrIntZero (mM, 2)+StrInt (mY, 4)+'0000';
  DecodeDate(pDateL, mY, mM, mD);
  mEnd := StrIntZero (mD, 2)+StrIntZero (mM, 2)+StrInt (mY, 4)+'0000';
  mCom := '2'+zHT+mType+zHT+mStart+zHT+mEnd;
  PrinterStatusVerify;
  Result := (SendComData('pR', mCom)=0);
end;

function  TFMEFox.PrintIntNumClose (pNumF, pNumL:longint; pDetails:boolean):boolean;
var mErr:longint; mCom, mType:string;
begin
  If pDetails then mType := '1' else mType := '2';
  mCom := '1'+zHT+mType+zHT+StrInt (pNumF, 0)+zHT+StrInt (pNumL, 0);
  PrinterStatusVerify;
  Result := (SendComData('pR', mCom)=0);
end;

function  TFMEFox.ReadLastDoc:string;
var mS:string; mSList:TStringList;
  mBusinessDayCount, mDocumentCount, mStartLineNumber, mEndLineNumber, mErr, I:longint;
begin
  Result := '';
  mS := GetComData('gJSI', '1', mErr);
  If mErr=0 then begin
    If mS<>'' then begin
      mBusinessDayCount := ValInt (LineElement(mS, 1, zHT));
      If mBusinessDayCount>0 then begin
        mS := GetComData('gBDJI', '1'+zHT+StrInt (mBusinessDayCount, 0), mErr);
        If mErr=0 then begin
          If mS<>'' then begin
            mDocumentCount := ValInt (LineElement(mS, 1, zHT));
            If mDocumentCount>0 then begin
              mS := GetComData('gDJI', '1'+zHT+StrInt (mBusinessDayCount, 0)+zHT+StrInt (mDocumentCount, 0), mErr);
              If mErr=0 then begin
                If mS<>'' then begin
                  mStartLineNumber := ValInt (LineElement(mS, 3, zHT));
                  mEndLineNumber := ValInt (LineElement(mS, 4, zHT));
                  If (mStartLineNumber>0) and (mEndLineNumber>mStartLineNumber) then begin
                    mSList := TStringList.Create;
                    For I:=mStartLineNumber to mEndLineNumber do begin
                      mS := GetComData('gJL', '1'+zHT+StrInt (I, 0), mErr);
                      If mErr=0 then begin
                        mS := LineElement (mS, 1, zHT);
                        Delete (mS, 1, 2);
                        mSList.Add(mS);
                      end else Break;
                    end;
                    If mErr=0 then Result := mSList.Text;
                    FreeAndNil (mSList);
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;

//  mDCls := GetDCloseNum;
//  mDocNum := GetFMDocNum;
(*  mT := Now;

  For I:=200 to 234 do begin
    mTItm := Now;
    If oPortComHand.WriteToPort('gJL'+zHT+'REQ'+zHT+'1'+zHT+StrInt (I, 0)+zLF) then begin
      Result := Result+LineElement (ReadInEFoxLn ('gJL'), 1, zHT)+'  - '+FormatDateTime ('ss,zzz', Now-mTItm)+zCR+zLF;
    end;
  end;
  Result := Result+FormatDateTime('hh:nn:ss,zzz', Now-mT)   ;*)
(*  If oPortComHand.WriteToPort('rRB'+zHT+'REQ'+zHT+'1'+zHT
    +'2'+zHT
    +'1'+zHT
    +'3'+zHT+'3'+zHT
    +'1'+zLF) then begin
    mS := ReadInEFoxLn ('rRB');
    Result := mS;
  end;*)
//    If (LineElement(mS, 0, zHT)='0') then Result := ValInt (LineElement(mS, 1, zHT));

//getJournalStorageInfo
//getJournalLine
//getDocumentJournalInfo
//retrieveRecBoundary
//fp@elcom.sk
//printDuplicateReceipt
end;


(*
Postup je nasledovny

1. zavolame prikaz getJournalStorageInfo

2.prikaz vrati aj hodnotu businessDayCount ktoru je potrebne odpamatat (zvycajne je to hodnota 1, ak sa maze zurnal kazdy den)

3.zavolame prikaz getBusinessDayJournalInfo pricom v parametri tohto prikazu dayStorageIndex zadame hodnotu businessDayCount z predchadzajuceho prikazu getJournalStorageInfo

4.prikaz vrati aj hodnotu documentCount ktoru je potrebne odpamatat

5.zavolame prikaz getDocumentJournalInfo pricom v parametri tohto prikazu dayStorageIndex zadame hodnotu businessDayCount z predchadzajuceho prikazu getJournalStorageInfo a v parametri documentIndex zadame hodnotu documentCount z predchadzajuceho prikazu getBusinessDayJournalInfo a

6.prikaz okrem inych hodnot vrati aj hodnoty startLineNumber a endLineNumber ktore obsahuju prvy a posledny riadok predchadzajuceho dokumentu

7. nasledne pomocou prikazu getJournalLine je mozne vycitat cely doklad, ak sa vycitava od riadkov startLineNumber a endLineNumber z predchadzajuceho prikazu getDocumentJournalInfo

*)
function  TFMEFox.GetFMBegValue:double;
var mS:string; mErr:longint;
begin
  Result := 0;
  mS := GetComData('gD', '8'+zHT+'1', mErr);
  If mErr=0 then begin
    If (LineElement(mS, 0, zHT)='0') then begin
      mS := LineElement(mS, 1, zHT);
      Result := ValDoub (mS);
    end;
  end;
end;

function  TFMEFox.WriteToDisp (pText:string):boolean;
var I:longint; mSList:TStringList;
begin
  Result := (SendComData('cD', '0')=0);
  If Result then begin
    mSList := TStringList.Create;
    mSList.Text := pText;
    If mSList.Count>0 then begin
      For I:=0 to mSList.Count-1 do begin
        Result := (SendComData('dTA', StrInt (I+1, 0)+zHT+'1'+zHT+mSList.Strings[I])=0);
        If not Result then Break;
      end;
    end;
    FreeAndNil (mSList);
  end;
end;

function  TFMEFox.ExportJournal:boolean;
begin
  Result := ExportJournalData (TRUE);
  If Result then Result := ExportJournalData (FALSE);
end;

function  TFMEFox.ReadDCloseVals:boolean;
var mS:string; mErr, I:longint;
begin
  For I:=1 to 5 do begin
    gCasClsVals.BValue[I] := GetTotalizerValue (I, 1);
    gCasClsVals.VatVal[I] := GetTotalizerValue (I, 15);
    gCasClsVals.VatPrc[I] := gFMInfo.VatPrc[I];
  end;
  Result := TRUE;
end;

(*
          gCasClsVals.ClsNum := pDClsNum;
          gCasClsVals.Date := BCDToDate (mS, 4);
          gCasClsVals.Time := BCDToTime (mS, 8);
          gCasClsVals.BValue[I+1] := mD;
          gCasClsVals.VatVal[I+1] := mD;
          gCasClsVals.VatPrc[I+1] := Round (mD);
          gCasClsVals.DocQnt := mW-1;
*)
//  ***** TExtDispHand *****
constructor TExtDispHand.Create (pExtDispSet:TExtDispSet);
begin
  oExtDispSet := pExtDispSet;
  oHidDev := nil;
  If oExtDispSet.DispType=0 then oHidDev := FindHidDev (512, 3386);
end;

destructor  TExtDispHand.Destroy;
begin
  If oHidDev<>nil then FreeAndNil(oHidDev);
end;

function  TExtDispHand.WriteDispLn (pLn:byte; pStr:string):boolean;
begin
  Result := FALSE;
  If (oExtDispSet.DispType=0) and (oHidDev<>nil) then begin
    If pLn in [1..2] then begin
      If WriteDispBuff (#31+#$24+#1+Chr (pLn)) then begin
        If WriteDispBuff (#$18) then begin
          pStr := Copy (pStr, 1, 20);
          Result := WriteDispBuff (pStr);
        end;
      end;
    end;
  end;
end;

function  TExtDispHand.WriteDispBuff (pStr:string):boolean;
var  mBuff: array [0..64] of Byte; mErr:DWord; mToWrite, mWritten: Cardinal;
     mStr,mSubStr:string; mBreak:boolean; I:longint;
begin
  Result := FALSE;
  If (oExtDispSet.DispType=0) and (oHidDev<>nil) then begin
    mToWrite :=  oHidDev.Caps.OutputReportByteLength;
    mStr := pStr; mBreak := FALSE;
    Repeat
      If Length (mStr)>mToWrite-2 then begin
        mSubStr := Copy (mStr, 1, mToWrite-2);
        Delete (mStr, 1, mToWrite-2);
      end else begin
        mSubStr := mStr;
        mStr := '';
      end;
      For I:=0 to mToWrite DO
        mBuff[I] := 0;
      If mSubStr<>'' then begin
        mBuff[1] := Length (mSubStr);
        For I:=1 to Length (mSubStr) do
          mBuff[I+1] := Ord (mSubStr [I]);
        If not oHidDev.WriteFile(mBuff, mToWrite, mWritten) then begin
          mErr := GetLastError;
          mBreak := TRUE;
        end else Result := TRUE;
      end else mBreak := TRUE;
    until (mStr='') or mBreak;
  end;
end;

function  TExtDispHand.ClearDisp:boolean;
begin
  Result := FALSE;
  If (oExtDispSet.DispType=0) and (oHidDev<>nil) then begin
    If WriteDispBuff (#31+#$43+#0) then begin
      Result := WriteDispBuff (#$C);
    end;
  end;
end;

function  TExtDispHand.InitDisp:boolean;
begin
  Result := FALSE;
  If (oExtDispSet.DispType=0) and (oHidDev<>nil) then begin
    Result := WriteDispBuff (#27+#$40);
  end;
end;

function  TExtDispHand.DispVersion:boolean;
begin
  Result := FALSE;
  If (oExtDispSet.DispType=0) and (oHidDev<>nil) then begin
    Result := WriteDispBuff (#31+#$40);
  end;
end;

(*
function  TExtDispHand.FindHidDev (pProductID,pVendorID:word):TJvHidDevice;
var mH:TJvHidDeviceController; mHidDev:TJvHidDevice;
begin
  Result := nil;
  mH := TJvHidDeviceController.Create(nil);
  mH.DeviceChange;
  While mH.CheckOut(mHidDev) do begin
    If mHidDev<>nil then begin
      If (mHidDev.Attributes.VendorID=pVendorID) and (mHidDev.Attributes.ProductID=pProductID) then begin
        Result := mHidDev;
      end;
    end;
  end;
//  FreeAndNil (mH);
end;
*)

//  ***** TCasFMHand *****
constructor TCasFMHand.Create (pPrnNum:longint;pCasFMHandSet:TPrintersSet;pRepMask:string);
var I,mPortType:longint;
begin
  oCasFMHandSet := pCasFMHandSet;
  oPrnNum := pPrnNum;
  oRepMask := pRepMask;
  oIntDispMask := '';
  oExtDispMask := '';
  oCopies := 1;
  oFMPaySchedule := FALSE;
  oFMIncExp := FALSE;

  oPrintBonusFoot := FALSE;
  oExtHeadUse := FALSE;
  oIntHeadUse := FALSE;
  oVarFootUse := FALSE;
  oFixFootUse := FALSE;
  oFldDataQnt := 0;
  For I:=1 to 300 do begin
    oFldData[I].ID := '';
    oFldData[I].Num := 0;
    oFldData[I].Str := '';
    oFldData[I].Typ := 0;
  end;
  oPrice      := 0;
  oQnt        := 0;
  oItmVal     := 0;
  oVatPrc     := 0;
  oNegItmType := '';
  oGsName     := '';
  oGsNameID   := '';
  oMsName     := '';
  oMsNameID   := '';
  oDocVal     := 0;

  oPrnType := 0;

  If oPrnNum=0 then begin
    oPrnType := oCasFMHandSet.FMPrn.PrnType;
    mPortType := oCasFMHandSet.FMPrn.PrnType;
    If mPortType>3 then mPortType := ptSerial;
    oPortComHand := TPortComHand.Create (mPortType);
    oPortComHand.oPortSet := oCasFMHandSet.FMPrn.PortSet;
  end else begin
    If oPrnNum in [0..3] then begin
      oPrnType := oCasFMHandSet.ExtPrn[oPrnNum].PrnType;
      oPortComHand := TPortComHand.Create (oPrnType);
      oPortComHand.oPortSet := oCasFMHandSet.ExtPrn[oPrnNum].PortSet;
      oPortComHand.oIPSet := oCasFMHandSet.ExtPrn[oPrnNum].IPSet;
    end;
  end;

  oActBlk   := TStringList.Create;
  oFullBlk  := TStringList.Create;

  InitPrnType;
  ReadRepFile;
  If oCasFMHandSet.ExtDisp.DispUse then oExtDisp :=TExtDispHand.Create(oCasFMHandSet.ExtDisp);
  OpenPort;
end;

destructor  TCasFMHand.Destroy;
begin
  FreeAndNil (oActBlk);
  FreeAndNil (oFullBlk);
  If oPortComHand<>nil then begin
    ClosePort;
    FreeAndNil (oPortComHand);
  end;
  If oSallyPrinter<>nil then FreeAndNil (oSallyPrinter);
  If oFMFT4000<>nil then FreeAndNil (oFMFT4000);
  If oFMPEGAS<>nil then FreeAndNil (oFMPEGAS);
  If oFMEFox<>nil then FreeAndNil (oFMEFox);
  If oBlockHead<>nil then FreeAndNil (oBlockHead);
  If oBlockItem<>nil then FreeAndNil (oBlockItem);
  If oShortItem<>nil then FreeAndNil (oShortItem);
  If oSubHead<>nil then FreeAndNil (oSubHead);
  If oSubFoot<>nil then FreeAndNil (oSubFoot);
  If oSumFoot<>nil then FreeAndNil (oSumFoot);
  If oInfoFoot<>nil then FreeAndNil (oInfoFoot);
  If oBonusFoot<>nil then FreeAndNil (oBonusFoot);
  If oAppHead<>nil then FreeAndNil (oAppHead);
  If oAppItem<>nil then FreeAndNil (oAppItem);
  If oAppData<>nil then FreeAndNil (oAppData);
  If oItmData<>nil then FreeAndNil (oItmData);
  If oAItmData<>nil then FreeAndNil (oAItmData);
  If oExtHead<>nil then FreeAndNil (oExtHead);
  If oIntHead<>nil then FreeAndNil (oIntHead);
  If oVarFoot<>nil then FreeAndNil (oVarFoot);
  If oFixFoot<>nil then FreeAndNil (oFixFoot);
  If oIntDispO<>nil then FreeAndNil (oIntDispO);
  If oIntDispI<>nil then FreeAndNil (oIntDispI);
  If oIntDispM<>nil then FreeAndNil (oIntDispM);
  If oIntDispE<>nil then FreeAndNil (oIntDispE);
  If oIntDispC<>nil then FreeAndNil (oIntDispC);
  If oIntDispX<>nil then FreeAndNil (oIntDispX);
  If oIntDispN<>nil then FreeAndNil (oIntDispN);
  If oIntDispP<>nil then FreeAndNil (oIntDispP);
  If oExtDispO<>nil then FreeAndNil (oExtDispO);
  If oExtDispI<>nil then FreeAndNil (oExtDispI);
  If oExtDispM<>nil then FreeAndNil (oExtDispM);
  If oExtDispE<>nil then FreeAndNil (oExtDispE);
  If oExtDispC<>nil then FreeAndNil (oExtDispC);
  If oExtDispX<>nil then FreeAndNil (oExtDispX);
  If oExtDispN<>nil then FreeAndNil (oExtDispN);
  If oExtDispP<>nil then FreeAndNil (oExtDispP);
  If oCasFMHandSet.ExtDisp.DispUse then FreeAndNil (oExtDisp);
  inherited;
end;

procedure  TCasFMHand.ReadRepFile;
var mSList:TStringList; I:longint; mID,mLn:string;
begin
  If FileExists (oRepMask) then begin
    mSList := TStringList.Create;
    mSList.LoadFromFile(oRepMask);
    If mSList.Count>0 then begin
      For I:=0 to mSList.Count-1 do begin
        If Copy (mSList.Strings[I],1,1)='^' then begin
          mID := Copy (mSList.Strings[I],2,2);
          mLn := Copy (mSList.Strings[I],4,Length (mSList.Strings[I]));
          If Length (mID)=2 then begin
            If mID='RN' then ReadRepName (mLn);
            If mID='EH' then ReadExtHeadUse;
            If mID='IH' then ReadIntHeadUse;
            If mID='BH' then ReadBlockHead (mLn);
            If mID='BI' then ReadBlockItem (mLn);
            If mID='SI' then ReadShortItem (mLn);
            If mID='XH' then ReadSubHead (mLn);
            If mID='XF' then ReadSubFoot (mLn);
            If mID='SF' then ReadSumFoot (mLn);
            If mID='VF' then ReadVarFootUse;
            If mID='IF' then ReadInfoFoot (mLn);
            If mID='BF' then ReadBonusFoot (mLn);
            If mID='FF' then ReadFixFootUse;
            If mID='AH' then ReadAppnHead (mLn);
            If mID='AI' then ReadAppItem (mLn);
          end;
        end;
      end;
    end;
    FreeAndNil (mSList);
  end;
end;

procedure TCasFMHand.SetIntDispMask (pValue:string);
begin
  oIntDispMask := pValue;
  ReadIntDisp;
end;

procedure TCasFMHand.SetExtDispMask (pValue:string);
begin
  oExtDispMask := pValue;
  ReadExtDisp;
end;

procedure  TCasFMHand.ReadRepName (pLn:string);
begin
  oRepName  := pLn;
end;

procedure  TCasFMHand.ReadExtHeadUse;
begin
  oExtHeadUse := TRUE;
end;

procedure  TCasFMHand.ReadIntHeadUse;
begin
  oIntHeadUse := TRUE;
end;

procedure  TCasFMHand.ReadBlockHead (pLn:string);
begin
  If oBlockHead=nil then oBlockHead := TStringList.Create;
  oBlockHead.Add(pLn);
end;

procedure  TCasFMHand.ReadBlockItem (pLn:string);
begin
  If oBlockItem=nil then oBlockItem := TStringList.Create;
  oBlockItem.Add(pLn);
end;

procedure TCasFMHand.ReadShortItem (pLn:string);
begin
  If oShortItem=nil then oShortItem := TStringList.Create;
  oShortItem.Add(pLn);
end;

procedure TCasFMHand.ReadSubHead (pLn:string);
begin
  If oSubHead=nil then oSubHead := TStringList.Create;
  oSubHead.Add(pLn);
end;

procedure TCasFMHand.ReadSubFoot (pLn:string);
begin
  If oSubFoot=nil then oSubFoot := TStringList.Create;
  oSubFoot.Add(pLn);
end;

procedure TCasFMHand.ReadSumFoot (pLn:string);
begin
  If oSumFoot=nil then oSumFoot := TStringList.Create;
  oSumFoot.Add(pLn);
end;

procedure  TCasFMHand.ReadVarFootUse;
begin
  oVarFootUse := TRUE;
end;

procedure  TCasFMHand.ReadInfoFoot (pLn:string);
begin
  If oInfoFoot=nil then oInfoFoot := TStringList.Create;
  oInfoFoot.Add(pLn);
end;

procedure TCasFMHand.ReadFixFootUse;
begin
  oFixFootUse := TRUE;
end;

procedure TCasFMHand.ReadBonusFoot (pLn:string);
begin
  If oBonusFoot=nil then oBonusFoot := TStringList.Create;
  oBonusFoot.Add(pLn);
end;

procedure TCasFMHand.ReadAppnHead (pLn:string);
begin
  If oAppHead=nil then oAppHead := TStringList.Create;
  oAppHead.Add(pLn);
end;

procedure  TCasFMHand.ReadAppItem (pLn:string);
begin
  If oAppItem=nil then oAppItem := TStringList.Create;
  oAppItem.Add(pLn);
end;

procedure TCasFMHand.ReadIntDisp;
var mSList:TStringList; I:longint; mID,mLn:string;
begin
  If FileExists (oIntDispMask) then begin
    mSList := TStringList.Create;
    mSList.LoadFromFile(oIntDispMask);
    If mSList.Count>0 then begin
      For I:=0 to mSList.Count-1 do begin
        If Copy (mSList.Strings[I],1,1)='^' then begin
          mID := Copy (mSList.Strings[I],2,1);
          mLn := Copy (mSList.Strings[I],3,Length (mSList.Strings[I]));
          If Length (mID)=1 then begin
            If mID='O' then ReadIntDispO (mLn);
            If mID='I' then ReadIntDispI (mLn);           
            If mID='M' then ReadIntDispM (mLn);
            If mID='E' then ReadIntDispE (mLn);
            If mID='C' then ReadIntDispC (mLn);
            If mID='N' then ReadIntDispN (mLn);
            If mID='X' then ReadIntDispX (mLn);
            If mID='P' then ReadIntDispP (mLn);
          end;
        end;
      end;
    end;
    FreeAndNil (mSList);
  end;
end;

procedure TCasFMHand.ReadIntDispO (pLn:string);
begin
  If oIntDispO=nil then oIntDispO := TStringList.Create;
  oIntDispO.Add(pLn);
end;

procedure TCasFMHand.ReadIntDispI (pLn:string);
begin
  If oIntDispI=nil then oIntDispI := TStringList.Create;
  oIntDispI.Add(pLn);
end;

procedure TCasFMHand.ReadIntDispM (pLn:string);
begin
  If oIntDispM=nil then oIntDispM := TStringList.Create;
  oIntDispM.Add(pLn);
end;

procedure TCasFMHand.ReadIntDispE (pLn:string);
begin
  If oIntDispE=nil then oIntDispE := TStringList.Create;
  oIntDispE.Add(pLn);
end;

procedure TCasFMHand.ReadIntDispC (pLn:string);
begin
  If oIntDispC=nil then oIntDispC := TStringList.Create;
  oIntDispC.Add(pLn);
end;

procedure TCasFMHand.ReadIntDispN (pLn:string);
begin
  If oIntDispN=nil then oIntDispN := TStringList.Create;
  oIntDispN.Add(pLn);
end;

procedure TCasFMHand.ReadIntDispX (pLn:string);
begin
  If oIntDispX=nil then oIntDispX := TStringList.Create;
  oIntDispX.Add(pLn);
end;

procedure TCasFMHand.ReadIntDispP (pLn:string);
begin
  If oIntDispP=nil then oIntDispP := TStringList.Create;
  oIntDispP.Add(pLn);
end;

procedure TCasFMHand.ReadExtDisp;
var mSList:TStringList; I:longint; mID,mLn:string;
begin
  If FileExists (oExtDispMask) then begin
    mSList := TStringList.Create;
    mSList.LoadFromFile(oExtDispMask);
    If mSList.Count>0 then begin
      For I:=0 to mSList.Count-1 do begin
        If Copy (mSList.Strings[I],1,1)='^' then begin
          mID := Copy (mSList.Strings[I],2,1);
          mLn := Copy (mSList.Strings[I],3,Length (mSList.Strings[I]));
          If Length (mID)=1 then begin
            If mID='O' then ReadExtDispO (mLn);
            If mID='I' then ReadExtDispI (mLn);
            If mID='M' then ReadExtDispM (mLn);
            If mID='E' then ReadExtDispE (mLn);
            If mID='C' then ReadExtDispC (mLn);
            If mID='N' then ReadExtDispN (mLn);
            If mID='X' then ReadExtDispX (mLn);
            If mID='P' then ReadExtDispP (mLn);
          end;
        end;
      end;
    end;
    FreeAndNil (mSList);
  end;
end;

procedure TCasFMHand.ReadExtDispO (pLn:string);
begin
  If oExtDispO=nil then oExtDispO := TStringList.Create;
  oExtDispO.Add(pLn);
end;

procedure TCasFMHand.ReadExtDispI (pLn:string);
begin
  If oExtDispI=nil then oExtDispI := TStringList.Create;
  oExtDispI.Add(pLn);
end;

procedure TCasFMHand.ReadExtDispM (pLn:string);
begin
  If oExtDispM=nil then oExtDispM := TStringList.Create;
  oExtDispM.Add(pLn);
end;

procedure TCasFMHand.ReadExtDispE (pLn:string);
begin
  If oExtDispE=nil then oExtDispE := TStringList.Create;
  oExtDispE.Add(pLn);
end;

procedure TCasFMHand.ReadExtDispC (pLn:string);
begin
  If oExtDispC=nil then oExtDispC := TStringList.Create;
  oExtDispC.Add(pLn);
end;

procedure TCasFMHand.ReadExtDispN (pLn:string);
begin
  If oExtDispN=nil then oExtDispN := TStringList.Create;
  oExtDispN.Add(pLn);
end;

procedure TCasFMHand.ReadExtDispX (pLn:string);
begin
  If oExtDispX=nil then oExtDispX := TStringList.Create;
  oExtDispX.Add(pLn);
end;

procedure TCasFMHand.ReadExtDispP (pLn:string);
begin
  If oExtDispP=nil then oExtDispP := TStringList.Create;
  oExtDispP.Add(pLn);
end;

function  TCasFMHand.FindFldID (pID:string;var pPos:longint):boolean;
var I:longint;
begin
  Result := FALSE; pPos := 0;
  If pID<>'' then begin
    For I:=1 to oFldDataQnt do begin
      If oFldData[I].ID=pID then begin
        pPos := I;
        Result := TRUE;
        Break;
      end;
    end;
  end;
end;

function  TCasFMHand.GetFldID (pID:string;var pPos:longint):boolean;
begin
  Result := FindFldID (pID,pPos);
  If not Result then begin
    If oFldDataQnt<300 then begin
      Inc (oFldDataQnt);
      pPos := oFldDataQnt;
      Result := TRUE;
    end;
  end;
end;

function  TCasFMHand.FillAllFld (pStr:string):string;
begin
  FillStandFld (pStr);
  FillSpecFld (pStr);
  FillVarLenFld (pStr);
  Result := DelHiddenLn (pStr);
end;

function  TCasFMHand.FillAllFldASCIIConv (pStr:string):string;
var mASCIITbl:longint;
begin
  pStr := FillAllFld(pStr);
  mASCIITbl := 1;
  If oPrnNum=0 then mASCIITbl := oCasFMHandSet.FMPrn.PrnEscSet.ASCIITbl;
  If oPrnNum in [1..3] then mASCIITbl := oCasFMHandSet.ExtPrn[oPrnNum].PrnEscSet.ASCIITbl;
  Result := ConvStrToSetASCIITbl (pStr, mASCIITbl);
end;

procedure TCasFMHand.FillStandFld (var pStr:string);
var mBeg,mLen,mFrac,mItm:longint; mID:string; mFind:boolean;
begin
  While Pos ('#',pStr)>0 do begin
    mBeg := Pos ('#',pStr); mLen := 0;
    mID := Copy (pStr,mBeg+1,1);
    mFind := FALSE;
    If mID<>'' then begin
      ScanFldParam (mBeg,pStr,mID,FALSE,mLen,mFrac);
      If FindFldID(mID,mItm) then begin
        ChangeVal (FALSE,mBeg,mLen,mFrac,mItm,pStr);
        mFind := TRUE;
      end;
    end;
    If not mFind then begin
      Delete (pStr,mBeg,1);
      Insert (' ',pStr,mBeg);
    end;
  end;
end;

procedure TCasFMHand.FillSpecFld (var pStr:string);
var mBeg,mLen,mFrac,mItm:longint; mID:string; mFind:boolean;
begin
  While Pos ('|',pStr)>0 do begin
    mBeg := Pos ('|',pStr); mLen := 0;
    mID := Copy (pStr,mBeg+1,1);
    mFind := FALSE;
    If mID<>'' then begin
      ScanFldParam (mBeg,pStr,mID,FALSE,mLen,mFrac);
      If FindFldID(mID,mItm) then begin
        ChangeVal (TRUE,mBeg,mLen,mFrac,mItm,pStr);
        mFind := TRUE;
      end;
    end;
    If not mFind then begin
      Delete (pStr,mBeg,1);
      Insert (' ',pStr,mBeg);
    end;
  end;
end;

procedure TCasFMHand.FillVarLenFld (var pStr:string);
var mBeg,mLen,mFrac,mItm:longint; mID:string; mFind:boolean;
begin
  While Pos ('¤',pStr)>0 do begin
    mBeg := Pos ('¤',pStr); mLen := 0;
    mID := Copy (pStr,mBeg+1,1);
    mFind := FALSE;
    If mID<>'' then begin
      ScanFldParam (mBeg,pStr,mID,TRUE,mLen,mFrac);
      If FindFldID(mID,mItm) then begin
        ChangeVal (FALSE,mBeg,mLen,mFrac,mItm,pStr);
        mFind := TRUE;
      end;
    end;
    If not mFind then begin
      Delete (pStr,mBeg,1);
      Insert (' ',pStr,mBeg);
    end;
  end;
end;

procedure TCasFMHand.ScanFldParam (pBeg:longint;pStr,pID:string;pVarFld:boolean;var pLen,pFrac:longint);
var mPos:longint; mEndPart,mEndFld,mFindFrac:boolean;
begin
  pLen := 1; pFrac := 0;
  mPos := pBeg+1;
  mEndPart := FALSE; mEndFld := FALSE; mFindFrac := FALSE;
  While (Length (pStr)>mPos) and not mEndFld do begin
    If pVarFld then begin
      If not mEndPart then begin
        mEndPart := (Copy (pStr,mPos,1)<>pID) and (Copy (pStr,mPos,1)<>'.');
        If not mEndPart then begin
          Inc (pLen);
          If mFindFrac then Inc (pFrac);
          If Copy (pStr,mPos,1)='.' then mFindFrac := TRUE;
        end;
      end else begin
        mEndFld := (Copy (pStr,mPos,1)<>' ');
        If not mEndFld then Inc (pLen);
      end;
    end else begin
      mEndFld := (Copy (pStr,mPos,1)<>pID) and (Copy (pStr,mPos,1)<>'.');
      If not mEndFld then begin
        Inc (pLen);
        If mFindFrac then Inc (pFrac);
        If Copy (pStr,mPos,1)='.' then mFindFrac := TRUE;
      end;
    end;
    Inc (mPos);
  end;
  If (pLen>1) and pVarFld then Dec (pLen); 
end;

procedure TCasFMHand.ChangeVal (pHide:boolean;pBeg,pLen,pFrac,pItm:longint;var pStr:string);
var mS:string; mHideLn:boolean;
begin
  mS := ''; mHideLn := FALSE;
  case oFldData[pItm].Typ of
    0 : begin
          If (oFldData[pItm].Str='') and pHide then begin
            mHideLn := TRUE;
          end else begin
            mS := AlignRight(oFldData[pItm].Str,pLen);
          end;
        end;
    1 : begin
          If (oFldData[pItm].Num=0) and pHide then begin
            mHideLn := TRUE;
          end else begin
            mS := StrInt (Round (Int (oFldData[pItm].Num)),pLen);
            If Length (mS)<pLen then mS := AlignRight(mS,pLen);
          end;
        end;
    2 : begin
          If (oFldData[pItm].Num=0) and pHide then begin
            mHideLn := TRUE;
          end else begin
            mS := StrDoub (oFldData[pItm].Num,pLen,pFrac);
            If Length (mS)<pLen then mS := AlignRight(mS,pLen);
          end;
        end;
    3 : begin
          If (oFldData[pItm].Num=0) and pHide then begin
            mHideLn := TRUE;
          end else begin
            mS := StrDoub (oFldData[pItm].Num,pLen,pFrac);
            mS := StripFractZero (mS);
            If Length (mS)<pLen then mS := AlignRight(mS,pLen);
          end;
        end;
    4 : begin
          If (oFldData[pItm].Num=0) and pHide then begin
            mHideLn := TRUE;
          end else begin
            mS := DateToStr (oFldData[pItm].Num);
            mS := AlignLeft(mS,pLen);
          end;
        end;
    5 : begin
          If (oFldData[pItm].Num=0) and pHide then begin
            mHideLn := TRUE;
          end else begin
            mS := TimeToStr (oFldData[pItm].Num);
            mS := AlignLeft(mS,pLen);
          end;
        end;
  end;
  If mHideLn then mS := '¶¶¶¶¶';
  Delete (pStr,pBeg,pLen);
  Insert (mS,pStr,pBeg);
end;

function  TCasFMHand.DelHiddenLn (pStr:string):string;
var mSList:TStringList; mCnt:longint;
begin
  mSList := TStringList.Create;
  mSList.Text := pStr;
  If mSList.Count>0 then begin
    mCnt := 0;
    Repeat
      If Pos ('¶¶¶¶¶',mSList.Strings[mCnt])>0
        then mSList.Delete(mCnt)
        else Inc (mCnt);
    until mCnt>mSList.Count-1;
  end;
  Result := mSList.Text;
  FreeAndNil(mSList);
end;

function  TCasFMHand.GetFldLen (pLn,pID:string):longint;
var mBeg,mLen,mFrac:longint;
begin
  mLen := 0;
  mBeg := Pos ('#'+pID,pLn);
  If mBeg>0 then ScanFldParam (mBeg,pLn,pID,FALSE,mLen,mFrac);
  If mLen=0 then begin
    mBeg := Pos ('|'+pID,pLn);
    If mBeg>0 then ScanFldParam (mBeg,pLn,pID,FALSE,mLen,mFrac);
  end;
  If mLen=0 then begin
    mBeg := Pos ('¤'+pID,pLn);
    If mBeg>0 then ScanFldParam (mBeg,pLn,pID,TRUE,mLen,mFrac);
  end;
  Result := mLen;
end;

procedure TCasFMHand.InitPrnType;
begin
  case oPrnType of
    0..3 : oSallyPrinter := TSallyPrinter.Create(oPortComHand);
    4 : oFMFT4000 := TFMFT4000.Create (oPortComHand);
    5 : oFMPEGAS := TFMPEGAS.Create (oPortComHand);
    6 : oFMEFox := TFMEFox.Create (oPortComHand);
  end;
end;

procedure TCasFMHand.AddBlkText(pText:string);
begin
  oActBlk.Text := oActBlk.Text+pText;
  oFullBlk.Text := oFullBlk.Text+pText;
end;

procedure TCasFMHand.AddBlkFreeLn (pFreeLnNum:longint);
var mS:string; I:longint;
begin
  mS := '';
  If pFreeLnNum>0 then begin
    For I:=1 to pFreeLnNum do
      mS := mS+zCR+zLF;
  end;
  oActBlk.Text := oActBlk.Text+mS;
  oFullBlk.Text := oFullBlk.Text+mS;
end;

procedure TCasFMHand.AddBlkEsc (pEsc:string);
var mEsc:string;
begin
  mEsc := ConvStrToESCCodes (pEsc);
  oActBlk.Text := oActBlk.Text+mEsc;
  oFullBlk.Text := oFullBlk.Text+mEsc;
end;
(*
function  TCasFMHand.MyOpenPort:boolean;
begin
  Result := FALSE;
  If not oPortComHand.Opened then begin
    oPortComHand.OpenPort;
     If (oPrnNum=0) and (oCasFMHandSet.FMPrn.PrnType=6) and (oFMEFox<>nil)
       then Result := oFMEFox.Connect
       else Result := TRUE;
  end;
end;

procedure TCasFMHand.MyClosePort (pMyOpen:boolean);
begin
  If pMyOpen then begin
   If (oPrnNum=0) and (oCasFMHandSet.FMPrn.PrnType=6) and (oFMEFox<>nil) then oFMEFox.Disconnect;
    oPortComHand.ClosePort;
  end;
end;
*)

procedure TCasFMHand.OpenPort;
begin
  If not oPortComHand.Opened then begin
    oPortComHand.OpenPort;
     If (oPrnNum=0) and (oCasFMHandSet.FMPrn.PrnType=6) and (oFMEFox<>nil) then oFMEFox.Connect;
  end;
end;

procedure TCasFMHand.ClosePort;
begin
  If oPortComHand.Opened then begin
    If (oPrnNum=0) and (oCasFMHandSet.FMPrn.PrnType=6) and (oFMEFox<>nil) then oFMEFox.Disconnect;
    oPortComHand.ClosePort;
  end;
end;

procedure TCasFMHand.ClearDCloseVals;
var I:longint;
begin
  gCasClsVals.ClsNum := 0;
  gCasGlobVals.DDocQnt := 0;
  gCasGlobVals.MDocQnt := 0;
  gCasGlobVals.XDocQnt  := 0;

  For I:=1 to 5 do begin
    gCasClsVals.BValue[I] := 0;
    gCasClsVals.VatVal[I] := 0;
    gCasClsVals.VatPrc[I] := 0;
  end;
  gCasClsVals.ClmVal := 0;
  gCasClsVals.NegVal := 0;
  gCasClsVals.DocQnt := 0;
  gCasClsVals.DscVal := 0;
  gCasClsVals.RetVal := 0;
  gCasClsVals.InvVal := 0;
end;

function  TCasFMHand.GetASCIITblNum:longint;
begin
  Result := 1;
  If oPrnNum=0 then Result := oCasFMHandSet.FMPrn.PrnEscSet.ASCIITbl;
  If oPrnNum in [1..3] then Result := oCasFMHandSet.ExtPrn[oPrnNum].PrnEscSet.ASCIITbl;
end;

procedure TCasFMHand.ClearFlds;
var I:longint;
begin
  oFldDataQnt := 0;
  For I:=1 to 300 do begin
    oFldData[I].ID := '';
    oFldData[I].Num := 0;
    oFldData[I].Str := '';
    oFldData[I].Typ := 0;
  end;
  If oExtHead<>nil then oExtHead.Clear;
  If oIntHead<>nil then oIntHead.Clear;
  If oVarFoot<>nil then oVarFoot.Clear;
  If oFixFoot<>nil then oFixFoot.Clear;
end;

procedure TCasFMHand.SetStrFld (pID,pVal:string);
var mPos:longint;
begin
  If GetFldID (pID,mPos) then begin
    oFldData[mPos].ID := pID;
    oFldData[mPos].Str := pVal;
    oFldData[mPos].Typ := 0;
  end;
end;

procedure TCasFMHand.SetIntFld (pID:string;pVal:longint);
var mPos:longint;
begin
  If GetFldID (pID,mPos) then begin
    oFldData[mPos].ID := pID;
    oFldData[mPos].Num := pVal;
    oFldData[mPos].Typ := 1;
  end;
end;

procedure TCasFMHand.SetDoubFld (pID:string;pVal:double);
var mPos:longint;
begin
  If GetFldID (pID,mPos) then begin
    oFldData[mPos].ID := pID;
    oFldData[mPos].Num := pVal;
    oFldData[mPos].Typ := 2;
  end;
end;

procedure TCasFMHand.SetSpecDoubFld (pID:string;pVal:double);
var mPos:longint;
begin
  If GetFldID (pID,mPos) then begin
    oFldData[mPos].ID := pID;
    oFldData[mPos].Num := pVal;
    oFldData[mPos].Typ := 3;
  end;
end;

procedure TCasFMHand.SetDateFld (pID:string;pVal:TDateTime);
var mPos:longint;
begin
  If GetFldID (pID,mPos) then begin
    oFldData[mPos].ID := pID;
    oFldData[mPos].Num := pVal;
    oFldData[mPos].Typ := 4;
  end;
end;

procedure TCasFMHand.SetTimeFld (pID:string;pVal:TDateTime);
var mPos:longint;
begin
  If GetFldID (pID,mPos) then begin
    oFldData[mPos].ID := pID;
    oFldData[mPos].Num := pVal;
    oFldData[mPos].Typ := 5;
  end;
end;

procedure TCasFMHand.SetExtHead (pS:string);
begin
  If oExtHead=nil then oExtHead := TStringList.Create;
  oExtHead.Add (ConvStrToSetASCIITbl (pS, GetASCIITblNum));
end;

procedure TCasFMHand.SetIntHead (pS:string);
begin
  If oIntHead=nil then oIntHead := TStringList.Create;
  oIntHead.Add (ConvStrToSetASCIITbl (pS, GetASCIITblNum));
end;

procedure TCasFMHand.SetVarFoot (pS:string);
begin
  If oVarFoot=nil then oVarFoot := TStringList.Create;
//  oVarFoot.Add (ConvStrToSetASCIITbl (pS, GetASCIITblNum));
  oVarFoot.Add (pS);
end;

procedure TCasFMHand.SetFixFoot (pS:string);
begin
  If oFixFoot=nil then oFixFoot := TStringList.Create;
  oFixFoot.Add (ConvStrToSetASCIITbl (pS, GetASCIITblNum));
end;

procedure TCasFMHand.SetPriceFld (pID:string;pVal:double);
begin
  SetDoubFld (pID,pVal);
  oPrice := pVal;
end;

procedure TCasFMHand.SetQntFld (pID:string;pVal:double);
begin
  SetSpecDoubFld (pID,pVal);
  oQnt := pVal;
end;

procedure TCasFMHand.SetItmValFld (pID:string;pVal:double);
begin
  SetDoubFld (pID,pVal);
  oItmVal := pVal;
end;

procedure TCasFMHand.SetVatPrcFld (pID:string;pVal:longint);
begin
  SetDoubFld (pID,pVal);
  oVatPrc := pVal;
end;

procedure TCasFMHand.SetNegItmTypeFld (pID:string;pVal:string);
begin
  SetStrFld (pID,pVal);
  oNegItmType := pVal;
end;

procedure TCasFMHand.SetGsNameFld (pID:string;pVal:string);
begin
  SetStrFld (pID,pVal);
  oGsNameID := pID;
  oGsName := pVal;
end;

procedure TCasFMHand.SetMsNameFld (pID:string;pVal:string);
begin
  SetStrFld (pID,pVal);
  oMsNameID := pID;
  oMsName := pVal;
end;

procedure TCasFMHand.SetDocValFld (pID:string;pVal:double);
begin
  SetDoubFld (pID,pVal);
  oDocVal := pVal;
end;

procedure TCasFMHand.SetPay (pNum:longint;pName:string;pPayVal:double);
begin
end;

function  TCasFMHand.Initialize:boolean;
begin
  Result := FALSE;
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      0: begin
           gFMInfo.Initialized := TRUE;
           Result := TRUE;
         end;
      4: Result := oFMFT4000.Initialize;
      5: Result := oFMPEGAS.Initialize;
      6: Result := oFMEFox.Initialize;
    end;
  end;
end;

function  TCasFMHand.ReadCassaID:boolean;
begin
  Result := FALSE;
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      0: Result := TRUE;
      4: Result := oFMFT4000.ReadCassaID;
      5: Result := oFMPEGAS.ReadCassaID;
      6: Result := oFMEFox.ReadCassaID;
    end;
  end;
end;

function  TCasFMHand.GetDCloseNum:longint;
begin
  Result := 0;
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      4: begin
           If oFMFT4000.ReadInfo (FALSE) then Result := oFMFT4000.oInfo.DCloseNum;
         end;
      5: Result := oFMPEGAS.GetDCloseNum;
      6: Result := oFMEFox.GetDCloseNum;
    end;
  end;
end;

function  TCasFMHand.PrintICDocHead:boolean;
begin
  Result := FALSE;
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      0: Result := TRUE;
      4: Result := oFMFT4000.PrintICDocHead;
      5: Result := oFMPEGAS.PrintICDocHead;
      6: Result := oFMEFox.PrintICDocHead;
    end;
  end;
end;

function  TCasFMHand.PrintDocHead:boolean;
var mHead:string;
begin
  mHead := '';
  Result := FALSE;
  If oBlockHead<>nil then mHead := FillAllFldASCIIConv(oBlockHead.Text);
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      0: Result := TRUE;
      4: begin
           mHead :=  oFMFT4000.ChangeESCCodes (mHead);
           Result := oFMFT4000.PrintDocHead (mHead);
         end;
      5: begin
           mHead :=  oFMPEGAS.ChangeESCCodes (mHead);
           oFMPEGAS.OpenCashBox;
           Result := oFMPEGAS.PrintDocHead (mHead);
         end;
      6: begin
           oFMEFox.OpenCashBox;
           Result := oFMEFox.PrintDocHead (mHead);
         end;
    end;
  end;
end;

function  TCasFMHand.PrintDocItem:boolean;
var mItem,mSItem, mGsName:string; mLen:longint; 
begin
  mItem := ''; mSItem := '';
  Result := FALSE;
  mGsName := FillAllFldASCIIConv(oGsName);
  mGsName := Copy (mGsName, 1, Length (mGsName)-2);
  If oBlockItem<>nil then mItem := FillAllFldASCIIConv(oBlockItem.Text);
  If oQnt=1 then begin
    If oShortItem<>nil then mSItem := FillAllFldASCIIConv(oShortItem.Text);
    If mSItem<>'' then begin
      mLen := GetFldLen (oShortItem.Text, oGsNameID);
      If mLen>=Length (oGsName) then mItem := mSItem;
    end;
  end;
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      0: Result := TRUE;
      4: begin
           oFMFT4000.ItmVal := oItmVal;
           Result := oFMFT4000.PrintDocItem (mItem, oVatPrc, oQnt, oNegItmType);
//           oFMFT4000.oPortComHand.Delay(400);
         end;
      5: begin
           oFMPEGAS.ItmVal := oItmVal;
           Result := oFMPEGAS.PrintDocItem (mItem, mGsName, oMsName, oVatPrc, oQnt, oPrice, oNegItmType);
         end;
      6: Result := oFMEFox.PrintDocItem (mItem, oPrice, oQnt, oItmVal, oVatPrc, oGsName, oMsName, oNegItmType);
    end;
  end;
end;

function  TCasFMHand.PrintSumDoc:boolean;
begin
  Result := FALSE;
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      0, 5, 6: Result := TRUE;
      4: begin
           oFMFT4000.DocVal := oDocVal;
           Result := oFMFT4000.PrintSumDoc;
         end;
    end;
  end;
end;

function  TCasFMHand.PrintDocPay (pPayNum, pFMPayNum:longint;pVal:double):boolean;
begin
  Result := FALSE;
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      4: begin
           oFMFT4000.DocVal := oDocVal;
           oFMFT4000.FMPaySchedule := oFMPaySchedule;
           Result := oFMFT4000.PrintDocPay (pFMPayNum, pVal);
         end;
      5: begin
           oFMPEGAS.DocVal := oDocVal;
           oFMPEGAS.FMPaySchedule := oFMPaySchedule;
           Result := oFMPEGAS.PrintDocPay (pPayNum, pFMPayNum, pVal);
         end;
      6: begin
           oFMEFox.FMPaySchedule := oFMPaySchedule;
           Result := oFMEFox.PrintDocPay (oDocVal, pFMPayNum, pVal);
         end;
    end;
  end;
end;

function  TCasFMHand.PrintDocNote:boolean;
var mVarFoot,mFixFoot,mInfoFoot,mBonusFoot:string; 
begin
  Result := TRUE;
  mVarFoot := '';
  mFixFoot := '';
  mInfoFoot := '';
  mBonusFoot := '';
  If oVarFootUse and (oVarFoot<>nil) then mVarFoot := FillAllFldASCIIConv(oVarFoot.Text);
  If oFixFootUse and (oFixFoot<>nil) then mFixFoot := oFixFoot.Text;
  If (oInfoFoot<>nil) then mInfoFoot := FillAllFldASCIIConv(oInfoFoot.Text);
  If (oBonusFoot<>nil) and oPrintBonusFoot then mBonusFoot := FillAllFldASCIIConv(oBonusFoot.Text);
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      0: Result := TRUE;
      4: begin
           If mVarFoot<>'' then begin
             mVarFoot :=  oFMFT4000.ChangeESCCodes (mVarFoot);
             Result := oFMFT4000.PrintDocNote (mVarFoot);
           end;
           If (mInfoFoot<>'') and Result then begin
             mInfoFoot :=  oFMFT4000.ChangeESCCodes (mInfoFoot);
             Result := oFMFT4000.PrintDocNote (mInfoFoot);
           end;
           If (mFixFoot<>'') and Result then begin
             mFixFoot :=  oFMFT4000.ChangeESCCodes (mFixFoot);
             Result := oFMFT4000.PrintDocNote (mFixFoot);
           end;
           If (mBonusFoot<>'') and Result then begin
             mBonusFoot :=  oFMFT4000.ChangeESCCodes (mBonusFoot);
             Result := oFMFT4000.PrintDocNote (mBonusFoot);
           end;
         end;
      5: begin
           If mVarFoot<>'' then begin
             mVarFoot :=  oFMPEGAS.ChangeESCCodes (mVarFoot);
             Result := oFMPEGAS.PrintDocNote (mVarFoot);
           end;
           If (mInfoFoot<>'') and Result then begin
             mInfoFoot :=  oFMPEGAS.ChangeESCCodes (mInfoFoot);
             Result := oFMPEGAS.PrintDocNote (mInfoFoot);
           end;
           If (mBonusFoot<>'') and Result then begin
             mBonusFoot :=  oFMPEGAS.ChangeESCCodes (mBonusFoot);
             Result := oFMPEGAS.PrintDocNote (mBonusFoot);
           end;
           If (mFixFoot<>'') and Result then begin
             mFixFoot :=  oFMPEGAS.ChangeESCCodes (mFixFoot);
             Result := oFMPEGAS.PrintDocNote (mFixFoot);
           end;
         end;
      6: begin
           If mVarFoot<>'' then Result := oFMEFox.PrintDocNote (mVarFoot);
           If (mInfoFoot<>'') and Result then Result := oFMEFox.PrintDocNote (mInfoFoot);
           If (mBonusFoot<>'') and Result then Result := oFMEFox.PrintDocNote (mBonusFoot);
           If (mFixFoot<>'') and Result then Result := oFMEFox.PrintDocNote (mFixFoot);
         end;
    end;
  end;
end;

function  TCasFMHand.PrintDocClose:boolean;
begin
  Result := FALSE;
  If gCasSet.ExtCashBoxSet.Enable then OpenExtCashBox;
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      0: Result := TRUE;
      4: begin
           Result := oFMFT4000.PrintDocClose;
           If Result then begin
             oFMFT4000.OpenCashBox;
             If gFMInfo.CassaID<>'' then begin
               oFullBlk.Text := oFMFT4000.ReadLastDoc;
               SaveToCFile (DecodeStrToSetASCIITbl (oFullBlk.Text, GetASCIITblNum), gPath.CasPath(gCasSet.CassaNum), gCasSet.CassaNum, gCasGlobVals.IntDocQnt, gCasBlk.BlkDate, gCasBlk.BlkTime, 'S', gCasGlobVals.FMDocQnt);
             end;
           end;
           ClosePort;
         end;
      5: begin
           Result := oFMPEGAS.PrintDocClose;
           If Result then begin
             If gFMInfo.CassaID<>'' then begin
               oFullBlk.Text := oFMPEGAS.ReadLastDoc;
               SaveToCFile (DecodeStrToSetASCIITbl (oFullBlk.Text, GetASCIITblNum), gPath.CasPath(gCasSet.CassaNum), gCasSet.CassaNum, gCasGlobVals.IntDocQnt, gCasBlk.BlkDate, gCasBlk.BlkTime, 'S', gCasGlobVals.FMDocQnt);
             end;
           end;
           ClosePort;
         end;
      6: begin
           Result := oFMEFox.PrintDocClose;
           If Result then begin
             If gFMInfo.CassaID<>'' then begin
               oFullBlk.Text := oFMEFox.ReadLastDoc;
               SaveToCFile (DecodeStrToSetASCIITbl (oFullBlk.Text, GetASCIITblNum), gPath.CasPath(gCasSet.CassaNum), gCasSet.CassaNum, gCasGlobVals.IntDocQnt, gCasBlk.BlkDate, gCasBlk.BlkTime, 'S', gCasGlobVals.FMDocQnt);
             end;
           end;
           ClosePort;
         end;
    end;
  end;
end;

function  TCasFMHand.PrintIncDocHead:boolean;
var mHead,mIntHead:string;
begin
  Result := FALSE;
  mHead := '';
  If oBlockHead<>nil then mHead := FillAllFldASCIIConv(oBlockHead.Text);
  mIntHead := '';
  If oIntHeadUse and (oIntHead<>nil) then mIntHead := oIntHead.Text;
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      0..3: begin
              If mIntHead<>'' then AddBlkText(mIntHead);
              AddBlkText(mHead);
              Result := TRUE;
            end;
      4: begin
           If FMIncExp then begin
             If oFMFT4000.ReadPrinterStatus(TRUE) then begin
               Result := oFMFT4000.PrintIncDocHead (mHead);
             end;
           end else begin
              If mIntHead<>'' then AddBlkText(mIntHead);
             AddBlkText(mHead);
             Result := TRUE;
           end;
         end;
      5: begin
           If FMIncExp then begin
             Result := oFMPEGAS.PrintIncDocHead (mHead);
           end else begin
              If mIntHead<>'' then AddBlkText(mIntHead);
             AddBlkText(mHead);
             Result := TRUE;
           end;
         end;
      6: begin
           If FMIncExp then begin
             Result := oFMEFox.PrintIncDocHead (mHead);
           end else begin
              If mIntHead<>'' then AddBlkText(mIntHead);
             AddBlkText(mHead);
             Result := TRUE;
           end;
         end;
    end;
  end;
end;

function  TCasFMHand.PrintIncDocPay (pPayNumID:string;pPayNum:longint;pFMPayNumID:string;pFMPayNum:integer;pPayNameID,pPayName,pExpValID:string;pIncVal:double):boolean;
var mItem:string;
begin
  Result := FALSE;
  SetIntFld(pPayNumID, pPayNum);
  SetIntFld(pFMPayNumID, pFMPayNum);
  SetStrFld(pPayNameID, pPayName);
  SetDoubFld(pExpValID, pIncVal);
  mItem := '';
  If oBlockItem<>nil then mItem := FillAllFldASCIIConv(oBlockItem.Text);
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      0..3: begin
              AddBlkText(mItem);
              Result := TRUE;
            end;
      4: begin
           If FMIncExp then begin
             Result := oFMFT4000.PrintIncDocPay(pFMPayNum, pIncVal);
           end else begin
             AddBlkText(mItem);
             Result := TRUE;
           end;
         end;
      5: begin
           If FMIncExp then begin
             Result := oFMPEGAS.PrintIncDocPay(pFMPayNum, pPayName, pIncVal);
           end else begin
             AddBlkText(mItem);
             Result := TRUE;
           end;
         end;
      6: begin
           If FMIncExp then begin
             Result := oFMEFox.PrintIncDocPay(pFMPayNum, pIncVal);
           end else begin
             AddBlkText(mItem);
             Result := TRUE;
           end;
         end;
    end;
  end;
end;

function  TCasFMHand.PrintIncDocFoot:boolean;
var mFoot:string; I:longint;
begin
  Result := FALSE;
  mFoot := '';
  If oSumFoot<>nil then mFoot := FillAllFldASCIIConv(oSumFoot.Text);
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      0..3: begin
              AddBlkText(mFoot);
              AddBlkFreeLn (oCasFMHandSet.FMPrn.PrnEscSet.LnFeedCnt);
              AddBlkEsc (oCasFMHandSet.FMPrn.PrnEscSet.CutEsc);
              oSallyPrinter.PrintData (oFullBlk.Text+ConvStrToESCCodes (oCasFMHandSet.FMPrn.PrnEscSet.OpenCash));
              SaveToCFile (DecodeStrToSetASCIITbl (oFullBlk.Text, GetASCIITblNum), gPath.CasPath(gCasSet.CassaNum), gCasSet.CassaNum, gCasGlobVals.IntDocQnt, gCasBlk.BlkDate, gCasBlk.BlkTime, 'I', gCasGlobVals.FMDocQnt);
              If oCopies>1 then begin
                For I:=2 to oCopies do
                  oSallyPrinter.PrintData (oFullBlk.Text);
              end;
            end;
      4: begin
           If FMIncExp then begin
             oFullBlk.Text := oFMFT4000.ChangeESCCodes (oFullBlk.Text);
             Result := oFMFT4000.PrintIncDocFoot (mFoot);
             If gFMInfo.CassaID<>'' then begin
               oFullBlk.Text := oFMFT4000.ReadLastDoc;
             end;
           end else begin
             AddBlkText(mFoot);
             AddBlkFreeLn (oCasFMHandSet.FMPrn.PrnEscSet.LnFeedCnt);
             AddBlkEsc (oCasFMHandSet.FMPrn.PrnEscSet.CutEsc);
             oFullBlk.Text := oFMFT4000.ChangeESCCodes (oFullBlk.Text);
             Result := oFMFT4000.PrintIntDoc (oFullBlk.Text);
           end;
           If Result then begin
             oFMFT4000.OpenCashBox;
             SaveToCFile (DecodeStrToSetASCIITbl (oFullBlk.Text, GetASCIITblNum), gPath.CasPath(gCasSet.CassaNum), gCasSet.CassaNum, gCasGlobVals.IntDocQnt, gCasBlk.BlkDate, gCasBlk.BlkTime, 'I', gCasGlobVals.FMDocQnt);
             If oCopies>1 then begin
               For I:=2 to oCopies do
                 oFMFT4000.PrintIntDoc (oFullBlk.Text);
             end;
           end;
         end;
      5: begin
           If FMIncExp then begin
             Result := oFMPEGAS.PrintIncDocFoot (mFoot);
             If gFMInfo.CassaID<>'' then begin
               oFullBlk.Text := oFMPEGAS.ReadLastDoc;
             end;
           end else begin
             AddBlkText(mFoot);
             oFullBlk.Text :=  oFMPEGAS.ChangeESCCodes (oFullBlk.Text);
             Result := oFMPEGAS.PrintIntDoc (oFullBlk.Text);
           end;
           If Result then begin
             oFMPEGAS.OpenCashBox;
             SaveToCFile (DecodeStrToSetASCIITbl (oFullBlk.Text, GetASCIITblNum), gPath.CasPath(gCasSet.CassaNum), gCasSet.CassaNum, gCasGlobVals.IntDocQnt, gCasBlk.BlkDate, gCasBlk.BlkTime, 'I', gCasGlobVals.FMDocQnt);
             If oCopies>1 then begin
               For I:=2 to oCopies do
                 oFMPEGAS.PrintIntDoc (oFullBlk.Text);
             end;
           end;
         end;
      6: begin
           If FMIncExp then begin
             Result := oFMEFox.PrintIncDocFoot (mFoot);
             If gFMInfo.CassaID<>'' then begin
               oFullBlk.Text := oFMEFox.ReadLastDoc;
             end;
           end else begin
             AddBlkText(mFoot);
             Result := oFMEFox.PrintIntDoc (oFullBlk.Text);
           end;
           If Result then begin
             oFMEFox.OpenCashBox;
             SaveToCFile (DecodeStrToSetASCIITbl (oFullBlk.Text, GetASCIITblNum), gPath.CasPath(gCasSet.CassaNum), gCasSet.CassaNum, gCasGlobVals.IntDocQnt, gCasBlk.BlkDate, gCasBlk.BlkTime, 'I', gCasGlobVals.FMDocQnt);
             If oCopies>1 then begin
               For I:=2 to oCopies do
                 oFMEFox.PrintIntDoc (oFullBlk.Text);
             end;
           end;
         end;
    end;
  end;
end;

function  TCasFMHand.PrintExpDocHead:boolean;
var mMyOpen:boolean; mHead,mIntHead:string;
begin
  Result := FALSE;
  mHead := '';
  If oBlockHead<>nil then mHead := FillAllFldASCIIConv(oBlockHead.Text);
  mIntHead := '';
  If oIntHeadUse and (oIntHead<>nil) then mIntHead := oIntHead.Text;
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      0..3: begin
              If mIntHead<>'' then AddBlkText(mIntHead);
              AddBlkText(mHead);
              Result := TRUE;
            end;
      4: begin
           If FMIncExp then begin
             Result := oFMFT4000.PrintExpDocHead (mHead);
           end else begin
              If mIntHead<>'' then AddBlkText(mIntHead);
             AddBlkText(mHead);
             Result := TRUE;
           end;
         end;
      5: begin
           If FMIncExp then begin
             Result := oFMPEGAS.PrintExpDocHead (mHead);
           end else begin
              If mIntHead<>'' then AddBlkText(mIntHead);
             AddBlkText(mHead);
             Result := TRUE;
           end;
         end;
      6: begin
           If FMIncExp then begin
             Result := oFMEFox.PrintExpDocHead (mHead);
           end else begin
              If mIntHead<>'' then AddBlkText(mIntHead);
             AddBlkText(mHead);
             Result := TRUE;
           end;
         end;
    end;
  end;
end;

function  TCasFMHand.PrintExpDocPay (pPayNumID:string;pPayNum:longint;pFMPayNumID:string;pFMPayNum:integer;pPayNameID,pPayName,pExpValID:string;pExpVal:double):boolean;
var mItem:string;
begin
  Result := FALSE;
  SetIntFld(pPayNumID, pPayNum);
  SetIntFld(pFMPayNumID, pFMPayNum);
  SetStrFld(pPayNameID, pPayName);
  SetDoubFld(pExpValID, pExpVal);
  mItem := '';
  If oBlockItem<>nil then mItem := FillAllFldASCIIConv(oBlockItem.Text);
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      0..3: begin
              AddBlkText(mItem);
              Result := TRUE;
            end;
      4: begin
           If FMIncExp then begin
             Result := oFMFT4000.PrintExpDocPay(pFMPayNum, pExpVal);
           end else begin
             AddBlkText(mItem);
             Result := TRUE;
           end;
         end;
      5: begin
           If FMIncExp then begin
             Result := oFMPEGAS.PrintExpDocPay(pFMPayNum, pPayName, pExpVal);
           end else begin
             AddBlkText(mItem);
             Result := TRUE;
           end;
         end;
      6: begin
           If FMIncExp then begin
             Result := oFMEFox.PrintExpDocPay(pFMPayNum, pExpVal);
           end else begin
             AddBlkText(mItem);
             Result := TRUE;
           end;
         end;
    end;
  end;
end;

function  TCasFMHand.PrintExpDocFoot:boolean;
var mFoot:string; I:longint;
begin
  Result := FALSE;
  mFoot := '';
  If oSumFoot<>nil then mFoot := FillAllFldASCIIConv(oSumFoot.Text);
  If gCasSet.ExtCashBoxSet.Enable then OpenExtCashBox;
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      0..3: begin
              AddBlkText(mFoot);
              AddBlkFreeLn (oCasFMHandSet.FMPrn.PrnEscSet.LnFeedCnt);
              AddBlkEsc (oCasFMHandSet.FMPrn.PrnEscSet.CutEsc);
              oSallyPrinter.PrintData (oFullBlk.Text+ConvStrToESCCodes (oCasFMHandSet.FMPrn.PrnEscSet.OpenCash));
              SaveToCFile (DecodeStrToSetASCIITbl (oFullBlk.Text, GetASCIITblNum), gPath.CasPath(gCasSet.CassaNum), gCasSet.CassaNum, gCasGlobVals.IntDocQnt, gCasBlk.BlkDate, gCasBlk.BlkTime, 'O', gCasGlobVals.FMDocQnt);
              If oCopies>1 then begin
                For I:=2 to oCopies do
                  oSallyPrinter.PrintData (oFullBlk.Text);
              end;
              Result := TRUE;
            end;
      4: begin
           If FMIncExp then begin
             mFoot :=  oFMFT4000.ChangeESCCodes (mFoot);
             Result := oFMFT4000.PrintExpDocFoot (mFoot);
             If gFMInfo.CassaID<>'' then begin
               oFullBlk.Text := oFMFT4000.ReadLastDoc;
             end;
           end else begin
             AddBlkText(mFoot);
             AddBlkFreeLn (oCasFMHandSet.FMPrn.PrnEscSet.LnFeedCnt);
             AddBlkEsc (oCasFMHandSet.FMPrn.PrnEscSet.CutEsc);
             oFullBlk.Text :=  oFMFT4000.ChangeESCCodes (oFullBlk.Text);
             Result := oFMFT4000.PrintIntDoc (oFullBlk.Text);
           end;
           oFMFT4000.OpenCashBox;
           If Result  then begin
             SaveToCFile (DecodeStrToSetASCIITbl (oFullBlk.Text, GetASCIITblNum), gPath.CasPath(gCasSet.CassaNum), gCasSet.CassaNum, gCasGlobVals.IntDocQnt, gCasBlk.BlkDate, gCasBlk.BlkTime, 'O', gCasGlobVals.FMDocQnt);
             If oCopies>1 then begin
               For I:=2 to oCopies do
                 oFMFT4000.PrintIntDoc (oFullBlk.Text);
             end;
           end;
         end;
      5: begin
           If FMIncExp then begin
             Result := oFMPEGAS.PrintExpDocFoot (mFoot);
             If gFMInfo.CassaID<>'' then begin
               oFullBlk.Text := oFMPEGAS.ReadLastDoc;
             end;
           end else begin
             AddBlkText(mFoot);
             oFullBlk.Text :=  oFMPEGAS.ChangeESCCodes (oFullBlk.Text);
             Result := oFMPEGAS.PrintIntDoc (oFullBlk.Text);
           end;
           oFMPEGAS.OpenCashBox;
           If Result  then begin
             SaveToCFile (DecodeStrToSetASCIITbl (oFullBlk.Text, GetASCIITblNum), gPath.CasPath(gCasSet.CassaNum), gCasSet.CassaNum, gCasGlobVals.IntDocQnt, gCasBlk.BlkDate, gCasBlk.BlkTime, 'O', gCasGlobVals.FMDocQnt);
             If oCopies>1 then begin
               For I:=2 to oCopies do
                 oFMPEGAS.PrintIntDoc (oFullBlk.Text);
             end;
           end;
         end;
      6: begin
           If FMIncExp then begin
             Result := oFMEFox.PrintExpDocFoot (mFoot);
             If gFMInfo.CassaID<>'' then begin
               oFullBlk.Text := oFMEFox.ReadLastDoc;
             end;
           end else begin
             AddBlkText(mFoot);
             AddBlkFreeLn (oCasFMHandSet.FMPrn.PrnEscSet.LnFeedCnt);
             AddBlkEsc (oCasFMHandSet.FMPrn.PrnEscSet.CutEsc);
             Result := oFMEFox.PrintIntDoc (oFullBlk.Text);
           end;
           oFMEFox.OpenCashBox;
           If Result  then begin
             SaveToCFile (DecodeStrToSetASCIITbl (oFullBlk.Text, GetASCIITblNum), gPath.CasPath(gCasSet.CassaNum), gCasSet.CassaNum, gCasGlobVals.IntDocQnt, gCasBlk.BlkDate, gCasBlk.BlkTime, 'O', gCasGlobVals.FMDocQnt);
             If oCopies>1 then begin
               For I:=2 to oCopies do
                 oFMEFox.PrintIntDoc (oFullBlk.Text);
             end;
           end;
         end;
    end;
  end;
end;

function  TCasFMHand.PrintChgDocHead:boolean;
var mHead,mIntHead:string;
begin
  Result := FALSE;
  mHead := '';
  If oBlockHead<>nil then mHead := FillAllFldASCIIConv(oBlockHead.Text);
  mIntHead := '';
  If oIntHeadUse and (oIntHead<>nil) then mIntHead := oIntHead.Text;
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      0..4, 6: begin
              If mIntHead<>'' then AddBlkText(mIntHead);
              AddBlkText(mHead);
              Result := TRUE;
            end;
      5: begin
           If FMIncExp then begin
             Result := oFMPEGAS.PrintChgDocHead (mHead);
           end else begin
             If mIntHead<>'' then AddBlkText(mIntHead);
             AddBlkText(mHead);
             Result := TRUE;
           end;
         end;
    end;
  end;
end;

function  TCasFMHand.PrintChgDocPay (pExpPayNumID:string;pExpPayNum:longint;pFMExpPayNumID:string;pFMExpPayNum:integer;pExpPayNameID,pExpPayName,pIncPayNumID:string;pIncPayNum:longint;pFMIncPayNumID:string;pFMIncPayNum:integer;pIncPayNameID,pIncPayName,pValID:string;pVal:double):boolean;
var mItem:string;
begin
  Result := FALSE;
  SetIntFld(pExpPayNumID, pExpPayNum);
  SetIntFld(pFMExpPayNumID, pFMExpPayNum);
  SetStrFld(pExpPayNameID, pExpPayName);
  SetIntFld(pIncPayNumID, pIncPayNum);
  SetIntFld(pFMIncPayNumID, pFMIncPayNum);
  SetStrFld(pIncPayNameID, pIncPayName);
  SetDoubFld(pValID, pVal);
  mItem := '';
  If oBlockItem<>nil then mItem := FillAllFldASCIIConv(oBlockItem.Text);
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      0..4, 6: begin
              AddBlkText(mItem);
              Result := TRUE;
            end;
      5: begin
           If FMIncExp then begin
             Result := oFMPEGAS.PrintChgDocPay(pFMIncPayNum, pFMExpPayNum, pIncPayName, pExpPayName, pVal);
           end else begin
             AddBlkText(mItem);
             Result := TRUE;
           end;
         end;
    end;
  end;
end;

function  TCasFMHand.PrintChgDocFoot:boolean;
var mFoot:string; I:longint;
begin
  Result := FALSE;
  mFoot := '';
  If oSumFoot<>nil then mFoot := FillAllFldASCIIConv(oSumFoot.Text);
  If gCasSet.ExtCashBoxSet.Enable then OpenExtCashBox;
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      0..3: begin
              AddBlkText(mFoot);
              AddBlkFreeLn (oCasFMHandSet.FMPrn.PrnEscSet.LnFeedCnt);
              AddBlkEsc (oCasFMHandSet.FMPrn.PrnEscSet.CutEsc);
              oSallyPrinter.PrintData (oFullBlk.Text+ConvStrToESCCodes (oCasFMHandSet.FMPrn.PrnEscSet.OpenCash));
              SaveToCFile (DecodeStrToSetASCIITbl (oFullBlk.Text, GetASCIITblNum), gPath.CasPath(gCasSet.CassaNum), gCasSet.CassaNum, gCasGlobVals.IntDocQnt, gCasBlk.BlkDate, gCasBlk.BlkTime, 'X', gCasGlobVals.FMDocQnt);
              If oCopies>1 then begin
                For I:=2 to oCopies do
                  oSallyPrinter.PrintData (oFullBlk.Text);
              end;
              Result := TRUE;
            end;
      4: begin
           AddBlkText(mFoot);
           AddBlkFreeLn (oCasFMHandSet.FMPrn.PrnEscSet.LnFeedCnt);
           AddBlkEsc (oCasFMHandSet.FMPrn.PrnEscSet.CutEsc);
           oFullBlk.Text := oFMFT4000.ChangeESCCodes (oFullBlk.Text);
           Result := oFMFT4000.PrintIntDoc (oFullBlk.Text);
           If Result then begin
             oFMFT4000.OpenCashBox;
             SaveToCFile (DecodeStrToSetASCIITbl (oFullBlk.Text, GetASCIITblNum), gPath.CasPath(gCasSet.CassaNum), gCasSet.CassaNum, gCasGlobVals.IntDocQnt, gCasBlk.BlkDate, gCasBlk.BlkTime, 'X', gCasGlobVals.FMDocQnt);
             If oCopies>1 then begin
               For I:=2 to oCopies do begin
                 oFMFT4000.PrintIntDoc (oFullBlk.Text);
               end;
             end;
           end;
         end;
      5: begin
           If FMIncExp then begin
             Result := oFMPEGAS.PrintChgDocFoot (mFoot);
             If gFMInfo.CassaID<>'' then begin
               oFullBlk.Text := oFMPEGAS.ReadLastDoc;
             end;
           end else begin
             AddBlkText(mFoot);
             oFullBlk.Text := oFMPEGAS.ChangeESCCodes (oFullBlk.Text);
             Result := oFMPEGAS.PrintIntDoc (oFullBlk.Text);
           end;
           oFMPEGAS.OpenCashBox;
           If Result  then begin
             SaveToCFile (DecodeStrToSetASCIITbl (oFullBlk.Text, GetASCIITblNum), gPath.CasPath(gCasSet.CassaNum), gCasSet.CassaNum, gCasGlobVals.IntDocQnt, gCasBlk.BlkDate, gCasBlk.BlkTime, 'X', gCasGlobVals.FMDocQnt);
             If oCopies>1 then begin
               For I:=2 to oCopies do
                 oFMPEGAS.PrintIntDoc (oFullBlk.Text);
             end;
           end;
         end;
      6: begin
           AddBlkText(mFoot);
           AddBlkFreeLn (oCasFMHandSet.FMPrn.PrnEscSet.LnFeedCnt);
           AddBlkEsc (oCasFMHandSet.FMPrn.PrnEscSet.CutEsc);
           Result := oFMEFox.PrintIntDoc (oFullBlk.Text);
           If Result then begin
             oFMEFox.OpenCashBox;
             SaveToCFile (DecodeStrToSetASCIITbl (oFullBlk.Text, GetASCIITblNum), gPath.CasPath(gCasSet.CassaNum), gCasSet.CassaNum, gCasGlobVals.IntDocQnt, gCasBlk.BlkDate, gCasBlk.BlkTime, 'X', gCasGlobVals.FMDocQnt);
             If oCopies>1 then begin
               For I:=2 to oCopies do begin
                 oFMEFox.PrintIntDoc (oFullBlk.Text);
               end;
             end;
           end;
         end;
    end;
  end;
end;

function  TCasFMHand.PrintChgDocOHead:boolean;
var mHead,mIntHead:string;
begin
  Result := FALSE;
  mHead := '';
  If oBlockHead<>nil then mHead := FillAllFldASCIIConv(oBlockHead.Text);
  mIntHead := '';
  If oIntHeadUse and (oIntHead<>nil) then mIntHead := oIntHead.Text;
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      4: Result := oFMFT4000.PrintExpDocHead (mHead);
      6: Result := oFMEFox.PrintExpDocHead (mHead);
    end;
  end;
end;

function  TCasFMHand.PrintChgDocOPay (pExpPayNumID:string;pExpPayNum:longint;pFMExpPayNumID:string;pFMExpPayNum:integer;pExpPayNameID,pExpPayName,pIncPayNumID:string;pIncPayNum:longint;pFMIncPayNumID:string;pFMIncPayNum:integer;pIncPayNameID,pIncPayName,pValID:string;pVal:double):boolean;
var mItem:string;
begin
  Result := FALSE;
  SetIntFld(pExpPayNumID, pExpPayNum);
  SetIntFld(pFMExpPayNumID, pFMExpPayNum);
  SetStrFld(pExpPayNameID, pExpPayName);
  SetIntFld(pIncPayNumID, pIncPayNum);
  SetIntFld(pFMIncPayNumID, pFMIncPayNum);
  SetStrFld(pIncPayNameID, pIncPayName);
  SetDoubFld(pValID, pVal);
  mItem := '';
  If oBlockItem<>nil then mItem := FillAllFldASCIIConv(oBlockItem.Text);
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      4: Result := oFMFT4000.PrintExpDocPay(pFMExpPayNum,pVal);
      6: Result := oFMEFox.PrintExpDocPay(pFMExpPayNum,pVal);
    end;
  end;
end;

function  TCasFMHand.PrintChgDocOFoot:boolean;
var mFoot:string; I:longint;
begin
  Result := FALSE;
  mFoot := '';
  If oSumFoot<>nil then mFoot := FillAllFldASCIIConv(oSumFoot.Text);
  If gCasSet.ExtCashBoxSet.Enable then OpenExtCashBox;
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      4: begin
           Result := oFMFT4000.PrintExpDocFoot (mFoot);
           If Result then begin
             If gFMInfo.CassaID<>'' then begin
               oFullBlk.Text := oFMFT4000.ReadLastDoc;
             end;
             oFMFT4000.OpenCashBox;
             SaveToCFile (DecodeStrToSetASCIITbl (oFullBlk.Text, GetASCIITblNum), gPath.CasPath(gCasSet.CassaNum), gCasSet.CassaNum, gCasGlobVals.IntDocQnt, gCasBlk.BlkDate, gCasBlk.BlkTime, 'O', gCasGlobVals.FMDocQnt);
             If oCopies>1 then begin
               For I:=2 to oCopies do
                 oFMFT4000.PrintIntDoc (oFullBlk.Text);
             end;
           end;
         end;
      6: begin
           Result := oFMEFox.PrintExpDocFoot (mFoot);
           If Result then begin
             If gFMInfo.CassaID<>'' then begin
               oFullBlk.Text := oFMEFox.ReadLastDoc;
             end;
             oFMEFox.OpenCashBox;
             SaveToCFile (DecodeStrToSetASCIITbl (oFullBlk.Text, GetASCIITblNum), gPath.CasPath(gCasSet.CassaNum), gCasSet.CassaNum, gCasGlobVals.IntDocQnt, gCasBlk.BlkDate, gCasBlk.BlkTime, 'O', gCasGlobVals.FMDocQnt);
             If oCopies>1 then begin
               For I:=2 to oCopies do
                 oFMEFox.PrintIntDoc (oFullBlk.Text);
             end;
           end;
         end;
    end;
  end;
end;

function  TCasFMHand.PrintChgDocIHead:boolean;
var mHead,mIntHead:string;
begin
  Result := FALSE;
  mHead := '';
  If oBlockHead<>nil then mHead := FillAllFldASCIIConv(oBlockHead.Text);
  mIntHead := '';
  If oIntHeadUse and (oIntHead<>nil) then mIntHead := oIntHead.Text;
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      4: Result := oFMFT4000.PrintIncDocHead (mHead);
      6: Result := oFMEFox.PrintIncDocHead (mHead);
    end;
  end;
end;

function  TCasFMHand.PrintChgDocIPay (pExpPayNumID:string;pExpPayNum:longint;pFMExpPayNumID:string;pFMExpPayNum:integer;pExpPayNameID,pExpPayName,pIncPayNumID:string;pIncPayNum:longint;pFMIncPayNumID:string;pFMIncPayNum:integer;pIncPayNameID,pIncPayName,pValID:string;pVal:double):boolean;
var mItem:string;
begin
  Result := FALSE;
  SetIntFld(pExpPayNumID, pExpPayNum);
  SetIntFld(pFMExpPayNumID, pFMExpPayNum);
  SetStrFld(pExpPayNameID, pExpPayName);
  SetIntFld(pIncPayNumID, pIncPayNum);
  SetIntFld(pFMIncPayNumID, pFMIncPayNum);
  SetStrFld(pIncPayNameID, pIncPayName);
  SetDoubFld(pValID, pVal);
  mItem := '';
  If oBlockItem<>nil then mItem := FillAllFldASCIIConv(oBlockItem.Text);
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      4: Result := oFMFT4000.PrintIncDocPay(pFMIncPayNum,pVal);
      6: Result := oFMEFox.PrintIncDocPay(pFMIncPayNum,pVal);
    end;
  end;
end;

function  TCasFMHand.PrintChgDocIFoot:boolean;
var mFoot:string; I:longint;
begin
  Result := FALSE;
  mFoot := '';
  If oSumFoot<>nil then mFoot := FillAllFldASCIIConv(oSumFoot.Text);
  If gCasSet.ExtCashBoxSet.Enable then OpenExtCashBox;
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      4: begin
           Result := oFMFT4000.PrintIncDocFoot (mFoot);
           If Result then begin
             If gFMInfo.CassaID<>'' then begin
               oFullBlk.Text := oFMFT4000.ReadLastDoc;
               oFMFT4000.OpenCashBox;
               SaveToCFile (DecodeStrToSetASCIITbl (oFullBlk.Text, GetASCIITblNum), gPath.CasPath(gCasSet.CassaNum), gCasSet.CassaNum, gCasGlobVals.IntDocQnt, gCasBlk.BlkDate, gCasBlk.BlkTime, 'X', gCasGlobVals.FMDocQnt);
               If oCopies>1 then begin
                 For I:=2 to oCopies do
                   oFMFT4000.PrintIntDoc (oFullBlk.Text);
               end;
             end;
           end;
         end;
      6: begin
           Result := oFMEFox.PrintIncDocFoot (mFoot);
           If Result then begin
             If gFMInfo.CassaID<>'' then begin
               oFullBlk.Text := oFMEFox.ReadLastDoc;
               oFMEFox.OpenCashBox;
               SaveToCFile (DecodeStrToSetASCIITbl (oFullBlk.Text, GetASCIITblNum), gPath.CasPath(gCasSet.CassaNum), gCasSet.CassaNum, gCasGlobVals.IntDocQnt, gCasBlk.BlkDate, gCasBlk.BlkTime, 'X', gCasGlobVals.FMDocQnt);
               If oCopies>1 then begin
                 For I:=2 to oCopies do
                   oFMEFox.PrintIntDoc (oFullBlk.Text);
               end;
             end;
           end;
         end;
    end;
  end;
end;

procedure TCasFMHand.PrintHead;
var mHead,mIntHead:string;
begin
  mHead := '';
  If oBlockHead<>nil then mHead := FillAllFldASCIIConv(oBlockHead.Text);
  mIntHead := '';
  If oIntHeadUse and (oIntHead<>nil) then mIntHead := oIntHead.Text;
  If mIntHead<>'' then AddBlkText(mIntHead);
  If mHead<>'' then AddBlkText(mHead);
end;

procedure TCasFMHand.PrintItem;
var mItem:string;
begin
  mItem := '';
  If oBlockItem<>nil then mItem := FillAllFldASCIIConv(oBlockItem.Text);
  If mItem<>'' then AddBlkText(mItem);
end;

procedure TCasFMHand.PrintSubHead;
var mSubHead:string;
begin
  mSubHead := '';
  If oSubHead<>nil then mSubHead := FillAllFldASCIIConv(oSubHead.Text);
  If mSubHead<>'' then AddBlkText(mSubHead);
end;

procedure TCasFMHand.PrintSubFoot;
var mSubFoot:string;
begin
  mSubFoot := '';
  If oSubFoot<>nil then mSubFoot := FillAllFldASCIIConv(oSubFoot.Text);
  If mSubFoot<>'' then AddBlkText(mSubFoot);
end;

procedure TCasFMHand.PrintAppHead;
var mAppHead:string;
begin
  mAppHead := '';
  If oAppHead<>nil then mAppHead := FillAllFldASCIIConv(oAppHead.Text);
  If mAppHead<>'' then begin
    If oAppData=nil then oAppData := TStringList.Create;
    oAppData.Text := oAppData.Text+mAppHead;
  end;
end;

procedure TCasFMHand.PrintAppItem;
var mAppItem:string;
begin
  mAppItem := '';
  If oAppItem<>nil then mAppItem := FillAllFldASCIIConv(oAppItem.Text);
  If mAppItem<>'' then begin
    If oAppData=nil then oAppData := TStringList.Create;
    oAppData.Text := oAppData.Text+mAppItem;
  end;
end;

function  TCasFMHand.PrintFoot (pDocType:string):boolean;
var mFoot, mS:string; I:longint;
begin
  Result := FALSE;
  mFoot := '';
  If oSumFoot<>nil then mFoot := FillAllFldASCIIConv(oSumFoot.Text);
  If mFoot<>'' then AddBlkText(mFoot);
  If oAppData<>nil then AddBlkText(oAppData.Text);
  If gCasSet.ExtCashBoxSet.Enable then OpenExtCashBox;
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      0..3: begin
              For I:=1 to oCopies do
                oSallyPrinter.PrintData (oFullBlk.Text);
              SaveToCFile (DecodeStrToSetASCIITbl (oFullBlk.Text, GetASCIITblNum), gPath.CasPath(gCasSet.CassaNum), gCasSet.CassaNum, gCasGlobVals.IntDocQnt, gCasBlk.BlkDate, gCasBlk.BlkTime, pDocType, gCasGlobVals.LocalDocQnt);
              Result := TRUE;
            end;
      4: begin
           AddBlkFreeLn (oCasFMHandSet.FMPrn.PrnEscSet.LnFeedCnt);
           AddBlkEsc (oCasFMHandSet.FMPrn.PrnEscSet.CutEsc);
           oFullBlk.Text := oFMFT4000.ChangeESCCodes (oFullBlk.Text);
           Result := oFMFT4000.PrintIntDoc (oFullBlk.Text);
           If Result then begin
             For I:=2 to oCopies do
               oFMFT4000.PrintIntDoc (oFullBlk.Text);
             SaveToCFile (DecodeStrToSetASCIITbl (oFullBlk.Text, GetASCIITblNum), gPath.CasPath(gCasSet.CassaNum), gCasSet.CassaNum, gCasGlobVals.IntDocQnt, gCasBlk.BlkDate, gCasBlk.BlkTime, pDocType, gCasGlobVals.LocalDocQnt);
           end;
         end;
      5: begin
           oFullBlk.Text := oFMPEGAS.ChangeESCCodes (oFullBlk.Text);
           Result := oFMPEGAS.PrintIntDoc (oFullBlk.Text);
           If Result then begin
             For I:=2 to oCopies do
               oFMPEGAS.PrintIntDoc (oFullBlk.Text);
             SaveToCFile (DecodeStrToSetASCIITbl (oFullBlk.Text, GetASCIITblNum), gPath.CasPath(gCasSet.CassaNum), gCasSet.CassaNum, gCasGlobVals.IntDocQnt, gCasBlk.BlkDate, gCasBlk.BlkTime, pDocType, gCasGlobVals.LocalDocQnt);
           end;
         end;
      6: begin
           Result := oFMEFox.PrintIntDoc (oFullBlk.Text);
           If Result then begin
             For I:=2 to oCopies do
               oFMEFox.PrintIntDoc (oFullBlk.Text);
             SaveToCFile (DecodeStrToSetASCIITbl (oFullBlk.Text, GetASCIITblNum), gPath.CasPath(gCasSet.CassaNum), gCasSet.CassaNum, gCasGlobVals.IntDocQnt, gCasBlk.BlkDate, gCasBlk.BlkTime, pDocType, gCasGlobVals.LocalDocQnt);
           end;
         end;
    end;
  end else begin
    If oPrnNum in [1..3] then begin
      AddBlkFreeLn (oCasFMHandSet.ExtPrn[oPrnNum].PrnEscSet.LnFeedCnt);
      mS := '';
      If oCasFMHandSet.ExtPrn[oPrnNum].PrnEscSet.CutEsc<>'' then mS := mS+ConvStrToESCCodes (oCasFMHandSet.ExtPrn[oPrnNum].PrnEscSet.CutEsc);
      If oCasFMHandSet.ExtPrn[oPrnNum].PrnEscSet.OpenCash<>'' then mS := mS+ConvStrToESCCodes (oCasFMHandSet.ExtPrn[oPrnNum].PrnEscSet.OpenCash);
      If oCasFMHandSet.ExtPrn[oPrnNum].PrnEscSet.DoubleOn<>'' then oFullBlk.Text := oSallyPrinter.ChangeESCCodes (oFullBlk.Text, '[', ']', ConvStrToESCCodes (oCasFMHandSet.ExtPrn[oPrnNum].PrnEscSet.BoldOn), ConvStrToESCCodes (oCasFMHandSet.ExtPrn[oPrnNum].PrnEscSet.BoldOff));
      If oCasFMHandSet.ExtPrn[oPrnNum].PrnEscSet.BoldOn<>'' then oFullBlk.Text := oSallyPrinter.ChangeESCCodes (oFullBlk.Text, '{', '}', ConvStrToESCCodes (oCasFMHandSet.ExtPrn[oPrnNum].PrnEscSet.DoubleOn), ConvStrToESCCodes (oCasFMHandSet.ExtPrn[oPrnNum].PrnEscSet.DoubleOff));
      For I:=1 to oCopies do
        Result := oSallyPrinter.PrintData (oFullBlk.Text+mS);
      SaveToCFile (DecodeStrToSetASCIITbl (oFullBlk.Text, GetASCIITblNum), gPath.CasPath(gCasSet.CassaNum), gCasSet.CassaNum, gCasGlobVals.IntDocQnt, gCasBlk.BlkDate, gCasBlk.BlkTime, pDocType, gCasGlobVals.LocalDocQnt);
    end;
  end;
end;

function  TCasFMHand.PrintIClose:boolean;
begin
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      4: oFMFT4000.PrintIClose;
      5: oFMPEGAS.PrintIClose;
      6: oFMEFox.PrintIClose;
    end;
  end;
end;

function  TCasFMHand.PrintDClose:boolean;
var I, mDocNum:longint; mS:string; mTime:TDateTime;
begin
  Result := FALSE;
  ClearDCloseVals;
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      4: begin
           oFMFT4000.oFT4000Err.DCloseRequiredShowErr := FALSE;
           If oFMFT4000.ReadPrinterStatus(TRUE) then begin
             oFMFT4000.oFT4000Err.DCloseRequiredShowErr := TRUE;
             If oFMFT4000.ReadInfo(FALSE) then begin
               mDocNum := oFMFT4000.oInfo.DCloseNum;
               If oFMFT4000.PrintDClose then begin
                 If oFMFT4000.ReadInfo(TRUE) then begin
                   If gFMInfo.CassaID<>'' then begin
                     If mDocNum<>oFMFT4000.oInfo.DCloseNum then begin
                       gCasGlobVals.FMDocQnt := oFMFT4000.oInfo.FMDocNum;
                       gCasGlobVals.DDocQnt := oFMFT4000.oInfo.FMDocNum;
                       Result := oFMFT4000.ReadDCloseVals(oFMFT4000.oInfo.DCloseNum);
                       oFullBlk.Text := oFMFT4000.ReadLastDoc;
                       SaveToCFile (DecodeStrToSetASCIITbl (oFullBlk.Text, GetASCIITblNum), gPath.CasPath(gCasSet.CassaNum), gCasSet.CassaNum, gCasGlobVals.IntDocQnt, gCasBlk.BlkDate, gCasBlk.BlkTime, 'D', oFMFT4000.oInfo.DCloseNum);
                       For I:=2 to oCopies do
                         oFMFT4000.PrintIntDoc (oFullBlk.Text);
                     end;
                   end else Result := TRUE;
                 end;
               end;
             end;
           end;
         end;
      5: begin
           mDocNum := oFMPEGAS.GetDCloseNum-2;
           If oFMPEGAS.ReadDCloseVals then begin
             If oFMPEGAS.PrintDClose then begin
               Wait(1000);
               mTime := IncMilliSecond (Now, 10000);
               Repeat
                 mS := oFMPEGAS.GetStatus;
                 If mS<>'0' then Wait(400);
                 Application.ProcessMessages;
               until (mS='0') or (mTime<Now);
               If gFMInfo.CassaID<>'' then begin
                 If oFMPEGAS.ReadDCloseData (mDocNum) then begin
                   oFMPEGAS.oInfo.FMDocNum := oFMPEGAS.GetFMDocNum;
                   gCasGlobVals.FMDocQnt := oFMPEGAS.oInfo.FMDocNum;
                   gCasGlobVals.DDocQnt := oFMPEGAS.oInfo.FMDocNum;
                   Result := TRUE;
                   oFullBlk.Text := oFMPEGAS.ReadLastDoc;
                   SaveToCFile (DecodeStrToSetASCIITbl (oFullBlk.Text, GetASCIITblNum), gPath.CasPath(gCasSet.CassaNum), gCasSet.CassaNum, gCasGlobVals.IntDocQnt, gCasBlk.BlkDate, gCasBlk.BlkTime, 'D', gCasClsVals.ClsNum);
                   For I:=2 to oCopies do
                     oFMPEGAS.PrintIntDoc (oFullBlk.Text);
                 end;
               end else Result := TRUE;
             end;
           end;
         end;
      6: begin
           mDocNum := oFMEFox.GetDCloseNum;
           gCasGlobVals.FMDocQnt := oFMEFox.GetFMDocNum;
           gCasGlobVals.DDocQnt := gCasGlobVals.FMDocQnt;
           If oFMEFox.ReadDCloseVals then begin
             If oFMEFox.PrintDClose then begin
               If gFMInfo.CassaID<>'' then begin
                 gCasClsVals.ClsNum := oFMEFox.GetDCloseNum;
                 Result := TRUE;
                 oFullBlk.Text := oFMEFox.ReadLastDoc;
                 SaveToCFile (DecodeStrToSetASCIITbl (oFullBlk.Text, GetASCIITblNum), gPath.CasPath(gCasSet.CassaNum), gCasSet.CassaNum, gCasGlobVals.IntDocQnt, gCasBlk.BlkDate, gCasBlk.BlkTime, 'D', gCasClsVals.ClsNum);
                 For I:=2 to oCopies do
                   oFMEFox.PrintIntDoc (oFullBlk.Text);
               end else Result := TRUE;
             end;
           end;
         end;
    end;
  end;
end;

function  TCasFMHand.PrintMClose:boolean;
var I:longint;
begin
  Result := FALSE;
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      4: begin
           For I:=1 to oCopies do
             Result := oFMFT4000.PrintMClose;
         end;
      5: begin
           For I:=1 to oCopies do
             Result := oFMPEGAS.PrintMClose;
         end;
      6: begin
           For I:=1 to oCopies do
             Result := oFMEFox.PrintMClose;
         end;
    end;
  end;
end;

function  TCasFMHand.PrintIntDateClose (pDateF, pDateL:TDate; pDetails:boolean):boolean;
var I:longint;
begin
  Result := FALSE;
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      4: Result := oFMFT4000.PrintIntDateClose (pDateF, pDateL, pDetails);
      5: Result := oFMPEGAS.PrintIntDateClose (pDateF, pDateL, pDetails);
      6: Result := oFMEFox.PrintIntDateClose (pDateF, pDateL, pDetails);
    end;
  end;
end;

function  TCasFMHand.PrintIntNumClose (pNumF, pNumL:longint; pDetails:boolean):boolean;
var I:longint;
begin
  Result := FALSE;
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      4: Result := oFMFT4000.PrintIntNumClose (pNumF, pNumL, pDetails);
      5: Result := oFMPEGAS.PrintIntNumClose (pNumF, pNumL, pDetails);
      6: Result := oFMEFox.PrintIntNumClose (pNumF, pNumL, pDetails);
    end;
  end;
end;

function  TCasFMHand.PrintLastBlock:boolean;
var I:longint;
begin
  Result := FALSE;
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      4: begin
           For I:=1 to oCopies do
             Result := oFMFT4000.PrintLastBlock;
         end;
      5: begin
           For I:=1 to oCopies do
             Result := oFMPEGAS.PrintLastBlock;
         end;
      6: begin
           For I:=1 to oCopies do
             Result := oFMEFox.PrintLastBlock;
         end;
    end;
  end;
end;

function  TCasFMHand.ExportJournal:boolean;
var I:longint;
begin
  Result := FALSE;
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      6: Result := oFMEFox.ExportJournal;
      else Result := TRUE;
    end;
  end else Result := TRUE;
end;

function  TCasFMHand.WriteToDispO:boolean;
var mText:string;
begin
  Result := FALSE;
  mText := '';
  If oIntDispO<>nil then mText := FillAllFld(oIntDispO.Text);
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      4: begin
           mText := ConvToNoDiakr(mText);
           Result := oFMFT4000.WriteToDisp(zFF);
           Result := oFMFT4000.WriteToDisp(mText);
         end;
      5: begin
//           mText := Win1250ToLatin2(mText);
           mText := ConvToNoDiakr(mText);
           Result := oFMPEGAS.WriteToDisp(mText, oCasFMHandSet.FMPrn.PrnEscSet.DispType);
         end;
      6: begin
           Result := oFMEFox.WriteToDisp(mText);
         end;
    end;
  end;
  If oCasFMHandSet.ExtDisp.DispUse and (oExtDispO<>nil) then begin
    mText := FillAllFld(oExtDispO.Text);
    mText := ConvToNoDiakr(mText);
    WriteToExtDisp (mText);
  end;
end;

function  TCasFMHand.WriteToDispI:boolean;
var mText:string; I:longint; mSList:TStringList;
begin
  Result := FALSE;
  mText := '';
  If oIntDispI<>nil then mText := FillAllFld(oIntDispI.Text);
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      4: begin
           mText := ConvToNoDiakr(mText);
           Result := oFMFT4000.WriteToDisp(mText);
         end;
      5: begin
//           mText := Win1250ToLatin2(mText);
           mText := ConvToNoDiakr(mText);
           Result := oFMPEGAS.WriteToDisp(mText, oCasFMHandSet.FMPrn.PrnEscSet.DispType);
         end;
      6: begin
           Result := oFMEFox.WriteToDisp(mText);
         end;
    end;
  end;
  If oCasFMHandSet.ExtDisp.DispUse and (oExtDispI<>nil) then begin
    mText := FillAllFld(oExtDispI.Text);
    mText := ConvToNoDiakr(mText);
    WriteToExtDisp (mText);
  end;
end;

function  TCasFMHand.WriteToDispM:boolean;
var mText:string;
begin
  Result := FALSE;
  mText := '';
  If oIntDispM<>nil then mText := FillAllFld(oIntDispM.Text);
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      4: begin
           mText := ConvToNoDiakr(mText);
           Result := oFMFT4000.WriteToDisp(zFF);
           Result := oFMFT4000.WriteToDisp(mText);
         end;
      5: begin
//           mText := Win1250ToLatin2(mText);
           mText := ConvToNoDiakr(mText);
           Result := oFMPEGAS.WriteToDisp(mText, oCasFMHandSet.FMPrn.PrnEscSet.DispType);
         end;
      6: begin
           Result := oFMEFox.WriteToDisp(mText);
         end;
    end;
  end;
  If oCasFMHandSet.ExtDisp.DispUse and (oExtDispM<>nil) then begin
    mText := FillAllFld(oExtDispM.Text);
    mText := ConvToNoDiakr(mText);
    WriteToExtDisp (mText);
  end;
end;

function  TCasFMHand.WriteToDispE:boolean;
var mText:string;
begin
  Result := FALSE;
  mText := '';
  If oIntDispE<>nil then mText := FillAllFld(oIntDispE.Text);
  If mText<>'' then begin
    If oPrnNum=0 then begin
      case oCasFMHandSet.FMPrn.PrnType of
        4: begin
             mText := ConvToNoDiakr(mText);
             Result := oFMFT4000.WriteToDisp(mText);
           end;
        5: begin
//             mText := Win1250ToLatin2(mText);
             mText := ConvToNoDiakr(mText);
             Result := oFMPEGAS.WriteToDisp(mText, oCasFMHandSet.FMPrn.PrnEscSet.DispType);
           end;
        6: begin
             Result := oFMEFox.WriteToDisp(mText);
           end;
      end;
    end;
  end;
  If oCasFMHandSet.ExtDisp.DispUse and (oExtDispE<>nil) then begin
    mText := FillAllFld(oExtDispE.Text);
    mText := ConvToNoDiakr(mText);
    WriteToExtDisp (mText);
  end;
end;

function  TCasFMHand.WriteToDispC:boolean;
var mText:string;
begin
  Result := FALSE;
  mText := '';
  If oIntDispC<>nil then mText := FillAllFld(oIntDispC.Text);
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      4: begin
           mText := ConvToNoDiakr(mText);
           Result := oFMFT4000.WriteToDisp(zFF);
           Result := oFMFT4000.WriteToDisp(mText);
         end;
      5: begin
//           mText := Win1250ToLatin2(mText);
           mText := ConvToNoDiakr(mText);
           Result := oFMPEGAS.WriteToDisp(mText, oCasFMHandSet.FMPrn.PrnEscSet.DispType);
         end;
      6: begin
           Result := oFMEFox.WriteToDisp(mText);
         end;
    end;
  end;
  If oCasFMHandSet.ExtDisp.DispUse and (oExtDispC<>nil) then begin
    mText := FillAllFld(oExtDispC.Text);
    mText := ConvToNoDiakr(mText);
    WriteToExtDisp (mText);
  end;
end;

function  TCasFMHand.WriteToDispN:boolean;
var mText:string;
begin
  Result := FALSE;
  mText := '';
  If oIntDispN<>nil then mText := FillAllFld(oIntDispN.Text);
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      4: begin
           mText := ConvToNoDiakr(mText);
           Result := oFMFT4000.WriteToDisp(zFF);
           Result := oFMFT4000.WriteToDisp(mText);
         end;
      5: begin
//           mText := Win1250ToLatin2(mText);
           mText := ConvToNoDiakr(mText);
           Result := oFMPEGAS.WriteToDisp(mText, oCasFMHandSet.FMPrn.PrnEscSet.DispType);
         end;
      6: begin
           Result := oFMEFox.WriteToDisp(mText);
         end;
    end;
  end;
  If oCasFMHandSet.ExtDisp.DispUse and (oExtDispN<>nil) then begin
    mText := FillAllFld(oExtDispN.Text);
    mText := ConvToNoDiakr(mText);
    WriteToExtDisp (mText);
  end;
end;

function  TCasFMHand.WriteToDispX:boolean;
var mText:string;
begin
  Result := FALSE;
  mText := '';
  If oIntDispX<>nil then mText := FillAllFld(oIntDispX.Text);
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      4: begin
           mText := ConvToNoDiakr(mText);
           Result := oFMFT4000.WriteToDisp(zFF);
           Result := oFMFT4000.WriteToDisp(mText);
         end;
      5: begin
//           mText := Win1250ToLatin2(mText);
           mText := ConvToNoDiakr(mText);
           Result := oFMPEGAS.WriteToDisp(mText, oCasFMHandSet.FMPrn.PrnEscSet.DispType);
         end;
      6: begin
           Result := oFMEFox.WriteToDisp(mText);
         end;
    end;
  end;
  If oCasFMHandSet.ExtDisp.DispUse and (oExtDispX<>nil) then begin
    mText := FillAllFld(oExtDispX.Text);
    mText := ConvToNoDiakr(mText);
    WriteToExtDisp (mText);
  end;
end;

function  TCasFMHand.WriteToDispP:boolean;
var mText:string;
begin
  Result := FALSE;
  mText := '';
  If oIntDispP<>nil then mText := FillAllFld(oIntDispP.Text);
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      4: begin
           mText := ConvToNoDiakr(mText);
           Result := oFMFT4000.WriteToDisp(zFF);
           Result := oFMFT4000.WriteToDisp(mText);
         end;
      5: begin
//           mText := Win1250ToLatin2(mText);
           mText := ConvToNoDiakr(mText);
           Result := oFMPEGAS.WriteToDisp(mText, oCasFMHandSet.FMPrn.PrnEscSet.DispType);
         end;
      6: begin
           Result := oFMEFox.WriteToDisp(mText);
         end;
    end;
  end;
  If oCasFMHandSet.ExtDisp.DispUse and (oExtDispP<>nil) then begin
    mText := FillAllFld(oExtDispP.Text);
    mText := ConvToNoDiakr(mText);
    WriteToExtDisp (mText);
  end;
end;

function  TCasFMHand.WriteToExtDisp (pStr:string):boolean;
var I:longint; mSList:TStringList;
begin
  If oCasFMHandSet.ExtDisp.DispUse and (oExtDispO<>nil) then begin
    mSList := TStringList.Create;
    mSList.Text := pStr;
    If oExtDisp<>nil then begin
      oExtDisp.ClearDisp;
      If mSList.Count>0 then begin
        For I:=0 to mSList.Count-1 do
          oExtDisp.WriteDispLn (I+1, mSList.Strings[I]);
      end;
    end;
    FreeAndNil (mSList);
  end;
end;

function  TCasFMHand.OpenCashBox:boolean;
var I:longint;
begin
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      1..3: begin
              oSallyPrinter.PrintData (ConvStrToESCCodes (oCasFMHandSet.FMPrn.PrnEscSet.OpenCash));
            end;
      4: Result := oFMFT4000.OpenCashBox;
      5: Result := oFMPEGAS.OpenCashBox;
      6: Result := oFMEFox.OpenCashBox;
    end;
  end;
  If gCasSet.ExtCashBoxSet.Enable then OpenExtCashBox;
end;

procedure TCasFMHand.OpenExtCashBox;
var mPort:TPortComHand;
begin
  If gCasSet.ExtCashBoxSet.Enable and (gCasSet.ExtCashBoxSet.EscStr<>'') then begin
    mPort := TPortComHand.Create (ptSerial);
    mPort.oPortSet := gCasSet.ExtCashBoxSet.PortSet;
    If mPort.OpenPort then begin
      mPort.WriteToPort(ConvStrToESCCodes(gCasSet.ExtCashBoxSet.EscStr));
      mPort.ClosePort;
    end;
    FreeAndNil (mPort);
  end;
end;

function  TCasFMHand.GetFMBegValue:double;
var I:longint;
begin
  Result := 0;
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      4: Result := oFMFT4000.GetFMBegValue;
      5: Result := oFMPEGAS.GetFMBegValue;
      6: Result := oFMEFox.GetFMBegValue;
    end;
  end;
end;

function  TCasFMHand.ReadLastDoc:string;
var I:longint;
begin
  Result := '';
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      4: Result := oFMFT4000.ReadLastDoc;
      5: Result := oFMPEGAS.ReadLastDoc;
      6: Result := oFMEFox.ReadLastDoc;
    end;
  end;
end;

procedure TCasFMHand.Delay (pMSec:longint);
begin
  oPortComHand.Delay(pMSec);
end;

function  TCasFMHand.GetDateTime:TDateTime;
var I:longint;
begin
  Result := 0;
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      4: Result := oFMFT4000.GetDateTime;
      5: Result := oFMPEGAS.GetDateTime;
      6: Result := oFMEFox.GetDateTime;
    end;
  end;
end;

function  TCasFMHand.SetDateTime (pDateTime:TDateTime):boolean;
var I:longint;
begin
  Result := FALSE;
  If oPrnNum=0 then begin
    case oCasFMHandSet.FMPrn.PrnType of
      4: Result := oFMFT4000.SetDateTime (pDateTime);
      5: Result := oFMPEGAS.SetDateTime (pDateTime);
      6: Result := oFMEFox.SetDateTime (pDateTime);
    end;
  end;
end;


//  ***** TScanHand *****

constructor TScanHand.Create (pPortSet:TPortSet);
begin
  oPortComHand := TPortComHand.Create (ptSerial);
  oPortComHand.oPortSet := pPortSet;
  Opened := FALSE;
end;

destructor  TScanHand.Destroy;
begin
  FreeAndNil (oPortComHand);
end;

function    TScanHand.OpenScan:boolean;
begin
  Result := oPortComHand.OpenPort;
  oErr := oPortComHand.Error;
  If oErr=0 then oOpened := TRUE;
end;

function    TScanHand.CloseScan:boolean;
begin
  Result := oPortComHand.ClosePort;
  oOpened := FALSE;
end;

function    TScanHand.ReadScan:string;
begin
  Result := '';
  If oPortComHand.Opened then begin
    Result := oPortComHand.ReadInPortBCScan;
  end;
end;

procedure SaveToCFile (pDoc,pPath:string;pCasNum,pIntDocQnt:longint;pDocDate:TDate;pDocTime:TTime;pDocType:string;pLocalDocQnt:longint);
var mFileName,mCDoc:string; mT:TextFile; mW:tTxtWrap; mLocSize,mErr:longint;
begin
  If pDocType<>'NOSAVE' then begin
    mFileName := pPath+GetCFileName(pDocDate, pCasNum);
    mLocSize := TxtFile.GetFileSize (mFileName);
    mW := TTxtWrap.Create;
    mW.ClearWrap;
    mW.SetText('B',0);
    mW.SetText(pDocType,0);  // I - príjem, O - výdaj,
    mW.SetNum(pIntDocQnt,0);
    mW.SetDate(pDocDate);
    mW.SetTime(pDocTime);
    mW.SetNum(pLocalDocQnt,0);
    mCDoc := mW.GetWrapText+zCR+zLF;
    mCDoc := mCDoc+pDoc;
    mW.ClearWrap;
    mW.SetText('E',0);
    mCDoc := mCDoc+mW.GetWrapText+zCR+zLF;
    FreeAndNil (mW);
    If OpenTxtFileWrite(mT, mFileName, mErr) then begin
      WriteTxtFile(mT, mCDoc, mErr);
      CloseTxtFile (mT, mErr);
      SaveCFileToSD (gSallyCom.SD_W, gSallyCom.WriComs, mLocSize, mCDoc, ExtractFileName (mFileName), pPath);
      SaveCFileToSD (gSallyCom.SD_C, gSallyCom.CentComs, mLocSize, mCDoc, ExtractFileName (mFileName), pPath);
      SaveCFileToIPC (gSallyCom.IPC_W, gSallyCom.WriComs, 'W', mCDoc, ExtractFileName (mFileName), pPath, pCasNum);
      SaveCFileToIPC (gSallyCom.IPC_C, gSallyCom.CentComs, 'C', mCDoc, ExtractFileName (mFileName), pPath, pCasNum);
      SendFileBlock ('C', gPath.CasPath(gCasSet.CassaNum)+GetCFileName(gCasBlk.BlkDate, gCasSet.CassaNum));
    end;
  end;
end;

procedure SaveCFileToSD (pSDParam:TSharedDirParam; pComs:TComsDef; pLocSize:longint; pCDoc, pFileName, pCasPath:string);
var mPath,mData:string; mLanSize,mErr:longint; mOK:boolean; mT:TextFile;
begin
  If pComs.ComType='SD' then begin
    If pComs.ExpBlkClsC then begin
      If pSDParam.Active then begin
        mPath := GetSDPath (pSDParam);
        If not DirectoryExists(mPath) then begin
          If DirectoryExists(ExtractFileDrive(mPath))then begin
            ForceDirectories(mPath);
          end;
        end;
        If DirectoryExists(mPath) then begin
          mLanSize := 0;
          If FileExists (mPath+pFileName) then mLanSize := TxtFile.GetFileSize (mPath+pFileName);
          If pLocSize<>mLanSize then begin
            mOK := TRUE;
            If FileExists (mPath+pFileName) then mOK := FileDelete(mPath+pFileName);
            If mOK then begin
              mData := ReadFullTxtFile(pCasPath+pFileName, mErr);
              If OpenTxtFileWrite(mT,mPath+pFileName,mErr) then begin
                WriteTxtFile(mT,mData,mErr);
                CloseTxtFile(mT,mErr);
              end;
            end;
          end else begin
            If OpenTxtFileWrite(mT,mPath+pFileName,mErr) then begin
              WriteTxtFile(mT, pCDoc,mErr);
              CloseTxtFile(mT,mErr);
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure SaveCFileToIPC (pIPCParam:TIPCParam; pComs:TComsDef; pType, pCDoc, pFileName, pCasPath:string; pCasNum:longint);
var mErr:longint; mOK:boolean; mT:TextFile;
begin
  If pComs.ComType='IPC' then begin
    If pComs.ExpBlkClsC then begin
      If pIPCParam.Active then begin
        pFileName := Copy (pFileName, 1, Pos ('.', pFileName)-1)+'.'+pType+StrIntZero (pCasNum, 3);
        If OpenTxtFileWrite(mT, pCasPath+pFileName, mErr) then begin
          WriteTxtFile(mT, pCDoc, mErr);
          CloseTxtFile(mT, mErr);
        end;
      end;
    end;
  end;
end;

function  GetCFileName (pDate:TDate;pCasNum:longint):string;
var mD,mM,mY:word;
begin
  DecodeDate(pDate,mY,mM,mD);
  Result := 'C'+StrIntZero (mD,2)+StrIntZero (mM,2)+Copy (StrInt (mY,4),3,2)+'.'+StrIntZero (pCasNum,3);
end;

function  DecodeCFileName (pName:string):TDate;
var mD,mM,mY:word;
begin
  Result := 0;
  pName := ExtractFileName(pName);
  mD := ValInt (Copy (pName,2,2));
  mM := ValInt (Copy (pName,4,2));
  mY := 2000+ValInt (Copy (pName,6,2));
  If (mD>0) and (mM>0) then Result := EncodeDate(mY,mM,mD);
end;

function BCDToDoub (pData:string;pPos:longint):double;
var mSign:boolean; mS:string; mExp:byte; I:longint;
begin
  Result := 0;
  If Length (pData)>pPos+5 then begin
    mSign := (Ord (pData[pPos+5]) and 128) = 128;
    If mSign
      then mS := '-'
      else mS := '';
    mExp := Ord (pData[pPos+5]) and 127;
    mS := mS+'0.';
    For I:=0 to 4 do
      mS := mS+DecToHEX (Ord (pData[pPos+I]),2);
    Result := ValDoub (mS)*Power(10, mExp-64);
  end;
end;

function BCDToDate (pData:string;pPos:longint):TDate;
var mS:string; I:longint; mD,mM,mY:word;
begin
  Result := 0;
  If Length (pData)>pPos+3 then begin
    mS := '';
    For I:=0 to 3 do
      mS := mS+DecToHEX (Ord (pData[pPos+I]),2);
    If Length (mS)=8 then begin
      mD := ValInt (Copy (mS,7,2));
      mM := ValInt (Copy (mS,5,2));
      mY := ValInt (Copy (mS,1,4));
      try
        Result := EncodeDate(mY,mM,mD);
      except end;
    end;
  end;
end;

function BCDToTime (pData:string;pPos:longint):TTime;
var mS:string; I:longint; mH,mM:word;
begin
  Result := 0;
  If Length (pData)>pPos+1 then begin
    mS := '';
    For I:=0 to 1 do
      mS := mS+DecToHEX (Ord (pData[pPos+I]),2);
    If Length (mS)=4 then begin
      mH := ValInt (Copy (mS,1,2));
      mM := ValInt (Copy (mS,3,2));
      try
        Result := EncodeTime (mH,mM,0,0);
      except end;
    end;
  end;
end;

function Win1250ToLatin2 (pStr: string):string;
var I:longint;
begin
  Result := '';
  For I:=1 to Length (pStr) do begin
    If Ord (pStr[I])<128
      then Result := Result+pStr[I]
      else Result := Result+Chr (ChWinToLatin2[Ord (pStr[I])]);
  end;
end;

function Latin2ToWin1250(pStr: string):string;
var I,J:longint; mCh:string;
begin
  Result := '';
  For I:=1 to Length (pStr) do begin
    If Ord (pStr[I])<128
      then mCh := pStr[I]
      else begin
        mCh := #32;
        For J:=128 to 255 do begin
          If Ord (pStr[I])=ChWinToLatin2[J] then begin
            mCh := Chr (J);
            Break;
          end;
        end;
      end;
    Result := Result+mCh;
  end;
end;

function  ConvStrToSetASCIITbl (pS:string;pASCIITbl:longint):string;
begin
  Result := pS;
  case pASCIITbl of
    1: Result := ConvToNoDiakr(pS);
    2: Result := Win1250ToLatin2 (pS);
  end;
end;
// http://msdn.microsoft.com/en-us/library/cc195052.aspx

function DecodeStrToSetASCIITbl (pS:string;pASCIITbl:longint):string;
begin
  Result := pS;
  case pASCIITbl of
    2: Result := Latin2ToWin1250 (pS);
  end;
end;

function FillESCCodes (pStr, pMark, pESC:string):string;
var mBeg:longint;
begin
  While Pos (pMark, pStr)>0 do begin
    mBeg := Pos (pMark, pStr);
    Delete (pStr, mBeg, Length (pMark));
    Insert (pESC, pStr, mBeg);
  end;
  Result := pStr;
end;

end.

EPSON Priner Codes
ESC 69 - Bold On
ESC 70 - Bold Off
ESC 71 - Double Strike On
ESC 72 - Double Strike Off

Varos
^B - Bold
^H-  Double
^N - Normal

Pegas
#31 - Double
~1B~45~01 - Bold On
~1B~45~00 - Bold Off

