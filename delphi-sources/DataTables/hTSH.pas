unit hTSH;

interface

uses
  IcTypes, IcTools, IcConv, IcValue, StkGlob, NexPath, NexGlob, NexIni, bTSH, hTSI, Dochand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TTshHnd = class (TTshBtr)
  private
  public
    function NextSerNum(pYear:Str2):longint; // Najde nasledujuce volne cislo dokladu
    function GenDocNum (pYear:Str2;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
    function GetVatPrc(pVatGrp:byte):byte; // Vráti percentuálnu sadzbu DPH zadanej daòovej skupiny
    procedure ResVer; // Prekontroluje ci doklad je rezervovany ak ano zrusi ho
    procedure Insert; overload;
    procedure Del(pDocNum:Str12);
    procedure Clc(phTSI:TTsiHnd);

    property VatPrc[pVatGrp:byte]:byte read GetVatPrc;
  end;

implementation

function TTshHnd.NextSerNum; // Najde nasledujuce volne cislo dokladu
begin
  Result:=GetDocNextYearSerNum(BtrTable,pYear);
end;

function TTshHnd.GenDocNum (pYear:Str2;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
begin
  Result := GenTsDocNum(pYear,BtrTable.BookNum,pSerNum);
end;

function TTshHnd.GetVatPrc(pVatGrp:byte):byte; // Vráti percentuálnu sadzbu DPH zadanej daòovej skupiny
begin
  Result := 0;
  case pVatGrp of
    1: Result := VatPrc1;
    2: Result := VatPrc2;
    3: Result := VatPrc3;
    4: Result := VatPrc4;
    5: Result := VatPrc5;
  end;
end;

procedure TTshHnd.ResVer; // Prekontroluje ci doklad je rezervovany ak ano zrusi ho
begin
  If DstLck=9 then Delete;
end;

procedure TTshHnd.Insert;
begin
  inherited ;
  VatPrc1 := gIni.GetVatPrc(1);
  VatPrc2 := gIni.GetVatPrc(2);
  VatPrc3 := gIni.GetVatPrc(3);
  VatPrc4 := gIni.GetVatPrc(4);
  VatPrc5 := gIni.GetVatPrc(5);
end;

procedure TTshHnd.Del(pDocNum:Str12);
begin
  If LocateDocNum(pDocNum) then Delete;
end;

procedure TTshHnd.Clc (phTSI:TTsiHnd);
var mItmQnt:longint; mDstStk,mDstPair:Str1; I:byte;
    mAcZValue,mAcTValue,mAcOValue,mAcSValue,mAcAValue,mAcBValue:double;
    mAcDValue,mAcDscVal,mAcRndVal,mFgDValue,mFgDscVal,mFgRndVal:double;
    mAcCValue,mAcEValue,mFgCValue,mFgEValue:TValue8; mPkdNum:Str12;
begin
  mItmQnt := 0;   mPkdNum := '';
  mAcZValue := 0; mAcTValue := 0; mAcOValue := 0; mAcSValue := 0;
  mAcDValue := 0; mAcDscVal := 0; mAcRndVal := 0; mAcAValue := 0; mAcBValue := 0;
  mFgDValue := 0; mFgDscVal := 0; mFgRndVal := 0;
  mAcCValue := TValue8.Create;  mAcCValue.Clear;
  mAcEValue := TValue8.Create;  mAcEValue.Clear;
  mFgCValue := TValue8.Create;  mFgCValue.Clear;
  mFgEValue := TValue8.Create;  mFgEValue.Clear;
  For I:=1 to 5 do begin
    mAcCValue.VatPrc[I] := VatPrc[I];
    mAcEValue.VatPrc[I] := VatPrc[I];
    mFgCValue.VatPrc[I] := VatPrc[I];
    mFgEValue.VatPrc[I] := VatPrc[I];
  end;
  mDstStk := 'N';   mDstPair := 'N';
  phTSI.SwapStatus;
  If phTSI.LocateDocNum (DocNum) then begin
    mDstStk := 'S';  mDstPair := 'Q';
    Repeat
      mItmQnt := mItmQnt+1;
      mAcZValue := mAcZValue+phTSI.AcZValue;
      mAcTValue := mAcTValue+phTSI.AcTValue;
      mAcOValue := mAcOValue+phTSI.AcOValue;
      mAcSValue := mAcSValue+phTSI.AcSValue;
      mAcDValue := mAcDValue+phTSI.AcDValue;
      mAcDscVal := mAcDscVal+phTSI.AcDscVal;
      mAcRndVal := mAcRndVal+phTSI.AcRndVal;
      mAcAValue := mAcAValue+phTSI.AcAValue;
      mAcBValue := mAcBValue+phTSI.AcBValue;
      mFgDValue := mFgDValue+phTSI.FgDValue;
      mFgDscVal := mFgDscVal+phTSI.FgDscVal;
      mFgRndVal := mFgRndVal+phTSI.FgRndVal;
      mAcCValue.Add (phTSI.VatPrc,phTSI.AcCValue);
      mAcEValue.Add (phTSI.VatPrc,phTSI.AcEValue);
      mFgCValue.Add (phTSI.VatPrc,phTSI.FgCValue);
      mFgEValue.Add (phTSI.VatPrc,phTSI.FgEValue);
      If (phTSI.StkStat='N') then mDstStk := 'N';
      If (phTSI.FinStat='') and (phTSI.FinStat<>'C') then mDstPair := 'N';
      If phTSI.PkdNum<>'' then mPkdNum := phTSI.PkdNum;
      phTSI.Next;
    until (phTSI.Eof) or (phTSI.DocNum<>DocNum);
  end;
  phTSI.RestoreStatus;
  // Ulozime vypocitane hodnoty do hlavicky dokladu
  DocClcRnd(mAcCValue,mAcEValue,mFgCValue,mFgEValue,IsNotNul(VatDoc));
  Edit;
  If IsNotNul (mAcSValue)
    then AcSValue := mAcSValue
    else AcSValue := mAcCValue.Value[0];
  If FgCourse=1 then begin
    If IsNotNul (mAcDValue)
      then DscPrc := Rd2 ((mAcDscVal/mAcDValue)*100)
      else DscPrc := 0;
  end
  else begin
    If IsNotNul (mFgDValue)
      then DscPrc := Rd2 ((mFgDscVal/mFgDValue)*100)
      else DscPrc := 0
  end;
  DocClcRnd(mAcCValue,mAcEValue,mFgCValue,mFgEValue,IsNotNul(VatDoc));
  AcCValue := mAcCValue.Value[0];
  AcVatVal := mAcEValue.Value[0]-mAcCValue.Value[0];
  AcEValue := mAcEValue.Value[0];
  AcCValue1 := mAcCValue.Value[1];
  AcCValue2 := mAcCValue.Value[2];
  AcCValue3 := mAcCValue.Value[3];
  AcCValue4 := mAcCValue.Value[4];
  AcCValue5 := mAcCValue.Value[5];

  AcEValue1 := mAcEValue.Value[1];
  AcEValue2 := mAcEValue.Value[2];
  AcEValue3 := mAcEValue.Value[3];
  AcEValue4 := mAcEValue.Value[4];
  AcEValue5 := mAcEValue.Value[5];

  AcPrfVal := mAcAValue-mAcCValue.Value[0]+mAcRndVal;
  PrfPrc := CalcProfPrc(mAcCValue.Value[0]+mAcRndVal,mAcAValue);
  FgCValue := mFgCValue.Value[0];
  FgVatVal := mFgEValue.Value[0]-mFgCValue.Value[0];
  FgEValue := mFgEValue.Value[0];
  FgCValue1 := mFgCValue.Value[1];
  FgCValue2 := mFgCValue.Value[2];
  FgCValue3 := mFgCValue.Value[3];
  FgCValue4 := mFgCValue.Value[4];
  FgCValue5 := mFgCValue.Value[5];

  FgEValue1 := mFgEValue.Value[1];
  FgEValue2 := mFgEValue.Value[2];
  FgEValue3 := mFgEValue.Value[3];
  FgEValue4 := mFgEValue.Value[4];
  FgEValue5 := mFgEValue.Value[5];

  ItmQnt := mItmQnt;
  DstStk := mDstStk;
  DstPair := mDstPair;
  PkdNum := mPkdNum;
  Post;
  FreeAndNil (mAcCValue);  FreeAndNil (mFgCValue);  FreeAndNil (mAcEValue);  FreeAndNil (mFgEValue);
end;

end.
{MOD 1905002}
