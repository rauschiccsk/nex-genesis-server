unit Stf;
{$F+}
// *****************************************************************************
// **********              FUNKCIE NA PRÁCU SO SKLADOM                **********
// *****************************************************************************
interface

uses
  IcTypes, IcConv, IcTools, IcVariab, IniFiles, SysUtils, NexGlob, Dat, DocFnc,
  NexPath, NexIni, Forms;

type
  TStf=class
    constructor Create(pDat:TDat);
    destructor Destroy; override;
    private
      oDat:TDat;
      oDoc:TDocFnc;
    public
      function GetActQnt(pStkNum:word;pGsCode:longint):double;
      function GetPosQnt(pStkNum:word;pGsCode:longint):double;
      function GetFreQnt(pStkNum:word;pGsCode:longint):double;
      function GetOcdQnt(pStkNum:word;pPaCode,pGsCode:longint):double;

      function ClcPosQnt(pStkNum:word;pGsCode:longint):double;

      procedure AddSts(pStkNum:word;pGsCode:longint;pSalQnt:double;pDocNum:Str12;pItmNum:word);
      procedure ClcSts(pStkNum:word;pGsCode:longint);

      procedure AddSpm(pStkNum:word;pSrcPos,pTrgPos:Str15;pGsCode:longint;pMovQnt:double);
      procedure ClcSpc(pStkNum:word;pPoCode:Str15;pGsCode:longint);

      property ActQnt[pStkNum:word;pGsCode:longint]:double read GetActQnt;
      property PosQnt[pStkNum:word;pGsCode:longint]:double read GetPosQnt;
      property FreQnt[pStkNum:word;pGsCode:longint]:double read GetFreQnt;
      property OcdQnt[pStkNum:word;pPaCode,pGsCode:longint]:double read GetOcdQnt;
    published
  end;

implementation

uses dOCILST;

constructor TStf.Create(pDat:TDat);
begin
  oDat:=pDat;
  oDoc:=TDocFnc.Create;
end;

destructor TStf.Destroy;
begin
  FreeAndNil(oDoc);
end;

// ********************************* PRIVATE ***********************************

// ********************************** PUBLIC ***********************************
function TStf.GetActQnt(pStkNum:word;pGsCode:longint):double;
begin
  Result:=0;
  With oDat.oGsd.oStd do begin
    Open(pStkNum);
    If ohSTK.GsCode<>pGsCode then begin
      If ohSTK.LocateGsCode(pGsCode) then Result:=ohSTK.ActQnt;
    end else begin
      ohSTK.BtrTable.Refresh;
      Result:=ohSTK.ActQnt;
    end;
  end;
end;

function TStf.GetPosQnt(pStkNum:word;pGsCode:longint):double;
begin
  Result:=0;
  With oDat.oGsd.oStd do begin
    Open(pStkNum);
    If ohSTK.GsCode<>pGsCode then begin
      If ohSTK.LocateGsCode(pGsCode) then Result:=ohSTK.PosQnt;
    end else begin
      ohSTK.BtrTable.Refresh;
      Result:=ohSTK.PosQnt;
    end;
  end;
end;

function TStf.GetFreQnt(pStkNum:word;pGsCode:longint):double;
begin
  Result:=0;
  With oDat.oGsd.oStd do begin
    Open(pStkNum);
    If ohSTK.GsCode<>pGsCode then begin
      If ohSTK.LocateGsCode(pGsCode) then Result:=ohSTK.FreQnt;
    end else begin
      ohSTK.BtrTable.Refresh;
      Result:=ohSTK.FreQnt;
    end;
  end;
end;


function TStf.GetOcdQnt(pStkNum:word;pPaCode,pGsCode:longint):double;
begin
  Result:=0;
  With oDoc.oOcd do begin
    If ohOCILST.LocSnPaPnSt(pStkNum,pPaCode,pGsCode,'R') then begin
      Repeat
        Result:=Result+ohOCILST.UndPrq;
        ohOCILST.Next;
      until ohOCILST.Eof or (ohOCILST.StkNum<>pStkNum) or (ohOCILST.ParNum<>pPaCode) or (ohOCILST.ProNum<>pGsCode) or (ohOCILST.RstSta<>'R');
    end;
  end;
(*
  With oDat.oGsd.oStd do begin
    Open(pStkNum);  OpenSTO;
    If ohSTO.LocateGsOrStPa(pGsCode,'C','R',PPaCode) then begin
      Repeat
        Result:=ohSTO.OrdQnt-ohSTO.DlvQnt;
        ohSTO.Next;
      until ohSTO.Eof or (ohSTO.GsCode<>pGsCode) or (ohSTO.OrdType<>'C') or (ohSTO.StkStat<>'R') or (ohSTO.PaCode<>pPaCode);
    end;
  end;
*)
end;

function TStf.ClcPosQnt(pStkNum:word;pGsCode:longint):double;
begin
  Result:=0;
  With oDat.oGsd.oStd do begin
    Open(pStkNum);  OpenSPC;
    If ohSPC.LocateGsCode(pGsCode) then begin
      Repeat
        Result:=Result+ohSPC.ActQnt;
        ohSPC.Next;
      until ohSPC.Eof or (ohSPC.GsCode<>pGsCode);
    end;
  end;
end;

procedure TStf.AddSts(pStkNum:word;pGsCode:longint;pSalQnt:double;pDocNum:Str12;pItmNum:word);
begin
  With oDat.oGsd.oStd do begin
    If pStkNum<>StkNum then Open(pStkNum);
    OpenSTS;
    If not ohSTS.LocateDoIt(pDocNum,pItmNum) then begin
      If IsNotNul(pSalQnt) then begin
        ohSTS.Insert;
        ohSTS.DocNum:=pDocNum;
        ohSTS.ItmNum:=pItmNum;
        ohSTS.GsCode:=pGsCode;
        ohSTS.SalDate:=Date;
        ohSTS.SalQnt:=pSalQnt;
        ohSTS.Post;
      end;
    end else begin
      If IsNotNul(pSalQnt) then begin
        ohSTS.Edit;
        ohSTS.SalQnt:=pSalQnt;
        ohSTS.Post;
      end;
      If IsNul(pSalQnt) then ohSTS.Delete;
    end;
    ClcSts(pStkNum,pGsCode);
  end;
end;

procedure TStf.ClcSts(pStkNum:word;pGsCode:longint);
var mSalQnt:double;
begin
  With oDat.oGsd.oStd do begin
    If pStkNum<>StkNum then Open(pStkNum);
    OpenSTS;
    mSalQnt:=0;
    If ohSTS.LocateGsCode(pGsCode) then begin
      Repeat
        mSalQnt:=mSalQnt+ohSTS.SalQnt;
        ohSTS.Next;
      until ohSTS.Eof or (ohSTS.GsCode<>pGsCode);
    end;
    ohSTK.BtrTable.Refresh;
    If ohSTK.SalQnt<>mSalQnt then begin
      ohSTK.Edit;
      ohSTK.SalQnt:=mSalQnt;
      ohSTK.Post;
    end;
  end;
end;

procedure TStf.AddSpm(pStkNum:word;pSrcPos,pTrgPos:Str15;pGsCode:longint;pMovQnt:double);
begin
  With oDat.oGsd.oStd do begin
    If pStkNum<>StkNum then Open(pStkNum);
    OpenSPM;
    If IsNotNul(pMovQnt) then begin
      ohSPM.Insert;
      If pSrcPos<>'' then begin
        ohSPM.PoCode:=pSrcPos;
        ohSPM.GsCode:=pGsCode;
        ohSPM.MovQnt:=pMovQnt*(-1);
        ohSPM.MovDat:=Date;
        ohSPM.MovTim:=Time;
        ohSPM.Post;
        ClcSpc(pStkNum,pSrcPos,pGsCode);
      end;  
      If pTrgPos<>'' then begin
        ohSPM.Insert;
        ohSPM.PoCode:=pTrgPos;
        ohSPM.GsCode:=pGsCode;
        ohSPM.MovQnt:=pMovQnt;
        ohSPM.MovDat:=Date;
        ohSPM.MovTim:=Time;
        ohSPM.Post;
        ClcSpc(pStkNum,pTrgPos,pGsCode);
      end;
    end;
  end;
end;

procedure TStf.ClcSpc(pStkNum:word;pPoCode:Str15;pGsCode:longint);
var mPosQnt:double; // Zásoba na všetkých pozíciách daného tovru
    mActQnt:double; // Zásoba na zadanej pozícii daného tovaru
begin
  With oDat.oGsd.oStd do begin
    If pStkNum<>StkNum then Open(pStkNum);
    OpenSPC;
    mPosQnt:=0;  mActQnt:=0;
    If ohSPM.LocateGsCode(pGsCode) then begin
      Repeat
        mPosQnt:=mPosQnt+ohSPM.MovQnt;
        If ohSPM.PoCode=pPoCode then mActQnt:=mActQnt+ohSPM.MovQnt;
        ohSPM.Next;
      until ohSPM.Eof or (ohSPM.GsCode<>pGsCode);
    end;
    If not ohSPC.LocatePoGs(pPoCode,pGsCode) then begin
      ohSPC.Insert;
      ohSPC.PoCode:=pPoCode;
      ohSPC.GsCode:=pGsCode;
      ohSPC.ActQnt:=mActQnt;
      ohSPC.Post;
    end else begin
      If ohSPC.ActQnt<>mActQnt then begin
        ohSPC.Edit;
        ohSPC.ActQnt:=mActQnt;
        ohSPC.Post;
      end;
    end;
    If ohSTK.GsCode<>pGsCode then ohSTK.LocateGsCode(pGsCode);
    If ohSTK.GsCode=pGsCode then begin
      ohSTK.Edit;
      ohSTK.PosQnt:=mPosQnt;
      ohSTK.Post;
    end;
  end;
end;

end.
