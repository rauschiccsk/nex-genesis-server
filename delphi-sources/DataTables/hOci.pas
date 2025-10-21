unit hOCI;
// OCI.BDF
interface

uses
  IcTypes, IcTools, NexPath, NexGlob, SavClc, bOCI,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs, Forms;

type
  TOciHnd = class (TOciBtr)
    function LasItmNum (pDocNum:Str12):word;
  private
    procedure SetSav(pSav:TSavClc);
  public
    function FgHPrice:double;

    procedure Post; overload;
    procedure Del(pDocNum:Str12);
    procedure SetFgHPrice(pFgHPrice, pFgCourse, pDscPrc: double); // Zadáme jednotkovú cenu a ostatné hodnoty vypoèíta
    procedure SetFgDPrice(pFgDPrice, pFgCourse, pDscPrc: double); // Zadáme jednotkovú cenu a ostatné hodnoty vypoèíta
    procedure SetFgCPrice(pFgCPrice, pFgCourse: double); // Zadáme jednotkovú nakupnu cenu a ostatné hodnoty vypoèíta
    procedure SetAcCPrice(pAcCPrice, pFgCourse: double); // Zadáme jednotkovú nakupnu cenu a ostatné hodnoty vypoèíta
  published
  end;

implementation
uses DM_Stkdat;

procedure TOciHnd.SetSav(pSav:TSavClc);
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

function TOciHnd.LasItmNum(pDocNum:Str12):word;
begin
  Result:=0;
  SwapStatus;
  SetIndex(ixDoIt);
  If LocateDocNum(pDocNum) then begin
    Repeat
      If ItmNum>Result then Result:=ItmNum;
      Next;
    until Eof or (DocNum<>DocNum)
  end;
  RestoreStatus;
end;

function TociHnd.FgHPrice:double;
begin
  Result := FgDPrice*(1+VatPrc/100);
end;

procedure TociHnd.Post;
begin
  If IsNul(OrdQnt-DlvQnt) or (OrdQnt<=DlvQnt) then StkStat := 'S';
  If (WriNum=0) and (StkNum>0)then begin
    If not dmStk.btSTKLST.Active then dmStk.btSTKLST.Open;
    dmStk.btSTKLST.SwapIndex;
    dmStk.btSTKLST.Indexname:='StkNum';
    If dmStk.btSTKLST.FindKey([StkNum]) then WriNum:=dmStk.btSTKLST.FieldByName('WriNum').AsInteger;
    dmStk.btSTKLST.RestoreIndex;
  end;
  inherited ;
end;

procedure TOciHnd.Del(pDocNum:Str12);
begin
  While LocateDocNum(pDocNum) do begin
    Delete;
    Application.ProcessMessages;
  end;
end;

procedure TOciHnd.SetFgHPrice(pFgHPrice,pFgCourse,pDscPrc:double); // Zadáme jednotkovú cenu a ostatné hodnoty vypoèíta
var mSav:TSavClc;
begin
  mSav:=TSavClc.Create;
  mSav.GsQnt:=OrdQnt;
  mSav.VatPrc:=VatPrc;
  mSav.DscPrc:=pDscPrc;
  mSav.FgCourse:=pFgCourse;
  mSav.FgHPrice:=pFgHPrice;
  SetSav(mSav);
  FreeAndNil (mSav);
end;

procedure TOciHnd.SetFgDPrice(pFgDPrice, pFgCourse, pDscPrc: double);
var mSav:TSavClc;
begin
  mSav := TSavClc.Create;
  mSav.GsQnt := OrdQnt;
  mSav.VatPrc := VatPrc;
  mSav.DscPrc := pDscPrc;
  mSav.FgCourse := pFgCourse;
  mSav.FgDPrice := pFgDPrice;
  SetSav(mSav);
  FreeAndNil (mSav);
end;

procedure TOciHnd.SetFgCPrice(pFgCPrice, pFgCourse: double); // Zadáme jednotkovú nakupnu cenu a ostatné hodnoty vypoèíta
begin
  FgCPrice:=RoundCPrice(pFgCPrice);
  FgCValue:=RoundCValue(FgCPrice*OrdQnt);
  AcCValue:=ClcAcFromFgS(FgCValue,pFgCourse);
end;

procedure TOciHnd.SetAcCPrice(pAcCPrice, pFgCourse: double);
begin
  AcCValue:=RoundCValue(pAcCPrice*OrdQnt);
  FgCValue:=ClcFgFromAcS(AcCValue,pFgCourse);
  If OrdQnt<>0 then FgCPrice:=RoundCPrice(FgCValue/OrdQnt) else FgCPrice:=RoundCPrice(FgCValue);
end;

end.
