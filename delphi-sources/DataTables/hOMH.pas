unit hOMH;

interface

uses
  IcTypes, IcConv, IcTools, IcValue, NexPath, NexGlob, NexIni, bOMH, hOMI, Dochand,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TOmhHnd = class (TOmhBtr)
  private
  public
    function NextSerNum(pYear:Str2):longint; // Najde nasledujuce volne cislo dokladu
    function GenDocNum (pYear:Str2;pBookNum:Str5;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
    function GetVatPrc(pVatGrp:byte):byte; // Vráti percentuálnu sadzbu DPH zadanej daòovej skupiny
    procedure Insert; overload;
    procedure Del(pDocNum:Str12);
    procedure Clc(phOMI:TOmiHnd);
    property VatPrc[pVatGrp:byte]:byte read GetVatPrc;
  published
  end;

implementation

function TOmhHnd.NextSerNum; // Najde nasledujuce volne cislo dokladu
begin
  Result := GetDocNextYearSerNum(BtrTable,pYear);
end;

function TOmhHnd.GenDocNum (pYear:Str2;pBookNum:Str5;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
begin
  Result := GenOmDocNum(pYear,pBookNum,pSerNum);
end;

function TOmhHnd.GetVatPrc(pVatGrp:byte):byte; // Vráti percentuálnu sadzbu DPH zadanej daòovej skupiny
begin
  Result := 0;
  case pVatGrp of
    1: Result := Round(VatPrc1);
    2: Result := Round(VatPrc2);
    3: Result := Round(VatPrc3);
    4: Result := Round(VatPrc4);
    5: Result := Round(VatPrc5);
  end;
end;

procedure TOmhHnd.Insert;
begin
  inherited ;
  VatPrc1 := gIni.GetVatPrc(1);
  VatPrc2 := gIni.GetVatPrc(2);
  VatPrc3 := gIni.GetVatPrc(3);
  VatPrc4 := gIni.GetVatPrc(4);
  VatPrc5 := gIni.GetVatPrc(5);
end;

procedure TOmhHnd.Del(pDocNum:Str12);
begin
  If LocateDocNum(pDocNum) then Delete;
end;

procedure TOmhHnd.Clc(phOMI:TOmiHnd);
var I:byte; mItmQnt:longint;   mAValue,mBValue:double;   mCValue,mEValue:TValue8;  mDstStk:Str1;
begin
  mItmQnt := 0;  mAValue := 0;  mBValue := 0;
  mCValue := TValue8.Create;  mCValue.Clear;
  mEValue := TValue8.Create;  mEValue.Clear;
  For I:=1 to 5 do begin
    mCValue.VatPrc[I] := VatPrc[I];
    mEValue.VatPrc[I] := VatPrc[I];
  end;
  phOMI.SwapIndex;
  mDstStk := 'N';
  If phOMI.LocateDocNum (DocNum) then begin
    mDstStk := 'S';
    Repeat
      Inc (mItmQnt);
      mCValue.Add (phOMI.VatPrc,phOMI.CValue);
      mEValue.Add (phOMI.VatPrc,phOMI.EValue);
      mBValue := mBValue+phOMI.BValue;
      mAValue := mAValue+(phOMI.BValue)/(1+phOMI.VatPrc/100);
      If phOMI.StkStat='N' then mDstStk := 'N';
      phOMI.Next;
    until (phOMI.Eof) or (phOMI.DocNum<>DocNum);
  end;
  phOMI.RestoreIndex;
  // Ulozime vypocitane hodnoty do hlavicky dokladu
  Edit;
  CValue := mCValue[0];
  CValue1 := mCValue[1];
  CValue2 := mCValue[2];
  CValue3 := mCValue[3];
  CValue4 := mCValue[4];
  CValue5 := mCValue[5];
  VatVal := mEValue[0]-mCValue[0];
  //VatVal1 := mEValue[1]-mCValue[1];
  //VatVal2 := mEValue[2]-mCValue[2];
  //VatVal3 := mEValue[3]-mCValue[3];
  EValue := mEValue[0];
  EValue1 := mEValue[1];
  EValue2 := mEValue[2];
  EValue3 := mEValue[3];
  EValue4 := mEValue[4];
  EValue5 := mEValue[5];
  AValue := Rd2(mAValue);
  BValue := Rd2(mBValue);
  DstStk := mDstStk;
  ItmQnt := mItmQnt;
  Post;
  FreeAndNil (mCValue);  FreeAndNil (mEValue);
end;

end.
