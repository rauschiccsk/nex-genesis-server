unit StkFnc;

interface

uses
  IcTypes, IcConv, IcVariab, IcTools, NexClc, Prp,
  eSTKLST, hPROCAT, xSTCLST, eOCILST, eOSILST, hSPC, //eSTKPOS,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, Forms, DateUtils;

type
  TStkFnc=class
    constructor Create;
    destructor Destroy; override;
  private
  public
    ohSPC:TSpcHnd;
    ohSTKLST:TStklstHne;
    ohPROCAT:TProcatHnd;
    ohSTCLST:TStclstHnx;
//    ohSTKPOS:TSTKPOSHne;
    ohOSILST:TOsilstHne;
    ohOCILST:TOcilstHne;
    procedure StcClc(pStkNum:word;pProNum:longint); // PrepoËÌta vöetky ˙daje skladovej karty zadanÈho tovaru
  end;

implementation

uses bSPC;

constructor TStkFnc.Create;
begin
  ohSPC:=TSpcHnd.Create;
  ohSTKLST:=TStklstHne.Create;
  ohPROCAT:=TProcatHnd.Create;
  ohSTCLST:=TStclstHnx.Create;
//  ohSTKPOS:=TSTKPOSHne.Create;
  ohOSILST:=TOsilstHne.Create;
  ohOCILST:=TOcilstHne.Create;
end;

destructor TStkFnc.Destroy;
begin
  FreeAndNil(ohOCILST);
  FreeAndNil(ohOSILST);
//  FreeAndNil(ohSTKPOS);
  FreeAndNil(ohSTCLST);
  FreeAndNil(ohPROCAT);
  FreeAndNil(ohSTKLST);
  FreeAndNil(ohSPC);
end;

// ******************************** PRIVATE ************************************


// ********************************* PUBLIC ************************************

procedure TStkFnc.StcClc(pStkNum:word;pProNum:longint);
var mReqPrq,mRstPrq,mRosPrq,mExdPrq,mOsdPrq,mPosPrq:double;
begin
  // ⁄daje odberateæsk˝ch z·kaziek
  mReqPrq:=0; mRstPrq:=0; mRosPrq:=0; mExdPrq:=0;
  If ohOCILST.LocSnPn(pStkNum,pProNum) then begin
    Repeat
      mReqPrq:=mReqPrq+ohOCILST.ReqPrq;
      mRstPrq:=mRstPrq+ohOCILST.RstPrq;
      mRosPrq:=mRosPrq+ohOCILST.RosPrq;
      mExdPrq:=mExdPrq+ohOCILST.ExdPrq;
      ohOCILST.Next;
    until ohOCILST.Eof or (ohOCILST.StkNum<>pStkNum) or (ohOCILST.ProNum<>pProNum);
  end;
  // ⁄daje dod·vateæsk˝ch objedn·vok
  mOsdPrq:=0;
  If ohOSILST.LocSnPn(pStkNum,pProNum) then begin
    Repeat
      If ohOSILST.ItmSta='O' then mOsdPrq:=mOsdPrq+ohOSILST.UndPrq;
      ohOSILST.Next;
    until ohOSILST.Eof or (ohOSILST.StkNum<>pStknum) or (ohOSILST.ProNum<>pProNum);
  end;
  // ⁄daje poziËnej z·soby
  mPosPrq:=0;
  If not ohSPC.Active then ohSPC.Open(pStkNum);
  If ValInt(ohSPC.BtrTable.BookNum)<>pStkNum then ohSPC.Open(pStkNum);
  If ohSPC.LocateGsCode(pProNum) then begin
    Repeat
      If ohSPC.PoCode<>'' then mPosPrq:=mPosPrq+ohSPC.ActQnt;
      ohSPC.Next;
    until ohSPC.Eof or (ohSPC.GsCode<>pProNum);
  end;
  // ⁄daje skladov˝ch pohybov

  // UloûÌme ˙daje na skladov˙ kartu
  If not ohSTCLST.LocSnPn(pStkNum,pProNum) then begin  // Zaloûiù nov˙ skladov˙ kartu
    If ohPROCAT.LocProNum(pProNum) then begin
      ohSTCLST.Insert;
      // TODO Pridaù StkNum, keÔ uû sklady bud˙ spojenÈ
      ohSTCLST.StkNum:=pStkNum;
      ohSTCLST.ProNum:=pProNum;
      ohSTCLST.ProNam:=ohPROCAT.ProNam;
      ohSTCLST.PgrNum:=ohPROCAT.PgrNum;
      ohSTCLST.FgrNum:=ohPROCAT.FgrNum;
      ohSTCLST.BarCod:=ohPROCAT.BarCod;
      ohSTCLST.StkCod:=ohPROCAT.StkCod;
      ohSTCLST.VatPrc:=ohPROCAT.VatPrc;
      ohSTCLST.MsuNam:=ohPROCAT.MsuNam;
      ohSTCLST.ReqPrq:=mReqPrq;
      ohSTCLST.RstPrq:=mRstPrq;
      ohSTCLST.RosPrq:=mRosPrq;
    //    ohSTCLST.ExdPrq:=mExdPrq;
      ohSTCLST.OsdPrq:=mOsdPrq;
      ohSTCLST.PosPrq:=mPosPrq;
      ohSTCLST.Post;
    end;
  end else begin
    ohSTCLST.Edit;
    ohSTCLST.ReqPrq:=mReqPrq;
    ohSTCLST.RstPrq:=mRstPrq;
    ohSTCLST.RosPrq:=mRosPrq;
  //    ohSTCLST.ExdPrq:=mExdPrq;
    ohSTCLST.OsdPrq:=mOsdPrq;
    ohSTCLST.PosPrq:=mPosPrq;
    ohSTCLST.Post;
  end;
end;

end.


