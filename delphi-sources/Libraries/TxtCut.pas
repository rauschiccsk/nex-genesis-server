unit TxtCut;
{$F+}

interface

uses
  {Delphi} Classes, Controls, SysUtils,
  {NEX}    IcTypes, IcConv, IcTools;

const
  cOK      = 0;
  cNotFld  = 1;
  cBadNum  = 2;
  cMaxFld  = 200;

type
  TDataRecPtr = ^DataRec;
  DataRec = array [1..cMaxFld] of record
    Beg: word;
    Len: word;
    App: boolean;
  end;

  TTxtCut = class
    constructor Create;
    destructor  Destroy;

    procedure   SetDelimiter (pDelimiter: Str1);
    procedure   SetSeparator (pSeparator: Str1);
    procedure   SetStr   (pStr: string);                  // Vlozenie retazca pre rozdelenie do poli
    procedure   SetStrCsv(pStr: string);                  // Vlozenie retazca pre rozdelenie do poli
    function    GetText  (pField: byte): string;
    function    GetNum   (pField: byte): LongInt;
    function    GetReal  (pField: byte): double;
    function    GetDate  (pField: byte): TDateTime;
    function    GetTime  (pField: byte): TDateTime;
    function    GetSpecDate(pField:byte): TDate;
    function    GetHEXDateTime (pField: byte): TDateTime;
    function    GetErr: byte;
    function    GetFldNum: byte;                          // Pocet poli retazca
    procedure   SetText  (pField: byte;pStr: string);     // Vlozenie textovej hodnoty do zadaneho pola
    procedure   SetNum   (pField: byte;pNum: LongInt);    // Vlozenie numerickej hodnoty do zadaneho pola
    procedure   SetReal  (pField: byte;pReal: double);    // Vlozenie desatinnj hodnoty do zadaneho pola
    procedure   SetDate  (pField: byte;pDate: TDateTime); // Vlozenie datumovej hodnoty do zadaneho pola
    procedure   SetTime  (pField: byte;pTime: TDateTime); // Vlozenie casovej hodnoty do zadaneho pola
    function    GetStr   : string;                        // Nacitanie celeho retazca

    private
      oMaxCount : byte;
      oErr      : byte;
      oDelim    : Str1;
      oSepar    : Str1;
      oStr      : string;
      oD        : TDataRecPtr;
    published
      property Count:byte read GetFldNum;
  end;

  TTxtCutLst = class
    constructor Create;
    destructor  Destroy;

    procedure   SetDelimiter (pDelimiter: Str1);
    procedure   SetSeparator (pSeparator: Str1);
    procedure   SetStr   (pStr: string);                  // Vlozenie retazca pre rozdelenie do poli
    function    GetText  (pField: byte): string;
    function    GetNum   (pField: byte): LongInt;
    function    GetReal  (pField: byte): double;
    function    GetDate  (pField: byte): TDateTime;
    function    GetTime  (pField: byte): TDateTime;
    function    GetHEXDateTime (pField: byte): TDateTime;
    function    GetFldNum: byte;                          // Pocet poli retazca
    function    GetStr   : string;                        // Nacitanie celeho retazca

    private
      oDelim    : Str1;
      oSepar    : Str1;
      oStr      : string;
      oSList    : TStringList;
    published
      property Count:byte read GetFldNum;
  end;

implementation

function ParseCSV(const S: string; ADelimiter: Char = ','; AQuoteChar: Char = '"'): TStrings;
type
  TState = (sNone, sBegin, sEnd);
var
  I: Integer;
  state: TState;
  token: string;

    procedure AddToResult;
    begin
      if (token <> '') and (token[1] = AQuoteChar) then
      begin
        Delete(token, 1, 1);
        Delete(token, Length(token), 1);
      end;
      Result.Add(token);
      token := '';
    end;

begin
  Result := TstringList.Create;
  state := sNone;
  token := '';
  I := 1;
  while I <= Length(S) do
  begin
    case state of
      sNone:
        begin
          if S[I] = ADelimiter then
          begin
            token := '';
            AddToResult;
            Inc(I);
            Continue;
          end;

          state := sBegin;
        end;
      sBegin:
        begin
          if S[I] = ADelimiter then
            if (token <> '') and (token[1] <> AQuoteChar) then
            begin
              state := sEnd;
              Continue;
            end;

          if S[I] = AQuoteChar then
            if (I = Length(S)) or (S[I + 1] = ADelimiter) then
              state := sEnd;
        end;
      sEnd:
        begin
          state := sNone;
          AddToResult;
          Inc(I);
          Continue;
        end;
    end;
    token := token + S[I];
    Inc(I);
  end;
  if token <> '' then
    AddToResult;
  if S[Length(S)] = ADelimiter then
    AddToResult
end;

CONSTRUCTOR TTxtCut.Create;
BEGIN
  New (oD);
  oErr := 0;
  oStr := '';
  oDelim := 'þ';
  oSepar := ',';
END;     { *** TTxtCut.Create *** }


DESTRUCTOR TTxtCut.Destroy;
BEGIN
  Dispose (oD);
END;     { *** TTxtCut.Destroy *** }


procedure  TTxtCut.SetDelimiter;
begin
  oDelim := pDelimiter;
end;

procedure  TTxtCut.SetSeparator;
begin
  oSepar := pSeparator;
end;

PROCEDURE  TTxtCut.SetStr;
var  I   : word;
     BCnt: byte;
     LCnt: byte;
BEGIN
  oErr := 0;
  BCnt := 0;
  LCnt := 0;
  oStr := pStr;
  If oDelim <> '' then begin
    For I := 1 to Length (oStr) do begin
      If oStr [I] = oDelim then begin
        If BCnt < cMaxFld then begin
          If BCnt = LCnt then begin
            Inc (BCnt);
            oD^[BCnt].Beg := I + 1;
          end
          else begin
            oD^[BCnt].Len := I - oD^[BCnt].Beg;
            LCnt := BCnt;
          end;
        end;
      end;
    end;
    oMaxCount := LCnt;
  end
  else begin
    oD^[1].Beg := 1;
    For I := 1 to Length (oStr) do begin
      If (oStr [I] = oSepar) or (I = Length (oStr)) then begin
        If BCnt < cMaxFld then begin
          Inc (BCnt);
          oD^[BCnt+1].Beg := I + 1;
          If I < Length (oStr)
            then oD^[BCnt].Len := I - oD^[BCnt].Beg
            else oD^[BCnt].Len := I - oD^[BCnt].Beg+1;
          LCnt := BCnt;
        end;
      end;
    end;
    If (oStr<>'') and (oStr[Length(oStr)]=oSepar) then begin
      oD^[LCnt].Len := oD^[LCnt].Len-1;
      Inc(LCnt);
    end;
    oMaxCount := LCnt;
  end;
END;     { *** TTxtCut.SetStr *** }

PROCEDURE  TTxtCut.SetStrCsv;
var  I,J : word;
     BCnt: byte;
     LCnt: byte;
     mApp: boolean;
     mSL:TStrings;
BEGIN
  oErr := 0;
  BCnt := 0;
  LCnt := 0;
  oStr:=pStr;
  mSL:=TStringList.Create;
  mSL := parsecsv(pStr,oSepar[1],'"');
  oStr:='';
  for I:=0 to mSL.Count-1 do oStr:=oStr+oSepar+oDelim+mSL[I]+oDelim;
  If oSepar<>'' then delete(oStr,1,1);
  oStr:=ReplaceStr(oStr,'""','"');
  mSL.Free;
  I:=1;
  If oStr<>'' then begin
    If oStr[1]='"'then begin
      oD^[1].App := True;
      oD^[1].Beg := 2;
      Inc(I);
    end else begin
      oD^[1].Beg := 1;
      oD^[1].App := False;
    end;
    while I<= Length (oStr) do begin
      If oD^[BCnt+1].App then begin
        while (I< Length (oStr)) and (oStr[I]<>'"') do Inc(I);
        Inc(I);
      end;
      If (oStr [I] = oSepar) or (I = Length (oStr)) then begin
        If (I = Length (oStr)) then begin
          Inc (BCnt);
          oD^[BCnt].Len := I - oD^[BCnt].Beg+1;
          If oD^[BCnt].App then oD^[BCnt].Len:=oD^[BCnt].Len-1;
          LCnt := BCnt;
        end else begin
          If BCnt < cMaxFld then begin
            Inc (BCnt);
            If oStr[I+1]='"'then begin
              oD^[BCnt+1].Beg := I + 2;
              oD^[BCnt+1].App := True;
            end else begin
              oD^[BCnt+1].Beg := I + 1;
              oD^[BCnt+1].App := False;
            end;
            If I < Length (oStr)
              then oD^[BCnt].Len := I - oD^[BCnt].Beg
              else oD^[BCnt].Len := I - oD^[BCnt].Beg+1;
            If oD^[BCnt].App then oD^[BCnt].Len:=oD^[BCnt].Len-1;
            If oD^[BCnt+1].App then begin
              Inc(I);
            end;
            LCnt := BCnt;
          end;
        end;
      end;
      Inc(I);
    end;
  end;
  If (oStr<>'') and (oStr[Length(oStr)]=oSepar) then Inc(LCnt);
  oMaxCount := LCnt;
END;     { *** TTxtCut.SetStr *** }

PROCEDURE  TTxtCut.SetText;
BEGIN
  Delete (oStr,oD^[pField].Beg,oD^[pField].Len);
  Insert (pStr,oStr,oD^[pField].Beg);
  SetStr(oStr);
END;     { *** TTxtCut.SetText *** }

PROCEDURE  TTxtCut.SetNum;
BEGIN
  SetText(pField,IntToStr(pNum));
END;     { *** TTxtCut.SetNum *** }

PROCEDURE  TTxtCut.SetReal;
BEGIN
  SetText(pField,ReplaceStr(FloatToStr(pReal),',','.'));
END;     { *** TTxtCut.SetNum *** }

PROCEDURE  TTxtCut.SetDate;
BEGIN
  SetText(pField,ReplaceStr(DateToStr(pDate),' ',''));
END;     { *** TTxtCut.SetNum *** }

PROCEDURE  TTxtCut.SetTime;
BEGIN
  SetText(pField,ReplaceStr(TimeToStr(pTime),' ',''));
END;     { *** TTxtCut.SetNum *** }

FUNCTION   TTxtCut.GetStr;
var  Txt: string;
BEGIN
  Result := oStr;
END;     { *** TTxtCut.GetText *** }

FUNCTION   TTxtCut.GetText;
var  Txt: string;
BEGIN
  oErr := 0;
  Txt := '';
  If pField <= oMaxCount then begin
    If oD^[pField].app
      then Txt := Copy (oStr, oD^[pField].Beg, oD^[pField].Len)
      else Txt := ReplaceStr (Copy (oStr, oD^[pField].Beg, oD^[pField].Len), oSepar, '');
    end else oErr := cNotFld;
  GetText := Txt;
END;     { *** TTxtCut.GetText *** }


FUNCTION   TTxtCut.GetNum;
var Num: LongInt;
    C  : integer;
BEGIN
  oErr := 0;
  Num := 0;
  If pField <= oMaxCount
    then begin
    If not oD^[pField].app
      then Val (ReplaceStr (RemRightSpaces (Copy (oStr, oD^[pField].Beg, oD^[pField].Len)), oSepar, ''), Num, C)
      else Val (RemRightSpaces (Copy (oStr, oD^[pField].Beg, oD^[pField].Len)), Num, C);
      If C <> 0 then oErr := cBadNum;
    end
    else oErr := cNotFld;
  GetNum := Num;
END;     { *** TTxtCut.GetNum *** }


FUNCTION   TTxtCut.GetReal;
var  Num  : double;
     C    : integer;
     SNum : string;
BEGIN
  oErr := 0;
  Num := 0;
  If pField <= oMaxCount
    then begin
      If not oD^[pField].app
        then SNum := ReplaceStr (RemRightSpaces (Copy (oStr, oD^[pField].Beg, oD^[pField].Len)), oSepar, '')
        else SNum := RemRightSpaces (Copy (oStr, oD^[pField].Beg, oD^[pField].Len));
      SNum := ReplaceStr (SNum,',','.');
      SNum := ReplaceStr (SNum,' ','');
      Val (SNum, Num, C);
      If C <> 0 then begin
        oErr := cBadNum;
        Num  := 0;
      end;
    end
    else oErr := cNotFld;
  GetReal := Num;
END;     { *** TTxtCut.GetReal *** }

function TTxtCut.GetDate(pField: byte): TDateTime;
var mLine:ShortString;
begin
  mLine := GetText(pField);
  If mLine<>'' then begin
    If Pos(mLine,':')>1 then mLine := ReplaceStr (mLine,' ','');
    Result := StrToDate (mLine);
  end
  else Result := 0;
end;

function TTxtCut.GetTime  (pField: byte): TDateTime;
var mLine:ShortString;
begin
  mLine := GetText(pField);
  If mLine<>'' then begin
    mLine := ReplaceStr (mLine,' ','');
    Result := StrToTime (mLine);
  end
  else Result := 0;
end;

function TTxtCut.GetSpecDate(pField:byte): TDate;
var mYear,mMonth,mDay: word; mDate:ShortString;
begin
  mDate := GetText(pField);
  If Length(mDate)=8 then begin // Format: YYYYMMDD
    mDate := GetText(pField);
    mYear := StrToInt(copy(mDate,1,4));
    mMonth := StrToInt(copy(mDate,5,2));
    mDay := StrToInt(copy(mDate,7,2));
    Result := EncodeDate(mYear,mMonth,mDay);
  end
  else Result := 0;
end;

function TTxtCut.GetHEXDateTime (pField: byte): TDateTime;
var mB:array [1..8] of byte; I:longint; mS:string;
begin
(*  Result := 0;
  mS := GetText(pField);
  If Length (mS)>=16 then begin
    For I:=0 to 7 do
      mB[I] := HEXToDec(Copy (mS,I*2+1,2));
    Move (mB, Result, 8);
  end;*)
end;

FUNCTION   TTxtCut.GetErr;
BEGIN
  GetErr := oErr;
END;     { *** TTxtCut.GetErr *** }

FUNCTION   TTxtCut.GetFldNum;
BEGIN
  GetFldNum := oMaxCount;
END;     { *** TTxtCut.GetFldNum *** }


// TTxtCutLst
CONSTRUCTOR TTxtCutLst.Create;
begin
  oStr := '';
  oDelim := 'þ';
  oSepar := ',';
  oSList := TStringList.Create;
end;     { *** TTxtCutLst.Create *** }


DESTRUCTOR TTxtCutLst.Destroy;
begin
  FreeAndNil (oSList);
end;     { *** TTxtCutLst.Destroy *** }


procedure  TTxtCutLst.SetDelimiter;
begin
  oDelim := pDelimiter;
end;

procedure  TTxtCutLst.SetSeparator;
begin
  oSepar := pSeparator;
end;

procedure  TTxtCutLst.SetStr;
var mStr:string;
begin
  oStr := pStr;
  mStr := oStr;
  If oDelim<>'' then begin
    If Copy (mStr, 1, 1)=oDelim then Delete (mStr, 1, 1);
    If Copy (mStr, Length (mStr), 1)=oDelim then Delete (mStr, Length (mStr), 1);
    mStr := ReplaceStr(mStr, oDelim+oSepar+oDelim, #13+#10);
  end else begin
    mStr := ReplaceStr(mStr, oSepar, #13+#10);
  end;
  oSList.Text := mStr;
end;

function   TTxtCutLst.GetStr;
begin
  Result := oStr;
end;

function   TTxtCutLst.GetText;
begin
  Result := '';
  If (pField>0) and (oSList.Count>=pField) then begin
    Result := RemLeftSpaces (RemRightSpaces (oSList.Strings[pField-1]));
  end;
end;

function   TTxtCutLst.GetNum;
var mNum, mErr:longint;
begin
  mNum := 0; mErr := 0;
  Val (GetText(pField), mNum, mErr);
  Result := mNum;
end;

function   TTxtCutLst.GetReal;
var mNum:double; mErr:longint; mS:string;
begin
  mNum := 0;
  mS := ReplaceStr (GetText(pField), ',', '.');
  mS := ReplaceStr (mS, ' ', '');
  Val (mS, mNum, mErr);
  Result := mNum;
end;

function TTxtCutLst.GetDate  (pField: byte): TDateTime;
var mS:string; mDate:TDateTime;
begin
  mS := ReplaceStr (GetText(pField), ' ', '');
  mDate := 0;
  If mS<>'' then begin
    try
      mDate := StrToDate (mS);
    except end;
  end;
  Result := mDate;
end;

function TTxtCutLst.GetTime  (pField: byte): TDateTime;
var mS:string; mTime:TDateTime;
begin
  mS := ReplaceStr (GetText(pField), ' ', '');
  mTime := 0;
  If mS<>'' then begin
    try
      mTime := StrToTime (mS);
    except end;
  end;
  Result := mTime;
end;

function  TTxtCutLst.GetHEXDateTime (pField: byte): TDateTime;
var mB:array [1..8] of byte; I:longint; mS:string;
begin
  Result := 0;
  mS := GetText(pField);
  If Length (mS)>=16 then begin
    For I:=0 to 7 do
      mB[I] := HEXToDec(Copy (mS,I*2+1,2));
    Move (mB, Result, 8);
  end;
end;

function   TTxtCutLst.GetFldNum;
begin
  GetFldNum := oSList.Count;
end;

end.  { unit TxtCut }