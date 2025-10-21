unit IcDate;

interface

uses
  {IdentCode} IcTypes, IcConv, IcVariab, IcTools, FpTools,
     {Delphi} SysUtils, Controls;

  function  ValidDate (pYear,pMonth,pDay:word):boolean;
            //Prekontroluje, èi zadaný dátum je správny
  function  ValidStrDate (pDate:Str10):boolean;
            //Prekontroluje, èi zadaný dátum je správny
  function  MonthLastDay (pYear,pMonth:word):byte;
            //Vráti posledný deò zadaného mesiaca
  function  ChangeDate (pDate:TDateTime;pYear,pMonth,pDay:longint):TDateTime;
            //Zmený dátum o zadaný rok,mesiac a deò
  function  DayOfWeekSK (pDate:TDateTime):longint;
            //Funkcia vráti èíslo dòa v týždni pod¾a zadaného dátumu v slovenskom Formáte, t.j. Pondelok je prvý deò
  function  WeekOfYear (pDate:TDateTime):byte;
            //Funkcia vráti èíslo týždòa v roky pod¾a zadaného dátumu
  function  FillDate (pDate:string):string;
            //Prekontroluje správnos dátumu rôzneho fomátu a v pripade potreby doplni chybajucu cast
  function  DateEvalue (pStr,pF,pL:string;pComType:byte):boolean;
            //Funkcia vráti, èi pStr dátum v textovom tvare sa vyhovuje  pComText -te zadaným podmienkam
            //pComText môže by:
            //  cdInt     - interval, pF - je prvá hodnota, pL - je posledná hodnota
            //  cdEqual   - rovná sa hodnote pF
            //  cdLessEq  - menší alebo rovná sa  hodnote pF
            //  cdLess    - minší ako pF
            //  cdGreatEq - väèší alebo rovná sa hodnote pF
            //  cdGreat   - väèší ako pF
            //  cdNotEq   - nerovná sa honote pF

  function  YearL(pDate:TDateTime): Str4;// Hodnota funkcie je 4 miestny rok zo zadaneho datumu
  function  YearS(pDate:TDateTime): Str2; // Hodnota funkcie je 2 miestny rok zo zadaneho datumu
  function  YearSLong (pYear:integer): Str2; // Hodnota funkcie je 2 miestny rok zo zadaneho roku vo forme cisla
  function  YearSToLong (pYear:Str2): longint; // Hodnota funkcie rok zo zadaneho roku vo forme Str2
  function  Year(pDate:TDateTime): word; // Hodnota funkcie je numericky rok zo zadaneho datumu
  function  Mth(pDate:TDateTime): Str2;  // Hodnota funkcie je mesiac zo zadaneho datumu
  function  MthNum (pDate:TDateTime): byte; // Hodnota funkcie je mesiac cislo zo zadaneho datumu
  function  Day(pDate:TDateTime): Str2;  // Hodnota funkcie je den zo zadaneho datumu
  function  DayNum(pDate:TDateTime): byte;  // Hodnota funkcie je cislo dna zo zadaneho datumu
  function  SysYearL:Str4;  // Hodnota funkcie je 4 miestny aktualny rok zo systemoveho datumu
  function  SysYear:Str2;  // Hodnota funkcie je 2 miestny aktualny rok zo systemoveho datumu
  function  SysMth:Str2;  // Hodnota funkcie aktualny mesiac zo systemoveho datumu
  function  SysDay:Str2;  // Hodnota funkcie aktualny den zo systemoveho datumu
  function  NumYear(pYear:Str4): word;  // Hodnota funkcie rok pYear v numerickom formate
  function  DayMth(pDate:TDateTime): Str5;  // Hodnota funkcie je den zo zadaneho datumu

  function  FirstWeekDate (pWeek:byte;pYear:Str4): TDateTime; // Prvy den zadaneho tyzdna v zadanom roku
  function  LastWeekDate (pWeek:byte;pYear:Str4): TDateTime; // Posledny den zadaneho tyzdna v zadanom roku
  function  FirstMthDate (pMth:Str2;pYear:Str4): TDateTime; // Prvy den zadaneho mesiaca a zadaneho roka
  function  LastMthDate (pMth:Str2;pYear:Str4): TDateTime; // Posledny den zadaneho mesiaca a zadaneho roka
  function  FirstYearDate (pYear:Str4): TDateTime; // Prvy den zadaneho roka
  function  LastYearDate (pYear:Str4): TDateTime; // Posledny den zadaneho roka

  function  FirstActMthDate: TDateTime; // Prvy den aktualneho mesiaca a zadaneho roka
  function  LastActMthDate: TDateTime; // Posledny den aktualneho mesiaca a zadaneho roka
  function  FirstPrvMthDate: TDateTime; // Prvy den predchadzajuceho mesiaca a zadaneho roka
  function  LastPrvMthDate: TDateTime; // Posledny den predchadzajuceho mesiaca a zadaneho roka

  function  DateInActYear (pDate:TDateTime):boolean; // TRUE ak datum je z aktualnehor roku
  function  CurrActYearDate: TDateTime; // Aktualny datum alebo koniec roka
  function  FirstActYearDate: TDateTime; // Prvy den aktualneho roka
  function  LastActYearDate: TDateTime; // Posledny den aktualneho roka
  function  FirstPrvYearDate: TDateTime; // Prvy den predchadzajuceho roka
  function  LastPrvYearDate: TDateTime; // Posledny den predchadzajuceho roka
  function  PrvYearDate (pDate:TDateTime): TDateTime; // Zadany datum v minulom roku

  function TimeToFileName (pTime:TDateTime): Str6;
  function DateToFileName (pDate:TDate):Str6;
  function DateToFileNameYMD (pDate:TDate):Str8;
  function DateToFileNameYMD6 (pDate:TDate):Str6;
  function DateToTxt (pDate:TDate):Str8;  // Prekonvertuje do formatu YYYYDDMM
  function DateToDDMMYYYY (pDate:TDate):Str8;
  function DateToYYYY_MM_DD (pDate:TDate):Str10;
  function DateToActYear (pDate:TDate):TDate;
  function DateFromYYYY_MM_DD(pTextDate:Str10):TDate;


  function  VerifyDate (pDate:string):string; //Kontroluje sprßvnos£ dßtumu r¢zneho fomßtu

  function  MthCount (pBegYear,pBegMth,pEndYear,pEndMth:word): integer; // Hodnota funkcie je pocet mesiacov medzi zadanym intervalom
  procedure NextMth (var pYear:word; var pMth:byte); // Procedura vrati nasledujuci mesiac - ak je to december zmeni sa aj rok

  function  StrTimeVerify (pTimeStr:string):string;

const
      cdInterval  = 0;
      cdEqual     = 1;
      cdLessEq    = 2;
      cdLess      = 3;
      cdGreatEq   = 4;
      cdGreat     = 5;
      cdNotEq     = 6;

      cdMonthsOfYear: array [0..12] of string =
                     ('','Január','Február','Marec','Apríl',
                      'Máj','Jún','Júl','August','September',
                      'Október','November','December');
      cNumDayStr    : array [0..5] of string = ('dní','deò','dni','dni','dni', 'dní');


implementation

function  ValidDate (pYear,pMonth,pDay:word):boolean;
begin
  ValidDate := FALSE;
  If pDay > 0 then ValidDate := (pDay<=MonthLastDay (pYear,pMonth));
end;

function  ValidStrDate (pDate:Str10):boolean;
var mDay,mMonth,mYear:word;  mOK: boolean;
begin
  mOK := FALSE;
  If Pos ('.',pDate)>0 then begin
    mDay := ValInt (Copy (pDate,1,Pos ('.',pDate)-1));
    Delete (pDate,1,Pos ('.',pDate));
    If Pos ('.',pDate)>0 then begin
      mMonth := ValInt (Copy (pDate,1,Pos ('.',pDate)-1));
      Delete (pDate,1,Pos ('.',pDate));
      mYear := ValInt (pDate);
      If mYear>0 then mOK := ValidDate (mYear,mMonth,mDay);
    end;
  end;
  Result := mOK;
end;

function  MonthLastDay (pYear,pMonth:word):byte;
begin
  MonthLastDay := 0;
  case pMonth of
    1,3,5,7,8,10,12: MonthLastDay := 31;
    4,6,9,11       : MonthLastDay := 30;
    2              : MonthLastDay := (28+Ord ((pYear mod 4 = 0) and (pYear mod 400 <> 0)));
  end;
end;

function  ChangeDate (pDate:TDateTime;pYear,pMonth,pDay:longint):TDateTime;
var D,M,Y: word;  mDate: TDateTime;
begin
  ChangeDate := 0;
  If pDate>0 then begin
    DecodeDate (pDate,Y,M,D);
    pMonth := (Y*12+(M-1))+pYear*12+pMonth;
    pYear  := pMonth div 12;
    pMonth := pMonth mod 12 +1;
    If D>MonthLastDay (pYear,pMonth) then D:=MonthLastDay (pYear,pMonth);
    If ValidDate (pYear,pMonth,D) then begin
      mDate := EncodeDate (pYear,pMonth,D);
      If (pDay >= 0) or ((pDay<0) and (mDate+pDay>0))
        then ChangeDate := mDate+pDay;
    end;
  end;
end;

function  DayOfWeekSK (pDate:TDateTime):longint;
var mDay:longint;
begin
  mDay := DayOfWeek (pDate);
  mDay := mDay-1;
  If mDay = 0 then mDay := 7;
  Result := mDay;
end;

function  WeekOfYear (pDate:TDateTime):byte;
var mY,mM,mD:word;  mFDate:TDateTime;  mDays :longint;
begin
  DecodeDate (pDate,mY,mM,mD);
  mFDate := EncodeDate (mY,1,1);
  mDays := Round (pDate-mFDate)+DayOfWeekSK (mFDate);
  If (mDays div 7) = (mDays / 7)
    then mDays := mDays div 7
    else mDays := mDays div 7 + 1;
  Result := mDays;
end;

function  FillDate (pDate:string):string;
var mDateS: string;  mD,mM,mY: word;  mWD,mW: longint;
    mS: string;  mFDate,mDate: TDateTime;
begin
  pDate := RemLeftSpaces (RemRightSpaces (pDate));
  If pDate='' then begin
    try
      mDateS := DateToStr (Date);
    except mDateS := ''; end;
  end else begin
    mDateS := '';
    mWD := 1;
    DecodeDate (Date,mY,mM,mD);
    If Pos ('/',pDate)=1 then begin
      pDate := Copy (pDate,2,Length (pDate));
      If pDate<>'' then begin
         If Pos ('/',pDate)>0 then begin
           mS := Copy (pDate,1,Pos ('/',pDate)-1);
           mW := ValInt (mS);
           pDate := Copy (pDate,Pos ('/',pDate)+1,Length (pDate));
           If Pos ('/',pDate)>0 then begin
             mS := Copy (pDate,1,Pos ('/',pDate)-1);
             mWD := ValInt (mS);
             pDate := Copy (pDate,Pos ('/',pDate)+1,Length (pDate));
             If pDate <> '' then begin
               mY := ValInt (pDate);
               If mY<100 then mY := mY+1900;
             end;
           end else mWD := ValInt (pDate);
         end else mW := ValInt (pDate);
      end else mW := ValInt (pDate);
      mFDate := EncodeDate (mY,1,1);
      If DayOfWeekSK (mFDate)<=4
        then mFDate := mFDate-DayOfWeekSK (mFDate)+1
        else mFDate := mFDate-DayOfWeekSK (mFDate)+8;
      mDate := mFDate+((mW-1)*7+mWD-1);
      try
        mDateS := DateToStr (mDate);
      except mDateS := ''; end;
    end else begin
      mDateS := ReplaceStr (pDate,',','.');
      If (Length (mDateS)>2) and (Pos ('.',mDateS)=0) then begin
        Insert ('.',mDateS,3);
        If Length (mDateS)>5 then Insert ('.',mDateS,6);
      end;
      If Pos ('.',mDateS)>0 then begin
        mD := ValInt (Copy (mDateS,1,Pos ('.',mDateS)-1));
        mDateS := Copy (mDateS,Pos ('.',mDateS)+1,Length (mDateS));
        If Pos ('.',mDateS)>0 then begin
          mM := ValInt (Copy (mDateS,1,Pos ('.',mDateS)-1));
          mDateS := Copy (mDateS,Pos ('.',mDateS)+1,Length (mDateS));
          If mDateS<>'' then begin
            mY := ValInt (mDateS);
            If mY<100 then mY := mY+1900;
          end;
        end else mM := ValInt (mDateS);
      end else mD := ValInt (mDateS);
      If (mY=0) or (mM=0) or (mD=0)
        then mDateS := ''
        else begin
          try
            mDateS := DateToStr (EncodeDate (mY,mM,mD));
          except mDateS := ''; end;
        end;
    end;
  end;
  Result := mDateS;
end;

function  DateEvalue (pStr,pF,pL:string;pComType:byte):boolean;
var mDate,mDateF,mDateL: string;
    mD,mDF,mDL: TDateTime; mOK: boolean;
begin
  mDate  := FillDate (pStr);
  mDateF := FillDate (pF);
  mDateL := FillDate (pL);
  mOK :=(mDateF<>'') and (mDateL<>'') and (mDate<>'');
  If mOK then begin
    mD  := StrToDate (pStr);
    mDF := StrToDate (mDateF);
    mDL := StrToDate (mDateL);
    case pComType of
      cdInterval: mOK := (mD>=mDF) and (mD<=mDL);
      cdEqual   : mOK := (mD=mDF);
      cdLessEq  : mOK := (mD<=mDF);
      cdLess    : mOK := (mD<mDF);
      cdGreatEq : mOK := (mD>=mDF);
      cdGreat   : mOK := (mD>mDF);
      cdNotEq   : mOK := (mD<>mDF);
    end;
  end;
  If mOK then mOK := (StrToDate (pStr)>=StrToDate (mDateF)) and (StrToDate (pStr)<=StrToDate (mDateL));
  Result := mOK;
end;

FUNCTION   YearL;
var  mD,mM,mY: word;
BEGIN
  DecodeDate (pDate,mY,mM,mD);
  Result := StrInt (mY,4);
END;     { *** YearL *** }

FUNCTION   YearS;
var  mD,mM,mY: word;
BEGIN
  If (pdate>2000)and(pdate<2020) then begin
//    WriteToLogFile('YEARS.LOG',FloatToStr(pDate));
    beep;
  end else begin
    DecodeDate (pDate,mY,mM,mD);
    Result := copy (StrInt (mY,4),3,2);
  end;
END;     { *** YearS *** }

FUNCTION   YearSLong;
BEGIN
  Result := StrIntZero(pYear-2000,2);
END;     { *** YearS *** }

FUNCTION   YearSToLong (pYear:Str2): longint; // Hodnota funkcie rok zo zadaneho roku vo forme Str2
BEGIN
  Result := 2000+ValInt(pYear);
END;     { *** YearS *** }

function Year;
var  mD,mM,mY: word;
begin
  DecodeDate (pDate,mY,mM,mD);
  Result := mY;
end;

FUNCTION   Mth;
var  mD,mM,mY: word;
BEGIN
  DecodeDate (pDate,mY,mM,mD);
  Result := StrIntZero (mM,2);
END;     { *** Mth *** }

FUNCTION   MthNum;
var  mD,mM,mY: word;
BEGIN
  DecodeDate (pDate,mY,mM,mD);
  Result := mM;
END;     { *** MthNum *** }

FUNCTION   Day;
var  mD,mM,mY: word;
BEGIN
  DecodeDate (pDate,mY,mM,mD);
  Result := StrIntZero (mD,2);
END;     { *** Day *** }

FUNCTION   DayNum;
var  mD,mM,mY: word;
BEGIN
  DecodeDate (pDate,mY,mM,mD);
  Result := mD;
END;

FUNCTION   DayMth;
var  mD,mM,mY: word;
BEGIN
  DecodeDate (pDate,mY,mM,mD);
  Result := StrIntZero (mD,2)+'.'+StrIntZero (mM,2);
END;     { *** Day *** }

FUNCTION   SysYearL;
BEGIN
  Result := YearL (Now);
END;     { *** SysYearL *** }

FUNCTION   SysYear;
BEGIN
  Result := YearS (Now);
END;     { *** SysYear *** }

FUNCTION   SysMth;
BEGIN
  Result := Mth (Now);
END;     { *** SysMth *** }

FUNCTION   SysDay;
BEGIN
  Result := Day (Now);
END;     { *** SysDay *** }

function  NumYear (pYear:Str4): word;
var  mY: word;
begin
  If Length(pYear)=4
    then Result := ValInt(pYear)
    else begin
      mY := ValInt(pYear);
      If (mY>80)
        then Result := 1900+mY
        else Result := 2000+mY;
    end;
end;

function  FirstWeekDate (pWeek:byte;pYear:Str4): TDateTime; // Prvy den zadaneho tyzdna v zadanom roku
var  mFirstYearDate: TDate;   mDayInFirstWeek:byte;
begin
  mFirstYearDate := FirstYearDate (pYear);  // Najdeme datum prveho dna v zadanom roku
  mDayInFirstWeek := 7-DayOfWeekSK (mFirstYearDate); // Urcime pocet dni prveho tyzdna
  Result := mFirstYearDate+mDayInFirstWeek+(pWeek-2)*7+1;
end;

function  LastWeekDate (pWeek:byte;pYear:Str4): TDateTime; // Posledny den zadaneho tyzdna v zadanom roku
var  mFirstYearDate: TDate;   mDayInFirstWeek:byte;
begin
  mFirstYearDate := FirstYearDate (pYear);  // Najdeme datum prveho dna v zadanom roku
  mDayInFirstWeek := 7-DayOfWeekSK (mFirstYearDate); // Urcime pocet dni prveho tizdna
  Result := mFirstYearDate+mDayInFirstWeek+(pWeek-1)*7;
end;

function  FirstMthDate (pMth:Str2;pYear:Str4): TDateTime; // Prvy den zadaneho mesiaca a zadaneho roka
var  mD,mM,mY: word;
begin
  Result := EncodeDate (ValInt(pYear),ValInt(pMth),1);
end;

function  LastMthDate (pMth:Str2;pYear:Str4): TDateTime; // Posledny den zadaneho mesiaca a zadaneho roka
begin
  If pMth='12'
    then Result := EncodeDate (ValInt(pYear),12,31)
    else Result := EncodeDate (ValInt(pYear),ValInt(pMth)+1,1)-1;
end;

function  FirstYearDate (pYear:Str4): TDateTime; // Prvy den zadaneho roka
begin
  Result := FirstMthDate ('01',pYear);
end;

function  LastYearDate (pYear:Str4): TDateTime; // Posledny den zadaneho roka
begin
  Result := LastMthDate ('12',pYear);
end;

function  FirstActMthDate: TDateTime; // Prvy den zadaneho mesiaca a zadaneho roka
begin
  Result := FirstMthDate(SysMth,gvSys.ActYear);
end;

function  LastActMthDate: TDateTime; // Posledny den zadaneho mesiaca a zadaneho roka
begin
  Result := LastMthDate(SysMth,gvSys.ActYear);
end;

function  FirstPrvMthDate: TDateTime; // Prvy den predchadzajuceho mesiaca a zadaneho roka
begin
  Result := FirstMthDate(Mth(LastPrvMthDate),gvSys.ActYear);
end;

function  LastPrvMthDate: TDateTime; // Posledny den predchadzajuceho mesiaca a zadaneho roka
begin
  Result := FirstActMthDate-1;
end;

function  DateInActYear (pDate:TDateTime):boolean; // TRUE ak datum je z aktualnehor roku
begin
  Result := InDateInterval (FirstYearDate (gvSys.ActYear),LastYearDate (gvSys.ActYear),pDate);
end;

function  CurrActYearDate: TDateTime; // Aktualny datum alebo koniec roka
begin
  Result := Date;
  If Result>LastActYearDate then Result := LastActYearDate;
end;

function  FirstActYearDate: TDateTime; // Prvy den aktualneho roka
begin
  Result := FirstYearDate (gvSys.ActYear);
end;

function  LastActYearDate: TDateTime; // Posledny den aktualneho roka
begin
  Result := LastYearDate (gvSys.ActYear);
end;

function  FirstPrvYearDate: TDateTime; // Prvy den predchadzajuceho roka
begin
  Result := FirstYearDate (StrInt(ValInt(gvSys.ActYear)-1,0));
end;

function  LastPrvYearDate: TDateTime; // Posledny den predchadzajuceho roka
begin
  Result := LastYearDate (StrInt(ValInt(gvSys.ActYear)-1,0));
end;

function  PrvYearDate (pDate:TDateTime): TDateTime; // Zadany datum v minulom roku
var  mD,mM,mY: word;  mDate:TDateTime;
begin
  DecodeDate (pDate,mY,mM,mD);
  mY := mY-1;
  If (mM=2) and (mD=28) then begin // Orekontrolujeme ci v predchadzajucom roku existuje 02.29
    If ValidDate (mY,mM,29) then mD := 29;
  end;
  If (mM=2) and (mD=29) then mD := 29;
  mDate := pDate;
  If not TryEncodeDate (mY,mM,mD,mDate) then TryEncodeDate (mY,mM,mD-1,mDate);
  Result := mDate;
end;

function  TimeToFileName (pTime:TDateTime): Str6;
var mHour, mMin,mSec,mMSec:word;
begin
  DecodeTime(pTime,mHour,mMin,mSec,mMSec);
  Result := StrIntZero(mHour,2)+StrIntZero(mMin,2)+StrIntZero(mSec,2);
end;

function  DateToFileName (pDate:TDate): Str6;
var  mD,mM,mY: word;
begin
  DecodeDate (pDate,mY,mM,mD);
  Result := StrIntZero(mD,2)+StrIntZero(mM,2)+copy(StrInt(mY,4),3,2);
end;

function  DateToFileNameYMD (pDate:TDate): Str8;
var  mD,mM,mY: word;
begin
  DecodeDate (pDate,mY,mM,mD);
  Result := StrInt(mY,4)+StrIntZero(mM,2)+StrIntZero(mD,2);
end;

function  DateToFileNameYMD6 (pDate:TDate): Str6;
var  mD,mM,mY: word;
begin
  DecodeDate (pDate,mY,mM,mD);
  Result := StrInt(mY-2000,2)+StrIntZero(mM,2)+StrIntZero(mD,2);
end;

function  DateToDDMMYYYY (pDate:TDate):Str8;
var  mD,mM,mY: word;
begin
  DecodeDate (pDate,mY,mM,mD);
  Result := StrIntZero(mD,2)+StrIntZero(mM,2)+StrInt(mY,4);
end;

function  DateToYYYY_MM_DD (pDate:TDate):Str10;
var  mD,mM,mY: word;
begin
  DecodeDate (pDate,mY,mM,mD);
  Result := StrInt(mY,4)+'-'+StrIntZero(mM,2)+'-'+StrIntZero(mD,2);
end;

function  DateToTxt (pDate:TDate): Str8; // Prekonvertuje do formatu YYYYDDMM
var  mD,mM,mY: word;
begin
  DecodeDate (pDate,mY,mM,mD);
  Result := StrInt(mY,4)+StrIntZero(mM,2)+StrIntZero(mD,2);
end;

function  DateToActYear (pDate:TDate):TDate;
var  mD,mM,mY,mAY: word;
begin
  DecodeDate (Date,mAY,mM,mD);
  DecodeDate (pDate,mY,mM,mD);
  Result := EncodeDate(mAY,mM,mD);
end;

function DateFromYYYY_MM_DD(pTextDate:Str10):TDate;
var  mYear,mMonth,mDay: word;
begin
  mYear := StrToInt(Copy(pTextDate, 1, 4));
  mMonth := StrToInt(Copy(pTextDate, 6, 2));
  mDay := StrToInt(Copy(pTextDate, 9, 2));
  Result := EncodeDate(mYear,mMonth,mDay);
end;

function  VerifyDate (pDate:string):string;
var mDateS:string;  mD,mM,mY:word; mWD,mW:longint;
    mS:string;  mFDate,mDate :TDateTime;
begin
  pDate := RemLeftSpaces (RemRightSpaces (pDate));
  If (pDate='.') or (pDate=',') then begin
    try
      mDateS := DateToStr (Date);
    except mDateS := ''; end;
  end else begin
    mDateS := '';
    mWD := 1;
    DecodeDate (Date,mY,mM,mD);
    mDateS := ReplaceStr (pDate,',','.');
    If (Length (mDateS)>2) and (Pos ('.',mDateS)=0) then begin
      Insert ('.',mDateS,3);
      If Length (mDateS)>5 then Insert ('.',mDateS,6);
    end;
    If Pos ('.',mDateS)>0 then begin
      mD := ValInt (Copy (mDateS,1,Pos ('.',mDateS)-1));
      mDateS := Copy (mDateS,Pos ('.',mDateS)+1,Length (mDateS));
      If Pos ('.',mDateS)>0 then begin
        mM := ValInt (Copy (mDateS,1,Pos ('.',mDateS)-1));
        mDateS := Copy (mDateS,Pos ('.',mDateS)+1,Length (mDateS));
        If mDateS<>'' then begin
          mY := ValInt (mDateS);
         If mY<100 then begin
           If mY<90
             then mY := mY+2000
             else mY := mY+1900;
         end;
        end;
      end else mM := ValInt (mDateS);
    end else mD := ValInt (mDateS);
    If (mY=0) or (mM=0) or (mD=0)
      then mDateS := ''
      else begin
        try
          mDateS := DateToStr (EncodeDate (mY,mM,mD));
        except mDateS := ''; end;
      end;
  end;
  VerifyDate := mDateS;
end;

function  MthCount (pBegYear,pBegMth,pEndYear,pEndMth:word): integer; // Hodnota funkcie je pocet mesiacov medzi zadanym intervalom
begin
  If pBegYear<>pEndYear then begin
     Result := 12-pBegMth+1+(pEndYear-pBegYear-1)*12+pEndMth;
  end
  else Result := pEndMth-pBegMth+1;
end;

procedure NextMth (var pYear:word; var pMth:byte); // Procedura vrati nasledujuci mesiac - ak je to december zmeni sa aj rok
begin
  Inc (pMth);
  If pMth=13 then begin // To znamena ze nasleduje dalsi rok
    Inc (pYear);
    pMth := 1;
  end;
end;

function  StrTimeVerify (pTimeStr:string):string;
var mTime:TTime;
begin
  If Pos (':', pTimeStr)=0 then pTimeStr := pTimeStr+':00';
  mTime := StrToTimeDef(pTimeStr, 0);
  If mTime=0
    then Result := ''
    else Result := FormatDateTime ('hh:nn', mTime);
end;


end.
