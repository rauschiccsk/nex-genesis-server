unit FpTools; // Prevodne funkcie medzi FredlyPascal a Delphi

interface
  uses
    {Delphi}   Controls, SysUtils;

//*********************** FRENDLI PASCAL SECTION *********************************

  const
    cFpMaxDate = 65378;           {nejvetsia korektna hodnota typu DateType - 31.12.2078 }
    cFpMaxTime = 24 * 60 * 60 * 100 - 1;
    cFpNoDate  = 0;               {hodnota indikujuci nekorektny datumu }
    cFpNoTime  = cFpMaxTime + 1;  {hodnota indikujuci nekorektny cas }
  type
    TFpDate = Word;               {Frendli Pascal datum }
    TFpTime = LongInt;            {Frendli Pascal cas }

  function  DMY_To_FpDate (pDay,pMonth,pYear: word) : TFpDate;                 {Prevadi den, mesic a rok na poradove cislo dne od 1.1.1900 }
  procedure FpDate_To_DMY (pDate: TFpDate; var pDay,pMonth,pYear: word);       {Prevod poradoveho cislo dne  od 1.1.1900 na den, mesic a rok }
  function  HMS_To_FpTime (pHour,pMin,pSec,pSec100: word) : TFpTime;           {Prevod hodin, minut, sekund a setin sekundy na cas }
  procedure FpTime_To_HMS (pTime: TFpTime; var pHour,pMin,pSec,pSec100: word); {Prevod casu na hodiny, minuty, sekundy a setiny sekund. }

  function  FpDate_To_Date(pFpDate: TFpDate): TDate;
  function  Date_To_FpDate(pDate: TDate): TFpDate;
  function  FpTime_To_Time(pFPTime: TFpTime): TTime;
  function  Time_To_FPTime(pTime: TTime): TFpTime;
  function  FpDateTime_To_DateTime(const pFpDate: TFpDate; const pFpTime:TFpTime):TDateTime;
  procedure DateTime_To_FpDateTime(const pDateTime: TDateTime; var pFpDate: TFpDate; var pFpTime:TFpTime);

//***********************************************************************

  function  TableName_To_DefFileName(pTableName: string):string;

implementation

function  TableName_To_DefFileName(pTableName: string):string;
begin   // Pr. PART001 -> dPART.DEF
   If pos('.', pTableName) > 0 then delete(pTableName, pos('.', pTableName), length(pTableName));
   while (pTableName[length(pTableName)] in ['0'..'9']) do delete(pTableName,length(pTableName),1);
   Result := 'd'+pTableName+'.DEF';
end;

////////////////////////////// FRENDLI PASCAL SECTION /////////////////////////////////////////

function  FPDate_To_Date(pFPDate: TFPDate):TDate;
var mDay,mMonth,mYear: word;
begin
  FPDate_To_DMY (pFPDate, mDay, mMonth, mYear);
  If (mYear <> 0) and (mMonth <> 0) and (mDay <> 0)
    then Result := EncodeDate(mYear, mMonth, mDay)
    else Result := 0;
end;

function  Date_To_FPDate(pDate: TDate):TFPDate;
var mDay,mMonth,mYear: word;
begin
  DecodeDate(pDate, mYear, mMonth, mDay);
  Result := DMY_To_FPDate (mDay, mMonth, mYear);
end;

function  FPTime_To_Time(pFPTime: TFPTime):TTime;
var mHour,mMin,mSec,mMSec: word;
begin
  FPTime_To_HMS (pFPTime, mHour, mMin, mSec, mMSec);
  Result := EncodeTime(mHour, mMin, mSec, mMSec);
end;

function  Time_To_FPTime(pTime: TTime):TFPTime;
var mHour,mMin,mSec,mMSec: word;
begin
  DecodeTime(pTime, mHour, mMin, mSec, mMSec);
  Result := HMS_To_FPTime (mHour, mMin, mSec, mMSec);
end;

function  FpDateTime_To_DateTime(const pFPDate: TFPDate; const pFPTime:TFPTime):TDateTime;
begin
  Result := FpDate_To_Date(pFpDate) + FpTime_To_Time(pFpTime);
end;

procedure DateTime_To_FpDateTime(const pDateTime: TDateTime; var pFPDate: TFPDate; var pFPTime:TFPTime);
begin
  pFPDate := Date_To_FPDate(pDateTime);
  pFPTime := Time_To_FPTime(pDateTime);
end;

function FPValidDMY (Day, Month, Year : Word) : Boolean;
begin    { Kontrola, zda parametry Day, Month a Year urcuji korektni datum. }
  FPValidDMY := false;
  If (Day > 0) and (Year >= 1900) and (Year <= 2078) then
    case Month of
      1, 3, 5, 7, 8, 10, 12 :
        FPValidDMY := Day <= 31;
      4, 6, 9, 11 :
        FPValidDMY := Day <= 30;
      2 :
        FPValidDMY := Day <= 28 + ord(Year mod 4 = 0);
    end;
end;


function  DMY_To_FPDate (pDay,pMonth,pYear: Word) : TFPDate;
begin          { Prevadi den, mesic a rok na poradove cislo dne od 1.1.1900 }
  If FPValidDMY(pDay,pMonth,pYear) then begin       { pokud jsou korektni parametry }
    If (pYear=1900) and (pMonth < 3) then
      If pMonth = 1
        then Result := pDay
        else Result := pDay + 31
    else
    begin
      If pMonth > 2 then
        Dec(pMonth, 3)
      else begin
        Inc(pMonth, 9);
        Dec(pYear);
      end;
      Result := (1461 * LongInt(pYear-1900) div 4) +
                ((153 * pMonth + 2) div 5) + pDay + 59;
    end;
  end
  else Result := cFpNoDate;
end;

procedure FPDate_To_DMY (pDate: TFpDate; var pDay,pMonth,pYear: word);
var mLongTemp: LongInt;
    mTemp: Word;
begin        { Prevod poradoveho cislo dne  od 1.1.1900 na den, mesic a rok }
  If (pDate > 0) and (pDate <= cFPMaxDate) then begin   { spravne datum }
    If pDate <= 59 then begin
      pYear := 1900;
      If pDate <= 31 then begin
        pMonth := 1;
        pDay := pDate;
      end
      else begin
        pMonth := 2;
        pDay := pDate - 31;
      end
    end
    else begin
      mLongTemp := 4 * LongInt(pred(pDate)) - 233;
      pYear := mLongTemp div 1461;
      mTemp := mLongTemp mod 1461 div 4 * 5 + 2;
      pMonth := mTemp div 153;
      pDay := mTemp mod 153 div 5 + 1;
      if pMonth < 10 then
        Inc(pMonth, 3)
      else begin
        Dec(pMonth, 9);
        Inc(pYear);
      end;
      Inc(pYear, 1900);
    end;
  end
  else begin
    pDay := 0;
    pMonth := 0 ;
    pYear := 0;
  end;
end;

function HMS_To_FpTime (pHour,pMin,pSec,pSec100 : word): TFpTime;
begin                  { Prevod hodin, minut, sekund a setin sekundy na cas }
  If (pHour<24) and (pMin<60) and (pSec<60) and (pSec100<1000) then
    Result := (LongInt(pHour*60+pMin)*60+pSec)*100+pSec100 div 10
  else Result := cFpNoTime;
end;

procedure FpTime_To_HMS (pTime: TFpTime; var pHour,pMin,pSec,pSec100: word);
var mW: word;
begin             { Prevod casu na hodiny, minuty, sekundy a setiny sekund. }
  If (pTime<0) or (pTime>cFpMaxTime) then begin
    pSec100 := 0;
    pSec := 0;
    pMin := 0;
    pHour := 0;
  end
  else begin
    pSec100 := pTime mod 100;
    pTime := pTime div 100;
    pSec := pTime mod 60;
    mW := pTime div 60;
    pMin := mW mod 60;
    pHour := mW div 60 mod 24;              { prepocteno i pro Time > MaxTime }
  end;
end;

end.
