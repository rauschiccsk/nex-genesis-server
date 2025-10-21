unit hPOH;

interface

uses
  IcTypes, IcVariab, IcConv, NexPath, NexGlob, NexText, Plc, bPOH, hPOI, Dochand,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TPohHnd = class (TPohBtr)
  private
  public
    procedure ResVer; // Prekontroluje ci doklad je rezervovany ak ano zrusi ho
    function NextSerNum(pYear:Str2):longint; // Najde nasledujuce volne cislo dokladu
    function GenDocNum (pYear:Str2;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu

    procedure Res(pYear:Str2;pSerNum:longint); // Zarezervuje doklad so zadanym poradovym cislom
    procedure Clc(phPOI:TPoiHnd);
  published
  end;

implementation

procedure TPohHnd.ResVer; // Prekontroluje ci doklad je rezervovany ak ano zrusi ho
begin
  If DstLck=9 then Delete;
end;

function TPohHnd.NextSerNum; // Najde nasledujuce volne cislo dokladu
begin
  Result := GetDocNextYearSerNum(BtrTable,pYear);
end;

function TPohHnd.GenDocNum (pYear:Str2;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
begin
  Result := GenPoDocNum(pYear,BtrTable.BookNum,pSerNum);
end;

procedure TPohHnd.Res(pYear:Str2;pSerNum:longint); // Zarezervuje zdoklad so zadanym poradovym cislom
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

procedure TPohHnd.Clc(phPOI:TPoiHnd);
var mItmQnt:longint;  mDValue,mHValue,mAValue,mBValue:double;  mCadNum,mOcdNum,mTcdNum,mIcdNum:Str12;
begin
  mItmQnt := 0;  mDValue := 0;  mHValue := 0;  mAValue := 0;  mBValue := 0;
  mCadNum := ''; mOcdNum := ''; mTcdNum := ''; mIcdNum := '';
  phPOI.SwapIndex;
  If phPOI.LocateDocNum (DocNum) then begin
    Repeat
      Inc (mItmQnt);
      mDValue := mDValue+phPOI.DValue;
      mHValue := mHValue+phPOI.HValue;
      mAValue := mAValue+phPOI.AValue;
      mBvalue := mBvalue+phPOI.BValue;
      If phPOI.CadNum<>'' then mCadNum := phPOI.CadNum;
      If phPOI.OcdNum<>'' then mOcdNum := phPOI.OcdNum;
      If phPOI.TcdNum<>'' then mTcdNum := phPOI.TcdNum;
      If phPOI.IcdNum<>'' then mIcdNum := phPOI.IcdNum;
      phPOI.Next;
    until (phPOI.Eof) or (phPOI.DocNum<>DocNum);
  end;
  phPOI.RestoreIndex;
  // Ulozime vypocitane hodnoty do hlavicky dokladu
  Edit;
  DValue := mDValue;
  HValue := mHValue;
  DdsVal := mDValue-mAValue;
  HdsVal := mHValue-mBvalue;
  AValue := mAValue;
  BValue := mBvalue;
  DscPrc := gPlc.ClcDscPrc(DValue,AValue);
  CadNum := mCadNum;
  OcdNum := mOcdNum;
  TcdNum := mTcdNum;
  IcdNum := mIcdNum;
  ItmQnt := mItmQnt;
  Post;
end;

end.
