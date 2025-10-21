unit Pld;
{$F+}
// *****************************************************************************
// **********         DATABÁZOVÉ SÚBORY PREDAJNÝCH CENNÍKOV           **********
// *****************************************************************************
interface

uses
  IcTypes, IcConv, IcTools, IcVariab, IniFiles, SysUtils, NexGlob, NexIni, AgmFnc,
  hPLSLST, hPLS, hPLH, hAPLLST, hAPLITM, hFGPADSC,
  Classes, Forms;

type
  PDat=^TDat;
  TDat=record
    rhPLC:TPlsHnd;
    rhPLH:TPlhHnd;
  end;

  TPld=class
    constructor Create;
    destructor Destroy; override;
    private
      oLst:TList;     // Zoznam otvorených cenníkov
      oPlsNum:word;   // Èíslo aktuálneho cenníka
      procedure Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
    public
      ohPLSLST:TPlslstHnd;  // Zoznam predajných cenníkov
      ohAPLLST:TApllstHnd;  // Zoznam akciových cenníkov
      ohAPLITM:TAplitmHnd;  // Akciový predajný cenník
      ohFGPADSC:TFgpadscHnd;// Obchodné pdomienky zákazníkov
      ohPLC:TPlsHnd;  // Predajný cenník
      ohPLH:TPlhHnd;  // História zmeny cien
      function Open(pPlsNum:word):boolean;  // Otvorí predajný cenník
      procedure OpenPLH;  // Otvorí históriu zmeny cien na aktuálne otvorený cenník
      procedure OpenAPLLST;  // Otvorí zoznam akciových cenníkov
      procedure OpenAPLITM;  // Otvorí akciový predajný cenník
      procedure OpenFGPADSC; // Otvorí obchodné podmienky zákazníkov
    published
      property PlsNum:word read oPlsNum;
  end;

implementation

uses bAPLITM;

constructor TPld.Create;
begin
  ohAPLLST:=nil;  ohAPLITM:=nil;
  ohFGPADSC:=nil;
  ohPLSLST:=TPlslstHnd.Create;
  oLst:=TList.Create;  oLst.Clear;
end;

destructor TPld.Destroy;
var I:word;
begin
  If oLst.Count>0 then begin
    For I:=1 to oLst.Count do begin
      Activate(I);
      FreeAndNil(ohPLC);
      FreeAndNil(ohPLH);
    end;
  end;
  FreeAndNil(oLst);
  FreeAndNil(ohPLSLST);
  If ohFGPADSC<>nil then FreeAndNil(ohFGPADSC);
  If ohAPLITM<>nil then FreeAndNil(ohAPLITM);
  If ohAPLLST<>nil then FreeAndNil(ohAPLLST);
end;

// ********************************* PRIVATE ***********************************

procedure TPld.Activate(pIndex:word);
var mDat:PDat;
begin
  mDat:=oLst.Items[pIndex-1];
  ohPLC:=mDat.rhPLC;
  ohPLH:=mDat.rhPLH;
end;

// ********************************** PUBLIC ***********************************

function TPld.Open(pPlsNum:word):boolean;
var mFind:boolean;  mCnt:word;  mDat:PDat;
begin
  mFind:=FALSE;
  If pPlsNum=0 then pPlsNum:=gIni.MainPls;
  If not ohPLSLST.Active then ohPLSLST.Open;
  Result:=ohPLSLST.LocatePlsNum(pPlsNum);
  If Result then begin
    oPlsNum:=pPlsNum;
    If oLst.Count>0 then begin
      mCnt:=0;
      Repeat
        Inc(mCnt);
        Activate(mCnt);
        mFind:=(ValInt(ohPLC.BtrTable.BookNum)=pPlsNum);
      until mFind or (mCnt=oLst.Count);
    end;
    If not mFind then begin // Ak dana kniha este nie je otvorena potomotvorime
      // Vytvorime objekty
      ohPLC:=TPlsHnd.Create;
      ohPLH:=TPlhHnd.Create;
      // Otvorime databazove subory
      ohPLC.Open(pPlsNum);
      // Ulozime objekty do zoznamu
      GetMem(mDat,SizeOf(TDat));
      mDat^.rhPLC:=ohPLC;
      mDat^.rhPLH:=ohPLH;
      oLst.Add(mDat);
    end;
  end;
end;

procedure TPld.OpenPLH;
begin
  If not ohPLH.Active then ohPLH.Open(oPlsNum);
end;

procedure TPld.OpenAPLLST;
begin
  If ohAPLLST=nil then begin
    ohAPLLST:=TApllstHnd.Create;
    ohAPLLST.Open;
  end;
end;

procedure TPld.OpenAPLITM;
begin
  If ohAPLITM=nil then begin
    ohAPLITM:=TAplitmHnd.Create;
    ohAPLITM.Open;
  end;
end;

procedure TPld.OpenFGPADSC;
begin
  If ohFGPADSC=nil then begin
    ohFGPADSC:=TFgpadscHnd.Create;
    ohFGPADSC.Open;
  end;
end;

end.
