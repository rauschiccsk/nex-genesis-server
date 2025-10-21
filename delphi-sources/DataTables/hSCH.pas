unit hSCH;

interface

uses
  IcVariab, IcTypes, IcConv, IcTools, IcValue, NexPath, NexGlob, NexText, NexIni, bSCH, hSCI, DocHand,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TSchHnd = class (TSchBtr)
  private
  public
    function NextSerNum(pYear:Str2):longint; // Najde nasledujuce volne cislo dokladu
    function GenDocNum (pYear:Str2;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
    function GetVatPrc(pVatGrp:byte):byte; // Vráti percentuálnu sadzbu DPH zadanej daòovej skupiny
    function GetBokNum:Str5; // Cislo otvorenej knihy

    procedure Del(pDocNum:Str12);
    procedure Res(pYear:Str2;pSerNum:longint); // Zarezervuje doklad so zadanym poradovym cislom
    procedure Clc(phSCI:TSciHnd);
    procedure Insert; overload;

    property BokNum:Str5 read GetBokNum;
    property VatPrc[pVatGrp:byte]:byte read GetVatPrc;
  published
  end;

implementation

function TSchHnd.NextSerNum; // Najde nasledujuce volne cislo dokladu
begin
  Result := GetDocNextYearSerNum(BtrTable,pYear);
end;

function TSchHnd.GenDocNum (pYear:Str2;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
begin
  Result := GenScDocNum(pYear,BtrTable.BookNum,pSerNum);
end;

function TSchHnd.GetVatPrc(pVatGrp:byte):byte; // Vráti percentuálnu sadzbu DPH zadanej daòovej skupiny
begin
  Result := 0;
  case pVatGrp of
    1: Result := VatPrc1;
    2: Result := VatPrc2;
    3: Result := VatPrc3;
  end;
end;

function TSchHnd.GetBokNum:Str5; // Cislo otvorenej knihy
begin
  Result := BtrTable.BookNum;
end;

procedure TSchHnd.Del(pDocNum:Str12);
begin
  If LocateDocNum(pDocNum) then Delete;
end;

procedure TSchHnd.Res(pYear:Str2;pSerNum:longint); // Zarezervuje zdoklad so zadanym poradovym cislom
begin
  Insert;
  SerNum := pSerNum;
  Year := pYear;
  DocNum := GenDocNum(pYear,pSerNum);
  DocDate := Date;
  DstLck := 9;
  PaName := gNt.GetSecText('STATUS','Reserve','Rezervovane pre: ')+gvSys.LoginName;
  Post;
end;

procedure TSchHnd.Clc(phSCI:TSciHnd);
var mAcCValue,mAcAValue,mAcBValue,mFgDValue,mFgHValue,mFgMValue,mFgWValue,mFgGrtVal,mFgAftVal:double;
    mFgAValue,mFgBValue:TValue8;  mAgiQnt,mGgiQnt,mAgsQnt,mGgsQnt:longint;  I:byte;
begin
  mAgiQnt := 0;    mGgiQnt := 0;    mAgsQnt := 0;    mGgsQnt := 0;
  mAcCValue := 0;  mAcAValue := 0;  mAcBValue := 0;
  mFgDValue := 0;  mFgHValue := 0;  mFgMValue := 0;  mFgWValue := 0;
  mFgGrtVal := 0;  mFgAftVal := 0;
  mFgAValue := TValue8.Create;  mFgAValue.Clear;
  mFgBValue := TValue8.Create;  mFgBValue.Clear;
  For I:=1 to 3 do begin 
    mFgAValue.VatPrc[I] := VatPrc[I];
    mFgBValue.VatPrc[I] := VatPrc[I];
  end;
  // Spocitame pouzity material
  phSCI.SwapIndex;
  If phSCI.LocateDocNum (DocNum) then begin
    Repeat
      If phSCI.GrtType='Z' then begin
        Inc(mGgiQnt);
        mFgGrtVal := mFgGrtVal+phSCI.FgBValue;
      end
      else begin
        Inc(mAgiQnt);
        mFgAftVal := mFgAftVal+phSCI.FgBValue;
      end;
      If phSCI.ItType='M'
        then mFgMValue := mFgMValue+phSCI.FgBValue
        else mFgWValue := mFgWValue+phSCI.FgBValue;
      mAcCValue := mAcAValue+phSCI.AcCValue;
      mAcAValue := mAcAValue+phSCI.AcAValue;
      mAcBValue := mAcBValue+phSCI.AcBValue;
      mFgDValue := mFgDValue+phSCI.FgDValue;
      mFgHValue := mFgHValue+phSCI.FgHValue;
      mFgAValue.Add (phSCI.VatPrc,phSCI.FgAValue);
      mFgBValue.Add (phSCI.VatPrc,phSCI.FgBValue);
      phSCI.Next;
    until (phSCI.Eof) or (phSCI.DocNum<>DocNum);
  end;
  phSCI.RestoreIndex;
  // Ulozime vyphSCItane hodnoty do hlavicky objednavky
  Edit;
  AcCValue := Rd2(mAcCValue);
  AcAValue := Rd2(mAcAValue);
  AcVatVal := Rd2(mAcBValue-mAcAValue);
  AcBValue := Rd2(mAcBValue);
  FgDValue := Rd2(mFgDValue);
  FgHValue := Rd2(mFgHValue);
  FgDscVal := Rd2(mFgDValue-mFgAValue[0]);
  FgHscVal := Rd2(mFgHValue-mFgBValue[0]);
  FgAValue := Rd2(mFgAValue.Value[0]);
  FgVatVal := Rd2(mFgBValue.Value[0]-mFgAValue.Value[0]);
  FgBValue := Rd2(mFgBValue.Value[0]);
  FgAValue1 := Rd2(mFgAValue.Value[1]);
  FgAValue2 := Rd2(mFgAValue.Value[2]);
  FgAValue3 := Rd2(mFgAValue.Value[3]);
  FgBValue1 := Rd2(mFgBValue.Value[1]);
  FgBValue2 := Rd2(mFgBValue.Value[2]);
  FgBValue3 := Rd2(mFgBValue.Value[3]);
  FgMValue := Rd2(mFgMValue);
  FgWValue := Rd2(mFgWValue);
  FgGrtVal := Rd2(mFgGrtVal);
  FgAftVal := Rd2(mFgBValue.Value[0]-mFgGrtVal);
  FgEndVal := Rd2(FgAftVal-FgAdvVal);
  If IsNotNul (FgDValue)
    then DscPrc := Rd2 ((FgDscVal/FgDValue)*100)
    else DscPrc := 0;
  AgiQnt := mAgiQnt;
  GgiQnt := mGgiQnt;
  AgsQnt := mAgsQnt;
  GgsQnt := mGgsQnt;
  Post;
  FreeAndNil (mFgAValue);
  FreeAndNil (mFgBValue);
end;

procedure TSchHnd.Insert;
begin
  inherited ;
  VatPrc1 := gIni.GetVatPrc(1);
  VatPrc2 := gIni.GetVatPrc(2);
  VatPrc3 := gIni.GetVatPrc(3);
end;

end.
