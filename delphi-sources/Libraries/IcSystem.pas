unit IcSystem;

interface

uses
  {IdentCode} IcConv,
     {Delphi} Forms, SysUtils, Windows;

  function  VolumeSerialNumber (pDriveChar: Char): string;
            //Hodnota funkcie je seriove cislo disku
  function  SetVolumeLab (pDriveChar:char;pLabel:string):boolean;
            //Hodnota funkcie je TRUE ak podarilosa zmenit Label disku na pLabel
  procedure Delay (pTime:longint);
            //Cakaci ciklus - caka pTime msec

implementation

function VolumeSerialNumber(pDriveChar: Char): string;
var OldErrorMode: Integer;  NotUsed, VolFlags: DWord;
    Buf: array [0..MAX_PATH] of Char;
    mSerialNumber: PDWORD;  mStr1, mStr2: string;
begin
  Result := '';
  mSerialNumber := nil;
  OldErrorMode := SetErrorMode(SEM_FAILCRITICALERRORS);
  try
    GetMem(mSerialNumber, sizeof(mSerialNumber));
    If GetVolumeInFormation(PChar(pDriveChar + ':\'), Buf, sizeof(Buf), mSerialNumber, NotUsed, VolFlags, nil, 0) then
//      SetString(Result, Buf, StrLen(Buf))
      mStr1 := Format('%x',[(mSerialNumber^ div $10000)]);
      mStr2 := Format('%x',[(mSerialNumber^ mod $10000)]);
      while (length(mStr1) < 4) do mStr1 := '0'+mStr1;
      If Length(mStr1)=8 then mStr1 := Format('%x',[ValInt('$'+Copy(mStr1,5,4))-1,4]);
      while (length(mStr2) < 4) do mStr2 := '0'+mStr2;
      If Length(mStr2)=8 then mStr2 := Copy (mStr2,5,4);
      Result := mStr1+'-'+mStr2;
      // hexdigits
  finally
    FreeMem(mSerialNumber);
    SetErrorMode(OldErrorMode);
  end;
end;

function  SetVolumeLab (pDriveChar:char;pLabel:string):boolean;
begin
  Result := SetVolumeLabel (PChar (pDriveChar+':\'),PChar (pLabel));
end;

procedure Delay (pTime:longint);
var mTime:TDateTime;
begin
  mTime := Time;
  Repeat
    Application.ProcessMessages;
  until Time>=mTime+(pTime/10000000)
end;


end.
