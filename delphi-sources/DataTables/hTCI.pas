unit hTCI;

interface

uses
  IcTypes, IcTools, NexPath, NexGlob, SavClc, bTCI,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TTciHnd = class (TTciBtr)
  private
    procedure SetSav(pSav:TSavClc);
    procedure ClrVat;
  public
    function FreeItmNum(pDocNum:Str12):word;
    function NextItmNum(pDocNum:Str12):word;
    procedure SetFgBPrice (pFgBPrice,pFgCourse:double;pVatDoc:byte); // Zadáme jednotkovú cenu a ostatné hodnoty vypoèíta
    procedure SetFgAPrice (pFgAPrice,pFgCourse:double;pVatDoc:byte); // Zadáme jednotkovú cenu a ostatné hodnoty vypoèíta
    procedure Del(pDocNum:Str12);
  published
    property Sav:TSavClc write SetSav;
  end;

implementation

// ********************************* PRIVATE ***********************************

procedure TTciHnd.SetSav(pSav:TSavClc);
begin
  AcDValue := pSav.AcDValue;
//  AcHValue := pSav.AcHValue;
  AcDscVal := pSav.AcDscVal;
//  AcHscVal := pSav.AcHscVal;
  AcAValue := pSav.AcAValue;
  AcBValue := pSav.AcBValue;
  FgDPrice := pSav.FgDPrice;
//  FgHPrice := pSav.FgHPrice;
  FgAPrice := pSav.FgAPrice;
  FgBPrice := pSav.FgBPrice;
  FgDValue := pSav.FgDValue;
//  FgHValue := pSav.FgHValue;
  FgDscVal := pSav.FgDscVal;
//  FgHscVal := pSav.FgHscVal;
  FgAValue := pSav.FgAValue;
  FgBValue := pSav.FgBValue;
end;

// ********************************* PUBLIC ************************************

function TTciHnd.FreeItmNum(pDocNum:Str12):word;
var mItmNum:word;  mFind:boolean;
begin
  Result := 0;
  SwapIndex;
  If LocateDoIt(pDocNum,1) then begin
    mItmNum := 0;
    Repeat
      Inc (mItmNum);
      mFind := mItmNum<ItmNum;
      If mItmNum>ItmNum then mItmNum := ItmNum;
      Next;
    until Eof or mFind or (DocNum<>pDocNum);
    If mFind
      then Result := mItmNum
      else Result := mItmNum+1;
  end
  else Result := 1;
  RestoreIndex;
end;

function TTciHnd.NextItmNum(pDocNum:Str12):word;
begin             
  If not NearestDoIt(pDocNum,65000) then Last;
  If not IsLastRec or (DocNum<>pDocNum) then Prior;
  If DocNum=pDocNum
    then Result := ItmNum+1
    else Result := 1;
end;

procedure TTciHnd.SetFgAPrice (pFgAPrice,pFgCourse:double;pVatDoc:byte); // Zadáme jednotkovú cenu a ostatné hodnoty vypoèíta
var mSav:TSavClc;
begin
  mSav := TSavClc.Create;
  mSav.GsQnt := GsQnt;
  mSav.VatPrc := VatPrc;
  If pVatDoc=0 then begin
    VatPrc:=0;
    mSav.VatPrc := VatPrc;
  end;
  mSav.DscPrc := DscPrc;
  mSav.FgCourse := pFgCourse;
  mSav.FgAPrice := pFgAPrice;
  SetSav(mSav);
  FreeAndNil (mSav);
end;

procedure TTciHnd.SetFgBPrice (pFgBPrice,pFgCourse:double;pVatDoc:byte); // Zadáme jednotkovú cenu a ostatné hodnoty vypoèíta
var mSav:TSavClc;
begin
  mSav := TSavClc.Create;
  mSav.GsQnt := GsQnt;
  mSav.VatPrc := VatPrc;
  mSav.DscPrc := DscPrc;
  mSav.FgCourse := pFgCourse;
  mSav.FgBPrice := pFgBPrice;
  SetSav(mSav);
  If pVatDoc=0 then ClrVat;
  FreeAndNil (mSav);
end;

procedure TTciHnd.Del(pDocNum:Str12);
begin
  While LocateDocNum(pDocNum) do begin
    Delete;
    Application.ProcessMessages;
  end;
end;

procedure TTciHnd.ClrVat;
begin
  VatPrc:=0;
  AcBValue := AcAValue;
  FgBPrice := FgAPrice;
  FgBValue := FgAValue;
end;

end.
{MOD 1905003}

