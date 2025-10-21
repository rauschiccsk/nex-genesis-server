unit TxtWrap;
{$F+}

interface

uses
  IcTypes, IcConv, IcTools, SysUtils;

type
  TTxtWrap = class
     constructor Create;

     procedure   SetDelimiter (pDelim: Str1);
     procedure   SetSeparator (pSepar: Str1);
     procedure   SetReal (pNum: real; pLen, pFrac: byte);
     procedure   SetNum  (pNum: LongInt; pLen: byte);
     procedure   SetRealZero (pNum: real; pLen, pFrac: byte);
     procedure   SetNumZero  (pNum: LongInt; pLen: byte);
     procedure   SetText (pStr: string; pLen: byte);
     procedure   SetText2 (pStr: string; pLen: byte); //Nekontroluje, Ëi obsahuje reùazec delimiter
     procedure   SetDate (pDate:TDateTime);
     procedure   SetTime (pTime:TDateTime);

     function    GetWrapText: string;
     procedure   ClearWrap;

     private
       oWrap: string;
       oDelim: Str1;
       oSepar: Str1;
       oDateSepar: Str1;
       oDoubleComma: boolean;
       oEmptyDate: boolean;
     published
       property DateSepar:Str1 read oDateSepar write oDateSepar;
       property DoubleComma:boolean read oDoubleComma write oDoubleComma;
       property EmptyDate:boolean read oEmptyDate write oEmptyDate;
   end;

implementation

CONSTRUCTOR TTxtWrap.Create;
BEGIN
  oDelim := '˛';
  oSepar := ',';
  oWrap := '';
  oDateSepar := '';
  oEmptyDate := True;
END;


PROCEDURE TTxtWrap.SetDelimiter;
BEGIN
  oDelim := pDelim;
END;     { *** TTxtWrap.SetDelimiter *** }


PROCEDURE TTxtWrap.SetSeparator;
BEGIN
  oSepar := pSepar;
END;     { *** TTxtWrap.SetSeparator *** }


PROCEDURE TTxtWrap.SetReal;
var  mStr:string;
BEGIN
  mStr := oDelim+StrDoub(pNum,pLen,pFrac)+oDelim;
//  mStr := oDelim+FloatToStrF(pNum,pLen,pFrac)+oDelim;
  If oDoubleComma then mStr:=ReplaceStr(mStr,'.',',');
  If oWrap = ''
    then oWrap := mStr
    else oWrap := oWrap + oSepar + mStr;
END;     { *** TTxtWrap.SetReal *** }


PROCEDURE TTxtWrap.SetNum;
var  mStr:string;
BEGIN
  mStr := oDelim + StrInt (pNum, pLen) + oDelim;
  If oWrap = ''
    then oWrap := mStr
    else oWrap := oWrap + oSepar + mStr;
END;     { *** TTxtWrap.SetNum *** }


PROCEDURE TTxtWrap.SetRealZero;
var  mStr:string;
BEGIN
  mStr := StrDoub (pNum, pLen, pFrac);
  mStr := ReplaceStr (mStr, ' ', '0');
  If oDoubleComma then mStr:=ReplaceStr(mStr,'.',',');
  mStr := oDelim + mStr  + oDelim;
  If oWrap = ''
    then oWrap := mStr
    else oWrap := oWrap + oSepar + mStr;
END;     { *** TTxtWrap.SetRealZero *** }


PROCEDURE TTxtWrap.SetNumZero;
var  mStr:string;
BEGIN
  mStr := oDelim + StrIntZero (pNum, pLen) + oDelim;
  If oWrap = ''
    then oWrap := mStr
    else oWrap := oWrap + oSepar + mStr;
END;     { *** TTxtWrap.SetNumZero *** }


PROCEDURE TTxtWrap.SetText;
var  mStr:string;
BEGIN
  pStr := ReplaceStr (pStr,oSepar,'.');
  If pLen=0
    then mStr := oDelim+pStr+oDelim
    else mStr := oDelim+AlignRight(pStr,pLen)+oDelim;
  If oWrap = ''
    then oWrap := mStr
    else oWrap := oWrap + oSepar + mStr;
END;     { *** TTxtWrap.SetText *** }

PROCEDURE TTxtWrap.SetText2;
var  mStr:string;
BEGIN
  If pLen=0
    then mStr := oDelim+pStr+oDelim
    else mStr := oDelim+AlignRight(pStr,pLen)+oDelim;
  If oWrap = ''
    then oWrap := mStr
    else oWrap := oWrap + oSepar + mStr;
END;     { *** TTxtWrap.SetText2 *** }

procedure TTxtWrap.SetDate (pDate:TDAteTime);
var  mD,mM,mY: word;  mStrDate:Str10;
begin
  If oEmptyDate and (pDate=0) then SetText ('',0)
  else begin
    If oDateSepar<>'' then begin
      DecodeDate (pDate,mY,mM,mD);
      mStrDate := StrInt(mD,2)+oDateSepar+StrIntZero(mM,2)+oDateSepar+StrIntZero(mY,4);
      SetText (mStrDate,0);
    end
    else SetText (ReplaceStr(DateToStr(pDate),' ',''),0);
  end;
end;

procedure TTxtWrap.SetTime (pTime:TDateTime);
begin
  SetText (ReplaceStr(TimeToStr(pTime),' ',''),0);
end;

FUNCTION TTxtWrap.GetWrapText;
BEGIN
  Result := oWrap;
END;     { *** TTxtWrap.GetWrapText *** }


PROCEDURE TTxtWrap.ClearWrap;
BEGIN
  oWrap := '';
END;     { *** TTxtWrap.ClearWrap *** }


end.  { unit TxtWrap }