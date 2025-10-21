unit Pqd;
{$F+}

// *****************************************************************************
//                              PREVODNE PRIKAZY
// *****************************************************************************
// Programové funkcia:
// ---------------
// *****************************************************************************


interface

uses
  IcTypes, IcConst, IcConv, IcTools, IcVariab, DocHand,
  NexGlob, NexPath, NexIni, NexMsg, NexError,
  Bok, Rep, Key, Afc, Doc,
  hSYSTEM, hPQH, hPQI, tPQI, tPQH,
  BtrHand, ComCtrls, SysUtils, Classes, Forms;

type
  PDat=^TDat;
  TDat=record
    rhPQH:TPqhHnd;
    rhPQI:TPqiHnd;
  end;

  TPqd = class(TComponent)
    constructor Create(AOwner: TComponent);
    destructor  Destroy; override;
    private
      oBokNum:Str5;
      oFrmName:Str15;
      oLst:TList;
      procedure Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
    public
      ohPQH:TPqhHnd;
      ohPQI:TPqiHnd;
      otPQI:TPqiTmp;
      procedure Open(pBokNum:Str5); overload; // Otvori vsetky databazove subory
      procedure Open(pBokNum:Str5;pPQH,pPQI:boolean); overload;// Otvori zadane databazove subory
      procedure NewDoc(pSerNum:word;pPaCode:longint;pDocDate:TDateTime;pDesTxt:Str30;pDocType:Str1); // Vygeneruje novu hlavicku dokladu
      procedure ClcDoc(pDocNum:Str12); // prepocita hlavicku zadaneho dokladu
      procedure TmpRef(pDocNum:Str12;pItmNum:longint); // Obnovy zaznam na zaklade BTR
      procedure SlcItm(pDocNum:Str12); // Nacita polozky zadaneho dokladu do PX
    published
      property BokNum:Str5 read oBokNum;
  end;

implementation

constructor TPqd.Create(AOwner: TComponent);
begin
  oFrmName := AOwner.Name;
  oLst := TList.Create;  oLst.Clear;
  otPQI := TPqiTmp.Create;
end;

destructor TPqd.Destroy;
var I:word;
begin
  If oLst.Count>0 then begin
    For I:=1 to oLst.Count do begin
      Activate (I);
      FreeAndNil (ohPQI);
      FreeAndNil (ohPQH);
    end;
  end;
  FreeAndNil (oLst);
  FreeAndNil (otPQI);
end;

// ********************************* PRIVATE ***********************************

procedure TPqd.Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
var mDat:PDat;
begin
  mDat := oLst.Items[pIndex-1];
  ohPQH := mDat.rhPQH;
  ohPQI := mDat.rhPQI;
end;

// ********************************** PUBLIC ***********************************

procedure TPqd.Open(pBokNum:Str5); // Otvori vsetky databazove subory
begin
  Open (pBokNum,TRUE,TRUE);
end;

procedure TPqd.Open(pBokNum:Str5;pPQH,pPQI:boolean); // Otvori zadane databazove subory
var mFind:boolean;  mCnt:word;  mDat:PDat;
begin
  oBokNum := pBokNum;
  mFind := FALSE;
  If oLst.Count>0 then begin
    mCnt := 0;
    Repeat
      Inc (mCnt);
      Activate(mCnt);
      mFind := ohPQH.BtrTable.BookNum=pBokNum;
    until mFind or (mCnt=oLst.Count);
  end;
  If not mFind then begin // Ak dana kniha este nie je otvorena potomotvorime
    // Vytvorime objekty
    ohPQH := TPqhHnd.Create;
    ohPQI := TPqiHnd.Create;
    // Otvorime databazove subory
    If pPQH then ohPQH.Open(pBokNum);
    If pPQI then ohPQI.Open(pBokNum);
    // Ulozime objekty do zoznamu
    GetMem (mDat,SizeOf(TDat));
    mDat^.rhPQH := ohPQH;
    mDat^.rhPQI := ohPQI;
    oLst.Add(mDat);
  end;
end;

procedure TPqd.SlcItm(pDocNum:Str12); // nacita polozky zadaneho dokladu do PX
begin
  If otPQI.Active then otPQI.Close;
  otPQI.Open;
  If ohPQI.LocateDocNum(pDocNum) then begin
    Repeat
      otPQI.Insert;
      BTR_To_PX (ohPQI.BtrTable,otPQI.TmpTable);
      otPQI.Post;
      Application.ProcessMessages;
      ohPQI.Next;
    until ohPQI.Eof or (ohPQI.DocNum<>pDocNum);
  end;
end;

procedure TPqd.NewDoc(pSerNum:word;pPaCode:longint;pDocDate:TDateTime;pDesTxt:Str30;pDocType:Str1); // Vygeneruje novu hlavicku dokladu
//var mSerNum,mTypNum:word;  mDocNum:Str12;  mDocDate:TDateTime;  mhPAB:TPabHnd;  mPyBegVal:double;
begin
(*
  mSerNum := pSerNum;
  mDocDate := pDocDate;
  If mSerNum=0 then begin
    mSerNum := ohCSH.NextSerNum; // Ak nie je zadane poradove cislo OD vygenerujeme nasledujuce
  end;
  mTypNum := ohCSH.NextTypNum(pDocType); // Najde nasledujuce volne typove cislo dokladu
  mPyBegVal := ohCSH.GetBegVal;  // Urci pociatocny stav pred novym dokladom
  If mDocDate=0 then mDocDate := Date; // Ak nie je zadany datum nastavime aktualny den
  mDocNum := ohCSH.GenDocNum(mSerNum,pDocType);
  If not ohCSH.LocateDocNum(mDocNum) then begin // Ak neexistuje vyvorime hlacicku dokladu OD
    ohCSH.Insert;
    ohCSH.DocNum := mDocNum;
    ohCSH.SerNum := mSerNum;
    ohCSH.DocCnt := mTypNum;
    ohCSH.DocType := pDocType;
    ohCSH.DocDate := mDocDate;
    ohCSH.Notice := pDesTxt;
    ohCSH.PyCourse := 1;
    ohCSH.PyBegVal := mPyBegVal;
    ohCSH.AcDvzName := gKey.SysAccDvz;
    ohCSH.PyDvzName := gKey.CsbDvName[BokNum];
    ohCSH.WriNum := gKey.CsbWriNum[BokNum];
    ohCSH.DocSpc := gKey.CsbDocSpc[BokNum];
    ohCSH.DstLck := 9;
    If (pPaCode>0) then begin
      mhPAB := TPabHnd.Create;  mhPAB.Open(0);
      If mhPAB.LocatePaCode(pPaCode) then BTR_To_BTR (mhPAB.BtrTable,ohCSH.BtrTable);
      FreeAndNil (mhPAB);
    end;
    ohCSH.Post;
  end;
*)
end;

procedure TPqd.ClcDoc(pDocNum:Str12); // prepocita hlavicku zadaneho dokladu
var mBokNum:Str5;
begin
  mBokNum := BookNumFromDocNum(pDocNum);
end;

procedure TPqd.TmpRef(pDocNum:Str12;pItmNum:longint); // Obnovy zaznam na zaklade BTR
begin
  If ohPQI.LocateDoIt(pDocNum,pItmNum) then begin
    If otPQI.LocateDoIt(ohPQI.DocNum,ohPQI.ItmNum)
      then otPQI.Edit
      else otPQI.Insert;
    BTR_To_PX (ohPQI.BtrTable,otPQI.TmpTable);
    otPQI.Post;
  end;
end;

end.


