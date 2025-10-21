unit hTSI;

interface

uses
  IcTypes, IcTools, NexPath, NexGlob, bTSI,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs, Forms;

type
  TTsiHnd = class (TTsiBtr)
  private
  public
    function FreeItmNum(pDocNum:Str12):word;
    function NextItmNum(pDocNum:Str12):word;
    procedure SetAcCPrice(pAcCPrice,pFgCourse:double); // Zadáme jednotkovú cenu a ostatné hodnoty vypoèíta
    procedure SetFgCPrice(pFgCPrice,pFgCourse:double); // Zadáme jednotkovú cenu a ostatné hodnoty vypoèíta
    procedure SetFgCValue(pFgCValue,pFgCourse:double); // Zadáme hodnotu bez DPH a ostatné hodnoty vypoèíta
    procedure SetFgEValue(pFgEValue,pFgCourse:double); // Zadáme hodnotu s DPH a ostatné hodnoty vypoèíta
    procedure Del(pDocNum:Str12);
  published
  end;

implementation

function TTsiHnd.FreeItmNum(pDocNum:Str12):word;
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

function TTsiHnd.NextItmNum(pDocNum:Str12):word;
begin
  If not NearestDoIt(pDocNum,65000) then Last;
  If not IsLastRec or (DocNum<>pDocNum) then Prior;
  If DocNum=pDocNum
    then Result := ItmNum+1
    else Result := 1;
end;

procedure TTsiHnd.SetAcCPrice (pAcCPrice,pFgCourse:double); // Zadáme jednotkovú cenu a ostatné hodnoty vypoèíta
begin
  If pFgCourse=0 then pFgCourse := 1;
  AcSPrice := pAcCPrice;
  AcCValue := RoundCValue(pAcCPrice*GsQnt);
  AcDValue := AcCValue;
  AcSValue := AcCValue;
  AcEValue := RoundCValue(AcCValue*(1+VatPrc/100));
  If (pFgCourse=1) then begin
    FgDValue := AcDValue;
    FgCValue := AcCValue;
    FgEValue := AcEValue;
  end
  else begin
    FgDValue := RoundCValue(AcDValue/pFgCourse);
    FgCValue := RoundCValue(AcCValue/pFgCourse);
    FgEValue := RoundCValue(AcEValue/pFgCourse);
  end;
  If IsNotNul(GsQnt) then begin
    FgCPrice := RoundCPrice(FgCValue/GsQnt);
    FgDPrice := RoundCPrice(FgDValue/GsQnt);
    FgEPrice := RoundCPrice(FgEValue/GsQnt);
  end;
end;

procedure TTsiHnd.SetFgCPrice (pFgCPrice,pFgCourse:double); // Zadáme jednotkovú cenu a ostatné hodnoty vypoèíta
begin
  If pFgCourse=0 then pFgCourse := 1;
  FgCPrice := pFgCPrice;
  FgCValue := RoundCValue(pFgCPrice*GsQnt);
  FgDValue := FgCValue;
  FgEValue := RoundCValue(FgCValue*(1+VatPrc/100));
  If IsNotNul(GsQnt) then begin
    FgDPrice := RoundCPrice(FgDValue/GsQnt);
    FgEPrice := RoundCPrice(FgEValue/GsQnt);
  end;
  If (pFgCourse=1) then begin
    AcSPrice := FgCPrice;
    AcCValue := FgCValue;
    AcSValue := FgCValue;
    AcDValue := FgDValue;
    AcEValue := FgEValue;
  end
  else begin
    AcCValue := RoundCValue(FgCValue*pFgCourse);
    AcSValue := FgCValue;
    AcDValue := RoundCValue(FgDValue*pFgCourse);
    AcEValue := RoundCValue(FgEValue*pFgCourse);
    If IsNotNul(GsQnt) then AcSPrice := RoundCPrice(AcSValue/GsQnt);
  end;
end;

procedure TTsiHnd.SetFgCValue(pFgCValue,pFgCourse:double); // Zadáme hodnotu bez DPH a ostatné hodnoty vypoèíta
begin
  If pFgCourse=0 then pFgCourse := 1;
  FgCValue := pFgCValue;
  FgDValue := pFgCValue;
  FgEValue := RoundCValue(FgCValue*(1+VatPrc/100));
  If IsNotNul(GsQnt) then begin
    FgCPrice := RoundCPrice(FgCValue/GsQnt);
    FgDPrice := RoundCPrice(FgDValue/GsQnt);
    FgEPrice := RoundCPrice(FgEValue/GsQnt);
  end;
  If (pFgCourse=1) then begin
    AcSPrice := FgCPrice;
    AcCValue := FgCValue;
    AcSValue := FgCValue;
    AcDValue := FgDValue;
    AcEValue := FgEValue;
  end
  else begin
    AcCValue := RoundCValue(FgCValue*pFgCourse);
    AcSValue := FgCValue;
    AcDValue := RoundCValue(FgDValue*pFgCourse);
    AcEValue := RoundCValue(FgEValue*pFgCourse);
    If IsNotNul(GsQnt) then AcSPrice := RoundCPrice(AcSValue/GsQnt);
  end;
end;

procedure TTsiHnd.SetFgEValue(pFgEValue,pFgCourse:double); // Zadáme hodnotu s DPH a ostatné hodnoty vypoèíta
begin
  If pFgCourse=0 then pFgCourse := 1;
  FgEValue := pFgEValue;
  FgCValue := RoundCValue(FgEValue/(1+VatPrc/100));
  FgDValue := FgCValue/(1-DscPrc/100);
  FgDscVal := FgDValue-FgCValue;
  If IsNotNul(GsQnt) then begin
    FgCPrice := RoundCPrice(FgCValue/GsQnt);
    FgDPrice := RoundCPrice(FgDValue/GsQnt);
    FgEPrice := RoundCPrice(FgEValue/GsQnt);
  end;
  If (pFgCourse=1) then begin
    AcSPrice := FgCPrice;
    AcCValue := FgCValue;
    AcDValue := FgDValue;
    AcEValue := FgEValue;
    AcSValue := FgCValue+AcZValue+AcTValue+AcOValue;
  end
  else begin
    AcCValue := RoundCValue(FgCValue*pFgCourse);
    AcDValue := RoundCValue(FgDValue*pFgCourse);
    AcEValue := RoundCValue(FgEValue*pFgCourse);
    AcSValue := RoundCValue(FgCValue*pFgCourse)+AcZValue+AcTValue+AcOValue;
  end;
  If IsNotNul(GsQnt) then AcSPrice := RoundCPrice(AcSValue/GsQnt);
  AcDscVal := AcDValue-AcCValue;
end;

procedure TTsiHnd.Del(pDocNum:Str12);
begin
  While LocateDocNum(pDocNum) do begin
    Delete;
    Application.ProcessMessages;
  end;
end;

end.
