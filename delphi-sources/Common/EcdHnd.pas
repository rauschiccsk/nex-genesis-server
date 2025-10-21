unit EcdHnd;

interface
  uses
    Dialogs,
    IcDate, IcConv, IcTools, IcTypes, TxtFile, IcVariab, TxtCut, TxtWrap, NexIni, NexPath,
    SysUtils, Classes, Controls, XSBuiltIns, Forms, TlHelp32, Windows,
    IdHTTP, IdTCPConnection, IdTCPClient, IdIOHandler;

  const
    cWriNum:longint=1;
    cCasNum:longint=1;
    cIntHead:string='InteHead';
    cFixFoot:string='FixFoot';
    cDrawerEsc:string='';
    cCashRndSave:byte=1;

    cRepNum_blk:byte=1;
    cRepNum_icblk:byte=1;
    cRepNum_incdoc:byte=1;
    cRepNum_expdoc:byte=1;

    cCopies_blk:byte=2;
    cCopies_icblk:byte=2;
    cCopies_incdoc:byte=1;
    cCopies_expdoc:byte=1;

    ceCasDocStd0='Vytvorenie tlaËovej ˙lohy';
    ceCasDocStd1='Chyba pri vytvorenÌ tlaËovej ˙lohy';
    ceCasDocStd2='»ak· na pokladniËn˝ server';
    ceCasDocStd3='Prebieha tlaË';
    ceCasDocStd4='Chyba pri vytlaËenÌ';
    ceCasDocStd5='PreruöenÈ uûÌvateæom - NEX';
    ceCasDocStd6='PreruöenÈ uûÌvateæom - ECS';
    ceCasDocStd9='⁄loha bola ˙speöne vykonan·';

    zNul    = Chr (0);
    zS      = Chr (1);
    zSTX    = Chr (2);
    zETX    = Chr (3);
    zEOT    = Chr (4);
    zENQ    = Chr (5);
    zACK    = Chr (6);
    zHT     = Chr (9);
    zLF     = Chr (10);
    zFF     = Chr (12);
    zCR     = Chr (13);
    zSOH    = Chr (13);
    zDC1    = Chr (17);
    zDC2    = Chr (18);
    zDC3    = Chr (19);
    zDC4    = Chr (20);
    zNAK    = Chr (21);
    zETB    = Chr (23);
    zESC    = Chr (27);
    zFS     = Chr (28);
    zGS     = Chr (29);
    zRS     = Chr (30);
    zUS     = Chr (31);
    zDLE    = Chr (16);
    zRVI    = Chr (16)+Chr (64);
    zBeg    = Chr($1C)+Chr($20);

    // Identifik·tor odberateæa na doklade
    cCustIDDIC=0;      // DI»
    cCustIDICO=1;      // I»O
    cCustIDICDPH=2;    // I» DPH
    cCustIDOther=3;    // InÈ

   // Typy poloûiek/z·porn˝ch poloûiek
   cItmTypePositive=0;          // Kladn· poloûka
   cItmTypeReturned=1;          // Vr·ten· poloûka
   cItmTypeDiscount=2;          // Zæava
   cItmTypeAdvance=3;           // »erpan· z·loha
   cItmTypeReturnedContainer=4; // Vr·ten˝ obal


  type
    TeKasaInfo = record  // inform·cie inicializovanÈho eKasa
      Initialized     : boolean;                  // »i bola eKasa inicializovan·
      eKasaType       : Str20;                    // Typ eKasa (Portos/eKasaSK)
      Version         : Str20;                    // Verzia PPEKK
      VatPrc          : array [1..5] of integer;  // Sadzby DPH (len pre eKasaSK)
      CashRegisterCode: Str20;                    // KÛd pokladne
    end;

    TCasActPayVals = array [0..9] of record  // Actu·lny stav platidiel
      Name    : Str30;   // N·zov platidla
      BegVal  : double;  // PoËiatoËn˝ stav
      TrnVal  : double;  // Denn· trûba aktu·lneho dÚa
      ExpVal  : double;  // V˝ber z pokladne
      ChIVal  : double;  // Zmena platidla - vklad
      ChOVal  : double;  // Zmena platidla - v˝ber
      IncVal  : double;  // Vklad do pokladne
      EndVal  : double;  // KoneËn˝ stav
      PaidAdv : double;  // Zaplaten· z·loha
      UsedAdv : double;  // »erpan· z·loha
    end;

    TEcsGlob = record  // Glob·lne premennÈ T-s˙boru
      Version  : Str10;                    // Verzia
      Prg      : Str10;                    // Program ktor˝ vytvoril SALLY/ECS
      PrevDate : TDate;                    // Predch·dzaj˙ci fiök·lny deÚ
      PayVals  : TCasActPayVals;           // Aktu·lny stav platidiel
      VatPrc   : array [1..5] of byte;     // Sadzby DPH
      AValue   : array [1..5] of double;   // Ceækov· trûba bez DPH podæa sadzby DPH
      BValue   : array [1..5] of double;   // Ceækov· trûba s DPH podæa sadzby DPH
      VatVal   : array [1..5] of double;   // DPH ceækom podæa sadzby DPH
      ClmVal   : double;                   // Hodnota stornovan˝ch poloûiek
      NegVal   : double;                   // Hodnota z·porn˝ch poloûiek - obaly
      RndH     : double;                   // Zaokr˙hlenie cez PPEKK
      RndI_P   : double;                   // Kladn· hodnota zaokr˙hlenia z poloûiek
      RndI_N   : double;                   // Z·porn· hodnota zaokr˙hlenia z poloûiek
      DscVal   : double;                   // Hodnota zæiav
      AdvVal   : double;                   // Hodnota Ëerpan˝ch z·loh
      ICDocPay : double;                   // Hodnota uhraden˝ch fakt˙r
      IntDocNum: longint;                  // InternÈ ËÌslo dokladu
      DDocNum  : longint;                  // DennÈ ËÌslo dokladu
      eKasaDocNum: Str20;                  // PoradovÈ ËÌslo z eKasa - mesaËnÈ
      XDocQnt  : longint;                  // PoËet dokladov od poslednej uz·vierky smeny - zatiaù nevyuûitÈ
      DDocQnt  : longint;                  // PoËet dokladov od poslednej dennej uz·vierky
      XClsNum  : longint;                  // PoradovÈ ËÌslo uz·vierky smeny - zatiaù nevyuûitÈ
      DClsNum  : longint;                  // PoradovÈ ËÌslo dennej uz·vierky
      SalDocQnt: longint;                  // PoËet pokladniËn˝ch dokladov
      ICDocQnt : longint;                  // PoËet ˙hrad fakt˙r
      IncDocQnt: longint;                  // PoËet vkladov
      DecDocQnt: longint;                  // PoËet v˝berov
      ClmItmQnt: longint;                  // PoËet stornovan˝ch poloûiek
      NegItmQnt: longint;                  // PoËet z·porn˝ch poloûiek - vr·ten˝ch obalov
      DscItmQnt: longint;                  // PoËet zæavnen˝ch poloûiek
      AdvItmQnt: longint;                  // PoËet Ëerpan˝ch z·loh
    end;

    TRndItm = record
      GsCode:longint;
      MgCode:longint;
      FgCode:longint;
      BarCode:Str15;
      GsName:Str30;
      MsName:Str3;
    end;

    TClsPayVals = array [0..9] of record  // KumulovanÈ ˙daje podla platidiel z denn˝ch uz·vierok
      TrnVal  : double;  // Trûba
      ExpVal  : double;  // Vyber
      IncVal  : double;  // Vklad
    end;

    TClsData = record  // KumulovanÈ ˙daje denn˝ch uz·vierok
      DClsNumF:longint;                   // »Ìslo prvej dennej uz·vierky
      DClsNumL:longint;                   // »Ìslo poslednej dennej uz·vierky
      DClsDateF:TDateTime;                // D·tum prvej dennej uz·vierky
      DClsDateL:TDateTime;                // D·tum poslednej dennej uz·vierky
      PayVals  : TClsPayVals;             // ⁄daje podla platidiel
      VatPrc   : array [1..5] of byte;    // Sadzby DPH
      AValue   : array [1..5] of double;  // Obrat bez DPH podæa sadzby DPH
      BValue   : array [1..5] of double;  // Obrat s DPH podæa sadzby DPH
      VatVal   : array [1..5] of double;  // DPH podæa sadzby DPH
      ClmVal   : double;                  // Hodnota stornovan˝ch poloûiek
      NegVal   : double;                  // Hodnota z·porn˝ch poloûiek - obalov
      AdvVal   : double;                  // Hodnota Ëerpan˝ch z·loh
      DscVal   : double;                  // Hodnota zæiav
      RndH     : double;                  // Zaokr˙hlenie cez PPEKK
      RndI_P   : double;                  // Kladn· hodnota zaokr˙hlenia z poloûiek
      RndI_N   : double;                  // Z·porn· hodnota zaokr˙hlenia z poloûiek
      ICDocPay : double;                  // Hodnota ˙hrad FA
      SalDocQnt:longint;                  // PoËet pokladniËn˝ch dokladov
      ICDocQnt : longint;                 // PoËet ˙hrad FA
      IncDocQnt: longint;                 // PoËet vkladov
      ExpDocQnt: longint;                 // PoËet v˝berov
      ClmItmQnt: longint;                 // PoËet stornovan˝ch poloûiek
      NegItmQnt: longint;                 // PoËet z·porn˝ch poloûiek - obalov
      DscItmQnt: longint;                 // PoËet zæavnen˝ch poloûiek
      AdvItmQnt: longint;                 // PoËet Ëerpan˝ch z·loh
    end;

    TVatPrc = array [1..5] of longint;  // Sadzby DPH
    TPaysTbl = array [0..9] of double;  // Zoznam ˙hrad podæa platidiel
    TNoteLst = array [1..4] of Str40;   // Zoznam pozn·mkov˝ch riadkov

    TBlkHead = record  // HlaviËkovÈ ˙daje pokladniËnÈho dokladu
      BlkDate:TDateTime;     // D·tum
      BlkTime:TDateTime;     // Time
      PaCode:longint;        // KÛd firmy
      PaName:Str30;          // N·zov firmy
      PaINO:Str15;           // I»O firmy
      PaTIN:Str15;           // DI» firmy
      PaVIN:Str15;           // I» DPH firmy
      CusCardNum:Str30;      // »Ìslo z·kaznÌckej karty
      CusName:Str40;         // Meno z·kaznÌka
      IntDocNum:Str15;       // InternÈ ËÌslo vy˙ËtovanÈho dokladu
      ExtDocNum:Str15;       // ExternÈ ËÌslo vy˙ËtovanÈho dokladu
      LoginName:Str8;        // Prihlasovacie meno uûÌvateæa
      UserName:Str30;        // CelÈ meno uûÌvateæa
      BValue:double;         // Hodnota dokladu s DPH
      RndVal:double;         // Hodnota zaokr˙hlenia  27.6.2022 Tibi zaokr˙hlenie
      PayVal:double;         // Zaplaten· hodnota     27.6.2022 Tibi zaokr˙hlenie
      VatPrc: array [1..5] of longint; // Sadzby DPH
      BVals: array [1..5] of double; // Hodnoty s DPH poæa sadzby DPH
      VatVals: array [1..5] of double; // Hodnoty DPH poæa sadzby DPH
      AVals: array [1..5] of double; // Hodnoty bez DPH poæa sadzby DPH
      DscBVals: array [1..5] of double; // Hodnoty zæiav s DPH poæa sadzby DPH
      UID:Str50;             // Unik·tny identifik·tor vytlaËenÈho dokladu
    end;

    TBlkItems = array [1..1000] of record  // Poloûky pokladniËnÈho dokladu
      GsCode:longint;    // PLU
      MgCode:longint;    // Tovarov· skupina
      FgCode:longint;    // FinanËn· skupina
      BarCode:Str15;     // IdentifikaËn˝ kÛd
      StkCode:Str15;     // Skladov˝ kÛd
      OsdCode:Str15;     // Objedn·vacÌ kÛd
      GsName:Str30;      // N·zov tovaru
      VatPrc:longint;    // Sadzba DPH
      Qnt:double;        // Mnoûstvo
      MsName:Str3;       // Mern· jednotka
      BPrice:double;     // Jednotkov· cena s DPH
      BValue:double;     // Hodnota s DPH
      FBPrice:double;    // Jednotkov· cena s DPH bez zæavy
      FBValue:double;    // Hodnota s DPH bez zæavy
      DscPrc:double;     // Percentu·lna zæava
      DscBVal:double;    // Zæava s DPH
      NegType:Str1;      // Typ z·pornej poloûky
      RefID:Str50;       // Pri vr·tenÌ tovaru ËÌslo pÙvodnÈho dokladu
      LoginName:Str8;    // Prihlasovacie meno uûÌvateæa na pÙvodnom doklade
      Date:TDateTime;    // D·tum vy˙Ëtovanie na pÙvodnom doklade
      Time:TDateTime;    // »as vy˙Ëtovania na pÙvodnom doklade
    end;

    TFldData = array [1..300] of record
      ID  : string;
      Num : double;
      Str : string;
      Typ : byte;    //0-string, 1-integer, 2-double, 3- double strip zero frac, 4-date, 5-time
    end;

    TValRec = record
      VatPrc : longint;
      AValue : double;
      VatVal : double;
      BValue : double;
    end;


// TePortosHand sl˙ûi na komunik·ciu s Portos eKasa od firmy Nine Digit s.r.o.
// Tento objek sa nepouûÌva samostatne, pouûÌva ho objekt TeKasaHnd.
    TePortosHand=class
      constructor Create(pHost:string;pPort,pConnectTimeout,pReadTimeout:longint);
      destructor  Destroy; override;
    private
      oHTTP:TIdHTTP;           // Cez t˙to premenn˙ prebieha komunik·cia cez HTTP
      oHost:string;            // IP adresa poËÌtaËa, kde je nainötalovan˝ komunik·tor pre Portos
      oPort:string;            // Port, cez ktor˝ sa komunikuje s komunik·torom Portos
      oHTTPCode:longint;       // Chybov˝ kÛd pri komunik·ciÌ cez HTTP
      oHTTPText:string;        // Textov· Ëasù chybovÈho kÛdu, pri komunik·ciÌ cez HTTP
      oJSon:TStringList;       // JSon text prekonverovanÈ pre StringList
      oUID:Str50;              // Unik·tny identifik·tor vytlaËenÈho dokladu
      oHead:string;            // Text hlaviËky dokladu
      oPayLst:TStringList;     // Zoznam ˙hrad podæa platidiel
      oItmLst:TStringList;     // Zoznam poloûiek
      oDocValPay:double;       // ⁄hrady ceækom
      oDocValItm:double;       // Ceækom podæa poloûiek
      oFullDocNum:string;

      function GetData(pType:string):string;
      function PostData(pType,pData:string):string;
      procedure FillJSonData(pData:string);
      function FindJSonItm(pItm:string):string;
      function FillDeposit(pVal:double;pHead,pFoot:string):string;
      function FillWithdraw(pVal:double;pHead,pFoot:string):string;
      function FillICDoc(pDocVal:double;pICDocNum,pCustID:string;pCustIDType:byte;pHead,pFoot:string):string;
      function FillBlkData(pHead,pFoot:string):string;
      function GetItmTypeStr(pItmType:byte):string;
    public
      function Initialize:boolean;
      function GetCashRegisterCode:boolean;
      function GetPrnState:boolean;
      function GetConnetced:boolean;
      function GetCertificates:TDateTime;
      function GetVersion:string;
      function GetLastReceiptNumber:longint;
      function GetFullLastReceiptNumber:string;
      function OpenDrawer:boolean;
      function PrintText(pText:string;pPrnHead:boolean):boolean;
      function PrintDeposit(pVal:double;pHead,pFoot:string):boolean;
      function PrintWithDraw(pVal:double;pHead,pFoot:string):boolean;
      procedure SetICDocH(pHead:string);
      procedure SetICDocP(pName:string;pValue:double);
      function PrintICDoc(pDocVal:double;pICDocNum,pCustID:string;pCustIDType:byte;pFoot:string):boolean;

      function SetBlkH(pHead:string):boolean;
      function SetBlkI(pItmType:byte;pGsName:string;pPrice,pQnt,pValue:double;pVatPrc:longint;pMs,pDescription,pReferenceReceiptId:string):boolean;
      procedure SetBlkP(pName:string;pValue:double);
      function PrintBlk(pDocVal:double;pFoot:string):boolean;

      function PrintCopy(pYear,pMonth,pReceiptNumber:longint):boolean;
      function PrintLastBlock:boolean;

      property UID:Str50 read oUID;
    end;

// TeKasaSKHand sl˙ûi na komunik·ciu s eKasaSK od firmy Bowa s.r.o.
// Tento objek sa nepouûÌva samostatne, pouûÌva ho objekt TeKasaHnd.
    TeKasaSKHand=class
      constructor Create(pHost:string;pPort,pConnectTimeout,pReadTimeout:longint);
      destructor  Destroy; override;
    private
      oIdTCPClient: TIdTCPClient;
      oDocVal:double;
      oDocValPay:double;
      oFullDocNum:string;
      oUID:Str50;

      function Connect:boolean;
      function SendData(pData:string;pDelay:longint):string; overload;
      function SendData(pData:string):string; overload;
      function ReadLen(pLen:longint):string;
      function Remove1B(pStr:string):string;
      function CalcBCC(pStr:string):byte;
      function GetVariabData (pCom:string; var pData:string):boolean;
      function GetVatSymb (pVatPrc:double):string;
      function GetUID:Str50;
    public
      function Initialize:boolean;
      function GetCashRegisterCode:boolean;
      function GetPrnState:boolean;
      function GetConnetced:boolean;
      function GetCertificates:TDateTime;
      function GetVersion:string;
      function GetVatPrc:boolean;
      function GetLastReceiptNumber:longint;
      function GetFullLastReceiptNumber:string;
      function GetDailyReceiptNumber:longint;
      function OpenDrawer(pESC:string):boolean;
      function ReadLastDoc:string;
      function GetStatus:string;
      function CancelDoc:boolean;
      function PrintText(pText:string):boolean;
      function WriteToDisp (pText:string):boolean;
      function PrintItmNote(pText:string):boolean;
      function PrintDocNote(pNote:string):boolean;
      function PrintDepositH(pHead:string):boolean;
      function PrintDepositP(pPayNum:longint;pPayName:string;pVal:double):boolean;
      function PrintDepositF(pFoot:string):boolean;
      function PrintDeposit(pPayNum:longint;pPayName:string;pVal:double;pHead,pFoot:string):boolean;
      function PrintWithdrawH(pHead:string):boolean;
      function PrintWithdrawP(pPayNum:longint;pPayName:string;pVal:double):boolean;
      function PrintWithdrawF(pFoot:string):boolean;

      function PrintICDocH(pDocVal:double;pICDocNum,pCustID:string;pCustIDType:byte;pHead:string):boolean;
      function PrintICDocP(pPayNum:longint;pName:string;pVal:double):boolean;
      function PrintICDoc(pFoot:string):boolean;

      function PrintBlkH(pHead:string;pDocVal:double):boolean;
      function PrintBlkI(pItmType:byte;pItem,pGsName:string;pPrice,pQnt,pValue:double;pVatPrc:longint;pMs,pDescription,pReferenceReceiptId:string):boolean;
      function PrintBlkP(pPayNum:longint;pName:string;pVal:double):boolean;
      function PrintBlk(pFoot:string):boolean;

      function PrintIClose:boolean;
      function PrintDClose:boolean;

      function ReadDCloseVals:boolean;
      function GetDCloseNum:longint;
      function GetPayID(pCode:longint):string;
//      function PrintMClose:boolean;

      function PrintLastBlock:boolean;

      property UID:Str50 read oUID;
    end;

// TeKasaHnd sl˙ûi na komunik·ciu s certifikaËn˝mi rieöeniami online pokladnÌ typu Portos a eKasaSK.
    TeKasaHnd = class
      constructor Create(pPPEKKType:byte;pHost:string;pPort,pConnectTimeout,pReadTimeout:longint;pWriteToLog:boolean);
      destructor  Destroy; override;

    private
      oPPEKKType  :byte;          // Typ komunikaËnÈho protokolu 1-Portos, 2-eKasaSK
      oPortos     :TePortosHand;  // Komunik·cia s komunikaËn˝m protokolom Portos (Nine Digit)
      oeKasaSK    :TeKasaSKHand;  // Komunik·cia s komunikaËn˝m protokolom eKasaSK (Bowa)
      oErrCod     :longint;       // KÛd chyby
      oErrDes     :Str200;        // Text chybovÈho hl·senia

      // Spracovanie tlaËovej masky
      oFldData   : TFldData;
      oFldDataQnt: longint;

      oFullBlk    : TStringList;

      oCopies     : longint;
      oRepMask    : string;
      oRepName    : string;
      oExtHeadUse : boolean;
      oIntHeadUse : boolean;
      oVarFootUse : boolean;
      oFixFootUse : boolean;

      oExtHead    : TStringList;
      oIntHead    : TStringList;
      oVarFoot    : TStringList;
      oFixFoot    : TStringList;
      oBlockHead  : TStringList;
      oBlockItem  : TStringList;
      oSumFoot    : TStringList;
      oInfoFoot   : TStringList;
      oItmData    : TStringList;

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
      oRefDocNum : string;

      procedure ReadRepFile;
      procedure ReadRepName (pLn:string);
      procedure ReadExtHeadUse;
      procedure ReadIntHeadUse;
      procedure ReadBlockHead (pLn:string);
      procedure ReadBlockItem (pLn:string);
      procedure ReadSumFoot (pLn:string);
      procedure ReadVarFootUse;
      procedure ReadInfoFoot (pLn:string);
      procedure ReadFixFootUse;

      procedure AddBlkText(pText:string);

      function  FindFldID (pID:string;var pPos:longint):boolean;
      function  GetFldID (pID:string;var pPos:longint):boolean;
      function  FillAllFld (pStr:string):string;
      procedure FillStandFld (var pStr:string);
      procedure FillSpecFld (var pStr:string);
      procedure FillVarLenFld (var pStr:string);
      procedure ScanFldParam (pBeg:longint;pStr,pID:string;pVarFld:boolean;var pLen,pFrac:longint);
      procedure ChangeVal (pHide:boolean;pBeg,pLen,pFrac,pItm:longint;var pStr:string);
      function  DelHiddenLn (pStr:string):string;

      procedure PrintHead;
      procedure PrintItem;
      function  PrintFoot (pDocType:string):boolean;

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
      procedure SetRefDocNum (pRefDocNum:string);

      function LoadEcdFile(pEcdFile:string):boolean;
      procedure FillBlkHead;
      procedure FillBlkItem(pNum:longint);
      procedure FillBlkDscItem(pNum:longint);

      function PrintDocHead:boolean;
      function PrintDocItem(pItmNum:longint):boolean;
      function PrintDocPay:boolean;
      function PrintDocFoot:boolean;

      procedure FillICBlkHead;
      function PrintICDocHead:boolean;
      function PrintICDocPay:boolean;
      function PrintICDocFoot:boolean;

      function GetDocText:string;
      procedure InitTFile;
      procedure SaveTDoc;
      procedure SaveTICDoc;
      procedure SaveRepDoc;

      procedure SaveIncDoc;
      procedure SaveExpDoc;

      function PrintInfoClsT:boolean;
      procedure SaveInfoCls;
      function PrintDClsT:boolean;
      procedure SaveDCls;
      function PrintMClsT:boolean;
      procedure SaveMCls;

      function GetUID:Str50;
    public
      function Initialize:boolean;
      function GetCashRegisterCode:boolean;
      function GetPrnState:boolean;
      function GetConnetced:boolean;
      function GetCertificates:TDateTime;
      function GetVersion:string;
      function GetLastReceiptNumber:longint;
      function GetFullLastReceiptNumber:string;
      function GetDailyReceiptNumber:longint;
      function OpenDrawer(pESC:string):boolean;
      function ReadLastDoc:string;

      procedure RecalcBlkHead;
      procedure AddRndItm;

      function PrintBlk(pEcdFile:string;pRepNum:byte):boolean;
      function PrintICDoc(pEcdFile:string;pRepNum:byte):boolean;

      function PrintRepDoc(pRepNum:byte):boolean;

      function PrintIncDoc(pIncVal:double;pRepNum:byte):boolean;

      function SetExpDocPay (pPayNum:longint;pExpVal:double):boolean;
      function PrintExpDoc(pRepNum:byte):boolean;

      function PrintInfoCls:boolean;
      function PrintDCls:boolean;

      function PrintMCls:boolean;

      function PrintLastBlock:boolean;

      procedure Test;

      property Copies:longint read oCopies write oCopies;
      property ErrCod:longint read oErrCod;
      property ErrDes:Str200 read oErrDes;
      property UID:Str50 read GetUID;
    end;

// TTFileHnd sl˙ûi na vytvorenie T-s˙boru
    TTFileHnd = class
      constructor Create;
      destructor  Destroy; override;
    private
      oList:TStringList;
      oLoginName:string;
      oUserName :string;
      oPrpsCode :longint;
      oPrpsName :string;

      function CalcCheckSum (pS:string):longint;
      procedure Save;
    public
      function GetFHLine:string;
      procedure SaveBegDoc;
      procedure SaveRepDoc;
      procedure SaveIncDoc;
      procedure SaveExpDoc;
      procedure SaveCoins(pLst:string);
      procedure SaveClsDoc(pType:string);
      procedure SaveMClsDoc;
      procedure SaveICDocPay;
      procedure SaveSalDoc;
    end;

// TTFileGlobFill naËÌta aktu·lne ˙daje do gEcsGlob premennej
    TTFileGlobFill = class
      constructor Create;
      destructor  Destroy; override;
    private
      oCut:TTxtCutLst;
      oChgDoc:boolean;

      function ReadInTFile(pFile:string):boolean;
      procedure SumBegVarInTFile(pFile:string);
      procedure ReadFH;
      procedure SumBegVarInBB;
      procedure SumBegVarInBP;
      procedure SumBegVarInBV;
      procedure SumBegVarInPB;
      procedure SumBegVarInIB;
      procedure SumBegVarInIP;
      procedure SumBegVarInOB;
      procedure SumBegVarInOP;
      procedure SumBegVarInHB;
      procedure SumBegVarInHX;
      procedure SumBegVarInHY;
      procedure SumBegVarInAB;
      procedure SumBegVarInXB;
      procedure SumBegVarInXI;
      procedure SumBegVarInDB;
      procedure SumBegVarInDI;
      procedure SumBegVarInMB;
      procedure SumBegVarInMI;
      procedure SumBegVarInSB;
      procedure SumBegVarInSI;
      procedure SumBegVarInSP;
      procedure SumBegVarInST;
      procedure SumBegVarInNB;
      procedure SumBegVarInRB;
      procedure SumBegVarInRP;
      procedure SumBegVarInKB;
      procedure SumBegVarInTB;
    public
      procedure FillGlobValues(pDate:TDate;pCasNum:longint;pPath:string);
    end;

// TTFileClsFill naËÌta ˙daje denn˝ch uz·vierok do gTClsData premennej
    TTFileClsFill = class
      constructor Create;
      destructor  Destroy; override;
    private
      oCut:TTxtCutLst;

      procedure ReadInDCls(pFile:string;pDate:TDateTime;pNumF,pNumL:longint);
      function  ReadInDClsDB(pLn:string;pDate:TDateTime;pNumF,pNumL:longint):boolean;
      procedure ReadInDClsDI(pLn:string);
      procedure SumClsVal(pVatPrc:byte;pVatVal,pBValue:double);
    public
      function FillClsValuesDate(pDateF,pDateL:TDateTime;pCasNum:longint;pPath:string):boolean;
      function FillClsValuesNum(pNumF,pNumL:longint;pCasNum:longint;pPath:string):boolean;
    end;

// TECDSave sl˙ûi na vygenerovanie a uloûenie ECD s˙boru
    TECDSave = class
      constructor Create;
      destructor  Destroy; override;
    private
      oWrap:TTxtWrap;
      oHead:string;
      oItm:TStringList;
      oPay:TStringList;
      oNot:TStringList;
      oBVal  :double;
      oPayVal:double;
      oItmVal:double;
      oRndVal:double;
      oErrCod:byte;

      function GetErrDes:Str100;
    public
      // ⁄hrada fakt˙ry
      procedure AddICP(pDocNum,pExtNum:Str20;pPaCode:longint;pIno,pTin,pVin,pPaName,pGsName:Str30;pBVal:double);
      // ⁄daje pokladniËnÈho dokladu
      procedure AddHed(pDocNum,pExtNum:Str20;pPaCode:longint;pIno,pTin,pVin,pPaName,pCrdNum,pCrdName:Str30;pBVal,pRndVal:double);
      procedure AddItm(pGsCode,pMgCode,pFgCode:longint;pBarCode,pStkCode,pOsdCode:Str15;pGsName:Str30;pVatPrc:longint;pMsName:Str3;pQnt,pBValue,pFBValue,pDscPrc,pDscBVal:double;pNegType:Str1;pRefID:Str50;pLoginName:Str8;pDate,pTime:TDateTime);
      // SpoloËnÈ ˙daje
      procedure AddPay(pPayNum:byte;pPayName:Str30;pPayVal:double);
      Procedure AddNot(pNotLin:Str40);

      function  DocGen(pPath,pFileName:string):boolean;

      property  ErrCod:byte read oErrCod;
      property  ErrDes:Str100 read GetErrDes;
    end;

// TECDLoad sl˙ûi na vygenerovanie a uloûenie ECD s˙boru
    TECDLoad = class
      constructor Create;
      destructor  Destroy; override;
    private
      oCut:TTxtCutLst;
      oErrCod:longint;
      oPayVal:double;
      oItmVal:double;
      oEcdFile:string;

      procedure LoadHead(pCom:string);
      procedure LoadItem(pCom:string);
      procedure LoadPay(pCom:string);
      procedure LoadNote(pCom:string);
      procedure RecalcBlkHead;
      function GetErrDes:Str100;
    public
      function LoadDoc(pPath,pFileName:string):boolean;

      property  ErrCod:longint read oErrCod;
      property  ErrDes:Str100 read GetErrDes;
    end;

  function  GetProcessQnt (pFileName:string):longint;
  procedure ArchEcdFile(pCasPath,pEcdFile,pSrdDoc,pRegIno,pParNam,pDocUid:string;pDocVal:double;pBlkNum,pCasNum,pErrCod:longint;pErrDes,pDocYear:string;pDocSerNum:longint);
  procedure WriteLogDebug (pStr:string);
  procedure WriteLogErr (pStr:string);
  procedure ClearEcsGlob;  // Vynuleje ˙daje v gEcsGlob
  procedure ClearClsData;  // Vynuleje ˙daje v gClsData
  function  GetTFileName (pDate:TDate;pCasNum:longint):string;
  function  GetCFileName (pDate:TDate;pCasNum:longint):string;

  var
    geKasaInfo:TeKasaInfo; // inform·cie inicializovanÈho eKasa
    gEcsGlob:TEcsGlob;     // Aktu·lny stav T s˙boru
    gClsData:TClsData;     // SumarizovanÈ ˙daje denn˝ch uz·vierok
    geKasaPath:string;     // Adres·r pokladne
    gEcdPath:string;       // Adres·r ECD s˙borov
    gBlkHead:TBlkHead;     // HlaviËkovÈ ˙daje pokladniËnÈho dokladu
    gBlkItems:TBlkItems;   // Poloûky pokladniËnÈho dokladu
    gBlkItemQnt:longint;   // PoËet poloûiek na pokladniËnom doklade
    gRndItmN:TRndItm;      // Z·porn· poloûka zaokr˙hlenia
    gRndItmP:TRndItm;      // Kladn· poloûka zaokr˙hlenia

implementation

  var
    uWriteToLog:boolean;   // Ak je TRUE, komunik·cia bude logovan·
    uVatPrc:TVatPrc;       // Sadzby DPH
    uPaysTbl:TPaysTbl;     // Zoznam ˙hrad podæa platidiel
    uNoteLst:TNoteLst;     // Zoznam pozn·mkov˝ch riadkov
    uNoteQnt:longint;      // PoËet pozn·mkov˝ch riadkov (max. 4)

    uEcsUnitInit:boolean;

procedure EcsUnitInit;
// Inicializ·cia glob·lnych premenn˝ch
begin
  If not uEcsUnitInit then begin
    uVatPrc[1]:=gIni.GetVatPrc(1);
    uVatPrc[2]:=gIni.GetVatPrc(2);
    uVatPrc[3]:=gIni.GetVatPrc(3);
    uVatPrc[4]:=gIni.GetVatPrc(4);
    uVatPrc[5]:=100;
    uEcsUnitInit:=TRUE;
  end;
end;

function  GetProcessQnt (pFileName:string):longint;
var mContinueLoop: LongBool; mHandle: THandle; mProcessEntry32: TProcessEntry32;
    mProcFile:string; mSelfProcessID:longint;
begin
  Result := 0;
  mHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  mProcessEntry32.dwSize := SizeOf(mProcessEntry32);
  mContinueLoop := Process32First(mHandle, mProcessEntry32);
  mSelfProcessID := GetCurrentProcessId;
  while Integer(mContinueLoop) <> 0 do begin
    If mProcessEntry32.th32ProcessID<>0 then begin
      mProcFile := UpString (mProcessEntry32.szExeFile);
      If UpString (pFileName)=mProcFile then begin
        If (mProcessEntry32.th32ProcessID<>mSelfProcessID)
          then Result := Result+1;
      end;
    end;
    mContinueLoop := Process32Next(mHandle, mProcessEntry32);
  end;
  CloseHandle(mHandle);
end;

procedure ArchEcdFile(pCasPath,pEcdFile,pSrdDoc,pRegIno,pParNam,pDocUid:string;pDocVal:double;pBlkNum,pCasNum,pErrCod:longint;pErrDes,pDocYear:string;pDocSerNum:longint);
var mS,mPathEcdDat,mPathEcdArc,mFile:string; mY,mM,mD:word; mT:TextFile; mW:TTxtWrap; mErr:longint; mSLst:TStringList;
begin
  DecodeDate(Date,mY,mM,mD);
  mFile:='ECA'+Copy (StrInt (mY,4),3,2)+StrIntZero (mM,2)+'.'+StrIntZero (pCasNum,3);
  mPathEcdDat:=pCasPath+'ECDDAT\';
  mPathEcdArc:=mPathEcdDat+'ECDARC\';
  If not DirectoryExists(mPathEcdArc) then ForceDirectories(mPathEcdArc);
  mW := TTxtWrap.Create;
  mW.ClearWrap;
  mW.SetText('B',0);
  mW.SetDate(Date);
  mW.SetTime(Time);
  mW.SetText(Copy(pEcdFile,3,8),0);
  mW.SetText(pSrdDoc,0);
  mW.SetNum(pBlkNum,0);
  mW.SetText(pRegIno,0);
  mW.SetText(pParNam,0);
  mW.SetReal(pDocVal,0,2);
  mW.SetText(pDocUid,0);
  mW.SetNum(pErrCod,0);
  mW.SetText(pErrDes,0);
  mW.SetText(pDocYear,0);
  mW.SetNum(pDocSerNum,0);
  mS:=mW.GetWrapText+zCR+zLF;
  mSLst:=TStringList.Create;
  mSLst.LoadFromFile(mPathEcdDat+pEcdFile);
  mS:=mS+mSLst.Text;
  FreeAndNil(mSLst);
  mW.ClearWrap;
  mW.SetText('E',0);
  mS:=mS+mW.GetWrapText+zCR+zLF;
  FreeAndNil (mW);
  If OpenTxtFileWrite(mT,mPathEcdArc+mFile,mErr) then begin
    WriteTxtFile(mT,mS,mErr);
    If mErr=0 then begin
      CloseTxtFile (mT,mErr);
      SysUtils.DeleteFile(mPathEcdDat+pEcdFile);
    end;
  end;
end;

procedure WriteLogDebug (pStr:string);
// Loguje komunik·ciu, ak je zapnut˝ uWriteToLog
var mT:TextFile; mErr:longint;mDate:string;
begin
  If uWriteToLog then begin
    If OpenTxtFileWrite(mT,geKasaPath+'eKasaLog'+'.debug',mErr) then begin
      mDate := FormatDateTime('dd.mm.yyyy hh:mm:ss,zzz',Now);
      WriteLnTxtFile(mT,mDate+' '+pStr,mErr);
      CloseTxtFile(mT,mErr);
    end;
  end;
end;

procedure WriteLogErr (pStr:string);
// Loguje chybn˙ komunik·ciu
var mT:TextFile; mErr:longint;mDate:string;
begin
  If OpenTxtFileWrite(mT,geKasaPath+'eKasaLog'+'.err',mErr) then begin
    mDate := FormatDateTime('dd.mm.yyyy hh:mm:ss,zzz',Now);
    WriteLnTxtFile(mT,mDate+' '+pStr,mErr);
    CloseTxtFile(mT,mErr);
  end;
end;

procedure ClearEcsGlob;
// Vynuluje alebo nastav˝ zakladnÈ hodnoty glob·lnej premennej gEcsGlob
var I:longint;
begin
  EcsUnitInit;
  gEcsGlob.Version:='';
  gEcsGlob.PrevDate:=0;
  For I:=0 to 9 do begin
//    gEcsGlob.PayVals[I].Name:='';
    gEcsGlob.PayVals[I].BegVal:=0;
    gEcsGlob.PayVals[I].TrnVal:=0;
    gEcsGlob.PayVals[I].ExpVal:=0;
    gEcsGlob.PayVals[I].ChIVal:=0;
    gEcsGlob.PayVals[I].ChOVal:=0;
    gEcsGlob.PayVals[I].IncVal:=0;
    gEcsGlob.PayVals[I].EndVal:=0;
    gEcsGlob.PayVals[I].PaidAdv:=0;
    gEcsGlob.PayVals[I].UsedAdv:=0;
  end;
  For I:=1 to 5 do begin
    gEcsGlob.VatPrc[I]:=uVatPrc[I];
    gEcsGlob.AValue[I]:=0;
    gEcsGlob.BValue[I]:=0;
    gEcsGlob.VatVal[I]:=0;
  end;
  uEcsUnitInit:=TRUE;
  gEcsGlob.ClmVal:=0;
  gEcsGlob.NegVal:=0;
  gEcsGlob.RndH:=0;
  gEcsGlob.RndI_P:=0;
  gEcsGlob.RndI_N:=0;
  gEcsGlob.DscVal:=0;
  gEcsGlob.AdvVal:=0;
  gEcsGlob.ICDocPay:=0;
  gEcsGlob.IntDocNum:=0;
  gEcsGlob.DDocNum:=0;
  gEcsGlob.eKasaDocNum:='';
  gEcsGlob.XDocQnt:=0;
  gEcsGlob.DDocQnt:=0;
  gEcsGlob.XClsNum:=0;
  gEcsGlob.DClsNum:=0;
  gEcsGlob.SalDocQnt:=0;
  gEcsGlob.ICDocQnt:=0;
  gEcsGlob.IncDocQnt:=0;
  gEcsGlob.DecDocQnt:=0;
  gEcsGlob.ClmItmQnt:=0;
  gEcsGlob.NegItmQnt:=0;
  gEcsGlob.DscItmQnt:=0;
  gEcsGlob.AdvItmQnt:=0;
end;

procedure ClearClsData;
// Vynuluje alebo nastav˝ zakladnÈ hodnoty glob·lnej premennej gClsData
var I:longint;
begin
  gClsData.DClsNumF:=0;
  gClsData.DClsNumL:=0;
  gClsData.DClsDateF:=0;
  gClsData.DClsDateL:=0;
  For I:=0 to 9 do begin
    gClsData.PayVals[I].TrnVal:=0;
    gClsData.PayVals[I].ExpVal:=0;
    gClsData.PayVals[I].IncVal:=0;
  end;
  For I:=1 to 5 do begin
    gClsData.VatPrc[I]:=gEcsGlob.VatPrc[I];
    gClsData.AValue[I]:=0;
    gClsData.BValue[I]:=0;
    gClsData.VatVal[I]:=0;
  end;
  gClsData.ClmVal:=0;
  gClsData.NegVal:=0;
  gClsData.AdvVal:=0;
  gClsData.DscVal:=0;
  gClsData.RndH:=0;
  gClsData.RndI_P:=0;
  gClsData.RndI_N:=0;
  gClsData.ICDocPay:=0;
  gClsData.SalDocQnt:=0;
  gClsData.ICDocQnt:=0;
  gClsData.IncDocQnt:=0;
  gClsData.ExpDocQnt:=0;
  gClsData.ClmItmQnt:=0;
  gClsData.NegItmQnt:=0;
  gClsData.DscItmQnt:=0;
  gClsData.AdvItmQnt:=0;
end;

function  GetTFileName (pDate:TDate;pCasNum:longint):string;
// Zo zadanÈho d·tumu vr·ti n·zov T s˙boru
var mD,mM,mY:word;
begin
  DecodeDate(pDate,mY,mM,mD);
  Result := 'T'+StrIntZero (mD,2)+StrIntZero (mM,2)+Copy (StrInt (mY,4),3,2)+'.'+StrIntZero (pCasNum,3);
end;

function  GetCFileName (pDate:TDate;pCasNum:longint):string;
// Zo zadanÈho d·tumu vr·ti n·zov C s˙boru
var mD,mM,mY:word;
begin
  DecodeDate(pDate,mY,mM,mD);
  Result := 'C'+StrIntZero (mD,2)+StrIntZero (mM,2)+Copy (StrInt (mY,4),3,2)+'.'+StrIntZero (pCasNum,3);
end;


procedure ClearBlkHead;
// Vynuluje glob·ln˙ premenn˙ gBlkHead
begin
  FillChar (gBlkHead,SizeOf(gBlkHead),#0);
end;

procedure ClearBlkItems;
// Vynuluje glob·ln˙ premenn˙ gBlkItemQnt
begin
  gBlkItemQnt:=0;
  FillChar (gBlkItems,SizeOf(gBlkItems),#0);
end;

procedure ClearPays;
// Vynuluje glob·ln˙ premenn˙ uPaysTbl
begin
  FillChar (uPaysTbl,SizeOf(uPaysTbl),#0);
end;

procedure ClearNoteLst;
// Vynuluje glob·ln˙ premenn˙ uNoteLst
begin
  FillChar (uNoteLst,SizeOf(uNoteLst),#0);
  uNoteQnt:=0;
end;

procedure CalcPayEndVal (pNum:longint);
// VypoËÌta koneËn˝ stav platidiel
begin
  If pNum in [0..9] then begin
    gEcsGlob.PayVals[pNum].EndVal:=gEcsGlob.PayVals[pNum].BegVal+gEcsGlob.PayVals[pNum].TrnVal
      -gEcsGlob.PayVals[pNum].ExpVal+gEcsGlob.PayVals[pNum].IncVal
      -gEcsGlob.PayVals[pNum].ChOVal+gEcsGlob.PayVals[pNum].ChIVal;
    gEcsGlob.PayVals[pNum].EndVal:=Roundx(gEcsGlob.PayVals[pNum].EndVal,2);
  end;
end;

procedure SaveToCFile (pDoc,pPath:string;pCasNum,pIntDocQnt:longint;pDocDate:TDate;pDocTime:TTime;pDocType,peKasaDocNum:string);
var mFileName,mCDoc:string; mT:TextFile; mW:tTxtWrap; mLocSize,mErr:longint;
begin
  mFileName := pPath+GetCFileName(pDocDate, pCasNum);
  mLocSize := TxtFile.GetFileSize (mFileName);
  mW := TTxtWrap.Create;
  mW.ClearWrap;
  mW.SetText('B',0);
  mW.SetText(pDocType,0);
  mW.SetNum(pIntDocQnt,0);
  mW.SetDate(pDocDate);
  mW.SetTime(pDocTime);
  mW.SetText(peKasaDocNum,0);
  mCDoc := mW.GetWrapText+zCR+zLF;
  mCDoc := mCDoc+pDoc;
  mW.ClearWrap;
  mW.SetText('E',0);
  mCDoc := mCDoc+mW.GetWrapText+zCR+zLF;
  FreeAndNil (mW);
  If OpenTxtFileWrite(mT, mFileName, mErr) then begin
    WriteTxtFile(mT, mCDoc, mErr);
    CloseTxtFile (mT, mErr);
  end;
end;

function StrPrice (pPrice:double):string;
// Prekontroluje cenu na reùazec na 3 alebo 2 desatinnÈ mnoûstvo
begin
  If Eq3(pPrice, Roundx(pPrice, 2))
    then Result := StrDoub(pPrice, 0, 2)
    else Result := StrDoub(pPrice, 0, 3);
end;

function RoundIntSpec(v:double):double;
// Funkcia zaokruhli podobne ako ROUND s tym rozdielom ze
/// XXX.5 sa vzdy rovna XXX+1
// a nie podla toho ci XXX je parne nadol a neparne nahor
var mRoundUp:boolean; I:double; mS:string;
begin
  mS:=StrDoub(v,0,4);
  Delete(mS,Length(mS)-2,3);
  v:=ValDoub(mS);
  mRoundUp:=Frac(Abs(v))>=0.5;
  I:=Int(v);
  if v>0 then begin
    if mRoundUp then I:=I+1;
  end else begin
    if mRoundUp then I:=I-1;
  end;
  Result:=I;
end;

function RoundSpec (pNumber:double;pFract:integer):double;
// ZaokruhlÌ speci·lne pomocou funkcie RoundIntSpec na zadan˝ poËet desatinn˝ch miest
var  N: double;
begin
  N := Sq (10, pFract);
  If pFract<0 then
  begin
    Result:=RoundIntSpec(pNumber*N)/N;
    Result:=ValDoub(StrDoub (Result,0,pFract));
  end else
  begin
    Result:=RoundIntSpec(pNumber*N)/N;
    Result:=ValDoub(StrDoub (Result,0,pFract));
  end;
end;

//  >>>>> TePortosHand >>>>>
constructor TePortosHand.Create(pHost:string;pPort,pConnectTimeout,pReadTimeout:longint);
begin
  oHost:=pHost;
  oPort:=StrInt(pPort,0);
  oHTTP:=TIdHTTP.Create;
  oHTTP.Request.Accept:='application/json';
  oHTTP.Request.ContentType:='application/json';
  oHTTP.Response.ContentType:='application/json';
  oHTTP.ConnectTimeout:=pConnectTimeout;
  oHTTP.ReadTimeout:=pReadTimeout;
  oHTTP.HTTPOptions:=oHTTP.HTTPOptions+[hoWaitForUnexpectedData];
  oJSon:=TStringList.Create;
  oPayLst:=TStringList.Create;
  oItmLst:=TStringList.Create;
  oHTTPCode:=0;
  oHTTPText:='';
end;

destructor TePortosHand.Destroy;
begin
  FreeAndNil(oItmLst);
  FreeAndNil(oPayLst);
  FreeAndNil(oJSon);
  try
    FreeAndNil(oHTTP);
  except end;
end;

function TePortosHand.GetData(pType:string):string;
// T·to funkcia odoöle GetData cez HTTP
begin
  oJSon.Clear;
  Result:='';
  try
    Result:=oHTTP.Get('http://'+oHost+':'+oPort+pType);
  except end;
  try
    oHTTPCode:=oHTTP.ResponseCode;
    oHTTPText:=oHTTP.ResponseText;
  except end;
  If (oHTTPCode<>200) and (oHTTPCode<>204) then WriteLogErr('GetData;'+pType+';'+Result+';'+StrInt(oHTTPCode,0)+';'+oHTTPText);
  WriteLogDebug('GetData;'+pType+';'+Result+';'+StrInt(oHTTPCode,0)+';'+oHTTPText);
end;

function TePortosHand.PostData(pType,pData:string):string;
// T·to funkcia odoöle PostData cez HTTP
var mParStream:TStringStream; mS:string;
begin
  Result:='';
  oJSon.Clear;
  mParStream := TStringStream.Create(Utf8Encode(pData));
  try
    Result:=oHTTP.Post('http://'+oHost+':'+oPort+pType,mParStream);
  except end;
  mS:='';
  try
    oHTTPCode:=oHTTP.ResponseCode;
    oHTTPText:=oHTTP.ResponseText;
  except end;
  FreeAndNil(mParStream);
  If (oHTTPCode<>200) and (oHTTPCode<>204) then WriteLogErr('PostData;'+pType+';'+pData+';'+Result+';'+StrInt(oHTTPCode,0)+';'+oHTTPText);
  WriteLogDebug('PostData;'+pType+';'+pData+';'+Result+';'+StrInt(oHTTPCode,0)+';'+oHTTPText);
end;

procedure TePortosHand.FillJSonData(pData:string);
// T·to metÛda prevedie ˙daje pData, ktorÈ s˙ v JSon form·te na mÙj StringList form·t do premennej oJSon
var mSLst,mGLst:TStringList; I,J:longint; mS,mGrp,mCntS:string; mRef:boolean;
begin
  oJSon.Clear;
  If Copy(pData,1,1)='[' then Delete(pData,1,1);
  If Copy(pData,1,1)='{' then Delete(pData,1,1);
  If Copy(pData,Length(pData),1)='}' then Delete(pData,Length(pData),1);
  pData:=ReplaceStr(pData,',"',#13+#10+'"');
  pData:=ReplaceStr(pData,'},{',#13+#10+zUS+#13+#10);

  pData:=ReplaceStr(pData,'":[{','":'+zDC1+#13+#10+zDC3+#13+#10);
  pData:=ReplaceStr(pData,'}]',#13+#10+zDC2+#13+#10+zDC4);
  pData:=ReplaceStr(pData,'":{','":'+zDC1+#13+#10);
  pData:=ReplaceStr(pData,'},"',#13+#10+zDC2+#13+#10+'"');
  pData:=ReplaceStr(pData,'}',#13+#10+zDC2);

  mSLst:=TStringList.Create;
  mGLst:=TStringList.Create;
  mSLst.Text:=pData;
  mGrp:='';
  If mSLst.Count>0 then begin
    For I:=0 to mSLst.Count-1 do begin
      mRef:=TRUE;
      mS:=mSLst.Strings[I];
      If Copy(mS,Length(mS)-2,3)='":'+zDC1 then begin
        Delete(mS,Length(mS)-1,2);
        mGLst.Add(mS);
      end else begin
        If mS=zDC2 then begin
          If mGLst.Count>0 then mGLst.Delete(mGLst.Count-1);
        end else begin
          If mS=zUS then begin
            mCntS:=mGLst.Strings[mGLst.Count-1];
            mGLst.Delete(mGLst.Count-1);
            Delete(mCntS,1,1);
            Delete(mCntS,Length(mCntS),1);
            mCntS:='"'+StrInt(ValInt(mCntS)+1,0)+'"';
            mGLst.Add(mCntS);
          end else begin
            If mS=zDC3 then begin
              mCntS:='"'+StrInt(ValInt(mCntS)+1,0)+'"';
              mGLst.Add(mCntS);
            end else begin
              If mS=zDC4 then begin
                If mGLst.Count>0 then mGLst.Delete(mGLst.Count-1);
              end else begin
                mRef:=FALSE;
                oJSon.Add(mGrp+mS);
              end;
            end;
          end;
        end;
      end;
      If mRef then begin
        mGrp:='';
        If mGLst.Count>0 then begin
          For J:=0 to mGLst.Count-1 do
            mGrp:=mGrp+mGLst.Strings[J]+'.';
        end;
      end;
    end;
  end;
  FreeAndNil(mGLst);
  FreeAndNil(mSLst);
end;

function TePortosHand.FindJSonItm(pItm:string):string;
// T·to funkcia vyhæad· zadan˙ poloûku z oJSon zoznamu
var I:longint; mS:string;
begin
  Result:='';
  For I:=0 to oJSon.Count-1 do begin
    mS:=oJSon.Strings[I];
    If Pos(pItm+':',mS)>0 then begin
      Delete(mS,1,Pos('":',mS)+1);
      If Copy(mS,1,1)='"' then Delete(mS,1,1);
      If Copy(mS,Length(mS),1)='"' then Delete(mS,Length(mS),1);
      Result:=mS;
      Break;
    end;
  end;
end;

function TePortosHand.FillDeposit(pVal:double;pHead,pFoot:string):string;
// T·to funkcia vr·ti form·t pre vklad
begin
  Result:='{"request":{"data":{';
  Result:=Result+'"amount":'+StrDoub(pVal,0,2)+',';
  Result:=Result+'"receiptType":"Deposit",';
  pHead:=ReplaceStr(pHead,'"',' ');
  pFoot:=ReplaceStr(pFoot,'"',' ');
  If pHead<>'' then Result:=Result+'"headerText":"'+pHead+'",';
  If pFoot<>'' then Result:=Result+'"footerText":"'+pFoot+'",';
  Result:=Result+'"cashRegisterCode":"'+geKasaInfo.CashRegisterCode+'"}';
  Result:=Result+'},"print":{"printerName":"pos"}}';
end;

function TePortosHand.FillWithdraw(pVal:double;pHead,pFoot:string):string;
// T·to funkcia vr·ti form·t pre v˝ber
begin
  Result:='{"request":{"data":{';
  Result:=Result+'"amount":'+StrDoub(pVal,0,2)+',';
  Result:=Result+'"receiptType":"Withdraw",';
  pHead:=ReplaceStr(pHead,'"',' ');
  pFoot:=ReplaceStr(pFoot,'"',' ');
  If pHead<>'' then Result:=Result+'"headerText":"'+pHead+'",';
  If pFoot<>'' then Result:=Result+'"footerText":"'+pFoot+'",';
  Result:=Result+'"cashRegisterCode":"'+geKasaInfo.CashRegisterCode+'"}';
  Result:=Result+'},"print":{"printerName":"pos"}}';
end;

function TePortosHand.FillICDoc(pDocVal:double;pICDocNum,pCustID:string;pCustIDType:byte;pHead,pFoot:string):string;
// T·to funkcia vr·ti form·t pre ˙hradu FA
var I:longint; mS,mCustIDType:string;
begin
  Result:='{"request":{"data":{';
  Result:=Result+'"amount":'+StrDoub(pDocVal,0,2)+',';
  Result:=Result+'"invoiceNumber":"'+pICDocNum+'",';
  Result:=Result+'"payments":[';
  For I:=0 to oPayLst.Count-1 do begin
    mS:=oPayLst.Strings[I];
    If I>0 then Result:=Result+',';
    Result:=Result+mS;
  end;
  mCustIDType:='DIC';
  If pCustIDType=cCustIDICO then mCustIDType:='ICO';
  If pCustIDType=cCustIDICDPH then mCustIDType:='ICDPH';
  If pCustIDType=cCustIDOther then mCustIDType:='Other';
  Result:=Result+'],';
  If pCustID<>'' then Result:=Result+'"customer":{"id":"'+pCustID+'","type":"'+mCustIDType+'"},';
  Result:=Result+'"receiptType":"Invoice",';
  pHead:=ReplaceStr(pHead,'"',' ');
  pFoot:=ReplaceStr(pFoot,'"',' ');
  If pHead<>'' then Result:=Result+'"headerText":"'+pHead+'",';
  If pFoot<>'' then Result:=Result+'"footerText":"'+pFoot+'",';
  Result:=Result+'"cashRegisterCode":"'+geKasaInfo.CashRegisterCode+'"}';
  Result:=Result+'},"print":{"printerName":"pos"}}';
end;

function TePortosHand.FillBlkData(pHead,pFoot:string):string;
// T·to funkcia vr·ti form·t pokladniËnÈho dokladu
var I:longint; mS:string;
begin
  Result:='{"request":{"data":{';
  Result:=Result+'"items":[';
  For I:=0 to oItmLst.Count-1 do begin
    mS:=oItmLst.Strings[I];
    If I>0 then Result:=Result+',';
    Result:=Result+mS;
  end;
  Result:=Result+'],"payments":[';
  For I:=0 to oPayLst.Count-1 do begin
    mS:=oPayLst.Strings[I];
    If I>0 then Result:=Result+',';
    Result:=Result+mS;
  end;
  Result:=Result+'],"receiptType":"CashRegister",';
  pHead:=ReplaceStr(pHead,'"',' ');
  pFoot:=ReplaceStr(pFoot,'"',' ');
// 27.6.2022 Tibi zaokr˙hlenie
  If IsNotNul(Rd2(gBlkHead.RndVal)) then Result:=Result+'"roundingAmount":"'+StrDoub(gBlkHead.RndVal,0,2)+'",';
  If pHead<>'' then Result:=Result+'"headerText":"'+pHead+'",';
  If pFoot<>'' then Result:=Result+'"footerText":"'+pFoot+'",';
  Result:=Result+'"cashRegisterCode":"'+geKasaInfo.CashRegisterCode+'"}';
  Result:=Result+'},"print":{"printerName":"pos"}}';
end;

function TePortosHand.GetItmTypeStr(pItmType:byte):string;
// T·to funkcia vr·ti typ poloûky
begin
  Result:='Positive';
  case pItmType of
    cItmTypeReturned:Result:='Returned';
    cItmTypeDiscount:Result:='Discount';
    cItmTypeAdvance :Result:='Advance';
    cItmTypeReturnedContainer:Result:='returnedContainer';
  end;
end;

function TePortosHand.Initialize:boolean;
// T·to funkcia inicializuje eKasu. NastavÌ kÛd pokladne a verziu
var I:longint;
begin
  geKasaInfo.Initialized:=FALSE;
  geKasaInfo.eKasaType:='Portos';
  geKasaInfo.Version:='';
  geKasaInfo.CashRegisterCode:='';
  For I:=1 to 5 do
    geKasaInfo.VatPrc[I]:=100;    //Pre Portos nie sa nepouûÌva
  Result:=GetCashRegisterCode;
  If Result then begin
    geKasaInfo.Version:=GetVersion;
    geKasaInfo.Initialized:=TRUE;
  end;
end;

function TePortosHand.GetCashRegisterCode:boolean;
// T·to funkcia vyËÌta kÛd pokladne a uloûÌ do premennej geKasaInfo.CashRegisterCode
var mS:string;
begin
  Result:=FALSE;
  geKasaInfo.CashRegisterCode:='';
  mS:=GetData('/api/v1/identities');
  If oHTTPCode=200 then begin
    Result:=TRUE;
    FillJSonData(mS);
    geKasaInfo.CashRegisterCode:=FindJSonItm('"organizationUnit"."cashRegisterCode"');
  end;
end;

function TePortosHand.GetPrnState:boolean;
// T·to funkcia vr·ti stav tlaËiarne
var mS:string;
begin
  Result:=FALSE;
  mS:=GetData('/api/v1/printers/status');
  If oHTTPCode=200 then begin
//    Result:=mS='{"state":"Ready"}';
    Result:=Pos ('"state":"Ready"',mS)>0;
  end;
end;

function TePortosHand.GetConnetced:boolean;
// T·to funkcia vr·ti stav pripojenia na FS
var mS:string;
begin
  Result:=FALSE;
  mS:=GetData('/api/v1/connectivity/status');
  If oHTTPCode=200 then begin
    FillJSonData(mS);
    Result:=FindJSonItm('"state"')='Up';
  end;
end;

function TePortosHand.GetCertificates:TDateTime;
// T·to funkcia vr·ti platnosù certifik·tu
var mS,mDateS:string;
begin
  Result:=0;
  mS:=GetData('/api/v1/certificates');
  If oHTTPCode=200 then begin
    FillJSonData(mS);
//    Result:=FindJSonItm('"isExpired"');
    mDateS:=FindJSonItm('"expirationDate"');
    with TXSDateTime.Create() do
      try
        XSToNative(mDateS); // convert from WideString
        Result:=AsDateTime; // convert to TDateTime
      finally
        Free;
      end;
  end;
end;

function TePortosHand.GetVersion:string;
// T·to funkcia vr·ti verziu PPEKK a CHDU
var mS:string;
begin
  Result:='';
  mS:=GetData('/api/v1/product/info');
  If oHTTPCode=200 then begin
    FillJSonData(mS);
    Result:=FindJSonItm('"ppekk"."version"')+'/'+FindJSonItm('"chdu"."version"');
  end;
end;

function TePortosHand.GetLastReceiptNumber:longint;
// T·to funkcia vr·ti aktu·lne poradovÈ ËÌslo ˙Ëtenky za aktu·lny mesiac
var mS:string;
begin
  Result:=0;
  mS:=GetData('/api/v1/storage/last_receipt_number?cashRegisterCode='+geKasaInfo.CashRegisterCode);
  If oHTTPCode=200 then begin
    FillJSonData(mS);
    mS:=FindJSonItm('"receiptNumber"');
    Result:=ValInt(mS);
  end;
end;

function TePortosHand.GetFullLastReceiptNumber:string;
// T·to funkcia vr·ti aktu·lne celÈ ËÌslo ˙Ëtenky vr·tane mesiaca a roka
var mS:string;
begin
  Result:='';
  mS:=GetData('/api/v1/storage/last_receipt_number?cashRegisterCode='+geKasaInfo.CashRegisterCode);
  If oHTTPCode=200 then begin
    FillJSonData(mS);
    Result:=FindJSonItm('"year"')+StrIntZero(ValInt(FindJSonItm('"month"')),2)+StrIntZero(ValInt(FindJSonItm('"receiptNumber"')),6);
  end;
end;

function TePortosHand.OpenDrawer:boolean;
// T·to funkcia otvorÌ pokladniËn˙ z·suvku
var mS:string;
begin
  Result:=FALSE;
  PostData('/api/v1/printers/open_drawer','');
  Result:=(oHTTPCode=204) or (oHTTPCode=200);
end;

function TePortosHand.PrintText(pText:string;pPrnHead:boolean):boolean;
// T·to funkcia vytlaËÌ nedaÚovÌ doklad. Ak pPrnHead, tak automaticky vytlaËÌ aj hlaviËku
var mS:string;
begin
  mS:='{"text":"'+pText+'"';
  If pPrnHead and (geKasaInfo.CashRegisterCode<>'') then mS:=mS+',"cashRegisterCode":"'+geKasaInfo.CashRegisterCode+'"';
  mS:=mS+'}';
  PostData('/api/v1/printers/print',mS);
  Result:=(oHTTPCode=204) or (oHTTPCode=200);
end;

function TePortosHand.PrintDeposit(pVal:double;pHead,pFoot:string):boolean;
var mS:string;
begin
  Result:=FALSE;
  oFullDocNum:=GetFullLastReceiptNumber;
  pHead:=ReplaceStr(pHead,'"',' ');
  pFoot:=ReplaceStr(pFoot,'"',' ');
  mS:=FillDeposit(pVal,pHead,pFoot);
  mS:=PostData('/api/v1/requests/receipts/deposit',mS);
  FillJSonData(mS);
  Result:=(oHTTPCode=200) or (oHTTPCode=202);
end;

function TePortosHand.PrintWithDraw(pVal:double;pHead,pFoot:string):boolean;
var mS:string;
begin
  Result:=FALSE;
  pHead:=ReplaceStr(pHead,'"',' ');
  pFoot:=ReplaceStr(pFoot,'"',' ');
  mS:=FillWithdraw(pVal,pHead,pFoot);
  mS:=PostData('/api/v1/requests/receipts/withdraw',mS);
  FillJSonData(mS);
  Result:=(oHTTPCode=200) or (oHTTPCode=202);
end;

procedure TePortosHand.SetICDocH(pHead:string);
// T·to funkcia vynuleje parametre pre nov˙ ˙hradu FA
begin
  oDocValPay:=0;
  oPayLst.Clear;
  oHead:=ReplaceStr(pHead,'"',' ');
  oFullDocNum:=GetFullLastReceiptNumber;
end;

procedure TePortosHand.SetICDocP(pName:string;pValue:double);
// Pomocou tejto funkcie treba zadaù ˙hrady podæa platidiel
var mS:string;
begin
  oDocValPay:=oDocValPay+pValue;
  mS:='{"name":"'+pName+'","amount":"'+StrDoub(pValue,0,2)+'"}';
  oPayLst.Add(mS);
end;

function TePortosHand.PrintICDoc(pDocVal:double;pICDocNum,pCustID:string;pCustIDType:byte;pFoot:string):boolean;
// T·to funkcia vytlaËÌ doklad o ˙hrade FA
var mS,mFullDocNum:string; mSLst:TStringList;
begin
  Result:=FALSE;
  oUID:='';
  If Eq2 (pDocVal,oDocValPay) and (oPayLst.Count>0) then begin
    pFoot:=ReplaceStr(pFoot,'"',' ');
    mS:=FillICDoc(pDocVal,pICDocNum,pCustID,pCustIDType,oHead,pFoot);
    mS:=PostData('/api/v1/requests/receipts/invoice',mS);
    FillJSonData(mS);
    mSLst:=TStringList.Create;
    If oHTTPCode=200 then begin
      oUID:=FindJSonItm('"response"."data"."id"');
    end;
    Result:=(oHTTPCode=200) or (oHTTPCode=202);
    If Result then begin
      mFullDocNum:=GetFullLastReceiptNumber;
      Result:=(oFullDocNum<>mFullDocNum);
    end;
  end;
end;

function TePortosHand.SetBlkH(pHead:string):boolean;
// T·to funkcia vynuleje parametre pre nov˝ pokladniËn˝ doklad
begin
  oDocValPay:=0;
  oPayLst.Clear;
  oItmLst.Clear;
  oHead:=ReplaceStr(pHead,'"',' ');
  oFullDocNum:=GetFullLastReceiptNumber;
  Result:=TRUE;
end;

function TePortosHand.SetBlkI(pItmType:byte;pGsName:string;pPrice,pQnt,pValue:double;pVatPrc:longint;pMs,pDescription,pReferenceReceiptId:string):boolean;
// Pomocou tejto funkcie treba zadaù poloûky
var mS,mPriceS:string;
begin
  Result:=TRUE;
  pGsName:=ReplaceStr(pGsName,'"',' ');
  pMs:=ReplaceStr(pmS,'"',' ');
  pDescription:=ReplaceStr(pDescription,'"',' ');
  If pQnt<0 then begin
    If (pItmType=cItmTypePositive) then begin
      pItmType:=cItmTypeReturned;
      pQnt:=Abs(pQnt);
      pPrice:=-1*Abs(pPrice);
    end else begin
      pQnt:=Abs(pQnt);
      pPrice:=-1*Abs(pPrice);
    end;
  end;
  Result:=Eq2 (pQnt*pPrice, pValue);
  If Result then begin
    oDocValItm:=oDocValItm+pValue;
    If pMs='' then pMs:='x';
    If pItmType<>cItmTypeReturned
      then pReferenceReceiptId:=''
      else begin
        If pReferenceReceiptId='' then pReferenceReceiptId:='1';
      end;

    mS:='{"type":"'+GetItmTypeStr(pItmType)+'"';
    mS:=mS+',"name":"'+pGsName+'"';
    mS:=mS+',"price":"'+StrDoub(pValue,0,2)+'"';
    mPriceS:=StrDoub(pPrice,0,3);
    If Copy(mPriceS,Length(mPriceS),1)='0' then Delete(mPriceS,Length(mPriceS),1);
    mS:=mS+',"unitPrice":"'+mPriceS+'"';
    mS:=mS+',"quantity":{"amount":"'+StripFractZero(StrDoub(pQnt,0,3))+'","unit":"'+Copy(pMs,1,3)+'"}';
    If pReferenceReceiptId<>'' then mS:=mS+',"referenceReceiptId": "'+pReferenceReceiptId+'"';
    mS:=mS+',"vatRate":"'+StrInt(pVatPrc,0)+'"';
    If pDescription<>'' then mS:=mS+',"description":"'+pDescription+'"';
    mS:=mS+'}';
    oItmLst.Add(mS);
  end;
end;

procedure TePortosHand.SetBlkP(pName:string;pValue:double);
// Pomocou tejto funkcie treba zadaù ˙hrady podæa platidiel
var mS:string;
begin
  oDocValPay:=oDocValPay+pValue;
  mS:='{"name":"'+pName+'","amount":"'+StrDoub(pValue,0,2)+'"}';
  oPayLst.Add(mS);
end;

function TePortosHand.PrintBlk(pDocVal:double;pFoot:string):boolean;
// T·to funkcia vytlaËÌ cel˝ pokladniËn˝ doklad
var mS:string;
begin
  Result:=FALSE;
  oUID:='';
  If Eq2 (pDocVal,oDocValItm) and Eq2 (pDocVal+gBlkHead.RndVal,oDocValPay) and (oItmLst.Count>0) and (oPayLst.Count>0) then begin
    pFoot:=ReplaceStr(pFoot,'"',' ');
    mS:=FillBlkData(oHead,pFoot);
    mS:=PostData('/api/v1/requests/receipts/cash_register',mS);
    FillJSonData(mS);
    If oHTTPCode=200 then begin
      oUID:=FindJSonItm('"response"."data"."id"');
    end;
    Result:=(oHTTPCode=200) or (oHTTPCode=202);
  end;
end;

function TePortosHand.PrintCopy(pYear,pMonth,pReceiptNumber:longint):boolean;
var mS:string;
begin
  Result:=FALSE;
  mS:='?CashRegisterCode='+geKasaInfo.CashRegisterCode+'&Year='+StrInt(pYear,0)+'&Month='+StrInt(pMonth,0)+'&ReceiptNumber='+StrInt(pReceiptNumber,0);
  mS:=PostData('/api/v1/requests/receipts/print_copy'+mS,'');
  FillJSonData(mS);
  Result:=(oHTTPCode=204) or (oHTTPCode=200);
end;

function TePortosHand.PrintLastBlock:boolean;
var mDocNum:longint; mY,mM,mD:word;
begin
  mDocNum:=GetLastReceiptNumber;
  DecodeDate(Date,mY,mM,mD);
  Result:=PrintCopy(mY,mM,mDocNum);
end;

//  <<<<< TePortosHand <<<<<

//  >>>>> TeKasaSKHand >>>>>
constructor TeKasaSKHand.Create(pHost:string;pPort,pConnectTimeout,pReadTimeout:longint);
begin
  oIdTCPClient:=TIdTCPClient.Create;
  oIdTCPClient.Host:=pHost;
  oIdTCPClient.Port:=pPort;
  oIdTCPClient.ReadTimeout:=pReadTimeout;
  oIdTCPClient.ConnectTimeout:=pConnectTimeout;
  Connect;
end;

destructor TeKasaSKHand.Destroy;
begin
  try
    If oIdTCPClient.Connected then oIdTCPClient.Disconnect;
  except end;
  try
    FreeAndNil(oIdTCPClient);
  except end;
  inherited;
end;

function TeKasaSKHand.Connect:boolean;
begin
  Result:=FALSE;
  try
    oIdTCPClient.Connect;
  except end;
  try
    Result:=oIdTCPClient.Connected;
  except end;
end;

function TeKasaSKHand.SendData(pData:string;pDelay:longint):string;
// T·to funkcia odoöe ˙daje do PPEKK
var mS,mAns,mCheck,mWriteMain,mRead,mWrite:string; I,mLen:longint; mEnd:boolean; mErr:boolean;
begin
  Result:='';
  If not oIdTCPClient.Connected then Connect;
  If oIdTCPClient.Connected then begin
    mS := Chr($1C)+Chr(01)+pData+zEOT;
    mWriteMain:=mS+Chr(CalcBCC(mS));
    oIdTCPClient.IOHandler.Write(mWriteMain);
    WriteLogDebug('Write;'+mWriteMain);
    mErr:=FALSE;
    mEnd:=TRUE;
    Repeat
      oIdTCPClient.IOHandler.CheckForDataOnSource(pDelay);
      mAns:=ReadLen(1);
      mRead:=mAns; mWrite:='';
      If Length(mAns)=1 then begin
        case mAns[1] of
          ':' : begin
                  mAns:=ReadLen(1);
                  mRead:=mRead+mAns;
                  If Length(mAns)=1 then begin
                    mLen:=Ord(mAns[1]);
                    If mLen>0 then begin
                      mAns:=ReadLen(mLen+1);
                      mRead:=mRead+mAns;
                      Result:=Result+Remove1B(mAns);
                      mAns:=ReadLen(2);
                      mRead:=mRead+mAns;
                      If Length(mAns)=2 then begin
                        case mAns[1] of
                          zETB: begin
                                  mWrite:=zACK;
                                  oIdTCPClient.IOHandler.Write(mWrite);
                                  mEnd:=FALSE;
                                end;
                          zETX: begin
                                  mWrite:=zETX;
                                  oIdTCPClient.IOHandler.Write(mWrite);
                                  mEnd:=TRUE;
                                end;
                        end;
                      end;
                    end;
                  end;
                end;
          zACK: begin
                  Result:=zACK;
                  mEnd:=TRUE;
                end;
          zNAK: begin
                  mErr:=TRUE;
                  mAns:='';
                  mLen:=oIdTCPClient.IOHandler.InputBuffer.Size;
                  If mLen>0 then begin
                    mAns:=ReadLen(mLen);
                    mRead:=mRead+mAns;
                    // Doplniù - chybovÈ kÛdy
                  end;
                  mEnd:=TRUE;
                end;
          zEOT: begin
                  oIdTCPClient.IOHandler.CheckForDataOnSource(500);
                  mLen:=oIdTCPClient.IOHandler.InputBuffer.Size;
                  If mLen>0 then begin
                    mAns:=ReadLen(mLen);
                    mRead:=mRead+mAns;
                  end;
                  mWrite:=zEOT;
                  oIdTCPClient.IOHandler.Write(mWrite);

                  oIdTCPClient.IOHandler.CheckForDataOnSource(500);
                  mLen:=oIdTCPClient.IOHandler.InputBuffer.Size;
                  If mLen>0 then begin
                    mAns:=ReadLen(mLen);
                    mRead:=mRead+mAns;
                  end;
                end;
          else begin
            mAns:='';
          end;
        end;
      end else begin
        mEnd:=TRUE;
        mErr:=TRUE;
      end;
      If mRead<>'' then WriteLogDebug('Read;'+mRead);
      If mWrite<>'' then WriteLogDebug('Write;'+mWrite);
      If mErr then begin
        If mWriteMain<>'' then WriteLogErr('Write;'+mWriteMain);
        If mRead<>'' then WriteLogErr('Read;'+mRead);
        If mWrite<>'' then WriteLogErr('Write;'+mWrite);
      end;
      Application.ProcessMessages;
    until mEnd;
  end;
end;

function TeKasaSKHand.SendData(pData:string):string;
// T·to funkcia odoöe ˙daje so fixnok dæûkou pri poûkanÌ na odpoveÔ
begin
  Result:=SendData(pData,2000);
end;

function TeKasaSKHand.ReadLen(pLen:longint):string;
// T·to funkcia vyËÌta zadan˝ dlh˝ reùaz cez TCP/IP
var mL:longint;
begin
  Result:='';
  mL:=oIdTCPClient.IOHandler.InputBuffer.Size;
  If mL>=pLen then begin
    Result:=oIdTCPClient.IOHandler.ReadString(pLen);
  end;
end;

function TeKasaSKHand.Remove1B(pStr:string):string;
// T·to funkcia odstr·ni zo zadanÈho reùazca nepotrebnÈ ESC sekvencie
var mPos:longint;
begin
  pStr:=ReplaceStr(pStr,#0,'');
  Repeat
    mPos:=Pos(zESC,pStr);
    If mPos>0 then begin
      Delete(pStr,mPos,2);
    end;
  until mPos=0;
  Repeat
    mPos:=Pos(#29,pStr);
    If mPos>0 then begin
      Delete(pStr,mPos,2);
    end;
  until mPos=0;
  Result:=pStr;
end;

function TeKasaSKHand.CalcBCC(pStr:string):byte;
// T·to funkcia vypoËÌta kontrolnÈ ËÌslo
var I:longint;
begin
 Result := 0;
 For I:=1 to Length (pStr) do
   Result := Result xor Ord (pStr[I]);
end;

function TeKasaSKHand.GetVariabData (pCom:string; var pData:string):boolean;
// T·to funkcia vyËÌta "variable" inform·cie
var mS,mAns:string;
begin
  Result:=FALSE;
  pData:='';
  mS := Chr($92)+pCom+zNul;
  mAns:=SendData(mS);
  If mAns<>'' then begin
    pData:=mAns;
    Result:=TRUE;
  end;
end;

function TeKasaSKHand.GetVatSymb (pVatPrc:double):string;
// T·to funkcia vr·ti oznaËenie zadanej sadzby DPH
begin
  Result := 'A';
  If pVatPrc=geKasaInfo.VatPrc[5] then Result := 'E';
  If pVatPrc=geKasaInfo.VatPrc[4] then Result := 'D';
  If pVatPrc=geKasaInfo.VatPrc[3] then Result := 'C';
  If pVatPrc=geKasaInfo.VatPrc[2] then Result := 'B';
  If pVatPrc=geKasaInfo.VatPrc[1] then Result := 'A';
end;

function TeKasaSKHand.GetUID:Str50;
var mData:string;
begin
  Result:='';
  If GetVariabData ('B41', mData) then begin
    Result:=LineElement (mData,2,';');
  end;
end;

function TeKasaSKHand.Initialize:boolean;
// T·to funkcia inicializuje eKasu. NastavÌ kÛd pokladne, verziu a sadzby DPH
var I:longint;
begin
  geKasaInfo.Initialized:=FALSE;
  geKasaInfo.eKasaType:='eKasaSK';
  geKasaInfo.Version:='';
  geKasaInfo.CashRegisterCode:='';
  For I:=1 to 5 do
    geKasaInfo.VatPrc[I]:=100;
  Result:=GetCashRegisterCode;
  If Result then begin
    Result:=GetVatPrc;
    If Result then begin
      geKasaInfo.Version:=GetVersion;
      geKasaInfo.Initialized:=TRUE;
    end;
  end;
end;

function TeKasaSKHand.GetCashRegisterCode:boolean;
// T·to funkcia vyËÌta kÛd pokladne a uloûÌ do premennej geKasaInfo.CashRegisterCode
var mS:string;
begin
  Result:=FALSE;
  If GetVariabData('E31',mS) then begin
    Result:=TRUE;
    geKasaInfo.CashRegisterCode:=LineElement(mS,4,';');
  end;
end;

function TeKasaSKHand.GetPrnState:boolean;
// T·to funkcia vr·ti stav tlaËiarne
var mS:string;
begin
  Result:=TRUE;
(*  Result:=FALSE;
  If GetVariabData('F92',mS) then begin
    Result:=LineElement(mS,3,';')='false';
  end; *)
end;

function TeKasaSKHand.GetConnetced:boolean;
// T·to funkcia vr·ti stav pripojenia na FS - zatiaæ nie je podporovan·
begin
  Result:=TRUE;
end;

function TeKasaSKHand.GetCertificates:TDateTime;
// T·to funkcia vr·ti platnosù certifik·tu - t·to funkcia nie je podporovan·
begin
  Result:=0;
end;

function TeKasaSKHand.GetVersion:string;
// T·to funkcia vr·ti verziu PPEKK
var mData:string;
begin
  Result:='';
  If GetVariabData ('F11', mData) then begin
    Result:=LineElement(mData, 7, ';');
  end;
end;

function TeKasaSKHand.GetVatPrc:boolean;
// T·to funkcia nastav˝ sadzby DPH podæa eKasaSK
var I:byte; mData:string;
begin
  For I:=1 to 5 do
    geKasaInfo.VatPrc[I] := 0;
  For I:=1 to 5 do begin
    Result:=FALSE;
    If GetVariabData('13'+StrInt (I, 1),mData) then begin
      If mData<>'' then begin
        geKasaInfo.VatPrc[I] := ValInt (LineElement(mData, 1, ';'));
        Result:=TRUE;
      end;
    end else Break;
  end;
end;

function TeKasaSKHand.GetLastReceiptNumber:longint;
// T·to funkcia vr·ti aktu·lne poradovÈ ËÌslo ˙Ëtenky za aktu·lny mesiac
var mData:string;
begin
  Result:=0;
  If GetVariabData ('E21', mData) then begin
    mData:=LineElement(mData,2,';');
    Delete(mData,1,6);
    Result:=ValInt(mData);
  end;
end;

function TeKasaSKHand.GetFullLastReceiptNumber:string;
// T·to funkcia vr·ti aktu·lne celÈ ËÌslo ˙Ëtenky vr·tane mesiaca a roka
var mData:string;
begin
  Result:='';
  If GetVariabData ('E21', mData) then begin
    Result:=LineElement(mData,2,';');
  end;
end;

function TeKasaSKHand.GetDailyReceiptNumber:longint;
// funkcia vr·ti aktu·lne poradovÈ ËÌslo ˙Ëtenky za aktu·lny aktu·lny deÚ
var mData:string;
begin
  Result:=0;
  If GetVariabData ('E21', mData) then begin
    Result:=ValInt(LineElement(mData,1,';'));
  end;
end;

function TeKasaSKHand.OpenDrawer(pESC:string):boolean;
// T·to funkcia otvorÌ pokladniËn˙ z·suvku. Do parametra treba zadaù ESC sekvenciu.
// NajËastejöie kombin·cie: 27,112,0,20,150; 27,112,1,20,150; 27,112,48,20,150; 27,112,49,20,150
var mS, mEsc, mSS, mNS:string; mNum:byte;
begin
  Result := FALSE;
  If pESC<>'' then begin
    mEsc:='';
    mSS:=pESC;
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
    mS := Chr($C7)+mEsc+zNul;
    Result := (SendData(mS)<>'');
  end else Result:=TRUE;
end;

function TeKasaSKHand.ReadLastDoc:string;
// T·to funkcia vr·ti posledn˝ vytlaËen˝ doklad
begin
  Result:=Latin2ToWin1250(SendData(Chr($93)));
end;

function TeKasaSKHand.GetStatus:string;
// T·to funkcia vr·ti stav eKasaSK
var mData:string;
begin
  Result := '-';
  If GetVariabData ('F11', mData) then begin
    Result := LineElement (mData,5,';');
  end;
end;

function TeKasaSKHand.CancelDoc:boolean;
// T·to funkcia zruöÌ zaËat˝ doklad
var mStatus, mS:string; mLnNum, I:longint;
begin
  Result := FALSE;
  mStatus := GetStatus;
  If (mStatus<>'-') then begin
    If (mStatus<>'0') and (mStatus<>'1') then begin
      If mStatus='10'
        then mS := Chr($22)+StrInt (0, 0)+zNul
        else mS := Chr($2B)+StrInt (0, 0)+zNul+'Storno dokladu'+zNul;
      SendData(mS);
      Result:=TRUE;
    end else Result := TRUE;
  end;
end;

function TeKasaSKHand.PrintText(pText:string):boolean;
// T·to funkcia vytlaËÌ nedaÚovÌ doklad.
var mS,mStatus,mAns:string; mSLst:TStringList;I:longint;
begin
  Result:=FALSE;
  If oIdTCPClient.Connected then begin
    mStatus:=GetStatus;
    If (mStatus='2') or (mStatus='3') or (mStatus='4') or (mStatus='10') or (mStatus='20') or (mStatus='32') or (mStatus='34') then CancelDoc;
    mS:=Chr($20)+'0'+zNul+'6'+zNul+'0'+zNul+'0'+zNul+'0'+zNul+'0'+zNul;
    mAns:=SendData(mS);
    mSLst:=TStringList.Create;
    mSLst.Text:=pText;
    If mSLst.Count>0 then begin
      For I:=0 to mSLst.Count-1 do begin
        mS:=Copy(mSLst.Strings[I],1,40);
        mS := Chr($31)+StrInt(1,0)+zNul+mS+zNul;
        mAns:=SendData(mS);
      end;
    end;
    FreeAndNil(mSLst);
    mS := Chr($22)+StrInt (2, 0)+zNul+'0'+zNul;
    mAns:=SendData(mS);
    Result:=(mAns=zACK);
  end;
end;

function TeKasaSKHand.WriteToDisp (pText:string):boolean;
// T·to funkcia odoöle text na intern˝ displej
var mS:string;
begin
  Result := FALSE;
  pText := ReplaceStr(pText, zCR+zLF, '');
  mS := Chr($C6)+'0'+zNul+zNul;
  If SendData(mS)=zACK then begin
    mS := Chr($C5)+'0'+zNul+zNul+pText+zNul;
    If SendData(mS)=zACK then Result:=TRUE;
  end;
end;

function TeKasaSKHand.PrintItmNote(pText:string):boolean;
// T·to funkcia vytlaËÌ poznomkov˝ riadok pod poloûkou
var mSList:TStringList; I:longint; mS:string;
begin
  Result := TRUE;
  If pText<>'' then begin
    mSList := TStringList.Create;
    mSList.Text := pText;
    For I:=0 to mSList.Count-1 do begin
      mS:=Chr($32)+StrInt (0, 0)+zNul+mSList.Strings[I]+zNul;
      Result:=SendData(mS)=zACK;
      If not Result then Break;
    end;
    FreeAndNil (mSList);
  end;
end;

function TeKasaSKHand.PrintDocNote(pNote:string):boolean;
var mStr,mS:string; mSList:TStringList; I:longint;
begin
  mSList := TStringList.Create;
  mSList.Text := pNote;
  If mSList.Count>0 then begin
    For I:=0 to mSList.Count-1 do begin
      mStr := mSList.Strings[I];
      If Length (mStr)>=40 then mStr := Copy (mStr, 1, 39);
      mS := Chr($31)+StrInt (0, 0)+zNul+mStr+zNul;
      Result:=SendData(mS)=zACK;
      If not Result then Break;
    end;
  end;
  FreeAndNil(mSList);
end;

function TeKasaSKHand.PrintDepositH(pHead:string):boolean;
// T·to funkcia vytlaË˝ hlaviËky s pre vklad
var mS,mStatus:string;
begin
  Result := FALSE;
  mStatus:=GetStatus;
  If (mStatus='2') or (mStatus='3') or (mStatus='4') or (mStatus='10') or (mStatus='20') or (mStatus='32') or (mStatus='34') then CancelDoc;
  oFullDocNum:=GetFullLastReceiptNumber;
  mS := Chr($20)+'0'+zNul
        +'5'+zNul              //Typ dokladu
        +'1'+zNul              //Typ prenosu: riadkov˝/blokov˝
        +'0'+zNul              //Typ bloËku: kladn˝/z·porn˝
        +'0'+zNul              //Typ rekapitul·cie: skr·ten·/pln·
        +StrInt(0, 0)+zNul;    //grafick· hlaviËka: 0-6
  Result:=(SendData(mS)=zACK);
  If Result and (pHead<>'') then Result := PrintItmNote(pHead);
end;

function TeKasaSKHand.PrintDepositP(pPayNum:longint;pPayName:string;pVal:double):boolean;
// T·to funkcia vytlaËÌ platidlo pre vklad
var mS:string;
begin
  mS := Chr($2E)+StrInt (0,0)+zNul
        +pPayName+zNul                  //Popis
        +'0'+zNul                       //Typ oper·cie: 0-vklad/1-v˝ber
        +StrDoub(pVal, 0, 2)+zNul      //Suma
        +StrInt(pPayNum, 0)+zNul;      //»Ìslo platidla
  Result:=(SendData(mS)=zACK);
end;

function TeKasaSKHand.PrintDepositF(pFoot:string):boolean;
// T·to funkcia vytlaËÌ p‰tiËku pre vklad
var mS:string;
begin
  Result := FALSE;
  If PrintItmNote(pFoot) then begin
    mS := Chr($22)+StrInt (0, 0)+zNul+'0'+zNul;
    Result:=(SendData(mS,oIdTCPClient.ReadTimeout)=zACK);
  end;
end;

function TeKasaSKHand.PrintDeposit(pPayNum:longint;pPayName:string;pVal:double;pHead,pFoot:string):boolean;
// T·to funkcia vytlaËÌ cel˝ doklad pre vklad
begin
  Result:=FALSE;
  If oIdTCPClient.Connected then begin
    Result:=PrintDepositH(pHead);
    If Result then begin
      Result:=PrintDepositP(pPayNum,pPayName,pVal);
      If Result then begin
        Result:=PrintDepositF(pFoot);
      end;
    end;
  end;
end;

function TeKasaSKHand.PrintWithdrawH(pHead:string):boolean;
// T·to funkcia vytlaËÌ hlaviËku v˝beru
var mS,mStatus:string;
begin
  Result := FALSE;
  mStatus:=GetStatus;
  If (mStatus='2') or (mStatus='3') or (mStatus='4') or (mStatus='10') or (mStatus='20') or (mStatus='32') or (mStatus='34') then CancelDoc;
  mS := Chr($20)+'0'+zNul
        +'5'+zNul              //Typ dokladu
        +'1'+zNul              //Typ prenosu: riadkov˝/blokov˝
        +'0'+zNul              //Typ bloËku: kladn˝/z·porn˝
        +'0'+zNul              //Typ rekapitul·cie: skr·ten·/pln·
        +StrInt(0, 0)+zNul;    //grafick· hlaviËka: 0-6
  Result:=(SendData(mS)=zACK);
  If Result then Result:=PrintItmNote(pHead);
end;

function TeKasaSKHand.PrintWithdrawP(pPayNum:longint;pPayName:string;pVal:double):boolean;
// T·to funkcia vytlaËÌ platidl· v˝beru
var mS:string;
begin
  mS := Chr($2E)+StrInt(0,0)+zNul
        +pPayName+zNul               //Popis
        +'1'+zNul                    //Typ oper·cie: 0-vklad/1-v˝ber
        +StrDoub(pVal,0,2)+zNul      //Suma
        +StrInt(pPayNum,0)+zNul;     //»Ìslo platidla
  Result:=(SendData(mS)=zACK);
end;

function TeKasaSKHand.PrintWithdrawF(pFoot:string):boolean;
// T·to funkcia vytlaËÌ p‰tiËku v˝beru
var mS:string;
begin
  Result := FALSE;
  If PrintItmNote (pFoot) then begin
    mS := Chr($22)+StrInt (0, 0)+zNul+'0'+zNul;
    Result:=(SendData(mS,oIdTCPClient.ReadTimeout)=zACK);
  end;
end;

function TeKasaSKHand.PrintICDocH(pDocVal:double;pICDocNum,pCustID:string;pCustIDType:byte;pHead:string):boolean;
// T·to funkcia vytlaËÌ hlaviËku ˙hrady FA
var mCom,mS,mStatus,mVatPrc:string; mCustIDType:byte;
begin
  Result:=FALSE;
  oDocVal:=pDocVal;
  oDocValPay:=0;
  oUID:='';
  mStatus:=GetStatus;
  If (mStatus='2') or (mStatus='3') or (mStatus='4') or (mStatus='10') or (mStatus='20') or (mStatus='32') or (mStatus='34') then CancelDoc;
  oFullDocNum:=GetFullLastReceiptNumber;
  mS := Chr($20)+'0'+zNul
        +'9'+zNul                     //⁄hrada FA
        +'1'+zNul                     //Typ prenosu: riadkov˝/blokov˝
        +'0'+zNul                     //Typ bloËku: kladn˝/z·porn˝
        +'0'+zNul                     //Typ rekapitul·cie: skr·ten·/pln·
        +'0'+zNul;                    //grafick· hlaviËka: 0-6
  Result:=(SendData(mS)=zACK);
  If Result then begin
    mVatPrc:=GetVatSymb (0);
    If pDocVal>0
     then mS := Chr($24)+StrInt (0, 1)+zNul+'1111111'+zNul+StrDoub (Abs(pDocVal),0,2)+zNul+mVatPrc+zNul+'1'+zNul+StrDoub (Abs(pDocVal),0,2)+zNul+'ks'+zNul
     else mS := Chr($28)+StrInt (0, 1)+zNul+'1111111'+zNul+StrDoub (Abs(pDocVal),0,2)+zNul+mVatPrc+zNul+'1'+zNul+StrDoub (Abs(pDocVal),0,2)+zNul+'ks'+zNul+'1'+zNul;
    Result:=(SendData(mS)=zACK);
    If Result then begin
      mS:=Chr($C9)+pICDocNum+zNul;
      Result:=(SendData(mS)=zACK);
      If Result then begin
(*        If (pCustID<>'') then begin
          mCustIDType:=2;
          case pCustIDType of
            cCustIDICO  : mCustIDType:=1;
            cCustIDDIC  : mCustIDType:=2;
            cCustIDICDPH: mCustIDType:=3;
            cCustIDOther: mCustIDType:=4;
          end;
          mS:=Chr($CB)+pCustID+zNul+StrInt(mCustIDType,0)+zNul;
          Result:=(SendData(mS)=zACK);
        end;*)
      end;
      If Result then begin
        If Result and (pHead<>'') then Result := PrintItmNote(pHead);
      end;
    end;
  end;
end;

function TeKasaSKHand.PrintICDocP(pPayNum:longint;pName:string;pVal:double):boolean;
// T·to funkcia vytlaËÌ platidl· ˙hrady FA
var mS:string; mName:string;
begin
  mName:=pName;
  If Length (mName)>10 then mName := Copy (mName,1,10);
  mS := Chr($30)+StrInt (0, 0)+zNul
        +StrInt (pPayNum,0)+zNul
        +StrDoub(oDocVal,0,2)+zNul
        +StrDoub(pVal,0,2)+zNul
        +'0'+zNul
        +mName+zNul;
  Result:=(SendData(mS)=zACK);
end;

function TeKasaSKHand.PrintICDoc(pFoot:string):boolean;
var mS:string; mFullDocNum:string;
begin
  If pFoot<>'' then Result:=PrintDocNote(pFoot);
  If Result then begin
    mS:=Chr($22)+StrInt (0, 0)+zNul+'0'+zNul;     // !!! Zabudovaù ËÌslo grafickej hlaviËky
    Result:=(SendData(mS,oIdTCPClient.ReadTimeout)=zACK);
    If Result  then begin
      mFullDocNum:=GetFullLastReceiptNumber;
      Result:= (mFullDocNum<>oFullDocNum) and (mFullDocNum<>'');
      oUID:=GetUID;
    end;
  end;
end;

function TeKasaSKHand.PrintBlkH(pHead:string;pDocVal:double):boolean;
var mS,mStatus:string;
begin
  Result := FALSE;
  oDocVal:=pDocVal;
  oDocValPay:=0;
  oUID:='';
  mStatus:=GetStatus;
  If (mStatus='2') or (mStatus='3') or (mStatus='4') or (mStatus='10') or (mStatus='20') or (mStatus='32') or (mStatus='34') then CancelDoc;
  oFullDocNum:=GetFullLastReceiptNumber;
  mS := Chr($20)+'0'+zNul
        +'0'+zNul                     //Maloobchod/veækoobchod
        +'1'+zNul                     //Typ prenosu: riadkov˝/blokov˝
        +'0'+zNul                     //Typ bloËku: kladn˝/z·porn˝
        +'0'+zNul                     //Typ rekapitul·cie: skr·ten·/pln·
        +'0'+zNul;               //grafick· hlaviËka: 0-6
  Result:=SendData(mS)=zACK;
  If Result and (pHead<>'') then Result := PrintItmNote(pHead);
end;

function TeKasaSKHand.PrintBlkI(pItmType:byte;pItem,pGsName:string;pPrice,pQnt,pValue:double;pVatPrc:longint;pMs,pDescription,pReferenceReceiptId:string):boolean;
var mVat,mCom,mS,mName:string; mSList:TStringList; mItm:longint;
begin
  mVat:=GetVatSymb (pVatPrc);
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
    If pItmType=cItmTypeDiscount then begin
      mS := Chr($26)+StrInt (0,1)+zNul
      +Copy(pGsName,1,18)+zNul
      +'0'+zNul
      +StrDoub (Abs(pValue),0,2)+zNul
      +mVat+zNul;
    end else begin
      If pItmType=cItmTypeAdvance then begin
        mS := Chr($B3)+Copy(pGsName,1,40)+zNul
        +'1'+zNul
        +mVat+zNul
        +StrDoub (Abs(pValue),0,2)+zNul;
      end else begin
        mItm:=0;
        If pQnt>=0 then begin
          mCom := Chr($24);
        end else begin
          If pItmType=cItmTypeReturnedContainer then begin
            mCom := Chr($2D);
          end else begin
            mCom := Chr($28);
          end;
        end;
        mS := mCom+StrInt (mItm, 1)+zNul
        +mName+zNul
        +StrDoub (Abs(pValue),0,2)+zNul
        +mVat+zNul
        +StripFractZero (StrDoub (Abs(pQnt),0,3))+zNul
        +StrPrice(pPrice)+zNul
        +Copy (pMs,1,3)+zNul;
        If pItmType=cItmTypeReturned then mS:=mS+pReferenceReceiptId+zNul;
      end;
    end;
    Result:=SendData(mS)=zACK;
  end;
  FreeAndNil (mSList);
end;

function TeKasaSKHand.PrintBlkP(pPayNum:longint;pName:string;pVal:double):boolean;
// T·to funkcia vytlaËÌ platidl· ˙hrady pokladniËnÈho dokladu
var mS:string; mName:string;
begin
  mName:=pName;
  If Length (mName)>10 then mName := Copy (mName,1,10);
  mS := Chr($30)+StrInt (0, 0)+zNul
        +StrInt (pPayNum,0)+zNul
        +StrDoub(oDocVal,0,2)+zNul
        +StrDoub(pVal,0,2)+zNul
        +'0'+zNul
        +mName+zNul;
  Result:=(SendData(mS)=zACK);
end;

function TeKasaSKHand.PrintBlk(pFoot:string):boolean;
var mS,mFullDocNum:string;
begin
  Result:=TRUE;
  If pFoot<>'' then Result:=PrintDocNote(pFoot);
  If Result then begin
    mS:=Chr($22)+StrInt (0, 0)+zNul+'0'+zNul;
    Result:=(SendData(mS,oIdTCPClient.ReadTimeout)=zACK);
    If Result  then begin
      mFullDocNum:=GetFullLastReceiptNumber;
      Result:= (mFullDocNum<>oFullDocNum) and (mFullDocNum<>'');
      If Result then begin
        gEcsGlob.DDocNum:=gEcsGlob.DDocNum+1;
        gEcsGlob.eKasaDocNum:=mFullDocNum;
        oUID:=GetUID;
      end;
    end;
  end;
end;

function TeKasaSKHand.PrintIClose:boolean;
var mS,mStatus:string;
begin
  mStatus:=GetStatus;
  If (mStatus='2') or (mStatus='3') or (mStatus='4') or (mStatus='10') or (mStatus='20') or (mStatus='32') or (mStatus='34') then CancelDoc;
  mS := Chr($50)+'X'+zNul+StrInt (1,0)+zNul;
  Result := SendData(mS,oIdTCPClient.ReadTimeout)=zACK;
end;

function TeKasaSKHand.PrintDClose:boolean;
var mS,mStatus:string;
begin
  mStatus:=GetStatus;
  If (mStatus='2') or (mStatus='3') or (mStatus='4') or (mStatus='10') or (mStatus='20') or (mStatus='32') or (mStatus='34') then CancelDoc;
  mS := Chr($50)+'Z'+zNul+StrInt (1,0)+zNul;
  Result := SendData(mS,oIdTCPClient.ReadTimeout)=zACK;
end;

function TeKasaSKHand.ReadDCloseVals:boolean;
var mData, mPayID:string; I,J,mIndex:longint; mTrn:array [1..5] of TValRec;
begin
  Result := FALSE;
  If GetVariabData ('E21', mData) then begin
//    gCasGlobVals.SaleDocQnt:=ValInt (LineElement(mData, 1, ';'));
//Obraty podla sadzby DPH
    For I:=1 to 5 do begin
      mTrn[I].VatPrc:=0;
      mTrn[I].AValue:=0;
      mTrn[I].VatVal:=0;
      mTrn[I].BValue:=0;
      gEcsGlob.BValue[I]:=0;
      gEcsGlob.VatVal[I]:=0;
      gEcsGlob.VatPrc[I]:=uVatPrc[I];
    end;
    For I:=1 to 5 do begin
      If GetVariabData ('13'+StrInt (I,1), mData) then begin
        mTrn[I].BValue:=ValDoub (LineElement (mData, 2, ';'));
        mTrn[I].VatVal:=ValDoub (LineElement (mData, 3, ';'));
        mTrn[I].VatPrc:=ValInt (LineElement (mData, 1, ';'));
        Result := TRUE;
      end else begin
        Result := FALSE;
        Break;
      end;
    end;
    For I:=1 to 5 do begin
      If IsNotNul(mTrn[I].BValue) then begin
        mIndex:=1;
        For J:=5 downto 1 do begin
          If mTrn[I].VatPrc=gEcsGlob.VatPrc[J] then mIndex:=J;
        end;
        gEcsGlob.BValue[mIndex]:=mTrn[I].BValue;
        gEcsGlob.VatVal[mIndex]:=mTrn[I].VatVal;
      end;
    end;

//Platidl·
    If Result then begin
      For I:=0 to 3 do begin
        mPayID := GetPayID(I);
        //Vklad/v˝ber
        If GetVariabData ('1C'+mPayID, mData) then begin
          gEcsGlob.PayVals[I].IncVal:=ValDoub (LineElement (mData, 1, ';'));
          gEcsGlob.PayVals[I].ExpVal:=ValDoub (LineElement (mData, 3, ';'));
          //Stav
          If GetVariabData ('E7'+mPayID, mData) then begin
            gEcsGlob.PayVals[I].TrnVal:=ValDoub (LineElement (mData, 4, ';'));
          end else begin
            Result := FALSE;
            Break;
          end;
        end;
      end;
    end;

    If Result then begin
    // ⁄hrada FA
      If GetVariabData ('171', mData) then begin
        gEcsGlob.ICDocPay:=ValDoub (LineElement (mData, 1, ';'));
        gEcsGlob.ICDocQnt:=ValInt (LineElement (mData, 2, ';'));
      end else Result := FALSE;
    end;

    If Result then begin
     If GetVariabData ('1B2', mData) then begin
       //Storno ?
//       -1*ValDoub (LineElement (mData, 1, ';'));
//       ValInt (LineElement (mData, 2, ';'));
       //Vt·tenie
       gEcsGlob.ClmVal:=ValDoub (LineElement (mData, 3, ';'));
       gEcsGlob.ClmItmQnt:=ValInt (LineElement (mData, 4, ';'));
     end else Result := FALSE;
    end;

    If Result then begin
     //Z·pornÈ poloûky
     If GetVariabData ('1D2', mData) then begin
       gEcsGlob.NegVal:=ValDoub (LineElement (mData, 1, ';'));
       gEcsGlob.NegItmQnt:=ValInt (LineElement (mData, 2, ';'));
     end else Result := FALSE;
    end;

    If Result then begin
     //Zæavy
     If GetVariabData ('1A2', mData) then begin
       gEcsGlob.DscVal := ValDoub (LineElement (mData, 3, ';'));
       gEcsGlob.DscItmQnt := ValInt (LineElement (mData, 4, ';'));
     end else Result := FALSE;
    end;

(*    If Result then begin
     //PoËet dokladov - vklad/v˝ber
     If GetVariabData ('1CH', mData) then begin
       gCasGlobVals.IncDocQnt:=0;
       gCasGlobVals.DecDocQnt:=ValInt (LineElement (mData, 1, ';'));
     end else Result := FALSE;
    end;*)

  end;
end;

function TeKasaSKHand.GetDCloseNum:longint;
var mData:string;
begin
  Result := -1;
  If GetVariabData ('E11', mData) then begin
    Result := ValInt (LineElement (mData, 1, ';'));
  end;
end;

function TeKasaSKHand.GetPayID(pCode:longint):string;
begin
  If pCode=0 then pCode:=16;
  Result := 'G';
  If (pCode>0) and (pCode<10) then Result := StrInt (pCode, 0);
  If (pCode>=10) and (pCode<=16) then Result := Chr (65+pCode-10);
end;

function TeKasaSKHand.PrintLastBlock:boolean;
var mS:string;
begin
  mS := Chr($2A);
  Result := (SendData(mS)=zACK);
end;

//  <<<<< TeKasaSKHand <<<<<

//  >>>>> TeKasaHnd >>>>>
constructor TeKasaHnd.Create(pPPEKKType:byte;pHost:string;pPort,pConnectTimeout,pReadTimeout:longint;pWriteToLog:boolean);
var I:longint;
begin
  uWriteToLog:=pWriteToLog;
  oPPEKKType:=pPPEKKType;
  case oPPEKKType of
    1: oPortos:=TePortosHand.Create(pHost,pPort,pConnectTimeout,pReadTimeout);
    2: oeKasaSK:=TeKasaSKHand.Create(pHost,pPort,pConnectTimeout,pReadTimeout);
  end;

  oCopies := 1;
  oExtHeadUse:=FALSE;
  oIntHeadUse:=FALSE;
  oVarFootUse:=FALSE;
  oFixFootUse:=FALSE;
  oFullBlk:=TStringList.Create;

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
  oRefDocNum  := '';

  oErrCod:=0;
  oErrDes:='';
end;

destructor TeKasaHnd.Destroy;
begin
  FreeAndNil (oFullBlk);
  If oBlockHead<>nil then FreeAndNil (oBlockHead);
  If oBlockItem<>nil then FreeAndNil (oBlockItem);
  If oSumFoot<>nil then FreeAndNil (oSumFoot);
  If oInfoFoot<>nil then FreeAndNil (oInfoFoot);
  If oItmData<>nil then FreeAndNil (oItmData);
  If oExtHead<>nil then FreeAndNil (oExtHead);
  If oIntHead<>nil then FreeAndNil (oIntHead);
  If oVarFoot<>nil then FreeAndNil (oVarFoot);
  If oFixFoot<>nil then FreeAndNil (oFixFoot);
  If oPortos<>nil then FreeAndNil (oPortos);
  If oeKasaSK<>nil then FreeAndNil (oeKasaSK);
  inherited;
end;

procedure TeKasaHnd.ReadRepFile;
var mSList:TStringList; I:longint; mID,mLn:string;
begin
  ClearFlds;
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
            If mID='SF' then ReadSumFoot (mLn);
            If mID='VF' then ReadVarFootUse;
            If mID='IF' then ReadInfoFoot (mLn);
            If mID='FF' then ReadFixFootUse;
          end;
        end;
      end;
    end;
    FreeAndNil (mSList);
  end;
end;

procedure TeKasaHnd.ReadRepName (pLn:string);
begin
  oRepName  := pLn;
end;

procedure TeKasaHnd.ReadExtHeadUse;
begin
  oExtHeadUse := TRUE;
end;

procedure TeKasaHnd.ReadIntHeadUse;
begin
  oIntHeadUse := TRUE;
end;

procedure TeKasaHnd.ReadBlockHead (pLn:string);
begin
  If oBlockHead=nil then oBlockHead := TStringList.Create;
  oBlockHead.Add(pLn);
end;

procedure TeKasaHnd.ReadBlockItem (pLn:string);
begin
  If oBlockItem=nil then oBlockItem := TStringList.Create;
  oBlockItem.Add(pLn);
end;

procedure TeKasaHnd.ReadSumFoot (pLn:string);
begin
  If oSumFoot=nil then oSumFoot := TStringList.Create;
  oSumFoot.Add(pLn);
end;

procedure TeKasaHnd.ReadVarFootUse;
begin
  oVarFootUse := TRUE;
end;

procedure TeKasaHnd.ReadInfoFoot (pLn:string);
begin
  If oInfoFoot=nil then oInfoFoot := TStringList.Create;
  oInfoFoot.Add(pLn);
end;

procedure TeKasaHnd.ReadFixFootUse;
begin
  oFixFootUse := TRUE;
end;

procedure TeKasaHnd.AddBlkText(pText:string);
begin
  oFullBlk.Text := oFullBlk.Text+pText;
end;

function TeKasaHnd.FindFldID (pID:string;var pPos:longint):boolean;
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

function TeKasaHnd.GetFldID (pID:string;var pPos:longint):boolean;
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

function  TeKasaHnd.FillAllFld (pStr:string):string;
begin
  FillStandFld (pStr);
  FillSpecFld (pStr);
  FillVarLenFld (pStr);
  Result := DelHiddenLn (pStr);
end;

procedure TeKasaHnd.FillStandFld (var pStr:string);
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

procedure TeKasaHnd.FillSpecFld (var pStr:string);
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

procedure TeKasaHnd.FillVarLenFld (var pStr:string);
var mBeg,mLen,mFrac,mItm:longint; mID:string; mFind:boolean;
begin
  While Pos ('§',pStr)>0 do begin
    mBeg := Pos ('§',pStr); mLen := 0;
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

procedure TeKasaHnd.ScanFldParam (pBeg:longint;pStr,pID:string;pVarFld:boolean;var pLen,pFrac:longint);
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

procedure TeKasaHnd.ChangeVal (pHide:boolean;pBeg,pLen,pFrac,pItm:longint;var pStr:string);
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
  If mHideLn then mS := '∂∂∂∂∂';
  Delete (pStr,pBeg,pLen);
  Insert (mS,pStr,pBeg);
end;

function TeKasaHnd.DelHiddenLn (pStr:string):string;
var mSList:TStringList; mCnt:longint;
begin
  mSList := TStringList.Create;
  mSList.Text := pStr;
  If mSList.Count>0 then begin
    mCnt := 0;
    Repeat
      If Pos ('∂∂∂∂∂',mSList.Strings[mCnt])>0
        then mSList.Delete(mCnt)
        else Inc (mCnt);
    until mCnt>mSList.Count-1;
  end;
  Result := mSList.Text;
  FreeAndNil(mSList);
end;

procedure TeKasaHnd.PrintHead;
var mHead,mIntHead,mExtHead:string;
begin
  mHead:=''; mIntHead:=''; mExtHead:='';
  If oBlockHead<>nil then mHead:=FillAllFld(oBlockHead.Text);
  If oIntHeadUse and (oIntHead<>nil) then mIntHead:=oIntHead.Text;
  If oExtHeadUse and (oExtHead<>nil) then mExtHead:=oExtHead.Text;
  If mExtHead<>'' then AddBlkText(mExtHead);
  If mIntHead<>'' then AddBlkText(mIntHead);
  If mHead<>'' then AddBlkText(mHead);
end;

procedure TeKasaHnd.PrintItem;
var mItem:string;
begin
  mItem := '';
  If oBlockItem<>nil then mItem:=FillAllFld(oBlockItem.Text);
  If mItem<>'' then AddBlkText(mItem);
end;

function TeKasaHnd.PrintFoot (pDocType:string):boolean;
var mPath, mFile, mFoot, mS:string; mErr, I, mOutNum:longint;
begin
  Result := FALSE;
  mFoot := '';
  If oSumFoot<>nil then mFoot:=FillAllFld(oSumFoot.Text);
  If mFoot<>'' then AddBlkText(mFoot);
  case oPPEKKType of
    0: Result:=TRUE;
    1: begin
          Result:=TRUE;
          For I:=1 to oCopies do begin
            If Result then Result := oPortos.PrintText (oFullBlk.Text,FALSE);
          end;
         If Result then SaveToCFile(oFullBlk.Text,geKasaPath,cCasNum,gEcsGlob.IntDocNum,gBlkHead.BlkDate,gBlkHead.BlkTime,pDocType,'');
        end;
    2: begin
          Result:=TRUE;
          For I:=1 to oCopies do begin
            If Result then Result := oeKasaSK.PrintText (oFullBlk.Text);
          end;
         If Result then SaveToCFile(oFullBlk.Text,geKasaPath,cCasNum,gEcsGlob.IntDocNum,gBlkHead.BlkDate,gBlkHead.BlkTime,pDocType,'');
        end;
  end;
end;

procedure TeKasaHnd.ClearFlds;
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

procedure TeKasaHnd.SetStrFld (pID,pVal:string);
var mPos:longint;
begin
  If GetFldID (pID,mPos) then begin
    oFldData[mPos].ID := pID;
    oFldData[mPos].Str := pVal;
    oFldData[mPos].Typ := 0;
  end;
end;

procedure TeKasaHnd.SetIntFld (pID:string;pVal:longint);
var mPos:longint;
begin
  If GetFldID (pID,mPos) then begin
    oFldData[mPos].ID := pID;
    oFldData[mPos].Num := pVal;
    oFldData[mPos].Typ := 1;
  end;
end;

procedure TeKasaHnd.SetDoubFld (pID:string;pVal:double);
var mPos:longint;
begin
  If GetFldID (pID,mPos) then begin
    oFldData[mPos].ID := pID;
    oFldData[mPos].Num := pVal;
    oFldData[mPos].Typ := 2;
  end;
end;

procedure TeKasaHnd.SetSpecDoubFld (pID:string;pVal:double);
var mPos:longint;
begin
  If GetFldID (pID,mPos) then begin
    oFldData[mPos].ID := pID;
    oFldData[mPos].Num := pVal;
    oFldData[mPos].Typ := 3;
  end;
end;

procedure TeKasaHnd.SetDateFld (pID:string;pVal:TDateTime);
var mPos:longint;
begin
  If GetFldID (pID,mPos) then begin
    oFldData[mPos].ID := pID;
    oFldData[mPos].Num := pVal;
    oFldData[mPos].Typ := 4;
  end;
end;

procedure TeKasaHnd.SetTimeFld (pID:string;pVal:TDateTime);
var mPos:longint;
begin
  If GetFldID (pID,mPos) then begin
    oFldData[mPos].ID := pID;
    oFldData[mPos].Num := pVal;
    oFldData[mPos].Typ := 5;
  end;
end;

procedure TeKasaHnd.SetExtHead (pS:string);
begin
  If oExtHead=nil then oExtHead := TStringList.Create;
  oExtHead.Add (pS);
end;

procedure TeKasaHnd.SetIntHead (pS:string);
begin
  If oIntHead=nil then oIntHead := TStringList.Create;
  oIntHead.Add (pS);
end;

procedure TeKasaHnd.SetVarFoot (pS:string);
begin
  If oVarFoot=nil then oVarFoot := TStringList.Create;
  oVarFoot.Add (pS);
end;

procedure TeKasaHnd.SetFixFoot (pS:string);
begin
  If oFixFoot=nil then oFixFoot := TStringList.Create;
  oFixFoot.Add (pS);
end;

procedure TeKasaHnd.SetPriceFld (pID:string;pVal:double);
begin
  SetDoubFld (pID,pVal);
  oPrice := pVal;
end;

procedure TeKasaHnd.SetQntFld (pID:string;pVal:double);
begin
  SetSpecDoubFld (pID,pVal);
  oQnt := pVal;
end;

procedure TeKasaHnd.SetItmValFld (pID:string;pVal:double);
begin
  SetDoubFld (pID,pVal);
  oItmVal := pVal;
end;

procedure TeKasaHnd.SetVatPrcFld (pID:string;pVal:longint);
begin
  SetDoubFld (pID,pVal);
  oVatPrc := pVal;
end;

procedure TeKasaHnd.SetNegItmTypeFld (pID:string;pVal:string);
begin
  SetStrFld (pID,pVal);
  oNegItmType := pVal;
end;

procedure TeKasaHnd.SetGsNameFld (pID:string;pVal:string);
begin
  SetStrFld (pID,pVal);
  oGsNameID := pID;
  oGsName := ReplaceStr(pVal,'"',' ');
end;

procedure TeKasaHnd.SetMsNameFld (pID:string;pVal:string);
begin
  SetStrFld (pID,pVal);
  oMsNameID := pID;
  oMsName := pVal;
end;

procedure TeKasaHnd.SetDocValFld (pID:string;pVal:double);
begin
  SetDoubFld (pID,pVal);
  oDocVal := pVal;
end;

procedure TeKasaHnd.SetRefDocNum (pRefDocNum:string);
begin
  oRefDocNum:=pRefDocNum;
end;

function TeKasaHnd.LoadEcdFile(pEcdFile:string):boolean;
// T·to funkcia naËÌta ˙daje z ECD s˙boru do glob·lnych premenn˝ch
var mR:TECDLoad;
begin
  oErrCod:=0;
  oErrDes:='';
  mR:=TECDLoad.Create;
  Result:=mR.LoadDoc(gEcdPath,pEcdFile);
  If not Result then begin
    oErrCod:=mR.ErrCod;
    oErrDes:=mR.ErrDes;
  end;
  FreeAndNil(mR);
end;

procedure TeKasaHnd.FillBlkHead;
var I:longint;
begin
  gBlkHead.BlkDate:=Date;
  gBlkHead.BlkTime:=Time;
  SetDateFld ('1', gBlkHead.BlkDate);
  SetTimeFld ('2', gBlkHead.BlkTime);
  SetIntFld ('3', cCasNum);
  SetIntFld ('4', gEcsGlob.IntDocNum);
  SetStrFld ('5', StrIntZero(cCasNum, 3)+StrIntZero(gEcsGlob.IntDocNum, 7));

  SetStrFld ('a', gBlkHead.PaName);
  SetStrFld ('b', gBlkHead.PaINO);
  SetStrFld ('c', gBlkHead.PaTIN);
  SetStrFld ('d', gBlkHead.PaVIN);
  SetStrFld ('e', gBlkHead.CusCardNum);
  SetStrFld ('f', gBlkHead.CusName);
  SetStrFld ('z', gBlkHead.IntDocNum);
  SetStrFld ('Z', gBlkHead.ExtDocNum);
  SetIntHead (cIntHead);
  If uNoteQnt>0 then begin
    For I:=1 to uNoteQnt do
      SetVarFoot(uNoteLst[I]);
  end;
  SetFixFoot(cFixFoot);
end;

procedure TeKasaHnd.FillBlkItem(pNum:longint);
begin
  SetIntFld ('A', gBlkItems[pNum].GsCode);
  SetIntFld ('B', gBlkItems[pNum].MgCode);
  SetIntFld ('C', gBlkItems[pNum].FgCode);
  SetStrFld ('D', gBlkItems[pNum].BarCode);
  SetStrFld ('E', gBlkItems[pNum].StkCode);
  SetStrFld ('F', gBlkItems[pNum].OsdCode);
  SetGsNameFld ('G', gBlkItems[pNum].GsName);
  SetVatPrcFld ('H', gBlkItems[pNum].VatPrc);
  SetQntFld ('I', gBlkItems[pNum].Qnt);
  SetMsNameFld ('J', gBlkItems[pNum].MsName);
  SetPriceFld ('K', gBlkItems[pNum].FBPrice);
  SetItmValFld ('L', gBlkItems[pNum].FBValue);
  SetDoubFld ('M', gBlkItems[pNum].DscPrc);
  SetDoubFld ('N', gBlkItems[pNum].DscBVal);
  SetNegItmTypeFld ('O', gBlkItems[pNum].NegType);
  SetRefDocNum(gBlkItems[pNum].RefID);
end;

procedure TeKasaHnd.FillBlkDscItem(pNum:longint);
begin
  SetIntFld ('A', gBlkItems[pNum].GsCode);
  SetIntFld ('B', gBlkItems[pNum].MgCode);
  SetIntFld ('C', gBlkItems[pNum].FgCode);
  SetStrFld ('D', gBlkItems[pNum].BarCode);
  SetStrFld ('E', gBlkItems[pNum].StkCode);
  SetStrFld ('F', gBlkItems[pNum].OsdCode);
  SetGsNameFld ('G', 'Zæava '+gBlkItems[pNum].GsName);
  SetVatPrcFld ('H', gBlkItems[pNum].VatPrc);
  SetQntFld ('I', -1);
  SetMsNameFld ('J', '');
  SetPriceFld ('K', -1*gBlkItems[pNum].DscBVal);
  SetItmValFld ('L', -1*gBlkItems[pNum].DscBVal);
  SetDoubFld ('M', 0);
  SetDoubFld ('N', 0);
  SetNegItmTypeFld ('O', 'D');
  SetRefDocNum('');
end;

function TeKasaHnd.PrintDocHead:boolean;
var mHead:string; I:longint;
begin
  Result:=FALSE;
  case oPPEKKType of
    0: Result:=TRUE;
    1: begin
         mHead:='';
         If oExtHeadUse and (oExtHead<>nil) then mHead:=mHead+oExtHead.Text;
         If oIntHeadUse and (oIntHead<>nil) then mHead:=mHead+oIntHead.Text;
         Result:=oPortos.SetBlkH(mHead);
       end;
    2: begin
         mHead:='';
         If oBlockHead<>nil then mHead:=mHead+oBlockHead.Text;
         Result:=oeKasaSK.PrintBlkH(mHead,gBlkHead.BValue);
       end;
  end;
end;

function TeKasaHnd.PrintDocItem(pItmNum:longint):boolean;
var mS,mName:string; mItmType:byte;
begin
  Result:=FALSE;
  mName:=FillAllFld(oBlockItem.Text);
  mItmType:=cItmTypePositive;
  If gBlkItems[pItmNum].Qnt<0 then begin
    mItmType:=cItmTypeReturned;
    If gBlkItems[pItmNum].NegType='D' then mItmType:=cItmTypeDiscount;
    If gBlkItems[pItmNum].NegType='A' then mItmType:=cItmTypeAdvance;
    If gBlkItems[pItmNum].NegType='N' then mItmType:=cItmTypeDiscount;
    If (mItmType=cItmTypeReturned) and (gBlkItems[pItmNum].RefID='') then gBlkItems[pItmNum].RefID:='1';
  end;
  case oPPEKKType of
    0: Result:=TRUE;
    1: begin
         Result:=oPortos.SetBlkI(mItmType,mName,gBlkItems[pItmNum].FBPrice,gBlkItems[pItmNum].Qnt,gBlkItems[pItmNum].FBValue,gBlkItems[pItmNum].VatPrc,gBlkItems[pItmNum].MsName,'',gBlkItems[pItmNum].RefID);
         AddBlkText(mName);
         mS:=AlignLeft(StripFractZero(StrDoub(gBlkItems[pItmNum].Qnt,0,3)),9)+' '+AlignRight(gBlkItems[pItmNum].MsName,3)+' x '+AlignRight(StrPrice(gBlkItems[pItmNum].FBPrice),9)+'= '+AlignRight(StrDoub(gBlkItems[pItmNum].FBValue,0,2),9)+StrInt(gBlkItems[pItmNum].VatPrc,3)+'%';
         AddBlkText(mS);
       end;
    2: begin
         Result:=oeKasaSK.PrintBlkI(mItmType,mName,gBlkItems[pItmNum].GsName,gBlkItems[pItmNum].FBPrice,gBlkItems[pItmNum].Qnt,gBlkItems[pItmNum].FBValue,gBlkItems[pItmNum].VatPrc,gBlkItems[pItmNum].MsName,'',gBlkItems[pItmNum].RefID);
       end;
  end;
end;

function TeKasaHnd.PrintDocPay:boolean;
var I,mNum:longint;
begin
  Result:=FALSE;
  gBlkHead.PayVal:=0;
  gBlkHead.RndVal:=0;
  case oPPEKKType of
    0: Result:=TRUE;
    1: begin
         For I:=0 to 9 do begin
           If IsNotNul(uPaysTbl[I]) then begin
             oPortos.SetBlkP(gEcsGlob.PayVals[I].Name,uPaysTbl[I]);
             gBlkHead.PayVal:=gBlkHead.PayVal+Rd2(uPaysTbl[I]);
           end;
         end;
         gBlkHead.RndVal:=Rd2(gBlkHead.PayVal-gBlkHead.BValue);
         Result:=TRUE;
       end;
    2: begin
         For I:=0 to 9 do begin
           mNum:=I;
           If mNum=0 then mNum:=16;
           If IsNotNul(uPaysTbl[I]) then begin
             Result:=oeKasaSK.PrintBlkP(mNum,gEcsGlob.PayVals[I].Name,uPaysTbl[I]);
             gBlkHead.PayVal:=gBlkHead.PayVal+Rd2(uPaysTbl[I]);
           end;
         end;
         gBlkHead.RndVal:=Rd2(gBlkHead.PayVal-gBlkHead.BValue);
       end;
  end;
end;

function TeKasaHnd.PrintDocFoot:boolean;
var mFoot:string; I:longint;
begin
  Result:=FALSE;
  mFoot:='';
  If oVarFootUse and (oVarFoot<>nil) then mFoot:=mFoot+FillAllFld(oVarFoot.Text);
  If (oInfoFoot<>nil) then mFoot:=mFoot+FillAllFld(oInfoFoot.Text);
  If oFixFootUse and (oFixFoot<>nil) then mFoot:=mFoot+FillAllFld(oFixFoot.Text);
  case oPPEKKType of
    0: Result:=TRUE;
    1: begin
         Result:=oPortos.PrintBlk(gBlkHead.BValue,mFoot);
         If Result then begin
           gBlkHead.UID:=oPortos.UID;
           gEcsGlob.DDocNum:=oPortos.GetLastReceiptNumber;
           gEcsGlob.eKasaDocNum:=oPortos.GetFullLastReceiptNumber;
           oFullBlk.Text:=GetDocText;
         end;
       end;
    2: begin
         Result:=oeKasaSK.PrintBlk(mFoot);
         gBlkHead.UID:=oeKasaSK.UID;
         gEcsGlob.DDocNum:=oeKasaSK.GetDailyReceiptNumber;
         gEcsGlob.eKasaDocNum:=oeKasaSK.GetFullLastReceiptNumber;
         If Result then begin
           oFullBlk.Text:=oeKasaSK.ReadLastDoc;
         end;
       end;
  end;
end;

procedure TeKasaHnd.FillICBlkHead;
var I:longint;
begin
  gBlkHead.BlkDate:=Date;
  gBlkHead.BlkTime:=Time;
  SetDateFld ('1', gBlkHead.BlkDate);
  SetTimeFld ('2', gBlkHead.BlkTime);
  SetIntFld ('3', cCasNum);
  SetIntFld ('4', gEcsGlob.IntDocNum);
  SetStrFld ('5', StrIntZero(cCasNum, 3)+StrIntZero(gEcsGlob.IntDocNum, 7));

  SetStrFld ('a', gBlkHead.PaName);
  SetStrFld ('b', gBlkHead.PaINO);
  SetStrFld ('c', gBlkHead.PaTIN);
  SetStrFld ('d', gBlkHead.PaVIN);
  SetDoubFld ('e', gBlkHead.BValue);
  SetStrFld ('A', gBlkHead.ExtDocNum);
  SetDoubFld ('B', gBlkHead.BValue);
  SetStrFld ('C', gBlkHead.IntDocNum);
  SetIntHead (cIntHead);
  If uNoteQnt>0 then begin
    For I:=1 to uNoteQnt do
      SetVarFoot(uNoteLst[I]);
  end;
  SetFixFoot(cFixFoot);
end;

function TeKasaHnd.PrintICDocHead:boolean;
var mHead:string; I:longint;
begin
  Result:=FALSE;
  case oPPEKKType of
    0: Result:=TRUE;
    1: begin
         mHead:='';
         If oExtHeadUse and (oExtHead<>nil) then mHead:=mHead+oExtHead.Text;
         If oIntHeadUse and (oIntHead<>nil) then mHead:=mHead+oIntHead.Text;
         Result:=oPortos.SetBlkH(mHead);
       end;
    2: begin
         mHead:='';
         If oBlockHead<>nil then mHead:=mHead+oBlockHead.Text;
         Result:=oeKasaSK.PrintICDocH(gBlkHead.BValue,gBlkHead.ExtDocNum,gBlkHead.PaTIN,cCustIDDIC,mHead);
       end;
  end;
end;

function TeKasaHnd.PrintICDocPay:boolean;
var I,mNum:longint;
begin
  Result:=FALSE;
  case oPPEKKType of
    0: Result:=TRUE;
    1: begin
         For I:=0 to 9 do begin
           If IsNotNul(uPaysTbl[I]) then oPortos.SetICDocP(gEcsGlob.PayVals[I].Name,uPaysTbl[I]);
         end;
         Result:=TRUE;
       end;
    2: begin
         For I:=0 to 9 do begin
           mNum:=I;
           If mNum=0 then mNum:=16;
           If IsNotNul(uPaysTbl[I]) then Result:=oeKasaSK.PrintICDocP(mNum,gEcsGlob.PayVals[I].Name,uPaysTbl[I]);
         end;
       end;
  end;
end;

function TeKasaHnd.PrintICDocFoot:boolean;
var mFoot:string; I:longint;
begin
  Result:=FALSE;
  mFoot:='';
  If oVarFootUse and (oVarFoot<>nil) then mFoot:=mFoot+FillAllFld(oVarFoot.Text);
  If (oInfoFoot<>nil) then mFoot:=mFoot+FillAllFld(oInfoFoot.Text);
  If oFixFootUse and (oFixFoot<>nil) then mFoot:=mFoot+FillAllFld(oFixFoot.Text);
  case oPPEKKType of
    0: Result:=TRUE;
    1: begin
         Result:=oPortos.PrintICDoc(gBlkHead.BValue,gBlkHead.ExtDocNum,gBlkHead.PaTIN,cCustIDDIC,mFoot);
         If Result then begin
          gBlkHead.UID:=oPortos.UID;
          gEcsGlob.DDocNum:=oPortos.GetLastReceiptNumber;
          gEcsGlob.eKasaDocNum:=oPortos.GetFullLastReceiptNumber;
          oFullBlk.Text:=GetDocText;
         end;
       end;
    2: begin
         Result:=oeKasaSK.PrintICDoc(mFoot);
         gBlkHead.UID:=oeKasaSK.UID;
         gEcsGlob.DDocNum:=oeKasaSK.GetDailyReceiptNumber;
         gEcsGlob.eKasaDocNum:=oeKasaSK.GetFullLastReceiptNumber;
         If Result then begin
           oFullBlk.Text:=oeKasaSK.ReadLastDoc;
         end;
       end;
  end;
end;

function TeKasaHnd.GetDocText:string;
var mSLst:TStringList; I:longint; mS,mSepar:string;
begin
  mSLst:=TStringList.Create;
  If oExtHeadUse and (oExtHead<>nil) and (oExtHead.Count>0) then begin
    For I:=0 to oExtHead.Count-1 do
      mSLst.Add(oExtHead.Strings[I]);
  end;
  If oIntHeadUse and (oExtHead<>nil) and (oIntHead.Count>0) then begin
    For I:=0 to oIntHead.Count-1 do
      mSLst.Add(oIntHead.Strings[I]);
  end;
  mS:='KP: '+geKasaInfo.CashRegisterCode;
  mSLst.Add(mS);
  mS:='Doklad: '+StrInt(gEcsGlob.DDocNum,5)+' D·tum: '+FormatDateTime('dd.mm.yyyy hh:nn:ss',gBlkHead.BlkDate+gBlkHead.BlkTime);
  mSLst.Add(mS);
  If (oBlockHead<>nil) and (oBlockHead.Count>0) then begin
    For I:=0 to oBlockHead.Count-1 do
      mSLst.Add(oBlockHead.Strings[I]);
  end;
  If (oFullBlk<>nil) and (oFullBlk.Count>0) then begin
    For I:=0 to oFullBlk.Count-1 do
      mSLst.Add(oFullBlk.Strings[I]);
  end;
  mSepar:='----------------------------------------';
  mS:='                         Suma: '+StrDoub(gBlkHead.BValue,0,2)+' EUR';
  mSLst.Add(mSepar);
  mSLst.Add(mS);
  mSLst.Add(mSepar);
  For I:=0 to 9 do begin
    If IsNotNul(uPaysTbl[I]) then begin
      mS:=AlignRight(gEcsGlob.PayVals[I].Name,30)+StrDoub(uPaysTbl[I],10,2);
      mSLst.Add(mS);
    end;
  end;
  mSLst.Add('');

  If (oSumFoot<>nil) and (oSumFoot.Count>0) then begin
    For I:=0 to oSumFoot.Count-1 do
      mSLst.Add(oSumFoot.Strings[I]);
  end;
  If oVarFootUse and (oVarFoot<>nil) and (oVarFoot.Count>0) then begin
    For I:=0 to oVarFoot.Count-1 do
      mSLst.Add(oVarFoot.Strings[I]);
  end;
  If (oInfoFoot<>nil) and (oInfoFoot.Count>0) then begin
    For I:=0 to oInfoFoot.Count-1 do
      mSLst.Add(oInfoFoot.Strings[I]);
  end;
  If oFixFootUse and (oFixFoot<>nil) and (oFixFoot.Count>0) then begin
    For I:=0 to oFixFoot.Count-1 do
      mSLst.Add(oFixFoot.Strings[I]);
  end;
  mSLst.Add('UID:'+gBlkHead.UID);
  Result:=FillAllFld(mSLst.Text);
  FreeAndNil(mSLst);
end;

procedure TeKasaHnd.InitTFile;
var mR:TTFileGlobFill; mFileName:string; mA:TTFileHnd;
begin
  mR:=TTFileGlobFill.Create;
  mR.FillGlobValues(Date,cCasNum,geKasaPath);
  FreeAndNil(mR);
  mFileName:=geKasaPath+GetTFileName(Date,cCasNum);
  If not FileExists(mFileName) then begin
    mA:=TTFileHnd.Create;
    FreeAndNil(mA);
  end;
end;


procedure TeKasaHnd.SaveTDoc;
var mR:TTFileHnd;
begin
  mR:=TTFileHnd.Create;
  mR.SaveSalDoc;
  FreeAndNil(mR);
end;

procedure TeKasaHnd.SaveTICDoc;
var mR:TTFileHnd;
begin
  mR:=TTFileHnd.Create;
  mR.SaveICDocPay;
  FreeAndNil(mR);
end;

procedure TeKasaHnd.SaveRepDoc;
var mR:TTFileHnd;
begin
  mR:=TTFileHnd.Create;
  mR.SaveRepDoc;
  FreeAndNil(mR);
end;

procedure TeKasaHnd.SaveIncDoc;
var mR:TTFileHnd;
begin
  mR:=TTFileHnd.Create;
  mR.SaveIncDoc;
  FreeAndNil(mR);
end;

procedure TeKasaHnd.SaveExpDoc;
var mR:TTFileHnd;
begin
  mR:=TTFileHnd.Create;
  mR.SaveExpDoc;
  FreeAndNil(mR);
end;

function TeKasaHnd.PrintInfoClsT:boolean;
var mTrnSum, mExpSum, mIncSum, mTrn:double; I:longint;
begin
  gBlkHead.BlkDate := Date;
  gBlkHead.BlkTime := Time;
  If Initialize then begin
    If GetPrnState then begin
      oRepMask:=gPath.RepPath+'ecs_acls.r'+StrIntZero(1,2);
      If FileExists(oRepMask) then begin
        InitTFile;
        ReadRepFile;
        SetIntHead(cIntHead);
        SetDateFld('1',gBlkHead.BlkDate);
        SetTimeFld('2',gBlkHead.BlkTime);
        SetIntFld('3',cCasNum);
        SetIntFld('4',gEcsGlob.IntDocNum);
        SetStrFld('5',StrIntZero(cCasNum, 3)+StrIntZero(gEcsGlob.IntDocNum, 7));
        SetStrFld('6',geKasaInfo.CashRegisterCode);

        SetIntFld('E',gEcsGlob.VatPrc[1]);
        SetDoubFld('F',gEcsGlob.AValue[1]);
        SetDoubFld('G',gEcsGlob.VatVal[1]);
        SetDoubFld('H',gEcsGlob.BValue[1]);
        SetIntFld('I',gEcsGlob.VatPrc[2]);
        SetDoubFld('J',gEcsGlob.AValue[2]);
        SetDoubFld('K',gEcsGlob.VatVal[2]);
        SetDoubFld('L',gEcsGlob.BValue[2]);
        SetIntFld('M',gEcsGlob.VatPrc[3]);
        SetDoubFld('N',gEcsGlob.AValue[3]);
        SetDoubFld('O',gEcsGlob.VatVal[3]);
        SetDoubFld('P',gEcsGlob.BValue[3]);
        SetIntFld('¡',gEcsGlob.VatPrc[4]);
        SetDoubFld('…',gEcsGlob.AValue[4]);
        SetDoubFld('Õ',gEcsGlob.VatVal[4]);
        SetDoubFld('”',gEcsGlob.BValue[4]);

        SetDoubFld('Q',gEcsGlob.AValue[1]+gEcsGlob.AValue[2]+gEcsGlob.AValue[3]+gEcsGlob.AValue[4]+gEcsGlob.ICDocPay);
        SetDoubFld('R',gEcsGlob.VatVal[1]+gEcsGlob.VatVal[2]+gEcsGlob.VatVal[3]+gEcsGlob.VatVal[4]);
        SetDoubFld('S',gEcsGlob.BValue[1]+gEcsGlob.BValue[2]+gEcsGlob.BValue[3]+gEcsGlob.BValue[4]+gEcsGlob.ICDocPay);

        SetStrFld('o', gEcsGlob.PayVals[0].Name);
        SetStrFld('p', gEcsGlob.PayVals[1].Name);
        SetStrFld('q', gEcsGlob.PayVals[2].Name);
        SetStrFld('r', gEcsGlob.PayVals[3].Name);
        SetStrFld('s', gEcsGlob.PayVals[4].Name);
        SetStrFld('t', gEcsGlob.PayVals[5].Name);
        SetStrFld('u', gEcsGlob.PayVals[6].Name);
        SetStrFld('v', gEcsGlob.PayVals[7].Name);
        SetStrFld('w', gEcsGlob.PayVals[8].Name);
        SetStrFld('x', gEcsGlob.PayVals[9].Name);

        SetIntFld('T', gEcsGlob.SalDocQnt);
        SetIntFld('U', gEcsGlob.ICDocQnt);
        SetIntFld('V', gEcsGlob.IncDocQnt);
        SetIntFld('W', gEcsGlob.DecDocQnt);

        SetDoubFld('X', gEcsGlob.RndH);
        SetDoubFld('Y', gEcsGlob.RndI_P+gEcsGlob.RndI_N);

        SetIntFld('e', gEcsGlob.DscItmQnt);
        SetIntFld('f', gEcsGlob.ClmItmQnt);
        SetIntFld('g', gEcsGlob.AdvItmQnt);
        SetIntFld('h', gEcsGlob.NegItmQnt);

        SetDoubFld('i', gEcsGlob.DscVal);
        SetDoubFld('j', gEcsGlob.ClmVal);
        SetDoubFld('k', gEcsGlob.AdvVal);
        SetDoubFld('l', gEcsGlob.NegVal);
        SetDoubFld('m', gEcsGlob.ICDocPay);

        PrintHead;
        mTrnSum := 0; mExpSum := 0; mIncSum := 0; mTrn := 0;
        For I:=0 to 9 do begin
          mTrn := gEcsGlob.PayVals[I].TrnVal+gEcsGlob.PayVals[I].ChIVal-gEcsGlob.PayVals[I].ChOVal;
          mTrnSum:=Roundx(mTrnSum+mTrn,4);
          mExpSum:=Roundx(mExpSum+gEcsGlob.PayVals[I].ExpVal,4);
          mIncSum:=Roundx(mIncSum+gEcsGlob.PayVals[I].IncVal,4);
          If gEcsGlob.PayVals[I].Name=''
            then SetStrFld('A', '')
           else SetStrFld('A', StrInt (I,0));
          SetDoubFld('B', gEcsGlob.PayVals[I].IncVal);
          SetDoubFld('C', gEcsGlob.PayVals[I].ExpVal);
          SetDoubFld('D', mTrn);
          PrintItem;
        end;
      end;
      SetDoubFld('b',mIncSum);
      SetDoubFld('c',mExpSum);
      SetDoubFld('d',mTrnSum);
      Result:=PrintFoot('A');
    end;
  end;
  If Result then SaveInfoCls
end;

procedure TeKasaHnd.SaveInfoCls;
var mR:TTFileHnd;
begin
  mR:=TTFileHnd.Create;
  mR.SaveClsDoc('A');
  FreeAndNil(mR);
end;

function TeKasaHnd.PrintDClsT:boolean;
var mTrnSum, mExpSum, mIncSum, mTrn:double; I:longint;
begin
  gBlkHead.BlkDate := Date;
  gBlkHead.BlkTime := Time;
  If Initialize then begin
    If GetPrnState then begin
      oRepMask:=gPath.RepPath+'ecs_dcls.r'+StrIntZero(1,2);
      If FileExists(oRepMask) then begin
        InitTFile;
        ReadRepFile;
        Inc(gEcsGlob.DClsNum);
        SetIntHead(cIntHead);
        SetDateFld('1',gBlkHead.BlkDate);
        SetTimeFld('2',gBlkHead.BlkTime);
        SetIntFld('3',cCasNum);
        SetIntFld('4',gEcsGlob.IntDocNum);
        SetStrFld('5',StrIntZero(cCasNum, 3)+StrIntZero(gEcsGlob.IntDocNum, 7));
        SetStrFld('6',geKasaInfo.CashRegisterCode);
        SetIntFld('7',gEcsGlob.DClsNum);

        SetIntFld('E',gEcsGlob.VatPrc[1]);
        SetDoubFld('F',gEcsGlob.AValue[1]);
        SetDoubFld('G',gEcsGlob.VatVal[1]);
        SetDoubFld('H',gEcsGlob.BValue[1]);
        SetIntFld('I',gEcsGlob.VatPrc[2]);
        SetDoubFld('J',gEcsGlob.AValue[2]);
        SetDoubFld('K',gEcsGlob.VatVal[2]);
        SetDoubFld('L',gEcsGlob.BValue[2]);
        SetIntFld('M',gEcsGlob.VatPrc[3]);
        SetDoubFld('N',gEcsGlob.AValue[3]);
        SetDoubFld('O',gEcsGlob.VatVal[3]);
        SetDoubFld('P',gEcsGlob.BValue[3]);
        SetIntFld('¡',gEcsGlob.VatPrc[4]);
        SetDoubFld('…',gEcsGlob.AValue[4]);
        SetDoubFld('Õ',gEcsGlob.VatVal[4]);
        SetDoubFld('”',gEcsGlob.BValue[4]);

        SetDoubFld('Q',gEcsGlob.AValue[1]+gEcsGlob.AValue[2]+gEcsGlob.AValue[3]+gEcsGlob.AValue[4]+gEcsGlob.ICDocPay);
        SetDoubFld('R',gEcsGlob.VatVal[1]+gEcsGlob.VatVal[2]+gEcsGlob.VatVal[3]+gEcsGlob.VatVal[4]);
        SetDoubFld('S',gEcsGlob.BValue[1]+gEcsGlob.BValue[2]+gEcsGlob.BValue[3]+gEcsGlob.BValue[4]+gEcsGlob.ICDocPay);

        SetStrFld('o', gEcsGlob.PayVals[0].Name);
        SetStrFld('p', gEcsGlob.PayVals[1].Name);
        SetStrFld('q', gEcsGlob.PayVals[2].Name);
        SetStrFld('r', gEcsGlob.PayVals[3].Name);
        SetStrFld('s', gEcsGlob.PayVals[4].Name);
        SetStrFld('t', gEcsGlob.PayVals[5].Name);
        SetStrFld('u', gEcsGlob.PayVals[6].Name);
        SetStrFld('v', gEcsGlob.PayVals[7].Name);
        SetStrFld('w', gEcsGlob.PayVals[8].Name);
        SetStrFld('x', gEcsGlob.PayVals[9].Name);

        SetIntFld('T', gEcsGlob.SalDocQnt);
        SetIntFld('U', gEcsGlob.ICDocQnt);
        SetIntFld('V', gEcsGlob.IncDocQnt);
        SetIntFld('W', gEcsGlob.DecDocQnt);

        SetDoubFld('X', gEcsGlob.RndH);
        SetDoubFld('Y', gEcsGlob.RndI_P+gEcsGlob.RndI_N);
        
        SetIntFld('e', gEcsGlob.DscItmQnt);
        SetIntFld('f', gEcsGlob.ClmItmQnt);
        SetIntFld('g', gEcsGlob.AdvItmQnt);
        SetIntFld('h', gEcsGlob.NegItmQnt);

        SetDoubFld('i', gEcsGlob.DscVal);
        SetDoubFld('j', gEcsGlob.ClmVal);
        SetDoubFld('k', gEcsGlob.AdvVal);
        SetDoubFld('l', gEcsGlob.NegVal);
        SetDoubFld('m', gEcsGlob.ICDocPay);

        PrintHead;
        mTrnSum := 0; mExpSum := 0; mIncSum := 0; mTrn := 0;
        For I:=0 to 9 do begin
          mTrn := gEcsGlob.PayVals[I].TrnVal+gEcsGlob.PayVals[I].ChIVal-gEcsGlob.PayVals[I].ChOVal;
          mTrnSum:=Roundx(mTrnSum+mTrn,4);
          mExpSum:=Roundx(mExpSum+gEcsGlob.PayVals[I].ExpVal,4);
          mIncSum:=Roundx(mIncSum+gEcsGlob.PayVals[I].IncVal,4);
          If gEcsGlob.PayVals[I].Name=''
            then SetStrFld('A', '')
           else SetStrFld('A', StrInt (I,0));
          SetDoubFld('B', gEcsGlob.PayVals[I].IncVal);
          SetDoubFld('C', gEcsGlob.PayVals[I].ExpVal);
          SetDoubFld('D', mTrn);
          PrintItem;
        end;
      end;
      SetDoubFld('b',mIncSum);
      SetDoubFld('c',mExpSum);
      SetDoubFld('d',mTrnSum);
      Result:=PrintFoot('D');
    end;
  end;
  If Result then SaveDCls
end;

procedure TeKasaHnd.SaveDCls;
var mR:TTFileHnd;
begin
  mR:=TTFileHnd.Create;
  mR.SaveClsDoc('D');
  FreeAndNil(mR);
end;

function TeKasaHnd.PrintMClsT:boolean;
var mTrnSum, mExpSum, mIncSum, mTrn:double; I:longint;
    mDateF,mDateL:TDateTime; mR:TTFileClsFill;
begin
  Result := FALSE;
  gBlkHead.BlkDate := Date;
  gBlkHead.BlkTime := Time;
  If Initialize then begin
    If GetPrnState then begin
      oRepMask:=gPath.RepPath+'ecs_mcls.r'+StrIntZero(1,2);
      If FileExists(oRepMask) then begin
        InitTFile;
        SetActYear(LineElement(StrDate(Date),2,'.'));
        mDateF:=FirstActMthDate;
        mDateL:=LastActMthDate;
        mR:=TTFileClsFill.Create;
        mR.FillClsValuesDate(mDateF,mDateL,cCasNum,geKasaPath);
        FreeAndNil(mR);
        ReadRepFile;

        SetIntHead(cIntHead);
        SetDateFld('1',gBlkHead.BlkDate);
        SetTimeFld('2',gBlkHead.BlkTime);
        SetIntFld('3',cCasNum);
        SetIntFld('4',gEcsGlob.IntDocNum);
        SetStrFld('5',StrIntZero(cCasNum, 3)+StrIntZero(gEcsGlob.IntDocNum, 7));
        SetStrFld('6',geKasaInfo.CashRegisterCode);
        SetIntFld('7',gClsData.DClsNumF);
        SetIntFld('8',gClsData.DClsNumL);
        SetDateFld('9',gClsData.DClsDateF);
        SetDateFld('0',gClsData.DClsDateL);

        SetIntFld('E',gClsData.VatPrc[1]);
        SetDoubFld('F',gClsData.AValue[1]);
        SetDoubFld('G',gClsData.VatVal[1]);
        SetDoubFld('H',gClsData.BValue[1]);
        SetIntFld('I',gClsData.VatPrc[2]);
        SetDoubFld('J',gClsData.AValue[2]);
        SetDoubFld('K',gClsData.VatVal[2]);
        SetDoubFld('L',gClsData.BValue[2]);
        SetIntFld('M',gClsData.VatPrc[3]);
        SetDoubFld('N',gClsData.AValue[3]);
        SetDoubFld('O',gClsData.VatVal[3]);
        SetDoubFld('P',gClsData.BValue[3]);
        SetIntFld('¡',gClsData.VatPrc[4]);
        SetDoubFld('…',gClsData.AValue[4]);
        SetDoubFld('Õ',gClsData.VatVal[4]);
        SetDoubFld('”',gClsData.BValue[4]);

        SetDoubFld('Q',gClsData.AValue[1]+gClsData.AValue[2]+gClsData.AValue[3]+gClsData.AValue[4]+gClsData.ICDocPay);
        SetDoubFld('R',gClsData.VatVal[1]+gClsData.VatVal[2]+gClsData.VatVal[3]+gClsData.VatVal[4]);
        SetDoubFld('S',gClsData.BValue[1]+gClsData.BValue[2]+gClsData.BValue[3]+gClsData.BValue[4]+gClsData.ICDocPay);

        SetStrFld('o', gEcsGlob.PayVals[0].Name);
        SetStrFld('p', gEcsGlob.PayVals[1].Name);
        SetStrFld('q', gEcsGlob.PayVals[2].Name);
        SetStrFld('r', gEcsGlob.PayVals[3].Name);
        SetStrFld('s', gEcsGlob.PayVals[4].Name);
        SetStrFld('t', gEcsGlob.PayVals[5].Name);
        SetStrFld('u', gEcsGlob.PayVals[6].Name);
        SetStrFld('v', gEcsGlob.PayVals[7].Name);
        SetStrFld('w', gEcsGlob.PayVals[8].Name);
        SetStrFld('x', gEcsGlob.PayVals[9].Name);

        SetIntFld('T', gClsData.SalDocQnt);
        SetIntFld('U', gClsData.ICDocQnt);
        SetIntFld('V', gClsData.IncDocQnt);
        SetIntFld('W', gClsData.ExpDocQnt);

        SetDoubFld('X', gClsData.RndH);
        SetDoubFld('Y', gClsData.RndI_P+gClsData.RndI_N);
        
        SetIntFld('e', gClsData.DscItmQnt);
        SetIntFld('f', gClsData.ClmItmQnt);
        SetIntFld('g', gClsData.AdvItmQnt);
        SetIntFld('h', gClsData.NegItmQnt);

        SetDoubFld('i', gClsData.DscVal);
        SetDoubFld('j', gClsData.ClmVal);
        SetDoubFld('k', gClsData.AdvVal);
        SetDoubFld('l', gClsData.NegVal);
        SetDoubFld('m', gClsData.ICDocPay);

        PrintHead;
        mTrnSum := 0; mExpSum := 0; mIncSum := 0; mTrn := 0;
        For I:=0 to 9 do begin
          mTrn := gClsData.PayVals[I].TrnVal;
          mTrnSum:=Roundx(mTrnSum+mTrn,4);
          mExpSum:=Roundx(mExpSum+gClsData.PayVals[I].ExpVal,4);
          mIncSum:=Roundx(mIncSum+gClsData.PayVals[I].IncVal,4);
          If gEcsGlob.PayVals[I].Name=''
            then SetStrFld('A', '')
           else SetStrFld('A', StrInt (I,0));
          SetDoubFld('B', gClsData.PayVals[I].IncVal);
          SetDoubFld('C', gClsData.PayVals[I].ExpVal);
          SetDoubFld('D', mTrn);
          PrintItem;
        end;
      end;
      SetDoubFld('b',mIncSum);
      SetDoubFld('c',mExpSum);
      SetDoubFld('d',mTrnSum);
      Result:=PrintFoot('M');
    end;
  end;
  If Result then SaveMCls;
end;

procedure TeKasaHnd.SaveMCls;
var mR:TTFileHnd;
begin
  mR:=TTFileHnd.Create;
  mR.SaveMClsDoc;
  FreeAndNil(mR);
end;

function TeKasaHnd.GetUID:Str50;
begin
  Result:='';
  case oPPEKKType of
    1: Result:=oPortos.UID;
    2: Result:=oeKasaSK.UID;
  end;
end;

function TeKasaHnd.Initialize:boolean;
// T·to funkcia inicializuje eKasu. NastavÌ z·kladnÈ inform·cie
begin
  Result:=geKasaInfo.Initialized;
  If not Result then begin
    case oPPEKKType of
      0: Result:=TRUE;
      1: Result:=oPortos.Initialize;
      2: Result:=oeKasaSK.Initialize;
    end;
  end;
  If not Result then begin
    oErrCod:=200001;
    oErrDes:='Chyba pri inicializ·ciÌ eKasa!';
  end;
end;

function TeKasaHnd.GetCashRegisterCode:boolean;
// T·to funkcia vyËÌta kÛd pokladne a uloûÌ do premennej geKasaInfo.CashRegisterCode
begin
  Result:=FALSE;
  case oPPEKKType of
    0: Result:=TRUE;
    1: Result:=oPortos.GetCashRegisterCode;
    2: Result:=oeKasaSK.GetCashRegisterCode;
  end;
end;

function TeKasaHnd.GetPrnState:boolean;
// T·to funkcia vr·ti stav tlaËiarne
begin
  Result:=FALSE;
  case oPPEKKType of
    0: Result:=TRUE;
    1: Result:=oPortos.GetPrnState;
    2: Result:=oeKasaSK.GetPrnState;
  end;
end;

function TeKasaHnd.GetConnetced:boolean;
// T·to funkcia vr·ti stav pripojenia na FS
begin
  Result:=FALSE;
  case oPPEKKType of
    0: Result:=TRUE;
    1: Result:=oPortos.GetConnetced;
    2: Result:=oeKasaSK.GetConnetced;
  end;
end;

function TeKasaHnd.GetCertificates:TDateTime;
// T·to funkcia vr·ti platnosù certifik·tu
begin
  Result:=0;
  case oPPEKKType of
    1: Result:=oPortos.GetCertificates;
    2: Result:=oeKasaSK.GetCertificates;
  end;
end;

function TeKasaHnd.GetVersion:string;
begin
  Result:='';
  case oPPEKKType of
    1: Result:=oPortos.GetVersion;
    2: Result:=oeKasaSK.GetVersion;
  end;
end;

function TeKasaHnd.GetLastReceiptNumber:longint;
begin
  Result:=0;
  If Initialize then begin
    case oPPEKKType of
      1: Result:=oPortos.GetLastReceiptNumber;
      2: Result:=oeKasaSK.GetLastReceiptNumber;
    end;
  end;
end;

function TeKasaHnd.GetFullLastReceiptNumber:string;
begin
  Result:='';
  If Initialize then begin
    case oPPEKKType of
      1: Result:=oPortos.GetFullLastReceiptNumber;
      2: Result:=oeKasaSK.GetFullLastReceiptNumber;
    end;
  end;
end;

function TeKasaHnd.GetDailyReceiptNumber:longint;
// funkcia vr·ti aktu·lne poradovÈ ËÌslo ˙Ëtenky pre Portosa za aktu·lny aktu·lny mesiac a pre eKasaSK  za aktu·lny aktu·lny deÚ
begin
  Result:=0;
  If Initialize then begin
    case oPPEKKType of
      1: Result:=oPortos.GetLastReceiptNumber;
      2: Result:=oeKasaSK.GetDailyReceiptNumber;
    end;
  end;
end;

function TeKasaHnd.OpenDrawer(pESC:string):boolean;
// T·to funkcia otvorÌ pokladniËn˙ z·suvku
begin
  Result:=FALSE;
  If Initialize then begin
    case oPPEKKType of
      0: Result:=TRUE;
      1: Result:=oPortos.OpenDrawer;
      2: Result:=oeKasaSK.OpenDrawer(pESC);
    end;
  end;
end;

function TeKasaHnd.ReadLastDoc:string;
// T·to funkcia vr·ti posledn˝ vytlaËen˝ doklad (len pre eKasaSK)
begin
  Result:='';
  If Initialize then begin
    case oPPEKKType of
      2: Result:=oeKasaSK.ReadLastDoc;
    end;
  end;
end;

procedure TeKasaHnd.RecalcBlkHead;
var I,J,mV,mVatPrc:longint;
begin
  For J:=1 to 5 do begin
    gBlkHead.VatPrc[J]:=uVatPrc[J];
    gBlkHead.BVals[J]:=0;
    gBlkHead.AVals[J]:=0;
    gBlkHead.VatVals[J]:=0;
    gBlkHead.DscBVals[J]:=0;
  end;
  For I:=1 to gBlkItemQnt do begin
    mVatPrc:=gBlkItems[I].VatPrc;
    mV:=-1;
    For J:=1 to 5 do begin
      If mVatPrc=gBlkHead.VatPrc[J] then begin
        mV:=J;
        Break;
      end;
    end;
    If mV>-1 then begin
      gBlkHead.BVals[mV]:=gBlkHead.BVals[mV]+gBlkItems[I].BValue;
      gBlkHead.AVals[mV]:=Roundx(gBlkHead.BVals[mV]/((100+mVatPrc)/100),2);
      gBlkHead.VatVals[mV]:=gBlkHead.BVals[mV]-gBlkHead.AVals[mV];
      If not IsNul(gBlkItems[I].DscBVal) then gBlkHead.DscBVals[mV]:=gBlkHead.DscBVals[mV]+gBlkItems[I].DscBVal;
    end;
  end;
end;

procedure TeKasaHnd.AddRndItm;
var mQnt:longint; mRndItm:TRndItm;
begin
  If gBlkHead.RndVal<0 then begin
    mQnt:=-1;
    mRndItm:=gRndItmN;
  end else begin
    mQnt:=1;
    mRndItm:=gRndItmP;
  end;
  Inc(gBlkItemQnt);
  gBlkItems[gBlkItemQnt].GsCode:=mRndItm.GsCode;
  gBlkItems[gBlkItemQnt].MgCode:=mRndItm.MgCode;
  gBlkItems[gBlkItemQnt].FgCode:=mRndItm.FgCode;
  gBlkItems[gBlkItemQnt].BarCode:=mRndItm.BarCode;
  gBlkItems[gBlkItemQnt].StkCode:='';
  gBlkItems[gBlkItemQnt].OsdCode:='';
  gBlkItems[gBlkItemQnt].GsName:=mRndItm.GsName;
  gBlkItems[gBlkItemQnt].VatPrc:=0;
  gBlkItems[gBlkItemQnt].MsName:=mRndItm.MsName;
  gBlkItems[gBlkItemQnt].Qnt:=mQnt;
  gBlkItems[gBlkItemQnt].BPrice:=Abs(gBlkHead.RndVal);
  gBlkItems[gBlkItemQnt].BValue:=gBlkHead.RndVal;
  gBlkItems[gBlkItemQnt].FBPrice:=Abs(gBlkHead.RndVal);
  gBlkItems[gBlkItemQnt].FBValue:=gBlkHead.RndVal;
  gBlkItems[gBlkItemQnt].DscPrc:=0;
  gBlkItems[gBlkItemQnt].DscBVal:=0;
  gBlkItems[gBlkItemQnt].NegType:='R';
  gBlkItems[gBlkItemQnt].RefID:='';
  gBlkItems[gBlkItemQnt].LoginName:='';
  gBlkItems[gBlkItemQnt].Date:=Date;
  gBlkItems[gBlkItemQnt].Time:=Time;
  oItmVal:=oItmVal+Rd2(gBlkHead.RndVal);
  RecalcBlkHead;
end;

function TeKasaHnd.PrintBlk(pEcdFile:string;pRepNum:byte):boolean;
var I:longint; mOK:boolean;
begin
  Result:=FALSE;
  If Initialize then begin
    If GetPrnState then begin
      If LoadEcdFile(pEcdFile) then begin
        oRepMask:=gPath.RepPath+'ecs_blk.re'+StrInt(oPPEKKType,0)+StrIntZero(pRepNum,2);
        If FileExists(oRepMask) then begin
          InitTFile;
          ReadRepFile;
          FillBlkHead;
          OpenDrawer(cDrawerEsc);
          If PrintDocHead then begin
            For I:=1 to gBlkItemQnt do begin
              FillBlkItem(I);
              mOK:=FALSE;
              If oBlockItem<>nil then mOK:=PrintDocItem(I);
              If not mOK then Break;
            end;
            If mOK then begin
              If PrintDocPay then begin
                Result:=PrintDocFoot;
              end;
            end;
          end;
          If Result then begin
            SaveToCFile (oFullBlk.Text,geKasaPath, cCasNum, gEcsGlob.IntDocNum, gBlkHead.BlkDate, gBlkHead.BlkTime, 'S', gEcsGlob.eKasaDocNum);
            If (cCashRndSave=1) and IsNotNul (Rd2(gBlkHead.RndVal)) then AddRndItm;
            SaveTDoc;
            If cCopies_blk>1 then begin
              For I:=2 to cCopies_blk do
                PrintLastBlock;
            end;
          end;
        end else begin
          oErrCod:=200003;
          oErrDes:='Neexistuj˙ca tlaËov· maska ('+ExtractFileName(oRepMask)+')';
        end;
      end;                              ;
    end else begin
      oErrCod:=200002;
      oErrDes:='Chyba pri komunik·ciÌ s tlaËiarÚou!';
    end;
  end;
end;

function TeKasaHnd.PrintICDoc(pEcdFile:string;pRepNum:byte):boolean;
var I:longint; mOK:boolean;
begin
  Result:=FALSE;
  If Initialize then begin
    If GetPrnState then begin
      If LoadEcdFile(pEcdFile) then begin
        If not Eq2 (gBlkHead.BValue, gBlkHead.PayVal) then gBlkHead.BValue:=gBlkHead.PayVal;
        oRepMask:=gPath.RepPath+'ecs_icblk.re'+StrInt(oPPEKKType,0)+StrIntZero(pRepNum,2);
        If FileExists(oRepMask) then begin
          InitTFile;
          ReadRepFile;
          FillICBlkHead;
          OpenDrawer(cDrawerEsc);
          If PrintICDocHead then begin
            If PrintICDocPay then begin
              Result:=PrintICDocFoot;
            end;
          end;
          If Result then begin
            SaveToCFile (oFullBlk.Text,geKasaPath, cCasNum, gEcsGlob.IntDocNum, gBlkHead.BlkDate, gBlkHead.BlkTime, 'S', gEcsGlob.eKasaDocNum);
            SaveTICDoc;
            If cCopies_icblk>1 then begin
              For I:=2 to cCopies_icblk do
                PrintLastBlock;
            end;
          end;
        end else begin
          oErrCod:=200003;
          oErrDes:='Neexistuj˙ca tlaËov· maska ('+ExtractFileName(oRepMask)+')';
        end;
      end;
    end else begin
      oErrCod:=200002;
      oErrDes:='Chyba pri komunik·ciÌ s tlaËiarÚou!';
    end;
  end;
end;

function  TeKasaHnd.PrintRepDoc(pRepNum:byte):boolean;
var I:longint; mBegSum, mTrnSum, mExpSum, mEndSum, mTrn:double;
begin
  Result := FALSE;
  gBlkHead.BlkDate := Date;
  gBlkHead.BlkTime := Time;
  If Initialize then begin
    If GetPrnState then begin
     oRepMask:=gPath.RepPath+'ecs_repdoc.r'+StrIntZero(1,2);
     If FileExists(oRepMask) then begin
       InitTFile;
       ReadRepFile;
       SetIntHead(cIntHead);
       SetDateFld('1',gBlkHead.BlkDate);
       SetTimeFld('2',gBlkHead.BlkTime);
       SetIntFld('3',cCasNum);
       SetIntFld('4',gEcsGlob.IntDocNum);
       SetStrFld('5',StrIntZero(cCasNum, 3)+StrIntZero(gEcsGlob.IntDocNum, 7));
       SetStrFld('6',geKasaInfo.CashRegisterCode);
       PrintHead;
       mBegSum := 0; mTrnSum := 0; mExpSum := 0; mEndSum := 0; mTrn := 0;
       For I:=0 to 9 do begin
         mTrn:=gEcsGlob.PayVals[I].TrnVal+gEcsGlob.PayVals[I].ChIVal-gEcsGlob.PayVals[I].ChOVal;
         mBegSum:=Roundx (mBegSum+gEcsGlob.PayVals[I].BegVal,4);
         mTrnSum:=Roundx (mTrnSum+mTrn,4);
         mExpSum:=Roundx (mExpSum+gEcsGlob.PayVals[I].ExpVal,4);
         mEndSum:=Roundx (mEndSum+gEcsGlob.PayVals[I].EndVal,4);
         If gEcsGlob.PayVals[I].Name=''
           then SetStrFld('A','')
           else SetStrFld('A',StrInt (I,0));
         SetDoubFld('B',gEcsGlob.PayVals[I].BegVal);
         SetDoubFld('C',mTrn);
         SetDoubFld('D',gEcsGlob.PayVals[I].ExpVal);
         SetDoubFld('E',gEcsGlob.PayVals[I].EndVal);
         PrintItem;
       end;
       SetDoubFld('b',mBegSum);
       SetDoubFld('c',mTrnSum);
       SetDoubFld('d',mExpSum);
       SetDoubFld('e',mEndSum);

       SetDoubFld('f',gEcsGlob.PayVals[0].IncVal);
       SetDoubFld('g',gEcsGlob.ICDocPay);
       SetDoubFld('h',gEcsGlob.AdvVal);
       SetDoubFld('i',gEcsGlob.ClmVal);
       SetDoubFld('j',gEcsGlob.DscVal);
       SetDoubFld('k',gEcsGlob.NegVal);

       SetStrFld('o',gEcsGlob.PayVals[0].Name);
       SetStrFld('p',gEcsGlob.PayVals[1].Name);
       SetStrFld('q',gEcsGlob.PayVals[2].Name);
       SetStrFld('r',gEcsGlob.PayVals[3].Name);
       SetStrFld('s',gEcsGlob.PayVals[4].Name);
       SetStrFld('t',gEcsGlob.PayVals[5].Name);
       SetStrFld('u',gEcsGlob.PayVals[6].Name);
       SetStrFld('v',gEcsGlob.PayVals[7].Name);
       SetStrFld('w',gEcsGlob.PayVals[8].Name);
       SetStrFld('x',gEcsGlob.PayVals[9].Name);
       Result:=PrintFoot('R');
       If Result then begin
         SaveRepDoc;
       end;
     end;
    end else begin
      oErrCod:=200002;
      oErrDes:='Chyba pri komunik·ciÌ s tlaËiarÚou!';
    end;
  end;
end;

function TeKasaHnd.PrintIncDoc(pIncVal:double;pRepNum:byte):boolean;
var I:byte; mS,mSepar:string; mHead,mFoot:string;
begin
  Result := FALSE;
  If pIncVal>0 then begin
    gBlkHead.BlkDate := Date;
    gBlkHead.BlkTime := Time;
    If Initialize then begin
      If GetPrnState then begin
        oRepMask:=gPath.RepPath+'ecs_incdoc.re'+StrInt(oPPEKKType,0)+StrIntZero(pRepNum,2);
        If FileExists(oRepMask) then begin
          InitTFile;
          ReadRepFile;
          uPaysTbl[0]:=pIncVal;
          SetIntHead(cIntHead);
          SetDateFld ('1', gBlkHead.BlkDate);
          SetTimeFld ('2', gBlkHead.BlkTime);
          SetIntFld ('3', cCasNum);
          SetIntFld ('4', gEcsGlob.IntDocNum);
          SetStrFld ('5', StrIntZero(cCasNum, 3)+StrIntZero(gEcsGlob.IntDocNum, 7));
          If oBlockHead<>nil then mHead:=FillAllFld(oBlockHead.Text);
          If oSumFoot<>nil then mFoot:=FillAllFld(oSumFoot.Text);
          OpenDrawer(cDrawerEsc);
          case oPPEKKType of
            0: Result:=TRUE;
            1: begin
                 Result:=oPortos.PrintDeposit(pIncVal,mHead,mFoot);
                 gEcsGlob.DDocNum:=oPortos.GetLastReceiptNumber;
                 gEcsGlob.eKasaDocNum:=oPortos.GetFullLastReceiptNumber;

                 AddBlkText(AlignCenter('VKLAD',40));
                 AddBlkText(' ');
                 mS:='Doklad: '+StrInt(gEcsGlob.DDocNum,7)+'  D·tum: '+FormatDateTime('dd.mm.yyyy hh:nn',Now); AddBlkText(mS);
                 mS:='KP: '+geKasaInfo.CashRegisterCode; AddBlkText(mS);
                 AddBlkText(mHead);
                 mSepar:='----------------------------------------';
                 mS:='                       Vklad: '+StrDoub(pIncVal,0,2)+' EUR';
                 AddBlkText(mSepar);
                 AddBlkText(mS);
                 AddBlkText(mSepar);
                 AddBlkText(mFoot);
               end;
            2: begin
                 Result:=oeKasaSK.PrintDeposit(16,gEcsGlob.PayVals[0].Name,pIncVal,mHead,mFoot);
                 If Result then begin
                   oFullBlk.Text:=oeKasaSK.ReadLastDoc;
                 end;
                 gEcsGlob.DDocNum:=oeKasaSK.GetDailyReceiptNumber;
                 gEcsGlob.eKasaDocNum:=oeKasaSK.GetFullLastReceiptNumber;
               end;
          end;
          If Result then begin
            SaveToCFile(oFullBlk.Text,geKasaPath,cCasNum,gEcsGlob.IntDocNum,gBlkHead.BlkDate,gBlkHead.BlkTime,'I',gEcsGlob.eKasaDocNum);
            SaveIncDoc;
            If cCopies_incdoc>1 then begin
              For I:=2 to cCopies_incdoc do
                PrintLastBlock;
            end;
          end;
        end;
      end;
    end;
  end;
end;

function TeKasaHnd.SetExpDocPay (pPayNum:longint;pExpVal:double):boolean;
begin
  If pPayNum in [0..9] then begin
    uPaysTbl[pPayNum]:=pExpVal;
  end;
end;

function TeKasaHnd.PrintExpDoc(pRepNum:byte):boolean;
var mHead,mFoot,mS,mSepar:string; mVal:double; I,mNum:longint;
begin
  gBlkHead.BlkDate := Date;
  gBlkHead.BlkTime := Time;
  If Initialize then begin
    If GetPrnState then begin
      oRepMask:=gPath.RepPath+'ecs_expdoc.re'+StrInt(oPPEKKType,0)+StrIntZero(pRepNum,2);
      If FileExists(oRepMask) then begin
        mHead:=''; mFoot:='';
        InitTFile;
        ReadRepFile;
        SetIntHead(cIntHead);
        SetDateFld ('1', gBlkHead.BlkDate);
        SetTimeFld ('2', gBlkHead.BlkTime);
        SetIntFld ('3', cCasNum);
        SetIntFld ('4', gEcsGlob.IntDocNum);
        SetStrFld ('5', StrIntZero(cCasNum, 3)+StrIntZero(gEcsGlob.IntDocNum, 7));
        If oBlockHead<>nil then mHead:=FillAllFld(oBlockHead.Text);
        If oSumFoot<>nil then mFoot:=FillAllFld(oSumFoot.Text);
        OpenDrawer(cDrawerEsc);
        case oPPEKKType of
          0: Result:=TRUE;
          1: begin
               mVal:=0;
               For I:=0 to 9 do begin
                 If IsNotNul(uPaysTbl[I]) then begin
                   mVal:=mVal+uPaysTbl[I];
                   mHead:=mHead+AlignRight(gEcsGlob.PayVals[I].Name,30)+StrDoub(uPaysTbl[I],10,2)+#13+#10;
                 end;
               end;
               Result:=oPortos.PrintWithDraw(mVal,mHead,mFoot);
               If Result then begin
                 gEcsGlob.DDocNum:=oPortos.GetLastReceiptNumber;
                 gEcsGlob.eKasaDocNum:=oPortos.GetFullLastReceiptNumber;
                 AddBlkText(AlignCenter('V›BER',40));
                 AddBlkText(' ');
                 mS:='Doklad: '+StrInt(gEcsGlob.DDocNum,7)+'  D·tum: '+FormatDateTime('dd.mm.yyyy hh:nn',Now); AddBlkText(mS);
                 mS:='KP: '+geKasaInfo.CashRegisterCode; AddBlkText(mS);
                 AddBlkText(' ');
                 AddBlkText(mHead);
                 mSepar:='----------------------------------------';
                 mS:='                      V˝ber: '+StrDoub(mVal,0,2)+' EUR';
                 AddBlkText(mSepar);
                 AddBlkText(mS);
                 AddBlkText(mSepar);
                 AddBlkText(mFoot);
               end;
             end;
          2: begin
               Result:=oeKasaSK.PrintWithdrawH(mHead);
               If Result then begin
                 For I:=0 to 9 do begin
                   If IsNotNul(uPaysTbl[I]) then begin
                     mNum:=I;
                     If mNum=0 then mNum:=16;
                     Result:=oeKasaSK.PrintWithdrawP(mNum,gEcsGlob.PayVals[I].Name,uPaysTbl[I]);
                     If not Result then Break;
                   end;
                 end;
                 If Result then begin
                   Result:=oeKasaSK.PrintWithdrawF(mFoot);
                   If Result then oFullBlk.Text:=oeKasaSK.ReadLastDoc;
                   If Result then begin
                     gEcsGlob.DDocNum:=oeKasaSK.GetDailyReceiptNumber;
                     gEcsGlob.eKasaDocNum:=oeKasaSK.GetFullLastReceiptNumber;
                   end;
                 end;
               end;
             end;
        end;
        If Result then begin
          SaveExpDoc;
          SaveToCFile(oFullBlk.Text,geKasaPath,cCasNum,gEcsGlob.IntDocNum,gBlkHead.BlkDate,gBlkHead.BlkTime,'O',gEcsGlob.eKasaDocNum);
          If cCopies_expdoc>1 then begin
            For I:=2 to cCopies_expdoc do
              PrintLastBlock;
          end;
        end;
      end;
    end;
  end;
end;

function TeKasaHnd.PrintInfoCls:boolean;
begin
  Result:=FALSE;
  case oPPEKKType of
    1: Result:=PrintInfoClsT;
    2: Result:=oeKasaSK.PrintIClose;
  end;
end;

function TeKasaHnd.PrintDCls:boolean;
var mClsNum:longint;
begin
  Result:=FALSE;
  case oPPEKKType of
    1: Result:=PrintDClsT;
    2: begin
         InitTFile;
         gBlkHead.BlkDate := Date;
         gBlkHead.BlkTime := Time;
         If oeKasaSK.ReadDCloseVals then begin
           mClsNum:=oeKasaSK.GetDCloseNum-1;
           Result:=oeKasaSK.PrintDClose;
           gEcsGlob.DClsNum:=oeKasaSK.GetDCloseNum-1;
           If mClsNum<>gEcsGlob.DClsNum then begin
             oFullBlk.Text:=oeKasaSK.ReadLastDoc;
             SaveToCFile (oFullBlk.Text,geKasaPath,cCasNum,gEcsGlob.IntDocNum,gBlkHead.BlkDate,gBlkHead.BlkTime,'D',StrInt(gEcsGlob.DClsNum,0));
             SaveDCls;
           end else Result:=FALSE;
         end;
       end;
  end;
end;

function TeKasaHnd.PrintMCls:boolean;
begin
  Result:=FALSE;
  case oPPEKKType of
    1,2: Result:=PrintMClsT;
  end;
end;

function TeKasaHnd.PrintLastBlock:boolean;
var I:longint;
begin
  Result := FALSE;
  case oPPEKKType of
    0: Result:=TRUE;
    1: Result:=oPortos.PrintLastBlock;
    2: Result:=oeKasaSK.PrintLastBlock;
  end;
end;

procedure TeKasaHnd.Test;
begin
  If Initialize then begin
    case oPPEKKType of
      1: begin
           oPortos.SetBlkH('Head');
           oPortos.SetBlkI(cItmTypePositive,'Tovar 1',0.5,8,4,20,'ks','','');
           oPortos.SetBlkI(cItmTypeReturned,'Tovar 2',-1,2,-2,20,'ks','','11111aaaa');
           oPortos.SetBlkP('Hotovosù', 2);
           oPortos.PrintBlk(2,'Foot');
         end;
      2: begin
           oeKasaSK.PrintBlkH('Head',2);
           oeKasaSK.PrintBlkI(cItmTypePositive,'Item','Tovar 1',0.5,8,4,20,'ks','description','');
           oeKasaSK.PrintBlkI(cItmTypeReturned,'Item','Tovar 2',1,-2,-2,20,'ks','description','11111aaaa');
           oeKasaSK.PrintBlkP(16,'Hotovosù',2);
           oeKasaSK.PrintBlk('Foot');
         end;
    end;
  end;
end;
//  <<<<< TeKasaHnd <<<<<

//  >>>>> TTFileHnd >>>>>
constructor TTFileHnd.Create;
var mFileName:string;
begin
  oList:=TStringList.Create;
  mFileName := geKasaPath+GetTFileName(Date,cCasNum);
  If not FileExists(mFileName) then begin
    SaveBegDoc;
    Inc(gEcsGlob.IntDocNum);
  end;
end;


destructor TTFileHnd.Destroy;
begin
  FreeAndNil(oList);
  inherited;
end;

function TTFileHnd.CalcCheckSum (pS:string):longint;
var I:longint;
begin
  Result := 0;
  For I:=1 to Length (pS) do
    Result := Result+Ord(pS[I]);
end;

procedure TTFileHnd.Save;
var mT:TextFile; mErr:longint; mFileName:string; mLocSize:longint;
begin
  If oList.Count>0 then begin
    mFileName := GetTFileName(Date,cCasNum);
    mLocSize := TxtFile.GetFileSize (geKasaPath+mFileName);
    If OpenTxtFileWrite(mT,geKasaPath+mFileName,mErr) then begin
      If gEcsGlob.Version<>cPrgVer then begin
        If Copy(oList.Strings[0],2,2)<>'FH' then oList.Insert(0,GetFHLine);
      end;
      WriteTxtFile(mT,oList.Text,mErr);
      CloseTxtFile(mT,mErr);
    end;
  end;
end;

function TTFileHnd.GetFHLine:string;
var mW:TTxtWrap;
begin
  mW := TTxtWrap.Create;
  mW.ClearWrap;
  mW.SetText ('FH',0);            // 1 HlaviËka kontrolnej p·sky
  mW.SetText (cPrgVer,0);         // 2 Verzia programu
  mW.SetText (cPrgMod,0);         // 3 D·tum vydania programovÈho modulu
  mW.SetText ('SK',0);            // 4 ät·t, kde sa pouûÌva pokladÚa
  mW.SetText ('Eur',0);           // 5 ät·tna mena
  mW.SetText ('ECS',0);           // 6 N·zov programu, ktor˝ vytvoril z·pis
  Result:=mW.GetWrapText;
  FreeAndNil (mW);
  gEcsGlob.Version:=cPrgVer;
end;

procedure TTFileHnd.SaveBegDoc;
var mW:TTxtWrap; I,mCheckSum:longint;
begin
  oList.Clear;
  mW := TTxtWrap.Create;
  oList.Add (GetFHLine);

  mCheckSum := 0;
  mW.ClearWrap;
  mW.SetText ('BB',0);                  //  1 HlaviËka dokladu poËiatoËnÈho stavu
  mW.SetNum  (cWriNum,0);               //  2 »Ìslo prev·dzkovej jednotky
  mW.SetNum  (cCasNum,0);               //  3 »Ìslo pokladne
  mW.SetNum  (gEcsGlob.IntDocNum,0);    //  4 InternÈ ËÌslo pokladniËnÈho dokladu
  mW.SetDate (gBlkHead.BlkDate);        //  5 D·tum vyhotovenie dokladu
  mW.SetTime (gBlkHead.BlkTime);        //  6 »as vyhotovenia dokladu
  mW.SetNum  (0,0);                     //  7 PoËiatoËny stav vöetk˝ch platidiel kumlatÌvne - nepouûÌva sa
  mW.SetNum  (gEcsGlob.XDocQnt,0);      //  8 XCusQnt - poËet z·kaznÌkov od poslednej X uz·vierky
  mW.SetNum  (gEcsGlob.DDocQnt,0);      //  9 DCusQnt - poËet z·kaznikov od poslednej D uz·vierky
  mW.SetNum  (0,0);                     // 10 MCusQnt - poËet z·kaznikov od poslednej M uz·vierky - nepouûÌva sa
  mW.SetText ('',0);                    // 11 Prihlasovacie meno pokladnÌka
  mW.SetText ('',0);                    // 12 Meno a prezvisko pokladnÌka
  mW.SetDate (gEcsGlob.PrevDate);       // 13 Predch·dzaj˙ci fiök·lny deÚ
  mW.SetDate (gBlkHead.BlkDate);        // 14 Aktu·lny fiök·lny d·tum - nepouûÌva sa
  mW.SetNum  (gEcsGlob.XClsNum, 0);     // 15 »Ìslo poslednej X uz·vierky
  mW.SetNum  (gEcsGlob.DClsNum, 0);     // 16 »Ìslo poslednej D uz·vierky
  mW.SetNum  (0, 0);                    // 17 »Ìslo poslednej M uz·vierky - nepouûÌva sa
  mW.SetReal (gEcsGlob.ICDocPay, 0, 2); // 18 Hodnota ˙hrady fakt˙r
  mW.SetReal (gEcsGlob.ClmVal, 0, 2);   // 19 Hodnota reklamovan˝ch poloûiek
  mW.SetReal (gEcsGlob.AdvVal, 0, 2);   // 20 Hodnota pouûit˝ch z·loh
  mW.SetReal (gEcsGlob.DscVal, 0, 2);   // 21 Hodnota zliav
  mW.SetNum  (gEcsGlob.ICDocQnt,0);     // 22 PoËet ˙hrad fakt˙r
  mW.SetNum  (gEcsGlob.IncDocQnt,0);    // 23 PoËet vkladov
  mW.SetNum  (gEcsGlob.DecDocQnt,0);    // 24 PoËet v˝berov
  mW.SetNum  (gEcsGlob.ClmItmQnt, 0);   // 25 PoËet reklamovan˝ch poloûiek
  mW.SetNum  (gEcsGlob.AdvItmQnt, 0);   // 26 PoËet pouûit˝ch z·loh
  mW.SetNum  (gEcsGlob.DscItmQnt, 0);   // 27 PoËet zliav
  mW.SetNum  (gEcsGlob.NegItmQnt, 0);   // 28 PoËet vr·ten˝ch obalov
  mW.SetReal (gEcsGlob.NegVal, 0, 2);   // 29 Hodnota vr·ten˝ch obalov
  mW.SetReal (gEcsGlob.RndH, 0, 2);     // 30 Hodnota zaokr˙hlenia cez PPEKK
  mW.SetReal (gEcsGlob.RndI_P, 0, 2);   // 31 Kladn· hodnota z poloûiek
  mW.SetReal (gEcsGlob.RndI_N, 0, 2);   // 32 Z·porn· hodnota z poloûiek

  oList.Add (mW.GetWrapText);
  mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);
  For I:=0 to 9 do begin
    If gEcsGlob.PayVals[I].Name<>'' then begin
      mW.ClearWrap;
      mW.SetText ('BP',0);                          // 1 Poloûka dokladu poËiatocnÈho stavu
      mW.SetNum  (I,0);                             // 2 »Ìslo platobnÈho prostriedku
      mW.SetText (gEcsGlob.PayVals[I].Name,0);      // 3 N·zov platobnÈho prostriedku
      mW.SetReal (0,0,2);                           // 4 PoËiatoËn˝ stav dÚa platobnÈho prostriedku - nepouûÌva sa
      mW.SetReal (gEcsGlob.PayVals[I].BegVal,0,2);  // 5 PoËiatoËn˝ stav platobnÈho prostriedku
      mW.SetReal (gEcsGlob.PayVals[I].TrnVal,0,2);  // 6 Trûba platobnÈho prostriedku
      mW.SetReal (gEcsGlob.PayVals[I].ExpVal,0,2);  // 7 V˝ber platobnÈho prostriedku
      mW.SetReal (gEcsGlob.PayVals[I].ChIVal,0,2);  // 8 Zmena platidla - Vklad platobnÈho prostriedku
      mW.SetReal (gEcsGlob.PayVals[I].ChOVal,0,2);  // 9 Zmena platidla - V˝ber platobnÈho prostriedku
      mW.SetReal (gEcsGlob.PayVals[I].IncVal,0,2);  // 10 Vklad platobnÈho prostriedku
      mW.SetReal (gEcsGlob.PayVals[I].EndVal,0,2);  // 11 KoneËn˝ stav platobnÈho prostriedku
      mW.SetReal (gEcsGlob.PayVals[I].PaidAdv,0,2); // 12 Zaplaten· z·loha platobnÈho prostriedku
      mW.SetReal (gEcsGlob.PayVals[I].UsedAdv,0,2); // 13 Pouûit· z·loha platobnÈho prostriedku
      oList.Add (mW.GetWrapText);
      mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);
    end;
  end;

  For I:=1 to 5 do begin
    If IsNotNul (gEcsGlob.BValue[I]) then begin
      mW.ClearWrap;
      mW.SetText ('BV',0);                     // 1 Poloûka trûby
      mW.SetNum  (gEcsGlob.VatPrc[I],0);   // 2 Sadzba DPH
      mW.SetReal (gEcsGlob.AValue[I],0,2); // 3 Hodnota bez DPH
      mW.SetReal (gEcsGlob.VatVal[I],0,2); // 4 Hodnota DPH
      mW.SetReal (gEcsGlob.BValue[I],0,2); // 5 Hodnota s DPH
      oList.Add (mW.GetWrapText);
      mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);
    end;
  end;
  mW.ClearWrap;
  mW.SetText ('BC',0);        //  1 KontrolnÈ ËÌslo - oznaËenie riadku
  mW.SetNum  (mCheckSum,0);   //  2 Kontrolne cislo
  oList.Add (mW.GetWrapText);
  Save;
  FreeAndNil (mW);
end;

procedure TTFileHnd.SaveRepDoc;
var mW:TTxtWrap; I,mCheckSum:longint; mActVal:double;
begin
  oList.Clear;
  mW := TTxtWrap.Create;
  mActVal := 0;
  For I:=0 to 9 do
    mActVal := mActVal+gEcsGlob.PayVals[I].EndVal;
  mCheckSum := 0;
  mW.ClearWrap;
  mW.SetText ('PB',0);            //  1 HlaviËka finanËnÈho stavu
  mW.SetNum  (cWriNum,0);         //  2 »Ìslo prev·dzkovej jednotky
  mW.SetNum  (cCasNum,0);         //  3 »Ìslo pokladne
  mW.SetNum  (gEcsGlob.IntDocNum, 0); //  4 InternÈ ËÌslo pokladniËnÈho dokladu
  mW.SetDate (gBlkHead.BlkDate);      //  5 D·tum vyhotovenie dokladu
  mW.SetTime (gBlkHead.BlkTime);      //  6 »as vyhotovenia dokladu
  mW.SetReal (mActVal, 0, 2);         //  7 Aktu·lny stav vöetk˝ch platidiel kumlatÌvne
  mW.SetText ('', 0);                 //  8 Prihlasovacie meno pokladnÌka
  mW.SetText ('', 0);                 //  9 Meno a prezvisko pokladnÌka
  mW.SetNum  (gEcsGlob.XDocQnt, 0);   // 10 PoËet z·kaznÌkov od poslednej X uz·vierky
  mW.SetNum  (gEcsGlob.DDocQnt, 0);   // 11 PoËet z·kaznikov od poslednej D uz·vierky
  mW.SetNum  (0, 0);                  // 12 PoËet z·kaznikov od poslednej M uz·vierky
  mW.SetNum  (gEcsGlob.XClsNum, 0);   // 13 »Ìslo poslednej X uz·vierky
  mW.SetNum  (gEcsGlob.DClsNum, 0);   // 14 »Ìslo poslednej D uz·vierky
  mW.SetNum  (0, 0);                  // 15 »Ìslo poslednej M uz·vierky
  mW.SetDate (gBlkHead.BlkDate);      // 16 Aktu·lny fiök·lny d·tum
  mW.SetReal  (gEcsGlob.ICDocPay, 0, 2); // 17 Hodnota ˙hrady fakt˙r
  oList.Add (mW.GetWrapText);
  mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);

  For I:=0 to 9 do begin
    If gEcsGlob.PayVals[I].Name<>'' then begin
      mW.ClearWrap;
      mW.SetText ('PP',0);                   //  1 FinanËnÈ stavy podæa platidiel
      mW.SetNum  (I,0);                      //  2 »Ìslo platobnÈho prostriedku
      mW.SetText (gEcsGlob.PayVals[I].Name,0);    //  3 N·zov platobnÈho prostriedku
      mW.SetReal (gEcsGlob.PayVals[I].BegVal,0,2);   //  4 PoËiatoËn˝ stav platobnÈho prostriedku
      mW.SetReal (gEcsGlob.PayVals[I].TrnVal,0,2);   //  5 Trûba
      mW.SetReal (gEcsGlob.PayVals[I].ExpVal,0,2);   //  6 Odvod trûby
      mW.SetReal (gEcsGlob.PayVals[I].EndVal,0,2);   //  7 KoneËn˝ stav platidla
      mW.SetReal (0,0,2);                            //  8 Nevr·tenÈ preplatky hotovosti
      mW.SetReal (gEcsGlob.PayVals[I].ChIVal,0,2);   //  9 Zmena platidla - prÌjem
      mW.SetReal (gEcsGlob.PayVals[I].ChOVal,0,2);   // 10 Zmena platidla - v˝daj
      mW.SetReal (gEcsGlob.PayVals[I].IncVal,0,2);   // 11 PrÌjem hotovosti do pokladne
      mW.SetReal (gEcsGlob.PayVals[I].PaidAdv,0,2);  // 12 Zaplaten· z·loha
      mW.SetReal (gEcsGlob.PayVals[I].UsedAdv,0,2);  // 13 »erpan· z·loha
      mW.SetReal (0,0,2); // 14 PrÌjem hotovosti do FM
      oList.Add (mW.GetWrapText);
      mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);
    end;
  end;

  mW.ClearWrap;
  mW.SetText ('PS',0);        //  1 Sumariz·cia
  mActVal := 0;
  For I:=0 to 9 do
    mActVal := mActVal+gEcsGlob.PayVals[I].BegVal;
  mW.SetReal (mActVal,0,2);   //  2 PoËiatoËn˝ stav platobnÈho prostriedku
  mActVal := 0;
  For I:=0 to 9 do
    mActVal := mActVal+gEcsGlob.PayVals[I].TrnVal;
  mW.SetReal (mACtVal,0,2);   //  3 Trûba
  mActVal := 0;
  For I:=0 to 9 do
    mActVal := mActVal+gEcsGlob.PayVals[I].ExpVal;
  mW.SetReal (mActVal,0,2);   //  4 Odvod trûby
  mActVal := 0;
  For I:=0 to 9 do
    mActVal := mActVal+gEcsGlob.PayVals[I].EndVal;
  mW.SetReal (mActVal,0,2);   //  5 KoneËn˝ stav platidla
  mActVal := 0;
  mW.SetReal (mActVal,0,2); //  6 Nevr·tenÈ preplatky hotovosti
  mActVal := 0;
  For I:=0 to 9 do
    mActVal := mActVal+gEcsGlob.PayVals[I].ChIVal;
  mW.SetReal (mActVal,0,2);   //  7 Zmena platidla - prÌjem
  mActVal := 0;
  For I:=0 to 9 do
    mActVal := mActVal+gEcsGlob.PayVals[I].ChOVal;
  mW.SetReal (mActVal,0,2);   //  8 Zmena platidla - v˝daj
  mActVal := 0;
  For I:=0 to 9 do
    mActVal := mActVal+gEcsGlob.PayVals[I].IncVal;
  mW.SetReal (mActVal,0,2);   //  9 PrÌjem hotovosti do pokladne
  mActVal := 0;
  For I:=0 to 9 do
    mActVal := mActVal+gEcsGlob.PayVals[I].PaidAdv;
  mW.SetReal (mActVal,0,2);  // 10 Zaplaten· z·loha
  mActVal := 0;
  For I:=0 to 9 do
    mActVal := mActVal+gEcsGlob.PayVals[I].UsedAdv;
  mW.SetReal (mActVal,0,2);  // 11 »erpan· z·loha
  mActVal := 0;
  mW.SetReal (mActVal,0,2); // 12 PrÌjem hotovosti do FM
  oList.Add (mW.GetWrapText);
  mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);

  mW.ClearWrap;
  mW.SetText ('PC',0);        //  1 KontrolnÈ ËÌslo - oznaËenie riadku
  mW.SetNum  (mCheckSum,0);   //  2 Kontrolne cislo
  oList.Add (mW.GetWrapText);
  Save;
  FreeAndNil (mW);
end;

procedure TTFileHnd.SaveIncDoc;
var mW:TTxtWrap; I,mCheckSum:longint; mIncVal:double;
begin
  Inc(gEcsGlob.IncDocQnt);
  oList.Clear;
  mIncVal := 0;
  For I:=0 to 9 do
    mIncVal := mIncVal+uPaysTbl[I];
  mW := TTxtWrap.Create;
  mCheckSum := 0;
  mW.ClearWrap;
  mW.SetText ('IB',0);                 //  1 HlaviËka prÌjmu hotovosti do pokladne
  mW.SetNum  (cWriNum,0);              //  2 »Ìslo prev·dzkovej jednotky
  mW.SetNum  (cCasNum,0);              //  3 »Ìslo pokladne
  mW.SetNum  (gEcsGlob.IntDocNum,0);   //  4 InternÈ ËÌslo pokladniËnÈho dokladu
  mW.SetDate (gBlkHead.BlkDate);       //  5 D·tum vyhotovenie dokladu
  mW.SetTime (gBlkHead.BlkTime);       //  6 »as vyhotovenia dokladu
  mW.SetReal (mIncVal,0,2);            //  7 Hodnota prijÌmanej hotovosti
  mW.SetText (oLoginName,0);           //  8 Prihlasovacie meno pokladnÌka
  mW.SetText (oUserName,0);            //  9 Meno a prezvisko pokladnÌka
  mW.SetDate (gBlkHead.BlkDate);       // 10 Aktu·lny fiök·lny d·tum
  mW.SetNum  (oPrpsCode,0);            // 11 Pri zmene platidla je -1
  mW.SetText (gEcsGlob.eKasaDocNum,0); // 12. »Ìslo dokladu z CHDU
  oList.Add (mW.GetWrapText);
  mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);

  For I:=0 to 9 do begin
    If IsNotNul (uPaysTbl[I]) then begin
      mW.ClearWrap;
      mW.SetText ('IP',0);                   //  1 PrÌjem podæa platidiel
      mW.SetNum  (I,0);                      //  2 »Ìslo platobnÈho prostriedku
      mW.SetText (gEcsGlob.PayVals[I].Name,0); //  3 N·zov platobnÈho prostriedku
      mW.SetReal (uPaysTbl[I],0,2);   //  4 Prijat· hodnota
      oList.Add (mW.GetWrapText);
      mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);
    end;
  end;

  mW.ClearWrap;
  mW.SetText ('IC',0);        //  1 KontrolnÈ ËÌslo - oznaËenie riadku
  mW.SetNum  (mCheckSum,0);   //  2 Kontrolne cislo
  oList.Add (mW.GetWrapText);
  Save;
  FreeAndNil (mW);
  If oPrpsCode=-1 then begin
    For I:=0 to 9 do begin
      gEcsGlob.PayVals[I].ChIVal:=gEcsGlob.PayVals[I].ChIVal+uPaysTbl[I];
      CalcPayEndVal (I);
    end;
  end else begin
    For I:=0 to 9 do begin
      gEcsGlob.PayVals[I].IncVal:=gEcsGlob.PayVals[I].IncVal+uPaysTbl[I];
      CalcPayEndVal (I);
    end;
  end;
end;

procedure TTFileHnd.SaveExpDoc;
var mW:TTxtWrap; I,mCheckSum:longint; mExpVal:double;
begin
  Inc(gEcsGlob.DecDocQnt);
  oList.Clear;
  mW := TTxtWrap.Create;
  mExpVal := 0;
  For I:=0 to 9 do
    mExpVal := mExpVal+uPaysTbl[I];
  mCheckSum := 0;
  mW.ClearWrap;
  mW.SetText ('OB',0);            //  1 HlaviËka odvodu trûby
  mW.SetNum  (cWriNum,0);         //  2 »Ìslo prev·dzkovej jednotky
  mW.SetNum  (cCasNum,0);         //  3 »Ìslo pokladne
  mW.SetNum  (gEcsGlob.IntDocNum,0); //  4 InternÈ ËÌslo pokladniËnÈho dokladu
  mW.SetDate (gBlkHead.BlkDate);  //  5 D·tum vyhotovenie dokladu
  mW.SetTime (gBlkHead.BlkTime);  //  6 »as vyhotovenia dokladu
  mW.SetReal (mExpVal,0,2);       //  7 Aktu·lny stav vöetk˝ch platidiel kumlatÌvne
  mW.SetText (oLoginName,0);      //  8 Prihlasovacie meno pokladnÌka
  mW.SetText (oUserName,0);       //  9 Meno a prezvisko pokladnÌka
  mW.SetNum  (oPrpsCode,0);       // 10 KÛd ˙Ëelu odvodu
  mW.SetText (oPrpsName,0);       // 11 N·zov ˙Ëelu odvodu
  mW.SetDate (gBlkHead.BlkDate);  // 12 Aktu·lny fiök·lny d·tum
  mW.SetText (gEcsGlob.eKasaDocNum,0);  // 13. »Ìslo dokladu z CHDU
  oList.Add (mW.GetWrapText);
  mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);

  For I:=0 to 9 do begin
    If IsNotNul (uPaysTbl[I]) then begin
      mW.ClearWrap;
      mW.SetText ('OP',0);                   //  1 Odvod trûby podla platidiel
      mW.SetNum  (I,0);                      //  2 »Ìslo platobnÈho prostriedku
      mW.SetText (gEcsGlob.PayVals[I].Name,0);    //  3 N·zov platobnÈho prostriedku
      mW.SetReal (uPaysTbl[I],0,2);   //  4 Vydan· hodnota
      oList.Add (mW.GetWrapText);
      mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);
    end;
  end;
  mW.ClearWrap;
  mW.SetText ('OC',0);        //  1 KontrolnÈ ËÌslo - oznaËenie riadku
  mW.SetNum  (mCheckSum,0);   //  2 Kontrolne cislo
  oList.Add (mW.GetWrapText);
  Save;
  FreeAndNil (mW);
  If oPrpsCode=-1 then begin
    For I:=0 to 9 do begin
      gEcsGlob.PayVals[I].ChOVal:=gEcsGlob.PayVals[I].ChOVal+uPaysTbl[I];
      CalcPayEndVal (I);
    end;
  end else begin
    For I:=0 to 9 do begin
      gEcsGlob.PayVals[I].ExpVal:=gEcsGlob.PayVals[I].ExpVal+uPaysTbl[I];
      CalcPayEndVal (I);
    end;
  end;
end;

procedure TTFileHnd.SaveCoins(pLst:string);
var mW:TTxtWrap; mCnt,I,mCheckSum:longint; mVal:double; mC,mQ,mV:array[1..30] of double; mS:string;
begin
  oList.Clear;
  mW:=TTxtWrap.Create;
  mVal:=0;
  mCnt:=0;
  While pLst<>'' do begin
    If Pos(';',pLst)>0 then begin
      mS:=Copy(pLst,1,Pos(';',pLst)-1);
      Delete(pLst,1,Pos(';',pLst));
    end else begin
      mS:=pLst;
      pLst:='';
    end;
    Inc(mCnt);
    mC[mCnt]:=ValDoub(LineElement(mS,0,'*'));
    mQ[mCnt]:=ValInt(LineElement(mS,1,'*'));
    mV[mCnt]:=mC[mCnt]*mQ[mCnt];
    mVal:=mVal+mV[mCnt];
  end;
  If mCnt>0 then begin
    mCheckSum := 0;
    mW.ClearWrap;
    mW.SetText ('NB',0);            //  1 HlaviËka mincovky
    mW.SetNum  (cWriNum,0);         //  2 »Ìslo prev·dzkovej jednotky
    mW.SetNum  (cCasNum,0);         //  3 »Ìslo pokladne
    mW.SetNum  (gEcsGlob.IntDocNum,0); //  4 InternÈ ËÌslo pokladniËnÈho dokladu
    mW.SetDate (gBlkHead.BlkDate);  //  5 D·tum vyhotovenie dokladu
    mW.SetTime (gBlkHead.BlkDate);  //  6 »as vyhotovenia dokladu
    mW.SetReal (mVal,0,2);          //  7 Hodnota mincovky
    mW.SetText (oLoginName,0);      //  8 Prihlasovacie meno pokladnÌka
    mW.SetText (oUserName,0);       //  9 Meno a prezvisko pokladnÌka
    oList.Add (mW.GetWrapText);
    mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);
    For I:=1 to mCnt do begin
      mW.ClearWrap;
      mW.SetText ('NI',0);                                 //  1 Poloûkamincovky
      mW.SetReal (mC[I],0,2); //  2 Nomin·lna hodnota
      mW.SetReal (mQ[I],0,0); //  3 PoËet
      mW.SetReal (mV[I],0,2); //  4 Hodnota
      oList.Add (mW.GetWrapText);
      mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);
    end;

    mW.ClearWrap;
    mW.SetText ('NC',0);        //  1 KontrolnÈ ËÌslo - oznaËenie riadku
    mW.SetNum  (mCheckSum,0);   //  2 Kontrolne cislo
    oList.Add (mW.GetWrapText);
    Save;
    FreeAndNil (mW);
  end;
end;

procedure TTFileHnd.SaveClsDoc(pType:string);
var mW:TTxtWrap; mCheckSum, I, mClsNum:longint; mBValue:double;
begin
  mBValue := 0;
  For I:=1 to 5 do
    mBValue := mBValue+gEcsGlob.BValue[I];
  mClsNum:=0;
  If pType='X' then mClsNum:=gEcsGlob.XClsNum;
  If pType='D' then mClsNum:=gEcsGlob.DClsNum;
  oList.Clear;
  mW := TTxtWrap.Create;
  mCheckSum := 0;
  mW.ClearWrap;
  mW.SetText (pType+'B',0);        //  1 HlaviËka uz·vierky: A - informaËn· (actual)  X - smeny, D - denn·
  mW.SetNum  (cWriNum,0);          //  2 »Ìslo prev·dzkovej jednotky
  mW.SetNum  (cCasNum,0);          //  3 »Ìslo pokladne
  mW.SetNum  (gEcsGlob.IntDocNum,0); //  4 InternÈ ËÌslo pokladniËnÈho dokladu
  mW.SetDate (gBlkHead.BlkDate);   //  5 D·tum vyhotovenie dokladu
  mW.SetTime (gBlkHead.BlkTime);   //  6 »as vyhotovenia dokladu
  mW.SetNum  (mClsNum,0);          //  7 »Ìslo uz·vierky
  mW.SetNum  (gEcsGlob.DDocQnt,0); //  8 PoËet dokladov od poslednej dennej uz·vierky
  mW.SetNum  (0,0);                //  9 PoËet dokladov od poslednej mesaËnej uz·vierky
  mW.SetReal (mBValue, 0, 2);      // 10 Celkov˝ obrat doplnevÈ od verzie 20.24
  mW.SetNum  (0,0);                // 11 PoËet dokladov od poslednej uz·vierky smeny
  mW.SetNum  (0,0);               // 12 NepouûÌva sa
  mW.SetText (oLoginName,0);      // 13 Prihlasovacie meno pokladnÌka
  mW.SetText (oUserName,0);       // 14 Meno a prezvisko pokladnÌka
  oList.Add (mW.GetWrapText);
  mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);

  mW.ClearWrap;
  mW.SetText (pType+'I',0);       //  1 Poloûka
  mW.SetNum  (1,0);               //  2 PoradovÈ ËÌslo 1
  mW.SetReal (gEcsGlob.RndH,0,2);//  3 Zaokr˙hlenie cez PPEKK
  oList.Add (mW.GetWrapText);
  mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);

  mW.ClearWrap;
  mW.SetText (pType+'I',0);       //  1 Poloûka
  mW.SetNum (2,0) ;               //  2 PoradovÈ ËÌslo 2
  mW.SetReal (gEcsGlob.RndI_P,0,2); //  3 Kladn· hodnota zaokr˙lenia pomocou poloûiek
  oList.Add (mW.GetWrapText);
  mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);

  mW.ClearWrap;
  mW.SetText (pType+'I',0);       //  1 Poloûka
  mW.SetNum (3,0);                //  2 PoradovÈ ËÌslo 3
  mW.SetReal(gEcsGlob.RndI_N,0,2); //  3 3 Z·porn· hodnota zaokr˙lenia pomocou poloûiek
  oList.Add (mW.GetWrapText);
  mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);

  mW.ClearWrap;
  mW.SetText (pType+'I',0);           //  1 Poloûka
  mW.SetNum  (4,0);                   //  2 PoradovÈ ËÌslo 4
  mW.SetReal (gEcsGlob.BValue[1],0,2); //  3 Obrat skupiny DPH1
  mW.SetReal (gEcsGlob.VatVal[1],0,2); //  4 Hodnota DPH1
  mW.SetNum  (gEcsGlob.VatPrc[1],0);   //  5 Sadzba DPH1
  oList.Add (mW.GetWrapText);
  mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);

  mW.ClearWrap;
  mW.SetText (pType+'I',0);           //  1 Poloûka
  mW.SetNum  (5,0);                   //  2 PoradovÈ ËÌslo 5
  mW.SetReal (gEcsGlob.BValue[2],0,2); //  3 Obrat skupiny DPH2
  mW.SetReal (gEcsGlob.VatVal[2],0,2); //  4 Hodnota DPH2
  mW.SetNum  (gEcsGlob.VatPrc[2],0);   //  5 Sadzba DPH2
  oList.Add (mW.GetWrapText);
  mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);

  mW.ClearWrap;
  mW.SetText (pType+'I',0);           //  1 Poloûka
  mW.SetNum  (6,0);                   //  2 PoradovÈ ËÌslo 6
  mW.SetReal (gEcsGlob.BValue[3],0,2); //  3 Obrat skupiny DPH3
  mW.SetReal (gEcsGlob.VatVal[3],0,2); //  4 Hodnota DPH3
  mW.SetNum  (gEcsGlob.VatPrc[3],0);   //  5 Sadzba DPH3
  oList.Add (mW.GetWrapText);
  mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);

  mW.ClearWrap;
  mW.SetText (pType+'I',0);        //  1 Poloûka
  mW.SetNum (7,0);                 //  2 PoradovÈ ËÌslo 7
  mW.SetReal (gEcsGlob.ClmVal,0,2); //  3 Hodnota storien
  oList.Add (mW.GetWrapText);
  mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);

  mW.ClearWrap;
  mW.SetText (pType+'I',0);        //  1 Poloûka
  mW.SetNum (8,0);                 //  2 PoradovÈ ËÌslo 8
  mW.SetReal (gEcsGlob.AdvVal,0,2); //  3 Hodnota z·porn˝ch z·loh
  oList.Add (mW.GetWrapText);
  mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);

  mW.ClearWrap;
  mW.SetText (pType+'I',0);        //  1 Poloûka
  mW.SetNum (9,0);                 //  2 PoradovÈ ËÌslo 9

  mW.SetNum (gEcsGlob.DDocQnt,0);   //  3 PoËet dokladov od poslednej uz·vierky
  mW.SetNum (gEcsGlob.ClmItmQnt,0);    //  4 PoËet storno dokladov od poslednej uz·vierky
  mW.SetNum (gEcsGlob.DscItmQnt,0);    //  5 PoËet zæavnen˝ch dokladov od poslednej uz·vierky
  mW.SetNum (gEcsGlob.NegItmQnt,0);    //  6 PoËet z·porn˝ch dokladov od poslednej uz·vierky
  mW.SetNum (gEcsGlob.AdvItmQnt,0);    //  7 PoËet pouûit˝ch z·loh od posledne  uz·vierky
  mW.SetNum (gEcsGlob.SalDocQnt,0);//  8 PoËet pokladniËn˝ch dokladov od poslednej uz·vierky
  mW.SetNum (gEcsGlob.IncDocQnt,0); //  9 PoËet vkladov˝ch dokladov od poslednej uz·vierky
  mW.SetNum (gEcsGlob.DecDocQnt,0); // 10 PoËet v˝berov˝ch dokladov od poslednej uz·vierky
  mW.SetNum (gEcsGlob.ICDocQnt,0);  // 11 PoËet ˙hrda FA od poslednej uz·vierky
  oList.Add (mW.GetWrapText);
  mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);

  mW.ClearWrap;
  mW.SetText (pType+'I',0);        //  1 Poloûka
  mW.SetNum (10,0);                //  2 PoradovÈ ËÌslo 10
  mW.SetReal (gEcsGlob.DscVal,0,2); //  3 Hodnota zliav
  oList.Add (mW.GetWrapText);
  mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);

  mW.ClearWrap;
  mW.SetText (pType+'I',0);        //  1 Poloûka
  mW.SetNum (11,0);                //  2 PoradovÈ ËÌslo 11
  mW.SetReal (gEcsGlob.NegVal,0,2); //  3 Hodnota vr·tenÈho obalu
  oList.Add (mW.GetWrapText);
  mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);

  mW.ClearWrap;
  mW.SetText (pType+'I',0);        //  1 Poloûka
  mW.SetNum (12,0);                //  2 PoradovÈ ËÌslo 12
  mW.SetReal (gEcsGlob.ICDocPay,0,2); //  3 ⁄hrada fakt˙r
  oList.Add (mW.GetWrapText);
  mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);

  mW.ClearWrap;
  mW.SetText (pType+'I',0);           //  1 Poloûka
  mW.SetNum  (13,0);                  //  2 PoradovÈ ËÌslo 13
  mW.SetReal (gEcsGlob.BValue[4],0,2); //  3 Obrat skupiny DPH4
  mW.SetReal (gEcsGlob.VatVal[4],0,2); //  4 Hodnota DPH4
  mW.SetNum  (gEcsGlob.VatPrc[4],0);   //  5 Sadzba DPH4
  oList.Add (mW.GetWrapText);
  mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);

  mW.ClearWrap;
  mW.SetText (pType+'I',0);           //  1 Poloûka
  mW.SetNum  (14,0);                  //  2 PoradovÈ ËÌslo 14
  mW.SetReal (gEcsGlob.BValue[5],0,2); //  3 Obrat skupiny DPH5
  mW.SetReal (gEcsGlob.VatVal[5],0,2); //  4 Hodnota DPH5
  mW.SetNum  (gEcsGlob.VatPrc[5],0);   //  5 Sadzba DPH5
  oList.Add (mW.GetWrapText);
  mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);

  For I:=0 to 9 do begin
    mW.ClearWrap;
    mW.SetText (pType+'I',0);           //  1 Poloûka
    mW.SetNum  (15+I,0);                //  2 PoradovÈ ËÌslo 15-24
    mW.SetNum  (I, 0);                  //  3 »Ìslo platidla
    mW.SetText (gEcsGlob.PayVals[I].Name, 0);   //  4 N·zov platidla
    mW.SetReal (gEcsGlob.PayVals[I].IncVal, 0, 2); //  5 Vklad - pre vybranÈ platidlo
    mW.SetReal (gEcsGlob.PayVals[I].ExpVal, 0, 2); //  6 V˝ber - pre vybranÈ platidlo
    mW.SetReal (gEcsGlob.PayVals[I].TrnVal, 0, 2); //  7 Obrat - pre vybranÈ platidlo
    oList.Add (mW.GetWrapText);
    mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);
  end;

  mW.ClearWrap;
  mW.SetText (pType+'C',0);   //  1 KontrolnÈ ËÌslo - oznaËenie riadku
  mW.SetNum  (mCheckSum,0);   //  2 Kontrolne cislo
  oList.Add (mW.GetWrapText);
  Save;
  FreeAndNil (mW);
end;

procedure TTFileHnd.SaveMClsDoc;
var mW:TTxtWrap; mCheckSum, I:longint; mBValue:double;
begin
  mBValue := 0;
  For I:=1 to 5 do
    mBValue := mBValue+gClsData.BValue[I];
  oList.Clear;
  mW := TTxtWrap.Create;
  mCheckSum := 0;
  mW.ClearWrap;
  mW.SetText ('MB',0);       //  1 HlaviËka uz·vierky: A - informaËn· (actual)  X - smeny, D - denn·, M - mesaËn·
  mW.SetNum  (cWriNum,0);         //  2 »Ìslo prev·dzkovej jednotky
  mW.SetNum  (cCasNum,0);         //  3 »Ìslo pokladne
  mW.SetNum  (gEcsGlob.IntDocNum,0); //  4 InternÈ ËÌslo pokladniËnÈho dokladu
  mW.SetDate (gBlkHead.BlkDate);  //  5 D·tum vyhotovenie dokladu
  mW.SetTime (gBlkHead.BlkTime);  //  6 »as vyhotovenia dokladu
  mW.SetNum  (0,0);            //  7 »Ìslo uz·vierky
  mW.SetNum  (0,0);            //  8 PoËet dokladov od poslednej dennej uz·vierky
  mW.SetNum  (0,0);            //  9 PoËet dokladov od poslednej mesaËnej uz·vierky
  mW.SetReal (mBValue, 0, 2);  // 10 Celkov˝ obrat doplnevÈ od verzie 20.24
  mW.SetNum  (0,0);            // 11 PoËet dokladov od poslednej uz·vierky smeny
  mW.SetNum  (0,0);            // 12 NepouûÌva sa
  mW.SetText (oLoginName,0);      // 13 Prihlasovacie meno pokladnÌka
  mW.SetText (oUserName,0);       // 14 Meno a prezvisko pokladnÌka
  oList.Add (mW.GetWrapText);
  mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);

  mW.ClearWrap;
  mW.SetText ('MI',0);       //  1 Poloûka
  mW.SetNum  (1,0);               //  2 PoradovÈ ËÌslo 1
  mW.SetReal (gClsData.RndH,0,2); //  3 Zaokr˙hlenie cez PPEKK
  oList.Add (mW.GetWrapText);
  mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);

  mW.ClearWrap;
  mW.SetText ('MI',0);       //  1 Poloûka
  mW.SetNum (2,0) ;               //  2 PoradovÈ ËÌslo 2
  mW.SetReal(gClsData.RndI_P,0,2); //  3 Kladn· hodnota zaokr˙hlenia pomocou poloûiek
  oList.Add (mW.GetWrapText);
  mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);

  mW.ClearWrap;
  mW.SetText ('MI',0);       //  1 Poloûka
  mW.SetNum (3,0);                //  2 PoradovÈ ËÌslo 3
  mW.SetReal(gClsData.RndI_N,0,2); //  3 Z·porn· hodnota zaokr˙hlenia pomocou poloûiek
  oList.Add (mW.GetWrapText);
  mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);

  mW.ClearWrap;
  mW.SetText ('MI',0);           //  1 Poloûka
  mW.SetNum  (4,0);                   //  2 PoradovÈ ËÌslo 4
  mW.SetReal (gClsData.BValue[1],0,2); //  3 Obrat skupiny DPH1
  mW.SetReal (gClsData.VatVal[1],0,2); //  4 Hodnota DPH1
  mW.SetNum  (gClsData.VatPrc[1],0);   //  5 Sadzba DPH1
  oList.Add (mW.GetWrapText);
  mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);

  mW.ClearWrap;
  mW.SetText ('MI',0);           //  1 Poloûka
  mW.SetNum  (5,0);                   //  2 PoradovÈ ËÌslo 5
  mW.SetReal (gClsData.BValue[2],0,2); //  3 Obrat skupiny DPH2
  mW.SetReal (gClsData.VatVal[2],0,2); //  4 Hodnota DPH2
  mW.SetNum  (gClsData.VatPrc[2],0);   //  5 Sadzba DPH2
  oList.Add (mW.GetWrapText);
  mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);

  mW.ClearWrap;
  mW.SetText ('MI',0);           //  1 Poloûka
  mW.SetNum  (6,0);                   //  2 PoradovÈ ËÌslo 6
  mW.SetReal (gClsData.BValue[3],0,2); //  3 Obrat skupiny DPH3
  mW.SetReal (gClsData.VatVal[3],0,2); //  4 Hodnota DPH3
  mW.SetNum  (gClsData.VatPrc[3],0);   //  5 Sadzba DPH3
  oList.Add (mW.GetWrapText);
  mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);

  mW.ClearWrap;
  mW.SetText ('MI',0);        //  1 Poloûka
  mW.SetNum (7,0);                 //  2 PoradovÈ ËÌslo 7
  mW.SetReal (gClsData.ClmVal,0,2); //  3 Hodnota storien
  oList.Add (mW.GetWrapText);
  mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);

  mW.ClearWrap;
  mW.SetText ('MI',0);        //  1 Poloûka
  mW.SetNum (8,0);                 //  2 PoradovÈ ËÌslo 8
  mW.SetReal (gClsData.AdvVal,0,2); //  3 Hodnota pouûit˝ch z·loh
  oList.Add (mW.GetWrapText);
  mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);

  mW.ClearWrap;
  mW.SetText ('MI',0);        //  1 Poloûka
  mW.SetNum (9,0);                 //  2 PoradovÈ ËÌslo 9
(*  mW.SetNum (gCasClsVals.DocQnt,0);    //  3 PoËet dokladov od poslednej uz·vierky
  mW.SetNum (gCasClsVals.ClmQnt,0);    //  4 PoËet storno dokladov od poslednej uz·vierky
  mW.SetNum (gCasClsVals.DscQnt,0);    //  5 PoËet zæavnen˝ch dokladov od poslednej uz·vierky
  mW.SetNum (gCasClsVals.NegQnt,0);    //  6 PoËet z·porn˝ch dokladov od poslednej uz·vierky
  mW.SetNum (gCasClsVals.RetQnt,0);    //  7 PoËet dokladov s vr·ten˝mi poloûkami od poslednej uz·vierky
  mW.SetNum (gCasClsVals.SaleQnt,0);   //  8 PoËet pokladniËn˝ch dokladov od poslednej uz·vierky
  mW.SetNum (gCasClsVals.IncQnt,0);    //  9 PoËet vkladov˝ch dokladov od poslednej uz·vierky
  mW.SetNum (gCasClsVals.DecQnt,0);    // 10 PoËet v˝berov˝ch dokladov od poslednej uz·vierky
  mW.SetNum (gCasClsVals.ICPayQnt,0);  // 11 PoËet ˙hrda FA od poslednej uz·vierky*)
  oList.Add (mW.GetWrapText);
  mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);

  mW.ClearWrap;
  mW.SetText ('MI',0);        //  1 Poloûka
  mW.SetNum (10,0);                //  2 PoradovÈ ËÌslo 10
  mW.SetReal (gClsData.DscVal,0,2); //  3 Hodnota zliav
  oList.Add (mW.GetWrapText);
  mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);

  mW.ClearWrap;
  mW.SetText ('MI',0);        //  1 Poloûka
  mW.SetNum (11,0);                //  2 PoradovÈ ËÌslo 11
  mW.SetReal (gClsData.NegVal,0,2); //  3 Hodnota vr·tenÈho obalu
  oList.Add (mW.GetWrapText);
  mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);

  mW.ClearWrap;
  mW.SetText ('MI',0);        //  1 Poloûka
  mW.SetNum (12,0);                //  2 PoradovÈ ËÌslo 12
  mW.SetReal (gClsData.ICDocPay,0,2); //  3 ⁄hrada fakt˙r
  oList.Add (mW.GetWrapText);
  mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);

  mW.ClearWrap;
  mW.SetText ('MI',0);           //  1 Poloûka
  mW.SetNum  (13,0);                  //  2 PoradovÈ ËÌslo 13
  mW.SetReal (gClsData.BValue[4],0,2); //  3 Obrat skupiny DPH4
  mW.SetReal (gClsData.VatVal[4],0,2); //  4 Hodnota DPH4
  mW.SetNum  (gClsData.VatPrc[4],0);   //  5 Sadzba DPH4
  oList.Add (mW.GetWrapText);
  mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);

  mW.ClearWrap;
  mW.SetText ('MI',0);           //  1 Poloûka
  mW.SetNum  (14,0);                  //  2 PoradovÈ ËÌslo 14
  mW.SetReal (gClsData.BValue[5],0,2); //  3 Obrat skupiny DPH5
  mW.SetReal (gClsData.VatVal[5],0,2); //  4 Hodnota DPH5
  mW.SetNum  (gClsData.VatPrc[5],0);   //  5 Sadzba DPH5
  oList.Add (mW.GetWrapText);
  mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);

  For I:=0 to 9 do begin
    mW.ClearWrap;
    mW.SetText ('MI',0);           //  1 Poloûka
    mW.SetNum  (15+I,0);                //  2 PoradovÈ ËÌslo 15-24
    mW.SetNum  (I, 0);                  //  3 »Ìslo platidla
    mW.SetText (gEcsGlob.PayVals[I].Name, 0);   //  4 N·zov platidla
    mW.SetReal (gClsData.PayVals[I].IncVal, 0, 2); //  5 Vklad - pre vybranÈ platidlo
    mW.SetReal (gClsData.PayVals[I].ExpVal, 0, 2); //  6 V˝ber - pre vybranÈ platidlo
    mW.SetReal (gClsData.PayVals[I].TrnVal, 0, 2); //  7 Obrat - pre vybranÈ platidlo
    oList.Add (mW.GetWrapText);
    mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);
  end;

  mW.ClearWrap;
  mW.SetText ('MC',0);   //  1 KontrolnÈ ËÌslo - oznaËenie riadku
  mW.SetNum  (mCheckSum,0);   //  2 Kontrolne cislo
  oList.Add (mW.GetWrapText);
  Save;
  FreeAndNil (mW);
end;

procedure TTFileHnd.SaveICDocPay;
var mW:TTxtWrap; I,mCheckSum:longint;
begin
  Inc(gEcsGlob.ICDocQnt);
  oList.Clear;
  mW := TTxtWrap.Create;
  mCheckSum := 0;
  mW.ClearWrap;
  mW.SetText ('RB', 0);            //  1 HlaviËka dokladu o uhradenÌ fakt˙ry
  mW.SetNum  (cWriNum, 0);         //  2 »Ìslo prev·dzkovej jednotky
  mW.SetNum  (cCasNum, 0);         //  3 »Ìslo pokladne
  mW.SetNum  (gEcsGlob.IntDocNum, 0); //  4 InternÈ ËÌslo pokladniËnÈho dokladu
  mW.SetDate (gBlkHead.BlkDate);   //  5 D·tum vyhotovenie dokladu
  mW.SetTime (gBlkHead.BlkTime);   //  6 »as vyhotovenia dokladu
  mW.SetNum  (gEcsGlob.DDocNum,0);   // 7 »Ìslo pokladniËnÈho dokladu od poslednej dennej uz·vierky
  mW.SetText (gBlkHead.ExtDocNum, 0); // 8 »Ìslo fakt˙ry
  mW.SetReal (gBlkHead.BValue, 0, 2); // 9 Zaplaten· hodnota fakt˙ry
  mW.SetText (uNoteLst[1],0);       // 10 Pozn·mka k fakt˙re 1
  mW.SetText (uNoteLst[2],0);       // 11 Pozn·mka k fakt˙re 2
  mW.SetText (uNoteLst[3],0);       // 12 Pozn·mka k fakt˙re 3
  mW.SetText (uNoteLst[4],0);       // 13 Pozn·mka k fakt˙re 4
  mW.SetText (oLoginName, 0);      // 14 Prihlasovacie meno pokladnÌka
  mW.SetText (oUserName, 0);       // 15 Meno a prezvisko pokladnÌka
  mW.SetDate (gBlkHead.BlkDate);  // 16 Aktu·lny fiök·lny d·tum
  mW.SetText('0', 0);              // 17 »i je extern˝ doklad - 1 ·no, 0 - nie
  mW.SetText  (gBlkHead.UID,0);   // 18 UID
  mW.SetText (gEcsGlob.eKasaDocNum,0);  // 19. »Ìslo dokladu z CHDU
  mW.SetText (gBlkHead.IntDocNum, 0); // 20. InternÈ ËÌslo fakt˙ry
  oList.Add (mW.GetWrapText);
  mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);

  For I:= 0 to 9 do begin
    If IsNotNul (uPaysTbl[I]) then begin
      mW.ClearWrap;
      mW.SetText ('RP', 0);                // 1 Zoznam platidiel
      mW.SetNum (I, 0);                    // 2 »Ìslo platidla
      mW.SetText (gEcsGlob.PayVals[I].Name, 0); // 3 N·zov platidla
      mW.SetReal (uPaysTbl[I], 0, 2);// 4 Zaplaten· hodnota
      oList.Add (mW.GetWrapText);
      mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);
    end;
  end;

  mW.ClearWrap;
  mW.SetText ('RC',0);        //  1 KontrolnÈ ËÌslo - oznaËenie riadku
  mW.SetNum  (mCheckSum,0);   //  2 Kontrolne cislo
  oList.Add (mW.GetWrapText);
  Save;
  FreeAndNil (mW);
end;

procedure TTFileHnd.SaveSalDoc;
var mW:TTxtWrap; I,mCheckSum:longint; mPayID, mS, mSub:string; mQnt:longint; mPrice, mVal:double;
    mRndH, mRndI:double;
begin
  oList.Clear;
  mW := TTxtWrap.Create;
  mCheckSum := 0;
  mW.ClearWrap;
  mW.SetText ('SB',0);               //  1 HlaviËka pokladniËnÈho dokladu
  mW.SetNum  (cWriNum,0);            //  2 »Ìslo prev·dzkovej jednotky
  mW.SetNum  (cCasNum,0);            //  3 »Ìslo pokladne
  mW.SetNum  (gEcsGlob.IntDocNum,0); //  4 InternÈ ËÌslo pokladniËnÈho dokladu
  mW.SetDate (gBlkHead.BlkDate);     //  5 D·tum vyhotovenie dokladu
  mW.SetTime (gBlkHead.BlkTime);     //  6 »as vyhotovenia dokladu
  mW.SetNum  (gBlkItemQnt,0);        //  7 PoËet poloûiek na pokladniËnom doklade
  mW.SetText (gBlkHead.CusCardNum,0); //  8 IdentifikaËn˝ kÛd z·kaznÌckej karty
  mW.SetText (oLoginName,0);         //  9 Prihlasovacie meno pokladnÌka
  mW.SetNum  (gEcsGlob.DDocNum,0);   // 10 »Ìslo pokladniËnÈho dokladu od poslednej dennej uz·vierky
  mW.SetText (gBlkHead.PaINO,0);     // 11 I»O firmy
  mW.SetText (gEcsGlob.eKasaDocNum,0); // 12 »Ìslo pokladniËnÈho dokladu z CHDU
  mW.SetText (oUserName,0);          // 13 Meno a prezvisko pokladnÌka
  mW.SetDate (gBlkHead.BlkDate);     // 14 D·tum fiök·lneho dÚa
  mW.SetReal (gBlkHead.BValue,0,2);    // 15 Hodnota pokladniËnej ˙Ëtenky
  mW.SetText ('',0);                  // 16 Typ dokladu: pokladniËn˝ doklad/ ˙hrada FA
  mW.SetText ('',0);                  // 17 IdentifikaËnÈ ËÌslo reklamovanÈho pokladniËnÈho dokladu
  mW.SetText ('',0);                  // 18 D·tum vystavenia reklamovanÈho pokladniËnÈho dokladu
  mW.SetText ('', 0);                 // 19 OznaËenie miestnosti
  mW.SetText ('', 0);                 // 20 N·zov miestnosti
  mW.SetText ('', 0);                 // 21 »Ìslo stola
  mW.SetText ('', 0);                 // 22 »Ìslo hosùa
  mW.SetText ('0', 0);                // 23 »i je extern˝ doklad - 1 ·no, 0 - nie
  mW.SetText ('', 0);                 // 24 OznaËenie stola
  mW.SetNum  (gBlkHead.PaCode,0);     // 25 KÛd firmy
  mW.SetText (gBlkHead.PaName,0);     // 26 N·zov firmy
  mW.SetText (gBlkHead.CusName,0);    // 27 Meno z·kaznÌka
  mW.SetText (gBlkHead.UID,0);        // 28 UID

  mRndH := 0; mRndI := 0;
  If cCashRndSave=0
    then mRndH := gBlkHead.RndVal
    else mRndI := gBlkHead.RndVal;
  mW.SetReal (mRndH,0,2);            // 29 Hodnota zaokr˙hlenie z PPEKK
  mW.SetReal (mRndI,0,2);            // 30 Hodnota zaokr˙hlenie z poloûiek

  mW.SetText (gBlkHead.PaTIN,0);      // 31 (29) DI»
  mW.SetText (gBlkHead.PaVIN,0);      // 32 (30) I» DPH
  mW.SetText (gBlkHead.IntDocNum,0);  // 33 (31) InternÈ ËÌslo vy˙ËtovanÈho dokladu
  mW.SetText (gBlkHead.ExtDocNum,0);  // 34 (32) ExternÈ ËÌslo vy˙ËtovanÈho dokladu

  oList.Add (mW.GetWrapText);
  mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);

  For I:=1 to gBlkItemQnt do begin
    mW.ClearWrap;
    mW.SetText ('SI',0);                                    //  1 Poloûka pokladniËnej ˙Ëtenky
    mW.SetText(gBlkItems[I].GsName,0);  //  2 N·zov tovaru
    mW.SetNum (gBlkItems[I].MGCode,0); //  3 »Ìslo tovarovej skupiny
    mW.SetNum (gBlkItems[I].GSCode,0); //  4 TovarovÈ ËÌslo
    mW.SetReal(gBlkItems[I].Qnt,0,3);    //  5 PredanÈ moûstvo
    mW.SetNum (gBlkItems[I].VatPrc,0); //  6 Sadzba DPH
    mW.SetReal(gBlkItems[I].DscPrc,0,2); //  7 Zæava v %
    mW.SetNum (0,0);                                        //  8 nepuûÌva sa
    mW.SetText(StrPrice (gBlkItems[I].BPrice), 0); //  9 Predajn· cena s DPH za MJ (zæavnen·)
    mW.SetReal(gBlkItems[I].BValue,0,2); // 10 Hodnota poloûky  v PC s DPH
    mW.SetText(StrPrice (gBlkItems[I].BPrice), 0);// 11 Listinov· cennÌkov· cena s DPH
    mW.SetText(gBlkItems[I].BarCode,0); // 12 IdentifikaËn˝ kÛd
    mW.SetText('',0);// 13 Zdroj ceny
    mW.SetText('',0);  // 14 Zdroj zæavy
    mW.SetText(gBlkItems[I].StkCode,0); // 15 Skladov˝ kÛd
    mW.SetNum (0,0); // 16 Sklad z ktorÈho sa odpoËÌta poloûka
    mW.SetText('',0);  // 17 DoplÚuj˙ce oznaËenie poloûky
    mW.SetReal(gBlkItems[I].DscBVal,0,2); // 18 Hodnota zæavy
    mW.SetText('',0); // 19 V˝robnÈ ËÌslo
    mW.SetText(gBlkItems[I].OsdCode,0); // 20 Objedn·vacÌ kÛd
    mW.SetText('',0);  // 21 AkciovÈ oznaËenie tovaru
    mW.SetText('',0); // 22 äpecifick˝ kÛd
    mW.SetText(gBlkItems[I].NegType,0);  // 23 Typ poloûky
    mW.SetNum (gBlkItems[I].FgCode,0); // 24 »Ìslo finanËnej skupiny
    mW.SetNum (0,0); // 25 Sortiment
    mW.SetText('',0);  // 26 Popis 1
    mW.SetText('',0);  // 27 Popis 2
    mW.SetText('',0);  // 28 Popis 3
    mW.SetText(gBlkItems[I].MsName,0);  // 29 Mern· jednotka
    mW.SetReal(0,0,2);  // 30 BÛnus za tovar
    mW.SetReal(0,0,2);// 31 Ceækov˝ bÛnus
    mW.SetNum (0,0); // 32 »Ìslo pokladne, kde bolo nablokovanÈ
    mW.SetNum (0,0); // 33 »Ìslo prev·dzky, kde bolo nablokovanÈ
    mW.SetText(gBlkItems[I].LoginName,0);  // 34 Meno pokladnÌka, kdo nablokoval
    mW.SetText(FormatDateTime('dd.mm.yyyy',gBlkItems[I].Date),0);  // 35 D·tom nablokovania
    mW.SetText(FormatDateTime('hh:nn',gBlkItems[I].Time),0);  // 35 »as nablokovania

    oList.Add (mW.GetWrapText);
    mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);
  end;

  For I:=1 to 5 do begin
    If IsNotNul (gBlkHead.BVals[I]) then begin
      mW.ClearWrap;
      mW.SetText ('ST',0);                       //  1 Tabuæka DPH
      mW.SetNum (gBlkHead.VatPrc[I],0);    //  2 Sadzba DPH
      mW.SetReal (gBlkHead.AVals[I],0,2); //  3 Hodnota bez DPH
      mW.SetReal (gBlkHead.VatVals[I],0,2); //  4 Hodnota DPH
      mW.SetReal (gBlkHead.BVals[I],0,2); //  5 Hodnota s DPH
      oList.Add (mW.GetWrapText);
      mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);
    end;
  end;

  mW.ClearWrap;
  mW.SetText ('SS',0);                       //  1 P]ti4ka dokladu
  mW.SetReal (0,0,2);                        //  2 KumulatÌvna hodnota bÛnusu - ak sa poËÌta len na niektorÈ poloûky, eöte nepouûÌva sa
  mW.SetNum  (0,0);                          //  3 NepouûÌva sa
  mW.SetReal (gBlkHead.BValue,0,2);          //  4 Hodnota s DPH
  mW.SetNum  (0,0);                          //  5 NepouûÌva sa
  mW.SetNum  (0,0);                          //  6 NepouûÌva sa
  mW.SetNum  (0,0);                          //  7 NepouûÌva sa
  mW.SetNum  (0,0);                          //  8 NepouûÌva sa
  mW.SetNum  (0,0);                          //  9 NepouûÌva sa
  mW.SetText (uNoteLst[1],0);                // 10 Variabiln· p‰tiËka 1
  mW.SetText (uNoteLst[2],0);                // 11 Variabiln· p‰tiËka 2
  mW.SetText (uNoteLst[3],0);                // 12 Variabiln· p‰tiËka 3
  mW.SetText (uNoteLst[4],0);                // 13 Variabiln· p‰tiËka 4
  If cCashRndSave=0 then mRndH := gBlkHead.RndVal;
  mW.SetReal (mRndH,0,2);                    // 14 Hodnota zaokr˙hlenie z PPEKK
  oList.Add (mW.GetWrapText);
  mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);
  mRndH := 0;

  For I:= 0 to 9 do begin
    If IsNotNul (uPaysTbl[I]) then begin
      mW.ClearWrap;
      mW.SetText ('SP',0);                // 1 Zoznam platidiel
      mW.SetNum (I,0);                    // 2 »Ìslo platidla
      mW.SetText (gEcsGlob.PayVals[I].Name,0); // 3 N·zov platidla
(*      If I=0                              // 4 Nevr·ten˝ preplatok - pre hotovosù
        then mW.SetReal (oPayVals[I].NotToRet,0,2)
        else mW.SetNum  (0,0);*)
      mW.SetReal (uPaysTbl[I],0,2);// 5 Zaplaten· hodnota
      oList.Add (mW.GetWrapText);
      mCheckSum := mCheckSum+CalcCheckSum (mW.GetWrapText);
    end;
  end;

  mW.ClearWrap;
  mW.SetText ('SC',0);   //  1 KontrolnÈ ËÌslo - oznaËenie riadku
  mW.SetNum  (mCheckSum,0);   //  2 Kontrolne cislo
  oList.Add (mW.GetWrapText);
  Save;
  FreeAndNil (mW);
end;

//  <<<<< TTFileHnd <<<<<

//  >>>>> TTFileGlobFill >>>>>
constructor TTFileGlobFill.Create;
begin
  ClearEcsGlob;
end;

destructor TTFileGlobFill.Destroy;
begin
  inherited;
end;

function  TTFileGlobFill.ReadInTFile(pFile:string):boolean;
begin
  Result := FALSE;
  If FileExists (pFile) then begin
    SumBegVarInTFile (pFile);
    Result:=TRUE;
  end;
end;

procedure TTFileGlobFill.SumBegVarInTFile(pFile:string);
var mSList:TStringList; I:longint; mS:string;
begin
  If FileExists (pFile) then begin
    mSList := TStringList.Create;
    mSList.LoadFromFile(pFile);
    If mSList.Count>0 then begin
      oCut := TTxtCutLst.Create;
      For I:=0 to mSList.Count-1 do begin
        oCut.SetStr(mSList.Strings[I]);
        If oCut.GetText(1)='FH' then ReadFH;
        If oCut.GetText(1)='BB' then SumBegVarInBB;
        If oCut.GetText(1)='BP' then SumBegVarInBP;
        If oCut.GetText(1)='BV' then SumBegVarInBV;
        If oCut.GetText(1)='PB' then SumBegVarInPB;
        If oCut.GetText(1)='IB' then SumBegVarInIB;
        If oCut.GetText(1)='IP' then SumBegVarInIP;
        If oCut.GetText(1)='OB' then SumBegVarInOB;
        If oCut.GetText(1)='OP' then SumBegVarInOP;
        If oCut.GetText(1)='HB' then SumBegVarInHB;
        If oCut.GetText(1)='HX' then SumBegVarInHX;
        If oCut.GetText(1)='HY' then SumBegVarInHY;
        If oCut.GetText(1)='AB' then SumBegVarInAB;
        If oCut.GetText(1)='XB' then SumBegVarInXB;
        If oCut.GetText(1)='XI' then SumBegVarInXI;
        If oCut.GetText(1)='DB' then SumBegVarInDB;
        If oCut.GetText(1)='DI' then SumBegVarInDI;
        If oCut.GetText(1)='MB' then SumBegVarInMB;
        If oCut.GetText(1)='MI' then SumBegVarInMI;
        If oCut.GetText(1)='SB' then SumBegVarInSB;
        If oCut.GetText(1)='SI' then SumBegVarInSI;
        If oCut.GetText(1)='SP' then SumBegVarInSP;
        If oCut.GetText(1)='ST' then SumBegVarInST;
        If oCut.GetText(1)='NB' then SumBegVarInNB;
        If oCut.GetText(1)='RB' then SumBegVarInRB;
        If oCut.GetText(1)='RP' then SumBegVarInRP;
        If oCut.GetText(1)='KB' then SumBegVarInKB;
        If oCut.GetText(1)='TB' then SumBegVarInTB;
      end;
      FreeAndNil (oCut);
    end;
    FreeAndNil (mSList);
  end;
end;

procedure TTFileGlobFill.ReadFH;
begin
  If gEcsGlob.Prg<>'ECS' then ClearEcsGlob; // ⁄doje, ktorÈ neboli uloûenÈ s programom ECS s˙ ignorovanÈ
  gEcsGlob.Version:=oCut.GetText(2);
  gEcsGlob.Prg:=oCut.GetText(6);
end;

procedure TTFileGlobFill.SumBegVarInBB;
var I:longint;
begin
  If oCut.GetNum(4)>0 then gEcsGlob.IntDocNum:=oCut.GetNum(4);
  If gEcsGlob.Prg='ECS' then begin
    gEcsGlob.PrevDate:=oCut.GetDate(13);
    For I:=1 to 5 do begin
//      gEcsGlob.VatPrc[I] := 0;
      gEcsGlob.AValue[I] := 0;
      gEcsGlob.VatVal[I] := 0;
      gEcsGlob.BValue[I] := 0;
    end;
    gEcsGlob.XDocQnt := oCut.GetNum(8);
    gEcsGlob.DDocQnt := oCut.GetNum(9);
    gEcsGlob.XClsNum := oCut.GetNum(15);
    gEcsGlob.DClsNum := oCut.GetNum(16);
    gEcsGlob.ICDocPay := oCut.GetReal(18);
    gEcsGlob.ClmVal := oCut.GetReal(19);
    gEcsGlob.AdvVal := oCut.GetReal(20);
    gEcsGlob.DscVal := oCut.GetReal(21);
    gEcsGlob.ICDocQnt  := oCut.GetNum(22);
    gEcsGlob.IncDocQnt := oCut.GetNum(23);
    gEcsGlob.DecDocQnt := oCut.GetNum(24);
    gEcsGlob.ClmItmQnt := oCut.GetNum(25);
    gEcsGlob.AdvItmQnt := oCut.GetNum(26);
    gEcsGlob.DscItmQnt := oCut.GetNum(27);
    gEcsGlob.NegItmQnt := oCut.GetNum(28);
    gEcsGlob.NegVal := oCut.GetReal(29);
    gEcsGlob.RndH := oCut.GetReal(30);
    gEcsGlob.RndI_P := oCut.GetReal(31);
    gEcsGlob.RndI_N := oCut.GetReal(32);
  end;
end;

procedure TTFileGlobFill.SumBegVarInBP;
var mNum:byte;
begin
  If gEcsGlob.Prg='ECS' then begin
    mNum:=oCut.GetNum(2);
    If mNum in [0..9] then begin
      gEcsGlob.PayVals[mNum].BegVal:=oCut.GetReal(5);
      gEcsGlob.PayVals[mNum].TrnVal:=oCut.GetReal(6);
      gEcsGlob.PayVals[mNum].ExpVal:=oCut.GetReal(7);
      gEcsGlob.PayVals[mNum].ChIVal:=oCut.GetReal(8);
      gEcsGlob.PayVals[mNum].ChOVal:=oCut.GetReal(9);
      gEcsGlob.PayVals[mNum].IncVal:=oCut.GetReal(10);
      gEcsGlob.PayVals[mNum].EndVal:=oCut.GetReal(11);
      gEcsGlob.PayVals[mNum].PaidAdv:=oCut.GetReal(12);
      gEcsGlob.PayVals[mNum].UsedAdv:=oCut.GetReal(13);
    end;
  end;
end;

procedure TTFileGlobFill.SumBegVarInBV;
var mVatPrc,mVatNum,I:longint;
begin
  If gEcsGlob.Prg='ECS' then begin
    mVatNum:=0;
    mVatPrc:=oCut.GetNum(2);
    For I:=1 to 5 do begin
      If mVatPrc=gEcsGlob.VatPrc[I] then begin
        mVatNum := I;
        Break;
      end else begin
(* 27.06.2022 Tibi
        If (gEcsGlob.VatPrc[I]=0) and (gEcsGlob.BValue[I]=0) then begin
          gEcsGlob.VatPrc[I]:=mVatPrc;
          mVatNum:=I;
          Break;
        end;*)
      end;
    end;
    If mVatNum>0 then begin
      gEcsGlob.VatPrc[mVatNum]:=mVatPrc;
      gEcsGlob.AValue[mVatNum]:=gEcsGlob.AValue[mVatNum]+oCut.GetReal(3);
      gEcsGlob.VatVal[mVatNum]:=gEcsGlob.VatVal[mVatNum]+oCut.GetReal(4);
      gEcsGlob.BValue[mVatNum]:=gEcsGlob.BValue[mVatNum]+oCut.GetReal(5);
    end;
  end;
end;

procedure TTFileGlobFill.SumBegVarInPB;
begin
  gEcsGlob.IntDocNum:=oCut.GetNum(4);
end;

procedure TTFileGlobFill.SumBegVarInIB;
var mNum:longint;
begin
  oChgDoc:=FALSE;
  If oCut.GetNum(4)>0 then gEcsGlob.IntDocNum:=oCut.GetNum(4);
  If gEcsGlob.Prg='ECS' then begin
    oChgDoc:=(oCut.GetNum(11)=-1);
    Inc(gEcsGlob.IncDocQnt);
  end;
end;

procedure TTFileGlobFill.SumBegVarInIP;
var mNum:byte;
begin
  If gEcsGlob.Prg='ECS' then begin
    mNum:=oCut.GetNum(2);
    If mNum in [0..9] then begin
      If oChgDoc then begin
        gEcsGlob.PayVals[mNum].ChIVal:=gEcsGlob.PayVals[mNum].ChIVal+oCut.GetReal(4);
      end else begin
        gEcsGlob.PayVals[mNum].IncVal:=gEcsGlob.PayVals[mNum].IncVal+oCut.GetReal(4);
      end;
      CalcPayEndVal(mNum);
    end;
  end;
end;

procedure TTFileGlobFill.SumBegVarInOB;
var mNum:longint;
begin
  If oCut.GetNum(4)>0 then gEcsGlob.IntDocNum:=oCut.GetNum(4);
  If gEcsGlob.Prg='ECS' then begin
    oChgDoc:=(oCut.GetNum(10)=-1);
    Inc(gEcsGlob.DecDocQnt);
  end;
end;

procedure TTFileGlobFill.SumBegVarInOP;
var mNum:byte;
begin
  If gEcsGlob.Prg='ECS' then begin
    mNum:=oCut.GetNum(2);
    If mNum in [0..9] then begin
      If oChgDoc then begin
        gEcsGlob.PayVals[mNum].ChOVal:=gEcsGlob.PayVals[mNum].ChOVal+oCut.GetReal(4);
      end else begin
        gEcsGlob.PayVals[mNum].ExpVal:=gEcsGlob.PayVals[mNum].ExpVal+oCut.GetReal(4);
      end;
      CalcPayEndVal (mNum);
    end;
  end;
end;

procedure TTFileGlobFill.SumBegVarInHB;
begin
  If oCut.GetNum(4)>0 then gEcsGlob.IntDocNum:=oCut.GetNum(4);
end;

procedure TTFileGlobFill.SumBegVarInHX;
var mNum:byte;
begin
  If gEcsGlob.Prg='ECS' then begin
    mNum:=oCut.GetNum(2);
    If mNum in [0..9] then begin
      gEcsGlob.PayVals[mNum].ChOVal:=gEcsGlob.PayVals[mNum].ChOVal+oCut.GetReal(5);
      CalcPayEndVal (mNum);
    end;
  end;
end;

procedure TTFileGlobFill.SumBegVarInHY;
var mNum:byte;
begin
  If gEcsGlob.Prg='ECS' then begin
    mNum:=oCut.GetNum(2);
    If mNum in [0..9] then begin
      gEcsGlob.PayVals[mNum].ChIVal:=gEcsGlob.PayVals[mNum].ChIVal+oCut.GetReal(5);
      CalcPayEndVal (mNum);
    end;
  end;
end;

procedure TTFileGlobFill.SumBegVarInAB;
begin
  gEcsGlob.IntDocNum:=oCut.GetNum(4);
end;

procedure TTFileGlobFill.SumBegVarInXB;
begin
  If oCut.GetNum(4)>0 then gEcsGlob.IntDocNum:=oCut.GetNum(4);
  If gEcsGlob.Prg='ECS' then begin
    If oCut.GetNum(11)>0 then gEcsGlob.XDocQnt := oCut.GetNum(11);
    If oCut.GetNum(8)>0 then gEcsGlob.DDocQnt := oCut.GetNum(8);
    gEcsGlob.XClsNum:=oCut.GetNum(7);
    gEcsGlob.XDocQnt := 0;
  end;
end;

procedure TTFileGlobFill.SumBegVarInXI;
begin
end;

procedure TTFileGlobFill.SumBegVarInDB;
var I:longint;
begin
  If oCut.GetNum(4)>0 then gEcsGlob.IntDocNum:=oCut.GetNum(4);
  If gEcsGlob.Prg='ECS' then begin
    gEcsGlob.DClsNum:=oCut.GetNum(7);
    If oCut.GetNum(11)>0 then gEcsGlob.XDocQnt:=oCut.GetNum(11);
    If oCut.GetNum(8)>0 then gEcsGlob.DDocQnt:=oCut.GetNum(8);
    gEcsGlob.DClsNum:=oCut.GetNum(7);
    gEcsGlob.DDocQnt := 0;
    For I:=1 to 5 do begin
//      gEcsGlob.VatPrc[I] := 0;
      gEcsGlob.AValue[I] := 0;
      gEcsGlob.BValue[I] := 0;
      gEcsGlob.VatVal[I] := 0;
    end;
    gEcsGlob.ClmVal := 0;
    gEcsGlob.AdvVal := 0;
    gEcsGlob.NegVal := 0;
    gEcsGlob.DscVal := 0;
    gEcsGlob.ICDocPay := 0;
    gEcsGlob.RndH := 0;
    gEcsGlob.RndI_P := 0;
    gEcsGlob.RndI_N := 0;
    For I:=0 to 9 do begin
      gEcsGlob.PayVals[I].BegVal:=gEcsGlob.PayVals[I].EndVal;
      gEcsGlob.PayVals[I].TrnVal:=0;
      gEcsGlob.PayVals[I].ExpVal:=0;
      gEcsGlob.PayVals[I].ChIVal:=0;
      gEcsGlob.PayVals[I].ChOVal:=0;
      gEcsGlob.PayVals[I].IncVal:=0;
      gEcsGlob.PayVals[I].PaidAdv:=0;
      gEcsGlob.PayVals[I].UsedAdv:=0;
    end;
    gEcsGlob.SalDocQnt:=0;
    gEcsGlob.ICDocQnt:=0;
    gEcsGlob.IncDocQnt:=0;
    gEcsGlob.DecDocQnt:=0;
    gEcsGlob.ClmItmQnt:=0;
    gEcsGlob.NegItmQnt:=0;
    gEcsGlob.DscItmQnt:=0;
    gEcsGlob.AdvItmQnt:=0;
  end;
end;

procedure TTFileGlobFill.SumBegVarInDI;
begin
end;

procedure TTFileGlobFill.SumBegVarInMB;
begin
  If oCut.GetNum(4)>0 then gEcsGlob.IntDocNum:=oCut.GetNum(4);
end;

procedure TTFileGlobFill.SumBegVarInMI;
begin
end;

procedure TTFileGlobFill.SumBegVarInSB;
var mRndI:double;
begin
  If oCut.GetNum(4)>0 then gEcsGlob.IntDocNum:=oCut.GetNum(4);
  If gEcsGlob.Prg='ECS' then begin
    Inc(gEcsGlob.XDocQnt);
    Inc(gEcsGlob.DDocQnt);
    If oCut.GetNum(10)>0 then gEcsGlob.DDocNum:=oCut.GetNum(10);
    gEcsGlob.eKasaDocNum:=oCut.GetText(12);

    If LineElementNum(oCut.GetStr,',')>32 then begin
      gEcsGlob.RndH := gEcsGlob.RndH+oCut.GetReal(29);
      mRndI := oCut.GetReal(30);
      If mRndI>0
        then gEcsGlob.RndI_P := gEcsGlob.RndI_P+mRndI
        else gEcsGlob.RndI_N := gEcsGlob.RndI_N+mRndI;

      Inc(gEcsGlob.SalDocQnt);
    end;
  end;
end;

procedure TTFileGlobFill.SumBegVarInSI;
var mNegType:string;
begin
  If gEcsGlob.Prg='ECS' then begin
    If oCut.GetText(23)<>'R' then begin
      If oCut.GetReal(5)<0 then begin
        If oCut.GetText(23)='A' then begin
          gEcsGlob.AdvVal:=gEcsGlob.AdvVal-oCut.GetReal(10);
          Inc(gEcsGlob.AdvItmQnt);
        end else begin
          If oCut.GetText(23)='O' then begin
            gEcsGlob.NegVal:=gEcsGlob.NegVal-oCut.GetReal(10);
            Inc(gEcsGlob.NegItmQnt);
          end else begin
            gEcsGlob.ClmVal:=gEcsGlob.ClmVal-oCut.GetReal(10);
            Inc(gEcsGlob.ClmItmQnt);
          end;
        end;
      end else begin
        If IsNotNul(oCut.GetReal(18)) then begin
          gEcsGlob.DscVal:=gEcsGlob.DscVal+oCut.GetReal(18);
          Inc(gEcsGlob.DscItmQnt);
        end;
      end;
    end;
  end;
end;

procedure TTFileGlobFill.SumBegVarInSP;
var mNum:byte;
begin
  If gEcsGlob.Prg='ECS' then begin
    mNum := oCut.GetNum(2);
    If mNum in [0..9] then begin
      gEcsGlob.PayVals[mNum].TrnVal:=gEcsGlob.PayVals[mNum].TrnVal+oCut.GetReal(4);
      CalcPayEndVal(mNum);
    end;
  end;
end;

procedure TTFileGlobFill.SumBegVarInST;
var mVatPrc,mVatNum,I:longint;
begin
  If gEcsGlob.Prg='ECS' then begin
    mVatNum := 0;
    mVatPrc:= oCut.GetNum(2);
    For I:=1 to 5 do begin
      If mVatPrc=gEcsGlob.VatPrc[I] then begin
        mVatNum := I;
        Break;
      end else begin
(*  27.06.2022 Tibi
        If (gEcsGlob.VatPrc[I]=0) and (gEcsGlob.BValue[I]=0) then begin
          gEcsGlob.VatPrc[I]:=mVatPrc;
          mVatNum := I;
          Break;
        end;*)
      end;
    end;
    If mVatNum>0 then begin
      gEcsGlob.AValue[mVatNum]:=gEcsGlob.AValue[mVatNum]+oCut.GetReal(3);
      gEcsGlob.VatVal[mVatNum]:=gEcsGlob.VatVal[mVatNum]+oCut.GetReal(4);
      gEcsGlob.BValue[mVatNum]:=gEcsGlob.BValue[mVatNum]+oCut.GetReal(5);
    end;
  end;
end;

procedure TTFileGlobFill.SumBegVarInNB;
begin
  gEcsGlob.IntDocNum:=oCut.GetNum(4);
end;

procedure TTFileGlobFill.SumBegVarInRB;
begin
  If oCut.GetNum(4)>0 then gEcsGlob.IntDocNum:=oCut.GetNum(4);
  If gEcsGlob.Prg='ECS' then begin
    Inc(gEcsGlob.XDocQnt);
    Inc(gEcsGlob.DDocQnt);
    If oCut.GetNum(10)>0 then gEcsGlob.DDocNum:=oCut.GetNum(7);
    gEcsGlob.eKasaDocNum:=oCut.GetText(19);
    gEcsGlob.ICDocPay:=gEcsGlob.ICDocPay+oCut.GetReal(9);
    Inc(gEcsGlob.ICDocQnt);
  end;
end;

procedure TTFileGlobFill.SumBegVarInRP;
var mNum:byte;
begin
  If gEcsGlob.Prg='ECS' then begin
    mNum := oCut.GetNum(2);
    If mNum in [0..9] then begin
      gEcsGlob.PayVals[mNum].TrnVal:=gEcsGlob.PayVals[mNum].TrnVal+oCut.GetReal(4);
      CalcPayEndVal (mNum);
    end;
  end;
end;

procedure TTFileGlobFill.SumBegVarInKB;
begin
  gEcsGlob.IntDocNum:=oCut.GetNum(16);
end;

procedure TTFileGlobFill.SumBegVarInTB;
begin
  gEcsGlob.IntDocNum:=oCut.GetNum(4);
end;

procedure TTFileGlobFill.FillGlobValues(pDate:TDate;pCasNum:longint;pPath:string);
var mTFile,mActDay,mS:string; mSearch:boolean; mSR:TSearchRec; mTList:TStringList;
    mD,mM,mY:word; mOK:boolean; I:longint;
begin
  mTFile := pPath+GetTFileName (pDate,pCasNum);
  mSearch := FALSE;
  If FileExists (mTFile) then mSearch:=ReadInTFile(mTFile);
  If not mSearch then begin
    mTList := TStringList.Create;
    If FindFirst(pPath+'T*.'+StrIntZero(pCasNum,3), faAnyFile, mSR) = 0 then begin
      Repeat
        If Length(mSR.Name)=11 then begin
          mS := Copy (mSR.Name,6,2)+Copy(mSR.Name,4,2)+Copy(mSR.Name,2,2);
          mS := mS+'-'+mSR.Name;
          mTList.Add(mS);
        end;
      until FindNext(mSR) <> 0;
      SysUtils.FindClose(mSR);
    end;
    If mTList.Count>0 then begin
      mTList.Sort;
      DecodeDate(pDate,mY,mM,mD);
      mActDay:=Copy(StrInt (mY,4),3,2)+StrIntZero(mM,2)+StrIntZero(mD,2);
      Repeat
        mS := Copy (mTList.Strings[mTList.Count-1],1,6);
        mOK := mS<=mActDay;
        If not mOK then mTList.Delete(mTList.Count-1);
      until mOK or (mTList.Count=0);
    end;
    If mTList.Count>0 then begin
      I:=mTList.Count-1;
      mTFile := pPath+Copy (mTList.Strings[I],Pos ('-',mTList.Strings[I])+1,Length (mTList.Strings[I]));
      mOK:=ReadInTFile(mTFile);
      gEcsGlob.PrevDate:=EncodeDate(mY,mM,mD);
    end;
    FreeAndNil (mTList);
  end;
  Inc(gEcsGlob.IntDocNum);
end;

//  <<<<< TTFileGlobFill <<<<<

//  >>>>> TTFileClsFill >>>>>
constructor TTFileClsFill.Create;
begin
  ClearClsData;
  oCut:=TTxtCutLst.Create;
end;

destructor TTFileClsFill.Destroy;
begin
  FreeAndNil(oCut);
  inherited;
end;

procedure TTFileClsFill.ReadInDCls(pFile:string;pDate:TDateTime;pNumF,pNumL:longint);
var mSList:TStringList; I:longint; mS:string; mOK:boolean;
begin
  If FileExists (pFile) then begin
    mSList := TStringList.Create;
    mSList.LoadFromFile(pFile);
    If mSList.Count>0 then begin
      oCut:=TTxtCutLst.Create;
      mOK:=FALSE;
      For I:=0 to mSList.Count-1 do begin
        oCut.SetStr(mSList.Strings[I]);
        If oCut.GetText(1)='DB' then mOK:=ReadInDClsDB(mSList.Strings[I],pDate,pNumF,pNumL);
        If (oCut.GetText(1)='DI') and mOK then ReadInDClsDI(mSList.Strings[I]);
      end;
      FreeAndNil (oCut);
    end;
    FreeAndNil (mSList);
  end;
end;

function  TTFileClsFill.ReadInDClsDB(pLn:string;pDate:TDateTime;pNumF,pNumL:longint):boolean;
var I:longint; mClsNum:longint; mOK:boolean;
begin
  Result:=FALSE;
  mClsNum:=oCut.GetNum(7);
  If pNumF=0
    then mOK:=TRUE
    else mOK:=InLongInterval (pNumF,pNumL,mClsNum);
  If mOK then begin
    gClsData.DClsNumL:=mClsNum;
    If gClsData.DClsNumF=0 then gClsData.DClsNumF:=gClsData.DClsNumL;
    gClsData.DClsDateL:=pDate;
    If gClsData.DClsDateF=0 then gClsData.DClsDateF:=pDate;
    Result:=TRUE;
  end;
end;

procedure TTFileClsFill.ReadInDClsDI(pLn:string);
var mItm:longint; mVatPrc:byte;mVatVal,mBValue:double;
begin
  mItm:=oCut.GetNum(2);
  If mItm=1 then gClsData.RndH:=gClsData.RndH+oCut.GetReal(3);
  If mItm=2 then gClsData.RndI_P:=gClsData.RndI_P+oCut.GetReal(3);
  If mItm=3 then gClsData.RndI_N:=gClsData.RndI_N+oCut.GetReal(3);
  If (mItm=4) or (mItm=5) or (mItm=6) or (mItm=13) or (mItm=14) then begin
    mVatPrc:=oCut.GetNum(5);
    mVatVal:=oCut.GetReal(4);
    mBValue:=oCut.GetReal(3);
    If IsNotNul(mBValue) then SumClsVal(mVatPrc,mVatVal,mBValue);
  end;
  If mItm=7 then gClsData.ClmVal:=gClsData.ClmVal+oCut.GetReal(3);
  If mItm=8 then gClsData.AdvVal:=gClsData.AdvVal+oCut.GetReal(3);
  If mItm=9 then begin
    gClsData.SalDocQnt := gClsData.SalDocQnt+oCut.GetNum(8);
    gClsData.ICDocQnt  := gClsData.ICDocQnt+oCut.GetNum(11);
    gClsData.IncDocQnt := gClsData.IncDocQnt+oCut.GetNum(9);
    gClsData.ExpDocQnt := gClsData.ExpDocQnt+oCut.GetNum(10);
    gClsData.ClmItmQnt := gClsData.ClmItmQnt+oCut.GetNum(4);
    gClsData.NegItmQnt := gClsData.NegItmQnt+oCut.GetNum(6);
    gClsData.DscItmQnt := gClsData.DscItmQnt+oCut.GetNum(5);
    gClsData.AdvItmQnt := gClsData.AdvItmQnt+oCut.GetNum(7);
  end;
  If mItm=10 then gClsData.DscVal:=gClsData.DscVal+oCut.GetReal(3);
  If mItm=11 then gClsData.NegVal:=gClsData.NegVal+oCut.GetReal(3);
  If mItm=12 then gClsData.ICDocPay:=gClsData.ICDocPay+oCut.GetReal(3);
  If (mItm>14) and (mItm<25) then begin
    gClsData.PayVals[mItm-15].TrnVal:=gClsData.PayVals[mItm-15].TrnVal+oCut.GetReal(7);
    gClsData.PayVals[mItm-15].IncVal:=gClsData.PayVals[mItm-15].IncVal+oCut.GetReal(5);
    gClsData.PayVals[mItm-15].ExpVal:=gClsData.PayVals[mItm-15].ExpVal+oCut.GetReal(6);
  end;
end;

procedure TTFileClsFill.SumClsVal(pVatPrc:byte;pVatVal,pBValue:double);
var I,mItm:longint;
begin
  mItm:=1;
  For I:=5 downto 1 do begin
    If (gClsData.VatPrc[I]=pVatPrc) then begin
      mItm:=I;
      Break;
    end;
(*  27.06.2022 Tibi
    If pVatPrc>0 then begin
      If (gClsData.VatPrc[I]=pVatPrc) and IsNotNul(gClsData.BValue[I]) then begin
        mItm:=I;
        Break;
      end else begin
        If IsNul(gClsData.BValue[I]) then mItm:=I;
      end;
    end else begin
      If gClsData.VatPrc[I]=pVatPrc then begin
        mItm:=I;
        Break;
      end else begin
        If (gClsData.VatPrc[I]=0) and IsNul(gClsData.BValue[I]) then mItm:=I;
      end;
    end;*)
  end;
  gClsData.VatPrc[mItm]:=pVatPrc;
  gClsData.VatVal[mItm]:=gClsData.VatVal[mItm]+pVatVal;
  gClsData.BValue[mItm]:=gClsData.BValue[mItm]+pBValue;
  gClsData.AValue[mItm]:=gClsData.BValue[mItm]-gClsData.VatVal[mItm];
end;

function TTFileClsFill.FillClsValuesDate(pDateF,pDateL:TDateTime;pCasNum:longint;pPath:string):boolean;
var mTList:TStringList; mSR:TSearchRec; mS:string; mDate:TDateTime; I:longint;
begin
  mTList := TStringList.Create;
  FillChar (gClsData,SizeOf(gClsData),#0);
  gClsData.VatPrc[1]:=gEcsGlob.VatPrc[1];
  gClsData.VatPrc[2]:=gEcsGlob.VatPrc[2];
  gClsData.VatPrc[3]:=gEcsGlob.VatPrc[3];
  gClsData.VatPrc[4]:=gEcsGlob.VatPrc[4];
  gClsData.VatPrc[5]:=gEcsGlob.VatPrc[5];
  If FindFirst(pPath+'T*.'+StrIntZero (pCasNum,3), faAnyFile, mSR) = 0 then begin
    Repeat
      If Length(mSR.Name)=11 then begin
        mDate:=EncodeDate(ValInt('20'+Copy (mSR.Name,6,2)),ValInt(Copy (mSR.Name,4,2)),ValInt(Copy (mSR.Name,2,2)));
        If InDateInterval(pDateF,pDateL,mDate) then begin
          mS := Copy (mSR.Name,6,2)+Copy (mSR.Name,4,2)+Copy (mSR.Name,2,2);
          mS := mS+'-'+mSR.Name;
          mTList.Add(mS);
        end;
      end;
    until FindNext(mSR) <> 0;
    SysUtils.FindClose(mSR);
  end;
  If mTList.Count>0 then begin
    mTList.Sort;
    For I:=0 to mTList.Count-1 do begin
      mDate:=0;
      mS:=mTList.Strings[I];
      mDate:=EncodeDate(ValInt('20'+Copy(mS,1,2)),ValInt(Copy(mS,3,2)),ValInt(Copy(mS,5,2)));
      Delete(mS,1,Pos('-',mS));
      ReadInDCls(pPath+mS,mDate,0,0);
    end;
  end;
  FreeAndNil(mTList);
end;

function TTFileClsFill.FillClsValuesNum(pNumF,pNumL:longint;pCasNum:longint;pPath:string):boolean;
var mTList:TStringList; mSR:TSearchRec; mS:string; I:longint; mDate:TDateTime;
begin
  FillChar (gClsData,SizeOf(gClsData),#0);
  mTList := TStringList.Create;
  If FindFirst(pPath+'T*.'+StrIntZero (pCasNum,3), faAnyFile, mSR) = 0 then begin
    Repeat
      If Length(mSR.Name)=11 then begin
        mS := Copy (mSR.Name,6,2)+Copy (mSR.Name,4,2)+Copy (mSR.Name,2,2);
        mS := mS+'-'+mSR.Name;
        mTList.Add(mS);
      end;
    until FindNext(mSR) <> 0;
    SysUtils.FindClose(mSR);
  end;
  If mTList.Count>0 then begin
    mTList.Sort;
    For I:=0 to mTList.Count-1 do begin
      mDate:=0;
      mS:=mTList.Strings[I];
      mDate:=EncodeDate(ValInt('20'+Copy(mS,1,2)),ValInt(Copy(mS,3,2)),ValInt(Copy(mS,5,2)));
      Delete(mS,1,Pos('-',mS));
      ReadInDCls(pPath+mS,mDate,pNumF,pNumL);
    end;
  end;
  FreeAndNil(mTList);
end;

//  <<<<< TTFileClsFill <<<<<

//  >>>>> TECDSave >>>>>

constructor TECDSave.Create;
begin
  oHead:='';
  oItm:=TStringList.Create;
  oPay:=TStringList.Create;
  oNot:=TStringList.Create;
  oWrap := TTxtWrap.Create;
  oWrap.SetDelimiter('');
  oWrap.SetSeparator(';');
  oBVal:=0;
  oPayVal:=0;
  oItmVal:=0;
  oRndVal:=0;
  oErrCod:=0;
end;

destructor TECDSave.Destroy;
begin
  FreeAndNil(oWrap);
  FreeAndNil(oNot);
  FreeAndNil(oPay);
  FreeAndNil(oItm);
  inherited;
end;

function TECDSave.GetErrDes:Str100;
begin
  Result:='';
  case oErrCod of
    1: Result:='Nie je zadan· hlaviËka';
    2: Result:='Ne s˙ zadanÈ poloûky';
    3: Result:='Nie je zadan· ˙hrada';
    4: Result:='Hodnota podæa poloûiek nesedÌ s hodnotou dokladu';
    5: Result:='⁄hrada dokladu sa nerovn· s hodnotou dokladu';
  end;
end;

procedure TECDSave.AddICP(pDocNum,pExtNum:Str20;pPaCode:longint;pIno,pTin,pVin,pPaName,pGsName:Str30;pBVal:double);
// Sl˙ûi na zadanie potrebn˝ch ˙dajov pre ˙hrady fakt˙ry
var mQnt:longint;
begin
  mQnt:=1;
  If pBVal<0 then mQnt:=-1;
  AddHed(pDocNum,pExtNum,pPaCode,pIno,pTin,pVin,pPaName,'','',pBVal,0);
  AddItm(0,0,0,pExtNum,'','',pGsName,0,'',mQnt,pBVal,pBVal,0,0,'','',gvSYS.LoginName,Date,Time);
end;

procedure TECDSave.AddHed(pDocNum,pExtNum:Str20;pPaCode:longint;pIno,pTin,pVin,pPaName,pCrdNum,pCrdName:Str30;pBVal,pRndVal:double);
// VloûÌ hlaviËkovÈ ˙daje pokladniËnÈho dokladu
begin
  oWrap.ClearWrap;
  oWrap.SetText ('H',0);             //  0. Riadok hlaviËky
  oWrap.SetText (pDocNum,0);         //  1. Doklad
  oWrap.SetText (pExtNum,0);         //  2. Variab. symbol
  oWrap.SetNum  (pPaCode,0);         //  3. KÛd firmy
  oWrap.SetText (pIno,0);            //  4. I»O
  oWrap.SetText (pTin,0);            //  5. DI»
  oWrap.SetText (pVin,0);            //  6. I» DPH
  oWrap.SetText (pPaName,0);         //  7. Nazov firmy
  oWrap.SetText (pCrdNum,0);         //  8. Zakaznicka karta
  oWrap.SetText (pCrdName,0);        //  9. Meno z·kaznÌka
  oWrap.SetReal (pBVal,0,2);         // 10. Hodnota dokladu
  oWrap.SetText (gvSYS.LoginName,0); // 11. Prihlasovacie meno uûÌvateæa, kto vy˙Ëtoval doklad
  oWrap.SetText (gvSYS.UserName,0);  // 12. CelÈ meno uûÌvateæa, kto vy˙Ëtoval doklad
  oWrap.SetDate (Date);              // 13. D·tum vytvorenia ECD s˙boru
  oWrap.SetTime (Time);              // 14. »as vytvorenia ECD s˙boru
  oHead:=oWrap.GetWrapText;
  oBVal:=pBVal;
  oRndVal:=pRndVal;
end;

procedure TECDSave.AddItm(pGsCode,pMgCode,pFgCode:longint;pBarCode,pStkCode,pOsdCode:Str15;pGsName:Str30;pVatPrc:longint;pMsName:Str3;pQnt,pBValue,pFBValue,pDscPrc,pDscBVal:double;pNegType:Str1;pRefID:Str50;pLoginName:Str8;pDate,pTime:TDateTime);
// VloûÌ ˙daje poloûky pokladniËnÈho dokladu
var mBPrice,mFBPrice:double;
begin
  pQnt:=RoundSpec(pQnt,3);
  mBPrice:=RoundSpec(pBValue/pQnt,3);
  mFBPrice:=RoundSpec(pFBValue/pQnt,3);
  oWrap.ClearWrap;
  oWrap.SetText ('I',0);          //  0. Poloûky
  oWrap.SetNum  (pGsCode,0);      //  1. PLU
  oWrap.SetNum  (pMgCode,0);      //  2. Tovarov· skupina
  oWrap.SetNum  (pFgCode,0);      //  3. FinanËn· skupina
  oWrap.SetText (pBarCode,0);     //  4. IdentifikaËn˝ kÛd
  oWrap.SetText (pStkCode,0);     //  5. Skladov˝ kÛd
  oWrap.SetText (pOsdCode,0);     //  6. Objedn·vacÌ kÛd
  oWrap.SetText (pGsName,0);      //  7. N·zov tovaru
  oWrap.SetNum  (pVatPrc,0);      //  8. Sadzba DPH
  oWrap.SetText (pMsName,0);      //  9. Mern· jednotka
  oWrap.SetReal (pQnt,0,3);       // 10. PredanÈ mnoûstvo
  oWrap.SetReal (mBPrice,0,3);    // 11. Jednotkov· cena s DPH po zæave
  oWrap.SetReal (pBValue,0,2);    // 12. Hodnota s DPH po zæave
  oWrap.SetReal (mFBPrice,0,3);   // 13. Jednotkov· cena s DPH pred zæavou
  oWrap.SetReal (pFBValue,0,2);   // 14. Hodnota s DPH pred zæavou
  oWrap.SetReal (pDscPrc,0,3);    // 15. Percento zæavy
  oWrap.SetReal (pDscBVal,0,2);   // 16. Hodnota zæavy s DPH
  oWrap.SetText (pNegType,0);     // 17. Oznaenie z·pornej poloûky: A-Ëerpan· z·loha, C-vr·ten· poloûka
  oWrap.SetText (pRefID,0);       // 18. ReferenËnÈ ËÌslo pÙvodnÈho pokladniËnÈho dokladu
  oWrap.SetText (pLoginName,0);   // 19. Prihlasovacie meno uûÌvateæa
  oWrap.SetDate (pDate);          // 20. D·tum zaevidovania poloûky na pÙvodn˝ doklad
  oWrap.SetTime (pTime);          // 21. »as zaevidovania poloûky na pÙvodn˝ doklad
  oItm.Add (oWrap.GetWrapText);
  oItmVal:=oItmVal+RoundSpec(pFBValue,2)-pDscBVal;
end;

procedure TECDSave.AddPay(pPayNum:byte;pPayName:Str30;pPayVal:double);
// VloûÌ platbu podæa platidla
begin
  If IsNotNul(pPayVal) then begin
    oWrap.ClearWrap;
    oWrap.SetText ('P',0);        // 0. PlatobnÈ prostriedky
    oWrap.SetNum  (pPayNum,0);    // 1. PoradovÈ ËÌslo platidla
    oWrap.SetText (pPayName,0);   // 2. N·zov platidal
    oWrap.SetReal (pPayVal,0,2);  // 3. Zaplaten· hodnota
    oPay.Add (oWrap.GetWrapText);
    oPayVal:=oPayVal+pPayVal;
  end;
end;

Procedure TECDSave.AddNot(pNotLin:Str40);
// VloûÌ pozn·mkov˝ riadok
begin
  oWrap.ClearWrap;
  oWrap.SetText ('N',0);          // 0. Pozn·mky
  oWrap.SetText (pNotLin,0);      // 1. Text pozn·mky
  oNot.Add (oWrap.GetWrapText);
end;

function  TECDSave.DocGen(pPath,pFileName:string):boolean;
// Vygeneruje ECD s˙bor
var mLst:TStringList; I:longint;
begin
  Result:=FALSE;
  oErrCod:=0;
  If oHead<>'' then begin
    If (oItm.Count>0) then begin
      If (oPay.Count>0) then begin
        If Equal(oBVal,oItmVal,2) then begin
          If Equal(Rd2(oBVal+oRndVal),Rd2(oPayVal),2) then begin
            mLst:=TStringList.Create;
            mLst.Add(oHead);
            For I:=0 to oItm.Count-1 do
              mLst.Add(oItm.Strings[I]);
            For I:=0 to oPay.Count-1 do
              mLst.Add(oPay.Strings[I]);
            If oNot.Count>0 then begin
              For I:=0 to oNot.Count-1 do
                mLst.Add(oNot.Strings[I]);
            end;
            pPath:=pPath+'ECDDAT\';
            If not DirectoryExists(pPath) then ForceDirectories(pPath);
            mLst.SaveToFile(pPath+pFileName);
            FreeAndNil(mLst);
            Result:=TRUE;
          end else oErrCod:=5; // ⁄hrada dokladu sa nerovn· s hodnotou dokladu
        end else oErrCod:=4; // Hodnota podæa poloûiek nesedÌ s hodnotou dokladu
      end else oErrCod:=3; // Nie je zadan· ˙hrada
    end else oErrCod:=2; // Ne s˙ zadanÈ poloûky
  end else oErrCod:=1; // Nie je zadan· hlaviËka
end;

//  <<<<< TECDSave <<<<<

//  >>>>> TECDLoad >>>>>

constructor TECDLoad.Create;
begin
  EcsUnitInit;
  ClearBlkHead;
  ClearBlkItems;
  ClearPays;
  ClearNoteLst;
  oCut:=TTxtCutLst.Create;
  oErrCod:=0;
  oPayVal:=0;
  oItmVal:=0;
  oEcdFile:='';
end;

destructor TECDLoad.Destroy;
begin
  FreeAndNil(oCut);
  inherited;
end;

procedure TECDLoad.LoadHead(pCom:string);
// NaËÌta hlaviËkovÈ ˙daje
begin
  gBlkHead.IntDocNum:=LineElement(pCom,1,';');
  gBlkHead.ExtDocNum:=LineElement(pCom,2,';');
  gBlkHead.PaCode:=ValInt(LineElement(pCom,3,';'));
  gBlkHead.PaINO:=LineElement(pCom,4,';');
  gBlkHead.PaTIN:=LineElement(pCom,5,';');
  gBlkHead.PaVIN:=LineElement(pCom,6,';');
  gBlkHead.PaName:=LineElement(pCom,7,';');
  gBlkHead.CusCardNum:=LineElement(pCom,8,';');
  gBlkHead.CusName:=LineElement(pCom,9,';');
  gBlkHead.BValue:=ValDoub(LineElement(pCom,10,';'));
  gBlkHead.LoginName:=LineElement(pCom,11,';');
  gBlkHead.UserName:=LineElement(pCom,12,';');
end;

procedure TECDLoad.LoadItem(pCom:string);
// NaËÌta ˙daje poloûky
begin
  If gBlkItemQnt<1000 then begin
    Inc(gBlkItemQnt);
    gBlkItems[gBlkItemQnt].GsCode:=ValInt(LineElement(pCom,1,';'));
    gBlkItems[gBlkItemQnt].MgCode:=ValInt(LineElement(pCom,2,';'));
    gBlkItems[gBlkItemQnt].FgCode:=ValInt(LineElement(pCom,3,';'));
    gBlkItems[gBlkItemQnt].BarCode:=LineElement(pCom,4,';');
    gBlkItems[gBlkItemQnt].StkCode:=LineElement(pCom,5,';');
    gBlkItems[gBlkItemQnt].OsdCode:=LineElement(pCom,6,';');
    gBlkItems[gBlkItemQnt].GsName:=LineElement(pCom,7,';');
    gBlkItems[gBlkItemQnt].VatPrc:=ValInt(LineElement(pCom,8,';'));
    gBlkItems[gBlkItemQnt].MsName:=LineElement(pCom,9,';');
    gBlkItems[gBlkItemQnt].Qnt:=ValDoub(LineElement(pCom,10,';'));
    gBlkItems[gBlkItemQnt].BPrice:=ValDoub(LineElement(pCom,11,';'));
    gBlkItems[gBlkItemQnt].BValue:=ValDoub(LineElement(pCom,12,';'));
    gBlkItems[gBlkItemQnt].FBPrice:=ValDoub(LineElement(pCom,13,';'));
    gBlkItems[gBlkItemQnt].FBValue:=ValDoub(LineElement(pCom,14,';'));
    gBlkItems[gBlkItemQnt].DscPrc:=ValDoub(LineElement(pCom,15,';'));
    gBlkItems[gBlkItemQnt].DscBVal:=ValDoub(LineElement(pCom,16,';'));
    gBlkItems[gBlkItemQnt].NegType:=LineElement(pCom,17,';');
    gBlkItems[gBlkItemQnt].RefID:=LineElement(pCom,18,';');
    gBlkItems[gBlkItemQnt].LoginName:=LineElement(pCom,19,';');
    gBlkItems[gBlkItemQnt].Date:=StrToDate(LineElement(pCom,20,';'));
    gBlkItems[gBlkItemQnt].Time:=StrToTime(LineElement(pCom,21,';'));
    oItmVal:=oItmVal+Roundx(gBlkItems[gBlkItemQnt].Qnt*gBlkItems[gBlkItemQnt].FBPrice,2)-gBlkItems[gBlkItemQnt].DscBVal;
  end;
end;

procedure TECDLoad.LoadPay(pCom:string);
// NaËÌta ˙daje platby
var mNum:longint;
begin
  mNum:=ValInt(LineElement(pCom,1,';'));
  If (mNum>=0) and (mNum<=9) then begin
    uPaysTbl[mNum]:=ValDoub(LineElement(pCom,3,';'));
    If mNum=0 then begin  // 27.06.2022 Tibi - zaokr˙hlenie
      If not Eq2(uPaysTbl[mNum],SpecRnd5(uPaysTbl[mNum])) then uPaysTbl[mNum]:=SpecRnd5(uPaysTbl[mNum]);
    end;
    oPayVal:=oPayVal+uPaysTbl[mNum];
  end;
end;

procedure TECDLoad.LoadNote(pCom:string);
// NaËÌta pozn·mkov˝ riadok
begin
  If uNoteQnt<4 then begin
    Inc(uNoteQnt);
    uNoteLst[uNoteQnt]:=LineElement(pCom,1,';');
  end;
end;

procedure TECDLoad.RecalcBlkHead;
// PrepoËÌta hodnoty pokladniËnÈho dokladu podæa sadzby DPH na z·klade poloûiek
var I,J,mV,mVatPrc:longint;
begin
  gBlkHead.PayVal:=0;
  For I:=0 to 9 do
    gBlkHead.PayVal:=gBlkHead.PayVal+Rd2(uPaysTbl[I]);
  gBlkHead.RndVal:=Rd2(gBlkHead.PayVal-gBlkHead.BValue);
  For J:=1 to 5 do
    gBlkHead.VatPrc[J]:=uVatPrc[J];
  For I:=1 to gBlkItemQnt do begin
    mVatPrc:=gBlkItems[I].VatPrc;
    mV:=-1;
    For J:=1 to 5 do begin
      If mVatPrc=gBlkHead.VatPrc[J] then begin
        mV:=J;
        Break;
      end;
    end;
    If mV>-1 then begin
      gBlkHead.BVals[mV]:=gBlkHead.BVals[mV]+gBlkItems[I].BValue;
      gBlkHead.AVals[mV]:=Roundx(gBlkHead.BVals[mV]/((100+mVatPrc)/100),2);
      gBlkHead.VatVals[mV]:=gBlkHead.BVals[mV]-gBlkHead.AVals[mV];
      If not IsNul(gBlkItems[I].DscBVal) then gBlkHead.DscBVals[mV]:=gBlkHead.DscBVals[mV]+gBlkItems[I].DscBVal;
    end;
  end;
end;

function TECDLoad.GetErrDes:Str100;
begin
  Result:='';
  case oErrCod of
    100001: Result:='Neexistuj˙ci ECD s˙bor ('+oEcdFile+')';
    100002: Result:='Chyba pri naËÌtanÌ ECD s˙boru ('+oEcdFile+')';
    100003: Result:='Nie je zadan· hlaviËka';
    100004: Result:='Ne s˙ zadanÈ poloûky';
    100005: Result:='Hodnota podæa poloûiek nesedÌ s hodnotou dokladu';
    100006: Result:='⁄hrada dokladu sa nerovn· s hodnotou dokladu';
  end;
end;

function TECDLoad.LoadDoc(pPath,pFileName:string):boolean;
// NaËÌta obsah ECD s˙boru
var mSLst:TStringList; I:longint; mS,mCom:string;
begin
  oErrCod:=0;
  oEcdFile:=pFileName;
  Result:=FALSE;
  If FileExists(pPath+pFileName) then begin
    mSLst:=TStringList.Create;
    mSLst.LoadFromFile(pPath+pFileName);
    If mSLst.Count>0 then begin
      For I:=0 to mSLst.Count-1 do begin
        mS:=mSLst.Strings[I];
        mCom:=LineElement(mS,0,';');
        If mCom='H' then LoadHead(mS);
        If mCom='I' then LoadItem(mS);
        If mCom='P' then LoadPay(mS);
        If mCom='N' then LoadNote(mS);
      end;
      If gBlkHead.IntDocNum<>'' then begin
        If gBlkItemQnt>0 then begin
          RecalcBlkHead;
          If Eq2(gBlkHead.BValue,oItmVal) then begin
            If Eq2(gBlkHead.BValue+gBlkHead.RndVal,gBlkHead.PayVal) then begin
              Result:=TRUE;
            end else oErrCod:=100006;
          end else oErrCod:=100005;
        end else oErrCod:=100004;
      end else oErrCod:=100003;
    end else oErrCod:=100002;
    FreeAndNil(mSLst);
  end else oErrCod:=100001;
end;

//  <<<<< TECDLoad <<<<<

begin
  uEcsUnitInit:=FALSE;
  gEcsGlob.PayVals[0].Name:='Hotovosù';
  gEcsGlob.PayVals[1].Name:='Karta';
  gEcsGlob.PayVals[2].Name:='äek';
  gRndItmN.GsCode:=0;
  gRndItmN.MgCode:=0;
  gRndItmN.FgCode:=0;
  gRndItmN.BarCode:='';
  gRndItmN.GsName:='Zaokr˙hlenie';
  gRndItmN.MsName:='ks';
  gRndItmP.GsCode:=0;
  gRndItmP.MgCode:=0;
  gRndItmP.FgCode:=0;
  gRndItmP.BarCode:='';
  gRndItmP.GsName:='Zaokr˙hlenie';
  gRndItmP.MsName:='ks';
end.
