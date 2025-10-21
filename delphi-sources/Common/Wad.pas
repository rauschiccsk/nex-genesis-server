unit Wad;
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
  IcTypes, IcConst, IcConv, IcTools, IcVariab, DocHand,
  NexGlob, NexPath, NexIni, NexMsg, NexError, ItgLog,
  SavClc, LinLst, Bok, Rep, Key, Afc, Doc,
  hSYSTEM, hWAH, hWAE, hWAI, tWAI, tWAE,
  ComCtrls, SysUtils, Classes, Forms;

type
  PDat=^TDat;
  TDat=record
    rhWAH:TWahHnd;
    rhWAE:TWaeHnd;
    rhWAI:TWaiHnd;
  end;

  TWad = class(TComponent)
    constructor Create(AOwner: TComponent);
    destructor  Destroy; override;
    private
      oBokNum:Str5;
      oFrmName:Str15;
      oLst:TList;
      procedure Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
    public
      ohWAH:TWahHnd;
      ohWAE:TWaeHnd;
      ohWAI:TWaiHnd;
      otWAE:TWaeTmp;
      otWAI:TWaiTmp;
      procedure Open(pBokNum:Str5); overload; // Otvori vsetky databazove subory
      procedure Open(pBokNum:Str5;pWAH,pWAE,pWAI:boolean); overload;// Otvori zadane databazove subory
      procedure PrnDoc(pDocNum,pRepName:Str12); // Vytlaèí zadany doklad
      procedure NewDoc(pyear:Str2;pSerNum:word;pBegDate,pEndDate:TDateTime); // Vygeneruje novu hlavicku dokladu
      procedure ClcDoc; overload;// Prepocita hlavicku aktualneho dokladu
      procedure ClcDoc(pDocNum:Str12); overload;// prepocita hlavicku zadaneho dokladu
      procedure TmpRef(pDocNum:Str12;pItmNum:longint); // Obnovy zaznam na zaklade BTR
      procedure SlcWae; overload; // Nacita zoznam zamestnancov aktualneho dokladu
      procedure SlcWae(pDocNum:Str12); overload; // Nacita zoznam zamestnancov zadaneho dokladu
      procedure SlcItm(pDocNum:Str12;pEpcNum:word); // Nacita polozky zadaneho dokladu do PX
    published
      property BokNum:Str5 read oBokNum;
  end;

implementation

uses bWAI, bWAE;

constructor TWad.Create(AOwner: TComponent);
begin
  oFrmName := AOwner.Name;
  oLst := TList.Create;  oLst.Clear;
  otWAE := TWaeTmp.Create;
  otWAI := TWaiTmp.Create;
end;

destructor TWad.Destroy;
var I:word;
begin
  If oLst.Count>0 then begin
    For I:=1 to oLst.Count do begin
      Activate (I);
      FreeAndNil (ohWAI);
      FreeAndNil (ohWAE);
      FreeAndNil (ohWAH);
    end;
  end;
  FreeAndNil (oLst);
  FreeAndNil (otWAI);
  FreeAndNil (otWAE);
end;

// ********************************* PRIVATE ***********************************

procedure TWad.Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
var mDat:PDat;
begin
  mDat := oLst.Items[pIndex-1];
  ohWAH := mDat.rhWAH;
  ohWAE := mDat.rhWAE;
  ohWAI := mDat.rhWAI;
end;

// ********************************** PUBLIC ***********************************

procedure TWad.Open(pBokNum:Str5); // Otvori vsetky databazove subory
begin
  Open (pBokNum,TRUE,TRUE,TRUE);
end;

procedure TWad.Open(pBokNum:Str5;pWAH,pWAE,pWAI:boolean); // Otvori zadane databazove subory
var mFind:boolean;  mCnt:word;  mDat:PDat;
begin
  oBokNum := pBokNum;
  mFind := FALSE;
  If oLst.Count>0 then begin
    mCnt := 0;
    Repeat
      Inc (mCnt);
      Activate(mCnt);
      mFind := ohWAH.BtrTable.BookNum=pBokNum;
    until mFind or (mCnt=oLst.Count);
  end;
  If not mFind then begin // Ak dana kniha este nie je otvorena potomotvorime
    // Vytvorime objekty
    ohWAH := TWahHnd.Create;
    ohWAE := TWaeHnd.Create;
    ohWAI := TWaiHnd.Create;
    // Otvorime databazove subory
    If pWAH then ohWAH.Open(pBokNum);
    If pWAE then ohWAE.Open(pBokNum);
    If pWAI then ohWAI.Open(pBokNum);
    // Ulozime objekty do zoznamu
    GetMem (mDat,SizeOf(TDat));
    mDat^.rhWAH := ohWAH;
    mDat^.rhWAE := ohWAE;
    mDat^.rhWAI := ohWAI;
    oLst.Add(mDat);
  end;
end;

procedure TWad.SlcItm(pDocNum:Str12;pEpcNum:word); // nacita polozky zadaneho dokladu do PX
var mItmNum:word;
begin
  If otWAI.Active then otWAI.Close;
  otWAI.Open;
  If ohWAI.LocateDoEc(pDocNum,pEpcNum) then begin
    mItmNum := 0;
    Repeat
      Inc(mItmNum);
      otWAI.Insert;
      BTR_To_PX (ohWAI.BtrTable,otWAI.TmpTable);
      otWAI.ItmNum := mItmNum;
      otWAI.Post;
      Application.ProcessMessages;
      ohWAI.Next;
    until ohWAI.Eof or (ohWAI.DocNum<>pDocNum) or (ohWAI.EpcNum<>pEpcNum);
  end;
end;

procedure TWad.SlcWae; // Nacita zoznam zamestnancov aktualneho dokladu
var mItmNum:word;
begin
  If otWAE.Active then otWAE.Close;
  otWAE.Open;
  If ohWAE.LocateDocNum(ohWAH.DocNum) then begin
    mItmNum := 0;
    Repeat
      Inc(mItmNum);
      otWAE.Insert;
      otWAE.ItmNum := mItmNum;
      BTR_To_PX (ohWAE.BtrTable,otWAE.TmpTable);
      otWAE.Post;
      Application.ProcessMessages;
      ohWAE.Next;
    until ohWAE.Eof or (ohWAE.DocNum<>ohWAH.DocNum);
  end;
end;

procedure TWad.SlcWae(pDocNum:Str12); // Nacita zoznam zamestnancov zadaneho dokladu
begin
  If ohWAH.LocateDocNum(pDocNum) then SlcWae;
end;

procedure TWad.PrnDoc(pDocNum,pRepName:Str12); // Vytlaèí zadany doklad
var mBokNum:Str5;  mRep:TRep;  mtWAI:TWaiTmp;  mhSYSTEM:TSystemHnd;
begin
  mBokNum := BookNumFromDocNum(pDocNum);
  gAfc.GrpNum := gvSys.LoginGroup;
  gAfc.BookNum := mBokNum;
  If gAfc.Scb.DocPrn then begin
    Open (mBokNum,TRUE,TRUE,TRUE);
    If ohWAH.LocateDocNum(pDocNum) then begin
      mhSYSTEM := TSystemHnd.Create;  mhSYSTEM.Open;
      mtWAI := TWaiTmp.Create;  mtWAI.Open;
      If ohWAI.LocateDocNum(pDocNum) then begin
        Repeat
          mtWAI.Insert;
          BTR_To_PX (ohWAI.BtrTable,mtWAI.TmpTable);
          mtWAI.Post;
          ohWAI.Next;
        until ohWAI.Eof or (ohWAI.DocNum<>pDocNum);
      end;
      // --------------------------
      mRep := TRep.Create(Self);
      mRep.SysBtr := mhSYSTEM.BtrTable;
      mRep.HedBtr := ohWAH.BtrTable;
      mRep.ItmTmp := otWAI.TmpTable;
      mRep.Execute(pRepName);
      If mRep.Printed then begin
//        ohWAH.Edit;
//        ohWAH.PrnCnt := ohWAH.PrnCnt+1;
//        ohWAH.Post;
      end;
      FreeAndNil (mRep);
      // --------------------------
      FreeAndNil (mtWAI);
      FreeAndNil (mhSYSTEM);
    end;
  end
  else ShowMsg(eCom.ThisFncIsDis,'');
end;

procedure TWad.NewDoc(pyear:Str2;pSerNum:word;pBegDate,pEndDate:TDateTime); // Vygeneruje novu hlavicku dokladu
var mSerNum:word;  mDocNum:Str12;
begin
  If pYear='' then pYear:=gvsys.ActYear2;
  mSerNum := pSerNum;
  If mSerNum=0 then mSerNum := NextSerNum(pYear,ohWAH.BtrTable); // Ak nie je zadane poradove cislo OD vygenerujeme nasledujuce
  mDocNum := ohWAH.GenDocNum(pyear,mSerNum);
  If not ohWAH.LocateDocNum(mDocNum) then begin // Ak neexistuje vyvorime hlacicku dokladu OD
    ohWAH.Insert;
    ohWAH.DocNum  := mDocNum;
    ohWAH.SerNum  := mSerNum;
    ohWAH.Year    := pyear;
    ohWAH.BegDate := pBegDate;
    ohWAH.EndDate := pEndDate;
    ohWAH.Post;
  end;
end;

procedure TWad.ClcDoc; // prepocita hlavicku zadaneho dokladu
var mBasSum,mTrnSum,mPrmSum,mAddSum,mPenSum,mTrnVal,mPrmVal,mAddVal,mPenVal:double;
begin
  mTrnSum := 0;  mPrmSum := 0;  mAddSum := 0;  mPenSum := 0;
  If ohWAE.LocateDocNum(ohWAH.DocNum) then begin
    Repeat
      mTrnVal := 0;  mPrmVal := 0;  mAddVal := 0;  mPenVal := 0;
      If ohWAI.LocateDoEc(ohWAE.DocNum,ohWAE.EpcNum) then begin
        Repeat
          mTrnVal := mTrnVal+ohWAI.TrnVal;
          mPrmVal := mPrmVal+ohWAI.PrmVal;
          mAddVal := mAddVal+ohWAI.AddVal;
          mPenVal := mPenVal+ohWAI.PenVal;
          Application.ProcessMessages;
          ohWAI.Next;
        until ohWAI.Eof or (ohWAI.DocNum<>ohWAE.DocNum) or (ohWAI.EpcNum<>ohWAE.EpcNum);
      end;
      // Kumulativne hodnoty podla zamestnancov
      ohWAE.Edit;
      ohWAE.TrnVal := mTrnVal;
      ohWAE.PrmVal := mPrmVal;
      ohWAE.AddVal := mAddVal;
      ohWAE.PenVal := mPenVal;
      ohWAE.Post;
      mBasSum := mBasSum+ohWAE.BasVal;
      mTrnSum := mTrnSum+mTrnVal;
      mPrmSum := mPrmSum+mPrmVal;
      mAddSum := mAddSum+mAddVal;
      mPenSum := mPenSum+mPenVal;
      Application.ProcessMessages;
      ohWAE.Next;
    until ohWAE.Eof or (ohWAE.DocNum<>ohWAH.DocNum);
  end;
  // Kumulativna hodnota dokladu
  ohWAH.Edit;
  ohWAH.BasVal := mBasSum;
  ohWAH.TrnVal := mTrnSum;
  ohWAH.PrmVal := mPrmSum;
  ohWAH.AddVal := mAddSum;
  ohWAH.PenVal := mPenSum;
  ohWAH.Post
end;

procedure TWad.ClcDoc(pDocNum:Str12); // prepocita hlavicku zadaneho dokladu
var mBokNum:Str5;
begin
  mBokNum := BookNumFromDocNum(pDocNum);
  Open (mBokNum,TRUE,TRUE,TRUE);
  If ohWAH.LocateDocNum(pDocNum) then ClcDoc;
end;

procedure TWad.TmpRef(pDocNum:Str12;pItmNum:longint); // Obnovy zaznam na zaklade BTR
begin
(*
  If ohWAI.LocateDoIt(pDocNum,pItmNum) then begin
    If otWAI.LocateDoIt(ohWAI.DocNum,ohWAI.ItmNum)
      then otWAI.Edit
      else otWAI.Insert;
    BTR_To_PX (ohWAI.BtrTable,otWAI.TmpTable);
    otWAI.Post;
  end;
*)  
end;

end.


