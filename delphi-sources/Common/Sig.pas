unit Sig;
{$F+}

// *****************************************************************************
//                                ELEKTRONICKY PODPIS
// K UUUUUUUU K R K M K D K NNNNNNNNNNNNNNNNNNNNNNNNNNNNN K h K m K s K
// *****************************************************************************

interface

uses
  Controls, ComCtrls, SysUtils, Classes, Forms, MxArrays;

type
  TSig = class
    constructor Create;
    destructor  Destroy;
    private
      oUser:ShortString;  // Str8
      oName:ShortString;  // Str30
      oText:ShortString;  // Str20
      oStat:byte;
      oDate:TDate;
      oTime:TTime;
      oCtrl:boolean; // TRUE ak podpis je v poriadku
      function KeyGen(pLen:byte):ShortString;
      function Decode(pText,pKey:ShortString;pLen:byte):ShortString;
      function Encode(pText,pKey:ShortString;pLen:byte):ShortString;
      function CtrlSum(pText:ShortString):longint;
      function FillStr(pText:ShortString;pLen:byte;pChar:char):ShortString;
      function Align(pText:ShortString;pLen:byte):ShortString;

      function GetSign:ShortString;   procedure SetSign(pValue:ShortString);   // Str80
    public
      property User:ShortString read oUser write oUser;
      property Name:ShortString read oName write oName;
      property Text:ShortString read oText write oText;
      property Stat:byte read oStat write oStat;
      property Date:TDate read oDate write oDate;
      property Time:TTime read oTime write oTime;
      property Sign:ShortString read GetSign write SetSign;
      property Ctrl:boolean read oCtrl;
    published
  end;

implementation

constructor TSig.Create;
begin
  Randomize;
  oUser := '';  oName := '';  oText := '';
  oStat := 0;   oDate := 0;   oTime := 0;
end;

destructor TSig.Destroy;
begin
end;

// ********************************* PRIVATE ***********************************

function TSig.KeyGen(pLen:byte):ShortString;
var I:byte;
begin
  For I:=1 to pLen do
    Result := Result+Chr(Random(9)+1);
end;

function TSig.Decode(pText,pKey:ShortString;pLen:byte):ShortString;
var mKey:ShortString; I:byte;
begin
  Result := '';
  mKey := pKey+pKey+pKey;
  pText := Align(pText,pLen);
  For I:=1 to pLen do
    Result := Result+Chr(Ord(pText[I])+Ord(mKey[I]));
end;

function TSig.Encode(pText,pKey:ShortString;pLen:byte):ShortString;
var mKey:ShortString; I:byte;  mChar:char;
begin
  Result := '';
  mKey := pKey+pKey+pKey;
  For I:=1 to pLen do begin
    mChar := Chr(Ord(pText[I])-Ord(mKey[I]));
    If mChar<>'*' then Result := Result+mChar;
  end;
end;

function TSig.CtrlSum(pText:ShortString):longint;
var mLen:byte;  mEvenSum,mOrdSum:longint; I:integer;
begin
  mLen := Length(pText);
  // Parne znaky
  I:= 0; mEvenSum := 0;
  Repeat
    Inc (I,2);
    If (I<mLen) then mEvenSum := mEvenSum+Ord(pText[I]);
  until (I>=mLen);
  // Neparne znaky
  I:= -1; mOrdSum:=0;
  Repeat
    Inc (I,2);
    If (I<mLen) then mOrdSum := mOrdSum+Ord(pText[I])*3;
  until (I>=mLen);
  Result := mEvenSum+mOrdSum;
end;

function TSig.FillStr(pText:ShortString;pLen:byte;pChar:char):ShortString;
var mCh: array [1..255] of char;  I: byte;  mText:ShortString;   mLen:longint;  mL: longint;
begin
  mL := pLen;
  mLen := Length(pText)+mL;
  FillChar(mCh,mLen,pChar);
  For I:=mL+1 to (mL+Length(pText)) do
    mCh[I] := pText[I-mL];
  mText := '';
  For I := 1 to mLen do
    mText := mText+mCh[I];
  Result := mText;
end;

function TSig.Align(pText:ShortString;pLen:byte):ShortString;
var mF:string;
begin
  If Length(pText)>=pLen
  then pText := Copy (pText,1,pLen)
  else begin
    mF := '';
    mF := FillStr(mF,pLen-Length(pText)+1,'*');
    mF := Copy (mF,1,pLen-Length (pText));
    pText := mF+pText;
  end;
  Result := pText;
end;

function TSig.GetSign:ShortString;
var mKey,mUser,mName,mText,mCtrl,mSign:ShortString;  mD,mM,mY,mH,mS,mI:word;  mYear,mMth,mDay,mHour,mMin,mSec:byte;
begin
  mKey := KeyGen(10);
  mUser := Decode(oUser,mKey,8);
  mName := Decode(oName,mKey,30);
  mText := Decode(oText,mKey,20);
  DecodeDate(oDate,mY,mM,mD);
  mYear := byte(mY-2000);
  mMth := byte(mM);
  mDay := byte(mD);
  DecodeTime(oTime,mH,mM,mS,mI);
  mHour := byte(mH);
  mMin := byte(mM);
  mSec := byte(mS);
  mSign := mKey[1]+mUser+mKey[2]+mName+mKey[3]+mText+mKey[4]+char(mYear)+mKey[5]+char(mMth)+mKey[6]+char(mDay)+mKey[7]+char(mHour)+mKey[8]+char(mMin)+mKey[9]+char(mSec)+mKey[10]+char(oStat+1);
  mCtrl := IntToStr(CtrlSum(mSign));
  Result := mSign+Decode(mCtrl,mKey,5);
end;

procedure TSig.SetSign(pValue:ShortString);
var mKey,mUser,mName,mText,mSign:ShortString;  mVery,mCtrl:longint;
begin
  mKey := pValue[1]+pValue[10]+pValue[41]+pValue[62]+pValue[64]+pValue[66]+pValue[68]+pValue[70]+pValue[72]+pValue[74];
  mCtrl := CtrlSum(copy(pValue,1,75));
  mVery := StrToInt(Encode(copy(pValue,76,5),mKey,5));
  oCtrl := mVery=mCtrl;
  If oCtrl then begin
    oUser := Encode(copy(pValue,2,8),mKey,8);
    oName := Encode(copy(pValue,11,30),mKey,30);
    oText := Encode(copy(pValue,42,20),mKey,20);
    oStat := Ord(pValue[75])-1;
    oDate := EncodeDate(Ord(pValue[63])+2000,Ord(pValue[65]),Ord(pValue[67]));
    oTime := EncodeTime(Ord(pValue[69]),Ord(pValue[71]),Ord(pValue[73]),0);
  end;
end;

// ********************************** PUBLIC ***********************************


end.


