unit Osd;
{$F+}

// *****************************************************************************
//                               OBJEKT NA PRACU S OB
// *****************************************************************************
// Tento objekt obsahuje funkcie, ktoré umožnia naèíta položky dokladov a
// uloži ich do iného dokladu
//
// Programové funkcia:
// ---------------
// *****************************************************************************


interface

uses
  IcTypes, IcConst, IcFiles, IcConv, IcTools, IcValue, IcVariab,
  NexGlob, NexPath, NexMsg, NexError, NexIni,
  DocHand, SavClc, LinLst, ItgLog, Bok, Rep, Key, Stk, Doc, Plc, StkGlob,
  hGSCAT, hPAB, hOSH, hOSI, hOSN, hOST, tOSI, tOST, hWriLst,
  ComCtrls, SysUtils, Classes, Forms, MxArrays;

type
  PDat=^TDat;
  TDat=record
    rhOSH:TOshHnd;
    rhOSI:TOsiHnd;
    rhOSN:TOsnHnd;
    rhOST:TOstHnd;
  end;

  TOsd = class(TComponent)
    constructor Create(AOwner: TComponent);
    destructor  Destroy; override;
    private
      oBokNum:Str5;
      oYear:Str2;
      oSerNum:longint;
      oDocNum:Str12;
      oPaCode:longint;
      oDocDate:TDateTime;
      oFrmName:Str15;
      oDocClc:TStrings;
      oOpnBok:TStrings;
      oCValue:double; // Hodnota otoreneho dokladu bez DPH
      oEValue:double; // Hodnota otoreneho dokladu s DPH
      oInd:TProgressBar;
      oStk:TStk;
      oLst:TList;
      function GetOpenCount:word;
    public
      ohGSCAT:TGscatHnd;
      ohPAB:TPabHnd;
      ohOSH:TOSHHnd;
      ohOSI:TOSIHnd;
      ohOSN:TOSNHnd;
      ohOST:TOSTHnd;
      otOSI:TOsiTmp;
      otOST:TOStTmp;
      function ActBok:Str5;
      procedure Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
      procedure Open(pBokNum:Str5); overload; // Otvori vsetky databazove subory
      procedure Open(pBokNum:Str5;pOSH,pOSI,pOSN,pOST:boolean); overload;// Otvori zadane databazove subory

      procedure OpenLst(pBokLst:ShortString); // Otvori vsetky knihy ktore su zadane v retazci
      procedure NewDoc(pYear:Str2;pSerNum,pPaCode:longint;pStkNum:word;pResDoc:boolean); overload; // Vygeneruje novu hlavicku dokladu
      procedure SetPac(pPaCode:longint); 
      procedure ClcDoc(pDocNum:Str12); // Prepocita hlavicku zadaneho dokladu podla jeho poloziek
      procedure PrnDoc(pDocNum:Str12); // Vytlaèí zadany doklad
      procedure SlcItm(pDocNum:Str12); // Nacita polozky zadaneho dokladu do PX
      procedure AddItm(pGsCode:longint;pGsQnt,pAcCPrice:double); overload; // Prida novu polozku na otvoreny doklad
      procedure AddItm(pGsCode:longint;pGsQnt,pAcCPrice,pBPrice:double;pMsName:Str10); overload;// Prida novu polozku na otvoreny doklad
      procedure AddItmVal(pGsCode:longint;pGsQnt,pAcCValue,pBPrice:double;pMsName:Str10); // Prida novu polozku na otvoreny doklad
      function  ModItm(pDocNum:Str12;pItmNum,pGsCode:longint;pGsQnt:double):boolean; // Prida mnozstvo na polozku
      procedure DelItm; overload;
      procedure DelItm(pDocNum:Str12;pItmNum:longint); overload; // Prida novu polozku na zadany doklad
      procedure DelSto(pDocNum:Str12;pItmNum:longint); // Zrusi skladovu rezervaciu zadanej polozky
      procedure LstClc; // Prepocita hlavicky dokladov ktore su uvedene v zozname oDocClc
      procedure AddClc(pDocNum:Str12); // Prida doklad do zoznamu, hlavicky ktorych treba prepocitat

      function LocatePaGsSt(pPaCode,pGsCode:longint;pStkStat:Str1;pActBok:boolean):boolean; // Najde polozku objedbnavky pre zadaneho dodavatela so zadanym priznakom
      function LocateOnOi  (pOcdNum:Str12;pOcdItm:longint;pActBok:boolean):boolean; // Najde polozku zakazky
      function DocDel(pDocNum:Str12;pHedDel:boolean):boolean;  // Zrusi zadany doklad
    published
      property phOSH:TOSHHnd read ohOSH write ohOSH;
      property phOSI:TOSIHnd read ohOSI write ohOSI;
      property OpenCount:word read GetOpenCount;
      property BokNum:Str5 read oBokNum;
      property Year:Str2 read oYear write oYear;
      property SerNum:longint read oSerNum;
      property DocNum:Str12 read oDocNum;
      property PaCode:longint write oPaCode;
      property DocDate:TDateTime write oDocDate;
      property OpnBok:TStrings read oOpnBok;
      property CValue:double read oCValue;
      property EValue:double read oEValue;
      property Ind:TProgressBar read oInd write oInd;
  end;

implementation

uses bOsi, bWRILST;

constructor TOsd.Create(AOwner: TComponent);
begin
  oFrmName := AOwner.Name;
  oCValue := 0;  oEValue := 0;
  oDocClc := TStringList.Create;  oDocClc.Clear;
  oOpnBok := TStringList.Create;  oOpnBok.Clear;
  ohGSCAT := TGscatHnd.Create;  ohGSCAT.Open;
  ohPAB := TPabHnd.Create;  ohPAB.Open(0);
  otOSI := TOsiTmp.Create;
  otOST := TOstTmp.Create;
  oStk := TStk.Create;
  oLst := TList.Create;  oLst.Clear;
end;

destructor TOsd.Destroy;
var I:word;
begin
  If oLst.Count>0 then begin
    For I:=1 to oLst.Count do begin
      Activate (I);
      FreeAndNil (ohOST);
      FreeAndNil (ohOSI);
      FreeAndNil (ohOSN);
      FreeAndNil (ohOSH);
    end;
  end;
  FreeAndNil (oLst);
  FreeAndNil (oStk);
  FreeAndNil (otOSI);
  FreeAndNil (otOST);
  FreeAndNil (ohPAB);
  FreeAndNil (ohGSCAT);
  FreeAndNil (oDocClc);
  FreeAndNil (oOpnBok);
end;

// ********************************* PRIVATE ***********************************

function TOsd.GetOpenCount:word;
begin
  Result := oLst.Count;
end;

// ********************************** PUBLIC ***********************************

function TOsd.ActBok:Str5;
begin
  Result := '';
  If ohOSH.BtrTable.Active
    then Result := ohOSH.BtrTable.BookNum
    else begin
      If ohOSI.BtrTable.Active
        then Result := ohOSI.BtrTable.BookNum
        else begin
          If ohOSN.BtrTable.Active
            then Result := ohOSN.BtrTable.BookNum
            else begin
              If ohOST.BtrTable.Active then Result := ohOST.BtrTable.BookNum;
            end;
        end;
    end;
end;

procedure TOsd.Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
var mDat:PDat;
begin
  mDat := oLst.Items[pIndex-1];
  ohOSH := mDat.rhOSH;
  ohOSI := mDat.rhOSI;
  ohOSN := mDat.rhOSN;
  ohOST := mDat.rhOST;
end;

procedure TOsd.Open(pBokNum:Str5); // Otvori vsetky databazove subory
begin
  Open(pBokNum,TRUE,TRUE,TRUE,TRUE);
end;

procedure TOsd.Open(pBokNum:Str5;pOSH,pOSI,pOSN,pOST:boolean); // Otvori zadane databazove subory
var mFind:boolean;  mCnt:word;  mDat:PDat;
begin
  oBokNum := pBokNum;
  mFind := FALSE;
  If oLst.Count>0 then begin
    mCnt := 0;
    Repeat
      Inc (mCnt);
      Activate(mCnt);
      mFind := ActBok=pBokNum;
    until mFind or (mCnt=oLst.Count);
  end;
  If not mFind then begin // Ak dana kniha este nie je otvorena potomotvorime
    // Vytvorime objekty
    ohOSH := TOshHnd.Create;
    ohOSI := TOsiHnd.Create;
    ohOSN := TOsnHnd.Create;
    ohOST := TOstHnd.Create;
    // Otvorime databazove subory
    If pOSH then ohOSH.Open(pBokNum);
    If pOSI then ohOSI.Open(pBokNum);
    If pOSN then ohOSN.Open(pBokNum);
    If pOST then ohOST.Open(pBokNum);
    // Ulozime objekty do zoznamu
    GetMem (mDat,SizeOf(TDat));
    mDat^.rhOSH := ohOSH;
    mDat^.rhOSI := ohOSI;
    mDat^.rhOSN := ohOSN;
    mDat^.rhOST := ohOST;
    oLst.Add(mDat);
  end;
end;

procedure TOsd.OpenLst(pBokLst:ShortString); // Otvori vsetky knihy ktore su zadane v retazci
var mLinLst:TLinLst;
begin
  oOpnBok.Clear;
  mLinLst := TLinLst.Create;
  mLinLst.AddLst(pBokLst);
  If mLinLst.Count>0 then begin
    mLinLst.First;
    Repeat
      If gBok.BokExist('OSB',mLinLst.Itm,TRUE) then Open(mLinLst.Itm);
      Application.ProcessMessages;
      mLinLst.Next;
    until mLinLst.Eof;
  end
  else begin  // Otvorime vsetky knihy
    gBok.LoadBokLst('OSB','');
    If gBok.BokLst.Count>0 then begin
      gBok.BokLst.First;
      Repeat
        Open (gBok.BokLst.Itm);
        Application.ProcessMessages;
        gBok.BokLst.Next;
      until gBok.BokLst.Eof;
    end;
  end;
  FreeAndNil (mLinLst);
end;

procedure TOsd.NewDoc(pYear:Str2;pSerNum,pPaCode:longint;pStkNum:word;pResDoc:boolean); // Vygeneruje novu hlavicku dokladu
var mSerNum:word;mhWriLst:TWriLstHnd;
begin
  oYear:=pYear;If oYear='' then oYear:=gvsys.actyear2;
  If pSerNum=0
    then oSerNum := GetDocNextYearSerNum(ohOSH.BtrTable,oYear) //Vygenerujeme nove cislo dokladu
    else oSerNum := pSerNum;
  If oDocDate=0 then oDocDate := Date; // Ak nie je zadany datum nastavime aktualny den
  oDocNum := ohOSH.GenDocNum(oYear, oSerNum);
  If not ohOSH.LocateDocNum(oDocNum) then begin // Ak neexistuje vyvorime hlacicku dokladu
    ohOSH.Insert;
    ohOSH.DocNum  := oDocNum;
    ohOSH.SerNum  := oSerNum;
    ohOSH.StkNum  := pStkNum;
    If ohOSH.PlsNum=0 then ohOSH.PlsNum := 1;
    ohOSH.DocDate := oDocDate;
    ohOSH.DlvDate := oDocDate;
    If ohPAB.LocatePaCode(pPaCode) then begin
      BTR_To_BTR (ohPAB.BtrTable,ohOSH.BtrTable);
      // Zadat aj miesto dodania
    end;
    mhWriLst:=TWrilstHnd.Create;mhWriLst.Open;
    If mhWriLst.LocateWriNum(GetWriNum(pStkNum)) then
    begin
      ohOSH.WpaCode := mhWriLst.WriNum;
      ohOSH.WpaName := mhWriLst.WriName;
      ohOSH.WpaAddr := mhWriLst.WriAddr;
      ohOSH.WpaSta  := mhWriLst.WriSta;
      ohOSH.WpaCty  := mhWriLst.WriCty;
      ohOSH.WpaCtn  := GetCtyName (mhWriLst.WriCty);
      ohOSH.WpaZip  := mhWriLst.WriZip;
    end;
    FreeAndNil(mhWriLst);
    ohOSH.AcDvzName := gKey.SysAccDvz;
    ohOSH.FgDvzName := gKey.Osb.BokDvz[BokNum];
    ohOSH.VatPrc1:=gIni.GetVatPrc(1);
    ohOSH.VatPrc2:=gIni.GetVatPrc(2);
    ohOSH.VatPrc3:=gIni.GetVatPrc(3);
    ohOSH.VatPrc4:=gIni.GetVatPrc(4);
    ohOSH.VatPrc5:=gIni.GetVatPrc(5);
    ohOSH.RspName:=gvSys.UserName;
    ohOSH.FgCourse:= 1;
    ohOSH.VatDoc  := 1;
    If pResDoc
      then ohOSH.DstLck := 9
      else ohOSH.DstLck := 0;
    ohOSH.Post;
  end;
end;

procedure TOsd.ClcDoc(pDocNum:Str12); // PrepOSIta hlavicku zadaneho dokladu podla jeho poloziek
var mCQ,mFQ,mSQ,mItmQnt,mCntReq,mCntOrd,mCntRes,mCntPrp,mCntRat,mCntTrm,mCntOut,mCntErr:longint;
    mAcDValue,mAcDscVal,mAcCValue,mAcVatVal,mAcEValue,mAcAValue,mAcBValue,
    mFgDValue,mFgDscVal,mFgCValue,mFgVatVal,mFgEValue:double;  mDstStk:Str1;
begin
  If ohOSH.LocateDocNum(pDocNum) then begin
    mCQ := 0; mFQ := 0; mSQ := 0;
    mItmQnt := 0;  mCntOrd := 0;  mCntReq := 0;  mCntRes := 0;  mDstStk := 'S';
    mCntPrp := 0;  mCntRat := 0;  mCntTrm := 0;  mCntOut := 0;  mCntErr := 0;
    mAcDValue:= 0; mAcDscVal:= 0; mAcCValue:= 0; mAcVatVal:= 0; mAcEValue:= 0;
    mAcAValue:= 0; mAcBValue:= 0; mFgDValue:= 0; mFgDscVal:= 0; mFgCValue:= 0;
    mFgVatVal:= 0; mFgEValue:= 0;
    ohOSI.SwapIndex;
    If ohOSI.LocateDocNum(ohOSH.DocNum) then begin
      Repeat
        Inc (mItmQnt);
        mAcCValue := mAcCValue+ohOSI.AcCValue;
        mAcDValue := mAcDValue+ohOSI.AcDValue;
        mAcEValue := mAcEValue+ohOSI.AcEValue;
        mAcDscVal := mAcDscVal+ohOSI.AcDscVal;
        mAcAValue := mAcAValue+ohOSI.AcAValue;
        mAcBValue := mAcBValue+ohOSI.AcBValue;

        mFgDscVal := mFgDscVal+ohOSI.FgDscVal;
        mFgCValue := mFgCValue+ohOSI.FgCValue;
        mFgEValue := mFgEValue+ohOSI.FgEValue;
        mFgDValue := mFgDValue+ohOSI.FgDValue;
        mFgDscVal := mFgDscVal+ohOSI.FgDscVal;
        If (ohOSI.DlvDate>0) then Inc (mCntTrm);
        If ohOSI.StkStat='N' then Inc (mCntReq);
        If ohOSI.StkStat='O' then Inc (mCntOrd);
        If ohOSI.StkStat='R' then Inc (mCntRes);
        If ohOSI.StkStat='P' then Inc (mCntPrp);
        If ohOSI.StkStat='S' then Inc (mCntOut);
        If ohOSI.StkStat='E' then Inc (mCntErr);
        If ohOSI.StkStat='O' then mDstStk := 'O';
        If ohOSI.FixDate>0 then Inc(mFQ);
        If ohOSI.CnfDate>0 then Inc(mCQ);
        If ohOSI.SupDate>0 then Inc(mSQ);
        ohOSI.Next;
      until (ohOSI.Eof) or (ohOSI.DocNum<>pDocNum);
    end;
    ohOSI.RestoreIndex;
    // Ulozime vypOSItane hodnoty do hlavicky objednavky
    ohOSH.Edit;
    If IsNotNul (mFgDValue)
      then ohOSH.DscPrc := Rd2 ((mFgDscVal/mFgDValue)*100)
      else ohOSH.DscPrc := 0;
    ohOSH.AcDValue := mAcDValue;
    ohOSH.AcCValue := mAcCValue;
    ohOSH.AcEValue := mAcEValue;
    ohOSH.AcVatVal := mAcEValue-mAcCValue;
    ohOSH.AcAValue := mAcAValue;
    ohOSH.AcBValue := mAcBValue;
    ohOSH.AcDscVal := mAcDscVal;
    ohOSH.FgDValue := mFgDValue;
    ohOSH.FgCValue := mFgCValue;
    ohOSH.FgEValue := mFgEValue;
    ohOSH.FgVatVal := mFgEValue-mFgCValue;
    ohOSH.FgDscVal := mFgDscVal;
    ohOSH.DstStk := mDstStk;
    ohOSH.ItmQnt := mItmQnt;
    If (mItmQnt>0) and (ohOSH.DstLck=9) then ohOSH.DstLck := 0;
    If mSQ=mItmQnt then ohOSH.CnfStat := 'P'
    else If mSQ>0  then ohOSH.CnfStat := 'N'
    else If mCQ>0  then ohOSH.CnfStat := 'C'
    else If mFQ>0  then ohOSH.CnfStat := 'F'
                   else ohOSH.CnfStat := '';
    ohOSH.Post;
  end;
end;

procedure TOsd.PrnDoc(pDocNum:Str12); // Vytlaèí zadany dodaci list
var mRep:TRep;
begin
  Open(BookNumFromDocNum(pDocNum));
  If ohOSH.LocateDocNum(pDocNum) then begin
    mRep := TRep.Create(Self);
    mRep.HedBtr := ohOSH.BtrTable;
    mRep.Execute('OSD');
    If mRep.Printed then begin
      ohOSH.Edit;
      ohOSH.DstLck := 1;
      ohOSH.PrnCnt := ohOSH.PrnCnt+1;
      ohOSH.Post;
    end;
    FreeAndNil (mRep);
  end;
end;

procedure TOsd.SlcItm(pDocNum:Str12); // Nacita polozky zadaneho dokladu do PX
begin
  oCValue := 0;   oEValue := 0;
  If otOSI.Active then otOSI.Close;
  otOSI.Open;
  If ohOSI.LocateDocNum(pDocNum) then begin
    Repeat
      otOSI.Insert;
      BTR_To_PX (ohOSI.BtrTable,otOSI.TmpTable);
      otOSI.Post;
      oCValue := oCValue+ohOSI.FgCValue;
      oEValue := oEValue+ohOSI.FgEValue;
      Application.ProcessMessages;
      ohOSI.Next;
    until ohOSI.Eof or (ohOSI.DocNum<>pDocNum);
  end;
end;

procedure TOsd.AddItm(pGsCode:longint;pGsQnt,pAcCPrice:double); // Prida novu polozku na otvoreny doklad
begin
  AddItm(pGsCode,pGsQnt,pAcCPrice,0,'');
end;

procedure TOsd.AddItm(pGsCode:longint;pGsQnt,pAcCPrice,pBPrice:double;pMsName:Str10); // Prida novu polozku na otvoreny doklad
var mItmNum:word;
begin
  If not ohGSCAT.Active then ohGSCAT.Open;
  If ohGSCAT.LocateGsCode(pGsCode) then begin
    mItmNum := NextItmNum(ohOSI.BtrTable,ohOSH.DocNum);
    ohOSI.Insert;
    ohOSI.DocNum := ohOSH.DocNum;
    ohOSI.ItmNum := mItmNum;
    BTR_To_BTR(ohGSCAT.BtrTable,ohOSI.BtrTable);
    ohOSI.OrdQnt := pGsQnt;
    ohOSI.AcCValue := RdX(pAcCPrice*pGsQnt,gKey.StpRndFrc);
    ohOSI.AcEValue := gPlc.ClcEPrice(ohOSI.VatPrc,ohOSI.AcCValue);
    ohOSI.AcDValue := ohOSI.AcCValue;
    ohOSI.FgDValue := ohOSI.AcCValue;
    ohOSI.FgCValue := ohOSI.AcCValue;
    ohOSI.FgEValue := ohOSI.AcEValue;
    ohOSI.FgCPrice := ohOSI.FgCValue/ohOSI.OrdQnt;
    ohOSI.FgDPrice := ohOSI.FgCPrice;
    ohOSI.FgEPrice := ohOSI.FgEValue/ohOSI.OrdQnt;
    ohOSI.AcBPrice := pBPrice;
    ohOSI.AcBValue := pBPrice*pGsQnt;
    ohOSI.AcAValue := gPlc.ClcAPrice(ohOSI.VatPrc,ohOSI.AcBValue);
    If pMsName<>'' then ohOSI.MsName := pMsName;
    If IsNotNul(pGsQnt) then ohOSI.AcAPrice := ohOSI.AcAValue/pGsQnt;
    ohOSI.StkNum := ohOSH.StkNum;
    ohOSI.PaCode := ohOSH.PaCode;
    ohOSI.DocDate := ohOSH.DocDate;
    ohOSI.StkStat := 'O';
    ohOSI.Post;
//    oStk.AddSto(ohOSI);
  end
  else ShowMsg (eCom.GscIsNoExist,StrInt(pGsCode,0));
end;

procedure TOsd.AddItmVal(pGsCode:longint;pGsQnt,pAcCValue,pBPrice:double;pMsName:Str10); // Prida novu polozku na otvoreny doklad
var mItmNum:word;
begin
  If not ohGSCAT.Active then ohGSCAT.Open;
  If ohGSCAT.LocateGsCode(pGsCode) then begin
    mItmNum := NextItmNum(ohOSI.BtrTable,ohOSH.DocNum);
    ohOSI.Insert;
    ohOSI.DocNum := ohOSH.DocNum;
    ohOSI.ItmNum := mItmNum;
    BTR_To_BTR(ohGSCAT.BtrTable,ohOSI.BtrTable);
    ohOSI.OrdQnt := pGsQnt;
    ohOSI.AcCValue := RdX(pAcCValue,gKey.StvRndFrc);
    ohOSI.AcEValue := gPlc.ClcEPrice(ohOSI.VatPrc,ohOSI.AcCValue);
    ohOSI.AcDValue := ohOSI.AcCValue;
    ohOSI.FgDValue := ohOSI.AcCValue;
    ohOSI.FgCValue := ohOSI.AcCValue;
    ohOSI.FgEValue := ohOSI.AcEValue;
    ohOSI.FgCPrice := ohOSI.FgCValue/ohOSI.OrdQnt;
    ohOSI.FgDPrice := ohOSI.FgCPrice;
    ohOSI.FgEPrice := ohOSI.FgEValue/ohOSI.OrdQnt;
    ohOSI.AcBPrice := pBPrice;
    ohOSI.AcBValue := pBPrice*pGsQnt;
    ohOSI.AcAValue := gPlc.ClcAPrice(ohOSI.VatPrc,ohOSI.AcBValue);
    If pMsName<>'' then ohOSI.MsName := pMsName;
    If IsNotNul(pGsQnt) then ohOSI.AcAPrice := ohOSI.AcAValue/pGsQnt;
    ohOSI.StkNum := ohOSH.StkNum;
    ohOSI.PaCode := ohOSH.PaCode;
    ohOSI.DocDate := ohOSH.DocDate;
    ohOSI.StkStat := 'O';
    ohOSI.Post;
  end
  else ShowMsg (eCom.GscIsNoExist,StrInt(pGsCode,0));
end;

procedure TOsd.DelItm;
begin
  DelItm(otOSI.DocNum,otOSI.ItmNum);
  otOSI.Delete;
end;

procedure TOsd.DelItm(pDocNum:Str12;pItmNum:longint);
begin
  If ohOSI.LocateDoIt(pDocNum,pItmNum) then begin
    oCValue := oCValue-ohOSI.FgCValue;
    oEValue := oEValue-ohOSI.FgEValue;
    ohOSI.Delete;
  end;
end;

procedure TOsd.DelSto(pDocNum:Str12;pItmNum:longint); // Zrusi skladovu rezervaciu zadanej polozky
begin
//  If ohOSI.LocateDoIt(pDocNum,pItmNum) then oStk.DelSto(ohOSI.DocNum,ohOSI.ItmNum);  // Odpise rezervaciu zo zadaneho dokladu
end;

procedure TOsd.AddClc(pDocNum: Str12);
var mExist:boolean;  I:word;
begin
  mExist := FALSE;
  If oDocClc.Count>0 then begin  // Mame doklady na prepOSItanie
    For I:=0 to oDocClc.Count-1 do begin
      If oDocClc.Strings[I]=pDocNum then mExist := TRUE;
    end
  end;
  If not mExist then oDocClc.Add(pDocNum);
end;

procedure TOsd.LstClc; // PrepOSIta hlavicky zakazkovych dokladov ktore su uvedene v zozname oDocClc
var I:word;
begin
  If oDocClc.Count>0 then begin  // Mame doklady na prepOSItanie
    For I:=0 to oDocClc.Count-1 do begin
      Open(BookNumFromDocNum(oDocClc.Strings[I]));
      ClcDoc(oDocClc.Strings[I]);
    end
  end;
end;

function TOsd.LocatePaGsSt(pPaCode,pGsCode:longint;pStkStat:Str1;pActBok:boolean):boolean; // Najde polozku zakazky pre zadaneho odberatela so zadanym priznakom
var mCnt:word;
begin
  Result := FALSE;
  If pActBok then begin // Hladat len v aktualnej knihe
    Result := ohOSI.LocatePaGsSt(pPaCode,pGsCode,pStkStat);
  end
  else begin // Hladat vo vsetkych knihach
    mCnt := 0;
    Repeat
      Activate(mCnt);
      Result := ohOSI.LocatePaGsSt(pPaCode,pGsCode,pStkStat);
      Inc (mCnt);
    until Result or (mCnt=oLst.Count);
  end;
end;

function TOsd.LocateOnOi  (pOcdNum:Str12;pOcdItm:longint;pActBok:boolean):boolean; // Najde polozku zakazky
var mCnt:word;
begin
  (*
  Result := FALSE;
  If pActBok then begin // Hladat len v aktualnej knihe
    Result := ohOSI.LocateOnOi (pOcdNum,pOcdItm);
  end
  else begin // Hladat vo vsetkych knihach
    mCnt := 0;
    Repeat
      Activate(mCnt);
      Result := ohOSI.LocateOnOi (pOcdNum,pOcdItm);
      Inc (mCnt);
    until Result or (mCnt=oOSI.Count);
  end;
  *)
end;

function TOsd.DocDel(pDocNum:Str12;pHedDel:boolean):boolean;  // Zrusi zadany doklad
begin
(*
  Result := TRUE;
  If ohOSH.LocateDocNum(pDocNum) then begin
    If DocUnr(pDocNum) then begin
      If ohOSI.LocateDocNum(pDocNum) then begin
        Repeat
          Application.ProcessMessages;
          If ohOSI.StkStat='N'
            then ohOSI.Delete
            else begin
              Result := FALSE;
              ohOSI.Next;
            end;
        until ohOSI.Eof or (ohOSI.Count=0) or (ohOSI.DocNum<>pDocNum);
      end;
    end;
    ohOSH.Clc(ohOSI);
    Result := ohOSH.ItmQnt=0; // Je to v poriadku ak doklad nema ziadne polozky
    If Result and pHedDel then ohOSH.Delete;  // Ak je nastavene zrusenie hlavicky a bola vymazana kazda polozka zrusime hlavicku dokladu
  end;
*)
end;

function TOsd.ModItm(pDocNum: Str12; pItmNum,pGsCode: Integer; pGsQnt: double):boolean;
var mPrice : double;
begin
  Result:=False;
  If (pItmNum=0) then begin
    If ohOSI.LocateDocNum(pDocNum) then begin
      while not ohOSI.Eof and (ohOSI.DocNum=pDocNum) and (ohOSI.GsCode<>pGsCode) do begin
        ohOSI.Next;
      end;
      Result := not ohOSI.Eof and (ohOSI.DocNum=pDocNum) and (ohOSI.GsCode=pGsCode);
    end;
  end else Result := ohOSI.LocateDoIt(pDocNum,pItmNum);
  If Result then begin
    If IsNotNul(ohOSI.OrdQnt)
      then mPrice := ohOSI.AcCValue/ohOSI.OrdQnt else mPrice := ohOSI.AcCValue;
    ohOSI.Edit;
    ohOSI.OrdQnt := ohOSI.OrdQnt + pGsQnt;
    ohOSI.AcCValue := RdX(mPrice*ohOSI.OrdQnt,gKey.StpRndFrc);
    ohOSI.AcEValue := gPlc.ClcEPrice(ohOSI.VatPrc,ohOSI.AcCValue);
    ohOSI.AcDValue := ohOSI.AcCValue;
    ohOSI.FgDValue := ohOSI.AcCValue;
    ohOSI.FgCValue := ohOSI.AcCValue;
    ohOSI.FgEValue := ohOSI.AcEValue;
    If IsNotNul(ohOSI.OrdQnt) then ohOSI.FgCPrice := ohOSI.FgCValue/ohOSI.OrdQnt;
    ohOSI.FgDPrice := ohOSI.FgCPrice;
    If IsNotNul(ohOSI.OrdQnt) then ohOSI.FgEPrice := ohOSI.FgEValue/ohOSI.OrdQnt;
    ohOSI.AcBValue := ohOSI.AcBPrice*ohOSI.OrdQnt;
    ohOSI.AcAValue := gPlc.ClcAPrice(ohOSI.VatPrc,ohOSI.AcBValue);
    If IsNotNul(ohOSI.OrdQnt) then ohOSI.AcAPrice := ohOSI.AcAValue/ohOSI.OrdQnt;
    ohOSI.Post;
//    oStk.StoRef(ohOSI);
    Result := True;
  end;
end;

procedure TOsd.SetPac(pPaCode: Integer);
var mhWriLst:TWriLstHnd;
begin
  ohOSH.Edit;
  If ohPAB.LocatePaCode(pPaCode) then begin
    BTR_To_BTR (ohPAB.BtrTable,ohOSH.BtrTable);
    // Zadat aj miesto dodania
  end;
  mhWriLst:=TWrilstHnd.Create;mhWriLst.Open;
  If mhWriLst.LocateWriNum(GetWriNum(ohOSH.StkNum)) then
  begin
    ohOSH.WpaCode := mhWriLst.WriNum;
    ohOSH.WpaName := mhWriLst.WriName;
    ohOSH.WpaAddr := mhWriLst.WriAddr;
    ohOSH.WpaSta  := mhWriLst.WriSta;
    ohOSH.WpaCty  := mhWriLst.WriCty;
    ohOSH.WpaCtn  := GetCtyName (mhWriLst.WriCty);
    ohOSH.WpaZip  := mhWriLst.WriZip;
  end;
  FreeAndNil(mhWriLst);
  ohOSH.Post;
end;

end.


