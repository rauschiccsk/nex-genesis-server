unit Idd;
{$F+}

// *****************************************************************************
//                     INTERNE UCTOVNE DOKLADY
// *****************************************************************************
//
// Programové funkcia:
// ---------------
// *****************************************************************************


interface

uses
  IcTypes, IcConst, IcConv, IcTools, IcVariab, IcValue, DocHand, NumText, NexGlob, NexPath,
  NexIni, NexMsg, NexError, LinLst, Account, Bok, Rep, Key, Afc, Doc, PayFnc,
  hSYSTEM, hPAB, hIDH, hIDI, hIDN, tIDI, tIDH, tNOT, hIDMLST,
  BtrHand, ComCtrls, SysUtils, Classes, Forms;

type
  PDat=^TDat;
  TDat=record
    rhIDH:TIdhHnd;
    rhIDI:TIdiHnd;
    rhIDN:TIdnHnd;
  end;

  TIdd = class(TComponent)
    constructor Create(AOwner: TComponent);
    destructor  Destroy; override;
    private
      oBokNum:Str5;
      oFrmName:Str15;
      oLst:TList;
      procedure Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
    public
      oPay:TPayFnc;
      ohIDH:TIdhHnd;
      ohIDI:TIdiHnd;
      otIDI:TIdiTmp;
      ohIDN:TIdnHnd;
      ohIDMLST:TIdmlstHnd;
      procedure Open(pBokNum:Str5); overload; // Otvori vsetky databazove subory
      procedure Open(pBokNum:Str5;pIDH,pIDI,pIDN:boolean); overload;// Otvori zadane databazove subory
      procedure PrnDoc(pDocNum:Str12); // Vytlaèí zadany dodaci list
      procedure NewDoc(pYear:Str2;pSerNum:word;pPaCode:longint;pDocDate:TDateTime;pDesTxt:Str30;pResDoc:boolean); // Vygeneruje novu hlavicku dokladu
      procedure CnfDoc; // Potvrdenie dokladu nastavi priznak rezervacie DstLck=9 na 0
      procedure ClcDoc(pDocNum:Str12); // prepocita hlavicku zadaneho dokladu
      procedure AccDoc; overload; // Rozúètuje aktualny doklad doklad
      procedure AccDoc(pDocNum:Str12); overload; // Rozúètuje zadaný doklad
      procedure TmpRef(pDocNum:Str12;pItmNum:longint); // Obnovy zaznam na zaklade BTR
      procedure SlcItm(pDocNum:Str12); // Nacita polozky zadaneho dokladu do PX
      procedure AddItm(pDocNum:Str12;pIdmNum:word;pCrdVal,pDebVal:double;pVatPrc:byte;pAValue,pVatVal:double); // Prida novu polozku na zadany doklad
    published
      property BokNum:Str5 read oBokNum;
  end;

implementation

uses bIDMLST;

constructor TIdd.Create(AOwner: TComponent);
begin
  oFrmName := AOwner.Name;
  oPay:=TPayFnc.Create;
  oLst:=TList.Create;  oLst.Clear;
  otIDI:=TIdiTmp.Create;
  ohIDMLST:=TIdmlstHnd.Create;
end;

destructor TIdd.Destroy;
var I:word;
begin
  If oLst.Count>0 then begin
    For I:=1 to oLst.Count do begin
      Activate (I);
      FreeAndNil (ohIDN);
      FreeAndNil (ohIDI);
      FreeAndNil (ohIDH);
    end;
  end;
  FreeAndNil (oPay);
  FreeAndNil (oLst);
  FreeAndNil (otIDI);
  FreeAndNil (ohIDMLST);
end;

// ********************************* PRIVATE ***********************************

procedure TIdd.Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
var mDat:PDat;
begin
  mDat := oLst.Items[pIndex-1];
  ohIDH := mDat.rhIDH;
  ohIDI := mDat.rhIDI;
  ohIDN := mDat.rhIDN;
end;

// ********************************** PUBLIC ***********************************

procedure TIdd.Open(pBokNum:Str5); // Otvori vsetky databazove subory
begin
  Open (pBokNum,TRUE,TRUE,TRUE);
end;

procedure TIdd.Open(pBokNum:Str5;pIDH,pIDI,pIDN:boolean); // Otvori zadane databazove subory
var mFind:boolean;  mCnt:word;  mDat:PDat;
begin
  oBokNum := pBokNum;
  mFind := FALSE;
  If oLst.Count>0 then begin
    mCnt := 0;
    Repeat
      Inc (mCnt);
      Activate(mCnt);
      mFind := ohIDH.BtrTable.BookNum=pBokNum;
    until mFind or (mCnt=oLst.Count);
  end;
  If not mFind then begin // Ak dana kniha este nie je otvorena potomotvorime
    // Vytvorime objekty
    ohIDH := TIdhHnd.Create;
    ohIDI := TIdiHnd.Create;
    ohIDN := TIdnHnd.Create;
    // Otvorime databazove subory
    If pIDH then ohIDH.Open(pBokNum);
    If pIDI then ohIDI.Open(pBokNum);
    If pIDN then ohIDN.Open(pBokNum);
    // Ulozime objekty do zoznamu
    GetMem (mDat,SizeOf(TDat));
    mDat^.rhIDH := ohIDH;
    mDat^.rhIDI := ohIDI;
    mDat^.rhIDN := ohIDN;
    oLst.Add(mDat);
  end;
end;

procedure TIdd.SlcItm(pDocNum:Str12); // nacita polozky zadaneho dokladu do PX
begin
  If otIDI.Active then otIDI.Close;
  otIDI.Open;
  If ohIDI.LocateDocNum(pDocNum) then begin
    Repeat
      otIDI.Insert;
      BTR_To_PX (ohIDI.BtrTable,otIDI.TmpTable);
      otIDI.Post;
      Application.ProcessMessages;
      ohIDI.Next;
    until ohIDI.Eof or (ohIDI.DocNum<>pDocNum);
  end;
end;

procedure TIdd.AddItm(pDocNum:Str12;pIdmNum:word;pCrdVal,pDebVal:double;pVatPrc:byte;pAValue,pVatVal:double); // Prida novu polozku na zadany doklad
var mItmNum:word;  mDesTxt:Str30;  mAccSnt:Str3;  mAccAnl:Str6;
begin
  If IsNotNul(pCrdVal) or IsNotNul(pDebVal) then begin
    If ohIDH.LocateDocNum(pDocNum) then begin
      mDesTxt := '';  mAccSnt := '';   mAccAnl := '';
      mItmNum := NextItmNum(ohIDI.BtrTable,pDocNum);
      If not ohIDMLST.Active then ohIDMLST.Open;
      If ohIDMLST.LocateIdmNum(pIdmNum) then begin
        mDesTxt := ohIDMLST.IdmName;
        mAccSnt := ohIDMLST.AccSnt;
        mAccAnl := ohIDMLST.AccAnl;
      end;
      try
        BtrBegTrans;
        ohIDI.Insert;
        ohIDI.DocNum := pDocNum;
        ohIDI.ItmNum := mItmNum;
        ohIDI.Describe := mDesTxt;
        ohIDI.AccSnt := mAccSnt;
        ohIDI.AccAnl := mAccAnl;
        ohIDI.CredVal := pCrdVal;
        ohIDI.DebVal := pDebVal;
        ohIDI.DocType := ohIDH.DocType;
        ohIDI.DocDate := ohIDH.DocDate;
        ohIDI.PaCode := ohIDH.PaCode;
        ohIDI.WriNum := ohIDH.WriNum;
        If pVatPrc>0 then begin
          ohIDI.VatPrc := pVatPrc;
          ohIDI.AcAValue := pAValue;
          ohIDI.AcVatVal := pVatVal;
          ohIDI.AcBValue := pAValue+pVatVal;
        end;
        ohIDI.Post;
        BtrEndTrans;
      except BtrAbortTrans; end;
    end
    else ShowMsg(eCom.DocIsNoExist,pDocNum);
  end;
end;

procedure TIdd.PrnDoc(pDocNum:Str12); // Vytlaèí zadany dodaci list
var mBokNum:Str5;  mRep:TRep;  mhSYSTEM:TSystemHnd;  mtIDH:TIdhTmp;  mtNOT:TNotTmp;  mInfVal:double;
begin
(*
  mBokNum := BookNumFromDocNum(pDocNum);
  gAfc.GrpNum := gvSys.LoginGroup;
  gAfc.BookNum := mBokNum;
  If gAfc.AmbDocPrn then begin
    Open (mBokNum,TRUE,TRUE,TRUE);
    If ohIDH.LocateDocNum(pDocNum) then begin
      mhSYSTEM := TSystemHnd.Create;  mhSYSTEM.Open;
      mtIDH := TIdhTmp.Create;   mtIDH.Open;
      mtIDH.Insert;
      BTR_To_PX (ohIDH.BtrTable,mtIDH.TmpTable);
      mtIDH.PyVatVal1 := ohIDH.PyBValue1-ohIDH.PyAValue1;
      mtIDH.PyVatVal2 := ohIDH.PyBValue2-ohIDH.PyAValue2;
      mtIDH.PyVatVal3 := ohIDH.PyBValue3-ohIDH.PyAValue3;
      mtIDH.TxtVal := ConvNumToText(mtIDH.PyBValue);
      If gKey.SysFixCrs>0 then begin
        If gKey.SysInfDvz='EUR'
          then mInfVal := ohIDH.PyBValue/gKey.SysFixCrs
          else mInfVal := ohIDH.PyBValue*gKey.SysFixCrs;
        mtIDH.PyDuoInf := 'Konverzný kurz: '+StrDoub(gKey.SysFixCrs,2,4)+'    Hodnota dokladu: '+StrDoub(mInfVal,0,2)+' '+gKey.SysInfDvz;
      end;
      mtIDH.Post;
      mtNOT := TNotTmp.Create;  mtNOT.Open;
      Notice (ohIDN.BtrTable,mtNOT.TmpTable,pDocNum,'N'); // Nacita poznamky do docasneho suboru pre tlac
      SlcItm(pDocNum);
      // --------------------------
      mRep := TRep.Create(Self);
      mRep.SysBtr := mhSYSTEM.BtrTable;
      mRep.HedTmp := mtIDH.TmpTable;
      mRep.ItmTmp := otCSI.TmpTable;
      mRep.SpcTmp := mtNOT.TmpTable;
      If copy(pDocNum,1,2)='PP'
        then mRep.Execute('CSDI')
        else mRep.Execute('CSDE');
      FreeAndNil (mRep);
      // --------------------------
      FreeAndNil (mtNOT);
      FreeAndNil (mtIDH);
      FreeAndNil (mhSYSTEM);
    end;
  end
  else ShowMsg(eCom.ThisFncIsDis,'');
*)
end;

procedure TIdd.NewDoc(pYear:Str2;pSerNum:word;pPaCode:longint;pDocDate:TDateTime;pDesTxt:Str30;pResDoc:boolean); // Vygeneruje novu hlavicku dokladu
var mSerNum:word;  mDocNum:Str12;  mDocDate:TDateTime;  mhPAB:TPabHnd;  mPyBegVal:double;
begin
  If pYear='' then pYear:=gvSys.ActYear2;
  mSerNum := pSerNum;
  mDocDate := pDocDate;
  If mSerNum=0 then mSerNum := GetDocNextYearSerNum(ohIDH.BtrTable,pYear); // Ak nie je zadane poradove cislo OD vygenerujeme nasledujuce
  If mDocDate=0 then mDocDate := Date; // Ak nie je zadany datum nastavime aktualny den
  mDocNum := ohIDH.GenDocNum(pYear,mSerNum);
  If not ohIDH.LocateDocNum(mDocNum) then begin // Ak neexistuje vyvorime hlacicku dokladu OD
    ohIDH.Insert;
    ohIDH.DocNum := mDocNum;
    ohIDH.SerNum := mSerNum;
    ohIDH.DocDate := mDocDate;
    ohIDH.Describe := pDesTxt;
//    ohIDH.WriNum := gKey.CsbWriNum[BokNum];
//    ohIDH.DocSpc := gKey.CsbDocSpc[BokNum];
    If pResDoc
      then ohIDH.DstLck := 9
      else ohIDH.DstLck := 0;
    If (pPaCode>0) then begin
      mhPAB := TPabHnd.Create;  mhPAB.Open(0);
      If mhPAB.LocatePaCode(pPaCode) then BTR_To_BTR (mhPAB.BtrTable,ohIDH.BtrTable);
      FreeAndNil (mhPAB);
    end;
    ohIDH.Post;
  end;
end;

procedure TIdd.CnfDoc; // potvrdenie dokladu nastavi priznak rezervacie DstLck=9 na 0
begin
  If ohIDH.DstLck=9 then begin
    ohIDH.Edit;
    ohIDH.DstLck := 0;
    ohIDH.Post;
  end;
end;

procedure TIdd.ClcDoc(pDocNum:Str12); // prepocita hlavicku zadaneho dokladu
var mBokNum:Str5;  mItmQnt:longint;   mCrdVal,mDebVal:double;  I:byte;
    mCAccSnt,mDAccSnt:Str3;  mCAccAnl,mDAccAnl:Str6; mAcAValue,mAcVatVal:TValue8;
begin
  mBokNum := BookNumFromDocNum(pDocNum);
  Open (mBokNum,TRUE,TRUE,FALSE);
  If ohIDH.LocateDocNum(pDocNum) then begin
    mCAccSnt := ''; mCAccAnl := '';  mDAccSnt := '';  mDAccAnl := '';
    mItmQnt := 0;  mCrdVal := 0;  mDebVal := 0;
    If (ohIDH.VatPrc1=0) and (ohIDH.VatPrc2=0) and (ohIDH.VatPrc3=0) and (ohIDH.VatPrc4=0) and (ohIDH.VatPrc5=0) then begin
      ohIDH.Edit;
      ohIDH.VatPrc1 := gIni.GetVatPrc(1);
      ohIDH.VatPrc2 := gIni.GetVatPrc(2);
      ohIDH.VatPrc3 := gIni.GetVatPrc(3);
      ohIDH.VatPrc4 := gIni.GetVatPrc(4);
      ohIDH.VatPrc5 := gIni.GetVatPrc(5);
      ohIDH.Post;
    end;
    mAcAValue := TValue8.Create;  mAcAValue.Clear;
    mAcVatVal := TValue8.Create;  mAcVatVal.Clear;
    For I:=1 to 5 do begin
      mAcAValue.VatPrc[I] := ohIDH.VatPrc[I];
      mAcVatVal.VatPrc[I] := ohIDH.VatPrc[I];
    end;
    ohIDI.SwapIndex;
    If ohIDI.LocateDocNum(ohIDH.DocNum) then begin
      Repeat
        Inc (mItmQnt);
        If ohIDH.VtcSpc>0 then begin
          mAcAValue.Add (ohIDI.VatPrc,ohIDI.AcAValue);
          mAcVatVal.Add (ohIDI.VatPrc,ohIDI.AcVatVal);
        end;
        mCrdVal := mCrdVal+ohIDI.CredVal;
        mDebVal := mDebVal+ohIDI.DebVal;
        If IsNotNul (mCrdVal) then begin
          mCAccSnt := ohIDI.AccSnt;
          mCAccAnl := ohIDI.AccAnl;
        end
        else begin
          mDAccSnt := ohIDI.AccSnt;
          mDAccAnl := ohIDI.AccAnl;
        end;
        ohIDI.Next;
      until (ohIDI.Eof) or (ohIDI.DocNum<>ohIDH.DocNum);
    end;
    ohIDI.RestoreIndex;
    // Ulozime vypocitane hodnoty do hlavicky
    ohIDH.Edit;
    ohIDH.AcAValue := mAcAValue.Value[0];
    ohIDH.AcVatVal := mAcVatVal.Value[0];
    ohIDH.AcAValue1 := mAcAValue.Value[1];
    ohIDH.AcVatVal1 := mAcVatVal.Value[1];
    ohIDH.AcAValue2 := mAcAValue.Value[2];
    ohIDH.AcVatVal2 := mAcVatVal.Value[2];
    ohIDH.AcAValue3 := mAcAValue.Value[3];
    ohIDH.AcVatVal3 := mAcVatVal.Value[3];
    ohIDH.AcAValue4 := mAcAValue.Value[4];
    ohIDH.AcVatVal4 := mAcVatVal.Value[4];
    ohIDH.AcAValue5 := mAcAValue.Value[5];
    ohIDH.AcVatVal5 := mAcVatVal.Value[5];

    ohIDH.CredVal := mCrdVal;
    ohIDH.DebVal := mDebVal;
    ohIDH.ItmQnt := mItmQnt;
    ohIDH.CAccSnt := mCAccSnt;
    ohIDH.CAccAnl := mCAccAnl;
    ohIDH.DAccSnt := mCAccSnt;
    ohIDH.DAccAnl := mCAccAnl;
    ohIDH.DstAcc := GetDstAcc(ohIDH.DocNum);
    If not Eq2(mCrdVal,mDebVal)
      then ohIDH.DstDif := '!'
      else ohIDH.DstDif := '';
    ohIDH.Post;
  end;
end;

procedure TIdd.AccDoc; // Rozúètuje aktualny doklad doklad
begin
  DocAccount (ohIDH.BtrTable,FALSE,Self); // Rozuctuje zadany doklad
end;

procedure TIdd.AccDoc(pDocNum:Str12); // Rozúètuje zadaný doklad
var mBokNum:Str5;
begin
  mBokNum := BookNumFromDocNum(pDocNum);
  Open (mBokNum,TRUE,TRUE,FALSE);
  If ohIDH.LocateDocNum(pDocNum) then DocAccount (ohIDH.BtrTable,FALSE,Self); // Rozuctuje zadany doklad
end;

procedure TIdd.TmpRef(pDocNum:Str12;pItmNum:longint); // Obnovy zaznam na zaklade BTR
begin
  If ohIDI.LocateDoIt(pDocNum,pItmNum) then begin
    If otIDI.LocateDoIt(ohIDI.DocNum,ohIDI.ItmNum)
      then otIDI.Edit
      else otIDI.Insert;
    BTR_To_PX (ohIDI.BtrTable,otIDI.TmpTable);
    otIDI.Post;
  end;
end;

end.


