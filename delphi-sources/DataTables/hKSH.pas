unit hKSH;

interface

uses
  IcTypes, IcConv, IcVariab, IcTools, NexPath, NexIni, NexGlob, NexText, bKSH, hKSI, DocHand,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TKshHnd = class (TKshBtr)
  private
  public
    function GenDocNum (pYear:Str2;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
    function GetVatPrc(pVatGrp:byte):byte; // Vráti percentuálnu sadzbu DPH zadanej daòovej skupiny
    function GetBokNum:Str5; // Cislo otvorenej knihy

    procedure Del(pDocNum:Str12);
    procedure Res(pYear:Str2;pSerNum:longint); // Zarezervuje doklad so zadanym poradovym cislom
    procedure Clc(phKSI:TKsiHnd);
    procedure Insert; overload;

    property BokNum:Str5 read GetBokNum;
    property VatPrc[pVatGrp:byte]:byte read GetVatPrc;
  end;

implementation

uses bKSI;

function TKshHnd.GenDocNum (pYear:Str2;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
begin
  Result := DocHand.GenKsDocNum(pYear,BtrTable.BookNum,pSerNum);
end;

function TKshHnd.GetVatPrc(pVatGrp:byte):byte; // Vráti percentuálnu sadzbu DPH zadanej daòovej skupiny
begin
  Result := 0;
  case pVatGrp of
    1: Result := VatPrc1;
    2: Result := VatPrc2;
    3: Result := VatPrc3;
  end;
end;

function TKshHnd.GetBokNum:Str5; // Cislo otvorenej knihy
begin
  Result := BtrTable.BookNum;
end;

procedure TKshHnd.Del(pDocNum:Str12);
begin
  If LocateDocNum(pDocNum) then Delete;
end;

procedure TKshHnd.Res(pYear:Str2;pSerNum:longint); // Zarezervuje zdoklad so zadanym poradovym cislom
begin
  Insert;
  If pYear='' then pYear:=gvSys.ActYear2;
  Year := pYear;
  SerNum := pSerNum;
  DocNum := GenDocNum(pYear,pSerNum);
  DocDate := Date;
  DstLck := 9;
  PaName := gNt.GetSecText('STATUS','Reserve','Rezervovane pre: ')+gvSys.LoginName;
  Post;
end;

procedure TKshHnd.Clc(phKSI:TKsiHnd);
var mCValue,mEValue,mAValue,mBValue:double;  mItmQnt:longint;  mTsdNum:Str12;
begin
  mItmQnt := 0;  mTsdNum := '';
  mCValue := 0;  mEValue := 0;  mAValue := 0;  mBValue := 0;
  // Spocitame pouzity material
  phKSI.SwapIndex;
  If phKSI.LocateDocNum (DocNum) then begin
    mTsdNum := phKSI.TsdNum;
    Repeat
      Inc(mItmQnt);
      mCValue := mCValue+phKSI.CValue;
      mEValue := mEValue+phKSI.EValue;
      mAValue := mAValue+phKSI.AValue;
      mBValue := mBValue+phKSI.BValue;
      If phKSI.TsdNum='' then mTsdNum := '';
      phKSI.Next;
    until (phKSI.Eof) or (phKSI.DocNum<>DocNum);
  end;
  phKSI.RestoreIndex;
  // Ulozime vyphKSItane hodnoty do hlavicky objednavky
  Edit;
  CValue := Rd2(mCValue);
  EValue := Rd2(mEValue);
  AValue := Rd2(mAValue);
  BValue := Rd2(mBValue);
  PrfVal := Rd2(mAValue-mCValue);
  TsdNum := mTsdNum;
//  PrfPrc :=
  ItmQnt := mItmQnt;
  Post;
end;

procedure TKshHnd.Insert;
begin
  inherited ;
  VatPrc1 := gIni.GetVatPrc(1);
  VatPrc2 := gIni.GetVatPrc(2);
  VatPrc3 := gIni.GetVatPrc(3);
end;

end.
