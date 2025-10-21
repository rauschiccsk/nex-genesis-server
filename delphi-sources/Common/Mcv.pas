unit Mcv;
{$F+}
// *****************************************************************************
// **********                 ODBERATE¼SKÉ PONUKY                     **********
// *****************************************************************************
interface

uses
  IcTypes, IcConv, IcTools, IcVariab, IniFiles, NexGlob, NexError, NexMsg, DocHand,
  Bok, Gsd,
  hMCH, hMCI, hMCN, tMCI,
  Classes, SysUtils, Forms;

type
  PDat=^TDat;
  TDat=record
    rhMCH:TMchHnd;
    rhMCI:TMciHnd;
    rhMCN:TMcnHnd;
  end;

  TMcv=class
    constructor Create;
    destructor Destroy; override;
    private
      oLst:TList;     // Zoznam otvorených cenníkov
      oBokNum:Str5;
      function GetDocNum:Str12;
      procedure Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
    public
      ohMCH:TMchHnd;
      ohMCI:TMciHnd;
      ohMCN:TMcnHnd;
      otMCI:TMciTmp;
      function Open(pBokNum:Str5):boolean;  // Otvori zadnú knihu
      function NexItmNum(pDocNum:Str12):word; //

      procedure OpenMCI;
      procedure OpenMCN;
      procedure ItmLst(pDocNum:Str12);
      procedure AddItm(pDocNum:Str12;pItmNum:word;pGsCode:longint;pGsQnt,pHPrice,pBPrice:double;pGsd:TGsd);
    published
      property DocNum:Str12 read GetDocNum;
  end;

implementation

constructor TMcv.Create;
begin
  oLst:=TList.Create;  oLst.Clear;
  otMCI:=TMciTmp.Create
end;

destructor TMcv.Destroy;
var I:word;
begin
  If oLst.Count>0 then begin
    For I:=1 to oLst.Count do begin
      Activate(I);
      FreeAndNil(ohMCH);
      FreeAndNil(ohMCI);
      FreeAndNil(ohMCN);
    end;
  end;
  FreeAndNil(otMCI);
  FreeAndNil(oLst);
end;

// ********************************* PRIVATE ***********************************

function TMcv.GetDocNum:Str12;
begin
  Result:=ohMCH.DocNum;;
end;

procedure TMcv.Activate(pIndex:word);
var mDat:PDat;
begin
  mDat:=oLst.Items[pIndex-1];
  ohMCH:=mDat.rhMCH;
  ohMCI:=mDat.rhMCI;
  ohMCN:=mDat.rhMCN;
end;

// ********************************** PUBLIC ***********************************

function TMcv.Open(pBokNum:Str5):boolean;
var mFind:boolean;  mCnt:word;  mDat:PDat;
begin
  If pBokNum<>'' then begin
    Result:=gBok.BokExist('MCB',pBokNum,TRUE);
    If Result then begin
      oBokNum:=pBokNum;
      mFind:=FALSE;
      If oLst.Count>0 then begin
        mCnt:=0;
        Repeat
          Inc(mCnt);
          Activate(mCnt);
          mFind:=(ohMCH.BtrTable.BookNum=pBokNum);
        until mFind or (mCnt=oLst.Count);
      end;
      If not mFind then begin // Ak dana kniha este nie je otvorena potomotvorime
        // Vytvorime objekty
        ohMCH:=TMchHnd.Create;
        ohMCI:=TMciHnd.Create;
        ohMCN:=TMcnHnd.Create;
        // Otvorime databazove subory
        ohMCH.Open(pBokNum);
        ohMCI.Open(pBokNum);
        ohMCN.Open(pBokNum);
        // Ulozime objekty do zoznamu
        GetMem(mDat,SizeOf(TDat));
        mDat^.rhMCH:=ohMCH;
        mDat^.rhMCI:=ohMCI;
        mDat^.rhMCN:=ohMCN;
        oLst.Add(mDat);
      end;
    end;
  end;
end;

function TMcv.NexItmNum (pDocNum:Str12):word;
begin
  ohMCI.SwapStatus;
  If not ohMCI.NearestDoIt(pDocNum,65000) then ohMCI.Last;
  If not ohMCI.IsLastRec or (ohMCI.DocNum<>pDocNum) then ohMCI.Prior;
  If ohMCI.DocNum=pDocNum
    then Result:=ohMCI.ItmNum+1
    else Result:=1;
  ohMCI.RestoreStatus;
end;

procedure TMcv.OpenMCI;
begin
  If not ohMCI.Active or (ohMCI.BtrTable.BookNum<>oBokNum) then ohMCI.Open(oBokNum);
end;

procedure TMcv.OpenMCN;
begin
  If not ohMCN.Active or (ohMCN.BtrTable.BookNum<>oBokNum) then ohMCN.Open(oBokNum);
end;

procedure TMcv.ItmLst(pDocNum:Str12);
var mBokNum:Str5;
begin
  otMCI.Open;
  mBokNum:=BookNumFromDocNum(pDocNum);
  Open(mBokNum);
  If ohMCI.LocateDocNum(pDocNum) then begin
    Repeat
      otMCI.Insert;
      BTR_To_PX(ohMCI.BtrTable,otMCI.TmpTable);
      otMCI.Post;
      ohMCI.Next;
    until ohMCI.Eof or (ohMCI.DocNum<>pDocNum);
  end;
end;

procedure TMcv.AddItm(pDocNum:Str12;pItmNum:word;pGsCode:longint;pGsQnt,pHPrice,pBPrice:double;pGsd:TGsd);
begin
  If ohMCH.LocateDocNum(pDocNum) then begin
    If not pGsd.ohGSC.Active then pGsd.ohGSC.Open;
    If pGsd.ohGSC.LocateGsCode(pGsCode) then begin
      If pItmNum=0 then pItmNum:=NexItmNum(pDocNum);
      If ohMCI.LocateDoIt(pDocNum,pItmNum) then begin // Existujúca položka
        ohMCI.Edit;
      end else begin  // Nová položka
        ohMCI.Insert;
        ohMCI.DocNum:=ohMCH.DocNum;
        ohMCI.ItmNum:=pItmNum;
      end;
      BTR_To_BTR(pGsd.ohGSC.BtrTable,ohMCI.BtrTable);
      ohMCI.GsQnt:=pGsQnt;
      ohMCI.StkNum:=ohMCH.StkNum;
      ohMCI.PaCode:=ohMCH.PaCode;
      ohMCI.DocDate:=ohMCH.DocDate;
      If ohMCH.VatDoc=0 then begin
//        pHPrice:=pHPrice/(1+ohOCI.VatPrc/100);
        ohMCI.VatPrc:=0;
      end;
//      ohOCI.DscPrc:=pDscPrc;
//      ohOCI.SetAcCPrice(pAcCPrice,ohOCH.FgCourse);
//      ohOCI.SetFgHPrice(pFgHPrice,ohOCH.FgCourse,pDscPrc);
//      ohOCI.StkStat:='N';
      ohMCI.Post;
    end else ShowMsg(eCom.GscIsNoExist,StrInt(pGsCode,0));
  end else ShowMsg(eCom.DocIsNoExist,pDocNum);
end;

end.
