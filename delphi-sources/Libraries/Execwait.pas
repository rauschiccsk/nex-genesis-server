unit ExecWait;

interface

uses
  Windows, Forms, ShellAPI; // Include SHELLAPI in this "uses" clause

function ExecAppWait(AppName,Params: string): boolean;
// Spusti programovy modul a pocka pokial sa to ukonci
function ExecApp(AppName,Params: string): boolean;
// Spusti programovy modul 
function ExecAppWaitErr(AppName,Params: string): integer;
// Spusti programovy modul a pocka pokial sa to ukonci ale vracia
// pripadny chybovy kod

implementation

{ Execute an external application APPNAME.
  Pass optional parameters in PARAMS, separated by spaces.
  Wait for completion of the application
  Returns FASLE if application failed.                     }
function ExecAppWait(AppName, Params: string): Boolean;
var
  // Structure containing and receiving info about application to start
  ShellExInfo: TShellExecuteInfo;
begin
  FillChar(ShellExInfo, SizeOf(ShellExInfo), 0);
  with ShellExInfo do begin
    cbSize := SizeOf(ShellExInfo);
    fMask := see_Mask_NoCloseProcess;
    Wnd := Application.Handle;
    lpFile := PChar(AppName);
    lpParameters := PChar(Params);
    nShow := sw_ShowNormal;
  end;
  Result := ShellExecuteEx(@ShellExInfo);
  If Result then
    while WaitForSingleObject(ShellExInfo.HProcess, 100) = WAIT_TIMEOUT do begin
      Application.ProcessMessages;
      If Application.Terminated then Break;
    end;
end;

function ExecApp(AppName, Params: string): Boolean;
var
  // Structure containing and receiving info about application to start
  ShellExInfo: TShellExecuteInfo;
begin
  FillChar(ShellExInfo, SizeOf(ShellExInfo), 0);
  with ShellExInfo do begin
    cbSize := SizeOf(ShellExInfo);
    fMask := see_Mask_NoCloseProcess;
    Wnd := Application.Handle;
    lpFile := PChar(AppName);
    lpParameters := PChar(Params);
    nShow := sw_ShowNormal;
  end;
  Result := ShellExecuteEx(@ShellExInfo);
end;

function ExecAppWaitErr(AppName,Params: string): integer;
var ShellExInfo: TShellExecuteInfo;  mErr:cardinal; mOK:boolean;
begin
  Result := 0;
  FillChar(ShellExInfo, SizeOf(ShellExInfo), 0);
  With ShellExInfo do begin
    cbSize := SizeOf(ShellExInfo);
    fMask := see_Mask_NoCloseProcess;
    Wnd := Application.Handle;
    lpFile := PChar(AppName);
    lpParameters := PChar(Params);
    nShow := sw_ShowNormal;
  end;
  mOK := ShellExecuteEx(@ShellExInfo);
  If mOK then begin
    while WaitForSingleObject(ShellExInfo.HProcess, 100) = WAIT_TIMEOUT do begin
      Application.ProcessMessages;
      if Application.Terminated then Break;
    end;
    GetExitCodeProcess(ShellExInfo.HProcess,mErr);
    Result := mErr;
  end else Result := -1;
end;

end.
