unit NEXApi;
//NEX Application programming interface

interface

uses
  Windows, Messages, TlHelp32;

  function  ExistProcessID (pProcessID:longint):boolean;
  procedure CloseExtApp (pAppHandle:longint);
  procedure TerminateExtApp (pAppHandle:longint);
  procedure ShowExtApp (pAppHandle:longint);

implementation

function  ExistProcessID (pProcessID:longint):boolean;
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

procedure CloseExtApp (pAppHandle:longint);
begin
  PostMessage(pAppHandle, WM_Close, 0, 0);
end;

procedure TerminateExtApp (pAppHandle:longint);
var hprocessID: INTEGER; processHandle: THandle; DWResult: DWORD;
begin
  If IsWindow(pAppHandle) then begin
    GetWindowThreadProcessID(pAppHandle, @hprocessID);
    If hprocessID <> 0 then begin
      processHandle := OpenProcess(PROCESS_TERMINATE or PROCESS_QUERY_INFORMATION, False, hprocessID);
      If processHandle <> 0 then begin
        TerminateProcess(processHandle, 0);
        CloseHandle(ProcessHandle);
      end;
    end;
  end;
end;

procedure ShowExtApp (pAppHandle:longint);
begin
  If pAppHandle>0 then begin
    ShowWindow(pAppHandle,SW_RESTORE);
    ShowWindow(pAppHandle,SW_HIDE);
    ShowWindow(pAppHandle,SW_SHOWNORMAL);
    ShowWindow(pAppHandle,SW_SHOW);
  end;
end;

end.
