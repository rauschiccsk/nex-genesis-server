unit WndHand;

interface

  uses
    TlHelp32, Windows, SysUtils, ShellApi, DateUtils, Forms, Messages, Controls, Classes;

  const
    WM_PingEshopMonitor = WM_USER + 4001;
    WM_WorkEshopMonitor = WM_USER + 4002;

  type
    TENumData = record
      hW: HWND;
      ID: DWORD;
    end;

    PMyEnumInfo = ^MyEnumInfo;
    MyEnumInfo = record
      ProcessId: DWORD;
      List: TStrings;
    end;

function  SendMyAppMessage(pMsg:cardinal;pFileName:string):boolean;

function  GetProcessQnt (pFileName:string):longint;
function  GetFirstProcessID (pFileName:string):longint;
function  ExistProcessID (pProcessID:longint):boolean;
function  WindowFromProcessID (pID:DWORD):HWND;
function  ENumProc (phw:HWND; var pData: TENumData):boolean; stdcall;
procedure GetWindowHandlesByPID(pID:DWORD; List: TStrings);
function  GetFirstWindowHandlesByPID(pID:DWORD):HWND;

function UpString (pString:string): string;
function UpChar (pChar:Char): Char;

procedure Wait (pTime:word); //Èaká zadaný poèet milisekúnd
function  ValInt (pStr:ShortString):integer;

implementation

function  SendMyAppMessage(pMsg:cardinal;pFileName:string):boolean;
var mProcID:longint;mHandle:Cardinal; mTime:TDateTime;
begin
  Result:=FALSE;
  mProcID:=GetFirstProcessID(ExtractFileName(pFileName));
  If mProcID=0 then begin
    ShellExecute(Application.Handle, 'open', PChar(pFileName), PChar(''), PChar (''), SW_SHOW);
    mTime := IncSecond (Now, 60);
    Repeat
      Wait(500);
      mProcID := GetFirstProcessID (ExtractFileName(ExtractFileName(pFileName)));
    until (mProcID>0) or (Now>mTime);
  end;

  If mProcID>0 then begin
    mHandle := GetFirstWindowHandlesByPID (mProcID);
    PostMessage(mHandle, pMsg, 0, 0);
    Result:=TRUE;
  end else ;//Chyba
end;

function  GetProcessQnt (pFileName:string):longint;
var mContinueLoop: LongBool; mHandle: THandle; mProcessEntry32: TProcessEntry32;
    mProcFile:string; mSelfProcessID:longint;
begin
  Result := 0;
  mHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  mProcessEntry32.dwSize := SizeOf(mProcessEntry32);
  mContinueLoop := Process32First(mHandle, mProcessEntry32);
  mSelfProcessID := GetCurrentProcessId;
  while Integer(mContinueLoop) <> 0 do begin
    If mProcessEntry32.th32ProcessID<>0 then begin
      mProcFile := UpString (mProcessEntry32.szExeFile);
      If UpString (pFileName)=mProcFile then begin
        If (mProcessEntry32.th32ProcessID<>mSelfProcessID)
          then Result := Result+1;
      end;
    end;
    mContinueLoop := Process32Next(mHandle, mProcessEntry32);
  end;
  CloseHandle(mHandle);
end;


function  GetFirstProcessID (pFileName:string):longint;
var mContinueLoop: LongBool; mHandle: THandle; mProcessEntry32: TProcessEntry32;
    mEnd:boolean;
begin
  Result := 0;
  mHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  mProcessEntry32.dwSize := SizeOf(mProcessEntry32);
  mContinueLoop := Process32First(mHandle, mProcessEntry32);
  mEnd := FALSE;
  while (Integer(mContinueLoop) <> 0) and not mEnd do begin
    If mProcessEntry32.th32ProcessID<>0 then begin
      If UpString(pFileName)=UpString(mProcessEntry32.szExeFile) then begin
        Result := mProcessEntry32.th32ProcessID;
        mEnd := TRUE;
      end;
    end;
    mContinueLoop := Process32Next(mHandle, mProcessEntry32);
  end;
  CloseHandle(mHandle);
end;

function  ExistProcessID (pProcessID:longint):boolean; // Momentálne nepoužívame
var mContinueLoop: LongBool; mHandle: THandle; mProcessEntry32: TProcessEntry32;
begin
  Result := FALSE;
  mHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  mProcessEntry32.dwSize := SizeOf(mProcessEntry32);
  mContinueLoop := Process32First(mHandle, mProcessEntry32);
  while (Integer(mContinueLoop) <> 0) and not Result do begin
    If mProcessEntry32.th32ProcessID<>0 then begin
      Result := (mProcessEntry32.th32ProcessID=pProcessID);
    end;
    mContinueLoop := Process32Next(mHandle, mProcessEntry32);
  end;
  CloseHandle(mHandle);
end;

function WindowFromProcessID (pID:DWORD): HWND;     // Momentálne nepoužívame
var mData: TEnumData;
begin
  mData.ID := pID;
  mData.hW := 0;
  EnumWindows(@EnumProc, longint(@mData));
  Result := mData.hW;
end;

function ENumProc (phw:HWND; var pData:TENumData):boolean; // Momentálne nepoužívame
var mID: DWORD;
begin
  Result := TRUE;
  GetWindowThreadProcessID (phw, @mID);
  If mID=pData.ID then begin
    pData.hW := phw;
    Result := FALSE;
  end;
end;

function MyEnumWindowsProc(wnd: HWND; param: LPARAM): BOOL; stdcall;
var dwPid: Cardinal; mClassName: array[0..255] of char; mS:string;
begin
  GetWindowThreadProcessId(wnd, @dwPid);
  if dwPid = PMyEnumInfo(param).ProcessId then begin
    GetClassName(wnd, mClassName, 255);
    mS:=string(mClassName);
    If Copy(mS,1,1)='T' then PMyEnumInfo(param).List.Add(IntToStr(wnd));
  end;
  Result := TRUE;
end;

procedure GetWindowHandlesByPID(pID:DWORD; List: TStrings); // Momentálne nepoužívame
var Info: MyEnumInfo;
begin
  Info.ProcessId := pID;
  Info.List := List;
  List.BeginUpdate;
  try
    EnumWindows(@MyEnumWindowsProc, LPARAM(@Info));
  finally
    List.EndUpdate;
  end;
end;

function  GetFirstWindowHandlesByPID(pID:DWORD):HWND;
var Info: MyEnumInfo; mList:TStrings;
begin
  Result:=0;
  Info.ProcessId := pID;
  mList:=TStringList.Create;
  Info.List := mList;
  mList.BeginUpdate;
  try
    EnumWindows(@MyEnumWindowsProc, LPARAM(@Info));
  finally
    mList.EndUpdate;
  end;
  If mList.Count>0 then Result:=ValInt(mList.Strings[0]);
  mList.Free;
end;

function  UpString (pString:string): string;
var I:longint;
begin
  Result := pString;
  For I:=1 to Length(pString) do
    Result[I] := UpChar(pString[I]);
end;

function  UpChar (pChar:Char): Char;
begin
  Result := pChar;
  If Ord(pChar) in [224..255]
    then Result := Chr(Ord(pChar)-32)
    else Result := UpCase (pChar);
end;

procedure Wait (pTime:word);
var mWaitTime:TDateTime;
begin
  mWaitTime:=IncMilliSecond (Now,pTime);
  While Now<mWaitTime do begin
    Application.ProcessMessages;
  end;
end;

function  ValInt (pStr:ShortString):integer;
var mNum:integer;  mErr:integer;
begin
  Val (pStr,mNum,mErr);
  If mErr<>0 then mNum := 0;
  Result := mNum;
end;


end.
