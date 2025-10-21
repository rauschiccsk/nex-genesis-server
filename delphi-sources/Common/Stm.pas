unit Stm;
{$F+}

// *****************************************************************************
//                   OBJEKT NA PRACU SO SKLADOVYMI POHYBMI
// *****************************************************************************


interface

uses
  IcTypes, IcConst, IcConv, IcTools, IcDate, IcVariab,
  NexGlob, NexPath, NexMsg, NexIni,
  DocHand, Key, StkGlob, hSTM,
  NexBtrTable, NexPxTable, ComCtrls, SysUtils, Classes, Forms, Controls;

type
  PDat=^TDat;
  TDat=record
    rYerNum:integer;
    rStkNum:word;
    rhSTM:TStmHnd;
  end;

  TStm=class
    constructor Create;
    destructor  Destroy;
    private
      oLst:TList; // Zoznam otvorenych subotov STM
      function GetCount:word;
      procedure Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
    public
      oPrvPath:ShortString;
      oYerNum:integer;
      oStkNum:word;
      ohSTM:TStmHnd;
      procedure Open(pYerNum:integer;pStkNum:word);
    published
      property Count:word read GetCount;
  end;

implementation

constructor TStm.Create;
begin
  oPrvPath:=gPath.PrvPath(gvSys.ActYear)+'STORES\';
  oLst:=TList.Create;  oLst.Clear;
end;

destructor TStm.Destroy;
var I:word;
begin
  If oLst.Count>0 then begin
    For I:=0 to oLst.Count-1 do begin
      Activate(I);
      FreeAndNil(ohSTM);
    end;
  end;
  FreeAndNil(oLst);
  inherited;
end;

// ********************************* PRIVATE ***********************************

procedure TStm.Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
var mDat:PDat;
begin
  mDat:=oLst.Items[pIndex-1];
  oYerNum:=mDat.rYerNum;
  oStkNum:=mDat.rStkNum;
  ohSTM:=mDat.rhSTM;
end;


// ********************************** PUBLIC ***********************************

procedure TStm.Open(pYerNum:integer;pStkNum:word);
var mFind:boolean;  mCnt:word; mDat:PDat;
begin
  mFind:=FALSE;
  If oLst.Count>0 then begin
    mCnt:=0;
    Repeat
      Inc(mCnt);
      Activate(mCnt);
      mFind:=(oYerNum=pYerNum) and (oStkNum=pStkNum);
    until mFind or (mCnt=oLst.Count);
  end;
  If not mFind then begin // Ak sklad nie je ete otvorený
    If pYerNum=0
      then ohSTM:=TStmHnd.Create
      else ohSTM:=TStmHnd.Create(oPrvPath);
    oYerNum:=pYerNum;
    oStkNum:=pStkNum;
    ohSTM.Open(pStkNum);
    // Ulozime objekty do zoznamu
    GetMem (mDat,SizeOf(TDat));
    mDat^.rYerNum:=pYerNum;
    mDat^.rStkNum:=pStkNum;
    mDat^.rhSTM:=ohSTM;
    oLst.Add(mDat);
  end;
end;

function TStm.GetCount:word;
begin
  Result:=oLst.Count;
end;

end.

