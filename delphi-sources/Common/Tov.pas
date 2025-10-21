unit Tov;
{$F+}
// *****************************************************************************
// **********                  TERMINÁLOVÉ VÝDAJKY                    **********
// *****************************************************************************
interface

uses
  IcTypes, IcConv, IcTools, IcVariab, IniFiles, SysUtils, NexGlob, DocHand, Bok,
  hTOH, hTOI, hTOA,
  Classes, Forms;

type
  PDat=^TDat;
  TDat=record
    rhTOH:TTohHnd;
    rhTOI:TToiHnd;
    rhTOA:TToaHnd;
  end;

  TTov=class
    constructor Create;
    destructor Destroy; override;
    private
      oLst:TList;     // Zoznam otvorených cenníkov
      oBokNum:Str5;
      function GetDocNum:Str12;
      procedure Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
    public
      ohTOH:TTohHnd;
      ohTOA:TToaHnd;
      ohTOI:TToiHnd;
      function Open(pBokNum:Str5):boolean;  // Otvori zadnú knihu
      procedure OpenTOI;
      procedure OpenTOA;
    published
      property DocNum:Str12 read GetDocNum;
      property BokNum:Str5 read oBokNum;
  end;

implementation

constructor TTov.Create;
begin
  oLst:=TList.Create;  oLst.Clear;
end;

destructor TTov.Destroy;
var I:word;
begin
  If oLst.Count>0 then begin
    For I:=1 to oLst.Count do begin
      Activate(I);
      FreeAndNil(ohTOH);
      FreeAndNil(ohTOA);
      FreeAndNil(ohTOI);
    end;
  end;
  FreeAndNil(oLst);
end;

// ********************************* PRIVATE ***********************************

function TTov.GetDocNum:Str12;
begin
  Result:=ohTOH.DocNum;;
end;

procedure TTov.Activate(pIndex:word);
var mDat:PDat;
begin
  mDat:=oLst.Items[pIndex-1];
  ohTOH:=mDat.rhTOH;
  ohTOA:=mDat.rhTOA;
  ohTOI:=mDat.rhTOI;
end;

// ********************************** PUBLIC ***********************************

function TTov.Open(pBokNum:Str5):boolean;
var mFind:boolean;  mCnt:word;  mDat:PDat;
begin
  If pBokNum<>'' then begin
    Result:=gBok.BokExist('TOB',pBokNum,TRUE);
    If Result then begin
      oBokNum:=pBokNum;
      mFind:=FALSE;
      If oLst.Count>0 then begin
        mCnt:=0;
        Repeat
          Inc(mCnt);
          Activate(mCnt);
          mFind:=(oBokNum=pBokNum);
        until mFind or (mCnt=oLst.Count);
      end;
      If not mFind then begin // Ak dana kniha este nie je otvorena potomotvorime
        // Vytvorime objekty
        ohTOH:=TTohHnd.Create;
        ohTOI:=TToiHnd.Create;
        ohTOA:=TToaHnd.Create;
        // Otvorime databazove subory
        ohTOH.Open(pBokNum);
        // Ulozime objekty do zoznamu
        GetMem(mDat,SizeOf(TDat));
        mDat^.rhTOH:=ohTOH;
        mDat^.rhTOI:=ohTOI;
        mDat^.rhTOA:=ohTOA;
        oLst.Add(mDat);
      end;
    end;
  end;
end;

procedure TTov.OpenTOI;
begin
  If not ohTOI.Active or (ohTOI.BtrTable.BookNum<>oBokNum) then ohTOI.Open(oBokNum);
end;

procedure TTov.OpenTOA;
begin
  If not ohTOA.Active or (ohTOA.BtrTable.BookNum<>oBokNum) then ohTOA.Open(oBokNum);
end;

end.
