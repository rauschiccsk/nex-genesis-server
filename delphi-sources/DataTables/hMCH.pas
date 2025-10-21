unit hMCH;
{MOD 18.04.002}
interface

uses
  IcTypes, IcConv, IcTools, IcValue, IcVariab, NexPath, NexIni, NexGlob, Nextext,
  DocHand, Key, bMCH, hMCI,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TMchHnd = class (TMchBtr)
  private
  public
    function GetBokNum:Str5; // Cislo otvorenej knihy
    function NextSerNum(pYear:Str2):longint; // Najde nasledujuce volne cislo dokladu
    function GenDocNum (pYear:Str2;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
    function GetVatPrc(pVatGrp:byte):byte; // Vráti percentuálnu sadzbu DPH zadanej daòovej skupiny
    procedure Insert; overload;
    procedure Del(pDocNum:Str12);
    procedure Clc(phMCI:TMciHnd);
    Function ClcFgDValue(phMCI:TMciHnd):double;
    procedure ResVer; // Prekontroluje ci doklad je rezervovany ak ano zrusi ho
    procedure Res(pYear:Str2;pSerNum:longint); // Zarezervuje doklad so zadanym poradovym cislom
    function  IsMyRes: boolean;
    function  IsRes: boolean;

    property BokNum:Str5 read GetBokNum;
    property VatPrc[pVatGrp:byte]:byte read GetVatPrc;
  published
  end;

implementation

uses bMCI;

function TMchHnd.GetBokNum:Str5; // Cislo otvorenej knihy
begin
  Result:=BtrTable.BookNum;
end;

function TMchHnd.NextSerNum; // Najde nasledujuce volne cislo dokladu
begin
  Result:=GetDocNextYearSerNum(Btrtable,pYear);
end;

function TMchHnd.GenDocNum (pYear:Str2;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
begin
  Result:=GenMcDocNum(pYear,BtrTable.BookNum,pSerNum);
end;

function TMchHnd.GetVatPrc(pVatGrp:byte):byte; // Vráti percentuálnu sadzbu DPH zadanej daòovej skupiny
begin
  Result:=0;
  case pVatGrp of
    1: Result:=VatPrc1;
    2: Result:=VatPrc2;
    3: Result:=VatPrc3;
  end;
end;

procedure TMchHnd.Insert;
begin
  inherited ;
  VatPrc1:=gIni.GetVatPrc(1);
  VatPrc2:=gIni.GetVatPrc(2);
  VatPrc3:=gIni.GetVatPrc(3);
  VatDoc:=1;
  AcDvzName:=gKey.SysAccDvz;
  FgDvzName:=AcDvzName;
  FgCourse:=1;
end;

procedure TMchHnd.Del(pDocNum:Str12);
begin
  If LocateDocNum(pDocNum) then Delete;
end;

procedure TMchHnd.Clc(phMCI:TMciHnd);
var mItmQnt:word;  mEquVal:double;  I:byte;
    mAcCValue,mAcDValue,mAcDscVal,mFgCValue,mFgDValue,mFgDscVal:double;
    mAcAValue,mAcBValue,mFgAValue,mFgBValue:TValue8;
begin
  mItmQnt:=0;    mEquVal:=0;
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
  phMCI.SwapIndex;
  If phMCI.LocateDocNum(DocNum) then begin
    Repeat
      Inc (mItmQnt);
      mAcCValue:=mAcCValue+phMCI.AcCValue;
      mAcDValue:=mAcDValue+phMCI.AcDValue;
      mAcDscVal:=mAcDscVal+phMCI.AcDscVal;
      mFgCValue:=mFgCValue+phMCI.FgCValue;
      mFgDValue:=mFgDValue+phMCI.FgDValue;
      mFgDscVal:=mFgDscVal+phMCI.FgDscVal;
      mAcAValue.Add (phMCI.VatPrc,phMCI.AcAValue);
      mAcBValue.Add (phMCI.VatPrc,phMCI.AcBValue);
      mFgAValue.Add (phMCI.VatPrc,phMCI.FgAValue);
      mFgBValue.Add (phMCI.VatPrc,phMCI.FgBValue);
      If (phMCI.OcdNum<>'') or (phMCI.TcdNum<>'') or IsNotNul(phMCI.DlvQnt) then mEquVal:=mEquVal+(phMCI.DlvQnt*phMCI.FgBPrice);
      phMCI.Next;
    until (phMCI.Eof) or (phMCI.DocNum<>DocNum);
  end;
  phMCI.RestoreIndex;
  // Ulozime vypocitane hodnoty do hlavicky objednavky
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
  AcDValue:=mAcDValue;
  AcDscVal:=mAcDscVal;
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
  FgAValue:=mFgAValue.Value[0];
  FgVatVal:=mFgBValue.Value[0]-mFgAValue.Value[0];
  FgBValue:=mFgBValue.Value[0];
  FgAValue1:=mFgAValue.Value[1];
  FgAValue2:=mFgAValue.Value[2];
  FgAValue3:=mFgAValue.Value[3];
  FgBValue1:=mFgBValue.Value[1];
  FgBValue2:=mFgBValue.Value[2];
  FgBValue3:=mFgBValue.Value[3];
  FgEndVal:=FgBValue-FgPayVal;
  AcEndVal:=AcBValue-AcPayVal;
  If IsNotNul(FgBValue) then PrfPrc:=Rd2(FgPValue/FgBValue*100);
  ProVal:=AcAValue-AcCValue;
  If IsNotNul(AcCValue) then ProPrc:=(ProVal/AcCValue*100);
  EquVal:=mEquVal;
  If IsNotNul(FgBValue) then begin
    EquPrc:=Round((mEquVal/FgBValue)*100);
    If Eq2(EquVal,FgBValue) then EquPrc:=100;
  end
  else EquPrc:=0;
  If EquPrc=100 then DstLck:=1;
  ItmQnt:=mItmQnt;
  Post;
  FreeAndNil(mAcAValue);   FreeAndNil(mFgAValue);
  FreeAndNil(mAcBValue);   FreeAndNil(mFgBValue);
end;

procedure TMchHnd.Res(pYear:Str2;pSerNum: Integer);
begin
  Insert;
  Year:=pYear;
  SerNum:=pSerNum;
  DocNum:=GenDocNum(pYear,pSerNum);
  DocDate:=Date;
  DstLck:=9;
  PaName:=gNt.GetSecText('STATUS','Reserve','Rezervovane pre: ')+gvSys.LoginName;
  Post;
end;

procedure TMchHnd.ResVer;
begin
  If DstLck=9 then Delete;
end;

function TMchHnd.ClcFgDValue(phMCI: TMciHnd):double;
begin
  Result:=0;
  phMCI.SwapIndex;
  If phMCI.LocateDocNum(DocNum) then begin
    Repeat
      Result:=Result+phMCI.FgDValue*(1+phMCI.VatPrc/100);
      phMCI.Next;
    until (phMCI.Eof) or (phMCI.DocNum<>DocNum);
  end;
  phMCI.RestoreIndex;
end;

function TMchHnd.IsMyRes: boolean;
begin
  Result:= (DstLck=9) and (CrtUser=gvSys.LoginName);
end;

function TMchHnd.IsRes: boolean;
begin
  Result:= (DstLck=9);
end;

end.
{MOD 1804002}
{MOD 1807015}
