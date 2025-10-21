unit hISH;

interface

uses
  IcTypes, IcConv, IcValue, IcTools, NexPath, NexGlob, NexIni, bISH, hISI, DocHand,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TIshHnd = class (TIshBtr)
  private
  public
    function NextSerNum(pYear:Str2):longint; // Najde nasledujuce volne cislo dokladu
    function GenDocNum (pYear:Str2;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
    function GetVatPrc(pVatGrp:byte):byte; // Vráti percentuálnu sadzbu DPH zadanej daòovej skupiny
    procedure Insert; overload;
    procedure Del(pDocNum:Str12);
    procedure Clc(phISI:TIsiHnd);

    property VatPrc[pVatGrp:byte]:byte read GetVatPrc;
  published
  end;

implementation

function TIshHnd.NextSerNum; // Najde nasledujuce volne cislo dokladu
begin
  Result := GetDocNextYearSerNum(BtrTable,pYear);
end;

function TIshHnd.GenDocNum (pYear:Str2;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
begin
  Result := GenIsDocNum(pYear,BtrTable.BookNum,pSerNum);
end;

function TIshHnd.GetVatPrc(pVatGrp:byte):byte; // Vráti percentuálnu sadzbu DPH zadanej daòovej skupiny
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

procedure TIshHnd.Insert;
begin
  inherited ;
  VatPrc1 := gIni.GetVatPrc(1);
  VatPrc2 := gIni.GetVatPrc(2);
  VatPrc3 := gIni.GetVatPrc(3);
  VatPrc4 := gIni.GetVatPrc(4);
  VatPrc5 := gIni.GetVatPrc(5);
end;

procedure TIshHnd.Del(pDocNum:Str12);
begin
  If LocateDocNum(pDocNum) then Delete;
end;

procedure TIshHnd.Clc(phISI:TIsiHnd);
var mItmQnt:longint;   mDstPair:Str1;  mTsdNum:Str15;   I:byte;
    mAcDValue,mAcDscVal,mAcAValue,mAcBValue,mFgDValue,mFgDscVal:double;
    mAcCValue,mAcEValue,mFgCValue,mFgEValue:TValue8;   mSrvMgc:longint;
    mRAcCValue,mRAcEValue,mRFgCValue,mRFgEValue:TValue8;
begin
  mItmQnt := 0;    mTsdNum := '';   mFgDValue := 0;  mFgDscVal := 0;
  mAcDValue := 0;  mAcDscVal := 0;  mAcAValue := 0;  mAcBValue := 0;
  mAcCValue := TValue8.Create;  mAcCValue.Clear;
  mAcEValue := TValue8.Create;  mAcEValue.Clear;
  mFgCValue := TValue8.Create;  mFgCValue.Clear;
  mFgEValue := TValue8.Create;  mFgEValue.Clear;
  mRAcCValue := TValue8.Create;  mRAcCValue.Clear;
  mRAcEValue := TValue8.Create;  mRAcEValue.Clear;
  mRFgCValue := TValue8.Create;  mRFgCValue.Clear;
  mRFgEValue := TValue8.Create;  mRFgEValue.Clear;
  For I:=1 to 5 do begin
    mAcCValue.VatPrc[I] := VatPrc[I]; mRAcCValue.VatPrc[I] := VatPrc[I];
    mAcEValue.VatPrc[I] := VatPrc[I]; mRAcEValue.VatPrc[I] := VatPrc[I];
    mFgCValue.VatPrc[I] := VatPrc[I]; mRFgCValue.VatPrc[I] := VatPrc[I];
    mFgEValue.VatPrc[I] := VatPrc[I]; mRFgEValue.VatPrc[I] := VatPrc[I];
  end;
  mDstPair := 'N';
  mSrvMgc := gIni.GetServiceMg;
  phISI.SwapIndex;
  If phISI.LocateDocNum (DocNum) then begin
    mDstPair := 'Q';
    Repeat
      Inc (mItmQnt);
      mAcDValue := mAcDValue+phISI.AcDValue;
      mAcDscVal := mAcDscVal+phISI.AcDscVal;
      mAcAValue := mAcAValue+phISI.AcAValue;
      mAcBValue := mAcBValue+phISI.AcBValue;
      mFgDValue := mFgDValue+phISI.FgDValue;
      mFgDscVal := mFgDscVal+phISI.FgDscVal;
      If pHISI.GsCode=90100 then begin
        mRAcCValue.Add (phISI.VatPrc,phISI.AcCValue);
        mRAcEValue.Add (phISI.VatPrc,phISI.AcEValue);
        mRFgCValue.Add (phISI.VatPrc,phISI.FgCValue);
        mRFgEValue.Add (phISI.VatPrc,phISI.FgEValue);
      end else begin
        mAcCValue.Add (phISI.VatPrc,phISI.AcCValue);
        mAcEValue.Add (phISI.VatPrc,phISI.AcEValue);
        mFgCValue.Add (phISI.VatPrc,phISI.FgCValue);
        mFgEValue.Add (phISI.VatPrc,phISI.FgEValue);
      end;
      If (phISI.MgCode<mSrvMgc) and ((phISI.Status='N') or (phISI.Status='')) then mDstPair := 'N';
      If mTsdNum='' then mTsdNum := phISI.TsdNum;
      phISI.Next;
    until (phISI.Eof) or (phISI.DocNum<>DocNum);
  end;
  phISI.RestoreIndex;
  // Ulozime vypocitane hodnoty do hlavicky objednavky
  Edit;
  If FgCourse=1 then begin
    If IsNotNul(mAcDValue)
      then DscPrc := Rd2 ((mAcDscVal/(mAcDValue))*100)
      else DscPrc := 0;
  end
  else begin
    If IsNotNul (mFgDValue)
      then DscPrc := Rd2 ((mFgDscVal/(mFgDValue))*100)
      else DscPrc := 0;
  end;
  DocClcRnd(mAcCValue,mAcEValue,mFgCValue,mFgEValue,IsNotNul(VatDoc));
  AcDValue  := mAcDValue;
  AcDscVal  := mAcDscVal;
  AcAValue  := mAcAValue;
  AcBValue  := mAcBValue;
  AcVatVal  := mAcEValue.Value[0]-mAcCValue.Value[0]+mRAcEValue.Value[0]-mRAcCValue.Value[0];
  AcCValue  := mAcCValue.Value[0]+mRAcCValue.Value[0];
  AcEValue  := mAcEValue.Value[0]+mRAcEValue.Value[0];
  AcCValue1 := mAcCValue.Value[1]+mRAcCValue.Value[1];
  AcCValue2 := mAcCValue.Value[2]+mRAcCValue.Value[2];
  AcCValue3 := mAcCValue.Value[3]+mRAcCValue.Value[3];
  AcCValue4 := mAcCValue.Value[4]+mRAcCValue.Value[4];
  AcCValue5 := mAcCValue.Value[5]+mRAcCValue.Value[5];

  AcEValue1 := mAcEValue.Value[1]+mRAcEValue.Value[1];
  AcEValue2 := mAcEValue.Value[2]+mRAcEValue.Value[2];
  AcEValue3 := mAcEValue.Value[3]+mRAcEValue.Value[3];
  AcEValue4 := mAcEValue.Value[4]+mRAcEValue.Value[4];
  AcEValue5 := mAcEValue.Value[5]+mRAcEValue.Value[5];

  AcEndVal  := AcEValue-EyCrdVal-AcPayVal;
  FgDValue  := mFgDValue;
  FgDscVal  := mFgDscVal;
  FgVatVal  := mFgEValue.Value[0]-mFgCValue.Value[0]+mRFgEValue.Value[0]-mRFgCValue.Value[0];
  FgCValue  := mFgCValue.Value[0]+mRFgCValue.Value[0];
  FgEValue  := mFgEValue.Value[0]+mRFgEValue.Value[0];
  FgCValue1 := mFgCValue.Value[1]+mRFgCValue.Value[1];
  FgCValue2 := mFgCValue.Value[2]+mRFgCValue.Value[2];
  FgCValue3 := mFgCValue.Value[3]+mRFgCValue.Value[3];
  FgCValue4 := mFgCValue.Value[4]+mRFgCValue.Value[4];
  FgCValue5 := mFgCValue.Value[5]+mRFgCValue.Value[5];

  FgEValue1 := mFgEValue.Value[1]+mRFgEValue.Value[1];
  FgEValue2 := mFgEValue.Value[2]+mRFgEValue.Value[2];
  FgEValue3 := mFgEValue.Value[3]+mRFgEValue.Value[3];
  FgEValue4 := mFgEValue.Value[4]+mRFgEValue.Value[4];
  FgEValue5 := mFgEValue.Value[5]+mRFgEValue.Value[5];

  FgEndVal := FgEValue-FgPayVal;
  ItmQnt := mItmQnt;
//  DstAcc := GetDstAcc(DocNum);
  DstPair := mDstPair;
  TsdNum := mTsdNum;
  Post;
  FreeAndNil (mAcCValue);    FreeAndNil (mFgCValue);
  FreeAndNil (mAcEValue);    FreeAndNil (mFgEValue);
  FreeAndNil (mRAcCValue);   FreeAndNil (mRFgCValue);
  FreeAndNil (mRAcEValue);   FreeAndNil (mRFgEValue);
end;

end.
