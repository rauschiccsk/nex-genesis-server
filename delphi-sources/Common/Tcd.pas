unit Tcd;
{$F+}

// *****************************************************************************
//                               OBJEKT NA PRACU S OD
// *****************************************************************************
// Tento objekt obsahuje funkcie, ktoré umožnia naèíta položky dokladov a
// uloži ich do iného dokladu
//
// Programové funkcia:
// ---------------
// Gen - vygeneruje odberate¾ský dodací list zo zadaného zdrojového dokladu.
//       Zdrojový doklad može by:
//          - Dodávate¾ský dodací list
//          - Odberate¾ský dodací list
//          - Odberate¾ska zakazka
// *****************************************************************************
// TCI.BDF

interface

uses
  IcTypes, IcConst, IcConv, IcTools, IcVariab, DocHand, NexGlob, NexPath, NexIni, NexMsg, NexError, NexPxTable,
  StkGlob, StkCanc, SavClc, LinLst, Bok, Rep, Key, Stk, Jrn, Icd, ItgLog, JrnAcc, DocFnc,
  hJOURNAL, hSYSTEM, hGSCAT, hPAB, hTCH, hTCI, hTCC, hTCN, hTSH, hTSI, hTOH, hTOI, hCPH, hCPI, tTCH, tTCI, tTCC, tDHEAD,
  Controls, ComCtrls, SysUtils, Classes, Forms;

const
  NOT_ROUND = 0;
  ROUND_TO_05 = 5;

type
  PDat=^TDat;
  TDat=record
    rhTCH:TTchHnd;
    rhTCI:TTciHnd;
    rhTCC:TTccHnd;
    rhTCN:TTcnHnd;
  end;

  TTcd = class(TComponent)
    constructor Create(AOwner: TComponent); overload;
    destructor  Destroy; override;
    private
      oFrmName:Str15;
      oBokNum:Str5;
      oLst:TList;

      oYear:Str2;
      oSerNum:longint;
      oDocNum:Str12;
      oPaCode:longint;
      oDocDate:TDateTime;
      oNoeVal:double;  // Hodnota nevyexpedovaného tovaru
      oNoeItm:word;    // Po4et nevyexpedovaných položiek
      oNpiVal:double;  // Hodnota nevyfakturovanych DL
      oNpiQnt:word;    // Pocet nevyfakturovanych DL
      oNsiQnt:word;    // Pocet nevyskladnenych poloziek
      oInd:TProgressBar;
      ohGSCAT:TGscatHnd;
      oOcdNums: TStrings;
      procedure Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
      procedure TcdFromTsd(pTsdNum:Str12); // Vyhgeneruje OD z DD
      procedure TcdFromTcd(pTcdNum:Str12); // Vyhgeneruje OD z OD
      procedure TcdFromOcd(pOcdNum:Str12); // Vygeneruje OD zo ZK
      procedure TcdFromTod(pTobNum:Str5;pTodNum:Str12); // Vyhgeneruje OD z TV
    public
      ohPAB:TPabHnd;
      ohTCH:TTchHnd;
      ohTCI:TTciHnd;
      ohTCC:TTccHnd;
      ohTCN:TTcnHnd;
      ohCPH:TCphHnd;
      ohCPI:TCpiHnd;
      otTCI:TTciTmp;
      otTCC:TTccTmp;
      constructor Create;overload;
      function ActBok:Str5;
      procedure Open(pBokNum:Str5); overload; // Otvori vsetky databazove subory
      procedure Open(pBokNum:Str5;pTCH,pTCI,pTCN,pTCC:boolean); overload;// Otvori zadane databazove subory

      procedure PrnPdfDoc(pDocNum,pMasNam:Str12;pPdfNam:Str50); overload; // Tlaè zadaného dokladu do PDF súboru
      // ------------------------------------------------------------------------------------------------------------------
      procedure PrnDoc; overload;// Vytlaèí zadany dodaci list
      procedure PrnDoc(pDocNum,pMasNam:Str12;pAutPrn:boolean;pPrnNam,pPdfNam:Str50;pCopies:word); overload;// Vytlaèí zadany dodaci list
      procedure PrnPck(pDocNum:Str12);  // Tlaè pod¾a balenia
      procedure ResDoc(pYear:Str2;pSerNum:longint); // Zarezervuje zdoklad so zadanym poradovym cislom
      procedure NewDoc(pYear:Str2;pPaCode:longint;pResDoc:boolean); overload; // Vygeneruje novu hlavicku dokladu
      procedure NewDoc(pYear:Str2;pPaCode:longint;pStkNum:word;pResDoc:boolean); overload; // Vygeneruje novu hlavicku dokladu
      procedure ChgPac(pPaCode:longint); // Zmeni kod firmy v hlavicke dokladu
      procedure LocDoc(pDocNum:Str12);   // Vyhlada doklad

      procedure CncDoc; // Storno rezervovaneho dokladu DstLck=9
      procedure CnfDoc; // Potvrdenie dokladu nastavi priznak rezervacie DstLck=9 na 0
      procedure ClcDoc; overload; // Prepocita hlavicku aktualneho dokladu
      procedure ClcDoc(pDocNum:Str12); overload; // prepocita hlavicku zadaneho dokladu
      procedure SubDoc; overload; // Vyskladni tovar zo zadaneho dodacieho istu
      procedure SubDoc(pDocNum:Str12); overload; // Vyskladni tovar zo zadaneho dodacieho istu
      procedure SlcItm(pDocNum:Str12); // Nacita polozky zadaneho dokladu do PX
      procedure AddItm(pGsCode:longint;pGsQnt,pDscPrc,pFgBPrice:double); overload; // Prida novu polozku na zadany dodaci lsit
      procedure AddItm(pGsCode:longint;pGsQnt,pAcCPrice,pDscPrc,pFgBPrice:double); overload; // Prida novu polozku na zadany dodaci lsit
      procedure AddItm(pDocNum:Str12;pGsCode:longint;pGsQnt,pDscPrc,pFgBPrice:double); overload; // Prida novu polozku na zadanu fakturu
      procedure AddItm(pStkNum,pGsCode:longint;pGsQnt,pAcCPrice,pDscPrc,pFgBPrice:double;pWriNum:longint;pSpMark:Str10); overload; // Prida novu polozku na zadany dodaci lsit
      procedure RefTmp(pPxTable:TNexPxTable); // Naèíta naposledy uloženú položku do doèasného súboru
      procedure AddRba(pStkNum,pGsCode:longint;pGsQnt,pDscPrc,pFgAPrice,pFgBPrice:double;pRbaCode:Str30;pRbaDate:TDate;pFifStr:String;pPxTable:TNexPxTable;pSpMark:Str10);  // Prida novu polozku so sarzou na zadany dodaci list
      procedure AddItc(pDocNum:Str12;pItmNum:longint); // Prida komponenty polozky na zadany dodaci list
      procedure AddTcc(pItmNum,pParent,pStkNum,pGsCode,pPdCode:longint;pGsQnt,pAcCPrice,pDscPrc,pFgBPrice:double;pWriNum:longint);  // Prida novu polozku na zadany dodaci lsit
      procedure UnsTcc(pDocNum:Str12;pItmNum,pParent:longint); // vystornuje komponenty polozky dodacieho listu
      function  DelTcc(pDocNum:Str12;pItmNum,pParent:longint):boolean; // Zrusime komponenty polozky dodacieho listu ak su nevyskladnene
      procedure InsTcc(var pNextNum:word;pTcdItm,pTccItm:longint;pDocDate:TDateTime;pStkNum,pPaCode:integer;pGsQnt:double);
      procedure SubTcc(pDocNum:Str12;pItmNum,pTccNum:longint); // vyda komponenty polozky dodacieho listu
      procedure SubTci(pDocNum:Str12;pItmNum:longint); // Vvyda komponenty polozky dodacieho listu
      function ClcTcc(pDocNum:Str12;pItmNum,pTccNum:longint):double; // sumarizuje NC vyrobku
      function SubItm(pDocNum:Str12;pItmNum:word):boolean;  // Vykona skladovu operaciu
      function UnsItm(pDocNum:Str12;pItmNum:word;pClc:boolean):boolean;  // Zrusi skladovu operaciu
      procedure IcdGen(pPrnIcd,pAutPrn:boolean;pPrnNam:Str50); overload; // Vygeneruje polozky z aktualneho dodacieho listu do novej faktury
      procedure IcdGen(pTcdNum,pIcdNum:Str12;pPrnIcd,pAutPrn:boolean;pPrnNam:Str50); overload; // Vygeneruje polozky zo zadaneho dodacieho listu do zadanej faktury
      procedure IcdGen(pIcdNum:Str12;pPrnIcd,pAutPrn:boolean;pPrnNam:Str50;pRoundType:byte); overload; // Vygeneruje polozky z aktualneho dodacieho listu do zadanej faktury

      function  IssItc(pDocNum:Str12;pItmNum,pParent:longint):boolean; // Zisti ci su vsetky komponenty vyskladnene

      procedure Gen(pSrcDoc:Str12); overload; // Vytvori OD na zaklade zadaneho zdrojoveho dokladu
      procedure Gen(pBokNum:Str5;pSrcDoc:Str12); overload; // Vytvori OD na zaklade zadaneho zdrojoveho dokladu
      procedure Mov(pSrcDoc:Str12;pTrgBok:Str5); // Premiestni doklad z jedeho cisla na druhu
      procedure Npi(pPaCode:longint;pBokLst:ShortString);  // Spocita nevyfakturovane DL pre zadanehoo zakaznika zo zadanych knih
      function Uns(pDocNum:Str12):boolean;  // Zrusi skladovu operaciu (t.j. prijem tovar naspat vyda podla znaku mnozstva
      function Del(pDocNum:Str12;pHedDel:boolean):boolean;  // Zrusi zadany doklad
    published
      property BokNum:Str5 read oBokNum;
      property SerNum:longint read oSerNum write oSerNum;
      property Year:Str2 read oYear write oYear;
      property DocNum:Str12 read oDocNum;
      property PaCode:longint write oPaCode;
      property DocDate:TDateTime write oDocDate;
      property NoeVal:double read oNoeVal;
      property NoeItm:word read oNoeItm;
      property NpiVal:double read oNpiVal;
      property NpiQnt:word read oNpiQnt;
      property NsiQnt:word read oNsiQnt;
      property Ind:TProgressBar read oInd write oInd;
      property OcdNums:TStrings read oOcdNums;
  end;

implementation

uses bTCI, bTCC, bTCH, bPAB, bCPI, bGSCAT, bCPH, bTSH, bFIF, bSTK, bTCN;

constructor TTcd.Create(AOwner: TComponent);
begin
  oFrmName:=AOwner.Name;
  oLst:=TList.Create;  oLst.Clear;
  ohGSCAT:=TGscatHnd.Create;  ohGSCAT.Open;
  ohPAB:=TPabHnd.Create;  ohPAB.Open(0);
  ohCPH:=TCphHnd.Create;
  ohCPI:=TCpiHnd.Create;
  otTCI:=TTciTmp.Create;
  otTCC:=TTccTmp.Create;
  oOcdNums:=TStringList.Create;
end;

constructor TTcd.Create;
begin
  oFrmName:='';
  oLst:=TList.Create;  oLst.Clear;
  ohGSCAT:=TGscatHnd.Create;  ohGSCAT.Open;
  ohPAB:=TPabHnd.Create;  ohPAB.Open(0);
  ohCPH:=TCphHnd.Create;
  ohCPI:=TCpiHnd.Create;
  otTCI:=TTciTmp.Create;
  otTCC:=TTccTmp.Create;
  oOcdNums:=TStringList.Create;
end;

destructor TTcd.Destroy;
var I:word;
begin
  If oLst.Count>0 then begin
    For I:=1 to oLst.Count do begin
      Activate (I);
      FreeAndNil (ohTCN);
      FreeAndNil (ohTCI);
      FreeAndNil (ohTCC);
      FreeAndNil (ohTCH);
    end;
  end;
  FreeAndNil (oLst);
  FreeAndNil (otTCI);
  FreeAndNil (otTCC);
  FreeAndNil (ohPAB);
  FreeAndNil (ohCPH);
  FreeAndNil (ohCPI);
  FreeAndNil (ohGSCAT);
  FreeAndNil (oOcdNums);
end;

// ********************************* PRIVATE ***********************************

procedure TTcd.Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
var mDat:PDat;
begin
  mDat:=oLst.Items[pIndex-1];
  ohTCH:=mDat.rhTCH;
  ohTCI:=mDat.rhTCI;
  ohTCC:=mDat.rhTCC;
  ohTCN:=mDat.rhTCN;
  ohCPH.Close;
  ohCPI.Close;
  If gKey.TcbCpiBok[ohTCH.BokNum]<>'' then
  begin
    ohCPH.Open(gKey.TcbCpiBok[ohTCH.BokNum]);
    ohCPI.Open(gKey.TcbCpiBok[ohTCH.BokNum]);
  end;
end;

procedure TTcd.TcdFromTsd(pTsdNum:Str12); // Vyhgeneruje OD z DD
var mTsbNum:Str5;  mItmNum:word;  mhTSH:TTshHnd;  mhTSI:TTsiHnd;  mSav:TSavClc;  mItgLog:TItgLog;
begin
  mTsbNum:=BookNumFromDocNum (pTsdNum);
  mhTSH:=TTshHnd.Create;  mhTSH.Open(mTsbNum);
  mhTSI:=TTsiHnd.Create;  mhTSI.Open(mTsbNum);
  If mhTSH.LocateDocNum(pTsdNum) then begin
    If mhTSI.LocateDocNum(pTsdNum) then begin
      If oYear='' then oYear:=mhTSH.Year;
      If oSerNum=0 then oSerNum:=ohTCH.NextSerNum(oYear); // Ak nie je zadane poradove cislo OD vygenerujeme nasledujuce
      If oDocDate=0 then oDocDate:=Date; // Ak nie je zadany datum nastavime aktualny den
      oDocNum:=ohTCH.GenDocNum(oYear,oSerNum);
      If not ohTCH.LocateDocNum(oDocNum) then begin // Ak neexistuje vyvorime hlacicku dokladu OD
        ohTCH.Insert;
        ohTCH.Year:=oYear;
        ohTCH.SerNum:=oSerNum;
        ohTCH.DocNum:=oDocNum;
        ohTCH.ExtNum:=GenExtNum(oDocDate,'',gKey.TcbExnFrm[ohTCH.BtrTable.BookNum],oSerNum,ohTCH.BtrTable.BookNum,gKey.TcbStkNum[ohTCH.BtrTable.BookNum]);
        ohTCH.StkNum:=gKey.TcbStkNum[ohTCH.BtrTable.BookNum];
        ohTCH.SmCode:=gKey.TcbSmCode[ohTCH.BtrTable.BookNum];
        ohTCH.AcDvzName:=gKey.SysAccDvz;
        ohTCH.FgDvzName:=gKey.TcbDvName[ohTCH.BtrTable.BookNum];
        ohTCH.DocDate:=oDocDate;
        ohTCH.FgCourse:=1;
        If ohPAB.LocatePaCode(oPaCode) then BTR_To_BTR (ohPAB.BtrTable,ohTCH.BtrTable);
        ohTCH.SpaCode:=ohTCH.PaCode;   ohTCH.WpaCode:=0;
        ohTCH.WpaName:=ohTCH.PaName;
        ohTCH.WpaAddr:=ohTCH.RegAddr;
        ohTCH.WpaSta:=ohTCH.RegSta;
        ohTCH.WpaCty:=ohTCH.RegCty;
        ohTCH.WpaCtn:=ohTCH.RegCtn;
        ohTCH.WpaZip:=ohTCH.RegZip;
        ohTCH.VatDoc:=1;
        ohTCH.Post;
      end;
      // Vytvorime polozky OD na zaklade DD
      mItgLog:=TItgLog.Create;
      mSav:=TSavClc.Create;
      mItmNum:=ohTCI.NextItmNum(ohTCH.DocNum);
      If oInd<>nil then begin
        oInd.Max:=mhTSH.ItmQnt;
        oInd.Position:=0;
      end;
      Repeat
        If oInd<>nil then oInd.StepBy(1);
        ohTCI.Insert;
        BTR_To_BTR (mhTSI.BtrTable,ohTCI.BtrTable);
        ohTCI.DocNum:=oDocNum;
        ohTCI.ItmNum:=mItmNum;
        If ohGSCAT.LocateGsCode(ohTCI.GsCode)
          then ohTCI.VatPrc:=ohGSCAT.VatPrc
          else ohTCI.VatPrc:=gvSys.DefVatPrc;
        ohTCI.StkStat:='N';
        // Vypoèíteme predajné ceny
        mSav.GsQnt:=ohTCI.GsQnt;
        mSav.VatPrc:=ohTCI.VatPrc;
        mSav.FgAValue:=RoundAcABValue(mhTSI.AcCValue*(1+gKey.TsbAgnPrf[mTsbNum]/100));
        ohTCI.Sav:=mSav;
        ohTCI.Post;
        // Historia operacii nad polozkami dokladov
        mItgLog.Add(mhTSI.DocNum,mhTSI.ItmNum,ohTCI.DocNum,ohTCI.ItmNum,oFrmName);
        Application.ProcessMessages;
        Inc (mItmNum);
        mhTSI.Next;
      until mhTSI.Eof or (mhTSI.DocNum<>pTsdNum);
      ohTCH.Clc(ohTCI);
      FreeAndNil (mSav);
      FreeAndNil (mItgLog);
      // Uložíme odkaz do DD na OD
      mhTSH.Edit;
      mhTSH.TcdNum:=oDocNum;
      mhTSH.Post;
    end;
  end;
  FreeAndNil (mhTSI);
  FreeAndNil (mhTSH);
end;

procedure TTcd.TcdFromTcd(pTcdNum:Str12); // Vyhgeneruje OD z OD
var mTcbNum:Str5;  mItmNum:word;  mhTCH:TTchHnd;  mhTCI:TTciHnd;  mItgLog:TItgLog;
begin
  mTcbNum:=BookNumFromDocNum (pTcdNum);
  mhTCH:=TTchHnd.Create;  mhTCH.Open(mTcbNum);
  mhTCI:=TTciHnd.Create;  mhTCI.Open(mTcbNum);
  If mhTCH.LocateDocNum(pTcdNum) then begin
    If mhTCI.LocateDocNum(pTcdNum) then begin
      If oYear='' then oYear:=mhTCH.Year;
      If oSerNum=0 then oSerNum:=ohTCH.NextSerNum(oYear); // Ak nie je zadane poradove cislo OD vygenerujeme nasledujuce
      If oDocDate=0 then oDocDate:=Date; // Ak nie je zadany datum nastavime aktualny den
      oDocNum:=ohTCH.GenDocNum(oYear,oSerNum);
      oPaCode:=mhTCI.PaCode;
      If not ohTCH.LocateDocNum(oDocNum) then begin // Ak neexistuje vyvorime hlacicku dokladu OD
        ohTCH.Insert;
        BTR_To_BTR (mhTCH.BtrTable,ohTCH.BtrTable);
        ohTCH.DocNum:=oDocNum;
        ohTCH.SerNum:=oSerNum;
        ohTCH.Year:=oYear;
        ohTCH.StkNum:=gKey.TcbStkNum[ohTCH.BtrTable.BookNum];
        ohTCH.SmCode:=gKey.TcbSmCode[ohTCH.BtrTable.BookNum];
        ohTCH.DocDate:=oDocDate;
        ohTCH.FgCourse:=1;
        If ohPAB.LocatePaCode(ohTCH.PaCode) then BTR_To_BTR (ohPAB.BtrTable,ohTCH.BtrTable);
        ohTCH.Post;
      end;
      // Vytvorime polozky OD na zaklade DD
      mItgLog:=TItgLog.Create;
      mItmNum:=ohTCI.NextItmNum(ohTCH.DocNum);
      If oInd<>nil then begin
        oInd.Max:=mhTCH.ItmQnt;
        oInd.Position:=0;
      end;
      Repeat
        If oInd<>nil then oInd.StepBy(1);
        ohTCI.Insert;
        BTR_To_BTR (mhTCI.BtrTable,ohTCI.BtrTable);
        ohTCI.DocNum:=oDocNum;
        ohTCI.ItmNum:=mItmNum;
        ohTCI.ScdNum:=mhTCI.DocNum;
        ohTCI.ScdItm:=mhTCI.ItmNum;
        ohTCI.StkStat:='N';
        ohTCI.Post;
        // Historia operacii nad polozkami dokladov
        mItgLog.Add(mhTCI.DocNum,mhTCI.ItmNum,ohTCI.DocNum,ohTCI.ItmNum,oFrmName);
        Application.ProcessMessages;
        Inc (mItmNum);
        mhTCI.Next;
      until mhTCI.Eof or (mhTCI.DocNum<>pTcdNum);
      ohTCH.Clc(ohTCI);
      FreeAndNil (mItgLog);
      // Uložíme odkaz do DD na OD
      mhTCH.Edit;
      mhTCH.RcvName:=oDocNum;
      mhTCH.Post;
    end;
  end;
  FreeAndNil (mhTCI);
  FreeAndNil (mhTCH);
end;

procedure TTcd.TcdFromTod(pTobNum:Str5;pTodNum:Str12); // Vyhgeneruje OD z TV
var mItmNum:word;  mhTOH:TTohHnd;  mhTOI:TToiHnd;  mSav:TSavClc;  mItgLog:TItgLog;
begin
  mhTOH:=TTohHnd.Create;  mhTOH.Open(pTobNum);
  mhTOI:=TToiHnd.Create;  mhTOI.Open(pTobNum);
  If mhTOH.LocateDocNum(pTodNum) then begin
    If mhTOI.LocateDocNum(pTodNum) then begin
      If oYear='' then oYear:=gvSys.ActYear2; 
      If oSerNum=0 then oSerNum:=ohTCH.NextSerNum(oYear); // Ak nie je zadane poradove cislo OD vygenerujeme nasledujuce
      If oDocDate=0 then oDocDate:=Date; // Ak nie je zadany datum nastavime aktualny den
      oDocNum:=ohTCH.GenDocNum(oYear,oSerNum);
      If not ohTCH.LocateDocNum(oDocNum) then begin // Ak neexistuje vyvorime hlacicku dokladu OD
        ohTCH.Insert;
        BTR_To_BTR (mhTOH.BtrTable,ohTCH.BtrTable);
        ohTCH.DocNum:=oDocNum;
        ohTCH.ExtNum:=mhTOH.DocNum;
        ohTCH.SerNum:=oSerNum;
        ohTCH.Year:=oYear;
        ohTCH.StkNum:=mhTOH.StkNum;
//        ohTCH.StkNum:=gKey.TcbStkNum[ohTCH.BtrTable.BookNum];
        ohTCH.SmCode:=gKey.TcbSmCode[ohTCH.BtrTable.BookNum];
        ohTCH.DocDate:=oDocDate;
        ohTCH.FgCourse:=1;
        If ohPAB.LocatePaCode(ohTCH.PaCode) then BTR_To_BTR (ohPAB.BtrTable,ohTCH.BtrTable);
        ohTCH.Post;
      end;
      // Vytvorime polozky OD na zaklade DD
      mItgLog:=TItgLog.Create;
      mSav:=TSavClc.Create;
      mItmNum:=ohTCI.NextItmNum(ohTCH.DocNum);
      If oInd<>nil then begin
        oInd.Max:=mhTOH.ItmQnt;
        oInd.Position:=0;
      end;
      Repeat
        If oInd<>nil then oInd.StepBy(1);
        ohTCI.Insert;
        BTR_To_BTR (mhTOI.BtrTable,ohTCI.BtrTable);
        ohTCI.DocNum:=oDocNum;
        ohTCI.ItmNum:=mItmNum;
        ohTCI.ScdNum:=mhTOI.DocNum;
        ohTCI.ScdItm:=mhTOI.ItmNum;
        ohTCI.StkStat:='N';
        // Vypoèíteme predajné ceny
        mSav.GsQnt:=mhTOI.GsQnt;
        mSav.VatPrc:=mhTOI.VatPrc;
        mSav.FgBPrice:=mhTOI.BPrice;
        ohTCI.Sav:=mSav;
        ohTCI.Post;
        // Ulozime odkaz do polozky terminalovej vydajky na dodaci list
        mhTOI.Edit;
        mhTOI.TcdNum:=ohTCI.DocNum;
        mhTOI.TcdItm:=ohTCI.ItmNum;
        mhTOI.Post;
        // Historia operacii nad polozkami dokladov
        mItgLog.Add(mhTOI.DocNum,mhTOI.ItmNum,ohTCI.DocNum,ohTCI.ItmNum,oFrmName);
        Application.ProcessMessages;
        Inc (mItmNum);
        mhTOI.Next;
      until mhTOI.Eof or (mhTOI.DocNum<>pTodNum);
      ohTCH.Clc(ohTCI);
      FreeAndNil (mSav);
      FreeAndNil (mItgLog);
    end;
  end;
  FreeAndNil (mhTOI);
  FreeAndNil (mhTOH);
end;

procedure TTcd.TcdFromOcd(pOcdNum:Str12); // Vygeneruje OD zo ZK
var mTcbNum:Str5;  mItmNum:word;  mDoc:TDocFnc;  mSav:TSavClc;  mItgLog:TItgLog;
begin
  mDoc:=TDocFnc.Create;
  With mDoc do begin
    If oOcd.ohOCHLST.LocDocNum(pOcdNum) then begin
      If oOcd.ohOCILST.LocDocNum(pOcdNum) then begin
        If oYear='' then oYear:=oOcd.ohOCHLST.DocYer;
        If oSerNum=0 then oSerNum:=ohTCH.NextSerNum(oYear); // Ak nie je zadane poradove cislo OD vygenerujeme nasledujuce
        If oDocDate=0 then oDocDate:=Date; // Ak nie je zadany datum nastavime aktualny den
        oDocNum:=ohTCH.GenDocNum(oYear,oSerNum);
        If not ohTCH.LocateDocNum(oDocNum) then begin // Ak neexistuje vyvorime hlacicku dokladu OD
          mTcbNum:=ohTCH.BtrTable.BookNum;
          ohTCH.Insert;
          ohTCH.DocNum:=oDocNum;
          ohTCH.ExtNum:=GenExtNum(oDocDate,'',gKey.TcbExnFrm[mTcbNum],oSerNum,mTcbNum,gKey.TcbStkNum[mTcbNum]);
          ohTCH.SerNum:=oSerNum;
          ohTCH.Year:=oYear;
          ohTCH.StkNum:=oOcd.ohOCHLST.StkNum;
          ohTCH.SmCode:=gKey.TcbSmCode[BokNum];
          ohTCH.DocDate:=oDocDate;
          ohTCH.DlvDate:=Date;
          ohTCH.OcdNum:=oOcd.ohOCHLST.DocNum;
          ohTCH.StkNum:=oOcd.ohOCHLST.StkNum;
          ohTCH.PaCode:=oOcd.ohOCHLST.ParNum;
          ohTCH.PaName:=oOcd.ohOCHLST.ParNam;
          ohTCH.RegName:=oOcd.ohOCHLST.ParNam;
          ohTCH.RegIno:=oOcd.ohOCHLST.RegIno;
          ohTCH.RegTin:=oOcd.ohOCHLST.RegTin;
          ohTCH.RegVin:=oOcd.ohOCHLST.RegAdr;
          ohTCH.RegAddr:=oOcd.ohOCHLST.RegAdr;
          ohTCH.RegSta:=oOcd.ohOCHLST.RegSta;
          ohTCH.RegCty:=oOcd.ohOCHLST.RegCty;
          ohTCH.RegCtn:=oOcd.ohOCHLST.RegCtn;
          ohTCH.RegZip:=oOcd.ohOCHLST.RegZip;
          ohTCH.PayCode:=oOcd.ohOCHLST.PayCod;
          ohTCH.PayName:=oOcd.ohOCHLST.PayNam;
          ohTCH.SpaCode:=oOcd.ohOCHLST.SpaNum;
          ohTCH.WpaCode:=oOcd.ohOCHLST.WpaNum;
          ohTCH.WpaName:=oOcd.ohOCHLST.WpaNam;
          ohTCH.WpaAddr:=oOcd.ohOCHLST.WpaAdr;
          ohTCH.WpaSta:=oOcd.ohOCHLST.WpaSta;
          ohTCH.WpaCty:=oOcd.ohOCHLST.WpaCty;
          ohTCH.WpaCtn:=oOcd.ohOCHLST.WpaCtn;
          ohTCH.WpaZip:=oOcd.ohOCHLST.WpaZip;
          ohTCH.TrsCode:=oOcd.ohOCHLST.TrsCod;
          ohTCH.TrsName:=oOcd.ohOCHLST.TrsNam;
          ohTCH.RspName:=gvSys.UserName;
          ohTCH.VatDoc:=oOcd.ohOCHLST.VatDoc;
          ohTCH.SpMark:=oOcd.ohOCHLST.SpcMrk;
          ohTCH.WriNum:=oOcd.ohOCHLST.WriNum;
          ohTCH.PrjCode:=oOcd.ohOCHLST.PrjCod;
          ohTCH.VatPrc1:=gIni.GetVatPrc(1);
          ohTCH.VatPrc2:=gIni.GetVatPrc(2);
          ohTCH.VatPrc3:=gIni.GetVatPrc(3);
          ohTCH.VatPrc4:=gIni.GetVatPrc(4);
          ohTCH.VatPrc5:=gIni.GetVatPrc(5);
          ohTCH.FgDvzName:=oOcd.ohOCHLST.DvzNam;
          ohTCH.FgCourse:=1;
          If ohPAB.LocatePaCode(ohTCH.PaCode) then BTR_To_BTR (ohPAB.BtrTable,ohTCH.BtrTable);
          ohTCH.Post;
        end;
        // Vytvorime polozky OD na zaklade ZK
        mSav:=TSavClc.Create;
        mItmNum:=ohTCI.NextItmNum(ohTCH.DocNum);
        If oInd<>nil then begin
          oInd.Max:=oOcd.ohOCHLST.ItmQnt;
          oInd.Position:=0;
        end;
        Repeat
          If oInd<>nil then oInd.StepBy(1);
          If IsNotNul(oOcd.ohOCILST.RstPrq) then begin
            ohTCI.Insert;
            ohTCI.DocNum:=oDocNum;
            ohTCI.ItmNum:=mItmNum;
            ohTCI.MgCode:=oOcd.ohOCILST.PgrNum;
            ohTCI.GsCode:=oOcd.ohOCILST.ProNum;
            ohTCI.GsName:=oOcd.ohOCILST.ProNam;
            ohTCI.BarCode:=oOcd.ohOCILST.BarCod;
            ohTCI.StkCode:=oOcd.ohOCILST.StkCod;
            ohTCI.Notice:=oOcd.ohOCILST.Notice;
            ohTCI.StkNum:=oOcd.ohOCILST.StkNum;
            ohTCI.Volume:=oOcd.ohOCILST.ProVol;
            ohTCI.Weight:=oOcd.ohOCILST.ProWgh;
            ohTCI.MsName:=oOcd.ohOCILST.MsuNam;
            ohTCI.SpMark:=oOcd.ohOCILST.SpcMrk;
            ohTCI.WriNum:=oOcd.ohOCILST.WriNum;
            ohTCI.ScdNum:=oOcd.ohOCILST.DocNum;
            ohTCI.ScdItm:=oOcd.ohOCILST.ItmNum;
            ohTCI.McdNum:=oOcd.ohOCILST.McdNum;
            ohTCI.McdItm:=oOcd.ohOCILST.McdItm;
            ohTCI.OcdNum:=oOcd.ohOCILST.DocNum;
            ohTCI.OcdItm:=oOcd.ohOCILST.ItmNum;
            ohTCI.GsQnt:=oOcd.ohOCILST.RstPrq;
            ohTCI.DocDate:=ohTCH.DocDate;
            ohTCI.DlvDate:=ohTCH.DlvDate;
            ohTCI.PaCode:=ohTCH.PaCode;
            ohTCI.StkStat:='N';
            // Vypoèíteme predajné ceny
            mSav.GsQnt:=ohTCI.GsQnt;
            mSav.VatPrc:=oOcd.ohOCILST.VatPrc;
            mSav.FgBPrice:=oOcd.ohOCILST.SalBva;
            ohTCI.Sav:=mSav;
            ohTCI.Post;
            oOcd.ohOCILST.Edit;
            oOcd.ohOCILST.TcdPrq:=oOcd.ohOCILST.TcdPrq+oOcd.ohOCILST.RstPrq;
            oOcd.ohOCILST.RstPrq:=0;
            oOcd.ohOCILST.TcdNum:=ohTCI.DocNum;
            oOcd.ohOCILST.TcdItm:=ohTCI.ItmNum;
            oOcd.ohOCILST.TcdDte:=ohTCI.DocDate;
            oOcd.ohOCILST.TcdDoq:=1;
            oOcd.ohOCILST.Post;
            oStk.StcClc(oOcd.ohOCILST.StkNum,oOcd.ohOCILST.ProNum);
            Application.ProcessMessages;
            Inc (mItmNum);
          end;
          oOcd.ohOCILST.Next;
        until oOcd.ohOCILST.Eof or (oOcd.ohOCILST.DocNum<>pOcdNum);
        If gKey.TcbOnlSub[mTcbNum] then SubDoc;
        ohTCH.Clc(ohTCI);
        FreeAndNil (mSav);
      end
      else ShowMsg(eCom.DocNoHaveItm,pOcdNum);
    end
    else ShowMsg(eCom.DocIsNoExist,pOcdNum);
  end;
  FreeAndNil (mDoc);
end;

// ********************************** PUBLIC ***********************************

function TTcd.ActBok:Str5;
begin
  Result:='';
  If ohTCH.BtrTable.Active
    then Result:=ohTCH.BtrTable.BookNum
    else begin
      If ohTCI.BtrTable.Active
        then Result:=ohTCI.BtrTable.BookNum
        else begin
          If ohTCN.BtrTable.Active then Result:=ohTCN.BtrTable.BookNum
        end;
    end;
end;

procedure TTcd.Open(pBokNum:Str5); // Otvori vsetky databazove subory
begin
  Open (pBokNum,TRUE,TRUE,TRUE,TRUE);
end;

procedure TTcd.Open(pBokNum:Str5;pTCH,pTCI,pTCN,pTCC:boolean); // Otvori zadane databazove subory
var mFind:boolean;  mCnt:word;  mDat:PDat;
begin
  oBokNum:=pBokNum;
  mFind:=FALSE;
  If oLst.Count>0 then begin
    mCnt:=0;
    Repeat
      Inc (mCnt);
      Activate(mCnt);
      mFind:=ActBok=pBokNum;
    until mFind or (mCnt=oLst.Count);
  end;
  If not mFind then begin // Ak dana kniha este nie je otvorena potomotvorime
    // Vytvorime objekty
    ohTCH:=TTchHnd.Create;
    ohTCI:=TTciHnd.Create;
    ohTCC:=TTccHnd.Create;
    ohTCN:=TTcnHnd.Create;
    // Otvorime databazove subory
    If pTCH then ohTCH.Open(pBokNum);
    If pTCI then ohTCI.Open(pBokNum);
    If pTCC then ohTCC.Open(pBokNum);
    If pTCN then ohTCN.Open(pBokNum);
    ohCPH.Close;
    ohCPI.Close;
    If gKey.TcbCpiBok[pBokNum]<>'' then
    begin
      ohCPH.Open(gKey.TcbCpiBok[pBokNum]);
      ohCPI.Open(gKey.TcbCpiBok[pBokNum]);
    end;
    // Ulozime objekty do zoznamu
    GetMem (mDat,SizeOf(TDat));
    mDat^.rhTCH:=ohTCH;
    mDat^.rhTCI:=ohTCI;
    mDat^.rhTCC:=ohTCC;
    mDat^.rhTCN:=ohTCN;
    oLst.Add(mDat);
  end;
end;

procedure TTcd.SlcItm(pDocNum:Str12); // nacita polozky zadaneho dokladu do PX
begin
  oNoeVal:=0;  oNoeItm:=0;
  If otTCI.Active then otTCI.Close;
  otTCI.Open;
  If ohTCI.LocateDocNum(pDocNum) then begin
    Repeat
      otTCI.Insert;
      BTR_To_PX(ohTCI.BtrTable,otTCI.TmpTable);
      otTCI.NoeQnt:=otTCI.GsQnt-otTCI.ExpQnt;
      otTCI.Post;
      If IsNotNul(otTCI.GsQnt-otTCI.ExpQnt) then begin
        Inc(oNoeItm);
        oNoeVal:=oNoeVal+(otTCI.GsQnt-otTCI.ExpQnt)*otTCI.FgBPrice;
      end;
      Application.ProcessMessages;
      ohTCI.Next;
    until ohTCI.Eof or (ohTCI.DocNum<>pDocNum);
  end;
  If otTCC.Active then otTCC.Close;
  otTCC.Open;
  If ohTCC.LocateTcdNum(pDocNum) then begin
    Repeat
      otTCC.Insert;
      BTR_To_PX (ohTCC.BtrTable,otTCC.TmpTable);
      otTCC.Post;
      Application.ProcessMessages;
      ohTCC.Next;
    until ohTCC.Eof or (ohTCC.TcdNum<>pDocNum);
  end;
end;

procedure TTcd.PrnPdfDoc(pDocNum,pMasNam:Str12;pPdfNam:Str50);  // Tlaè adaného dokladu do PDF súboru
begin
  PrnDoc(pDocNum,pMasNam,TRUE,'PDFCreator',pPdfNam,1);
end;

procedure TTcd.PrnDoc; // Vytlaèí zadany dodaci list
begin
  PrnDoc(ohTCH.DocNum,'',FALSE,'','',0);
end;

procedure TTcd.PrnDoc(pDocNum,pMasNam:Str12;pAutPrn:boolean;pPrnNam,pPdfNam:Str50;pCopies:word); // Vytlaèí zadany dodaci list
var mJrn:TJrn;  mRep:TRep;  mtTCH:TTchTmp;  mhSYSTEM:TSystemHnd;  mBokNum:Str5;  mInfVal:double;
begin
  mBokNum:=BookNumFromDocNum(pDocNum);
  If pMasNam='' then pMasNam:='TCD';
  If pPdfNam='' then pPdfNam:=pDocNum;
  Open (mBokNum);
  ohTCH.SwapIndex;
  If ohTCH.LocateDocNum(pDocNum) then begin
    mhSYSTEM:=TSystemHnd.Create;  mhSYSTEM.Open;
    mtTCH:=TTchTmp.Create;   mtTCH.Open;
    mtTCH.Insert;
    BTR_To_PX(ohTCH.BtrTable,mtTCH.TmpTable);
    mtTCH.FgVatVal1:=ohTCH.FgBValue1-ohTCH.FgAValue1;
    mtTCH.FgVatVal2:=ohTCH.FgBValue2-ohTCH.FgAValue2;
    mtTCH.FgVatVal3:=ohTCH.FgBValue3-ohTCH.FgAValue3;
    If ohTCN.LocateDoNtLn(pDocNum,'',0) then mtTCH.Notice1:=ohTCN.Notice;
    If ohTCN.LocateDoNtLn(pDocNum,'',1) then mtTCH.Notice2:=ohTCN.Notice;
    If ohTCN.LocateDoNtLn(pDocNum,'',2) then mtTCH.Notice3:=ohTCN.Notice;
    If ohTCN.LocateDoNtLn(pDocNum,'',3) then mtTCH.Notice4:=ohTCN.Notice;
    If ohTCN.LocateDoNtLn(pDocNum,'',4) then mtTCH.Notice5:=ohTCN.Notice;
    mtTCH.DlrName:=GetDlrName(ohTCH.DlrCode);
    mtTCH.Post;
    SlcItm(pDocNum);
    mJrn:=TJrn.Create;
    mJrn.DocAcc(pDocNum);
    If gIni.StkCodePrnShort then otTCI.SetIndex('ScBc');
    // --------------------------
    mRep:=TRep.Create(Self);
    mRep.SysBtr:=mhSYSTEM.BtrTable;
    mRep.HedTmp:=mtTCH.TmpTable;
    mRep.SpcTmp:=mJrn.ptDOCACC.TmpTable;
    mRep.ItmTmp:=otTCI.TmpTable;
    If pAutPrn
      then mRep.ExecuteQuick(pMasNam,pPrnNam,pPdfNam,pCopies)
      else mRep.Execute('TCD');
    If mRep.PrnQnt>0 then begin // Ulozime pocet vytlacenych kopii
      ohTCH.BtrTable.Modify:=FALSE;
      ohTCH.BtrTable.Sended:=FALSE;
      ohTCH.Edit;
      ohTCH.PrnCnt:=ohTCH.PrnCnt+mRep.PrnQnt;
      If gKey.TcbPrnCls[mBokNum] then ohTCH.DstLck:=1; // Uzatvorime doklad
      ohTCH.Post;
      ohTCH.BtrTable.Sended:=TRUE;
      ohTCH.BtrTable.Modify:=TRUE;
    end;
    FreeAndNil (mRep);
    // --------------------------
    FreeAndNil(mJrn);
    FreeAndNil(mtTCH);
    FreeAndNil(mhSYSTEM);
  end;
  ohTCH.RestoreIndex;
end;

procedure TTcd.PrnPck(pDocNum:Str12); // Tlaè pod¾a balenia
var mRep:TRep;  mtTCH:TTchTmp;  mhSYSTEM:TSystemHnd;  mBokNum:Str5;  mInfVal:double; 
begin
  mBokNum:=BookNumFromDocNum(pDocNum);
  Open(mBokNum);
  If ohTCH.LocateDocNum(pDocNum) then begin
    mhSYSTEM:=TSystemHnd.Create;  mhSYSTEM.Open;
    mtTCH:=TTchTmp.Create;   mtTCH.Open;
    mtTCH.Insert;
    BTR_To_PX (ohTCH.BtrTable,mtTCH.TmpTable);
    mtTCH.FgVatVal1:=ohTCH.FgBValue1-ohTCH.FgAValue1;
    mtTCH.FgVatVal2:=ohTCH.FgBValue2-ohTCH.FgAValue2;
    mtTCH.FgVatVal3:=ohTCH.FgBValue3-ohTCH.FgAValue3;
    mtTCH.FgVatVal4:=ohTCH.FgBValue4-ohTCH.FgAValue4;
    mtTCH.FgVatVal5:=ohTCH.FgBValue5-ohTCH.FgAValue5;

    mtTCH.DlrName  :=GetDlrName(ohTCH.DlrCode);
    mtTCH.Post;

    otTCI.Open;
    If ohTCI.LocateDocNum(pDocNum) then begin
      Repeat
        If otTCI.LocGcSm(ohTCI.GsCode,ohTCI.SpMark) then begin
          otTCI.Edit;
          otTCI.GsQnt:=otTCI.GsQnt+ohTCI.GsQnt;
          otTCI.FgAValue:=otTCI.FgAValue+ohTCI.FgAValue;
          otTCI.FgBValue:=otTCI.FgBValue+ohTCI.FgBValue;
          If ohTCI.RbaDate<otTCI.RbaDate then otTCI.RbaDate:=ohTCI.RbaDate;
          otTCI.Post;
        end else begin
          otTCI.Insert;
          BTR_To_PX (ohTCI.BtrTable,otTCI.TmpTable);
          otTCI.PckQnt:=1;
(*
          If mhAGRITM.LocatePaGs(ohTCH.PaCode,ohTCI.GsCode) then begin
            If mhAGRITM.CsName<>'' then otTCI.GsName:=mhAGRITM.CsName;
            If mhAGRITM.CsCode<>'' then otTCI.CsCode:=mhAGRITM.CsCode;
          end;
*)
          otTCI.Post;
        end;
        Application.ProcessMessages;
        ohTCI.Next;
      until ohTCI.Eof or (ohTCI.DocNum<>pDocNum);
    end;
//    FreeAndNil(mhAGRITM);
    // --------------------------
    mRep:=TRep.Create(Self);
    mRep.SysBtr:=mhSYSTEM.BtrTable;
    mRep.HedTmp:=mtTCH.TmpTable;
    mRep.ItmTmp:=otTCI.TmpTable;
    mRep.Execute('TCP');
    If mRep.PrnQnt>0 then begin // Ulozime pocet vytlacenych kopii
      ohTCH.BtrTable.Modify:=FALSE;
      ohTCH.BtrTable.Sended:=FALSE;
      ohTCH.Edit;
      ohTCH.PrnCnt:=ohTCH.PrnCnt+mRep.PrnQnt;
      If gKey.TcbPrnCls[mBokNum] then ohTCH.DstLck:=1; // Uzatvorime doklad
      ohTCH.Post;
      ohTCH.BtrTable.Sended:=TRUE;
      ohTCH.BtrTable.Modify:=TRUE;
    end;
    FreeAndNil (mRep);
    // --------------------------
    FreeAndNil (mtTCH);
    FreeAndNil (mhSYSTEM);
  end;
end;

procedure TTcd.ResDoc(pYear:Str2;pSerNum:longint); // Zarezervuje zdoklad so zadanym poradovym cislom
begin
  If not ohTCH.LocateYearSerNum(pYear,pSerNum) then ohTCH.Res(pYear,pSerNum);
end;

procedure TTcd.NewDoc(pYear:Str2;pPaCode:longint;pResDoc:boolean); // Vygeneruje novu hlavicku dokladu
begin
  NewDoc(pYear,pPaCode,0,pResDoc);
end;

procedure TTcd.NewDoc(pYear:Str2;pPaCode:longint;pStkNum:word;pResDoc:boolean); // Vygeneruje novu hlavicku dokladu
begin
  oYear:=pYear;If oYear='' then oYear:=gvsys.ActYear2;
  If oSerNum=0 then oSerNum:=ohTCH.NextSerNum(oYear); // Ak nie je zadane poradove cislo OD vygenerujeme nasledujuce
  If oDocDate=0 then oDocDate:=Date; // Ak nie je zadany datum nastavime aktualny den
  oDocNum:=ohTCH.GenDocNum(Year,oSerNum);
  If not ohTCH.LocateDocNum(oDocNum) then begin // Ak neexistuje vyvorime hlacicku dokladu OD
    ohTCH.Insert;
    ohTCH.DocNum:=oDocNum;
    ohTCH.SerNum:=oSerNum;
    ohTCH.Year:=oYear;
    If pStkNum<>0
      then ohTCH.StkNum:=pStkNum
      else ohTCH.StkNum:=gKey.TcbStkNum[BokNum];
    ohTCH.PlsNum:=gKey.TcbPlsNum[BokNum];
    ohTCH.ExtNum:=GenExtNum(oDocDate,'',gKey.TcbExnFrm[BokNum],oSerNum,BokNum,ohTCH.StkNum);
    ohTCH.SmCode:=gKey.TcbSmCode[BokNum];
    ohTCH.DocDate:=oDocDate;
    ohTCH.RspName:=gvSys.UserName;
    If ohPAB.LocatePaCode(pPaCode) then begin
      BTR_To_BTR (ohPAB.BtrTable,ohTCH.BtrTable);
      ohTCH.TrsCode:=ohPAB.IcTrsCode;
      ohTCH.TrsName:=ohPAB.IcTrsName;
      ohTCH.PayCode:=ohPAB.IcPayCode;
      ohTCH.PayName:=ohPAB.IcPayName;
      If ohPAB.IcPlsNum<>0 then ohTCH.PlsNum:=ohPAB.IcPlsNum;
      // Zadat aj miesto dodania
    end;
    ohTCH.SpaCode:=ohTCH.PaCode;
    ohTCH.WpaName:=ohTCH.PaName;
    ohTCH.WpaAddr:=ohTCH.RegAddr;
    ohTCH.WpaSta:=ohTCH.RegSta;
    ohTCH.WpaCty:=ohTCH.RegCty;
    ohTCH.WpaCtn:=ohTCH.RegCtn;
    ohTCH.WpaZip:=ohTCH.RegZip;
    ohTCH.AcDvzName:=gKey.SysAccDvz;
    ohTCH.FgDvzName:=gKey.TcbDvName[BokNum];
    ohTCH.FgCourse:=1;
    ohTCH.VatDoc:=1;
    If pResDoc
      then ohTCH.DstLck:=9
      else ohTCH.DstLck:=0;
    ohTCH.Post;
  end;
end;

procedure TTcd.CnfDoc; // potvrdenie dokladu nastavi priznak rezervacie DstLck=9 na 0
begin
  If ohTCH.DstLck=9 then begin
    ohTCH.Edit;
    ohTCH.DstLck:=0;
    ohTCH.Post;
  end;
end;

procedure TTcd.CncDoc; // Storno rezervovaneho dokladu DstLck=9
begin
  If (ohTCH.DstLck=9) and not ohTCI.LocateDocNum(ohTCH.DocNum) and not ohTCC.LocateTcdNum(ohTCH.DocNum)
  then begin
    ohTCH.Delete;
  end;
  oSerNum:=0;
end;

procedure TTcd.AddItm(pGsCode:longint;pGsQnt,pDscPrc,pFgBPrice:double); // Prida novu polozku na zadany dodaci lsit
begin
  AddItm(pGsCode,pGsQnt,0,pDscPrc,pFgBPrice);
end;

procedure TTcd.AddItm(pGsCode:longint;pGsQnt,pAcCPrice,pDscPrc,pFgBPrice:double); // Prida novu polozku na zadany dodaci lsit
var mItmNum:word;
begin
  If not ohGSCAT.Active then ohGSCAT.Open;
  If ohGSCAT.LocateGsCode(pGsCode) then begin
    mItmNum:=ohTCI.NextItmNum(ohTCH.DocNum);
    ohTCI.Insert;
    ohTCI.DocNum:=ohTCH.DocNum;
    ohTCI.ItmNum:=mItmNum;
    BTR_To_BTR(ohGSCAT.BtrTable,ohTCI.BtrTable);
    ohTCI.GsQnt:=pGsQnt;
    ohTCI.DscPrc:=pDscPrc;
    ohTCI.AcCValue:=RdX(pAcCPrice*pGsQnt,gKey.StpRndFrc);
    ohTCI.FgCValue:=ClcFgFromAcS(ohTCI.AcCValue,ohTCH.FgCourse);
    If ohTCI.GsQnt<>0 then ohTCI.FgCPrice:=ohTCI.FgCValue/ohTCI.GsQnt;
    ohTCI.SetFgBPrice(pFgBPrice,ohTCH.FgCourse,ohTCH.VatDoc);
    ohTCI.StkNum:=ohTCH.StkNum;
    ohTCI.WriNum:=ohTCH.WriNum;
    ohTCI.PaCode:=ohTCH.PaCode;
    ohTCI.DocDate:=ohTCH.DocDate;
    ohTCI.StkStat:='N';
    ohTCI.Post;
    AddItc(ohTCI.DocNum,mItmNum);
  end
  else ShowMsg (eCom.GscIsNoExist,StrInt(pGsCode,0));
end;

procedure TTcd.AddItm(pStkNum,pGsCode:longint;pGsQnt,pAcCPrice,pDscPrc,pFgBPrice:double;pWriNum:longint;pSpMark:Str10); // Prida novu polozku na zadany dodaci lsit
var mItmNum:word;
begin
  If not ohGSCAT.Active then ohGSCAT.Open;
  If ohGSCAT.LocateGsCode(pGsCode) then begin
    mItmNum:=ohTCI.NextItmNum(ohTCH.DocNum);
    ohTCI.Insert;
    ohTCI.DocNum:=ohTCH.DocNum;
    ohTCI.ItmNum:=mItmNum;
    BTR_To_BTR(ohGSCAT.BtrTable,ohTCI.BtrTable);
    ohTCI.GsQnt:=pGsQnt;
    ohTCI.DscPrc:=pDscPrc;
    ohTCI.AcCValue:=RdX(pAcCPrice*pGsQnt,gKey.StpRndFrc);
    ohTCI.FgCValue:=ClcFgFromAcS(ohTCI.AcCValue,ohTCH.FgCourse);
    If ohTCI.GsQnt<>0 then ohTCI.FgCPrice:=ohTCI.FgCValue/ohTCI.GsQnt;
    ohTCI.SetFgBPrice(pFgBPrice,ohTCH.FgCourse,ohTCH.VatDoc);
    ohTCI.StkNum:=ohTCH.StkNum;
    ohTCI.WriNum:=ohTCH.WriNum;
    ohTCI.PaCode:=ohTCH.PaCode;
    ohTCI.DocDate:=ohTCH.DocDate;
    ohTCI.SpMark:=pSpMark;
    ohTCI.StkStat:='N';
    If pStkNum>0 then ohTCI.StkNum :=pStkNum;
    If pWriNum>0 then ohTCI.WriNum :=pWriNum;
    ohTCI.Post;
    AddItc(ohTCI.DocNum,mItmNum);
  end
  else ShowMsg (eCom.GscIsNoExist,StrInt(pGsCode,0));
end;

procedure TTcd.RefTmp(pPxTable:TNexPxTable); // Naèíta naposledy uloženú položku do doèasného súboru
begin
  pPxTable.Insert;
  BTR_To_PX(ohTCI.BtrTable,pPxTable); // Ulozi zaznam z btTCI do ptTCI
  pPxTable.Post;
end;

procedure TTcd.AddRba(pStkNum,pGsCode:longint;pGsQnt,pDscPrc,pFgAPrice,pFgBPrice:double;pRbaCode:Str30;pRbaDate:TDate;pFifStr:String;pPxTable:TNexPxTable;pSpMark:Str10);  // Prida novu polozku so sarzou na zadany dodaci list
var mJ,mI,mItmNum:word; mStk:TStk; mQnt,mSQnt:double; mRbaCode,mLine,mStr:String;
    mFifNum:longint; mL:TStrings;
begin
  If not ohGSCAT.Active then ohGSCAT.Open;
  If not ohGSCAT.LocateGsCode(pGsCode) then begin
    ShowMsg (eCom.GscIsNoExist,StrInt(pGsCode,0));
    Exit;
  end;
  If IsNul(pGsQnt) then Exit;
  mStk:=TStk.Create;
  If Eq3(pFgAPrice,pFgBPrice) then pFgBPrice:=RoundFgABPrice(pFgAPrice*(1+ohGSCAT.VatPrc/100));
  If pGsQnt<0 then begin
    // Dobropis
    AddItm(pStkNum,pGsCode,pGsQnt,0,pDscPrc,pFgBPrice,ohTCH.WriNum,pSpMark);
    ohTCI.Edit; ohTCI.RbaCode:= pRbaCode; ohTCI.RbaDate:= pRbaDate; ohTCI.Post;
    ohTCH.Edit; ohTCH.RbaCode:= ohTCI.RbaCode; ohTCH.RbaDate:= ohTCI.RbaDate; ohTCH.Post;
    mStk.Clear;
    mStk.SmSign:='-';  // Vydaj tovaru
    mStk.DocNum:=ohTCI.DocNum;
    mStk.ItmNum:=ohTCI.ItmNum;
    mStk.DocDate:=ohTCI.DocDate;
    mStk.GsCode:=ohTCI.GsCode;
    mStk.MgCode:=ohTCI.MgCode;
    mStk.BarCode:=ohTCI.BarCode;
    mStk.SmCode:=ohTCH.SmCode;
    mStk.PaCode:=ohTCH.PaCode;
    mStk.GsName:=ohTCI.GsName;
    mStk.GsQnt:=ohTCI.GsQnt;
    mStk.CValue:=ohTCI.AcCValue;
    mStk.RbaCode:=ohTCI.RbaCode;
    mStk.RbaDate:=ohTCI.RbaDate;
    If IsNotNul(mStk.GsQnt) then mStk.CPrice:=RdX(ohTCI.AcCValue/ohTCI.GsQnt,gKey.StpRndFrc);
    If mStk.Sub(ohTCI.StkNum) then begin // Ak sa podarilo vydat polozky
      ohTCI.Edit;
      If ohTCI.GsQnt<0
        then ohTCI.AcCValue:=0-Abs(mStk.CValue)
        else ohTCI.AcCValue:=Abs(mStk.CValue);
      ohTCI.FgCValue:=ClcFgFromAcS(ohTCI.AcCValue,ohTCH.FgCourse);
      If ohTCI.GsQnt<>0 then ohTCI.FgCPrice:=ohTCI.FgCValue/ohTCI.GsQnt;
      ohTCI.StkStat:='S';
      ohTCI.Post;
      pPxTable.Insert;
      BTR_To_PX(ohTCI.BtrTable,pPxTable); // Ulozi zaznam z btTCI do ptTCI
      pPxTable.Post;
    end;
  end else begin
    mL:=TStringList.Create;
    If pStkNum>0 then mStk.StkNum:=pStkNum else mStk.StkNum:=ohTCH.StkNum;
    If pFifStr='' then begin
      mQnt:=pGsQnt;
      mRbaCode:=pRbaCode;
      mStk.ohFIF.LocateGcRc(pGsCode,pRbaCode);
      while not mStk.ohFIF.Eof and(mStk.ohFIF.GsCode=pGsCode) and(mQnt>0) and(mStk.ohFIF.RbaCode=pRbaCode) do
      begin
        If (mStk.ohFIF.Status='A' )then begin
          If mqnt>mStk.ohFIF.ActQnt
            then mStr:=mStr+'|'+IntToStr(mStk.ohFIF.FifNum)+'*'+StrDoub(mStk.ohFIF.ActQnt,0,5)
            else mStr:=mStr+'|'+IntToStr(mStk.ohFIF.FifNum)+'*'+StrDoub(mQnt,0,5);
          mQnt:=mQnt-mStk.ohFIF.ActQnt;
        end;
        mStk.ohFIF.Next;
      end;
      If mStr<>'' then begin
        Delete (mStr,1,1);
        mL.Add(mRbaCode+'='+mStr);
      end;
      mRbaCode:='';mStr:='';
      mStk.ohFIF.NearestGcRc(pGsCode,'');
      while not mStk.ohFIF.Eof and(mStk.ohFIF.GsCode=pGsCode) and(mQnt>0) do begin
        If mRbaCode<>mStk.ohFIF.RbaCode then begin
          If mStr<>'' then begin
            Delete (mStr,1,1);
            mL.Add(mRbaCode+'='+mStr);
          end;
          mRbaCode:=mStk.ohFIF.RbaCode;mStr:='';
        end;
        If (mStk.ohFIF.Status='A' )and(mStk.ohFIF.RbaCode='') then begin
          If mqnt>mStk.ohFIF.ActQnt
            then mStr:=mStr+'|'+IntToStr(mStk.ohFIF.FifNum)+'*'+StrDoub(mStk.ohFIF.ActQnt,0,5)
            else mStr:=mStr+'|'+IntToStr(mStk.ohFIF.FifNum)+'*'+StrDoub(mQnt,0,5);
          mQnt:=mQnt-mStk.ohFIF.ActQnt;
        end;
        mStk.ohFIF.Next;
      end;
      If mStr<>'' then begin
        Delete (mStr,1,1);
        mL.Add(mRbaCode+'='+mStr);
      end;
    end else begin
      mL.Clear;
      for mJ:=0 to LineElementNum(pFifStr,'|')-1 do begin
        mStr:=LineElement(pFifStr,mJ,'|');
        mFifNum:=ValInt(LineElement(mStr,0,'*'));
        mQnt:=ValDoub(LineElement(mStr,1,'*'));
        If mStk.ohFIF.LocateFifNum(mFifNum)
          then mRbaCode:=mStk.ohFIF.RbaCode;
        If mL.IndexOfName(mRbaCode)=-1
          then mL.Add(mRbaCode+'='+mStr)
          else mL.Values[mRbaCode]:=mL.Values[mRbaCode]+'|'+mStr;
      end;
    end;
    If mL.Count>0 then begin
      For mI:=0 to ml.Count-1 do begin
        mRbaCode:=mL.Names[mI];
        mLine:=mL.Values[mRbaCode];
        mSQnt:=0;
        mStk.FifLst.Clear;
        for mJ:=0 to LineElementNum(mLine,'|')-1 do begin
          mStr:=LineElement(mLine,mJ,'|');
          mFifNum:=ValInt(LineElement(mStr,0,'*'));
          mQnt:=ValDoub(LineElement(mStr,1,'*'));
          mSQnt:=mSQnt+mQnt;
          mStk.ohFIF.LocateFifNum(mFifNum);
          mStk.FifLst.Add(mFifNum,mQnt,mStk.ohFIF.InPrice,mStk.ohFIF.PaCode,
            mStk.ohFIF.AcqStat,mStk.ohFIF.RbaDate,mStk.ohFIF.RbaCode,mStk.ohFIF.ActPos);
        end;
        mItmNum:=ohTCI.NextItmNum(ohTCH.DocNum);
        ohTCI.Insert;
        ohTCI.DocNum:=ohTCH.DocNum;
        ohTCI.ItmNum:=mItmNum;
        BTR_To_BTR(ohGSCAT.BtrTable,ohTCI.BtrTable);
        ohTCI.GsQnt:=mSQnt;
        ohTCI.DscPrc:=pDscPrc;
        If mStk.ohFIF.RbaCode=''
          then ohTCI.RbaCode:=pRbaCode
          else ohTCI.RbaCode:=mStk.ohFIF.RbaCode;
        ohTCI.RbaDate:=mStk.ohFIF.RbaDate;
        ohTCI.SetFgBPrice(pFgBPrice,ohTCH.FgCourse,ohTCH.VatDoc);
        ohTCI.StkNum:=ohTCH.StkNum;
        ohTCI.WriNum:=ohTCH.WriNum;
        ohTCI.PaCode:=ohTCH.PaCode;
        ohTCI.DocDate:=ohTCH.DocDate;
        ohTCI.SpMark:=pSpMark;
        ohTCI.StkStat:='N';
        If pStkNum>0 then ohTCI.StkNum :=pStkNum;
    //    If pWriNum>0 then ohTCI.WriNum :=pWriNum;
        ohTCI.Post;
        ohTCH.Edit;
        ohTCH.RbaCode:= ohTCI.RbaCode;
        ohTCH.RbaDate:= ohTCI.RbaDate;
        ohTCH.Post;
        mStk.Clear;
        mStk.SmSign:='-';  // Vydaj tovaru
        mStk.DocNum:=ohTCI.DocNum;
        mStk.ItmNum:=ohTCI.ItmNum;
        mStk.DocDate:=ohTCI.DocDate;
        mStk.GsCode:=ohTCI.GsCode;
        mStk.MgCode:=ohTCI.MgCode;
        mStk.BarCode:=ohTCI.BarCode;
        mStk.SmCode:=ohTCH.SmCode;
        mStk.PaCode:=ohTCH.PaCode;
        mStk.GsName:=ohTCI.GsName;
        mStk.GsQnt:=mSQnt;
        mStk.MyOut;  // Vydá z príslušnej fifo karty
        ohTCI.Edit;
        ohTCI.StkStat:='S';
        ohTCI.AcCValue:=mStk.CValue;
        ohTCI.FgCValue:=ClcFgFromAcS(ohTCI.AcCValue,ohTCH.FgCourse);
        If mSQnt<>0 then ohTCI.FgCPrice:=ohTCI.FgCValue/mSQnt;
        ohTCI.Post;
        pPxTable.Insert;
        BTR_To_PX(ohTCI.BtrTable,pPxTable); // Ulozi zaznam z btTCI do ptTCI
        pPxTable.Post;
      end;
    end else begin
      mItmNum:=ohTCI.NextItmNum(ohTCH.DocNum);
      ohTCI.Insert;
      ohTCI.DocNum:=ohTCH.DocNum;
      ohTCI.ItmNum:=mItmNum;
      BTR_To_BTR(ohGSCAT.BtrTable,ohTCI.BtrTable);
      ohTCI.GsQnt:=pGsQnt;
      ohTCI.DscPrc:=pDscPrc;
      ohTCI.RbaCode:=pRbaCode;
      ohTCI.RbaDate:=pRbaDate;
  //    ohTCI.AcCValue:=RdX(pAcCPrice*pGsQnt,gKey.StpRndFrc);
  //    ohTCI.FgCValue:=ClcFgFromAcS(ohTCI.AcCValue,ohTCH.FgCourse);
  //    If ohTCI.GsQnt<>0 then ohTCI.FgCPrice:=ohTCI.FgCValue/ohTCI.GsQnt;
      ohTCI.SetFgBPrice(pFgBPrice,ohTCH.FgCourse,ohTCH.VatDoc);
      ohTCI.StkNum:=ohTCH.StkNum;
      ohTCI.WriNum:=ohTCH.WriNum;
      ohTCI.PaCode:=ohTCH.PaCode;
      ohTCI.DocDate:=ohTCH.DocDate;
      ohTCI.StkStat:='N';
      If pStkNum>0 then ohTCI.StkNum :=pStkNum;
  //    If pWriNum>0 then ohTCI.WriNum :=pWriNum;
      ohTCI.Post;
      ohTCH.Edit;
      ohTCH.RbaCode:= ohTCI.RbaCode;
      ohTCH.RbaDate:= ohTCI.RbaDate;
      ohTCH.Post;
      pPxTable.Insert;
      BTR_To_PX(ohTCI.BtrTable,pPxTable); // Ulozi zaznam z btTCI do ptTCI
      pPxTable.Post;
    end;
    FreeAndNil(mL);
  end;
  FreeAndNil(mStk);
  ohTCH.Clc(ohTCI);
end;

procedure TTcd.InsTcc(var pNextNum:word;pTcdItm,pTccItm:longint;pDocDate:TDateTime;pStkNum,pPaCode:integer;pGsQnt:double);
var mPdGsQnt:double;
begin
  ohTCC.SwapStatus;
  If ohCPH.LocatePdCode(ohTCC.CpCode) then begin
    ohCPI.LocatePdCode(ohTCC.CpCode);
    while not ohCPI.Eof and (ohCPI.PdCode=ohCPH.PdCode) do begin
      mPdGsQnt:=ohCPI.PdGsQnt;
      If IsNul (mPdGsQnt) then mPdGsQnt:=ohCPH.PdGsQnt;
      If IsNul (mPdGsQnt) then mPdGsQnt:=1;
      ohTCC.Insert;
      ohTCC.TcdNum :=oDocNum;
      ohTCC.TcdItm :=pTcdItm;
      ohTCC.TccItm :=pNextNum;
      ohTCC.Parent :=pTccItm;
      ohTCC.PdCode :=ohCPH.PdCode;
      ohTCC.CpCode :=ohCPI.CpCode;
      ohTCC.CpName :=ohCPI.CpName;
      ohTCC.BarCode:=ohCPI.BarCode;
      ohTCC.MsName :=ohCPI.MsName;
      ohTCC.DocDate:=pDocDate;
      ohTCC.StkNum :=pStknum;
      ohTCC.ItmType:=ohCPI.ItmType;
      ohTCC.MgCode :=ohCPI.MgCode;
      ohTCC.GsType :=ohGSCAT.GsType;
      ohTCC.CPrice :=0;
      ohTCC.CValue :=0;
      ohTCC.StkStat:='N';
      ohTCC.PaCode :=pPaCode;
      ohTCC.AcCValue:= 0;
      ohTCC.FgCPrice:= 0;
      ohTCC.FgCValue:= 0;
      ohTCC.DocDate:=pDocDate;
      ohTCC.DlvDate:=0;
      ohTCC.DrbDate:=0;
      ohTCC.DlvUser:='';
      ohTCC.PdGsQnt:=pGsQnt;
      ohTCC.LosPrc :=ohCPI.LosPrc;
      ohTCC.RcGsQnt:=Rd3(pGsQnt*ohCPI.RcGsQnt/mPdGsQnt);
      ohTCC.CpSeQnt:=Rd3(ohTCC.RcGsQnt*(1+ohCPI.LosPrc/100));
      If ohTCC.ItmType = 'W' then begin
        ohTCC.CPrice:=ohCPI.CPrice;
        ohTCC.CValue:=ohCPI.CPrice*ohTCC.CpSeQnt;
        ohTCC.CpSuQnt:=ohTCC.CpSeQnt;
      end;
      ohCPI.SwapStatus;
      If (ohTCC.PdCode<>ohTCC.CpCode) and ohCPI.LocatePdCode(ohTCC.CpCode)
        then ohTCC.ItmType:='X';
      ohCPI.RestoreStatus;
      ohTCC.Post;
      Inc(pNextNum);
      Application.ProcessMessages;
      ohCPI.Next;
    end;
  end;
  ohTCC.RestoreStatus;
end;


procedure TTcd.AddItc(pDocNum:Str12;pItmNum:longint); // Prida komponenty polozky na zadany dodaci lsit
var mSerNum:word; mPdGsQnt:double;mItmNum:word; mSumQnt,mSumVal,mCpSeQnt:double; mF: boolean;
begin
  If oDocNum<>pDocNum then LocDoc(pDocNum);
  If ohTCI.LocateDoIt(oDocNum,pItmNum)and(ohCPI.Active or (gKey.TcbCpiBok[oBokNum]<>'')) then begin
    If not ohCPI.Active then  ohCPI.Open(gKey.TcbCpiBok[oBokNum]);If not ohCPH.Active then  ohCPH.Open(gKey.TcbCpiBok[oBokNum]);
    If not ohGSCAT.Active then ohGSCAT.Open;
    If ohGSCAT.LocateGsCode(ohTCI.GsCode) then begin
      If ohCPH.LocatePdCode(ohTCI.GsCode) then begin
        mSerNum:=ohTCC.NextSerNum(oDocNum);
        ohCPI.LocatePdCode(ohTCI.GsCode);
        while not ohCPI.Eof and (ohCPI.PdCode=ohTCI.GsCode) do begin
          mCpSeQnt:=0;
          mPdGsQnt:=ohCPI.PdGsQnt;
          If IsNul (mPdGsQnt) then mPdGsQnt:=ohCPH.PdGsQnt;
          If IsNul (mPdGsQnt) then mPdGsQnt:=1;
          ohTCC.Insert;
          ohTCC.TcdNum :=oDocNum;
          ohTCC.TcdItm :=pItmNum;
          ohTCC.TccItm :=mSerNum;
          ohTCC.Parent :=ohTCI.ItmNum;
          ohTCC.PdCode :=ohTCI.GsCode;
          ohTCC.CpCode :=ohCPI.CpCode;
          ohTCC.CpName :=ohCPI.CpName;
          ohTCC.BarCode:=ohCPI.BarCode;
          ohTCC.MsName :=ohCPI.MsName;
          ohTCC.DocDate:=ohTCI.DocDate;
          ohTCC.StkNum :=ohTCI.Stknum;
          ohTCC.ItmType:=ohCPI.ItmType;
          ohTCC.MgCode :=ohCPI.MgCode;
          ohTCC.GsType :=ohGSCAT.GsType;
          ohTCC.CPrice :=0;
          ohTCC.CValue :=0;
          ohTCC.StkStat:='N';
          ohTCC.PaCode :=ohTCI.PaCode;
          ohTCC.AcCValue:= 0;
          ohTCC.FgCPrice:= 0;
          ohTCC.FgCValue:= 0;
          ohTCC.DocDate:=ohTCI.DocDate;
          ohTCC.DlvDate:=0;
          ohTCC.DrbDate:=0;
          ohTCC.DlvUser:='';
          ohTCC.PdGsQnt:=ohTCI.GsQnt;
          ohTCC.LosPrc :=ohCPI.LosPrc;
          ohTCC.RcGsQnt:=Rd3(ohTCI.GsQnt*ohCPI.RcGsQnt/mPdGsQnt);
          ohTCC.CpSeQnt:=Rd3(ohTCC.RcGsQnt*(1+ohCPI.LosPrc/100));
          If ohTCC.ItmType = 'W' then begin
            ohTCC.CPrice:=ohCPI.CPrice;
            ohTCC.CValue:=ohCPI.CPrice*ohTCC.CpSeQnt;
            ohTCC.CpSuQnt:=ohTCC.CpSeQnt;
          end;
          mCpSeQnt:=mCpSeQnt+Rd3(Rd3(ohTCI.GsQnt*ohCPI.RcGsQnt/mPdGsQnt)*(1+ohCPI.LosPrc/100));
          ohCPI.SwapStatus;
          If (ohTCC.PdCode<>ohTCC.CpCode) and ohCPI.LocatePdCode(ohTCC.CpCode)
            then ohTCC.ItmType:='X';
          ohCPI.RestoreStatus;
          ohTCC.Post;
          Inc(mSerNum);
          Application.ProcessMessages;
          ohCPI.Next;
        end;
        ohTCI.Edit;
        ohTCI.StkStat:='C';
        ohTCI.AcCvalue:= 0;
        ohTCI.Post;
        repeat
          mF:=False;
          ohTCC.LocateTdTi(oDocNum,pItmNum);
          while not ohTCC.Eof and (ohTCC.TcdNum=oDocNum) do begin
            mF:=mF or (ohTCC.ItmType='X');
            If ohTCC.ItmType='X' then begin
              InsTcc(mSerNum,ohTcc.TcdItm,ohTcc.TccItm,ohTcc.DocDate,ohTcc.StkNum,ohTcc.PaCode,ohTcc.CpSeQnt);
              ohTCC.Edit;
              ohTCC.ItmType:='P';
              ohTCC.Post;
            end;
            ohTCC.Next;
          end;
        until not mF;
      end;
    end
    else ShowMsg (eCom.GscIsNoExist,StrInt(ohTCI.GsCode,0));
  end;
end;

procedure TTcd.AddTcc; // Prida komponent na zadany dodaci lsit
var mSerNum:word; mItmNum:word; mF: boolean;
begin
  // tcc.bdf
  If ohTCI.LocateDoIt(oDocNum,pItmNum)and(ohCPI.Active or (gKey.TcbCpiBok[oBokNum]<>'')) then begin
    If not ohCPI.Active then  ohCPI.Open(gKey.TcbCpiBok[oBokNum]);
    If not ohCPH.Active then  ohCPH.Open(gKey.TcbCpiBok[oBokNum]);
    If not ohGSCAT.Active then ohGSCAT.Open;
    If ohGSCAT.LocateGsCode(pGsCode) then begin
      mSerNum:=ohTCC.NextSerNum(oDocNum);
      ohTCC.Insert;
      ohTCC.TcdNum :=oDocNum;
      ohTCC.TcdItm :=pItmNum;
      ohTCC.TccItm :=mSerNum;
      ohTCC.Parent :=pParent;
      ohTCC.PdCode :=pPdCode;
      ohTCC.CpCode :=ohGSCAT.GsCode;
      ohTCC.CpName :=ohGSCAT.GsName;
      ohTCC.BarCode:=ohGSCAT.BarCode;
      ohTCC.MsName :=ohGSCAT.MsName;
      ohTCC.DocDate:=ohTCI.DocDate;
      ohTCC.StkNum :=ohTCI.Stknum;
      ohTCC.ItmType:='C';
      ohTCC.MgCode :=ohGSCAT.MgCode;
      ohTCC.GsType :=ohGSCAT.GsType;
      ohTCC.CPrice :=0;
      ohTCC.CValue :=0;
      ohTCC.StkStat:='N';
      ohTCC.PaCode :=ohTCI.PaCode;
      ohTCC.AcCValue:= 0;
      ohTCC.FgCPrice:= 0;
      ohTCC.FgCValue:= 0;
      ohTCC.DocDate:=ohTCI.DocDate;
      ohTCC.DlvDate:=0;
      ohTCC.DrbDate:=0;
      ohTCC.DlvUser:='';
      ohTCC.PdGsQnt:=1;
      ohTCC.LosPrc :=0;
      ohTCC.RcGsQnt:=pGsQnt;
      ohTCC.CpSeQnt:=pGsQnt;
      If ohTCC.ItmType = 'W' then begin
        ohTCC.CPrice:=ohCPI.CPrice;
        ohTCC.CValue:=ohCPI.CPrice*ohTCC.CpSeQnt;
        ohTCC.CpSuQnt:=ohTCC.CpSeQnt;
      end;
      ohCPI.SwapStatus;
      If (ohTCC.PdCode<>ohTCC.CpCode) and ohCPI.LocatePdCode(ohTCC.CpCode)
        then ohTCC.ItmType:='X';
      ohCPI.RestoreStatus;
      ohTCC.Post;
      ohTCI.Edit;
      ohTCI.StkStat:='C';
      ohTCI.AcCvalue:= 0;
      ohTCI.Post;
      Inc(mSerNum);
      repeat
        mF:=False;
        ohTCC.LocateTcdNum(oDocNum);
        while not ohTCC.Eof and (ohTCC.TcdNum=oDocNum) do begin
          mF:=mF or (ohTCC.ItmType='X');
          If ohTCC.ItmType='X' then begin
            InsTcc(mSerNum,ohTcc.TcdItm,ohTcc.TccItm,ohTcc.DocDate,ohTcc.StkNum,ohTcc.PaCode,ohTcc.CpSeQnt);
            ohTCC.Edit;
            ohTCC.ItmType:='P';
            ohTCC.Post;
          end;
          ohTCC.Next;
        end;
      until not mF;
    end
    else ShowMsg (eCom.GscIsNoExist,StrInt(ohTCI.GsCode,0));
  end;
end;

procedure TTcd.UnsTcc(pDocNum:Str12;pItmNum,pParent:longint); // Stornuje komponenty polozky na zadany dodaci lsit
var mItmNum:word; mSumQnt,mSumVal,mCpSeQnt,mPdGsQnt:double; mStkCanc: TStkCanc;
begin
  // tcc.bdf
  LocDoc(pDocNum);
  If ohTCI.LocateDoIt(oDocNum,pItmNum)and ohTCC.LocateTdTi(oDocNum,pItmNum)then begin
    mStkCanc:=TStkCanc.Create;
    mStkCanc.OpenStkFiles(ohTCI.StkNum);
    If not ohGSCAT.Active then ohGSCAT.Open;
    If ohGSCAT.LocateGsCode(ohTCI.GsCode)then begin
      while not ohTCC.Eof and (ohTCC.TcdNum=ohTCI.DocNum) and (ohTCC.TcdItm=ohTCI.ItmNum) do begin
        If (pParent=0) or (pParent=ohTCC.Parent) then
        begin
          If mStkCanc.Cancel(ohTCC.TcdNum,ohTCC.TccItm)=0 then begin
            ohTCC.Edit;
            ohTCC.StkStat:='N';
            ohTCC.AcCValue:=0;
            ohTCC.CpSuQnt:=0;
            ohTCC.FgCValue:=0;
            ohTCC.Post;
          end;
        end;
        ohTCC.Next;
      end;
    end;
    FreeAndNil(mStkCanc);
  end;
end;

function TTcd.DelTcc(pDocNum:Str12;pItmNum,pParent:longint):boolean;
var mItmNum:word; mSumQnt,mSumVal,mCpSeQnt,mPdGsQnt:double;
begin
  Result:=True;
  LocDoc(pDocNum);
  If ohTCI.LocateDoIt(oDocNum,pItmNum)and ohTCC.LocateTdTi(oDocNum,pItmNum)then begin
    while Result and not ohTCC.Eof and (ohTCC.TcdNum=ohTCI.DocNum) and (ohTCC.TcdItm=ohTCI.ItmNum) do begin
      If (pParent=0) or (pParent=ohTCC.Parent) then Result:=IsNul(ohTCC.CpSuQnt);
      ohTCC.Next;
    end;
    If Result then begin
      ohTCC.LocateTdTi(oDocNum,pItmNum);
      while not ohTCC.Eof and (ohTCC.TcdNum=ohTCI.DocNum) and (ohTCC.TcdItm=ohTCI.ItmNum) do begin
        If (pParent=0) or (pParent=ohTCC.Parent) then ohTCC.Delete;
      end;
    end;
  end;
end;

procedure TTcd.AddItm(pDocNum:Str12;pGsCode:longint;pGsQnt,pDscPrc,pFgBPrice:double); // Prida novu polozku na zadanu fakturu
begin
  If ohTCH.LocateDocNum(pDocNum)
    then AddItm(pGsCode,pGsQnt,pDscPrc,pFgBPrice)
    else ShowMsg(eCom.DocIsNoExist,pDocNum);
end;

procedure TTcd.IcdGen(pPrnIcd,pAutPrn:boolean;pPrnNam:Str50); // Vygeneruje polozky z aktualneho dodacieho listu do novej faktury
begin
  IcdGen('',pPrnIcd,pAutPrn,pPrnNam,NOT_ROUND);
end;

procedure TTcd.IcdGen(pTcdNum,pIcdNum:Str12;pPrnIcd,pAutPrn:boolean;pPrnNam:Str50); // Vygeneruje polozky zo zadaneho dodacieho listu do zadanej faktury
begin
  If ohTCH.LocateDocNum(pTcdNum)
    then IcdGen(pIcdNum,pPrnIcd,pAutPrn,pPrnNam,NOT_ROUND)
    else ShowMsg(eCom.DocIsNoExist,pTcdNum);
end;

procedure TTcd.IcdGen(pIcdNum:Str12;pPrnIcd,pAutPrn:boolean;pPrnNam:Str50;pRoundType:byte); // Vygeneruje polozky z aktualneho dodacieho listu do zadanej faktury
var mIcd:TIcd;  mAcc:TF_JrnAccF;  mBokNum:Str5;  mItmNum:word;  mIcdNum:Str12;
    mRoundValue:double; mRoundSign:integer;
begin
  If ohTCI.LocateDocNum(ohTCH.DocNum) then begin
    mBokNum:=gKey.TcbIcbNum[ohTCH.BokNum];
    mIcd:=TIcd.Create(Self);
    mIcd.Open(mBokNum,TRUE,TRUE,FALSE);
    mIcdNum:=pIcdNum;
    If mIcdNum='' then begin
      mIcd.NewDoc(ohTCH.Year,ohTCH.PaCode,FALSE);
      mIcd.ohICH.Edit;
      mIcd.ohICH.WpaName:=ohTCH.WpaName;
      mIcd.ohICH.WpaAddr:=ohTCH.WpaAddr;
      mIcd.ohICH.WpaSta:=ohTCH.WpaSta;
      mIcd.ohICH.WpaZip:=ohTCH.WpaZip;
      mIcd.ohICH.WpaCty:=ohTCH.WpaCty;
      mIcd.ohICH.WpaCtn:=ohTCH.WpaCtn;
      mIcd.ohICH.VatDoc:=ohTCH.VatDoc;
      mIcd.ohICH.FgDvzName:=ohTCH.FgDvzName;
      mIcd.ohICH.FgCourse:=ohTCH.FgCourse;
      mIcd.ohICH.TrsCode:=ohTCH.TrsCode;
      mIcd.ohICH.TrsName:=ohTCH.TrsName;
      mIcd.ohICH.PayCode:=ohTCH.PayCode;
      mIcd.ohICH.PayName:=ohTCH.PayName;
      If gIni.SpecSetting='TOP' then begin  // Len pre SYNDICUS s.r.o.
        If UpString(ohTCH.PayCode)='DOB' then mIcd.ohICH.PayMode:=4;
      end;
      If mIcd.ohICH.VatDoc=0 then mIcd.ohICH.DocSpc:=2;
      mIcd.ohICH.Post;
      mIcdNum:=mIcd.DocNum;
    end;
    If mIcd.ohICH.LocateDocNum(mIcdNum) then begin
      If mIcd.ohICH.DstLck=9 then begin
        mIcd.ohICH.Edit;
        mIcd.ohICH.DstLck:=0;
        mIcd.ohICH.Post;
      end;
      Repeat
        If ohTCI.IcdNum='' then begin
          mItmNum:=mIcd.ohICI.NextItmNum(mIcdNum);
          mIcd.ohICI.Insert;
          BTR_To_BTR (ohTCI.BtrTable,mIcd.ohICI.BtrTable);
          mIcd.ohICI.DocNum:=mIcdNum;
          mIcd.ohICI.ItmNum:=mItmNum;
          mIcd.ohICI.PaCode:=mIcd.ohICH.PaCode;
          mIcd.ohICI.DocDate:=mIcd.ohICH.DocDate;
          mIcd.ohICI.TcdNum:=ohTCI.DocNum;
          mIcd.ohICI.TcdItm:=ohTCI.ItmNum;
          mIcd.ohICI.TcdDate:=ohTCI.DocDate;
          mIcd.ohICI.Post;
          // Spatny odkaz na fakturu
          ohTCI.Edit;
          ohTCI.IcdNum :=mIcdNum;
          ohTCI.IcdItm :=mItmNum;
          ohTCI.IcdDate:=mIcd.ohICH.DocDate;
          ohTCI.FinStat:='F';
          ohTCI.Post;
        end;
        Application.ProcessMessages;
        ohTCI.Next;
      until ohTCI.Eof or (ohTCI.DocNum<>ohTCH.DocNum);
      mIcd.ClcDoc;
      // Created by Zoltan Rausch 08.12.2023
      if pRoundType=ROUND_TO_05 then begin
        mRoundValue:=SpecRnd5(mIcd.ohICH.FgBValue)-mIcd.ohICH.FgBValue;
        mRoundSign:=1;
        if mRoundValue < 0 then mRoundSign := -1;
        if Abs(mRoundValue) > 0.009 then begin // Add new round item to the invoice
          mItmNum:=mIcd.ohICI.NextItmNum(mIcdNum);
          mIcd.ohICI.Insert;
          mIcd.ohICI.DocNum:=mIcdNum;
          mIcd.ohICI.ItmNum:=mItmNum;
          mIcd.ohICI.PaCode:=mIcd.ohICH.PaCode;
          mIcd.ohICI.DocDate:=mIcd.ohICH.DocDate;
          mIcd.ohICI.GsName:='Zaokrúhlenie';
          mIcd.ohICI.GsQnt:=mRoundSign;
          mIcd.ohICI.VatPrc:=0;
          mIcd.ohICI.AcAValue:=mRoundValue;
          mIcd.ohICI.AcBValue:=mRoundValue;
          mIcd.ohICI.FgAPrice:=Abs(mRoundValue);
          mIcd.ohICI.FgBPrice:=mIcd.ohICI.FgAPrice;
          mIcd.ohICI.FgAValue:=mRoundValue;
          mIcd.ohICI.FgBValue:=mRoundValue;
          mIcd.ohICI.AccSnt:=gIni.IsRndSnt;
          mIcd.ohICI.AccAnl:=gIni.IsRndAnl;
          mIcd.ohICI.Post;
          mIcd.ClcDoc;
        end;
      end;
      If gKey.IcbAutAcc[mBokNum] then begin
        mAcc:=TF_JrnAccF.Create(Self);
        mAcc.Execute(mIcd.ohICH.BtrTable,FALSE);
        FreeAndNil(mAcc);
      end;
      If pPrnIcd then mIcd.PrnDoc(mIcdNum,pAutPrn,pPrnNam,'',0);
      ClcDoc;
    end
    else ShowMsg(eCom.DocIsNoExist,mIcdNum);
    FreeAndNil(mIcd);
  end;
end;

procedure TTcd.Gen(pSrcDoc:Str12); // Vytvori OD na zaklade zadaneho zdrojoveho dokladu
var mDocType:byte;
begin
  mDocType:=GetDocType (pSrcDoc);
  case mDocType of
    dtTS: TcdFromTsd(pSrcDoc); // Vyhgeneruje OD z DD
    dtTC: TcdFromTcd(pSrcDoc); // Vyhgeneruje OD z OD
    dtOC: TcdFromOcd(pSrcDoc); // Vyhgeneruje OD zo ZK
  end;
end;

procedure TTcd.Gen(pBokNum:Str5;pSrcDoc:Str12); // Vytvori OD na zaklade zadaneho zdrojoveho dokladu
var mDocType:byte;
begin
  mDocType:=GetDocType (pSrcDoc);
  case mDocType of
    dtTO: TcdFromTod(pBokNum,pSrcDoc); // Vyhgeneruje OD z TV
  end;
end;

procedure TTcd.Mov(pSrcDoc:Str12;pTrgBok:Str5); // Premiestni doklad z jedeho cisla na druhu
var mSrcBok:Str5;  mItmNum:word;  mhTCH:TTchHnd;  mhTCI:TTciHnd;  mItgLog:TItgLog;  mStk:TStk;
begin
  Open(pTrgBok);
  mSrcBok:=BookNumFromDocNum (pSrcDoc);
  mhTCH:=TTchHnd.Create;  mhTCH.Open(mSrcBok);
  mhTCI:=TTciHnd.Create;  mhTCI.Open(mSrcBok);
  If mhTCH.LocateDocNum(pSrcDoc) then begin
    If mhTCI.LocateDocNum(pSrcDoc) then begin
      If oYear='' then oYear:=mhTCH.Year; // Ak nie je zadane poradove cislo OD vygenerujeme nasledujuce
      If oSerNum=0 then oSerNum:=ohTCH.NextSerNum(oYear); // Ak nie je zadane poradove cislo OD vygenerujeme nasledujuce
      If oDocDate=0 then oDocDate:=Date; // Ak nie je zadany datum nastavime aktualny den
      oDocNum:=ohTCH.GenDocNum(oYear,oSerNum);
      oPaCode:=mhTCH.PaCode;
      If not ohTCH.LocateDocNum(oDocNum) then begin // Ak neexistuje vyvorime hlacicku dokladu OD
        ohTCH.Insert;
        BTR_To_BTR (mhTCH.BtrTable,ohTCH.BtrTable);
        ohTCH.DocNum:=oDocNum;
        ohTCH.SerNum:=oSerNum;
        ohTCH.Year:=oYear;
        ohTCH.StkNum:=gKey.TcbStkNum[ohTCH.BtrTable.BookNum];
        ohTCH.SmCode:=gKey.TcbSmCode[ohTCH.BtrTable.BookNum];
        ohTCH.DocDate:=oDocDate;
        ohTCH.FgCourse:=1;
        If ohPAB.LocatePaCode(ohTCH.PaCode) then BTR_To_BTR (ohPAB.BtrTable,ohTCH.BtrTable);
        ohTCH.Post;
      end;
      // Vytvorime polozky OD na zaklade DD
      mItgLog:=TItgLog.Create;
      mItmNum:=ohTCI.NextItmNum(ohTCH.DocNum);
      If oInd<>nil then begin
        oInd.Max:=mhTCH.ItmQnt;
        oInd.Position:=0;
      end;
      // Prekopirujeme polozky dodacieho listu
      mStk:=TStk.Create;
      Repeat
        If oInd<>nil then oInd.StepBy(1);
        ohTCI.Insert;
        BTR_To_BTR (mhTCI.BtrTable,ohTCI.BtrTable);
        ohTCI.DocNum:=oDocNum;
        ohTCI.ItmNum:=mItmNum;
        ohTCI.ScdNum:=mhTCI.DocNum;
        ohTCI.ScdItm:=mhTCI.ItmNum;
        ohTCI.StkStat:='S';
        ohTCI.Post;
        // Precislujeme skladove pohyby a FIFO
        mStk.StkNum:=mhTCI.StkNum;
        mStk.Ren(mhTCI.DocNum,mhTCI.ItmNum,oDocNum,mItmNum);
// TODO prepracovat
//        mOcd.MovTcd(mhTCI.DocNum,mhTCI.ItmNum,oDocNum,mItmNum,oDocDate);
        // Historia operacii nad polozkami dokladov
        mItgLog.Add(mhTCI.DocNum,mhTCI.ItmNum,ohTCI.DocNum,ohTCI.ItmNum,oFrmName);
        Application.ProcessMessages;
        Inc (mItmNum);
        mhTCI.Next;
      until mhTCI.Eof or (mhTCI.DocNum<>pSrcDoc);
      ohTCH.Clc(ohTCI);
      FreeAndNil (mStk);
      FreeAndNil (mItgLog);
      mhTCI.Del(pSrcDoc);
      // Uložíme odkaz do DD na OD
      mhTCH.Edit;
      mhTCH.RcvName:=oDocNum;
      mhTCH.Post;
      mhTCH.Clc(mhTCI);
    end;
  end;
  FreeAndNil (mhTCI);
  FreeAndNil (mhTCH);
end;

procedure TTcd.SubDoc; // Vyskladni tovar zo zadaneho dodacieho istu
var mStk:TStk; mFind:boolean; mCnt:byte;
var mCValue,mCpSeQnt,mCpSuQnt:double;
begin
  oOcdNums.Clear;
  oNsiQnt:=0;
  If ohTCI.LocateDocNum(ohTCH.DocNum) then begin
    mStk:=TStk.Create;
    If oInd<>nil then begin
      oInd.Max:=ohTCH.ItmQnt;
      oInd.Position:=0;
    end;
    Repeat
      If oInd<>nil then oInd.StepBy(1);
      If ohTCI.StkStat='N' then begin
        mStk.Clear;
        mStk.SmSign:='-';  // Vydaj tovaru
        mStk.DocNum:=ohTCI.DocNum;
        mStk.ItmNum:=ohTCI.ItmNum;
        mStk.DocDate:=ohTCI.DocDate;
        mStk.GsCode:=ohTCI.GsCode;
        mStk.MgCode:=ohTCI.MgCode;
        mStk.BarCode:=ohTCI.BarCode;
        mStk.SmCode:=ohTCH.SmCode;
        mStk.PaCode:=ohTCH.PaCode;
        mStk.GsName:=ohTCI.GsName;
        mStk.GsQnt:=ohTCI.GsQnt;
        mStk.CValue:=ohTCI.AcCValue;
        If IsNul(mStk.CValue) then begin
          mStk.ohSTK.Open(ohTCI.StkNum);
          If mStk.ohSTK.LocateGsCode(mStk.GsCode) then begin
            mStk.CValue:=mStk.ohSTK.LastPrice*mStk.GsQnt;
            If IsNul(mStk.CValue) then mStk.CValue:=mStk.ohSTK.AvgPrice*mStk.GsQnt;
            If IsNotNul(mStk.CValue) then begin
              ohTCI.Edit;
              ohTCI.AcCValue:=mStk.CValue;
              ohTCI.Post;
            end;
          end;  
        end;
        If IsNotNul(ohTCI.GsQnt) then mStk.BPrice:=ohTCI.AcBValue/ohTCI.GsQnt;
        If IsNotNul(mStk.GsQnt) then mStk.CPrice:=RdX(ohTCI.AcCValue/ohTCI.GsQnt,gKey.StpRndFrc);
        If mStk.Sub(ohTCI.StkNum) then begin // Ak sa podarilo vydat polozky
          ohTCI.Edit;
          If ohTCI.GsQnt<0
            then ohTCI.AcCValue:=0-Abs(mStk.CValue)
            else ohTCI.AcCValue:=Abs(mStk.CValue);
          ohTCI.FgCValue:=ClcFgFromAcS(ohTCI.AcCValue,ohTCH.FgCourse);
          If ohTCI.GsQnt<>0 then ohTCI.FgCPrice:=ohTCI.FgCValue/ohTCI.GsQnt;
          ohTCI.StkStat:='S';
          ohTCI.Post;
          mFind:=TRUE;
          If oOcdNums.Count>0 then begin
            mCnt:=0;
            Repeat
              mFind:=oOcdNums.Strings[mCnt]=ohTCI.OcdNum;
              Inc (mCnt);
            until mFind or (mCnt=oOcdNums.Count);
          end;
          If not mFind then oOcdNums.Add (ohTCI.OcdNum);
        end else Inc(oNsiQnt);
      end else If ohTCI.StkStat='C' then begin
        mCpSeQnt:=0;mCpSuQnt:=0;mCValue:=0;
        If ohTCC.LocateTdTi(ohTCI.DocNum,ohTCI.ItmNum) then begin
          repeat
            If (ohTCC.ItmType='C') and IsNotNul(ohTCC.CpSeQnt-ohTCC.CpSuQnt) then begin
              mStk.Clear;
              mStk.SmSign:='-';  // Vydaj tovaru
              mStk.DocNum:=ohTCC.TcdNum;
              mStk.ItmNum:=ohTCC.TccItm;
              mStk.DocDate:=ohTCC.DocDate;
              mStk.GsCode:=ohTCC.CpCode;
              mStk.MgCode:=ohTCC.MgCode;
              mStk.BarCode:=ohTCC.BarCode;
              mStk.SmCode:=ohTCH.SmCode;
              mStk.PaCode:=ohTCH.PaCode;
              mStk.GsName:=ohTCC.CpName;
              mStk.GsQnt:=ohTCC.CpSeQnt-ohTCC.CpSuQnt;
              mStk.CValue:=ohTCC.FgCPrice*(ohTCC.CpSeQnt-ohTCC.CpSuQnt);
//              mStk.CPrice:=RdX(ohTCC.FgCPrice,gKey.StpRndFrc);
              If mStk.Sub(ohTCC.StkNum) then begin // Ak sa podarilo vydat polozky
                ohTCC.Edit;
                ohTCC.CpSuQnt:=ohTCC.CpSuQnt+mStk.GsQnt;
                If (mStk.GsQnt)<0
                  then ohTCC.CValue:=ohTCC.CValue - Abs(mStk.CValue)
                  else ohTCC.CValue:=ohTCC.CValue + Abs(mStk.CValue);
                ohTCC.AcCValue:=ohTCC.CValue;
                ohTCC.FgCValue:=ClcFgFromAcS(ohTCC.CValue,ohTCH.FgCourse);
                If (ohTCC.CpSuQnt)<>0 then ohTCC.FgCPrice:=ohTCC.FgCValue/ohTCC.CpSuQnt;
                If (ohTCC.CpSuQnt)<>0 then ohTCC.CPrice:=ohTCC.CValue/ohTCC.CpSuQnt;
                If IsNul(ohTCC.CpSeQnt-ohTCC.CpSuQnt) then ohTCC.StkStat:='S';
                ohTCC.Post;
              end;
            end;
            mCValue :=mCValue+ohTCC.CValue;
            mCpSeQnt:=mCpSeQnt+ohTCC.CpSeQnt;
            mCpSuQnt:=mCpSuQnt+ohTCC.CpSuQnt;
            ohTCC.Next;
          until ohTCC.Eof or (ohTCC.TcdNum<>ohTCI.DocNum)or (ohTCC.TcdItm<>ohTCI.ItmNum)
        end;
        ohTCI.Edit;
        ohTCI.StkStat:='C';
        ohTCI.AcCValue:= mCValue;   { TODO : doplnit zapis NC }
        ohTCI.Post;
      end;
      Application.ProcessMessages;
      ohTCI.Next;
    until ohTCI.Eof or (ohTCI.DocNum<>ohTCH.DocNum);
    FreeAndNil (mStk);
  end;
  ClcDoc; // ohTCH.Clc(ohTCI);
end;

procedure TTcd.SubDoc(pDocNum:Str12); // Vyskladni tovar zo zadaneho dodacieho istu
begin
  If ohTCH.LocateDocNum(pDocNum) then SubDoc;
end;

procedure TTcd.ClcDoc; // prepocita hlavicku zadaneho dokladu
var mCValue:double;
begin
  If ohTCC.LocateTcdNum(ohTCH.DocNum) then begin
    ohTCI.NearestDoIt(ohTCH.DocNum,0);
    while not ohTCI.Eof and (ohTCI.DocNum=ohTCH.DocNum) do begin
      If ohTCI.StkStat='C' then begin
        mCValue:=ClcTcc(ohTCH.DocNum,ohTCI.ItmNum,0);
        // tci.bdf
        ohTCI.Edit;ohTCI.AcCValue:=mCValue;
        ohTCI.FgCValue:=ClcFgFromAcS(mCValue,ohTCH.FgCourse);
        If IsNotNul(ohTCI.GsQnt)
          then ohTCI.FgCPrice:=ohTCI.FgCValue/ohTCI.GsQnt
          else ohTCI.FgCPrice:=ohTCI.FgCValue;
        ohTCI.Post;
      end;
      ohTCI.Next;
    end;
  end;
  ohTCH.Clc(ohTCI);
end;

procedure TTcd.ClcDoc(pDocNum:Str12); // prepocita hlavicku zadaneho dokladu
var mCValue:double;
begin
  If ohTCH.LocateDocNum(pDocNum) then begin
    If ohTCC.LocateTcdNum(ohTCH.DocNum) then begin
      ohTCI.NearestDoIt(ohTCH.DocNum,0);
      while not ohTCI.Eof and (ohTCI.DocNum=ohTCH.DocNum) do begin
        If ohTCI.StkStat='C' then begin
          mCValue:=ClcTcc(ohTCH.DocNum,ohTCI.ItmNum,0);
          // tci.bdf
          ohTCI.Edit;ohTCI.AcCValue:=mCValue;
          ohTCI.FgCValue:=ClcFgFromAcS(mCValue,ohTCH.FgCourse);
          If IsNotNul(ohTCI.GsQnt)
            then ohTCI.FgCPrice:=ohTCI.FgCValue/ohTCI.GsQnt
            else ohTCI.FgCPrice:=ohTCI.FgCValue;
          ohTCI.Post;
        end;
        ohTCI.Next;
      end;
    end;
    ohTCH.Clc(ohTCI);
  end;
end;

function TTcd.Uns(pDocNum:Str12):boolean;  // Zrusi skladovu operaciu (t.j. prijem tovar naspat vyda podla znaku mnozstva
var mStk:TStk;
begin
  Result:=TRUE;
  If ohTCH.LocateDocNum(pDocNum) then begin
    If ohTCI.LocateDocNum(pDocNum) then begin
      mStk:=TStk.Create;
      Repeat
        If ohTCI.StkStat='S' then begin
          If mStk.Uns(ohTCI.StkNum,ohTCI.DocNum,ohTCI.ItmNum) then begin
            ohTCI.Edit;
            ohTCI.AcCValue:=0;
            ohTCI.StkStat:='N';
            ohTCI.Post;
          end
          else Result:=FALSE;
        end;
        If ohTCI.StkStat='C' then begin
          UnsTcc(ohTCI.DocNum,ohTCI.ItmNum,0);
          If IssItc(ohTCI.DocNum,ohTCI.ItmNum,0) then begin
            ohTCI.Edit;
            ohTCI.AcCValue:=0;
            ohTCI.StkStat:='C';
            ohTCI.Post;
          end
          else Result:=FALSE;
        end;
        Application.ProcessMessages;
        ohTCI.Next;
      until ohTCI.Eof or (ohTCI.DocNum<>pDocNum);
      FreeAndNil (mStk);
    end;
    ohTCH.Clc(ohTCI);
  end;
end;

function TTcd.Del(pDocNum:Str12;pHedDel:boolean):boolean;  // Zrusi zadany doklad
begin
  Result:=TRUE;
  If ohTCH.LocateDocNum(pDocNum) then begin
    If Uns(pDocNum) then begin
      If ohTCC.LocateTcdNum(pDocNum) then begin
        Repeat
          Application.ProcessMessages;
          If ohTCC.StkStat='N'
            then ohTCC.Delete
            else begin
              Result:=FALSE;
              ohTCC.Next;
            end;
        until ohTCC.Eof or (ohTCC.Count=0) or (ohTCC.TcdNum<>pDocNum);
      end;
      If ohTCI.LocateDocNum(pDocNum) then begin
        Repeat
          Application.ProcessMessages;
          If (ohTCI.StkStat='N') and not ohTCC.LocateTdTi(pDocNum,ohTCI.ItmNum)
            then ohTCI.Delete
            else begin
              Result:=FALSE;
              ohTCI.Next;
            end;
        until ohTCI.Eof or (ohTCI.Count=0) or (ohTCI.DocNum<>pDocNum);
      end;
    end;
    ClcDoc; // ohTCH.Clc(ohTCI);
    Result:=ohTCH.ItmQnt=0; // Je to v poriadku ak doklad nema ziadne polozky
    If Result and pHedDel then ohTCH.Delete;  // Ak je nastavene zrusenie hlavicky a bola vymazana kazda polozka zrusime hlavicku dokladu
  end;
end;

procedure TTcd.Npi(pPaCode:longint;pBokLst:ShortString);  // Spocita nevyfakturovane DL pre zadanehoo zakaznika zo zadanych knih
var mhTCH:TTchHnd;
begin
  oNpiVal:=0;  oNpiQnt:=0;
  gBok.LoadBokLst('TCB',pBokLst);
  If gBok.BokLst.Count>0 then begin
    gBok.BokLst.First;
    Repeat
      mhTCH:=TTchHnd.Create;  mhTCH.Open(gBok.BokLst.Itm);
      If mhTCH.LocatePaCode(pPaCode) then begin
        Repeat
          If mhTCH.IcdNum='' then begin
            oNpiVal:=oNpiVal+mhTCH.AcBValue;
            Inc (oNpiQnt);
          end;
          Application.ProcessMessages;
          mhTCH.Next;
        until mhTCH.Eof or (mhTCH.PaCode<>pPaCode);
      end;
      FreeAndNil (mhTCH);
      Application.ProcessMessages;
      gBok.BokLst.Next;
    until gBok.BokLst.Eof;
  end;
end;

procedure TTcd.ChgPac(pPaCode: Integer);
begin
  If ohPAB.LocatePaCode(pPaCode) then begin
    BTR_To_BTR (ohPAB.BtrTable,ohTCH.BtrTable);
    ohTCH.TrsCode:=ohPAB.IcTrsCode;
    ohTCH.TrsName:=ohPAB.IcTrsName;
    ohTCH.PayCode:=ohPAB.IcPayCode;
    ohTCH.PayName:=ohPAB.IcPayName;
    If ohPAB.IcPlsNum<>0 then ohTCH.PlsNum:=ohPAB.IcPlsNum;
    // Zadat aj miesto dodania
  end;
end;

function TTcd.IssItc(pDocNum:Str12;pItmNum,pParent: Integer): boolean;
var mParent:longint;mV,mValue:double;
begin
  LocDoc(pDocNum);
  Result:=TRUE;
  ohTCC.SwapStatus;
  If ohTCH.LocateDocNum(pDocNum) and ohTCI.LocateDoIt(pDocNum,pItmNum)  then begin
    If pParent>=10000 then begin
      If ohTCC.LocateTdTc(pDocNum,pParent) then begin
        If ohTCC.ItmType='C' then begin
          Result:=Eq3(ohTCC.CpSeQnt,ohTCC.CpSuQnt);
        end else If ohTCC.ItmType='W' then begin
          Result:=True;
        end else If ohTCC.ItmType='P' then begin
          mParent:=ohTCC.TccItm;mValue:=0;
          ohTCC.LocateTdTi(pDocNum,pItmNum);
          repeat
            If ohTCC.Parent=mParent then Result:=IssItc(pDocNum,pItmNum,ohTCC.TccItm);
            ohTCC.Next;
          until not Result or ohTCC.Eof or (ohTCC.TcdNum<>pDocNum)or (ohTCC.TcdItm<>pItmNum);
        end;
      end;
    end else begin
      mParent:=pItmNum;
      ohTCC.LocateTdTi(pDocNum,pItmNum);
      repeat
        If ohTCC.Parent=mParent then begin
          result:=IssItc(pDocNum,pItmNum,ohTCC.TccItm);
        end;
        ohTCC.Next;
      until not Result or ohTCC.Eof or (ohTCC.TcdNum<>pDocNum)or (ohTCC.TcdItm<>pItmNum)
    end;
  end;
  ohTCC.RestoreStatus;
end;

procedure TTcd.LocDoc(pDocNum: Str12);
begin
  If ohTCH.LocateDocNum(pDocNum) then begin
    oYear:=ohTCH.Year;
    oSerNum:=ohTCH.SerNum;
    oDocNum:=ohTCH.DocNum;
    oPaCode:=ohTCH.PaCode;
    oDocDate:= ohTCH.DocDate;
  end;
end;

procedure TTcd.SubTcc(pDocNum: Str12; pItmNum, pTccNum: Integer);
var mStk:TStk; mFind:boolean; mCnt:byte; mParent:longint;
begin
  ohTCC.SwapStatus;
  If ohTCH.LocateDocNum(pDocNum) and ohTCI.LocateDoIt(pDocNum,pItmNum)  then begin
    If ohTCC.LocateTdTc(pDocNum,pTccNum) then begin
      If ohTCC.ItmType='C' then begin
        If IsNotNul(ohTCC.CpSeQnt-ohTCC.CpSuQnt) then begin
          mStk:=TStk.Create;
          mStk.Clear;
          mStk.SmSign:='-';  // Vydaj tovaru
          mStk.DocNum:=ohTCC.TcdNum;
          mStk.ItmNum:=ohTCC.TccItm;
          mStk.DocDate:=ohTCC.DocDate;
          mStk.GsCode:=ohTCC.CpCode;
          mStk.MgCode:=ohTCC.MgCode;
          mStk.BarCode:=ohTCC.BarCode;
          mStk.SmCode:=ohTCH.SmCode;
          mStk.PaCode:=ohTCH.PaCode;
          mStk.GsName:=ohTCC.CpName;
          mStk.GsQnt:=ohTCC.CpSeQnt-ohTCC.CpSuQnt;
          mStk.CValue:=ohTCC.CPrice*(ohTCC.CpSeQnt-ohTCC.CpSuQnt);
  //              mStk.CPrice:=RdX(ohTCC.FgCPrice,gKey.StpRndFrc);
          If IsNotNul(mStk.GsQnt) and mStk.Sub(ohTCC.StkNum) then begin // Ak sa podarilo vydat polozky
            ohTCC.Edit;
            ohTCC.CpSuQnt:=ohTCC.CpSuQnt+mStk.GsQnt;
            If (mStk.GsQnt)<0
              then ohTCC.CValue:=ohTCC.CValue - Abs(mStk.CValue)
              else ohTCC.CValue:=ohTCC.CValue + Abs(mStk.CValue);
            ohTCC.FgCValue:=ClcFgFromAcS(ohTCC.CValue,ohTCH.FgCourse);
            If (ohTCC.CpSuQnt)<>0 then ohTCC.FgCPrice:=ohTCC.FgCValue/ohTCC.CpSuQnt;
            ohTCC.AcCValue:=ohTCC.CValue;
            If (ohTCC.CpSuQnt)<>0 then ohTCC.CPrice:=ohTCC.CValue/ohTCC.CpSuQnt;
            If IsNul(ohTCC.CpSeQnt-ohTCC.CpSuQnt) then ohTCC.StkStat:='S';
            ohTCC.Post;
          end;
          FreeAndNil (mStk);
        end;
      end else If ohTCC.ItmType='P' then begin
        mParent:=ohTCC.TccItm;
        ohTCC.LocateTdTi(pDocNum,pItmNum);
        repeat
          If ohTCC.Parent=mParent then begin
            SubTcc(pDocNum,pItmNum,ohTCC.TccItm);
          end;
          ohTCC.Next;
        until ohTCC.Eof or (ohTCC.TcdNum<>pDocNum)or (ohTCC.TcdItm<>pItmNum)
      end;
    end;
  end;
  ohTCC.RestoreStatus;
end;

function TTcd.ClcTcc(pDocNum: Str12; pItmNum, pTccNum: Integer):double;
var mParent:longint;mV,mValue:double;
begin
  Result:=0;
  ohTCC.SwapStatus;
  If ohTCH.LocateDocNum(pDocNum) and ohTCI.LocateDoIt(pDocNum,pItmNum)  then begin
    If pTccNum>=10000 then begin
      If ohTCC.LocateTdTc(pDocNum,pTccNum) then begin
        If ohTCC.ItmType='C' then begin
          Result:=Result+ohTCC.CValue;
        end else If ohTCC.ItmType='W' then begin
          //
        end else If ohTCC.ItmType='P' then begin
          mParent:=ohTCC.TccItm;mValue:=0;
          ohTCC.LocateTdTi(pDocNum,pItmNum);
          repeat
            If ohTCC.Parent=mParent then begin
              mV:=ClcTcc(pDocNum,pItmNum,ohTCC.TccItm);
              Result:=Result+mV;
              mValue:=mValue+mV;
            end;
            ohTCC.Next;
          until ohTCC.Eof or (ohTCC.TcdNum<>pDocNum)or (ohTCC.TcdItm<>pItmNum);
          ohTCC.LocateTdTc(pDocNum,mParent);
          ohTCC.Edit;
          ohTCC.CValue:=mValue;
          ohTCC.AcCValue:=mValue;
          ohTCC.FgCValue:=ClcFgFromAcS(mValue,ohTCH.FgCourse);
          If IsNotNul(ohTCC.CpSuQnt)
            then ohTCC.FgCPrice:=ohTCC.FgCValue/ohTCC.CpSuQnt
            else ohTCC.FgCPrice:=ohTCC.FgCValue;
          If IsNotNul(ohTCC.CpSuQnt)
            then ohTCC.CPrice:=ohTCC.CValue/ohTCC.CpSuQnt
            else ohTCC.CPrice:=ohTCC.CValue;
          ohTCC.Post;
        end;
      end;
    end else begin
      mParent:=pItmNum;
      ohTCC.LocateTdTi(pDocNum,pItmNum);
      repeat
        If ohTCC.Parent=mParent then begin
          result:=Result+ClcTcc(pDocNum,pItmNum,ohTCC.TccItm);
        end;
        ohTCC.Next;
      until ohTCC.Eof or (ohTCC.TcdNum<>pDocNum)or (ohTCC.TcdItm<>pItmNum)
    end;
  end;
  ohTCC.RestoreStatus;
end;

procedure TTcd.SubTci(pDocNum:Str12;pItmNum:longint); // vydaj kompponentov polozky ODL
var mItmNum:word; mSumQnt,mSumVal,mCpSeQnt,mPdGsQnt:double;
begin
  // tcc.bdf
  LocDoc(pDocNum);
  If ohTCI.LocateDoIt(oDocNum,pItmNum)and ohTCC.LocateTdTi(oDocNum,pItmNum)then begin
    If not ohGSCAT.Active then ohGSCAT.Open;
    If ohGSCAT.LocateGsCode(ohTCI.GsCode)then begin
      while not ohTCC.Eof and (ohTCC.TcdNum=ohTCI.DocNum) and (ohTCC.TcdItm=ohTCI.ItmNum) do begin
        SubTcc(pDocNum,pItmNum,ohTCC.TccItm);
        ohTCC.Next;
      end;
      mSumVal:=ClcTcc(pDocNum,pItmNum,0);
    end;
  end;
end;

function TTcd.SubItm(pDocNum:Str12;pItmNum:word):boolean;  // Zrusi skladovu operaciu (t.j. prijem tovar naspat vyda podla znaku mnozstva
var mStk:TStk;
begin
  Result:=FALSE;
  If ohTCI.LocateDoIt(pDocNum,pItmNum) then begin
    mStk:=TStk.Create;
    If ohTCI.StkStat='N' then begin
      mStk.Clear;
      mStk.SmSign:='-';  // Vydaj tovaru
      mStk.DocNum:=ohTCI.DocNum;
      mStk.ItmNum:=ohTCI.ItmNum;
      mStk.DocDate:=ohTCI.DocDate;
      mStk.GsCode:=ohTCI.GsCode;
      mStk.MgCode:=ohTCI.MgCode;
      mStk.BarCode:=ohTCI.BarCode;
      mStk.SmCode:=ohTCH.SmCode;
      mStk.PaCode:=ohTCH.PaCode;
      mStk.GsName:=ohTCI.GsName;
      mStk.GsQnt:=ohTCI.GsQnt;
      mStk.CValue:=ohTCI.AcCValue;
      If IsNotNul(mStk.GsQnt) then mStk.CPrice:=RdX(ohTCI.AcCValue/ohTCI.GsQnt,gKey.StpRndFrc);
      If mStk.Sub(ohTCI.StkNum) then begin // Ak sa podarilo vydat polozky
        ohTCI.Edit;
        If ohTCI.GsQnt<0
          then ohTCI.AcCValue:=0-Abs(mStk.CValue)
          else ohTCI.AcCValue:=Abs(mStk.CValue);
        ohTCI.FgCValue:=ClcFgFromAcS(ohTCI.AcCValue,ohTCH.FgCourse);
        If ohTCI.GsQnt<>0 then ohTCI.FgCPrice:=ohTCI.FgCValue/ohTCI.GsQnt;
        ohTCI.StkStat:='S';
        If ohTCI.SpMark='E' then ohTCI.SpMark:='';
        ohTCI.Post;
        Result:=TRUE;
      end;
    end;
  end;
end;

function TTcd.UnsItm(pDocNum:Str12;pItmNum:word;pClc:boolean):boolean;  // Zrusi skladovu operaciu
var mStk:TStk;
begin
  Result:=TRUE;
  If ohTCH.LocateDocNum(pDocNum) then begin
    If ohTCI.LocateDoIt(pDocNum,pItmNum) then begin
      If ohTCI.StkStat='S' then begin
        mStk:=TStk.Create;
        If mStk.Uns(ohTCI.StkNum,ohTCI.DocNum,ohTCI.ItmNum) then begin
          ohTCI.Edit;
          ohTCI.StkStat:='N';
          ohTCI.Post;
        end
        else Result:=FALSE;
      end;
      FreeAndNil(mStk);
    end;
    If pClc then ohTCH.Clc(ohTCI);
  end;
end;

end.

