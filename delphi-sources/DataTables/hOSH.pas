unit hOSH;

interface

uses
  IcTypes, IcTools, IcConv, NexPath, NexGlob, bOSH, hOsi, DocHand,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;


type
  TOshHnd = class (TOshBtr)
  private
  public
    function GenDocNum (pYear:Str2;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
    procedure Del(pDocNum:Str12);
    procedure Clc(phOSI:TOsiHnd);   // Prepocita hlavicku podla jeho poloziek
  published
  end;

implementation

function TOshHnd.GenDocNum (pYear:Str2;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
begin
  Result := GenOsDocNum(pYear,BtrTable.BookNum,pSerNum);
end;

procedure TOshHnd.Del(pDocNum:Str12);
begin
  If LocateDocNum(pDocNum) then Delete;
end;

procedure TOshHnd.Clc(phOSI:TOsiHnd);   // Prepocita hlavicku podla jeho poloziek
var mItmQnt,mCntReq,mCntOrd,mCntRes,mCntPrp,mCntRat,mCntTrm,mCntOut,mCntErr:longint;
    mAcAValue,mAcBValue,mAcCValue,mAcEValue,mAcDValue,mAcDscVal,
    mFgCValue,mFgEValue,mFgDValue,mFgDscVal,mVolume,mWeight:double;
    I:byte;
begin
  // OSH.BDF OSI.BDF
  mItmQnt := 0;  mCntOrd := 0;  mCntReq := 0;  mCntRes := 0;
  mCntPrp := 0;  mCntRat := 0;  mCntTrm := 0;  mCntOut := 0;  mCntErr := 0;
  mAcCValue := 0;  mAcDValue := 0;  mAcEValue := 0;  mAcAValue := 0;  mAcBValue := 0;
  mFgCValue := 0;  mFgDValue := 0;  mFgEValue := 0;  mFgDscVal := 0;  mAcDscVal := 0;
  mVolume   := 0;  mWeight   := 0;
  phOSI.SwapIndex;
  If phOSI.LocateDocNum(DocNum) then begin
    Repeat
      Inc (mItmQnt);
      mAcCValue := mAcCValue+phOSI.AcCValue;
      mAcDValue := mAcDValue+phOSI.AcDValue;
      mAcEValue := mAcEValue+phOSI.AcEValue;
      mAcDscVal := mAcDscVal+phOSI.AcDscVal;
      mFgCValue := mFgCValue+phOSI.FgCValue;
      mFgEValue := mFgEValue+phOSI.FgEValue;
      mFgDValue := mFgDValue+phOSI.FgDValue;
      mFgDscVal := mFgDscVal+phOSI.FgDscVal;
      mAcAValue := mAcAValue+phOSI.AcAValue;
      mAcBValue := mAcBValue+phOSI.AcBValue;
      mVolume   := mVolume+phOSI.Volume;
      mWeight   := mWeight+phOSI.Weight;
      If (phOSI.DlvDate>0) then Inc (mCntTrm);
      If phOSI.StkStat='N' then Inc (mCntReq);
      If phOSI.StkStat='O' then Inc (mCntOrd);
      If phOSI.StkStat='R' then Inc (mCntRes);
      If phOSI.StkStat='P' then Inc (mCntPrp);
      If phOSI.StkStat='S' then Inc (mCntOut);
      If phOSI.StkStat='E' then Inc (mCntErr);
      phOSI.Next;
    until (phOSI.Eof) or (phOSI.DocNum<>DocNum);
  end;
  phOSI.RestoreIndex;
  // Ulozime vypocitane hodnoty do hlavicky objednavky
  Edit;
  If FgCourse=1 then begin
    If IsNotNul (mAcDValue)
      then DscPrc := Rd2 ((mAcDscVal/mAcDValue)*100)
      else DscPrc := 0;
  end
  else begin
    If IsNotNul (mFgDValue)
      then DscPrc := Rd2 ((mFgDscVal/mFgDValue)*100)
      else DscPrc := 0;
  end;
  AcDValue := mAcDValue;
  AcCValue := mAcCValue;
  AcEValue := mAcEValue;
  AcVatVal := mAcEValue-mAcCValue;
  AcDscVal := mAcDscVal;
  AcAValue := mAcAValue;
  AcBValue := mAcBValue;
  FgCValue := mFgCValue;
  FgEValue := mFgEValue;
  FgDValue := mFgDValue;
  FgDscVal := mFgDscVal;
  AcDscVal := mAcDscVal;
  Volume   := mVolume;
  Weight   := mWeight;
  ItmQnt   := mItmQnt;
  Post;
end;

end.
