unit Csd;
{$F+}

// *****************************************************************************
//                     CENOVE PONUKY PRENAJMU ZARIADENI
// *****************************************************************************
//
// Programové funkcia:
// ---------------
// *****************************************************************************


interface

uses
  IcTypes, IcConst, IcConv, IcTools, IcVariab, DocHand, NumText, IcDate, NexGlob, NexPath, NexIni, NexMsg, NexError, JrnAcc, PayFnc,
  SavClc, LinLst, Txt, Bok, Rep, Key, Afc, Doc, Dac, Plc, ItgLog, hSYSTEM, hPAB, hCSH, hCSI, tCSI, tCSH, hCSN, tNOT, hCSOINC, hCSOEXP,
  LangForm, BtrHand, ComCtrls, SysUtils, Classes, Forms;

type
  PDat=^TDat;
  TDat=record
    rhCSH:TCshHnd;
    rhCSI:TCsiHnd;
    rhCSN:TCsnHnd;
  end;

  TCsd = class(TComponent)
    constructor Create(AOwner: TComponent);
    destructor  Destroy; override;
    private
      oBokNum:Str5;
      oFrmName:Str15;
      oLst:TList;
      procedure Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
    public
      oPay:TPayFnc;
      ohCSH:TCshHnd;
      ohCSI:TCsiHnd;
      otCSI:TCsiTmp;
      ohCSN:TCsnHnd;
      ohCSOINC:TCsoincHnd;
      ohCSOEXP:TCsoexpHnd;
      procedure Open(pBokNum:Str5); overload; // Otvori vsetky databazove subory
      procedure Open(pBokNum:Str5;pCSH,pCSI,pCSN:boolean); overload;// Otvori zadane databazove subory
      procedure PrnDoc(pDocNum:Str12); // Vytlaèí zadany dodaci list
      procedure NewDoc(pYear:Str2;pSerNum:word;pPaCode:longint;pDocDate:TDateTime;pDesTxt:Str30;pDocType:Str1); // Vygeneruje novu hlavicku dokladu
      procedure CnfDoc; // Potvrdenie dokladu nastavi priznak rezervacie DstLck=9 na 0
      procedure ClcDoc(pDocNum:Str12); // Prepocita hlavicku zadaneho dokladu
      procedure AccDoc; overload; // Rozúètuje aktualny doklad doklad
      procedure AccDoc(pDocNum:Str12); overload; // Rozúètuje zadaný doklad
      procedure TmpRef(pDocNum:Str12;pItmNum:longint); // Obnovy zaznam na zaklade BTR
      procedure SlcItm(pDocNum:Str12); // Nacita polozky zadaneho dokladu do PX
      procedure AddItm(pDocNum:Str12;pCsoNum:word;pPyVatVal,pPyBValue:double;pConDoc,pConExt:Str12); // Prida novu polozku na zadany doklad
      procedure AddItmAcc(pDocNum:Str12;pCsoNum:word;pPyVatVal,pPyBValue:double;pConDoc,pConExt:Str12;pAccSnt:Str3;pAccAnl:Str6;pDesTxt:Str30;pVatPrc:byte); // Prida novu polozku na zadany doklad
      procedure AddDpi(pDocNum:Str12;pVatPrc:byte;pBvalue:double); // Pridá položku: Príjatá záloha
      procedure AddDpe(pDocNum:Str12;pVatPrc:byte;pBvalue:double); // Pridá položku: Odpoèet zálohy
    published
      property BokNum:Str5 read oBokNum;
  end;

implementation

uses bSYSTEM, bCSH;

constructor TCsd.Create(AOwner: TComponent);
begin
  oFrmName:=AOwner.Name;
  oPay:=TPayFnc.Create;
  oLst:=TList.Create;  oLst.Clear;
  otCSI:=TCsiTmp.Create;
  ohCSOINC:=TCsoincHnd.Create;
  ohCSOEXP:=TCsoexpHnd.Create;
end;

destructor TCsd.Destroy;
var I:word;
begin
  If oLst.Count>0 then begin
    For I:=1 to oLst.Count do begin
      Activate(I);
      FreeAndNil(ohCSN);
      FreeAndNil(ohCSI);
      FreeAndNil(ohCSH);
    end;
  end;
  FreeAndNil (oPay);
  FreeAndNil (oLst);
  FreeAndNil (otCSI);
  FreeAndNil (ohCSOINC);
  FreeAndNil (ohCSOEXP);
end;

// ********************************* PRIVATE ***********************************

procedure TCsd.Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
var mDat:PDat;
begin
  mDat:=oLst.Items[pIndex-1];
  ohCSH:=mDat.rhCSH;
  ohCSI:=mDat.rhCSI;
  ohCSN:=mDat.rhCSN;
end;

// ********************************** PUBLIC ***********************************

procedure TCsd.Open(pBokNum:Str5); // Otvori vsetky databazove subory
begin
  Open (pBokNum,TRUE,TRUE,TRUE);
end;

procedure TCsd.Open(pBokNum:Str5;pCSH,pCSI,pCSN:boolean); // Otvori zadane databazove subory
var mFind:boolean;  mCnt:word;  mDat:PDat;
begin
  oBokNum:=pBokNum;
  mFind:=FALSE;
  If oLst.Count>0 then begin
    mCnt:=0;
    Repeat
      Inc (mCnt);
      Activate(mCnt);
      mFind:=ohCSH.BtrTable.BookNum=pBokNum;
    until mFind or (mCnt=oLst.Count);
  end;
  If not mFind then begin // Ak dana kniha este nie je otvorena potomotvorime
    // Vytvorime objekty
    ohCSH:=TCshHnd.Create;
    ohCSI:=TCsiHnd.Create;
    ohCSN:=TCsnHnd.Create;
    // Otvorime databazove subory
    If pCSH then ohCSH.Open(pBokNum);
    If pCSI then ohCSI.Open(pBokNum);
    If pCSN then ohCSN.Open(pBokNum);
    // Ulozime objekty do zoznamu
    GetMem (mDat,SizeOf(TDat));
    mDat^.rhCSH:=ohCSH;
    mDat^.rhCSI:=ohCSI;
    mDat^.rhCSN:=ohCSN;
    oLst.Add(mDat);
  end;
end;

procedure TCsd.SlcItm(pDocNum:Str12); // nacita polozky zadaneho dokladu do PX
begin
  If otCSI.Active then otCSI.Close;
  otCSI.Open;
  If ohCSI.LocateDocNum(pDocNum) then begin
    Repeat
      otCSI.Insert;
      BTR_To_PX (ohCSI.BtrTable,otCSI.TmpTable);
      otCSI.Post;
      Application.ProcessMessages;
      ohCSI.Next;
    until ohCSI.Eof or (ohCSI.DocNum<>pDocNum);
  end;
end;

procedure TCsd.AddItm(pDocNum:Str12;pCsoNum:word;pPyVatVal,pPyBValue:double;pConDoc,pConExt:Str12); // Prida novu polozku na zadany doklad
var mItmNum:word;  mDesTxt:Str30;  mAccSnt:Str3;  mAccAnl:Str6;  mVatPrc:byte;  mVatVal:double;
begin
  If IsNotNul(Abs(pPyVatVal)+Abs(pPyBValue)) then begin
    If ohCSH.LocateDocNum(pDocNum) then begin
      mDesTxt:='';  mAccSnt:='';   mAccAnl:='';
      mItmNum:=ohCSI.NextItmNum(pDocNum);
      If ohCSH.DocType='I' then begin  // Prijmovy pokladnicny doklad
        If not ohCSOINC.Active then ohCSOINC.Open;
        If ohCSOINC.LocateCsoNum(pCsoNum) then begin
          mDesTxt:=ohCSOINC.CsoName;
          mAccSnt:=ohCSOINC.AccSnt;
          mAccAnl:=ohCSOINC.AccAnl;
          mVatPrc:=ohCSOINC.VatPrc;
        end
  //      else ShowMsg (,);  TODO
      end
      else begin // Vydajovy pokladnicny doklad
        If not ohCSOEXP.Active then ohCSOEXP.Open;
        If ohCSOEXP.LocateCsoNum(pCsoNum) then begin
          mDesTxt:=ohCSOEXP.CsoName;
          mAccSnt:=ohCSOEXP.AccSnt;
          mAccAnl:=ohCSOEXP.AccAnl;
          mVatPrc:=ohCSOEXP.VatPrc;
        end
  //      else ShowMsg (,);  TODO
      end;
      try BtrBegTrans;
        mVatVal:=pPyVatVal;
        If IsNul(mVatVal) then mVatVal:=pPyBValue-gPlc.ClcAPrice(mVatPrc,pPyBValue);
        ohCSI.Insert;
        ohCSI.DocNum:=pDocNum;
        ohCSI.ItmNum:=mItmNum;
        ohCSI.Describe:=mDesTxt;
        ohCSI.AccSnt:=mAccSnt;
        ohCSI.AccAnl:=mAccAnl;
        ohCSI.VatPrc:=mVatPrc;
        ohCSI.PyBValue:=pPyBValue;
        ohCSI.PyAValue:=pPyBValue-mVatVal;
        ohCSI.AcBValue:=Rd2(ohCSI.PyBValue*ohCSH.PyCourse);
        ohCSI.AcAValue:=Rd2(ohCSI.PyAValue*ohCSH.PyCourse);
        ohCSI.PyCourse:=1;
        ohCSI.FgCourse:=1;
        ohCSI.FgPayVal:=ohCSI.PyBValue;
        ohCSI.AcDvzName:=ohCSH.AcDvzName;
        ohCSI.PyDvzName:=ohCSH.PyDvzName;
        ohCSI.FgDvzName:=ohCSH.PyDvzName;
        ohCSI.DocDate:=ohCSH.DocDate;
        ohCSI.PaCode:=ohCSH.PaCode;
        ohCSI.WriNum:=ohCSH.WriNum;
        ohCSI.ConDoc:=pConDoc;
        ohCSI.ConExt:=pConExt;
        ohCSI.Post;
        If pConDoc<>'' then begin // Uhrada faktur
          oPay.AddPayJrn(ohCSI.DocNum,ohCSI.ItmNum,ohCSI.ConExt,ohCSI.ConDoc,ohCSI.DocDate,ohCSI.PaCode,ohCSI.PyBValue,ohCSI.WriNum,mDesTxt);
        end;
      BtrEndTrans;
      except BtrAbortTrans; end;
    end
    else ShowMsg(eCom.DocIsNoExist,pDocNum);
  end;
end;

procedure TCsd.PrnDoc(pDocNum:Str12); // Vytlaèí zadany dodaci list
var mBokNum:Str5;  mRep:TRep;  mhSYSTEM:TSystemHnd;  mtCSH:TCshTmp;  mtNOT:TNotTmp;  mInfVal:double;
begin
  mBokNum:=BookNumFromDocNum(pDocNum);
  gAfc.GrpNum:=gvSys.LoginGroup;
  gAfc.BookNum:=mBokNum;
  If gAfc.AmbDocPrn then begin
    Open (mBokNum,TRUE,TRUE,TRUE);
    If ohCSH.LocateDocNum(pDocNum) then begin
      mhSYSTEM:=TSystemHnd.Create;  mhSYSTEM.Open;
      mtCSH:=TCshTmp.Create;   mtCSH.Open;
      mtCSH.Insert;
      BTR_To_PX (ohCSH.BtrTable,mtCSH.TmpTable);
      mtCSH.PyVatVal1:=ohCSH.PyBValue1-ohCSH.PyAValue1;
      mtCSH.PyVatVal2:=ohCSH.PyBValue2-ohCSH.PyAValue2;
      mtCSH.PyVatVal3:=ohCSH.PyBValue3-ohCSH.PyAValue3;
      mtCSH.TxtVal:=ConvNumToText(mtCSH.PyBValue);
      If gKey.SysFixCrs>0 then begin
        If gKey.SysInfDvz='EUR'
          then mInfVal:=ohCSH.PyBValue/gKey.SysFixCrs
          else mInfVal:=ohCSH.PyBValue*gKey.SysFixCrs;
        mtCSH.PyDuoInf:='Konverzný kurz: '+StrDoub(gKey.SysFixCrs,2,4)+'    Hodnota dokladu: '+StrDoub(mInfVal,0,2)+' '+gKey.SysInfDvz;
      end;
      mtCSH.Post;
      mtNOT:=TNotTmp.Create;  mtNOT.Open;
      Notice (ohCSN.BtrTable,mtNOT.TmpTable,pDocNum,'N'); // Nacita poznamky do docasneho suboru pre tlac
      SlcItm(pDocNum);
      // --------------------------
      mRep:=TRep.Create(Self);
      mRep.SysBtr:=mhSYSTEM.BtrTable;
      mRep.HedTmp:=mtCSH.TmpTable;
      mRep.ItmTmp:=otCSI.TmpTable;
      mRep.SpcTmp:=mtNOT.TmpTable;
      If copy(pDocNum,1,2)='PP'
        then mRep.Execute('CSDI')
        else mRep.Execute('CSDE');
      FreeAndNil (mRep);
      // --------------------------
      FreeAndNil (mtNOT);
      FreeAndNil (mtCSH);
      FreeAndNil (mhSYSTEM);
    end;
  end
  else ShowMsg(eCom.ThisFncIsDis,'');
end;

procedure TCsd.NewDoc(pYear:Str2;pSerNum:word;pPaCode:longint;pDocDate:TDateTime;pDesTxt:Str30;pDocType:Str1); // Vygeneruje novu hlavicku dokladu
var mSerNum,mTypNum:word;  mDocNum:Str12;  mDocDate:TDateTime;  mhPAB:TPabHnd;  mPyBegVal:double;mhSYSTEM:TSystemHnd;
begin
  If pYear='' then pYear:=gvSys.ActYear2;
  mSerNum:=pSerNum;
  mDocDate:=pDocDate;
  If mSerNum=0 then begin
    mSerNum:=ohCSH.NextSerNum(pYear); // Ak nie je zadane poradove cislo OD vygenerujeme nasledujuce
  end;
  mTypNum:=ohCSH.NextTypNum(pYear,pDocType); // Najde nasledujuce volne typove cislo dokladu
  mPyBegVal:=ohCSH.GetBegVal;  // Urci pociatocny stav pred novym dokladom
  If mDocDate=0 then mDocDate:=Date; // Ak nie je zadany datum nastavime aktualny den
  mDocNum:=ohCSH.GenDocNum(pYear,mSerNum,pDocType);
  If not ohCSH.LocateDocNum(mDocNum) then begin // Ak neexistuje vyvorime hlacicku dokladu OD
    ohCSH.Insert;
    ohCSH.DocNum:=mDocNum;
    ohCSH.SerNum:=mSerNum;
    ohCSH.Year:=pYear;
    ohCSH.DocCnt:=mTypNum;
    ohCSH.DocType:=pDocType;
    ohCSH.DocDate:=mDocDate;
    ohCSH.Notice:=pDesTxt;
    ohCSH.PyCourse:=1;
    ohCSH.PyBegVal:=mPyBegVal;
    ohCSH.AcDvzName:=gKey.SysAccDvz;
    ohCSH.PyDvzName:=gKey.CsbDvName[BokNum];
    ohCSH.WriNum:=gKey.CsbWriNum[BokNum];
    If pDocType='I'
      then ohCSH.DocSpc:=gKey.CsbSpcCsi[BokNum]
      else ohCSH.DocSpc:=gKey.CsbSpcCse[BokNum];
    ohCSH.DstLck:=9;
    If (pPaCode>0) then begin
      mhPAB:=TPabHnd.Create;  mhPAB.Open(0);
      If mhPAB.LocatePaCode(pPaCode) then BTR_To_BTR (mhPAB.BtrTable,ohCSH.BtrTable);
      FreeAndNil (mhPAB);
    end else begin
      mhSYSTEM:=TSystemHnd.Create;  mhSYSTEM.Open;
      ohCSH.PaName  :=mhSYSTEM.MyPaName;
      ohCSH.RegName :=mhSYSTEM.MyPaName;
      ohCSH.RegIno  :=mhSYSTEM.MyPaIno;
      ohCSH.RegTin  :=mhSYSTEM.MyPaTin;
      ohCSH.RegVin  :=mhSYSTEM.MyPaVin;
      ohCSH.RegAddr :=mhSYSTEM.MyPaAddr;
      ohCSH.RegSta  :=mhSYSTEM.MyStaName;
      ohCSH.RegCty  :=mhSYSTEM.MyCtyCode;
      ohCSH.RegCtn  :=mhSYSTEM.MyCtyName;
      ohCSH.RegZip  :=mhSYSTEM.MyZipCode;
      mhSYSTEM.Close;FreeAndNil(mhSYSTEM);
    end;
    ohCSH.Post;
  end;
end;

procedure TCsd.CnfDoc; // potvrdenie dokladu nastavi priznak rezervacie DstLck=9 na 0
begin
  If ohCSH.DstLck=9 then begin
    ohCSH.Edit;
    ohCSH.DstLck:=0;
    ohCSH.Post;
  end;
end;

procedure TCsd.ClcDoc(pDocNum:Str12); // prepocita hlavicku zadaneho dokladu
var mBokNum:Str5;
begin
  mBokNum:=BookNumFromDocNum(pDocNum);
  Open (mBokNum,TRUE,TRUE,FALSE);
  If ohCSH.LocateDocNum(pDocNum) then ohCSH.Clc(ohCSI);
end;

procedure TCsd.AccDoc; // Rozúètuje aktualny doklad doklad
var mDac:TDacF;  mAccSnt:Str3;  mAccAnl:Str6;  mCrdVal,mDebVal:double;  
begin
  If ohCSI.LocateDocNum (ohCSH.DocNum) then begin
    mDac:=TDacF.Create(Self);
    mDac.Show;
    mDac.DocNum:=ohCSH.DocNum;
    mDac.DocDate:=ohCSH.DocDate;
    mDac.WriNum:=ohCSH.WriNum;
    mDac.OcdNum:=ohCSH.OcdNum;
    mDac.PaCode:=ohCSH.PaCode;
    // Zauctujeme pokladnu - 211
    mAccSnt:=gkey.CsbDocSnt[BokNum];  If mAccSnt='' then mAccSnt:='211';
    mAccAnl:=gkey.CsbDocAnl[BokNum];  If mAccAnl='' then mAccAnl:='000100';
    mCrdVal:=0; mDebVal:=0;
    If ohCSH.DocType='I'
      then mCrdVal:=ohCSH.AcBValue
      else mDebVal:=ohCSH.AcBValue;
    mDac.Add(0,mAccSnt,mAccAnl,mCrdVal,mDebVal);
    // Zauctujeme DPH - 343 (nizka sadba)
    mCrdVal:=0; mDebVal:=0;
    If ohCSH.DocType='I' then begin
      mAccSnt:=gkey.CsbVaoSnt[BokNum];
      mAccAnl:=gkey.CsbVaoAnl[BokNum];
      mDebVal:=ohCSH.AcBValue2-ohCSH.AcAValue2;
    end
    else begin
      mAccSnt:=gkey.CsbVaiSnt[BokNum];
      mAccAnl:=gkey.CsbVaiAnl[BokNum];
      mCrdVal:=ohCSH.AcBValue2-ohCSH.AcAValue2;
    end;
    If mAccSnt='' then mAccSnt:='343';
    mAccAnl:=AnlGen(mAccAnl,ohCSI.VatPrc);
    If IsNotNul(mCrdVal) or IsNotNul(mDebVal) then mDac.Add(0,mAccSnt,mAccAnl,mCrdVal,mDebVal);
    // Zauctujeme DPH - 343 (vyssia sadba)
    mCrdVal:=0; mDebVal:=0;
    If ohCSH.DocType='I' then begin
      mAccSnt:=gkey.CsbVaoSnt[BokNum];
      mAccAnl:=gkey.CsbVaoAnl[BokNum];
      mDebVal:=ohCSH.AcBValue3-ohCSH.AcAValue3;
    end
    else begin
      mAccSnt:=gKey.CsbVaiSnt[BokNum];
      mAccAnl:=gKey.CsbVaiAnl[BokNum];
      mCrdVal:=ohCSH.AcBValue3-ohCSH.AcAValue3;
    end;
    If mAccSnt='' then mAccSnt:='343';
    mAccAnl:=AnlGen(mAccAnl,ohCSI.VatPrc);
    If IsNotNul(mCrdVal) or IsNotNul(mDebVal) then mDac.Add(0,mAccSnt,mAccAnl,mCrdVal,mDebVal);
    // Zauctujeme polozky pokladnicneho dokladu
    Repeat
      mDac.WriNum:=ohCSI.WriNum;
      mDac.PaCode:=ohCSI.PaCode;
      If ohCSI.ConExt='DEPOSIT' then begin //Prijat8 z8loha - osobitn0 roz[4tovanie
        If ohCSI.AcBValue>0 then begin
          mDac.Add(0,gKey.Icm.SpvSnt,AccAnlGen(gKey.Icm.SpvAnl,0),0,ohCSI.AcBValue);
          mDac.Add(0,gKey.Icm.SptSnt,AccAnlGen(gKey.Icm.SptAnl,ohCSI.VatPrc),0,(ohCSI.AcBValue-ohCSI.AcAValue)*(-1));
        end else begin
          mDac.Add(0,gKey.Icm.SpvSnt,AccAnlGen(gKey.Icm.SpvAnl,0),ohCSI.AcBValue*(-1),0);
          mDac.Add(0,gKey.Icm.SptSnt,AccAnlGen(gKey.Icm.SptAnl,ohCSI.VatPrc),(ohCSI.AcBValue-ohCSI.AcAValue),0);
        end;
      end else begin // Riadna polozka pokladnicneho dokladu
        mDac.ConDoc:=ohCSI.ConDoc;
        mDac.ExtNum:=ohCSI.ConExt;
        mCrdVal:=0; mDebVal:=0;
        If ohCSH.DocType='I'
          then mDebVal:=ohCSI.AcAValue+ohCSI.AcPdfVal
          else mCrdVal:=ohCSI.AcAValue+ohCSI.AcPdfVal;
        mDac.Add(0,ohCSI.AccSnt,ohCSI.AccAnl,mCrdVal,mDebVal);
        // Rozdiel uhrady
        If IsNotNul(ohCSI.AcPdfVal) then begin
          mCrdVal:=0; mDebVal:=0;
          If ohCSI.AcPdfVal>0
            then mCrdVal:=ohCSI.AcPdfVal        // 548
            else mDebVal:=Abs(ohCSI.AcPdfVal);  // 648
          mDac.Add(0,ohCSI.PdfSnt,ohCSI.PdfAnl,mCrdVal,mDebVal);
        end;
      end;
      Application.ProcessMessages;
      ohCSI.Next;
    until (ohCSI.Eof) or (ohCSI.DocNum<>ohCSH.DocNum);
    mDac.Save;
    // Oznacime hlavicku dokladu
    ohCSH.Edit;
    If mDac.AccErr
      then ohCSH.DstAcc:=''
      else ohCSH.DstAcc:='A';
    ohCSH.Post;
    FreeAndNil(mDac);
  end;
//  SndAccToFile (btJOURNAL,L_DocNum.Text);
end;

procedure TCsd.AccDoc(pDocNum:Str12); // Rozúètuje zadaný doklad
var mBokNum:Str5;
begin
  mBokNum:=BookNumFromDocNum(pDocNum);
  Open (mBokNum,TRUE,TRUE,FALSE);
  If ohCSH.LocateDocNum(pDocNum) then AccDoc; // Rozuctuje zadany doklad
end;

procedure TCsd.TmpRef(pDocNum:Str12;pItmNum:longint); // Obnovy zaznam na zaklade BTR
begin
  If ohCSI.LocateDoIt(pDocNum,pItmNum) then begin
    If otCSI.LocateDoIt(ohCSI.DocNum,ohCSI.ItmNum)
      then otCSI.Edit
      else otCSI.Insert;
    BTR_To_PX (ohCSI.BtrTable,otCSI.TmpTable);
    otCSI.Post;
  end;
end;

procedure TCsd.AddItmAcc(pDocNum: Str12; pCsoNum: word; pPyVatVal,pPyBValue: double;
  pConDoc,pConExt: Str12; pAccSnt: Str3; pAccAnl: Str6; pDesTxt: Str30; pVatPrc: byte);
var mItmNum:word;  mDesTxt:Str30;  mAccSnt:Str3;  mAccAnl:Str6;  mVatPrc:byte;  mVatVal:double;
begin
  If IsNotNul(Abs(pPyVatVal)+Abs(pPyBValue)) then begin
    If ohCSH.LocateDocNum(pDocNum) then begin
      mDesTxt:='';  mAccSnt:='';   mAccAnl:='';
      mItmNum:=ohCSI.NextItmNum(pDocNum);
      If ohCSH.DocType='I' then begin  // Prijmovy pokladnicny doklad
        If not ohCSOINC.Active then ohCSOINC.Open;
        If ohCSOINC.LocateCsoNum(pCsoNum) then begin
          mDesTxt:=ohCSOINC.CsoName;
          mAccSnt:=ohCSOINC.AccSnt;
          mAccAnl:=ohCSOINC.AccAnl;
          mVatPrc:=ohCSOINC.VatPrc;
        end
  //      else ShowMsg (,);  TODO
      end
      else begin // Vydajovy pokladnicny doklad
        If not ohCSOEXP.Active then ohCSOEXP.Open;
        If ohCSOEXP.LocateCsoNum(pCsoNum) then begin
          mDesTxt:=ohCSOEXP.CsoName;
          mAccSnt:=ohCSOEXP.AccSnt;
          mAccAnl:=ohCSOEXP.AccAnl;
          mVatPrc:=ohCSOEXP.VatPrc;
        end
  //      else ShowMsg (,);  TODO
      end;
      If pAccSnt<>'' then mAccSnt:=pAccSnt;
      If pAccAnl<>'' then mAccAnl:=pAccAnl;
      If pDesTxt<>'' then mDesTxt:=pDesTxt;
      mVatPrc:=pVatPrc;
      try BtrBegTrans;
        mVatVal:=pPyVatVal;
        If IsNul(mVatVal) then mVatVal:=pPyBValue-gPlc.ClcAPrice(mVatPrc,pPyBValue);
        ohCSI.Insert;
        ohCSI.DocNum:=pDocNum;
        ohCSI.ItmNum:=mItmNum;
        ohCSI.Describe:=mDesTxt;
        ohCSI.AccSnt:=mAccSnt;
        ohCSI.AccAnl:=mAccAnl;
        ohCSI.VatPrc:=mVatPrc;
        ohCSI.PyBValue:=pPyBValue;
        ohCSI.PyAValue:=pPyBValue-mVatVal;
        ohCSI.AcBValue:=Rd2(ohCSI.PyBValue*ohCSH.PyCourse);
        ohCSI.AcAValue:=Rd2(ohCSI.PyAValue*ohCSH.PyCourse);
        ohCSI.PyCourse:=1;
        ohCSI.FgCourse:=1;
        ohCSI.FgPayVal:=ohCSI.PyBValue;
        ohCSI.AcDvzName:=ohCSH.AcDvzName;
        ohCSI.PyDvzName:=ohCSH.PyDvzName;
        ohCSI.FgDvzName:=ohCSH.PyDvzName;
        ohCSI.DocDate:=ohCSH.DocDate;
        ohCSI.PaCode:=ohCSH.PaCode;
        ohCSI.WriNum:=ohCSH.WriNum;
        ohCSI.ConDoc:=pConDoc;
        ohCSI.ConExt:=pConExt;
        ohCSI.Post;
        If pConDoc<>'' then begin // Uhrada faktur
          oPay.AddPayJrn(ohCSI.DocNum,ohCSI.ItmNum,ohCSI.ConExt,ohCSI.ConDoc,ohCSI.DocDate,ohCSI.PaCode,ohCSI.PyBValue,ohCSI.WriNum,mDesTxt);
        end;
      BtrEndTrans;
      except BtrAbortTrans; end;
    end
    else ShowMsg(eCom.DocIsNoExist,pDocNum);
  end;
end;

procedure TCsd.AddDpi(pDocNum:Str12;pVatPrc:byte;pBvalue:double);
var mItmNum:word;    mAvalue:double;
begin
  If IsNotNul(Abs(pBvalue)) then begin
    If ohCSH.LocateDocNum(pDocNum) then begin
      mItmNum:=ohCSI.NextItmNum(pDocNum);
      mAvalue:=Rd2(pBvalue/(1+pVatPrc/100));
      ohCSI.Insert;
      ohCSI.DocNum:=pDocNum;
      ohCSI.ItmNum:=mItmNum;
      ohCSI.Describe:=SysTxt('DPIDES','Prijatá záloha')+StrInt(pVatPrc,3)+'%';
      ohCSI.VatPrc:=pVatPrc;
      ohCSI.PyBvalue:=pBvalue;
      ohCSI.PyAvalue:=mAvalue;
      ohCSI.AcBValue:=pBvalue;
      ohCSI.AcAValue:=mAvalue;
      ohCSI.PyCourse:=1;
      ohCSI.FgCourse:=1;
      ohCSI.FgPayVal:=pBvalue;
      ohCSI.AcDvzName:=ohCSH.AcDvzName;
      ohCSI.PyDvzName:=ohCSH.PyDvzName;
      ohCSI.FgDvzName:=ohCSH.PyDvzName;
      ohCSI.DocDate:=ohCSH.DocDate;
      ohCSI.PaCode:=ohCSH.PaCode;
      ohCSI.WriNum:=ohCSH.WriNum;
      ohCSI.ConExt:='DEPOSIT';
      ohCSI.Post;
    end;
  end else ; // Nezobrazovat ShowMsg(eCom.DocIsNoExist,pDocNum);
end;

procedure TCsd.AddDpe(pDocNum:Str12;pVatPrc:byte;pBvalue:double); // Pridá položku: Odpoèet zálohovej platby
var mItmNum:word;    mAvalue:double;
begin
  If IsNotNul(Abs(pBvalue)) then begin
    If ohCSH.LocateDocNum(pDocNum) then begin
      mItmNum:=ohCSI.NextItmNum(pDocNum);
      mAvalue:=Rd2(pBvalue/(1+pVatPrc/100));
      ohCSI.Insert;
      ohCSI.DocNum:=pDocNum;
      ohCSI.ItmNum:=mItmNum;
      ohCSI.Describe:=SysTxt('DPEDES','Odpoèet zálohy')+StrInt(pVatPrc,3)+'%';
      ohCSI.VatPrc:=pVatPrc;
      ohCSI.PyBvalue:=pBvalue;
      ohCSI.PyAvalue:=mAvalue;
      ohCSI.AcBValue:=pBvalue;
      ohCSI.AcAValue:=mAvalue;
      ohCSI.PyCourse:=1;
      ohCSI.FgCourse:=1;
      ohCSI.FgPayVal:=pBvalue;
      ohCSI.AcDvzName:=ohCSH.AcDvzName;
      ohCSI.PyDvzName:=ohCSH.PyDvzName;
      ohCSI.FgDvzName:=ohCSH.PyDvzName;
      ohCSI.DocDate:=ohCSH.DocDate;
      ohCSI.PaCode:=ohCSH.PaCode;
      ohCSI.WriNum:=ohCSH.WriNum;
      ohCSI.ConExt:='DEPOSIT';
      ohCSI.Post;
    end;
  end else ; // Nezobrazovat ShowMsg(eCom.DocIsNoExist,pDocNum);
end;

end.


