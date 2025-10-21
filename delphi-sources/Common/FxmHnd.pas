unit FxmHnd;
{$F+}

// *****************************************************************************
//                          EVIDENCIA MAJETKU
// *****************************************************************************
//
// Programové funkcia:
// ---------------
// *****************************************************************************


interface

uses
  IcTypes, IcConst, IcConv, IcTools, IcVariab,
  NexBtrTable, ComCtrls, SysUtils, Classes, Forms;

type
  PDat=^TDat;
  TDat=record
    rdFXH:TNexBtrTable;
    rdFXT:TNexBtrTable;
    rdFXL:TNexBtrTable;
  end;

  TFxmHnd = class
    constructor Create;
    destructor  Destroy; override;
    private
      oBokNum:Str5;
      oFrmName:Str15;
      oLst:TList;
      procedure Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
    public
      odFXH:TNexBtrTable;
      odFXT:TNexBtrTable;
      odFXL:TNexBtrTable;
      procedure Open(pBokNum:Str5); overload; // Otvori vsetky databazove subory
      procedure Open(pPath:ShortString;pBokNum:Str5); overload; // Otvori vsetky databazove subory
      procedure Open(pBokNum:Str5;pSCH,pSCI,pSCN:boolean); overload;// Otvori zadane databazove subory
      procedure Open(pPath:ShortString;pBokNum:Str5;pSCH,pSCI,pSCN:boolean); overload; // Otvori vsetky databazove subory
      procedure DocLoc(pDocNum:Str15);
    published
      property BokNum:Str5 read oBokNum;
  end;

implementation

constructor TFxmHnd.Create;
begin
  oLst := TList.Create;  oLst.Clear;
end;

destructor TFxmHnd.Destroy;
var I:word;
begin
  If oLst.Count>0 then begin
    For I:=1 to oLst.Count do begin
      Activate (I);
      odFXH.Close;  FreeAndNil(odFXH);
      odFXT.Close;  FreeAndNil(odFXT);
      odFXL.Close;  FreeAndNil(odFXL);
    end;
  end;
  FreeAndNil (oLst);
end;

// ********************************* PRIVATE ***********************************

procedure TFxmHnd.Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
var mDat:PDat;
begin
  mDat := oLst.Items[pIndex-1];
  odFXH := mDat.rdFXH;
  odFXT := mDat.rdFXT;
  odFXL := mDat.rdFXL;
end;

// ********************************** PUBLIC ***********************************

procedure TFxmHnd.Open(pBokNum:Str5); // Otvori vsetky databazove subory
begin
  Open ('',pBokNum,TRUE,TRUE,TRUE);
end;

procedure TFxmHnd.Open(pPath:ShortString;pBokNum:Str5); // Otvori vsetky databazove subory
begin
  Open (pPath,pBokNum,TRUE,TRUE,TRUE);
end;

procedure TFxmHnd.Open(pBokNum:Str5;pSCH,pSCI,pSCN:boolean); // Otvori zadane databazove subory
begin
  Open('',pBokNum,pSCH,pSCI,pSCN); // Otvori vsetky databazove subory
end;

procedure TFxmHnd.Open(pPath:ShortString;pBokNum:Str5;pSCH,pSCI,pSCN:boolean); // Otvori vsetky databazove subory
var mFind:boolean;  mCnt:word;  mDat:PDat;
begin
(*
  oBokNum := pBokNum;
  mFind := FALSE;
  If oLst.Count>0 then begin
    mCnt := 0;
    Repeat
      Inc (mCnt);
      Activate(mCnt);
      mFind := ohSCH.BtrTable.BookNum=pBokNum;
    until mFind or (mCnt=oLst.Count);
  end;
  If not mFind then begin // Ak dana kniha este nie je otvorena potomotvorime
    // Vytvorime objekty
    If pPath='' then begin
      ohSCH := TSchHnd.Create;
      ohSCI := TSciHnd.Create;
      ohSCN := TScnHnd.Create;
    end
    else begin
      ohSCH := TSchHnd.Create(pPath);
      ohSCI := TSciHnd.Create(pPath);
      ohSCN := TScnHnd.Create(pPath);
    end;
    // Otvorime databazove subory
    If pSCH then ohSCH.Open(pBokNum);
    If pSCI then ohSCI.Open(pBokNum);
    If pSCN then ohSCN.Open(pBokNum);
    // Ulozime objekty do zoznamu
    GetMem (mDat,SizeOf(TDat));
    mDat^.rhSCH := ohSCH;
    mDat^.rhSCI := ohSCI;
    mDat^.rhSCN := ohSCN;
    oLst.Add(mDat);
  end;
  *)
end;

procedure TFxmHnd.DocLoc(pDocNum:Str15);
begin
end;

end.


