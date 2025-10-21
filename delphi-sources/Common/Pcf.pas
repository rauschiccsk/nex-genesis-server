unit Pcf;
{$F+}
// *****************************************************************************
// **********          FUNKCIE NA PR¡CU S PREDAJN›MI CENAMI           **********
// *****************************************************************************
interface

uses
  IcTypes, IcConv, IcTools, IcVariab, IniFiles, SysUtils, NexGlob, NexClc, DocFnc, AgmFnc, Txt, Dat, Key, Plc,
  NexPath, NexIni, Forms;

type
  TPcf=class
    constructor Create(pDat:TDat);
    destructor Destroy; override;
    private
      oDat:TDat;
      oDoc:TDocFnc;
      oAgm:TAgmFnc;
      oPlsNum:word;
      oSaDate:TDateTime;
      oAgdNum:Str30;
      oPceSrc:Str3;
      oPceDes:Str90;
      oLowApc:double;
      oVatPrc:integer;
    public
      function GetPlsBpc(pPaCode,pGsCode:longint):double;
      function GetPlsApc(pPaCode,pGsCode:longint):double;
      function GetAplBpc(pPaCode,pGsCode:longint):double;
      function GetAplApc(pPaCode,pGsCode:longint):double;
      function GetAgrBpc(pPaCode,pGsCode:longint):double;
      function GetAgrApc(pPaCode,pGsCode:longint):double;
      function GetBciBpc(pPaCode,pGsCode:longint):double;
      function GetBciApc(pPaCode,pGsCode:longint):double;
      function GetOcdBpc(pPaCode,pGsCode:longint;pOcbNum:Str5):double;
      function GetMinBpc(pStkNum,pGsCode:longint):double;

      function GetLowBpc(pStkNum,pPaCode,pGsCode:longint;pOcbNum:Str5):double;
      // -----------------------------------------------------------------------
      property PlsNum:word read oPlsNum write oPlsNum;  // »Ìslo predajnÈho cennÌka
      property SaDate:TDateTime write oSaDate;  // D·tum predaja - pre zistenie akciovej ceny
      property AgdNum:Str30 write oAgdNum;  // »Ìslo zmluvy - pre zistenie zmuvnej ceny
      property PceSrc:Str3 read oPceSrc;  // Zdroj predajnej ceny - oznaËenie
      property PceDes:Str90 read oPceDes;  // Zdroj predajnej ceny - popis
      property LowApc:double read oLowApc;  // Najlepöia cena bez DPH - vypoËÌtanÈ z ceny s DPH
      property PlsBpc[pPaCode,pGsCode:longint]:double read GetPlsBpc;  // CennÌkov· predajn· cena s DPH
      property PlsApc[pPaCode,pGsCode:longint]:double read GetPlsApc;  // CennÌkov· predajn· cena bez DPH
      property AplBpc[pPaCode,pGsCode:longint]:double read GetAplBpc;  // Akciov· predajn· cena s DPH
      property AplApc[pPaCode,pGsCode:longint]:double read GetAplApc;  // Akciov· predajn· cena bez DPH
      property AgrBpc[pPaCode,pGsCode:longint]:double read GetAgrBpc;  // Zmluvn· predajn· cena s DPH
      property AgrApc[pPaCode,pGsCode:longint]:double read GetAgrApc;  // Zmluvn· predajn· cena bez DPH
      property BciBpc[pPaCode,pGsCode:longint]:double read GetBciBpc;  // Obchodn· predajn· cena s DPH
      property BciApc[pPaCode,pGsCode:longint]:double read GetBciApc;  // Obchodn· predajn· cena bez DPH
      property OcdBpc[pPaCode,pGsCode:longint;pOcbNum:Str5]:double read GetOcdBpc;  // Predajn· cenz zo z·kazky
      property MinBpc[pStkNum,pGsCode:longint]:double read GetMinBpc;  // Minim·lna predajn· cena
      property LowBpc[pStkNum,pPaCode,pGsCode:longint;pOcbNum:Str5]:double read GetLowBpc;  // Najniûöia predajn· cena s DPH
    published
  end;

implementation

uses // bOCI, 
    bAPLITM, bAGRITM, Gsd, bFgpadsc, bPAB, bPLS, bSTK, bFGLST, dOCILST;

constructor TPcf.Create(pDat:TDat);
begin
  oDat:=pDat;
  oDoc:=TDocFnc.Create;
  oAgm:=TAgmFnc.Create;
  oPlsNum:=gIni.MainPls;
  oSaDate:=Date;
  oAgdNum:='';
end;

destructor TPcf.Destroy;
begin
  FreeAndNil(oAgm);
  FreeAndNil(oDoc);
end;

// ********************************* PRIVATE ***********************************

function TPcf.GetPlsBpc(pPaCode,pGsCode:longint):double;
begin
  Result:=0;
  // UrËÌme ËÌslo predajnÈho cennÌka
  oDat.oPad.OpenPAB;
  If oDat.oPad.ohPAB.PaCode<>pPaCode then begin
    If oDat.oPad.LocPaCode(pPaCode) then OPlsNum:=oDat.oPad.ohPAB.IcPlsNum;
  end else begin
    oDat.oPad.ohPAB.BtrTable.Refresh;
    oPlsNum:=oDat.oPad.ohPAB.IcPlsNum;
  end;
  If oPlsNum=0 then oPlsNum:=gIni.MainPls;
  // N·jdeme predajn˙ cenu
  With oDat.oGsd.oPld do begin
    Open(OPlsNum);
    If ohPLC.GsCode<>pGsCode then begin
      If ohPLC.LocateGsCode(pGsCode) then Result:=ohPLC.BPrice;
    end else Result:=ohPLC.BPrice;
  end;
end;

function TPcf.GetPlsApc(pPaCode,pGsCode:longint):double;
var mPlsNum:word;
begin
  Result:=0;
  mPlsNum:=0;
  // UrËÌme ËÌslo predajnÈho cennÌka
  oDat.oPad.OpenPAB;
  If oDat.oPad.ohPAB.PaCode<>pPaCode then begin
    If oDat.oPad.LocPaCode(pPaCode) then mPlsNum:=oDat.oPad.ohPAB.IcPlsNum;
  end else mPlsNum:=oDat.oPad.ohPAB.IcPlsNum;
  If mPlsNum=0 then mPlsNum:=oPlsNum;
  // N·jdeme predajn˙ cenu
  With oDat.oGsd.oPld do begin
    Open(mPlsNum);
    If ohPLC.GsCode<>pGsCode then begin
      If ohPLC.LocateGsCode(pGsCode) then Result:=ohPLC.APrice;
    end else Result:=ohPLC.APrice;
    oVatPrc:=ohPLC.VatPrc;
  end;
end;

function TPcf.GetAplBpc(pPaCode,pGsCode:longint):double;
var mAplNum:word;  mFind:boolean;
begin
  Result:=0;
  mAplNum:=0;
  // UrËÌme ËÌslo akciovÈho cennÌka
  oDat.oPad.OpenPAB;
  If oDat.oPad.ohPAB.PaCode<>pPaCode then begin
    If oDat.oPad.LocPaCode(pPaCode) then mAplNum:=oDat.oPad.ohPAB.IcAplNum;
  end else mAplNum:=oDat.oPad.ohPAB.IcAplNum;
  // N·jdeme akciov˙ cenu
  With oDat.oGsd.oPld do begin
    OpenAPLITM;
    If (ohAPLITM.AplNum<>mAplNum) or (ohAPLITM.GsCode<>pGsCode) then begin
      If ohAPLITM.LocateAnGs(mAplNum,pGsCode) then begin
        mFind:=FALSE;
        Repeat
          mFind:=InDateInterval(ohAPLITM.BegDate,ohAPLITM.EndDate,oSaDate);
          If not mFind then ohAPLITM.Next;
        until mFind or (ohAPLITM.AplNum<>mAplNum) or (ohAPLITM.GsCode<>pGsCode);
        If mFind then Result:=ohAPLITM.AcBPrice;
      end;
    end else Result:=ohAPLITM.AcBPrice;
  end;
end;

function TPcf.GetAplApc(pPaCode,pGsCode:longint):double;
var mAplNum:word;   mFind:boolean;
begin
  Result:=0;
  mAplNum:=0;
  // UrËÌme ËÌslo akciovÈho cennÌka
  oDat.oPad.OpenPAB;
  If oDat.oPad.ohPAB.PaCode<>pPaCode then begin
    If oDat.oPad.LocPaCode(pPaCode) then mAplNum:=oDat.oPad.ohPAB.IcAplNum;
  end else mAplNum:=oDat.oPad.ohPAB.IcAplNum;
  // N·jdeme akciov˙ cenu
  With oDat.oGsd.oPld do begin
    OpenAPLITM;
    If (ohAPLITM.AplNum<>mAplNum) or (ohAPLITM.GsCode<>pGsCode) then begin
      If ohAPLITM.LocateAnGs(mAplNum,pGsCode) then begin
        mFind:=FALSE;
        Repeat
          mFind:=InDateInterval(ohAPLITM.BegDate,ohAPLITM.EndDate,oSaDate);
          If not mFind then ohAPLITM.Next;
        until mFind or (ohAPLITM.AplNum<>mAplNum) or (ohAPLITM.GsCode<>pGsCode);
        If mFind then Result:=ohAPLITM.AcAPrice;
      end;
    end else Result:=ohAPLITM.AcAPrice;
  end;
end;

function TPcf.GetAgrBpc(pPaCode,pGsCode:longint):double;
begin
  Result:=oAgm.GetAgcBpc(pGsCode,pPaCode,'',Date);
(*
  Result:=0;
  With oDat.oGsd.oPld do begin
    OpenAGRITM;
    If (ohAGRITM.AgdNum<>oAgdNum) or (ohAGRITM.PaCode<>pPaCode) or (ohAGRITM.GsCode<>pGsCode) then begin
      If ohAGRITM.LocateAnPaGs(oAgdNum,pPaCode,pGsCode) then Result:=ohAGRITM.BPrice;
    end else Result:=ohAGRITM.BPrice;
  end;
*)
end;

function TPcf.GetAgrApc(pPaCode,pGsCode:longint):double;
begin
  Result:=oAgm.GetAgcApc(pGsCode,pPaCode,'',Date);
(*
  Result:=0;
  With oDat.oGsd.oPld do begin
    OpenAGRITM;
    If (ohAGRITM.AgdNum<>oAgdNum) or (ohAGRITM.PaCode<>pPaCode) or (ohAGRITM.GsCode<>pGsCode) then begin
      If ohAGRITM.LocateAnPaGs(oAgdNum,pPaCode,pGsCode) then Result:=ohAGRITM.APrice;
    end else Result:=ohAGRITM.APrice;
  end;
*)
end;

function TPcf.GetBciBpc(pPaCode,pGsCode:longint):double;
var mFgCode:longint;  mDscPrc:double;
begin
  Result:=0;
  With oDat.oGsd.oPld do begin
    If oDat.oGsd.LocGsCode(pGsCode) then begin
      mFgCode:=oDat.oGsd.ohGSC.FgCode;
      OpenFGPADSC;
      If (ohFGPADSC.PaCode<>pPaCode) or (ohFGPADSC.FgCode<>mFgCode) then begin
        If ohFGPADSC.LocatePaFg(pPaCode,mFgCode) then mDscPrc:=ohFGPADSC.DscPrc;
      end else mDscPrc:=ohFGPADSC.DscPrc;
      Result:=Rd(PlsBpc[pPaCode,pGsCode]*(1-mDscPrc/100),gKey.SysFgpFrc,cStand);
    end;
  end;
end;

function TPcf.GetBciApc(pPaCode,pGsCode:longint):double;
var mFgCode:longint;  mDscPrc:double;
begin
  Result:=0;
  With oDat.oGsd.oPld do begin
    If oDat.oGsd.LocGsCode(pGsCode) then begin
      mFgCode:=oDat.oGsd.ohGSC.FgCode;
      OpenFGPADSC;
      If (ohFGPADSC.PaCode<>pPaCode) or (ohFGPADSC.FgCode<>mFgCode) then begin
        If ohFGPADSC.LocatePaFg(pPaCode,mFgCode) then mDscPrc:=ohFGPADSC.DscPrc;
      end else mDscPrc:=ohFGPADSC.DscPrc;
      Result:=Rd(PlsApc[pPaCode,pGsCode]*(1-mDscPrc/100),gKey.SysFgpFrc,cStand);
    end;
  end;
end;

function TPcf.GetOcdBpc(pPaCode,pGsCode:longint;pOcbNum:Str5):double;
var mFgCode:longint;  mDscPrc:double;
begin
  Result:=0;
  If pOcbNum<>'' then begin
    With oDoc.oOcd do begin
      If ohOCILST.LocSnPaPnSt(gKey.Stk.MaiStk,pPaCode,pGsCode,'R') then begin // TODO - nie je to presnÈ urËenie ceny - bude treba celÈ prerobiù
        If IsNotNul(ohOCILST.SalPrq) then Result:=RndBas(ohOCILST.EndBva/ohOCILST.SalPrq);
      end;
    end;
(*
    With oDat.oDod.oOcd do begin
      Open(pOcbNum);
      OpenOCI;
      If ohOCI.LocatePaGsSt(pPaCode,pGsCode,'R') then Result:=ohOCI.FgBPrice;
    end;
*)    
  end;
end;

function TPcf.GetMinBpc(pStkNum,pGsCode:longint):double;
var mStkNum:word;  mCprice,mMinPrf:double;  mFgCode:longint;  mVatPrc:byte;
begin
  Result:=0;
  If gKey.Whs.MpcAct then begin
    mCprice:=0; mMinPrf:=0;
    If gKey.Whs.MpcStk=1
      then mStkNum:=pStkNum
      else mStkNum:=gKey.Stk.MaiStk;
    With oDat.oGsd do begin
      oStd.Open(mStkNum);
      If oStd.ohSTK.LocateGsCode(pGsCode) then begin
        mVatPrc:=oStd.ohSTK.VatPrc;
        If gKey.Whs.MpcCpc=1
          then mCprice:=oStd.ohSTK.AvgPrice
          else mCprice:=oStd.ohSTK.LastPrice;
      end;
      If IsNotNul(mCprice) then begin
        OpenGSC;
        OpenFGC;
        mMinPrf:=gKey.Whs.MinPrf;
        If ohGSC.LocateGsCode(pGsCode) then begin
          mVatPrc:=ohGSC.VatPrc;
          If ohFGC.LocateFgCode(ohGSC.FgCode) then begin
            If IsNotNul(ohFGC.MinPrf) then mMinPrf:=ohFGC.MinPrf;
          end;
        end;
        Result:=mCprice*(1+mMinPrf/100)*(1+mVatPrc/100);
      end;
    end;
  end;
end;

function TPcf.GetLowBpc(pStkNum,pPaCode,pGsCode:longint;pOcbNum:Str5):double;
var  mPlsBpc,mAplBpc,mAgrBpc,mBciBpc,mOcdBpc,mMinBpc:double;
begin
  mPlsBpc:=PlsBpc[pPaCode,pGsCode];
  mAplBpc:=AplBpc[pPaCode,pGsCode];
  mAgrBpc:=AgrBpc[pPaCode,pGsCode];
  mBciBpc:=BciBpc[pPaCode,pGsCode];
  mOcdBpc:=OcdBpc[pPaCode,pGsCode,pOcbNum];
  mMinBpc:=MinBpc[pStkNum,pGsCode];
  // N·jdeme najlepöiu cenu
  Result:=mPlsBpc;  oPceSrc:='PC';
  If IsNotNul(mAplBpc) and ((mAplBpc<Result) or IsNul(Result)) then begin
    oPceDes:=SysTxt('ActPce','Akciov· predajn· cena');
    Result:=mAplBpc;  oPceSrc:='AC';
  end;
  If IsNotNul(mAgrBpc) and ((mAgrBpc<Result) or IsNul(Result)) then begin
    oPceDes:=SysTxt('AgmPce','Predajn· cena podæa zmluvn˝ch podmienok');
    Result:=mAgrBpc;  oPceSrc:='ZP';
  end;
  If IsNotNul(mBciBpc) and ((mBciBpc<Result) or IsNul(Result)) then begin
    oPceDes:=SysTxt('BciPce','Predajn· cena podæa obchodn˝ch podmienok');
    Result:=mBciBpc;  oPceSrc:='OP';
  end;
  If IsNotNul(mOcdBpc) and ((mOcdBpc<Result) or IsNul(Result)) then begin
    oPceDes:=SysTxt('OcdPce','Predajn· cena podæa z·kazky');
    Result:=mOcdBpc;  oPceSrc:='ZK';
  end;
  If gKey.Whs.MpcAct then begin
    If Result<mMinBpc then begin
      If (oPceSrc<>'AC') or (not gKey.Whs.MpcApc and (oPceSrc='AC')) then begin
        oPceDes:=SysTxt('MinPce','Minim·lna predajn· cena');
        Result:=mMinBpc;  oPceSrc:='MC';
      end;
    end;
  end;
end;

// ********************************** PUBLIC ***********************************
end.
