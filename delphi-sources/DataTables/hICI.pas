unit hICI;

interface

uses
  IcTypes, IcTools, NexPath, NexGlob, SavClc, Key, bICI,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TIciHnd = class (TIciBtr)
  private
    procedure SetSav(pSav:TSavClc);
  public
    function FreeItmNum(pDocNum:Str12):word;
    function NextItmNum(pDocNum:Str12):word;
    procedure SetFgBPrice (pFgBPrice,pFgCourse:double); // Zadáme jednotkovú cenu a ostatné hodnoty vypoèíta
    procedure Del(pDocNum:Str12);
    procedure AcvClc; // Prepocita UM podla VM podla kurzu
  published
    property Sav:TSavClc write SetSav;
  end;

implementation

procedure TIciHnd.SetSav(pSav:TSavClc);
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
function TIciHnd.FreeItmNum(pDocNum:Str12):word;
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

function TIciHnd.NextItmNum(pDocNum:Str12):word;
begin
  If not NearestDoIt(pDocNum,65000) then Last;
  If not IsLastRec or (DocNum<>pDocNum) then Prior;
  If DocNum=pDocNum
    then Result := ItmNum+1
    else Result := 1;
end;

procedure TIciHnd.SetFgBPrice (pFgBPrice,pFgCourse:double); // Zadáme jednotkovú cenu a ostatné hodnoty vypoèíta
var mSav:TSavClc;
begin
  mSav := TSavClc.Create;
  mSav.GsQnt := GsQnt;
  mSav.VatPrc := VatPrc;
  mSav.DscPrc := DscPrc;
  mSav.FgCourse := pFgCourse;
  mSav.FgBPrice := pFgBPrice;
  SetSav(mSav);
  FreeAndNil (mSav);
end;

procedure TIciHnd.Del(pDocNum:Str12);
begin
  While LocateDocNum(pDocNum) do begin
    Delete;
    Application.ProcessMessages;
  end;
end;

procedure TIciHnd.AcvClc; // Prepocita UM podla VM podla kurzu
begin
  AcDValue := ClcAcFromFgC(FgDValue,FgCourse);
  AcDscVal := ClcAcFromFgC(FgDscVal,FgCourse);
  AcAValue := ClcAcFromFgC(FgAValue,FgCourse);
  AcBValue := ClcAcFromFgC(FgBValue,FgCourse);
end;

end.
