unit hOCH;

interface

uses
  IcTypes, IcConv, IcValue, IcTools, IcVariab,
  NexPath, NexGlob, NexIni, NexText, SavClc, bOCH, hOCI, DocHand,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TOchHnd = class (TOchBtr)
  private
  public
    function NextSerNum(pYear:Str2):longint; // Najde nasledujuce volne cislo dokladu
    function GenDocNum (pYear:Str2;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
    function GetVatPrc(pVatGrp:byte):byte; // Vráti percentuálnu sadzbu DPH zadanej daòovej skupiny
    function GetBokNum:Str5; // Cislo otvorenej knihy

    procedure Insert; overload;
    procedure Del(pDocNum:Str12);
    procedure Clc(phOCI:TOciHnd);   // Prepocita hlavicku podla jeho poloziek
    procedure ResVer; // Prekontroluje ci doklad je rezervovany ak ano zrusi ho
    procedure Res(pYear:Str2;pSerNum:longint); // Zarezervuje doklad so zadanym poradovym cislom
    function  IsMyRes: boolean;
    function  IsRes: boolean;

    property BokNum:Str5 read GetBokNum;
    property VatPrc[pVatGrp:byte]:byte read GetVatPrc;
  published
  end;

implementation

function TOchHnd.NextSerNum; // Najde nasledujuce volne cislo dokladu
begin
  Result:=GetDocNextYearSerNum(BtrTable,pYear);
end;

function TOchHnd.GenDocNum (pYear:Str2;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
begin
  Result:=GenOcDocNum(pYear,BokNum,pSerNum);
end;

function TOchHnd.GetVatPrc(pVatGrp:byte):byte; // Vráti percentuálnu sadzbu DPH zadanej daòovej skupiny
begin
  Result:=0;
  case pVatGrp of
    1: Result:=VatPrc1;
    2: Result:=VatPrc2;
    3: Result:=VatPrc3;
  end;
end;

function TOchHnd.GetBokNum:Str5; // Cislo otvorenej knihy
begin
  Result:=BtrTable.BookNum;
end;

procedure TOchHnd.Insert;
begin
  inherited ;
  VatPrc1:=gIni.GetVatPrc(1);
  VatPrc2:=gIni.GetVatPrc(2);
  VatPrc3:=gIni.GetVatPrc(3);
end;

procedure TOchHnd.Del(pDocNum:Str12);
begin
  If LocateDocNum(pDocNum) then Delete;
end;

procedure TOchHnd.Clc(phOCI:TOciHnd);   // Prepocita hlavicku podla jeho poloziek
var mItmQnt,mCntReq,mCntOrd,mCntRes,mCntPrp,mCntRat,mCntTrm,mCntOut,mCntErr:longint;
    mAcCValue,mAcDValue,mAcDscVal,mFgCValue,mFgDValue,mFgDscVal,mTValue:double;
    mAcAValue,mAcBValue,mFgAValue,mFgBValue:TValue8;    I:byte;
begin
  mItmQnt:=0;  mCntOrd:=0;  mCntReq:=0;  mCntRes:=0;  mTValue:=0;
  mCntPrp:=0;  mCntRat:=0;  mCntTrm:=0;  mCntOut:=0;  mCntErr:=0;
  mAcCValue:=0;  mAcDValue:=0;  mAcDscVal:=0;
  mFgCValue:=0;  mFgDValue:=0;  mFgDscVal:=0;
  mAcAValue:=TValue8.Create;  mAcAValue.Clear;
  mAcBValue:=TValue8.Create;  mAcBValue.Clear;
  mFgAValue:=TValue8.Create;  mFgAValue.Clear;
  mFgBValue:=TValue8.Create;  mFgBValue.Clear;
  For I:=1 to 3 do begin
    mAcAValue.VatPrc[I]:=VatPrc[I];
    mAcBValue.VatPrc[I]:=VatPrc[I];
    mFgAValue.VatPrc[I]:=VatPrc[I];
    mFgBValue.VatPrc[I]:=VatPrc[I];
  end;
  phOCI.SwapStatus;
  If phOCI.LocateDocNum(DocNum) then begin
    Repeat
      Inc (mItmQnt);
      mAcCValue:=mAcCValue+phOCI.AcCValue;
      mAcDValue:=mAcDValue+phOCI.AcDValue;
      mAcDscVal:=mAcDscVal+phOCI.AcDscVal;
      mFgCValue:=mFgCValue+phOCI.FgCValue;
      mFgDValue:=mFgDValue+phOCI.FgDValue;
      mFgDscVal:=mFgDscVal+phOCI.FgDscVal;
      mTValue:=mTValue+phOCI.TValue;
      mAcAValue.Add (phOCI.VatPrc,phOCI.AcAValue);
      mAcBValue.Add (phOCI.VatPrc,phOCI.AcBValue);
      mFgAValue.Add (phOCI.VatPrc,phOCI.FgAValue);
      mFgBValue.Add (phOCI.VatPrc,phOCI.FgBValue);
      If (phOCI.DlvDate>0) then Inc(mCntTrm);
      If (phOCI.RatDate>0) then Inc(mCntRat);
      If phOCI.StkStat='N' then Inc(mCntReq);
      If phOCI.StkStat='O' then Inc(mCntOrd);
      If phOCI.StkStat='R' then Inc(mCntRes);
      If phOCI.StkStat='P' then Inc(mCntPrp);
      If phOCI.StkStat='S' then Inc(mCntOut);
      If phOCI.StkStat='E' then Inc(mCntErr);
      phOCI.Next;
    until (phOCI.Eof) or (phOCI.DocNum<>DocNum);
  end;
  phOCI.RestoreStatus;
  // Ulozime vypocitane hodnoty do hlavicky objednavky
  DocClcRnd(mAcAValue,mAcBValue,mFgAValue,mFgBValue,IsNotNul(VatDoc));
  Edit;
  If FgCourse=1 then begin
    If IsNotNul (mAcDValue)
      then DscPrc:=Rd2 ((mAcDscVal/mAcDValue)*100)
      else DscPrc:=0;
  end
  else begin
    If IsNotNul (mFgDValue)
      then DscPrc:=Rd2 ((mFgDscVal/mFgDValue)*100)
      else DscPrc:=0;
  end;      
  AcCValue:=mAcCValue;
  AcAValue:=mAcAValue.Value[0];
  AcVatVal:=mAcBValue.Value[0]-mAcAValue.Value[0];
  AcBValue:=mAcBValue.Value[0];
  AcAValue1:=mAcAValue.Value[1];
  AcAValue2:=mAcAValue.Value[2];
  AcAValue3:=mAcAValue.Value[3];
  AcBValue1:=mAcBValue.Value[1];
  AcBValue2:=mAcBValue.Value[2];
  AcBValue3:=mAcBValue.Value[3];
  FgCValue:=mFgCValue;
  FgDValue:=mFgDValue;
  FgDscVal:=mFgDscVal;
  TValue:=mTValue;
  FgAValue:=mFgAValue.Value[0];
  FgVatVal:=mFgBValue.Value[0]-mFgAValue.Value[0];
  FgBValue:=mFgBValue.Value[0];
  FgAValue1:=mFgAValue.Value[1];
  FgAValue2:=mFgAValue.Value[2];
  FgAValue3:=mFgAValue.Value[3];
  FgBValue1:=mFgBValue.Value[1];
  FgBValue2:=mFgBValue.Value[2];
  FgBValue3:=mFgBValue.Value[3];
  AcDValue:=ClcAcFromFg2(mFgDValue,FgCourse);
  AcDscVal:=ClcAcFromFg2(mFgDscVal,FgCourse);
  ItmQnt:=mItmQnt;
  CntReq:=mCntReq;
  CntOrd:=mCntOrd;
  CntRes:=mCntRes;
  CntPrp:=mCntPrp;
  CntTrm:=mCntTrm;
  CntRat:=mCntRat;
  CntOut:=mCntOut;
  CntErr:=mCntErr;
  Post;
  FreeAndNil (mAcAValue);
  FreeAndNil (mAcBValue);
end;

function TOchHnd.IsMyRes: boolean;
begin
  Result:= (DstLck=9) and (CrtUser=gvSys.LoginName);
end;

function TOchHnd.IsRes: boolean;
begin
  Result:= (DstLck=9);
end;

procedure TOchHnd.Res(pYear:Str2;pSerNum: Integer);
begin
  Insert;
  Year  :=pYear;
  SerNum:=pSerNum;
  DocNum:=GenDocNum(pYear,pSerNum);
  DocDate:=Date;
  DstLck:=9;
  PaName:=gNt.GetSecText('STATUS','Reserve','Rezervovane pre: ')+gvSys.LoginName;
  Post;
end;

procedure TOchHnd.ResVer;
begin
  If DstLck=9 then Delete;
end;

end.
