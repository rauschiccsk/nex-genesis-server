unit TxtFile;


interface

uses
  IcFiles, NexError, Nexmsg, BtrTools, IcConv,DateUtils, 
  Forms, Windows,SysUtils,Classes;

type
  TTxtFile = class
    constructor Create (pFile:string);
    destructor  Destroy; override;

    procedure   WriteStringList (pStringList :TStrings);
  private
    oIOResult  : Integer;
    oTxFile    : TextFile;
    oFileName  : String;
  end;

  function  OpenTxtFileWrite (var pTxtFile:TextFile; pFile:string; var pErr:longint):boolean;
  function  OpenTxtFileRead (var pTxtFile:TextFile; pFile:string; var pErr:longint):boolean;
  function  WriteLnTxtFile (var pTxtFile:TextFile; pStr:string; var pErr:longint):boolean;
  function  WriteTxtFile (var pTxtFile:TextFile; pStr:string; var pErr:longint):boolean;
  function  ReadTxtFile (var pTxtFile:TextFile; var pStr:string; var pErr:longint):boolean;
  function  CloseTxtFile(var pTxtFile:TextFile; var pErr:longint):boolean;
  function  ReadFullTxtFile (pFile:string; var pErr:longint):string;
  procedure SaveFullTxtFile (pFile,pData:string; var pErr:integer);
  function  FileRename (pOldFile,pNewFile:string):boolean;
  function  FileDelete (pFile:string):boolean;
  function  GetFileSize (pFile:string):longint;
  function  GetFileTime (pFile:string):TDateTime;
  procedure Wait(pMSec:longint);


implementation

function OpenTxtFileWrite (var pTxtFile:TextFile; pFile:string; var pErr:longint):boolean;
var mTime:TDateTime;
begin
  pErr := 0;
  AssignFile (pTxtFile, pFile);
  mTime := IncMilliSecond (Now, 2000);
  Repeat
    {$I-}
    If FileExists(pFile)
      then Append (pTxtFile)
      else Rewrite (pTxtFile);
    {$I+} pErr := IOResult;
    If pErr>0 then Wait (10);
  until (pErr=0) or (Now>mTime);
  Result := (pErr=0);
end;

function OpenTxtFileRead (var pTxtFile:TextFile; pFile:string; var pErr:longint):boolean;
var mTime:TDateTime;
begin
  pErr := 0;
  Result := FALSE;
  If FileExists(pFile) then begin
    mTime := IncMilliSecond (Now, 2000);
    AssignFile (pTxtFile, pFile);
    Repeat
      {$I-} Reset (pTxtFile); {$I+} pErr := IOResult;
      If pErr>0 then Wait (10);
    until (pErr=0) or (Now>mTime);
    Result := (pErr=0);
  end;
end;

function WriteLnTxtFile (var pTxtFile:TextFile; pStr:string; var pErr:longint):boolean;
var mTime:TDateTime;
begin
  pErr := 0;
  mTime := IncMilliSecond (Now, 2000);
  Repeat
    {$I-} WriteLn (pTxtFile, pStr); {$I+} pErr := IOResult;
    If pErr>0 then Wait (10);
  until (pErr=0) or (Now>mTime);
  Result := (pErr=0);
end;

function WriteTxtFile (var pTxtFile:TextFile; pStr:string; var pErr:longint):boolean;
var mTime:TDateTime;
begin
  pErr := 0;
  mTime := IncMilliSecond (Now, 2000);
  Repeat
    {$I-} Write (pTxtFile, pStr); {$I+} pErr := IOResult;
    If pErr>0 then Wait (10);
  until (pErr=0) or (Now>mTime);
  Result := (pErr=0);
end;

function ReadTxtFile (var pTxtFile:TextFile; var pStr:string; var pErr:longint):boolean;
var mTime:TDateTime;
begin
  pErr := 0;
  mTime := IncMilliSecond (Now, 2000);
  Repeat
    {$I-} ReadLn (pTxtFile, pStr); {$I+} pErr := IOResult;
    If pErr>0 then Wait (10);
  until (pErr=0) or (Now>mTime);
  Result := (pErr=0);
end;

function CloseTxtFile(var pTxtFile:TextFile; var pErr:longint):boolean;
var mTime:TDateTime;
begin
  pErr := 0;
  mTime := IncMilliSecond (Now, 2000);
  Repeat
    {$I-} CloseFile (pTxtFile); {$I+} pErr := IOResult;
    If pErr>0 then Wait (10);
  until (pErr=0) or (Now>mTime);
  Result := (pErr=0);
end;

function ReadFullTxtFile (pFile:string; var pErr:longint):string;
var mSList:TStringList; mT:TextFile; mS:string; mErr:longint;
begin
  mSList := TStringList.Create;
  Result := ''; pErr := 1;
  If OpenTxtFileRead(mT, pFile, mErr) then begin
    Repeat
      If ReadTxtFile(mT, mS, mErr) then mSList.Add(mS);
    until (mErr>0) or EOF (mT);
    If mErr=0 then pErr := 0;
    CloseTxtFile(mT, mErr);
  end;
  Result := mSList.Text;
  FreeAndNil(mSList);
end;

procedure SaveFullTxtFile (pFile,pData:string; var pErr:integer);
var mT:TextFile;
begin
  If not DirectoryExists(ExtractFilePath(pFile)) then ForceDirectories(ExtractFilePath(pFile));
  If OpenTxtFileWrite(mT, pFile, pErr) then begin
    WriteTxtFile(mT, pData, pErr);
    CloseTxtFile(mT, pErr);
  end;
end;

function FileRename (pOldFile,pNewFile:string):boolean;
var mTime:TDateTime;
begin
  mTime := IncMilliSecond (Now, 2000);
  If FileExists(pNewFile) then FileDelete (pNewFile);
  Repeat
    Result := RenameFile(pOldFile, pNewFile);
    If not Result then Wait (10);
  until Result or (Now>mTime);
end;

function  FileDelete (pFile:string):boolean;
var mTime:TDateTime;
begin
  mTime := IncMilliSecond (Now, 2000);
  Repeat
    Result := DeleteFile(pFile);
    If not Result then Wait (10);
  until Result or (Now>mTime);
end;

function  GetFileSize (pFile:string):longint;
var mSR:TSearchRec;
begin
  Result := 0;
  If FindFirst(pFile, faAnyFile, mSR) = 0 then begin
    Result := mSR.Size;
    FindClose(mSR);
  end;
end;

function  GetFileTime (pFile:string):TDateTime;
var mSR:TSearchRec;
begin
  Result := 0;
  If FindFirst(pFile, faAnyFile, mSR) = 0 then begin
    Result := FileDateToDateTime (mSR.Time);
    FindClose(mSR);
  end;
end;

procedure Wait(pMSec:longint);
var mTime:TDateTime;
begin
  mTime := IncMilliSecond(Now,pMSec);
  Repeat
    Application.ProcessMessages;
  until Now>mTime;
end;

constructor TTxtFile.Create (pFile:string);
var I:byte;
begin
  oIOResult:=0;
  AssignFile (oTxFile,pFile);
  FileSetAttr(pFile,160);
  FileMode := $42;
  I:=0;
  repeat
    Inc(I);
    If not FileExistsI (pFile)
      then {$I+}Rewrite (oTxFile){$I-}
      else {$I+}Append (oTxFile){$I-};
    oIOResult:= IOResult;
    If oIOResult>0 then Sleep(100);
  until (oIOResult=0) or (I>3);
  If oIOResult>0 then ShowMsg(ecSysFileIsWriteDeny,pFile);
  If oIOResult>0 then WriteToLogFile('TXTERROR.LOG','Open_Write Error '+'|'+IntToStr(oIOResult)+'|'+pFile);
  oFileName:=pFile;
end;

destructor  TTxtFile.Destroy;
begin
  CloseFile (oTxFile);
  inherited Destroy;
end;

procedure   TTxtFile.WriteStringList (pStringList :TStrings);
var I:longint;
begin
  If oIOResult=0 then begin
    oIOResult:=0;
    For I:=1 to pStringList.Count do begin
      {$I+}WriteLn (oTxFile,pStringList.Strings[I-1]);{$I-}
      If oIOResult=0 then oIOResult := IOResult;
    end;
    If oIOResult>0 then WriteToLogFile('TXTERROR.LOG','Writeln Error'+'|'+IntToStr(oIOResult)+'|'+oFileName);
  end;
end;


end.
