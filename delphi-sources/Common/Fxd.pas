unit Fxd;
{$F+}

// *****************************************************************************
//                     OBJEKT NA PRACU S INVESTICNYM MAJETKOM
// *****************************************************************************

interface

uses
  IcTypes, IcConst, IcConv, IcTools, IcVariab, DocHand, NexGlob, NexPath, NexIni, NexMsg, NexError,
  Bok, Rep, Key, hSYSTEM, hFXA, hFXT, hFXL, tFXT, tFXL, tDHEAD,
  ComCtrls, SysUtils, Classes, Forms;

type
  PDat=^TDat;
  TDat=record
    rhFXA:TFxaHnd;
    rhFXT:TFxtHnd;
    rhFXL:TFxlHnd;
  end;

  TFxd = class(TComponent)
    constructor Create(AOwner: TComponent);
    destructor  Destroy; override;
    private
      oFrmName:Str15;
      oBokNum:Str5;
      oLst:TList;
      procedure Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
    public
      ohFXA:TFxaHnd;
      ohFXT:TFxtHnd;
      ohFXL:TFxlHnd;
      otFXT:TFxtTmp;
      otFXL:TFxlTmp;
      function ActBok:Str5;
      procedure Open(pBokNum:Str5); overload; // Otvori vsetky databazove subory
      procedure Open(pBokNum:Str5;pFXA,pFXT,pFXL:boolean); overload;// Otvori zadane databazove subory

      procedure SlcFxt(pDocNum:Str12); // Nacita danove opisy zo zadaneho dokladu
      procedure SlcFxl(pDocNum:Str12); // Nacita uctovne opisy zo zadaneho dokladu
    published
      property BokNum:Str5 read oBokNum;
  end;

implementation

constructor TFxd.Create(AOwner: TComponent);
begin
  oFrmName := AOwner.Name;
  oLst := TList.Create;  oLst.Clear;
  otFXT := TFxtTmp.Create;
  otFXL := TFxlTmp.Create;
end;

destructor TFxd.Destroy;
var I:word;
begin
  If oLst.Count>0 then begin
    For I:=1 to oLst.Count do begin
      Activate (I);
      FreeAndNil (ohFXL);
      FreeAndNil (ohFXT);
      FreeAndNil (ohFXA);
    end;
  end;
  FreeAndNil (oLst);
  FreeAndNil (otFXL);
  FreeAndNil (otFXT);
end;

// ********************************* PRIVATE ***********************************

procedure TFxd.Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
var mDat:PDat;
begin
  mDat := oLst.Items[pIndex-1];
  ohFXA := mDat.rhFXA;
  ohFXT := mDat.rhFXT;
  ohFXL := mDat.rhFXL;
end;

// ********************************** PUBLIC ***********************************

function TFxd.ActBok:Str5;
begin
  Result := '';
  If ohFXA.BtrTable.Active
    then Result := ohFXA.BtrTable.BookNum
    else begin
      If ohFXT.BtrTable.Active
        then Result := ohFXT.BtrTable.BookNum
        else begin
          If ohFXL.BtrTable.Active then Result := ohFXL.BtrTable.BookNum
        end;
    end;
end;

procedure TFxd.Open(pBokNum:Str5); // Otvori vsetky databazove subory
begin
  Open (pBokNum,TRUE,TRUE,TRUE);
end;

procedure TFxd.Open(pBokNum:Str5;pFXA,pFXT,pFXL:boolean); // Otvori zadane databazove subory
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
    ohFXA := TFxaHnd.Create;
    ohFXT := TFxtHnd.Create;
    ohFXL := TFxlHnd.Create;
    // Otvorime databazove subory
    If pFXA then ohFXA.Open(pBokNum);
    If pFXT then ohFXT.Open(pBokNum);
    If pFXL then ohFXL.Open(pBokNum);
    // Ulozime objekty do zoznamu
    GetMem (mDat,SizeOf(TDat));
    mDat^.rhFXA := ohFXA;
    mDat^.rhFXT := ohFXT;
    mDat^.rhFXL := ohFXL;
    oLst.Add(mDat);
  end;
end;

procedure TFxd.SlcFxt(pDocNum:Str12); // Nacita danove opisy zo zadaneho dokladu
begin
  If otFXT.Active then otFXT.Close;
  otFXT.Open;
  If ohFXT.LocateDocNum(pDocNum) then begin
    Repeat
      otFXT.Insert;
      BTR_To_PX (ohFXT.BtrTable,otFXT.TmpTable);
      otFXT.Post;
      Application.ProcessMessages;
      ohFXT.Next;
    until ohFXT.Eof or (ohFXT.DocNum<>pDocNum);
  end;
end;

procedure TFxd.SlcFxl(pDocNum:Str12); // Nacita uctovne opisy zo zadaneho dokladu
begin
  If otFXL.Active then otFXL.Close;
  otFXL.Open;
  If ohFXL.LocateDocNum(pDocNum) then begin
    Repeat
      otFXL.Insert;
      BTR_To_PX (ohFXL.BtrTable,otFXL.TmpTable);
      otFXL.Post;
      Application.ProcessMessages;
      ohFXL.Next;
    until ohFXL.Eof or (ohFXL.DocNum<>pDocNum);
  end;
end;

end.


