unit Ksd;
{$F+}

// *****************************************************************************
//                          ZAKAZKY PRENAJMU TOVARU
// *****************************************************************************
//
// Programové funkcia:
// ---------------
// *****************************************************************************


interface

uses
  IcTypes, IcConst, IcConv, IcTools, IcVariab, DocHand, IstFnc,
  NexGlob, NexPath, NexIni, NexMsg, NexError, ItgLog,
  SavClc, LinLst, Bok, Rep, Key, Afc, Doc, Plc,
  hSYSTEM, hGSCAT, hPAB, hKSH, hKSI, hKSO, hKSN, tKSH, tKSI, tKSS, tNOT,
  ComCtrls, SysUtils, Classes, Forms;

type
  PDat=^TDat;
  TDat=record
    rhKSH:TKshHnd;
    rhKSI:TKsiHnd;
    rhKSO:TKsoHnd;
    rhKSN:TKsnHnd;
  end;

  TKsd = class(TComponent)
    constructor Create(AOwner: TComponent);
    destructor  Destroy; override;
    private
      oBokNum:Str5;
      oFrmName:Str15;
      oLst:TList;
      ohGSCAT:TGscatHnd;
      oYear:Str2;
      procedure Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
    public
      oIst:TIstFnc;
      ohKSH:TKshHnd;
      ohKSI:TKsiHnd;
      ohKSO:TKsoHnd;
      otKSI:TKsiTmp;
      otKSS:TKssTmp;
      ohKSN:TKsnHnd;
      procedure Open(pBokNum:Str5); overload; // Otvori vsetky databazove subory
      procedure Open(pPath:ShortString;pBokNum:Str5); overload; // Otvori vsetky databazove subory
      procedure Open(pBokNum:Str5;pKSH,pKSI,pKSO,pKSN:boolean); overload;// Otvori zadane databazove subory
      procedure Open(pPath:ShortString;pBokNum:Str5;pKSH,pKSI,pKSO,pKSN:boolean); overload; // Otvori vsetky databazove subory
      procedure PrnDoc; overload; // Vytlaèí aktualny doklad
      procedure PrnDoc(pDocNum:Str12); overload; // Vytlaèí zadany doklad
      procedure ResDoc(pYear:Str2;pSerNum:longint); // Zarezervuje zdoklad so zadanym poradovym cislom
      procedure ResVer; // Prekontroluje ci doklad je rezervovany ak ano zrusi ho
      procedure NewDoc(pYear:Str2;pSerNum,pStkNum:word;pPaCode:longint;pDocDate,pBegDate,pEndDate:TDateTime); // Vygeneruje novu hlavicku dokladu
      procedure ClcDoc; overload; // prepocita hlavicku zadaneho dokladu
      procedure ClcDoc(pDocNum:Str12); overload; // prepocita hlavicku zadaneho dokladu
      procedure CnfDoc; // Potvrdenie dokladu nastavi priznak rezervacie DstLck=9 na 0
      procedure TmpRef(pDocNum:Str12;pItmNum:longint); // Obnovy zaznam na zaklade BTR
      procedure AddItm(pDocNum:Str12;pFifNum,pGsCode:longint;pGsQnt,pCValue,pBValue:double;pKidNum:Str12;pKidItm:longint;pKidDate:TDateTime); // Prida novu polozku na zadany doklad
      procedure SlcItm; overload; // Nacita polozky aktualneho dokladu dokladu do PX
      procedure SlcItm(pDocNum:Str12); overload; // Nacita polozky zadaneho dokladu do PX
      procedure SumItm(pDocNum:Str12); // Vyhotoví kumultaívny zoznam položiek vybraného dokladu pod¾a PLU
    published
      property Year:Str2 read oYear write oYear;
      property BokNum:Str5 read oBokNum;
  end;

implementation

uses bKSI, bGSCAT;

constructor TKsd.Create(AOwner: TComponent);
begin
  oFrmName:=AOwner.Name;
  oLst:=TList.Create;  oLst.Clear;
  ohGSCAT:=TGscatHnd.Create;
  otKSI:=TKsiTmp.Create;
  otKSS:=TKssTmp.Create;
  oIst:=TIstFnc.Create;
end;

destructor TKsd.Destroy;
var I:word;
begin
  FreeAndNil(oIst);
  If oLst.Count>0 then begin
    For I:=1 to oLst.Count do begin
      Activate (I);
      FreeAndNil (ohKSN);
      FreeAndNil (ohKSI);
      FreeAndNil (ohKSO);
      FreeAndNil (ohKSH);
    end;
  end;
  FreeAndNil (oLst);
  FreeAndNil (otKSS);
  FreeAndNil (otKSI);
  FreeAndNil (ohGSCAT);
end;

// ********************************* PRIVATE ***********************************

procedure TKsd.Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
var mDat:PDat;
begin
  mDat:=oLst.Items[pIndex-1];
  ohKSH:=mDat.rhKSH;
  ohKSI:=mDat.rhKSI;
  ohKSO:=mDat.rhKSO;
  ohKSN:=mDat.rhKSN;
end;

// ********************************** PUBLIC ***********************************

procedure TKsd.Open(pBokNum:Str5); // Otvori vsetky databazove subory
begin
  Open ('',pBokNum,TRUE,TRUE,TRUE,TRUE);
end;

procedure TKsd.Open(pPath:ShortString;pBokNum:Str5); // Otvori vsetky databazove subory
begin
  Open (pPath,pBokNum,TRUE,TRUE,TRUE,TRUE);
end;

procedure TKsd.Open(pBokNum:Str5;pKSH,pKSI,pKSO,pKSN:boolean); // Otvori zadane databazove subory
begin
  Open('',pBokNum,pKSH,pKSI,pKSO,pKSN); // Otvori vsetky databazove subory
end;

procedure TKsd.Open(pPath:ShortString;pBokNum:Str5;pKSH,pKSI,pKSO,pKSN:boolean); // Otvori vsetky databazove subory
var mFind:boolean;  mCnt:word;  mDat:PDat;
begin
  oBokNum:=pBokNum;
  mFind:=FALSE;
  If oLst.Count>0 then begin
    mCnt:=0;
    Repeat
      Inc (mCnt);
      Activate(mCnt);
      mFind:=ohKSH.BtrTable.BookNum=pBokNum;
    until mFind or (mCnt=oLst.Count);
  end;
  If not mFind then begin // Ak dana kniha este nie je otvorena potomotvorime
    // Vytvorime objekty
    If pPath='' then begin
      ohKSH:=TKshHnd.Create;
      ohKSI:=TKsiHnd.Create;
      ohKSO:=TKsoHnd.Create;
      ohKSN:=TKsnHnd.Create;
    end
    else begin
      ohKSH:=TKshHnd.Create(pPath);
      ohKSI:=TKsiHnd.Create(pPath);
      ohKSO:=TKsoHnd.Create(pPath);
      ohKSN:=TKsnHnd.Create(pPath);
    end;
    // Otvorime databazove subory
    If pKSH then ohKSH.Open(pBokNum);
    If pKSI then ohKSI.Open(pBokNum);
    If pKSO then ohKSO.Open(pBokNum);
    If pKSN then ohKSN.Open(pBokNum);
    // Ulozime objekty do zoznamu
    GetMem (mDat,SizeOf(TDat));
    mDat^.rhKSH:=ohKSH;
    mDat^.rhKSI:=ohKSI;
    mDat^.rhKSO:=ohKSO;
    mDat^.rhKSN:=ohKSN;
    oLst.Add(mDat);
  end;
end;

procedure TKsd.AddItm(pDocNum:Str12;pFifNum,pGsCode:longint;pGsQnt,pCValue,pBValue:double;pKidNum:Str12;pKidItm:longint;pKidDate:TDateTime); // Prida novu polozku na zadany doklad
var mItmNum:word;
begin
  If ohKSH.LocateDocNum(pDocNum) then begin
    If not ohGSCAT.Active then ohGSCAT.Open;
    If ohGSCAT.LocateGsCode(pGsCode) then begin
      mItmNum:=NextItmNum(ohKSI.BtrTable,pDocNum);
      ohKSI.Insert;
      ohKSI.DocNum:=pDocNum;
      ohKSI.ItmNum:=mItmNum;
      BTR_To_BTR(ohGSCAT.BtrTable,ohKSI.BtrTable);
      If oIst.GetCctVat(ohKSH.PaCode,pGsCode) then begin // Kontrola na prenesenie daònovej povinnosti DPH
        ohKSI.CctVat:=1;
        ohKSI.VatPrc:=0;
      end;
      ohKSI.GsQnt:=pGsQnt;
      ohKSI.CValue:=pCValue;
      ohKSI.BValue:=pBValue;
      ohKSI.CPrice:=RdX(pCValue/pGsQnt,gKey.StpRndFrc);
      ohKSI.EValue:=gPlc.ClcEPrice(ohGSCAT.VatPrc,pCValue);
      ohKSI.AValue:=gPlc.ClcAPrice(ohGSCAT.VatPrc,pBValue);
      ohKSI.PrfVal:=ohKSI.AValue-ohKSI.CValue;
      ohKSI.PrfPrc:=gPlc.ClcPrfPrc(ohKSI.CValue,ohKSI.AValue);
      ohKSI.PaCode:=ohKSH.PaCode;
      ohKSI.DocDate:=ohKSH.DocDate;
      ohKSI.FifNum:=pFifNum;
      ohKSI.KidNum:=pKidNum;
      ohKSI.KidItm:=pKidItm;
      ohKSI.KidDate:=pKidDate;
      ohKSI.Post;
(*      
      mItmNum:=ohKSO.NextItmNum(pDocNum);
      ohKSO.Insert;
      ohKSO.DocNum     Str12        ;Interné èíslo konsignaènej nahlášky
      ohKSO.ItmNum     word         ;Poradové èíslo položky dokladu
      ohKSO.OutDoc     Str12        ;Interné èíslo dokladu predaja
      ohKSO.OutItm     longint      ;Poradové èíslo položky dokladu
      ohKSO.OutQnt     double       ;Predaja/vydané množstvo
      ohKSO.OutVal     double       ;Hodnota predaja/výdaja
      ohKSO.OutDat     DateType     ;Datum predaja/výdaja
      ohKSO.OutPac     longint      ;Ciselny kod odberate¾a
RenDoc     Str12        ;Interné èíslo dokladu konsignaènej zípožièky
RenItm     longint      ;Poradové èíslo položky dokladu
RenFif     longint      ;FIFO karta konsignaènej zípožièky
RenVal     double       ;Hodnota konsignaènej zápožièky
RenDat     DateType     ;Datum príjmu konsignaènej zápožièky
RetDoc     Str12        ;Interné èíslo dokladu konsignaènej vrátenky
RetItm     longint      ;Poradové èíslo položky dokladu
RetDat     DateType     ;Datum výdaj konsignaènej vrátenky
BuyDoc     Str12        ;Interné èíslo dokladu konsignaèného nákupu
BuyItm     longint      ;Poradové èíslo položky dokladu
BuyFif     longint      ;FIFO karta konsignaèného nákupu
BuyVal     double       ;Hodnota nakúpeného príjmu
BuyDat     DateType     ;Datum príjmu konsignaèného nákupu
GsCode     longint      ;Tovarové èíslo - PLU
BPrice     double       ;PC/MJ s DPH
*)
    end
    else ShowMsg (eCom.GscIsNoExist,StrInt(pGsCode,0));
  end
  else ShowMsg(eCom.DocIsNoExist,pDocNum);
end;

procedure TKsd.SlcItm; // nacita polozky zadaneho dokladu do PX
begin
  If otKSI.Active then otKSI.Close;
  otKSI.Open;
  If ohKSI.LocateDocNum(ohKSH.DocNum) then begin
    Repeat
      otKSI.Insert;
      BTR_To_PX (ohKSI.BtrTable,otKSI.TmpTable);
      otKSI.Post;
      Application.ProcessMessages;
      ohKSI.Next;
    until ohKSI.Eof or (ohKSI.DocNum<>ohKSH.DocNum);
  end;
end;

procedure TKsd.SumItm(pDocNum:Str12); // Vyhotoví kumultaívny zoznam položiek vybraného dokladu pod¾a PLU
begin
  If otKSS.Active then otKSS.Close;
  otKSS.Open;
  If ohKSI.LocateDocNum(ohKSH.DocNum) then begin
    Repeat
      If otKSS.LocateGsCode(ohKSI.GsCode) then begin
        otKSS.Edit;
        otKSS.GsQnt:=otKSS.GsQnt+ohKSI.GsQnt;
        otKSS.CValue:=otKSS.CValue+ohKSI.CValue;
        otKSS.Post;
      end
      else begin
        If not ohGSCAT.Active then ohGSCAT.Open;
        otKSS.Insert;
        BTR_To_PX (ohKSI.BtrTable,otKSS.TmpTable);
        If ohGSCAT.LocateGsCode(ohKSI.GsCode) then otKSS.OsdCode:=ohGSCAT.OsdCode;
        otKSS.Post;
      end;
      Application.ProcessMessages;
      ohKSI.Next;
    until ohKSI.Eof or (ohKSI.DocNum<>ohKSH.DocNum);
  end;
end;

procedure TKsd.SlcItm(pDocNum:Str12); // nacita polozky zadaneho dokladu do PX
begin
  If ohKSH.LocateDocNum(pDocNum) then SlcItm;
end;

procedure TKsd.PrnDoc; // Vytlaèí aktualny doklad
begin
  PrnDoc(ohKSH.DocNum);
end;

procedure TKsd.PrnDoc(pDocNum:Str12); // Vytlaèí zadany doklad
var mBokNum:Str5;  mRep:TRep;  mtKSH:TKshTmp;  mhSYSTEM:TSystemHnd;  mtNOT:TNotTmp;
begin
  mBokNum:=BookNumFromDocNum(pDocNum);
  gAfc.GrpNum:=gvSys.LoginGroup;
  gAfc.BookNum:=mBokNum;
  If gAfc.Ksb.DocPrn then begin
    Open(mBokNum,TRUE,TRUE,TRUE,TRUE);
    If ohKSH.LocateDocNum(pDocNum) then begin
      mhSYSTEM:=TSystemHnd.Create;  mhSYSTEM.Open;
      mtNOT:=TNotTmp.Create;  mtNOT.Open;
      Notice(ohKSN.BtrTable,mtNOT.TmpTable,pDocNum,'N'); // Poznamky
      Notice(ohKSN.BtrTable,mtNOT.TmpTable,pDocNum,'I'); // Interne poznámky
      mtKSH:=TKshTmp.Create;  mtKSH.Open;
      mtKSH.Insert;
      BTR_To_PX (ohKSH.BtrTable,mtKSH.TmpTable);
      mtKSH.Post;
      SumItm(pDocNum);
      // --------------------------
      mRep:=TRep.Create(Self);
      mRep.SysBtr:=mhSYSTEM.BtrTable;
      mRep.HedTmp:=mtKSH.TmpTable;
      mRep.ItmTmp:=otKSS.TmpTable;
      mRep.SpcTmp:=mtNOT.TmpTable;
      mRep.Execute('KSD');
      If mRep.Printed then begin
        ohKSH.Edit;
        ohKSH.PrnCnt:=ohKSH.PrnCnt+1;
        ohKSH.Post;
      end;
      FreeAndNil (mRep);
      // --------------------------
      FreeAndNil (mtKSH);
      FreeAndNil (mtNOT);
      FreeAndNil (mhSYSTEM);
    end;
  end
  else ShowMsg(eCom.ThisFncIsDis,'');
end;

procedure TKsd.ResDoc(pYear:Str2;pSerNum:longint); // Zarezervuje zdoklad so zadanym poradovym cislom
begin
  oYear:=pYear;If oYear='' then oYear:=gvsys.ActYear2;
  If not ohKSH.LocateYearSerNum(oYear,pSerNum) then ohKSH.Res(oYear,pSerNum);
end;

procedure TKsd.ResVer; // Prekontroluje ci doklad je rezervovany ak ano zrusi ho
begin
  If ohKSH.DstLck=9 then begin
    ohKSN.Del(ohKSH.DocNum);
    ohKSH.Delete;
  end;
end;

procedure TKsd.NewDoc(pYear:Str2;pSerNum,pStkNum:word;pPaCode:longint;pDocDate,pBegDate,pEndDate:TDateTime); // Vygeneruje novu hlavicku dokladu
var mSerNum:word;  mDocNum:Str12;  mDocDate:TDateTime;  mhPAB:TPabHnd;
begin
  oYear:=pYear;If oYear='' then oYear:=gvsys.ActYear2;
  mSerNum:=pSerNum;
  mDocDate:=pDocDate;
  If mSerNum=0 then mSerNum:=GetDocNextYearSerNum(ohKSH.BtrTable,pYear); // Ak nie je zadane poradove cislo OD vygenerujeme nasledujuce
  If mDocDate=0 then mDocDate:=Date; // Ak nie je zadany datum nastavime aktualny den
  mDocNum:=ohKSH.GenDocNum(pYear,mSerNum);
  If not ohKSH.LocateDocNum(mDocNum) then begin // Ak neexistuje vyvorime hlacicku dokladu OD
    ohKSH.Insert;
    ohKSH.DocNum:=mDocNum;
    ohKSH.SerNum:=mSerNum;
    ohKSH.StkNum:=pStkNum;
    ohKSH.DocDate:=mDocDate;
    ohKSH.BegDate:=pBegDate;
    ohKSH.EndDate:=pEndDate;
    ohKSH.DstLck:=9;
    If (pPaCode>0) then begin
      mhPAB:=TPabHnd.Create;  mhPAB.Open(0);
      If mhPAB.LocatePaCode(pPaCode) then BTR_To_BTR (mhPAB.BtrTable,ohKSH.BtrTable);
      FreeAndNil (mhPAB);
    end;
    ohKSH.Post;
  end;
end;

procedure TKsd.ClcDoc; // prepocita hlavicku zadaneho dokladu
begin
  ClcDoc(ohKSH.DocNum);
end;

procedure TKsd.ClcDoc(pDocNum:Str12); // prepocita hlavicku zadaneho dokladu
var mBokNum:Str5;
begin
  mBokNum:=BookNumFromDocNum(pDocNum);
  Open(mBokNum,TRUE,TRUE,TRUE,FALSE);
  If ohKSH.LocateDocNum(pDocNum) then ohKSH.Clc(ohKSI);
end;

procedure TKsd.CnfDoc; // potvrdenie dokladu nastavi priznak rezervacie DstLck=9 na 0
begin
  If ohKSH.DstLck=9 then begin
    ohKSH.Edit;
    ohKSH.DstLck:=0;
    ohKSH.Post;
  end;
end;

procedure TKsd.TmpRef(pDocNum:Str12;pItmNum:longint); // Obnovy zaznam na zaklade BTR
begin
  If ohKSI.LocateDoIt(pDocNum,pItmNum) then begin
    If otKSI.LocateItmNum(ohKSI.ItmNum)
      then otKSI.Edit
      else otKSI.Insert;
    BTR_To_PX (ohKSI.BtrTable,otKSI.TmpTable);
    otKSI.Post;
  end;
end;

end.
{MOD 1905002}

